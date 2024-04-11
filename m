Return-Path: <linux-kernel+bounces-140421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A268A1431
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB775282A4B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245F114BF8D;
	Thu, 11 Apr 2024 12:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c+fd63HJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1E51442FF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712837749; cv=none; b=QcUgUI+2GPT6FW3WjEvlTDl5i7QGLlvZRkuEQDTxTg8fYmNr1BziMk1r5GSBLlOrW3g6cmRSGmd7F0d2owbzT4FAdawOmiUcXHCCOmrZ7WINIRnwq3WIHJcghS0s+Kgxii2yi1Yj7vxztaLQRWb0ouHfbRkgaMoqCCmRz7EmfEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712837749; c=relaxed/simple;
	bh=+H0oBngUo6CGYj23lJLfq2hMyMfpU92PpN6nrFaPJvs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LWgm62pxl/WKfENOZlVv2Q0NlncPWwIGuHEkPnliYfhsnDoj/WqAoS73ZCf7+Q/4ixi+J7n1sHPAFIekdJLtUCA7KcjEW2syPMW98245AiWgDu9gUM+Wp8wSYafSRX+lsG4FxXXgJD1LZrO+VPywWsWGD2yOD1kXBFpKDBRcfAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c+fd63HJ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712837748; x=1744373748;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+H0oBngUo6CGYj23lJLfq2hMyMfpU92PpN6nrFaPJvs=;
  b=c+fd63HJYY/Ie5GhP2nYmeaw2W4IJCo9qxw/ziXqFX9GqywEr5SDDSAh
   BgFnOSob7OeQmL0zcer0p2Fib+pYeqZBUMeOC/VjjssGHbLqVwjJsqQ7D
   y01JKtvTnj1ZOs8PeYIZg48fGKzcaCGXg2nOYj/RMA3FUaUbgjjgzR/bj
   APLIGfwyyyN3vNaUGmg4awrsAAyLogLvbBCQNd+9hR8WEnsBlHaevPozc
   js3um9G9V+2i1oEgGlZco3VCGKTb7okI2qtAAbFiPrOblpOrsfJBvtXJ7
   VUu5IINVcz6BOXJm/o22yzlR7TJ1CJapyNimP4HsylctjLb0ZmnU48GU5
   Q==;
X-CSE-ConnectionGUID: E0QEveRtQMmxmA+ix3CgSw==
X-CSE-MsgGUID: UiQyRs7EQxGEYFKgDaoHdQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19664064"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="19664064"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 05:15:47 -0700
X-CSE-ConnectionGUID: +fgJ9b4KRvepFXsl13DhnA==
X-CSE-MsgGUID: HEng4AKNTwWV3zoESGTQ4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="25660255"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.237.86]) ([10.124.237.86])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 05:15:45 -0700
Message-ID: <876a6016-66ec-448d-922e-1964bd1f3f54@linux.intel.com>
Date: Thu, 11 Apr 2024 20:15:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "Liu, Yi L" <yi.l.liu@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iommu/vt-d: Remove caching mode check before devtlb
 flush
To: "Zhang, Tina" <tina.zhang@intel.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20240407144232.190355-1-baolu.lu@linux.intel.com>
 <20240407144232.190355-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52764F42C20B6B18DDE7E66B8C072@BN9PR11MB5276.namprd11.prod.outlook.com>
 <MW5PR11MB5881E15977B2987AE32510B289062@MW5PR11MB5881.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <MW5PR11MB5881E15977B2987AE32510B289062@MW5PR11MB5881.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/11 7:49, Zhang, Tina wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Tian, Kevin <kevin.tian@intel.com>
