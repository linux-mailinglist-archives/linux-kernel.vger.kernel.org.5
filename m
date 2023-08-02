Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0002076CB49
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbjHBKwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjHBKwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:52:10 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EF19C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 03:52:08 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RG7xh4fjKzNmZ3;
        Wed,  2 Aug 2023 18:48:40 +0800 (CST)
Received: from [10.67.145.224] (10.67.145.224) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 18:52:06 +0800
Subject: Re: [PATCH 1/1] Revert "iommu/arm-smmu-v3: Set TTL invalidation hint
 better"
To:     Will Deacon <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Tomas Krcka <krckatom@amazon.de>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <1690784482-30028-1-git-send-email-wangwudi@hisilicon.com>
 <20230801085504.GA26130@willie-the-truck>
From:   zhurui <zhurui3@huawei.com>
Message-ID: <27c895b8-1fb0-be88-8bc3-878d754684c8@huawei.com>
Date:   Wed, 2 Aug 2023 18:52:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230801085504.GA26130@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.145.224]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/1 16:55, Will Deacon wrote:
> On Mon, Jul 31, 2023 at 02:21:22PM +0800, wangwudi wrote:
>> From: Rui Zhu <zhurui3@huawei.com>
>>
>> This reverts commit 6833b8f2e19945a41e4d5efd8c6d9f4cae9a5b7d.
>>
>> This constraint violates the protocol. When tg is not 0 but ttl, scale,
>> and num are 0, the hardware reports the CERROR_IL gerror. In the
>> protocol, leaf is not a prerequisite for TTL.
>>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Lu Baolu <baolu.lu@linux.intel.com>
>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
>> Cc: Yicong Yang <yangyicong@hisilicon.com>
>> Cc: Tomas Krcka <krckatom@amazon.de>
>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Cc: Nicolin Chen <nicolinc@nvidia.com>
>> Cc: Rui Zhu <zhurui3@huawei.com>
>>
>> Signed-off-by: Rui Zhu <zhurui3@huawei.com>
>> ---
>>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++-------
>>  1 file changed, 2 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 9b0dc3505601..098e84cfa82f 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -1898,13 +1898,8 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
>>  		/* Convert page size of 12,14,16 (log2) to 1,2,3 */
>>  		cmd->tlbi.tg = (tg - 10) / 2;
>>  
>> -		/*
>> -		 * Determine what level the granule is at. For non-leaf, io-pgtable
>> -		 * assumes .tlb_flush_walk can invalidate multiple levels at once,
>> -		 * so ignore the nominal last-level granule and leave TTL=0.
>> -		 */
>> -		if (cmd->tlbi.leaf)
>> -			cmd->tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
>> +		/* Determine what level the granule is at */
>> +		cmd->tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
> 
> Doesn't this reintroduce the bug that 6833b8f2e199 tried to fix?
> 
> afaict, we should only hit the problematic case of tg != 0 but ttl, scale
> and num all 0 if we're invalidating a single page, so shouldn't we just
> zap tg in that case, since it's not doing anything useful?

You're right. I'm sorry I missed. I just need to handle the problematic
case by assigning 0 to tg. It's better to add this following code before
each tlbi cmd batch add.

if (num_pages == 1) {
	cmd->tlbi.tg = 0;
}

I'll resubmit a new patch. Thanks for your correction.

> 
> I hesitate to say we should avoid range invalidation altogether for
> single-page invalidations because I think some errata workarounds might
> need that to work.
> 
> Will
> .
> 
