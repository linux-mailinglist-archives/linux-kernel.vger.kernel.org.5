Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58068756BE3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjGQSYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjGQSX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:23:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31B312A;
        Mon, 17 Jul 2023 11:23:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 458B5611F3;
        Mon, 17 Jul 2023 18:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07F6C433D9;
        Mon, 17 Jul 2023 18:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618219;
        bh=5IHxtaUx9BeFSGJ8QZLEShLeDTCl6tPy3XAgHbYQ4tU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e9eCU41IK9CYprQQWUX4KmxgxlRaNPKxyRWZtTUMpN2ymUWqinJFnJ2/vS+1RftKA
         oDMrckJLqf2bYAFQNnGhtFYXg74XtacFmdrmq076irpeGPD33lp++Jsq5v7bFJNxag
         d38s9f3iRam32PNTA2ZI/UGJN77Ks+yeRQ84Cn7DdjQ5ACU1jm1llZRrJpLQSVAIaA
         kSF8evLs+axwSuHr7D3MWqdmtdy/fqMxxObrfY9AnhkvkLejHZ2uKvyGDWALPBX8Ob
         zL4TGee8JOilawnUZSh/m6YykigYV/yhasNYoyDsnu/iazHXMKZPS2chSUln10kePb
         oC6aHMzNygH6w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 29BC2CE0902; Mon, 17 Jul 2023 11:23:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 05/18] torture: Allow #CHECK# in --kconfig argument to kvm.sh
Date:   Mon, 17 Jul 2023 11:23:24 -0700
Message-Id: <20230717182337.1098991-5-paulmck@kernel.org>
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

Testing building of a given RCU Tasks flavor with the other two
flavors disabled requires checking that the other two flavors are in
fact disabled.  This commit therefore modifies the scripting to permit
things like "#CHECK#CONFIG_TASKS_TRACE_RCU=n" to be passed into the
kvm.sh script's --kconfig parameter.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/configcheck.sh   | 61 ++++++++++---------
 .../rcutorture/bin/kvm-test-1-run.sh          |  1 -
 tools/testing/selftests/rcutorture/bin/kvm.sh |  2 +-
 3 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/configcheck.sh b/tools/testing/selftests/rcutorture/bin/configcheck.sh
index b92dfeb7fbbf..99162d18bad3 100755
--- a/tools/testing/selftests/rcutorture/bin/configcheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/configcheck.sh
@@ -3,6 +3,8 @@
 #
 # Usage: configcheck.sh .config .config-template
 #
+# Non-empty output if errors detected.
+#
 # Copyright (C) IBM Corporation, 2011
 #
 # Authors: Paul E. McKenney <paulmck@linux.ibm.com>
@@ -10,32 +12,35 @@
 T="`mktemp -d ${TMPDIR-/tmp}/configcheck.sh.XXXXXX`"
 trap 'rm -rf $T' 0
 
-sed -e 's/"//g' < $1 > $T/.config
+# function test_kconfig_enabled ( Kconfig-var=val )
+function test_kconfig_enabled () {
+	if ! grep -q "^$1$" $T/.config
+	then
+		echo :$1: improperly set
+		return 1
+	fi
+	return 0
+}
 
-sed -e 's/"//g' -e 's/\(.*\)=n/# \1 is not set/' -e 's/^#CHECK#//' < $2 |
-awk	'
-{
-		print "if grep -q \"" $0 "\" < '"$T/.config"'";
-		print "then";
-		print "\t:";
-		print "else";
-		if ($1 == "#") {
-			print "\tif grep -q \"" $2 "\" < '"$T/.config"'";
-			print "\tthen";
-			print "\t\tif test \"$firsttime\" = \"\""
-			print "\t\tthen"
-			print "\t\t\tfirsttime=1"
-			print "\t\tfi"
-			print "\t\techo \":" $2 ": improperly set\"";
-			print "\telse";
-			print "\t\t:";
-			print "\tfi";
-		} else {
-			print "\tif test \"$firsttime\" = \"\""
-			print "\tthen"
-			print "\t\tfirsttime=1"
-			print "\tfi"
-			print "\techo \":" $0 ": improperly set\"";
-		}
-		print "fi";
-	}' | sh
+# function test_kconfig_disabled ( Kconfig-var )
+function test_kconfig_disabled () {
+	if grep -q "^$1=n$" $T/.config
+	then
+		return 0
+	fi
+	if grep -q "^$1=" $T/.config
+	then
+		echo :$1=n: improperly set
+		return 1
+	fi
+	return 0
+}
+
+sed -e 's/"//g' < $1 > $T/.config
+sed -e 's/^#CHECK#//' < $2 > $T/ConfigFragment
+grep '^CONFIG_.*=n$' $T/ConfigFragment |
+	sed -e 's/^/test_kconfig_disabled /' -e 's/=n$//' > $T/kconfig-n.sh
+. $T/kconfig-n.sh
+grep -v '^CONFIG_.*=n$' $T/ConfigFragment | grep '^CONFIG_' |
+	sed -e 's/^/test_kconfig_enabled /' > $T/kconfig-not-n.sh
+. $T/kconfig-not-n.sh
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index d2a3710a5f2a..b9912de9d71e 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -57,7 +57,6 @@ config_override_param () {
 		cat $T/Kconfig_args >> $resdir/ConfigFragment.input
 		config_override.sh $T/$2 $T/Kconfig_args > $T/$2.tmp
 		mv $T/$2.tmp $T/$2
-		# Note that "#CHECK#" is not permitted on commandline.
 	fi
 }
 
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index d3cdc2d33d4b..b0f36a638a69 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -186,7 +186,7 @@ do
 		fi
 		;;
 	--kconfig|--kconfigs)
-		checkarg --kconfig "(Kconfig options)" $# "$2" '^CONFIG_[A-Z0-9_]\+=\([ynm]\|[0-9]\+\|"[^"]*"\)\( CONFIG_[A-Z0-9_]\+=\([ynm]\|[0-9]\+\|"[^"]*"\)\)*$' '^error$'
+		checkarg --kconfig "(Kconfig options)" $# "$2" '^\(#CHECK#\)\?CONFIG_[A-Z0-9_]\+=\([ynm]\|[0-9]\+\|"[^"]*"\)\( \(#CHECK#\)\?CONFIG_[A-Z0-9_]\+=\([ynm]\|[0-9]\+\|"[^"]*"\)\)*$' '^error$'
 		TORTURE_KCONFIG_ARG="`echo "$TORTURE_KCONFIG_ARG $2" | sed -e 's/^ *//' -e 's/ *$//'`"
 		shift
 		;;
-- 
2.40.1

