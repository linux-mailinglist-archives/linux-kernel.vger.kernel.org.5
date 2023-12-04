Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187FA8029B7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 02:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjLDBCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 20:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjLDBCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 20:02:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEA1D7;
        Sun,  3 Dec 2023 17:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701651771; x=1733187771;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/HuHnYJELZ3s+Pg2jAz1DP57zcUQSq+bWviBQSQi96k=;
  b=N5E2+top27vVKlKN+wlezayPzxcBdEAwNHtWzvIr/M95ELBUyJTh9C6U
   A9UprC/b3x5zZSg1swvHjXUWxImOO+6a+AYezGGzRxk9vp7a+BehlYga0
   qQOBsuk69nPzxdIOfQeHkjnoUjpSpjTVg74dpOb5et8HhOf75J3PL4Oaz
   LltmuQJf++RnBXLrBrMVE/bW3qArVAIK/CDUxMZdW3YxmeILM5w3UFPSe
   Xu7pGwIBT/+YCyw1ihC1i20Rlq36rSEdFqnSEbMUln0v1BFQKcK4my3yL
   jTAUzA/9e3t7Q30VLmI0EJ99HqR3v3pP1yPJG5By4nWZJyV2matHmf2G0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="424834469"
X-IronPort-AV: E=Sophos;i="6.04,248,1695711600"; 
   d="scan'208";a="424834469"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 17:02:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="774101136"
X-IronPort-AV: E=Sophos;i="6.04,248,1695711600"; 
   d="scan'208";a="774101136"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga007.fm.intel.com with ESMTP; 03 Dec 2023 17:02:39 -0800
Message-ID: <1b82e10f-bf5c-4fca-b558-ce2e4fe9f128@linux.intel.com>
Date:   Mon, 4 Dec 2023 08:58:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 11/12] iommu: Consolidate per-device fault data
 management
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
References: <20231115030226.16700-1-baolu.lu@linux.intel.com>
 <20231115030226.16700-12-baolu.lu@linux.intel.com>
 <20231201194602.GF1489931@ziepe.ca>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231201194602.GF1489931@ziepe.ca>
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

On 12/2/23 3:46 AM, Jason Gunthorpe wrote:
> On Wed, Nov 15, 2023 at 11:02:25AM +0800, Lu Baolu wrote:
> 
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index d19031c1b0e6..c17d5979d70d 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -597,6 +597,8 @@ struct iommu_device {
>>   /**
>>    * struct iommu_fault_param - per-device IOMMU fault data
>>    * @lock: protect pending faults list
>> + * @users: user counter to manage the lifetime of the data, this field
>> + *         is protected by dev->iommu->lock.
>>    * @dev: the device that owns this param
>>    * @queue: IOPF queue
>>    * @queue_list: index into queue->devices
>> @@ -606,6 +608,7 @@ struct iommu_device {
>>    */
>>   struct iommu_fault_param {
>>   	struct mutex lock;
>> +	int users;
> 
> Use refcount_t for the debugging features

Yes.

> 
>>   	struct device *dev;
>>   	struct iopf_queue *queue;
> 
> But why do we need this to be refcounted? iopf_queue_remove_device()
> is always called before we get to release? This struct isn't very big
> so I'd just leave it allocated and free it during release?

iopf_queue_remove_device() should always be called before device
release.

The reference counter is implemented to synchronize access to the fault
parameter among different paths. For example, iopf_queue_remove_device()
removes the parameter, while iommu_report_device_fault() and
iommu_page_response() have needs to reference it. These three paths
could possibly happen in different threads.

> 
>> @@ -72,23 +115,14 @@ static int iommu_handle_iopf(struct iommu_fault *fault, struct device *dev)
>>   	struct iopf_group *group;
>>   	struct iopf_fault *iopf, *next;
>>   	struct iommu_domain *domain = NULL;
>> -	struct iommu_fault_param *iopf_param;
>> -	struct dev_iommu *param = dev->iommu;
>> +	struct iommu_fault_param *iopf_param = dev->iommu->fault_param;
>>   
>> -	lockdep_assert_held(&param->lock);
>> +	lockdep_assert_held(&iopf_param->lock);
> 
> This patch seems like it is doing a few things, can the locking
> changes be kept in their own patch?

Yes. Let me try to.

Best regards,
baolu
