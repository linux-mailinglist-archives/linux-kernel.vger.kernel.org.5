Return-Path: <linux-kernel+bounces-134880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FC489B82C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152851C21931
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577232260A;
	Mon,  8 Apr 2024 07:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g2LCcLqP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB0F2BAE1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712560529; cv=none; b=BaipgIc8rme5Fr3sjyNtl1nePDVsXjVjRNn8QiUY6xlWsXHxTL4IJiWpOORttYsuucjqA0SIohaY4g0MQlXNq2+fmIahMcfGt0LILa+SwWbFDX92VCYh0okykJC0lfMcw5DGPInWJ+K7Yrx3rJJzcJJZQLZ2WNCnbUzoQmaBjZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712560529; c=relaxed/simple;
	bh=qxQSGhtB7OI4pZbUFVPKG7+Mc0Mv8CgmSkdT8Oakzfo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=s7wlE9Oap0ONwF4SA+bH50/a8jyBtPQrorvGBJgDAwKHjd4+pJmyIeXLsi80jBnlP3+JMDtHwNtoz45MnXaAN89g9SD440JWfWBUpcKpudWY24QN6zeJoAr0VauUo6snlY0whznl7HW0dRfKy4ckVRe4FeX0ygT+kykVsj5tHGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g2LCcLqP; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712560527; x=1744096527;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qxQSGhtB7OI4pZbUFVPKG7+Mc0Mv8CgmSkdT8Oakzfo=;
  b=g2LCcLqPOwotoseSGTN++Y2o04UzKH2s/FbzQC6rwW1eCa9wzgfjQysk
   aFAkLLv5oZMVDmdSFncxqCXodS96WRVbqVVI/4QmPK8flp/4CC7KK2WHX
   4LkmSzzQaWMZdcxrhjGf9eq1obW/UhIIa95Mldvfh1uuzyhPVQPEu03Hp
   S8e2ZmtIX39CRScAEQ7XEDU2FNlcbtg5HHOKEdbESzzUPY/YcZs1D6Fz7
   uhC8zQXnbu0X58oHK3+bIEXFCkNbd/6IwgXPPbP1e5f9wB67iZi2+VQ8w
   Kr5pMDhm3Zax+aUYvAKJSE8KnK3V7P8VqRxd3GtM0iRvLYR2T/yjGsOtf
   g==;
X-CSE-ConnectionGUID: Ni2D/Z7FQw6Ojlwgb/4aEA==
X-CSE-MsgGUID: CGYpdi3XR2S/Cp5Ope+BTw==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="18394883"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="18394883"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 00:15:27 -0700
X-CSE-ConnectionGUID: lLCUzcysTSmruEBJE7PNUA==
X-CSE-MsgGUID: CYDVEzm/S4ulUdJQNa41kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="24476823"
Received: from penghuan-mobl.ccr.corp.intel.com (HELO [10.254.211.109]) ([10.254.211.109])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 00:15:24 -0700
Message-ID: <fafddce6-155b-4a50-b63e-46005364181e@linux.intel.com>
Date: Mon, 8 Apr 2024 15:15:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix WARN_ON in iommu probe path
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20240407011429.136282-1-baolu.lu@linux.intel.com>
 <BN9PR11MB52760913F36DACBC612088668C002@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52760913F36DACBC612088668C002@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/8 11:52, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Sunday, April 7, 2024 9:14 AM
