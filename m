Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299C97F14E6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 14:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbjKTNwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 08:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbjKTNvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 08:51:54 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC186D4B;
        Mon, 20 Nov 2023 05:51:36 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c87acba73bso17908651fa.1;
        Mon, 20 Nov 2023 05:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700488295; x=1701093095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GIf/7OpP8VtEJNt4sR3DXzoJdNlezeJaMEZxH0YUM0o=;
        b=MIyUMT8PelQ67olLv87UXHhxjI/iyYzIpcE7MB8VsB89H20cJ2nFoNBO0NrzWb+5Yn
         YrIwlpYjZTyw1jtUxbdbo0KSVMyu1KsAwPobUaKyQhz8nyj8Ju0OeogEp/3SlE9adC86
         odY5xKHtMdWL3CxbfF3xvaQQDi7CAQrJIP9kON0Zce6UD3JqwYRSfHvgr7tIPNjpknLc
         T/SsL7zp79atKX1wG3X/Ifbqcoxh+iZNy9yQj+DDXeLufplN5czqrcBE34yCkvr/boq5
         Tb/vQojqATc5naYmUUwIKMkQvtfTP26aXRohigRPTHli/U9CeUo3aIGx8VE+W6vIa5Br
         VYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700488295; x=1701093095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GIf/7OpP8VtEJNt4sR3DXzoJdNlezeJaMEZxH0YUM0o=;
        b=ioYxNpExWLWtXJKbL/ioc3MV6MmaIiNMd2/xrGTEvaaAYG3D5XHyJdDIDMmN4Nhbbo
         JXeQcskfMyw9EuV5ndOP4mDJMe3nf3a3kxCIv71an7y2e4lAu+X0qy2m/o0VaehwwdGz
         Dww0EqnLPNQVLZogegRV8Fu2ZZSeqDUJRbVvsp3jZKHX9utap8IHauiPnuoQvcKfAhSs
         KRpNuQHKLbEJWoicZs9toTSoFiZWEPdjIpRwzn77sbV7oFwGI46+4xWu5qMhWEhyYFcH
         c5g2FAnlo5Psb+Nv2VlaqWcSm2QT/qKGSqlTGrzRPVf6h+sRTJi9WqqAz3kLi78vCjKn
         9BJg==
X-Gm-Message-State: AOJu0Yy6qGViDtMklo0SzR25DVitlv5jl9CzsS5+VmdQ1pxjXh8eXq1V
        mVLCo07NV3YP17DUnRP0q+F4JCvJ3ZQ=
X-Google-Smtp-Source: AGHT+IGNG/CqatG35iNvkBw+BbCu3x+dR7FxjR/Rwbwjxh+7pqa/JRoV2sSvFgNdFxXPxvvTAa8z6A==
X-Received: by 2002:a05:651c:311:b0:2c8:5b9b:397c with SMTP id a17-20020a05651c031100b002c85b9b397cmr4630573ljp.32.1700488294817;
        Mon, 20 Nov 2023 05:51:34 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id j33-20020a05600c1c2100b0040772934b12sm18205846wms.7.2023.11.20.05.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 05:51:34 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Harini Katakam <harini.katakam@amd.com>,
        Simon Horman <horms@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [net-next RFC PATCH 14/14] net: phy: qca807x: Add support for configurable LED
Date:   Mon, 20 Nov 2023 14:50:41 +0100
Message-Id: <20231120135041.15259-15-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231120135041.15259-1-ansuelsmth@gmail.com>
References: <20231120135041.15259-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCA8072/5 have up to 2 LEDs attached for PHY.

LEDs can be configured to be ON/hw blink or be set to HW control.

Hw blink mode is set to blink at 4Hz or 250ms.

PHY can support both copper (TP) or fiber (FIBRE) kind and supports
different HW control modes based on the port type.

HW control modes supported for netdev trigger for copper ports are:
- LINK_10
- LINK_100
- LINK_1000
- TX
- RX
- FULL_DUPLEX
- HALF_DUPLEX

HW control modes supported for netdev trigger for fiber ports are:
- LINK_100
- LINK_1000
- TX
- RX
- FULL_DUPLEX
- HALF_DUPLEX

