Return-Path: <linux-kernel+bounces-134176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D90A89AEAB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 07:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F0A2825CE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 05:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BB7184D;
	Sun,  7 Apr 2024 05:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vh8e95ri"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1996AB9
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 05:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712468051; cv=none; b=QuX5I04QX3AAMYABhuq53oBoWB6xz4Mgtsz+Rk6YuYtHxqtCQsRXd/xg8ixdwVGFofjBKzUkxaR32+CECAc8CGby7xVB29QoYcazaG8pLTcLSALS5Sav1OSIB0wJDyMFhdEBAeglzkOsjFrhwVFHYHkptGjecRgDLl9q7Bz06bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712468051; c=relaxed/simple;
	bh=hS14BoUXabQE9RbhnDRWpPJPj15kQ0oX5ql7Imy7tbg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RfBeCiMQeavWWn/b3aZmI5zsMUyoFbe4gumsGXHqtDVXUdxAQ5ybCPgiG6pK32g8WSdt/plxIx51ly1d2nBRy8Ttqv6MXPaX4QSpCCCDI8EQZwu88wYwrcrRt901QEb8sIIB6sEUP8XYoizPt/nji24gCCB7U2FplhQcTlxZ8TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vh8e95ri; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712468050; x=1744004050;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hS14BoUXabQE9RbhnDRWpPJPj15kQ0oX5ql7Imy7tbg=;
  b=Vh8e95riOHwf5PGWscTH55T4+Tv4ZF5LD74XBUhcOFXxo81/AA9R+Mbz
   wxI3OZJOb7i5o5z0RScO5Co+9iC2C4Vw1JxehWEXXeHKi0OYUx2jSwhdu
   JlPYAA4ZVskDsuBsfDqbcq+5MHDXtfEuoLIH2XJ8K2CJ1HABL9hiQqhIx
   q3DL8KMzM2Wa7rHB7E8rhd/eUqcaZb475hUtLFl8VcQMUFg79YMJTB5Ll
   amqh0NC8LiMbEJ7rvo32vkR77BlB55zss2GwctiUjj/TbfWEkBiwXqtGR
   N5DFnyjWpt+c/Tdr5RMSTDej83jorwtkGgqWfN4nvDzu7t0kJ2KSDwTy6
   g==;
X-CSE-ConnectionGUID: 9BWXQczLSfOQd7PZCNXadQ==
X-CSE-MsgGUID: 1OS5/5U8Rd6bKLHNsiQ2QQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="8334132"
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="8334132"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2024 22:34:09 -0700
X-CSE-ConnectionGUID: 3snujzdnQQeW0hmoBOLzQw==
X-CSE-MsgGUID: VvFcIJIeTFuRWKvRCUiFmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="24046191"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa005.fm.intel.com with ESMTP; 06 Apr 2024 22:34:06 -0700
Message-ID: <9aeb7dfd-e8af-4da8-b67e-274f3227efa4@linux.intel.com>
Date: Sun, 7 Apr 2024 13:33:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "Zhang, Tina" <tina.zhang@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/12] iommu/vt-d: Add cache tag invalidation helpers
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
 <20240325021705.249769-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52769F48D89273B0CCAA0B7C8C3B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52769F48D89273B0CCAA0B7C8C3B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/28/24 3:39 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, March 25, 2024 10:17 AM
