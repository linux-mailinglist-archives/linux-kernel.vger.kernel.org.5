Return-Path: <linux-kernel+bounces-105351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B5987DC83
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 08:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71E91C20F64
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 07:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13F4E574;
	Sun, 17 Mar 2024 07:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqkjDmg0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F47611E;
	Sun, 17 Mar 2024 07:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710661117; cv=none; b=WmiIbO8ZJ3b25UXy6aRHBbQV31uilbgRErIkDU6EIlmUdtvdnzfG8abecvf0sxIl45ufSQ50eDdrNusaVJoePe0XPAgQIEZODi+wQXq1D+teS/BZYnRbqrrB+1cCVHgsx0r/Ivs/HlZ4TOYvbLLCjva/vCJmOawRC0ObQ37UVJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710661117; c=relaxed/simple;
	bh=HHOs0CW8I4gqnedOp3HPM0oA3rWB4jDXwFZHZjPnBL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiXfpZD85gZOSGLOu0Fus2ZkwT7o0+sHCOnzN6lmV3GRahyxjtbhRxYv/msuPLkJBlGDKD4MaU9hkBaZD9LNzjhEQKgEpk5eiw2kc522f0n+xknHggbrPhgrpFqMawCTXR/QRMerzc7R/7Upj85UCFbqpFdGH3gmniB4PsKNO8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqkjDmg0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B5BC433C7;
	Sun, 17 Mar 2024 07:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710661116;
	bh=HHOs0CW8I4gqnedOp3HPM0oA3rWB4jDXwFZHZjPnBL8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=EqkjDmg0nIsSLoL5eadz9Pu2y1y+8grdSFqKFArOGwg6xvAzLenjEcGbM8ElbHTka
	 vqgTMwFcUEch0PdjltMLHLpLz0C7z27QLF0opBmmP/GE5Oi4cYM3iMBXwtAJf403Vk
	 dLauv7ph1yR/FNVJ5hgySK8hnGx+HXinsjMqUjGhpf7FZ6Qfosrx/bXeOQGCPhoFaa
	 tX2OAIyQc+7ppE0v2vPB/9iGZe9wS3OM7ZpFQPtWTB5zet7XqR2+vQExI6nSZgzJOJ
	 lNFpAc3uhuxkupHOLD7hqz/kEUpwn8/ODZa4pfSQXp3x621aui4W9dsb1rtFyhY/el
	 dq9XvC7lidtnQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5C33FCE0D83; Sun, 17 Mar 2024 00:38:33 -0700 (PDT)
Date: Sun, 17 Mar 2024 00:38:33 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Z qiang <qiang.zhang1211@gmail.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu-tasks: Remove unnecessary lazy_jiffies in
 call_rcu_tasks_generic_timer()
Message-ID: <986428d9-5d82-463c-908b-b88435d53e79@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240312113524.7654-1-qiang.zhang1211@gmail.com>
 <d3762d8c-1996-4703-8fa2-f0b00febf2fb@paulmck-laptop>
 <CALm+0cVivqMsTi0P_4dSK5XSE1ZW_Xx=9_h61VapZTtuOoUwDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm+0cVivqMsTi0P_4dSK5XSE1ZW_Xx=9_h61VapZTtuOoUwDw@mail.gmail.com>

On Wed, Mar 13, 2024 at 12:49:50PM +0800, Z qiang wrote:
> >
> > On Tue, Mar 12, 2024 at 07:35:24PM +0800, Zqiang wrote:
> > > The rcu_tasks_percpu structure's->lazy_timer is queued only when
> > > the rcu_tasks structure's->lazy_jiffies is not equal to zero in
> > > call_rcu_tasks_generic(), if the lazy_timer callback is invoked,
> > > that means the lazy_jiffes is not equal to zero, this commit
> > > therefore remove lazy_jiffies check in call_rcu_tasks_generic_timer().
> > >
> > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > > ---
> > >  kernel/rcu/tasks.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > > index b1254cf3c210..439e0b9a2656 100644
> > > --- a/kernel/rcu/tasks.h
> > > +++ b/kernel/rcu/tasks.h
> > > @@ -299,7 +299,7 @@ static void call_rcu_tasks_generic_timer(struct timer_list *tlp)
> > >
> > >       rtp = rtpcp->rtpp;
> > >       raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
> > > -     if (!rcu_segcblist_empty(&rtpcp->cblist) && rtp->lazy_jiffies) {
> > > +     if (!rcu_segcblist_empty(&rtpcp->cblist)) {
> >
> > Good eyes!
> >
> > But did you test with something like a WARN_ON_ONCE(rtp->lazy_jiffies)?
> 
> Hi, Paul
> 
> +  if (!rcu_segcblist_empty(&rtpcp->cblist) &&
> !WARN_ON_ONCE(!rtp->lazy_jiffies))
> 
> I've done tests like this:
> 
> 1. runqemu nographic kvm slirp qemuparams="-smp 4 -m 2048M -drive
> file=$PWD/share.img,if=virtio"
> bootparams="rcupdate.rcu_tasks_trace_lazy_ms=0" -d
> 
> 2.  insmod torture.ko
>      insmod rcutorture.ko torture_type=tasks-tracing fwd_progress=4
> 
> 3. bpftrace -e 't:timer:timer_expire_entry /args->function ==
> kaddr("call_rcu_tasks_generic_timer")/
>                                             {
> printf("comm:%s,cpu:%d,stack:%s,func:%s\n", comm, cpu, kstack,
> ksym(args->function)); }'
> 
> The call_rcu_tasks_generic_timer() has never been executed.

Very good!

Then if we get a couple of acks or reviews from the others acknowledging
that if they ever make ->lazy_jiffies be changeable at runtime, they
will remember to do something to adjust this logic appropriately, I will
take it.  ;-)

							Thanx, Paul

> Thanks
> Zqiang
> 
> 
> >
> >                                                 Thanx, Paul
> >
> > >               if (!rtpcp->urgent_gp)
> > >                       rtpcp->urgent_gp = 1;
> > >               needwake = true;
> > > --
> > > 2.17.1
> > >

