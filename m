Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A6E80603E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 22:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346421AbjLEVLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 16:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLEVLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 16:11:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E2B18B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 13:11:10 -0800 (PST)
Date:   Tue, 5 Dec 2023 22:11:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701810668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lRnyi7RUD3uat7xocE2sCs3Fi4FAPkAA/cTsvLupByc=;
        b=lrueSzkx6AaDlJdqyVKMhPq5+JiUPsN37iQM14iYQZqKZSCKh/3IC0uEfhwkstVITpy2Nm
        zvlwLELgxdz7Fe9o4lYoulgmYQ2JTTGr25HAVJ+jH//FawuRjd3SIp+Uo2kthFu2W89Rba
        EYdQ9bIT93EdIG9mW99KE99bykosVSY7mDgsoMQwFhjccJ8ZHM1OF11vNmz2Saa94ywFJl
        oSatNy1yijPmbnNv33iz/xkSy+lw5wa/3OpqXcM5+5g1/2qqsmuimQaSlIHlCBtIDgSlQL
        aGBmXdgM9n7oC/0rkgh7WJbjNqoH/HWdC9npHR++PpsPLwsHKaaNkhz1S5Qylw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701810668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lRnyi7RUD3uat7xocE2sCs3Fi4FAPkAA/cTsvLupByc=;
        b=3Wfu6fJf8M4C7yvH9N1d/YOEjMEVXDhiRM4HNXxza2/eeUzwJSc1etAIXybj5Sx2tK80YQ
        6x38yeUWy6IdF1Dg==
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
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v9 22/32] timers: Keep the pinned timers separate from
 the others
Message-ID: <20231205211106.ykKsi921@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-23-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231201092654.34614-23-anna-maria@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-01 10:26:44 [+0100], Anna-Maria Behnsen wrote:
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1985,10 +1998,31 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
>  		return expires;
>  	}
>  
> -	raw_spin_lock(&base->lock);
> -	nextevt = next_timer_interrupt(base, basej);
> +	base_local = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
> +	base_global = this_cpu_ptr(&timer_bases[BASE_GLOBAL]);
> +
> +	raw_spin_lock(&base_local->lock);
> +	raw_spin_lock_nested(&base_global->lock, SINGLE_DEPTH_NESTING);
> +
> +	nextevt_local = next_timer_interrupt(base_local, basej);
> +	nextevt_global = next_timer_interrupt(base_global, basej);
>  
> -	if (base->timers_pending) {
> +	/*
> +	 * Check whether the local event is expiring before or at the same
> +	 * time as the global event.
> +	 *
> +	 * Note, that nextevt_global and nextevt_local might be based on
> +	 * different base->clk values. So it's not guaranteed that
> +	 * comparing with empty bases results in a correct local_first.

This ends like an unsolved mystery case. Could you add why one should
not worry about an incorrect local_first?

But seriously, how far apart can they get and what difference does it
make?  At timer enqueue time clk equals jiffies. At this point one clk
base could be at jiffies and the other might be a few jiffies before
that.
The next event (as in next_expiry) should be valid for both compare
wise. Both must be larger than jiffies. The delta between jiffies and
next event has to be less than NEXT_TIMER_MAX_DELTA for each base.

> +	 */
> +	if (base_local->timers_pending && base_global->timers_pending)
> +		local_first = time_before_eq(nextevt_local, nextevt_global);
> +	else
> +		local_first = base_local->timers_pending;
> +
> +	nextevt = local_first ? nextevt_local : nextevt_global;
> +
> +	if (base_local->timers_pending || base_global->timers_pending) {
>  		/* If we missed a tick already, force 0 delta */
>  		if (time_before(nextevt, basej))
>  			nextevt = basej;

So if nextevt_local missed a tick and nextevt_global is
NEXT_TIMER_MAX_DELTA-1 (so we get the largest difference possible
between those two) then the time_before_eq() should still come out
right. We could still miss more than one tick.

This looks good. I just don't understand the (above) comment.

Sebastian
