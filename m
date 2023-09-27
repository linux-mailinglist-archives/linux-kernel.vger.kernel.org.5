Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610437B0AB9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjI0Qyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjI0Qyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:54:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05D8DD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:54:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B43C433CC;
        Wed, 27 Sep 2023 16:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695833670;
        bh=pfq+SQ5jW2o9nXakRgvSgmaqn3orOhnaopBx/4PGPjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dI0YrIfy3jXCRX8+l+D2FjpPKNs3YV7+hSTiGlNtpGtV7CQS6bd586Pt3ZyMoUV7i
         jICgsB1K+tZwYyfcHX3fcqS+EjQyqfKN56lB5rxmhPJY1u5C5yqAJzH2Y+Sh7GcCnA
         Wsjh/mt9gs90sacL9QsJdnhEDORTDgAeSQlZkhrVAQHBgxfLa5jj1XVu8ZHqzgIdZB
         zk0Ns+qhq+xNHB0bKRIrrb335lwvV5BvXwFSnl0oaVCz5cqX0mwtAQkzs+FzxjX+2m
         gh/D3N+yoUM4HM2so+vq6e9HXDseLImFHeWW1gISm9LFOO+4RJWBhgwJur/o7zClzJ
         ononDWm9zlqqw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, linux-riscv@lists.infradead.org
Subject: [PATCH 2/2] usb: dwc3: add T-HEAD TH1520 usb driver
Date:   Thu, 28 Sep 2023 00:42:22 +0800
Message-Id: <20230927164222.3505-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230927164222.3505-1-jszhang@kernel.org>
References: <20230927164222.3505-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds TH1520 Glue layer to support USB controller on T-HEAD TH1520 SoC.
There is a DesignWare USB3 DRD core in TH1520 SoCs, the dwc3 core is
the child of this USB wrapper module device.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 MAINTAINERS                   |   1 +
 drivers/usb/dwc3/Kconfig      |   9 +++
 drivers/usb/dwc3/Makefile     |   1 +
 drivers/usb/dwc3/dwc3-thead.c | 119 ++++++++++++++++++++++++++++++++++
 4 files changed, 130 insertions(+)
 create mode 100644 drivers/usb/dwc3/dwc3-thead.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 90f13281d297..d55e40060c46 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18481,6 +18481,7 @@ M:	Fu Wei <wefu@redhat.com>
 L:	linux-riscv@lists.infradead.org
 S:	Maintained
 F:	arch/riscv/boot/dts/thead/
+F:	drivers/usb/dwc3/dwc3-thead.c
 
 RNBD BLOCK DRIVERS
 M:	Md. Haris Iqbal <haris.iqbal@ionos.com>
diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 98efcbb76c88..1b02f4f55b47 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -178,4 +178,13 @@ config USB_DWC3_OCTEON
 	  Only the host mode is currently supported.
 	  Say 'Y' or 'M' here if you have one such device.
 
+config USB_DWC3_THEAD
+	tristate "T-HEAD Platform"
+	depends on ARCH_THEAD || COMPILE_TEST
+	default USB_DWC3
+	help
+	  Support T-HEAD platform with DesignWare Core USB3 IP.
+	  Only the host mode is currently supported.
+	  Say 'Y' or 'M' here if you have one such device.
+
 endif
diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
index fe1493d4bbe5..9523a51dd279 100644
--- a/drivers/usb/dwc3/Makefile
+++ b/drivers/usb/dwc3/Makefile
@@ -55,3 +55,4 @@ obj-$(CONFIG_USB_DWC3_QCOM)		+= dwc3-qcom.o
 obj-$(CONFIG_USB_DWC3_IMX8MP)		+= dwc3-imx8mp.o
 obj-$(CONFIG_USB_DWC3_XILINX)		+= dwc3-xilinx.o
 obj-$(CONFIG_USB_DWC3_OCTEON)		+= dwc3-octeon.o
