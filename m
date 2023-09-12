Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648FB79D7F6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237047AbjILRvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236863AbjILRu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:50:59 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9CF10FD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:50:55 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c3bd829b86so19005125ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1694541055; x=1695145855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqvOnLhOJ7ioO5JJTC1Cfy8iveYDzUsMPwOovPSix+c=;
        b=R/OPu7sPkJMOtLuKB1+uF0O6VOP/6E+uA24RgK0YThml/IU17RbWODTyO51aCTWoHq
         2NqCaifap18cnSBqv1OMDop9gfAv8lkTX6DDGZD/XH56r/A0WV+VA41IHlxMnfSfBpNl
         jBArEi0Lu+Mr4YwAVt/T7oLRl5ifNKXh48W96cu22e3AmwX8FEA6xBXgsFm7yghKdFZ0
         zR4H27JEIdxCsPZ+aWiLhm9DHMMdlPlln9dmfkH2NgzCsbeHJQrdd/iyGj+E2CVlchVk
         J9/ff7nJclqk6zDZdRcUa3HpRXKiraC68/49Oeb05qsBJQG2/1x5eAFlLYGzBUhFV8l+
         XYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694541055; x=1695145855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqvOnLhOJ7ioO5JJTC1Cfy8iveYDzUsMPwOovPSix+c=;
        b=u1PqAH911HBhf/L/fqpx0hCh9bpolwCT2l6JLAeHjDm8mw6ZYaFpF+RcxFeyLwVHlh
         qDRudamKahnyY3IH/20T9azzv46X/wOUqXvFTnVGWRwNY2bLRLFECvxGF3r6THkt/3z3
         RSTLv+fB2P/KlnYd1BFHeCvMypmIiZsyWQSsRSb6bOBm4ENJuWV3Zy5LaqTrRaF9JRYf
         eWID54GZLL0U2BjdgVJO0gm+Xwf/htD6ORs5RBKugMnAdpbMh8SviPIJdQU7hbNtm/sJ
         ZHuoqI1GwUiFjlFoMqLC23fvusBJWCcCCFBIE78BcEL9VFLgtIfYW0jvYD2RKIomvkmU
         n6Lg==
X-Gm-Message-State: AOJu0YzJD1qgFIhMDTUTTQluCeg5bOxUH/QQ8l+q412G4cbolV3kKmZI
        Yq7hXW8s1Db/5LUf52BkaL6t8A==
X-Google-Smtp-Source: AGHT+IE5c5JSs15kio7mxEty4WsjlWzj99bxM4y0jB4BCDizeQRn6wl0ccpwdGbDTuyUHFcknxuSbA==
X-Received: by 2002:a17:902:f687:b0:1c3:ae56:4594 with SMTP id l7-20020a170902f68700b001c3ae564594mr575848plg.49.1694541054694;
        Tue, 12 Sep 2023 10:50:54 -0700 (PDT)
Received: from localhost.localdomain ([171.76.81.83])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902a40c00b001b891259eddsm8691440plq.197.2023.09.12.10.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 10:50:54 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v8 06/16] irqchip/sifive-plic: Convert PLIC driver into a platform driver
Date:   Tue, 12 Sep 2023 23:19:18 +0530
Message-Id: <20230912174928.528414-7-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912174928.528414-1-apatel@ventanamicro.com>
References: <20230912174928.528414-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PLIC driver does not require very early initialization so let us
convert it into a platform driver.

As part of the conversion, the PLIC probing undergoes the following
changes:
1. Use dev_info(), dev_err() and dev_warn() instead of pr_info(),
   pr_err() and pr_warn()
2. Use devm_xyz() APIs wherever applicable
3. Use fwnode APIs to read PLIC properties so that PLIC driver
   is suitable for ACPI as well.
4. PLIC is now probed after CPUs are brought-up so we have to
   setup cpuhp state after context handler of all online CPUs
   are initialized otherwise we see crash on multi-socket systems

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/irq-sifive-plic.c | 198 +++++++++++++++++-------------
 1 file changed, 112 insertions(+), 86 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 62ba27553cc3..72d6e06ef52b 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2017 SiFive
  * Copyright (C) 2018 Christoph Hellwig
  */
-#define pr_fmt(fmt) "plic: " fmt
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -13,8 +12,6 @@
 #include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/syscore_ops.h>
@@ -64,6 +61,7 @@
 #define PLIC_QUIRK_EDGE_INTERRUPT	0
 
 struct plic_priv {
+	struct device *dev;
 	struct cpumask lmask;
 	struct irq_domain *irqdomain;
 	void __iomem *regs;
@@ -85,7 +83,6 @@ struct plic_handler {
 	struct plic_priv	*priv;
 };
 static int plic_parent_irq __ro_after_init;
-static bool plic_cpuhp_setup_done __ro_after_init;
 static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
 
 static int plic_irq_set_type(struct irq_data *d, unsigned int type);
@@ -371,7 +368,8 @@ static void plic_handle_irq(struct irq_desc *desc)
 		int err = generic_handle_domain_irq(handler->priv->irqdomain,
 						    hwirq);
 		if (unlikely(err))
-			pr_warn_ratelimited("can't find mapping for hwirq %lu\n",
+			dev_warn_ratelimited(handler->priv->dev,
+					"can't find mapping for hwirq %lu\n",
 					hwirq);
 	}
 
@@ -406,57 +404,83 @@ static int plic_starting_cpu(unsigned int cpu)
 	return 0;
 }
 
