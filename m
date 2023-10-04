Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F5D7B7B13
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241928AbjJDJGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241942AbjJDJFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:05:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD0C0DC
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 02:05:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15C50152B;
        Wed,  4 Oct 2023 02:06:19 -0700 (PDT)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FFA73F59C;
        Wed,  4 Oct 2023 02:05:38 -0700 (PDT)
From:   Hongyan Xia <Hongyan.Xia2@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Qais Yousef <qyousef@layalina.io>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Christian Loehle <christian.loehle@arm.com>,
        linux-kernel@vger.kernel.org, Hongyan Xia <hongyan.xia2@arm.com>
Subject: [RFC PATCH 5/6] sched/uclamp: Remove all uclamp bucket logic
Date:   Wed,  4 Oct 2023 10:04:53 +0100
Message-Id: <48fcea0a9bb2d2212c575032e64ab717756dc0fa.1696345700.git.Hongyan.Xia2@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696345700.git.Hongyan.Xia2@arm.com>
References: <cover.1696345700.git.Hongyan.Xia2@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hongyan Xia <hongyan.xia2@arm.com>

Also rewrite uclamp_update_active() so that the effective uclamp values
are updated every time we change task group properties, change system
defaults or a request is issued from userspace.

TODO: Rewrite documentation to match the new logic.

Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
---
 include/linux/sched.h |   4 -
 init/Kconfig          |  32 -----
 kernel/sched/core.c   | 295 +++---------------------------------------
 kernel/sched/fair.c   |   4 -
 kernel/sched/rt.c     |   4 -
 kernel/sched/sched.h  |  85 ------------
 6 files changed, 16 insertions(+), 408 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 825d7b86b006..5b8d5abb2bba 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -685,9 +685,6 @@ struct sched_dl_entity {
 };
 
 #ifdef CONFIG_UCLAMP_TASK
-/* Number of utilization clamp buckets (shorter alias) */
-#define UCLAMP_BUCKETS CONFIG_UCLAMP_BUCKETS_COUNT
-
 /*
  * Utilization clamp for a scheduling entity
  * @value:		clamp value "assigned" to a se
@@ -713,7 +710,6 @@ struct sched_dl_entity {
  */
 struct uclamp_se {
 	unsigned int value		: bits_per(SCHED_CAPACITY_SCALE);
-	unsigned int bucket_id		: bits_per(UCLAMP_BUCKETS);
 	unsigned int active		: 1;
 	unsigned int user_defined	: 1;
 };
diff --git a/init/Kconfig b/init/Kconfig
index 5e7d4885d1bf..4ec0023d2149 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -808,38 +808,6 @@ config UCLAMP_TASK
 	  enforce or grant any specific bandwidth for tasks.
 
 	  If in doubt, say N.
-
-config UCLAMP_BUCKETS_COUNT
-	int "Number of supported utilization clamp buckets"
-	range 5 20
-	default 5
-	depends on UCLAMP_TASK
-	help
-	  Defines the number of clamp buckets to use. The range of each bucket
-	  will be SCHED_CAPACITY_SCALE/UCLAMP_BUCKETS_COUNT. The higher the
-	  number of clamp buckets the finer their granularity and the higher
-	  the precision of clamping aggregation and tracking at run-time.
-
-	  For example, with the minimum configuration value we will have 5
-	  clamp buckets tracking 20% utilization each. A 25% boosted tasks will
-	  be refcounted in the [20..39]% bucket and will set the bucket clamp
-	  effective value to 25%.
-	  If a second 30% boosted task should be co-scheduled on the same CPU,
-	  that task will be refcounted in the same bucket of the first task and
-	  it will boost the bucket clamp effective value to 30%.
-	  The clamp effective value of a bucket is reset to its nominal value
-	  (20% in the example above) when there are no more tasks refcounted in
-	  that bucket.
-
-	  An additional boost/capping margin can be added to some tasks. In the
-	  example above the 25% task will be boosted to 30% until it exits the
-	  CPU. If that should be considered not acceptable on certain systems,
-	  it's always possible to reduce the margin by increasing the number of
-	  clamp buckets to trade off used memory for run-time tracking
-	  precision.
-
-	  If in doubt, use the default value.
-
 endmenu
 
 #
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 32511ee63f01..c5bf01e7df28 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1387,17 +1387,9 @@ static struct uclamp_se uclamp_default[UCLAMP_CNT];
  */
 DEFINE_STATIC_KEY_FALSE(sched_uclamp_used);
 
