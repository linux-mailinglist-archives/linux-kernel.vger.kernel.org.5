Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8887D765846
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbjG0QGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbjG0QGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:06:40 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79F33583;
        Thu, 27 Jul 2023 09:06:33 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51ff0e3d8c1so1485981a12.0;
        Thu, 27 Jul 2023 09:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690473992; x=1691078792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9dOC2E95GJjvAFbLkJUIEK9S7ygE+JoBTf2ZmjYAvI=;
        b=iHk1PqhDBs6qWstiwcqY5IDxNmNdkOZoelZm0P7jSTD9+sWYmmP+dD50ELk7pJzdmB
         zyuTLJXMaM1W15WFqrllZ0Jojlx07HDLh5jviIuBrJrfRi5ke3s35lSsD3MlfRvMjYf2
         KBUYYuyPhKvzuMZP/1486LCoDlHj31jx+aGVzrXHKDmMUtIcferBp3+b6BNDLhzwAoB5
         mY+bVjXGw/VKNU/iAjdtmr/nqbw67OMMIKvhaEy3p/X6Lnz4kqdnfW/oNaijxP0rhDsq
         llpsGWmF0uyk72VMjvdRKh/9A+jEyPOrRFI/0AcDXQRppXoRDn9KehQ8ZBfxzNIDjZwI
         iwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690473992; x=1691078792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/9dOC2E95GJjvAFbLkJUIEK9S7ygE+JoBTf2ZmjYAvI=;
        b=boWsWc3Ktuu0BkSMffu86Iha48sOAMoMvjbmBTvyu784hVjm29SCuOhVe2ljfOHZ9O
         1otu33Pq4BhBEC4aW5+VvQF/o2D495p4outIbutST1n7Hb1duleZTylvrMAw3bO5aCBo
         hN7IVEH4o4ycx5kq+baDN5TrSE82gCfi5kcZjf5jylNuqntt13apj9QVX+ijcOZBxgKN
         sibFaVs7j9LI4szAl4z7I7qUtepBK5z1dA47vb7gp8/032nmICQKahMJG1SbV/95f6MZ
         uQ6+8pylMz6R6QLQ27+SV3i9FpN1vnSA3TVfH+fDl1uUTENGSLspC9vOkKWkR19xPAG7
         Vnjg==
X-Gm-Message-State: ABy/qLZ8OaFoXlhzbDomk7HtJTDsMls2Vp00YHHERWB87GQYP2EKuzes
        0RAYf2X6BoOUlU1vTMoliTQ=
X-Google-Smtp-Source: APBJJlERQVTHUUWy/LRTcjXLU1A4850JmSLUrY9IERmmIOAR2A7JWruMqRB1PBpCMA4+p2eZtSVTPA==
X-Received: by 2002:a17:907:58d:b0:973:d06d:545f with SMTP id vw13-20020a170907058d00b00973d06d545fmr1871311ejb.24.1690473991723;
        Thu, 27 Jul 2023 09:06:31 -0700 (PDT)
Received: from localhost.localdomain ([2a01:c844:242b:b300:215:5dff:fe78:868])
        by smtp.gmail.com with ESMTPSA id ck8-20020a170906c44800b00982be08a9besm936540ejb.172.2023.07.27.09.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 09:06:31 -0700 (PDT)
From:   Matus Gajdos <matuszpd@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matus Gajdos <matuszpd@gmail.com>
Subject: [PATCH 3/3] leds: Add Broadchip BCT3024 LED driver
Date:   Thu, 27 Jul 2023 18:05:25 +0200
Message-Id: <20230727160525.23312-4-matuszpd@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230727160525.23312-1-matuszpd@gmail.com>
References: <20230727160525.23312-1-matuszpd@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCT3024 chip is an I2C LED driver with independent 24 output
channels. Each channel supports 256 levels.

