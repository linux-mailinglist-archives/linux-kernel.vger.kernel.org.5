Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00E6775648
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 11:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjHIJWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 05:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjHIJWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:22:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87401FF2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 02:22:09 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RLPcZ09HyzcdWm;
        Wed,  9 Aug 2023 17:18:38 +0800 (CST)
Received: from [10.67.145.224] (10.67.145.224) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 17:22:06 +0800
Subject: Re: [PATCH v2 1/1] iommu/arm-smmu-v3: Fix error case of range command
To:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
CC:     Nicolin Chen <nicolinc@nvidia.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
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
From:   zhurui <zhurui3@huawei.com>
Message-ID: <412886be-644a-5b46-9bfa-1c9a358f9a5d@huawei.com>
Date:   Wed, 9 Aug 2023 17:22:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <80ead8ee-4dbe-7b3c-44f5-944073a2a39d@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.145.224]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/9 0:43, Robin Murphy wrote:
> On 08/08/2023 5:24 pm, Will Deacon wrote:
>> Hi Robin,
>>
>> On Mon, Aug 07, 2023 at 08:20:45PM +0100, Robin Murphy wrote:
>>> On 2023-08-06 06:28, zhurui wrote:
>>>> On 2023/8/5 2:30, Nicolin Chen wrote:
>>>>> On Fri, Aug 04, 2023 at 05:52:25PM +0100, Will Deacon wrote:
>>>>>> On Fri, Aug 04, 2023 at 05:31:20PM +0800, zhurui wrote:
>>>>>>> When tg != 0 but ttl, scale, num all 0 in a range tlbi command, it
>>>>>>> is reserved and will cause the CERROR_ILL error. This case means
>>>>>>> that the size to be invalidated is only one page size, and the
>>>>>>> range invalidation is meaningless here. So we set tg to 0 in this
>>>>>>> case to do an non-range invalidation instead.
>>>>>
>>>>>>> @@ -1930,6 +1927,12 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
>>>>>>>                           num = (num_pages >> scale) & CMDQ_TLBI_RANGE_NUM_MAX;
>>>>>>>                           cmd->tlbi.num = num - 1;
>>>>>>>
>>>>>>> +                       /* Prevent error caused by one page tlbi with leaf 0 */
>>>>>>> +                       if (scale == 0 && num == 1 && cmd->tlbi.leaf == 0)
>>>>>>> +                               cmd->tlbi.tg = 0;
>>>>>>
>>>>>> This should only be true for the last iteration, right (i.e. when num_pages
>>>>>> == 1)? In which case, I'd prefer to leave the old code as-is and just add:
>>>>>>
>>>>>>           /* Single-page leaf invalidation requires a TG field of 0 */
>>>>>>           if (num_pages == 1 && !cmd->tlbi.leaf)
>>>>>>                   cmd->tlbi.tg = 0;To Will and Nicolin,
>>>>
>>>> Not only the last iteration, it's the result of __ffs function. For example, if
>>>> numpages is 33, then the value of __ffs(num_pages) is 0, so the value of scale
>>>> is also 0. The value of num depends on CMDQ_TLBI_RANGE_NUM_MAX. That is, the
>>>> maximum value of num is 31. Therefore, the final value of num is 1.
>>>> So, if consider CMDQ_TLBI_RANGE_NUM_MAX, there will be some case not the last
>>>> one page but the beginning pages. That's why I use scale and num as conditions,
>>>> not num_pages. Then I should reassign tg based on the result.
>>>
>>> Yeah, I'd rather not downgrade to a non-range invalidate since that
>>> complicates the reasoning for the errata affecting those. If the size of the
>>> invalidation is equal to TG then it can only represent a single last-level
>>> page, i.e. TTL=3, thus if it does warrant handling here then indeed
>>> rearranging to base the condition on num_pages as well ought to suffice.
>>> However, this is all still begging the question of where and why we're doing
>>> a *non-leaf* invalidation that isn't aligned to the size of a table, because
>>> that in itself doesn't make a whole heap of sense - my hunch is that that
>>> wants figuring out and could probably be fixed at the source.
>>
>> Isn't that described above because we're using CMDQ_TLBI_RANGE_NUM_MAX
>> to break up the range into separate commands?
> 
> Not really, because if we're doing a genuine non-leaf invalidation of a table then it should be a block-aligned range that ought to fit in a single command and should certainly never involve a single-granule remainder. If we're doing non-leaf invalidations of things that logically don't need to be non-leaf, making them leaf would be the even better option.
> 

I agree with Robin that if the caller is doing a genuine non-leaf invalidation
of a table, it should not involve a single-granule tlbi. It seems that the
caller only filter the block size, but not the address aligned or not maybe.

>> Do you mind if I queue the patch as-is for now? I don't think the driver
>> should be emitting illegal commands, and v2 of the patch does seem like
>> the obvious thing to do.
> 
> TBH I'd rather you just drop my patch if it's proven problematic, and I'll take another crack at it soon. The potential problems we introduce by using non-range invalidates on errata-affected MMU-700 revisions are worse than the almost-entirely-theoretical one I was trying to address.
> 

If you all agree to roll back the problematic code, is the first patch be OK?
Should I need to add some more descriptions to clarify this?

Thanks,
Zhurui.





