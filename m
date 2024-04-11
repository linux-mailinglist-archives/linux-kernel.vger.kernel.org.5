Return-Path: <linux-kernel+bounces-140487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC2E8A1557
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC271C2172A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD1114C5B8;
	Thu, 11 Apr 2024 13:13:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD5022096
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712841220; cv=none; b=NuYbEWZ3A6jfVhsIDZoLtbUWduETsjIKaGGBG8+Bxum/v6a08+BxGoxGyQJ+Cci87AV0rcGn2IJfNqz3CqpjUAs7z9iBObMHT9M/v1mojjZNjV6oJnlgIYQLX4LbVaXT1DGFed3v1+ShuWpa10upCGBQyW+kBsX+ryGX0LzVEx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712841220; c=relaxed/simple;
	bh=dOD0KsrLEjg9iH8ZN3UDQmx72Brw6XPTxx41Vx6TG8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KsztnhRHyBt07fD+qaWAR3A5Dl5tkPfmO+mMNrAjoHUZaPW+4NpdjK1VxST8sGJCTSW/GXDdebcaYbbNKL3dbf53PXJ0D5mtAupOl58xNpOzefZiUZ2ANcwfwsNbBWo3IMuW7kzPDCu+8DICxLJS4/tSuaHehC3XbvLXBHQiirk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48C2011FB;
	Thu, 11 Apr 2024 06:14:06 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C350E3F64C;
	Thu, 11 Apr 2024 06:13:35 -0700 (PDT)
Message-ID: <51055d13-4a72-4000-9a22-b403d8c5b2ff@arm.com>
Date: Thu, 11 Apr 2024 14:13:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Remove caching mode check before
 device TLB flush
To: Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev
Cc: Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
References: <20240410055823.264501-1-baolu.lu@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240410055823.264501-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/04/2024 6:58 am, Lu Baolu wrote:
> The Caching Mode (CM) of the Intel IOMMU indicates if the hardware
> implementation caches not-present or erroneous translation-structure
> entries except the first-stage translation. The caching mode is
> irrelevant to the device TLB , therefore there is no need to check
> it before a device TLB invalidation operation.
> 
> iommu_flush_iotlb_psi() is called in map and unmap paths. The caching
> mode check before device TLB invalidation will cause device TLB
> invalidation always issued if IOMMU is not running in caching mode.
> This is wrong and causes unnecessary performance overhead.
> 
> The removal of caching mode check in intel_flush_iotlb_all() doesn't
> impact anything no matter the IOMMU is working in caching mode or not.
> Commit <29b32839725f> ("iommu/vt-d: Do not use flush-queue when
> caching-mode is on") has already disabled flush-queue for caching mode,
> hence caching mode will never call intel_flush_iotlb_all().

Well, technically it might still, at domain creation via 
iommu_create_device_direct_mappings(), but domain->has_iotlb_device 
should definitely be false at that point :)

Cheers,
Robin.

> Fixes: bf92df30df90 ("intel-iommu: Only avoid flushing device IOTLB for domain ID 0 in caching mode")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 
> Change log:
> 
> v2:
>   - Squash two patches into a single one.
>   - No functionality changes.
> 
> v1: https://lore.kernel.org/linux-iommu/20240407144232.190355-1-baolu.lu@linux.intel.com/
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 50eb9aed47cc..681789b1258d 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1501,11 +1501,7 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
>   	else
>   		__iommu_flush_iotlb_psi(iommu, did, pfn, pages, ih);
>   
> -	/*
> -	 * In caching mode, changes of pages from non-present to present require
> -	 * flush. However, device IOTLB doesn't need to be flushed in this case.
> -	 */
> -	if (!cap_caching_mode(iommu->cap) || !map)
> +	if (!map)
>   		iommu_flush_dev_iotlb(domain, addr, mask);
>   }
>   
> @@ -1579,8 +1575,7 @@ static void intel_flush_iotlb_all(struct iommu_domain *domain)
>   			iommu->flush.flush_iotlb(iommu, did, 0, 0,
>   						 DMA_TLB_DSI_FLUSH);
>   
> -		if (!cap_caching_mode(iommu->cap))
> -			iommu_flush_dev_iotlb(dmar_domain, 0, MAX_AGAW_PFN_WIDTH);
> +		iommu_flush_dev_iotlb(dmar_domain, 0, MAX_AGAW_PFN_WIDTH);
>   	}
>   
>   	if (dmar_domain->nested_parent)

