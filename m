Return-Path: <linux-kernel+bounces-74182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BF885D0D6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64097287792
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4473A26E;
	Wed, 21 Feb 2024 07:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="njhbinh8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867BA39FF4
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499075; cv=none; b=lFEJleZXmBfF2XauBgEr48IXKh0vfUQ6zJwBgetA2G+E95Mitx8xa+q9pvAo2UQnv13X6LcBehgq1NFFgoP0e2qRK5B37Q2v55wv1HlJeYJB/9EuEDjVE47DdsaD0Da50qBUynyX8lAvxdTmw5KFA9egKZ/f0fxrM9CNwLm3iP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499075; c=relaxed/simple;
	bh=z8a6adMwHf0zm9CtOjQSKt10MSEpjf4VHNiwglQO3j8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TAANv/r9n/Itc5hQ2a87B8IRwaI4FPf1fiibJaBG8sAkFQHDc0if0ho9RrmYdURoMp0tQvz9z/5n1bOv6/F99wrcOGriv+zqCMTZ/Kgd29HmIeZEcRE0nf+sTiiutNAnLrZqFn1+xsrdgD70KNODhCRpsXdTJm7g/GtHdEfiS9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=njhbinh8; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708499073; x=1740035073;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=z8a6adMwHf0zm9CtOjQSKt10MSEpjf4VHNiwglQO3j8=;
  b=njhbinh8bG2rLUq/2wkwLh7K7se8dBrha8I3IMOzALxT33SZflKuisPy
   nAQhnnu/z7PVQ9JaA9bG6C4YcbJeyo4tmUoQQ02RYwSHLrao+gCISDgrk
   ZbS7xinh8+2bFdLJcLYsONQFqMKfnXbOMnWEzcvnsiJaVrpjnQpM6/0se
   4pFEjXtqp5fXI51CGuZHhhZlPF/eVMA1O0UmWOzmO0YL+OhCxkRsuLGnl
   0FVQGlYYrHIY8u7/XJJbcOd1Q3+WrX3rnQlZWanOvMl58X8hdFdQSg/D4
   V/TQ6IELsHVISM1YgUdL3fqBK4slu6QHMPw6x/uLNRffR5bKyP9vgfpXY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2514553"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="2514553"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 23:04:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="42519268"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.255.29.32]) ([10.255.29.32])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 23:04:30 -0800
Message-ID: <2049ec79-b081-4ae2-80d2-50899d461339@linux.intel.com>
Date: Wed, 21 Feb 2024 15:04:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/vt-d: Use device rbtree in iopf reporting path
To: Jason Gunthorpe <jgg@ziepe.ca>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Huang Jiaqing <jiaqing.huang@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240215072249.4465-1-baolu.lu@linux.intel.com>
 <20240215072249.4465-3-baolu.lu@linux.intel.com>
 <20240215175534.GD1299735@ziepe.ca>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20240215175534.GD1299735@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/16/2024 1:55 AM, Jason Gunthorpe wrote:
> On Thu, Feb 15, 2024 at 03:22:49PM +0800, Lu Baolu wrote:
>> The existing IO page fault handler currently locates the PCI device by
>> calling pci_get_domain_bus_and_slot(). This function searches the list
>> of all PCI devices until the desired device is found. To improve lookup
>> efficiency, a helper function named device_rbtree_find() is introduced
>> to search for the device within the rbtree. Replace
>> pci_get_domain_bus_and_slot() in the IO page fault handling path.
>>
>> Co-developed-by: Huang Jiaqing <jiaqing.huang@intel.com>
>> Signed-off-by: Huang Jiaqing <jiaqing.huang@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.h |  1 +
>>   drivers/iommu/intel/iommu.c | 29 +++++++++++++++++++++++++++++
>>   drivers/iommu/intel/svm.c   | 14 ++++++--------
>>   3 files changed, 36 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>> index 54eeaa8e35a9..f13c228924f8 100644
>> --- a/drivers/iommu/intel/iommu.h
>> +++ b/drivers/iommu/intel/iommu.h
>> @@ -1081,6 +1081,7 @@ void free_pgtable_page(void *vaddr);
>>   void iommu_flush_write_buffer(struct intel_iommu *iommu);
>>   struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *parent,
>>   					       const struct iommu_user_data *user_data);
>> +struct device *device_rbtree_find(struct intel_iommu *iommu, u16 rid);
>>   
>>   #ifdef CONFIG_INTEL_IOMMU_SVM
>>   void intel_svm_check(struct intel_iommu *iommu);
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 09009d96e553..d92c680bcc96 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -120,6 +120,35 @@ static int device_rid_cmp(struct rb_node *lhs, const struct rb_node *rhs)
>>   	return device_rid_cmp_key(&key, rhs);
>>   }
>>   
>> +/*
>> + * Looks up an IOMMU-probed device using its source ID.
>> + *
>> + * If the device is found:
>> + *  - Increments its reference count.
>> + *  - Returns a pointer to the device.
>> + *  - The caller must call put_device() after using the pointer.
>> + *
>> + * If the device is not found, returns NULL.
>> + */
>> +struct device *device_rbtree_find(struct intel_iommu *iommu, u16 rid)
>> +{
>> +	struct device_domain_info *info;
>> +	struct device *dev = NULL;
>> +	struct rb_node *node;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&iommu->device_rbtree_lock, flags);
>> +	node = rb_find(&rid, &iommu->device_rbtree, device_rid_cmp_key);
>> +	if (node) {
>> +		info = rb_entry(node, struct device_domain_info, node);
>> +		dev = info->dev;
>> +		get_device(dev);
> This get_device() is a bit troubling. It eventually calls into
> iommu_report_device_fault() which does:
>
> 	struct dev_iommu *param = dev->iommu;

So far no protection to dev->iommu structure access in generic
iommu layer between different threads, such as hot removal interrupt &
iopf handling thread, so we should enhance that in generic iommu code ?

Thanks,
Ethan

>
> Which is going to explode if the iomm driver release has already
> happened, which is a precondition to getting to a unref'd struct
> device.
>
> The driver needs to do something to fence these events during it's
> release function.
>
> If we are already doing that then I'd suggest to drop the get_device
> and add a big fat comment explaining the special rules about lifetime
> that are in effect here.
>
> Otherwise you need to do that barrier rethink the way the locking
> works..
>
> Aside from that this looks like a great improvement to me
>
> Thanks,
> Jason
>

