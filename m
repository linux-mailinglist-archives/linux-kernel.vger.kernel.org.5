Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BAA7BFA98
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjJJMBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjJJMBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:01:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7800125;
        Tue, 10 Oct 2023 05:00:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FCBC433CA;
        Tue, 10 Oct 2023 12:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696939227;
        bh=ksjecpVsxhnG07ngqspAmw6yvV2qCy9sCs74cU/Rdec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h7L+9Olzu0k0FZ7CM6Jy88fRCY/dMxW9AoTJ6lOe+YoyqewT6IR3tvLW+iV8XC9kB
         n8N7jztdBh+71s/fK4Y06fc3tl9dFtenwX5FgspmGr93MA8VSzR2p5aimRk3gbUfry
         jHynYBGBqfreKcu+i9nmnGp8vFPNz/hbKpOLoGS+50IS7XUuZQPNpKoo2dKAsG6Y0Q
         wnBmqbYPWv63AtaPRjmHctqZYkombm2vSW3kq5y16UorCL7XuIJDvpzNyrSfQPFZ16
         dtRqnBb2fbL6fofjKPryP2437WkZIuUNFL0vO2vu8XT9MeIqIx3Jzt3TH81dvwW2xA
         Zf8t3LeL9LJ7g==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 19/23] torture: Add kvm.sh --debug-info argument
Date:   Tue, 10 Oct 2023 13:59:17 +0200
Message-Id: <20231010115921.988766-20-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010115921.988766-1-frederic@kernel.org>
References: <20231010115921.988766-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a --debug-info argument to kvm.sh in order to ease
interpretation of addresses printed on the console and the like.
This argument also disables KASLR.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index b0f36a638a69..7af73ddc148d 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -49,6 +49,7 @@ TORTURE_SHUTDOWN_GRACE=180
 TORTURE_SUITE=rcu
 TORTURE_MOD=rcutorture
 TORTURE_TRUST_MAKE=""
+debuginfo="CONFIG_DEBUG_INFO_NONE=n CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y"
 resdir=""
 configs=""
 cpus=0
@@ -68,6 +69,7 @@ usage () {
 	echo "       --cpus N"
 	echo "       --datestamp string"
 	echo "       --defconfig string"
+	echo "       --debug-info"
 	echo "       --dryrun batches|scenarios|sched|script"
 	echo "       --duration minutes | <seconds>s | <hours>h | <days>d"
 	echo "       --gdb"
@@ -135,6 +137,15 @@ do
 		ds=$2
 		shift
 		;;
+	--debug-info|--debuginfo)
+		if test -z "$TORTURE_KCONFIG_KCSAN_ARG" && test -z "$TORTURE_BOOT_GDB_ARG"
+		then
+			TORTURE_KCONFIG_KCSAN_ARG="$debuginfo"; export TORTURE_KCONFIG_KCSAN_ARG
+			TORTURE_BOOT_GDB_ARG="nokaslr"; export TORTURE_BOOT_GDB_ARG
+		else
+			echo "Ignored redundant --debug-info (implied by --kcsan &c)"
+		fi
+		;;
 	--defconfig)
 		checkarg --defconfig "defconfigtype" "$#" "$2" '^[^/][^/]*$' '^--'
 		TORTURE_DEFCONFIG=$2
@@ -163,7 +174,7 @@ do
 		shift
 		;;
 	--gdb)
-		TORTURE_KCONFIG_GDB_ARG="CONFIG_DEBUG_INFO_NONE=n CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y"; export TORTURE_KCONFIG_GDB_ARG
+		TORTURE_KCONFIG_GDB_ARG="$debuginfo"; export TORTURE_KCONFIG_GDB_ARG
 		TORTURE_BOOT_GDB_ARG="nokaslr"; export TORTURE_BOOT_GDB_ARG
 		TORTURE_QEMU_GDB_ARG="-s -S"; export TORTURE_QEMU_GDB_ARG
 		;;
@@ -179,7 +190,7 @@ do
 		shift
 		;;
 	--kasan)
-		TORTURE_KCONFIG_KASAN_ARG="CONFIG_DEBUG_INFO_NONE=n CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y CONFIG_KASAN=y"; export TORTURE_KCONFIG_KASAN_ARG
+		TORTURE_KCONFIG_KASAN_ARG="$debuginfo CONFIG_KASAN=y"; export TORTURE_KCONFIG_KASAN_ARG
 		if test -n "$torture_qemu_mem_default"
 		then
 			TORTURE_QEMU_MEM=2G
@@ -191,7 +202,7 @@ do
 		shift
 		;;
 	--kcsan)
-		TORTURE_KCONFIG_KCSAN_ARG="CONFIG_DEBUG_INFO_NONE=n CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y CONFIG_KCSAN=y CONFIG_KCSAN_STRICT=y CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000 CONFIG_KCSAN_VERBOSE=y CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y"; export TORTURE_KCONFIG_KCSAN_ARG
+		TORTURE_KCONFIG_KCSAN_ARG="$debuginfo CONFIG_KCSAN=y CONFIG_KCSAN_STRICT=y CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000 CONFIG_KCSAN_VERBOSE=y CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y"; export TORTURE_KCONFIG_KCSAN_ARG
 		;;
 	--kmake-arg|--kmake-args)
 		checkarg --kmake-arg "(kernel make arguments)" $# "$2" '.*' '^error$'
-- 
2.34.1

