Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660757FF472
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjK3QNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjK3QNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:13:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26884197
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701360790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o/phfTUBezyckehvgP1ne0ESiIuzAdRoII/h/BrGy/Q=;
        b=dqhS6lBmnub69p1bdZvmcti85i9DjHHM8GyKMTue/cc0uc4+SL2enKELO6t9GwddByUZcZ
        HTY1GRzXwLlE7Vvx2t1no8T07xbQITrtVYuTKKqeQGmqg3K4EcYIGxLoffADsSdNfoMenc
        j3cJ4MmJJcAVCeB/GpkSTvcJP/2Ws3s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-fpRAe2hsPUiGw_cxFYIb-A-1; Thu, 30 Nov 2023 11:13:06 -0500
X-MC-Unique: fpRAe2hsPUiGw_cxFYIb-A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19ADF812C2C;
        Thu, 30 Nov 2023 16:13:06 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.195.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4121FC15881;
        Thu, 30 Nov 2023 16:13:03 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Tomas Glozar <tglozar@redhat.com>
Subject: [RFC PATCH 1/2] sched/fair: Only throttle CFS tasks on return to userspace
Date:   Thu, 30 Nov 2023 17:12:43 +0100
Message-ID: <20231130161245.3894682-2-vschneid@redhat.com>
In-Reply-To: <20231130161245.3894682-1-vschneid@redhat.com>
References: <20231130161245.3894682-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported in [1], CFS bandwidth throttling is a source of headaches in
PREEMPT_RT - generally speaking, a throttled CFS task can hold locks that
prevent ksoftirqd from running, which prevents replenishing & unthrottling
the cfs_rq of said CFS task.

Peter mentioned that there have been discussions on changing /when/ the
throttling happens: rather than have it be done immediately upon updating
the runtime statistics and realizing the cfs_rq has depleted its quota, we wait
for the task to be about to return to userspace.

I'm not aware of the arguments in favour of this for !PREEMPT_RT, but given [1]
I had a look into it. Using this approach means no task can be throttled while
holding a kernel lock, which solves the locking dependency issue.

Concept & headaches
===================

The original idea was:
o cfs_rq runs out of runtime, flag it
o Take the tasks out of the cfs_rq one by one as they exit the kernel
o Dequeue the cfs_rq once it is empty of tasks (as if doing "normal" throttling)
o Put the tasks back onto it
o At unthrottle, simply re-enqueue the cfs_rq sched_entity and all is well

Cgroup migration kinda breaks all of that. Consider a task moving to a
now-fully-throttled cfs_rq: if we just enqueue it onto the throttled se, then
it's the same as throttling it, and if it is holding a problematic lock then
we're back to square one.
This means we can never fully throttle a cfs_rq, which is making me not so
confident in this approach.

Should/can we consider deferring such migrations to the unthrottle (with
something like in affine_move_task())? I think failing the migration is not
an option due to e.g. autogroups, and IIUC returning from writing to
cgroup/tasks means the migration has happened (like updating a task's
affinity), which means this would need to be a blocking wait.

CPU migrations within the same taskgroup are similarly
problematic (e.g. moving from a cfs_rq that still has a bit of ->runtime
left to one that has run out).

Throttle clocks are also kinda busted in this approach, but they aren't my
greatest concern at this point :-)

Implementation
==============

cfs_rq's that deplete their ->runtime get flagged for later throttling via
->in_throttle_limbo, and this is propagated down the hierarchy.

Tasks enqueued in a cfs_rq with ->in_throttle_limbo picked for execution
get a task_work added, which lets the actual throttling happen in
exit_to_user_mode().

Upon unthrottling, tasks are enqueued back onto their respective
cfs_rq. Unlike the previous throttling implementation, cfs_rq's can be
unthrottled while in a half-throttled state (i.e. some tasks have been
removed from them, while others are still enqueued and runnable), so the
unthrottling process is a bit more involved.

