Return-Path: <linux-kernel+bounces-163329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7E38B6986
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D231B1C21AC3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1AD12E63;
	Tue, 30 Apr 2024 04:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M9nQ/j6u"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D8C10E5;
	Tue, 30 Apr 2024 04:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714452254; cv=fail; b=CVuhtwZqYTKnAMV4uzj+1qbjG9NqzO9O4ZxVbh+XtVqANTDwSmkDIX1vJMhM2yIJ7sxr2rVcF2SN3fODx1fxE3Lpz2v2hDAJJPcVHtiTregeKGv5UZ1ikW5Ub7dMnoM2k3gf2F3gLui8Yom9Q+xwWTXjO/S+g3XhHao2NmZlvBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714452254; c=relaxed/simple;
	bh=RUEXEBxBFX8kKx41yMKJhUE7+bSHOUQ4G8xkPRlhCU8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XiZwpJkebU31mGDCvyrkUG6f7mTBnNkldNbSDp7bOKxS01yGrA0hYc2mSkvk7QGxkgoqlFbyaPCmIgvDLJIy/ycDKKqilxTdY2PWwJ3JuY0W+qEZ1STsWiUqtBl38NvdlHt2+mqoWXBtiOHs7JAz46VlOc/l69ex4Dv0gyg3Uec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M9nQ/j6u; arc=fail smtp.client-ip=40.107.94.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDrYRY3Mo3ewPj8g40rIjckiHrUyV4yECG3zpIjTMeJiVkXcEDCNcK2ttnVPyEN7g4dFk6yI2flB2cATGtQo8yZCRmGx2syQW3zrcjpLr81WAHAY+X2ImWKD47UmoWCA+F+E2UzYMCZQq8s/FI91rIHmHCER8fhWgSO4/tORvQOcPc6xTY3mM4pi91Rz9515f3+fIUJVDKbbnqJphnO0vUoZfXfy6ozRjEZxYaEW8Rr4gu1i9GOWyXVJhVG6RZ5TIaVXF00RQf2Kf9bhoyTgvmDQ7N2Xx0+U6degtDtMao9/WDCGwOfCsnNDYJ0xxMKuBf0La1I2Rm48NrHyBFGjUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9vdxtBQLuqUDst4WxiLnMXs1NlIMnmBJqqg7uyV9Tc=;
 b=gxFbZOhILoEA78/KsfEknW6Dde13PtWRfq+9bSDexgTsJIAqJNi3Bd0obyqd93MP+agZEA/8DdPoktM+cTkLGqFBODcSQ9Jmx+uZ4YcM2F1BAXJnbS1z6yh7Rp3SUXf77nVOBcux/sYlGcpUZITtZHDVXAQm/ky2Sj2up0DkqUK8s7//mjPVaic5zxgZ+jUOW436tHaRIbeGc0rpeaF9atTG28AK6N33egohuEP9eIa7sgO4U7tYJid5JdTBCl+hk88F1U5VhhRBISmrg6YQ+uotdtyPnhTGYP9UYQLPXEx42p1I3Ym/wvflHkfVAPQvYxRc0TCYvTxLak/KOVJ9kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9vdxtBQLuqUDst4WxiLnMXs1NlIMnmBJqqg7uyV9Tc=;
 b=M9nQ/j6un8rv5LPYFPn98TWKu1UcOTFfGGCr1XV2jIasy1v3NNkfTn8BdTDfAhaL4Dg4LjromSQedndwKCUf0wwqUR2wSTssJnJGK6CUAaukl51OUN63FnYVEvMtH9Z3inODHH28mI8lvV9nf1Uti5fNlcKC1wqQnKYQN9jNI5gTLwaCm2q7+oDdlSn6EbCbW4QetsKps0IZh9lQTUcqCUCGx1lgl3+vns8vA+hWo0S4k8ojOEvHbCxN0JwpIVVQvbii3KltXcfaiYwftCAjXpJmjwHWIAsHEleMhHyvXV/tPe+OH1g0pV5R8wEhe3BbCozpi+o198kauxFszr+rGg==
Received: from SN1PR12CA0087.namprd12.prod.outlook.com (2603:10b6:802:21::22)
 by BY5PR12MB4276.namprd12.prod.outlook.com (2603:10b6:a03:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 04:44:10 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:802:21:cafe::d6) by SN1PR12CA0087.outlook.office365.com
 (2603:10b6:802:21::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Tue, 30 Apr 2024 04:44:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 04:44:09 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Apr
 2024 21:44:07 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 29 Apr 2024 21:44:06 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 29 Apr 2024 21:44:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v6 1/6] iommu/arm-smmu-v3: Pass in cmdq pointer to arm_smmu_cmdq_issue_cmdlist()
