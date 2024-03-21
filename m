Return-Path: <linux-kernel+bounces-110159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1098885AF2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6891F2286A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6668528B;
	Thu, 21 Mar 2024 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DD/A0moG"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640928613F;
	Thu, 21 Mar 2024 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711031984; cv=none; b=gLk3IwzuJKnmnnipiNotaN3bLuAS4lrOrF22jO6EIzHPfjUsgjW11pe4bvbBRlZgG6DPH2Pf2FX1iVvhGmLlMxK7C6V0Mcr+USlXD51TEOxHQe+4LM5qzwgXRcxekqj/YEevtHQIS8J+9S1S+WI1OSDY8GNFt+fbDeYW1Q50+zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711031984; c=relaxed/simple;
	bh=O7ugDoNZZgm0a4P1HqPuzSFXp9R7YHvdFQ7coGOXL6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ej0YxnVg8jXXAaIux5KEn3509khGxJYZQWOACV2ItHLu/syh6YSeLcJ8nggcXHMap4rbNKA2RbC6nSt9KZaDeUtBpw7r4HYO8PKeeE426tsQwcZGHxOYCC3M54g8BOPWmq2dLorUR9JKm4KIffNNXXLtaONj6Gn4HODpKBM71nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DD/A0moG; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso1263121a12.2;
        Thu, 21 Mar 2024 07:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711031981; x=1711636781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQL77I0RDWDyolkQWE/R2ZxVS1GwI+NfUnobsEhFvyE=;
        b=DD/A0moGcR8DwtSHaaTSJaDesXKhmSwlEB78Y6zSzd6yGR9aR0zpBlHQbEpQ/R820m
         pGJn/+A/0vO5tfelx54ZQtzg6jcQ8RNFYSBhpTi7vA+3AotT2evbsE8MQt0IB9iLWB8j
         GG2ZaLntQpPZ+m2CewcN0Hq9zgnLzRXMSDDKCC59KMvIuRgMYzV1o7o886+kQTSuyrGj
         iW9ZJC2y8nSOhloNYcmkKZJJX/byj29rzjmw8LXTVbCIW8cmQEk5RMv93XzJ1hzO+KDX
         iIHMpoNgmpBwu+soivJP5/Vc7ohuYXKzkVH22k4pUI8FzfISV0P4zVFaXUbYmzrDO23O
         +9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711031981; x=1711636781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQL77I0RDWDyolkQWE/R2ZxVS1GwI+NfUnobsEhFvyE=;
        b=FyU/Ckdm+eiFA0lOOLUvYm7U1UksLKLYXmaTqjo63LrPob5NbN4zPDEOlTZZ5EEQvv
         XXY0LP0SjrmXq902b1f2BUo8bXHkLyuXOfQ6R6WxloKTNLlRzwa1hygXeHrBTXHGN1OV
         l7JnwUtrf7IFq/ukFCmhviLu9KuUaxoBO4hcevjVDR4UFAhemRrCNQLuOJTUmw34fKHB
         RRHs/Gy36/qJ6dYujG3ipQ/8BqyTCmlskWjEwkSW6uJ4hvWWiKcakc7eDRgKaOTTR8y/
         9sXM1kSyct3ixLTU4Zp1H164ZdMkbzboshlyi0czfrXfMmCl1/Gp19xiofqCnOjJJqMo
         BOqw==
X-Forwarded-Encrypted: i=1; AJvYcCUUpuBZrEFZ0w1pFXr90TOWF369JWLRCYMWTknOn535Ht/ZNH02WJKzdqS2dnCTTcr+W/1cp2gfAYhsrijyOheSEhRMxjwoQuwx3WNnDX27sZ86IiFp+wHk9ZgS0K6DCwVaukrAHPbyxKWKrRdFir6fXFWFa2rI13NaCn2alCzn9oAt11A=
X-Gm-Message-State: AOJu0YwiD8w40i8JG+OJ30bViONdGW9zJdSGCNFvC8ct1Kqp/z/BmrmM
	Je3Y3RpCIXgCLQ7i9tl6nqPeyRrDibz566iSpjcB16BhoFaojOA=
