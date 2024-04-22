Return-Path: <linux-kernel+bounces-152744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D488AC3B6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2B7AB2129D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C582418037;
	Mon, 22 Apr 2024 05:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hyp9YZ1L"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731E41759F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 05:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713763906; cv=none; b=LlmrWLvZ6xqaWPHsrFbzLwgkwDstRDMBO1SB2s7U+mD4VakUa2Y/IGtC/dt260hnE9LVyWK5njZ5M/ckyNm9H1nFe3ztOobABhRhe3DnvRSz+0sUOYajLsuPWkV8qIp3Rch9pPcK0KpclVuj1kMROmtEgDUsKfrxRPknQWn8r0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713763906; c=relaxed/simple;
	bh=b35dIzQ8H1LWpzZGyNzi6AKj8qjN/T9a35X9jCsZn5k=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=stbB346kH7yVjrcNyrLuNwLyIXJIvrcMxcsDvgHs865aK7gR1BriIY9cdlTgrrs/JdHM+FivKnIqRgYW7pRRSW23JI4kknAn+0bcLUXii1icFu6F5Vdd3QcXqNWPDRPk9RKoORzwgY3EEDN3hE26WxWX8f8rLtIF/2nBjkXuFp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hyp9YZ1L; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713763904; x=1745299904;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b35dIzQ8H1LWpzZGyNzi6AKj8qjN/T9a35X9jCsZn5k=;
  b=hyp9YZ1LkUwiDF9Nf+qCj6zfkR04+eKfZBK+LnbFe+nk4znT2z71gDIr
   smZcWcCFavUyF8/ZpT3DuAFeeIeXqA4xNzj1RNmWalL7Yf+Ieq9kcJZUb
   Z6giuXb0Q1lmaToMOUkfOdAnc9e6Gz+NMjUWeqpSMUGo+dr7zo0STlnze
   cjKMI2WmFNXySpgPmS3UtlveHjRRARYp/yW2pdfdPqkm4V//mpyDk9uvw
   htFqKa3YdYixlq+G9pBBGXXU6K/R7RyWrl8RcFJaaSOPq9qqIsWBxk14f
   /leYlAflqw0luke8JMaZev3ipucCZgTwMecNI7G0PZlZPpayehq9lRF6N
   g==;
X-CSE-ConnectionGUID: f9INaL+BSNKv+8vC5GuUOQ==
X-CSE-MsgGUID: vSPylyDvRqq8v3HDeHHW3Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="26805136"
X-IronPort-AV: E=Sophos;i="6.07,219,1708416000"; 
   d="scan'208";a="26805136"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2024 22:31:43 -0700
X-CSE-ConnectionGUID: ltzPMmlaTd27KwbEGFQI5w==
X-CSE-MsgGUID: W5E4fW8LSdip7O2XkH9JvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,219,1708416000"; 
   d="scan'208";a="24347302"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa006.jf.intel.com with ESMTP; 21 Apr 2024 22:31:41 -0700
Message-ID: <40c3b216-f3bb-4058-88a1-45de433432f3@linux.intel.com>
Date: Mon, 22 Apr 2024 13:30:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Tina Zhang <tina.zhang@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/12] iommu/vt-d: Add cache tag invalidation helpers
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20240416080656.60968-1-baolu.lu@linux.intel.com>
 <20240416080656.60968-3-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240416080656.60968-3-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/16/24 4:06 PM, Lu Baolu wrote:
> Add several helpers to invalidate the caches after mappings in the
> affected domain are changed.
> 
> - cache_tag_flush_range() invalidates a range of caches after mappings
>    within this range are changed. It uses the page-selective cache
>    invalidation methods.
> 
> - cache_tag_flush_all() invalidates all caches tagged by a domain ID.
>    It uses the domain-selective cache invalidation methods.
> 
> - cache_tag_flush_range_np() invalidates a range of caches when new
>    mappings are created in the domain and the corresponding page table
>    entries change from non-present to present.
> 
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.h |  14 +++
>   drivers/iommu/intel/cache.c | 195 ++++++++++++++++++++++++++++++++++++
>   drivers/iommu/intel/iommu.c |  12 ---
>   3 files changed, 209 insertions(+), 12 deletions(-)

