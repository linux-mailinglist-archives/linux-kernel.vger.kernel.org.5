Return-Path: <linux-kernel+bounces-163333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B446E8B698E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7CB81C21B4A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3D61B95B;
	Tue, 30 Apr 2024 04:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZCQMgY9U"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317BF18628;
	Tue, 30 Apr 2024 04:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714452262; cv=fail; b=dT1fjgyRBD3bH0PfDqEpfBJiciYjX3JXujTO2xtqfCzRXyXcCsWDwKTFompd51SN5mAL7xX9ajzTq91KbWfbQHqp1qTlWkUAXv+LoV1gm8DjNA5QDx87bKRiU0f2fLraDYkxwDySSgffly1Snh6IAqleFhz5nPtGodlbYjz2YaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714452262; c=relaxed/simple;
	bh=+pmV/WlftSoFWSqbXrnh/dMsj4JwqxsRhryvupZmIP4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h6Im7Bddbodhfu48l7wB1UowtYmQKGvmBqCou0sHr7wOYyN+he4MEX+K9mtwfUpic99G+f+n7PM5KkwRtyLePJy0ipCpLQd8Hp8/k/OUDlHuhkU9U76WizLfQA7v4LYwFglOqew9D8gJNSMCobg+d8Te5Y4CDwVqXOS6lqUCCIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZCQMgY9U; arc=fail smtp.client-ip=40.107.212.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5UV8Jb/QPFjyf8urXStPaq3ByDpjThTA0ZqLAgtt2JkPuiZac/ff3AKs9hRG9jqR/E1V2A+oA5NezeUVloGqehE2IZYFutC7TrLKP8hHW5StKwXwJZxNflw4sATxV9XHg/+0d6rjTQENRp+1DEKPfemoY+TYPxJ6YgOsnsdlEicloI8Zal928sOKih+L4pvmSLk7clmackq1///nFinGNTF5t5GNoEIsbQ2sbgthdqcGLs/W5ol4bFGf+udQXvpDTRiaEm9evU6fN8Vk6TQyCRQAU6g+uFEKXFicKiqtd2ZUtFEW16c2/DC2ECIeOuxQFrDTbf8DGqv0g+iess5nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtcUhhLLQlhwUHWp3E5qNVm8dfY4E8/bzO8zqI8jEZM=;
 b=EI8r29n+31tYsReNXweYWz63P5ymCn2zy5Prmn9uUkur8IXXyAhunTZLJXEq+p9vASP2hpD0I2LzaaZhCJldWHVmZQAEStfrZRolH0m4RMLlSBaOTBPLLvUYxLapNqrdJGCTq24JZdzzxQNL9XxiPFNgp+s2UmzeKKdOp+Dbf8dGaxEdXhz1ssoC8HVxbaa/W1QubOoZC9q5YXeY1Z6TUaZAn05AhEjaQxxnjRCrGtRGmIQBlxsxUIws93LsbLq0M1TWDiHw2AjBNpmzpb2rJlGXPi3BDHw/bZou3x/O+ycx2Q+Uv3kbLoTf1HUrVrV4J5/mb8ZMIHUleb+QPWzauw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtcUhhLLQlhwUHWp3E5qNVm8dfY4E8/bzO8zqI8jEZM=;
 b=ZCQMgY9Ug09HN7bP1A/kpIgebqLOQ6UqkftoY6wBsXYCPn//gXq1yoU5AZXTUG+ziW8A10ibSFaUEAAzjbBxQQdt5khERA1/WzCnfZS79GBdyfILgKT+JdVvI2nMqCvZRh0bQ20lJGfylfw+UbdDCXkGtymBtnuONIkLIEClA8CBXixFvRm/Pb9ncXhcelqfa65cQ045U/6NehrxAJw+Jmqo878kllQztSDIu/61URcKwb/HmwBUS7Uue2pZB1/Ua+tnMv/NjYbxFedgCJFRE8YfLQXY0B6p/lL6ZmY/Ta90cjypScyoG8BaYQb1codHS6B4Q7VqJTReNy46FjMQVQ==
Received: from SN7PR18CA0028.namprd18.prod.outlook.com (2603:10b6:806:f3::11)
 by IA0PR12MB8713.namprd12.prod.outlook.com (2603:10b6:208:48e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 04:44:17 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::8b) by SN7PR18CA0028.outlook.office365.com
 (2603:10b6:806:f3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Tue, 30 Apr 2024 04:44:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 04:44:16 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Apr
 2024 21:44:09 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 29 Apr 2024 21:44:09 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 29 Apr 2024 21:44:09 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v6 4/6] iommu/arm-smmu-v3: Make __arm_smmu_cmdq_skip_err reusable