LED support conflicts with GPIO controller feature and must be disabled
if gpio-controller is used for the PHY.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/qca807x.c | 382 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 375 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/qca807x.c b/drivers/net/phy/qca807x.c
index 5b82af52778a..a0daf65d872d 100644
--- a/drivers/net/phy/qca807x.c
+++ b/drivers/net/phy/qca807x.c
@@ -80,17 +80,60 @@
 #define QCA807X_MMD7_1000BASE_T_POWER_SAVE_PER_CABLE_LENGTH	0x801a
 #define QCA807X_CONTROL_DAC_MASK				GENMASK(2, 0)
 
+#define QCA807X_MMD7_LED_GLOBAL				0x8073
+#define QCA807X_LED_BLINK_1				GENMASK(11, 6)
+#define QCA807X_LED_BLINK_2				GENMASK(5, 0)
+/* Values are the same for both BLINK_1 and BLINK_2 */
+#define QCA807X_LED_BLINK_FREQ_MASK			GENMASK(5, 3)
+#define QCA807X_LED_BLINK_FREQ_2HZ			FIELD_PREP(QCA807X_LED_BLINK_FREQ_MASK, 0x0)
+#define QCA807X_LED_BLINK_FREQ_4HZ			FIELD_PREP(QCA807X_LED_BLINK_FREQ_MASK, 0x1)
+#define QCA807X_LED_BLINK_FREQ_8HZ			FIELD_PREP(QCA807X_LED_BLINK_FREQ_MASK, 0x2)
+#define QCA807X_LED_BLINK_FREQ_16HZ			FIELD_PREP(QCA807X_LED_BLINK_FREQ_MASK, 0x3)
+#define QCA807X_LED_BLINK_FREQ_32HZ			FIELD_PREP(QCA807X_LED_BLINK_FREQ_MASK, 0x4)
+#define QCA807X_LED_BLINK_FREQ_64HZ			FIELD_PREP(QCA807X_LED_BLINK_FREQ_MASK, 0x5)
+#define QCA807X_LED_BLINK_FREQ_128HZ			FIELD_PREP(QCA807X_LED_BLINK_FREQ_MASK, 0x6)
+#define QCA807X_LED_BLINK_FREQ_256HZ			FIELD_PREP(QCA807X_LED_BLINK_FREQ_MASK, 0x7)
+#define QCA807X_LED_BLINK_DUTY_MASK			GENMASK(2, 0)
+#define QCA807X_LED_BLINK_DUTY_50_50			FIELD_PREP(QCA807X_LED_BLINK_DUTY_MASK, 0x0)
+#define QCA807X_LED_BLINK_DUTY_75_25			FIELD_PREP(QCA807X_LED_BLINK_DUTY_MASK, 0x1)
+#define QCA807X_LED_BLINK_DUTY_25_75			FIELD_PREP(QCA807X_LED_BLINK_DUTY_MASK, 0x2)
+#define QCA807X_LED_BLINK_DUTY_33_67			FIELD_PREP(QCA807X_LED_BLINK_DUTY_MASK, 0x3)
+#define QCA807X_LED_BLINK_DUTY_67_33			FIELD_PREP(QCA807X_LED_BLINK_DUTY_MASK, 0x4)
+#define QCA807X_LED_BLINK_DUTY_17_83			FIELD_PREP(QCA807X_LED_BLINK_DUTY_MASK, 0x5)
+#define QCA807X_LED_BLINK_DUTY_83_17			FIELD_PREP(QCA807X_LED_BLINK_DUTY_MASK, 0x6)
+#define QCA807X_LED_BLINK_DUTY_8_92			FIELD_PREP(QCA807X_LED_BLINK_DUTY_MASK, 0x7)
 #define QCA807X_MMD7_LED_100N_1				0x8074
 #define QCA807X_MMD7_LED_100N_2				0x8075
 #define QCA807X_MMD7_LED_1000N_1			0x8076
 #define QCA807X_MMD7_LED_1000N_2			0x8077
