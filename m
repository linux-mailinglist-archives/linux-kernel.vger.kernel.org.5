Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4057EBF10
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 10:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbjKOJFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbjKOJE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:04:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03FD118;
        Wed, 15 Nov 2023 01:04:51 -0800 (PST)
Date:   Wed, 15 Nov 2023 09:04:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700039090;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DNAf8wU6PPCxHMJYi0/ea6+KwN/XeDBJ0saFlTOGsik=;
        b=zt3UhOulnXys+bysSe2hDP75/CF1bQKpTcxZTKx5IOT5sXHAIJsBYs+QoQiAC52mBDIc1c
        m1Z4m1QoCd41X7fddS7RKDawUUvuN+5eTlVqN3a9pD833qKrLIb8YJ9G9/qzlmM03b5j+d
        aPD+9jnoUTvDpCjNSBgJZB2P/IBS1Q2TCURBQc4XNKtE09W/SBA1e4x2cU6IeX5FWfU3rS
        erfUtYThQZyeizEmn/tSYRYI7xeevyngXbCzG1uiFxjOXC8xfKD/WFzLY985YRpj3Zz39u
        aE2af3Rnx8zzWYMJSuxY7t35nqU9grBfLYQF9TnfpAfN8giiABUHU0arOMf0NQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700039090;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DNAf8wU6PPCxHMJYi0/ea6+KwN/XeDBJ0saFlTOGsik=;
        b=HCK8+YBxb5G9CKOgjy8dhA4pHLfRAtmPM8M3uWQtnNsCorFp/61OR4Inxwxk44CpfMaGiD
        JjtyU9hzp6KJBiDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Introduce deadline servers
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <4968601859d920335cf85822eb573a5f179f04b8.1699095159.git.bristot@kernel.org>
References: <4968601859d920335cf85822eb573a5f179f04b8.1699095159.git.bristot@kernel.org>
MIME-Version: 1.0
Message-ID: <170003908965.391.16468153080164112430.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     63ba8422f876e32ee564ea95da9a7313b13ff0a1
Gitweb:        https://git.kernel.org/tip/63ba8422f876e32ee564ea95da9a7313b13ff0a1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 04 Nov 2023 11:59:21 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Nov 2023 09:57:51 +01:00

sched/deadline: Introduce deadline servers

Low priority tasks (e.g., SCHED_OTHER) can suffer starvation if tasks
with higher priority (e.g., SCHED_FIFO) monopolize CPU(s).

RT Throttling has been introduced a while ago as a (mostly debug)
countermeasure one can utilize to reserve some CPU time for low priority
tasks (usually background type of work, e.g. workqueues, timers, etc.).
It however has its own problems (see documentation) and the undesired
effect of unconditionally throttling FIFO tasks even when no lower
priority activity needs to run (there are mechanisms to fix this issue
as well, but, again, with their own problems).

Introduce deadline servers to service low priority tasks needs under
starvation conditions. Deadline servers are built extending SCHED_DEADLINE
implementation to allow 2-level scheduling (a sched_deadline entity
becomes a container for lower priority scheduling entities).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/4968601859d920335cf85822eb573a5f179f04b8.1699095159.git.bristot@kernel.org
---
 include/linux/sched.h   |  22 ++-
 kernel/sched/core.c     |  17 ++-
 kernel/sched/deadline.c | 332 ++++++++++++++++++++++++++-------------
 kernel/sched/fair.c     |   2 +-
 kernel/sched/sched.h    |  27 +++-
 5 files changed, 292 insertions(+), 108 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 44b46d9..8d25816 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -63,11 +63,13 @@ struct robust_list_head;
 struct root_domain;
 struct rq;
 struct sched_attr;
+struct sched_dl_entity;
 struct seq_file;
 struct sighand_struct;
 struct signal_struct;
 struct task_delay_info;
 struct task_group;
