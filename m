Return-Path: <linux-kernel+bounces-88318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A0886DFFB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58C7B1C22357
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9056F51F;
	Fri,  1 Mar 2024 11:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zh0kdIZG"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F456CDB8;
	Fri,  1 Mar 2024 11:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709291564; cv=none; b=t9PVmAvnVJhsh2QKjMGzwWrSx2Qz87QCxrwMvq9eAwaeIGr15qXyujl5NPp71zo5d51VZTJghK15gCrap9PBOgE2Bg4FEVIJRD4PX/jwWHwC8w2EIr7marUdwFG8vjX6xOz9pBDqhKTqn20F3/DW5pSkPv8kEdtbYPCgv+HmNlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709291564; c=relaxed/simple;
	bh=BEB7qWDqpMw22mTCQUG5lw1gg9QbrSUF0oqtCMqWoC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZyOmEqp1R7ywopixejU0A+TVavDah6m/8cigFN7D+P6z2ZxwprMwSZU7LYugcVhtbDN8xZ7KPafKzAgEaNiIDKaazWyOc4wT0AeVXv82F11DRGCFEhi8YQeZiKvK9WaG6XRMhiZAL9IFoHnL5ja88mPxEFx803uYn2KcQx8u3co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zh0kdIZG; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a43dba50bb7so282194866b.0;
        Fri, 01 Mar 2024 03:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709291561; x=1709896361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Rqdfw7u5pplnc2e2TFtlnNGF+ckTKLmulF+IZmE6Uw=;
        b=Zh0kdIZGSVyF+wWq18+w59GZtyV6bOxAwVSlv5rM2BtjJC0PrNgOou7+HlM0pFQJU3
         jhGFwz14+bstO+RcNJM+Hyb3BKy/Zm6xsCr1Gznqn3CfgUp1gYajIKVLDA6H5LQvumvr
         trzGRWN7bsIVKCH1XY5Mb7xLp5yl2IGBoC27O96kVVqjB2GXFC0q463jxTJDuHnYDgL1
         1uSvoBQJHcz35NEW46H7JZPKX9BKCR+lqiYLNIPqzYqwZCjsrT8UZdvHWLUleWch+ayP
         7413jY/2OCSv69BDPvLDn1dFDY48sEHMlHVkIFtIsfe/NPJv9ayVjOdK2ZIQlz8djd7t
         OVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709291561; x=1709896361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Rqdfw7u5pplnc2e2TFtlnNGF+ckTKLmulF+IZmE6Uw=;
        b=RH9307mXgoRXE/o0n/8bbM1zanKy31sMQ22dooiaYtHIUyhuWcyfenxD+wx9nCkKSA
         A95WAMwW/xbI7HEMWHJp1jxhK9gkvlANRhFjWn2223qCJyoVLUUPPIyH6E2vsBMDapqk
         LPBktWQXRMff/AhsFOxNlXrhyOCAsW2r2xSVFXLgEBDIEaLwvGIVYWeIww5u5fLEJdsT
         bZAjNnY9gVP2IAxSLfnMOiu4lgaRXMzNyOmiDhuKauraemfvctmDQSwyaTZoonWPxtge
         Fk78vTKJkK9S8+rs6QmSIosEY0sVs4ukUNDEDIRmXxZWweawZynxy+zd7Z4PRmWJctAN
         blGg==
X-Forwarded-Encrypted: i=1; AJvYcCUGFMqoT69Bvr9rs3deT48YmfYaQtFbGxtMSR68qe0eEjILDcC/VgABSgYa8HPRBl6fUZsntgWNqSx4OG5usZ3WrOMxwgb0Rtv4OUyzW661louNW/U14gNPXDwjFlFS+RM0px5YExyQCbD23etSIaxs1QxAArb9PZ1e9S7AiS8NqGw0Gw==
X-Gm-Message-State: AOJu0YwOADYToBCIcLg7S7UIzzLfAkytlrUsi+jMI4hsHURzWHGh2rBH
	KcUu/6g/aRD2fSJEQmy40conSTDoEYYK4p3W8Sj02Wb3GZwvPnc8
