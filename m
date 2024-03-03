Return-Path: <linux-kernel+bounces-89628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3700286F339
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 01:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B02EC2840E2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 00:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E905A31;
	Sun,  3 Mar 2024 00:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlRJQD1d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DEE7F;
	Sun,  3 Mar 2024 00:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709425520; cv=none; b=rNSWQKVV4V3LRia0Hv8xS7EBXMWTl0Mmxt5Zj259zO2N2CJz/0FzPM7I4GlQhUI+53Wrv15wDcaU0a9VbhRCGiInoAGq6xq2f4XWesZLf4MZdBSAubWip1ontyhzdmfMUY3o2a3wX9m3RvmvE4W6vr+cJFj1eJcvPG2l95hY9fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709425520; c=relaxed/simple;
	bh=oe4tv+sWsVINy3pdkPlCqyC4weGlijmdXnLiY7j84L0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3VtXBAP4qJi2zzb47yx3BZw45hEygHD29Jy39bHPNHEHi1Ge9l5YZ4zc+/Et3P0brvlEyp+F9SFsuSDML8du+VjuRX+PzD58L00qE7L+y4wUlI7BbyexPO/IDcWDnxiBLOCnK6cn4YVusKSkfi+yUke/ppe8tlds0yG73cvMFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlRJQD1d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A43AC433C7;
	Sun,  3 Mar 2024 00:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709425519;
	bh=oe4tv+sWsVINy3pdkPlCqyC4weGlijmdXnLiY7j84L0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=WlRJQD1dSrsqDKkuIavjqmlcjMtD1dcK3vTLYZzVBqExvISIFOK0RfOoP1KX+e7cD
	 k0ImZC0aXI1Wkim/1NCOT+vS292ylVz1ADz48kChVQ6YJRlYpn9+XU/VOZlRdUPiJW
	 Bc4a5Xin7Oa0uSF0xxI3YK9blzgjckl/VNaWOSZkV5h1PH/btQEpJqzeNK9epopadG
	 BW1SJjHooPlr45S3KS3ZYSgdhgpEy0BYxaPeo649Dv1lqrSXl5bzN/1zB9CoiKjqB9
	 W/rW6QsFHcZr8duE9hhudetxCprtNYcW27Kh56xSSbOtinDjrUMgJkF6BHRo0u16Ih
	 rQAngpljkbNaQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3A805CE08FA; Sat,  2 Mar 2024 16:25:19 -0800 (PST)
Date: Sat, 2 Mar 2024 16:25:19 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Network Development <netdev@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
	kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
Message-ID: <f1e77cd2-18b2-4ab1-8ce3-da2c6babbd53@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <55900c6a-f181-4c5c-8de2-bca640c4af3e@paulmck-laptop>
 <10FC3F5F-AA33-4F81-9EB6-87EB2D41F3EE@joelfernandes.org>
 <99b2ccae-07f6-4350-9c55-25ec7ae065c0@paulmck-laptop>
 <CAEXW_YQ+40a1-hk5ZP+QJ54xniSutosC7MjMscJJy8fen-gU9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YQ+40a1-hk5ZP+QJ54xniSutosC7MjMscJJy8fen-gU9Q@mail.gmail.com>

