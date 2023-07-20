Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717CA75B0F7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 16:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjGTOOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 10:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjGTOOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:14:31 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739DC2686;
        Thu, 20 Jul 2023 07:14:26 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-cfcebc33d04so748442276.2;
        Thu, 20 Jul 2023 07:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689862465; x=1690467265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Z+6ZA3+zW2x/yG4Zxjlc9UzudCwrZGMn9TeL09tqn4=;
        b=om+ItY/6ZVzt+Timon50dblX3VqF9g43SkFSIjVB0vbqeDtABwGs0mgcsS1mmIMJ/c
         n7m++QCJVy2FR/3nHclD8ADdpt0C4jB7N1MACTF1hKKungfzkXmwtdt5wml9j/29FElM
         xu7TeiIMhJGW/ZSyGIK/ohVYsmGfEtDIZJBtEt6ugemX/+ko6/RyBrgJe2nn6QZwlqXh
         K8o4eAr5jOqnoiJhwklTSXYcy6cLsjoykYIejzg411/0VGPNBwDXJkPOwIFfljoHG1mg
         a9mY0v5Pqwt5YFdIzy+IxgyqO3ev7NmxpS26sVUe6ox3as2PBRFc9PEo7P7k5S6s36jb
         JVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689862465; x=1690467265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Z+6ZA3+zW2x/yG4Zxjlc9UzudCwrZGMn9TeL09tqn4=;
        b=JAitwEg0nNRHjPktZAWlh9dBxFUcM+2DMPHldhRXj/MgsACsg9fVNCXE8NdYLTPsMo
         20jS/W+JBYb49altdTR+QG8VB4MM/OZFNXQdM9V52dZ/UOEvyVeIMVybG1+lfIXX1cSa
         oK/xoY/jGVBvPZ6Wz5gjF4KoL9+BycVoMrGWbVT6QYpXLSZjDb9D53Bm6Ind288vlEQ9
         ck+MNtGfQtpEa7XkAOI6GU5HD6v4C9buZdpMJJQBZBfjldn1VoBQoMaJNmoM3lShr75m
         e2o7VuZgQo5d9ZPQaMeoRZ5MzYqd7fyaZm+QzKVBv7Jkacc99UX/NF5TdNeFGAWtYN7H
         VuEA==
X-Gm-Message-State: ABy/qLZctqReH6VrClwPETIQiNT6HsMsTs4Ym1uTpIJnmn2zta19NXDs
        bR3Btis3qfDr2fCz8XV9HPI=
X-Google-Smtp-Source: APBJJlEErtXcd9P4kGpnmsDkOD9fvAus333hyUySJgHFNxRkZWhyPtDIk94mhdqVyWLRzE6u4QGShA==
X-Received: by 2002:a81:a197:0:b0:576:916d:96b with SMTP id y145-20020a81a197000000b00576916d096bmr5865169ywg.36.1689862465495;
        Thu, 20 Jul 2023 07:14:25 -0700 (PDT)
Received: from z-Lenovo-Product.lan ([2605:59c8:6153:ca10::4f6])
        by smtp.gmail.com with ESMTPSA id z195-20020a0dd7cc000000b00583414320d2sm221362ywd.111.2023.07.20.07.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 07:14:25 -0700 (PDT)
From:   David Ober <dober6023@gmail.com>
To:     wim@linux-watchdog.org
Cc:     linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, mpearson@lenovo.com,
        dober@lenovo.com, David Ober <dober6023@gmail.com>
Subject: [PATCH v2] Watchdog: New module for ITE 5632 watchdog
Date:   Thu, 20 Jul 2023 10:14:21 -0400
Message-Id: <20230720141421.119237-1-dober6023@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This modules is to allow for the new ITE 5632 EC chip
to support the watchdog for initial use in the Lenovo SE10

Signed-off-by: David Ober <dober6023@gmail.com>

V2 Fix stop to deactivate wdog on unload of module
V2 Remove extra logging that is not needed
V2 change udelays to usleep_range 
V2 Changed to now request region on start and release on stop instead 
   of for every ping and read/write 

---
 drivers/watchdog/Kconfig       |  10 ++
 drivers/watchdog/Makefile      |   1 +
 drivers/watchdog/ite5632_wdt.c | 273 +++++++++++++++++++++++++++++++++
 3 files changed, 284 insertions(+)
 create mode 100644 drivers/watchdog/ite5632_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index ee97d89dfc11..861cc0eff468 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -264,6 +264,16 @@ config MENZ069_WATCHDOG
 	  This driver can also be built as a module. If so the module
 	  will be called menz069_wdt.
 
