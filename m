Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F127EC1A3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 12:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343627AbjKOLuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 06:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343616AbjKOLtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 06:49:31 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9A811D;
        Wed, 15 Nov 2023 03:49:28 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 5D34724E2D9;
        Wed, 15 Nov 2023 19:49:25 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Nov
 2023 19:49:25 +0800
Received: from ubuntu.localdomain (183.27.97.246) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Nov
 2023 19:49:24 +0800
From:   Minda Chen <minda.chen@starfivetech.com>
To:     Conor Dooley <conor@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Daire McNamara" <daire.mcnamara@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>,
        Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v11 12/20] PCI: microchip: Add request_event_irq() callback function
Date:   Wed, 15 Nov 2023 19:49:04 +0800
Message-ID: <20231115114912.71448-13-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231115114912.71448-1-minda.chen@starfivetech.com>
References: <20231115114912.71448-1-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.97.246]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PolarFire implements specific PCIe interrupts except PLDA local interrupt.
For lack of MSI controller, these interrupts have to be added to global
event field. PolarFire driver also register additional interrupt symbol
name.

PolarFire PCIe contain total 28 interrupts event while PLDA contain 13
local interrupts event, interrupt to event num mapping is different.

So add a callback function to support different IRQ register function.
Also Add PLDA default handler function, which will be moved to pcie-
plda-host.c in moving codes patch.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../pci/controller/plda/pcie-microchip-host.c | 31 ++++++++++++++++---
 drivers/pci/controller/plda/pcie-plda.h       |  5 +++
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index d42278c006bc..f89d102f4979 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -643,6 +643,11 @@ static irqreturn_t mc_event_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t plda_event_handler(int irq, void *dev_id)
+{
+	return IRQ_HANDLED;
+}
+
 static void plda_handle_event(struct irq_desc *desc)
 {
 	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
@@ -804,6 +809,17 @@ static int mc_pcie_init_clks(struct device *dev)
 	return 0;
 }
 
+static int mc_request_event_irq(struct plda_pcie_rp *plda, int event_irq,
+				int event)
+{
+	return devm_request_irq(plda->dev, event_irq, mc_event_handler,
+				0, event_cause[event].sym, plda);
+}
+
+static const struct plda_event mc_event = {
+	.request_event_irq = mc_request_event_irq,
+};
+
 static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
 {
 	struct device *dev = port->dev;
@@ -904,7 +920,9 @@ static void mc_disable_interrupts(struct mc_pcie *port)
 	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
 }
 
-static int plda_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp *port)
+static int plda_init_interrupts(struct platform_device *pdev,
+				struct plda_pcie_rp *port,
+				const struct plda_event *event)
 {
 	struct device *dev = &pdev->dev;
 	int irq;
@@ -928,8 +946,13 @@ static int plda_init_interrupts(struct platform_device *pdev, struct plda_pcie_r
 			return -ENXIO;
 		}
 
-		ret = devm_request_irq(dev, event_irq, mc_event_handler,
-				       0, event_cause[i].sym, port);
+		if (event->request_event_irq)
+			ret = event->request_event_irq(port, event_irq, i);
+		else
+			ret = devm_request_irq(dev, event_irq,
+					       plda_event_handler,
+					       0, NULL, port);
+
 		if (ret) {
 			dev_err(dev, "failed to request IRQ %d\n", event_irq);
 			return ret;
@@ -983,7 +1006,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
 		return ret;
 
 	/* Address translation is up; safe to enable interrupts */
-	ret = plda_init_interrupts(pdev, &port->plda);
+	ret = plda_init_interrupts(pdev, &port->plda, &mc_event);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index e3d35cef9894..28ed1374e1de 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -121,6 +121,11 @@ struct plda_pcie_rp {
 	int num_events;
 };
 
+struct plda_event {
+	int (*request_event_irq)(struct plda_pcie_rp *pcie,
+				 int event_irq, int event);
+};
+
 void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 			    phys_addr_t axi_addr, phys_addr_t pci_addr,
 			    size_t size);
-- 
2.17.1

