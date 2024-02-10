Return-Path: <linux-kernel+bounces-60410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF79850485
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 14:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C053B229E7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 13:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F11D5380F;
	Sat, 10 Feb 2024 13:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iAcpXY9C"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7C31B971
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707571987; cv=none; b=B2/HuqnDnJGonz0VbRqWpakueFZo4np245PH9kS0+fCKwwzxiGq0SJOBoVjdKIodKQW0YnMGtU4f3gBpS/zTTJTgxcNdp+ZuYB2Rx1SCP3ODVVHbqibmngRwcM/7pYVEuoXTZEzXN4sVzj201rQoJOPFARyd91ywNu2cBNrSgiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707571987; c=relaxed/simple;
	bh=2sZ9E0/xTDqLlaH/qHjRSjD4cdH1/44z5u1OyOr6WMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z7QhhN04PFUf056tfWruCka7bhotozzEUb/8uWgtFukcVm713QXVY56AjP05+xBTcqveoUt0bYiQOS7mCkiWdJ0G9oYyDnnivVz6bwpqFO6UArf5gmt9dZ2mgX0LKDkm2mP/WmhbT4uwCLNmhOzdjvXkiZE8IqLJdUnbtGVUpFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iAcpXY9C; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707571975; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=99XXjLhf4MoYAImcI2IsHO8wd8GAAUQCn+cwMyrwLmM=;
	b=iAcpXY9C+JaJkgbbPZKSDzqSOpKBpR/FmwQNsFpLXqgI+e8QkJvABOoPRzVF+yuaFtbIXhChC8DdX91Gh+oVZRxEeq8KRxx5oDE9ISWwJKsm6AKy+4e1tDI/hHDIOJDkQH2x6JVI0TZIqne9itKqcJZ3xI4LdZ5hWurA7haSWx4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W0O8QJX_1707571973;
Received: from 30.120.175.242(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0W0O8QJX_1707571973)
          by smtp.aliyun-inc.com;
          Sat, 10 Feb 2024 21:32:54 +0800
Message-ID: <cea0ba13-23d5-4ef3-8d73-f08d84701710@linux.alibaba.com>
Date: Sat, 10 Feb 2024 21:32:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 1/2] watchdog/softlockup: low-overhead detection of
 interrupt
To: Bitao Hu <yaoma@linux.alibaba.com>, dianders@chromium.org,
 akpm@linux-foundation.org, pmladek@suse.com, kernelfans@gmail.com
Cc: linux-kernel@vger.kernel.org
References: <20240208125426.70511-1-yaoma@linux.alibaba.com>
 <20240208125426.70511-2-yaoma@linux.alibaba.com>
From: Liu Song <liusong@linux.alibaba.com>
In-Reply-To: <20240208125426.70511-2-yaoma@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Looks good！

Reviewed-by: Liu Song <liusong@linux.alibaba.com>