[1]: https://lore.kernel.org/all/20231031160120.GE15024@noisy.programming.kicks-ass.net/
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/sched.h |   2 +
 kernel/sched/core.c   |   6 +-
 kernel/sched/debug.c  |   4 +-
 kernel/sched/fair.c   | 257 +++++++++++++++++++++++++++++++-----------
 kernel/sched/sched.h  |   7 ++
 5 files changed, 206 insertions(+), 70 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index e4235bbfad776..20194e4c8b0b5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -805,6 +805,8 @@ struct task_struct {
 
 #ifdef CONFIG_CGROUP_SCHED
 	struct task_group		*sched_task_group;
+	struct callback_head            sched_throttle_work;
+	struct list_head                throttle_node;
 #endif
 
 #ifdef CONFIG_UCLAMP_TASK
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7a0c16115b79f..a63152072554b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4504,6 +4504,10 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->se.cfs_rq			= NULL;
 #endif
 
+#ifdef CONFIG_CFS_BANDWIDTH
+	init_cfs_throttle_work(p);
+#endif
+
 #ifdef CONFIG_SCHEDSTATS
 	/* Even if schedstat is disabled, there should not be garbage */
 	memset(&p->stats, 0, sizeof(p->stats));
@@ -10823,7 +10827,7 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
 		cfs_rq->runtime_enabled = runtime_enabled;
 		cfs_rq->runtime_remaining = 0;
 
-		if (cfs_rq->throttled)
+		if (cfs_rq->in_throttle_limbo)
 			unthrottle_cfs_rq(cfs_rq);
 	}
 
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 4580a450700ec..8867904cf7eee 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -695,8 +695,8 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 #endif
 #endif
 #ifdef CONFIG_CFS_BANDWIDTH
-	SEQ_printf(m, "  .%-30s: %d\n", "throttled",
-			cfs_rq->throttled);
+	SEQ_printf(m, "  .%-30s: %d\n", "in_throttle_limbo",
+			cfs_rq->in_throttle_limbo);
 	SEQ_printf(m, "  .%-30s: %d\n", "throttle_count",
 			cfs_rq->throttle_count);
 #endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8767988242ee3..27aee13e7ccd9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5497,7 +5497,7 @@ static void __account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
 	if (likely(cfs_rq->runtime_remaining > 0))
 		return;
 
-	if (cfs_rq->throttled)
+	if (cfs_rq->throttled || cfs_rq->in_throttle_limbo)
 		return;
 	/*
 	 * if we're unable to extend our runtime we resched so that the active
@@ -5548,7 +5548,61 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 {
 	struct rq *rq = data;
 	struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
+	struct sched_entity *se = tg->se[cpu_of(rq)];
+	struct cfs_rq *pcfs_rq = cfs_rq_of(se);
+	long task_delta = 0, idle_task_delta = 0;
+	struct task_struct *p, *tmp;
 
+	/*
+	 * Re-enqueue the tasks that have been throttled at this level.
+	 *
+	 * The task count is up-propagated via ->unthrottled_*h_nr_running,
+	 * as we can't purely rely on h_nr_running post-enqueue: the unthrottle
+	 * might happen when a cfs_rq still has some tasks enqueued, either still
+	 * making their way to userspace, or freshly migrated to it.
+	 */
+	list_for_each_entry_safe(p, tmp, &cfs_rq->throttled_limbo_list, throttle_node) {
+		struct sched_entity *pse = &p->se;
+
+		list_del_init(&p->throttle_node);
+		enqueue_entity(cfs_rq, pse, ENQUEUE_WAKEUP);
+		task_delta++;
+		idle_task_delta += task_has_idle_policy(p);
+	}
+
+	/*
+	 * Account tasks woken up in children; by this point all direct children
+	 * have been visited.
+	 */
+	task_delta += cfs_rq->unthrottled_h_nr_running;
+	idle_task_delta += cfs_rq->unthrottled_idle_h_nr_running;
+
+	/*
+	 * unthrottle_cfs_rq() needs a value to up-propagate above the
+	 * freshly unthrottled cfs_rq.
+	 */
+	cfs_rq->unthrottled_h_nr_running = task_delta;
+	cfs_rq->unthrottled_idle_h_nr_running = idle_task_delta;
+
+	cfs_rq->h_nr_running += task_delta;
+	cfs_rq->idle_h_nr_running += idle_task_delta;
+
+	/* Accumulate the delta in the parent's stash. Once all its children
+	 * (i.e. all of this cfs_rq's siblings) have been visited, this value
+	 * will be stable and used for its own count update.
+	 */
+	pcfs_rq->unthrottled_h_nr_running += task_delta;
+	pcfs_rq->unthrottled_idle_h_nr_running += idle_task_delta;
+
+	/*
+	 * If the cfs_rq became empty during throttling, then we dequeued
+	 * it. It needs to be put back in the hierarchy if it or any of
+	 * its children have now-unthrottled tasks.
+	 */
+	if (!se->on_rq && (task_delta || idle_task_delta))
+		enqueue_entity(pcfs_rq, se, ENQUEUE_WAKEUP);
+
+	cfs_rq->in_throttle_limbo = false;
 	cfs_rq->throttle_count--;
 	if (!cfs_rq->throttle_count) {
 		cfs_rq->throttled_clock_pelt_time += rq_clock_pelt(rq) -
@@ -5573,6 +5627,17 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 	return 0;
 }
 
