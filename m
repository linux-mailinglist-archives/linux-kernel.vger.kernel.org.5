Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF0E7A9D0C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjIUT2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjIUT1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:27:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DCE2A0C3B;
        Thu, 21 Sep 2023 10:57:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A677D1596;
        Thu, 21 Sep 2023 03:13:01 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.78.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27AD13F59C;
        Thu, 21 Sep 2023 03:12:24 -0700 (PDT)
Date:   Thu, 21 Sep 2023 11:12:22 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, conor.dooley@microchip.com,
        suagrfillet@gmail.com, ajones@ventanamicro.com, lftan@kernel.org
Subject: Re: [PATCH 4/4] energy_model: use a fixed reference frequency
Message-ID: <ZQwXBr/QXKUVJYBy@arm.com>
References: <20230901130312.247719-1-vincent.guittot@linaro.org>
 <20230901130312.247719-5-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901130312.247719-5-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 Sep 2023 at 15:03:12 (+0200), Vincent Guittot wrote:
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
>  include/linux/energy_model.h | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index b9caa01dfac4..7ee07be6928e 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -204,6 +204,20 @@ struct em_perf_state *em_pd_get_efficient_state(struct em_perf_domain *pd,
>  	return ps;
>  }
>  
> +#ifdef arch_scale_freq_ref
> +static __always_inline
> +unsigned long  arch_scale_freq_ref_em(int cpu, struct em_perf_domain *pd)

The comments in patch 3/4 should be considered for this function and its
use as well.

Thanks,
Ionela.

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
>  /**
>   * em_cpu_energy() - Estimates the energy consumed by the CPUs of a
>   *		performance domain
> @@ -224,7 +238,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>  				unsigned long max_util, unsigned long sum_util,
>  				unsigned long allowed_cpu_cap)
>  {
> -	unsigned long freq, scale_cpu;
> +	unsigned long freq, ref_freq, scale_cpu;
>  	struct em_perf_state *ps;
>  	int cpu;
>  
> @@ -241,11 +255,11 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>  	 */
>  	cpu = cpumask_first(to_cpumask(pd->cpus));
>  	scale_cpu = arch_scale_cpu_capacity(cpu);
> -	ps = &pd->table[pd->nr_perf_states - 1];
> +	ref_freq = arch_scale_freq_ref_em(cpu, pd);
>  
>  	max_util = map_util_perf(max_util);
>  	max_util = min(max_util, allowed_cpu_cap);
> -	freq = map_util_freq(max_util, ps->frequency, scale_cpu);
> +	freq = map_util_freq(max_util, ref_freq, scale_cpu);
>  
>  	/*
>  	 * Find the lowest performance state of the Energy Model above the
> -- 
> 2.34.1
> 
> 
