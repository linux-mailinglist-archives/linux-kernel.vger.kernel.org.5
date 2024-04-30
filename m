Return-Path: <linux-kernel+bounces-163334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C695D8B6990
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291D91F2280C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC1E17579;
	Tue, 30 Apr 2024 04:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KCYGo4zm"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB115199B9;
	Tue, 30 Apr 2024 04:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714452265; cv=fail; b=sxrLnbWxUy3nv6h0va8wwhBhsSKTIOaTtUNkfGZUXZsXumsTjDGs0L1tEL+xqC9szlcI1q/0e9MF/9aOKMJP7mOEjPXg10UyeT5TQZn59tZT+jSapmLyClMpLBqPrs8PRzIkNY+Svd0YX9iIVzE/EixQ6EKoDEEWnTjjw6gr3UU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714452265; c=relaxed/simple;
	bh=qRIqctcipDp16BDY2JyySLjuJcf5i1ahgSle6dJHHBc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H1NtvkT9FDo1DcVanUWg7pIM/8TQqczRRlQKuYIBoXL+W52p7pSa00LsdFffaPEYnf4F2JtTFN85hqg35CuJ0UbscpeQnEmKNHb0rsAmpD/1/RkCMH4tzA++iNu02jrtKRTl50PnnmslOwiDLfYJAknaPVDPvBNmvt2OVIeb4GY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KCYGo4zm; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gbli+fOZBI4ekS85HBtTJpuwrGNs4aCarZ/QT7VYtdJTbZo/57hmYPrEOIFlIvYclAaU/vhrTcmJ/KYrOydx41ILYw2tjyCLTbzXnQ48AD0lat/hP7wz7Q4cAVUKUbHvncH91K4CCUq7/NRFUz7j12tm5lUD45JforRZ1+v1kE4DlPEBLm69b0MHQHr24qOKtNizNKQFGRpP0etj+U75Pn/M/Wl1haRr7q6NyEhuFyfbD9xdNfjX/hVJQJbGUzZT7MYE3k71BT2fkpsmX61ZljIveFNqKKp7XxapzK3yZans2JCd5aLVH0ORSC0VQoG2nLy+REgL56+KWCgymsayxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gm1nddAd8qPxUx7RuWZO+6pSj1/u/fHRDeGHIT6kVMQ=;
 b=jByg9g6rxF+faWbXjJxqdQM6dISNXK0Aw9b7KNKH8PAPE23fDFBDWfJ9OkQXvnHu8Utc6M6i1p7Oh7tWc+5p3CQkX69y8+HyQ4hnEdtzkdkBqwi7VFxtj67YI3BVTCENnb0VvZ83JFBxlWESswJVf/B9yYUs9nIk18aYubRUu1iEu5yGxq86sPbYHu2JstXn6UvKab3YjMDzERpjHbUqi3DvHLtKf1e96/2PEpQTfxrvJfb7Rgjg/hKquiKy5ANr4RJvmmFXSjMie4muUHGlKfd1pOkDwT99m+RRxMy174hKQT8aGKE76RVYdpYw35NPf0Mf+xpbo2+uUebU1LwiQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gm1nddAd8qPxUx7RuWZO+6pSj1/u/fHRDeGHIT6kVMQ=;
 b=KCYGo4zmAjYuowXlN/f29pK5VYOI2y74OcXPqAkdvc4+nv1NC1WyjJiy6LuntRVwfrvSq13qiFQ3iwHEqJB3cXGILfOOViU3Yw3SfzaQRASXOOzV1tZyIwq5CxVcm0bA2wg/Fqd75fd1+7yQ6biHgYhFqIVgO2WSE0vyL8R/pamYRaRH3aCyU59kuxdbNRW3RkccDt4HiZ3nX9YadZ6jB1kCgYlp3heaENAGvlDq6aL3vpiT8imv5M4n1XYHnTVZf05YIo78rdZo6aQi4hutfBAgf5LzOqHUS/OMPn6cmHzv/xOkasfQfTTbDO8jBkWRj5bl3Qw84azACpmq7SkS+Q==
Received: from BL1PR13CA0205.namprd13.prod.outlook.com (2603:10b6:208:2be::30)
 by PH7PR12MB6666.namprd12.prod.outlook.com (2603:10b6:510:1a8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Tue, 30 Apr
 2024 04:44:18 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::7d) by BL1PR13CA0205.outlook.office365.com
 (2603:10b6:208:2be::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.21 via Frontend
 Transport; Tue, 30 Apr 2024 04:44:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 04:44:17 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Apr
 2024 21:44:10 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 29 Apr 2024 21:44:10 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 29 Apr 2024 21:44:09 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v6 5/6] iommu/arm-smmu-v3: Add in-kernel support for NVIDIA Tegra241 (Grace) CMDQV
