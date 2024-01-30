Return-Path: <linux-kernel+bounces-44721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2249842682
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77D61C221B8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CAF6D1C7;
	Tue, 30 Jan 2024 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwwXtS8o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD0F6D1BF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706622934; cv=none; b=RXNs41HQCR+zTsKUnOuVvmEuqdHG0rnVLpyuyKipLlEFfVuJBb5NlpjAxgEeqKdWTtNtOQROKy5g1m0QP3RAoimOPd51Y1tRj8isI9LjQ8sdChEvUUXvk/jTqLqEcOebbG9+7df4CE2OdL7dxLQQO5JavbWeeDDreCBEpvrkyw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706622934; c=relaxed/simple;
	bh=seN8zsI4AwKDuO3jFUMBIanLEvBBqPj86SY27vXvh28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDqIXgHPshfHAfb8IONo5b1FDlDU5xKAhV+odx/3io7dBTk1cnbAvJilfjBbIGiJqEH9a4JlNma3LX1ga/haBrx99L7DqFGuxqGzqyCSvL57FbKDd6rkmp2vW8BkViPKEC8nlz95d5Z0AtJeapy351Imeww9YKEds8wVj7uW2Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwwXtS8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE824C433C7;
	Tue, 30 Jan 2024 13:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706622933;
	bh=seN8zsI4AwKDuO3jFUMBIanLEvBBqPj86SY27vXvh28=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=WwwXtS8o+6jSFyRZSGOdA9LSYtgTkKlotMToV2nAp4JSP4FLWGSKy73412pYXsURu
	 o9qzT9RJFIU3EQANRtbT0wfTg1VeyjDpGACAGLPF4KlE1WPFg5FTI3aM32wAQyWP83
	 +90ysmDLPIR2oLLUIgS3DwUTmVTRs3+IXRZlY46yGYByBiXjx+VCmuDwLYko5z1k7e
	 Bqq/+cNGTDu+w7/Kw4y60DpWPpStaIyhfCyW0TNVeqxHKV31wd72TTOV3o53kQB9/i
	 x4cesJy9W0+NyP4wFn8UlFv3+Ln5vKHAF571mbq51KoFWiZ1EKC6a0SRGmJcfYKv5m
	 F67kzpcxkltng==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 51BBDCE0975; Tue, 30 Jan 2024 05:55:33 -0800 (PST)
Date: Tue, 30 Jan 2024 05:55:33 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Feng Tang <feng.tang@intel.com>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Jin Wang <jin1.wang@intel.com>
Subject: Re: [PATCH v3] clocksource: Scale the max retry number of watchdog
 read according to CPU numbers
Message-ID: <b25b8060-af20-41e0-b54d-ba1403d23396@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240129134505.961208-1-feng.tang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129134505.961208-1-feng.tang@intel.com>

On Mon, Jan 29, 2024 at 09:45:05PM +0800, Feng Tang wrote:
> There was a bug on one 8-socket server that the TSC is wrongly marked as
> 'unstable' and disabled during boot time (reproduce rate is about every
> 120 rounds of reboot tests), with log:
> 
>     clocksource: timekeeping watchdog on CPU227: wd-tsc-wd excessive read-back delay of 153560ns vs. limit of 125000ns,
>     wd-wd read-back delay only 11440ns, attempt 3, marking tsc unstable
>     tsc: Marking TSC unstable due to clocksource watchdog
>     TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
>     sched_clock: Marking unstable (119294969739, 159204297)<-(125446229205, -5992055152)
>     clocksource: Checking clocksource tsc synchronization from CPU 319 to CPUs 0,99,136,180,210,542,601,896.
>     clocksource: Switched to clocksource hpet
> 
> The reason is for platform with lots of CPU, there are sporadic big or huge
> read latency of read watchog/clocksource during boot or when system is under
> stress work load, and the frequency and maximum value of the latency goes up
> with the increasing of CPU numbers. Current code already has logic to detect
> and filter such high latency case by reading 3 times of watchdog, and check
> the 2 deltas. Due to the randomness of the latency, there is a low possibility
> situation that the first delta (latency) is big, but the second delta is small
> and looks valid, which can escape from the check, and there is a
> 'max_cswd_read_retries' for retrying that check covering this case, whose
> default value is only 2 and may be not enough for machines with huge number
> of CPUs.
> 
> So scale and enlarge the max retry number according to CPU number to better
> filter those latency noise for large systems, which has been verified fine
> in 4 days and 670 rounds of reboot test on the 8-socket machine.
> 
> Also add sanity check for user input value for 'max_cswd_read_retries', make
> it self-adaptive by default, and provide a general helper for getting this
> max retry number as suggested by Paul and Waiman.
> 
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Tested-by: Jin Wang <jin1.wang@intel.com>

Tested-by: Paul E. McKenney <paulmck@kernel.org>

