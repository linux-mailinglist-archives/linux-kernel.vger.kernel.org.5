Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C04C753001
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbjGNDeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjGNDeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:34:12 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B26CD
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689305650; x=1720841650;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iC96bqOQX5kvCoBAcZNbqBQI/SPJtZnbz1ANg4udjG4=;
  b=lOawZXFcAJlJEW95MjkMi4IBPdbGjj0AxUpSm46DDCN8RHDp6xgbixYM
   wda2EeILBwV9+gMqoCLtj8eRl8V3n2zLIXdFTwYWPJq+v9Bi6iuugvxek
   aw0KKyECkzJLI2h/W6M5DHaoDYCnOa3nCVp/vC9bER0lR5i8kO/UHxkBB
   Uyo01i/FCTdgqdVfF/Cc+HxMH3RGpPYQWzXsWqdtaK2A312zwG0bXmFPw
   tKGO5KaYaURnhJW1Xki0G5hAK3bjTX/IJrUSO6KvzVuikE3CX6fLcAbrf
   dguVzt0Hq1DP25adlJsFIMHB4DZlylnFhqZb1smv+4LuIJKtuFUdBAdqH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="365419800"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="365419800"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 20:34:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="787700392"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="787700392"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.191.49]) ([10.252.191.49])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 20:34:04 -0700
Message-ID: <87e78302-9f69-8db1-8a0a-b40e1f29d9c6@linux.intel.com>
Date:   Fri, 14 Jul 2023 11:34:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@nvidia.com>,
        Will Deacon <will@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH v10 6/7] iommu/vt-d: Add set_dev_pasid callback for dma
 domain
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <20230712163355.3177511-1-jacob.jun.pan@linux.intel.com>
 <20230712163355.3177511-7-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB5276C14341AC7CE6D352948F8C37A@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276C14341AC7CE6D352948F8C37A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/13 15:56, Tian, Kevin wrote:
>> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Sent: Thursday, July 13, 2023 12:34 AM
>>
>>
>> -	/*
>> -	 * Should never reach here until we add support for attaching
>> -	 * non-SVA domain to a pasid.
>> -	 */
>> -	WARN_ON(1);
>> +	dmar_domain = to_dmar_domain(domain);
>> +	spin_lock_irqsave(&dmar_domain->lock, flags);
>> +	list_for_each_entry(curr, &dmar_domain->dev_pasids, link_domain)
>> {
>> +		if (curr->dev == dev && curr->pasid == pasid) {
>> +			list_del(&curr->link_domain);
>> +			dev_pasid = curr;
>> +			break;
>> +		}
>> +	}
>> +	spin_unlock_irqrestore(&dmar_domain->lock, flags);
>>
> 
> what about no matching dev_pasid is find?

kfree() can handle this gracefully.

> 
>> +	domain_detach_iommu(dmar_domain, iommu);
>> +	kfree(dev_pasid);
>>   out_tear_down:
>>   	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
>>   	intel_drain_pasid_prq(dev, pasid);
>>   }
>>
>> +static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
>> +				     struct device *dev, ioasid_t pasid)
>> +{
>> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
>> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>> +	struct intel_iommu *iommu = info->iommu;
>> +	struct dev_pasid_info *dev_pasid;
>> +	unsigned long flags;
>> +	int ret;
>> +
>> +	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
>> +		return -EOPNOTSUPP;
>> +
>> +	if (context_copied(iommu, info->bus, info->devfn))
>> +		return -EBUSY;
>> +
>> +	ret = prepare_domain_attach_device(domain, dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
>> +	if (!dev_pasid)
>> +		return -ENOMEM;
>> +
>> +	ret = domain_attach_iommu(dmar_domain, iommu);
>> +	if (ret)
>> +		goto out_free;
>> +
>> +	if (domain_type_is_si(dmar_domain))
>> +		ret = intel_pasid_setup_pass_through(iommu, dmar_domain,
>> +						     dev, pasid);
>> +	else if (dmar_domain->use_first_level)
>> +		ret = domain_setup_first_level(iommu, dmar_domain,
>> +					       dev, pasid);
>> +	else
>> +		ret = intel_pasid_setup_second_level(iommu, dmar_domain,
>> +						     dev, pasid);
>> +	if (ret)
>> +		goto out_detach_iommu;
>> +
>> +	dev_pasid->dev = dev;
>> +	dev_pasid->pasid = pasid;
>> +	spin_lock_irqsave(&dmar_domain->lock, flags);
>> +	list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
>> +	spin_unlock_irqrestore(&dmar_domain->lock, flags);
>> +
>> +	return 0;
>> +out_detach_iommu:
>> +	domain_detach_iommu(dmar_domain, iommu);
>> +out_free:
>> +	kfree(dev_pasid);
>> +	return ret;
>> +}
>> +
>>   const struct iommu_ops intel_iommu_ops = {
>>   	.capable		= intel_iommu_capable,
>>   	.domain_alloc		= intel_iommu_domain_alloc,
>> @@ -4777,6 +4869,7 @@ const struct iommu_ops intel_iommu_ops = {
>>   #endif
>>   	.default_domain_ops = &(const struct iommu_domain_ops) {
>>   		.attach_dev		= intel_iommu_attach_device,
>> +		.set_dev_pasid		= intel_iommu_set_dev_pasid,
>>   		.map_pages		= intel_iommu_map_pages,
>>   		.unmap_pages		= intel_iommu_unmap_pages,
>>   		.iotlb_sync_map		=
>> intel_iommu_iotlb_sync_map,
>> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>> index 6d94a29f5d52..68bb7cdf5543 100644
>> --- a/drivers/iommu/intel/iommu.h
>> +++ b/drivers/iommu/intel/iommu.h
>> @@ -595,6 +595,7 @@ struct dmar_domain {
>>
>>   	spinlock_t lock;		/* Protect device tracking lists */
>>   	struct list_head devices;	/* all devices' list */
>> +	struct list_head dev_pasids;	/* all attached pasids */
>>
>>   	struct dma_pte	*pgd;		/* virtual address */
>>   	int		gaw;		/* max guest address width */
>> @@ -717,6 +718,12 @@ struct device_domain_info {
>>   	struct pasid_table *pasid_table; /* pasid table */
>>   };
>>
>> +struct dev_pasid_info {
>> +	struct list_head link_domain;	/* link to domain siblings */
>> +	struct device *dev;		/* the physical device */
>> +	ioasid_t pasid;			/* PASID of the physical device */
>> +};
> 
> the comment for dev/pasid is meaningless.

Then we can remove them.

Best regards,
baolu
