Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC157819CC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 15:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbjHSNoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 09:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjHSNoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 09:44:07 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D8C1D761;
        Sat, 19 Aug 2023 06:42:07 -0700 (PDT)
Received: from p200300ccff2bce001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff2b:ce00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qXMDG-002nxt-Bb; Sat, 19 Aug 2023 15:41:58 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1qXMDG-001ueH-09;
        Sat, 19 Aug 2023 15:41:58 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        bcousson@baylibre.com, tony@atomide.com, andreas@kemnade.info,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH 2/3] clk: twl: add clock driver for TWL6032
Date:   Sat, 19 Aug 2023 15:41:46 +0200
Message-Id: <20230819134147.456060-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230819134147.456060-1-andreas@kemnade.info>
References: <20230819134147.456060-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TWL6032 has some clock outputs which are controlled like
fixed-voltage regulators, in some drivers for these chips
found in the wild, just the regulator api is abused for controlling
them, so simply use something similar to the regulator functions.
Due to a lack of hardware available for testing, leave out the
TWL6030-specific part of those functions.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/clk/Kconfig   |   9 ++
 drivers/clk/Makefile  |   1 +
 drivers/clk/clk-twl.c | 205 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 215 insertions(+)
 create mode 100644 drivers/clk/clk-twl.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 6b3b424addab4..e927f88d6014c 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -277,6 +277,15 @@ config COMMON_CLK_S2MPS11
 	  clock. These multi-function devices have two (S2MPS14) or three
 	  (S2MPS11, S5M8767) fixed-rate oscillators, clocked at 32KHz each.
 
+config CLK_TWL
+	tristate "Clock driver for the TWL PMIC family"
+	depends on TWL4030_CORE
+	help
+	  Enable support for controlling the clock resources on TWL family
+	  PMICs. These devices have some 32K clock outputs which can be
+	  controlled by software. For now, only the TWL6032 clocks are
+	  supported.
+
 config CLK_TWL6040
 	tristate "External McPDM functional clock from twl6040"
 	depends on TWL6040_CORE
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 7cb000549b612..31c04e23b7a90 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_COMMON_CLK_STM32H7)	+= clk-stm32h7.o
 obj-$(CONFIG_COMMON_CLK_STM32MP157)	+= clk-stm32mp1.o
 obj-$(CONFIG_COMMON_CLK_TPS68470)      += clk-tps68470.o
 obj-$(CONFIG_CLK_TWL6040)		+= clk-twl6040.o
+obj-$(CONFIG_CLK_TWL)			+= clk-twl.o
 obj-$(CONFIG_ARCH_VT8500)		+= clk-vt8500.o
 obj-$(CONFIG_COMMON_CLK_RS9_PCIE)	+= clk-renesas-pcie.o
 obj-$(CONFIG_COMMON_CLK_SI521XX)	+= clk-si521xx.o
