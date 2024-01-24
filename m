Return-Path: <linux-kernel+bounces-36285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22855839E5E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 468D31C22291
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AC015AB;
	Wed, 24 Jan 2024 01:44:06 +0000 (UTC)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FE94402
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 01:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706060645; cv=none; b=t/+nxKtDbcpptqnwY4aN38HMJ6KSpO4k2zD8Dj+9jN0cnf1mxjFibYwH4cGpz5kiStnZgiqjc2tmUWDK04dorAdKQXILgzBH7wA/CllBpWE4xr2uz0aoUDezHvCWu7KHAp5Ot7frQtfPYL9vSvuiaMe1v3f/zqZGu1JRKWV46RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706060645; c=relaxed/simple;
	bh=qzK5QWoCZGP7kcuhkszdhBYL+28JmOXvV/QDv5530W8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6/9V1/gPOiMRZFDk4VrrCDo+JCP69aSrOK8OqI7/Wh6kpZUay+18CeqXjYp41Uyif/gupfb6JP5ZaXEzd6Y288juxkX1caZorZaOPmfL0QCuVEpI8f/FlQ8CART5myiJPXvDtzN46tIwypQqQ+h82anBXkQ4L/EL1sU7TXgBAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W.EBnX._1706060636;
Received: from 30.178.80.116(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0W.EBnX._1706060636)
          by smtp.aliyun-inc.com;
          Wed, 24 Jan 2024 09:43:57 +0800
Message-ID: <8d6afe80-58ca-455d-a6ae-797d7c5ce388@linux.alibaba.com>
Date: Wed, 24 Jan 2024 09:43:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] watchdog/softlockup: low-overhead detection of
 interrupt storm
To: Bitao Hu <yaoma@linux.alibaba.com>, dianders@chromium.org,
 akpm@linux-foundation.org, pmladek@suse.com, tglx@linutronix.de,
 maz@kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20240123121223.22318-1-yaoma@linux.alibaba.com>
 <20240123121223.22318-2-yaoma@linux.alibaba.com>
