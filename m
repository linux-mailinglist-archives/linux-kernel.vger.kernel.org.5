Return-Path: <linux-kernel+bounces-149916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A23E58A97D4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E6A8283291
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346D415F308;
	Thu, 18 Apr 2024 10:50:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFFA15D5D6
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437458; cv=none; b=tWR9fqyxB77Nx0vmrJ7Fj3AV1IK31ghRib+IivAGEGl0LbriVvaZUYqMflx7Oas/ymae/IBiS5DUM6kFIM1sGbOh7dch7ydW6VdKI6ACHgh9fqp8XzX331ajcEdP/b/uUuYihJcFJjs3VQp5mEITCJm1d0Z0p3lUnWpfoVsvaYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437458; c=relaxed/simple;
	bh=dKY2WJomerr9QZ5RzjY7LsILZQASd08BlEcCuguh4Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1YisDPm+sQDjfibNPperTZl1SkVrVSo61vMo1ZHDoAnlCrrJMPqpiwFzeZqKyPcWjM4QpLHG4kg+HN6ltRv49MdSUvLRyuGXvPmG8k7xxHGsQ+EMIp9a1RA9/ND9obxd4E6ssiJEdYR/l06G9RBxVucvK+Rg/7RoSfCPBjj5OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89EBA339;
	Thu, 18 Apr 2024 03:51:24 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 128223F792;
	Thu, 18 Apr 2024 03:50:54 -0700 (PDT)
Date: Thu, 18 Apr 2024 11:50:52 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Beata Michalska <beata.michalska@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	ionela.voinescu@arm.com, vanshikonda@os.amperecomputing.com,
	will@kernel.org, catalin.marinas@arm.com,
	vincent.guittot@linaro.org, sumitg@nvidia.com,
	yang@os.amperecomputing.com, lihuisong@huawei.com,
	viresh.kumar@linaro.org
Subject: Re: [PATCH v5 2/5] arm64: amu: Rule out potential use after free
Message-ID: <20240418105052.zvkomz5yeayie4ph@bogus>
References: <20240417093848.1555462-1-beata.michalska@arm.com>
 <20240417093848.1555462-3-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417093848.1555462-3-beata.michalska@arm.com>

On Wed, Apr 17, 2024 at 10:38:45AM +0100, Beata Michalska wrote:
> For the time being, the amu_fie_cpus cpumask is being exclusively used
> by the AMU-related internals of FIE support and is guaranteed to be
> valid on every access currently made. Still the mask is not being
> invalidated on one of the error handling code paths, which leaves
> a soft spot with potential risk of uaf for CPUMASK_OFFSTACK cases.
> To make things sound, set the cpumaks pointer explicitly to NULL upon
> failing to register the cpufreq notifier.
> Note that, due to the quirks of CPUMASK_OFFSTACK, this change needs to
> be wrapped with grim ifdefing (it would be better served by
> incorporating this into free_cpumask_var ...)
>

Yes it doesn't look neat.

> Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> ---
>  arch/arm64/kernel/topology.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 1a2c72f3e7f8..3c814a278534 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -244,8 +244,12 @@ static int __init init_amu_fie(void)
>
>  	ret = cpufreq_register_notifier(&init_amu_fie_notifier,
>  					CPUFREQ_POLICY_NOTIFIER);
> -	if (ret)
> +	if (ret) {
>  		free_cpumask_var(amu_fie_cpus);
> +#ifdef CONFIG_CPUMASK_OFFSTACK
> +		amu_fie_cpus = NULL;
> +#endif
> +	}

Instead of this #ifdeffery, I was wondering if we can actually do the
allocation in init_amu_fie_callback() the first time it gets called
checking if amu_fie_cpus is NULL. init_amu_fie_callback() must get called
only if the cpufreq_register_notifier() succeeds right ?

Also I don't see anyone calling amu_fie_setup(), so where do you think
the possible use after free could occur for amu_fie_cpus. Just thinking
out loud to check if I missed anything.

--
Regards,
Sudeep

