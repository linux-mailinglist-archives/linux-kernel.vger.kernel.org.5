Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43429804149
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbjLDWFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 17:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbjLDWFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:05:30 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EB0FF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 14:05:35 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAH4G-0003EN-JZ; Mon, 04 Dec 2023 23:05:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAH4G-00DbY0-0e; Mon, 04 Dec 2023 23:05:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAH4F-00EMX2-Nj; Mon, 04 Dec 2023 23:05:31 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 1/3] w1: gpio: Don't use platform data for driver data
Date:   Mon,  4 Dec 2023 23:05:21 +0100
Message-ID:  <8f7ebe03ddaa5a5c6e2b36fecdf59da7fc373527.1701727212.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701727212.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701727212.git.u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5383; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=AKyfJXZm9/5UE4F6cuV9Y1FnKF2AOE5dzxjtMA4AAnw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlbk0giTnUy1TC2koQvlwIjM1T+c3sZfvwKQ1u7 E5uex4YWWyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZW5NIAAKCRCPgPtYfRL+ TmCtB/9ZlAHAk4HQBIprhIRLWZRuhqP39AuxtCUHKLxPveQNUpAsWVwaa0NZH34R62CWYcmbdHb xXDLlF2Wfv5ygWBIkYmSgslamIa+5Ot2ZYbmD9lXfOUgD7BOPjG0ym/xG5evupUXuVqbjh5Kcw0 uXartNW+Nxstn6GSar5/op2D0tRaVEto1CvIFNimln53D8S2BRxI8O5H2FQIIHRWq7ZTlHwik9h RvwItkWH6nzKrjcGLOpvQmsauTXBeSM5fzLV688Y4niN/tD9m6gypcfj7YBT5D7cUG6MM29tzda HAkBIdl9JudotU9/g7riHqhnMGh1u4WRQak8qjJCRIN47wf4
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct device's .platform_data isn't for drivers to write to. For
driver-specific data there is .driver_data instead.

As there is no in-tree platform that provides w1_gpio_platform_data,
drop the include file and replace it by a local struct w1_gpio_ddata.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/w1/masters/w1-gpio.c | 56 +++++++++++++++++-------------------
 include/linux/w1-gpio.h      | 22 --------------
 2 files changed, 27 insertions(+), 51 deletions(-)
 delete mode 100644 include/linux/w1-gpio.h

diff --git a/drivers/w1/masters/w1-gpio.c b/drivers/w1/masters/w1-gpio.c
index e45acb6d916e..8d65db65178c 100644
--- a/drivers/w1/masters/w1-gpio.c
+++ b/drivers/w1/masters/w1-gpio.c
@@ -9,7 +9,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-#include <linux/w1-gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of_platform.h>
 #include <linux/err.h>
@@ -18,9 +17,16 @@
 
 #include <linux/w1.h>
 
