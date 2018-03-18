#!/bin/sh

echo 'package interp'
echo
echo '// Do not edit! File generated by ../test/gen_example.sh'
echo
for file in *.gi
do
	awk '
	$0 == "// Output:" { done = 1 }
	{ if (done) out = out "\n" $0; else src = src "\n" $0 }
	END {
		print "func Example_'${file%.*}'() {"
		print "src := `" src "`"
		printf "NewInterpreter(InterpOpt{}).Eval(src)"
		print out
		print "}"
	}
	' $file

	echo
done
