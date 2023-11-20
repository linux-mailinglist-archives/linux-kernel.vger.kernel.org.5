Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170467F14E2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 14:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbjKTNwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 08:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbjKTNvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 08:51:44 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7A71AA;
        Mon, 20 Nov 2023 05:51:34 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40859c466efso16144705e9.3;
        Mon, 20 Nov 2023 05:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700488293; x=1701093093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lwOqpq8wMuGFvFAyqjc9ntVImZ49seWbU3wj+Y9SX8M=;
        b=ji14EHQov7fyk/OvaaNMrxT4AlYBd7e84GmAu/3P3XbrJNjvZnZnw9qT4Cn1gW7yY2
         hhpRBTTOYvlaXj4drASFQeIyenzoy9NPfZ0iIgW1KZLOjGC0IKJnuWwnTlaxB2bliByh
         ns+L4bUOfC3OcuV7qF6Bz3FffWvRGziXimoJmjJzhpdZ9bwCF5ItiLWuRj9k40+MqHnq
         sw40E7ljIWQAinKedUTAdODIJAnQUslaLW7/j+dRETZ+mRqb4EBvXSW1eXVBNt8pEN3j
         T4SzK87oLKotiRwmrXcqFb3Ea5/tGwzXNxdbpaN9y60OotVmjt18ypvvih2Qp3+RW+y1
         rlgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700488293; x=1701093093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwOqpq8wMuGFvFAyqjc9ntVImZ49seWbU3wj+Y9SX8M=;
        b=vbX7pB3bDIE6PUmuY1o44ITYNtzQ1ejE5TLfsTvNwKzMvf0hO7Nx6wf8WI8ACABufd
         AlpLb9s+SKu8AI22r73s7vC4Pmd9ZET0Jd6Ld1E2sVxZF5te93g4O8RjpwIApX5HXrnH
         0Vb3AFew3V+jvHFXKeT2dBoR/bY+Us6/fGXHnWBXapLMnEO0wgDxLA1JVRauG7alDZNE
         aEBuUalKrIQiuCT6HynkRyRZxMEra+DOYRVEKXXs9YOsNR37qHWxscj+yOEkzjDB57Px
         H/j7cTZ9QlFVySMchX5tLGhBxB4xnuWjZv2WXyTyGyhA7vFKJxHKmye2YmGYgyKbEddY
         Bahw==
X-Gm-Message-State: AOJu0YxSvpwWT3gB8ZrIBeT7veiI8mR/BAhdY0YFDQGCBr5f9I/m5puE
        zrcTS6V9UtF+p2ZIIhux0K4=
X-Google-Smtp-Source: AGHT+IFmg+IDN1S5hiDX/OCJuB0kKVd53gCz/3x1PpP8nqnLbxDFU7dX760HGV1Bk2uTz15Nrzm28w==
X-Received: by 2002:a05:600c:4f55:b0:406:411f:742e with SMTP id m21-20020a05600c4f5500b00406411f742emr6269618wmq.34.1700488293121;
        Mon, 20 Nov 2023 05:51:33 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id j33-20020a05600c1c2100b0040772934b12sm18205846wms.7.2023.11.20.05.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 05:51:32 -0800 (PST)
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
Subject: [net-next RFC PATCH 13/14] net: phy: add Qualcom QCA807x driver
Date:   Mon, 20 Nov 2023 14:50:40 +0100
Message-Id: <20231120135041.15259-14-ansuelsmth@gmail.com>
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

From: Robert Marko <robert.marko@sartura.hr>

This adds driver for the Qualcomm QCA8072 and QCA8075 PHY-s.

They are 2 or 5 port IEEE 802.3 clause 22 compliant 10BASE-Te,
100BASE-TX and 1000BASE-T PHY-s.

They feature 2 SerDes, one for PSGMII or QSGMII connection with
MAC, while second one is SGMII for connection to MAC or fiber.

Both models have a combo port that supports 1000BASE-X and
100BASE-FX fiber.

Each PHY inside of QCA807x series has 4 digitally controlled
output only pins that natively drive LED-s.
But some vendors used these to driver generic LED-s controlled
by userspace, so lets enable registering each PHY as GPIO
controller and add driver for it.

These are commonly used in Qualcomm IPQ40xx, IPQ60xx and IPQ807x
boards.

Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/Kconfig   |   7 +
 drivers/net/phy/Makefile  |   1 +
 drivers/net/phy/qca807x.c | 864 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 872 insertions(+)
 create mode 100644 drivers/net/phy/qca807x.c

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 25cfc5ded1da..5ad85bd978a0 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -325,6 +325,13 @@ config AT803X_PHY
 	  Currently supports the AR8030, AR8031, AR8033, AR8035 and internal
 	  QCA8337(Internal qca8k PHY) model
 
+config QCA807X_PHY
+	tristate "Qualcomm QCA807x PHYs"
+	depends on OF_MDIO
+	help
+	  Currently supports the Qualcomm QCA8072, QCA8075 and the PSGMII
+	  control PHY.
+
 config QSEMI_PHY
 	tristate "Quality Semiconductor PHYs"
 	help
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index f65e85c91fc1..a4da4f127b23 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_NCN26000_PHY)	+= ncn26000.o
 obj-$(CONFIG_NXP_C45_TJA11XX_PHY)	+= nxp-c45-tja11xx.o
 obj-$(CONFIG_NXP_CBTX_PHY)	+= nxp-cbtx.o
 obj-$(CONFIG_NXP_TJA11XX_PHY)	+= nxp-tja11xx.o
