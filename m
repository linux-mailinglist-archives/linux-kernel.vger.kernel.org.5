Return-Path: <linux-kernel+bounces-110180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A65885B33
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8788C1F22A63
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF948595C;
	Thu, 21 Mar 2024 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bo1mXDrd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="72pv6KOl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B9B58232;
	Thu, 21 Mar 2024 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711032806; cv=none; b=qhnUqNgDztqkKxIOgjobSlv9FmSqD8aFN3LLp4KZQcOaCF0vSsVeZ7WPZmnq35C/SFHyc+aPv0yB9stBxqUCdrkH37q3p8sxxmzuhz1Q1zfPNRlthWTZX5x+c0Olm4iC7EEd6lNXSibc23ywE7v+s4ZhkqUUeZpbx/+vl/qWezk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711032806; c=relaxed/simple;
	bh=xrAps+kQb2l8QaGn7Q6eCI50hbOHvxC5cKDHNy6xTB4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=la2+WOKCeVTqiB9laHJY+86CtaBZeqdDFefQk5kbEx50VqUmWXIrjf7B2NFIt+ULAFbCEVmTfUacFnHoozzaEQz8uc3uoHCpSgpTBVJbNqhYZuccqUPJW6Pfel4zzkijkvlBj/7wRAWBNO28B8D7lPbrqgnr0m1auWrBa7GS34g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bo1mXDrd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=72pv6KOl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711032802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2r4kmlwH724Y4qI43//rL/0kpwyX9e5Eqqy+Tzlxna4=;
	b=Bo1mXDrdv9XN9ZfmeP7xgJh41zMLO8nOEsx6Tq0pqTkcVSOjDALigxXRNqQR8I0ICkjnfE
	jKO/rVkdvlpkv5QW3DdVSUE4ZpI6JNA5PUc3upt94pt9Nne/B2u264SiabjnUjwD2L0TvP
	nviHQ1omFuOg+DMG4rX7W/RNABhShvvJfJ6ph9bQLYwJbxU4c3B+hFv6o3gbZL6IO1et4L
	Ea2A6wYiuyQJAU+QkrkR+1uaIIBGH4tu9wPipDWhkzBy9amAzqt4KSNAnaeYkgXyRKtEan
	ZKOg7m+zHEJ3/7TT611E4X5nrcCwVRrIumMmrk9MKxUMp7ci7AOVlnh1U81J0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711032802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2r4kmlwH724Y4qI43//rL/0kpwyX9e5Eqqy+Tzlxna4=;
	b=72pv6KOlbz95mP5aFQ19r1gYUoZf8dUWfzAVreSPhDIR2yaW8/hAvL1hmsHdgv1+EU9W0K
	esvYdHhzFZEGnZDg==
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
 subramanian.mohan@intel.com, basavaraj.goudar@intel.com,
 thejesh.reddy.t.r@intel.com, lakshmi.sowjanya.d@intel.com
Subject: Re: [PATCH v5 02/11] timekeeping: Add function to convert realtime
 to base clock
In-Reply-To: <20240319130547.4195-3-lakshmi.sowjanya.d@intel.com>
References: <20240319130547.4195-1-lakshmi.sowjanya.d@intel.com>
 <20240319130547.4195-3-lakshmi.sowjanya.d@intel.com>
Date: Thu, 21 Mar 2024 15:53:22 +0100
Message-ID: <87le6bhc0t.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Mar 19 2024 at 18:35, lakshmi.sowjanya.d@intel.com wrote:
> +bool ktime_real_to_base_clock(ktime_t treal, enum clocksource_ids base_id, u64 *cycles)
> +{
> +	struct timekeeper *tk = &tk_core.timekeeper;
> +	unsigned int seq;
> +	u64 delta;
> +
> +	do {
> +		seq = read_seqcount_begin(&tk_core.seq);
> +		delta = (u64)treal - tk->tkr_mono.base_real;
> +		if (delta > tk->tkr_mono.clock->max_idle_ns)
> +			return false;

I don't think this cutoff is valid. There is no guarantee that this is
linear unless:

       Treal[last timekeeper update] <= treal < Treal[next timekeeper update]

Look at the dance in get_device_system_crosststamp() and
adjust_historical_crosststamp() to see why.

> +		*cycles = tk->tkr_mono.cycle_last + convert_ns_to_cs(delta);
> +		if (!convert_cs_to_base(cycles, base_id))
> +			return false;
> +	} while (read_seqcount_retry(&tk_core.seq, seq));
> +
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(ktime_real_to_base_clock);

Looking at the usage site:

> +static bool pps_generate_next_pulse(struct pps_tio *tio, ktime_t expires)
> +{
> +	u64 art;
> +
> +	if (!ktime_real_to_base_clock(expires, CSID_X86_ART, &art)) {
> +		pps_tio_disable(tio);

I'm pretty sure this can happen when there is sufficient delay between
the check for (now - expires < SAFE_TIME_NS) and the delta computation
in ktime_real_to_base_clock() if there is a timerkeeper update
interleaving which brings tkr_mono.base_real in front of expires.

Is that intentional and correct?

If so, then it's inconsistent with the behaviour of the hrtimer
callback:

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
> +
> +	guard(spinlock)(&tio->lock);
> +
> +	expires = hrtimer_get_expires(timer);
> +	now = ktime_get_real();
> +
> +	if (now - expires < SAFE_TIME_NS) {
> +		if (!pps_generate_next_pulse(tio, expires + SAFE_TIME_NS))
> +			return HRTIMER_NORESTART;
> +	}

This safe guard does not care about time being set. I'm not familiar
with the PPS logic, but is it expected that the pulse pattern will be
like this:

         

    ---|-----|-----|-----|----------------->
       P     P  ^        P
                |
        clock_settime(CLOCK_REALTIME, now - 2 seconds)         
        
        Obviously the pulse gap will be as big as the time is set
        backwards, which might be way more than 2 seconds.
        

    ---|-----|-----|-----|----------------->
       P     P  ^  P     P
                |
        clock_settime(CLOCK_REALTIME, now + 2 seconds)         

I don't see anything in this code which cares about CLOCK_REALTIME being
set via clock_settime() or adjtimex().

Aside of that I have a question about how the TIO hardware treats this
case:

   ktime_real_to_base_clock(expires, &art);

-> GAP which makes @art get into the past

   pps_compv_write(tio, art - ART_HW_DELAY_CYCLES);

Will the hardware ignore that already expired value or just emit a pulse
immediately? In the latter case the pulse will be at a random point in
time, which does not sound correct.

Thanks,

        tglx

