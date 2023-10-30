Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5877DBA80
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 14:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbjJ3NUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 09:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjJ3NUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 09:20:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1301C9;
        Mon, 30 Oct 2023 06:19:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DFABFEC;
        Mon, 30 Oct 2023 06:20:40 -0700 (PDT)
Received: from e129154.nice.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F25103F64C;
        Mon, 30 Oct 2023 06:19:53 -0700 (PDT)
Date:   Mon, 30 Oct 2023 14:19:06 +0100
From:   Beata Michalska <beata.michalska@arm.com>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     Zeng Heng <zengheng4@huawei.com>, broonie@kernel.org,
        joey.gouly@arm.com, will@kernel.org, amit.kachhap@arm.com,
        rafael@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        maz@kernel.org, viresh.kumar@linaro.org,
        yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        wangxiongfeng2@huawei.com, xiexiuqi@huawei.com,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/3] cpufreq: CPPC: Keep the target core awake when
 reading its cpufreq rate
Message-ID: <ZT-tSoCYR-818pa3@e129154.nice.arm.com>
References: <20231025093847.3740104-1-zengheng4@huawei.com>
 <20231025093847.3740104-3-zengheng4@huawei.com>
 <ZTjz2Ox_iqorbejw@FVFF77S0Q05N>
 <28a6e60c-4492-105b-5fcf-3129ca868349@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28a6e60c-4492-105b-5fcf-3129ca868349@nvidia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 08:27:23PM +0530, Sumit Gupta wrote:
> 
> 
> 
> > [adding Ionela]
> > 
> > On Wed, Oct 25, 2023 at 05:38:46PM +0800, Zeng Heng wrote:
> > > As ARM AMU's document says, all counters are subject to any changes
> > > in clock frequency, including clock stopping caused by the WFI and WFE
> > > instructions.
> > > 
> > > Therefore, using smp_call_on_cpu() to trigger target CPU to
> > > read self's AMU counters, which ensures the counters are working
> > > properly while cstate feature is enabled.
> > 
> > IIUC there's a pretty deliberate split with all the actual reading of the AMU
> > living in arch/arm64/kernel/topolgy.c, and the driver code being (relatively)
> > generic.
> > 
> > We already have code in arch/arm64/kernel/topolgy.c to read counters on a
> > specific CPU; why can't e reuse that (and avoid exporting cpu_has_amu_feat())?
> 
> 
> This patch seems mostly based on my previous patch [1] and discussed here
> [2] already. Beata [CCed] shared an alternate approach [3] leveraging
> existing code from 'topology.c' to get the average freq for last tick
> period.
> 
> 
> Beata,
> 
> Could you share v2 of [3] with the request to merge. We can try to solve the
> issue with CPU IDLE case later on top?
>
Will do (same for the below request if feasible)

---
BR
B.
> Additionally, also please include the fix in [4] if it looks fine.
> 
> Best Regards,
> Sumit Gupta
> 
> [1] https://lore.kernel.org/all/20230418113459.12860-7-sumitg@nvidia.com/
> [2] https://lore.kernel.org/lkml/cde1d8a9-3a21-e82b-7895-40603a14d898@nvidia.com/T/#m2174305de4706006e0bd9c103a0e5ff61cea7a12
> [3]
> https://lore.kernel.org/lkml/20230606155754.245998-1-beata.michalska@arm.com/
> [4]
> https://lore.kernel.org/lkml/6a5710f6-bfbb-5dfd-11cd-0cd02220cee7@nvidia.com/
> 
> 
> > > 
> > > Reported-by: Sumit Gupta <sumitg@nvidia.com>
> > > Link: https://lore.kernel.org/all/20230418113459.12860-7-sumitg@nvidia.com/
> > > Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> > > ---
> > >   drivers/cpufreq/cppc_cpufreq.c | 39 ++++++++++++++++++++++++++--------
> > >   1 file changed, 30 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> > > index fe08ca419b3d..321a9dc9484d 100644
> > > --- a/drivers/cpufreq/cppc_cpufreq.c
> > > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > > @@ -90,6 +90,12 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
> > >                                 struct cppc_perf_fb_ctrs *fb_ctrs_t0,
> > >                                 struct cppc_perf_fb_ctrs *fb_ctrs_t1);
> > > 
> > > +struct fb_ctr_pair {
> > > +     u32 cpu;
> > > +     struct cppc_perf_fb_ctrs fb_ctrs_t0;
> > > +     struct cppc_perf_fb_ctrs fb_ctrs_t1;
> > > +};
> > > +
> > >   /**
> > >    * cppc_scale_freq_workfn - CPPC arch_freq_scale updater for frequency invariance
> > >    * @work: The work item.
> > > @@ -840,9 +846,24 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
> > >        return (reference_perf * delta_delivered) / delta_reference;
> > >   }
> > > 
> > > +static int cppc_get_perf_ctrs_pair(void *val)
> > > +{
> > > +     struct fb_ctr_pair *fb_ctrs = val;
> > > +     int cpu = fb_ctrs->cpu;
> > > +     int ret;
> > > +
> > > +     ret = cppc_get_perf_ctrs(cpu, &fb_ctrs->fb_ctrs_t0);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     udelay(2); /* 2usec delay between sampling */
> > > +
> > > +     return cppc_get_perf_ctrs(cpu, &fb_ctrs->fb_ctrs_t1);
> > > +}
> > > +
> > >   static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
> > >   {
> > > -     struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
> > > +     struct fb_ctr_pair fb_ctrs = { .cpu = cpu, };
> > >        struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> > >        struct cppc_cpudata *cpu_data = policy->driver_data;
> > >        u64 delivered_perf;
> > > @@ -850,18 +871,18 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
> > > 
> > >        cpufreq_cpu_put(policy);
> > > 
> > > -     ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
> > > -     if (ret)
> > > -             return 0;
> > > -
> > > -     udelay(2); /* 2usec delay between sampling */
> > > +     if (cpu_has_amu_feat(cpu))
> > > +             ret = smp_call_on_cpu(cpu, cppc_get_perf_ctrs_pair,
> > > +                                   &fb_ctrs, false);
> > > +     else
> > > +             ret = cppc_get_perf_ctrs_pair(&fb_ctrs);
> > > 
> > > -     ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
> > >        if (ret)
> > >                return 0;
> > > 
> > > -     delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
> > > -                                            &fb_ctrs_t1);
> > > +     delivered_perf = cppc_perf_from_fbctrs(cpu_data,
> > > +                                           &fb_ctrs.fb_ctrs_t0,
> > > +                                           &fb_ctrs.fb_ctrs_t1);
> > > 
> > >        return cppc_cpufreq_perf_to_khz(cpu_data, delivered_perf);
> > >   }
> > > --
> > > 2.25.1
> > > 
