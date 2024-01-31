Return-Path: <linux-kernel+bounces-46310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86826843DC6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEB5C1F2B988
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770B66A030;
	Wed, 31 Jan 2024 11:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aNUqu+5x"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F36369DED
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 11:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706699181; cv=none; b=N2Jr1ZbElWIAZkKwpAHre6sG6vtFj4k8JkwPkc5jIrkYmbLFJSGqS8t6DbYsPu3Fj55tedkyHmJasz+E3DW4DwLQCtdDDVrNBH/gyQbE0qCRDKy5UI8wbX+HO12LVm66RqU+eoW2lPBxQ2aBOPgcvQuw8S0ZVCf07kciBTRmffE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706699181; c=relaxed/simple;
	bh=fPiyArmTKkYNXHeG7Eyo/mNrdvMXpwd7bk1SUBxXaHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XAII7qZ5mukD7hcUrb5eXZ+BoxQfIgAIJeaC+1C1/d/JM3ClLq6s5+iWfTsin1G1Em7mwfsLSf3LelLmT/5OruUhG1ypPNN+K6Ze+PM98LCViVtVP1zzK5fhpmxv7YYp9fD9Ppr3gh4oJcNmg3uR+l/Opu3D6PZ1jv/T06mJvTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aNUqu+5x; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706699170; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bERsmjJlZkBhEyNdZe8lJXPZFO71xd8HzILhH6dqpgM=;
	b=aNUqu+5xLpBhtS9hRrsRTIG3EMJ4pITWET38ODufMzkdkznc/W4J/p1C3B2EPJMRC4hu3xl2L1TjQp5UhJ2+Yo0877f9sjZmG1IzeiGA0OGpw6a5XaWuV31l5NJCARXgML2yE5MqP8n4lVszqI0+mVR6OSCkzzjYfhPjwIU2bS4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.jNws5_1706699168;
Received: from 30.178.67.117(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W.jNws5_1706699168)
          by smtp.aliyun-inc.com;
          Wed, 31 Jan 2024 19:06:09 +0800
Message-ID: <42d0e3f4-39e0-4404-87d9-7df89f8b8c0c@linux.alibaba.com>
Date: Wed, 31 Jan 2024 19:06:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/2] watchdog/softlockup: low-overhead detection of
 interrupt storm
Content-Language: en-US
To: Liu Song <liusong@linux.alibaba.com>, dianders@chromium.org,
 akpm@linux-foundation.org, pmladek@suse.com, kernelfans@gmail.com
Cc: linux-kernel@vger.kernel.org
References: <20240130074744.45759-1-yaoma@linux.alibaba.com>
 <20240130074744.45759-2-yaoma@linux.alibaba.com>
 <f6525b03-0864-4bd3-b083-3532f0042745@linux.alibaba.com>