+struct task_struct;
 struct user_event_mm;
 
 /*
@@ -607,6 +609,9 @@ struct sched_rt_entity {
 #endif
 } __randomize_layout;
 
+typedef bool (*dl_server_has_tasks_f)(struct sched_dl_entity *);
+typedef struct task_struct *(*dl_server_pick_f)(struct sched_dl_entity *);
+
 struct sched_dl_entity {
 	struct rb_node			rb_node;
 
@@ -654,6 +659,7 @@ struct sched_dl_entity {
 	unsigned int			dl_yielded        : 1;
 	unsigned int			dl_non_contending : 1;
 	unsigned int			dl_overrun	  : 1;
+	unsigned int			dl_server         : 1;
 
 	/*
 	 * Bandwidth enforcement timer. Each -deadline task has its
@@ -668,7 +674,20 @@ struct sched_dl_entity {
 	 * timer is needed to decrease the active utilization at the correct
 	 * time.
 	 */
-	struct hrtimer inactive_timer;
+	struct hrtimer			inactive_timer;
+
+	/*
+	 * Bits for DL-server functionality. Also see the comment near
+	 * dl_server_update().
+	 *
+	 * @rq the runqueue this server is for
+	 *
+	 * @server_has_tasks() returns true if @server_pick return a
+	 * runnable task.
+	 */
+	struct rq			*rq;
+	dl_server_has_tasks_f		server_has_tasks;
+	dl_server_pick_f		server_pick;
 
 #ifdef CONFIG_RT_MUTEXES
 	/*
@@ -795,6 +814,7 @@ struct task_struct {
 	struct sched_entity		se;
 	struct sched_rt_entity		rt;
 	struct sched_dl_entity		dl;
+	struct sched_dl_entity		*dl_server;
 	const struct sched_class	*sched_class;
 
 #ifdef CONFIG_SCHED_CORE
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 966631f..f5f4495 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3797,6 +3797,8 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 		rq->idle_stamp = 0;
 	}
 #endif
+
+	p->dl_server = NULL;
 }
 
 /*
@@ -6003,12 +6005,27 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			p = pick_next_task_idle(rq);
 		}
 
+		/*
+		 * This is the fast path; it cannot be a DL server pick;
+		 * therefore even if @p == @prev, ->dl_server must be NULL.
+		 */
+		if (p->dl_server)
+			p->dl_server = NULL;
+
 		return p;
 	}
 
 restart:
 	put_prev_task_balance(rq, prev, rf);
 
+	/*
+	 * We've updated @prev and no longer need the server link, clear it.
+	 * Must be done before ->pick_next_task() because that can (re)set
+	 * ->dl_server.
+	 */
+	if (prev->dl_server)
+		prev->dl_server = NULL;
+
 	for_each_class(class) {
 		p = class->pick_next_task(rq);
 		if (p)
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 81810f6..a04a436 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -54,8 +54,14 @@ static int __init sched_dl_sysctl_init(void)
 late_initcall(sched_dl_sysctl_init);
 #endif
 
+static bool dl_server(struct sched_dl_entity *dl_se)
+{
+	return dl_se->dl_server;
+}
+
 static inline struct task_struct *dl_task_of(struct sched_dl_entity *dl_se)
 {
+	BUG_ON(dl_server(dl_se));
 	return container_of(dl_se, struct task_struct, dl);
 }
 
@@ -64,12 +70,19 @@ static inline struct rq *rq_of_dl_rq(struct dl_rq *dl_rq)
 	return container_of(dl_rq, struct rq, dl);
 }
 
-static inline struct dl_rq *dl_rq_of_se(struct sched_dl_entity *dl_se)
+static inline struct rq *rq_of_dl_se(struct sched_dl_entity *dl_se)
 {
-	struct task_struct *p = dl_task_of(dl_se);
-	struct rq *rq = task_rq(p);
+	struct rq *rq = dl_se->rq;
+
+	if (!dl_server(dl_se))
+		rq = task_rq(dl_task_of(dl_se));
 
-	return &rq->dl;
+	return rq;
+}
+
+static inline struct dl_rq *dl_rq_of_se(struct sched_dl_entity *dl_se)
+{
+	return &rq_of_dl_se(dl_se)->dl;
 }
 
 static inline int on_dl_rq(struct sched_dl_entity *dl_se)
