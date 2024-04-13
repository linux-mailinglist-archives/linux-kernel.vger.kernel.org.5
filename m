Return-Path: <linux-kernel+bounces-143552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 796F08A3AC2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D026E1F24AC1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99561BC3E;
	Sat, 13 Apr 2024 03:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="moH9E55U"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988E622625;
	Sat, 13 Apr 2024 03:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712979864; cv=fail; b=k1J0ZnHWCOY553ZMRRqIgC01E7I+ypkufyTJY1MTC9m29fN5uKlxMaBCUhufoNj0htWFKxq93LTf9wjdhE/TxsnHwUxzTNoQQ1LNq0DqUcUQD9sik/AOa1T/vAGp8J7SETwLuD+G4u5Osknn9JDRlUKRerz27LrOcKeH+gfEwyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712979864; c=relaxed/simple;
	bh=dtwWqqLeK73drM3gblORo84wt9Hox/uWhZvN1gnnI4M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G3EqX0PhLV2Q6PGX4zNHlTLFEe/7QANtCP7KJFbAAv49PjrbZ4Cm6mlmIZNe8KaE/L419WckumsGEw9HO8baSG3TmqiC/jRf2qZV8SZ6BBuyM0/yMvcXuMFN92kBrkGZA24obgZHBh78zmapFqBvtqUkrwbrCaQhx6VyzJyU6Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=moH9E55U; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VA7bpTzI/WKxG16GhchqJd2KRy2dpchg2sMuaqfZNJBnnhdp13yr/KhEzEElbuXJISbX7f8uon77ZDXyQ9ZtJjtO5wHCcBiaIlh79FdkLLaySYV/T5QoZcToj/A3iLPRIKI+a/EcV62igtOU+bxJZQM1lmaIThcYcQdvViUkNSFDvGf5ZlcwKWEq5IO/t39EGKThZxxujjKGiU7kSSF52oi63g9d6qTf1a8/eDZ9X/LF1/sw2HdZ3+7EurKrgvAOcZHk9ZdF7wgfZqS+htzbcv8gDwEDGuE1x+Ijj0kkuFciU4hai5COQ8piwJbBj3Zd3Hhicq0eExpKCsBJGoCLSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pvEdzRwacagJPQstepvTvqZqZSMEEDc4SMh2CusMCU=;
 b=kOascPEuFFgbiNUHWPyfqNVTXi4SO+nHLJJ3tJZbD+IypZfIT3Ce3lHZrQuHa6dcVxcoPNNyTm7QzCRXTpbcLBPhW24SDd4C3LffUxBf6HyRRtDD8u3fkJlKbuLWHIApc3nr2Ss4vdundSLg7pu+aoFaGdONvleLk5pm3z9PYzsq/W25jRbM1MInZSsKkEZZ2Ww3Chrjx8gXw11CvYjh6C4SDPKCpqUPQ/RIreJvU6/B02z/Dv/Qi4sQ+PJlbwphs1PLOD3G4Zw895wuXuzpiWnmJxNyUNh0BD1gZj5A/rp3lSRV+2a0WbXo4eHRXBHE5HGQ6pgOOcvvZEr8sx1jrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pvEdzRwacagJPQstepvTvqZqZSMEEDc4SMh2CusMCU=;
 b=moH9E55UltIp+0tXaqbl+3nHrwAS6yMckg+BjumB5g9FQaFMz+lFdXTXVnmUb74IAZdm3Lm54um10TZS9dNbzoi9NJpFRoTxYI/FOYwEqxP/eYV7k/1UxLcGPT1rQxxyN6e0LQH0nmeXp+ME1dIEJkW7d7rxULAzbL+ZYxJ1n4/0TXBkaCtdxC3QaPyQhIQVyNOHI+WVp655ZO11b0aY8EtobfcxZaums1IzxElX74VQvcvrT2+AyMb9sjR/huCOcEZPd7ifQETSTWDa0MjDFrL8YW0pLQFN5MqDodYSjNDN2UFHEsl2HqC9+HuESxxarQObcnxJKuyHK63MBpj3nQ==
