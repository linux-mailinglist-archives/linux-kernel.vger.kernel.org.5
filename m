Return-Path: <linux-kernel+bounces-143550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B438A3AC0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A093B23C07
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE581B952;
	Sat, 13 Apr 2024 03:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KpGlSz3P"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96172110B;
	Sat, 13 Apr 2024 03:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712979861; cv=fail; b=LmuFhnPaWHc+QP1jT5iWkQ5Qr6rLN5hMMD+cQX26sVK/1DIS9kP8rPDKoj4bGHTq7vSJTppIsaDIPOhhjorzlTYGbmYaPVzG00C4YUANS28V9sDIMwAQ2pdGgHqxPzLU9Lf1ESXV0tJvy03jThxtadA6Kt7SVBGtNROfVOjVWzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712979861; c=relaxed/simple;
	bh=m+txnxz5A0qDMUAnv4GZi1bWFaMsh0WCqPQNKCEZhRU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R4PEeUAzsy1Ao3lVrvwM6Cd19MHsUasa7lfx62tA63KQVGSJi3OCgSFErqcDgwAOUkBAYjaGx3JeM4Rrmxif8KgU3tzw+5VTGGVLg3kz4UvS2Dvv5XSMonHysI9kpXLpiDNFHki6tyshPMKRxGgFDbZmrH0+maIoajaKfaX8t+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KpGlSz3P; arc=fail smtp.client-ip=40.107.100.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEcbeVnmonNj4knz9Ye/Z9UW3ONu7mOwr8P4OfUwyGWy2uLti1LTO2rYS3rwMpKWYYDXn6Dy6mdKljszUpxBllNEWZgg/tsLkjXT6pl3fJU5JNxVymKV8BllOfDEFDqewevxFmtg2eUPbvtmQHrC9GpRONlTezDGV5kM6Qvve9q3XJm+U6UWinxXCWV72hHIPluql7WlOVFVGmVqJyJHHHWGLAxFHFtnzr5TITpi8CHFU13C0f+CWhQ6hRD6fo0zxOwnzAc5YvPERHn4afJuWOEOpnhAJ+Y/KOST6JvYX9dtWYy+n3iMSKGPZUwwpgKm72NW14NkCBvOtPUS0coBDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhT0v6QQEeEEzP6KIW0yMX+TyZKjOKU1KtGkf2OEJv0=;
 b=CZzKJSTfdIrgwQxJA3gqmtqXnzU0V7dhxRzvYlIbB9GitShbRAjkhGIPAR0Ybj+YR/nEiGPQcwit3abI2q1H3NEahkBuNx2FFglN1KYjgi7AtkVFUE9Cr8GOuJKhoeQAohwJ2d2Cwq2PLjYNzfeD1A0vtI8V83JBXKqEcTdIPmyKsc9Pld9cHH72h5kLlApircGQahk0dhCjTkYJUgr+ijD0fs05o4wfns5G0ymiyrrUREg0/26MtekOJewL8WV+iBL9X06LQ6pgHnWwQaD79xeq+VYWMvtdFr8dNlzArm5PVzsTMwD9/98r9EhbaDVmlo+502EM8scpXWBI77TtAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhT0v6QQEeEEzP6KIW0yMX+TyZKjOKU1KtGkf2OEJv0=;
 b=KpGlSz3PBnv8XUolfpM+YokpNVeYDBizulGZVn3TGJRXCzDavcHnwtBj1thBqYVgP1uS24BxsJ8DzqKDodmOrlQ5gVcLViVqMlygQb/mhe89HnQi8e5wQslBq9mZvJ1kSSEQiBH6AQJSYhSmnIG7aUxkXQvA1JMQexYCX5CnF6xvTR9peiLuE1UZB32/1kLeNLrGTSNKzIm8I0fIvyCbeItMhuFnifKC20qzyZVS1AGWUGQq5RXes1HHoKtqH4eLdQwgCqz3++6PUdwX1zTvWTNzaj2jSq1aF1SE4i4vLHRrGZDuU0RxQ7XZpv4a4/Um+V5RWXG2u8T6F0CLRJlw2Q==
Received: from CH5PR02CA0018.namprd02.prod.outlook.com (2603:10b6:610:1ed::20)
 by BL3PR12MB6451.namprd12.prod.outlook.com (2603:10b6:208:3ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Sat, 13 Apr
 2024 03:44:16 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::9) by CH5PR02CA0018.outlook.office365.com
 (2603:10b6:610:1ed::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.29 via Frontend
 Transport; Sat, 13 Apr 2024 03:44:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Sat, 13 Apr 2024 03:44:16 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 20:44:07 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 12 Apr 2024 20:44:07 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 12 Apr 2024 20:44:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v5 6/6] iommu/tegra241-cmdqv: Limit CMDs for guest owned VINTF