Date: Mon, 29 Apr 2024 21:43:48 -0700
Message-ID: <63414546b1eafdf8032ac1b95ea514da6d206d63.1714451595.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|PH7PR12MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: 52dd932c-dd42-4aa0-ce09-08dc68d031e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|376005|82310400014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y0PkqDTVYvK2oh3uBTELpCHxoUMaqkeGN5LwUTkFwJmuuDFrpLvj7HdT+0qN?=
 =?us-ascii?Q?t2Wlc5dv6u4mrJ+8COOI5aSNYf5K7ni1IulgXfhzdg36wIkPXHjcM2EQs1lq?=
 =?us-ascii?Q?tApcp10w+RqifcIVuHzdABY3bwfonPi72nEWSt/EsZuH8o3V0iRapGRHkaLp?=
 =?us-ascii?Q?Z7EIJYY1Vq29PJy9kgY2lWIuSR5wVD/ofZdjWc19lkZlTjsqe36P/8u/B9cM?=
 =?us-ascii?Q?ZEbnc/7zp7zjnOTehWdGrvio6/jTzc50qxUY6D8PshNvUMJdLptsxS2H+U14?=
 =?us-ascii?Q?4gBrUOlgQJbG+9oVNNSCAxOwx0dnVlAoLkaBwxSc9kOqb3Ch8kweaplzv8nB?=
 =?us-ascii?Q?i+X4QsfvO57tkUfkYbW7q38buy45dkJUAm5Dve2wTkTM/C/3Fn79REhU6LOY?=
 =?us-ascii?Q?Cs6gLYBESiikLhrcKXhWBqNy1WfZDAhfTawAebaXECRtDkiA0I9dRtB+PbUD?=
 =?us-ascii?Q?gfKGAzgcjkMqztIj6uHJ3iGakUJKvPNPFF8MRpx8H4xO6m2GU/Vi6EHTrI/0?=
 =?us-ascii?Q?1JztgmUtz8cQyVy1xYenUTg2TC/GO4AhbZ3MQoUZZ+jaBZFsJT5wLPHhKqja?=
 =?us-ascii?Q?CI41sPcrGVKrOBSOxDEUd6d5B+0S0Of1ZFGuDhY/ZCJia1rZlNv5THqSjo5A?=
 =?us-ascii?Q?8WER2O5CClNPfV76CkRdzqocI0QoBcPrEUZeDNorS3oQ6bPaCHxyARQXWLzb?=
 =?us-ascii?Q?xKvZa7e9uiEwLypgPpR37BIdPiCgdLjkh4RoRYunr3Hfk23X5zdlykJDo+lu?=
 =?us-ascii?Q?NalfJk6HuaAyIFctuXjI7SVVcgC/JWsfs2ZUt7Lz9hGHDOUBN6An3oMl4WTE?=
 =?us-ascii?Q?Hdz/pRvBSaIGrJmDkQAS4vOv1GSMiu9v45msipFspVO5tssb3Du51FjsZNZ1?=
 =?us-ascii?Q?yKJbDpfDUZ2158zX0i3AdVVblsUHsbUSG54S/8m7o3m7mGY7YLl4nf2qvtNR?=
 =?us-ascii?Q?f45UhQ02Uzhimreg/6J+QnJ4i2qYbA1Qpkpi0MfWosTul/qqRLAnCxJvnshx?=
 =?us-ascii?Q?foG0zoxkYheniJEWLaEYqd+AladDMXiumNyMvxzVmUDKu0VhyIQd3JpESDAS?=
 =?us-ascii?Q?x+ZwW37WsYOJWk2JUKTqniZt17ztDcjNCmaBwyHUk4CxxnDU/VA4eLnjfpn2?=
 =?us-ascii?Q?1s9yKzFx3ScPdY33Slu4uXJ87ESYFmTsa6MHIM3ug8VNddjXjo0PKUZNbw0K?=
 =?us-ascii?Q?MMdo8ctBeR558o10FuUXREYF4gqSBPJVOfxS5WXiK/X2pWvcSFsF/XHN/YaN?=
 =?us-ascii?Q?dzCkcMrZZwfPNQ3Qa5JCMg3UD0dOVeMhcaiVa03ghK6E4g2LQPxt2QhjjJ5Z?=
 =?us-ascii?Q?h5FWe3yTyz/diaN6vscsvSdftpgzmY6mJBBfoAj6pZoCI3fD5v2WYaMa5NN4?=
 =?us-ascii?Q?JQ/2TU1WsesKBur8mx12L3tAJCDO?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 04:44:17.7235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52dd932c-dd42-4aa0-ce09-08dc68d031e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6666

From: Nate Watterson <nwatterson@nvidia.com>

NVIDIA's Tegra241 Soc has a CMDQ-Virtualization (CMDQV) hardware, extending
the standard ARM SMMU v3 IP to support multiple VCMDQs with virtualization
capabilities. In terms of command queue, they are very like a standard SMMU
CMDQ (or ECMDQs), but only support CS_NONE in the CS field of CMD_SYNC.

Add a new tegra241-cmdqv driver, and insert its structure pointer into the
existing arm_smmu_device, and then add related function calls in the SMMUv3
driver to interact with the CMDQV driver.

In the CMDQV driver, add a minimal part for the in-kernel support: reserve
VINTF0 for in-kernel use, and assign some of the VCMDQs to the VINTF0, and
select one VCMDQ based on the current CPU ID to execute supported commands.
This multi-queue design for in-kernel use gives some limited improvements:
up to 20% reduction of invalidation time was measured by a multi-threaded
DMA unmap benchmark, compared to a single queue.

The other part of the CMDQV driver will be user-space support that gives a
hypervisor running on the host OS to talk to the driver for virtualization
use cases, allowing VMs to use VCMDQs without trappings, i.e. no VM Exits.
This is currently WIP based on IOMMUFD, and will be sent for review after
SMMU nesting patches are getting merged. This part will provide a guest OS
a bigger improvement: 70% to 90% reductions of TLB invalidation time were
measured by DMA unmap tests running in a guest OS, compared to nested SMMU
CMDQ (with trappings).

However, it is very important for this in-kernel support to get merged and
installed to VMs running on Grace-powered servers as soon as possible. So,
later those servers would only need to upgrade their host kernels for the
user-space support.

As the initial version, the CMDQV driver only supports ACPI configurations.

Signed-off-by: Nate Watterson <nwatterson@nvidia.com>
Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 MAINTAINERS                                   |   1 +
 drivers/iommu/Kconfig                         |  12 +
 drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  22 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  37 +
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 815 ++++++++++++++++++
 6 files changed, 882 insertions(+), 6 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f6dc90559341..8a799dbc300b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21742,6 +21742,7 @@ M:	Thierry Reding <thierry.reding@gmail.com>
 R:	Krishna Reddy <vdumpa@nvidia.com>
 L:	linux-tegra@vger.kernel.org
 S:	Supported
+F:	drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
 F:	drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
 F:	drivers/iommu/tegra*
 
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 0af39bbbe3a3..82e557de31e3 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -410,6 +410,18 @@ config ARM_SMMU_V3_SVA
 	  Say Y here if your system supports SVA extensions such as PCIe PASID
 	  and PRI.
 
+config TEGRA241_CMDQV
+	bool "NVIDIA Tegra241 CMDQ-V extension support for ARM SMMUv3"
+	depends on ARM_SMMU_V3
+	depends on ACPI
+	help
+	  Support for NVIDIA CMDQ-Virtualization extension for ARM SMMUv3. The
+	  CMDQ-V extension is similar to v3.3 ECMDQ for multi command queues
+	  support, except with virtualization capabilities.
+
+	  Say Y here if your system is NVIDIA Tegra241 (Grace) or it has the same
+	  CMDQ-V extension.
+
 config S390_IOMMU
 	def_bool y if S390 && PCI
 	depends on S390 && PCI
diff --git a/drivers/iommu/arm/arm-smmu-v3/Makefile b/drivers/iommu/arm/arm-smmu-v3/Makefile
index 54feb1ecccad..8dff2bc4c7f3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/Makefile
+++ b/drivers/iommu/arm/arm-smmu-v3/Makefile
@@ -2,4 +2,5 @@
 obj-$(CONFIG_ARM_SMMU_V3) += arm_smmu_v3.o
 arm_smmu_v3-objs-y += arm-smmu-v3.o
 arm_smmu_v3-objs-$(CONFIG_ARM_SMMU_V3_SVA) += arm-smmu-v3-sva.o
+arm_smmu_v3-objs-$(CONFIG_TEGRA241_CMDQV) += tegra241-cmdqv.o
 arm_smmu_v3-objs := $(arm_smmu_v3-objs-y)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5111859347d5..665a5e585f72 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -354,6 +354,9 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 
 static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
 {
+	if (smmu->tegra241_cmdqv)
+		return tegra241_cmdqv_get_cmdq(smmu);
+
 	return &smmu->cmdq;
 }
 
@@ -3105,12 +3108,10 @@ static struct iommu_ops arm_smmu_ops = {
 };
 
 /* Probing and initialisation functions */
