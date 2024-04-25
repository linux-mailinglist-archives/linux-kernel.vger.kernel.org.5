Return-Path: <linux-kernel+bounces-158712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8D48B2419
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F01FAB28470
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AD714A0A7;
	Thu, 25 Apr 2024 14:27:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B784149DFF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714055272; cv=none; b=dNEnTiH2xDMd/FxciG2AjgluW15nr4ikeBAjrgHblyi5C7oUpqFYPZSDpzffEXG46G55jws9qcXUU3r4WnZFdDDbjPvx8hR3ocT3ROuB+6p6Nq28+PjrAQavgok9CUzxCdK48ISc9yGnCO0OqvQpRb8qccT10y99XYGWos51N3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714055272; c=relaxed/simple;
	bh=mJWIOq23bs7ji+Fl4ndMwX8erxoXcwpt0Cw321wXBWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CN6ygtyGyVye2Ath5a+vy4vk4603BebqTu7sCCJSXb6TzvNbC0pQr4sVFoYQEI+SpRVw0b8tm9Gr4qzo9fU6/+XgZTbb6llQYdNiosPYq7TFUfk6rzZUAfoZV1/ZjUultkPXUc/GZz5KdiSPBxeBdbi7Hth/ltH6DWCyx87kjNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93FFA1007;
	Thu, 25 Apr 2024 07:28:18 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8421E3F64C;
	Thu, 25 Apr 2024 07:27:47 -0700 (PDT)
Date: Thu, 25 Apr 2024 16:27:37 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	ionela.voinescu@arm.com, vanshikonda@os.amperecomputing.com,
	will@kernel.org, catalin.marinas@arm.com,
	vincent.guittot@linaro.org, sumitg@nvidia.com,
	yang@os.amperecomputing.com, lihuisong@huawei.com,
	viresh.kumar@linaro.org
Subject: Re: [PATCH v5 2/5] arm64: amu: Rule out potential use after free
Message-ID: <ZipoWUErkebDKXYd@arm.com>
References: <20240417093848.1555462-1-beata.michalska@arm.com>
 <20240417093848.1555462-3-beata.michalska@arm.com>
 <20240418105052.zvkomz5yeayie4ph@bogus>
 <ZiFCfwEvdJxg6Hth@arm.com>
 <20240424102527.3s4ebjnaai2md5pa@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424102527.3s4ebjnaai2md5pa@bogus>

On Wed, Apr 24, 2024 at 11:25:27AM +0100, Sudeep Holla wrote:
> On Thu, Apr 18, 2024 at 05:55:43PM +0200, Beata Michalska wrote:
> > On Thu, Apr 18, 2024 at 11:50:52AM +0100, Sudeep Holla wrote:
> > > On Wed, Apr 17, 2024 at 10:38:45AM +0100, Beata Michalska wrote:
> > > > For the time being, the amu_fie_cpus cpumask is being exclusively used
> > > > by the AMU-related internals of FIE support and is guaranteed to be
> > > > valid on every access currently made. Still the mask is not being
> > > > invalidated on one of the error handling code paths, which leaves
> > > > a soft spot with potential risk of uaf for CPUMASK_OFFSTACK cases.
> > > > To make things sound, set the cpumaks pointer explicitly to NULL upon
> > > > failing to register the cpufreq notifier.
> > > > Note that, due to the quirks of CPUMASK_OFFSTACK, this change needs to
> > > > be wrapped with grim ifdefing (it would be better served by
> > > > incorporating this into free_cpumask_var ...)
> > > >
> > >
> > > Yes it doesn't look neat.
> > >
> > > > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> > > > ---
> > > >  arch/arm64/kernel/topology.c | 6 +++++-
> > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> > > > index 1a2c72f3e7f8..3c814a278534 100644
> > > > --- a/arch/arm64/kernel/topology.c
> > > > +++ b/arch/arm64/kernel/topology.c
> > > > @@ -244,8 +244,12 @@ static int __init init_amu_fie(void)
> > > >
> > > >  	ret = cpufreq_register_notifier(&init_amu_fie_notifier,
> > > >  					CPUFREQ_POLICY_NOTIFIER);
> > > > -	if (ret)
> > > > +	if (ret) {
> > > >  		free_cpumask_var(amu_fie_cpus);
> > > > +#ifdef CONFIG_CPUMASK_OFFSTACK
> > > > +		amu_fie_cpus = NULL;
> > > > +#endif
> > > > +	}
> > >
> > > Instead of this #ifdeffery, I was wondering if we can actually do the
> > > allocation in init_amu_fie_callback() the first time it gets called
> > > checking if amu_fie_cpus is NULL. init_amu_fie_callback() must get called
> > > only if the cpufreq_register_notifier() succeeds right ?
> > >
> 
> > Delayed allocation ... I guess this will do the trick.
> 
> I prefer that if we can't find any other alternative. Do you see any issues
> with that ? That said I am fine if Will/Catalin is happy with this.
>
We could actually move it up further to amu_fie_setup and potentially save on
memory if none of the present CPUs have valid AMU counters. This is unlikely but
still. So it could look like:

--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@@ -297,7 -194,7 +297,8 @@@ static void amu_fie_setup(const struct
        int cpu;

        /* We are already set since the last insmod of cpufreq driver */
++      if (cpumask_available(amu_fie_cpus) &&
--      if (unlikely(cpumask_subset(cpus, amu_fie_cpus)))
++          unlikely(cpumask_subset(cpus, amu_fie_cpus)))
                return;

        for_each_cpu(cpu, cpus) {
@@@ -305,6 -202,6 +306,10 @@@
                        return;
        }

++      if (!cpumask_available(amu_fie_cpus) &&
++              !zalloc_cpumask_var(&amu_fie_cpus, GFP_KERNEL))
++              return;
++

In both cases we risk not setting up AMUs for FIE for all or some CPUs
if we fail to allocate the memory but I guess we are already there.
@Ionela: What do you think?

> > > Also I don't see anyone calling amu_fie_setup(), so where do you think
> > > the possible use after free could occur for amu_fie_cpus. Just thinking
> > > out loud to check if I missed anything.
> > >
> > You haven't missed anything. Currently the uaf is purely theoretical as the code
> > that relies on that mask will only be executed if we have succeeded to register
> > the amu fie support: so far so good.
> 
> Yes it is better to handle it even if it is theoretical.
> 
> I assume you get some compiler error if you assign unconditionally and
> if(IS_ENABLED()) also doesn't work in this case as it would still give
> error ?
Yes, the #if is needed to exclude it from compilation if !CPUMASK_OFFSTACK.

---
BR
Beata
> 
> --
> Regards,
> Sudeep

