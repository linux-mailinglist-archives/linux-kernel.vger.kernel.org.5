Return-Path: <linux-kernel+bounces-163566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE218B6D37
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 595DC1F21529
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD2A1BF6D7;
	Tue, 30 Apr 2024 08:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ysu7qESt"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E4A1C0DC7;
	Tue, 30 Apr 2024 08:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466379; cv=none; b=YwHa1slgbI40Unkz9RVrkPM1+C+FDrNXGq/kJnhk5K4tvpf5DyyXyy7UrmG3evdxBOUsU0bDB9rqQxh8q9yTC5hYXBSD72TJn5+Cuy+bx0Y5iBgi8kRu+SV4x7RIm8LEieBGtg84iXkDoaBM6B10OFhYK+9OtvqykyIF/cl0hR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466379; c=relaxed/simple;
	bh=nliaHWA/NMStS5UotZ7BKISP29iSI3mDU9pVVa55xuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kjcjTxXrtAyeohkIiayN/9uB/GYsUKhnccoXMQVI78HHldef0aTQDATebYQ3klUBSLGVZ5aA4yNErw94DCawpWAUCZVC5tCEXDHGB5x5cOe6PY8gO6nu9BdZvgC74zASQcIrlddaR2jx2rkRARWfYzriUqewDH6d/nFmWbpPQzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ysu7qESt; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id CA7AC2000B;
	Tue, 30 Apr 2024 08:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714466375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1x6u+GMy96SLnvHnPDRb/JeS/VQcZwMT1qoZIOF3XQc=;
	b=Ysu7qEStKewqPlfDKZxeb4N/jgwYmmGV23M+nB1ssvvXEtpld6bg0vA+QtO27Wg21aV2kI
	ndlDkh2GU7qiEFqM5oL8iDq/OWcIwvP1CikwguzY9+pb8ewrumTcdw9ryr7eRqYNOqKwT0
	iFiaupFzyYk0He0UThVMkWQsk3hYRmFo02yrvUkz28w3mbUnAu3BJKi5Bf8jE+m2AFegVC
	oiyPIR4xmhmtjIBXsXRmQYTXYTb+E1ryajRVJml+HHNVA/dCW7Q8Gn4B9xHx/Oufipv7Ba
	pksW2xIiJ9cg8ytIia9f1zFyfLDjcvY2PWr2YFqvn/fjdJI/+vxC/0I0DSxXYA==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lee Jones <lee@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 16/17] mfd: Add support for LAN966x PCI device
Date: Tue, 30 Apr 2024 10:37:25 +0200
Message-ID: <20240430083730.134918-17-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430083730.134918-1-herve.codina@bootlin.com>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Add a PCI driver that handles the LAN966x PCI device using a device-tree
overlay. This overlay is applied to the PCI device DT node and allows to
describe components that are present in the device.

The memory from the device-tree is remapped to the BAR memory thanks to
"ranges" properties computed at runtime by the PCI core during the PCI
enumeration.
The PCI device itself acts as an interrupt controller and is used as the
parent of the internal LAN966x interrupt controller to route the
interrupts to the assigned PCI INTx interrupt.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/mfd/Kconfig          |  24 ++++
 drivers/mfd/Makefile         |   4 +
 drivers/mfd/lan966x_pci.c    | 229 +++++++++++++++++++++++++++++++++++
 drivers/mfd/lan966x_pci.dtso | 167 +++++++++++++++++++++++++
 drivers/pci/quirks.c         |   1 +
 5 files changed, 425 insertions(+)
 create mode 100644 drivers/mfd/lan966x_pci.c
 create mode 100644 drivers/mfd/lan966x_pci.dtso

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 4b023ee229cf..e5f5d2986dd3 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -144,6 +144,30 @@ config MFD_ATMEL_FLEXCOM
 	  by the probe function of this MFD driver according to a device tree
 	  property.
 
