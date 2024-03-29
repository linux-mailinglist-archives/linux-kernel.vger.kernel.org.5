Return-Path: <linux-kernel+bounces-124183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C5A891384
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF94287D4B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11133D549;
	Fri, 29 Mar 2024 06:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="amisSJm3"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE183EA64;
	Fri, 29 Mar 2024 06:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711692933; cv=fail; b=UwUVctI/wBBHObXr2Y40GPeHyrus6xLvCgUEk/QH6Zs3uFJGRHzBolXo93i30ptxj1X+lYxJd7DIDHiLhrGRJwM4Umk7Kj9yuLqPdihaT+lEGcbneQ0I8b5bMQToFWBOVqIkB6fxvcfdWvJKQ8biteOJ1j8N95y3zqSnJbcj8Wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711692933; c=relaxed/simple;
	bh=ez+sk0p2gJBMABB8oQ7oIf/fnj2URWATt+NEELtwNG4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MutaDab+WJBPoWrGC9zPps5u1IksI0vtG0/Thv+4iFdyO5PYd3F00uNQUt2FaVvFa0rgrUTnB8sdBqr3ZzHQHWcrxmh/ICwOTUmMFt8teHjrIaUgqDEEasg41nRzgbWvfZc2pJuQvwVCFac+czrR5uWA2qfWKYYWutEhptRMZvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=amisSJm3; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qi96cVR2DRsaYA6hQCj+m4VgZTK20OGyeuW4DTjlPgF1d6EVtAX8h5Mc05PD7rJcJ40IriyZieM2FQxSzTDohJM64wKGxKRMsqY/5nxVKP49m5BzRvNM+E4SRj2UXAfoN7dX1CEDd8uiPkTcos/d44MDnd8qDdo9bgnQ9zn0HIVgxoFwHOrXEiIlPUxhUwTvnp0AdHwdWVTIsQVTDpEMf9Wi8iZ7QdmJ5YoNxkK42BrhPuHj35FHMLi4SFY4AOAIKCDSaKuYTLZp8baOUjb4xHhzxzmR9LiY0SohsfI9q3ZelICK/zf7tYMtcGqYg4K80MdN4hlt8D+L45owUPnV1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuuLxMzEvDctqxAwqaLasOXBtsTJWU9VsIqTNzStANY=;
 b=BcBWYXmYbbG/JtVlypvm/RlLYluvC81ng1VeCPSNId9Ch4YdULbdTcQyv/j430NmQyoeij7H5o09AbZyfK8bhQQy1kxzPPJ8X+ppyJ4bJcHYBOx7C2HGmpV70c1zUAnJ7R3xA1suT5e7fiRUQ5RhpVBJYYBl8Ag8UzQ5VnU9c1BBDqH9s/KiUN/9s2pI1JGV7xzCx6uTcTvL58kre9rnQqiqPIbmLNzyAzHD/EQ8TGjdG76QICI9ltY88KVdbP+JWzbjnRXez0UfevZIm28ehN0oRuFfY2Cp1WjjJwbog5efuLo1c7B1PEGvnH5sNB/pqOQww3898ECgwJ90y7yWHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuuLxMzEvDctqxAwqaLasOXBtsTJWU9VsIqTNzStANY=;
 b=amisSJm3svD8JDBzkHINDP+Q5JdL/UQo9ptPKHAGPVYrseCnfLZrxjMqdU4G81XsjhlQke0D8Lf9v8tnGiPIapViwhmSZJpAPfqvvPs5YkLOnQtlH/pasS12Dciel/lPpOgQ1wiAPhy3j3EJia1MgTBxQRZfkHCvAs+KzQlJZwoWMOY0zfcdve5prW9vbEzFQCmTxR7uuhID5dQ0Ii9aN8JZLxZqyBSoUKPBxyvfaR/LMXBpxBh6crxATS1FktiookBll3EIt1IAsSsD0cc55B9FnthimsrmS6yP0M6R736zXwuZYQnestDC2mb3SmnywuqOEgeU9+IctpoNgcxyAQ==
Received: from PH7P220CA0091.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::10)
 by MN2PR12MB4343.namprd12.prod.outlook.com (2603:10b6:208:26f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38; Fri, 29 Mar
 2024 06:15:25 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::38) by PH7P220CA0091.outlook.office365.com
 (2603:10b6:510:32d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.41 via Frontend
 Transport; Fri, 29 Mar 2024 06:15:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 06:15:25 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 28 Mar
 2024 23:15:14 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Thu, 28 Mar 2024 23:15:14 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 28 Mar 2024 23:15:13 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v4 1/6] iommu/arm-smmu-v3: Add CS_NONE quirk
