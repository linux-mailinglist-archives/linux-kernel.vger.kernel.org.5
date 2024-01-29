Return-Path: <linux-kernel+bounces-42201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4894C83FDD7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBFE31F213EA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034864CE04;
	Mon, 29 Jan 2024 05:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SAbkfrKm"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE634C60B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 05:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706507555; cv=fail; b=ldh9MBzvTjQcBA7XUZJk0tn2t970p+Sb4ULVT8L1wy9jTXYARiAQvexxlW+24N8vvSu4MUWiJnf2ScVTqtGDmh2aHyqBpmFM4tWjTTQS95oyd7dxcuivFsmIrkaD4zU8yy7NJRsD6fRFQsSfqdJRKr/E6ZjkLEw5GanYPv8cmOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706507555; c=relaxed/simple;
	bh=HZubQGUM+zWeuyfAnPQBDtT4IttLjbVEfDMuDLkpmLU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g5lJJn8iutTeSErcJRdACAPN7rkHOXgo271OmOfxjaEUh+LycryeNc0quU0z7udPOBFFhS5fzxVf29xW4CYIFjuVoE8W/p7dJ72bqx0fgP+Ly9MPipgmA5IJnlD6MwNrv/dM+eiuqxVlb33KPo8tWKPmLuizQDs369rpq6vCmBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SAbkfrKm; arc=fail smtp.client-ip=40.107.100.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oW1NwOu0Ww2yBDlwcRgaLlcfcT4aBTMTaxxh904sb/skNp2mpnXF2ncgZf7C8Yx6o9cyLs01nzdrVJAY/hp0jHt5EEHEtVpE4EhRwwjfNtBWdZ9BhhjcATSpSIXN0uwm65Fk+Bqqx36YkLMzGR94WCZt9S7ultnUl4+Udtsn67ygDoi0oAHdo8KXCZWNS8fUNslUofkKJ+PNqC0zVJDAgQrgZJLHa8X8orDMHqzm3a7n4vbcM6MRT3VVTcZQNjkVisdyrviM5oftKn3997a0x9UfxLlk9uG3YbBcAaOw9n9tWTU0M9Vvig3GdXySE1yBv9UyB+gJAMprn8FdLsL/NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFwb3LdQZfc1auqOX52wW8s9hwRhKy2o9/oZTX8aD6A=;
 b=Deb0xJHTlgkK1YxBP3uq+v8dpMS3mb/+VnGGYUqwGzaGvl44VUk3AmFbVoWb129UA/Y1dKn1VTB+07PblQYHvWHj/CsZ8hHt3bY8XjY98YyAuEw8wD62Ul4HT8NXCstN9MvTZTvsZX57YF4Fvu0sqev6kY2FcslWnL6p5GRdyO/hywzyDZdh9sljhcSK5/p8FPbqMofsQvVeQp+abbjaLtX5tNPAycRfZMrVgcckplamaKl8/eowXvNvyB9oAzgATO7Bi6/TEV+rN/eOn9tnx3pWlLH9jv4nqh9ZBT6oQImkD+s2rTKQIs2qEoeZjjKKILeDa5asXdENLaWvlvAnSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFwb3LdQZfc1auqOX52wW8s9hwRhKy2o9/oZTX8aD6A=;
 b=SAbkfrKmfc5pHxjzLaDyrD4iGFUDr3uItyUDYZZ2E4/DkZSeuN2PkHjnPhsElo92wqFQJymL41Re1MBYpSU9ePXY/K85ChCggiwEuR2B0yQT8+FXuWkr6hNci3o/lECWNDC7WTjB0ngLSR0tyseypjqwEDkZu01zz/FRXnjuqBM=
Received: from BN9P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::30)
 by BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Mon, 29 Jan
 2024 05:52:31 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:10c:cafe::9f) by BN9P222CA0025.outlook.office365.com
 (2603:10b6:408:10c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32 via Frontend
 Transport; Mon, 29 Jan 2024 05:52:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 29 Jan 2024 05:52:30 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 28 Jan
 2024 23:52:30 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 28 Jan
 2024 23:52:30 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Sun, 28 Jan 2024 23:52:27 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>, <vkoul@kernel.org>
CC: <alsa-devel@alsa-project.org>, <yung-chuan.liao@linux.intel.com>,
	<pierre-louis.bossart@linux.intel.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <vinod.koul@intel.com>,
	<venkataprasad.potturu@amd.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V4 05/13] soundwire: amd: refactor soundwire pads enable
Date: Mon, 29 Jan 2024 11:21:39 +0530
Message-ID: <20240129055147.1493853-6-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129055147.1493853-1-Vijendar.Mukunda@amd.com>
References: <20240129055147.1493853-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|BY5PR12MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: 803efdfe-9849-4037-1ec3-08dc208e7b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/Ztntdh+UHe5Ya02SIGbcVSl20v3Zvp2tfZ8QeN8omEkEI+CNrUsSr80cl8+p97/8gdW6wRHuj7Y7chUXiBdgx4Hmz4bZw786rSAUSnZyd63lClQwR/18O7pS+OLqki+enb+bdGbOHnPJQOlJqwleTbGHKcOt6j1QWKhDpzqarBWpV8uTPGmvNYtgmL8UJ7qteRWdCs9i54A3dermv8L72QlIV5fEo+2fqXwiBj7/U2pg2GbNwFme9LRdvHpgIi+Y9yYoY5pol7HiYZUxFl4zbBTOzFhiDcEAxDO2Yw2XS7JaIEwHixjpzoaH74wUIuTeLpdejsaj8mHQldqNRnZS25iE3lJPOkqzQInb9ai7bABSo7sJaAzJSmmUJwi0GcgJOEw8mmpBEJ3y804Cea+IT8XM6bP3YQrq0KT/uHdOd879tPQYPVeMaTL9pYros4T9oyHt8Mr7FKvuv5CHIv7pUY9iB1+WAmaondE/NKa1gxEPCf012cDsZVfMZRX329yN/P1FWU/CZkGJfnLqlgtY6KbPF5L8HSerHp+e+HLzx/ZCXrZH5uryK/dUVp8gyUGad7XT97UGt7+Zdo0XbOYNjrZas1O9kNK/fDxfxL+ASwsRS2iGcwLfQIaLgUSPMjRnGjlhY2PPANle3bGwQsY++l+PAhi0wSpsiNACk1dsGQ1EuVnSYL56KPsoD2qK7aLRwxxCxJM170FbpoUzaoYPTsHBEfH0M3fzBc+7S2yCumYqwc31pjQYZyA0ftMXEcn
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39850400004)(376002)(346002)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(82310400011)(36840700001)(46966006)(40480700001)(47076005)(83380400001)(36756003)(36860700001)(81166007)(356005)(86362001)(4326008)(70586007)(8936002)(336012)(5660300002)(8676002)(2616005)(316002)(82740400003)(1076003)(426003)(7696005)(26005)(110136005)(54906003)(478600001)(6666004)(41300700001)(70206006)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 05:52:30.8042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 803efdfe-9849-4037-1ec3-08dc208e7b73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275

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
index 46a0538d7fc7..e45dc8261ab1 100644
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
index efc000334aa0..44d682a83e23 100644
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