-#define QCA807X_LED_TXACT_BLK_EN_2			BIT(10)
-#define QCA807X_LED_RXACT_BLK_EN_2			BIT(9)
-#define QCA807X_LED_GT_ON_EN_2				BIT(6)
-#define QCA807X_LED_HT_ON_EN_2				BIT(5)
-#define QCA807X_LED_BT_ON_EN_2				BIT(4)
-#define QCA807X_GPIO_FORCE_EN				BIT(15)
-#define QCA807X_GPIO_FORCE_MODE_MASK			GENMASK(14, 13)
+/* Values are the same for LED1 and LED2 */
+/* Values for control 1 */
+#define QCA807X_LED_COPPER_ON_BLINK_MASK		GENMASK(12, 0)
+#define QCA807X_LED_FDX_ON_EN				BIT(12)
+#define QCA807X_LED_HDX_ON_EN				BIT(11)
+#define QCA807X_LED_TXACT_BLK_EN			BIT(10)
+#define QCA807X_LED_RXACT_BLK_EN			BIT(9)
+#define QCA807X_LED_GT_ON_EN				BIT(6)
+#define QCA807X_LED_HT_ON_EN				BIT(5)
+#define QCA807X_LED_BT_ON_EN				BIT(4)
+/* Values for control 2 */
+#define QCA807X_LED_FORCE_EN				BIT(15)
+#define QCA807X_LED_FORCE_MODE_MASK			GENMASK(14, 13)
+#define QCA807X_LED_FORCE_BLINK_1			FIELD_PREP(QCA807X_LED_FORCE_MODE_MASK, 0x3)
+#define QCA807X_LED_FORCE_BLINK_2			FIELD_PREP(QCA807X_LED_FORCE_MODE_MASK, 0x2)
+#define QCA807X_LED_FORCE_ON				FIELD_PREP(QCA807X_LED_FORCE_MODE_MASK, 0x1)
+#define QCA807X_LED_FORCE_OFF				FIELD_PREP(QCA807X_LED_FORCE_MODE_MASK, 0x0)
+#define QCA807X_LED_FIBER_ON_BLINK_MASK			GENMASK(11, 1)
+#define QCA807X_LED_FIBER_TXACT_BLK_EN			BIT(10)
+#define QCA807X_LED_FIBER_RXACT_BLK_EN			BIT(9)
+#define QCA807X_LED_FIBER_FDX_ON_EN			BIT(6)
+#define QCA807X_LED_FIBER_HDX_ON_EN			BIT(5)
+#define QCA807X_LED_FIBER_1000BX_ON_EN			BIT(2)
+#define QCA807X_LED_FIBER_100FX_ON_EN			BIT(1)
+
+/* Some device repurpose the LED as GPIO out */
+#define QCA807X_GPIO_FORCE_EN				QCA807X_LED_FORCE_EN
+#define QCA807X_GPIO_FORCE_MODE_MASK			QCA807X_LED_FORCE_MODE_MASK
 
 #define QCA807X_INTR_ENABLE				0x12
 #define QCA807X_INTR_STATUS				0x13
@@ -338,6 +381,320 @@ static int qca807x_cable_test_start(struct phy_device *phydev)
 	return ret;
 }
 
