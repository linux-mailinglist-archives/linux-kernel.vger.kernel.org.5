Return-Path: <linux-kernel+bounces-144531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3AE8A477A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CC3FB21F39
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 05:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03F04A23;
	Mon, 15 Apr 2024 05:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S3sLvVA+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82E7803
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 05:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713157682; cv=none; b=oyNOgFqm/T6GK2DD/l0iV8RHFXdL1jUwGdIM3al1yKSbkAEeenofp6Q0iCOf9y2vjBfqeWPKIVNzAb11pSO5IO/egheuFuKgFtQo/7JRA61K/E62r1ocK35Vxd7j60JeZHSKcGhRXiyt7ZdN1Sv21PJCdWlDPGTAjWPhv5FY3fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713157682; c=relaxed/simple;
	bh=nBp1aa7icvI98EARrvbLcFWnA3dhsJ9+1045QRPkjIQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jQLmAOqRYu/+k9gsxNwY2MWCCSdHg5oGkJ2ircw9AuBnrzI22dUE9rZSQ2x483LE/4ne3ziHy7FC4opghsIMZejyeQg3zRUb+evdmV9MVfQKVbMguJDHQ2t9G/0vYsNcW6/rEL8m786ewPx6em0goDn8/+16qFXoKuba8T6Fn7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S3sLvVA+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713157680; x=1744693680;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nBp1aa7icvI98EARrvbLcFWnA3dhsJ9+1045QRPkjIQ=;
  b=S3sLvVA+YNz92c1IiQAEhZFdZ9nnE7nrcNbTSzNOU7IfkXLFtmmWXeC2
   E38LZLskmGSBGD28JVQ+/VKR+D8btTTseTSRUYxCoAF7gtRvgJsDbDnZE
   Ye8zyMwbtI0Kt7jG4KTgwfIyyKAormEhlXYgzBueU9YTVkFo+1+VSfhLL
   +LQzTs3nuQQWFagy4aMQ0nl84BF09TMkYVlm2LcBQxJM7Z+v6i67+CcEf
   zxxNC7x+HjBRXXAR/D1vYFfKGiS7LnogCDSfABRVN7WNJQDDV5dYJ8CTX
   gCwn1bC1c2wX7r/nGJjFg894OXi8hj9gcLITSNHTkplKf4nJro6RlXlOK
   A==;
X-CSE-ConnectionGUID: I5AulA7KTlOSrQR1SrXmaA==
X-CSE-MsgGUID: OjABIwM/QZSMqvvmhX/lPg==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="8699326"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="8699326"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 22:08:00 -0700
X-CSE-ConnectionGUID: fMWRZStvTT2P2zP8iEriUA==
X-CSE-MsgGUID: 9wK9YF/xT1qzVKiRjO15tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="26429988"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa004.fm.intel.com with ESMTP; 14 Apr 2024 22:07:57 -0700
Message-ID: <285d70cc-f65b-4d76-81cf-c9da2952dcf2@linux.intel.com>
Date: Mon, 15 Apr 2024 13:06:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "Liu, Yi L" <yi.l.liu@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 02/12] iommu/vt-d: Add cache tag invalidation helpers
To: "Zhang, Tina" <tina.zhang@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20240410020844.253535-1-baolu.lu@linux.intel.com>
 <20240410020844.253535-3-baolu.lu@linux.intel.com>
 <MW5PR11MB5881FE21211FCED9B9BCBAB189092@MW5PR11MB5881.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <MW5PR11MB5881FE21211FCED9B9BCBAB189092@MW5PR11MB5881.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/15/24 12:15 PM, Zhang, Tina wrote:
