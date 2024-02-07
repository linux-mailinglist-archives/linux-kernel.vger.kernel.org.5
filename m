Return-Path: <linux-kernel+bounces-56382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A5F84C983
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A33E1C251F9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F471AADA;
	Wed,  7 Feb 2024 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NpMZnaX2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oW8AIcjm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A1417BC5;
	Wed,  7 Feb 2024 11:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707304849; cv=none; b=ezkv+AO+cZDoxcuJ/diaGG9ZX1F9Elian9y405UHsYKjOniAEtMAoRelfnP/tltQw6mo8YiyOHALeoEU1hZy8ER4+GbHxZKVlw1CWPxm2hO4+g6zyLjloxgqQeGSKdqlO+Pz+PHBX28qLxxd0ZZfsLN7HzhPUFdpa62yQzSi3c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707304849; c=relaxed/simple;
	bh=kNpB21ZQdIylBhThsbGbl7LJYyMCwRLN4v9jaIps8Cc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y/3yZtShExkuT4GpbhXs2fRIDkUt3hY00xs19xur9RoErfUmWOrZp9tJck8T1FhIg56tEEogO/6CYNAsrQOMY+i+OQGoJ2VDofkkCCiBCMPgD7k7lvKELmgawdUC7XTSDROZsLB3FigViKugFFRYd47nwrUUxcRTo7pPtOU1PEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NpMZnaX2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oW8AIcjm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707304845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nn2+OBhhtcsxepVa2QjmGAyVRZ+oibsRlzxUMCiG/hw=;
	b=NpMZnaX2Ehbai+rNXvToJEEVjWWwc83YFiDwnL6F3yFYNP5a9OL3v5TEVXPXGCqFhCd2Ez
	Y1e55jsHQp8pCUNmm8zD8YJrKtXN3D0G1AS9o1C7awdmahiUtNL6y0LLcESom0QcIzIBfG
	L+OlvxWDc8lETXW0ZjHCLPIdtl9uDcvJy2FPJpK3R7B0CXTbs6DF8aoMSMy6Wxt6DGt+VA
	zT8SAqvfnai4V/9UVyfyAV+EJNXLjpOp5Ln3n9gIdGnYNEuEKJKPTGc/dfpWgTwWyHCqna
	Xv8SSUlc+VmqridlItgRO5qb/ZVDBNWGBhE3SAtIS51Yf6hvwY/qzueUbb8Eyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707304845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nn2+OBhhtcsxepVa2QjmGAyVRZ+oibsRlzxUMCiG/hw=;
	b=oW8AIcjmWgOQ6p+XFe4PJk/RX2BJTLEzXI3xN3EtA2Mk1mYHC0lSmWETZhDP6qS8h5eRCM
	x7WppLdWHTFVymBg==
To: Pranav Prasad <pranavpp@google.com>, rafael@kernel.org, pavel@ucw.cz,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 krossmo@google.com, jstultz@google.com
Cc: Pranav Prasad <pranavpp@google.com>
Subject: Re: [PATCH] alarmtimer, PM: suspend: Expose a function from
In-Reply-To: <20240131191317.2191421-1-pranavpp@google.com>
References: <20240131191317.2191421-1-pranavpp@google.com>
Date: Wed, 07 Feb 2024 12:20:43 +0100
Message-ID: <87plx8msfo.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 31 2024 at 19:13, Pranav Prasad wrote:
> Hi!
>
> I am proposing a patch in which I want to return the errno code ETIME
> instead of EBUSY in enter_state() in the kernel suspend flow. Currently,
> EBUSY is returned  when an imminent alarm is pending which is checked in
> alarmtimer_suspend() in alarmtimer.c. The proposed patch series moves the
> check to enter_state() in suspend.c to catch a potential suspend failure
> early in the suspend flow. I want to replace EBUSY with ETIME to make it
> more diagnosable in userspace, and may be more appropriate considering a
> timer is about to expire.
>
> I am reaching out to get an opinion from the
> suspend maintainers if this would act as any potential risk in the suspend
> flow which only has EBUSY, EAGAIN, and EINVAL as return error codes
> currently. This has been developed as part of a patch series, and only the
> patch of interest is below this message. Any feedback or insights would be
> greatly appreciated.
>
> Thank you,
> Pranav Prasad

Can you please use a cover letter instead of putting random stuff into
the changelong?

