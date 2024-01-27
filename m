Return-Path: <linux-kernel+bounces-41152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8035183ECA4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 11:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D871C21D08
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 10:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE1F1EA76;
	Sat, 27 Jan 2024 10:09:15 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C533E21352;
	Sat, 27 Jan 2024 10:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706350154; cv=none; b=RRIwJG0r9M6d2F1Hfyfp0SnGw+DbB+kSDp7oSlkKDwYLkgTsAbjVXs5idODnB/ddTz7F8Q2pmOf31s8b/BlaQPaNArNwoVUgLXgiWlioDRJG2FoNVm1p0xUW+hYGdetB/0rr1NQ/ZA1wmDXeA6UNyWI/bXHHrU7K50OxmDrI3zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706350154; c=relaxed/simple;
	bh=juV0JcssHDpWJTEemuYAlau+Mk5jWYOUWwXkB8j0MCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hC7P+UfyhIbTvTCb78CWZ0WMmEtxFuQg9ps2NGlHoHc7e5DUWrg74yhA0J007fEnyZP5LNSoLfwmiM0JTgcujazurk0/S3VpK3+Suu8+6YAGMFGA/mj0gT2vpMTsWz3S4dT+gKZZpHL/EQdWi54NlqKiybxlgl1LU1Icj+38ii8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TMVcb3BpdzsWYQ;
	Sat, 27 Jan 2024 18:07:59 +0800 (CST)
