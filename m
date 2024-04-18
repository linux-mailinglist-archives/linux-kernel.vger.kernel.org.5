Return-Path: <linux-kernel+bounces-150431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE838A9F37
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236261F2409F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A2816F833;
	Thu, 18 Apr 2024 15:55:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCE24C63A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713455755; cv=none; b=tCLL83lyHYEp4+0tg5vQKkDDH0QYaHzMHLKAH2T71bYktoNmp57eaedQ8C4TpnUe4IP4EFND1790EYi/RpkTvqKy5GHP+IS53wdc/9eSlD7xrPaurE3WhRcMphYEySWvvjzg2Fs4zZl6XJWlDfE5WbVbJa/eZ23lfIL1oHjRxes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713455755; c=relaxed/simple;
	bh=IkFYKStb5vVjFfojXz2L6X80mSnRJF2jFkHrNp/7Oz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uW0HnbePcTTWBjAl861fQjHho3RbOtAH4nK5SojIcKUb0sgV7rNVNPWd86E5Njl99BxSPrBJpyeaiXc726Onup4YnYmyGEFzSZrYIZntTduXwgetgbCEyKqnFGP/OYMZyBvInt3gKPetxdnHqDz839+5G0MZjP6UUjH0IvbjROo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E935F2F;
	Thu, 18 Apr 2024 08:56:20 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8A5D3F64C;
	Thu, 18 Apr 2024 08:55:49 -0700 (PDT)
Date: Thu, 18 Apr 2024 17:55:43 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	ionela.voinescu@arm.com, vanshikonda@os.amperecomputing.com,
	will@kernel.org, catalin.marinas@arm.com,
	vincent.guittot@linaro.org, sumitg@nvidia.com,
	yang@os.amperecomputing.com, lihuisong@huawei.com,
	viresh.kumar@linaro.org
Subject: Re: [PATCH v5 2/5] arm64: amu: Rule out potential use after free
Message-ID: <ZiFCfwEvdJxg6Hth@arm.com>
References: <20240417093848.1555462-1-beata.michalska@arm.com>
 <20240417093848.1555462-3-beata.michalska@arm.com>
 <20240418105052.zvkomz5yeayie4ph@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418105052.zvkomz5yeayie4ph@bogus>

On Thu, Apr 18, 2024 at 11:50:52AM +0100, Sudeep Holla wrote:
> On Wed, Apr 17, 2024 at 10:38:45AM +0100, Beata Michalska wrote:
> > For the time being, the amu_fie_cpus cpumask is being exclusively used
> > by the AMU-related internals of FIE support and is guaranteed to be
> > valid on every access currently made. Still the mask is not being
> > invalidated on one of the error handling code paths, which leaves
> > a soft spot with potential risk of uaf for CPUMASK_OFFSTACK cases.
> > To make things sound, set the cpumaks pointer explicitly to NULL upon
> > failing to register the cpufreq notifier.
> > Note that, due to the quirks of CPUMASK_OFFSTACK, this change needs to
> > be wrapped with grim ifdefing (it would be better served by
> > incorporating this into free_cpumask_var ...)
> >
> 
> Yes it doesn't look neat.
> 
> > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> > ---
> >  arch/arm64/kernel/topology.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> > index 1a2c72f3e7f8..3c814a278534 100644
> > --- a/arch/arm64/kernel/topology.c
> > +++ b/arch/arm64/kernel/topology.c
> > @@ -244,8 +244,12 @@ static int __init init_amu_fie(void)
> >
> >  	ret = cpufreq_register_notifier(&init_amu_fie_notifier,
> >  					CPUFREQ_POLICY_NOTIFIER);
> > -	if (ret)
> > +	if (ret) {
> >  		free_cpumask_var(amu_fie_cpus);
> > +#ifdef CONFIG_CPUMASK_OFFSTACK
> > +		amu_fie_cpus = NULL;
> > +#endif
> > +	}
> 
> Instead of this #ifdeffery, I was wondering if we can actually do the
> allocation in init_amu_fie_callback() the first time it gets called
> checking if amu_fie_cpus is NULL. init_amu_fie_callback() must get called
> only if the cpufreq_register_notifier() succeeds right ?
> 
Delayed allocation ... I guess this will do the trick.
> Also I don't see anyone calling amu_fie_setup(), so where do you think
> the possible use after free could occur for amu_fie_cpus. Just thinking
> out loud to check if I missed anything.
>
You haven't missed anything. Currently the uaf is purely theoretical as the code
that relies on that mask will only be executed if we have succeeded to register
the amu fie support: so far so good.
This change is required for following patches, where that mask is being used to
determine if given CPU has been setup with AMU counters, and as such there needs
to be a safe way to validate it (at any time) by arch_freq_get_on_cpu and
arch_cpu_idle_enter (patches 3/5 & 4/5): both will be called from outside the
FIE.  Without this change, if cpufreq_register_notifier fails in init_amu_fie,
we will have amu_fie_cpus pointing to released memory.

Hope that makes things more clear.

---
BR
Beata
> --
> Regards,
> Sudeep

