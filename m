Return-Path: <linux-kernel+bounces-77330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 999578603C8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 124D81F234E8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11427173E;
	Thu, 22 Feb 2024 20:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miTeHAYS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A693F405D8;
	Thu, 22 Feb 2024 20:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708634516; cv=none; b=lcDnCyqZns+Gz5jFEu3Zf0zMQ9qatbHKcBMEYiIw53I4DbCmfOCitKhMe6l3bBqXBp0RamS5cjBgBfIAKF/Egy5r61K7id3h65uwySEodLLz2WpxuPXvWL/nxfk7cAU3/v1/cdS+6L6tuabjPDAwZmLW08UOX9MXHevbmnSOlOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708634516; c=relaxed/simple;
	bh=hdo47RSbsSpo5khNHCty4bp18NrksUGXifAW+WSacSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoX/xtI/gkWEoPGPj2LebtIZ7vyHSxJnXmtznhZ7cTO9y+UxSugT7YPn4LiF758LoNqCqiTDMLADmBLrO5Bf/H1u0PPjBC5O69l5wdc0e6/I7P79y8aerxR+FhwraU8wIkUWKCWbSD9In3WQfy0AQDN2QpBuV3cvpCaYuZcYvI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miTeHAYS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323EDC433F1;
	Thu, 22 Feb 2024 20:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708634516;
	bh=hdo47RSbsSpo5khNHCty4bp18NrksUGXifAW+WSacSQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=miTeHAYSIVh+DDeBOK4gv2faZNiwGq6n7elFSYrV2eBsr40x3fwv51pSf1G+MslTE
	 HfkaGCFQqlUqLH0x9qe7bPphC/34vkmGi7b1vUTMNt23PnKX7ej214lZCw4z21uPs1
	 NMqArwAguNTj8Y+k8EDjMz7ysxBTf9+IPfublHuU/t2yt711iUQuVN9/mYNBo5vs+Y
	 LTHYyvc/wXcf0J+9dvfgjLdPpZtvlwex7TGPTxS2USQJbaI92znctzKzBYXZOk17db
	 hav9frtysUi4Bb9StSfYk34OWf0mjyyJlXCuPNUsLQI7L7FSgxkEXrbdO6X1lu5h9F
	 gQGDlOG9u20ww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BD55FCE0738; Thu, 22 Feb 2024 12:41:55 -0800 (PST)
Date: Thu, 22 Feb 2024 12:41:55 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Chen Zhongjin <chenzhongjin@huawei.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Oleg Nesterov <oleg@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Peng Zhang <zhangpeng.00@bytedance.com>
Subject: Re: [PATCH v2 3/6] rcu-tasks: Initialize data to eliminate
 RCU-tasks/do_exit() deadlocks
Message-ID: <1e265c80-2008-4419-8a21-d05c39e1e53e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240217012745.3446231-1-boqun.feng@gmail.com>
 <20240217012745.3446231-4-boqun.feng@gmail.com>
 <Zdd0b3HI4uNAoc2P@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zdd0b3HI4uNAoc2P@localhost.localdomain>

