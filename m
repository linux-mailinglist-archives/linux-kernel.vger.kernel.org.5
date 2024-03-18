Return-Path: <linux-kernel+bounces-105667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D67587E255
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 03:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4EB01F2323C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EEC1DFF4;
	Mon, 18 Mar 2024 02:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgrmBA8X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9D9F4FB;
	Mon, 18 Mar 2024 02:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710730264; cv=none; b=QYxsuhl8Ti6I7oUHGqniMdPqTL8i9ncsPBMs5bMCovBI+uBybbUx0COgKT7sKir25UZxcCKruHBb3huz5Cp4PY9AJJhXfJ8OZahAdyZZvO8t3I/vEhx4JH6GIzJ0bzIlUaQZq7DJy0zy7dtv1VjUAiiDfo02SDxxaWXE13SAz1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710730264; c=relaxed/simple;
	bh=D3hrwaKVct3qy/dDUOUo0P2ML4zfqAVSmhJl31m7AB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRe8gjiHjmM1bsJjcYQWciqiivSJE1wdo3GxpR/JO3vLvm0JvDXHfYmViZavo5orpjoMcgXI5SBfdiv1O+tqz2bQ0cjS6a+2Q0C3nGKTdpLP8CtejcDgsMQgGkRLTLIRTPVwt9xL1RcV2pHBDUSw6Hlqxxne8gQTmxDi3f2iIao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgrmBA8X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E194C433C7;
	Mon, 18 Mar 2024 02:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710730263;
	bh=D3hrwaKVct3qy/dDUOUo0P2ML4zfqAVSmhJl31m7AB4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=EgrmBA8XUh3tNKYO/rCmT3qB8CT80ti885/7KJdASY7SWB253B52PnlR1ak3wyLoB
	 JuQcx0hPj9Gs2pV6UtPQDAy5b3iMddYowt3rmJBsunJCSmQVKLwHJD4HK+rxzJo5Rh
	 H7OUWO5XJtnAkbnQQ4eOEcpIEE4P/LwyKQj98tqisNMUsHVo0TKTADcSyuh/2X1THs
	 fo/6EhNF0wKQ9IFoKn/SebpsI6pyilgKhJyWnygH3+1ADytyRsfvBfOH2QBSZTGHbL
	 +I2WhjVrYU7SqjmX6aVX3iqJVA5W2KsyOrN0QWfwXOAYRprWkZ8h+0TwcQhFkCX7oj
	 qFuz/p55/MZEA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EAC4ACE0D83; Sun, 17 Mar 2024 19:51:01 -0700 (PDT)
Date: Sun, 17 Mar 2024 19:51:01 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Z qiang <qiang.zhang1211@gmail.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcutorture: Make rcutorture support print rcu-tasks
 gp state
Message-ID: <0222fee6-9b4c-4556-b30e-13526a393224@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240317113811.8085-1-qiang.zhang1211@gmail.com>
 <4ffbaa69-0d36-4a16-abc5-8aa4b37e68b8@paulmck-laptop>
 <CALm+0cVA6Hb7MX1q-Xz9K1no2vJQ614qBtpqcuCink=AF_LAhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm+0cVA6Hb7MX1q-Xz9K1no2vJQ614qBtpqcuCink=AF_LAhA@mail.gmail.com>