+obj-$(CONFIG_QCA807X_PHY)		+= qca807x.o
 obj-$(CONFIG_QSEMI_PHY)		+= qsemi.o
 obj-$(CONFIG_REALTEK_PHY)	+= realtek.o
 obj-$(CONFIG_RENESAS_PHY)	+= uPD60620.o
diff --git a/drivers/net/phy/qca807x.c b/drivers/net/phy/qca807x.c
new file mode 100644
index 000000000000..5b82af52778a
--- /dev/null
+++ b/drivers/net/phy/qca807x.c
@@ -0,0 +1,864 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 Sartura Ltd.
+ *
+ * Author: Robert Marko <robert.marko@sartura.hr>
+ *         Christian Marangi <ansuelsmth@gmail.com>
+ *
+ * Qualcomm QCA8072 and QCA8075 PHY driver
+ */
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/phy.h>
+#include <linux/bitfield.h>
+#include <linux/ethtool_netlink.h>
+#include <linux/gpio.h>
+#include <linux/sfp.h>
+
+#include <dt-bindings/net/qcom-qca807x.h>
+
+#define PHY_ID_QCA8072		0x004dd0b2
+#define PHY_ID_QCA8075		0x004dd0b1
+
+/* Downshift */
+#define QCA807X_SMARTSPEED_EN			BIT(5)
+#define QCA807X_SMARTSPEED_RETRY_LIMIT_MASK	GENMASK(4, 2)
+#define QCA807X_SMARTSPEED_RETRY_LIMIT_DEFAULT	5
+#define QCA807X_SMARTSPEED_RETRY_LIMIT_MIN	2
+#define QCA807X_SMARTSPEED_RETRY_LIMIT_MAX	9
+
+/* Cable diagnostic test (CDT) */
+#define QCA807X_CDT						0x16
+#define QCA807X_CDT_ENABLE					BIT(15)
+#define QCA807X_CDT_ENABLE_INTER_PAIR_SHORT			BIT(13)
+#define QCA807X_CDT_STATUS					BIT(11)
+#define QCA807X_CDT_MMD3_STATUS					0x8064
+#define QCA807X_CDT_MDI0_STATUS_MASK				GENMASK(15, 12)
+#define QCA807X_CDT_MDI1_STATUS_MASK				GENMASK(11, 8)
+#define QCA807X_CDT_MDI2_STATUS_MASK				GENMASK(7, 4)
+#define QCA807X_CDT_MDI3_STATUS_MASK				GENMASK(3, 0)
+#define QCA807X_CDT_RESULTS_INVALID				0x0
+#define QCA807X_CDT_RESULTS_OK					0x1
+#define QCA807X_CDT_RESULTS_OPEN				0x2
+#define QCA807X_CDT_RESULTS_SAME_SHORT				0x3
+#define QCA807X_CDT_RESULTS_CROSS_SHORT_WITH_MDI1_SAME_OK	0x4
+#define QCA807X_CDT_RESULTS_CROSS_SHORT_WITH_MDI2_SAME_OK	0x8
+#define QCA807X_CDT_RESULTS_CROSS_SHORT_WITH_MDI3_SAME_OK	0xc
+#define QCA807X_CDT_RESULTS_CROSS_SHORT_WITH_MDI1_SAME_OPEN	0x6
+#define QCA807X_CDT_RESULTS_CROSS_SHORT_WITH_MDI2_SAME_OPEN	0xa
+#define QCA807X_CDT_RESULTS_CROSS_SHORT_WITH_MDI3_SAME_OPEN	0xe
+#define QCA807X_CDT_RESULTS_CROSS_SHORT_WITH_MDI1_SAME_SHORT	0x7
+#define QCA807X_CDT_RESULTS_CROSS_SHORT_WITH_MDI2_SAME_SHORT	0xb
+#define QCA807X_CDT_RESULTS_CROSS_SHORT_WITH_MDI3_SAME_SHORT	0xf
+#define QCA807X_CDT_RESULTS_BUSY				0x9
+#define QCA807X_CDT_MMD3_MDI0_LENGTH				0x8065
+#define QCA807X_CDT_MMD3_MDI1_LENGTH				0x8066
+#define QCA807X_CDT_MMD3_MDI2_LENGTH				0x8067
+#define QCA807X_CDT_MMD3_MDI3_LENGTH				0x8068
+#define QCA807X_CDT_SAME_SHORT_LENGTH_MASK			GENMASK(15, 8)
+#define QCA807X_CDT_CROSS_SHORT_LENGTH_MASK			GENMASK(7, 0)
+
+#define QCA807X_CHIP_CONFIGURATION				0x1f
+#define QCA807X_BT_BX_REG_SEL					BIT(15)
+#define QCA807X_BT_BX_REG_SEL_FIBER				0
+#define QCA807X_BT_BX_REG_SEL_COPPER				1
+#define QCA807X_CHIP_CONFIGURATION_MODE_CFG_MASK		GENMASK(3, 0)
+#define QCA807X_CHIP_CONFIGURATION_MODE_QSGMII_SGMII		4
+#define QCA807X_CHIP_CONFIGURATION_MODE_PSGMII_FIBER		3
+#define QCA807X_CHIP_CONFIGURATION_MODE_PSGMII_ALL_COPPER	0
+
+#define QCA807X_MEDIA_SELECT_STATUS				0x1a
+#define QCA807X_MEDIA_DETECTED_COPPER				BIT(5)
+#define QCA807X_MEDIA_DETECTED_1000_BASE_X			BIT(4)
+#define QCA807X_MEDIA_DETECTED_100_BASE_FX			BIT(3)
+
+#define QCA807X_MMD7_FIBER_MODE_AUTO_DETECTION			0x807e
+#define QCA807X_MMD7_FIBER_MODE_AUTO_DETECTION_EN		BIT(0)
+
+#define QCA807X_MMD7_1000BASE_T_POWER_SAVE_PER_CABLE_LENGTH	0x801a
+#define QCA807X_CONTROL_DAC_MASK				GENMASK(2, 0)
+
+#define QCA807X_MMD7_LED_100N_1				0x8074
+#define QCA807X_MMD7_LED_100N_2				0x8075
+#define QCA807X_MMD7_LED_1000N_1			0x8076
+#define QCA807X_MMD7_LED_1000N_2			0x8077
+#define QCA807X_LED_TXACT_BLK_EN_2			BIT(10)
+#define QCA807X_LED_RXACT_BLK_EN_2			BIT(9)
+#define QCA807X_LED_GT_ON_EN_2				BIT(6)
+#define QCA807X_LED_HT_ON_EN_2				BIT(5)
+#define QCA807X_LED_BT_ON_EN_2				BIT(4)
+#define QCA807X_GPIO_FORCE_EN				BIT(15)
+#define QCA807X_GPIO_FORCE_MODE_MASK			GENMASK(14, 13)
+
+#define QCA807X_INTR_ENABLE				0x12
+#define QCA807X_INTR_STATUS				0x13
+#define QCA807X_INTR_ENABLE_AUTONEG_ERR			BIT(15)
+#define QCA807X_INTR_ENABLE_SPEED_CHANGED		BIT(14)
+#define QCA807X_INTR_ENABLE_DUPLEX_CHANGED		BIT(13)
+#define QCA807X_INTR_ENABLE_LINK_FAIL			BIT(11)
+#define QCA807X_INTR_ENABLE_LINK_SUCCESS		BIT(10)
+
+#define QCA807X_FUNCTION_CONTROL			0x10
+#define QCA807X_FC_MDI_CROSSOVER_MODE_MASK		GENMASK(6, 5)
+#define QCA807X_FC_MDI_CROSSOVER_AUTO			3
+#define QCA807X_FC_MDI_CROSSOVER_MANUAL_MDIX		1
+#define QCA807X_FC_MDI_CROSSOVER_MANUAL_MDI		0
+
+#define QCA807X_PHY_SPECIFIC_STATUS			0x11
+#define QCA807X_SS_SPEED_AND_DUPLEX_RESOLVED		BIT(11)
+#define QCA807X_SS_SPEED_MASK				GENMASK(15, 14)
+#define QCA807X_SS_SPEED_1000				2
+#define QCA807X_SS_SPEED_100				1
+#define QCA807X_SS_SPEED_10				0
+#define QCA807X_SS_DUPLEX				BIT(13)
+#define QCA807X_SS_MDIX					BIT(6)
+
+/* PQSGMII Analog PHY specific */
+#define PQSGMII_CTRL_REG				0x0
+#define PQSGMII_ANALOG_SW_RESET				BIT(6)
+#define PQSGMII_DRIVE_CONTROL_1				0xb
+#define PQSGMII_TX_DRIVER_MASK				GENMASK(7, 4)
+#define PQSGMII_MODE_CTRL				0x6d
+#define PQSGMII_MODE_CTRL_AZ_WORKAROUND_MASK		BIT(0)
+#define PQSGMII_MMD3_SERDES_CONTROL			0x805a
+
+#define SERDES_RESET_SLEEP				100
+
+enum qca807x_global_phy {
+	QCA807X_COMBO_ADDR = 0,
+	QCA807X_PQSGMII_ADDR,
+
+	__QCA807X_GLOBAL_PHY_MAX,
+};
+
+const char * const qca807x_global_phy_names[] = {
+	[QCA807X_COMBO_ADDR] = "combo",
+	[QCA807X_PQSGMII_ADDR] = "pqsgmii",
+};
+
+struct qca807x_gpio_priv {
+	struct phy_device *phy;
+};
+
+static int qca807x_get_downshift(struct phy_device *phydev, u8 *data)
+{
+	int val, cnt, enable;
+
+	val = phy_read(phydev, MII_NWAYTEST);
+	if (val < 0)
+		return val;
+
+	enable = FIELD_GET(QCA807X_SMARTSPEED_EN, val);
+	cnt = FIELD_GET(QCA807X_SMARTSPEED_RETRY_LIMIT_MASK, val) + 2;
+
+	*data = enable ? cnt : DOWNSHIFT_DEV_DISABLE;
+
+	return 0;
+}
+
+static int qca807x_set_downshift(struct phy_device *phydev, u8 cnt)
+{
+	int ret, val;
+
+	if (cnt > QCA807X_SMARTSPEED_RETRY_LIMIT_MAX ||
+	    (cnt < QCA807X_SMARTSPEED_RETRY_LIMIT_MIN && cnt != DOWNSHIFT_DEV_DISABLE))
+		return -EINVAL;
+
+	if (!cnt) {
+		ret = phy_clear_bits(phydev, MII_NWAYTEST, QCA807X_SMARTSPEED_EN);
+	} else {
+		val = QCA807X_SMARTSPEED_EN;
+		val |= FIELD_PREP(QCA807X_SMARTSPEED_RETRY_LIMIT_MASK, cnt - 2);
+
+		phy_modify(phydev, MII_NWAYTEST,
+			   QCA807X_SMARTSPEED_EN |
+			   QCA807X_SMARTSPEED_RETRY_LIMIT_MASK,
+			   val);
+	}
+
+	ret = genphy_soft_reset(phydev);
+
+	return ret;
+}
+
+static int qca807x_get_tunable(struct phy_device *phydev,
+			       struct ethtool_tunable *tuna, void *data)
+{
+	switch (tuna->id) {
+	case ETHTOOL_PHY_DOWNSHIFT:
+		return qca807x_get_downshift(phydev, data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int qca807x_set_tunable(struct phy_device *phydev,
+			       struct ethtool_tunable *tuna, const void *data)
+{
+	switch (tuna->id) {
+	case ETHTOOL_PHY_DOWNSHIFT:
+		return qca807x_set_downshift(phydev, *(const u8 *)data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static bool qca807x_distance_valid(int result)
+{
+	switch (result) {
+	case QCA807X_CDT_RESULTS_OPEN:
+	case QCA807X_CDT_RESULTS_SAME_SHORT:
+	case QCA807X_CDT_RESULTS_CROSS_SHORT_WITH_MDI1_SAME_OK:
+	case QCA807X_CDT_RESULTS_CROSS_SHORT_WITH_MDI2_SAME_OK:
+	case QCA807X_CDT_RESULTS_CROSS_SHORT_WITH_MDI3_SAME_OK:
+	case QCA807X_CDT_RESULTS_CROSS_SHORT_WITH_MDI1_SAME_OPEN:
+	case QCA807X_CDT_RESULTS_CROSS_SHORT_WITH_MDI2_SAME_OPEN:
+	case QCA807X_CDT_RESULTS_CROSS_SHORT_WITH_MDI3_SAME_OPEN:
+	case QCA807X_CDT_RESULTS_CROSS_SHORT_WITH_MDI1_SAME_SHORT:
+	case QCA807X_CDT_RESULTS_CROSS_SHORT_WITH_MDI2_SAME_SHORT:
+	case QCA807X_CDT_RESULTS_CROSS_SHORT_WITH_MDI3_SAME_SHORT:
+		return true;
+	}
+	return false;
+}
+
+static int qca807x_report_length(struct phy_device *phydev,
+				 int pair, int result)
+{
+	int length;
+	int ret;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_PCS, QCA807X_CDT_MMD3_MDI0_LENGTH + pair);
+	if (ret < 0)
+		return ret;
+
+	switch (result) {
+	case ETHTOOL_A_CABLE_RESULT_CODE_SAME_SHORT:
+		length = (FIELD_GET(QCA807X_CDT_SAME_SHORT_LENGTH_MASK, ret) * 800) / 10;
+		break;
+	case ETHTOOL_A_CABLE_RESULT_CODE_OPEN:
+	case ETHTOOL_A_CABLE_RESULT_CODE_CROSS_SHORT:
+		length = (FIELD_GET(QCA807X_CDT_CROSS_SHORT_LENGTH_MASK, ret) * 800) / 10;
+		break;
+	}
+
+	ethnl_cable_test_fault_length(phydev, pair, length);
+
+	return 0;
+}
+
+static int qca807x_cable_test_report_trans(int result)
+{
+	switch (result) {
+	case QCA807X_CDT_RESULTS_OK:
+		return ETHTOOL_A_CABLE_RESULT_CODE_OK;
+	case QCA807X_CDT_RESULTS_OPEN:
+		return ETHTOOL_A_CABLE_RESULT_CODE_OPEN;
+	case QCA807X_CDT_RESULTS_SAME_SHORT:
+		return ETHTOOL_A_CABLE_RESULT_CODE_SAME_SHORT;
+	case QCA807X_CDT_RESULTS_CROSS_SHORT_WITH_MDI1_SAME_OK:
+	case QCA807X_CDT_RESULTS_CROSS_SHORT_WITH_MDI2_SAME_OK:
+	case QCA807X_CDT_RESULTS_CROSS_SHORT_WITH_MDI3_SAME_OK:
+	case QCA807X_CDT_RESULTS_CROSS_SHORT_WITH_MDI1_SAME_OPEN:
+	case QCA807X_CDT_RESULTS_CROSS_SHORT_WITH_MDI2_SAME_OPEN:
+	case QCA807X_CDT_RESULTS_CROSS_SHORT_WITH_MDI3_SAME_OPEN:
+	case QCA807X_CDT_RESULTS_CROSS_SHORT_WITH_MDI1_SAME_SHORT:
+	case QCA807X_CDT_RESULTS_CROSS_SHORT_WITH_MDI2_SAME_SHORT:
+	case QCA807X_CDT_RESULTS_CROSS_SHORT_WITH_MDI3_SAME_SHORT:
+		return ETHTOOL_A_CABLE_RESULT_CODE_CROSS_SHORT;
+	default:
+		return ETHTOOL_A_CABLE_RESULT_CODE_UNSPEC;
+	}
+}
+
+static int qca807x_cable_test_report(struct phy_device *phydev)
+{
+	int pair0, pair1, pair2, pair3;
+	int ret;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_PCS, QCA807X_CDT_MMD3_STATUS);
+	if (ret < 0)
+		return ret;
+
+	pair0 = FIELD_GET(QCA807X_CDT_MDI0_STATUS_MASK, ret);
+	pair1 = FIELD_GET(QCA807X_CDT_MDI1_STATUS_MASK, ret);
+	pair2 = FIELD_GET(QCA807X_CDT_MDI2_STATUS_MASK, ret);
+	pair3 = FIELD_GET(QCA807X_CDT_MDI3_STATUS_MASK, ret);
+
+	ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_A,
+				qca807x_cable_test_report_trans(pair0));
+	ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_B,
+				qca807x_cable_test_report_trans(pair1));
+	ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_C,
+				qca807x_cable_test_report_trans(pair2));
+	ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_D,
+				qca807x_cable_test_report_trans(pair3));
+
+	if (qca807x_distance_valid(pair0))
+		qca807x_report_length(phydev, 0, qca807x_cable_test_report_trans(pair0));
+	if (qca807x_distance_valid(pair1))
+		qca807x_report_length(phydev, 1, qca807x_cable_test_report_trans(pair1));
+	if (qca807x_distance_valid(pair2))
+		qca807x_report_length(phydev, 2, qca807x_cable_test_report_trans(pair2));
+	if (qca807x_distance_valid(pair3))
+		qca807x_report_length(phydev, 3, qca807x_cable_test_report_trans(pair3));
+
+	return 0;
+}
+
+static int qca807x_cable_test_get_status(struct phy_device *phydev,
+					 bool *finished)
+{
+	int val;
+
+	*finished = false;
+
+	val = phy_read(phydev, QCA807X_CDT);
+	if (!((val & QCA807X_CDT_ENABLE) && (val & QCA807X_CDT_STATUS))) {
+		*finished = true;
+
+		return qca807x_cable_test_report(phydev);
+	}
+
+	return 0;
+}
+
+static int qca807x_cable_test_start(struct phy_device *phydev)
+{
+	int val, ret;
+
+	val = phy_read(phydev, QCA807X_CDT);
+	/* Enable inter-pair short check as well */
+	val &= ~QCA807X_CDT_ENABLE_INTER_PAIR_SHORT;
+	val |= QCA807X_CDT_ENABLE;
+	ret = phy_write(phydev, QCA807X_CDT, val);
+
+	return ret;
+}
+
+#ifdef CONFIG_GPIOLIB
+static int qca807x_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
+{
+	return GPIO_LINE_DIRECTION_OUT;
+}
+
+static int qca807x_gpio_get_reg(unsigned int offset)
+{
+	return QCA807X_MMD7_LED_100N_2 + (offset % 2) * 2;
+}
+
+static int qca807x_gpio_get(struct gpio_chip *gc, unsigned int offset)
+{
+	struct qca807x_gpio_priv *priv = gpiochip_get_data(gc);
+	int val;
+
+	val = phy_read_mmd(priv->phy, MDIO_MMD_AN, qca807x_gpio_get_reg(offset));
+
+	return FIELD_GET(QCA807X_GPIO_FORCE_MODE_MASK, val);
+}
+
+static void qca807x_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
+{
+	struct qca807x_gpio_priv *priv = gpiochip_get_data(gc);
+	int val;
+
+	val = phy_read_mmd(priv->phy, MDIO_MMD_AN, qca807x_gpio_get_reg(offset));
+	val &= ~QCA807X_GPIO_FORCE_MODE_MASK;
+	val |= QCA807X_GPIO_FORCE_EN;
+	val |= FIELD_PREP(QCA807X_GPIO_FORCE_MODE_MASK, value);
+
+	phy_write_mmd(priv->phy, MDIO_MMD_AN, qca807x_gpio_get_reg(offset), val);
+}
+
+static int qca807x_gpio_dir_out(struct gpio_chip *gc, unsigned int offset, int value)
+{
+	qca807x_gpio_set(gc, offset, value);
+
+	return 0;
+}
+
+static int qca807x_gpio(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	struct qca807x_gpio_priv *priv;
+	struct gpio_chip *gc;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->phy = phydev;
+
+	gc = devm_kzalloc(dev, sizeof(*gc), GFP_KERNEL);
+	if (!gc)
+		return -ENOMEM;
+
+	gc->label = dev_name(dev);
+	gc->base = -1;
+	gc->ngpio = 2;
+	gc->parent = dev;
+	gc->owner = THIS_MODULE;
+	gc->can_sleep = true;
+	gc->get_direction = qca807x_gpio_get_direction;
+	gc->direction_output = qca807x_gpio_dir_out;
+	gc->get = qca807x_gpio_get;
+	gc->set = qca807x_gpio_set;
+
+	return devm_gpiochip_add_data(dev, gc, priv);
+}
+#endif
+
+static int qca807x_read_copper_status(struct phy_device *phydev)
+{
+	int ss, err, old_link = phydev->link;
+
+	/* Update the link, but return if there was an error */
+	err = genphy_update_link(phydev);
+	if (err)
+		return err;
+
+	/* why bother the PHY if nothing can have changed */
+	if (phydev->autoneg == AUTONEG_ENABLE && old_link && phydev->link)
+		return 0;
+
+	phydev->speed = SPEED_UNKNOWN;
+	phydev->duplex = DUPLEX_UNKNOWN;
+	phydev->pause = 0;
+	phydev->asym_pause = 0;
+
+	err = genphy_read_lpa(phydev);
+	if (err < 0)
+		return err;
+
+	/* Read the QCA807x PHY-Specific Status register copper page,
+	 * which indicates the speed and duplex that the PHY is actually
+	 * using, irrespective of whether we are in autoneg mode or not.
+	 */
+	ss = phy_read(phydev, QCA807X_PHY_SPECIFIC_STATUS);
+	if (ss < 0)
+		return ss;
+
+	if (ss & QCA807X_SS_SPEED_AND_DUPLEX_RESOLVED) {
+		int sfc;
+
+		sfc = phy_read(phydev, QCA807X_FUNCTION_CONTROL);
+		if (sfc < 0)
+			return sfc;
+
+		switch (FIELD_GET(QCA807X_SS_SPEED_MASK, ss)) {
+		case QCA807X_SS_SPEED_10:
+			phydev->speed = SPEED_10;
+			break;
+		case QCA807X_SS_SPEED_100:
+			phydev->speed = SPEED_100;
+			break;
+		case QCA807X_SS_SPEED_1000:
+			phydev->speed = SPEED_1000;
+			break;
+		}
+		if (ss & QCA807X_SS_DUPLEX)
+			phydev->duplex = DUPLEX_FULL;
+		else
+			phydev->duplex = DUPLEX_HALF;
+
+		if (ss & QCA807X_SS_MDIX)
+			phydev->mdix = ETH_TP_MDI_X;
+		else
+			phydev->mdix = ETH_TP_MDI;
+
+		switch (FIELD_GET(QCA807X_FC_MDI_CROSSOVER_MODE_MASK, sfc)) {
+		case QCA807X_FC_MDI_CROSSOVER_MANUAL_MDI:
+			phydev->mdix_ctrl = ETH_TP_MDI;
+			break;
+		case QCA807X_FC_MDI_CROSSOVER_MANUAL_MDIX:
+			phydev->mdix_ctrl = ETH_TP_MDI_X;
+			break;
+		case QCA807X_FC_MDI_CROSSOVER_AUTO:
+			phydev->mdix_ctrl = ETH_TP_MDI_AUTO;
+			break;
+		}
+	}
+
+	if (phydev->autoneg == AUTONEG_ENABLE && phydev->autoneg_complete)
+		phy_resolve_aneg_pause(phydev);
+
+	return 0;
+}
+
+static int qca807x_read_fiber_status(struct phy_device *phydev)
+{
+	int ss, err, lpa, old_link = phydev->link;
+
+	/* Update the link, but return if there was an error */
+	err = genphy_update_link(phydev);
+	if (err)
+		return err;
+
+	/* why bother the PHY if nothing can have changed */
+	if (phydev->autoneg == AUTONEG_ENABLE && old_link && phydev->link)
+		return 0;
+
+	phydev->speed = SPEED_UNKNOWN;
+	phydev->duplex = DUPLEX_UNKNOWN;
+	phydev->pause = 0;
+	phydev->asym_pause = 0;
+
+	if (phydev->autoneg == AUTONEG_ENABLE && phydev->autoneg_complete) {
+		lpa = phy_read(phydev, MII_LPA);
+		if (lpa < 0)
+			return lpa;
+
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+				 phydev->lp_advertising, lpa & LPA_LPACK);
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
+				 phydev->lp_advertising, lpa & LPA_1000XFULL);
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_Pause_BIT,
+				 phydev->lp_advertising, lpa & LPA_1000XPAUSE);
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+				 phydev->lp_advertising,
+				 lpa & LPA_1000XPAUSE_ASYM);
+
+		phy_resolve_aneg_linkmode(phydev);
+	}
+
+	/* Read the QCA807x PHY-Specific Status register fiber page,
+	 * which indicates the speed and duplex that the PHY is actually
+	 * using, irrespective of whether we are in autoneg mode or not.
+	 */
+	ss = phy_read(phydev, QCA807X_PHY_SPECIFIC_STATUS);
+	if (ss < 0)
+		return ss;
+
+	if (ss & QCA807X_SS_SPEED_AND_DUPLEX_RESOLVED) {
+		switch (FIELD_GET(QCA807X_SS_SPEED_MASK, ss)) {
+		case QCA807X_SS_SPEED_100:
+			phydev->speed = SPEED_100;
+			break;
+		case QCA807X_SS_SPEED_1000:
+			phydev->speed = SPEED_1000;
+			break;
+		}
+
+		if (ss & QCA807X_SS_DUPLEX)
+			phydev->duplex = DUPLEX_FULL;
+		else
+			phydev->duplex = DUPLEX_HALF;
+	}
+
+	return 0;
+}
+
+static int qca807x_read_status(struct phy_device *phydev)
+{
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, phydev->supported)) {
+		switch (phydev->port) {
+		case PORT_FIBRE:
+			return qca807x_read_fiber_status(phydev);
+		case PORT_TP:
+			return qca807x_read_copper_status(phydev);
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return qca807x_read_copper_status(phydev);
+}
+
+static int qca807x_config_intr(struct phy_device *phydev)
+{
+	int ret, val;
+
+	val = phy_read(phydev, QCA807X_INTR_ENABLE);
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
+		/* Check for combo port as it has fewer interrupts */
+		if (phy_read(phydev, QCA807X_CHIP_CONFIGURATION)) {
+			val |= QCA807X_INTR_ENABLE_SPEED_CHANGED;
+			val |= QCA807X_INTR_ENABLE_LINK_FAIL;
+			val |= QCA807X_INTR_ENABLE_LINK_SUCCESS;
+		} else {
+			val |= QCA807X_INTR_ENABLE_AUTONEG_ERR;
+			val |= QCA807X_INTR_ENABLE_SPEED_CHANGED;
+			val |= QCA807X_INTR_ENABLE_DUPLEX_CHANGED;
+			val |= QCA807X_INTR_ENABLE_LINK_FAIL;
+			val |= QCA807X_INTR_ENABLE_LINK_SUCCESS;
+		}
+		ret = phy_write(phydev, QCA807X_INTR_ENABLE, val);
+	} else {
+		ret = phy_write(phydev, QCA807X_INTR_ENABLE, 0);
+	}
+
+	return ret;
+}
+
+static irqreturn_t qca807x_handle_interrupt(struct phy_device *phydev)
+{
+	int irq_status, int_enabled;
+
+	irq_status = phy_read(phydev, QCA807X_INTR_STATUS);
+	if (irq_status < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+
+	/* Read the current enabled interrupts */
+	int_enabled = phy_read(phydev, QCA807X_INTR_ENABLE);
+	if (int_enabled < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+
+	/* See if this was one of our enabled interrupts */
+	if (!(irq_status & int_enabled))
+		return IRQ_NONE;
+
+	phy_trigger_machine(phydev);
+
+	return IRQ_HANDLED;
+}
+
+static int qca807x_sfp_insert(void *upstream, const struct sfp_eeprom_id *id)
+{
+	struct phy_device *phydev = upstream;
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(support) = { 0, };
+	phy_interface_t iface;
+	int ret;
+	DECLARE_PHY_INTERFACE_MASK(interfaces);
+
+	sfp_parse_support(phydev->sfp_bus, id, support, interfaces);
+	iface = sfp_select_interface(phydev->sfp_bus, support);
+
+	dev_info(&phydev->mdio.dev, "%s SFP module inserted\n", phy_modes(iface));
+
+	switch (iface) {
+	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_100BASEX:
+		/* Set PHY mode to PSGMII combo (1/4 copper + combo ports) mode */
+		ret = phy_modify(phydev,
+				 QCA807X_CHIP_CONFIGURATION,
+				 QCA807X_CHIP_CONFIGURATION_MODE_CFG_MASK,
+				 QCA807X_CHIP_CONFIGURATION_MODE_PSGMII_FIBER);
+		/* Enable fiber mode autodection (1000Base-X or 100Base-FX) */
+		ret = phy_set_bits_mmd(phydev,
+				       MDIO_MMD_AN,
+				       QCA807X_MMD7_FIBER_MODE_AUTO_DETECTION,
+				       QCA807X_MMD7_FIBER_MODE_AUTO_DETECTION_EN);
+		/* Select fiber page */
+		ret = phy_clear_bits(phydev,
+				     QCA807X_CHIP_CONFIGURATION,
+				     QCA807X_BT_BX_REG_SEL);
+
+		phydev->port = PORT_FIBRE;
+		break;
+	default:
+		dev_err(&phydev->mdio.dev, "Incompatible SFP module inserted\n");
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static void qca807x_sfp_remove(void *upstream)
+{
+	struct phy_device *phydev = upstream;
+
+	/* Select copper page */
+	phy_set_bits(phydev,
+		     QCA807X_CHIP_CONFIGURATION,
+		     QCA807X_BT_BX_REG_SEL);
+
+	phydev->port = PORT_TP;
+}
+
+static const struct sfp_upstream_ops qca807x_sfp_ops = {
+	.attach = phy_sfp_attach,
+	.detach = phy_sfp_detach,
+	.module_insert = qca807x_sfp_insert,
+	.module_remove = qca807x_sfp_remove,
+};
+
+static int qca807x_config(struct phy_device *phydev)
+{
+	struct device_node *node = phydev->mdio.dev.of_node;
+	int control_dac, ret = 0;
+	u32 of_control_dac;
+
+	if (of_property_read_u32(node, "qcom,control-dac", &of_control_dac))
+		of_control_dac = QCA807X_CONTROL_DAC_DSP_VOLT_QUARTER_BIAS;
+
+	control_dac = phy_read_mmd(phydev, MDIO_MMD_AN,
+				   QCA807X_MMD7_1000BASE_T_POWER_SAVE_PER_CABLE_LENGTH);
+	control_dac &= ~QCA807X_CONTROL_DAC_MASK;
+	control_dac |= FIELD_PREP(QCA807X_CONTROL_DAC_MASK, of_control_dac);
+	ret = phy_write_mmd(phydev, MDIO_MMD_AN,
+			    QCA807X_MMD7_1000BASE_T_POWER_SAVE_PER_CABLE_LENGTH,
+			    control_dac);
+
+	return ret;
+}
+
+static int qca807x_probe(struct phy_device *phydev)
+{
+	struct device_node *node = phydev->mdio.dev.of_node;
+	int ret = 0;
+
+	if (IS_ENABLED(CONFIG_GPIOLIB)) {
+		if (of_find_property(node, "leds") &&
+		    of_find_property(node, "gpio-controller")) {
+			phydev_err("Invalid property detected. LEDs and gpio-controller are mutually exclusive.");
+			return -EINVAL;
+		}
+
+		/* Do not register a GPIO controller unless flagged for it */
+		if (of_property_read_bool(node, "gpio-controller")) {
+			ret = qca807x_gpio(phydev);
+			if (ret)
+				return ret;
+		}
+	}
+
+	/* Attach SFP bus on combo port*/
+	if (phy_read(phydev, QCA807X_CHIP_CONFIGURATION)) {
+		ret = phy_sfp_probe(phydev, &qca807x_sfp_ops);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, phydev->supported);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, phydev->advertising);
+	}
+
+	return ret;
+}
+
+static int qca807x_phy_package_config_init_once(struct phy_device *phydev)
+{
+	phy_interface_t package_interface = PHY_INTERFACE_MODE_NA;
+	struct phy_package_shared *shared = phydev->shared;
+	u32 tx_driver_strength;
+	int val, ret;
+
+	if (of_property_read_u32(shared->np, "qcom,tx-driver-strength",
+				 &tx_driver_strength))
+		tx_driver_strength = PSGMII_QSGMII_TX_DRIVER_600MV;
+
+	phy_lock_mdio_bus(phydev);
+
+	/* Set correct PHY package mode */
+	phy_package_get_mode(phydev, &package_interface);
+	val = __phy_package_read(phydev, QCA807X_COMBO_ADDR,
+				 QCA807X_CHIP_CONFIGURATION);
+	val &= ~QCA807X_CHIP_CONFIGURATION_MODE_CFG_MASK;
+	if (package_interface == PHY_INTERFACE_MODE_QSGMII)
+		val |= QCA807X_CHIP_CONFIGURATION_MODE_QSGMII_SGMII;
+	else if (package_interface == PHY_INTERFACE_MODE_PSGMII)
+		val |= QCA807X_CHIP_CONFIGURATION_MODE_PSGMII_ALL_COPPER;
+	ret = __phy_package_write(phydev, QCA807X_COMBO_ADDR,
+				  QCA807X_CHIP_CONFIGURATION, val);
+	if (ret)
+		goto exit;
+
+	/* After mode change Serdes reset is required */
+	val = __phy_package_read(phydev, QCA807X_PQSGMII_ADDR,
+				 PQSGMII_CTRL_REG);
+	val &= ~PQSGMII_ANALOG_SW_RESET;
+	ret = __phy_package_write(phydev, QCA807X_PQSGMII_ADDR,
+				  PQSGMII_CTRL_REG, val);
+	if (ret)
+		goto exit;
+
+	msleep(SERDES_RESET_SLEEP);
+
+	val = __phy_package_read(phydev, QCA807X_PQSGMII_ADDR,
+				 PQSGMII_CTRL_REG);
+	val |= PQSGMII_ANALOG_SW_RESET;
+	ret = __phy_package_write(phydev, QCA807X_PQSGMII_ADDR,
+				  PQSGMII_CTRL_REG, val);
+	if (ret)
+		goto exit;
+
+	/* Workaround to enable AZ transmitting ability */
+	val = __phy_package_read_mmd(phydev, QCA807X_PQSGMII_ADDR,
+				     MDIO_MMD_PMAPMD, PQSGMII_MODE_CTRL);
+	val &= ~PQSGMII_MODE_CTRL_AZ_WORKAROUND_MASK;
+	ret = __phy_package_write_mmd(phydev, QCA807X_PQSGMII_ADDR,
+				      MDIO_MMD_PMAPMD, PQSGMII_MODE_CTRL, val);
+	if (ret)
+		goto exit;
+
+	/* Set PQSGMII TX AMP strength */
+	val = __phy_package_read(phydev, QCA807X_PQSGMII_ADDR,
+				 PQSGMII_DRIVE_CONTROL_1);
+	val &= ~PQSGMII_TX_DRIVER_MASK;
+	val |= FIELD_PREP(PQSGMII_TX_DRIVER_MASK, tx_driver_strength);
+	ret = __phy_package_write(phydev, QCA807X_PQSGMII_ADDR,
+				  PQSGMII_DRIVE_CONTROL_1, val);
+	if (ret)
+		goto exit;
+
+	/* Prevent PSGMII going into hibernation via PSGMII self test */
+	val = __phy_package_read_mmd(phydev, QCA807X_COMBO_ADDR,
+				     MDIO_MMD_PCS, PQSGMII_MMD3_SERDES_CONTROL);
+	val &= ~BIT(1);
+	ret = __phy_package_write_mmd(phydev, QCA807X_COMBO_ADDR,
+				      MDIO_MMD_PCS, PQSGMII_MMD3_SERDES_CONTROL, val);
+
+exit:
+	phy_unlock_mdio_bus(phydev);
+
+	return ret;
+}
+
+static struct phy_driver qca807x_drivers[] = {
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_QCA8072),
+		.name           = "Qualcomm QCA8072",
+		.flags		= PHY_POLL_CABLE_TEST,
+		/* PHY_GBIT_FEATURES */
+		.probe		= qca807x_probe,
+		.config_init	= qca807x_config,
+		.read_status	= qca807x_read_status,
+		.config_intr	= qca807x_config_intr,
+		.handle_interrupt = qca807x_handle_interrupt,
+		.soft_reset	= genphy_soft_reset,
+		.get_tunable	= qca807x_get_tunable,
+		.set_tunable	= qca807x_set_tunable,
+		.resume		= genphy_resume,
+		.suspend	= genphy_suspend,
+		.cable_test_start	= qca807x_cable_test_start,
+		.cable_test_get_status	= qca807x_cable_test_get_status,
+	},
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_QCA8075),
+		.name           = "Qualcomm QCA8075",
+		.flags		= PHY_POLL_CABLE_TEST,
+		/* PHY_GBIT_FEATURES */
+		.probe		= qca807x_probe,
+		.config_init	= qca807x_config,
+		.read_status	= qca807x_read_status,
+		.config_intr	= qca807x_config_intr,
+		.handle_interrupt = qca807x_handle_interrupt,
+		.soft_reset	= genphy_soft_reset,
+		.get_tunable	= qca807x_get_tunable,
+		.set_tunable	= qca807x_set_tunable,
+		.resume		= genphy_resume,
+		.suspend	= genphy_suspend,
+		.cable_test_start	= qca807x_cable_test_start,
+		.cable_test_get_status	= qca807x_cable_test_get_status,
+		/* PHY package define */
+		.phy_package_global_phy_num = ARRAY_SIZE(qca807x_global_phy_names),
+		.phy_package_global_phy_names = qca807x_global_phy_names,
+		.phy_package_config_init_once = qca807x_phy_package_config_init_once,
+	},
+};
+module_phy_driver(qca807x_drivers);
+
+static struct mdio_device_id __maybe_unused qca807x_tbl[] = {
+	{ PHY_ID_MATCH_EXACT(PHY_ID_QCA8072) },
+	{ PHY_ID_MATCH_EXACT(PHY_ID_QCA8075) },
+	{ }
+};
+
+MODULE_AUTHOR("Robert Marko <robert.marko@sartura.hr>");
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
+MODULE_DESCRIPTION("Qualcomm QCA807x PHY driver");
+MODULE_DEVICE_TABLE(mdio, qca807x_tbl);
+MODULE_LICENSE("GPL");
-- 
2.40.1