-static int __init __plic_init(struct device_node *node,
-			      struct device_node *parent,
-			      unsigned long plic_quirks)
+static const struct of_device_id plic_match[] = {
+	{ .compatible = "sifive,plic-1.0.0" },
+	{ .compatible = "riscv,plic0" },
+	{ .compatible = "andestech,nceplic100",
+	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
+	{ .compatible = "thead,c900-plic",
+	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
+	{}
+};
+
+static int plic_probe(struct platform_device *pdev)
 {
-	int error = 0, nr_contexts, nr_handlers = 0, i;
-	u32 nr_irqs;
-	struct plic_priv *priv;
+	int rc, nr_contexts, nr_handlers = 0, i, cpu;
+	unsigned long plic_quirks = 0, hartid;
+	struct fwnode_reference_args parent;
+	struct device *dev = &pdev->dev;
 	struct plic_handler *handler;
-	unsigned int cpu;
+	struct irq_domain *domain;
+	struct plic_priv *priv;
+	irq_hw_number_t hwirq;
+	struct resource *res;
+	bool cpuhp_setup;
+	u32 nr_irqs;
+
+	if (is_of_node(dev->fwnode)) {
+		const struct of_device_id *id;
+
+		id = of_match_node(plic_match, to_of_node(dev->fwnode));
+		if (id)
+			plic_quirks = (unsigned long)id->data;
+	}
 
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
-
+	priv->dev = dev;
 	priv->plic_quirks = plic_quirks;
 
-	priv->regs = of_iomap(node, 0);
-	if (WARN_ON(!priv->regs)) {
-		error = -EIO;
-		goto out_free_priv;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "failed to get MMIO resource\n");
+		return -EINVAL;
+	}
+	priv->regs = devm_ioremap(dev, res->start, resource_size(res));
+	if (!priv->regs) {
+		dev_err(dev, "failed map MMIO registers\n");
+		return -EIO;
 	}
 
-	error = -EINVAL;
-	of_property_read_u32(node, "riscv,ndev", &nr_irqs);
-	if (WARN_ON(!nr_irqs))
-		goto out_iounmap;
-
+	rc = fwnode_property_read_u32_array(dev->fwnode, "riscv,ndev",
+						&nr_irqs, 1);
+	if (rc) {
+		dev_err(dev, "riscv,ndev property not available\n");
+		return rc;
+	}
 	priv->nr_irqs = nr_irqs;
 
-	priv->prio_save = bitmap_alloc(nr_irqs, GFP_KERNEL);
+	priv->prio_save = devm_bitmap_zalloc(dev, nr_irqs, GFP_KERNEL);
 	if (!priv->prio_save)
-		goto out_free_priority_reg;
-
-	nr_contexts = of_irq_count(node);
-	if (WARN_ON(!nr_contexts))
-		goto out_free_priority_reg;
+		return -ENOMEM;
 
-	error = -ENOMEM;
-	priv->irqdomain = irq_domain_add_linear(node, nr_irqs + 1,
-			&plic_irqdomain_ops, priv);
-	if (WARN_ON(!priv->irqdomain))
-		goto out_free_priority_reg;
+	nr_contexts = 0;
+	while (!fwnode_property_get_reference_args(dev->fwnode,
+				"interrupts-extended", "#interrupt-cells",
+				0, nr_contexts, &parent))
+		nr_contexts++;
+	if (WARN_ON(!nr_contexts)) {
+		dev_err(dev, "no PLIC context available\n");
+		return -EINVAL;
+	}
 
 	for (i = 0; i < nr_contexts; i++) {
-		struct of_phandle_args parent;
-		irq_hw_number_t hwirq;
-		int cpu;
-		unsigned long hartid;
-
-		if (of_irq_parse_one(node, i, &parent)) {
-			pr_err("failed to parse parent for context %d.\n", i);
+		rc = fwnode_property_get_reference_args(dev->fwnode,
+				"interrupts-extended", "#interrupt-cells",
+				0, i, &parent);
+		if (rc) {
+			dev_warn(dev, "parent irq for context%d not found\n", i);
 			continue;
 		}
 
@@ -477,22 +501,23 @@ static int __init __plic_init(struct device_node *node,
 			continue;
 		}
 
-		error = riscv_get_intc_hartid(of_fwnode_handle(parent.np),
-					      &hartid);
-		if (error < 0) {
-			pr_warn("failed to parse hart ID for context %d.\n", i);
+		rc = riscv_get_intc_hartid(parent.fwnode, &hartid);
+		if (rc < 0) {
+			dev_warn(dev, "failed to get hart ID for context%d.\n", i);
 			continue;
 		}
 
 		cpu = riscv_hartid_to_cpuid(hartid);
 		if (cpu < 0) {
-			pr_warn("Invalid cpuid for context %d\n", i);
+			dev_warn(dev, "Invalid cpuid for context %d\n", i);
 			continue;
 		}
 
 		/* Find parent domain and register chained handler */
-		if (!plic_parent_irq && irq_find_host(parent.np)) {
-			plic_parent_irq = irq_of_parse_and_map(node, i);
+		domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(),
+						  DOMAIN_BUS_ANY);
+		if (!plic_parent_irq && domain) {
+			plic_parent_irq = irq_create_mapping(domain, RV_IRQ_EXT);
 			if (plic_parent_irq)
 				irq_set_chained_handler(plic_parent_irq,
 							plic_handle_irq);
@@ -505,7 +530,7 @@ static int __init __plic_init(struct device_node *node,
 		 */
 		handler = per_cpu_ptr(&plic_handlers, cpu);
 		if (handler->present) {
-			pr_warn("handler already present for context %d.\n", i);
+			dev_warn(dev, "handler already present for context%d.\n", i);
 			plic_set_threshold(handler, PLIC_DISABLE_THRESHOLD);
 			goto done;
 		}
@@ -519,10 +544,13 @@ static int __init __plic_init(struct device_node *node,
 			i * CONTEXT_ENABLE_SIZE;
 		handler->priv = priv;
 
-		handler->enable_save =  kcalloc(DIV_ROUND_UP(nr_irqs, 32),
-						sizeof(*handler->enable_save), GFP_KERNEL);
+		handler->enable_save =  devm_kcalloc(dev,
+						DIV_ROUND_UP(nr_irqs, 32),
+						sizeof(*handler->enable_save),
+						GFP_KERNEL);
 		if (!handler->enable_save)
-			goto out_free_enable_reg;
+			return -ENOMEM;
+
 done:
 		for (hwirq = 1; hwirq <= nr_irqs; hwirq++) {
 			plic_toggle(handler, hwirq, 0);
@@ -532,52 +560,50 @@ static int __init __plic_init(struct device_node *node,
 		nr_handlers++;
 	}
 
+	priv->irqdomain = irq_domain_create_linear(dev->fwnode, nr_irqs + 1,
+						   &plic_irqdomain_ops, priv);
+	if (WARN_ON(!priv->irqdomain))
+		return -ENOMEM;
+
 	/*
 	 * We can have multiple PLIC instances so setup cpuhp state
-	 * and register syscore operations only when context handler
-	 * for current/boot CPU is present.
+	 * and register syscore operations only after context handlers
+	 * of all online CPUs are initialized.
 	 */
-	handler = this_cpu_ptr(&plic_handlers);
-	if (handler->present && !plic_cpuhp_setup_done) {
+	cpuhp_setup = true;
+	for_each_online_cpu(cpu) {
+		handler = per_cpu_ptr(&plic_handlers, cpu);
+		if (!handler->present) {
+			cpuhp_setup = false;
+			break;
+		}
+	}
+	if (cpuhp_setup) {
 		cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
 				  "irqchip/sifive/plic:starting",
 				  plic_starting_cpu, plic_dying_cpu);
 		register_syscore_ops(&plic_irq_syscore_ops);
-		plic_cpuhp_setup_done = true;
 	}
 
-	pr_info("%pOFP: mapped %d interrupts with %d handlers for"
-		" %d contexts.\n", node, nr_irqs, nr_handlers, nr_contexts);
+	dev_info(dev, "mapped %d interrupts with %d handlers for"
+		" %d contexts.\n", nr_irqs, nr_handlers, nr_contexts);
 	return 0;
-
-out_free_enable_reg:
-	for_each_cpu(cpu, cpu_present_mask) {
-		handler = per_cpu_ptr(&plic_handlers, cpu);
-		kfree(handler->enable_save);
-	}
-out_free_priority_reg:
-	kfree(priv->prio_save);
-out_iounmap:
-	iounmap(priv->regs);
-out_free_priv:
-	kfree(priv);
-	return error;
-}
-
-static int __init plic_init(struct device_node *node,
-			    struct device_node *parent)
-{
-	return __plic_init(node, parent, 0);
 }
 
-IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
-IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy systems */
+static struct platform_driver plic_driver = {
+	.driver = {
+		.name		= "riscv-plic",
+		.of_match_table	= plic_match,
+	},
+	.probe = plic_probe,
+};
 
-static int __init plic_edge_init(struct device_node *node,
-				 struct device_node *parent)
+static int __init plic_init(void)
 {
-	return __plic_init(node, parent, BIT(PLIC_QUIRK_EDGE_INTERRUPT));
+	/*
+	 * Register PLIC driver as early as possible so that PLIC
+	 * platform device is probed as soon as it is created.
+	 */
+	return platform_driver_register(&plic_driver);
 }
-
-IRQCHIP_DECLARE(andestech_nceplic100, "andestech,nceplic100", plic_edge_init);
-IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", plic_edge_init);
+core_initcall(plic_init);
-- 
2.34.1

