Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463827D3DB7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjJWRaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbjJWR30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:29:26 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8C6199A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:29:06 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b36e1fcea0so2691570b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698082146; x=1698686946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ed91E3Tat4PldAKlj3UX7/JLm+o5cX5rjfpT7Fyfc30=;
        b=pKUfTXi8wt7J3B4+dlHv1eugSWXaJJeYI/mSEX58b95bbktkG4XDnwZL/sl9SjGI8R
         jmgG3BUrA9vKEvIqwEI+A+F4XU84uTL7d8M1ek93WaAGScqlKnvkolTQM4VPzbdBw8QZ
         Ifq7XouzMY8uCT/EFDjKLe+7XSNGu2Fkmh3M4CUuw6sZx98tZN+mBZS/JhW7DiPXDgtZ
         D91VaGgC+AimIC8p8Lh35WS/yGqqfdqdiib9QzQWmfm9buT9MUnzUvn4cCWCHiSN7dT1
         DnXmFHAqkEgs4X57tUIZrS5xEsFCW0MdKbSIfnHgT7rGt8IZ5D6oDIRsDLY2W6ud66bY
         Zqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698082146; x=1698686946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ed91E3Tat4PldAKlj3UX7/JLm+o5cX5rjfpT7Fyfc30=;
        b=WbBqDiNKQUlbtsSg8pg55oZ9w1jWTS8z8coUxwA10JYk8DQhTnVmJ/thyecHQ24I0W
         PlU9KNmEsUl58QtqnbVtOaYmB00cgn8j7JVrAMqL6HfW9SMvtUtG0RYrsaoOehh4t14Y
         MfRfGclexS2VaIwfORhpMsL6yMpf5LVjO2ZXJSZmU8DsWkUZD2PiJEHa9K+Y0d28Y77q
         kefn06q+NUXIvOU5VGihlNvYJzSsIEsqbKDlj/kunaypTjd5DEKHKXago31NhOgRL4i/
         XlO+AGpK7+/UsldIt1XrUgayukH1dZCo5y1sk6AwkLwubEOMcTAILXWVkroEYhBYN7SE
         b66A==
X-Gm-Message-State: AOJu0YyKghDw/V0awRm0vWuqfgkBZgk5j70QmvN4bdNpa6zmKxN2TMha
        K9wHnpgB/CPdnToS9CFCpqEIcMH7zky59puX+Y8=
X-Google-Smtp-Source: AGHT+IGIvn2IUVd0qrv2Y0wDcIPwKH6ud7YHv+DILCtVmZNbtRwlpiz/2prHBIVtfqUI6M4fcJR8GQ==
X-Received: by 2002:a05:6a00:17a1:b0:6b2:baa0:6d4c with SMTP id s33-20020a056a0017a100b006b2baa06d4cmr8207011pfg.33.1698082146125;
        Mon, 23 Oct 2023 10:29:06 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.86.9])
        by smtp.gmail.com with ESMTPSA id g5-20020aa79f05000000b006be055ab117sm6473194pfr.92.2023.10.23.10.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 10:29:05 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v11 11/14] irqchip: Add RISC-V advanced PLIC driver for direct-mode
