Return-Path: <linux-kernel+bounces-87989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D0B86DBD7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4E61F2672A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6544E69316;
	Fri,  1 Mar 2024 07:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="brkwjGfq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3BD69944
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 07:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709276721; cv=none; b=o89HM7oYk0/v6GOai5OyNeM+ceISnVYMi6+6UYVyesA/18Fgy0of3fL/5hAHLlJimP4ftzl7MV6jbTTROkY9gjgJhHpYh3eQxCtBvTb3ct3mXJPYMAy5tdx9vMtQKiXM4HLRNZngIiaIGXLU45QVZQ+GPagPyp+laUqUDiC79/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709276721; c=relaxed/simple;
	bh=qqJZRKu3127B3POCknwtTqzC0Dy+O9Rd38Eo05Wt27Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZXoEHBwrE7UDKQcFFmKzz6iGGAUyLSUsscGBm+BhJyOtV28maDEkYcqUBg8x8W83qwXqlKILuqrHTrYrkIRtMNK3gRaJKqqNPIx0DhK6/p/eLNERgA9p2sXTjSHByXKxLzwOpe5/7d1CJOWEcnf9/jwQ3klNlFYg2QYX0KTrQ8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=brkwjGfq; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709276719; x=1740812719;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qqJZRKu3127B3POCknwtTqzC0Dy+O9Rd38Eo05Wt27Q=;
  b=brkwjGfqWhSg/T/YKyLDCmaY7FHI8Os4MzlOJGT38WJfqxOizCtOYk2g
   N9AUsvsnDySlUhYRBrNlDAJij7F0qJppHQSWcOOga8qUZfOKBLMYLaJlD
   Obo1GHJRP6Xuejx4GvKFjrTRr6un6tAvGQ3HVQu6qahIqZkzLenEnzShb
   Y84kdoBY9IM5JlWZRmPMvHZbIeAsSnoai2tcW1a3geB3kErtVMbzXjpGM
   m8LnJ0a+oJ47pbLAf+Ic2CSs8NL+KlO7RCSKVBlEuiVlbxFrGqA8TW7d8
   49ZRB/IVh4SVUtm05cqiLLpGSiuiiDDmpH99T1exDIMV8as68U8pYI9jz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="29226584"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="29226584"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 23:05:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="12649246"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.124.229.115]) ([10.124.229.115])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 23:05:15 -0800
Message-ID: <b43dfb1a-41d7-49cf-8f47-02ec6e46dc1c@linux.intel.com>
Date: Fri, 1 Mar 2024 15:05:14 +0800
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

Given maintainer is going to pick up patchset
https://lore.kernel.org/lkml/2d1788da-521c-4531-a159-81d2fb801d6c@linux.intel.com/T/
and this one is mutually exclusive with it, suspend.


Thanks,
Ethan


