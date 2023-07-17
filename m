Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD39756B43
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjGQSFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjGQSFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:05:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68351BDA;
        Mon, 17 Jul 2023 11:04:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DA0F61063;
        Mon, 17 Jul 2023 18:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92431C433C8;
        Mon, 17 Jul 2023 18:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689617095;
        bh=CThg7+qrAYHNviaEnrB7QQ1YArM5XTgkYw5qKyemOsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TvubXY9EE0C9gCFaPi+1i6CMEFSl0GE/uzksJ8eoClCwMhazf3m6gCm4EM2phKitC
         cIELsJbRoZOKZ/8yAPlfXP/7lwl14TskZjkcP3F3ODLMiqXrOUAtRw+KYKmtSAYGQg
         YtOlzR0H39xYPe0i01To5VBlyJOiEFv2L7FPAVLGOmS8BWa2/H6wIzfydHm7v9lqcE
         RQFWYRUtDJ2UcSEgTL1YHGehhvlCDD7VSwyiGFlKdkN2e4fxUFaIxmhQdYTH8l+HUt
         WatSLiTgT6UWMHM1SfR41qBEPHYedyGtd7derjP6izmUjc6Z3SNgjacHIibke2wPXF
         LB1gMuuUelP0g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 54EEACE03F1; Mon, 17 Jul 2023 11:04:55 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH rcu 1/5] rcu-tasks: Treat only synchronous grace periods urgently
Date:   Mon, 17 Jul 2023 11:04:50 -0700
Message-Id: <20230717180454.1097714-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <a6fff63c-5930-4918-82a3-a9301309d88d@paulmck-laptop>
References: <a6fff63c-5930-4918-82a3-a9301309d88d@paulmck-laptop>
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

The performance requirements on RCU Tasks, and in particular on RCU
Tasks Trace, have evolved over time as the workloads have evolved.
The current implementation is designed to provide low grace-period
latencies, and also to accommodate short-duration floods of callbacks.

However, current workloads can also provide a constant background
callback-queuing rate of a few hundred call_rcu_tasks_trace() invocations
per second.  This results in continuous back-to-back RCU Tasks Trace
grace periods, which in turn can consume the better part of 10% of a CPU.
One could take the attitude that there are several tens of other CPUs on
the systems running such workloads, but energy efficiency is a thing.
On these systems, although asynchronous grace-period requests happen
every few milliseconds, synchronous grace-period requests are quite rare.

This commit therefore arrranges for grace periods to be initiated
immediately in response to calls to synchronize_rcu_tasks*() and
also to calls to synchronize_rcu_mult() that are passed one of the
call_rcu_tasks*() functions.  These are recognized by the tell-tale
wakeme_after_rcu callback function.

In other cases, callbacks are gathered up for up to about 250 milliseconds
before a grace period is initiated.  This results in more than an order of
magnitude reduction in RCU Tasks Trace grace periods, with corresponding
reduction in consumption of CPU time.

Reported-by: Alexei Starovoitov <ast@kernel.org>
Reported-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 81 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 73 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index b770add3f843..c88d7fe29d92 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -25,6 +25,8 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
  * @cblist: Callback list.
  * @lock: Lock protecting per-CPU callback list.
  * @rtp_jiffies: Jiffies counter value for statistics.
+ * @lazy_timer: Timer to unlazify callbacks.
+ * @urgent_gp: Number of additional non-lazy grace periods.
  * @rtp_n_lock_retries: Rough lock-contention statistic.
  * @rtp_work: Work queue for invoking callbacks.
  * @rtp_irq_work: IRQ work queue for deferred wakeups.
