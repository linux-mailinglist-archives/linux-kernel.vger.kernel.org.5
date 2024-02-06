Return-Path: <linux-kernel+bounces-55392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC2E84BC26
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAAE51C23750
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0951DDF60;
	Tue,  6 Feb 2024 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAa3+ia+"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A5B1B286;
	Tue,  6 Feb 2024 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240795; cv=none; b=dGGaHh3TNK82/BgKT1GEh6b0QIB771Bl6HGU/xWmv9EQnmGSM3Y+/5G+T8NCuux7Kf1ghIntB0SWAnesl7vA58Acuf05VNe3WvSvtQAZce+cLNyZZOHZZN4TFoerSQygwGl2FGACY11UaeielyZTyxkA40ey4/E/8NifRGRHdpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240795; c=relaxed/simple;
	bh=lVnD2FLt87Y7Be9LDp9rQeARP6jlrGEoL4hF4rwexN8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dycFiU3H4UlMJLlv3YRQ/5ypVan88RRpPByC12PgwVTia+pKqqjGQaLS0Q+hFac6FrteoLk3YLVZ1Un1BUNq205wak2XbJ+oRLV6ysm/ueJ6d7NiH4eIcy8eoUm5Zo+UVuT3naawbLKYh+wq80F/NUmGI97F70DccK4+Gru6Pok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAa3+ia+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40ff812442aso2814895e9.2;
        Tue, 06 Feb 2024 09:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707240792; x=1707845592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2bPb64tk5SB/C0z8w9KrOUZ8DDcTcGxxTiQl9YBAiAg=;
        b=gAa3+ia+ttcOabJQw2nDPsvioRq/wUBKRlKgh5SnPVIWcsgaK8kdXmey6isqSihXD4
         znxruIKEbX7rIByBlbqTFSVypb6sLNNMbgb5eXq+4ibo3RiIcKNrx9ltulf7X0kPz1qR
         07PqEGhO/Dpin8NCQqIYVYjWHwBqP8slursYTQ0ib0V3GJdVaZ+QG14t7dzYS4DS7lZg
         RBiBFMQ5ag6Fm5ye3GlGrBQ5+M82BBj1d+YGvIVe9vSw+i5V85Di2Ggfo+ZnHz/1XVLY
         klsK3zIi1vORt/fvDO4yb4GE4rFIK+WHtDQ5xuHh2F95UtAJ+TxUB24uzPU48QnoNK16
         gsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707240792; x=1707845592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bPb64tk5SB/C0z8w9KrOUZ8DDcTcGxxTiQl9YBAiAg=;
        b=qOxG3Wwn3GKi+mKDF2tdXjqgLIUNnEy3nemOfJJizYETaFDV8IU3R+gmavLlr23zcE
         kmFvSCR60egCYjl4jsNcwmazRIzVyNd9b8yrthLIeF4ab1dTEi5hN9FmRO2FUaa38uo/
         5kyI85dOKBjnnUn9w/e7avaeNzJUWL4qg1RFKJ8j52kxM/bju++4nmt6l1DwS8RmYvYi
         sRIPLUqWblBEbSl9FiJH4qtDBKDvXWrxObRo3vGy4syx0DFHZQdIoOGmLB7THnJWLrhc
         A+D6YPL7aVb1/0l5/A+V2aPdtS5TzRaa5YPdeHvHTiwUbgujxwaRzbdH2nkF8196jGJj
         akqA==
X-Gm-Message-State: AOJu0Yw/MDCZMMyRCiUWGjGgNNwOKYhzP++y6ywtbnCg+S02SS0jCIV5
	lENCZ6qzhIr0Ot2Pik/irxPzTt0GqHHG0687x4JMJiLY/55fbIzWv4i1KsNH
