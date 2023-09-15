Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19087A182F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbjIOIMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbjIOIMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:12:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BB9271D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:12:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3272C4163D;
        Fri, 15 Sep 2023 08:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694765528;
        bh=8pWk09qb0sQ/IwsL/P6y/WuoSGs+tzhjM92zM3GWetY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=am1rJsoXOefZFzwGkwJkIJgDQz6wUgKbo4bZ88jyz3bjNoCFi0FOyGPQ9zHUihvsN
         7d0EvfYOWfkH0TEW8ItAFUlla1gxmM9jq5gOVdhCRfAEHaY0gx10B9lpV1QnJ7Ub57
         NYSB43szQrjbLb1xKuL6WGBFNzIExp8dNpFSWQ9bj0YfEZjcsXdScDKPBywewqKNhx
         ydaXuf8mQJxViMsR/1KrZVdaIMcxG+cV7NSI1Bi+pZ/Puv647epPtrHPnUybkG0e3B
         ICg9/lFaDq/gcOv9tySO4AJxXqJF7OKrDfs+c2xfnSy1gnwJp5rzflpfnWOXa52bV5
         E+kxH9cBT7kyg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE17EE6436;
        Fri, 15 Sep 2023 08:12:08 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Fri, 15 Sep 2023 11:10:52 +0300
Subject: [PATCH v4 10/42] soc: Add SoC driver for Cirrus ep93xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230915-ep93xx-v4-10-a1d779dcec10@maquefel.me>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
In-Reply-To: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
To:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Joel Stanley <joel@jms.id.au>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Walker Chen <walker.chen@starfivetech.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Damien Le Moal <dlemoal@kernel.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694765525; l=10614;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=yXJN4s9S3Z8tfrvw7cipYT7sR+n5ixv4b2JWiAeYeRk=; =?utf-8?q?b=3DhN0Lzc0blkyV?=
 =?utf-8?q?n7AtnZ+0k+P77HpRVVx6HBsfDM5pIRBWwtCaBixkaxUZqXoGCyN/3dVgKwpVhCU2?=
 FucBtaw7ACnLQIdQkdEcLy5XSdGIuyI0ljURNUsxi0SAHWC5CdF6
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add an SoC driver for the ep93xx. Currently there is only one thing
not fitting into any other framework, and that is the swlock setting.

Used for clock settings, pinctrl and restart.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/soc/Kconfig               |   1 +
 drivers/soc/Makefile              |   1 +
 drivers/soc/cirrus/Kconfig        |  12 +++
 drivers/soc/cirrus/Makefile       |   2 +
 drivers/soc/cirrus/soc-ep93xx.c   | 215 ++++++++++++++++++++++++++++++++++++++
 include/linux/soc/cirrus/ep93xx.h |  11 +-
 6 files changed, 240 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 4e176280113a..16327b63b773 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -8,6 +8,7 @@ source "drivers/soc/aspeed/Kconfig"
 source "drivers/soc/atmel/Kconfig"
 source "drivers/soc/bcm/Kconfig"
 source "drivers/soc/canaan/Kconfig"
+source "drivers/soc/cirrus/Kconfig"
 source "drivers/soc/fsl/Kconfig"
 source "drivers/soc/fujitsu/Kconfig"
 source "drivers/soc/imx/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 3b0f9fb3b5c8..b76a03fe808e 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -9,6 +9,7 @@ obj-y				+= aspeed/
 obj-$(CONFIG_ARCH_AT91)		+= atmel/
 obj-y				+= bcm/
 obj-$(CONFIG_SOC_CANAAN)	+= canaan/
+obj-$(CONFIG_EP93XX_SOC)        += cirrus/
 obj-$(CONFIG_ARCH_DOVE)		+= dove/
 obj-$(CONFIG_MACH_DOVE)		+= dove/
 obj-y				+= fsl/
