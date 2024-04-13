Return-Path: <linux-kernel+bounces-143548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A04498A3ABA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C41B1F24AB6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1411CABA;
	Sat, 13 Apr 2024 03:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jwlGn8e5"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3DA1BDC3;
	Sat, 13 Apr 2024 03:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712979854; cv=fail; b=CeV5FhYQDuWnBeA6cp0yYgSFbvG7I9geFVP84WNKMKvsu2lt3Sp/wmYEbQ+spH4jFk+Owi6Pq7C5zUde8ibiOpPfGkrKUqCbKhvZcLsWcJpjg8AWeeIwSsXH7dnrjAdcb+HFqxrs82YHU8TZXhfcl+lnzsrpoRRTNRPtMZPEb7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712979854; c=relaxed/simple;
	bh=2WSCI7wYPP0ARa6qO0FGtDK9EqRsmZTEekUlViNBMP8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P2Mnp84dLi4DnQctLdvWKyO5wIY6rvLlk5p4fuWLhdmAAw8PgK9mX5coGs5RPHJ5EYsNjKoCyu1dKnFn5XOtPjEyJLZ0GNM2WHkM4wev9ITt7VjAYpW5YQD7JOt2OFVgBUrTff9zSS+SMtYQ/ZMXA13WvZngOWtcDMhouujHfA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jwlGn8e5; arc=fail smtp.client-ip=40.107.94.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpuAmYi9YUfEyv+BRW0x/HO8EyQYJLy0MrHroXYvh7okExsk9L8nlxzNmUPNeRSl8dNBYNq5ls+r0E78M0pLbJE6hhnSgkgPRt05sUdO7N+b4VAsOEdGB9c5l6hl30pViTbeqGDgL1UXQLBuqH0xAZ1yGz7/aigo/D13AUVazz5cYet9AIEt8CLlpoVMq6oltczDh5ZA6r/q4CGkIWg+c29kiDZMAuOw8WjI9utS/2KA0RValLc/AsZjNUwQPg7oiXNzNoy8dMShhZtTcchTO+Pjbx2TPpcM9EoIjThhB5jYbPR8ZMBzt0g3tDJ67uT4XMisrB8IItPbkK95Ucaa8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wXl+2UiMhwCwUgGZMbh+lqVKV31o9U5hsFYlAofckg=;
 b=QwnlsfbYcbGkxEwUB7ChzAlyak/WOnjEUDF32M2R8/l6l9d0onWHX5jlnVQo5IHdSHqiv/trlFo5gfnrelkoE3Qurl9wxJIDh01B3uDA+QieUzrSMCHhCrztF9OtMV8q5LQ+TxEgmGjoxsRn0wIQK2bYYaRqG6TfmQsyaLpQrVt6Pw8IUzWSJGtpvMjW/6P3YfYpIRSiz6ZHP8+YsD7NbMBizN0bVjptkygPmOIF8z/orTQ30A+IM5gCirLGm3nb22of1PRGMkplY/GhsS8mnc99NCOXNm6ipIU8tzWj8qVnFjc1K1D0jrdyxTPeByb4lr8MLtCXGar0LV5YjamYnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wXl+2UiMhwCwUgGZMbh+lqVKV31o9U5hsFYlAofckg=;
 b=jwlGn8e5A/Xig+VeiSKvB7Rmf7YMyr6CQ1GLkOzgFVvmm4y7IJk2u3bpf7ep5gVCGLxY9cH9uXB9jBCn4ZOVw9mGEsSMKk4EW0QVnd5tjbI5ZrFxf2zsYATsGQL8SXXNHWkHkbYIpfsepu/c8L4gsHlq02TtLi8+8WvY2p/aMMh4n54JeOwRJBNb4uZUgu2L7inLc+x+R8GvDI2trzvbpNaAU0Bdhyc8GfFp3nXAd+ga/Urf7iTT+qYUiwBghLmEasm5yWvAmWhDqY7XaE56jU/czro0ny0TP7iNTiKfKAJFG7RDXOVKX2ZyHNiGMipbkxJ5q5EDQCmU7CrNYA1xPw==
Received: from CH0P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::32)
 by CY8PR12MB7633.namprd12.prod.outlook.com (2603:10b6:930:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 13 Apr
 2024 03:44:10 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::b3) by CH0P220CA0016.outlook.office365.com
 (2603:10b6:610:ef::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.34 via Frontend
 Transport; Sat, 13 Apr 2024 03:44:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Sat, 13 Apr 2024 03:44:09 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 20:44:05 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 12 Apr 2024 20:44:04 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 12 Apr 2024 20:44:04 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v5 3/6] iommu/arm-smmu-v3: Make __arm_smmu_cmdq_skip_err reusable
