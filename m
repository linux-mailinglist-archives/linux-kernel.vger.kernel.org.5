Return-Path: <linux-kernel+bounces-58271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D0984E3C5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900C42891ED
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5AA79941;
	Thu,  8 Feb 2024 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lR5Xv308";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lX2vlCRv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E5B78B75;
	Thu,  8 Feb 2024 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707405259; cv=none; b=gbV4+jyj0Eq7Tmj89Lop5tNfSP+eu6DPctevEHnOT17QLGUmfYqEHt13BH1tsmoS800Er3rrQx7+8wrD3anH0U0oWxM/pmcIOpJash46351zR9ozPVVNfSjrYEAIPQjTol66H+zpqxa2slN1op30cPhfM4Gwu3dwj5VIjN4K7Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707405259; c=relaxed/simple;
	bh=k67Ku4nB+j9z1OnPAabF+SA7vYNtpc6cZOpoi92P1D4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=Rlpb0GuBvDPbhx/pIjP6RUDh9JK8A6nj1TKvbJS9FNgaDYyTDba2PrVHPGXOaC0BbueReMls88RH4YuafjkLfLyhUB/+dHidr/LlcJldZPcQVmwJPXQIwB1vNHNSzQHYyjIz2KXyu3lXV+I2oVYyOFXuRgPgqJUHrfottKYWtok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lR5Xv308; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lX2vlCRv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707405255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=Y/mJ4V5ODp1OjO5K7WAULxON8je6JT7lSJcesdF0zwA=;
	b=lR5Xv308pjT/LKI8IM8xB/XSaI0Dnb5HSiiNZEcP1GG/X0J2TGhY5RsRXxvUquFtK5Kaba
	2qgKUqQBYDes23bT/Oti60rd/dLpmC1C6XEqg+UvsrvCqKxYP8nb1k+B33QKNOcpSSXcSH
	IQPxQ3pK41vKwjXsCNbCA3PAbnYM1W7QICBM1MV5LoQ2zE3IzztFmaabhkdZfFzLdOHs+5
	7M6dJ1Ndv1+8RVk6GLIpY425f7WzV+O406O+gK3Z05xJ8j5gQbnT1hfCZo8YXAzE9tRiep
	Wnooz6ezxZ+T2sO6f5ps2Yzx44+QTLTYOd45CVawJ6cJNBJV9wuWjjGU6jQ4yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707405255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=Y/mJ4V5ODp1OjO5K7WAULxON8je6JT7lSJcesdF0zwA=;
	b=lX2vlCRvmWLLnz1TXzYs9CGXtjOII9OYpB8OU/Wn0AEnymAqvTvw87UIVMVFJVX3rNXkG2
	DyClVZlotGwKEmBw==
To: lakshmi.sowjanya.d@intel.com, jstultz@google.com, giometti@enneenne.com,
 corbet@lwn.net, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, andriy.shevchenko@linux.intel.com,
 eddie.dong@intel.com, christopher.s.hall@intel.com,
 jesse.brandeburg@intel.com, davem@davemloft.net,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, perex@perex.cz, linux-sound@vger.kernel.org,
 anthony.l.nguyen@intel.com, peter.hilber@opensynergy.com,
 pandith.n@intel.com, mallikarjunappa.sangannavar@intel.com,
 subramanian.mohan@intel.com, thejesh.reddy.t.r@intel.com,
 lakshmi.sowjanya.d@intel.com
Subject: Re: [PATCH v4 02/11] timekeeping: Add function to convert realtime
 to base clock
In-Reply-To: <20240207060854.6524-3-lakshmi.sowjanya.d@intel.com>
Date: Thu, 08 Feb 2024 16:14:15 +0100
Message-ID: <8734u3m1iw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 07 2024 at 11:38, lakshmi sowjanya d. wrote:
> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
>
> Introduce an interface, ktime_real_to_base_clock() to convert realtime
> to base clock.
>
> Convert the base clock to the system clock using convert_base_to_cs() in
> get_device_system_crosststamp().
>
> Add the helper function timekeeping_clocksource_has_base(), to check
> whether the current clocksource has the same base clock.

Neither ktime_real_to_base_clock() nor
timekeeping_clocksource_has_base() are used anywhere.

What's the point of having them in the first place?

Your changelog explains the WHAT but not the WHY....

> +static bool convert_clock(u64 *val, u32 numerator, u32 denominator)
> +{
> +	u64 rem, res;
> +
> +	if (numerator == 0 || denominator == 0)
> +		return false;

What's wrong with the usual (!numerator || !denominator) notation?

> +
> +	res = div64_u64_rem(*val, denominator, &rem) * numerator;
> +	*val = res + div_u64(rem * numerator, denominator);
> +	return true;
> +}
> +
> +static bool convert_base_to_cs(struct system_counterval_t *scv)
> +{
> +	struct clocksource *cs = tk_core.timekeeper.tkr_mono.clock;
> +	struct clocksource_base *base = cs->base;
> +
> +	/* The timestamp was taken from the time keeper clock source */
> +	if (cs->id == scv->cs_id)
> +		return true;
> +
> +	/* Check whether cs_id matches the base clock */
> +	if (!base || base->id != scv->cs_id)
> +		return false;
> +
> +	/* Avoid conversion to a less precise clock */
> +	if (scv->nsecs && cs->freq_khz != 0 && base->freq_khz < cs->freq_khz) {
> +		if (!convert_clock(&scv->cycles, cs->freq_khz, USEC_PER_SEC))
> +			return false;
> +	} else {
> +		if (scv->nsecs) {
> +			if (!convert_clock(&scv->cycles, base->freq_khz, USEC_PER_SEC))
> +				return false;
> +		}
> +		if (!convert_clock(&scv->cycles, base->numerator, base->denominator))
> +			return false;
> +	}

The above logic makes my brain hurt.

It's a reaonable requirement that cs->freq must be != 0 when sc->base !=
NULL and then converting from nanoseconds can always use cs->freq no
matter what the value of the base frequency is. Even for the case where
the base frequency is larger than cs->freq because the double conversion
does not give you more precision, right?

> +	scv->cycles += base->offset;

So the whole thing can be reduced to:

   nom = scv->nsecs ? cs->freq_khz : base->numerator;
   den = scv->nsecs ? USEC_PER_SEC : base->denominator;

   convert(&scv->cycles, nom, den);
   scv->cycles += base->offset;

Thanks,

        tglx