Date: Mon, 29 Apr 2024 21:43:44 -0700
Message-ID: <0acb55059f7212abdf4277a81e2f033127072bc9.1714451595.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|BY5PR12MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a0dd7fb-52a8-4faf-9a79-08dc68d02d33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|376005|82310400014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rx4WTYNxue3lIsV7X/f5SBQd6PAJ+lmnglWm/n4ak/FUvNk6fVQAyNAPTk7o?=
 =?us-ascii?Q?6Mc4H1wlM/0ENikf1eG6q8/0+/gR0Xa+AQAbSE7AUWweEVr5SluXbDbeZkT0?=
 =?us-ascii?Q?XdGG5eCndsKemYZNcUUTW5lmdh6X5FS/XhxFLJUlPB7gEwk3PUR3FSL5pjvI?=
 =?us-ascii?Q?S2Bj+wAkMITA753HIsoL10Hi1ZAAyAsXPDO21tyz5mksyEjwxESVjwdIp204?=
 =?us-ascii?Q?WFsIM4qitymRcrwIUx6q970GyFMB8khY0LMrF7RA41TSFL4Tz6Y1Ft2XX7br?=
 =?us-ascii?Q?ESPJczz/MYe1fQLBfYhkqD2YDDIzcstiCrvy3bZc9Ln1hGVwenaU7JAWdlq0?=
 =?us-ascii?Q?vv5JYEaORMaWsyHDchU4OmwN3zwtPrE20CIW+DPf64e68Xihn3h30rPossZy?=
 =?us-ascii?Q?9QxF7u8sZ4qDy1WSbBD4QZgIYAETC9TONuHtYrMOia3EnEjo+N4zea4lF6CA?=
 =?us-ascii?Q?QhH+5UighFi6MGJH8mfJhxHc5NYYonfPSBZtnHlRouUrEGqqEXoSKDX66yq1?=
 =?us-ascii?Q?6LqL75NSYWviHkLgJMwiKLWOH3prDjYDQV8IsODIicAw4uj/zK5IRCTauZVI?=
 =?us-ascii?Q?laoX6Su9CtUqEgcrmUzNHlrPI+/SARfrJNd+AlkXVA7l09jpUtTELyhwtyRS?=
 =?us-ascii?Q?Fk9G/JPwv9jZzbNsj/UzpWrmEcANZQLNOvW7dniafAwL+czlgZ9j5RrYodei?=
 =?us-ascii?Q?QxX9kynqZsZQZ9YNDR3l4asAl4PmjanxCGAn7xCN15oxSi8In/mo6uSNIdmf?=
 =?us-ascii?Q?giLPCFANi4EyFJ59rtMQo/nv7UI+pmHHZNcMrOOB4HEik1U4qhXG2LVAq585?=
 =?us-ascii?Q?NITvc0/1Yql5K8Y/9SiOOcKDXHS+qy4oYtTdsd//IsSF/VZmPDq6p9o7gu03?=
 =?us-ascii?Q?5Q+C6fEz7+lctUeMGEgjN/9mCs7Fy7u4LISteROn/g/WqSfGmJpJm0WOGb3I?=
 =?us-ascii?Q?grJtsDTaialzisTVS692NzfH4CAUot3Z7lv99EVbCcz5/nHp3uDsge3j9Xpu?=
 =?us-ascii?Q?FUb61fx+mZucn4tM2r5VDqi7CzqbqRgDvSlohhvLD6LO5icvkDOK7RaYeJrx?=
 =?us-ascii?Q?ZAU4ZXiRIcOmTjVy3aTI7d1J0JlWFsYln+mKV0jZWNrC5tjC6rYb9wHfkohw?=
 =?us-ascii?Q?dNRCW2d/4AAk85jkAG6d9GercwFv3Jwij9uDkgTruwZ+ntg+adjV1wTIRDqz?=
 =?us-ascii?Q?qwIX1caN4cNaNTIfthWNThh2a/H7V6860tpj4AYcflnSBrWOpJk9fRNMeJqC?=
 =?us-ascii?Q?uSXI1ISyPLShmqot61LJ7OYlTTJfzrUPu1Mc3SlDurwhG8zY47vR/TS+MJHy?=
 =?us-ascii?Q?XoRSgamYp3FtTpKhdWw1DBE3YS+TXMWlwP9ukE8nzx4a2o5xxaYN7hApu3mE?=
 =?us-ascii?Q?FpJxTbtfyCJHwcUon8z4nI9yta5e?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 04:44:09.9360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0dd7fb-52a8-4faf-9a79-08dc68d02d33
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4276

