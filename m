Return-Path: <linux-kernel+bounces-82901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D3A868B8B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2218E1F21D39
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A28D13698A;
	Tue, 27 Feb 2024 09:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rzlV55dA"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAA9135A65;
	Tue, 27 Feb 2024 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024576; cv=none; b=U2X2dNc36yEKBaUNMZqz0Tylq7fdqsb1b5kNaVF2e9ayc3i9kE8p8gqrkcf3DxnAASR/tsC7yaaJSec2KnQ0BqGonPMQ+a5QkIw2QnLZ4RNF6yyiC6q3yQ1Ku8TcvIwqQ4lEngf227+Ocs48SkszAIBQZ3lZLna1Em1NMoWWOZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024576; c=relaxed/simple;
	bh=Um1XAVigevnv14Yo2UsDOc+ic7fQArkcwp7Zqnjv6sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FArA0TrYoVFNMTc5yVdv8yrDPm4lF60CA8q3bSXvBa8wRa/x2KTQu1Xid2yYyzIKXP+yJCKW3Nvwht3LXQWjGgzg1jWELIuQgUBJOkVG8vvE9Z2ZAiQ3RyH4NsdxGRqtWhmuk9NeipL0LDCH1lv0dSZM+pS8LU89OHwAOLbpZQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rzlV55dA; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709024565; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bKyExLaJsMJFtDGzvQca2erL9AyFIbFelzMrpVgTicU=;
	b=rzlV55dA/EulHOyzrz+tKIVP/GSIUV5b5wsi3x62+7/vlLRTp0R5+AOujcj0MTbXU/IbbX+RAnUNwYfLbzCYihy9bffR23tuPwGJ6b5Odfkf7R7sGNbEeN4D2Jt/RBhvF9S6UqzOiePdPz4MYefYcMxOPvDrviPaL4aGJG+33OA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W1M9Gjj_1709024562;
Received: from 30.178.80.107(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0W1M9Gjj_1709024562)
          by smtp.aliyun-inc.com;
          Tue, 27 Feb 2024 17:02:44 +0800
Message-ID: <49144bb6-dd90-44ef-965a-aa5af8d568b1@linux.alibaba.com>
Date: Tue, 27 Feb 2024 17:02:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv10 4/4] watchdog/softlockup: report the most frequent
 interrupts
To: Bitao Hu <yaoma@linux.alibaba.com>, dianders@chromium.org,
 tglx@linutronix.de, akpm@linux-foundation.org, pmladek@suse.com,
 kernelfans@gmail.com, deller@gmx.de, npiggin@gmail.com,
 tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
 jan.kiszka@siemens.com
Cc: linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20240226020939.45264-1-yaoma@linux.alibaba.com>
 <20240226020939.45264-5-yaoma@linux.alibaba.com>
From: Liu Song <liusong@linux.alibaba.com>
In-Reply-To: <20240226020939.45264-5-yaoma@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/2/26 10:09, Bitao Hu 写道:
> When the watchdog determines that the current soft lockup is due
> to an interrupt storm based on CPU utilization, reporting the
> most frequent interrupts could be good enough for further
> troubleshooting.
>
> Below is an example of interrupt storm. The call tree does not
> provide useful information, but we can analyze which interrupt
> caused the soft lockup by comparing the counts of interrupts.
>
> [  638.870231] watchdog: BUG: soft lockup - CPU#9 stuck for 26s! [swapper/9:0]
> [  638.870825] CPU#9 Utilization every 4s during lockup:
> [  638.871194]  #1:   0% system,          0% softirq,   100% hardirq,     0% idle
> [  638.871652]  #2:   0% system,          0% softirq,   100% hardirq,     0% idle
> [  638.872107]  #3:   0% system,          0% softirq,   100% hardirq,     0% idle
> [  638.872563]  #4:   0% system,          0% softirq,   100% hardirq,     0% idle
> [  638.873018]  #5:   0% system,          0% softirq,   100% hardirq,     0% idle
> [  638.873494] CPU#9 Detect HardIRQ Time exceeds 50%. Most frequent HardIRQs:
> [  638.873994]  #1: 330945      irq#7
> [  638.874236]  #2: 31          irq#82
> [  638.874493]  #3: 10          irq#10
> [  638.874744]  #4: 2           irq#89
> [  638.874992]  #5: 1           irq#102
> ...
> [  638.875313] Call trace:
> [  638.875315]  __do_softirq+0xa8/0x364
>
> Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
> ---
>   kernel/watchdog.c | 115 ++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 111 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 69e72d7e461d..c9d49ae8d045 100644
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
> @@ -417,13 +420,104 @@ static void print_cpustat(void)
>   	}
>   }
>   
> +#define HARDIRQ_PERCENT_THRESH          50
> +#define NUM_HARDIRQ_REPORT              5
> +struct irq_counts {
> +	int irq;
> +	u32 counts;
> +};
> +
> +static DEFINE_PER_CPU(bool, snapshot_taken);
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
> +	if (!__this_cpu_read(snapshot_taken)) {
> +		kstat_snapshot_irqs();
> +		__this_cpu_write(snapshot_taken, true);
> +	}
> +}
> +
> +static void stop_counting_irqs(void)
> +{
> +	__this_cpu_write(snapshot_taken, false);
> +}
> +
> +static void print_irq_counts(void)
> +{
> +	unsigned int i, count;
> +	struct irq_counts irq_counts_sorted[NUM_HARDIRQ_REPORT] = {
> +		{-1, 0}, {-1, 0}, {-1, 0}, {-1, 0}, {-1, 0}
> +	};
> +
> +	if (__this_cpu_read(snapshot_taken)) {
> +		for_each_active_irq(i) {
> +			count = kstat_get_irq_since_snapshot(i);
> +			tabulate_irq_count(irq_counts_sorted, i, count, NUM_HARDIRQ_REPORT);
> +		}
> +
> +		/*
> +		 * We do not want the "watchdog: " prefix on every line,
> +		 * hence we use "printk" instead of "pr_crit".
> +		 */
> +		printk(KERN_CRIT "CPU#%d Detect HardIRQ Time exceeds %d%%. Most frequent HardIRQs:\n",
> +		       smp_processor_id(), HARDIRQ_PERCENT_THRESH);
> +
> +		for (i = 0; i < NUM_HARDIRQ_REPORT; i++) {
> +			if (irq_counts_sorted[i].irq == -1)
> +				break;
> +
> +			printk(KERN_CRIT "\t#%u: %-10u\tirq#%d\n",
> +			       i + 1, irq_counts_sorted[i].counts,
> +			       irq_counts_sorted[i].irq);
> +		}
> +
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
> @@ -527,6 +621,18 @@ static int is_softlockup(unsigned long touch_ts,
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
> +		if (time_after_eq(now, period_ts + get_softlockup_thresh() / NUM_SAMPLE_PERIODS) &&
> +		    need_counting_irqs())
> +			start_counting_irqs();
> +
>   		/* Warn about unreasonable delays. */
>   		if (time_after(now, period_ts + get_softlockup_thresh()))
>   			return now - touch_ts;
> @@ -549,6 +655,7 @@ static DEFINE_PER_CPU(struct cpu_stop_work, softlockup_stop_work);
>   static int softlockup_fn(void *data)
>   {
>   	update_touch_ts();
> +	stop_counting_irqs();
>   	complete(this_cpu_ptr(&softlockup_completion));
>   
>   	return 0;

Looks good.

Reviewed-by: Liu Song <liusong@linux.alibaba.com>


