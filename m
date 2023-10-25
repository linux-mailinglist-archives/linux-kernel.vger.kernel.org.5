Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538617D69A8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbjJYLB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjJYLBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:01:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53AFBA6;
        Wed, 25 Oct 2023 04:01:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89CBF2F4;
        Wed, 25 Oct 2023 04:02:03 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.69.205])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6311B3F738;
        Wed, 25 Oct 2023 04:01:19 -0700 (PDT)
Date:   Wed, 25 Oct 2023 12:01:16 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     broonie@kernel.org, joey.gouly@arm.com, will@kernel.org,
        amit.kachhap@arm.com, rafael@kernel.org, catalin.marinas@arm.com,
        james.morse@arm.com, maz@kernel.org, viresh.kumar@linaro.org,
        sumitg@nvidia.com, yang@os.amperecomputing.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wangxiongfeng2@huawei.com,
        xiexiuqi@huawei.com, Ionela Voinescu <ionela.voinescu@arm.com>
Subject: Re: [PATCH 3/3] cpufreq: CPPC: Eliminate the impact of cpc_read()
 latency error
Message-ID: <ZTj1fMsMj-Mekfn3@FVFF77S0Q05N>
References: <20231025093847.3740104-1-zengheng4@huawei.com>
 <20231025093847.3740104-4-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025093847.3740104-4-zengheng4@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 05:38:47PM +0800, Zeng Heng wrote:
