Return-Path: <linux-kernel+bounces-124182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D11891382
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5275E1C230B9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFB63FB3C;
	Fri, 29 Mar 2024 06:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y3MHW9qL"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3695A3D984;
	Fri, 29 Mar 2024 06:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711692931; cv=fail; b=EU+CKxpu4ngDkVKMCnB5a5vk8cJFK/FJs5Odz2tk9FrYg3Qw+mkH6dYCRaPKGt7+eV5qbjZKtAFCjNlg4SPmr19u8c0zNjpcqsaOEfWgbEtZSD7whxgAzvTPwExfvU/W+NHT/RoBdtu76Dn6wI3lvKi0MW+iGxg5bfW+Mjs687M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711692931; c=relaxed/simple;
	bh=QVY2NlQRjbfXkx8sVauskuckfDqw77zCyPfiQBe7y4Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DbLSYmHYK1hUrG0/Ll+FKrMiMhWvnUP1TOHrdxO4hSuNI1013pc4LShNGp0TS9gppsb21H89sW3JpB1QzRBWZ1He2TFTu/6O2/LJ8eKfjDFxMvFTOkur/4TVyftxr2cQSLh63oZ4HlfKGmoCZ5rEVZy2Px38vcbwtIyM3BBueCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y3MHW9qL; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eD0u1x5u8DoarqzZiMtP1qE1RSlbZaLQQMZcYdSbkO2ac80VlKpvULnhu2QXmn2nFN34VcXcnb2hVsezHyuXgwOTw6D9fWxZf/TH8chASQokQLRKoBsnkU+UpANuwjo6Wa+yHCFyZJhJZ57OucC8Hp0RoQBcdWXpkyKpiXHQrzi24akoBJDWbh4Wk0+h4vQ7sopM55m9MWNyES3+8Z089K+rv/XJ1x9BAOnkLqfEjUMpdvr8mAgL50OaB1u210OuhK7u1oqm22Q4p5xs8CEs3kNdsYhzeLUl3bq6N0fZWKwqXAuiFYdKCrZRhov2dpEslD1AlYS7MADcDMZf5iYINg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNdl1o6namIad3uQYT5rONipX5GXGrLZZUwZ9BvNdbk=;
 b=Pa1IAgleg8BZBljeapG9fGpHdjVKtAy46PIwImq4QLfG8NOaNr/9f0flMvMlADnzA1X5MPWY43ehr2WTeUKNWHu1qGkShuiHNIWKcQT+rsNVjcRO2T/tfxni024inKxCK1c22Q2tNG3C3w+80rBFZjIUFMG2qLMXJ9Pki+7yB155LBO+5QBfoqKR2ImzUOkZoYALVYcVDy9PszuKhQH+ZTPPoYN7mN++MHXMkeUpZfT7x1bqKo5jrz9LfgXDAPatgycu7gfPHC4TrbUzQK40zHE3lAzFh5mFjUTfztrUjxkF2ZoiLgsfmos0oJjvOOXx/CH75OjrqceZFE2pAYo15w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNdl1o6namIad3uQYT5rONipX5GXGrLZZUwZ9BvNdbk=;
 b=Y3MHW9qLgYLiqfipIt8zNjOyO4nEHl8OhbOBda5olHk6650SRN1voxBGWrsUy1ftXSGEsrFo1e8shCXOfVGKEctDH/1Hamp7JNl/9CLG0MacXPtJUlVsi1qiV1YaZOVU9vOzBEyhzi6rmBCW+PQb56wqEUBAjhUt4qpddjYOIUVWe14k5dZThQLMJAtbBcddyZdztyYShCjez1qV7tepOqOUJKyirV7K80ZM3JEvjZqN21vPsWYuzgO7v72fIbFU8M8mv5C8iCoGLzHurmy0z2XOsWFlxfKJzPLrHU9lSKuaX+31BkxKwGGX6pxJurnPNYhjNTGikasj8nB+aksNJw==
Received: from BN1PR13CA0013.namprd13.prod.outlook.com (2603:10b6:408:e2::18)
 by IA0PR12MB8839.namprd12.prod.outlook.com (2603:10b6:208:493::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Fri, 29 Mar
 2024 06:15:27 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:e2:cafe::b8) by BN1PR13CA0013.outlook.office365.com
 (2603:10b6:408:e2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Fri, 29 Mar 2024 06:15:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 06:15:27 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 28 Mar
 2024 23:15:15 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Thu, 28 Mar 2024 23:15:15 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 28 Mar 2024 23:15:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v4 2/6] iommu/arm-smmu-v3: Make arm_smmu_cmdq_init reusable
Date: Thu, 28 Mar 2024 23:14:06 -0700
Message-ID: <78032b4ba243d778b1fdc24ea46019da6626a760.1711690673.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|IA0PR12MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: 7778ef85-e802-456d-e401-08dc4fb7a0bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2oK+n6MNDLAHZ0BHbX0U7Xm4I4wryyY31ezrOd27saZEhdcq3A6/dO5XS6dpxXSuH2BnEHezNDNhng84F7HJG6uBjU1o8YV9QZnnAx6xA4VWS77ow8syIknTpsssli521TDd+indAUzjjvP8ArkLgtdxTj4eyPQBE+QpLGMgcR+56kuZAOIXNr+HLUXZ6/KtfmcjplJguflUf4A8EPvD2uGZ//M7dmf+niKGRqkD5DVO08s84wQO9N2Ag8MU8eKzFyENz20pfuEGpUGIxhYq3PFKvWm6bCbuAe63Ef8JftIohNOL9KMW6gCsix3l6hDlUSJj/chN8H6v6SYFGanod9vX9MSlnhyjVJBr4ZVX28skZ5dKVuVxwbhq+8TerTzgDnL2NgiaFhLmENUbys86aFcYUdlU6gliaf0eEr/yFcmgMtdSpZQWdrYCxSSHvJrx0d8yIpAlnxI5ChJ5m8Y26pqN5xbuKPcD8LUvK+g7pfVg1VPutONDDukPMdlU5/EKSvH0n1mQB9zDX1n2qemwebBLBqa64YW+NVAtelHbz3eRExx4Qxa4YjPFu3AgToQ5VvYHMCRl3MdPsCtTtEr9dl9nFpc+RjghIafepoLSX8vCIlgigIhP8lu6LZGBKvlGLcNc+zPKj+UZQH1MaY5WF6f9zyydmlhXKYy/ukq958YR77l2XVvJmUKP/x/87fV5f9aIAcKNF/JUvzjidhLjAOgSkYO6Ube1Nmm6KWWuEVMOygC9JGgCs+vUsHKCJSLJ
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 06:15:27.2145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7778ef85-e802-456d-e401-08dc4fb7a0bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8839

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
index da3957ad95be..44fcc0c0a149 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3135,9 +3135,9 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 	return 0;
 }
 
-static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
+int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
+		       struct arm_smmu_cmdq *cmdq)
 {
-	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
 	unsigned int nents = 1 << cmdq->q.llq.max_n_shift;
 
 	atomic_set(&cmdq->owner_prod, 0);
@@ -3162,7 +3162,7 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
-	ret = arm_smmu_cmdq_init(smmu);
+	ret = arm_smmu_cmdq_init(smmu, &smmu->cmdq);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index b95d9a9ae0a8..4af0976a2338 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -758,6 +758,9 @@ bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd);
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


