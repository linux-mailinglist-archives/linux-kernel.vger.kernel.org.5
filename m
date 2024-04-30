Return-Path: <linux-kernel+bounces-163330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A6E8B6989
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFB43B21454
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC4017589;
	Tue, 30 Apr 2024 04:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IA51PXV/"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017AB134BE;
	Tue, 30 Apr 2024 04:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714452257; cv=fail; b=DajK5871+0rIZkQ9/PY8jIT5X55A4Y2Mt8aRZP0iaUskW8Q/rg2x8eGkh4CE3mluwkv2T3tNW2FvrH5gdgxYlg/GwkEKdr+p8iVb2OCGAaoSUB/1JSVij6uBCDE1oU5hjZtQ9yyfXs0VxQ0u/jS5IRLDs90zGmAeHjdEbsJN3sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714452257; c=relaxed/simple;
	bh=R95Zd8bG5nyFySlHcpcnTrq/y5Z2MR8BA2caSbxp15c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iSCqhIkgFzn+bwHN/t3Xc6NDxwL0XM/eHUNSGX6VJm0LS/dl3vRZWta3wEXvqgtGxzfxvl6nj5/WqnZxtcZVAGRLQ4kIkl06wMER35oAQKj24JBm67uXM2Hz8IWF/4aa+dHhd4Ky9IUnFBE5nFPCnpfcKZ4vXNKtjuXKTCX3cSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IA51PXV/; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTo/HmrjJrX5i2O+MtFHvtFBgg9/G4AhioutfN5ayA5F0AuHcTiMe/4P4Rc7Wga+4GQXgXqQwDeOkLvR1ABfOjyhiHe5yAzyiiSwI7HU+EN99ihAtF05YdkdO3ACT9NxYqIrPei9C6frIVQWUl7ZwinJWB1mNKJYWd24RfcrHmAGrf7G0kuCcFoA/oK4uDTF/4E9tonSihA7cuRDWh4iK+QglTIrnXpPCK3/3W6ZGIesgEjT4domnPvHnJs+eBV/F5I0YlbTYrrx4jzKd94T+kvonv5WAS7D9Adys3yO6+qS8RExXdCCArMqtd7on0KbVcULfaYKElJn+rdIDdW6/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gs43R8bMby/zdQZJF5aoXuNZ1WrhEw/OV5VOXDXs3S8=;
 b=mF2y/VPeiiCg/SuX/KGGAAhV56kK0Pcd/esNqtCeWWR1owadV2q+J7Aymwtim0CNoBWOVL6oWoUC/E0vlsiy+nvBLvD/k4xC/qpdU9P1hR0Ci10jSeXBnIdZcZ9c+XdWuToti1m2aQGJrazkpOT3emqYid98Cf1cElQ/c+9lbg/MgGRDztv6v6ZFCokgOmsa06kfCJyS6pj819waAdnn5XeosFjog2Yq9bo5KP8EpZeMpkTrqt5zwx2OgEiOqC+OF7XmtghrsARfisQ/0nMHgat+ObS6GghB0/3L/T6MEfQGWPz2PQfM4Jd9uf4HNIgIy06f0Z8AJDrXOTpj54rvkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gs43R8bMby/zdQZJF5aoXuNZ1WrhEw/OV5VOXDXs3S8=;
 b=IA51PXV/DYxQYf9A4UdBAy8rXnqn0HkBWz7IVKp/ySIZxP0MQ1+s0DSdfafeeUbPBvbF1aGXRFDDSkZ399iUBcJc06TsEyBBu7SfCymUhHxFjmCubH0gOmydv+goTgqeLSiKBZbqNUuA2JhXeDL3+P+HwAa5TB4hsYOPkUXi9Wb3URfxrkFUMPEyKv0FradNOFwTuotXJf+guK6ZsAgdeaTpftZpJG9vJM+RJtbP1kG5gGqlqOyEGwPEJY9kdWj9O7c67GyScPA2vJMZiV7Yy3MKOeSN0sfjGT/WBz6bkWYgqdzKdHRi2XBo/HMM9mAytxXDUrf/I2xywMlFrzJUAg==
