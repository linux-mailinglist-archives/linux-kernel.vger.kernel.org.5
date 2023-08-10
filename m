Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB63B77710E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbjHJHLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjHJHK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:10:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999F2F3;
        Thu, 10 Aug 2023 00:10:56 -0700 (PDT)
Date:   Thu, 10 Aug 2023 07:10:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691651455;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DbvknevY4abZzwd+RIbwQtP5ajWq1ZaH7mjU+uR5oho=;
        b=mmED7lIUM1ur+vX+cA0Ay40amB6bpo0u7WNTDzJgCdekyMHNjjsLBLNtMb04bxIh1BAebu
        8xuLZy9reN9nzbgXwiGg7NCDyrJ6nqcdYwVbffj3AsFIEXIOGTYEGJHcS3hARtkcrG1ues
        YdKIwkGOpod7M82tmEThvv5609Uin1F11iYcXXmtOVF0MiVMmxa5EL9hxIjofWBh5Rc09y
        j+nWjsx6hNVqvCpQlWMnHnWxi9mu9DnDWJHJ9wHY+rV3z5nSlIPWSAbqQmmTA8E7gHaxD5
        RYWlNeLEp8tKjzva/3gwWWR9xojXIPpZCTyGh1y5DfE4CfIi9zJjP9n06OkYZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691651455;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DbvknevY4abZzwd+RIbwQtP5ajWq1ZaH7mjU+uR5oho=;
        b=h4Ij/uHQdNSxAMikixeRk3Mf+S8ogyKEHOUqdqcOwC8daEw2tRxVeOVDDccHGIAQZsyiTM
        UZR7iCX7Wpbw84DA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/smp: Use lag to simplify cross-runqueue placement
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230531124604.068911180@infradead.org>
References: <20230531124604.068911180@infradead.org>
MIME-Version: 1.0
Message-ID: <169165145462.27769.13767120789664508163.tip-bot2@tip-bot2>
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

Commit-ID:     e8f331bcc270354a803c2127c486190d33eac441
Gitweb:        https://git.kernel.org/tip/e8f331bcc270354a803c2127c486190d33eac441
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 31 May 2023 13:58:46 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Jul 2023 09:43:58 +02:00

sched/smp: Use lag to simplify cross-runqueue placement

Using lag is both more correct and simpler when moving between
runqueues.

Notable, min_vruntime() was invented as a cheap approximation of
avg_vruntime() for this very purpose (SMP migration). Since we now
have the real thing; use it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230531124604.068911180@infradead.org
---
 kernel/sched/fair.c | 145 +++++--------------------------------------
 1 file changed, 19 insertions(+), 126 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 58798da..57e8bc1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5083,7 +5083,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 	 *
 	 * EEVDF: placement strategy #1 / #2
 	 */
-	if (sched_feat(PLACE_LAG) && cfs_rq->nr_running > 1) {
+	if (sched_feat(PLACE_LAG) && cfs_rq->nr_running) {
 		struct sched_entity *curr = cfs_rq->curr;
 		unsigned long load;
 
@@ -5172,61 +5172,21 @@ static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq);
 
 static inline bool cfs_bandwidth_used(void);
 
-/*
- * MIGRATION
- *
- *	dequeue
- *	  update_curr()
- *	    update_min_vruntime()
- *	  vruntime -= min_vruntime
- *
- *	enqueue
- *	  update_curr()
- *	    update_min_vruntime()
- *	  vruntime += min_vruntime
- *
- * this way the vruntime transition between RQs is done when both
- * min_vruntime are up-to-date.
- *
- * WAKEUP (remote)
- *
- *	->migrate_task_rq_fair() (p->state == TASK_WAKING)
- *	  vruntime -= min_vruntime
- *
- *	enqueue
- *	  update_curr()
- *	    update_min_vruntime()
- *	  vruntime += min_vruntime
- *
- * this way we don't have the most up-to-date min_vruntime on the originating
- * CPU and an up-to-date min_vruntime on the destination CPU.
- */
-
 static void
 enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
-	bool renorm = !(flags & ENQUEUE_WAKEUP) || (flags & ENQUEUE_MIGRATED);
 	bool curr = cfs_rq->curr == se;
 
 	/*
 	 * If we're the current task, we must renormalise before calling
 	 * update_curr().
 	 */
-	if (renorm && curr)
-		se->vruntime += cfs_rq->min_vruntime;
+	if (curr)
+		place_entity(cfs_rq, se, 0);
 
 	update_curr(cfs_rq);
 
 	/*
-	 * Otherwise, renormalise after, such that we're placed at the current
-	 * moment in time, instead of some random moment in the past. Being
-	 * placed in the past could significantly boost this task to the
-	 * fairness detriment of existing tasks.
-	 */
-	if (renorm && !curr)
-		se->vruntime += cfs_rq->min_vruntime;
-
-	/*
 	 * When enqueuing a sched_entity, we must:
 	 *   - Update loads to have both entity and cfs_rq synced with now.
 	 *   - For group_entity, update its runnable_weight to reflect the new
@@ -5237,11 +5197,22 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 */
 	update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH);
 	se_update_runnable(se);
+	/*
+	 * XXX update_load_avg() above will have attached us to the pelt sum;
+	 * but update_cfs_group() here will re-adjust the weight and have to
+	 * undo/redo all that. Seems wasteful.
+	 */
 	update_cfs_group(se);
-	account_entity_enqueue(cfs_rq, se);
 