+static int tg_unthrottle_clear_up(struct task_group *tg, void *data)
+{
+	struct rq *rq = data;
+	struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
+
+	cfs_rq->unthrottled_h_nr_running = 0;
+	cfs_rq->unthrottled_idle_h_nr_running = 0;
+
+	return 0;
+}
+
 static int tg_throttle_down(struct task_group *tg, void *data)
 {
 	struct rq *rq = data;
@@ -5588,61 +5653,59 @@ static int tg_throttle_down(struct task_group *tg, void *data)
 			cfs_rq->throttled_clock_self = rq_clock(rq);
 	}
 	cfs_rq->throttle_count++;
+	cfs_rq->in_throttle_limbo = true;
 
 	return 0;
 }
 
-static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
+static void throttle_cfs_rq_work(struct callback_head *work)
 {
-	struct rq *rq = rq_of(cfs_rq);
-	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
+	struct task_struct *p = container_of(work, struct task_struct, sched_throttle_work);
 	struct sched_entity *se;
-	long task_delta, idle_task_delta, dequeue = 1;
+	struct rq *rq;
+	struct cfs_rq *qcfs_rq, *top_cfs_rq;
+	long task_delta, idle_task_delta;
 
-	raw_spin_lock(&cfs_b->lock);
-	/* This will start the period timer if necessary */
-	if (__assign_cfs_rq_runtime(cfs_b, cfs_rq, 1)) {
-		/*
-		 * We have raced with bandwidth becoming available, and if we
-		 * actually throttled the timer might not unthrottle us for an
-		 * entire period. We additionally needed to make sure that any
-		 * subsequent check_cfs_rq_runtime calls agree not to throttle
-		 * us, as we may commit to do cfs put_prev+pick_next, so we ask
-		 * for 1ns of runtime rather than just check cfs_b.
-		 */
-		dequeue = 0;
-	} else {
-		list_add_tail_rcu(&cfs_rq->throttled_list,
-				  &cfs_b->throttled_cfs_rq);
-	}
-	raw_spin_unlock(&cfs_b->lock);
+	WARN_ON_ONCE(p != current);
 
-	if (!dequeue)
-		return false;  /* Throttle no longer required. */
+	/*
+	 * If task is exiting, then there won't be a return to userspace, so we
+	 * don't have to bother with any of this.
+	 */
+	if ((p->flags & PF_EXITING))
+		return;
 
-	se = cfs_rq->tg->se[cpu_of(rq_of(cfs_rq))];
+	CLASS(task_rq_lock, rq_guard)(p);
+	rq = rq_guard.rq;
+	se = &p->se;
+	qcfs_rq = cfs_rq_of(se);
 
-	/* freeze hierarchy runnable averages while throttled */
-	rcu_read_lock();
-	walk_tg_tree_from(cfs_rq->tg, tg_throttle_down, tg_nop, (void *)rq);
-	rcu_read_unlock();
+	/*
+	 * If not in limbo, then either replenish has happened or this task got
+	 * migrated out of the throttled cfs_rq, move along
+	 */
+	if (!qcfs_rq->in_throttle_limbo)
+		goto done;
+
+	update_rq_clock(rq);
+
+	list_add(&p->throttle_node, &qcfs_rq->throttled_limbo_list);
+	task_delta = 1;
+	idle_task_delta = cfs_rq_is_idle(qcfs_rq) ? 1 : 0;
 
-	task_delta = cfs_rq->h_nr_running;
-	idle_task_delta = cfs_rq->idle_h_nr_running;
 	for_each_sched_entity(se) {
-		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
-		/* throttled entity or throttle-on-deactivate */
+		qcfs_rq = cfs_rq_of(se);
+
 		if (!se->on_rq)
 			goto done;
 
 		dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
-
-		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_running;
-
 		qcfs_rq->h_nr_running -= task_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
 
+		if (qcfs_rq->in_throttle_limbo)
+			top_cfs_rq = qcfs_rq;
+
 		if (qcfs_rq->load.weight) {
 			/* Avoid re-evaluating load for this entity: */
 			se = parent_entity(se);
@@ -5651,34 +5714,84 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	}
 
 	for_each_sched_entity(se) {
-		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
+		qcfs_rq = cfs_rq_of(se);
 		/* throttled entity or throttle-on-deactivate */
 		if (!se->on_rq)
-			goto done;
+			goto throttle_done;
 
 		update_load_avg(qcfs_rq, se, 0);
 		se_update_runnable(se);
-
-		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_running;
-
 		qcfs_rq->h_nr_running -= task_delta;
-		qcfs_rq->idle_h_nr_running -= idle_task_delta;
+		qcfs_rq->h_nr_running -= idle_task_delta;
 	}
 
+throttle_done:
 	/* At this point se is NULL and we are at root level*/
-	sub_nr_running(rq, task_delta);
-
+	sub_nr_running(rq, 1);
 done:
+	p->sched_throttle_work.next = &p->sched_throttle_work;
 	/*
-	 * Note: distribution will already see us throttled via the
-	 * throttled-list.  rq->lock protects completion.
+	 * XXX: this assumes the highest in_throttle_limbo cfs_rq in the
+	 * hierarchy is the one which got throttled, which might not always
+	 * be the case.
 	 */
-	cfs_rq->throttled = 1;
-	SCHED_WARN_ON(cfs_rq->throttled_clock);
-	if (cfs_rq->nr_running)
-		cfs_rq->throttled_clock = rq_clock(rq);
-	return true;
+	if (top_cfs_rq && !top_cfs_rq->throttled_clock)
+		top_cfs_rq->throttled_clock = rq_clock(rq);
+
+	resched_curr(rq);
+}
+
+void init_cfs_throttle_work(struct task_struct *p)
+{
+	/* Protect against double add, see throttle_cfs_rq() and throttle_cfs_rq_work() */
+	p->sched_throttle_work.next = &p->sched_throttle_work;
+	init_task_work(&p->sched_throttle_work, throttle_cfs_rq_work);
+}
+
+static inline bool task_has_throttle_work(struct task_struct *p)
+{
+	return p->sched_throttle_work.next != &p->sched_throttle_work;
+}
+
+static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
+{
+	struct rq *rq = rq_of(cfs_rq);
+	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
+	long dequeue = 1;
+
+	if (cfs_rq->in_throttle_limbo)
+		return false;
+
+	raw_spin_lock(&cfs_b->lock);
+	/* This will start the period timer if necessary */
+	if (__assign_cfs_rq_runtime(cfs_b, cfs_rq, 1)) {
+		/*
+		 * We have raced with bandwidth becoming available, and if we
+		 * actually throttled the timer might not unthrottle us for an
+		 * entire period. We additionally needed to make sure that any
+		 * subsequent check_cfs_rq_runtime calls agree not to throttle
+		 * us, as we may commit to do cfs put_prev+pick_next, so we ask
+		 * for 1ns of runtime rather than just check cfs_b.
+		 */
+		dequeue = 0;
+	} else {
+		list_add_tail_rcu(&cfs_rq->throttled_list,
+				  &cfs_b->throttled_cfs_rq);
+	}
+
+	raw_spin_unlock(&cfs_b->lock);
+
+	if (!dequeue)
+		return false;  /* Throttle no longer required. */
+
+	rcu_read_lock();
+	walk_tg_tree_from(cfs_rq->tg, tg_throttle_down, tg_nop, (void *)rq);
+	rcu_read_unlock();
+
+	if (!task_has_throttle_work(current))
+		task_work_add(current, &current->sched_throttle_work, TWA_RESUME);
+
+	return false;
 }
 
 void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
@@ -5690,8 +5803,6 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
 
-	cfs_rq->throttled = 0;
-
 	update_rq_clock(rq);
 
 	raw_spin_lock(&cfs_b->lock);
@@ -5719,8 +5830,15 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		goto unthrottle_throttle;
 	}
 
