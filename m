Return-Path: <linux-kernel+bounces-133923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE28B89AAF4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 14:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1121F21ADC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 12:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D067832C9C;
	Sat,  6 Apr 2024 12:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FzIWa8CV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF7E652
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 12:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712408151; cv=none; b=EnN2AukfHei+vhwp6LcO/1lefxQ5MBt1qXr4N99X3iKwK2cVoIubEJgx7Mj4D5lKpaBt2BgERPD2jYXv3fAKrbxLO0BgQhN20HqP4kHARLWf7wMPWZ3jb4m67nbcXM6+aoiP7hC/hFmQRHZaHP0mSZ+hggHBRguVK2dGVknaLYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712408151; c=relaxed/simple;
	bh=0uBq/I9RS48908VoKoeGWXDGV1SpEnf+QHjKl8GwSbA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FlDCiWKGaw8weMO6CHSTz3MRcqJU5iBegR5qh6ZLvwFJM7/fZzhc7f/r+5oqwCuM9dKg+92vcARAlC5MyyiSU0xhyulbhzimx1yvoWCZYU3hZl9nsUGDn9pprVeUXe9VqqiLdGLZ2cCwNnj/m/AsPWNc3fV9ab1GlXscCJ1OC30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FzIWa8CV; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712408150; x=1743944150;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=0uBq/I9RS48908VoKoeGWXDGV1SpEnf+QHjKl8GwSbA=;
  b=FzIWa8CVczqS4R06DC9PviuCGP3Agx7eppMHwaV93RmaWwcZdGmPT1/X
   bfrY0swZ2RB5OnWPKfwDv41FWsIVvtSaQGa32JWnxUkrA9MXUD43YEicI
   himGRd0NupEeq1R4jXADv4cfF1pBWmEgvEjEXh2//PUAXbYRSLJdkt2rd
   5ow8vcoPYelZ0MeFNCkDGPnnfkHluyIJY3WQui5sMWLi693k6j37N3fPJ
   YE9WQnirWuDwxQiq9s43/wVrGxUYENO+3HOeP3FCkGR4gGx+tkrBQiwkB
   Ka0BFCNDUlVfb4PrxpOBq9qIPDffY0xd04RBfeTeC7MAiWrvCZBz4G38i
   g==;
X-CSE-ConnectionGUID: StclJKLuSauwjwMb/cBA3g==
X-CSE-MsgGUID: +DoGSFieSUizHZN0pWvx+w==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="7828778"
X-IronPort-AV: E=Sophos;i="6.07,183,1708416000"; 
   d="scan'208";a="7828778"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2024 05:55:49 -0700
X-CSE-ConnectionGUID: Ed8uX/PySGuFDLerWXEjsQ==
X-CSE-MsgGUID: K4es7CR1QTity8fq2mpi/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,183,1708416000"; 
   d="scan'208";a="50641083"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.29.89]) ([10.255.29.89])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2024 05:55:46 -0700
Message-ID: <bc76bb64-8304-4fdf-ae16-03f3e545fd67@linux.intel.com>
Date: Sat, 6 Apr 2024 20:55:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 01/12] iommu/vt-d: Add cache tag assignment interface
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: baolu.lu@linux.intel.com, "Zhang, Tina" <tina.zhang@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
 <20240325021705.249769-2-baolu.lu@linux.intel.com>
 <BN9PR11MB5276A6DDE82623A32FF80F4F8C3B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <BN9PR11MB5276A6DDE82623A32FF80F4F8C3B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kevin,

Thanks for your review comments.

On 3/28/24 3:12 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, March 25, 2024 10:17 AM
>>
>> +enum cache_tag_type {
>> +	CACHE_TAG_TYPE_IOTLB,
>> +	CACHE_TAG_TYPE_DEVTLB,
>> +	CACHE_TAG_TYPE_PARENT_IOTLB,
>> +	CACHE_TAG_TYPE_PARENT_DEVTLB,
>> +};
> 
> '_TYPE_' can be removed to make it shorter

Okay.

> 
>> +
>> +/* Checks if an existing cache tag can be reused for a new association. */
>> +static bool cache_tag_reusable(struct cache_tag *tag, u16 domain_id,
>> +			       struct intel_iommu *iommu, struct device *dev,
>> +			       ioasid_t pasid, enum cache_tag_type type)
> 
> cache_tage_match()

