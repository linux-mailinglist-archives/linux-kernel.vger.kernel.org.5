Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9158053E6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbjLEMNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjLEMNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:13:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBF2C3;
        Tue,  5 Dec 2023 04:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701778423; x=1733314423;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MYqOhIpAjG+tcFzzzvBDM/zAZxf8GMMLxtt+rsWwboM=;
  b=mDzI3Y7+SHNcFAaOAh9VsrFA3QixVH53hJ0F4PjAEktSYOCK8Y4dTM4c
   yk8fv2NF3FRjGqa1qN0XgYfPWg4x5O3nTGl6t240YfTzLLkgX994VqZnH
   kf8kWU6Vozc6AT2ihbggsuex5BJkeZUMimuh6w+zyEu4zii2M6o3XQmid
   3OVWxBU0OmRg4k4n5zxdJf9Sk4AVvIh9Cwv7Eq+rsiEYhWjh9qtHintY7
   lwHZr/pvVq1WMDh6u2rmyETjw29uJNQ0Qtl1NFuvx/9FlGM7OpcEJ57PV
   XCnrLG1eZ4vG1C6ZSk9QlLIIYH9DPWnvlVAsXEL+naaP76buw7a/KE5u7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="378910566"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="378910566"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 04:13:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="12315536"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.31.68]) ([10.255.31.68])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 04:13:40 -0800
Message-ID: <dfb350c8-b3e3-48ad-86b3-201205521153@linux.intel.com>
Date:   Tue, 5 Dec 2023 20:13:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 09/12] iommu: Make iommu_queue_iopf() more generic
Content-Language: en-US
To:     Yi Liu <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <20231115030226.16700-1-baolu.lu@linux.intel.com>
 <20231115030226.16700-10-baolu.lu@linux.intel.com>
 <e18c7c93-7184-4bbc-97cd-61fc0bc0aa3d@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <e18c7c93-7184-4bbc-97cd-61fc0bc0aa3d@intel.com>
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

On 2023/12/5 15:13, Yi Liu wrote:
>> @@ -157,8 +173,8 @@ int iommu_queue_iopf(struct iommu_fault *fault, 
>> struct device *dev)
>>       group->dev = dev;
>>       group->last_fault.fault = *fault;
>>       INIT_LIST_HEAD(&group->faults);
>> +    group->domain = domain;
>>       list_add(&group->last_fault.list, &group->faults);
>> -    INIT_WORK(&group->work, iopf_handler);
>>       /* See if we have partial faults for this group */
>>       list_for_each_entry_safe(iopf, next, &iopf_param->partial, list) {
>> @@ -167,9 +183,13 @@ int iommu_queue_iopf(struct iommu_fault *fault, 
>> struct device *dev)
>>               list_move(&iopf->list, &group->faults);
>>       }
>> -    queue_work(iopf_param->queue->wq, &group->work);
>> -    return 0;
>> +    mutex_unlock(&iopf_param->lock);
>> +    ret = domain->iopf_handler(group);
>> +    mutex_lock(&iopf_param->lock);
> 
> After this change, this function (iommu_queue_iopf) does not queue
> anything. Should this function be renamed? Except this, I didn't see
> other problem.

It's renamed in the next patch.

> 
> Reviewed-by:Yi Liu <yi.l.liu@intel.com>

Thank you!

Best regards,
baolu
