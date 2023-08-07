Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A9B771B8C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 09:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjHGHbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 03:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjHGHbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 03:31:14 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B7B10FA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 00:31:10 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe21e7f3d1so6807879e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 00:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691393469; x=1691998269;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hw9cMV3Kp/ZQd5zUWqpeFfkYYVasJe+O5vg4nUlz7nE=;
        b=jwK+16J8Q8V8bqepppJc/Idq9XXoDLWtfhbOQMM+gkRHEUwyahRjUSKUx7Wq7hiYZw
         tJIcGjQMoezfbTaQV+3C2zMrF1/cvYGnB1QCxMPR669UYJ2P9/qOKEBReL8K32xFbOAJ
         Ia/JTQR8GOdeJuYZN/DnOwgi+99eXsKnDnbGYUgUsfkbbzUc4AP3t2TZ9KRB1lobHvIz
         9aFZHL3HMwCtazfxggdSKdE4Fn2i4aXjxkqfAMTb2xYDf/HVltX421v73GTa8sUeK8iK
         NQ02Tz2JX0cc9IqQ+FlIgFMZilpFM954w9oSI2j/AwgEu4o1zKd49sSZcFpSVDEi1fL6
         qzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691393469; x=1691998269;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hw9cMV3Kp/ZQd5zUWqpeFfkYYVasJe+O5vg4nUlz7nE=;
        b=GydeIiE41rfnBzcheXRu2QrCOBfK9iv9T8db640Mu8Zgv562iP/PhH7jJEcV6N7fvg
         Dma5N7iIhJxe0VY/GmOy61dAfAEENBzMUV7cY8sBfMoLru4kT2hq2AR2J47wMQdJC4ik
         e15bNRII9C1y8SY7JfP0apCo9Jy7UMAMYSfsDw9dunNPe+nhBIb32ma1KusTxHilEvmj
         BmqxQ75ZMM6QmxgSHmyGErN4+O0ZfnVK7PRyvqetsM91f9psVSsY4YTES/ood17W6hUH
         Dm61hU752d2evxsdfg4mCwCj7XaCO8v2VlVc9sOQVKmRr1AUBdghVFxYCDQclX/N0D4Q
         q3GQ==
X-Gm-Message-State: AOJu0YyNPR3uJQ5Kl8XQIObT0MRlBau3HL/MAagPTugwyli5PS28jmH7
        /pIyunxGrmVHk1KepBoByiDYbUoQblEYQKKFMcQ=
X-Google-Smtp-Source: AGHT+IFZEoWJ0ZP24pGtLvHJSuFnJWgKhTHVGvkVQuymhW6QkL12s7YWP9Y1QUl+QcnMa3bism37NQ==
X-Received: by 2002:a2e:8e95:0:b0:2b9:43a7:376e with SMTP id z21-20020a2e8e95000000b002b943a7376emr6064388ljk.29.1691393468750;
        Mon, 07 Aug 2023 00:31:08 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id p3-20020a2ea403000000b002b9db7df0dasm1710809ljn.8.2023.08.07.00.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 00:31:08 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 07 Aug 2023 09:31:06 +0200
Subject: [PATCH] rtc: ds2404: Convert to GPIO descriptors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-descriptors-rtc-v1-1-ce0f9187576e@linaro.org>
X-B4-Tracking: v=1; b=H4sIALmd0GQC/x3MQQqAIBBA0avErBNMEaOrRAvTsWZTMRMRiHdPW
 r7F/wUEmVBg6gowPiR0Hg1D30Hcw7GhotQMRhurR+1VQolM132yKL6j8j4561xefXDQqosx0/s
 f56XWD/FuI2xhAAAA
To:     Sven Schnelle <svens@stackframe.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the DS2404 to use GPIO descriptors instead of
hard-coded global GPIO numbers.

The platform data can be deleted because there are no in-tree
users and it only contained GPIO numbers which are now
passed using descriptor tables (or device tree or ACPI).

The driver was rewritten to use a state container for the
device driver state (struct ds2404 *chip) and pass that
around instead of using a global singleton storage for the
GPIO handles.

When declaring GPIO descriptor tables or other hardware
descriptions for the RTC driver, implementers should take care
to flag the RESET line as active low, such as by using the
GPIOD_ACTIVE_LOW flag in the descriptor table.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/rtc/rtc-ds2404.c                 | 169 +++++++++++++------------------
 include/linux/platform_data/rtc-ds2404.h |  20 ----
 2 files changed, 69 insertions(+), 120 deletions(-)