> We have found significant differences in the latency of cpc_read() between
> regular scenarios and scenarios with high memory access pressure. Ignoring
> this error can result in getting rate interface occasionally returning
> absurd values.
> 
> Here provides a high memory access sample test by stress-ng. My local
> testing platform includes 160 CPUs, the CPC registers is accessed by mmio
> method, and the cpuidle feature is disabled (the AMU always works online):
> 
> ~~~
> ./stress-ng --memrate 160 --timeout 180
> ~~~
> 
> The following data is sourced from ftrace statistics towards
> cppc_get_perf_ctrs():
> 
>               Regular scenarios               ||      High memory access pressure scenarios
> 104)               |  cppc_get_perf_ctrs() {  ||  133)               |  cppc_get_perf_ctrs() {
> 104)   0.800 us    |    cpc_read.isra.0();    ||  133)   4.580 us    |    cpc_read.isra.0();
> 104)   0.640 us    |    cpc_read.isra.0();    ||  133)   7.780 us    |    cpc_read.isra.0();
> 104)   0.450 us    |    cpc_read.isra.0();    ||  133)   2.550 us    |    cpc_read.isra.0();
> 104)   0.430 us    |    cpc_read.isra.0();    ||  133)   0.570 us    |    cpc_read.isra.0();
> 104)   4.610 us    |  }                       ||  133) ! 157.610 us  |  }
> 104)               |  cppc_get_perf_ctrs() {  ||  133)               |  cppc_get_perf_ctrs() {
> 104)   0.720 us    |    cpc_read.isra.0();    ||  133)   0.760 us    |    cpc_read.isra.0();
> 104)   0.720 us    |    cpc_read.isra.0();    ||  133)   4.480 us    |    cpc_read.isra.0();
> 104)   0.510 us    |    cpc_read.isra.0();    ||  133)   0.520 us    |    cpc_read.isra.0();
> 104)   0.500 us    |    cpc_read.isra.0();    ||  133) + 10.100 us   |    cpc_read.isra.0();
> 104)   3.460 us    |  }                       ||  133) ! 120.850 us  |  }
> 108)               |  cppc_get_perf_ctrs() {  ||   87)               |  cppc_get_perf_ctrs() {
> 108)   0.820 us    |    cpc_read.isra.0();    ||   87) ! 255.200 us  |    cpc_read.isra.0();
> 108)   0.850 us    |    cpc_read.isra.0();    ||   87)   2.910 us    |    cpc_read.isra.0();
> 108)   0.590 us    |    cpc_read.isra.0();    ||   87)   5.160 us    |    cpc_read.isra.0();
> 108)   0.610 us    |    cpc_read.isra.0();    ||   87)   4.340 us    |    cpc_read.isra.0();
> 108)   5.080 us    |  }                       ||   87) ! 315.790 us  |  }
> 108)               |  cppc_get_perf_ctrs() {  ||   87)               |  cppc_get_perf_ctrs() {
> 108)   0.630 us    |    cpc_read.isra.0();    ||   87)   0.800 us    |    cpc_read.isra.0();
> 108)   0.630 us    |    cpc_read.isra.0();    ||   87)   6.310 us    |    cpc_read.isra.0();
> 108)   0.420 us    |    cpc_read.isra.0();    ||   87)   1.190 us    |    cpc_read.isra.0();
> 108)   0.430 us    |    cpc_read.isra.0();    ||   87) + 11.620 us   |    cpc_read.isra.0();
> 108)   3.780 us    |  }                       ||   87) ! 207.010 us  |  }
> 
> My local testing platform works under 3000000hz, but the cpuinfo_cur_freq
> interface returns values that are not even close to the actual frequency:
> 
> [root@localhost ~]# cd /sys/devices/system/cpu
> [root@localhost cpu]# for i in {0..159}; do cat cpu$i/cpufreq/cpuinfo_cur_freq; done
> 5127812
> 2952127
> 3069001
> 3496183
> 922989768
> 2419194
> 3427042
> 2331869
> 3594611
> 8238499
> ...
> 
> The reason is when under heavy memory access pressure, the execution of
> cpc_read() delay has increased from sub-microsecond to several hundred
> microseconds. Moving the cpc_read function into a critical section by irq
> disable/enable has minimal impact on the result.
> 
>   cppc_get_perf_ctrs()[0]                    cppc_get_perf_ctrs()[1]
> /                    \                      /                      \
> cpc_read         cpc_read                  cpc_read            cpc_read
>  ref[0]        delivered[0]                 ref[1]            delivered[1]
>     |              |                           |                    |
>     v              v                           v                    v
> -----------------------------------------------------------------------> time
>      <--delta[0]--> <------sample_period------> <-----delta[1]----->
> 
> Since that,
>   freq = ref_freq * (delivered[1] - delivered[0]) / (ref[1] - ref[0])
> and
>   delivered[1] - delivered[0] = freq * (delta[1] + sample_period),
>   ref[1] - ref[0] = ref_freq * (delta[0] + sample_period)
> 
> To eliminate the impact of system memory access latency, setting a
> sampling period of 2us is far from sufficient. Consequently, we suggest
> cppc_cpufreq_get_rate() only can be called in the process context, and
> adopt a longer sampling period to neutralize the impact of random latency.
> 
> Here we call the cond_resched() function instead of sleep-like functions
> to ensure that `taskset -c $i cat cpu$i/cpufreq/cpuinfo_cur_freq` could
> work when cpuidle feature is enabled.
> 
> Reported-by: Yang Shi <yang@os.amperecomputing.com>
> Link: https://lore.kernel.org/all/20230328193846.8757-1-yang@os.amperecomputing.com/
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 321a9dc9484d..a7c5418bcda7 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -851,12 +851,26 @@ static int cppc_get_perf_ctrs_pair(void *val)

The previous patch added this function, and calls it with smp_call_on_cpu(),
where it'll run in IRQ context with IRQs disabled...

>  	struct fb_ctr_pair *fb_ctrs = val;
>  	int cpu = fb_ctrs->cpu;
>  	int ret;
> +	unsigned long timeout;
>  
>  	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs->fb_ctrs_t0);
>  	if (ret)
>  		return ret;
>  
> -	udelay(2); /* 2usec delay between sampling */
> +	if (likely(!irqs_disabled())) {
> +		/*
> +		 * Set 1ms as sampling interval, but never schedule
> +		 * to the idle task to prevent the AMU counters from
> +		 * stopping working.
> +		 */
> +		timeout = jiffies + msecs_to_jiffies(1);
> +		while (!time_after(jiffies, timeout))
> +			cond_resched();
> +
> +	} else {

... so we'll enter this branch of the if-else ...

> +		pr_warn_once("CPU%d: Get rate in atomic context", cpu);

... and pr_warn_once() for something that's apparently normal and outside of
the user's control?

That doesn't make much sense to me.

Mark.

> +		udelay(2); /* 2usec delay between sampling */
> +	}
>  
>  	return cppc_get_perf_ctrs(cpu, &fb_ctrs->fb_ctrs_t1);
>  }
> -- 
> 2.25.1
> 
