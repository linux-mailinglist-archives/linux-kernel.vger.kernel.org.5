Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35438131A7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573341AbjLNNdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573304AbjLNNds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:33:48 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F401114;
        Thu, 14 Dec 2023 05:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702560834; x=1734096834;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=soBBTcL3N0Z5TyqqPy+iCs++Nwlxmcs4HlCzpCK+Ozw=;
  b=fN6tqZiwNcL/+l9lCwbG/GJFNQswxjj+zYaHGJLzfqqbAvWPdQuxKFTF
   DKAT515nZSkSVIIhIxerilnmI9tbNwZi2GR8ZHB5b5wC7oA0ZZlLXqiSy
   E6OxiwTyMJPLbYbbwFgSwXdTgGy3AEetT3gJRyYq8T3E+xNcqVYidkKfj
   wrnfA+vZosa5rdsVYULWZtCbBmxRAyTiHFeROFp96YgIpg2P61c3NF7Tl
   piTd2rklxO0a3+Wg2ppl93eEwf+WsoQC9NkJNIETTG6tUKBtqENiiR0ZM
   6/eiTcy1RfZeqlAEOPCsxX8cxZx0HnW55aRozEY+BHFb8JRkt7oZ7xtCZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="375274190"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="375274190"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 05:33:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="892469482"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="892469482"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.210.30]) ([10.254.210.30])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 05:33:48 -0800
Message-ID: <4e08dc77-82ce-40ce-8a0c-ac9016186c23@linux.intel.com>
Date:   Thu, 14 Dec 2023 21:33:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com, robin.murphy@arm.com,
        kevin.tian@intel.com, jgg@nvidia.com, alex.williamson@redhat.com,
        joro@8bytes.org, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com,
        xin.zeng@intel.com, yan.y.zhao@intel.com
Subject: Re: [PATCH 8/8] iommu/vt-d: Add set_dev_pasid callback for nested
 domain
To:     "Yang, Weijiang" <weijiang.yang@intel.com>,
        Yi Liu <yi.l.liu@intel.com>
References: <20231127063428.127436-1-yi.l.liu@intel.com>
 <20231127063428.127436-9-yi.l.liu@intel.com>
 <a19031b0-7c30-45e6-b171-c53e3578b867@intel.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <a19031b0-7c30-45e6-b171-c53e3578b867@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/12/14 10:55, Yang, Weijiang wrote:
> On 11/27/2023 2:34 PM, Yi Liu wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>
>> This allows the upper layers to set a nested type domain to a PASID of a
>> device if the PASID feature is supported by the IOMMU hardware.
>>
>> The set_dev_pasid callback for non-nest domain has already be there, so
>> this only needs to add it for nested domains.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> ---
>>   drivers/iommu/intel/nested.c | 47 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 47 insertions(+)
>>
>> diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
>> index 44ad48db7ea0..f6f687750104 100644
>> --- a/drivers/iommu/intel/nested.c
>> +++ b/drivers/iommu/intel/nested.c
>> @@ -68,6 +68,52 @@ static int intel_nested_attach_dev(struct 
>> iommu_domain *domain,
>>       return 0;
>>   }
>> +static int intel_nested_set_dev_pasid(struct iommu_domain *domain,
>> +                      struct device *dev, ioasid_t pasid)
>> +{
>> +    struct device_domain_info *info = dev_iommu_priv_get(dev);
>> +    struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>> +    struct intel_iommu *iommu = info->iommu;
>> +    struct dev_pasid_info *dev_pasid;
>> +    unsigned long flags;
>> +    int ret = 0;
>> +
>> +    if (!pasid_supported(iommu))
>> +        return -EOPNOTSUPP;
>> +
>> +    if (iommu->agaw < dmar_domain->s2_domain->agaw)
>> +        return -EINVAL;
>> +
>> +    ret = 
>> prepare_domain_attach_device(&dmar_domain->s2_domain->domain, dev);
>> +    if (ret)
>> +        return ret;
>> +
>> +    dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
>> +    if (!dev_pasid)
>> +        return -ENOMEM;
>> +
>> +    ret = domain_attach_iommu(dmar_domain, iommu);
>> +    if (ret)
>> +        goto err_free;
>> +
>> +    ret = intel_pasid_setup_nested(iommu, dev, pasid, dmar_domain);
>> +    if (ret)
>> +        goto err_detach_iommu;
>> +
>> +    dev_pasid->dev = dev;
>> +    dev_pasid->pasid = pasid;
>> +    spin_lock_irqsave(&dmar_domain->lock, flags);
>> +    list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
>> +    spin_unlock_irqrestore(&dmar_domain->lock, flags);
> 
> ---> list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
> 
> dev_pasid is linked at later time, this leads to 
> domain->has_iotlb_device is not correctly set, which finally results 
> into a missing of device iotlb flush in iommu_flush_dev_iotlb()when it's 
> called.
> Check this call path:
> domain_attach_iommu()->domain_update_iommu_cap()->domain_update_iotlb()->domain->has_iotlb_device = has_iotlb_device; The ugly fixup is to call domain_update_iommu_cap() or domain_update_iotlb() here again before return.
> The similar issue is in intel_iommu_set_dev_pasid() and 
> intel_nested_attach_dev().

Yes, domain->has_iotlb_device must be updated whenever a domain is
attached to (or removed from) a RID or PASID. I would be grateful if you
could post some patches to fix the set_device_pasid and
nested_attach_dev paths.

I assume Yi can fix this series in the next version.

Best regards,
baolu