X-Google-Smtp-Source: AGHT+IEexSRYDqF/6ubZNIvZWgCp7afO8Ihds9Esax5aS9qQU9+0JeD37z6DDagH+eVxNoUH8QDkYA==
X-Received: by 2002:a05:600c:a3a4:b0:40f:dc50:aea5 with SMTP id hn36-20020a05600ca3a400b0040fdc50aea5mr2139106wmb.22.1707240791890;
        Tue, 06 Feb 2024 09:33:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWgjwEI0YWxlE5wEa5UzzHoRfc14OADrBTi6J5gQtvGeUF7lJ/zNovU6G9wHTFGTG5MQdD/H8RwaJ5ob0gQAVjAr7mpTuUV+LDvASwawQU9VnY08E/BVeWFt6jvRLLDxdhopDMuv+b5YYF9VwdN/+CHNhAGweBloHY5n1WgU+Zy4hxPy9KWNWnXdG9r9172bGKJTamq4xuw/+Dtzp/p5ConyEF5Q1r1QPFvVrgr9c8SqTP0PJkCE3grKFvyCsdJl2iCdpeutSI7n7eZrIGtsY6VFPiP2k7z7oTVgSf2QZXW+wmuzyyJKR0m4uiSrxXNGhNnBZaA1ObziL7IQQpC+k8YdwH+5vrGqF+Bayk7HQ10H0SwWizZgwKVSPw2sAaoMsj2ZxstF7ZEGh2PMhK+H+FAeOyYHDBzFi/DHVw93b5ykJDrU5WZh6+8rl942cCnJ5E2SHCfYs2MGday6NidOYz0N1UOGcuJpvqOhGnF/UhoGT5VqVM9UQU9yqSYe9qJqj7BPmsp4EDWLqUA5jDCs/hME5xb97kjxFLemjb6pznkOcQ0etK+1G8scaskJSPApNLppcL3stPTdQyT2gwzuYudm1q1obTrSomTVjH90MzcQLZIhP5a9E8MUTmaeiox4i+D8tmr2RDChyDmCBDaYCR0msht45GxByivm5rf6B3jw9sO+tTYOg==
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id l14-20020a05600c4f0e00b0040fc56712e8sm2621215wmq.17.2024.02.06.09.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 09:33:10 -0800 (PST)
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
Subject: [net-next PATCH v7 10/10] net: phy: qca807x: add support for configurable LED
Date: Tue,  6 Feb 2024 18:31:13 +0100
Message-ID: <20240206173115.7654-11-ansuelsmth@gmail.com>
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
 drivers/net/phy/qcom/qca807x.c | 256 ++++++++++++++++++++++++++++++++-
 1 file changed, 254 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/qcom/qca807x.c b/drivers/net/phy/qcom/qca807x.c
index 43fc9cddd975..01815f947060 100644
--- a/drivers/net/phy/qcom/qca807x.c
+++ b/drivers/net/phy/qcom/qca807x.c
@@ -57,8 +57,18 @@
 #define QCA807X_MMD7_LED_CTRL(x)			(0x8074 + ((x) * 2))
 #define QCA807X_MMD7_LED_FORCE_CTRL(x)			(0x8075 + ((x) * 2))
 
-#define QCA807X_GPIO_FORCE_EN				BIT(15)
-#define QCA807X_GPIO_FORCE_MODE_MASK			GENMASK(14, 13)
+/* LED hw control pattern for fiber port */
+#define QCA807X_LED_FIBER_PATTERN_MASK			GENMASK(11, 1)
+#define QCA807X_LED_FIBER_TXACT_BLK_EN			BIT(10)
+#define QCA807X_LED_FIBER_RXACT_BLK_EN			BIT(9)
+#define QCA807X_LED_FIBER_FDX_ON_EN			BIT(6)
+#define QCA807X_LED_FIBER_HDX_ON_EN			BIT(5)
+#define QCA807X_LED_FIBER_1000BX_ON_EN			BIT(2)
+#define QCA807X_LED_FIBER_100FX_ON_EN			BIT(1)
+
+/* Some device repurpose the LED as GPIO out */
+#define QCA807X_GPIO_FORCE_EN				QCA808X_LED_FORCE_EN
+#define QCA807X_GPIO_FORCE_MODE_MASK			QCA808X_LED_FORCE_MODE_MASK
 
 #define QCA807X_FUNCTION_CONTROL			0x10
 #define QCA807X_FC_MDI_CROSSOVER_MODE_MASK		GENMASK(6, 5)