Received: from BL1P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::7)
 by SA3PR12MB8437.namprd12.prod.outlook.com (2603:10b6:806:2f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 13 Apr
 2024 03:44:17 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:208:2c5:cafe::11) by BL1P221CA0020.outlook.office365.com
 (2603:10b6:208:2c5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26 via Frontend
 Transport; Sat, 13 Apr 2024 03:44:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.0 via Frontend Transport; Sat, 13 Apr 2024 03:44:16 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 20:44:06 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 12 Apr 2024 20:44:06 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 12 Apr 2024 20:44:05 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v5 5/6] iommu/arm-smmu-v3: Add in-kernel support for NVIDIA Tegra241 (Grace) CMDQV
Date: Fri, 12 Apr 2024 20:43:53 -0700
Message-ID: <9ee45e60f0f85784fc25492cdfeec003e703325c.1712977210.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1712977210.git.nicolinc@nvidia.com>
References: <cover.1712977210.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|SA3PR12MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: d64632a0-7004-4a33-0c4b-08dc5b6bfe78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q0c5sLHNDGIFNB1AOXvjbO8SXViM7nHYFtGap37L2642rBeUDD9YrRGS/TcuhAick3MlvptkJ63KmRi5750Y+l1n5r0XGfDrnBt7YEjFe66U1+XYK0STFDiSZgBMCsH/2+HczOvxDBWvb0xuR/qvd8E1Rl1Ksp0U6SOaQT9KHLBG8jEtnzQtMqpCIF0ltnzmj4PeKRoqbCNjFbkxSOAiBsPFIkqC+3Vlu7J5DNEAIPXlqdp5+DfGf8LOBM7Usf+yDioCcdyeM0Rz+Fxi6XQg3lye48pdCy6x7DGnSIBMX9H05iNmqBw6J04GZbvOgONYlx9I7cKiLfwsLqsP7p5YGvk13lXYvIVf1Y59ir5TyEX6JuxygDqjDunqBuMvkfDM5j4ss+Ag0TpzLTVlG8lOtGCa2imuTMFJ/4P50zUGb7sZGScL9/xkroPvTW7IR/7WivicLm/uPIlaLKHfuxxbqIS++iwpamNTlGivao/ZOQnaucfaxcALAciY14M9yho2KbVLEuMuawXLv98a2V3W7QtqTIAX6xtZZVydQIroFqRO3pm2YMTsH1LlMms/uwTrPUUNlqwwo8hk55aFh0dOzz5MII+UMO0LP9j/3ee73qfYnfYeNvE1hv7cf4n7c0Vs7ttzWeAqaaEv39iN44sgwT3CDQc92Y5o7Ac4YQo3NcQN2W9roS1r2oFvMvmgZQmBqfYXT4EfrPH/24A+jThWxVcw/CGXSJnl7zBKwcsXkXi+9jUj2PIQCo/A7wm6UaAO
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 03:44:16.6801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d64632a0-7004-4a33-0c4b-08dc5b6bfe78
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8437

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
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 804 ++++++++++++++++++
 6 files changed, 871 insertions(+), 6 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c

diff --git a/MAINTAINERS b/MAINTAINERS
index aea47e04c3a5..b0e66aecfa71 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21758,6 +21758,7 @@ M:	Thierry Reding <thierry.reding@gmail.com>
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
index cedaf606962b..ba7a933c1efb 100644
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
 
@@ -3104,12 +3107,10 @@ static struct iommu_ops arm_smmu_ops = {
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
 
@@ -3566,6 +3567,12 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
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
@@ -3940,6 +3947,9 @@ static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
 	if (iort_smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE)
 		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
 
+	smmu->tegra241_cmdqv =
+		tegra241_cmdqv_acpi_probe(smmu, node->identifier);
+
 	return 0;
 }
 #else
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ce0b0afe62b8..5b8e463c28eb 100644
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
@@ -763,6 +771,10 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
 		       struct arm_smmu_cmdq *cmdq);
 void __arm_smmu_cmdq_skip_err(struct device *dev, struct arm_smmu_queue *q);
