Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5757D81C5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 13:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344763AbjJZL0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 07:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJZL0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 07:26:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DA811A6;
        Thu, 26 Oct 2023 04:26:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E84CA2F4;
        Thu, 26 Oct 2023 04:27:16 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.70.231])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB90E3F738;
        Thu, 26 Oct 2023 04:26:32 -0700 (PDT)
Date:   Thu, 26 Oct 2023 12:26:20 +0100
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
Message-ID: <ZTpM3OXZ8C1OrBIQ@FVFF77S0Q05N>
References: <20231025093847.3740104-1-zengheng4@huawei.com>
 <20231025093847.3740104-4-zengheng4@huawei.com>
 <ZTj1fMsMj-Mekfn3@FVFF77S0Q05N>
 <abb15757-cbe6-037f-e8d3-5df9fbbf6c04@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abb15757-cbe6-037f-e8d3-5df9fbbf6c04@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 09:55:39AM +0800, Zeng Heng wrote:
> 
> 在 2023/10/25 19:01, Mark Rutland 写道:
> > On Wed, Oct 25, 2023 at 05:38:47PM +0800, Zeng Heng wrote:
> > 
> > The previous patch added this function, and calls it with smp_call_on_cpu(),
> > where it'll run in IRQ context with IRQs disabled...
> 
> smp_call_on_cpu() puts the work to the bind-cpu worker.

Ah, sorry -- I had confused this with the smp_call_function*() family, which do
this in IRQ context.

> And this function will be called in task context, and IRQs is certainly enabled.

Understood; given that, please ignore my comments below.

Mark.

> 
> 
> Zeng Heng
> 
> > >   	struct fb_ctr_pair *fb_ctrs = val;
> > >   	int cpu = fb_ctrs->cpu;
> > >   	int ret;
> > > +	unsigned long timeout;
> > >   	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs->fb_ctrs_t0);
> > >   	if (ret)
> > >   		return ret;
> > > -	udelay(2); /* 2usec delay between sampling */
> > > +	if (likely(!irqs_disabled())) {
> > > +		/*
> > > +		 * Set 1ms as sampling interval, but never schedule
> > > +		 * to the idle task to prevent the AMU counters from
> > > +		 * stopping working.
> > > +		 */
> > > +		timeout = jiffies + msecs_to_jiffies(1);
> > > +		while (!time_after(jiffies, timeout))
> > > +			cond_resched();
> > > +
> > > +	} else {
> > ... so we'll enter this branch of the if-else ...
> > 
> > > +		pr_warn_once("CPU%d: Get rate in atomic context", cpu);
> > ... and pr_warn_once() for something that's apparently normal and outside of
> > the user's control?
> > 
> > That doesn't make much sense to me.
> > 
> > Mark.
> > 
> > > +		udelay(2); /* 2usec delay between sampling */
> > > +	}
> > >   	return cppc_get_perf_ctrs(cpu, &fb_ctrs->fb_ctrs_t1);
> > >   }
> > > -- 
> > > 2.25.1
> > > 
