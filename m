Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABD0791748
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 14:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345451AbjIDMjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 08:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjIDMjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 08:39:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF88FEC;
        Mon,  4 Sep 2023 05:39:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83C091474;
        Mon,  4 Sep 2023 05:40:26 -0700 (PDT)
Received: from [10.57.93.88] (unknown [10.57.93.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EFCD3F793;
        Mon,  4 Sep 2023 05:39:43 -0700 (PDT)
Message-ID: <1a349a05-d351-c2e0-615f-ed503563da5c@arm.com>
Date:   Mon, 4 Sep 2023 13:40:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/4] energy_model: use a fixed reference frequency
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, catalin.marinas@arm.com, lftan@kernel.org,
        will@kernel.org, juri.lelli@redhat.com, peterz@infradead.org,
        mingo@redhat.com, sudeep.holla@arm.com, rostedt@goodmis.org,
        vschneid@redhat.com, linux@armlinux.org.uk,
        linux-riscv@lists.infradead.org, mgorman@suse.de,
        bsegall@google.com, dietmar.eggemann@arm.com,
        linux-pm@vger.kernel.org, bristot@redhat.com, rafael@kernel.org,
        gregkh@linuxfoundation.org, viresh.kumar@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        aou@eecs.berkeley.edu
References: <20230901130312.247719-1-vincent.guittot@linaro.org>
 <20230901130312.247719-5-vincent.guittot@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20230901130312.247719-5-vincent.guittot@linaro.org>
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



On 9/1/23 14:03, Vincent Guittot wrote:
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

LGTM,

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

FYI, I'm going to send my v4 for the EM hopefully in next days, so those
changes might collide. But we can sort this out later (when both would
be ready).

Regards,
Lukasz
