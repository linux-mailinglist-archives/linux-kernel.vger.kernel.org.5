Return-Path: <linux-kernel+bounces-139422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 834BB8A031D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D9728345C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D62018413F;
	Wed, 10 Apr 2024 22:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v4npgz+5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MVfPV07b"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C507184107;
	Wed, 10 Apr 2024 22:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712787335; cv=none; b=JrTLF4XjP5fp6E8teXZpeWm+mkSwzMzFnFYIYM6+AOrtCBlRpBZThRzI8XAOID+l+xKvkjISbvwCx4IRDXEHIXmXcD1zTwofbocjFERzojCcnaMBvcPYA5QqrDGG6b4E76fT85N+GBWYYhy6udLXzViLN7K5zXcF8NwIJ9IGQK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712787335; c=relaxed/simple;
	bh=A/lV+1Ac2zw9xElc0bPbLpO1AnYokiSgY0NCWvJTk3E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UirZ5H42tOrexrFjM7BL9YraCLeq8QmicnLBSHUhpwXluKr2H3VIEzqK11H/VOuq5lTGEeywbEsMte4fJ/FzCJLR+Vz5rExSomUUau1j/+4or4NrgS0DeYsf9D9MQt2n8objk1aJgAwNlWkTe2Fa4/92d7AVlYSp9B1zvVmPfis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v4npgz+5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MVfPV07b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712787331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yv1aoSAnbbHpJLpzRKC+j97D6+Bc6CY0CLsHS2K8ILg=;
	b=v4npgz+5aALgAbCa4gYmW+sAu1VbuMi5mmGWhrk2cAcWRxxH4pHy5nrXHNxv1At5IAeB/0
	iSKfMviSNGaDOtJ64MoFjVFPiPswQ4GMq/F/eukaTkHCHFNIV9ltqfTCJSY+Jeax8N38/D
	lociKYTR0SP6bWY88di3mNDqOJ2v4jw/yrpwKM4Ap/hBjWIUp4jfBzy5ADDWKciQVkHii4
	AsmmAgMXdEbP+H4MHxrGcJ19Q9Q6+iDOy8GJm/WCfGkm8BbiZayNHjlxiSc5P+L8ngWZou
	Vmd3GeXzCMuHXTxPB23DGxecr3ziWocyC/q7y2/Icbjqrn4ZjN0s49rvjEw8ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712787331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yv1aoSAnbbHpJLpzRKC+j97D6+Bc6CY0CLsHS2K8ILg=;
	b=MVfPV07bOUJ3KqluWXxG3YvId4KrFUETz3y7W9lQh/AJfTIl0ORZdyzcntjr/e71k8Q7nD
	CAkHiH4iXKD2ipBA==
To: lakshmi.sowjanya.d@intel.com, jstultz@google.com, giometti@enneenne.com,
 corbet@lwn.net, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, andriy.shevchenko@linux.intel.com,
 eddie.dong@intel.com, christopher.s.hall@intel.com,
 jesse.brandeburg@intel.com, davem@davemloft.net,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, perex@perex.cz, linux-sound@vger.kernel.org,
 anthony.l.nguyen@intel.com, peter.hilber@opensynergy.com,
 pandith.n@intel.com, subramanian.mohan@intel.com,
 thejesh.reddy.t.r@intel.com, lakshmi.sowjanya.d@intel.com
Subject: Re: [PATCH v6 08/11] timekeeping: Add function to convert realtime
 to base clock
In-Reply-To: <20240410114828.25581-9-lakshmi.sowjanya.d@intel.com>
References: <20240410114828.25581-1-lakshmi.sowjanya.d@intel.com>
 <20240410114828.25581-9-lakshmi.sowjanya.d@intel.com>
Date: Thu, 11 Apr 2024 00:15:31 +0200
Message-ID: <877ch43lvg.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Apr 10 2024 at 17:18, lakshmi.sowjanya.d@intel.com wrote:
> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
>
> PPS(Pulse Per Second) generates signals in realtime, but Timed IO

.. generates signals based on CLOCK_REALTIME, but ...

> hardware understands time in base clock reference.

