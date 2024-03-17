Return-Path: <linux-kernel+bounces-105346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F26E887DC7E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 08:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69FAF1F217A1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 07:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EAC17984;
	Sun, 17 Mar 2024 07:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ov40e0Da"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EAD14F98;
	Sun, 17 Mar 2024 07:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710660669; cv=none; b=S7v/5FzrBMdtGHw7K5+y/YECS8/4Q4yAJnxjfkYnvkWBEijpqtnFhbk5lE5p6QRlYyoM3vXZgfRUhBgEnDbG2Vj0gI20FCKsuHuEaj0OPwW4eSIIm3JHt81zbJbgNlWmhzhg80WiZGhBTEcYlbZKLF5ytO/f2o5u5hg4Vxbri5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710660669; c=relaxed/simple;
	bh=a/T8ct5y3sl7wBmjTZV15I56STW6/flrOAcEZ7oKA2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJFN9bEZ+3+XuxBCZk26453oTzKrJFCoE7Oki/Zos0ZkDatc9Fih3th3R0D6fUZ7HtSSHcfOP3ND+gUPQyuHjHyZaSMEicRhXwAd2JxxwzLWqAV2fl8wbaxwHqRE2zIVNKAkVwIPK2Cm+KwikJJh8KOIh7DThbVyslZGdRyTM+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ov40e0Da; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A401EC433C7;
	Sun, 17 Mar 2024 07:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710660668;
	bh=a/T8ct5y3sl7wBmjTZV15I56STW6/flrOAcEZ7oKA2Q=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ov40e0Daw5ymbjg7URE6xFFwSrQ0XWSk8ROY8qo6Cykx9qGfML7pelvByRLGJDDkU
	 bhGFpXaKFvLCFq10XqWSyoG6oIcdtLT+vETSPnDoCJX4eBHcLpAhYWdVXB9OXc3BfV
	 btMkzh0LYaT5ySeb2cswcGyRL0oGayblT1Lbycg43rcHbgfU/A4faC4W4Mw0JvnQtV
	 RxOX4n38YZk2RMb15YFisS+8s0Kv9BLNCFBX0J/Q2DeWNrjZ0rEGE//kVE6L+zdjP4
	 wi+1Tce4JF8XPpp9a2KaWKyEj+XMs8Dn41OpPOeAs9riJeiJXJge4fOpwQCihEnFAm
	 hBn6zSHPHvDnw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 97D10CE0D83; Sun, 17 Mar 2024 00:31:05 -0700 (PDT)
Date: Sun, 17 Mar 2024 00:31:05 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Z qiang <qiang.zhang1211@gmail.com>
Cc: frederic@kernel.org, joel@joelfernandes.org, neeraj.upadhyay@kernel.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu-tasks: Avoid rtp_irq_work triggering when the
 rcu-tasks GP is ongoing
Message-ID: <58ca12cc-07a2-407e-b60a-cabeb227ea9c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240311035502.7112-1-qiang.zhang1211@gmail.com>
 <49c73303-fdda-4912-b26a-75f2235b3a62@paulmck-laptop>
 <CALm+0cWeYcp4jKV2H=g5MOHOg6WJ7se0S1g6BhZrwPACiFWYDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm+0cWeYcp4jKV2H=g5MOHOg6WJ7se0S1g6BhZrwPACiFWYDA@mail.gmail.com>

On Sun, Mar 17, 2024 at 03:12:59PM +0800, Z qiang wrote:
> >
> > On Mon, Mar 11, 2024 at 11:55:02AM +0800, Zqiang wrote:
> > > This commit generate rcu_task_gp_in_progress() to check whether
> > > the rcu-tasks GP is ongoing, if is ongoing, avoid trigger
> > > rtp_irq_work to wakeup rcu tasks kthreads in call_rcu_tasks_generic().
> > >
> > > The test results are as follows:
> > >
> > > echo call_rcu_tasks_iw_wakeup > /sys/kernel/debug/tracing/set_ftrace_filter
> > > echo 1 > /sys/kernel/debug/tracing/function_profile_enabled
> > > insmod rcutorture.ko torture_type=tasks-tracing fwd_progress=4
> > > sleep 600
> > > rmmod rcutorture.ko
> > > echo 0 > /sys/kernel/debug/tracing/function_profile_enabled
> > > echo > /sys/kernel/debug/tracing/set_ftrace_filter
> > >
> > > head /sys/kernel/debug/tracing/trace_stat/function*
> > >
> > > original: 56376  apply patch: 33521
> > >
> > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> >
> > Note that rcu_seq_current() does not provide ordering.  So are you
> > sure that this change is safe on weakly ordered systems such as ARM?
> 
> The  rcu_seq_current() provide implicit address-dependency barriers, or
> did I miss something?

It would be ordered after the last update of the grace-period sequence
number, but that update has not happened yet.

> > For example, consider the following sequence of events:
> >
> > o       The call_rcu_tasks_generic() function picks up the grace-period
> >         sequence number, which shows that there is a grace period in
> >         progress.
> 
> The rcu-callback has been enqueued to list before we pick up the
> gp seq number.

