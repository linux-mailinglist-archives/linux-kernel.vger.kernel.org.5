Return-Path: <linux-kernel+bounces-70222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A31E5859500
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21DC3B224F8
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 06:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DD06AA1;
	Sun, 18 Feb 2024 06:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ASlvnVdl"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AE75394;
	Sun, 18 Feb 2024 06:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708237751; cv=none; b=AInXRKrwc8E7hR1F2XYtgweiUlGAxDS81ll4Q/T0V/Lu+hEPDou2sDhSTbk7l5VdAtMGB1Y3B1pcuqlTcbZCVE/WJvhANpzMioqUQLuaSHZ3S5DMrN7U05N6ew/3Mh3YoLoZj3b9mikZj7BrBZWhWt1tV6jubBQotjVqr1RZUhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708237751; c=relaxed/simple;
	bh=RFrTruxCePpCvvUZ9JG4MkT85f7C9D0dY59j2MbiQ3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LqS5ej56ZlJDse8xRz+HS2LbudVqk2MfYY53v06PNeFCXW1r6afbinn4FFlWRgvyg6W5hRQ3593+jc6RSaKhR2jBQctQHMyigvPiSiw8RN9Pd8Y/I27Gyta2G+C7ebThJT5i4Mhsy2EFgxuyk0+5GFv6OUMH/VqnQcJ8qT6UMng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ASlvnVdl; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=649G+
	c2moUST3OyqTYL+YtM4w/uIcFil9PTAbL3lI2s=; b=ASlvnVdlWCbBWDsr44RhW
	OLhDzL8kXxTPD3XsxOZUVNLE7QYTgdiRxuGY/kNlLzCXyb36WrOgbvBCspRviDdE
	jK8a07B+0uJx+U+tMVO8VinC3W7dXqIJ9Ja2Ze5h6Eu9VssMI+7lFhxxZ9+XGkJ9
	gxTewDgNiz0gTsLLlYXMI4=
Received: from localhost.localdomain (unknown [39.144.138.207])
	by gzga-smtp-mta-g1-4 (Coremail) with SMTP id _____wD3X1V3o9FlTGBpCw--.34987S3;
	Sun, 18 Feb 2024 14:28:12 +0800 (CST)
From: Xing Tong Wu <xingtong_wu@163.com>
To: lee@kernel.org
Cc: Pavel Machek <pavel@ucw.cz>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
	Xing Tong Wu <xingtong.wu@siemens.com>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Henning Schild <henning@hennsch.de>
Subject: [RESEND PATCH v2 1/1] leds: simatic-ipc-leds-gpio: add support for module BX-59A
Date: Sun, 18 Feb 2024 14:28:06 +0800
Message-Id: <20240218062806.3932-2-xingtong_wu@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240218062806.3932-1-xingtong_wu@163.com>
References: <20240208120901.GL689448@google.com>
 <20240218062806.3932-1-xingtong_wu@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X1V3o9FlTGBpCw--.34987S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr1kurWUJw15Xryrur4DArb_yoWrZr4xpF
	nxJa9YkFW5Xr1Dtr13GFW7Zas3uw4xKr97trZrGa90g3Wjvr10gFnrAFW3XFZ5J3yDuFnx
	GF1rtFyj9r4kAwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7fHUUUUUU=
X-CM-SenderInfo: p0lqw35rqjs4rx6rljoofrz/xtbB0h2I0GWXwEKJ6gAAsE

From: Xing Tong Wu <xingtong.wu@siemens.com>

This is used for the Siemens Simatic IPC BX-59A, which has its LEDs
connected to GPIOs provided by the Nuvoton NCT6126D

Signed-off-by: Xing Tong Wu <xingtong.wu@siemens.com>
---
 .../leds/simple/simatic-ipc-leds-gpio-core.c  |  1 +
 .../simple/simatic-ipc-leds-gpio-f7188x.c     | 53 ++++++++++++++++---
 2 files changed, 48 insertions(+), 6 deletions(-)

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
index c7c3a1f986e6..2d6910328769 100644
--- a/drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c
@@ -17,7 +17,12 @@
 
 #include "simatic-ipc-leds-gpio.h"
 
-static struct gpiod_lookup_table simatic_ipc_led_gpio_table = {
+struct simatic_ipc_led_tables {
+	struct gpiod_lookup_table *led_lookup_table;
+	struct gpiod_lookup_table *led_lookup_table_extra;
+};
+
+static struct gpiod_lookup_table simatic_ipc_led_gpio_table_227g = {
 	.dev_id = "leds-gpio",
 	.table = {
 		GPIO_LOOKUP_IDX("gpio-f7188x-2", 0, NULL, 0, GPIO_ACTIVE_LOW),
@@ -30,7 +35,7 @@ static struct gpiod_lookup_table simatic_ipc_led_gpio_table = {
 	},
 };
 
-static struct gpiod_lookup_table simatic_ipc_led_gpio_table_extra = {
+static struct gpiod_lookup_table simatic_ipc_led_gpio_table_extra_227g = {
 	.dev_id = NULL, /* Filled during initialization */
 	.table = {
 		GPIO_LOOKUP_IDX("gpio-f7188x-3", 6, NULL, 6, GPIO_ACTIVE_HIGH),
@@ -39,16 +44,52 @@ static struct gpiod_lookup_table simatic_ipc_led_gpio_table_extra = {
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
+	struct simatic_ipc_led_tables *led_tables;
+
+	led_tables = devm_kzalloc(&pdev->dev, sizeof(*led_tables), GFP_KERNEL);
+	if (!led_tables)
+		return -ENOMEM;
+
+	switch (plat->devmode) {
+	case SIMATIC_IPC_DEVICE_227G:
+		led_tables->led_lookup_table = &simatic_ipc_led_gpio_table_227g;
+		led_tables->led_lookup_table_extra = &simatic_ipc_led_gpio_table_extra_227g;
+		break;
+	case SIMATIC_IPC_DEVICE_BX_59A:
+		led_tables->led_lookup_table = &simatic_ipc_led_gpio_table_bx_59a;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	dev_set_drvdata(&pdev->dev, led_tables);
+	return simatic_ipc_leds_gpio_probe(pdev, led_tables->led_lookup_table,
+					   led_tables->led_lookup_table_extra);
 }
 
 static void simatic_ipc_leds_gpio_f7188x_remove(struct platform_device *pdev)
 {
-	simatic_ipc_leds_gpio_remove(pdev, &simatic_ipc_led_gpio_table,
-				     &simatic_ipc_led_gpio_table_extra);
+	struct simatic_ipc_led_tables *led_tables;
+
+	led_tables = dev_get_drvdata(&pdev->dev);
+	simatic_ipc_leds_gpio_remove(pdev, led_tables->led_lookup_table,
+				     led_tables->led_lookup_table_extra);
 }
 
 static struct platform_driver simatic_ipc_led_gpio_driver = {
-- 
2.25.1


