Return-Path: <linux-kernel+bounces-6955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0494F819FCC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4DCF285506
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB36636AED;
	Wed, 20 Dec 2023 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwVdaDfC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0DA358B2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28786C433CB;
	Wed, 20 Dec 2023 13:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703078866;
	bh=5tmOTjHygMvIW2ITSWGwywyb1m3QbhuMHEd0ncmMSkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lwVdaDfC/JZuNy2uYuPMNT2u5Q/UO98S2p/+5goIuXllsEMobrRo6RHxke+MkcAbX
	 1JKIYZhq7pl1Gf0y36Fz5Yv3Q/nohVxk4vcRrHfh1PpIAVSACG7meihHDnp0DjFl9u
	 fS/WBsm4/eymB37ZagmQhap02CFftyPSS1KG2eEpnTwy1leflouywL8/BSboWFYXsL
	 kr8wSnru3S0M595/W3bYgDitidK6BmVpUWx0BEgjISBzRGSW0aujRONqgnRld2zkfa
	 0MO+nwo1auduCJTdC+qoyhhrApMHk5kbZUSWL1WbD79R8XYbxR5cErVSFQ1UnParag
	 sXSiRAybhpz8g==
Date: Wed, 20 Dec 2023 14:27:43 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Giovanni Gherdovich <ggherdovich@suse.cz>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v9 03/32] tick-sched: Warn when next tick seems to be in
 the past
Message-ID: <ZYLrz24qc8VQ_BIc@localhost.localdomain>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-4-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231201092654.34614-4-anna-maria@linutronix.de>

Le Fri, Dec 01, 2023 at 10:26:25AM +0100, Anna-Maria Behnsen a écrit :
> When the next tick is in the past, the delta between basemono and the next
> tick gets negativ. But the next tick should never be in the past. The
> negative effect of a wrong next tick might be a stop of the tick and timers
> might expire late.
> 
> To prevent expensive debugging when changing underlying code, add a
> WARN_ON_ONCE into this code path. To prevent complete misbehaviour, also
> reset next_tick to basemono in this case.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
> v9: Add reset of next_tick to basemono
> ---
>  kernel/time/tick-sched.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 89517cfb6510..b1b591de781e 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -839,6 +839,10 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
>  		ts->next_timer = next_tick;
>  	}
>  
> +	/* Make sure next_tick is never before basemono! */
> +	if (WARN_ON_ONCE(basemono > next_tick))
> +		next_tick = basemono;
> +

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

And some food for thoughts:

1) Is it possible for hrtimer_get_next_event() to return values in the past?
2) Is hrtimer_get_next_event() unconditionally locking &cpu_base->lock even
   high resolution is active? Can we avoid that?

Thanks.



>  	/*
>  	 * If the tick is due in the next period, keep it ticking or
>  	 * force prod the timer.
> -- 
> 2.39.2
> 