Date: Fri, 12 Apr 2024 20:43:51 -0700
Message-ID: <7aaecf0eab666d3f074adc0186dd13e9fbf17061.1712977210.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|CY8PR12MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: a0058ad5-8153-415d-edec-08dc5b6bfa43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c7FnlR/J5xuCvFFt8PfbreoSMwKySPZbgNFDc+DGZoXP9Ds5V+8jJCz5aFTtJXJ8eauHNUVy2B4oT1OwgTcJnspjyx736Qbkp9/0cASufWw15x75uYMNED1mpRpCqlw94JTCoTS8u98BF83tIBTJBGVdgMuZKF4xveOUP40pKz/1lSA20Xa4SVafPrl6MldfI/EHTYbgK+MVHZVczGJbKLnGXmGzbGcLDNd5vRvXSuA41SNhFWOBtZxmtaIDqZ/HrlvQ9Fp8M+l3lhpL08tgMUdfWmikzLHyCWzMQZ5lneQqg5/DepVFW0V77jvNCxbpbEqgR2F33UFfmDAx9vQ4yz7qMDV7FK/hYj0JiH73r/FtSzmqDtxM3x/e3gJMRwCkeLi8XsFlHyJA9X77p+rDBfKsjtgQKnWuMQUPqTmiH47+JDPFvt4kgkC4CdsALa6e2onnohhCE2HOjf5oN3iMB3ULOrrECK9sG43ABhi/5wvOtO3VFAMJ8aWAbtWAS9OsdMytea9ik39gvUePEz1eB7LGD1VW/DsVC5NBmuBr97kBHPmVjl2JgTpCWBgeFi8m7hQQfLPfGlbqbyhv7W91oLbt/opkpEWHz4PCjt6LBde8tKdAzyHsmCEGTxuZTruic702gGDcQUT0dHpw5JuXs4xTESbA/g1TzYH0KLzkMLwu1j0CrvIScXMRDtuMpsAUiFjXRUzOw0+jOikUXcW+FYQTQI5V46GO3f5AcHFfmBC2JMhPKzrEHVruZ8u6EkpI
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 03:44:09.6589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0058ad5-8153-415d-edec-08dc5b6bfa43
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7633

Allow __arm_smmu_cmdq_skip_err function to be reused by NVIDIA Tegra241
CMDQV unit since it will use the same data structure for q.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 +++++++++-------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 18da1a317823..c5d43f2167be 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -379,8 +379,7 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
 	arm_smmu_cmdq_build_cmd(cmd, &ent);
 }
 
-static void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
-				     struct arm_smmu_queue *q)
+void __arm_smmu_cmdq_skip_err(struct device *dev, struct arm_smmu_queue *q)
 {
 	static const char * const cerror_str[] = {
 		[CMDQ_ERR_CERROR_NONE_IDX]	= "No error",
@@ -397,12 +396,12 @@ static void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
 		.opcode = CMDQ_OP_CMD_SYNC,
 	};
 
-	dev_err(smmu->dev, "CMDQ error (cons 0x%08x): %s\n", cons,
+	dev_err(dev, "CMDQ error (cons 0x%08x): %s\n", cons,
 		idx < ARRAY_SIZE(cerror_str) ?  cerror_str[idx] : "Unknown");
 
 	switch (idx) {
 	case CMDQ_ERR_CERROR_ABT_IDX:
-		dev_err(smmu->dev, "retrying command fetch\n");
+		dev_err(dev, "retrying command fetch\n");
 		return;
 	case CMDQ_ERR_CERROR_NONE_IDX:
 		return;
@@ -424,9 +423,12 @@ static void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
 	 * not to touch any of the shadow cmdq state.
 	 */
 	queue_read(cmd, Q_ENT(q, cons), q->ent_dwords);
-	dev_err(smmu->dev, "skipping command in error state:\n");
+	dev_err(dev, "skipping command in error state:\n");
 	for (i = 0; i < ARRAY_SIZE(cmd); ++i)
-		dev_err(smmu->dev, "\t0x%016llx\n", (unsigned long long)cmd[i]);
+		dev_err(dev, "\t0x%016llx\n", (unsigned long long)cmd[i]);
+
+	if (q->quirks & CMDQ_QUIRK_SYNC_CS_NONE_ONLY)
+		cmd_sync.sync.cs_none = true;
 
 	/* Convert the erroneous command into a CMD_SYNC */
 	arm_smmu_cmdq_build_cmd(cmd, &cmd_sync);
@@ -436,7 +438,7 @@ static void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
 
 static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
 {
-	__arm_smmu_cmdq_skip_err(smmu, &smmu->cmdq.q);
+	__arm_smmu_cmdq_skip_err(smmu->dev, &smmu->cmdq.q);
 }
 
 /*
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ab2824e46ac5..ce0b0afe62b8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -762,6 +762,7 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 
 int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
 		       struct arm_smmu_cmdq *cmdq);
+void __arm_smmu_cmdq_skip_err(struct device *dev, struct arm_smmu_queue *q);
 
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
-- 
2.43.0


