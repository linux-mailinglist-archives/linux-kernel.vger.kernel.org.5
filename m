Return-Path: <linux-kernel+bounces-51307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D51848917
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 23:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29DD284203
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 22:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDAC134AE;
	Sat,  3 Feb 2024 22:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hl5T7dCU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E58C134C6;
	Sat,  3 Feb 2024 22:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706997608; cv=none; b=uSsS2D6sFEZCd0NWYNIDvINP2DCkD9DmCZhHHzoKmrH74DsSo4nFp1SLIza4TANkcWmkt9cUVyY9VPVJtSwbKD97pR8rHiIdkIp9kA0uFbQguo/4Xvm5ENN8VAY9cu3PXEcT52reN7Zlaz/dPvImwMTwpPdHL8cvkufNe0YgSJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706997608; c=relaxed/simple;
	bh=7XPY5aPtdjOpUT48dzCP8uj1o5iaIeQSyTChtYnMAQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKR7UkocavMx7R/331pN2F76rfHNIK3qXUcb3z6L0WtiwWz1svv/8nmQe0jvh2dJ7Uk8PT2/EVFdGM1Wiynav5X/Y3zrbaELb/spjlVBZeuVlF3ixkcorP4Q3fjK5KLEx/c8qCc/NJuVW7xEucev8CIQvEYiBVn5cHaBIPA44wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hl5T7dCU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E421BC433C7;
	Sat,  3 Feb 2024 22:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706997608;
	bh=7XPY5aPtdjOpUT48dzCP8uj1o5iaIeQSyTChtYnMAQ0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=hl5T7dCU0kuz9U6TcpEvpW9lP1gjjPT7lZm+5FUNDqrZ/GnZZJ17TkC6xrgSLNfUy
	 bqA4Kppi3VcaXFE+7IeDXJbIzPhlbUkvhLInLQkIThywIIGqDykGl3vh8OQsYNrO4W
	 aIiKAC41dhDWL2lTH6yLwxJMTcwI6F6mKsUsL3E+PhHSoX2vOuN/nHJyRGL9lljCOl
	 sYu50zHwtObAeeZJr7LsoWVNN/tLWp76EqUMtbkGa9VoZ+yP/P7S247J2xSv1Eo6wr
	 dx9DTOnA/+BhH7P16ntFdhucv6y7XSj26do5nXlVT0ZCwjqxa9AHvgvp9PJIlvXRrs
	 Ga6F5ui68dQYw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 66014CE0D05; Sat,  3 Feb 2024 14:00:03 -0800 (PST)
Date: Sat, 3 Feb 2024 14:00:03 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Yang Jihong <yangjihong1@huawei.com>
Cc: Chen Zhongjin <chenzhongjin@huawei.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, naveen.n.rao@linux.ibm.com,
	anil.s.keshavamurthy@intel.com, davem@davemloft.net,
	mhiramat@kernel.org, akpm@linux-foundation.org, tglx@linutronix.de,
	peterz@infradead.org, pmladek@suse.com, dianders@chromium.org,
	npiggin@gmail.com, mpe@ellerman.id.au, jkl820.git@gmail.com,
	juerg.haefliger@canonical.com, rick.p.edgecombe@intel.com,
	eric.devolder@oracle.com, mic@digikod.net
Subject: Re: [RFC PATCH] kprobes: Use synchronize_rcu_tasks_rude in
 kprobe_optimizer
Message-ID: <d970cda7-bf17-49c5-85b9-7596beb3690b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240102034024.256326-1-chenzhongjin@huawei.com>
 <29eaed4d-c4e5-cf9b-113b-da146b719820@huawei.com>
 <d7cb96d8-86e1-423d-a135-46b4e472fe9e@paulmck-laptop>
 <d7dfe177-6bfb-63c2-9be5-6ad25c8c243e@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7dfe177-6bfb-63c2-9be5-6ad25c8c243e@huawei.com>

