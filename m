Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FECD768F0A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjGaHio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 03:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjGaHid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:38:33 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC8441A4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 00:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=QbnVs
        MkSAD3R0QYKdOtGNDxONWdkJlBwGzEf4SY7bg4=; b=C+x9SK7Hd0VLPkx6kuNQw
        MdD5/rU/bqHDaj4sFN8gwo1IUbMammFFhh4NnM0RoCEdmj9lbYRDGkcrieuQyGJ6
        zUTPWGhSZRrg0lZ65HuSExgzn8rS0iIHhapYN8tTsLrbRwmCltD0HMaf0EpfuAuR
        ktJllN1hO0NwuREXXjXf1U=
Received: from localhost.localdomain (unknown [39.144.138.187])
        by zwqz-smtp-mta-g4-3 (Coremail) with SMTP id _____wAHF+cOYcdkXWxVBw--.36239S2;
        Mon, 31 Jul 2023 15:21:51 +0800 (CST)
From:   xingtong_wu@163.com
To:     hdegoede@redhat.com, markgross@kernel.org,
        henning.schild@siemens.com, xingtong.wu@siemens.com,
        platform-driver-x86@vger.kernel.or, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] batt: simatic-ipc-batt: add support for module BX-59A
Date:   Mon, 31 Jul 2023 15:21:48 +0800
Message-Id: <20230731072148.4781-1-xingtong_wu@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230731071424.4663-1-xingtong_wu@163.com>
References: <20230731071424.4663-1-xingtong_wu@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAHF+cOYcdkXWxVBw--.36239S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtF1fAFy8GFy7AF1fJF4xWFg_yoW7GrW7pF
        n8JayFkFW5Ww4Yyr43G3y7urnxZa1IkrW7GFZrGw1ava4qvr10qa47AFWfXFsxJrW5Wa45
        JFsayFWUuF4DZrUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j-XocUUUUU=
X-Originating-IP: [39.144.138.187]
X-CM-SenderInfo: p0lqw35rqjs4rx6rljoofrz/xtbBEBG90GNfuZpm9QAAsg
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "xingtong.wu" <xingtong.wu@siemens.com>

This is used for the Siemens Simatic IPC BX-59A, which
can monitor the voltage of the CMOS battery with two bits
that indicate low or empty state

Signed-off-by: xingtong.wu <xingtong.wu@siemens.com>
---
 drivers/platform/x86/siemens/Kconfig          |  1 +
 .../x86/siemens/simatic-ipc-batt-f7188x.c     | 37 ++++++++++++++-----
 .../platform/x86/siemens/simatic-ipc-batt.c   |  3 +-
 3 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/siemens/Kconfig b/drivers/platform/x86/siemens/Kconfig
index 9c227a19432f..2ee36e33b03d 100644
--- a/drivers/platform/x86/siemens/Kconfig
+++ b/drivers/platform/x86/siemens/Kconfig
@@ -53,6 +53,7 @@ config SIEMENS_SIMATIC_IPC_BATT_ELKHARTLAKE
 config SIEMENS_SIMATIC_IPC_BATT_F7188X
 	tristate "CMOS Battery monitoring for Simatic IPCs based on Nuvoton GPIO"
 	depends on GPIO_F7188X
+	depends on PINCTRL_ALDERLAKE
 	depends on SIEMENS_SIMATIC_IPC_BATT
 	default SIEMENS_SIMATIC_IPC_BATT
 	help
diff --git a/drivers/platform/x86/siemens/simatic-ipc-batt-f7188x.c b/drivers/platform/x86/siemens/simatic-ipc-batt-f7188x.c
index ed330f6a8ea8..a66107e0fe1e 100644
--- a/drivers/platform/x86/siemens/simatic-ipc-batt-f7188x.c
+++ b/drivers/platform/x86/siemens/simatic-ipc-batt-f7188x.c
@@ -17,6 +17,8 @@
 
 #include "simatic-ipc-batt.h"
 
