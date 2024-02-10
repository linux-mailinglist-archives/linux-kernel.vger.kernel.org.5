Return-Path: <linux-kernel+bounces-60308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 465548502FE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 08:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A78DDB23AF4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 07:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845E136AE0;
	Sat, 10 Feb 2024 07:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BHBbMjYP"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7E1200DC
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 07:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707548986; cv=none; b=SKmVgorTOBEVxXEQTFO8L5usN+4XLvUMhYrLy7sxdNCNdB0n893eZkM87NJHhK15C51t0OTl2UUBEQ5AIlwrQiKfsaIFws3X5ZvhuQ2/h8I1HE5ZQ1kAykGj9ohn8yLhvyUKOX9lAPhlaT3ik9mtjjnDseFQIQbdhboblr/Mmjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707548986; c=relaxed/simple;
	bh=gPaBS0oQVJX1UXa+pMAzOknoNywuSAjjRI9YDTj0/xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbOdbch4vOIemf5qmV2f6zkX3/IkFAvbIRamJ42b7QMy7EfyK2FNceLI7eS06+oUNxHw37lvKkC8sSDxH13DGl+GrsxaKLuWtfKlytXC9W92vC9oCJkTwQPRBmrlYz2e81VKriPqH5DBzZGdRTGmnM69zqGZy36RaUg0Eo3MVpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BHBbMjYP; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d7431e702dso15755105ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 23:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707548983; x=1708153783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o84QHSqn+ObMNs1MLh+nj630dEtvLSjAJedEuzESKd8=;
        b=BHBbMjYPKEFlgeJHbV5ap6HI5KNG+EKrdD1Wa+1KDF41YcPxxSB7DOclm+OwpyFUN9
         uDqKnenXFCJJ+I8cmJbAMl0UhgPlL1RzwArbElHlA0AfFlUpK81FSBYJ/mVC96efB3vy
         w3ByCcFHMRrTHiUA+4a0gwL+excBDgBUSvMpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707548983; x=1708153783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o84QHSqn+ObMNs1MLh+nj630dEtvLSjAJedEuzESKd8=;
        b=KTa3l9gv1Ag4J1q3pwNr65Q5jcTBbsm1SUyU200ocTfNVlqvBLbtJlHncUGcy+mmUG
         WurEdcQPVeWOwsCED6mNAtgI+kC/j321i0lt2ZHsmJjvhq9LOLLMwR9c532WhjEzEO4B
         zX3dkiTv0JqZdo3SfTvb2qNRVYLCN52Z5/l/AmYL2ATSPN9FGQY74eRoGvQC3WmsAA+v
         PZI8obDalAzha7nemzvBWsiKcw0w2MaGekfqKrsWs85nwMPwHh1kjFp/dfJs55GZ9GPv
         cMMPVxEGMhkioRdexGwXYLi7vLAtFwovji9YEQk2op7ZjMjoL2rJQfjJLJrzvCjqm3l+
         DtGw==
X-Gm-Message-State: AOJu0YxEWhYx4DqaoMG8GhobsHEIlpAdC8OvM4SWQA79VPOwB2uelTwt
	4ok5a0/BtSktcZrAMocvHPlbdp93ijJEZTR9aXpBmBXg7+ilA87fyxkYlaj58g==
X-Google-Smtp-Source: AGHT+IHQqPyQHPEDIlCHc7C1mC3g8p62zaSNCMkmWlBGHZZZW1BGkyGvlV2yTQuTXgKLPHa+ekutbw==
X-Received: by 2002:a17:90a:9b89:b0:296:111b:9f54 with SMTP id g9-20020a17090a9b8900b00296111b9f54mr804884pjp.19.1707548982684;
        Fri, 09 Feb 2024 23:09:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUZvkpINzfgQ79HHlVYtLDFq1tpexnzLkHo5LRNFPbTvlqmQn54F9Mwd4587ls60RSzNQHZUAfL/GfLqhDQ0LGkkfy1w/Zp4ydvD/im29I8IJRiAbr8fTRNMBd+EmSIpoOGgsNVxLHfuR+JQ5UO9UYe6NEallKgWwjKgAf0NrRPbvILevlY/iuAVnlwX0QpqJ5B6DCCk5WSdWbD46OV7cTzJDdhwNzC37HEXY9Ce+rIAZWozg6k+9aHP7kHptVEKa3CfcLoU5SuDiF+sGzCemr9VpyrScYnpqoMWsGxZlYPexj5hRwrYP2UdVX57fCmdeGEWH7R7q1jPCD+NK/80TtWguEKO7t8BY4t2JgVIxPNl2/oBdyhDqFh2H16xj7Ord01E3pFFx2qbGQqDcVv/6/Mz5vPOmeDwzoZ2ZMMCxc2u4X7U6D8Kg==
Received: from localhost (175.199.125.34.bc.googleusercontent.com. [34.125.199.175])
        by smtp.gmail.com with UTF8SMTPSA id r8-20020a17090ad40800b002967bc2c852sm2903295pju.43.2024.02.09.23.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 23:09:42 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: chrome-platform@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	linux-gpio@vger.kernel.org
