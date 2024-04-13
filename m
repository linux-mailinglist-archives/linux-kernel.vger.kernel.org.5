Return-Path: <linux-kernel+bounces-143569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5D88A3AE8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE9CD1C22E26
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E884E55C2E;
	Sat, 13 Apr 2024 03:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aJ2oowit"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E0253803;
	Sat, 13 Apr 2024 03:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712980093; cv=fail; b=imF9ax6YtydippXa6pEevTrS5MejpSaj8JR2zVpeTBUHX33B6SJaYtYrkKXp148ONQfc6TMlWziIH71hJLFspeQrN8n0+msQNr8nMNCYlguIAS/iYK7ZOtb1P5aXtIWodvERS7NkG32qIzCL+n25pnzO9312U5bNw6OSAX52njg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712980093; c=relaxed/simple;
	bh=jR76Q7MargMWlzVZY1P4VNuWu0Upgjs4BMiythj1uWY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=txDfPL/AH7wGX9plYNgv5WxrZRzBF8aOCoV+PGEWFVJWxBdixaBcEbGbN9TYXLWnynin4wsQKtIrYxfWZPSXDpd7moAJsPdnl0GJw8Rs6o1Umf7a/p66v7QKUwiGeOyh62MAnx8TKuRGYE23gOYsD49X/VgO4vN3CdX4OY0wqeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aJ2oowit; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGNn+o6ESik6/UakAjnbuwLjr5TFS6oG275VCoYyxwS99tXutU+9N69WzbTyQuvnOY47c04k10Lngwq31aqDIT4fo4FsVyCsuR9ZeamLMgX/VRsDiT9LuwCCCiz7DjK5j4BuNO0LmtgVqhpMEWPu0OEYy/BphJcTf6viyWjcoTozaTy0RgTun/8CowYew9aR29teEISlKW2/ef+spjmkIY8Rk9e623UJ23a3fLGQRfuqsXaGQ5MK404b4EWjvGdV4mOq0jqCs3JJuOyWIBAqtLq6wPr+pnCX9RMmfDJg6n7VnK9NoQ5G0EJyxONfkPlU9XQeNeyOFqYLyyFgN8G4dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLgqY2lecJlGYZ1nv7u+bIUJ625VoiO0aNpIHusOcAs=;
 b=McZHC5kcRJi5WuEUhP/O6G052CPqv6SCj2hq7n4DWf/fAsCaMSY1Ymros/EbOsqTOyqxWpEGAajfDiWEliKRDOgG3rKWOGyJiHvE2NDwb2/a54jf9sNrMWa6Bi71veH9WRcVvg57EAH479ZwDKOya8rZ0+PMwv+/Etcu/EO6l43VqPz/XnNjx63tgqAdcn5i5aD84v4CMVC0VWCSxRdKDY6R3WlqvLQNk6WD2uTsHEGKljgUlAoi6rQatF4hM8RDuiVCZzclchW17cSJ6OiRX8fYg+8cXweds3+a8qirQUZkhRSOX3IvjqtegVWDGMRoh2Qbcmb4FEU86tZpZF4KEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLgqY2lecJlGYZ1nv7u+bIUJ625VoiO0aNpIHusOcAs=;
 b=aJ2oowitrXiC1ykmvI5OZO1pkydEwBfDuJeXAFC9jl6WSSkijzWeiN15lOEf3fiyoQIrs5W5yOWpuQZdDjcPa96haPi/NsTWzyQVaEWPkntWP60ZiCXTVz7WTvQWkzXqbwxlQ3mrkhKSQekx5V8rlOM2+Sf0LCEV42JQUA7LJXGc3JUBv8mQCOZ6Q3z1w2CVSxf9ECcUKlqJsarzpSVQyktL5uxiVTzJIovXpgaWcKlgXsLsz+JhsMy8wIIgonj8Ke83D2636UbF+2AmQ/m/H9Bs6Jw4YZ5w1l2RJSk74Ek4kPIOMvi1M2ZoLn1Ib6Wkdxo7kpdM2P4PH4GGife/yQ==
