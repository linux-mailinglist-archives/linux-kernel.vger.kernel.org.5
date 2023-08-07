Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D711F772E94
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjHGTVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjHGTVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:21:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5F6610F3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 12:21:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49DAE1FB;
        Mon,  7 Aug 2023 12:21:47 -0700 (PDT)
Received: from [192.168.1.102] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50E903F64C;
        Mon,  7 Aug 2023 12:21:02 -0700 (PDT)
Message-ID: <661a7bb5-99e1-de16-d860-0cd17f7a0470@arm.com>
Date:   Mon, 7 Aug 2023 20:20:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/1] iommu/arm-smmu-v3: Fix error case of range command
Content-Language: en-GB
To:     zhurui <zhurui3@huawei.com>, Nicolin Chen <nicolinc@nvidia.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
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
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <015b4573-9d74-451b-8028-a1050ade7019@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-06 06:28, zhurui wrote:
> On 2023/8/5 2:30, Nicolin Chen wrote:
>> On Fri, Aug 04, 2023 at 05:52:25PM +0100, Will Deacon wrote:
>>> On Fri, Aug 04, 2023 at 05:31:20PM +0800, zhurui wrote:
>>>> When tg != 0 but ttl, scale, num all 0 in a range tlbi command, it
>>>> is reserved and will cause the CERROR_ILL error. This case means
>>>> that the size to be invalidated is only one page size, and the
>>>> range invalidation is meaningless here. So we set tg to 0 in this
>>>> case to do an non-range invalidation instead.
>>
>>>> @@ -1930,6 +1927,12 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
>>>>                          num = (num_pages >> scale) & CMDQ_TLBI_RANGE_NUM_MAX;
>>>>                          cmd->tlbi.num = num - 1;
>>>>
>>>> +                       /* Prevent error caused by one page tlbi with leaf 0 */
>>>> +                       if (scale == 0 && num == 1 && cmd->tlbi.leaf == 0)
>>>> +                               cmd->tlbi.tg = 0;
>>>
>>> This should only be true for the last iteration, right (i.e. when num_pages
>>> == 1)? In which case, I'd prefer to leave the old code as-is and just add:
>>>
>>>          /* Single-page leaf invalidation requires a TG field of 0 */
>>>          if (num_pages == 1 && !cmd->tlbi.leaf)
>>>                  cmd->tlbi.tg = 0;To Will and Nicolin,
> 
> Not only the last iteration, it's the result of __ffs function. For example, if
> numpages is 33, then the value of __ffs(num_pages) is 0, so the value of scale
> is also 0. The value of num depends on CMDQ_TLBI_RANGE_NUM_MAX. That is, the
> maximum value of num is 31. Therefore, the final value of num is 1.
> So, if consider CMDQ_TLBI_RANGE_NUM_MAX, there will be some case not the last
> one page but the beginning pages. That's why I use scale and num as conditions,
> not num_pages. Then I should reassign tg based on the result.

Yeah, I'd rather not downgrade to a non-range invalidate since that 
complicates the reasoning for the errata affecting those. If the size of 
the invalidation is equal to TG then it can only represent a single 
last-level page, i.e. TTL=3, thus if it does warrant handling here then 
indeed rearranging to base the condition on num_pages as well ought to 
suffice. However, this is all still begging the question of where and 
why we're doing a *non-leaf* invalidation that isn't aligned to the size 
of a table, because that in itself doesn't make a whole heap of sense - 
my hunch is that that wants figuring out and could probably be fixed at 
the source.

Thanks,
Robin.

> 
>>
>> Is "!cmd->tlbi.leaf" to be "leaf" or "non-leaf"?
>>
>> IIUIC, this "num_pages == 1" implies "NUM == 0, SCALE == 0" while
>> the "!cmd->tlbi.leaf" implies "TTL = 0b00", which in combination
>> would result in a CERROR_ILL mentioned by the spec?
>>
>> I feel this could be more clear by just checking the three fields
>> following the spec...>
>> Thanks
>> Nicolin
>> .
>>
> Yes, based on spec 4.4.1.1 for ARM IHI 0070, after the TLL and TG table, there is a
> description for TG != 0b00, and you can check it in the last point.
> 
> Thanks.
> ZhuRui
> .
