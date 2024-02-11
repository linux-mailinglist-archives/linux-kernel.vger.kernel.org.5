Return-Path: <linux-kernel+bounces-60833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD584850A02
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06F051C20D10
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365E25B5D8;
	Sun, 11 Feb 2024 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="p6lUftJW"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979C21E88A
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707665794; cv=none; b=iHi1xTza7g1MclEBrYlB8+6YbYP2iECAAy2zS/0Ynsqx+JAXqwkeXNMPtKtHWIx2bo8ig5KOYLIgJmfKo3y8EcGqGlxspgBD5TRTxx395tZzsYyskFcdQvuc3yvmc1vcpGH9D0rGkqoC1Xp55uZEIFvfYVS8f4T8ZRla+2ouJKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707665794; c=relaxed/simple;
	bh=31RCNQrUHhDFdFdUJa9I2UTr1KGFfWdIavypZ+vgbQY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BP7V9AaRnvnRum1laRgG4DypgTlfMHv+1bRXJv1vMFnya2yX6RftT44ynQfla0bfqcWu/b7sECFqvI/obRhE+64uKZ+8kZIXaBtASMw6Ex9ULFMgHClyLRP3NTmeiB3iFYMzgApjWFFag8bmNifz7w4fenxwyKJtxeT7aprwySw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=p6lUftJW; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707665782; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=F1UTbpKvJiJKIyt/1OBU432hU5AW4ryhxmCrqRxeaOM=;
	b=p6lUftJWeEUpUCQmPx01DwotFhhzdEcH4db/UuBywVWdV5y98MpepBt70j9VrtC7pJgDl4u7gIVc+aPSzrvOm4WvuQ59KHgMvvyzWTJVwFgJVWNYTVidy2UFqqeOs+SOKkGS5PnRXGgFIaieu0FzdnyO3PVol23YZVHo/gj5MHc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W0QQ5OK_1707665744;
Received: from 192.168.0.104(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W0QQ5OK_1707665744)
          by smtp.aliyun-inc.com;
          Sun, 11 Feb 2024 23:36:22 +0800
Message-ID: <2261fef2-2b0a-429d-a349-88bfb7fd6ace@linux.alibaba.com>
Date: Sun, 11 Feb 2024 23:36:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitao Hu <yaoma@linux.alibaba.com>
Subject: Re: [PATCHv6 2/2] watchdog/softlockup: report the most frequent
 interrupts
To: Petr Mladek <pmladek@suse.com>
Cc: dianders@chromium.org, akpm@linux-foundation.org, kernelfans@gmail.com,
 liusong@linux.alibaba.com, linux-kernel@vger.kernel.org,
 yaoma@linux.alibaba.com
References: <20240208125426.70511-1-yaoma@linux.alibaba.com>
 <20240208125426.70511-3-yaoma@linux.alibaba.com> <ZcY5LLfQcHIkpll7@alley>
