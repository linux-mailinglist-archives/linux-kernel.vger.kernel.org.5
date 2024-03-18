Return-Path: <linux-kernel+bounces-105665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2C887E247
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 03:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5C321F21DEA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EF11DFC4;
	Mon, 18 Mar 2024 02:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzSpKKRN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28741CD23;
	Mon, 18 Mar 2024 02:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710730136; cv=none; b=joELPeDwq2aYM19VsYawHpSdWZQiVH9N2tjlukYfHdmRq95HSphml8/JYU5d/nyI/QK8DNicI2T0r/KuOYtCsVz1VMv2xTZjLcXVZWM+vrfAI8hmbdgHULccucH3QlpMwEXs7Ff7H5pRYDhDnHjxNMLZOr87gS/9dORZ8YIOpKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710730136; c=relaxed/simple;
	bh=CzvPHoJJhRy8ouq9M+SUixwcSc9tWXezI/vHAFvTKuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ztf9ZqL2me8EaRlPwQF2M79xo9nk9ci2XHUxdIiaoqE83u4M9x8GuilAgWnXUsbcZTlPbwNjQG1dyr2A94uI0cv7hroy8lgGJtWEmFkP1MH00Inl4irJupcwEJtWvNg3WjOVTjDX5IJ+xx2fWes6QTias9W7Y9Tmw/92eW3G0cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzSpKKRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC94C433F1;
	Mon, 18 Mar 2024 02:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710730136;
	bh=CzvPHoJJhRy8ouq9M+SUixwcSc9tWXezI/vHAFvTKuw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=pzSpKKRNqVx75HPJncZTGDAfAOfv+O603VOCS+vZ4wr5/Akbick6T10vEpsUBoDT0
	 07G02j6r9gAl1VKp+7adRpUiZ8rV2W5JSl8AYPeYVG3/caYB9uKDyFDw8ffdTuLaH6
	 RkSJphGJmbxLVPPeBEuPI0p+4zD1HktNMvhB18KQ++zWF5SAB6YBxE6LL2HlDVBImY
	 T9EnsAVw/sLT7T1mSxIn00dWxNf0NFt4RrH0s2GQaH98uYulF9dkthGDE5Zuz4xzPa
	 8cNyC1HDe5l4tt4UTmbgFI4NBmRnE6Z+kWdevqXgCuLixzXC5pXZ+9Si/P2PVrnPSs
	 kptCgwfr0lZRw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 32A4CCE0D83; Sun, 17 Mar 2024 19:48:54 -0700 (PDT)
Date: Sun, 17 Mar 2024 19:48:54 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Z qiang <qiang.zhang1211@gmail.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu-tasks: Remove unnecessary lazy_jiffies in
 call_rcu_tasks_generic_timer()
Message-ID: <9247666f-8557-4419-a4aa-42193c386086@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240312113524.7654-1-qiang.zhang1211@gmail.com>
 <d3762d8c-1996-4703-8fa2-f0b00febf2fb@paulmck-laptop>
 <CALm+0cVivqMsTi0P_4dSK5XSE1ZW_Xx=9_h61VapZTtuOoUwDw@mail.gmail.com>
 <986428d9-5d82-463c-908b-b88435d53e79@paulmck-laptop>
 <CALm+0cWf9ODsxodfm+3JHciuEAe4=0fA3R4n4rhjh7XZzHonNQ@mail.gmail.com>
 <ed220ce3-943f-4554-8f79-fd5da1dfb458@paulmck-laptop>
 <CALm+0cVywbBNfzZBjcxJNvpeixkBrfPZu_4qSnOXQvqYTbjMyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm+0cVywbBNfzZBjcxJNvpeixkBrfPZu_4qSnOXQvqYTbjMyg@mail.gmail.com>

