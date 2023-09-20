Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAF67A71F8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbjITFYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbjITFYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:24:32 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CE5E53
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 22:23:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNMqmqLIJxr06vppdkWsPFDb141XAzrJiWCLocf6bA7vqPmcmVuDgVDYCsTzzjVJgTSgGcmhSPyTM4ebU/U5jmzc4ZhbFTbc3zZcG8H6tEp1bLIrbf2XS//spKIBET2nKxziKtIRzDWoXZrjdz2Rk5ZpwqeQ6r8nR8hekefSAnJfmQ5F5jHzY/xnzxG+QWVVhecJ4Q5TqmnSaKKrhsDhoFwrS1xVoeinr671c/lsfVO1NGxIN8+twxfuL+oqKVYh9aSfqc+/ixINDB3UUAAEqFvCrufT8CIvuquJMJt70rOXWp0w+eMLYO3WRbbrC+e9i/lth7x1XzH57jQYGveVOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RbGyoU1D2JTWOC7qyW0hbiyFCQ5nuBQjyao0QqUSnA=;
 b=VmnZUcx6K9cMJVRXysccJuJUnIBGWFAMX6I1M54eI758pSSSMTrVVky3pODgNO0vUO8ZYWkt8Dx9FjXKgkTSOvkfbatC8iJyJGFqRpz2gHqdf1CMKVQWO6mNBLDF8xp8bjcaxE8kJKHgGZEDCnuIbQmorIMBbXJ+KW71BR31pVk4Q7IX0OQZHYOsnhmOmRRjirjPjErWynRRCfj/jLwhxdVvuRcT+c7XKURjxOo1cVR90MzYbqRa94HNDjB+0gTnUvO8/QJAq98nbV4dP+HMGNpMCkIZGW9OefeUypzLbbZ90JjNYFVV1miGgzp8vnmj5w0o39jtMpAkj4pmrabrjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RbGyoU1D2JTWOC7qyW0hbiyFCQ5nuBQjyao0QqUSnA=;
 b=N4AuU1Lbg/S6KlvfLs1vHToYaoaKcpRgxF630lZ25ld1oeL0OLsVkkbRJwD6EjjbiDDfFVeWIQkVrhra2TXhvtYicUD0TOzeVDdBbQeBwmzns0peAH9PP5pmUMNuM3xPnRwB7/VGJNkEYtvMKhCHKn4MBUwBVAmmMcyOhYFnlsWdTZ2rIGs4XU1Pnh6OprSlOduSmKiaLAXGlujd9TvZ4s+tS6mZCa9ZbWz28Y5NvUJGQjd4AkUPCea6zBWmrKMgeehwpt3wpuWF625c5Dl2vmbfKwj6Na/8EjvGgJ/Xxqc+QcuqNxjHWLpAj9rxvavWqwjZlpo7evk6p/VGlIJ47w==
