Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9DA80B2FE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 09:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjLIH5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 02:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjLIH5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 02:57:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122F310CF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 23:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702108643; x=1733644643;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IfcEoRZ+GUIXcMKDg9WsBnRqP0HY5kXEDbcOQjV/3bM=;
  b=DOHuGEUdPfANeqsLqpfGUHNaYIGIOcXENfrEe1zM5cdrnagYjlVit8MK
   tFuBL6lO1p510yHrQ/gYA9q564RWuvnV/Wjcko8eabt5PaOmx6Bj+9p1U
   WbUpxcgsuHSy8OyTi9lYUvhJ5Z2r3PGLyUm12wZLOZdR2RZd43qM0iHCk
   X3rbCfzSMwbOFNkRNF9Vv+iFQQM9kdk2NbqrPh5xaFXL7e+ks3zvkYNhQ
   5zaMaf2LDVC2cSBQVoqBIGRavYBu/QQ53uom0ZewzlzKTVCxk1Dwm2+Y3
   8JLHsjOKyR2ZjpuSXWBmX3NColgVuJ4L23clOFEj1rT84fviFKxajc5DI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="460972597"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="460972597"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 23:57:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="838366809"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="838366809"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga008.fm.intel.com with ESMTP; 08 Dec 2023 23:57:19 -0800
Message-ID: <0008adc6-57fd-4ac8-8e8e-5a966596ad61@linux.intel.com>
Date:   Sat, 9 Dec 2023 15:52:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] iommu/vt-d: Setup scalable mode context entry in
 probe path
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20231205012203.244584-1-baolu.lu@linux.intel.com>
 <20231205012203.244584-2-baolu.lu@linux.intel.com>
 <BN9PR11MB5276A5F34EA7CBBF026E264E8C8AA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276A5F34EA7CBBF026E264E8C8AA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/23 4:50 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, December 5, 2023 9:22 AM
>>
>> @@ -304,6 +304,11 @@ int intel_pasid_setup_first_level(struct intel_iommu
>> *iommu,
>>   		return -EINVAL;
>>   	}
>>
>> +	if (intel_pasid_setup_sm_context(dev, true)) {
>> +		dev_err(dev, "Context entry is not configured\n");
>> +		return -ENODEV;
>> +	}
>> +
>>   	spin_lock(&iommu->lock);
>>   	pte = intel_pasid_get_entry(dev, pasid);
>>   	if (!pte) {
>> @@ -384,6 +389,11 @@ int intel_pasid_setup_second_level(struct
>> intel_iommu *iommu,
>>   		return -EINVAL;
>>   	}
>>
>> +	if (intel_pasid_setup_sm_context(dev, true)) {
>> +		dev_err(dev, "Context entry is not configured\n");
>> +		return -ENODEV;
>> +	}
>> +
>>   	pgd = domain->pgd;
>>   	agaw = iommu_skip_agaw(domain, iommu, &pgd);
>>   	if (agaw < 0) {
>> @@ -505,6 +515,11 @@ int intel_pasid_setup_pass_through(struct
>> intel_iommu *iommu,
>>   	u16 did = FLPT_DEFAULT_DID;
>>   	struct pasid_entry *pte;
>>
>> +	if (intel_pasid_setup_sm_context(dev, true)) {
>> +		dev_err(dev, "Context entry is not configured\n");
>> +		return -ENODEV;
>> +	}
>> +
>>   	spin_lock(&iommu->lock);
>>   	pte = intel_pasid_get_entry(dev, pasid);
>>   	if (!pte) {
> 
> instead of replicating the invocation in all three stubs it's simpler to
> do once in dmar_domain_attach_device() for all of them.

It's not good to repeat the code. Perhaps we can add this check to
intel_pasid_get_entry()? The rule is that you can't get the pasid entry
if the context is copied.

> Then put the deferred check outside of intel_pasid_setup_sm_context()
> instead of using a Boolean flag

Okay, that's more readable.

>> @@ -623,6 +638,11 @@ int intel_pasid_setup_nested(struct intel_iommu
>> *iommu, struct device *dev,
>>   		return -EINVAL;
>>   	}
>>
>> +	if (intel_pasid_setup_sm_context(dev, true)) {
>> +		dev_err_ratelimited(dev, "Context entry is not configured\n");
>> +		return -ENODEV;
>> +	}
>> +
> 
> Do we support nested in kdump?

No.

> 
>> +
>> +	/*
>> +	 * Cache invalidation for changes to a scalable-mode context table
>> +	 * entry.
>> +	 *
>> +	 * Section 6.5.3.3 of the VT-d spec:
>> +	 * - Device-selective context-cache invalidation;
>> +	 * - Domain-selective PASID-cache invalidation to affected domains
>> +	 *   (can be skipped if all PASID entries were not-present);
>> +	 * - Domain-selective IOTLB invalidation to affected domains;
>> +	 * - Global Device-TLB invalidation to affected functions.
>> +	 *
>> +	 * For kdump cases, old valid entries may be cached due to the
>> +	 * in-flight DMA and copied pgtable, but there is no unmapping
>> +	 * behaviour for them, thus we need explicit cache flushes for all
>> +	 * affected domain IDs and PASIDs used in the copied PASID table.
>> +	 * Given that we have no idea about which domain IDs and PASIDs
>> were
>> +	 * used in the copied tables, upgrade them to global PASID and IOTLB
>> +	 * cache invalidation.
>> +	 *
>> +	 * For kdump case, at this point, the device is supposed to finish
>> +	 * reset at its driver probe stage, so no in-flight DMA will exist,
>> +	 * and we don't need to worry anymore hereafter.
>> +	 */
>> +	if (context_copied(iommu, bus, devfn)) {
>> +		context_clear_entry(context);
>> +		clear_context_copied(iommu, bus, devfn);
>> +		iommu->flush.flush_context(iommu, 0,
>> +					   (((u16)bus) << 8) | devfn,
>> +					   DMA_CCMD_MASK_NOBIT,
>> +					   DMA_CCMD_DEVICE_INVL);
>> +		qi_flush_pasid_cache(iommu, 0, QI_PC_GLOBAL, 0);
>> +		iommu->flush.flush_iotlb(iommu, 0, 0, 0,
>> DMA_TLB_GLOBAL_FLUSH);
>> +		devtlb_invalidation_with_pasid(iommu, dev,
>> IOMMU_NO_PASID);
>> +	}
> 
> I don't see this logic from existing code. If it's a bug fix then
> please send it separately first.

This code originates from domain_context_mapping_one(). It's not a bug
fix.

>> +
>> +	context_entry_set_pasid_table(context, dev);
> 
> and here is additional change to the context entry. Why is the
> context cache invalidated in the start?

The previous context entry may be copied from a previous kernel.
Therefore, we need to tear down the entry and flush the caches before
reusing it.

> 
>> +
>> +static int pci_pasid_table_setup(struct pci_dev *pdev, u16 alias, void *data)
>> +{
>> +	struct device *dev = data;
>> +
>> +	if (dev != &pdev->dev)
>> +		return 0;
> 
> what is it for? the existing domain_context_mapping_cb() doesn't have
> this check then implying a behavior change.

Emm, I should remove this line and keep it consistent with the exiting
code.

Best regards,
baolu
