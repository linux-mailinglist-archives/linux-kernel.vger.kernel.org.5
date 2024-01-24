Return-Path: <linux-kernel+bounces-37296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4EE83ADEB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C42A81C2207B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA9D7CF05;
	Wed, 24 Jan 2024 16:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHFlmV2T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733D2539E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112223; cv=none; b=T//1cEQIxlMt5WXEAs1eU0CYKRCzjDo03SN8crNUEvYt/F625a7qEQGeB79WMEpSjqbfFQU3jU7pILMaDrkAD3L6R33yYKna6KFk9P61e80s3+4FfFfjzI0qMVDz2mWg6s60mXm19ejShxtNjH2VQEA9QymUiQwCWsoD6CaKTPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112223; c=relaxed/simple;
	bh=x/tzpQQm4opZMo3zGkoTns+FUQexJHlzqI5yTxSXLgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZY7zLWgy8oSisn/Ncmw7RSNg8arH3s9rdNOZmD6G4a0eRuUKmZXeFK6wFxKZIqmAO/D4gtheos6PWWQuAvjWqQvGvF27fGFkmrXEGtDKgv5QfK+0n2/n/3JbgBWakBnGCmgae74Y0WHtM6BuDkZoorffN2ZG5AaQP8BdLoh02w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHFlmV2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05274C433F1;
	Wed, 24 Jan 2024 16:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706112223;
	bh=x/tzpQQm4opZMo3zGkoTns+FUQexJHlzqI5yTxSXLgs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=XHFlmV2Td32IDn4CFleFntWAh31mvUxJK+arChk4smuXTBPnGl6xHZTT04dLpyDPD
	 W62xbnowLjHPKBik1wm9Uh/4gML86jEdXxM+uonbtzP5ykACLmwLh5LJPT3cm6+aMz
	 V1iME8K9kP1A3xFA/1qtrd5NWckbowdCYrwthxQgEUYG+UEc2Jtwghzqp9fFABOs1D
	 /c9l6E058eAh/Xnia1IXePXbKD4b4RxZRgrrEcSUiFlAKF1fJ3cL5HhQ+zsOWPKoG7
	 YfmxW/TnPnoqQ/Wt5b/1dnpcKQAV7A0tzgSmHbQWud3/Sdh6HdA0paijyqi0M42abr
	 LEatkpv9XrInQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 98D16CE145A; Wed, 24 Jan 2024 08:03:42 -0800 (PST)
Date: Wed, 24 Jan 2024 08:03:42 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jiri Wiesner <jwiesner@suse.de>
Cc: linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH v3] clocksource: Skip watchdog check for large watchdog
 intervals
Message-ID: <616658ba-0e69-447b-8b52-5051a5aa9bc0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240122172350.GA740@incl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122172350.GA740@incl>

