Return-Path: <linux-kernel+bounces-6221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F041819614
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF3028742A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA0246B0;
	Wed, 20 Dec 2023 01:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FA8NfmAP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFB2440B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 01:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=aFf71YKlmBdavy5zuWJqFMWS/uiK5dKGj3zZ+PjZ9FY=; b=FA8NfmAPI3pUNkh4ps+a6iLirM
	ZtkIhBicbYm5PCmZ/SgIPeVWojMvE8KGdOoV2XUU6yVApUxkQ2RyjZyaAdlIwH6LlFBCzktkaKW6k
	ghtAfJ7b+AD58mpLeVSg+vX5GjlXSHQSaxzt0vB/1J61Ru3mDnRrftmSIEyT7VzBtRNJsbCXziILK
	aPPhSw+Bu8drCM4JosRAvPbfUwLZ7XsFzFL7SmIkWHBVdzX/Z1NP+k3AAvfVG/afRgScGbHWrr86G
	dl0YjgR5Vt315qwcoE2vkLnqyQ2JLSZy1yONxGogpPiXI1/ZtO1N4cPcQ+x1qAaLXFyHCvJtYuWHY
	btjabnwA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFl0L-00FrLp-38;
	Wed, 20 Dec 2023 01:04:10 +0000
Message-ID: <155363f0-26f5-4946-a36e-ee68b5887e60@infradead.org>
Date: Tue, 19 Dec 2023 17:04:08 -0800
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
 Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
References: <20231220001856.3710363-1-jstultz@google.com>
 <20231220001856.3710363-7-jstultz@google.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231220001856.3710363-7-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/19/23 16:18, John Stultz wrote:
> Add a CONFIG_SCHED_PROXY_EXEC option, along with a boot argument
> sched_prox_exec= that can be used to disable the feature at boot

  sched_proxy_exec=

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
>   suggested by Metin Kaya.
> * Switch boot arg from =disable/enable to use kstrtobool(),
>   which supports =yes|no|1|0|true|false|on|off, as also
>   suggested by Metin Kaya, and print a message when a boot
>   argument is used.
> ---
>  .../admin-guide/kernel-parameters.txt         |  5 ++++
>  include/linux/sched.h                         | 13 +++++++++
>  init/Kconfig                                  |  7 +++++
>  kernel/sched/core.c                           | 29 +++++++++++++++++++
>  4 files changed, 54 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 65731b060e3f..cc64393b913f 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5714,6 +5714,11 @@
>  	sa1100ir	[NET]
>  			See drivers/net/irda/sa1100_ir.c.
>  
> +	sched_proxy_exec= [KNL]
> +			Enables or disables "proxy execution" style
> +			solution to mutex based priority inversion.

			            mutex-based

> +			Format: <bool>
> +
>  	sched_verbose	[KNL] Enables verbose scheduler debug messages.
>  
>  	schedstats=	[KNL,X86] Enable or disable scheduled statistics.
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index bfe8670f99a1..880af1c3097d 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1566,6 +1566,19 @@ struct task_struct {
>  	 */
>  };
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
>  static inline struct pid *task_pid(struct task_struct *task)
>  {
>  	return task->thread_pid;
> diff --git a/init/Kconfig b/init/Kconfig
> index 9ffb103fc927..c5a759b6366a 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -908,6 +908,13 @@ config NUMA_BALANCING_DEFAULT_ENABLED
>  	  If set, automatic NUMA balancing will be enabled if running on a NUMA
>  	  machine.
>  
> +config SCHED_PROXY_EXEC
> +	bool "Proxy Execution"
> +	default n
> +	help
> +	  This option enables proxy execution, a mechanism for mutex owning

	                                                       mutex-owning

> +	  tasks to inherit the scheduling context of higher priority waiters.
> +
>  menuconfig CGROUPS
>  	bool "Control Group support"
>  	select KERNFS
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 4e46189d545d..e06558fb08aa 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -117,6 +117,35 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
>  
>  DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
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

Preferably s/boottime/boot time/.

> +	return 0;
> +}
> +#endif
> +__setup("sched_proxy_exec=", setup_proxy_exec);
> +
>  #ifdef CONFIG_SCHED_DEBUG
>  /*
>   * Debugging: various feature bits

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

