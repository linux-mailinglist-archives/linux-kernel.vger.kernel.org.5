Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5852777115
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbjHJHLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbjHJHK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:10:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2215DE40;
        Thu, 10 Aug 2023 00:10:58 -0700 (PDT)
Date:   Thu, 10 Aug 2023 07:10:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691651456;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YvJ6lRNTv/BcJ7SFiryOQFgRbB8zwokDHuWopKpNmLQ=;
        b=bckGw7tfYhzBymCL2Mk04jhvie/mnWw0rc1oEvd+ZArzIC0W+1GP5ucF2wwA6DsevVRj6z
        IxMi8fENGS84+EeSo+LsfPay9L7XYD/Z15YvCHlz7tWYHIMft5XBgDVK3Hf/lPv9I2QWbo
        OHSP6iB26too+dKNh84r+o1mwvHnc5+Zd1Yr5s9snQNKk8ue1+h8YcJhjfvbTiaLBXU9bh
        uo2FBJFOOVBmlbcoZnivfEogecqyIWWFpS+sYzzPQBYdxPvNZMJfY8qNXzadH95PH0rnUV
        eK5hNjVn61j5GFQDtSl0WQxiIWZXrFDDWaMCBIkcOcXvbvXGFizaJYD+rDKQ9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691651456;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YvJ6lRNTv/BcJ7SFiryOQFgRbB8zwokDHuWopKpNmLQ=;
        b=Ei7O9/zdYx8rgZQo1Z9mnD2uSRwe8Kh6eYwBcFhCQNa/wkeirmyvfo+tF/ZvKQO6dDLcd7
        JwjTmZG7TAcs6RCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Implement an EEVDF-like scheduling policy
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230531124603.931005524@infradead.org>
References: <20230531124603.931005524@infradead.org>
MIME-Version: 1.0
Message-ID: <169165145575.27769.3114444788507978483.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     147f3efaa24182a21706bca15eab2f3f4630b5fe
Gitweb:        https://git.kernel.org/tip/147f3efaa24182a21706bca15eab2f3f4630b5fe
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 31 May 2023 13:58:44 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Jul 2023 09:43:58 +02:00

sched/fair: Implement an EEVDF-like scheduling policy

Where CFS is currently a WFQ based scheduler with only a single knob,
the weight. The addition of a second, latency oriented parameter,
makes something like WF2Q or EEVDF based a much better fit.

Specifically, EEVDF does EDF like scheduling in the left half of the
tree -- those entities that are owed service. Except because this is a
virtual time scheduler, the deadlines are in virtual time as well,
which is what allows over-subscription.

EEVDF has two parameters:

 - weight, or time-slope: which is mapped to nice just as before

 - request size, or slice length: which is used to compute
   the virtual deadline as: vd_i = ve_i + r_i/w_i

Basically, by setting a smaller slice, the deadline will be earlier
and the task will be more eligible and ran earlier.

Tick driven preemption is driven by request/slice completion; while
wakeup preemption is driven by the deadline.

