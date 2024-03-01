Return-Path: <linux-kernel+bounces-87798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDEE86D928
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81019286A0A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB8E36120;
	Fri,  1 Mar 2024 01:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="glCVKYIT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA42A2C85F
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 01:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709257845; cv=none; b=tqHsQKQmNx4Mtalx/de2Up0utxd820w2Yi0pbsxxnm0c1MSQZuUKgzAVyPt7m/EF1LcW+EHMzTgymQvOFSEaIWBx2d/Osj4SwRyTKCsZFLUF7CeDLSJkyG9WhNhD5+N5T991g9XWiWDh6a6/4b13eaKfca6Q4eRKL0KaMz2HOCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709257845; c=relaxed/simple;
	bh=nNsEDn3Vls0jVQChE/FavePc/zLPW+1eOfz7dPTgXYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jlHMlBABuFk5unmKJ8uf1U8ohzICNEhN+Uqln0K+iwyi4SW7K+DjvxcdhwAIQGvq8INRh40j8+aqzX+hE0QKY7xWltJUekEUS2xVr9kBrPnSJw5t5buWLMt8X991TeolwPTEisml4vSeQmpTz+Ku7PAlQOZYIMIOKF6uKhUOJhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=glCVKYIT; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709257844; x=1740793844;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nNsEDn3Vls0jVQChE/FavePc/zLPW+1eOfz7dPTgXYs=;
  b=glCVKYITTn+OruAOFaPUX+I9YQOW24zQMww/86LAaAKU7lhNeHu1Vz4W
   NA2cpSYsq8wTZmCeVYG8geX5Wn77URlPLntnQrc+fZsvBDT+pdWLns1+S
   Mz22O1QyWZ60DNc0Io/Cb1l2HwT6dsWwpsWTrPEpxDUBwBlKjiXPeTz/L
   2zg4ePAehKMUr2BfhEdVQ76SY76Q8bjsBmlb6hPPqu6tRum5xkyl40kdx
   v1ukiNe+jCen0VshCSOk6a9bUPu2J+nPgpaWhaeD2a6eMtkgM8dSEBN71
   xd9WYnIpskrqv6sPni98wlZGntii99Hz/BiO8vwLAGKBYHZh64X5YLLQr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="15211651"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="15211651"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 17:50:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="45581280"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.124.229.115]) ([10.124.229.115])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 17:50:40 -0800
Message-ID: <f258426b-cfbe-42c8-9c6a-42452837c73c@linux.intel.com>
Date: Fri, 1 Mar 2024 09:50:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: avoid sending explicit ATS invalidation
 request to released device
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: baolu.lu@linux.intel.com, bhelgaas@google.com, robin.murphy@arm.com,
 jgg@ziepe.ca, kevin.tian@intel.com, dwmw2@infradead.org, will@kernel.org,
 lukas@wunner.de, yi.l.liu@intel.com, dan.carpenter@linaro.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240229210640.GA362869@bhelgaas>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20240229210640.GA362869@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/1/2024 5:06 AM, Bjorn Helgaas wrote:
> On Wed, Feb 28, 2024 at 10:31:38PM -0500, Ethan Zhao wrote:
>> The introduction of per iommu device rbtree also defines the lifetime of
>> interoperation between iommu and devices, if the device has been released
>> from device rbtree, no need to send ATS invalidation request to it anymore,
>> thus avoid the possibility of later ITE fault to be triggered.
>>
>> This is part of the followup of prior proposed patchset
>>
>> https://do-db2.lkml.org/lkml/2024/2/22/350
> Please use https://lore.kernel.org/ URLs instead.  This one looks like
> https://lore.kernel.org/r/20240222090251.2849702-1-haifeng.zhao@linux.intel.com/
>
>> To make sure all the devTLB entries to be invalidated in the device release
>> path, do implict invalidation by fapping the E bit of ATS control register.
>> see PCIe spec v6.2, sec 10.3.7 implicit invalidation events.
> s/implict/implicit/
>
> s/fapping/?/  (no idea :)  "flipping"?  Oh, probably "flapping" per the
> comment below.  But I think "flapping" is ambiguous; "setting" would be
> better)

Yup, like the memory bit flipping, no idea what is the right word,
setting one bit to 0, then 1, then back to 0. perhaps details the
setting action 0-->1-->0 ?

> s/v6.2/r6.2/ (also below in comment)

got it.

>
>> Fixes: 6f7db75e1c46 ("iommu/vt-d: Add second level page table interface")
>> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 6 ++++++
>>   drivers/iommu/intel/pasid.c | 7 +++++++
>>   2 files changed, 13 insertions(+)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 6743fe6c7a36..b85d88ccb4b0 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -1368,6 +1368,12 @@ static void iommu_disable_pci_caps(struct device_domain_info *info)
>>   	pdev = to_pci_dev(info->dev);
>>   
>>   	if (info->ats_enabled) {
>> +		pci_disable_ats(pdev);
>> +		/*
>> +		 * flap the E bit of ATS control register to do implicit
>> +		 * ATS invlidation, see PCIe spec v6.2, sec 10.3.7
> s/invlidation/invalidation/
>
> I would put the comment above the pci_disable_ats(), so it looks like
> this:
>
>    /* comment ... */
>    pci_disable_ats(pdev);
>    pci_enable_ats(pdev, VTD_PAGE_SHIFT);
>
>    pci_disable_ats(pdev);
>
> because the spec says the E field must change from Clear to Set to
> cause invalidation of all ATC entries, so it's important to see that
> we clear E first, then set it.

Great, will correct.

Thanks,
Ethan

>
>> +		 */
>> +		pci_enable_ats(pdev, VTD_PAGE_SHIFT);
>>   		pci_disable_ats(pdev);
>>   		info->ats_enabled = 0;
>>   		domain_update_iotlb(info->domain);
>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>> index 108158e2b907..5f13e017a12c 100644
>> --- a/drivers/iommu/intel/pasid.c
>> +++ b/drivers/iommu/intel/pasid.c
>> @@ -215,6 +215,13 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
>>   		return;
>>   
>>   	sid = info->bus << 8 | info->devfn;
>> +	/*
>> +	 * If device has been released from rbtree, no need to send ATS
>> +	 * Invalidation	request anymore, that could cause ITE fault.
>> +	 */
>> +	if (!device_rbtree_find(iommu, sid))
>> +		return;
>> +
>>   	qdep = info->ats_qdep;
>>   	pfsid = info->pfsid;
>>   
>> -- 
>> 2.31.1
>>

