Return-Path: <linux-kernel+bounces-16049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDED2823776
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4346D1F25EEA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209221DDF2;
	Wed,  3 Jan 2024 22:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRWmK/9m"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708F61DDE0
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 22:08:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2025C433C8;
	Wed,  3 Jan 2024 22:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704319689;
	bh=8toS+vH5TPTvCpB0j1ZUDmGyx02iYIyKXGyqPxOzIdk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=fRWmK/9mUBIYIM0IH9NCzZfQMkMmJvMqw1pwXmF+pTpFqoTy8xlBHbeo243/wirw/
	 ZS45VOM0GS6+Y8Kl1WE2y/3RlAavx07VupffACtS1yT93ARhjOeVRcVskhj5bdO+Qm
	 pEqTgE+PQddxqfkPPCcl5IQWCkf/GMCTsU6YmHGd0HfKPZcIA1wYf/hK+sNdemnnev
	 yMN39gkq4sUuT+v1qYXS3HUsPCGdgiaKZKrbiGC+BQ2vzf6sa6SwDA4Y6+OZ/jG1JN
	 UbtR3DLtQFnU+uZRGgL/cJhccSDBE8AFwez59eK63ygM4Z3a2WNW5629bmmALX5CvR
	 2dg5a7qrcvWPQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9157DCE08F4; Wed,  3 Jan 2024 14:08:08 -0800 (PST)
Date: Wed, 3 Jan 2024 14:08:08 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jiri Wiesner <jwiesner@suse.de>
Cc: linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH] clocksource: Skip watchdog check for large watchdog
 intervals
Message-ID: <5b8fd9ba-1622-4ec7-b3cc-2db3a78122f1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240103112113.GA6108@incl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103112113.GA6108@incl>

On Wed, Jan 03, 2024 at 12:21:13PM +0100, Jiri Wiesner wrote:
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
> threshold of 400 microseconds.  The discrepancy is that the measured
> clocksource skew was evaluated against a threshold suited for watchdog
> intervals of roughly WATCHDOG_INTERVAL, i.e. HZ >> 1, which is 0.5 second.
> Both the cs_nsec and the wd_nsec value indicate that the actual watchdog
> interval was circa 14.5 seconds. Since the watchdog is executed in softirq
> context the expiration of the watchdog timer can get severely delayed on
> account of a ksoftirqd thread not getting to run in a timely manner.
> Surely, a system with such belated softirq execution is not working well
> and the scheduling issue should be looked into but the clocksource
> watchdog should be able to deal with it accordingly.
> 
> The solution in this patch skips the current watchdog check if the
> watchdog interval exceeds 1.5 * WATCHDOG_INTERVAL. Considering the maximum
> watchdog interval of 1.5 * WATCHDOG_INTERVAL, the current default
> uncertainty margin (of the TSC and HPET) corresponds to a limit on
> clocksource skew of 333 ppm (microseconds of skew per second). To keep the
> limit imposed by NTP (500 microseconds of skew per second) for all
> possible watchdog intervals, the margins would have to be scaled so that
> the threshold value is proportional to the length of the actual watchdog
> interval.
> 
> Fixes: 2e27e793e280 ("clocksource: Reduce clocksource-skew threshold")
> Suggested-by: Feng Tang <feng.tang@intel.com>
> Signed-off-by: Jiri Wiesner <jwiesner@suse.de>

I believe that there were concerns about a similar approach in the case
where the jiffies counter is the clocksource, but in the meantime:

Tested-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/time/clocksource.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index c108ed8a9804..ac5cb0ff278b 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -98,7 +98,9 @@ static u64 suspend_start;
>  /*
>   * Interval: 0.5sec.
>   */
> -#define WATCHDOG_INTERVAL (HZ >> 1)
> +#define WATCHDOG_INTERVAL	(HZ >> 1)
> +#define WATCHDOG_INTR_MAX_NS	((WATCHDOG_INTERVAL + (WATCHDOG_INTERVAL >> 1))\
> +				 * NSEC_PER_SEC / HZ)
>  
>  /*
>   * Threshold: 0.0312s, when doubled: 0.0625s.
> @@ -134,6 +136,7 @@ static DECLARE_WORK(watchdog_work, clocksource_watchdog_work);
>  static DEFINE_SPINLOCK(watchdog_lock);
>  static int watchdog_running;
>  static atomic_t watchdog_reset_pending;
> +static int64_t watchdog_max_intr;
>  
>  static inline void clocksource_watchdog_lock(unsigned long *flags)
>  {
> @@ -400,7 +403,7 @@ static void clocksource_watchdog(struct timer_list *unused)
>  {
>  	u64 csnow, wdnow, cslast, wdlast, delta;
>  	int next_cpu, reset_pending;
> -	int64_t wd_nsec, cs_nsec;
> +	int64_t wd_nsec, cs_nsec, interval;
>  	struct clocksource *cs;
>  	enum wd_read_status read_ret;
>  	unsigned long extra_wait = 0;
> @@ -470,6 +473,27 @@ static void clocksource_watchdog(struct timer_list *unused)
>  		if (atomic_read(&watchdog_reset_pending))
>  			continue;
>  
> +		/*
> +		 * The processing of timer softirqs can get delayed (usually
> +		 * on account of ksoftirqd not getting to run in a timely
> +		 * manner), which causes the watchdog interval to stretch.
> +		 * Some clocksources, e.g. acpi_pm, cannot tolerate
> +		 * watchdog intervals longer than a few seconds.
> +		 * Skew detection may fail for longer watchdog intervals
> +		 * on account of fixed margins being used.
> +		 */
> +		interval = max(cs_nsec, wd_nsec);
> +		if (unlikely(interval > WATCHDOG_INTR_MAX_NS)) {
> +			if (system_state > SYSTEM_SCHEDULING &&
> +			    interval > 2 * watchdog_max_intr) {
> +				watchdog_max_intr = interval;
> +				pr_warn("Skipping watchdog check: cs_nsec: %lld wd_nsec: %lld\n",
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

