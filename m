Return-Path: <linux-kernel+bounces-163332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDE68B698C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC261C21B54
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FA01802E;
	Tue, 30 Apr 2024 04:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="byI4QFNi"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4102017579;
	Tue, 30 Apr 2024 04:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714452259; cv=fail; b=m/wp5uNO5wjEFb7lxPh1XGhBJM167pjcEdEfPzok2sHrFScDIo1iBcyII1dWEvH3PAcrNvD++3Z7Q6wU4akb5F9DMO4+tmWiNoJSSd1qoj0lS64khZPH43XifwBUOUn1DuSR9mZGlH/PRqY1+s6i3cPa9qHxax9g71JvdFtvVcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714452259; c=relaxed/simple;
	bh=7GRMnSoAVa9s3ommmdVF4t+GALXXFBZ2E7Ck7pimUwo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tGBnLNgFmXTdqSJ5vmTAeZAoK2V8yFFZdGSyoA4+PpxHkY1pS/9u9VBTOVUY48fmP3d100h1qaRaclF9VRbacwg0V3jdtUP55w32m0oku0+L7KRMW8Y8emRyKzBTqUGzVLyyWumN5EAziMbqhfmJyQj6THmDzXN2Z2Zczhw7nik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=byI4QFNi; arc=fail smtp.client-ip=40.107.100.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WX41tnklJ/oU7KAmiNEe97LhatZmKokZAHxlWx7p31CceoyKB4ClvDaQD+RVQzPvYqsz/dW2yEh8FdI8Yxp3XFT5f+EH83GuaCWJfrW+PGU6n1sEXXpPzloFcRZ4RdVGRhIq0Q4N9ar/rbGL1Rt9dJySU7qHVyWMOBwMUVTkVQ5ynHXSJvJTKUFnCIfTxjDfELWE0IXFP8wN/U4Sk7Fe07leXKWMH5i1ErW4RttFetR9eL0l6EOeNo9+RdVKF4324yCsewpAmTKm/yrM/cdKEpjcH4q/EkgDk5TYh8Oo8t4hIf4mSJD+XxKr39DxBMlyX/ef6kyoRyqi3vgTTf9SQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FRamK4114oAevkftuz6mFt73hVOGyAH5y2G717pUck=;
 b=Fuw6rbCx4Qb7Yujdi6W410PPXY1S9vxBZf4ng7D5T/jHDw53pasr2N6J3BBSnobRCpKYZhMKk3oLKNxkdaYrbyCxn3cd391Ty2MCLCyf5jske7E2JAvyV6Qu2qB/QV2513+Cwpqb7TwYbDVki86bEVAkK4HhE0I7Apiv6E0EfWdUoZU1/S6mnmPR8AjrN61s6IhTI7PAURFwfOs0IvLhDv6ojq6Z+Fgk/uABFdsCf+tvSrwzqP7KOFQvCjxfJY71/G61oFaK2kaR+7lA+je5mCm/SvsYUekwgw0+Wme/mzN+zCFvqHtYbwwbK05Pa7GJlTdkPsjmSveUFj7sPLSYTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FRamK4114oAevkftuz6mFt73hVOGyAH5y2G717pUck=;
 b=byI4QFNiFRthxfv74wdjKDFt/VZi9iV6OfMXQcxWOwLdr+giHZn3IyPA7rdZ8a/P52+x5HDzNkb8DKkIqmUaHo4dePN9b7lyx3xvAqFUOmurhIRKOkxxuvLQk+Mlyc8w0KZNWuB6yPOTzOqh3GUSR/Sn+ylEZjoGWFsl1w28OG/RSMKkOtzVF14hOO17hKmGWdlorrZZebuS2BX0A7FkOndm3HUKL0dVIcc56b4jrZk3qah9f7toOcr0zPf7rNzSQkwoYYiuU4sQCoitiLRunM/BdtA8wbmkTw+Hu5wv2EeHQrBkBMp7ZZ7o6mo55BVfM/+PDa4oHIEG7hQisTeVcg==
Received: from SN7PR18CA0012.namprd18.prod.outlook.com (2603:10b6:806:f3::35)
 by PH7PR12MB7114.namprd12.prod.outlook.com (2603:10b6:510:1ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 04:44:15 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::64) by SN7PR18CA0012.outlook.office365.com
 (2603:10b6:806:f3::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Tue, 30 Apr 2024 04:44:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 04:44:14 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Apr
 2024 21:44:09 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 29 Apr 2024 21:44:08 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 29 Apr 2024 21:44:07 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v6 3/6] iommu/arm-smmu-v3: Make arm_smmu_cmdq_init reusable
