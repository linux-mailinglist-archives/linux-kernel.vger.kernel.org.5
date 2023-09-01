Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F45D7901C3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 20:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350486AbjIASCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 14:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjIASCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 14:02:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 083E3FD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 11:02:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D2B8FEC;
        Fri,  1 Sep 2023 11:03:06 -0700 (PDT)
Received: from [10.57.5.33] (unknown [10.57.5.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5ACC73F8A4;
        Fri,  1 Sep 2023 11:02:26 -0700 (PDT)
Message-ID: <58fbd72b-32bc-c6da-15b2-0b8a284df60a@arm.com>
Date:   Fri, 1 Sep 2023 19:02:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/3] iommu/io-pgtable-arm: Add nents_per_pgtable in struct
 io_pgtable_cfg
Content-Language: en-GB
To:     Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>
Cc:     jgg@nvidia.com, joro@8bytes.org, jean-philippe@linaro.org,
        apopple@nvidia.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <cover.1692693557.git.nicolinc@nvidia.com>
 <0fe68babdb3a07adf024ed471fead4e3eb7e703f.1692693557.git.nicolinc@nvidia.com>
 <f468b461-b203-5179-eb6d-9432b9911329@arm.com>
 <ZOTlcFs2NG6nJEPN@Asurada-Nvidia>
 <61f9b371-7c45-26b1-ec0f-600765280c89@arm.com>
 <ZO5R5i4n2WI2GnKQ@Asurada-Nvidia>
 <d234fa8d-d945-3f7f-1110-fe55bea88587@arm.com>
 <ZO5uGKzGsaliQ1fF@Asurada-Nvidia> <20230830214958.GA30121@willie-the-truck>
 <ZPDQPs9UL2sksblM@Asurada-Nvidia> <ZPErio3R5redmDNU@Asurada-Nvidia>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZPErio3R5redmDNU@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-01 01:08, Nicolin Chen wrote:
> Hi Will/Robin,
> 
> On Thu, Aug 31, 2023 at 10:39:15AM -0700, Nicolin Chen wrote:
>   
>> Though I have not dig enough, I assume that this worst case could
>> happen to SVA too, since the IOTLB invalidation is from MMU code.
>> But the same worst case might not happen to non-SVA pathway, i.e.
>> TLBI ops for IO Page Table doesn't really benefit from this?
>>
>> With that being questioned, I got Robin's remarks that it wouldn't
>> be easy to decide the arbitrary number, so we could just take the
>> worst case from SVA pathway as the common threshold.
>>
>> Then, SVA uses the CPU page table, so perhaps we should highlight
>> that SMMU sets the threshold directly reusing the MAX_TLBI_OPS of
>> CPU page table rather than calculating from IO page table, though
>> both of them are in the same format?
> 
> Our test team encountered a soft lockup in this path today:
> --------------------------------------------------------------------
> watchdog: BUG: soft lockup - CPU#244 stuck for 26s!

That's a lot of TLBIs!

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
>   arm_smmu_cmdq_issue_cmdlist+0x178/0xa50
>   __arm_smmu_tlb_inv_range+0x118/0x254
>   arm_smmu_tlb_inv_range_asid+0x6c/0x130
>   arm_smmu_mm_invalidate_range+0xa0/0xa4
>   __mmu_notifier_invalidate_range_end+0x88/0x120
>   unmap_vmas+0x194/0x1e0
>   unmap_region+0xb4/0x144
>   do_mas_align_munmap+0x290/0x490
>   do_mas_munmap+0xbc/0x124
>   __vm_munmap+0xa8/0x19c
>   __arm64_sys_munmap+0x28/0x50
>   invoke_syscall+0x78/0x11c
>   el0_svc_common.constprop.0+0x58/0x1c0
>   do_el0_svc+0x34/0x60
>   el0_svc+0x2c/0xd4
>   el0t_64_sync_handler+0x114/0x140
>   el0t_64_sync+0x1a4/0x1a8
> --------------------------------------------------------------------
> 
> 
> I think it is the same problem that we fixed in tlbflush.h using
> MAX_TLBI_OPS. So, I plan to send a cleaner bug fix (cc stable):
> --------------------------------------------------------------------
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index a5a63b1c947e..e3ea7d2a6308 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -186,6 +186,9 @@ static void arm_smmu_free_shared_cd(struct arm_smmu_ctx_desc *cd)
>          }
>   }
> 
> +/* Copid from arch/arm64/include/asm/tlbflush.h to avoid similar soft lockups */
> +#define MAX_TLBI_OPS   (1 << (PAGE_SHIFT - 3))
> +
>   static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
>                                           struct mm_struct *mm,
>                                           unsigned long start, unsigned long end)
> @@ -201,9 +204,14 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
>           */
>          size = end - start;
> 
> -       if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM))
> -               arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,
> -                                           PAGE_SIZE, false, smmu_domain);
> +       if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM)) {
> +               if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_RANGE_INV) &&
> +                   size >= MAX_TLBI_OPS * PAGE_SIZE)
> +                       arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
> +               else
> +                       arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,
> +                                                   PAGE_SIZE, false, smmu_domain);
> +       }
>          arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, start, size);
>   }
> --------------------------------------------------------------------
> 
> What do you think about it?

Looks reasonable to me - I think it's the right shape to foreshadow the 
bigger refactoring we discussed, and I can't object to using 
PAGE_{SIZE,SHIFT} for the calculation when it's specifically in the 
context of SVA.

Thanks,
Robin.
