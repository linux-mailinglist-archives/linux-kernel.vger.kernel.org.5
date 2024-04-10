Return-Path: <linux-kernel+bounces-138988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2C289FD10
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7914AB293E2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BC817B4E8;
	Wed, 10 Apr 2024 16:37:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E38816F274
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712767031; cv=none; b=igyy4j4D4uS17/oOxdh1j4pjCsOO9etwg9ORTUhxu1bV1pIh9CgtbOGcLGFD+y/ElxBBkVJWJjtQlsw5v9PFgSVjtGIQipQf0CcdoOu1f0FDo5GqkKrk/86h0EIa5eprB14zAx4hONW4XOgTt4g4nHAkEbJ7/XKnlUgoFC6Q83Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712767031; c=relaxed/simple;
	bh=wY8a3bi6jEqKcdiIKKypYn3FBf08SvzztehZy4MIMMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UThC2R50UJc0qZpluaoqbQKPVcpqfP2oCEMluIkcSFyw8GWPy3OCHYsA8k0x3oSPIgxLGd8+kpnDUKP81TEdJU+qrkfIa6tB6KHKzCbIbJxL2bQKPWyb4tn0PROcikbJKTDqIFfDCqlCKtV/Vvhwkf7d2dPdsqNu13AGBu4MKAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 880A2139F;
	Wed, 10 Apr 2024 09:37:38 -0700 (PDT)
Received: from [10.57.53.164] (unknown [10.57.53.164])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 508A53F766;
	Wed, 10 Apr 2024 09:37:07 -0700 (PDT)
Message-ID: <0dda6ce6-1b82-4168-93b7-a0e847ce9b08@arm.com>
Date: Wed, 10 Apr 2024 17:37:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] iommu: Add static iommu_ops->release_domain
Content-Language: en-GB
To: Jason Gunthorpe <jgg@ziepe.ca>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Kevin Tian <kevin.tian@intel.com>, Eric Badger <ebadger@purestorage.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240305013305.204605-1-baolu.lu@linux.intel.com>
 <20240305013305.204605-2-baolu.lu@linux.intel.com>
 <20240410152606.GF223006@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240410152606.GF223006@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-04-10 4:26 pm, Jason Gunthorpe wrote:
