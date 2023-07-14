Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFCF7537A4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236076AbjGNKOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236061AbjGNKON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:14:13 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2731989;
        Fri, 14 Jul 2023 03:14:11 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 3FCA724E16E;
        Fri, 14 Jul 2023 18:14:10 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 14 Jul
 2023 18:14:10 +0800
Received: from starfive-sdk.starfivetech.com (171.223.208.138) by
 EXMBX062.cuchost.com (172.16.6.62) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Fri, 14 Jul 2023 18:14:08 +0800
From:   Samin Guo <samin.guo@starfivetech.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Frank <Frank.Sae@motor-comm.com>
CC:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "Russell King" <linux@armlinux.org.uk>,
        Samin Guo <samin.guo@starfivetech.com>,
        "Yanhong Wang" <yanhong.wang@starfivetech.com>
Subject: [PATCH v4 2/2] net: phy: motorcomm: Add pad drive strength cfg support
Date:   Fri, 14 Jul 2023 18:14:06 +0800
Message-ID: <20230714101406.17686-3-samin.guo@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230714101406.17686-1-samin.guo@starfivetech.com>
References: <20230714101406.17686-1-samin.guo@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The motorcomm phy (YT8531) supports the ability to adjust the drive
strength of the rx_clk/rx_data, and the default strength may not be
suitable for all boards. So add configurable options to better match
the boards.(e.g. StarFive VisionFive 2)

When we configure the drive strength, we need to read the current
LDO voltage value to ensure that it is a legal value at that LDO
voltage.

Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
Signed-off-by: Samin Guo <samin.guo@starfivetech.com>
---
 drivers/net/phy/motorcomm.c | 114 ++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 2fa5a90e073b..857a451fa35e 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -163,6 +163,10 @@
 
 #define YT8521_CHIP_CONFIG_REG			0xA001
 #define YT8521_CCR_SW_RST			BIT(15)
+#define YT8531_RGMII_LDO_VOL_MASK		GENMASK(5, 4)
+#define YT8531_LDO_VOL_3V3			0x0
+#define YT8531_LDO_VOL_1V8			0x2
+
 /* 1b0 disable 1.9ns rxc clock delay  *default*
  * 1b1 enable 1.9ns rxc clock delay
  */
@@ -236,6 +240,12 @@
  */
 #define YTPHY_WCR_TYPE_PULSE			BIT(0)
 
