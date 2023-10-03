Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C7F7B750B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbjJCXgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236705AbjJCXgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:36:09 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62191F1;
        Tue,  3 Oct 2023 16:36:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9spElrf9CqoMErQkn80DW5Se7qlmgDeQUeg4pLCP7pevac5DHn08Sg5SNOPBIEUvuR03zYe1WlgJ4uvvNtlEDlbB9VUE+T8JweQ8SYreRARi+OICXob0EXikV9kp6V0FsUCkomVMYjCo/PoHtHM72B0UN3M+hVimKwN03eEHmrx3oJmU/3CaNbillUrEjNyS472RgdZRbI4+p4r2nlqzyuCGEBEmoFgnfcu8GP2unw8lwQOuy5YBebiJszaa2WWYieW+Z/7F9FgNSvb6tH0Q+yPBuItwiiWRS+AvVSF7fEJme/urLCXg9S8s6GQPj46Oo5ABuTb5xn2I6ibLhGfhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pF4GT/GGiNuh3mlr6YxGLeQnXkd25qV+xM2xwcp13ro=;
 b=QY11mZkdeb9Msr/Eur6fFBX/iScCb5oL7dUsYkseKPeN8SWs2+ZftMOdMiyFOllk6EmNli/cRI9r/iEn4ec0qvb4d3ukJF1WmLLHEizR+Gd1ezNy4UgPW0Yhx4zd0WTAtj96ZlYLn1jRUp/ABsuAbwdSMIxoEbjsmsdKPbX4tdu4K5HUQ+7dRgV7EyMWAScWZC62hHRBHu7pcUuDswUjpxMUPyu+Zd3mTEsPopeWF4WTeFaycGKMKdJZ9/TEw0fX8gCSCBhmvAE/mkTgahHOS0iz382HuoCFfAEBobjN8NVRoFtsZwXH0hmi1hCKd9YCjMdcJ0fex0VEkQWZV82hUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pF4GT/GGiNuh3mlr6YxGLeQnXkd25qV+xM2xwcp13ro=;
 b=ijN8tj82dQt9RHdnsqOE7jcU/CZglrQRC1TbalGYVzJY4ruPZuxEio5xPv9+1NM3xWsmUQH2Km2vDu9qzkzKQkbDcPfSQJRHOJADuJG0tGzcXTIoG7db9m0ds49oMaSQLm9kIl8GJ6CcSYlnMhEW4Kd/tvy72MESoC1k7sd5ZW+X68H/klM3G1RSjhlpWZ+gLGhVpEsYvmROmlcUx5xDLddkhEFN2cxYcvPBIFLwfbwR8sMLrDWR0McG+a/pWkmnojmvBw9FdSATpVAg8oc2NBaiKvyoLGsUmA+FLbHGA8ls+6PChrcoLxE1hx5EuN0UNYb8z32tHjLGNJVwVKGOiQ==