On Thu, Feb 22, 2024 at 05:21:03PM +0100, Frederic Weisbecker wrote:
> Le Fri, Feb 16, 2024 at 05:27:38PM -0800, Boqun Feng a écrit :
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > Holding a mutex across synchronize_rcu_tasks() and acquiring
> > that same mutex in code called from do_exit() after its call to
> > exit_tasks_rcu_start() but before its call to exit_tasks_rcu_stop()
> > results in deadlock.  This is by design, because tasks that are far
> > enough into do_exit() are no longer present on the tasks list, making
> > it a bit difficult for RCU Tasks to find them, let alone wait on them
> > to do a voluntary context switch.  However, such deadlocks are becoming
> > more frequent.  In addition, lockdep currently does not detect such
> > deadlocks and they can be difficult to reproduce.
> > 
> > In addition, if a task voluntarily context switches during that time
> > (for example, if it blocks acquiring a mutex), then this task is in an
> > RCU Tasks quiescent state.  And with some adjustments, RCU Tasks could
> > just as well take advantage of that fact.
> > 
> > This commit therefore initializes the data structures that will be needed
> > to rely on these quiescent states and to eliminate these deadlocks.
> > 
> > Link: https://lore.kernel.org/all/20240118021842.290665-1-chenzhongjin@huawei.com/
> > 
> > Reported-by: Chen Zhongjin <chenzhongjin@huawei.com>
> > Reported-by: Yang Jihong <yangjihong1@huawei.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Tested-by: Yang Jihong <yangjihong1@huawei.com>
> > Tested-by: Chen Zhongjin <chenzhongjin@huawei.com>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  init/init_task.c   | 1 +
> >  kernel/fork.c      | 1 +
> >  kernel/rcu/tasks.h | 2 ++
> >  3 files changed, 4 insertions(+)
> > 
> > diff --git a/init/init_task.c b/init/init_task.c
> > index 7ecb458eb3da..4daee6d761c8 100644
> > --- a/init/init_task.c
> > +++ b/init/init_task.c
> > @@ -147,6 +147,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
> >  	.rcu_tasks_holdout = false,
> >  	.rcu_tasks_holdout_list = LIST_HEAD_INIT(init_task.rcu_tasks_holdout_list),
> >  	.rcu_tasks_idle_cpu = -1,
> > +	.rcu_tasks_exit_list = LIST_HEAD_INIT(init_task.rcu_tasks_exit_list),
> >  #endif
> >  #ifdef CONFIG_TASKS_TRACE_RCU
> >  	.trc_reader_nesting = 0,
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 0d944e92a43f..af7203be1d2d 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -1976,6 +1976,7 @@ static inline void rcu_copy_process(struct task_struct *p)
> >  	p->rcu_tasks_holdout = false;
> >  	INIT_LIST_HEAD(&p->rcu_tasks_holdout_list);
> >  	p->rcu_tasks_idle_cpu = -1;
> > +	INIT_LIST_HEAD(&p->rcu_tasks_exit_list);
> >  #endif /* #ifdef CONFIG_TASKS_RCU */
> >  #ifdef CONFIG_TASKS_TRACE_RCU
> >  	p->trc_reader_nesting = 0;
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index b7d5f2757053..4a5d562e3189 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -277,6 +277,8 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
> >  		rtpcp->rtpp = rtp;
> >  		if (!rtpcp->rtp_blkd_tasks.next)
> >  			INIT_LIST_HEAD(&rtpcp->rtp_blkd_tasks);
> > +		if (!rtpcp->rtp_exit_list.next)
> 
> I assume there can't be an exiting task concurrently at this point on
> boot. Because kthreadd just got created and workqueues as well but that's it,
> right? Or workqueues can die that early? Probably not.
> 
> > +			INIT_LIST_HEAD(&rtpcp->rtp_exit_list);
> 
> Because if tasks can exit concurrently, then we are in trouble :-)

Tasks exiting at that point might be unconventional, but I don't see
anything that prevents them from doing so.

So excellent catch, and thank you very much!!!

My thought is to add the following patch to precede this one, which
initializes those lists at rcu_init() time.  Would that work?

						Thanx, Paul

------------------------------------------------------------------------

commit 9a876aac8064dfd46c840e4bb6177e65f7964bb4
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Feb 22 12:29:54 2024 -0800

    rcu-tasks: Initialize callback lists at rcu_init() time
    
    In order for RCU Tasks to reliably maintain per-CPU lists of exiting
    tasks, those lists must be initialized before it is possible for tasks
    to exit, especially given that the boot CPU is not necessarily CPU 0
    (an example being, powerpc kexec() kernels).  And at the time that
    rcu_init_tasks_generic() is called, a task could potentially exit,
    unconventional though that sort of thing might be.
    
    This commit therefore moves the calls to cblist_init_generic() from
    functions called from rcu_init_tasks_generic() to a new function named
    tasks_cblist_init_generic() that is invoked from rcu_init().
    
    This constituted a bug in a commit that never went to mainline, so
    there is no need for any backporting to -stable.
    
    Reported-by: Frederic Weisbecker <frederic@kernel.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 4e65a92e528e5..86fce206560e8 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -528,6 +528,12 @@ struct task_struct *get_rcu_tasks_gp_kthread(void);
 struct task_struct *get_rcu_tasks_rude_gp_kthread(void);
 #endif // # ifdef CONFIG_TASKS_RUDE_RCU
 
