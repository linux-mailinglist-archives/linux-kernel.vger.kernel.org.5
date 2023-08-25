Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853707881B7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242906AbjHYIMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237231AbjHYIMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:12:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1233BCEE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 01:12:03 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RXCJ93rTkzNn1t;
        Fri, 25 Aug 2023 16:08:25 +0800 (CST)
Received: from [10.67.145.224] (10.67.145.224) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 25 Aug 2023 16:12:00 +0800
Subject: Re: [PATCH v2 1/1] iommu/arm-smmu-v3: Fix error case of range command
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
CC:     Nicolin Chen <nicolinc@nvidia.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
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
From:   zhurui <zhurui3@huawei.com>
Message-ID: <d05378c0-5b85-caaf-ae0d-49576adf7d86@huawei.com>
Date:   Fri, 25 Aug 2023 16:12:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230818162114.GB16216@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.145.224]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/19 0:21, Will Deacon wrote:
> On Fri, Aug 18, 2023 at 05:19:31PM +0100, Robin Murphy wrote:
>> On 2023-08-09 14:48, Robin Murphy wrote:
>> [...]
>>> Does the patch below work for you?
>>
>> Any comments on this? Just noticed this commit on a local dev branch and
>> realised I'd totally forgotten about it already. I'm pretty confident it
>> ought to be right, but then it *was* also me who missed the original bug to
>> begin with... ;)
> 
> I'm happy to take it if zhurui can confirm that it fixes their issue...
> 
> Will (had also forgotten about this)
> 
>>> ----->8-----
>>> Subject: [PATCH] iommu/arm-smmu-v3: Avoid constructing invalid range
>>> commands
>>>
>>> Although io-pgtable's non-leaf invalidations are always for full tables,
>>> I missed that SVA also uses non-leaf invalidations, while being at the
>>> mercy of whatever range the MMU notifier throws at it. This means it
>>> definitely wants the previous TTL fix as well, since it also doesn't
>>> know exactly which leaf level(s) may need invalidating, but it can also
>>> give us less-aligned ranges wherein certain corners may lead to building
>>> an invalid command where TTL, Num and Scale are all 0. It should be fine
>>> to handle this by over-invalidating an extra page, since falling back to
>>> a non-range command opens up a whole can of errata-flavoured worms.
>>>
>>> Fixes: 6833b8f2e199 ("iommu/arm-smmu-v3: Set TTL invalidation hint better")
>>> Reported-by: Rui Zhu <zhurui3@huawei.com>
>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>> ---
>>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 15 ++++++++++-----
>>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> index 9b0dc3505601..6ccbae9b93a1 100644
>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> @@ -1895,18 +1895,23 @@ static void __arm_smmu_tlb_inv_range(struct
>>> arm_smmu_cmdq_ent *cmd,
>>>           /* Get the leaf page size */
>>>           tg = __ffs(smmu_domain->domain.pgsize_bitmap);
>>>
>>> +        num_pages = size >> tg;
>>> +
>>>           /* Convert page size of 12,14,16 (log2) to 1,2,3 */
>>>           cmd->tlbi.tg = (tg - 10) / 2;
>>>
>>>           /*
>>> -         * Determine what level the granule is at. For non-leaf,
>>> io-pgtable
>>> -         * assumes .tlb_flush_walk can invalidate multiple levels at once,
>>> -         * so ignore the nominal last-level granule and leave TTL=0.
>>> +         * Determine what level the granule is at. For non-leaf, both
>>> +         * io-pgtable and SVA pass a nominal last-level granule because
>>> +         * they don't know what level(s) actually apply, so ignore that
>>> +         * and leave TTL=0. However for various errata reasons we still
>>> +         * want to use a range command, so avoid the SVA corner case
>>> +         * where both scale and num could be 0 as well.
>>>            */
>>>           if (cmd->tlbi.leaf)
>>>               cmd->tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
>>> -
>>> -        num_pages = size >> tg;
>>> +        else if ((num_pages & CMDQ_TLBI_RANGE_NUM_MAX) == 1)
>>> +            num_pages++;
>>>       }
>>>
>>>       cmds.num = 0;
>>>

Hi, Will and Robin,
Sorry for taking so long to reply you. We have some problems with our machine these days. It's
solved just today. I give a test with Robin's patch for our testcase, everything is ok. I think
the problem has been solved.

Thanks,
ZhuRui.
