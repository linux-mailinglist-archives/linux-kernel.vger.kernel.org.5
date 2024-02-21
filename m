Return-Path: <linux-kernel+bounces-74247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0BE85D18B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF741F2100D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9E83AC12;
	Wed, 21 Feb 2024 07:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lGr2DN+s"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0287039879
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708501061; cv=none; b=ovX7uVWK05ujhQdckwsQDIT0My6iLpcyPQscMflttOIVt/SNg6R34F1jbdyNVrJogAE3CuJAMrVr/lRc3+yU7Z5RylnnsydZO7PsoonN3WvrI5FW/0oYPtHGFdbjjv+TXyLQgjO81zJFrcA7jlIqRm3c/AhNjdykqz88YJehOWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708501061; c=relaxed/simple;
	bh=JceDNvK/M7QV+iUrBQaGfshcPpFauLuTbcLabhJ8U4s=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OA79A/vRiS9p6xkGWoiYW202OsLe7Ig/4l4j4QhWfac/H2jg6Wnon8QSvV96MKdePbhJDcOXWHycF/GNwpR8pyokkOXcO05L+3YrXAdDzgrqW3AvKBEwpeOy2K+QRWIfR+fuIWCndpSES9+e8Si9euaboN09GfYJ4Agt0LLEjqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lGr2DN+s; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708501061; x=1740037061;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JceDNvK/M7QV+iUrBQaGfshcPpFauLuTbcLabhJ8U4s=;
  b=lGr2DN+sqD+HkFSnL9MWGHMR9eLPDou/Hh0ncm0V/Bf7ifGcVaE2p+Zf
   n2OQPbXO8jmfdHoiX8QQMPmAGWH+lwqChwmdoFZaCrZxpNtDHHrMBDgSa
   atMWnodxTkzypN/TLLKf1nfddVv1yKX9l6czuHP+5rIHE0yfo1JD83EG0
   3WHcQaVu7ibSIfnW1dH9nJ3h8kJksddnznWOV54X9GS2j0tMNm2Rnh6Qe
   erxr0AmCylRA01RjMwo08n6NM+meCRgks5Zk/Viyb0DtWB/0pP1hrBc2y
   B4C6XgGajrcXV03x/rR1AsbUvJJh/A2HYfQG4JcZ4PShXKA//ca1dmxeP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="25108117"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="25108117"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 23:37:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="9688812"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.171.203]) ([10.249.171.203])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 23:37:37 -0800
Message-ID: <02680b8d-ac70-40ba-9242-c50aeab88857@linux.intel.com>
Date: Wed, 21 Feb 2024 15:37:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Huang Jiaqing <jiaqing.huang@intel.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu/vt-d: Use device rbtree in iopf reporting path
Content-Language: en-US
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20240215072249.4465-1-baolu.lu@linux.intel.com>
 <20240215072249.4465-3-baolu.lu@linux.intel.com>
 <20240215175534.GD1299735@ziepe.ca>
 <2049ec79-b081-4ae2-80d2-50899d461339@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <2049ec79-b081-4ae2-80d2-50899d461339@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/2/21 15:04, Ethan Zhao wrote:
> On 2/16/2024 1:55 AM, Jason Gunthorpe wrote:
>> On Thu, Feb 15, 2024 at 03:22:49PM +0800, Lu Baolu wrote:
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
>>> +    node = rb_find(&rid, &iommu->device_rbtree, device_rid_cmp_key);
>>> +    if (node) {
>>> +        info = rb_entry(node, struct device_domain_info, node);
>>> +        dev = info->dev;
>>> +        get_device(dev);
>> This get_device() is a bit troubling. It eventually calls into
>> iommu_report_device_fault() which does:
>>
>>     struct dev_iommu *param = dev->iommu;
> 
> So far no protection to dev->iommu structure access in generic
> iommu layer between different threads, such as hot removal interrupt &
> iopf handling thread, so we should enhance that in generic iommu code ?

The iommu core is sitting between the upper layers and individual iommu
drivers. All calls from the upper layers are made within the driver
context. The device driver framework and iommu subsystem guarantee that
dev->iommu is always valid in the driver context.

However, iommu_report_device_fault() is different. It's called in the
interrupt thread, not in any driver context. Hence, the individual iommu
driver should guarantee that dev->iommu is valid when calling
iommu_report_device_fault().

Best regards,
baolu

