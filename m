Return-Path: <linux-kernel+bounces-163335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 170DC8B6992
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386F31C21BFC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBD12837A;
	Tue, 30 Apr 2024 04:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YWTJOq0P"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE144224FD;
	Tue, 30 Apr 2024 04:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714452268; cv=fail; b=rcLa0tibV8tdFO5Jf1N/igPFWs52XCEvDFrbDSvhLYNtT4XjHMb4D+MHez+TNzGHeTCG3WAGrL81cQ/xGuHZoXSJtCeBrAL8KF5H1hQWjYeo5lPdBnn9tQOZn4vBAoxbgb3f2yv/yO88KMQJ2waEq1XC3VtTbvXA2b1piosrdEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714452268; c=relaxed/simple;
	bh=LWXYAYfBOx52YUQVKAMAspGxxDebB4Xs42TB0zeBL/0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dg8RvwYxPplvEF7Ly1rwPvkwETkWd/8wtbp5yGtUeAy6+G5AQuil6qijLvdnyYxUF63Wm0K4MznFclziCNOWh6TjhCGZonU1TFQ6G0QhIVDwBsPUEvEmfFZITpIcU14zW1SgOenwnciLnn27SxYWha528zHxvPR4+QH1kafPw+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YWTJOq0P; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9SFCdV0Q+ySK21Yr2tTPTUw8acVbLt2agKbYps+vWyFzcxLFyEAKUBs3UAf4S4sZpisYa5idk5Qpu6LhzFXtMggKuTjmmkT9UJRIp+TLy8LejH+kqMNfSjlzOV8q67tjuIUNl7Sz9JBHgoCsPSqaXPhS4mOFPkVpFwHvt/n83bwnjzCRWzphUeyhNlLw+73LNpjcTvCPgDM5oxfnnTAjMhY0ClLOG8HszgZWKd94QiCfH61GYVpbXF0n2ShGP09biYiiQ27mK3jYfude4Rmn5eul3hetmTYKhzahecdG2zCwltfNv+qxGvwL8BhLiv0calgjhBoOvFP5WZw1NbpKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUHqpfFc7P9L/7S5eFMmeZU/JeujbJnunF42Jf7h/fk=;
 b=ItSyj6R9bYmKBfzjqQ0Kz4T8B8pbu+jfXapxGPgJTFDKxVYBxsuOLCP76K5RFNlx1oScJpAtX+BUtnKLLV4zbfpGqrQ5YHweY9BwiDdzc1KZEhfMg5quI3YooftF0JQXfxvJL8co4DLYqUH7OFp5/hVerJkWePkzCWzoV9qEcpLUe1Xr2akW3oAncLjT1QGxsD9REiwmEWVsdAHJP/FJEN7aWz6mV4FxhCevQzKF/Y38rq+0wfQGLpKkKnsNLuwiOb3qupfGrnWef4RptD/Zo8BGP7UUXPdQtZPGplyyoYv42GbzVpE5iUqQTIwFj0SYeni8NQlG9BKKYQlwtDr7iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUHqpfFc7P9L/7S5eFMmeZU/JeujbJnunF42Jf7h/fk=;
 b=YWTJOq0PZ5Qr3KP9VEhgUEc6gOsuPsLpYSA4DHpyOW4a7cSKwWc/epmq0GuDdLzXvyFbhI+sqH69uw7bTbEgOHMrmZ+N51G5tzPaSGEdaQmVI3fM/nJN3tCOUr1WlpnfrV954Rxac7XSjygGkggdi+NTE+x5tP/alTbitk0ps79PJs5OwQgidIBJUWjeMXA9roiYJ37Wm+TRyvHt4aHg/alCPFe8FMBzbAVfh5xtgbUE7JvrEfd3luicQBCM6RYYSLUuuuxQ8C5xGHytUKp0KCRpRjGUrG4XKjiDWes4cGaowCyxIHGYn6VPKV8w1Difw5M+9j//9qW+hxwcwE75FA==
Received: from SN7PR18CA0011.namprd18.prod.outlook.com (2603:10b6:806:f3::19)
 by DS0PR12MB7584.namprd12.prod.outlook.com (2603:10b6:8:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 04:44:20 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::ae) by SN7PR18CA0011.outlook.office365.com
 (2603:10b6:806:f3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Tue, 30 Apr 2024 04:44:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 04:44:20 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Apr
 2024 21:44:11 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 29 Apr 2024 21:44:10 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 29 Apr 2024 21:44:10 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v6 6/6] iommu/tegra241-cmdqv: Limit CMDs for guest owned VINTF
