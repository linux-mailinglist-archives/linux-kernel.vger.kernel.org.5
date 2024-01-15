Return-Path: <linux-kernel+bounces-25935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFFF82D884
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E39C51C21842
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5922B2C68C;
	Mon, 15 Jan 2024 11:44:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3231E4BF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 11:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BDDA2F4;
	Mon, 15 Jan 2024 03:45:05 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.91.116])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A36743F5A1;
	Mon, 15 Jan 2024 03:44:17 -0800 (PST)
Date: Mon, 15 Jan 2024 11:44:12 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Huang Shijie <shijie@os.amperecomputing.com>
Cc: catalin.marinas@arm.com, patches@amperecomputing.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: implement arm64 specific cpu_to_node
Message-ID: <ZaUajJbKGywgC-AX@FVFF77S0Q05N>
References: <20240115095931.53765-1-shijie@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115095931.53765-1-shijie@os.amperecomputing.com>

On Mon, Jan 15, 2024 at 05:59:31PM +0800, Huang Shijie wrote:
> After setting the right NUMA node for VMAP stack,
>   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?id=75b5e0bf90bf
> 
> I found there are at least four places in the common code where
> the cpu_to_node() is called before it is initialized:
>    0.) early_trace_init()         in kernel/trace/trace.c
>    1.) sched_init()               in kernel/sched/core.c
>    2.) init_sched_fair_class()    in kernel/sched/fair.c
>    3.) workqueue_init_early()     in kernel/workqueue.c
> 
> We cannot use early_cpu_to_node() for them, since early_cpu_to_node()
> does not work for some ARCHs, such as x86, riscv, etc.

I spot that x86 seems to have an implementation of early_cpu_to_node(); what's
wrong with it?

> So we have to implement the arm64 specific cpu_to_node().

Surely those early uses of cpu_to_node() are equally broken on those other
architectures, so why should this be specific to arm64?

> This patch
>    0.) introduces the __cpu_to_node function pointer,
>        and exports it for kernel modules.
> 
>    1.) defines a macro cpu_to_node to override the
>        generic percpu implementation of cpu_to_node.
> 
>    2.) __cpu_to_node is initialized with early_cpu_to_node() before
>        numa_node is initialized.
> 
>    3.) __cpu_to_node is set to arm64_cpu_to_node() when numa_node is ready.
>       arm64_cpu_to_node() is a clone of the generic cpu_to_node().

I don't think this is the right approach. Regardlesss of anything else, we
shouldn't have a solution that only fixes arm64.

Why can't we mandate an early_cpu_to_node(), and have the other architectures
implement that?

Why can't we change cpu_to_node() to automatically do the right thing?

Mark.

> 
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> ---
>  arch/arm64/include/asm/topology.h |  4 ++++
>  arch/arm64/kernel/smp.c           | 21 ++++++++++++++++++++-
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
> index a323b109b9c4..3e99b40b5f9f 100644
> --- a/arch/arm64/include/asm/topology.h
> +++ b/arch/arm64/include/asm/topology.h
> @@ -12,6 +12,10 @@ int pcibus_to_node(struct pci_bus *bus);
>  				 cpu_all_mask :				\
>  				 cpumask_of_node(pcibus_to_node(bus)))
>  
> +/* override generic percpu implementation of cpu_to_node */
> +extern int (*__cpu_to_node)(int cpu);
> +#define cpu_to_node(cpu) __cpu_to_node(cpu)
> +
>  #endif /* CONFIG_NUMA */
>  
>  #include <linux/arch_topology.h>
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 4ced34f62dab..8a3bc101eaed 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -90,6 +90,21 @@ static struct irq_desc *ipi_desc[MAX_IPI] __ro_after_init;
>  
>  static void ipi_setup(int cpu);
>  
> +int (*__cpu_to_node)(int cpu);
> +EXPORT_SYMBOL(__cpu_to_node);
> +
> +#ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
> +static int arm64_cpu_to_node(int cpu)
> +{
> +	return per_cpu(numa_node, cpu);
> +}
> +#else
> +static int arm64_cpu_to_node(int cpu)
> +{
> +	return 0;
> +}
> +#endif
> +
>  #ifdef CONFIG_HOTPLUG_CPU
>  static void ipi_teardown(int cpu);
>  static int op_cpu_kill(unsigned int cpu);
> @@ -613,6 +628,7 @@ static void __init acpi_parse_and_init_cpus(void)
>  
>  	for (i = 0; i < nr_cpu_ids; i++)
>  		early_map_cpu_to_node(i, acpi_numa_get_nid(i));
> +	__cpu_to_node = early_cpu_to_node;
>  }
>  #else
>  #define acpi_parse_and_init_cpus(...)	do { } while (0)
> @@ -674,6 +690,7 @@ static void __init of_parse_and_init_cpus(void)
>  next:
>  		cpu_count++;
>  	}
> +	__cpu_to_node = early_cpu_to_node;
>  }
>  
>  /*
> @@ -733,7 +750,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>  	 * secondary CPUs present.
>  	 */
>  	if (max_cpus == 0)
> -		return;
> +		goto out;
>  
>  	/*
>  	 * Initialise the present map (which describes the set of CPUs
> @@ -758,6 +775,8 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>  		set_cpu_present(cpu, true);
>  		numa_store_cpu_info(cpu);
>  	}
> +out:
> +	__cpu_to_node = arm64_cpu_to_node;
>  }
>  
>  static const char *ipi_types[NR_IPI] __tracepoint_string = {
> -- 
> 2.40.1
> 