+struct w1_gpio_ddata {
+	struct gpio_desc *gpiod;
+	struct gpio_desc *pullup_gpiod;
+	void (*enable_external_pullup)(int enable);
+	unsigned int pullup_duration;
+};
+
 static u8 w1_gpio_set_pullup(void *data, int delay)
 {
-	struct w1_gpio_platform_data *pdata = data;
+	struct w1_gpio_ddata *pdata = data;
 
 	if (delay) {
 		pdata->pullup_duration = delay;
@@ -46,14 +52,14 @@ static u8 w1_gpio_set_pullup(void *data, int delay)
 
 static void w1_gpio_write_bit(void *data, u8 bit)
 {
-	struct w1_gpio_platform_data *pdata = data;
+	struct w1_gpio_ddata *pdata = data;
 
 	gpiod_set_value(pdata->gpiod, bit);
 }
 
 static u8 w1_gpio_read_bit(void *data)
 {
-	struct w1_gpio_platform_data *pdata = data;
+	struct w1_gpio_ddata *pdata = data;
 
 	return gpiod_get_value(pdata->gpiod) ? 1 : 0;
 }
@@ -69,35 +75,25 @@ MODULE_DEVICE_TABLE(of, w1_gpio_dt_ids);
 static int w1_gpio_probe(struct platform_device *pdev)
 {
 	struct w1_bus_master *master;
-	struct w1_gpio_platform_data *pdata;
+	struct w1_gpio_ddata *pdata;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	/* Enforce open drain mode by default */
 	enum gpiod_flags gflags = GPIOD_OUT_LOW_OPEN_DRAIN;
 	int err;
 
-	if (of_have_populated_dt()) {
-		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
-		if (!pdata)
-			return -ENOMEM;
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
 
-		/*
-		 * This parameter means that something else than the gpiolib has
-		 * already set the line into open drain mode, so we should just
-		 * driver it high/low like we are in full control of the line and
-		 * open drain will happen transparently.
-		 */
-		if (of_property_present(np, "linux,open-drain"))
-			gflags = GPIOD_OUT_LOW;
-
-		pdev->dev.platform_data = pdata;
-	}
-	pdata = dev_get_platdata(dev);
-
-	if (!pdata) {
-		dev_err(dev, "No configuration data\n");
-		return -ENXIO;
-	}
+	/*
+	 * This parameter means that something else than the gpiolib has
+	 * already set the line into open drain mode, so we should just
+	 * driver it high/low like we are in full control of the line and
+	 * open drain will happen transparently.
+	 */
+	if (of_property_present(np, "linux,open-drain"))
+		gflags = GPIOD_OUT_LOW;
 
 	master = devm_kzalloc(dev, sizeof(struct w1_bus_master),
 			GFP_KERNEL);
@@ -152,7 +148,7 @@ static int w1_gpio_probe(struct platform_device *pdev)
 static int w1_gpio_remove(struct platform_device *pdev)
 {
 	struct w1_bus_master *master = platform_get_drvdata(pdev);
-	struct w1_gpio_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct w1_gpio_ddata *pdata = master->data;
 
 	if (pdata->enable_external_pullup)
 		pdata->enable_external_pullup(0);
@@ -167,7 +163,8 @@ static int w1_gpio_remove(struct platform_device *pdev)
 
 static int __maybe_unused w1_gpio_suspend(struct device *dev)
 {
-	struct w1_gpio_platform_data *pdata = dev_get_platdata(dev);
+	struct w1_bus_master *master = dev_get_drvdata(dev);
+	struct w1_gpio_ddata *pdata = master->data;
 
 	if (pdata->enable_external_pullup)
 		pdata->enable_external_pullup(0);
@@ -177,7 +174,8 @@ static int __maybe_unused w1_gpio_suspend(struct device *dev)
 
 static int __maybe_unused w1_gpio_resume(struct device *dev)
 {
-	struct w1_gpio_platform_data *pdata = dev_get_platdata(dev);
+	struct w1_bus_master *master = dev_get_drvdata(dev);
+	struct w1_gpio_ddata *pdata = master->data;
 
 	if (pdata->enable_external_pullup)
 		pdata->enable_external_pullup(1);
diff --git a/include/linux/w1-gpio.h b/include/linux/w1-gpio.h
deleted file mode 100644
index 3495fd0dc790..000000000000
--- a/include/linux/w1-gpio.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * w1-gpio interface to platform code
- *
- * Copyright (C) 2007 Ville Syrjala <syrjala@sci.fi>
- */
-#ifndef _LINUX_W1_GPIO_H
-#define _LINUX_W1_GPIO_H
-
-struct gpio_desc;
-
-/**
- * struct w1_gpio_platform_data - Platform-dependent data for w1-gpio
- */
-struct w1_gpio_platform_data {
-	struct gpio_desc *gpiod;
-	struct gpio_desc *pullup_gpiod;
-	void (*enable_external_pullup)(int enable);
-	unsigned int pullup_duration;
-};
-
-#endif /* _LINUX_W1_GPIO_H */
-- 
2.42.0

