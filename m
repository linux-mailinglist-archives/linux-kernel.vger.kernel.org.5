Return-Path: <linux-kernel+bounces-124184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BDA891386
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1AC6B21B6A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1334E4084D;
	Fri, 29 Mar 2024 06:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xxm8WOx7"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE273FB02;
	Fri, 29 Mar 2024 06:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711692933; cv=fail; b=sO46ReQiVLT08e6SRwt6LBQOxQsuKuHNMI8tMafQVkkI5wI8FsKBuX4fdRJcoui6TO5yY+CAB5ZCC2AsepdHEKMKq36lehavJQzDEKOrSQosOHvTTFlr1u66Hv+jXixhpTbZyIvddEgUmw9ZakgLCcl0A5VYT1DlyNJMEyeAZ6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711692933; c=relaxed/simple;
	bh=BT0VfUeYY0WSW8gVvf2iWsM4Cy0ReGtt+E8jigSFyxo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGrBdTLqxCzlQtiZgWQT57JpxBafeLNXuLzJpqP48kQrEnVl7UEjNQSDgn6oS8O+Sn6Hpp4+5NWH8Hx+8mawjlbWcewgBzKrnaewhmIqdQpKtLq7xVjog7rKqc31FreSDIy9+6KvoPOnlDmX5dB1ZSh/be4Lbv48sVsRNNJmNDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xxm8WOx7; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5XGpUu4Y9gPOVzuHPoixS4863LuWBIlv176pu4lUxFV7h5fXGmbmyH9WxTo4jUnrV5oIKrjUqxr1FMB8nhvO+3/lW9Yu1IpFNjD5bW3K3MPWORU8OJujAG8g8RODa1STN2iFh3SFCKyxaoA8f2yf/dy6CzdkfBe56ZKZzbE+geJRyF0GIGYX8Uz9Yt5BxIUU2cj0hwVSaz8TozXJZig/o7H0U57YWSlyEns6v3vckZJMJjsLM5oFgTErcgJ8NqoXtuWiCi2x1jCZN+Vi60qtrM62n5qI3Xhr9/n1tlwhGpUF8K3L4OdMtHAQXW98ZkCwNZeQpGglQ4aGJ8MHJ/9LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzeJgMasrBKZweYz/iNOmJOpwf+fNatuH2gYLFkexFU=;
 b=RrjNShnfj9XsUdiEppZIFGTHFtNn25z0BlOmYvHgJZqum1zrLJp3sX4Gvlr85wkGtsb2lymOHH+Up4vVYRio3FxtU5ttw1/ACWPBSoQCPMV+0AZjFe6mCm+x97FzAW6tVFzcjymjKZxq60GYKzoGfWNmqOqPY8Opln3TvP43oF8kcyRhyvuvDEW9z4y+cWagPg/6oNErpGG5kt4a3RsLGhqSlgZkm4rWdOpUrKR6axuxzVLKNP3kOAYgYZVtvku7Vlc6NKvA1jzbVmke2FpYADfEb4MA0V21uqZK9BrI5FyVp3vgBK2T9oOqNLRiR8lEjSYaOIQvP4NKvhU+RVgn0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzeJgMasrBKZweYz/iNOmJOpwf+fNatuH2gYLFkexFU=;
 b=Xxm8WOx7NarVcWYZ76KpxiI3PSTppWo3KA0JB/hBJ1QA4qOrQmIgg43op9KfILHcrzfKdaksUKsMJDzEt+7tESH6NT04Gg7aYzbW8f+yBm7N/Z0B7OOyroyX8qWL5dckrZEVbZ7z30N5V0x/Nh+Tg74dPvd8nGww7vNhEKPNet3kVciZUuU1YrJs2tCyZAzt1j2gj8MGrQQ68tmbbP8wBvW6Ui/A/bXmBtO/WXWeY4FGuykVuLv2g75V/wPDxEamPlsXrzxoRSxKPvEyoayqpbu4ObItCQmiQEorV3HNQr6gHof/puYnDe9paS3b9eMXI1c9S+2Kca1Xy0OVUOoc6g==
Received: from BN9PR03CA0534.namprd03.prod.outlook.com (2603:10b6:408:131::29)
 by IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Fri, 29 Mar
 2024 06:15:29 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:131:cafe::cd) by BN9PR03CA0534.outlook.office365.com
 (2603:10b6:408:131::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Fri, 29 Mar 2024 06:15:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 06:15:28 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 28 Mar
 2024 23:15:16 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Thu, 28 Mar 2024 23:15:16 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 28 Mar 2024 23:15:15 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v4 3/6] iommu/arm-smmu-v3: Make __arm_smmu_cmdq_skip_err reusable
Date: Thu, 28 Mar 2024 23:14:07 -0700
Message-ID: <ba09af875d76827961e22164e5fd239824c10f92.1711690673.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|IA1PR12MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: 70dc324b-dbe7-4e88-60d9-08dc4fb7a1b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7MF2ou5YM9FgbRGYjKg2kvI3gOHUDmb+YStlSLZ2SwbxuMGJ9UeoCdlStNXsk5CxlA0AEeXAo5Ne01EOpdPHaSMD0vN542lJOOW7EYaHnLE2vvj70bUE5Acnp1iHSpzv9oBrr/sjKTGdwfRRRB6BwRoYDCUKk3/G72gRnho7eqbDqBYudRdksNe0kWqcPvxDIR/VAjRSQ7i02lY/IOPCq6/59uf49D/yQJyCQcKgSKtKYhfbBT3p1De3NZT6h/Lw0MSs8Dan+s3Nfzht/W25eQsDvamd2tn87VDvkFHe3LMXQNtQWIBm3Ir8ueBZFq9bBaqQSzK7r28yC3TqM5BYr998sVi9KikB1XCKmzyCw5xLwhlSk4be9EI6BU28jD/oZ4rHLOWVigTHHzGbseY3aSYdDsAysehsEBgScMmKKjSgBHsVSga+M9o5OZzmfxzLHhfwEia8WdaSOyQBn7OzGX7Auc6+5TLcJR6l3flM05dQwQ11t2OkFaPx/5xLJVcihDoeAwnXRMKjo3pWSRJ0TsJURKZ988RbSAA6y2NWukUfIKxGw9xx7wv4+5O6E4XnctX32zT1tQzjvwekVLRVKVayEDvZlgrS1LMqWVBxLHdKEEkg04Mj8JnJ1NDqcmtyxrHjjHqFwOBb311SPcxwYn5nz6XBTFyeJwUbnqvV19ZoXqrGG3KsE2aTrBPaHubJZytTX2gjG5ZWrw6IVk1MVqXUItjb8B+1XM0PNNJM8aDnC5nKqWcE/6DeIiq0Tnzv
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 06:15:28.8455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70dc324b-dbe7-4e88-60d9-08dc4fb7a1b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6092

Allow __arm_smmu_cmdq_skip_err function to be reused by NVIDIA Tegra241
CMDQV unit since it will use the same data structure for q.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 +++++++++-------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 44fcc0c0a149..6cb20bff5a8a 100644
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
index 4af0976a2338..3046c1028e66 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -760,6 +760,7 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 
 int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
 		       struct arm_smmu_cmdq *cmdq);
+void __arm_smmu_cmdq_skip_err(struct device *dev, struct arm_smmu_queue *q);
 
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
-- 
2.43.0


