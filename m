Return-Path: <linux-kernel+bounces-143551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2956F8A3ABF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D393E285B5E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB192C870;
	Sat, 13 Apr 2024 03:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z67B7By2"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D301D551;
	Sat, 13 Apr 2024 03:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712979861; cv=fail; b=UuzhUsIiuraNI+OBGxvD3lWfP+PLcwIQuijGdi/ZO+ubWvaISEpyVUDVOwSxYnD+7/rUuDD45hh6wsFq42MVKBGOWoNiWWYjf5UbECTvSNBV1C6t3b25EO+BIkrNzv7xRfxrnNzQtqMwnUBuQfsdDCOxcdenpzdEQBe3FIFEnPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712979861; c=relaxed/simple;
	bh=XSkwOzHTu+6NRQ4ZR7qyr8RZiz7BvzPwkxxaGiNVz6Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NoOIOwA3yuU6p1YKWsdk/3MNAWJKwSUBXLH5aI2hI7KOxIp6yT1BUILXi1JDtBXZ/2cXFoptrBtYHUDYkqjVf4HszT8Q9q9sAVNNheiCRMmKArJbGWsBnUnX7io84m09oerH8+atVpgXXS/uG/0Ffse6jBYjxhWvLqUiWbgoYMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z67B7By2; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYNLNAOnSWUTXzKs1UhcZGprdkkhT+XxWINdqnV4bPK78DPkLwVWSZ+cEqKJVMNU89xyIbQ+zIyDL3sU8RP4jSNBgjiRqGubhRteaYiIuy/lLY5142dqmVU9jkjCoyWoWS9E8rvJ43jno9Nu+SUq5sS3U+J/3MnD2+hsWWmUoFYB03mWIXksRrifA8JDW9uYTZetaYtP39LOfdmn15t6CejDYZ/zlB/1SgzYkusKK73Z98u3XBrX9mYVANat4c3tYAIjB60RCUEqg4KW+dIHYOrP6BtL4Ef9RcTcYJAPpjWbXlHIHxi1Q9wNxILEVk76Bxq+8zV+9u4Nu2L7a9Y2lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihCl8layj3gC5PY0zStFzR/VTz8CqnPcy3ttPmWJxn8=;
 b=RCmI/gcNYVOy2yGEt4GIRex8dX+iNZaHoFXHpNlDg34l9Uq0J12nOmUTKb7D4v3Enr9CeSN+Syj2Pw9ntO2tQsqNLSC32GUX+3d3xQCWOf4m5pVevgh8j0SibxqugygS49oCFNO7LQeQ481NafrCQL4awQDyFssr0pggZL+cQGPSNtjzJr41gabiLFZp6W4Otarv1/9GdVKN/Ab2txZ2Zi987ruosltB3W31vvLRQQ3RRGQmwCmfyOeaUqjnFnAs2wiPHy9qszcV/Gq5DSHkByPfhLO+b89jHiy+SEfQNSj1Q0D8cH5Pj54iktqfD3TTnVozBl0jElGSIlAf68h/Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihCl8layj3gC5PY0zStFzR/VTz8CqnPcy3ttPmWJxn8=;
 b=Z67B7By29jilymcUjiBlai9jRrt+vx/LHhvADazcGozOP7CbmgeNQqvXBsK6stlN/t1/I6BoqYLafDVotPUfeM4ZSSwEUEWe/rmcNCwM7aaqmFSNRBa/NOEk+76bWCLyGlXdjptSwvZdSnqkljNPf2ek1Rm8jvZya3f9nQ37OmF0QqLdIkPTetq95IkG7XmEwNd8TwuhTy40/GuFUBkV9qjGGuhkAUPeBeAsgIugznhntv+svtYl9LL8QVXkVWvqNADCcCL6B6vELnE65Sk8ezJ8lla8HQEy0zqzV5bECi/FQjBmIONWkL/eSYRys2gSXntXCaZI18v26Z56xu8N1w==
Received: from BL0PR02CA0005.namprd02.prod.outlook.com (2603:10b6:207:3c::18)
 by CH3PR12MB7665.namprd12.prod.outlook.com (2603:10b6:610:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Sat, 13 Apr
 2024 03:44:12 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:207:3c:cafe::1f) by BL0PR02CA0005.outlook.office365.com
 (2603:10b6:207:3c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26 via Frontend
 Transport; Sat, 13 Apr 2024 03:44:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.0 via Frontend Transport; Sat, 13 Apr 2024 03:44:12 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 20:44:05 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 12 Apr 2024 20:44:05 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 12 Apr 2024 20:44:04 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v5 4/6] iommu/arm-smmu-v3: Pass in cmdq pointer to arm_smmu_cmdq_issue_cmdlist()
