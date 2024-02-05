Return-Path: <linux-kernel+bounces-53045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4786849FEF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2605A1F2143D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4574BAA8;
	Mon,  5 Feb 2024 16:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S59dRWNg"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32970481CD;
	Mon,  5 Feb 2024 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707151756; cv=none; b=QUqEJ0yp1bJFdfYCyMxUPhdFoDCeCEUJGyzGPwk1CrfWIOnE9tsuLmOPhdefqaJ3Q+WUoY0LJ5Sobiq+68voV46oUEKfZp526LIlpcupz1Rfk7+jVA1Cof6zY3Mek5orKoi6146+flYgvOfNi7UmqvN23fTZyCb1/6k+jW5+G7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707151756; c=relaxed/simple;
	bh=JIO5Q4NToHkijFOhkOpq9I2oLqDJ+nKW/XBDN6UzhxM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TzN1GZNfb/G+q8I0o0R8LS3It/AVAeH7Y6N6l2EEro2BuZW74RvCKLH5MA8qK1j+I3NeUzQ36Dx6PFSrHxt7FDb2DKfCjM4VAJ/BuYJev15VSm+TqG/7jx1Ih1qx2AYHP66E8U7hKt9gFa4XEje74tgDfCkxVMH3h1uWemDX25Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S59dRWNg; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33b401fd72bso654999f8f.3;
        Mon, 05 Feb 2024 08:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707151752; x=1707756552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eAth+Hbw6otxJl0OVFFt9caHiuF+8y5+p+yMYDw15mw=;
        b=S59dRWNg0XEFJRs2F97TiJVRnGfTWZrixaOh+zMtc+GXz0C9lB6JMG4pg3dfG6OvNZ
         hOGWqV52XVWxApjCOYWdx6vCKA4xfpnJ3YiVVkvgZVDnBdp2/AKhhqaKo8uVHZN7zs5L
         unTjZYmyqjnQ1JG+5AWWC5fvs9JJdMgAb7givbcZmeNGDnAFOgb1P6WZYXif+dzagp4X
         9sh2T7P2t/WeuEgzcgG89Kcq8MmJZs1f+MuJ3YN2j1joPg9PMQe9MRqKZEjLD6+t6oJ8
         KemMGEmAu+lvqj6z9YqQ9QpQc1s9Ev/cPb0U3CXT9+v1/RkXHXOiulQB29PmJJipt7rU
         /OYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707151752; x=1707756552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eAth+Hbw6otxJl0OVFFt9caHiuF+8y5+p+yMYDw15mw=;
        b=ZK3a8PAZYESrlEzw2Ecrkbn+YCaCQFkNAa6+EcSTsbddSB/NQdpybfXUHO+e8YQ9wR
         QQ8pI7qbOXt/Geei+8FCf4h4ztkUV40RzhX+Rud24nOM9ETBCgGhCC3HqBN35klQPJhP
         2ZIYRVjWQNSrBx+coxHOx98c+c+u6RBRPxizfjwkmbNttYrZ3peaYCA1LpNfITlp39vS
         gP0H/vYK5QU9BFH+YSnL+UYQcT5CSXF2kCgXOQ6ATYBEfxRwiWk9mF3IVLGMpuYsDPXH
         ZyABsOVmStF+05TKbYPFu8Nlppbx1dmWh+9tyfyksLM7ZQcN2jpH5RG0E9avowWWbTTH
         8x3g==
X-Gm-Message-State: AOJu0YzGRlSRtl1auH7ylQiQEzVd0z/dScHAoXcR45tQW+E5UsAYrLLm
	83pq2DjJDlDajWuAdp6yBCXGcyaoh69zf6T7sKDSOEUO0VWYPgzq
