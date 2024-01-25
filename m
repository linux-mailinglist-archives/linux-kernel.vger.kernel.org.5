Return-Path: <linux-kernel+bounces-38552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E78D83C168
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C68B128C1A1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AAF35EF1;
	Thu, 25 Jan 2024 11:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTbKPb73"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BA3321AF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 11:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706183829; cv=none; b=RBqCZGBQtPcsBJjOrrw7c66tASProHs2Q9Ry7t3A3JDqx0Rus4nLKredimL9mcbGgzLLeUl0NGtIPgerbxAa7nKMBXX81yi6MlHtlR5BFcz2XIyvQ9b7XZ3qjNUigxB8IU0HYojiD3s1YY7iSG4U+cR6PivPVO8K88tvKssdlgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706183829; c=relaxed/simple;
	bh=BGJEiMlRzKX4t3iaxmTX45WOVv5F3++XmfXJuH9STFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaZAFbzmAYMY0OG6oGaF168t7lifclHn2vf6HyCREQbOGxjfiJ35sL122aZmKIk5/B4uiEDIDGIqwtYl2vbZMI1JvF9lG3rByej4V+WOiqhnhDy8UNdYewEX0VywE5HNkyaDHJsr/EZNviY4kbkY1DL+wA0+dE9b6jKovCy53w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTbKPb73; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4005BC433F1;
	Thu, 25 Jan 2024 11:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706183828;
	bh=BGJEiMlRzKX4t3iaxmTX45WOVv5F3++XmfXJuH9STFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PTbKPb73asJ5zmYLUHClgodfcyX+3wmYXgyhUeOVMf6lQfOqwoYe/P141miqkwhID
	 bv8nBLnzi/511BpJ8ghZIG5Oe62x2cjhcbt9Q/2klP/f79n32FevjzI3F0zqyBr1/u
	 LCrkohXipQYpNVKUj7X7BDAJYvh/OdMzEzu7Pg3Mvs14G5kV3RLCGbgVhpe2v5EP00
	 XfbW3zpUGO9nNdLwNHsSL7Xwg72fT9XXEMikEbLxmT64QfeOGSQ9K5ntB4Ua89Flqx
	 w5pzzDKcxySYWkvLYG5rKDr6Z51s0udZLpVg7YgSPzzh6DUKa0RbRsdY93QSA88Ccd
	 hZhbjcbmnccSg==
Date: Thu, 25 Jan 2024 12:57:05 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peng Liu <liupeng17@lenovo.com>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 01/15] tick/nohz: Remove duplicate between
 tick_nohz_switch_to_nohz() and tick_setup_sched_timer()
Message-ID: <ZbJMkautxpj1sQEJ@lothringen>
References: <20240124170459.24850-1-frederic@kernel.org>
 <20240124170459.24850-2-frederic@kernel.org>
 <87h6j1kc97.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6j1kc97.ffs@tglx>

On Thu, Jan 25, 2024 at 10:12:20AM +0100, Thomas Gleixner wrote:
> On Wed, Jan 24 2024 at 18:04, Frederic Weisbecker wrote:
> >  
> >  /**
> >   * tick_setup_sched_timer - setup the tick emulation timer
> > + * @mode: tick_nohz_mode to setup for
> >   */
> > -void tick_setup_sched_timer(void)
> > +void tick_setup_sched_timer(int mode)
> >  {
> >  	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
> > -	ktime_t now = ktime_get();
> >  
> >  	/* Emulate tick processing via per-CPU hrtimers: */
> >  	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
> > -	ts->sched_timer.function = tick_nohz_highres_handler;
> > +#ifdef CONFIG_HIGH_RES_TIMERS
> > +	if (mode == NOHZ_MODE_HIGHRES)
> > +		ts->sched_timer.function = tick_nohz_highres_handler;
> > +#endif
> 
> Adding
> 
> #define tick_nohz_highres_handler NULL
> 
> for CONFIG_HIGH_RES_TIMERS=n somewhere allows you to write that as:
> 
> 	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && mode == NOHZ_MODE_HIGHRES)
> 		ts->sched_timer.function = tick_nohz_highres_handler;

So the next patch does:

if (mode == NOHZ_MODE_HIGHRES)
    ts->sched_timer.function = tick_nohz_highres_handler;

Because that condition only happens in CONFIG_HIGH_RES_TIMERS anyway
and the function field exists in any case.

I can move that to the current patch though.

>     
> > +	hrtimer_forward_now(&ts->sched_timer, TICK_NSEC);
> > +	if (mode == NOHZ_MODE_HIGHRES)
> 
> Wants a (IS_ENABLED(HIGRES) && mode == ...) no?

Hmm, indeed hrtimer_start_range_ns() called by hrtimer_start_expires()
is only defined if CONFIG_HIGH_RES_TIMERS=y. I'll resend.

Thanks.

> 
> Thanks,
> 
>         tglx

