Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565617FC293
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346514AbjK1PxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346475AbjK1Pww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:52:52 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B7BA1727;
        Tue, 28 Nov 2023 07:52:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7ADAEC15;
        Tue, 28 Nov 2023 07:53:39 -0800 (PST)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.78.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A50C33F6C4;
        Tue, 28 Nov 2023 07:52:51 -0800 (PST)
Date:   Tue, 28 Nov 2023 15:52:50 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
        lukasz.luba@arm.com, pierre.gondois@arm.com,
        beata.michalska@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org
Subject: Re: [PATCH v6 1/7] topology: Add a new arch_scale_freq_reference
Message-ID: <ZWYM0hn28RHjAalh@arm.com>
References: <20231109101438.1139696-1-vincent.guittot@linaro.org>
 <20231109101438.1139696-2-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109101438.1139696-2-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

I have a small request on this patch, which is useful for [1].
I'll detail what is needed lower in the code.

[1] https://lore.kernel.org/lkml/ZWYDr6JJJzBvsqf0@arm.com/

On Thursday 09 Nov 2023 at 11:14:32 (+0100), Vincent Guittot wrote:
> Create a new method to get a unique and fixed max frequency. Currently
> cpuinfo.max_freq or the highest (or last) state of performance domain are
> used as the max frequency when computing the frequency for a level of
> utilization but:
> - cpuinfo_max_freq can change at runtime. boost is one example of
>   such change.
> - cpuinfo.max_freq and last item of the PD can be different leading to
>   different results between cpufreq and energy model.
> 
> We need to save the reference frequency that has been used when computing
> the CPUs capacity and use this fixed and coherent value to convert between
> frequency and CPU's capacity.
> 
> In fact, we already save the frequency that has been used when computing
> the capacity of each CPU. We extend the precision to save kHz instead of
> MHz currently and we modify the type to be aligned with other variables
> used when converting frequency to capacity and the other way.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Tested-by: Lukasz Luba <lukasz.luba@arm.com>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm/include/asm/topology.h   |  1 +
>  arch/arm64/include/asm/topology.h |  1 +
>  arch/riscv/include/asm/topology.h |  1 +
>  drivers/base/arch_topology.c      | 29 ++++++++++++++---------------
>  include/linux/arch_topology.h     |  7 +++++++
>  include/linux/sched/topology.h    |  8 ++++++++
>  6 files changed, 32 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
> index c7d2510e5a78..853c4f81ba4a 100644
> --- a/arch/arm/include/asm/topology.h
> +++ b/arch/arm/include/asm/topology.h
> @@ -13,6 +13,7 @@
>  #define arch_set_freq_scale topology_set_freq_scale
>  #define arch_scale_freq_capacity topology_get_freq_scale
>  #define arch_scale_freq_invariant topology_scale_freq_invariant
> +#define arch_scale_freq_ref topology_get_freq_ref
>  #endif
>  
>  /* Replace task scheduler's default cpu-invariant accounting */
> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
> index 9fab663dd2de..a323b109b9c4 100644
> --- a/arch/arm64/include/asm/topology.h
> +++ b/arch/arm64/include/asm/topology.h
> @@ -23,6 +23,7 @@ void update_freq_counters_refs(void);
>  #define arch_set_freq_scale topology_set_freq_scale
>  #define arch_scale_freq_capacity topology_get_freq_scale
>  #define arch_scale_freq_invariant topology_scale_freq_invariant
> +#define arch_scale_freq_ref topology_get_freq_ref
>  
>  #ifdef CONFIG_ACPI_CPPC_LIB
>  #define arch_init_invariance_cppc topology_init_cpu_capacity_cppc
> diff --git a/arch/riscv/include/asm/topology.h b/arch/riscv/include/asm/topology.h
> index e316ab3b77f3..61183688bdd5 100644
> --- a/arch/riscv/include/asm/topology.h
> +++ b/arch/riscv/include/asm/topology.h
> @@ -9,6 +9,7 @@
>  #define arch_set_freq_scale		topology_set_freq_scale
>  #define arch_scale_freq_capacity	topology_get_freq_scale
>  #define arch_scale_freq_invariant	topology_scale_freq_invariant
> +#define arch_scale_freq_ref		topology_get_freq_ref
>  
>  /* Replace task scheduler's default cpu-invariant accounting */
>  #define arch_scale_cpu_capacity	topology_get_cpu_scale
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index b741b5ba82bd..e8d1cdf1f761 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -19,6 +19,7 @@
>  #include <linux/init.h>
>  #include <linux/rcupdate.h>
>  #include <linux/sched.h>
> +#include <linux/units.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/thermal_pressure.h>
> @@ -26,7 +27,8 @@
>  static DEFINE_PER_CPU(struct scale_freq_data __rcu *, sft_data);
>  static struct cpumask scale_freq_counters_mask;
>  static bool scale_freq_invariant;
> -static DEFINE_PER_CPU(u32, freq_factor) = 1;
> +DEFINE_PER_CPU(unsigned long, capacity_freq_ref) = 1;

It would be good for this to be initialized to 0 for other users that
might want to detect when capacity_freq_ref was not yet set.

