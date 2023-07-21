Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF61275C6E5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 14:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjGUM3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 08:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjGUM3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 08:29:39 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCE72106;
        Fri, 21 Jul 2023 05:29:37 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-583a8596e2aso810587b3.1;
        Fri, 21 Jul 2023 05:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689942576; x=1690547376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tc2DUVw3S2rr0BdPREx2gU2YkFEqYPheCV0prmYoXsw=;
        b=Aknmnrjc4WEC3/uTCUTG4A/DDrZF1EuImaq3VH41BHr/HUPrY/ytwEWZJA+ejKdvqZ
         YkcrvhuAboI8GB1mS018O+gU2rhwsHgd4knnCFunpugvbPvMmTwhaOr4UbYJs7LlK7zE
         9ARvO/m3+iCLClwBjFAvgz+m4Fe38zd85zw3jHuCj39WLXj/t4ML+NzHWkfTh3bLTl1c
         XCNPiYyKF6QD6vv6pvpySpjEEN1r54qBJnmyo1RciV65k02SQNJSJYTBecjZVyzVfgvt
         2wJUrTHjNwvna0l+YXSjXdZG5qa12YeCXEoFIvLRjr+Th4V1Ebuh2OiKSwNF7xhnDQpW
         xrAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689942576; x=1690547376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tc2DUVw3S2rr0BdPREx2gU2YkFEqYPheCV0prmYoXsw=;
        b=le+utY6CZURbyV4eANkllPaRneWkwzjBRunxJ+ep5r2WDC+sw+2L1vJW0JUe3dL0Lc
         WiJvXjYi1r/ks2hu+IsjHkC3GxVO/KRuTdJgMmEpLKf2TqGq8D+XIvvv2xUxRFAVortZ
         JRG/RAY66M0MtqfVT5b/VcaaQkLV+wLKfLpE+YmhrHR4L9afvZ4LInMwPASz6nSII4FP
         0F0vGp3EWQxk5H6txf744tqXJQNa2swn7IZDswlj3CoNwAXi0y03vejyrsY3NbKv1ZiI
         1ODZlUjghv/uBbd83BR37bdQfNAW+1Brh9jAGazc6V5O9Ld/T2L0wCYrw7thBAVLzv8q
         Vipg==
X-Gm-Message-State: ABy/qLZmxm1EmRSxGZFAH/g76PwaYU4UQiluJmuzdt/H9NUMudLw4pXF
        67gQ5D3czlkq3qVocJQOEdw=
X-Google-Smtp-Source: APBJJlH9opA4MJPUgNRHa3kk+e2XupACB5RCNem/NKRfWJDZTLWi1uQYsXvc3PwFLnDzC2TXcaxFrg==
X-Received: by 2002:a25:908d:0:b0:c60:6db5:36e5 with SMTP id t13-20020a25908d000000b00c606db536e5mr1393262ybl.35.1689942576520;
        Fri, 21 Jul 2023 05:29:36 -0700 (PDT)
Received: from z-Lenovo-Product.lan ([2605:59c8:6153:ca10::4f6])
        by smtp.gmail.com with ESMTPSA id y2-20020a259282000000b00bcd91bb300esm715094ybl.54.2023.07.21.05.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 05:29:36 -0700 (PDT)
From:   David Ober <dober6023@gmail.com>
To:     wim@linux-watchdog.org
Cc:     linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, mpearson@lenovo.com,
        dober@lenovo.com, David Ober <dober6023@gmail.com>