-/* Integer rounded range for each bucket */
-#define UCLAMP_BUCKET_DELTA DIV_ROUND_CLOSEST(SCHED_CAPACITY_SCALE, UCLAMP_BUCKETS)
-
 #define for_each_clamp_id(clamp_id) \
 	for ((clamp_id) = 0; (clamp_id) < UCLAMP_CNT; (clamp_id)++)
 
-static inline unsigned int uclamp_bucket_id(unsigned int clamp_value)
-{
-	return min_t(unsigned int, clamp_value / UCLAMP_BUCKET_DELTA, UCLAMP_BUCKETS - 1);
-}
-
 static inline unsigned int uclamp_none(enum uclamp_id clamp_id)
 {
 	if (clamp_id == UCLAMP_MIN)
@@ -1409,58 +1401,9 @@ static inline void uclamp_se_set(struct uclamp_se *uc_se,
 				 unsigned int value, bool user_defined)
 {
 	uc_se->value = value;
-	uc_se->bucket_id = uclamp_bucket_id(value);
 	uc_se->user_defined = user_defined;
 }
 
-static inline unsigned int
-uclamp_idle_value(struct rq *rq, enum uclamp_id clamp_id,
-		  unsigned int clamp_value)
-{
-	/*
-	 * Avoid blocked utilization pushing up the frequency when we go
-	 * idle (which drops the max-clamp) by retaining the last known
-	 * max-clamp.
-	 */
-	if (clamp_id == UCLAMP_MAX) {
-		rq->uclamp_flags |= UCLAMP_FLAG_IDLE;
-		return clamp_value;
-	}
-
-	return uclamp_none(UCLAMP_MIN);
-}
-
-static inline void uclamp_idle_reset(struct rq *rq, enum uclamp_id clamp_id,
-				     unsigned int clamp_value)
-{
-	/* Reset max-clamp retention only on idle exit */
-	if (!(rq->uclamp_flags & UCLAMP_FLAG_IDLE))
-		return;
-
-	uclamp_rq_set(rq, clamp_id, clamp_value);
-}
-
-static inline
-unsigned int uclamp_rq_max_value(struct rq *rq, enum uclamp_id clamp_id,
-				   unsigned int clamp_value)
-{
-	struct uclamp_bucket *bucket = rq->uclamp[clamp_id].bucket;
-	int bucket_id = UCLAMP_BUCKETS - 1;
-
-	/*
-	 * Since both min and max clamps are max aggregated, find the
-	 * top most bucket with tasks in.
-	 */
-	for ( ; bucket_id >= 0; bucket_id--) {
-		if (!bucket[bucket_id].tasks)
-			continue;
-		return bucket[bucket_id].value;
-	}
-
-	/* No tasks -- default clamp values */
-	return uclamp_idle_value(rq, clamp_id, clamp_value);
-}
-
 static void __uclamp_update_util_min_rt_default(struct task_struct *p)
 {
 	unsigned int default_util_min;
@@ -1542,196 +1485,24 @@ uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
 
 unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
 {
-	struct uclamp_se uc_eff;
-
-	/* Task currently refcounted: use back-annotated (effective) value */
-	if (p->uclamp[clamp_id].active)
-		return (unsigned long)p->uclamp[clamp_id].value;
-
-	uc_eff = uclamp_eff_get(p, clamp_id);
-
-	return (unsigned long)uc_eff.value;
-}
-
-/*
- * When a task is enqueued on a rq, the clamp bucket currently defined by the
- * task's uclamp::bucket_id is refcounted on that rq. This also immediately
- * updates the rq's clamp value if required.
- *
- * Tasks can have a task-specific value requested from user-space, track
- * within each bucket the maximum value for tasks refcounted in it.
- * This "local max aggregation" allows to track the exact "requested" value
- * for each bucket when all its RUNNABLE tasks require the same clamp.
- */
-static inline void uclamp_rq_inc_id(struct rq *rq, struct task_struct *p,
-				    enum uclamp_id clamp_id)
-{
-	struct uclamp_rq *uc_rq = &rq->uclamp[clamp_id];
-	struct uclamp_se *uc_se = &p->uclamp[clamp_id];
-	struct uclamp_bucket *bucket;
-
-	lockdep_assert_rq_held(rq);
+	if (!uclamp_is_used() || !p->uclamp[clamp_id].active)
+		return uclamp_none(clamp_id);
 
-	/* Update task effective clamp */
-	p->uclamp[clamp_id] = uclamp_eff_get(p, clamp_id);
-
-	bucket = &uc_rq->bucket[uc_se->bucket_id];
-	bucket->tasks++;
-	uc_se->active = true;
-
-	uclamp_idle_reset(rq, clamp_id, uc_se->value);
-
-	/*
-	 * Local max aggregation: rq buckets always track the max
-	 * "requested" clamp value of its RUNNABLE tasks.
-	 */
-	if (bucket->tasks == 1 || uc_se->value > bucket->value)
-		bucket->value = uc_se->value;
-
-	if (uc_se->value > uclamp_rq_get(rq, clamp_id))
-		uclamp_rq_set(rq, clamp_id, uc_se->value);
+	return p->uclamp[clamp_id].value;
 }
 
-/*
- * When a task is dequeued from a rq, the clamp bucket refcounted by the task
- * is released. If this is the last task reference counting the rq's max
- * active clamp value, then the rq's clamp value is updated.
- *
- * Both refcounted tasks and rq's cached clamp values are expected to be
- * always valid. If it's detected they are not, as defensive programming,
- * enforce the expected state and warn.
- */
-static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
-				    enum uclamp_id clamp_id)
-{
-	struct uclamp_rq *uc_rq = &rq->uclamp[clamp_id];
-	struct uclamp_se *uc_se = &p->uclamp[clamp_id];
-	struct uclamp_bucket *bucket;
-	unsigned int bkt_clamp;
-	unsigned int rq_clamp;
-
-	lockdep_assert_rq_held(rq);
-
-	/*
-	 * If sched_uclamp_used was enabled after task @p was enqueued,
-	 * we could end up with unbalanced call to uclamp_rq_dec_id().
-	 *
-	 * In this case the uc_se->active flag should be false since no uclamp
-	 * accounting was performed at enqueue time and we can just return
-	 * here.
-	 *
-	 * Need to be careful of the following enqueue/dequeue ordering
-	 * problem too
-	 *
-	 *	enqueue(taskA)
-	 *	// sched_uclamp_used gets enabled
-	 *	enqueue(taskB)
-	 *	dequeue(taskA)
-	 *	// Must not decrement bucket->tasks here
-	 *	dequeue(taskB)
-	 *
-	 * where we could end up with stale data in uc_se and
-	 * bucket[uc_se->bucket_id].
-	 *
-	 * The following check here eliminates the possibility of such race.
-	 */
-	if (unlikely(!uc_se->active))
-		return;
-
-	bucket = &uc_rq->bucket[uc_se->bucket_id];
-
-	SCHED_WARN_ON(!bucket->tasks);
-	if (likely(bucket->tasks))
-		bucket->tasks--;
-
-	uc_se->active = false;
-
-	/*
-	 * Keep "local max aggregation" simple and accept to (possibly)
-	 * overboost some RUNNABLE tasks in the same bucket.
-	 * The rq clamp bucket value is reset to its base value whenever
-	 * there are no more RUNNABLE tasks refcounting it.
-	 */
-	if (likely(bucket->tasks))
-		return;
-
-	rq_clamp = uclamp_rq_get(rq, clamp_id);
-	/*
-	 * Defensive programming: this should never happen. If it happens,
-	 * e.g. due to future modification, warn and fixup the expected value.
-	 */
-	SCHED_WARN_ON(bucket->value > rq_clamp);
-	if (bucket->value >= rq_clamp) {
-		bkt_clamp = uclamp_rq_max_value(rq, clamp_id, uc_se->value);
-		uclamp_rq_set(rq, clamp_id, bkt_clamp);
-	}
-}
-
-static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
-{
-	enum uclamp_id clamp_id;
-
-	/*
-	 * Avoid any overhead until uclamp is actually used by the userspace.
-	 *
-	 * The condition is constructed such that a NOP is generated when
-	 * sched_uclamp_used is disabled.
-	 */
-	if (!static_branch_unlikely(&sched_uclamp_used))
-		return;
-
-	if (unlikely(!p->sched_class->uclamp_enabled))
-		return;
-
-	for_each_clamp_id(clamp_id)
-		uclamp_rq_inc_id(rq, p, clamp_id);
-
-	/* Reset clamp idle holding when there is one RUNNABLE task */
-	if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
-		rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
-}
-
-static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
+static inline void
+uclamp_update_active_nolock(struct task_struct *p)
 {
 	enum uclamp_id clamp_id;
 
-	/*
-	 * Avoid any overhead until uclamp is actually used by the userspace.
-	 *
-	 * The condition is constructed such that a NOP is generated when
-	 * sched_uclamp_used is disabled.
-	 */
-	if (!static_branch_unlikely(&sched_uclamp_used))
-		return;
-
-	if (unlikely(!p->sched_class->uclamp_enabled))
-		return;
-
 	for_each_clamp_id(clamp_id)
-		uclamp_rq_dec_id(rq, p, clamp_id);
-}
-
-static inline void uclamp_rq_reinc_id(struct rq *rq, struct task_struct *p,
-				      enum uclamp_id clamp_id)
-{
-	if (!p->uclamp[clamp_id].active)
-		return;
-
-	uclamp_rq_dec_id(rq, p, clamp_id);
-	uclamp_rq_inc_id(rq, p, clamp_id);
-
-	/*
-	 * Make sure to clear the idle flag if we've transiently reached 0
-	 * active tasks on rq.
-	 */
-	if (clamp_id == UCLAMP_MAX && (rq->uclamp_flags & UCLAMP_FLAG_IDLE))
-		rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
+		p->uclamp[clamp_id] = uclamp_eff_get(p, clamp_id);
 }
 
 static inline void
 uclamp_update_active(struct task_struct *p)
 {
-	enum uclamp_id clamp_id;
 	struct rq_flags rf;
 	struct rq *rq;
 
@@ -1745,14 +1516,7 @@ uclamp_update_active(struct task_struct *p)
 	 */
 	rq = task_rq_lock(p, &rf);
 
-	/*
-	 * Setting the clamp bucket is serialized by task_rq_lock().
-	 * If the task is not yet RUNNABLE and its task_struct is not
-	 * affecting a valid clamp bucket, the next time it's enqueued,
-	 * it will already see the updated clamp bucket value.
-	 */
-	for_each_clamp_id(clamp_id)
-		uclamp_rq_reinc_id(rq, p, clamp_id);
+	uclamp_update_active_nolock(p);
 
 	task_rq_unlock(rq, p, &rf);
 }
@@ -1983,26 +1747,22 @@ static void __setscheduler_uclamp(struct task_struct *p,
 		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
 			      attr->sched_util_max, true);
 	}