X-Google-Smtp-Source: AGHT+IGptLXz1WvCsMZ3icAmzzrsfWjhb8J30eELsLKXp3qhaReq0tf9zAeosFL7WWhDps5QWx5OZQ==
X-Received: by 2002:a17:906:5786:b0:a43:6f6:e23d with SMTP id k6-20020a170906578600b00a4306f6e23dmr1007727ejq.38.1709291560704;
        Fri, 01 Mar 2024 03:12:40 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id n18-20020a170906089200b00a43a478e4f0sm1583254eje.180.2024.03.01.03.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:12:40 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] pwm: add support for NXPs high-side switch MC33XS2410
Date: Fri,  1 Mar 2024 12:11:23 +0100
Message-Id: <20240301111124.29283-3-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240301111124.29283-1-dima.fedrau@gmail.com>
References: <20240301111124.29283-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MC33XS2410 is a four channel high-side switch. Featuring advanced
monitoring and control function, the device is operational from 3.0 V to
60 V. The device is controlled by SPI port for configuration.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/pwm/Kconfig          |  12 ++
 drivers/pwm/Makefile         |   1 +
 drivers/pwm/pwm-mc33xs2410.c | 324 +++++++++++++++++++++++++++++++++++
 3 files changed, 337 insertions(+)
 create mode 100644 drivers/pwm/pwm-mc33xs2410.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 4b956d661755..da7048899ea7 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -384,6 +384,18 @@ config PWM_LPSS_PLATFORM
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-lpss-platform.
 
+config PWM_MC33XS2410
+	tristate "MC33XS2410 PWM support"
+	depends on OF
+	depends on SPI
+	help
+	  NXP MC33XS2410 high-side switch driver. The MC33XS2410 is a four
+	  channel high-side switch. The device is operational from 3.0 V
+	  to 60 V. The device is controlled by SPI port for configuration.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-mc33xs2410.
+
 config PWM_MESON
 	tristate "Amlogic Meson PWM driver"
 	depends on ARCH_MESON || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index c5ec9e168ee7..6e7904e82c42 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
 obj-$(CONFIG_PWM_LPSS)		+= pwm-lpss.o
 obj-$(CONFIG_PWM_LPSS_PCI)	+= pwm-lpss-pci.o
 obj-$(CONFIG_PWM_LPSS_PLATFORM)	+= pwm-lpss-platform.o
+obj-$(CONFIG_PWM_MC33XS2410)	+= pwm-mc33xs2410.o
 obj-$(CONFIG_PWM_MESON)		+= pwm-meson.o
 obj-$(CONFIG_PWM_MEDIATEK)	+= pwm-mediatek.o
 obj-$(CONFIG_PWM_MICROCHIP_CORE)	+= pwm-microchip-core.o
