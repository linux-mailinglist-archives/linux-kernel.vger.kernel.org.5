Return-Path: <linux-kernel+bounces-142686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 749E78A2ED5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A18B28225B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982265FBA9;
	Fri, 12 Apr 2024 13:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W1xIpf42"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE74A5EE78;
	Fri, 12 Apr 2024 13:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927186; cv=fail; b=ISUuy9GJfS5N41mLJV3Vh0DWaCq/ZmiY4i+odvsz+jMAIN1vyfh1wSQT1LCMJuXVc8Mkeq/81i7qCOSkzmuWhGUPT21sgqgkVFuWp7TjVpmAhZ51Tmc+YZaavvA8fU8thWH5Hc4t81TqHKSp+0cR6itf6xOuJYNlYHc9fx69zhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927186; c=relaxed/simple;
	bh=XrD/OsG1cMrqmfPSB+ql0ZBIABmpRgJxzLhWPCpkcX0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NTJXtGavmUPpi8Ja27+sVTjdMz9SeDzNSlpLYZWRAih2DvB83rXw9/UB0oK1Y+28pZ/U7bYMhIiwjp9t66RoD48rqG2EIKEni7C0ELu29f00599j9Hwslz3JqlcimYFFlJ+mfiZ/Ll8yAoxpWf3KAUn6qGJs9mOoM6gygbjIuWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W1xIpf42; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIZAk7S4hdTh5dDWWqLCrbP9RfVMi+KjPjKral7abuNeHeI8Yc9RtWC8jZh+jDq+irkN5rBYu7SiElF9ks8DFRB121RKd5h/Vn1eQsJQFMeSAMKh2Mtd8zzFFeWAHqiIpZzanAN5kjz6o4jSuJmvmri6BHN6DVBw+I1F6+VKpva467zM8A+A+z4anfUAKdxsHRBl8sMpJOpeUHj665W0f+kTNioSfKrwneWiO5lDKtGSKmIXOFiC0+DACQqJK0L4/EUkClJF+enserQkd2F6ak59RzmURWtvDcJkcbuwA8TXrc9xg+SNWmX6SA4E6mwergVs8X6H7mhXX35lEs9aJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qz/4yIDcNubAgGxJ5dFXmG0Bpq5wJCZViuy0l9PzLqk=;
 b=hG+c5ZF8GV5qJEO4wQDe4cf0NPE/M05FIrmlSZUPwpLXgX7dMW9YotQqpLnTlD71MMqZ1Ha8X8ScV7CrRsqlnKdZMOe37cqJhWEo5z5i4WgsP9JPoCbvvizzDDccC/Qo3EbGvqcjRZEqR3OhbN7ABZB6YlusAoHUGQkyg+bNfluVlLCI2/Uz1xjXfhEBsn3OUx79P39Do/xWL16LE+TFwe5ecnjA9M6+koxQuo7Y+u0fWvV9yLqaaq6cZJfK/2ahsBAe1/LVB1SWCjEIU96wSSvAPmo9OC6XWDRDObXOURMLS4rWZ4keAOx+kWH6iN10Q9fA5np4REy6B2tTiTvYBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qz/4yIDcNubAgGxJ5dFXmG0Bpq5wJCZViuy0l9PzLqk=;
 b=W1xIpf42P+BxOQA68RNqP7tpW/Bx7O9Q9yZsxaBpEzSoM7gvJdruAH4eQ99JxU2BdF3RpTBF9FvvhasPMrrtdoEApeCDnPkIoWRb+TpTPznL5Zy3aYbdq+UhwCpUOuxQ5ThSkSXrjqsEEYx+ZXry8Er51inQuP5opnklOMdXGh4b/GSmcBZHqGgRFJzNXOxampZ1V8gs4ULLgOcBxnjRkwkagcyyLS9KDNRkCa1gKwxdb79tKHfrxysM0JweyzLg9qqecx56hh8xOikDH+7DO1nu7m609ImXdv1Ast+6Q1P3bWKmhruPyjx/WvvCgrPBUBhkSj1sU03tn7AEs4euSQ==
