Return-Path: <linux-kernel+bounces-143547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9A48A3AB8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289161F24960
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4A41C68C;
	Sat, 13 Apr 2024 03:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZZycDEVK"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF75718EA1;
	Sat, 13 Apr 2024 03:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712979852; cv=fail; b=lXB8h3EL3tgV4d91es1P0PeVZ6+61cQkvV4N7jgip7zi3SByGx9i9iJbIQ6InTSwP0lN7TNB9qBR+ITLDL1ms8T1R4W4EGrM1srxgWMGqVYmJ/Ikw5tBBv6mFZHnmaWWWNablvpRmyZENo9kLZsmcizcqnfHnGsiAKwq6AISirM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712979852; c=relaxed/simple;
	bh=PscgOsnjfMK0vzkpfbaPAWSJuKItfyM3GvnT5fB0MtA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ReqyjB6FtYcK504M2ZRTAryUhduAR8V8TM9KGY5iDjAu3tE8JBs6v4QKFYoIAvNEAXYVirxNqM4EHfk50GxY4ye4mC4icwFQH4rXCYI2xRK4gDXUNpBJIMYzsPBCxZQs++92OJB61/n/oTi+jSYpnvxgxZfTQDpFvQKQfZytRZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZZycDEVK; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kViBV0nKlG68zTR/sDPXLp8ZfHGgyY8KO6Tlmwu6IhtKCvmPgdL17RD8U4aEAeTILqPJ/1uY+tHAfdAwMETplZCua/newj13Q1o4eHkR9/u9n++ahw5vmWXxpP9xdPbr/IXnUj2ZpPqnYgHyeu1mvg7upQRT7rMljY6bDBkR0VjuNn/L+5ORwWkvqAtRm7CM/5Kw3VjPQmsQlwGuuoV7jAPt2Btk6dhaki2VDa9769oMPTX1FaoKCHjxov64D7zXKu2p23jdDvOAoSzmjwngrsMBhYLxTSgw7KlRsRPGbWlVZV+EpLMspuh9dophEb+v7yNAe+CR2/byL12fmyTm3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+FAU8eHAJiqZw2YnhJMKtOC1Zm+6m+pbOcAVNdTDos=;
 b=XB/RCxRBvhUmVkyiu7n8CucHqkbQk0LO0Q+BZjbxc2dbejASOzn2zN7WUDR371pUW75pL2dxx+webOYNJAaEOK4z9z6MJGJvvqeJevQ9/BgIOUvyQhrB8qqKK0E6mWLRPhgAzPnoXJ7hzKlKejO0xaVz2aXMDUzl2YpqkpuvFngHZfEop6aHOqvbjbuPWBzSaqEYHan/XnI+Uk82fyNratFrl7fzi9cjNTZM0BEYdnwV3BYR2C1LM1lnWOxpqP4w5914wc+UYZ+SFJuKBrcs1p5mspPSONEgnjMGON8VKQE3m0zsQzxNEnqPJpH1mfY1BT/8X8VhaMBivLw2aX3jww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+FAU8eHAJiqZw2YnhJMKtOC1Zm+6m+pbOcAVNdTDos=;
 b=ZZycDEVKfxodU7KMf4ODjrLxdnCMyeLW1xm+fjCYz3hz/T0t2Mxx9gKfObJmQgq492Oz/n5WwEEwyucB1UDjfhlS58KQtiRBfU60/oljwcByfjhyaiU68Lw7OWeXOeZaw+GvtnYz7I4Ad0Ok5gp5Tr96KVDh8pJcuFmv6tq0Ma0z14cT0et0/Kqvw9nLqTL7WRoWE9WR8S7jghUeej1PUM/X0y3dtmDxeIYOOeKEAtWYV3ziYXNmbaPnfx0p2KfAIMDeu7XQ1p67rQj2tn8WtuHXmjAHOpPnpEQhOExCot1VdjjChBJ/eFjVALMeg/8BtqkLCufoJLOsoK8Qgku4SA==
