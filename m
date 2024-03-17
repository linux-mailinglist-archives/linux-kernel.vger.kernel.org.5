Return-Path: <linux-kernel+bounces-105549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A79F687DFF8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 21:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE241F21346
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A46208A3;
	Sun, 17 Mar 2024 20:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwVXuhBt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FDF20315;
	Sun, 17 Mar 2024 20:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710707288; cv=none; b=e0V/Os3DgSf86/E58QgtqItxvWTbJcwruDD58KDIIn+uzWHVu51qcZ/9AvVAoEepQvAWRT7Yjve++bWORY8cQeBfuYWPZFpvQJqp6MzcQExOFR/5gmYMoINZOuDZswc5MJaXarvFqraOPi/AbwkJx2241XZJ3hl7N4UCBOP0WTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710707288; c=relaxed/simple;
	bh=rxI9ytld0UKrdtmy6bxfUL6Uq9vOul2rTgLxUBzkaK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKLwONgASOZMI074d6D/Lkzcztc1s+akMh8rM5XEme+FkzEPTulPb9rrh81aW5stjSTRo07rF49KjuUeWNYSfNID9bjfFRv1+dNFC96AvEiyXKr6tuyCnfK7yJ8f2gcvU8dsBgS9cA+GewaM4614y5EAs8ySy/cKkm1t3SvFcU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwVXuhBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C230BC433F1;
	Sun, 17 Mar 2024 20:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710707288;
	bh=rxI9ytld0UKrdtmy6bxfUL6Uq9vOul2rTgLxUBzkaK0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=cwVXuhBt6ruNDC7u39KoWWE/c/ubyO6dr3aD7e8i+A2FB8iTo06iJRm7ZcnLXJpVF
	 OM3QbdU1ihwaY2MKIRCqj+PDdANOk28+NxtzOc9LnsWM3OW9znBmBl7iQG/F36jAgg
	 JoQxGTYP/q/sx3VHwgf0P+RAqlBf80QhkQBkDsKG3GH1H41AhBXpiKba5lN722BgKE
	 nS8zqqZpkh5J13cySlLiNRRH8ZcWV7jpeQPDRmnsJMxABkC1WjYQA/bVCAoDBnZH9/
	 lcWNmDt5NS0x/TmXxbXmKLrTlLcJDbA+ZleF7N0o9pXHA0KRoLc8HCxvxz1pJVUYjU
	 fZtae2IJG+M6Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 778B2CE0D83; Sun, 17 Mar 2024 13:28:04 -0700 (PDT)
Date: Sun, 17 Mar 2024 13:28:04 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Z qiang <qiang.zhang1211@gmail.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu-tasks: Remove unnecessary lazy_jiffies in
 call_rcu_tasks_generic_timer()
Message-ID: <ed220ce3-943f-4554-8f79-fd5da1dfb458@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240312113524.7654-1-qiang.zhang1211@gmail.com>
 <d3762d8c-1996-4703-8fa2-f0b00febf2fb@paulmck-laptop>
 <CALm+0cVivqMsTi0P_4dSK5XSE1ZW_Xx=9_h61VapZTtuOoUwDw@mail.gmail.com>
 <986428d9-5d82-463c-908b-b88435d53e79@paulmck-laptop>
 <CALm+0cWf9ODsxodfm+3JHciuEAe4=0fA3R4n4rhjh7XZzHonNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm+0cWf9ODsxodfm+3JHciuEAe4=0fA3R4n4rhjh7XZzHonNQ@mail.gmail.com>

