Return-Path: <linux-kernel+bounces-55389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 159DB84BC0F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86DAC1F27497
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5C317C7F;
	Tue,  6 Feb 2024 17:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9s5RVmG"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA64168BA;
	Tue,  6 Feb 2024 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240790; cv=none; b=UEnkLqdEWiDr2y6rh+q5BJgi7mFEuOEIf+TVg7OGv6a4W+iTZe3von+0c00AQXadpitGRZQmPdgjXQTT15wAp2S2lHYqx7P2u6KQrXDJUjc4pGCM6/W0OSCY1zNtRs2RIURFYivPgyBoZv5Uzn8E7IMN8GQ/7NC+2w7Lt61+BfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240790; c=relaxed/simple;
	bh=Ae4QGhSKhFkw8cl/A+6Rcw17tpPOwIZgu5VCFIaSz+g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUGu1DHgUjfB1/GCniFICFPGUXlZMxF2ViRsOOlT0QehY+SxoeQ0vUk/5KJXG8bTWpYSYOPlocf96HtbY1qUyirMo+sMe+OghQSjLrx8ndqr0LqUq1P7JTB1RgqqQDngOa9QZMVP5NbRRoibPkNo1146JymrLMfr1XJq4ZTMUAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9s5RVmG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40efcb37373so10005555e9.2;
        Tue, 06 Feb 2024 09:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707240786; x=1707845586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PUDKgqKuLVdcqW+r3q8aBq+kKkEgLeSn0XaqiRPMSlA=;
        b=h9s5RVmGyDp5INXmKNjTyFFg7w4IzICqW1QKSqhSB+t8FfAxMlvvXSiRZxLYhfxpkh
         dgCftDPaE/rSkTf+8+qQO/qUqXj8ZY2yuwjMvxIA4QjeYSexa1XT0MqtYkC63TbMKgTN
         OhkZSEWAgnwD34ukrUxtNCxIOIVi5WbXfpJxBlRBYGS+eQJqvxBmRkWvKP0zLHObcZOx
         6FO43xztst2RYi0KCb6tPM4oGt/55YLCJKB05gmVEN5MxcczP+KiJX5Imr6jGw8rUhwH
         6GTWIz1CgRmV0mMJagIlMavcg+MKRORZAmjSoG7OHp7XXaeNZsoXjtDxkPMVLyeIqfX8
         hIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707240786; x=1707845586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUDKgqKuLVdcqW+r3q8aBq+kKkEgLeSn0XaqiRPMSlA=;
        b=dPtHxfGkOpUP1J+UMOCal4Fl0bRr/4GWXTPGiwyNSe5XqKwystuss6/bljvUz1zjLB
         H89k61MQAznUewCUhvSJ5vi8EcyydKl/316am535dlcEn39VwlFx7BlULp2IsO4EJfoL
         lY4ySzbqTDAM0eh2iLzN+rKc5qAvPrHK0r9UBfw6caUktXYIos3x7zxdBw5aOXDhAuql
         muyT/t1mLqQxWXdbo7dUJezVp6TQ/9HjsBsbRppN6tV6Iqd4ajByfE7W1iq2jIdW2/70
         2mL32UcvW20/UrN9fceqUv6O9c5fh/4BJ3vsJYo6DtOXnFfbYIb9IpUkgTqJxLWCbn+2
         Z0ZA==
X-Gm-Message-State: AOJu0YwXSd4ie77cEhSAKtH5HFfB31jmoCTH4ZgVCP9T+KTqO/Sz8oUw
	y667C+BsCk2Zc6OL3h+dKiGXMfMeUPao1nFyt7jsjgng81n4zuC3ss46JWuD
