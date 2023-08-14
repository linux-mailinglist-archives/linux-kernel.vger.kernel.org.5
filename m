Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B7077BC7E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjHNPIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbjHNPIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:08:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401F610F2;
        Mon, 14 Aug 2023 08:08:07 -0700 (PDT)
Date:   Mon, 14 Aug 2023 15:08:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692025685;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wZLzFGLp0LblNIxdwzKrgvDq+h7j/iVCt/3NvDNLSHg=;
        b=i0Fw+b7kIriiYGk3RxHQh65R2HY19Wk34R17sq7G3rDpktbpYOynshwLuFMVOASnwIyh+O
        Qvfnmro6poPEYZZ8DxidPjgQ/TPQS2lCFaoKEcJl4Wzg8NDKqu2VDVctH9iet09dhdOzTV
        rUlLQS+0iV34W4mx4tVNM+qN+8drY51XZR8iur6tilEUgOz8ZxvyyLxKzQJwNn0gCSDlIy
        xD8LlxB/eCubjMEpl8VWnEXl5MWNRkpSOC5Q3DVyljz5OiF/U1rLQjlal0aAn0G0RmEosV
        02Wj5V7gsQGD78JAbPqLba7KVxZiGA/s8ix8oV51hcJvonVyk5l0VZ5KRnA7pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692025685;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wZLzFGLp0LblNIxdwzKrgvDq+h7j/iVCt/3NvDNLSHg=;
        b=cVu+Y+FIvxgfZtH6PPffhW54q9xRcfmQocR7Yf6upg9tOtvy2ZhkgJGgScuKsXbHiHnWEq
        PxUW8qHi6ggD6kCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Simplify ttwu()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230801211812.101069260@infradead.org>
References: <20230801211812.101069260@infradead.org>
MIME-Version: 1.0
Message-ID: <169202568534.27769.9465399521118250754.tip-bot2@tip-bot2>
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

Commit-ID:     857d315f1201cfcf60e5849c96d2b4dd20f90ebf
Gitweb:        https://git.kernel.org/tip/857d315f1201cfcf60e5849c96d2b4dd20f90ebf
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 01 Aug 2023 22:41:26 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Aug 2023 17:01:25 +02:00

sched: Simplify ttwu()

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lore.kernel.org/r/20230801211812.101069260@infradead.org
---
 kernel/sched/core.c | 221 +++++++++++++++++++++----------------------
 1 file changed, 109 insertions(+), 112 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 65ebf43..68bd68d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3733,14 +3733,14 @@ ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
 		struct sched_domain *sd;
 
 		__schedstat_inc(p->stats.nr_wakeups_remote);
-		rcu_read_lock();
+
+		guard(rcu)();
 		for_each_domain(rq->cpu, sd) {
 			if (cpumask_test_cpu(cpu, sched_domain_span(sd))) {
 				__schedstat_inc(sd->ttwu_wake_remote);
 				break;
 			}
 		}
-		rcu_read_unlock();
 	}
 
 	if (wake_flags & WF_MIGRATED)