> On Tue, Mar 05, 2024 at 09:33:01AM +0800, Lu Baolu wrote:
>> The current device_release callback for individual iommu drivers does the
>> following:
>>
>> 1) Silent IOMMU DMA translation: It detaches any existing domain from the
>>     device and puts it into a blocking state (some drivers might use the
>>     identity state).
>> 2) Resource release: It releases resources allocated during the
>>     device_probe callback and restores the device to its pre-probe state.
>>
>> Step 1 is challenging for individual iommu drivers because each must check
>> if a domain is already attached to the device. Additionally, if a deferred
>> attach never occurred, the device_release should avoid modifying hardware
>> configuration regardless of the reason for its call.
>>
>> To simplify this process, introduce a static release_domain within the
>> iommu_ops structure. It can be either a blocking or identity domain
>> depending on the iommu hardware. The iommu core will decide whether to
>> attach this domain before the device_release callback, eliminating the
>> need for repetitive code in various drivers.
>>
>> Consequently, the device_release callback can focus solely on the opposite
>> operations of device_probe, including releasing all resources allocated
>> during that callback.
>>
>> Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>> ---
>>   include/linux/iommu.h |  1 +
>>   drivers/iommu/iommu.c | 19 +++++++++++++++----
>>   2 files changed, 16 insertions(+), 4 deletions(-)
> 
> I looked at all the drivers:
>   1) Didn't spend time to guess what ipmmu-vmss is doing
>   2) Several drivers are obviously missing the release_domain behavior
>      and now be trivially fixed
>   3) amd, s390, virtio-iommu and arm-smmu should probably support
>      blocked_domain (I assume that is what their detach does)
>   4) arm-smmuv3 can use it too once disable_bypass is removed
>   5) Several drivers don't even have release_device functions.
>      Probably all of them can do their identiy domains too.
> 
> This seems like a pretty reasonable thing to add to this series too:
> 
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index eb1e62cd499a58..3ddc4b4418a049 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -979,6 +979,7 @@ static void apple_dart_get_resv_regions(struct device *dev,
>   static const struct iommu_ops apple_dart_iommu_ops = {
>   	.identity_domain = &apple_dart_identity_domain,
>   	.blocked_domain = &apple_dart_blocked_domain,
> +	.release_domain = &apple_dart_blocked_domain,
>   	.domain_alloc_paging = apple_dart_domain_alloc_paging,
>   	.probe_device = apple_dart_probe_device,
>   	.release_device = apple_dart_release_device,
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index d98c9161948a25..902dc4da44f987 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -1424,8 +1424,6 @@ static void exynos_iommu_release_device(struct device *dev)
>   	struct exynos_iommu_owner *owner = dev_iommu_priv_get(dev);
>   	struct sysmmu_drvdata *data;
>   
> -	WARN_ON(exynos_iommu_identity_attach(&exynos_identity_domain, dev));
> -
>   	list_for_each_entry(data, &owner->controllers, owner_node)
>   		device_link_del(data->link);
>   }
> @@ -1471,6 +1469,7 @@ static int exynos_iommu_of_xlate(struct device *dev,
>   
>   static const struct iommu_ops exynos_iommu_ops = {
>   	.identity_domain = &exynos_identity_domain,
> +	.release_domain = &exynos_identity_domain,
>   	.domain_alloc_paging = exynos_iommu_domain_alloc_paging,
>   	.device_group = generic_device_group,
>   	.probe_device = exynos_iommu_probe_device,
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index b8c47f18bc2612..b5693041b18dd4 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -1012,6 +1012,7 @@ static void mtk_iommu_get_resv_regions(struct device *dev,
>   
>   static const struct iommu_ops mtk_iommu_ops = {
>   	.identity_domain = &mtk_iommu_identity_domain,
> +	.release_domain = &mtk_iommu_identity_domain,
>   	.domain_alloc_paging = mtk_iommu_domain_alloc_paging,
>   	.probe_device	= mtk_iommu_probe_device,
>   	.release_device	= mtk_iommu_release_device,
> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> index a9fa2a54dc9b39..9e7205af7d7316 100644
> --- a/drivers/iommu/mtk_iommu_v1.c
> +++ b/drivers/iommu/mtk_iommu_v1.c
> @@ -580,6 +580,7 @@ static int mtk_iommu_v1_hw_init(const struct mtk_iommu_v1_data *data)
>   
>   static const struct iommu_ops mtk_iommu_v1_ops = {
>   	.identity_domain = &mtk_iommu_v1_identity_domain,
> +	.release_domain = &mtk_iommu_v1_identity_domain,
>   	.domain_alloc_paging = mtk_iommu_v1_domain_alloc_paging,
>   	.probe_device	= mtk_iommu_v1_probe_device,
>   	.probe_finalize = mtk_iommu_v1_probe_finalize,
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index c9528065a59afa..c4c76aaec19e50 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -1725,6 +1725,7 @@ static void omap_iommu_release_device(struct device *dev)
>   
>   static const struct iommu_ops omap_iommu_ops = {
>   	.identity_domain = &omap_iommu_identity_domain,
> +	.release_domain = &omap_iommu_identity_domain,
>   	.domain_alloc_paging = omap_iommu_domain_alloc_paging,
>   	.probe_device	= omap_iommu_probe_device,
>   	.release_device	= omap_iommu_release_device,
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index da79d9f4cf6371..e551c5b143bbd3 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -1162,6 +1162,7 @@ static int rk_iommu_of_xlate(struct device *dev,
>   
>   static const struct iommu_ops rk_iommu_ops = {
>   	.identity_domain = &rk_identity_domain,
> +	.release_domain = &rk_identity_domain,
>   	.domain_alloc_paging = rk_iommu_domain_alloc_paging,
>   	.probe_device = rk_iommu_probe_device,
>   	.release_device = rk_iommu_release_device,
> 
>> +	if (!dev->iommu->attach_deferred && ops->release_domain)
>> +		ops->release_domain->ops->attach_dev(ops->release_domain, dev);
> 
> We should probably be sensitive to the
> dev->iommu->require_direct flag - generally drivers should prefer the
> blocked for the release domain, but in case the FW ias asking for
> require_direct we need to switch to identity.

At this point do we even need release_domain? It sounds like the logic 
you want to enforce is going to be trivial to resolve directly in the 
core code. As typed-in-mail-client pseudocode, roughly:

static void iommu_set_release_domain(struct device *dev)
{
	const struct iommu_ops *ops = dev_iommu_ops(dev);
	struct iommu_domain *rd;

	/*
	 * Static domains are expected not to track any device state,
	 * and thus be tolerant of devices disappearing once "attached"
	 */
	if (ops->blocked_domain && !(dev->iommu->require_direct || 
other_arch_or_platform_reason))
		rd = ops->blocked_domain;
	else if (ops->identity_domain)
		rd = ops->identity_domain;
	else /* Hope release_device does the right thing! */
		return;

	if (!dev->iommu->attach_deferred && rd != dev->iommu_group->domain)
		__iommu_attach_device(rd, dev);
}

..no driver churn necessary. (And frankly I think it's a further bonus 
to avoid risking any notion of release_domain being implementable as its 
own distinct special thing)

Thanks,
Robin.

> 
> Also, may as well avoid switching a domain if the group is already
> correct and use the common attach function to get the tracing.. So
> like this?
> 
> 	if (!dev->iommu->attach_deferred) {
> 		struct iommu_domain *release_domain = ops->release_domain;
> 
> 		if (dev->iommu->require_direct && ops->identity_domain)
> 			release_domain = ops->identity_domain;
> 
> 		if (release_domain && group->domain != release_domain)
> 			WARN_ON(__iommu_attach_device(release_domain, dev));
> 	}
> 
> Jason