Date: Mon, 29 Apr 2024 21:43:46 -0700
Message-ID: <47a2ec844ec42694872d3c3b1a09f1b870712f78.1714451595.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|PH7PR12MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cdf2d1d-12b4-440c-c178-08dc68d03004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|82310400014|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GJ10XDkzhv9XFd54NBCw8CCJ2/hLTcxZ640XjbpOJRM20G8T3WV+yjIUZCUm?=
 =?us-ascii?Q?QI+odSkE5nbhVUizw2uspr/0ZxW/YUwgHeHG4si1fU5gvsCPnnWx0G/6pVJR?=
 =?us-ascii?Q?qBjDSCC+RjZcPvY19wM9UmIrjPYFrudi3wLTwIm/ck5jS9dd8pzIfjBi/Rj0?=
 =?us-ascii?Q?wZz7QRSuL/kBUcUlBpnwOkmrdzNdHy+8EUsQEWuPkeyfLGic/ThrtDXv2LoQ?=
 =?us-ascii?Q?sv6NYkBiVcX9SZS9dZSGaDvrzjg5SCNdert5tBM67mO+ROlRJ1Aafd5GqMK2?=
 =?us-ascii?Q?9snQqrf/7ZYsdE6PtpTjY3y2gWd5LC7GrKvLvyMOGWAFfhe/Cedxa35qH3tE?=
 =?us-ascii?Q?pmvwTSwEs32VScMTS5MC2H87VseKXEcMOuhcROsxGEtGZ/Pt9CV0USvMqG1Y?=
 =?us-ascii?Q?m/iKo/8xOS0ZSpxxt9b41g0LcGSS31gGWJSrmzNEc7aYDJplrQOqxPlPYGRF?=
 =?us-ascii?Q?Ty6D0Bg3lDsiqAVujjhdzWOsSg3ZH3YXXHOejEc2Qwr4+uYKoA/w+WBuM3VV?=
 =?us-ascii?Q?yDfvJQdefLLNX78XNZ78g5nQpAl0xHFZ9ctoFE7eSG9QjYRLigVSl+NhCVDq?=
 =?us-ascii?Q?nR5uGNNCKXRdXuqudw5JqjXJTFAIrLW/GgLhVGpPlb55FHHADzHz2Vwx9asF?=
 =?us-ascii?Q?B92F1ZtJfT2dDS7V/YrARpkhR1AZ829ZVt4vKhCQFB+EAZ0FKWulJu9ZYu7y?=
 =?us-ascii?Q?Jj9D/y0+G6RLaddLzI8JFikicEvseMhfxi9KfLENlCd5Uz5ZqQA6OZqQW2QF?=
 =?us-ascii?Q?w2dvnOfGd0KFTvkeGesQHUiVFopfrRACv1p3X9lupEDeHp1dVE4WHqvvZjy3?=
 =?us-ascii?Q?YaUVCaOpr8J5RJdkOOIae01R/4kIAQpfxNeuFE22INRmiUPy/cDUJfin3HCT?=
 =?us-ascii?Q?Al/aQ8L3lsBdpK+6+bsCsYBWXuLawKGpIx+xLsn0XXmgMeJ42mVmO3FuVldy?=
 =?us-ascii?Q?B70x2OZAvbdklv32u+jRqed+/e99qBPVZZSPaLsiv5koC68dsV4J0Ce9W+D4?=
 =?us-ascii?Q?8oqVEXmf2/tyFXTCOfZGF0ZRCZrmvVGdXRB8kt2blcYO60XfFXy9cWIm/QQZ?=
 =?us-ascii?Q?vr0RES6cgbyEgG1wUiMdlaFGmINVazb1/XBmhP3k38RfgLgVvjyk7tyepB0R?=
 =?us-ascii?Q?pGbqV7MSjNsSGm9RYxXodcNMIKbhS2M8qh9dRunumzIn5Imc28gdv/tB7ImK?=
 =?us-ascii?Q?ZbX3uTt4Kl/X4ld1mQbkHzrJdgKlyT75Nm7BSPsNZwqfzg+YH3ax1hbqI6H2?=
 =?us-ascii?Q?ZB31l8gl6PH9Mak3jJJA4JnnfMCO8KQlDmrv9aLoTN/cUpQSCs9yIif8GRlI?=
 =?us-ascii?Q?xxERvAwfDkA5ZSxqS9amV6UWVHvx375EwFrsCKtmK97NeFp7ME1H7Oz+UuJ7?=
 =?us-ascii?Q?hoNjMjrMQZ7fZ53+y5tSDNoC+tcx?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 04:44:14.6620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cdf2d1d-12b4-440c-c178-08dc68d03004
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7114

The CMDQV extension in NVIDIA Tegra241 SoC resues the arm_smmu_cmdq
structure while the queue location isn't same as smmu->cmdq.

Add a cmdq argument to arm_smmu_cmdq_init() function and shares its
define in the header for CMDQV driver to use.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 6 +++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 3 +++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b3d03ca01adc..538850059bdd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3145,9 +3145,9 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 	return 0;
 }
 
-static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
+int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
+		       struct arm_smmu_cmdq *cmdq)
 {
-	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
 	unsigned int nents = 1 << cmdq->q.llq.max_n_shift;
 
 	atomic_set(&cmdq->owner_prod, 0);
@@ -3172,7 +3172,7 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
-	ret = arm_smmu_cmdq_init(smmu);
+	ret = arm_smmu_cmdq_init(smmu, &smmu->cmdq);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index bbee08e82943..ab2824e46ac5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -760,6 +760,9 @@ bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd);
 int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 			    unsigned long iova, size_t size);
 
+int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
+		       struct arm_smmu_cmdq *cmdq);
+
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
 bool arm_smmu_master_sva_supported(struct arm_smmu_master *master);
-- 
2.43.0


