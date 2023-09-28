Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046D17B1747
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjI1JZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbjI1JZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:25:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCC81AB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695893107; x=1727429107;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R2aE8j4JYfqblhnvS1c2OlVELJZE0JvEb7YhQhBXfYs=;
  b=cMa9fL5fVQnIn6ZdHB3maWHjAXm0mv7+5R1W6w4SGDfv10W1uToB8RH+
   GxLGOOgpvVGjfNZv70tq4cqqkJ/ALTQ0iSDjK6p8ugaSINu3H+xf9BOvT
   yZHta4BjTdlg4OjIE4bxgXuxDLYYSqyGXnqN/+9PM94UcP31A3M0G2b3h
   oMUyT8FylfGsb2vw1eKtNZsBhvBwbVq4xkEt68ceSSydxY+Q2RqvETcb4
   a4VMfs396CM+HspyQx7Eme/Bms5mJ0eBbCNet1eSv5Bu7pNt8TDJF+mt9
   w8CEFaU795hl26H88rC+lKlzC35ouyiHoGz18+6+YCbdvdh3dSRO7Ol2H
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="384818207"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="384818207"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 02:25:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="726169101"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="726169101"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.215.143]) ([10.254.215.143])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 02:25:04 -0700
Message-ID: <d009b69d-fd70-97dc-eb32-b61e1e5c606c@linux.intel.com>
Date:   Thu, 28 Sep 2023 17:25:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc:     baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Sanity check on param list for
 iommu_get_resv_regions
Content-Language: en-US
To:     Dawei Li <set_pte_at@outlook.com>
References: <TYTP286MB35645FDEF45FDFC91D35CE1ECAC2A@TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM>
 <7c7b8981-022c-2fa8-7ee5-9c97d8e17862@linux.intel.com>
 <TYTP286MB3564BA78F5ED7E8FE4DEEE93CAC1A@TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <TYTP286MB3564BA78F5ED7E8FE4DEEE93CAC1A@TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/28 16:57, Dawei Li wrote:
> On Thu, Sep 28, 2023 at 09:33:29AM +0800, Baolu Lu wrote:
>> On 9/27/23 10:25 PM, Dawei Li wrote:
>>> In iommu_get_resv_regions(), param list is an argument supplied by caller,
>>> into which callee is supposed to insert resv regions.
>>>
>>> In other words, this 'list' argument is expected to be an empty list,
>>> so make an explicit annotation on it.
>>>
>>> Signed-off-by: Dawei Li<set_pte_at@outlook.com>
>>> ---
>>>    drivers/iommu/iommu.c | 9 +++++----
>>>    1 file changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index 1ecac2b5c54f..a01c4a7a9d19 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -813,7 +813,7 @@ int iommu_get_group_resv_regions(struct iommu_group *group,
>>>    	mutex_lock(&group->mutex);
>>>    	for_each_group_device(group, device) {
>>> -		struct list_head dev_resv_regions;
>>> +		LIST_HEAD(dev_resv_regions);
>>>    		/*
>>>    		 * Non-API groups still expose reserved_regions in sysfs,
>>> @@ -822,7 +822,6 @@ int iommu_get_group_resv_regions(struct iommu_group *group,
>>>    		if (!device->dev->iommu)
>>>    			break;
>>> -		INIT_LIST_HEAD(&dev_resv_regions);
>>>    		iommu_get_resv_regions(device->dev, &dev_resv_regions);
>>>    		ret = iommu_insert_device_resv_regions(&dev_resv_regions, head);
>>>    		iommu_put_resv_regions(device->dev, &dev_resv_regions);
>>> @@ -1061,12 +1060,11 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
>>>    					       struct device *dev)
>>>    {
>>>    	struct iommu_resv_region *entry;
>>> -	struct list_head mappings;
>>>    	unsigned long pg_size;
>>> +	LIST_HEAD(mappings);
>>>    	int ret = 0;
>>>    	pg_size = domain->pgsize_bitmap ? 1UL << __ffs(domain->pgsize_bitmap) : 0;
>>> -	INIT_LIST_HEAD(&mappings);
>>>    	if (WARN_ON_ONCE(iommu_is_dma_domain(domain) && !pg_size))
>>>    		return -EINVAL;
>>> @@ -2813,6 +2811,9 @@ void iommu_get_resv_regions(struct device *dev, struct list_head *list)
>>>    {
>>>    	const struct iommu_ops *ops = dev_iommu_ops(dev);
>>> +	if (WARN_ON(!list_empty(list)))
>>> +		return;
>> I don't understand why the input list*must*  be empty. This interface
> Because @list is an output-only argument, which is supposed to be filled
> by caller(inserting elements into it). If it's not empty, it's an inputing
> argument, in which case caller will take existing node (in @list) into account,
> and insert new nodes before/after them.
> Please lemme put it another way, if list argment is not empty:
> 
> Before calling:
> list: head->A
> 
> After calling
> list: head->A->B->C
> 
> It will confuse caller cuz it can't tell whether A is a valid returned
> by callee.

I see. Thank you for the explanation.

Best regards,
baolu

