Return-Path: <linux-kernel+bounces-60411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7F2850486
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 14:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54FE1B228DF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 13:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E6D5380F;
	Sat, 10 Feb 2024 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="frXbHtSq"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE4C2114
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 13:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707572023; cv=none; b=NBauBrEAOvF/shI8wp0exud0oZDYy+QL/kyhIJF7D7HBqK+XLO4Gws8Ar3JGDhAdCIE84HTR9QqJNmr1pVcuqtqS43z4HiHfE1lvxhgfoCzQyuQzVWLm/SLg5csXuspJAwDBwa2lb8igwfdyeiEZdUROHHYU9lFjbPbv5zDpLGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707572023; c=relaxed/simple;
	bh=S3qpEyi6iEpk0KiykEAHNzfsDGwEH3Ja+8u230iWX7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i8j5ePyV6D9+Ue+Ao9VBKlVXlCXR80gy5tElHzaRpkjWa4s8j3lEIZyFXUirEDATpVDnVvOIusnI8P2y0Q9WjIiecxrdY+VA0h0BUs+xqd8EQ+GbiLmdi5F46s8o4AOSxk3qPoyZGO8FjGx9xNOc6CE08vZlYbH5LyfFVOzAn4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=frXbHtSq; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707572011; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Ftf8lo58gnF+caNhtpPCaf5NWmRTU4dk/LuOdGoR/C8=;
	b=frXbHtSq0QaECRcPQ1R8kjP44PPl9Wz7AszziS1o6bOaQ0vyuIOqnz7NGosMS5dGNCFLsOlYhqboP+09FUWiLBE0hNN5imGaLqk+HfsbbQC9qDwjVYOMBQLohVNT5OjCXcab2MAGWF0MTin1YimXIHWhaxj7qOTUY67KyQLyiCw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W0O8QKA_1707571975;
Received: from 30.120.175.242(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0W0O8QKA_1707571975)
          by smtp.aliyun-inc.com;
          Sat, 10 Feb 2024 21:33:31 +0800
Message-ID: <470e9795-6269-407b-801a-5cffb95988f0@linux.alibaba.com>
Date: Sat, 10 Feb 2024 21:33:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 2/2] watchdog/softlockup: report the most frequent
 interrupts
To: Bitao Hu <yaoma@linux.alibaba.com>, dianders@chromium.org,
 akpm@linux-foundation.org, pmladek@suse.com, kernelfans@gmail.com
Cc: linux-kernel@vger.kernel.org
References: <20240208125426.70511-1-yaoma@linux.alibaba.com>
 <20240208125426.70511-3-yaoma@linux.alibaba.com>
From: Liu Song <liusong@linux.alibaba.com>
In-Reply-To: <20240208125426.70511-3-yaoma@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Looks good！

Reviewed-by: Liu Song <liusong@linux.alibaba.com>

