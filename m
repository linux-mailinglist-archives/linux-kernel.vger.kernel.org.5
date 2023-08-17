Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FA477FE6F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 21:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354657AbjHQTRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 15:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354510AbjHQTRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 15:17:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E07B12135
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 12:17:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EA0AD75;
        Thu, 17 Aug 2023 12:17:41 -0700 (PDT)
Received: from [10.57.90.41] (unknown [10.57.90.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 161D53F64C;
        Thu, 17 Aug 2023 12:16:58 -0700 (PDT)
Message-ID: <3fc6ba4b-1e40-b835-06b9-b6d40f916d75@arm.com>
Date:   Thu, 17 Aug 2023 20:16:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH v1 4/8] iommu/arm-smmu-v3: check smmu compatibility on
 attach
Content-Language: en-GB
To:     Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     will@kernel.org, jgg@nvidia.com, nicolinc@nvidia.com,
        tina.zhang@intel.com, jean-philippe@linaro.org
References: <20230817182055.1770180-1-mshavit@google.com>
 <20230818021629.RFC.v1.4.I100c49a1e2ce915982965a065f95a494c2e9ad28@changeid>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230818021629.RFC.v1.4.I100c49a1e2ce915982965a065f95a494c2e9ad28@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-17 19:16, Michael Shavit wrote:
> Record the domain's pgtbl_cfg when it's being prepared so that it can
> later be compared to the features an smmu supports.

What's wrong with retrieving the existing config from the 
io_pgtable_ops, same as all the other io-pgtable code does?

Thanks,
Robin.

> Verify a domain's compatibility with the smmu when it's being attached
> to a master belong to a different smmu device.
> 
> Signed-off-by: Michael Shavit <mshavit@google.com>
> ---
> 
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 103 ++++++++++++++++----
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   2 +
>   2 files changed, 86 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 447af74dbe280..c0943cf3c09ca 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2195,17 +2195,48 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
>   	return 0;
>   }
>   
> +static int arm_smmu_prepare_pgtbl_cfg(struct arm_smmu_device *smmu,
> +				      enum arm_smmu_domain_stage stage,
> +				      struct io_pgtable_cfg *pgtbl_cfg)
> +{
> +	unsigned long ias, oas;
> +
> +	switch (stage) {
> +	case ARM_SMMU_DOMAIN_S1:
> +		ias = (smmu->features & ARM_SMMU_FEAT_VAX) ? 52 : 48;
> +		ias = min_t(unsigned long, ias, VA_BITS);
> +		oas = smmu->ias;
> +		break;
> +	case ARM_SMMU_DOMAIN_NESTED:
> +	case ARM_SMMU_DOMAIN_S2:
> +		ias = smmu->ias;
> +		oas = smmu->oas;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	*pgtbl_cfg = (struct io_pgtable_cfg) {
> +		.pgsize_bitmap	= smmu->pgsize_bitmap,
> +		.ias		= ias,
> +		.oas		= oas,
> +		.coherent_walk	= smmu->features & ARM_SMMU_FEAT_COHERENCY,
> +		.tlb		= &arm_smmu_flush_ops,
> +		.iommu_dev	= smmu->dev,
> +	};
> +	return 0;
> +}
> +
>   static int arm_smmu_domain_finalise(struct iommu_domain *domain)
>   {
>   	int ret;
> -	unsigned long ias, oas;
>   	enum io_pgtable_fmt fmt;
> -	struct io_pgtable_cfg pgtbl_cfg;
>   	struct io_pgtable_ops *pgtbl_ops;
>   	int (*finalise_stage_fn)(struct arm_smmu_domain *,
>   				 struct io_pgtable_cfg *);
>   	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>   	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	struct io_pgtable_cfg *pgtbl_cfg = &smmu_domain->pgtbl_cfg;
>   
>   	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
>   		smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS;
> @@ -2220,16 +2251,11 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
>   
>   	switch (smmu_domain->stage) {
>   	case ARM_SMMU_DOMAIN_S1:
> -		ias = (smmu->features & ARM_SMMU_FEAT_VAX) ? 52 : 48;
> -		ias = min_t(unsigned long, ias, VA_BITS);
> -		oas = smmu->ias;
>   		fmt = ARM_64_LPAE_S1;
>   		finalise_stage_fn = arm_smmu_domain_finalise_s1;
>   		break;
>   	case ARM_SMMU_DOMAIN_NESTED:
>   	case ARM_SMMU_DOMAIN_S2:
> -		ias = smmu->ias;
> -		oas = smmu->oas;
>   		fmt = ARM_64_LPAE_S2;
>   		finalise_stage_fn = arm_smmu_domain_finalise_s2;
>   		break;
> @@ -2237,24 +2263,19 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
>   		return -EINVAL;
>   	}
>   
> -	pgtbl_cfg = (struct io_pgtable_cfg) {
> -		.pgsize_bitmap	= smmu->pgsize_bitmap,
> -		.ias		= ias,
> -		.oas		= oas,
> -		.coherent_walk	= smmu->features & ARM_SMMU_FEAT_COHERENCY,
> -		.tlb		= &arm_smmu_flush_ops,
> -		.iommu_dev	= smmu->dev,
> -	};
> +	ret = arm_smmu_prepare_pgtbl_cfg(smmu, smmu_domain->stage, pgtbl_cfg);
> +	if (ret)
> +		return ret;
>   
> -	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
> +	pgtbl_ops = alloc_io_pgtable_ops(fmt, pgtbl_cfg, smmu_domain);
>   	if (!pgtbl_ops)
>   		return -ENOMEM;
>   
> -	domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
> -	domain->geometry.aperture_end = (1UL << pgtbl_cfg.ias) - 1;
> +	domain->pgsize_bitmap = pgtbl_cfg->pgsize_bitmap;
> +	domain->geometry.aperture_end = (1UL << pgtbl_cfg->ias) - 1;
>   	domain->geometry.force_aperture = true;
>   
> -	ret = finalise_stage_fn(smmu_domain, &pgtbl_cfg);
> +	ret = finalise_stage_fn(smmu_domain, pgtbl_cfg);
>   	if (ret < 0) {
>   		free_io_pgtable_ops(pgtbl_ops);
>   		return ret;
> @@ -2406,6 +2427,46 @@ static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
>   	pci_disable_pasid(pdev);
>   }
>   
> +static int
> +arm_smmu_verify_domain_compatible(struct arm_smmu_device *smmu,
> +				  struct arm_smmu_domain *smmu_domain)
> +{
> +	struct io_pgtable_cfg pgtbl_cfg;
> +	int ret;
> +
> +	if (smmu_domain->domain.type == IOMMU_DOMAIN_IDENTITY)
> +		return 0;
> +
> +	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S2) {
> +		if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S2))
> +			return -EINVAL;
> +		if (smmu_domain->s2_cfg.vmid >> smmu->vmid_bits)
> +			return -EINVAL;
> +	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
> +		if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1))
> +			return -EINVAL;
> +		if (smmu_domain->cd.asid >> smmu->asid_bits)
> +			return -EINVAL;
> +	}
> +
> +	ret = arm_smmu_prepare_pgtbl_cfg(smmu, smmu_domain->stage, &pgtbl_cfg);
> +	if (ret)
> +		return ret;
> +
> +	if (smmu_domain->pgtbl_cfg.ias > pgtbl_cfg.ias ||
> +	    smmu_domain->pgtbl_cfg.oas > pgtbl_cfg.oas ||
> +	    /*
> +	     * The supported pgsize_bitmap must be a superset of the domain's
> +	     * pgsize_bitmap.
> +	     */
> +	    (smmu_domain->pgtbl_cfg.pgsize_bitmap ^ pgtbl_cfg.pgsize_bitmap) &
> +		    smmu_domain->pgtbl_cfg.pgsize_bitmap ||
> +	    smmu_domain->pgtbl_cfg.coherent_walk != pgtbl_cfg.coherent_walk)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>   static void arm_smmu_installed_smmus_remove_device(
>   	struct arm_smmu_domain *smmu_domain,
>   	struct arm_smmu_master *master)
> @@ -2449,6 +2510,10 @@ arm_smmu_installed_smmus_add_device(struct arm_smmu_domain *smmu_domain,
>   		}
>   	}
>   	if (!list_entry_found) {
> +		ret = arm_smmu_verify_domain_compatible(smmu, smmu_domain);
> +		if (ret)
> +			goto unlock;
> +
>   		installed_smmu = kzalloc(sizeof(*installed_smmu), GFP_KERNEL);
>   		if (!installed_smmu) {
>   			ret = -ENOMEM;
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 2ab23139c796e..143b287be2f8b 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -9,6 +9,7 @@
>   #define _ARM_SMMU_V3_H
>   
>   #include <linux/bitfield.h>
> +#include <linux/io-pgtable.h>
>   #include <linux/iommu.h>
>   #include <linux/kernel.h>
>   #include <linux/mmzone.h>
> @@ -729,6 +730,7 @@ struct arm_smmu_domain {
>   	struct mutex			init_mutex; /* Protects smmu pointer */
>   
>   	struct io_pgtable_ops		*pgtbl_ops;
> +	struct io_pgtable_cfg		pgtbl_cfg;
>   	atomic_t			nr_ats_masters;
>   
>   	enum arm_smmu_domain_stage	stage;
