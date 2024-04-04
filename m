Return-Path: <linux-kernel+bounces-130854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CB8897DF9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 05:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B3F1C260F2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 03:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761DC1CFB9;
	Thu,  4 Apr 2024 03:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5L301+i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968711C6B8;
	Thu,  4 Apr 2024 03:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712200774; cv=none; b=C3nImo7wXcCenI4TqOtN/UmtIeUsbpEZcQY4QQitJm9oY2ZvMZnXdQ2yEEttQ+NUBw0/4PQBZI1mJZvCiqaiPjFbb96rxEz0STmaIPGfeVxHajdENxqYRXHdObiX8/At7FjuKKuqrlhsi6gXU1ilfh3pUte93I/WQ966dqH5ifw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712200774; c=relaxed/simple;
	bh=ldfQo3BSNnBOeM7Tjq0xfnzNFWEHirIrlaezS1F3UP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxS7wEgmHX5XSM8nRHRoAZfQX89snVFrKrLGOVYpFyGGUpm9ado1GUDEZfDKv1TlUGJOdABqjd/uJUBnUd667+NkztAHWKATNN27E3NauOwz53EznZ3j6dKKSyVcg5YfnhOmAvAgwPgSBfUxR9bfWzog5EV8qQjbxDIz44N9G+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5L301+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5CCC433C7;
	Thu,  4 Apr 2024 03:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712200774;
	bh=ldfQo3BSNnBOeM7Tjq0xfnzNFWEHirIrlaezS1F3UP0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=f5L301+i4wdZ4B4SwIgVfJeonOyUhobPtdxSZ/DTKKn5D8mx5F71sUId4xDpNUotP
	 0Xqm83NAXhiujot+ZBAsv2unhu4qsSgJJulQWY++MgBex5c5a9UqSCo5cSHl7sbzre
	 20SFb4g7x/AIpRCjwIoqTrEG2muXfNk+bRhJ3D0kMY7X7m3YzUsX0vPc+k4S8PY54w
	 Y4Hv7utj3AezdC6JdXNVt7alKXD1phYv3s4JftkOFEfEgUoVf9NIKVKe/2M3vkQ/rp
	 6cfNX5MJ3w0MtOBSBYX5kjtbQoCVR1LE5m101vC6i7zvZH0+ysklONCSrKdkU79eEh
	 RcbLPGztE6ziA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C1B32CE109B; Wed,  3 Apr 2024 20:19:33 -0700 (PDT)
Date: Wed, 3 Apr 2024 20:19:33 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Z qiang <qiang.zhang1211@gmail.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Make rcutorture support srcu double call test
Message-ID: <9120fc5d-4385-4151-a30c-734c61b0685d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240324124224.615-1-qiang.zhang1211@gmail.com>
 <fded324e-19bd-47a0-bd92-f25aaeddfc1f@paulmck-laptop>
 <CALm+0cUiXDY3n6dvOWSmBqr3MTpAsxO+uwFzMvXySUbw1tBkZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm+0cUiXDY3n6dvOWSmBqr3MTpAsxO+uwFzMvXySUbw1tBkZQ@mail.gmail.com>

On Mon, Mar 25, 2024 at 01:26:19PM +0800, Z qiang wrote:
> >
> > On Sun, Mar 24, 2024 at 08:42:24PM +0800, Zqiang wrote:
> > > This commit also allows rcutorture to support srcu double call test
> > > with CONFIG_DEBUG_OBJECTS_RCU_HEAD option enabled. since the spinlock
> >
> >                                                    ^ Comma ","?
> >
> > > will be called in call_srcu(), in RT-kernel, the spinlock is sleepable,
> >
> > You lost me on "the spinlock will be called in call_srcu()".
> 
> Hi, Paul
> 
> I mean that
> call_srcu()
> ->srcu_gp_start_if_needed
>     ->spin_lock_irqsave_sdp_contention
>          -> spin_trylock_irqsave_rcu_node     (may be return false)
>           ->spin_lock_irqsave_rcu_node(ssp->srcu_sup, *flags);   <---spinlock
> 
> >
> > > therefore remove disable-irq and disable-preempt protection.
> > >
> > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> >
> > Nice!  A question below.
> >
> > > ---
> > >  kernel/rcu/rcutorture.c | 36 +++++++++++++++++++++---------------
> > >  1 file changed, 21 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > > index 3f9c3766f52b..6571a69142f8 100644
> > > --- a/kernel/rcu/rcutorture.c
> > > +++ b/kernel/rcu/rcutorture.c
> > > @@ -388,6 +388,7 @@ struct rcu_torture_ops {
> > >       int extendables;
> > >       int slow_gps;
> > >       int no_pi_lock;
> > > +     int debug_objects;
> > >       const char *name;
> > >  };
> > >
> > > @@ -573,6 +574,7 @@ static struct rcu_torture_ops rcu_ops = {
> > >       .irq_capable            = 1,
> > >       .can_boost              = IS_ENABLED(CONFIG_RCU_BOOST),
> > >       .extendables            = RCUTORTURE_MAX_EXTEND,
> > > +     .debug_objects          = 1,
> > >       .name                   = "rcu"
> > >  };
> > >
> > > @@ -743,6 +745,7 @@ static struct rcu_torture_ops srcu_ops = {
> > >       .cbflood_max    = 50000,
> > >       .irq_capable    = 1,
> > >       .no_pi_lock     = IS_ENABLED(CONFIG_TINY_SRCU),
> > > +     .debug_objects  = 1,
> > >       .name           = "srcu"
> > >  };
> > >
> > > @@ -782,6 +785,7 @@ static struct rcu_torture_ops srcud_ops = {
> > >       .cbflood_max    = 50000,
> > >       .irq_capable    = 1,
> > >       .no_pi_lock     = IS_ENABLED(CONFIG_TINY_SRCU),
> > > +     .debug_objects  = 1,
> > >       .name           = "srcud"
> > >  };
> > >
> > > @@ -3481,35 +3485,37 @@ static void rcu_test_debug_objects(void)
> > >  #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
> > >       struct rcu_head rh1;
> > >       struct rcu_head rh2;
> > > +     int idx;
> > > +
> > > +     if (!cur_ops->debug_objects || !cur_ops->call ||
> > > +                     !cur_ops->cb_barrier)
> >
> > If this is built-in, could we please WARN if there is a conflict?
> 
> WARN_ON_ONCE(!cur_ops->debug_objects) ?

