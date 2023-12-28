Return-Path: <linux-kernel+bounces-12725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA15781F959
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A205B23433
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F65D526;
	Thu, 28 Dec 2023 15:06:21 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E7FD2E6
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D8FB2F4;
	Thu, 28 Dec 2023 07:07:03 -0800 (PST)
Received: from [10.57.87.187] (unknown [10.57.87.187])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CC293F64C;
	Thu, 28 Dec 2023 07:06:14 -0800 (PST)
Message-ID: <b038f966-95b9-49c6-baa3-f51ef64d5f69@arm.com>
Date: Thu, 28 Dec 2023 15:06:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/23] sched: Add CONFIG_SCHED_PROXY_EXEC & boot
 argument to enable/disable
Content-Language: en-US
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Joel Fernandes <joelaf@google.com>, Qais Yousef <qyousef@google.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat
 <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 kernel-team@android.com
References: <20231220001856.3710363-1-jstultz@google.com>
 <20231220001856.3710363-7-jstultz@google.com>
From: Metin Kaya <metin.kaya@arm.com>
In-Reply-To: <20231220001856.3710363-7-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/12/2023 12:18 am, John Stultz wrote:
> Add a CONFIG_SCHED_PROXY_EXEC option, along with a boot argument
> sched_prox_exec= that can be used to disable the feature at boot
> time if CONFIG_SCHED_PROXY_EXEC was enabled.
> 
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Qais Yousef <qyousef@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Zimuzo Ezeozue <zezeozue@google.com>
> Cc: Youssef Esmat <youssefesmat@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Metin Kaya <Metin.Kaya@arm.com>
> Cc: Xuewen Yan <xuewen.yan94@gmail.com>
> Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: kernel-team@android.com
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
> v7:
> * Switch to CONFIG_SCHED_PROXY_EXEC/sched_proxy_exec= as
>    suggested by Metin Kaya.
> * Switch boot arg from =disable/enable to use kstrtobool(),
>    which supports =yes|no|1|0|true|false|on|off, as also
>    suggested by Metin Kaya, and print a message when a boot
>    argument is used.
> ---
>   .../admin-guide/kernel-parameters.txt         |  5 ++++
>   include/linux/sched.h                         | 13 +++++++++
>   init/Kconfig                                  |  7 +++++
>   kernel/sched/core.c                           | 29 +++++++++++++++++++
>   4 files changed, 54 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 65731b060e3f..cc64393b913f 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5714,6 +5714,11 @@
>   	sa1100ir	[NET]
>   			See drivers/net/irda/sa1100_ir.c.
>   
> +	sched_proxy_exec= [KNL]
> +			Enables or disables "proxy execution" style
> +			solution to mutex based priority inversion.
> +			Format: <bool>
> +
>   	sched_verbose	[KNL] Enables verbose scheduler debug messages.
>   
>   	schedstats=	[KNL,X86] Enable or disable scheduled statistics.
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index bfe8670f99a1..880af1c3097d 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1566,6 +1566,19 @@ struct task_struct {
>   	 */
>   };
>   
> +#ifdef CONFIG_SCHED_PROXY_EXEC
> +DECLARE_STATIC_KEY_TRUE(__sched_proxy_exec);
> +static inline bool sched_proxy_exec(void)
> +{
> +	return static_branch_likely(&__sched_proxy_exec);
> +}
> +#else
> +static inline bool sched_proxy_exec(void)
> +{
> +	return false;
> +}
> +#endif
> +
>   static inline struct pid *task_pid(struct task_struct *task)
>   {
>   	return task->thread_pid;
> diff --git a/init/Kconfig b/init/Kconfig
> index 9ffb103fc927..c5a759b6366a 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -908,6 +908,13 @@ config NUMA_BALANCING_DEFAULT_ENABLED
>   	  If set, automatic NUMA balancing will be enabled if running on a NUMA
>   	  machine.
>   
> +config SCHED_PROXY_EXEC
> +	bool "Proxy Execution"
> +	default n
> +	help
> +	  This option enables proxy execution, a mechanism for mutex owning
> +	  tasks to inherit the scheduling context of higher priority waiters.
> +

Should `SCHED_PROXY_EXEC` config option be under `Scheduler features` menu?

>   menuconfig CGROUPS
>   	bool "Control Group support"
>   	select KERNFS
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 4e46189d545d..e06558fb08aa 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -117,6 +117,35 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
>   
>   DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
>   
> +#ifdef CONFIG_SCHED_PROXY_EXEC
> +DEFINE_STATIC_KEY_TRUE(__sched_proxy_exec);
> +static int __init setup_proxy_exec(char *str)
> +{
> +	bool proxy_enable;
> +
> +	if (kstrtobool(str, &proxy_enable)) {
> +		pr_warn("Unable to parse sched_proxy_exec=\n");
> +		return 0;
> +	}
> +
> +	if (proxy_enable) {
> +		pr_info("sched_proxy_exec enabled via boot arg\n");
> +		static_branch_enable(&__sched_proxy_exec);
> +	} else {
> +		pr_info("sched_proxy_exec disabled via boot arg\n");
> +		static_branch_disable(&__sched_proxy_exec);
> +	}
> +	return 1;
> +}
> +#else
> +static int __init setup_proxy_exec(char *str)
> +{
> +	pr_warn("CONFIG_SCHED_PROXY_EXEC=n, so it cannot be enabled or disabled at boottime\n");
> +	return 0;
> +}
> +#endif
> +__setup("sched_proxy_exec=", setup_proxy_exec);
> +
>   #ifdef CONFIG_SCHED_DEBUG
>   /*
>    * Debugging: various feature bits


