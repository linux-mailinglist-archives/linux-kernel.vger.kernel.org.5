Return-Path: <linux-kernel+bounces-40322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AEA83DE7C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A4CC286BCA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C151DDE7;
	Fri, 26 Jan 2024 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+oXjJZO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCD41DDC8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 16:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706286000; cv=none; b=O5sVpUwmO28D2hKX4bF2mdJsZjIN54NW4fo34nfpziAH0N/UeCLT2AecObDn7xoUalVbMTs7lEUWlOyrKnf23rvDVo//EmaF6gv5p6lYYkKdOM88XsLgqiAuZBey6QQiWHOupmFD8pc8y332B+mck/4nTt2H93R7QTaYbgzxhE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706286000; c=relaxed/simple;
	bh=ObQrPGSmVxw2aihVzMhP5iX/zPR0WDH9gRE98WUbGT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/uDjet7ea90PXnrfvWbgfBetdOpC6V1qKG1x5b0VzqbACSLzAW98ajAHjNtJA4QkXfsAYjvKwfN2myUkJNCg50xAAJTqVdIa5GXixlLFdNqe7E3qItCQQq7Bze3EPn7PgZqN0ZH0BIbZn1HStqwtBBwdqF82BNh6F2f+iwbtqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D+oXjJZO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706285997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=093JZIeaWcsNCK/8OwyUI7Am1/3YeTyMzulZFP2S+WE=;
	b=D+oXjJZOMo7Nx6DZo/mTQ5mv7bp4arEYI71hLvjWXNhG80yTjAZzksXAnnohMHlbDu5JYr
	1xJRtOYawaJn//nFMmAiwEUtFLRJppJYNP9/tTQ77h8oIpvnVu63KezvqJqvpguSmnBK7P
	FZjlzQ0mzc0suLNBT4HBFwV1Sw7tmqU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-NTNozoegP4-sJI2MzfISZw-1; Fri, 26 Jan 2024 11:19:52 -0500
X-MC-Unique: NTNozoegP4-sJI2MzfISZw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8ABC486F166;
	Fri, 26 Jan 2024 16:19:51 +0000 (UTC)
Received: from [10.22.8.210] (unknown [10.22.8.210])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0DEF451D5;
	Fri, 26 Jan 2024 16:19:51 +0000 (UTC)
Message-ID: <ebeff3e5-cd57-49ac-86d3-6ebe3c53fa40@redhat.com>
Date: Fri, 26 Jan 2024 11:19:50 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource: Scale the max retry number of watchdog read
 according to CPU numbers
Content-Language: en-US
To: Feng Tang <feng.tang@intel.com>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Jin Wang <jin1.wang@intel.com>
References: <20240126091250.79985-1-feng.tang@intel.com>
 <3b3d9499-dc7a-4ea0-9615-526940f5fcf2@paulmck-laptop>
 <ZbO3bN3WEUvejRBp@feng-clx.sh.intel.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZbO3bN3WEUvejRBp@feng-clx.sh.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 1/26/24 08:45, Feng Tang wrote:
