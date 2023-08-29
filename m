Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2957278CF94
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 00:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239476AbjH2Wk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 18:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239462AbjH2Wkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 18:40:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 736AA99
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 15:40:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31BC52F4;
        Tue, 29 Aug 2023 15:41:15 -0700 (PDT)
Received: from [10.57.2.162] (unknown [10.57.2.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A70D3F64C;
        Tue, 29 Aug 2023 15:40:34 -0700 (PDT)
Message-ID: <dc99bc7b-b6bc-1b82-3d8e-8e385596070b@arm.com>
Date:   Tue, 29 Aug 2023 23:40:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 3/3] iommu/arm-smmu-v3: Add a max_tlbi_ops for
 __arm_smmu_tlb_inv_range()
Content-Language: en-GB
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     will@kernel.org, jgg@nvidia.com, joro@8bytes.org,
        jean-philippe@linaro.org, apopple@nvidia.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
References: <cover.1692693557.git.nicolinc@nvidia.com>
 <3ba332e141102d31b756326cdc4078cac1f5ab1c.1692693557.git.nicolinc@nvidia.com>
 <3f630d3d-c59a-f454-14db-2bf9b8e76877@arm.com>
 <ZOTjGIJU8Kfl1Q4f@Asurada-Nvidia> <ZOU+6hsKy4R099B3@Asurada-Nvidia>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZOU+6hsKy4R099B3@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-23 00:04, Nicolin Chen wrote:
> Hi Robin,
> 
> On Tue, Aug 22, 2023 at 09:32:26AM -0700, Nicolin Chen wrote:
>> On Tue, Aug 22, 2023 at 10:30:35AM +0100, Robin Murphy wrote:
>>
>>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>> index d6c647e1eb01..3f0db30932bd 100644
>>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>> @@ -1897,7 +1897,14 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
>>>>        if (!size)
>>>>                return;
>>>>
>>>> -     if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
>>>> +     if (!(smmu->features & ARM_SMMU_FEAT_RANGE_INV)) {
>>>> +             /*
>>>> +              * When the size reaches a threshold, replace per-granule TLBI
>>>> +              * commands with one single per-asid or per-vmid TLBI command.
>>>> +              */
>>>> +             if (size >= granule * smmu_domain->max_tlbi_ops)
>>>> +                     return arm_smmu_tlb_inv_domain(smmu_domain);
>>>
>>> This looks like it's at the wrong level - we should have figured this
>>> out before we got as far as low-level command-building. I'd have thought
>>> it would be a case of short-circuiting directly from
>>> arm_smmu_tlb_inv_range_domain() to arm_smmu_tlb_inv_context().
>>
>> OK, I could do that. We would have copies of this same routine
>> though. Also, the shortcut applies to !ARM_SMMU_FEAT_RANGE_INV
>> cases only, so this function feels convenient to me.
> 
> I was trying to say that we would need the same piece in both
> arm_smmu_tlb_inv_range_domain() and arm_smmu_tlb_inv_range_asid(),
> though the latter one only needs to call arm_smmu_tlb_inv_asid().

Its not like arm_smmu_tlb_inv_range_asid() doesn't already massively 
overlap with arm_smmu_tlb_inv_range_domain() anyway, so a little further 
duplication hardly seems like it would hurt. Checking 
ARM_SMMU_FEAT_RANGE_INV should be cheap (otherwise we'd really want to 
split __arm_smmu_tlb_inv_range() into separate RIL vs. non-RIL versions 
to avoid having it in the loop), and it makes the intent clear. What I 
just really don't like is a flow where we construct a specific command, 
then call the low-level function to issue it, only that function then 
actually jumps back out into another high-level function which 
constructs a *different* command. This code is already a maze of twisty 
little passages...

> Also, arm_smmu_tlb_inv_context() does a full range ATC invalidation
> instead of a given range like what arm_smmu_tlb_inv_range_domain()
> currently does. So, it might be a bit overkill.
> 
> Combining all your comments, we'd have something like this:

TBH I'd be inclined to refactor a bit harder, maybe break out some 
VMID-based helpers for orthogonality, and aim for a flow like:

	if (over threshold)
		tlb_inv_domain()
	else if (stage 1)
		tlb_inv_range_asid()
	else
		tlb_inv_range_vmid()
	atc_inv_range()

or possibly if you prefer:

	if (stage 1) {
		if (over threshold)
			tlb_inv_asid()
		else
			tlb_inv_range_asid()
	} else {
		if (over threshold)
			tlb_inv_vmid()
		else
			tlb_inv_range_vmid()
	}
	atc_inv_range()

where the latter maybe trades more verbosity for less duplication 
overall - I'd probably have to try both to see which looks nicer in the 
end. And obviously if there's any chance of inventing a clear and 
consistent naming scheme in the process, that would be lovely.

Thanks,
Robin.

> -------------------------------------------------------------------
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 7614739ea2c1..2967a6634c7c 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1937,12 +1937,22 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
>   					  size_t granule, bool leaf,
>   					  struct arm_smmu_domain *smmu_domain)
>   {
> +	struct io_pgtable_cfg *cfg =
> +		&io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops)->cfg;
>   	struct arm_smmu_cmdq_ent cmd = {
>   		.tlbi = {
>   			.leaf	= leaf,
>   		},
>   	};
>   
> +	/*
> +	 * If the given size is too large that would end up with too many TLBI
> +	 * commands in CMDQ, short circuit directly to a full invalidation
> +	 */
> +	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_RANGE_INV) &&
> +	    size >= granule * (1UL << cfg->bits_per_level))
> +		return arm_smmu_tlb_inv_context(smmu_domain);
> +
>   	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
>   		cmd.opcode	= smmu_domain->smmu->features & ARM_SMMU_FEAT_E2H ?
>   				  CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA;
> @@ -1964,6 +1974,8 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
>   				 size_t granule, bool leaf,
>   				 struct arm_smmu_domain *smmu_domain)
>   {
> +	struct io_pgtable_cfg *cfg =
> +		&io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops)->cfg;
>   	struct arm_smmu_cmdq_ent cmd = {
>   		.opcode	= smmu_domain->smmu->features & ARM_SMMU_FEAT_E2H ?
>   			  CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA,
> @@ -1973,6 +1985,14 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
>   		},
>   	};
>   
> +	/*
> +	 * If the given size is too large that would end up with too many TLBI
> +	 * commands in CMDQ, short circuit directly to a full invalidation
> +	 */
> +	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_RANGE_INV) &&
> +	    size >= granule * (1UL << cfg->bits_per_level))
> +		return arm_smmu_tlb_inv_asid(smmu_domain->smmu, asid);
> +
>   	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
>   }
>   
> -------------------------------------------------------------------
> 
> You're sure that you prefer this, right?
> 
> Thanks
> Nicolin
