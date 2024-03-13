Return-Path: <linux-kernel+bounces-101203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 622A487A3F3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8621C1C2174A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38F018629;
	Wed, 13 Mar 2024 08:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bhjD6ueD"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8B7171A6;
	Wed, 13 Mar 2024 08:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710317705; cv=none; b=YpdCRZ34Mc4B3eBhZG/09Ui9tneSsR4DkuPqgtoansEAIdkUfaw6ZAcEXKytdtYhpkPAJkBJHHmJhj6p73uvZt6TPkI8/dG4KcjHslqgBr7GBcpA3PWObv9PCw0lKou3Nyscs7Yya/0XeMM3qvC6KGrJQxig2rrP/3K6SXHNRL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710317705; c=relaxed/simple;
	bh=6ACgQRkjwLr3es9amra2hSZW1tM5eUceoFTu3/80IAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lhpNJEoIoj2QSdeV3HvJ4DwG4mbYCrea7P2kr+WCWjV9DdFI6NIb2UZs/pUt+yBFBZDFgvtiXI7vNDF9xy3BPs5JpxgKxLz8mKZ7VkvKuN69zTHQ3A//yaX21aPlPxIkkZ7f38+m5yXVNaxdleHq+oybZAcvjanjv/Prvlquh6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bhjD6ueD; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ySvk1
	10FebIcrpo64c8Fhrck02hJgRALePz85GlRAKs=; b=bhjD6ueDC+1w3kTfzm2qj
	yGT9EBgG2LVMhCXoWW/ANG2seQnhbBVTq33S/zxldjBtMp0w0I2q+cWcpBbXgscj
	MFkysT7C7eLCamaP0oghGDfFp4/Q9DNvrsz49Q1Km+45LW1Inn8NGikdgJw8i1OG
	htVXqlwRJ1mqZJvHJpf3H8=
Received: from localhost.localdomain (unknown [39.144.138.148])
	by gzga-smtp-mta-g1-4 (Coremail) with SMTP id _____wDHpTBkYPFl51aWBg--.60890S3;
	Wed, 13 Mar 2024 16:14:30 +0800 (CST)
From: Xing Tong Wu <xingtong_wu@163.com>
To: andy.shevchenko@gmail.com,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Xing Tong Wu <xingtong.wu@siemens.com>,
	Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Henning Schild <henning@hennsch.de>
Subject: [PATCH v3 1/1] leds: simatic-ipc-leds-gpio: add support for module BX-59A
Date: Wed, 13 Mar 2024 16:14:25 +0800
Message-Id: <20240313081425.2634-2-xingtong_wu@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240313081425.2634-1-xingtong_wu@163.com>
References: <20240313081425.2634-1-xingtong_wu@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHpTBkYPFl51aWBg--.60890S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr1kurWUJw15Xryrur4DArb_yoWrZr4kpF
	nxJa9YkFW3XF1Dtr13GFW7Zas3uw4xKr97trZrGa90g3Wjvr10gFnrAFW3XFZ5J3yDuFnx
	GF1rtFyj9r4kAwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwWrXUUUUU=
X-CM-SenderInfo: p0lqw35rqjs4rx6rljoofrz/xtbBEAqg0GVOCv++yAAAsC

From: Xing Tong Wu <xingtong.wu@siemens.com>

This is used for the Siemens Simatic IPC BX-59A, which has its LEDs
connected to GPIOs provided by the Nuvoton NCT6126D.

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
index c7c3a1f986e6..08d8e580b4f1 100644
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
+	const struct simatic_ipc_platform *plat = dev_get_platdata(&pdev->dev);
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
+	platform_set_drvdata(pdev, led_tables);
+	return simatic_ipc_leds_gpio_probe(pdev, led_tables->led_lookup_table,
+					   led_tables->led_lookup_table_extra);
 }
 
 static void simatic_ipc_leds_gpio_f7188x_remove(struct platform_device *pdev)
 {
-	simatic_ipc_leds_gpio_remove(pdev, &simatic_ipc_led_gpio_table,
-				     &simatic_ipc_led_gpio_table_extra);
+	struct simatic_ipc_led_tables *led_tables;
+
+	led_tables = platform_get_drvdata(pdev);
+	simatic_ipc_leds_gpio_remove(pdev, led_tables->led_lookup_table,
+				     led_tables->led_lookup_table_extra);
 }
 
 static struct platform_driver simatic_ipc_led_gpio_driver = {
-- 
2.25.1


