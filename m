Return-Path: <linux-kernel+bounces-45551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06000843247
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 292621C24595
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC884C6F;
	Wed, 31 Jan 2024 00:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iP5Ko6Zs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18674A28
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706662433; cv=none; b=As3MaBhvja1KaRfwen62RBEd7VZE7JKZblPCygvtYBw9y+wn1KIv60dygji6JORiQa0tHwRRhmmRaaJqIXd36jU9HQh/NiLIECm6Vmxv+tj5cZGBrPh/24GYdvS01w046xSPFqmDaW57K9wL1Vt+N/PMXQtS/eXjFPnXK1I04aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706662433; c=relaxed/simple;
	bh=Qxo+qi+FDzb+n6Z3r747BARH7jN3rTAQ2j7txbt/9fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kebKgc1EeVZrZilZvzbM4hE0ZC5tPikJdTfWkae//dqceSyu2jT2Zn0ptCSkFYFuuz3rIt9NXUl/fe4hd3jBBW1KRXazA/h8nrSx6eETU4RFk9lFdOTHuc3Jm3+MoiZiTqJ61XhQFcVYqboEZGgFl7z/ycJo4NirvUBLpoDZCZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iP5Ko6Zs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706662429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GQbPQeKKAs5zSj5SO5Z+FeS+Aas1FRacPY1/uVZiJfY=;
	b=iP5Ko6ZsFIkdPZu/lClTTvGOPTh27U+KeyzpMsA9fWawp7EEgVf90EnT+jsTHewvKw1pW4
	aEQjW1ODZ2ngYikD6lgIkUEpRoKdIET4WwySrASkQX4hpP7+R+y9CVVNOaDVp9BmjB3+O7
	q4oZ8g3ylGg5DcyvNcSGDbZhKaZptLY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-8kcgnXMGPCSXSjMlhFI9tw-1; Tue,
 30 Jan 2024 19:53:46 -0500
X-MC-Unique: 8kcgnXMGPCSXSjMlhFI9tw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 704E41C05148;
	Wed, 31 Jan 2024 00:53:45 +0000 (UTC)
Received: from [10.22.8.207] (unknown [10.22.8.207])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EB7BD157;
	Wed, 31 Jan 2024 00:53:44 +0000 (UTC)
Message-ID: <f3f9db02-f81f-4992-8a18-8e2b2046013c@redhat.com>
Date: Tue, 30 Jan 2024 19:53:44 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] clocksource: Scale the max retry number of watchdog
 read according to CPU numbers
Content-Language: en-US
To: Feng Tang <feng.tang@intel.com>, John Stultz <jstultz@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>,
 paulmck@kernel.org, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org
