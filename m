Return-Path: <linux-kernel+bounces-124186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FD389138A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079AB1F22729
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF064439E;
	Fri, 29 Mar 2024 06:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lKOx/EQd"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFD444368;
	Fri, 29 Mar 2024 06:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711692941; cv=fail; b=FbOdI+jLjzIqmoMhL7RUo/Y6EUb84Qn4LBFkE5+Nhforo7CmotpXJ7B0gIdodYnnTS6o/D7eVNNagUYqckfnybkAOtbyRd8tYSY98MoH2GMy1EM8KFS6EKNVg5Fxm3DT8rpawZmub84AN5O3X5BjEYLalDGBgkp6MgZ0LR7m0wA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711692941; c=relaxed/simple;
	bh=LP9DXU2REa3nomOBWgtdOLJCPeeF2hD4w61Bp6nDs2Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iCjGUsH5kS9JY2HPMirte/hbTRLjQ8p2W5OzLSo9bgteWs5VaLkgo3rSa46GxAnWjZ1spSFqaI9zs49E6xo1PpMavpTJ0lk94tObTAnY9+vPLQuwR0HUfjpzUZJC/cUC7Eg0JRk4VNxBO64Zgx9c7OEcexJiHU5wAdtg3bnHQIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lKOx/EQd; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5nSW3yfUJtrfLJ866zHryt6oIH+9f+dEHD1LQSt4YMUS0AOmV2/p2kMLBJTViqk8yoBXgG7Wz4ZH7QfJXV8ES4v9+C2jyP2fgiJ/jr37vNaIh371/Pz81eXn8AQOPrDe3GAU2WmeCoZoLSYKIzzeZ1XvJk5ls6vNc2PepHTzivBlHhTay/SPpZYjhS9J4RJ4CjYwNGfSDoB4c9uUphP9s1P4O7XNnuYv0q4WKS68JJL8bv8vy1iITmzxLmNFptfBxohwkP30upUEAky2KjGIZbGQvUIFHaLDe13oUcFYR56XTBPY+BJe09pY7OG6hxGqyB4IewsMQyl366B6F7P8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbtlNqhfEjwLm10D5TifXP4/kRQtBuXCBRVV7ZftVrM=;
 b=TFUQ0EM91ybfGyyJjs0BEHAxPsCypuFpjytp6yDTBY+ZKHnlG6m12pB3eCjFBRZFfTP6IiaJS9hM7JRcRhkybLt/akT7pm4gY9RBpcnHzi82Z3+3gAil3vB3CQ+Pf/wv7hD3RcRcXlfJ2qNuqm5AohHC+NiIscZfT3FyTDfwzOI1f0IqxzcAObSHGv/4r5c2azf0Is7bPfMnGicb4R2X84ArUP8gIP5tQ3v60QriHaN5lva8UT4jaI7oNQ/tl1wbKMhxHTSqWW3zuOb/4kf0wvxR/S4+0ZWFmr800UiZTaMpcVOUM4hfa9h/BmlwaYgF+o0Fi2M/5bWDV/sr3i7ziA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbtlNqhfEjwLm10D5TifXP4/kRQtBuXCBRVV7ZftVrM=;
 b=lKOx/EQdvPiSZliW7OqJGz2UtR3K7/95KWJKmgh7s8QPXiwSDI+kBR/NdBJHwL1cEeiMbgsvt2zUtWZiFhw837/SGsL0ZLDKbPlUkygvEdIHXPnA87QgKoRg0K79uZpTX40wmO1LDwzAo5ghDmrwnHQtoGZxUaiS7j9D+LeSkAXinIoyPpmnJuZKN+Ksq3f+vTWaVnvu6B9g83B/fp+rpGVm2vRxbJepPefISWDyYEqqZVjcASUP+/oNmLe4v6gmCOmeR2bD1OfefRTH7nbd4OWaW6LjJmfd3Zzfp/C3L8I08GnSbWtK2O8qelZwNX0Tx3XsWeVkVXbNW0zHquvECA==
Received: from BN9PR03CA0855.namprd03.prod.outlook.com (2603:10b6:408:13d::20)
 by IA1PR12MB8310.namprd12.prod.outlook.com (2603:10b6:208:3ff::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Fri, 29 Mar
 2024 06:15:35 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:13d:cafe::35) by BN9PR03CA0855.outlook.office365.com
 (2603:10b6:408:13d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Fri, 29 Mar 2024 06:15:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 06:15:34 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 28 Mar
 2024 23:15:19 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Thu, 28 Mar 2024 23:15:18 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 28 Mar 2024 23:15:18 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v4 6/6] iommu/tegra241-cmdqv: Limit CMDs for guest owned VINTF
