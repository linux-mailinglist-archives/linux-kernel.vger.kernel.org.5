Return-Path: <linux-kernel+bounces-42947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89039840923
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014491F27960
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481821534EC;
	Mon, 29 Jan 2024 14:58:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44B1152E0F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706540293; cv=none; b=dDCRxAv4MmaksQ1xLak+papWC+2t1A71ubRFVw+U0tyHQGlLBzVse384/dS7C7dZWDN4a+J8mzvYAuizuBDHB5rkdKScOQqO2QTeRxYjO96K+u+ilbKY0DqsYbuFCypAU/YXNjFiPP2VuCRiAtnzB5v7IpfuT3uWdCglMmFnoII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706540293; c=relaxed/simple;
	bh=dUXxx5YwYdIUiP+yNNH4SbAazb+SQA7QJdosJHirv1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gOGbgfmPYX3Lwsv2I4W2F3cZHFAXwf59J7R9ajspdcKjLLnTh6zcwWIbpxuFcluifk/SJ/4axgq+WUlun8Upm3Evpo/OY1Nc4Nw5yzdttDYn7lI8o3NY6k/G3Yie27TXcye3fIhz5fbd7S5dhvkeqoQqoZ/xAT9uvQ213RfFwXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF5FADA7;
	Mon, 29 Jan 2024 06:58:53 -0800 (PST)
Received: from [10.57.77.253] (unknown [10.57.77.253])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC9FA3F738;
	Mon, 29 Jan 2024 06:58:08 -0800 (PST)
Message-ID: <e5ab27ab-05b4-40d5-aaba-245259d325ea@arm.com>
Date: Mon, 29 Jan 2024 14:58:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iommu: Probe right iommu_ops for device
Content-Language: en-GB
To: Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240126105341.78086-1-baolu.lu@linux.intel.com>
 <20240126105341.78086-3-baolu.lu@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240126105341.78086-3-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-26 10:53 am, Lu Baolu wrote:
> Previously, in the iommu probe device path, __iommu_probe_device() gets
> the iommu_ops for the device from dev->iommu->fwspec if this field has
> been initialized before probing. Otherwise, it is assumed that only one
> of Intel, AMD, s390, PAMU or legacy SMMUv2 can be present, hence it's
> feasible to lookup the global iommu device list and use the iommu_ops of
> the first iommu device which has no dev->iommu->fwspec.
> 
> The assumption mentioned above is no longer correct with the introduction
> of the IOMMUFD mock device on x86 platforms. There might be multiple
> instances of iommu drivers, none of which have the dev->iommu->fwspec
> field populated.
> 
> Probe the right iommu_ops for device by iterating over all the global
> drivers and call their probe function to find a match.

This will now break several drivers which are no longer expecting to see 
a ->probe_device call without having seen the corresponding ->of_xlate 
call first.

Can we please just do the trivial fix to iommufd itself? At this point I 
don't mind if it's your v1, the even simpler one I proposed 2 months 
ago[1], or anything else similarly self-contained.

Thanks,
Robin.

[1] 
https://lore.kernel.org/linux-iommu/e365c08b21a8d0b60e6f5d1411be6701c1a06a53.1701165201.git.robin.murphy@arm.com/

