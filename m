Return-Path: <linux-kernel+bounces-59315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CD984F544
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18B3F1C2155C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80F837706;
	Fri,  9 Feb 2024 12:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="PQY6C32E"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2043.outbound.protection.outlook.com [40.107.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0F62E847;
	Fri,  9 Feb 2024 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707482196; cv=fail; b=UUGqgEdLX1SqK5pvUNmj9ndhmNgaW8FGxslqduiS0FnsfaZEUEq32sGWKGAbRKQRFli5gJJNOzjW6VOyTecw9DbGSUObPDazNsksqR/B5rGSYddbkFH5PAHM4ZLHSGIzEX+PB79q29mIwEAIxPVwuR5xfV/Whwv6a072ugL+Zuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707482196; c=relaxed/simple;
	bh=clZmkcHh/noq0vjRkwJ6ctpzOHtMfMw7pgr3mAS/5tc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JNceWU/XDeOax/WEaRyWcun/vHct7Oq2CXHdEXfQub1sqtCe8RGICQ9hgFRXhNnXwQAY18Nhy6Y1ie12L6uJB9eJws22vmJVCz2cN4bg0eUh/N5RAfIPtFITwzqY8zc5r5xTfhPIvwO4CNjsfyoWwPv2Ca8W6S27kgQcCHqadmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=PQY6C32E; arc=fail smtp.client-ip=40.107.6.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqAbv9tP6Imyo/ZgWg1yNCHOKxf2gjkkp6hE0Hco92xC6gCfuOFFdzty2bpwdcYPS4JjHFLkuaxYYHpwCax4aMu9Zn6CzXfmOFK7buVaYUvARURMjdzErgJ7ERoLIBP5x2jcqLKFyW2xoUZYnhiMuvxKmiJXNl17ePqDFC2XADxQJWiD5C6Vfd1vodPQYtu0xTgiXVKJDyy0XLR1KCM+aRy7WAg5YCT7dEBh0o3fT0yyhYeEdqJ/SaypYZeEfw/11ehfRpqwQT/V6OUd/cKAEZ9Q2+9SMi1f2BIoWKvn2t6obrLYz75wMTN3wxK5oZukJPaiUBs09eAcUL2o5mppqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JL5CuQco33ZN6B+4Cp3GsKSNE6oHqtU9p71KL1DcoI=;
 b=VmXpZ/mmcynDGRHz4Kx8xZKV23DhmjZ3Fxvb4bYQ+wb8ElxCPqJn2DlhXc1dD/weUFVlGqHo8a6T7to0inJmEGJr9Bj222d9k902PN3zj1zC5qkT2Kwr3YIHLNCJmdxnX0RLNI+DGcNdmbpDeX7YVDZsGhOpOL1/DiSiltfSfLIn3VCp/W2OQSmWR4z7wix1Kb6CxiJaQUqBGNSCNpMOGQ3ZF+BVzdl7SiaOhfPsbvSamL3DlJ89+GbKjC2HbZdr/z63vuYvkvB1oPElrXbfRM0Z40YHUCNSHM6A0l2qQw+/3hgA/n4JA5f3M7rZtWg7bizb5qaor46Z1IDRYjsM1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JL5CuQco33ZN6B+4Cp3GsKSNE6oHqtU9p71KL1DcoI=;
 b=PQY6C32E6sVWKyqpAuldbggxlg0ulYsTr7N5R7GMYmtjGV3A6Zxz0YQeKzezzD/9DQCE98DK0+7spGH0VGLR9uytuEf1AEQRvr6hbt5SOrpyiwnLa24QuuyVQYFT6mB+pK4SkveUrfT9HkuVlx/v08f0Fqh1UG9qSbQYpvl9+P8=
Received: from DB8PR09CA0007.eurprd09.prod.outlook.com (2603:10a6:10:a0::20)
 by AS8PR06MB7191.eurprd06.prod.outlook.com (2603:10a6:20b:25e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Fri, 9 Feb
 2024 12:36:31 +0000
Received: from DU6PEPF0000B61B.eurprd02.prod.outlook.com
 (2603:10a6:10:a0:cafe::e0) by DB8PR09CA0007.outlook.office365.com
 (2603:10a6:10:a0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Fri, 9 Feb 2024 12:36:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 DU6PEPF0000B61B.mail.protection.outlook.com (10.167.8.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 12:36:30 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Fri, 9 Feb 2024 13:36:30 +0100
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
Subject: [PATCH v3 2/2] net: phy: dp83826: support TX data voltage tuning
Date: Fri,  9 Feb 2024 13:36:28 +0100
Message-Id: <20240209123628.2113971-2-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209123628.2113971-1-catalin.popescu@leica-geosystems.com>
References: <20240209123628.2113971-1-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 09 Feb 2024 12:36:30.0588 (UTC) FILETIME=[9B8C13C0:01DA5B54]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61B:EE_|AS8PR06MB7191:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 260d3fa2-c479-48e3-3ae5-08dc296bbe50
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jPlsfO1uE8gn0/QnETdPe4L18xDvQKxO2B9zOna5Bo88jsFqdojJoVQGbgTQxFIwSfyl1bERXgQ7I7sqTyRxtveIx3NPMXyTyoXn9e0ZM6vgmDnVgNV9pqH9ts8gIx/dYrPTQNLuaQELDkbiFylBRDhR9uKyBmSH3fc48BJxix1iWDSoy54/efaGr2NvU4yTxt/J6SnYkfYX3/Az5y8aVonBFdXygNRWsRcO6ZoHWmG1fVLER4Ux5J5fXEqRJoT74ApTRmWS/LL2D6tkEVeQ2H2IvV9o3Xdd51jtl/4feNmvu7CQLv2/X2XJZQy05Jo61F50pl1Mvve+63xXp8g/O91HGJd2XVQCT2OZBHJlWjwd9aie+i5fCT7OAXGLYhs3KhdtzfFSLkwpoIWyDOE61BHKU2k3ckeB8Awpz+LyhcgRvsYVr0mPhuszlhVKHkHsX+QcjQG9s2s/ASDiFjm9Emt1UzAQ/dq8etmP4F4rCkeszXnEVcjg1OdFcmJVwv4KU3COA3o1Ehon6XBOB6FreNQFvMEWhS9XyIlbqaT38GBn6zybbmRZOPdWgcgXDhI2TkgNTx5gO++RDtwvx4+R1eSLZycu9FqTF/A1S9rmmzMcdEvbroOa4b2b/dhJr+xm6yxVSjyWA9sPWuY6H8LX0g==
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(82310400011)(1800799012)(186009)(46966006)(40470700004)(36840700001)(82740400003)(107886003)(356005)(81166007)(86362001)(83380400001)(70586007)(316002)(2616005)(70206006)(336012)(26005)(478600001)(36756003)(921011)(1076003)(66899024)(450100002)(5660300002)(4326008)(44832011)(8936002)(8676002)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 12:36:30.9529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 260d3fa2-c479-48e3-3ae5-08dc296bbe50
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7191

DP83826 offers the possibility to tune the voltage of logical
levels of the MLT-3 encoded TX data. This is especially interesting
when the TX data path is lossy and we want to increase the voltage
levels to compensate the loss.

Prior to PHY configuration, the driver SW resets the PHY which has
the same effect as the HW reset pin according to the datasheet.
Hence, there's no need to force update the VOD_CFG registers to make
sure they hold their reset values. VOD_CFG registers need to be
updated only if the DT has been configured with values other than
the reset ones.

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