+config ITE5632_WDT
+        tristate "ITE 5632"
+        select WATCHDOG_CORE
+        help
+          If you say yes here you get support for the watchdog
+          functionality of the ITE 5632 eSIO chip.
+
+          This driver can also be built as a module. If so, the module
+          will be called ite5632_wdt.
+
 config WDAT_WDT
 	tristate "ACPI Watchdog Action Table (WDAT)"
 	depends on ACPI
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 3633f5b98236..32c8340f3175 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -119,6 +119,7 @@ obj-$(CONFIG_WAFER_WDT) += wafer5823wdt.o
 obj-$(CONFIG_I6300ESB_WDT) += i6300esb.o
 obj-$(CONFIG_IE6XX_WDT) += ie6xx_wdt.o
 obj-$(CONFIG_ITCO_WDT) += iTCO_wdt.o
+obj-$(CONFIG_ITE5632_WDT) += ite5632_wdt.o
 ifeq ($(CONFIG_ITCO_VENDOR_SUPPORT),y)
 obj-$(CONFIG_ITCO_WDT) += iTCO_vendor_support.o
 endif
diff --git a/drivers/watchdog/ite5632_wdt.c b/drivers/watchdog/ite5632_wdt.c
new file mode 100644
index 000000000000..4b1fe6de6f87
--- /dev/null
+++ b/drivers/watchdog/ite5632_wdt.c
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *	Customized ITE5632 WDT driver for Lenovo SE10.
+ *
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/platform_device.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/watchdog.h>
+
+#define EC_STATUS_port	0x6C
+#define EC_CMD_port	0x6C
+#define EC_DATA_port	0x68
+#define EC_OBF		0x01
+#define EC_IBF		0x02
+#define CFG_LDN		0x07
+#define CFG_BRAM_LDN	0x10    /* for BRAM Base */
+#define CFG_PORT	0x2E
+
+#define CUS_WDT_SWI		0x1A
+#define CUS_WDT_CFG		0x1B
+#define CUS_WDT_FEED		0xB0
+#define CUS_WDT_CNT		0xB1
+
+#define DRVNAME			"ite5632"
+
+/*The timeout range is 1-255 seconds*/
+#define MIN_TIMEOUT		1
+#define MAX_TIMEOUT		255
+
+#define WATCHDOG_TIMEOUT	60	/* 60 sec default timeout */
+static unsigned short bram_base;
+
+static int timeout;	/* in seconds */
+module_param(timeout, int, 0);
+MODULE_PARM_DESC(timeout,
+		 "Watchdog timeout in seconds. 1 <= timeout <= 255, default="
+		 __MODULE_STRING(WATCHDOG_TIMEOUT) ".");
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout,
+		 "Watchdog cannot be stopped once started (default="
+		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+struct ite5632_data_t {
+	struct watchdog_device wdt;
+	int region_locked;
+};
+
+/* Kernel methods. */
+static void set_bram(unsigned char offset, unsigned char val)
+{
+	outb(offset, bram_base);
+	outb(val, bram_base + 1);
+}
+
+/* wait EC output buffer full */
+static void wait_EC_OBF(void)
+{
+	while (1) {
+		if (inb(EC_STATUS_port) & EC_OBF)
+			break;
+		usleep_range(10, 125);
+	}
+}
+
+/* wait EC input buffer empty */
+static void wait_EC_IBE(void)
+{
+	while (1) {
+		if (!(inb(EC_STATUS_port) & EC_IBF))
+			break;
+		usleep_range(10, 125);
+	}
+}
+
+static void send_EC_cmd(unsigned char eccmd)
+{
+	wait_EC_IBE();
+	outb(eccmd, EC_CMD_port);
+	wait_EC_IBE();
+}
+
+static unsigned char Read_EC_data(void)
+{
+	wait_EC_OBF();
+	return inb(EC_DATA_port);
+}
+
+static void LPC_Write_Byte(unsigned char index, unsigned char data)
+{
+	outb(index, CFG_PORT);
+	outb(data, CFG_PORT + 1);
+}
+
+static unsigned char LPC_Read_Byte(unsigned char index)
+{
+	outb(index, CFG_PORT);
+	return inb(CFG_PORT + 1);
+}
+
+static int GetChipID(void)
+{
+	unsigned char MSB, LSB;
+	unsigned char cmd = 0x55;
+
+	outb(0x87, CFG_PORT);
+	outb(0x01, CFG_PORT);
+	outb(0x55, CFG_PORT);
+	outb(cmd, CFG_PORT);
+	outb(0x20, CFG_PORT);
+	MSB = inb(CFG_PORT + 1);
+	outb(0x21, CFG_PORT);
+	LSB = inb(CFG_PORT + 1);
+	return (MSB * 256 + LSB);
+}
+
+static int wdt_start(struct watchdog_device *wdog)
+{
+	struct ite5632_data_t *data = watchdog_get_drvdata(wdog);
+
+	if (!request_region(EC_DATA_port, 5, "EC")) {
+		dev_err(data->wdt.parent, ":request fail\n");
+		return 0;
+	}
+	data->region_locked = 1;
+	set_bram(CUS_WDT_SWI, 0x80);
+	return 0;
+}
+
+static int wdt_set_timeout(struct watchdog_device *wdog, unsigned int timeout)
+{
+	wdog->timeout = timeout;
+	set_bram(CUS_WDT_CFG, wdog->timeout);
+	return 0;
+}
+
+static int wdt_stop(struct watchdog_device *wdog)
+{
+	struct ite5632_data_t *data = watchdog_get_drvdata(wdog);
+
+	set_bram(CUS_WDT_SWI, 0);
+	if (data->region_locked == 1)
+		release_region(EC_DATA_port, 5);
+	return 0;
+}
+
+static unsigned int wdt_get_time(struct watchdog_device *wdog)
+{
+	unsigned int timeleft;
+
+	send_EC_cmd(CUS_WDT_CNT);
+
+	timeleft = Read_EC_data();
+	return timeleft;
+}
+
+static int wdt_ping(struct watchdog_device *wdog)
+{
+	send_EC_cmd(CUS_WDT_FEED);
+	return 0;
+}
+
+/* Kernel Interfaces */
+static const struct watchdog_info wdt_info = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+	.identity = "5632 Watchdog",
+};
+
+static const struct watchdog_ops wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = wdt_start,
+	.stop = wdt_stop,
+	.ping = wdt_ping,
+	.set_timeout = wdt_set_timeout,
+	.get_timeleft = wdt_get_time,
+};
+
+static int ite5632_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ite5632_data_t *data = NULL;
+
+	dev_info(&pdev->dev, "Probe ITE5632 called\n");
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->region_locked = 0;
+	data->wdt.info = &wdt_info,
+	data->wdt.ops = &wdt_ops,
+	data->wdt.timeout = WATCHDOG_TIMEOUT; /* Set default timeout */
+	data->wdt.min_timeout = MIN_TIMEOUT;
+	data->wdt.max_timeout = MAX_TIMEOUT;
+	data->wdt.parent = &pdev->dev;
+
+	watchdog_init_timeout(&data->wdt, timeout, &pdev->dev);
+	watchdog_set_drvdata(&data->wdt, data);
+
+	watchdog_set_nowayout(&data->wdt, nowayout);
+	watchdog_stop_on_reboot(&data->wdt);
+	watchdog_stop_on_unregister(&data->wdt);
+
+	dev_info(&pdev->dev, "initialized. timeout=%d sec (nowayout=%d)\n",
+		 data->wdt.timeout, nowayout);
+
+	return devm_watchdog_register_device(dev, &data->wdt);
+}
+
+static struct platform_driver ite5632_driver = {
+	.driver = {
+		.name = DRVNAME,
+	},
+	.probe  = ite5632_probe,
+};
+
+static struct platform_device *pdev;
+
+static int __init wdt_init(void)
+{
+	int ret;
+	int chip;
+
+	chip = GetChipID();
+
+	if (chip == 0x5632)
+		pr_info("Found ITE ChipID = %4X\n", chip);
+	else
+		return -ENODEV;
+
+	LPC_Write_Byte(CFG_LDN, CFG_BRAM_LDN);
+	bram_base = ((LPC_Read_Byte(0x60) << 8) | LPC_Read_Byte(0x61));
+
+	platform_driver_register(&ite5632_driver);
+
+	pdev = platform_device_alloc(DRVNAME, bram_base);
+
+	/* platform_device_add calls probe() */
+	ret = platform_device_add(pdev);
+	if (ret) {
+		platform_device_put(pdev);
+		if (pdev)
+			platform_device_unregister(pdev);
+		platform_driver_unregister(&ite5632_driver);
+	}
+	return ret;
+}
+
+static void __exit wdt_exit(void)
+{
+	platform_device_unregister(pdev);
+	platform_driver_unregister(&ite5632_driver);
+
+	LPC_Write_Byte(2, 2);
+}
+
+module_init(wdt_init);
+module_exit(wdt_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("David Ober<dober@lenovo.com>");
+MODULE_DESCRIPTION("WDT driver for ITE5632");
-- 
2.34.1