X-Google-Smtp-Source: AGHT+IEVZEHMXFIEC1ZqlzvMK9FTABD6kpOJmZbZ+Y27AzRuCRvgkyC1vLyN7ZPDu7eN6RgBmQ1uWg==
X-Received: by 2002:a17:906:7f0b:b0:a46:e8dc:5d51 with SMTP id d11-20020a1709067f0b00b00a46e8dc5d51mr4900400ejr.25.1711031980768;
        Thu, 21 Mar 2024 07:39:40 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:b39:dab4:8e20:e918])
        by smtp.gmail.com with ESMTPSA id e3-20020a170906248300b00a46abaeeb1csm6147923ejb.104.2024.03.21.07.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 07:39:40 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Chris Zhong <zyw@rock-chips.com>,
	Zhang Qing <zhangqing@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 2/5] mfd: rk8xx: Add RK816 support
Date: Thu, 21 Mar 2024 15:39:10 +0100
Message-ID: <20240321143911.90210-5-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240321143911.90210-2-knaerzche@gmail.com>
References: <20240321143911.90210-2-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This integrates RK816 support in the this existing rk8xx mfd driver.

This version has unaligned interrupt registers, which requires to define a
separate get_irq_reg callback for the regmap. Apart from that the
integration is straightforward and the existing structures can be used as
is. The initialisation sequence has been taken from vendor kernel.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 drivers/mfd/Kconfig       |   4 +-
 drivers/mfd/rk8xx-core.c  | 103 ++++++++++++++++++++++++++++
 drivers/mfd/rk8xx-i2c.c   |  45 +++++++++++-
 include/linux/mfd/rk808.h | 141 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 290 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 4b023ee229cf..2e7286cc98e4 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1225,7 +1225,7 @@ config MFD_RK8XX
 	select MFD_CORE
 
 config MFD_RK8XX_I2C
-	tristate "Rockchip RK805/RK808/RK809/RK817/RK818 Power Management Chip"
+	tristate "Rockchip RK805/RK808/RK809/RK816/RK817/RK818 Power Management Chip"
 	depends on I2C && OF
 	select MFD_CORE
 	select REGMAP_I2C
@@ -1233,7 +1233,7 @@ config MFD_RK8XX_I2C
 	select MFD_RK8XX
 	help
 	  If you say yes here you get support for the RK805, RK808, RK809,
-	  RK817 and RK818 Power Management chips.
+	  RK816, RK817 and RK818 Power Management chips.
 	  This driver provides common support for accessing the device
 	  through I2C interface. The device supports multiple sub-devices
 	  including interrupts, RTC, LDO & DCDC regulators, and onkey.
diff --git a/drivers/mfd/rk8xx-core.c b/drivers/mfd/rk8xx-core.c
index e2261b68b844..a616f159d8d4 100644
--- a/drivers/mfd/rk8xx-core.c
+++ b/drivers/mfd/rk8xx-core.c
@@ -28,6 +28,10 @@ static const struct resource rtc_resources[] = {
 	DEFINE_RES_IRQ(RK808_IRQ_RTC_ALARM),
 };
 
+static const struct resource rk816_rtc_resources[] = {
+	DEFINE_RES_IRQ(RK816_IRQ_RTC_ALARM),
+};
+
 static const struct resource rk817_rtc_resources[] = {
 	DEFINE_RES_IRQ(RK817_IRQ_RTC_ALARM),
 };
@@ -87,6 +91,21 @@ static const struct mfd_cell rk808s[] = {
 	},
 };
 