-static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
-				   struct arm_smmu_queue *q,
-				   void __iomem *page,
-				   unsigned long prod_off,
-				   unsigned long cons_off,
-				   size_t dwords, const char *name)
+int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
+			    struct arm_smmu_queue *q, void __iomem *page,
+			    unsigned long prod_off, unsigned long cons_off,
+			    size_t dwords, const char *name)
 {
 	size_t qsz;
 
@@ -3567,6 +3568,12 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 		return ret;
 	}
 
+	if (smmu->tegra241_cmdqv) {
+		ret = tegra241_cmdqv_device_reset(smmu);
+		if (ret)
+			return ret;
+	}
+
 	/* Invalidate any cached configuration */
 	cmd.opcode = CMDQ_OP_CFGI_ALL;
 	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
@@ -3941,6 +3948,9 @@ static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
 	if (iort_smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE)
 		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
 
+	smmu->tegra241_cmdqv =
+		tegra241_cmdqv_acpi_probe(smmu, node->identifier);
+
 	return 0;
 }
 #else
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 32e7fc5e1794..87e4c227a937 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -626,6 +626,8 @@ struct arm_smmu_strtab_cfg {
 	u32				strtab_base_cfg;
 };
 
+struct tegra241_cmdqv;
+
 /* An SMMUv3 instance */
 struct arm_smmu_device {
 	struct device			*dev;
@@ -689,6 +691,12 @@ struct arm_smmu_device {
 
 	struct rb_root			streams;
 	struct mutex			streams_mutex;
+
+	/*
+	 * Pointer to NVIDIA Tegra241 CMDQ-Virtualization Extension support,
+	 * similar to v3.3 ECMDQ except with virtualization capabilities.
+	 */
+	struct tegra241_cmdqv		*tegra241_cmdqv;
 };
 
 struct arm_smmu_stream {
@@ -764,6 +772,10 @@ int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
 		       struct arm_smmu_cmdq *cmdq);
 void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
 			      struct arm_smmu_queue *q);
+int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
+			    struct arm_smmu_queue *q, void __iomem *page,
+			    unsigned long prod_off, unsigned long cons_off,
+			    size_t dwords, const char *name);
 
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
@@ -820,4 +832,29 @@ static inline void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
 {
 }
 #endif /* CONFIG_ARM_SMMU_V3_SVA */
