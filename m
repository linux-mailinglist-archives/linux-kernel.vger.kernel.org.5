Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04267B1271
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjI1GNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjI1GNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:13:32 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9751A5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 23:13:25 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-3513fa06bafso25695635ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 23:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695881604; x=1696486404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MliKW0PO/NiUQNarKv7L85fBcDqA4HvgVA9noixRcgg=;
        b=QvfpBuzVUoFQbTQKdZx1RFRiCckEtnTp92FaiFSBGXH4oMWGGjreYw7cr7peFVKhfs
         IrHE/acTlzP6CSisbX3qS6f/Uy0IljlixVoWJq0XKXgt95QA+GGc+2S5sRb6p79W7YbD
         JDUTpCIzEPWm9/X2JZugg8R5BTVQGcYmsXnNu5vXJhU4CYnOUNZCHxTEz7G8Oe4IFy/V
         EF5qEyU99KA4SvsE0gB4JVezOVRNatKfxs8Buzbnj4ufjyva1X0ekC/uFazAyUgIUud8
         AlDdVyXB/NLzXWfaAL0htu2W8EWwf93NYHnqeXrc7xfNi9gGxmHK9/RjJQ8Q/BfvS0fw
         dlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695881604; x=1696486404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MliKW0PO/NiUQNarKv7L85fBcDqA4HvgVA9noixRcgg=;
        b=lX1CcJY+8tRz/R904n7/J3YtFSokvDOrI5FHEUldHjjGbdKA89p+Us+OhTXx0UDovz
         LqNzOGV8X1qTmqpb51pVjZanGRPF+Z/G2ZJk2XFH9KY6eQPBr4AcAcHlt186XmYN0M2i
         SMJ5D29sMB3Hzx/+z2fF1zS4ZqoJqJCn0ZCmXXU6qLB3zQ2XEHZoH8+CCsEVI37STx1s
         44jPzGFMT6Lao/BhNQL+NK3fPdgvxo0JNVk3bhnY9Gp0TeN/euTWhz6Z7INLd21TxzXW
         5ALu2tcJai7fNDhkFxlZE5QQcLrvFneE/Xn/ida9WRstuRgo+visNZ/ZmepG3KgIgv2v
         qK/A==
X-Gm-Message-State: AOJu0YzloPGsQyFPkaBnCe2sWlFnRY5l80ublwqprwHyepQWAQKPmAEa
        T05o1jWgcO+wrJuYDl51FvIEIQ==