> +EXPORT_PER_CPU_SYMBOL_GPL(capacity_freq_ref);
>  
>  static bool supports_scale_freq_counters(const struct cpumask *cpus)
>  {
> @@ -170,9 +172,9 @@ DEFINE_PER_CPU(unsigned long, thermal_pressure);
>   * operating on stale data when hot-plug is used for some CPUs. The
>   * @capped_freq reflects the currently allowed max CPUs frequency due to
>   * thermal capping. It might be also a boost frequency value, which is bigger
> - * than the internal 'freq_factor' max frequency. In such case the pressure
> - * value should simply be removed, since this is an indication that there is
> - * no thermal throttling. The @capped_freq must be provided in kHz.
> + * than the internal 'capacity_freq_ref' max frequency. In such case the
> + * pressure value should simply be removed, since this is an indication that
> + * there is no thermal throttling. The @capped_freq must be provided in kHz.
>   */
>  void topology_update_thermal_pressure(const struct cpumask *cpus,
>  				      unsigned long capped_freq)
> @@ -183,10 +185,7 @@ void topology_update_thermal_pressure(const struct cpumask *cpus,
>  
>  	cpu = cpumask_first(cpus);
>  	max_capacity = arch_scale_cpu_capacity(cpu);
> -	max_freq = per_cpu(freq_factor, cpu);
> -
> -	/* Convert to MHz scale which is used in 'freq_factor' */
> -	capped_freq /= 1000;
> +	max_freq = arch_scale_freq_ref(cpu);
>  
>  	/*
>  	 * Handle properly the boost frequencies, which should simply clean
> @@ -279,13 +278,13 @@ void topology_normalize_cpu_scale(void)
>  
>  	capacity_scale = 1;
>  	for_each_possible_cpu(cpu) {
> -		capacity = raw_capacity[cpu] * per_cpu(freq_factor, cpu);
> +		capacity = raw_capacity[cpu] * per_cpu(capacity_freq_ref, cpu);

The only affected code that I could find is here and below.

The above line would have to change to:
capacity = raw_capacity[cpu] * per_cpu(capacity_freq_ref, cpu) ?: 1;

>  		capacity_scale = max(capacity, capacity_scale);
>  	}
>  
>  	pr_debug("cpu_capacity: capacity_scale=%llu\n", capacity_scale);
>  	for_each_possible_cpu(cpu) {
> -		capacity = raw_capacity[cpu] * per_cpu(freq_factor, cpu);
> +		capacity = raw_capacity[cpu] * per_cpu(capacity_freq_ref, cpu);

and here:
capacity = raw_capacity[cpu] * per_cpu(capacity_freq_ref, cpu) ?: 1;

I think it's nicer to start with capacity_freq_ref as 0 and compensate here
for uninitialized capacity_freq_ref.

Let me know if this is alright of if you'd prefer us to make this change
in a separate patch.

Thanks,
Ionela.

>  		capacity = div64_u64(capacity << SCHED_CAPACITY_SHIFT,
>  			capacity_scale);
>  		topology_set_cpu_scale(cpu, capacity);
> @@ -321,15 +320,15 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
>  			cpu_node, raw_capacity[cpu]);
>  
>  		/*
> -		 * Update freq_factor for calculating early boot cpu capacities.
> +		 * Update capacity_freq_ref for calculating early boot cpu capacities.
>  		 * For non-clk CPU DVFS mechanism, there's no way to get the
>  		 * frequency value now, assuming they are running at the same
> -		 * frequency (by keeping the initial freq_factor value).
> +		 * frequency (by keeping the initial capacity_freq_ref value).
>  		 */
>  		cpu_clk = of_clk_get(cpu_node, 0);
>  		if (!PTR_ERR_OR_ZERO(cpu_clk)) {
> -			per_cpu(freq_factor, cpu) =
> -				clk_get_rate(cpu_clk) / 1000;
> +			per_cpu(capacity_freq_ref, cpu) =
> +				clk_get_rate(cpu_clk) / HZ_PER_KHZ;
>  			clk_put(cpu_clk);
>  		}
>  	} else {
> @@ -411,7 +410,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
>  	cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cpus);
>  
>  	for_each_cpu(cpu, policy->related_cpus)
> -		per_cpu(freq_factor, cpu) = policy->cpuinfo.max_freq / 1000;
> +		per_cpu(capacity_freq_ref, cpu) = policy->cpuinfo.max_freq;
>  
>  	if (cpumask_empty(cpus_to_visit)) {
>  		topology_normalize_cpu_scale();
> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> index a07b510e7dc5..32c24ff4f2a8 100644
> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -27,6 +27,13 @@ static inline unsigned long topology_get_cpu_scale(int cpu)
>  
>  void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity);
>  
> +DECLARE_PER_CPU(unsigned long, capacity_freq_ref);
> +
> +static inline unsigned long topology_get_freq_ref(int cpu)
> +{
> +	return per_cpu(capacity_freq_ref, cpu);
> +}
> +
>  DECLARE_PER_CPU(unsigned long, arch_freq_scale);
>  
>  static inline unsigned long topology_get_freq_scale(int cpu)
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index de545ba85218..a6e04b4a21d7 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -279,6 +279,14 @@ void arch_update_thermal_pressure(const struct cpumask *cpus,
>  { }
>  #endif
>  
> +#ifndef arch_scale_freq_ref
> +static __always_inline
> +unsigned int arch_scale_freq_ref(int cpu)
> +{
> +	return 0;
> +}
> +#endif
> +
>  static inline int task_node(const struct task_struct *p)
>  {
>  	return cpu_to_node(task_cpu(p));
> -- 
> 2.34.1
> 
