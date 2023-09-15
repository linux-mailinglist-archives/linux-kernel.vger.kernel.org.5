Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5C07A1C1E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbjIOKXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbjIOKXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:23:14 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBE81FD4;
        Fri, 15 Sep 2023 03:23:03 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 37DA824E264;
        Fri, 15 Sep 2023 18:23:02 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 15 Sep
 2023 18:23:02 +0800
Received: from ubuntu.localdomain (113.72.144.67) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 15 Sep
 2023 18:22:57 +0800
From:   Minda Chen <minda.chen@starfivetech.com>
To:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>,
        Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v6 15/19] PCI: microchip: Move IRQ functions to pcie-plda-host.c
Date:   Fri, 15 Sep 2023 18:22:39 +0800
Message-ID: <20230915102243.59775-16-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230915102243.59775-1-minda.chen@starfivetech.com>
References: <20230915102243.59775-1-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.144.67]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move IRQ functions to pcie-plda-host.c.
Including MSI, INTx, event interrupts and IRQ
init functions.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 .../pci/controller/plda/pcie-microchip-host.c | 364 -----------------
 drivers/pci/controller/plda/pcie-plda-host.c  | 365 ++++++++++++++++++
 drivers/pci/controller/plda/pcie-plda.h       |   3 +
 3 files changed, 368 insertions(+), 364 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index 49e09d24eb8f..016915d42f73 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -317,240 +317,6 @@ static void mc_pcie_enable_msi(struct mc_pcie *port, void __iomem *ecam)
 		       ecam + MC_MSI_CAP_CTRL_OFFSET + PCI_MSI_ADDRESS_HI);
 }
 
