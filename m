Return-Path: <linux-kernel+bounces-64469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84436853EE4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392691F296C7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E73D63087;
	Tue, 13 Feb 2024 22:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fv1rlUBI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TVYKnzRB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FFC62A18
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707863919; cv=none; b=Lb15o/E5DPGdx2s+KCkZh7uu+OIiE4TwjJDGPdA/0XHT8vx71Fxkm6+577iY0v1Ifdt4QULgtQ93TVBPgdoyhMZdUeD4TYEE8D+GGe7BNZomyxTOo5UAu0zs/b9HO421sffKwk5GG5H4dUe58FXIMXMMm4cLQo2AJjFKHRncs3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707863919; c=relaxed/simple;
	bh=0K9/zqIgY1PURO+8+UzHBu0T80ph2CAcR+BunYc/ITc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nga5zyBpRkA5+gzBi0jQzjiytD6s5zp8DUb3NnR1VrOQ8sX9A5I+arc6Az1YK/9jXKw0WocJJEb+7vIIglyeUuW0Kw/z6kf9NxQirUgI2NjbywTTND7htOAbELxC12Z6SDq3tM77OHLSnUOAF1H2uHT9YoMztn2YwNMo6vntDgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fv1rlUBI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TVYKnzRB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707863915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i3aMuHfIZMgVzjPLk2CQm7UHEuWSxafiRLRcg/aPL4Q=;
	b=fv1rlUBIfpMwDF/nMbttuPUqkzlQ55lanfgKdviObgKh/6gY+a7ZEqS+It9Qaw5W4VP/0R
	wwQSHPXfNY+SNxc6XrdDFN+VBv/go0Zx5Loy3LNQ7HZ9FfdRvm6GClXmEZp96cM0wSSmEo
	TC0P2Izq3azZCIG/8H0umoihGAWd86U/WJh9gOG0BueRu2BPgTWl6UsCwTwx+Rt/Er8EYq
	xJItZgpnXq3IhWeSWghjn5DoPKI0RAfu/2XxwHUQzVpoGAbUPzeFDcgoT2Fb/Fxt31XRQh
	9bBEL4DnGH/HNnG9DiTVYlL1PMPvrw7Q3pplpcZt02ayNlZ0CFrV/3mFqajAjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707863915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i3aMuHfIZMgVzjPLk2CQm7UHEuWSxafiRLRcg/aPL4Q=;
	b=TVYKnzRBbiOMGJiqBEXPWnG0bjyKH2BqEcQ6WgUxU7pIQk4l3pMWhCWtLip/HjDPER+RYB
	o/OxPNEH9gLZadCw==
To: Pranav Prasad <pranavpp@google.com>, jstultz@google.com, sboyd@kernel.org
Cc: linux-kernel@vger.kernel.org, krossmo@google.com
Subject: Re: [PATCH v2 2/2] alarmtimer: Modify alarmtimer suspend callback
 to check for imminent alarm using PM notifier
In-Reply-To: <20240213203028.1593499-1-pranavpp@google.com>
References: <87ttmch7k0.ffs@tglx>
 <20240213203028.1593499-1-pranavpp@google.com>
Date: Tue, 13 Feb 2024 23:38:35 +0100
Message-ID: <87zfw4f0r8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pranav!

On Tue, Feb 13 2024 at 20:30, Pranav Prasad wrote:
>> How is this supposed to work? rtc is NULL.
>
> alarmtimer_get_soonest() has the following:
> 	rtc = alarmtimer_get_rtcdev();
>         if (!rtc)
> 		return 0;
>
> rtc is set in alarmtimer_get_soonest(). If rtc is NULL, the notifier
> returns NOTIFY_DONE before even reaching pm_wakeup_event(), hence there is
> no NULL pointer dereference expected.

      struct rtc_device *rtc = NULL;

      if (!alarmtimer_get_soonest(rtc, ....)
      	  return 0 ;

      pm_wakeup_event(rtc->dev);

static bool alarmtimer_get_soonest(struct rtc_device *rtc, ....)
{
 	rtc = alarmtimer_get_rtcdev();
        if (!rtc)
 		return false;
        ...
        return true;
}

How is the assignment in alarmtimer_get_soonest() causing 'rtc' at the
callsite to become magically non NULL unless you have this shiny new AI
enhanced compiler with the long awaited 'do what I mean' optimization
enabled by default.

My old school brain based compiler is absolutely sure that both places
which I pointed out are straight forward unconditional NULL pointer
dereferences. See below.

>> How was this ever tested?
>
> I tested it by forcing kernel suspend writing 'mem' to /sys/power/state and
> using a large window (120s instead of the current 2s) so that a pending
> alarm is likely. The debug print is logged as expected without any kernel
> crash, and the suspend gets aborted.

I have no idea what you tested, but definitely not the complete
submitted code.

The only reason why this did not explode in your face in
pm_wakeup_event() is that this function has a NULL pointer check and
struct rtc_device has @dev as first member, which means that

       rtc == &rtc->dev

resulting in the NULL pointer check to be effective because &rtc->dev
evaluates to NULL.

But that does not make the code more correct. It's still am
unconditional NULL pointer dereference by definition, no?

Just flip the ordering of @dev in @owner in struct rtc_device and watch
the show.

alarmtimer_suspend() did not explode in your face because either the
notifier aborted suspend, which means the function was never reached, or
there was no timer armed. Why?

Because rtc_cancel_timer() has no NULL pointer check and unconditionally
dereferences @rtc.

Just for the record. I missed to spot this gem in your patch:

> +	/* Find the soonest timer to expire */
> +	if (!alarmtimer_get_soonest(rtc, &min, &expires, &type))
>  		return 0;
>  
> -	if (ktime_to_ns(min) < suspend_check_duration_ms * NSEC_PER_MSEC) {
> -		pm_wakeup_event(dev, suspend_check_duration_ms);
> -		return -EBUSY;
> -	}
> -

So you delete the threshold check. What makes sure that a timer which
got armed _after_ the notifier ran or one of the nanosleep timers which
are only accounted for after freezing are checked for expiring before
the threshold?

Nothing, right?

But sure, the patch did what you wanted to demonstrate and that's why it
is correct and perfect, right?

I conceed that your patch works perfectly correct under the following
condition:

    Either alarmtimer_pm_callback() aborts the suspend or
    alarmtimer_get_soonest() does not find an armed timer when called in
    alarmtimer_suspend()

Unfortunately that's not reflecting reality in production systems unless
I'm missing something important here.

Thanks,

        tglx

