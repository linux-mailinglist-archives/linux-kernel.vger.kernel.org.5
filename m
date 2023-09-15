Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020617A17B3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjIOHoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbjIOHoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:44:04 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEFC98;
        Fri, 15 Sep 2023 00:43:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kr4ppbqvQZdkmpgBrJBE7hTytVywd/S/3RDFk9K+0X/MQFaRQKZTCo2+l+cANxvBxrgvh7PFE8wSB98GenCj8/Gg1KehAFshVKNiQ8uKjrN91AYrQa7y/mMRfZqSnbrXMOr3Y7BlPTtjXUQt9GrZ9jbf4CSm6BbpOSVU0CPrWBwInzfOvehjsph4ayaGoDaDTiQlN4aUmk2X53KanVE7uxSiLB0MZ3XI6YUrsuBX9LNws2rDACUsCGbh+Rtuh+cP/K0Cen6p+WO1RMUR/WqefMKFJCu3GMqWhK9aB9t1ZUj3D/oubSUWGZsq02iy2GUQPPnffe3j/hQyK7MiM4QdCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLRlaseHNfvFqAUPP1xqLvAociwLP7WPJuxWRONT/kw=;
 b=CQ5MSHBxuZ7HPMAKZfDbmZC8RAc7OHR6r+IemiIMqRXNwtzW9GxtcSKcHJpg5gshgACVcp1tyoAU7peNi5H0OD82wYgZdFNdsja6qqwnIAhVzglz9Q40R/ARePIkCnmF+KTk8+sLimr06bba42CkjDXUDoqESpLZRF4m9Nb1F1/1zR2nMBF7zkFlKWJrnA91nSBFqPOxOkCP2VGxtKY1fHabCf4Y+dFCxLSvuh1f1ZHSvP+WIEsrrefMADapma2/+idRbUIHePvsJA8C5g5lqxXywk2ixgxJ9grG8iJee/rNnSyDaG2nZCvH+puap4A9iK+LNG925tQDU4zROwgxXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLRlaseHNfvFqAUPP1xqLvAociwLP7WPJuxWRONT/kw=;
 b=VlWjsBRkaFKC+0eWwHqKfUH8CHoZOMb8PFH3koju5l3KX6FykFc3U3vW/v7xpZtK0hnUywv/tnNgQWDyaqrKYApr3DdRVAKLrdEPwwQ7wwWHE7osRaPobz810ulMrJFmZoUjhFSelvQG7tvGJQzKZm2kuSC6LRDVrgTJcb0Ou4i3kUzDUAA+TzUvvg7w6ollW5knmkO2dgMPBCgyvt21CENRf9YNwZNcJ5mWMoVU2n0Whq98oQpVDUVcWoio54ucznse3msERoyvvCriELS6dXO9nVqS60bWZLWpIymmf6POlsb5uiYjkEuyntVMWrIhF8Oqds4FB7sj84o613JB7A==
