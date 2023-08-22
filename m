Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90FB783CEF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 11:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbjHVJap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 05:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbjHVJao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:30:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C53D4CC8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:30:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 615A511FB;
        Tue, 22 Aug 2023 02:31:23 -0700 (PDT)
Received: from [10.57.5.95] (unknown [10.57.5.95])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EE1F3F64C;
        Tue, 22 Aug 2023 02:30:40 -0700 (PDT)
Message-ID: <3f630d3d-c59a-f454-14db-2bf9b8e76877@arm.com>
Date:   Tue, 22 Aug 2023 10:30:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 3/3] iommu/arm-smmu-v3: Add a max_tlbi_ops for
 __arm_smmu_tlb_inv_range()
Content-Language: en-GB
To:     Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, jgg@nvidia.com
Cc:     joro@8bytes.org, jean-philippe@linaro.org, apopple@nvidia.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
References: <cover.1692693557.git.nicolinc@nvidia.com>
 <3ba332e141102d31b756326cdc4078cac1f5ab1c.1692693557.git.nicolinc@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <3ba332e141102d31b756326cdc4078cac1f5ab1c.1692693557.git.nicolinc@nvidia.com>
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

On 2023-08-22 09:45, Nicolin Chen wrote:
> When receiving an __arm_smmu_tlb_inv_range() call with a large size, there
> could be a long latency at this function call: one part is coming from a
> large software overhead in the routine of building commands, and the other
> part is coming from CMDQ hardware consuming the large number of commands.
> This latency could be significantly large on an SMMU that does not support
> range invalidation commands, i.e. no ARM_SMMU_FEAT_RANGE_INV.
> 
> One way to optimize this is to replace a large number of VA invalidation
> commands with one single per-asid or per-vmid invalidation command, if an
> invalidation size reaches a preset threshold using the number of entries
> per io-pgtable, similar to the MAX_TLBI_OPS in arm64's tlbflush.h.
> 
> Add a max_tlbi_ops in arm_smmu_domain, and convert a large number of per-
> granule TLBI commands to one single per-asid or per-vmid TLBI command, on
> SMMUs without ARM_SMMU_FEAT_RANGE_INV.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 +++++++++-
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
>   2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index d6c647e1eb01..3f0db30932bd 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1897,7 +1897,14 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
>   	if (!size)
>   		return;
>   
> -	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
> +	if (!(smmu->features & ARM_SMMU_FEAT_RANGE_INV)) {
> +		/*
> +		 * When the size reaches a threshold, replace per-granule TLBI
> +		 * commands with one single per-asid or per-vmid TLBI command.
> +		 */
> +		if (size >= granule * smmu_domain->max_tlbi_ops)
> +			return arm_smmu_tlb_inv_domain(smmu_domain);

This looks like it's at the wrong level - we should have figured this 
out before we got as far as low-level command-building. I'd have thought 
it would be a case of short-circuiting directly from 
arm_smmu_tlb_inv_range_domain() to arm_smmu_tlb_inv_context().

> +	} else {
>   		/* Get the leaf page size */
>   		tg = __ffs(smmu_domain->domain.pgsize_bitmap);
>   
> @@ -2258,6 +2265,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
>   	}
>   
>   	smmu_domain->pgtbl_ops = pgtbl_ops;
> +	smmu_domain->max_tlbi_ops = pgtbl_cfg.nents_per_pgtable;

And now we're carrying *three* copies of the same information around 
everywhere? Honestly, just pull cfg->bits_per_level out of the 
io_pgtable_ops at the point where you need it, like the pagetable code 
itself manages to do perfectly happily. Wrap it in an io-pgtable helper 
if you think that's cleaner.

Thanks,
Robin.

>   	return 0;
>   }
>   
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index dcab85698a4e..f68c95a2e24f 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -721,6 +721,7 @@ struct arm_smmu_domain {
>   	struct io_pgtable_ops		*pgtbl_ops;
>   	bool				stall_enabled;
>   	atomic_t			nr_ats_masters;
> +	unsigned long			max_tlbi_ops;
>   
>   	enum arm_smmu_domain_stage	stage;
>   	union {