The hardware does not understand anything.

> Add an interface,
> ktime_real_to_base_clock() to convert realtime to base clock.
>
> Add the helper function timekeeping_clocksource_has_base(), to check
> whether the current clocksource has the same base clock. This will be
> used by Timed IO device to check if the base clock is X86_ART(Always
> Running Timer).

Again this fails to explain the rationale and as this is a core change
which is hardware agnostic the whole Timed IO and ART reference is not
really helpful. Something like this:

  "PPS (Pulse Per Second) generates a hardware pulse every second based
   on CLOCK_REALTIME. This works fine when the pulse is generated in
   software from a hrtimer callback function.

   For hardware which generates the pulse by programming a timer it's
   required to convert CLOCK_REALTIME to the underlying hardware clock.

   The X86 Timed IO device is based on the Always Running Timer (ART),
   which is the base clock of the TSC, which is usually the system
   clocksource on X86.

   The core code already has functionality to convert base clock
   timestamps to system clocksource timestamps, but there is no support
   for converting the other way around.

   Provide the required functionality to support such devices in a
   generic way to avoid code duplication in drivers:

      1) ktime_real_to_base_clock() to convert a CLOCK_REALTIME
         timestamp to a base clock timestamp

      2) timekeeping_clocksource_has_base() to allow drivers to validate
         that the system clocksource is based on a particular
         clocksource ID.
  
> +static bool convert_cs_to_base(u64 *cycles, enum clocksource_ids base_id)
> +{
> +	struct clocksource *cs = tk_core.timekeeper.tkr_mono.clock;
> +	struct clocksource_base *base = cs->base;
> +
> +	/* Check whether base_id matches the base clock */
> +	if (!base || base->id != base_id)
> +		return false;
> +
> +	*cycles -= base->offset;
> +	if (!convert_clock(cycles, base->denominator, base->numerator))
> +		return false;
> +	return true;
> +}
> +
> +static u64 convert_ns_to_cs(u64 delta)
> +{
> +	struct tk_read_base *tkr = &tk_core.timekeeper.tkr_mono;
> +
> +	return div_u64((delta << tkr->shift) - tkr->xtime_nsec, tkr->mult);
> +}

> +bool ktime_real_to_base_clock(ktime_t treal, enum clocksource_ids base_id, u64 *cycles)

As this is a kernel API function it really wants kernel-doc comment to
explain the functionality, the arguments and the return value.

> +{
> +	struct timekeeper *tk = &tk_core.timekeeper;
> +	unsigned int seq;
> +	u64 delta;
> +
> +	do {
> +		seq = read_seqcount_begin(&tk_core.seq);
> +		if ((u64)treal < tk->tkr_mono.base_real)
> +			return false;
> +		delta = (u64)treal - tk->tkr_mono.base_real;

In the previous version you had a sanity check on delta:

>>> +		if (delta > tk->tkr_mono.clock->max_idle_ns)
>>> +			return false;

And I told you:

>> I don't think this cutoff is valid. There is no guarantee that this is
>> linear unless:
>>
>>       Treal[last timekeeper update] <= treal < Treal[next timekeeper update]
>>
>> Look at the dance in get_device_system_crosststamp() and
>> adjust_historical_crosststamp() to see why.

So now there is not even a check anymore whether the delta conversion
can overflow.

There is zero explanation why this conversion is considered to be
correct.

> +		*cycles = tk->tkr_mono.cycle_last + convert_ns_to_cs(delta);
> +		if (!convert_cs_to_base(cycles, base_id))
> +			return false;
> +	} while (read_seqcount_retry(&tk_core.seq, seq));
> +
> +	return true;
> +}

> +/**
> + * timekeeping_clocksource_has_base - Check whether the current clocksource
> + *     has a base clock

s/has a base clock/is based on a given base clock

> + * @id:		The clocksource ID to check for

base clocksource ID

> + *
> + * Note:	The return value is a snapshot which can become invalid right
> + *		after the function returns.
> + *
> + * Return:	true if the timekeeper clocksource has a base clock with @id,
> + *		false otherwise
> + */

Thanks,

        tglx

