Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E230876A493
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjGaXL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGaXLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:11:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2E51A5;
        Mon, 31 Jul 2023 16:11:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F18986134F;
        Mon, 31 Jul 2023 23:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1E1C433C7;
        Mon, 31 Jul 2023 23:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690845110;
        bh=QLAjE/GGSiZipKUex73TsazKgLlG2VFV8t+GpNpJUrs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QT7qFPwbt++C6pX1FEft72MhAT12SkEdw5f7xZYXniCoFrQYe82clCPDDxdSGX3I0
         Vv0CPidxzYvsT9AI4yTlxnLZwUaMyqBeSnhEr1+ZAXsEm2wTSx95f6uL4LdKhkvvak
         ZQe6DKpsaDCUBaiMPu0cA0wV38sPhtDHQ4zycelDCBsXdIvInxYRvb2yCXA1wMCMtN
         CDf/GFjm7G7ObpadRPHVSc/f2EWuVCq9dSSuGNoUpol7138IlGOmdiITt/jpnOm330
         ucSpVbKBv8QSpSIzy0/04p0kuscGRFZVerowhDFwENPkfzH+VxtQtcDXjpNSrisVhP
         UFP7H51bAB5kA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EE140CE1065; Mon, 31 Jul 2023 16:11:49 -0700 (PDT)
Date:   Mon, 31 Jul 2023 16:11:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 6/5] rcu-tasks: Permit use of debug-objects with RCU
 Tasks flavors
Message-ID: <0bb374e7-694e-4b2d-b2aa-472a5a4e1670@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a6fff63c-5930-4918-82a3-a9301309d88d@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6fff63c-5930-4918-82a3-a9301309d88d@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rcu-tasks: Permit use of debug-objects with RCU Tasks flavors

Currently, cblist_init_generic() holds a raw spinlock when invoking
INIT_WORK().  This fails in kernels built with CONFIG_DEBUG_OBJECTS=y
due to memory allocation being forbidden while holding a raw spinlock.
But the only reason for holding the raw spinlock is to synchronize
with early boot calls to call_rcu_tasks(), call_rcu_tasks_rude, and,
last but not least, call_rcu_tasks_trace().  These calls also invoke
cblist_init_generic() in order to support early boot queueing of
callbacks.

Except that there are no early boot calls to either of these three
functions, and the BPF guys confirm that they have no plans to add any
such calls.

This commit therefore removes the synchronization and adds a
WARN_ON_ONCE() to catch the case of now-prohibited early boot RCU Tasks
callback queueing.

If early boot queueing is needed, an "initialized" flag may be added to
the rcu_tasks structure.  Then queueing a callback before this flag is set
would initialize the callback list (if needed) and queue the callback.
The decision as to where to queue the callback given the possibility of
non-zero boot CPUs is left as an exercise for the reader.

Reported-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 291d536b1789..a4cd4ea2402c 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -236,7 +236,7 @@ static const char *tasks_gp_state_getname(struct rcu_tasks *rtp)
 #endif /* #ifndef CONFIG_TINY_RCU */
 
 // Initialize per-CPU callback lists for the specified flavor of
-// Tasks RCU.
+// Tasks RCU.  Do not enqueue callbacks before this function is invoked.
 static void cblist_init_generic(struct rcu_tasks *rtp)
 {
 	int cpu;
@@ -244,7 +244,6 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 	int lim;
 	int shift;
 
-	raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
 	if (rcu_task_enqueue_lim < 0) {
 		rcu_task_enqueue_lim = 1;
 		rcu_task_cb_adjust = true;
@@ -267,17 +266,16 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 		WARN_ON_ONCE(!rtpcp);
 		if (cpu)
 			raw_spin_lock_init(&ACCESS_PRIVATE(rtpcp, lock));
-		raw_spin_lock_rcu_node(rtpcp); // irqs already disabled.
+		local_irq_save(flags);  // serialize initialization
 		if (rcu_segcblist_empty(&rtpcp->cblist))
 			rcu_segcblist_init(&rtpcp->cblist);
+		local_irq_restore(flags);
 		INIT_WORK(&rtpcp->rtp_work, rcu_tasks_invoke_cbs_wq);
 		rtpcp->cpu = cpu;
 		rtpcp->rtpp = rtp;
 		if (!rtpcp->rtp_blkd_tasks.next)
 			INIT_LIST_HEAD(&rtpcp->rtp_blkd_tasks);
-		raw_spin_unlock_rcu_node(rtpcp); // irqs remain disabled.
 	}
-	raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
 
 	pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=%d.\n", rtp->name,
 			data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim), rcu_task_cb_adjust);
@@ -351,11 +349,9 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 		    READ_ONCE(rtp->percpu_enqueue_lim) != nr_cpu_ids)
 			needadjust = true;  // Defer adjustment to avoid deadlock.
 	}
-	if (!rcu_segcblist_is_enabled(&rtpcp->cblist)) {
-		raw_spin_unlock_rcu_node(rtpcp); // irqs remain disabled.
-		cblist_init_generic(rtp);
-		raw_spin_lock_rcu_node(rtpcp); // irqs already disabled.
-	}
+	// Queuing callbacks before initialization not yet supported.
+	if (WARN_ON_ONCE(!rcu_segcblist_is_enabled(&rtpcp->cblist)))
+		rcu_segcblist_init(&rtpcp->cblist);
 	needwake = (func == wakeme_after_rcu) ||
 		   (rcu_segcblist_n_cbs(&rtpcp->cblist) == rcu_task_lazy_lim);
 	if (havekthread && !needwake && !timer_pending(&rtpcp->lazy_timer)) {
