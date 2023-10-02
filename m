Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A405D7B4ABD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 04:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbjJBCRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 22:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbjJBCRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 22:17:30 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49D1D8
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 19:17:26 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2773b10bd05so2679150a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 19:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696213046; x=1696817846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lhRzM6KnB/PywI33Jm04a+skJPYEHXmin9uZYbICJM=;
        b=Tj1zTJh0GFFur/+0pIaCvomp+E4Qu8RTpWWBX69irEP4CEbb/1yoYqlu2nDxgABrAu
         gSyTv6pK+1kxvEyYbGiI9u4Rmn/0IeQK4eQjfcfsSWWqCSWaQ5dNUbvXId6K6ou36NZ4
         cCjmAJUO0iuT4ZOuI7SvT9mCYrMUd2SWAzMOBVg4vACl186nLdqKTiy2po/Rh3Y0yC1U
         Sukq/yppbbx8JW5R1kbXLzNtRszDB1IYagLB7m+m9PuvAwSrW8KV6nbyiF77QNXblcZ0
         JuhH63m9EMqX3rmC35163IoToGM8xSz4nOiX+jODVHYzxB+EGCy5dKcbbJsB6SyxnJjL
         lacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696213046; x=1696817846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lhRzM6KnB/PywI33Jm04a+skJPYEHXmin9uZYbICJM=;
        b=vExWviDiJUHk2F6dYImnS0/CFUfHEgpbrYE/nf+QYYJdSP9Oh+5W4JiVX6fdJEkPqH
         XO9Eqe2MtSamiH1i6J9xTk1Y7wxMb181JeBMH/TlNEIFlrtH99+WfMXoeJ2hAs451sL6
         KUojDe3Et3p0kwGtmfF++V1FhK2DPrV6XTyuz6wmRtD7TPoqtjxeZmkJQrv+hG0DhSWT
         AzJF0whIMjrnj64erUFUZuNQwge4PmGk+d0aBzJIgx1C4uwSrge11PuwL/a0fDesiVDn
         uWnZqWqjvAElezMJrixR4sieDRbb4jYdnU3ABTGcvzHMC6ANOQw+ZImDYgDcrDRpgTnI
         x0Tw==
X-Gm-Message-State: AOJu0YyQylpC2drAdr0GP/xvLSpaChuYNfshp5o3c2RLECmRsCn033Dh
        AbEedw4qqP56kVaCXR4/kRTgsKoWsYWzrZydCDJdfw==
X-Google-Smtp-Source: AGHT+IG3u8rwKFBxmfqf4kdkOvutNf56z/KpgPe2CDRNonX06xQsHrHs0e6xhBmsWB2SL+EDWAuH3g==
X-Received: by 2002:a17:90a:1383:b0:274:60c7:e15a with SMTP id i3-20020a17090a138300b0027460c7e15amr9153743pja.4.1696213046246;
        Sun, 01 Oct 2023 19:17:26 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:7ab1:199:d138:f054])
        by smtp.gmail.com with ESMTPSA id mg11-20020a17090b370b00b002609cadc56esm5278319pjb.11.2023.10.01.19.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 19:17:25 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     sudeep.holla@arm.com, cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org
Cc:     Oleksii_Moisieiev@epam.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC 3/4] gpio: scmi: add SCMI pinctrl based gpio driver
Date:   Mon,  2 Oct 2023 11:16:01 +0900
Message-Id: <20231002021602.260100-4-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002021602.260100-1-takahiro.akashi@linaro.org>
References: <20231002021602.260100-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCMI pin control protocol supports not only pin controllers, but also
gpio controllers by design. This patch includes a generic gpio driver
which allows consumer drivers to access gpio pins that are handled
through SCMI interfaces.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/gpio/Kconfig     |   8 ++
 drivers/gpio/Makefile    |   1 +
 drivers/gpio/gpio-scmi.c | 154 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 163 insertions(+)
 create mode 100644 drivers/gpio/gpio-scmi.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 673bafb8be58..1a968b950f3a 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -566,6 +566,14 @@ config GPIO_SAMA5D2_PIOBU
 	  The difference from regular GPIOs is that they
 	  maintain their value during backup/self-refresh.
 
+config GPIO_SCMI
+	tristate "GPIO support based on SCMI pinctrl"
+	depends on OF_GPIO
+	depends on PINCTRL_SCMI
+	help
+	  Select this option to support GPIO devices based on SCMI pin
+	  control protocol.
+
 config GPIO_SIFIVE
 	tristate "SiFive GPIO support"
 	depends on OF_GPIO
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index eb73b5d633eb..2abe1e9d5e77 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -141,6 +141,7 @@ obj-$(CONFIG_ARCH_SA1100)		+= gpio-sa1100.o
 obj-$(CONFIG_GPIO_SAMA5D2_PIOBU)	+= gpio-sama5d2-piobu.o
 obj-$(CONFIG_GPIO_SCH311X)		+= gpio-sch311x.o
 obj-$(CONFIG_GPIO_SCH)			+= gpio-sch.o