Date: Thu, 28 Mar 2024 23:14:05 -0700
Message-ID: <6e1704f99d8f31b7abe653fe95f459377857937b.1711690673.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|MN2PR12MB4343:EE_
X-MS-Office365-Filtering-Correlation-Id: caefcdb2-6aa3-43a4-d929-08dc4fb79f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AUkP+oRyt0zynWwQ6GRHj+Q6/y0cV+qT0I0RnaJKu+hiPl9TDeTdmi20FpUb/hU/u+Szb+nREKZ1xco7NA0QlUKK8O6HoN7xTX6778o+ViecUPAfD6akxugGk85+XAJEjtPneJEbjuCnbyDPSnoFwvWUP/qfEXeyV25suyEH8kL+2muNjrqenpFHYoNq3olLIVqfHrMlxX0tCDnmH61v610er253pW7rbFHy+ABvsU5069qW9NbtV7gEVy9b8EE3lIqLLQPlhuOZYL/Gbpf9ySHIPC7OMPYkIMRA1CuIgKMs08lndvTQ+idn25MOZA1mvez3nBaJ7krN5IiMaMoous/HpUqEOwHMdAxHn7JVFz2rOV1ISXmSKbn7lw0In+M7Y9SkOdLvquW8/edfZKUxUn1RizqY0OC/if/YOMzluRxJmYap3G/EAgCEpRWqzO2kTajA15EOhfQBHQowPeHxPXKiCMZ9dZXKJif4pDsnrxhQnUFOdH+YKlrHptUekQd4fHajXvAsHJ0E1AsVYj0oNTrAxjXqqJpeZkV/gSmwEsIxVGI0Z/wC58+sV/bxHzSIGpnxjMFAiGRTJoRzLQY+QPlOWdunBOynFw4tRHPpuNqd4nMFy7ajjRCyp2uMx4pkXYBVOpaLrXZQI/6sofhgYhzmoZXcJpXKobUuHbwaBJ4qegf6UQvu1gi3+2GsnahvTatWCWqtMmyTUHc9HdcanHok/YiOumC6e2L8lhcjvFddPgAi8w3qjdFuN4zQJ0m8
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 06:15:25.2148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caefcdb2-6aa3-43a4-d929-08dc4fb79f80
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4343

The CMDQV extension in NVIDIA Tegra241 SoC only supports CS_NONE in the
CS field of CMD_SYNC. Add a quirk flag to accommodate that.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 ++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  4 ++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5ed036225e69..da3957ad95be 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -334,7 +334,9 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 		cmd[1] |= FIELD_PREP(CMDQ_RESUME_1_STAG, ent->resume.stag);
 		break;
 	case CMDQ_OP_CMD_SYNC:
-		if (ent->sync.msiaddr) {
+		if (ent->sync.cs_none) {
+			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_NONE);
+		} else if (ent->sync.msiaddr) {
 			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_IRQ);
 			cmd[1] |= ent->sync.msiaddr & CMDQ_SYNC_1_MSIADDR_MASK;
 		} else {
@@ -371,6 +373,9 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
 				   q->ent_dwords * 8;
 	}
 
+	if (q->quirks & CMDQ_QUIRK_SYNC_CS_NONE_ONLY)
+		ent.sync.cs_none = true;
+
 	arm_smmu_cmdq_build_cmd(cmd, &ent);
 }
 
@@ -707,7 +712,8 @@ static int __arm_smmu_cmdq_poll_until_consumed(struct arm_smmu_device *smmu,
 static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
 					 struct arm_smmu_ll_queue *llq)
 {
-	if (smmu->options & ARM_SMMU_OPT_MSIPOLL)
+	if (smmu->options & ARM_SMMU_OPT_MSIPOLL &&
+	    !(cmdq->q.quirks & CMDQ_QUIRK_SYNC_CS_NONE_ONLY))
 		return __arm_smmu_cmdq_poll_until_msi(smmu, llq);
 
 	return __arm_smmu_cmdq_poll_until_consumed(smmu, llq);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 23baf117e7e4..b95d9a9ae0a8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -509,6 +509,7 @@ struct arm_smmu_cmdq_ent {
 		#define CMDQ_OP_CMD_SYNC	0x46
 		struct {
 			u64			msiaddr;
+			bool			cs_none;
 		} sync;
 	};
 };
@@ -541,6 +542,9 @@ struct arm_smmu_queue {
 
 	u32 __iomem			*prod_reg;
 	u32 __iomem			*cons_reg;
+
+#define CMDQ_QUIRK_SYNC_CS_NONE_ONLY	BIT(0)	/* CMD_SYNC CS field supports CS_NONE only */
+	u32				quirks;
 };
 
 struct arm_smmu_queue_poll {
-- 
2.43.0


