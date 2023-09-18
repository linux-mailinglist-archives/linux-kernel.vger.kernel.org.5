Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9C17A45CA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbjIRJW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 05:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239142AbjIRJWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:22:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EB0B6;
        Mon, 18 Sep 2023 02:22:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA2BC433C8;
        Mon, 18 Sep 2023 09:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695028961;
        bh=3asbmydlTrYFQRQpW0z4htJw7Y1DdXlksy2ai5XGF3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U25Zl5wBkmgG4S5D9v0GeETOwm362dPqsm8gwoZXWJh4l3byhm9EgT1BwFqHZOeKR
         fSGfllCESBDbOTHY1G0yHaXNxdLZoVCarINWv/nLFxGTa7n1SUpmdQg3oobp8fY/LL
         ZDtpNX+4fOJJvGAqIiYzKC5jp60c69w2d7LPsfjqWnYYTpT5gCzFU7eaP4RLD7DPj6
         D7dHkVO7YCKCUESf4O9sm5lngD2eWblC9J6fLNvnamEiB9f3/6FPTOXjqNLmeQ9hXF
         /iGpvnUTLXv03IYu6FJ9bxoLuj6kWGWZE543AA4NgoQZDDV2XoDbbeyn56jnGbXeyT
         6CUbBv/LoNErQ==
Date:   Mon, 18 Sep 2023 10:22:36 +0100
From:   Will Deacon <will@kernel.org>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     robin.murphy@arm.com, joro@8bytes.org, jgg@nvidia.com,
        jean-philippe@linaro.org, apopple@nvidia.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix soft lockup triggered by
 arm_smmu_mm_invalidate_range
Message-ID: <20230918092235.GA17341@willie-the-truck>
References: <20230901203904.4073-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901203904.4073-1-nicolinc@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 01:39:04PM -0700, Nicolin Chen wrote:
> When running an SVA case, the following soft lockup is triggered:
> --------------------------------------------------------------------
> watchdog: BUG: soft lockup - CPU#244 stuck for 26s!
> pstate: 83400009 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> pc : arm_smmu_cmdq_issue_cmdlist+0x178/0xa50
> lr : arm_smmu_cmdq_issue_cmdlist+0x150/0xa50
> sp : ffff8000d83ef290
> x29: ffff8000d83ef290 x28: 000000003b9aca00 x27: 0000000000000000
> x26: ffff8000d83ef3c0 x25: da86c0812194a0e8 x24: 0000000000000000
> x23: 0000000000000040 x22: ffff8000d83ef340 x21: ffff0000c63980c0
> x20: 0000000000000001 x19: ffff0000c6398080 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000 x15: ffff3000b4a3bbb0
> x14: ffff3000b4a30888 x13: ffff3000b4a3cf60 x12: 0000000000000000
> x11: 0000000000000000 x10: 0000000000000000 x9 : ffffc08120e4d6bc
> x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000048cfa
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : 000000000000000a
> x2 : 0000000080000000 x1 : 0000000000000000 x0 : 0000000000000001
> Call trace:
>  arm_smmu_cmdq_issue_cmdlist+0x178/0xa50
>  __arm_smmu_tlb_inv_range+0x118/0x254
>  arm_smmu_tlb_inv_range_asid+0x6c/0x130
>  arm_smmu_mm_invalidate_range+0xa0/0xa4
>  __mmu_notifier_invalidate_range_end+0x88/0x120
>  unmap_vmas+0x194/0x1e0
>  unmap_region+0xb4/0x144
>  do_mas_align_munmap+0x290/0x490
>  do_mas_munmap+0xbc/0x124
>  __vm_munmap+0xa8/0x19c
>  __arm64_sys_munmap+0x28/0x50
>  invoke_syscall+0x78/0x11c
>  el0_svc_common.constprop.0+0x58/0x1c0
>  do_el0_svc+0x34/0x60
>  el0_svc+0x2c/0xd4
>  el0t_64_sync_handler+0x114/0x140
>  el0t_64_sync+0x1a4/0x1a8
> --------------------------------------------------------------------
> 
> The commit 06ff87bae8d3 ("arm64: mm: remove unused functions and variable
> protoypes") fixed a similar lockup on the CPU MMU side. Yet, it can occur
> to SMMU too since arm_smmu_mm_invalidate_range() is typically called next
> to MMU tlb flush function, e.g.
> 	tlb_flush_mmu_tlbonly {
> 		tlb_flush {
> 			__flush_tlb_range {
> 				// check MAX_TLBI_OPS
> 			}
> 		}
> 		mmu_notifier_invalidate_range {
> 			arm_smmu_mm_invalidate_range {
> 				// does not check MAX_TLBI_OPS
> 			}
> 		}
> 	}
> 
> Clone a CMDQ_MAX_TLBI_OPS from the MAX_TLBI_OPS in tlbflush.h, since in an
> SVA case SMMU uses the CPU page table, so it makes sense to align with the
> tlbflush code. Then, replace per-page TLBI commands with a single per-asid
> TLBI command, if the request size hits this threshold.
> 
> Fixes: 51d113c3be09 ("iommu/arm-smmu-v3: Make BTM optional for SVA")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 11 ++++++++---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     |  9 +++++++++
>  2 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index a5a63b1c947e..7ec3f5219250 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -201,9 +201,14 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
>  	 */
>  	size = end - start;
>  
> -	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM))
> -		arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,
> -					    PAGE_SIZE, false, smmu_domain);
> +	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM)) {
> +		if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_RANGE_INV) &&
> +		    size >= CMDQ_MAX_TLBI_OPS * PAGE_SIZE)
> +			arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
> +		else
> +			arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,
> +						    PAGE_SIZE, false, smmu_domain);

cosmetic nit: Please use braces for the multi-line conditionals.

> +	}
>  	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, start, size);
>  }
>  
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index dcab85698a4e..79a81eed1dcc 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -326,6 +326,15 @@
>   */
>  #define CMDQ_BATCH_ENTRIES		BITS_PER_LONG
>  
> +/*
> + * Cloned from the MAX_TLBI_OPS in arch/arm64/include/asm/tlbflush.h, this
> + * is used as a threshold to replace per-page TLBI commands to issue in the
> + * command queue with an address-space TLBI command, when SMMU w/o a range
> + * invalidation feature handles too many per-page TLBI commands, which will
> + * otherwise result in a soft lockup.
> + */
> +#define CMDQ_MAX_TLBI_OPS		(1 << (PAGE_SHIFT - 3))

Maybe stick "SVA" in the name of this somewhere, since that's the reason why
looking at PAGE_SHIFT is relevant?

Will
