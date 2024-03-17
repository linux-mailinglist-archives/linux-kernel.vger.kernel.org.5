Return-Path: <linux-kernel+bounces-105348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F0887DC80
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 08:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C4E1F20FE4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 07:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3953F1C288;
	Sun, 17 Mar 2024 07:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqAiaxzW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F92B1BF35;
	Sun, 17 Mar 2024 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710660699; cv=none; b=LdwOGvbzFejo0CHakh7ZXRvsqXGc2j46ZFaK3zfg/FSRvzVmXm6KH8I1GsTEoSKp8mUV6XzJpQgaLyKieZvo5fy6VbnsliRhK2atPpHcUehlg50Ol37vCxewEucYGycrJ9chEERedFp5/CdzarLQaoL5VDKAhXUCuRfPT3oS1TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710660699; c=relaxed/simple;
	bh=GPZRO/qP9OSJ8w4An6Tzpoe/JSgZlU+igzfSvXj73u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gk0PPlviODNJrUAHAV2Cj+MsP0Z0TmWC+jis6MmSzvBBJzKKzmjawTvZXLGJpkSk0DyFXOSghp30DgaUfrr8F1DJ8ba7RZUR06ZJD2uTfIzgXcMCTRxr8j6PhulYpdvehVc3Ev74wIL4M4pca0NNiuA346evWHZGylFh738fE80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqAiaxzW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BA2C433F1;
	Sun, 17 Mar 2024 07:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710660698;
	bh=GPZRO/qP9OSJ8w4An6Tzpoe/JSgZlU+igzfSvXj73u0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=hqAiaxzWfPMUKmVgvC9AOct2lPFB2GORRMRvj9csQ5zNAODaQjujlGRgWwLSpyEN1
	 +lz0ciCWzcrC4R7cvDnW/u3cqYWbAE7S0Ao22F/N3Z585SUb7YfY0vde0dz15q8Mhy
	 mumVWoe7bGbyeHEjc3CpC4lS8GFWwoCMhg8WnqQAZOhBdwOun9JALg3iSiEMfDBbt/
	 RPAUhNNxIlYI3CGXk95oN9XQHlqgnYiKW1jrlZm4OvCiVqxdDMvu6Nz4nRrgCq35qf
	 RJNtIMcARtaFaF1FgAbRwvRNK6NLxinDJ8ptXPhihtr9mJkhhVmACusBQe9XrHtUMP
	 pG9IPanbOucBw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0AF1CCE0D83; Sun, 17 Mar 2024 00:31:36 -0700 (PDT)
Date: Sun, 17 Mar 2024 00:31:36 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Z qiang <qiang.zhang1211@gmail.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Make rcutorture support print rcu-tasks gp
 state
Message-ID: <7060c4f6-a57c-45ea-bae2-fe515bcf01ff@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240312072357.23517-1-qiang.zhang1211@gmail.com>
 <40a4b0f3-b850-4d73-b514-ce5149abb465@paulmck-laptop>
 <CALm+0cXCK5dj+a8YNe-etxVjJwChPtSeDDL3M7cZxDO1OCTR9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm+0cXCK5dj+a8YNe-etxVjJwChPtSeDDL3M7cZxDO1OCTR9Q@mail.gmail.com>

On Sun, Mar 17, 2024 at 03:16:43PM +0800, Z qiang wrote:
> >
> > On Tue, Mar 12, 2024 at 03:23:57PM +0800, Zqiang wrote:
> > > This commit make rcu-tasks related rcutorture test support rcu-tasks
> > > gp state printing when the writer stall occurs or the at the end of
> > > rcutorture test.
> > >
> > > The test is as follows:
> > > [ 3872.548702] tasks-tracing:  Start-test grace-period state: g4560 f0x0
> > > [ 4332.661283] tasks-tracing:  End-test grace-period state: g41540 f0x0 total-gps=36980
> > >
> > > [ 4401.381138] tasks:  Start-test grace-period state: g8 f0x0
> > > [ 4565.619354] tasks:  End-test grace-period state: g1732 f0x0 total-gps=1724
> > >
> > > [ 4589.006917] tasks-rude:  Start-test grace-period state: g8 f0x0
> > > [ 5059.379321] tasks-rude:  End-test grace-period state: g8508 f0x0 total-gps=8500
> > >
> > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> >
> > Again, good eyes, and that fix would work.  But wouldn't it make more
> > sense to create a new cur_ops function pointer for these functions?
> > That might allow getting rid of the *_FLAVOR checks and values, plus
> > simplify the code a bit.  To make the function signatures work out,
> > there would need to be an intermediate SRCU function to supply the right
> > rcu_struct pointer.
> >
> > This would shorten and simplify the code a bit.
> >
> > Or is there some reason that this won't work?
> 
> Hi, Paul
> 
> Thanks for your suggestion, I will resend with reference to the
> suggestions above.

Very good, looking forward to seeing it!

							Thanx, Paul

