Return-Path: <linux-kernel+bounces-38179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49ED483BC09
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D63471F23736
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DC21B94A;
	Thu, 25 Jan 2024 08:31:16 +0000 (UTC)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AEA18039
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706171476; cv=none; b=ICCmR6+13HSvxSYBqfkJiV8y9C431uzbBg2jGCsCR5v9Su+edwp7Th29oFUBJk2ymNeZOl0V+9MOwMR25MGuok2I9Iom840cApbcs28bBCcO6/wh2yXbG/v4Ul4IOSceIwNZ2REWSwPCZghdpkQuspvu6f52H1fSpoJcS15cV0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706171476; c=relaxed/simple;
	bh=m/7DGf1do0jsDUZDYzBxB/LrtDCJMUPG0S+IefJqibw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GGaZhuVJU+UBnU5NEJsc2A4K3JG5g3TkCcAxUQjytvSkMQDI+w+OhkaFJRDTiVJxW6IIoVR8KNJV59px7/rXQ8j3rNcYDSQ1FvBogZtI93vpKqr+2KtUyd407LztyEl7tJ0x0k1xiScEsFK9IJsuUJRziVgt9oWW5dvbI9ioCD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W.JldC2_1706171467;
Received: from 30.178.67.122(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W.JldC2_1706171467)
          by smtp.aliyun-inc.com;
          Thu, 25 Jan 2024 16:31:09 +0800
Message-ID: <8c7ba29d-0e12-412f-b88f-347de237d1ad@linux.alibaba.com>
Date: Thu, 25 Jan 2024 16:31:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] watchdog/softlockup: low-overhead detection of
 interrupt storm
Content-Language: en-US
To: Doug Anderson <dianders@chromium.org>
Cc: akpm@linux-foundation.org, pmladek@suse.com, tglx@linutronix.de,
 maz@kernel.org, liusong@linux.alibaba.com, linux-kernel@vger.kernel.org,
 yaoma@linux.alibaba.com
References: <20240123121223.22318-1-yaoma@linux.alibaba.com>
 <20240123121223.22318-2-yaoma@linux.alibaba.com>
 <CAD=FV=WEEQeKX=ec3Gr-8CKs2K0MaWN3V0-0yOsuret0qcB_AA@mail.gmail.com>
From: Bitao Hu <yaoma@linux.alibaba.com>
In-Reply-To: <CAD=FV=WEEQeKX=ec3Gr-8CKs2K0MaWN3V0-0yOsuret0qcB_AA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/1/25 08:19, Doug Anderson wrote:
> Hi,
> 
> On Tue, Jan 23, 2024 at 4:12 AM Bitao Hu <yaoma@linux.alibaba.com> wrote:
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
>>      #1: 0.0% system, 0.0% softirq, 100.0% hardirq, 0.0% idle
>>      #2: 0.0% system, 0.0% softirq, 100.0% hardirq, 0.0% idle
>>      #3: 0.0% system, 0.0% softirq, 100.0% hardirq, 0.0% idle
>>      #4: 0.0% system, 0.0% softirq, 100.0% hardirq, 0.0% idle
>>      #5: 0.0% system, 0.0% softirq, 100.0% hardirq, 0.0% idle
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
> 
> Just to set the tone: this sounds like a great idea! I've found myself
> wanting something like this for a long time but I've never sat down to
> try to code up a mechanism. I have review comments below, but mostly
> it's just details. IMO the idea is definitely something we want to
> land.
Thanks for your support of this idea.
> 
> 
>> Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
>> ---
>>   kernel/watchdog.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 58 insertions(+)
>>
>> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
>> index 81a8862295d6..9fad10e0a147 100644
>> --- a/kernel/watchdog.c
>> +++ b/kernel/watchdog.c
>> @@ -23,6 +23,8 @@
>>   #include <linux/sched/debug.h>
>>   #include <linux/sched/isolation.h>
>>   #include <linux/stop_machine.h>
>> +#include <linux/kernel_stat.h>
>> +#include <linux/math64.h>
>>
>>   #include <asm/irq_regs.h>
>>   #include <linux/kvm_para.h>
>> @@ -441,6 +443,58 @@ static int is_softlockup(unsigned long touch_ts,
>>          return 0;
>>   }
>>
>> +#ifdef CONFIG_IRQ_TIME_ACCOUNTING
>> +static DEFINE_PER_CPU(u64, cpustat_old[NR_STATS]);
>> +static DEFINE_PER_CPU(u64, cpustat_diff[5][NR_STATS]);
>> +static DEFINE_PER_CPU(int, cpustat_tail);
> 
> The above is potentially a lot of memory. On some configs we allow up
> to 8192 CPUs and you're storing (NR_STATS * 6) u64s per CPU plus
> another int per CPU . NR_STATS can be up to 11 currently, so if I did
> my math right then that's
> 
> 8 * 8192 * 11 * 6 + 4 * 8192 = 4,358,144 bytes (!) That's probably not OK.
> 
> In theory you only need 4 stats (plus the total) instead of 11. If you
> do that plus the "old" then that would give you (8 * 8192 * 5 * 6 + 4
> * 8192) = 1,998,848 bytes. That's still a lot, but at least less.
> ...so at the very least you should only store the fields you need.
> 
> Given the amount of potential space at stake, it's probably worth
> optimizing this to something smaller than u64 as well. It feels like
> it would be easy to use u32. You only need diffs here and it doesn't
> seem like it would be hard to figure out how to use 32-bits, even if
> you have the drop a bit of granularity.
> 
> It feels like you could even go down to 8-bits per stat, though. You
> don't _really_ need such accurate percentages, right? Does it really
> matter if you have 99.4%? It seems like just saying 99% would be fine.
> Just do the math here and store the integral percentage per stat you
> care about. The numbers 0 - 100 can be stored in 8 bits.
> 
Thanks for your detailed analysis and optimization of memory 
consumption. I indeed hadn't considered this point, and I will
update it in v2.
> Combining that all together, I guess you could do this (untested):
> 
> 1. Get the current stats and right shift them all by 10 and convert
> them to 32-bit. This gives you (roughly) microseconds which will roll
> over roughly every ~4000 seconds. That seems about right, though I
> guess it's possible to do more and see if we can squeeze into 16 bits.
> 
> 2. Sum up all 11 of the stats to get a total. This should still fit
> into 32-bits.