+static const struct mfd_cell rk816s[] = {
+	{ .name = "rk805-pinctrl", },
+	{ .name = "rk808-clkout", },
+	{ .name = "rk808-regulator", },
+	{	.name = "rk805-pwrkey",
+		.num_resources = ARRAY_SIZE(rk805_key_resources),
+		.resources = rk805_key_resources,
+	},
+	{
+		.name = "rk808-rtc",
+		.num_resources = ARRAY_SIZE(rk816_rtc_resources),
+		.resources = rk816_rtc_resources,
+	},
+};
+
 static const struct mfd_cell rk817s[] = {
 	{ .name = "rk808-clkout", },
 	{ .name = "rk808-regulator", },
@@ -148,6 +167,17 @@ static const struct rk808_reg_data rk808_pre_init_reg[] = {
 						    VB_LO_SEL_3500MV },
 };
 
+static const struct rk808_reg_data rk816_pre_init_reg[] = {
+	{ RK818_BUCK1_CONFIG_REG, RK817_RAMP_RATE_MASK,
+				  RK817_RAMP_RATE_12_5MV_PER_US },
+	{ RK818_BUCK2_CONFIG_REG, RK817_RAMP_RATE_MASK,
+				  RK817_RAMP_RATE_12_5MV_PER_US },
+	{ RK818_BUCK4_CONFIG_REG, BUCK_ILMIN_MASK,  BUCK_ILMIN_250MA },
+	{ RK808_THERMAL_REG, TEMP_HOTDIE_MSK, TEMP105C},
+	{ RK808_VB_MON_REG, VBAT_LOW_VOL_MASK | VBAT_LOW_ACT_MASK,
+			    RK808_VBAT_LOW_3V0 | EN_VABT_LOW_SHUT_DOWN },
+};
+
 static const struct rk808_reg_data rk817_pre_init_reg[] = {
 	{RK817_RTC_CTRL_REG, RTC_STOP, RTC_STOP},
 	/* Codec specific registers */
@@ -350,6 +380,59 @@ static const struct regmap_irq rk808_irqs[] = {
 	},
 };
 
