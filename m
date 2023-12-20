Return-Path: <linux-kernel+bounces-7021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1424481A095
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6CDA28AE27
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CAD38FB0;
	Wed, 20 Dec 2023 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjxiOTEj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4175838F8E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 14:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D73AC433CC;
	Wed, 20 Dec 2023 14:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703080855;
	bh=TsDCwkBaMdKoCv+Np9f6t9jCgxH5nUH7ukB2HEWM/aE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FjxiOTEj9CZ8MeLmeRu78ioBBydcvtHYgk3K5f5vg8xElj+nYY2PD8Xd0D9WO8pav
	 EwK7ksy7wgEvELKaH/CHbQHXgHv+zAW9UACPzC67UVNoxty7HsE2V8zMB4yGKvYTXX
	 D6zRYappk6Kk0t3jG+ZaYURa3ItCf2Sg0ENfVMj5FSkATr5ep1fStLqnPl2bYPvxo6
	 vc7GXNAhSI0dkxLUVy1bjrKp9swdZ9ei6frpg0UVx9d5RmDGtOATP/AO5QTLTLRoxZ
	 5Sx8t7EhhSj5RIKiPt3FUQV66Pwi90sJK3B/KguPYasdcihPrjNIneUODaz4OUql41
	 wThyO4evLUIVw==
Date: Wed, 20 Dec 2023 15:00:52 +0100
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
Subject: Re: [PATCH v9 11/32] timers: Rework idle logic
Message-ID: <ZYLzlBPpS5zT7OHq@localhost.localdomain>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-12-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231201092654.34614-12-anna-maria@linutronix.de>

Le Fri, Dec 01, 2023 at 10:26:33AM +0100, Anna-Maria Behnsen a écrit :
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> To improve readability of the code, split base->idle calculation and
> expires calculation into separate parts. While at it, update the comment
> about timer base idle marking.
> 
> Thereby the following subtle change happens if the next event is just one
> jiffy ahead and the tick was already stopped: Originally base->is_idle
> remains true in this situation. Now base->is_idle turns to false. This may
> spare an IPI if a timer is enqueued remotely to an idle CPU that is going
> to tick on the next jiffy.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> ---
> v9: Re-ordering to not hurt the eyes and update comment
> v4: Change condition to force 0 delta and update commit message (Frederic)
> ---
>  kernel/time/timer.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index fee42dda8237..0826018d9873 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1943,22 +1943,23 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
>  	 */
>  	__forward_timer_base(base, basej);
>  
> -	if (time_before_eq(nextevt, basej)) {
> -		expires = basem;
> -		base->is_idle = false;
> -	} else {
> -		if (base->timers_pending)
> -			expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
> -		/*
> -		 * If we expect to sleep more than a tick, mark the base idle.
> -		 * Also the tick is stopped so any added timer must forward
> -		 * the base clk itself to keep granularity small. This idle
> -		 * logic is only maintained for the BASE_STD base, deferrable
> -		 * timers may still see large granularity skew (by design).
> -		 */
> -		if ((expires - basem) > TICK_NSEC)
> -			base->is_idle = true;
> +	if (base->timers_pending) {
> +		/* If we missed a tick already, force 0 delta */
> +		if (time_before(nextevt, basej))
> +			nextevt = basej;
> +		expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
>  	}
> +
> +	/*
> +	 * Base is idle if the next event is more than a tick away.
> +	 *
> +	 * If the base is marked idle then any timer add operation must forward
> +	 * the base clk itself to keep granularity small. This idle logic is
> +	 * only maintained for the BASE_STD base, deferrable timers may still
> +	 * see large granularity skew (by design).
> +	 */
> +	base->is_idle = time_after(nextevt, basej + 1);
> +

Much better, thanks! :-)

