filename="$1"

cat <<EOF
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-type" content="text/html;charset=UTF-8" />
</head>
<body>
EOF
$ZOZ= "n"
while IFS= read -r line
do

    if [[ "$line" =~ ^\#\# ]]; then

        modified_line="<h2>${line:2}</h2>"
    elif [[ "$line" =~ ^\# ]]; then

        modified_line="<h1>${line:1}</h1>"
    elif [ -z "$line" ];then
	modified_line="<p>"
    elif [[ "$line" =~ ^( - ) || "$(ZOZ)"="y"]];then
	modified_line="<li>${line:1}</li>"


    elif [[ "$line" =~ ^( - ) || ZOZ="n"]];then
	echo "<ol>"
	ZOZ="y"


    else

        modified_line="$line"
    fi


	echo "$modified_line" |
	sed 's/__\([^__]*\)__/\<strong\>\1\<\/strong\>/g' |
	sed 's/_\([^_]*\)_/\<em\>\1\<\/em\>/g' |
	sed 's@https://\([^ ]*\)@a href="https://\1">https://\1</a>@g' |
	sed 's@- @@'


done < "$filename"



cat <<EOF
</body>
</html>
EOF

