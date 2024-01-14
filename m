Return-Path: <linux-kernel+bounces-25386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B354582CF62
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 01:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7C21F22073
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 00:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0759380;
	Sun, 14 Jan 2024 00:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F9cd9KE2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QatDXfcb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730AA7E
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 00:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705191739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tbqSocM7AY2xwmZ1e4M/mdEEJPDtFVD2uk/fr34n9Oc=;
	b=F9cd9KE2fqWtNm2al9BJVDkcBKegdpZq35Awxjmeu2E1OcLKpqqUo8tp6vVfie7G9dLIuk
	f2c9G399fbtDNGzpfDSI3MW8c4RDB07KIB7r9vFWbVRLljiD3OkMYByRwVrFcZIF3uVPWu
	7KzYgX+IcEL5kdeTTB+/dpn8CbvzDvCjYX+SBFAnot6dLa5gvCkt9oHtj3Lwx4IFWMOqWr
	/KkwJiMz90DLJluSYvsL1IC31Dny+4yJ+M1uwy+MzaschgFrCKA06IaBdWwx72mc3Qv+M4
	l8aJxTq2+xO6YquBZUzKC2mtTFfW1AqmCT5CrnUkqWxXu92sgTwePotRhSwFeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705191739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tbqSocM7AY2xwmZ1e4M/mdEEJPDtFVD2uk/fr34n9Oc=;
	b=QatDXfcbs27vv6jdOVVCZ5yHkv4m3l0NbksBz9BhkNBXQ87sv1oLxzw6k12DURnj1jGstI
	ypYRUM4noWCc/ZBQ==
To: Jiri Wiesner <jwiesner@suse.de>
Cc: linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>, Stephen
 Boyd <sboyd@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Feng
 Tang <feng.tang@intel.com>
Subject: Re: [PATCH v2] clocksource: Skip watchdog check for large watchdog
 intervals
In-Reply-To: <20240113114400.GH3303@incl>
References: <20240110192623.GA7158@incl> <875xzyijl5.ffs@tglx>
 <20240113114400.GH3303@incl>
Date: Sun, 14 Jan 2024 01:22:18 +0100
Message-ID: <87cyu4hih1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jan 13 2024 at 12:44, Jiri Wiesner wrote:
> On Fri, Jan 12, 2024 at 05:48:22PM +0100, Thomas Gleixner wrote:
>> On Wed, Jan 10 2024 at 20:26, Jiri Wiesner wrote:
>> > The measured clocksource skew - the absolute difference between cs_nsec
>> > and wd_nsec - was 668 microseconds:
>> >> cs_nsec - wd_nsec = 14524115132 - 14523447520 = 667612
>> >
>> > The kernel (based on 5.14.21) used 200 microseconds for the
>> > uncertainty_margin of both the clocksource and watchdog, resulting in a
>> > threshold of 400 microseconds.  The discrepancy is that the measured
>> > clocksource skew was evaluated against a threshold suited for watchdog
>> > intervals of roughly WATCHDOG_INTERVAL, i.e. HZ >> 1, which is 0.5
>> > second.
>> 
>> This really took some time to decode. What you are trying to explain is:
>> 
>>    The comparison between the clocksource and the watchdog is not
>>    working for large readout intervals because the conversion to
>>    nanoseconds is imprecise. The reason is that the initialization
>>    values of the shift/mult pairs which are used for conversion are not
>>    sufficiently accurate and the accumulated inaccuracy causes the
>>    comparison to exceed the threshold.
>
> The root cause of the bug does not concern the precision of the conversion 
> to nanoseconds. The shift/mult pair of the TSC can convert diffs as large 
> as 600 seconds. The HPET is limited to 179.0 seconds on account of being a 
> 32-bit counter. The acpi_pm can convert only 4.7 seconds. With the 
> CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE option enabled, the ranges are 
> reduced to a half. The example above showed the TSC as the clocksource and 
> the HPET as a watchdog both of which should be able to convert a diff of 
> 14.5 seconds to nanoseconds with sufficient precision.

No. It _is_ an initialization and conversion precision problem, nothing
else.

Assume a perfect world where the frequency of the TSC and the frequency
of the HPET are precisely known at initialization time and the
conversion factors to nanoseconds are precise as well. Assume further
that the clock frequencies wont drift over time differently.

Then the relationship between the nanosecond converted readouts of TSC
and HPET (or any other watchdog clocksource) would be constant
independent of the readout interval with the following prerequisites:

  1) freq(TSC) / freq(HPET) == constant

  2) Conversion from TSC to nanoseconds is correct independent of the
     interval

  3) Conversion from HPET to nanoseconds is correct independent of the
     interval

So if all apply the uncertainty margin would be correct for any
valid non wrapped around readout interval, which is a completely
different issue to take care of.

Though because neither the frequency values are precise nor the
conversion factors to nanoseconds are precise for a larger interval nor
there is a guarantee that the clock frequencies of both clocks can't
drift differently all prerequisites #1 - #3 above are not there.

As a consequence there _is_ a limitation to the readout interval where
the comparison is valid.

See?

If you still don't agree then I'm happy to write up the corresponding
formulas for you.

Thanks,

        tglx