> Hi Paul,
>
> On Fri, Jan 26, 2024 at 04:27:19AM -0800, Paul E. McKenney wrote:
>> On Fri, Jan 26, 2024 at 05:12:50PM +0800, Feng Tang wrote:
>>> There was a bug on one 8-socket server that the TSC is wrongly marked as
>>> 'unstable' and disabled during boot time. (reproduce rate is every 120
>>> rounds of reboot tests), with log:
>>>
>>>      clocksource: timekeeping watchdog on CPU227: wd-tsc-wd excessive read-back delay of 153560ns vs. limit of 125000ns,
>>>      wd-wd read-back delay only 11440ns, attempt 3, marking tsc unstable
>>>      tsc: Marking TSC unstable due to clocksource watchdog
>>>      TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
>>>      sched_clock: Marking unstable (119294969739, 159204297)<-(125446229205, -5992055152)
>>>      clocksource: Checking clocksource tsc synchronization from CPU 319 to CPUs 0,99,136,180,210,542,601,896.
>>>      clocksource: Switched to clocksource hpet
>>>
>>> The reason is for platform with lots of CPU, there are sporadic big or huge
>>> read latency of read watchog/clocksource during boot or when system is under
>>> stress work load, and the frequency and maximum value of the latency goes up
>>> with the increasing of CPU numbers. Current code already has logic to detect
>>> and filter such high latency case by reading 3 times of watchdog, and check
>>> the 2 deltas. Due to the randomness of the latency, there is a low possibility
>>> situation that the first delta (latency) is big, but the second delta is small
>>> and looks valid, which can escape from the check, and there is a
>>> 'max_cswd_read_retries' for retrying that check covering this case, whose
>>> default value is only 2 and may be not enough for machines with huge number
>>> of CPUs.
>>>
>>> So scale and enlarge the max retry number according to CPU number to better
>>> filter those latency noise on large system, which has been verified fine in
>>> 4 days and 670 rounds of reboot test on the 8-socket machine.
>>>
>>> Tested-by: Jin Wang <jin1.wang@intel.com>
>>> Signed-off-by: Feng Tang <feng.tang@intel.com>
>>> ---
>>>   kernel/time/clocksource.c | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>>
>>> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
>>> index c108ed8a9804..f15283101906 100644
>>> --- a/kernel/time/clocksource.c
>>> +++ b/kernel/time/clocksource.c
>>> @@ -226,6 +226,15 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
>>>   	u64 wd_end, wd_end2, wd_delta;
>>>   	int64_t wd_delay, wd_seq_delay;
>>>   
>>> +	/*
>>> +	 * If no user changes the default value, scale the retry threshold
>>> +	 * according to CPU numbers. As per test, the more CPU a platform has,
>>> +	 * the bigger read latency is found during boot time or under stress
>>> +	 * work load. Increase the try nubmer to reduce false alarms.
>>> + 	 */
>>> +	if (max_cswd_read_retries == 2)
>> I like the self-adjusting behavior!
> Thanks!
>   
>> But why not make max_cswd_read_retries be a long (instead of a ulong)
>> defaulting to -1.  Then when someone sets it to a specific positive
>> value, they get exactly that value, while leaving it -1 gets the default
>> CPU-scaling behavior.  Zero and other negative values should get a
>> warning in order to reserve the for possible future use.
> Good suggestions!
>
>> I also suggest doing the adjustment at boot time, for example, using
>> an early_initcall().  That way the test code also sees the scaled value.
> I also thought about doing the adjustment once in early boot phase
> using num_possible_cpus(), but gave up as that parameters could be
> changed runtime using sysfs's module parameter interface, and cpu
> runtime hotplugging.
>
> Since the watchdog timer only happens (if not skipped) every 500 ms,
> how about doing the ilog2 math everytime, like below:
>
> diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
> index 1d42d4b17327..9104bdecf34e 100644
> --- a/include/linux/clocksource.h
> +++ b/include/linux/clocksource.h
> @@ -291,7 +291,7 @@ static inline void timer_probe(void) {}
>   #define TIMER_ACPI_DECLARE(name, table_id, fn)		\
>   	ACPI_DECLARE_PROBE_ENTRY(timer, name, table_id, 0, NULL, 0, fn)
>   
> -extern ulong max_cswd_read_retries;
> +extern long max_cswd_read_retries;
>   void clocksource_verify_percpu(struct clocksource *cs);
>   
>   #endif /* _LINUX_CLOCKSOURCE_H */
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index c108ed8a9804..867bb36e6dad 100644
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
> @@ -225,8 +225,17 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
>   	unsigned int nretries;
>   	u64 wd_end, wd_end2, wd_delta;
>   	int64_t wd_delay, wd_seq_delay;
> +	long max_retries = max_cswd_read_retries;
> +	
> +	if (max_cswd_read_retries <= 0) {
> +		if (max_cswd_read_retries != -1)
> +			pr_warn_once("max_cswd_read_retries has been set a invalid number: %d\n",
> +				max_cswd_read_retries);
>   
> -	for (nretries = 0; nretries <= max_cswd_read_retries; nretries++) {
> +		max_retries = ilog2(num_online_cpus()) + 1;
> +	} 		
> +
> +	for (nretries = 0; nretries <= max_retries; nretries++) {
>   		local_irq_disable();
>   		*wdnow = watchdog->read(watchdog);
>   		*csnow = cs->read(cs);
> @@ -238,7 +247,7 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
>   		wd_delay = clocksource_cyc2ns(wd_delta, watchdog->mult,
>   					      watchdog->shift);
>   		if (wd_delay <= WATCHDOG_MAX_SKEW) {
> -			if (nretries > 1 || nretries >= max_cswd_read_retries) {
> +			if (nretries > 1 || nretries >= max_retries) {
>   				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
>   					smp_processor_id(), watchdog->name, nretries);
>   			}

The max_cswd_read_retries value is also used in 
kernel/time/clocksource-wdtest.c. You will have to apply similar logic 
to clocksource-wdtest.c if it is not done once in early_init.

Cheers,
Longman