+
+	uclamp_update_active_nolock(p);
 }
 
 static void uclamp_fork(struct task_struct *p)
 {
 	enum uclamp_id clamp_id;
 
-	/*
-	 * We don't need to hold task_rq_lock() when updating p->uclamp_* here
-	 * as the task is still at its early fork stages.
-	 */
-	for_each_clamp_id(clamp_id)
-		p->uclamp[clamp_id].active = false;
-
-	if (likely(!p->sched_reset_on_fork))
-		return;
-
-	for_each_clamp_id(clamp_id) {
-		uclamp_se_set(&p->uclamp_req[clamp_id],
-			      uclamp_none(clamp_id), false);
+	if (unlikely(p->sched_reset_on_fork)) {
+		for_each_clamp_id(clamp_id) {
+			uclamp_se_set(&p->uclamp_req[clamp_id],
+				      uclamp_none(clamp_id), false);
+		}
 	}
+
+	uclamp_update_active(p);
 }
 
 static void uclamp_post_fork(struct task_struct *p)
@@ -2010,28 +1770,10 @@ static void uclamp_post_fork(struct task_struct *p)
 	uclamp_update_util_min_rt_default(p);
 }
 
-static void __init init_uclamp_rq(struct rq *rq)
-{
-	enum uclamp_id clamp_id;
-	struct uclamp_rq *uc_rq = rq->uclamp;
-
-	for_each_clamp_id(clamp_id) {
-		uc_rq[clamp_id] = (struct uclamp_rq) {
-			.value = uclamp_none(clamp_id)
-		};
-	}
-
-	rq->uclamp_flags = UCLAMP_FLAG_IDLE;
-}
-
 static void __init init_uclamp(void)
 {
 	struct uclamp_se uc_max = {};
 	enum uclamp_id clamp_id;
-	int cpu;
-
-	for_each_possible_cpu(cpu)
-		init_uclamp_rq(cpu_rq(cpu));
 
 	for_each_clamp_id(clamp_id) {
 		uclamp_se_set(&init_task.uclamp_req[clamp_id],
@@ -2050,8 +1792,6 @@ static void __init init_uclamp(void)
 }
 
 #else /* CONFIG_UCLAMP_TASK */
-static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p) { }
-static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p) { }
 static inline int uclamp_validate(struct task_struct *p,
 				  const struct sched_attr *attr)
 {
@@ -2098,7 +1838,6 @@ static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 		psi_enqueue(p, (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED));
 	}
 