@@ -38,6 +40,8 @@ struct rcu_tasks_percpu {
 	raw_spinlock_t __private lock;
 	unsigned long rtp_jiffies;
 	unsigned long rtp_n_lock_retries;
+	struct timer_list lazy_timer;
+	unsigned int urgent_gp;
 	struct work_struct rtp_work;
 	struct irq_work rtp_irq_work;
 	struct rcu_head barrier_q_head;
@@ -51,7 +55,6 @@ struct rcu_tasks_percpu {
  * @cbs_wait: RCU wait allowing a new callback to get kthread's attention.
  * @cbs_gbl_lock: Lock protecting callback list.
  * @tasks_gp_mutex: Mutex protecting grace period, needed during mid-boot dead zone.
- * @kthread_ptr: This flavor's grace-period/callback-invocation kthread.
  * @gp_func: This flavor's grace-period-wait function.
  * @gp_state: Grace period's most recent state transition (debugging).
  * @gp_sleep: Per-grace-period sleep to prevent CPU-bound looping.
@@ -61,6 +64,8 @@ struct rcu_tasks_percpu {
  * @tasks_gp_seq: Number of grace periods completed since boot.
  * @n_ipis: Number of IPIs sent to encourage grace periods to end.
  * @n_ipis_fails: Number of IPI-send failures.
+ * @kthread_ptr: This flavor's grace-period/callback-invocation kthread.
+ * @lazy_jiffies: Number of jiffies to allow callbacks to be lazy.
  * @pregp_func: This flavor's pre-grace-period function (optional).
  * @pertask_func: This flavor's per-task scan function (optional).
  * @postscan_func: This flavor's post-task scan function (optional).
@@ -92,6 +97,7 @@ struct rcu_tasks {
 	unsigned long n_ipis;
 	unsigned long n_ipis_fails;
 	struct task_struct *kthread_ptr;
+	unsigned long lazy_jiffies;
 	rcu_tasks_gp_func_t gp_func;
 	pregp_func_t pregp_func;
 	pertask_func_t pertask_func;
@@ -127,6 +133,7 @@ static struct rcu_tasks rt_name =							\
 	.gp_func = gp,									\
 	.call_func = call,								\
 	.rtpcpu = &rt_name ## __percpu,							\
+	.lazy_jiffies = DIV_ROUND_UP(HZ, 4),						\
 	.name = n,									\
 	.percpu_enqueue_shift = order_base_2(CONFIG_NR_CPUS),				\
 	.percpu_enqueue_lim = 1,							\
@@ -276,6 +283,33 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 			data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim), rcu_task_cb_adjust);
 }
 
+// Compute wakeup time for lazy callback timer.
+static unsigned long rcu_tasks_lazy_time(struct rcu_tasks *rtp)
+{
+	return jiffies + rtp->lazy_jiffies;
+}
+
+// Timer handler that unlazifies lazy callbacks.
+static void call_rcu_tasks_generic_timer(struct timer_list *tlp)
+{
+	unsigned long flags;
+	bool needwake = false;
+	struct rcu_tasks *rtp;
+	struct rcu_tasks_percpu *rtpcp = from_timer(rtpcp, tlp, lazy_timer);
+
+	rtp = rtpcp->rtpp;
+	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
+	if (!rcu_segcblist_empty(&rtpcp->cblist) && rtp->lazy_jiffies) {
+		if (!rtpcp->urgent_gp)
+			rtpcp->urgent_gp = 1;
+		needwake = true;
+		mod_timer(&rtpcp->lazy_timer, rcu_tasks_lazy_time(rtp));
+	}
+	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
+	if (needwake)
+		rcuwait_wake_up(&rtp->cbs_wait);
+}
+
 // IRQ-work handler that does deferred wakeup for call_rcu_tasks_generic().
 static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp)
 {
@@ -292,6 +326,7 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 {
 	int chosen_cpu;
 	unsigned long flags;
+	bool havekthread = smp_load_acquire(&rtp->kthread_ptr);
 	int ideal_cpu;
 	unsigned long j;
 	bool needadjust = false;
@@ -321,7 +356,15 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 		cblist_init_generic(rtp);
 		raw_spin_lock_rcu_node(rtpcp); // irqs already disabled.
 	}
-	needwake = rcu_segcblist_empty(&rtpcp->cblist);
+	needwake = func == wakeme_after_rcu;
+	if (havekthread && !timer_pending(&rtpcp->lazy_timer)) {
+		if (rtp->lazy_jiffies)
+			mod_timer(&rtpcp->lazy_timer, rcu_tasks_lazy_time(rtp));
+		else
+			needwake = rcu_segcblist_empty(&rtpcp->cblist);
+	}
+	if (needwake)
+		rtpcp->urgent_gp = 3;
 	rcu_segcblist_enqueue(&rtpcp->cblist, rhp);
 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 	if (unlikely(needadjust)) {
@@ -415,9 +458,14 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 		}
 		rcu_segcblist_advance(&rtpcp->cblist, rcu_seq_current(&rtp->tasks_gp_seq));
 		(void)rcu_segcblist_accelerate(&rtpcp->cblist, rcu_seq_snap(&rtp->tasks_gp_seq));
-		if (rcu_segcblist_pend_cbs(&rtpcp->cblist))
+		if (rtpcp->urgent_gp > 0 && rcu_segcblist_pend_cbs(&rtpcp->cblist)) {
+			if (rtp->lazy_jiffies)
+				rtpcp->urgent_gp--;
 			needgpcb |= 0x3;
-		if (!rcu_segcblist_empty(&rtpcp->cblist))
+		} else if (rcu_segcblist_empty(&rtpcp->cblist)) {
+			rtpcp->urgent_gp = 0;
+		}
+		if (rcu_segcblist_ready_cbs(&rtpcp->cblist))
 			needgpcb |= 0x1;
 		raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 	}