Subject: [PATCH v3] Watchdog: New module for ITE 5632 watchdog
Date:   Fri, 21 Jul 2023 08:29:31 -0400
Message-Id: <20230721122931.505957-1-dober6023@gmail.com>
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
V3 add counter to while loops so it will not hang
V3 rework code to use platform_device_register_simple
V3 rework getting the Chip ID to remove duplicate code and close IO
V3 change some extra logging to be debug only
---
 drivers/watchdog/Kconfig       |  10 ++
 drivers/watchdog/Makefile      |   1 +
 drivers/watchdog/ite5632_wdt.c | 278 +++++++++++++++++++++++++++++++++
 3 files changed, 289 insertions(+)
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
index 000000000000..efa0881eef4a
--- /dev/null
+++ b/drivers/watchdog/ite5632_wdt.c
@@ -0,0 +1,278 @@
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
+#define ITE5632_SIO_UNLOCK_KEY          0x87
+#define ITE5632_SIO_LOCK_KEY            0xAA
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
+#define MAX_WAIT		10
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
+/* the watchdog platform device */
+static struct platform_device *ite5632wdt_platform_device;
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
+	int loop = 0;
+
+	while (1) {
+		if (inb(EC_STATUS_port) & EC_OBF || loop > MAX_WAIT)
+			break;
+		loop++;
+		usleep_range(10, 125);
+	}
+}
+
+/* wait EC input buffer empty */
+static void wait_EC_IBE(void)
+{
+	int loop = 0;
+
+	while (1) {
+		if (!(inb(EC_STATUS_port) & EC_IBF) || loop > MAX_WAIT)
+			break;
+		loop++;
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
+	outb(ITE5632_SIO_UNLOCK_KEY, CFG_PORT);
+	outb(0x01, CFG_PORT);
+	outb(0x55, CFG_PORT);
+	outb(cmd, CFG_PORT);
+	MSB = LPC_Read_Byte(0x20);
+	LSB = LPC_Read_Byte(0x21);
+	outb(ITE5632_SIO_LOCK_KEY, CFG_PORT);
+	return (MSB * 256 + LSB);
+}
+
+static int wdt_start(struct watchdog_device *wdog)
+{
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
+	set_bram(CUS_WDT_SWI, 0);
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
+	struct watchdog_device *wdt;
+	int ret;
+
+	dev_dbg(&pdev->dev, "Probe ITE5632 called\n");
+
+	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt) {
+		release_region(EC_DATA_port, 5);
+		return -ENOMEM;
+	}
+
+	wdt->info = &wdt_info,
+	wdt->ops = &wdt_ops,
+	wdt->timeout = WATCHDOG_TIMEOUT; /* Set default timeout */
+	wdt->min_timeout = MIN_TIMEOUT;
+	wdt->max_timeout = MAX_TIMEOUT;
+	wdt->parent = &pdev->dev;
+
+	watchdog_init_timeout(wdt, timeout, &pdev->dev);
+	watchdog_set_nowayout(wdt, nowayout);
+	watchdog_stop_on_reboot(wdt);
+	watchdog_stop_on_unregister(wdt);
+
+	ret = devm_watchdog_register_device(dev, wdt);
+
+	dev_dbg(&pdev->dev, "initialized. timeout=%d sec (nowayout=%d)\n",
+		wdt->timeout, nowayout);
+
+	return ret;
+}
+
+static struct platform_driver ite5632_driver = {
+	.driver = {
+		.name = DRVNAME,
+	},
+	.probe  = ite5632_probe,
+};
+
+static int __init wdt_init(void)
+{
+	int err;
+	int chip;
+
+	if (!request_region(EC_DATA_port, 5, "EC")) {
+		pr_err(":request fail\n");
+		return -EIO;
+	}
+	chip = GetChipID();
+
+	if (chip != 0x5632) {
+		release_region(EC_DATA_port, 5);
+		return -ENODEV;
+	}
+	pr_info("Found ITE ChipID = %4X\n", chip);
+
+	LPC_Write_Byte(CFG_LDN, CFG_BRAM_LDN);
+	bram_base = (LPC_Read_Byte(0x60) << 8) | LPC_Read_Byte(0x61);
+
+	ite5632wdt_platform_device = platform_device_register_simple(DRVNAME,
+								     -1, NULL, 0);
+	if (IS_ERR(ite5632wdt_platform_device)) {
+		release_region(EC_DATA_port, 5);
+		return PTR_ERR(ite5632wdt_platform_device);
+	}
+
+	err = platform_driver_probe(&ite5632_driver, ite5632_probe);
+	if (err)
+		goto unreg_platform_device;
+
+	return 0;
+
+unreg_platform_device:
+	platform_device_unregister(ite5632wdt_platform_device);
+	release_region(EC_DATA_port, 5);
+	return err;
+}
+
+static void __exit wdt_exit(void)
+{
+	platform_device_unregister(ite5632wdt_platform_device);
+	platform_driver_unregister(&ite5632_driver);
+
+	release_region(EC_DATA_port, 5);
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

