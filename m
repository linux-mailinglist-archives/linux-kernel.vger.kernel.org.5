Return-Path: <linux-kernel+bounces-51977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E42849230
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 02:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC9B81C20E83
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 01:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2318472;
	Mon,  5 Feb 2024 01:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gPHg//WW"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3794D79D8
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 01:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707097185; cv=none; b=DFBbS6RMNXF5vjBPOf3GqAWzh7VY3oxkSomrjb7geszHWK9B7gVVmnq+KuAP1R/uGUysy34jiiitQtDV/Vdb7BJfEQNfayQSrfgeOS4e83O3BEIosBKuhAXxNMyvkIVh5BVjucpb6DRXuyD67XF+0/pKOrF0fxMXQ6jzF32rPdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707097185; c=relaxed/simple;
	bh=rgNMaPiGUZWmdmarENvKINXW60jw+GdOM+Qp0G3Vdjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B77EUqjYI3DZ3PjWon6SDrN5/CDgY+7l5fp3OXR8UAdV18PHIJLgmob7vWDTFDlntyy3dr5NAkcAQj4yQo1aY1R9b4gair/TCu94/yUjYPeIBcttPRPNx/BdfF330G358dTKsHSUQ2km6L0DFOgWkgD9RXe9LY2LpTqkAYOJKsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gPHg//WW; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707097179; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=jRsT4cgPCNCVFRZHXYR4jCeYq1G5FG3getkHYt3zl2I=;
	b=gPHg//WWJdlp67+1RZl3nUNWCM0azAPX/eXdQaoTEpv+SVtuI9P0LN9eTgw0+wqr2ZRQYQK2JIn8yZ34pK/O0q0l4utch6zUtZ4fV8kKHBGYhgZ8JKukA1lJoryX76v2LzxRpvSAIDC8ISIeZuF6+A5DvYUAapbBTxxGbrwuFhM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W01z6jF_1707097178;
Received: from 30.178.80.101(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0W01z6jF_1707097178)
          by smtp.aliyun-inc.com;
          Mon, 05 Feb 2024 09:39:39 +0800
Message-ID: <042cb1f0-9948-4366-af0a-d55724d2d11a@linux.alibaba.com>
Date: Mon, 5 Feb 2024 09:39:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 2/3] watchdog/softlockup: report the most frequent
 interrupts
To: Bitao Hu <yaoma@linux.alibaba.com>, dianders@chromium.org,
 akpm@linux-foundation.org, pmladek@suse.com, kernelfans@gmail.com
Cc: linux-kernel@vger.kernel.org
References: <20240204145154.11069-1-yaoma@linux.alibaba.com>
 <20240204145154.11069-3-yaoma@linux.alibaba.com>
