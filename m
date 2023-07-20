Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0C175B043
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjGTNkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjGTNkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:40:41 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18481BFC;
        Thu, 20 Jul 2023 06:40:39 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-579ef51428eso8791297b3.2;
        Thu, 20 Jul 2023 06:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689860439; x=1690465239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ts6geZGQGEZBxFxvT1FCczqL+Ys052ML+vAse9RJSvs=;
        b=RDX1GnB2zUsi66RN/S9bk8jg2ulN6JMH/Tl7sYe17XDBEerV26RyrVAaB2qDvP6Kc/
         dNeUzXE1lsjmHzxbCbuqDkUAji3xbpmjnyH2YkSbD7sOMPkRdKGtQYXMrkRQUtg5m7bK
         BKBdef1p5KPVhrWR8pB9Fp90HGJr6qqv2ZxrSp1x+kBgHTwi//LKzdXmQAdhPLnfFPvD
         EkVGDD5p+kUE3BQnugfLHrFy2mPRQRuEpwZ4l3T6P8ufRaqV3UXU0KELPOUFoMKS3H39
         gDfG0IZc2gF1enDGEBO7w51D+GyQzw8/AcRiLpsgDtCx+mU5s26e38GAQ5en5kOwxFkI
         q5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689860439; x=1690465239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ts6geZGQGEZBxFxvT1FCczqL+Ys052ML+vAse9RJSvs=;
        b=MGi7+H3/IWJKDQReokw9eWFgRxH9C2HEmfeDsDWOWNA8fiHgcvsQIC0+x2J4DoT1Gf
         ue4y6DZg4pZwlXmzo8KIqAoVQ11kbHlbhhWoi5uVb/Bm4cl8edRjBB50OabKt8b1jK2I
         LBYCvVvwqXWu/XgJ35Xm8t4j+nyH1L1G+LGIh27FqIr9qHP7kcmbyiu8qIb/sfn8e/lj
         F6HqgvZDZy9xgnzOU2pZiiiWKbqFznABWhjWGWr5L3waza7raoUgKnlHkXG/EYOUjW5j
         JrAl6aR5WSjEcu6CH/z89FQTyiODIjJmRQisU+bS63J1WwiKYvuZUEezHgCw03Yi+q3D
         qCdw==
X-Gm-Message-State: ABy/qLYqNu/HHoOA8xXS6UJsWW+wDLvHcTB49sKom0npchPLab73m1JO
        A6Up94pX17ZBcELY1QDAbsQ=
X-Google-Smtp-Source: APBJJlHXGLi6I4a2uQaK49FpfFOhskC8Pa33DimbCyK0iqOAlDn9qBB2Sm5TvFyO9MAHjd0cVlShmQ==
X-Received: by 2002:a0d:d995:0:b0:583:6839:755 with SMTP id b143-20020a0dd995000000b0058368390755mr5005933ywe.14.1689860437966;
        Thu, 20 Jul 2023 06:40:37 -0700 (PDT)
Received: from z-Lenovo-Product.lan ([2605:59c8:6153:ca10::4f6])
        by smtp.gmail.com with ESMTPSA id n75-20020a0dcb4e000000b0056d3d7a59cesm214523ywd.12.2023.07.20.06.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 06:40:37 -0700 (PDT)
From:   David Ober <dober6023@gmail.com>
To:     wim@linux-watchdog.org
Cc:     linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, mpearson@lenovo.com,
        dober@lenovo.com, David Ober <dober6023@gmail.com>
Subject: [PATCH v2] Watchdog: New module for ITE 5632 watchdog
Date:   Thu, 20 Jul 2023 09:40:30 -0400
Message-Id: <20230720134030.119137-1-dober6023@gmail.com>
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
V2 Fix issues indentified by maintainer
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

