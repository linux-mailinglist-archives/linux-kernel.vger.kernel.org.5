Return-Path: <linux-kernel+bounces-87987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B8086DBD4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C93A3B224C4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015F96931A;
	Fri,  1 Mar 2024 07:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lPJTjZC/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41C169304
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 07:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709276683; cv=none; b=SLfQKAz21FLtqAKk4H5XoLFP+IZXg2ITnRiwMNd1mpxg0hkDUnaZIYfKdaMa3XcyDQaHtL5vlg3/ReWQZnFmiiDmVhCyljHPRv9C5DbJbVm2KvglB49dxboo/znjetjAo1Jv5CSurItlzlD2d79gm2L/VxCPUM7dr1QHApaJC8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709276683; c=relaxed/simple;
	bh=+fpJTr6RmOM7/oEcyjl781MXmUjhyZhONR28zM0E3+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AOyWpLK9hyD/s1jOH5pt4zP+bV2zFV86UN5NB4KuK9gXLo0d/EbENyazIVxnbGVGJd64cmsOpeGGtOxodpy+V2GlAX+4mkc4h19oPpwfj2Tg6YERZPexjLcFWR5yBJYq6k25A6q/E10lGJWQJYM2s6AqXQVE9SH2dtOlTLnjvnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lPJTjZC/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709276681; x=1740812681;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+fpJTr6RmOM7/oEcyjl781MXmUjhyZhONR28zM0E3+0=;
  b=lPJTjZC/so23iah9ws4NmOc2Q7Ww9/+QBVLa3Q19r2BWqDPgXujuB3PI
   jz+gu6axbMmg0JGaIboz0RTyLvGEq+T5ncStlJgxIE85fixmopGwlO7nO
   Vli3QkEg54nC6fzSSZ5bdlwQrB/ktBzr1y83NOoqZfLn+KuiqkrehOfjx
   YEHtJBtWV5Q5FeTP8oF7CjSJV3S4gkIsaHZmNSbHoECPddPpGO79r5I6K
   UDcSEPxqyyfizXzk8HDuvdWOFytkS/ZFVpCfZ0H+AVKPOBC0qYNcrf9X6
   jpa6mmme4EpfvEp5d8OIuwxRPpThrejO7L1wG9PlFSbDmwbSvIGKkN2u6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="29226484"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="29226484"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 23:04:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="12649055"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.124.229.115]) ([10.124.229.115])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 23:04:38 -0800
Message-ID: <69cf00a3-4b37-4e33-8b36-9a8c3e071ecd@linux.intel.com>
Date: Fri, 1 Mar 2024 15:04:35 +0800
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

Given maintainer is going to pick up patchset
https://lore.kernel.org/lkml/2d1788da-521c-4531-a159-81d2fb801d6c@linux.intel.com/T/
and this one is mutually exclusive with it, suspend.


Thanks,
Ethan