diff --git a/drivers/rtc/rtc-ds2404.c b/drivers/rtc/rtc-ds2404.c
index 0480f592307e..3231fd9f61da 100644
--- a/drivers/rtc/rtc-ds2404.c
+++ b/drivers/rtc/rtc-ds2404.c
@@ -7,9 +7,8 @@
 #include <linux/rtc.h>
 #include <linux/types.h>
 #include <linux/bcd.h>
-#include <linux/platform_data/rtc-ds2404.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/slab.h>
 
 #include <linux/io.h>
@@ -27,164 +26,140 @@
 #define DS2404_CLK	1
 #define DS2404_DQ	2
 
-struct ds2404_gpio {
-	const char *name;
-	unsigned int gpio;
-};
-
 struct ds2404 {
-	struct ds2404_gpio *gpio;
+	struct device *dev;
+	struct gpio_desc *rst_gpiod;
+	struct gpio_desc *clk_gpiod;
+	struct gpio_desc *dq_gpiod;
 	struct rtc_device *rtc;
 };
 
-static struct ds2404_gpio ds2404_gpio[] = {
-	{ "RTC RST", 0 },
-	{ "RTC CLK", 0 },
-	{ "RTC DQ", 0 },
-};
-
-static int ds2404_gpio_map(struct ds2404 *chip, struct platform_device *pdev,
-			  struct ds2404_platform_data *pdata)
+static int ds2404_gpio_map(struct ds2404 *chip, struct platform_device *pdev)
 {
-	int i, err;
-
-	ds2404_gpio[DS2404_RST].gpio = pdata->gpio_rst;
-	ds2404_gpio[DS2404_CLK].gpio = pdata->gpio_clk;
-	ds2404_gpio[DS2404_DQ].gpio = pdata->gpio_dq;
-
-	for (i = 0; i < ARRAY_SIZE(ds2404_gpio); i++) {
-		err = gpio_request(ds2404_gpio[i].gpio, ds2404_gpio[i].name);
-		if (err) {
-			dev_err(&pdev->dev, "error mapping gpio %s: %d\n",
-				ds2404_gpio[i].name, err);
-			goto err_request;
-		}
-		if (i != DS2404_DQ)
-			gpio_direction_output(ds2404_gpio[i].gpio, 1);
-	}
+	struct device *dev = &pdev->dev;
 
-	chip->gpio = ds2404_gpio;
-	return 0;
+	/* This will de-assert RESET, declare this GPIO as GPIOD_ACTIVE_LOW */
+	chip->rst_gpiod = devm_gpiod_get(dev, "rst", GPIOD_OUT_LOW);
+	if (IS_ERR(chip->rst_gpiod))
+		return PTR_ERR(chip->rst_gpiod);
 
-err_request:
-	while (--i >= 0)
-		gpio_free(ds2404_gpio[i].gpio);
-	return err;
-}
+	chip->clk_gpiod = devm_gpiod_get(dev, "clk", GPIOD_OUT_HIGH);
+	if (IS_ERR(chip->clk_gpiod))
+		return PTR_ERR(chip->clk_gpiod);
 
-static void ds2404_gpio_unmap(void *data)
-{
-	int i;
+	chip->dq_gpiod = devm_gpiod_get(dev, "dq", GPIOD_ASIS);
+	if (IS_ERR(chip->dq_gpiod))
+		return PTR_ERR(chip->dq_gpiod);
 
-	for (i = 0; i < ARRAY_SIZE(ds2404_gpio); i++)
-		gpio_free(ds2404_gpio[i].gpio);
+	return 0;
 }
 
-static void ds2404_reset(struct device *dev)
+static void ds2404_reset(struct ds2404 *chip)
 {
-	gpio_set_value(ds2404_gpio[DS2404_RST].gpio, 0);
+	gpiod_set_value(chip->rst_gpiod, 1);
 	udelay(1000);
-	gpio_set_value(ds2404_gpio[DS2404_RST].gpio, 1);
-	gpio_set_value(ds2404_gpio[DS2404_CLK].gpio, 0);
-	gpio_direction_output(ds2404_gpio[DS2404_DQ].gpio, 0);
+	gpiod_set_value(chip->rst_gpiod, 0);
+	gpiod_set_value(chip->clk_gpiod, 0);
+	gpiod_direction_output(chip->dq_gpiod, 0);
 	udelay(10);
 }
 
