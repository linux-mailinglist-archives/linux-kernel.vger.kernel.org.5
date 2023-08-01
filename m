Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A443D76A801
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 06:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjHAErC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 00:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjHAEqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 00:46:55 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA2B10CA;
        Mon, 31 Jul 2023 21:46:53 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3712eZSq021659;
        Mon, 31 Jul 2023 21:46:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=lMUcm+2jpGhLyehQdH3nCMeeNcTu7ROYLFb3Qob9/TE=;
 b=EMG34UJ9GFfSi4FkG/FRMvj4BsaesgBhirfiifcEOsPFqEU0A44ust+cNy5UuLIhAB3J
 JBGhi0cwfHG1jePv2vG3VfiHRiijCUuQ149qOeMYGnHQneN9XXBNot6ArRu2OHzeInE5
 KRb1gQxVrTjmglrCb34YjifkSR7aanRjUSbXUkTP0edeT6KekNiqNWSUD85mr4a3/hU6
 jFZe/f/3JsKjGIMGRGC4iZRm/vwu3PzcH/psmxV4Onjz8Bo2JAdRdxp8ndSFFsyVzfW5
 /00n6uNI0jWFTyvbQ2bvdgaL0HLDefsQ7eG1IZY/w4oP3MVFmDElLii6LfN4ok3R+Lnz GQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3s6du0aw21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 21:46:38 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 31 Jul
 2023 21:46:36 -0700
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 31 Jul 2023 21:46:33 -0700
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH 2/2 v10] Watchdog: Add marvell GTI watchdog driver
Date:   Tue, 1 Aug 2023 10:16:23 +0530
Message-ID: <20230801044623.9275-2-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230801044623.9275-1-bbhushan2@marvell.com>
References: <20230801044623.9275-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: 0KPDdxK6c_wGb5lbBNRro3wngf8rqamS
X-Proofpoint-ORIG-GUID: 0KPDdxK6c_wGb5lbBNRro3wngf8rqamS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_02,2023-07-31_02,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for Marvell GTI watchdog.  Global timer
unit (GTI) support hardware watchdog timer. Software programs
watchdog timer to generate interrupt on first timeout, second
timeout is configured to be ignored and system reboots on
third timeout.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
v10:
 - Added MODULE_LICENSE

v9:
 - include header files is alphabetic order
 - using BIT_ULL for bit shifts in macros
 - using devm_clk_get_enabled() rather than
   devm_clk_get() and clk_prepare_enable()
 - compatibles as per dt-binding changes

v8:
  - Compatible names as per soc names
  - This driver run on ARM64 based architecture, Added 64BIT config
    dependency to avoid compilation error related to readq/writeq on
    32 as platform (Hexagon)

 drivers/watchdog/Kconfig           |  13 ++
 drivers/watchdog/Makefile          |   1 +
 drivers/watchdog/marvell_gti_wdt.c | 340 +++++++++++++++++++++++++++++
 3 files changed, 354 insertions(+)
 create mode 100644 drivers/watchdog/marvell_gti_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index ee97d89dfc11..87ac222b436e 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1797,6 +1797,19 @@ config OCTEON_WDT
 	  from the first interrupt, it is then only poked when the
 	  device is written.
 
+config MARVELL_GTI_WDT
+	tristate "Marvell GTI Watchdog driver"
+	depends on ARCH_THUNDER || (COMPILE_TEST && 64BIT)
+	default y
+	select WATCHDOG_CORE
+	help
+	 Marvell GTI hardware supports watchdog timer. First timeout
+	 works as watchdog pretimeout and installed interrupt handler
+	 will be called on first timeout. Hardware can generate interrupt
+	 to SCP on second timeout but it is not enabled, So second
+	 timeout is ignored. If device poke does not happen then system
+	 will reboot on third timeout.
+
 config BCM2835_WDT
 	tristate "Broadcom BCM2835 hardware watchdog"
 	depends on ARCH_BCM2835 || (OF && COMPILE_TEST)
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 3633f5b98236..7eab9de311cb 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -98,6 +98,7 @@ obj-$(CONFIG_VISCONTI_WATCHDOG) += visconti_wdt.o
 obj-$(CONFIG_MSC313E_WATCHDOG) += msc313e_wdt.o
 obj-$(CONFIG_APPLE_WATCHDOG) += apple_wdt.o
 obj-$(CONFIG_SUNPLUS_WATCHDOG) += sunplus_wdt.o
