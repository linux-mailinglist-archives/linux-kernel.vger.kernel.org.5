Return-Path: <linux-kernel+bounces-70821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40213859CC3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4812B212F2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3710208C6;
	Mon, 19 Feb 2024 07:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RXn/oV80"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5150B20DEB
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708327361; cv=none; b=T4wMhggy3+cE19/4uGIqUhEp6XFQgid2B0Pg/ZIkdurmVYyUNcl5fJusDshbNwRyNffuTza4KlJQs9ofYgAvtPoj8hxBSVDCCvhj02qGzVGVJZFvTxhstzwk1Uti53IO/A+AGSoMq850dtF60tv8p8ZbSRhOCSsCT5EnAMohvWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708327361; c=relaxed/simple;
	bh=WJoJWc4NJmRDweWqU7/qelFnZ7VDIWAHnqXRxCqaBlI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NFTwONQ/NOnFYuZ9i9KhfkufgEgG+E/yut2uJb6QoeyaQroevl6vDLZt8viCIuf3KiqOAXfpxnuaeQRlmhN/L/rvoWJYvnGdlRSawkD7fy4lXyWmFm4Dt0shjccaboA88UAuETKlGHuZ8ETOs+TCnFDL6hNmQt3KCoDWjv2h4T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RXn/oV80; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708327360; x=1739863360;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WJoJWc4NJmRDweWqU7/qelFnZ7VDIWAHnqXRxCqaBlI=;
  b=RXn/oV80x94TSJ93gEGT1btR365fXClSbWJ8q9pktHcja4bw3Gfd/fqI
   a+pZgGCgAOn+emDp5PCjDRiiaDIICTQHolM/Ckge+uk7NuSF3niln89/X
   bV5+gCrHHPdgr3aCq0MHw0aOwdl7mvyNTLgTHfzmlMM3c042c+4UZQ409
   OAgCzeRN0Fk8qmVJNyPky7a1nZz5hhvqoFHSUrlaKPbrXDqHs00mHp/bT
   RylUSkjz4V9t7VAJoIZCopPA5Iwd4Xpnmk47XnJmlLiFI1qcW/Ca/vqO6
   rH+ICBZGj3wYDKO5RvrKX6oYHLItsULaT811oiixw7jk4eAs0LutVlmeW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="13501647"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="13501647"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 23:22:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="27576624"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.215.112]) ([10.254.215.112])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 23:22:36 -0800
Message-ID: <2fa8af78-5277-4278-b0e2-8a983dbbab2c@linux.intel.com>
Date: Mon, 19 Feb 2024 15:22:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Huang Jiaqing <jiaqing.huang@intel.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu/vt-d: Use device rbtree in iopf reporting path
Content-Language: en-US
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>
References: <20240215072249.4465-1-baolu.lu@linux.intel.com>
 <20240215072249.4465-3-baolu.lu@linux.intel.com>
 <0da83c5c-0e35-4087-aacf-6831060cab8e@linux.intel.com>
 <e59f6ba0-a289-4c3f-8746-b58f9474a35b@linux.intel.com>
 <be26926a-5843-46c6-a0b9-c51b5d8e29fc@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <be26926a-5843-46c6-a0b9-c51b5d8e29fc@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/2/19 15:06, Ethan Zhao wrote:
> On 2/19/2024 2:58 PM, Baolu Lu wrote:
>> On 2024/2/19 14:54, Ethan Zhao wrote:
>>> On 2/15/2024 3:22 PM, Lu Baolu wrote:
>>>> The existing IO page fault handler currently locates the PCI device by
>>>> calling pci_get_domain_bus_and_slot(). This function searches the list
>>>> of all PCI devices until the desired device is found. To improve lookup
>>>> efficiency, a helper function named device_rbtree_find() is introduced
>>>> to search for the device within the rbtree. Replace
>>>> pci_get_domain_bus_and_slot() in the IO page fault handling path.
>>>>
>>>> Co-developed-by: Huang Jiaqing <jiaqing.huang@intel.com>
>>>> Signed-off-by: Huang Jiaqing <jiaqing.huang@intel.com>
>>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>>> ---
>>>>   drivers/iommu/intel/iommu.h |  1 +
>>>>   drivers/iommu/intel/iommu.c | 29 +++++++++++++++++++++++++++++
>>>>   drivers/iommu/intel/svm.c   | 14 ++++++--------
>>>>   3 files changed, 36 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>>>> index 54eeaa8e35a9..f13c228924f8 100644
>>>> --- a/drivers/iommu/intel/iommu.h
>>>> +++ b/drivers/iommu/intel/iommu.h
>>>> @@ -1081,6 +1081,7 @@ void free_pgtable_page(void *vaddr);
>>>>   void iommu_flush_write_buffer(struct intel_iommu *iommu);
>>>>   struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain 
>>>> *parent,
>>>>                              const struct iommu_user_data *user_data);
>>>> +struct device *device_rbtree_find(struct intel_iommu *iommu, u16 rid);
>>>>   #ifdef CONFIG_INTEL_IOMMU_SVM
>>>>   void intel_svm_check(struct intel_iommu *iommu);
>>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>>> index 09009d96e553..d92c680bcc96 100644
>>>> --- a/drivers/iommu/intel/iommu.c
>>>> +++ b/drivers/iommu/intel/iommu.c
>>>> @@ -120,6 +120,35 @@ static int device_rid_cmp(struct rb_node *lhs, 
>>>> const struct rb_node *rhs)
>>>>       return device_rid_cmp_key(&key, rhs);
>>>>   }
>>>> +/*
>>>> + * Looks up an IOMMU-probed device using its source ID.
>>>> + *
>>>> + * If the device is found:
>>>> + *  - Increments its reference count.
>>>> + *  - Returns a pointer to the device.
>>>> + *  - The caller must call put_device() after using the pointer.
>>>> + *
>>>> + * If the device is not found, returns NULL.
>>>> + */
>>>> +struct device *device_rbtree_find(struct intel_iommu *iommu, u16 rid)
>>>> +{
>>>> +    struct device_domain_info *info;
>>>> +    struct device *dev = NULL;
>>>> +    struct rb_node *node;
>>>> +    unsigned long flags;
>>>> +
>>>> +    spin_lock_irqsave(&iommu->device_rbtree_lock, flags);
>>>
>>> Though per iommu device rbtree isn't a big tree, given already holds 
>>> spin_lock
>>> why still needs irq off ?
>>
>> I want it to be usable not only in the normal execution flow, but also
>> in the interrupt context, such as for the DMA remapping fault
>> (unrecoverable) reporting path.
> 
> Holding rbtree_lock only should work in interrrupt context, I missed 
> something ?

No. That will possibly cause dead lock.

Best regards,
baolu