Date: Thu, 28 Mar 2024 23:14:10 -0700
Message-ID: <473c173f8b5ab2878f2948c68d9c9846d664f771.1711690673.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1711690673.git.nicolinc@nvidia.com>
References: <cover.1711690673.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|IA1PR12MB8310:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c22c8b-ebb6-4765-c04d-08dc4fb7a536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	07O7WT6bb9//9m/0oOUasyvljaOu2cIAp4nXJFYs8Oa1um+8CQfj7sRhi/62JWM9LQhr6boUQ64GRJ54NxsTJyXPiyPJr2br6kp4At/o5bPaueEwWhShQ2GQK/52xlGRCMclBWCVh234Z6gHbwb9UoByYDgg12CH9IpN7IQgifu4Q30THdqrdglhyNTqVaWCz4FV+qB6NmDPFJbmBsuPwTH9rZQG4hoWQV32uJF738AV4zpYfs4RxgyGU++ixR2gdbQJm7lekHGhpiTwoPu8OVKG4FXKCRen0LDbHBHl6sJbW+sD3VTmvEalm/XvyLNCBWja7Dr7o0UrO3AucgoINT0WdhBy1J64K69+fsxSa9xnWV2C3qP+dKzr+VBY40SnZJQMrKm4plgcvGmUsbAefwr5KBefMOd/m4FdgRw4W4beL254n/jEqYRAG5jp9/iUzHkUtP2IC4fIAbi2zfxQ+HM8z/vCver/gd6Hya85Jrro+osh2g9AjdbeQuOhVGqo90XESc47zMqlgZZ7ng3nfSBPjOqlybpSGv4UFfBsQZEtHi3hnbb8JSkkYcrcN0HlozQpZT5wsxJaAKK1e+PkRP7GWLKZHtybxQ9aGfjZ5JLN+MK1gxC5ihVlOjbMsMA31xFr/EIWoF/dSq9cuPZXP0VmhsI2YUxHVGPO7OaTAduPb7MfZml0fcgDU9S2iOlv1HipNIV0bYz+4pFMJEAwpLpVk/175QSHsHgUcivHXq41jWfOi93fVva78UCzO+Vl
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 06:15:34.7331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c22c8b-ebb6-4765-c04d-08dc4fb7a536
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8310

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
index d12e048ddd93..5cc31cdf1ab7 100644
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
@@ -765,7 +766,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	u32 prod;
 	unsigned long flags;
 	bool owner;
-	struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu);
+	struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu, cmds, n);
 	struct arm_smmu_ll_queue llq, head;
 	int ret = 0;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 22270de3aed7..495c80579c8e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -834,7 +834,8 @@ static inline void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
 struct tegra241_cmdqv *
 tegra241_cmdqv_acpi_probe(struct arm_smmu_device *smmu, int id);
 int tegra241_cmdqv_device_reset(struct arm_smmu_device *smmu);
-struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu);
+struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
+					      u64 *cmds, int n);
 #else /* CONFIG_TEGRA241_CMDQV */
 static inline struct tegra241_cmdqv *
 tegra241_cmdqv_acpi_probe(struct arm_smmu_device *smmu, int id)
@@ -848,7 +849,7 @@ static inline int tegra241_cmdqv_device_reset(struct arm_smmu_device *smmu)
 }
 
 static inline struct arm_smmu_cmdq *
-tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
+tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu, u64 *cmds, int n)
 {
 	return NULL;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 4bfddeb658e2..7816ec8e6075 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -213,6 +213,7 @@ struct tegra241_vintf {
 	u16 idx;
 
 	bool enabled;
+	bool hyp_own;
 	atomic_t error;
 
 	struct tegra241_cmdqv *cmdqv;
@@ -330,7 +331,33 @@ static int tegra241_cmdqv_init_one_vcmdq(struct tegra241_vcmdq *vcmdq)
 	return arm_smmu_cmdq_init(cmdqv->smmu, cmdq);
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
+
 {
 	struct tegra241_cmdqv *cmdqv = smmu->tegra241_cmdqv;
 	struct tegra241_vintf *vintf = cmdqv->vintf[0];
@@ -344,6 +371,10 @@ struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
 	if (atomic_read(&vintf->error))
 		return &smmu->cmdq;
 
+	/* Unsupported CMDs go for smmu->cmdq pathway */
+	if (!tegra241_vintf_support_cmds(vintf, cmds, n))
+		return &smmu->cmdq;
+
 	/*
 	 * Select a vcmdq to use. Here we use a temporal solution to
 	 * balance out traffic on cmdq issuing: each cmdq has its own
@@ -405,12 +436,23 @@ int tegra241_cmdqv_device_reset(struct arm_smmu_device *smmu)
 	atomic_set(&vintf->error, 0);
 	vintf->base = cmdqv->base + TEGRA241_VINTF(0);
 
+	/*
+	 * Note that HYP_OWN bit is wired to zero when running in guest kernel
+	 * regardless of enabling it here, as !HYP_OWN cmdqs have a restricted
+	 * set of supported commands, by following the HW design.
+	 */
 	regval = FIELD_PREP(VINTF_HYP_OWN, 1);
 	vintf_writel(regval, CONFIG);
 
 	regval |= FIELD_PREP(VINTF_EN, 1);
 	vintf_writel(regval, CONFIG);
 
+	/*
+	 * As being mentioned above, HYP_OWN bit is wired to zero for a guest
+	 * kernel, so read it back from HW to ensure that reflects in hyp_own
+	 */
+	vintf->hyp_own = !!FIELD_GET(VINTF_HYP_OWN, vintf_readl(CONFIG));
+
 	ret = readl_relaxed_poll_timeout(vintf->base + TEGRA241_VINTF_STATUS,
 					 regval, regval & VINTF_ENABLED,
 					 1, ARM_SMMU_POLL_TIMEOUT_US);
-- 
2.43.0


