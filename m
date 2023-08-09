Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257F5776A7D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbjHIUn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbjHIUnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:43:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67D4B4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 13:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ThEUNb9D9nIZpZ+/BY6F6cfgdQIlu3LVP2VkHFdZEuo=; b=frd6yqbu86MqYEAXmJxyBqjZQ2
        BgxYLcE4k0M5+CDr2I2lZPa/khnMfeSzCQT+VIFG70EV93XUsqCiyW+DLPCIqfU6AJUy5PkDnANbm
        K50Er4Q552rkIYUWds+3mn2gGDpJJ4+yDK+VWQxCmmxyRxXJb9FdG7Td1EZ8EBHiFabyFSSUTBpoi
        L+s9+6fkkRKEtmQ5ScSWXqAtUrNUk9u66Y/BvWvpkL3doio1QiXn/dUNvTJlSKoqQ41rxZp3mtFUQ
        5WvNsoNddu3FhrQxD4IXxatYd/hzgfMoDIQQIyDa81MLqBuN757tDv3tBsyUsK5mhkwE8QnkbHKJC
        3e7eY+nA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qTq1n-008LN9-GP; Wed, 09 Aug 2023 20:43:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1416530067B;
        Wed,  9 Aug 2023 22:43:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6EDA1206EC33A; Wed,  9 Aug 2023 22:43:33 +0200 (CEST)
Message-ID: <20230809204200.580725323@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Aug 2023 22:24:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] sched: Misc cleanups
References: <20230809202440.012625269@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Random remaining guard use...

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |  167 +++++++++++++++++++---------------------------------
 1 file changed, 63 insertions(+), 104 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1480,16 +1480,12 @@ static void __uclamp_update_util_min_rt_
 
 static void uclamp_update_util_min_rt_default(struct task_struct *p)
 {
-	struct rq_flags rf;
-	struct rq *rq;
-
 	if (!rt_task(p))
 		return;
 
 	/* Protect updates to p->uclamp_* */
-	rq = task_rq_lock(p, &rf);
+	guard(task_rq_lock)(p);
 	__uclamp_update_util_min_rt_default(p);
-	task_rq_unlock(rq, p, &rf);
 }
 
 static inline struct uclamp_se
@@ -1785,9 +1781,8 @@ static void uclamp_update_root_tg(void)
 	uclamp_se_set(&tg->uclamp_req[UCLAMP_MAX],
 		      sysctl_sched_uclamp_util_max, false);
 
-	rcu_read_lock();
+	guard(rcu)();
 	cpu_util_update_eff(&root_task_group.css);
-	rcu_read_unlock();
 }
 #else
 static void uclamp_update_root_tg(void) { }
@@ -1814,10 +1809,9 @@ static void uclamp_sync_util_min_rt_defa
 	smp_mb__after_spinlock();
 	read_unlock(&tasklist_lock);
 
-	rcu_read_lock();
+	guard(rcu)();
 	for_each_process_thread(g, p)
 		uclamp_update_util_min_rt_default(p);
-	rcu_read_unlock();
 }
 
 static int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
@@ -2250,20 +2244,13 @@ static __always_inline
 int task_state_match(struct task_struct *p, unsigned int state)
 {
 #ifdef CONFIG_PREEMPT_RT
-	int match;
-
 	/*
 	 * Serialize against current_save_and_set_rtlock_wait_state() and
 	 * current_restore_rtlock_saved_state().
 	 */
-	raw_spin_lock_irq(&p->pi_lock);
-	match = __task_state_match(p, state);
-	raw_spin_unlock_irq(&p->pi_lock);
-
-	return match;
-#else
-	return __task_state_match(p, state);
+	guard(raw_spinlock_irq)(&p->pi_lock);
 #endif
+	return __task_state_match(p, state);
 }
 
 /*
@@ -2417,10 +2404,9 @@ void migrate_disable(void)
 		return;
 	}
 
-	preempt_disable();
+	guard(preempt)();
 	this_rq()->nr_pinned++;
 	p->migration_disabled = 1;
-	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(migrate_disable);
 
@@ -2444,7 +2430,7 @@ void migrate_enable(void)
 	 * Ensure stop_task runs either before or after this, and that
 	 * __set_cpus_allowed_ptr(SCA_MIGRATE_ENABLE) doesn't schedule().
 	 */