Subject: [PATCH 02/22] gpio: Add ChromeOS EC GPIO driver
Date: Fri,  9 Feb 2024 23:09:13 -0800
Message-ID: <20240210070934.2549994-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240210070934.2549994-1-swboyd@chromium.org>
References: <20240210070934.2549994-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ChromeOS embedded controller (EC) supports setting the state of
GPIOs when the system is unlocked, and getting the state of GPIOs in all
cases. The GPIOs are on the EC itself, so the EC acts similar to a GPIO
expander. Add a driver to get and set the GPIOs on the EC through the
host command interface.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: <linux-gpio@vger.kernel.org>
Cc: <chrome-platform@lists.linux.dev>
Cc: Pin-yen Lin <treapking@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpio/Kconfig        |  10 ++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/gpio-cros-ec.c | 218 ++++++++++++++++++++++++++++++++++++
 3 files changed, 229 insertions(+)
 create mode 100644 drivers/gpio/gpio-cros-ec.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b3a133ed31ee..62b0ae25a727 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1220,6 +1220,16 @@ config GPIO_BD9571MWV
 	  This driver can also be built as a module. If so, the module
 	  will be called gpio-bd9571mwv.
 
+config GPIO_CROS_EC
+	tristate "ChromeOS EC GPIO support"
+	depends on CROS_EC
+	help
+	  GPIO driver for exposing GPIOs on the ChromeOS Embedded
+	  Controller.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called gpio-cros-ec.
+
 config GPIO_CRYSTAL_COVE
 	tristate "GPIO support for Crystal Cove PMIC"
 	depends on (X86 || COMPILE_TEST) && INTEL_SOC_PMIC
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index eb73b5d633eb..2e66410c1da6 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_GPIO_BT8XX)		+= gpio-bt8xx.o
 obj-$(CONFIG_GPIO_CADENCE)		+= gpio-cadence.o
 obj-$(CONFIG_GPIO_CLPS711X)		+= gpio-clps711x.o
 obj-$(CONFIG_GPIO_SNPS_CREG)		+= gpio-creg-snps.o
+obj-$(CONFIG_GPIO_CROS_EC)		+= gpio-cros-ec.o
 obj-$(CONFIG_GPIO_CRYSTAL_COVE)		+= gpio-crystalcove.o
 obj-$(CONFIG_GPIO_CS5535)		+= gpio-cs5535.o
 obj-$(CONFIG_GPIO_DA9052)		+= gpio-da9052.o