Received: from BL0PR02CA0017.namprd02.prod.outlook.com (2603:10b6:207:3c::30)
 by DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 04:44:13 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:207:3c:cafe::bf) by BL0PR02CA0017.outlook.office365.com
 (2603:10b6:207:3c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Tue, 30 Apr 2024 04:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 04:44:13 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Apr
 2024 21:44:08 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 29 Apr 2024 21:44:07 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 29 Apr 2024 21:44:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v6 2/6] iommu/arm-smmu-v3: Add CS_NONE quirk
Date: Mon, 29 Apr 2024 21:43:45 -0700
Message-ID: <81d79f51c69604a38ea4f72c8ac2c573c52e8609.1714451595.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1714451595.git.nicolinc@nvidia.com>
References: <cover.1714451595.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|DM4PR12MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: 70bae28c-ecc0-41da-730c-08dc68d02f14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|82310400014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AYcFc4NQhCc2V7dyelOnH3moc8d46NG2E0pi/UEW61LSl47+QMY7h1tvHXhA?=
 =?us-ascii?Q?56NZu8yhWLydOujuHdgiH6wzEXUX5v5WfxjysXGSsHE7OJ+yTLEfv8xuVx8n?=
 =?us-ascii?Q?U7pRXLcY8AqE5gFcw7ts2pSL1FgwFOndFWuDlUa36kTxa5phBdPE7XsZCPLJ?=
 =?us-ascii?Q?pggQp/0104ilWUV1Xznh9LQ/927kgI/BC58Z0ej+GgIPoG6KR96RR6sa7rQf?=
 =?us-ascii?Q?YAldu8HaYxqlED5RlS2GorJD7qnHy4qEg1Im0YYPPoMWj/X1rr2m81xvy2Gu?=
 =?us-ascii?Q?pCw3C50c8FwiXxCZJax0/Y/WEV5qlB1mo0Ah4RiWNQ15UPxP4nMmySnlbNof?=
 =?us-ascii?Q?fSEuaa3pfih/XcU2Xj7KJLTSzlTD5C8q0EzxJ4hOkci/JngNrRJ13OKIu0ht?=
 =?us-ascii?Q?Wb2D77CrYRBvTx1z8C+czquKfTgNELQ5rrBYQrqhWyCScmAtrVoucvrcp1m1?=
 =?us-ascii?Q?RVhmrAEyYPhNZOC/8cZCUoXlIcOo2qJA8mCUe7+FcvFVNUy9iISmvm0lxHYS?=
 =?us-ascii?Q?Us06C58glUo9sOAuAUCN9lYewwC7Ze41zvOF9LOkHkbZN+MN61rJkf47SPKm?=
 =?us-ascii?Q?TREVi6udH3Vv17Nb8z3Rb3v7V4iZSOK0VZtiiQpKEsNpRbExiqV25KCUvqQD?=
 =?us-ascii?Q?gmF/WK7oBluJbfHB4wPBpM1h9fFE9URwWZdiW/HE4IccqNSAiJrRt8rBRKFu?=
 =?us-ascii?Q?dGcViFkLB9gGqTikd845scfgpdYSW9aoS8KVN5EocQR7K0l0ixjKCqS6tDGn?=
 =?us-ascii?Q?YXO9Xx9RfWWya/OBQ20/HGCfreDb5L6SWPlX4vqG0f/q6FdktNjH3GGc+B+E?=
 =?us-ascii?Q?bUMWtvOut7O3KYVfmophlvVEv4+BGAaOJiyomcxW3dOWg+cWtjn/NokXXE5y?=
 =?us-ascii?Q?MgGWGJaXco0PtPcCXtD1EFlty/cPbtdpGAmP0D+j0yXAsSBMIgo9rFsRDMYY?=
 =?us-ascii?Q?0rIn4RCfCUlXPn3dGy0jcUV3FTZohKBoNvzulkTrSzzJuJVMBBfr2Hl9+Arj?=
 =?us-ascii?Q?5+uWW4SCdgCh4GNPqFG7eP74GD0SH1dnuqaalQCy2ogL/gvaO9m1tlG5tG1Z?=
 =?us-ascii?Q?yM7E2+y98fPFvlMowxGD/mhMqoWFH4GJZL2LOjeP4XBKRdm7kvhZzTtdfim6?=
 =?us-ascii?Q?C9waXZCBfn5sQDOFgDTcxDwFyhtzXLAEHWH1UQpIkG5mtvIphwe5wGf3J6Bq?=
 =?us-ascii?Q?p8Yq53LgsB3uMH1qOlvQx9v/L8v1ipZW/kJlpkGMTisyep+3ovZxmPvjTAB1?=
 =?us-ascii?Q?VOD/i1ZEWB/NHH2tnDG0maagycI/KUq1Q2cFHblNzTCXbNxRk/GYhbod3WWj?=
 =?us-ascii?Q?brRR5EYlSuaGL4JnA2W7F31s7UDBg2CNj0VttfVJ8JrZ6s5wgbFQf1QGVsRc?=
 =?us-ascii?Q?bhi1r1RBfzKJGfO4pcFkd/Df5k3T?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 04:44:13.0092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bae28c-ecc0-41da-730c-08dc68d02f14
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6566