diff --git a/drivers/clk/clk-twl.c b/drivers/clk/clk-twl.c
new file mode 100644
index 0000000000000..deb5742393bac
--- /dev/null
+++ b/drivers/clk/clk-twl.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Clock driver for twl device.
+ *
+ * inspired by the driver for the Palmas device
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/mfd/twl.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define VREG_STATE              2
+#define TWL6030_CFG_STATE_OFF   0x00
+#define TWL6030_CFG_STATE_ON    0x01
+#define TWL6030_CFG_STATE_MASK  0x03
+
+struct twl_clk32k_desc {
+	const char *clk_name;
+	u8 base;
+};
+
+struct twl_clock_info {
+	struct device *dev;
+	struct clk_hw hw;
+	const struct twl_clk32k_desc *clk_desc;
+};
+
+static inline int
+twlclk_read(struct twl_clock_info *info, unsigned int slave_subgp,
+	    unsigned int offset)
+{
+	u8 value;
+	int status;
+
+	status = twl_i2c_read_u8(slave_subgp, &value,
+				 info->clk_desc->base + offset);
+	return (status < 0) ? status : value;
+}
+
+static inline int
+twlclk_write(struct twl_clock_info *info, unsigned int slave_subgp,
+	     unsigned int offset, u8 value)
+{
+	return twl_i2c_write_u8(slave_subgp, value,
+				info->clk_desc->base + offset);
+}
+
+static inline struct twl_clock_info *to_twl_clks_info(struct clk_hw *hw)
+{
+	return container_of(hw, struct twl_clock_info, hw);
+}
+
+static unsigned long twl_clks_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	return 32768;
+}
+
+static int twl6032_clks_prepare(struct clk_hw *hw)
+{
+	struct twl_clock_info *cinfo = to_twl_clks_info(hw);
+	int ret;
+
+	ret = twlclk_write(cinfo, TWL_MODULE_PM_RECEIVER, VREG_STATE,
+			   TWL6030_CFG_STATE_ON);
+	if (ret < 0)
+		dev_err(cinfo->dev, "clk prepare failed\n");
+
+	return ret;
+}
+
+static void twl6032_clks_unprepare(struct clk_hw *hw)
+{
+	struct twl_clock_info *cinfo = to_twl_clks_info(hw);
+	int ret;
+
+	ret = twlclk_write(cinfo, TWL_MODULE_PM_RECEIVER, VREG_STATE,
+			   TWL6030_CFG_STATE_OFF);
+	if (ret < 0)
+		dev_err(cinfo->dev, "clk unprepare failed\n");
+}
+
+static int twl6032_clks_is_prepared(struct clk_hw *hw)
+{
+	struct twl_clock_info *cinfo = to_twl_clks_info(hw);
+	int val;
+
+	val = twlclk_read(cinfo, TWL_MODULE_PM_RECEIVER, VREG_STATE);
+	if (val < 0) {
+		dev_err(cinfo->dev, "clk read failed\n");
+		return val;
+	}
+
+	val &= TWL6030_CFG_STATE_MASK;
+
+	return val == TWL6030_CFG_STATE_ON;
+}
+
+static const struct clk_ops twl6032_clks_ops = {
+	.prepare	= twl6032_clks_prepare,
+	.unprepare	= twl6032_clks_unprepare,
+	.is_prepared	= twl6032_clks_is_prepared,
+	.recalc_rate	= twl_clks_recalc_rate,
+};
+
+struct twl_clks_of_match_data {
+	struct clk_init_data init;
+	const struct twl_clk32k_desc desc;
+};
+
+static const struct twl_clks_of_match_data twl6032_of_clk32kg = {
+	.init = {
+		.name = "clk32kg",
+		.ops = &twl6032_clks_ops,
+		.flags = CLK_IGNORE_UNUSED,
+	},
+	.desc = {
+		.clk_name = "clk32kg",
+		.base = 0x8C,
+	},
+};
+
+static const struct twl_clks_of_match_data twl6032_of_clk32kaudio = {
+	.init = {
+		.name = "clk32kaudio",
+		.ops = &twl6032_clks_ops,
+		.flags = CLK_IGNORE_UNUSED,
+	},
+	.desc = {
+		.clk_name = "clk32kaudio",
+		.base = 0x8F,
+	},
+};
+
+static const struct of_device_id twl_clks_of_match[] = {
+	{
+		.compatible = "ti,twl6032-clk32kg",
+		.data = &twl6032_of_clk32kg,
+	},
+	{
+		.compatible = "ti,twl6032-clk32kaudio",
+		.data = &twl6032_of_clk32kaudio,
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, twl_clks_of_match);
+
+static int twl_clks_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	const struct twl_clks_of_match_data *match_data;
+	struct twl_clock_info *cinfo;
+	int ret;
+
+	match_data = of_device_get_match_data(&pdev->dev);
+	if (!match_data)
+		return 1;
+
+	cinfo = devm_kzalloc(&pdev->dev, sizeof(*cinfo), GFP_KERNEL);
+	if (!cinfo)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, cinfo);
+
+	cinfo->dev = &pdev->dev;
+
+	cinfo->clk_desc = &match_data->desc;
+	cinfo->hw.init = &match_data->init;
+	ret = devm_clk_hw_register(&pdev->dev, &cinfo->hw);
+	if (ret) {
+		dev_err(&pdev->dev, "Fail to register clock %s, %d\n",
+			match_data->desc.clk_name, ret);
+		return ret;
+	}
+
+	ret = of_clk_add_hw_provider(node, of_clk_hw_simple_get, &cinfo->hw);
+	if (ret < 0)
+		dev_err(&pdev->dev, "Fail to add clock driver, %d\n", ret);
+	return ret;
+}
+
+static void twl_clks_remove(struct platform_device *pdev)
+{
+	of_clk_del_provider(pdev->dev.of_node);
+}
+
+static struct platform_driver twl_clks_driver = {
+	.driver = {
+		.name = "twl-clk",
+		.of_match_table = twl_clks_of_match,
+	},
+	.probe = twl_clks_probe,
+	.remove_new = twl_clks_remove,
+};
+
+module_platform_driver(twl_clks_driver);
+
+MODULE_DESCRIPTION("Clock driver for TWL Series Devices");
+MODULE_ALIAS("platform:twl-clk");
+MODULE_LICENSE("GPL");
-- 
2.39.2

