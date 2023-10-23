Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0169E7D3DB1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbjJWR3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjJWR3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:29:05 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FB11997
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:28:52 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6b44befac59so3343475b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698082131; x=1698686931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dP0rd1bglZJP8jyx5z7lgnmz0vdRJSPu0LJTWx3tkGQ=;
        b=V6WOawdaGqZLWdIzFu2iZyEHJeb8zI0UAR7Tei197V2SsD0BO8yra9YnGZ52Cpc9Zu
         4GquahVvLtBPsIK4i9MGCcIlsjP/Wi3Wh/UXcnTDXreSfZbP4Ca3rUSYVZe0OE7kaUXZ
         ktuVROBwqJiZWPDL07Iq2KbkY0zSvejMEWRSbFpkhVoqNH8QQi8YyKGqBOc1yhbosTHW
         l49NwwH5gyMcz6YmlSg0ta3wow8s5Mt80CNuUXuRK39KrIVcvyUGIVfnNlcKeORVya6p
         vV/+LFdIckfJ7hz7klGx06GWshwJtAImBYq6SZMfN9xTiQ84SsxL0oSmDshy0WvnVs+c
         2rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698082131; x=1698686931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dP0rd1bglZJP8jyx5z7lgnmz0vdRJSPu0LJTWx3tkGQ=;
        b=dgfG2NXU+HFmzERHJi529bwKn2i/chYVd/1206G5bIVZMLhCB4nZYPP+LbOgANP+gr
         t4xg6TJ74ukdffTu/7plocaLmLdXfMsEy1SrLU1bHsB32rwEWFEoC0v3l5lyrpj9Oy/o
         BgSA/2Stxb7hIzHWWqni2ZYrfShUxsVS1SLaqO71YA6ov94btXt2JWYHq0bL1/SAGeoE
         WN9+ldK1jM0VefvDiAiyXAwgYnKrVI4BMxXya6HhFBW4BK8zYyRj+KJhbVPu0TxtblPe
         lhlhMrwBSgYeQw0QJyunarlbVtuU/XrL2oqOmYjzlEVKqLiJcE4w/g1ImS1/mAhqg/my
         /odA==
X-Gm-Message-State: AOJu0Yy7rTodQaiVH5Zg6F94YwiN2GzourlpHAIa3Hq5Pd7pSaI3x7n8
        lyhDUiTkQSFxGz5Ekkb2jjLdMQ==
X-Google-Smtp-Source: AGHT+IGXoii+P1b9dgt2aDoEIN34trsES6znhAqUc3+Ykmyt7TzrsiiKYA4EJBEs9Qbsduin8Ns6+g==
X-Received: by 2002:a05:6a20:12c5:b0:17b:1f76:86ee with SMTP id v5-20020a056a2012c500b0017b1f7686eemr331329pzg.16.1698082131164;
        Mon, 23 Oct 2023 10:28:51 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.86.9])
        by smtp.gmail.com with ESMTPSA id g5-20020aa79f05000000b006be055ab117sm6473194pfr.92.2023.10.23.10.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 10:28:50 -0700 (PDT)
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
Subject: [PATCH v11 08/14] irqchip/riscv-imsic: Add support for platform MSI irqdomain
Date:   Mon, 23 Oct 2023 22:57:54 +0530
Message-Id: <20231023172800.315343-9-apatel@ventanamicro.com>
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

