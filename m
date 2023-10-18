Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453A87CDA01
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjJRLFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjJRLFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:05:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9120C111;
        Wed, 18 Oct 2023 04:05:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36F462F4;
        Wed, 18 Oct 2023 04:06:21 -0700 (PDT)
Received: from [10.57.81.189] (unknown [10.57.81.189])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA1F93F762;
        Wed, 18 Oct 2023 04:05:35 -0700 (PDT)
Message-ID: <db2ba48c-f1f4-41ca-99e6-4cb756a8ac00@arm.com>
Date:   Wed, 18 Oct 2023 12:06:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] topology: add a new arch_scale_freq_reference
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     conor.dooley@microchip.com, will@kernel.org,
        ionela.voinescu@arm.com, vschneid@redhat.com, mgorman@suse.de,
        bsegall@google.com, dietmar.eggemann@arm.com, peterz@infradead.org,
        sudeep.holla@arm.com, aou@eecs.berkeley.edu, palmer@dabbelt.com,
        linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
        pierre.gondois@arm.com, paul.walmsley@sifive.com,
        catalin.marinas@arm.com, linux@armlinux.org.uk,
        suagrfillet@gmail.com, ajones@ventanamicro.com,
        juri.lelli@redhat.com, lftan@kernel.org, mingo@redhat.com,
        rafael@kernel.org, gregkh@linuxfoundation.org, rostedt@goodmis.org,
        bristot@redhat.com, viresh.kumar@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231009103621.374412-1-vincent.guittot@linaro.org>
 <20231009103621.374412-3-vincent.guittot@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231009103621.374412-3-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/9/23 11:36, Vincent Guittot wrote:
> Create a new method to get a unique and fixed max frequency. Currently
> cpuinfo.max_freq or the highest (or last) state of performance domain are
> used as the max frequency when computing the frequency for a level of
> utilization but:
> - cpuinfo_max_freq can change at runtime. boost is one example of
>    such change.
> - cpuinfo.max_freq and last item of the PD can be different leading to
>    different results between cpufreq and energy model.
> 
> We need to save the reference frequency that has been used when computing
> the CPUs capacity and use this fixed and coherent value to convert between
> frequency and CPU's capacity.
> 
> In fact, we already save the frequency that has been used when computing
> the capacity of each CPU. We extend the precision to save khZ instead of
> Mhz currently and we modify the type to be aligned with other variables
> used when converting frequency to capacity and the other way.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>   arch/arm/include/asm/topology.h   |  1 +
>   arch/arm64/include/asm/topology.h |  1 +
>   arch/riscv/include/asm/topology.h |  1 +
>   drivers/base/arch_topology.c      | 29 ++++++++++++++---------------
>   include/linux/arch_topology.h     |  7 +++++++
>   5 files changed, 24 insertions(+), 15 deletions(-)

[snip]

> @@ -170,9 +172,9 @@ DEFINE_PER_CPU(unsigned long, thermal_pressure);
>    * operating on stale data when hot-plug is used for some CPUs. The
>    * @capped_freq reflects the currently allowed max CPUs frequency due to
>    * thermal capping. It might be also a boost frequency value, which is bigger
> - * than the internal 'freq_factor' max frequency. In such case the pressure
> - * value should simply be removed, since this is an indication that there is
> - * no thermal throttling. The @capped_freq must be provided in kHz.
> + * than the internal 'capacity_ref_freq' max frequency. In such case the
> + * pressure value should simply be removed, since this is an indication that
> + * there is no thermal throttling. The @capped_freq must be provided in kHz.
>    */
>   void topology_update_thermal_pressure(const struct cpumask *cpus,
>   				      unsigned long capped_freq)
> @@ -183,10 +185,7 @@ void topology_update_thermal_pressure(const struct cpumask *cpus,
>   
>   	cpu = cpumask_first(cpus);
>   	max_capacity = arch_scale_cpu_capacity(cpu);
> -	max_freq = per_cpu(freq_factor, cpu);
> -
> -	/* Convert to MHz scale which is used in 'freq_factor' */
> -	capped_freq /= 1000;

I do like this small speed-up and I'm happy that it's possible with this
new design. (IIRC some of your platforms can update the thermal
pressure quite many time per sec - that might be the reason why
you see some speed-ups mentioned in the cover letter)

> +	max_freq = arch_scale_freq_ref(cpu);
>   


LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
