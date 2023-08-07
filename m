Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4048773031
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 22:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjHGUOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 16:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjHGUOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 16:14:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68D1510CF;
        Mon,  7 Aug 2023 13:14:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE9021FB;
        Mon,  7 Aug 2023 13:15:17 -0700 (PDT)
Received: from [192.168.1.102] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 702233F6C4;
        Mon,  7 Aug 2023 13:14:32 -0700 (PDT)
Message-ID: <919ab857-30cf-00a5-1a40-fb180678792e@arm.com>
Date:   Mon, 7 Aug 2023 21:14:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 5.15 4/6] iommu/arm-smmu-v3: Document MMU-700 erratum
 2812531
Content-Language: en-GB
To:     Easwar Hariharan <eahariha@linux.microsoft.com>,
        stable@vger.kernel.org
Cc:     easwar.hariharan@microsoft.com, Nicolin Chen <nicolinc@nvidia.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joerg Roedel <joro@8bytes.org>,
        Sasha Levin <sashal@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Tomas Krcka <krckatom@amazon.de>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux.dev>
References: <20230802170227.1590187-1-eahariha@linux.microsoft.com>
 <20230802170227.1590187-5-eahariha@linux.microsoft.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230802170227.1590187-5-eahariha@linux.microsoft.com>
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

On 2023-08-02 18:02, Easwar Hariharan wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> 
> commit 309a15cb16bb075da1c99d46fb457db6a1a2669e upstream
> 
> To work around MMU-700 erratum 2812531 we need to ensure that certain
> sequences of commands cannot be issued without an intervening sync. In
> practice this falls out of our current command-batching machinery
> anyway - each batch only contains a single type of invalidation command,
> and ends with a sync. The only exception is when a batch is sufficiently
> large to need issuing across multiple command queue slots, wherein the
> earlier slots will not contain a sync and thus may in theory interleave
> with another batch being issued in parallel to create an affected
> sequence across the slot boundary.
> 
> Since MMU-700 supports range invalidate commands and thus we will prefer
> to use them (which also happens to avoid conditions for other errata),
> I'm not entirely sure it's even possible for a single high-level
> invalidate call to generate a batch of more than 63 commands,

Out of interest, have you observed a case where this actually happens?

> but for
> the sake of robustness and documentation, wire up an option to enforce
> that a sync is always inserted for every slot issued.
> 
> The other aspect is that the relative order of DVM commands cannot be
> controlled, so DVM cannot be used. Again that is already the status quo,
> but since we have at least defined ARM_SMMU_FEAT_BTM, we can explicitly
> disable it for documentation purposes even if it's not wired up anywhere
> yet.

Note that there seems to be a slight issue with this patch that I 
missed, under discussion here:

https://lore.kernel.org/linux-iommu/27c895b8-1fb0-be88-8bc3-878d754684c8@huawei.com/T/#t

Thanks,
Robin.

> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Link: https://lore.kernel.org/r/330221cdfd0003cd51b6c04e7ff3566741ad8374.1683731256.git.robin.murphy@arm.com
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>   Documentation/arm64/silicon-errata.rst      |  2 ++
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 12 ++++++++++++
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
>   3 files changed, 15 insertions(+)
> 
> diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
> index 55e1e074dec1..322df8abbc0e 100644
> --- a/Documentation/arm64/silicon-errata.rst
> +++ b/Documentation/arm64/silicon-errata.rst
> @@ -124,6 +124,8 @@ stable kernels.
>   +----------------+-----------------+-----------------+-----------------------------+
>   | ARM            | MMU-600         | #1076982        | N/A                         |
>   +----------------+-----------------+-----------------+-----------------------------+
> +| ARM            | MMU-700         | #2812531        | N/A                         |
> ++----------------+-----------------+-----------------+-----------------------------+
>   +----------------+-----------------+-----------------+-----------------------------+
>   | Broadcom       | Brahma-B53      | N/A             | ARM64_ERRATUM_845719        |
>   +----------------+-----------------+-----------------+-----------------------------+
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 782d040a829c..6a551a48d271 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -897,6 +897,12 @@ static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
>   				    struct arm_smmu_cmdq_batch *cmds,
>   				    struct arm_smmu_cmdq_ent *cmd)
>   {
> +	if (cmds->num == CMDQ_BATCH_ENTRIES - 1 &&
> +	    (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC)) {
> +		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, true);
> +		cmds->num = 0;
> +	}
> +
>   	if (cmds->num == CMDQ_BATCH_ENTRIES) {
>   		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, false);
>   		cmds->num = 0;
> @@ -3461,6 +3467,7 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>   
>   #define IIDR_IMPLEMENTER_ARM		0x43b
>   #define IIDR_PRODUCTID_ARM_MMU_600	0x483
> +#define IIDR_PRODUCTID_ARM_MMU_700	0x487
>   
>   static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
>   {
> @@ -3481,6 +3488,11 @@ static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
>   			if (variant == 0 && revision <= 2)
>   				smmu->features &= ~ARM_SMMU_FEAT_SEV;
>   			break;
> +		case IIDR_PRODUCTID_ARM_MMU_700:
> +			/* Arm erratum 2812531 */
> +			smmu->features &= ~ARM_SMMU_FEAT_BTM;
> +			smmu->options |= ARM_SMMU_OPT_CMDQ_FORCE_SYNC;
> +			break;
>   		}
>   		break;
>   	}
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 5964e02c4e57..abaecdf8d5d2 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -651,6 +651,7 @@ struct arm_smmu_device {
>   #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
>   #define ARM_SMMU_OPT_PAGE0_REGS_ONLY	(1 << 1)
>   #define ARM_SMMU_OPT_MSIPOLL		(1 << 2)
> +#define ARM_SMMU_OPT_CMDQ_FORCE_SYNC	(1 << 3)
>   	u32				options;
>   
>   	struct arm_smmu_cmdq		cmdq;