On Mon, Mar 18, 2024 at 10:19:58AM +0800, Z qiang wrote:
> >
> > On Sun, Mar 17, 2024 at 07:38:11PM +0800, Zqiang wrote:
> > > This commit make rcu-tasks related rcutorture test support rcu-tasks
> > > gp state printing when the writer stall occurs or the at the end of
> > > rcutorture test, and generate rcu_ops->get_gp_data() operation to
> > > simplify the acquisition of gp state for different types of rcutorture
> > > tests.
> > >
> > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> >
> > Much better!!!
> >
> > A few questions below.  One small change left, a question on testing,
> > and the possibility of a few cleanup patches if you are interested.
> >
> >                                                         Thanx, Paul
> >
> > > ---
> > >
> > > [   47.582683] rcu:  Start-test grace-period state: g4313 f0x0
> > > [   73.780444] rcu:  End-test grace-period state: g15728 f0x0 total-gps=2854
> > >
> > > [   99.013921] srcu:  Start-test grace-period state: g0 f0x0
> > > [  126.596727] srcu:  End-test grace-period state: g10292 f0x0 total-gps=10292
> > >
> > > [  175.664991] srcud:  Start-test grace-period state: g0 f0x0
> > > [  195.012774] srcud:  End-test grace-period state: g7628 f0x0 total-gps=7628
> > >
> > > [  216.943521] tasks:  Start-test grace-period state: g8 f0x0
> > > [  234.245093] tasks:  End-test grace-period state: g300 f0x0 total-gps=292
> > >
> > > [  267.139368] tasks-rude:  Start-test grace-period state: g8 f0x0
> > > [  296.132748] tasks-rude:  End-test grace-period state: g684 f0x0 total-gps=676
> > >
> > > [  316.044241] tasks-tracing:  Start-test grace-period state: g8 f0x0
> > > [  342.020447] tasks-tracing:  End-test grace-period state: g348 f0x0 total-gps=340
> > >
> > >  kernel/rcu/rcu.h        | 20 ++++++++++----------
> > >  kernel/rcu/rcutorture.c | 29 +++++++++++++++++++++--------
> > >  kernel/rcu/srcutree.c   |  5 +----
> > >  kernel/rcu/tasks.h      | 21 +++++++++++++++++++++
> > >  kernel/rcu/tree.c       | 13 +++----------
> > >  5 files changed, 56 insertions(+), 32 deletions(-)
> > >
> > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > > index 86fce206560e..38238e595a61 100644
> > > --- a/kernel/rcu/rcu.h
> > > +++ b/kernel/rcu/rcu.h
> > > @@ -522,12 +522,18 @@ static inline void show_rcu_tasks_gp_kthreads(void) {}
> > >
> > >  #ifdef CONFIG_TASKS_RCU
> > >  struct task_struct *get_rcu_tasks_gp_kthread(void);
> > > +void rcu_tasks_get_gp_data(int *flags, unsigned long *gp_seq);
> > >  #endif // # ifdef CONFIG_TASKS_RCU
> > >
> > >  #ifdef CONFIG_TASKS_RUDE_RCU
> > >  struct task_struct *get_rcu_tasks_rude_gp_kthread(void);
> > > +void rcu_tasks_rude_get_gp_data(int *flags, unsigned long *gp_seq);
> > >  #endif // # ifdef CONFIG_TASKS_RUDE_RCU
> > >
> > > +#ifdef CONFIG_TASKS_TRACE_RCU
> > > +void rcu_tasks_trace_get_gp_data(int *flags, unsigned long *gp_seq);
> > > +#endif
> > > +
> >
> > If you have not already done so, could you please test with the rcutorture
> > scenarios, while artificially forcing that warning to trigger?
> 
> I used the following command to force writer stall:
> 
> insmod rcutorture.ko torture_type=rcu* fwd_progress=0 stat_interval=4
> stall_cpu_block=1 stall_cpu=40 stall_cpu_holdoff=10
> 
> tasks_trace:
> [52392.689229] ??? Writer stall state RTWS_SYNC(21) g447101 f0x0
> ->state 0x2 cpu 2
> [52392.689235] rcu_tasks_trace: RTGS_WAIT_SCAN_HOLDOUTS(6) since 8
> g:447101 i:0/26562 kCuU l:1 N1 h:44/225560/436368
> 
> tasks_rude:
> [52614.705062] ??? Writer stall state RTWS_SYNC(21) g261 f0x0 ->state 0x2 cpu 2
> [52614.705067] rcu_tasks_rude: RTGS_WAIT_GP(2) since 13807 g:261
> i:0/261 kCuU l:250
> 
> tasks:
> [52751.857305] ??? Writer stall state RTWS_EXP_SYNC(4) g149 f0x0
> ->state 0x2 cpu 2
> [52751.858163] rcu_tasks: RTGS_WAIT_SCAN_HOLDOUTS(6) since 57 g:149
> i:0/0 kCuU l:250
> 
> rcu:
> ??? Writer stall state RTWS_POLL_WAIT_EXP_FULL(20) g952633 f0x0
> ->state 0x402 cpu 2
> [52826.481118] task:rcu_torture_wri state:I stack:0 pid:8655 tgid:8655
> ppid:2 flags:0x00004000
> rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: 0x402
> ->rt_priority 1 delta ->gp_start 6093 ->gp_activity 0
> ->gp_req_activity 6093 ->gp_wake_time 6093 ->gp_wake_seq 952629
> ->gp_s0
> [52826.481462] rcu: rcu_node 0:3 ->gp_seq 952633 ->gp_seq_needed
> 952640 ->qsmask 0x0 b.EG ->n_boosts 2328
> [52826.481466] rcu: cpu 0 ->gp_seq_needed 952640
> [52826.481469] rcu: cpu 1 ->gp_seq_needed 952640
> [52826.481472] rcu: cpu 2 ->gp_seq_needed 952636
> [52826.481474] rcu: cpu 3 ->gp_seq_needed 952640
> [52826.481477] rcu: RCU callbacks invoked since boot: 127957840
> [52826.481481] rcu_tasks: RTGS_WAIT_CBS(11) since 30792 g:268 i:0/0 k.u. l:250
> [52826.481486] rcu_tasks_rude: RTGS_WAIT_CBS(11) since 164976 g:680
> i:0/677 k.u. l:250
> [52826.481492] rcu_tasks_trace: RTGS_WAIT_CBS(11) since 395536
> g:447148 i:0/26567 k.u. l:1 N0 h:44/225572/436420
> 
> srcu:
> rcu: srcu-torture: Tree SRCU g3586 state 0 (SRCU_SIZE_SMALL)
> per-CPU(idx=1): 0(16,6 C) 1(2,-12 .) 2(-11,7 .) 3(-6,-1 .) T(1,0)
> [52940.785131] ??? Writer stall state RTWS_EXP_SYNC(4) g3586 f0x0
> ->state 0x2 cpu 0
> [52940.785136] task:rcu_torture_wri state:D stack:0 pid:8748 tgid:8748
> ppid:2 flags:0x00004000

