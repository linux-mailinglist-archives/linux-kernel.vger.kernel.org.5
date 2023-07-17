Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD867756BEB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjGQSYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjGQSYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:24:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4B310E0;
        Mon, 17 Jul 2023 11:23:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAD8D61203;
        Mon, 17 Jul 2023 18:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DDCC433B6;
        Mon, 17 Jul 2023 18:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618220;
        bh=lQ8xvrzS/midsPZxoW+nooVrgi5HaHXJ95sEYKvfCKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NDkdJ5GMLJqXwwFMYSfympe1ELYEOFjm3y8LvA6LtiZVR3OFUEYm7/Mo6hJM+/WoC
         H+u1g2uAVqfCg6b5/RxLLQEk7quUcz7T2CpTPn7czelV2c9Of3dwh0HXnWEaiE5BzT
         cakrKi4TMEeCPRVH8UE2xuyUEi6DNrjhorSxpOfwLAok8u3LMad767+lbHl2keI0YH
         4xTx+E5ZHkHTjLoyfvIUTq37lG6LArHAt69/aWMX91AAStna4D3qjADFnFfM/25Thv
         XZaK4LnqkaKfc5SwyBaOBXmc3mt1qZIthWuRvym2C6X5mUnJtMaKBKK5reGOXxTir6
         643kq4+I31hcw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 34522CE09E0; Mon, 17 Jul 2023 11:23:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 10/18] torture: Place --bootargs parameters at end of -append list
Date:   Mon, 17 Jul 2023 11:23:29 -0700
Message-Id: <20230717182337.1098991-10-paulmck@kernel.org>
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

Currently, the kernel boot parameters specified by the kvm.sh --bootargs
parameter are placed near the beginning of the -append list that is
passed to qemu.  This means that in the not-uncommon case of a kernel
boot parameter where the last argument wins, the --bootargs list overrides
neither the list in the .boot file nor the additional parameters supplied
by the rcutorture scripting.

This commit therefore places the kernel boot parameters specified by
the kvm.sh --bootargs parameter at the end of qemu's -append list.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/functions.sh          | 2 +-
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh     | 2 +-
 .../selftests/rcutorture/configs/lock/ver_functions.sh       | 5 +++--
 .../selftests/rcutorture/configs/rcu/ver_functions.sh        | 5 +++--
 .../selftests/rcutorture/configs/rcuscale/ver_functions.sh   | 5 +++--
 .../selftests/rcutorture/configs/refscale/ver_functions.sh   | 5 +++--
 .../selftests/rcutorture/configs/scf/ver_functions.sh        | 5 +++--
 7 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index 48b9147e8c91..b8e2ea23cb3f 100644
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -45,7 +45,7 @@ checkarg () {
 configfrag_boot_params () {
 	if test -r "$2.boot"
 	then
-		echo $1 `grep -v '^#' "$2.boot" | tr '\012' ' '`
+		echo `grep -v '^#' "$2.boot" | tr '\012' ' '` $1
 	else
 		echo $1
 	fi
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index b9912de9d71e..1e7566997e51 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -162,7 +162,7 @@ boot_args="`configfrag_boot_params "$boot_args_in" "$config_template"`"
 boot_args="`per_version_boot_params "$boot_args" $resdir/.config $seconds`"
 if test -n "$TORTURE_BOOT_GDB_ARG"
 then
-	boot_args="$boot_args $TORTURE_BOOT_GDB_ARG"
+	boot_args="$TORTURE_BOOT_GDB_ARG $boot_args"
 fi
 
 # Give bare-metal advice
diff --git a/tools/testing/selftests/rcutorture/configs/lock/ver_functions.sh b/tools/testing/selftests/rcutorture/configs/lock/ver_functions.sh
index d3e4b2971f92..e7bb32709d78 100644
--- a/tools/testing/selftests/rcutorture/configs/lock/ver_functions.sh
+++ b/tools/testing/selftests/rcutorture/configs/lock/ver_functions.sh
@@ -22,8 +22,9 @@ locktorture_param_onoff () {
 #
 # Adds per-version torture-module parameters to kernels supporting them.
 per_version_boot_params () {
-	echo $1 `locktorture_param_onoff "$1" "$2"` \
+	echo	`locktorture_param_onoff "$1" "$2"` \
 		locktorture.stat_interval=15 \
 		locktorture.shutdown_secs=$3 \
-		locktorture.verbose=1
+		locktorture.verbose=1 \
+		$1
 }
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/ver_functions.sh b/tools/testing/selftests/rcutorture/configs/rcu/ver_functions.sh
index e2bc99c785e7..c044df386876 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/ver_functions.sh
+++ b/tools/testing/selftests/rcutorture/configs/rcu/ver_functions.sh
@@ -46,10 +46,11 @@ rcutorture_param_stat_interval () {
 #
 # Adds per-version torture-module parameters to kernels supporting them.
 per_version_boot_params () {
-	echo $1 `rcutorture_param_onoff "$1" "$2"` \
+	echo	`rcutorture_param_onoff "$1" "$2"` \
 		`rcutorture_param_n_barrier_cbs "$1"` \
 		`rcutorture_param_stat_interval "$1"` \
 		rcutorture.shutdown_secs=$3 \
 		rcutorture.test_no_idle_hz=1 \
-		rcutorture.verbose=1
+		rcutorture.verbose=1 \
+		$1
 }
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/ver_functions.sh b/tools/testing/selftests/rcutorture/configs/rcuscale/ver_functions.sh
index ffbe15109f0d..28070b43f017 100644
--- a/tools/testing/selftests/rcutorture/configs/rcuscale/ver_functions.sh
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/ver_functions.sh
@@ -11,6 +11,7 @@
 #
 # Adds per-version torture-module parameters to kernels supporting them.
 per_version_boot_params () {
-	echo $1 rcuscale.shutdown=1 \
-		rcuscale.verbose=0
+	echo	rcuscale.shutdown=1 \
+		rcuscale.verbose=0 \
+		$1
 }
diff --git a/tools/testing/selftests/rcutorture/configs/refscale/ver_functions.sh b/tools/testing/selftests/rcutorture/configs/refscale/ver_functions.sh
index f81fa2c541a6..748465627601 100644
--- a/tools/testing/selftests/rcutorture/configs/refscale/ver_functions.sh
+++ b/tools/testing/selftests/rcutorture/configs/refscale/ver_functions.sh
@@ -11,6 +11,7 @@
 #
 # Adds per-version torture-module parameters to kernels supporting them.
 per_version_boot_params () {
-	echo $1 refscale.shutdown=1 \
-		refscale.verbose=0
+	echo	refscale.shutdown=1 \
+		refscale.verbose=0 \
+		$1
 }
diff --git a/tools/testing/selftests/rcutorture/configs/scf/ver_functions.sh b/tools/testing/selftests/rcutorture/configs/scf/ver_functions.sh
index 2d949e58f5a5..7637f68ef0ce 100644
--- a/tools/testing/selftests/rcutorture/configs/scf/ver_functions.sh
+++ b/tools/testing/selftests/rcutorture/configs/scf/ver_functions.sh
@@ -22,8 +22,9 @@ scftorture_param_onoff () {
 #
 # Adds per-version torture-module parameters to kernels supporting them.
 per_version_boot_params () {
-	echo $1 `scftorture_param_onoff "$1" "$2"` \
+	echo	`scftorture_param_onoff "$1" "$2"` \
 		scftorture.stat_interval=15 \
 		scftorture.shutdown_secs=$3 \
-		scftorture.verbose=1
+		scftorture.verbose=1 \
+		$1
 }
-- 
2.40.1

