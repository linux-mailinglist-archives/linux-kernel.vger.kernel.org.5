Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8658053DE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442396AbjLEL4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442195AbjLELzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:55:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D0198;
        Tue,  5 Dec 2023 03:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701777349; x=1733313349;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e3cGY29NO2TW5wcDKR/uxU5ISJOcURe7TpDGtZtP95Q=;
  b=MDAr5BS1LPykCRcsIlmHFRzoII+yWmkZXlJBlSM6cY2+hnTpZ/gTsKL/
   HXZlsNaUnrreZOW3BIGqJlm9CN0zo4xDbkmauIidS9+NWiOfKp25UVYxw
   lcs/SVl/pGKONKUWqmL2KuMSsZ2GLbzgp1n/ueWONHaw0H/WiPjKQU3He
   3sB/2lGX08vaZlwW/EgcpBNmRFPzhl30sUVo5BsGi3ko111uBL3F7eOEn
   OkppWhKUp3cM8Y/3NNUJdIsvWZXaZjcyynIx0uSSRJEqkM7WJ5FPcxT69
   4k1qmI4JPPFjedWAmuJrdMsqpreoG5Ovs4304Jx7E98BuxLybAXjNq7B7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="7180384"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="7180384"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 03:55:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="861717965"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="861717965"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.31.68]) ([10.255.31.68])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 03:55:42 -0800
Message-ID: <fb4b2617-4b8e-4f83-84c6-c5523591803f@linux.intel.com>
Date:   Tue, 5 Dec 2023 19:55:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v7 03/12] iommu: Remove unrecoverable fault data
Content-Language: en-US
To:     Yi Liu <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <20231115030226.16700-1-baolu.lu@linux.intel.com>
 <20231115030226.16700-4-baolu.lu@linux.intel.com>
 <50b9684c-e018-4e1c-9aac-67e0ffd9bc27@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <50b9684c-e018-4e1c-9aac-67e0ffd9bc27@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/12/4 18:58, Yi Liu wrote:
> On 2023/11/15 11:02, Lu Baolu wrote:
>> The unrecoverable fault data is not used anywhere. Remove it to avoid
>> dead code.
>>
>> Suggested-by: Kevin Tian <kevin.tian@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>> ---
>>   include/linux/iommu.h | 70 +------------------------------------------
>>   1 file changed, 1 insertion(+), 69 deletions(-)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index c2e2225184cf..81eee1afec72 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -50,69 +50,9 @@ struct iommu_dma_cookie;
>>   /* Generic fault types, can be expanded IRQ remapping fault */
>>   enum iommu_fault_type {
>> -    IOMMU_FAULT_DMA_UNRECOV = 1,    /* unrecoverable fault */
>>       IOMMU_FAULT_PAGE_REQ,        /* page request fault */
> 
> a nit, do you kno why this enum was starting from 1? Should it still
> start from 1 after deleting UNRECOV?

As Jason suggested in another thread, we will address this issue in
another thread. I am not sure for now whether we will remove the fault
type field or re-use the previous scheme.

Best regards,
baolu