-	task_delta = cfs_rq->h_nr_running;
-	idle_task_delta = cfs_rq->idle_h_nr_running;
+	/*
+	 * cfs_rq's below us may not have been fully emptied out, so we can't rely
+	 * directly on ->h_nr_running. Use the stash instead.
+	 */
+	task_delta = cfs_rq->unthrottled_h_nr_running;
+	idle_task_delta = cfs_rq->unthrottled_idle_h_nr_running;
+
+	walk_tg_tree_from(cfs_rq->tg, tg_nop, tg_unthrottle_clear_up, (void *)rq);
+
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 
@@ -5728,9 +5846,6 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 			break;
 		enqueue_entity(qcfs_rq, se, ENQUEUE_WAKEUP);
 
-		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_running;
-
 		qcfs_rq->h_nr_running += task_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
 
@@ -5745,9 +5860,6 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		update_load_avg(qcfs_rq, se, UPDATE_TG);
 		se_update_runnable(se);
 
-		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_running;
-
 		qcfs_rq->h_nr_running += task_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
 
@@ -5797,7 +5909,7 @@ static void __cfsb_csd_unthrottle(void *arg)
 				 throttled_csd_list) {
 		list_del_init(&cursor->throttled_csd_list);
 
-		if (cfs_rq_throttled(cursor))
+		if (cfs_rq_throttled(cursor) || cursor->in_throttle_limbo)
 			unthrottle_cfs_rq(cursor);
 	}
 
