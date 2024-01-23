Return-Path: <linux-kernel+bounces-36109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 526CB839BC4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3E891F25305
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2977C4EB55;
	Tue, 23 Jan 2024 22:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0L4V5h5K"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671644F5FD
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 22:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706047537; cv=none; b=GyAWxfX7mjzB0S+7AGkBnrR8+NAbfUn8bqwaZPyjexpLR+nQu1rKfjBWvglt6FMKTKm/Z29Jznm3Go2mVdrmduYtz53X6lMUCCwxSL6Hlz9pO/giZEjxW5gocjpvOrVhNPCTPj6kYyQ5zQYW5ljhLXf/WhR1ZEs6MHzOdw9ylac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706047537; c=relaxed/simple;
	bh=thO5LPEyWvzU47wXPE35nWn2JWrO47iL4KN3e4AIGmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwGS0cf6Wr9ebmfB8Ov7W0P8h9k4uq/7lNQa/oQjWLY6t5BFNHwg1uwlIhkAHlw1H1fwuzDdb8tq1hm+hKdC4REOh7a/xJ9V2H79Ij0DNb4mdR0ZKcVzGC5wzY9pnHmC65+sVEQwuL+XaDh5GSzG9G3lnramV8FvSxHbXowqLvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0L4V5h5K; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-783148737d5so379793185a.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 14:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706047533; x=1706652333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BwJ9PTqkhtEkz7ixLUun1KPqXqIDAwDlxefhzBSFQg=;
        b=0L4V5h5KLtadPT/A+yTWF2yY58nllCWWZ+/H/+TLabm8Itj/P3OFfWsvpIrgNLZThd
         /EbPRjPk0Rlc04FDGawITzo/kgNWcIjo3Tn4Nm3wAojQRuxNckNsZ4Z2EQXJK67DF6MP
         8WZdi4cP5JPzG6KL8dZ9FhngnjWdHpEDl/yHATU3rUftO6Cft/dJHqfAdr6cYNAFMd/p
         2okBHXmZgie7WNjX5iKwakD950xlVziBVgf5bGFPOW18TytBURbWZDs8Xnh8RsWMesLS
         elRoUUdo/IvcXcOraz4zO08XZza72oYGGzOuDM43gVv+LikyndCoBNNsA9uS0kOFZ3BZ
         LdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706047533; x=1706652333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BwJ9PTqkhtEkz7ixLUun1KPqXqIDAwDlxefhzBSFQg=;
        b=nZwQw28ZG+/ClQQmQbsYhUIQs3lCvEVtkwWdSWp2EfXV6l9rTlLDx3whYXRPHlVVa7
         R+rAxI1X5TRJ9YmmrSojOs3VgtLgFZzGSqVZ/QJoe5ds0T66S6hREIpND7UcFTzP3yxI
         zrCkDlIu9TZRSvnuBzOuaZ7NlzjPyKNyldG/S8rmdfj+IVTphJRIe5g65+ZP3gd4GRrd
         XfTaLP31KmIFNVVyaLJ9f/tZfGnoWJBpqvBhmWYYaR2vQIyWIXakVrBpFJOWsY85gcrx
         CVXTL+57XQaD6ZwjsHdttsRLPlkmeJtYpmzQosqHM4dZrbr3tcX152hGngl8eGkBhywS
         sjbA==
X-Gm-Message-State: AOJu0YyI14Hg0XtC8yM5bChvFqaZzvGJBO+rw2SbAZWyDAt1aRhLMpbo
	0evKwWQsTujZ5KHfwTKlIaM/vdhbfgCFZEohotQo5TxnLkkOhTMtL7rQ/My+G7c=
X-Google-Smtp-Source: AGHT+IGR2wATbVPvUAhdpdMWB0/9KXexd06mEugHvMz6YKNtF7X1+kFF+aaNUe4nbxZ2iiBQISi94Q==
X-Received: by 2002:a05:620a:388c:b0:783:2b14:eca7 with SMTP id qp12-20020a05620a388c00b007832b14eca7mr7237057qkn.48.1706047533268;
        Tue, 23 Jan 2024 14:05:33 -0800 (PST)
Received: from workbox.taildc8f3.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id y26-20020a05620a09da00b007834bfeb0e8sm3425402qky.51.2024.01.23.14.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 14:05:33 -0800 (PST)
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
Subject: [PATCH 2/2 v2] pwm: Add driver for AXI PWM generator
Date: Tue, 23 Jan 2024 17:05:14 -0500
Message-ID: <20240123220515.279439-3-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123220515.279439-1-tgamblin@baylibre.com>
References: <20240123220515.279439-1-tgamblin@baylibre.com>
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
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>

---
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
 drivers/pwm/pwm-axi-pwmgen.c | 246 +++++++++++++++++++++++++++++++++++
 4 files changed, 261 insertions(+)
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
index 000000000000..39d2c7be0cb4
--- /dev/null
+++ b/drivers/pwm/pwm-axi-pwmgen.c
@@ -0,0 +1,246 @@
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
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#define AXI_PWMGEN_VERSION_MAJOR(x)	(((x) >> 16) & 0xff)
+#define AXI_PWMGEN_VERSION_MINOR(x)	(((x) >> 8) & 0xff)
+#define AXI_PWMGEN_VERSION_PATCH(x)	((x) & 0xff)
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
+
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
+	if (AXI_PWMGEN_VERSION_MAJOR(val) != 1) {
+		return dev_err_probe(dev, -ENODEV, "Unsupported peripheral version %u.%u.%u\n",
+			AXI_PWMGEN_VERSION_MAJOR(val),
+			AXI_PWMGEN_VERSION_MINOR(val),
+			AXI_PWMGEN_VERSION_PATCH(val));
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


