Return-Path: <linux-kernel+bounces-46315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A17D8843DD1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56245293DD3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684B56E2A0;
	Wed, 31 Jan 2024 11:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YaP5S3Lk"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E34D6EB4A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 11:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706699323; cv=none; b=BNxU9h/UT06cuP3sI7SvEGJwRuGiSgEmQBNLowh0b+B3kx3634Jr2zZa9Wk4NZJuiRkr2UTMdFijQvW/kIGp+nBxCc9ZB2Exx8RlekbmIDZ+4fQR0HTDbnyouRfkVy6TbCtuxr0TVNb4229Qo3XSWxOQ7OO/cqRVruJK2QN4W0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706699323; c=relaxed/simple;
	bh=HY58CsLPzA1lVXcWNzUEh1Thv5YQ2zaWtkVZl330PLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dAimET/9gptKn0A79jIvItbzGiUY2t3wdMuWBz5pEvG+K78QveUzeEmllfm8trS0BXL9iNp8I75V/Tb3YDEUcxT11WNfBlzniNj3XbpP40HZ4nh0ll/3MZe+wfuwf8vVGuGWdcFoxbkAWBkcbLBBIuytoXVZAlzkocckm9yrRQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YaP5S3Lk; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706699318; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BtDpBlYrJT19LLzhatnciKlO7Bh7yEt22vXAZTHidUc=;
	b=YaP5S3LkYjY87l8CaimLEua3xQlOWmg0Kr7xasXQZnEfbQ3co7a7ipguUXEHIMj5DolB3HIoOlNBsoJ2nGXl4vJx8P95Oe9vHNghglDXilH2/iJ/JK7v1rlOD6d+oqSuTwEn4EIsho5LRXRSEgQinZS449v9mP5yl2htpVC19K0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W.jNxow_1706699316;
Received: from 30.178.67.117(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W.jNxow_1706699316)
          by smtp.aliyun-inc.com;
          Wed, 31 Jan 2024 19:08:37 +0800
Message-ID: <b5d88f82-6048-4ca9-becb-3e2c68acbaaf@linux.alibaba.com>
Date: Wed, 31 Jan 2024 19:08:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/2] watchdog/softlockup: report the most frequent
 interrupts
Content-Language: en-US
To: Liu Song <liusong@linux.alibaba.com>, dianders@chromium.org,
 akpm@linux-foundation.org, pmladek@suse.com, lecopzer.chen@mediatek.com,
 kernelfans@gmail.com
Cc: linux-kernel@vger.kernel.org, yaoma@linux.alibaba.com
References: <20240130074744.45759-1-yaoma@linux.alibaba.com>
 <20240130074744.45759-3-yaoma@linux.alibaba.com>
 <ad353e3e-4f9d-42a0-834f-39cfc128453f@linux.alibaba.com>