Very good, looking forward to the version that avoids creating the
redundant NULL initializations.

							Thanx, Paul

> > For example, CONFIG_TASKS_TRACE_RCU can be tested using this command
> > line:
> >
> > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 5m --configs "TRACE01 TRACE02" --trust-make
> >
> > You can add more scenarios to the --configs argument, and the rest of
> > them can be found in tools/testing/selftests/rcutorture/configs/rcu.
> >
> > >  #ifdef CONFIG_TASKS_RCU_GENERIC
> > >  void tasks_cblist_init_generic(void);
> > >  #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
> > > @@ -557,8 +563,7 @@ static inline void rcu_set_jiffies_lazy_flush(unsigned long j) { }
> > >  #endif
> > >
> > >  #if defined(CONFIG_TREE_RCU)
> > > -void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
> > > -                         unsigned long *gp_seq);
> > > +void rcutorture_get_gp_data(int *flags, unsigned long *gp_seq);
> > >  void do_trace_rcu_torture_read(const char *rcutorturename,
> > >                              struct rcu_head *rhp,
> > >                              unsigned long secs,
> > > @@ -566,8 +571,7 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
> > >                              unsigned long c);
> > >  void rcu_gp_set_torture_wait(int duration);
> > >  #else
> > > -static inline void rcutorture_get_gp_data(enum rcutorture_type test_type,
> > > -                                       int *flags, unsigned long *gp_seq)
> > > +static inline void rcutorture_get_gp_data(int *flags, unsigned long *gp_seq)
> > >  {
> > >       *flags = 0;
> > >       *gp_seq = 0;
> > > @@ -587,20 +591,16 @@ static inline void rcu_gp_set_torture_wait(int duration) { }
> > >
> > >  #ifdef CONFIG_TINY_SRCU
> > >
> > > -static inline void srcutorture_get_gp_data(enum rcutorture_type test_type,
> > > -                                        struct srcu_struct *sp, int *flags,
> > > +static inline void srcutorture_get_gp_data(struct srcu_struct *sp, int *flags,
> > >                                          unsigned long *gp_seq)
> > >  {
> > > -     if (test_type != SRCU_FLAVOR)
> > > -             return;
> > >       *flags = 0;
> > >       *gp_seq = sp->srcu_idx;
> > >  }
> > >
> > >  #elif defined(CONFIG_TREE_SRCU)
> > >
> > > -void srcutorture_get_gp_data(enum rcutorture_type test_type,
> > > -                          struct srcu_struct *sp, int *flags,
> > > +void srcutorture_get_gp_data(struct srcu_struct *sp, int *flags,
> > >                            unsigned long *gp_seq);
> > >
> > >  #endif
> > > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > > index 2f43d31fb7a5..2e8a037072eb 100644
> > > --- a/kernel/rcu/rcutorture.c
> > > +++ b/kernel/rcu/rcutorture.c
> > > @@ -381,6 +381,7 @@ struct rcu_torture_ops {
> > >       void (*gp_kthread_dbg)(void);
> > >       bool (*check_boost_failed)(unsigned long gp_state, int *cpup);
> > >       int (*stall_dur)(void);
> > > +     void (*get_gp_data)(int *flags, unsigned long *gp_seq);
> > >       long cbflood_max;
> > >       int irq_capable;
> > >       int can_boost;
> > > @@ -569,6 +570,7 @@ static struct rcu_torture_ops rcu_ops = {
> > >       .gp_kthread_dbg         = show_rcu_gp_kthreads,
> > >       .check_boost_failed     = rcu_check_boost_fail,
> > >       .stall_dur              = rcu_jiffies_till_stall_check,
> > > +     .get_gp_data            = rcutorture_get_gp_data,
> > >       .irq_capable            = 1,
> > >       .can_boost              = IS_ENABLED(CONFIG_RCU_BOOST),
> > >       .extendables            = RCUTORTURE_MAX_EXTEND,
> > > @@ -612,6 +614,7 @@ static struct rcu_torture_ops rcu_busted_ops = {
> > >       .sync           = synchronize_rcu_busted,
> > >       .exp_sync       = synchronize_rcu_busted,
> > >       .call           = call_rcu_busted,
> > > +     .get_gp_data    = NULL,
> >
> > When this is NULL, please just leave it out.
> >
> > If you wish, you can also send separate patches removing the pre-existing
> > initialization of function pointers to NULL, one per function pointer.
> 
> I will record it in my todo document.
> 
> Thanks
> 
> 
> >
> > >       .cb_barrier     = NULL,
> > >       .fqs            = NULL,
> > >       .stats          = NULL,
> > > @@ -628,6 +631,11 @@ static struct srcu_struct srcu_ctld;
> > >  static struct srcu_struct *srcu_ctlp = &srcu_ctl;
> > >  static struct rcu_torture_ops srcud_ops;
> > >
> > > +static void srcu_get_gp_data(int *flags, unsigned long *gp_seq)
> > > +{
> > > +     srcutorture_get_gp_data(srcu_ctlp, flags, gp_seq);
> > > +}
> > > +
> > >  static int srcu_torture_read_lock(void)
> > >  {
> > >       if (cur_ops == &srcud_ops)
> > > @@ -736,6 +744,7 @@ static struct rcu_torture_ops srcu_ops = {
> > >       .call           = srcu_torture_call,
> > >       .cb_barrier     = srcu_torture_barrier,
> > >       .stats          = srcu_torture_stats,
> > > +     .get_gp_data    = srcu_get_gp_data,
> > >       .cbflood_max    = 50000,
> > >       .irq_capable    = 1,
> > >       .no_pi_lock     = IS_ENABLED(CONFIG_TINY_SRCU),
> > > @@ -774,6 +783,7 @@ static struct rcu_torture_ops srcud_ops = {
> > >       .call           = srcu_torture_call,
> > >       .cb_barrier     = srcu_torture_barrier,
> > >       .stats          = srcu_torture_stats,
> > > +     .get_gp_data    = srcu_get_gp_data,
> > >       .cbflood_max    = 50000,
> > >       .irq_capable    = 1,
> > >       .no_pi_lock     = IS_ENABLED(CONFIG_TINY_SRCU),
> > > @@ -796,6 +806,7 @@ static struct rcu_torture_ops busted_srcud_ops = {
> > >       .call           = srcu_torture_call,
> > >       .cb_barrier     = srcu_torture_barrier,
> > >       .stats          = srcu_torture_stats,
> > > +     .get_gp_data    = NULL,
> > >       .irq_capable    = 1,
> > >       .no_pi_lock     = IS_ENABLED(CONFIG_TINY_SRCU),
> > >       .extendables    = RCUTORTURE_MAX_EXTEND,
> > > @@ -838,6 +849,7 @@ static struct rcu_torture_ops trivial_ops = {
> > >       .get_gp_seq     = rcu_no_completed,
> > >       .sync           = synchronize_rcu_trivial,
> > >       .exp_sync       = synchronize_rcu_trivial,
> > > +     .get_gp_data    = NULL,
> > >       .fqs            = NULL,
> > >       .stats          = NULL,
> > >       .irq_capable    = 1,
> > > @@ -882,6 +894,7 @@ static struct rcu_torture_ops tasks_ops = {
> > >       .call           = call_rcu_tasks,
> > >       .cb_barrier     = rcu_barrier_tasks,
> > >       .gp_kthread_dbg = show_rcu_tasks_classic_gp_kthread,
> > > +     .get_gp_data    = rcu_tasks_get_gp_data,
> > >       .fqs            = NULL,
> > >       .stats          = NULL,
> > >       .irq_capable    = 1,
> > > @@ -922,6 +935,7 @@ static struct rcu_torture_ops tasks_rude_ops = {
> > >       .call           = call_rcu_tasks_rude,
> > >       .cb_barrier     = rcu_barrier_tasks_rude,
> > >       .gp_kthread_dbg = show_rcu_tasks_rude_gp_kthread,
> > > +     .get_gp_data    = rcu_tasks_rude_get_gp_data,
> > >       .cbflood_max    = 50000,
> > >       .fqs            = NULL,
> > >       .stats          = NULL,
> > > @@ -974,6 +988,7 @@ static struct rcu_torture_ops tasks_tracing_ops = {
> > >       .call           = call_rcu_tasks_trace,
> > >       .cb_barrier     = rcu_barrier_tasks_trace,
> > >       .gp_kthread_dbg = show_rcu_tasks_trace_gp_kthread,
> > > +     .get_gp_data    = rcu_tasks_trace_get_gp_data,
> > >       .cbflood_max    = 50000,
> > >       .fqs            = NULL,
> > >       .stats          = NULL,
> > > @@ -2264,10 +2279,8 @@ rcu_torture_stats_print(void)
> > >               int __maybe_unused flags = 0;
> > >               unsigned long __maybe_unused gp_seq = 0;
> > >
> > > -             rcutorture_get_gp_data(cur_ops->ttype,
> > > -                                    &flags, &gp_seq);
> > > -             srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp,
> > > -                                     &flags, &gp_seq);
> > > +             if (cur_ops->get_gp_data)
> > > +                     cur_ops->get_gp_data(&flags, &gp_seq);
> > >               wtp = READ_ONCE(writer_task);
> > >               pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %#x cpu %d\n",
> > >                        rcu_torture_writer_state_getname(),
> > > @@ -3390,8 +3403,8 @@ rcu_torture_cleanup(void)
> > >               fakewriter_tasks = NULL;
> > >       }
> > >
> > > -     rcutorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
> > > -     srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp, &flags, &gp_seq);
> > > +     if (cur_ops->get_gp_data)
> > > +             cur_ops->get_gp_data(&flags, &gp_seq);
> > >       pr_alert("%s:  End-test grace-period state: g%ld f%#x total-gps=%ld\n",
> > >                cur_ops->name, (long)gp_seq, flags,
> > >                rcutorture_seq_diff(gp_seq, start_gp_seq));
> > > @@ -3762,8 +3775,8 @@ rcu_torture_init(void)
> > >                       nrealreaders = 1;
> > >       }
> > >       rcu_torture_print_module_parms(cur_ops, "Start of test");
> > > -     rcutorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
> > > -     srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp, &flags, &gp_seq);
> > > +     if (cur_ops->get_gp_data)
> > > +             cur_ops->get_gp_data(&flags, &gp_seq);
> > >       start_gp_seq = gp_seq;
> > >       pr_alert("%s:  Start-test grace-period state: g%ld f%#x\n",
> > >                cur_ops->name, (long)gp_seq, flags);
> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > index d19326486edd..98f79ba01b0a 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -1828,12 +1828,9 @@ static void process_srcu(struct work_struct *work)
> > >       srcu_reschedule(ssp, curdelay);
> > >  }
> > >
> > > -void srcutorture_get_gp_data(enum rcutorture_type test_type,
> > > -                          struct srcu_struct *ssp, int *flags,
> > > +void srcutorture_get_gp_data(struct srcu_struct *ssp, int *flags,
> > >                            unsigned long *gp_seq)
> > >  {
> > > -     if (test_type != SRCU_FLAVOR)
> > > -             return;
> > >       *flags = 0;
> > >       *gp_seq = rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq);
> > >  }
> > > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > > index e83adcdb49b5..e7ac9138a4fd 100644
> > > --- a/kernel/rcu/tasks.h
> > > +++ b/kernel/rcu/tasks.h
> > > @@ -1182,6 +1182,13 @@ struct task_struct *get_rcu_tasks_gp_kthread(void)
> > >  }
> > >  EXPORT_SYMBOL_GPL(get_rcu_tasks_gp_kthread);
> > >
> > > +void rcu_tasks_get_gp_data(int *flags, unsigned long *gp_seq)
> > > +{
> > > +     *flags = 0;
> > > +     *gp_seq = rcu_seq_current(&rcu_tasks.tasks_gp_seq);
> > > +}
> > > +EXPORT_SYMBOL_GPL(rcu_tasks_get_gp_data);
> > > +
> > >  /*
> > >   * Protect against tasklist scan blind spot while the task is exiting and
> > >   * may be removed from the tasklist.  Do this by adding the task to yet
> > > @@ -1361,6 +1368,13 @@ struct task_struct *get_rcu_tasks_rude_gp_kthread(void)
> > >  }
> > >  EXPORT_SYMBOL_GPL(get_rcu_tasks_rude_gp_kthread);
> > >
> > > +void rcu_tasks_rude_get_gp_data(int *flags, unsigned long *gp_seq)
> > > +{
> > > +     *flags = 0;
> > > +     *gp_seq = rcu_seq_current(&rcu_tasks_rude.tasks_gp_seq);
> > > +}
> > > +EXPORT_SYMBOL_GPL(rcu_tasks_rude_get_gp_data);
> > > +
> > >  #endif /* #ifdef CONFIG_TASKS_RUDE_RCU */
> > >
> > >  ////////////////////////////////////////////////////////////////////////
> > > @@ -2020,6 +2034,13 @@ struct task_struct *get_rcu_tasks_trace_gp_kthread(void)
> > >  }
> > >  EXPORT_SYMBOL_GPL(get_rcu_tasks_trace_gp_kthread);
> > >
> > > +void rcu_tasks_trace_get_gp_data(int *flags, unsigned long *gp_seq)
> > > +{
> > > +     *flags = 0;
> > > +     *gp_seq = rcu_seq_current(&rcu_tasks_trace.tasks_gp_seq);
> > > +}
> > > +EXPORT_SYMBOL_GPL(rcu_tasks_trace_get_gp_data);
> > > +
> > >  #else /* #ifdef CONFIG_TASKS_TRACE_RCU */
> > >  static void exit_tasks_rcu_finish_trace(struct task_struct *t) { }
> > >  #endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 9fbb5ab57c84..e229a12afe31 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -539,17 +539,10 @@ static struct rcu_node *rcu_get_root(void)
> > >  /*
> > >   * Send along grace-period-related data for rcutorture diagnostics.
> > >   */
> > > -void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
> > > -                         unsigned long *gp_seq)
> > > +void rcutorture_get_gp_data(int *flags, unsigned long *gp_seq)
> > >  {
> > > -     switch (test_type) {
> > > -     case RCU_FLAVOR:
> > > -             *flags = READ_ONCE(rcu_state.gp_flags);
> > > -             *gp_seq = rcu_seq_current(&rcu_state.gp_seq);
> > > -             break;
> > > -     default:
> > > -             break;
> > > -     }
> > > +     *flags = READ_ONCE(rcu_state.gp_flags);
> > > +     *gp_seq = rcu_seq_current(&rcu_state.gp_seq);
> > >  }
> > >  EXPORT_SYMBOL_GPL(rcutorture_get_gp_data);
> > >
> > > --
> > > 2.17.1
> > >