Received: from BL0PR02CA0014.namprd02.prod.outlook.com (2603:10b6:207:3c::27)
 by CY5PR12MB6552.namprd12.prod.outlook.com (2603:10b6:930:40::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 13 Apr
 2024 03:44:08 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:207:3c:cafe::4e) by BL0PR02CA0014.outlook.office365.com
 (2603:10b6:207:3c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Sat, 13 Apr 2024 03:44:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.0 via Frontend Transport; Sat, 13 Apr 2024 03:44:07 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 20:44:03 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 12 Apr 2024 20:44:02 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 12 Apr 2024 20:44:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v5 1/6] iommu/arm-smmu-v3: Add CS_NONE quirk
Date: Fri, 12 Apr 2024 20:43:49 -0700
Message-ID: <10a39a51cae4de9ef47580f0c4439fb6c5373588.1712977210.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|CY5PR12MB6552:EE_
X-MS-Office365-Filtering-Correlation-Id: 838ae515-17ce-48f4-bef0-08dc5b6bf8e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	USFqhPt+/tReIqLNBbV+CUkzMnh1kf8t6RI0chNKdBhQ5GNGx4EevQF6XaePgF8JDJvtBQJm2k9w3f6BfQM2FWE7I4YwsnUhEjyUQdd1D4aMJGsAv7+qVC7JN754GYNrQeHHymKK1FV014jLUZQFveq2DOLUnoAiS38LjGz+Wy0uXiDx2hcFQsmlfwb7CiFgWPqWJyubN2AUr61SANn9FD4YpnEfC8TFwZJ+NBy0txErbe4qTudpEyWP0xMtMUEc42MzlN+p0YvimLyL3GkLQ+I7kQ3h5U335gWKyFaS3eWmXBqJ0ZZ9MF6C4LjUGxe/5sYQejL/k/D+1UqlaEEc4B9V1SoZBP35np3iwIT4oCaW760SixUPZbgTS8nIqDbd9cNHH6nUm5xSVq21b1DeU+GMxjutMiXo+79jBdCtHaI5Kwazw2r2m1OJ/HFtVNUui42UnXG4kUkmUL2S1lpXSV9qw8lxDeA80nWHhlNgV2r+n9I6dPKpktM8d4xhm7lVSsn2QhumMUaz+8tD2mXOQCJ86mj1EUaDXRIVs1auH9CRt2pyaDCYTl0r2Kg4P/OsNIfJ/qhVOJsSGrbk2zHfRn/SlFgJJC9l0YjJct245VXzEUJ0GJe39SnMIO9Bpxh9ZuFm88cTnmulyYs3uXUXh5Z8XoxHojfc7YFJdDVGncA5Ji9e7qqmqdEr1dxLwMKiRa0e0WrOXOy3fxIihFEcdn+lW7rAjfvepj5CseGll0s/pEo+dTqk2EwIDtqg0xbd
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 03:44:07.3458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 838ae515-17ce-48f4-bef0-08dc5b6bf8e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6552

The CMDQV extension in NVIDIA Tegra241 SoC only supports CS_NONE in the
CS field of CMD_SYNC. Add a quirk flag to accommodate that.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 ++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  4 ++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 41f93c3ab160..385a6e72b2f2 100644
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
index 2a19bb63e5c6..bbee08e82943 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -510,6 +510,7 @@ struct arm_smmu_cmdq_ent {
 		#define CMDQ_OP_CMD_SYNC	0x46
 		struct {
 			u64			msiaddr;
+			bool			cs_none;
 		} sync;
 	};
 };
@@ -542,6 +543,9 @@ struct arm_smmu_queue {
 
 	u32 __iomem			*prod_reg;
 	u32 __iomem			*cons_reg;
+
+#define CMDQ_QUIRK_SYNC_CS_NONE_ONLY	BIT(0)	/* CMD_SYNC CS field supports CS_NONE only */
+	u32				quirks;
 };
 
 struct arm_smmu_queue_poll {
-- 
2.43.0