在 2024/2/8 20:54, Bitao Hu 写道:
> When the watchdog determines that the current soft lockup is due
> to an interrupt storm based on CPU utilization, reporting the
> most frequent interrupts could be good enough for further
> troubleshooting.
>
> Below is an example of interrupt storm. The call tree does not
> provide useful information, but we can analyze which interrupt
> caused the soft lockup by comparing the counts of interrupts.
>
> [ 2987.488075] watchdog: BUG: soft lockup - CPU#9 stuck for 23s! [kworker/9:1:214]
> [ 2987.488607] CPU#9 Utilization every 4s during lockup:
> [ 2987.488941]  #1:   0% system,          0% softirq,   100% hardirq,     0% idle
> [ 2987.489357]  #2:   0% system,          0% softirq,   100% hardirq,     0% idle
> [ 2987.489771]  #3:   0% system,          0% softirq,   100% hardirq,     0% idle
> [ 2987.490186]  #4:   0% system,          0% softirq,   100% hardirq,     0% idle
> [ 2987.490601]  #5:   0% system,          0% softirq,   100% hardirq,     0% idle
> [ 2987.491034] CPU#9 Detect HardIRQ Time exceeds 50%. Most frequent HardIRQs:
> [ 2987.491493]  #1: 330985      irq#7(IPI)
> [ 2987.491743]  #2: 5000        irq#10(arch_timer)
> [ 2987.492039]  #3: 9           irq#91(nvme0q2)
> [ 2987.492318]  #4: 3           irq#118(virtio1-output.12)
> ...
> [ 2987.492728] Call trace:
> [ 2987.492729]  __do_softirq+0xa8/0x364
>
> Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
> ---
>   kernel/watchdog.c | 153 ++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 149 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 380b60074f1d..e9e98ce5ff40 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -12,22 +12,25 @@
>   
>   #define pr_fmt(fmt) "watchdog: " fmt
>   
> -#include <linux/mm.h>
>   #include <linux/cpu.h>
> -#include <linux/nmi.h>
>   #include <linux/init.h>
> +#include <linux/irq.h>
> +#include <linux/irqdesc.h>
>   #include <linux/kernel_stat.h>
> +#include <linux/kvm_para.h>
>   #include <linux/math64.h>
> +#include <linux/mm.h>
>   #include <linux/module.h>
> +#include <linux/nmi.h>
> +#include <linux/stop_machine.h>
>   #include <linux/sysctl.h>
>   #include <linux/tick.h>
> +
>   #include <linux/sched/clock.h>
>   #include <linux/sched/debug.h>
>   #include <linux/sched/isolation.h>
> -#include <linux/stop_machine.h>
>   
>   #include <asm/irq_regs.h>
> -#include <linux/kvm_para.h>
>   
>   static DEFINE_MUTEX(watchdog_mutex);
>   
> @@ -412,13 +415,142 @@ static void print_cpustat(void)
>   	}
>   }
>   
> +#define HARDIRQ_PERCENT_THRESH		50
> +#define NUM_HARDIRQ_REPORT		5
> +static DEFINE_PER_CPU(u32 *, hardirq_counts);
> +static DEFINE_PER_CPU(int, actual_nr_irqs);
> +struct irq_counts {
> +	int irq;
> +	u32 counts;
> +};
> +
> +/* Tabulate the most frequent interrupts. */
> +static void tabulate_irq_count(struct irq_counts *irq_counts, int irq, u32 counts, int rank)
> +{
> +	int i;
> +	struct irq_counts new_count = {irq, counts};
> +
> +	for (i = 0; i < rank; i++) {
> +		if (counts > irq_counts[i].counts)
> +			swap(new_count, irq_counts[i]);
> +	}
> +}
> +
> +/*
> + * If the hardirq time exceeds HARDIRQ_PERCENT_THRESH% of the sample_period,
> + * then the cause of softlockup might be interrupt storm. In this case, it
> + * would be useful to start interrupt counting.
> + */
> +static bool need_counting_irqs(void)
> +{
> +	u8 util;
> +	int tail = __this_cpu_read(cpustat_tail);
> +
> +	tail = (tail + NUM_HARDIRQ_REPORT - 1) % NUM_HARDIRQ_REPORT;
> +	util = __this_cpu_read(cpustat_util[tail][STATS_HARDIRQ]);
> +	return util > HARDIRQ_PERCENT_THRESH;
> +}
> +
> +static void start_counting_irqs(void)
> +{
> +	int i;
> +	int local_nr_irqs;
> +	struct irq_desc *desc;
> +	u32 *counts = __this_cpu_read(hardirq_counts);
> +
> +	if (!counts) {
> +		/*
> +		 * nr_irqs has the potential to grow at runtime. We should read
> +		 * it and store locally to avoid array out-of-bounds access.
> +		 */
> +		local_nr_irqs = READ_ONCE(nr_irqs);
> +		counts = kcalloc(local_nr_irqs, sizeof(u32), GFP_ATOMIC);
> +		if (!counts)
> +			return;
> +		for (i = 0; i < local_nr_irqs; i++) {
> +			desc = irq_to_desc(i);
> +			if (!desc)
> +				continue;
> +			counts[i] = desc->kstat_irqs ?
> +				*this_cpu_ptr(desc->kstat_irqs) : 0;
> +		}
> +		__this_cpu_write(actual_nr_irqs, local_nr_irqs);
> +		__this_cpu_write(hardirq_counts, counts);
> +	}
> +}
> +
> +static void stop_counting_irqs(void)
> +{
> +	kfree(__this_cpu_read(hardirq_counts));
> +	__this_cpu_write(hardirq_counts, NULL);
> +}
> +
> +static void print_irq_counts(void)
> +{
> +	int i;
> +	struct irq_desc *desc;
> +	u32 counts_diff;
> +	int local_nr_irqs = __this_cpu_read(actual_nr_irqs);
> +	u32 *counts = __this_cpu_read(hardirq_counts);
> +	struct irq_counts irq_counts_sorted[NUM_HARDIRQ_REPORT] = {
> +		{-1, 0}, {-1, 0}, {-1, 0}, {-1, 0},
> +	};
> +
> +	if (counts) {
> +		for_each_irq_desc(i, desc) {
> +			/*
> +			 * We need to bounds-check in case someone on a different CPU
> +			 * expanded nr_irqs.
> +			 */
> +			if (desc->kstat_irqs) {
> +				counts_diff = *this_cpu_ptr(desc->kstat_irqs);
> +				if (i < local_nr_irqs)
> +					counts_diff -= counts[i];
> +			} else {
> +				counts_diff = 0;
> +			}
> +			tabulate_irq_count(irq_counts_sorted, i, counts_diff,
> +					   NUM_HARDIRQ_REPORT);
> +		}
> +		/*
> +		 * We do not want the "watchdog: " prefix on every line,
> +		 * hence we use "printk" instead of "pr_crit".
> +		 */
> +		printk(KERN_CRIT "CPU#%d Detect HardIRQ Time exceeds %d%%. Most frequent HardIRQs:\n",
> +		       smp_processor_id(), HARDIRQ_PERCENT_THRESH);
> +		for (i = 0; i < NUM_HARDIRQ_REPORT; i++) {
> +			if (irq_counts_sorted[i].irq == -1)
> +				break;
> +			desc = irq_to_desc(irq_counts_sorted[i].irq);
> +			if (desc && desc->action)
> +				printk(KERN_CRIT "\t#%u: %-10u\tirq#%d(%s)\n",
> +				       i + 1, irq_counts_sorted[i].counts,
> +				       irq_counts_sorted[i].irq, desc->action->name);
> +			else
> +				printk(KERN_CRIT "\t#%u: %-10u\tirq#%d\n",
> +				       i + 1, irq_counts_sorted[i].counts,
> +				       irq_counts_sorted[i].irq);
> +		}
> +		/*
> +		 * If the hardirq time is less than HARDIRQ_PERCENT_THRESH% in the last
> +		 * sample_period, then we suspect the interrupt storm might be subsiding.
> +		 */
> +		if (!need_counting_irqs())
> +			stop_counting_irqs();
> +	}
> +}
> +
>   static void report_cpu_status(void)
>   {
>   	print_cpustat();
> +	print_irq_counts();
>   }
>   #else
>   static inline void update_cpustat(void) { }
>   static inline void report_cpu_status(void) { }
> +static inline bool need_counting_irqs(void) { return false; }
> +static inline void start_counting_irqs(void) { }
> +static inline void stop_counting_irqs(void) { }
>   #endif
>   
>   /*
> @@ -522,6 +654,18 @@ static int is_softlockup(unsigned long touch_ts,
>   			 unsigned long now)
>   {
>   	if ((watchdog_enabled & WATCHDOG_SOFTOCKUP_ENABLED) && watchdog_thresh) {
> +		/*
> +		 * If period_ts has not been updated during a sample_period, then
> +		 * in the subsequent few sample_periods, period_ts might also not
> +		 * be updated, which could indicate a potential softlockup. In
> +		 * this case, if we suspect the cause of the potential softlockup
> +		 * might be interrupt storm, then we need to count the interrupts
> +		 * to find which interrupt is storming.
> +		 */
> +		if (time_after_eq(now, period_ts + get_softlockup_thresh() / 5) &&
> +		    need_counting_irqs())
> +			start_counting_irqs();
> +
>   		/* Warn about unreasonable delays. */
>   		if (time_after(now, period_ts + get_softlockup_thresh()))
>   			return now - touch_ts;
> @@ -544,6 +688,7 @@ static DEFINE_PER_CPU(struct cpu_stop_work, softlockup_stop_work);
>   static int softlockup_fn(void *data)
>   {
>   	update_touch_ts();
> +	stop_counting_irqs();
>   	complete(this_cpu_ptr(&softlockup_completion));
>   
>   	return 0;

