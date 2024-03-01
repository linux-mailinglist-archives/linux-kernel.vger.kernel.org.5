Return-Path: <linux-kernel+bounces-87802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F07186D936
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACDC51F25C62
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1121B36137;
	Fri,  1 Mar 2024 01:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="huy8Z9ze"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22B13399B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 01:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709257900; cv=none; b=EzKuZ/jCu+QHVapQJ3vkNDWkQs0rlP6UAumsf/ft3mla+nQCH/9onvqOve8Kt2PSIaUGk4tsw+L18TCzgx70TDOTMDWArsKf2xV2upXlcwW2M0qBoJeylrA+2190j/J+27MqC6ftB+gbVSY+4vMCIWUB0hxSV4hZ4KVqVcgG3RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709257900; c=relaxed/simple;
	bh=hFW6W71DX+J8HilFF8PSecokRa8ihHk28CG7/DMhH3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rlk7qNydeM7oaT3K9hsYcAfVPSWqiCqDAQ6C/PrHTG5enk/ACpNQ2ag4dnrwoMB3dCKJkSa+IXorYA8HDeCSNZOyH439nX8XjGj0J0q7PHy+c9BaqMxgELfYWQjaEo4AgHKcCYkv6ey/jwQPyMzQAwm2FwioJcsukQ6GIXUp7cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=huy8Z9ze; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709257899; x=1740793899;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hFW6W71DX+J8HilFF8PSecokRa8ihHk28CG7/DMhH3w=;
  b=huy8Z9zeni11Ubf1UrQuvHqcE6RMqIDLA9Eo5JHFnnyW+MBdtOcbu/fR
   4E9t+cWSDOtr4H73mKy6Tp8yRF6Zo1In/2+Dwo/WuztrgWm3KeDe6v1E4
   tiCiO7Mqe/C21Rq5k5lzhRfEAUlHrLFUx5GTXBKyUl2/vDfkIAtKMcGcR
   xYJUI+4LI969/QWks1nr7W19M8vv97We6DzKIcys5ixOIf4DFnnmJVNe7
   WRBVItpXogiCbq18jrwN0RhMkCLqt7BSbqw4gORY4iNfa3WoI6tuC/i5I
   E2Auhh6YgaE89cghmhSslLBasiVxer0zGQvuFc5CFW00/FzNAKO6hC1Be
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="15211690"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="15211690"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 17:51:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="45581615"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.124.229.115]) ([10.124.229.115])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 17:51:35 -0800
Message-ID: <86db24b9-5461-4b6b-8858-a7ca2966c957@linux.intel.com>
Date: Fri, 1 Mar 2024 09:51:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: improve ITE fault handling if device was
 released
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: baolu.lu@linux.intel.com, bhelgaas@google.com, robin.murphy@arm.com,
 jgg@ziepe.ca, kevin.tian@intel.com, dwmw2@infradead.org, will@kernel.org,
 lukas@wunner.de, yi.l.liu@intel.com, dan.carpenter@linaro.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240229210726.GA363458@bhelgaas>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20240229210726.GA363458@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/1/2024 5:07 AM, Bjorn Helgaas wrote:
> On Wed, Feb 28, 2024 at 11:07:24PM -0500, Ethan Zhao wrote:
>> Break the loop to blindly retry the timeout ATS invalidation request
>> after ITE fault hit if device was released or isn't present anymore.
>>
>> This is part of the followup of prior proposed patchset
>>
>> https://do-db2.lkml.org/lkml/2024/2/22/350
> Use lore URL, please.

Sure !

>
>> Fixes: 6ba6c3a4cacf ("VT-d: add device IOTLB invalidation support")
>> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
>> ---
>>   drivers/iommu/intel/dmar.c | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>> index d14797aabb7a..d01d68205557 100644
>> --- a/drivers/iommu/intel/dmar.c
>> +++ b/drivers/iommu/intel/dmar.c
>> @@ -1273,6 +1273,9 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
>>   {
>>   	u32 fault;
>>   	int head, tail;
>> +	u64 iqe_err, ite_sid;
>> +	struct device *dev = NULL;
>> +	struct pci_dev *pdev = NULL;
>>   	struct q_inval *qi = iommu->qi;
>>   	int shift = qi_shift(iommu);
>>   
>> @@ -1317,6 +1320,13 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
>>   		tail = readl(iommu->reg + DMAR_IQT_REG);
>>   		tail = ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
>>   
>> +		/*
>> +		 * SID field is valid only when the ITE field is Set in FSTS_REG
>> +		 * see Intel VT-d spec r4.1, section 11.4.9.9
>> +		 */
>> +		iqe_err = dmar_readq(iommu->reg + DMAR_IQER_REG);
>> +		ite_sid = DMAR_IQER_REG_ITESID(iqe_err);
>> +
>>   		writel(DMA_FSTS_ITE, iommu->reg + DMAR_FSTS_REG);
>>   		pr_info("Invalidation Time-out Error (ITE) cleared\n");
>>   
>> @@ -1326,6 +1336,21 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
>>   			head = (head - 2 + QI_LENGTH) % QI_LENGTH;
>>   		} while (head != tail);
>>   
>> +		/*
>> +		 * If got ITE, we need to check if the sid of ITE is one of the
>> +		 * current valid ATS invalidation target devices, if no, or the
>> +		 * target device isn't presnet, don't try this request anymore.
>> +		 * 0 value of ite_sid means old VT-d device, no ite_sid value.
>> +		 */
>> +		if (ite_sid) {
>> +			dev = device_rbtree_find(iommu, ite_sid);
>> +			if (!dev || !dev_is_pci(dev))
>> +				return -ETIMEDOUT;
>> +			pdev = to_pci_dev(dev);
>> +			if (!pci_device_is_present(pdev) &&
>> +				ite_sid == pci_dev_id(pci_physfn(pdev)))
>> +				return -ETIMEDOUT;
>> +		}
>>   		if (qi->desc_status[wait_index] == QI_ABORT)
>>   			return -EAGAIN;
>>   	}
>> -- 
>> 2.31.1
>>