Received: from BL1PR13CA0069.namprd13.prod.outlook.com (2603:10b6:208:2b8::14)
 by SN7PR12MB7372.namprd12.prod.outlook.com (2603:10b6:806:29b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 13 Apr
 2024 03:48:08 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:208:2b8:cafe::54) by BL1PR13CA0069.outlook.office365.com
 (2603:10b6:208:2b8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.14 via Frontend
 Transport; Sat, 13 Apr 2024 03:48:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.0 via Frontend Transport; Sat, 13 Apr 2024 03:48:08 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 20:47:54 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 12 Apr 2024 20:47:54 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 12 Apr 2024 20:47:53 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <suravee.suthikulpanit@amd.com>
CC: <joro@8bytes.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, <yi.l.liu@intel.com>, <eric.auger@redhat.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Dhaval.Giani@amd.com>, <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH RFCv1 14/14] iommu/tegra241-cmdqv: Add user-space use support
Date: Fri, 12 Apr 2024 20:47:11 -0700
Message-ID: <f00da8df12a154204e53b343b2439bf31517241f.1712978213.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1712978212.git.nicolinc@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|SN7PR12MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 3845d618-3100-4a75-b154-08dc5b6c886d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gad7sxdQHE5R9Gg75gAfGlBM46jOTlhF6wYuKwgucnAdM3l+UyUiCDh62mn58HVpd1FVyL/67Ju3qWAHLfN/FgmwnkkB2fAYeris3+crO8ddiu/PRpAQ0F016Pg2MlkxBJ7yGLNbZ11RJK43VWCeOycZ1DRQr2K4cC2HcJWWv7NBeCj/HqLHh5QXWEO8MoKRi+2eIZx5M8OJfHrEchJuSLqDGHKlGYw335IahRZk+DEA8uLBev6dbvW3tQqrvLRu3KE7M9r33J9VuuSjI2C7Q0KcY7bnEcPlCwU37sq+ek3IQn+Me4g+iOo+khDEG7Zjz84JzcvVz50jgVrwIzWv1fG2muDG2MZM8/CFlZ3ZvsaWXFo59yasjM63Ov1s3FhkOPGQNT7TxUk8ygwGIx85LeKURzOfATOcQzNJ6J6qd8dAfyxOX9+sUdEzNwDSZdO6+6x4d5DgfgfFOscAFjgInkFkI4e/uGfdDQOGpnuDQ5BFhpWZwa3vMBhRtVJbTxwJa0raHjl8hafshL+CUuiYg9Qk/PmZlZ3yrJxEJ8mxhb+hVumCXOi6xHKv1MMfZE8wJuLfBQRZ5xVl6anEfqeOdQLKshz06qdub3wEkfA3rBsmym+ynDpHZq7mzpNvUEx6/fEph8xy4kVTRWRSlhpMgBDLMnA8MWFOvMCwylMtsRivDpxfEt9S1gpj8GN+LPCg2c+5jhIZurgyFuK9a5GcQ1XBrwSBKa13qtRoCwNO6WlPtIZQc/6FogUAXZL0LV2O
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(7416005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 03:48:08.1378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3845d618-3100-4a75-b154-08dc5b6c886d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7372

Add the support via VIOMMU infrastructure for virtualization use case.

This basically allows VMM to allocate VINTFs (as a viommu object) and
assign VCMDQs to it. A VINTF's MMIO page0 can be mmap'd to user space
for VM to access directly without VMEXIT and corresponding hypercall.

As an initial version, the number of VCMDQs per VINTF is fixed to two.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  19 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  19 ++
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 284 +++++++++++++++++-
 3 files changed, 317 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9af6659ea488..367df65d1e2a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -17,6 +17,7 @@
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/io-pgtable.h>
+#include <linux/iommufd.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/msi.h>
@@ -3077,6 +3078,23 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	arm_smmu_sva_remove_dev_pasid(domain, dev, pasid);
 }
 