Because the tree is now effectively an interval tree, and the
selection is no longer 'leftmost', over-scheduling is less of a
problem.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230531124603.931005524@infradead.org
---
 include/linux/sched.h   |   4 +-
 kernel/sched/core.c     |   1 +-
 kernel/sched/debug.c    |   6 +-
 kernel/sched/fair.c     | 338 +++++++++++++++++++++++++++++++++------
 kernel/sched/features.h |   3 +-
 kernel/sched/sched.h    |   4 +-
 6 files changed, 308 insertions(+), 48 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ba1828b..177b3f3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -549,6 +549,9 @@ struct sched_entity {
 	/* For load-balancing: */
 	struct load_weight		load;
 	struct rb_node			run_node;
+	u64				deadline;
+	u64				min_deadline;
+
 	struct list_head		group_node;
 	unsigned int			on_rq;
 
@@ -557,6 +560,7 @@ struct sched_entity {
 	u64				prev_sum_exec_runtime;
 	u64				vruntime;
 	s64				vlag;
+	u64				slice;
 
 	u64				nr_migrations;
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 84b0d47..e85a2fd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4502,6 +4502,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->se.nr_migrations		= 0;
 	p->se.vruntime			= 0;
 	p->se.vlag			= 0;
+	p->se.slice			= sysctl_sched_min_granularity;
 	INIT_LIST_HEAD(&p->se.group_node);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index e48d2b2..18efc6d 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -582,9 +582,13 @@ print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
 	else
 		SEQ_printf(m, " %c", task_state_to_char(p));
 
-	SEQ_printf(m, " %15s %5d %9Ld.%06ld %9Ld %5d ",
+	SEQ_printf(m, "%15s %5d %9Ld.%06ld %c %9Ld.%06ld %9Ld.%06ld %9Ld.%06ld %9Ld %5d ",
 		p->comm, task_pid_nr(p),
 		SPLIT_NS(p->se.vruntime),
+		entity_eligible(cfs_rq_of(&p->se), &p->se) ? 'E' : 'N',
+		SPLIT_NS(p->se.deadline),
+		SPLIT_NS(p->se.slice),
+		SPLIT_NS(p->se.sum_exec_runtime),
 		(long long)(p->nvcsw + p->nivcsw),
 		p->prio);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index dd12ada..4d3505d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -47,6 +47,7 @@
 #include <linux/psi.h>
 #include <linux/ratelimit.h>
 #include <linux/task_work.h>
+#include <linux/rbtree_augmented.h>
 
 #include <asm/switch_to.h>
 
@@ -347,6 +348,16 @@ static u64 __calc_delta(u64 delta_exec, unsigned long weight, struct load_weight
 	return mul_u64_u32_shr(delta_exec, fact, shift);
 }
 
+/*
+ * delta /= w
+ */
+static inline u64 calc_delta_fair(u64 delta, struct sched_entity *se)
+{
+	if (unlikely(se->load.weight != NICE_0_LOAD))
+		delta = __calc_delta(delta, NICE_0_LOAD, &se->load);
+
+	return delta;
+}
 
 const struct sched_class fair_sched_class;
 
@@ -717,11 +728,62 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
 
 /*
  * lag_i = S - s_i = w_i * (V - v_i)
+ *
+ * However, since V is approximated by the weighted average of all entities it
+ * is possible -- by addition/removal/reweight to the tree -- to move V around
+ * and end up with a larger lag than we started with.
+ *
+ * Limit this to either double the slice length with a minimum of TICK_NSEC
+ * since that is the timing granularity.
+ *
+ * EEVDF gives the following limit for a steady state system:
+ *
+ *   -r_max < lag < max(r_max, q)
+ *
+ * XXX could add max_slice to the augmented data to track this.
  */
 void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	s64 lag, limit;
+
 	SCHED_WARN_ON(!se->on_rq);
-	se->vlag = avg_vruntime(cfs_rq) - se->vruntime;
+	lag = avg_vruntime(cfs_rq) - se->vruntime;
+
+	limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
+	se->vlag = clamp(lag, -limit, limit);
+}
+
+/*
+ * Entity is eligible once it received less service than it ought to have,
+ * eg. lag >= 0.
+ *
+ * lag_i = S - s_i = w_i*(V - v_i)
+ *
+ * lag_i >= 0 -> V >= v_i
+ *
+ *     \Sum (v_i - v)*w_i
+ * V = ------------------ + v
+ *          \Sum w_i
+ *
+ * lag_i >= 0 -> \Sum (v_i - v)*w_i >= (v_i - v)*(\Sum w_i)
+ *
+ * Note: using 'avg_vruntime() > se->vruntime' is inacurate due
+ *       to the loss in precision caused by the division.
+ */
+int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	struct sched_entity *curr = cfs_rq->curr;
+	s64 avg = cfs_rq->avg_vruntime;
+	long load = cfs_rq->avg_load;
+
+	if (curr && curr->on_rq) {
+		unsigned long weight = scale_load_down(curr->load.weight);
+
+		avg += entity_key(cfs_rq, curr) * weight;
+		load += weight;
+	}
+
+	return avg >= entity_key(cfs_rq, se) * load;
 }
 
 static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
@@ -740,8 +802,8 @@ static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
 
 static void update_min_vruntime(struct cfs_rq *cfs_rq)
 {
+	struct sched_entity *se = __pick_first_entity(cfs_rq);
 	struct sched_entity *curr = cfs_rq->curr;
-	struct rb_node *leftmost = rb_first_cached(&cfs_rq->tasks_timeline);
 
 	u64 vruntime = cfs_rq->min_vruntime;
 
@@ -752,9 +814,7 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
 			curr = NULL;
 	}
 
-	if (leftmost) { /* non-empty tree */
-		struct sched_entity *se = __node_2_se(leftmost);
-
+	if (se) {
 		if (!curr)
 			vruntime = se->vruntime;
 		else
@@ -771,18 +831,50 @@ static inline bool __entity_less(struct rb_node *a, const struct rb_node *b)
 	return entity_before(__node_2_se(a), __node_2_se(b));
 }
 
+#define deadline_gt(field, lse, rse) ({ (s64)((lse)->field - (rse)->field) > 0; })
+
+static inline void __update_min_deadline(struct sched_entity *se, struct rb_node *node)
+{
+	if (node) {
+		struct sched_entity *rse = __node_2_se(node);
+		if (deadline_gt(min_deadline, se, rse))
+			se->min_deadline = rse->min_deadline;
+	}
+}
+
+/*
+ * se->min_deadline = min(se->deadline, left->min_deadline, right->min_deadline)
+ */
+static inline bool min_deadline_update(struct sched_entity *se, bool exit)
+{
+	u64 old_min_deadline = se->min_deadline;
+	struct rb_node *node = &se->run_node;
+
+	se->min_deadline = se->deadline;
+	__update_min_deadline(se, node->rb_right);
+	__update_min_deadline(se, node->rb_left);
+
+	return se->min_deadline == old_min_deadline;
+}
+
+RB_DECLARE_CALLBACKS(static, min_deadline_cb, struct sched_entity,
+		     run_node, min_deadline, min_deadline_update);
+
 /*
  * Enqueue an entity into the rb-tree:
  */
 static void __enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	avg_vruntime_add(cfs_rq, se);
-	rb_add_cached(&se->run_node, &cfs_rq->tasks_timeline, __entity_less);
+	se->min_deadline = se->deadline;
+	rb_add_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
+				__entity_less, &min_deadline_cb);
 }
 
 static void __dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	rb_erase_cached(&se->run_node, &cfs_rq->tasks_timeline);
