Return-Path: <linux-kernel+bounces-54836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AA384B440
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF18288D6E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C64135A47;
	Tue,  6 Feb 2024 11:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SbJYzPp2"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B4F6DCF7;
	Tue,  6 Feb 2024 11:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707220161; cv=fail; b=Oto3bTIxuBnAFJKy7kXrF1JqHyOmX7eut5hcWp50riC58QOrESWdsf8McCNm+wGRBfIssRdobuimu5dZpj41rNrUZ5lB+/9xiBvj2x07/2lh1sVCYHnjXG2VbXJ52TvF59eHjoYr6fyKI28+EPyu90EnDu9w4cccovpXIccV6AA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707220161; c=relaxed/simple;
	bh=OoDJ8yMQHJcg25QloJTbWWQ1elVKmK4prq6g1nkpF2U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Epv0cKCUcpT+z3ZvyLZx0GSUbUXlUlJGvX5+sE3gBQfaGDcukXhrdEaI352yPAHsl2p1dBu4X1xCd3Hs1FW8r8EFlZd2JT8CubC7Y7S7sl0MYUAtWw0Xsv/GTWE+GDgrUv7Muk9/pbRfGRRn8peIE/yENfJ83xa2s3dCIQj3+yI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SbJYzPp2; arc=fail smtp.client-ip=40.107.101.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWHUZmjqX9oAxGzfeGBB6yQOLP1IQ09WqVjiH86siilIWAmLMcFcj40La8OTAPemUiMgScoABvqyS02HsPLMCu1PTxSzQK4uOutSjXWgJHOvpWbQs8QN95VnXh3/W8fGqsB68KXMSTiVD+o9FShnrjaMxFcfd+D82HFRwQWsufBR57ZpP3rr6OHePm2czwCdBEqwp9D1NRfZBPfnmZE0sdDKCZWa459k5h/9ympvkIU4Qy93im+kmeEau9VNYWlWlHOnlTUKOSMU3TdUiGOF5jDWkoSA71wbUMGzkDOaXAEqJjj52x4inM2DzQkpTXs236IPMeIgTsqIFCAsE1kKgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emTUHxJY0T+TFBlYA2byvT4Ib94x7/1m1l84cDhhjko=;
 b=dCe2R+5aaDOumAgzkkWHCkGLZQj0aqKNZgeT+HIJQlHcdPY5aq6+MPyEMhbzaQkA/seYNLuQvkacO+NB7twuE4o0CyBz44fYns+6C0PPBVGr0t9ArL2fMdK+hJl8m3WG6FVXxWhLWP5cK74c1AI26NypI3SqBW1irrlZyh6oWOsqbE06frQhc65DoTT9F6PL9f77VrkoAgU2xcukBJIo3T+NRpVVeNhx4w7qK+LnoqdDk4urEVynKvowQpaFDaKrClwO7AKT8x4GcPSYsTZYJbLqv9cmP2gF9y6PIxumyNRcqveXGgtCzptX/FpOJGRuZTp1RDfJfuE7hC0FaIqV1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emTUHxJY0T+TFBlYA2byvT4Ib94x7/1m1l84cDhhjko=;
 b=SbJYzPp2D2iK4AP7Go7M+j+MSY2B02WM8nDwzdAjW7x2FUNR86u7XaX6VWFJgtowDHtmjtSW/AuPREKcUF6zgZci83SaKPaFhNQZTiKAxKuB6rU9oaikj+wcWqPdgyAlSSGFRhhi25HnvX0Kny8FqLfGDxedrjgiOipdWxAkYcCgyywzOXF9bC/z4c8T688UVGARZgW6mwKgQk/6pDL9xjNX8lRQS+/Q531tmjWPe/l6YjFtf5ZwnqggiyBhwlLQq44n09PT+asUj+1IoyKFQUgTBS0tKETgq4G4rqtV78rdZuNFKL2gZEjiE8VfE7cRGjidGlCQ/F+XmKAERPav+g==