@@ -394,9 +407,8 @@ static void __dl_clear_params(struct sched_dl_entity *dl_se);
 static void task_non_contending(struct sched_dl_entity *dl_se)
 {
 	struct hrtimer *timer = &dl_se->inactive_timer;
-	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
-	struct rq *rq = rq_of_dl_rq(dl_rq);
-	struct task_struct *p = dl_task_of(dl_se);
+	struct rq *rq = rq_of_dl_se(dl_se);
+	struct dl_rq *dl_rq = &rq->dl;
 	s64 zerolag_time;
 
 	/*
@@ -426,25 +438,33 @@ static void task_non_contending(struct sched_dl_entity *dl_se)
 	 * utilization now, instead of starting a timer
 	 */
 	if ((zerolag_time < 0) || hrtimer_active(&dl_se->inactive_timer)) {
-		if (dl_task(p))
+		if (dl_server(dl_se)) {
 			sub_running_bw(dl_se, dl_rq);
+		} else {
+			struct task_struct *p = dl_task_of(dl_se);
 
-		if (!dl_task(p) || READ_ONCE(p->__state) == TASK_DEAD) {
-			struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
+			if (dl_task(p))
+				sub_running_bw(dl_se, dl_rq);
 
-			if (READ_ONCE(p->__state) == TASK_DEAD)
-				sub_rq_bw(dl_se, &rq->dl);
-			raw_spin_lock(&dl_b->lock);
-			__dl_sub(dl_b, dl_se->dl_bw, dl_bw_cpus(task_cpu(p)));
-			raw_spin_unlock(&dl_b->lock);
-			__dl_clear_params(dl_se);
+			if (!dl_task(p) || READ_ONCE(p->__state) == TASK_DEAD) {
+				struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
+
+				if (READ_ONCE(p->__state) == TASK_DEAD)
+					sub_rq_bw(dl_se, &rq->dl);
+				raw_spin_lock(&dl_b->lock);
+				__dl_sub(dl_b, dl_se->dl_bw, dl_bw_cpus(task_cpu(p)));
+				raw_spin_unlock(&dl_b->lock);
+				__dl_clear_params(dl_se);
+			}
 		}
 
 		return;
 	}
 
 	dl_se->dl_non_contending = 1;
-	get_task_struct(p);
+	if (!dl_server(dl_se))
+		get_task_struct(dl_task_of(dl_se));
+
 	hrtimer_start(timer, ns_to_ktime(zerolag_time), HRTIMER_MODE_REL_HARD);
 }
 
@@ -471,8 +491,10 @@ static void task_contending(struct sched_dl_entity *dl_se, int flags)
 		 * will not touch the rq's active utilization,
 		 * so we are still safe.
 		 */
-		if (hrtimer_try_to_cancel(&dl_se->inactive_timer) == 1)
-			put_task_struct(dl_task_of(dl_se));
+		if (hrtimer_try_to_cancel(&dl_se->inactive_timer) == 1) {
+			if (!dl_server(dl_se))
+				put_task_struct(dl_task_of(dl_se));
+		}
 	} else {
 		/*
 		 * Since "dl_non_contending" is not set, the
@@ -485,10 +507,8 @@ static void task_contending(struct sched_dl_entity *dl_se, int flags)
 	}
 }
 
-static inline int is_leftmost(struct task_struct *p, struct dl_rq *dl_rq)
+static inline int is_leftmost(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 {
-	struct sched_dl_entity *dl_se = &p->dl;
-
 	return rb_first_cached(&dl_rq->root) == &dl_se->rb_node;
 }
 
@@ -740,8 +760,10 @@ static inline void deadline_queue_pull_task(struct rq *rq)
 }
 #endif /* CONFIG_SMP */
 
+static void
+enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags);
 static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags);