-	if (flags & ENQUEUE_WAKEUP)
+	/*
+	 * XXX now that the entity has been re-weighted, and it's lag adjusted,
+	 * we can place the entity.
+	 */
+	if (!curr)
 		place_entity(cfs_rq, se, 0);
+
+	account_entity_enqueue(cfs_rq, se);
+
 	/* Entity has migrated, no longer consider this task hot */
 	if (flags & ENQUEUE_MIGRATED)
 		se->exec_start = 0;
@@ -5346,23 +5317,12 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	clear_buddies(cfs_rq, se);
 
-	if (flags & DEQUEUE_SLEEP)
-		update_entity_lag(cfs_rq, se);
-
+	update_entity_lag(cfs_rq, se);
 	if (se != cfs_rq->curr)
 		__dequeue_entity(cfs_rq, se);
 	se->on_rq = 0;
 	account_entity_dequeue(cfs_rq, se);
 
-	/*
-	 * Normalize after update_curr(); which will also have moved
-	 * min_vruntime if @se is the one holding it back. But before doing
-	 * update_min_vruntime() again, which will discount @se's position and
-	 * can move min_vruntime forward still more.
-	 */
-	if (!(flags & DEQUEUE_SLEEP))
-		se->vruntime -= cfs_rq->min_vruntime;
-
 	/* return excess runtime on last dequeue */
 	return_cfs_rq_runtime(cfs_rq);
 
@@ -8208,18 +8168,6 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 {
 	struct sched_entity *se = &p->se;
 
-	/*
-	 * As blocked tasks retain absolute vruntime the migration needs to
-	 * deal with this by subtracting the old and adding the new
-	 * min_vruntime -- the latter is done by enqueue_entity() when placing
-	 * the task on the new runqueue.
-	 */
-	if (READ_ONCE(p->__state) == TASK_WAKING) {
-		struct cfs_rq *cfs_rq = cfs_rq_of(se);
-
-		se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
-	}
-
 	if (!task_on_rq_migrating(p)) {
 		remove_entity_load_avg(se);
 
@@ -12709,8 +12657,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
  */
 static void task_fork_fair(struct task_struct *p)
 {
-	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se, *curr;
+	struct cfs_rq *cfs_rq;
 	struct rq *rq = this_rq();
 	struct rq_flags rf;
 
@@ -12719,22 +12667,9 @@ static void task_fork_fair(struct task_struct *p)
 
 	cfs_rq = task_cfs_rq(current);
 	curr = cfs_rq->curr;
-	if (curr) {
+	if (curr)
 		update_curr(cfs_rq);
-		se->vruntime = curr->vruntime;
-	}
 	place_entity(cfs_rq, se, 1);
-
-	if (sysctl_sched_child_runs_first && curr && entity_before(curr, se)) {
-		/*
-		 * Upon rescheduling, sched_class::put_prev_task() will place
-		 * 'current' within the tree based on its new key value.
-		 */
-		swap(curr->vruntime, se->vruntime);
-		resched_curr(rq);
-	}
-
-	se->vruntime -= cfs_rq->min_vruntime;
 	rq_unlock(rq, &rf);
 }
 
@@ -12763,34 +12698,6 @@ prio_changed_fair(struct rq *rq, struct task_struct *p, int oldprio)
 		check_preempt_curr(rq, p, 0);
 }
 
-static inline bool vruntime_normalized(struct task_struct *p)
-{
-	struct sched_entity *se = &p->se;
-
-	/*
-	 * In both the TASK_ON_RQ_QUEUED and TASK_ON_RQ_MIGRATING cases,
-	 * the dequeue_entity(.flags=0) will already have normalized the
-	 * vruntime.
-	 */
-	if (p->on_rq)
-		return true;
-
-	/*
-	 * When !on_rq, vruntime of the task has usually NOT been normalized.
-	 * But there are some cases where it has already been normalized:
-	 *
-	 * - A forked child which is waiting for being woken up by
-	 *   wake_up_new_task().
-	 * - A task which has been woken up by try_to_wake_up() and
-	 *   waiting for actually being woken up by sched_ttwu_pending().
-	 */
-	if (!se->sum_exec_runtime ||
-	    (READ_ONCE(p->__state) == TASK_WAKING && p->sched_remote_wakeup))
-		return true;
-
-	return false;
-}
-
 #ifdef CONFIG_FAIR_GROUP_SCHED
 /*
  * Propagate the changes of the sched_entity across the tg tree to make it
@@ -12861,16 +12768,6 @@ static void attach_entity_cfs_rq(struct sched_entity *se)
 static void detach_task_cfs_rq(struct task_struct *p)
 {
 	struct sched_entity *se = &p->se;
-	struct cfs_rq *cfs_rq = cfs_rq_of(se);
-
-	if (!vruntime_normalized(p)) {
-		/*
-		 * Fix up our vruntime so that the current sleep doesn't
-		 * cause 'unlimited' sleep bonus.
-		 */
-		place_entity(cfs_rq, se, 0);
-		se->vruntime -= cfs_rq->min_vruntime;
-	}
 
 	detach_entity_cfs_rq(se);
 }
@@ -12878,12 +12775,8 @@ static void detach_task_cfs_rq(struct task_struct *p)
 static void attach_task_cfs_rq(struct task_struct *p)
 {
 	struct sched_entity *se = &p->se;
-	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
 	attach_entity_cfs_rq(se);
-
-	if (!vruntime_normalized(p))
-		se->vruntime += cfs_rq->min_vruntime;
 }
 
 static void switched_from_fair(struct rq *rq, struct task_struct *p)