在 2024/2/8 20:54, Bitao Hu 写道:
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
>      #1: 0% system, 0% softirq, 100% hardirq, 0% idle
>      #2: 0% system, 0% softirq, 100% hardirq, 0% idle
>      #3: 0% system, 0% softirq, 100% hardirq, 0% idle
>      #4: 0% system, 0% softirq, 100% hardirq, 0% idle
>      #5: 0% system, 0% softirq, 100% hardirq, 0% idle
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
> The mechanism requires a considerable amount of global storage space
> when configured for the maximum number of CPUs. Therefore, adding a
> SOFTLOCKUP_DETECTOR_INTR_STORM Kconfig knob that defaults to "yes"
> if the max number of CPUs is <= 128.
>
> Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
> ---
>   kernel/watchdog.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++
>   lib/Kconfig.debug | 13 +++++++
>   2 files changed, 104 insertions(+)
>
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 81a8862295d6..380b60074f1d 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -16,6 +16,8 @@
>   #include <linux/cpu.h>
>   #include <linux/nmi.h>
>   #include <linux/init.h>
> +#include <linux/kernel_stat.h>
> +#include <linux/math64.h>
>   #include <linux/module.h>
>   #include <linux/sysctl.h>
>   #include <linux/tick.h>
> @@ -333,6 +335,92 @@ __setup("watchdog_thresh=", watchdog_thresh_setup);
>   
>   static void __lockup_detector_cleanup(void);
>   
> +#ifdef CONFIG_SOFTLOCKUP_DETECTOR_INTR_STORM
> +#define NUM_STATS_GROUPS	5
> +enum stats_per_group {
> +	STATS_SYSTEM,
> +	STATS_SOFTIRQ,
> +	STATS_HARDIRQ,
> +	STATS_IDLE,
> +	NUM_STATS_PER_GROUP,
> +};
> +
> +static const enum cpu_usage_stat tracked_stats[NUM_STATS_PER_GROUP] = {
> +	CPUTIME_SYSTEM,
> +	CPUTIME_SOFTIRQ,
> +	CPUTIME_IRQ,
> +	CPUTIME_IDLE,
> +};
> +
> +static DEFINE_PER_CPU(u16, cpustat_old[NUM_STATS_PER_GROUP]);
> +static DEFINE_PER_CPU(u8, cpustat_util[NUM_STATS_GROUPS][NUM_STATS_PER_GROUP]);
> +static DEFINE_PER_CPU(u8, cpustat_tail);
> +
> +/*
> + * We don't need nanosecond resolution. A granularity of 16ms is
> + * sufficient for our precision, allowing us to use u16 to store
> + * cpustats, which will roll over roughly every ~1000 seconds.
> + * 2^24 ~= 16 * 10^6
> + */
> +static u16 get_16bit_precision(u64 data_ns)
> +{
> +	return data_ns >> 24LL; /* 2^24ns ~= 16.8ms */
> +}
> +
> +static void update_cpustat(void)
> +{
> +	int i;
> +	u8 util;
> +	u16 old_stat, new_stat;
> +	struct kernel_cpustat kcpustat;
> +	u64 *cpustat = kcpustat.cpustat;
> +	u8 tail = __this_cpu_read(cpustat_tail);
> +	u16 sample_period_16 = get_16bit_precision(sample_period);
> +
> +	kcpustat_cpu_fetch(&kcpustat, smp_processor_id());
> +	for (i = 0; i < NUM_STATS_PER_GROUP; i++) {
> +		old_stat = __this_cpu_read(cpustat_old[i]);
> +		new_stat = get_16bit_precision(cpustat[tracked_stats[i]]);
> +		util = DIV_ROUND_UP(100 * (new_stat - old_stat), sample_period_16);
> +		__this_cpu_write(cpustat_util[tail][i], util);
> +		__this_cpu_write(cpustat_old[i], new_stat);
> +	}
> +	__this_cpu_write(cpustat_tail, (tail + 1) % NUM_STATS_GROUPS);
> +}
> +
> +static void print_cpustat(void)
> +{
> +	int i, group;
> +	u8 tail = __this_cpu_read(cpustat_tail);
> +	u64 sample_period_second = sample_period;
> +
> +	do_div(sample_period_second, NSEC_PER_SEC);
> +	/*
> +	 * We do not want the "watchdog: " prefix on every line,
> +	 * hence we use "printk" instead of "pr_crit".
> +	 */
> +	printk(KERN_CRIT "CPU#%d Utilization every %llus during lockup:\n",
> +	       smp_processor_id(), sample_period_second);
> +	for (i = 0; i < NUM_STATS_GROUPS; i++) {
> +		group = (tail + i) % NUM_STATS_GROUPS;
> +		printk(KERN_CRIT "\t#%d: %3u%% system,\t%3u%% softirq,\t"
> +			"%3u%% hardirq,\t%3u%% idle\n", i + 1,
> +			__this_cpu_read(cpustat_util[group][STATS_SYSTEM]),
> +			__this_cpu_read(cpustat_util[group][STATS_SOFTIRQ]),
> +			__this_cpu_read(cpustat_util[group][STATS_HARDIRQ]),
> +			__this_cpu_read(cpustat_util[group][STATS_IDLE]));
> +	}
> +}
> +
> +static void report_cpu_status(void)
> +{
> +	print_cpustat();
> +}
> +#else
> +static inline void update_cpustat(void) { }
> +static inline void report_cpu_status(void) { }
> +#endif
> +
>   /*
>    * Hard-lockup warnings should be triggered after just a few seconds. Soft-
>    * lockups can have false positives under extreme conditions. So we generally
> @@ -504,6 +592,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>   	 */
>   	period_ts = READ_ONCE(*this_cpu_ptr(&watchdog_report_ts));
>   
> +	update_cpustat();
> +
>   	/* Reset the interval when touched by known problematic code. */
>   	if (period_ts == SOFTLOCKUP_DELAY_REPORT) {
>   		if (unlikely(__this_cpu_read(softlockup_touch_sync))) {
> @@ -539,6 +629,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>   		pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
>   			smp_processor_id(), duration,
>   			current->comm, task_pid_nr(current));
> +		report_cpu_status();
>   		print_modules();
>   		print_irqtrace_events(current);
>   		if (regs)
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 975a07f9f1cc..49f652674bd8 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1029,6 +1029,19 @@ config SOFTLOCKUP_DETECTOR
>   	  chance to run.  The current stack trace is displayed upon
>   	  detection and the system will stay locked up.
>   
> +config SOFTLOCKUP_DETECTOR_INTR_STORM
> +	bool "Detect Interrupt Storm in Soft Lockups"
> +	depends on SOFTLOCKUP_DETECTOR && IRQ_TIME_ACCOUNTING
> +	default y if NR_CPUS <= 128
> +	help
> +	  Say Y here to enable the kernel to detect interrupt storm
> +	  during "soft lockups".
> +
> +	  "soft lockups" can be caused by a variety of reasons. If one is
> +	  caused by an interrupt storm, then the storming interrupts will not
> +	  be on the callstack. To detect this case, it is necessary to report
> +	  the CPU stats and the interrupt counts during the "soft lockups".
> +
>   config BOOTPARAM_SOFTLOCKUP_PANIC
>   	bool "Panic (Reboot) On Soft Lockups"
>   	depends on SOFTLOCKUP_DETECTOR