+static struct gpiod_lookup_table *batt_lookup_table;
+
 static struct gpiod_lookup_table simatic_ipc_batt_gpio_table_227g = {
 	.table = {
 		GPIO_LOOKUP_IDX("gpio-f7188x-7", 6, NULL, 0, GPIO_ACTIVE_HIGH),
@@ -34,24 +36,39 @@ static struct gpiod_lookup_table simatic_ipc_batt_gpio_table_bx_39a = {
 	},
 };
 
+static struct gpiod_lookup_table simatic_ipc_batt_gpio_table_bx_59a = {
+	.table = {
+		GPIO_LOOKUP_IDX("gpio-f7188x-7", 6, NULL, 0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("gpio-f7188x-7", 5, NULL, 1, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("INTC1056:00", 438, NULL, 2, GPIO_ACTIVE_HIGH),
+		{} /* Terminating entry */
+	}
+};
+
 static int simatic_ipc_batt_f7188x_remove(struct platform_device *pdev)
 {
-	const struct simatic_ipc_platform *plat = pdev->dev.platform_data;
-
-	if (plat->devmode == SIMATIC_IPC_DEVICE_227G)
-		return simatic_ipc_batt_remove(pdev, &simatic_ipc_batt_gpio_table_227g);
-
-	return simatic_ipc_batt_remove(pdev, &simatic_ipc_batt_gpio_table_bx_39a);
+	return simatic_ipc_batt_remove(pdev, batt_lookup_table);
 }
 
 static int simatic_ipc_batt_f7188x_probe(struct platform_device *pdev)
 {
 	const struct simatic_ipc_platform *plat = pdev->dev.platform_data;
 
-	if (plat->devmode == SIMATIC_IPC_DEVICE_227G)
-		return simatic_ipc_batt_probe(pdev, &simatic_ipc_batt_gpio_table_227g);
+	switch (plat->devmode) {
+	case SIMATIC_IPC_DEVICE_227G:
+		batt_lookup_table = &simatic_ipc_batt_gpio_table_227g;
+		break;
+	case SIMATIC_IPC_DEVICE_BX_39A:
+		batt_lookup_table = &simatic_ipc_batt_gpio_table_bx_39a;
+		break;
+	case SIMATIC_IPC_DEVICE_BX_59A:
+		batt_lookup_table = &simatic_ipc_batt_gpio_table_bx_59a;
+		break;
+	default:
+		return -ENODEV;
+	}
 
-	return simatic_ipc_batt_probe(pdev, &simatic_ipc_batt_gpio_table_bx_39a);
+	return simatic_ipc_batt_probe(pdev, batt_lookup_table);
 }
 
 static struct platform_driver simatic_ipc_batt_driver = {
@@ -66,5 +83,5 @@ module_platform_driver(simatic_ipc_batt_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" KBUILD_MODNAME);
-MODULE_SOFTDEP("pre: simatic-ipc-batt gpio_f7188x platform:elkhartlake-pinctrl");
+MODULE_SOFTDEP("pre: simatic-ipc-batt gpio_f7188x platform:elkhartlake-pinctrl platform:alderlake-pinctrl");
 MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
diff --git a/drivers/platform/x86/siemens/simatic-ipc-batt.c b/drivers/platform/x86/siemens/simatic-ipc-batt.c
index e34417ca9e13..d66b9969234b 100644
--- a/drivers/platform/x86/siemens/simatic-ipc-batt.c
+++ b/drivers/platform/x86/siemens/simatic-ipc-batt.c
@@ -169,6 +169,7 @@ int simatic_ipc_batt_probe(struct platform_device *pdev, struct gpiod_lookup_tab
 	case SIMATIC_IPC_DEVICE_227G:
 	case SIMATIC_IPC_DEVICE_BX_39A:
 	case SIMATIC_IPC_DEVICE_BX_21A:
+	case SIMATIC_IPC_DEVICE_BX_59A:
 		table->dev_id = dev_name(dev);
 		gpiod_add_lookup_table(table);
 		break;
@@ -193,7 +194,7 @@ int simatic_ipc_batt_probe(struct platform_device *pdev, struct gpiod_lookup_tab
 
 	if (table->table[2].key) {
 		flags = GPIOD_OUT_HIGH;
-		if (priv.devmode == SIMATIC_IPC_DEVICE_BX_21A)
+		if (priv.devmode == SIMATIC_IPC_DEVICE_BX_21A || SIMATIC_IPC_DEVICE_BX_59A)
 			flags = GPIOD_OUT_LOW;
 		priv.gpios[2] = devm_gpiod_get_index(dev, "CMOSBattery meter", 2, flags);
 		if (IS_ERR(priv.gpios[2])) {
-- 
2.25.1

