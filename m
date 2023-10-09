Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F547BECB1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378368AbjJIVRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbjJIVQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:16:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600282101
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 14:15:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D37C433C8;
        Mon,  9 Oct 2023 21:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696886131;
        bh=TS+C80SAzE+hVZogvc00I7js8dsT05l02Pw/Z87rgEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dXxlujNjsZzdXVp/sM9i4XQLmCJcOgkfUZeecHLXv3OxI+YWqym200Ob54C1ACJKI
         8ssnQ0l+Xr7Wop/aj3iD8irF5mfv+XKxc+tWEnpJlLjgucNJqcq+wwVPycRbYD4dKY
         OeaIEb4Wh39iCxLHDdZBAHqfyy0TfTXjyIFiXuMW8DbLNOtU/KVA/56FOAS4ZOrcqy
         J7RHUeBHNSeDnUJWeDOsc0fJ65rmuendvX1Al3DyXOnzvEE+oPTT7s/3HuSP/JRkQg
         YzQI2l+2cTcbQv32XEN0DYvhj9/WN2PLsKE6hNT4p6mYefUsC1TcA79I+F9aZQznqk
         lr0WnjfKbyQrA==
Date:   Mon, 9 Oct 2023 23:15:27 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH v8 09/25] timer: Split out get next timer functionality
Message-ID: <ZSRtb9Kh-m0laSwL@localhost.localdomain>
References: <20231004123454.15691-1-anna-maria@linutronix.de>
 <20231004123454.15691-10-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231004123454.15691-10-anna-maria@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Oct 04, 2023 at 02:34:38PM +0200, Anna-Maria Behnsen a écrit :
> Split out get next timer functionality to make it reusable in other
> places. Thereby the order of getting the next expiry, forwarding the base
> clock and mark timer bases as idle, is changed. This change of order
> shouldn't have any impact, as nothing inside the function relies on the
> idle value or the updated timer base clock.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  kernel/time/timer.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 18f8aac9b19a..f443aa807fbc 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1911,6 +1911,24 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
>  	return DIV_ROUND_UP_ULL(nextevt, TICK_NSEC) * TICK_NSEC;
>  }
>  
> +static inline unsigned long __get_next_timer_interrupt(unsigned long basej,
> +						       struct timer_base *base)
> +{
> +	unsigned long nextevt;
> +
> +	if (base->next_expiry_recalc)
> +		next_expiry_recalc(base);
> +	nextevt = base->next_expiry;
> +
> +	if (base->timers_pending) {
> +		/* If we missed a tick already, force 0 delta */
> +		if (time_before(nextevt, basej))
> +			nextevt = basej;
> +	}
> +
> +	return nextevt;
> +}
> +
>  /**
>   * get_next_timer_interrupt - return the time (clock mono) of the next timer
>   * @basej:	base time jiffies
> @@ -1933,9 +1951,7 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
>  		return expires;
>  
>  	raw_spin_lock(&base->lock);
> -	if (base->next_expiry_recalc)
> -		next_expiry_recalc(base);
> -	nextevt = base->next_expiry;
> +	nextevt = __get_next_timer_interrupt(basej, base);
>  
>  	/*
>  	 * We have a fresh next event. Check whether we can forward the
> @@ -1952,14 +1968,10 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
>  	 */
>  	base->is_idle = time_after(nextevt, basej + 1);
>  
> -	if (base->timers_pending) {
> -		/* If we missed a tick already, force 0 delta */
> -		if (time_before(nextevt, basej))
> -			nextevt = basej;
> -		expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
> -	}
>  	raw_spin_unlock(&base->lock);
>  
> +	expires = basem + (u64)(nextevt - basej) * TICK_NSEC;

Does that compute KTIME_MAX when there is no timers pending?

Thanks.

> +
>  	return cmp_next_hrtimer_event(basem, expires);
>  }
>  
> -- 
> 2.39.2
> 
