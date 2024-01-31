Return-Path: <linux-kernel+bounces-47185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD6A844A41
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B752128B15E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60203A1A8;
	Wed, 31 Jan 2024 21:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PoBmTTo0"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A878439AFC
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 21:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737253; cv=none; b=NqW8B2WEng0ANGlA63/KTtPOXUXjJB02QPavvK0CDvz6D+RNIUPusD1X3f12YQXXBwk1pZrYX3OukrvS5n8OxqgGLnPetJvJIHqgaEqXHgQeB4mMnJOO5aHeqJ9EYKJIs1060tRKCyzQBTON1xzlkoGXZ968Nv5DVQ0jPc4adAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737253; c=relaxed/simple;
	bh=TzJI9DKcr14wIxwW5xX42GkeCx1HYD+R/f/OjsgMQu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzKisSJeozR/EiikEFvpMv2tE+1pFVQZ06n9x+wLHp3p+wS79hoov9yOduEUBM8v7b/sRd2CVhF1p3GuiwGhtBDZW5bm9sUSFj+3XZxEIZlGPP38QrkSBKKQzLvtn2kCRNpfOz5h7pV5kjCMEU8lGwNEpKh2Tujah14kBreS+/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PoBmTTo0; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3be90c51299so174583b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706737249; x=1707342049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsEVxG29WCMfnx8JtgD8uSy6BCcIKhPjoqts5Funlgk=;
        b=PoBmTTo0KoAn3js0XbH5oWloyA2CgcHc/5JDUAWuMCfMQQXG1ohyDPT0HDrt6NeUNP
         NQgW4BdUuBZRmyQvOVBVzV3rFewE3t9Y5sZ9wHVbAr3prde7WWs4O8DxB8KZhbmfZQFh
         386XAdD0E7CzHtbZaUX0iTK9WOkkFmPBvLjO9/R1x94RVlzDTcubx00tNIGWmSYfsrtf
         TX5SqFWmnzKFkTHu/lyE2GUrlhEQjfQvPAEFWqCYuf94X7tysj4vKpblaYSDIDHN2UlY
         qGSby5aqBJ2qQrRFLt9Doyg/Fu4upmS0wj8SannweQQ/Lc3dbTDbdeEZ+pPvwxdolZVp
         crJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706737249; x=1707342049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsEVxG29WCMfnx8JtgD8uSy6BCcIKhPjoqts5Funlgk=;
        b=rcl1edOeGz0w14q6Z0CE9cpkJU3LgBgyo5rMbEF6lbjolepqkDLQhm3uBbU9qWIyzk
         I9SLP0+fYmmqC399DFlrSAx5f43JPEr3u4EK1acEwBNqppl+QXVH4B1dQoE+9rbIaMPd
         Kdqd7uGkGex10GyPIxQzUHEv6krp3R/E8BojEQ6sWz08IJ9JnNN+meuwKrqdNRkJv9L0
         GPd8mcZKfW8oTKV1i0MD9y2539rdF1FR0t+69IwFgspcGYa56O1C38IgQ5lXjeLZFnHZ
         lz9ePCvs2+AhE2iOLYuLRHNneO1F981htyzhl+ln/0NotK/rqD2lK6aPJY2isRrK+f1z
         wWpg==
X-Gm-Message-State: AOJu0Yyh0diHatIqzVeRGw1B+rRJb2Ztb1UKe2jnGCELCzjL/C2OdqxS
	1/5i8JmnVNpklk01w5K1QYyTYHWw5w+qD6nfFYtbP0ckWA50fUhpJTfqCKXXNGY=
X-Google-Smtp-Source: AGHT+IHq/e8pnhFUDAICQ/t87WXNxsEnPo/PiG4c3dkbnBNplJBMJcBVN+cLzHqJSQ4NMwb+ZA020g==
X-Received: by 2002:a05:6808:2f05:b0:3be:c0f9:3cb4 with SMTP id gu5-20020a0568082f0500b003bec0f93cb4mr3643826oib.25.1706737249530;
        Wed, 31 Jan 2024 13:40:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUJnNirCWZnLItLHBgrn1/jV23gkm3qXnwUW9u1iYwRtC1mlU+gUu1QUTqY3kzXJNkCWo++RHySDOSFqgd3vJviwX0VBWi/kDs7DYcy5szkGmxpgBTrjJrpiDQy/UTv+LvBO8ydETYTV5AaWlEZEY1k/osNajJ06rQgzuc2rf1QihUAstLTZ+tafxUI13lZcSisziZ6V63fyWXe+aPDzI4NLkT9TVlmg6qdNuvHHe1jhLt+3aEz6IWAeLt5Q8QA6rKKxMN5EzqtqPO+IuCfLRDxRy9rIlJBTuibHSpIjdhmkRkUxeHHTlj6e67/5Z4Q4keiKsaENLQvbBS/aeAeTK8rqDjUoPzZjpkkzZeVMjgPb0esDy02OMbzhrA8pjs4/GjA6vlMs8BT/cel0JDzXVESIdp4+JbVGj3gIsx6JCyQnHQgzlG9YdOVhqY=
