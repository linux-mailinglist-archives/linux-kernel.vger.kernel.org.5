Return-Path: <linux-kernel+bounces-41876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F09183F918
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD812822B3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECAB2E64E;
	Sun, 28 Jan 2024 18:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DsNLIaaH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5DC2E631
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 18:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706465739; cv=none; b=Tlp8o/oXZFskE2Y1c620cNJ0bxwuQc0w3j/3m/WTgXL/MX1Udi/RWFl5evtNlVZdpgo+qEX6+njykzhDBN0+sWy2Cb2OeguTepaq7kzt49rwIywCsJGvZVs17Tn2wRWd1fXy5XjxC470i5QlhT1sULXfBJZxsNFX4PbHoxSPhqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706465739; c=relaxed/simple;
	bh=J3uNCS29mMt2uKHbpMxx3/wDBR3UwLuRkZmMji/YYfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JnDtpPJR5YHLyJ//z+++W1xmcqHZrJ/TRaO2bGc3+bCesKf3NnkqNUQhj2lMBoTPoQ0r2qsehmJK8YXzq991VNm1GCGNik52VDOvwmW7OZGIbFyBNA9FVlSXsDuAYJvbUn9B8zrK18x4Kayi9Owmw6yv0o7N0utBRWTc5Nh+GEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DsNLIaaH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706465736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fcbObUkScnl11KwbXw5gr+Yu5nHweNvfDxQF8KtaT5k=;
	b=DsNLIaaHdQGUIg2bBAb5QpAr6fnuoWzR9CMILopEygF35KcnLdsT/oOyK9W9EcVgcb2Cn1
	EyYqCVL3zoiki6eGFTB/50zyaf/HWuK4X9+QYK7ZG3dfGRYjZrylLYtb8GqsZw38gwe+x6
	HcuTEO484FhY82umD+25g6fRVLdN6yY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-LSzHogioNNGq3v8esnKiaw-1; Sun, 28 Jan 2024 13:15:32 -0500
X-MC-Unique: LSzHogioNNGq3v8esnKiaw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19F5685A58B;
	Sun, 28 Jan 2024 18:15:32 +0000 (UTC)
Received: from [10.22.8.80] (unknown [10.22.8.80])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 83484492BC6;
	Sun, 28 Jan 2024 18:15:31 +0000 (UTC)
Message-ID: <9ca4d7de-d022-4a5b-b114-3ffe5f4b4bd1@redhat.com>
Date: Sun, 28 Jan 2024 13:15:31 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clocksource: Scale the max retry number of watchdog
 read according to CPU numbers
Content-Language: en-US
To: Feng Tang <feng.tang@intel.com>, John Stultz <jstultz@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>,
 linux-kernel@vger.kernel.org, paulmck@kernel.org,
 Peter Zijlstra <peterz@infradead.org>
Cc: Jin Wang <jin1.wang@intel.com>
References: <20240128143143.3021280-1-feng.tang@intel.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240128143143.3021280-1-feng.tang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9


On 1/28/24 09:31, Feng Tang wrote:
> There was a bug on one 8-socket server that the TSC is wrongly marked as
> 'unstable' and disabled during boot time. (reproduce rate is every 120
> rounds of reboot tests), with log:
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
> filter those latency noise on large system, which has been verified fine in
> 4 days and 670 rounds of reboot test on the 8-socket machine.
>
> Also add sanity check for user input value for 'max_cswd_read_retries', and
> provide a general helper for getting this max retry number as suggested by
> Paul and Waiman.
>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Tested-by: Jin Wang <jin1.wang@intel.com>
> ---
> Changelog:
>
>      since v1:
>        * Add santity check for user input value of 'max_cswd_read_retries'
>          and a helper function for getting max retry nubmer (Paul)
>        * Apply the same logic to watchdog test code (Waiman)
>
>   include/linux/clocksource.h      |  2 +-
>   kernel/time/clocksource-wdtest.c | 12 +++++++-----
>   kernel/time/clocksource.c        | 26 +++++++++++++++++++++-----
>   3 files changed, 29 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
> index 1d42d4b17327..8d84d2f79622 100644
> --- a/include/linux/clocksource.h
> +++ b/include/linux/clocksource.h
> @@ -291,7 +291,7 @@ static inline void timer_probe(void) {}
>   #define TIMER_ACPI_DECLARE(name, table_id, fn)		\
>   	ACPI_DECLARE_PROBE_ENTRY(timer, name, table_id, 0, NULL, 0, fn)
>   
> -extern ulong max_cswd_read_retries;
> +long clocksource_max_watchdog_read_retries(void);
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
> index c108ed8a9804..00e359c80822 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -208,9 +208,8 @@ void clocksource_mark_unstable(struct clocksource *cs)
>   	spin_unlock_irqrestore(&watchdog_lock, flags);
>   }
>   
> -ulong max_cswd_read_retries = 2;
> -module_param(max_cswd_read_retries, ulong, 0644);
> -EXPORT_SYMBOL_GPL(max_cswd_read_retries);
> +static long max_cswd_read_retries = -1;
> +module_param(max_cswd_read_retries, long, 0644);
>   static int verify_n_cpus = 8;
>   module_param(verify_n_cpus, int, 0644);
>   
> @@ -220,13 +219,30 @@ enum wd_read_status {
>   	WD_READ_SKIP
>   };
>   
> +long clocksource_max_watchdog_read_retries(void)
> +{
> +	long max_retries = max_cswd_read_retries;
> +
> +	if (max_cswd_read_retries <= 0) {
> +		/* santity check for user input value */
> +		if (max_cswd_read_retries != -1)
> +			pr_warn_once("max_cswd_read_retries has been set a invalid number: %ld\n",
> +				max_cswd_read_retries);
> +
> +		max_retries = ilog2(num_online_cpus()) + 1;
> +	}
> +	return max_retries;
> +}

Should you add 
"EXPORT_SYMBOL_GPL(clocksource_max_watchdog_read_retries)" since 
clocksource-wdtest.c is likely to be in a kernel module? Alternatively, 
you can make clocksource_max_watchdog_read_retries() an inline function 
in a header file and keep the max_cswd_read_retries export.

Cheers,
Longman