> Fixes: 17de3f5fdd35 ("iommu: Retire bus ops")
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/iommu.c | 76 +++++++++++++++++++++++++++----------------
>   1 file changed, 48 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 0af0b5544072..2cdb01e411fa 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -396,30 +396,69 @@ void dev_iommu_priv_set(struct device *dev, void *priv)
>   }
>   EXPORT_SYMBOL_GPL(dev_iommu_priv_set);
>   
> +static struct iommu_device *
> +__iommu_do_probe_device(struct device *dev, const struct iommu_ops *ops)
> +{
> +	struct iommu_device *iommu_dev;
> +
> +	if (!try_module_get(ops->owner))
> +		return ERR_PTR(-EINVAL);
> +
> +	iommu_dev = ops->probe_device(dev);
> +	if (IS_ERR(iommu_dev))
> +		module_put(ops->owner);
> +
> +	return iommu_dev;
> +}
> +
> +static struct iommu_device *iommu_probe_device_ops(struct device *dev)
> +{
> +	struct iommu_device *iter, *iommu_dev = ERR_PTR(-ENODEV);
> +	struct iommu_fwspec *fwspec;
> +
> +	/*
> +	 * For FDT-based systems and ACPI IORT/VIOT, drivers register IOMMU
> +	 * instances with non-NULL fwnodes, and client devices should have been
> +	 * identified with a fwspec by this point. Otherwise, we will iterate
> +	 * over all the global drivers and call their probe function to find a
> +	 * match.
> +	 */
> +	fwspec = dev_iommu_fwspec_get(dev);
> +	if (fwspec && fwspec->ops)
> +		return __iommu_do_probe_device(dev, fwspec->ops);
> +
> +	mutex_lock(&iommu_device_lock);
> +	list_for_each_entry(iter, &iommu_device_list, list) {
> +		iommu_dev = __iommu_do_probe_device(dev, iter->ops);
> +		if (!IS_ERR(iommu_dev))
> +			break;
> +	}
> +	mutex_unlock(&iommu_device_lock);
> +
> +	return iommu_dev;
> +}
> +
>   /*
>    * Init the dev->iommu and dev->iommu_group in the struct device and get the
>    * driver probed
>    */
> -static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
> +static int iommu_init_device(struct device *dev)
>   {
>   	struct iommu_device *iommu_dev;
> +	const struct iommu_ops *ops;
>   	struct iommu_group *group;
>   	int ret;
>   
>   	if (!dev_iommu_get(dev))
>   		return -ENOMEM;
>   
> -	if (!try_module_get(ops->owner)) {
> -		ret = -EINVAL;
> -		goto err_free;
> -	}
> -
> -	iommu_dev = ops->probe_device(dev);
> +	iommu_dev = iommu_probe_device_ops(dev);
>   	if (IS_ERR(iommu_dev)) {
>   		ret = PTR_ERR(iommu_dev);
> -		goto err_module_put;
> +		goto err_free;
>   	}
>   	dev->iommu->iommu_dev = iommu_dev;
> +	ops = dev_iommu_ops(dev);
>   
>   	ret = iommu_device_link(iommu_dev, dev);
>   	if (ret)
> @@ -444,7 +483,6 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
>   err_release:
>   	if (ops->release_device)
>   		ops->release_device(dev);
> -err_module_put:
>   	module_put(ops->owner);
>   err_free:
>   	dev->iommu->iommu_dev = NULL;
> @@ -499,28 +537,10 @@ DEFINE_MUTEX(iommu_probe_device_lock);
>   
>   static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
>   {
> -	const struct iommu_ops *ops;
> -	struct iommu_fwspec *fwspec;
>   	struct iommu_group *group;
>   	struct group_device *gdev;
>   	int ret;
>   
> -	/*
> -	 * For FDT-based systems and ACPI IORT/VIOT, drivers register IOMMU
> -	 * instances with non-NULL fwnodes, and client devices should have been
> -	 * identified with a fwspec by this point. Otherwise, we can currently
> -	 * assume that only one of Intel, AMD, s390, PAMU or legacy SMMUv2 can
> -	 * be present, and that any of their registered instances has suitable
> -	 * ops for probing, and thus cheekily co-opt the same mechanism.
> -	 */
> -	fwspec = dev_iommu_fwspec_get(dev);
> -	if (fwspec && fwspec->ops)
> -		ops = fwspec->ops;
> -	else
> -		ops = iommu_ops_from_fwnode(NULL);
> -
> -	if (!ops)
> -		return -ENODEV;
>   	/*
>   	 * Serialise to avoid races between IOMMU drivers registering in
>   	 * parallel and/or the "replay" calls from ACPI/OF code via client
> @@ -534,7 +554,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>   	if (dev->iommu_group)
>   		return 0;
>   
> -	ret = iommu_init_device(dev, ops);
> +	ret = iommu_init_device(dev);
>   	if (ret)
>   		return ret;
>   

