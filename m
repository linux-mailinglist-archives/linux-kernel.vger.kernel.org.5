Return-Path: <linux-kernel+bounces-7942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FC781AF82
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CE1C28657D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0553617736;
	Thu, 21 Dec 2023 07:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RIiG0cie"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6BF168D3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 07:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtzWD/rK50ghZZK8oR9AK676qsaruKKBrx+iuOJH+NTyzBgVZVl5MbuFywHY87N5d3gnJjYuhyUC2xUG0OXXS6yAqGcOjDV3DGSr0RnPa6TCAiWszvWtoPd57GpGbymK0p8FFG8EAckhriImChJ8/llTI6DtgvurTVmpDz+nIahq2EjhlllSZl/HQBSKPzEQ2mK//1zY7FTh2y0zrf1Fmk4Ax88GTztwigLzQdjs1g/t5eJUN5S3UGWXdqYR1C/KLorIg8ctILIL2FbgGY7YlpvxAzKHiSDVLgAqoudu/VVus0YJz83dJ0rDkgYOZNQ7dqOBMIxD9FhXWWIsK8fRNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJivtawyCIrVrea1lU5RWMl9WYBMO7S57Sz2cNATNV8=;
 b=JABzHpha6WSCr1zmeE4KjX5kBitE3xExdLW7xsIYrf1hRLYrTysGpo8hqQk42p3JssY1/B5VquTdGdDnKyg2NTMEWV96BHu41qvTFmO56Mry9bVYfXil5s1QDCCWy9emE+Lm2oA1fIUvS1bHuCDey6y/72k7FDpZJ6t2KeDE6e7rL3MLEIQ7wY9DHT+Xuzd0ttXniFIA4yY5ypsrV5PZ1Z49dM8uIHsBB5QLR01HmjnKKUknr35fyiQ99emaO9W1dxCZTyDqtE4d46uaOyWYwHJqHQBFhXAziRRRgMYMW9PHLo/Geln4p2uYlnqMyKMOQsJBXqqKJkFAwZyu6Kudyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJivtawyCIrVrea1lU5RWMl9WYBMO7S57Sz2cNATNV8=;
 b=RIiG0cie6WUvuOyUFFWONklkiioqh6Y4i1yfce1x9hnzp1OjcbDRSyzLI9z0G46ZYmfw/koi+wKFvX3O76yxyTw7PXJqCStUjxsmPX0XxilcM/3WIFRwTKk/MxV/s/YfjzIjIPvwhIyE9BKPJYslxLH4wjxR07Xoz4lcmduiD8A=
Received: from MW4PR03CA0178.namprd03.prod.outlook.com (2603:10b6:303:8d::33)
 by DS0PR12MB8501.namprd12.prod.outlook.com (2603:10b6:8:15d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 07:36:37 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:8d:cafe::81) by MW4PR03CA0178.outlook.office365.com
 (2603:10b6:303:8d::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20 via Frontend
 Transport; Thu, 21 Dec 2023 07:36:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.18 via Frontend Transport; Thu, 21 Dec 2023 07:36:37 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 01:36:36 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 20 Dec
 2023 23:36:36 -0800
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Thu, 21 Dec 2023 01:36:33 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>, <vkoul@kernel.org>
CC: <alsa-devel@alsa-project.org>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <pierre-louis.bossart@linux.intel.com>,
	<vinod.koul@intel.com>, <venkataprasad.potturu@amd.com>, Vijendar Mukunda
	<Vijendar.Mukunda@amd.com>, Bard Liao <yung-chuan.liao@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 04/12] drivers: soundwire: refactor soundwire pads enable