The driver currently calls arm_smmu_get_cmdq() helper in different places,
although they are all called from the arm_smmu_cmdq_issue_cmdlist().

Allow to pass in the cmdq pointer, instead of calling arm_smmu_get_cmdq()
every time.

This will also help CMDQV extension in NVIDIA Tegra241 SoC, as its driver
will maintain its own cmdq pointers, then need to redirect arm_smmu->cmdq
to one of its vcmdqs upon seeing a supported command.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 41f93c3ab160..6a7e6b1ba5f7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -596,11 +596,11 @@ static void arm_smmu_cmdq_poll_valid_map(struct arm_smmu_cmdq *cmdq,
 
 /* Wait for the command queue to become non-full */
 static int arm_smmu_cmdq_poll_until_not_full(struct arm_smmu_device *smmu,
+					     struct arm_smmu_cmdq *cmdq,
 					     struct arm_smmu_ll_queue *llq)
 {
 	unsigned long flags;
 	struct arm_smmu_queue_poll qp;
-	struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu);
 	int ret = 0;
 
 	/*
@@ -631,11 +631,11 @@ static int arm_smmu_cmdq_poll_until_not_full(struct arm_smmu_device *smmu,
  * Must be called with the cmdq lock held in some capacity.
  */
 static int __arm_smmu_cmdq_poll_until_msi(struct arm_smmu_device *smmu,
+					  struct arm_smmu_cmdq *cmdq,
 					  struct arm_smmu_ll_queue *llq)
 {
 	int ret = 0;
 	struct arm_smmu_queue_poll qp;
-	struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu);
 	u32 *cmd = (u32 *)(Q_ENT(&cmdq->q, llq->prod));
 
 	queue_poll_init(smmu, &qp);
@@ -655,10 +655,10 @@ static int __arm_smmu_cmdq_poll_until_msi(struct arm_smmu_device *smmu,
  * Must be called with the cmdq lock held in some capacity.
  */
 static int __arm_smmu_cmdq_poll_until_consumed(struct arm_smmu_device *smmu,
+					       struct arm_smmu_cmdq *cmdq,
 					       struct arm_smmu_ll_queue *llq)
 {
 	struct arm_smmu_queue_poll qp;
-	struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu);
 	u32 prod = llq->prod;
 	int ret = 0;
 
@@ -705,12 +705,13 @@ static int __arm_smmu_cmdq_poll_until_consumed(struct arm_smmu_device *smmu,
 }
 
 static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
+					 struct arm_smmu_cmdq *cmdq,
 					 struct arm_smmu_ll_queue *llq)
 {
 	if (smmu->options & ARM_SMMU_OPT_MSIPOLL)
-		return __arm_smmu_cmdq_poll_until_msi(smmu, llq);
+		return __arm_smmu_cmdq_poll_until_msi(smmu, cmdq, llq);
 
-	return __arm_smmu_cmdq_poll_until_consumed(smmu, llq);
+	return __arm_smmu_cmdq_poll_until_consumed(smmu, cmdq, llq);
 }
 
 static void arm_smmu_cmdq_write_entries(struct arm_smmu_cmdq *cmdq, u64 *cmds,
@@ -767,7 +768,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 
 		while (!queue_has_space(&llq, n + sync)) {
 			local_irq_restore(flags);
-			if (arm_smmu_cmdq_poll_until_not_full(smmu, &llq))
+			if (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq, &llq))
 				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
 			local_irq_save(flags);
 		}
@@ -843,7 +844,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	/* 5. If we are inserting a CMD_SYNC, we must wait for it to complete */
 	if (sync) {
 		llq.prod = queue_inc_prod_n(&llq, n);
-		ret = arm_smmu_cmdq_poll_until_sync(smmu, &llq);
+		ret = arm_smmu_cmdq_poll_until_sync(smmu, cmdq, &llq);
 		if (ret) {
 			dev_err_ratelimited(smmu->dev,
 					    "CMD_SYNC timeout at 0x%08x [hwprod 0x%08x, hwcons 0x%08x]\n",
-- 
2.43.0