-static void ds2404_write_byte(struct device *dev, u8 byte)
+static void ds2404_write_byte(struct ds2404 *chip, u8 byte)
 {
 	int i;
 
-	gpio_direction_output(ds2404_gpio[DS2404_DQ].gpio, 1);
+	gpiod_direction_output(chip->dq_gpiod, 1);
 	for (i = 0; i < 8; i++) {
-		gpio_set_value(ds2404_gpio[DS2404_DQ].gpio, byte & (1 << i));
+		gpiod_set_value(chip->dq_gpiod, byte & (1 << i));
 		udelay(10);
-		gpio_set_value(ds2404_gpio[DS2404_CLK].gpio, 1);
+		gpiod_set_value(chip->clk_gpiod, 1);
 		udelay(10);
-		gpio_set_value(ds2404_gpio[DS2404_CLK].gpio, 0);
+		gpiod_set_value(chip->clk_gpiod, 0);
 		udelay(10);
 	}
 }
 
-static u8 ds2404_read_byte(struct device *dev)
+static u8 ds2404_read_byte(struct ds2404 *chip)
 {
 	int i;
 	u8 ret = 0;
 
-	gpio_direction_input(ds2404_gpio[DS2404_DQ].gpio);
+	gpiod_direction_input(chip->dq_gpiod);
 
 	for (i = 0; i < 8; i++) {
-		gpio_set_value(ds2404_gpio[DS2404_CLK].gpio, 0);
+		gpiod_set_value(chip->clk_gpiod, 0);
 		udelay(10);
-		if (gpio_get_value(ds2404_gpio[DS2404_DQ].gpio))
+		if (gpiod_get_value(chip->dq_gpiod))
 			ret |= 1 << i;
-		gpio_set_value(ds2404_gpio[DS2404_CLK].gpio, 1);
+		gpiod_set_value(chip->clk_gpiod, 1);
 		udelay(10);
 	}
 	return ret;
 }
 