-	preempt_disable();
+	guard(preempt)();
 	if (p->cpus_ptr != &p->cpus_mask)
 		__set_cpus_allowed_ptr(p, &ac);
 	/*
@@ -2455,7 +2441,6 @@ void migrate_enable(void)
 	barrier();
 	p->migration_disabled = 0;
 	this_rq()->nr_pinned--;
-	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(migrate_enable);
 
@@ -3516,13 +3501,11 @@ int migrate_swap(struct task_struct *cur
  */
 void kick_process(struct task_struct *p)
 {
-	int cpu;
+	guard(preempt)();
+	int cpu = task_cpu(p);
 
-	preempt_disable();
-	cpu = task_cpu(p);
 	if ((cpu != smp_processor_id()) && task_curr(p))
 		smp_send_reschedule(cpu);
-	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(kick_process);
 
@@ -6367,8 +6350,9 @@ static void sched_core_balance(struct rq
 	struct sched_domain *sd;
 	int cpu = cpu_of(rq);
 
-	preempt_disable();
-	rcu_read_lock();
+	guard(preempt)();
+	guard(rcu)();
+
 	raw_spin_rq_unlock_irq(rq);
 	for_each_domain(cpu, sd) {
 		if (need_resched())
@@ -6378,8 +6362,6 @@ static void sched_core_balance(struct rq
 			break;
 	}
 	raw_spin_rq_lock_irq(rq);
-	rcu_read_unlock();
-	preempt_enable();
 }
 
 static DEFINE_PER_CPU(struct balance_callback, core_balance_head);
@@ -8257,8 +8239,6 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pi
 #ifdef CONFIG_SMP
 int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask)
 {
-	int ret = 0;
-
 	/*
 	 * If the task isn't a deadline task or admission control is
 	 * disabled then we don't care about affinity changes.
@@ -8272,11 +8252,11 @@ int dl_task_check_affinity(struct task_s
 	 * tasks allowed to run on all the CPUs in the task's
 	 * root_domain.
 	 */
-	rcu_read_lock();
+	guard(rcu)();
 	if (!cpumask_subset(task_rq(p)->rd->span, mask))
-		ret = -EBUSY;
-	rcu_read_unlock();
-	return ret;
+		return -EBUSY;
+
+	return 0;
 }
 #endif
 
@@ -10508,11 +10488,9 @@ static int cpu_cgroup_css_online(struct
 
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 	/* Propagate the effective uclamp value for the new group */
-	mutex_lock(&uclamp_mutex);
-	rcu_read_lock();
+	guard(mutex)(&uclamp_mutex);
+	guard(rcu)();
 	cpu_util_update_eff(css);
-	rcu_read_unlock();
-	mutex_unlock(&uclamp_mutex);
 #endif
 
 	return 0;
@@ -10663,8 +10641,8 @@ static ssize_t cpu_uclamp_write(struct k
 
 	static_branch_enable(&sched_uclamp_used);
 
-	mutex_lock(&uclamp_mutex);
-	rcu_read_lock();
+	guard(mutex)(&uclamp_mutex);
+	guard(rcu)();
 
 	tg = css_tg(of_css(of));
 	if (tg->uclamp_req[clamp_id].value != req.util)
@@ -10679,9 +10657,6 @@ static ssize_t cpu_uclamp_write(struct k
 	/* Update effective clamps to track the most restrictive value */
 	cpu_util_update_eff(of_css(of));
 
-	rcu_read_unlock();
-	mutex_unlock(&uclamp_mutex);
-
 	return nbytes;
 }
 
@@ -10707,10 +10682,10 @@ static inline void cpu_uclamp_print(stru
 	u64 percent;
 	u32 rem;
 
-	rcu_read_lock();
-	tg = css_tg(seq_css(sf));
-	util_clamp = tg->uclamp_req[clamp_id].value;
-	rcu_read_unlock();
+	scoped_guard (rcu) {
+		tg = css_tg(seq_css(sf));
+		util_clamp = tg->uclamp_req[clamp_id].value;
+	}
 
 	if (util_clamp == SCHED_CAPACITY_SCALE) {
 		seq_puts(sf, "max\n");
@@ -11032,7 +11007,6 @@ static int tg_cfs_schedulable_down(struc
 
 static int __cfs_schedulable(struct task_group *tg, u64 period, u64 quota)
 {
-	int ret;
 	struct cfs_schedulable_data data = {
 		.tg = tg,
 		.period = period,
@@ -11044,11 +11018,8 @@ static int __cfs_schedulable(struct task
 		do_div(data.quota, NSEC_PER_USEC);
 	}
 
-	rcu_read_lock();
-	ret = walk_tg_tree(tg_cfs_schedulable_down, tg_nop, &data);
-	rcu_read_unlock();
-
-	return ret;
+	guard(rcu)();
+	return walk_tg_tree(tg_cfs_schedulable_down, tg_nop, &data);
 }
 
 static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
@@ -11653,14 +11624,12 @@ int __sched_mm_cid_migrate_from_fetch_ci
 	 * are not the last task to be migrated from this cpu for this mm, so
 	 * there is no need to move src_cid to the destination cpu.
 	 */
-	rcu_read_lock();
+	guard(rcu)();
 	src_task = rcu_dereference(src_rq->curr);
 	if (READ_ONCE(src_task->mm_cid_active) && src_task->mm == mm) {
-		rcu_read_unlock();
 		t->last_mm_cid = -1;
 		return -1;
 	}
-	rcu_read_unlock();
 
 	return src_cid;
 }
@@ -11704,18 +11673,17 @@ int __sched_mm_cid_migrate_from_try_stea
 	 * the lazy-put flag, this task will be responsible for transitioning
 	 * from lazy-put flag set to MM_CID_UNSET.
 	 */
-	rcu_read_lock();
-	src_task = rcu_dereference(src_rq->curr);
-	if (READ_ONCE(src_task->mm_cid_active) && src_task->mm == mm) {
-		rcu_read_unlock();
-		/*
-		 * We observed an active task for this mm, there is therefore
-		 * no point in moving this cid to the destination cpu.
-		 */
-		t->last_mm_cid = -1;
-		return -1;
+	scoped_guard (rcu) {
+		src_task = rcu_dereference(src_rq->curr);
+		if (READ_ONCE(src_task->mm_cid_active) && src_task->mm == mm) {
+			/*
+			 * We observed an active task for this mm, there is therefore
+			 * no point in moving this cid to the destination cpu.
+			 */
+			t->last_mm_cid = -1;
+			return -1;
+		}
 	}
-	rcu_read_unlock();
 
 	/*
 	 * The src_cid is unused, so it can be unset.
@@ -11788,7 +11756,6 @@ static void sched_mm_cid_remote_clear(st
 {
 	struct rq *rq = cpu_rq(cpu);
 	struct task_struct *t;
-	unsigned long flags;
 	int cid, lazy_cid;
 
 	cid = READ_ONCE(pcpu_cid->cid);
@@ -11823,23 +11790,21 @@ static void sched_mm_cid_remote_clear(st
 	 * the lazy-put flag, that task will be responsible for transitioning
 	 * from lazy-put flag set to MM_CID_UNSET.
 	 */
-	rcu_read_lock();
-	t = rcu_dereference(rq->curr);
-	if (READ_ONCE(t->mm_cid_active) && t->mm == mm) {
-		rcu_read_unlock();
-		return;
+	scoped_guard (rcu) {
+		t = rcu_dereference(rq->curr);
+		if (READ_ONCE(t->mm_cid_active) && t->mm == mm)
+			return;
 	}
-	rcu_read_unlock();
 
 	/*
 	 * The cid is unused, so it can be unset.
 	 * Disable interrupts to keep the window of cid ownership without rq
 	 * lock small.
 	 */
-	local_irq_save(flags);
-	if (try_cmpxchg(&pcpu_cid->cid, &lazy_cid, MM_CID_UNSET))
-		__mm_cid_put(mm, cid);
-	local_irq_restore(flags);
+	scoped_guard (irqsave) {
+		if (try_cmpxchg(&pcpu_cid->cid, &lazy_cid, MM_CID_UNSET))
+			__mm_cid_put(mm, cid);
+	}
 }
 
 static void sched_mm_cid_remote_clear_old(struct mm_struct *mm, int cpu)
@@ -11861,14 +11826,13 @@ static void sched_mm_cid_remote_clear_ol
 	 * snapshot associated with this cid if an active task using the mm is
 	 * observed on this rq.
 	 */
-	rcu_read_lock();
-	curr = rcu_dereference(rq->curr);
-	if (READ_ONCE(curr->mm_cid_active) && curr->mm == mm) {
-		WRITE_ONCE(pcpu_cid->time, rq_clock);
-		rcu_read_unlock();
-		return;
+	scoped_guard (rcu) {
+		curr = rcu_dereference(rq->curr);
+		if (READ_ONCE(curr->mm_cid_active) && curr->mm == mm) {
+			WRITE_ONCE(pcpu_cid->time, rq_clock);
+			return;
+		}
 	}
-	rcu_read_unlock();
 
 	if (rq_clock < pcpu_cid->time + SCHED_MM_CID_PERIOD_NS)
 		return;
@@ -11962,7 +11926,6 @@ void task_tick_mm_cid(struct rq *rq, str
 void sched_mm_cid_exit_signals(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
-	struct rq_flags rf;
 	struct rq *rq;
 
 	if (!mm)
@@ -11970,7 +11933,7 @@ void sched_mm_cid_exit_signals(struct ta
 
 	preempt_disable();
 	rq = this_rq();
-	rq_lock_irqsave(rq, &rf);
+	guard(rq_lock_irqsave)(rq);
 	preempt_enable_no_resched();	/* holding spinlock */
 	WRITE_ONCE(t->mm_cid_active, 0);
 	/*
@@ -11980,13 +11943,11 @@ void sched_mm_cid_exit_signals(struct ta
 	smp_mb();
 	mm_cid_put(mm);
 	t->last_mm_cid = t->mm_cid = -1;
-	rq_unlock_irqrestore(rq, &rf);
 }
 
 void sched_mm_cid_before_execve(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
-	struct rq_flags rf;
 	struct rq *rq;
 
 	if (!mm)
@@ -11994,7 +11955,7 @@ void sched_mm_cid_before_execve(struct t
 
 	preempt_disable();
 	rq = this_rq();
-	rq_lock_irqsave(rq, &rf);
+	guard(rq_lock_irqsave)(rq);
 	preempt_enable_no_resched();	/* holding spinlock */
 	WRITE_ONCE(t->mm_cid_active, 0);
 	/*
@@ -12004,13 +11965,11 @@ void sched_mm_cid_before_execve(struct t
 	smp_mb();
 	mm_cid_put(mm);
 	t->last_mm_cid = t->mm_cid = -1;
-	rq_unlock_irqrestore(rq, &rf);
 }
 
 void sched_mm_cid_after_execve(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
-	struct rq_flags rf;
 	struct rq *rq;
 
 	if (!mm)
@@ -12018,16 +11977,16 @@ void sched_mm_cid_after_execve(struct ta
 
 	preempt_disable();
 	rq = this_rq();
-	rq_lock_irqsave(rq, &rf);
-	preempt_enable_no_resched();	/* holding spinlock */
-	WRITE_ONCE(t->mm_cid_active, 1);
-	/*
-	 * Store t->mm_cid_active before loading per-mm/cpu cid.
-	 * Matches barrier in sched_mm_cid_remote_clear_old().
-	 */
-	smp_mb();
-	t->last_mm_cid = t->mm_cid = mm_cid_get(rq, mm);
-	rq_unlock_irqrestore(rq, &rf);
+	scoped_guard (rq_lock_irqsave, rq) {
+		preempt_enable_no_resched();	/* holding spinlock */
+		WRITE_ONCE(t->mm_cid_active, 1);
+		/*
+		 * Store t->mm_cid_active before loading per-mm/cpu cid.
+		 * Matches barrier in sched_mm_cid_remote_clear_old().
+		 */
+		smp_mb();
+		t->last_mm_cid = t->mm_cid = mm_cid_get(rq, mm);
+	}
 	rseq_set_notify_resume(t);
 }
 


