Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60D5806BDA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377321AbjLFKXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377339AbjLFKXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:23:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC28012F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:23:38 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701858217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GsNdpIFc09s1gqwIZ71ov1AFzBRmEFB6zZkx3fRFd5g=;
        b=iglMCXYyWWOMX7ot3k5OXm8pLuBqWxuDAP2bHQUssr5GOCjJq8hVEADDYLcqHtp4Ep5wfm
        xe1r8/kqj0JZLEttatjOUyZzkMPt+MMZ/qgy18cSVxvFaycfumYY/nNn0+BqKQSBqr0fz1
        +e7IXR5KdNmVMYFSjvI4Q4k0bAVkzjUwOdoDriacIToGLT7pu5cHrg+I0zFpG6KvxHCdSM
        9Jd2aOsz1U4YmnlJSzIy6oQZ6KNsWAYmg0rT0Il4k5WpP0yElDKxnuWNNJQJMBK5YFAKG1
        yeTKPTcFxyanC0FgHsQZI4SuLhj7lfnTsXf98YM+bsaTrFkGezWeSJ+mt+rSXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701858217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GsNdpIFc09s1gqwIZ71ov1AFzBRmEFB6zZkx3fRFd5g=;
        b=+dJEwX6YqeEwRrSRllj+nGgCh/Z4usBpBzPJUCNUqgV9ao2PWcoaKgLJuW9K661xfUH2qu
        JIR1wSI6bAPhsDCA==
To:     Sebastian Siewior <bigeasy@linutronix.de>
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
In-Reply-To: <20231205211106.ykKsi921@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-23-anna-maria@linutronix.de>
 <20231205211106.ykKsi921@linutronix.de>
Date:   Wed, 06 Dec 2023 11:23:36 +0100
Message-ID: <87fs0feijb.fsf@somnus>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Siewior <bigeasy@linutronix.de> writes:

> On 2023-12-01 10:26:44 [+0100], Anna-Maria Behnsen wrote:
>> --- a/kernel/time/timer.c
>> +++ b/kernel/time/timer.c
>> @@ -1985,10 +1998,31 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
>>  		return expires;
>>  	}
>>  
>> -	raw_spin_lock(&base->lock);
>> -	nextevt = next_timer_interrupt(base, basej);
>> +	base_local = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
>> +	base_global = this_cpu_ptr(&timer_bases[BASE_GLOBAL]);
>> +
>> +	raw_spin_lock(&base_local->lock);
>> +	raw_spin_lock_nested(&base_global->lock, SINGLE_DEPTH_NESTING);
>> +
>> +	nextevt_local = next_timer_interrupt(base_local, basej);
>> +	nextevt_global = next_timer_interrupt(base_global, basej);
>>  
>> -	if (base->timers_pending) {
>> +	/*
>> +	 * Check whether the local event is expiring before or at the same
>> +	 * time as the global event.
>> +	 *
>> +	 * Note, that nextevt_global and nextevt_local might be based on
>> +	 * different base->clk values. So it's not guaranteed that
>> +	 * comparing with empty bases results in a correct local_first.
>
> This ends like an unsolved mystery case. Could you add why one should
> not worry about an incorrect local_first?
>
> But seriously, how far apart can they get and what difference does it
> make?  At timer enqueue time clk equals jiffies. At this point one clk
> base could be at jiffies and the other might be a few jiffies before
> that.
> The next event (as in next_expiry) should be valid for both compare
> wise. Both must be larger than jiffies. The delta between jiffies and
> next event has to be less than NEXT_TIMER_MAX_DELTA for each base.
>
>> +	 */
>> +	if (base_local->timers_pending && base_global->timers_pending)
>> +		local_first = time_before_eq(nextevt_local, nextevt_global);
>> +	else
>> +		local_first = base_local->timers_pending;
>> +
>> +	nextevt = local_first ? nextevt_local : nextevt_global;
>> +
>> +	if (base_local->timers_pending || base_global->timers_pending) {
>>  		/* If we missed a tick already, force 0 delta */
>>  		if (time_before(nextevt, basej))
>>  			nextevt = basej;
>
> So if nextevt_local missed a tick and nextevt_global is
> NEXT_TIMER_MAX_DELTA-1 (so we get the largest difference possible
> between those two) then the time_before_eq() should still come out
> right. We could still miss more than one tick.
>

This problem was only there when comparing _empty_ bases
(!timer_base::timers_pending) because of the different base clocks and
the stale next_expiry.

But I didn't update the check and the comment after introducing the
forward of the next_expiry when !timer_base::timers_pending in
next_timer_interrupt(). So now it is sufficient to replace the
local_first detection by simply doing:

	local_first = time_before_eq(nextevt_local, nextevt_global);

Will fix it and will also add a comment to next_timer_interrupt() where
the next_expiry is updated when !timer_base::timers_pending.

Thanks,

	Anna-Maria
