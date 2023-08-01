Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BA076BF40
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjHAVZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjHAVY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:24:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131CF35A7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 14:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=d7IoV3mp1lNO/qVCmLB7jmrWy1OfPyeEV/3PfRbFH8k=; b=LzWkMvFWmU8IhV/McwiylHZHRN
        hOc3QDgIdIkDW0kCnPGyVzxZwdQ059bMivNk9HB2WYMTJNthS0QyhqOEV07B+y3prixahIxIZ9nqm
        Y/ex7w/59uEiiEk309Fn65+kNiI4vQCABToj2JSSdPJbT5klwC1/gk16xNSpVybV/vYn4OCO8z8QC
        b/CmIW1zYbsX9V16oshrcw1y1jPGtFLryH2PwsLWi1KLfb9i/qctey2noT6c43uSWISHAO+BZaE63
        52S5itpnBKNdkd8nEH0nCdiaG1S7riCGC+zzipbuHx+HLP1K2nAhf1rSK74vqRUyNINRa2c5sNglX
        gaDe74yA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQwqn-00EvTu-1c;
        Tue, 01 Aug 2023 21:24:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BEE4030278C;
        Tue,  1 Aug 2023 23:24:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 492882028A2D9; Tue,  1 Aug 2023 23:24:15 +0200 (CEST)
Message-ID: <20230801211812.101069260@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 01 Aug 2023 22:41:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] sched: Simplify ttwu()
References: <20230801204121.929256934@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |  221 +++++++++++++++++++++++++---------------------------
 1 file changed, 109 insertions(+), 112 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3706,14 +3706,14 @@ ttwu_stat(struct task_struct *p, int cpu
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
@@ -4172,10 +4172,9 @@ bool ttwu_state_match(struct task_struct
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
@@ -4202,129 +4201,127 @@ try_to_wake_up(struct task_struct *p, un
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