That is true, but what guarantees that the grace-period kthread will see
the callback as having been enqueued?  In a kernel that was built with
CONFIG_RCU_NOCB_CPU, rcu_segcblist_n_cbs() is just a READ_ONCE(), right?

> > o       The grace period ends, and sees no reason to start a new grace
> >         period.
> 
> the gp ends, the rcu_tasks_need_gpcb() will be invoked to check
> whether to start a new gp.   find pending callback, the new gp
> will start  or did I miss something?

Maybe you aren't missing something, but in that case I need you to tell
me exactly what guarantees the ordering.  Please keep in mind that even
in x86, propagation delays can result in reads on one CPU returning the
old value long after some other CPU wrote the new value.  And at least
on the surface, this scenario involves each CPU doing an unordered read
and getting the old value.  (The CPU queueing the new callback got an
old value for the grace-period sequence number and the CPU ending the
grace period got an old value for the number of callbacks queued at the
other CPU.)

So please tell me exactly what prevents that scenario from happening.

							Thanx, Paul

> Thanks
> Zqiang
> 
> 
> >
> > o       The call_rcu_tasks_generic() function sees no reason to wake
> >         up the grace-period kthread.  There are no more calls to
> >         call_rcu_tasks*(), so the callback is never invoked.
> >
> > Or is there something that prevents this sequence of events from
> > ever happening on weakly ordered systems?
> >
> >                                                         Thanx, Paul
> >
> > > ---
> > >
> > > original:
> > > ==> /sys/kernel/debug/tracing/trace_stat/function0 <==
> > >   Function                               Hit    Time            Avg             s^2
> > >   --------                               ---    ----            ---             ---
> > >   call_rcu_tasks_iw_wakeup             13217    19292.52 us     1.459 us        8.834 us
> > >
> > > ==> /sys/kernel/debug/tracing/trace_stat/function1 <==
> > >   Function                               Hit    Time            Avg             s^2
> > >   --------                               ---    ----            ---             ---
> > >   call_rcu_tasks_iw_wakeup             15146    22377.01 us     1.477 us        22.873 us
> > >
> > > ==> /sys/kernel/debug/tracing/trace_stat/function2 <==
> > >   Function                               Hit    Time            Avg             s^2
> > >   --------                               ---    ----            ---             ---
> > >   call_rcu_tasks_iw_wakeup             12561    18125.76 us     1.443 us        6.372 us
> > >
> > > ==> /sys/kernel/debug/tracing/trace_stat/function3 <==
> > >   Function                               Hit    Time            Avg             s^2
> > >   --------                               ---    ----            ---             ---
> > >   call_rcu_tasks_iw_wakeup             15452    21770.57 us     1.408 us        6.710 us
> > >
> > > apply patch:
> > > ==> /sys/kernel/debug/tracing/trace_stat/function0 <==
> > >   Function                               Hit    Time            Avg             s^2
> > >   --------                               ---    ----            ---             ---
> > >   call_rcu_tasks_iw_wakeup              8334    15121.13 us     1.814 us        4.457 us
> > >
> > > ==> /sys/kernel/debug/tracing/trace_stat/function1 <==
> > >   Function                               Hit    Time            Avg             s^2
> > >   --------                               ---    ----            ---             ---
> > >   call_rcu_tasks_iw_wakeup              8355    15760.51 us     1.886 us        14.775 us
> > >
> > > ==> /sys/kernel/debug/tracing/trace_stat/function2 <==
> > >   Function                               Hit    Time            Avg             s^2
> > >   --------                               ---    ----            ---             ---
> > >   call_rcu_tasks_iw_wakeup              7219    14194.27 us     1.966 us        42.440 us
> > >
> > > ==> /sys/kernel/debug/tracing/trace_stat/function3 <==
> > >   Function                               Hit    Time            Avg             s^2
> > >   --------                               ---    ----            ---             ---
> > >   call_rcu_tasks_iw_wakeup              9613    19850.04 us     2.064 us        91.023 us
> > >
> > >  kernel/rcu/tasks.h | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > > index 147b5945d67a..36c7e1d441d0 100644
> > > --- a/kernel/rcu/tasks.h
> > > +++ b/kernel/rcu/tasks.h
> > > @@ -317,6 +317,11 @@ static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp)
> > >       rcuwait_wake_up(&rtp->cbs_wait);
> > >  }
> > >
> > > +static int rcu_task_gp_in_progress(struct rcu_tasks *rtp)
> > > +{
> > > +     return rcu_seq_state(rcu_seq_current(&rtp->tasks_gp_seq));
> > > +}
> > > +
> > >  // Enqueue a callback for the specified flavor of Tasks RCU.
> > >  static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
> > >                                  struct rcu_tasks *rtp)
> > > @@ -375,7 +380,8 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
> > >       }
> > >       rcu_read_unlock();
> > >       /* We can't create the thread unless interrupts are enabled. */
> > > -     if (needwake && READ_ONCE(rtp->kthread_ptr))
> > > +     if (needwake && READ_ONCE(rtp->kthread_ptr) &&
> > > +                     !rcu_task_gp_in_progress(rtp))
> > >               irq_work_queue(&rtpcp->rtp_irq_work);
> > >  }
> > >
> > > --
> > > 2.17.1
> > >

