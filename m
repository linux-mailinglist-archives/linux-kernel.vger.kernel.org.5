Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56427B1758
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjI1J1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjI1J1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:27:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BDD75193
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:27:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F32F51FB;
        Thu, 28 Sep 2023 02:28:13 -0700 (PDT)
Received: from [10.57.0.224] (unknown [10.57.0.224])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AFD13F59C;
        Thu, 28 Sep 2023 02:27:34 -0700 (PDT)
Message-ID: <abdc07fb-f558-ae44-0226-a4c03909a3f4@arm.com>
Date:   Thu, 28 Sep 2023 10:27:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] iommu: Sanity check on param list for
 iommu_get_resv_regions
Content-Language: en-GB
To:     Dawei Li <set_pte_at@outlook.com>,
        Baolu Lu <baolu.lu@linux.intel.com>
Cc:     joro@8bytes.org, will@kernel.org, jgg@nvidia.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <TYTP286MB35645FDEF45FDFC91D35CE1ECAC2A@TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM>
 <7c7b8981-022c-2fa8-7ee5-9c97d8e17862@linux.intel.com>
 <TYTP286MB3564BA78F5ED7E8FE4DEEE93CAC1A@TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <TYTP286MB3564BA78F5ED7E8FE4DEEE93CAC1A@TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-28 09:57, Dawei Li wrote:
> Hi,
> Thanks for reviewing,
> 
> On Thu, Sep 28, 2023 at 09:33:29AM +0800, Baolu Lu wrote:
>> On 9/27/23 10:25 PM, Dawei Li wrote:
>>> In iommu_get_resv_regions(), param list is an argument supplied by caller,
>>> into which callee is supposed to insert resv regions.
>>>
>>> In other words, this 'list' argument is expected to be an empty list,
>>> so make an explicit annotation on it.
>>>
>>> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
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
>>
>> I don't understand why the input list *must* be empty. This interface

Yeah, the commit message really doesn't make much sense :(

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

If a caller would be confused by appending to a non-empty list then that 
caller should avoid passing a non-empty list. But that's not the API's 
problem; in general, appending to non-empty lists is absolutely a valid 
thing to do, it's kind of the point of using a list rather than, say, 
returning an array. It seems entirely reasonable that a caller might 
want to collect the reserved regions for multiple groups into a single 
list for its own convenience, and we have absolutely no reason to 
disallow that.

Note also that your arbitrary input vs. output argument rule 
fundamentally couldn't work for this API, since actual implementations 
of ops->get_resv_regions already *do* build up the list by passing it 
around multiple different helper APIs internally (look at the call path 
through arm_smmu_get_resv_regions(), for instance).

Thanks,
Robin.

>> has already been exported, so please update the comment to explain this
>> new requirement.
>>
>>> +
>>>    	if (ops->get_resv_regions)
>>>    		ops->get_resv_regions(dev, list);
>>>    }
>>
>> Best regards,
>> baolu
