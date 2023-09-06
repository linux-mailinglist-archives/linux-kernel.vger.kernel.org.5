Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5499E7934B4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 07:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239450AbjIFFFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 01:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjIFFFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 01:05:08 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95B9CC2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 22:05:04 -0700 (PDT)
Received: from [172.20.10.67] (c-73-118-245-227.hsd1.wa.comcast.net [73.118.245.227])
        by linux.microsoft.com (Postfix) with ESMTPSA id 96176212B18B;
        Tue,  5 Sep 2023 22:05:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 96176212B18B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1693976703;
        bh=KKgsOAhDKOzqo69u3zNX41ZaU+WuV4X01q+Ns+I6CPo=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=UyxQbLMEeAft8ZsE9dSu91CV3ja8JNP91tt6A0MTemXqt7rdrukHq+eTWnxn9RHjB
         24IZID5a4WJ8tadEz77nrnf3tjtatmlE8P5aA+iAAkrSitfbbqgLw2Iq1wgYpdFATn
         z+dcYXDV0XqmbjZzep9IfxNd2hjRvNzgGNlV9q7w=
Message-ID: <dafbccb4-f7be-838f-c037-91ff2dc324e4@linux.microsoft.com>
Date:   Tue, 5 Sep 2023 22:05:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
From:   Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: Re: [PATCH v2 1/1] iommu/arm-smmu-v3: Fix error case of range command
To:     zhurui <zhurui3@huawei.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Tomas Krcka <krckatom@amazon.de>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <d5fc1f72-7428-4fef-d868-d06b85add635@huawei.com>
 <20230804165225.GF30679@willie-the-truck> <ZM1DqxXcBT2SOs8/@Asurada-Nvidia>
 <015b4573-9d74-451b-8028-a1050ade7019@huawei.com>
 <661a7bb5-99e1-de16-d860-0cd17f7a0470@arm.com>
 <20230808162409.GB2890@willie-the-truck>
 <80ead8ee-4dbe-7b3c-44f5-944073a2a39d@arm.com>
 <412886be-644a-5b46-9bfa-1c9a358f9a5d@huawei.com>
 <280d0be7-7d41-ed78-bf4b-3db6c0076e22@arm.com>
 <197e87cd-91a2-dce8-716c-488b379abbaf@arm.com>
 <20230818162114.GB16216@willie-the-truck>
 <d05378c0-5b85-caaf-ae0d-49576adf7d86@huawei.com>
Content-Language: en-US
In-Reply-To: <d05378c0-5b85-caaf-ae0d-49576adf7d86@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/23 01:12, zhurui wrote:
> On 2023/8/19 0:21, Will Deacon wrote:
>> On Fri, Aug 18, 2023 at 05:19:31PM +0100, Robin Murphy wrote:
>>> On 2023-08-09 14:48, Robin Murphy wrote:
>>> [...]
>>>> Does the patch below work for you?
>>>
>>> Any comments on this? Just noticed this commit on a local dev branch and
>>> realised I'd totally forgotten about it already. I'm pretty confident it
>>> ought to be right, but then it *was* also me who missed the original bug to
>>> begin with... ;)
>>
>> I'm happy to take it if zhurui can confirm that it fixes their issue...
>>
>> Will (had also forgotten about this)
>>
>>>> ----->8-----
>>>> Subject: [PATCH] iommu/arm-smmu-v3: Avoid constructing invalid range
>>>> commands
>>>>
>>>> Although io-pgtable's non-leaf invalidations are always for full tables,
>>>> I missed that SVA also uses non-leaf invalidations, while being at the
>>>> mercy of whatever range the MMU notifier throws at it. This means it
>>>> definitely wants the previous TTL fix as well, since it also doesn't
>>>> know exactly which leaf level(s) may need invalidating, but it can also
>>>> give us less-aligned ranges wherein certain corners may lead to building
>>>> an invalid command where TTL, Num and Scale are all 0. It should be fine
>>>> to handle this by over-invalidating an extra page, since falling back to
>>>> a non-range command opens up a whole can of errata-flavoured worms.
>>>>
>>>> Fixes: 6833b8f2e199 ("iommu/arm-smmu-v3: Set TTL invalidation hint better")
>>>> Reported-by: Rui Zhu <zhurui3@huawei.com>
>>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>>> ---
>>>>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 15 ++++++++++-----
>>>>    1 file changed, 10 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>> index 9b0dc3505601..6ccbae9b93a1 100644
>>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>> @@ -1895,18 +1895,23 @@ static void __arm_smmu_tlb_inv_range(struct
>>>> arm_smmu_cmdq_ent *cmd,
>>>>            /* Get the leaf page size */
>>>>            tg = __ffs(smmu_domain->domain.pgsize_bitmap);
>>>>
>>>> +        num_pages = size >> tg;
>>>> +
>>>>            /* Convert page size of 12,14,16 (log2) to 1,2,3 */
>>>>            cmd->tlbi.tg = (tg - 10) / 2;
>>>>
>>>>            /*
>>>> -         * Determine what level the granule is at. For non-leaf,
>>>> io-pgtable
>>>> -         * assumes .tlb_flush_walk can invalidate multiple levels at once,
>>>> -         * so ignore the nominal last-level granule and leave TTL=0.
>>>> +         * Determine what level the granule is at. For non-leaf, both
>>>> +         * io-pgtable and SVA pass a nominal last-level granule because
>>>> +         * they don't know what level(s) actually apply, so ignore that
>>>> +         * and leave TTL=0. However for various errata reasons we still
>>>> +         * want to use a range command, so avoid the SVA corner case
>>>> +         * where both scale and num could be 0 as well.
>>>>             */
>>>>            if (cmd->tlbi.leaf)
>>>>                cmd->tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
>>>> -
>>>> -        num_pages = size >> tg;
>>>> +        else if ((num_pages & CMDQ_TLBI_RANGE_NUM_MAX) == 1)
>>>> +            num_pages++;
>>>>        }
>>>>
>>>>        cmds.num = 0;
>>>>
> 
> Hi, Will and Robin,
> Sorry for taking so long to reply you. We have some problems with our machine these days. It's
> solved just today. I give a test with Robin's patch for our testcase, everything is ok. I think
> the problem has been solved.
> 
> Thanks,
> ZhuRui.
>

Hi Robin,

Could you please send out this patch since ZhuRui has confirmed it fixes 
their issue and CC it to stable for v5.15+? Or if Will is willing to 
pick it up off this thread, I can do the backport to stable.

-- 
Thanks,
Easwar