+config MFD_LAN966X_PCI
+	tristate "Microchip LAN966x PCIe Support"
+	depends on PCI
+	select OF
+	select OF_OVERLAY
+	select IRQ_DOMAIN
+	help
+	  This enables the support for the LAN966x PCIe device.
+	  This is used to drive the LAN966x PCIe device from the host system
+	  to which it is connected.
+
+	  This driver uses an overlay to load other drivers to support for
+	  LAN966x internal components.
+	  Even if this driver does not depend on these other drivers, in order
+	  to have a fully functional board, the following drivers are needed:
+	    - fixed-clock (COMMON_CLK)
+	    - lan966x-oic (LAN966X_OIC)
+	    - lan966x-cpu-syscon (MFD_SYSCON)
+	    - lan966x-switch-reset (RESET_MCHP_SPARX5)
+	    - lan966x-pinctrl (PINCTRL_OCELOT)
+	    - lan966x-serdes (PHY_LAN966X_SERDES)
+	    - lan966x-miim (MDIO_MSCC_MIIM)
+	    - lan966x-switch (LAN966X_SWITCH)
+
 config MFD_ATMEL_HLCDC
 	tristate "Atmel HLCDC (High-end LCD Controller)"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index c66f07edcd0e..165a9674ff48 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -284,3 +284,7 @@ rsmu-i2c-objs			:= rsmu_core.o rsmu_i2c.o
 rsmu-spi-objs			:= rsmu_core.o rsmu_spi.o
 obj-$(CONFIG_MFD_RSMU_I2C)	+= rsmu-i2c.o
 obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu-spi.o