The Linux platform MSI support requires a platform MSI irqdomain so
let us add a platform irqchip driver for RISC-V IMSIC which provides
a base IRQ domain and platform MSI domain. This driver assumes that
the IMSIC state is already initialized by the IMSIC early driver.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/Makefile                   |   2 +-
 drivers/irqchip/irq-riscv-imsic-platform.c | 309 +++++++++++++++++++++
 2 files changed, 310 insertions(+), 1 deletion(-)
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
index 000000000000..23d286cb017e
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -0,0 +1,309 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ */
+
+#define pr_fmt(fmt) "riscv-imsic: " fmt
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
+static void imsic_irq_mask(struct irq_data *d)
+{
+	imsic_vector_mask(irq_data_get_irq_chip_data(d));
+}
+
+static void imsic_irq_unmask(struct irq_data *d)
+{
+	imsic_vector_unmask(irq_data_get_irq_chip_data(d));
+}
+
+static void imsic_irq_compose_vector_msg(struct imsic_vector *vec,
+					 struct msi_msg *msg)
+{
+	phys_addr_t msi_addr;
+	int err;
+
+	if (WARN_ON(vec == NULL))
+		return;
+
+	err = imsic_cpu_page_phys(vec->cpu, 0, &msi_addr);
+	if (WARN_ON(err))
+		return;
+
+	msg->address_hi = upper_32_bits(msi_addr);
+	msg->address_lo = lower_32_bits(msi_addr);
+	msg->data = IMSIC_VECTOR_BASE_LOCAL_ID(vec);
+}
+
+static void imsic_irq_compose_msg(struct irq_data *d, struct msi_msg *msg)
+{
+	imsic_irq_compose_vector_msg(irq_data_get_irq_chip_data(d), msg);
+}
+
+#ifdef CONFIG_SMP
+static void imsic_msi_update_msg(struct irq_data *d, struct imsic_vector *vec)
+{
+	struct msi_msg msg[2] = { [1] = { }, };
+
+	imsic_irq_compose_vector_msg(vec, msg);
+	irq_data_get_irq_chip(d)->irq_write_msi_msg(d, msg);
+}
+
+static int imsic_irq_set_affinity(struct irq_data *d,
+				  const struct cpumask *mask_val,
+				  bool force)
+{
+	struct imsic_vector *old_vec, *new_vec;
+	struct irq_data *pd = d->parent_data;
+	unsigned int i, virq, hwirq;
+
+	old_vec = irq_data_get_irq_chip_data(pd);
+	if (WARN_ON(old_vec == NULL))
+		return -ENOENT;
+
+	/* Find-out base virq, hwirq and order of the old vector */
+	hwirq = IMSIC_VECTOR_BASE_HWIRQ(old_vec);
+	virq = pd->irq - (old_vec->hwirq - hwirq);
+
+	/* Ensure old vector points to the first entry */
+	if (old_vec->hwirq != hwirq) {
+		pd = irq_domain_get_irq_data(imsic->base_domain, virq);
+		old_vec = irq_data_get_irq_chip_data(pd);
+	}
+
+	/* Get a new vector on the desired set of CPUs */
+	new_vec = imsic_vector_alloc(hwirq, mask_val, old_vec->order);
+	if (!new_vec)
+		return -ENOSPC;
+
+	/* If old vector belongs to the desired CPU then do nothing */
+	if (old_vec->cpu == new_vec->cpu) {
+		imsic_vector_free(new_vec);
+		return IRQ_SET_MASK_OK_DONE;
+	}
+
+	/* Point device to the new vector */
+	imsic_msi_update_msg(d, new_vec);
+
+	/* Update irq descriptors */
+	for (i = 0; i < BIT(old_vec->order); i++) {
+		pd = irq_domain_get_irq_data(imsic->base_domain, virq + i);
+
+		/* Save the new vector entry in irq descriptor*/
+		pd->chip_data = new_vec + i;
+
+		/* Update effective affinity of parent irq data */
+		irq_data_update_effective_affinity(pd,
+						cpumask_of(new_vec->cpu));
+	}
+
+	/* Move state of the old vector to the new vector */
+	imsic_vector_move(old_vec, new_vec);
+
+	return IRQ_SET_MASK_OK_DONE;
+}
+#endif
+
+static struct irq_chip imsic_irq_base_chip = {
+	.name			= "IMSIC-BASE",
+	.irq_mask		= imsic_irq_mask,
+	.irq_unmask		= imsic_irq_unmask,
+	.irq_compose_msi_msg	= imsic_irq_compose_msg,
+	.flags			= IRQCHIP_SKIP_SET_WAKE |
+				  IRQCHIP_MASK_ON_SUSPEND,
+};
+
+static int imsic_irq_domain_alloc(struct irq_domain *domain,
+				  unsigned int virq, unsigned int nr_irqs,
+				  void *args)
+{
+	struct imsic_vector *vec;
+	int i, hwirq;
+
+	hwirq = imsic_hwirqs_alloc(get_count_order(nr_irqs));
+	if (hwirq < 0)
+		return hwirq;
+
+	vec = imsic_vector_alloc(hwirq, cpu_online_mask,
+				 get_count_order(nr_irqs));
+	if (!vec) {
+		imsic_hwirqs_free(hwirq, get_count_order(nr_irqs));
+		return -ENOSPC;
+	}
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_domain_set_info(domain, virq + i, hwirq + i,
+				    &imsic_irq_base_chip, vec + i,
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
+	imsic_vector_free(irq_data_get_irq_chip_data(d));
+	imsic_hwirqs_free(d->hwirq, get_count_order(nr_irqs));
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+}
+
+#ifdef CONFIG_GENERIC_IRQ_DEBUGFS
+static void imsic_irq_debug_show(struct seq_file *m, struct irq_domain *d,
+				 struct irq_data *irqd, int ind)
+{
+	if (!irqd) {
+		imsic_vector_debug_show_summary(m, ind);
+		return;
+	}
+
+	imsic_vector_debug_show(m, irq_data_get_irq_chip_data(irqd), ind);
+}
+#endif
+
+static const struct irq_domain_ops imsic_base_domain_ops = {
+	.alloc		= imsic_irq_domain_alloc,
+	.free		= imsic_irq_domain_free,
+#ifdef CONFIG_GENERIC_IRQ_DEBUGFS
+	.debug_show	= imsic_irq_debug_show,
+#endif
+};
+
+static struct irq_chip imsic_plat_irq_chip = {
+	.name			= "IMSIC-PLAT",
+#ifdef CONFIG_SMP
+	.irq_set_affinity	= imsic_irq_set_affinity,
+#endif
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
+static int imsic_irq_domains_init(struct fwnode_handle *fwnode)
+{
+	/* Create Base IRQ domain */
+	imsic->base_domain = irq_domain_create_tree(fwnode,
+					&imsic_base_domain_ops, imsic);
+	if (!imsic->base_domain) {
+		pr_err("%pfwP: failed to create IMSIC base domain\n",
+			fwnode);
+		return -ENOMEM;
+	}
+	irq_domain_update_bus_token(imsic->base_domain, DOMAIN_BUS_NEXUS);
+
+	/* Create Platform MSI domain */
+	imsic->plat_domain = platform_msi_create_irq_domain(fwnode,
+						&imsic_plat_domain_info,
+						imsic->base_domain);
+	if (!imsic->plat_domain) {
+		pr_err("%pfwP: failed to create IMSIC platform domain\n",
+			fwnode);
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
+	rc = imsic_irq_domains_init(dev->fwnode);
+	if (rc) {
+		dev_err(dev, "failed to initialize IRQ and MSI domains\n");
+		return rc;
+	}
+
+	dev_info(dev, "  hart-index-bits: %d,  guest-index-bits: %d\n",
+		 global->hart_index_bits, global->guest_index_bits);
+	dev_info(dev, " group-index-bits: %d, group-index-shift: %d\n",
+		 global->group_index_bits, global->group_index_shift);
+	dev_info(dev, " per-CPU IDs %d at base PPN %pa\n",
+		 global->nr_ids, &global->base_addr);
+	dev_info(dev, " total %d interrupts available\n",
+		 imsic->nr_hwirqs);
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
+builtin_platform_driver(imsic_platform_driver);
-- 
2.34.1

