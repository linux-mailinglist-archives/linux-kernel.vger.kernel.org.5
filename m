Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A027EB092
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjKNNHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjKNNHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:07:49 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6978FD;
        Tue, 14 Nov 2023 05:07:44 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A7F2C15;
        Tue, 14 Nov 2023 05:08:29 -0800 (PST)
Received: from e129154.nice.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20B293F6C4;
        Tue, 14 Nov 2023 05:07:36 -0800 (PST)
Date:   Tue, 14 Nov 2023 14:06:44 +0100
From:   Beata Michalska <beata.michalska@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
        lukasz.luba@arm.com, ionela.voinescu@arm.com,
        pierre.gondois@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org
Subject: Re: [PATCH v6 7/7] arm64/amu: Use capacity_ref_freq to set AMU ratio
Message-ID: <ZVNw5Ci9kCPMqV67@e129154.nice.arm.com>
References: <20231109101438.1139696-1-vincent.guittot@linaro.org>
 <20231109101438.1139696-8-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109101438.1139696-8-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 11:14:38AM +0100, Vincent Guittot wrote:
> Use the new capacity_ref_freq to set the ratio that is used by AMU for
> computing the arch_scale_freq_capacity().
> This helps to keep everything aligned using the same reference for
> computing CPUs capacity.
> 
> The default value of the ratio (stored in per_cpu(arch_max_freq_scale))
> ensures that arch_scale_freq_capacity() returns max capacity until it is
> set to its correct value with the cpu capacity and capacity_ref_freq.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm64/kernel/topology.c  | 26 +++++++++++++-------------
>  drivers/base/arch_topology.c  | 12 +++++++++++-
>  include/linux/arch_topology.h |  1 +
>  3 files changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 817d788cd866..1a2c72f3e7f8 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -82,7 +82,12 @@ int __init parse_acpi_topology(void)
>  #undef pr_fmt
>  #define pr_fmt(fmt) "AMU: " fmt
>  
> -static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale);
> +/*
> + * Ensure that amu_scale_freq_tick() will return SCHED_CAPACITY_SCALE until
> + * the CPU capacity and its associated frequency have been correctly
> + * initialized.
> + */
> +static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale) =  1UL << (2 * SCHED_CAPACITY_SHIFT);
>  static DEFINE_PER_CPU(u64, arch_const_cycles_prev);
>  static DEFINE_PER_CPU(u64, arch_core_cycles_prev);
>  static cpumask_var_t amu_fie_cpus;
> @@ -112,14 +117,14 @@ static inline bool freq_counters_valid(int cpu)
>  	return true;
>  }
>  
> -static int freq_inv_set_max_ratio(int cpu, u64 max_rate, u64 ref_rate)
> +void freq_inv_set_max_ratio(int cpu, u64 max_rate)
>  {
> -	u64 ratio;
> +	u64 ratio, ref_rate = arch_timer_get_rate();
>  
>  	if (unlikely(!max_rate || !ref_rate)) {
> -		pr_debug("CPU%d: invalid maximum or reference frequency.\n",
> +		WARN_ONCE(1, "CPU%d: invalid maximum or reference frequency.\n",
>  			 cpu);
> -		return -EINVAL;
> +		return;
>  	}
>  
>  	/*
> @@ -139,12 +144,10 @@ static int freq_inv_set_max_ratio(int cpu, u64 max_rate, u64 ref_rate)
>  	ratio = div64_u64(ratio, max_rate);
>  	if (!ratio) {
>  		WARN_ONCE(1, "Reference frequency too low.\n");
> -		return -EINVAL;
> +		return;
>  	}
>  
> -	per_cpu(arch_max_freq_scale, cpu) = (unsigned long)ratio;
> -
> -	return 0;
> +	WRITE_ONCE(per_cpu(arch_max_freq_scale, cpu), (unsigned long)ratio);
>  }
>  
>  static void amu_scale_freq_tick(void)
> @@ -195,10 +198,7 @@ static void amu_fie_setup(const struct cpumask *cpus)
>  		return;
>  
>  	for_each_cpu(cpu, cpus) {
> -		if (!freq_counters_valid(cpu) ||
> -		    freq_inv_set_max_ratio(cpu,
> -					   cpufreq_get_hw_max_freq(cpu) * 1000ULL,
> -					   arch_timer_get_rate()))
> +		if (!freq_counters_valid(cpu))

>  			return;
>  	}
>  
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 0a2e43728286..0906114963ff 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -344,6 +344,10 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
>  	return !ret;
>  }
>  
> +void __weak freq_inv_set_max_ratio(int cpu, u64 max_rate)
> +{
> +}
> +
>  #ifdef CONFIG_ACPI_CPPC_LIB
>  #include <acpi/cppc_acpi.h>
>  
> @@ -381,6 +385,9 @@ void topology_init_cpu_capacity_cppc(void)
>  	}
>  
>  	for_each_possible_cpu(cpu) {
> +		freq_inv_set_max_ratio(cpu,
> +				       per_cpu(capacity_freq_ref, cpu) * HZ_PER_KHZ);
> +
>  		capacity = raw_capacity[cpu];
>  		capacity = div64_u64(capacity << SCHED_CAPACITY_SHIFT,
>  				     capacity_scale);
> @@ -422,8 +429,11 @@ init_cpu_capacity_callback(struct notifier_block *nb,
>  
>  	cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cpus);
>  
> -	for_each_cpu(cpu, policy->related_cpus)
> +	for_each_cpu(cpu, policy->related_cpus) {
>  		per_cpu(capacity_freq_ref, cpu) = policy->cpuinfo.max_freq;
> +		freq_inv_set_max_ratio(cpu,
> +				       per_cpu(capacity_freq_ref, cpu) * HZ_PER_KHZ);
> +	}
Just wondering if this is really necessary as freq_inv_set_max_ratio will
originally be called upon cpufreq notification being triggered (with
CPUFREQ_CREATE_POLICY event) which should happen after the newly introduced
capacity_freq_ref gets properly set up, so wouldn't the change of flipping
cpufreq_get_hw_max_freq(cpu) to capacity_freq_ref do just fine ?
Then pushing AMU specific call to generic arch code  would not be necessary.
Or did I miss smth on the way ?

---
BR
B.

>  
>  	if (cpumask_empty(cpus_to_visit)) {
>  		topology_normalize_cpu_scale();
> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> index 32c24ff4f2a8..a63d61ca55af 100644
> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -99,6 +99,7 @@ void update_siblings_masks(unsigned int cpu);
>  void remove_cpu_topology(unsigned int cpuid);
>  void reset_cpu_topology(void);
>  int parse_acpi_topology(void);
> +void freq_inv_set_max_ratio(int cpu, u64 max_rate);
>  #endif
>  
>  #endif /* _LINUX_ARCH_TOPOLOGY_H_ */
> -- 
> 2.34.1
> 