Date: Fri, 12 Apr 2024 20:43:52 -0700
Message-ID: <8c5d2e129432faf0ede8d4748133574e0e82401a.1712977210.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|CH3PR12MB7665:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b2d696c-dacd-494e-733e-08dc5b6bfbe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qKRnRbtMb/89WZbGUIrahzMMUcFlrbe9EfdELGBKCF8z7FXF/awp24LoEF1A/OEuRiA3iSTg1d+5ypxDABAeBTdzW8j2LOeTjaZkSp41SaEHwLUonPpmBWiQy1hIhDOncdO+bp3sqO4XnGE6sTAA1sy3uJXPwkyq598feSjA4uWRquWK3348ontpccZxx0UegCNIj9jxHf22nj1uF6dVngjudq5N9zOXFls5s0xJ5OLnvfz6LIThmGQKU3TSV/wLJeGHS31O66rsFYCcH7FOdClhzcNKiqHm6OOQmJ0t5CZjb/QeWnyRAc92JT7ev0fdxJ7musK010wsWA/BuEdmkAcealo9rje+F90r71uH33chQ0FFq+nsFzZ7jkyAopQvv7iLKKcjGnS5psWxT+ZKVMpRwh5ymokcTz9mYj7dJWc76XZGPo8QMbdgGuCNgNLBpkguhh1X7uIJSQ4By41B2WTM1GdKJV0KIWtIzzKyyieXM32ZdiZraahk7os3P5brZVOtcvADdzhctzGSzsfV4Qlt3ZOTPjnxMyAWQOS1F//j708ch2gNduRrVHBSVkLUXP6fiRtQCTmrPwjAGt0sHTKoDhBnUpbzdbGDdAc/7V0NSkQltZYy5cogDbZfO6CEypzp7pwlacyf6PgwuWezLjyyI30xkz2cgcpvoZdYekVnRFKlBZi+ah+3u7ZkDoB8dqB+CIjFpgRvJQOJCdGqEIN1pjDfeBNtmPhbyv+jHVfkGTpThVQ6JDC7pHDgbxww
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 03:44:12.3614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2d696c-dacd-494e-733e-08dc5b6bfbe7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7665

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
index c5d43f2167be..cedaf606962b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -603,11 +603,11 @@ static void arm_smmu_cmdq_poll_valid_map(struct arm_smmu_cmdq *cmdq,
 
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
@@ -638,11 +638,11 @@ static int arm_smmu_cmdq_poll_until_not_full(struct arm_smmu_device *smmu,
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
@@ -662,10 +662,10 @@ static int __arm_smmu_cmdq_poll_until_msi(struct arm_smmu_device *smmu,
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
 
@@ -712,13 +712,14 @@ static int __arm_smmu_cmdq_poll_until_consumed(struct arm_smmu_device *smmu,
 }
 
 static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
+					 struct arm_smmu_cmdq *cmdq,
 					 struct arm_smmu_ll_queue *llq)
 {
 	if (smmu->options & ARM_SMMU_OPT_MSIPOLL &&
 	    !(cmdq->q.quirks & CMDQ_QUIRK_SYNC_CS_NONE_ONLY))
-		return __arm_smmu_cmdq_poll_until_msi(smmu, llq);
+		return __arm_smmu_cmdq_poll_until_msi(smmu, cmdq, llq);
 
-	return __arm_smmu_cmdq_poll_until_consumed(smmu, llq);
+	return __arm_smmu_cmdq_poll_until_consumed(smmu, cmdq, llq);
 }
 
 static void arm_smmu_cmdq_write_entries(struct arm_smmu_cmdq *cmdq, u64 *cmds,
@@ -775,7 +776,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 
 		while (!queue_has_space(&llq, n + sync)) {
 			local_irq_restore(flags);
-			if (arm_smmu_cmdq_poll_until_not_full(smmu, &llq))
+			if (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq, &llq))
 				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
 			local_irq_save(flags);
 		}
@@ -851,7 +852,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
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