+	rb_erase_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
+				  &min_deadline_cb);
 	avg_vruntime_sub(cfs_rq, se);
 }
 
@@ -806,6 +898,97 @@ static struct sched_entity *__pick_next_entity(struct sched_entity *se)
 	return __node_2_se(next);
 }
 
+static struct sched_entity *pick_cfs(struct cfs_rq *cfs_rq, struct sched_entity *curr)
+{
+	struct sched_entity *left = __pick_first_entity(cfs_rq);
+
+	/*
+	 * If curr is set we have to see if its left of the leftmost entity
+	 * still in the tree, provided there was anything in the tree at all.
+	 */
+	if (!left || (curr && entity_before(curr, left)))
+		left = curr;
+
+	return left;
+}
+
+/*
+ * Earliest Eligible Virtual Deadline First
+ *
+ * In order to provide latency guarantees for different request sizes
+ * EEVDF selects the best runnable task from two criteria:
+ *
+ *  1) the task must be eligible (must be owed service)
+ *
+ *  2) from those tasks that meet 1), we select the one
+ *     with the earliest virtual deadline.
+ *
+ * We can do this in O(log n) time due to an augmented RB-tree. The
+ * tree keeps the entries sorted on service, but also functions as a
+ * heap based on the deadline by keeping:
+ *
+ *  se->min_deadline = min(se->deadline, se->{left,right}->min_deadline)
+ *
+ * Which allows an EDF like search on (sub)trees.
+ */
+static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
+{
+	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
+	struct sched_entity *curr = cfs_rq->curr;
+	struct sched_entity *best = NULL;
+
+	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
+		curr = NULL;
+
+	while (node) {
+		struct sched_entity *se = __node_2_se(node);
+
+		/*
+		 * If this entity is not eligible, try the left subtree.
+		 */
+		if (!entity_eligible(cfs_rq, se)) {
+			node = node->rb_left;
+			continue;
+		}
+
+		/*
+		 * If this entity has an earlier deadline than the previous
+		 * best, take this one. If it also has the earliest deadline
+		 * of its subtree, we're done.
+		 */
+		if (!best || deadline_gt(deadline, best, se)) {
+			best = se;
+			if (best->deadline == best->min_deadline)
+				break;
+		}
+
+		/*
+		 * If the earlest deadline in this subtree is in the fully
+		 * eligible left half of our space, go there.
+		 */
+		if (node->rb_left &&
+		    __node_2_se(node->rb_left)->min_deadline == se->min_deadline) {
+			node = node->rb_left;
+			continue;
+		}
+
+		node = node->rb_right;
+	}
+
+	if (!best || (curr && deadline_gt(deadline, best, curr)))
+		best = curr;
+
+	if (unlikely(!best)) {
+		struct sched_entity *left = __pick_first_entity(cfs_rq);
+		if (left) {
+			pr_err("EEVDF scheduling fail, picking leftmost\n");
+			return left;
+		}
+	}
+
+	return best;
+}
+
 #ifdef CONFIG_SCHED_DEBUG
 struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
 {
@@ -840,17 +1023,6 @@ int sched_update_scaling(void)
 #endif
 
 /*
- * delta /= w
- */
-static inline u64 calc_delta_fair(u64 delta, struct sched_entity *se)
-{
-	if (unlikely(se->load.weight != NICE_0_LOAD))
-		delta = __calc_delta(delta, NICE_0_LOAD, &se->load);
-
-	return delta;
-}
-
-/*
  * The idea is to set a period in which each task runs once.
  *
  * When there are too many tasks (sched_nr_latency) we have to stretch
@@ -915,6 +1087,48 @@ static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	return slice;
 }
 
+static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se);
+
+/*
+ * XXX: strictly: vd_i += N*r_i/w_i such that: vd_i > ve_i
+ * this is probably good enough.
+ */
+static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	if ((s64)(se->vruntime - se->deadline) < 0)
+		return;
+
+	if (sched_feat(EEVDF)) {
+		/*
+		 * For EEVDF the virtual time slope is determined by w_i (iow.
+		 * nice) while the request time r_i is determined by
+		 * sysctl_sched_min_granularity.
+		 */
+		se->slice = sysctl_sched_min_granularity;
+
+		/*
+		 * The task has consumed its request, reschedule.
+		 */
+		if (cfs_rq->nr_running > 1) {
+			resched_curr(rq_of(cfs_rq));
+			clear_buddies(cfs_rq, se);
+		}
+	} else {
+		/*
+		 * When many tasks blow up the sched_period; it is possible
+		 * that sched_slice() reports unusually large results (when
+		 * many tasks are very light for example). Therefore impose a
+		 * maximum.
+		 */
+		se->slice = min_t(u64, sched_slice(cfs_rq, se), sysctl_sched_latency);
+	}
+
+	/*
+	 * EEVDF: vd_i = ve_i + r_i / w_i
+	 */
+	se->deadline = se->vruntime + calc_delta_fair(se->slice, se);
+}
+
 #include "pelt.h"
 #ifdef CONFIG_SMP
 
