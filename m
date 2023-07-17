Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B8F756BE4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjGQSYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjGQSYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:24:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61356B1;
        Mon, 17 Jul 2023 11:23:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6435611F4;
        Mon, 17 Jul 2023 18:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF43C4339A;
        Mon, 17 Jul 2023 18:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618219;
        bh=Y4qEan4Bht4WZhImYKyYPdEi4fHI0gcDqvRNnRmfnWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s6HELBkflFiaMJQlucVyqGiw3EuBWOlewxbh5yx95kHBEpenu48/nZS7/3gjzGeGg
         DCbos1fc5VQdHqLOs0uOPKbfsVH7Sfc4j5ee7+cbqiJbua/5Py7u5tQT2WhrOzTuBv
         Bc2A2L+KoLBfbH9Pg51n0OxMMOla5INiT3+iBMcHbCqcu3DyhkE1NwnWOA8Je42d+5
         FA6k3ZvUWY1wkVBiM8Q07agtBeS+S5xHMqzYo4rs5vfLmNixFI2MxFmTKbED+MWelV
         zapSQk4H2MZo4MKL63BwhnBj5zXdW7eSCP3RYdSrwRTC68toTSt1rWGObBtHowFARM
         yW5U+LoskKuMw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2BCDECE092F; Mon, 17 Jul 2023 11:23:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 06/18] torture: Make kvm-recheck.sh report .config errors
Date:   Mon, 17 Jul 2023 11:23:25 -0700
Message-Id: <20230717182337.1098991-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d03c7482-acde-4f33-a7fb-fa7c58fdc9a2@paulmck-laptop>
References: <d03c7482-acde-4f33-a7fb-fa7c58fdc9a2@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, kvm-recheck.sh will print out any .config errors with messages
of the form:

:CONFIG_TASKS_TRACE_RCU=y: improperly set

However, if these are the only errors, the resulting exit code will
declare the run successful.  This commit therefore causes kvm-recheck.sh
to record .config errors in the results directory in a file named
ConfigFragment.diags and also returns a non-zero error code in that case.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/kvm-recheck.sh   | 37 +++++++++++++++----
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
index 1df7e695edf7..97bdacc3fc55 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
@@ -16,6 +16,8 @@
 T=/tmp/kvm-recheck.sh.$$
 trap 'rm -f $T' 0 2
 
+configerrors=0
+
 PATH=`pwd`/tools/testing/selftests/rcutorture/bin:$PATH; export PATH
 . functions.sh
 for rd in "$@"
@@ -32,7 +34,7 @@ do
 		fi
 		TORTURE_SUITE="`cat $i/../torture_suite`" ; export TORTURE_SUITE
 		configfile=`echo $i | sed -e 's,^.*/,,'`
-		rm -f $i/console.log.*.diags
+		rm -f $i/console.log.*.diags $i/ConfigFragment.diags
 		case "${TORTURE_SUITE}" in
 		X*)
 			;;
@@ -49,8 +51,14 @@ do
 			then
 				echo QEMU killed
 			fi
-			configcheck.sh $i/.config $i/ConfigFragment > $T 2>&1
-			cat $T
+			configcheck.sh $i/.config $i/ConfigFragment > $i/ConfigFragment.diags 2>&1
+			if test -s $i/ConfigFragment.diags
+			then
+				cat $i/ConfigFragment.diags
+				configerrors=$((configerrors+1))
+			else
+				rm $i/ConfigFragment.diags
+			fi
 			if test -r $i/Make.oldconfig.err
 			then
 				cat $i/Make.oldconfig.err
@@ -65,7 +73,14 @@ do
 			if test -f "$i/buildonly"
 			then
 				echo Build-only run, no boot/test
-				configcheck.sh $i/.config $i/ConfigFragment
+				configcheck.sh $i/.config $i/ConfigFragment > $i/ConfigFragment.diags 2>&1
+				if test -s $i/ConfigFragment.diags
+				then
+					cat $i/ConfigFragment.diags
+					configerrors=$((configerrors+1))
+				else
+					rm $i/ConfigFragment.diags
+				fi
 				parse-build.sh $i/Make.out $configfile
 			elif test -f "$i/qemu-cmd"
 			then
@@ -79,10 +94,10 @@ do
 	done
 	if test -f "$rd/kcsan.sum"
 	then
-		if ! test -f $T
+		if ! test -f $i/ConfigFragment.diags
 		then
 			:
-		elif grep -q CONFIG_KCSAN=y $T
+		elif grep -q CONFIG_KCSAN=y $i/ConfigFragment.diags
 		then
 			echo "Compiler or architecture does not support KCSAN!"
 			echo Did you forget to switch your compiler with '--kmake-arg CC=<cc-that-supports-kcsan>'?
@@ -94,17 +109,23 @@ do
 		fi
 	fi
 done
+
+if test "$configerrors" -gt 0
+then
+	echo $configerrors runs with .config errors.
+	ret=1
+fi
 EDITOR=echo kvm-find-errors.sh "${@: -1}" > $T 2>&1
 builderrors="`tr ' ' '\012' < $T | grep -c '/Make.out.diags'`"
 if test "$builderrors" -gt 0
 then
 	echo $builderrors runs with build errors.
-	ret=1
+	ret=2
 fi
 runerrors="`tr ' ' '\012' < $T | grep -c '/console.log.diags'`"
 if test "$runerrors" -gt 0
 then
 	echo $runerrors runs with runtime errors.
-	ret=2
+	ret=3
 fi
 exit $ret
-- 
2.40.1

