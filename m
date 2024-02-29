Return-Path: <linux-kernel+bounces-86095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F8386BF81
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D226288214
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D32374F9;
	Thu, 29 Feb 2024 03:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y6XJ5goj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59F137169
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 03:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709177667; cv=none; b=YGdOUILEZNMx9B9v2z2KpVl9US+nTOUk0EblS3SonJYn95Q3kfAY/DxIkqu3zY0qfWq07DO2VpPPLknfsQ4l9UaCunk5Lctc+O5jZ0XR4kx2uxvXvmNekhiyB43KH+WaCQM2i1lymGsmZ7PUv+Y7JRadr1/rSx4tPWLJ0NJVSSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709177667; c=relaxed/simple;
	bh=mLXRLhmJnW4cgxgYoXVhgo5B5WkbP+m4BXGC5JOMMmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxnyFF21fl3sbA4W1TBhVpTjROVwIGAawjXy4Xv35mKb8uXjQfo6NaqFS8YK382Z/EZb3iRMY2pBLz8B/QtbRdY+0Ca/to5k1wtG1/Kix8u1MwXVrJ4rkL38LZtn4hL5F6uuwJKpOODQC64VH8agyrGQNvH5w0YqkQaf8sUgYx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y6XJ5goj; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709177665; x=1740713665;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mLXRLhmJnW4cgxgYoXVhgo5B5WkbP+m4BXGC5JOMMmU=;
  b=Y6XJ5gojFLXR1Fzd6MQ9NxGz/snEoEsLLG31FmnHRvKLIBlXWHCK9aqz
   6wNOKIdZ5L4jmfBnC2Olvcin+YZ7N0UBUc29xk68F++lwAmKBStaBZwwk
   iQoghryZeEqRCNhCEF/UMBTBxMSoUrrUeregUDa9pCI51qafCVQ9EqnU7
   528HOLF50HqEcevOK327m3iopqVwP5b+OV2LgxlMc0/GidFMt4bhVlGEN
   yH+CqvsqaFDOZFVYiuzVUpfPCvUSce56fWRblEok46bNzOGPmIpQ2HkJ7
   EWGMZe/rRnVNlxJ3odirSXaprxWv6n6on43HguxqkINS6Ii/tUW1vCgjj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="21082369"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="21082369"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 19:34:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="7591335"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.124.229.115]) ([10.124.229.115])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 19:34:21 -0800
Message-ID: <6661144c-793f-4988-aae1-4616209a3c21@linux.intel.com>
Date: Thu, 29 Feb 2024 11:34:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: avoid sending explicit ATS invalidation
 request to released device
To: baolu.lu@linux.intel.com, bhelgaas@google.com, robin.murphy@arm.com,
 jgg@ziepe.ca
Cc: kevin.tian@intel.com, dwmw2@infradead.org, will@kernel.org,
 lukas@wunner.de, yi.l.liu@intel.com, dan.carpenter@linaro.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240229033138.3379560-1-haifeng.zhao@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20240229033138.3379560-1-haifeng.zhao@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/29/2024 11:31 AM, Ethan Zhao wrote:
> The introduction of per iommu device rbtree also defines the lifetime of
> interoperation between iommu and devices, if the device has been released
> from device rbtree, no need to send ATS invalidation request to it anymore,
> thus avoid the possibility of later ITE fault to be triggered.
>
> This is part of the followup of prior proposed patchset
>
> https://do-db2.lkml.org/lkml/2024/2/22/350
>
> To make sure all the devTLB entries to be invalidated in the device release
> path, do implict invalidation by fapping the E bit of ATS control register.
> see PCIe spec v6.2, sec 10.3.7 implicit invalidation events.
>
> Fixes: 6f7db75e1c46 ("iommu/vt-d: Add second level page table interface")
> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 6 ++++++
>   drivers/iommu/intel/pasid.c | 7 +++++++
>   2 files changed, 13 insertions(+)
>
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 6743fe6c7a36..b85d88ccb4b0 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1368,6 +1368,12 @@ static void iommu_disable_pci_caps(struct device_domain_info *info)
>   	pdev = to_pci_dev(info->dev);
>   
>   	if (info->ats_enabled) {
> +		pci_disable_ats(pdev);
> +		/*
> +		 * flap the E bit of ATS control register to do implicit
> +		 * ATS invlidation, see PCIe spec v6.2, sec 10.3.7
> +		 */
> +		pci_enable_ats(pdev, VTD_PAGE_SHIFT);
>   		pci_disable_ats(pdev);
>   		info->ats_enabled = 0;
>   		domain_update_iotlb(info->domain);
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 108158e2b907..5f13e017a12c 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -215,6 +215,13 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
>   		return;
>   
>   	sid = info->bus << 8 | info->devfn;
> +	/*
> +	 * If device has been released from rbtree, no need to send ATS
> +	 * Invalidation	request anymore, that could cause ITE fault.
> +	 */
> +	if (!device_rbtree_find(iommu, sid))
> +		return;
> +
>   	qdep = info->ats_qdep;
>   	pfsid = info->pfsid;
>   

This patch based on Baolu's per iommu device rbtree patchset
https://github.com/LuBaolu/intel-iommu/commits/rbtree-for-device-info-v2


Thanks,
Ethan