X-Google-Smtp-Source: AGHT+IH2ixKTl/sxKzFIjcj9Nj2QPZeHcoC4KST3fxZBVekL+8Tw679pzveSO5d7cRAD2kDW57auaA==
X-Received: by 2002:a05:600c:a41:b0:40e:f46d:ad35 with SMTP id c1-20020a05600c0a4100b0040ef46dad35mr2834307wmq.36.1707240785809;
        Tue, 06 Feb 2024 09:33:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVm9/IscC4PHuLqMjb6pAl8SWJzO1Efsp/Zl7pFT+nX7Hd/ZJZU+VsW4ycG7o9F5qIbLVtsa4r2bZMKv+OLLNYQl+nJr3FRNm9fOuSNYJ0UwQR67QwBgWb+XvEU2vLjSdvl7wUaBEErKi8EyzL9gH3pBkk9w6GIjfh1a8pJtmvc6xWbxtUs/XUWGg+ONrBTNAJCZMIYkTf2CQZuetLnNUaQ0cNh2qtBHLi7AzGytu9bDoS7DgbZ5CZq/I4CuSfu8poRmJfb/TIlY81nUq2k/XB8K1PjEoY9Px/4zVOcoNokvZhVxQAKZ5mG4qH/NPGaK9YJ8iY5NHSi+f55tp688GfQHAV51KxGK5zSdAckufYhto/4RxziuVEUL4Vo5J/AZH3TtJJ/khZLI+114089ZJmfqwnBE1d7Z/iPQkcYGoYO6zvs84rYoijkU8sjjcZx7xQnFykKxcSywafeGEnAX0YhEt4ETdqHJ2yht29CDJHN9iHdyvmG/T5NxuUBTNfmcuRuZSAuW09PBue06eZ7dEpa8gWnrqyiBSu/1vSRbpxIzur+HK5jbG9rtois0N7t6sykxwBWYf3jgYz/4tK/jm8kKEloLTMc6nG8wT2Gl8vMJ+Rinn/Ps+Mp4WUkI7YMw9q6+xOHWLjtfFHYOsS5H0Yt6+JKau1xPIPHyJWqhF7lcTUQBPQvyA==
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id l14-20020a05600c4f0e00b0040fc56712e8sm2621215wmq.17.2024.02.06.09.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 09:33:04 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [net-next PATCH v7 07/10] net: phy: qcom: add support for QCA807x PHY Family
Date: Tue,  6 Feb 2024 18:31:10 +0100
Message-ID: <20240206173115.7654-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206173115.7654-1-ansuelsmth@gmail.com>
References: <20240206173115.7654-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Robert Marko <robert.marko@sartura.hr>

This adds driver for the Qualcomm QCA8072 and QCA8075 PHY-s.

They are 2 or 5 port IEEE 802.3 clause 22 compliant 10BASE-Te,
100BASE-TX and 1000BASE-T PHY-s.

They feature 2 SerDes, one for PSGMII or QSGMII connection with
MAC, while second one is SGMII for connection to MAC or fiber.

Both models have a combo port that supports 1000BASE-X and
100BASE-FX fiber.

PHY package can be configured in 3 mode following this table:

              First Serdes mode       Second Serdes mode
Option 1      PSGMII for copper       Disabled
              ports 0-4
Option 2      PSGMII for copper       1000BASE-X / 100BASE-FX
              ports 0-4
Option 3      QSGMII for copper       SGMII for
              ports 0-3               copper port 4

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
 drivers/net/phy/qcom/Kconfig   |   8 +
 drivers/net/phy/qcom/Makefile  |   1 +
 drivers/net/phy/qcom/qca807x.c | 597 +++++++++++++++++++++++++++++++++
 3 files changed, 606 insertions(+)
 create mode 100644 drivers/net/phy/qcom/qca807x.c

diff --git a/drivers/net/phy/qcom/Kconfig b/drivers/net/phy/qcom/Kconfig
index 80db24deb689..570626cc8e14 100644
--- a/drivers/net/phy/qcom/Kconfig
+++ b/drivers/net/phy/qcom/Kconfig
@@ -20,3 +20,11 @@ config QCA808X_PHY
 	select QCOM_NET_PHYLIB
 	help
 	  Currently supports the QCA8081 model