@@ -5837,7 +5949,7 @@ static void unthrottle_cfs_rq_async(struct cfs_rq *cfs_rq)
 {
 	lockdep_assert_rq_held(rq_of(cfs_rq));
 
-	if (SCHED_WARN_ON(!cfs_rq_throttled(cfs_rq) ||
+	if (SCHED_WARN_ON(!(cfs_rq_throttled(cfs_rq) || cfs_rq->in_throttle_limbo) ||
 	    cfs_rq->runtime_remaining <= 0))
 		return;
 
@@ -5865,7 +5977,12 @@ static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 		}
 
 		rq_lock_irqsave(rq, &rf);
-		if (!cfs_rq_throttled(cfs_rq))
+		/*
+		 * A cfs_rq can be in_throttle_limbo but not throttled if it is
+		 * waiting for tasks to exit the kernel. In this case we still
+		 * want to replenish.
+		 */
+		if (!cfs_rq_throttled(cfs_rq) && !cfs_rq->in_throttle_limbo)
 			goto next;
 
 		/* Already queued for async unthrottle */
@@ -5914,7 +6031,7 @@ static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 
 		list_del_init(&cfs_rq->throttled_csd_list);
 
-		if (cfs_rq_throttled(cfs_rq))
+		if (cfs_rq_throttled(cfs_rq) || cfs_rq->in_throttle_limbo)
 			unthrottle_cfs_rq(cfs_rq);
 
 		rq_unlock_irqrestore(rq, &rf);
@@ -6252,6 +6369,7 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 	cfs_rq->runtime_enabled = 0;
 	INIT_LIST_HEAD(&cfs_rq->throttled_list);
 	INIT_LIST_HEAD(&cfs_rq->throttled_csd_list);
+	INIT_LIST_HEAD(&cfs_rq->throttled_limbo_list);
 }
 
 void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
@@ -8274,6 +8392,8 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 
 	p = task_of(se);
 
+	if (unlikely(cfs_rq_of(se)->in_throttle_limbo && !task_has_throttle_work(p)))
+		task_work_add(p, &p->sched_throttle_work, TWA_RESUME);
 	/*
 	 * Since we haven't yet done put_prev_entity and if the selected task
 	 * is a different task than we started out with, try and touch the
@@ -8314,6 +8434,9 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 
 	p = task_of(se);
 
+	if (unlikely(cfs_rq_of(se)->in_throttle_limbo && !task_has_throttle_work(p)))
+		task_work_add(p, &p->sched_throttle_work, TWA_RESUME);
+
 done: __maybe_unused;
 #ifdef CONFIG_SMP
 	/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2e5a95486a422..be29154d93898 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -633,8 +633,13 @@ struct cfs_rq {
 	u64			throttled_clock_self_time;
 	int			throttled;
 	int			throttle_count;
+	int                     in_throttle_limbo;
+	/* Temp storage for updating the counts during unthrottling */
+	unsigned int            unthrottled_h_nr_running;
+	unsigned int            unthrottled_idle_h_nr_running;
 	struct list_head	throttled_list;
 	struct list_head	throttled_csd_list;
+	struct list_head	throttled_limbo_list;
 #endif /* CONFIG_CFS_BANDWIDTH */
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 };
@@ -2416,6 +2421,8 @@ extern void init_sched_dl_class(void);
 extern void init_sched_rt_class(void);
 extern void init_sched_fair_class(void);
 
+extern void init_cfs_throttle_work(struct task_struct *p);
+
 extern void reweight_task(struct task_struct *p, int prio);
 
 extern void resched_curr(struct rq *rq);
-- 
2.41.0

