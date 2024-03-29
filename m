Return-Path: <linux-kernel+bounces-124185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3B8891388
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33766287E3C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C193C41233;
	Fri, 29 Mar 2024 06:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MfA6GcC4"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ABF3FBBC;
	Fri, 29 Mar 2024 06:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711692935; cv=fail; b=DLNHCd9HAKEzPzN7B5O6wrLRP1IJsDPgfNfrjtTcBtb9Dk3BmEu75htPb8kVCuVQkZiYe2qhmaEDy8FegnIoeW6Q9dYQ9aOnAw7Io1E790PEZf3xoJGUGPX+jkpdazaxB751YCuiKNWOfcAq2Tbuiowgd1fgoQL0oTjqf2ioA9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711692935; c=relaxed/simple;
	bh=j62Hg899YiHlNoG8zjeBR0HGTrtojHlwKtyW+4gqCzQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k215XhG59ylemd+Ri2liJ4aXRrwpfO2brbZBqCP7F5dJqW9dMHB1chhnEKwvbVeuCAr5+7l+XjP8ekvdRzGrpSBta8zgyOe7ucsJ2oiNR9BH8BYDQ/N0cSb4Ff28v4yK1TE5xWxfDF80bChzC46I/fyqtaVLOK0Q3FbKavezpLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MfA6GcC4; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EP8ebBUwOJtevfhMYjsgjn52pkLeB/g1+jA30wqdUB1/1vdvNXsQGWmdUzYFxLsZLeQOlEehThmet9y26XQkrfT0kt0UMr8q3TRsFugVEhjk5fFxkOVrrXRNgBf5vLMQu9lw2mkdfXswR4F8xO0u3uMkYKNioY3TNvSDbbwx9unYjBw2iKgeWk73v+EOMzFvx16/V4GnnlK7pY4pz3F4xMxdaEBATgRkf59Y60WMzm/i7bcQYzOmp0vyXVDHSBckbO3f1QwiSDs1F1HTNDMB2yhKmyWcmSniuOCuTHiNqAd1PIpPUsXeHhRz9dGyYSWt6g0VAtPvpOT7El0RyguIvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcurntWljFabsf9xTfcX1B5g9bJ+JITr1GT/HWbNbmk=;
 b=KbeKNW4fOsaktCz3iHl3r42U3+pDn0LaWUw3L+cc6GE1pTxICYjva7UIdGJ+KzmI5c/pgLQ9ayf1yQyN6DwSElwmXmV6/KapiCWUJTrnxZh39nLQThl4UTjuCgpEf7JpvsGJ7DyfvzrLTsGVbWE9s4G4yEYX5Q1TCMoQCx4ZDffYDyvmtS8RlkziyS/M/9LtNQVX1tD7T6YQJuWanCfScS3uPS7gfBTgxfhXxxIlHeikWHHz1Bbd/yqvYsLJXuyKjQJP2GINutNrehbcTww7jiel12pxqyxxMpPJR9ScAJxLY0NO3IbgSZtDX8lARgJThfYDp6cpkAbyDCywItNtmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcurntWljFabsf9xTfcX1B5g9bJ+JITr1GT/HWbNbmk=;
 b=MfA6GcC4QyUkOxkf4UI0O8Xg46a4GhJwNgKfeu7Vppl5+XYQe8PgySSZgCVHny5sjl17Za5ILb/MFTbAzaFEYu1ISSF3nceNB+a3FBhJiGy8okJCGuxxN6+P3Kvk8bsGh4YVMAbIz2FdTaUS3Kkn3OIEkUo2cYHynj5fdyM0dkY18NBKDJZKw+W3rLzB31vvc8ufg1wQ97fFce1BV28IcOKTDF4F0juSEnobCQHDAtKPkTVMYMeqbGCv2dUR3STA9eRmUsJKI6UtLPoqgTUirzTI3bLRnlM32SvFhwGI0gZKvKrigPDdtnMebrvCgF2lsQHako8yxmLZIX4taOLmKw==
Received: from BN9PR03CA0859.namprd03.prod.outlook.com (2603:10b6:408:13d::24)
 by BL1PR12MB5945.namprd12.prod.outlook.com (2603:10b6:208:398::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38; Fri, 29 Mar
 2024 06:15:30 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:13d:cafe::fb) by BN9PR03CA0859.outlook.office365.com
 (2603:10b6:408:13d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Fri, 29 Mar 2024 06:15:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 06:15:30 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 28 Mar
 2024 23:15:17 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Thu, 28 Mar 2024 23:15:17 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 28 Mar 2024 23:15:16 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v4 4/6] iommu/arm-smmu-v3: Pass in cmdq pointer to arm_smmu_cmdq_issue_cmdlist()
Date: Thu, 28 Mar 2024 23:14:08 -0700
Message-ID: <5f1283471b5e0fe415afc7af3b6db7d06f21ff53.1711690673.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|BL1PR12MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: 620fdab4-09e7-47bf-2bc7-08dc4fb7a2ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aJIQQY59UzjpSt2z3+GRQqc1qgnt9a/hMUOc0WzRWp69MPiruTF/6tP3qT39DMPLKWoOaPMFQ5zYjUHXA/5qA83wqEaVIOAp4+7EN3i53VOsms5fbpOtsyU39ONsXRF7F5SREcyuOz0LJQ5Rf067MWpKAzLBB6j88rnofBRcZpgQuNBbx3bDNClTn9TtYritjjrgoNmoB3ijVP5DPs40TPhID8EFHLxs17ebozzQbMvRw/5qXouw1pvZZLXDan6pAnV6iWRe43rr1z98fs+UGL8755nEGyakDV/+xXSTr6wK7M90YYwtE5nh2kFAKkHj1XDOHGnWME3sTwlAtzTW+oADczD6w0XSn8Ure+icShupBysqw/1qpA8wmA55mD8wjvK2n3VedDVHybMt9q2m+BAKLGA76oLd0tR7G/emPTkuvrNByeQ2/92rgxHV7/0VNBvy6uewfMw6yt48YQaSu0AaSWRdVDmKtb0ZkqyqLzYT3PqxKhOZ1KSf+lca/Mm3fH2YfOnulgr2FR35Kr8yBP4YOLIEhiu6zE1k7YDQhJcPFz/C2yBlNG41Wqlu8zL9th5b2tjTwnZIaJQIv+as64LUxMX6T1X7M/X4IvCMYHh5Cu6AnZT8SbGNbd0SZVWPPMg6s0sNJPZjdx7Abd1hgLFB7JMXFkhsiLEbhGmbOQVzP8BktWvJ6G2XLmwkdfNyXS6b8NaK1i4TY3fqeUsFxbfIBo4slnPqEhexJyzJ/qgj0Hg/Ql/rg3hGH/BHD6Wa
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 06:15:30.5455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 620fdab4-09e7-47bf-2bc7-08dc4fb7a2ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5945

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
index 6cb20bff5a8a..7630c1dd5235 100644
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