Date:   Mon, 23 Oct 2023 22:57:57 +0530
Message-Id: <20231023172800.315343-12-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023172800.315343-1-apatel@ventanamicro.com>
References: <20231023172800.315343-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISC-V advanced interrupt architecture (AIA) specification defines
advanced platform-level interrupt controller (APLIC) which has two modes
of operation: 1) Direct mode and 2) MSI mode.
(For more details, refer https://github.com/riscv/riscv-aia)

In APLIC direct-mode, wired interrupts are forwared to CPUs (or HARTs)
as a local external interrupt.

We add a platform irqchip driver for the RISC-V APLIC direct-mode to
support RISC-V platforms having only wired interrupts.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/Kconfig                  |   5 +
 drivers/irqchip/Makefile                 |   1 +
 drivers/irqchip/irq-riscv-aplic-direct.c | 343 +++++++++++++++++++++++
 drivers/irqchip/irq-riscv-aplic-main.c   | 232 +++++++++++++++
 drivers/irqchip/irq-riscv-aplic-main.h   |  45 +++
 include/linux/irqchip/riscv-aplic.h      | 119 ++++++++
 6 files changed, 745 insertions(+)
 create mode 100644 drivers/irqchip/irq-riscv-aplic-direct.c
 create mode 100644 drivers/irqchip/irq-riscv-aplic-main.c
 create mode 100644 drivers/irqchip/irq-riscv-aplic-main.h
 create mode 100644 include/linux/irqchip/riscv-aplic.h

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index c1d69b418dfb..1996cc6f666a 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -546,6 +546,11 @@ config SIFIVE_PLIC
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 
+config RISCV_APLIC
+	bool
+	depends on RISCV
+	select IRQ_DOMAIN_HIERARCHY
+
 config RISCV_IMSIC
 	bool
 	depends on RISCV
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index abca445a3229..7f8289790ed8 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -95,6 +95,7 @@ obj-$(CONFIG_QCOM_MPM)			+= irq-qcom-mpm.o
 obj-$(CONFIG_CSKY_MPINTC)		+= irq-csky-mpintc.o
 obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
 obj-$(CONFIG_RISCV_INTC)		+= irq-riscv-intc.o
+obj-$(CONFIG_RISCV_APLIC)		+= irq-riscv-aplic-main.o irq-riscv-aplic-direct.o
 obj-$(CONFIG_RISCV_IMSIC)		+= irq-riscv-imsic-state.o irq-riscv-imsic-early.o irq-riscv-imsic-platform.o
 obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
 obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
diff --git a/drivers/irqchip/irq-riscv-aplic-direct.c b/drivers/irqchip/irq-riscv-aplic-direct.c
new file mode 100644
index 000000000000..9ed2666bfb5e
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-aplic-direct.c
@@ -0,0 +1,343 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ */
+
+#include <linux/bitops.h>
+#include <linux/cpu.h>
+#include <linux/interrupt.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqchip/riscv-aplic.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/printk.h>
+#include <linux/smp.h>
+
+#include "irq-riscv-aplic-main.h"
+
+#define APLIC_DISABLE_IDELIVERY		0
+#define APLIC_ENABLE_IDELIVERY		1
+#define APLIC_DISABLE_ITHRESHOLD	1
+#define APLIC_ENABLE_ITHRESHOLD		0
+
+struct aplic_direct {
+	struct aplic_priv	priv;
+	struct irq_domain	*irqdomain;
+	struct cpumask		lmask;
+};
+
+struct aplic_idc {
+	unsigned int		hart_index;
+	void __iomem		*regs;
+	struct aplic_direct	*direct;
+};
+
+static unsigned int aplic_direct_parent_irq;
+static DEFINE_PER_CPU(struct aplic_idc, aplic_idcs);
+
+static void aplic_direct_irq_eoi(struct irq_data *d)
+{
+	/*
+	 * The fasteoi_handler requires irq_eoi() callback hence
+	 * provide a dummy handler.
+	 */
+}
+
+#ifdef CONFIG_SMP
+static int aplic_direct_set_affinity(struct irq_data *d,
+				  const struct cpumask *mask_val, bool force)
+{
+	struct aplic_priv *priv = irq_data_get_irq_chip_data(d);
+	struct aplic_direct *direct =
+			container_of(priv, struct aplic_direct, priv);
+	struct aplic_idc *idc;
+	unsigned int cpu, val;
+	struct cpumask amask;
+	void __iomem *target;
+
+	cpumask_and(&amask, &direct->lmask, mask_val);
+
+	if (force)
+		cpu = cpumask_first(&amask);
+	else
+		cpu = cpumask_any_and(&amask, cpu_online_mask);
+
+	if (cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	idc = per_cpu_ptr(&aplic_idcs, cpu);
+	target = priv->regs + APLIC_TARGET_BASE;
+	target += (d->hwirq - 1) * sizeof(u32);
+	val = idc->hart_index & APLIC_TARGET_HART_IDX_MASK;
+	val <<= APLIC_TARGET_HART_IDX_SHIFT;
+	val |= APLIC_DEFAULT_PRIORITY;
+	writel(val, target);
+
+	irq_data_update_effective_affinity(d, cpumask_of(cpu));
+
+	return IRQ_SET_MASK_OK_DONE;
+}
+#endif
+
+static struct irq_chip aplic_direct_chip = {
+	.name		= "APLIC-DIRECT",
+	.irq_mask	= aplic_irq_mask,
+	.irq_unmask	= aplic_irq_unmask,
+	.irq_set_type	= aplic_irq_set_type,
+	.irq_eoi	= aplic_direct_irq_eoi,
+#ifdef CONFIG_SMP
+	.irq_set_affinity = aplic_direct_set_affinity,
+#endif
+	.flags		= IRQCHIP_SET_TYPE_MASKED |
+			  IRQCHIP_SKIP_SET_WAKE |
+			  IRQCHIP_MASK_ON_SUSPEND,
+};
+
+static int aplic_direct_irqdomain_translate(struct irq_domain *d,
+					 struct irq_fwspec *fwspec,
+					 unsigned long *hwirq,
+					 unsigned int *type)
+{
+	struct aplic_priv *priv = d->host_data;
+
+	return aplic_irqdomain_translate(fwspec, priv->gsi_base,
+					 hwirq, type);
+}
+
+static int aplic_direct_irqdomain_alloc(struct irq_domain *domain,
+				     unsigned int virq, unsigned int nr_irqs,
+				     void *arg)
+{
+	int i, ret;
+	unsigned int type;
+	irq_hw_number_t hwirq;
+	struct irq_fwspec *fwspec = arg;
+	struct aplic_priv *priv = domain->host_data;
+	struct aplic_direct *direct =
+			container_of(priv, struct aplic_direct, priv);
+
+	ret = aplic_irqdomain_translate(fwspec, priv->gsi_base,
+					&hwirq, &type);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_domain_set_info(domain, virq + i, hwirq + i,
+				    &aplic_direct_chip, priv,
+				    handle_fasteoi_irq, NULL, NULL);
+		irq_set_affinity(virq + i, &direct->lmask);
+		/* See the reason described in aplic_msi_irqdomain_alloc() */
+		irq_set_status_flags(virq + i, IRQ_DISABLE_UNLAZY);
+	}
+
+	return 0;
+}
+
+static const struct irq_domain_ops aplic_direct_irqdomain_ops = {
+	.translate	= aplic_direct_irqdomain_translate,
+	.alloc		= aplic_direct_irqdomain_alloc,
+	.free		= irq_domain_free_irqs_top,
+};
+
+/*
+ * To handle an APLIC direct interrupts, we just read the CLAIMI register
+ * which will return highest priority pending interrupt and clear the
+ * pending bit of the interrupt. This process is repeated until CLAIMI
+ * register return zero value.
+ */
+static void aplic_direct_handle_irq(struct irq_desc *desc)
+{
+	struct aplic_idc *idc = this_cpu_ptr(&aplic_idcs);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct irq_domain *irqdomain = idc->direct->irqdomain;
+	irq_hw_number_t hw_irq;
+	int irq;
+
+	chained_irq_enter(chip, desc);
+
+	while ((hw_irq = readl(idc->regs + APLIC_IDC_CLAIMI))) {
+		hw_irq = hw_irq >> APLIC_IDC_TOPI_ID_SHIFT;
+		irq = irq_find_mapping(irqdomain, hw_irq);
+
+		if (unlikely(irq <= 0))
+			dev_warn_ratelimited(idc->direct->priv.dev,
+					     "hw_irq %lu mapping not found\n",
+					     hw_irq);
+		else
+			generic_handle_irq(irq);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void aplic_idc_set_delivery(struct aplic_idc *idc, bool en)
+{
+	u32 de = (en) ? APLIC_ENABLE_IDELIVERY : APLIC_DISABLE_IDELIVERY;
+	u32 th = (en) ? APLIC_ENABLE_ITHRESHOLD : APLIC_DISABLE_ITHRESHOLD;
+
+	/* Priority must be less than threshold for interrupt triggering */
+	writel(th, idc->regs + APLIC_IDC_ITHRESHOLD);
+
+	/* Delivery must be set to 1 for interrupt triggering */
+	writel(de, idc->regs + APLIC_IDC_IDELIVERY);
+}
+
+static int aplic_direct_dying_cpu(unsigned int cpu)
+{
+	if (aplic_direct_parent_irq)
+		disable_percpu_irq(aplic_direct_parent_irq);
+
+	return 0;
+}
+
+static int aplic_direct_starting_cpu(unsigned int cpu)
+{
+	if (aplic_direct_parent_irq)
+		enable_percpu_irq(aplic_direct_parent_irq,
+				irq_get_trigger_type(aplic_direct_parent_irq));
+
+	return 0;
+}
+
+static int aplic_direct_parse_parent_hwirq(struct device *dev,
+					   u32 index, u32 *parent_hwirq,
+					   unsigned long *parent_hartid)
+{
+	struct of_phandle_args parent;
+	int rc;
+
+	/*
+	 * Currently, only OF fwnode is supported so extend this
+	 * function for ACPI support.
+	 */
+	if (!is_of_node(dev->fwnode))
+		return -EINVAL;
+
+	rc = of_irq_parse_one(to_of_node(dev->fwnode), index, &parent);
+	if (rc)
+		return rc;
+
+	rc = riscv_of_parent_hartid(parent.np, parent_hartid);
+	if (rc)
+		return rc;
+
+	*parent_hwirq = parent.args[0];
+	return 0;
+}
+
+int aplic_direct_setup(struct device *dev, void __iomem *regs)
+{
+	int i, j, rc, cpu, setup_count = 0;
+	struct aplic_direct *direct;
+	struct aplic_priv *priv;
+	struct irq_domain *domain;
+	unsigned long hartid;
+	struct aplic_idc *idc;
+	u32 val, hwirq;
+
+	direct = kzalloc(sizeof(*direct), GFP_KERNEL);
+	if (!direct)
+		return -ENOMEM;
+	priv = &direct->priv;
+
+	rc = aplic_setup_priv(priv, dev, regs);
+	if (rc) {
+		dev_err(dev, "failed to create APLIC context\n");
+		kfree(direct);
+		return rc;
+	}
+
+	/* Setup per-CPU IDC and target CPU mask */
+	for (i = 0; i < priv->nr_idcs; i++) {
+		rc = aplic_direct_parse_parent_hwirq(dev, i, &hwirq, &hartid);
+		if (rc) {
+			dev_warn(dev, "parent irq for IDC%d not found\n", i);
+			continue;
+		}
+
+		/*
+		 * Skip interrupts other than external interrupts for
+		 * current privilege level.
+		 */
+		if (hwirq != RV_IRQ_EXT)
+			continue;
+
+		cpu = riscv_hartid_to_cpuid(hartid);
+		if (cpu < 0) {
+			dev_warn(dev, "invalid cpuid for IDC%d\n", i);
+			continue;
+		}
+
+		cpumask_set_cpu(cpu, &direct->lmask);
+
+		idc = per_cpu_ptr(&aplic_idcs, cpu);
+		idc->hart_index = i;
+		idc->regs = priv->regs + APLIC_IDC_BASE + i * APLIC_IDC_SIZE;
+		idc->direct = direct;
+
+		aplic_idc_set_delivery(idc, true);
+
+		/*
+		 * Boot cpu might not have APLIC hart_index = 0 so check
+		 * and update target registers of all interrupts.
+		 */
+		if (cpu == smp_processor_id() && idc->hart_index) {
+			val = idc->hart_index & APLIC_TARGET_HART_IDX_MASK;
+			val <<= APLIC_TARGET_HART_IDX_SHIFT;
+			val |= APLIC_DEFAULT_PRIORITY;
+			for (j = 1; j <= priv->nr_irqs; j++)
+				writel(val, priv->regs + APLIC_TARGET_BASE +
+					    (j - 1) * sizeof(u32));
+		}
+
+		setup_count++;
+	}
+
+	/* Find parent domain and register chained handler */
+	domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(),
+					  DOMAIN_BUS_ANY);
+	if (!aplic_direct_parent_irq && domain) {
+		aplic_direct_parent_irq = irq_create_mapping(domain, RV_IRQ_EXT);
+		if (aplic_direct_parent_irq) {
+			irq_set_chained_handler(aplic_direct_parent_irq,
+						aplic_direct_handle_irq);
+
+			/*
+			 * Setup CPUHP notifier to enable parent
+			 * interrupt on all CPUs
+			 */
+			cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+					  "irqchip/riscv/aplic:starting",
+					  aplic_direct_starting_cpu,
+					  aplic_direct_dying_cpu);
+		}
+	}
+
+	/* Fail if we were not able to setup IDC for any CPU */
+	if (!setup_count) {
+		kfree(direct);
+		return -ENODEV;
+	}
+
+	/* Setup global config and interrupt delivery */
+	aplic_init_hw_global(priv, false);
+
+	/* Create irq domain instance for the APLIC */
+	direct->irqdomain = irq_domain_create_linear(dev->fwnode,
+						   priv->nr_irqs + 1,
+						   &aplic_direct_irqdomain_ops,
+						   priv);
+	if (!direct->irqdomain) {
+		dev_err(dev, "failed to create direct irq domain\n");
+		kfree(direct);
+		return -ENOMEM;
+	}
+
+	/* Advertise the interrupt controller */
+	dev_info(dev, "%d interrupts directly connected to %d CPUs\n",
+		 priv->nr_irqs, priv->nr_idcs);
+
+	return 0;
+}
diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq-riscv-aplic-main.c
new file mode 100644
index 000000000000..87450708a733
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-aplic-main.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ */
+
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/printk.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/irqchip/riscv-aplic.h>
+
+#include "irq-riscv-aplic-main.h"
+
+void aplic_irq_unmask(struct irq_data *d)
+{
+	struct aplic_priv *priv = irq_data_get_irq_chip_data(d);
+
+	writel(d->hwirq, priv->regs + APLIC_SETIENUM);
+}
+
+void aplic_irq_mask(struct irq_data *d)
+{
+	struct aplic_priv *priv = irq_data_get_irq_chip_data(d);
+
+	writel(d->hwirq, priv->regs + APLIC_CLRIENUM);
+}
+
+int aplic_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	u32 val = 0;
+	void __iomem *sourcecfg;
+	struct aplic_priv *priv = irq_data_get_irq_chip_data(d);
+
+	switch (type) {
+	case IRQ_TYPE_NONE:
+		val = APLIC_SOURCECFG_SM_INACTIVE;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		val = APLIC_SOURCECFG_SM_LEVEL_LOW;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		val = APLIC_SOURCECFG_SM_LEVEL_HIGH;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		val = APLIC_SOURCECFG_SM_EDGE_FALL;
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		val = APLIC_SOURCECFG_SM_EDGE_RISE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	sourcecfg = priv->regs + APLIC_SOURCECFG_BASE;
+	sourcecfg += (d->hwirq - 1) * sizeof(u32);
+	writel(val, sourcecfg);
+
+	return 0;
+}
+
+int aplic_irqdomain_translate(struct irq_fwspec *fwspec, u32 gsi_base,
+			      unsigned long *hwirq, unsigned int *type)
+{
+	if (WARN_ON(fwspec->param_count < 2))
+		return -EINVAL;
+	if (WARN_ON(!fwspec->param[0]))
+		return -EINVAL;
+
+	/* For DT, gsi_base is always zero. */
+	*hwirq = fwspec->param[0] - gsi_base;
+	*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+
+	WARN_ON(*type == IRQ_TYPE_NONE);
+
+	return 0;
+}
+
+void aplic_init_hw_global(struct aplic_priv *priv, bool msi_mode)
+{
+	u32 val;
+#ifdef CONFIG_RISCV_M_MODE
+	u32 valH;
+
+	if (msi_mode) {
+		val = priv->msicfg.base_ppn;
+		valH = ((u64)priv->msicfg.base_ppn >> 32) &
+			APLIC_xMSICFGADDRH_BAPPN_MASK;
+		valH |= (priv->msicfg.lhxw & APLIC_xMSICFGADDRH_LHXW_MASK)
+			<< APLIC_xMSICFGADDRH_LHXW_SHIFT;
+		valH |= (priv->msicfg.hhxw & APLIC_xMSICFGADDRH_HHXW_MASK)
+			<< APLIC_xMSICFGADDRH_HHXW_SHIFT;
+		valH |= (priv->msicfg.lhxs & APLIC_xMSICFGADDRH_LHXS_MASK)
+			<< APLIC_xMSICFGADDRH_LHXS_SHIFT;
+		valH |= (priv->msicfg.hhxs & APLIC_xMSICFGADDRH_HHXS_MASK)
+			<< APLIC_xMSICFGADDRH_HHXS_SHIFT;
+		writel(val, priv->regs + APLIC_xMSICFGADDR);
+		writel(valH, priv->regs + APLIC_xMSICFGADDRH);
+	}
+#endif
+
+	/* Setup APLIC domaincfg register */
+	val = readl(priv->regs + APLIC_DOMAINCFG);
+	val |= APLIC_DOMAINCFG_IE;
+	if (msi_mode)
+		val |= APLIC_DOMAINCFG_DM;
+	writel(val, priv->regs + APLIC_DOMAINCFG);
+	if (readl(priv->regs + APLIC_DOMAINCFG) != val)
+		dev_warn(priv->dev, "unable to write 0x%x in domaincfg\n",
+			 val);
+}
+
+static void aplic_init_hw_irqs(struct aplic_priv *priv)
+{
+	int i;
+
+	/* Disable all interrupts */
+	for (i = 0; i <= priv->nr_irqs; i += 32)
+		writel(-1U, priv->regs + APLIC_CLRIE_BASE +
+			    (i / 32) * sizeof(u32));
+
+	/* Set interrupt type and default priority for all interrupts */
+	for (i = 1; i <= priv->nr_irqs; i++) {
+		writel(0, priv->regs + APLIC_SOURCECFG_BASE +
+			  (i - 1) * sizeof(u32));
+		writel(APLIC_DEFAULT_PRIORITY,
+		       priv->regs + APLIC_TARGET_BASE +
+		       (i - 1) * sizeof(u32));
+	}
+
+	/* Clear APLIC domaincfg */
+	writel(0, priv->regs + APLIC_DOMAINCFG);
+}
+
+int aplic_setup_priv(struct aplic_priv *priv, struct device *dev,
+		     void __iomem *regs)
+{
+	struct of_phandle_args parent;
+	int rc;
+
+	/*
+	 * Currently, only OF fwnode is supported so extend this
+	 * function for ACPI support.
+	 */
+	if (!is_of_node(dev->fwnode))
+		return -EINVAL;
+
+	/* Save device pointer and register base */
+	priv->dev = dev;
+	priv->regs = regs;
+
+	/* Find out number of interrupt sources */
+	rc = of_property_read_u32(to_of_node(dev->fwnode),
+					     "riscv,num-sources",
+					     &priv->nr_irqs);
+	if (rc) {
+		dev_err(dev, "failed to get number of interrupt sources\n");
+		return rc;
+	}
+
+	/*
+	 * Find out number of IDCs based on parent interrupts
+	 *
+	 * If "msi-parent" property is present then we ignore the
+	 * APLIC IDCs which forces the APLIC driver to use MSI mode.
+	 */
+	if (!of_property_present(to_of_node(dev->fwnode), "msi-parent")) {
+		while (!of_irq_parse_one(to_of_node(dev->fwnode),
+					 priv->nr_idcs, &parent))
+			priv->nr_idcs++;
+	}
+
+	/* Setup initial state APLIC interrupts */
+	aplic_init_hw_irqs(priv);
+
+	return 0;
+}
+
+static int aplic_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	bool msi_mode = false;
+	struct resource *res;
+	void __iomem *regs;
+	int rc;
+
+	/* Map the MMIO registers */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "failed to get MMIO resource\n");
+		return -EINVAL;
+	}
+	regs = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!regs) {
+		dev_err(dev, "failed map MMIO registers\n");
+		return -ENOMEM;
+	}
+
+	/*
+	 * If msi-parent property is present then setup APLIC MSI
+	 * mode otherwise setup APLIC direct mode.
+	 */
+	if (is_of_node(dev->fwnode))
+		msi_mode = of_property_present(to_of_node(dev->fwnode),
+						"msi-parent");
+	if (msi_mode)
+		rc = -ENODEV;
+	else
+		rc = aplic_direct_setup(dev, regs);
+	if (rc) {
+		dev_err(dev, "failed setup APLIC in %s mode\n",
+			msi_mode ? "MSI" : "direct");
+		return rc;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id aplic_match[] = {
+	{ .compatible = "riscv,aplic" },
+	{}
+};
+
+static struct platform_driver aplic_driver = {
+	.driver = {
+		.name		= "riscv-aplic",
+		.of_match_table	= aplic_match,
+	},
+	.probe = aplic_probe,
+};
+builtin_platform_driver(aplic_driver);
diff --git a/drivers/irqchip/irq-riscv-aplic-main.h b/drivers/irqchip/irq-riscv-aplic-main.h
new file mode 100644
index 000000000000..474a04229334
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-aplic-main.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ */
+
+#ifndef _IRQ_RISCV_APLIC_MAIN_H
+#define _IRQ_RISCV_APLIC_MAIN_H
+
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/fwnode.h>
+
+#define APLIC_DEFAULT_PRIORITY		1
+
+struct aplic_msicfg {
+	phys_addr_t		base_ppn;
+	u32			hhxs;
+	u32			hhxw;
+	u32			lhxs;
+	u32			lhxw;
+};
+
+struct aplic_priv {
+	struct device		*dev;
+	u32			gsi_base;
+	u32			nr_irqs;
+	u32			nr_idcs;
+	void __iomem		*regs;
+	struct aplic_msicfg	msicfg;
+};
+
+void aplic_irq_unmask(struct irq_data *d);
+void aplic_irq_mask(struct irq_data *d);
+int aplic_irq_set_type(struct irq_data *d, unsigned int type);
+int aplic_irqdomain_translate(struct irq_fwspec *fwspec, u32 gsi_base,
+			      unsigned long *hwirq, unsigned int *type);
+void aplic_init_hw_global(struct aplic_priv *priv, bool msi_mode);
+int aplic_setup_priv(struct aplic_priv *priv, struct device *dev,
+		     void __iomem *regs);
+int aplic_direct_setup(struct device *dev, void __iomem *regs);
+
+#endif
diff --git a/include/linux/irqchip/riscv-aplic.h b/include/linux/irqchip/riscv-aplic.h
new file mode 100644
index 000000000000..97e198ea0109
--- /dev/null
+++ b/include/linux/irqchip/riscv-aplic.h
@@ -0,0 +1,119 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ */
+#ifndef __LINUX_IRQCHIP_RISCV_APLIC_H
+#define __LINUX_IRQCHIP_RISCV_APLIC_H
+
+#include <linux/bitops.h>
+
+#define APLIC_MAX_IDC			BIT(14)
+#define APLIC_MAX_SOURCE		1024
+
+#define APLIC_DOMAINCFG			0x0000
+#define APLIC_DOMAINCFG_RDONLY		0x80000000
+#define APLIC_DOMAINCFG_IE		BIT(8)
+#define APLIC_DOMAINCFG_DM		BIT(2)
+#define APLIC_DOMAINCFG_BE		BIT(0)
+
+#define APLIC_SOURCECFG_BASE		0x0004
+#define APLIC_SOURCECFG_D		BIT(10)
+#define APLIC_SOURCECFG_CHILDIDX_MASK	0x000003ff
+#define APLIC_SOURCECFG_SM_MASK	0x00000007
+#define APLIC_SOURCECFG_SM_INACTIVE	0x0
+#define APLIC_SOURCECFG_SM_DETACH	0x1
+#define APLIC_SOURCECFG_SM_EDGE_RISE	0x4
+#define APLIC_SOURCECFG_SM_EDGE_FALL	0x5
+#define APLIC_SOURCECFG_SM_LEVEL_HIGH	0x6
+#define APLIC_SOURCECFG_SM_LEVEL_LOW	0x7
+
+#define APLIC_MMSICFGADDR		0x1bc0
+#define APLIC_MMSICFGADDRH		0x1bc4
+#define APLIC_SMSICFGADDR		0x1bc8
+#define APLIC_SMSICFGADDRH		0x1bcc
+
+#ifdef CONFIG_RISCV_M_MODE
+#define APLIC_xMSICFGADDR		APLIC_MMSICFGADDR
+#define APLIC_xMSICFGADDRH		APLIC_MMSICFGADDRH
+#else
+#define APLIC_xMSICFGADDR		APLIC_SMSICFGADDR
+#define APLIC_xMSICFGADDRH		APLIC_SMSICFGADDRH
+#endif
+
+#define APLIC_xMSICFGADDRH_L		BIT(31)
+#define APLIC_xMSICFGADDRH_HHXS_MASK	0x1f
+#define APLIC_xMSICFGADDRH_HHXS_SHIFT	24
+#define APLIC_xMSICFGADDRH_LHXS_MASK	0x7
+#define APLIC_xMSICFGADDRH_LHXS_SHIFT	20
+#define APLIC_xMSICFGADDRH_HHXW_MASK	0x7
+#define APLIC_xMSICFGADDRH_HHXW_SHIFT	16
+#define APLIC_xMSICFGADDRH_LHXW_MASK	0xf
+#define APLIC_xMSICFGADDRH_LHXW_SHIFT	12
+#define APLIC_xMSICFGADDRH_BAPPN_MASK	0xfff
+
+#define APLIC_xMSICFGADDR_PPN_SHIFT	12
+
+#define APLIC_xMSICFGADDR_PPN_HART(__lhxs) \
+	(BIT(__lhxs) - 1)
+
+#define APLIC_xMSICFGADDR_PPN_LHX_MASK(__lhxw) \
+	(BIT(__lhxw) - 1)
+#define APLIC_xMSICFGADDR_PPN_LHX_SHIFT(__lhxs) \
+	((__lhxs))
+#define APLIC_xMSICFGADDR_PPN_LHX(__lhxw, __lhxs) \
+	(APLIC_xMSICFGADDR_PPN_LHX_MASK(__lhxw) << \
+	 APLIC_xMSICFGADDR_PPN_LHX_SHIFT(__lhxs))
+
+#define APLIC_xMSICFGADDR_PPN_HHX_MASK(__hhxw) \
+	(BIT(__hhxw) - 1)
+#define APLIC_xMSICFGADDR_PPN_HHX_SHIFT(__hhxs) \
+	((__hhxs) + APLIC_xMSICFGADDR_PPN_SHIFT)
+#define APLIC_xMSICFGADDR_PPN_HHX(__hhxw, __hhxs) \
+	(APLIC_xMSICFGADDR_PPN_HHX_MASK(__hhxw) << \
+	 APLIC_xMSICFGADDR_PPN_HHX_SHIFT(__hhxs))
+
+#define APLIC_IRQBITS_PER_REG		32
+
+#define APLIC_SETIP_BASE		0x1c00
+#define APLIC_SETIPNUM			0x1cdc
+
+#define APLIC_CLRIP_BASE		0x1d00
+#define APLIC_CLRIPNUM			0x1ddc
+
+#define APLIC_SETIE_BASE		0x1e00
+#define APLIC_SETIENUM			0x1edc
+
+#define APLIC_CLRIE_BASE		0x1f00
+#define APLIC_CLRIENUM			0x1fdc
+
+#define APLIC_SETIPNUM_LE		0x2000
+#define APLIC_SETIPNUM_BE		0x2004
+
+#define APLIC_GENMSI			0x3000
+
+#define APLIC_TARGET_BASE		0x3004
+#define APLIC_TARGET_HART_IDX_SHIFT	18
+#define APLIC_TARGET_HART_IDX_MASK	0x3fff
+#define APLIC_TARGET_GUEST_IDX_SHIFT	12
+#define APLIC_TARGET_GUEST_IDX_MASK	0x3f
+#define APLIC_TARGET_IPRIO_MASK	0xff
+#define APLIC_TARGET_EIID_MASK	0x7ff
+
+#define APLIC_IDC_BASE			0x4000
+#define APLIC_IDC_SIZE			32
+
+#define APLIC_IDC_IDELIVERY		0x00
+
+#define APLIC_IDC_IFORCE		0x04
+
+#define APLIC_IDC_ITHRESHOLD		0x08
+
+#define APLIC_IDC_TOPI			0x18
+#define APLIC_IDC_TOPI_ID_SHIFT	16
+#define APLIC_IDC_TOPI_ID_MASK	0x3ff
+#define APLIC_IDC_TOPI_PRIO_MASK	0xff
+
+#define APLIC_IDC_CLAIMI		0x1c
+
+#endif
-- 
2.34.1

