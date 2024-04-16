Return-Path: <linux-kernel+bounces-146347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 594858A63C0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14CEB281217
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CBE6BFC2;
	Tue, 16 Apr 2024 06:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hYHN4zgq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6671E49D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 06:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713249047; cv=none; b=kMN0f2p+BDhNk9BBkHXyOxZi2oNQYyYwmzhymzQ0ON58Yne1HRdogp3fogoXdflwNr4weX/ZBbMhGcQvR3GxFou4ub2YjAetOo1bLU5wevmqbWrSXuAydvMUnJyWbk0WdBCSkvatK+bM7Ro8XE9qsZ6Gjp/dVftxg73Xw6V1KOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713249047; c=relaxed/simple;
	bh=R8Kkn/zbvxeFSDE1FVJAO/vEL694RCGZhuBpvql9wIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WIp25Kn5odGip1qy99UQMzhL1dsbVwnZOv+ziwNxthN05/EAMSs7x9gFksqoPniGDu4xJY1ctmWOeWxFXCsAbpYUWUC3VCl6fsFhzNjmCTFZUHdCi7SJdsoTymYgCsNSAwEe4OAQuL1NaL8Z+N1+FWxvQTLgB6Nq24qz/XsSHLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hYHN4zgq; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713249045; x=1744785045;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R8Kkn/zbvxeFSDE1FVJAO/vEL694RCGZhuBpvql9wIQ=;
  b=hYHN4zgqOiYe6QUpNT0c/Vkq/0dHGOzvBcaeNePbOhlB4P9cpx1VjUWH
   UOxGH5ElylBXFymbcG7pM7yWUfPJZ7qO1iHIujf4gsuxmafdiYBbTgl0B
   Y23jfoynaAYXw9UIwdrbPv3y9BK6ZsU764GSKOO4pJGIsN21PBb+8WHRW
   vus0kcs2CfpX0O/dKUxQgnDvSbNvOTu9opmr/seyr+/ZwileqyyETnG3+
   WuqK7dws1f90obHUYxodChwSfcrxWh5KYkcBevHmXPla4cSN4UV8667Gs
   thhfAo5ZviX0RCotDqugLZvAkhfNeEH/CH6zrMdF5JHRtySVsCT49BEJL
   g==;
X-CSE-ConnectionGUID: QlmneQT7RsOj1TLwKmgYuQ==
X-CSE-MsgGUID: zhPtB8rcT7OGvqBhXIaEkw==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="26123258"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="26123258"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 23:30:45 -0700
X-CSE-ConnectionGUID: V0zIrX3ySfyAUyEdzoqDqw==
X-CSE-MsgGUID: 9aVQrBdTRe6tuO+5eZnh9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="59606714"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.255.31.180]) ([10.255.31.180])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 23:30:41 -0700
Message-ID: <916dbee7-5ab1-4def-91fe-546e6ab974de@linux.intel.com>
Date: Tue, 16 Apr 2024 14:30:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] iommu/vt-d: Remove caching mode check before
 device TLB flush
To: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev
Cc: Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org
References: <20240415013835.9527-1-baolu.lu@linux.intel.com>
 <9ba0b6a2-e6c1-46de-8d30-929567952c54@linux.intel.com>
 <da521760-c2d7-432e-8ace-8793d520ab09@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <da521760-c2d7-432e-8ace-8793d520ab09@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/16/2024 10:57 AM, Baolu Lu wrote:
> On 4/16/24 8:53 AM, Ethan Zhao wrote:
>> On 4/15/2024 9:38 AM, Lu Baolu wrote:
>>> The Caching Mode (CM) of the Intel IOMMU indicates if the hardware
>>> implementation caches not-present or erroneous translation-structure
>>> entries except for the first-stage translation. The caching mode is
>>> irrelevant to the device TLB, therefore there is no need to check it
>>> before a device TLB invalidation operation.
>>>
>>> Remove two caching mode checks before device TLB invalidation in the
>>> driver. The removal of these checks doesn't change the driver's 
>>> behavior
>>> in critical map/unmap paths. Hence, there is no functionality or
>>> performance impact, especially since commit <29b32839725f> 
>>> ("iommu/vt-d:
>>> Do not use flush-queue when caching-mode is on") has already disabled
>>> flush-queue for caching mode. Therefore, caching mode will never call
>>> intel_flush_iotlb_all().
>>>
>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>>> ---
>>>   drivers/iommu/intel/iommu.c | 9 ++-------
>>>   1 file changed, 2 insertions(+), 7 deletions(-)
>>>
>>> Change log:
>>> v3:
>>>   - It turned out that the removals don't change the driver's behavior,
>>>     hence change it from a fix patch to a cleanup one.
>>>   - No functionality changes.
>>> v2: 
>>> https://lore.kernel.org/lkml/20240410055823.264501-1-baolu.lu@linux.intel.com/
>>>   - Squash two patches into a single one.
>>>   - No functionality changes.
>>> v1: 
>>> https://lore.kernel.org/linux-iommu/20240407144232.190355-1-baolu.lu@linux.intel.com/
>>>
>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>> index a7ecd90303dc..f0a67e9d9faf 100644
>>> --- a/drivers/iommu/intel/iommu.c
>>> +++ b/drivers/iommu/intel/iommu.c
>>> @@ -1501,11 +1501,7 @@ static void iommu_flush_iotlb_psi(struct 
>>> intel_iommu *iommu,
>>>       else
>>>           __iommu_flush_iotlb_psi(iommu, did, pfn, pages, ih);
>>> -    /*
>>> -     * In caching mode, changes of pages from non-present to 
>>> present require
>>> -     * flush. However, device IOTLB doesn't need to be flushed in 
>>> this case.
>>> -     */
>>> -    if (!cap_caching_mode(iommu->cap) || !map)
>>> +    if (!map)
>>>           iommu_flush_dev_iotlb(domain, addr, mask);
>>>   }
>>
>> Given devTLB flushing is irrelavent to CM, put iommu_flush_dev_iotlb()
>> in iommu_flush_iotlb_psi() and called with CM checking context is not
>> reasonable. the logic is buggy.
>>
>> static void __mapping_notify_one(struct intel_iommu *iommu, struct 
>> dmar_domain *domain,
>>                   unsigned long pfn, unsigned int pages)
>> {
>>      /*
>>       * It's a non-present to present mapping. Only flush if caching 
>> mode
>>       * and second level.
>>       */
>>      if (cap_caching_mode(iommu->cap) && !domain->use_first_level)
>>          iommu_flush_iotlb_psi(iommu, domain, pfn, pages, 0, 1);
>>      else
>>          iommu_flush_write_buffer(iommu);
>>
>>
>> then how about fold all CM checking logic in iommu_flush_iotlb_psi()
>> or speperate iommu_flush_dev_iotlb() from iommu_flush_iotlb_psi() ?
>
> I am refactoring the code with a new series.
>
> https://lore.kernel.org/linux-iommu/20240410020844.253535-1-baolu.lu@linux.intel.com/ 
>

Great, thx.

>
> Best regards,
> baolu