Date: Mon, 29 Apr 2024 21:43:47 -0700
Message-ID: <25150aec77edf5590bca81f4a418ef1ee7b21952.1714451595.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|IA0PR12MB8713:EE_
X-MS-Office365-Filtering-Correlation-Id: 28fe10a3-34c9-4bc1-fac6-08dc68d03167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400014|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n/Kdb8WXVZNRMTCZX90cr9RQCNTw2j8IdvHEYrn9cbkETUtc1SdErT78EoNB?=
 =?us-ascii?Q?IsHWIJL4PeF2Jm0QcnhkCydHEi5v1t/FdDhvGcaRVTHY0Du5uv+SYK9GISFT?=
 =?us-ascii?Q?1LEiqkXceAUzEQsBsY3aGiHoeVcca/SbyZO65KuIJS98hFEAn9sQ0RQmBHad?=
 =?us-ascii?Q?DOA4Ddynyq+2aafA7xRsc27umuStPasfIVxY8xyULG2GoSg7KH+X4b6R3l9o?=
 =?us-ascii?Q?VvCttFsPWkKLQxgKCIEgIRhLACceujDYeOVHx5iL/so3u8CntOBm14D6noWS?=
 =?us-ascii?Q?DbJOkHsx0wlcj/veqfIRj0nErLsKng73jG6d7S8KMQW9oxJilYN3GipG7+w5?=
 =?us-ascii?Q?XmP7kn4W99ftgn4QTeK4sRlBsvxnIbZDyL97Mb9jUiLdDkORt6ARHcv9qc/e?=
 =?us-ascii?Q?ECX2c3fDLRLmRIsyivMR1yAxk63eXwis95937HvtihZabx4FpvY01x4n5+2k?=
 =?us-ascii?Q?IqdnUJJVeuH7QlRTyRNkPMsBf7Ai7J6lnK/CW7uOoi6MPGcFQGM+dKuWUiZj?=
 =?us-ascii?Q?Vc/kQJNoYKdAys1Vb5H1QBTRRRiK1Owfd2cydfopv5J4CJOmSXyePmXxdAE5?=
 =?us-ascii?Q?VltilvAhrSZz+jR7CZ1/3aD/19IvLvm/DuuRAXDsDVYa6+/T8al/uQWt2532?=
 =?us-ascii?Q?G9LMN0S/KKFGrCr3cvsgVMwNlhJbVDZ7EZGeOidaCfOYvyZoXykHw0wfnd3O?=
 =?us-ascii?Q?AcrHvM9rjsvGxD53a98Tz7fkgWWh/xyuZxuyU60awyeJ35qC4qGVlcypR3yo?=
 =?us-ascii?Q?d01aQm1ue/hBEtnIxbfnFbdD8ag8ncWIlvQTj27/h2IddccJDMl9YnJMx5dw?=
 =?us-ascii?Q?DPzGdNjiMogNZp9Jr5NUxc0q15Ez5MwClocTf0p16yEmmAWgISqhARRoIibb?=
 =?us-ascii?Q?DqU6wjLltwAPsmLvcPjOo2ANPxG02iQYESU73Fp1kUvCmz68ymCi+PFldSTx?=
 =?us-ascii?Q?arXDf6XPLiIgKGMpSTu1iab0SAFgXMQ9CQzJTHO6Go2tRAieuR7vGuilEoLJ?=
 =?us-ascii?Q?Qvijn9OVBU+N193WDgINs+QE9DBSEY/pDnxO7tZLMdFdOnrqAyQfB7qtTZzY?=
 =?us-ascii?Q?Y8xfeQN2Rxk0QAc4DDCcXBRDza2RMI0hR3KdrSXBjLu6KA5HlNwrWloHGtGL?=
 =?us-ascii?Q?sA27hXwIXmbqrGwF6SI+QyadQ4r3Cbv65LhLsKm6EZ2cKmBabIgxFMWU53bi?=
 =?us-ascii?Q?jR2t3zbVkWZfG5L+rjxjmNuHK0JCjK/Oo31Ubj7JJGj5qVE7h0K/NLpsWCMI?=
 =?us-ascii?Q?P4TLCjKP8KQP0aEeSbfVR4HT7x3LGwM9LRtuUlmo2yB3oyBuaIgMBGohSQH4?=
 =?us-ascii?Q?xumUftPHIU7ToeZYIWXl0cJf5QhoHvTkEHhTcIv3sTuAfIfm+cGEd2Jo5XSO?=
 =?us-ascii?Q?6qWc7rTW2xsjDWGjUgEuw3fE+dI/?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 04:44:16.9902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28fe10a3-34c9-4bc1-fac6-08dc68d03167
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8713

Allow __arm_smmu_cmdq_skip_err function to be reused by NVIDIA Tegra241
CMDQV unit since it will use the same data structure for q. And include
the CMDQ_QUIRK_SYNC_CS_NONE_ONLY quirk when inserting a CMD_SYNC.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 +++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 538850059bdd..5111859347d5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -379,8 +379,8 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
 	arm_smmu_cmdq_build_cmd(cmd, &ent);
 }
 
-static void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
-				     struct arm_smmu_queue *q)
+void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
+			      struct arm_smmu_queue *q)
 {
 	static const char * const cerror_str[] = {
 		[CMDQ_ERR_CERROR_NONE_IDX]	= "No error",
@@ -428,6 +428,9 @@ static void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
 	for (i = 0; i < ARRAY_SIZE(cmd); ++i)
 		dev_err(smmu->dev, "\t0x%016llx\n", (unsigned long long)cmd[i]);
 
+	if (q->quirks & CMDQ_QUIRK_SYNC_CS_NONE_ONLY)
+		cmd_sync.sync.cs_none = true;
+
 	/* Convert the erroneous command into a CMD_SYNC */
 	arm_smmu_cmdq_build_cmd(cmd, &cmd_sync);
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ab2824e46ac5..32e7fc5e1794 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -762,6 +762,8 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 
 int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
 		       struct arm_smmu_cmdq *cmdq);
+void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
+			      struct arm_smmu_queue *q);
 
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
-- 
2.43.0


