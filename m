Return-Path: <linux-kernel+bounces-74053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F033785CF59
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180E21C2129D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7790C3984A;
	Wed, 21 Feb 2024 04:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgo8aD96"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745462E3EF
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 04:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708490550; cv=none; b=ugJUqB+t4mjKJDXrs/dQJpdYHN+P7fRuvbPnsP2X1JtR4I83YElPCJWOxCa3TwzdhTwPgq9jVCzMMgBfV/nporY7q05J7ipJ5aK7Jc6kfsW7YxWWUMUJUQwrqmpLXctVlQM2iMDaqPnkqRN6pcWMjCCxHO3BGdwQ226XJR49agg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708490550; c=relaxed/simple;
	bh=7qbv084Tw0jU0rG3Mycr9LtNeEo3/RiPxmKo2q2amKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVclE6J7Dgd6BF3feJER6svuMr2ClTvlYutHaTmCyHpB1HhtI9xtzs6cwF36jfGY/p4SHRWySVgrxRoMEDozC1s0GHH1TVvNcfq0NikuhsikCTqY9IYT9xspPcqVn7stROtVi/Ru3BAOM8kKhu40bZeV6sUcXH1HvD6+ZXY2S24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgo8aD96; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33D2C433F1;
	Wed, 21 Feb 2024 04:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708490550;
	bh=7qbv084Tw0jU0rG3Mycr9LtNeEo3/RiPxmKo2q2amKw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=fgo8aD96y1Rt8TWLVLeJmxBQqY0hvadB01t5JAanSrByjTRLqqtYY4TUhhv79v9TZ
	 QKCJUY/S171UQISoxjLQa1KTIhul1DIBmf5df8zo8O1636ivTA/Y3oEZa8LrCa2b2y
	 t8+LH8jFAOlQCSbbv4OG5yCNzldGsP+jAZW5hiFFvTauAKHnJb/hEshTRMGOnt4IVY
	 NIkH3IQYivZQRLHNlQ6NtuOVbkWGMzTSVnsQME7GRceXXiH4VzaUABEvGAGuKsWZmV
	 fAZUq1wtIskLPIxxWMdiAdhgVmnBx7IkPtb0fqzDn+hjqTMHasuOW4DkCMGnU7oIew
	 JkSP21K5LC6GA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8D0C7CE133F; Tue, 20 Feb 2024 20:42:29 -0800 (PST)
Date: Tue, 20 Feb 2024 20:42:29 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Feng Tang <feng.tang@intel.com>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
	Jin Wang <jin1.wang@intel.com>
Subject: Re: [PATCH v5] clocksource: Scale the max retry number of watchdog
 read according to CPU numbers
Message-ID: <c8986bdb-e3c0-41a1-b9ca-2229f9a6f2a1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240221030407.915927-1-feng.tang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221030407.915927-1-feng.tang@intel.com>

