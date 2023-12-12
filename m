Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574F180E38F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 06:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjLLFL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 00:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjLLFLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 00:11:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282B2CE;
        Mon, 11 Dec 2023 21:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702357921; x=1733893921;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/zUAzsErPK8Qs9uAvyrynqUtVON8UCLPxeGNKXurnzY=;
  b=Z2p+tJUrqlCPhzC0UOBB/cBUl+cxfrBxfLLOh7rwjlF8CJRm/Fdj4gsh
   pLnF/neD297txkFt0TE/etlMysEpKKUEkdJBAuTkKGsca+BlYTHCsgE6S
   DfNZSae8cDVCTOaTWHkVylTtvBs0lrJ4QCg+ZCiJ41vaMbKbVTZLLHAV9
   brYiIvRfBOheeFDmB9wagsT1aqJ8pOge1lb1rE7JjGcNRb4oiM1ML6K32
   JKcAdjIQxNHSFYon/t+LlBYQ8atKbSGX+1KpVYRmmuQJ6wAK/LDClDzuM
   v6MtzW1o9CNvwL8KGjhfb1SfN7RDTCCCA6ZTaoBOfEb3x+zyFe3GXm6oA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="391927274"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="391927274"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 21:12:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="839303421"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="839303421"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga008.fm.intel.com with ESMTP; 11 Dec 2023 21:11:57 -0800
Message-ID: <0f23e37a-5ace-492c-82e9-cf3d13f4ef6f@linux.intel.com>
Date:   Tue, 12 Dec 2023 13:07:17 +0800
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
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231211152456.GB1489931@ziepe.ca>
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

On 12/11/23 11:24 PM, Jason Gunthorpe wrote:
> On Thu, Dec 07, 2023 at 02:43:08PM +0800, Lu Baolu wrote:
>> @@ -217,12 +250,9 @@ int iommu_page_response(struct device *dev,
>>   	if (!ops->page_response)
>>   		return -ENODEV;
>>   
>> -	mutex_lock(&param->lock);
>> -	fault_param = param->fault_param;
>> -	if (!fault_param) {
>> -		mutex_unlock(&param->lock);
>> +	fault_param = iopf_get_dev_fault_param(dev);
>> +	if (!fault_param)
>>   		return -EINVAL;
>> -	}
> The refcounting should work by passing around the fault_param object,
> not re-obtaining it from the dev from a work.
> 
> The work should be locked to the iommu_fault_param that was active
> when the work was launched.
> 
> When we get to iommu_page_response it does this:
> 
> 	/* Only send response if there is a fault report pending */
> 	mutex_lock(&fault_param->lock);
> 	if (list_empty(&fault_param->faults)) {
> 		dev_warn_ratelimited(dev, "no pending PRQ, drop response\n");
> 		goto done_unlock;
> 	}
> 
> Which determines that the iommu_fault_param is stale and pending
> free..

Yes, agreed. The iopf_fault_param should be passed in together with the
iopf_group. The reference count should be released in the
iopf_free_group(). These two helps could look like below:

int iommu_page_response(struct iopf_group *group,
			struct iommu_page_response *msg)
{
	bool needs_pasid;
	int ret = -EINVAL;
	struct iopf_fault *evt;
	struct iommu_fault_page_request *prm;
	struct device *dev = group->fault_param->dev;
	const struct iommu_ops *ops = dev_iommu_ops(dev);
	bool has_pasid = msg->flags & IOMMU_PAGE_RESP_PASID_VALID;
	struct iommu_fault_param *fault_param = group->fault_param;

	if (!ops->page_response)
		return -ENODEV;

	/* Only send response if there is a fault report pending */
	mutex_lock(&fault_param->lock);
	if (list_empty(&fault_param->faults)) {
		dev_warn_ratelimited(dev, "no pending PRQ, drop response\n");
		goto done_unlock;
	}
	/*
	 * Check if we have a matching page request pending to respond,
	 * otherwise return -EINVAL
	 */
	list_for_each_entry(evt, &fault_param->faults, list) {
		prm = &evt->fault.prm;
		if (prm->grpid != msg->grpid)
			continue;

		/*
		 * If the PASID is required, the corresponding request is
		 * matched using the group ID, the PASID valid bit and the PASID
		 * value. Otherwise only the group ID matches request and
		 * response.
		 */
		needs_pasid = prm->flags & IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID;
		if (needs_pasid && (!has_pasid || msg->pasid != prm->pasid))
			continue;

		if (!needs_pasid && has_pasid) {
			/* No big deal, just clear it. */
			msg->flags &= ~IOMMU_PAGE_RESP_PASID_VALID;
			msg->pasid = 0;
		}

		ret = ops->page_response(dev, evt, msg);
		list_del(&evt->list);
		kfree(evt);
		break;
	}

done_unlock:
	mutex_unlock(&fault_param->lock);

	return ret;
}

...

void iopf_free_group(struct iopf_group *group)
{
	struct iopf_fault *iopf, *next;

	list_for_each_entry_safe(iopf, next, &group->faults, list) {
		if (!(iopf->fault.prm.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE))
			kfree(iopf);
	}

	/* Pair with iommu_report_device_fault(). */
	iopf_put_dev_fault_param(group->fault_param);
	kfree(group);
}

Best regards,
baolu