On Mon, Mar 18, 2024 at 10:35:44AM +0800, Z qiang wrote:
> > On Sun, Mar 17, 2024 at 10:31:22PM +0800, Z qiang wrote:
> > > > On Wed, Mar 13, 2024 at 12:49:50PM +0800, Z qiang wrote:
> > > > > > On Tue, Mar 12, 2024 at 07:35:24PM +0800, Zqiang wrote:
> > > > > > > The rcu_tasks_percpu structure's->lazy_timer is queued only when
> > > > > > > the rcu_tasks structure's->lazy_jiffies is not equal to zero in
> > > > > > > call_rcu_tasks_generic(), if the lazy_timer callback is invoked,
> > > > > > > that means the lazy_jiffes is not equal to zero, this commit
> > > > > > > therefore remove lazy_jiffies check in call_rcu_tasks_generic_timer().
> > > > > > >
> > > > > > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > > > > > > ---
> > > > > > >  kernel/rcu/tasks.h | 2 +-
> > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > > > > > > index b1254cf3c210..439e0b9a2656 100644
> > > > > > > --- a/kernel/rcu/tasks.h
> > > > > > > +++ b/kernel/rcu/tasks.h
> > > > > > > @@ -299,7 +299,7 @@ static void call_rcu_tasks_generic_timer(struct timer_list *tlp)
> > > > > > >
> > > > > > >       rtp = rtpcp->rtpp;
> > > > > > >       raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
> > > > > > > -     if (!rcu_segcblist_empty(&rtpcp->cblist) && rtp->lazy_jiffies) {
> > > > > > > +     if (!rcu_segcblist_empty(&rtpcp->cblist)) {
> > > > > >
> > > > > > Good eyes!
> > > > > >
> > > > > > But did you test with something like a WARN_ON_ONCE(rtp->lazy_jiffies)?
> > > > >
> > > > > Hi, Paul
> > > > >
> > > > > +  if (!rcu_segcblist_empty(&rtpcp->cblist) &&
> > > > > !WARN_ON_ONCE(!rtp->lazy_jiffies))
> > > > >
> > > > > I've done tests like this:
> > > > >
> > > > > 1. runqemu nographic kvm slirp qemuparams="-smp 4 -m 2048M -drive
> > > > > file=$PWD/share.img,if=virtio"
> > > > > bootparams="rcupdate.rcu_tasks_trace_lazy_ms=0" -d
> > > > >
> > > > > 2.  insmod torture.ko
> > > > >      insmod rcutorture.ko torture_type=tasks-tracing fwd_progress=4
> > > > >
> > > > > 3. bpftrace -e 't:timer:timer_expire_entry /args->function ==
> > > > > kaddr("call_rcu_tasks_generic_timer")/
> > > > >                                             {
> > > > > printf("comm:%s,cpu:%d,stack:%s,func:%s\n", comm, cpu, kstack,
> > > > > ksym(args->function)); }'
> > > > >
> > > > > The call_rcu_tasks_generic_timer() has never been executed.
> > > >
> > > > Very good!
> > > >
> > > > Then if we get a couple of acks or reviews from the others acknowledging
> > > > that if they ever make ->lazy_jiffies be changeable at runtime, they
> > > > will remember to do something to adjust this logic appropriately, I will
> > > > take it.  ;-)
> > > >
> > >
> > > Hi, Paul
> > >
> > > Would it be better to modify it as follows? set needwake not
> > > depend on lazy_jiffies,  if  ->lazy_jiffies be changed at runtime,
> > > and set it to zero, will miss the chance to wake up gp kthreads.
> > >
> > > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > > index e7ac9138a4fd..aea2b71af36c 100644
> > > --- a/kernel/rcu/tasks.h
> > > +++ b/kernel/rcu/tasks.h
> > > @@ -299,11 +299,12 @@ static void call_rcu_tasks_generic_timer(struct
> > > timer_list *tlp)
> > >
> > >         rtp = rtpcp->rtpp;
> > >         raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
> > > -       if (!rcu_segcblist_empty(&rtpcp->cblist) && rtp->lazy_jiffies) {
> > > +       if (!rcu_segcblist_empty(&rtpcp->cblist)) {
> > >                 if (!rtpcp->urgent_gp)
> > >                         rtpcp->urgent_gp = 1;
> > >                 needwake = true;
> > > -               mod_timer(&rtpcp->lazy_timer, rcu_tasks_lazy_time(rtp));
> > > +               if (rtp->lazy_jiffies)
> > > +                       mod_timer(&rtpcp->lazy_timer, rcu_tasks_lazy_time(rtp));
> > >         }
> > >         raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
> > >         if (needwake)
> >
> > Interesting approach!
> >
> > But how does that avoid defeating laziness by doing the wakeup early?
> 
> Hello, Paul
> 
> Does this mean that if cblist is empty, we will miss the opportunity to
> enqueue the timer again?  If so, we can move mod_timer() outside
> the if condition.
> or I didn't understand your question?

Never mind!  I was getting confused, and forgetting that this code has
already seen a timeout.

Let's see what others think.

							Thanx, Paul

> Thanks
> Zqiang
> 
> 
> >
> >                                                         Thanx, Paul
> >
> > > Thanks
> > > Zqiang
> > >
> > >
> > > >                                                         Thanx, Paul
> > > >
> > > > > Thanks
> > > > > Zqiang
> > > > >
> > > > >
> > > > > >
> > > > > >                                                 Thanx, Paul
> > > > > >
> > > > > > >               if (!rtpcp->urgent_gp)
> > > > > > >                       rtpcp->urgent_gp = 1;
> > > > > > >               needwake = true;
> > > > > > > --
> > > > > > > 2.17.1
> > > > > > >