Signed-off-by: Matus Gajdos <matuszpd@gmail.com>
---
 drivers/leds/Kconfig        |   9 +
 drivers/leds/Makefile       |   1 +
 drivers/leds/leds-bct3024.c | 564 ++++++++++++++++++++++++++++++++++++
 3 files changed, 574 insertions(+)
 create mode 100644 drivers/leds/leds-bct3024.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 6046dfeca16f..75059db201e2 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -135,6 +135,15 @@ config LEDS_BCM6358
 	  This option enables support for LEDs connected to the BCM6358
 	  LED HW controller accessed via MMIO registers.
 
+config LEDS_BCT3024
+	tristate "LED Support for Broadchip BCT3024"
+	depends on LEDS_CLASS
+	depends on I2C
+	depends on OF
+	help
+	  This option enables support for LEDs connected to the BCT3024
+	  LED driver.
+
 config LEDS_CHT_WCOVE
 	tristate "LED support for Intel Cherry Trail Whiskey Cove PMIC"
 	depends on LEDS_CLASS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index d71f1226540c..f9eaed4c2317 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_LEDS_AW200XX)		+= leds-aw200xx.o
 obj-$(CONFIG_LEDS_AW2013)		+= leds-aw2013.o
 obj-$(CONFIG_LEDS_BCM6328)		+= leds-bcm6328.o
 obj-$(CONFIG_LEDS_BCM6358)		+= leds-bcm6358.o
+obj-$(CONFIG_LEDS_BCT3024)		+= leds-bct3024.o
 obj-$(CONFIG_LEDS_BD2606MVV)		+= leds-bd2606mvv.o
 obj-$(CONFIG_LEDS_BD2802)		+= leds-bd2802.o
 obj-$(CONFIG_LEDS_BLINKM)		+= leds-blinkm.o