If the RCU flavor asked for debug-objects testing, but didn't provide
the necessary functions to carry it out.  Maybe something like this
between the "if" and the "return"?

	WARN_ON_ONCE(cur_ops->debug_objects &&
		     (!cur_ops->call || !cur_ops->cb_barrier))

> > Otherwise, it looks like the test succeeded.
> >
> > > +             return;
> > > +
> > >       struct rcu_head *rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
> > >
> > >       init_rcu_head_on_stack(&rh1);
> > >       init_rcu_head_on_stack(&rh2);
> > > -     pr_alert("%s: WARN: Duplicate call_rcu() test starting.\n", KBUILD_MODNAME);
> > > +     pr_alert("%s: WARN: Duplicate call_%s() test starting.\n", KBUILD_MODNAME, cur_ops->name);
> > >
> > >       /* Try to queue the rh2 pair of callbacks for the same grace period. */
> > > -     preempt_disable(); /* Prevent preemption from interrupting test. */
> >
> > What makes us not need this preempt_disable() in the RCU case?
> 
> the cur_ops->readlock/unlock() can guarantee that the callback will
> not be called
> when in the readlock/unlock() critical section.
> Besides, for srcu, if invoke preempt_disable(), and the call_srcu()
> internally calls
> spinlock, which will trigger a lockdep warning in RT-kernels.

Very good!

> > > -     rcu_read_lock(); /* Make it impossible to finish a grace period. */
> > > -     call_rcu_hurry(&rh1, rcu_torture_leak_cb); /* Start grace period. */
> > > -     local_irq_disable(); /* Make it harder to start a new grace period. */
> >
> > Same question for the local_irq_disable()?
> >
> > > -     call_rcu_hurry(&rh2, rcu_torture_leak_cb);
> > > -     call_rcu_hurry(&rh2, rcu_torture_err_cb); /* Duplicate callback. */
> > > +     idx = cur_ops->readlock(); /* Make it impossible to finish a grace period. */
> > > +     cur_ops->call(&rh1, rcu_torture_leak_cb); /* Start grace period. */
> > > +     cur_ops->call(&rh2, rcu_torture_leak_cb);
> > > +     cur_ops->call(&rh2, rcu_torture_err_cb); /* Duplicate callback. */
> > >       if (rhp) {
> > > -             call_rcu_hurry(rhp, rcu_torture_leak_cb);
> > > -             call_rcu_hurry(rhp, rcu_torture_err_cb); /* Another duplicate callback. */
> > > +             cur_ops->call(rhp, rcu_torture_leak_cb);
> > > +             cur_ops->call(rhp, rcu_torture_err_cb); /* Another duplicate callback. */
> > >       }
> > > -     local_irq_enable();
> > > -     rcu_read_unlock();
> > > -     preempt_enable();
> > > +     cur_ops->readunlock(idx);
> > >
> > >       /* Wait for them all to get done so we can safely return. */
> > > -     rcu_barrier();
> > > -     pr_alert("%s: WARN: Duplicate call_rcu() test complete.\n", KBUILD_MODNAME);
> > > +     cur_ops->cb_barrier();
> > > +     pr_alert("%s: WARN: Duplicate call_%s() test complete.\n", KBUILD_MODNAME, cur_ops->name);
> > >       destroy_rcu_head_on_stack(&rh1);
> > >       destroy_rcu_head_on_stack(&rh2);
> > >       kfree(rhp);
> > >  #else /* #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
> > > -     pr_alert("%s: !CONFIG_DEBUG_OBJECTS_RCU_HEAD, not testing duplicate call_rcu()\n", KBUILD_MODNAME);
> > > +     pr_alert("%s: !CONFIG_DEBUG_OBJECTS_RCU_HEAD, not testing duplicate call_%s()\n", KBUILD_MODNAME, cur_ops->name);
> > >  #endif /* #else #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
> >
> > It might be possible to simplify the code by turning this #ifdef into
> > IS_ENABLED().
> 
> mean that IS_ENABLED(CONFIG_DEBUG_OBJECTS_RCU_HEAD)?

That is what I was thinking of.  Does that work in this case?

							Thanx, Paul

> Thanks
> Zqiang
> 
> >
> >                                                         Thanx, Paul
> >
> > >  }
> > >
> > > --
> > > 2.17.1
> > >

