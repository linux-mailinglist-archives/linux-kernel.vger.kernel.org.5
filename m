Return-Path: <linux-kernel+bounces-60832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86306850A01
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1F8A281CD2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A80B5B670;
	Sun, 11 Feb 2024 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="amriTfH/"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7DA5B5A6
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707665757; cv=none; b=IMSlz/JEXTgsmyLLr4yhylbq/mlVLp8GcY2/JwjRzr+vIo+VbV/W58ZfNykePkSnJ6DVY8DI+GMwuyehJRDVTOsymCsTgJ5PrrZdBWWWMMzTMAhj38ceMs0jVmKDGAk4MzqSg0GY+cd+kVnGcofa5kUGieOf6e4E9nIiBe95l/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707665757; c=relaxed/simple;
	bh=O05siLkq2RwyTTjYcyonNpTva1vWq8ICugGqol5VSQE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZH2/J2w3trHB4umwYCw4jej/o058sUNfdflGk4Ec524ZhpY9HpJvJEPBDZZIKD/94aVtmdKSwxcXai3oO1t9Q9BKp6gwpAinXRAj5wRdSydFRNzGdrTBSB6wVyrT1NCkgZquDRX25p1AsSfCYwKK3b9M4K+FoNygCGSJ7roPEOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=amriTfH/; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707665745; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=5lRWlAjmQVJnMZwnFRfHRt6A+J4fRJyqRFoeNDqlkVA=;
	b=amriTfH/EePZGiyn+qX5te7qtB3IPsxnZdoOC3bqTUiBEDIakAvYsGpDsCNdHoXp4lmOUONgRjtAtdQz9FWq1YaoGvVZyzQyH19ZTjABRfpc2/eVQAxUn/ErdG6iqdWRQ/IoXJd/ISjOUMFhzfpaTsv0UHa5sjFMrJQKZ4dRhbs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W0QQ5Nj_1707665743;
Received: from 192.168.0.104(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W0QQ5Nj_1707665743)
          by smtp.aliyun-inc.com;
          Sun, 11 Feb 2024 23:35:44 +0800
Message-ID: <2a615ecf-c26f-4710-87df-c02f1e489d19@linux.alibaba.com>
Date: Sun, 11 Feb 2024 23:35:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitao Hu <yaoma@linux.alibaba.com>
Subject: Re: [PATCHv6 1/2] watchdog/softlockup: low-overhead detection of
 interrupt
To: Petr Mladek <pmladek@suse.com>
Cc: dianders@chromium.org, akpm@linux-foundation.org, kernelfans@gmail.com,
 liusong@linux.alibaba.com, linux-kernel@vger.kernel.org,
 yaoma@linux.alibaba.com
References: <20240208125426.70511-1-yaoma@linux.alibaba.com>
 <20240208125426.70511-2-yaoma@linux.alibaba.com> <ZcYqIOR17BHJyHbx@alley>