> ---
> Changelog:
> 
>     since v2:
>       * Fix the unexported symbol of helper function being used by
>         kernel module issue (Waiman)
> 
>     since v1:
>       * Add santity check for user input value of 'max_cswd_read_retries'
>         and a helper function for getting max retry nubmer (Paul)
>       * Apply the same logic to watchdog test code (Waiman)
> 
>  include/linux/clocksource.h      | 18 +++++++++++++++++-
>  kernel/time/clocksource-wdtest.c | 12 +++++++-----
>  kernel/time/clocksource.c        | 10 ++++++----
>  3 files changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
> index 1d42d4b17327..0483f7dd66a3 100644
> --- a/include/linux/clocksource.h
> +++ b/include/linux/clocksource.h
> @@ -291,7 +291,23 @@ static inline void timer_probe(void) {}
>  #define TIMER_ACPI_DECLARE(name, table_id, fn)		\
>  	ACPI_DECLARE_PROBE_ENTRY(timer, name, table_id, 0, NULL, 0, fn)
>  
> -extern ulong max_cswd_read_retries;
> +extern long max_cswd_read_retries;
> +
> +static inline long clocksource_max_watchdog_read_retries(void)
> +{
> +	long max_retries = max_cswd_read_retries;
> +
> +	if (max_cswd_read_retries <= 0) {
> +		/* santity check for user input value */
> +		if (max_cswd_read_retries != -1)
> +			pr_warn_once("max_cswd_read_retries was set with an invalid number: %ld\n",
> +				max_cswd_read_retries);
> +
> +		max_retries = ilog2(num_online_cpus()) + 1;
> +	}
> +	return max_retries;
> +}
> +
>  void clocksource_verify_percpu(struct clocksource *cs);
>  
>  #endif /* _LINUX_CLOCKSOURCE_H */
> diff --git a/kernel/time/clocksource-wdtest.c b/kernel/time/clocksource-wdtest.c
> index df922f49d171..c70cea3c44a1 100644
> --- a/kernel/time/clocksource-wdtest.c
> +++ b/kernel/time/clocksource-wdtest.c
> @@ -106,6 +106,7 @@ static int wdtest_func(void *arg)
>  	unsigned long j1, j2;
>  	char *s;
>  	int i;
> +	long max_retries;
>  
>  	schedule_timeout_uninterruptible(holdoff * HZ);
>  
> @@ -139,18 +140,19 @@ static int wdtest_func(void *arg)
>  	WARN_ON_ONCE(time_before(j2, j1 + NSEC_PER_USEC));
>  
>  	/* Verify tsc-like stability with various numbers of errors injected. */
> -	for (i = 0; i <= max_cswd_read_retries + 1; i++) {
> -		if (i <= 1 && i < max_cswd_read_retries)
> +	max_retries = clocksource_max_watchdog_read_retries();
> +	for (i = 0; i <= max_retries + 1; i++) {
> +		if (i <= 1 && i < max_retries)
>  			s = "";
> -		else if (i <= max_cswd_read_retries)
> +		else if (i <= max_retries)
>  			s = ", expect message";
>  		else
>  			s = ", expect clock skew";
> -		pr_info("--- Watchdog with %dx error injection, %lu retries%s.\n", i, max_cswd_read_retries, s);
> +		pr_info("--- Watchdog with %dx error injection, %ld retries%s.\n", i, max_retries, s);
>  		WRITE_ONCE(wdtest_ktime_read_ndelays, i);
>  		schedule_timeout_uninterruptible(2 * HZ);
>  		WARN_ON_ONCE(READ_ONCE(wdtest_ktime_read_ndelays));
> -		WARN_ON_ONCE((i <= max_cswd_read_retries) !=
> +		WARN_ON_ONCE((i <= max_retries) !=
>  			     !(clocksource_wdtest_ktime.flags & CLOCK_SOURCE_UNSTABLE));
>  		wdtest_ktime_clocksource_reset();
>  	}
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index c108ed8a9804..2e5a1d6c6712 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -208,8 +208,8 @@ void clocksource_mark_unstable(struct clocksource *cs)
>  	spin_unlock_irqrestore(&watchdog_lock, flags);
>  }
>  
> -ulong max_cswd_read_retries = 2;
> -module_param(max_cswd_read_retries, ulong, 0644);
> +long max_cswd_read_retries = -1;
> +module_param(max_cswd_read_retries, long, 0644);
>  EXPORT_SYMBOL_GPL(max_cswd_read_retries);
>  static int verify_n_cpus = 8;
>  module_param(verify_n_cpus, int, 0644);
> @@ -225,8 +225,10 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
>  	unsigned int nretries;
>  	u64 wd_end, wd_end2, wd_delta;
>  	int64_t wd_delay, wd_seq_delay;
> +	long max_retries;
>  
> -	for (nretries = 0; nretries <= max_cswd_read_retries; nretries++) {
> +	max_retries = clocksource_max_watchdog_read_retries();
> +	for (nretries = 0; nretries <= max_retries; nretries++) {
>  		local_irq_disable();
>  		*wdnow = watchdog->read(watchdog);
>  		*csnow = cs->read(cs);
> @@ -238,7 +240,7 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
>  		wd_delay = clocksource_cyc2ns(wd_delta, watchdog->mult,
>  					      watchdog->shift);
>  		if (wd_delay <= WATCHDOG_MAX_SKEW) {
> -			if (nretries > 1 || nretries >= max_cswd_read_retries) {
> +			if (nretries > 1 || nretries >= max_retries) {
>  				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
>  					smp_processor_id(), watchdog->name, nretries);
>  			}
> -- 
> 2.34.1
> 

