Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8463A803979
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343972AbjLDQDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbjLDQDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:03:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1008EA4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:03:54 -0800 (PST)
Date:   Mon, 4 Dec 2023 17:03:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701705832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oOGKvQa+fD1H+3fJFY5r6c8uqdzNpto7YjAjUn5AcY0=;
        b=dpoiyQpkZqd+2evWeKtSi1P8xf0rf9vXzPmGHc6oWblsnmNoTMz9RQR434dvHSTf0Lg4mI
        2q4I0UgltZ9u3gUlmNoUCHYha4EtxHONuqS99YbVIX1Ore/77+UhP8Bp+wbaJC0Kvfd+iP
        wXZAab0aukZBo7RVG3hD2XZdOqvz3pfjIJh8nco4CEhjwOL+QdNleCZA8GJH1B6EHZ+yvQ
        Mf5jShs46Vt06LLgmEqti+/Iuy0RPTsC/BXcj+wL9HQLfqRh9aXAMIFIBxhsd+AqpnunX7
        QLlMHDgtB57WL004UxHaLTqWIN7jn0qQGVqYDmuftkCqYpIb1Hh1YiaY2ftC8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701705832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oOGKvQa+fD1H+3fJFY5r6c8uqdzNpto7YjAjUn5AcY0=;
        b=b9GXWlF6yHaVfbz5YlE9faTuI1oRyyQGPVLDbIe7882o09LJh/Z3Q/uHEGi40++uhPo/zq
        NFaP6QvjXe4XQ4Dg==
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v9 12/32] timers: Fix nextevt calculation when no timers
 are pending
Message-ID: <20231204160350.OTCnqCJf@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-13-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231201092654.34614-13-anna-maria@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-01 10:26:34 [+0100], Anna-Maria Behnsen wrote:
> When no timer is queued into an empty timer base, the next_expiry will not
> be updated. It was originally calculated as
> 
>   base->clk + NEXT_TIMER_MAX_DELTA
> 
> When the timer base stays empty long enough (> NEXT_TIMER_MAX_DELTA), the
> next_expiry value of the empty base suggests that there is a timer pending
> soon. This might be more a kind of a theoretical problem, but the fix
> doesn't hurt.

So __run_timers() sets base::next_expiry to base->clk +
NEXT_TIMER_MAX_DELTA and then we have no more timers enqueued.

But wouldn't base->timers_pending remain false? Therefore it would use
"expires = KTIME_MAX" as return value (well cmp_next_hrtimer_event())?

Based on the code as of #11, it would only set timer_base::is_idle
wrongly false if it wraps around. Other than that, I don't see an issue.
What do I miss?

If you update it regardless here then it would make a difference to
run_local_timers() assuming we have still hrtimer which expire and this
next_expiry check might raise a softirq since it does not consider the
timers_pending value.

> Use only base->next_expiry value as nextevt when timers are
> pending. Otherwise nextevt will be jiffies + NEXT_TIMER_MAX_DELTA. As all
> information is in place, update base->next_expiry value of the empty timer
> base as well.

or consider timers_pending in run_local_timers()? An additional read vs
write?

> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1944,10 +1943,20 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
>  	__forward_timer_base(base, basej);
>  
>  	if (base->timers_pending) {
> +		nextevt = base->next_expiry;
> +
>  		/* If we missed a tick already, force 0 delta */
>  		if (time_before(nextevt, basej))
>  			nextevt = basej;
>  		expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
> +	} else {
> +		/*
> +		 * Move next_expiry for the empty base into the future to
> +		 * prevent a unnecessary raise of the timer softirq when the
                           an
> +		 * next_expiry value will be reached even if there is no timer
> +		 * pending.
> +		 */
> +		base->next_expiry = nextevt;
>  	}
>  
>  	/*

Sebastian