X-Google-Smtp-Source: AGHT+IEa+p2Gu3O5bNF6ARkfDwpkLLOBQjyg3JMGyXPkKBr75Lm6RSe5tzvvKANw/AITvYDtKwGQMA==
X-Received: by 2002:a5d:4205:0:b0:336:76de:c171 with SMTP id n5-20020a5d4205000000b0033676dec171mr42537wrq.62.1707151751831;
        Mon, 05 Feb 2024 08:49:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVBN/rP392aBR4AXOCqzMP23rdDrN6W6799C0gDsxFNocBEFSu4AdE5wQirtKorD+E5RFuemy96KKYvE/mUvWaAesJchsysyZaIrY0ckFiVjJrz5q7dLV6xKQu2rEXaIuEnVh1tRLGLi/uE742EzBF8yw7jnWqGQafdmE7/eLEz7+l2QM240DntucRPkFLUAeJTMHxOhiGPTubZXv90lJImWeOFe8ab15w3omZg7Fs+aZyH36P92X3tPz9c5eRD9cCpTusjxWoGZ3FUg53cWRqaV4PSdWoz8tL2YlNU+WjhxZTbFVaSpqEdqED12X0vKqMorn1/8nLiWCUn2hOftZMdzCX+Ctkqm6UvNHDMlCwKvggkkYBlQHdPm3Sb5kakE6Uh5wOZoI4q64+h+ndLN+ROe+NI78MLqN1Btp53lPMLAdMvQGi9+6RGkeNwut+9eU2lHPttJQ+528b91wHkR7VXJcCbNolqpGAz+yJdRsrLYmdfGjwbouva+r/ATDUOiEqCBF1l9bIzxnqsW5SxouUoUuyDWO8NQZsFt4uZzBGH1sO2I945zEbuJ1m7L2ETSWheGJnhPl4hoJroo3MZwKDtJ9PXAb4yF4W1KnJCKezGYOHe9YxY6yA2xyJXJ0PzizxF/bm7+u8l03c/6fdAZ2MPPA+RtXCETmCWvICGLMBSVQQ62SyCdA==
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id k2-20020a05600c1c8200b0040fafd84095sm9140567wms.41.2024.02.05.08.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:49:11 -0800 (PST)
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
Subject: [net-next PATCH v6 07/10] net: phy: qcom: add support for QCA807x PHY Family
Date: Mon,  5 Feb 2024 17:48:39 +0100
Message-ID: <20240205164851.1351-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205164851.1351-1-ansuelsmth@gmail.com>
References: <20240205164851.1351-1-ansuelsmth@gmail.com>
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
index 000000000000..de8ea94c15f7
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
+#define PQSGMII_TX_DRIVER_140MV				FIELD_PREP(PQSGMII_TX_DRIVER_MASK, 0x0)
+#define PQSGMII_TX_DRIVER_160MV				FIELD_PREP(PQSGMII_TX_DRIVER_MASK, 0x1)
+#define PQSGMII_TX_DRIVER_180MV				FIELD_PREP(PQSGMII_TX_DRIVER_MASK, 0x2)
+#define PQSGMII_TX_DRIVER_200MV				FIELD_PREP(PQSGMII_TX_DRIVER_MASK, 0x3)
+#define PQSGMII_TX_DRIVER_220MV				FIELD_PREP(PQSGMII_TX_DRIVER_MASK, 0x4)
+#define PQSGMII_TX_DRIVER_240MV				FIELD_PREP(PQSGMII_TX_DRIVER_MASK, 0x5)
+#define PQSGMII_TX_DRIVER_260MV				FIELD_PREP(PQSGMII_TX_DRIVER_MASK, 0x6)
+#define PQSGMII_TX_DRIVER_280MV				FIELD_PREP(PQSGMII_TX_DRIVER_MASK, 0x7)
+#define PQSGMII_TX_DRIVER_300MV				FIELD_PREP(PQSGMII_TX_DRIVER_MASK, 0x8)
+#define PQSGMII_TX_DRIVER_320MV				FIELD_PREP(PQSGMII_TX_DRIVER_MASK, 0x9)
+#define PQSGMII_TX_DRIVER_400MV				FIELD_PREP(PQSGMII_TX_DRIVER_MASK, 0xa)
+#define PQSGMII_TX_DRIVER_500MV				FIELD_PREP(PQSGMII_TX_DRIVER_MASK, 0xb)
+#define PQSGMII_TX_DRIVER_600MV				FIELD_PREP(PQSGMII_TX_DRIVER_MASK, 0xc)
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
+	u32 tx_driver_strength;
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
+	unsigned int tx_driver_strength;
+	const char *package_mode_name;
+
+	/* Default to 600mw if not defined */
+	if (of_property_read_u32(shared->np, "qcom,tx-driver-strength",
+				 &tx_driver_strength))
+		tx_driver_strength = 600;
+
+	switch (tx_driver_strength) {
+	case 140:
+		priv->tx_driver_strength = PQSGMII_TX_DRIVER_140MV;
+		break;
+	case 160:
+		priv->tx_driver_strength = PQSGMII_TX_DRIVER_160MV;
+		break;
+	case 180:
+		priv->tx_driver_strength = PQSGMII_TX_DRIVER_180MV;
+		break;
+	case 200:
+		priv->tx_driver_strength = PQSGMII_TX_DRIVER_200MV;
+		break;
+	case 220:
+		priv->tx_driver_strength = PQSGMII_TX_DRIVER_220MV;
+		break;
+	case 240:
+		priv->tx_driver_strength = PQSGMII_TX_DRIVER_240MV;
+		break;
+	case 260:
+		priv->tx_driver_strength = PQSGMII_TX_DRIVER_260MV;
+		break;
+	case 280:
+		priv->tx_driver_strength = PQSGMII_TX_DRIVER_280MV;
+		break;
+	case 300:
+		priv->tx_driver_strength = PQSGMII_TX_DRIVER_300MV;
+		break;
+	case 320:
+		priv->tx_driver_strength = PQSGMII_TX_DRIVER_320MV;
+		break;
+	case 400:
+		priv->tx_driver_strength = PQSGMII_TX_DRIVER_400MV;
+		break;
+	case 500:
+		priv->tx_driver_strength = PQSGMII_TX_DRIVER_500MV;
+		break;
+	case 600:
+		priv->tx_driver_strength = PQSGMII_TX_DRIVER_600MV;
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
+	val |= FIELD_PREP(PQSGMII_TX_DRIVER_MASK, priv->tx_driver_strength);
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


