Return-Path: <linux-kernel+bounces-35902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1F183989E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3BA288A24
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5751312BEAD;
	Tue, 23 Jan 2024 18:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EAdVLGtQ"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CF5823B6;
	Tue, 23 Jan 2024 18:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035634; cv=none; b=sBZTqcP5B2HuF/BnZFAVANXVEhXvr6zFr0zJ0kB48ZLAQtmiaAYNQwIGhUIFdooq+uGFTXqnjxmpjfu6gsLCfenOCyI80RjX9TeqZr7hdI3nTOIbycyhR+491Z3Pwr3nnQWr1KCHUzuE5t8TV+59YxRIRIsGQoUTsZVamvaKW7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035634; c=relaxed/simple;
	bh=lrlfW6P8+nnr7Vb4eIZh44sDhNKfAZ2uiq0VLEkYi6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LR+7Tb6nGuzrIRli0i808PNZxuYgimWXFtUTxhmfLqBtkA1PvDVXCa6tORM0l4QlFYlzx4onpRsYfH3eA1j0bd1kdCo3s5zmc+kwFR/8YE8/4FZa62D23nOPAEYmjF/5lxdyrtvRJrsSc0J0LTCwdoc4z15P+RzxVElXGfD8oFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EAdVLGtQ; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 37EFAC000D;
	Tue, 23 Jan 2024 18:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706035629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j6vdXTz6q1AE5aHZA1n5hZRYgrR1vbjLA1zvfxUbjoA=;
	b=EAdVLGtQj0F9hFuiz1QiLaFXudfKra+CgoktuU1lEDJ8khw32qoFDK93J7cZr6SlWgtNX5
	IqV71vYYNDBvIVL278R/gLjXHy0MH6NtGGwXMP+SZePyvdOTubSUve9ETZlWYBsISuD0D+
	wZCI4k7PRGjuKO5Fenyq952NYqsawZ+3D65Oh4n82CnxD+Invy5SFWJCjvt3DrMnP4gw0U
	mh3MzLw3epLdkQKvu71IsMDAQVc1mOcMki4Je69fbxlRBC7TLMQCxQjNTJ3Wcr8eWh2YBJ
	RPAoWSVMiLMbzfapMlHx0tglSTCiFLV7T7Ug7yHcgmwGp9C20vPDW620LO1wIQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 23 Jan 2024 19:46:54 +0100
Subject: [PATCH v3 09/17] reset: eyeq5: add platform driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240123-mbly-clk-v3-9-392b010b8281@bootlin.com>
References: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
In-Reply-To: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, linux-gpio@vger.kernel.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

Add the Mobileye EyeQ5 reset controller driver. It belongs to a syscon
region called OLB. It might grow to add later support of other
platforms from Mobileye.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 MAINTAINERS                 |   1 +
 drivers/reset/Kconfig       |  12 ++
 drivers/reset/Makefile      |   1 +
 drivers/reset/reset-eyeq5.c | 383 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 397 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3ea96ab7d2b8..dd3b5834386f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14794,6 +14794,7 @@ F:	arch/mips/boot/dts/mobileye/
 F:	arch/mips/configs/eyeq5_defconfig
 F:	arch/mips/mobileye/board-epm5.its.S
 F:	drivers/clk/clk-eyeq5.c
+F:	drivers/reset/reset-eyeq5.c
 F:	include/dt-bindings/clock/mobileye,eyeq5-clk.h
 F:	include/dt-bindings/soc/mobileye,eyeq5.h
 
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index ccd59ddd7610..80bfde54c076 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -66,6 +66,18 @@ config RESET_BRCMSTB_RESCAL
 	  This enables the RESCAL reset controller for SATA, PCIe0, or PCIe1 on
 	  BCM7216.
 
+config RESET_EYEQ5
+	bool "Mobileye EyeQ5 reset controller"
+	depends on MFD_SYSCON
+	depends on MACH_EYEQ5 || COMPILE_TEST
+	default MACH_EYEQ5
+	help
+	  This enables the Mobileye EyeQ5 reset controller.
+
+	  It has three domains, with a varying number of resets in each of them.
+	  Registers are located in a shared register region called OLB accessed
+	  through a syscon & regmap.
+
 config RESET_HSDK
 	bool "Synopsys HSDK Reset Driver"
 	depends on HAS_IOMEM
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 8270da8a4baa..4fabe0070390 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_RESET_BCM6345) += reset-bcm6345.o
 obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
 obj-$(CONFIG_RESET_BRCMSTB) += reset-brcmstb.o
 obj-$(CONFIG_RESET_BRCMSTB_RESCAL) += reset-brcmstb-rescal.o
