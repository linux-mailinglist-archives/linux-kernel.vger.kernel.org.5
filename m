Return-Path: <linux-kernel+bounces-134201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E368989AEEA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2A421F223DE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 06:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8691747F;
	Sun,  7 Apr 2024 06:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ejz+f8TA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB347460
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 06:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712472144; cv=none; b=kOgsV8FatPrATE8r27h8op/Uas/1UKYJQ7J9F52iEvIjlHmdgYm+irxWejiLimQxGoJudFsJjwbj4e8enJ1C2Xgjwm93Y0KuVMOppcRKyuQVX+n6D1Iw47DDTjP8Auycx4BxBjRmgni/A6Ipwiz5g6x00E+sHZMYjGOoLoFMcBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712472144; c=relaxed/simple;
	bh=KdK5I71E3njctY0Z+Vx14Q5I2n0CIhVqzT7SMjXlfpg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U0AUOzUIKD67bP/EZgiws7BTJydpqZx9ofvMSjoxWxDUYKHf6oZU4vecIZFZXet3I+EcQY6foUnFLiSfE4dDme+4Leiqdvfh/OqidtNJCcyV7v7jVfPP5Ab7Wn2ywbe5aVdLak0SNmhebvvacMJggtlU7s+EqBfFDPZhN9DNMWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ejz+f8TA; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712472141; x=1744008141;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KdK5I71E3njctY0Z+Vx14Q5I2n0CIhVqzT7SMjXlfpg=;
  b=ejz+f8TArtGNemyjn2FHRuN1sYU0+o67jd/smlJeSYi7IjUmbbiQuvsQ
   19RI+XuT/6P/rCBeBc/vuXzxSl2ubpQhcXItIylwekLxbS6MgNu0sMgDE
   jlsACCRUxpNUYqUzhExBO+5qiyd6r1sT9hUz97vv//gwRREZ9jTY7rY6A
   M+SF+PSuiJuaxTb4RraeeWKIR8iQ0ga3yWf/kKQt6u9cr08GtP0bkTkhG
   ZlCzcwa46VMtvDFbym6OQfN9CY7h2e5FDpT44wbVAG/z96Ou8yl/CBhb5
   ih8dVpfiSunGxG7GthPAxv7O5rGkTwK6ElyaQ3+JtegJc1vDD3yA73pgT
   A==;
X-CSE-ConnectionGUID: GkLdlUzwT5aZ5fQjo0LchQ==
X-CSE-MsgGUID: Mb0CemEXSpOHK2eX0DTWqg==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="18487743"
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="18487743"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2024 23:42:20 -0700
X-CSE-ConnectionGUID: 4GjG8IfkTBarLkzihfKe9g==
X-CSE-MsgGUID: RMwI1UwQR4uGFqX1dLDcYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="24194089"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa004.fm.intel.com with ESMTP; 06 Apr 2024 23:42:18 -0700
Message-ID: <7657779b-bda0-4303-96c5-33949cf6457c@linux.intel.com>
Date: Sun, 7 Apr 2024 14:41:12 +0800
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
Subject: Re: [PATCH 06/12] iommu/vt-d: Use cache_tag_flush_cm_range() in
 iotlb_sync_map
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
 <20240325021705.249769-7-baolu.lu@linux.intel.com>
 <BN9PR11MB52766C4CA9A27F34419AEE258C3B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52766C4CA9A27F34419AEE258C3B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/28/24 3:48 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, March 25, 2024 10:17 AM
>>
>> The iotlb_sync_map callback is called by the iommu core after non-present
>> to present mappings are created. The iommu driver uses this callback to
>> invalidate caches if IOMMU is working in caching mode and second-only
>> translation is used for the domain. Use cache_tag_flush_cm_range() in this
>> callback.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 22 +---------------------
>>   1 file changed, 1 insertion(+), 21 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 1c03d2dafb9d..2dcab1e5cd4d 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -1504,20 +1504,6 @@ static void iommu_flush_iotlb_psi(struct
>> intel_iommu *iommu,
>>   		iommu_flush_dev_iotlb(domain, addr, mask);
>>   }
>>
>> -/* Notification for newly created mappings */
>> -static void __mapping_notify_one(struct intel_iommu *iommu, struct
>> dmar_domain *domain,
>> -				 unsigned long pfn, unsigned int pages)
>> -{
>> -	/*
>> -	 * It's a non-present to present mapping. Only flush if caching mode
>> -	 * and second level.
>> -	 */
>> -	if (cap_caching_mode(iommu->cap) && !domain->use_first_level)
>> -		iommu_flush_iotlb_psi(iommu, domain, pfn, pages, 0, 1);
>> -	else
>> -		iommu_flush_write_buffer(iommu);
>> -}
> 
> iommu_flush_write_buffer is for a quite different issue. it's clearer to
> keep it separated from the iotlb helpers.

The VT-d spec describes the write buffer flushing in section 6.8. It
states,

1. Write buffer flushing is required only for earlier VT-d hardware
    implementations. Newer hardware implementations are expected to NOT
    require this.
2. Write buffer flushing is related to cache invalidation. The hardware
    performs an implicit write-buffer-flushing as a pre-condition to
    the invalidation operations.

According to this, write buffer flushing is only required in the map
path when IOMMU is not in caching mode and the RWBF iommu capability is
set, which perfectly matches the case of cache_tag_flush_cm_range().

By doing it in cache_tag_flush_cm_range(), the code will be simpler and
easier for maintenance.

Best regards,
baolu