From: Liu Song <liusong@linux.alibaba.com>
In-Reply-To: <20240123121223.22318-2-yaoma@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/1/23 20:12, Bitao Hu 写道:
> The following softlockup is caused by interrupt storm, but it cannot be
> identified from the call tree. Because the call tree is just a snapshot
> and doesn't fully capture the behavior of the CPU during the soft lockup.
>    watchdog: BUG: soft lockup - CPU#28 stuck for 23s! [fio:83921]
>    ...
>    Call trace:
>      __do_softirq+0xa0/0x37c
>      __irq_exit_rcu+0x108/0x140
>      irq_exit+0x14/0x20
>      __handle_domain_irq+0x84/0xe0
>      gic_handle_irq+0x80/0x108
>      el0_irq_naked+0x50/0x58
>
> Therefore，I think it is necessary to report CPU utilization during the
> softlockup_thresh period (report once every sample_period, for a total
> of 5 reportings), like this:
>    watchdog: BUG: soft lockup - CPU#28 stuck for 23s! [fio:83921]
>    CPU#28 Utilization every 4s during lockup:
>      #1: 0.0% system, 0.0% softirq, 100.0% hardirq, 0.0% idle
>      #2: 0.0% system, 0.0% softirq, 100.0% hardirq, 0.0% idle
>      #3: 0.0% system, 0.0% softirq, 100.0% hardirq, 0.0% idle
>      #4: 0.0% system, 0.0% softirq, 100.0% hardirq, 0.0% idle
>      #5: 0.0% system, 0.0% softirq, 100.0% hardirq, 0.0% idle
>    ...
>
> This would be helpful in determining whether an interrupt storm has
> occurred or in identifying the cause of the softlockup. The criteria for
> determination are as follows:
>    a. If the hardirq utilization is high, then interrupt storm should be
>    considered and the root cause cannot be determined from the call tree.
>    b. If the softirq utilization is high, then we could analyze the call
>    tree but it may cannot reflect the root cause.
>    c. If the system utilization is high, then we could analyze the root
>    cause from the call tree.
>
> Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
> ---
>   kernel/watchdog.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 58 insertions(+)
>
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 81a8862295d6..9fad10e0a147 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -23,6 +23,8 @@
>   #include <linux/sched/debug.h>
>   #include <linux/sched/isolation.h>
>   #include <linux/stop_machine.h>
> +#include <linux/kernel_stat.h>
> +#include <linux/math64.h>
>   
>   #include <asm/irq_regs.h>
>   #include <linux/kvm_para.h>
> @@ -441,6 +443,58 @@ static int is_softlockup(unsigned long touch_ts,
>   	return 0;
>   }
>   
> +#ifdef CONFIG_IRQ_TIME_ACCOUNTING
> +static DEFINE_PER_CPU(u64, cpustat_old[NR_STATS]);
> +static DEFINE_PER_CPU(u64, cpustat_diff[5][NR_STATS]);
> +static DEFINE_PER_CPU(int, cpustat_tail);
> +
> +static void update_cpustat(void)
> +{
> +	u64 *old = this_cpu_ptr(cpustat_old);
> +	u64 (*diff)[NR_STATS] = this_cpu_ptr(cpustat_diff);
> +	int tail = this_cpu_read(cpustat_tail), i;
> +	struct kernel_cpustat kcpustat;
> +	u64 *cpustat = kcpustat.cpustat;
> +
> +	kcpustat_cpu_fetch(&kcpustat, smp_processor_id());
> +	for (i = 0; i < NR_STATS; i++) {
> +		diff[tail][i] = cpustat[i] - old[i];
> +		old[i] = cpustat[i];
> +	}
> +	this_cpu_write(cpustat_tail, (tail + 1) % 5);
The number 5 here is related to the 5 in cpustat_diff[5], and it is 
recommended to use a macro definition instead of using the number 5 
directly.
> +}
> +
> +static void print_cpustat(void)
> +{
> +	int i, j, k;
> +	u64 a[5][NR_STATS], b[5][NR_STATS];
Use define instead of the literal number 5.
> +	u64 (*diff)[NR_STATS] = this_cpu_ptr(cpustat_diff);
> +	int tail = this_cpu_read(cpustat_tail);
> +	u32 period_us = sample_period / 1000;
Use NSEC_PER_USEC
> +
> +	for (i = 0; i < 5; i++) {
> +		for (j = 0; j < NR_STATS; j++) {
> +			a[i][j] = 100 * (diff[i][j] / 1000);
> +			b[i][j] = 10 * do_div(a[i][j], period_us);
> +			do_div(b[i][j], period_us);
> +		}
> +	}
> +	printk(KERN_CRIT "CPU#%d Utilization every %us during lockup:\n",
better use "pr_crit", and was the original intent here microseconds (us) 
or milliseconds (ms)?
> +		smp_processor_id(), period_us/1000000);
better use "period_us /NSEC_PER_MSEC"?
> +	for (k = 0, i = tail; k < 5; k++, i = (i + 1) % 5) {

It seems that only i and j are necessary, k is not essential.

> +		printk(KERN_CRIT "\t#%d: %llu.%llu%% system,\t%llu.%llu%% softirq,\t"
> +			"%llu.%llu%% hardirq,\t%llu.%llu%% idle\n", k+1,
> +			a[i][CPUTIME_SYSTEM], b[i][CPUTIME_SYSTEM],
> +			a[i][CPUTIME_SOFTIRQ], b[i][CPUTIME_SOFTIRQ],
> +			a[i][CPUTIME_IRQ], b[i][CPUTIME_IRQ],
> +			a[i][CPUTIME_IDLE], b[i][CPUTIME_IDLE]);
> +	}
> +}
> +#else
> +static inline void update_cpustat(void) { }
> +static inline void print_cpustat(void) { }
> +#endif
> +
>   /* watchdog detector functions */
>   static DEFINE_PER_CPU(struct completion, softlockup_completion);
>   static DEFINE_PER_CPU(struct cpu_stop_work, softlockup_stop_work);
> @@ -504,6 +558,9 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>   	 */
>   	period_ts = READ_ONCE(*this_cpu_ptr(&watchdog_report_ts));
>   
> +	/* update cpu usage stat */
The function name already indicates that it involves graphs, so the 
comment here appears superfluous.
If a comment is absolutely necessary, please provide more detailed 
information.
> +	update_cpustat();
> +
>   	/* Reset the interval when touched by known problematic code. */
>   	if (period_ts == SOFTLOCKUP_DELAY_REPORT) {
>   		if (unlikely(__this_cpu_read(softlockup_touch_sync))) {
> @@ -539,6 +596,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>   		pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
>   			smp_processor_id(), duration,
>   			current->comm, task_pid_nr(current));
> +		print_cpustat();
>   		print_modules();
>   		print_irqtrace_events(current);
>   		if (regs)

