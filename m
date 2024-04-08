Return-Path: <linux-kernel+bounces-134740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD37D89B63D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 146691C21346
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862E91877;
	Mon,  8 Apr 2024 03:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HDQ3aEi8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ACA37B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 03:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712545606; cv=none; b=SEMntDas1Q4r9us6eggWHSJm7IFaV2KZYgInBW/Bl/tT5LBe2aRgmRjRHR7yF+SmLLVTN5lefS3gD+tkYR6iY7i063MOaPX11dYKxur2A7OeQj8hujr6gugqlBYziklFJfn/L2vGyPukRYlCdOaxupmjRnkvIPcDyVOAbJgFL/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712545606; c=relaxed/simple;
	bh=1tJDDkzMtYiz2boItIh1oGSi/Vi6dSIKRpTvodnN7l8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ayyzLUz19guNasEG9JkZBOOE+bNNL6z5eNbec8tjs5tIxWBopFOXuPtUmn/VmC0fjQVFR9TQ0pmC9BRjivfsUX9K/VoyWjmRVeALcRoQohF/VkDX+Te7jjeUwTyF68QfWCyL7UpN04xiI9mB0ueJjLTBSc4pyPCZNEfnOIT9wrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HDQ3aEi8; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712545605; x=1744081605;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1tJDDkzMtYiz2boItIh1oGSi/Vi6dSIKRpTvodnN7l8=;
  b=HDQ3aEi84QzYpvt0/ayfYFSkhehGBNQ3+W/udIflmxoIAocow5tLeqmU
   5SYy8G1A5WtPn8ufeVZ5TDuvZX2Tb9wrPj75e5uY7voX4GkZ+bwgQzj9I
   1CX4zsqhZqDG7tK3g6ZwYunGVvW7RzIPvZTNwiJEFWlE9l71yPoVI5Dn+
   ky4Hrzki0Vej+pBK9bPTpMK16TzOYDbeD47Cz4aDC/GNrD5SvU/cDPL9R
   EuqaMCbd5LBSJeU1IVyzGatlPvy1bJODDrbP8IXFM2el+nN9Fxg2BjkO/
   Kfpy7Nwtj/BzHQv/8/ulTbQ5MkZNB0G7rNzhNxWpcaRU7SFCOKRWXId1I
   Q==;
X-CSE-ConnectionGUID: 5dvmf7vER9Ky8kxQH9dqrg==
X-CSE-MsgGUID: uxdhMIRqR5eV10fsjSIDSw==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="7642361"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="7642361"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 20:06:45 -0700
X-CSE-ConnectionGUID: Yo8s+z3+Q8ee8PlV8MWr0w==
X-CSE-MsgGUID: 7TuVjiUgQ9yeQyX/0raVdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="19794793"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa009.fm.intel.com with ESMTP; 07 Apr 2024 20:06:42 -0700
Message-ID: <5df9df66-ae2b-42a8-9c71-0623968d3e42@linux.intel.com>
Date: Mon, 8 Apr 2024 11:05:35 +0800
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
Subject: Re: [PATCH 00/12] Consolidate domain cache invalidation
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
 <BN9PR11MB5276088E9D595A903E9255E48C3B2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <2256b869-d0c2-49b4-b6cc-89e59d40386f@linux.intel.com>
 <BN9PR11MB5276B476EC7C098E153ABF168C002@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276B476EC7C098E153ABF168C002@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/24 11:03 AM, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Sunday, April 7, 2024 3:28 PM
>>
>> On 3/28/24 3:59 PM, Tian, Kevin wrote:
>>>> From: Lu Baolu<baolu.lu@linux.intel.com>
>>>> Sent: Monday, March 25, 2024 10:17 AM
>>>>
>>>> The IOMMU hardware cache needs to be invalidated whenever the
>>>> mappings
>>>> in the domain are changed. Currently, domain cache invalidation is
>>>> scattered across different places, causing several issues:
>>>>
>>>> - IOMMU IOTLB Invalidation: This is done by iterating through the domain
>>>>     IDs of each domain using the following code:
>>>>
>>>>           xa_for_each(&dmar_domain->iommu_array, i, info)
>>>>                   iommu_flush_iotlb_psi(info->iommu, dmar_domain,
>>>>                                         start_pfn, nrpages,
>>>>                                         list_empty(&gather->freelist), 0);
>>>>
>>>>     This code could theoretically cause a use-after-free problem because
>>>>     there's no lock to protect the "info" pointer within the loop.
>>>>
>>>> - Inconsistent Invalidation Methods: Different domain types implement
>>>>     their own cache invalidation methods, making the code difficult to
>>>>     maintain. For example, the DMA domain, SVA domain, and nested
>> domain
>>>>     have similar cache invalidation code scattered across different files.
>>>>
>>>> - SVA Domain Inconsistency: The SVA domain implementation uses a
>>>>     completely different data structure to track attached devices compared
>>>>     to other domains. This creates unnecessary differences and, even
>>>>     worse, leads to duplicate IOTLB invalidation when an SVA domain is
>>>>     attached to devices belonging to different IOMMU domains.
>>> can you elaborate how duplicated invalidations are caused?
>>
>> Yes, sure.
>>
>> Current Intel SVA implementation keeps the bond between mm and a PASID
>> of a device in a list of intel_svm_dev. In the mm notifier callback, it
>> iterates all intel_svam_dev in the list and invalidates the IOTLB and
>> device TLB sequentially.
>>
>> If multiple devices belong to a single IOMMU, the IOTLB will be flushed
>> multiple times. However, since these devices share the same domain ID
>> and PASID, a single IOTLB cache invalidation is sufficient. The
>> additional flushes are redundant and negatively impact performance.
>>
> 
> yes it's redundant. But what does "devices belonging to different
> IOMMU domains" in the original context try to convey? From above
> explanation it sounds irrelevant...

My typo. :-) Sorry for the confusion.

I should say,

"... attached to devices belonging to a same IOMMU ..."

Best regards,
baolu