Received: from workbox.taildc8f3.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id br44-20020a05620a462c00b007853f040aedsm537160qkb.8.2024.01.31.13.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 13:40:49 -0800 (PST)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	u.kleine-koenig@pengutronix.de,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	Drew Fustini <dfustini@baylibre.com>,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH 2/2 v3] pwm: Add driver for AXI PWM generator
Date: Wed, 31 Jan 2024 16:40:41 -0500
Message-ID: <20240131214042.1335251-3-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131214042.1335251-1-tgamblin@baylibre.com>
References: <20240131214042.1335251-1-tgamblin@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Drew Fustini <dfustini@baylibre.com>

Add support for the Analog Devices AXI PWM Generator. This device is an
FPGA-implemented peripheral used as PWM signal generator and can be
interfaced with AXI4. The register map of this peripheral makes it
possible to configure the period and duty cycle of the output signal.

Link: https://wiki.analog.com/resources/fpga/docs/axi_pwm_gen
Co-developed-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Co-developed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
Acked-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
v3 changes:
* Address feedback for driver in v2:
  * Remove unnecessary blank line in axi_pwmgen_apply
  * Use macros already defined in <linux/fpga/adi-axi-common.h> for
    version checking

v2 changes:
* Address feedback for driver and device tree in v1:
  * Use more reasonable Kconfig approach
  * Use common prefixes for all functions
  * Rename axi_pwmgen struct to axi_pwmgen_ddata
  * Change use of "pwm" to "ddata"
  * Set and check state->polarity
  * Multiply safely with mul_u64_u64_div_u64()
  * Improve handling of max and zero periods
  * Error if clk_rate_hz > NSEC_PER_SEC
  * Add "Limitations" section at top of pwm-axi-pwmgen.c
  * Don't disable outputs by default
  * Remove unnecessary macros for period, duty, offset
  * Fix axi_pwmgen_ddata alignment
  * Don't artificially limit npwm to four
  * Use clk_rate_exclusive_get(), balance with clk_rate_exclusive_put()
  * Cache clk rate in axi_pwmgen_ddata
  * Don't assign pwm->chip.base, do assign pwm->chip.atomic
* Remove redundant calls to clk_get_rate
* Test contents of AXI_PWMGEN_REG_CORE_MAGIC instead of
  arbitrary AXI_PWMGEN_TEST_DATA in AXI_PWMGEN_REG_SCRATCHPAD
* Remove redundant clk struct from axi_pwmgen_ddata
* Add self as module author
* Add major version check for IP core

---
 MAINTAINERS                  |   1 +
 drivers/pwm/Kconfig          |  13 ++
 drivers/pwm/Makefile         |   1 +
 drivers/pwm/pwm-axi-pwmgen.c | 242 +++++++++++++++++++++++++++++++++++
 4 files changed, 257 insertions(+)
 create mode 100644 drivers/pwm/pwm-axi-pwmgen.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a4ed5545680..2baa7a0a1c8c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3438,6 +3438,7 @@ L:	linux-pwm@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
+F:	drivers/pwm/pwm-axi-pwmgen.c
 
 AXXIA I2C CONTROLLER
 M:	Krzysztof Adamski <krzysztof.adamski@nokia.com>
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 4b956d661755..d44b0e86adee 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -98,6 +98,19 @@ config PWM_ATMEL_TCB
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-atmel-tcb.
 
+config PWM_AXI_PWMGEN
+	tristate "Analog Devices AXI PWM generator"
+	depends on MICROBLAZE || NIOS2 || ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA || COMPILE_TEST
+	select REGMAP_MMIO
+	help
+	  This enables support for the Analog Devices AXI PWM generator.
+
+	  This is a configurable PWM generator with variable pulse width and
+	  period.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called pwm-axi-pwmgen.
+
 config PWM_BCM_IPROC
 	tristate "iProc PWM support"
 	depends on ARCH_BCM_IPROC || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index c5ec9e168ee7..8322089954e9 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_PWM_APPLE)		+= pwm-apple.o
 obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
 obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
 obj-$(CONFIG_PWM_ATMEL_TCB)	+= pwm-atmel-tcb.o