Date: Mon, 29 Apr 2024 21:43:49 -0700
Message-ID: <4ee1f867e838b90a21de16b12cf2e39ba699eab4.1714451595.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|DS0PR12MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: c4081c2a-1f10-4e6d-f4b9-08dc68d03389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400014|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3Hg7Q9ikK+b8dsqQhbSi0qEMPCHXZ/jGq91MbSOKjR+M1DVT94oz/YkCb+mC?=
 =?us-ascii?Q?uop42nJRhEcY90MGN6/C0OZpuifUOlWeaiSoui67jpilzGF2bUVeMVpO0weN?=
 =?us-ascii?Q?GZedJJ2blaDQRE143B+mRapq9/pNOf9WVBAR9BrmT+QBRUDXU1RiQfDIvaK4?=
 =?us-ascii?Q?u2ZpUqZslStt+O/r9Tm88Rk+uUd6I3enQ2NRfKO8n1R1H4szzQRyRYjoX0vY?=
 =?us-ascii?Q?NBlK2JLxNtvtmslWGYsEWEpn0FKRWs6IuO+uf8HOKpd5Mlxtwwz4llhhElRq?=
 =?us-ascii?Q?2EoWJLXTXEnhPuyCoXmMhECMm+wD1UBvDUJjapraU7FfSlMLCaRfuPt4xQ1M?=
 =?us-ascii?Q?tLYkPEh29zXSvVxTGuXsCs2WhUM5XC0dGGN9x5Hp5dWPmwX08eUywwrP6vNf?=
 =?us-ascii?Q?MNl42M3+bv3bNxuZ3hotAHm4TKRcmCSo1lLckBHwrJhsqAP7Wtv/lsk2uqEf?=
 =?us-ascii?Q?ZZ8+5q5MbpTVe8vYoEufrkp+eDYAeNUC77jD0FvRVRHcZsKzAFVcE1vjbS05?=
 =?us-ascii?Q?d7QVziDBDT0gYBs79FHYoVYHwdfYPaxaixu/xTuWSf8oZU0hw7hwK26l4fMP?=
 =?us-ascii?Q?aET5Olame4R+2G8aJf6tPaRdBOMgOjqlo+DsVOeQlztkkeCJRgCZ7dFNV5CR?=
 =?us-ascii?Q?S0BZpDu0uR3Zs4mhgjAivVeimSTWdOJuTYcbVEgaixuJf8wtsxWNuH1dRQ34?=
 =?us-ascii?Q?u/OqLSYxz30MjI60AwmueJFHbFxLoFx/Si9vP4+Np17HWeyNIP2TjkSmucX8?=
 =?us-ascii?Q?91T5E3ayVuVKNpp5U8Qjx4iV05AbJDz1snibbY+yCLByZkElgN/ws0Lqpknv?=
 =?us-ascii?Q?9fXP/At/wjhihBgXZ/2qZ38UV6lWOw94J40xHpq691EYG2uFXxnV45jOlQ5T?=
 =?us-ascii?Q?fRfgAG8GgVt4DwuSkiFPQzBV5a5q0gC1KLockajNsVLQC/sajRLg1e+EDHbY?=
 =?us-ascii?Q?fReDMNg1oDN6y+sC3J3qehOTmj/BA85vAH0OFEvnySQtFC8PNOjGUHKuBZdF?=
 =?us-ascii?Q?cXl6bMdEhYGx4NPba1eJTTnHyuzgudtaXIvyLuABiMfZ9AXH4ZuTaKpv+Nkq?=
 =?us-ascii?Q?/nnjGstP0ZhupAaun9nqn48tYYdauURA40CZ26Pv0fgfpFNKq8l0WH2TlITs?=
 =?us-ascii?Q?Q9sK2HSBuhFR8Tsuk9KQZu0JDw4zsADfR6Pccczwf4UN+/NKcKv5M/fNOcDh?=
 =?us-ascii?Q?SASc2e5KOq0EGbLptji6gwfKKyTPUXUDKIY2HIb799QVe1/n1hhtXiPT7teI?=
 =?us-ascii?Q?XojyON1TBFx/BqM4M/9CaExnJCI8lF2cL4DLvdXXqb/sTV3LDfrVK4pl41tx?=
 =?us-ascii?Q?w4oMbRv1T+ZsaeE9BAt3xldy3FRVh5Ori+7CBCK4nkI98hRKnq0Mkhas59P3?=
 =?us-ascii?Q?/ShP0Ipkig7ctsrTsdyEv4mhksN3?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 04:44:20.5683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4081c2a-1f10-4e6d-f4b9-08dc68d03389
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7584

When VCMDQs are assigned to a VINTF owned by a guest (HYP_OWN bit unset),
only TLB and ATC invalidation commands are supported by the VCMDQ HW. So,
add a new helper to scan the input cmds to make sure every single command
is supported when selecting a queue.

Note that the guest VM shouldn't have HYP_OWN bit being set regardless of
guest kernel driver writing it or not, i.e. the hypervisor running in the
host OS should wire this bit to zero when trapping a write access to this
VINTF_CONFIG register from a guest kernel.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  7 +--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  5 ++-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 44 ++++++++++++++++++-
 3 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 665a5e585f72..0802c3c96a2a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -352,10 +352,11 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 	return 0;
 }
 
