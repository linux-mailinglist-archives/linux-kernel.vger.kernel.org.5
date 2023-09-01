Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4449E7902DE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 22:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350738AbjIAUjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 16:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjIAUjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 16:39:31 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEC4E7E;
        Fri,  1 Sep 2023 13:39:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFBujdxVLfaEmjhi2FJpC3qmEXDO2pxco5i7XG+7awDt5ok7gU1f6TY92IZ6JUWhqBkyiiRB+XFiUEp/nbxrqOtuUYXqJhV2YsbMMp+2HpZ1zjNL7owjLlcV7s1S9g9wZToYmawGabNI9e99FGnj1XCzv/p4Kxhxb64c2WVHgr6Mcqt9v1pMIgQ7zdMz7zCkvru5haR1NbIdDTJrvLy9aGT1WziC/9Z1IAf5VPHnyVdBzO6P/eb+KCTBuBqoc/QU3gcIkHWB3wXuAFq2ZiSbY6CG4r7Udw5GIZo224I1QUg5vBdPUKP6UJgO+a5HfVlC4QZVTkq8TzqpmuGHMnXlzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZWtsA75+R+/WHYVx5TDtbbksHfgjhxdFWoFviWiiCQ=;
 b=eO52CqZYeqTmNoq/RnrE9VQ5rGEAHbUpMHCdMBC5ORBnzVyG5FZsEHF/3Cd2OQBv/NzcADCm04uvkHWRXdBDlCySTSD4XY9alrLBdUpZts7Sp3TPdkU8rIb+V3sh+nCvxllJ3NtKa8VFConguA4abX5RBImEXujFthe0uebXaprbsyEywQrUvmdskjP+SkvStJQU+5N1bLrQc7rtiNL9NjzUJeqsjwGAsoV8xy/KFFkBVwVeCwly5DWMeOeVD8/mo/Td/9p47mWBmPUiKSE8d5yFXNZR27qI/9u7Ytzj55/5b9FRFcltMjgrjqzBixr082NHbvPqoW7xTHXdAa4Fxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZWtsA75+R+/WHYVx5TDtbbksHfgjhxdFWoFviWiiCQ=;
 b=NIN5FJ7hr9Df00DeFxnXZY42dfHLjAOXCv+Yw+2uiWmeqddl2Fad/gR9Ukf+0dyi+rC1mmI+QeTD2lzhFBDENCb8asVMneuXen6whCHHIMzBTiI9zLehKNPTGjH4xsR+PLq7XfE699WdU3GruujLCCBrvX1bAehGt+/sB8SJ08MMqiaiaeRtOkNkg9NPlSwuru3WUJizcOJsRSt4V0uvob5ra7zmZ7V5FX/P6sVtcxZA7X3lVgF/EY9aO4Ddp91Y4JLl9PLKUKzfHmhYT49LfGbYh1W3aIKhYo5T4jz7RYGfFaSM3gpP81mWYHu6GBHy2QZKYxxO7UWZChElkx6lZw==