@@ -4199,10 +4199,9 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
 static int
 try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 {
-	unsigned long flags;
+	guard(preempt)();
 	int cpu, success = 0;
 
-	preempt_disable();
 	if (p == current) {
 		/*
 		 * We're waking current, this means 'p->on_rq' and 'task_cpu(p)
@@ -4229,129 +4228,127 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 * reordered with p->state check below. This pairs with smp_store_mb()
 	 * in set_current_state() that the waiting thread does.
 	 */
-	raw_spin_lock_irqsave(&p->pi_lock, flags);
-	smp_mb__after_spinlock();
-	if (!ttwu_state_match(p, state, &success))
-		goto unlock;
+	scoped_guard (raw_spinlock_irqsave, &p->pi_lock) {
+		smp_mb__after_spinlock();
+		if (!ttwu_state_match(p, state, &success))
+			break;
 
-	trace_sched_waking(p);
+		trace_sched_waking(p);
 
-	/*
-	 * Ensure we load p->on_rq _after_ p->state, otherwise it would
-	 * be possible to, falsely, observe p->on_rq == 0 and get stuck
-	 * in smp_cond_load_acquire() below.
-	 *
-	 * sched_ttwu_pending()			try_to_wake_up()
-	 *   STORE p->on_rq = 1			  LOAD p->state
-	 *   UNLOCK rq->lock
-	 *
-	 * __schedule() (switch to task 'p')
-	 *   LOCK rq->lock			  smp_rmb();
-	 *   smp_mb__after_spinlock();
-	 *   UNLOCK rq->lock
-	 *
-	 * [task p]
-	 *   STORE p->state = UNINTERRUPTIBLE	  LOAD p->on_rq
-	 *
-	 * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
-	 * __schedule().  See the comment for smp_mb__after_spinlock().
-	 *
-	 * A similar smb_rmb() lives in try_invoke_on_locked_down_task().
-	 */
-	smp_rmb();
-	if (READ_ONCE(p->on_rq) && ttwu_runnable(p, wake_flags))
-		goto unlock;
+		/*
+		 * Ensure we load p->on_rq _after_ p->state, otherwise it would
+		 * be possible to, falsely, observe p->on_rq == 0 and get stuck
+		 * in smp_cond_load_acquire() below.
+		 *
+		 * sched_ttwu_pending()			try_to_wake_up()
+		 *   STORE p->on_rq = 1			  LOAD p->state
+		 *   UNLOCK rq->lock
+		 *
+		 * __schedule() (switch to task 'p')
+		 *   LOCK rq->lock			  smp_rmb();
+		 *   smp_mb__after_spinlock();
+		 *   UNLOCK rq->lock
+		 *
+		 * [task p]
+		 *   STORE p->state = UNINTERRUPTIBLE	  LOAD p->on_rq
+		 *
+		 * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
+		 * __schedule().  See the comment for smp_mb__after_spinlock().
+		 *
+		 * A similar smb_rmb() lives in try_invoke_on_locked_down_task().
+		 */
+		smp_rmb();
+		if (READ_ONCE(p->on_rq) && ttwu_runnable(p, wake_flags))
+			break;
 
 #ifdef CONFIG_SMP
-	/*
-	 * Ensure we load p->on_cpu _after_ p->on_rq, otherwise it would be
-	 * possible to, falsely, observe p->on_cpu == 0.
-	 *
-	 * One must be running (->on_cpu == 1) in order to remove oneself
-	 * from the runqueue.
-	 *
-	 * __schedule() (switch to task 'p')	try_to_wake_up()
-	 *   STORE p->on_cpu = 1		  LOAD p->on_rq
-	 *   UNLOCK rq->lock
-	 *
-	 * __schedule() (put 'p' to sleep)
-	 *   LOCK rq->lock			  smp_rmb();
-	 *   smp_mb__after_spinlock();
-	 *   STORE p->on_rq = 0			  LOAD p->on_cpu
-	 *
-	 * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
-	 * __schedule().  See the comment for smp_mb__after_spinlock().
-	 *
-	 * Form a control-dep-acquire with p->on_rq == 0 above, to ensure
-	 * schedule()'s deactivate_task() has 'happened' and p will no longer
-	 * care about it's own p->state. See the comment in __schedule().
-	 */
-	smp_acquire__after_ctrl_dep();
+		/*
+		 * Ensure we load p->on_cpu _after_ p->on_rq, otherwise it would be
+		 * possible to, falsely, observe p->on_cpu == 0.
+		 *
+		 * One must be running (->on_cpu == 1) in order to remove oneself
+		 * from the runqueue.
+		 *
+		 * __schedule() (switch to task 'p')	try_to_wake_up()
+		 *   STORE p->on_cpu = 1		  LOAD p->on_rq
+		 *   UNLOCK rq->lock
+		 *
+		 * __schedule() (put 'p' to sleep)
+		 *   LOCK rq->lock			  smp_rmb();
+		 *   smp_mb__after_spinlock();
+		 *   STORE p->on_rq = 0			  LOAD p->on_cpu
+		 *
+		 * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
+		 * __schedule().  See the comment for smp_mb__after_spinlock().
+		 *
+		 * Form a control-dep-acquire with p->on_rq == 0 above, to ensure
+		 * schedule()'s deactivate_task() has 'happened' and p will no longer
+		 * care about it's own p->state. See the comment in __schedule().
+		 */
+		smp_acquire__after_ctrl_dep();
 
-	/*
-	 * We're doing the wakeup (@success == 1), they did a dequeue (p->on_rq
-	 * == 0), which means we need to do an enqueue, change p->state to
-	 * TASK_WAKING such that we can unlock p->pi_lock before doing the
-	 * enqueue, such as ttwu_queue_wakelist().
-	 */
-	WRITE_ONCE(p->__state, TASK_WAKING);
+		/*
+		 * We're doing the wakeup (@success == 1), they did a dequeue (p->on_rq
+		 * == 0), which means we need to do an enqueue, change p->state to
+		 * TASK_WAKING such that we can unlock p->pi_lock before doing the
+		 * enqueue, such as ttwu_queue_wakelist().
+		 */
+		WRITE_ONCE(p->__state, TASK_WAKING);
 
-	/*
-	 * If the owning (remote) CPU is still in the middle of schedule() with
-	 * this task as prev, considering queueing p on the remote CPUs wake_list
-	 * which potentially sends an IPI instead of spinning on p->on_cpu to
-	 * let the waker make forward progress. This is safe because IRQs are
-	 * disabled and the IPI will deliver after on_cpu is cleared.
-	 *
-	 * Ensure we load task_cpu(p) after p->on_cpu:
-	 *
-	 * set_task_cpu(p, cpu);
-	 *   STORE p->cpu = @cpu
-	 * __schedule() (switch to task 'p')
-	 *   LOCK rq->lock
-	 *   smp_mb__after_spin_lock()		smp_cond_load_acquire(&p->on_cpu)
-	 *   STORE p->on_cpu = 1		LOAD p->cpu
-	 *
-	 * to ensure we observe the correct CPU on which the task is currently
-	 * scheduling.
-	 */
-	if (smp_load_acquire(&p->on_cpu) &&
-	    ttwu_queue_wakelist(p, task_cpu(p), wake_flags))
-		goto unlock;
+		/*
+		 * If the owning (remote) CPU is still in the middle of schedule() with
+		 * this task as prev, considering queueing p on the remote CPUs wake_list
+		 * which potentially sends an IPI instead of spinning on p->on_cpu to
+		 * let the waker make forward progress. This is safe because IRQs are
+		 * disabled and the IPI will deliver after on_cpu is cleared.
+		 *
+		 * Ensure we load task_cpu(p) after p->on_cpu:
+		 *
+		 * set_task_cpu(p, cpu);
+		 *   STORE p->cpu = @cpu
+		 * __schedule() (switch to task 'p')
+		 *   LOCK rq->lock
+		 *   smp_mb__after_spin_lock()		smp_cond_load_acquire(&p->on_cpu)
+		 *   STORE p->on_cpu = 1		LOAD p->cpu
+		 *
+		 * to ensure we observe the correct CPU on which the task is currently
+		 * scheduling.
+		 */
+		if (smp_load_acquire(&p->on_cpu) &&
+		    ttwu_queue_wakelist(p, task_cpu(p), wake_flags))
+			break;
 
-	/*
-	 * If the owning (remote) CPU is still in the middle of schedule() with
-	 * this task as prev, wait until it's done referencing the task.
-	 *
-	 * Pairs with the smp_store_release() in finish_task().
-	 *
-	 * This ensures that tasks getting woken will be fully ordered against
-	 * their previous state and preserve Program Order.
-	 */
-	smp_cond_load_acquire(&p->on_cpu, !VAL);
+		/*
+		 * If the owning (remote) CPU is still in the middle of schedule() with
+		 * this task as prev, wait until it's done referencing the task.
+		 *
+		 * Pairs with the smp_store_release() in finish_task().
+		 *
+		 * This ensures that tasks getting woken will be fully ordered against
+		 * their previous state and preserve Program Order.
+		 */
+		smp_cond_load_acquire(&p->on_cpu, !VAL);
 
-	cpu = select_task_rq(p, p->wake_cpu, wake_flags | WF_TTWU);
-	if (task_cpu(p) != cpu) {
-		if (p->in_iowait) {
-			delayacct_blkio_end(p);
-			atomic_dec(&task_rq(p)->nr_iowait);
-		}
+		cpu = select_task_rq(p, p->wake_cpu, wake_flags | WF_TTWU);
+		if (task_cpu(p) != cpu) {
+			if (p->in_iowait) {
+				delayacct_blkio_end(p);
+				atomic_dec(&task_rq(p)->nr_iowait);
+			}
 
-		wake_flags |= WF_MIGRATED;
-		psi_ttwu_dequeue(p);
-		set_task_cpu(p, cpu);
-	}
+			wake_flags |= WF_MIGRATED;
+			psi_ttwu_dequeue(p);
+			set_task_cpu(p, cpu);
+		}
 #else
-	cpu = task_cpu(p);
+		cpu = task_cpu(p);
 #endif /* CONFIG_SMP */
 
-	ttwu_queue(p, cpu, wake_flags);
-unlock:
-	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+		ttwu_queue(p, cpu, wake_flags);
+	}
 out:
 	if (success)
 		ttwu_stat(p, task_cpu(p), wake_flags);
-	preempt_enable();
 
 	return success;
 }
