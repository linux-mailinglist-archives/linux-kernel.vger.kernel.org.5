Return-Path: <linux-kernel+bounces-139057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9138789FDF3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B41A41C20920
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E1518131B;
	Wed, 10 Apr 2024 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OeQYQyur"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EDF17F366;
	Wed, 10 Apr 2024 17:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769162; cv=none; b=NPdtR+SRiJqeoq675GVuPzeZk6LHDAOZ3/WB7DbqsDC8bfTftqA4jBQe8PYRQd2m+GvFLAX0FC0JsKkZcKBEEGgLI2hIvH90HlemrzV9bdQU6Ez5lh5YcT9DPWp9lqII62CS61G+vBtLmXIW6wPw21Kf4YpwyGYNLbMQO3ipRcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769162; c=relaxed/simple;
	bh=ESW7k04bOah5gJzElrHGNSP1+hSPZzg7NelHWdPldCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZZvlxPMyX/TWlR20jz6mJCKc1xm8A8bsHN7/GsD0vVrGqGSChSxePDdY8kwzlI/eKX+pEv1UPYnrxVXm5XOqRj7M40ZpiO8OJ9csyKhRADBYtF+LvGTblAzmkgiKGL3gECEMNi2otE8z+D0naPH1AIPs0Z1Un85twpUJl6nfGlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OeQYQyur; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1763C1C000B;
	Wed, 10 Apr 2024 17:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712769156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F3BqGEUn2EmB2IwhPjvDlmPWipGAcZkNTnmyUxCGE3o=;
	b=OeQYQyurEe0wdA5JCyKiAcgm5pO40eJaXH/qaEO9RX2B/L8ZFHAkqALehBajIFWoCWVebX
	0y46BqtA5Y+BwJN/JrQq5PDyF3tkyPusKCkIgG2FbbYWOsByzg0gFSDmPCPVlKJJFuIdX+
	3sg7ViUfBGoQ83zbiWbbg6ZBDUT+wrGv80aN28SXPpFGLxQfR1smJGl3hWsG+8baH8aGuz
	mavVkFhtSmrnsEN/5E9nz+BSC17SH9ixXf8aB128wG9phDjKzOpyFQJmU/8sI1u6Y31IcH
	81baQYS3o+YMrp5grvs6u/ZAPJEtWddZUf28CRAF4gsQK2RWEZqG6mX+ux3zZw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 10 Apr 2024 19:12:34 +0200
Subject: [PATCH 05/11] clk: eyeq: add driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240410-mbly-olb-v1-5-335e496d7be3@bootlin.com>
References: <20240410-mbly-olb-v1-0-335e496d7be3@bootlin.com>
In-Reply-To: <20240410-mbly-olb-v1-0-335e496d7be3@bootlin.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-gpio@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Add Mobileye EyeQ5, EyeQ6L and EyeQ6H clock controller driver. It is
both a platform driver and a hook onto of_clk_init() used for clocks
required early (GIC timer, UARTs).

For some compatible, it is both at the same time. eqc_init() initialises
early PLLs and stores clock array in a static linked list. It marks
other clocks as deferred. eqc_probe() retrieves the clock array and
adds all remaining clocks.

It exposes read-only PLLs derived from the main crystal on board. It
also exposes another type of clocks: divider clocks. They always have
even divisors and have one PLL as parent.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 MAINTAINERS            |   1 +
 drivers/clk/Kconfig    |  11 +
 drivers/clk/Makefile   |   1 +
 drivers/clk/clk-eyeq.c | 644 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 657 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42553da10be9..33168ebf3cc5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14932,6 +14932,7 @@ F:	Documentation/devicetree/bindings/soc/mobileye/
 F:	arch/mips/boot/dts/mobileye/
 F:	arch/mips/configs/eyeq5_defconfig
 F:	arch/mips/mobileye/board-epm5.its.S