Date: Thu, 21 Dec 2023 13:05:50 +0530
Message-ID: <20231221073558.3181911-5-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221073558.3181911-1-Vijendar.Mukunda@amd.com>
References: <20231221073558.3181911-1-Vijendar.Mukunda@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|DS0PR12MB8501:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ffba4a4-290b-4d32-bf9b-08dc01f7908e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fZhh7KrVhyKZiFv12ld/b5lW8NoguxCLyh0ahkGc699naxHEyaoijahaYVQU22bSyTZEtNuwZHCxjQqT1SIPTDpbsJYgijswl7JMGqDFPRyV4kp/jLhZ6S/eBjxnjAFrfQFE60noAFiEnvPIWbr6nvXnresDoz7wNHJDndhpnjFPxdJgSAkAmfWP2BLFL0c231AaXyS6NOcYoboes2tcODCx4wGWGZBuB4GNOMNYbLSy42T9pLSnrjOrS8R4KqQ8xW2NHq+G2maLZZgn5SecQG4FJ9rxTrb0oslaGfjNyJD21iNtPLFJ/l6G6hSmx/xeKNIsafCaBXK0+JL1ZibqRJKExZWKYU88SZpULe6zGQ1QI3Hmug5tyONXH65n/W+N/bxUbAfWOy/h/zjwTiYlfFclq5HmLseVgthT+mil7sNaB3dvo8Bsl1W4dvRvHYVuAQ/ciDAS4AKoNNe+x8Y1Gyg9/hr7O1CpXhg6NhZA5f8uoBA7qoPKJMG8GZ89OT48sqsiAqBRZcWN1UqNV/EQvmsCelXkrd7CrStnvRbZAPaovQNauRT3DZWlJXcFN3TRCZDMzwYqWfVTJlK/qM2kW5Xtgel0FqIE7VvKcE+xU8XcyouyAlNsxlNxAH4tPT0FrYLmOcwLs2YLuVVisCbSh9MLyTlT/iQGTv8oWf6+akIgdFHOEol7G8XkGAeii1B9X/A4U7eqgKPS5/zkAhozsRNczKk2T6iQMQx6kN1UprXIEgRZT8OiAc8uo6Ri9P+Z2DdiZJ9/lywrLbTA/kOPlQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(82310400011)(1800799012)(186009)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(6666004)(478600001)(54906003)(110136005)(316002)(8676002)(8936002)(70586007)(70206006)(83380400001)(36860700001)(47076005)(7696005)(1076003)(26005)(336012)(426003)(2616005)(41300700001)(2906002)(4326008)(5660300002)(40480700001)(86362001)(36756003)(82740400003)(81166007)(356005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 07:36:37.2029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ffba4a4-290b-4d32-bf9b-08dc01f7908e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8501

As sdw pads enable sequence is executed only once, invoke it
from probe sequence.

Program required pads for both manager instances
based on link_mask during probe sequence. This will avoid
acquiring mutex lock.
Remove unnecessary delay after programming ACP_SW_PAD_KEEPER_EN
register.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/amd_init.c    | 45 +++++++++++++++++++++++++++++++++
 drivers/soundwire/amd_manager.c | 18 -------------
 2 files changed, 45 insertions(+), 18 deletions(-)

diff --git a/drivers/soundwire/amd_init.c b/drivers/soundwire/amd_init.c
index 5c9569d9ad01..b3b3c7266384 100644
--- a/drivers/soundwire/amd_init.c
+++ b/drivers/soundwire/amd_init.c
@@ -15,6 +15,47 @@
 
 #include "amd_init.h"
 
+#define ACP_PAD_PULLDOWN_CTRL				0x0001448
+#define ACP_SW_PAD_KEEPER_EN				0x0001454
+#define AMD_SDW_PAD_PULLDOWN_CTRL_ENABLE_MASK		0x7f9a
+#define AMD_SDW0_PAD_PULLDOWN_CTRL_ENABLE_MASK		0x7f9f
+#define AMD_SDW1_PAD_PULLDOWN_CTRL_ENABLE_MASK		0x7ffa
+#define AMD_SDW0_PAD_EN_MASK				1
+#define AMD_SDW1_PAD_EN_MASK				0x10
+#define AMD_SDW_PAD_EN_MASK	(AMD_SDW0_PAD_EN_MASK | AMD_SDW1_PAD_EN_MASK)
+
+static int amd_enable_sdw_pads(void __iomem *mmio, u32 link_mask, struct device *dev)
+{
+	u32 val;
+	u32 pad_keeper_en_mask, pad_pulldown_ctrl_mask;
+
+	switch (link_mask) {
+	case 1:
+		pad_keeper_en_mask = AMD_SDW0_PAD_EN_MASK;
+		pad_pulldown_ctrl_mask = AMD_SDW0_PAD_PULLDOWN_CTRL_ENABLE_MASK;
+		break;
+	case 2:
+		pad_keeper_en_mask = AMD_SDW1_PAD_EN_MASK;
+		pad_pulldown_ctrl_mask = AMD_SDW1_PAD_PULLDOWN_CTRL_ENABLE_MASK;
+		break;
+	case 3:
+		pad_keeper_en_mask = AMD_SDW_PAD_EN_MASK;
+		pad_pulldown_ctrl_mask = AMD_SDW_PAD_PULLDOWN_CTRL_ENABLE_MASK;
+		break;
+	default:
+		dev_err(dev, "No SDW Links are enabled\n");
+		return -ENODEV;
+	}
+
+	val = readl(mmio + ACP_SW_PAD_KEEPER_EN);
+	val |= pad_keeper_en_mask;
+	writel(val, mmio + ACP_SW_PAD_KEEPER_EN);
+	val = readl(mmio + ACP_PAD_PULLDOWN_CTRL);
+	val &= pad_pulldown_ctrl_mask;
+	writel(val, mmio + ACP_PAD_PULLDOWN_CTRL);
+	return 0;
+}
+
 static int sdw_amd_cleanup(struct sdw_amd_ctx *ctx)
 {
 	int i;
@@ -37,6 +78,7 @@ static struct sdw_amd_ctx *sdw_amd_probe_controller(struct sdw_amd_res *res)
 	struct platform_device_info pdevinfo[2];
 	u32 link_mask;
 	int count, index;
+	int ret;
 
 	if (!res)
 		return NULL;
@@ -50,6 +92,9 @@ static struct sdw_amd_ctx *sdw_amd_probe_controller(struct sdw_amd_res *res)
 
 	count = res->count;
 	dev_dbg(&adev->dev, "Creating %d SDW Link devices\n", count);
+	ret = amd_enable_sdw_pads(res->mmio_base, res->link_mask, res->parent);
+	if (ret)
+		return NULL;
 
 	/*
 	 * we need to alloc/free memory manually and can't use devm:
diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index c27b0b0f33a6..1427cccfc309 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -26,23 +26,6 @@
 
 #define to_amd_sdw(b)	container_of(b, struct amd_sdw_manager, bus)
 
-static void amd_enable_sdw_pads(struct amd_sdw_manager *amd_manager)
-{
-	u32 sw_pad_pulldown_val;
-	u32 val;
-
-	mutex_lock(amd_manager->acp_sdw_lock);
-	val = readl(amd_manager->acp_mmio + ACP_SW_PAD_KEEPER_EN);
-	val |= amd_manager->reg_mask->sw_pad_enable_mask;
-	writel(val, amd_manager->acp_mmio + ACP_SW_PAD_KEEPER_EN);
-	usleep_range(1000, 1500);
-
-	sw_pad_pulldown_val = readl(amd_manager->acp_mmio + ACP_PAD_PULLDOWN_CTRL);
-	sw_pad_pulldown_val &= amd_manager->reg_mask->sw_pad_pulldown_mask;
-	writel(sw_pad_pulldown_val, amd_manager->acp_mmio + ACP_PAD_PULLDOWN_CTRL);
-	mutex_unlock(amd_manager->acp_sdw_lock);
-}
-
 static int amd_init_sdw_manager(struct amd_sdw_manager *amd_manager)
 {
 	u32 val;
@@ -872,7 +855,6 @@ int amd_sdw_manager_start(struct amd_sdw_manager *amd_manager)
 
 	prop = &amd_manager->bus.prop;
 	if (!prop->hw_disabled) {
-		amd_enable_sdw_pads(amd_manager);
 		ret = amd_init_sdw_manager(amd_manager);
 		if (ret)
 			return ret;
-- 
2.34.1


