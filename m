Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9847E41FF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 15:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbjKGOor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 09:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjKGOop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 09:44:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B239E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 06:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NbdBthsvDmWc+b1OxzhoxxTD1DSyiCWn83dIxsFA2aA=; b=CHADnMQaqH1P4xMoHaxCAZOFSz
        /2XlC8cD/UTJ5/QsbvBN0t4+P2MLFdf+KRnHNV6nqgEUOUbX75qcrE8xBRm6rwJPd1Lsl5sjvLaaM
        QyDcpTqTgwEIkW/cYyvEPsF37lwf5s0fqgbIMrbYV0o6OzkYzZ/mKggyXuFypGZNcLq6/+Pxasq9f
        i0Efqmqdvvr6Yi421/rGjUNBcStOyLml7FrMXWsLLZpkQRwEhao4yvnXWLCXsHvLZnZwoQ4/MpThl
        nvY13XAVIesBVYwzvhen8Al+ke5USYbp4gTrcNWW6S/bIl2y1TJXGiq+Ti/anW5V0O/4U5sPoi8n+
        cSQjkzlQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r0NJY-00Cqlv-Nu; Tue, 07 Nov 2023 14:44:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id E13E630049D; Tue,  7 Nov 2023 15:44:24 +0100 (CET)
Date:   Tue, 7 Nov 2023 15:44:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v5 7/7] sched/fair: Fair server interface
Message-ID: <20231107144424.GX8262@noisy.programming.kicks-ass.net>
References: <cover.1699095159.git.bristot@kernel.org>
 <26adad2378c8b15533e4f6216c2863341e587f57.1699095159.git.bristot@kernel.org>
 <20231106154042.GH3818@noisy.programming.kicks-ass.net>
 <9a7222ed-88f8-4a3f-9d83-09b7fb977c27@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a7222ed-88f8-4a3f-9d83-09b7fb977c27@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 05:29:49PM +0100, Daniel Bristot de Oliveira wrote:

> I was thinking about moving the entire throttling machinery inside CONFIG_RT_GROUP_SCHED
> for now, because GROUP_SCHED depends on it, no?

This builds and boots..

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9930,8 +9930,6 @@ void __init sched_init(void)
 #endif /* CONFIG_RT_GROUP_SCHED */
 	}
 
-	init_rt_bandwidth(&def_rt_bandwidth, global_rt_period(), global_rt_runtime());
-
 #ifdef CONFIG_SMP
 	init_defrootdomain();
 #endif