> 
>> -----Original Message-----
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Wednesday, April 10, 2024 10:09 AM
>> To: Joerg Roedel<joro@8bytes.org>; Will Deacon<will@kernel.org>; Robin
>> Murphy<robin.murphy@arm.com>; Tian, Kevin<kevin.tian@intel.com>;
>> Jason Gunthorpe<jgg@ziepe.ca>
>> Cc: Zhang, Tina<tina.zhang@intel.com>; Liu, Yi L<yi.l.liu@intel.com>;
>> iommu@lists.linux.dev;linux-kernel@vger.kernel.org; Lu Baolu
>> <baolu.lu@linux.intel.com>
>> Subject: [PATCH v2 02/12] iommu/vt-d: Add cache tag invalidation helpers
>>
>> Add several helpers to invalidate the caches after mappings in the affected
>> domain are changed.
>>
>> - cache_tag_flush_range() invalidates a range of caches after mappings
>>    within this range are changed. It uses the page-selective cache
>>    invalidation methods.
>>
>> - cache_tag_flush_all() invalidates all caches tagged by a domain ID.
>>    It uses the domain-selective cache invalidation methods.
>>
>> - cache_tag_flush_range_np() invalidates a range of caches when new
>>    mappings are created in the domain and the corresponding page table
>>    entries change from non-present to present.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.h |  14 +++
>>   drivers/iommu/intel/cache.c | 195
>> ++++++++++++++++++++++++++++++++++++
>>   drivers/iommu/intel/iommu.c |  12 ---
>>   3 files changed, 209 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>> index 6f6bffc60852..700574421b51 100644
>> --- a/drivers/iommu/intel/iommu.h
>> +++ b/drivers/iommu/intel/iommu.h
>> @@ -35,6 +35,8 @@
>>   #define VTD_PAGE_MASK		(((u64)-1) << VTD_PAGE_SHIFT)
>>   #define VTD_PAGE_ALIGN(addr)	(((addr) + VTD_PAGE_SIZE - 1) &
>> VTD_PAGE_MASK)
>>
>> +#define IOVA_PFN(addr)		((addr) >> PAGE_SHIFT)
>> +
>>   #define VTD_STRIDE_SHIFT        (9)
>>   #define VTD_STRIDE_MASK         (((u64)-1) << VTD_STRIDE_SHIFT)
>>
>> @@ -1041,6 +1043,13 @@ static inline void context_set_sm_pre(struct
>> context_entry *context)
>>   	context->lo |= BIT_ULL(4);
>>   }
>>
>> +/* Returns a number of VTD pages, but aligned to MM page size */ static
>> +inline unsigned long aligned_nrpages(unsigned long host_addr, size_t
>> +size) {
>> +	host_addr &= ~PAGE_MASK;
>> +	return PAGE_ALIGN(host_addr + size) >> VTD_PAGE_SHIFT; }
>> +
>>   /* Convert value to context PASID directory size field coding. */
>>   #define context_pdts(pds)	(((pds) & 0x7) << 9)
>>
>> @@ -1116,6 +1125,11 @@ int cache_tag_assign_domain(struct
>> dmar_domain *domain, u16 did,
>>   			    struct device *dev, ioasid_t pasid);  void
>> cache_tag_unassign_domain(struct dmar_domain *domain, u16 did,
>>   			       struct device *dev, ioasid_t pasid);
>> +void cache_tag_flush_range(struct dmar_domain *domain, unsigned long
>> start,
>> +			   unsigned long end, int ih);
>> +void cache_tag_flush_all(struct dmar_domain *domain); void
>> +cache_tag_flush_range_np(struct dmar_domain *domain, unsigned long
>> start,
>> +			      unsigned long end);
>>
>>   #ifdef CONFIG_INTEL_IOMMU_SVM
>>   void intel_svm_check(struct intel_iommu *iommu); diff --git
>> a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c index
>> debbdaeff1c4..b2270dc8a765 100644
>> --- a/drivers/iommu/intel/cache.c
>> +++ b/drivers/iommu/intel/cache.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/dmar.h>
>>   #include <linux/iommu.h>
>>   #include <linux/memory.h>
>> +#include <linux/pci.h>
>>   #include <linux/spinlock.h>
>>
>>   #include "iommu.h"
>> @@ -194,3 +195,197 @@ void cache_tag_unassign_domain(struct
>> dmar_domain *domain, u16 did,
>>   	if (domain->domain.type == IOMMU_DOMAIN_NESTED)
>>   		__cache_tag_unassign_parent_domain(domain->s2_domain,
>> did, dev, pasid);  }
>> +
>> +static unsigned long calculate_psi_aligned_address(unsigned long start,
>> +						   unsigned long end,
>> +						   unsigned long *_pages,
>> +						   unsigned long *_mask)
>> +{
>> +	unsigned long pages = aligned_nrpages(start, end - start + 1);
>> +	unsigned long aligned_pages = __roundup_pow_of_two(pages);
>> +	unsigned long bitmask = aligned_pages - 1;
>> +	unsigned long mask = ilog2(aligned_pages);
>> +	unsigned long pfn = IOVA_PFN(start);
>> +
>> +	/*
>> +	 * PSI masks the low order bits of the base address. If the
>> +	 * address isn't aligned to the mask, then compute a mask value
>> +	 * needed to ensure the target range is flushed.
>> +	 */
>> +	if (unlikely(bitmask & pfn)) {
>> +		unsigned long end_pfn = pfn + pages - 1, shared_bits;
>> +
>> +		/*
>> +		 * Since end_pfn <= pfn + bitmask, the only way bits
>> +		 * higher than bitmask can differ in pfn and end_pfn is
>> +		 * by carrying. This means after masking out bitmask,
>> +		 * high bits starting with the first set bit in
>> +		 * shared_bits are all equal in both pfn and end_pfn.
>> +		 */
>> +		shared_bits = ~(pfn ^ end_pfn) & ~bitmask;
>> +		mask = shared_bits ? __ffs(shared_bits) : BITS_PER_LONG;
>> +	}
>> +
>> +	*_pages = aligned_pages;
>> +	*_mask = mask;
>> +
>> +	return ALIGN_DOWN(start, VTD_PAGE_SIZE); }
> It's a good idea to use the above logic to calculate the appropriate mask for non-size-aligned page selective invalidation for all domains, including sva domain. Sounds like we plan to allow non-size-aligned page selection invalidation.
> 
> However, currently there are some places in the code which have the assumption that the size of the page selective invalidation should be aligned with the start address, a.k.a. only size-aligned page selective invalidation should happen and non-size-aligned one isn't expected.
> 
> One example is in qi_flush_dev_iotlb_pasid() and there is a checking:
> 	if (!IS_ALIGNED(addr, VTD_PAGE_SIZE << size_order)
> 		pr_warn_ratelimited(...)
> If the non-size-aligned page selective invalidation is allowed, the warning message may come out which sounds confusing and impacts performance.
> 
> Another example is in qi_flush_piotlb() and there is a WARN_ON_ONCE() to remind user when non-size-aligned page selective invalidation is being used.
> 	If (WARN_ON_ONCE(!IS_ALIGNED(addr, align))
> 		...
> 
> So, can we consider removing the checking as well in this patch-set?

This series doesn't intend to change the driver's behavior, so the check
and warning you mentioned should be kept. The iommu core ensures the
invalidation size is page-size aligned. Those checks in the iommu driver
just make sure that the callers are doing things right.

Best regards,
baolu

