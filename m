Return-Path: <linux-kernel+bounces-70802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A570859C8F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA8A328107C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB402033B;
	Mon, 19 Feb 2024 07:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nvJ0o9uu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7F820324
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708326407; cv=none; b=RvThpfNsT6YSXPPoD6v6rELDhYW61JPUO9dpLGks+VrTqqe6Aj2pm3lJKSGDTcMcer5BA9sb3oicsKYDtQBJ5yV+Ow4V37TEgnvu7M6xVEJo0VIMZBXx0byFDgKjV4gubV8geVKFP6M4isRbIsuuAg5Uj5581jjLckWsMgdb0FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708326407; c=relaxed/simple;
	bh=jL/ogQTTLnEai4egIuUnse4Yxi+uOWqeXlDLIPmtXso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=su2Um0nz61K8YpOtgCv1jwnd/E+qCA1ANFCfQ+jE1w4PKUD8QrzcuHOxzCw6+agnpaQM693L0kBqQnhi87yGScV30QEIdswB3cJ3cbJLeXgYuy3KcmRjfLfy4FiQM73DtcXC1LdjBa/lEQpHj0nRIi5l/KPAUCoRoxXcU4xIDaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nvJ0o9uu; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708326406; x=1739862406;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jL/ogQTTLnEai4egIuUnse4Yxi+uOWqeXlDLIPmtXso=;
  b=nvJ0o9uux5J4CZuZjbPE4l08/gatr4nA6OrG7yIEKdCEJku7Q2CsPfkG
   U9BpctswZQKFqcQuGXcziWaQGTO7bsNB5j/raEXlc6PyIRZYxbwUFaKdP
   WtjJmYkwk+aQy/9igQQOvb2H9NKFM1A/261jRPkdntgZs6m1D8LnrJ1ah
   ob8WKiCbu5k32UrAN7L+WBUPvxFmucOb8BgkPYs57if4EKocqM/xyjsj1
   owUJaOn3dkhW6IeIhHR34Ij8hblwNzuzUjmEk8ulthDGgDI4ZJfweH3EW
   Jru4yz5F4wsw2mUmp9pp6QSHQVNRYDDFBub4j+Wqhk3yJszaqt3Ay9rsw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="12940755"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="12940755"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 23:06:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="9000796"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.254.209.179]) ([10.254.209.179])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 23:06:42 -0800
Message-ID: <be26926a-5843-46c6-a0b9-c51b5d8e29fc@linux.intel.com>
Date: Mon, 19 Feb 2024 15:06:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/vt-d: Use device rbtree in iopf reporting path
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: Huang Jiaqing <jiaqing.huang@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240215072249.4465-1-baolu.lu@linux.intel.com>
 <20240215072249.4465-3-baolu.lu@linux.intel.com>
 <0da83c5c-0e35-4087-aacf-6831060cab8e@linux.intel.com>
 <e59f6ba0-a289-4c3f-8746-b58f9474a35b@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <e59f6ba0-a289-4c3f-8746-b58f9474a35b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/19/2024 2:58 PM, Baolu Lu wrote:
> On 2024/2/19 14:54, Ethan Zhao wrote:
>> On 2/15/2024 3:22 PM, Lu Baolu wrote:
>>> The existing IO page fault handler currently locates the PCI device by
>>> calling pci_get_domain_bus_and_slot(). This function searches the list
>>> of all PCI devices until the desired device is found. To improve lookup
>>> efficiency, a helper function named device_rbtree_find() is introduced
>>> to search for the device within the rbtree. Replace
>>> pci_get_domain_bus_and_slot() in the IO page fault handling path.
>>>
>>> Co-developed-by: Huang Jiaqing <jiaqing.huang@intel.com>
>>> Signed-off-by: Huang Jiaqing <jiaqing.huang@intel.com>
>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>> ---
>>>   drivers/iommu/intel/iommu.h |  1 +
>>>   drivers/iommu/intel/iommu.c | 29 +++++++++++++++++++++++++++++
>>>   drivers/iommu/intel/svm.c   | 14 ++++++--------
>>>   3 files changed, 36 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>>> index 54eeaa8e35a9..f13c228924f8 100644
>>> --- a/drivers/iommu/intel/iommu.h
>>> +++ b/drivers/iommu/intel/iommu.h
>>> @@ -1081,6 +1081,7 @@ void free_pgtable_page(void *vaddr);
>>>   void iommu_flush_write_buffer(struct intel_iommu *iommu);
>>>   struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain 
>>> *parent,
>>>                              const struct iommu_user_data *user_data);
>>> +struct device *device_rbtree_find(struct intel_iommu *iommu, u16 rid);
>>>   #ifdef CONFIG_INTEL_IOMMU_SVM
>>>   void intel_svm_check(struct intel_iommu *iommu);
>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>> index 09009d96e553..d92c680bcc96 100644
>>> --- a/drivers/iommu/intel/iommu.c
>>> +++ b/drivers/iommu/intel/iommu.c
>>> @@ -120,6 +120,35 @@ static int device_rid_cmp(struct rb_node *lhs, 
>>> const struct rb_node *rhs)
>>>       return device_rid_cmp_key(&key, rhs);
>>>   }
>>> +/*
>>> + * Looks up an IOMMU-probed device using its source ID.
>>> + *
>>> + * If the device is found:
>>> + *  - Increments its reference count.
>>> + *  - Returns a pointer to the device.
>>> + *  - The caller must call put_device() after using the pointer.
>>> + *
>>> + * If the device is not found, returns NULL.
>>> + */
>>> +struct device *device_rbtree_find(struct intel_iommu *iommu, u16 rid)
>>> +{
>>> +    struct device_domain_info *info;
>>> +    struct device *dev = NULL;
>>> +    struct rb_node *node;
>>> +    unsigned long flags;
>>> +
>>> +    spin_lock_irqsave(&iommu->device_rbtree_lock, flags);
>>
>> Though per iommu device rbtree isn't a big tree, given already holds 
>> spin_lock
>> why still needs irq off ?
>
> I want it to be usable not only in the normal execution flow, but also
> in the interrupt context, such as for the DMA remapping fault
> (unrecoverable) reporting path.

Holding rbtree_lock only should work in interrrupt context, I missed something ?
But with irq_off, as side effect, telling all the CPUs not to handle interrrupt
that moment.

Thanks,
Ethan

>
> Best regards,
> baolu