The CMDQV extension in NVIDIA Tegra241 SoC only supports CS_NONE in the
CS field of CMD_SYNC. Add a quirk flag to accommodate that.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 ++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  4 ++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6a7e6b1ba5f7..b3d03ca01adc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -334,7 +334,9 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 		cmd[1] |= FIELD_PREP(CMDQ_RESUME_1_STAG, ent->resume.stag);
 		break;
 	case CMDQ_OP_CMD_SYNC:
-		if (ent->sync.msiaddr) {
+		if (ent->sync.cs_none) {
+			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_NONE);
+		} else if (ent->sync.msiaddr) {
 			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_IRQ);
 			cmd[1] |= ent->sync.msiaddr & CMDQ_SYNC_1_MSIADDR_MASK;
 		} else {
@@ -371,6 +373,9 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
 				   q->ent_dwords * 8;
 	}
 
+	if (q->quirks & CMDQ_QUIRK_SYNC_CS_NONE_ONLY)
+		ent.sync.cs_none = true;
+
 	arm_smmu_cmdq_build_cmd(cmd, &ent);
 }
 
@@ -708,7 +713,8 @@ static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
 					 struct arm_smmu_cmdq *cmdq,
 					 struct arm_smmu_ll_queue *llq)
 {
-	if (smmu->options & ARM_SMMU_OPT_MSIPOLL)
+	if (smmu->options & ARM_SMMU_OPT_MSIPOLL &&
+	    !(cmdq->q.quirks & CMDQ_QUIRK_SYNC_CS_NONE_ONLY))
 		return __arm_smmu_cmdq_poll_until_msi(smmu, cmdq, llq);
 
 	return __arm_smmu_cmdq_poll_until_consumed(smmu, cmdq, llq);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 2a19bb63e5c6..bbee08e82943 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -510,6 +510,7 @@ struct arm_smmu_cmdq_ent {
 		#define CMDQ_OP_CMD_SYNC	0x46
 		struct {
 			u64			msiaddr;
+			bool			cs_none;
 		} sync;
 	};
 };
@@ -542,6 +543,9 @@ struct arm_smmu_queue {
 
 	u32 __iomem			*prod_reg;
 	u32 __iomem			*cons_reg;
+
+#define CMDQ_QUIRK_SYNC_CS_NONE_ONLY	BIT(0)	/* CMD_SYNC CS field supports CS_NONE only */
+	u32				quirks;
 };
 
 struct arm_smmu_queue_poll {
-- 
2.43.0