-static void __dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags);
+static void dequeue_dl_entity(struct sched_dl_entity *dl_se, int flags);
 static void wakeup_preempt_dl(struct rq *rq, struct task_struct *p, int flags);
 
 static inline void replenish_dl_new_period(struct sched_dl_entity *dl_se,
@@ -989,8 +1011,7 @@ static inline bool dl_is_implicit(struct sched_dl_entity *dl_se)
  */
 static void update_dl_entity(struct sched_dl_entity *dl_se)
 {
-	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
-	struct rq *rq = rq_of_dl_rq(dl_rq);
+	struct rq *rq = rq_of_dl_se(dl_se);
 
 	if (dl_time_before(dl_se->deadline, rq_clock(rq)) ||
 	    dl_entity_overflow(dl_se, rq_clock(rq))) {
@@ -1021,11 +1042,11 @@ static inline u64 dl_next_period(struct sched_dl_entity *dl_se)
  * actually started or not (i.e., the replenishment instant is in
  * the future or in the past).
  */
-static int start_dl_timer(struct task_struct *p)
+static int start_dl_timer(struct sched_dl_entity *dl_se)
 {
-	struct sched_dl_entity *dl_se = &p->dl;
 	struct hrtimer *timer = &dl_se->dl_timer;
-	struct rq *rq = task_rq(p);
+	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
+	struct rq *rq = rq_of_dl_rq(dl_rq);
 	ktime_t now, act;
 	s64 delta;
 
@@ -1059,13 +1080,33 @@ static int start_dl_timer(struct task_struct *p)
 	 * and observe our state.
 	 */
 	if (!hrtimer_is_queued(timer)) {
-		get_task_struct(p);
+		if (!dl_server(dl_se))
+			get_task_struct(dl_task_of(dl_se));
 		hrtimer_start(timer, act, HRTIMER_MODE_ABS_HARD);
 	}
 
 	return 1;
 }
 
+static void __push_dl_task(struct rq *rq, struct rq_flags *rf)
+{
+#ifdef CONFIG_SMP
+	/*
+	 * Queueing this task back might have overloaded rq, check if we need
+	 * to kick someone away.
+	 */
+	if (has_pushable_dl_tasks(rq)) {
+		/*
+		 * Nothing relies on rq->lock after this, so its safe to drop
+		 * rq->lock.
+		 */
+		rq_unpin_lock(rq, rf);
+		push_dl_task(rq);
+		rq_repin_lock(rq, rf);
+	}
+#endif
+}
+
 /*
  * This is the bandwidth enforcement timer callback. If here, we know
  * a task is not on its dl_rq, since the fact that the timer was running
@@ -1084,10 +1125,34 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 	struct sched_dl_entity *dl_se = container_of(timer,
 						     struct sched_dl_entity,
 						     dl_timer);
-	struct task_struct *p = dl_task_of(dl_se);
+	struct task_struct *p;
 	struct rq_flags rf;
 	struct rq *rq;
 
+	if (dl_server(dl_se)) {
+		struct rq *rq = rq_of_dl_se(dl_se);
+		struct rq_flags rf;
+
+		rq_lock(rq, &rf);
+		if (dl_se->dl_throttled) {
+			sched_clock_tick();
+			update_rq_clock(rq);
+
+			if (dl_se->server_has_tasks(dl_se)) {
+				enqueue_dl_entity(dl_se, ENQUEUE_REPLENISH);
+				resched_curr(rq);
+				__push_dl_task(rq, &rf);
+			} else {
+				replenish_dl_entity(dl_se);
+			}
+
+		}
+		rq_unlock(rq, &rf);
+
+		return HRTIMER_NORESTART;
+	}
+
+	p = dl_task_of(dl_se);
 	rq = task_rq_lock(p, &rf);
 
 	/*
@@ -1158,21 +1223,7 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 	else
 		resched_curr(rq);
 
-#ifdef CONFIG_SMP
-	/*
-	 * Queueing this task back might have overloaded rq, check if we need
-	 * to kick someone away.
-	 */
-	if (has_pushable_dl_tasks(rq)) {
-		/*
-		 * Nothing relies on rq->lock after this, so its safe to drop
-		 * rq->lock.
-		 */
-		rq_unpin_lock(rq, &rf);
-		push_dl_task(rq);
-		rq_repin_lock(rq, &rf);
-	}
-#endif
+	__push_dl_task(rq, &rf);
 
 unlock:
 	task_rq_unlock(rq, p, &rf);
@@ -1214,12 +1265,11 @@ static void init_dl_task_timer(struct sched_dl_entity *dl_se)
  */
 static inline void dl_check_constrained_dl(struct sched_dl_entity *dl_se)
 {
-	struct task_struct *p = dl_task_of(dl_se);
-	struct rq *rq = rq_of_dl_rq(dl_rq_of_se(dl_se));
+	struct rq *rq = rq_of_dl_se(dl_se);
 
 	if (dl_time_before(dl_se->deadline, rq_clock(rq)) &&
 	    dl_time_before(rq_clock(rq), dl_next_period(dl_se))) {
-		if (unlikely(is_dl_boosted(dl_se) || !start_dl_timer(p)))
+		if (unlikely(is_dl_boosted(dl_se) || !start_dl_timer(dl_se)))
 			return;
 		dl_se->dl_throttled = 1;
 		if (dl_se->runtime > 0)
@@ -1270,29 +1320,13 @@ static u64 grub_reclaim(u64 delta, struct rq *rq, struct sched_dl_entity *dl_se)
 	return (delta * u_act) >> BW_SHIFT;
 }
 
-/*
- * Update the current task's runtime statistics (provided it is still
- * a -deadline task and has not been removed from the dl_rq).
- */
-static void update_curr_dl(struct rq *rq)
+static inline void
+update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se,
+                        int flags);
+static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta_exec)
 {
-	struct task_struct *curr = rq->curr;
-	struct sched_dl_entity *dl_se = &curr->dl;
-	s64 delta_exec, scaled_delta_exec;
-	int cpu = cpu_of(rq);
-
-	if (!dl_task(curr) || !on_dl_rq(dl_se))
-		return;
+	s64 scaled_delta_exec;
 
-	/*
-	 * Consumed budget is computed considering the time as
-	 * observed by schedulable tasks (excluding time spent
-	 * in hardirq context, etc.). Deadlines are instead
-	 * computed using hard walltime. This seems to be the more
-	 * natural solution, but the full ramifications of this
-	 * approach need further study.
-	 */
-	delta_exec = update_curr_common(rq);
 	if (unlikely(delta_exec <= 0)) {
 		if (unlikely(dl_se->dl_yielded))
 			goto throttle;
@@ -1310,10 +1344,9 @@ static void update_curr_dl(struct rq *rq)
 	 * according to current frequency and CPU maximum capacity.
 	 */
 	if (unlikely(dl_se->flags & SCHED_FLAG_RECLAIM)) {
-		scaled_delta_exec = grub_reclaim(delta_exec,
-						 rq,
-						 &curr->dl);
+		scaled_delta_exec = grub_reclaim(delta_exec, rq, dl_se);
 	} else {
+		int cpu = cpu_of(rq);
 		unsigned long scale_freq = arch_scale_freq_capacity(cpu);
 		unsigned long scale_cpu = arch_scale_cpu_capacity(cpu);
 
@@ -1332,11 +1365,20 @@ throttle:
 		    (dl_se->flags & SCHED_FLAG_DL_OVERRUN))
 			dl_se->dl_overrun = 1;
 
-		__dequeue_task_dl(rq, curr, 0);
-		if (unlikely(is_dl_boosted(dl_se) || !start_dl_timer(curr)))
-			enqueue_task_dl(rq, curr, ENQUEUE_REPLENISH);
+		dequeue_dl_entity(dl_se, 0);
+		if (!dl_server(dl_se)) {
+			update_stats_dequeue_dl(&rq->dl, dl_se, 0);
+			dequeue_pushable_dl_task(rq, dl_task_of(dl_se));
+		}
 
-		if (!is_leftmost(curr, &rq->dl))
+		if (unlikely(is_dl_boosted(dl_se) || !start_dl_timer(dl_se))) {
+			if (dl_server(dl_se))
+				enqueue_dl_entity(dl_se, ENQUEUE_REPLENISH);
+			else
+				enqueue_task_dl(rq, dl_task_of(dl_se), ENQUEUE_REPLENISH);
+		}
+
+		if (!is_leftmost(dl_se, &rq->dl))
 			resched_curr(rq);
 	}
 
@@ -1366,20 +1408,82 @@ throttle:
 	}
 }
 
+void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
+{
+	update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
+}
+
+void dl_server_start(struct sched_dl_entity *dl_se)
+{
+	if (!dl_server(dl_se)) {
+		dl_se->dl_server = 1;
+		setup_new_dl_entity(dl_se);
+	}
+	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
+}
+
+void dl_server_stop(struct sched_dl_entity *dl_se)
+{
+	dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);
+}
+
+void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
+		    dl_server_has_tasks_f has_tasks,
+		    dl_server_pick_f pick)
+{
+	dl_se->rq = rq;
+	dl_se->server_has_tasks = has_tasks;
+	dl_se->server_pick = pick;
+}
+
+/*
+ * Update the current task's runtime statistics (provided it is still
+ * a -deadline task and has not been removed from the dl_rq).
+ */
+static void update_curr_dl(struct rq *rq)
+{
+	struct task_struct *curr = rq->curr;
+	struct sched_dl_entity *dl_se = &curr->dl;
+	s64 delta_exec;
+
+	if (!dl_task(curr) || !on_dl_rq(dl_se))
+		return;
+
+	/*
+	 * Consumed budget is computed considering the time as
+	 * observed by schedulable tasks (excluding time spent
+	 * in hardirq context, etc.). Deadlines are instead
+	 * computed using hard walltime. This seems to be the more
+	 * natural solution, but the full ramifications of this
+	 * approach need further study.
+	 */
+	delta_exec = update_curr_common(rq);
+	update_curr_dl_se(rq, dl_se, delta_exec);
+}
+
 static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 {
 	struct sched_dl_entity *dl_se = container_of(timer,
 						     struct sched_dl_entity,
 						     inactive_timer);
-	struct task_struct *p = dl_task_of(dl_se);
+	struct task_struct *p = NULL;
 	struct rq_flags rf;
 	struct rq *rq;
 
-	rq = task_rq_lock(p, &rf);
+	if (!dl_server(dl_se)) {
+		p = dl_task_of(dl_se);
+		rq = task_rq_lock(p, &rf);
+	} else {
+		rq = dl_se->rq;
+		rq_lock(rq, &rf);
+	}
 
 	sched_clock_tick();
 	update_rq_clock(rq);
 
+	if (dl_server(dl_se))
+		goto no_task;
+
 	if (!dl_task(p) || READ_ONCE(p->__state) == TASK_DEAD) {
 		struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
 
@@ -1396,14 +1500,21 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 
 		goto unlock;
 	}
+
+no_task:
 	if (dl_se->dl_non_contending == 0)
 		goto unlock;
 
 	sub_running_bw(dl_se, &rq->dl);
 	dl_se->dl_non_contending = 0;
 unlock:
-	task_rq_unlock(rq, p, &rf);
-	put_task_struct(p);
+
+	if (!dl_server(dl_se)) {
+		task_rq_unlock(rq, p, &rf);
+		put_task_struct(p);
+	} else {
+		rq_unlock(rq, &rf);
+	}
 
 	return HRTIMER_NORESTART;
 }
