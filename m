Return-Path: <linux-kernel+bounces-4135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FC281784D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E7B1C21EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD2E5D744;
	Mon, 18 Dec 2023 17:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ksBSCS5u"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEF5498A4;
	Mon, 18 Dec 2023 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5913C1BF20E;
	Mon, 18 Dec 2023 17:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702919667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLCeBmhS+A36p5SaThMS9I6nY4Sh4aae8o6vMqQL64M=;
	b=ksBSCS5u+3vF8TtREfkkpg0gOZmy1BtceD5LNmJB0PwEHiGjfsA2EEjjREglOqeI7xmvWA
	pYyE9m/nN1+zV4JS/ho/Dg5DJihLqOdosqUTdjSUnQ3CGiRC8+JtY/bTXwxaQ3YVLtJfrM
	sWYQopcUU2KR3Sg0DUIoao9m69Mb702/ZdWI4pNLXDMddVt7dOoBnpDY9UBxIGg3HacSUB
	d0vpQm2IMWejByfRZM6OdufJEEu4JdRXFoXz3320QvL81GLOfLQ3FVJV3nhS9HqMWKXlRI
	lsKuqsU48SErG7ZNqyLcsghU2jKEdp6lxc4v6kRXS/dqNsm3HCI9VhkvNVwX0A==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Mon, 18 Dec 2023 18:14:18 +0100
Subject: [PATCH 3/5] clk: eyeq5: add controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231218-mbly-clk-v1-3-44ce54108f06@bootlin.com>
References: <20231218-mbly-clk-v1-0-44ce54108f06@bootlin.com>
In-Reply-To: <20231218-mbly-clk-v1-0-44ce54108f06@bootlin.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

Add the Mobileye EyeQ5 clock controller driver. See the header comment
for more information on how it works. This driver is specific to this
platform; it might grow to add later support of other platforms from
Mobileye.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 MAINTAINERS             |   1 +
 drivers/clk/Kconfig     |  11 +++
 drivers/clk/Makefile    |   1 +
 drivers/clk/clk-eyeq5.c | 211 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 224 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f04fa760a4d..c75c7de1d507 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14557,6 +14557,7 @@ F:	Documentation/devicetree/bindings/mips/mobileye.yaml
 F:	arch/mips/boot/dts/mobileye/
 F:	arch/mips/configs/generic/board-eyeq5.config
 F:	arch/mips/generic/board-epm5.its.S
+F:	drivers/clk/clk-eyeq5.c
 F:	include/dt-bindings/clock/mobileye,eyeq5-clk.h
 F:	include/dt-bindings/soc/mobileye,eyeq5.h
 
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index c30d0d396f7a..84fe0a89b8df 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -218,6 +218,17 @@ config COMMON_CLK_EN7523
 	  This driver provides the fixed clocks and gates present on Airoha
 	  ARM silicon.
 
+config COMMON_CLK_EYEQ5
+	bool "Clock driver for the Mobileye EyeQ5 platform"
+	depends on OF
+	depends on SOC_EYEQ5 || COMPILE_TEST
+	default SOC_EYEQ5
+	help
+		This drivers provides the fixed clocks found on the Mobileye EyeQ5
+		SoC. Its registers live in a shared register region called OLB.
+		It provides 10 read-only PLLs derived from the main crystal clock which
+		must be constant.
+
 config COMMON_CLK_FSL_FLEXSPI
 	tristate "Clock driver for FlexSPI on Layerscape SoCs"
 	depends on ARCH_LAYERSCAPE || COMPILE_TEST
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index ed71f2e0ee36..0df0dc6dbcae 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_ARCH_CLPS711X)		+= clk-clps711x.o
 obj-$(CONFIG_COMMON_CLK_CS2000_CP)	+= clk-cs2000-cp.o
 obj-$(CONFIG_ARCH_SPARX5)		+= clk-sparx5.o
 obj-$(CONFIG_COMMON_CLK_EN7523)		+= clk-en7523.o
+obj-$(CONFIG_COMMON_CLK_EYEQ5)		+= clk-eyeq5.o
 obj-$(CONFIG_COMMON_CLK_FIXED_MMIO)	+= clk-fixed-mmio.o
 obj-$(CONFIG_COMMON_CLK_FSL_FLEXSPI)	+= clk-fsl-flexspi.o
 obj-$(CONFIG_COMMON_CLK_FSL_SAI)	+= clk-fsl-sai.o