Received: from DM6PR05CA0057.namprd05.prod.outlook.com (2603:10b6:5:335::26)
 by SJ1PR12MB6219.namprd12.prod.outlook.com (2603:10b6:a03:456::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 05:23:17 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:5:335:cafe::2d) by DM6PR05CA0057.outlook.office365.com
 (2603:10b6:5:335::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Wed, 20 Sep 2023 05:23:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 05:23:16 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Sep
 2023 22:23:04 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Sep
 2023 22:23:04 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 19 Sep 2023 22:23:03 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <jgg@nvidia.com>, <jean-philippe@linaro.org>,
        <apopple@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: [PATCH v2] iommu/arm-smmu-v3: Fix soft lockup triggered by arm_smmu_mm_invalidate_range
Date:   Tue, 19 Sep 2023 22:22:57 -0700
Message-ID: <20230920052257.8615-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|SJ1PR12MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: 0759a090-96b7-4b07-a487-08dbb999b1de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XoRL3oRi0Q6bcAWflfVqQjwOAQ37QnTgodLR16Oe7fI3Y3ihYZehsABLBU0ascN86h4QyJuL0P5ZQGh8QtL/+8KwamTpx67LQVY8975pl5IzQztch//mWoYo1rfgtAuEbYyypzbgf4cDtDCno/Ni0pFiHaQYKPPsg8fSi2bF+PhFrZABxN1Ajs2x9pKXncNoduR83Fg9nkoWNlVvmJlyq6oTfeEn29pu0W+M5XCFc+pjCqkw7i5NWkBOlQ1+gX+X2AjGTKkezXFNOGP28vMNTVhPrkFuiFd39rh/41C9A8hurXBehhnK1hNS8eZzpwxJvFNzGq6HDRYHrOP8x/OqI8BcqGpR5Is5PZR8JTRk+8pHqWs/+bL010a4t+9LR9Ck6TsLscdqIiIyfSZECWX1bfD1tWnFRBj1s+3qlsc4qcLqPcVy4fZiA7rcYBnSE8/ivIZvwjAvc2QT7UaDl/zT3qgI0zi5rYN1NnDZipZIWJIum+KhGoTk3CbNRHHCmLwFW62Vyr8DKT2mCnC47cDQYnWoPNmgrUJWW1un8UWkadTnYKeEjzpuVAdRXs8+dxB9lYUU7jrLwRSrhYt0HMysXZU+9l0pKfzGboH5v5L6j7DjhH029nPNR1Kl15xYTkwDl8PysKA5HJAnq7Dc9aZWYimDm3TLOlUmtQze5rkvFzHgd4IIA842bV0T7V/VsCMXD36xn3IvZ3T5BZfz60Wfuu2mi1sCWEzYS/qJ3azqG8n4HjzeX2iMZSRR/cpELUxYA/DWr+/jjpn/uckXjqk2Z3kCArVNBOp/nphBSVjOwGs=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(186009)(1800799009)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(478600001)(7696005)(6666004)(40460700003)(86362001)(36756003)(40480700001)(82740400003)(7636003)(356005)(36860700001)(2616005)(1076003)(47076005)(26005)(426003)(2906002)(336012)(8676002)(83380400001)(8936002)(5660300002)(110136005)(70586007)(4326008)(41300700001)(54906003)(966005)(316002)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 05:23:16.6944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0759a090-96b7-4b07-a487-08dbb999b1de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6219
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running an SVA case, the following soft lockup is triggered:
--------------------------------------------------------------------
watchdog: BUG: soft lockup - CPU#244 stuck for 26s!
pstate: 83400009 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : arm_smmu_cmdq_issue_cmdlist+0x178/0xa50
lr : arm_smmu_cmdq_issue_cmdlist+0x150/0xa50
sp : ffff8000d83ef290
x29: ffff8000d83ef290 x28: 000000003b9aca00 x27: 0000000000000000
x26: ffff8000d83ef3c0 x25: da86c0812194a0e8 x24: 0000000000000000
x23: 0000000000000040 x22: ffff8000d83ef340 x21: ffff0000c63980c0
x20: 0000000000000001 x19: ffff0000c6398080 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: ffff3000b4a3bbb0
x14: ffff3000b4a30888 x13: ffff3000b4a3cf60 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000000 x9 : ffffc08120e4d6bc
x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000048cfa
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 000000000000000a
x2 : 0000000080000000 x1 : 0000000000000000 x0 : 0000000000000001
Call trace:
 arm_smmu_cmdq_issue_cmdlist+0x178/0xa50
 __arm_smmu_tlb_inv_range+0x118/0x254
 arm_smmu_tlb_inv_range_asid+0x6c/0x130
 arm_smmu_mm_invalidate_range+0xa0/0xa4
 __mmu_notifier_invalidate_range_end+0x88/0x120
 unmap_vmas+0x194/0x1e0
 unmap_region+0xb4/0x144
 do_mas_align_munmap+0x290/0x490
 do_mas_munmap+0xbc/0x124
 __vm_munmap+0xa8/0x19c
 __arm64_sys_munmap+0x28/0x50
 invoke_syscall+0x78/0x11c
 el0_svc_common.constprop.0+0x58/0x1c0
 do_el0_svc+0x34/0x60
 el0_svc+0x2c/0xd4
 el0t_64_sync_handler+0x114/0x140
 el0t_64_sync+0x1a4/0x1a8
--------------------------------------------------------------------

Note that since 6.6-rc1 the arm_smmu_mm_invalidate_range above is renamed
to "arm_smmu_mm_arch_invalidate_secondary_tlbs", yet the problem remains.

The commit 06ff87bae8d3 ("arm64: mm: remove unused functions and variable
protoypes") fixed a similar lockup on the CPU MMU side. Yet, it can occur
to SMMU too, since arm_smmu_mm_arch_invalidate_secondary_tlbs() is called
typically next to MMU tlb flush function, e.g.
	tlb_flush_mmu_tlbonly {
		tlb_flush {
			__flush_tlb_range {
				// check MAX_TLBI_OPS
			}
		}
		mmu_notifier_arch_invalidate_secondary_tlbs {
			arm_smmu_mm_arch_invalidate_secondary_tlbs {
				// does not check MAX_TLBI_OPS
			}
		}
	}

Clone a CMDQ_MAX_TLBI_OPS from the MAX_TLBI_OPS in tlbflush.h, since in an
SVA case SMMU uses the CPU page table, so it makes sense to align with the
tlbflush code. Then, replace per-page TLBI commands with a single per-asid
TLBI command, if the request size hits this threshold.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---

Changelog:
v2
 * Rebased on top of v6.6-rc2
 * Added an extra pair of braces for multiple conditions
 * Moved CMDQ_MAX_TLBI_OPS macro to sva.c as it's tied to PAGE_SHIFT.
   Non-SVA pathway will need another threshold based on TLBI granule.
 * Dropped "Fixes" and CC-stable-tree lines, since it won't apply to
   any older tree. Instead, will submit another compatible patch for
   stable trees.
v1
 https://lore.kernel.org/all/20230901203904.4073-1-nicolinc@nvidia.com/

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 4d83edc2be99..8a16cd3ef487 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -185,8 +185,17 @@ static void arm_smmu_free_shared_cd(struct arm_smmu_ctx_desc *cd)
 		kfree(cd);
 	}
 }
 
+/*
+ * Cloned from the MAX_TLBI_OPS in arch/arm64/include/asm/tlbflush.h, this
+ * is used as a threshold to replace per-page TLBI commands to issue in the
+ * command queue with an address-space TLBI command, when SMMU w/o a range
+ * invalidation feature handles too many per-page TLBI commands, which will
+ * otherwise result in a soft lockup.
+ */
+#define CMDQ_MAX_TLBI_OPS		(1 << (PAGE_SHIFT - 3))
+
 static void arm_smmu_mm_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 						struct mm_struct *mm,
 						unsigned long start,
 						unsigned long end)
@@ -200,10 +209,15 @@ static void arm_smmu_mm_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 	 * different from IOMMU subsystem using the last address of an address
 	 * range. So do a simple translation here by calculating size correctly.
 	 */
 	size = end - start;
-	if (size == ULONG_MAX)
-		size = 0;
+	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_RANGE_INV)) {
+		if (size >= CMDQ_MAX_TLBI_OPS * PAGE_SIZE)
+			size = 0;
+	} else {
+		if (size == ULONG_MAX)
+			size = 0;
+	}
 
 	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM)) {
 		if (!size)
 			arm_smmu_tlb_inv_asid(smmu_domain->smmu,
-- 
2.42.0