> Thanks
> Zqiang
> 
> 
> >
> > Why didn't I do that to start with?  Well, the various RCU flavors
> > appeared one at a time over some years...  ;-)
> >
> >                                                         Thanx, Paul
> >
> > > ---
> > >  kernel/rcu/rcu.h        |  8 ++++++++
> > >  kernel/rcu/rcutorture.c |  3 +++
> > >  kernel/rcu/tasks.h      | 25 +++++++++++++++++++++++++
> > >  3 files changed, 36 insertions(+)
> > >
> > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > > index 86fce206560e..3353e3697645 100644
> > > --- a/kernel/rcu/rcu.h
> > > +++ b/kernel/rcu/rcu.h
> > > @@ -556,6 +556,14 @@ static inline unsigned long rcu_get_jiffies_lazy_flush(void) { return 0; }
> > >  static inline void rcu_set_jiffies_lazy_flush(unsigned long j) { }
> > >  #endif
> > >
> > > +#ifdef CONFIG_TASKS_RCU_GENERIC
> > > +void rcutaskstorture_get_gp_data(enum rcutorture_type test_type, int *flags,
> > > +                             unsigned long *gp_seq);
> > > +#else
> > > +static inline void rcutaskstorture_get_gp_data(enum rcutorture_type test_type, int *flags,
> > > +                             unsigned long *gp_seq) { }
> > > +#endif
> > > +
> > >  #if defined(CONFIG_TREE_RCU)
> > >  void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
> > >                           unsigned long *gp_seq);
> > > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > > index dd7d5ba45740..91c03f37fd97 100644
> > > --- a/kernel/rcu/rcutorture.c
> > > +++ b/kernel/rcu/rcutorture.c
> > > @@ -2267,6 +2267,7 @@ rcu_torture_stats_print(void)
> > >                                      &flags, &gp_seq);
> > >               srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp,
> > >                                       &flags, &gp_seq);
> > > +             rcutaskstorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
> > >               wtp = READ_ONCE(writer_task);
> > >               pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %#x cpu %d\n",
> > >                        rcu_torture_writer_state_getname(),
> > > @@ -3391,6 +3392,7 @@ rcu_torture_cleanup(void)
> > >
> > >       rcutorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
> > >       srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp, &flags, &gp_seq);
> > > +     rcutaskstorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
> > >       pr_alert("%s:  End-test grace-period state: g%ld f%#x total-gps=%ld\n",
> > >                cur_ops->name, (long)gp_seq, flags,
> > >                rcutorture_seq_diff(gp_seq, start_gp_seq));
> > > @@ -3763,6 +3765,7 @@ rcu_torture_init(void)
> > >       rcu_torture_print_module_parms(cur_ops, "Start of test");
> > >       rcutorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
> > >       srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp, &flags, &gp_seq);
> > > +     rcutaskstorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
> > >       start_gp_seq = gp_seq;
> > >       pr_alert("%s:  Start-test grace-period state: g%ld f%#x\n",
> > >                cur_ops->name, (long)gp_seq, flags);
> > > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > > index e83adcdb49b5..b1254cf3c210 100644
> > > --- a/kernel/rcu/tasks.h
> > > +++ b/kernel/rcu/tasks.h
> > > @@ -2149,6 +2149,31 @@ late_initcall(rcu_tasks_verify_schedule_work);
> > >  static void rcu_tasks_initiate_self_tests(void) { }
> > >  #endif /* #else #ifdef CONFIG_PROVE_RCU */
> > >
> > > +void rcutaskstorture_get_gp_data(enum rcutorture_type test_type, int *flags,
> > > +                             unsigned long *gp_seq)
> > > +{
> > > +     switch (test_type) {
> > > +     case RCU_TASKS_FLAVOR:
> > > +#ifdef CONFIG_TASKS_RCU
> > > +             *gp_seq = rcu_seq_current(&rcu_tasks.tasks_gp_seq);
> > > +#endif
> > > +             break;
> > > +     case RCU_TASKS_RUDE_FLAVOR:
> > > +#ifdef CONFIG_TASKS_RUDE_RCU
> > > +             *gp_seq = rcu_seq_current(&rcu_tasks_rude.tasks_gp_seq);
> > > +#endif
> > > +             break;
> > > +     case RCU_TASKS_TRACING_FLAVOR:
> > > +#ifdef CONFIG_TASKS_TRACE_RCU
> > > +             *gp_seq = rcu_seq_current(&rcu_tasks_trace.tasks_gp_seq);
> > > +#endif
> > > +             break;
> > > +     default:
> > > +             break;
> > > +     }
> > > +}
> > > +EXPORT_SYMBOL_GPL(rcutaskstorture_get_gp_data);
> > > +
> > >  void __init tasks_cblist_init_generic(void)
> > >  {
> > >       lockdep_assert_irqs_disabled();
> > > --
> > > 2.17.1
> > >