+static const unsigned int rk816_irq_status_offsets[] = {
+	(RK816_INT_STS_REG1 - RK816_INT_STS_REG1),
+	(RK816_INT_STS_REG2 - RK816_INT_STS_REG1),
+	(RK816_INT_STS_REG3 - RK816_INT_STS_REG1),
+};
+
+static const unsigned int rk816_irq_mask_offsets[] = {
+	(RK816_INT_STS_MSK_REG1 - RK816_INT_STS_MSK_REG1),
+	(RK816_INT_STS_MSK_REG2 - RK816_INT_STS_MSK_REG1),
+	(RK816_INT_STS_MSK_REG3 - RK816_INT_STS_MSK_REG1),
+};
+
+static const unsigned int rk816_get_irq_reg(struct regmap_irq_chip_data *data,
+					    unsigned int base, int index)
+{
+	unsigned int irq_reg = base;
+
+	switch (base) {
+	case RK816_INT_STS_REG1:
+		irq_reg += rk816_irq_status_offsets[index];
+		break;
+	case RK816_INT_STS_MSK_REG1:
+		irq_reg += rk816_irq_mask_offsets[index];
+		break;
+	}
+
+	return irq_reg;
+};
+
+static const struct regmap_irq rk816_irqs[] = {
+	/* INT_STS_REG1 IRQs */
+	REGMAP_IRQ_REG(RK816_IRQ_PWRON_FALL, 0, RK816_INT_STS_PWRON_FALL),
+	REGMAP_IRQ_REG(RK816_IRQ_PWRON_RISE, 0, RK816_INT_STS_PWRON_RISE),
+
+	/* INT_STS_REG2 IRQs  */
+	REGMAP_IRQ_REG(RK816_IRQ_VB_LOW, 1, RK816_INT_STS_VB_LOW),
+	REGMAP_IRQ_REG(RK816_IRQ_PWRON, 1, RK816_INT_STS_PWRON),
+	REGMAP_IRQ_REG(RK816_IRQ_PWRON_LP, 1, RK816_INT_STS_PWRON_LP),
+	REGMAP_IRQ_REG(RK816_IRQ_HOTDIE, 1, RK816_INT_STS_HOTDIE),
+	REGMAP_IRQ_REG(RK816_IRQ_RTC_ALARM, 1, RK816_INT_STS_RTC_ALARM),
+	REGMAP_IRQ_REG(RK816_IRQ_RTC_PERIOD, 1, RK816_INT_STS_RTC_PERIOD),
+	REGMAP_IRQ_REG(RK816_IRQ_USB_OV, 1, RK816_INT_STS_USB_OV),
+
+	/* INT_STS3 IRQs */
+	REGMAP_IRQ_REG(RK816_IRQ_PLUG_IN, 2, RK816_INT_STS_PLUG_IN),
+	REGMAP_IRQ_REG(RK816_IRQ_PLUG_OUT, 2, RK816_INT_STS_PLUG_OUT),
+	REGMAP_IRQ_REG(RK816_IRQ_CHG_OK, 2, RK816_INT_STS_CHG_OK),
+	REGMAP_IRQ_REG(RK816_IRQ_CHG_TE, 2, RK816_INT_STS_CHG_TE),
+	REGMAP_IRQ_REG(RK816_IRQ_CHG_TS, 2, RK816_INT_STS_CHG_TS),
+	REGMAP_IRQ_REG(RK816_IRQ_CHG_CVTLIM, 2, RK816_INT_STS_CHG_CVTLIM),
+	REGMAP_IRQ_REG(RK816_IRQ_DISCHG_ILIM, 2, RK816_INT_STS_DISCHG_ILIM),
+};
+
 static const struct regmap_irq rk818_irqs[] = {
 	/* INT_STS */
 	[RK818_IRQ_VOUT_LO] = {
@@ -482,6 +565,18 @@ static const struct regmap_irq_chip rk808_irq_chip = {
 	.init_ack_masked = true,
 };
 
+static const struct regmap_irq_chip rk816_irq_chip = {
+	.name = "rk816",
+	.irqs = rk816_irqs,
+	.num_irqs = ARRAY_SIZE(rk816_irqs),
+	.num_regs = 3,
+	.get_irq_reg = rk816_get_irq_reg,
+	.status_base = RK816_INT_STS_REG1,
+	.mask_base = RK816_INT_STS_MSK_REG1,
+	.ack_base = RK816_INT_STS_REG1,
+	.init_ack_masked = true,
+};
+
 static struct regmap_irq_chip rk817_irq_chip = {
 	.name = "rk817",
 	.irqs = rk817_irqs,
@@ -530,6 +625,7 @@ static int rk808_power_off(struct sys_off_data *data)
 		reg = RK817_SYS_CFG(3);
 		bit = DEV_OFF;
 		break;
+	case RK816_ID:
 	case RK818_ID:
 		reg = RK818_DEVCTRL_REG;
 		bit = DEV_OFF;
@@ -637,6 +733,13 @@ int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap
 		cells = rk808s;
 		nr_cells = ARRAY_SIZE(rk808s);
 		break;
+	case RK816_ID:
+		rk808->regmap_irq_chip = &rk816_irq_chip;
+		pre_init_reg = rk816_pre_init_reg;
+		nr_pre_init_regs = ARRAY_SIZE(rk816_pre_init_reg);
+		cells = rk816s;
+		nr_cells = ARRAY_SIZE(rk816s);
+		break;
 	case RK818_ID:
 		rk808->regmap_irq_chip = &rk818_irq_chip;
 		pre_init_reg = rk818_pre_init_reg;
diff --git a/drivers/mfd/rk8xx-i2c.c b/drivers/mfd/rk8xx-i2c.c
index 75b5cf09d5a0..69a6b297d723 100644
--- a/drivers/mfd/rk8xx-i2c.c
+++ b/drivers/mfd/rk8xx-i2c.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Rockchip RK808/RK818 Core (I2C) driver
+ * Rockchip RK805/RK808/RK816/RK817/RK818 Core (I2C) driver
  *
  * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
  * Copyright (C) 2016 PHYTEC Messtechnik GmbH
@@ -49,6 +49,35 @@ static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
 	return false;
 }
 
+static bool rk816_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	/*
+	 * Technically the ROUND_30s bit makes RTC_CTRL_REG volatile, but
+	 * we don't use that feature.  It's better to cache.
+	 */
+
+	switch (reg) {
+	case RK808_SECONDS_REG ... RK808_WEEKS_REG:
+	case RK808_RTC_STATUS_REG:
+	case RK808_VB_MON_REG:
+	case RK808_THERMAL_REG:
+	case RK816_DCDC_EN_REG1:
+	case RK816_DCDC_EN_REG2:
+	case RK816_INT_STS_REG1:
+	case RK816_INT_STS_REG2:
+	case RK816_INT_STS_REG3:
+	case RK808_DEVCTRL_REG:
+	case RK816_SUP_STS_REG:
+	case RK816_GGSTS_REG:
+	case RK816_ZERO_CUR_ADC_REGH:
+	case RK816_ZERO_CUR_ADC_REGL:
+	case RK816_GASCNT_REG(0) ... RK816_BAT_VOL_REGL:
+		return true;
+	}
+
+	return false;
+}
+
 static bool rk817_is_volatile_reg(struct device *dev, unsigned int reg)
 {
 	/*
@@ -100,6 +129,14 @@ static const struct regmap_config rk808_regmap_config = {
 	.volatile_reg = rk808_is_volatile_reg,
 };
 
+static const struct regmap_config rk816_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = RK816_DATA_REG(18),
+	.cache_type = REGCACHE_MAPLE,
+	.volatile_reg = rk816_is_volatile_reg,
+};
+
 static const struct regmap_config rk817_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -123,6 +160,11 @@ static const struct rk8xx_i2c_platform_data rk809_data = {
 	.variant = RK809_ID,
 };
 
+static const struct rk8xx_i2c_platform_data rk816_data = {
+	.regmap_cfg = &rk816_regmap_config,
+	.variant = RK816_ID,
+};
+
 static const struct rk8xx_i2c_platform_data rk817_data = {
 	.regmap_cfg = &rk817_regmap_config,
 	.variant = RK817_ID,
@@ -161,6 +203,7 @@ static const struct of_device_id rk8xx_i2c_of_match[] = {
 	{ .compatible = "rockchip,rk805", .data = &rk805_data },
 	{ .compatible = "rockchip,rk808", .data = &rk808_data },
 	{ .compatible = "rockchip,rk809", .data = &rk809_data },
+	{ .compatible = "rockchip,rk816", .data = &rk816_data },
 	{ .compatible = "rockchip,rk817", .data = &rk817_data },
 	{ .compatible = "rockchip,rk818", .data = &rk818_data },
 	{ },
diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
index 78e167a92483..8b27fb2fafa8 100644
--- a/include/linux/mfd/rk808.h
+++ b/include/linux/mfd/rk808.h
@@ -113,6 +113,145 @@ enum rk808_reg {
 #define RK808_INT_STS_MSK_REG2	0x4f
 #define RK808_IO_POL_REG	0x50
 
+/* RK816 */
+enum rk816_reg {
+	RK816_ID_DCDC1,
+	RK816_ID_DCDC2,
+	RK816_ID_DCDC3,
+	RK816_ID_DCDC4,
+	RK816_ID_LDO1,
+	RK816_ID_LDO2,
+	RK816_ID_LDO3,
+	RK816_ID_LDO4,
+	RK816_ID_LDO5,
+	RK816_ID_LDO6,
+	RK816_ID_BOOST,
+	RK816_ID_OTG_SW,
+};
+
+enum rk816_irqs {
+	/* INT_STS_REG1 */
+	RK816_IRQ_PWRON_FALL,
+	RK816_IRQ_PWRON_RISE,
+
+	/* INT_STS_REG2 */
+	RK816_IRQ_VB_LOW,
+	RK816_IRQ_PWRON,
+	RK816_IRQ_PWRON_LP,
+	RK816_IRQ_HOTDIE,
+	RK816_IRQ_RTC_ALARM,
+	RK816_IRQ_RTC_PERIOD,
+	RK816_IRQ_USB_OV,
+
+	/* INT_STS_REG3 */
+	RK816_IRQ_PLUG_IN,
+	RK816_IRQ_PLUG_OUT,
+	RK816_IRQ_CHG_OK,
+	RK816_IRQ_CHG_TE,
+	RK816_IRQ_CHG_TS,
+	RK816_IRQ_CHG_CVTLIM,
+	RK816_IRQ_DISCHG_ILIM,
+};
+
+/* power channel registers */
+#define RK816_DCDC_EN_REG1		0x23
+
+#define RK816_DCDC_EN_REG2		0x24
+#define	RK816_BOOST_EN			BIT(1)
+#define RK816_OTG_EN			BIT(2)
+#define	RK816_BOOST_EN_MSK		BIT(5)
+#define RK816_OTG_EN_MSK		BIT(6)
+#define RK816_BUCK_DVS_CONFIRM		BIT(7)
+
+#define RK816_LDO_EN_REG1		0x27
+
+#define RK816_LDO_EN_REG2		0x28
+
+/*interrupt registers and irq definitions*/
+#define RK816_INT_STS_REG1		0x49
+#define RK816_INT_STS_MSK_REG1		0x4a
+#define RK816_INT_STS_PWRON_FALL	BIT(5)
+#define RK816_INT_STS_PWRON_RISE	BIT(6)
+
+#define RK816_INT_STS_REG2		0x4c
+#define RK816_INT_STS_MSK_REG2		0x4d
+#define RK816_INT_STS_VB_LOW		BIT(1)
+#define RK816_INT_STS_PWRON		BIT(2)
+#define RK816_INT_STS_PWRON_LP		BIT(3)
+#define RK816_INT_STS_HOTDIE		BIT(4)
+#define RK816_INT_STS_RTC_ALARM		BIT(5)
+#define RK816_INT_STS_RTC_PERIOD	BIT(6)
+#define RK816_INT_STS_USB_OV		BIT(7)
+
+#define RK816_INT_STS_REG3		0x4e
+#define RK816_INT_STS_MSK_REG3		0x4f
+#define RK816_INT_STS_PLUG_IN		BIT(0)
+#define RK816_INT_STS_PLUG_OUT		BIT(1)
+#define RK816_INT_STS_CHG_OK		BIT(2)
+#define RK816_INT_STS_CHG_TE		BIT(3)
+#define RK816_INT_STS_CHG_TS		BIT(4)
+#define RK816_INT_STS_CHG_CVTLIM	BIT(6)
+#define RK816_INT_STS_DISCHG_ILIM	BIT(7)
+
+/* charger, boost and OTG registers */
+#define RK816_OTG_BUCK_LDO_CONFIG_REG	0x2a
+#define RK816_CHRG_CONFIG_REG		0x2b
+#define RK816_BOOST_ON_VESL_REG		0x54
+#define RK816_BOOST_SLP_VSEL_REG	0x55
+#define RK816_CHRG_BOOST_CONFIG_REG	0x9a
+#define RK816_SUP_STS_REG		0xa0
+#define RK816_USB_CTRL_REG		0xa1
+#define RK816_CHRG_CTRL(x)		(0xa3 + (x))
+#define RK816_BAT_CTRL_REG		0xa6
+#define RK816_BAT_HTS_TS_REG		0xa8
+#define RK816_BAT_LTS_TS_REG		0xa9
+
+/* adc and fuel gauge registers */
+#define RK816_TS_CTRL_REG		0xac
+#define RK816_ADC_CTRL_REG		0xad
+#define RK816_GGCON_REG			0xb0
+#define RK816_GGSTS_REG			0xb1
+#define RK816_ZERO_CUR_ADC_REGH		0xb2
+#define RK816_ZERO_CUR_ADC_REGL		0xb3
+#define RK816_GASCNT_CAL_REG(x)		(0xb7 - (x))
+#define RK816_GASCNT_REG(x)		(0xbb - (x))
+#define RK816_BAT_CUR_AVG_REGH		0xbc
+#define RK816_BAT_CUR_AVG_REGL		0xbd
+#define RK816_TS_ADC_REGH		0xbe
+#define RK816_TS_ADC_REGL		0xbf
+#define RK816_USB_ADC_REGH		0xc0
+#define RK816_USB_ADC_REGL		0xc1
+#define RK816_BAT_OCV_REGH		0xc2
+#define RK816_BAT_OCV_REGL		0xc3
+#define RK816_BAT_VOL_REGH		0xc4
+#define RK816_BAT_VOL_REGL		0xc5
+#define RK816_RELAX_ENTRY_THRES_REGH	0xc6
+#define RK816_RELAX_ENTRY_THRES_REGL	0xc7
+#define RK816_RELAX_EXIT_THRES_REGH	0xc8
+#define RK816_RELAX_EXIT_THRES_REGL	0xc9
+#define RK816_RELAX_VOL1_REGH		0xca
+#define RK816_RELAX_VOL1_REGL		0xcb
+#define RK816_RELAX_VOL2_REGH		0xcc
+#define RK816_RELAX_VOL2_REGL		0xcd
+#define RK816_RELAX_CUR1_REGH		0xce
+#define RK816_RELAX_CUR1_REGL		0xcf
+#define RK816_RELAX_CUR2_REGH		0xd0
+#define RK816_RELAX_CUR2_REGL		0xd1
+#define RK816_CAL_OFFSET_REGH		0xd2
+#define RK816_CAL_OFFSET_REGL		0xd3
+#define RK816_NON_ACT_TIMER_CNT_REG	0xd4
+#define RK816_VCALIB0_REGH		0xd5
+#define RK816_VCALIB0_REGL		0xd6
+#define RK816_VCALIB1_REGH		0xd7
+#define RK816_VCALIB1_REGL		0xd8
+#define RK816_FCC_GASCNT_REG(x)		(0xdc - (x))
+#define RK816_IOFFSET_REGH		0xdd
+#define RK816_IOFFSET_REGL		0xde
+#define RK816_SLEEP_CON_SAMP_CUR_REG	0xdf
+
+/* general purpose data registers 0xe0 ~ 0xf2 */
+#define RK816_DATA_REG(x)		(0xe0 + (x))
+
 /* RK818 */
 #define RK818_DCDC1			0
 #define RK818_LDO1			4
@@ -791,6 +930,7 @@ enum rk806_dvs_mode {
 #define VOUT_LO_INT	BIT(0)
 #define CLK32KOUT2_EN	BIT(0)
 
+#define TEMP105C			0x08
 #define TEMP115C			0x0c
 #define TEMP_HOTDIE_MSK			0x0c
 #define SLP_SD_MSK			(0x3 << 2)
@@ -1191,6 +1331,7 @@ enum {
 	RK806_ID = 0x8060,
 	RK808_ID = 0x0000,
 	RK809_ID = 0x8090,
+	RK816_ID = 0x8160,
 	RK817_ID = 0x8170,
 	RK818_ID = 0x8180,
 };
-- 
2.43.2