+#define YTPHY_PAD_DRIVE_STRENGTH_REG		0xA010
+#define YT8531_RGMII_RXC_DS_MASK		GENMASK(15, 13)
+#define YT8531_RGMII_RXD_DS_HI_MASK		BIT(12)		/* Bit 2 of rxd_ds */
+#define YT8531_RGMII_RXD_DS_LOW_MASK		GENMASK(5, 4)	/* Bit 1/0 of rxd_ds */
+#define YT8531_RGMII_RX_DS_DEFAULT		0x3
+
 #define YTPHY_SYNCE_CFG_REG			0xA012
 #define YT8521_SCR_SYNCE_ENABLE			BIT(5)
 /* 1b0 output 25m clock
@@ -834,6 +844,106 @@ static int ytphy_rgmii_clk_delay_config_with_lock(struct phy_device *phydev)
 	return ret;
 }
 
+/**
+ * struct ytphy_ldo_vol_map - map a current value to a register value
+ * @vol: ldo voltage
+ * @ds:  value in the register
+ * @cur: value in device configuration
+ */
+struct ytphy_ldo_vol_map {
+	u32 vol;
+	u32 ds;
+	u32 cur;
+};
+
+static const struct ytphy_ldo_vol_map yt8531_ldo_vol[] = {
+	{.vol = YT8531_LDO_VOL_1V8, .ds = 0, .cur = 1200},
+	{.vol = YT8531_LDO_VOL_1V8, .ds = 1, .cur = 2100},
+	{.vol = YT8531_LDO_VOL_1V8, .ds = 2, .cur = 2700},
+	{.vol = YT8531_LDO_VOL_1V8, .ds = 3, .cur = 2910},
+	{.vol = YT8531_LDO_VOL_1V8, .ds = 4, .cur = 3110},
+	{.vol = YT8531_LDO_VOL_1V8, .ds = 5, .cur = 3600},
+	{.vol = YT8531_LDO_VOL_1V8, .ds = 6, .cur = 3970},
+	{.vol = YT8531_LDO_VOL_1V8, .ds = 7, .cur = 4350},
+	{.vol = YT8531_LDO_VOL_3V3, .ds = 0, .cur = 3070},
+	{.vol = YT8531_LDO_VOL_3V3, .ds = 1, .cur = 4080},
+	{.vol = YT8531_LDO_VOL_3V3, .ds = 2, .cur = 4370},
+	{.vol = YT8531_LDO_VOL_3V3, .ds = 3, .cur = 4680},
+	{.vol = YT8531_LDO_VOL_3V3, .ds = 4, .cur = 5020},
+	{.vol = YT8531_LDO_VOL_3V3, .ds = 5, .cur = 5450},
+	{.vol = YT8531_LDO_VOL_3V3, .ds = 6, .cur = 5740},
+	{.vol = YT8531_LDO_VOL_3V3, .ds = 7, .cur = 6140},
+};
+
+static u32 yt8531_get_ldo_vol(struct phy_device *phydev)
+{
+	u32 val;
+
+	val = ytphy_read_ext_with_lock(phydev, YT8521_CHIP_CONFIG_REG);
+	val = FIELD_GET(YT8531_RGMII_LDO_VOL_MASK, val);
+
+	return val <= YT8531_LDO_VOL_1V8 ? val : YT8531_LDO_VOL_1V8;
+}
+
+static u32 yt8531_get_ds_map(struct phy_device *phydev, u32 cur)
+{
+	u32 vol;
+	int i;
+
+	vol = yt8531_get_ldo_vol(phydev);
+	for (i = 0; i < ARRAY_SIZE(yt8531_ldo_vol); i++) {
+		if (yt8531_ldo_vol[i].vol == vol && yt8531_ldo_vol[i].cur == cur)
+			return yt8531_ldo_vol[i].ds;
+	}
+
+	phydev_warn(phydev,
+		    "No matching current value was found %d, Use default value.\n", cur);
+
+	return YT8531_RGMII_RX_DS_DEFAULT;
+}
+
+static int yt8531_set_ds(struct phy_device *phydev)
+{
+	struct device_node *node = phydev->mdio.dev.of_node;
+	u32 ds_field_low, ds_field_hi;
+	u32 ds, val;
+	int ret;
+
+	/* set rgmii rx clk driver strength */
+	if (!of_property_read_u32(node, "motorcomm,rx-clk-driver-strength", &val))
+		ds = yt8531_get_ds_map(phydev, val);
+	else
+		ds = YT8531_RGMII_RX_DS_DEFAULT;
+
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YTPHY_PAD_DRIVE_STRENGTH_REG,
+					 YT8531_RGMII_RXC_DS_MASK,
+					 FIELD_PREP(YT8531_RGMII_RXC_DS_MASK, ds));
+	if (ret < 0)
+		return ret;
+
+	/* set rgmii rx data driver strength */
+	if (!of_property_read_u32(node, "motorcomm,rx-data-driver-strength", &val))
+		ds = yt8531_get_ds_map(phydev, val);
+	else
+		ds = YT8531_RGMII_RX_DS_DEFAULT;
+
+	ds_field_hi = FIELD_GET(BIT(2), ds);
+	ds_field_hi = FIELD_PREP(YT8531_RGMII_RXD_DS_HI_MASK, ds_field_hi);
+
+	ds_field_low = FIELD_GET(GENMASK(1, 0), ds);
+	ds_field_low = FIELD_PREP(YT8531_RGMII_RXD_DS_LOW_MASK, ds_field_low);
+
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YTPHY_PAD_DRIVE_STRENGTH_REG,
+					 YT8531_RGMII_RXD_DS_LOW_MASK | YT8531_RGMII_RXD_DS_HI_MASK,
+					 ds_field_low | ds_field_hi);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 /**
  * yt8521_probe() - read chip config then set suitable polling_mode
  * @phydev: a pointer to a &struct phy_device
@@ -1518,6 +1628,10 @@ static int yt8531_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
+	ret = yt8531_set_ds(phydev);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
-- 
2.17.1