From: Bitao Hu <yaoma@linux.alibaba.com>
In-Reply-To: <f6525b03-0864-4bd3-b083-3532f0042745@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/1/31 09:19, Liu Song wrote:
> 
> 在 2024/1/30 15:47, Bitao Hu 写道:
>> The following softlockup is caused by interrupt storm, but it cannot be
>> identified from the call tree. Because the call tree is just a snapshot
>> and doesn't fully capture the behavior of the CPU during the soft lockup.
>>    watchdog: BUG: soft lockup - CPU#28 stuck for 23s! [fio:83921]
>>    ...
>>    Call trace:
>>      __do_softirq+0xa0/0x37c
>>      __irq_exit_rcu+0x108/0x140
>>      irq_exit+0x14/0x20
>>      __handle_domain_irq+0x84/0xe0
>>      gic_handle_irq+0x80/0x108
>>      el0_irq_naked+0x50/0x58
>>
>> Therefore，I think it is necessary to report CPU utilization during the
>> softlockup_thresh period (report once every sample_period, for a total
>> of 5 reportings), like this:
>>    watchdog: BUG: soft lockup - CPU#28 stuck for 23s! [fio:83921]
>>    CPU#28 Utilization every 4s during lockup:
>>      #1: 0% system, 0% softirq, 100% hardirq, 0% idle
>>      #2: 0% system, 0% softirq, 100% hardirq, 0% idle
>>      #3: 0% system, 0% softirq, 100% hardirq, 0% idle
>>      #4: 0% system, 0% softirq, 100% hardirq, 0% idle
>>      #5: 0% system, 0% softirq, 100% hardirq, 0% idle
>>    ...
>>
>> This would be helpful in determining whether an interrupt storm has
>> occurred or in identifying the cause of the softlockup. The criteria for
>> determination are as follows:
>>    a. If the hardirq utilization is high, then interrupt storm should be
>>    considered and the root cause cannot be determined from the call tree.
>>    b. If the softirq utilization is high, then we could analyze the call
>>    tree but it may cannot reflect the root cause.
>>    c. If the system utilization is high, then we could analyze the root
>>    cause from the call tree.
>>
>> Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
>> ---
>>   kernel/watchdog.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 72 insertions(+)
>>
>> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
>> index 81a8862295d6..0efe9604c3c2 100644
>> --- a/kernel/watchdog.c
>> +++ b/kernel/watchdog.c
>> @@ -23,6 +23,8 @@
>>   #include <linux/sched/debug.h>
>>   #include <linux/sched/isolation.h>
>>   #include <linux/stop_machine.h>
>> +#include <linux/kernel_stat.h>
>> +#include <linux/math64.h>
>>   #include <asm/irq_regs.h>
>>   #include <linux/kvm_para.h>
>> @@ -441,6 +443,73 @@ static int is_softlockup(unsigned long touch_ts,
>>       return 0;
>>   }
>> +#ifdef CONFIG_IRQ_TIME_ACCOUNTING
>> +#define NUM_STATS_GROUPS    5
>> +#define STATS_SYSTEM        0
>> +#define STATS_SOFTIRQ        1
>> +#define STATS_HARDIRQ        2
>> +#define STATS_IDLE        3
>> +#define NUM_STATS_PER_GROUP    4
> This is a set of related numbers; wouldn't it be better to use an enum?
Agree.
>> +static DEFINE_PER_CPU(u16, cpustat_old[NUM_STATS_PER_GROUP]);
>> +static DEFINE_PER_CPU(u8, 
>> cpustat_utilization[NUM_STATS_GROUPS][NUM_STATS_PER_GROUP]);
>> +static DEFINE_PER_CPU(u8, cpustat_tail);
>> +static enum cpu_usage_stat idx_to_stat[NUM_STATS_PER_GROUP] = {
>> +    CPUTIME_SYSTEM, CPUTIME_SOFTIRQ, CPUTIME_IRQ, CPUTIME_IDLE
>> +};
> To be honest, I'm not particularly fond of the name 'idx_to_stat' as the 
> concept of an
> index is already implied by the nature of an array, so adding 'idx' is 
> redundant.
> I suggest shortening the name.
OK, the name 'stats' is clear enough here.
> 
>> +
>> +static void update_cpustat(void)
>> +{
>> +    u8 i;
>> +    u16 *old = this_cpu_ptr(cpustat_old);
>> +    u8 (*utilization)[NUM_STATS_PER_GROUP] = 
>> this_cpu_ptr(cpustat_utilization);
>> +    u8 tail = this_cpu_read(cpustat_tail);
>> +    struct kernel_cpustat kcpustat;
>> +    u64 *cpustat = kcpustat.cpustat;
>> +    u16 sample_period_ms = sample_period >> 24LL; /* 2^24ns ~= 16.8ms */
> 
> There are two instances where right shift operations are used; it is 
> suggested to employ a helper macro for a more comfortable look.
OK.
> 
> 
>> +
>> +    kcpustat_cpu_fetch(&kcpustat, smp_processor_id());
>> +    for (i = STATS_SYSTEM; i < NUM_STATS_PER_GROUP; i++) {
>> +        /*
>> +         * We don't need nanosecond resolution. A granularity of 16ms is
>> +         * sufficient for our precision, allowing us to use u16 to store
>> +         * cpustats, which will roll over roughly every ~1000 seconds.
>> +         * 2^24 ~= 16 * 10^6
>> +         */
>> +        cpustat[idx_to_stat[i]] = 
>> lower_16_bits(cpustat[idx_to_stat[i]] >> 24LL);
>> +        utilization[tail][i] = 100 * (u16)(cpustat[idx_to_stat[i]] - 
>> old[i])
>> +                    / sample_period_ms;
>> +        old[i] = cpustat[idx_to_stat[i]];
>> +    }
>> +    this_cpu_write(cpustat_tail, (tail + 1) % NUM_STATS_GROUPS);
>> +}
>> +
>> +static void print_cpustat(void)
>> +{
>> +    u8 i, j;
>> +    u8 (*utilization)[NUM_STATS_PER_GROUP] = 
>> this_cpu_ptr(cpustat_utilization);
>> +    u8 tail = this_cpu_read(cpustat_tail);
>> +    u64 sample_period_second = sample_period;
>> +
>> +    do_div(sample_period_second, NSEC_PER_SEC);
>> +    /*
>> +     * We do not want the "watchdog: " prefix on every line,
>> +     * hence we use "printk" instead of "pr_crit".
>> +     */
>> +    printk(KERN_CRIT "CPU#%d Utilization every %llus during lockup:\n",
>> +        smp_processor_id(), sample_period_second);
>> +    for (j = STATS_SYSTEM, i = tail; j < NUM_STATS_GROUPS;
>> +        j++, i = (i + 1) % NUM_STATS_GROUPS) {
>> +        printk(KERN_CRIT "\t#%d: %3u%% system,\t%3u%% softirq,\t"
>> +            "%3u%% hardirq,\t%3u%% idle\n", j+1,
>> +            utilization[i][STATS_SYSTEM], utilization[i][STATS_SOFTIRQ],
>> +            utilization[i][STATS_HARDIRQ], utilization[i][STATS_IDLE]);
>> +    }
>> +}
>> +#else
>> +static inline void update_cpustat(void) { }
>> +static inline void print_cpustat(void) { }
>> +#endif
>> +
>>   /* watchdog detector functions */
>>   static DEFINE_PER_CPU(struct completion, softlockup_completion);
>>   static DEFINE_PER_CPU(struct cpu_stop_work, softlockup_stop_work);
>> @@ -504,6 +573,8 @@ static enum hrtimer_restart 
>> watchdog_timer_fn(struct hrtimer *hrtimer)
>>        */
>>       period_ts = READ_ONCE(*this_cpu_ptr(&watchdog_report_ts));
>> +    update_cpustat();
>> +
>>       /* Reset the interval when touched by known problematic code. */
>>       if (period_ts == SOFTLOCKUP_DELAY_REPORT) {
>>           if (unlikely(__this_cpu_read(softlockup_touch_sync))) {
>> @@ -539,6 +610,7 @@ static enum hrtimer_restart 
>> watchdog_timer_fn(struct hrtimer *hrtimer)
>>           pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
>>               smp_processor_id(), duration,
>>               current->comm, task_pid_nr(current));
>> +        print_cpustat();
>>           print_modules();
>>           print_irqtrace_events(current);
>>           if (regs)