@@ -1047,6 +1261,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	schedstat_add(cfs_rq->exec_clock, delta_exec);
 
 	curr->vruntime += calc_delta_fair(delta_exec, curr);
+	update_deadline(cfs_rq, curr);
 	update_min_vruntime(cfs_rq);
 
 	if (entity_is_task(curr)) {
@@ -3521,6 +3736,14 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 		 * we need to scale se->vlag when w_i changes.
 		 */
 		se->vlag = div_s64(se->vlag * old_weight, weight);
+	} else {
+		s64 deadline = se->deadline - se->vruntime;
+		/*
+		 * When the weight changes, the virtual time slope changes and
+		 * we should adjust the relative virtual deadline accordingly.
+		 */
+		deadline = div_s64(deadline * old_weight, weight);
+		se->deadline = se->vruntime + deadline;
 	}
 
 #ifdef CONFIG_SMP
@@ -4871,6 +5094,7 @@ static inline bool entity_is_long_sleeper(struct sched_entity *se)
 static void
 place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 {
+	u64 vslice = calc_delta_fair(se->slice, se);
 	u64 vruntime = avg_vruntime(cfs_rq);
 	s64 lag = 0;
 
@@ -4942,9 +5166,9 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 		 */
 		load = cfs_rq->avg_load;
 		if (curr && curr->on_rq)
-			load += curr->load.weight;
+			load += scale_load_down(curr->load.weight);
 
-		lag *= load + se->load.weight;
+		lag *= load + scale_load_down(se->load.weight);
 		if (WARN_ON_ONCE(!load))
 			load = 1;
 		lag = div_s64(lag, load);
@@ -4985,6 +5209,19 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 	}
 
 	se->vruntime = vruntime;