+
+config QCA807X_PHY
+	tristate "Qualcomm QCA807x PHYs"
+	select QCOM_NET_PHYLIB
+	depends on OF_MDIO
+	help
+	  Currently supports the Qualcomm QCA8072, QCA8075 and the PSGMII
+	  control PHY.
diff --git a/drivers/net/phy/qcom/Makefile b/drivers/net/phy/qcom/Makefile
index 0362d7ed47be..f24fb550babd 100644
--- a/drivers/net/phy/qcom/Makefile
+++ b/drivers/net/phy/qcom/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_QCOM_NET_PHYLIB)	+= qcom-phy-lib.o
 obj-$(CONFIG_AT803X_PHY)	+= at803x.o
 obj-$(CONFIG_QCA83XX_PHY)	+= qca83xx.o
 obj-$(CONFIG_QCA808X_PHY)	+= qca808x.o
+obj-$(CONFIG_QCA807X_PHY)	+= qca807x.o
diff --git a/drivers/net/phy/qcom/qca807x.c b/drivers/net/phy/qcom/qca807x.c
new file mode 100644
index 000000000000..43fc9cddd975
--- /dev/null
+++ b/drivers/net/phy/qcom/qca807x.c
@@ -0,0 +1,597 @@
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
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/phy.h>
+#include <linux/bitfield.h>
+#include <linux/gpio/driver.h>
+#include <linux/sfp.h>
+
+#include "qcom.h"
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
+/* List of tweaks enabled by this bit:
+ * - With both FULL amplitude and FULL bias current: bias current
+ *   is set to half.
+ * - With only DSP amplitude: bias current is set to half and
+ *   is set to 1/4 with cable < 10m.
+ * - With DSP bias current (included both DSP amplitude and
+ *   DSP bias current): bias current is half the detected current
+ *   with cable < 10m.
+ */
+#define QCA807X_CONTROL_DAC_BIAS_CURRENT_TWEAK			BIT(2)
+#define QCA807X_CONTROL_DAC_DSP_BIAS_CURRENT			BIT(1)
+#define QCA807X_CONTROL_DAC_DSP_AMPLITUDE			BIT(0)
+
+#define QCA807X_MMD7_LED_100N_1				0x8074
+#define QCA807X_MMD7_LED_100N_2				0x8075
+#define QCA807X_MMD7_LED_1000N_1			0x8076
+#define QCA807X_MMD7_LED_1000N_2			0x8077
+
+#define QCA807X_MMD7_LED_CTRL(x)			(0x8074 + ((x) * 2))
+#define QCA807X_MMD7_LED_FORCE_CTRL(x)			(0x8075 + ((x) * 2))
+
+#define QCA807X_GPIO_FORCE_EN				BIT(15)
+#define QCA807X_GPIO_FORCE_MODE_MASK			GENMASK(14, 13)
+
+#define QCA807X_FUNCTION_CONTROL			0x10
+#define QCA807X_FC_MDI_CROSSOVER_MODE_MASK		GENMASK(6, 5)
+#define QCA807X_FC_MDI_CROSSOVER_AUTO			3
+#define QCA807X_FC_MDI_CROSSOVER_MANUAL_MDIX		1
+#define QCA807X_FC_MDI_CROSSOVER_MANUAL_MDI		0
+
+/* PQSGMII Analog PHY specific */
+#define PQSGMII_CTRL_REG				0x0
+#define PQSGMII_ANALOG_SW_RESET				BIT(6)
+#define PQSGMII_DRIVE_CONTROL_1				0xb
+#define PQSGMII_TX_DRIVER_MASK				GENMASK(7, 4)
+#define PQSGMII_TX_DRIVER_140MV				0x0
+#define PQSGMII_TX_DRIVER_160MV				0x1
+#define PQSGMII_TX_DRIVER_180MV				0x2
+#define PQSGMII_TX_DRIVER_200MV				0x3
+#define PQSGMII_TX_DRIVER_220MV				0x4
+#define PQSGMII_TX_DRIVER_240MV				0x5
+#define PQSGMII_TX_DRIVER_260MV				0x6
+#define PQSGMII_TX_DRIVER_280MV				0x7
+#define PQSGMII_TX_DRIVER_300MV				0x8
+#define PQSGMII_TX_DRIVER_320MV				0x9
+#define PQSGMII_TX_DRIVER_400MV				0xa
+#define PQSGMII_TX_DRIVER_500MV				0xb
+#define PQSGMII_TX_DRIVER_600MV				0xc
+#define PQSGMII_MODE_CTRL				0x6d
+#define PQSGMII_MODE_CTRL_AZ_WORKAROUND_MASK		BIT(0)
+#define PQSGMII_MMD3_SERDES_CONTROL			0x805a
+
+#define PHY_ID_QCA8072		0x004dd0b2
+#define PHY_ID_QCA8075		0x004dd0b1
+
+#define QCA807X_COMBO_ADDR_OFFSET			4
+#define QCA807X_PQSGMII_ADDR_OFFSET			5
+#define SERDES_RESET_SLEEP				100
+
+enum qca807x_global_phy {
+	QCA807X_COMBO_ADDR = 4,
+	QCA807X_PQSGMII_ADDR = 5,
+};
+
+struct qca807x_shared_priv {
+	unsigned int package_mode;
+	u32 tx_drive_strength;
+};
+
+struct qca807x_gpio_priv {
+	struct phy_device *phy;
+};
+
+struct qca807x_priv {
+	bool dac_full_amplitude;
+	bool dac_full_bias_current;
+	bool dac_disable_bias_current_tweak;
+};
+
+static int qca807x_cable_test_start(struct phy_device *phydev)
+{
+	/* we do all the (time consuming) work later */
+	return 0;
+}
+
+#ifdef CONFIG_GPIOLIB
+static int qca807x_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
+{
+	return GPIO_LINE_DIRECTION_OUT;
+}
+
+static int qca807x_gpio_get(struct gpio_chip *gc, unsigned int offset)
+{
+	struct qca807x_gpio_priv *priv = gpiochip_get_data(gc);
+	u16 reg;
+	int val;
+
+	reg = QCA807X_MMD7_LED_FORCE_CTRL(offset);
+	val = phy_read_mmd(priv->phy, MDIO_MMD_AN, reg);
+
+	return FIELD_GET(QCA807X_GPIO_FORCE_MODE_MASK, val);
+}
+
+static void qca807x_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
+{
+	struct qca807x_gpio_priv *priv = gpiochip_get_data(gc);
+	u16 reg;
+	int val;
+
+	reg = QCA807X_MMD7_LED_FORCE_CTRL(offset);
+
+	val = phy_read_mmd(priv->phy, MDIO_MMD_AN, reg);
+	val &= ~QCA807X_GPIO_FORCE_MODE_MASK;
+	val |= QCA807X_GPIO_FORCE_EN;
+	val |= FIELD_PREP(QCA807X_GPIO_FORCE_MODE_MASK, value);
+
+	phy_write_mmd(priv->phy, MDIO_MMD_AN, reg, val);
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
+static int qca807x_read_fiber_status(struct phy_device *phydev)
+{
+	bool changed;
+	int ss, err;
+
+	err = genphy_c37_read_status(phydev, &changed);
+	if (err || !changed)
+		return err;
+
+	/* Read the QCA807x PHY-Specific Status register fiber page,
+	 * which indicates the speed and duplex that the PHY is actually
+	 * using, irrespective of whether we are in autoneg mode or not.
+	 */
+	ss = phy_read(phydev, AT803X_SPECIFIC_STATUS);
+	if (ss < 0)
+		return ss;
+
+	phydev->speed = SPEED_UNKNOWN;
+	phydev->duplex = DUPLEX_UNKNOWN;
+	if (ss & AT803X_SS_SPEED_DUPLEX_RESOLVED) {
+		switch (FIELD_GET(AT803X_SS_SPEED_MASK, ss)) {
+		case AT803X_SS_SPEED_100:
+			phydev->speed = SPEED_100;
+			break;
+		case AT803X_SS_SPEED_1000:
+			phydev->speed = SPEED_1000;
+			break;
+		}
+
+		if (ss & AT803X_SS_DUPLEX)
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
+			return at803x_read_status(phydev);
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return at803x_read_status(phydev);
+}
+
+static int qca807x_phy_package_probe_once(struct phy_device *phydev)
+{
+	struct phy_package_shared *shared = phydev->shared;
+	struct qca807x_shared_priv *priv = shared->priv;
+	unsigned int tx_drive_strength;
+	const char *package_mode_name;
+
+	/* Default to 600mw if not defined */
+	if (of_property_read_u32(shared->np, "qcom,tx-drive-strength-milliwatt",
+				 &tx_drive_strength))
+		tx_drive_strength = 600;
+
+	switch (tx_drive_strength) {
+	case 140:
+		priv->tx_drive_strength = PQSGMII_TX_DRIVER_140MV;
+		break;
+	case 160:
+		priv->tx_drive_strength = PQSGMII_TX_DRIVER_160MV;
+		break;
+	case 180:
+		priv->tx_drive_strength = PQSGMII_TX_DRIVER_180MV;
+		break;
+	case 200:
+		priv->tx_drive_strength = PQSGMII_TX_DRIVER_200MV;
+		break;
+	case 220:
+		priv->tx_drive_strength = PQSGMII_TX_DRIVER_220MV;
+		break;
+	case 240:
+		priv->tx_drive_strength = PQSGMII_TX_DRIVER_240MV;
+		break;
+	case 260:
+		priv->tx_drive_strength = PQSGMII_TX_DRIVER_260MV;
+		break;
+	case 280:
+		priv->tx_drive_strength = PQSGMII_TX_DRIVER_280MV;
+		break;
+	case 300:
+		priv->tx_drive_strength = PQSGMII_TX_DRIVER_300MV;
+		break;
+	case 320:
+		priv->tx_drive_strength = PQSGMII_TX_DRIVER_320MV;
+		break;
+	case 400:
+		priv->tx_drive_strength = PQSGMII_TX_DRIVER_400MV;
+		break;
+	case 500:
+		priv->tx_drive_strength = PQSGMII_TX_DRIVER_500MV;
+		break;
+	case 600:
+		priv->tx_drive_strength = PQSGMII_TX_DRIVER_600MV;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	priv->package_mode = PHY_INTERFACE_MODE_NA;
+	if (!of_property_read_string(shared->np, "qcom,package-mode",
+				     &package_mode_name)) {
+		if (!strcasecmp(package_mode_name,
+				phy_modes(PHY_INTERFACE_MODE_PSGMII)))
+			priv->package_mode = PHY_INTERFACE_MODE_PSGMII;
+		else if (!strcasecmp(package_mode_name,
+				     phy_modes(PHY_INTERFACE_MODE_QSGMII)))
+			priv->package_mode = PHY_INTERFACE_MODE_QSGMII;
+		else
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int qca807x_phy_package_config_init_once(struct phy_device *phydev)
+{
+	struct phy_package_shared *shared = phydev->shared;
+	struct qca807x_shared_priv *priv = shared->priv;
+	int val, ret;
+
+	phy_lock_mdio_bus(phydev);
+
+	/* Set correct PHY package mode */
+	val = __phy_package_read(phydev, QCA807X_COMBO_ADDR,
+				 QCA807X_CHIP_CONFIGURATION);
+	val &= ~QCA807X_CHIP_CONFIGURATION_MODE_CFG_MASK;
+	/* package_mode can be QSGMII or PSGMII and we validate
+	 * this in probe_once.
+	 * With package_mode to NA, we default to PSGMII.
+	 */
+	switch (priv->package_mode) {
+	case PHY_INTERFACE_MODE_QSGMII:
+		val |= QCA807X_CHIP_CONFIGURATION_MODE_QSGMII_SGMII;
+		break;
+	case PHY_INTERFACE_MODE_PSGMII:
+	default:
+		val |= QCA807X_CHIP_CONFIGURATION_MODE_PSGMII_ALL_COPPER;
+	}
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
+	val |= FIELD_PREP(PQSGMII_TX_DRIVER_MASK, priv->tx_drive_strength);
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
+static int qca807x_probe(struct phy_device *phydev)
+{
+	struct device_node *node = phydev->mdio.dev.of_node;
+	struct qca807x_shared_priv *shared_priv;
+	struct device *dev = &phydev->mdio.dev;
+	struct phy_package_shared *shared;
+	struct qca807x_priv *priv;
+	int ret;
+
+	ret = devm_of_phy_package_join(dev, phydev, sizeof(*shared_priv));
+	if (ret)
+		return ret;
+
+	if (phy_package_probe_once(phydev)) {
+		ret = qca807x_phy_package_probe_once(phydev);
+		if (ret)
+			return ret;
+	}
+
+	shared = phydev->shared;
+	shared_priv = shared->priv;
+
+	/* Make sure PHY follow PHY package mode if enforced */
+	if (shared_priv->package_mode != PHY_INTERFACE_MODE_NA &&
+	    phydev->interface != shared_priv->package_mode)
+		return -EINVAL;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dac_full_amplitude = of_property_read_bool(node, "qcom,dac-full-amplitude");
+	priv->dac_full_bias_current = of_property_read_bool(node, "qcom,dac-full-bias-current");
+	priv->dac_disable_bias_current_tweak = of_property_read_bool(node,
+								     "qcom,dac-disable-bias-current-tweak");
+
+	if (IS_ENABLED(CONFIG_GPIOLIB)) {
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
+		if (ret)
+			return ret;
+		linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, phydev->supported);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, phydev->advertising);
+	}
+
+	phydev->priv = priv;
+
+	return 0;
+}
+
+static int qca807x_config_init(struct phy_device *phydev)
+{
+	struct qca807x_priv *priv = phydev->priv;
+	u16 control_dac;
+	int ret;
+
+	if (phy_package_init_once(phydev)) {
+		ret = qca807x_phy_package_config_init_once(phydev);
+		if (ret)
+			return ret;
+	}
+
+	control_dac = phy_read_mmd(phydev, MDIO_MMD_AN,
+				   QCA807X_MMD7_1000BASE_T_POWER_SAVE_PER_CABLE_LENGTH);
+	control_dac &= ~QCA807X_CONTROL_DAC_MASK;
+	if (!priv->dac_full_amplitude)
+		control_dac |= QCA807X_CONTROL_DAC_DSP_AMPLITUDE;
+	if (!priv->dac_full_amplitude)
+		control_dac |= QCA807X_CONTROL_DAC_DSP_BIAS_CURRENT;
+	if (!priv->dac_disable_bias_current_tweak)
+		control_dac |= QCA807X_CONTROL_DAC_BIAS_CURRENT_TWEAK;
+	return phy_write_mmd(phydev, MDIO_MMD_AN,
+			     QCA807X_MMD7_1000BASE_T_POWER_SAVE_PER_CABLE_LENGTH,
+			     control_dac);
+}
+
+static struct phy_driver qca807x_drivers[] = {
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_QCA8072),
+		.name           = "Qualcomm QCA8072",
+		.flags		= PHY_POLL_CABLE_TEST,
+		/* PHY_GBIT_FEATURES */
+		.probe		= qca807x_probe,
+		.config_init	= qca807x_config_init,
+		.read_status	= qca807x_read_status,
+		.config_intr	= at803x_config_intr,
+		.handle_interrupt = at803x_handle_interrupt,
+		.soft_reset	= genphy_soft_reset,
+		.get_tunable	= at803x_get_tunable,
+		.set_tunable	= at803x_set_tunable,
+		.resume		= genphy_resume,
+		.suspend	= genphy_suspend,
+		.cable_test_start	= qca807x_cable_test_start,
+		.cable_test_get_status	= qca808x_cable_test_get_status,
+	},
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_QCA8075),
+		.name           = "Qualcomm QCA8075",
+		.flags		= PHY_POLL_CABLE_TEST,
+		/* PHY_GBIT_FEATURES */
+		.probe		= qca807x_probe,
+		.config_init	= qca807x_config_init,
+		.read_status	= qca807x_read_status,
+		.config_intr	= at803x_config_intr,
+		.handle_interrupt = at803x_handle_interrupt,
+		.soft_reset	= genphy_soft_reset,
+		.get_tunable	= at803x_get_tunable,
+		.set_tunable	= at803x_set_tunable,
+		.resume		= genphy_resume,
+		.suspend	= genphy_suspend,
+		.cable_test_start	= qca807x_cable_test_start,
+		.cable_test_get_status	= qca808x_cable_test_get_status,
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
2.43.0