Received: from MW2PR16CA0011.namprd16.prod.outlook.com (2603:10b6:907::24) by
 PH0PR12MB7815.namprd12.prod.outlook.com (2603:10b6:510:28a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 07:43:56 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:907:0:cafe::b) by MW2PR16CA0011.outlook.office365.com
 (2603:10b6:907::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 07:43:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.19 via Frontend Transport; Fri, 15 Sep 2023 07:43:56 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 15 Sep
 2023 00:43:53 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 15 Sep
 2023 00:43:52 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Fri, 15 Sep 2023 00:43:51 -0700
Date:   Fri, 15 Sep 2023 00:43:50 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <jgg@nvidia.com>, <jean-philippe@linaro.org>,
        <apopple@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix soft lockup triggered by
 arm_smmu_mm_invalidate_range
Message-ID: <ZQQLNmmAOsNmvtDs@Asurada-Nvidia>
References: <20230901203904.4073-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230901203904.4073-1-nicolinc@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|PH0PR12MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e8ab1e6-37d7-4d34-b612-08dbb5bf8452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3MAuxDwagh1DDI5VtckgUF9rp8/QEi5GZimdpGQQKuwByT4lHSNR58RlG2wLEEILWR8hiAvYpWVdrqAQ2IzRXBm6OehfCStRjh0sVJXqScSfVrv3IGQ99Ib0k5LA1wVFlfjB1+Z9n/h+oCSu84cV+szG+5Do/VVzCRFMMsRslEB4eatL7NaAOSZw7a2xrnmStrt1YoqNkoH4Q84ZKGllvyKZeQTqmmYv+psSIvs4vNBIrbtycpIAItiAvYjUWTR7LzPFNWAcsUQmUinnHfaYm5LaNEEonzSfJ6ANSOzB1EAN381QZfU3APwn1XoJ/m45gmyLPFngLfHZ4YgcQfPw+qsEdLayjHzksbq8GqzooyxFWMZzjs+6oqBgbdJNg/FBs3d91g6oEZBQRFb3QSD3xGgoJ/L3eAqrBQ0q839GVwtGmUNQduxVLYPXoFvA1pVBC3A6QVQ6DqeBTXv9itd+sxfCI65N+Xs/FgZt1yAhUmhmNY4R4r0U0GJmsKJvY5Bl46SEANj7yT8xqdn/AYgUKhBkyRcGGxBZ7lOt+sX8hbqKYzSfK3+Ee+UgZ4x8p2DvxrTFV8HbQdeI/RRCqnCSrgH6hMrJn8FtqlCd5vvfSCZk2FvswvUev2bQF+bpNOlEx3gwgCIS0nSKh4uOai5usCYln8QJ8w4xF4bei0UBD3NUY7m0ZaSWGQrUwd7z7Gqs0laJO+C1tXWrhfZ2nNM9q6QGoJCbIB6d1zwJBceYKLJJjmGxqgfYeaby+7yzGeuC
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(82310400011)(186009)(451199024)(1800799009)(40470700004)(46966006)(36840700001)(83380400001)(336012)(426003)(4326008)(8936002)(5660300002)(8676002)(26005)(82740400003)(47076005)(9686003)(36860700001)(7636003)(356005)(478600001)(55016003)(110136005)(316002)(40480700001)(41300700001)(54906003)(70206006)(70586007)(86362001)(33716001)(2906002)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 07:43:56.5357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8ab1e6-37d7-4d34-b612-08dbb5bf8452
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7815
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found this patch cannot be applied to v6.6-rc1 due to conflicts
with some new commits that were merged during the previous cycle.

I can redo a version rebasing on the v6.6-rc1, yet the new version
won't apply to earlier kernel stable trees. Is there a way to make
it happen that both mainline and earlier trees can have this fix?

Thanks
Nicolin

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
>         tlb_flush_mmu_tlbonly {
>                 tlb_flush {
>                         __flush_tlb_range {
>                                 // check MAX_TLBI_OPS
>                         }
>                 }
>                 mmu_notifier_invalidate_range {
>                         arm_smmu_mm_invalidate_range {
>                                 // does not check MAX_TLBI_OPS
>                         }
>                 }
>         }
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
>          */
>         size = end - start;
> 
> -       if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM))
> -               arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,
> -                                           PAGE_SIZE, false, smmu_domain);
> +       if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM)) {
> +               if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_RANGE_INV) &&
> +                   size >= CMDQ_MAX_TLBI_OPS * PAGE_SIZE)
> +                       arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
> +               else
> +                       arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,
> +                                                   PAGE_SIZE, false, smmu_domain);
> +       }
>         arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, start, size);
>  }
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index dcab85698a4e..79a81eed1dcc 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -326,6 +326,15 @@
>   */
>  #define CMDQ_BATCH_ENTRIES             BITS_PER_LONG
> 
> +/*
> + * Cloned from the MAX_TLBI_OPS in arch/arm64/include/asm/tlbflush.h, this
> + * is used as a threshold to replace per-page TLBI commands to issue in the
> + * command queue with an address-space TLBI command, when SMMU w/o a range
> + * invalidation feature handles too many per-page TLBI commands, which will
> + * otherwise result in a soft lockup.
> + */
> +#define CMDQ_MAX_TLBI_OPS              (1 << (PAGE_SHIFT - 3))
> +
>  #define CMDQ_0_OP                      GENMASK_ULL(7, 0)
>  #define CMDQ_0_SSV                     (1UL << 11)
> 
> --
> 2.42.0
> 
> 
