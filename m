Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281B5751F57
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbjGMK6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjGMK6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:58:41 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365CD1999;
        Thu, 13 Jul 2023 03:58:40 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-bc379e4c1cbso517145276.2;
        Thu, 13 Jul 2023 03:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689245919; x=1691837919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dYVt+VbeLmbZJR0d6mKtXmGKopicziWTKgBNn9JasiU=;
        b=TLlEqePnpYSdehVxJ6QIo1qV1T5WVN2pFnZEyYjUUg4ULzqoRKTs17NIbGILA1L9Bm
         Xk//bl1ID1ExHbcDP7CP1qKJZE35vWXWTQp52C3BCpF5IJdedxC3XP+3VCikW3sNSOEX
         whPdByLgXM+wFgZIlfdTHi8Tki+UE91pQ1lKLMqEQOr/st1XQ9qorIaOPilQNkVPdFcv
         slBr1S4cmtFcMsV4/J7Y/adOqjHN96b42cSiyupt9Hq7uHkGvapvIbsTIFOS0fLxAyjj
         5rFWK4uCK9xHD1d2FDER/lCCXLqAdf1UeZFttquHy6bpIdCuHuH7UodgDmequS+IFZfn
         Xuug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689245919; x=1691837919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dYVt+VbeLmbZJR0d6mKtXmGKopicziWTKgBNn9JasiU=;
        b=N0fnJptEKm7BMfitNKvo9I+rg8lxyzjPf+YJzb5zgDgEwSxbgNmEZONm0uPOhPkfdV
         NV8xm05uSrfpilfIpl/9sqPzb3Ft1PI7ph22Ia5mtUW5fByNbAfHZqM6GY5fhptoGPJW
         8tw1K+LcGmc2nUNreHFES7yje3aigoZKPZ9C63uVYWSajXO6mkfO6YsoDoReTytvRJUz
         6Ey/w55XFaPFLzAuqIW/PbaZlj5xsuPBVsoTjodaNg6dUv524Q2+QJk4sHmA0nPyKCsN
         lRIoL+RBxsI9rJ/G1aqbwG4jl/WOgbZ2IQHkXm12oJSK06kM88gbmZc92LepOe2SDk9x
         E1Ww==
X-Gm-Message-State: ABy/qLbvEw88tzqnoVov3adC6FNVTM2BuLW/GeCabLRCJRlGKahjks4X
        NynnvKLKq83JgHeJBt5Oanc=
X-Google-Smtp-Source: APBJJlGWHZpBiSTYIxgNAWG2/JRW+1oQsEsl9aG0jrEz4GbxQyRHc5CRW3YyQ42csRcax/Sx4HQMWA==
X-Received: by 2002:a0d:d80c:0:b0:56d:40da:1fc2 with SMTP id a12-20020a0dd80c000000b0056d40da1fc2mr1211642ywe.50.1689245919335;
        Thu, 13 Jul 2023 03:58:39 -0700 (PDT)
Received: from z-Lenovo-Product.lan ([2605:59c8:6153:ca10:ba85:d572:3a65:9783])
        by smtp.gmail.com with ESMTPSA id q127-20020a0de785000000b00545a081849esm1709057ywe.46.2023.07.13.03.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 03:58:38 -0700 (PDT)
From:   David Ober <dober6023@gmail.com>
To:     wim@linux-watchdog.org
Cc:     linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, mpearson@lenovo.com,
        dober@lenovo.com, David Ober <dober6023@gmail.com>
Subject: [PATCH] Watchdog: New module for ITE 5632 watchdog
Date:   Thu, 13 Jul 2023 06:58:34 -0400
Message-Id: <20230713105834.65751-1-dober6023@gmail.com>
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
---
 drivers/watchdog/Kconfig       |  10 ++
 drivers/watchdog/Makefile      |   1 +
 drivers/watchdog/ite5632_wdt.c | 279 +++++++++++++++++++++++++++++++++
 3 files changed, 290 insertions(+)
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
index 000000000000..32a68f16674f
--- /dev/null
+++ b/drivers/watchdog/ite5632_wdt.c
@@ -0,0 +1,279 @@
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
+		"Watchdog timeout in seconds. 1 <= timeout <= 255, default="
+				__MODULE_STRING(WATCHDOG_TIMEOUT) ".");
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout,
+		"Watchdog cannot be stopped once started (default="
+				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+struct ite5632_data_t {
+	struct watchdog_device wdt;
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
+		udelay(10);
+	}
+}
+
+/* wait EC input buffer empty */
+static void wait_EC_IBE(void)
+{
+	while (1) {
+		if (!(inb(EC_STATUS_port) & EC_IBF))
+			break;
+		udelay(10);
+	}
+}
+
+static void send_EC_cmd(unsigned char EcCmd)
+{
+	wait_EC_IBE();
+	outb(EcCmd, EC_CMD_port);
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
+	unsigned short wPortAddr = 0x2E;
+	unsigned char MSB, LSB;
+	unsigned char cmd = (CFG_PORT == 0x2E) ? (0x55) : (0xAA);
+
+	outb(0x87, CFG_PORT);
+	outb(0x01, CFG_PORT);
+	outb(0x55, CFG_PORT);
+	outb(cmd, CFG_PORT);
+	outb(0x20, wPortAddr);
+	MSB = inb(wPortAddr + 1);
+	outb(0x21, wPortAddr);
+	LSB = inb(wPortAddr + 1);
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
+	wdt_set_timeout(wdog, 0);
+	return 0;
+}
+
+static unsigned int wdt_get_time(struct watchdog_device *wdog)
+{
+	unsigned int timeleft;
+	struct ite5632_data_t *data = watchdog_get_drvdata(wdog);
+
+	if (!request_region(EC_DATA_port, 5, "EC")) {
+		dev_err(data->wdt.parent, ":request fail\n");
+		return 0;
+	}
+	send_EC_cmd(CUS_WDT_CNT);
+
+	timeleft = (int)Read_EC_data();
+	release_region(EC_DATA_port, 5);
+	return timeleft;
+}
+
+static int wdt_ping(struct watchdog_device *wdog)
+{
+	struct ite5632_data_t *data = watchdog_get_drvdata(wdog);
+
+	if (!request_region(EC_DATA_port, 5, "EC")) {
+		dev_err(data->wdt.parent, ":request fail\n");
+		return 0;
+	}
+	send_EC_cmd(CUS_WDT_FEED);
+	release_region(EC_DATA_port, 5);
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
+		pr_info("Found ITE ChipID= %4X\n", chip);
+	else {
+		pr_info("ITE ChipID 5632 not found\n");
+		return -ENODEV;
+	}
+
+	LPC_Write_Byte(CFG_LDN, CFG_BRAM_LDN);
+	bram_base = ((LPC_Read_Byte(0x60) << 8) | LPC_Read_Byte(0x61));
+
+	platform_driver_register(&ite5632_driver);
+
+	pdev = platform_device_alloc(DRVNAME, bram_base);
+
+	dev_info(&pdev->dev, "ITE5632 device found\n");
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
+	outb(0x02, 0x2E);
+	outb(0x02, 0x2E + 1);
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