+
+lan966x-pci-objs		:= lan966x_pci.o
+lan966x-pci-objs		+= lan966x_pci.dtbo.o
+obj-$(CONFIG_MFD_LAN966X_PCI)	+= lan966x-pci.o
diff --git a/drivers/mfd/lan966x_pci.c b/drivers/mfd/lan966x_pci.c
new file mode 100644
index 000000000000..d9d886a1948f
--- /dev/null
+++ b/drivers/mfd/lan966x_pci.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Microchip LAN966x PCI driver
+ *
+ * Copyright (c) 2024 Microchip Technology Inc. and its subsidiaries.
+ *
+ * Authors:
+ *	Clément Léger <clement.leger@bootlin.com>
+ *	Hervé Codina <herve.codina@bootlin.com>
+ */
+
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+
+/* Embedded dtbo symbols created by cmd_wrap_S_dtb in scripts/Makefile.lib */
+extern char __dtbo_lan966x_pci_begin[];
+extern char __dtbo_lan966x_pci_end[];
+
+struct pci_dev_intr_ctrl {
+	struct pci_dev *pci_dev;
+	struct irq_domain *irq_domain;
+	int irq;
+};
+
+static int pci_dev_irq_domain_map(struct irq_domain *d, unsigned int virq, irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(virq, &dummy_irq_chip, handle_simple_irq);
+	return 0;
+}
+
+static const struct irq_domain_ops pci_dev_irq_domain_ops = {
+	.map = pci_dev_irq_domain_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
+static irqreturn_t pci_dev_irq_handler(int irq, void *data)
+{
+	struct pci_dev_intr_ctrl *intr_ctrl = data;
+	int ret;
+
+	ret = generic_handle_domain_irq(intr_ctrl->irq_domain, 0);
+	return ret ? IRQ_NONE : IRQ_HANDLED;
+}
+
+static struct pci_dev_intr_ctrl *pci_dev_create_intr_ctrl(struct pci_dev *pdev)
+{
+	struct pci_dev_intr_ctrl *intr_ctrl;
+	struct fwnode_handle *fwnode;
+	int ret;
+
+	if (!pdev->irq)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	fwnode = dev_fwnode(&pdev->dev);
+	if (!fwnode)
+		return ERR_PTR(-ENODEV);
+
+	intr_ctrl = kmalloc(sizeof(*intr_ctrl), GFP_KERNEL);
+	if (!intr_ctrl)
+		return ERR_PTR(-ENOMEM);
+
+	intr_ctrl->pci_dev = pdev;
+
+	intr_ctrl->irq_domain = irq_domain_create_linear(fwnode, 1, &pci_dev_irq_domain_ops,
+							 intr_ctrl);
+	if (!intr_ctrl->irq_domain) {
+		pci_err(pdev, "Failed to create irqdomain\n");
+		ret = -ENOMEM;
+		goto err_free_intr_ctrl;
+	}
+
+	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_LEGACY);
+	if (ret < 0) {
+		pci_err(pdev, "Unable alloc irq vector (%d)\n", ret);
+		goto err_remove_domain;
+	}
+	intr_ctrl->irq = pci_irq_vector(pdev, 0);
+	ret = request_irq(intr_ctrl->irq, pci_dev_irq_handler, IRQF_SHARED,
+			  dev_name(&pdev->dev), intr_ctrl);
+	if (ret) {
+		pci_err(pdev, "Unable to request irq %d (%d)\n", intr_ctrl->irq, ret);
+		goto err_free_irq_vector;
+	}
+
+	return intr_ctrl;
+
+err_free_irq_vector:
+	pci_free_irq_vectors(pdev);
+err_remove_domain:
+	irq_domain_remove(intr_ctrl->irq_domain);
+err_free_intr_ctrl:
+	kfree(intr_ctrl);
+	return ERR_PTR(ret);
+}
+
+static void pci_dev_remove_intr_ctrl(struct pci_dev_intr_ctrl *intr_ctrl)
+{
+	free_irq(intr_ctrl->irq, intr_ctrl);
+	pci_free_irq_vectors(intr_ctrl->pci_dev);
+	irq_dispose_mapping(irq_find_mapping(intr_ctrl->irq_domain, 0));
+	irq_domain_remove(intr_ctrl->irq_domain);
+	kfree(intr_ctrl);
+}
+
+static void devm_pci_dev_remove_intr_ctrl(void *data)
+{
+	struct pci_dev_intr_ctrl *intr_ctrl = data;
+
+	pci_dev_remove_intr_ctrl(intr_ctrl);
+}
+
+static int devm_pci_dev_create_intr_ctrl(struct pci_dev *pdev)
+{
+	struct pci_dev_intr_ctrl *intr_ctrl;
+
+	intr_ctrl = pci_dev_create_intr_ctrl(pdev);
+
+	if (IS_ERR(intr_ctrl))
+		return PTR_ERR(intr_ctrl);
+
+	return devm_add_action_or_reset(&pdev->dev, devm_pci_dev_remove_intr_ctrl, intr_ctrl);
+}
+
+struct lan966x_pci {
+	struct device *dev;
+	struct pci_dev *pci_dev;
+	int ovcs_id;
+};
+
+static int lan966x_pci_load_overlay(struct lan966x_pci *data)
+{
+	u32 dtbo_size = __dtbo_lan966x_pci_end - __dtbo_lan966x_pci_begin;
+	void *dtbo_start = __dtbo_lan966x_pci_begin;
+	int ret;
+
+	ret = of_overlay_fdt_apply(dtbo_start, dtbo_size, &data->ovcs_id, data->dev->of_node);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void lan966x_pci_unload_overlay(struct lan966x_pci *data)
+{
+	of_overlay_remove(&data->ovcs_id);
+}
+
+static int lan966x_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct device *dev = &pdev->dev;
+	struct lan966x_pci *data;
+	int ret;
+
+	if (!dev->of_node) {
+		dev_err(dev, "Missing of_node for device\n");
+		return -EINVAL;
+	}
+
+	/* Need to be done before devm_pci_dev_create_intr_ctrl.
+	 * It allocates an IRQ and so pdev->irq is updated
+	 */
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	ret = devm_pci_dev_create_intr_ctrl(pdev);
+	if (ret)
+		return ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, data);
+	data->dev = dev;
+	data->pci_dev = pdev;
+
+	ret = lan966x_pci_load_overlay(data);
+	if (ret)
+		return ret;
+
+	pci_set_master(pdev);
+
+	ret = of_platform_default_populate(dev->of_node, NULL, dev);
+	if (ret)
+		goto err_unload_overlay;
+
+	return 0;
+
+err_unload_overlay:
+	lan966x_pci_unload_overlay(data);
+	return ret;
+}
+
+static void lan966x_pci_remove(struct pci_dev *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct lan966x_pci *data = dev_get_drvdata(dev);
+
+	of_platform_depopulate(dev);
+
+	lan966x_pci_unload_overlay(data);
+
+	pci_clear_master(pdev);
+}
+
+static struct pci_device_id lan966x_pci_ids[] = {
+	{ PCI_DEVICE(0x1055, 0x9660) },
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, lan966x_pci_ids);
+
+static struct pci_driver lan966x_pci_driver = {
+	.name = "mchp_lan966x_pci",
+	.id_table = lan966x_pci_ids,
+	.probe = lan966x_pci_probe,
+	.remove = lan966x_pci_remove,
+};
+module_pci_driver(lan966x_pci_driver);
+
+MODULE_AUTHOR("Herve Codina <herve.codina@bootlin.com>");
+MODULE_DESCRIPTION("Microchip LAN966x PCI driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/lan966x_pci.dtso b/drivers/mfd/lan966x_pci.dtso
new file mode 100644
index 000000000000..041f4319e4cd
--- /dev/null
+++ b/drivers/mfd/lan966x_pci.dtso
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Microchip UNG
+ */
+
+#include <dt-bindings/clock/microchip,lan966x.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/mfd/atmel-flexcom.h>
+#include <dt-bindings/phy/phy-lan966x-serdes.h>
+#include <dt-bindings/gpio/gpio.h>
+
+/dts-v1/;
+/plugin/;
+
+/ {
+	fragment@0 {
+		target-path="";
+		__overlay__ {
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			pci-ep-bus@0 {
+				compatible = "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				/*
+				 * map @0xe2000000 (32MB) to BAR0 (CPU)
+				 * map @0xe0000000 (16MB) to BAR1 (AMBA)
+				 */
+				ranges = <0xe2000000 0x00 0x00 0x00 0x2000000
+				          0xe0000000 0x01 0x00 0x00 0x1000000>;
+
+				oic: oic@e00c0120 {
+					compatible = "microchip,lan966x-oic";
+					#interrupt-cells = <2>;
+					interrupt-controller;
+					interrupts = <0>; /* PCI INTx assigned interrupt */
+					reg = <0xe00c0120 0x190>;
+				};
+
+				cpu_clk: cpu_clk {
+					compatible = "fixed-clock";
+					#clock-cells = <0>;
+					clock-frequency = <600000000>;  // CPU clock = 600MHz
+				};
+
+				ddr_clk: ddr_clk {
+					compatible = "fixed-clock";
+					#clock-cells = <0>;
+					clock-frequency = <30000000>;  // Fabric clock = 30MHz
+				};
+
+				sys_clk: sys_clk {
+					compatible = "fixed-clock";
+					#clock-cells = <0>;
+					clock-frequency = <15625000>;  // System clock = 15.625MHz
+				};
+
+				cpu_ctrl: syscon@e00c0000 {
+					compatible = "microchip,lan966x-cpu-syscon", "syscon";
+					reg = <0xe00c0000 0xa8>;
+				};
+
+				reset: reset@e200400c {
+					compatible = "microchip,lan966x-switch-reset";
+					reg = <0xe200400c 0x4>;
+					reg-names = "gcb";
+					#reset-cells = <1>;
+					cpu-syscon = <&cpu_ctrl>;
+				};
+
+				gpio: pinctrl@e2004064 {
+					compatible = "microchip,lan966x-pinctrl";
+					reg = <0xe2004064 0xb4>,
+					      <0xe2010024 0x138>;
+					resets = <&reset 0>;
+					reset-names = "switch";
+					gpio-controller;
+					#gpio-cells = <2>;
+					gpio-ranges = <&gpio 0 0 78>;
+					interrupt-parent = <&oic>;
+					interrupt-controller;
+					interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+					#interrupt-cells = <2>;
+
+					tod_pins: tod_pins {
+						pins = "GPIO_36";
+						function = "ptpsync_1";
+					};
+
+					fc0_a_pins: fcb4-i2c-pins {
+						/* RXD, TXD */
+						pins = "GPIO_9", "GPIO_10";
+						function = "fc0_a";
+					};
+
+				};
+
+				serdes: serdes@e202c000 {
+					compatible = "microchip,lan966x-serdes";
+					reg = <0xe202c000 0x9c>,
+					      <0xe2004010 0x4>;
+					#phy-cells = <2>;
+				};
+
+				mdio1: mdio@e200413c {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					compatible = "microchip,lan966x-miim";
+					reg = <0xe200413c 0x24>,
+					      <0xe2010020 0x4>;
+
+					resets = <&reset 0>;
+					reset-names = "switch";
+
+					lan966x_phy0: ethernet-lan966x_phy@1 {
+						reg = <1>;
+					};
+
+					lan966x_phy1: ethernet-lan966x_phy@2 {
+						reg = <2>;
+					};
+				};
+
+				switch: switch@e0000000 {
+					compatible = "microchip,lan966x-switch";
+					reg = <0xe0000000 0x0100000>,
+					      <0xe2000000 0x0800000>;
+					reg-names = "cpu", "gcb";
+
+					interrupt-parent = <&oic>;
+					interrupts = <12 IRQ_TYPE_LEVEL_HIGH>,
+						     <9 IRQ_TYPE_LEVEL_HIGH>;
+					interrupt-names = "xtr", "ana";
+
+					resets = <&reset 0>;
+					reset-names = "switch";
+
+					pinctrl-names = "default";
+					pinctrl-0 = <&tod_pins>;
+
+					ethernet-ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port0: port@0 {
+							phy-handle = <&lan966x_phy0>;
+
+							reg = <0>;
+							phy-mode = "gmii";
+							phys = <&serdes 0 CU(0)>;
+						};
+
+						port1: port@1 {
+							phy-handle = <&lan966x_phy1>;
+
+							reg = <1>;
+							phy-mode = "gmii";
+							phys = <&serdes 1 CU(1)>;
+						};
+					};
+				};
+			};
+		};
+	};
+};
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index eff7f5df08e2..9933f245b781 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6241,6 +6241,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa76e, dpc_log_size);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
+DECLARE_PCI_FIXUP_FINAL(0x1055, 0x9660, of_pci_make_dev_node);
 
 /*
  * Devices known to require a longer delay before first config space access
-- 
2.44.0