Received: from CH5P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::15)
 by CY5PR12MB6480.namprd12.prod.outlook.com (2603:10b6:930:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 13:06:16 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::66) by CH5P223CA0015.outlook.office365.com
 (2603:10b6:610:1f3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26 via Frontend
 Transport; Fri, 12 Apr 2024 13:06:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 13:06:16 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 06:06:02 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 12 Apr 2024 06:06:02 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 12 Apr 2024 06:05:59 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <krzysztof.kozlowski@linaro.org>, <robh@kernel.org>,
	<conor+dt@kernel.org>, <maz@kernel.org>, <mark.rutland@arm.com>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <amhetre@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [Patch v3 2/2] memory: tegra: make sid and broadcast regions optional
Date: Fri, 12 Apr 2024 18:35:40 +0530
Message-ID: <20240412130540.28447-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240412130540.28447-1-sumitg@nvidia.com>
References: <20240412130540.28447-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|CY5PR12MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: 49dadcf5-ffff-44c4-9795-08dc5af15665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ycNzGaB5lvO0HeMKtyuigNihSRgK4vA6Nsk6OLv+W01WqljXnkf5vGVqXLYSbkdZxQxVevp7wPY66y9s+LmvZJOpuB22BbjMkILm3uuytyL0gi1+U+s8Az78OK3JIRYL1F0h/uRfwZkLPou6a5O6CLuROfW9S2vqIMx/O5BckjD+rwEOay6jN54hGY9cgFEI56X3GW+k2Ot+ZIAV8FNRUoe7Q9XmQbFEVXt8RLG7frnffU3xrOuRnu30S7MzsjoOGh4IX5qWkeVTDonpN8Kt2S9owhLZIO/9+thYuSqzxPMbJjQT2B/hOB8Z89xBAiLDZsGbc2q+599zkh0cX1yjnt3FRrwPHkH0voDnIq/ADy1K2RtsGqCSpGujrwnMi7Gnc6RhG7A4Zw/Ui09RGRWlZolI5Cs0jKHrfNwcEZylSN7rsLbOgZ4l25kR13VBJ6W5faod+wkwkdFqjqlctUc1kCa7rPOUHXAU5wkmTiRH+13yPv3AeUI3dd9pkORA9Nn/GyXqJY8yP7l3dRka3/U0Ep2PZ14obArd9Mf3CrXhcoC/jRwvIB2vNKP7iVqBVIjR9jKv3dqfY4bw682OpHeJZTnYlf7VV6v3xMJC0OSPyFsOL1YHnD0tzZ8KCxSgfxyCKOPTUSrPJGLsQJCwqA6J0rX9at6Ls9mLAZr0dr+eO5+1Z8BNFVsU7s+sIlzwxgOCKl7TAIl0i+2Bg7ip6g9Lswlga0ymZ1vsGU1cU4GBwh6zcTiFgs1x2ZveVYNYqeIe
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 13:06:16.1322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49dadcf5-ffff-44c4-9795-08dc5af15665
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6480

MC SID and Broadbast channel register access is restricted for Guest VM.
In Tegra MC driver, consider both the regions as optional and skip
access to restricted registers from Guest if a region is not present
in Guest DT.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/memory/tegra/mc.c       |  9 ++++++++-
 drivers/memory/tegra/mc.h       | 22 ++++++++++++----------
 drivers/memory/tegra/tegra186.c | 25 +++++++++++++------------
 3 files changed, 33 insertions(+), 23 deletions(-)

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
index c3f6655bec60..7e7bd3e09cdc 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -112,25 +112,27 @@ icc_provider_to_tegra_mc(struct icc_provider *provider)
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
+	} else if (mc->ch_regs) {
+		return readl_relaxed(mc->ch_regs[ch] + offset);
+	}
 
-	return readl_relaxed(mc->ch_regs[ch] + offset);
+	return 0;
 }
 
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
+	} else if (mc->ch_regs) {
 		writel_relaxed(value, mc->ch_regs[ch] + offset);
+	}
 }
 
 static inline u32 mc_readl(const struct tegra_mc *mc, unsigned long offset)
diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index 1b3183951bfe..716582255eeb 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -26,20 +26,16 @@
 static int tegra186_mc_probe(struct tegra_mc *mc)
 {
 	struct platform_device *pdev = to_platform_device(mc->dev);
+	struct resource *res;
 	unsigned int i;
-	char name[8];
+	char name[14];
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
@@ -55,7 +51,6 @@ static int tegra186_mc_probe(struct tegra_mc *mc)
 			return PTR_ERR(mc->ch_regs[i]);
 	}
 
-populate:
 	err = of_platform_populate(mc->dev->of_node, NULL, NULL, mc->dev);
 	if (err < 0)
 		return err;
@@ -121,6 +116,9 @@ static int tegra186_mc_probe_device(struct tegra_mc *mc, struct device *dev)
 	if (!tegra_dev_iommu_get_stream_id(dev, &sid))
 		return 0;
 
+	if (!mc->regs)
+		return 0;
+
 	while (!of_parse_phandle_with_args(dev->of_node, "interconnects", "#interconnect-cells",
 					   index, &args)) {
 		if (args.np == mc->dev->of_node && args.args_count != 0) {
@@ -146,6 +144,9 @@ static int tegra186_mc_resume(struct tegra_mc *mc)
 #if IS_ENABLED(CONFIG_IOMMU_API)
 	unsigned int i;
 
+	if (!mc->regs)
+		return 0;
+
 	for (i = 0; i < mc->soc->num_clients; i++) {
 		const struct tegra_mc_client *client = &mc->soc->clients[i];
 
-- 
2.17.1