Received: from SJ0PR13CA0027.namprd13.prod.outlook.com (2603:10b6:a03:2c0::32)
 by DS0PR12MB9322.namprd12.prod.outlook.com (2603:10b6:8:1bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.27; Fri, 1 Sep
 2023 20:39:26 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::9b) by SJ0PR13CA0027.outlook.office365.com
 (2603:10b6:a03:2c0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18 via Frontend
 Transport; Fri, 1 Sep 2023 20:39:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Fri, 1 Sep 2023 20:39:26 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 1 Sep 2023
 13:39:13 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 1 Sep 2023
 13:39:13 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 1 Sep 2023 13:39:12 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <jgg@nvidia.com>, <jean-philippe@linaro.org>,
        <apopple@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <stable@vger.kernel.org>
Subject: [PATCH] iommu/arm-smmu-v3: Fix soft lockup triggered by arm_smmu_mm_invalidate_range
Date:   Fri, 1 Sep 2023 13:39:04 -0700
Message-ID: <20230901203904.4073-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|DS0PR12MB9322:EE_
X-MS-Office365-Filtering-Correlation-Id: b5ab4b95-57b0-471d-0085-08dbab2b8853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZmgWYeIWh+uEA7y0A7SPnRFxuLpEz90EnJaJSiArDOUGk/ubIXxKH5Nqb3jmftkuXKdL1ZLEce1dy1tYkR8fftxePZzj5Uv0DppVpIfERX/gA64VQ4X0/b5Qolo8EdpoF6XOxVAtmjQnM5yfW42ijh8pRwmu+lRSz0KqpKcARgBtoxFMAaemX0Zsa1WuNKxWWjnKffRFSMO3NqtupRMy6XPi4cWEzZfH0Z7voUXrPyk5BA2idwKOFgO+57b4HM7b+ZOdZMj3gS+SmgLG7wdHrWq5cSBfAxVCTsbHDtpprY9j7Bm24vbKtKNZvopocOpz9kBZSWrrhi4XEqB4H6tprzCqqb175yRMRxUEfC88ifVqLDVq2oyMU1c115N2EV4QK47R4qcv0dPcTIg59USx6JrSTXMaJFv7PiS9r+IbTxMAkCUhMEsU6VDcucGAAhTSe6fWEqXg+DekGt37JxMQjqsdIW6p0HBAAhFia1h6Z0H0wYabID2f5IRefA9lh/QjZwwF9OY5yMyVynEXiRUOOCD+cJ1b2RnUDy5ReV5HVTUKaLTqB0QNa/STGsy9O/JyUs1reIm7eCW0Cf7eFFmh1KX3cGk6z5x35ttCMSdJRu9x4w6NzRHoClK5z5qtrdjkUKEYh9f8WtKB6ZfUwcC6Dk/noQLSLQGZLOv+kWPAshJfvxlZxk5rjq0jWb7pbXsKbYFYX6DCAHuymAhwZE27XNnkkSbHFxc7Av/Vdvx0zXb+7wo6XfGE1zeRhZU0igAj
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(46966006)(40470700004)(356005)(478600001)(6666004)(2616005)(1076003)(7636003)(82740400003)(110136005)(36860700001)(47076005)(54906003)(426003)(336012)(26005)(83380400001)(70206006)(70586007)(7696005)(2906002)(5660300002)(8676002)(40460700003)(41300700001)(316002)(40480700001)(8936002)(86362001)(36756003)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 20:39:26.0579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ab4b95-57b0-471d-0085-08dbab2b8853
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9322
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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

The commit 06ff87bae8d3 ("arm64: mm: remove unused functions and variable
protoypes") fixed a similar lockup on the CPU MMU side. Yet, it can occur
to SMMU too since arm_smmu_mm_invalidate_range() is typically called next
to MMU tlb flush function, e.g.
	tlb_flush_mmu_tlbonly {
		tlb_flush {
			__flush_tlb_range {
				// check MAX_TLBI_OPS
			}
		}
		mmu_notifier_invalidate_range {
			arm_smmu_mm_invalidate_range {
				// does not check MAX_TLBI_OPS
			}
		}
	}

Clone a CMDQ_MAX_TLBI_OPS from the MAX_TLBI_OPS in tlbflush.h, since in an
SVA case SMMU uses the CPU page table, so it makes sense to align with the
tlbflush code. Then, replace per-page TLBI commands with a single per-asid
TLBI command, if the request size hits this threshold.

Fixes: 51d113c3be09 ("iommu/arm-smmu-v3: Make BTM optional for SVA")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 11 ++++++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     |  9 +++++++++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index a5a63b1c947e..7ec3f5219250 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -201,9 +201,14 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
 	 */
 	size = end - start;
 
-	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM))
-		arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,
-					    PAGE_SIZE, false, smmu_domain);
+	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM)) {
+		if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_RANGE_INV) &&
+		    size >= CMDQ_MAX_TLBI_OPS * PAGE_SIZE)
+			arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
+		else
+			arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,
+						    PAGE_SIZE, false, smmu_domain);
+	}
 	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, start, size);
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index dcab85698a4e..79a81eed1dcc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -326,6 +326,15 @@
  */
 #define CMDQ_BATCH_ENTRIES		BITS_PER_LONG
 
+/*
+ * Cloned from the MAX_TLBI_OPS in arch/arm64/include/asm/tlbflush.h, this
+ * is used as a threshold to replace per-page TLBI commands to issue in the
+ * command queue with an address-space TLBI command, when SMMU w/o a range
+ * invalidation feature handles too many per-page TLBI commands, which will
+ * otherwise result in a soft lockup.
+ */
+#define CMDQ_MAX_TLBI_OPS		(1 << (PAGE_SHIFT - 3))
+
 #define CMDQ_0_OP			GENMASK_ULL(7, 0)
 #define CMDQ_0_SSV			(1UL << 11)
 
-- 
2.42.0

