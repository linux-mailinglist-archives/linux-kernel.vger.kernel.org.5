Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEAC7D69D2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjJYLOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjJYLOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:14:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA820BB;
        Wed, 25 Oct 2023 04:14:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33CAE2F4;
        Wed, 25 Oct 2023 04:15:19 -0700 (PDT)
Received: from bogus (unknown [10.57.93.106])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AE673F738;
        Wed, 25 Oct 2023 04:14:34 -0700 (PDT)
Date:   Wed, 25 Oct 2023 12:13:01 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     broonie@kernel.org, joey.gouly@arm.com, will@kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>, amit.kachhap@arm.com,
        rafael@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        mark.rutland@arm.com, maz@kernel.org, viresh.kumar@linaro.org,
        sumitg@nvidia.com, yang@os.amperecomputing.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wangxiongfeng2@huawei.com,
        xiexiuqi@huawei.com
Subject: Re: [PATCH 2/3] cpufreq: CPPC: Keep the target core awake when
 reading its cpufreq rate
Message-ID: <20231025111301.ng5eaeaixfs3jjpg@bogus>
References: <20231025093847.3740104-1-zengheng4@huawei.com>
 <20231025093847.3740104-3-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025093847.3740104-3-zengheng4@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 05:38:46PM +0800, Zeng Heng wrote:
> As ARM AMU's document says, all counters are subject to any changes
> in clock frequency, including clock stopping caused by the WFI and WFE
> instructions.
> 
> Therefore, using smp_call_on_cpu() to trigger target CPU to
> read self's AMU counters, which ensures the counters are working
> properly while cstate feature is enabled.
> 
> Reported-by: Sumit Gupta <sumitg@nvidia.com>
> Link: https://lore.kernel.org/all/20230418113459.12860-7-sumitg@nvidia.com/
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 39 ++++++++++++++++++++++++++--------
>  1 file changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index fe08ca419b3d..321a9dc9484d 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c

[...]

> @@ -850,18 +871,18 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>  
>  	cpufreq_cpu_put(policy);
>  
> -	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
> -	if (ret)
> -		return 0;
> -
> -	udelay(2); /* 2usec delay between sampling */
> +	if (cpu_has_amu_feat(cpu))

Have you compiled this on x86 ? Even if you have somehow managed to,
this is not the right place to check the presence of AMU feature on
the CPU.

If AMU registers are used in CPPC, they must be using FFH GAS, in which
case the interpretation of FFH is architecture dependent code.

--
Regards,
Sudeep
