Return-Path: <linux-kernel+bounces-63503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175AF85307E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C294E282D97
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFD23E47E;
	Tue, 13 Feb 2024 12:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a6Z4Je4j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RrmHqUik"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9A13C490
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707827331; cv=none; b=FcgReTEGv4p2c9qyJXP4wMdjrqLkK9RODV4wvm7a3aUaFW7QLDmeFMQjresC+i5ggxIAaB+vEthKfQIUs7ynneySp6CXBjvvwWX+Tkwj2UUyWSlwps7X0ycjgLtnrbh589OGJSvANXplSPaLU88DfnpmY8cwanZbo2QF0IWunPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707827331; c=relaxed/simple;
	bh=ow+STwHlYd1Vhoc8KwxMYBfmdJbnDPRhC7E99p7z0+E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LGdcedTse0qJU1nulrg7TJYNha1fRqQrHZriE4taEQFrbd1jmTY0kMZSu4E4FaNftKDVRnDAo6fbr+Z/DXZMxQ7Nxi9HClnsZs4EV0lCzX0P4loufJi7+sMB0hJVN/7w2F1hJOwcHd46SIql6sIYAu8ThHvznNbtKN/uJlShWQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a6Z4Je4j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RrmHqUik; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707827327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2WgwH2lZ8nJQB7Q4kUzzsdIxjlcY4tX3R4pVNm+7l3A=;
	b=a6Z4Je4jQwKyoQEvbYovBWoEvuzHAz18rjbTOw8hn76btbazNElU5PveBoa8OTXDGepvxl
	kedxZyj0p70JcRbPRuY8RfATKtU8nbJQq0SnABXXu+c4wbh04qFy3y1pSEBakCInFv22nf
	YSq72vGQh+v9OfLFvtWj9k7V7EBzBWSQshLdv5+dKB6J/8Suir2v1yijTl9MDKbu2a00m/
	z0OQSsjQmeggP10HZjzCBsbjVkA9bcaBrOsHyff4afuh5ma/RINGxYT/v6ZpLKtZ/OYCFJ
	U15y9Vtwa8FsRo+oku9ZRtO6JuN+fhW9vk9aVFpvU2E7d3OSEEGQLojMbPUllQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707827327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2WgwH2lZ8nJQB7Q4kUzzsdIxjlcY4tX3R4pVNm+7l3A=;
	b=RrmHqUik5nLOywTBAPOIJvYUfwCcNX9hbUchhGE0LrzAjtvy8H4laHO/R2xGpmwcGFtRo9
	ohVF6O1Mg/Dr1TDQ==
To: Pranav Prasad <pranavpp@google.com>, jstultz@google.com, sboyd@kernel.org
Cc: linux-kernel@vger.kernel.org, krossmo@google.com, Pranav Prasad
 <pranavpp@google.com>
Subject: Re: [PATCH v2 2/2] alarmtimer: Modify alarmtimer suspend callback
 to check for imminent alarm using PM notifier
In-Reply-To: <20240208195622.758765-3-pranavpp@google.com>
References: <20240208195622.758765-1-pranavpp@google.com>
 <20240208195622.758765-3-pranavpp@google.com>
Date: Tue, 13 Feb 2024 13:28:47 +0100
Message-ID: <87ttmch7k0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Feb 08 2024 at 19:56, Pranav Prasad wrote:

The subject line wants some trimming. It's supposed to be a concise
short summary and not a novel.

Aside of that it's blantantly wrong. It does not modify the suspend
callback to check with a PM notifier. It adds a PM notifier to check
early before the suspend callback runs.

> +/**
> + * alarmtimer_get_soonest - Finds the soonest alarm to expire among the
> + * alarm bases.
> + * @rtc: ptr to rtc_device struct
> + * @min: ptr to relative time to the soonest alarm to expire
> + * @expires: ptr to absolute time of the soonest alarm to expire
> + * @type: ptr to alarm type
> + *
> + * Returns 1 if soonest alarm was found, returns 0 if don't care.
> + */
> +static int alarmtimer_get_soonest(struct rtc_device *rtc, ktime_t *min,
> +					ktime_t *expires, int *type)