+static struct iommufd_viommu *arm_smmu_viommu_alloc(struct device *dev,
+						    unsigned int viommu_type,
+						    struct iommu_domain *domain)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain_devices(domain);
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+
+	if (!master || !master->smmu)
+		return ERR_PTR(-ENODEV);
+
+	if (master->smmu->tegra241_cmdqv &&
+	    viommu_type == IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV)
+		return tegra241_cmdqv_viommu_alloc(
+			master->smmu->tegra241_cmdqv, smmu_domain);
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static struct iommu_ops arm_smmu_ops = {
 	.identity_domain	= &arm_smmu_identity_domain,
 	.blocked_domain		= &arm_smmu_blocked_domain,
@@ -3091,6 +3109,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.remove_dev_pasid	= arm_smmu_remove_dev_pasid,
 	.dev_enable_feat	= arm_smmu_dev_enable_feature,
 	.dev_disable_feat	= arm_smmu_dev_disable_feature,
+	.viommu_alloc		= arm_smmu_viommu_alloc,
 	.page_response		= arm_smmu_page_response,
 	.def_domain_type	= arm_smmu_def_domain_type,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index fdc3d570cf43..8ee3f10086b9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -701,6 +701,7 @@ struct arm_smmu_device {
 
 struct arm_smmu_stream {
 	u32				id;
+	u32				cmdqv_sid_slot;
 	struct arm_smmu_master		*master;
 	struct rb_node			node;
 };
@@ -776,6 +777,14 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 			    unsigned long prod_off, unsigned long cons_off,
 			    size_t dwords, const char *name);
 
+static inline phys_addr_t
+arm_smmu_domain_ipa_to_pa(struct arm_smmu_domain *smmu_domain, u64 ipa)
+{
+	if (WARN_ON_ONCE(smmu_domain->stage != ARM_SMMU_DOMAIN_S2))
+		return 0;
+	return iommu_iova_to_phys(&smmu_domain->domain, ipa);
+}
+
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
 bool arm_smmu_master_sva_supported(struct arm_smmu_master *master);
@@ -838,6 +847,9 @@ tegra241_cmdqv_acpi_probe(struct arm_smmu_device *smmu, int id);
 int tegra241_cmdqv_device_reset(struct arm_smmu_device *smmu);
 struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
 					      u64 *cmds, int n);
+struct iommufd_viommu *
+tegra241_cmdqv_viommu_alloc(struct tegra241_cmdqv *cmdqv,
+			    struct arm_smmu_domain *smmu_domain);
 #else /* CONFIG_TEGRA241_CMDQV */
 static inline struct tegra241_cmdqv *
 tegra241_cmdqv_acpi_probe(struct arm_smmu_device *smmu, int id)
@@ -855,6 +867,13 @@ tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu, u64 *cmds, int n)
 {
 	return NULL;
 }
+
+static inline struct iommufd_viommu *
+tegra241_cmdqv_viommu_alloc(struct tegra241_cmdqv *cmdqv,
+			    struct arm_smmu_domain *smmu_domain);
+{
+	return -ENODEV;
+}
 #endif /* CONFIG_TEGRA241_CMDQV */
 
 #endif /* _ARM_SMMU_V3_H */
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 7aeaf810980c..18e250ec60dc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -8,7 +8,12 @@
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/iommu.h>
+#include <linux/iommufd.h>
 #include <linux/iopoll.h>
+#include <linux/kvm_host.h>
+#include <linux/platform_device.h>
+#include <linux/vfio.h>
+#include <uapi/linux/iommufd.h>
 
 #include <acpi/acpixf.h>
 
@@ -28,8 +33,10 @@
 #define  CMDQV_EN			BIT(0)
 
 #define TEGRA241_CMDQV_PARAM		0x0004
+#define  CMDQV_NUM_SID_PER_VM_LOG2	GENMASK(15, 12)
 #define  CMDQV_NUM_VINTF_LOG2		GENMASK(11, 8)
 #define  CMDQV_NUM_VCMDQ_LOG2		GENMASK(7, 4)
+#define  CMDQV_VER			GENMASK(3, 0)
 
 #define TEGRA241_CMDQV_STATUS		0x0008
 #define  CMDQV_ENABLED			BIT(0)
@@ -47,6 +54,14 @@
 /* VINTF config regs */
 #define TEGRA241_VINTF(v)		(0x1000 + 0x100*(v))
 