+int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
+			    struct arm_smmu_queue *q, void __iomem *page,
+			    unsigned long prod_off, unsigned long cons_off,
+			    size_t dwords, const char *name);
 
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
@@ -819,4 +831,29 @@ static inline void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
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
index 000000000000..15683123a4ce
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -0,0 +1,804 @@
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
+ * @enabled: Enabled or not
+ * @error: Status error or not
+ * @cmdqv: CMDQV HW pointer
+ * @vcmdqs: List of VCMDQ pointers
+ * @base: MMIO base address
+ */
+struct tegra241_vintf {
+	u16 idx;
+
+	bool enabled;
+	atomic_t error;	/* Race between interrupts and get_cmdq() */
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
+	/* Cache error status to bypass VCMDQs until error is recovered */
+	atomic_set(&vintf->error,
+		   !!FIELD_GET(VINTF_STATUS, vintf_readl(STATUS)));
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
+			__arm_smmu_cmdq_skip_err(cmdqv->dev, &vcmdq->cmdq.q);
+
+			gerrorn = vcmdq_page0_readl_relaxed(GERRORN);
+			gerror = vcmdq_page0_readl_relaxed(GERROR);
+
+			vcmdq_page0_writel(gerror, GERRORN);
+		}
+	}
+
+	/* Now error status should be clean, cache it again */
+	atomic_set(&vintf->error,
+		   !!FIELD_GET(VINTF_STATUS, vintf_readl(STATUS)));
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
+	u16 lidx;
+
+	if (bypass_vcmdq)
+		return &smmu->cmdq;
+
+	/* Use SMMU CMDQ if vintfs[0] is uninitialized */
+	if (!vintf->enabled)
+		return &smmu->cmdq;
+
+	/* Use SMMU CMDQ if vintfs[0] has error status */
+	if (atomic_read(&vintf->error))
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
+	return &vintf->vcmdqs[lidx]->cmdq;
+}
+
+static void tegra241_vcmdq_hw_deinit(struct tegra241_vcmdq *vcmdq)
+{
+	struct tegra241_cmdqv *cmdqv = vcmdq->cmdqv;
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
+	cmdqv_writel_relaxed(0, CMDQ_ALLOC(vcmdq->idx));
+	vcmdq_dbg("deinited\n");
+}
+
+static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
+{
+	struct tegra241_cmdqv *cmdqv = vcmdq->cmdqv;
+	struct tegra241_vintf *vintf = vcmdq->vintf;
+	u32 regval;
+	int ret;
+
+	/* Configure and enable the vcmdq */
+	tegra241_vcmdq_hw_deinit(vcmdq);
+
+	regval  = FIELD_PREP(CMDQV_CMDQ_ALLOC_VINTF, vintf->idx);
+	regval |= FIELD_PREP(CMDQV_CMDQ_ALLOC_LVCMDQ, vcmdq->lidx);
+	regval |= CMDQV_CMDQ_ALLOCATED;
+	cmdqv_writel_relaxed(regval, CMDQ_ALLOC(vcmdq->idx));
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
+	vcmdq->page0 = cmdqv->base + TEGRA241_VCMDQ_PAGE0(qidx);
+	vcmdq->page1 = cmdqv->base + TEGRA241_VCMDQ_PAGE1(qidx);
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
+	u32 regval;
+	int lidx;
+	int ret;
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
+	regval = FIELD_PREP(VINTF_HYP_OWN, 1);
+	vintf_writel(regval, CONFIG);
+
+	ret = vintf_write_config(regval | VINTF_EN);
+	if (ret)
+		return ret;
+
+	vintf->enabled = !!(VINTF_ENABLED & vintf_readl(STATUS));
+	atomic_set(&vintf->error,
+		   !!FIELD_GET(VINTF_STATUS, vintf_readl(STATUS)));
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


