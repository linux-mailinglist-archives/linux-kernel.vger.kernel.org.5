Return-Path: <linux-kernel+bounces-86113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCC686BFC3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 05:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7409AB24042
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476AC37705;
	Thu, 29 Feb 2024 04:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W8T7iXww"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD41376E4
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 04:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709179745; cv=none; b=nvmuYLor3AvXcF+QNRi2kHJhmr679tKLh9SQPsLDg9KtzVXTJvQjz6uUJ+HAvAdfSzZWFzcJR5l9LkjoNt/IPV2x6IHRxITqL6rOQOqevlhAQQsKVfUPd/RHRfoR1d+qahm/qyhP8KyVvmrXG3Hd5rMSsFo36yVrpK2uXT9qfHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709179745; c=relaxed/simple;
	bh=boKa93IVjNEOFQLBBYcUwqu3popS6xnt4z3tH9DYuak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXUforXERt5k0YxRyyddIUqx1zbk3EhHwxkbzWA28mTrKaMmeEfKElZErFw/JSfD/niaOSP5/7Qg4KK9syUOKQmIzlPIKX8UqBHtcnyRit4fcSOFDESqEFP2NnW69tHez1qOfDYFmAm3gvIAo9WBtjsHVTzSEzLoLOAwk3tzmQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W8T7iXww; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709179744; x=1740715744;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=boKa93IVjNEOFQLBBYcUwqu3popS6xnt4z3tH9DYuak=;
  b=W8T7iXwwjamExRwGI+fRJ5ymi4PXnwiuKFlQDM0jSo7dp+TV5i2XQ41s
   IGUJI+x/Bo7EiYIuls+FgemJEAQ0tyATRzjBw7+bmHru8aQUuUpoGKyfm
   G1aK9/XibfsPly/lHwF4Gg6ZJ9128lL/DZ2uL5GAfOG1OURwQM8XCBm8v
   TSq+vF6CyBMxqj3Yqn0Pu+cM2rYNldamrwtBJYkGV6NHiz5EzhQiAi+M5
   mfC0XTUTXtHb09KpbM/x5547GADdyCYh02whskXMGb5xylIBVQ8AO+qQU
   SU7tV1Fptj+/GQBYass4sgMkmdWsdvbOBCDkmvjYGbykN9c8uQWQO7uID
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14336888"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="14336888"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 20:09:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="12376381"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.124.229.115]) ([10.124.229.115])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 20:09:00 -0800
Message-ID: <32475465-caef-4202-80f4-410a173e400e@linux.intel.com>
Date: Thu, 29 Feb 2024 12:08:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: improve ITE fault handling if device was
 released
To: baolu.lu@linux.intel.com, bhelgaas@google.com, robin.murphy@arm.com,
 jgg@ziepe.ca
Cc: kevin.tian@intel.com, dwmw2@infradead.org, will@kernel.org,
 lukas@wunner.de, yi.l.liu@intel.com, dan.carpenter@linaro.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240229040724.3393042-1-haifeng.zhao@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20240229040724.3393042-1-haifeng.zhao@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/29/2024 12:07 PM, Ethan Zhao wrote:
> Break the loop to blindly retry the timeout ATS invalidation request
> after ITE fault hit if device was released or isn't present anymore.
>
> This is part of the followup of prior proposed patchset
>
> https://do-db2.lkml.org/lkml/2024/2/22/350
>
> Fixes: 6ba6c3a4cacf ("VT-d: add device IOTLB invalidation support")
> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
> ---
>   drivers/iommu/intel/dmar.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index d14797aabb7a..d01d68205557 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1273,6 +1273,9 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
>   {
>   	u32 fault;
>   	int head, tail;
> +	u64 iqe_err, ite_sid;
> +	struct device *dev = NULL;
> +	struct pci_dev *pdev = NULL;
>   	struct q_inval *qi = iommu->qi;
>   	int shift = qi_shift(iommu);
>   
> @@ -1317,6 +1320,13 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
>   		tail = readl(iommu->reg + DMAR_IQT_REG);
>   		tail = ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
>   
> +		/*
> +		 * SID field is valid only when the ITE field is Set in FSTS_REG
> +		 * see Intel VT-d spec r4.1, section 11.4.9.9
> +		 */
> +		iqe_err = dmar_readq(iommu->reg + DMAR_IQER_REG);
> +		ite_sid = DMAR_IQER_REG_ITESID(iqe_err);
> +
>   		writel(DMA_FSTS_ITE, iommu->reg + DMAR_FSTS_REG);
>   		pr_info("Invalidation Time-out Error (ITE) cleared\n");
>   
> @@ -1326,6 +1336,21 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
>   			head = (head - 2 + QI_LENGTH) % QI_LENGTH;
>   		} while (head != tail);
>   
> +		/*
> +		 * If got ITE, we need to check if the sid of ITE is one of the
> +		 * current valid ATS invalidation target devices, if no, or the
> +		 * target device isn't presnet, don't try this request anymore.
> +		 * 0 value of ite_sid means old VT-d device, no ite_sid value.
> +		 */
> +		if (ite_sid) {
> +			dev = device_rbtree_find(iommu, ite_sid);
> +			if (!dev || !dev_is_pci(dev))
> +				return -ETIMEDOUT;
> +			pdev = to_pci_dev(dev);
> +			if (!pci_device_is_present(pdev) &&
> +				ite_sid == pci_dev_id(pci_physfn(pdev)))
> +				return -ETIMEDOUT;
> +		}
>   		if (qi->desc_status[wait_index] == QI_ABORT)
>   			return -EAGAIN;
>   	}

This patch based on Baolu's per iommu device rbtree patchset

https://github.com/LuBaolu/intel-iommu/commits/rbtree-for-device-info-v2

Thanks,
Ethan