+#define TEGRA241_VINTFi_CONFIG(i)	(TEGRA241_VINTF(i) + TEGRA241_VINTF_CONFIG)
+#define TEGRA241_VINTFi_STATUS(i)	(TEGRA241_VINTF(i) + TEGRA241_VINTF_STATUS)
+#define TEGRA241_VINTFi_SID_MATCH(i, s)	(TEGRA241_VINTF(i) + TEGRA241_VINTF_SID_MATCH(s))
+#define TEGRA241_VINTFi_SID_REPLACE(i, s) \
+					(TEGRA241_VINTF(i) + TEGRA241_VINTF_SID_REPLACE(s))
+#define TEGRA241_VINTFi_CMDQ_ERR_MAP(i, m) \
+					(TEGRA241_VINTF(i) + TEGRA241_VINTF_CMDQ_ERR_MAP(m))
+
 #define TEGRA241_VINTF_CONFIG		0x0000
 #define  VINTF_HYP_OWN			BIT(17)
 #define  VINTF_VMID			GENMASK(16, 1)
@@ -55,6 +70,10 @@
 #define TEGRA241_VINTF_STATUS		0x0004
 #define  VINTF_STATUS			GENMASK(3, 1)
 #define  VINTF_ENABLED			BIT(0)
+#define  VINTF_VI_NUM_LVCMDQ		GENMASK(23, 16)
+
+#define TEGRA241_VINTF_SID_MATCH(s)	(0x0040 + 0x4*(s))
+#define TEGRA241_VINTF_SID_REPLACE(s)	(0x0080 + 0x4*(s))
 
 #define TEGRA241_VINTF_CMDQ_ERR_MAP(m)	(0x00C0 + 0x4*(m))
 