> 
> 3. Do the math to get the integral percentages and store those in the tail slot.
> 
I'm a bit confused, why is there a need to sum up all 11 of the stats to
get a total? I calculate the percentage using sample_period.
> 4. Store the 4 stats you care about plus the total (all 32-bits) in
> "cpustat_old".
> 
> If I've got that right, your definitions should be able to be:
> 
> #define NUM_OLD_STATS_GROUPS  5
> #define NUM_STATS_PER_GROUP 4
> static DEFINE_PER_CPU(u32, cpustat_old[NUM_STATS_PER_GROUP + 1]);
> static DEFINE_PER_CPU(u8,
> cpustat_utilization[NUM_OLD_STATS][NUM_STATS_PER_GROUP]);
> static DEFINE_PER_CPU(u8, cpustat_tail);
> 
> With the maximum number of CPUs, that's now this, if I got my math right.
> 
> 4 * 8192 * 5 + 1 * 8192 * 5 * 4 + 1 * 8192 = 335,872 bytes.
> 
> That's a lot less, but still a lot. I'd be interested to hear other
> opinions, but it's probably worth a Kconfig knob.
> 
> 
>> +static void update_cpustat(void)
>> +{
>> +       u64 *old = this_cpu_ptr(cpustat_old);
>> +       u64 (*diff)[NR_STATS] = this_cpu_ptr(cpustat_diff);
>> +       int tail = this_cpu_read(cpustat_tail), i;
> 
> nit: Please define "i" on its own line. It looks weird the way you have it here.
Sure.
> 
>> +       struct kernel_cpustat kcpustat;
>> +       u64 *cpustat = kcpustat.cpustat;
>> +
>> +       kcpustat_cpu_fetch(&kcpustat, smp_processor_id());
>> +       for (i = 0; i < NR_STATS; i++) {
>> +               diff[tail][i] = cpustat[i] - old[i];
>> +               old[i] = cpustat[i];
>> +       }
>> +       this_cpu_write(cpustat_tail, (tail + 1) % 5);
>> +}
>> +
>> +static void print_cpustat(void)
>> +{
>> +       int i, j, k;
>> +       u64 a[5][NR_STATS], b[5][NR_STATS];
>> +       u64 (*diff)[NR_STATS] = this_cpu_ptr(cpustat_diff);
>> +       int tail = this_cpu_read(cpustat_tail);
>> +       u32 period_us = sample_period / 1000;
>> +
>> +       for (i = 0; i < 5; i++) {
>> +               for (j = 0; j < NR_STATS; j++) {
>> +                       a[i][j] = 100 * (diff[i][j] / 1000);
>> +                       b[i][j] = 10 * do_div(a[i][j], period_us);
>> +                       do_div(b[i][j], period_us);
>> +               }
>> +       }
>> +       printk(KERN_CRIT "CPU#%d Utilization every %us during lockup:\n",
>> +               smp_processor_id(), period_us/1000000);
>> +       for (k = 0, i = tail; k < 5; k++, i = (i + 1) % 5) {
>> +               printk(KERN_CRIT "\t#%d: %llu.%llu%% system,\t%llu.%llu%% softirq,\t"
>> +                       "%llu.%llu%% hardirq,\t%llu.%llu%% idle\n", k+1,
>> +                       a[i][CPUTIME_SYSTEM], b[i][CPUTIME_SYSTEM],
>> +                       a[i][CPUTIME_SOFTIRQ], b[i][CPUTIME_SOFTIRQ],
>> +                       a[i][CPUTIME_IRQ], b[i][CPUTIME_IRQ],
>> +                       a[i][CPUTIME_IDLE], b[i][CPUTIME_IDLE]);
> 
> As per your response to Liu Song, I understand why you're using
> "printk" instead of pr_crit(), but it deserves a comment.
Sure, I will add a comment here.