Received: from CH5PR03CA0001.namprd03.prod.outlook.com (2603:10b6:610:1f1::29)
 by SJ2PR12MB7919.namprd12.prod.outlook.com (2603:10b6:a03:4cc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.8; Tue, 6 Feb
 2024 11:49:16 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::e5) by CH5PR03CA0001.outlook.office365.com
 (2603:10b6:610:1f1::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 11:49:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 11:49:16 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 6 Feb 2024
 03:49:04 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 6 Feb 2024
 03:49:04 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 6 Feb 2024 03:49:01 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <treding@nvidia.com>, <krzysztof.kozlowski@linaro.org>,
	<jonathanh@nvidia.com>, <maz@kernel.org>, <mark.rutland@arm.com>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC: <amhetre@nvidia.com>, <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch] memory: tegra: Skip SID override from Guest VM
Date: Tue, 6 Feb 2024 17:18:52 +0530
Message-ID: <20240206114852.8472-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|SJ2PR12MB7919:EE_
X-MS-Office365-Filtering-Correlation-Id: bf71aefd-7208-4bc4-6a52-08dc2709a569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ggXTJdQgKpZS1qOOIJkmdDuMOMvRihPyxnVyS+qvJTaG9UIFwZ9BBj4X1Xn99yCILAyghzpxTE1gfS9qqYfC1dfau1g1V6Zb/n527EpCZeRtMleS79sHnaP5JtNVI0s/Zj4YhQRkio9W5/MjQPLoOqyalu8rxfPpCgfr4z4vkb0+Yuqx8CAI2aEmlgyE7e9buP5AsPMjrwOS/oVwsk5V3UnSFCIAAOmfJlJt7Sj2xBsw5PDd6zXnCsDk5GhXfXCdgggtSJIQ5l33ZYImHpKA/OeZgiUWGQybsNy2k80ZfwCMscLeIBIBP/oMhaFthFNdR2RhbbQxM+OW28FRNDazx85U0G5UvZVrpBk+yLOi90mh2zRDpUPt1D9EGnepTZD7DmMNBE4kFLBHklETHDbZbFg9nt9/Lvw5rrOC0m31zR0wxQpPO1XvXBDSoOB7FTN4ezPpzbjuDWkTqejApHBUbk4g4I4xHlAHi2AGEKSB5vq2e/GdhJHney8asMAkseMTmcC/9MnyJoGimzXw10I1UHar9MhU3hxG9lsAaw6HqGTfGIbnGbUMRV3M1GXrQTz5xnOUQyfm6uOuEFwDeCBhmkW/NRKWS09wg8U1o04gMqNFEiOZyVxV/GIGOm9DB34HNuaKnRVe1/w+JT1fuuN1xqTyMm9Vk/Vevm7lwf4dvyQaJnsNQqbEvlMLRLAX1f9FTfMPQ6aqRyqtlLsRBkFyUhBNoZIrI0yX0Vvc8Al+o8rCdi5aJmY2joEJItriYYvXLtKZ4MRlROR3k4aQ2d2xbw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(40480700001)(1076003)(40460700003)(2616005)(26005)(36860700001)(41300700001)(336012)(356005)(107886003)(478600001)(54906003)(316002)(83380400001)(7696005)(47076005)(6666004)(426003)(7636003)(36756003)(110136005)(2906002)(70206006)(82740400003)(4326008)(8936002)(86362001)(8676002)(5660300002)(70586007)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 11:49:16.1543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf71aefd-7208-4bc4-6a52-08dc2709a569
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7919

MC SID register access is restricted for Guest VM.
So, skip the SID override programming from the Guest VM.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/memory/tegra/tegra186.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index 1b3183951bfe..df441896b69d 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -10,6 +10,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <asm/virt.h>
 
 #include <soc/tegra/mc.h>
 
@@ -118,6 +119,11 @@ static int tegra186_mc_probe_device(struct tegra_mc *mc, struct device *dev)
 	unsigned int i, index = 0;
 	u32 sid;
 
+	if (!is_kernel_in_hyp_mode()) {
+		dev_dbg(mc->dev, "Register access not allowed\n");
+		return 0;
+	}
+
 	if (!tegra_dev_iommu_get_stream_id(dev, &sid))
 		return 0;
 
@@ -146,6 +152,11 @@ static int tegra186_mc_resume(struct tegra_mc *mc)
 #if IS_ENABLED(CONFIG_IOMMU_API)
 	unsigned int i;
 
+	if (!is_kernel_in_hyp_mode()) {
+		dev_dbg(mc->dev, "Register access not allowed\n");
+		return 0;
+	}
+
 	for (i = 0; i < mc->soc->num_clients; i++) {
 		const struct tegra_mc_client *client = &mc->soc->clients[i];
 
-- 
2.17.1