From: Liu Song <liusong@linux.alibaba.com>
In-Reply-To: <20240204145154.11069-3-yaoma@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/2/4 22:51, Bitao Hu 写道:
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
>   kernel/watchdog.c | 156 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 156 insertions(+)
>
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 7b121e166b81..d31120c3e9d1 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -19,6 +19,9 @@
>   #include <linux/kernel_stat.h>
>   #include <linux/math64.h>
>   #include <linux/module.h>
> +#include <linux/irq.h>
> +#include <linux/irqdesc.h>
> +#include <linux/bitops.h>
>   #include <linux/sysctl.h>
>   #include <linux/tick.h>
>   #include <linux/sched/clock.h>
> @@ -412,13 +415,153 @@ static void print_cpustat(void)
>   	}
>   }
>   
> +#define HARDIRQ_PERCENT_THRESH		50
> +#define NUM_HARDIRQ_REPORT		5
> +static DECLARE_BITMAP(softlockup_hardirq_cpus, CONFIG_NR_CPUS);
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
> +	int tail = __this_cpu_read(cpustat_tail);
> +	u8 util;
> +
> +	tail = (tail + NUM_HARDIRQ_REPORT - 1) % NUM_HARDIRQ_REPORT;
> +	util = __this_cpu_read(cpustat_util[tail][STATS_HARDIRQ]);
> +	return util > HARDIRQ_PERCENT_THRESH;
> +}
> +
> +static void start_counting_irqs(void)
> +{
> +	int i;
> +	u32 *counts = __this_cpu_read(hardirq_counts);
> +	int cpu = smp_processor_id();
> +	struct irq_desc *desc;
> +
> +	if (!test_bit(cpu, softlockup_hardirq_cpus)) {
> +		/*
> +		 * nr_irqs has the potential to grow at runtime. We should read
> +		 * it and store locally to avoid array out-of-bounds access.
> +		 */
> +		__this_cpu_write(actual_nr_irqs, nr_irqs);
> +		counts = kmalloc_array(__this_cpu_read(actual_nr_irqs),
> +				       sizeof(u32),
> +				       GFP_ATOMIC);
> +		if (!counts)
> +			return;
> +		for (i = 0; i < __this_cpu_read(actual_nr_irqs); i++) {
> +			desc = irq_to_desc(i);
> +			if (!desc)
> +				continue;
> +			counts[i] = desc->kstat_irqs ?
> +				*this_cpu_ptr(desc->kstat_irqs) : 0;
> +		}
> +		__this_cpu_write(hardirq_counts, counts);
> +		set_bit(cpu, softlockup_hardirq_cpus);
> +	}
> +}
> +
> +static void stop_counting_irqs(void)
> +{
> +	u32 *counts = __this_cpu_read(hardirq_counts);
> +	int cpu = smp_processor_id();
> +
> +	if (test_bit(cpu, softlockup_hardirq_cpus)) {
> +		kfree(counts);
> +		counts = NULL;
> +		__this_cpu_write(hardirq_counts, counts);
> +		clear_bit(cpu, softlockup_hardirq_cpus);
> +	}
> +}
> +
> +static void print_irq_counts(void)
> +{
> +	int i;
> +	struct irq_desc *desc;
> +	u32 counts_diff;
> +	u32 *counts = __this_cpu_read(hardirq_counts);
> +	int cpu = smp_processor_id();
> +	struct irq_counts irq_counts_sorted[NUM_HARDIRQ_REPORT] = {
> +		{-1, 0}, {-1, 0}, {-1, 0}, {-1, 0},
> +	};
> +
> +	if (test_bit(cpu, softlockup_hardirq_cpus)) {
> +		for_each_irq_desc(i, desc) {
> +			if (!desc)
> +				continue;
> +			/*
> +			 * We need to bounds-check in case someone on a different CPU
> +			 * expanded nr_irqs.
> +			 */
> +			if (i < __this_cpu_read(actual_nr_irqs))
> +				counts_diff = desc->kstat_irqs ?
> +					*this_cpu_ptr(desc->kstat_irqs) - counts[i] : 0;
> +			else
> +				counts_diff = desc->kstat_irqs ?
> +					*this_cpu_ptr(desc->kstat_irqs) : 0;
> +			tabulate_irq_count(irq_counts_sorted, i, counts_diff,
> +					NUM_HARDIRQ_REPORT);
> +		}
> +		/*
> +		 * We do not want the "watchdog: " prefix on every line,
> +		 * hence we use "printk" instead of "pr_crit".
> +		 */
> +		printk(KERN_CRIT "CPU#%d Detect HardIRQ Time exceeds %d%%. Most frequent HardIRQs:\n",
> +			smp_processor_id(), HARDIRQ_PERCENT_THRESH);
> +		for (i = 0; i < NUM_HARDIRQ_REPORT; i++) {
> +			if (irq_counts_sorted[i].irq == -1)
> +				break;
> +			desc = irq_to_desc(irq_counts_sorted[i].irq);
> +			if (desc && desc->action)
> +				printk(KERN_CRIT "\t#%u: %-10u\tirq#%d(%s)\n",
> +					i+1, irq_counts_sorted[i].counts,
> +					irq_counts_sorted[i].irq, desc->action->name);
> +			else
> +				printk(KERN_CRIT "\t#%u: %-10u\tirq#%d\n",
> +					i+1, irq_counts_sorted[i].counts,
> +					irq_counts_sorted[i].irq);
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
> @@ -522,6 +665,18 @@ static int is_softlockup(unsigned long touch_ts,
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
> @@ -544,6 +699,7 @@ static DEFINE_PER_CPU(struct cpu_stop_work, softlockup_stop_work);
>   static int softlockup_fn(void *data)
>   {
>   	update_touch_ts();
> +	stop_counting_irqs();
>   	complete(this_cpu_ptr(&softlockup_completion));
>   
>   	return 0;

Looks good.

Here is a personal suggestion: within a function body, if there are
variable declarations and declarations with assignments, it is
recommended to place the declarations with assignments after those that
are simply declarations, as this looks neater.

Reviewed-by: Liu Song <liusong@linux.alibaba.com>


