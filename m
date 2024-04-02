Return-Path: <linux-kernel+bounces-128043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59170895557
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C36511F2227C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8788062A;
	Tue,  2 Apr 2024 13:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F76CphT7"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE13839FF;
	Tue,  2 Apr 2024 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064439; cv=fail; b=UREnTnP7KN3McG4/evilWLvJPgEJsEM96S9Nadz++4WRlmGNy9D0A908t46ieLntnRjSqlxzd5wC4XuRIvHJCl5y+DXZjlrnKkWMBoJS9tUiDZ7EOar9BtBsRJFpHar2UHMdDJCvG6IWbJxf5EgWwu0B1Kxgif1bO1b/LKeix0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064439; c=relaxed/simple;
	bh=AfyOKVCJCozES2/xUnhvj33utlmGib8PN1FCS1K72m8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KbiZPnZFNgHnBxYuWrRwvYGNYg5CBmwWAYX+9SiiBtTCOcSI2vcqxV392uBhTAuz9nZM6YFT8E7EDEyB97iBryQbJ7clNBIGb0tXqOQ5LOM66T+5zLJe6qXXPmlX0UwlaH2cFLXnzfpcq0Mcgd37bUaumAYLmG1kf9uPTx+x+CY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F76CphT7; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjEusiItjuK43g32l64P8Yd91dhA4PHoI+dM7Wqf+3p62T3Wx690qVWtV8X1Lb065VXb1BUoBMIq0Wsyx9A3BGF23H1TKlyyySnSv7mDpwVzxJ6NWbCp796BFwxADkZXYRSPIqfaHfZJAxDn+3klB5StCZB6c9/Ya8wNrA0Xf+XcKxHUbuekxtZIMdpb8uM5hRkWzSwuiaNfgZb0cQUemCj/9RgUKOTFHszdIH5fBzU2kMIv4F2CjJ954r4TlWVeu6PQs64nOn59aehFczZ3RtlIRnRsE+5ZmpalWTw6qtirD6tioX4Ae6yotOyPg0ge+bBXWXGBLBgFhgrFpz0gkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8m4L4qqc93m1QdlP6YP8vz59+Lor0V+APuQHFosojYo=;
 b=Yr405bV0jsEcI4BABGjuuTysVHgj6+OIWwuR5pb4P/wohh9UIZcs8S9WboTvh1oL5ioyN+DRD8nVeaZdTAfkI9jsol0xMfrajI686In4AU/WufW6qzJ46ATsw5IqxcszXvB6IWn/hktcb324NSoAh3xC07uppURNTxHTkUSAYwlBgqL5J7E1tUH+At0fJzxIImDc6qRsOA5T81RjB3yUn59wFcg3z4nSGRD4VZsISoPTZ8jqMtS668YGBJbwvaIbXS6mDkf5BksBr8LK1IDpr31Ha2au8matn+DeY9ClFIHcXdbuO2+brgG9gKAEvYkcXVkw7w8WAf9ptjy67vKLjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8m4L4qqc93m1QdlP6YP8vz59+Lor0V+APuQHFosojYo=;
 b=F76CphT7X20bthdMe5wBLLzNotHcG4Z93QfPImQyVXTiwV6VWaV5udNSNjAb/YbufEQW6ndBvgSopOJ65hgnwaFudkJ1dyfUosQW4eZMeJ+ShZxcX73/R7/LoeaD8Mo6PlfNYaeMNGAyanhUDXnA0GoZycn0vZoxuzOJUubkj/i4OcMIttQgiL6qq/UtzkhJX8oVHXY/4XQIM7XzIDPso+oE4uWBslQYMAuNTNCszw1sKnueiLaywD2zi3kLbx7+XY/1TEOHRbdsgBfCp6Sq+i+u97k/iOMBPohCysmBw+gaEYy/a2O2Xz68embsYEK97tvcVqL7z9QRW9qTk3CVbA==