Please align the second argument with the first argument of the
function.

Also the return value wants to be bool.

> +{
> +	int i;
> +	unsigned long flags;

Please see:

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations

> +	spin_lock_irqsave(&freezer_delta_lock, flags);
> +	*min = freezer_delta;
> +	*expires = freezer_expires;
> +	*type = freezer_alarmtype;
> +	freezer_delta = 0;
> +	spin_unlock_irqrestore(&freezer_delta_lock, flags);

This only makes sense for the actual suspend operation because freezing
of processes happens after the notifier callback runs.

> +	rtc = alarmtimer_get_rtcdev();
> +	/* If we have no rtcdev, just return */
> +	if (!rtc)
> +		return 0;
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
> +		if (!*min || delta < *min) {

You can spare the !*min if you initialize min to KTIME_MAX.

> +			*expires = next->expires;
> +			*min = delta;
> +			*type = i;
> +		}
> +	}
> +
> +	if (*min == 0)

!*min above and *min == 0 here. Can we have consistency please?

> +		return 0;
> +
> +	return 1;
> +}
> +
> +static int alarmtimer_pm_callback(struct notifier_block *nb,
> +			    unsigned long mode, void *_unused)
> +{
> +	ktime_t min, expires;
> +	struct rtc_device *rtc = NULL;
> +	int type;

Same as above vs. ordering.

> +	switch (mode) {
> +	case PM_SUSPEND_PREPARE:
> +		/* Find the soonest timer to expire */
> +		if (!alarmtimer_get_soonest(rtc, &min, &expires, &type))
> +			return NOTIFY_DONE;
> +
> +		if (ktime_to_ns(min) <
> +			suspend_check_duration_ms * NSEC_PER_MSEC) {

No need for the line break. 80 character limit is gone.

> +			pr_warn("[%s] Suspend abort due to imminent alarm\n", __func__);

Why is this a warning? If at all it wants to be pr_debug() and the
__func_ is pretty useless as grep is able to find the string, no?

> +			pm_wakeup_event(&rtc->dev, suspend_check_duration_ms);

How is this supposed to work? rtc is NULL.

> +			return notifier_from_errno(-ETIME);
> +		}
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block alarmtimer_pm_notifier = {
> +	.notifier_call = alarmtimer_pm_callback,
> +};
> +
>  /**
>   * alarmtimer_get_rtcdev - Return selected rtcdevice
>   *
> @@ -181,6 +263,7 @@ static int alarmtimer_rtc_add_device(struct device *dev)
>  static inline void alarmtimer_rtc_timer_init(void)
>  {
>  	rtc_timer_init(&rtctimer, NULL, NULL);
> +	register_pm_notifier(&alarmtimer_pm_notifier);
>  }
>  
>  static struct class_interface alarmtimer_rtc_interface = {
> @@ -296,49 +379,14 @@ EXPORT_SYMBOL_GPL(alarm_expires_remaining);
>  static int alarmtimer_suspend(struct device *dev)
>  {
>  	ktime_t min, now, expires;
> -	int i, ret, type;
> -	struct rtc_device *rtc;
> -	unsigned long flags;
> +	struct rtc_device *rtc = NULL;
>  	struct rtc_time tm;
> +	int ret, type;

See above.

SNIP

>  	/* Setup an rtc timer to fire that far in the future */

And another NULL pointer dereference follows suit.

How was this ever tested?

You need:

	rtc = alarmtimer_get_rtcdev();
	if (!rtc)
		return [0|NOTIFY_DONE];

in both functions and then hand in rtc to alarmtimer_get_soonest(), no?

Thanks,

        tglx

