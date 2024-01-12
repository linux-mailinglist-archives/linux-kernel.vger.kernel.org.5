Return-Path: <linux-kernel+bounces-24870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0927882C3EC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E6761C21CAE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4EB77638;
	Fri, 12 Jan 2024 16:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OihcQlfb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wsE6E0B7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF126DD08
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705078103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i39wnHVKkhy9d6TH4lPHt34UT4DWa+lFtOcCwcilE1s=;
	b=OihcQlfbnHLtB/SL/R9wo4RwUsBPeTo1GmzAzZa6oF2+P51Dn9c8uzMdyEYbThJeeC8WPI
	8ek3ZgNdVX/mAlNOvnODt0fTid0JgGjZBPtLI5olNHmfSw8GDeII+sI6KcFtb/Yiz+JY4M
	3LHYK6WYjUhJXMlCOAWXS8LqN+5vRffrqlPI6DePFySLKJFk2tOdrGcFC8jEVIIOEDNWfY
	n/YCX8ieEB1ANudAZ4W355KYSI/g1EA4RE7ycNUT33bEMjnvGyxj7kMBe2CBsHTYQLaFT/
	NlumP273G9f9QyQgJxWtOtUdEiy+OpAdcB/uy5PYB3ERtivxETJTmCMGcGKkyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705078103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i39wnHVKkhy9d6TH4lPHt34UT4DWa+lFtOcCwcilE1s=;
	b=wsE6E0B7CpzonqLp8RanzuQNSEDY6urOv2hUx6afgTOH43KcwPHe9NXO30FPWRCeyqxwLS
	+hHxNEJ0tL/JbuDA==
To: Jiri Wiesner <jwiesner@suse.de>, linux-kernel@vger.kernel.org
Cc: John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, "Paul
 E. McKenney" <paulmck@kernel.org>, Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH v2] clocksource: Skip watchdog check for large watchdog
 intervals
In-Reply-To: <20240110192623.GA7158@incl>
References: <20240110192623.GA7158@incl>
Date: Fri, 12 Jan 2024 17:48:22 +0100
Message-ID: <875xzyijl5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 10 2024 at 20:26, Jiri Wiesner wrote:
> The measured clocksource skew - the absolute difference between cs_nsec
> and wd_nsec - was 668 microseconds:
>> cs_nsec - wd_nsec = 14524115132 - 14523447520 = 667612
>
> The kernel (based on 5.14.21) used 200 microseconds for the
> uncertainty_margin of both the clocksource and watchdog, resulting in a
> threshold of 400 microseconds.  The discrepancy is that the measured
> clocksource skew was evaluated against a threshold suited for watchdog
> intervals of roughly WATCHDOG_INTERVAL, i.e. HZ >> 1, which is 0.5
> second.

This really took some time to decode. What you are trying to explain is:

   The comparison between the clocksource and the watchdog is not
   working for large readout intervals because the conversion to
   nanoseconds is imprecise. The reason is that the initialization
   values of the shift/mult pairs which are used for conversion are not
   sufficiently accurate and the accumulated inaccuracy causes the
   comparison to exceed the threshold.

Right?

So yes, limiting the maximum readout interval and skipping the check is
sensible.

> Both the cs_nsec and the wd_nsec value indicate that the actual watchdog
> interval was circa 14.5 seconds. Since the watchdog is executed in softirq
> context the expiration of the watchdog timer can get severely delayed on
> account of a ksoftirqd thread not getting to run in a timely manner.
> Surely, a system with such belated softirq execution is not working well
> and the scheduling issue should be looked into but the clocksource
> watchdog should be able to deal with it accordingly.
>
> The solution in this patch skips the current watchdog check if the

  s/The solution in this patch skips/Prevent this by skipping/

We already know that this is a patch, no?

> v2: fixed interger overflow in WATCHDOG_INTR_MAX_NS on i386

Please put the version log after the --- separator. It's not part of the
changelog.

> Fixes: 2e27e793e280 ("clocksource: Reduce clocksource-skew threshold")
> Suggested-by: Feng Tang <feng.tang@intel.com>
> Reviewed-by: Feng Tang <feng.tang@intel.com>
> Tested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Jiri Wiesner <jwiesner@suse.de>
> ---
>  kernel/time/clocksource.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index c108ed8a9804..e7f8d0a1b95c 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -98,7 +98,9 @@ static u64 suspend_start;
>  /*
>   * Interval: 0.5sec.
>   */
> -#define WATCHDOG_INTERVAL (HZ >> 1)
> +#define WATCHDOG_INTERVAL	(HZ >> 1)
> +#define WATCHDOG_INTR_MAX_NS	((WATCHDOG_INTERVAL + (WATCHDOG_INTERVAL >> 1))\
> +				 * (NSEC_PER_SEC / HZ))

That 1.5 * WATCHDOG_INTERVAL seems to be rather arbitrary. One second
should be safe enough, no?
>  
> +		/*
> +		 * The processing of timer softirqs can get delayed (usually
> +		 * on account of ksoftirqd not getting to run in a timely
> +		 * manner), which causes the watchdog interval to stretch.
> +		 * Some clocksources, e.g. acpi_pm, cannot tolerate
> +		 * watchdog intervals longer than a few seconds.

What ensures that the watchdog did not wrap around then?

> +		 * Skew detection may fail for longer watchdog intervals
> +		 * on account of fixed margins being used.
> +		 */
> +		interval = max(cs_nsec, wd_nsec);
> +		if (unlikely(interval > WATCHDOG_INTR_MAX_NS)) {
> +			if (system_state > SYSTEM_SCHEDULING &&
> +			    interval > 2 * watchdog_max_intr) {

watchdog_max_intr is a misnomer. Why not naming it watchdog_max_interval
to make it entirly clear what this is about?

> +				watchdog_max_intr = interval;
> +				pr_warn("Skipping watchdog check: cs_nsec: %lld wd_nsec: %lld\n",
> +					cs_nsec, wd_nsec);

This really wants to have a proper indication why the check was skipped,
i,e. due to a long readout interval, no?

Thanks,

        tglx

