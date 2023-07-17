Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C0B756BEF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjGQSYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjGQSYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:24:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503EB10E3;
        Mon, 17 Jul 2023 11:23:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C118261204;
        Mon, 17 Jul 2023 18:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D4EC433AD;
        Mon, 17 Jul 2023 18:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618219;
        bh=qHIeKT9jqHAeemj/f9dbUhQ4zOrTZrB+KZ1K94En2Mg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QMY4aBZrrRUCDkp25yFUbN9ecihF3hhj4k+G0SJGhTHQHE4JvA09P2JZdqxMZA3GQ
         zjwdM6yUnHtC8CVn9kCPSP6o4mHgy9sB9NfpsudbazKI+B2DKUVluim6+I13etMeM6
         X+O2Qayk/i2EKSKGdBZZ7gqv2POsTGgDJQG3kSK6L3sTIgiwXzo3qk8DtTvWNZLWuX
         SextQshJLHRa6AstlrXJkDREuVKVtml5Y30LqoZTp7F+3J5JYJJKK4nuGAbkwOYVS5
         ZWNFzN60hA16/+b21XbgYq4kcshq7n/Q9P/700BYfjsuD3Dn+8TF5opotQv3vCL4Da
         dd9WDQmaeREZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2DF39CE0930; Mon, 17 Jul 2023 11:23:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH rcu 07/18] torture: Add RCU Tasks individual-flavor build tests
Date:   Mon, 17 Jul 2023 11:23:26 -0700
Message-Id: <20230717182337.1098991-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d03c7482-acde-4f33-a7fb-fa7c58fdc9a2@paulmck-laptop>
References: <d03c7482-acde-4f33-a7fb-fa7c58fdc9a2@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds build tests of the individual RCU Tasks flavors in
order to detect inadvertent dependencies among the flavors.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/torture.sh       | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index c3190ca9c96f..dd3bfadb0639 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -55,6 +55,7 @@ do_kasan=yes
 do_kcsan=no
 do_clocksourcewd=yes
 do_rt=yes
+do_rcutasksflavors=yes
 
 # doyesno - Helper function for yes/no arguments
 function doyesno () {
@@ -81,6 +82,7 @@ usage () {
 	echo "       --do-locktorture / --do-no-locktorture / --no-locktorture"
 	echo "       --do-none"
 	echo "       --do-rcuscale / --do-no-rcuscale / --no-rcuscale"
+	echo "       --do-rcutasksflavors / --do-no-rcutasksflavors / --no-rcutasksflavors"
 	echo "       --do-rcutorture / --do-no-rcutorture / --no-rcutorture"
 	echo "       --do-refscale / --do-no-refscale / --no-refscale"
 	echo "       --do-rt / --do-no-rt / --no-rt"
@@ -115,6 +117,7 @@ do
 		;;
 	--do-all|--doall)
 		do_allmodconfig=yes
+		do_rcutasksflavor=yes
 		do_rcutorture=yes
 		do_locktorture=yes
 		do_scftorture=yes
@@ -146,6 +149,7 @@ do
 		;;
 	--do-none|--donone)
 		do_allmodconfig=no
+		do_rcutasksflavors=no
 		do_rcutorture=no
 		do_locktorture=no
 		do_scftorture=no
@@ -160,6 +164,9 @@ do
 	--do-rcuscale|--do-no-rcuscale|--no-rcuscale)
 		do_rcuscale=`doyesno "$1" --do-rcuscale`
 		;;
+	--do-rcutasksflavors|--do-no-rcutasksflavors|--no-rcutasksflavors)
+		do_rcutasksflavors=`doyesno "$1" --do-rcutasksflavors`
+		;;
 	--do-rcutorture|--do-no-rcutorture|--no-rcutorture)
 		do_rcutorture=`doyesno "$1" --do-rcutorture`
 		;;
@@ -361,6 +368,40 @@ then
 	fi
 fi
 
+# Test building RCU Tasks flavors in isolation, both SMP and !SMP
+if test "$do_rcutasksflavors" = "yes"
+then
+	echo " --- rcutasksflavors:" Start `date` | tee -a $T/log
+	rtfdir="tools/testing/selftests/rcutorture/res/$ds/results-rcutasksflavors"
+	mkdir -p "$rtfdir"
+	cat > $T/rcutasksflavors << __EOF__
+#CHECK#CONFIG_TASKS_RCU=n
+#CHECK#CONFIG_TASKS_RUDE_RCU=n
+#CHECK#CONFIG_TASKS_TRACE_RCU=n
+__EOF__
+	for flavor in CONFIG_TASKS_RCU CONFIG_TASKS_RUDE_RCU CONFIG_TASKS_TRACE_RCU
+	do
+		forceflavor="`echo $flavor | sed -e 's/^CONFIG/CONFIG_FORCE/'`"
+		deselectedflavors="`grep -v $flavor $T/rcutasksflavors | tr '\012' ' ' | tr -s ' ' | sed -e 's/ *$//'`"
+		echo " --- Running RCU Tasks Trace flavor $flavor `date`" >> $rtfdir/log
+		tools/testing/selftests/rcutorture/bin/kvm.sh --datestamp "$ds/results-rcutasksflavors/$flavor" --buildonly --configs "TINY01 TREE04" --kconfig "CONFIG_RCU_EXPERT=y CONFIG_RCU_SCALE_TEST=y $forceflavor=y $deselectedflavors" --trust-make > $T/$flavor.out 2>&1
+		retcode=$?
+		if test "$retcode" -ne 0
+		then
+			break
+		fi
+	done
+	if test "$retcode" -eq 0
+	then
+		echo "rcutasksflavors($retcode)" $rtfdir >> $T/successes
+		echo Success >> $rtfdir/log
+	else
+		echo "rcutasksflavors($retcode)" $rtfdir >> $T/failures
+		echo " --- rcutasksflavors Test summary:" >> $rtfdir/log
+		echo " --- Summary: Exit code $retcode from $flavor, see Make.out" >> $rtfdir/log
+	fi
+fi
+
 # --torture rcu
 if test "$do_rcutorture" = "yes"
 then
-- 
2.40.1