@@ -236,6 +255,7 @@ MODULE_PARM_DESC(bypass_vcmdq,
 
 /**
  * struct tegra241_vcmdq - Virtual Command Queue
+ * @core: Embedded iommufd_vqueue structure
  * @idx: Global index in the CMDQV HW
  * @lidx: Local index in the VINTF
  * @cmdqv: CMDQV HW pointer
@@ -246,6 +266,8 @@ MODULE_PARM_DESC(bypass_vcmdq,
  * @page1: MMIO Page1 base address
  */
 struct tegra241_vcmdq {
+	struct iommufd_vqueue core;
+
 	u16 idx;
 	u16 lidx;
 
@@ -257,19 +279,27 @@ struct tegra241_vcmdq {
 	void __iomem *page0;
 	void __iomem *page1;
 };
+#define vqueue_to_vcmdq(v) container_of(v, struct tegra241_vcmdq, core)
 
 /**
  * struct tegra241_vintf - Virtual Interface
+ * @core: Embedded iommufd_viommu structure
  * @idx: Global index in the CMDQV HW
+ * @vmid: VMID for configuration
  * @enabled: Enabled or not
  * @hyp_own: Owned by hypervisor (in-kernel)
  * @error: Status error or not
  * @cmdqv: CMDQV HW pointer
  * @vcmdqs: List of VCMDQ pointers
  * @base: MMIO base address
+ * @s2_domain: Stage-2 SMMU domain
+ * @sid_slots: Stream ID Slot allocator
  */
 struct tegra241_vintf {
+	struct iommufd_viommu core;
+
 	u16 idx;
+	u16 vmid;
 
 	bool enabled;
 	bool hyp_own;
@@ -279,13 +309,19 @@ struct tegra241_vintf {
 	struct tegra241_vcmdq **vcmdqs;
 
 	void __iomem *base;
+	struct arm_smmu_domain *s2_domain;
+
+#define TEGRA241_VINTF_MAX_SID_SLOT 15
+	struct ida sid_slots;
 };
+#define viommu_to_vintf(v) container_of(v, struct tegra241_vintf, core)
 
 /**
  * struct tegra241_cmdqv - CMDQ-V for SMMUv3
  * @smmu: SMMUv3 pointer
  * @dev: Device pointer
  * @base: MMIO base address
+ * @base_phys: Page frame number of @base, for mmap
  * @irq: IRQ number
  * @num_vintfs: Total number of VINTFs
  * @num_vcmdqs: Total number of VCMDQs
@@ -299,6 +335,7 @@ struct tegra241_cmdqv {
 
 	struct device *dev;
 	void __iomem *base;
+	unsigned long base_pfn;
 	int irq;
 
 	/* CMDQV Hardware Params */
@@ -446,15 +483,11 @@ static void tegra241_vcmdq_hw_deinit(struct tegra241_vcmdq *vcmdq)
 	vcmdq_dbg("deinited\n");
 }
 
-static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
+static void _tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
 {
 	struct tegra241_cmdqv *cmdqv = vcmdq->cmdqv;
 	struct tegra241_vintf *vintf = vcmdq->vintf;
 	u32 regval;
-	int ret;
-
-	/* Configure and enable the vcmdq */
-	tegra241_vcmdq_hw_deinit(vcmdq);
 
 	regval  = FIELD_PREP(CMDQV_CMDQ_ALLOC_VINTF, vintf->idx);
 	regval |= FIELD_PREP(CMDQV_CMDQ_ALLOC_LVCMDQ, vcmdq->lidx);
@@ -462,7 +495,15 @@ static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
 	cmdqv_writel_relaxed(regval, CMDQ_ALLOC(vcmdq->idx));
 
 	vcmdq_page1_writeq_relaxed(vcmdq->cmdq.q.q_base, BASE);
+}
+
+static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
+{
+	int ret;
 
+	/* Configure and enable the vcmdq */
+	tegra241_vcmdq_hw_deinit(vcmdq);
+	_tegra241_vcmdq_hw_init(vcmdq);
 	ret = vcmdq_write_config(VCMDQ_EN);
 	if (ret) {
 		vcmdq_err("GERRORN=0x%X\n", vcmdq_page0_readl_relaxed(GERRORN));
@@ -723,6 +764,8 @@ tegra241_cmdqv_find_resource(struct arm_smmu_device *smmu, int id)
 
 	acpi_dev_free_resource_list(&resource_list);
 
+	cmdqv->base_pfn = rentry->res->start >> PAGE_SHIFT;
+
 	INIT_LIST_HEAD(&resource_list);
 
 	ret = acpi_dev_get_resources(adev, &resource_list,
@@ -843,3 +886,234 @@ tegra241_cmdqv_acpi_probe(struct arm_smmu_device *smmu, int id)
 
 	return cmdqv;
 }
+
+static int tegra241_vcmdq_hw_init_user(struct tegra241_vcmdq *vcmdq)
+{
+	/* Configure the vcmdq only; User space does the enabling */
+	_tegra241_vcmdq_hw_init(vcmdq);
+
+	vcmdq_dbg("inited at host PA 0x%llx size 0x%lx\n",
+		  vcmdq->cmdq.q.q_base & VCMDQ_ADDR,
+		  1UL << (vcmdq->cmdq.q.q_base & VCMDQ_LOG2SIZE));
+	return 0;
+}
+
+static struct iommufd_vqueue *
+tegra241_cmdqv_vqueue_alloc(struct iommufd_viommu *viommu,
+			    const struct iommu_user_data *user_data)
+{
+	struct tegra241_vintf *vintf = viommu_to_vintf(viommu);
+	struct tegra241_cmdqv *cmdqv = vintf->cmdqv;
+	struct iommu_vqueue_tegra241_cmdqv arg;
+	struct tegra241_vcmdq *vcmdq;
+	phys_addr_t q_base;
+	int ret;
+
+	ret = iommu_copy_struct_from_user(&arg, user_data,
+					  IOMMU_VQUEUE_DATA_TEGRA241_CMDQV,
+					  vcmdq_base);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (!arg.vcmdq_base || arg.vcmdq_base & ~VCMDQ_ADDR)
+		return ERR_PTR(-EINVAL);
+	if (!arg.vcmdq_log2size || arg.vcmdq_log2size > VCMDQ_LOG2SIZE)
+		return ERR_PTR(-EINVAL);
+	if (arg.vcmdq_id >= cmdqv->num_vcmdqs_per_vintf)
+		return ERR_PTR(-EINVAL);
+	q_base = arm_smmu_domain_ipa_to_pa(vintf->s2_domain, arg.vcmdq_base);
+	if (!q_base)
+		return ERR_PTR(-EINVAL);
+
+	if (vintf->vcmdqs[arg.vcmdq_id]) {
+		vcmdq = vintf->vcmdqs[arg.vcmdq_id];
+
+		/* deinit the previous setting as a reset, before re-init */
+		tegra241_vcmdq_hw_deinit(vcmdq);
+
+		vcmdq->cmdq.q.q_base  = q_base & VCMDQ_ADDR;
+		vcmdq->cmdq.q.q_base |=	arg.vcmdq_log2size;
+		tegra241_vcmdq_hw_init_user(vcmdq);
+
+		return &vcmdq->core;
+	}
+
+	vcmdq = iommufd_vqueue_alloc(tegra241_vcmdq, core);
+	if (!vcmdq)
+		return ERR_PTR(-ENOMEM);
+
+	ret = tegra241_vintf_lvcmdq_init(vintf, arg.vcmdq_id, vcmdq);
+	if (ret)
+		goto free_vcmdq;
+
+	vcmdq->cmdq.q.q_base  = q_base & VCMDQ_ADDR;
+	vcmdq->cmdq.q.q_base |=	arg.vcmdq_log2size;
+
+	ret = tegra241_vcmdq_hw_init_user(vcmdq);
+	if (ret)
+		goto deinit_lvcmdq;
+	vintf->vcmdqs[arg.vcmdq_id] = vcmdq;
+	vcmdq_dbg("allocated\n");
+
+	return &vcmdq->core;
+deinit_lvcmdq:
+	tegra241_vintf_lvcmdq_deinit(vcmdq);
+free_vcmdq:
+	kfree(vcmdq);
+	return ERR_PTR(ret);
+}
+
+static void tegra241_cmdqv_vqueue_free(struct iommufd_vqueue *vqueue)
+{
+	struct tegra241_vcmdq *vcmdq = vqueue_to_vcmdq(vqueue);
+
+	tegra241_vcmdq_hw_deinit(vcmdq);
+	tegra241_vintf_lvcmdq_deinit(vcmdq);
+	vcmdq->vintf->vcmdqs[vcmdq->lidx] = NULL;
+	vcmdq_dbg("deallocated\n");
+
+	/* IOMMUFD core frees the memory of vcmdq and vqueue */
+}
+
+static void tegra241_cmdqv_viommu_free(struct iommufd_viommu *viommu)
+{
+	struct tegra241_vintf *vintf = viommu_to_vintf(viommu);
+	struct tegra241_cmdqv *cmdqv = vintf->cmdqv;
+	int qidx;
+
+	/* Just in case, make sure all LVCMDQs are disabled */
+	for (qidx = 0; qidx < cmdqv->num_vcmdqs_per_vintf; qidx++)
+		if (vintf->vcmdqs[qidx])
+			tegra241_cmdqv_vqueue_free(&vintf->vcmdqs[qidx]->core);
+
+	vintf_write_config(0);
+
+	ida_destroy(&vintf->sid_slots);
+	kfree(vintf->vcmdqs);
+
+	ida_free(&cmdqv->vintf_ids, vintf->idx);
+	cmdqv->vintfs[vintf->idx] = NULL;
+	vintf_dbg("deallocated with vmid (%d)\n", vintf->vmid);
+
+	/* IOMMUFD core frees the memory of vintf and viommu */
+}
+
+static int tegra241_cmdqv_viommu_set_dev_id(struct iommufd_viommu *viommu,
+					    struct device *dev, u64 dev_id)
+{
+	struct tegra241_vintf *vintf =
+		container_of(viommu, struct tegra241_vintf, core);
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_stream *stream = &master->streams[0];
+	int slot;
+
+	WARN_ON_ONCE(master->num_streams != 1);
+
+	/* Find an empty slot of SID_MATCH and SID_REPLACE */
+	slot = ida_alloc_max(&vintf->sid_slots,
+			     TEGRA241_VINTF_MAX_SID_SLOT, GFP_KERNEL);
+	if (slot < 0)
+		return slot;
+
+	vintf_writel_relaxed(stream->id, SID_REPLACE(slot));
+	vintf_writel_relaxed(dev_id << 1 | 0x1, SID_MATCH(slot));
+	stream->cmdqv_sid_slot = slot;
+	vintf_dbg("allocated a slot (%d) for pSID=%x, vSID=%x\n",
+		  slot, stream->id, (u32)dev_id);
+
+	return 0;
+}
+
+static void tegra241_cmdqv_viommu_unset_dev_id(struct iommufd_viommu *viommu,
+					       struct device *dev)
+{
+	struct tegra241_vintf *vintf =
+		container_of(viommu, struct tegra241_vintf, core);
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_stream *stream = &master->streams[0];
+	int slot = stream->cmdqv_sid_slot;
+
+	vintf_writel_relaxed(0, SID_REPLACE(slot));
+	vintf_writel_relaxed(0, SID_MATCH(slot));
+	ida_free(&vintf->sid_slots, slot);
+	vintf_dbg("deallocated a slot (%d) for pSID=%x\n", slot, stream->id);
+}
+
+static unsigned long tegra241_cmdqv_get_mmap_pfn(struct iommufd_viommu *viommu,
+						 size_t pgsize)
+{
+	struct tegra241_vintf *vintf =
+		container_of(viommu, struct tegra241_vintf, core);
+	struct tegra241_cmdqv *cmdqv = vintf->cmdqv;
+
+	return cmdqv->base_pfn + TEGRA241_VINTFi_PAGE0(vintf->idx) / PAGE_SIZE;
+}
+
+static const struct iommufd_viommu_ops tegra241_cmdqv_viommu_ops = {
+	.free = tegra241_cmdqv_viommu_free,
+	.set_dev_id = tegra241_cmdqv_viommu_set_dev_id,
+	.unset_dev_id = tegra241_cmdqv_viommu_unset_dev_id,
+	.vqueue_alloc = tegra241_cmdqv_vqueue_alloc,
+	.vqueue_free = tegra241_cmdqv_vqueue_free,
+	.get_mmap_pfn = tegra241_cmdqv_get_mmap_pfn,
+};
+
+struct iommufd_viommu *
+tegra241_cmdqv_viommu_alloc(struct tegra241_cmdqv *cmdqv,
+			    struct arm_smmu_domain *smmu_domain)
+{
+	struct tegra241_vintf *vintf;
+	int idx, ret;
+	u32 regval;
+
+	if (!smmu_domain || smmu_domain->stage != ARM_SMMU_DOMAIN_S2)
+		return ERR_PTR(-EINVAL);
+
+	vintf = iommufd_viommu_alloc(tegra241_vintf, core);
+	if (!vintf)
+		return ERR_PTR(-ENOMEM);
+	vintf->core.ops = &tegra241_cmdqv_viommu_ops;
+
+	ret = ida_alloc_range(&cmdqv->vintf_ids, 1,
+			      cmdqv->num_vintfs - 1, GFP_KERNEL);
+	if (ret < 0) {
+		dev_err(cmdqv->dev, "no more available vintf\n");
+		goto out_free;
+	}
+	idx = ret;
+	cmdqv->vintfs[idx] = vintf;
+
+	vintf->idx = idx;
+	vintf->cmdqv = cmdqv;
+	vintf->vmid = smmu_domain->vmid;
+	vintf->s2_domain = smmu_domain;
+	vintf->base = cmdqv->base + TEGRA241_VINTF(idx);
+
+	ret = vintf_write_config(0);
+	if (ret)
+		goto out_ida_free;
+	regval = FIELD_PREP(VINTF_VMID, vintf->vmid) |
+		 FIELD_PREP(VINTF_EN, 1);
+	ret = vintf_write_config(regval);
+	if (ret)
+		goto out_ida_free;
+
+	vintf->vcmdqs = kcalloc(cmdqv->num_vcmdqs_per_vintf,
+				sizeof(*vintf->vcmdqs), GFP_KERNEL);
+	if (!vintf->vcmdqs) {
+		ret = -ENOMEM;
+		goto out_ida_free;
+	}
+
+	ida_init(&vintf->sid_slots);
+
+	vintf_dbg("allocated with vmid (%d)\n", vintf->vmid);
+
+	return &vintf->core;
+
+out_ida_free:
+	ida_free(&cmdqv->vintf_ids, vintf->idx);
+out_free:
+	kfree(vintf);
+	return ERR_PTR(ret);
+}
-- 
2.43.0


