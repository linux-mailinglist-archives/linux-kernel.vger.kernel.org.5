Return-Path: <linux-kernel+bounces-132882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DED1899B8E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AE631F23B11
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8872016C86F;
	Fri,  5 Apr 2024 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zz6IlpKY"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FBD16C444
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712315047; cv=none; b=DIAOula+z83vDtwjxUij+ZsJcPv7TBCFohjyUhqJcgENq1MwrRbV0K25vESdm0cIAEaGF+wc7PK2cZG573zA+MNRB81N8ir1kBLUulqIFRPeRyNGM6YP+R4Sof3+zwT3ciDmcOuhzK30Is7xSOHbp5273w9YDLvu1KlbA0gH4X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712315047; c=relaxed/simple;
	bh=9tYqk4f70pvDgfXnTUEp68z7b5o+YJZq1cywjX4z5Vg=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=jmeVWQVUG5FB8nhSbwgfpRGeN0b4ljQAXqlshco9x1WPIyMSpmQBH+EiyWApK99NbVzFEHJ2prEzrfRlTC/DACzSsq1fC1q9nneEXBOq8/xmZCh2oBZbxT80Fe1fUzenbI4s+r++ZLS+ESVzN+Ixgly0tXYjPy9fd3cWF6dg5VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Zz6IlpKY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=hNByCiG9RvCJoUGw1qab9h7akZshHpkHFgruk79d8xc=; b=Zz6IlpKYAI2bCFh1nFBmDgeAw3
	L0j1ocXzkScwI1f5v2PBhU9JDsqtrvejJREJbODbf9ajStYFhNTC2F/FFnGrTaKLXXNHeu7XXq+Mw
	rEyXd9NVHoJ2RTNBQjc7ASBHa0UqIuhllMXpHTUzKhhhUxINa/joSSrrTwKaL+GjR1S15bFRLwCEr
	egZ89drwUMyWRLqau1Q9lAP6piYKwtKMd3JNCyGd6rgeogWl9QlNdl/NppTpk9uIQri3zrN0S+m7p
	RwyAcau6NUHakFBODHWDmrc0yjq1KaAypKx66yB+TwICP8MC7hZtGwmIP0sw3P8Z9xDYx5Dr/+3dG
	y65W0DlQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rshMH-0000000AKMR-27N2;
	Fri, 05 Apr 2024 11:03:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 9B8EB302DBE; Fri,  5 Apr 2024 13:03:44 +0200 (CEST)
Message-Id: <20240405110010.631664251@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 05 Apr 2024 12:28:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@redhat.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 bristot@redhat.com,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com,
 tglx@linutronix.de,
 efault@gmx.de
Subject: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
References: <20240405102754.435410987@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Extend / fix 86bfbb7ce4f6 ("sched/fair: Add lag based placement") by
noting that lag is fundamentally a temporal measure. It should not be
carried around indefinitely.

OTOH it should also not be instantly discarded, doing so will allow a
task to game the system by purposefully (micro) sleeping at the end of
its time quantum.

Since lag is intimately tied to the virtual time base, a wall-time
based decay is also insufficient, notably competition is required for
any of this to make sense.

Instead, delay the dequeue and keep the 'tasks' on the runqueue,
competing until they are eligible.

Strictly speaking, we only care about keeping them until the 0-lag
point, but that is a difficult proposition, instead carry them around
until they get picked again, and dequeue them at that point.