diff --git a/drivers/leds/leds-bct3024.c b/drivers/leds/leds-bct3024.c
new file mode 100644
index 000000000000..7732fe022093
--- /dev/null
+++ b/drivers/leds/leds-bct3024.c
@@ -0,0 +1,564 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * LED driver for Broadchip BCT3024, based on leds-syscon.c
+ *
+ * Copyright 2023 Matus Gajdos <matuszpd@gmail.com>
+ */
+
+#include <linux/i2c.h>
+#include <linux/leds.h>
+#include <linux/regmap.h>
+#include <linux/gpio/consumer.h>
+#include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
+
+#define BCT3024_LED_COUNT		36
+#define BCT3024_REG_SHUTDOWN		(0x00)
+#define BCT3024_REG_BRIGHTNESS(n)	(0x01 + (n))
+#define BCT3024_REG_UPDATE		(0x25)
+#define BCT3024_REG_CONTROL(n)		(0x26 + (n))
+#define BCT3024_REG_GLOBAL_CONTROL	(0x4a)
+#define BCT3024_REG_RESET		(0x4f)
+
+enum bct3024_state {
+	BCT3024_STATE_INIT,
+	BCT3024_STATE_SHUTDOWN,
+	BCT3024_STATE_IDLE,
+	BCT3024_STATE_ACTIVE,
+};
+
+struct bct3024_led {
+	struct bct3024_led *next;
+	bool active;
+	unsigned int idx;
+	struct led_classdev ldev;
+	struct bct3024_data *priv;
+};
+
+struct bct3024_data {
+	enum bct3024_state state;
+	struct device *dev;
+	struct gpio_desc *shutdown_gpiod;
+	struct regulator *supply;
+	struct regmap *regmap;
+	struct mutex lock;
+	struct bct3024_led leds[BCT3024_LED_COUNT];
+};
+
+static const struct reg_default bct3024_defaults[] = {
+	{ BCT3024_REG_SHUTDOWN,		0x00 },
+	{ BCT3024_REG_BRIGHTNESS(0),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(1),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(2),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(3),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(4),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(5),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(6),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(7),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(8),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(9),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(10),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(11),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(12),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(13),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(14),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(15),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(16),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(17),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(18),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(19),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(20),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(21),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(22),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(23),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(24),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(25),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(26),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(27),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(28),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(29),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(30),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(31),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(32),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(33),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(34),	0x00 },
+	{ BCT3024_REG_BRIGHTNESS(35),	0x00 },
+	{ BCT3024_REG_UPDATE,		0x00 },
+	{ BCT3024_REG_CONTROL(0),	0x00 },
+	{ BCT3024_REG_CONTROL(1),	0x00 },
+	{ BCT3024_REG_CONTROL(2),	0x00 },
+	{ BCT3024_REG_CONTROL(3),	0x00 },
+	{ BCT3024_REG_CONTROL(4),	0x00 },
+	{ BCT3024_REG_CONTROL(5),	0x00 },
+	{ BCT3024_REG_CONTROL(6),	0x00 },
+	{ BCT3024_REG_CONTROL(7),	0x00 },
+	{ BCT3024_REG_CONTROL(8),	0x00 },
+	{ BCT3024_REG_CONTROL(9),	0x00 },
+	{ BCT3024_REG_CONTROL(10),	0x00 },
+	{ BCT3024_REG_CONTROL(11),	0x00 },
+	{ BCT3024_REG_CONTROL(12),	0x00 },
+	{ BCT3024_REG_CONTROL(13),	0x00 },
+	{ BCT3024_REG_CONTROL(14),	0x00 },
+	{ BCT3024_REG_CONTROL(15),	0x00 },
+	{ BCT3024_REG_CONTROL(16),	0x00 },
+	{ BCT3024_REG_CONTROL(17),	0x00 },
+	{ BCT3024_REG_CONTROL(18),	0x00 },
+	{ BCT3024_REG_CONTROL(19),	0x00 },
+	{ BCT3024_REG_CONTROL(20),	0x00 },
+	{ BCT3024_REG_CONTROL(21),	0x00 },
+	{ BCT3024_REG_CONTROL(22),	0x00 },
+	{ BCT3024_REG_CONTROL(23),	0x00 },
+	{ BCT3024_REG_CONTROL(24),	0x00 },
+	{ BCT3024_REG_CONTROL(25),	0x00 },
+	{ BCT3024_REG_CONTROL(26),	0x00 },
+	{ BCT3024_REG_CONTROL(27),	0x00 },
+	{ BCT3024_REG_CONTROL(28),	0x00 },
+	{ BCT3024_REG_CONTROL(29),	0x00 },
+	{ BCT3024_REG_CONTROL(30),	0x00 },
+	{ BCT3024_REG_CONTROL(31),	0x00 },
+	{ BCT3024_REG_CONTROL(32),	0x00 },
+	{ BCT3024_REG_CONTROL(33),	0x00 },
+	{ BCT3024_REG_CONTROL(34),	0x00 },
+	{ BCT3024_REG_CONTROL(35),	0x00 },
+	{ BCT3024_REG_GLOBAL_CONTROL,	0x00 },
+	{ BCT3024_REG_RESET,		0x00 },
+};
+
+static bool bct3024_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case BCT3024_REG_UPDATE:
+	case BCT3024_REG_RESET:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool bct3024_readable_reg(struct device *dev, unsigned int reg)
+{
+	/* The chip doesn't support i2c read */
+	return false;
+}
+
+static bool bct3024_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case BCT3024_REG_SHUTDOWN:
+	case BCT3024_REG_BRIGHTNESS(0) ... BCT3024_REG_BRIGHTNESS(35):
+	case BCT3024_REG_UPDATE:
+	case BCT3024_REG_CONTROL(0) ... BCT3024_REG_CONTROL(35):
+	case BCT3024_REG_GLOBAL_CONTROL:
+	case BCT3024_REG_RESET:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config bct3024_regmap = {
+	.reg_bits		= 8,
+	.val_bits		= 8,
+	.max_register		= BCT3024_REG_RESET,
+	.reg_defaults		= bct3024_defaults,
+	.num_reg_defaults	= ARRAY_SIZE(bct3024_defaults),
+	.volatile_reg		= bct3024_volatile_reg,
+	.readable_reg		= bct3024_readable_reg,
+	.writeable_reg		= bct3024_writeable_reg,
+	.cache_type             = REGCACHE_FLAT,
+};
+
+static int bct3024_write(struct bct3024_data *priv, unsigned int reg,
+			 unsigned int val)
+{
+	int ret = regmap_write(priv->regmap, reg, val);
+
+	if (ret < 0)
+		dev_err(priv->dev, "failed to write register 0x%x: %d\n", reg, ret);
+
+	return ret;
+}
+
+static bool bct3024_any_active(struct bct3024_data *priv)
+{
+	int i;
+
+	for (i = ARRAY_SIZE(priv->leds); i--; )
+		if (priv->leds[i].active && priv->leds[i].ldev.brightness)
+			return true;
+
+	return false;
+}
+
+static int bct3024_set_shutdown_reg(struct bct3024_data *priv, bool shutdown)
+{
+	unsigned int val = shutdown || !bct3024_any_active(priv) ? 0 : 1;
+	int ret = bct3024_write(priv, BCT3024_REG_SHUTDOWN, val);
+
+	return ret < 0 ? ret : val;
+}
+
+static int bct3024_shutdown(struct bct3024_data *priv, int active)
+{
+	struct device *dev = priv->dev;
+	int is_off = priv->state == BCT3024_STATE_INIT ||
+		     priv->state == BCT3024_STATE_SHUTDOWN;
+	int ret;
+
+	if (is_off == active) {
+		/* Nothing to do here */
+	} else if (active) {
+		priv->state = BCT3024_STATE_SHUTDOWN;
+
+		bct3024_set_shutdown_reg(priv, true);
+		regcache_cache_only(priv->regmap, true);
+
+		if (priv->shutdown_gpiod)
+			gpiod_set_value_cansleep(priv->shutdown_gpiod, 1);
+
+		if (priv->supply) {
+			ret = regulator_disable(priv->supply);
+			if (ret < 0)
+				dev_err(dev, "failed to disable supply: %d\n", ret);
+		}
+	} else {
+		if (priv->supply) {
+			ret = regulator_enable(priv->supply);
+			if (ret < 0) {
+				dev_err(dev, "failed to enable supply: %d\n", ret);
+				return ret;
+			}
+		}
+
+		if (priv->shutdown_gpiod)
+			gpiod_set_value_cansleep(priv->shutdown_gpiod, 0);
+
+		if (priv->state == BCT3024_STATE_SHUTDOWN) {
+			regcache_cache_only(priv->regmap, false);
+			regcache_mark_dirty(priv->regmap);
+			ret = regcache_sync(priv->regmap);
+			if (ret < 0) {
+				dev_err(dev, "failed to sync regmap: %d\n", ret);
+				return ret;
+			}
+		}
+
+		ret = bct3024_set_shutdown_reg(priv, false);
+		if (ret < 0)
+			return ret;
+
+		priv->state = ret ? BCT3024_STATE_ACTIVE : BCT3024_STATE_IDLE;
+	}
+
+	return 0;
+}
+
+static int bct3024_brightness_set(struct led_classdev *ldev,
+				  enum led_brightness brightness)
+{
+	struct bct3024_led *led = container_of(ldev, struct bct3024_led, ldev);
+	struct bct3024_data *priv = led->priv;
+	struct device *dev = priv->dev;
+	int ret;
+	unsigned int ctrl, bright;
+
+	if (priv->state == BCT3024_STATE_INIT)
+		return -EIO;
+
+	if (brightness == 0) {
+		ctrl = 0x00;
+		bright = 0;
+	} else if (brightness < 256) {
+		ctrl = 0x01;
+		bright = brightness;
+	}
+
+	mutex_lock(&priv->lock);
+
+	if (bct3024_any_active(priv) && (priv->state == BCT3024_STATE_IDLE ||
+	    priv->state == BCT3024_STATE_SHUTDOWN)) {
+		pm_runtime_get_sync(dev);
+		priv->state = BCT3024_STATE_ACTIVE;
+	}
+
+	for (; led; led = led->next) {
+		ret = bct3024_write(priv, BCT3024_REG_CONTROL(led->idx), ctrl);
+		if (ret < 0)
+			goto exit;
+		ret = bct3024_write(priv, BCT3024_REG_BRIGHTNESS(led->idx), bright);
+		if (ret < 0)
+			goto exit;
+	}
+
+	ret = bct3024_write(priv, BCT3024_REG_UPDATE, 0);
+	if (ret < 0)
+		goto exit;
+
+	ret = bct3024_set_shutdown_reg(priv, false);
+	if (ret < 0)
+		goto exit;
+
+	if (!ret && priv->state == BCT3024_STATE_ACTIVE) {
+		priv->state = BCT3024_STATE_IDLE;
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+		/* Activate autosuspend */
+		pm_runtime_idle(dev);
+	}
+
+	ret = 0;
+
+exit:
+	mutex_unlock(&priv->lock);
+
+	return ret;
+}
+
+static int bct3024_setup_led(struct bct3024_data *priv, u32 reg,
+			     struct bct3024_led **prev, struct led_init_data *idata)
+{
+	struct device *dev = priv->dev;
+	struct bct3024_led *led;
+	int ret;
+
+	if (reg >= BCT3024_LED_COUNT) {
+		ret = -EINVAL;
+		dev_err_probe(dev, ret, "invalid reg value: %u\n", reg);
+		return ret;
+	}
+
+	led = &priv->leds[reg];
+
+	if (led->active) {
+		ret = -EINVAL;
+		dev_err_probe(dev, ret, "reg redeclared: %u\n", reg);
+		return ret;
+	}
+
+	led->active = true;
+	led->priv = priv;
+	led->idx = reg;
+
+	if (!*prev) {
+		led->ldev.max_brightness = 255;
+		led->ldev.brightness_set_blocking = bct3024_brightness_set;
+
+		ret = devm_led_classdev_register_ext(dev, &led->ldev, idata);
+		if (ret < 0) {
+			dev_err_probe(dev, ret, "failed to register led %u\n", reg);
+			return ret;
+		}
+	} else
+		(*prev)->next = led;
+
+	*prev = led;
+
+	return 0;
+}
+
+static int bct3024_of_parse(struct i2c_client *client)
+{
+	struct bct3024_data *priv = i2c_get_clientdata(client);
+	struct device *dev = priv->dev;
+	struct device_node *np;
+	int ret;
+
+	ret = of_get_child_count(dev->of_node);
+	if (!ret || ret > ARRAY_SIZE(priv->leds)) {
+		dev_err_probe(dev, -EINVAL, "invalid nodes count: %d\n", ret);
+		return -EINVAL;
+	}
+
+	for_each_child_of_node(dev->of_node, np) {
+		u32 regs[BCT3024_LED_COUNT];
+		struct led_init_data idata = {
+			.fwnode = of_fwnode_handle(np),
+			.devicename = client->name,
+		};
+		struct bct3024_led *led;
+		int count, i;
+
+		count = of_property_read_variable_u32_array(np, "reg", regs, 1,
+							    BCT3024_LED_COUNT);
+		if (count < 0) {
+			ret = count;
+			dev_err_probe(dev, ret, "failed to read node reg\n");
+			goto fail;
+		}
+
+		for (i = 0, led = NULL; i < count; i++) {
+			ret = bct3024_setup_led(priv, regs[i], &led, &idata);
+			if (ret < 0)
+				goto fail;
+		}
+	}
+
+	return 0;
+
+fail:
+	of_node_put(np);
+
+	return ret;
+}
+
+static int bct3024_i2c_probe(struct i2c_client *client)
+{
+	struct bct3024_data *priv;
+	struct device *dev = &client->dev;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+
+	priv->supply = devm_regulator_get_optional(dev, "vdd");
+	if (IS_ERR(priv->supply)) {
+		ret = PTR_ERR(priv->supply);
+		if (ret != -ENODEV) {
+			dev_err_probe(dev, ret, "failed to get supply\n");
+			return ret;
+		}
+		priv->supply = NULL;
+	}
+
+	priv->shutdown_gpiod = devm_gpiod_get_optional(dev, "shutdown", GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->shutdown_gpiod)) {
+		ret = PTR_ERR(priv->shutdown_gpiod);
+		dev_err_probe(dev, ret, "failed to get shutdown gpio\n");
+		return ret;
+	}
+
+	priv->regmap = devm_regmap_init_i2c(client, &bct3024_regmap);
+	if (IS_ERR(priv->regmap)) {
+		ret = PTR_ERR(priv->regmap);
+		return ret;
+	}
+
+	mutex_init(&priv->lock);
+	i2c_set_clientdata(client, priv);
+
+	pm_runtime_set_autosuspend_delay(dev, 2000);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_enable(dev);
+	if (!pm_runtime_enabled(dev)) {
+		ret = bct3024_shutdown(priv, false);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		goto fail;
+
+	ret = bct3024_of_parse(client);
+	if (ret < 0)
+		goto fail;
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
+
+fail:
+	dev_err_probe(dev, ret, "probe failed\n");
+	if (!pm_runtime_status_suspended(dev))
+		bct3024_shutdown(priv, 2);
+	return ret;
+}
+
+static void bct3024_i2c_remove(struct i2c_client *client)
+{
+	struct bct3024_data *priv = i2c_get_clientdata(client);
+
+	bct3024_shutdown(priv, true);
+	pm_runtime_disable(priv->dev);
+	mutex_destroy(&priv->lock);
+}
+
+static void bct3024_i2c_shutdown(struct i2c_client *client)
+{
+	struct bct3024_data *priv = i2c_get_clientdata(client);
+
+	bct3024_shutdown(priv, true);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int bct3024_runtime_idle(struct device *dev)
+{
+	struct bct3024_data *priv = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "%s: %d\n", __func__, priv->state);
+
+	return priv->state == BCT3024_STATE_ACTIVE ? -EBUSY : 0;
+}
+
+static int bct3024_runtime_suspend(struct device *dev)
+{
+	struct bct3024_data *priv = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "%s: %d\n", __func__, priv->state);
+
+	switch (priv->state) {
+	case BCT3024_STATE_INIT:
+	case BCT3024_STATE_SHUTDOWN:
+		return 0;
+	default:
+		break;
+	}
+
+	return bct3024_shutdown(priv, true);
+}
+
+static int bct3024_runtime_resume(struct device *dev)
+{
+	struct bct3024_data *priv = dev_get_drvdata(dev);
+	int ret;
+
+	dev_dbg(dev, "%s: %d\n", __func__, priv->state);
+
+	switch (priv->state) {
+	case BCT3024_STATE_INIT:
+	case BCT3024_STATE_SHUTDOWN:
+		break;
+	default:
+		return 0;
+	}
+
+	ret = bct3024_shutdown(priv, false);
+	if (ret < 0)
+		bct3024_shutdown(priv, 2);
+
+	return ret;
+}
+#endif
+
+static const struct dev_pm_ops bct3024_pm_ops = {
+	SET_RUNTIME_PM_OPS(bct3024_runtime_suspend, bct3024_runtime_resume,
+			   bct3024_runtime_idle)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+};
+
+static const struct of_device_id bct3024_of_match[] = {
+	{ .compatible = "broadchip,bct3024" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, bct3024_of_match);
+
+static struct i2c_driver bct3024_driver = {
+	.driver = {
+		.name = "bct3024",
+		.of_match_table = bct3024_of_match,
+		.pm = &bct3024_pm_ops,
+	},
+	.probe_new = bct3024_i2c_probe,
+	.shutdown = bct3024_i2c_shutdown,
+	.remove = bct3024_i2c_remove,
+};
+
+module_i2c_driver(bct3024_driver);
+
+MODULE_AUTHOR("Matus Gajdos <matuszpd@gmail.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Broadchip BCT3024 LED driver");
-- 
2.25.1