>> Sent: Tuesday, April 9, 2024 3:30 PM
>> To: Lu Baolu <baolu.lu@linux.intel.com>; iommu@lists.linux.dev
>> Cc: Liu, Yi L <yi.l.liu@intel.com>; Joerg Roedel <joro@8bytes.org>; Will
>> Deacon <will@kernel.org>; Robin Murphy <robin.murphy@arm.com>; linux-
>> kernel@vger.kernel.org
>> Subject: RE: [PATCH 2/2] iommu/vt-d: Remove caching mode check before
>> devtlb flush
>>
>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>> Sent: Sunday, April 7, 2024 10:43 PM
>>>
>>> The Caching Mode (CM) of the Intel IOMMU indicates if the hardware
>>> implementation caches not-present or erroneous translation-structure
>>> entries except the first-stage translation. The caching mode is
>>> unrelated to the device TLB , therefore there is no need to check it
>>> before a device TLB invalidation operation.
>>>
>>> Before the scalable mode is introduced, caching mode is treated as an
>>> indication that the driver is running in a VM guest. This is just a
>>> software contract as shadow page table is the only way to implement a
>>> virtual IOMMU. But the VT-d spec doesn't state this anywhere. After
>>> the scalable mode is introduced, this doesn't stand for anymore, as
>>> caching mode is not relevant for the first-stage translation. A
>>> virtual IOMMU implementation is free to support first-stage
>>> translation only with caching mode cleared.
>>
>> I didn't get the connection to the scalable mode.
>>
>> if required we can still use caching mode to imply running as a guest.
>> Just need to make sure its implementation conforming to the VT-d spec.
>>
>>>
>>> Remove the caching mode check before device TLB invalidation to ensure
>>> compatibility with the scalable mode use cases.
>>>
>>> Fixes: 792fb43ce2c9 ("iommu/vt-d: Enable Intel IOMMU scalable mode by
>>> default")
>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>> ---
>>>   drivers/iommu/intel/iommu.c | 5 ++---
>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>> index 493b6a600394..681789b1258d 100644
>>> --- a/drivers/iommu/intel/iommu.c
>>> +++ b/drivers/iommu/intel/iommu.c
>>> @@ -1501,7 +1501,7 @@ static void iommu_flush_iotlb_psi(struct
>>> intel_iommu *iommu,
>>>   	else
>>>   		__iommu_flush_iotlb_psi(iommu, did, pfn, pages, ih);
>>>
>>> -	if (!cap_caching_mode(iommu->cap) && !map)
>>> +	if (!map)
>>>   		iommu_flush_dev_iotlb(domain, addr, mask);
>>
>> as commented earlier better squash this in patch1.
>>
>>>   }
>>>
>>> @@ -1575,8 +1575,7 @@ static void intel_flush_iotlb_all(struct
>>> iommu_domain *domain)
>>>   			iommu->flush.flush_iotlb(iommu, did, 0, 0,
>>>   						 DMA_TLB_DSI_FLUSH);
>>>
>>> -		if (!cap_caching_mode(iommu->cap))
>>> -			iommu_flush_dev_iotlb(dmar_domain, 0,
>>> MAX_AGAW_PFN_WIDTH);
>>> +		iommu_flush_dev_iotlb(dmar_domain, 0,
>>> MAX_AGAW_PFN_WIDTH);
>>>   	}
>>>
>>
>> I'm hesitating to agree with this change. Strictly speaking it's correct.
>> but w/o supporting batch invalidation this implies performance drop on
>> viommu due to more VM-exits and there may incur user complaints when
>> their VMs upgrade to a newer kernel version.
>>
>> So it'd be better to keep this behavior and fix it together with batch
>> invalidation support. Anyway none of the viommu implementations today
>> (either shadow or nested translation) relies on the correct devtlb behavior
>> from the guest otherwise it's already broken.
> How about we split this change into a patch. I'm working on the batch invalidation patch-set now and I'm happy to include this code change into the batch invalidation series.

No worries. It turned out that these two checks are just unnecessary.
Removing them won't cause any driver behavior change. So, I will make it
a cleanup patch and target it for the next merge window.

Best regards,
baolu