+
+#ifdef CONFIG_TEGRA241_CMDQV
+struct tegra241_cmdqv *
+tegra241_cmdqv_acpi_probe(struct arm_smmu_device *smmu, int id);
+int tegra241_cmdqv_device_reset(struct arm_smmu_device *smmu);
+struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu);
+#else /* CONFIG_TEGRA241_CMDQV */
+static inline struct tegra241_cmdqv *
+tegra241_cmdqv_acpi_probe(struct arm_smmu_device *smmu, int id)
+{
+	return NULL;
+}
+
+static inline int tegra241_cmdqv_device_reset(struct arm_smmu_device *smmu)
+{
+	return -ENODEV;
+}
+
+static inline struct arm_smmu_cmdq *
+tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
+{
+	return NULL;
+}
+#endif /* CONFIG_TEGRA241_CMDQV */
+
 #endif /* _ARM_SMMU_V3_H */
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
new file mode 100644
index 000000000000..4b2af3aaa6b4
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -0,0 +1,815 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2021-2024 NVIDIA CORPORATION & AFFILIATES. */
+
+#define dev_fmt(fmt) "tegra241_cmdqv: " fmt
+
+#include <linux/acpi.h>
+#include <linux/debugfs.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/iommu.h>
+#include <linux/iopoll.h>
+
+#include <acpi/acpixf.h>
+
+#include "arm-smmu-v3.h"
+
+#define TEGRA241_CMDQV_HID		"NVDA200C"
+
+/* CMDQV register page base and size defines */
+#define TEGRA241_CMDQV_CONFIG_BASE	(0)
+#define TEGRA241_CMDQV_CONFIG_SIZE	(SZ_64K)
+#define TEGRA241_VCMDQ_PAGE0_BASE	(TEGRA241_CMDQV_CONFIG_BASE + SZ_64K)
+#define TEGRA241_VCMDQ_PAGE1_BASE	(TEGRA241_VCMDQ_PAGE0_BASE + SZ_64K)
+#define TEGRA241_VINTF_PAGE_BASE	(TEGRA241_VCMDQ_PAGE1_BASE + SZ_64K)
+
+/* CMDQV global config regs */
+#define TEGRA241_CMDQV_CONFIG		0x0000
+#define  CMDQV_EN			BIT(0)
+
+#define TEGRA241_CMDQV_PARAM		0x0004
+#define  CMDQV_NUM_VINTF_LOG2		GENMASK(11, 8)
+#define  CMDQV_NUM_VCMDQ_LOG2		GENMASK(7, 4)
+
+#define TEGRA241_CMDQV_STATUS		0x0008
+#define  CMDQV_ENABLED			BIT(0)
+
+#define TEGRA241_CMDQV_VINTF_ERR_MAP	0x0014
+#define TEGRA241_CMDQV_VINTF_INT_MASK	0x001C
+#define TEGRA241_CMDQV_VCMDQ_ERR_MAP0	0x0024
+#define TEGRA241_CMDQV_VCMDQ_ERR_MAP(i)	(0x0024 + 0x4*(i))
+
+#define TEGRA241_CMDQV_CMDQ_ALLOC(q)	(0x0200 + 0x4*(q))
+#define  CMDQV_CMDQ_ALLOC_VINTF		GENMASK(20, 15)
+#define  CMDQV_CMDQ_ALLOC_LVCMDQ	GENMASK(7, 1)
+#define  CMDQV_CMDQ_ALLOCATED		BIT(0)
+
+/* VINTF config regs */
+#define TEGRA241_VINTF(v)		(0x1000 + 0x100*(v))
+
+#define TEGRA241_VINTF_CONFIG		0x0000
+#define  VINTF_HYP_OWN			BIT(17)
+#define  VINTF_VMID			GENMASK(16, 1)
+#define  VINTF_EN			BIT(0)
+
+#define TEGRA241_VINTF_STATUS		0x0004
+#define  VINTF_STATUS			GENMASK(3, 1)
+#define  VINTF_ENABLED			BIT(0)
+
+#define TEGRA241_VINTF_CMDQ_ERR_MAP(m)	(0x00C0 + 0x4*(m))
+
+/* VCMDQ config regs */
+/* -- PAGE0 -- */
+#define TEGRA241_VCMDQ_PAGE0(q)		(TEGRA241_VCMDQ_PAGE0_BASE + 0x80*(q))
+
+#define TEGRA241_VCMDQ_CONS		0x00000
+#define  VCMDQ_CONS_ERR			GENMASK(30, 24)
+
+#define TEGRA241_VCMDQ_PROD		0x00004
+
+#define TEGRA241_VCMDQ_CONFIG		0x00008
+#define  VCMDQ_EN			BIT(0)
+
+#define TEGRA241_VCMDQ_STATUS		0x0000C
+#define  VCMDQ_ENABLED			BIT(0)
+
+#define TEGRA241_VCMDQ_GERROR		0x00010
+#define TEGRA241_VCMDQ_GERRORN		0x00014
+
+/* -- PAGE1 -- */
+#define TEGRA241_VCMDQ_PAGE1(q)		(TEGRA241_VCMDQ_PAGE1_BASE + 0x80*(q))
+#define  VCMDQ_ADDR			GENMASK(47, 5)
+#define  VCMDQ_LOG2SIZE			GENMASK(4, 0)
+
+#define TEGRA241_VCMDQ_BASE		0x00000
+#define TEGRA241_VCMDQ_CONS_INDX_BASE	0x00008
+
+/* VINTF logical-VCMDQ pages */
+#define TEGRA241_VINTFi_PAGE0(i)	(TEGRA241_VINTF_PAGE_BASE + SZ_128K*(i))
+#define TEGRA241_VINTFi_PAGE1(i)	(TEGRA241_VINTFi_PAGE0(i) + SZ_64K)
+#define TEGRA241_VINTFi_LVCMDQ_PAGE0(i, q) \
+					(TEGRA241_VINTFi_PAGE0(i) + 0x80*(q))
+#define TEGRA241_VINTFi_LVCMDQ_PAGE1(i, q) \
+					(TEGRA241_VINTFi_PAGE1(i) + 0x80*(q))
+
+/* MMIO helpers */
+#define cmdqv_readl(reg) \
+	readl(cmdqv->base + TEGRA241_CMDQV_##reg)
+#define cmdqv_readl_relaxed(reg) \
+	readl_relaxed(cmdqv->base + TEGRA241_CMDQV_##reg)
+#define cmdqv_writel(val, reg) \
+	writel((val), cmdqv->base + TEGRA241_CMDQV_##reg)
+#define cmdqv_writel_relaxed(val, reg) \
+	writel_relaxed((val), cmdqv->base + TEGRA241_CMDQV_##reg)
+
+#define vintf_readl(reg) \
+	readl(vintf->base + TEGRA241_VINTF_##reg)
+#define vintf_readl_relaxed(reg) \
+	readl_relaxed(vintf->base + TEGRA241_VINTF_##reg)
+#define vintf_writel(val, reg) \
+	writel((val), vintf->base + TEGRA241_VINTF_##reg)
+#define vintf_writel_relaxed(val, reg) \
+	writel_relaxed((val), vintf->base + TEGRA241_VINTF_##reg)
+
+#define vcmdq_page0_readl(reg) \
+	readl(vcmdq->page0 + TEGRA241_VCMDQ_##reg)
+#define vcmdq_page0_readl_relaxed(reg) \
+	readl_relaxed(vcmdq->page0 + TEGRA241_VCMDQ_##reg)
+#define vcmdq_page0_writel(val, reg) \
+	writel((val), vcmdq->page0 + TEGRA241_VCMDQ_##reg)
+#define vcmdq_page0_writel_relaxed(val, reg) \
+	writel_relaxed((val), vcmdq->page0 + TEGRA241_VCMDQ_##reg)
+
+#define vcmdq_page1_readl(reg) \
+	readl(vcmdq->page1 + TEGRA241_VCMDQ_##reg)
+#define vcmdq_page1_readl_relaxed(reg) \
+	readl_relaxed(vcmdq->page1 + TEGRA241_VCMDQ_##reg)
+#define vcmdq_page1_readq_relaxed(reg) \
+	readq_relaxed(vcmdq->page1 + TEGRA241_VCMDQ_##reg)
+#define vcmdq_page1_writel(val, reg) \
+	writel((val), vcmdq->page1 + TEGRA241_VCMDQ_##reg)
+#define vcmdq_page1_writel_relaxed(val, reg) \
+	writel_relaxed((val), vcmdq->page1 + TEGRA241_VCMDQ_##reg)
+#define vcmdq_page1_writeq(val, reg) \
+	writeq((val), vcmdq->page1 + TEGRA241_VCMDQ_##reg)
+#define vcmdq_page1_writeq_relaxed(val, reg) \
+	writeq_relaxed((val), vcmdq->page1 + TEGRA241_VCMDQ_##reg)
+
+/* Logging helpers */
+#define cmdqv_warn(fmt, ...) \
+	dev_warn(cmdqv->dev, "CMDQV: " fmt, ##__VA_ARGS__)
+#define cmdqv_err(fmt, ...) \
+	dev_err(cmdqv->dev, "CMDQV: " fmt, ##__VA_ARGS__)
+#define cmdqv_info(fmt, ...) \
+	dev_info(cmdqv->dev, "CMDQV: " fmt, ##__VA_ARGS__)
+#define cmdqv_dbg(fmt, ...) \
+	dev_dbg(cmdqv->dev, "CMDQV: " fmt, ##__VA_ARGS__)
+
+#define vintf_warn(fmt, ...) \
+	dev_warn(vintf->cmdqv->dev, "VINTF%u: " fmt, vintf->idx, ##__VA_ARGS__)
+#define vintf_err(fmt, ...) \
+	dev_err(vintf->cmdqv->dev, "VINTF%u: " fmt, vintf->idx, ##__VA_ARGS__)
+#define vintf_info(fmt, ...) \
+	dev_info(vintf->cmdqv->dev, "VINTF%u: " fmt, vintf->idx, ##__VA_ARGS__)
+#define vintf_dbg(fmt, ...) \
+	dev_dbg(vintf->cmdqv->dev, "VINTF%u: " fmt, vintf->idx, ##__VA_ARGS__)
+
+#define vcmdq_warn(fmt, ...)                                                   \
+	({                                                                     \
+		struct tegra241_vintf *vintf = vcmdq->vintf;                   \
+		if (vintf)                                                     \
+			vintf_warn("VCMDQ%u/LVCMDQ%u: " fmt,                   \
+				   vcmdq->idx, vcmdq->lidx,                    \
+				   ##__VA_ARGS__);                             \
+		else                                                           \
+			dev_warn(vcmdq->cmdqv->dev, "VCMDQ%u: " fmt,           \
+				 vcmdq->idx, ##__VA_ARGS__);                   \
+	})
+#define vcmdq_err(fmt, ...)                                                    \
+	({                                                                     \
+		struct tegra241_vintf *vintf = vcmdq->vintf;                   \
+		if (vintf)                                                     \
+			vintf_err("VCMDQ%u/LVCMDQ%u: " fmt,                    \
+				  vcmdq->idx, vcmdq->lidx,                     \
+				  ##__VA_ARGS__);                              \
+		else                                                           \
+			dev_err(vcmdq->cmdqv->dev, "VCMDQ%u: " fmt,            \
+				vcmdq->idx, ##__VA_ARGS__);                    \
+	})
+#define vcmdq_info(fmt, ...)                                                   \
+	({                                                                     \
+		struct tegra241_vintf *vintf = vcmdq->vintf;                   \
+		if (vintf)                                                     \
+			vintf_info("VCMDQ%u/LVCMDQ%u: " fmt,                   \
+				   vcmdq->idx, vcmdq->lidx,                    \
+				   ##__VA_ARGS__);                             \
+		else                                                           \
+			dev_info(vcmdq->cmdqv->dev, "VCMDQ%u: " fmt,           \
+				 vcmdq->idx, ##__VA_ARGS__);                   \
+	})
+#define vcmdq_dbg(fmt, ...)                                                    \
+	({                                                                     \
+		struct tegra241_vintf *vintf = vcmdq->vintf;                   \
+		if (vintf)                                                     \
+			vintf_dbg("VCMDQ%u/LVCMDQ%u: " fmt,                    \
+				  vcmdq->idx, vcmdq->lidx,                     \
+				  ##__VA_ARGS__);                              \
+		else                                                           \
+			dev_dbg(vcmdq->cmdqv->dev, "VCMDQ%u: " fmt,            \
+				vcmdq->idx, ##__VA_ARGS__);                    \
+	})
+
+/* Configuring and polling helpers */
+#define tegra241_cmdqv_write_config(_owner, _OWNER, _regval)                   \
+	({                                                                     \
+		bool _en = (_regval) & _OWNER##_EN;                            \
+		u32 _status;                                                   \
+		int _ret;                                                      \
+		writel((_regval), _owner->base + TEGRA241_##_OWNER##_CONFIG);  \
+		_ret = readl_poll_timeout(                                     \
+			_owner->base + TEGRA241_##_OWNER##_STATUS, _status,    \
+			_en ? (_regval) & _OWNER##_ENABLED :                   \
+			      !((_regval) & _OWNER##_ENABLED),                 \
+			1, ARM_SMMU_POLL_TIMEOUT_US);                          \
+		if (_ret)                                                      \
+			_owner##_err("failed to %sable, STATUS = 0x%08X\n",    \
+				     _en ? "en" : "dis", _status);             \
+		atomic_set(&_owner->status, _status);                          \
+		_ret;                                                          \
+	})
+
+#define cmdqv_write_config(_regval) \
+	tegra241_cmdqv_write_config(cmdqv, CMDQV, _regval)
+#define vintf_write_config(_regval) \
+	tegra241_cmdqv_write_config(vintf, VINTF, _regval)
+#define vcmdq_write_config(_regval) \
+	tegra241_cmdqv_write_config(vcmdq, VCMDQ, _regval)
+
+static bool disable_cmdqv;
+module_param(disable_cmdqv, bool, 0444);
+MODULE_PARM_DESC(disable_cmdqv,
+	"This allows to disable CMDQV HW and use default SMMU internal CMDQ.");
+
+static bool bypass_vcmdq;
+module_param(bypass_vcmdq, bool, 0444);
+MODULE_PARM_DESC(bypass_vcmdq,
+	"This allows to bypass VCMDQ for debugging use or perf comparison.");
+
+/**
+ * struct tegra241_vcmdq - Virtual Command Queue
+ * @idx: Global index in the CMDQV HW
+ * @lidx: Local index in the VINTF
+ * @status: cached status register
+ * @cmdqv: CMDQV HW pointer
+ * @vintf: VINTF HW pointer
+ * @cmdq: Command Queue struct
+ * @base: MMIO base address
+ * @page0: MMIO Page0 base address
+ * @page1: MMIO Page1 base address
+ */
+struct tegra241_vcmdq {
+	u16 idx;
+	u16 lidx;
+
+	atomic_t status;
+
+	struct tegra241_cmdqv *cmdqv;
+	struct tegra241_vintf *vintf;
+	struct arm_smmu_cmdq cmdq;
+
+	void __iomem *base;
+	void __iomem *page0;
+	void __iomem *page1;
+};
+
+/**
+ * struct tegra241_vintf - Virtual Interface
+ * @idx: Global index in the CMDQV HW
+ * @status: cached status register
+ * @cmdqv: CMDQV HW pointer
+ * @vcmdqs: List of VCMDQ pointers
+ * @base: MMIO base address
+ */
+struct tegra241_vintf {
+	u16 idx;
+
+	atomic_t status;
+
+	struct tegra241_cmdqv *cmdqv;
+	struct tegra241_vcmdq **vcmdqs;
+
+	void __iomem *base;
+};
+
+/**
+ * struct tegra241_cmdqv - CMDQ-V for SMMUv3
+ * @smmu: SMMUv3 pointer
+ * @dev: Device pointer
+ * @base: MMIO base address
+ * @irq: IRQ number
+ * @num_vintfs: Total number of VINTFs
+ * @num_vcmdqs: Total number of VCMDQs
+ * @num_vcmdqs_per_vintf: Number of VCMDQs per VINTF
+ * @status: cached status register
+ * @vintf_ids: VINTF id allocator
+ * @vcmdq_ids: VCMDQ id allocator
+ * @vtinfs: List of VINTFs
+ */
+struct tegra241_cmdqv {
+	struct arm_smmu_device *smmu;
+
+	struct device *dev;
+	void __iomem *base;
+	int irq;
+
+	/* CMDQV Hardware Params */
+	u16 num_vintfs;
+	u16 num_vcmdqs;
+	u16 num_vcmdqs_per_vintf;
+
+	atomic_t status;
+
+	struct ida vintf_ids;
+	struct ida vcmdq_ids;
+
+	struct tegra241_vintf **vintfs;
+};
+
+static void tegra241_cmdqv_handle_vintf0_error(struct tegra241_cmdqv *cmdqv)
+{
+	struct tegra241_vintf *vintf = cmdqv->vintfs[0];
+	int i;
+
+	/* Cache status to bypass VCMDQs until error is recovered */
+	atomic_set(&vintf->status, vintf_readl(STATUS));
+
+	for (i = 0; i < 4; i++) {
+		u32 lvcmdq_err_map = vintf_readl_relaxed(CMDQ_ERR_MAP(i));
+
+		while (lvcmdq_err_map) {
+			int lidx = ffs(lvcmdq_err_map) - 1;
+			struct tegra241_vcmdq *vcmdq = vintf->vcmdqs[lidx];
+			u32 gerrorn, gerror;
+
+			lvcmdq_err_map &= ~BIT(lidx);
+
+			__arm_smmu_cmdq_skip_err(cmdqv->smmu, &vcmdq->cmdq.q);
+
+			gerrorn = vcmdq_page0_readl_relaxed(GERRORN);
+			gerror = vcmdq_page0_readl_relaxed(GERROR);
+
+			vcmdq_page0_writel(gerror, GERRORN);
+		}
+	}
+
+	/* Now error status should be clean, cache it again */
+	atomic_set(&vintf->status, vintf_readl(STATUS));
+}
+
+static irqreturn_t tegra241_cmdqv_isr(int irq, void *devid)
+{
+	struct tegra241_cmdqv *cmdqv = (struct tegra241_cmdqv *)devid;
+	u32 vintf_errs[2];
+	u32 vcmdq_errs[4];
+
+	vintf_errs[0] = cmdqv_readl_relaxed(VINTF_ERR_MAP);
+	vintf_errs[1] = cmdqv_readl_relaxed(VINTF_ERR_MAP + 0x4);
+
+	vcmdq_errs[0] = cmdqv_readl_relaxed(VCMDQ_ERR_MAP(0));
+	vcmdq_errs[1] = cmdqv_readl_relaxed(VCMDQ_ERR_MAP(1));
+	vcmdq_errs[2] = cmdqv_readl_relaxed(VCMDQ_ERR_MAP(2));
+	vcmdq_errs[3] = cmdqv_readl_relaxed(VCMDQ_ERR_MAP(3));
+
+	cmdqv_warn("unexpected cmdqv error reported\n");
+	cmdqv_warn(" vintf_map: 0x%08X%08X\n", vintf_errs[1], vintf_errs[0]);
+	cmdqv_warn(" vcmdq_map: 0x%08X%08X%08X%08X\n",
+		   vcmdq_errs[3], vcmdq_errs[2], vcmdq_errs[1], vcmdq_errs[0]);
+
+	/* Handle VINTF0 and its VCMDQs */
+	if (vintf_errs[0] & 0x1)
+		tegra241_cmdqv_handle_vintf0_error(cmdqv);
+
+	return IRQ_HANDLED;
+}
+
+struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
+{
+	struct tegra241_cmdqv *cmdqv = smmu->tegra241_cmdqv;
+	struct tegra241_vintf *vintf = cmdqv->vintfs[0];
+	struct tegra241_vcmdq *vcmdq;
+	u16 lidx;
+
+	if (bypass_vcmdq)
+		return &smmu->cmdq;
+
+	/* Use SMMU CMDQ if vintfs[0] is uninitialized */
+	if (!FIELD_GET(VINTF_ENABLED, atomic_read(&vintf->status)))
+		return &smmu->cmdq;
+
+	/* Use SMMU CMDQ if vintfs[0] has error status */
+	if (FIELD_GET(VINTF_STATUS, atomic_read(&vintf->status)))
+		return &smmu->cmdq;
+
+	/*
+	 * Select a vcmdq to use. Here we use a temporal solution to
+	 * balance out traffic on cmdq issuing: each cmdq has its own
+	 * lock, if all cpus issue cmdlist using the same cmdq, only
+	 * one CPU at a time can enter the process, while the others
+	 * will be spinning at the same lock.
+	 */
+	lidx = smp_processor_id() % cmdqv->num_vcmdqs_per_vintf;
+	vcmdq = vintf->vcmdqs[lidx];
+	if (!FIELD_GET(VCMDQ_ENABLED, atomic_read(&vcmdq->status)))
+		return &smmu->cmdq;
+	return &vcmdq->cmdq;
+}
+
+static void tegra241_vcmdq_hw_deinit(struct tegra241_vcmdq *vcmdq)
+{
+	u32 gerrorn, gerror;
+
+	if (vcmdq_write_config(0)) {
+		vcmdq_err("GERRORN=0x%X\n", vcmdq_page0_readl_relaxed(GERRORN));
+		vcmdq_err("GERROR=0x%X\n", vcmdq_page0_readl_relaxed(GERROR));
+		vcmdq_err("CONS=0x%X\n", vcmdq_page0_readl_relaxed(CONS));
+	}
+	vcmdq_page0_writel_relaxed(0, PROD);
+	vcmdq_page0_writel_relaxed(0, CONS);
+	vcmdq_page1_writeq_relaxed(0, BASE);
+	vcmdq_page1_writeq_relaxed(0, CONS_INDX_BASE);
+
+	gerrorn = vcmdq_page0_readl_relaxed(GERRORN);
+	gerror = vcmdq_page0_readl_relaxed(GERROR);
+	if (gerror != gerrorn) {
+		vcmdq_info("Uncleared error detected, resetting\n");
+		vcmdq_page0_writel(gerror, GERRORN);
+	}
+
+	vcmdq_dbg("deinited\n");
+}
+
+static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
+{
+	int ret;
+
+	/* Configure and enable the vcmdq */
+	tegra241_vcmdq_hw_deinit(vcmdq);
+
+	vcmdq_page1_writeq_relaxed(vcmdq->cmdq.q.q_base, BASE);
+
+	ret = vcmdq_write_config(VCMDQ_EN);
+	if (ret) {
+		vcmdq_err("GERRORN=0x%X\n", vcmdq_page0_readl_relaxed(GERRORN));
+		vcmdq_err("GERROR=0x%X\n", vcmdq_page0_readl_relaxed(GERROR));
+		vcmdq_err("CONS=0x%X\n", vcmdq_page0_readl_relaxed(CONS));
+		return ret;
+	}
+
+	vcmdq_dbg("inited\n");
+	return 0;
+}
+
+/* Adapt struct arm_smmu_cmdq init sequences from arm-smmu-v3.c for VCMDQs */
+static int tegra241_vcmdq_alloc_smmu_cmdq(struct tegra241_vcmdq *vcmdq)
+{
+	struct arm_smmu_device *smmu = vcmdq->cmdqv->smmu;
+	struct arm_smmu_cmdq *cmdq = &vcmdq->cmdq;
+	struct arm_smmu_queue *q = &cmdq->q;
+	char name[16];
+	int ret;
+
+	sprintf(name, "vcmdq%u", vcmdq->idx);
+
+	q->llq.max_n_shift = ilog2(SZ_64K >> CMDQ_ENT_SZ_SHIFT);
+
+	/* Use the common helper to init the VCMDQ, and then... */
+	ret = arm_smmu_init_one_queue(smmu, q, vcmdq->page0,
+				      TEGRA241_VCMDQ_PROD, TEGRA241_VCMDQ_CONS,
+				      CMDQ_ENT_DWORDS, name);
+	if (ret)
+		return ret;
+
+	/* ...override q_base to write VCMDQ_BASE registers */
+	q->q_base = q->base_dma & VCMDQ_ADDR;
+	q->q_base |= FIELD_PREP(VCMDQ_LOG2SIZE, q->llq.max_n_shift);
+
+	/* All VCMDQs support CS_NONE only for CMD_SYNC */
+	q->quirks = CMDQ_QUIRK_SYNC_CS_NONE_ONLY;
+
+	return arm_smmu_cmdq_init(smmu, cmdq);
+}
+
+static void tegra241_vcmdq_free_smmu_cmdq(struct tegra241_vcmdq *vcmdq)
+{
+	struct tegra241_cmdqv *cmdqv = vcmdq->cmdqv;
+	struct arm_smmu_queue *q = &vcmdq->cmdq.q;
+	size_t nents = 1 << q->llq.max_n_shift;
+
+	dmam_free_coherent(cmdqv->smmu->dev, (nents * CMDQ_ENT_DWORDS) << 3,
+			   q->base, q->base_dma);
+}
+
+static int tegra241_vintf_lvcmdq_init(struct tegra241_vintf *vintf, u16 lidx,
+				      struct tegra241_vcmdq *vcmdq)
+{
+	struct tegra241_cmdqv *cmdqv = vintf->cmdqv;
+	u16 idx = vintf->idx;
+	u16 qidx;
+
+	qidx = ida_alloc_max(&cmdqv->vcmdq_ids,
+			     cmdqv->num_vcmdqs - 1, GFP_KERNEL);
+	if (qidx < 0)
+		return qidx;
+
+	vcmdq->idx = qidx;
+	vcmdq->lidx = lidx;
+	vcmdq->cmdqv = cmdqv;
+	vcmdq->vintf = vintf;
+	vcmdq->page0 = cmdqv->base + TEGRA241_VINTFi_LVCMDQ_PAGE0(idx, lidx);
+	vcmdq->page1 = cmdqv->base + TEGRA241_VINTFi_LVCMDQ_PAGE1(idx, lidx);
+	vcmdq->base = vcmdq->page0; /* CONFIG register is in page0 */
+	return 0;
+}
+
+static void tegra241_vintf_lvcmdq_deinit(struct tegra241_vcmdq *vcmdq)
+{
+	ida_free(&vcmdq->cmdqv->vcmdq_ids, vcmdq->idx);
+}
+
+static struct tegra241_vcmdq *
+tegra241_vintf_lvcmdq_alloc(struct tegra241_vintf *vintf, u16 lidx)
+{
+	struct tegra241_cmdqv *cmdqv = vintf->cmdqv;
+	struct tegra241_vcmdq *vcmdq;
+	int ret;
+
+	vcmdq = devm_kzalloc(cmdqv->dev, sizeof(*vcmdq), GFP_KERNEL);
+	if (!vcmdq)
+		return ERR_PTR(-ENOMEM);
+
+	ret = tegra241_vintf_lvcmdq_init(vintf, lidx, vcmdq);
+	if (ret)
+		goto free_vcmdq;
+
+	/* Setup struct arm_smmu_cmdq data members */
+	ret = tegra241_vcmdq_alloc_smmu_cmdq(vcmdq);
+	if (ret)
+		goto deinit_lvcmdq;
+
+	ret = tegra241_vcmdq_hw_init(vcmdq);
+	if (ret)
+		goto free_queue;
+
+	vcmdq_dbg("allocated\n");
+	return vcmdq;
+free_queue:
+	tegra241_vcmdq_free_smmu_cmdq(vcmdq);
+deinit_lvcmdq:
+	tegra241_vintf_lvcmdq_deinit(vcmdq);
+free_vcmdq:
+	devm_kfree(cmdqv->dev, vcmdq);
+	return ERR_PTR(ret);
+}
+
+static void tegra241_vintf_lvcmdq_free(struct tegra241_vcmdq *vcmdq)
+{
+	tegra241_vcmdq_hw_deinit(vcmdq);
+	tegra241_vcmdq_free_smmu_cmdq(vcmdq);
+	tegra241_vintf_lvcmdq_deinit(vcmdq);
+	devm_kfree(vcmdq->cmdqv->dev, vcmdq);
+}
+
+int tegra241_cmdqv_device_reset(struct arm_smmu_device *smmu)
+{
+	struct tegra241_cmdqv *cmdqv = smmu->tegra241_cmdqv;
+	struct tegra241_vintf *vintf = cmdqv->vintfs[0];
+	int qidx, lidx, idx, ret;
+	u32 regval;
+
+	/* Reset CMDQV */
+	regval = cmdqv_readl_relaxed(CONFIG);
+	ret = cmdqv_write_config(regval & ~CMDQV_EN);
+	if (ret)
+		return ret;
+	ret = cmdqv_write_config(regval | CMDQV_EN);
+	if (ret)
+		return ret;
+
+	/* Reset and configure vintf0 */
+	ret = vintf_write_config(0);
+	if (ret)
+		return ret;
+
+	/* Pre-allocate num_vcmdqs_per_vintf of VCMDQs to each VINTF */
+	for (idx = 0, qidx = 0; idx < cmdqv->num_vintfs; idx++) {
+		for (lidx = 0; lidx < cmdqv->num_vcmdqs_per_vintf; lidx++) {
+			regval  = FIELD_PREP(CMDQV_CMDQ_ALLOC_VINTF, idx);
+			regval |= FIELD_PREP(CMDQV_CMDQ_ALLOC_LVCMDQ, lidx);
+			regval |= CMDQV_CMDQ_ALLOCATED;
+			cmdqv_writel_relaxed(regval, CMDQ_ALLOC(qidx++));
+		}
+	}
+
+	regval = FIELD_PREP(VINTF_HYP_OWN, 1);
+	vintf_writel(regval, CONFIG);
+
+	ret = vintf_write_config(regval | VINTF_EN);
+	if (ret)
+		return ret;
+
+	/* Build an arm_smmu_cmdq for each vcmdq allocated to vintf */
+	vintf->vcmdqs = devm_kcalloc(cmdqv->dev, cmdqv->num_vcmdqs_per_vintf,
+				     sizeof(*vintf->vcmdqs), GFP_KERNEL);
+	if (!vintf->vcmdqs)
+		return -ENOMEM;
+
+	/* Allocate logical vcmdqs to vintf */
+	for (lidx = 0; lidx < cmdqv->num_vcmdqs_per_vintf; lidx++) {
+		struct tegra241_vcmdq *vcmdq;
+
+		vcmdq = tegra241_vintf_lvcmdq_alloc(vintf, lidx);
+		if (IS_ERR(vcmdq))
+			goto free_lvcmdq;
+		vintf->vcmdqs[lidx] = vcmdq;
+	}
+
+	return 0;
+free_lvcmdq:
+	for (lidx--; lidx >= 0; lidx--)
+		tegra241_vintf_lvcmdq_free(vintf->vcmdqs[lidx]);
+	devm_kfree(cmdqv->dev, vintf->vcmdqs);
+	return ret;
+}
+
+static int tegra241_cmdqv_acpi_is_memory(struct acpi_resource *res, void *data)
+{
+	struct resource_win win;
+
+	return !acpi_dev_resource_address_space(res, &win);
+}
+
+static int tegra241_cmdqv_acpi_get_irqs(struct acpi_resource *ares, void *data)
+{
+	struct resource r;
+	int *irq = data;
+
+	if (*irq <= 0 && acpi_dev_resource_interrupt(ares, 0, &r))
+		*irq = r.start;
+	return 1; /* No need to add resource to the list */
+}
+
+static struct tegra241_cmdqv *
+tegra241_cmdqv_find_resource(struct arm_smmu_device *smmu, int id)
+{
+	struct tegra241_cmdqv *cmdqv = NULL;
+	struct device *dev = smmu->dev;
+	struct list_head resource_list;
+	struct resource_entry *rentry;
+	struct acpi_device *adev;
+	const char *match_uid;
+	int ret;
+
+	if (acpi_disabled)
+		return NULL;
+
+	/* Look for a device in the DSDT whose _UID matches the SMMU node ID */
+	match_uid = kasprintf(GFP_KERNEL, "%u", id);
+	adev = acpi_dev_get_first_match_dev(TEGRA241_CMDQV_HID, match_uid, -1);
+	kfree(match_uid);
+
+	if (!adev)
+		return NULL;
+
+	dev_info(dev, "found companion CMDQV device, %s\n",
+		 dev_name(&adev->dev));
+
+	INIT_LIST_HEAD(&resource_list);
+	ret = acpi_dev_get_resources(adev, &resource_list,
+				     tegra241_cmdqv_acpi_is_memory, NULL);
+	if (ret < 0) {
+		dev_err(dev, "failed to get memory resource: %d\n", ret);
+		goto put_dev;
+	}
+
+	cmdqv = devm_kzalloc(dev, sizeof(*cmdqv), GFP_KERNEL);
+	if (!cmdqv)
+		goto free_list;
+
+	cmdqv->dev = dev;
+	cmdqv->smmu = smmu;
+
+	rentry = list_first_entry_or_null(&resource_list,
+					  struct resource_entry, node);
+	if (!rentry) {
+		cmdqv_err("failed to get memory resource entry\n");
+		goto free_cmdqv;
+	}
+
+	cmdqv->base = devm_ioremap_resource(smmu->dev, rentry->res);
+	if (IS_ERR(cmdqv->base)) {
+		cmdqv_err("failed to ioremap: %ld\n", PTR_ERR(cmdqv->base));
+		goto free_cmdqv;
+	}
+
+	acpi_dev_free_resource_list(&resource_list);
+
+	INIT_LIST_HEAD(&resource_list);
+
+	ret = acpi_dev_get_resources(adev, &resource_list,
+				     tegra241_cmdqv_acpi_get_irqs, &cmdqv->irq);
+	if (ret < 0 || cmdqv->irq <= 0) {
+		cmdqv_warn("no cmdqv interrupt. errors will not be reported\n");
+	} else {
+		ret = devm_request_irq(smmu->dev, cmdqv->irq,
+				       tegra241_cmdqv_isr, 0,
+				       "tegra241-cmdqv", cmdqv);
+		if (ret) {
+			cmdqv_err("failed to request irq (%d): %d\n",
+				  cmdqv->irq, ret);
+			goto iounmap;
+		}
+	}
+
+	goto free_list;
+
+iounmap:
+	devm_iounmap(cmdqv->dev, cmdqv->base);
+free_cmdqv:
+	devm_kfree(cmdqv->dev, cmdqv);
+	cmdqv = NULL;
+free_list:
+	acpi_dev_free_resource_list(&resource_list);
+put_dev:
+	put_device(&adev->dev);
+
+	return cmdqv;
+}
+
+struct dentry *cmdqv_debugfs_dir;
+
+static int tegra241_cmdqv_probe(struct tegra241_cmdqv *cmdqv)
+{
+	struct tegra241_vintf *vintf;
+	u32 regval;
+	int ret;
+
+	regval = cmdqv_readl(CONFIG);
+	if (disable_cmdqv) {
+		cmdqv_info("disable_cmdqv=true. Falling back to SMMU CMDQ\n");
+		cmdqv_write_config(regval & ~CMDQV_EN);
+		return -ENODEV;
+	}
+
+	ret = cmdqv_write_config(regval | CMDQV_EN);
+	if (ret)
+		return ret;
+
+	regval = cmdqv_readl_relaxed(PARAM);
+	cmdqv->num_vintfs = 1 << FIELD_GET(CMDQV_NUM_VINTF_LOG2, regval);
+	cmdqv->num_vcmdqs = 1 << FIELD_GET(CMDQV_NUM_VCMDQ_LOG2, regval);
+	cmdqv->num_vcmdqs_per_vintf = cmdqv->num_vcmdqs / cmdqv->num_vintfs;
+
+	cmdqv->vintfs = devm_kcalloc(cmdqv->dev, cmdqv->num_vintfs,
+				     sizeof(*cmdqv->vintfs), GFP_KERNEL);
+	if (!cmdqv->vintfs)
+		return -ENOMEM;
+
+	vintf = devm_kzalloc(cmdqv->dev, sizeof(*vintf), GFP_KERNEL);
+	if (!vintf) {
+		ret = -ENOMEM;
+		goto free_vintfs;
+	}
+
+	ida_init(&cmdqv->vintf_ids);
+	ida_init(&cmdqv->vcmdq_ids);
+
+	/* Reserve vintfs[0] for in-kernel use */
+	ret = ida_alloc_max(&cmdqv->vintf_ids, 0, GFP_KERNEL);
+	if (ret != 0) {
+		cmdqv_err("failed to reserve vintf0: ret %d\n", ret);
+		if (ret > 0)
+			ret = -EBUSY;
+		goto destroy_ids;
+	}
+	vintf->idx = 0;
+	cmdqv->vintfs[0] = vintf;
+
+	vintf->cmdqv = cmdqv;
+	vintf->base = cmdqv->base + TEGRA241_VINTF(0);
+
+#ifdef CONFIG_IOMMU_DEBUGFS
+	if (!cmdqv_debugfs_dir) {
+		cmdqv_debugfs_dir = debugfs_create_dir("tegra241_cmdqv", iommu_debugfs_dir);
+		debugfs_create_bool("bypass_vcmdq", 0644, cmdqv_debugfs_dir, &bypass_vcmdq);
+	}
+#endif
+
+	return 0;
+destroy_ids:
+	ida_destroy(&cmdqv->vcmdq_ids);
+	ida_destroy(&cmdqv->vintf_ids);
+	devm_kfree(cmdqv->dev, vintf);
+free_vintfs:
+	devm_kfree(cmdqv->dev, cmdqv->vintfs);
+	return ret;
+}
+
+struct tegra241_cmdqv *
+tegra241_cmdqv_acpi_probe(struct arm_smmu_device *smmu, int id)
+{
+	struct tegra241_cmdqv *cmdqv;
+
+	cmdqv = tegra241_cmdqv_find_resource(smmu, id);
+	if (!cmdqv)
+		return NULL;
+
+	if (tegra241_cmdqv_probe(cmdqv)) {
+		if (cmdqv->irq > 0)
+			devm_free_irq(smmu->dev, cmdqv->irq, cmdqv);
+		devm_iounmap(smmu->dev, cmdqv->base);
+		devm_kfree(smmu->dev, cmdqv);
+		return NULL;
+	}
+
+	return cmdqv;
+}
-- 
2.43.0


