Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E03279D800
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237054AbjILRvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236914AbjILRvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:51:24 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F5F10D3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:51:20 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68fb5bd8f02so2459367b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1694541080; x=1695145880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqLslZ2IpeL26Xg5SufuITXQb4lOmt+bkcLgkdLrkFY=;
        b=PIfFuFBeOWLV0PQJyHX8taiBXc+t9aXmA4HBP2SR8pm+63C+XxQRrz47fLAOOoAkyu
         fiSAogVX0SSK+dTgGKeNfTUMrcHocnusVr02hhOJb6vgexVlQRXUuIKiqIFVTKeqc1Vq
         W0kc8dStJG4PCfUPT3xeQSiEifuxmU3205/AVJgByjsutManuvJ1QKhchOxbevSdTcSP
         eI2vrH1OnAWnxngyMYFBP+ZNujxQg6RYXEhZPFUo71j0STiRXmGk5r6Lq/M7HEPN94jk
         Q7gLF7gPOqGHSR5PQkbOCkgtIpvsB9exI6nhQ3u3RX7sH9tj/DDJmpAplxXtuTinHfGc
         rYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694541080; x=1695145880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EqLslZ2IpeL26Xg5SufuITXQb4lOmt+bkcLgkdLrkFY=;
        b=aDlGy/MBDKYLYDhg9oR6SY/MMMdlBMRuXQuaJJmGS+DnUjuoQqe1+8NjCRnn1JnYpX
         xEZ3MUmzFcE6F8ZkYcMRSAaw0sm99H8HVTOjnxkwYvhlQvT5POoJoqP6FSgQt5bLR1WX
         bMbAStZEkqVdsyytadDey9ZrapF0U/zc0R30orcudhKuLTbWDIinp010mdx3my+3XQKB
         XAKb49wzO5uVpnhqkcalG52G/TRH+l1JAIHBnwvJuSE/muNv8fIla2JnAUZwi6OfKevx
         hoAJzNXNBmCZ0mLc9n26b5io8fDyw6ZjRicphHU99JqZZ+eH7z0SMKzlR5z4Z+QROxkz
         de7g==
X-Gm-Message-State: AOJu0Yzp6nx+/y5icVkTosIaJGBJ7mjGZ/ecKoiDBYkVrefhntxNVrU+
        V77fZ44s2HXoHUWSEa40Y467Yw==
X-Google-Smtp-Source: AGHT+IHms4mWc9POGy9MJMt8YY4PFiwfPPOw5qM8IA71I9OCknFSiJRXEDiDm5kqUlhzg3QOW6cy5g==
X-Received: by 2002:a05:6a20:ce91:b0:14b:f9b2:eb7 with SMTP id if17-20020a056a20ce9100b0014bf9b20eb7mr103534pzb.59.1694541079814;
        Tue, 12 Sep 2023 10:51:19 -0700 (PDT)
Received: from localhost.localdomain ([171.76.81.83])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902a40c00b001b891259eddsm8691440plq.197.2023.09.12.10.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 10:51:19 -0700 (PDT)
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
Subject: [PATCH v8 10/16] irqchip/riscv-imsic: Add support for platform MSI irqdomain
Date:   Tue, 12 Sep 2023 23:19:22 +0530
Message-Id: <20230912174928.528414-11-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912174928.528414-1-apatel@ventanamicro.com>
References: <20230912174928.528414-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux platform MSI support requires a platform MSI irqdomain so
let us add a platform irqchip driver for RISC-V IMSIC which provides
a base IRQ domain and platform MSI domain. This driver assumes that
the IMSIC state is already initialized by the IMSIC early driver.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/Makefile                   |   2 +-
 drivers/irqchip/irq-riscv-imsic-platform.c | 280 +++++++++++++++++++++
 2 files changed, 281 insertions(+), 1 deletion(-)
 create mode 100644 drivers/irqchip/irq-riscv-imsic-platform.c

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index d714724387ce..abca445a3229 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -95,7 +95,7 @@ obj-$(CONFIG_QCOM_MPM)			+= irq-qcom-mpm.o
 obj-$(CONFIG_CSKY_MPINTC)		+= irq-csky-mpintc.o
 obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
 obj-$(CONFIG_RISCV_INTC)		+= irq-riscv-intc.o
-obj-$(CONFIG_RISCV_IMSIC)		+= irq-riscv-imsic-state.o irq-riscv-imsic-early.o
+obj-$(CONFIG_RISCV_IMSIC)		+= irq-riscv-imsic-state.o irq-riscv-imsic-early.o irq-riscv-imsic-platform.o
 obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
 obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
 obj-$(CONFIG_IMX_INTMUX)		+= irq-imx-intmux.o
diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
new file mode 100644
index 000000000000..b78f1b2ee3dc
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -0,0 +1,280 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ */
+
+#include <linux/bitmap.h>
+#include <linux/cpu.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <linux/smp.h>
+
+#include "irq-riscv-imsic-state.h"
+
+static int imsic_cpu_page_phys(unsigned int cpu,
+			       unsigned int guest_index,
+			       phys_addr_t *out_msi_pa)
+{
+	struct imsic_global_config *global;
+	struct imsic_local_config *local;
+
+	global = &imsic->global;
+	local = per_cpu_ptr(global->local, cpu);
+
+	if (BIT(global->guest_index_bits) <= guest_index)
+		return -EINVAL;
+
+	if (out_msi_pa)
+		*out_msi_pa = local->msi_pa +
+			      (guest_index * IMSIC_MMIO_PAGE_SZ);
+
+	return 0;
+}
+
+static int imsic_get_cpu(const struct cpumask *mask_val, bool force,
+			 unsigned int *out_target_cpu)
+{
+	unsigned int cpu;
+
+	if (force)
+		cpu = cpumask_first(mask_val);
+	else
+		cpu = cpumask_any_and(mask_val, cpu_online_mask);
+
+	if (cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	if (out_target_cpu)
+		*out_target_cpu = cpu;
+
+	return 0;
+}
+
+static void imsic_irq_mask(struct irq_data *d)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&imsic->ids_lock, flags);
+	bitmap_clear(imsic->ids_enabled_bimap, d->hwirq, 1);
+	__imsic_id_disable(d->hwirq);
+	raw_spin_unlock_irqrestore(&imsic->ids_lock, flags);
+
+	imsic_ids_remote_sync();
+}
+
+static void imsic_irq_unmask(struct irq_data *d)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&imsic->ids_lock, flags);
+	bitmap_set(imsic->ids_enabled_bimap, d->hwirq, 1);
+	__imsic_id_enable(d->hwirq);
+	raw_spin_unlock_irqrestore(&imsic->ids_lock, flags);
+
+	imsic_ids_remote_sync();
+}
+
+static void imsic_irq_compose_msi_msg(struct irq_data *d,
+				      struct msi_msg *msg)
+{
+	phys_addr_t msi_addr;
+	unsigned int cpu;
+	int err;
+
+	cpu = imsic_id_get_target(d->hwirq);
+	if (WARN_ON(cpu == UINT_MAX))
+		return;
+
+	err = imsic_cpu_page_phys(cpu, 0, &msi_addr);
+	if (WARN_ON(err))
+		return;
+
+	msg->address_hi = upper_32_bits(msi_addr);
+	msg->address_lo = lower_32_bits(msi_addr);
+	msg->data = d->hwirq;
+}
+
+#ifdef CONFIG_SMP
+static int imsic_irq_set_affinity(struct irq_data *d,
+				  const struct cpumask *mask_val,
+				  bool force)
+{
+	unsigned int target_cpu;
+	int rc;
+
+	rc = imsic_get_cpu(mask_val, force, &target_cpu);
+	if (rc)
+		return rc;
+
+	imsic_id_set_target(d->hwirq, target_cpu);
+	irq_data_update_effective_affinity(d, cpumask_of(target_cpu));
+
+	return IRQ_SET_MASK_OK;
+}
+#endif
+
+static struct irq_chip imsic_irq_base_chip = {
+	.name			= "IMSIC-BASE",
+	.irq_mask		= imsic_irq_mask,
+	.irq_unmask		= imsic_irq_unmask,
+#ifdef CONFIG_SMP
+	.irq_set_affinity	= imsic_irq_set_affinity,
+#endif
+	.irq_compose_msi_msg	= imsic_irq_compose_msi_msg,
+	.flags			= IRQCHIP_SKIP_SET_WAKE |
+				  IRQCHIP_MASK_ON_SUSPEND,
+};
+
+static int imsic_irq_domain_alloc(struct irq_domain *domain,
+				  unsigned int virq,
+				  unsigned int nr_irqs,
+				  void *args)
+{
+	int i, hwirq, err = 0;
+	unsigned int cpu;
+
+	err = imsic_get_cpu(cpu_online_mask, false, &cpu);
+	if (err)
+		return err;
+
+	hwirq = imsic_ids_alloc(get_count_order(nr_irqs));
+	if (hwirq < 0)
+		return hwirq;
+
+	for (i = 0; i < nr_irqs; i++) {
+		imsic_id_set_target(hwirq + i, cpu);
+		irq_domain_set_info(domain, virq + i, hwirq + i,
+				    &imsic_irq_base_chip, imsic,
+				    handle_simple_irq, NULL, NULL);
+		irq_set_noprobe(virq + i);
+		irq_set_affinity(virq + i, cpu_online_mask);
+		/*
+		 * IMSIC does not implement irq_disable() so Linux interrupt
+		 * subsystem will take a lazy approach for disabling an IMSIC
+		 * interrupt. This means IMSIC interrupts are left unmasked
+		 * upon system suspend and interrupts are not processed
+		 * immediately upon system wake up. To tackle this, we disable
+		 * the lazy approach for all IMSIC interrupts.
+		 */
+		irq_set_status_flags(virq + i, IRQ_DISABLE_UNLAZY);
+	}
+
+	return 0;
+}
+
+static void imsic_irq_domain_free(struct irq_domain *domain,
+				  unsigned int virq,
+				  unsigned int nr_irqs)
+{
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+
+	imsic_ids_free(d->hwirq, get_count_order(nr_irqs));
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+}
+
+static const struct irq_domain_ops imsic_base_domain_ops = {
+	.alloc		= imsic_irq_domain_alloc,
+	.free		= imsic_irq_domain_free,
+};
+
+static struct irq_chip imsic_plat_irq_chip = {
+	.name			= "IMSIC-PLAT",
+};
+
+static struct msi_domain_ops imsic_plat_domain_ops = {
+};
+
+static struct msi_domain_info imsic_plat_domain_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
+	.ops	= &imsic_plat_domain_ops,
+	.chip	= &imsic_plat_irq_chip,
+};
+
+static int imsic_irq_domains_init(struct device *dev)
+{
+	/* Create Base IRQ domain */
+	imsic->base_domain = irq_domain_create_tree(dev->fwnode,
+					&imsic_base_domain_ops, imsic);
+	if (!imsic->base_domain) {
+		dev_err(dev, "failed to create IMSIC base domain\n");
+		return -ENOMEM;
+	}
+	irq_domain_update_bus_token(imsic->base_domain, DOMAIN_BUS_NEXUS);
+
+	/* Create Platform MSI domain */
+	imsic->plat_domain = platform_msi_create_irq_domain(dev->fwnode,
+						&imsic_plat_domain_info,
+						imsic->base_domain);
+	if (!imsic->plat_domain) {
+		dev_err(dev, "failed to create IMSIC platform domain\n");
+		irq_domain_remove(imsic->base_domain);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int imsic_platform_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct imsic_global_config *global;
+	int rc;
+
+	if (!imsic) {
+		dev_err(dev, "early driver not probed\n");
+		return -ENODEV;
+	}
+
+	if (imsic->base_domain) {
+		dev_err(dev, "irq domain already created\n");
+		return -ENODEV;
+	}
+
+	global = &imsic->global;
+
+	/* Initialize IRQ and MSI domains */
+	rc = imsic_irq_domains_init(dev);
+	if (rc) {
+		dev_err(dev, "failed to initialize IRQ and MSI domains\n");
+		return rc;
+	}
+
+	dev_info(dev, "  hart-index-bits: %d,  guest-index-bits: %d\n",
+		 global->hart_index_bits, global->guest_index_bits);
+	dev_info(dev, " group-index-bits: %d, group-index-shift: %d\n",
+		 global->group_index_bits, global->group_index_shift);
+	dev_info(dev, " mapped %d interrupts at base PPN %pa\n",
+		 global->nr_ids, &global->base_addr);
+
+	return 0;
+}
+
+static const struct of_device_id imsic_platform_match[] = {
+	{ .compatible = "riscv,imsics" },
+	{}
+};
+
+static struct platform_driver imsic_platform_driver = {
+	.driver = {
+		.name		= "riscv-imsic",
+		.of_match_table	= imsic_platform_match,
+	},
+	.probe = imsic_platform_probe,
+};
+
+static int __init imsic_platform_init(void)
+{
+	/*
+	 * Register IMSIC driver as early as possible so that IMSIC
+	 * platform device is probed as soon as it is created.
+	 */
+	return platform_driver_register(&imsic_platform_driver);
+}
+core_initcall(imsic_platform_init);
-- 
2.34.1

