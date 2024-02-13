Return-Path: <linux-kernel+bounces-63075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08193852A8D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 568E51F22C08
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EE01B59C;
	Tue, 13 Feb 2024 08:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="qBhHpKbS"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2057.outbound.protection.outlook.com [40.107.8.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567C31B599;
	Tue, 13 Feb 2024 08:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707811641; cv=fail; b=nOttCtjPwJAHnyisQKG+O+HYoNEzUlZB/ZvijTEA5oiDQOicTOXrJE5GuVFxi0TsHtgtC81uaXiuLJCp0lUG5wnAjtADbEcpgj2T+pdXfWdSgampbZM7CItiVDCd+un7KJ5TzRJinmOuGv0xosL2FA8um37+DRqpvlfqTNLGQxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707811641; c=relaxed/simple;
	bh=Vpw0zKDYx+QaZKgSPbHtZXV8hIZOw4PK3pGbiLTN+xY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kPzuzUSoxHcXy0Jr5NxPYDsnGPuTl5hb05n1YC7omTBwwI03dLc+ZGITI7KyoEkPYm/J/L964s4KmAqne4Td2Wn01Erk3NDeaLq4ogs9b2Xb+vSDthtIJsHfEt51Qg3nYoYgaAMSk7mr0H8hGHJCvChlBCEPbmDIsCuy1fKKbe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=qBhHpKbS; arc=fail smtp.client-ip=40.107.8.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3dc1MoxvwR7NdqGrDCqEq7HQd10VoRIMClRyho9mMU1Ybfp6bdJc7pT9b+H0Hny/jvVF9NbZo9J3Jyw3sr6CT/2vPar/4Z5AUP3IFzUG9urZ7j2CFGDQukieMNuou4UpL0DJmlU8dzK7sBtmPgPeETRBqpcZhKc4fNUZ6mWcLHhr2wFeYXcNysmITwcgLnKxc5rsSAoBaMinvxe01JVqB80wKHIkN+p4WLEQ5sP7n6RgvBt+nRy52D61Xy1XWZgmZhjMqIBfs8aR0OjWgoh6ElEG5OcSaHJAypHgjiR3XbtybT0m2EKHV2LIxFus4IiR/mjZ5ZWAxDCzPnuN7f2sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3eFUueocJmujmimKrqINFOrmzYjipFdqsGHa40q48s=;
 b=V/kCEbOb2a1rJb8ALKMxuY/infEcnDHSS30+V5Xde/Cj/Zudejy4lEhyELhzFamq6XWo57Yw63YcIVQBaTNXHcdxG5xvDiULLfuH8K2gXjR1ps6yq3UaorlFVbZ/01tBUMMxF0YL6h/pgsojY7HwAo7C01tYonJBk0OBjIZ5XZfFrwFCQtQf4hm4BYMSKZm+7uzAgFlNlz9fuYqPqC1ib1trcfrIP9MtsuazDCQ82TJyPxAANixBAZ22kr5yR3RHJL4tQNR8ggreyZwSMsndPYeJaqzjC3z6nbdjmGg4q1EfwIX6Od7PmKDiRIA8P4ORiRK/Q7hp3lcopPXyVSwYnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3eFUueocJmujmimKrqINFOrmzYjipFdqsGHa40q48s=;
 b=qBhHpKbSGlC6Su9UYzcrWp611g//OLthie8X9/6qWF1n4sKHH6HCuOcI2AJQB/+pMmRo6puysJAbyFmrMSb3TcEwcOZ7Z/unkKns5kLq6v7W0we5gMa1LtS/Q5uEIDC/5BBTXsC5ak4zAa1hPseGUIByz5cZK9Dtic+yFlh1ti8=
Received: from AS8PR04CA0072.eurprd04.prod.outlook.com (2603:10a6:20b:313::17)
 by AM8PR06MB6835.eurprd06.prod.outlook.com (2603:10a6:20b:1d1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 08:07:08 +0000
Received: from AMS0EPF000001B7.eurprd05.prod.outlook.com
 (2603:10a6:20b:313:cafe::ce) by AS8PR04CA0072.outlook.office365.com
 (2603:10a6:20b:313::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Tue, 13 Feb 2024 08:07:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AMS0EPF000001B7.mail.protection.outlook.com (10.167.16.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Tue, 13 Feb 2024 08:07:08 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Tue, 13 Feb 2024 09:07:08 +0100
From: Catalin Popescu <catalin.popescu@leica-geosystems.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	afd@ti.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bsp-development.geo@leica-geosystems.com,
	m.felsch@pengutronix.de,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>
Subject: [PATCH v5 2/2] net: phy: dp83826: support TX data voltage tuning
Date: Tue, 13 Feb 2024 09:07:05 +0100
Message-Id: <20240213080705.4184566-2-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240213080705.4184566-1-catalin.popescu@leica-geosystems.com>
References: <20240213080705.4184566-1-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 13 Feb 2024 08:07:08.0330 (UTC) FILETIME=[A3BE38A0:01DA5E53]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B7:EE_|AM8PR06MB6835:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f9d5d589-9939-45a2-4fad-08dc2c6ac680
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	216BfGQABM7lt4tv7piphDq2AUicHpI+UMfqDzGOXTzXdFEK8NeeaIYjWYvi92t5sD8U9innzrb51o1kRduDh+IP+dD/sUAjpJDLUi9OHZ/zaVRnRAey3yXLX8p3XIpRS23e1p6NKNB+8osHHDHNBknPSK2fb+7I/b4TjAIFbvDVpIMeiHba8nYUHuLuENPGRkn4gU+UUaAOo4N1kZG9eIr0wove/A3ncie1yqc/U1KNGLsFh57Q4/JE3KqXtbaiIYZW84pEVOJ2td+76jj6ReJ1sk8m6Xw7uZ1UUVyEDvCm8J7n3dXzefg1kTVN10/yOPFb5EVW6hMxBDEHCMXGAdf9bJeIRPTTMO9Eo83H/oLofth8ocRvAfUIxnnI8k+WsY1JFrM6URie+XhqQ0LZldWQLD4isF7ajoqg1So8uY2BJHRIQ8Pxbrk1n56fl3zzUVUM3ybvLjm1mGVmbZVhH7mL7hRjbOfISMTW/iihgzvQVzkAsVrGDkWjKqXqzHwCLZdTharIg7gb546govFL2k4/yW9f3yzEnHFVTbdGhLOKG1iOwPlADIEAmnhHsdwkA30oOLpP4w6ieMbRJfrM4ZeuOcOuODYd/2wjEfTdNZqkypuniQ+2B79FrZ3Q9H1EeM1LcEmZdrhPUy8CpS+QsA==
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(186009)(1800799012)(82310400011)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(83380400001)(86362001)(66899024)(107886003)(70206006)(70586007)(316002)(2616005)(1076003)(82740400003)(6666004)(478600001)(5660300002)(44832011)(2906002)(81166007)(336012)(8676002)(450100002)(8936002)(4326008)(26005)(921011)(36756003)(356005)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 08:07:08.7127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d5d589-9939-45a2-4fad-08dc2c6ac680
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR06MB6835

DP83826 offers the possibility to tune the voltage of logical
levels of the MLT-3 encoded TX data. This is useful when there
is a voltage drop in between the PHY and the connector and we
want to increase the voltage levels to compensate for that drop.

Prior to PHY configuration, the driver SW resets the PHY which has
the same effect as the HW reset pin according to the datasheet.
Hence, there's no need to force update the VOD_CFG registers to make
sure they hold their reset values. VOD_CFG registers need to be
updated only if the DT has been configured with values other than
the reset ones.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
Changes in v2:
 - remove raw values mapping tables dp83826_cfg_dac_minus_raw/
   dp83826_cfg_dac_plus_raw and replace them with functions
   dp83826_to_dac_minus_one_regval/dp83826_to_dac_plus_one_regval
 - increase readability of function dp83826_config_init
 - change return value of function dp83826_of_init from int to void
   since it never returns any error

Changes in v3:
 - rename DT properties to "-bp"
 - rename DP83826_CFG_DAC_MPERCENT_DEFAULT/DP83826_CFG_DAC_MPERCENT_PER_STEP
   to DP83826_CFG_DAC_PERCENT_DEFAULT/DP83826_CFG_DAC_PERCENT_PER_STEP and
   update their values to reflect the new unit "basis point"
 - update commit message with explanation about the registers reset
   values

Changes in v4:
 - update commit message to be more meaningful

Changes in v5:
 - add reviewed-by tag
---
 drivers/net/phy/dp83822.c | 130 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 126 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index b7cb71817780..30f2616ab1c2 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/phy.h>
 #include <linux/netdevice.h>
+#include <linux/bitfield.h>
 
 #define DP83822_PHY_ID	        0x2000a240
 #define DP83825S_PHY_ID		0x2000a140
@@ -34,6 +35,10 @@
 #define MII_DP83822_GENCFG	0x465
 #define MII_DP83822_SOR1	0x467
 
+/* DP83826 specific registers */
+#define MII_DP83826_VOD_CFG1	0x30b
+#define MII_DP83826_VOD_CFG2	0x30c
+
 /* GENCFG */
 #define DP83822_SIG_DET_LOW	BIT(0)
 
@@ -110,6 +115,19 @@
 #define DP83822_RX_ER_STR_MASK	GENMASK(9, 8)
 #define DP83822_RX_ER_SHIFT	8
 
+/* DP83826: VOD_CFG1 & VOD_CFG2 */
+#define DP83826_VOD_CFG1_MINUS_MDIX_MASK	GENMASK(13, 12)
+#define DP83826_VOD_CFG1_MINUS_MDI_MASK		GENMASK(11, 6)
+#define DP83826_VOD_CFG2_MINUS_MDIX_MASK	GENMASK(15, 12)
+#define DP83826_VOD_CFG2_PLUS_MDIX_MASK		GENMASK(11, 6)
+#define DP83826_VOD_CFG2_PLUS_MDI_MASK		GENMASK(5, 0)
+#define DP83826_CFG_DAC_MINUS_MDIX_5_TO_4	GENMASK(5, 4)
+#define DP83826_CFG_DAC_MINUS_MDIX_3_TO_0	GENMASK(3, 0)
+#define DP83826_CFG_DAC_PERCENT_PER_STEP	625
+#define DP83826_CFG_DAC_PERCENT_DEFAULT		10000
+#define DP83826_CFG_DAC_MINUS_DEFAULT		0x30
+#define DP83826_CFG_DAC_PLUS_DEFAULT		0x10
+
 #define MII_DP83822_FIBER_ADVERTISE    (ADVERTISED_TP | ADVERTISED_MII | \
 					ADVERTISED_FIBRE | \
 					ADVERTISED_Pause | ADVERTISED_Asym_Pause)
@@ -118,6 +136,8 @@ struct dp83822_private {
 	bool fx_signal_det_low;
 	int fx_enabled;
 	u16 fx_sd_enable;
+	u8 cfg_dac_minus;
+	u8 cfg_dac_plus;
 };
 
 static int dp83822_set_wol(struct phy_device *phydev,
@@ -233,7 +253,7 @@ static int dp83822_config_intr(struct phy_device *phydev)
 				DP83822_ENERGY_DET_INT_EN |
 				DP83822_LINK_QUAL_INT_EN);
 
-		/* Private data pointer is NULL on DP83825/26 */
+		/* Private data pointer is NULL on DP83825 */
 		if (!dp83822 || !dp83822->fx_enabled)
 			misr_status |= DP83822_ANEG_COMPLETE_INT_EN |
 				       DP83822_DUP_MODE_CHANGE_INT_EN |
@@ -254,7 +274,7 @@ static int dp83822_config_intr(struct phy_device *phydev)
 				DP83822_PAGE_RX_INT_EN |
 				DP83822_EEE_ERROR_CHANGE_INT_EN);
 
-		/* Private data pointer is NULL on DP83825/26 */
+		/* Private data pointer is NULL on DP83825 */
 		if (!dp83822 || !dp83822->fx_enabled)
 			misr_status |= DP83822_ANEG_ERR_INT_EN |
 				       DP83822_WOL_PKT_INT_EN;
@@ -474,6 +494,43 @@ static int dp83822_config_init(struct phy_device *phydev)
 	return dp8382x_disable_wol(phydev);
 }
 
+static int dp83826_config_init(struct phy_device *phydev)
+{
+	struct dp83822_private *dp83822 = phydev->priv;
+	u16 val, mask;
+	int ret;
+
+	if (dp83822->cfg_dac_minus != DP83826_CFG_DAC_MINUS_DEFAULT) {
+		val = FIELD_PREP(DP83826_VOD_CFG1_MINUS_MDI_MASK, dp83822->cfg_dac_minus) |
+		      FIELD_PREP(DP83826_VOD_CFG1_MINUS_MDIX_MASK,
+				 FIELD_GET(DP83826_CFG_DAC_MINUS_MDIX_5_TO_4,
+					   dp83822->cfg_dac_minus));
+		mask = DP83826_VOD_CFG1_MINUS_MDIX_MASK | DP83826_VOD_CFG1_MINUS_MDI_MASK;
+		ret = phy_modify_mmd(phydev, DP83822_DEVADDR, MII_DP83826_VOD_CFG1, mask, val);
+		if (ret)
+			return ret;
+
+		val = FIELD_PREP(DP83826_VOD_CFG2_MINUS_MDIX_MASK,
+				 FIELD_GET(DP83826_CFG_DAC_MINUS_MDIX_3_TO_0,
+					   dp83822->cfg_dac_minus));
+		mask = DP83826_VOD_CFG2_MINUS_MDIX_MASK;
+		ret = phy_modify_mmd(phydev, DP83822_DEVADDR, MII_DP83826_VOD_CFG2, mask, val);
+		if (ret)
+			return ret;
+	}
+
+	if (dp83822->cfg_dac_plus != DP83826_CFG_DAC_PLUS_DEFAULT) {
+		val = FIELD_PREP(DP83826_VOD_CFG2_PLUS_MDIX_MASK, dp83822->cfg_dac_plus) |
+		      FIELD_PREP(DP83826_VOD_CFG2_PLUS_MDI_MASK, dp83822->cfg_dac_plus);
+		mask = DP83826_VOD_CFG2_PLUS_MDIX_MASK | DP83826_VOD_CFG2_PLUS_MDI_MASK;
+		ret = phy_modify_mmd(phydev, DP83822_DEVADDR, MII_DP83826_VOD_CFG2, mask, val);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int dp8382x_config_init(struct phy_device *phydev)
 {
 	return dp8382x_disable_wol(phydev);
@@ -509,11 +566,44 @@ static int dp83822_of_init(struct phy_device *phydev)
 
 	return 0;
 }
+
+static int dp83826_to_dac_minus_one_regval(int percent)
+{
+	int tmp = DP83826_CFG_DAC_PERCENT_DEFAULT - percent;
+
+	return tmp / DP83826_CFG_DAC_PERCENT_PER_STEP;
+}
+
+static int dp83826_to_dac_plus_one_regval(int percent)
+{
+	int tmp = percent - DP83826_CFG_DAC_PERCENT_DEFAULT;
+
+	return tmp / DP83826_CFG_DAC_PERCENT_PER_STEP;
+}
+
+static void dp83826_of_init(struct phy_device *phydev)
+{
+	struct dp83822_private *dp83822 = phydev->priv;
+	struct device *dev = &phydev->mdio.dev;
+	u32 val;
+
+	dp83822->cfg_dac_minus = DP83826_CFG_DAC_MINUS_DEFAULT;
+	if (!device_property_read_u32(dev, "ti,cfg-dac-minus-one-bp", &val))
+		dp83822->cfg_dac_minus += dp83826_to_dac_minus_one_regval(val);
+
+	dp83822->cfg_dac_plus = DP83826_CFG_DAC_PLUS_DEFAULT;
+	if (!device_property_read_u32(dev, "ti,cfg-dac-plus-one-bp", &val))
+		dp83822->cfg_dac_plus += dp83826_to_dac_plus_one_regval(val);
+}
 #else
 static int dp83822_of_init(struct phy_device *phydev)
 {
 	return 0;
 }
+
+static void dp83826_of_init(struct phy_device *phydev)
+{
+}
 #endif /* CONFIG_OF_MDIO */
 
 static int dp83822_read_straps(struct phy_device *phydev)
@@ -567,6 +657,22 @@ static int dp83822_probe(struct phy_device *phydev)
 	return 0;
 }
 
+static int dp83826_probe(struct phy_device *phydev)
+{
+	struct dp83822_private *dp83822;
+
+	dp83822 = devm_kzalloc(&phydev->mdio.dev, sizeof(*dp83822),
+			       GFP_KERNEL);
+	if (!dp83822)
+		return -ENOMEM;
+
+	phydev->priv = dp83822;
+
+	dp83826_of_init(phydev);
+
+	return 0;
+}
+
 static int dp83822_suspend(struct phy_device *phydev)
 {
 	int value;
@@ -610,6 +716,22 @@ static int dp83822_resume(struct phy_device *phydev)
 		.resume = dp83822_resume,			\
 	}
 
+#define DP83826_PHY_DRIVER(_id, _name)				\
+	{							\
+		PHY_ID_MATCH_MODEL(_id),			\
+		.name		= (_name),			\
+		/* PHY_BASIC_FEATURES */			\
+		.probe          = dp83826_probe,		\
+		.soft_reset	= dp83822_phy_reset,		\
+		.config_init	= dp83826_config_init,		\
+		.get_wol = dp83822_get_wol,			\
+		.set_wol = dp83822_set_wol,			\
+		.config_intr = dp83822_config_intr,		\
+		.handle_interrupt = dp83822_handle_interrupt,	\
+		.suspend = dp83822_suspend,			\
+		.resume = dp83822_resume,			\
+	}
+
 #define DP8382X_PHY_DRIVER(_id, _name)				\
 	{							\
 		PHY_ID_MATCH_MODEL(_id),			\
@@ -628,8 +750,8 @@ static int dp83822_resume(struct phy_device *phydev)
 static struct phy_driver dp83822_driver[] = {
 	DP83822_PHY_DRIVER(DP83822_PHY_ID, "TI DP83822"),
 	DP8382X_PHY_DRIVER(DP83825I_PHY_ID, "TI DP83825I"),
-	DP8382X_PHY_DRIVER(DP83826C_PHY_ID, "TI DP83826C"),
-	DP8382X_PHY_DRIVER(DP83826NC_PHY_ID, "TI DP83826NC"),
+	DP83826_PHY_DRIVER(DP83826C_PHY_ID, "TI DP83826C"),
+	DP83826_PHY_DRIVER(DP83826NC_PHY_ID, "TI DP83826NC"),
 	DP8382X_PHY_DRIVER(DP83825S_PHY_ID, "TI DP83825S"),
 	DP8382X_PHY_DRIVER(DP83825CM_PHY_ID, "TI DP83825M"),
 	DP8382X_PHY_DRIVER(DP83825CS_PHY_ID, "TI DP83825CS"),
-- 
2.34.1