@@ -1466,10 +1577,8 @@ static inline void dec_dl_deadline(struct dl_rq *dl_rq, u64 deadline) {}
 static inline
 void inc_dl_tasks(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 {
-	int prio = dl_task_of(dl_se)->prio;
 	u64 deadline = dl_se->deadline;
 
-	WARN_ON(!dl_prio(prio));
 	dl_rq->dl_nr_running++;
 	add_nr_running(rq_of_dl_rq(dl_rq), 1);
 
@@ -1479,9 +1588,6 @@ void inc_dl_tasks(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 static inline
 void dec_dl_tasks(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 {
-	int prio = dl_task_of(dl_se)->prio;
-
-	WARN_ON(!dl_prio(prio));
 	WARN_ON(!dl_rq->dl_nr_running);
 	dl_rq->dl_nr_running--;
 	sub_nr_running(rq_of_dl_rq(dl_rq), 1);
@@ -1648,8 +1754,7 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 	} else if (flags & ENQUEUE_REPLENISH) {
 		replenish_dl_entity(dl_se);
 	} else if ((flags & ENQUEUE_RESTORE) &&
-		  dl_time_before(dl_se->deadline,
-				 rq_clock(rq_of_dl_rq(dl_rq_of_se(dl_se))))) {
+		   dl_time_before(dl_se->deadline, rq_clock(rq_of_dl_se(dl_se)))) {
 		setup_new_dl_entity(dl_se);
 	}
 
@@ -1730,19 +1835,13 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 
 	enqueue_dl_entity(&p->dl, flags);
 
+	if (dl_server(&p->dl))
+		return;
+
 	if (!task_current(rq, p) && !p->dl.dl_throttled && p->nr_cpus_allowed > 1)
 		enqueue_pushable_dl_task(rq, p);
 }
 
-static void __dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
-{
-	update_stats_dequeue_dl(&rq->dl, &p->dl, flags);
-	dequeue_dl_entity(&p->dl, flags);
-
-	if (!p->dl.dl_throttled)
-		dequeue_pushable_dl_task(rq, p);
-}
-
 static void dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 {
 	update_curr_dl(rq);
@@ -1750,7 +1849,9 @@ static void dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 	if (p->on_rq == TASK_ON_RQ_MIGRATING)
 		flags |= DEQUEUE_MIGRATING;
 
-	__dequeue_task_dl(rq, p, flags);
+	dequeue_dl_entity(&p->dl, flags);
+	if (!p->dl.dl_throttled && !dl_server(&p->dl))
+		dequeue_pushable_dl_task(rq, p);
 }
 
 /*
@@ -1940,12 +2041,12 @@ static void wakeup_preempt_dl(struct rq *rq, struct task_struct *p,
 }
 
 #ifdef CONFIG_SCHED_HRTICK
-static void start_hrtick_dl(struct rq *rq, struct task_struct *p)
+static void start_hrtick_dl(struct rq *rq, struct sched_dl_entity *dl_se)
 {
-	hrtick_start(rq, p->dl.runtime);
+	hrtick_start(rq, dl_se->runtime);
 }
 #else /* !CONFIG_SCHED_HRTICK */
-static void start_hrtick_dl(struct rq *rq, struct task_struct *p)
+static void start_hrtick_dl(struct rq *rq, struct sched_dl_entity *dl_se)
 {
 }
 #endif
@@ -1965,9 +2066,6 @@ static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
 	if (!first)
 		return;
 
-	if (hrtick_enabled_dl(rq))
-		start_hrtick_dl(rq, p);
-
 	if (rq->curr->sched_class != &dl_sched_class)
 		update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 0);
 
@@ -1990,12 +2088,25 @@ static struct task_struct *pick_task_dl(struct rq *rq)
 	struct dl_rq *dl_rq = &rq->dl;
 	struct task_struct *p;
 
+again:
 	if (!sched_dl_runnable(rq))
 		return NULL;
 
 	dl_se = pick_next_dl_entity(dl_rq);
 	WARN_ON_ONCE(!dl_se);
-	p = dl_task_of(dl_se);
+
+	if (dl_server(dl_se)) {
+		p = dl_se->server_pick(dl_se);
+		if (!p) {
+			WARN_ON_ONCE(1);
+			dl_se->dl_yielded = 1;
+			update_curr_dl_se(rq, dl_se, 0);
+			goto again;
+		}
+		p->dl_server = dl_se;
+	} else {
+		p = dl_task_of(dl_se);
+	}
 
 	return p;
 }
@@ -2005,9 +2116,15 @@ static struct task_struct *pick_next_task_dl(struct rq *rq)
 	struct task_struct *p;
 
 	p = pick_task_dl(rq);
-	if (p)
+	if (!p)
+		return p;
+
+	if (!p->dl_server)
 		set_next_task_dl(rq, p, true);
 
+	if (hrtick_enabled(rq))
+		start_hrtick_dl(rq, &p->dl);
+
 	return p;
 }
 