+static int qca807x_led_parse_netdev(struct phy_device *phydev, unsigned long rules,
+				    u16 *offload_trigger)
+{
+	/* Parsing specific to netdev trigger */
+	switch (phydev->port) {
+	case PORT_TP:
+		if (test_bit(TRIGGER_NETDEV_TX, &rules))
+			*offload_trigger |= QCA807X_LED_TXACT_BLK_EN;
+		if (test_bit(TRIGGER_NETDEV_RX, &rules))
+			*offload_trigger |= QCA807X_LED_RXACT_BLK_EN;
+		if (test_bit(TRIGGER_NETDEV_LINK_10, &rules))
+			*offload_trigger |= QCA807X_LED_BT_ON_EN;
+		if (test_bit(TRIGGER_NETDEV_LINK_100, &rules))
+			*offload_trigger |= QCA807X_LED_HT_ON_EN;
+		if (test_bit(TRIGGER_NETDEV_LINK_1000, &rules))
+			*offload_trigger |= QCA807X_LED_GT_ON_EN;
+		if (test_bit(TRIGGER_NETDEV_HALF_DUPLEX, &rules))
+			*offload_trigger |= QCA807X_LED_HDX_ON_EN;
+		if (test_bit(TRIGGER_NETDEV_FULL_DUPLEX, &rules))
+			*offload_trigger |= QCA807X_LED_FDX_ON_EN;
+		break;
+	case PORT_FIBRE:
+		if (test_bit(TRIGGER_NETDEV_TX, &rules))
+			*offload_trigger |= QCA807X_LED_FIBER_TXACT_BLK_EN;
+		if (test_bit(TRIGGER_NETDEV_RX, &rules))
+			*offload_trigger |= QCA807X_LED_FIBER_RXACT_BLK_EN;
+		if (test_bit(TRIGGER_NETDEV_LINK_100, &rules))
+			*offload_trigger |= QCA807X_LED_FIBER_100FX_ON_EN;
+		if (test_bit(TRIGGER_NETDEV_LINK_1000, &rules))
+			*offload_trigger |= QCA807X_LED_FIBER_1000BX_ON_EN;
+		if (test_bit(TRIGGER_NETDEV_HALF_DUPLEX, &rules))
+			*offload_trigger |= QCA807X_LED_FIBER_HDX_ON_EN;
+		if (test_bit(TRIGGER_NETDEV_FULL_DUPLEX, &rules))
+			*offload_trigger |= QCA807X_LED_FIBER_FDX_ON_EN;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	if (rules && !*offload_trigger)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static int qca807x_led_hw_control_enable(struct phy_device *phydev, u8 index)
+{
+	int val, reg, ret;
+
+	switch (index) {
+	case 0:
+		reg = QCA807X_MMD7_LED_100N_2;
+		break;
+	case 1:
+		reg = QCA807X_MMD7_LED_1000N_2;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	val = phy_read_mmd(phydev, MDIO_MMD_AN, reg);
+	val &= ~QCA807X_LED_FORCE_EN;
+	ret = phy_write_mmd(phydev, MDIO_MMD_AN, reg, val);
+
+	return ret;
+}
+
+static int qca807x_led_hw_is_supported(struct phy_device *phydev, u8 index,
+				       unsigned long rules)
+{
+	u16 offload_trigger = 0;
+
+	if (index > 1)
+		return -EINVAL;
+
+	return qca807x_led_parse_netdev(phydev, rules, &offload_trigger);
+}
+
+static int qca807x_led_hw_control_set(struct phy_device *phydev, u8 index,
+				      unsigned long rules)
+{
+	int val, ret, copper_reg, fibre_reg;
+	u16 offload_trigger = 0;
+
+	switch (index) {
+	case 0:
+		copper_reg = QCA807X_MMD7_LED_100N_1;
+		fibre_reg = QCA807X_MMD7_LED_100N_2;
+		break;
+	case 1:
+		copper_reg = QCA807X_MMD7_LED_1000N_1;
+		fibre_reg = QCA807X_MMD7_LED_1000N_2;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = qca807x_led_parse_netdev(phydev, rules, &offload_trigger);
+	if (ret)
+		return ret;
+
+	ret = qca807x_led_hw_control_enable(phydev, index);
+	if (ret)
+		return ret;
+
+	switch (phydev->port) {
+	case PORT_TP:
+		val = phy_read_mmd(phydev, MDIO_MMD_AN, copper_reg);
+		val &= ~QCA807X_LED_COPPER_ON_BLINK_MASK;
+		val |= offload_trigger;
+		ret = phy_write_mmd(phydev, MDIO_MMD_AN, copper_reg, val);
+		break;
+	case PORT_FIBRE:
+		val = phy_read_mmd(phydev, MDIO_MMD_AN, fibre_reg);
+		val &= ~QCA807X_LED_FIBER_ON_BLINK_MASK;
+		val |= offload_trigger;
+		ret = phy_write_mmd(phydev, MDIO_MMD_AN, fibre_reg, val);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static bool qca807x_led_hw_control_status(struct phy_device *phydev, u8 index)
+{
+	int val, reg;
+
+	switch (index) {
+	case 0:
+		reg = QCA807X_MMD7_LED_100N_2;
+		break;
+	case 1:
+		reg = QCA807X_MMD7_LED_1000N_2;
+		break;
+	default:
+		return false;
+	}
+
+	val = phy_read_mmd(phydev, MDIO_MMD_AN, reg);
+
+	return !(val & QCA807X_LED_FORCE_EN);
+}
+
+static int qca807x_led_hw_control_get(struct phy_device *phydev, u8 index,
+				      unsigned long *rules)
+{
+	int val, copper_reg, fibre_reg;
+
+	switch (index) {
+	case 0:
+		copper_reg = QCA807X_MMD7_LED_100N_1;
+		fibre_reg = QCA807X_MMD7_LED_100N_2;
+		break;
+	case 1:
+		copper_reg = QCA807X_MMD7_LED_1000N_1;
+		fibre_reg = QCA807X_MMD7_LED_100N_2;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Check if we have hw control enabled */
+	if (qca807x_led_hw_control_status(phydev, index))
+		return -EINVAL;
+
+	/* Parsing specific to netdev trigger */
+	switch (phydev->port) {
+	case PORT_TP:
+		val = phy_read_mmd(phydev, MDIO_MMD_AN, copper_reg);
+		if (val & QCA807X_LED_TXACT_BLK_EN)
+			set_bit(TRIGGER_NETDEV_TX, rules);
+		if (val & QCA807X_LED_RXACT_BLK_EN)
+			set_bit(TRIGGER_NETDEV_RX, rules);
+		if (val & QCA807X_LED_BT_ON_EN)
+			set_bit(TRIGGER_NETDEV_LINK_10, rules);
+		if (val & QCA807X_LED_HT_ON_EN)
+			set_bit(TRIGGER_NETDEV_LINK_100, rules);
+		if (val & QCA807X_LED_GT_ON_EN)
+			set_bit(TRIGGER_NETDEV_LINK_1000, rules);
+		if (val & QCA807X_LED_HDX_ON_EN)
+			set_bit(TRIGGER_NETDEV_HALF_DUPLEX, rules);
+		if (val & QCA807X_LED_FDX_ON_EN)
+			set_bit(TRIGGER_NETDEV_FULL_DUPLEX, rules);
+		break;
+	case PORT_FIBRE:
+		val = phy_read_mmd(phydev, MDIO_MMD_AN, fibre_reg);
+		if (val & QCA807X_LED_FIBER_TXACT_BLK_EN)
+			set_bit(TRIGGER_NETDEV_TX, rules);
+		if (val & QCA807X_LED_FIBER_RXACT_BLK_EN)
+			set_bit(TRIGGER_NETDEV_RX, rules);
+		if (val & QCA807X_LED_FIBER_100FX_ON_EN)
+			set_bit(TRIGGER_NETDEV_LINK_100, rules);
+		if (val & QCA807X_LED_FIBER_1000BX_ON_EN)
+			set_bit(TRIGGER_NETDEV_LINK_1000, rules);
+		if (val & QCA807X_LED_FIBER_HDX_ON_EN)
+			set_bit(TRIGGER_NETDEV_HALF_DUPLEX, rules);
+		if (val & QCA807X_LED_FIBER_FDX_ON_EN)
+			set_bit(TRIGGER_NETDEV_FULL_DUPLEX, rules);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int qca807x_led_hw_control_reset(struct phy_device *phydev, u8 index)
+{
+	int val, copper_reg, fibre_reg, ret;
+
+	switch (index) {
+	case 0:
+		copper_reg = QCA807X_MMD7_LED_100N_1;
+		fibre_reg = QCA807X_MMD7_LED_100N_2;
+		break;
+	case 1:
+		copper_reg = QCA807X_MMD7_LED_1000N_1;
+		fibre_reg = QCA807X_MMD7_LED_100N_2;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (phydev->port) {
+	case PORT_TP:
+		val = phy_read_mmd(phydev, MDIO_MMD_AN, copper_reg);
+		val &= ~QCA807X_LED_COPPER_ON_BLINK_MASK;
+		ret = phy_write_mmd(phydev, MDIO_MMD_AN, copper_reg, val);
+		break;
+	case PORT_FIBRE:
+		val = phy_read_mmd(phydev, MDIO_MMD_AN, fibre_reg);
+		val &= ~QCA807X_LED_FIBER_ON_BLINK_MASK;
+		ret = phy_write_mmd(phydev, MDIO_MMD_AN, fibre_reg, val);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int qca807x_led_brightness_set(struct phy_device *phydev,
+				      u8 index, enum led_brightness value)
+{
+	int val, ret;
+	u16 reg;
+
+	switch (index) {
+	case 0:
+		reg = QCA807X_MMD7_LED_100N_2;
+		break;
+	case 1:
+		reg = QCA807X_MMD7_LED_1000N_2;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* If we are setting off the LED reset any hw control rule */
+	if (!value) {
+		ret = qca807x_led_hw_control_reset(phydev, index);
+		if (ret)
+			return ret;
+	}
+
+	val = phy_read_mmd(phydev, MDIO_MMD_AN, reg);
+	val &= ~(QCA807X_LED_FORCE_EN | QCA807X_LED_FORCE_MODE_MASK);
+	val |= QCA807X_LED_FORCE_EN;
+	if (value)
+		val |= QCA807X_LED_FORCE_ON;
+	ret = phy_write_mmd(phydev, MDIO_MMD_AN, reg, val);
+
+	return ret;
+}
+
+static int qca807x_led_blink_set(struct phy_device *phydev, u8 index,
+				 unsigned long *delay_on,
+				 unsigned long *delay_off)
+{
+	int val, ret;
+	u16 reg;
+
+	switch (index) {
+	case 0:
+		reg = QCA807X_MMD7_LED_100N_2;
+		break;
+	case 1:
+		reg = QCA807X_MMD7_LED_1000N_2;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Set blink to 50% off, 50% on at 4Hz by default */
+	val = phy_read_mmd(phydev, MDIO_MMD_AN, QCA807X_MMD7_LED_GLOBAL);
+	val &= ~(QCA807X_LED_BLINK_FREQ_MASK | QCA807X_LED_BLINK_DUTY_MASK);
+	val |= QCA807X_LED_BLINK_FREQ_4HZ | QCA807X_LED_BLINK_DUTY_50_50;
+	ret = phy_write_mmd(phydev, MDIO_MMD_AN, QCA807X_MMD7_LED_GLOBAL, val);
+
+	/* We use BLINK_1 for normal blinking */
+	val = phy_read_mmd(phydev, MDIO_MMD_AN, reg);
+	val &= ~(QCA807X_LED_FORCE_EN | QCA807X_LED_FORCE_MODE_MASK);
+	val |= QCA807X_LED_FORCE_EN | QCA807X_LED_FORCE_BLINK_1;
+	ret = phy_write_mmd(phydev, MDIO_MMD_AN, reg, val);
+
+	/* We set blink to 4Hz, aka 250ms */
+	*delay_on = 250 / 2;
+	*delay_off = 250 / 2;
+
+	return ret;
+}
+
 #ifdef CONFIG_GPIOLIB
 static int qca807x_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
 {
@@ -716,6 +1073,12 @@ static int qca807x_probe(struct phy_device *phydev)
 			ret = qca807x_gpio(phydev);
 			if (ret)
 				return ret;
+
+			phydev->drv->led_brightness_set = NULL;
+			phydev->drv->led_blink_set = NULL;
+			phydev->drv->led_hw_is_supported = NULL;
+			phydev->drv->led_hw_control_set = NULL;
+			phydev->drv->led_hw_control_get = NULL;
 		}
 	}
 
@@ -843,6 +1206,11 @@ static struct phy_driver qca807x_drivers[] = {
 		.suspend	= genphy_suspend,
 		.cable_test_start	= qca807x_cable_test_start,
 		.cable_test_get_status	= qca807x_cable_test_get_status,
+		.led_brightness_set = qca807x_led_brightness_set,
+		.led_blink_set = qca807x_led_blink_set,
+		.led_hw_is_supported = qca807x_led_hw_is_supported,
+		.led_hw_control_set = qca807x_led_hw_control_set,
+		.led_hw_control_get = qca807x_led_hw_control_get,
 		/* PHY package define */
 		.phy_package_global_phy_num = ARRAY_SIZE(qca807x_global_phy_names),
 		.phy_package_global_phy_names = qca807x_global_phy_names,
-- 
2.40.1