-static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
+static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu,
+					       u64 *cmds, int n)
 {
 	if (smmu->tegra241_cmdqv)
-		return tegra241_cmdqv_get_cmdq(smmu);
+		return tegra241_cmdqv_get_cmdq(smmu, cmds, n);
 
 	return &smmu->cmdq;
 }
@@ -766,7 +767,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	u32 prod;
 	unsigned long flags;
 	bool owner;
-	struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu);
+	struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu, cmds, n);
 	struct arm_smmu_ll_queue llq, head;
 	int ret = 0;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 87e4c227a937..e21e29f4770b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -837,7 +837,8 @@ static inline void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
 struct tegra241_cmdqv *
 tegra241_cmdqv_acpi_probe(struct arm_smmu_device *smmu, int id);
 int tegra241_cmdqv_device_reset(struct arm_smmu_device *smmu);
-struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu);
+struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
+					      u64 *cmds, int n);
 #else /* CONFIG_TEGRA241_CMDQV */
 static inline struct tegra241_cmdqv *
 tegra241_cmdqv_acpi_probe(struct arm_smmu_device *smmu, int id)
@@ -851,7 +852,7 @@ static inline int tegra241_cmdqv_device_reset(struct arm_smmu_device *smmu)
 }
 
 static inline struct arm_smmu_cmdq *
-tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
+tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu, u64 *cmds, int n)
 {
 	return NULL;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 4b2af3aaa6b4..59ff2b740bec 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -266,6 +266,7 @@ struct tegra241_vcmdq {
  * struct tegra241_vintf - Virtual Interface
  * @idx: Global index in the CMDQV HW
  * @status: cached status register
+ * @hyp_own: Owned by hypervisor (in-kernel)
  * @cmdqv: CMDQV HW pointer
  * @vcmdqs: List of VCMDQ pointers
  * @base: MMIO base address
@@ -274,6 +275,7 @@ struct tegra241_vintf {
 	u16 idx;
 
 	atomic_t status;
+	bool hyp_own;
 
 	struct tegra241_cmdqv *cmdqv;
 	struct tegra241_vcmdq **vcmdqs;
@@ -372,7 +374,32 @@ static irqreturn_t tegra241_cmdqv_isr(int irq, void *devid)
 	return IRQ_HANDLED;
 }
 
-struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
+static bool tegra241_vintf_support_cmds(struct tegra241_vintf *vintf,
+					u64 *cmds, int n)
+{
+	int i;
+
+	/* VINTF owned by hypervisor can execute any command */
+	if (vintf->hyp_own)
+		return true;
+
+	/* Guest-owned VINTF must Check against the list of supported CMDs */
+	for (i = 0; i < n; i++) {
+		switch (FIELD_GET(CMDQ_0_OP, cmds[i * CMDQ_ENT_DWORDS])) {
+		case CMDQ_OP_TLBI_NH_ASID:
+		case CMDQ_OP_TLBI_NH_VA:
+		case CMDQ_OP_ATC_INV:
+			continue;
+		default:
+			return false;
+		}
+	}
+
+	return true;
+}
+
+struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
+					      u64 *cmds, int n)
 {
 	struct tegra241_cmdqv *cmdqv = smmu->tegra241_cmdqv;
 	struct tegra241_vintf *vintf = cmdqv->vintfs[0];
@@ -390,6 +417,10 @@ struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
 	if (FIELD_GET(VINTF_STATUS, atomic_read(&vintf->status)))
 		return &smmu->cmdq;
 
+	/* Unsupported CMDs go for smmu->cmdq pathway */
+	if (!tegra241_vintf_support_cmds(vintf, cmds, n))
+		return &smmu->cmdq;
+
 	/*
 	 * Select a vcmdq to use. Here we use a temporal solution to
 	 * balance out traffic on cmdq issuing: each cmdq has its own
@@ -590,6 +621,11 @@ int tegra241_cmdqv_device_reset(struct arm_smmu_device *smmu)
 		}
 	}
 
+	/*
+	 * Note that HYP_OWN bit is wired to zero when running in guest kernel
+	 * regardless of enabling it here, as !HYP_OWN cmdqs have a restricted
+	 * set of supported commands, by following the HW design.
+	 */
 	regval = FIELD_PREP(VINTF_HYP_OWN, 1);
 	vintf_writel(regval, CONFIG);
 
@@ -597,6 +633,12 @@ int tegra241_cmdqv_device_reset(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
+	/*
+	 * As being mentioned above, HYP_OWN bit is wired to zero for a guest
+	 * kernel, so read it back from HW to ensure that reflects in hyp_own
+	 */
+	vintf->hyp_own = !!(VINTF_HYP_OWN & vintf_readl(CONFIG));
+
 	/* Build an arm_smmu_cmdq for each vcmdq allocated to vintf */
 	vintf->vcmdqs = devm_kcalloc(cmdqv->dev, cmdqv->num_vcmdqs_per_vintf,
 				     sizeof(*vintf->vcmdqs), GFP_KERNEL);
-- 
2.43.0