@@ -9986,7 +9984,6 @@ void __init sched_init(void)
 		init_tg_cfs_entry(&root_task_group, &rq->cfs, NULL, i, NULL);
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
-		rq->rt.rt_runtime = def_rt_bandwidth.rt_runtime;
 #ifdef CONFIG_RT_GROUP_SCHED
 		init_tg_rt_entry(&root_task_group, &rq->rt, NULL, i, NULL);
 #endif
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1480,6 +1480,7 @@ static void update_curr_dl_se(struct rq
 	if (dl_se == &rq->fair_server)
 		return;
 
+#ifdef CONFIG_RT_GROUP_SCHED
 	/*
 	 * Because -- for now -- we share the rt bandwidth, we need to
 	 * account our runtime there too, otherwise actual rt tasks
@@ -1504,6 +1505,7 @@ static void update_curr_dl_se(struct rq
 			rt_rq->rt_time += delta_exec;
 		raw_spin_unlock(&rt_rq->rt_runtime_lock);
 	}
+#endif
 }
 
 void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -8,10 +8,6 @@ int sched_rr_timeslice = RR_TIMESLICE;
 /* More than 4 hours if BW_SHIFT equals 20. */
 static const u64 max_rt_runtime = MAX_BW;
 
-static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun);
-
-struct rt_bandwidth def_rt_bandwidth;
-
 /*
  * period over which we measure -rt task CPU usage in us.
  * default: 1s
@@ -67,6 +63,40 @@ static int __init sched_rt_sysctl_init(v
 late_initcall(sched_rt_sysctl_init);
 #endif
 
+void init_rt_rq(struct rt_rq *rt_rq)
+{
+	struct rt_prio_array *array;
+	int i;
+
+	array = &rt_rq->active;
+	for (i = 0; i < MAX_RT_PRIO; i++) {
+		INIT_LIST_HEAD(array->queue + i);
+		__clear_bit(i, array->bitmap);
+	}
+	/* delimiter for bitsearch: */
+	__set_bit(MAX_RT_PRIO, array->bitmap);
+
+#if defined CONFIG_SMP
+	rt_rq->highest_prio.curr = MAX_RT_PRIO-1;
+	rt_rq->highest_prio.next = MAX_RT_PRIO-1;
+	rt_rq->overloaded = 0;
+	plist_head_init(&rt_rq->pushable_tasks);
+#endif /* CONFIG_SMP */
+	/* We start is dequeued state, because no RT tasks are queued */
+	rt_rq->rt_queued = 0;
+
+#ifdef CONFIG_RT_GROUP_SCHED
+	rt_rq->rt_time = 0;
+	rt_rq->rt_throttled = 0;
+	rt_rq->rt_runtime = 0;
+	raw_spin_lock_init(&rt_rq->rt_runtime_lock);
+#endif
+}
+
+#ifdef CONFIG_RT_GROUP_SCHED
+
+static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun);
+
 static enum hrtimer_restart sched_rt_period_timer(struct hrtimer *timer)
 {
 	struct rt_bandwidth *rt_b =
@@ -131,35 +161,6 @@ static void start_rt_bandwidth(struct rt
 	do_start_rt_bandwidth(rt_b);
 }
 
-void init_rt_rq(struct rt_rq *rt_rq)
-{
-	struct rt_prio_array *array;
-	int i;
-
-	array = &rt_rq->active;
-	for (i = 0; i < MAX_RT_PRIO; i++) {
-		INIT_LIST_HEAD(array->queue + i);
-		__clear_bit(i, array->bitmap);
-	}
-	/* delimiter for bitsearch: */
-	__set_bit(MAX_RT_PRIO, array->bitmap);
-
-#if defined CONFIG_SMP
-	rt_rq->highest_prio.curr = MAX_RT_PRIO-1;
-	rt_rq->highest_prio.next = MAX_RT_PRIO-1;
-	rt_rq->overloaded = 0;
-	plist_head_init(&rt_rq->pushable_tasks);
-#endif /* CONFIG_SMP */
-	/* We start is dequeued state, because no RT tasks are queued */
-	rt_rq->rt_queued = 0;
-
-	rt_rq->rt_time = 0;
-	rt_rq->rt_throttled = 0;
-	rt_rq->rt_runtime = 0;
-	raw_spin_lock_init(&rt_rq->rt_runtime_lock);
-}
-
-#ifdef CONFIG_RT_GROUP_SCHED
 static void destroy_rt_bandwidth(struct rt_bandwidth *rt_b)
 {
 	hrtimer_cancel(&rt_b->rt_period_timer);
@@ -254,9 +255,6 @@ int alloc_rt_sched_group(struct task_gro
 	if (!tg->rt_se)
 		goto err;
 
-	init_rt_bandwidth(&tg->rt_bandwidth,
-			ktime_to_ns(def_rt_bandwidth.rt_period), 0);
-
 	for_each_possible_cpu(i) {
 		rt_rq = kzalloc_node(sizeof(struct rt_rq),
 				     GFP_KERNEL, cpu_to_node(i));
@@ -605,70 +603,6 @@ static inline struct rt_bandwidth *sched
 	return &rt_rq->tg->rt_bandwidth;
 }
 
-#else /* !CONFIG_RT_GROUP_SCHED */
-
-static inline u64 sched_rt_runtime(struct rt_rq *rt_rq)
-{
-	return rt_rq->rt_runtime;
-}
-
-static inline u64 sched_rt_period(struct rt_rq *rt_rq)
-{
-	return ktime_to_ns(def_rt_bandwidth.rt_period);
-}
-
-typedef struct rt_rq *rt_rq_iter_t;
-
-#define for_each_rt_rq(rt_rq, iter, rq) \
-	for ((void) iter, rt_rq = &rq->rt; rt_rq; rt_rq = NULL)
-
-#define for_each_sched_rt_entity(rt_se) \
-	for (; rt_se; rt_se = NULL)
-
-static inline struct rt_rq *group_rt_rq(struct sched_rt_entity *rt_se)
-{
-	return NULL;
-}
-
-static inline void sched_rt_rq_enqueue(struct rt_rq *rt_rq)
-{
-	struct rq *rq = rq_of_rt_rq(rt_rq);
-
-	if (!rt_rq->rt_nr_running)
-		return;
-
-	enqueue_top_rt_rq(rt_rq);
-	resched_curr(rq);
-}
-
-static inline void sched_rt_rq_dequeue(struct rt_rq *rt_rq)
-{
-	dequeue_top_rt_rq(rt_rq, rt_rq->rt_nr_running);
-}
-
-static inline int rt_rq_throttled(struct rt_rq *rt_rq)
-{
-	return rt_rq->rt_throttled;
-}
-
-static inline const struct cpumask *sched_rt_period_mask(void)
-{
-	return cpu_online_mask;
-}
-
-static inline
-struct rt_rq *sched_rt_period_rt_rq(struct rt_bandwidth *rt_b, int cpu)
-{
-	return &cpu_rq(cpu)->rt;
-}
-
-static inline struct rt_bandwidth *sched_rt_bandwidth(struct rt_rq *rt_rq)
-{
-	return &def_rt_bandwidth;
-}
-
-#endif /* CONFIG_RT_GROUP_SCHED */
-
 bool sched_rt_bandwidth_account(struct rt_rq *rt_rq)
 {
 	struct rt_bandwidth *rt_b = sched_rt_bandwidth(rt_rq);
@@ -860,7 +794,7 @@ static int do_sched_rt_period_timer(stru
 	const struct cpumask *span;
 
 	span = sched_rt_period_mask();
-#ifdef CONFIG_RT_GROUP_SCHED
+
 	/*
 	 * FIXME: isolated CPUs should really leave the root task group,
 	 * whether they are isolcpus or were isolated via cpusets, lest
@@ -872,7 +806,7 @@ static int do_sched_rt_period_timer(stru
 	 */
 	if (rt_b == &root_task_group.rt_bandwidth)
 		span = cpu_online_mask;
-#endif
+
 	for_each_cpu(i, span) {
 		int enqueue = 0;
 		struct rt_rq *rt_rq = sched_rt_period_rt_rq(rt_b, i);
@@ -939,18 +873,6 @@ static int do_sched_rt_period_timer(stru
 	return idle;
 }
 
-static inline int rt_se_prio(struct sched_rt_entity *rt_se)
-{
-#ifdef CONFIG_RT_GROUP_SCHED
-	struct rt_rq *rt_rq = group_rt_rq(rt_se);
-
-	if (rt_rq)
-		return rt_rq->highest_prio.curr;
-#endif
-
-	return rt_task_of(rt_se)->prio;
-}
-
 static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
 {
 	u64 runtime = sched_rt_runtime(rt_rq);
@@ -994,6 +916,70 @@ static int sched_rt_runtime_exceeded(str
 	return 0;
 }
 
+#else /* !CONFIG_RT_GROUP_SCHED */
+
+typedef struct rt_rq *rt_rq_iter_t;
+
+#define for_each_rt_rq(rt_rq, iter, rq) \
+	for ((void) iter, rt_rq = &rq->rt; rt_rq; rt_rq = NULL)
+
+#define for_each_sched_rt_entity(rt_se) \
+	for (; rt_se; rt_se = NULL)
+
+static inline struct rt_rq *group_rt_rq(struct sched_rt_entity *rt_se)
+{
+	return NULL;
+}
+
+static inline void sched_rt_rq_enqueue(struct rt_rq *rt_rq)
+{
+	struct rq *rq = rq_of_rt_rq(rt_rq);
+
+	if (!rt_rq->rt_nr_running)
+		return;
+
+	enqueue_top_rt_rq(rt_rq);
+	resched_curr(rq);
+}
+
+static inline void sched_rt_rq_dequeue(struct rt_rq *rt_rq)
+{
+	dequeue_top_rt_rq(rt_rq, rt_rq->rt_nr_running);
+}
+
+static inline int rt_rq_throttled(struct rt_rq *rt_rq)
+{
+	return false;
+}
+
+static inline const struct cpumask *sched_rt_period_mask(void)
+{
+	return cpu_online_mask;
+}
+
+static inline
+struct rt_rq *sched_rt_period_rt_rq(struct rt_bandwidth *rt_b, int cpu)
+{
+	return &cpu_rq(cpu)->rt;
+}
+
+static void __enable_runtime(struct rq *rq) { }
+static void __disable_runtime(struct rq *rq) { }
+
+#endif /* CONFIG_RT_GROUP_SCHED */
+
+static inline int rt_se_prio(struct sched_rt_entity *rt_se)
+{
+#ifdef CONFIG_RT_GROUP_SCHED
+	struct rt_rq *rt_rq = group_rt_rq(rt_se);
+
+	if (rt_rq)
+		return rt_rq->highest_prio.curr;
+#endif
+
+	return rt_task_of(rt_se)->prio;
+}
+
 /*
  * Update the current task's runtime statistics. Skip current tasks that
  * are not in our scheduling class.
@@ -1001,7 +987,6 @@ static int sched_rt_runtime_exceeded(str
 static void update_curr_rt(struct rq *rq)
 {
 	struct task_struct *curr = rq->curr;
-	struct sched_rt_entity *rt_se = &curr->rt;
 	s64 delta_exec;
 
 	if (curr->sched_class != &rt_sched_class)
@@ -1011,6 +996,9 @@ static void update_curr_rt(struct rq *rq
 	if (unlikely(delta_exec <= 0))
 		return;
 
+#ifdef CONFIG_RT_GROUP_SCHED
+	struct sched_rt_entity *rt_se = &curr->rt;
+
 	if (!rt_bandwidth_enabled())
 		return;
 
@@ -1029,6 +1017,7 @@ static void update_curr_rt(struct rq *rq
 				do_start_rt_bandwidth(sched_rt_bandwidth(rt_rq));
 		}
 	}
+#endif
 }
 
 static void
@@ -1185,7 +1174,6 @@ dec_rt_group(struct sched_rt_entity *rt_
 static void
 inc_rt_group(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
 {
-	start_rt_bandwidth(&def_rt_bandwidth);
 }
 
 static inline
@@ -2913,19 +2901,6 @@ int sched_rt_can_attach(struct task_grou
 #ifdef CONFIG_SYSCTL
 static int sched_rt_global_constraints(void)
 {
-	unsigned long flags;
-	int i;
-
-	raw_spin_lock_irqsave(&def_rt_bandwidth.rt_runtime_lock, flags);
-	for_each_possible_cpu(i) {
-		struct rt_rq *rt_rq = &cpu_rq(i)->rt;
-
-		raw_spin_lock(&rt_rq->rt_runtime_lock);
-		rt_rq->rt_runtime = global_rt_runtime();
-		raw_spin_unlock(&rt_rq->rt_runtime_lock);
-	}
-	raw_spin_unlock_irqrestore(&def_rt_bandwidth.rt_runtime_lock, flags);
-
 	return 0;
 }
 #endif /* CONFIG_SYSCTL */
@@ -2945,12 +2920,6 @@ static int sched_rt_global_validate(void
 
 static void sched_rt_do_global(void)
 {
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&def_rt_bandwidth.rt_runtime_lock, flags);
-	def_rt_bandwidth.rt_runtime = global_rt_runtime();
-	def_rt_bandwidth.rt_period = ns_to_ktime(global_rt_period());
-	raw_spin_unlock_irqrestore(&def_rt_bandwidth.rt_runtime_lock, flags);
 }
 
 static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -698,13 +698,13 @@ struct rt_rq {
 #endif /* CONFIG_SMP */
 	int			rt_queued;
 
+#ifdef CONFIG_RT_GROUP_SCHED
 	int			rt_throttled;
 	u64			rt_time;
 	u64			rt_runtime;
 	/* Nests inside the rq lock: */
 	raw_spinlock_t		rt_runtime_lock;
 
-#ifdef CONFIG_RT_GROUP_SCHED
 	unsigned int		rt_nr_boosted;
 
 	struct rq		*rq;
@@ -2460,7 +2460,6 @@ extern void reweight_task(struct task_st
 extern void resched_curr(struct rq *rq);
 extern void resched_cpu(int cpu);
 
-extern struct rt_bandwidth def_rt_bandwidth;
 extern void init_rt_bandwidth(struct rt_bandwidth *rt_b, u64 period, u64 runtime);
 extern bool sched_rt_bandwidth_account(struct rt_rq *rt_rq);
 
