Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2907C5014
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjJKK2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346255AbjJKK2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:28:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01DC0D9;
        Wed, 11 Oct 2023 03:27:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 645B21477;
        Wed, 11 Oct 2023 03:28:38 -0700 (PDT)
Received: from [192.168.1.13] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BA1C3F762;
        Wed, 11 Oct 2023 03:27:51 -0700 (PDT)
Message-ID: <ac8968b9-8463-4aa2-a38d-fc2b9137460d@arm.com>
Date:   Wed, 11 Oct 2023 12:27:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] cpufreq/cppc: set the frequency used for capacity
 computation
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, lukasz.luba@arm.com,
        ionela.voinescu@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org
References: <20231009103621.374412-1-vincent.guittot@linaro.org>
 <20231009103621.374412-7-vincent.guittot@linaro.org>
Content-Language: en-US
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20231009103621.374412-7-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vincent,

On 10/9/23 12:36, Vincent Guittot wrote:
> cppc cpufreq driver can register an artificial energy model. In such case,
> it also have to register the frequency that is used to define the CPU
> capacity
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>   drivers/cpufreq/cppc_cpufreq.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index fe08ca419b3d..24c6ba349f01 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -636,6 +636,21 @@ static int populate_efficiency_class(void)
>   	return 0;
>   }
>   
> +
> +static void cppc_cpufreq_set_capacity_ref_freq(struct cpufreq_policy *policy)
> +{
> +	struct cppc_perf_caps *perf_caps;
> +	struct cppc_cpudata *cpu_data;
> +	unsigned int ref_freq;
> +
> +	cpu_data = policy->driver_data;
> +	perf_caps = &cpu_data->perf_caps;
> +
> +	ref_freq = cppc_cpufreq_perf_to_khz(cpu_data, perf_caps->highest_perf);
> +
> +	per_cpu(capacity_ref_freq, policy->cpu) = ref_freq;

'capacity_ref_freq' seems to be updated only if CONFIG_ENERGY_MODEL is set. However in
[1], get_capacity_ref_freq() relies on 'capacity_ref_freq'. The cpufreq_schedutil governor
should have a valid 'capacity_ref_freq' value set if the CPPC cpufreq driver is used
without energy model I believe.

Also 'capacity_ref_freq' seems to be set only for 'policy->cpu'. I believe it should
be set for the whole perf domain in case this 'policy->cpu' goes offline.

Another thing, related my comment to [1] and to [2], for CPPC the max capacity matches
the boosting frequency. We have:
   'non-boosted max capacity' < 'boosted max capacity'.
-
If boosting is not enabled, the CPU utilization can still go above the 'non-boosted max
capacity'. The overutilization of the system seems to be triggered by comparing the CPU
util to the 'boosted max capacity'. So systems might not be detected as overutilized.

For the EAS energy computation, em_cpu_energy() tries to predict the frequency that will
be used. It is currently unknown to the function that the frequency request will be
clamped by __resolve_freq():
get_next_freq()
\-cpufreq_driver_resolve_freq()
   \-__resolve_freq()
This means that the energy computation might use boosting frequencies, which are not
available.

Regards,
Pierre

[1]: [PATCH v2 4/6] cpufreq/schedutil: use a fixed reference frequency
[2]: https://lore.kernel.org/lkml/20230905113308.GF28319@noisy.programming.kicks-ass.net/

> +}
> +
>   static void cppc_cpufreq_register_em(struct cpufreq_policy *policy)
>   {
>   	struct cppc_cpudata *cpu_data;
> @@ -643,6 +658,9 @@ static void cppc_cpufreq_register_em(struct cpufreq_policy *policy)
>   		EM_ADV_DATA_CB(cppc_get_cpu_power, cppc_get_cpu_cost);
>   
>   	cpu_data = policy->driver_data;
> +
> +	cppc_cpufreq_set_capacity_ref_freq(policy);
> +
>   	em_dev_register_perf_domain(get_cpu_device(policy->cpu),
>   			get_perf_level_count(policy), &em_cb,
>   			cpu_data->shared_cpu_map, 0);