Cc: Jin Wang <jin1.wang@intel.com>
References: <20240129134505.961208-1-feng.tang@intel.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240129134505.961208-1-feng.tang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 1/29/24 08:45, Feng Tang wrote:
> There was a bug on one 8-socket server that the TSC is wrongly marked as
> 'unstable' and disabled during boot time (reproduce rate is about every
> 120 rounds of reboot tests), with log:
>
>      clocksource: timekeeping watchdog on CPU227: wd-tsc-wd excessive read-back delay of 153560ns vs. limit of 125000ns,
>      wd-wd read-back delay only 11440ns, attempt 3, marking tsc unstable
>      tsc: Marking TSC unstable due to clocksource watchdog
>      TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
>      sched_clock: Marking unstable (119294969739, 159204297)<-(125446229205, -5992055152)
>      clocksource: Checking clocksource tsc synchronization from CPU 319 to CPUs 0,99,136,180,210,542,601,896.
>      clocksource: Switched to clocksource hpet
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
> ---
> Changelog:
>
>      since v2:
>        * Fix the unexported symbol of helper function being used by
>          kernel module issue (Waiman)
>
>      since v1:
>        * Add santity check for user input value of 'max_cswd_read_retries'
>          and a helper function for getting max retry nubmer (Paul)
>        * Apply the same logic to watchdog test code (Waiman)
>
>   include/linux/clocksource.h      | 18 +++++++++++++++++-
>   kernel/time/clocksource-wdtest.c | 12 +++++++-----
>   kernel/time/clocksource.c        | 10 ++++++----
>   3 files changed, 30 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
> index 1d42d4b17327..0483f7dd66a3 100644
> --- a/include/linux/clocksource.h
> +++ b/include/linux/clocksource.h
> @@ -291,7 +291,23 @@ static inline void timer_probe(void) {}
>   #define TIMER_ACPI_DECLARE(name, table_id, fn)		\
>   	ACPI_DECLARE_PROBE_ENTRY(timer, name, table_id, 0, NULL, 0, fn)
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
>   void clocksource_verify_percpu(struct clocksource *cs);
>   
>   #endif /* _LINUX_CLOCKSOURCE_H */
> diff --git a/kernel/time/clocksource-wdtest.c b/kernel/time/clocksource-wdtest.c
> index df922f49d171..c70cea3c44a1 100644
> --- a/kernel/time/clocksource-wdtest.c
> +++ b/kernel/time/clocksource-wdtest.c
> @@ -106,6 +106,7 @@ static int wdtest_func(void *arg)
>   	unsigned long j1, j2;
>   	char *s;
>   	int i;
> +	long max_retries;
>   
>   	schedule_timeout_uninterruptible(holdoff * HZ);
>   
> @@ -139,18 +140,19 @@ static int wdtest_func(void *arg)
>   	WARN_ON_ONCE(time_before(j2, j1 + NSEC_PER_USEC));
>   
>   	/* Verify tsc-like stability with various numbers of errors injected. */
> -	for (i = 0; i <= max_cswd_read_retries + 1; i++) {
> -		if (i <= 1 && i < max_cswd_read_retries)
> +	max_retries = clocksource_max_watchdog_read_retries();
> +	for (i = 0; i <= max_retries + 1; i++) {
> +		if (i <= 1 && i < max_retries)
>   			s = "";
> -		else if (i <= max_cswd_read_retries)
> +		else if (i <= max_retries)
>   			s = ", expect message";
>   		else
>   			s = ", expect clock skew";
> -		pr_info("--- Watchdog with %dx error injection, %lu retries%s.\n", i, max_cswd_read_retries, s);
> +		pr_info("--- Watchdog with %dx error injection, %ld retries%s.\n", i, max_retries, s);
>   		WRITE_ONCE(wdtest_ktime_read_ndelays, i);
>   		schedule_timeout_uninterruptible(2 * HZ);
>   		WARN_ON_ONCE(READ_ONCE(wdtest_ktime_read_ndelays));
> -		WARN_ON_ONCE((i <= max_cswd_read_retries) !=
> +		WARN_ON_ONCE((i <= max_retries) !=
>   			     !(clocksource_wdtest_ktime.flags & CLOCK_SOURCE_UNSTABLE));
>   		wdtest_ktime_clocksource_reset();
>   	}
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index c108ed8a9804..2e5a1d6c6712 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -208,8 +208,8 @@ void clocksource_mark_unstable(struct clocksource *cs)
>   	spin_unlock_irqrestore(&watchdog_lock, flags);
>   }
>   
> -ulong max_cswd_read_retries = 2;
> -module_param(max_cswd_read_retries, ulong, 0644);
> +long max_cswd_read_retries = -1;
> +module_param(max_cswd_read_retries, long, 0644);
>   EXPORT_SYMBOL_GPL(max_cswd_read_retries);
>   static int verify_n_cpus = 8;
>   module_param(verify_n_cpus, int, 0644);
> @@ -225,8 +225,10 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
>   	unsigned int nretries;
>   	u64 wd_end, wd_end2, wd_delta;
>   	int64_t wd_delay, wd_seq_delay;
> +	long max_retries;
>   
> -	for (nretries = 0; nretries <= max_cswd_read_retries; nretries++) {
> +	max_retries = clocksource_max_watchdog_read_retries();
> +	for (nretries = 0; nretries <= max_retries; nretries++) {
>   		local_irq_disable();
>   		*wdnow = watchdog->read(watchdog);
>   		*csnow = cs->read(cs);
> @@ -238,7 +240,7 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
>   		wd_delay = clocksource_cyc2ns(wd_delta, watchdog->mult,
>   					      watchdog->shift);
>   		if (wd_delay <= WATCHDOG_MAX_SKEW) {
> -			if (nretries > 1 || nretries >= max_cswd_read_retries) {
> +			if (nretries > 1 || nretries >= max_retries) {
>   				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
>   					smp_processor_id(), watchdog->name, nretries);
>   			}
Reviewed-by: Waiman Long <longman@redhat.com>