+obj-$(CONFIG_RESET_EYEQ5) += reset-eyeq5.o
 obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
 obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
 obj-$(CONFIG_RESET_INTEL_GW) += reset-intel-gw.o
diff --git a/drivers/reset/reset-eyeq5.c b/drivers/reset/reset-eyeq5.c
new file mode 100644
index 000000000000..2217e42e140b
--- /dev/null
+++ b/drivers/reset/reset-eyeq5.c
@@ -0,0 +1,383 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Reset driver for the Mobileye EyeQ5 platform.
+ *
+ * The registers are located in a syscon region called OLB. We handle three
+ * reset domains. Domains 0 and 2 look similar in that they both use one bit
+ * per reset line. Domain 1 has a register per reset.
+ *
+ * We busy-wait after updating a reset in domains 0 or 1. The reason is hardware
+ * logic built-in self-test (LBIST) that might be enabled.
+ *
+ * We use eq5r_ as prefix, as-in "EyeQ5 Reset", but way shorter.
+ *
+ * Known resets in domain 0:
+ *  3. CAN0
+ *  4. CAN1
+ *  5. CAN2
+ *  6. SPI0
+ *  7. SPI1
+ *  8. SPI2
+ *  9. SPI3
+ * 10. UART0
+ * 11. UART1
+ * 12. UART2
+ * 13. I2C0
+ * 14. I2C1
+ * 15. I2C2
+ * 16. I2C3
+ * 17. I2C4
+ * 18. TIMER0
+ * 19. TIMER1
+ * 20. TIMER2
+ * 21. TIMER3
+ * 22. TIMER4
+ * 23. WD0
+ * 24. EXT0
+ * 25. EXT1
+ * 26. GPIO
+ * 27. WD1
+ *
+ * Known resets in domain 1:
+ * 0. VMP0	(Vector Microcode Processors)
+ * 1. VMP1
+ * 2. VMP2
+ * 3. VMP3
+ * 4. PMA0	(Programmable Macro Array)
+ * 5. PMA1
+ * 6. PMAC0
+ * 7. PMAC1
+ * 8. MPC0	(Multi-threaded Processing Clusters)
+ * 9. MPC1
+ *
+ * Known resets in domain 2:
+ *  0. PCIE0_CORE
+ *  1. PCIE0_APB
+ *  2. PCIE0_LINK_AXI
+ *  3. PCIE0_LINK_MGMT
+ *  4. PCIE0_LINK_HOT
+ *  5. PCIE0_LINK_PIPE
+ *  6. PCIE1_CORE
+ *  7. PCIE1_APB
+ *  8. PCIE1_LINK_AXI
+ *  9. PCIE1_LINK_MGMT
+ * 10. PCIE1_LINK_HOT
+ * 11. PCIE1_LINK_PIPE
+ * 12. MULTIPHY
+ * 13. MULTIPHY_APB
+ * 15. PCIE0_LINK_MGMT
+ * 16. PCIE1_LINK_MGMT
+ * 17. PCIE0_LINK_PM
+ * 18. PCIE1_LINK_PM
+ *
+ * Copyright (C) 2024 Mobileye Vision Technologies Ltd.
+ */
+
+#include <linux/mfd/syscon.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+
+/* Offsets into the OLB region as well as masks for domain 1 registers. */
+#define EQ5R_OLB_SARCR0			(0x004)
+#define EQ5R_OLB_SARCR1			(0x008)
+#define EQ5R_OLB_PCIE_GP		(0x120)
+#define EQ5R_OLB_ACRP_REG(n)		(0x200 + 4 * (n)) // n=0..12
+#define EQ5R_OLB_ACRP_PD_REQ		BIT(0)
+#define EQ5R_OLB_ACRP_ST_POWER_DOWN	BIT(27)
+#define EQ5R_OLB_ACRP_ST_ACTIVE		BIT(29)
+
+/* Vendor-provided values. D1 has a long timeout because of LBIST. */
+#define D0_TIMEOUT_POLL			10
+#define D1_TIMEOUT_POLL			40000
+
+/*
+ * Masks for valid reset lines in each domain. This array is also used to get
+ * the domain and reset counts.
+ */
+static const u32 eq5r_valid_masks[] = { 0x0FFFFFF8, 0x00001FFF, 0x0007BFFF };
+
+#define EQ5R_DOMAIN_COUNT ARRAY_SIZE(eq5r_valid_masks)
+
+struct eq5r_private {
+	struct mutex mutexes[EQ5R_DOMAIN_COUNT]; /* We serialize all reset operations. */
+	struct regmap *olb;			 /* Writes go to a syscon regmap. */
+	struct reset_controller_dev rcdev;
+};
+
+static int _eq5r_busy_wait(struct eq5r_private *priv, struct device *dev,
+			   u32 domain, u32 offset, bool assert)
+{
+	unsigned int val, mask;
+	int i;
+
+	lockdep_assert_held(&priv->mutexes[domain]);
+
+	switch (domain) {
+	case 0:
+		for (i = 0; i < D0_TIMEOUT_POLL; i++) {
+			regmap_read(priv->olb, EQ5R_OLB_SARCR1, &val);
+			val = !(val & BIT(offset));
+			if (val == assert)
+				return 0;
+			__udelay(1);
+		}
+		break;
+	case 1:
+		mask = assert ? EQ5R_OLB_ACRP_ST_POWER_DOWN : EQ5R_OLB_ACRP_ST_ACTIVE;
+		for (i = 0; i < D1_TIMEOUT_POLL; i++) {
+			regmap_read(priv->olb, EQ5R_OLB_ACRP_REG(offset), &val);
+			if (val & mask)
+				return 0;
+			__udelay(1);
+		}
+		break;
+	case 2:
+		return 0; /* No busy waiting for domain 2. */
+	default:
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "%u-%u: timeout\n", domain, offset);
+	return -ETIMEDOUT;
+}
+
+static void _eq5r_assert(struct eq5r_private *priv, u32 domain, u32 offset)
+{
+	lockdep_assert_held(&priv->mutexes[domain]);
+
+	switch (domain) {
+	case 0:
+		regmap_clear_bits(priv->olb, EQ5R_OLB_SARCR0, BIT(offset));
+		break;
+	case 1:
+		regmap_set_bits(priv->olb, EQ5R_OLB_ACRP_REG(offset),
+				EQ5R_OLB_ACRP_PD_REQ);
+		break;
+	case 2:
+		regmap_clear_bits(priv->olb, EQ5R_OLB_PCIE_GP, BIT(offset));
+		break;
+	default:
+		WARN_ON(1);
+	}
+}
+
+static int eq5r_assert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	struct eq5r_private *priv = dev_get_drvdata(rcdev->dev);
+	u32 offset = id & GENMASK(7, 0);
+	u32 domain = id >> 8;
+	int ret;
+
+	if (WARN_ON(domain >= EQ5R_DOMAIN_COUNT))
+		return -EINVAL;
+
+	dev_dbg(rcdev->dev, "%u-%u: assert request\n", domain, offset);
+
+	mutex_lock(&priv->mutexes[domain]);
+	_eq5r_assert(priv, domain, offset);
+	ret = _eq5r_busy_wait(priv, rcdev->dev, domain, offset, true);
+	mutex_unlock(&priv->mutexes[domain]);
+
+	return ret;
+}
+
+static void _eq5r_deassert(struct eq5r_private *priv, u32 domain, u32 offset)
+{
+	lockdep_assert_held(&priv->mutexes[domain]);
+
+	switch (domain) {
+	case 0:
+		regmap_set_bits(priv->olb, EQ5R_OLB_SARCR0, BIT(offset));
+		break;
+	case 1:
+		regmap_clear_bits(priv->olb, EQ5R_OLB_ACRP_REG(offset),
+				  EQ5R_OLB_ACRP_PD_REQ);
+		break;
+	case 2:
+		regmap_set_bits(priv->olb, EQ5R_OLB_PCIE_GP, BIT(offset));
+		break;
+	default:
+		WARN_ON(1);
+	}
+}
+
+static int eq5r_deassert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	struct eq5r_private *priv = dev_get_drvdata(rcdev->dev);
+	u32 offset = id & GENMASK(7, 0);
+	u32 domain = id >> 8;
+	int ret;
+
+	if (WARN_ON(domain >= EQ5R_DOMAIN_COUNT))
+		return -EINVAL;
+
+	dev_dbg(rcdev->dev, "%u-%u: deassert request\n", domain, offset);
+
+	mutex_lock(&priv->mutexes[domain]);
+	_eq5r_deassert(priv, domain, offset);
+	ret = _eq5r_busy_wait(priv, rcdev->dev, domain, offset, false);
+	mutex_unlock(&priv->mutexes[domain]);
+
+	return ret;
+}
+
+static int eq5r_reset(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	struct device *dev = rcdev->dev;
+	struct eq5r_private *priv = dev_get_drvdata(dev);
+	u32 offset = id & GENMASK(7, 0);
+	u32 domain = id >> 8;
+	int ret;
+
+	if (WARN_ON(domain >= EQ5R_DOMAIN_COUNT))
+		return -EINVAL;
+
+	dev_dbg(dev, "%u-%u: reset request\n", domain, offset);
+
+	mutex_lock(&priv->mutexes[domain]);
+
+	_eq5r_assert(priv, domain, offset);
+	ret = _eq5r_busy_wait(priv, dev, domain, offset, true);
+	if (ret) /* don't let an error disappear silently */
+		dev_warn(dev, "%u-%u: reset assert failed: %d\n",
+			 domain, offset, ret);
+
+	_eq5r_deassert(priv, domain, offset);
+	ret = _eq5r_busy_wait(priv, dev, domain, offset, false);
+
+	mutex_unlock(&priv->mutexes[domain]);
+
+	return ret;
+}
+
+static int eq5r_status(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	struct eq5r_private *priv = dev_get_drvdata(rcdev->dev);
+	u32 offset = id & GENMASK(7, 0);
+	u32 domain = id >> 8;
+	unsigned int val;
+	int ret;
+
+	if (WARN_ON(domain >= EQ5R_DOMAIN_COUNT))
+		return -EINVAL;
+
+	dev_dbg(rcdev->dev, "%u-%u: status request\n", domain, offset);
+
+	mutex_lock(&priv->mutexes[domain]);
+
+	switch (domain) {
+	case 0:
+		regmap_read(priv->olb, EQ5R_OLB_SARCR1, &val);
+		ret = !(val & BIT(offset));
+		break;
+	case 1:
+		regmap_read(priv->olb, EQ5R_OLB_ACRP_REG(offset), &val);
+		ret = !(val & EQ5R_OLB_ACRP_ST_ACTIVE);
+		break;
+	case 2:
+		regmap_read(priv->olb, EQ5R_OLB_PCIE_GP, &val);
+		ret = !(val & BIT(offset));
+		break;
+	}
+
+	mutex_unlock(&priv->mutexes[domain]);
+
+	return ret;
+}
+
+static const struct reset_control_ops eq5r_ops = {
+	.reset	  = eq5r_reset,
+	.assert	  = eq5r_assert,
+	.deassert = eq5r_deassert,
+	.status	  = eq5r_status,
+};
+
+static int eq5r_of_xlate(struct reset_controller_dev *rcdev,
+			 const struct of_phandle_args *reset_spec)
+{
+	u32 domain, offset;
+
+	if (WARN_ON(reset_spec->args_count != 2))
+		return -EINVAL;
+
+	domain = reset_spec->args[0];
+	offset = reset_spec->args[1];
+
+	if (domain >= EQ5R_DOMAIN_COUNT || offset > 31 ||
+	    !(eq5r_valid_masks[domain] & BIT(offset))) {
+		dev_err(rcdev->dev, "%u-%u: invalid reset\n", domain, offset);
+		return -EINVAL;
+	}
+
+	return (domain << 8) | offset;
+}
+
+static int eq5r_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct device_node *parent_np = of_get_parent(np);
+	struct eq5r_private *priv;
+	int ret, i;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, priv);
+
+	priv->olb = ERR_PTR(-ENODEV);
+	if (parent_np) {
+		priv->olb = syscon_node_to_regmap(parent_np);
+		of_node_put(parent_np);
+	}
+	if (IS_ERR(priv->olb))
+		return PTR_ERR(priv->olb);
+
+	for (i = 0; i < EQ5R_DOMAIN_COUNT; i++)
+		mutex_init(&priv->mutexes[i]);
+
+	priv->rcdev.ops = &eq5r_ops;
+	priv->rcdev.owner = THIS_MODULE;
+	priv->rcdev.dev = dev;
+	priv->rcdev.of_node = np;
+	priv->rcdev.of_reset_n_cells = 2;
+	priv->rcdev.of_xlate = eq5r_of_xlate;
+
+	priv->rcdev.nr_resets = 0;
+	for (i = 0; i < EQ5R_DOMAIN_COUNT; i++)
+		priv->rcdev.nr_resets += __builtin_popcount(eq5r_valid_masks[i]);
+
+	ret = reset_controller_register(&priv->rcdev);
+	if (ret) {
+		dev_err(dev, "Failed registering reset controller: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id eq5r_match_table[] = {
+	{ .compatible = "mobileye,eyeq5-reset" },
+	{}
+};
+
+static struct platform_driver eq5r_driver = {
+	.probe = eq5r_probe,
+	.driver = {
+		.name = "eyeq5-reset",
+		.of_match_table = eq5r_match_table,
+	},
+};
+
+static int __init eq5r_init(void)
+{
+	return platform_driver_register(&eq5r_driver);
+}
+
+arch_initcall(eq5r_init);

-- 
2.43.0