>>
>> +
>> +static unsigned long calculate_psi_aligned_address(unsigned long start,
>> +						   unsigned long end,
>> +						   unsigned long *_pages,
>> +						   unsigned long *_mask)
>> +{
>> +	unsigned long pages = (end - start + VTD_PAGE_SIZE - 1) >>
>> VTD_PAGE_SHIFT;
> 
> this doesn't sound correct. You'd want to follow aligned_nrpages().

Okay, I will make it like below.

	unsigned long pages = aligned_nrpages(start, end - start + 1);

> 
>> +		case CACHE_TAG_TYPE_DEVTLB:
>> +			if (tag->pasid == IOMMU_NO_PASID)
>> +				qi_flush_dev_iotlb(iommu, sid, info->pfsid,
>> +						   info->ats_qdep, addr,
>> mask);
>> +			else
>> +				qi_flush_dev_iotlb_pasid(iommu, sid, info-
>>> pfsid,
>> +							 tag->pasid, info-
>>> ats_qdep,
>> +							 addr, mask);
>> +
>> +			quirk_extra_dev_tlb_flush(info, addr, mask, tag-
>>> pasid, info->ats_qdep);
>> +			break;
>> +		case CACHE_TAG_TYPE_PARENT_DEVTLB:
>> +			/*
>> +			 * Address translation cache in device side caches the
>> +			 * result of nested translation. There is no easy way
>> +			 * to identify the exact set of nested translations
>> +			 * affected by a change in S2. So just flush the entire
>> +			 * device cache.
>> +			 */
>> +			qi_flush_dev_iotlb(iommu, sid, info->pfsid, info-
>>> ats_qdep,
>> +					   0, MAX_AGAW_PFN_WIDTH);
>> +			quirk_extra_dev_tlb_flush(info, 0,
>> MAX_AGAW_PFN_WIDTH,
>> +						  IOMMU_NO_PASID, info-
>>> ats_qdep);
>> +			break;
> 
> parent devtlb can has pasid too, though not enabled now. As core helpers
> probably we can support it now leading to simpler code:
> 
> 	case CACHE_TAG_TYPE_PARENT_DEVTLB:
> 		//change addr/mask
> 		//fallthrough
> 	case CACHE_TAG_TYPE_DEVTLB:
> 		//what this patch does

Yes. Yours is better. I will make it like below:

+               case CACHE_TAG_PARENT_DEVTLB:
+                       /*
+                        * Address translation cache in device side 
caches the
+                        * result of nested translation. There is no 
easy way
+                        * to identify the exact set of nested translations
+                        * affected by a change in S2. So just flush the 
entire
+                        * device cache.
+                        */
+                       addr = 0;
+                       mask = MAX_AGAW_PFN_WIDTH;
+                       fallthrough;
                 case CACHE_TAG_DEVTLB:


>> +void cache_tag_flush_all(struct dmar_domain *domain)
>> +{
>> +	struct cache_tag *tag;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&domain->cache_lock, flags);
>> +	list_for_each_entry(tag, &domain->cache_tags, node) {
>> +		struct device_domain_info *info = dev_iommu_priv_get(tag-
>>> dev);
>> +		struct intel_iommu *iommu = tag->iommu;
>> +		u16 sid = PCI_DEVID(info->bus, info->devfn);
>> +
>> +		switch (tag->type) {
>> +		case CACHE_TAG_TYPE_IOTLB:
>> +		case CACHE_TAG_TYPE_PARENT_IOTLB:
>> +			if (domain->use_first_level)
>> +				qi_flush_piotlb(iommu, tag->domain_id,
>> +						tag->pasid, 0, -1, 0);
>> +			else
>> +				iommu->flush.flush_iotlb(iommu, tag-
>>> domain_id,
>> +							 0, 0,
>> DMA_TLB_DSI_FLUSH);
>> +			break;
>> +		case CACHE_TAG_TYPE_DEVTLB:
>> +		case CACHE_TAG_TYPE_PARENT_DEVTLB:
>> +			qi_flush_dev_iotlb(iommu, sid, info->pfsid, info-
>>> ats_qdep,
>> +					   0, MAX_AGAW_PFN_WIDTH);
>> +			quirk_extra_dev_tlb_flush(info, 0,
>> MAX_AGAW_PFN_WIDTH,
>> +						  IOMMU_NO_PASID, info-
>>> ats_qdep);
>> +			break;
>> +		}
>> +	}
> 
> could this loop be consolidated with the one in previous helper? anyway
> the only difference is on addr/mask...
> 
>> +/*
>> + * Invalidate a range of IOVA when IOMMU is in caching mode and new
>> mappings
>> + * are added to the target domain.
>> + */
>> +void cache_tag_flush_cm_range(struct dmar_domain *domain, unsigned
>> long start,
>> +			      unsigned long end)
>> +{
> 
> I'm also not sure why this is worth a separate helper. why couldn't it
> be managed by previous flush_range()?
This is only my preference. I'd like to separate things belonging to
different paths, so that it's easier for maintenance. For example, if,
in the future, we need to add or enhance something for a specific case,
we don't need to care about other cases.

> 
>> +	unsigned long pages, mask, addr;
>> +	struct cache_tag *tag;
>> +	unsigned long flags;
>> +
>> +	addr = calculate_psi_aligned_address(start, end, &pages, &mask);
>> +
>> +	spin_lock_irqsave(&domain->cache_lock, flags);
>> +	list_for_each_entry(tag, &domain->cache_tags, node) {
>> +		struct intel_iommu *iommu = tag->iommu;
>> +
>> +		/*
>> +		 * When IOMMU is enabled in caching mode some non-
>> present
>> +		 * mappings may be cached by the IOTLB if it uses second-
>> +		 * only translation.
>> +		 */
>> +		if (!cap_caching_mode(iommu->cap) || domain-
>>> use_first_level) {
>> +			iommu_flush_write_buffer(iommu);
>> +			continue;
>> +		}
> 
> the comment really doesn't tell what this block does. from its intention
> it probably more suitable to be in the caller side as today.

Yes, agreed. Will remove it.

> 
>> +
>> +		if (tag->type == CACHE_TAG_TYPE_IOTLB ||
>> +		    tag->type == CACHE_TAG_TYPE_PARENT_IOTLB) {
>> +			/*
>> +			 * Fallback to domain selective flush if no
>> +			 * PSI support or the size is too big.
>> +			 */
>> +			if (!cap_pgsel_inv(iommu->cap) ||
>> +			    mask > cap_max_amask_val(iommu->cap))
>> +				iommu->flush.flush_iotlb(iommu, tag-
>>> domain_id,
>> +							 0, 0,
>> DMA_TLB_DSI_FLUSH);
>> +			else
>> +				iommu->flush.flush_iotlb(iommu, tag-
>>> domain_id,
>> +							 addr, mask,
>> +
>> DMA_TLB_PSI_FLUSH);
>> +		}
>> +	}
> 
> You skipped devtlb invalidation. yes it's not necessary based on current
> nested translation design and this part is inconsistent in different paths.
> 
> but as a semantics change you may want to first make removing devtlb
> invalidation a separate patch and then do this cleanup, so bisect is easier.

This helper is designed for map paths when the IOMMU is in caching mode.
Caching mode doesn't impact the device TLB, so we should not invalidate
the device TLB here.

I guess the confusing thing is about the code below.


         /*
          * In caching mode, changes of pages from non-present to 
present require
          * flush. However, device IOTLB doesn't need to be flushed in 
this case.
          */
         if (!cap_caching_mode(iommu->cap) || !map)
                 iommu_flush_dev_iotlb(domain, addr, mask);

The real code doesn't match the comments, and I think the comments
describe the right thing. So perhaps the code should be changed to match
the comments.

	if (!map)
		iommu_flush_dev_iotlb(domain, addr, mask);

??

Best regards,
baolu

