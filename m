Return-Path: <linux-kernel+bounces-108837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 533CF8810B3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E1502855F2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995553E49B;
	Wed, 20 Mar 2024 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fj5aKgi6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3013DB8C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 11:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710933264; cv=none; b=My+g4OF+/1e9/d66x+mj1qgCJRnQJYPHfkaYGaBZz4rMk++n0LZzI44mofYtmSK0HBl4kiLIgVbEPkYvqje8deZ8iz6EAwWdeM6tRT1rY43qm8kC2aJpmK4Z+kLiRn1NaxqAxK4V7cpSNzVJzZyI0y/StL1oQXkl1zq3Gck4wJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710933264; c=relaxed/simple;
	bh=f93gNh9P3wLWOA4ykU7okGdefFzZJd7zYhZkTfDnz4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=naIkTV4SocAy1bcLdIUj6LakNebXw8n9qR/PnE0B8avXNtU57llS4k83+ZjyU4z4zlk2bcE1a72sevsIMgtLre6Vs9ml9CErGSYP4FvQVL3M0sg5/epnbIzLK8UvHLi95AQqeEEcENLdbrFTFF4SgFOuBPKUOl2Ii4ozn0FvlbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fj5aKgi6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D41DC433C7;
	Wed, 20 Mar 2024 11:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710933264;
	bh=f93gNh9P3wLWOA4ykU7okGdefFzZJd7zYhZkTfDnz4U=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Fj5aKgi65aIHaS3d8ORiOpHAN3UYX6iaVlDuNr53RextcA6m/ygwVvKnEcu4ubm5W
	 dKS3uf4UyDZxERnoF1O4T44onEZG/vOojjWzg3hfOivxktVBFKv8rdqWdafIWQHwaK
	 kLPME4eeASh+8yZHWzLKLIp6dm6TWKKTRBuqfIiTfXVSw1LqM4Udgr+KMH8hKIVuMv
	 tOWIJ6wGgjQJmp73QRQwBL4YDEFu3eYgmgUMvGCFL/4xuGOaj069jvZEYaXD/sV/ve
	 AydlLPLwTd8+JJ/AqMxcQolmpecY6kq7vALHK70UdXdbSHQhh4ILGS9WgZkT9QuE21
	 /0LQggvFYUpYw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 17299CE0F92; Wed, 20 Mar 2024 04:14:24 -0700 (PDT)
Date: Wed, 20 Mar 2024 04:14:24 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [PATCH 2/2] timers: Fix removed self-IPI on global timer's
 enqueue in nohz_full
Message-ID: <1b5752c8-ef32-4ed4-b539-95d507ec99ce@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240318230729.15497-1-frederic@kernel.org>
 <20240318230729.15497-3-frederic@kernel.org>
 <464f6be2-4a72-440d-be53-6a1035d56a4f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <464f6be2-4a72-440d-be53-6a1035d56a4f@paulmck-laptop>

On Tue, Mar 19, 2024 at 02:18:00AM -0700, Paul E. McKenney wrote:
> On Tue, Mar 19, 2024 at 12:07:29AM +0100, Frederic Weisbecker wrote:
> > While running in nohz_full mode, a task may enqueue a timer while the
> > tick is stopped. However the only places where the timer wheel,
> > alongside the timer migration machinery's decision, may reprogram the
> > next event accordingly with that new timer's expiry are the idle loop or
> > any IRQ tail.
> > 
> > However neither the idle task nor an interrupt may run on the CPU if it
> > resumes busy work in userspace for a long while in full dynticks mode.
> > 
> > To solve this, the timer enqueue path raises a self-IPI that will
> > re-evaluate the timer wheel on its IRQ tail. This asynchronous solution
> > avoids potential locking inversion.
> > 
> > This is supposed to happen both for local and global timers but commit:
> > 
> > 	b2cf7507e186 ("timers: Always queue timers on the local CPU")
> > 
> > broke the global timers case with removing the ->is_idle field handling
> > for the global base. As a result, global timers enqueue may go unnoticed
> > in nohz_full.
> > 
> > Fix this with restoring the idle tracking of the global timer's base,
> > allowing self-IPIs again on enqueue time.
> 
> Testing with the previous patch (1/2 in this series) reduced the number of
> problems by about an order of magnitude, down to two sched_tick_remote()
> instances and one enqueue_hrtimer() instance, very good!
> 
> I have kicked off a test including this patch.  Here is hoping!  ;-)

And 22*100 hours of TREE07 got me one run with a sched_tick_remote()
complaint and another run with a starved RCU grace-period kthread.
So this is definitely getting more reliable, but still a little ways
to go.

							Thanx, Paul

> > Reported-by: Paul E. McKenney <paulmck@kernel.org>
> > Fixes: b2cf7507e186 ("timers: Always queue timers on the local CPU")
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  kernel/time/timer.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> > index e69e75d3858c..dee29f1f5b75 100644
> > --- a/kernel/time/timer.c
> > +++ b/kernel/time/timer.c
> > @@ -642,7 +642,8 @@ trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
> >  	 * the base lock:
> >  	 */
> >  	if (base->is_idle) {
> > -		WARN_ON_ONCE(!(timer->flags & TIMER_PINNED));
> > +		WARN_ON_ONCE(!(timer->flags & TIMER_PINNED ||
> > +			       tick_nohz_full_cpu(base->cpu)));
> >  		wake_up_nohz_cpu(base->cpu);
> >  	}
> >  }
> > @@ -2292,6 +2293,13 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
> >  		 */
> >  		if (!base_local->is_idle && time_after(nextevt, basej + 1)) {
> >  			base_local->is_idle = true;
> > +			/*
> > +			 * Global timers queued locally while running in a task
> > +			 * in nohz_full mode need a self-IPI to kick reprogramming
> > +			 * in IRQ tail.
> > +			 */
> > +			if (tick_nohz_full_cpu(base_local->cpu))
> > +				base_global->is_idle = true;
> >  			trace_timer_base_idle(true, base_local->cpu);
> >  		}
> >  		*idle = base_local->is_idle;
> > @@ -2364,6 +2372,8 @@ void timer_clear_idle(void)
> >  	 * path. Required for BASE_LOCAL only.
> >  	 */
> >  	__this_cpu_write(timer_bases[BASE_LOCAL].is_idle, false);
> > +	if (tick_nohz_full_cpu(smp_processor_id()))
> > +		__this_cpu_write(timer_bases[BASE_GLOBAL].is_idle, false);
> >  	trace_timer_base_idle(false, smp_processor_id());
> >  
> >  	/* Activate without holding the timer_base->lock */
> > -- 
> > 2.44.0
> > 