+obj-$(CONFIG_MARVELL_GTI_WDT) += marvell_gti_wdt.o
 
 # X86 (i386 + ia64 + x86_64) Architecture
 obj-$(CONFIG_ACQUIRE_WDT) += acquirewdt.o
diff --git a/drivers/watchdog/marvell_gti_wdt.c b/drivers/watchdog/marvell_gti_wdt.c
new file mode 100644
index 000000000000..a6ed7d8db791
--- /dev/null
+++ b/drivers/watchdog/marvell_gti_wdt.c
@@ -0,0 +1,340 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell GTI Watchdog driver
+ *
+ * Copyright (C) 2023 Marvell.
+ */
+
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/watchdog.h>
+
+/*
+ * Hardware supports following mode of operation:
+ * 1) Interrupt Only:
+ *    This will generate the interrupt to arm core whenever timeout happens.
+ *
+ * 2) Interrupt + del3t (Interrupt to firmware (SCP processor)).
+ *    This will generate interrupt to arm core on 1st timeout happens
+ *    This will generate interrupt to SCP processor on 2nd timeout happens
+ *
+ * 3) Interrupt + Interrupt to SCP processor (called delt3t) + reboot.
+ *    This will generate interrupt to arm core on 1st timeout happens
+ *    Will generate interrupt to SCP processor on 2nd timeout happens,
+ *    if interrupt is configured.
+ *    Reboot on 3rd timeout.
+ *
+ * Driver will use hardware in mode-3 above so that system can reboot in case
+ * a hardware hang. Also h/w is configured not to generate SCP interrupt, so
+ * effectively 2nd timeout is ignored within hardware.
+ *
+ * First timeout is effectively watchdog pretimeout.
+ */
+
+/* GTI CWD Watchdog (GTI_CWD_WDOG) Register */
+#define GTI_CWD_WDOG(reg_offset)	(0x8 * (reg_offset))
+#define GTI_CWD_WDOG_MODE_INT_DEL3T_RST	0x3
+#define GTI_CWD_WDOG_MODE_MASK		GENMASK_ULL(1, 0)
+#define GTI_CWD_WDOG_LEN_SHIFT		4
+#define GTI_CWD_WDOG_LEN_MASK		GENMASK_ULL(19, 4)
+#define GTI_CWD_WDOG_CNT_SHIFT		20
+#define GTI_CWD_WDOG_CNT_MASK		GENMASK_ULL(43, 20)
+
+/* GTI CWD Watchdog Interrupt (GTI_CWD_INT) Register */
+#define GTI_CWD_INT			0x200
+#define GTI_CWD_INT_PENDING_STATUS(bit)	BIT_ULL(bit)
+
+/* GTI CWD Watchdog Interrupt Enable Clear (GTI_CWD_INT_ENA_CLR) Register */
+#define GTI_CWD_INT_ENA_CLR		0x210
+#define GTI_CWD_INT_ENA_CLR_VAL(bit)	BIT_ULL(bit)
+
+/* GTI CWD Watchdog Interrupt Enable Set (GTI_CWD_INT_ENA_SET) Register */
+#define GTI_CWD_INT_ENA_SET		0x218
+#define GTI_CWD_INT_ENA_SET_VAL(bit)	BIT_ULL(bit)
+
+/* GTI CWD Watchdog Poke (GTI_CWD_POKE) Registers */
+#define GTI_CWD_POKE(reg_offset)	(0x10000 + 0x8 * (reg_offset))
+#define GTI_CWD_POKE_VAL		1
+
+struct gti_match_data {
+	u32 gti_num_timers;
+};
+
+static const struct gti_match_data match_data_octeontx2 = {
+	.gti_num_timers = 54,
+};
+
+static const struct gti_match_data match_data_cn10k = {
+	.gti_num_timers = 64,
+};
+
+struct gti_wdt_priv {
+	struct watchdog_device wdev;
+	void __iomem *base;
+	u32 clock_freq;
+	struct clk *sclk;
+	/* wdt_timer_idx used for timer to be used for system watchdog */
+	u32 wdt_timer_idx;
+	const struct gti_match_data *data;
+};
+
+static irqreturn_t gti_wdt_interrupt(int irq, void *data)
+{
+	struct watchdog_device *wdev = data;
+	struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
+
+	/* Clear Interrupt Pending Status */
+	writeq(GTI_CWD_INT_PENDING_STATUS(priv->wdt_timer_idx),
+	       priv->base + GTI_CWD_INT);
+
+	watchdog_notify_pretimeout(wdev);
+
+	return IRQ_HANDLED;
+}
+
+static int gti_wdt_ping(struct watchdog_device *wdev)
+{
+	struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
+
+	writeq(GTI_CWD_POKE_VAL,
+	       priv->base + GTI_CWD_POKE(priv->wdt_timer_idx));
+
+	return 0;
+}
+
+static int gti_wdt_start(struct watchdog_device *wdev)
+{
+	struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
+	u64 regval;
+
+	if (!wdev->pretimeout)
+		return -EINVAL;
+
+	set_bit(WDOG_HW_RUNNING, &wdev->status);
+
+	/* Clear any pending interrupt */
+	writeq(GTI_CWD_INT_PENDING_STATUS(priv->wdt_timer_idx),
+	       priv->base + GTI_CWD_INT);
+
+	/* Enable Interrupt */
+	writeq(GTI_CWD_INT_ENA_SET_VAL(priv->wdt_timer_idx),
+	       priv->base + GTI_CWD_INT_ENA_SET);
+
+	/* Set (Interrupt + SCP interrupt (DEL3T) + core domain reset) Mode */
+	regval = readq(priv->base + GTI_CWD_WDOG(priv->wdt_timer_idx));
+	regval |= GTI_CWD_WDOG_MODE_INT_DEL3T_RST;
+	writeq(regval, priv->base + GTI_CWD_WDOG(priv->wdt_timer_idx));
+
+	return 0;
+}
+
+static int gti_wdt_stop(struct watchdog_device *wdev)
+{
+	struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
+	u64 regval;
+
+	/* Disable Interrupt */
+	writeq(GTI_CWD_INT_ENA_CLR_VAL(priv->wdt_timer_idx),
+	       priv->base + GTI_CWD_INT_ENA_CLR);
+
+	/* Set GTI_CWD_WDOG.Mode = 0 to stop the timer */
+	regval = readq(priv->base + GTI_CWD_WDOG(priv->wdt_timer_idx));
+	regval &= ~GTI_CWD_WDOG_MODE_MASK;
+	writeq(regval, priv->base + GTI_CWD_WDOG(priv->wdt_timer_idx));
+
+	return 0;
+}
+
+static int gti_wdt_settimeout(struct watchdog_device *wdev,
+					unsigned int timeout)
+{
+	struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
+	u64 timeout_wdog, regval;
+
+	/* Update new timeout */
+	wdev->timeout = timeout;
+
+	/* Pretimeout is 1/3 of timeout */
+	wdev->pretimeout = timeout / 3;
+
+	/* Get clock cycles from pretimeout */
+	timeout_wdog = (u64)priv->clock_freq * wdev->pretimeout;
+
+	/* Watchdog counts in 1024 cycle steps */
+	timeout_wdog = timeout_wdog >> 10;
+
+	/* GTI_CWD_WDOG.CNT: reload counter is 16-bit */
+	timeout_wdog = (timeout_wdog + 0xff) >> 8;
+	if (timeout_wdog >= 0x10000)
+		timeout_wdog = 0xffff;
+
+	/*
+	 * GTI_CWD_WDOG.LEN is 24bit, lower 8-bits should be zero and
+	 * upper 16-bits are same as GTI_CWD_WDOG.CNT
+	 */
+	regval = readq(priv->base + GTI_CWD_WDOG(priv->wdt_timer_idx));
+	regval &= GTI_CWD_WDOG_MODE_MASK;
+	regval |= (timeout_wdog << (GTI_CWD_WDOG_CNT_SHIFT + 8)) |
+		   (timeout_wdog << GTI_CWD_WDOG_LEN_SHIFT);
+	writeq(regval, priv->base + GTI_CWD_WDOG(priv->wdt_timer_idx));
+
+	return 0;
+}
+
+static int gti_wdt_set_pretimeout(struct watchdog_device *wdev,
+					unsigned int timeout)
+{
+	struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
+	struct watchdog_device *wdog_dev = &priv->wdev;
+
+	/* pretimeout should 1/3 of max_timeout */
+	if (timeout * 3 <= wdog_dev->max_timeout)
+		return gti_wdt_settimeout(wdev, timeout * 3);
+
+	return -EINVAL;
+}
+
+static void gti_clk_disable_unprepare(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
+static int gti_wdt_get_cntfrq(struct platform_device *pdev,
+			      struct gti_wdt_priv *priv)
+{
+	int err;
+
+	priv->sclk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(priv->sclk))
+		return PTR_ERR(priv->sclk);
+
+	err = devm_add_action_or_reset(&pdev->dev,
+				       gti_clk_disable_unprepare, priv->sclk);
+	if (err)
+		return err;
+
+	priv->clock_freq = clk_get_rate(priv->sclk);
+	if (!priv->clock_freq)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct watchdog_info gti_wdt_ident = {
+	.identity = "Marvell GTI watchdog",
+	.options = WDIOF_SETTIMEOUT | WDIOF_PRETIMEOUT | WDIOF_KEEPALIVEPING |
+		   WDIOF_MAGICCLOSE | WDIOF_CARDRESET,
+};
+
+static const struct watchdog_ops gti_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = gti_wdt_start,
+	.stop = gti_wdt_stop,
+	.ping = gti_wdt_ping,
+	.set_timeout = gti_wdt_settimeout,
+	.set_pretimeout = gti_wdt_set_pretimeout,
+};
+
+static int gti_wdt_probe(struct platform_device *pdev)
+{
+	struct gti_wdt_priv *priv;
+	struct device *dev = &pdev->dev;
+	struct watchdog_device *wdog_dev;
+	u64 max_pretimeout;
+	u32 wdt_idx;
+	int irq;
+	int err;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->base),
+			      "reg property not valid/found\n");
+
+	err = gti_wdt_get_cntfrq(pdev, priv);
+	if (err)
+		return dev_err_probe(&pdev->dev, err,
+				     "GTI clock frequency not valid/found");
+
+	priv->data = of_device_get_match_data(dev);
+
+	/* default use last timer for watchdog */
+	priv->wdt_timer_idx = priv->data->gti_num_timers - 1;
+
+	err = of_property_read_u32(dev->of_node, "marvell,wdt-timer-index",
+				   &wdt_idx);
+	if (!err) {
+		if (wdt_idx >= priv->data->gti_num_timers)
+			return dev_err_probe(&pdev->dev, err,
+				"GTI wdog timer index not valid");
+
+		priv->wdt_timer_idx = wdt_idx;
+	}
+
+	wdog_dev = &priv->wdev;
+	wdog_dev->info = &gti_wdt_ident,
+	wdog_dev->ops = &gti_wdt_ops,
+	wdog_dev->parent = dev;
+	/*
+	 * Watchdog counter is 24 bit where lower 8 bits are zeros
+	 * This counter decrements every 1024 clock cycles.
+	 */
+	max_pretimeout = (GTI_CWD_WDOG_CNT_MASK >> GTI_CWD_WDOG_CNT_SHIFT);
+	max_pretimeout &= ~0xFFUL;
+	max_pretimeout = (max_pretimeout * 1024) / priv->clock_freq;
+	wdog_dev->pretimeout = max_pretimeout;
+
+	/* Maximum timeout is 3 times the pretimeout */
+	wdog_dev->max_timeout = max_pretimeout * 3;
+	/* Minimum first timeout (pretimeout) is 1, so min_timeout as 3 */
+	wdog_dev->min_timeout = 3;
+	wdog_dev->timeout = wdog_dev->pretimeout;
+
+	watchdog_set_drvdata(wdog_dev, priv);
+	platform_set_drvdata(pdev, priv);
+	gti_wdt_settimeout(wdog_dev, wdog_dev->timeout);
+	watchdog_stop_on_reboot(wdog_dev);
+	watchdog_stop_on_unregister(wdog_dev);
+
+	err = devm_watchdog_register_device(dev, wdog_dev);
+	if (err)
+		return err;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return dev_err_probe(&pdev->dev, irq, "IRQ resource not found\n");
+
+	err = devm_request_irq(dev, irq, gti_wdt_interrupt, 0,
+			       pdev->name, &priv->wdev);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to register interrupt handler\n");
+
+	dev_info(dev, "Watchdog enabled (timeout=%d sec)\n", wdog_dev->timeout);
+	return 0;
+}
+
+static const struct of_device_id gti_wdt_of_match[] = {
+	{ .compatible = "marvell,cn9670-wdt", .data = &match_data_octeontx2},
+	{ .compatible = "marvell,cn10624-wdt", .data = &match_data_cn10k},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, gti_wdt_of_match);
+
+static struct platform_driver gti_wdt_driver = {
+	.driver = {
+		.name = "gti-wdt",
+		.of_match_table = gti_wdt_of_match,
+	},
+	.probe = gti_wdt_probe,
+};
+module_platform_driver(gti_wdt_driver);
+
+MODULE_AUTHOR("Bharat Bhushan <bbhushan2@marvell.com>");
+MODULE_DESCRIPTION("Marvell GTI watchdog driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

