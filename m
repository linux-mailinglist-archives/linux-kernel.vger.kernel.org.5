Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD6279172C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 14:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352832AbjIDMej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 08:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236987AbjIDMei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 08:34:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19BA01A7;
        Mon,  4 Sep 2023 05:34:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B4AB143D;
        Mon,  4 Sep 2023 05:35:10 -0700 (PDT)
Received: from [10.57.93.88] (unknown [10.57.93.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5B373F793;
        Mon,  4 Sep 2023 05:34:27 -0700 (PDT)
Message-ID: <840cb103-8ffb-9798-05a3-a557f78f7f7a@arm.com>
Date:   Mon, 4 Sep 2023 13:35:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/4] topology: add a new arch_scale_freq_reference
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     conor.dooley@microchip.com, linux-arm-kernel@lists.infradead.org,
        suagrfillet@gmail.com, juri.lelli@redhat.com, sudeep.holla@arm.com,
        palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        ajones@ventanamicro.com, lftan@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux@armlinux.org.uk, bristot@redhat.com, catalin.marinas@arm.com,
        bsegall@google.com, will@kernel.org, vschneid@redhat.com,
        rostedt@goodmis.org, rafael@kernel.org, dietmar.eggemann@arm.com,
        aou@eecs.berkeley.edu, mingo@redhat.com, paul.walmsley@sifive.com,
        mgorman@suse.de, gregkh@linuxfoundation.org, peterz@infradead.org,
        viresh.kumar@linaro.org
References: <20230901130312.247719-1-vincent.guittot@linaro.org>
 <20230901130312.247719-3-vincent.guittot@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20230901130312.247719-3-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,


On 9/1/23 14:03, Vincent Guittot wrote:
> Create a new method to get a unique and fixed max frequency. Currently
> cpuinfo.max_freq or last item of performance domain are used as the max
> frequency when computing the frequency for a level of utilization but:
> - cpuinfo_max_freq can change at runtime. boost is one example of
>    such change.
> - cpuinfo.max_freq and last item of the PD can be different leading to
>    different results betwen cpufreq and energy model.
> 
> We need to save the max frequency that has been used when computing the
> CPUs capacity and use this fixed and coherent value to convert between
> frequency and CPU's capacity.
> 
> In fact, we already save the frequency that has been used when computing
> the capacity of each CPU. We extend the precision to save khZ instead of
> Mhz currently and we modify the type to be aligned with other variables
> used when converting frequency to capacity and the other way.

I do like this 'kHz' change. We also use kHz in the EM, so better
aligned now.

> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>   arch/arm/include/asm/topology.h   | 1 +
>   arch/arm64/include/asm/topology.h | 1 +
>   arch/riscv/include/asm/topology.h | 1 +
>   drivers/base/arch_topology.c      | 9 +++------
>   include/linux/arch_topology.h     | 7 +++++++
>   5 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
> index c7d2510e5a78..853c4f81ba4a 100644
> --- a/arch/arm/include/asm/topology.h
> +++ b/arch/arm/include/asm/topology.h
> @@ -13,6 +13,7 @@
>   #define arch_set_freq_scale topology_set_freq_scale
>   #define arch_scale_freq_capacity topology_get_freq_scale
>   #define arch_scale_freq_invariant topology_scale_freq_invariant
> +#define arch_scale_freq_ref topology_get_freq_ref
>   #endif
>   
>   /* Replace task scheduler's default cpu-invariant accounting */
> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
> index 9fab663dd2de..a323b109b9c4 100644
> --- a/arch/arm64/include/asm/topology.h
> +++ b/arch/arm64/include/asm/topology.h
> @@ -23,6 +23,7 @@ void update_freq_counters_refs(void);
>   #define arch_set_freq_scale topology_set_freq_scale
>   #define arch_scale_freq_capacity topology_get_freq_scale
>   #define arch_scale_freq_invariant topology_scale_freq_invariant
> +#define arch_scale_freq_ref topology_get_freq_ref
>   
>   #ifdef CONFIG_ACPI_CPPC_LIB
>   #define arch_init_invariance_cppc topology_init_cpu_capacity_cppc
> diff --git a/arch/riscv/include/asm/topology.h b/arch/riscv/include/asm/topology.h
> index e316ab3b77f3..61183688bdd5 100644
> --- a/arch/riscv/include/asm/topology.h
> +++ b/arch/riscv/include/asm/topology.h
> @@ -9,6 +9,7 @@
>   #define arch_set_freq_scale		topology_set_freq_scale
>   #define arch_scale_freq_capacity	topology_get_freq_scale
>   #define arch_scale_freq_invariant	topology_scale_freq_invariant
> +#define arch_scale_freq_ref		topology_get_freq_ref
>   
>   /* Replace task scheduler's default cpu-invariant accounting */
>   #define arch_scale_cpu_capacity	topology_get_cpu_scale
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index b741b5ba82bd..75fa67477a9d 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -26,7 +26,7 @@
>   static DEFINE_PER_CPU(struct scale_freq_data __rcu *, sft_data);
>   static struct cpumask scale_freq_counters_mask;
>   static bool scale_freq_invariant;
> -static DEFINE_PER_CPU(u32, freq_factor) = 1;
> +DEFINE_PER_CPU(unsigned long, freq_factor) = 1;

Why it's not static now?

>   
>   static bool supports_scale_freq_counters(const struct cpumask *cpus)
>   {
> @@ -183,10 +183,7 @@ void topology_update_thermal_pressure(const struct cpumask *cpus,
>   
>   	cpu = cpumask_first(cpus);
>   	max_capacity = arch_scale_cpu_capacity(cpu);
> -	max_freq = per_cpu(freq_factor, cpu);
> -
> -	/* Convert to MHz scale which is used in 'freq_factor' */
> -	capped_freq /= 1000;
> +	max_freq = arch_scale_freq_ref(cpu);
>   
>   	/*
>   	 * Handle properly the boost frequencies, which should simply clean
> @@ -411,7 +408,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
>   	cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cpus);
>   
>   	for_each_cpu(cpu, policy->related_cpus)
> -		per_cpu(freq_factor, cpu) = policy->cpuinfo.max_freq / 1000;
> +		per_cpu(freq_factor, cpu) = policy->cpuinfo.max_freq;
>   
>   	if (cpumask_empty(cpus_to_visit)) {
>   		topology_normalize_cpu_scale();
> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> index a07b510e7dc5..7a2dba9c3dc0 100644
> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -27,6 +27,13 @@ static inline unsigned long topology_get_cpu_scale(int cpu)
>   
>   void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity);
>   
> +DECLARE_PER_CPU(unsigned long, freq_factor);
> +
> +static inline unsigned long topology_get_freq_ref(int cpu)
> +{
> +	return per_cpu(freq_factor, cpu);
> +}
> +
>   DECLARE_PER_CPU(unsigned long, arch_freq_scale);
>   
>   static inline unsigned long topology_get_freq_scale(int cpu)

Apart from that 'static' missing, that looks good.

Regards,
Lukasz
