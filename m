Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEC8752FF5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbjGND2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbjGND22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:28:28 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6968F270A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689305306; x=1720841306;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nVIcB82tLh0UA0mJc4/Rq+bVR36taDChNwOAP4F0acA=;
  b=UxmedvMJVluoYuvDdLnE/xDKSbJJiJgdHZbA7IDSJBgEX06QfuxwzkcS
   O9WD8uXlDCrKiqw5TNrPKW3gV6HmHkKLanwLMaSOcOzKhWMpvR/tKw+rE
   7U24ZZqJsPml7BlvUgEhqTea85Rlk4iVn9HATD3qooMtYwGp4uIJ2ldLc
   KQk9oSZZoo68dxF2mrQvgDCMRFof6uvbPQi+D2nlqhIp8eNwIj3QKScm1
   8j/78yZ8GUw9a4v1SB6OAQsERRmfjNXCTK72t5RephuEmlLiQtS5dI80F
   9xJPAYccvmZZq7uNKxv/zBnAW16qYVSjHdwloCFKmI/qq3pMQDTBn1rlE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="429144070"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="429144070"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 20:28:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="722230755"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="722230755"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.191.49]) ([10.252.191.49])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 20:28:19 -0700
Message-ID: <9875863a-eba5-c8fa-a39b-7d3300e3b5ca@linux.intel.com>
Date:   Fri, 14 Jul 2023 11:28:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@nvidia.com>,
        Will Deacon <will@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH v10 5/7] iommu/vt-d: Make prq draining code generic
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <20230712163355.3177511-1-jacob.jun.pan@linux.intel.com>
 <20230712163355.3177511-6-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB52761F5CDE22E5C3C10E7E728C37A@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52761F5CDE22E5C3C10E7E728C37A@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On 2023/7/13 15:49, Tian, Kevin wrote:
>> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Sent: Thursday, July 13, 2023 12:34 AM
>>
>> -	/* Domain type specific cleanup: */
>>   	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
>> -	if (domain) {
>> -		switch (domain->type) {
>> -		case IOMMU_DOMAIN_SVA:
>> -			intel_svm_remove_dev_pasid(dev, pasid);
>> -			break;
>> -		default:
>> -			/* should never reach here */
>> -			WARN_ON(1);
>> -			break;
>> -		}
>> +	if (!domain)
>> +		goto out_tear_down;
> 
> WARN_ON()

Why?

My understanding is that remve_device_pasid could be call in any context
including no domain attached.

> 
>>   		 * large and has to be physically contiguous. So it's
>>   		 * hard to be as defensive as we might like.
>>   		 */
>> -		intel_pasid_tear_down_entry(iommu, dev, svm->pasid,
>> false);
>> -		intel_svm_drain_prq(dev, svm->pasid);
> 
> after removing the 2 lines the comment above becomes stale.

Yes.

> 
>> -static void intel_svm_drain_prq(struct device *dev, u32 pasid)
>> +void intel_drain_pasid_prq(struct device *dev, u32 pasid)
>>   {
>>   	struct device_domain_info *info;
>>   	struct dmar_domain *domain;
> 
> later we should move generic prq handling logic out of svm.c into
> a new prq.c

Yes.

Best regards,
baolu