-static void plda_handle_msi(struct irq_desc *desc)
-{
-	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct device *dev = port->dev;
-	struct plda_msi *msi = &port->msi;
-	void __iomem *bridge_base_addr = port->bridge_addr;
-	unsigned long status;
-	u32 bit;
-	int ret;
-
-	chained_irq_enter(chip, desc);
-
-	status = readl_relaxed(bridge_base_addr + ISTATUS_LOCAL);
-	if (status & PM_MSI_INT_MSI_MASK) {
-		writel_relaxed(status & PM_MSI_INT_MSI_MASK, bridge_base_addr + ISTATUS_LOCAL);
-		status = readl_relaxed(bridge_base_addr + ISTATUS_MSI);
-		for_each_set_bit(bit, &status, msi->num_vectors) {
-			ret = generic_handle_domain_irq(msi->dev_domain, bit);
-			if (ret)
-				dev_err_ratelimited(dev, "bad MSI IRQ %d\n",
-						    bit);
-		}
-	}
-
-	chained_irq_exit(chip, desc);
-}
-
-static void plda_msi_bottom_irq_ack(struct irq_data *data)
-{
-	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
-	void __iomem *bridge_base_addr = port->bridge_addr;
-	u32 bitpos = data->hwirq;
-
-	writel_relaxed(BIT(bitpos), bridge_base_addr + ISTATUS_MSI);
-}
-
-static void plda_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
-{
-	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
-	phys_addr_t addr = port->msi.vector_phy;
-
-	msg->address_lo = lower_32_bits(addr);
-	msg->address_hi = upper_32_bits(addr);
-	msg->data = data->hwirq;
-
-	dev_dbg(port->dev, "msi#%x address_hi %#x address_lo %#x\n",
-		(int)data->hwirq, msg->address_hi, msg->address_lo);
-}
-
-static int plda_msi_set_affinity(struct irq_data *irq_data,
-				 const struct cpumask *mask, bool force)
-{
-	return -EINVAL;
-}
-
-static struct irq_chip plda_msi_bottom_irq_chip = {
-	.name = "PLDA MSI",
-	.irq_ack = plda_msi_bottom_irq_ack,
-	.irq_compose_msi_msg = plda_compose_msi_msg,
-	.irq_set_affinity = plda_msi_set_affinity,
-};
-
-static int plda_irq_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
-				     unsigned int nr_irqs, void *args)
-{
-	struct plda_pcie_rp *port = domain->host_data;
-	struct plda_msi *msi = &port->msi;
-	unsigned long bit;
-
-	mutex_lock(&msi->lock);
-	bit = find_first_zero_bit(msi->used, msi->num_vectors);
-	if (bit >= msi->num_vectors) {
-		mutex_unlock(&msi->lock);
-		return -ENOSPC;
-	}
-
-	set_bit(bit, msi->used);
-
-	irq_domain_set_info(domain, virq, bit, &plda_msi_bottom_irq_chip,
-			    domain->host_data, handle_edge_irq, NULL, NULL);
-
-	mutex_unlock(&msi->lock);
-
-	return 0;
-}
-
-static void plda_irq_msi_domain_free(struct irq_domain *domain, unsigned int virq,
-				     unsigned int nr_irqs)
-{
-	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
-	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(d);
-	struct plda_msi *msi = &port->msi;
-
-	mutex_lock(&msi->lock);
-
-	if (test_bit(d->hwirq, msi->used))
-		__clear_bit(d->hwirq, msi->used);
-	else
-		dev_err(port->dev, "trying to free unused MSI%lu\n", d->hwirq);
-
-	mutex_unlock(&msi->lock);
-}
-
-static const struct irq_domain_ops msi_domain_ops = {
-	.alloc	= plda_irq_msi_domain_alloc,
-	.free	= plda_irq_msi_domain_free,
-};
-
-static struct irq_chip plda_msi_irq_chip = {
-	.name = "PLDA PCIe MSI",
-	.irq_ack = irq_chip_ack_parent,
-	.irq_mask = pci_msi_mask_irq,
-	.irq_unmask = pci_msi_unmask_irq,
-};
-
-static struct msi_domain_info plda_msi_domain_info = {
-	.flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		  MSI_FLAG_PCI_MSIX),
-	.chip = &plda_msi_irq_chip,
-};
-
-static int plda_allocate_msi_domains(struct plda_pcie_rp *port)
-{
-	struct device *dev = port->dev;
-	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
-	struct plda_msi *msi = &port->msi;
-
-	mutex_init(&port->msi.lock);
-
-	msi->dev_domain = irq_domain_add_linear(NULL, msi->num_vectors,
-						&msi_domain_ops, port);
-	if (!msi->dev_domain) {
-		dev_err(dev, "failed to create IRQ domain\n");
-		return -ENOMEM;
-	}
-
-	msi->msi_domain = pci_msi_create_irq_domain(fwnode, &plda_msi_domain_info,
-						    msi->dev_domain);
-	if (!msi->msi_domain) {
-		dev_err(dev, "failed to create MSI domain\n");
-		irq_domain_remove(msi->dev_domain);
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-static void plda_handle_intx(struct irq_desc *desc)
-{
-	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct device *dev = port->dev;
-	void __iomem *bridge_base_addr = port->bridge_addr;
-	unsigned long status;
-	u32 bit;
-	int ret;
-
-	chained_irq_enter(chip, desc);
-
-	status = readl_relaxed(bridge_base_addr + ISTATUS_LOCAL);
-	if (status & PM_MSI_INT_INTX_MASK) {
-		status &= PM_MSI_INT_INTX_MASK;
-		status >>= PM_MSI_INT_INTX_SHIFT;
-		for_each_set_bit(bit, &status, PCI_NUM_INTX) {
-			ret = generic_handle_domain_irq(port->intx_domain, bit);
-			if (ret)
-				dev_err_ratelimited(dev, "bad INTx IRQ %d\n",
-						    bit);
-		}
-	}
-
-	chained_irq_exit(chip, desc);
-}
-
-static void plda_ack_intx_irq(struct irq_data *data)
-{
-	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
-	void __iomem *bridge_base_addr = port->bridge_addr;
-	u32 mask = BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
-
-	writel_relaxed(mask, bridge_base_addr + ISTATUS_LOCAL);
-}
-
-static void plda_mask_intx_irq(struct irq_data *data)
-{
-	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
-	void __iomem *bridge_base_addr = port->bridge_addr;
-	unsigned long flags;
-	u32 mask = BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
-	u32 val;
-
-	raw_spin_lock_irqsave(&port->lock, flags);
-	val = readl_relaxed(bridge_base_addr + IMASK_LOCAL);
-	val &= ~mask;
-	writel_relaxed(val, bridge_base_addr + IMASK_LOCAL);
-	raw_spin_unlock_irqrestore(&port->lock, flags);
-}
-
-static void plda_unmask_intx_irq(struct irq_data *data)
-{
-	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
-	void __iomem *bridge_base_addr = port->bridge_addr;
-	unsigned long flags;
-	u32 mask = BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
-	u32 val;
-
-	raw_spin_lock_irqsave(&port->lock, flags);
-	val = readl_relaxed(bridge_base_addr + IMASK_LOCAL);
-	val |= mask;
-	writel_relaxed(val, bridge_base_addr + IMASK_LOCAL);
-	raw_spin_unlock_irqrestore(&port->lock, flags);
-}
-
-static struct irq_chip plda_intx_irq_chip = {
-	.name = "PLDA PCIe INTx",
-	.irq_ack = plda_ack_intx_irq,
-	.irq_mask = plda_mask_intx_irq,
-	.irq_unmask = plda_unmask_intx_irq,
-};
-
-static int plda_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
-			      irq_hw_number_t hwirq)
-{
-	irq_set_chip_and_handler(irq, &plda_intx_irq_chip, handle_level_irq);
-	irq_set_chip_data(irq, domain->host_data);
-
-	return 0;
-}
-
-static const struct irq_domain_ops intx_domain_ops = {
-	.map = plda_pcie_intx_map,
-};
-
 static inline u32 reg_to_event(u32 reg, struct event_map field)
 {
 	return (reg & field.reg_mask) ? BIT(field.event_bit) : 0;
@@ -637,23 +403,6 @@ static irqreturn_t mc_event_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void plda_handle_event(struct irq_desc *desc)
-{
-	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
-	unsigned long events;
-	u32 bit;
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-
-	chained_irq_enter(chip, desc);
-
-	events = port->event_ops->get_events(port);
-
-	for_each_set_bit(bit, &events, port->num_events)
-		generic_handle_domain_irq(port->event_domain, bit);
-
-	chained_irq_exit(chip, desc);
-}
-
 static void mc_ack_event_irq(struct irq_data *data)
 {
 	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
@@ -817,47 +566,6 @@ static const struct plda_event mc_event = {
 	.msi_event              = EVENT_LOCAL_PM_MSI_INT_MSI,
 };
 
-static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port,
-				      const struct irq_domain_ops *ops)
-{
-	struct device *dev = port->dev;
-	struct device_node *node = dev->of_node;
-	struct device_node *pcie_intc_node;
-
-	/* Setup INTx */
-	pcie_intc_node = of_get_next_child(node, NULL);
-	if (!pcie_intc_node) {
-		dev_err(dev, "failed to find PCIe Intc node\n");
-		return -EINVAL;
-	}
-
-	port->event_domain = irq_domain_add_linear(pcie_intc_node, port->num_events,
-						   ops, port);
-
-	if (!port->event_domain) {
-		dev_err(dev, "failed to get event domain\n");
-		of_node_put(pcie_intc_node);
-		return -ENOMEM;
-	}
-
-	irq_domain_update_bus_token(port->event_domain, DOMAIN_BUS_NEXUS);
-
-	port->intx_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
-						  &intx_domain_ops, port);
-	if (!port->intx_domain) {
-		dev_err(dev, "failed to get an INTx IRQ domain\n");
-		of_node_put(pcie_intc_node);
-		return -ENOMEM;
-	}
-
-	irq_domain_update_bus_token(port->intx_domain, DOMAIN_BUS_WIRED);
-
-	of_node_put(pcie_intc_node);
-	raw_spin_lock_init(&port->lock);
-
-	return plda_allocate_msi_domains(port);
-}
-
 static inline void mc_clear_secs(struct mc_pcie *port)
 {
 	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
@@ -918,78 +626,6 @@ static void mc_disable_interrupts(struct mc_pcie *port)
 	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
 }
 
-static int plda_init_interrupts(struct platform_device *pdev,
-				struct plda_pcie_rp *port,
-				const struct plda_event *event)
-{
-	struct device *dev = &pdev->dev;
-	int irq;
-	int i, intx_irq, msi_irq, event_irq;
-	int ret;
-	const struct irq_domain_ops *irq_dom_ops;
-
-	if (!event->event_ops || !event->event_ops->get_events) {
-		dev_err(dev, "no get events ops\n");
-		return -EINVAL;
-	}
-
-	irq_dom_ops = event->domain_ops ? event->domain_ops : &mc_event_domain_ops;
-
-	ret = plda_pcie_init_irq_domains(port, irq_dom_ops);
-	if (ret) {
-		dev_err(dev, "failed creating IRQ domains\n");
-		return ret;
-	}
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return -ENODEV;
-
-	port->event_ops = event->event_ops;
-
-	for (i = 0; i < port->num_events; i++) {
-		event_irq = irq_create_mapping(port->event_domain, i);
-		if (!event_irq) {
-			dev_err(dev, "failed to map hwirq %d\n", i);
-			return -ENXIO;
-		}
-
-		if (event->request_event_irq)
-			ret = event->request_event_irq(port, event_irq, i);
-		else
-			ret = devm_request_irq(dev, event_irq, plda_event_handler,
-					       0, NULL, port);
-
-		if (ret) {
-			dev_err(dev, "failed to request IRQ %d\n", event_irq);
-			return ret;
-		}
-	}
-
-	intx_irq = irq_create_mapping(port->event_domain,
-				      event->intx_event);
-	if (!intx_irq) {
-		dev_err(dev, "failed to map INTx interrupt\n");
-		return -ENXIO;
-	}
-
-	/* Plug the INTx chained handler */
-	irq_set_chained_handler_and_data(intx_irq, plda_handle_intx, port);
-
-	msi_irq = irq_create_mapping(port->event_domain,
-				     event->msi_event);
-	if (!msi_irq)
-		return -ENXIO;
-
-	/* Plug the MSI chained handler */
-	irq_set_chained_handler_and_data(msi_irq, plda_handle_msi, port);
-
-	/* Plug the main event chained handler */
-	irq_set_chained_handler_and_data(irq, plda_handle_event, port);
-
-	return 0;
-}
-
 static int mc_platform_init(struct pci_config_window *cfg)
 {
 	struct device *dev = cfg->parent;
diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
index f29ff0f00dda..5c9dce595400 100644
--- a/drivers/pci/controller/plda/pcie-plda-host.c
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -20,6 +20,240 @@
 
 #include "pcie-plda.h"
 
+static void plda_handle_msi(struct irq_desc *desc)
+{
+	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct device *dev = port->dev;
+	struct plda_msi *msi = &port->msi;
+	void __iomem *bridge_base_addr = port->bridge_addr;
+	unsigned long status;
+	u32 bit;
+	int ret;
+
+	chained_irq_enter(chip, desc);
+
+	status = readl_relaxed(bridge_base_addr + ISTATUS_LOCAL);
+	if (status & PM_MSI_INT_MSI_MASK) {
+		writel_relaxed(status & PM_MSI_INT_MSI_MASK, bridge_base_addr + ISTATUS_LOCAL);
+		status = readl_relaxed(bridge_base_addr + ISTATUS_MSI);
+		for_each_set_bit(bit, &status, msi->num_vectors) {
+			ret = generic_handle_domain_irq(msi->dev_domain, bit);
+			if (ret)
+				dev_err_ratelimited(dev, "bad MSI IRQ %d\n",
+						    bit);
+		}
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void plda_msi_bottom_irq_ack(struct irq_data *data)
+{
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
+	void __iomem *bridge_base_addr = port->bridge_addr;
+	u32 bitpos = data->hwirq;
+
+	writel_relaxed(BIT(bitpos), bridge_base_addr + ISTATUS_MSI);
+}
+
+static void plda_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
+	phys_addr_t addr = port->msi.vector_phy;
+
+	msg->address_lo = lower_32_bits(addr);
+	msg->address_hi = upper_32_bits(addr);
+	msg->data = data->hwirq;
+
+	dev_dbg(port->dev, "msi#%x address_hi %#x address_lo %#x\n",
+		(int)data->hwirq, msg->address_hi, msg->address_lo);
+}
+
+static int plda_msi_set_affinity(struct irq_data *irq_data,
+				 const struct cpumask *mask, bool force)
+{
+	return -EINVAL;
+}
+
+static struct irq_chip plda_msi_bottom_irq_chip = {
+	.name = "PLDA MSI",
+	.irq_ack = plda_msi_bottom_irq_ack,
+	.irq_compose_msi_msg = plda_compose_msi_msg,
+	.irq_set_affinity = plda_msi_set_affinity,
+};
+
+static int plda_irq_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				     unsigned int nr_irqs, void *args)
+{
+	struct plda_pcie_rp *port = domain->host_data;
+	struct plda_msi *msi = &port->msi;
+	unsigned long bit;
+
+	mutex_lock(&msi->lock);
+	bit = find_first_zero_bit(msi->used, msi->num_vectors);
+	if (bit >= msi->num_vectors) {
+		mutex_unlock(&msi->lock);
+		return -ENOSPC;
+	}
+
+	set_bit(bit, msi->used);
+
+	irq_domain_set_info(domain, virq, bit, &plda_msi_bottom_irq_chip,
+			    domain->host_data, handle_edge_irq, NULL, NULL);
+
+	mutex_unlock(&msi->lock);
+
+	return 0;
+}
+
+static void plda_irq_msi_domain_free(struct irq_domain *domain, unsigned int virq,
+				     unsigned int nr_irqs)
+{
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(d);
+	struct plda_msi *msi = &port->msi;
+
+	mutex_lock(&msi->lock);
+
+	if (test_bit(d->hwirq, msi->used))
+		__clear_bit(d->hwirq, msi->used);
+	else
+		dev_err(port->dev, "trying to free unused MSI%lu\n", d->hwirq);
+
+	mutex_unlock(&msi->lock);
+}
+
+static const struct irq_domain_ops msi_domain_ops = {
+	.alloc	= plda_irq_msi_domain_alloc,
+	.free	= plda_irq_msi_domain_free,
+};
+
+static struct irq_chip plda_msi_irq_chip = {
+	.name = "PLDA PCIe MSI",
+	.irq_ack = irq_chip_ack_parent,
+	.irq_mask = pci_msi_mask_irq,
+	.irq_unmask = pci_msi_unmask_irq,
+};
+
+static struct msi_domain_info plda_msi_domain_info = {
+	.flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		  MSI_FLAG_PCI_MSIX),
+	.chip = &plda_msi_irq_chip,
+};
+
+static int plda_allocate_msi_domains(struct plda_pcie_rp *port)
+{
+	struct device *dev = port->dev;
+	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
+	struct plda_msi *msi = &port->msi;
+
+	mutex_init(&port->msi.lock);
+
+	msi->dev_domain = irq_domain_add_linear(NULL, msi->num_vectors,
+						&msi_domain_ops, port);
+	if (!msi->dev_domain) {
+		dev_err(dev, "failed to create IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	msi->msi_domain = pci_msi_create_irq_domain(fwnode, &plda_msi_domain_info,
+						    msi->dev_domain);
+	if (!msi->msi_domain) {
+		dev_err(dev, "failed to create MSI domain\n");
+		irq_domain_remove(msi->dev_domain);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void plda_handle_intx(struct irq_desc *desc)
+{
+	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct device *dev = port->dev;
+	void __iomem *bridge_base_addr = port->bridge_addr;
+	unsigned long status;
+	u32 bit;
+	int ret;
+
+	chained_irq_enter(chip, desc);
+
+	status = readl_relaxed(bridge_base_addr + ISTATUS_LOCAL);
+	if (status & PM_MSI_INT_INTX_MASK) {
+		status &= PM_MSI_INT_INTX_MASK;
+		status >>= PM_MSI_INT_INTX_SHIFT;
+		for_each_set_bit(bit, &status, PCI_NUM_INTX) {
+			ret = generic_handle_domain_irq(port->intx_domain, bit);
+			if (ret)
+				dev_err_ratelimited(dev, "bad INTx IRQ %d\n",
+						    bit);
+		}
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void plda_ack_intx_irq(struct irq_data *data)
+{
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
+	void __iomem *bridge_base_addr = port->bridge_addr;
+	u32 mask = BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
+
+	writel_relaxed(mask, bridge_base_addr + ISTATUS_LOCAL);
+}
+
+static void plda_mask_intx_irq(struct irq_data *data)
+{
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
+	void __iomem *bridge_base_addr = port->bridge_addr;
+	unsigned long flags;
+	u32 mask = BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
+	u32 val;
+
+	raw_spin_lock_irqsave(&port->lock, flags);
+	val = readl_relaxed(bridge_base_addr + IMASK_LOCAL);
+	val &= ~mask;
+	writel_relaxed(val, bridge_base_addr + IMASK_LOCAL);
+	raw_spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static void plda_unmask_intx_irq(struct irq_data *data)
+{
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
+	void __iomem *bridge_base_addr = port->bridge_addr;
+	unsigned long flags;
+	u32 mask = BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
+	u32 val;
+
+	raw_spin_lock_irqsave(&port->lock, flags);
+	val = readl_relaxed(bridge_base_addr + IMASK_LOCAL);
+	val |= mask;
+	writel_relaxed(val, bridge_base_addr + IMASK_LOCAL);
+	raw_spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static struct irq_chip plda_intx_irq_chip = {
+	.name = "PLDA PCIe INTx",
+	.irq_ack = plda_ack_intx_irq,
+	.irq_mask = plda_mask_intx_irq,
+	.irq_unmask = plda_unmask_intx_irq,
+};
+
+static int plda_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
+			      irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &plda_intx_irq_chip, handle_level_irq);
+	irq_set_chip_data(irq, domain->host_data);
+
+	return 0;
+}
+
+static const struct irq_domain_ops intx_domain_ops = {
+	.map = plda_pcie_intx_map,
+};
+
 irqreturn_t plda_event_handler(int irq, void *dev_id)
 {
 	return IRQ_HANDLED;
@@ -45,6 +279,23 @@ static u32 plda_get_events(struct plda_pcie_rp *port)
 	return events;
 }
 
+static void plda_handle_event(struct irq_desc *desc)
+{
+	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	u32 bit;
+	unsigned long events;
+
+	chained_irq_enter(chip, desc);
+
+	events = port->event_ops->get_events(port);
+
+	for_each_set_bit(bit, &events, port->num_events)
+		generic_handle_domain_irq(port->event_domain, bit);
+
+	chained_irq_exit(chip, desc);
+}
+
 static u32 plda_hwirq_to_mask(int hwirq)
 {
 	u32 mask;
@@ -119,6 +370,120 @@ static const struct plda_event_ops plda_event_ops = {
 	.get_events = plda_get_events,
 };
 
+static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port,
+				      const struct irq_domain_ops *ops)
+{
+	struct device *dev = port->dev;
+	struct device_node *node = dev->of_node;
+	struct device_node *pcie_intc_node;
+
+	/* Setup INTx */
+	pcie_intc_node = of_get_next_child(node, NULL);
+	if (!pcie_intc_node) {
+		dev_err(dev, "failed to find PCIe Intc node\n");
+		return -EINVAL;
+	}
+
+	port->event_domain = irq_domain_add_linear(pcie_intc_node, port->num_events,
+						   ops, port);
+
+	if (!port->event_domain) {
+		dev_err(dev, "failed to get event domain\n");
+		of_node_put(pcie_intc_node);
+		return -ENOMEM;
+	}
+
+	irq_domain_update_bus_token(port->event_domain, DOMAIN_BUS_NEXUS);
+
+	port->intx_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
+						  &intx_domain_ops, port);
+	if (!port->intx_domain) {
+		dev_err(dev, "failed to get an INTx IRQ domain\n");
+		of_node_put(pcie_intc_node);
+		return -ENOMEM;
+	}
+
+	irq_domain_update_bus_token(port->intx_domain, DOMAIN_BUS_WIRED);
+
+	of_node_put(pcie_intc_node);
+	raw_spin_lock_init(&port->lock);
+
+	return plda_allocate_msi_domains(port);
+}
+
+int plda_init_interrupts(struct platform_device *pdev,
+			 struct plda_pcie_rp *port,
+			 const struct plda_event *event)
+{
+	struct device *dev = &pdev->dev;
+	int irq;
+	int i, intx_irq, msi_irq, event_irq;
+	int ret;
+	const struct irq_domain_ops *irq_dom_ops;
+
+	if (!event->event_ops || !event->event_ops->get_events) {
+		dev_err(dev, "no get events ops\n");
+		return -EINVAL;
+	}
+
+	irq_dom_ops = event->domain_ops ? event->domain_ops : &plda_evt_dom_ops;
+
+	ret = plda_pcie_init_irq_domains(port, irq_dom_ops);
+	if (ret) {
+		dev_err(dev, "failed creating IRQ domains\n");
+		return ret;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return -ENODEV;
+
+	port->event_ops = event->event_ops;
+
+	for (i = 0; i < port->num_events; i++) {
+		event_irq = irq_create_mapping(port->event_domain, i);
+		if (!event_irq) {
+			dev_err(dev, "failed to map hwirq %d\n", i);
+			return -ENXIO;
+		}
+
+		if (event->request_event_irq)
+			ret = event->request_event_irq(port, event_irq, i);
+		else
+			ret = devm_request_irq(dev, event_irq, plda_event_handler,
+					       0, NULL, port);
+
+		if (ret) {
+			dev_err(dev, "failed to request IRQ %d\n", event_irq);
+			return ret;
+		}
+	}
+
+	intx_irq = irq_create_mapping(port->event_domain,
+				      event->intx_event);
+	if (!intx_irq) {
+		dev_err(dev, "failed to map INTx interrupt\n");
+		return -ENXIO;
+	}
+
+	/* Plug the INTx chained handler */
+	irq_set_chained_handler_and_data(intx_irq, plda_handle_intx, port);
+
+	msi_irq = irq_create_mapping(port->event_domain,
+				     event->msi_event);
+	if (!msi_irq)
+		return -ENXIO;
+
+	/* Plug the MSI chained handler */
+	irq_set_chained_handler_and_data(msi_irq, plda_handle_msi, port);
+
+	/* Plug the main event chained handler */
+	irq_set_chained_handler_and_data(irq, plda_handle_event, port);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(plda_init_interrupts);
+
 void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 			    phys_addr_t axi_addr, phys_addr_t pci_addr,
 			    size_t size)
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index 122084a3318a..e59369f23329 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -164,6 +164,9 @@ struct plda_event {
 };
 
 irqreturn_t plda_event_handler(int irq, void *dev_id);
+int plda_init_interrupts(struct platform_device *pdev,
+			 struct plda_pcie_rp *port,
+			 const struct plda_event *event);
 void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 			    phys_addr_t axi_addr, phys_addr_t pci_addr,
 			    size_t size);
-- 
2.17.1