+obj-$(CONFIG_USB_DWC3_THEAD)		+= dwc3-thead.o
diff --git a/drivers/usb/dwc3/dwc3-thead.c b/drivers/usb/dwc3/dwc3-thead.c
new file mode 100644
index 000000000000..999b1e319c72
--- /dev/null
+++ b/drivers/usb/dwc3/dwc3-thead.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dwc3-thead.c - T-HEAD platform specific glue layer
+ *
+ * Inspired by dwc3-of-simple.c
+ *
+ * Copyright (C) 2021 Alibaba Group Holding Limited.
+ * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include "core.h"
+
+#define USB_SSP_EN		0x34
+#define  REF_SSP_EN		BIT(0)
+#define USB_SYS			0x3c
+#define  COMMONONN		BIT(0)
+
+#define USB3_DRD_SWRST		0x14
+#define  USB3_DRD_PRST		BIT(0)
+#define  USB3_DRD_PHYRST	BIT(1)
+#define  USB3_DRD_VCCRST	BIT(2)
+#define  USB3_DRD_RSTMASK	(USB3_DRD_PRST | USB3_DRD_PHYRST | USB3_DRD_VCCRST)
+
+struct dwc3_thead {
+	void __iomem		*base;
+	struct regmap		*misc_sysreg;
+	struct regulator	*vbus;
+};
+
+static void dwc3_thead_optimize_power(struct dwc3_thead *thead)
+{
+	u32 val;
+
+	/* config usb top within USB ctrl & PHY reset */
+	regmap_update_bits(thead->misc_sysreg, USB3_DRD_SWRST,
+			   USB3_DRD_RSTMASK, USB3_DRD_PRST);
+
+	/*
+	 * dwc reg also need to be configed to save power
+	 * 1. set USB_SYS[COMMONONN]
+	 * 2. set DWC3_GCTL[SOFITPSYNC](done by core.c)
+	 * 3. set GUSB3PIPECTL[SUSPENDEN] (done by core.c)
+	 */
+	val = readl(thead->base + USB_SYS);
+	val |= COMMONONN;
+	writel(val, thead->base + USB_SYS);
+	val = readl(thead->base + USB_SSP_EN);
+	val |= REF_SSP_EN;
+	writel(val, thead->base + USB_SSP_EN);
+
+	regmap_update_bits(thead->misc_sysreg, USB3_DRD_SWRST,
+			   USB3_DRD_RSTMASK, USB3_DRD_RSTMASK);
+}
+
+static int dwc3_thead_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct dwc3_thead *thead;
+	int ret;
+
+	thead = devm_kzalloc(&pdev->dev, sizeof(*thead), GFP_KERNEL);
+	if (!thead)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, thead);
+
+	ret = devm_regulator_get_enable_optional(dev, "vbus");
+	if (ret < 0 && ret != -ENODEV)
+		return ret;
+
+	thead->misc_sysreg = syscon_regmap_lookup_by_phandle(np, "thead,misc-sysreg");
+	if (IS_ERR(thead->misc_sysreg))
+		return PTR_ERR(thead->misc_sysreg);
+
+	thead->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(thead->base))
+		return PTR_ERR(thead->base);
+
+	dwc3_thead_optimize_power(thead);
+
+	return of_platform_populate(np, NULL, NULL, dev);
+}
+
+static void dwc3_thead_remove(struct platform_device *pdev)
+{
+	of_platform_depopulate(&pdev->dev);
+}
+
+static const struct of_device_id dwc3_thead_of_match[] = {
+	{ .compatible = "thead,th1520-usb" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, dwc3_thead_of_match);
+
+static struct platform_driver dwc3_thead_driver = {
+	.probe		= dwc3_thead_probe,
+	.remove_new	= dwc3_thead_remove,
+	.driver		= {
+		.name	= "dwc3-thead",
+		.of_match_table	= dwc3_thead_of_match,
+	},
+};
+module_platform_driver(dwc3_thead_driver);
+
+MODULE_ALIAS("platform:dwc3-thead");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("DesignWare DWC3 T-HEAD Glue Driver");
+MODULE_AUTHOR("Jisheng Zhang <jszhang@kernel.org>");
-- 
2.40.1