+obj-$(CONFIG_PWM_AXI_PWMGEN)	+= pwm-axi-pwmgen.o
 obj-$(CONFIG_PWM_BCM_IPROC)	+= pwm-bcm-iproc.o
 obj-$(CONFIG_PWM_BCM_KONA)	+= pwm-bcm-kona.o
 obj-$(CONFIG_PWM_BCM2835)	+= pwm-bcm2835.o
diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
new file mode 100644
index 000000000000..44e62e90b227
--- /dev/null
+++ b/drivers/pwm/pwm-axi-pwmgen.c
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Analog Devices AXI PWM generator
+ *
+ * Copyright 2024 Analog Devices Inc.
+ * Copyright 2024 Baylibre SAS
+ *
+ * Limitations:
+ * - The writes to registers for period and duty are shadowed until
+ *   LOAD_CONFIG is written to AXI_PWMGEN_REG_CONFIG at the end of the
+ *   current period.
+ * - Writing LOAD_CONFIG also has the effect of re-synchronizing all
+ *   enabled channels, which could cause glitching on other channels. It
+ *   is therefore expected that channels are assigned harmonic periods
+ *   and all have a single user coordinating this.
+ * - Supports normal polarity. Does not support changing polarity.
+ */
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/fpga/adi-axi-common.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#define AXI_PWMGEN_REG_CORE_VERSION	0x00
+#define AXI_PWMGEN_REG_ID		0x04
+#define AXI_PWMGEN_REG_SCRATCHPAD	0x08
+#define AXI_PWMGEN_REG_CORE_MAGIC	0x0C
+#define AXI_PWMGEN_REG_CONFIG		0x10
+#define AXI_PWMGEN_REG_NPWM		0x14
+#define AXI_PWMGEN_CHX_PERIOD(ch)	(0x40 + (12 * (ch)))
+#define AXI_PWMGEN_CHX_DUTY(ch)		(0x44 + (12 * (ch)))
+#define AXI_PWMGEN_CHX_OFFSET(ch)	(0x48 + (12 * (ch)))
+#define AXI_PWMGEN_REG_CORE_MAGIC_VAL	0x601A3471 /* Identification number to test during setup */
+#define AXI_PWMGEN_LOAD_CONFIG		BIT(1)
+#define AXI_PWMGEN_RESET		BIT(0)
+
+struct axi_pwmgen_ddata {
+	struct pwm_chip	chip;
+	struct regmap *regmap;
+	unsigned long clk_rate_hz;
+};
+
+static const struct regmap_config axi_pwmgen_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+};
+
+static struct axi_pwmgen_ddata *axi_pwmgen_from_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct axi_pwmgen_ddata, chip);
+}
+
+static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct axi_pwmgen_ddata *ddata = axi_pwmgen_from_chip(chip);
+	unsigned int ch = pwm->hwpwm;
+	struct regmap *regmap = ddata->regmap;
+	u64 period_cnt, duty_cnt;
+	int ret;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	if (state->enabled) {
+		period_cnt = mul_u64_u64_div_u64(state->period, ddata->clk_rate_hz, NSEC_PER_SEC);
+		if (period_cnt > UINT_MAX)
+			period_cnt = UINT_MAX;
+
+		if (period_cnt == 0)
+			return -EINVAL;
+
+		ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), period_cnt);
+		if (ret)
+			return ret;
+
+		duty_cnt = mul_u64_u64_div_u64(state->duty_cycle, ddata->clk_rate_hz, NSEC_PER_SEC);
+		if (duty_cnt > UINT_MAX)
+			duty_cnt = UINT_MAX;
+
+		ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), duty_cnt);
+		if (ret)
+			return ret;
+	} else {
+		ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), 0);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), 0);
+		if (ret)
+			return ret;
+	}
+
+	return regmap_write(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_LOAD_CONFIG);
+}
+
+static int axi_pwmgen_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				struct pwm_state *state)
+{
+	struct axi_pwmgen_ddata *ddata = axi_pwmgen_from_chip(chip);
+	struct regmap *regmap = ddata->regmap;
+	unsigned int ch = pwm->hwpwm;
+	u32 cnt;
+	int ret;
+
+	ret = regmap_read(regmap, AXI_PWMGEN_CHX_PERIOD(ch), &cnt);
+	if (ret)
+		return ret;
+
+	state->enabled = cnt != 0;
+
+	state->period = DIV_ROUND_UP_ULL((u64)cnt * NSEC_PER_SEC, ddata->clk_rate_hz);
+
+	ret = regmap_read(regmap, AXI_PWMGEN_CHX_DUTY(ch), &cnt);
+	if (ret)
+		return ret;
+
+	state->duty_cycle = DIV_ROUND_UP_ULL((u64)cnt * NSEC_PER_SEC, ddata->clk_rate_hz);
+
+	state->polarity = PWM_POLARITY_NORMAL;
+
+	return 0;
+}
+
+static const struct pwm_ops axi_pwmgen_pwm_ops = {
+	.apply = axi_pwmgen_apply,
+	.get_state = axi_pwmgen_get_state,
+};
+
+static int axi_pwmgen_setup(struct axi_pwmgen_ddata *ddata, struct device *dev)
+{
+	struct regmap *regmap = ddata->regmap;
+	int ret;
+	u32 val;
+
+	ret = regmap_read(regmap, AXI_PWMGEN_REG_CORE_MAGIC, &val);
+	if (ret)
+		return ret;
+
+	if (val != AXI_PWMGEN_REG_CORE_MAGIC_VAL)
+		return dev_err_probe(dev, -ENODEV,
+			"failed to read expected value from register: got %08x, expected %08x\n",
+			val,
+			AXI_PWMGEN_REG_CORE_MAGIC_VAL);
+
+	ret = regmap_read(regmap, AXI_PWMGEN_REG_CORE_VERSION, &val);
+	if (ret)
+		return ret;
+
+	if (ADI_AXI_PCORE_VER_MAJOR(val) != 1) {
+		return dev_err_probe(dev, -ENODEV, "Unsupported peripheral version %u.%u.%u\n",
+			ADI_AXI_PCORE_VER_MAJOR(val),
+			ADI_AXI_PCORE_VER_MINOR(val),
+			ADI_AXI_PCORE_VER_PATCH(val));
+	}
+
+	ret = regmap_read(regmap, AXI_PWMGEN_REG_NPWM, &ddata->chip.npwm);
+	if (ret)
+		return ret;
+
+	/* Enable the core */
+	return regmap_update_bits(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_RESET, 0);
+}
+
+static void axi_pwmgen_clk_rate_exclusive_put(void *data)
+{
+	clk_rate_exclusive_put(data);
+}
+
+static int axi_pwmgen_probe(struct platform_device *pdev)
+{
+	struct axi_pwmgen_ddata *ddata;
+	struct clk *clk;
+	void __iomem *io_base;
+	int ret;
+
+	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	io_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(io_base))
+		return PTR_ERR(io_base);
+
+	ddata->regmap = devm_regmap_init_mmio(&pdev->dev, io_base, &axi_pwmgen_regmap_config);
+	if (IS_ERR(ddata->regmap))
+		return dev_err_probe(&pdev->dev, PTR_ERR(ddata->regmap),
+				     "failed to init register map\n");
+
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(clk), "failed to get clock\n");
+
+	ret = clk_rate_exclusive_get(clk);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to get exclusive rate\n");
+
+	ret = devm_add_action_or_reset(&pdev->dev, axi_pwmgen_clk_rate_exclusive_put, clk);
+	if (ret)
+		return ret;
+
+	ddata->clk_rate_hz = clk_get_rate(clk);
+	if (!ddata->clk_rate_hz || ddata->clk_rate_hz > NSEC_PER_SEC)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "Invalid clock rate: %lu\n", ddata->clk_rate_hz);
+
+	ddata->chip.dev = &pdev->dev;
+	ddata->chip.ops = &axi_pwmgen_pwm_ops;
+	ddata->chip.atomic = true;
+
+	ret = axi_pwmgen_setup(ddata, &pdev->dev);
+	if (ret < 0)
+		return ret;
+
+	return devm_pwmchip_add(&pdev->dev, &ddata->chip);
+}
+
+static const struct of_device_id axi_pwmgen_ids[] = {
+	{ .compatible = "adi,axi-pwmgen-1.00.a" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, axi_pwmgen_ids);
+
+static struct platform_driver axi_pwmgen_driver = {
+	.driver = {
+		.name = "axi-pwmgen",
+		.of_match_table = axi_pwmgen_ids,
+	},
+	.probe = axi_pwmgen_probe,
+};
+module_platform_driver(axi_pwmgen_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Sergiu Cuciurean <sergiu.cuciurean@analog.com>");
+MODULE_AUTHOR("Trevor Gamblin <tgamblin@baylibre.com>");
+MODULE_DESCRIPTION("Driver for the Analog Devices AXI PWM generator");
-- 
2.43.0