diff --git a/drivers/pwm/pwm-mc33xs2410.c b/drivers/pwm/pwm-mc33xs2410.c
new file mode 100644
index 000000000000..35753039da6b
--- /dev/null
+++ b/drivers/pwm/pwm-mc33xs2410.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Liebherr-Electronics and Drives GmbH
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/pwm.h>
+
+#include <asm/unaligned.h>
+
+#include <linux/spi/spi.h>
+
+#define MC33XS2410_GLB_CTRL		0x00
+#define MC33XS2410_GLB_CTRL_MODE_MASK	GENMASK(7, 6)
+#define MC33XS2410_GLB_CTRL_NORMAL_MODE	BIT(6)
+#define MC33XS2410_GLB_CTRL_SAFE_MODE	BIT(7)
+#define MC33XS2410_OUT1_4_CTRL		0x02
+#define MC33XS2410_PWM_CTRL1		0x05
+#define MC33XS2410_PWM_CTRL1_POL_INV(x)	BIT(x)
+#define MC33XS2410_PWM_CTRL3		0x07
+#define MC33XS2410_PWM_CTRL3_EN(x)	BIT(4 + (x))
+#define MC33XS2410_PWM_CTRL3_EN_MASK	GENMASK(7, 4)
+#define MC33XS2410_PWM_FREQ1		0x08
+#define MC33XS2410_PWM_FREQ(x)		(MC33XS2410_PWM_FREQ1 + (x))
+#define MC33XS2410_PWM_FREQ_STEP_MASK	GENMASK(7, 6)
+#define MC33XS2410_PWM_FREQ_MASK	GENMASK(5, 0)
+#define MC33XS2410_PWM_DC1		0x0c
+#define MC33XS2410_PWM_DC(x)		(MC33XS2410_PWM_DC1 + (x))
+#define MC33XS2410_WDT			0x14
+
+#define MC33XS2410_IN_OUT_STA		0x01
+#define MC33XS2410_IN_OUT_STA_OUT_EN(x)	BIT(4 + (x))
+
+#define MC33XS2410_WR_FLAG		BIT(7)
+#define MC33XS2410_RD_CTRL_FLAG		BIT(7)
+#define MC33XS2410_RD_DATA_MASK		GENMASK(13, 0)
+
+#define MC33XS2410_PERIOD_MAX	0
+#define MC33XS2410_PERIOD_MIN	1
+
+struct mc33xs2410_pwm {
+	struct pwm_chip chip;
+	struct spi_device *spi;
+	struct mutex lock;
+};
+
+enum mc33xs2410_freq_steps {
+	STEP_05HZ,
+	STEP_2HZ,
+	STEP_8HZ,
+	STEP_32HZ,
+};
+
+/*
+ * When outputs are controlled by SPI, the device supports four frequency ranges
+ * with following steps:
+ * - 0.5 Hz steps from 0.5 Hz to 32 Hz
+ * - 2 Hz steps from 2 Hz to 128 Hz
+ * - 8 Hz steps from 8 Hz to 512 Hz
+ * - 32 Hz steps from 32 Hz to 2048 Hz
+ * Below are the minimum and maximum frequencies converted to periods in ns for
+ * each of the four frequency ranges.
+ */
+static const u32 mc33xs2410_period[4][2] = {
+	[STEP_05HZ] = { 2000000000, 31250000 },
+	[STEP_2HZ] = { 500000000, 7812500 },
+	[STEP_8HZ] = { 125000000, 1953125 },
+	[STEP_32HZ] = { 31250000, 488281 },
+};
+
+static struct mc33xs2410_pwm *mc33xs2410_pwm_from_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct mc33xs2410_pwm, chip);
+}
+
+static int mc33xs2410_write_reg(struct spi_device *spi, u8 reg, u8 val)
+{
+	u8 tx[2];
+
+	tx[0] = reg | MC33XS2410_WR_FLAG;
+	tx[1] = val;
+
+	return spi_write(spi, tx, 2);
+}
+
+static int mc33xs2410_read_reg(struct spi_device *spi, u8 reg, bool ctrl)
+{
+	u8 tx[2], rx[2];
+	int ret;
+
+	tx[0] = reg;
+	tx[1] = ctrl ? MC33XS2410_RD_CTRL_FLAG : 0;
+
+	ret = spi_write(spi, tx, 2);
+	if (ret < 0)
+		return ret;
+
+	ret = spi_read(spi, rx, 2);
+	if (ret < 0)
+		return ret;
+
+	return FIELD_GET(MC33XS2410_RD_DATA_MASK, get_unaligned_be16(rx));
+}
+
+static int mc33xs2410_read_reg_ctrl(struct spi_device *spi, u8 reg)
+{
+	return mc33xs2410_read_reg(spi, reg, true);
+}
+
+static int mc33xs2410_modify_reg(struct spi_device *spi, u8 reg, u8 mask, u8 val)
+{
+	int ret;
+
+	ret = mc33xs2410_read_reg_ctrl(spi, reg);
+	if (ret < 0)
+		return ret;
+
+	ret &= ~mask;
+	ret |= val & mask;
+
+	return mc33xs2410_write_reg(spi, reg, ret);
+}
+
+static int mc33xs2410_read_reg_diag(struct spi_device *spi, u8 reg)
+{
+	return mc33xs2410_read_reg(spi, reg, false);
+}
+
+static u8 mc33xs2410_pwm_get_freq(const struct pwm_state *state)
+{
+	u32 period, freq, max, min;
+	int step;
+	u8 ret;
+
+	period = state->period;
+	/*
+	 * Check if period is within the limits of each of the four frequency
+	 * ranges, starting with the highest frequency(lowest period). Higher
+	 * frequencies are represented with better resolution by the device.
+	 */
+	for (step = STEP_32HZ; step >= STEP_05HZ; step--) {
+		min = mc33xs2410_period[step][MC33XS2410_PERIOD_MIN];
+		max = mc33xs2410_period[step][MC33XS2410_PERIOD_MAX];
+		if ((period <= max) && (period >= min))
+			break;
+	}
+
+	freq = DIV_ROUND_CLOSEST(max, period) - 1;
+	ret = FIELD_PREP(MC33XS2410_PWM_FREQ_MASK, freq);
+	return (ret | FIELD_PREP(MC33XS2410_PWM_FREQ_STEP_MASK, step));
+}
+
+static int mc33xs2410_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+				const struct pwm_state *state)
+{
+	struct mc33xs2410_pwm *mc33xs2410 = mc33xs2410_pwm_from_chip(chip);
+	struct spi_device *spi = mc33xs2410->spi;
+	u8 mask, val;
+	int ret;
+
+	if (state->period > mc33xs2410_period[STEP_05HZ][MC33XS2410_PERIOD_MAX])
+		return -EINVAL;
+
+	if (state->period < mc33xs2410_period[STEP_32HZ][MC33XS2410_PERIOD_MIN])
+		return -EINVAL;
+
+	guard(mutex)(&mc33xs2410->lock);
+	mask = MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm);
+	val = (state->polarity == PWM_POLARITY_INVERSED) ? mask : 0;
+	ret = mc33xs2410_modify_reg(spi, MC33XS2410_PWM_CTRL1, mask, val);
+	if (ret < 0)
+		return ret;
+
+	ret = mc33xs2410_write_reg(spi, MC33XS2410_PWM_FREQ(pwm->hwpwm),
+				   mc33xs2410_pwm_get_freq(state));
+	if (ret < 0)
+		return ret;
+
+	ret = mc33xs2410_write_reg(spi, MC33XS2410_PWM_DC(pwm->hwpwm),
+				   pwm_get_relative_duty_cycle(state, 255));
+	if (ret < 0)
+		return ret;
+
+	mask = MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm);
+	val = (state->enabled) ? mask : 0;
+	return mc33xs2410_modify_reg(spi, MC33XS2410_PWM_CTRL3, mask, val);
+}
+
+static int mc33xs2410_pwm_get_state(struct pwm_chip *chip,
+				    struct pwm_device *pwm,
+				    struct pwm_state *state)
+{
+	struct mc33xs2410_pwm *mc33xs2410 = mc33xs2410_pwm_from_chip(chip);
+	struct spi_device *spi = mc33xs2410->spi;
+	u32 freq, code, steps;
+	int ret;
+
+	guard(mutex)(&mc33xs2410->lock);
+	ret = mc33xs2410_read_reg_ctrl(spi, MC33XS2410_PWM_CTRL1);
+	if (ret < 0)
+		return ret;
+
+	state->polarity = (ret & MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm)) ?
+			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
+
+	ret = mc33xs2410_read_reg_ctrl(spi, MC33XS2410_PWM_FREQ(pwm->hwpwm));
+	if (ret < 0)
+		return ret;
+
+	/* Lowest frequency steps are starting with 0.5Hz, scale them by two. */
+	steps = (FIELD_GET(MC33XS2410_PWM_FREQ_STEP_MASK, ret) * 2) << 1;
+	code = FIELD_GET(MC33XS2410_PWM_FREQ_MASK, ret);
+	/* Frequency = (code + 1) x steps */
+	freq = (code + 1) * steps;
+	/* Convert frequency to period in ns, considering scaled steps value. */
+	state->period = 2000000000ULL / (freq);
+
+	ret = mc33xs2410_read_reg_ctrl(spi, MC33XS2410_PWM_DC(pwm->hwpwm));
+	if (ret < 0)
+		return ret;
+
+	ret = pwm_set_relative_duty_cycle(state, ret, 255);
+	if (ret)
+		return ret;
+
+	ret = mc33xs2410_read_reg_diag(spi, MC33XS2410_IN_OUT_STA);
+	if (ret < 0)
+		return ret;
+
+	state->enabled = !!(ret & MC33XS2410_IN_OUT_STA_OUT_EN(pwm->hwpwm));
+
+	return 0;
+}
+
+static const struct pwm_ops mc33xs2410_pwm_ops = {
+	.apply = mc33xs2410_pwm_apply,
+	.get_state = mc33xs2410_pwm_get_state,
+};
+
+static int mc33xs2410_reset(struct device *dev)
+{
+	struct gpio_desc *reset_gpio;
+
+	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR_OR_NULL(reset_gpio))
+		return PTR_ERR_OR_ZERO(reset_gpio);
+
+	fsleep(1000);
+	gpiod_set_value_cansleep(reset_gpio, 0);
+	/* Wake-up time */
+	fsleep(10000);
+
+	return 0;
+}
+
+static int mc33xs2410_probe(struct spi_device *spi)
+{
+	struct mc33xs2410_pwm *mc33xs2410;
+	struct device *dev = &spi->dev;
+	int ret;
+
+	mc33xs2410 = devm_kzalloc(&spi->dev, sizeof(*mc33xs2410), GFP_KERNEL);
+	if (!mc33xs2410)
+		return -ENOMEM;
+
+	mc33xs2410->chip.dev = dev;
+	mc33xs2410->chip.ops = &mc33xs2410_pwm_ops;
+	mc33xs2410->chip.npwm = 4;
+	mc33xs2410->spi = spi;
+	mutex_init(&mc33xs2410->lock);
+
+	ret = mc33xs2410_reset(dev);
+	if (ret)
+		return ret;
+
+	/* Disable watchdog */
+	ret = mc33xs2410_write_reg(spi, MC33XS2410_WDT, 0x0);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to disable watchdog\n");
+
+	/* Transitition to normal mode */
+	ret = mc33xs2410_modify_reg(spi, MC33XS2410_GLB_CTRL,
+				    MC33XS2410_GLB_CTRL_MODE_MASK,
+				    MC33XS2410_GLB_CTRL_NORMAL_MODE);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Failed to transition to normal mode\n");
+
+	ret = devm_pwmchip_add(dev, &mc33xs2410->chip);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to add pwm chip\n");
+
+	return 0;
+}
+
+static const struct spi_device_id mc33xs2410_spi_id[] = {
+	{ "mc33xs2410", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, mc33xs2410_spi_id);
+
+static const struct of_device_id mc33xs2410_of_match[] = {
+	{ .compatible = "nxp,mc33xs2410" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mc33xs2410_of_match);
+
+static struct spi_driver mc33xs2410_driver = {
+	.driver = {
+		.name = "mc33xs2410-pwm",
+		.of_match_table = mc33xs2410_of_match,
+	},
+	.probe = mc33xs2410_probe,
+	.id_table = mc33xs2410_spi_id,
+};
+module_spi_driver(mc33xs2410_driver);
+
+MODULE_DESCRIPTION("NXP MC33XS2410 high-side switch driver");
+MODULE_AUTHOR("Dimitri Fedrau <dima.fedrau@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.39.2


