Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0136776197
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjHINsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjHINsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:48:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05DDE1982
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 06:48:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F38DD75;
        Wed,  9 Aug 2023 06:49:21 -0700 (PDT)
Received: from [10.57.4.174] (unknown [10.57.4.174])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B33813F59C;
        Wed,  9 Aug 2023 06:48:36 -0700 (PDT)
Message-ID: <280d0be7-7d41-ed78-bf4b-3db6c0076e22@arm.com>
Date:   Wed, 9 Aug 2023 14:48:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/1] iommu/arm-smmu-v3: Fix error case of range command
To:     zhurui <zhurui3@huawei.com>, Will Deacon <will@kernel.org>
Cc:     Nicolin Chen <nicolinc@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Tomas Krcka <krckatom@amazon.de>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <1690784482-30028-1-git-send-email-wangwudi@hisilicon.com>
 <20230801085504.GA26130@willie-the-truck>
 <27c895b8-1fb0-be88-8bc3-878d754684c8@huawei.com>
 <d5fc1f72-7428-4fef-d868-d06b85add635@huawei.com>
 <20230804165225.GF30679@willie-the-truck> <ZM1DqxXcBT2SOs8/@Asurada-Nvidia>
 <015b4573-9d74-451b-8028-a1050ade7019@huawei.com>
 <661a7bb5-99e1-de16-d860-0cd17f7a0470@arm.com>
 <20230808162409.GB2890@willie-the-truck>
 <80ead8ee-4dbe-7b3c-44f5-944073a2a39d@arm.com>
 <412886be-644a-5b46-9bfa-1c9a358f9a5d@huawei.com>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <412886be-644a-5b46-9bfa-1c9a358f9a5d@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-09 10:22, zhurui wrote:
> On 2023/8/9 0:43, Robin Murphy wrote:
>> On 08/08/2023 5:24 pm, Will Deacon wrote:
>>> Hi Robin,
>>>
>>> On Mon, Aug 07, 2023 at 08:20:45PM +0100, Robin Murphy wrote:
>>>> On 2023-08-06 06:28, zhurui wrote:
>>>>> On 2023/8/5 2:30, Nicolin Chen wrote:
>>>>>> On Fri, Aug 04, 2023 at 05:52:25PM +0100, Will Deacon wrote:
>>>>>>> On Fri, Aug 04, 2023 at 05:31:20PM +0800, zhurui wrote:
>>>>>>>> When tg != 0 but ttl, scale, num all 0 in a range tlbi command, it
>>>>>>>> is reserved and will cause the CERROR_ILL error. This case means
>>>>>>>> that the size to be invalidated is only one page size, and the
>>>>>>>> range invalidation is meaningless here. So we set tg to 0 in this
>>>>>>>> case to do an non-range invalidation instead.
>>>>>>
>>>>>>>> @@ -1930,6 +1927,12 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
>>>>>>>>                            num = (num_pages >> scale) & CMDQ_TLBI_RANGE_NUM_MAX;
>>>>>>>>                            cmd->tlbi.num = num - 1;
>>>>>>>>
>>>>>>>> +                       /* Prevent error caused by one page tlbi with leaf 0 */
>>>>>>>> +                       if (scale == 0 && num == 1 && cmd->tlbi.leaf == 0)
>>>>>>>> +                               cmd->tlbi.tg = 0;
>>>>>>>
>>>>>>> This should only be true for the last iteration, right (i.e. when num_pages
>>>>>>> == 1)? In which case, I'd prefer to leave the old code as-is and just add:
>>>>>>>
>>>>>>>            /* Single-page leaf invalidation requires a TG field of 0 */
>>>>>>>            if (num_pages == 1 && !cmd->tlbi.leaf)
>>>>>>>                    cmd->tlbi.tg = 0;To Will and Nicolin,
>>>>>
>>>>> Not only the last iteration, it's the result of __ffs function. For example, if
>>>>> numpages is 33, then the value of __ffs(num_pages) is 0, so the value of scale
>>>>> is also 0. The value of num depends on CMDQ_TLBI_RANGE_NUM_MAX. That is, the
>>>>> maximum value of num is 31. Therefore, the final value of num is 1.
>>>>> So, if consider CMDQ_TLBI_RANGE_NUM_MAX, there will be some case not the last
>>>>> one page but the beginning pages. That's why I use scale and num as conditions,
>>>>> not num_pages. Then I should reassign tg based on the result.
>>>>
>>>> Yeah, I'd rather not downgrade to a non-range invalidate since that
>>>> complicates the reasoning for the errata affecting those. If the size of the
>>>> invalidation is equal to TG then it can only represent a single last-level
>>>> page, i.e. TTL=3, thus if it does warrant handling here then indeed
>>>> rearranging to base the condition on num_pages as well ought to suffice.
>>>> However, this is all still begging the question of where and why we're doing
>>>> a *non-leaf* invalidation that isn't aligned to the size of a table, because
>>>> that in itself doesn't make a whole heap of sense - my hunch is that that
>>>> wants figuring out and could probably be fixed at the source.
>>>
>>> Isn't that described above because we're using CMDQ_TLBI_RANGE_NUM_MAX
>>> to break up the range into separate commands?
>>
>> Not really, because if we're doing a genuine non-leaf invalidation of a table then it should be a block-aligned range that ought to fit in a single command and should certainly never involve a single-granule remainder. If we're doing non-leaf invalidations of things that logically don't need to be non-leaf, making them leaf would be the even better option.
>>
> 
> I agree with Robin that if the caller is doing a genuine non-leaf invalidation
> of a table, it should not involve a single-granule tlbi. It seems that the
> caller only filter the block size, but not the address aligned or not maybe.