Date: Fri, 12 Apr 2024 20:43:54 -0700
Message-ID: <ee70b82c8268e9a6746486ddcb3e8e7f32f0629f.1712977210.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|BL3PR12MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: c8ce5ffc-65c9-4033-e510-08dc5b6bfe0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oJQKpFfV2RYzTxzAmsulIzLXDM3BishBKTxEHil9DPnACdkaR8GmL0tlJSTZJ7awXXqzstl2OewAkaVdmoR4dcHh14wB6tg6iLms7AAyECaDv7ga7eIZQFm4KzIzoucPwAA3lSdDDW9QrivAhUUWdArFM+5hpuMCcu3TAgFfFTsmcepicUrut3D6Q/GZfQLgyn09TfswACISD10BRrwl7S9H2Q03rsXWiHvR9xvJhASboebfZ2boFew3jUkm74S/VaGoGowZR4oFtpxfbFpikobsebY3ycpGZfHkJt9x0PwpUv8TJEKfVF1I7ZAfG0A1Fk3s9URnOjz6UlLiHMWITWw4Z7sFS1shP1fnTi+kzU0FOGCEYU+SCcG7BkFALyIddfE8p/Cq9T3MHaPljUp9I0MCSwuRTa1MkQs9gx/m0LhukuArZjsXWIHQbqjmMH5BVT0DIyAkfsyeN9zWIUc2Syu+kXfDenoRsX+wnbnALJ0Tc8uWtlAewOdIZ2YVKv7cSb69ib/V106TTVw0y3tRwN3XGfIptpaw8nACu94dkcjWJDtzGpZAzNL4TMpPJNmx75OTwJd+KQDXKCm2JtzcjrK+PHjUdFgJThbF19ZLlabSGK9BjTa4KmMet40WRGR6mbFe+6OuAKZ0KAh+NIAIfDcNKLwAEQLkyXg7W5XV2So18nyNPEORsMNOl7oLLM5P15kOqrQ1NXbIWudLnbUKznb9cDDxgHPmNGJKlxCJP+6wUSUrfF6ycETTEFCJPiQW
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 03:44:16.0156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ce5ffc-65c9-4033-e510-08dc5b6bfe0d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6451

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
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 43 ++++++++++++++++++-
 3 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ba7a933c1efb..9af6659ea488 100644
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
index 5b8e463c28eb..fdc3d570cf43 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -836,7 +836,8 @@ static inline void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
 struct tegra241_cmdqv *
 tegra241_cmdqv_acpi_probe(struct arm_smmu_device *smmu, int id);
 int tegra241_cmdqv_device_reset(struct arm_smmu_device *smmu);
-struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu);
+struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
+					      u64 *cmds, int n);
 #else /* CONFIG_TEGRA241_CMDQV */
 static inline struct tegra241_cmdqv *
 tegra241_cmdqv_acpi_probe(struct arm_smmu_device *smmu, int id)
@@ -850,7 +851,7 @@ static inline int tegra241_cmdqv_device_reset(struct arm_smmu_device *smmu)
 }
 
 static inline struct arm_smmu_cmdq *
-tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
+tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu, u64 *cmds, int n)
 {
 	return NULL;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 15683123a4ce..7aeaf810980c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -262,6 +262,7 @@ struct tegra241_vcmdq {
  * struct tegra241_vintf - Virtual Interface
  * @idx: Global index in the CMDQV HW
  * @enabled: Enabled or not
+ * @hyp_own: Owned by hypervisor (in-kernel)
  * @error: Status error or not
  * @cmdqv: CMDQV HW pointer
  * @vcmdqs: List of VCMDQ pointers
@@ -271,6 +272,7 @@ struct tegra241_vintf {
 	u16 idx;
 
 	bool enabled;
+	bool hyp_own;
 	atomic_t error;	/* Race between interrupts and get_cmdq() */
 
 	struct tegra241_cmdqv *cmdqv;
@@ -369,7 +371,32 @@ static irqreturn_t tegra241_cmdqv_isr(int irq, void *devid)
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
@@ -386,6 +413,10 @@ struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
 	if (atomic_read(&vintf->error))
 		return &smmu->cmdq;
 
+	/* Unsupported CMDs go for smmu->cmdq pathway */
+	if (!tegra241_vintf_support_cmds(vintf, cmds, n))
+		return &smmu->cmdq;
+
 	/*
 	 * Select a vcmdq to use. Here we use a temporal solution to
 	 * balance out traffic on cmdq issuing: each cmdq has its own
@@ -575,6 +606,11 @@ int tegra241_cmdqv_device_reset(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
+	/*
+	 * Note that HYP_OWN bit is wired to zero when running in guest kernel
+	 * regardless of enabling it here, as !HYP_OWN cmdqs have a restricted
+	 * set of supported commands, by following the HW design.
+	 */
 	regval = FIELD_PREP(VINTF_HYP_OWN, 1);
 	vintf_writel(regval, CONFIG);
 
@@ -582,6 +618,11 @@ int tegra241_cmdqv_device_reset(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
+	/*
+	 * As being mentioned above, HYP_OWN bit is wired to zero for a guest
+	 * kernel, so read it back from HW to ensure that reflects in hyp_own
+	 */
+	vintf->hyp_own = !!(VINTF_HYP_OWN & vintf_readl(CONFIG));
 	vintf->enabled = !!(VINTF_ENABLED & vintf_readl(STATUS));
 	atomic_set(&vintf->error,
 		   !!FIELD_GET(VINTF_STATUS, vintf_readl(STATUS)));
-- 
2.43.0