From: Bitao Hu <yaoma@linux.alibaba.com>
In-Reply-To: <ad353e3e-4f9d-42a0-834f-39cfc128453f@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/1/31 09:50, Liu Song wrote:
> 
> 在 2024/1/30 15:47, Bitao Hu 写道:
>> When the watchdog determines that the current soft lockup is due
>> to an interrupt storm based on CPU utilization, reporting the
>> most frequent interrupts could be good enough for further
>> troubleshooting.
>>
>> Below is an example of interrupt storm. The call tree does not
>> provide useful information, but we can analyze which interrupt
>> caused the soft lockup by comparing the counts of interrupts.
>>
>> [ 2987.488075] watchdog: BUG: soft lockup - CPU#9 stuck for 23s! 
>> [kworker/9:1:214]
>> [ 2987.488607] CPU#9 Utilization every 4s during lockup:
>> [ 2987.488941]  #1:   0% system,          0% softirq,   100% 
>> hardirq,     0% idle
>> [ 2987.489357]  #2:   0% system,          0% softirq,   100% 
>> hardirq,     0% idle
>> [ 2987.489771]  #3:   0% system,          0% softirq,   100% 
>> hardirq,     0% idle
>> [ 2987.490186]  #4:   0% system,          0% softirq,   100% 
>> hardirq,     0% idle
>> [ 2987.490601]  #5:   0% system,          0% softirq,   100% 
>> hardirq,     0% idle
>> [ 2987.491034] CPU#9 Detect HardIRQ Time exceeds 50%. Most frequent 
>> HardIRQs:
>> [ 2987.491493]  #1: 330985      irq#7(IPI)
>> [ 2987.491743]  #2: 5000        irq#10(arch_timer)
>> [ 2987.492039]  #3: 9           irq#91(nvme0q2)
>> [ 2987.492318]  #4: 3           irq#118(virtio1-output.12)
>> ...
>> [ 2987.492728] Call trace:
>> [ 2987.492729]  __do_softirq+0xa8/0x364
>>
>> Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
>> ---
>>   kernel/watchdog.c | 150 ++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 150 insertions(+)
>>
>> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
>> index 0efe9604c3c2..38fb18e17d71 100644
>> --- a/kernel/watchdog.c
>> +++ b/kernel/watchdog.c
>> @@ -25,6 +25,9 @@
>>   #include <linux/stop_machine.h>
>>   #include <linux/kernel_stat.h>
>>   #include <linux/math64.h>
>> +#include <linux/irq.h>
>> +#include <linux/bitops.h>
>> +#include <linux/irqdesc.h>
>>   #include <asm/irq_regs.h>
>>   #include <linux/kvm_para.h>
>> @@ -431,11 +434,15 @@ void touch_softlockup_watchdog_sync(void)
>>       __this_cpu_write(watchdog_report_ts, SOFTLOCKUP_DELAY_REPORT);
>>   }
>> +static void set_potential_softlockup(unsigned long now, unsigned long 
>> touch_ts);
>> +
>>   static int is_softlockup(unsigned long touch_ts,
>>                unsigned long period_ts,
>>                unsigned long now)
>>   {
>>       if ((watchdog_enabled & WATCHDOG_SOFTOCKUP_ENABLED) && 
>> watchdog_thresh) {
>> +        /* Softlockup may occur in the current period */
>> +        set_potential_softlockup(now, period_ts);
>>           /* Warn about unreasonable delays. */
>>           if (time_after(now, period_ts + get_softlockup_thresh()))
>>               return now - touch_ts;
>> @@ -457,6 +464,8 @@ static enum cpu_usage_stat 
>> idx_to_stat[NUM_STATS_PER_GROUP] = {
>>       CPUTIME_SYSTEM, CPUTIME_SOFTIRQ, CPUTIME_IRQ, CPUTIME_IDLE
>>   };
>> +static void print_hardirq_counts(void);
>> +
>>   static void update_cpustat(void)
>>   {
>>       u8 i;
>> @@ -504,10 +513,150 @@ static void print_cpustat(void)
>>               utilization[i][STATS_SYSTEM], 
>> utilization[i][STATS_SOFTIRQ],
>>               utilization[i][STATS_HARDIRQ], utilization[i][STATS_IDLE]);
>>       }
>> +    print_hardirq_counts();
>> +}
>> +
>> +#define HARDIRQ_PERCENT_THRESH        50
>> +#define NUM_HARDIRQ_REPORT        5
>> +static DECLARE_BITMAP(softlockup_hardirq_cpus, CONFIG_NR_CPUS);
>> +static DEFINE_PER_CPU(u32 *, hardirq_counts);
>> +
>> +static void find_counts_top(u32 *irq_counts, int *irq, u32 
>> perirq_counts, int perirq_id, int range)
>> +{
>> +    unsigned int i, j;
>> +
>> +    for (i = 0; i < range; i++) {
>> +        if (perirq_counts > irq_counts[i]) {
>> +            for (j = range - 1; j > i; j--) {
>> +                irq_counts[j] = irq_counts[j - 1];
>> +                irq[j] = irq[j - 1];
>> +            }
>> +            irq_counts[j] = perirq_counts;
>> +            irq[j] = perirq_id;
>> +            break;
>> +        }
>> +    }
>> +}
>> +
>> +/*
>> + * If the proportion of time spent handling irq exceeds 
>> HARDIRQ_PERCENT_THRESH%
>> + * during sample_period, then it is necessary to record the counts of 
>> each irq.
>> + */
>> +static inline bool need_record_irq_counts(int type)
>> +{
>> +    int tail = this_cpu_read(cpustat_tail);
>> +    u8 utilization;
>> +
>> +    if (--tail == -1)
>> +        tail = 4;
>> +    utilization = this_cpu_read(cpustat_utilization[tail][type]);
>> +    return utilization > HARDIRQ_PERCENT_THRESH;
>>   }
>> +
>> +/*
>> + * Mark softlockup as potentially caused by hardirq
>> + */
>> +static void set_potential_softlockup_hardirq(void)
>> +{
>> +    u32 i;
>> +    u32 *counts = __this_cpu_read(hardirq_counts);
>> +    int cpu = smp_processor_id();
>> +    struct irq_desc *desc;
>> +
>> +    if (!need_record_irq_counts(STATS_HARDIRQ))
>> +        return;
>> +
>> +    if (!test_bit(cpu, softlockup_hardirq_cpus)) {
>> +        counts = kmalloc_array(nr_irqs, sizeof(u32), GFP_ATOMIC);
>> +        if (!counts)
>> +            return;
>> +        for_each_irq_desc(i, desc) {
>> +            if (!desc)
>> +                continue;
>> +            counts[i] = desc->kstat_irqs ?
>> +                *this_cpu_ptr(desc->kstat_irqs) : 0;
>> +        }
>> +        __this_cpu_write(hardirq_counts, counts);
>> +        set_bit(cpu, softlockup_hardirq_cpus);
>> +    }
>> +}
>> +
>> +static void clear_potential_softlockup_hardirq(void)
>> +{
>> +    u32 *counts = __this_cpu_read(hardirq_counts);
>> +    int cpu = smp_processor_id();
>> +
>> +    if (test_bit(cpu, softlockup_hardirq_cpus)) {
>> +        kfree(counts);
>> +        counts = NULL;
>> +        __this_cpu_write(hardirq_counts, counts);
>> +        clear_bit(cpu, softlockup_hardirq_cpus);
>> +    }
>> +}
>> +
>> +/*
>> + * Mark that softlockup may occur
>> + */
>> +static void set_potential_softlockup(unsigned long now, unsigned long 
>> period_ts)
>> +{
>> +    if (time_after_eq(now, period_ts + get_softlockup_thresh() / 5))
>> +        set_potential_softlockup_hardirq();
>> +}
>> +
>> +static void clear_potential_softlockup(void)
>> +{
>> +    clear_potential_softlockup_hardirq();
>> +}
>> +
>> +static void print_hardirq_counts(void)
>> +{
>> +    u32 i;
>> +    struct irq_desc *desc;
>> +    u32 counts_diff;
>> +    u32 *counts = __this_cpu_read(hardirq_counts);
>> +    int cpu = smp_processor_id();
>> +    u32 hardirq_counts_top[NUM_HARDIRQ_REPORT] = {0, 0, 0, 0, 0};
>> +    int hardirq_top[NUM_HARDIRQ_REPORT] = {-1, -1, -1, -1, -1};
> "hardirq_counts_top" and "hardirq_top" seem like two members of a struct,
> working together to record the most suspicious irq, so wouldn't using a 
> struct make it clearer?
OK, I will define a struct.
>> +
>> +    if (test_bit(cpu, softlockup_hardirq_cpus)) {
>> +        /* Find the top NUM_HARDIRQ_REPORT most frequent interrupts */
>> +        for_each_irq_desc(i, desc) {
>> +            if (!desc)
>> +                continue;
>> +            counts_diff = desc->kstat_irqs ?
>> +                *this_cpu_ptr(desc->kstat_irqs) - counts[i] : 0;
>> +            find_counts_top(hardirq_counts_top, hardirq_top,
>> +                    counts_diff, i, NUM_HARDIRQ_REPORT);
>> +        }
>> +        /*
>> +         * We do not want the "watchdog: " prefix on every line,
>> +         * hence we use "printk" instead of "pr_crit".
>> +         */
>> +        printk(KERN_CRIT "CPU#%d Detect HardIRQ Time exceeds %d%%. 
>> Most frequent HardIRQs:\n",
>> +            smp_processor_id(), HARDIRQ_PERCENT_THRESH);
>> +        for (i = 0; i < NUM_HARDIRQ_REPORT; i++) {
>> +            if (hardirq_top[i] == -1)
>> +                break;
>> +            desc = irq_to_desc(hardirq_top[i]);
>> +            if (desc && desc->action)
>> +                printk(KERN_CRIT "\t#%u: %-10u\tirq#%d(%s)\n",
>> +                    i+1, hardirq_counts_top[i],
>> +                    hardirq_top[i], desc->action->name);
>> +            else
>> +                printk(KERN_CRIT "\t#%u: %-10u\tirq#%d\n",
>> +                    i+1, hardirq_counts_top[i],
>> +                    hardirq_top[i]);
>> +        }
>> +        if (!need_record_irq_counts(STATS_HARDIRQ))
>> +            clear_potential_softlockup_hardirq();
>> +    }
>> +}
>> +
>>   #else
>>   static inline void update_cpustat(void) { }
>>   static inline void print_cpustat(void) { }
>> +static inline void set_potential_softlockup(unsigned long now, 
>> unsigned long period_ts) { }
>> +static inline void clear_potential_softlockup(void) { }
>>   #endif
>>   /* watchdog detector functions */
>> @@ -525,6 +674,7 @@ static DEFINE_PER_CPU(struct cpu_stop_work, 
>> softlockup_stop_work);
>>   static int softlockup_fn(void *data)
>>   {
>>       update_touch_ts();
>> +    clear_potential_softlockup();
>>       complete(this_cpu_ptr(&softlockup_completion));
>>       return 0;

