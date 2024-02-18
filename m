Return-Path: <linux-kernel+bounces-70244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4171485952E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05481F228F8
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFDA7492;
	Sun, 18 Feb 2024 07:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KWxaD5Bf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079DB2CA8
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 07:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708239728; cv=none; b=qLiHJRDU3KoK1HbXUphBdQ3zKaVoAj7e5JDiiZixgYjWUO+vNyacVQFRy5B3saOu1mHAAk9bfIZ4j+RzaWtas6xzx/9kcEr7q6qkaZq2O7p7N9yj3T7jyB9k+cRVSQ2z02dPTJgyXt+ZgbJ0a+aaweqQTws7sS6C2btsta1bBBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708239728; c=relaxed/simple;
	bh=HKzHkVS1fXxecNNyqxumIEyRbepuVzHbnU1ybxwDeQM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ILAAa9ISX4LZkaSV3iuueF5qWSy3SWTu/exd5qibuxCnZzyKF8y/wpN6oCYGJNpp5EAMYxUGRV+79Tsp9uuy9K3hmttegH/+ug/lCzhXKic6fb/9ZjRGQvcslRFw94LjRRPmeLfGYwETl+LEIj8XeM3rNqsb1LAncYH2CsIu3dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KWxaD5Bf; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708239727; x=1739775727;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HKzHkVS1fXxecNNyqxumIEyRbepuVzHbnU1ybxwDeQM=;
  b=KWxaD5BfEZe3wbuLsQ1Fabd3TWNKh20QeOia/WBDf3GtY9EC0FvFBozY
   I2DPss1zuYfABqCkNfNJESTZJxBRDQZ1cjwxCDGhQWm+AW253vtgYtFMc
   aYoW7RVAf3wYc8WRMDu9JWtRYLGvwtkoF1NW/arNQyPazwNtKtM6I8ael
   22gMIFFMmpARh4f3SUflGJQ/SvGNA9IiVQqBcPJvhQQt6TfM0ZWwB5y0J
   pOhbsqRXwyJRarMKc4/Hz1qBvINjvHY2cIHL8UEwvfMpmK7XBURmVvKcE
   MlElbrjX19UHxqZ9bMl1+hb+x5HftKmzOADVc/8SRtRnWykPfMNqXm+WF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="2755487"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="2755487"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 23:02:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="826814987"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="826814987"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.209.212]) ([10.254.209.212])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 23:02:02 -0800
Message-ID: <67391b2d-b441-4d43-aa46-2a30c95420a3@linux.intel.com>
Date: Sun, 18 Feb 2024 15:02:00 +0800
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
 Ethan Zhao <haifeng.zhao@linux.intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu/vt-d: Use device rbtree in iopf reporting path
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240215072249.4465-1-baolu.lu@linux.intel.com>
 <20240215072249.4465-3-baolu.lu@linux.intel.com>
 <20240215175534.GD1299735@ziepe.ca>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240215175534.GD1299735@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/16 1:55, Jason Gunthorpe wrote:
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
> 
> This get_device() is a bit troubling. It eventually calls into
> iommu_report_device_fault() which does:
> 
> 	struct dev_iommu *param = dev->iommu;
> 
> Which is going to explode if the iomm driver release has already
> happened, which is a precondition to getting to a unref'd struct
> device.
> 
> The driver needs to do something to fence these events during it's
> release function.

Yes, theoretically the dev->iommu should be protected in the
iommu_report_device_fault() path.

> 
> If we are already doing that then I'd suggest to drop the get_device
> and add a big fat comment explaining the special rules about lifetime
> that are in effect here.
> 
> Otherwise you need to do that barrier rethink the way the locking
> works..

A device hot removing goes through at least the following steps:

- Disable PRI.
- Drain all outstanding I/O page faults.
- Stop DMA.
- Unload the device driver.
- Call iommu_release_device() upon the BUS_NOTIFY_REMOVED_DEVICE event.

This sequence ensures that a device cannot generate an I/O page fault
after PRI has been disabled. So in reality it's impossible for a device
to generate an I/O page fault before disabling PRI and then go through
the long journey to reach iommu_release_device() before
iopf_get_dev_fault_param() is called in page fault interrupt handling
thread.

Considering this behavior, adding a comment to the code explaining the
sequence and removing put_device() may be a simpler solution?

> 
> Aside from that this looks like a great improvement to me
> 
> Thanks,
> Jason

Best regards,
baolu