>>
>> Commit 1a75cc710b95 ("iommu/vt-d: Use rbtree to track iommu probed
>> devices") adds all devices probed by the iommu driver in a rbtree
>> indexed by the source ID of each device. It assumes that each device
>> has a unique source ID. This assumption is incorrect and the VT-d
>> spec doesn't state this requirement either.
>>
>> The reason for using a rbtree to track devices is to look up the device
>> with PCI bus and devfunc in the paths of handling ATS invalidation time
>> out error and the PRI I/O page faults. Both are PCI ATS feature related.
>>
>> Only track the devices that have PCI ATS capabilities in the rbtree to
>> avoid unnecessary WARN_ON in the iommu probe path. Otherwise, on some
>> platforms below kernel splat will be displayed and the iommu probe results
>> in failure.
> Just be curious. What about two ATS capable devices putting behind
> a PCI-to-PCIe bridge?

I don't think ATS capable device putting behind a PCI-to-PCIe bridge is
a right configuration for the ATS service. The PCIe spec requires this
in section 10.1.1, that

"
ATS requires the following:
- ATS capable components must interoperate with [PCIe-1.1] compliant
   components.
..
"

My understanding is that PCI-to-PCIe bridge is not a PCIe compliant
device.

> 
>>   WARNING: CPU: 3 PID: 166 at drivers/iommu/intel/iommu.c:158
>> intel_iommu_probe_device+0x319/0xd90
>>   Call Trace:
>>    <TASK>
>>    ? __warn+0x7e/0x180
>>    ? intel_iommu_probe_device+0x319/0xd90
>>    ? report_bug+0x1f8/0x200
>>    ? handle_bug+0x3c/0x70
>>    ? exc_invalid_op+0x18/0x70
>>    ? asm_exc_invalid_op+0x1a/0x20
>>    ? intel_iommu_probe_device+0x319/0xd90
>>    ? debug_mutex_init+0x37/0x50
>>    __iommu_probe_device+0xf2/0x4f0
>>    iommu_probe_device+0x22/0x70
>>    iommu_bus_notifier+0x1e/0x40
>>    notifier_call_chain+0x46/0x150
>>    blocking_notifier_call_chain+0x42/0x60
>>    bus_notify+0x2f/0x50
>>    device_add+0x5ed/0x7e0
>>    platform_device_add+0xf5/0x240
>>    mfd_add_devices+0x3f9/0x500
>>    ? preempt_count_add+0x4c/0xa0
>>    ? up_write+0xa2/0x1b0
>>    ? __debugfs_create_file+0xe3/0x150
>>    intel_lpss_probe+0x49f/0x5b0
>>    ? pci_conf1_write+0xa3/0xf0
>>    intel_lpss_pci_probe+0xcf/0x110 [intel_lpss_pci]
>>    pci_device_probe+0x95/0x120
>>    really_probe+0xd9/0x370
>>    ? __pfx___driver_attach+0x10/0x10
>>    __driver_probe_device+0x73/0x150
>>    driver_probe_device+0x19/0xa0
>>    __driver_attach+0xb6/0x180
>>    ? __pfx___driver_attach+0x10/0x10
>>    bus_for_each_dev+0x77/0xd0
>>    bus_add_driver+0x114/0x210
>>    driver_register+0x5b/0x110
>>    ? __pfx_intel_lpss_pci_driver_init+0x10/0x10 [intel_lpss_pci]
>>    do_one_initcall+0x57/0x2b0
>>    ? kmalloc_trace+0x21e/0x280
>>    ? do_init_module+0x1e/0x210
>>    do_init_module+0x5f/0x210
>>    load_module+0x1d37/0x1fc0
>>    ? init_module_from_file+0x86/0xd0
>>    init_module_from_file+0x86/0xd0
>>    idempotent_init_module+0x17c/0x230
>>    __x64_sys_finit_module+0x56/0xb0
>>    do_syscall_64+0x6e/0x140
>>    entry_SYSCALL_64_after_hwframe+0x71/0x79
>>
>> Fixes: 1a75cc710b95 ("iommu/vt-d: Use rbtree to track iommu probed
>> devices")
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 50eb9aed47cc..a7ecd90303dc 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -4299,9 +4299,11 @@ static struct iommu_device
>> *intel_iommu_probe_device(struct device *dev)
>>   	}
>>
>>   	dev_iommu_priv_set(dev, info);
>> -	ret = device_rbtree_insert(iommu, info);
>> -	if (ret)
>> -		goto free;
>> +	if (pdev && pci_ats_supported(pdev)) {
>> +		ret = device_rbtree_insert(iommu, info);
>> +		if (ret)
>> +			goto free;
>> +	}
> probably replace device_rbtree with ats_rbtree?

It makes sense. Probably I need a follow-up patch to do such cleanup.

Best regards,
baolu