Content-Language: en-US
In-Reply-To: <ZcYqIOR17BHJyHbx@alley>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 2024/2/9 21:35, Petr Mladek wrote:
> Hi,
> 
> I am sorry for jouning this game so late. But honestly, it went
> forward too quickly. A good practice is to wait a week before
> sending new version so that you give a chance more people
> to provide some feedback.
> 
> The only exception might be when you know exactly who could
> review it because the area in not interesting for anyone else.
> But this is typicall not the case for kernel core code.
Thanks for your reminder, I will be mindful of the pace.
> 
> 
> On Thu 2024-02-08 20:54:25, Bitao Hu wrote:
>> The following softlockup is caused by interrupt storm, but it cannot be
>> identified from the call tree. Because the call tree is just a snapshot
>> and doesn't fully capture the behavior of the CPU during the soft lockup.
>>    watchdog: BUG: soft lockup - CPU#28 stuck for 23s! [fio:83921]
>>    ...
>>    Call trace:
>>      __do_softirq+0xa0/0x37c
>>      __irq_exit_rcu+0x108/0x140
>>      irq_exit+0x14/0x20
>>      __handle_domain_irq+0x84/0xe0
>>      gic_handle_irq+0x80/0x108
>>      el0_irq_naked+0x50/0x58
>>
>> Therefore，I think it is necessary to report CPU utilization during the
>> softlockup_thresh period (report once every sample_period, for a total
>> of 5 reportings), like this:
>>    watchdog: BUG: soft lockup - CPU#28 stuck for 23s! [fio:83921]
>>    CPU#28 Utilization every 4s during lockup:
>>      #1: 0% system, 0% softirq, 100% hardirq, 0% idle
>>      #2: 0% system, 0% softirq, 100% hardirq, 0% idle
>>      #3: 0% system, 0% softirq, 100% hardirq, 0% idle
>>      #4: 0% system, 0% softirq, 100% hardirq, 0% idle
>>      #5: 0% system, 0% softirq, 100% hardirq, 0% idle
> 
> I like this. IMHO, it might be really useful.
> 
>> --- a/kernel/watchdog.c
>> +++ b/kernel/watchdog.c
>> @@ -333,6 +335,92 @@ __setup("watchdog_thresh=", watchdog_thresh_setup);
>>   
>>   static void __lockup_detector_cleanup(void);
>>   
>> +#ifdef CONFIG_SOFTLOCKUP_DETECTOR_INTR_STORM
>> +#define NUM_STATS_GROUPS	5
> 
> It would be nice to synchronize this with the hardcoded 5 in:
> 
> static void set_sample_period(void)
> {
> 	/*
> 	 * convert watchdog_thresh from seconds to ns
> 	 * the divide by 5 is to give hrtimer several chances (two
> 	 * or three with the current relation between the soft
> 	 * and hard thresholds) to increment before the
> 	 * hardlockup detector generates a warning
> 	 */
> 	sample_period = get_softlockup_thresh() * ((u64)NSEC_PER_SEC / 5);
OK, I've had the same thought.
> 
> For exmaple, define and use the following in both situations:
> 
> #define NUM_SAMPLE_PERIODS	5
>
>> +enum stats_per_group {
>> +	STATS_SYSTEM,
>> +	STATS_SOFTIRQ,
>> +	STATS_HARDIRQ,
>> +	STATS_IDLE,
>> +	NUM_STATS_PER_GROUP,
>> +};
>> +
>> +static const enum cpu_usage_stat tracked_stats[NUM_STATS_PER_GROUP] = {
>> +	CPUTIME_SYSTEM,
>> +	CPUTIME_SOFTIRQ,
>> +	CPUTIME_IRQ,
>> +	CPUTIME_IDLE,
>> +};
>> +
>> +static DEFINE_PER_CPU(u16, cpustat_old[NUM_STATS_PER_GROUP]);
>> +static DEFINE_PER_CPU(u8, cpustat_util[NUM_STATS_GROUPS][NUM_STATS_PER_GROUP]);
>> +static DEFINE_PER_CPU(u8, cpustat_tail);
>> +
>> +/*
>> + * We don't need nanosecond resolution. A granularity of 16ms is
>> + * sufficient for our precision, allowing us to use u16 to store
>> + * cpustats, which will roll over roughly every ~1000 seconds.
>> + * 2^24 ~= 16 * 10^6
>> + */
>> +static u16 get_16bit_precision(u64 data_ns)
>> +{
>> +	return data_ns >> 24LL; /* 2^24ns ~= 16.8ms */
> 
> I would personally use
> 
>      delta_ns >> 20  /* 2^20ns ~= 1ms */
> 
> to make it easier for debugging by a human. It would support
> the sample period up to 65s which might be enough.
> 
> But I do not resirt on it. ">> 24" provides less granularity
> but it supports longer sample periods.
I considered using ">>20" as it provides more intuitive granularity,
but I wanted to support longer sample periods. After weighing the
options, I chose ">>24".
> 
>> +static void print_cpustat(void)
>> +{
>> +	int i, group;
>> +	u8 tail = __this_cpu_read(cpustat_tail);
>> +	u64 sample_period_second = sample_period;
>> +
>> +	do_div(sample_period_second, NSEC_PER_SEC);
>> +	/*
>> +	 * We do not want the "watchdog: " prefix on every line,
>> +	 * hence we use "printk" instead of "pr_crit".
>> +	 */
>> +	printk(KERN_CRIT "CPU#%d Utilization every %llus during lockup:\n",
>> +	       smp_processor_id(), sample_period_second);
>> +	for (i = 0; i < NUM_STATS_GROUPS; i++) {
> 
> This starts with the 1st group in the array. Is it the oldest one?
> It should take into account cpustat_tail.
Yes, It starts with the oldest one. After "update_cpustat" is completed,
"cpustat_tail" points to the oldest one. Here, I start accessing the 
data pointed to by the "cpustat_tail".
> 
> 
>> +		group = (tail + i) % NUM_STATS_GROUPS;
>> +		printk(KERN_CRIT "\t#%d: %3u%% system,\t%3u%% softirq,\t"
>> +			"%3u%% hardirq,\t%3u%% idle\n", i + 1,
>> +			__this_cpu_read(cpustat_util[group][STATS_SYSTEM]),
>> +			__this_cpu_read(cpustat_util[group][STATS_SOFTIRQ]),
>> +			__this_cpu_read(cpustat_util[group][STATS_HARDIRQ]),
>> +			__this_cpu_read(cpustat_util[group][STATS_IDLE]));
>> +	}
>> +}
>> +
> 

Best Regards,
Bitao

