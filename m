Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5887B8662
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243394AbjJDRXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjJDRXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:23:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B181A7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 10:23:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52487C15;
        Wed,  4 Oct 2023 10:23:50 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC45C3F59C;
        Wed,  4 Oct 2023 10:23:10 -0700 (PDT)
Message-ID: <08de017f-80b1-8374-ab0e-2eaebe037b86@arm.com>
Date:   Wed, 4 Oct 2023 18:23:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 4/7] iommu: Switch __iommu_domain_alloc() to device ops
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org
References: <cover.1696253096.git.robin.murphy@arm.com>
 <458dd0ed839541693a49da33239b33cf4c48b8ec.1696253096.git.robin.murphy@arm.com>
 <20231002141615.GA650249@nvidia.com>
 <a4078085-4061-2b52-daba-1cd642f0cf9d@arm.com>
 <20231002193609.GB650762@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231002193609.GB650762@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2023 8:36 pm, Jason Gunthorpe wrote:
> On Mon, Oct 02, 2023 at 08:02:23PM +0100, Robin Murphy wrote:
>> On 02/10/2023 3:16 pm, Jason Gunthorpe wrote:
>>> On Mon, Oct 02, 2023 at 02:49:12PM +0100, Robin Murphy wrote:
>>>> @@ -2120,20 +2120,30 @@ static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
>>>>    	return domain;
>>>>    }
>>>> -static struct iommu_domain *
>>>> -__iommu_group_domain_alloc(struct iommu_group *group, unsigned int type)
>>>> +static int __iommu_domain_alloc_dev(struct device *dev, void *data)
>>>>    {
>>>
>>> Why?
>>
>> Because out of 3 callsites, two were in a context which now needed to
>> make the iommu_group_first_dev() call itself anyway,
> 
> I don't see it. Why not just do this?
> 
> static int __iommu_domain_alloc_dev(struct device *dev, void *data)
> {
> 	/* FIXME: This is not correctly locked */
> 	struct iommu_group *group = iommu_group_get(dev);
> 	struct group **alloc_group = data;
> 
> 	if (!group)
> 		return 0;
> 
> 	mutex_lock(&group->mutex);
> 	/* Theoretically we could have raced against release */
> 	if (list_empty(&group->devices)) {
> 		mutex_unlock(&group->mutex);
> 		iommu_group_put(group);
> 		return 0;
> 	}
> 
> 	*alloc_group = group;
> 	return 1;
> }
> 
> struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
> {
> 	struct iommu_group *alloc_group;
> 	struct iommu_domain *dom;
> 
> 	/* Only one driver is supported with this interface */
> 	if (WARN_ON(iommu_num_drivers > 1))
> 		return NULL;
> 
> 	bus_for_each_dev(bus, NULL, &alloc_group, __iommu_domain_alloc_dev);
> 	if (!alloc_group)
> 		return NULL;
> 	dom = __iommu_group_domain_alloc(alloc_group, IOMMU_DOMAIN_UNMANAGED);
> 	mutex_unlock(&alloc_group->mutex);
> 	iommu_group_put(alloc_group);
> 	return dom;
> }
> EXPORT_SYMBOL_GPL(iommu_domain_alloc);
> 
> (and ++/-- iommu_num_drivers in iommu_device_register)
> 
> One patch, it's pretty easy???

Sure, that would then leave two callsites for 
__iommu_group_domain_alloc(), which might in turn justify leaving it 
factored out, but the endgame is to get a device to resolve 
dev_iommu_ops(), so if we're starting with a suitable device in hand 
then using its group to immediately re-derive a device again when we 
*could* trivially pass the device straight through is silly and 
overcomplicated.

However it turns out that we can't easily touch the group here at all 
without then needing dependent changes in VFIO, so rather than invite 
any more scope creep at this point I'm going to respin this as a purely 
sideways step that sticks to resolving ops from a bus, and save any 
further device/instance niceties for step 2 when I have to touch all the 
external callers anyway.

>> Um... Good? I mean in 3/4 cases it's literally the exact same code just
>> factored out again, while the one I've added picks some arbitrary device
>> in a different way.
> 
> Sure, but the whole point was to make it obvious that there was no
> direct linkage from the various dev parameters we have in places and
> what dev will be passed by the driver.

But that's the argument that makes no sense - it happens to be the case 
in the current code that all default domain allocation sites are already 
buried in several layers worth of group-based machinery, but that in 
itself holds no significance to the allocation process. I maintain that 
it is simply misleading to pretend that (taking a little artistic 
license with types) a round trip through 
dev->iommu_group->devices->next->dev->iommu holds any significance over 
just dev->iommu. There's hardly anything "obvious" about it either - 
it's buried in core code that driver authors have little reason to even 
look at.

If I'm implementing a driver, I'm going to see the signature of the op I 
need to implement, which tells me to allocate a domain and gives me a 
device to allocate it for, and for reference I'm going to look at how 
other drivers implement that op. I would not start by picking through 
the core code for the callers of the caller of that op, to see some 
weird code that looks redundant when in practice I observe it resolving 
a device back to itself, and think "ah yes, now I see the undocumented 
significance of an idea that only existed in Jason's head". If you don't 
want an IOMMU driver to be able to think the particular device is 
important, don't pass a bloody device! If the only intended purpose is 
for the driver to resolve dev->iommu instance data, then have the core 
do that and just pass the dev_iommu or iommu_dev directly; ambiguity solved.

If one is expected to look at subtleties 2 or 3 levels down the 
callchain of an API in order to understand how to implement that API 
correctly, that is *a badly designed API*, and piling on more 
"correctness theatre" code to attempt to highlight the bad design does 
not address the real problem there.

> Everything passes through
> __iommu_group_domain_alloc() and at the end of the day that should be
> the only allocation API.

But *why* should it? What's inherently more special about a group vs. a 
device or an IOMMU instance (especially with those being the things 
drivers actually deal with in relation to domains)?

If you've noticed, between here and patch #3 I already end up 
effectively enforcing that devices in the same group must have identical 
device ops - that's arguably an even stronger requirement than we need, 
but it fits the current drivers so we may as well not relax it until 
proven necessary. So AFAICS the problem you're desperate to address is a 
theoretical one of a driver author going out of their way to implement a 
single .domain_alloc_paging implementation badly, in a way which would 
only affect the behaviour of that driver, and should be easy to spot in 
patch review anyway. Any complexity in core code in an attempt to make 
any difference to that seems about as worthwhile as trying to hold back 
the tide.

Thanks,
Robin.
