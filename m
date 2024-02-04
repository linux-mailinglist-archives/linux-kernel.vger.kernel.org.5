Return-Path: <linux-kernel+bounces-51526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 228F8848C30
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC281F22C0A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADD5171A4;
	Sun,  4 Feb 2024 08:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JaQRKEh9"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA71715AE0;
	Sun,  4 Feb 2024 08:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707035505; cv=none; b=KSUI0KAR8spBUseVr7jNHIkJGOMBCsIREc41iOnxnv8GhF81xyVPrulNjpKlTRcThNAIHv8OkBtoAJmJv3jKzxkUGbFqGdni41mBpkbqD98E+kO2qlCO+TY4R2F5GhwZmtaROWDb/qdpo37jhTUlfcdaRurSb7mCbcoN03N6IAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707035505; c=relaxed/simple;
	bh=zuZ16cXlvgwszlj4UY3oSjQsOuqVS9Gy8T9k3jLpus4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TCl551nN79dE9HGJhR2tik3t2NFYsoxZd84fcMa7T7YJ4FMw2JbCQ7HKNIFRFebLYtaOmjEbKdMVA39skGEun2c3MPUCBkK6NAxJXvu/qjus3Ij9aqnF39yyEkH1HFAwc40+QfGlAuTxuyPOLl+cUjyQmoIsrbSa3onC0mohOVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JaQRKEh9; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=14TOX
	UYYbIa7nuVrv7wPD6Hm67H8jXpzC51fRcD2YDI=; b=JaQRKEh9BwNt7ESr+7YWP
	16ewiOYq3OUnVLx+mE5ZgxGytIvGcvSaGohW+d0v75n7TKDyiKA5G5LQpC+XJFw/
	MsuZJOyr9WMrAfJ/10S+WuSq++Lj0xnyG1AWoCIq5/S8FqZ/5Frc7cm5Gaq8W3aN
	CYUGg3yjryAqEXnzGKHplc=
Received: from localhost.localdomain (unknown [39.144.137.116])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wDnM2Y+S79lBerCAg--.45702S3;
	Sun, 04 Feb 2024 16:30:58 +0800 (CST)
From: Xing Tong Wu <xingtong_wu@163.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Xing Tong Wu <xingtong.wu@siemens.com>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
	Henning Schild <henning@hennsch.de>
Subject: [PATCH RESEND 1/1] leds: simatic-ipc-leds-gpio: add support for module BX-59A
Date: Sun,  4 Feb 2024 16:30:48 +0800
Message-Id: <20240204083048.2458-2-xingtong_wu@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240204083048.2458-1-xingtong_wu@163.com>
References: <20240204083048.2458-1-xingtong_wu@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnM2Y+S79lBerCAg--.45702S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr1kurWUJw15Xry7JFy7Jrb_yoWrXF1fpF
	nrJ39YkFW5J3Zrtw13CFW7ZF93u3WxKr97tFZrGa90g3Wjvr10qF9rAFW3XFZ5J3ykuF17
	GF1rtFyUur4DAwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jqxRfUUUUU=
X-CM-SenderInfo: p0lqw35rqjs4rx6rljoofrz/xtbBEAd60GVOCGzapQAAsN

From: Xing Tong Wu <xingtong.wu@siemens.com>

This is used for the Siemens Simatic IPC BX-59A, which has its LEDs
connected to GPIOs provided by the Nuvoton NCT6126D

Signed-off-by: Xing Tong Wu <xingtong.wu@siemens.com>
---
 .../leds/simple/simatic-ipc-leds-gpio-core.c  |  1 +
 .../simple/simatic-ipc-leds-gpio-f7188x.c     | 42 ++++++++++++++++---
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio-core.c b/drivers/leds/simple/simatic-ipc-leds-gpio-core.c
index 667ba1bc3a30..85003fd7f1aa 100644
--- a/drivers/leds/simple/simatic-ipc-leds-gpio-core.c
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio-core.c
@@ -56,6 +56,7 @@ int simatic_ipc_leds_gpio_probe(struct platform_device *pdev,
 	case SIMATIC_IPC_DEVICE_127E:
 	case SIMATIC_IPC_DEVICE_227G:
 	case SIMATIC_IPC_DEVICE_BX_21A:
+	case SIMATIC_IPC_DEVICE_BX_59A:
 		break;
 	default:
 		return -ENODEV;
diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c b/drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c
index c7c3a1f986e6..783e74e9a805 100644
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
 
 static void simatic_ipc_leds_gpio_f7188x_remove(struct platform_device *pdev)
 {
-	simatic_ipc_leds_gpio_remove(pdev, &simatic_ipc_led_gpio_table,
-				     &simatic_ipc_led_gpio_table_extra);
+	simatic_ipc_leds_gpio_remove(pdev, led_lookup_table,
+				     led_lookup_table_extra);
 }
 
 static struct platform_driver simatic_ipc_led_gpio_driver = {
-- 
2.25.1