+obj-$(CONFIG_GPIO_SCMI)			+= gpio-scmi.o
 obj-$(CONFIG_GPIO_SIFIVE)		+= gpio-sifive.o
 obj-$(CONFIG_GPIO_SIM)			+= gpio-sim.o
 obj-$(CONFIG_GPIO_SIOX)			+= gpio-siox.o
diff --git a/drivers/gpio/gpio-scmi.c b/drivers/gpio/gpio-scmi.c
new file mode 100644
index 000000000000..ece63ea62b70
--- /dev/null
+++ b/drivers/gpio/gpio-scmi.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2023 Linaro Inc.
+//   Author: AKASHI takahiro <takahiro.akashi@linaro.org>
+
+#include <linux/gpio/driver.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+#include "gpiolib.h"
+
+struct scmi_gpio_priv {
+	struct gpio_chip chip;
+};
+
+static int scmi_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
+{
+	unsigned long config;
+
+	config = PIN_CONFIG_OUTPUT_ENABLE;
+	if (pinctrl_gpio_get_config(chip->gpiodev->base + offset, &config))
+		return -1;
+	if (config)
+		return GPIO_LINE_DIRECTION_OUT;
+
+	config = PIN_CONFIG_INPUT_ENABLE;
+	if (pinctrl_gpio_get_config(chip->gpiodev->base + offset, &config))
+		return -1;
+	if (config)
+		return GPIO_LINE_DIRECTION_IN;
+
+	return -1;
+}
+
+static int scmi_gpio_direction_input(struct gpio_chip *chip,
+				     unsigned int offset)
+{
+	return pinctrl_gpio_direction_input(chip->gpiodev->base + offset);
+}
+
+static int scmi_gpio_direction_output(struct gpio_chip *chip,
+				      unsigned int offset, int val)
+{
+	return pinctrl_gpio_direction_output(chip->gpiodev->base + offset);
+}
+
+static int scmi_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	unsigned long config;
+
+	/* FIXME: currently, PIN_CONFIG_INPUT not defined */
+	config = PIN_CONFIG_INPUT;
+	if (pinctrl_gpio_get_config(chip->gpiodev->base + offset, &config))
+		return -1;
+
+	/* FIXME: the packed format not defined */
+	if (config >> 8)
+		return 1;
+
+	return 0;
+}
+
+static void scmi_gpio_set(struct gpio_chip *chip, unsigned int offset, int val)
+{
+	unsigned long config;
+
+	config = PIN_CONF_PACKED(PIN_CONFIG_OUTPUT, val & 0x1);
+;
+	pinctrl_gpio_set_config(chip->gpiodev->base + offset, config);
+}
+
+static u16 sum_up_ngpios(struct gpio_chip *chip)
+{
+	struct gpio_pin_range *range;
+	struct gpio_device *gdev = chip->gpiodev;
+	u16 ngpios = 0;
+
+	list_for_each_entry(range, &gdev->pin_ranges, node) {
+		ngpios += range->range.npins;
+	}
+
+	return ngpios;
+}
+
+static int scmi_gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *parent_np;
+	struct scmi_gpio_priv *priv;
+	struct gpio_chip *chip;
+	int ret;
+
+	/* FIXME: who should be the parent */
+	parent_np = NULL;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	chip = &priv->chip;
+	chip->label = dev_name(dev);
+	chip->parent = dev;
+	chip->base = -1;
+
+	chip->request = gpiochip_generic_request;
+	chip->free = gpiochip_generic_free;
+	chip->get_direction = scmi_gpio_get_direction;
+	chip->direction_input = scmi_gpio_direction_input;
+	chip->direction_output = scmi_gpio_direction_output;
+	chip->get = scmi_gpio_get;
+	chip->set = scmi_gpio_set;
+
+	ret = devm_gpiochip_add_data(dev, chip, priv);
+	if (ret)
+		return ret;
+
+	chip->ngpio = sum_up_ngpios(chip);
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+}
+
+static int scmi_gpio_remove(struct platform_device *pdev)
+{
+	struct scmi_gpio_priv *priv = platform_get_drvdata(pdev);
+
+	gpiochip_remove(&priv->chip);
+
+	return 0;
+}
+
+static const struct of_device_id scmi_gpio_match[] = {
+	{ .compatible = "arm,scmi-gpio-generic" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, scmi_gpio_match);
+
+static struct platform_driver scmi_gpio_driver = {
+	.probe = scmi_gpio_probe,
+	.remove = scmi_gpio_remove,
+	.driver = {
+		.name = "scmi-gpio",
+		.of_match_table = scmi_gpio_match,
+	},
+};
+module_platform_driver(scmi_gpio_driver);
+
+MODULE_AUTHOR("AKASHI Takahiro <takahiro.akashi@linaro.org>");
+MODULE_DESCRIPTION("SCMI Pinctrl based GPIO driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