@@ -549,11 +597,19 @@ static void rcu_tasks_one_gp(struct rcu_tasks *rtp, bool midboot)
 // RCU-tasks kthread that detects grace periods and invokes callbacks.
 static int __noreturn rcu_tasks_kthread(void *arg)
 {
+	int cpu;
 	struct rcu_tasks *rtp = arg;
 
+	for_each_possible_cpu(cpu) {
+		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
+
+		timer_setup(&rtpcp->lazy_timer, call_rcu_tasks_generic_timer, 0);
+		rtpcp->urgent_gp = 1;
+	}
+
 	/* Run on housekeeping CPUs by default.  Sysadm can move if desired. */
 	housekeeping_affine(current, HK_TYPE_RCU);
-	WRITE_ONCE(rtp->kthread_ptr, current); // Let GPs start!
+	smp_store_release(&rtp->kthread_ptr, current); // Let GPs start!
 
 	/*
 	 * Each pass through the following loop makes one check for
@@ -635,16 +691,22 @@ static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 {
 	int cpu;
 	bool havecbs = false;
+	bool haveurgent = false;
+	bool haveurgentcbs = false;
 
 	for_each_possible_cpu(cpu) {
 		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
 
-		if (!data_race(rcu_segcblist_empty(&rtpcp->cblist))) {
+		if (!data_race(rcu_segcblist_empty(&rtpcp->cblist)))
 			havecbs = true;
+		if (data_race(rtpcp->urgent_gp))
+			haveurgent = true;
+		if (!data_race(rcu_segcblist_empty(&rtpcp->cblist)) && data_race(rtpcp->urgent_gp))
+			haveurgentcbs = true;
+		if (havecbs && haveurgent && haveurgentcbs)
 			break;
-		}
 	}
-	pr_info("%s: %s(%d) since %lu g:%lu i:%lu/%lu %c%c %s\n",
+	pr_info("%s: %s(%d) since %lu g:%lu i:%lu/%lu %c%c%c%c l:%lu %s\n",
 		rtp->kname,
 		tasks_gp_state_getname(rtp), data_race(rtp->gp_state),
 		jiffies - data_race(rtp->gp_jiffies),
@@ -652,6 +714,9 @@ static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 		data_race(rtp->n_ipis_fails), data_race(rtp->n_ipis),
 		".k"[!!data_race(rtp->kthread_ptr)],
 		".C"[havecbs],
+		".u"[haveurgent],
+		".U"[haveurgentcbs],
+		rtp->lazy_jiffies,
 		s);
 }
 #endif // #ifndef CONFIG_TINY_RCU
-- 
2.40.1

