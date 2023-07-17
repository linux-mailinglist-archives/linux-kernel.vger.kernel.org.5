Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A0E756B41
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjGQSF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjGQSFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:05:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0377198C;
        Mon, 17 Jul 2023 11:04:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E217611C6;
        Mon, 17 Jul 2023 18:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92647C433CA;
        Mon, 17 Jul 2023 18:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689617095;
        bh=4Rvqpj2uxc7m3FkdSvfRYtUA4WLN8IJWZxpll6G1Oo8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OFdPUnn6Y8cXhOeM3B0NMhTg21LZlEPm9YkU9MIchyEwcc0Q90EQBqcl5ggtXzBNk
         YlSdNx8MH5rIUP2KNizz5raY4yY7TwoPq+Iv2SwIUcg20Ts25G79Dhpb5FcEW4TNDi
         mWapt47SD2fs/YtoSlZ9vmt0ILEnRbPvQ3Iy1/y55QWveTjOIhGY2hQdsbKDCMnvi+
         mG1Rh8Jx5hW5wOPhKmxCKW+3OtfK5lc6l3cazzHtPpR6bNoe21ATS5L6XUOCfagRZA
         pmg3Xt5Yqjgo0miag0aSO/RANllIbxhHWQgkWI5+fdYTTcpJA5lYiypEphFVstWYPc
         et3UJ2j/F0saA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5C269CE0836; Mon, 17 Jul 2023 11:04:55 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH rcu 4/5] rcu-tasks: Cancel callback laziness if too many callbacks
Date:   Mon, 17 Jul 2023 11:04:53 -0700
Message-Id: <20230717180454.1097714-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <a6fff63c-5930-4918-82a3-a9301309d88d@paulmck-laptop>
References: <a6fff63c-5930-4918-82a3-a9301309d88d@paulmck-laptop>
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

The various RCU Tasks flavors now do lazy grace periods when there are
only asynchronous grace period requests.  By default, the system will let
250 milliseconds elapse after the first call_rcu_tasks*() callbacki is
queued before starting a grace period.  In contrast, synchronous grace
period requests such as synchronize_rcu_tasks*() will start a grace
period immediately.

However, invoking one of the call_rcu_tasks*() functions in a too-tight
loop can result in a callback flood, which in turn can exhaust memory
if grace periods are delayed for too long.

This commit therefore sets a limit so that the grace-period kthread
will be awakened when any CPU's callback list expands to contain
rcupdate.rcu_task_lazy_lim callbacks elements (defaulting to 32, set to -1
to disable), the grace-period kthread will be awakened, thus cancelling
any ongoing laziness and getting out in front of the potential callback
flood.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 kernel/rcu/tasks.h                              | 7 +++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a0f427e1a562..44705a3618b9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5264,6 +5264,13 @@
 			number avoids disturbing real-time workloads,
 			but lengthens grace periods.
 
+	rcupdate.rcu_task_lazy_lim= [KNL]
+			Number of callbacks on a given CPU that will
+			cancel laziness on that CPU.  Use -1 to disable
+			cancellation of laziness, but be advised that
+			doing so increases the danger of OOM due to
+			callback flooding.
+
 	rcupdate.rcu_task_stall_info= [KNL]
 			Set initial timeout in jiffies for RCU task stall
 			informational messages, which give some indication
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 28e986627e3f..291d536b1789 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -176,6 +176,8 @@ static int rcu_task_contend_lim __read_mostly = 100;
 module_param(rcu_task_contend_lim, int, 0444);
 static int rcu_task_collapse_lim __read_mostly = 10;
 module_param(rcu_task_collapse_lim, int, 0444);
+static int rcu_task_lazy_lim __read_mostly = 32;
+module_param(rcu_task_lazy_lim, int, 0444);
 
 /* RCU tasks grace-period state for debugging. */
 #define RTGS_INIT		 0
@@ -354,8 +356,9 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 		cblist_init_generic(rtp);
 		raw_spin_lock_rcu_node(rtpcp); // irqs already disabled.
 	}
-	needwake = func == wakeme_after_rcu;
-	if (havekthread && !timer_pending(&rtpcp->lazy_timer)) {
+	needwake = (func == wakeme_after_rcu) ||
+		   (rcu_segcblist_n_cbs(&rtpcp->cblist) == rcu_task_lazy_lim);
+	if (havekthread && !needwake && !timer_pending(&rtpcp->lazy_timer)) {
 		if (rtp->lazy_jiffies)
 			mod_timer(&rtpcp->lazy_timer, rcu_tasks_lazy_time(rtp));
 		else
-- 
2.40.1