On Fri, Mar 01, 2024 at 09:24:15PM -0500, Joel Fernandes wrote:
> (Shrinking CC a bit)
> 
> On Thu, Feb 29, 2024 at 1:29 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Thu, Feb 29, 2024 at 12:41:55PM -0500, Joel Fernandes wrote:
> > > > On Feb 29, 2024, at 11:57 AM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > ﻿On Thu, Feb 29, 2024 at 09:21:48AM -0500, Joel Fernandes wrote:
> > > >>> On 2/28/2024 5:58 PM, Paul E. McKenney wrote:
> > > >>> On Wed, Feb 28, 2024 at 02:48:44PM -0800, Alexei Starovoitov wrote:
> > > >>>> On Wed, Feb 28, 2024 at 2:31 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > > >>>>>
> > > >>>>> On Wed, 28 Feb 2024 14:19:11 -0800
> > > >>>>> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > >>>>>
> > > >>>>>>>>
> > > >>>>>>>> Well, to your initial point, cond_resched() does eventually invoke
> > > >>>>>>>> preempt_schedule_common(), so you are quite correct that as far as
> > > >>>>>>>> Tasks RCU is concerned, cond_resched() is not a quiescent state.
> > > >>>>>>>
> > > >>>>>>> Thanks for confirming. :-)
> > > >>>>>>
> > > >>>>>> However, given that the current Tasks RCU use cases wait for trampolines
> > > >>>>>> to be evacuated, Tasks RCU could make the choice that cond_resched()
> > > >>>>>> be a quiescent state, for example, by adjusting rcu_all_qs() and
> > > >>>>>> .rcu_urgent_qs accordingly.
> > > >>>>>>
> > > >>>>>> But this seems less pressing given the chance that cond_resched() might
> > > >>>>>> go away in favor of lazy preemption.
> > > >>>>>
> > > >>>>> Although cond_resched() is technically a "preemption point" and not truly a
> > > >>>>> voluntary schedule, I would be happy to state that it's not allowed to be
> > > >>>>> called from trampolines, or their callbacks. Now the question is, does BPF
> > > >>>>> programs ever call cond_resched()? I don't think they do.
> > > >>>>>
> > > >>>>> [ Added Alexei ]
> > > >>>>
> > > >>>> I'm a bit lost in this thread :)
> > > >>>> Just answering the above question.
> > > >>>> bpf progs never call cond_resched() directly.
> > > >>>> But there are sleepable (aka faultable) bpf progs that
> > > >>>> can call some helper or kfunc that may call cond_resched()
> > > >>>> in some path.
> > > >>>> sleepable bpf progs are protected by rcu_tasks_trace.
> > > >>>> That's a very different one vs rcu_tasks.
> > > >>>
> > > >>> Suppose that the various cond_resched() invocations scattered throughout
> > > >>> the kernel acted as RCU Tasks quiescent states, so that as soon as a
> > > >>> given task executed a cond_resched(), synchronize_rcu_tasks() might
> > > >>> return or call_rcu_tasks() might invoke its callback.
> > > >>>
> > > >>> Would that cause BPF any trouble?
> > > >>>
> > > >>> My guess is "no", because it looks like BPF is using RCU Tasks (as you
> > > >>> say, as opposed to RCU Tasks Trace) only to wait for execution to leave a
> > > >>> trampoline.  But I trust you much more than I trust myself on this topic!
> > > >>
> > > >> But it uses RCU Tasks Trace as well (for sleepable bpf programs), not just
> > > >> Tasks? Looks like that's what Alexei said above as well, and I confirmed it in
> > > >> bpf/trampoline.c
> > > >>
> > > >>        /* The trampoline without fexit and fmod_ret progs doesn't call original
> > > >>         * function and doesn't use percpu_ref.
> > > >>         * Use call_rcu_tasks_trace() to wait for sleepable progs to finish.
> > > >>         * Then use call_rcu_tasks() to wait for the rest of trampoline asm
> > > >>         * and normal progs.
> > > >>         */
> > > >>        call_rcu_tasks_trace(&im->rcu, __bpf_tramp_image_put_rcu_tasks);
> > > >>
> > > >> The code comment says it uses both.
> > > >
> > > > BPF does quite a few interesting things with these.
> > > >
> > > > But would you like to look at the update-side uses of RCU Tasks Rude
> > > > to see if lazy preemption affects them?  I don't believe that there
> > > > are any problems here, but we do need to check.
> > >
> > > Sure I will be happy to. I am planning look at it in detail over the 3 day weekend. Too much fun! ;-)
> >
> > Thank you, and looking forward to seeing what you come up with!
> >
> > The canonical concern would be that someone somewhere is using either
> > call_rcu_tasks_rude() or synchronize_rcu_tasks_rude() to wait for
> > non-preemptible regions of code that does not account for the possibility
> > of preemption in CONFIG_PREEMPT_NONE or PREEMPT_PREEMPT_VOLUNTARY kernels.
> >
> > I *think* that these are used only to handle the possibility
> > of tracepoints on functions on the entry/exit path and on the
> > RCU-not-watching portions of the idle loop.  If so, then there is no
> > difference in behavior for lazy preemption.  But who knows?
> 
> Hi Paul, regarding CONFIG_PREEMPT_AUTO, for Tasks RCU rude, I think
> the following patch will address your concern about quiescent states
> on CPUs spinning away in kernel mode:
> 
> "sched/fair: handle tick expiry under lazy preemption"
> Link: https://lore.kernel.org/all/20240213055554.1802415-24-ankur.a.arora@oracle.com/
> 
> In this patch Ankur makes sure that the scheduling-clock interrupt
> will reschedule the CPU after a tick and not let queued tasks starve
> due to lazy re-scheduling. So my impression is the
> "schedule_on_each_cpu()" should schedule a worker thread in time to
> apply the implied Tasks RCU quiescent state even if the rescheduling
> was a LAZY-reschedule.
> 
> Also, not sure if the "voluntary mode" of CONFIG_PREEMPT_AUTO behaves
> differently. My feeling is regardless of preemption mode,
> CONFIG_PREEMPT_AUTO should always preempt after a tick if something
> else needs to run. It just will not preempt immediately like before
> (although CFS did already have some wakeup preemption logic to slow it
> down a bit). I am reviewing Ankur's patches more to confirm that and
> also reviewing his patches more to see how it could affect.

Thank you for the info!

As you noted, one thing that Ankur's series changes is that preemption
can occur anywhere that it is not specifically disabled in kernels
built with CONFIG_PREEMPT_NONE=y or CONFIG_PREEMPT_VOLUNTARY=y.  This in
turn changes Tasks Rude RCU's definition of a quiescent state for these
kernels, adding all code regions where preemption is not specifically
disabled to the list of such quiescent states.

Although from what I know, this is OK, it would be good to check the
calls to call_rcu_tasks_rude() or synchronize_rcu_tasks_rude() are set
up so as to expect these new quiescent states.  One example where it
would definitely be OK is if there was a call to synchronize_rcu_tasks()
right before or after that call to synchronize_rcu_tasks_rude().

Would you be willing to check the call sites to verify that they
are OK with this change in semantics?

							Thanx, Paul