+
+	/*
+	 * When joining the competition; the exisiting tasks will be,
+	 * on average, halfway through their slice, as such start tasks
+	 * off with half a slice to ease into the competition.
+	 */
+	if (sched_feat(PLACE_DEADLINE_INITIAL) && initial)
+		vslice /= 2;
+
+	/*
+	 * EEVDF: vd_i = ve_i + r_i/w_i
+	 */
+	se->deadline = se->vruntime + vslice;
 }
 
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
@@ -5207,19 +5444,12 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 static void
 check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 {
-	unsigned long ideal_runtime, delta_exec;
+	unsigned long delta_exec;
 	struct sched_entity *se;
 	s64 delta;
 
-	/*
-	 * When many tasks blow up the sched_period; it is possible that
-	 * sched_slice() reports unusually large results (when many tasks are
-	 * very light for example). Therefore impose a maximum.
-	 */
-	ideal_runtime = min_t(u64, sched_slice(cfs_rq, curr), sysctl_sched_latency);
-
 	delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
-	if (delta_exec > ideal_runtime) {
+	if (delta_exec > curr->slice) {
 		resched_curr(rq_of(cfs_rq));
 		/*
 		 * The current task ran long enough, ensure it doesn't get
@@ -5243,7 +5473,7 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 	if (delta < 0)
 		return;
 
-	if (delta > ideal_runtime)
+	if (delta > curr->slice)
 		resched_curr(rq_of(cfs_rq));
 }
 
@@ -5298,17 +5528,20 @@ wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se);
 static struct sched_entity *
 pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 {
-	struct sched_entity *left = __pick_first_entity(cfs_rq);
-	struct sched_entity *se;
+	struct sched_entity *left, *se;
 
-	/*
-	 * If curr is set we have to see if its left of the leftmost entity
-	 * still in the tree, provided there was anything in the tree at all.
-	 */
-	if (!left || (curr && entity_before(curr, left)))
-		left = curr;
+	if (sched_feat(EEVDF)) {
+		/*
+		 * Enabling NEXT_BUDDY will affect latency but not fairness.
+		 */
+		if (sched_feat(NEXT_BUDDY) &&
+		    cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next))
+			return cfs_rq->next;
+
+		return pick_eevdf(cfs_rq);
+	}
 
-	se = left; /* ideally we run the leftmost entity */
+	se = left = pick_cfs(cfs_rq, curr);
 
 	/*
 	 * Avoid running the skip buddy, if running something else can
@@ -5401,7 +5634,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 		return;
 #endif
 
-	if (cfs_rq->nr_running > 1)
+	if (!sched_feat(EEVDF) && cfs_rq->nr_running > 1)
 		check_preempt_tick(cfs_rq, curr);
 }
 
@@ -6445,13 +6678,12 @@ static inline void unthrottle_offline_cfs_rqs(struct rq *rq) {}
 static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
 {
 	struct sched_entity *se = &p->se;
-	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
 	SCHED_WARN_ON(task_rq(p) != rq);
 
 	if (rq->cfs.h_nr_running > 1) {
-		u64 slice = sched_slice(cfs_rq, se);
 		u64 ran = se->sum_exec_runtime - se->prev_sum_exec_runtime;
+		u64 slice = se->slice;
 		s64 delta = slice - ran;
 
 		if (delta < 0) {
@@ -8228,7 +8460,19 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	if (cse_is_idle != pse_is_idle)
 		return;
 
-	update_curr(cfs_rq_of(se));
+	cfs_rq = cfs_rq_of(se);
+	update_curr(cfs_rq);
+
+	if (sched_feat(EEVDF)) {
+		/*
+		 * XXX pick_eevdf(cfs_rq) != se ?
+		 */
+		if (pick_eevdf(cfs_rq) == pse)
+			goto preempt;
+
+		return;
+	}
+
 	if (wakeup_preempt_entity(se, pse) == 1) {
 		/*
 		 * Bias pick_next to pick the sched entity that is
@@ -8474,7 +8718,7 @@ static void yield_task_fair(struct rq *rq)
 
 	clear_buddies(cfs_rq, se);
 
-	if (curr->policy != SCHED_BATCH) {
+	if (sched_feat(EEVDF) || curr->policy != SCHED_BATCH) {
 		update_rq_clock(rq);
 		/*
 		 * Update run-time statistics of the 'current'.
@@ -8487,6 +8731,8 @@ static void yield_task_fair(struct rq *rq)
 		 */
 		rq_clock_skip_update(rq);
 	}
+	if (sched_feat(EEVDF))
+		se->deadline += calc_delta_fair(se->slice, se);
 
 	set_skip_buddy(se);
 }