X-Google-Smtp-Source: AGHT+IFp6yBVBwYq2mHyOPmYnBW08LH2urrnLsZpuo6GG/pDR5eTvzHGNfra357HHnJoRSEiox2i4A==
X-Received: by 2002:a05:6e02:1c8e:b0:351:4b68:ec3a with SMTP id w14-20020a056e021c8e00b003514b68ec3amr280637ill.9.1695881604030;
        Wed, 27 Sep 2023 23:13:24 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id x6-20020a92d306000000b003506f457d70sm4774467ila.63.2023.09.27.23.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 23:13:23 -0700 (PDT)
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
Subject: [PATCH v9 08/15] irqchip: Add RISC-V incoming MSI controller early driver
Date:   Thu, 28 Sep 2023 11:42:00 +0530
Message-Id: <20230928061207.1841513-9-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928061207.1841513-1-apatel@ventanamicro.com>
References: <20230928061207.1841513-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISC-V advanced interrupt architecture (AIA) specification
defines a new MSI controller called incoming message signalled
interrupt controller (IMSIC) which manages MSI on per-HART (or
per-CPU) basis. It also supports IPIs as software injected MSIs.
(For more details refer https://github.com/riscv/riscv-aia)

Let us add an early irqchip driver for RISC-V IMSIC which sets
up the IMSIC state and provide IPIs.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/Kconfig                 |   6 +
 drivers/irqchip/Makefile                |   1 +
 drivers/irqchip/irq-riscv-imsic-early.c | 259 +++++++++++
 drivers/irqchip/irq-riscv-imsic-state.c | 570 ++++++++++++++++++++++++
 drivers/irqchip/irq-riscv-imsic-state.h |  66 +++
 include/linux/irqchip/riscv-imsic.h     |  86 ++++
 6 files changed, 988 insertions(+)
 create mode 100644 drivers/irqchip/irq-riscv-imsic-early.c
 create mode 100644 drivers/irqchip/irq-riscv-imsic-state.c
 create mode 100644 drivers/irqchip/irq-riscv-imsic-state.h
 create mode 100644 include/linux/irqchip/riscv-imsic.h

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index f7149d0f3d45..bdd80716114d 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -546,6 +546,12 @@ config SIFIVE_PLIC
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 
+config RISCV_IMSIC
+	bool
+	depends on RISCV
+	select IRQ_DOMAIN_HIERARCHY
+	select GENERIC_MSI_IRQ
+
 config EXYNOS_IRQ_COMBINER
 	bool "Samsung Exynos IRQ combiner support" if COMPILE_TEST
 	depends on (ARCH_EXYNOS && ARM) || COMPILE_TEST
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index ffd945fe71aa..d714724387ce 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -95,6 +95,7 @@ obj-$(CONFIG_QCOM_MPM)			+= irq-qcom-mpm.o
 obj-$(CONFIG_CSKY_MPINTC)		+= irq-csky-mpintc.o
 obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
 obj-$(CONFIG_RISCV_INTC)		+= irq-riscv-intc.o
+obj-$(CONFIG_RISCV_IMSIC)		+= irq-riscv-imsic-state.o irq-riscv-imsic-early.o
 obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
 obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
 obj-$(CONFIG_IMX_INTMUX)		+= irq-imx-intmux.o
diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-riscv-imsic-early.c
new file mode 100644
index 000000000000..68561ca385e8
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ */
+
+#define pr_fmt(fmt) "riscv-imsic: " fmt
+#include <linux/cpu.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/smp.h>
+
+#include "irq-riscv-imsic-state.h"
+
+/*
+ * The IMSIC driver uses 1 IPI for ID synchronization and
+ * arch/riscv/kernel/smp.c require 6 IPIs so we fix the
+ * total number of IPIs to 8.
+ */
+#define IMSIC_NR_IPI				8
+
+static int imsic_parent_irq;
+
+#ifdef CONFIG_SMP
+static irqreturn_t imsic_ids_sync_handler(int irq, void *data)
+{
+	imsic_ids_local_sync();
+	return IRQ_HANDLED;
+}
+
+void imsic_ids_remote_sync(void)
+{
+	struct cpumask amask;
+
+	/*
+	 * We simply inject ID synchronization IPI to all target CPUs
+	 * except current CPU. The ipi_send_mask() implementation of
+	 * IPI mux will inject ID synchronization IPI only for CPUs
+	 * that have enabled it so offline CPUs won't receive IPI.
+	 * An offline CPU will unconditionally synchronize IDs through
+	 * imsic_starting_cpu() when the CPU is brought up.
+	 */
+	cpumask_andnot(&amask, cpu_online_mask, cpumask_of(smp_processor_id()));
+	__ipi_send_mask(imsic->ipi_lsync_desc, &amask);
+}
+
+static void imsic_ipi_send(unsigned int cpu)
+{
+	struct imsic_local_config *local =
+				per_cpu_ptr(imsic->global.local, cpu);
+
+	writel(imsic->ipi_id, local->msi_va);
+}
+
+static void imsic_ipi_starting_cpu(void)
+{
+	/* Enable IPIs for current CPU. */
+	__imsic_id_enable(imsic->ipi_id);
+
+	/* Enable virtual IPI used for IMSIC ID synchronization */
+	enable_percpu_irq(imsic->ipi_virq, 0);
+}
+
+static void imsic_ipi_dying_cpu(void)
+{
+	/*
+	 * Disable virtual IPI used for IMSIC ID synchronization so
+	 * that we don't receive ID synchronization requests.
+	 */
+	disable_percpu_irq(imsic->ipi_virq);
+}
+
+static int __init imsic_ipi_domain_init(void)
+{
+	int virq;
+
+	/* Allocate interrupt identity for IPIs */
+	virq = imsic_ids_alloc(get_count_order(1));
+	if (virq < 0)
+		return virq;
+	imsic->ipi_id = virq;
+
+	/* Create IMSIC IPI multiplexing */
+	virq = ipi_mux_create(IMSIC_NR_IPI, imsic_ipi_send);
+	if (virq <= 0) {
+		imsic_ids_free(imsic->ipi_id, get_count_order(1));
+		return (virq < 0) ? virq : -ENOMEM;
+	}
+	imsic->ipi_virq = virq;
+
+	/* First vIRQ is used for IMSIC ID synchronization */
+	virq = request_percpu_irq(imsic->ipi_virq, imsic_ids_sync_handler,
+				  "riscv-imsic-lsync", imsic->global.local);
+	if (virq) {
+		imsic_ids_free(imsic->ipi_id, get_count_order(1));
+		return virq;
+	}
+	irq_set_status_flags(imsic->ipi_virq, IRQ_HIDDEN);
+	imsic->ipi_lsync_desc = irq_to_desc(imsic->ipi_virq);
+
+	/* Set vIRQ range */
+	riscv_ipi_set_virq_range(imsic->ipi_virq + 1, IMSIC_NR_IPI - 1, true);
+
+	/* Announce that IMSIC is providing IPIs */
+	pr_info("%pfwP: providing IPIs using interrupt %d\n",
+		imsic->fwnode, imsic->ipi_id);
+
+	return 0;
+}
+#else
+static void imsic_ipi_starting_cpu(void)
+{
+}
+
+static void imsic_ipi_dying_cpu(void)
+{
+}
+
+static int __init imsic_ipi_domain_init(void)
+{
+	/* Clear the IPI id because we are not using IPIs */
+	imsic->ipi_id = 0;
+	return 0;
+}
+#endif
+
+/*
+ * To handle an interrupt, we read the TOPEI CSR and write zero in one
+ * instruction. If TOPEI CSR is non-zero then we translate TOPEI.ID to
+ * Linux interrupt number and let Linux IRQ subsystem handle it.
+ */
+static void imsic_handle_irq(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	irq_hw_number_t hwirq;
+	int err;
+
+	chained_irq_enter(chip, desc);
+
+	while ((hwirq = csr_swap(CSR_TOPEI, 0))) {
+		hwirq = hwirq >> TOPEI_ID_SHIFT;
+
+		if (hwirq == imsic->ipi_id) {
+#ifdef CONFIG_SMP
+			ipi_mux_process();
+#endif
+			continue;
+		}
+
+		if (unlikely(!imsic->base_domain))
+			continue;
+
+		err = generic_handle_domain_irq(imsic->base_domain, hwirq);
+		if (unlikely(err))
+			pr_warn_ratelimited(
+				"hwirq %lu mapping not found\n", hwirq);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static int imsic_starting_cpu(unsigned int cpu)
+{
+	/* Enable per-CPU parent interrupt */
+	enable_percpu_irq(imsic_parent_irq,
+			  irq_get_trigger_type(imsic_parent_irq));
+
+	/* Setup IPIs */
+	imsic_ipi_starting_cpu();
+
+	/*
+	 * Interrupts identities might have been enabled/disabled while
+	 * this CPU was not running so sync-up local enable/disable state.
+	 */
+	imsic_ids_local_sync();
+
+	/* Enable local interrupt delivery */
+	imsic_ids_local_delivery(true);
+
+	return 0;
+}
+
+static int imsic_dying_cpu(unsigned int cpu)
+{
+	/* Cleanup IPIs */
+	imsic_ipi_dying_cpu();
+
+	return 0;
+}
+
+static int __init imsic_early_probe(struct fwnode_handle *fwnode)
+{
+	int rc;
+	struct irq_domain *domain;
+
+	/* Find parent domain and register chained handler */
+	domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(),
+					  DOMAIN_BUS_ANY);
+	if (!domain) {
+		pr_err("%pfwP: Failed to find INTC domain\n", fwnode);
+		return -ENOENT;
+	}
+	imsic_parent_irq = irq_create_mapping(domain, RV_IRQ_EXT);
+	if (!imsic_parent_irq) {
+		pr_err("%pfwP: Failed to create INTC mapping\n", fwnode);
+		return -ENOENT;
+	}
+	irq_set_chained_handler(imsic_parent_irq, imsic_handle_irq);
+
+	/* Initialize IPI domain */
+	rc = imsic_ipi_domain_init();
+	if (rc) {
+		pr_err("%pfwP: Failed to initialize IPI domain\n", fwnode);
+		return rc;
+	}
+
+	/*
+	 * Setup cpuhp state (must be done after setting imsic_parent_irq)
+	 *
+	 * Don't disable per-CPU IMSIC file when CPU goes offline
+	 * because this affects IPI and the masking/unmasking of
+	 * virtual IPIs is done via generic IPI-Mux
+	 */
+	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+			  "irqchip/riscv/imsic:starting",
+			  imsic_starting_cpu, imsic_dying_cpu);
+
+	return 0;
+}
+
+static int __init imsic_early_dt_init(struct device_node *node,
+				      struct device_node *parent)
+{
+	int rc;
+	struct fwnode_handle *fwnode = &node->fwnode;
+
+	/* Setup IMSIC state */
+	rc = imsic_setup_state(fwnode);
+	if (rc) {
+		pr_err("%pfwP: failed to setup state (error %d)\n",
+			fwnode, rc);
+		return rc;
+	}
+
+	/* Do early setup of IPIs */
+	rc = imsic_early_probe(fwnode);
+	if (rc)
+		return rc;
+
+	/* Ensure that OF platform device gets probed */
+	of_node_clear_flag(node, OF_POPULATED);
+	return 0;
+}
+IRQCHIP_DECLARE(riscv_imsic, "riscv,imsics", imsic_early_dt_init);
diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
new file mode 100644
index 000000000000..aedd0bf34d2d
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -0,0 +1,570 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ */
+
+#define pr_fmt(fmt) "riscv-imsic: " fmt
+#include <linux/bitmap.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/spinlock.h>
+#include <linux/smp.h>
+#include <asm/hwcap.h>
+
+#include "irq-riscv-imsic-state.h"
+
+#define IMSIC_DISABLE_EIDELIVERY		0
+#define IMSIC_ENABLE_EIDELIVERY			1
+#define IMSIC_DISABLE_EITHRESHOLD		1
+#define IMSIC_ENABLE_EITHRESHOLD		0
+
+#define imsic_csr_write(__c, __v)		\
+do {						\
+	csr_write(CSR_ISELECT, __c);		\
+	csr_write(CSR_IREG, __v);		\
+} while (0)
+
+#define imsic_csr_read(__c)			\
+({						\
+	unsigned long __v;			\
+	csr_write(CSR_ISELECT, __c);		\
+	__v = csr_read(CSR_IREG);		\
+	__v;					\
+})
+
+#define imsic_csr_set(__c, __v)			\
+do {						\
+	csr_write(CSR_ISELECT, __c);		\
+	csr_set(CSR_IREG, __v);			\
+} while (0)
+
+#define imsic_csr_clear(__c, __v)		\
+do {						\
+	csr_write(CSR_ISELECT, __c);		\
+	csr_clear(CSR_IREG, __v);		\
+} while (0)
+
+struct imsic_priv *imsic;
+
+const struct imsic_global_config *imsic_get_global_config(void)
+{
+	return (imsic) ? &imsic->global : NULL;
+}
+EXPORT_SYMBOL_GPL(imsic_get_global_config);
+
+void __imsic_eix_update(unsigned long base_id,
+			unsigned long num_id, bool pend, bool val)
+{
+	unsigned long i, isel, ireg;
+	unsigned long id = base_id, last_id = base_id + num_id;
+
+	while (id < last_id) {
+		isel = id / BITS_PER_LONG;
+		isel *= BITS_PER_LONG / IMSIC_EIPx_BITS;
+		isel += (pend) ? IMSIC_EIP0 : IMSIC_EIE0;
+
+		ireg = 0;
+		for (i = id & (__riscv_xlen - 1);
+		     (id < last_id) && (i < __riscv_xlen); i++) {
+			ireg |= BIT(i);
+			id++;
+		}
+
+		/*
+		 * The IMSIC EIEx and EIPx registers are indirectly
+		 * accessed via using ISELECT and IREG CSRs so we
+		 * need to access these CSRs without getting preempted.
+		 *
+		 * All existing users of this function call this
+		 * function with local IRQs disabled so we don't
+		 * need to do anything special here.
+		 */
+		if (val)
+			imsic_csr_set(isel, ireg);
+		else
+			imsic_csr_clear(isel, ireg);
+	}
+}
+
+void imsic_id_set_target(unsigned int id, unsigned int target_cpu)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&imsic->ids_lock, flags);
+	imsic->ids_target_cpu[id] = target_cpu;
+	raw_spin_unlock_irqrestore(&imsic->ids_lock, flags);
+}
+
+unsigned int imsic_id_get_target(unsigned int id)
+{
+	unsigned int ret;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&imsic->ids_lock, flags);
+	ret = imsic->ids_target_cpu[id];
+	raw_spin_unlock_irqrestore(&imsic->ids_lock, flags);
+
+	return ret;
+}
+
+void imsic_ids_local_sync(void)
+{
+	int i;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&imsic->ids_lock, flags);
+	for (i = 1; i <= imsic->global.nr_ids; i++) {
+		if (imsic->ipi_id == i)
+			continue;
+
+		if (test_bit(i, imsic->ids_enabled_bimap))
+			__imsic_id_enable(i);
+		else
+			__imsic_id_disable(i);
+	}
+	raw_spin_unlock_irqrestore(&imsic->ids_lock, flags);
+}
+
+void imsic_ids_local_delivery(bool enable)
+{
+	if (enable) {
+		imsic_csr_write(IMSIC_EITHRESHOLD, IMSIC_ENABLE_EITHRESHOLD);
+		imsic_csr_write(IMSIC_EIDELIVERY, IMSIC_ENABLE_EIDELIVERY);
+	} else {
+		imsic_csr_write(IMSIC_EIDELIVERY, IMSIC_DISABLE_EIDELIVERY);
+		imsic_csr_write(IMSIC_EITHRESHOLD, IMSIC_DISABLE_EITHRESHOLD);
+	}
+}
+
+int imsic_ids_alloc(unsigned int order)
+{
+	int ret;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&imsic->ids_lock, flags);
+	ret = bitmap_find_free_region(imsic->ids_used_bimap,
+				      imsic->global.nr_ids + 1, order);
+	raw_spin_unlock_irqrestore(&imsic->ids_lock, flags);
+
+	return ret;
+}
+
+void imsic_ids_free(unsigned int base_id, unsigned int order)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&imsic->ids_lock, flags);
+	bitmap_release_region(imsic->ids_used_bimap, base_id, order);
+	raw_spin_unlock_irqrestore(&imsic->ids_lock, flags);
+}
+
+static int __init imsic_ids_init(void)
+{
+	int i;
+	struct imsic_global_config *global = &imsic->global;
+
+	raw_spin_lock_init(&imsic->ids_lock);
+
+	/* Allocate used bitmap */
+	imsic->ids_used_bimap = bitmap_zalloc(global->nr_ids + 1, GFP_KERNEL);
+	if (!imsic->ids_used_bimap)
+		return -ENOMEM;
+
+	/* Allocate enabled bitmap */
+	imsic->ids_enabled_bimap = bitmap_zalloc(global->nr_ids + 1,
+						GFP_KERNEL);
+	if (!imsic->ids_enabled_bimap) {
+		kfree(imsic->ids_used_bimap);
+		return -ENOMEM;
+	}
+
+	/* Allocate target CPU array */
+	imsic->ids_target_cpu = kcalloc(global->nr_ids + 1,
+				       sizeof(unsigned int), GFP_KERNEL);
+	if (!imsic->ids_target_cpu) {
+		bitmap_free(imsic->ids_enabled_bimap);
+		bitmap_free(imsic->ids_used_bimap);
+		return -ENOMEM;
+	}
+	for (i = 0; i <= global->nr_ids; i++)
+		imsic->ids_target_cpu[i] = UINT_MAX;
+
+	/* Reserve ID#0 because it is special and never implemented */
+	bitmap_set(imsic->ids_used_bimap, 0, 1);
+
+	return 0;
+}
+
+static void __init imsic_ids_cleanup(void)
+{
+	kfree(imsic->ids_target_cpu);
+	bitmap_free(imsic->ids_enabled_bimap);
+	bitmap_free(imsic->ids_used_bimap);
+}
+
+static int __init imsic_get_parent_hartid(struct fwnode_handle *fwnode,
+					  u32 index, unsigned long *hartid)
+{
+	int rc;
+	struct of_phandle_args parent;
+
+	/*
+	 * Currently, only OF fwnode is supported so extend this
+	 * function for ACPI support.
+	 */
+	if (!is_of_node(fwnode))
+		return -EINVAL;
+
+	rc = of_irq_parse_one(to_of_node(fwnode), index, &parent);
+	if (rc)
+		return rc;
+
+	/*
+	 * Skip interrupts other than external interrupts for
+	 * current privilege level.
+	 */
+	if (parent.args[0] != RV_IRQ_EXT)
+		return -EINVAL;
+
+	return riscv_of_parent_hartid(parent.np, hartid);
+}
+
+static int __init imsic_get_mmio_resource(struct fwnode_handle *fwnode,
+					  u32 index, struct resource *res)
+{
+	/*
+	 * Currently, only OF fwnode is supported so extend this
+	 * function for ACPI support.
+	 */
+	if (!is_of_node(fwnode))
+		return -EINVAL;
+
+	return of_address_to_resource(to_of_node(fwnode), index, res);
+}
+
+static int __init imsic_parse_fwnode(struct fwnode_handle *fwnode,
+				     struct imsic_global_config *global,
+				     u32 *nr_parent_irqs,
+				     u32 *nr_mmios)
+{
+	unsigned long hartid;
+	struct resource res;
+	int rc;
+	u32 i;
+
+	/*
+	 * Currently, only OF fwnode is supported so extend this
+	 * function for ACPI support.
+	 */
+	if (!is_of_node(fwnode))
+		return -EINVAL;
+
+	*nr_parent_irqs = 0;
+	*nr_mmios = 0;
+
+	/* Find number of parent interrupts */
+	*nr_parent_irqs = 0;
+	while (!imsic_get_parent_hartid(fwnode, *nr_parent_irqs, &hartid))
+		(*nr_parent_irqs)++;
+	if (!(*nr_parent_irqs)) {
+		pr_err("%pfwP: no parent irqs available\n", fwnode);
+		return -EINVAL;
+	}
+
+	/* Find number of guest index bits in MSI address */
+	rc = of_property_read_u32(to_of_node(fwnode),
+				  "riscv,guest-index-bits",
+				  &global->guest_index_bits);
+	if (rc)
+		global->guest_index_bits = 0;
+
+	/* Find number of HART index bits */
+	rc = of_property_read_u32(to_of_node(fwnode),
+				  "riscv,hart-index-bits",
+				  &global->hart_index_bits);
+	if (rc) {
+		/* Assume default value */
+		global->hart_index_bits = __fls(*nr_parent_irqs);
+		if (BIT(global->hart_index_bits) < *nr_parent_irqs)
+			global->hart_index_bits++;
+	}
+
+	/* Find number of group index bits */
+	rc = of_property_read_u32(to_of_node(fwnode),
+				  "riscv,group-index-bits",
+				  &global->group_index_bits);
+	if (rc)
+		global->group_index_bits = 0;
+
+	/*
+	 * Find first bit position of group index.
+	 * If not specified assumed the default APLIC-IMSIC configuration.
+	 */
+	rc = of_property_read_u32(to_of_node(fwnode),
+				  "riscv,group-index-shift",
+				  &global->group_index_shift);
+	if (rc)
+		global->group_index_shift = IMSIC_MMIO_PAGE_SHIFT * 2;
+
+	/* Find number of interrupt identities */
+	rc = of_property_read_u32(to_of_node(fwnode),
+				  "riscv,num-ids",
+				  &global->nr_ids);
+	if (rc) {
+		pr_err("%pfwP: number of interrupt identities not found\n",
+			fwnode);
+		return rc;
+	}
+
+	/* Find number of guest interrupt identities */
+	rc = of_property_read_u32(to_of_node(fwnode),
+				  "riscv,num-guest-ids",
+				  &global->nr_guest_ids);
+	if (rc)
+		global->nr_guest_ids = global->nr_ids;
+
+	/* Sanity check guest index bits */
+	i = BITS_PER_LONG - IMSIC_MMIO_PAGE_SHIFT;
+	if (i < global->guest_index_bits) {
+		pr_err("%pfwP: guest index bits too big\n", fwnode);
+		return -EINVAL;
+	}
+
+	/* Sanity check HART index bits */
+	i = BITS_PER_LONG - IMSIC_MMIO_PAGE_SHIFT - global->guest_index_bits;
+	if (i < global->hart_index_bits) {
+		pr_err("%pfwP: HART index bits too big\n", fwnode);
+		return -EINVAL;
+	}
+
+	/* Sanity check group index bits */
+	i = BITS_PER_LONG - IMSIC_MMIO_PAGE_SHIFT -
+	    global->guest_index_bits - global->hart_index_bits;
+	if (i < global->group_index_bits) {
+		pr_err("%pfwP: group index bits too big\n", fwnode);
+		return -EINVAL;
+	}
+
+	/* Sanity check group index shift */
+	i = global->group_index_bits + global->group_index_shift - 1;
+	if (i >= BITS_PER_LONG) {
+		pr_err("%pfwP: group index shift too big\n", fwnode);
+		return -EINVAL;
+	}
+
+	/* Sanity check number of interrupt identities */
+	if ((global->nr_ids < IMSIC_MIN_ID) ||
+	    (global->nr_ids >= IMSIC_MAX_ID) ||
+	    ((global->nr_ids & IMSIC_MIN_ID) != IMSIC_MIN_ID)) {
+		pr_err("%pfwP: invalid number of interrupt identities\n",
+			fwnode);
+		return -EINVAL;
+	}
+
+	/* Sanity check number of guest interrupt identities */
+	if ((global->nr_guest_ids < IMSIC_MIN_ID) ||
+	    (global->nr_guest_ids >= IMSIC_MAX_ID) ||
+	    ((global->nr_guest_ids & IMSIC_MIN_ID) != IMSIC_MIN_ID)) {
+		pr_err("%pfwP: invalid number of guest interrupt identities\n",
+			fwnode);
+		return -EINVAL;
+	}
+
+	/* Compute base address */
+	rc = imsic_get_mmio_resource(fwnode, 0, &res);
+	if (rc) {
+		pr_err("%pfwP: first MMIO resource not found\n", fwnode);
+		return -EINVAL;
+	}
+	global->base_addr = res.start;
+	global->base_addr &= ~(BIT(global->guest_index_bits +
+				   global->hart_index_bits +
+				   IMSIC_MMIO_PAGE_SHIFT) - 1);
+	global->base_addr &= ~((BIT(global->group_index_bits) - 1) <<
+			       global->group_index_shift);
+
+	/* Find number of MMIO register sets */
+	while (!imsic_get_mmio_resource(fwnode, *nr_mmios, &res))
+		(*nr_mmios)++;
+
+	return 0;
+}
+
+int __init imsic_setup_state(struct fwnode_handle *fwnode)
+{
+	int rc, cpu;
+	phys_addr_t base_addr;
+	void __iomem **mmios_va = NULL;
+	struct resource *mmios = NULL;
+	struct imsic_local_config *local;
+	struct imsic_global_config *global;
+	unsigned long reloff, hartid;
+	u32 i, j, index, nr_parent_irqs, nr_mmios, nr_handlers = 0;
+
+	/*
+	 * Only one IMSIC instance allowed in a platform for clean
+	 * implementation of SMP IRQ affinity and per-CPU IPIs.
+	 *
+	 * This means on a multi-socket (or multi-die) platform we
+	 * will have multiple MMIO regions for one IMSIC instance.
+	 */
+	if (imsic) {
+		pr_err("%pfwP: already initialized hence ignoring\n",
+			fwnode);
+		return -EALREADY;
+	}
+
+	if (!riscv_isa_extension_available(NULL, SxAIA)) {
+		pr_err("%pfwP: AIA support not available\n", fwnode);
+		return -ENODEV;
+	}
+
+	imsic = kzalloc(sizeof(*imsic), GFP_KERNEL);
+	if (!imsic)
+		return -ENOMEM;
+	imsic->fwnode = fwnode;
+	global = &imsic->global;
+
+	global->local = alloc_percpu(typeof(*(global->local)));
+	if (!global->local) {
+		rc = -ENOMEM;
+		goto out_free_priv;
+	}
+
+	/* Parse IMSIC fwnode */
+	rc = imsic_parse_fwnode(fwnode, global, &nr_parent_irqs, &nr_mmios);
+	if (rc)
+		goto out_free_local;
+
+	/* Allocate MMIO resource array */
+	mmios = kcalloc(nr_mmios, sizeof(*mmios), GFP_KERNEL);
+	if (!mmios) {
+		rc = -ENOMEM;
+		goto out_free_local;
+	}
+
+	/* Allocate MMIO virtual address array */
+	mmios_va = kcalloc(nr_mmios, sizeof(*mmios_va), GFP_KERNEL);
+	if (!mmios_va) {
+		rc = -ENOMEM;
+		goto out_iounmap;
+	}
+
+	/* Parse and map MMIO register sets */
+	for (i = 0; i < nr_mmios; i++) {
+		rc = imsic_get_mmio_resource(fwnode, i, &mmios[i]);
+		if (rc) {
+			pr_err("%pfwP: unable to parse MMIO regset %d\n",
+				fwnode, i);
+			goto out_iounmap;
+		}
+
+		base_addr = mmios[i].start;
+		base_addr &= ~(BIT(global->guest_index_bits +
+				   global->hart_index_bits +
+				   IMSIC_MMIO_PAGE_SHIFT) - 1);
+		base_addr &= ~((BIT(global->group_index_bits) - 1) <<
+			       global->group_index_shift);
+		if (base_addr != global->base_addr) {
+			rc = -EINVAL;
+			pr_err("%pfwP: address mismatch for regset %d\n",
+				fwnode, i);
+			goto out_iounmap;
+		}
+
+		mmios_va[i] = ioremap(mmios[i].start, resource_size(&mmios[i]));
+		if (!mmios_va[i]) {
+			rc = -EIO;
+			pr_err("%pfwP: unable to map MMIO regset %d\n",
+				fwnode, i);
+			goto out_iounmap;
+		}
+	}
+
+	/* Initialize interrupt identity management */
+	rc = imsic_ids_init();
+	if (rc) {
+		pr_err("%pfwP: failed to initialize interrupt management\n",
+		       fwnode);
+		goto out_iounmap;
+	}
+
+	/* Configure handlers for target CPUs */
+	for (i = 0; i < nr_parent_irqs; i++) {
+		rc = imsic_get_parent_hartid(fwnode, i, &hartid);
+		if (rc) {
+			pr_warn("%pfwP: hart ID for parent irq%d not found\n",
+				fwnode, i);
+			continue;
+		}
+
+		cpu = riscv_hartid_to_cpuid(hartid);
+		if (cpu < 0) {
+			pr_warn("%pfwP: invalid cpuid for parent irq%d\n",
+				fwnode, i);
+			continue;
+		}
+
+		/* Find MMIO location of MSI page */
+		index = nr_mmios;
+		reloff = i * BIT(global->guest_index_bits) *
+			 IMSIC_MMIO_PAGE_SZ;
+		for (j = 0; nr_mmios; j++) {
+			if (reloff < resource_size(&mmios[j])) {
+				index = j;
+				break;
+			}
+
+			/*
+			 * MMIO region size may not be aligned to
+			 * BIT(global->guest_index_bits) * IMSIC_MMIO_PAGE_SZ
+			 * if holes are present.
+			 */
+			reloff -= ALIGN(resource_size(&mmios[j]),
+			BIT(global->guest_index_bits) * IMSIC_MMIO_PAGE_SZ);
+		}
+		if (index >= nr_mmios) {
+			pr_warn("%pfwP: MMIO not found for parent irq%d\n",
+				fwnode, i);
+			continue;
+		}
+
+		local = per_cpu_ptr(global->local, cpu);
+		local->msi_pa = mmios[index].start + reloff;
+		local->msi_va = mmios_va[index] + reloff;
+
+		nr_handlers++;
+	}
+
+	/* If no CPU handlers found then can't take interrupts */
+	if (!nr_handlers) {
+		pr_err("%pfwP: No CPU handlers found\n", fwnode);
+		rc = -ENODEV;
+		goto out_ids_cleanup;
+	}
+
+	/* We don't need MMIO arrays anymore so let's free-up */
+	kfree(mmios_va);
+	kfree(mmios);
+
+	return 0;
+
+out_ids_cleanup:
+	imsic_ids_cleanup();
+out_iounmap:
+	for (i = 0; i < nr_mmios; i++) {
+		if (mmios_va[i])
+			iounmap(mmios_va[i]);
+	}
+	kfree(mmios_va);
+	kfree(mmios);
+out_free_local:
+	free_percpu(imsic->global.local);
+out_free_priv:
+	kfree(imsic);
+	imsic = NULL;
+	return rc;
+}
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-riscv-imsic-state.h
new file mode 100644
index 000000000000..3170018949a8
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ */
+
+#ifndef _IRQ_RISCV_IMSIC_STATE_H
+#define _IRQ_RISCV_IMSIC_STATE_H
+
+#include <linux/irqchip/riscv-imsic.h>
+#include <linux/irqdomain.h>
+#include <linux/fwnode.h>
+
+struct imsic_priv {
+	/* Device details */
+	struct fwnode_handle *fwnode;
+
+	/* Global configuration common for all HARTs */
+	struct imsic_global_config global;
+
+	/* Global state of interrupt identities */
+	raw_spinlock_t ids_lock;
+	unsigned long *ids_used_bimap;
+	unsigned long *ids_enabled_bimap;
+	unsigned int *ids_target_cpu;
+
+	/* IPI interrupt identity and synchronization */
+	u32 ipi_id;
+	int ipi_virq;
+	struct irq_desc *ipi_lsync_desc;
+
+	/* IRQ domains (created by platform driver) */
+	struct irq_domain *base_domain;
+	struct irq_domain *plat_domain;
+};
+
+extern struct imsic_priv *imsic;
+
+void __imsic_eix_update(unsigned long base_id,
+			unsigned long num_id, bool pend, bool val);
+
+#define __imsic_id_enable(__id)		\
+	__imsic_eix_update((__id), 1, false, true)
+#define __imsic_id_disable(__id)	\
+	__imsic_eix_update((__id), 1, false, false)
+
+void imsic_id_set_target(unsigned int id, unsigned int target_cpu);
+unsigned int imsic_id_get_target(unsigned int id);
+
+void imsic_ids_local_sync(void);
+void imsic_ids_local_delivery(bool enable);
+
+#ifdef CONFIG_SMP
+void imsic_ids_remote_sync(void);
+#else
+static inline void imsic_ids_remote_sync(void)
+{
+}
+#endif
+
+int imsic_ids_alloc(unsigned int order);
+void imsic_ids_free(unsigned int base_id, unsigned int order);
+
+int imsic_setup_state(struct fwnode_handle *fwnode);
+
+#endif
diff --git a/include/linux/irqchip/riscv-imsic.h b/include/linux/irqchip/riscv-imsic.h
new file mode 100644
index 000000000000..1f6fc9a57218
--- /dev/null
+++ b/include/linux/irqchip/riscv-imsic.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ */
+#ifndef __LINUX_IRQCHIP_RISCV_IMSIC_H
+#define __LINUX_IRQCHIP_RISCV_IMSIC_H
+
+#include <linux/types.h>
+#include <asm/csr.h>
+
+#define IMSIC_MMIO_PAGE_SHIFT		12
+#define IMSIC_MMIO_PAGE_SZ		(1UL << IMSIC_MMIO_PAGE_SHIFT)
+#define IMSIC_MMIO_PAGE_LE		0x00
+#define IMSIC_MMIO_PAGE_BE		0x04
+
+#define IMSIC_MIN_ID			63
+#define IMSIC_MAX_ID			2048
+
+#define IMSIC_EIDELIVERY		0x70
+
+#define IMSIC_EITHRESHOLD		0x72
+
+#define IMSIC_EIP0			0x80
+#define IMSIC_EIP63			0xbf
+#define IMSIC_EIPx_BITS			32
+
+#define IMSIC_EIE0			0xc0
+#define IMSIC_EIE63			0xff
+#define IMSIC_EIEx_BITS			32
+
+#define IMSIC_FIRST			IMSIC_EIDELIVERY
+#define IMSIC_LAST			IMSIC_EIE63
+
+#define IMSIC_MMIO_SETIPNUM_LE		0x00
+#define IMSIC_MMIO_SETIPNUM_BE		0x04
+
+struct imsic_local_config {
+	phys_addr_t msi_pa;
+	void __iomem *msi_va;
+};
+
+struct imsic_global_config {
+	/*
+	 * MSI Target Address Scheme
+	 *
+	 * XLEN-1                                                12     0
+	 * |                                                     |     |
+	 * -------------------------------------------------------------
+	 * |xxxxxx|Group Index|xxxxxxxxxxx|HART Index|Guest Index|  0  |
+	 * -------------------------------------------------------------
+	 */
+
+	/* Bits representing Guest index, HART index, and Group index */
+	u32 guest_index_bits;
+	u32 hart_index_bits;
+	u32 group_index_bits;
+	u32 group_index_shift;
+
+	/* Global base address matching all target MSI addresses */
+	phys_addr_t base_addr;
+
+	/* Number of interrupt identities */
+	u32 nr_ids;
+
+	/* Number of guest interrupt identities */
+	u32 nr_guest_ids;
+
+	/* Per-CPU IMSIC addresses */
+	struct imsic_local_config __percpu *local;
+};
+
+#ifdef CONFIG_RISCV_IMSIC
+
+extern const struct imsic_global_config *imsic_get_global_config(void);
+
+#else
+
+static inline const struct imsic_global_config *imsic_get_global_config(void)
+{
+	return NULL;
+}
+
+#endif
+
+#endif
-- 
2.34.1

