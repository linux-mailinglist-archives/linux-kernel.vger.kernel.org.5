Return-Path: <linux-kernel+bounces-49942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC138471D5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43C401C24F2B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667AC1468E6;
	Fri,  2 Feb 2024 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BA3I5Nrg"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680E147A4D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706883750; cv=none; b=EuKfcWbPog544xonChuTohDZRNLCAUowD0HNooPEZDpHkyP43/cA3Kd4PeNFrBTnsHSi87Uh89XWzYbG5pSFevdizB5GcRLZM8UbiuMFyaqycPsR2rfLpiue9SizN6obolNeM105dN0z80/6OKDl27/44M2obURBi7X2IqNtjp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706883750; c=relaxed/simple;
	bh=xwzklGrj7vVdUby+djemFWfj6zc/kYrnyKrVzBZRX1I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DPl7EW7VniF/I3uFqHYv72BcP6F8MXYc4uPuuhuVu2XpfnUq7HgjXfPmeq0Fst5Ca6Yyflk4OYhJ8NRviaVzRF+NzVzaalEdR9JadV6XjnsvTaUA26WKP4sUtBMd1zpn5HM9Bj3Bl1yA+UmPOGKmXrOl5327zYKWWy2EQifet70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BA3I5Nrg; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706883744; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=d4OqDX/cQzt1bcoYyaseDnrGw+jftOLJeybPAxyiH/c=;
	b=BA3I5NrgPrLwcLGgIRV2tY6uH2zizCOQqd2SvDuAoqDdAGcENyDp0Tmreod/po7MXPsXl2U2ysfPXPAmwZEiXujQlfh3clupGyDAClAHjT/zoKKgSc24QPOqkTbRK2bb9Fq55G5aECEnbGapM+0/3niD89AWOPTjtxbRHXwdhYw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W.xEuF7_1706883735;
Received: from 192.168.0.104(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W.xEuF7_1706883735)
          by smtp.aliyun-inc.com;
          Fri, 02 Feb 2024 22:22:24 +0800
Message-ID: <673881a4-3060-40ab-b1d2-72115f9df5f7@linux.alibaba.com>
Date: Fri, 2 Feb 2024 22:22:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitao Hu <yaoma@linux.alibaba.com>
Subject: Re: [PATCHv3 1/2] watchdog/softlockup: low-overhead detection of
 interrupt storm
To: Doug Anderson <dianders@chromium.org>
Cc: akpm@linux-foundation.org, pmladek@suse.com, kernelfans@gmail.com,
 liusong@linux.alibaba.com, linux-kernel@vger.kernel.org,
 yaoma@linux.alibaba.com
References: <20240131171738.35496-1-yaoma@linux.alibaba.com>
 <20240131171738.35496-2-yaoma@linux.alibaba.com>
 <CAD=FV=VOYo-OsjKwPQFuBHgB6Uk9E-nb3CiwKjj_yLtPDa7sYQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAD=FV=VOYo-OsjKwPQFuBHgB6Uk9E-nb3CiwKjj_yLtPDa7sYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/2/1 10:22, Doug Anderson wrote:
> Hi,
> 
> On Wed, Jan 31, 2024 at 9:17 AM Bitao Hu <yaoma@linux.alibaba.com> wrote:
>>
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
>>    ...
>>
>> This would be helpful in determining whether an interrupt storm has
>> occurred or in identifying the cause of the softlockup. The criteria for
>> determination are as follows:
>>    a. If the hardirq utilization is high, then interrupt storm should be
>>    considered and the root cause cannot be determined from the call tree.
>>    b. If the softirq utilization is high, then we could analyze the call
>>    tree but it may cannot reflect the root cause.
>>    c. If the system utilization is high, then we could analyze the root
>>    cause from the call tree.
>>
>> Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
>> ---
>>   kernel/watchdog.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 84 insertions(+)
> 
> Random high-level question: I'm trying to figure out exactly when your
> code will trigger. The only way it will trigger is if the timer
> interrupt is a higher priority than the storming interrupt. By this I
> don't mean that the timer will interrupt the storming one (it's not a
> nested interrupt), but that if both interrupts are currently asserted
> we'll service the timer first.
> 
> If the storming interrupt is always serviced before the timer
> interrupt then the softlockup code won't trigger at all. In that case
> we should detect a hard lockup and hopefully you've got the buddy
> detector enabled and pseudo-NMI turned on. Then hopefully we'll have
> actually interrupted the storming interrupt and it'll be on the
> callstack.
> 
> I just wanted to make sure I was understanding correctly. This is why
> you don't print the stats from watchdog_hardlockup_check() because
> they're not useful there, right?
Yes, you are right. The scenario I'm considering matches your
description. If the storming interrupt lead to a soft lockup, then it
will not be on the callstack. In this case, we need the stats.
> 
> 
>> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
>> index 81a8862295d6..046507be4eb5 100644
>> --- a/kernel/watchdog.c
>> +++ b/kernel/watchdog.c
>> @@ -23,6 +23,8 @@
>>   #include <linux/sched/debug.h>
>>   #include <linux/sched/isolation.h>
>>   #include <linux/stop_machine.h>
>> +#include <linux/kernel_stat.h>
>> +#include <linux/math64.h>
> 
> nit: instead of adding to the end, add these in sorted order. The
> includes we have now are _almost_ in sorted order. I'd add these
> between "init.h" and "module.h"
Sure, I will standardize the code.
> 
> 
>>   #include <asm/irq_regs.h>
>>   #include <linux/kvm_para.h>
>> @@ -441,6 +443,85 @@ static int is_softlockup(unsigned long touch_ts,
>>          return 0;
>>   }
>>
>> +#ifdef CONFIG_IRQ_TIME_ACCOUNTING
> 
> In v1 I think I suggested adding a new config. Even with your
> optimizations you've quoted this as taking up "237,568 bytes" of
> global storage when things are configured for the max number of CPUs.
> It feels like someone might not want that. Adding a new Kconfig knob
> shouldn't be a huge problem. Maybe you can have it default to "yes" if
> the max number of CPUs is <= 64 or 128 or something?
Sure, I will add a new config.
> 
> 
>> +#define NUM_STATS_GROUPS       5
>> +enum stats_per_group {
>> +       STATS_SYSTEM,
>> +       STATS_SOFTIRQ,
>> +       STATS_HARDIRQ,
>> +       STATS_IDLE,
>> +       NUM_STATS_PER_GROUP,
>> +};
>> +static enum cpu_usage_stat stats[NUM_STATS_PER_GROUP] = {
> 
> "static const", not just "static"
OK.
> 
> nit: maybe call this "tracked_stats" since "stats" is a bit of a
> generic name for a global.
Agree, it is clearer.
> 
> 
>> +       CPUTIME_SYSTEM,
>> +       CPUTIME_SOFTIRQ,
>> +       CPUTIME_IRQ,
>> +       CPUTIME_IDLE,
>> +};
>> +static DEFINE_PER_CPU(u16, cpustat_old[NUM_STATS_PER_GROUP]);
>> +static DEFINE_PER_CPU(u8, cpustat_utilization[NUM_STATS_GROUPS][NUM_STATS_PER_GROUP]);
>> +static DEFINE_PER_CPU(u8, cpustat_tail);
>> +
>> +/*
>> + * We don't need nanosecond resolution. A granularity of 16ms is
>> + * sufficient for our precision, allowing us to use u16 to store
>> + * cpustats, which will roll over roughly every ~1000 seconds.
>> + * 2^24 ~= 16 * 10^6
>> + */
>> +static u16 get_16bit_precision(u64 data)
> 
> nit: instead of "data", call it "data_ns"
OK.
> 
> 
>> +{
>> +       return data >> 24LL; /* 2^24ns ~= 16.8ms */
>> +}
>> +
>> +static void update_cpustat(void)
>> +{
>> +       u8 i;
> 
> FWIW, Andrew Morton (who will likely be the one landing this patch)
> was quoted in LWN [1] the other week saying that "i" should be an
> integer. :-P Making it an "int" won't make the code any less
> efficient.
> 
> [1] https://lwn.net/Articles/958417/
OK, I will use "int" here.
> 
> 
>> +       u16 old;
>> +       u8 utilization;
>> +       u8 tail = __this_cpu_read(cpustat_tail);
>> +       struct kernel_cpustat kcpustat;
>> +       u64 *cpustat = kcpustat.cpustat;
>> +       u16 sample_period_ms = get_16bit_precision(sample_period);
> 
> It's not really milliseconds, right? Maybe "sample_period_16"?
Agree, it is clearer.
> 
> 
>> +       kcpustat_cpu_fetch(&kcpustat, smp_processor_id());
>> +       for (i = STATS_SYSTEM; i < NUM_STATS_PER_GROUP; i++) {
> 
> nit: start i as 0 instead of assuming that STATS_SYSTEM is 0.
OK.
> 
> 
>> +               old = __this_cpu_read(cpustat_old[i]);
>> +               cpustat[stats[i]] = get_16bit_precision(cpustat[stats[i]]);
> 
> IMO make a local called "new" and store the 16-bit precision there.
> That's easier to read, gets rid of the cast below, and is probably
> more efficient (the compiler doesn't need to upcast the 16-bit value
> and store it in a 64-bit memory location).
Oh, that's interesting, I hadn't thought of that.
  ...oh, or maybe "new" is a
> reserved keyword? You could call them "old_stat_16" and "new_stat_16".
> 
> 
>> +               utilization = 100 * (u16)(cpustat[stats[i]] - old) / sample_period_ms;
> 
> Maybe slightly better to round, with:
> 
> utilization = DIV_ROUND_UP(100 * (new - old), sample_period_ms);
> 
> What do you think?
Agree, I will use your method.
> 
> 
>> +               __this_cpu_write(cpustat_utilization[tail][i], utilization);
>> +               __this_cpu_write(cpustat_old[i], cpustat[stats[i]]);
>> +       }
>> +       __this_cpu_write(cpustat_tail, (tail + 1) % NUM_STATS_GROUPS);
>> +}
>> +
>> +static void print_cpustat(void)
>> +{
>> +       u8 i, j;
>> +       u8 tail = __this_cpu_read(cpustat_tail);
>> +       u64 sample_period_second = sample_period;
>> +
>> +       do_div(sample_period_second, NSEC_PER_SEC);
>> +       /*
>> +        * We do not want the "watchdog: " prefix on every line,
>> +        * hence we use "printk" instead of "pr_crit".
>> +        */
>> +       printk(KERN_CRIT "CPU#%d Utilization every %llus during lockup:\n",
>> +               smp_processor_id(), sample_period_second);
>> +       for (j = STATS_SYSTEM, i = tail; j < NUM_STATS_GROUPS;
> 
> Here initting "j" to STATS_SYSTEM definitely doesn't make sense. Init to 0.
> 
> You could also make your loop easier to understand with just:
> 
> for (i = 0; i < NUM_STATS_GROUPS; i++) {
>    unsigned int group = (tail + i) % NUM_STATS_GROUPS;
>
Agree, it is easier to read.

> 
> -Doug