diff --git a/drivers/soc/cirrus/Kconfig b/drivers/soc/cirrus/Kconfig
new file mode 100644
index 000000000000..408f3343a265
--- /dev/null
+++ b/drivers/soc/cirrus/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+
+if ARCH_EP93XX
+
+config EP93XX_SOC
+	bool "Cirrus EP93xx chips SoC"
+	select SOC_BUS
+	default y if !EP93XX_SOC_COMMON
+	help
+	  Support SoC for Cirrus EP93xx chips.
+
+endif
diff --git a/drivers/soc/cirrus/Makefile b/drivers/soc/cirrus/Makefile
new file mode 100644
index 000000000000..ed6752844c6f
--- /dev/null
+++ b/drivers/soc/cirrus/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-y	+= soc-ep93xx.o
diff --git a/drivers/soc/cirrus/soc-ep93xx.c b/drivers/soc/cirrus/soc-ep93xx.c
new file mode 100644
index 000000000000..b8b23ee56f9f
--- /dev/null
+++ b/drivers/soc/cirrus/soc-ep93xx.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * SoC driver for Cirrus EP93xx chips.
+ * Copyright (C) 2022 Nikita Shubin <nikita.shubin@maquefel.me>
+ *
+ * Based on a rewrite of arch/arm/mach-ep93xx/core.c
+ * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
+ * Copyright (C) 2007 Herbert Valerio Riedel <hvr@gnu.org>
+ *
+ * Thanks go to Michael Burian and Ray Lehtiniemi for their key
+ * role in the ep93xx Linux community
+ */
+
+#include <linux/bits.h>
+#include <linux/clk-provider.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+#include <linux/soc/cirrus/ep93xx.h>
+
+#define EP93XX_EXT_CLK_RATE		14745600
+
+#define EP93XX_SYSCON_DEVCFG		0x80
+
+#define EP93XX_SWLOCK_MAGICK		0xaa
+#define EP93XX_SYSCON_SWLOCK		0xc0
+#define EP93XX_SYSCON_SYSCFG		0x9c
+#define EP93XX_SYSCON_SYSCFG_REV_MASK	GENMASK(31, 28)
+#define EP93XX_SYSCON_SYSCFG_REV_SHIFT	28
+
+#define EP93XX_SYSCON_CLKSET1		0x20
+#define EP93XX_SYSCON_CLKSET1_NBYP1	BIT(23)
+#define EP93XX_SYSCON_CLKSET2		0x24
+#define EP93XX_SYSCON_CLKSET2_NBYP2	BIT(19)
+#define EP93XX_SYSCON_CLKSET2_PLL2_EN	BIT(18)
+
+static DEFINE_SPINLOCK(ep93xx_swlock);
+
+/*
+ * EP93xx System Controller software locked register write
+ *
+ * Logic safeguards are included to condition the control signals for
+ * power connection to the matrix to prevent part damage. In addition, a
+ * software lock register is included that must be written with 0xAA
+ * before each register write to change the values of the four switch
+ * matrix control registers.
+ */
+void ep93xx_regmap_write(struct regmap *map, unsigned int reg, unsigned int val)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ep93xx_swlock, flags);
+
+	regmap_write(map, EP93XX_SYSCON_SWLOCK, EP93XX_SWLOCK_MAGICK);
+	regmap_write(map, reg, val);
+
+	spin_unlock_irqrestore(&ep93xx_swlock, flags);
+}
+
+void ep93xx_regmap_update_bits(struct regmap *map, unsigned int reg,
+			       unsigned int mask, unsigned int val)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ep93xx_swlock, flags);
+
+	regmap_write(map, EP93XX_SYSCON_SWLOCK, EP93XX_SWLOCK_MAGICK);
+	/* force write is required to clear swlock if is no changes are made */
+	regmap_update_bits_base(map, reg, mask, val, NULL, false, true);
+
+	spin_unlock_irqrestore(&ep93xx_swlock, flags);
+}
+
+static unsigned int __init ep93xx_soc_revision(struct regmap *map)
+{
+	unsigned int val;
+
+	regmap_read(map, EP93XX_SYSCON_SYSCFG, &val);
+	val &= EP93XX_SYSCON_SYSCFG_REV_MASK;
+	val >>= EP93XX_SYSCON_SYSCFG_REV_SHIFT;
+	return val;
+}
+
+static const char __init *ep93xx_get_soc_rev(struct regmap *map)
+{
+	switch (ep93xx_soc_revision(map)) {
+	case EP93XX_CHIP_REV_D0:
+		return "D0";
+	case EP93XX_CHIP_REV_D1:
+		return "D1";
+	case EP93XX_CHIP_REV_E0:
+		return "E0";
+	case EP93XX_CHIP_REV_E1:
+		return "E1";
+	case EP93XX_CHIP_REV_E2:
+		return "E2";
+	default:
+		return "unknown";
+	}
+}
+
+/*
+ * PLL rate = 14.7456 MHz * (X1FBD + 1) * (X2FBD + 1) / (X2IPD + 1) / 2^PS
+ */
+static unsigned long __init calc_pll_rate(u64 rate, u32 config_word)
+{
+	rate *= ((config_word >> 11) & GENMASK(4, 0)) + 1;	/* X1FBD */
+	rate *= ((config_word >> 5) & GENMASK(5, 0)) + 1;	/* X2FBD */
+	do_div(rate, (config_word & GENMASK(4, 0)) + 1);	/* X2IPD */
+	rate >>= ((config_word >> 16) & GENMASK(1, 0));		/* PS */
+
+	return rate;
+}
+
+static int __init ep93xx_syscon_probe(struct platform_device *pdev)
+{
+	unsigned int clk_f_div, clk_h_div, clk_p_div, clk_usb_div;
+	const char fclk_divisors[] = { 1, 2, 4, 8, 16, 1, 1, 1 };
+	const char hclk_divisors[] = { 1, 2, 4, 5, 6, 8, 16, 32 };
+	const char pclk_divisors[] = { 1, 2, 4, 8 };
+	unsigned long clk_pll1_rate, clk_pll2_rate;
+	struct soc_device_attribute *attrs;
+	struct soc_device *soc_dev;
+	struct device *dev = &pdev->dev;
+	struct regmap *map;
+	struct clk_hw *hw;
+	u32 value;
+
+	map = device_node_to_regmap(dev->of_node);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	/* Determine the bootloader configured pll1 rate */
+	regmap_read(map, EP93XX_SYSCON_CLKSET1, &value);
+
+	if (value & EP93XX_SYSCON_CLKSET1_NBYP1)
+		clk_pll1_rate = calc_pll_rate(EP93XX_EXT_CLK_RATE, value);
+	else
+		clk_pll1_rate = EP93XX_EXT_CLK_RATE;
+
+	hw = clk_hw_register_fixed_rate(dev, "pll1", "xtali", 0, clk_pll1_rate);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+
+	/* Initialize the pll1 derived clocks */
+	clk_f_div = fclk_divisors[(value >> 25) & GENMASK(2, 0)];
+	clk_h_div = hclk_divisors[(value >> 20) & GENMASK(2, 0)];
+	clk_p_div = pclk_divisors[(value >> 18) & GENMASK(1, 0)];
+
+	hw = clk_hw_register_fixed_factor(dev, "fclk", "pll1", 0, 1, clk_f_div);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+
+	hw = clk_hw_register_fixed_factor(dev, "hclk", "pll1", 0, 1, clk_h_div);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+
+	hw = clk_hw_register_fixed_factor(dev, "pclk", "hclk", 0, 1, clk_p_div);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+
+	/* Determine the bootloader configured pll2 rate */
+	regmap_read(map, EP93XX_SYSCON_CLKSET2, &value);
+	if (!(value & EP93XX_SYSCON_CLKSET2_NBYP2))
+		clk_pll2_rate = EP93XX_EXT_CLK_RATE;
+	else if (value & EP93XX_SYSCON_CLKSET2_PLL2_EN)
+		clk_pll2_rate = calc_pll_rate(EP93XX_EXT_CLK_RATE, value);
+	else
+		clk_pll2_rate = 0;
+
+	hw = clk_hw_register_fixed_rate(dev, "pll2", "xtali", 0, clk_pll2_rate);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+
+	regmap_read(map, EP93XX_SYSCON_CLKSET2, &value);
+	clk_usb_div = (((value >> 28) & GENMASK(3, 0)) + 1);
+	hw = clk_hw_register_fixed_factor(dev, "usb_clk", "pll2", 0, 1, clk_usb_div);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+
+	attrs = devm_kzalloc(dev, sizeof(*attrs), GFP_KERNEL);
+	if (!attrs)
+		return -ENOMEM;
+
+	attrs->machine = of_flat_dt_get_machine_name();
+	attrs->family = "Cirrus Logic EP93xx";
+	attrs->revision = ep93xx_get_soc_rev(map);
+
+	soc_dev = soc_device_register(attrs);
+	if (IS_ERR(soc_dev))
+		return PTR_ERR(soc_dev);
+
+	dev_info(dev, "EP93xx SoC revision %s\n", attrs->revision);
+
+	return 0;
+}
+
+static const struct of_device_id ep9301_syscon_of_device_ids[] = {
+	{ .compatible	= "cirrus,ep9301-syscon" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver ep9301_syscon_driver = {
+	.driver = {
+		.name = "ep9301-syscon",
+		.of_match_table = ep9301_syscon_of_device_ids,
+	},
+};
+builtin_platform_driver_probe(ep9301_syscon_driver, ep93xx_syscon_probe);
diff --git a/include/linux/soc/cirrus/ep93xx.h b/include/linux/soc/cirrus/ep93xx.h
index 8b4b8221ed4c..267529ee2b3d 100644
--- a/include/linux/soc/cirrus/ep93xx.h
+++ b/include/linux/soc/cirrus/ep93xx.h
@@ -11,7 +11,7 @@ struct regmap;
 #define EP93XX_CHIP_REV_E1	6
 #define EP93XX_CHIP_REV_E2	7
 
-#ifdef CONFIG_ARCH_EP93XX
+#if defined(CONFIG_EP93XX_SOC_COMMON)
 int ep93xx_pwm_acquire_gpio(struct platform_device *pdev);
 void ep93xx_pwm_release_gpio(struct platform_device *pdev);
 int ep93xx_ide_acquire_gpio(struct platform_device *pdev);
@@ -33,11 +33,18 @@ static inline int ep93xx_i2s_acquire(void) { return 0; }
 static inline void ep93xx_i2s_release(void) {}
 static inline unsigned int ep93xx_chip_revision(void) { return 0; }
 
-#endif
+#if defined(CONFIG_EP93XX_SOC)
+void ep93xx_regmap_write(struct regmap *map, unsigned int reg, unsigned int val);
+void ep93xx_regmap_update_bits(struct regmap *map, unsigned int reg,
+			       unsigned int mask, unsigned int val);
 
+#else
 static inline void ep93xx_regmap_write(struct regmap *map, unsigned int reg, unsigned int val) {}
 static inline void ep93xx_regmap_update_bits(struct regmap *map, unsigned int reg,
 					     unsigned int mask, unsigned int val)
 { }
 
 #endif
+#endif
+
+#endif

-- 
2.39.2