+#ifdef CONFIG_TASKS_RCU_GENERIC
+void tasks_cblist_init_generic(void);
+#else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
+static inline void tasks_cblist_init_generic(void) { }
+#endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
+
 #define RCU_SCHEDULER_INACTIVE	0
 #define RCU_SCHEDULER_INIT	1
 #define RCU_SCHEDULER_RUNNING	2
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 866743e0796f4..e06e388e7c7e6 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -240,7 +240,6 @@ static const char *tasks_gp_state_getname(struct rcu_tasks *rtp)
 static void cblist_init_generic(struct rcu_tasks *rtp)
 {
 	int cpu;
-	unsigned long flags;
 	int lim;
 	int shift;
 
@@ -266,10 +265,8 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 		WARN_ON_ONCE(!rtpcp);
 		if (cpu)
 			raw_spin_lock_init(&ACCESS_PRIVATE(rtpcp, lock));
-		local_irq_save(flags);  // serialize initialization
 		if (rcu_segcblist_empty(&rtpcp->cblist))
 			rcu_segcblist_init(&rtpcp->cblist);
-		local_irq_restore(flags);
 		INIT_WORK(&rtpcp->rtp_work, rcu_tasks_invoke_cbs_wq);
 		rtpcp->cpu = cpu;
 		rtpcp->rtpp = rtp;
@@ -1153,7 +1150,6 @@ module_param(rcu_tasks_lazy_ms, int, 0444);
 
 static int __init rcu_spawn_tasks_kthread(void)
 {
-	cblist_init_generic(&rcu_tasks);
 	rcu_tasks.gp_sleep = HZ / 10;
 	rcu_tasks.init_fract = HZ / 10;
 	if (rcu_tasks_lazy_ms >= 0)
@@ -1340,7 +1336,6 @@ module_param(rcu_tasks_rude_lazy_ms, int, 0444);
 
 static int __init rcu_spawn_tasks_rude_kthread(void)
 {
-	cblist_init_generic(&rcu_tasks_rude);
 	rcu_tasks_rude.gp_sleep = HZ / 10;
 	if (rcu_tasks_rude_lazy_ms >= 0)
 		rcu_tasks_rude.lazy_jiffies = msecs_to_jiffies(rcu_tasks_rude_lazy_ms);
@@ -1972,7 +1967,6 @@ module_param(rcu_tasks_trace_lazy_ms, int, 0444);
 
 static int __init rcu_spawn_tasks_trace_kthread(void)
 {
-	cblist_init_generic(&rcu_tasks_trace);
 	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB)) {
 		rcu_tasks_trace.gp_sleep = HZ / 10;
 		rcu_tasks_trace.init_fract = HZ / 10;
@@ -2144,6 +2138,24 @@ late_initcall(rcu_tasks_verify_schedule_work);
 static void rcu_tasks_initiate_self_tests(void) { }
 #endif /* #else #ifdef CONFIG_PROVE_RCU */
 
+void __init tasks_cblist_init_generic(void)
+{
+	lockdep_assert_irqs_disabled();
+	WARN_ON(num_online_cpus() > 1);
+
+#ifdef CONFIG_TASKS_RCU
+	cblist_init_generic(&rcu_tasks);
+#endif
+
+#ifdef CONFIG_TASKS_RUDE_RCU
+	cblist_init_generic(&rcu_tasks_rude);
+#endif
+
+#ifdef CONFIG_TASKS_TRACE_RCU
+	cblist_init_generic(&rcu_tasks_trace);
+#endif
+}
+
 void __init rcu_init_tasks_generic(void)
 {
 #ifdef CONFIG_TASKS_RCU
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index fec804b790803..705c0d16850aa 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -261,4 +261,5 @@ void __init rcu_init(void)
 {
 	open_softirq(RCU_SOFTIRQ, rcu_process_callbacks);
 	rcu_early_boot_tests();
+	tasks_cblist_init_generic();
 }
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 31f3a61f9c384..4f4aec64039f0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -5601,6 +5601,8 @@ void __init rcu_init(void)
 	(void)start_poll_synchronize_rcu_expedited();
 
 	rcu_test_sync_prims();
+
+	tasks_cblist_init_generic();
 }
 
 #include "tree_stall.h"

