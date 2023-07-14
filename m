Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DA67531B0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbjGNGCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbjGNGC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:02:29 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8A5271F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 23:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689314548; x=1720850548;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1id4JB2ckUipK8/ncHOfr/CgvJHLeGE2BCfOa/y4afM=;
  b=AazNPU6xmu0+gIuBnYgMGGfNdkJy4guBst7NerOFS1ojmD1DNtscVm8G
   Ju7/OTncHNOFDi5TANPiwRIksmLQ41bhnkUGF2q5zI/PZNuPYIVGS43V9
   NY+f/XjsOBAkavZ+ipSeKx6ULpkGOP5EUzwv7yd533V5Qxhqln/InM0Ko
   N0Wzp/Q2lOb7uw/cFl9gNOGjMgWO4ZC3XZdIIuWBJXKoDGw0SVh8UrFjd
   EFvzFUk9wrP4UF41Zu0TWYpcNR2TAQYDdj4OUsMEatB3oLFKUXBW78YHF
   0Ulp/KLYBnF3qvVvrWXe5nzvYl/c2WSFBT1MD66/6BbQHs4Q4uZXLjO39
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="431570384"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="431570384"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 23:02:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="751920849"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="751920849"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.187.116]) ([10.252.187.116])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 23:02:23 -0700
Message-ID: <2753b770-564a-b141-1505-94f08016abc5@linux.intel.com>
Date:   Fri, 14 Jul 2023 14:02:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@nvidia.com>,
        Will Deacon <will@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH v10 3/7] iommu/vt-d: Add domain_flush_pasid_iotlb()
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <20230712163355.3177511-1-jacob.jun.pan@linux.intel.com>
 <20230712163355.3177511-4-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB5276EC6A22D3A3C9DE1C46678C37A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <d89755de-bb7a-ee23-f308-2500aad81120@linux.intel.com>
 <BN9PR11MB5276DBFD837A82AF61DF00D28C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276DBFD837A82AF61DF00D28C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On 2023/7/14 11:51, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Friday, July 14, 2023 11:37 AM
>>
>> On 2023/7/13 15:52, Tian, Kevin wrote:
>>>> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>>> Sent: Thursday, July 13, 2023 12:34 AM
>>>> +static void domain_flush_pasid_iotlb(struct intel_iommu *iommu,
>>>> +				     struct dmar_domain *domain, u64 addr,
>>>> +				     unsigned long npages, bool ih)
>>>> +{
>>>> +	u16 did = domain_id_iommu(domain, iommu);
>>>> +	unsigned long flags;
>>>> +
>>>> +	spin_lock_irqsave(&domain->lock, flags);
>>>> +	if (!list_empty(&domain->devices))
>>>> +		qi_flush_piotlb(iommu, did, IOMMU_NO_PASID, addr,
>>>> npages, ih);
>>>> +	spin_unlock_irqrestore(&domain->lock, flags);
>>>
>>> btw I gave a comment before that the check of list_empty() changes
>>> the semantics instead of just creating a helper.
>>>
>>> If it's the right thing to do please split it into a separate fix patch.
>>
>> Perhaps move it into patch 6?
>>
> 
> I still prefer to putting it in a separate patch since it changes the
> behavior in existing path. It's not really about dev_pasid which
> patch6 is trying to support.

Okay, that will also be fine to me.

Best regards,
baolu