@@ -2045,8 +2162,8 @@ static void task_tick_dl(struct rq *rq, struct task_struct *p, int queued)
 	 * be set and schedule() will start a new hrtick for the next task.
 	 */
 	if (hrtick_enabled_dl(rq) && queued && p->dl.runtime > 0 &&
-	    is_leftmost(p, &rq->dl))
-		start_hrtick_dl(rq, p);
+	    is_leftmost(&p->dl, &rq->dl))
+		start_hrtick_dl(rq, &p->dl);
 }
 
 static void task_fork_dl(struct task_struct *p)
@@ -2986,6 +3103,7 @@ static void __dl_clear_params(struct sched_dl_entity *dl_se)
 	dl_se->dl_yielded		= 0;
 	dl_se->dl_non_contending	= 0;
 	dl_se->dl_overrun		= 0;
+	dl_se->dl_server		= 0;
 
 #ifdef CONFIG_RT_MUTEXES
 	dl_se->pi_se			= dl_se;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1cd92b1..07f5558 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1131,6 +1131,8 @@ static inline void update_curr_task(struct task_struct *p, s64 delta_exec)
 	trace_sched_stat_runtime(p, delta_exec);
 	account_group_exec_runtime(p, delta_exec);
 	cgroup_account_cputime(p, delta_exec);
