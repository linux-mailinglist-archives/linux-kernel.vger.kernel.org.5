Return-Path: <linux-kernel+bounces-139438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 758708A035B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23BE01F218FD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34ABF190696;
	Wed, 10 Apr 2024 22:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="muTnCJ68";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FPSE9QII"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078D2184133;
	Wed, 10 Apr 2024 22:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712788128; cv=none; b=UnbgeWExYmqWSJJ8WdZ8jkNtB0enm2aQUo5JxAXS/EsJtaWORcgsox5oqlg6nPb/Ihua4E/XKxH917LNvYYMl9cH4GtSN+cx+AVmqMSrR5InKmgkCPUHwyEStRONGwlzObcAZOo9uXmwUwyW3Ra78QUlvf79IMVb5pLbRjXJbSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712788128; c=relaxed/simple;
	bh=rGZ+6mgME8CDq8cx81U16NGCfofP7d9T2GtDJ02icag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oTkpIeXODoemdnt6YEV8FH1+/wgwyZRuF3avbe47VyUG9R6yBBknIRXGQmxDOCH4xoZqO0MGg5VFzuD4qlRxZXgEq+JHJqbixVv1aplwXazrONukHoQRipJzfigVoPt3LaPTve9nHgCB3EZjAp2OWORxZ33xdoCp4MOo6UPGjvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=muTnCJ68; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FPSE9QII; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712788124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+09dt8Lue6gAfa+yZ3gUFUEMm5OBKypuTUNVnYjhGiQ=;
	b=muTnCJ68xg/jmo1x+2PYwo/j8IVl0QMhstkOGPeUNym23NDJrX5zlIVmz9uYKGC9+/ri/7
	r6snD/AYMuoBMQhStc6A+vE/yMOG9XexG/wrx+iGOKmU/XgUzwZOF0oGkdhko9NdJCRQas
	2v6q7OryngQcxkh7piM54dBz7MZap2S61QX8VWH7lazZ9iBkX+GXQ+V3+HBDu8wbiW/DvR
	Ml0UXNavBUtb/JzSyMy8zpYb7jndefj/ExMb5KkJFNnvb3MKpzzo+wv8qdhLwXMsFg7D7Y
	jThZMktSZwHCqfIwQFGrAR3DpGQQ814EnkbCEZUx9IL1INtVwOQHwfQKCY0QGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712788124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+09dt8Lue6gAfa+yZ3gUFUEMm5OBKypuTUNVnYjhGiQ=;
	b=FPSE9QIIrOJKgP7TOP2bJcNmzEPJfsb9D62zE2XFb1kLmJQ/08SWzbqjbkcHgTADwuS7DU
	98onkVILTp2D12Aw==
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
Subject: Re: [PATCH v6 09/11] pps: generators: Add PPS Generator TIO Driver
In-Reply-To: <20240410114828.25581-10-lakshmi.sowjanya.d@intel.com>
References: <20240410114828.25581-1-lakshmi.sowjanya.d@intel.com>
 <20240410114828.25581-10-lakshmi.sowjanya.d@intel.com>
Date: Thu, 11 Apr 2024 00:28:43 +0200
Message-ID: <874jc83l9g.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Apr 10 2024 at 17:18, lakshmi.sowjanya.d@intel.com wrote:
> +static bool pps_generate_next_pulse(struct pps_tio *tio, ktime_t expires)
> +{
> +	u64 art;
> +
> +	if (!ktime_real_to_base_clock(expires, CSID_X86_ART, &art)) {
> +		pps_tio_disable(tio);
> +		return false;
> +	}
> +
> +	pps_compv_write(tio, art - ART_HW_DELAY_CYCLES);
> +	return true;
> +}
> +
> +static enum hrtimer_restart hrtimer_callback(struct hrtimer *timer)
> +{
> +	struct pps_tio *tio = container_of(timer, struct pps_tio, timer);
> +	ktime_t expires, now;
> +	u32 event_count;
> +
> +	guard(spinlock)(&tio->lock);
> +
> +	/* Check if any event is missed. If an event is missed, TIO will be disabled*/
> +	event_count = pps_tio_read(tio, TIOEC);
> +	if (!tio->prev_count && tio->prev_count == event_count)
> +		goto err;
> +	tio->prev_count = event_count;
> +	expires = hrtimer_get_expires(timer);
> +	now = ktime_get_real();
> +
> +	if (now - expires < SAFE_TIME_NS) {
> +		if (!pps_generate_next_pulse(tio, expires + SAFE_TIME_NS))
> +			goto err;
> +	}

If the hrtimer callback is invoked late so that now - expires is >=
SAFE_TIME_NS then this just forwards the timer and tries again.

This lacks any form of explanation why this is correct as obviously
there will be a missing pulse, no?

> +	hrtimer_forward(timer, now, NSEC_PER_SEC / 2);
> +	return HRTIMER_RESTART;
> +err:
> +	dev_err(tio->dev, "Event missed, Disabling Timed I/O");
> +	pps_tio_disable(tio);

Why does this disable it again? The failure path in
pps_generate_next_pulse() does so already, no?

> +	return HRTIMER_NORESTART;
> +}
> +

Thanks,

        tglx