On Mon, Jan 22, 2024 at 06:23:50PM +0100, Jiri Wiesner wrote:
> There have been reports of the watchdog marking clocksources unstable on
> machines with 8 NUMA nodes:
> > clocksource: timekeeping watchdog on CPU373: Marking clocksource 'tsc' as unstable because the skew is too large:
> > clocksource:   'hpet' wd_nsec: 14523447520 wd_now: 5a749706 wd_last: 45adf1e0 mask: ffffffff
> > clocksource:   'tsc' cs_nsec: 14524115132 cs_now: 515ce2c5a96caa cs_last: 515cd9a9d83918 mask: ffffffffffffffff
> > clocksource:   'tsc' is current clocksource.
> > tsc: Marking TSC unstable due to clocksource watchdog
> > TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
> > sched_clock: Marking unstable (1950347883333462, 79649632569)<-(1950428279338308, -745776594)
> > clocksource: Checking clocksource tsc synchronization from CPU 400 to CPUs 0,46,52,54,138,208,392,397.
> > clocksource: Switched to clocksource hpet
> 
> The measured clocksource skew - the absolute difference between cs_nsec
> and wd_nsec - was 668 microseconds:
> > cs_nsec - wd_nsec = 14524115132 - 14523447520 = 667612
> 
> The kernel (based on 5.14.21) used 200 microseconds for the
> uncertainty_margin of both the clocksource and watchdog, resulting in a
> threshold of 400 microseconds (the md variable). Both the cs_nsec and the
> wd_nsec value indicate that the readout interval was circa 14.5 seconds.
> The observed behaviour is that watchdog checks failed for large readout
> intervals on 8 NUMA node machines. This indicates that the size of the
> skew was directly proportinal to the length of the readout interval on
> those machines. The measured clocksource skew, 668 microseconds, was
> evaluated against a threshold (the md variable) that is suited for
> readout intervals of roughly WATCHDOG_INTERVAL, i.e. HZ >> 1, which is
> 0.5 second.
> 
> The intention of 2e27e793e280 ("clocksource: Reduce clocksource-skew
> threshold") was to tighten the threshold for evaluating skew and set the
> lower bound for the uncertainty_margin of clocksources to twice
> WATCHDOG_MAX_SKEW. Later in c37e85c135ce ("clocksource: Loosen clocksource
> watchdog constraints"), the WATCHDOG_MAX_SKEW constant was increased to
> 125 microseconds to fit the limit of NTP, which is able to use a
> clocksource that suffers from up to 500 microseconds of skew per second.
> Both the TSC and the HPET use default uncertainty_margin. When the
> readout interval gets stretched the default uncertainty_margin is no
> longer a suitable lower bound for evaluating skew - it imposes a limit
> that is far stricter than the skew with which NTP can deal.
> 
> The root causes of the skew being directly proportinal to the length of
> the readout interval are
> * the inaccuracy of the shift/mult pairs of clocksources and the watchdog
> * the conversion to nanoseconds is imprecise for large readout intervals
> 
> Prevent this by skipping the current watchdog check if the readout
> interval exceeds 2 * WATCHDOG_INTERVAL. Considering the maximum readout
> interval of 2 * WATCHDOG_INTERVAL, the current default uncertainty margin
> (of the TSC and HPET) corresponds to a limit on clocksource skew of 250
> ppm (microseconds of skew per second).  To keep the limit imposed by NTP
> (500 microseconds of skew per second) for all possible readout intervals,
> the margins would have to be scaled so that the threshold value is
> proportional to the length of the actual readout interval.
> 
> As for why the readout interval may get stretched: Since the watchdog is
> executed in softirq context the expiration of the watchdog timer can get
> severely delayed on account of a ksoftirqd thread not getting to run in a
> timely manner. Surely, a system with such belated softirq execution is not
> working well and the scheduling issue should be looked into but the
> clocksource watchdog should be able to deal with it accordingly.
> 
> Fixes: 2e27e793e280 ("clocksource: Reduce clocksource-skew threshold")
> Suggested-by: Feng Tang <feng.tang@intel.com>
> Reviewed-by: Feng Tang <feng.tang@intel.com>
> Tested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Jiri Wiesner <jwiesner@suse.de>
> ---
> 
> v2: fixed interger overflow in WATCHDOG_INTR_MAX_NS on i386
> v3: variable renaming, threshold adjusted, message and log changes
> 
>  kernel/time/clocksource.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index c108ed8a9804..3052b1f1168e 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -99,6 +99,7 @@ static u64 suspend_start;
>   * Interval: 0.5sec.
>   */
>  #define WATCHDOG_INTERVAL (HZ >> 1)
> +#define WATCHDOG_INTERVAL_MAX_NS ((2 * WATCHDOG_INTERVAL) * (NSEC_PER_SEC / HZ))

We need something here to force 64-bit arithmetic on 32-bit systems
correct?  (If I missed a v4, please point me at it.)

							Thanx, Paul

>  /*
>   * Threshold: 0.0312s, when doubled: 0.0625s.
> @@ -134,6 +135,7 @@ static DECLARE_WORK(watchdog_work, clocksource_watchdog_work);
>  static DEFINE_SPINLOCK(watchdog_lock);
>  static int watchdog_running;
>  static atomic_t watchdog_reset_pending;
> +static int64_t watchdog_max_interval;
>  
>  static inline void clocksource_watchdog_lock(unsigned long *flags)
>  {
> @@ -399,8 +401,8 @@ static inline void clocksource_reset_watchdog(void)
>  static void clocksource_watchdog(struct timer_list *unused)
>  {
>  	u64 csnow, wdnow, cslast, wdlast, delta;
> +	int64_t wd_nsec, cs_nsec, interval;
>  	int next_cpu, reset_pending;
> -	int64_t wd_nsec, cs_nsec;
>  	struct clocksource *cs;
>  	enum wd_read_status read_ret;
>  	unsigned long extra_wait = 0;
> @@ -470,6 +472,27 @@ static void clocksource_watchdog(struct timer_list *unused)
>  		if (atomic_read(&watchdog_reset_pending))
>  			continue;
>  
> +		/*
> +		 * The processing of timer softirqs can get delayed (usually
> +		 * on account of ksoftirqd not getting to run in a timely
> +		 * manner), which causes the watchdog interval to stretch.
> +		 * Skew detection may fail for longer watchdog intervals
> +		 * on account of fixed margins being used.
> +		 * Some clocksources, e.g. acpi_pm, cannot tolerate
> +		 * watchdog intervals longer than a few seconds.
> +		 */
> +		interval = max(cs_nsec, wd_nsec);
> +		if (unlikely(interval > WATCHDOG_INTERVAL_MAX_NS)) {
> +			if (system_state > SYSTEM_SCHEDULING &&
> +			    interval > 2 * watchdog_max_interval) {
> +				watchdog_max_interval = interval;
> +				pr_warn("Long readout interval, skipping watchdog check: cs_nsec: %lld wd_nsec: %lld\n",
> +					cs_nsec, wd_nsec);
> +			}
> +			watchdog_timer.expires = jiffies;
> +			continue;
> +		}
> +
>  		/* Check the deviation from the watchdog clocksource. */
>  		md = cs->uncertainty_margin + watchdog->uncertainty_margin;
>  		if (abs(cs_nsec - wd_nsec) > md) {
> -- 
> 2.35.3
> 
> 
> -- 
> Jiri Wiesner
> SUSE Labs

