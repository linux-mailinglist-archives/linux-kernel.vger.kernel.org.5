Return-Path: <linux-kernel+bounces-139374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F7C8A022B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46C491F25214
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E76184139;
	Wed, 10 Apr 2024 21:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cjZIlLaL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nV7PBw92"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E891836F3;
	Wed, 10 Apr 2024 21:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712784771; cv=none; b=hEO78MJBwrh3jPn7aoKtiO0i8jxRdva++BftTt6UmFT5KkKrx6eAKlJWZliSMRqIeGNnELuYrgIM3nCulHAA+MW4pr2GeEXv0yILSxR8hM+Q7HUUSyXG1ClvRM6OEK9/6xRb8i9t8kyinMYp/mkK2tdxNhS6DJWdDLMGFoiAdnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712784771; c=relaxed/simple;
	bh=uPaan8WWeNrf7KcvhIYFP+9mQ3Jap9iTRzy0ugpH7BU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dSWxhtMY4YIchHAPzwAfvkDt4R8w4qI8CLTgfxY46v3HCCCwlX6HVgcpV4yMDoXwkLHUCOlRRtl8QcZavVk4G7/Uinea7QPPn/swZ1dRaR/YFwXUzql0oAEo1UiwXm3ZYbMOBqgCyXbkIGs7xy96v68y/XUpDm34Djr8X/D/LrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cjZIlLaL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nV7PBw92; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712784767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nh8OJkypTZN2dIacuWiBicR/c4idFBZIzTy0pVZ35ws=;
	b=cjZIlLaL/PET73d27bxQlie5EjJ9KCuctB85P00To/7BKeKXkrRLZKwPkflv6XDInOeerx
	SYrs+aLDhP34tezZuQ77WhJ/aBHrY9wjSRib7PnKXWawOBOLOaifubvCZOMmkA/WsWNrkH
	tQPDQyPuOa+hNZjY8Bbl7N/vHusGJTFQYvRu6+DYQn1cNkZCNgSGbrJ+q6rNhhmb5lp3N+
	3poKBGia6ReXtFAEA4uM2gTKqOROS+34+hyarZ5Njq9FjIiOQS3Gn6sCpsKF54Cv9Bxyp7
	AyjUU/mnMozhgiNZV2MyTLzsjgOSXYlGwp+V4Y+1Zr/QadVb0yY+cso9P/ouwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712784767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nh8OJkypTZN2dIacuWiBicR/c4idFBZIzTy0pVZ35ws=;
	b=nV7PBw924lPvBzqrI/DpQb1r5WYRKGXbBipF/QylDBVVWVk2N5W4vkOtRlhcxuBm8quLJH
	XhR5wRV5qwpOLsDg==
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
Subject: Re: [PATCH v6 01/11] x86/tsc: Add base clock properties in
 clocksource structure
In-Reply-To: <20240410114828.25581-2-lakshmi.sowjanya.d@intel.com>
References: <20240410114828.25581-1-lakshmi.sowjanya.d@intel.com>
 <20240410114828.25581-2-lakshmi.sowjanya.d@intel.com>
Date: Wed, 10 Apr 2024 23:32:46 +0200
Message-ID: <87cyqw3nup.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Apr 10 2024 at 17:18, lakshmi.sowjanya.d@intel.com wrote:
> @@ -48,6 +49,7 @@ struct module;
>   * @archdata:		Optional arch-specific data
>   * @max_cycles:		Maximum safe cycle value which won't overflow on
>   *			multiplication
> + * @freq_khz:		Clocksource frequency in khz.
>   * @name:		Pointer to clocksource name
>   * @list:		List head for registration (internal)
>   * @rating:		Rating value for selection (higher is better)
> @@ -70,6 +72,8 @@ struct module;
>   *			validate the clocksource from which the snapshot was
>   *			taken.
>   * @flags:		Flags describing special properties
> + * @base:		Hardware abstraction for clock on which a clocksource
> + *			is based
>   * @enable:		Optional function to enable the clocksource
>   * @disable:		Optional function to disable the clocksource
>   * @suspend:		Optional suspend function for the clocksource
> @@ -105,12 +109,14 @@ struct clocksource {
>  	struct arch_clocksource_data archdata;
>  #endif
>  	u64			max_cycles;
> +	u32			freq_khz;

Q: Why is this a bad place to add this member?

A: Because it creates a 4 byte hole in the data structure.

>  	const char		*name;
>  	struct list_head	list;

While adding it here fills a 4 byte hole.

Hint:

  pahole -c clocksource kernel/time/clocksource.o

would have told you that.

>  	int			rating;
>  	enum clocksource_ids	id;
>  	enum vdso_clock_mode	vdso_clock_mode;
>  	unsigned long		flags;
> +	struct clocksource_base *base;

> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index b58dffc58a8f..2542cfefbdee 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1193,6 +1193,40 @@ static bool timestamp_in_interval(u64 start, u64 end, u64 ts)
>  	return false;
>  }
>  
> +static bool convert_clock(u64 *val, u32 numerator, u32 denominator)
> +{
> +	u64 rem, res;
> +
> +	if (!numerator || !denominator)
> +		return false;
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
> +	u32 num, den;
> +
> +	/* The timestamp was taken from the time keeper clock source */
> +	if (cs->id == scv->cs_id)
> +		return true;
> +
> +	/* Check whether cs_id matches the base clock */
> +	if (!base || base->id != scv->cs_id)
> +		return false;
> +
> +	num = scv->use_nsecs ? cs->freq_khz : base->numerator;
> +	den = scv->use_nsecs ? USEC_PER_SEC : base->denominator;
> +
> +	convert_clock(&scv->cycles, num, den);

Q: Why does this ignore the return value of convert_clock() ?

A: Because all drivers will correctly fill in everything.

Q: Then why does convert_clock() bother to check and have a return
   value?

A: Because drivers will fail to correctly fill in everything

Thanks,

        tglx

