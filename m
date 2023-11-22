Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926137F4592
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344043AbjKVMSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343654AbjKVMST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:18:19 -0500
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2FA12C;
        Wed, 22 Nov 2023 04:18:14 -0800 (PST)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 3AMCGIi3025043;
        Wed, 22 Nov 2023 20:16:18 +0800 (+08)
        (envelope-from peterlin@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Wed, 22 Nov 2023
 20:16:14 +0800
From:   Yu Chien Peter Lin <peterlin@andestech.com>
To:     <acme@kernel.org>, <adrian.hunter@intel.com>,
        <ajones@ventanamicro.com>, <alexander.shishkin@linux.intel.com>,
        <andre.przywara@arm.com>, <anup@brainfault.org>,
        <aou@eecs.berkeley.edu>, <atishp@atishpatra.org>,
        <conor+dt@kernel.org>, <conor.dooley@microchip.com>,
        <conor@kernel.org>, <devicetree@vger.kernel.org>,
        <dminus@andestech.com>, <evan@rivosinc.com>,
        <geert+renesas@glider.be>, <guoren@kernel.org>, <heiko@sntech.de>,
        <irogers@google.com>, <jernej.skrabec@gmail.com>,
        <jolsa@kernel.org>, <jszhang@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
        <locus84@andestech.com>, <magnus.damm@gmail.com>,
        <mark.rutland@arm.com>, <mingo@redhat.com>, <n.shubin@yadro.com>,
        <namhyung@kernel.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <peterlin@andestech.com>,
        <peterz@infradead.org>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <rdunlap@infradead.org>, <robh+dt@kernel.org>,
        <samuel@sholland.org>, <sunilvl@ventanamicro.com>,
        <tglx@linutronix.de>, <tim609@andestech.com>, <uwu@icenowy.me>,
        <wens@csie.org>, <will@kernel.org>, <ycliang@andestech.com>,
        <inochiama@outlook.com>
Subject: [PATCH v4 03/13] irqchip/riscv-intc: Introduce Andes hart-level interrupt controller
Date:   Wed, 22 Nov 2023 20:12:25 +0800
Message-ID: <20231122121235.827122-4-peterlin@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122121235.827122-1-peterlin@andestech.com>
References: <20231122121235.827122-1-peterlin@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 3AMCGIi3025043
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Andes hart-level interrupt controller. This
controller provides interrupt mask/unmask functions to access the
custom register (SLIE) where the non-standard S-mode local interrupt
enable bits are located.

To share the riscv_intc_domain_map() with the generic RISC-V INTC and
ACPI, we add a chip parameter to riscv_intc_init_common(), so it can be
passed to the irq_domain_set_info() as private data.

Andes hart-level interrupt controller requires the "andestech,cpu-intc"
compatible string to be present in interrupt-controller of cpu node.
e.g.,

  cpu0: cpu@0 {
      compatible = "andestech,ax45mp", "riscv";
      ...
      cpu0-intc: interrupt-controller {
          #interrupt-cells = <0x01>;
          compatible = "andestech,cpu-intc", "riscv,cpu-intc";
          interrupt-controller;
      };
  };

Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
Reviewed-by: Charles Ci-Jyun Wu <dminus@andestech.com>
Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
Changes v1 -> v2:
  - New patch
Changes v2 -> v3:
  - Return -ENXIO if no valid compatible INTC found
  - Allow falling back to generic RISC-V INTC
Changes v3 -> v4: (Suggested by Thomas [1])
  - Add comment to andes irq chip function
  - Refine code flow to share with generic RISC-V INTC and ACPI
  - Move Andes specific definitions to include/linux/soc/andes/irq.h  

[1] https://patchwork.kernel.org/project/linux-riscv/patch/20231019135723.3657156-1-peterlin@andestech.com/
---
 drivers/irqchip/irq-riscv-intc.c | 51 ++++++++++++++++++++++++++++----
 include/linux/soc/andes/irq.h    | 17 +++++++++++
 2 files changed, 63 insertions(+), 5 deletions(-)
 create mode 100644 include/linux/soc/andes/irq.h

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 2fdd40f2a791..30f0036c8978 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/smp.h>
+#include <linux/soc/andes/irq.h>
 
 static struct irq_domain *intc_domain;
 
@@ -46,6 +47,31 @@ static void riscv_intc_irq_unmask(struct irq_data *d)
 	csr_set(CSR_IE, BIT(d->hwirq));
 }
 