On Mon, Jan 29, 2024 at 08:58:10AM +0800, Yang Jihong wrote:
> Hello,
> 
> On 2024/1/28 3:22, Paul E. McKenney wrote:
> > On Tue, Jan 09, 2024 at 07:28:29PM +0800, Yang Jihong wrote:
> > > Hello,
> > > 
> > > PING.
> > > 
> > > I had a similar problem. Is this solution feasible?
> > 
> > Sadly, no.
> > 
> > It fails on CONFIG_PREEMPT=y kernels because synchronize_rcu_tasks_rude()
> > will not wait on tasks that have been preempted while executing in
> > a trampoline.
> > 
> > But could you please try out the patch shown at the end of this email?
> 
> Thanks for the patch, yes, I've tested and it solves the problem.

Very good, and thank you for testing it!

May I apply your Tested-by to the commit to record your efforts for
posterity?

							Thanx, Paul

> > > Thanks,
> > > Yang
> > > 
> > > On 2024/1/2 11:40, Chen Zhongjin wrote:
> > > > There is a deadlock scenario in kprobe_optimizer():
> > > > 
> > > > pid A				pid B			pid C
> > > > kprobe_optimizer()		do_exit()		perf_kprobe_init()
> > > > mutex_lock(&kprobe_mutex)	exit_tasks_rcu_start()	mutex_lock(&kprobe_mutex)
> > > > synchronize_rcu_tasks()		zap_pid_ns_processes()	// waiting kprobe_mutex
> > > > // waiting tasks_rcu_exit_srcu	kernel_wait4()
> > > > 				// waiting pid C exit
> > > > 
> > > > To avoid this deadlock loop, use synchronize_rcu_tasks_rude() in kprobe_optimizer()
> > > > rather than synchronize_rcu_tasks(). synchronize_rcu_tasks_rude() can also promise
> > > > that all preempted tasks have scheduled, but it will not wait tasks_rcu_exit_srcu.
> > > > 
> > > > Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> > > > ---
> > > >    arch/Kconfig     | 2 +-
> > > >    kernel/kprobes.c | 2 +-
> > > >    2 files changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/arch/Kconfig b/arch/Kconfig
> > > > index f4b210ab0612..dc6a18854017 100644
> > > > --- a/arch/Kconfig
> > > > +++ b/arch/Kconfig
> > > > @@ -104,7 +104,7 @@ config STATIC_CALL_SELFTEST
> > > >    config OPTPROBES
> > > >    	def_bool y
> > > >    	depends on KPROBES && HAVE_OPTPROBES
> > > > -	select TASKS_RCU if PREEMPTION
> > > > +	select TASKS_RUDE_RCU
> > > >    config KPROBES_ON_FTRACE
> > > >    	def_bool y
> > > > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > > > index d5a0ee40bf66..09056ae50c58 100644
> > > > --- a/kernel/kprobes.c
> > > > +++ b/kernel/kprobes.c
> > > > @@ -623,7 +623,7 @@ static void kprobe_optimizer(struct work_struct *work)
> > > >    	 * Note that on non-preemptive kernel, this is transparently converted
> > > >    	 * to synchronoze_sched() to wait for all interrupts to have completed.
> > > >    	 */
> > > > -	synchronize_rcu_tasks();
> > > > +	synchronize_rcu_tasks_rude();
> > > >    	/* Step 3: Optimize kprobes after quiesence period */
> > > >    	do_optimize_kprobes();
> > 
> > ------------------------------------------------------------------------
> > 
> > commit bc31e6cb27a9334140ff2f0a209d59b08bc0bc8c
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Sat Jan 20 07:07:08 2024 -0800
> > 
> >      rcu-tasks: Eliminate deadlocks involving do_exit() and RCU tasks
> >      Holding a mutex across synchronize_rcu_tasks() and acquiring
> >      that same mutex in code called from do_exit() after its call to
> >      exit_tasks_rcu_start() but before its call to exit_tasks_rcu_stop()
> >      results in deadlock.  This is by design, because tasks that are far
> >      enough into do_exit() are no longer present on the tasks list, making
> >      it a bit difficult for RCU Tasks to find them, let alone wait on them
> >      to do a voluntary context switch.  However, such deadlocks are becoming
> >      more frequent.  In addition, lockdep currently does not detect such
> >      deadlocks and they can be difficult to reproduce.
> >      In addition, if a task voluntarily context switches during that time
> >      (for example, if it blocks acquiring a mutex), then this task is in an
> >      RCU Tasks quiescent state.  And with some adjustments, RCU Tasks could
> >      just as well take advantage of that fact.
> >      This commit therefore eliminates these deadlock by replacing the
> >      SRCU-based wait for do_exit() completion with per-CPU lists of tasks
> >      currently exiting.  A given task will be on one of these per-CPU lists for
> >      the same period of time that this task would previously have been in the
> >      previous SRCU read-side critical section.  These lists enable RCU Tasks
> >      to find the tasks that have already been removed from the tasks list,
> >      but that must nevertheless be waited upon.
> >      The RCU Tasks grace period gathers any of these do_exit() tasks that it
> >      must wait on, and adds them to the list of holdouts.  Per-CPU locking
> >      and get_task_struct() are used to synchronize addition to and removal
> >      from these lists.
> >      Link: https://lore.kernel.org/all/20240118021842.290665-1-chenzhongjin@huawei.com/
> >      Reported-by: Chen Zhongjin <chenzhongjin@huawei.com>
> >      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index cdb8ea53c365..4f0e9274da2d 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -858,6 +858,8 @@ struct task_struct {
> >   	u8				rcu_tasks_idx;
> >   	int				rcu_tasks_idle_cpu;
> >   	struct list_head		rcu_tasks_holdout_list;
> > +	int				rcu_tasks_exit_cpu;
> > +	struct list_head		rcu_tasks_exit_list;
> >   #endif /* #ifdef CONFIG_TASKS_RCU */
> >   #ifdef CONFIG_TASKS_TRACE_RCU
> > diff --git a/init/init_task.c b/init/init_task.c
> > index 7ecb458eb3da..4daee6d761c8 100644
> > --- a/init/init_task.c
> > +++ b/init/init_task.c
> > @@ -147,6 +147,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
> >   	.rcu_tasks_holdout = false,
> >   	.rcu_tasks_holdout_list = LIST_HEAD_INIT(init_task.rcu_tasks_holdout_list),
> >   	.rcu_tasks_idle_cpu = -1,
> > +	.rcu_tasks_exit_list = LIST_HEAD_INIT(init_task.rcu_tasks_exit_list),
> >   #endif
> >   #ifdef CONFIG_TASKS_TRACE_RCU
> >   	.trc_reader_nesting = 0,
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 47ff3b35352e..3eb86f30e664 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -1975,6 +1975,7 @@ static inline void rcu_copy_process(struct task_struct *p)
> >   	p->rcu_tasks_holdout = false;
> >   	INIT_LIST_HEAD(&p->rcu_tasks_holdout_list);
> >   	p->rcu_tasks_idle_cpu = -1;
> > +	INIT_LIST_HEAD(&p->rcu_tasks_exit_list);
> >   #endif /* #ifdef CONFIG_TASKS_RCU */
> >   #ifdef CONFIG_TASKS_TRACE_RCU
> >   	p->trc_reader_nesting = 0;
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index 732ad5b39946..bd4a51fd5b1f 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -32,6 +32,7 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
> >    * @rtp_irq_work: IRQ work queue for deferred wakeups.
> >    * @barrier_q_head: RCU callback for barrier operation.
> >    * @rtp_blkd_tasks: List of tasks blocked as readers.
> > + * @rtp_exit_list: List of tasks in the latter portion of do_exit().
> >    * @cpu: CPU number corresponding to this entry.
> >    * @rtpp: Pointer to the rcu_tasks structure.
> >    */
> > @@ -46,6 +47,7 @@ struct rcu_tasks_percpu {
> >   	struct irq_work rtp_irq_work;
> >   	struct rcu_head barrier_q_head;
> >   	struct list_head rtp_blkd_tasks;
> > +	struct list_head rtp_exit_list;
> >   	int cpu;
> >   	struct rcu_tasks *rtpp;
> >   };
> > @@ -144,8 +146,6 @@ static struct rcu_tasks rt_name =							\
> >   }
> >   #ifdef CONFIG_TASKS_RCU
> > -/* Track exiting tasks in order to allow them to be waited for. */
> > -DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
> >   /* Report delay in synchronize_srcu() completion in rcu_tasks_postscan(). */
> >   static void tasks_rcu_exit_srcu_stall(struct timer_list *unused);
> > @@ -275,6 +275,8 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
> >   		rtpcp->rtpp = rtp;
> >   		if (!rtpcp->rtp_blkd_tasks.next)
> >   			INIT_LIST_HEAD(&rtpcp->rtp_blkd_tasks);
> > +		if (!rtpcp->rtp_exit_list.next)
> > +			INIT_LIST_HEAD(&rtpcp->rtp_exit_list);
> >   	}
> >   	pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=%d.\n", rtp->name,
> > @@ -851,10 +853,12 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
> >   //	number of voluntary context switches, and add that task to the
> >   //	holdout list.
> >   // rcu_tasks_postscan():
> > -//	Invoke synchronize_srcu() to ensure that all tasks that were
> > -//	in the process of exiting (and which thus might not know to
> > -//	synchronize with this RCU Tasks grace period) have completed
> > -//	exiting.
> > +//	Gather per-CPU lists of tasks in do_exit() to ensure that all
> > +//	tasks that were in the process of exiting (and which thus might
> > +//	not know to synchronize with this RCU Tasks grace period) have
> > +//	completed exiting.  The synchronize_rcu() in rcu_tasks_postgp()
> > +//	will take care of any tasks stuck in the non-preemptible region
> > +//	of do_exit() following its call to exit_tasks_rcu_stop().
> >   // check_all_holdout_tasks(), repeatedly until holdout list is empty:
> >   //	Scans the holdout list, attempting to identify a quiescent state
> >   //	for each task on the list.  If there is a quiescent state, the
> > @@ -867,8 +871,10 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
> >   //	with interrupts disabled.
> >   //
> >   // For each exiting task, the exit_tasks_rcu_start() and
> > -// exit_tasks_rcu_finish() functions begin and end, respectively, the SRCU
> > -// read-side critical sections waited for by rcu_tasks_postscan().
> > +// exit_tasks_rcu_finish() functions add and remove, respectively, the
> > +// current task to a per-CPU list of tasks that rcu_tasks_postscan() must
> > +// wait on.  This is necessary because rcu_tasks_postscan() must wait on
> > +// tasks that have already been removed from the global list of tasks.
> >   //
> >   // Pre-grace-period update-side code is ordered before the grace
> >   // via the raw_spin_lock.*rcu_node().  Pre-grace-period read-side code
> > @@ -932,9 +938,13 @@ static void rcu_tasks_pertask(struct task_struct *t, struct list_head *hop)
> >   	}
> >   }
> > +void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func);
> > +DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks, "RCU Tasks");
> > +
> >   /* Processing between scanning taskslist and draining the holdout list. */
> >   static void rcu_tasks_postscan(struct list_head *hop)
> >   {
> > +	int cpu;
> >   	int rtsi = READ_ONCE(rcu_task_stall_info);
> >   	if (!IS_ENABLED(CONFIG_TINY_RCU)) {
> > @@ -948,9 +958,9 @@ static void rcu_tasks_postscan(struct list_head *hop)
> >   	 * this, divide the fragile exit path part in two intersecting
> >   	 * read side critical sections:
> >   	 *
> > -	 * 1) An _SRCU_ read side starting before calling exit_notify(),
> > -	 *    which may remove the task from the tasklist, and ending after
> > -	 *    the final preempt_disable() call in do_exit().
> > +	 * 1) A task_struct list addition before calling exit_notify(),
> > +	 *    which may remove the task from the tasklist, with the
> > +	 *    removal after the final preempt_disable() call in do_exit().
> >   	 *
> >   	 * 2) An _RCU_ read side starting with the final preempt_disable()
> >   	 *    call in do_exit() and ending with the final call to schedule()
> > @@ -959,7 +969,18 @@ static void rcu_tasks_postscan(struct list_head *hop)
> >   	 * This handles the part 1). And postgp will handle part 2) with a
> >   	 * call to synchronize_rcu().
> >   	 */
> > -	synchronize_srcu(&tasks_rcu_exit_srcu);
> > +
> > +	for_each_possible_cpu(cpu) {
> > +		unsigned long flags;
> > +		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, cpu);
> > +		struct task_struct *t;
> > +
> > +		raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
> > +		list_for_each_entry(t, &rtpcp->rtp_exit_list, rcu_tasks_exit_list)
> > +			if (list_empty(&t->rcu_tasks_holdout_list))
> > +				rcu_tasks_pertask(t, hop);
> > +		raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
> > +	}
> >   	if (!IS_ENABLED(CONFIG_TINY_RCU))
> >   		del_timer_sync(&tasks_rcu_exit_srcu_stall_timer);
> > @@ -1027,7 +1048,6 @@ static void rcu_tasks_postgp(struct rcu_tasks *rtp)
> >   	 *
> >   	 * In addition, this synchronize_rcu() waits for exiting tasks
> >   	 * to complete their final preempt_disable() region of execution,
> > -	 * cleaning up after synchronize_srcu(&tasks_rcu_exit_srcu),
> >   	 * enforcing the whole region before tasklist removal until
> >   	 * the final schedule() with TASK_DEAD state to be an RCU TASKS
> >   	 * read side critical section.
> > @@ -1035,9 +1055,6 @@ static void rcu_tasks_postgp(struct rcu_tasks *rtp)
> >   	synchronize_rcu();
> >   }
> > -void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func);
> > -DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks, "RCU Tasks");
> > -
> >   static void tasks_rcu_exit_srcu_stall(struct timer_list *unused)
> >   {
> >   #ifndef CONFIG_TINY_RCU
> > @@ -1147,25 +1164,45 @@ struct task_struct *get_rcu_tasks_gp_kthread(void)
> >   EXPORT_SYMBOL_GPL(get_rcu_tasks_gp_kthread);
> >   /*
> > - * Contribute to protect against tasklist scan blind spot while the
> > - * task is exiting and may be removed from the tasklist. See
> > - * corresponding synchronize_srcu() for further details.
> > + * Protect against tasklist scan blind spot while the task is exiting and
> > + * may be removed from the tasklist.  Do this by adding the task to yet
> > + * another list.
> >    */
> > -void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
> > +void exit_tasks_rcu_start(void)
> >   {
> > -	current->rcu_tasks_idx = __srcu_read_lock(&tasks_rcu_exit_srcu);
> > +	unsigned long flags;
> > +	struct rcu_tasks_percpu *rtpcp;
> > +	struct task_struct *t = current;
> > +
> > +	WARN_ON_ONCE(!list_empty(&t->rcu_tasks_exit_list));
> > +	get_task_struct(t);
> > +	preempt_disable();
> > +	rtpcp = this_cpu_ptr(rcu_tasks.rtpcpu);
> > +	t->rcu_tasks_exit_cpu = smp_processor_id();
> > +	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
> > +	if (!rtpcp->rtp_exit_list.next)
> > +		INIT_LIST_HEAD(&rtpcp->rtp_exit_list);
> > +	list_add(&t->rcu_tasks_exit_list, &rtpcp->rtp_exit_list);
> > +	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
> > +	preempt_enable();
> >   }
> >   /*
> > - * Contribute to protect against tasklist scan blind spot while the
> > - * task is exiting and may be removed from the tasklist. See
> > - * corresponding synchronize_srcu() for further details.
> > + * Remove the task from the "yet another list" because do_exit() is now
> > + * non-preemptible, allowing synchronize_rcu() to wait beyond this point.
> >    */
> > -void exit_tasks_rcu_stop(void) __releases(&tasks_rcu_exit_srcu)
> > +void exit_tasks_rcu_stop(void)
> >   {
> > +	unsigned long flags;
> > +	struct rcu_tasks_percpu *rtpcp;
> >   	struct task_struct *t = current;
> > -	__srcu_read_unlock(&tasks_rcu_exit_srcu, t->rcu_tasks_idx);
> > +	WARN_ON_ONCE(list_empty(&t->rcu_tasks_exit_list));
> > +	rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, t->rcu_tasks_exit_cpu);
> > +	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
> > +	list_del_init(&t->rcu_tasks_exit_list);
> > +	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
> > +	put_task_struct(t);
> >   }
> >   /*
> > 
> Tested-by: Yang Jihong <yangjihong1@huawei.com>
> 
> Thanks,
> Yang

