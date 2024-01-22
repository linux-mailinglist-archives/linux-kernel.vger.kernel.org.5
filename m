Return-Path: <linux-kernel+bounces-32623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57277835E11
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A81E3B26F74
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D398439AEE;
	Mon, 22 Jan 2024 09:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xxwoL6PW"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7694439AC8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705915534; cv=fail; b=kgRwsx+JbmtX6leLmfZnSGZMikRSSSbteGNlcNC7U/y3VYPT9Wk+NHNAkoP3VZu9Z4nFbdklQGS+Xv+AULrRgdKISVZjKr6eaXcEPzUKTZp+nogU2PY1DQ2snsb5MXiylDQDba7zcX07vNd1rxY26r1LXdD6cxvJ5E7hJy/BdyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705915534; c=relaxed/simple;
	bh=tyEZPTEeR7iWKSi9Zhc2/tPj3NPkCZH6BZVfjFCsVZQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jFQ4b6loY0b/GQ5M4HO4kocb/1jF6yVDGkLfvRbsoxlxrwsGBeKH2GEI12BD/4b4WHsWqa0BonENAvPlJmBF9vzOjZCMcDEauUQvPxpxZQTS7y9XtXGFMILexmC1IblJzc0Edgc0O3dRfwYP23q00CtnRnJowwPquczhLX3nEqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xxwoL6PW; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kX/C+6+fVIvrxcdf4DTBJNEhRjScwCyg4lU5T8aDjG+dH1fXQ21WkO8fosH7AgSfzg95Uvh4lJYA3fZYUz2v5obArlcScdLWumqPETwHq9aX52JewyHS3dLlKcpgAhQNa8CcTr3MCWwadwpQUPBALEacIsPRe9kQPwjLpJLqOxAn6xjNRrA7JSbadycnEdi9ZDdU6krjh/x174uPgu76fUDtyA0daOhmYzeCCETNIWp6YjIBWaDPftWjwgt2tBFVNLyldpWaeUT82Q5TV0Ay1hSAFKLr7gxGWoiGBUpTTcFBtJftyP471SW8nki8kvxGvj3VV5uOel/SoO7s1UTqEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IacFn7eqF5kdZGkhlqH0YD9/OWDzYxwStCzDix+z0ns=;
 b=i+tKyboZB1Cdo0bjrZl3OXRV9+LHpyd3kIsA/UbjBO8DCPiPVPJguIPiqqrgPQoUqogo+CigaJTKzfNadex25uLJjX8vf48QVKbOnbVszZevvIYTMWTjJ9HmDiaQmMNspt/YImL7H3mfRE9I/FCsexhVI3vxoTHYgDdgleQbfHFriOQW4h7v7jIBbT3uqMeNBZI0A1FxCasZeTU0sZTZuzVFjl7HWqo/Uwu9fxbTP16O4I74pz0Zi9lZOX+N/tkaOtvY3IOa+2OfMzJWw1ajUMa4oiFRLnfplQ/Y/Wn0mqwV2wpnTfy/6qFc8IhCo//MBml7peh+aCwRpOYNymjHYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IacFn7eqF5kdZGkhlqH0YD9/OWDzYxwStCzDix+z0ns=;
 b=xxwoL6PWYKfd2Y0hYWcRBO5/refXykfr1whZw7MsgDyLydwSvyyLOpSM4qj6WwO3Xnuss36fNSk7vbfSj9dc08pI+4MoiQ6gmCWSAWQo+PjDwLih057N1w0XWCHu0SR/B8Sd9dQp3BTeXTcLQz+nUOn2lk3ssb0NSwFFZkxgBB0=
Received: from DS7PR03CA0244.namprd03.prod.outlook.com (2603:10b6:5:3b3::9) by
 PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Mon, 22 Jan
 2024 09:25:29 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::71) by DS7PR03CA0244.outlook.office365.com
 (2603:10b6:5:3b3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.30 via Frontend
 Transport; Mon, 22 Jan 2024 09:25:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Mon, 22 Jan 2024 09:25:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 03:25:18 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Mon, 22 Jan 2024 03:25:11 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>, <vkoul@kernel.org>
CC: <alsa-devel@alsa-project.org>, <yung-chuan.liao@linux.intel.com>,
	<pierre-louis.bossart@linux.intel.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <vinod.koul@intel.com>,
	<venkataprasad.potturu@amd.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V3 05/13] soundwire: amd: refactor soundwire pads enable
Date: Mon, 22 Jan 2024 14:54:27 +0530
Message-ID: <20240122092435.3791175-6-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122092435.3791175-1-Vijendar.Mukunda@amd.com>
References: <20240122092435.3791175-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|PH8PR12MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd653b9-7c70-40a9-5dc2-08dc1b2c12a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VWDnIITSj7shPxtodUuXmFoH2/qyXb971cd5qvWTd6q941Vl9a9mDZdxFw9emGyDrVkEFvonEY0sDhs0PYHo/ZZO8Pn4ITcQjm0JFgu9xJgZ2+YqNYYKRYTv+QlJXxoOh1KRMApYJbD8bCSmh4fXTnJtbmAwmxelp0wQVK8vwvhK+AIJkBMQSD0V6JPRqWF2KgzBG9/N9G5B0P9oFt7EwYRKZnftHHTNkobNnRcaO4M4jq08f/CbnEYCqkDwl7jwU/jR4VemA1eRVlg4tnQZQ/gdByp/6alNgb3qDYkgjkTj5ERo9fzAigQjoyINZr2VX/z55NDJYJo0zT7iYErP8fhblV55Tq0zqB/gCc9ghVOPjc7htS8fY31Bu3KE9dii7O+rY8M5uIxNCJu5ajsTW2QOLRS2S2vk8tftNYvGlrwn7e69PMzVLp4FVYg6Rnr8MCBbuxvbXnkJJGmcXFVhYspsJQPSUzIYT/Nn7LCwZlTdpEAs0wxpy9AEqYrB19k5RUTdon4DNmPRk7zljrIznJ/BTwvbZJdTr2LhNU0cVcoSVINRBoN/CIaFb8jLt+HhfGkJJt7Y4uBykSa5j4K+n8kUOYCuAdb6P3EV9flvxYThNSavVKVOfZGZ9TZMuKN8uHmOxZy0pt1e8o4MhJDppr1m/isjAWZ8rU2JRNF+Rc2dlCa90wI05lGHmzbJZ7H5ONcH12fm8l8dpiZcFVphA4+khT9AEC98JWrUIslGGR1RWmzb0xovoa00FIhuFxZjypmXxrvs2ud8urq/qc2h/Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(64100799003)(1800799012)(82310400011)(451199024)(186009)(40470700004)(36840700001)(46966006)(41300700001)(336012)(1076003)(6666004)(47076005)(426003)(83380400001)(40480700001)(40460700003)(26005)(7696005)(8936002)(54906003)(70206006)(70586007)(110136005)(316002)(82740400003)(86362001)(478600001)(2616005)(36860700001)(81166007)(36756003)(356005)(8676002)(2906002)(5660300002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 09:25:28.4037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd653b9-7c70-40a9-5dc2-08dc1b2c12a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7325

As sdw pads enable sequence is executed only once, invoke it from probe
sequence.

Program required pads for both manager instances based on link_mask during
probe sequence. This will avoid acquiring mutex lock.
Remove unnecessary delay after programming ACP_SW_PAD_KEEPER_EN register.

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
index 0fcf8f8545b1..7ccafd8eab7d 100644
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