diff --git a/drivers/gpio/gpio-cros-ec.c b/drivers/gpio/gpio-cros-ec.c
new file mode 100644
index 000000000000..0d35558304bf
--- /dev/null
+++ b/drivers/gpio/gpio-cros-ec.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2024 Google LLC
+ *
+ * This driver provides the ability to control GPIOs on the Chrome OS EC.
+ * There isn't any direction control, and setting values on GPIOs is only
+ * possible when the system is unlocked.
+ */
+
+#include <linux/bitops.h>
+#include <linux/errno.h>
+#include <linux/gpio/driver.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_data/cros_ec_commands.h>
+#include <linux/platform_data/cros_ec_proto.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+/* Setting gpios is only supported when the system is unlocked */
+static void cros_ec_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	const char *name = gc->names[gpio];
+	struct cros_ec_device *cros_ec = gpiochip_get_data(gc);
+	struct ec_params_gpio_set params = {
+		.val = val,
+	};
+	int ret;
+	ssize_t copied;
+
+	copied = strscpy(params.name, name, sizeof(params.name));
+	if (copied < 0)
+		return;
+
+	ret = cros_ec_cmd(cros_ec, 0, EC_CMD_GPIO_SET, &params,
+			  sizeof(params), NULL, 0);
+	if (ret < 0)
+		dev_err(gc->parent, "error setting gpio%d (%s) on EC: %d\n", gpio, name, ret);
+}
+
+static int cros_ec_gpio_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	const char *name = gc->names[gpio];
+	struct cros_ec_device *cros_ec = gpiochip_get_data(gc);
+	struct ec_params_gpio_get params;
+	struct ec_response_gpio_get response;
+	int ret;
+	ssize_t copied;
+
+	copied = strscpy(params.name, name, sizeof(params.name));
+	if (copied < 0)
+		return -EINVAL;
+
+	ret = cros_ec_cmd(cros_ec, 0, EC_CMD_GPIO_GET, &params,
+			  sizeof(params), &response, sizeof(response));
+	if (ret < 0) {
+		dev_err(gc->parent, "error getting gpio%d (%s) on EC: %d\n", gpio, name, ret);
+		return ret;
+	}
+
+	return response.val;
+}
+
+#define CROS_EC_GPIO_INPUT         BIT(8)
+#define CROS_EC_GPIO_OUTPUT        BIT(9)
+
+static int cros_ec_gpio_get_direction(struct gpio_chip *gc, unsigned int gpio)
+{
+	const char *name = gc->names[gpio];
+	struct cros_ec_device *cros_ec = gpiochip_get_data(gc);
+	struct ec_params_gpio_get_v1 params = {
+		.subcmd = EC_GPIO_GET_INFO,
+		.get_info.index = gpio,
+	};
+	struct ec_response_gpio_get_v1 response;
+	int ret;
+
+	ret = cros_ec_cmd(cros_ec, 1, EC_CMD_GPIO_GET, &params,
+			  sizeof(params), &response, sizeof(response));
+	if (ret < 0) {
+		dev_err(gc->parent, "error getting direction of gpio%d (%s) on EC: %d\n", gpio, name, ret);
+		return ret;
+	}
+
+	if (response.get_info.flags & CROS_EC_GPIO_INPUT)
+		return GPIO_LINE_DIRECTION_IN;
+
+	if (response.get_info.flags & CROS_EC_GPIO_OUTPUT)
+		return GPIO_LINE_DIRECTION_OUT;
+
+	return -EINVAL;
+}
+
+static int cros_ec_gpio_request(struct gpio_chip *chip, unsigned gpio_pin)
+{
+	if (gpio_pin < chip->ngpio)
+		return 0;
+
+	return -EINVAL;
+}
+
+/* Query EC for all gpio line names */
+static int cros_ec_gpio_init_names(struct cros_ec_device *cros_ec, struct gpio_chip *gc)
+{
+	struct ec_params_gpio_get_v1 params = {
+		.subcmd = EC_GPIO_GET_INFO,
+	};
+	struct ec_response_gpio_get_v1 response;
+	int ret, i;
+	/* EC may not NUL terminate */
+	size_t name_len = sizeof(response.get_info.name) + 1;
+	ssize_t copied;
+	const char **names;
+	char *str;
+
+	names = devm_kcalloc(gc->parent, gc->ngpio, sizeof(*names), GFP_KERNEL);
+	if (!names)
+		return -ENOMEM;
+	gc->names = names;
+
+	str = devm_kcalloc(gc->parent, gc->ngpio, name_len, GFP_KERNEL);
+	if (!str)
+		return -ENOMEM;
+
+	/* Get gpio line names one at a time */
+	for (i = 0; i < gc->ngpio; i++) {
+		params.get_info.index = i;
+		ret = cros_ec_cmd(cros_ec, 1, EC_CMD_GPIO_GET, &params,
+				  sizeof(params), &response, sizeof(response));
+		if (ret < 0) {
+			dev_err_probe(gc->parent, ret, "error getting gpio%d info\n", i);
+			return ret;
+		}
+
+		names[i] = str;
+		copied = strscpy(str, response.get_info.name, name_len);
+		if (copied < 0)
+			return copied;
+
+		str += copied + 1;
+	}
+
+	return 0;
+}
+
+/* Query EC for number of gpios */
+static int cros_ec_gpio_ngpios(struct cros_ec_device *cros_ec)
+{
+	struct ec_params_gpio_get_v1 params = {
+		.subcmd = EC_GPIO_GET_COUNT,
+	};
+	struct ec_response_gpio_get_v1 response;
+	int ret;
+
+	ret = cros_ec_cmd(cros_ec, 1, EC_CMD_GPIO_GET, &params,
+			  sizeof(params), &response, sizeof(response));
+	if (ret < 0)
+		return ret;
+
+	return response.get_count.val;
+}
+
+static int cros_ec_gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cros_ec_device *cros_ec = dev_get_drvdata(dev->parent);
+	struct gpio_chip *gc;
+	int ngpios;
+	int ret;
+
+	ngpios = cros_ec_gpio_ngpios(cros_ec);
+	if (ngpios < 0) {
+		dev_err_probe(dev, ngpios, "error getting gpio count\n");
+		return ngpios;
+	}
+
+	gc = devm_kzalloc(&pdev->dev, sizeof(*gc), GFP_KERNEL);
+	if (!gc)
+		return -ENOMEM;
+
+	gc->ngpio = ngpios;
+	gc->parent = dev;
+	ret = cros_ec_gpio_init_names(cros_ec, gc);
+	if (ret)
+		return ret;
+
+	gc->can_sleep = true;
+	gc->label = dev_name(dev);
+	gc->base = -1;
+	gc->set = cros_ec_gpio_set;
+	gc->get = cros_ec_gpio_get;
+	gc->get_direction = cros_ec_gpio_get_direction;
+	gc->request = cros_ec_gpio_request;
+
+	return devm_gpiochip_add_data(&pdev->dev, gc, cros_ec);
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id cros_ec_gpio_of_match[] = {
+	{ .compatible = "google,cros-ec-gpio" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, cros_ec_gpio_of_match);
+#endif
+
+static struct platform_driver cros_ec_gpio_driver = {
+	.probe = cros_ec_gpio_probe,
+	.driver = {
+		.name = "cros-ec-gpio",
+		.of_match_table = of_match_ptr(cros_ec_gpio_of_match),
+	},
+};
+module_platform_driver(cros_ec_gpio_driver);
+
+MODULE_DESCRIPTION("ChromeOS EC GPIO Driver");
+MODULE_LICENSE("GPL");
-- 
https://chromeos.dev