+F:	drivers/clk/clk-eyeq5.c
 F:	include/dt-bindings/clock/mobileye,eyeq5-clk.h
 
 MODULE SUPPORT
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 50af5fc7f570..1eb6e70977a3 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -218,6 +218,17 @@ config COMMON_CLK_EN7523
 	  This driver provides the fixed clocks and gates present on Airoha
 	  ARM silicon.
 
+config COMMON_CLK_EYEQ
+	bool "Clock driver for the Mobileye EyeQ platform"
+	depends on OF || COMPILE_TEST
+	depends on MACH_EYEQ5 || MACH_EYEQ6H || COMPILE_TEST
+	default MACH_EYEQ5 || MACH_EYEQ6H
+	help
+	  This driver provides clocks found on Mobileye EyeQ5, EyeQ6L and Eye6H
+	  SoCs. Controllers live in shared register regions called OLB. Driver
+	  provides read-only PLLs, derived from the main crystal clock (which
+	  must be constant). It also exposes some divider clocks.
+
 config COMMON_CLK_FSL_FLEXSPI
 	tristate "Clock driver for FlexSPI on Layerscape SoCs"
 	depends on ARCH_LAYERSCAPE || COMPILE_TEST
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 14fa8d4ecc1f..52de92309aa8 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_ARCH_CLPS711X)		+= clk-clps711x.o
 obj-$(CONFIG_COMMON_CLK_CS2000_CP)	+= clk-cs2000-cp.o
 obj-$(CONFIG_ARCH_SPARX5)		+= clk-sparx5.o
 obj-$(CONFIG_COMMON_CLK_EN7523)		+= clk-en7523.o
+obj-$(CONFIG_COMMON_CLK_EYEQ)		+= clk-eyeq.o
 obj-$(CONFIG_COMMON_CLK_FIXED_MMIO)	+= clk-fixed-mmio.o
 obj-$(CONFIG_COMMON_CLK_FSL_FLEXSPI)	+= clk-fsl-flexspi.o
 obj-$(CONFIG_COMMON_CLK_FSL_SAI)	+= clk-fsl-sai.o