Oh, did you hit this with SVA by any chance? AFAICS the only place
io-pgtable can cause a non-leaf invalidation is from tlb_flush_walk,
which absolutely should be table-aligned, but then there is another path
from arm_smmu_mm_invalidate_range(), where I guess we use non-leaf
unconditionally because the MMU notifier doesn't have visibility of
exactly how the pagetable structure may have changed. However, by the
same token that path really does actually need my fix, since it's also
hard-coding PAGE_SIZE as the invalidation granule. I was saying it's a
largely theoretical issue from the io-pgtable point of view, since the
chance of unmapping a level 1 table full of level 2 block entries via
the IOMMU API is minimal (other than cases like VFIO teardown where
precise invalidation doesn't matter since the whole domain is about to
be destroyed anyway), but in this SVA path which I hadn't considered
before, I think it means that unmapping *any* block entry may not be
invalidated correctly, and unmapping blocks in general is definitely
something that processes can and will do :(

>>> Do you mind if I queue the patch as-is for now? I don't think the driver
>>> should be emitting illegal commands, and v2 of the patch does seem like
>>> the obvious thing to do.
>>
>> TBH I'd rather you just drop my patch if it's proven problematic, and I'll take another crack at it soon. The potential problems we introduce by using non-range invalidates on errata-affected MMU-700 revisions are worse than the almost-entirely-theoretical one I was trying to address.

Does the patch below work for you?

Thanks,
Robin.

----->8-----
Subject: [PATCH] iommu/arm-smmu-v3: Avoid constructing invalid range commands

Although io-pgtable's non-leaf invalidations are always for full tables,
I missed that SVA also uses non-leaf invalidations, while being at the
mercy of whatever range the MMU notifier throws at it. This means it
definitely wants the previous TTL fix as well, since it also doesn't
know exactly which leaf level(s) may need invalidating, but it can also
give us less-aligned ranges wherein certain corners may lead to building
an invalid command where TTL, Num and Scale are all 0. It should be fine
to handle this by over-invalidating an extra page, since falling back to
a non-range command opens up a whole can of errata-flavoured worms.

Fixes: 6833b8f2e199 ("iommu/arm-smmu-v3: Set TTL invalidation hint better")
Reported-by: Rui Zhu <zhurui3@huawei.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 15 ++++++++++-----
  1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9b0dc3505601..6ccbae9b93a1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1895,18 +1895,23 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
  		/* Get the leaf page size */
  		tg = __ffs(smmu_domain->domain.pgsize_bitmap);
  
+		num_pages = size >> tg;
+
  		/* Convert page size of 12,14,16 (log2) to 1,2,3 */
  		cmd->tlbi.tg = (tg - 10) / 2;
  
  		/*
-		 * Determine what level the granule is at. For non-leaf, io-pgtable
-		 * assumes .tlb_flush_walk can invalidate multiple levels at once,
-		 * so ignore the nominal last-level granule and leave TTL=0.
+		 * Determine what level the granule is at. For non-leaf, both
+		 * io-pgtable and SVA pass a nominal last-level granule because
+		 * they don't know what level(s) actually apply, so ignore that
+		 * and leave TTL=0. However for various errata reasons we still
+		 * want to use a range command, so avoid the SVA corner case
+		 * where both scale and num could be 0 as well.
  		 */
  		if (cmd->tlbi.leaf)
  			cmd->tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
-
-		num_pages = size >> tg;
+		else if ((num_pages & CMDQ_TLBI_RANGE_NUM_MAX) == 1)
+			num_pages++;
  	}
  
  	cmds.num = 0;