On Sun, Mar 17, 2024 at 10:31:22PM +0800, Z qiang wrote:
> > On Wed, Mar 13, 2024 at 12:49:50PM +0800, Z qiang wrote:
> > > > On Tue, Mar 12, 2024 at 07:35:24PM +0800, Zqiang wrote:
> > > > > The rcu_tasks_percpu structure's->lazy_timer is queued only when
> > > > > the rcu_tasks structure's->lazy_jiffies is not equal to zero in
> > > > > call_rcu_tasks_generic(), if the lazy_timer callback is invoked,
> > > > > that means the lazy_jiffes is not equal to zero, this commit
> > > > > therefore remove lazy_jiffies check in call_rcu_tasks_generic_timer().
> > > > >
> > > > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > > > > ---
> > > > >  kernel/rcu/tasks.h | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > > > > index b1254cf3c210..439e0b9a2656 100644
> > > > > --- a/kernel/rcu/tasks.h
> > > > > +++ b/kernel/rcu/tasks.h
> > > > > @@ -299,7 +299,7 @@ static void call_rcu_tasks_generic_timer(struct timer_list *tlp)
> > > > >
> > > > >       rtp = rtpcp->rtpp;
> > > > >       raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
> > > > > -     if (!rcu_segcblist_empty(&rtpcp->cblist) && rtp->lazy_jiffies) {
> > > > > +     if (!rcu_segcblist_empty(&rtpcp->cblist)) {
> > > >
> > > > Good eyes!
> > > >
> > > > But did you test with something like a WARN_ON_ONCE(rtp->lazy_jiffies)?
> > >
> > > Hi, Paul
> > >
> > > +  if (!rcu_segcblist_empty(&rtpcp->cblist) &&
> > > !WARN_ON_ONCE(!rtp->lazy_jiffies))
> > >
> > > I've done tests like this:
> > >
> > > 1. runqemu nographic kvm slirp qemuparams="-smp 4 -m 2048M -drive
> > > file=$PWD/share.img,if=virtio"
> > > bootparams="rcupdate.rcu_tasks_trace_lazy_ms=0" -d
> > >
> > > 2.  insmod torture.ko
> > >      insmod rcutorture.ko torture_type=tasks-tracing fwd_progress=4
> > >
> > > 3. bpftrace -e 't:timer:timer_expire_entry /args->function ==
> > > kaddr("call_rcu_tasks_generic_timer")/
> > >                                             {
> > > printf("comm:%s,cpu:%d,stack:%s,func:%s\n", comm, cpu, kstack,
> > > ksym(args->function)); }'
> > >
> > > The call_rcu_tasks_generic_timer() has never been executed.
> >
> > Very good!
> >
> > Then if we get a couple of acks or reviews from the others acknowledging
> > that if they ever make ->lazy_jiffies be changeable at runtime, they
> > will remember to do something to adjust this logic appropriately, I will
> > take it.  ;-)
> >
> 
> Hi, Paul
> 
> Would it be better to modify it as follows? set needwake not
> depend on lazy_jiffies,  if  ->lazy_jiffies be changed at runtime,
> and set it to zero, will miss the chance to wake up gp kthreads.
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index e7ac9138a4fd..aea2b71af36c 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -299,11 +299,12 @@ static void call_rcu_tasks_generic_timer(struct
> timer_list *tlp)
> 
>         rtp = rtpcp->rtpp;
>         raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
> -       if (!rcu_segcblist_empty(&rtpcp->cblist) && rtp->lazy_jiffies) {
> +       if (!rcu_segcblist_empty(&rtpcp->cblist)) {
>                 if (!rtpcp->urgent_gp)
>                         rtpcp->urgent_gp = 1;
>                 needwake = true;
> -               mod_timer(&rtpcp->lazy_timer, rcu_tasks_lazy_time(rtp));
> +               if (rtp->lazy_jiffies)
> +                       mod_timer(&rtpcp->lazy_timer, rcu_tasks_lazy_time(rtp));
>         }
>         raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
>         if (needwake)

Interesting approach!

But how does that avoid defeating laziness by doing the wakeup early?

							Thanx, Paul

> Thanks
> Zqiang
> 
> 
> >                                                         Thanx, Paul
> >
> > > Thanks
> > > Zqiang
> > >
> > >
> > > >
> > > >                                                 Thanx, Paul
> > > >
> > > > >               if (!rtpcp->urgent_gp)
> > > > >                       rtpcp->urgent_gp = 1;
> > > > >               needwake = true;
> > > > > --
> > > > > 2.17.1
> > > > >

