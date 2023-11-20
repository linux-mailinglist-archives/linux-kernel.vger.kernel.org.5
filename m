Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CC67F0B5C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 05:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjKTEVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 23:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKTEVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 23:21:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9C4C5;
        Sun, 19 Nov 2023 20:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700454110; x=1731990110;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6v/qk6XILJ+EShe/DB479gTNTuB+ktH4JpqYg6NOK44=;
  b=Gri5v89c3emaAYFCIIK4RTwo7EropjZxTtjHnru0JhnqlzVbE0g4HQcQ
   WR/Ae3/x7mvbx3nzRe6uCNlJ+yB/yoexsIn19utS9RhS9Ho7zBGvOtDgq
   h6byLIlwaxHgMUyp6F7ljw8Fi+urVjDDWmztcDs8w9/2G6UIs731kkZ1S
   2Q9LA+WX32noRNyIMlILVymHAwEnwziTvFWD/bJlhdhh5qcFnVPxQSYOv
   f84dlK9qZ6smKg+vTEORGh+WgvWqBrAzXV2YF9B1lDtQGVykENmVd4SH4
   3zejx7Esva3aic3xH02xSGIoP9arljI6Zt2ViECa1GvxgBsvMZ1w0d1il
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="381939857"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="381939857"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 20:21:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="716104605"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="716104605"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga003.jf.intel.com with ESMTP; 19 Nov 2023 20:21:46 -0800
Message-ID: <c67754fc-9fff-43b4-82ce-078e71134815@linux.intel.com>
Date:   Mon, 20 Nov 2023 12:17:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        "Luo, Yuzhang" <yuzhang.luo@intel.com>,
        "Zhu, Tony" <tony.zhu@intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix incorrect cache invalidation for mm
 notification
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20231117090933.75267-1-baolu.lu@linux.intel.com>
 <BN9PR11MB52768C9149602718CD2EFC1B8CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52768C9149602718CD2EFC1B8CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/23 11:45 AM, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Friday, November 17, 2023 5:10 PM
>>
>> Commit 6bbd42e2df8f ("mmu_notifiers: call invalidate_range() when
>> invalidating TLBs") moved the secondary TLB invalidations into the TLB
>> invalidation functions to ensure that all secondary TLB invalidations
>> happen at the same time as the CPU invalidation and added a flush-all
>> type of secondary TLB invalidation for the batched mode, where a range
>> of [0, -1UL) is used to indicates that the range extends to the end of
>> the address space.
>>
>> However, using an end address of -1UL caused an overflow in the Intel
>> IOMMU driver, where the end address was rounded up to the next page.
>> As a result, both the IOTLB and device ATC were not invalidated correctly.
>>
>> Add a flush all helper function and call it when the invalidation range
>> is from 0 to -1UL, ensuring that the entire caches are invalidated
>> correctly.
>>
>> Fixes: 6bbd42e2df8f ("mmu_notifiers: call invalidate_range() when
>> invalidating TLBs")
>> Cc:stable@vger.kernel.org
>> Cc: Huang Ying<ying.huang@intel.com>
>> Cc: Alistair Popple<apopple@nvidia.com>
>> Tested-by: Luo Yuzhang<yuzhang.luo@intel.com>  # QAT
>> Tested-by: Tony Zhu<tony.zhu@intel.com>  # DSA
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/svm.c | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
>> index 50a481c895b8..588385050a07 100644
>> --- a/drivers/iommu/intel/svm.c
>> +++ b/drivers/iommu/intel/svm.c
>> @@ -216,6 +216,27 @@ static void intel_flush_svm_range(struct intel_svm
>> *svm, unsigned long address,
>>   	rcu_read_unlock();
>>   }
>>
>> +static void intel_flush_svm_all(struct intel_svm *svm)
>> +{
>> +	struct device_domain_info *info;
>> +	struct intel_svm_dev *sdev;
>> +
>> +	rcu_read_lock();
>> +	list_for_each_entry_rcu(sdev, &svm->devs, list) {
>> +		info = dev_iommu_priv_get(sdev->dev);
>> +
>> +		qi_flush_piotlb(sdev->iommu, sdev->did, svm->pasid, 0, -1UL,
>> 1);
> Why setting 'ih' to skip invalidating page structure caches?

It should be set to '0'. Good catch! Thank you!

Best regards,
baolu
