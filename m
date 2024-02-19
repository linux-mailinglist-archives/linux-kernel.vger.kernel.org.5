Return-Path: <linux-kernel+bounces-70794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6330859C75
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E34D0B2141C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086A120322;
	Mon, 19 Feb 2024 06:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KBY8+2TJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D18208A9
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708325933; cv=none; b=QIHL/bAqzKTs7YGWGGjvOHuez3Rp3axquGY1+4c9gZFA3yZH/NMRMJ5yZbsnU3bOVSc9xZIaZhvD9HWIlzm/EdUldBNquyM4tbdvSEz4oUpvfoYejbUtNJW0+6XVaV9s3BzFhBmRNfzGEfSUbFrsm6wUh9q4d9iVYnifB1+C+As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708325933; c=relaxed/simple;
	bh=Pb1aZOld1EmcUHzmbXWEjtyFmhh3gojEOq9lhsXaZFQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Zyx8PnTBDdzQh02bD7vv7FV5MsL4LyY/1MGr7mYAGYcERVg/dvfqRHwY5pLEADC7HinYiLOqzf6kknyLpVNH7Excm7Ob+gr3dwodMC8FSDmihMBCfsmugK6eamaZlvcomSndjB8fnMQeuQbo+uVLJAvnxvJo94tE25ADayiD7S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KBY8+2TJ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708325932; x=1739861932;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Pb1aZOld1EmcUHzmbXWEjtyFmhh3gojEOq9lhsXaZFQ=;
  b=KBY8+2TJF0BXwgBqnTmeAmlY2B5p9ccGqbD1x8Id6dccN/4c4G2D8HFQ
   1XviSd0zohkCzMLcvDkegZpXZKojAzM+b8wyVWJsMwao/d5IS4+MASelE
   vuA1+4J8DboPN1CT6sJ3okJuCaBO+aj0tBdfHl9r4IxvXMC38iFL/1fo2
   ukxsG6DdN5piyyFF0829uId3ofhAAjprAbn5DgOjU7CiVTMi85uJv++Lv
   +nGEOFDkcBM1mxpDcxyTaER9sNRru+Ls2APrXt3w4pppfYL80GfrY4ZQd
   HvZIzQB8hLfWJFTWmqXxXhDPlP52kMmC7C4joGhXlXfOmSO2p0oHH5YKf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2254842"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2254842"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 22:58:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="9077661"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.215.112]) ([10.254.215.112])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 22:58:47 -0800
Message-ID: <e59f6ba0-a289-4c3f-8746-b58f9474a35b@linux.intel.com>
Date: Mon, 19 Feb 2024 14:58:44 +0800
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
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <0da83c5c-0e35-4087-aacf-6831060cab8e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/2/19 14:54, Ethan Zhao wrote:
> On 2/15/2024 3:22 PM, Lu Baolu wrote:
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
>>   drivers/iommu/intel/iommu.h |  1 +
>>   drivers/iommu/intel/iommu.c | 29 +++++++++++++++++++++++++++++
>>   drivers/iommu/intel/svm.c   | 14 ++++++--------
>>   3 files changed, 36 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>> index 54eeaa8e35a9..f13c228924f8 100644
>> --- a/drivers/iommu/intel/iommu.h
>> +++ b/drivers/iommu/intel/iommu.h
>> @@ -1081,6 +1081,7 @@ void free_pgtable_page(void *vaddr);
>>   void iommu_flush_write_buffer(struct intel_iommu *iommu);
>>   struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain 
>> *parent,
>>                              const struct iommu_user_data *user_data);
>> +struct device *device_rbtree_find(struct intel_iommu *iommu, u16 rid);
>>   #ifdef CONFIG_INTEL_IOMMU_SVM
>>   void intel_svm_check(struct intel_iommu *iommu);
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 09009d96e553..d92c680bcc96 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -120,6 +120,35 @@ static int device_rid_cmp(struct rb_node *lhs, 
>> const struct rb_node *rhs)
>>       return device_rid_cmp_key(&key, rhs);
>>   }
>> +/*
>> + * Looks up an IOMMU-probed device using its source ID.
>> + *
>> + * If the device is found:
>> + *  - Increments its reference count.
>> + *  - Returns a pointer to the device.
>> + *  - The caller must call put_device() after using the pointer.
>> + *
>> + * If the device is not found, returns NULL.
>> + */
>> +struct device *device_rbtree_find(struct intel_iommu *iommu, u16 rid)
>> +{
>> +    struct device_domain_info *info;
>> +    struct device *dev = NULL;
>> +    struct rb_node *node;
>> +    unsigned long flags;
>> +
>> +    spin_lock_irqsave(&iommu->device_rbtree_lock, flags);
> 
> Though per iommu device rbtree isn't a big tree, given already holds 
> spin_lock
> why still needs irq off ?

I want it to be usable not only in the normal execution flow, but also
in the interrupt context, such as for the DMA remapping fault
(unrecoverable) reporting path.

Best regards,
baolu

