Return-Path: <linux-kernel+bounces-56856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD6B84D05D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FBA7B2800B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EA485C4F;
	Wed,  7 Feb 2024 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="pjjyxPrw"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2067.outbound.protection.outlook.com [40.107.6.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE8984FA4;
	Wed,  7 Feb 2024 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328745; cv=fail; b=fFWDXl4MDKcfeDTPi29VszI1xZaoKh+5fsUm5Fs+VOsNCa7m8ZMdMZSK0XLYb+bIPPyFJisTPRJwyUPpbjExY0uhKDlg6mLxEn5qlmL9uCgLaEj6oPmNOogfX4YZ6Mi6ZnhbkFYN6bo84jIVsTlR6vCfwceEIlmyJWGRdU958q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328745; c=relaxed/simple;
	bh=PvpIJ7+d04VHJNCRAJoklOB9Af/R2bRVdx0WhN6+/QY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OoUJXZ737lTc+kQjOSFxxMw1m0M02DVhmlD4yWSENFRcHMbK6+/bhDgkXMZfXifI3uCtTpbbEKOcqsT7TyCvFAvgg3H3HJqeiX4QEVaQ7zUiGpm1hzXwD5yQm8nsCxn2HNZqgiaq3SwILoYlgvlRYa2RqLnWuPv83g+I04kfQZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=pjjyxPrw; arc=fail smtp.client-ip=40.107.6.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcAX9FSqVR6jRE63xFRxrnNolWh+rmuTvze9/8zPr49Yh+rmFNB7nriXCElr7sKEqV6goGiwhy76jZRBu5N3hYB0H+GaO+p559RkzSD964YlLRn2PYZtx8kwWX98PL84y5/TWCwvdtOXYp3C3djFEVVULML3TfhgjLM1wRuH4MVND2HcGBveHzQwgTt/HTBfyrWgKcUJ+LfBpYaLqZmgJVwpVw5tM7I51G5ImC966Xeu3As13Q9RruMlh3lroJosb7tJDLKgva4VYHUyTpTBWVsu/yIFqL9ChByhpOcM9NfEzqc8GMAgIO61ktmyWlkdDS6h5KFitfxw7L9IhtGLgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsrHJS/xL6QlNcRxFNr+tiqLUJgt9LvcQOiy6R/ZfpE=;
 b=mgBCbB3GFo+yts0EmWOpJfXHT5gyzTI1AGQ9QrnAucWz+TxFDGPJ2WT/YFEe4VHpiIzP7AFteopPXsprb7x11srb6Di+Rh/IzkBdLeInvm3Hs+CE6kukvAxTb+j7n8w/am2eWLVGk3UyzfdvCc3sYdXz8qUzY7weG58NYf6O8TwVV2ffR6R9r8U9OYu5F74fbMlmVpCgFAKvevuhDJDyiqRVAXoYdlFrqlw6Ov7zF+NpJuoVFMSTixY+Sx0iR1GeGPkdkm7/eGuAF0vgB8BUz/QMbvqwXBpHk9hWxZ7eQvSiw/acqHiM8A7yYPEe/Jm4hm39Rigs0W0tPYHBgGS/qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsrHJS/xL6QlNcRxFNr+tiqLUJgt9LvcQOiy6R/ZfpE=;
 b=pjjyxPrwoVuGYN+XyMKYaoZQOsciMTr+F0+uXoEWSTcL7ZuCfiIH2UHNjgngFEUVcNMOK9vjWzmdtn2w60NvlAYxqvwz9M7Drrwv+7Kd0etWRMjSEvyBxwxj3iUd5FirWY3bz4wfZ4N6ckL/EqhDZnyZDLdSttymx1ERZmiyP24=
Received: from AS8PR04CA0067.eurprd04.prod.outlook.com (2603:10a6:20b:313::12)
 by AS8PR06MB7349.eurprd06.prod.outlook.com (2603:10a6:20b:250::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 17:59:00 +0000
Received: from AM3PEPF00009BA2.eurprd04.prod.outlook.com
 (2603:10a6:20b:313:cafe::1e) by AS8PR04CA0067.outlook.office365.com
 (2603:10a6:20b:313::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Wed, 7 Feb 2024 17:59:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AM3PEPF00009BA2.mail.protection.outlook.com (10.167.16.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 17:59:00 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Wed, 7 Feb 2024 18:59:00 +0100
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
Subject: [PATCH v2 2/2] net: phy: dp83826: support TX data voltage tuning
Date: Wed,  7 Feb 2024 18:58:45 +0100
Message-Id: <20240207175845.764775-2-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240207175845.764775-1-catalin.popescu@leica-geosystems.com>
References: <20240207175845.764775-1-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Feb 2024 17:59:00.0668 (UTC) FILETIME=[544477C0:01DA59EF]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA2:EE_|AS8PR06MB7349:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bf6de0df-fe1d-4025-f8f4-08dc280676e4
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kknqylIvyzXK85EDN26AbBwxXC52mOfpiiAjGdLs8hF0WK2UMrccoNn5Kg2MCET/71sPnM+h5HRTm1ECLhyXBYt0EfTExHzIBVJ7rWwnRG9gsRVHsRFji0yelSNRTMp2DgM+F7z67PP+3oyz1jo8vzhA6f08pK+fqvcNdTa8hbYK79zcDoAgS6ntuh2J+BtQFedsVibtJ4ygrOlVdi9HwHh9KPenJpMRL1sh9CFmPTN48eHrryTf6MoNAEozWGdXDFbB0jQudYi/EKklYoSYI+Z1DE8Hdu1/fyCCmVOb0Xa/r5bwtEicAqSAVRFOQi2nTj1gmNfHWtT7zp/61G9G58YY691gRxVuungtRKg7Y/SrxAYnYek8GUv45HTguqkProK6vvDCn17GowawHDdh81tmDF+rq3CrbQjlcy1tnpiBaAWw4MgtLZDUP6qjWSqerhXWxH01WcnLYg4o0iLUyrziOSpxKj/zYu/s5/ncBWIz2wwjEi9Cyh5g53Nm7g7ik2CnfsE/BerzjkJXmvOCYa6xAdo7ZZbz3Wcs8ZkPWi6K5Kcj2meMDbcXo394OLzxJQJeV0Z9EOehF0GWq+KIO5Nw9Nk4r1Xtfe78kGBC6566hp6j6eGcPEZkKL8twMZFhqyuLtpLsejBZ/Bt8B5xoqNWz7bDDS6MOmoRUwBkPOFVlVhW9sZHmN9Dil9TPhtXtAIp0Q8E5xeKj5hHUm8s6CBIXaL0r1hji1wNLciDXYZiT2YWVmp9uvCRxi8Vj9/G6+WAQG15Kq13wrCln1u+JQ==
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(36840700001)(40470700004)(46966006)(44832011)(1076003)(2616005)(107886003)(66899024)(86362001)(26005)(336012)(41300700001)(5660300002)(921011)(2906002)(316002)(450100002)(70206006)(478600001)(70586007)(8676002)(36756003)(8936002)(4326008)(6666004)(40460700003)(36860700001)(81166007)(40480700001)(47076005)(356005)(82740400003)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 17:59:00.8618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6de0df-fe1d-4025-f8f4-08dc280676e4
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7349

DP83826 offers the possibility to tune the voltage of logical levels
of the MLT-3 encoded TX data. This is especially interesting when the
TX data path is lossy and we want to increase the voltage levels to
compensate the loss.

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
Changes in v2:
 - remove raw values mapping tables dp83826_cfg_dac_minus_raw/
   dp83826_cfg_dac_plus_raw and replace them with functions
   dp83826_to_dac_minus_one_regval/dp83826_to_dac_plus_one_regval
 - increase readability of function dp83826_config_init
 - change return value of function dp83826_of_init from int to void
   since it never returns any error
---
 drivers/net/phy/dp83822.c | 130 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 126 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index b7cb71817780..17070bb1a4b0 100644
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
+#define DP83826_CFG_DAC_MPERCENT_PER_STEP	6250
+#define DP83826_CFG_DAC_MPERCENT_DEFAULT	100000
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
+	int tmp = DP83826_CFG_DAC_MPERCENT_DEFAULT - percent;
+
+	return tmp / DP83826_CFG_DAC_MPERCENT_PER_STEP;
+}
+
+static int dp83826_to_dac_plus_one_regval(int percent)
+{
+	int tmp = percent - DP83826_CFG_DAC_MPERCENT_DEFAULT;
+
+	return tmp / DP83826_CFG_DAC_MPERCENT_PER_STEP;
+}
+
+static void dp83826_of_init(struct phy_device *phydev)
+{
+	struct dp83822_private *dp83822 = phydev->priv;
+	struct device *dev = &phydev->mdio.dev;
+	u32 val;
+
+	dp83822->cfg_dac_minus = DP83826_CFG_DAC_MINUS_DEFAULT;
+	if (!device_property_read_u32(dev, "ti,cfg-dac-minus-one-milli-percent", &val))
+		dp83822->cfg_dac_minus += dp83826_to_dac_minus_one_regval(val);
+
+	dp83822->cfg_dac_plus = DP83826_CFG_DAC_PLUS_DEFAULT;
+	if (!device_property_read_u32(dev, "ti,cfg-dac-plus-one-milli-percent", &val))
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