+	if (p->dl_server)
+		dl_server_update(p->dl_server, delta_exec);
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1cda787..8a70d51 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -313,6 +313,33 @@ extern bool dl_param_changed(struct task_struct *p, const struct sched_attr *att
 extern int  dl_cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
 extern int  dl_bw_check_overflow(int cpu);
 
+/*
+ * SCHED_DEADLINE supports servers (nested scheduling) with the following
+ * interface:
+ *
+ *   dl_se::rq -- runqueue we belong to.
+ *
+ *   dl_se::server_has_tasks() -- used on bandwidth enforcement; we 'stop' the
+ *                                server when it runs out of tasks to run.
+ *
+ *   dl_se::server_pick() -- nested pick_next_task(); we yield the period if this
+ *                           returns NULL.
+ *
+ *   dl_server_update() -- called from update_curr_common(), propagates runtime
+ *                         to the server.
+ *
+ *   dl_server_start()
+ *   dl_server_stop()  -- start/stop the server when it has (no) tasks.
+ *
+ *   dl_server_init() -- initializes the server.
+ */
+extern void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec);
+extern void dl_server_start(struct sched_dl_entity *dl_se);
+extern void dl_server_stop(struct sched_dl_entity *dl_se);
+extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
+		    dl_server_has_tasks_f has_tasks,
+		    dl_server_pick_f pick);
+
 #ifdef CONFIG_CGROUP_SCHED
 
 struct cfs_rq;
