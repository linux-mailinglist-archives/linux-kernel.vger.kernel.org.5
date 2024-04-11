Return-Path: <linux-kernel+bounces-141537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104678A1F86
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415CF1C222F1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CBD15E88;
	Thu, 11 Apr 2024 19:30:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B190A134D1;
	Thu, 11 Apr 2024 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712863830; cv=none; b=ikP1+ANNIoGt3IeoScSYoAYoVjUF+YQG+kEL9F/iU9guovU4uOQInrMQF+1Fwk31fwV8Mg/8Ddj+agl7JQ0ujJskpXNyI81hGc2kF/y3cIYjXk9awWvxWMwIKEciCjr7ZPTjxnnc6CFKKCaQqX2hnprfRBeJ5I1hgmNhsqWlo/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712863830; c=relaxed/simple;
	bh=nh2Upng/Ji4PI8OKXrJFPEst72tzht4Q2xUmho5cW2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzPof5QXJf+PM0G1mIJbkEsTSQdNXYhexe7ORfusob8Omoc+aKuIFMIuStIVgMmotu5vyiXYuc36QssNIlLrga5z+TLtI4AmGl+oVvNdhRphQ0+bmLkWrVtgkAlepw5oXnOSc4qJzUIP0/cP/DRhiBlM/9A9ACHJBNkcS4FNYFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1843E113E;
	Thu, 11 Apr 2024 12:30:56 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E20F3F64C;
	Thu, 11 Apr 2024 12:30:23 -0700 (PDT)
Date: Thu, 11 Apr 2024 21:30:16 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Sumit Gupta <sumitg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	ionela.voinescu@arm.com, vanshikonda@os.amperecomputing.com,
	sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
	vincent.guittot@linaro.org, yang@os.amperecomputing.com,
	lihuisong@huawei.com, linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] arm64: Update AMU-based frequency scale factor on
 entering idle
Message-ID: <Zhg6SLfqrRUf0vmp@arm.com>
References: <20240405133319.859813-1-beata.michalska@arm.com>
 <20240405133319.859813-4-beata.michalska@arm.com>
 <3ab3cbc1-234f-e0b6-4521-298018547aad@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ab3cbc1-234f-e0b6-4521-298018547aad@nvidia.com>

On Thu, Apr 11, 2024 at 12:27:00AM +0530, Sumit Gupta wrote:

Hi Sumit,
> Hi Beata,
> 
> This patch is giving abort due to 'amu_fie_cpus' mask which gets allocated
> later in 'init_amu_fie()'.
> 
>  ] smp: Bringing up secondary CPUs ...
>  ] Unable to handle kernel read from unreadable memory at virtual
>    address 0000000000000000
>    .......
>  ] Call trace:
>  ]  arch_cpu_idle_enter+0x30/0xe0
>  ]  do_idle+0xb8/0x2e0
>  ]  cpu_startup_entry+0x3c/0x50
>  ]  rest_init+0x108/0x128
>  ]  start_kernel+0x7a4/0xa50
>  ]  __primary_switched+0x80/0x90
>  ] Code: d53cd042 b8626800 f943c821 53067c02 (f8627821)
>  ] ---[ end trace 0000000000000000 ]---
>  ] Kernel panic - not syncing: Oops: Fatal exception
> 
> Added cpumask_available() check before access to fix.
> 
>  +++ b/arch/arm64/kernel/topology.c
>  @@ -211,9 +211,13 @@ void arch_cpu_idle_enter(void)
>   {
>          unsigned int cpu = smp_processor_id();
> 
>  -       if (!cpumask_test_cpu(cpu, amu_fie_cpus))
>  +       if (cpumask_available(amu_fie_cpus) &&
>  +           !cpumask_test_cpu(cpu, amu_fie_cpus))
>                  return;
> 
That's actually a gruesome mistake on my side. Thanks for catching that one.
On that note: arch_freq_get_on_cpu should be also protected case amu fie init
fails for some reason. Will be sending an update.

Thanks again.

---
BR
Beata
> Thank you,
> Sumit Gupta
> 
> On 05/04/24 19:03, Beata Michalska wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > Now that the frequency scale factor has been activated for retrieving
> > current frequency on a given CPU, trigger its update upon entering
> > idle. This will, to an extent, allow querying last known frequency
> > in a non-invasive way. It will also improve the frequency scale factor
> > accuracy when a CPU entering idle did not receive a tick for a while.
> > As a consequence, for idle cores, the reported frequency will be the
> > last one observed before entering the idle state.
> > 
> > Suggested-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> > ---
> >   arch/arm64/kernel/topology.c | 17 +++++++++++++++--
> >   1 file changed, 15 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> > index b03fe8617721..f204f6489f98 100644
> > --- a/arch/arm64/kernel/topology.c
> > +++ b/arch/arm64/kernel/topology.c
> > @@ -207,6 +207,19 @@ static struct scale_freq_data amu_sfd = {
> >          .set_freq_scale = amu_scale_freq_tick,
> >   };
> > 
> > +void arch_cpu_idle_enter(void)
> > +{
> > +       unsigned int cpu = smp_processor_id();
> > +
> > +       if (!cpumask_test_cpu(cpu, amu_fie_cpus))
> > +               return;
> > +
> > +       /* Kick in AMU update but only if one has not happened already */
> > +       if (housekeeping_cpu(cpu, HK_TYPE_TICK) &&
> > +           time_is_before_jiffies(per_cpu(cpu_amu_samples.last_update, cpu)))
> > +               amu_scale_freq_tick();
> > +}
> > +
> >   #define AMU_SAMPLE_EXP_MS      20
> > 
> >   unsigned int arch_freq_get_on_cpu(int cpu)
> > @@ -232,8 +245,8 @@ unsigned int arch_freq_get_on_cpu(int cpu)
> >           * this boils down to identifying an active cpu within the same freq
> >           * domain, if any.
> >           */
> > -       if (!housekeeping_cpu(cpu, HK_TYPE_TICK) ||
> > -           time_is_before_jiffies(last_update + msecs_to_jiffies(AMU_SAMPLE_EXP_MS))) {
> > +       if (!housekeeping_cpu(cpu, HK_TYPE_TICK) || (!idle_cpu(cpu) &&
> > +           time_is_before_jiffies(last_update + msecs_to_jiffies(AMU_SAMPLE_EXP_MS)))) {
> >                  struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> >                  int ref_cpu = cpu;
> > 
> > --
> > 2.25.1
> > 

