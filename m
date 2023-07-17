Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1878D756BF6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjGQSZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjGQSYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:24:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3111738;
        Mon, 17 Jul 2023 11:24:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49C416122A;
        Mon, 17 Jul 2023 18:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32484C433CD;
        Mon, 17 Jul 2023 18:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618220;
        bh=8PFWR4Yd5sy950ZwktRvW5giBsaeVnJYZDf2y1in5HQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f8QUHU4GNIoJGdZF0/j7rJlw32by99WA1mjuHcek4aSeWBgiTzRaaVdnEwqyktgpg
         meWLFStxtXhakweqdoAyIqgCWkRTO6ieLhE5zWphMDDU+xcMLZSEll0TQQawLuhD3B
         fj6lHnpnrIgRqEP9Y0uHmEKmjTGjHsvMwWTU5gTfOBBSRlgCt5DxNq0RcJzyc2EPj3
         MptVpU5BX/QZejWQeDKK41ldHs6+q7g0u60fKkCHO86Nth7SA1IdFTR+LhN3rroUPI
         w8Y01yCSIy8bz89OrK8P0vuqr6hd8/bo4F+yMPJK8N+y2DtVLR9dV4l4h2cUCcWaDG
         BVipqzXUpxqJg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 411B0CE0AD2; Mon, 17 Jul 2023 11:23:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH rcu 16/18] torture: Switch qemu from -nographic to -display none
Date:   Mon, 17 Jul 2023 11:23:35 -0700
Message-Id: <20230717182337.1098991-16-paulmck@kernel.org>
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

This commit switches the qemu argument "-nographic" to "-display none",
aligning with the nolibc tests.

Cc: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 3bc0140438ef..b33cd8753689 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -9,9 +9,9 @@
 #
 # Usage: kvm-test-1-run.sh config resdir seconds qemu-args boot_args_in
 #
-# qemu-args defaults to "-enable-kvm -nographic -no-reboot", along with
-#			arguments specifying the number of CPUs and
-#			other options generated from the underlying
+# qemu-args defaults to "-enable-kvm -display none -no-reboot", along
+#			with arguments specifying the number of CPUs
+#			and other options generated from the underlying
 #			CPU architecture.
 # boot_args_in defaults to value returned by the per_version_boot_params
 #			shell function.
@@ -140,7 +140,7 @@ then
 fi
 
 # Generate -smp qemu argument.
-qemu_args="-enable-kvm -nographic -no-reboot $qemu_args"
+qemu_args="-enable-kvm -display none -no-reboot $qemu_args"
 cpu_count=`configNR_CPUS.sh $resdir/ConfigFragment`
 cpu_count=`configfrag_boot_cpus "$boot_args_in" "$config_template" "$cpu_count"`
 if test "$cpu_count" -gt "$TORTURE_ALLOTED_CPUS"
-- 
2.40.1

