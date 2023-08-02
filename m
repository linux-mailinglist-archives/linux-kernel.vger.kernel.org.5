Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B78D76D0E6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbjHBPCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbjHBPCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:02:25 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6628C4200
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 08:01:43 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bbdc05a93bso43878785ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 08:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1690988489; x=1691593289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqLslZ2IpeL26Xg5SufuITXQb4lOmt+bkcLgkdLrkFY=;
        b=WVtR08sfgmdEnEVpHjiIVI0pX6IT1UM2u9fL+5W7L1AzWejfkUj8A4/42o4FzRuk2y
         3cOfg8V2QualwE8+eiA62vy8WNJqLokUgulGSCi3IqnX2zu+fr9BN7hNcyqnHPjOEaOn
         S3vqG5zyVyIWdeTdyyt16D7WKFwsTOVDXmI3Aco7hbgqLHq0G67H1AFwY8MudO0nBS/p
         b+/cGOu1qgSdwz9x5PdTjYzlOGm1jDQXkRb6+6uTDnc3P5klvVKyfgf4asLB1rMVKRev
         tuyAutRCUZXP2Dloo1RNfOjkAszuEe4A71C0I8hXBeUs/5sVZcmJA2BkQXYz5flxUtp0
         SflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690988489; x=1691593289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EqLslZ2IpeL26Xg5SufuITXQb4lOmt+bkcLgkdLrkFY=;
        b=TPuj/2u5asQuC65JAMuajCkv1lESI4CtnhTnrVuPFxCSK8nRuh4eG16/1D4CeygLkO
         Qilj8oNvyP8LjApppHdvSFAG7NWJVWl3sH4qpRWzPl8X2dBVrDVKtDqHi+WiR0rvxy3P
         SUKrg4jN9m6zZkjl/DY/ma6Trt3raHrx8ojTqMBuWzUwnyvuNqB8iR34B8CPRMTxdIeX
         fzYsyCD+0vA+ezVnNN2fFZNzbD4nRt0k8ndLkV/Pn5NX32T4vcWGkD/X2ILQMsPIxy3J
         gGYuW8OrFKXInmWWejFjkIiLvUKhCjeIZHZKw4ayUb78UBlFesXZI4KJrjq6QMh58pd/
         HnRQ==
X-Gm-Message-State: ABy/qLatDEk72I47KV8JxFnVw4Xrr2pP1cQXZLvL+Emq+UM6E1ECKe/c
        HVQyDkOOaD1VdIFFU+vfOmPS3w==
X-Google-Smtp-Source: APBJJlEp2Xh6iaFtg8hFq9/uOZtzjAsVjnvbljstsAQSmQB9MPdWyHX9RIiGZ7b24K4jhsGepd4I5Q==
X-Received: by 2002:a17:902:d489:b0:1b8:8069:d432 with SMTP id c9-20020a170902d48900b001b88069d432mr15816183plg.16.1690988488655;
        Wed, 02 Aug 2023 08:01:28 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id v11-20020a1709028d8b00b001bb99e188fcsm12503963plo.194.2023.08.02.08.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 08:01:28 -0700 (PDT)
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
Subject: [PATCH v7 09/15] irqchip/riscv-imsic: Add support for platform MSI irqdomain
Date:   Wed,  2 Aug 2023 20:30:12 +0530
Message-Id: <20230802150018.327079-10-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230802150018.327079-1-apatel@ventanamicro.com>
References: <20230802150018.327079-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