diff --git a/drivers/clk/clk-eyeq5.c b/drivers/clk/clk-eyeq5.c
new file mode 100644
index 000000000000..74bcb8cec5c1
--- /dev/null
+++ b/drivers/clk/clk-eyeq5.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PLL clock driver for the Mobileye EyeQ5 platform.
+ *
+ * This controller handles 10 read-only PLLs, all derived from the same main
+ * crystal clock. The parent clock is expected to be constant. This driver is
+ * custom to this platform, its registers live in a shared region called OLB.
+ *
+ * We use eq5c_ as prefix, as-in "EyeQ5 Clock", but way shorter.
+ *
+ * Copyright (C) 2023 Mobileye Vision Technologies Ltd.
+ */
+#include <linux/bits.h>
+#include <linux/clk-provider.h>
+#include <linux/clk.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/mobileye,eyeq5-clk.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt) "%s: " fmt, __func__
+
+/*
+ * PLL control & status registers, n=0..1
+ * 0x02c..0x078
+ */
+#define OLB_PCSR_CPU(n)				(0x02C + (n) * 4) /* CPU */
+#define OLB_PCSR_VMP(n)				(0x034 + (n) * 4) /* VMP */
+#define OLB_PCSR_PMA(n)				(0x03C + (n) * 4) /* PMA */
+#define OLB_PCSR_VDI(n)				(0x044 + (n) * 4) /* VDI */
+#define OLB_PCSR_DDR0(n)			(0x04C + (n) * 4) /* DDR0 */
+#define OLB_PCSR_PCI(n)				(0x054 + (n) * 4) /* PCI */
+#define OLB_PCSR_PER(n)				(0x05C + (n) * 4) /* PER */
+#define OLB_PCSR_PMAC(n)			(0x064 + (n) * 4) /* PMAC */
+#define OLB_PCSR_MPC(n)				(0x06c + (n) * 4) /* MPC */
+#define OLB_PCSR_DDR1(n)			(0x074 + (n) * 4) /* DDR1 */
+
+/* In frac mode, it enables fractional noise canceling DAC. Else, no function. */
+#define OLB_PCSR0_DAC_EN			BIT(0)
+/* Fractional or integer mode */
+#define OLB_PCSR0_DSM_EN			BIT(1)
+#define OLB_PCSR0_PLL_EN			BIT(2)
+/* All clocks output held at 0 */
+#define OLB_PCSR0_FOUTPOSTDIV_EN		BIT(3)
+#define OLB_PCSR0_POST_DIV1			GENMASK(6, 4)
+#define OLB_PCSR0_POST_DIV2			GENMASK(9, 7)
+#define OLB_PCSR0_REF_DIV			GENMASK(15, 10)
+#define OLB_PCSR0_INTIN				GENMASK(27, 16)
+#define OLB_PCSR0_BYPASS			BIT(28)
+/* Bits 30..29 are reserved */
+#define OLB_PCSR0_PLL_LOCKED			BIT(31)
+
+#define OLB_PCSR1_RESET				BIT(0)
+#define OLB_PCSR1_SSGC_DIV			GENMASK(4, 1)
+/* Spread amplitude (% = 0.1 * SPREAD[4:0]) */
+#define OLB_PCSR1_SPREAD			GENMASK(9, 5)
+#define OLB_PCSR1_DIS_SSCG			BIT(10)
+/* Down-spread or center-spread */
+#define OLB_PCSR1_DOWN_SPREAD			BIT(11)
+#define OLB_PCSR1_FRAC_IN			GENMASK(31, 12)
+
+static const struct eq5c_pll {
+	const char *name;
+	u32 reg;
+} eq5c_plls[] = {
+	[EQ5C_PLL_CPU] =  { .name = "pll-cpu",  .reg = OLB_PCSR_CPU(0),  },
+	[EQ5C_PLL_VMP] =  { .name = "pll-vmp",  .reg = OLB_PCSR_VMP(0),  },
+	[EQ5C_PLL_PMA] =  { .name = "pll-pma",  .reg = OLB_PCSR_PMA(0),  },
+	[EQ5C_PLL_VDI] =  { .name = "pll-vdi",  .reg = OLB_PCSR_VDI(0),  },
+	[EQ5C_PLL_DDR0] = { .name = "pll-ddr0", .reg = OLB_PCSR_DDR0(0), },
+	[EQ5C_PLL_PCI] =  { .name = "pll-pci",  .reg = OLB_PCSR_PCI(0),  },
+	[EQ5C_PLL_PER] =  { .name = "pll-per",  .reg = OLB_PCSR_PER(0),  },
+	[EQ5C_PLL_PMAC] = { .name = "pll-pmac", .reg = OLB_PCSR_PMAC(0), },
+	[EQ5C_PLL_MPC] =  { .name = "pll-mpc",  .reg = OLB_PCSR_MPC(0),  },
+	[EQ5C_PLL_DDR1] = { .name = "pll-ddr1", .reg = OLB_PCSR_DDR1(0), },
+};
+
+static int eq5c_pll_parse_registers(u32 r0, u32 r1, unsigned long *mult,
+				    unsigned long *div, unsigned long *acc)
+{
+	if (!mult || !div || !acc)
+		return -EINVAL;
+
+	if (r0 & OLB_PCSR0_BYPASS) {
+		*mult = 1;
+		*div = 1;
+		*acc = 0;
+		return 0;
+	}
+
+	if (!(r0 & OLB_PCSR0_PLL_LOCKED))
+		return -EINVAL;
+
+	*mult = FIELD_GET(OLB_PCSR0_INTIN, r0);
+	*div = FIELD_GET(OLB_PCSR0_REF_DIV, r0);
+	if (r0 & OLB_PCSR0_FOUTPOSTDIV_EN)
+		*div *= FIELD_GET(OLB_PCSR0_POST_DIV1, r0) *
+			FIELD_GET(OLB_PCSR0_POST_DIV2, r0);
+
+	/* Fractional mode, in 2^20 (0x100000) parts. */
+	if (r0 & OLB_PCSR0_DSM_EN) {
+		*div *= 0x100000;
+		*mult = *mult * 0x100000 + FIELD_GET(OLB_PCSR1_FRAC_IN, r1);
+	}
+
+	if (!*mult || !*div)
+		return -EINVAL;
+
+	/* Spread spectrum. */
+	if (!(r1 & (OLB_PCSR1_RESET | OLB_PCSR1_DIS_SSCG))) {
+		/*
+		 * Spread is 1/1000 parts of frequency, accuracy is half of
+		 * that. To get accuracy, convert to ppb (parts per billion).
+		 */
+		u32 spread = FIELD_GET(OLB_PCSR1_SPREAD, r1);
+		*acc = spread * 500000;
+		if (r1 & OLB_PCSR1_DOWN_SPREAD) {
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
+static void eq5c_init(struct device_node *np)
+{
+	struct device_node *parent_np = of_get_parent(np);
+	struct clk_hw_onecell_data *data;
+	unsigned long parent_clk_rate;
+	struct clk_hw *parent_clk_hw;
+	struct clk *parent_clk;
+	struct regmap *olb;
+	int i;
+
+	data = kzalloc(struct_size(data, hws, ARRAY_SIZE(eq5c_plls)), GFP_KERNEL);
+	if (!data)
+		return;
+
+	data->num = ARRAY_SIZE(eq5c_plls);
+
+	/*
+	 * TODO: currently, if OLB is not available, we log an error and early
+	 * return. We might want to change this behavior and assume all clocks
+	 * are in bypass mode; that is what is being done in the vendor driver.
+	 *
+	 * It is still unclear if there are valid situations where the OLB
+	 * region would be inaccessible.
+	 */
+	olb = ERR_PTR(-ENODEV);
+	if (parent_np)
+		olb = syscon_node_to_regmap(parent_np);
+	if (IS_ERR(olb))
+		olb = syscon_regmap_lookup_by_phandle(np, "mobileye,olb");
+	if (IS_ERR(olb)) {
+		pr_err("failed getting regmap: %ld\n", PTR_ERR(olb));
+		return;
+	}
+
+	parent_clk = of_clk_get_by_name(np, "ref");
+	if (IS_ERR_OR_NULL(parent_clk)) {
+		pr_err("no parent clock found\n");
+		return;
+	}
+	parent_clk_hw = __clk_get_hw(parent_clk);
+	parent_clk_rate = clk_get_rate(parent_clk);
+	clk_put(parent_clk);
+
+	for (i = 0; i < ARRAY_SIZE(eq5c_plls); i++) {
+		const struct eq5c_pll *pll = &eq5c_plls[i];
+		unsigned long mult, div, acc;
+		u32 r0, r1;
+		int ret;
+
+		regmap_read(olb, pll->reg, &r0);
+		regmap_read(olb, pll->reg + sizeof(r0), &r1);
+
+		ret = eq5c_pll_parse_registers(r0, r1, &mult, &div, &acc);
+		if (ret) {
+			pr_warn("failed parsing state of %s\n", pll->name);
+			continue;
+		}
+
+		/* We use fixed_rate and not fixed_factor because the latter
+		 * does not allow reporting accuracy. The alternative is to
+		 * create a custom clk implementation but that adds too many
+		 * lines to the kernel for not much benefit; our parent clock
+		 * rate won't change anyway.
+		 */
+		data->hws[i] = clk_hw_register_fixed_rate_with_accuracy_parent_hw(
+				NULL, pll->name, parent_clk_hw, 0,
+				parent_clk_rate * mult / div, acc);
+		if (IS_ERR_OR_NULL(data->hws[i])) {
+			pr_err("failed registering %s: %ld\n",
+			       pll->name, PTR_ERR(data->hws[i]));
+			data->hws[i] = ERR_PTR(-ENOENT);
+		}
+	}
+
+	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, data);
+}
+
+CLK_OF_DECLARE_DRIVER(eq5c, "mobileye,eyeq5-clk", eq5c_init);

-- 
2.43.0