Received: from dggpemd100005.china.huawei.com (unknown [7.185.36.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 314FB1404FC;
	Sat, 27 Jan 2024 18:09:06 +0800 (CST)
Received: from [10.67.108.67] (10.67.108.67) by dggpemd100005.china.huawei.com
 (7.185.36.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Sat, 27 Jan
 2024 18:09:05 +0800
Message-ID: <a5bfe45f-34ef-0c06-b4c1-9ed83ce42c9a@huawei.com>
Date: Sat, 27 Jan 2024 18:09:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH v2] kprobes: Use synchronize_rcu_tasks_rude in
 kprobe_optimizer
Content-Language: en-US
To: "paulmck@kernel.org" <paulmck@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	yangjihong <yangjihong1@huawei.com>, "naveen.n.rao@linux.ibm.com"
	<naveen.n.rao@linux.ibm.com>, "anil.s.keshavamurthy@intel.com"
	<anil.s.keshavamurthy@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "mhiramat@kernel.org" <mhiramat@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "peterz@infradead.org" <peterz@infradead.org>,
	"pmladek@suse.com" <pmladek@suse.com>, "dianders@chromium.org"
	<dianders@chromium.org>, "npiggin@gmail.com" <npiggin@gmail.com>,
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>, "jkl820.git@gmail.com"
	<jkl820.git@gmail.com>, "juerg.haefliger@canonical.com"
	<juerg.haefliger@canonical.com>, "rick.p.edgecombe@intel.com"
	<rick.p.edgecombe@intel.com>, "eric.devolder@oracle.com"
	<eric.devolder@oracle.com>, "mic@digikod.net" <mic@digikod.net>
References: <20240118021842.290665-1-chenzhongjin@huawei.com>
 <bc485622-2e69-46e6-b95f-c1b4868e8d53@paulmck-laptop>
 <1b349ff9-db82-4d60-8290-1ca74bc78fb4@paulmck-laptop>
From: Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <1b349ff9-db82-4d60-8290-1ca74bc78fb4@paulmck-laptop>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemd100005.china.huawei.com (7.185.36.102)

On 2024/1/20 23:30, Paul E. McKenney wrote:

Hi Paul,
This patch works for my reproduce test case.

Just a small question, if you dont mind, this problem exsit on LTS 
version but we had struct rcu_tasks_percpu after v5.17. We can't 
backport this patch to LTS 5.10 or 4.19, which are still under maintaince.
If you have any idea or plan to apply this patch to elder version, 
please tell me, thanks very much!

Anyway, it's ok to apply this patch to mainline.

Best,
Chen

>> Again, that comment reads in full as follows:
>>
>> 	/*
>> 	 * Step 2: Wait for quiesence period to ensure all potentially
>> 	 * preempted tasks to have normally scheduled. Because optprobe
>> 	 * may modify multiple instructions, there is a chance that Nth
>> 	 * instruction is preempted. In that case, such tasks can return
>> 	 * to 2nd-Nth byte of jump instruction. This wait is for avoiding it.
>> 	 * Note that on non-preemptive kernel, this is transparently converted
>> 	 * to synchronoze_sched() to wait for all interrupts to have completed.
>> 	 */
>>
>> Please note well that first sentence.
>>
>> Unless that first sentence no longer holds, this patch cannot work
>> because synchronize_rcu_tasks_rude() will not (repeat, NOT) wait for
>> preempted tasks.
>>
>> So how to safely break this deadlock?  Reproducing Chen Zhongjin's
>> diagram:
>>
>> pid A				pid B			pid C
>> kprobe_optimizer()		do_exit()		perf_kprobe_init()
>> mutex_lock(&kprobe_mutex)	exit_tasks_rcu_start()	mutex_lock(&kprobe_mutex)
>> synchronize_rcu_tasks()		zap_pid_ns_processes()	// waiting kprobe_mutex
>> // waiting tasks_rcu_exit_srcu	kernel_wait4()
>> 				// waiting pid C exit
>>
>> We need to stop synchronize_rcu_tasks() from waiting on tasks like
>> pid B that are voluntarily blocked.  One way to do that is to replace
>> SRCU with a set of per-CPU lists.  Then exit_tasks_rcu_start() adds the
>> current task to this list and does ...
>>
>> OK, this is getting a bit involved.  If you would like to follow along,
>> please feel free to look here:
>>
>> https://docs.google.com/document/d/1MEHHs5qbbZBzhN8dGP17pt-d87WptFJ2ZQcqS221d9I/edit?usp=sharing
> 
> And please see below for a prototype patch, which passes moderate
> rcutorture testing.
> 
> Chen Zhongjin, does this prevent the deadlock you have been seeing?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 113fe0eeabe7a83e87d638d44b9e1d0f9691b146
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Sat Jan 20 07:07:08 2024 -0800
> 
>      rcu-tasks: Eliminate deadlocks involving do_exit() and RCU tasks
>      
>      Holding a mutex across synchronize_rcu_tasks() and acquiring
>      that same mutex in code called from do_exit() after its call to
>      exit_tasks_rcu_start() but before its call to exit_tasks_rcu_stop()
>      results in deadlock.  This is by design, because tasks that are far
>      enough into do_exit() are no longer present on the tasks list, making
>      it a bit difficult for RCU Tasks to find them, let alone wait on them
>      to do a voluntary context switch.  However, such deadlocks are becoming
>      more frequent.  In addition, lockdep currently does not detect such
>      deadlocks and they can be difficult to reproduce.
>      
>      In addition, if a task voluntarily context switches during that time
>      (for example, if it blocks acquiring a mutex), then this task is in an
>      RCU Tasks quiescent state.  And with some adjustments, RCU Tasks could
>      just as well take advantage of that fact.
>      
>      This commit therefore eliminates these deadlock by replacing the
>      SRCU-based wait for do_exit() completion with per-CPU lists of tasks
>      currently exiting.  A given task will be on one of these per-CPU lists for
>      the same period of time that this task would previously have been in the
>      previous SRCU read-side critical section.  These lists enable RCU Tasks
>      to find the tasks that have already been removed from the tasks list,
>      but that must nevertheless be waited upon.
>      
>      The RCU Tasks grace period gathers any of these do_exit() tasks that it
>      must wait on, and adds them to the list of holdouts.  Per-CPU locking
>      and get_task_struct() are used to synchronize addition to and removal
>      from these lists.
>      
>      Link: https://lore.kernel.org/all/20240118021842.290665-1-chenzhongjin@huawei.com/
>      
>      Reported-by: Chen Zhongjin <chenzhongjin@huawei.com>
>      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index dddd10b1b815..3fe36befb613 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -855,6 +855,8 @@ struct task_struct {
>   	u8				rcu_tasks_idx;
>   	int				rcu_tasks_idle_cpu;
>   	struct list_head		rcu_tasks_holdout_list;
> +	int				rcu_tasks_exit_cpu;
> +	struct list_head		rcu_tasks_exit_list;
>   #endif /* #ifdef CONFIG_TASKS_RCU */
>   
>   #ifdef CONFIG_TASKS_TRACE_RCU
> diff --git a/init/init_task.c b/init/init_task.c
> index 5727d42149c3..65f037bff457 100644
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -152,6 +152,7 @@ struct task_struct init_task
>   	.rcu_tasks_holdout = false,
>   	.rcu_tasks_holdout_list = LIST_HEAD_INIT(init_task.rcu_tasks_holdout_list),
>   	.rcu_tasks_idle_cpu = -1,
> +	.rcu_tasks_exit_list = LIST_HEAD_INIT(init_task.rcu_tasks_exit_list),
>   #endif
>   #ifdef CONFIG_TASKS_TRACE_RCU
>   	.trc_reader_nesting = 0,
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 10917c3e1f03..6bacd515e0eb 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1981,6 +1981,7 @@ static inline void rcu_copy_process(struct task_struct *p)
>   	p->rcu_tasks_holdout = false;
>   	INIT_LIST_HEAD(&p->rcu_tasks_holdout_list);
>   	p->rcu_tasks_idle_cpu = -1;
> +	INIT_LIST_HEAD(&p->rcu_tasks_exit_list);
>   #endif /* #ifdef CONFIG_TASKS_RCU */
>   #ifdef CONFIG_TASKS_TRACE_RCU
>   	p->trc_reader_nesting = 0;
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 732ad5b39946..bd4a51fd5b1f 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -32,6 +32,7 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
>    * @rtp_irq_work: IRQ work queue for deferred wakeups.
>    * @barrier_q_head: RCU callback for barrier operation.
>    * @rtp_blkd_tasks: List of tasks blocked as readers.
> + * @rtp_exit_list: List of tasks in the latter portion of do_exit().
>    * @cpu: CPU number corresponding to this entry.
>    * @rtpp: Pointer to the rcu_tasks structure.
>    */
> @@ -46,6 +47,7 @@ struct rcu_tasks_percpu {
>   	struct irq_work rtp_irq_work;
>   	struct rcu_head barrier_q_head;
>   	struct list_head rtp_blkd_tasks;
> +	struct list_head rtp_exit_list;
>   	int cpu;
>   	struct rcu_tasks *rtpp;
>   };
> @@ -144,8 +146,6 @@ static struct rcu_tasks rt_name =							\
>   }
>   
>   #ifdef CONFIG_TASKS_RCU
> -/* Track exiting tasks in order to allow them to be waited for. */
> -DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
>   
>   /* Report delay in synchronize_srcu() completion in rcu_tasks_postscan(). */
>   static void tasks_rcu_exit_srcu_stall(struct timer_list *unused);
> @@ -275,6 +275,8 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
>   		rtpcp->rtpp = rtp;
>   		if (!rtpcp->rtp_blkd_tasks.next)
>   			INIT_LIST_HEAD(&rtpcp->rtp_blkd_tasks);
> +		if (!rtpcp->rtp_exit_list.next)
> +			INIT_LIST_HEAD(&rtpcp->rtp_exit_list);
>   	}
>   
>   	pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=%d.\n", rtp->name,
> @@ -851,10 +853,12 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
>   //	number of voluntary context switches, and add that task to the
>   //	holdout list.
>   // rcu_tasks_postscan():
> -//	Invoke synchronize_srcu() to ensure that all tasks that were
> -//	in the process of exiting (and which thus might not know to
> -//	synchronize with this RCU Tasks grace period) have completed
> -//	exiting.
> +//	Gather per-CPU lists of tasks in do_exit() to ensure that all
> +//	tasks that were in the process of exiting (and which thus might
> +//	not know to synchronize with this RCU Tasks grace period) have
> +//	completed exiting.  The synchronize_rcu() in rcu_tasks_postgp()
> +//	will take care of any tasks stuck in the non-preemptible region
> +//	of do_exit() following its call to exit_tasks_rcu_stop().
>   // check_all_holdout_tasks(), repeatedly until holdout list is empty:
>   //	Scans the holdout list, attempting to identify a quiescent state
>   //	for each task on the list.  If there is a quiescent state, the
> @@ -867,8 +871,10 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
>   //	with interrupts disabled.
>   //
>   // For each exiting task, the exit_tasks_rcu_start() and
> -// exit_tasks_rcu_finish() functions begin and end, respectively, the SRCU
> -// read-side critical sections waited for by rcu_tasks_postscan().
> +// exit_tasks_rcu_finish() functions add and remove, respectively, the
> +// current task to a per-CPU list of tasks that rcu_tasks_postscan() must
> +// wait on.  This is necessary because rcu_tasks_postscan() must wait on
> +// tasks that have already been removed from the global list of tasks.
>   //
>   // Pre-grace-period update-side code is ordered before the grace
>   // via the raw_spin_lock.*rcu_node().  Pre-grace-period read-side code
> @@ -932,9 +938,13 @@ static void rcu_tasks_pertask(struct task_struct *t, struct list_head *hop)
>   	}
>   }
>   
> +void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func);
> +DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks, "RCU Tasks");
> +
>   /* Processing between scanning taskslist and draining the holdout list. */
>   static void rcu_tasks_postscan(struct list_head *hop)
>   {
> +	int cpu;
>   	int rtsi = READ_ONCE(rcu_task_stall_info);
>   
>   	if (!IS_ENABLED(CONFIG_TINY_RCU)) {
> @@ -948,9 +958,9 @@ static void rcu_tasks_postscan(struct list_head *hop)
>   	 * this, divide the fragile exit path part in two intersecting
>   	 * read side critical sections:
>   	 *
> -	 * 1) An _SRCU_ read side starting before calling exit_notify(),
> -	 *    which may remove the task from the tasklist, and ending after
> -	 *    the final preempt_disable() call in do_exit().
> +	 * 1) A task_struct list addition before calling exit_notify(),
> +	 *    which may remove the task from the tasklist, with the
> +	 *    removal after the final preempt_disable() call in do_exit().
>   	 *
>   	 * 2) An _RCU_ read side starting with the final preempt_disable()
>   	 *    call in do_exit() and ending with the final call to schedule()
> @@ -959,7 +969,18 @@ static void rcu_tasks_postscan(struct list_head *hop)
>   	 * This handles the part 1). And postgp will handle part 2) with a
>   	 * call to synchronize_rcu().
>   	 */
> -	synchronize_srcu(&tasks_rcu_exit_srcu);
> +
> +	for_each_possible_cpu(cpu) {
> +		unsigned long flags;
> +		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, cpu);
> +		struct task_struct *t;
> +
> +		raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
> +		list_for_each_entry(t, &rtpcp->rtp_exit_list, rcu_tasks_exit_list)
> +			if (list_empty(&t->rcu_tasks_holdout_list))
> +				rcu_tasks_pertask(t, hop);
> +		raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
> +	}
>   
>   	if (!IS_ENABLED(CONFIG_TINY_RCU))
>   		del_timer_sync(&tasks_rcu_exit_srcu_stall_timer);
> @@ -1027,7 +1048,6 @@ static void rcu_tasks_postgp(struct rcu_tasks *rtp)
>   	 *
>   	 * In addition, this synchronize_rcu() waits for exiting tasks
>   	 * to complete their final preempt_disable() region of execution,
> -	 * cleaning up after synchronize_srcu(&tasks_rcu_exit_srcu),
>   	 * enforcing the whole region before tasklist removal until
>   	 * the final schedule() with TASK_DEAD state to be an RCU TASKS
>   	 * read side critical section.
> @@ -1035,9 +1055,6 @@ static void rcu_tasks_postgp(struct rcu_tasks *rtp)
>   	synchronize_rcu();
>   }
>   
> -void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func);
> -DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks, "RCU Tasks");
> -
>   static void tasks_rcu_exit_srcu_stall(struct timer_list *unused)
>   {
>   #ifndef CONFIG_TINY_RCU
> @@ -1147,25 +1164,45 @@ struct task_struct *get_rcu_tasks_gp_kthread(void)
>   EXPORT_SYMBOL_GPL(get_rcu_tasks_gp_kthread);
>   
>   /*
> - * Contribute to protect against tasklist scan blind spot while the
> - * task is exiting and may be removed from the tasklist. See
> - * corresponding synchronize_srcu() for further details.
> + * Protect against tasklist scan blind spot while the task is exiting and
> + * may be removed from the tasklist.  Do this by adding the task to yet
> + * another list.
>    */
> -void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
> +void exit_tasks_rcu_start(void)
>   {
> -	current->rcu_tasks_idx = __srcu_read_lock(&tasks_rcu_exit_srcu);
> +	unsigned long flags;
> +	struct rcu_tasks_percpu *rtpcp;
> +	struct task_struct *t = current;
> +
> +	WARN_ON_ONCE(!list_empty(&t->rcu_tasks_exit_list));
> +	get_task_struct(t);
> +	preempt_disable();
> +	rtpcp = this_cpu_ptr(rcu_tasks.rtpcpu);
> +	t->rcu_tasks_exit_cpu = smp_processor_id();
> +	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
> +	if (!rtpcp->rtp_exit_list.next)
> +		INIT_LIST_HEAD(&rtpcp->rtp_exit_list);
> +	list_add(&t->rcu_tasks_exit_list, &rtpcp->rtp_exit_list);
> +	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
> +	preempt_enable();
>   }
>   
>   /*
> - * Contribute to protect against tasklist scan blind spot while the
> - * task is exiting and may be removed from the tasklist. See
> - * corresponding synchronize_srcu() for further details.
> + * Remove the task from the "yet another list" because do_exit() is now
> + * non-preemptible, allowing synchronize_rcu() to wait beyond this point.
>    */
> -void exit_tasks_rcu_stop(void) __releases(&tasks_rcu_exit_srcu)
> +void exit_tasks_rcu_stop(void)
>   {
> +	unsigned long flags;
> +	struct rcu_tasks_percpu *rtpcp;
>   	struct task_struct *t = current;
>   
> -	__srcu_read_unlock(&tasks_rcu_exit_srcu, t->rcu_tasks_idx);
> +	WARN_ON_ONCE(list_empty(&t->rcu_tasks_exit_list));
> +	rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, t->rcu_tasks_exit_cpu);
> +	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
> +	list_del_init(&t->rcu_tasks_exit_list);
> +	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
> +	put_task_struct(t);
>   }
>   
>   /*

