inp="$1"
out="$1.out"
legende="$2"


error() {
        echo "$1"
        exit 1
}


test $# -eq 2 || error "Aufruf: $0 <gruppen-datei> <legenden-datei>"


a="$(cat $inp)"
b="echo $a"
eval "$b" | tr " " "\n" | tr "-" ";" > $out
while read line; do
  s=$(echo $line | cut -d " " -f1)
  r=$(echo $line | cut -d " " -f2-)
  sed -i "s/$s/$r/" $out
done < "$legende"
cat $out | column  -ts";" | sort -k4 | nl
