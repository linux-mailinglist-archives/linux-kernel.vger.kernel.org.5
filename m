Return-Path: <linux-kernel+bounces-4791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE9A81821C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 108E41F258A6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C448C15;
	Tue, 19 Dec 2023 07:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mimf+mH9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E26213AD8;
	Tue, 19 Dec 2023 07:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702970216; x=1734506216;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e1H4euSynEtAK+MQ7n5ddNUb1SBbebH7TmVLRdIdcdM=;
  b=mimf+mH91DwNBYn62ufbbu9mhs68d6jNXm2VBpVh7TOT8h0FgWHJfaXR
   M3NfyVWZMogPj/ZRsk3rHMnDpvIf3khbJoJzYY6TWbXqjcQO38fSjhiwC
   maexaGUvhkSDv8mJtd6T+AjdGX5nymBcrNTjzpWIwXPnGJSixFSRnl+jn
   0KUdR+rSyLiMnRj6k7UPf78EDDuL5l3sb//JRMHN3H0ullV2q83ApQDJ1
   CG0a5QAfttF5ik111QLHl9AjzkT7PpH+AnEwc1RxoFQkaSoc8w1z/+/Ul
   ORswsaVIRboZIL3qZx1JDGDit9tLuCdihgbjOdbJTlYwEjSL+OA1+nEC/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="426751052"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="426751052"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 23:16:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="17500248"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.93.26.36]) ([10.93.26.36])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 23:16:53 -0800
Message-ID: <2fa95471-e22e-46b7-8f23-f4e6abbbd69b@linux.intel.com>
Date: Tue, 19 Dec 2023 15:16:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] iommu/vt-d: don's issue devTLB flush request when
 device is disconnected
To: Baolu Lu <baolu.lu@linux.intel.com>, bhelgaas@google.com,
 dwmw2@infradead.org, will@kernel.org, robin.murphy@arm.com, lukas@wunner.de
Cc: linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20231217114902.3836260-1-haifeng.zhao@linux.intel.com>
 <20231217114902.3836260-3-haifeng.zhao@linux.intel.com>
 <ac0fd341-7def-485e-9f32-530cf8a83273@linux.intel.com>
 <a275032f-cb1d-4ccc-9418-9567aba6b343@linux.intel.com>
 <f7dfdec4-ec52-44b0-9e04-bdcc3af2ba25@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <f7dfdec4-ec52-44b0-9e04-bdcc3af2ba25@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/19/2023 2:57 PM, Baolu Lu wrote:
> On 2023/12/19 14:49, Ethan Zhao wrote:
>>>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>>>> index 74e8e4c17e81..182eb5df244d 100644
>>>> --- a/drivers/iommu/intel/pasid.c
>>>> +++ b/drivers/iommu/intel/pasid.c
>>>> @@ -476,6 +476,23 @@ devtlb_invalidation_with_pasid(struct 
>>>> intel_iommu *iommu,
>>>>   {
>>>>       struct device_domain_info *info;
>>>>       u16 sid, qdep, pfsid;
>>>> +    struct pci_dev *pdev;
>>>> +
>>>> +    pdev = to_pci_dev(dev);
>>>> +    if (!pdev)
>>>> +        return;
>>>> +
>>>> +    /*
>>>> +     * If endpoint device's link was brough down by user's pci 
>>>> configuration
>>>> +     * access to it's hotplug capable slot link control register, 
>>>> as sequence
>>>> +     * response for DLLSC, pciehp_ist() will set the device 
>>>> error_state to
>>>> +     * pci_channel_io_perm_failure. Checking device's state here 
>>>> to avoid
>>>> +     * issuing meaningless devTLB flush request to it, that might 
>>>> cause lockup
>>>> +     * warning or deadlock because too long time waiting in 
>>>> interrupt context.
>>>> +     */
>>>> +
>>>> +    if (pci_dev_is_disconnected(pdev))
>>>> +        return;
>>>>         info = dev_iommu_priv_get(dev);
>>>>       if (!info || !info->ats_enabled)
>>>
>>> It's likely better to check the device status after verifying
>>> ats_enabled. How about below change?
>>>
>>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>>> index 74e8e4c17e81..fa19c6cdfd8b 100644
>>> --- a/drivers/iommu/intel/pasid.c
>>> +++ b/drivers/iommu/intel/pasid.c
>>> @@ -481,6 +481,9 @@ devtlb_invalidation_with_pasid(struct 
>>> intel_iommu *iommu,
>>>         if (!info || !info->ats_enabled)
>>>                 return;
>>>
>>> +       if (pci_dev_is_disconnected(to_pci_dev(dev)))
>>
>> I like this kind of simplicity, but rationalist always brings me back 
>> to the no-error(ugly)
>>
>> style.  🙂
>
> The rational is that Intel IOMMU driver only supports PCI ATS. So if
> device is marked as ATS supported, then it must be a PCI device.
> Therefore, it's safe to convert it to pci_device with to_pci_dev().

Fair engough !


Thanks,

Ethan

>
> If you move this up before ATS checking, then you need to check
> dev_is_pci().
>
> Best regards,
> baolu
>