Okay.

> 
>> +{
>> +	if (tag->type != type)
>> +		return false;
>> +
>> +	if (tag->domain_id != domain_id || tag->pasid != pasid)
>> +		return false;
>> +
>> +	if (type == CACHE_TAG_TYPE_IOTLB)
>> +		return tag->iommu == iommu;
>> +
>> +	if (type == CACHE_TAG_TYPE_DEVTLB)
>> +		return tag->dev == dev;
>> +
>> +	return false;
> 
> why do you disallow PARENT_TYPE from reusing? It's not uncommon
> to have two devices attached to a same nested domain hence with
> the same parent domain. Disallowing tag reuse implies unnecessarily
> duplicated cache flushes...

PARENT_TYPE could be reused. The new helper looks like the following:

/* Checks if an existing cache tag can be reused for a new association. */
static bool cache_tage_match(struct cache_tag *tag, u16 domain_id,
                                struct intel_iommu *iommu, struct device 
*dev,
                                ioasid_t pasid, enum cache_tag_type type)
{
         if (tag->type != type)
                 return false;

         if (tag->domain_id != domain_id || tag->pasid != pasid)
                 return false;

         if (type == CACHE_TAG_IOTLB || type == CACHE_TAG_PARENT_IOTLB)
                 return tag->iommu == iommu;

         if (type == CACHE_TAG_DEVTLB || type == CACHE_TAG_PARENT_DEVTLB)
                 return tag->dev == dev;

         return false;
}

>> +}
>> +
>> +/* Assign a cache tag with specified type to domain. */
>> +static int cache_tag_assign(struct dmar_domain *domain, u16 did,
>> +			    struct device *dev, ioasid_t pasid,
>> +			    enum cache_tag_type type)
>> +{
>> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
>> +	struct intel_iommu *iommu = info->iommu;
>> +	struct cache_tag *tag, *temp;
>> +	unsigned long flags;
>> +
>> +	tag = kzalloc(sizeof(*tag), GFP_KERNEL);
>> +	if (!tag)
>> +		return -ENOMEM;
>> +
>> +	tag->type = type;
>> +	tag->iommu = iommu;
>> +	tag->dev = dev;
> 
> should we set tag->dev only for DEVTLB type? It's a bit confusing to set
> it for IOTLB type which doesn't care about device. Actually doing so
> is instead misleading as the 1st device creating the tag may have been
> detached but then it will still show up in the trace when the last device
> detach destroying the tag.

For IOTLB types, perhaps we could add a struct device pointer for the
iommu. This way, the tag->dev could more directly indicate the device
implementing the cache.

> 
>> +static int __cache_tag_assign_parent_domain(struct dmar_domain
>> *domain, u16 did,
>> +					    struct device *dev, ioasid_t pasid)
> 
> this pair is similar to the earlier one except the difference on type.
> 
> what about keeping just one pair which accepts a 'parent' argument to
> decide the type internally?

Okay, let try to refine it.

> 
> 
>> +/*
>> + * Assigns cache tags to a domain when it's associated with a device's
>> + * PASID using a specific domain ID.
> 
> s/Assigns/Assign/

Done.

> 
>> +
>> +	did = domain_id_iommu(domain, iommu);
>> +	ret = cache_tag_assign_domain(domain, did, dev,
>> IOMMU_NO_PASID);
> 
> there are many occurrences of this pattern. What about passing in
> a 'iommu' parameter and getting 'did' inside the helper? for svm
> it can be specialized internally too.

Perhaps, let me try it later and see what the code looks like.

> 
>> @@ -4607,10 +4623,11 @@ static void
>> intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>>   	 */
>>   	if (domain->type == IOMMU_DOMAIN_SVA) {
>>   		intel_svm_remove_dev_pasid(dev, pasid);
>> +		cache_tag_unassign_domain(dmar_domain,
>> +					  FLPT_DEFAULT_DID, dev, pasid);
> 
> is it correct to destroy the tag before teardown completes, e.g. iotlb still
> needs to be flushed in intel_pasid_tear_down_entry()?

You are right. iotlb still needs to be there until the teardown
completes. I will investigate this more later.

Beset regards,
baolu

