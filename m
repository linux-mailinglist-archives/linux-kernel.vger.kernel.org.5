Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73C17D7EF0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344746AbjJZIxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344757AbjJZIxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:53:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21DD410E3;
        Thu, 26 Oct 2023 01:53:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F3592F4;
        Thu, 26 Oct 2023 01:54:08 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5154F3F762;
        Thu, 26 Oct 2023 01:53:24 -0700 (PDT)
Date:   Thu, 26 Oct 2023 09:53:21 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     <broonie@kernel.org>, <joey.gouly@arm.com>, <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, <amit.kachhap@arm.com>,
        <rafael@kernel.org>, <catalin.marinas@arm.com>,
        <james.morse@arm.com>, <mark.rutland@arm.com>, <maz@kernel.org>,
        <viresh.kumar@linaro.org>, <sumitg@nvidia.com>,
        <yang@os.amperecomputing.com>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <wangxiongfeng2@huawei.com>, <xiexiuqi@huawei.com>
Subject: Re: [PATCH 2/3] cpufreq: CPPC: Keep the target core awake when
 reading its cpufreq rate
Message-ID: <ZTopAUnBQXGIuM5f@bogus>
References: <20231025093847.3740104-1-zengheng4@huawei.com>
 <20231025093847.3740104-3-zengheng4@huawei.com>
 <20231025111301.ng5eaeaixfs3jjpg@bogus>
 <dcc4dfd7-fbef-7b46-5037-3916077ec696@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dcc4dfd7-fbef-7b46-5037-3916077ec696@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 10:24:54AM +0800, Zeng Heng wrote:
> 
> 在 2023/10/25 19:13, Sudeep Holla 写道:
> > On Wed, Oct 25, 2023 at 05:38:46PM +0800, Zeng Heng wrote:
> > > As ARM AMU's document says, all counters are subject to any changes
> > > in clock frequency, including clock stopping caused by the WFI and WFE
> > > instructions.
> > > 
> > > Therefore, using smp_call_on_cpu() to trigger target CPU to
> > > read self's AMU counters, which ensures the counters are working
> > > properly while cstate feature is enabled.
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
> > [...]
> > 
> > > @@ -850,18 +871,18 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
> > >   	cpufreq_cpu_put(policy);
> > > -	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
> > > -	if (ret)
> > > -		return 0;
> > > -
> > > -	udelay(2); /* 2usec delay between sampling */
> > > +	if (cpu_has_amu_feat(cpu))
> > Have you compiled this on x86 ? Even if you have somehow managed to,
> > this is not the right place to check the presence of AMU feature on
> > the CPU.
> > If AMU registers are used in CPPC, they must be using FFH GAS, in which
> > case the interpretation of FFH is architecture dependent code.
>
> According to drivers/cpufreq/Makefile, cppc_cpufreq.c is only compiled with
> ARM architecture.
>

Well that's true but this change doesn't belong to cppc_cpufreq.c, it must
be part of drivers/acpi/cppc_acpi.c IMO and sorry I assumed that without
explicitly mentioning that here.

> But here, I would change cpu_has_amu_feat() with cpc_ffh_supported(), which
> belongs to FFH APIs.
>

It is not like that. cppc_acpi.c will know the GAS is FFH based so no need to
check anything there. I see counters_read_on_cpu() called from cpc_ffh_read()
already takes care of reading the AMUs on the right CPU. What exactly is
the issue you are seeing ? I don't if this change is needed at all.

--
Regards,
Sudeep