-	uclamp_rq_inc(rq, p);
 	p->sched_class->enqueue_task(rq, p, flags);
 
 	if (sched_core_enabled(rq))
@@ -2118,7 +1857,6 @@ static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 		psi_dequeue(p, flags & DEQUEUE_SLEEP);
 	}
 
-	uclamp_rq_dec(rq, p);
 	p->sched_class->dequeue_task(rq, p, flags);
 }
 
@@ -10659,7 +10397,6 @@ static void cpu_util_update_eff(struct cgroup_subsys_state *css)
 			if (eff[clamp_id] == uc_se[clamp_id].value)
 				continue;
 			uc_se[clamp_id].value = eff[clamp_id];
-			uc_se[clamp_id].bucket_id = uclamp_bucket_id(eff[clamp_id]);
 			clamps |= (0x1 << clamp_id);
 		}
 		if (!clamps) {
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 75a8f7d50e9c..bfe01f534a21 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12708,10 +12708,6 @@ DEFINE_SCHED_CLASS(fair) = {
 #ifdef CONFIG_SCHED_CORE
 	.task_is_throttled	= task_is_throttled_fair,
 #endif
-
-#ifdef CONFIG_UCLAMP_TASK
-	.uclamp_enabled		= 1,
-#endif
 };
 
 #ifdef CONFIG_SCHED_DEBUG
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 0597ba0f85ff..68f257150c16 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2732,10 +2732,6 @@ DEFINE_SCHED_CLASS(rt) = {
 #ifdef CONFIG_SCHED_CORE
 	.task_is_throttled	= task_is_throttled_rt,
 #endif
-
-#ifdef CONFIG_UCLAMP_TASK
-	.uclamp_enabled		= 1,
-#endif
 };
 
 #ifdef CONFIG_RT_GROUP_SCHED
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e73aedd9a76b..30dee8eb2ed9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -903,46 +903,6 @@ extern void rto_push_irq_work_func(struct irq_work *work);
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_UCLAMP_TASK
-/*
- * struct uclamp_bucket - Utilization clamp bucket
- * @value: utilization clamp value for tasks on this clamp bucket
- * @tasks: number of RUNNABLE tasks on this clamp bucket
- *
- * Keep track of how many tasks are RUNNABLE for a given utilization
- * clamp value.
- */
-struct uclamp_bucket {
-	unsigned long value : bits_per(SCHED_CAPACITY_SCALE);
-	unsigned long tasks : BITS_PER_LONG - bits_per(SCHED_CAPACITY_SCALE);
-};
-
-/*
- * struct uclamp_rq - rq's utilization clamp
- * @value: currently active clamp values for a rq
- * @bucket: utilization clamp buckets affecting a rq
- *
- * Keep track of RUNNABLE tasks on a rq to aggregate their clamp values.
- * A clamp value is affecting a rq when there is at least one task RUNNABLE
- * (or actually running) with that value.
- *
- * There are up to UCLAMP_CNT possible different clamp values, currently there
- * are only two: minimum utilization and maximum utilization.
- *
- * All utilization clamping values are MAX aggregated, since:
- * - for util_min: we want to run the CPU at least at the max of the minimum
- *   utilization required by its currently RUNNABLE tasks.
- * - for util_max: we want to allow the CPU to run up to the max of the
- *   maximum utilization allowed by its currently RUNNABLE tasks.
- *
- * Since on each system we expect only a limited number of different
- * utilization clamp values (UCLAMP_BUCKETS), use a simple array to track
- * the metrics required to compute all the per-rq utilization clamp values.
- */
-struct uclamp_rq {
-	unsigned int value;
-	struct uclamp_bucket bucket[UCLAMP_BUCKETS];
-};
-
 DECLARE_STATIC_KEY_FALSE(sched_uclamp_used);
 #endif /* CONFIG_UCLAMP_TASK */
 
@@ -989,12 +949,8 @@ struct rq {
 	u64			nr_switches;
 
 #ifdef CONFIG_UCLAMP_TASK
-	/* Utilization clamp values based on CPU's RUNNABLE tasks */
-	struct uclamp_rq	uclamp[UCLAMP_CNT] ____cacheline_aligned;
-	unsigned int		uclamp_flags;
 	unsigned int		root_cfs_util_uclamp;
 	unsigned int		root_cfs_util_uclamp_removed;
-#define UCLAMP_FLAG_IDLE 0x01
 #endif
 
 	struct cfs_rq		cfs;
@@ -2229,11 +2185,6 @@ struct affinity_context {
 };
 
 struct sched_class {
-
-#ifdef CONFIG_UCLAMP_TASK
-	int uclamp_enabled;
-#endif
-
 	void (*enqueue_task) (struct rq *rq, struct task_struct *p, int flags);
 	void (*dequeue_task) (struct rq *rq, struct task_struct *p, int flags);
 	void (*yield_task)   (struct rq *rq);
@@ -3037,23 +2988,6 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
 #ifdef CONFIG_UCLAMP_TASK
 unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
 
-static inline unsigned long uclamp_rq_get(struct rq *rq,
-					  enum uclamp_id clamp_id)
-{
-	return READ_ONCE(rq->uclamp[clamp_id].value);
-}
-
-static inline void uclamp_rq_set(struct rq *rq, enum uclamp_id clamp_id,
-				 unsigned int value)
-{
-	WRITE_ONCE(rq->uclamp[clamp_id].value, value);
-}
-
-static inline bool uclamp_rq_is_idle(struct rq *rq)
-{
-	return rq->uclamp_flags & UCLAMP_FLAG_IDLE;
-}
-
 /*
  * When uclamp is compiled in, the aggregation at rq level is 'turned off'
  * by default in the fast path and only gets turned on once userspace performs
@@ -3137,25 +3071,6 @@ static inline bool uclamp_is_used(void)
 	return false;
 }
 
-static inline unsigned long uclamp_rq_get(struct rq *rq,
-					  enum uclamp_id clamp_id)
-{
-	if (clamp_id == UCLAMP_MIN)
-		return 0;
-
-	return SCHED_CAPACITY_SCALE;
-}
-
-static inline void uclamp_rq_set(struct rq *rq, enum uclamp_id clamp_id,
-				 unsigned int value)
-{
-}
-
-static inline bool uclamp_rq_is_idle(struct rq *rq)
-{
-	return false;
-}
-
 static inline unsigned long root_cfs_util(struct rq *rq)
 {
 	return READ_ONCE(rq->cfs.avg.util_avg);
-- 
2.34.1

