Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964F3810830
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 03:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378306AbjLMCYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 21:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378272AbjLMCY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 21:24:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315E4A0;
        Tue, 12 Dec 2023 18:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702434275; x=1733970275;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MtTjxsnnk6REyd91XRIZZp4F4yr33L++gpip89sPY0A=;
  b=ffmd5gM4o41ZcLDRbg2QrXmAIsknGO5lGlyMHM5KmNfj+FROUXqh3wjy
   3CcUP3eAo3ftiLcGEHBkpGdcXKAUMLrStPQ/c4PG/cH89reKAtohxU7lc
   hGMpI15mb+xn0/VEknSd/YB6s7oMwAFiAU98a762lXN9eg3iZMe4AeNQd
   9nkqG6nEwCYXEVJjRIj3QBuqcv6G61V8qcVmCAvdRawU3xy6aTA6ilBzt
   WJ9D8aCfRVQVluwAIWwfhKHmBI2ibfRDZiMAHNfFx8c5EW+FDTSQvQSme
   vqQ7j2Q+5yReGZ2FrMx4dSY25L+VWw1j3LZk187e5ZxgtdXVb2jy6T/Ds
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="461377483"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="461377483"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 18:24:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="723468294"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="723468294"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga003.jf.intel.com with ESMTP; 12 Dec 2023 18:24:13 -0800
Message-ID: <cfc8cc32-8c62-440d-946f-69cd855fedaf@linux.intel.com>
Date:   Wed, 13 Dec 2023 10:19:32 +0800
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
        Longfang Liu <liulongfang@huawei.com>,
        Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 12/12] iommu: Use refcount for fault data access
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
References: <20231207064308.313316-1-baolu.lu@linux.intel.com>
 <20231207064308.313316-13-baolu.lu@linux.intel.com>
 <20231211152456.GB1489931@ziepe.ca>
 <0f23e37a-5ace-492c-82e9-cf3d13f4ef6f@linux.intel.com>
 <20231212151809.GD3013885@ziepe.ca>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231212151809.GD3013885@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/23 11:18 PM, Jason Gunthorpe wrote:
> On Tue, Dec 12, 2023 at 01:07:17PM +0800, Baolu Lu wrote:
> 
>> Yes, agreed. The iopf_fault_param should be passed in together with the
>> iopf_group. The reference count should be released in the
>> iopf_free_group(). These two helps could look like below:
>>
>> int iommu_page_response(struct iopf_group *group,
>> 			struct iommu_page_response *msg)
>> {
>> 	bool needs_pasid;
>> 	int ret = -EINVAL;
>> 	struct iopf_fault *evt;
>> 	struct iommu_fault_page_request *prm;
>> 	struct device *dev = group->fault_param->dev;
>> 	const struct iommu_ops *ops = dev_iommu_ops(dev);
>> 	bool has_pasid = msg->flags & IOMMU_PAGE_RESP_PASID_VALID;
>> 	struct iommu_fault_param *fault_param = group->fault_param;
>>
>> 	if (!ops->page_response)
>> 		return -ENODEV;
> 
> We should never get here if this is the case, prevent the device from
> being added in the first place

Yeah, could move it to iopf_queue_add_device(). WARN and return failure
there if the driver is not ready for page request handling.

> 
>> 	/* Only send response if there is a fault report pending */
>> 	mutex_lock(&fault_param->lock);
>> 	if (list_empty(&fault_param->faults)) {
>> 		dev_warn_ratelimited(dev, "no pending PRQ, drop response\n");
>> 		goto done_unlock;
>> 	}
>> 	/*
>> 	 * Check if we have a matching page request pending to respond,
>> 	 * otherwise return -EINVAL
>> 	 */
>> 	list_for_each_entry(evt, &fault_param->faults, list) {
>> 		prm = &evt->fault.prm;
>> 		if (prm->grpid != msg->grpid)
>> 			continue;
>>
>> 		/*
>> 		 * If the PASID is required, the corresponding request is
>> 		 * matched using the group ID, the PASID valid bit and the PASID
>> 		 * value. Otherwise only the group ID matches request and
>> 		 * response.
>> 		 */
>> 		needs_pasid = prm->flags & IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID;
>> 		if (needs_pasid && (!has_pasid || msg->pasid != prm->pasid))
>> 			continue;
>>
>> 		if (!needs_pasid && has_pasid) {
>> 			/* No big deal, just clear it. */
>> 			msg->flags &= ~IOMMU_PAGE_RESP_PASID_VALID;
>> 			msg->pasid = 0;
>> 		}
>>
>> 		ret = ops->page_response(dev, evt, msg);
>> 		list_del(&evt->list);
>> 		kfree(evt);
>> 		break;
>> 	}
>>
>> done_unlock:
>> 	mutex_unlock(&fault_param->lock);
> 
> I would have expected the group to free'd here? But regardless this
> looks like a good direction

Both work for me. We can decide it according to the needs of code later.

> 
> Jason

Best regards,
baolu