-static void ds2404_read_memory(struct device *dev, u16 offset,
+static void ds2404_read_memory(struct ds2404 *chip, u16 offset,
 			       int length, u8 *out)
 {
-	ds2404_reset(dev);
-	ds2404_write_byte(dev, DS2404_READ_MEMORY_CMD);
-	ds2404_write_byte(dev, offset & 0xff);
-	ds2404_write_byte(dev, (offset >> 8) & 0xff);
+	ds2404_reset(chip);
+	ds2404_write_byte(chip, DS2404_READ_MEMORY_CMD);
+	ds2404_write_byte(chip, offset & 0xff);
+	ds2404_write_byte(chip, (offset >> 8) & 0xff);
 	while (length--)
-		*out++ = ds2404_read_byte(dev);
+		*out++ = ds2404_read_byte(chip);
 }
 
-static void ds2404_write_memory(struct device *dev, u16 offset,
+static void ds2404_write_memory(struct ds2404 *chip, u16 offset,
 				int length, u8 *out)
 {
 	int i;
 	u8 ta01, ta02, es;
 
-	ds2404_reset(dev);
-	ds2404_write_byte(dev, DS2404_WRITE_SCRATCHPAD_CMD);
-	ds2404_write_byte(dev, offset & 0xff);
-	ds2404_write_byte(dev, (offset >> 8) & 0xff);
+	ds2404_reset(chip);
+	ds2404_write_byte(chip, DS2404_WRITE_SCRATCHPAD_CMD);
+	ds2404_write_byte(chip, offset & 0xff);
+	ds2404_write_byte(chip, (offset >> 8) & 0xff);
 
 	for (i = 0; i < length; i++)
-		ds2404_write_byte(dev, out[i]);
+		ds2404_write_byte(chip, out[i]);
 
-	ds2404_reset(dev);
-	ds2404_write_byte(dev, DS2404_READ_SCRATCHPAD_CMD);
+	ds2404_reset(chip);
+	ds2404_write_byte(chip, DS2404_READ_SCRATCHPAD_CMD);
 
-	ta01 = ds2404_read_byte(dev);
-	ta02 = ds2404_read_byte(dev);
-	es = ds2404_read_byte(dev);
+	ta01 = ds2404_read_byte(chip);
+	ta02 = ds2404_read_byte(chip);
+	es = ds2404_read_byte(chip);
 
 	for (i = 0; i < length; i++) {
-		if (out[i] != ds2404_read_byte(dev)) {
-			dev_err(dev, "read invalid data\n");
+		if (out[i] != ds2404_read_byte(chip)) {
+			dev_err(chip->dev, "read invalid data\n");
 			return;
 		}
 	}
 
-	ds2404_reset(dev);
-	ds2404_write_byte(dev, DS2404_COPY_SCRATCHPAD_CMD);
-	ds2404_write_byte(dev, ta01);
-	ds2404_write_byte(dev, ta02);
-	ds2404_write_byte(dev, es);
+	ds2404_reset(chip);
+	ds2404_write_byte(chip, DS2404_COPY_SCRATCHPAD_CMD);
+	ds2404_write_byte(chip, ta01);
+	ds2404_write_byte(chip, ta02);
+	ds2404_write_byte(chip, es);
 
-	gpio_direction_input(ds2404_gpio[DS2404_DQ].gpio);
-	while (gpio_get_value(ds2404_gpio[DS2404_DQ].gpio))
+	while (gpiod_get_value(chip->dq_gpiod))
 		;
 }
 
-static void ds2404_enable_osc(struct device *dev)
+static void ds2404_enable_osc(struct ds2404 *chip)
 {
 	u8 in[1] = { 0x10 }; /* enable oscillator */
-	ds2404_write_memory(dev, 0x201, 1, in);
+
+	ds2404_write_memory(chip, 0x201, 1, in);
 }
 
 static int ds2404_read_time(struct device *dev, struct rtc_time *dt)
 {
+	struct ds2404 *chip = dev_get_drvdata(dev);
 	unsigned long time = 0;
 	__le32 hw_time = 0;
 
-	ds2404_read_memory(dev, 0x203, 4, (u8 *)&hw_time);
+	ds2404_read_memory(chip, 0x203, 4, (u8 *)&hw_time);
 	time = le32_to_cpu(hw_time);
 
 	rtc_time64_to_tm(time, dt);
@@ -193,8 +168,9 @@ static int ds2404_read_time(struct device *dev, struct rtc_time *dt)
 
 static int ds2404_set_time(struct device *dev, struct rtc_time *dt)
 {
+	struct ds2404 *chip = dev_get_drvdata(dev);
 	u32 time = cpu_to_le32(rtc_tm_to_time64(dt));
-	ds2404_write_memory(dev, 0x203, 4, (u8 *)&time);
+	ds2404_write_memory(chip, 0x203, 4, (u8 *)&time);
 	return 0;
 }
 
@@ -205,7 +181,6 @@ static const struct rtc_class_ops ds2404_rtc_ops = {
 
 static int rtc_probe(struct platform_device *pdev)
 {
-	struct ds2404_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct ds2404 *chip;
 	int retval = -EBUSY;
 
@@ -213,22 +188,16 @@ static int rtc_probe(struct platform_device *pdev)
 	if (!chip)
 		return -ENOMEM;
 
+	chip->dev = &pdev->dev;
+
 	chip->rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(chip->rtc))
 		return PTR_ERR(chip->rtc);
 
-	retval = ds2404_gpio_map(chip, pdev, pdata);
+	retval = ds2404_gpio_map(chip, pdev);
 	if (retval)
 		return retval;
 
-	retval = devm_add_action_or_reset(&pdev->dev, ds2404_gpio_unmap, chip);
-	if (retval)
-		return retval;
-
-	dev_info(&pdev->dev, "using GPIOs RST:%d, CLK:%d, DQ:%d\n",
-		 chip->gpio[DS2404_RST].gpio, chip->gpio[DS2404_CLK].gpio,
-		 chip->gpio[DS2404_DQ].gpio);
-
 	platform_set_drvdata(pdev, chip);
 
 	chip->rtc->ops = &ds2404_rtc_ops;
@@ -238,7 +207,7 @@ static int rtc_probe(struct platform_device *pdev)
 	if (retval)
 		return retval;
 
-	ds2404_enable_osc(&pdev->dev);
+	ds2404_enable_osc(chip);
 	return 0;
 }
 
diff --git a/include/linux/platform_data/rtc-ds2404.h b/include/linux/platform_data/rtc-ds2404.h
deleted file mode 100644
index 22c53825528f..000000000000
--- a/include/linux/platform_data/rtc-ds2404.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * ds2404.h - platform data structure for the DS2404 RTC.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2012 Sven Schnelle <svens@stackframe.org>
- */
-
-#ifndef __LINUX_DS2404_H
-#define __LINUX_DS2404_H
-
-struct ds2404_platform_data {
-
-	unsigned int gpio_rst;
-	unsigned int gpio_clk;
-	unsigned int gpio_dq;
-};
-#endif

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230807-descriptors-rtc-77d5355fb7a5

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