Content-Language: en-US
In-Reply-To: <ZcY5LLfQcHIkpll7@alley>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2024/2/9 22:39, Petr Mladek wrote:
> On Thu 2024-02-08 20:54:26, Bitao Hu wrote:
>> When the watchdog determines that the current soft lockup is due
>> to an interrupt storm based on CPU utilization, reporting the
>> most frequent interrupts could be good enough for further
>> troubleshooting.
>>
>> Below is an example of interrupt storm. The call tree does not
>> provide useful information, but we can analyze which interrupt
>> caused the soft lockup by comparing the counts of interrupts.
>>
>> [ 2987.488075] watchdog: BUG: soft lockup - CPU#9 stuck for 23s! [kworker/9:1:214]
>> [ 2987.488607] CPU#9 Utilization every 4s during lockup:
>> [ 2987.488941]  #1:   0% system,          0% softirq,   100% hardirq,     0% idle
>> [ 2987.489357]  #2:   0% system,          0% softirq,   100% hardirq,     0% idle
>> [ 2987.489771]  #3:   0% system,          0% softirq,   100% hardirq,     0% idle
>> [ 2987.490186]  #4:   0% system,          0% softirq,   100% hardirq,     0% idle
>> [ 2987.490601]  #5:   0% system,          0% softirq,   100% hardirq,     0% idle
>> [ 2987.491034] CPU#9 Detect HardIRQ Time exceeds 50%. Most frequent HardIRQs:
>> [ 2987.491493]  #1: 330985      irq#7(IPI)
>> [ 2987.491743]  #2: 5000        irq#10(arch_timer)
>> [ 2987.492039]  #3: 9           irq#91(nvme0q2)
>> [ 2987.492318]  #4: 3           irq#118(virtio1-output.12)
> 
> Nit: It might looks slightly better if it prints the last 5 HardIRQs ;-)
>       Maybe this version already does.
Yes, it can print the last 5 HardIRQs. And I ignore those HardIRQs with
a count of zero, so it can print between 1 to 5 HardIRQs.
> 
>> --- a/kernel/watchdog.c
>> +++ b/kernel/watchdog.c
>> @@ -412,13 +415,142 @@ static void print_cpustat(void)
>>   	}
>>   }
>>   
>> +#define HARDIRQ_PERCENT_THRESH		50
>> +#define NUM_HARDIRQ_REPORT		5
> 
> It actually creates array for 5 IRQ entries.
> 
>> +static DEFINE_PER_CPU(u32 *, hardirq_counts);
>> +static DEFINE_PER_CPU(int, actual_nr_irqs);
>> +struct irq_counts {
>> +	int irq;
>> +	u32 counts;
>> +};
>> +
>> +static void print_irq_counts(void)
>> +{
>> +	int i;
>> +	struct irq_desc *desc;
>> +	u32 counts_diff;
>> +	int local_nr_irqs = __this_cpu_read(actual_nr_irqs);
>> +	u32 *counts = __this_cpu_read(hardirq_counts);
>> +	struct irq_counts irq_counts_sorted[NUM_HARDIRQ_REPORT] = {
>> +		{-1, 0}, {-1, 0}, {-1, 0}, {-1, 0},
>> +	};
>> +
>> +	if (counts) {
>> +		for_each_irq_desc(i, desc) {
> 
> I would use:
> 
> 		for (i = 0; i < local_nr_irqs; i++) {
The number of HardIRQs has the potential to grow at runtime. And I
want to count these newly added HardIRQs. Therefore, I use
"for_each_irq_desc" here.

> It does not make sense to process IRQs where "counts_diff = 0;"
> 
>> +
> 
>> +			/*
>> +			 * We need to bounds-check in case someone on a different CPU
>> +			 * expanded nr_irqs.
>> +			 */
>> +			if (desc->kstat_irqs) {
>> +				counts_diff = *this_cpu_ptr(desc->kstat_irqs);
>> +				if (i < local_nr_irqs)
>> +					counts_diff -= counts[i];
>> +			} else {
>> +				counts_diff = 0;
> 
> And it would allow to remove this branch.
Agree.
> 
>> +			}
>> +			tabulate_irq_count(irq_counts_sorted, i, counts_diff,
>> +					   NUM_HARDIRQ_REPORT);
>> +		}
> 
> Please, add an empty line here.
> 
> Empty lines helps to read the code. For example, they help to make
> clear that a top-level comment describes a particular block of code.
> Or they helps to see where { } blocks end.
> 
> Long blobs of core are hard to read for me. Maybe, I suffer with some
> level of dislexia but I know many more people who prefer this.
> 
> Heh, I would personally add empty lines on several other locations.
> 
>> +		/*
>> +		 * We do not want the "watchdog: " prefix on every line,
>> +		 * hence we use "printk" instead of "pr_crit".
>> +		 */
>> +		printk(KERN_CRIT "CPU#%d Detect HardIRQ Time exceeds %d%%. Most frequent HardIRQs:\n",
>> +		       smp_processor_id(), HARDIRQ_PERCENT_THRESH);
> 
> for example here
> 
>> +		for (i = 0; i < NUM_HARDIRQ_REPORT; i++) {
>> +			if (irq_counts_sorted[i].irq == -1)
>> +				break;
> 
> here
> 
>> +			desc = irq_to_desc(irq_counts_sorted[i].irq);
>> +			if (desc && desc->action)
>> +				printk(KERN_CRIT "\t#%u: %-10u\tirq#%d(%s)\n",
>> +				       i + 1, irq_counts_sorted[i].counts,
>> +				       irq_counts_sorted[i].irq, desc->action->name);
>> +			else
>> +				printk(KERN_CRIT "\t#%u: %-10u\tirq#%d\n",
>> +				       i + 1, irq_counts_sorted[i].counts,
>> +				       irq_counts_sorted[i].irq);
>> +		}
> 
> end here ;-)
> 
>> +		/*
>> +		 * If the hardirq time is less than HARDIRQ_PERCENT_THRESH% in the last
>> +		 * sample_period, then we suspect the interrupt storm might be subsiding.
>> +		 */
>> +		if (!need_counting_irqs())
>> +			stop_counting_irqs();
>> +	}
>> +}
OK, I will add empty lines for easier readability.
>> +
>> @@ -522,6 +654,18 @@ static int is_softlockup(unsigned long touch_ts,
>>   			 unsigned long now)
>>   {
>>   	if ((watchdog_enabled & WATCHDOG_SOFTOCKUP_ENABLED) && watchdog_thresh) {
>> +		/*
>> +		 * If period_ts has not been updated during a sample_period, then
>> +		 * in the subsequent few sample_periods, period_ts might also not
>> +		 * be updated, which could indicate a potential softlockup. In
>> +		 * this case, if we suspect the cause of the potential softlockup
>> +		 * might be interrupt storm, then we need to count the interrupts
>> +		 * to find which interrupt is storming.
>> +		 */
>> +		if (time_after_eq(now, period_ts + get_softlockup_thresh() / 5) &&
> 
> (get_softlockup_thresh() / 5) might be replaced by sample_period.
> 
The "sample_period" is measured in nanoseconds and is represented
by a "u64" type. However, the "time_after_eq" here expects seconds
as a "u32" type, hence I refrained from using "sample_period" in
this instance.

> Also it looks to strict. I would allow some small delay, e.g. 1 ms.
This is second-level precision, and "now" is obtained by
"running_clock() >> 30LL", so it's not strict here.
> 
>> +		    need_counting_irqs())
>> +			start_counting_irqs();
>> +
>>   		/* Warn about unreasonable delays. */
>>   		if (time_after(now, period_ts + get_softlockup_thresh()))
>>   			return now - touch_ts;
> 
> Great work!
Thanks.

Best Regards,
Bitao