[...]

> +
> +/*
> + * Invalidates a range of IOVA from @start (inclusive) to @end (inclusive)
> + * when the memory mappings in the target domain have been modified.
> + */
> +void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
> +			   unsigned long end, int ih)
> +{
> +	unsigned long pages, mask, addr;
> +	struct cache_tag *tag;
> +	unsigned long flags;
> +
> +	addr = calculate_psi_aligned_address(start, end, &pages, &mask);
> +
> +	spin_lock_irqsave(&domain->cache_lock, flags);
> +	list_for_each_entry(tag, &domain->cache_tags, node) {
> +		struct intel_iommu *iommu = tag->iommu;
> +		struct device_domain_info *info;
> +		u16 sid;
> +
> +		switch (tag->type) {
> +		case CACHE_TAG_IOTLB:
> +		case CACHE_TAG_NESTING_IOTLB:
> +			if (domain->use_first_level) {
> +				qi_flush_piotlb(iommu, tag->domain_id,
> +						tag->pasid, addr, pages, ih);
> +			} else {
> +				/*
> +				 * Fallback to domain selective flush if no
> +				 * PSI support or the size is too big.
> +				 */
> +				if (!cap_pgsel_inv(iommu->cap) ||
> +				    mask > cap_max_amask_val(iommu->cap))
> +					iommu->flush.flush_iotlb(iommu, tag->domain_id,
> +								 0, 0, DMA_TLB_DSI_FLUSH);
> +				else
> +					iommu->flush.flush_iotlb(iommu, tag->domain_id,
> +								 addr | ih, mask,
> +								 DMA_TLB_PSI_FLUSH);
> +			}
> +			break;
> +		case CACHE_TAG_NESTING_DEVTLB:
> +			/*
> +			 * Address translation cache in device side caches the
> +			 * result of nested translation. There is no easy way
> +			 * to identify the exact set of nested translations
> +			 * affected by a change in S2. So just flush the entire
> +			 * device cache.
> +			 */
> +			addr = 0;
> +			mask = MAX_AGAW_PFN_WIDTH;
> +			fallthrough;

I realized that the logic above is not right. Setting both @addr and
@mask to 0 doesn't means flush all caches on the device. I will change
it like below:

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index e8418cdd8331..18debb82272a 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -302,9 +302,14 @@ void cache_tag_flush_range(struct dmar_domain 
*domain, unsigned long start,
                          * affected by a change in S2. So just flush 
the entire
                          * device cache.
                          */
-                       addr = 0;
-                       mask = MAX_AGAW_PFN_WIDTH;
-                       fallthrough;
+                       info = dev_iommu_priv_get(tag->dev);
+                       sid = PCI_DEVID(info->bus, info->devfn);
+
+                       qi_flush_dev_iotlb(iommu, sid, info->pfsid, 
info->ats_qdep,
+                                          0, MAX_AGAW_PFN_WIDTH);
+                       quirk_extra_dev_tlb_flush(info, 0, 
MAX_AGAW_PFN_WIDTH,
+                                                 IOMMU_NO_PASID, 
info->ats_qdep);
+                       break;
                 case CACHE_TAG_DEVTLB:
                         info = dev_iommu_priv_get(tag->dev);
                         sid = PCI_DEVID(info->bus, info->devfn);

> +		case CACHE_TAG_DEVTLB:
> +			info = dev_iommu_priv_get(tag->dev);
> +			sid = PCI_DEVID(info->bus, info->devfn);
> +
> +			if (tag->pasid == IOMMU_NO_PASID)
> +				qi_flush_dev_iotlb(iommu, sid, info->pfsid,
> +						   info->ats_qdep, addr, mask);
> +			else
> +				qi_flush_dev_iotlb_pasid(iommu, sid, info->pfsid,
> +							 tag->pasid, info->ats_qdep,
> +							 addr, mask);
> +
> +			quirk_extra_dev_tlb_flush(info, addr, mask, tag->pasid, info->ats_qdep);
> +			break;
> +		}
> +	}
> +	spin_unlock_irqrestore(&domain->cache_lock, flags);

Best regards,
baolu