Since we should have dequeued them at the 0-lag point, truncate lag
(eg. don't let them earn positive lag).

XXX test the cfs-throttle stuff

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h   |    1 
 kernel/sched/core.c     |   22 +++++--
 kernel/sched/fair.c     |  148 +++++++++++++++++++++++++++++++++++++++++++-----
 kernel/sched/features.h |   12 +++
 kernel/sched/sched.h    |    2 
 5 files changed, 167 insertions(+), 18 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -542,6 +542,7 @@ struct sched_entity {
 
 	struct list_head		group_node;
 	unsigned int			on_rq;
+	unsigned int			sched_delayed;
 
 	u64				exec_start;
 	u64				sum_exec_runtime;
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2154,10 +2154,14 @@ void activate_task(struct rq *rq, struct
 
 void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
 {
-	WRITE_ONCE(p->on_rq, (flags & DEQUEUE_SLEEP) ? 0 : TASK_ON_RQ_MIGRATING);
-	ASSERT_EXCLUSIVE_WRITER(p->on_rq);
+	bool sleep = flags & DEQUEUE_SLEEP;
 
-	dequeue_task(rq, p, flags);
+	if (dequeue_task(rq, p, flags)) {
+		WRITE_ONCE(p->on_rq, sleep ? 0 : TASK_ON_RQ_MIGRATING);
+		ASSERT_EXCLUSIVE_WRITER(p->on_rq);
+	} else {
+		SCHED_WARN_ON(!sleep); /* only sleep can fail */
+	}
 }
 
 static inline int __normal_prio(int policy, int rt_prio, int nice)
@@ -3858,12 +3862,17 @@ static int ttwu_runnable(struct task_str
 
 	rq = __task_rq_lock(p, &rf);
 	if (task_on_rq_queued(p)) {
+		update_rq_clock(rq);
+		if (p->se.sched_delayed) {
+			/* mustn't run a delayed task */
+			SCHED_WARN_ON(task_on_cpu(rq, p));
+			enqueue_task(rq, p, ENQUEUE_DELAYED);
+		}
 		if (!task_on_cpu(rq, p)) {
 			/*
 			 * When on_rq && !on_cpu the task is preempted, see if
 			 * it should preempt the task that is current now.
 			 */
-			update_rq_clock(rq);
 			wakeup_preempt(rq, p, wake_flags);
 		}
 		ttwu_do_wakeup(p);
@@ -4243,11 +4252,16 @@ int try_to_wake_up(struct task_struct *p
 		 * case the whole 'p->on_rq && ttwu_runnable()' case below
 		 * without taking any locks.
 		 *
+		 * Specifically, given current runs ttwu() we must be before
+		 * schedule()'s deactivate_task(), as such this must not
+		 * observe sched_delayed.
+		 *
 		 * In particular:
 		 *  - we rely on Program-Order guarantees for all the ordering,
 		 *  - we're serialized against set_special_state() by virtue of
 		 *    it disabling IRQs (this allows not taking ->pi_lock).
 		 */
+		SCHED_WARN_ON(p->se.sched_delayed);
 		if (!ttwu_state_match(p, state, &success))
 			goto out;
 
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5270,6 +5270,10 @@ static inline int cfs_rq_throttled(struc
 static inline bool cfs_bandwidth_used(void);
 
 static void
+requeue_delayed_entity(struct sched_entity *se);
+
+/* XXX bool and pull in the requeue_delayed_entity thing */
+static void
 enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
 	bool curr = cfs_rq->curr == se;
@@ -5356,18 +5360,33 @@ static void clear_buddies(struct cfs_rq
 
 static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
 
-static void
+static bool
 dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
-	int action = UPDATE_TG;
-
-	if (entity_is_task(se) && task_on_rq_migrating(task_of(se)))
-		action |= DO_DETACH;
-
 	/*
 	 * Update run-time statistics of the 'current'.
 	 */
-	update_curr(cfs_rq);
+	if (flags & DEQUEUE_DELAYED) {
+		SCHED_WARN_ON(!se->sched_delayed);
+		se->sched_delayed = 0;
+	} else {
+		bool sleep = flags & DEQUEUE_SLEEP;
+
+		SCHED_WARN_ON(sleep && se->sched_delayed);
+		update_curr(cfs_rq);
+
+		if (sched_feat(DELAY_DEQUEUE) && sleep &&
+		    !entity_eligible(cfs_rq, se)) {
+			if (cfs_rq->next == se)
+				cfs_rq->next = NULL;
+			se->sched_delayed = 1;
+			return false;
+		}
+	}
+
+	int action = UPDATE_TG;
+	if (entity_is_task(se) && task_on_rq_migrating(task_of(se)))
+		action |= DO_DETACH;
 
 	/*
 	 * When dequeuing a sched_entity, we must:
@@ -5407,6 +5426,8 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
 
 	if (cfs_rq->nr_running == 0)
 		update_idle_cfs_rq_clock_pelt(cfs_rq);
+
+	return true;
 }
 
 static void
@@ -5432,6 +5453,7 @@ set_next_entity(struct cfs_rq *cfs_rq, s
 	}
 
 	update_stats_curr_start(cfs_rq, se);
+	SCHED_WARN_ON(cfs_rq->curr);
 	cfs_rq->curr = se;
 
 	/*
@@ -5452,6 +5474,8 @@ set_next_entity(struct cfs_rq *cfs_rq, s
 	se->prev_sum_exec_runtime = se->sum_exec_runtime;
 }
 
+static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags);
+
 /*
  * Pick the next process, keeping these things in mind, in this order:
  * 1) keep things fair between processes/task groups
@@ -5460,16 +5484,29 @@ set_next_entity(struct cfs_rq *cfs_rq, s
  * 4) do not run the "skip" process, if something else is available
  */
 static struct sched_entity *
-pick_next_entity(struct cfs_rq *cfs_rq)
+pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
 {
 	/*
 	 * Enabling NEXT_BUDDY will affect latency but not fairness.
 	 */
 	if (sched_feat(NEXT_BUDDY) &&
-	    cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next))
+	    cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next)) {
+		/* ->next will never be delayed */
+		SCHED_WARN_ON(cfs_rq->next->sched_delayed);
 		return cfs_rq->next;
+	}
 
-	return pick_eevdf(cfs_rq);
+	struct sched_entity *se = pick_eevdf(cfs_rq);
+	if (se->sched_delayed) {
+		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
+		SCHED_WARN_ON(se->sched_delayed);
+		SCHED_WARN_ON(se->on_rq);
+		if (sched_feat(DELAY_ZERO) && se->vlag > 0)
+			se->vlag = 0;
+
+		return NULL;
+	}
+	return se;
 }
 
 static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq);
@@ -5493,6 +5530,7 @@ static void put_prev_entity(struct cfs_r
 		/* in !on_rq case, update occurred at dequeue */
 		update_load_avg(cfs_rq, prev, 0);
 	}
+	SCHED_WARN_ON(cfs_rq->curr != prev);
 	cfs_rq->curr = NULL;
 }
 
@@ -5793,6 +5831,10 @@ static bool throttle_cfs_rq(struct cfs_r
 		if (!se->on_rq)
 			goto done;
 
+		/*
+		 * XXX should be fine vs sched_delay; if won't run after this.
+		 * Either pick dequeues it, or unthrottle. Double check!!
+		 */
 		dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
@@ -5882,8 +5924,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cf
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 
-		if (se->on_rq)
+		if (se->on_rq) {
+			if (se->sched_delayed)
+				requeue_delayed_entity(se);
 			break;
+		}
 		enqueue_entity(qcfs_rq, se, ENQUEUE_WAKEUP);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
@@ -6729,6 +6774,40 @@ static int sched_idle_cpu(int cpu)
 }
 #endif
 
+static void
+requeue_delayed_entity(struct sched_entity *se)
+{
+	struct cfs_rq *cfs_rq = cfs_rq_of(se);
+
+	/*
+	 * se->sched_delayed should imply both: se->on_rq == 1 and
+	 * cfs_rq->curr != se. Because a delayed entity is one that is still on
+	 * the runqueue competing until elegibility.
+	 *
+	 * Except for groups, consider current going idle and newidle pulling a
+	 * task in the same group -- in that case 'cfs_rq->curr == se'.
+	 */
+	SCHED_WARN_ON(!se->sched_delayed);
+	SCHED_WARN_ON(!se->on_rq);
+	SCHED_WARN_ON(entity_is_task(se) && cfs_rq->curr == se);
+
+	if (sched_feat(DELAY_ZERO)) {
+		update_entity_lag(cfs_rq, se);
+		if (se->vlag > 0) {
+			cfs_rq->nr_running--;
+			if (se != cfs_rq->curr)
+				__dequeue_entity(cfs_rq, se);
+			se->vlag = 0;
+			place_entity(cfs_rq, se, 0);
+			if (se != cfs_rq->curr)
+				__enqueue_entity(cfs_rq, se);
+			cfs_rq->nr_running++;
+		}
+	}
+
+	se->sched_delayed = 0;
+}
+
 /*
  * The enqueue_task method is called before nr_running is
  * increased. Here we update the fair scheduling stats and
@@ -6742,6 +6821,11 @@ enqueue_task_fair(struct rq *rq, struct
 	int idle_h_nr_running = task_has_idle_policy(p);
 	int task_new = !(flags & ENQUEUE_WAKEUP);
 
+	if (flags & ENQUEUE_DELAYED) {
+		requeue_delayed_entity(se);
+		return;
+	}
+
 	/*
 	 * The code below (indirectly) updates schedutil which looks at
 	 * the cfs_rq utilization to select a frequency.
@@ -6759,8 +6843,11 @@ enqueue_task_fair(struct rq *rq, struct
 		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
 
 	for_each_sched_entity(se) {
-		if (se->on_rq)
+		if (se->on_rq) {
+			if (se->sched_delayed)
+				requeue_delayed_entity(se);
 			break;
+		}
 		cfs_rq = cfs_rq_of(se);
 		enqueue_entity(cfs_rq, se, flags);
 
@@ -6836,6 +6923,7 @@ static int dequeue_entities(struct rq *r
 {
 	bool was_sched_idle = sched_idle_rq(rq);
 	bool task_sleep = flags & DEQUEUE_SLEEP;
+	bool task_delayed = flags & DEQUEUE_DELAYED;
 	struct task_struct *p = NULL;
 	struct cfs_rq *cfs_rq;
 	int idle_h_nr_running;
@@ -6849,7 +6937,13 @@ static int dequeue_entities(struct rq *r
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
-		dequeue_entity(cfs_rq, se, flags);
+
+		if (!dequeue_entity(cfs_rq, se, flags)) {
+			if (p && &p->se == se)
+				return -1;
+
+			break;
+		}
 
 		/* h_nr_running is the hierachical count of tasks */
 		if (p) {
@@ -6877,6 +6971,7 @@ static int dequeue_entities(struct rq *r
 			break;
 		}
 		flags |= DEQUEUE_SLEEP;
+		flags &= ~DEQUEUE_DELAYED;
 	}
 
 	for_each_sched_entity(se) {
@@ -6906,6 +7001,18 @@ static int dequeue_entities(struct rq *r
 		/* balance early to pull high priority tasks */
 		if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
 			rq->next_balance = jiffies;
+
+		if (task_delayed) {
+			SCHED_WARN_ON(!task_sleep);
+			SCHED_WARN_ON(p->on_rq != 1);
+
+			/* Fix-up what dequeue_task_fair() skipped */
+			util_est_update(&rq->cfs, p, task_sleep);
+			hrtick_update(rq);
+
+			/* Fix-up what deactivate_task() skipped. */
+			WRITE_ONCE(p->on_rq, 0);
+		}
 	}
 
 	return 1;
@@ -6923,6 +7030,10 @@ static bool dequeue_task_fair(struct rq
 	if (dequeue_entities(rq, &p->se, flags) < 0)
 		return false;
 
+	/*
+	 * It doesn't make sense to update util_est for the delayed dequeue
+	 * case where ttwu will make it appear the sleep never happened.
+	 */
 	util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
 	hrtick_update(rq);
 	return true;
@@ -8463,7 +8574,9 @@ static struct task_struct *pick_task_fai
 		if (unlikely(check_cfs_rq_runtime(cfs_rq)))
 			goto again;
 
-		se = pick_next_entity(cfs_rq);
+		se = pick_next_entity(rq, cfs_rq);
+		if (!se)
+			goto again;
 		cfs_rq = group_cfs_rq(se);
 	} while (cfs_rq);
 
@@ -12803,10 +12916,17 @@ static void attach_task_cfs_rq(struct ta
 static void switched_from_fair(struct rq *rq, struct task_struct *p)
 {
 	detach_task_cfs_rq(p);
+	// XXX think harder on this
+	// this could actually be handled correctly I suppose; keep the whole
+	// se enqueued while boosted. horrible complexity though
+	p->se.sched_delayed = 0;
+	// XXX also vlag ?!?
 }
 
 static void switched_to_fair(struct rq *rq, struct task_struct *p)
 {
+	SCHED_WARN_ON(p->se.sched_delayed);
+
 	attach_task_cfs_rq(p);
 
 	set_task_max_allowed_capacity(p);
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -29,6 +29,18 @@ SCHED_FEAT(NEXT_BUDDY, false)
 SCHED_FEAT(CACHE_HOT_BUDDY, true)
 
 /*
+ * Delay dequeueing tasks until they get selected or woken.
+ *
+ * By delaying the dequeue for non-eligible tasks, they remain in the
+ * competition and can burn off their negative lag. When they get selected
+ * they'll have positive lag by definition.
+ *
+ * DELAY_ZERO clips the lag on dequeue (or wakeup) to 0.
+ */
+SCHED_FEAT(DELAY_DEQUEUE, true)
+SCHED_FEAT(DELAY_ZERO, true)
+
+/*
  * Allow wakeup-time preemption of the current task:
  */
 SCHED_FEAT(WAKEUP_PREEMPTION, true)
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2245,6 +2245,7 @@ extern const u32		sched_prio_to_wmult[40
 #define DEQUEUE_MOVE		0x04 /* Matches ENQUEUE_MOVE */
 #define DEQUEUE_NOCLOCK		0x08 /* Matches ENQUEUE_NOCLOCK */
 #define DEQUEUE_MIGRATING	0x100 /* Matches ENQUEUE_MIGRATING */
+#define DEQUEUE_DELAYED		0x200 /* Matches ENQUEUE_DELAYED */
 
 #define ENQUEUE_WAKEUP		0x01
 #define ENQUEUE_RESTORE		0x02
@@ -2260,6 +2261,7 @@ extern const u32		sched_prio_to_wmult[40
 #endif
 #define ENQUEUE_INITIAL		0x80
 #define ENQUEUE_MIGRATING	0x100
+#define ENQUEUE_DELAYED		0x200
 
 #define RETRY_TASK		((void *)-1UL)
 