+static void andes_intc_irq_mask(struct irq_data *d)
+{
+	/*
+	 * Andes specific S-mode local interrupt causes (hwirq)
+	 * are defined as (256 + n) and controlled by n-th bit
+	 * of SLIE.
+	 */
+	unsigned int mask = BIT(d->hwirq % BITS_PER_LONG);
+
+	if (d->hwirq < ANDES_SLI_CAUSE_BASE)
+		csr_clear(CSR_IE, mask);
+	else
+		csr_clear(ANDES_CSR_SLIE, mask);
+}
+
+static void andes_intc_irq_unmask(struct irq_data *d)
+{
+	unsigned int mask = BIT(d->hwirq % BITS_PER_LONG);
+
+	if (d->hwirq < ANDES_SLI_CAUSE_BASE)
+		csr_set(CSR_IE, mask);
+	else
+		csr_set(ANDES_CSR_SLIE, mask);
+}
+
 static void riscv_intc_irq_eoi(struct irq_data *d)
 {
 	/*
@@ -69,11 +95,20 @@ static struct irq_chip riscv_intc_chip = {
 	.irq_eoi = riscv_intc_irq_eoi,
 };
 
+static struct irq_chip andes_intc_chip = {
+	.name       = "RISC-V INTC",
+	.irq_mask   = andes_intc_irq_mask,
+	.irq_unmask = andes_intc_irq_unmask,
+	.irq_eoi    = riscv_intc_irq_eoi,
+};
+
 static int riscv_intc_domain_map(struct irq_domain *d, unsigned int irq,
 				 irq_hw_number_t hwirq)
 {
+	struct irq_chip *chip = d->host_data;
+
 	irq_set_percpu_devid(irq);
-	irq_domain_set_info(d, irq, hwirq, &riscv_intc_chip, d->host_data,
+	irq_domain_set_info(d, irq, hwirq, chip, d->host_data,
 			    handle_percpu_devid_irq, NULL, NULL);
 
 	return 0;
@@ -112,11 +147,12 @@ static struct fwnode_handle *riscv_intc_hwnode(void)
 	return intc_domain->fwnode;
 }
 
-static int __init riscv_intc_init_common(struct fwnode_handle *fn)
+static int __init riscv_intc_init_common(struct fwnode_handle *fn,
+					 struct irq_chip *chip)
 {
 	int rc;
 
-	intc_domain = irq_domain_create_tree(fn, &riscv_intc_domain_ops, NULL);
+	intc_domain = irq_domain_create_tree(fn, &riscv_intc_domain_ops, chip);
 	if (!intc_domain) {
 		pr_err("unable to add IRQ domain\n");
 		return -ENXIO;
@@ -138,6 +174,7 @@ static int __init riscv_intc_init(struct device_node *node,
 {
 	int rc;
 	unsigned long hartid;
+	struct irq_chip *chip = &riscv_intc_chip;
 
 	rc = riscv_of_parent_hartid(node, &hartid);
 	if (rc < 0) {
@@ -162,10 +199,14 @@ static int __init riscv_intc_init(struct device_node *node,
 		return 0;
 	}
 
-	return riscv_intc_init_common(of_node_to_fwnode(node));
+	if (of_device_is_compatible(node, "andestech,cpu-intc"))
+		chip = &andes_intc_chip;
+
+	return riscv_intc_init_common(of_node_to_fwnode(node), chip);
 }
 
 IRQCHIP_DECLARE(riscv, "riscv,cpu-intc", riscv_intc_init);
+IRQCHIP_DECLARE(andes, "andestech,cpu-intc", riscv_intc_init);
 
 #ifdef CONFIG_ACPI
 
@@ -192,7 +233,7 @@ static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
 		return -ENOMEM;
 	}
 
-	return riscv_intc_init_common(fn);
+	return riscv_intc_init_common(fn, &riscv_intc_chip);
 }
 
 IRQCHIP_ACPI_DECLARE(riscv_intc, ACPI_MADT_TYPE_RINTC, NULL,
diff --git a/include/linux/soc/andes/irq.h b/include/linux/soc/andes/irq.h
new file mode 100644
index 000000000000..f03e68fea261
--- /dev/null
+++ b/include/linux/soc/andes/irq.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 Andes Technology Corporation
+ */
+#ifndef __ANDES_IRQ_H
+#define __ANDES_IRQ_H
+
+/* Andes PMU irq number */
+#define ANDES_RV_IRQ_PMU		18
+#define ANDES_SLI_CAUSE_BASE		256
+
+/* Andes PMU related registers */
+#define ANDES_CSR_SLIE			0x9c4
+#define ANDES_CSR_SLIP			0x9c5
+#define ANDES_CSR_SCOUNTEROF		0x9d4
+
+#endif /* __ANDES_IRQ_H */
-- 
2.34.1

