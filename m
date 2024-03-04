Return-Path: <linux-kernel+bounces-90333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8A386FDCC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDE651C224E6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E2520B33;
	Mon,  4 Mar 2024 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hd1u5h0Y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223191BC3D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709545149; cv=none; b=SH3CRR4lThlo64LEKa3H7+V4WXIZWimxNpgQO5IzaKfR2cgYJ4TnRGJt/mDCP9pQ4Dn4y9FyVJ7Mbig2l6Pv30QDs2uWQ9qpZoeco6+Iiq2BaMM/uX+We5dQSjSzE79EFrLKSshOuNo7KxLd73mWzqHpkyn1OeRdlMBZVxXYjgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709545149; c=relaxed/simple;
	bh=zw1bKc+mpb3Eq0EH3dsgVKb7A+Jz5grqECA/b0F7Vl0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hBmTs9zgiN7p0oksEiWH1/h2fLRglCSMprQ2YuKO6daN2lp9+GQyMe3ilP2mjpFQHPVJv8Ed5Y0BNqxfBeyw/VBConi4tRxO+bl3nw/1KfH8hpqDJrPlZiL0Ft7REb8pUCDErN87wxvxwa2zi5fCFTp3Wis8A1CWqfj3r3hpbfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hd1u5h0Y; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709545148; x=1741081148;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zw1bKc+mpb3Eq0EH3dsgVKb7A+Jz5grqECA/b0F7Vl0=;
  b=hd1u5h0YIuJ1JRwH4eKRAzeM/TGb56ZZoWr3QNXCOdu1/Hd+FwfDILo8
   ZP4SEj0vlAvXdq6GwTWHU6W3i20DDb3i7w8lbRTmMDMK9v6NAvCIeEFWY
   wOVRvP6K+2C7uVJYa0o1RjsgN59Bb/G9OyLv+ofjeCiBNfP6GxK1NADSJ
   RTsMyE8xfGspzGCrlp/JzY/ZPh0Kjp0CHm2K8H3aUBIH/3jNi4jw4C6NJ
   MywMg5tcaJg0wZBCE5YDRJH//+HOzZjMqvYlSqGqH9VUJaHtjBiadtQEO
   klz245xg5xnauQslwg2q00424RwQikOFTH7OTGXp9NPDVzxTNGOOKv+eF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="21562712"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="21562712"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 01:39:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="13495049"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.211.18]) ([10.254.211.18])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 01:39:05 -0800
Message-ID: <4fadb386-e441-4464-9af1-0d369aed717e@linux.intel.com>
Date: Mon, 4 Mar 2024 17:39:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iommu/vt-d: Fix NULL domain on device release
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, "Badger, Eric" <ebadger@purestorage.com>
References: <20240229094613.121575-1-baolu.lu@linux.intel.com>
 <20240229094613.121575-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52764189F754ABF69D24E2AE8C232@BN9PR11MB5276.namprd11.prod.outlook.com>
 <2cc53838-c88f-43a0-b974-c5acb6f27849@linux.intel.com>
 <BL1PR11MB5271815FE2D13186078BCED58C232@BL1PR11MB5271.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BL1PR11MB5271815FE2D13186078BCED58C232@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/4 16:59, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Monday, March 4, 2024 4:07 PM
>>
>> On 2024/3/4 15:36, Tian, Kevin wrote:
>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Sent: Thursday, February 29, 2024 5:46 PM
>>>>
>>>> +
>>>> +/*
>>>> + * Cache invalidation for changes to a scalable-mode context table
>>>> + * entry.
>>>> + *
>>>> + * Section 6.5.3.3 of the VT-d spec:
>>>> + * - Device-selective context-cache invalidation;
>>>> + * - Domain-selective PASID-cache invalidation to affected domains
>>>> + *   (can be skipped if all PASID entries were not-present);
>>>> + * - Domain-selective IOTLB invalidation to affected domains;
>>>
>>> the spec talks about domain-selective but the code actually does
>>> global invalidation.
>>
>> I should have included the following comments below:
>>
>> /* Given that we have no idea about which domain IDs and PASIDs were
>>    * used in the pasid table, upgrade them to global PASID and IOTLB
>>    * cache invalidation. This doesn't impact the performance significantly
>>    * as the clearing context entry is not a critical path.
>>    */
>>
> 
> but then it affects all other perf-critical paths which rely on the cache
> for other devices...

You are right. Good consideration.

> 
> It's preferable to restrict overhead to this release path only e.g. walking
> the PASID table to identify affected DIDs and PASIDs instead of expanding
> the impact to system wide.

The sm_context_flush_caches() could be used in two different paths:
- Deferred attachment case;
- Normal device release path.

For the formal case, we have to use global cache invalidation; but the
the latter case, it's fine to skip these cache invalidation. The new
helper probably looks like below.

/*
  * Cache invalidation for changes to a scalable-mode context table
  * entry.
  *
  * Section 6.5.3.3 of the VT-d spec:
  * - Device-selective context-cache invalidation;
  * - Domain-selective PASID-cache invalidation to affected domains
  *   (can be skipped if all PASID entries were not-present);
  * - Domain-selective IOTLB invalidation to affected domains;
  * - Global Device-TLB invalidation to affected functions.
  *
  * For kdump cases, old valid entries may be cached due to the in-flight
  * DMA and copied pgtable, but there is no unmapping behaviour for them,
  * thus we need explicit cache flushes for all affected domain IDs and
  * PASIDs used in the copied PASID table. Given that we have no idea about
  * which domain IDs and PASIDs were used in the copied tables, upgrade
  * them to global PASID and IOTLB cache invalidation.
  *
  * For normal case, the iommu has been parked in blocking state. All PASID
  * entries are in non-present now. Skip PASID and IOTLB cache invalidation.
  */
static void sm_context_flush_caches(struct device *dev)
{
         struct device_domain_info *info = dev_iommu_priv_get(dev);
         struct intel_iommu *iommu = info->iommu;

         iommu->flush.flush_context(iommu, 0, PCI_DEVID(info->bus, 
info->devfn),
                                    DMA_CCMD_MASK_NOBIT, 
DMA_CCMD_DEVICE_INVL);
         if (context_copied(iommu, info->bus, info->devfn)) {
                 qi_flush_pasid_cache(iommu, 0, QI_PC_GLOBAL, 0);
                 iommu->flush.flush_iotlb(iommu, 0, 0, 0, 
DMA_TLB_GLOBAL_FLUSH);
         }
         devtlb_invalidation_with_pasid(iommu, dev, IOMMU_NO_PASID);
}

Does it look good for you?

Best regards,
baolu

