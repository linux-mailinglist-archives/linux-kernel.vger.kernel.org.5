Return-Path: <linux-kernel+bounces-144530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D012E8A4778
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539991F21851
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 05:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FE24A1A;
	Mon, 15 Apr 2024 05:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hkX+Afsp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF2D1367
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 05:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713157298; cv=none; b=FFRMh4xc9JPzNWUkoPPq4/LVY3T+2gtTGR8O1YhNiIFFhfkozV8gU1ay64dc6CI6HTJwDiX6o9/UpZbYy737XkJ40gVQaHvOLixANVfj2chM9wdxI1oj83qV41yGhILXKTSU307bM2HjYVEqF3NIFPeQHxohEw24+vyuAkfXDEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713157298; c=relaxed/simple;
	bh=Foesuml+1ORyJSj3WNO/ccAGGj85+yXj4BEzJbW4VAQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hy/L99zdYD7MLWEOPTesQ/5ekoL/AXEVPWozUJrEd7N44IPwGQ3HEv+19npPB4m0Q6oO1g13SX17py9up9shpMiXVk0KQ712hGr3wIL7ojAajbzCMim0qYmu0O+rnKjIqyV8zbxVXLZcWLcdLq08sF6wDorhHYpRKeXf9xU7Kl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hkX+Afsp; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713157295; x=1744693295;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Foesuml+1ORyJSj3WNO/ccAGGj85+yXj4BEzJbW4VAQ=;
  b=hkX+Afsp69eEFGrGps+QnXiYAMecMF/LRW9cuU6UpfMBX7xm/u3ASuUg
   BIQf/Y/mK/iaJjnGsfCpMvKviWd3AHt+ee6K3yJC6A2R6mS2DzQlo1tFH
   alrR6JSNvbbKfJ3UHCfrtS36vdFnJQpxZIHS+Er0iSboiS0be8hv5t7kZ
   2ABcZbmgviB3AHUQd91PFV7UGrlqNrC+rQuVM4Y35dv889udyvzq1Usgv
   EQ2wMNelfNQAMCCCHh9YBS4XoMXn4TgknErYn7MEdFGuWrEV1hm6X4+kI
   3xhMT6e50OlJJbeLBS39gzsHfsaZdlcgTegq+Zawl2z5jcyoENN8nk/tj
   g==;
X-CSE-ConnectionGUID: aPAqZYDfRIOG20SIkwy6xg==
X-CSE-MsgGUID: EVF/8WGXTN6w6DMZP9qcdw==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="12374935"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="12374935"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 22:01:34 -0700
X-CSE-ConnectionGUID: 0Nug+8IlRxO0D/tSm3I2pA==
X-CSE-MsgGUID: RVUMpqqXTu2Ljw0X/qGvlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="21783503"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 14 Apr 2024 22:01:33 -0700
Message-ID: <a5c4b57b-c1f8-4f75-95e4-9a462f4673c9@linux.intel.com>
Date: Mon, 15 Apr 2024 13:00:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] iommu/vt-d: Remove caching mode check before
 device TLB flush
To: Yi Liu <yi.l.liu@intel.com>, "Zhang, Tina" <tina.zhang@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20240415013835.9527-1-baolu.lu@linux.intel.com>
 <MW5PR11MB58818970CB8E9A37A6AF563889092@MW5PR11MB5881.namprd11.prod.outlook.com>
 <f3502244-5f37-4f44-94a5-39939ba20eec@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <f3502244-5f37-4f44-94a5-39939ba20eec@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/15/24 10:43 AM, Yi Liu wrote:
> On 2024/4/15 10:22, Zhang, Tina wrote:
>>
>>
>>> -----Original Message-----
>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>> Sent: Monday, April 15, 2024 9:39 AM
>>> To: iommu@lists.linux.dev
>>> Cc: Tian, Kevin <kevin.tian@intel.com>; Liu, Yi L 
>>> <yi.l.liu@intel.com>; Jacob
>>> Pan <jacob.jun.pan@linux.intel.com>; Joerg Roedel <joro@8bytes.org>; 
>>> Will
>>> Deacon <will@kernel.org>; Robin Murphy <robin.murphy@arm.com>; linux-
>>> kernel@vger.kernel.org; Lu Baolu <baolu.lu@linux.intel.com>
>>> Subject: [PATCH v3 1/1] iommu/vt-d: Remove caching mode check before
>>> device TLB flush
>>>
>>> The Caching Mode (CM) of the Intel IOMMU indicates if the hardware
>>> implementation caches not-present or erroneous translation-structure 
>>> entries
>>> except for the first-stage translation. The caching mode is 
>>> irrelevant to the
>>> device TLB, therefore there is no need to check it before a device TLB
>>> invalidation operation.
>>>
>>> Remove two caching mode checks before device TLB invalidation in the 
>>> driver.
>>> The removal of these checks doesn't change the driver's behavior in 
>>> critical
>>> map/unmap paths. Hence, there is no functionality or performance impact,
>>> especially since commit <29b32839725f> ("iommu/vt-d:
>>> Do not use flush-queue when caching-mode is on") has already disabled
>>> flush-queue for caching mode. Therefore, caching mode will never call
>>> intel_flush_iotlb_all().
>> The current logic is if the caching mode is being used and a domain 
>> isn't using first level I/O page table, then flush-queue won't be 
>> used. Otherwise, the flush-queue can be enabled.
>> See https://github.com/torvalds/linux/commit/257ec29074
>>
>> In other words, if the caching mode is being used and a domain is 
>> using first level I/O page table, the flush-queue can be used for this 
>> domain to flush iotlb. Could the code change in this patch bring any 
>> performance impact to this case?
> 
> This seems to have performance deduction in the nested translation case.
> The iommufd nested support bas been merged in 6.8, while the Qemu side
> is wip. So this performance deduction does not happen until Qemu is
> done. Should this also be considered as a performance regression? TBH.

Caching mode is irrelevant to first-stage and nesting translations. If
the QEMU implementation still relies on caching mode for nesting
support, it's already broken.

Best regards,
baolu