Received: from MN2PR15CA0041.namprd15.prod.outlook.com (2603:10b6:208:237::10)
 by CY5PR12MB9053.namprd12.prod.outlook.com (2603:10b6:930:37::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:27:12 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::f3) by MN2PR15CA0041.outlook.office365.com
 (2603:10b6:208:237::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 13:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 13:27:11 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 06:26:47 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 2 Apr 2024 06:26:46 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 2 Apr 2024 06:26:43 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <krzysztof.kozlowski@linaro.org>, <robh@kernel.org>,
	<conor+dt@kernel.org>, <maz@kernel.org>, <mark.rutland@arm.com>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <amhetre@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [Patch v2 2/2] memory: tegra: make sid and broadcast regions optional
Date: Tue, 2 Apr 2024 18:56:26 +0530
Message-ID: <20240402132626.24693-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240402132626.24693-1-sumitg@nvidia.com>
References: <20240402132626.24693-1-sumitg@nvidia.com>
X-NVConfidentiality: public
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|CY5PR12MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: 94cf5edb-b154-445d-bb22-08dc53189a96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zonN2XtXM7mgrDW41lWzu/5g2uGGib1vVAsbHnr7KlLByvzKqMuILfuotVaVpStwuZ/evnVmTOuD0Ve+xDbvmpV3oCOuezhhvQtNsv5NpbqwN0dP0VZsqHqTxzK2BMDH0J3RErkuIx3vIfYJAfvS8oP9jURO/+TsGNwthGGsvI/rpC99+c05rDcT8tIAXEcmv07RrVnd2r7MyLWTqGNM8mh4UzDiA7Dr2zTjL87wNRWW0fPH2GVXaiEs7QFpniiL+JTQacHs+SWHAIplYTXOjF1exj83zjcUSQ9JeIK2p7zC9s0yD0kvVvrBTt/f0S/EsbYZs+dOBO0l+i7kuIt/hiJK1UDX5TviXLwNwMbInRJ4RfStujngN1sxJ+koH31sZlJ0NgTlkI+pHq0Tdp7GHILi+bPPKsUCIcdNclHTcw38Q/UcqWXUE77x8PP7hc7aOPh2kowkuZwXMbvOHqpKf6OGQ7xF/yn/TNaGM9NVAg7A0VfsuL77ODqFRHmqI+V5Ev6Sc3c1ps8AHQtekWI48h2PTUWl4KpJvag5wTbguwzpxYTRCAZ7HzRoSaeUQXIvrwdW4imjPy3THVwmR2wAwZ4HmhB/nCAJ5ALwuvVuKXEwPdXwFeB64mJf9UQNCCYJeud8hr6W2WXqxyXUt7m8gMUTqPWCnYDlqGpU+TBeSQo9aU5QMMd4aDm26/sj3uHadJN7BzE9W/72QOMydjuuHD8DL7hBcbm4kVfGzwNAxe56CsY4666z0wjqinIvc6mT
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:27:11.5626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94cf5edb-b154-445d-bb22-08dc53189a96
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9053

MC SID and Broadbast channel register access is restricted for Guest VM.
In Tegra MC driver, consider both the regions as optional and skip
access to restricted registers from Guest if a region is not present
in Guest DT.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/memory/tegra/mc.c       |  9 ++++++++-
 drivers/memory/tegra/mc.h       | 18 +++++++++---------
 drivers/memory/tegra/tegra186.c | 22 ++++++++++++----------
 3 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 224b488794e5..d819dab1b223 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -899,6 +899,7 @@ static void tegra_mc_num_channel_enabled(struct tegra_mc *mc)
 
 static int tegra_mc_probe(struct platform_device *pdev)
 {
+	struct resource *res;
 	struct tegra_mc *mc;
 	u64 mask;
 	int err;
@@ -923,7 +924,13 @@ static int tegra_mc_probe(struct platform_device *pdev)
 	/* length of MC tick in nanoseconds */
 	mc->tick = 30;
 
-	mc->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (mc->soc->num_channels) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sid");
+		if (res)
+			mc->regs = devm_ioremap_resource(&pdev->dev, res);
+	} else {
+		mc->regs = devm_platform_ioremap_resource(pdev, 0);
+	}
 	if (IS_ERR(mc->regs))
 		return PTR_ERR(mc->regs);
 
diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index c3f6655bec60..5cdb9451f364 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -112,11 +112,11 @@ icc_provider_to_tegra_mc(struct icc_provider *provider)
 static inline u32 mc_ch_readl(const struct tegra_mc *mc, int ch,
 			      unsigned long offset)
 {
-	if (!mc->bcast_ch_regs)
-		return 0;
-
-	if (ch == MC_BROADCAST_CHANNEL)
+	if (ch == MC_BROADCAST_CHANNEL) {
+		if (!mc->bcast_ch_regs)
+			return 0;
 		return readl_relaxed(mc->bcast_ch_regs + offset);
+	}
 
 	return readl_relaxed(mc->ch_regs[ch] + offset);
 }
@@ -124,13 +124,13 @@ static inline u32 mc_ch_readl(const struct tegra_mc *mc, int ch,
 static inline void mc_ch_writel(const struct tegra_mc *mc, int ch,
 				u32 value, unsigned long offset)
 {
-	if (!mc->bcast_ch_regs)
-		return;
-
-	if (ch == MC_BROADCAST_CHANNEL)
+	if (ch == MC_BROADCAST_CHANNEL) {
+		if (!mc->bcast_ch_regs)
+			return;
 		writel_relaxed(value, mc->bcast_ch_regs + offset);
-	else
+	} else {
 		writel_relaxed(value, mc->ch_regs[ch] + offset);
+	}
 }
 
 static inline u32 mc_readl(const struct tegra_mc *mc, unsigned long offset)
diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index 1b3183951bfe..7b5e9bd13ffd 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -26,20 +26,16 @@
 static int tegra186_mc_probe(struct tegra_mc *mc)
 {
 	struct platform_device *pdev = to_platform_device(mc->dev);
+	struct resource *res;
 	unsigned int i;
 	char name[8];
 	int err;
 
-	mc->bcast_ch_regs = devm_platform_ioremap_resource_byname(pdev, "broadcast");
-	if (IS_ERR(mc->bcast_ch_regs)) {
-		if (PTR_ERR(mc->bcast_ch_regs) == -EINVAL) {
-			dev_warn(&pdev->dev,
-				 "Broadcast channel is missing, please update your device-tree\n");
-			mc->bcast_ch_regs = NULL;
-			goto populate;
-		}
-
-		return PTR_ERR(mc->bcast_ch_regs);
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "broadcast");
+	if (res) {
+		mc->bcast_ch_regs = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(mc->bcast_ch_regs))
+			return PTR_ERR(mc->bcast_ch_regs);
 	}
 
 	mc->ch_regs = devm_kcalloc(mc->dev, mc->soc->num_channels, sizeof(*mc->ch_regs),
@@ -121,6 +117,9 @@ static int tegra186_mc_probe_device(struct tegra_mc *mc, struct device *dev)
 	if (!tegra_dev_iommu_get_stream_id(dev, &sid))
 		return 0;
 
+	if (!mc->regs)
+		return 0;
+
 	while (!of_parse_phandle_with_args(dev->of_node, "interconnects", "#interconnect-cells",
 					   index, &args)) {
 		if (args.np == mc->dev->of_node && args.args_count != 0) {
@@ -146,6 +145,9 @@ static int tegra186_mc_resume(struct tegra_mc *mc)
 #if IS_ENABLED(CONFIG_IOMMU_API)
 	unsigned int i;
 
+	if (!mc->regs)
+		return 0;
+
 	for (i = 0; i < mc->soc->num_clients; i++) {
 		const struct tegra_mc_client *client = &mc->soc->clients[i];
 
-- 
2.17.1