diff --git a/drivers/clk/clk-eyeq.c b/drivers/clk/clk-eyeq.c
new file mode 100644
index 000000000000..bb2535010ae6
--- /dev/null
+++ b/drivers/clk/clk-eyeq.c
@@ -0,0 +1,644 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PLL clock driver for the Mobileye EyeQ5, EyeQ6L and EyeQ6H platforms.
+ *
+ * This controller handles read-only PLLs, all derived from the same main
+ * crystal clock. It also exposes divider clocks, those are children to PLLs.
+ * Parent clock is expected to be constant. This driver's registers live in
+ * a shared region called OLB. Some PLLs are initialised early by of_clk_init().
+ *
+ * We use eqc_ as prefix, as-in "EyeQ Clock", but way shorter.
+ *
+ * Copyright (C) 2024 Mobileye Vision Technologies Ltd.
+ */
+
+#define pr_fmt(fmt) "clk-eyeq: " fmt
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/overflow.h>
+#include <linux/platform_device.h>
+#include <linux/printk.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include <dt-bindings/clock/mobileye,eyeq5-clk.h>
+
+#define EQC_MAX_DIV_COUNT		4
+
+/* In frac mode, it enables fractional noise canceling DAC. Else, no function. */
+#define PCSR0_DAC_EN			BIT(0)
+/* Fractional or integer mode */
+#define PCSR0_DSM_EN			BIT(1)
+#define PCSR0_PLL_EN			BIT(2)
+/* All clocks output held at 0 */
+#define PCSR0_FOUTPOSTDIV_EN		BIT(3)
+#define PCSR0_POST_DIV1			GENMASK(6, 4)
+#define PCSR0_POST_DIV2			GENMASK(9, 7)
+#define PCSR0_REF_DIV			GENMASK(15, 10)
+#define PCSR0_INTIN			GENMASK(27, 16)
+#define PCSR0_BYPASS			BIT(28)
+/* Bits 30..29 are reserved */
+#define PCSR0_PLL_LOCKED		BIT(31)
+
+#define PCSR1_RESET			BIT(0)
+#define PCSR1_SSGC_DIV			GENMASK(4, 1)
+/* Spread amplitude (% = 0.1 * SPREAD[4:0]) */
+#define PCSR1_SPREAD			GENMASK(9, 5)
+#define PCSR1_DIS_SSCG			BIT(10)
+/* Down-spread or center-spread */
+#define PCSR1_DOWN_SPREAD		BIT(11)
+#define PCSR1_FRAC_IN			GENMASK(31, 12)
+
+/*
+ * Driver might register clock provider from eqc_init() if PLLs are required
+ * early (before platform bus is ready). Store struct eqc_priv inside linked
+ * list to pass clock provider from eqc_init() to eqc_probe() and register
+ * remaining clocks from platform device probe.
+ *
+ * Clock provider is NOT created by eqc_init() if no early clock is required.
+ * Store as linked list because EyeQ6H has multiple clock controller instances.
+ * Matching is done based on devicetree node pointer.
+ */
+static DEFINE_SPINLOCK(eqc_list_slock);
+static LIST_HEAD(eqc_list);
+
+struct eqc_pll {
+	unsigned int	index;
+	const char	*name;
+	u32		reg64;
+};
+
+/*
+ * Divider clock. Divider is 2*(v+1), with v the register value.
+ * Min divider is 2, max is 2*(2^width).
+ */
+struct eqc_div {
+	unsigned int	index;
+	const char	*name;
+	unsigned int	parent;
+	const char	*resource_name;
+	u8		shift;
+	u8		width;
+};
+
+struct eqc_match_data {
+	unsigned int		early_pll_count;
+	const struct eqc_pll	*early_plls;
+
+	unsigned int		pll_count;
+	const struct eqc_pll	*plls;
+
+	unsigned int		div_count;
+	const struct eqc_div	*divs;
+};
+
+struct eqc_priv {
+	struct clk_hw_onecell_data	*cells;
+	const struct eqc_match_data	*data;
+	void __iomem			*base_plls;
+	struct device_node		*np;
+	struct list_head		list;
+};
+
+static int eqc_pll_parse_registers(u32 r0, u32 r1, unsigned long *mult,
+				   unsigned long *div, unsigned long *acc)
+{
+	if (r0 & PCSR0_BYPASS) {
+		*mult = 1;
+		*div = 1;
+		*acc = 0;
+		return 0;
+	}
+
+	if (!(r0 & PCSR0_PLL_LOCKED))
+		return -EINVAL;
+
+	*mult = FIELD_GET(PCSR0_INTIN, r0);
+	*div = FIELD_GET(PCSR0_REF_DIV, r0);
+	if (r0 & PCSR0_FOUTPOSTDIV_EN)
+		*div *= FIELD_GET(PCSR0_POST_DIV1, r0) * FIELD_GET(PCSR0_POST_DIV2, r0);
+
+	/* Fractional mode, in 2^20 (0x100000) parts. */
+	if (r0 & PCSR0_DSM_EN) {
+		*div *= 0x100000;
+		*mult = *mult * 0x100000 + FIELD_GET(PCSR1_FRAC_IN, r1);
+	}
+
+	if (!*mult || !*div)
+		return -EINVAL;
+
+	/* Spread spectrum. */
+	if (!(r1 & (PCSR1_RESET | PCSR1_DIS_SSCG))) {
+		/*
+		 * Spread is 1/1000 parts of frequency, accuracy is half of
+		 * that. To get accuracy, convert to ppb (parts per billion).
+		 */
+		u32 spread = FIELD_GET(PCSR1_SPREAD, r1);
+
+		*acc = spread * 500000;
+		if (r1 & PCSR1_DOWN_SPREAD) {
+			/*
+			 * Downspreading: the central frequency is half a
+			 * spread lower.
+			 */
+			*mult *= 2000 - spread;
+			*div *= 2000;
+		}
+	} else {
+		*acc = 0;
+	}
+
+	return 0;
+}
+
+static unsigned int eqc_compute_clock_count(const struct eqc_match_data *data)
+{
+	unsigned int i, nb_clks = 0;
+
+	for (i = 0; i < data->early_pll_count; i++)
+		if (data->early_plls[i].index >= nb_clks)
+			nb_clks = data->early_plls[i].index + 1;
+	for (i = 0; i < data->pll_count; i++)
+		if (data->plls[i].index >= nb_clks)
+			nb_clks = data->plls[i].index + 1;
+	for (i = 0; i < data->div_count; i++)
+		if (data->divs[i].index >= nb_clks)
+			nb_clks = data->divs[i].index + 1;
+
+	/* We expect the biggest clock index to be 1 below the clock count. */
+	WARN_ON(nb_clks != data->early_pll_count + data->pll_count + data->div_count);
+
+	return nb_clks;
+}
+
+static int eqc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	void __iomem *div_resources[EQC_MAX_DIV_COUNT];
+	struct device_node *np = dev->of_node;
+	const struct eqc_match_data *data;
+	struct eqc_priv *priv = NULL;
+	struct clk_hw *hw;
+	unsigned int i;
+
+	data = device_get_match_data(dev);
+	if (!data)
+		return -ENODEV;
+
+	if (data->early_pll_count) {
+		/* Device got inited early. Retrieve clock provider from list. */
+		struct eqc_priv *entry;
+
+		spin_lock(&eqc_list_slock);
+		list_for_each_entry(entry, &eqc_list, list) {
+			if (entry->np == np) {
+				priv = entry;
+				break;
+			}
+		}
+		spin_unlock(&eqc_list_slock);
+
+		if (!priv)
+			return -ENODEV;
+	} else {
+		/* Device did NOT get init early. Do it now. */
+		unsigned int nb_clks;
+
+		priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+		if (!priv)
+			return -ENOMEM;
+
+		priv->np = np;
+		priv->data = data;
+
+		nb_clks = eqc_compute_clock_count(data);
+		priv->cells = devm_kzalloc(dev, struct_size(priv->cells, hws, nb_clks),
+					   GFP_KERNEL);
+		if (!priv->cells)
+			return -ENOMEM;
+
+		priv->cells->num = nb_clks;
+
+		/*
+		 * We expect named resources if divider clocks are present.
+		 * Else, we only expect one resource.
+		 */
+		if (data->div_count)
+			priv->base_plls = devm_platform_ioremap_resource_byname(pdev, "plls");
+		else
+			priv->base_plls = devm_platform_ioremap_resource(pdev, 0);
+		if (IS_ERR(priv->base_plls))
+			return PTR_ERR(priv->base_plls);
+	}
+
+	for (i = 0; i < data->pll_count; i++) {
+		const struct eqc_pll *pll = &data->plls[i];
+		unsigned long mult, div, acc;
+		u32 r0, r1;
+		u64 val;
+		int ret;
+
+		val = readq(priv->base_plls + pll->reg64);
+		r0 = val;
+		r1 = val >> 32;
+
+		ret = eqc_pll_parse_registers(r0, r1, &mult, &div, &acc);
+		if (ret) {
+			dev_warn(dev, "failed parsing state of %s\n", pll->name);
+			priv->cells->hws[pll->index] = ERR_PTR(ret);
+			continue;
+		}
+
+		hw = clk_hw_register_fixed_factor_with_accuracy_fwname(dev,
+				dev->of_node, pll->name, "ref", 0, mult, div, acc);
+		priv->cells->hws[pll->index] = hw;
+		if (IS_ERR(hw))
+			dev_warn(dev, "failed registering %s: %pe\n", pll->name, hw);
+	}
+
+	BUG_ON(ARRAY_SIZE(div_resources) < data->div_count);
+
+	for (i = 0; i < data->div_count; i++) {
+		const struct eqc_div *div = &data->divs[i];
+		void __iomem *base = NULL;
+		struct clk_hw *parent;
+		unsigned int j;
+
+		/*
+		 * Multiple divider clocks can request the same resource. Store
+		 * resource pointers during probe(). For each divider clock,
+		 * check if previous clocks referenced the same resource name.
+		 *
+		 * See EQ6HC_SOUTH_DIV_OSPI_REF and EQ6HC_SOUTH_DIV_OSPI_SYS.
+		 */
+		for (j = 0; j < i; j++) {
+			if (strcmp(data->divs[j].resource_name, div->resource_name) == 0) {
+				base = div_resources[j];
+				break;
+			}
+		}
+
+		/* Resource is first encountered. */
+		if (!base) {
+			base = devm_platform_ioremap_resource_byname(pdev, div->resource_name);
+			if (IS_ERR(base)) {
+				dev_warn(dev, "failed to iomap resource for %s\n", div->name);
+				priv->cells->hws[div->index] = base;
+				continue;
+			}
+		}
+
+		div_resources[i] = base;
+
+		parent = priv->cells->hws[div->parent];
+		hw = clk_hw_register_divider_table_parent_hw(dev, div->name,
+				parent, 0, base, div->shift, div->width,
+				CLK_DIVIDER_EVEN_INTEGERS, NULL, NULL);
+		priv->cells->hws[div->index] = hw;
+		if (IS_ERR(hw))
+			dev_warn(dev, "failed registering %s: %pe\n",
+				 div->name, hw);
+	}
+
+	/* Clock provider has not been registered by eqc_init(). Do it now. */
+	if (data->early_pll_count == 0) {
+		/* When providing a single clock, require no cell. */
+		if (priv->cells->num == 1)
+			return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+							   priv->cells->hws);
+		else
+			return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+							   priv->cells);
+	}
+
+	return 0;
+}
+
+/* Required early for GIC timer (pll-cpu) and UARTs (pll-per). */
+static const struct eqc_pll eqc_eyeq5_early_plls[] = {
+	{ .index = EQ5C_PLL_CPU, .name = "pll-cpu",  .reg64 = 0x00, },
+	{ .index = EQ5C_PLL_PER, .name = "pll-per",  .reg64 = 0x30, },
+};
+
+static const struct eqc_pll eqc_eyeq5_plls[] = {
+	{ .index = EQ5C_PLL_VMP,  .name = "pll-vmp",  .reg64 = 0x08, },
+	{ .index = EQ5C_PLL_PMA,  .name = "pll-pma",  .reg64 = 0x10, },
+	{ .index = EQ5C_PLL_VDI,  .name = "pll-vdi",  .reg64 = 0x18, },
+	{ .index = EQ5C_PLL_DDR0, .name = "pll-ddr0", .reg64 = 0x20, },
+	{ .index = EQ5C_PLL_PCI,  .name = "pll-pci",  .reg64 = 0x28, },
+	{ .index = EQ5C_PLL_PMAC, .name = "pll-pmac", .reg64 = 0x38, },
+	{ .index = EQ5C_PLL_MPC,  .name = "pll-mpc",  .reg64 = 0x40, },
+	{ .index = EQ5C_PLL_DDR1, .name = "pll-ddr1", .reg64 = 0x48, },
+};
+
+static const struct eqc_div eqc_eyeq5_divs[] = {
+	{
+		.index = EQ5C_DIV_OSPI,
+		.name = "div-ospi",
+		.parent = EQ5C_PLL_PER,
+		.resource_name = "ospi",
+		.shift = 0,
+		.width = 4,
+	},
+};
+
+static const struct eqc_match_data eqc_eyeq5_match_data = {
+	.early_pll_count	= ARRAY_SIZE(eqc_eyeq5_early_plls),
+	.early_plls		= eqc_eyeq5_early_plls,
+
+	.pll_count	= ARRAY_SIZE(eqc_eyeq5_plls),
+	.plls		= eqc_eyeq5_plls,
+
+	.div_count	= ARRAY_SIZE(eqc_eyeq5_divs),
+	.divs		= eqc_eyeq5_divs,
+};
+
+static const struct eqc_pll eqc_eyeq6l_plls[] = {
+	{ .index = EQ6LC_PLL_DDR, .name = "pll-ddr", .reg64 = 0x2C },
+	{ .index = EQ6LC_PLL_CPU, .name = "pll-cpu", .reg64 = 0x34 }, /* also acc */
+	{ .index = EQ6LC_PLL_PER, .name = "pll-per", .reg64 = 0x3C },
+	{ .index = EQ6LC_PLL_VDI, .name = "pll-vdi", .reg64 = 0x44 },
+};
+
+static const struct eqc_match_data eqc_eyeq6l_match_data = {
+	.pll_count	= ARRAY_SIZE(eqc_eyeq6l_plls),
+	.plls		= eqc_eyeq6l_plls,
+};
+
+/* Required early for GIC timer. */
+static const struct eqc_pll eqc_eyeq6h_central_early_plls[] = {
+	{ .index = 0, .name = "pll-cpu", .reg64 = 0x00 },
+};
+
+static const struct eqc_match_data eqc_eyeq6h_central_match_data = {
+	.early_pll_count	= ARRAY_SIZE(eqc_eyeq6h_central_early_plls),
+	.early_plls		= eqc_eyeq6h_central_early_plls,
+};
+
+/* Required early for UART. */
+static const struct eqc_pll eqc_eyeq6h_west_early_plls[] = {
+	{ .index = 0, .name = "pll-west", .reg64 = 0x00 },
+};
+
+static const struct eqc_match_data eqc_eyeq6h_west_match_data = {
+	.early_pll_count	= ARRAY_SIZE(eqc_eyeq6h_west_early_plls),
+	.early_plls		= eqc_eyeq6h_west_early_plls,
+};
+
+static const struct eqc_pll eqc_eyeq6h_east_plls[] = {
+	{ .index = 0, .name = "pll-east", .reg64 = 0x00 },
+};
+
+static const struct eqc_match_data eqc_eyeq6h_east_match_data = {
+	.pll_count	= ARRAY_SIZE(eqc_eyeq6h_east_plls),
+	.plls		= eqc_eyeq6h_east_plls,
+};
+
+static const struct eqc_pll eqc_eyeq6h_south_plls[] = {
+	{ .index = EQ6HC_SOUTH_PLL_VDI,  .name = "pll-vdi",  .reg64 = 0x00 },
+	{ .index = EQ6HC_SOUTH_PLL_PCIE, .name = "pll-pcie", .reg64 = 0x08 },
+	{ .index = EQ6HC_SOUTH_PLL_PER,  .name = "pll-per",  .reg64 = 0x10 },
+	{ .index = EQ6HC_SOUTH_PLL_ISP,  .name = "pll-isp",  .reg64 = 0x18 },
+};
+
+static const struct eqc_div eqc_eyeq6h_south_divs[] = {
+	{
+		.index = EQ6HC_SOUTH_DIV_EMMC,
+		.name = "div-emmc",
+		.parent = EQ6HC_SOUTH_PLL_PER,
+		.resource_name = "emmc",
+		.shift = 4,
+		.width = 4,
+	},
+	{
+		.index = EQ6HC_SOUTH_DIV_OSPI_REF,
+		.name = "div-ospi-ref",
+		.parent = EQ6HC_SOUTH_PLL_PER,
+		.resource_name = "ospi",
+		.shift = 4,
+		.width = 4,
+	},
+	{
+		.index = EQ6HC_SOUTH_DIV_OSPI_SYS,
+		.name = "div-ospi-sys",
+		.parent = EQ6HC_SOUTH_PLL_PER,
+		.resource_name = "ospi",
+		.shift = 8,
+		.width = 1,
+	},
+	{
+		.index = EQ6HC_SOUTH_DIV_TSU,
+		.name = "div-tsu",
+		.parent = EQ6HC_SOUTH_PLL_PCIE,
+		.resource_name = "tsu",
+		.shift = 4,
+		.width = 8,
+	},
+};
+
+static const struct eqc_match_data eqc_eyeq6h_south_match_data = {
+	.pll_count	= ARRAY_SIZE(eqc_eyeq6h_south_plls),
+	.plls		= eqc_eyeq6h_south_plls,
+
+	.div_count	= ARRAY_SIZE(eqc_eyeq6h_south_divs),
+	.divs		= eqc_eyeq6h_south_divs,
+};
+
+static const struct eqc_pll eqc_eyeq6h_ddr0_plls[] = {
+	{ .index = 0, .name = "pll-ddr0", .reg64 = 0x00 },
+};
+
+static const struct eqc_match_data eqc_eyeq6h_ddr0_match_data = {
+	.pll_count	= ARRAY_SIZE(eqc_eyeq6h_ddr0_plls),
+	.plls		= eqc_eyeq6h_ddr0_plls,
+};
+
+static const struct eqc_pll eqc_eyeq6h_ddr1_plls[] = {
+	{ .index = 0, .name = "pll-ddr1", .reg64 = 0x00 },
+};
+
+static const struct eqc_match_data eqc_eyeq6h_ddr1_match_data = {
+	.pll_count	= ARRAY_SIZE(eqc_eyeq6h_ddr1_plls),
+	.plls		= eqc_eyeq6h_ddr1_plls,
+};
+
+static const struct eqc_pll eqc_eyeq6h_acc_plls[] = {
+	{ .index = EQ6HC_ACC_PLL_XNN, .name = "pll-xnn", .reg64 = 0x00 },
+	{ .index = EQ6HC_ACC_PLL_VMP, .name = "pll-vmp", .reg64 = 0x10 },
+	{ .index = EQ6HC_ACC_PLL_PMA, .name = "pll-pma", .reg64 = 0x1C },
+	{ .index = EQ6HC_ACC_PLL_MPC, .name = "pll-mpc", .reg64 = 0x28 },
+	{ .index = EQ6HC_ACC_PLL_NOC, .name = "pll-noc", .reg64 = 0x30 },
+};
+
+static const struct eqc_match_data eqc_eyeq6h_acc_match_data = {
+	.pll_count	= ARRAY_SIZE(eqc_eyeq6h_acc_plls),
+	.plls		= eqc_eyeq6h_acc_plls,
+};
+
+static const struct of_device_id eqc_match_table[] = {
+	{ .compatible = "mobileye,eyeq5-clk", .data = &eqc_eyeq5_match_data },
+	{ .compatible = "mobileye,eyeq6l-clk", .data = &eqc_eyeq6l_match_data },
+	{ .compatible = "mobileye,eyeq6h-central-clk", .data = &eqc_eyeq6h_central_match_data },
+	{ .compatible = "mobileye,eyeq6h-west-clk", .data = &eqc_eyeq6h_west_match_data },
+	{ .compatible = "mobileye,eyeq6h-east-clk", .data = &eqc_eyeq6h_east_match_data },
+	{ .compatible = "mobileye,eyeq6h-south-clk", .data = &eqc_eyeq6h_south_match_data },
+	{ .compatible = "mobileye,eyeq6h-ddr0-clk", .data = &eqc_eyeq6h_ddr0_match_data },
+	{ .compatible = "mobileye,eyeq6h-ddr1-clk", .data = &eqc_eyeq6h_ddr1_match_data },
+	{ .compatible = "mobileye,eyeq6h-acc-clk", .data = &eqc_eyeq6h_acc_match_data },
+	{}
+};
+MODULE_DEVICE_TABLE(of, eqc_match_table);
+
+static struct platform_driver eqc_driver = {
+	.probe = eqc_probe,
+	.driver = {
+		.name = "clk-eyeq",
+		.of_match_table = eqc_match_table,
+	},
+};
+builtin_platform_driver(eqc_driver);
+
+static void __init eqc_init(struct device_node *np)
+{
+	const struct eqc_match_data *data;
+	unsigned int nb_clks = 0;
+	struct eqc_priv *priv;
+	unsigned int i;
+	int ret;
+
+	data = of_match_node(eqc_match_table, np)->data;
+
+	/* No reason to early init this clock provider. Do it at probe. */
+	if (data->early_pll_count == 0)
+		return;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	priv->np = np;
+	priv->data = data;
+
+	nb_clks = eqc_compute_clock_count(data);
+	priv->cells = kzalloc(struct_size(priv->cells, hws, nb_clks), GFP_KERNEL);
+	if (!priv->cells) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	priv->cells->num = nb_clks;
+
+	/*
+	 * Mark non-early clocks as deferred; they'll be registered at platform
+	 * device probe.
+	 */
+	for (i = 0; i < data->pll_count; i++)
+		priv->cells->hws[data->plls[i].index] = ERR_PTR(-EPROBE_DEFER);
+	for (i = 0; i < data->div_count; i++)
+		priv->cells->hws[data->divs[i].index] = ERR_PTR(-EPROBE_DEFER);
+
+	/*
+	 * We expect named resources if divider clocks are present.
+	 * Else, we only expect one resource.
+	 */
+	if (data->div_count)
+		ret = of_property_match_string(np, "reg-names", "plls");
+	else
+		ret = 0;
+	if (ret < 0)
+		goto err;
+
+	priv->base_plls = of_iomap(np, ret);
+	if (!priv->base_plls) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	for (i = 0; i < data->early_pll_count; i++) {
+		const struct eqc_pll *pll = &data->early_plls[i];
+		unsigned long mult, div, acc;
+		struct clk_hw *hw;
+		u32 r0, r1;
+		u64 val;
+
+		val = readq(priv->base_plls + pll->reg64);
+		r0 = val;
+		r1 = val >> 32;
+
+		ret = eqc_pll_parse_registers(r0, r1, &mult, &div, &acc);
+		if (ret) {
+			pr_err("failed parsing state of %s\n", pll->name);
+			goto err;
+		}
+
+		hw = clk_hw_register_fixed_factor_with_accuracy_fwname(NULL,
+				np, pll->name, "ref", 0, mult, div, acc);
+		priv->cells->hws[pll->index] = hw;
+		if (IS_ERR(hw)) {
+			pr_err("failed registering %s: %pe\n", pll->name, hw);
+			ret = PTR_ERR(hw);
+			goto err;
+		}
+	}
+
+	/* When providing a single clock, require no cell. */
+	if (nb_clks == 1)
+		ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, priv->cells->hws);
+	else
+		ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, priv->cells);
+	if (ret) {
+		pr_err("failed registering clk provider: %d\n", ret);
+		goto err;
+	}
+
+	spin_lock(&eqc_list_slock);
+	list_add_tail(&priv->list, &eqc_list);
+	spin_unlock(&eqc_list_slock);
+
+	return;
+
+err:
+	/*
+	 * We are doomed. The system will not be able to boot.
+	 *
+	 * Let's still try to be good citizens by freeing resources and print
+	 * a last error message that might help debugging.
+	 */
+
+	if (priv && priv->cells) {
+		of_clk_del_provider(np);
+
+		for (i = 0; i < data->early_pll_count; i++) {
+			const struct eqc_pll *pll = &data->early_plls[i];
+			struct clk_hw *hw = priv->cells->hws[pll->index];
+
+			if (!IS_ERR_OR_NULL(hw))
+				clk_hw_unregister_fixed_factor(hw);
+		}
+
+		kfree(priv->cells);
+	}
+
+	kfree(priv);
+
+	pr_err("failed clk init: %d\n", ret);
+}
+
+CLK_OF_DECLARE_DRIVER(eqc_eyeq5, "mobileye,eyeq5-clk", eqc_init);
+CLK_OF_DECLARE_DRIVER(eqc_eyeq6h_central, "mobileye,eyeq6h-central-clk", eqc_init);
+CLK_OF_DECLARE_DRIVER(eqc_eyeq6h_west, "mobileye,eyeq6h-west-clk", eqc_init);

-- 
2.44.0