On Wed, Feb 21, 2024 at 11:04:07AM +0800, Feng Tang wrote:
> There was a bug on one 8-socket server that the TSC is wrongly marked
> as 'unstable' and disabled during boot time (reproduce rate is about
> every 120 rounds of reboot tests), with log:
> 
>     clocksource: timekeeping watchdog on CPU227: wd-tsc-wd excessive read-back delay of 153560ns vs. limit of 125000ns,
>     wd-wd read-back delay only 11440ns, attempt 3, marking tsc unstable
>     tsc: Marking TSC unstable due to clocksource watchdog
>     TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
>     sched_clock: Marking unstable (119294969739, 159204297)<-(125446229205, -5992055152)
>     clocksource: Checking clocksource tsc synchronization from CPU 319 to CPUs 0,99,136,180,210,542,601,896.
>     clocksource: Switched to clocksource hpet
> 
> The reason is for platform with lots of CPU, there are sporadic big or
> huge read latency of read watchog/clocksource during boot or when system
> is under stress work load, and the frequency and maximum value of the
> latency goes up with the increasing of CPU numbers. Current code already
> has logic to detect and filter such high latency case by reading 3 times
> of watchdog, and check the 2 deltas. Due to the randomness of the
> latency, there is a low possibility situation that the first delta
> (latency) is big, but the second delta is small and looks valid, which
> can escape from the check, and there is a 'max_cswd_read_retries' for
> retrying that check covering this case, whose default value is only 2
> and may be not enough for machines with huge number of CPUs.
> 
> So scale and enlarge the max retry number according to CPU number to
> better filter those latency noise for large systems, which has been
> verified fine in 4 days reboot test on the 8-socket machine.
> 
> Also as suggested by Thomas, remove parameter 'max_cswd_read_retries'
> which was originally introduced to cover this.
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Tested-by: Jin Wang <jin1.wang@intel.com>
> Tested-by: Paul E. McKenney <paulmck@kernel.org>
> Reviewed-by: Waiman Long <longman@redhat.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
> Changelog:
> 
>     since v4:
>       * Add a helper function to be shared by different files (Paul)
> 
>     since v3:
>       * Remove clocksource's module parameter 'max_cswd_read_retries' (Thomas)
>       * Use "ilog4" instead of ilog2 for max retry calculation, and
>         may be adjusted later (Paul)
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
> 
> 
>  Documentation/admin-guide/kernel-parameters.txt   |  6 ------
>  include/linux/clocksource.h                       | 13 ++++++++++++-
>  kernel/time/clocksource-wdtest.c                  | 13 +++++++------
>  kernel/time/clocksource.c                         |  9 ++++-----
>  tools/testing/selftests/rcutorture/bin/torture.sh |  2 +-
>  5 files changed, 24 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 31b3a25680d0..763e96dcf8b1 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -679,12 +679,6 @@
>  			loops can be debugged more effectively on production
>  			systems.
>  
> -	clocksource.max_cswd_read_retries= [KNL]
> -			Number of clocksource_watchdog() retries due to
> -			external delays before the clock will be marked
> -			unstable.  Defaults to two retries, that is,
> -			three attempts to read the clock under test.
> -
>  	clocksource.verify_n_cpus= [KNL]
>  			Limit the number of CPUs checked for clocksources
>  			marked with CLOCK_SOURCE_VERIFY_PERCPU that
> diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
> index 1d42d4b17327..13cf36fe27ac 100644
> --- a/include/linux/clocksource.h
> +++ b/include/linux/clocksource.h
> @@ -291,7 +291,18 @@ static inline void timer_probe(void) {}
>  #define TIMER_ACPI_DECLARE(name, table_id, fn)		\
>  	ACPI_DECLARE_PROBE_ENTRY(timer, name, table_id, 0, NULL, 0, fn)
>  
> -extern ulong max_cswd_read_retries;
> +static inline int clocksource_get_max_watchdog_retry(void)
> +{
> +	 /*
> +	 * When system is in boot phase or under heavy workload, there could
> +	 * be random big latency during clocksource/watchdog read, so add
> +	 * some retry to filter the noise latency. As the latency's frequency
> +	 * and maximum value goes up with the CPU numbers relatively, chose
> +	 * the max retry number according to CPU numbers.
> +	 */
> +	return (ilog2(num_online_cpus()) / 2 + 1);
> +}
> +
>  void clocksource_verify_percpu(struct clocksource *cs);
>  
>  #endif /* _LINUX_CLOCKSOURCE_H */
> diff --git a/kernel/time/clocksource-wdtest.c b/kernel/time/clocksource-wdtest.c
> index df922f49d171..2a5abda307e1 100644
> --- a/kernel/time/clocksource-wdtest.c
> +++ b/kernel/time/clocksource-wdtest.c
> @@ -105,7 +105,7 @@ static int wdtest_func(void *arg)
>  {
>  	unsigned long j1, j2;
>  	char *s;
> -	int i;
> +	int i, max_retries;
>  
>  	schedule_timeout_uninterruptible(holdoff * HZ);
>  
> @@ -139,18 +139,19 @@ static int wdtest_func(void *arg)
>  	WARN_ON_ONCE(time_before(j2, j1 + NSEC_PER_USEC));
>  
>  	/* Verify tsc-like stability with various numbers of errors injected. */
> -	for (i = 0; i <= max_cswd_read_retries + 1; i++) {
> -		if (i <= 1 && i < max_cswd_read_retries)
> +	max_retries = clocksource_get_max_watchdog_retry(); 
> +	for (i = 0; i <= max_retries + 1; i++) {
> +		if (i <= 1 && i < max_retries)
>  			s = "";
> -		else if (i <= max_cswd_read_retries)
> +		else if (i <= max_retries)
>  			s = ", expect message";
>  		else
>  			s = ", expect clock skew";
> -		pr_info("--- Watchdog with %dx error injection, %lu retries%s.\n", i, max_cswd_read_retries, s);
> +		pr_info("--- Watchdog with %dx error injection, %d retries%s.\n", i, max_retries, s);
>  		WRITE_ONCE(wdtest_ktime_read_ndelays, i);
>  		schedule_timeout_uninterruptible(2 * HZ);
>  		WARN_ON_ONCE(READ_ONCE(wdtest_ktime_read_ndelays));
> -		WARN_ON_ONCE((i <= max_cswd_read_retries) !=
> +		WARN_ON_ONCE((i <= max_retries) !=
>  			     !(clocksource_wdtest_ktime.flags & CLOCK_SOURCE_UNSTABLE));
>  		wdtest_ktime_clocksource_reset();
>  	}
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index 3052b1f1168e..7fcb8d06b7cd 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -210,9 +210,6 @@ void clocksource_mark_unstable(struct clocksource *cs)
>  	spin_unlock_irqrestore(&watchdog_lock, flags);
>  }
>  
> -ulong max_cswd_read_retries = 2;
> -module_param(max_cswd_read_retries, ulong, 0644);
> -EXPORT_SYMBOL_GPL(max_cswd_read_retries);
>  static int verify_n_cpus = 8;
>  module_param(verify_n_cpus, int, 0644);
>  
> @@ -227,8 +224,10 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
>  	unsigned int nretries;
>  	u64 wd_end, wd_end2, wd_delta;
>  	int64_t wd_delay, wd_seq_delay;
> +	int max_retries;
>  
> -	for (nretries = 0; nretries <= max_cswd_read_retries; nretries++) {
> +	max_retries = clocksource_get_max_watchdog_retry(); 
> +	for (nretries = 0; nretries <= max_retries; nretries++) {
>  		local_irq_disable();
>  		*wdnow = watchdog->read(watchdog);
>  		*csnow = cs->read(cs);
> @@ -240,7 +239,7 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
>  		wd_delay = clocksource_cyc2ns(wd_delta, watchdog->mult,
>  					      watchdog->shift);
>  		if (wd_delay <= WATCHDOG_MAX_SKEW) {
> -			if (nretries > 1 || nretries >= max_cswd_read_retries) {
> +			if (nretries > 1 || nretries >= max_retries) {
>  				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
>  					smp_processor_id(), watchdog->name, nretries);
>  			}
> diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
> index d5a0d8a33c27..bbac5f4b03d0 100755
> --- a/tools/testing/selftests/rcutorture/bin/torture.sh
> +++ b/tools/testing/selftests/rcutorture/bin/torture.sh
> @@ -567,7 +567,7 @@ then
>  	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 tsc=watchdog"
>  	torture_set "clocksourcewd-1" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 45s --configs TREE03 --kconfig "CONFIG_TEST_CLOCKSOURCE_WATCHDOG=y" --trust-make
>  
> -	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 clocksource.max_cswd_read_retries=1 tsc=watchdog"
> +	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 tsc=watchdog"
>  	torture_set "clocksourcewd-2" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 45s --configs TREE03 --kconfig "CONFIG_TEST_CLOCKSOURCE_WATCHDOG=y" --trust-make
>  
>  	# In case our work is already done...
> -- 
> 2.34.1
> 