@@ -121,6 +131,233 @@ static int qca807x_cable_test_start(struct phy_device *phydev)
 	return 0;
 }
 
+static int qca807x_led_parse_netdev(struct phy_device *phydev, unsigned long rules,
+				    u16 *offload_trigger)
+{
+	/* Parsing specific to netdev trigger */
+	switch (phydev->port) {
+	case PORT_TP:
+		if (test_bit(TRIGGER_NETDEV_TX, &rules))
+			*offload_trigger |= QCA808X_LED_TX_BLINK;
+		if (test_bit(TRIGGER_NETDEV_RX, &rules))
+			*offload_trigger |= QCA808X_LED_RX_BLINK;
+		if (test_bit(TRIGGER_NETDEV_LINK_10, &rules))
+			*offload_trigger |= QCA808X_LED_SPEED10_ON;
+		if (test_bit(TRIGGER_NETDEV_LINK_100, &rules))
+			*offload_trigger |= QCA808X_LED_SPEED100_ON;
+		if (test_bit(TRIGGER_NETDEV_LINK_1000, &rules))
+			*offload_trigger |= QCA808X_LED_SPEED1000_ON;
+		if (test_bit(TRIGGER_NETDEV_HALF_DUPLEX, &rules))
+			*offload_trigger |= QCA808X_LED_HALF_DUPLEX_ON;
+		if (test_bit(TRIGGER_NETDEV_FULL_DUPLEX, &rules))
+			*offload_trigger |= QCA808X_LED_FULL_DUPLEX_ON;
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
+	u16 reg;
+
+	if (index > 1)
+		return -EINVAL;
+
+	reg = QCA807X_MMD7_LED_FORCE_CTRL(index);
+	return qca808x_led_reg_hw_control_enable(phydev, reg);
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
+	u16 reg, mask, offload_trigger = 0;
+	int ret;
+
+	if (index > 1)
+		return -EINVAL;
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
+		reg = QCA807X_MMD7_LED_CTRL(index);
+		mask = QCA808X_LED_PATTERN_MASK;
+		break;
+	case PORT_FIBRE:
+		/* HW control pattern bits are in LED FORCE reg */
+		reg = QCA807X_MMD7_LED_FORCE_CTRL(index);
+		mask = QCA807X_LED_FIBER_PATTERN_MASK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return phy_modify_mmd(phydev, MDIO_MMD_AN, reg, mask,
+			      offload_trigger);
+}
+
+static bool qca807x_led_hw_control_status(struct phy_device *phydev, u8 index)
+{
+	u16 reg;
+
+	if (index > 1)
+		return false;
+
+	reg = QCA807X_MMD7_LED_FORCE_CTRL(index);
+	return qca808x_led_reg_hw_control_status(phydev, reg);
+}
+
+static int qca807x_led_hw_control_get(struct phy_device *phydev, u8 index,
+				      unsigned long *rules)
+{
+	u16 reg;
+	int val;
+
+	if (index > 1)
+		return -EINVAL;
+
+	/* Check if we have hw control enabled */
+	if (qca807x_led_hw_control_status(phydev, index))
+		return -EINVAL;
+
+	/* Parsing specific to netdev trigger */
+	switch (phydev->port) {
+	case PORT_TP:
+		reg = QCA807X_MMD7_LED_CTRL(index);
+		val = phy_read_mmd(phydev, MDIO_MMD_AN, reg);
+		if (val & QCA808X_LED_TX_BLINK)
+			set_bit(TRIGGER_NETDEV_TX, rules);
+		if (val & QCA808X_LED_RX_BLINK)
+			set_bit(TRIGGER_NETDEV_RX, rules);
+		if (val & QCA808X_LED_SPEED10_ON)
+			set_bit(TRIGGER_NETDEV_LINK_10, rules);
+		if (val & QCA808X_LED_SPEED100_ON)
+			set_bit(TRIGGER_NETDEV_LINK_100, rules);
+		if (val & QCA808X_LED_SPEED1000_ON)
+			set_bit(TRIGGER_NETDEV_LINK_1000, rules);
+		if (val & QCA808X_LED_HALF_DUPLEX_ON)
+			set_bit(TRIGGER_NETDEV_HALF_DUPLEX, rules);
+		if (val & QCA808X_LED_FULL_DUPLEX_ON)
+			set_bit(TRIGGER_NETDEV_FULL_DUPLEX, rules);
+		break;
+	case PORT_FIBRE:
+		/* HW control pattern bits are in LED FORCE reg */
+		reg = QCA807X_MMD7_LED_FORCE_CTRL(index);
+		val = phy_read_mmd(phydev, MDIO_MMD_AN, reg);
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
+	u16 reg, mask;
+
+	if (index > 1)
+		return -EINVAL;
+
+	switch (phydev->port) {
+	case PORT_TP:
+		reg = QCA807X_MMD7_LED_CTRL(index);
+		mask = QCA808X_LED_PATTERN_MASK;
+		break;
+	case PORT_FIBRE:
+		/* HW control pattern bits are in LED FORCE reg */
+		reg = QCA807X_MMD7_LED_FORCE_CTRL(index);
+		mask = QCA807X_LED_FIBER_PATTERN_MASK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return phy_clear_bits_mmd(phydev, MDIO_MMD_AN, reg, mask);
+}
+
+static int qca807x_led_brightness_set(struct phy_device *phydev,
+				      u8 index, enum led_brightness value)
+{
+	u16 reg;
+	int ret;
+
+	if (index > 1)
+		return -EINVAL;
+
+	/* If we are setting off the LED reset any hw control rule */
+	if (!value) {
+		ret = qca807x_led_hw_control_reset(phydev, index);
+		if (ret)
+			return ret;
+	}
+
+	reg = QCA807X_MMD7_LED_FORCE_CTRL(index);
+	return qca808x_led_reg_brightness_set(phydev, reg, value);
+}
+
+static int qca807x_led_blink_set(struct phy_device *phydev, u8 index,
+				 unsigned long *delay_on,
+				 unsigned long *delay_off)
+{
+	u16 reg;
+
+	if (index > 1)
+		return -EINVAL;
+
+	reg = QCA807X_MMD7_LED_FORCE_CTRL(index);
+	return qca808x_led_reg_blink_set(phydev, reg, delay_on, delay_off);
+}
+
 #ifdef CONFIG_GPIOLIB
 static int qca807x_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
 {
@@ -496,6 +733,16 @@ static int qca807x_probe(struct phy_device *phydev)
 								     "qcom,dac-disable-bias-current-tweak");
 
 	if (IS_ENABLED(CONFIG_GPIOLIB)) {
+		/* Make sure we don't have mixed leds node and gpio-controller
+		 * to prevent registering leds and having gpio-controller usage
+		 * conflicting with them.
+		 */
+		if (of_find_property(node, "leds", NULL) &&
+		    of_find_property(node, "gpio-controller", NULL)) {
+			phydev_err(phydev, "Invalid property detected. LEDs and gpio-controller are mutually exclusive.");
+			return -EINVAL;
+		}
+
 		/* Do not register a GPIO controller unless flagged for it */
 		if (of_property_read_bool(node, "gpio-controller")) {
 			ret = qca807x_gpio(phydev);
@@ -580,6 +827,11 @@ static struct phy_driver qca807x_drivers[] = {
 		.suspend	= genphy_suspend,
 		.cable_test_start	= qca807x_cable_test_start,
 		.cable_test_get_status	= qca808x_cable_test_get_status,
+		.led_brightness_set = qca807x_led_brightness_set,
+		.led_blink_set = qca807x_led_blink_set,
+		.led_hw_is_supported = qca807x_led_hw_is_supported,
+		.led_hw_control_set = qca807x_led_hw_control_set,
+		.led_hw_control_get = qca807x_led_hw_control_get,
 	},
 };
 module_phy_driver(qca807x_drivers);
-- 
2.43.0


