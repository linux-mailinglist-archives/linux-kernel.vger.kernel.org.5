Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD072792A8C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242666AbjIEQjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354176AbjIEKFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:05:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E42790;
        Tue,  5 Sep 2023 03:05:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB74011FB;
        Tue,  5 Sep 2023 03:06:17 -0700 (PDT)
Received: from [10.34.100.102] (e126645.nice.arm.com [10.34.100.102])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D616D3F793;
        Tue,  5 Sep 2023 03:05:35 -0700 (PDT)
Message-ID: <cd795543-53db-ed14-e9dd-b5738a4f3b9d@arm.com>
Date:   Tue, 5 Sep 2023 12:05:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/4] energy_model: use a fixed reference frequency
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org
References: <20230901130312.247719-1-vincent.guittot@linaro.org>
 <20230901130312.247719-5-vincent.guittot@linaro.org>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20230901130312.247719-5-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vincent,
I tried the patch-set on a platform using cppc_cpufreq and that has boosting
frequencies,

1-
On such platform, the CPU capacity comes from the CPPC highest_frequency
field. The CPU capacity is set to the capacity of the boosting frequency.
This behaviour is different from DT platforms where the CPU capacity is
updated whenever the boosting mode is enabled (it seems).

Wouldn't it be better to have CPU max capacities set to their boosting
capacity as for CPPC base platforms ? It seems the max frequency is always
available somehow for all the cpufreq drivers with boosting available, i.e.
acpi-cpufreq, amd-pstate, cppc_cpufreq.


2-
On the CPPC based platforms, the per_cpu freq_factor is not used/updated,
meaning that we have:
arch_scale_freq_ref_em()
\-arch_scale_freq_ref()
   \-topology_get_freq_ref()
     \-per_cpu(freq_factor, cpu) (set to the default value: 1)
and em_cpu_energy()'s ref_freq variable is then set to 1 instead of the max
frequency (leading to a 0 energy computation).

3-
Also just in case, arch_scale_freq_ref_policy() and cpufreq_get_hw_max_freq()
seem to have close (but not identical) purpose,

Regards,
Pierre

On 9/1/23 15:03, Vincent Guittot wrote:
> The last item of a performance domain is not always the performance point
> that has been used to compute CPU's capacity. This can lead to different
> target frequency compared with other part of the system like schedutil and
> would result in wrong energy estimation.
> 
> a new arch_scale_freq_ref() is available to return a fixed and coherent
> frequency reference that can be used when computing the CPU's frequency
> for an level of utilization. Use this function when available or fallback
> to the last performance domain item otherwise.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>   include/linux/energy_model.h | 20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index b9caa01dfac4..7ee07be6928e 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -204,6 +204,20 @@ struct em_perf_state *em_pd_get_efficient_state(struct em_perf_domain *pd,
>   	return ps;
>   }
>   
> +#ifdef arch_scale_freq_ref
> +static __always_inline
> +unsigned long  arch_scale_freq_ref_em(int cpu, struct em_perf_domain *pd)
> +{
> +	return arch_scale_freq_ref(cpu);
> +}
> +#else
> +static __always_inline
> +unsigned long  arch_scale_freq_ref_em(int cpu, struct em_perf_domain *pd)
> +{
> +	return pd->table[pd->nr_perf_states - 1].frequency;
> +}
> +#endif
> +
>   /**
>    * em_cpu_energy() - Estimates the energy consumed by the CPUs of a
>    *		performance domain
> @@ -224,7 +238,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>   				unsigned long max_util, unsigned long sum_util,
>   				unsigned long allowed_cpu_cap)
>   {
> -	unsigned long freq, scale_cpu;
> +	unsigned long freq, ref_freq, scale_cpu;
>   	struct em_perf_state *ps;
>   	int cpu;
>   
> @@ -241,11 +255,11 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>   	 */
>   	cpu = cpumask_first(to_cpumask(pd->cpus));
>   	scale_cpu = arch_scale_cpu_capacity(cpu);
> -	ps = &pd->table[pd->nr_perf_states - 1];
> +	ref_freq = arch_scale_freq_ref_em(cpu, pd);
>   
>   	max_util = map_util_perf(max_util);
>   	max_util = min(max_util, allowed_cpu_cap);
> -	freq = map_util_freq(max_util, ps->frequency, scale_cpu);
> +	freq = map_util_freq(max_util, ref_freq, scale_cpu);
>   
>   	/*
>   	 * Find the lowest performance state of the Energy Model above the