Received: from CY8PR12CA0042.namprd12.prod.outlook.com (2603:10b6:930:49::21)
 by CH3PR12MB9220.namprd12.prod.outlook.com (2603:10b6:610:198::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Tue, 3 Oct
 2023 23:36:03 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:49:cafe::36) by CY8PR12CA0042.outlook.office365.com
 (2603:10b6:930:49::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Tue, 3 Oct 2023 23:36:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 23:36:03 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 3 Oct 2023
 16:35:53 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 3 Oct 2023 16:35:53 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 3 Oct 2023 16:35:52 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <sashal@kernel.org>, <stable@vger.kernel.org>
CC:     <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <jgg@nvidia.com>, <jean-philippe@linaro.org>,
        <baolu.lu@linux.intel.com>, <apopple@nvidia.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: [PATCH][6.5, 6.1, 5.15] iommu/arm-smmu-v3: Fix soft lockup triggered by arm_smmu_mm_invalidate_range
Date:   Tue, 3 Oct 2023 16:35:49 -0700
Message-ID: <20231003233549.33678-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|CH3PR12MB9220:EE_
X-MS-Office365-Filtering-Correlation-Id: c101bbbd-df54-4ed2-276d-08dbc46981ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J6CyWrrHDllUcEXOFpTF01E3mt2K/7joeWDfg18qTnEiyZFQQyQgM5PcjYCweamK2YVQCrq3sfEIYuTykNlXRD5i0LeHEJqo1whUq0bROwuIdEoMUIyB9W0lcnEf/JUqTlfSGrU6ylNYhtLoEYI0jmuiadMntWK+LAsLyMB+6Cxsx6J/grKKBYsmXOaG3L7KW739gMxR35izZRquB4GwQOOa3U27aBwHL3svKqmiYXC2mmurTAbEh9u+fp9w2QARroC/o063tleXnNqGTFY8dIdmh46xdOPTrrzZj1ZK+tRxZrZKUM9H1/N3r1C15Fzhf8YaFcFVT9IOUMAzRf98myhMUPWmt9NYk6cDVEk5AFT1bWGoFPg614EcBWmCnaHyHIPajaSGUsrlpqDQZ+TFkUWxRQ4EI7UCsxJ5u5TYZFBjEAVbA7lgbd5REjo46tEhUa+3Hf3lUXPYGajJAHlCh2bW5x275N6iHi36vZLALfZVXBDgR7bcFI4Q4A4X2c/K7KQcFIJ92nGH/26jNz5oRljOZt4Jddr2iuq3PUHfIz5jkaSuKIsQi3lILj4Pa+2ZHa/0JDImF5yS235wJ+ZFC/7UXPZ+YDblNPQQXWhhlAYdNPTMysN0eljSAVPzlUmkt1tA4hWkkRKHO1lbD2UG8P6L2KIdwzqf+Z7RHGeHFVtdhoLM6YVc8eVQDoUFDpP5gDq9lhTL9Hq+mi3DaHpjpcsFX8h7kVfy6STA0g8tcJlWMN3B8jy6chJKVJ3pf3Z+jZU6pDpDfF9vACCtO7iOZlQ/BvgWKX4fe3NflCnL+Iu+g+j8bS30XiZy2b0uWhm3
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(82310400011)(451199024)(1800799009)(186009)(64100799003)(36840700001)(40470700004)(46966006)(2906002)(40460700003)(86362001)(356005)(2616005)(426003)(6666004)(82740400003)(478600001)(1076003)(966005)(336012)(26005)(7636003)(83380400001)(36860700001)(47076005)(54906003)(110136005)(4326008)(316002)(7416002)(70206006)(40480700001)(36756003)(8676002)(41300700001)(8936002)(5660300002)(70586007)(7696005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 23:36:03.0188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c101bbbd-df54-4ed2-276d-08dbc46981ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9220
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit d5afb4b47e13161b3f33904d45110f9e6463bad6 upstream.

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

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Link: https://lore.kernel.org/r/20230920052257.8615-1-nicolinc@nvidia.com
Signed-off-by: Will Deacon <will@kernel.org>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 27 ++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index a5a63b1c947e..98d3ba7f9487 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -186,6 +186,15 @@ static void arm_smmu_free_shared_cd(struct arm_smmu_ctx_desc *cd)
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
 static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
 					 struct mm_struct *mm,
 					 unsigned long start, unsigned long end)
@@ -200,10 +209,22 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
 	 * range. So do a simple translation here by calculating size correctly.
 	 */
 	size = end - start;
+	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_RANGE_INV)) {
+		if (size >= CMDQ_MAX_TLBI_OPS * PAGE_SIZE)
+			size = 0;
+	}
+
+	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM)) {
+		if (!size)
+			arm_smmu_tlb_inv_asid(smmu_domain->smmu,
+					      smmu_mn->cd->asid);
+		else
+			arm_smmu_tlb_inv_range_asid(start, size,
+						    smmu_mn->cd->asid,
+						    PAGE_SIZE, false,
+						    smmu_domain);
+	}
 
-	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM))
-		arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,
-					    PAGE_SIZE, false, smmu_domain);
 	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, start, size);
 }
 
-- 
2.42.0