> The alarmtimer driver currently fails suspend attempts when there is an
> alarm pending within the next suspend_check_duration_ns nanoseconds, since
> the   system is expected to wake up soon anyway. The entire suspend process
> is initiated even though the system will immediately awaken. This process
> includes substantial work before the suspend fails and additional work
> afterwards to undo the failed suspend that was attempted. Therefore on
> battery-powered devices that initiate suspend attempts from userspace, it
> may be advantageous to be able to fail the suspend earlier in the suspend
> flow to avoid power consumption instead of unnecessarily doing extra work.
> As one data point, an analysis of a subset of Android devices showed that
> imminent alarms account for roughly 40% of all suspend failures on average
> leading to unnecessary power wastage.
>
> To facilitate this, expose
> function time_check_suspend_fail() from alarmtimer to be used by the power
> subsystem to perform the check earlier in the suspend flow. Perform the
> check in enter_state() and return early if an alarm is to be fired in the
> next suspend_check_duration_ns nanoseconds, failing suspend.
>
> Signed-off-by: Pranav Prasad <pranavpp@google.com>
> Signed-off-by: Kelly Rossmoyer <krossmo@google.com>

This Signed-off-by chain is bogus.

> +/**
> + * alarmtimer_init_soonest - Initializes parameters to find soonest alarm.
> + * @min: ptr to relative time to the soonest alarm to expire
> + * @expires: ptr to absolute time of the soonest alarm to expire
> + * @type: ptr to alarm type
> + *
> + */
> +static void alarmtimer_init_soonest(ktime_t *min, ktime_t *expires, int *type)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&freezer_delta_lock, flags);
> +	*min = freezer_delta;
> +	*expires = freezer_expires;
> +	*type = freezer_alarmtype;
> +	freezer_delta = 0;
> +	spin_unlock_irqrestore(&freezer_delta_lock, flags);
> +}
> +
> +/**
> + * alarmtimer_get_soonest - Finds the soonest alarm to expire among the alarm bases.
> + * @min: ptr to relative time to the soonest alarm to expire
> + * @expires: ptr to absolute time of the soonest alarm to expire
> + * @type: ptr to alarm type
> + *
> + */
> +static void alarmtimer_get_soonest(ktime_t *min, ktime_t *expires, int *type)
> +{
> +	int i;
> +	unsigned long flags;

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations

Aside of that 'flags' wants to be in the loop scope.

> +
> +	/* Find the soonest timer to expire */
> +	for (i = 0; i < ALARM_NUMTYPE; i++) {
> +		struct alarm_base *base = &alarm_bases[i];
> +		struct timerqueue_node *next;
> +		ktime_t delta;
> +
> +		spin_lock_irqsave(&base->lock, flags);
> +		next = timerqueue_getnext(&base->timerqueue);
> +		spin_unlock_irqrestore(&base->lock, flags);
> +		if (!next)
> +			continue;
> +		delta = ktime_sub(next->expires, base->get_ktime());
> +		if (!(*min) || (delta < *min)) {

The inner brackets are pointless

> +			*expires = next->expires;
> +			*min = delta;
> +			*type = i;
> +		}
> +	}
> +}
> +
> +/**
> + * time_check_suspend_fail - Check if suspend should be failed due to an
> + * alarm within the next suspend_check_duration nanoseconds.
> + *
> + * Returns error if suspend should be failed, else returns 0.
> + */
> +int time_check_suspend_fail(void)
> +{
> +	ktime_t min, expires;
> +	int type;

Why is this unconditional and not checking RTC dev?

> +	/* Initialize parameters to find soonest timer */
> +	alarmtimer_init_soonest(&min, &expires, &type);

How does that make sense? That function evaluates the freezer state, but
there is nothing frozen when this is invoked.

> +	/* Find the soonest timer to expire */
> +	alarmtimer_get_soonest(&min, &expires, &type);
> +
> +	if (min == 0)
> +		return 0;
> +
> +	if (ktime_to_ns(min) < suspend_check_duration_ns)
> +		return -EBUSY;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(time_check_suspend_fail);

What is this export for?

> +
>  /**
>   * alarmtimer_get_rtcdev - Return selected rtcdevice
>   *
> @@ -296,49 +374,24 @@ EXPORT_SYMBOL_GPL(alarm_expires_remaining);
>  static int alarmtimer_suspend(struct device *dev)
>  {
..
> +	/* Initialize parameters to find soonest timer */
> +	alarmtimer_init_soonest(&min, &expires, &type);

This wants to be _after_ the RTC dev check, no?

>  	rtc = alarmtimer_get_rtcdev();
>  	/* If we have no rtcdev, just return */
>  	if (!rtc)
>  		return 0;
>  
> +	/* Find the soonest timer to expire */
> +	alarmtimer_get_soonest(&min, &expires, &type);
>  
> -	if (ktime_to_ns(min) < suspend_check_duration_ns) {
> -		pm_wakeup_event(dev, suspend_check_duration_ns/NSEC_PER_MSEC);

What injects the pm_wakeup_event after this change?

Thanks,

        tglx