@@ -12363,8 +12609,8 @@ static void rq_offline_fair(struct rq *rq)
 static inline bool
 __entity_slice_used(struct sched_entity *se, int min_nr_tasks)
 {
-	u64 slice = sched_slice(cfs_rq_of(se), se);
 	u64 rtime = se->sum_exec_runtime - se->prev_sum_exec_runtime;
+	u64 slice = se->slice;
 
 	return (rtime * min_nr_tasks > slice);
 }
@@ -13059,7 +13305,7 @@ static unsigned int get_rr_interval_fair(struct rq *rq, struct task_struct *task
 	 * idle runqueue:
 	 */
 	if (rq->cfs.load.weight)
-		rr_interval = NS_TO_JIFFIES(sched_slice(cfs_rq_of(se), se));
+		rr_interval = NS_TO_JIFFIES(se->slice);
 
 	return rr_interval;
 }
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 7958a10..60cce1e 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -13,6 +13,7 @@ SCHED_FEAT(GENTLE_FAIR_SLEEPERS, true)
  * sleep+wake cycles. EEVDF placement strategy #1, #2 if disabled.
  */
 SCHED_FEAT(PLACE_LAG, true)
+SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
 
 /*
  * Prefer to schedule the task we woke last (assuming it failed
@@ -103,3 +104,5 @@ SCHED_FEAT(LATENCY_WARN, false)
 
 SCHED_FEAT(ALT_PERIOD, true)
 SCHED_FEAT(BASE_SLICE, true)
+
+SCHED_FEAT(EEVDF, true)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 52a0a4b..aa5b293 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2505,9 +2505,10 @@ extern void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags);
 extern const_debug unsigned int sysctl_sched_nr_migrate;
 extern const_debug unsigned int sysctl_sched_migration_cost;
 
+extern unsigned int sysctl_sched_min_granularity;
+
 #ifdef CONFIG_SCHED_DEBUG
 extern unsigned int sysctl_sched_latency;
-extern unsigned int sysctl_sched_min_granularity;
 extern unsigned int sysctl_sched_idle_min_granularity;
 extern unsigned int sysctl_sched_wakeup_granularity;
 extern int sysctl_resched_latency_warn_ms;
@@ -3487,5 +3488,6 @@ static inline void init_sched_mm_cid(struct task_struct *t) { }
 #endif
 
 extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
+extern int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se);
 
 #endif /* _KERNEL_SCHED_SCHED_H */
