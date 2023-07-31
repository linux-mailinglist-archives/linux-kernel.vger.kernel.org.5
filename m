Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E82E768FA8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjGaIIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjGaIID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:08:03 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B213C2111;
        Mon, 31 Jul 2023 01:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=OvDeU
        hri4hMYcdVAW/0ip7PXQ5yfuGa2bCViMpSRGnM=; b=eL+EBubr9NeQNaH0ugcfk
        z+Us5EfSb9fKASSSdkLMFHcIqyEeEfZtXLW05EhHfdTumWlq22Bw19M8DNiy6MG1
        fptlcSVmBDN2KefBqZ5dUCG204vVlJqbe1J/euke2IBEu0ejfUqaGm3Am3pa13iZ
        l9k9oORuJVwkOd5y1Y5hYM=
Received: from localhost.localdomain (unknown [39.144.138.187])
        by zwqz-smtp-mta-g3-3 (Coremail) with SMTP id _____wBXyzBNYMdkPmzZBg--.18258S2;
        Mon, 31 Jul 2023 15:18:38 +0800 (CST)
From:   xingtong_wu@163.com
To:     pavel@ucw.cz, lee@kernel.org, henning.schild@siemens.com,
        hdegoede@redhat.com, xingtong.wu@siemens.com,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] leds: simatic-ipc-leds-gpio: add support for module BX-59A
Date:   Mon, 31 Jul 2023 15:18:33 +0800
Message-Id: <20230731071833.4725-1-xingtong_wu@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230731071424.4663-1-xingtong_wu@163.com>
References: <20230731071424.4663-1-xingtong_wu@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBXyzBNYMdkPmzZBg--.18258S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr1kurWUJw15XF13XFykAFb_yoWrXFy5pF
        nrJ39YkFW5JF17tw13CFW7ZF93u3WxKr97tFZrGa90q3Wjvr10qF9rAFW3XFZ5J3ykuF17
        GF4rtFyUuF4DAwUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jHg4hUUUUU=
X-Originating-IP: [39.144.138.187]
X-CM-SenderInfo: p0lqw35rqjs4rx6rljoofrz/xtbCfhO90GDcO8jYDwAAsY
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "xingtong.wu" <xingtong.wu@siemens.com>

This is used for the Siemens Simatic IPC BX-59A, which has its LEDs
connected to GPIOs provided by the Nuvoton NCT6126D

Signed-off-by: xingtong.wu <xingtong.wu@siemens.com>
---
 .../leds/simple/simatic-ipc-leds-gpio-core.c  |  1 +
 .../simple/simatic-ipc-leds-gpio-f7188x.c     | 42 ++++++++++++++++---
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio-core.c b/drivers/leds/simple/simatic-ipc-leds-gpio-core.c
index c552ea73ed9d..10dca208d8cc 100644
--- a/drivers/leds/simple/simatic-ipc-leds-gpio-core.c
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio-core.c
@@ -58,6 +58,7 @@ int simatic_ipc_leds_gpio_probe(struct platform_device *pdev,
 	case SIMATIC_IPC_DEVICE_127E:
 	case SIMATIC_IPC_DEVICE_227G:
 	case SIMATIC_IPC_DEVICE_BX_21A:
+	case SIMATIC_IPC_DEVICE_BX_59A:
 		break;
 	default:
 		return -ENODEV;
diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c b/drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c
index 583a6b6c7c22..a5b544b20857 100644
--- a/drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c
@@ -17,7 +17,10 @@
 
 #include "simatic-ipc-leds-gpio.h"
 
-static struct gpiod_lookup_table simatic_ipc_led_gpio_table = {
+static struct gpiod_lookup_table *led_lookup_table;
+static struct gpiod_lookup_table *led_lookup_table_extra;
+
+static struct gpiod_lookup_table simatic_ipc_led_gpio_table_227g = {
 	.dev_id = "leds-gpio",
 	.table = {
 		GPIO_LOOKUP_IDX("gpio-f7188x-2", 0, NULL, 0, GPIO_ACTIVE_LOW),
@@ -30,7 +33,7 @@ static struct gpiod_lookup_table simatic_ipc_led_gpio_table = {
 	},
 };
 
-static struct gpiod_lookup_table simatic_ipc_led_gpio_table_extra = {
+static struct gpiod_lookup_table simatic_ipc_led_gpio_table_extra_227g = {
 	.dev_id = NULL, /* Filled during initialization */
 	.table = {
 		GPIO_LOOKUP_IDX("gpio-f7188x-3", 6, NULL, 6, GPIO_ACTIVE_HIGH),
@@ -39,16 +42,43 @@ static struct gpiod_lookup_table simatic_ipc_led_gpio_table_extra = {
 	},
 };
 
+static struct gpiod_lookup_table simatic_ipc_led_gpio_table_bx_59a = {
+	.dev_id = "leds-gpio",
+	.table = {
+		GPIO_LOOKUP_IDX("gpio-f7188x-2", 0, NULL, 0, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-f7188x-2", 3, NULL, 1, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-f7188x-5", 3, NULL, 2, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-f7188x-5", 2, NULL, 3, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-f7188x-7", 7, NULL, 4, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-f7188x-7", 4, NULL, 5, GPIO_ACTIVE_LOW),
+		{} /* Terminating entry */
+	}
+};
+
 static int simatic_ipc_leds_gpio_f7188x_probe(struct platform_device *pdev)
 {
-	return simatic_ipc_leds_gpio_probe(pdev, &simatic_ipc_led_gpio_table,
-					   &simatic_ipc_led_gpio_table_extra);
+	const struct simatic_ipc_platform *plat = pdev->dev.platform_data;
+
+	switch (plat->devmode) {
+	case SIMATIC_IPC_DEVICE_227G:
+		led_lookup_table = &simatic_ipc_led_gpio_table_227g;
+		led_lookup_table_extra = &simatic_ipc_led_gpio_table_extra_227g;
+		break;
+	case SIMATIC_IPC_DEVICE_BX_59A:
+		led_lookup_table = &simatic_ipc_led_gpio_table_bx_59a;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	return simatic_ipc_leds_gpio_probe(pdev, led_lookup_table,
+					   led_lookup_table_extra);
 }
 
 static int simatic_ipc_leds_gpio_f7188x_remove(struct platform_device *pdev)
 {
-	return simatic_ipc_leds_gpio_remove(pdev, &simatic_ipc_led_gpio_table,
-					    &simatic_ipc_led_gpio_table_extra);
+	return simatic_ipc_leds_gpio_remove(pdev, led_lookup_table,
+					    led_lookup_table_extra);
 }
 
 static struct platform_driver simatic_ipc_led_gpio_driver = {
-- 
2.25.1

