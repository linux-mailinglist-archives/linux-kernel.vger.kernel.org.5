Return-Path: <linux-kernel+bounces-133801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6D689A8DF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 06:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3A711C21CA3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 04:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006B72901;
	Sat,  6 Apr 2024 04:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SYF4bya4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECC6A50
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 04:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712378124; cv=none; b=jA/VE58daKJxFWzA66/QPTezkX0aMyEChIjvHVeRdUzwb11fJIddljVAXVpeIanXZoO+vovjxvA8Erj7hUS/PSBifACCzG6NvkkSPfuSnnoY9f/3VM9UMCelVgbt6BwilEF7UZtljBQBS7LCteqvJwIjS4zQDijDXh19+QMFSNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712378124; c=relaxed/simple;
	bh=qtmWZt/jxejIJ9PmMzYOhQaTUv0eoZfI7HqYDaoa34s=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eD3Qz6kfUVarX23Ro5nopxswpcaRdN0ZMN4GGZkonnBWyHvM2sHKxzbo+jHRWOVc0RmUcoMYyDNBmmhx/wLT7dDQt2QnOFYUT1OSkWB718NVItm1C40x0hA2PvSPgTw5xoyISgTSV7OsM50NIMRULEg8DwIKZY/yu5j1+YvYTpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SYF4bya4; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712378123; x=1743914123;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qtmWZt/jxejIJ9PmMzYOhQaTUv0eoZfI7HqYDaoa34s=;
  b=SYF4bya4A5BLUdl48EYu7FKz5WorO4cFJ1cxCnk7O02IKuagz+QiKSsA
   x8BuWwBglTd36XhN3UN4LWH7A4NzT/Sn2BghGcaAV2/NxL9zptaruTQFY
   XyV/8N3APHffRNgZa1rROc+cjCANFfUkaBNCF+rK5Pd9HVCkfKGcXjfYZ
   9HIxFZ3NvSCIjNURm1/z6YMgxW9W2DQ+valIE051OX8e0ro/ErkpgWJ6h
   c7Pc/kp5IbZXywBEfaVbFCBtXQImNFFx+WN/zF1pUKw24oK/KpgyaThjW
   fEYQQzFuamE1huA5GzeG3LxlxkD+LqnAn59nfBo0vkv5zgJ+Daun5z4Re
   g==;
X-CSE-ConnectionGUID: gVJgHCPnTZyz49x4QXIM0A==
X-CSE-MsgGUID: EGTjZufZRDi6kTYpsBfVcg==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="11544634"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="11544634"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 21:35:22 -0700
X-CSE-ConnectionGUID: 4mLoGmmEQf61FPDk4wrB4w==
X-CSE-MsgGUID: 3A8nclyETq+tLMYeWrZfsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="23986342"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa004.fm.intel.com with ESMTP; 05 Apr 2024 21:35:18 -0700
Message-ID: <3b740988-7fe6-4328-8ce2-d66d9a2ab497@linux.intel.com>
Date: Sat, 6 Apr 2024 12:34:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/9] iommu: Introduce domain attachment handle
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20240403011519.78512-1-baolu.lu@linux.intel.com>
 <20240403011519.78512-2-baolu.lu@linux.intel.com>
 <20240403115851.GA1723999@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240403115851.GA1723999@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/24 7:58 PM, Jason Gunthorpe wrote:
> On Wed, Apr 03, 2024 at 09:15:11AM +0800, Lu Baolu wrote:
>> Currently, when attaching a domain to a device or its PASID, domain is
>> stored within the iommu group. It could be retrieved for use during the
>> window between attachment and detachment.
>>
>> With new features introduced, there's a need to store more information
>> than just a domain pointer. This information essentially represents the
>> association between a domain and a device. For example, the SVA code
>> already has a custom struct iommu_sva which represents a bond between
>> sva domain and a PASID of a device. Looking forward, the IOMMUFD needs
>> a place to store the iommufd_device pointer in the core, so that the
>> device object ID could be quickly retrieved in the critical fault handling
>> path.
>>
>> Introduce domain attachment handle that explicitly represents the
>> attachment relationship between a domain and a device or its PASID.
>> A caller-specific data field can be used by the caller to store additional
>> information beyond a domain pointer, depending on its specific use case.
>>
>> Co-developed-by: Jason Gunthorpe<jgg@nvidia.com>
>> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/iommu-priv.h |   9 +++
>>   drivers/iommu/iommu.c      | 158 +++++++++++++++++++++++++++++++++----
>>   2 files changed, 153 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
>> index 5f731d994803..08c0667cef54 100644
>> --- a/drivers/iommu/iommu-priv.h
>> +++ b/drivers/iommu/iommu-priv.h
>> @@ -28,4 +28,13 @@ void iommu_device_unregister_bus(struct iommu_device *iommu,
>>   				 const struct bus_type *bus,
>>   				 struct notifier_block *nb);
>>   
>> +struct iommu_attach_handle {
>> +	struct iommu_domain		*domain;
>> +	refcount_t			users;
> I don't understand how the refcounting can be generally useful. There
> is no way to free this:
> 
>> +	void				*priv;
> When the refcount goes to zero.

This field is set by the caller, so the caller ensures that the pointer
can only be freed after iommu domain detachment. For iopf, the caller
should automatically respond to all outstanding iopf's in the domain
detach path.

In the sva case, which uses the workqueue to handle iopf,
flush_workqueue() is called in the domain detach path to ensure that all
outstanding iopf's are completed before detach completion.

For iommufd, perhaps I need to add the following code in the detach (and
the same to replace) paths:

--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -68,14 +68,35 @@ int iommufd_fault_domain_attach_dev(struct 
iommufd_hw_pagetable *hwpt,
         return 0;
  }

+static void iommufd_auto_response_handle(struct iommufd_fault *fault,
+                                        struct iommu_attach_handle *handle)
+{
+       struct iommufd_device *idev = handle->priv;
+       struct iopf_group *group;
+       unsigned long index;
+
+       mutex_lock(&fault->mutex);
+       xa_for_each(&idev->faults, index, group) {
+               xa_erase(&idev->faults, index);
+               iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
+       }
+       mutex_unlock(&fault->mutex);
+}
+
  void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
                                      struct iommufd_device *idev)
  {
+       struct iommufd_fault *fault = hwpt->fault;
+       struct iommu_attach_handle *handle;
+
         if (WARN_ON(!hwpt->fault_capable))
                 return;

+       handle = iommu_attach_handle_get(idev->igroup->group, 
IOMMU_NO_PASID);
         iommu_detach_group(hwpt->domain, idev->igroup->group);
         iommufd_fault_iopf_disable(idev);
+       iommufd_auto_response_handle(fault, handle);
+       iommu_attach_handle_put(handle);
  }

Best regards,
baolu

