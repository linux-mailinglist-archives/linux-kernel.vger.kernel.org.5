Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839687DAE9B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 22:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjJ2Vdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 17:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjJ2Vda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 17:33:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C61C0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 14:33:27 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698615206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=rJ5xicmlXazwIcm9KntaXbVTU+AyBgWEBCJ4XA0WbWU=;
        b=0ihhrNv2QHlu1H/1R+DkSye32Dyr7arYPt31GjUF9Is75R02vMu3ZiFYVPNe6kKsaFtoj1
        sE9dkvzSe1SwXrAFI873Irbb0cJdE1/VOY43x8AZ8XtsV3Ihe+/7WNo1U+iSuYiIJ51Jne
        tNKREEXKr8uLxHk1631L9mjkUvdbMJuEHI1JtJKrDn+3PjMOiqoje2CEPlGtRLMs/2CBgP
        uHvX7DtuL6yDS17w0awRNaB3BaJ3JCrfmD/00WxMvSUwFIdFdG4kREtCFuofsY2wDvwiso
        mzip2NFryHoOkRiPn9+buHruJAIZdOL7YrjXsrQ+AXK741JhVpJKgPhMXvX93Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698615206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=rJ5xicmlXazwIcm9KntaXbVTU+AyBgWEBCJ4XA0WbWU=;
        b=nmP0Jey/TGLEE6Fx+fWJe3/msw3O+nfJGrc+sUSMG5OOS0pabCUteTnK6xXY9ozJdJ7j/l
        lBSto87HWQM+5LCA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/core for v6.7-rc1
References: <169861500709.181063.7816209662289132093.tglx@xen13>
Message-ID: <169861500873.181063.15886241927509430280.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 29 Oct 2023 22:33:25 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2023-10=
-29-v2

up to:  f99b926f6543: irqchip/sifive-plic: Fix syscore registration for multi=
-socket systems

Updates for the interrupt subsytem:

  Core:

    - Exclude managed interrupts in the calculation of interrupts which are
      targeted to a CPU which is about to be offlined to ensure that there
      are enough free vectors on the still online CPUs to migrate them over.

      Managed interrupts do not need to be accounted because they are
      either shut down on offline or migrated to an already reserved and
      guaranteed slot on a still online CPU in the interrupts affinity
      mask.

      Including managed interrupts is overaccounting and can result in
      needlessly aborting hibernation on large server machines.

    - The usual set of small improvements

  Drivers:

    - Make the generic interrupt chip implementation handle interrupt
      domains correctly and initialize the name pointers correctly

    - Add interrupt affinity setting support to the Renesas RZG2L chip
      driver.

    - Prevent registering syscore operations multiple times in the SiFive
      PLIC chip driver.

    - Update device tree handling in the NXP Layerscape MSI chip driver


Thanks,

	tglx

------------------>
Anup Patel (1):
      irqchip/sifive-plic: Fix syscore registration for multi-socket systems

Chen Yu (1):
      genirq/matrix: Exclude managed interrupts in irq_matrix_allocated()

Herve Codina (1):
      genirq/generic_chip: Make irq_remove_generic_chip() irqdomain aware

Kees Cook (1):
      irqdomain: Annotate struct irq_domain with __counted_by

Keguang Zhang (1):
      genirq/generic-chip: Fix the irq_chip name for /proc/interrupts

Lad Prabhakar (1):
      irqchip/renesas-rzg2l: Enhance driver to support interrupt affinity set=
ting

Reinette Chatre (1):
      PCI/MSI: Provide stubs for IMS functions

Rob Herring (1):
      irqchip/ls-scfg-msi: Use device_get_match_data()


 drivers/irqchip/irq-ls-scfg-msi.c   | 12 +++++-------
 drivers/irqchip/irq-renesas-rzg2l.c |  1 +
 drivers/irqchip/irq-sifive-plic.c   |  7 ++++---
 include/linux/irqdomain.h           |  2 +-
 include/linux/pci.h                 | 34 ++++++++++++++++++++++++++--------
 kernel/irq/generic-chip.c           | 31 ++++++++++++++++++++++++-------
 kernel/irq/matrix.c                 |  6 +++---
 7 files changed, 64 insertions(+), 29 deletions(-)

diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-=
msi.c
index f31a262fe438..15cf80b46322 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -17,7 +17,8 @@
 #include <linux/irqdomain.h>
 #include <linux/of_irq.h>
 #include <linux/of_pci.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/spinlock.h>
=20
 #define MSI_IRQS_PER_MSIR	32
@@ -334,20 +335,17 @@ MODULE_DEVICE_TABLE(of, ls_scfg_msi_id);
=20
 static int ls_scfg_msi_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	struct ls_scfg_msi *msi_data;
 	struct resource *res;
 	int i, ret;
=20
-	match =3D of_match_device(ls_scfg_msi_id, &pdev->dev);
-	if (!match)
-		return -ENODEV;
-
 	msi_data =3D devm_kzalloc(&pdev->dev, sizeof(*msi_data), GFP_KERNEL);
 	if (!msi_data)
 		return -ENOMEM;
=20
-	msi_data->cfg =3D (struct ls_scfg_msi_cfg *) match->data;
+	msi_data->cfg =3D (struct ls_scfg_msi_cfg *)device_get_match_data(&pdev->de=
v);
+	if (!msi_data->cfg)
+		return -ENODEV;
=20
 	msi_data->regs =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(msi_data->regs)) {
diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesa=
s-rzg2l.c
index 4bbfa2b0a4df..e3029dd70ae1 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -247,6 +247,7 @@ static const struct irq_chip irqc_chip =3D {
 	.irq_set_irqchip_state	=3D irq_chip_set_parent_state,
 	.irq_retrigger		=3D irq_chip_retrigger_hierarchy,
 	.irq_set_type		=3D rzg2l_irqc_set_type,
+	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
 	.flags			=3D IRQCHIP_MASK_ON_SUSPEND |
 				  IRQCHIP_SET_TYPE_MASKED |
 				  IRQCHIP_SKIP_SET_WAKE,
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-p=
lic.c
index e1484905b7bd..5b7bc4fd9517 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -532,17 +532,18 @@ static int __init __plic_init(struct device_node *node,
 	}
=20
 	/*
-	 * We can have multiple PLIC instances so setup cpuhp state only
-	 * when context handler for current/boot CPU is present.
+	 * We can have multiple PLIC instances so setup cpuhp state
+	 * and register syscore operations only when context handler
+	 * for current/boot CPU is present.
 	 */
 	handler =3D this_cpu_ptr(&plic_handlers);
 	if (handler->present && !plic_cpuhp_setup_done) {
 		cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
 				  "irqchip/sifive/plic:starting",
 				  plic_starting_cpu, plic_dying_cpu);
+		register_syscore_ops(&plic_irq_syscore_ops);
 		plic_cpuhp_setup_done =3D true;
 	}
-	register_syscore_ops(&plic_irq_syscore_ops);
=20
 	pr_info("%pOFP: mapped %d interrupts with %d handlers for"
 		" %d contexts.\n", node, nr_irqs, nr_handlers, nr_contexts);
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 51c254b7fec2..ee0a82c60508 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -174,7 +174,7 @@ struct irq_domain {
 	irq_hw_number_t			hwirq_max;
 	unsigned int			revmap_size;
 	struct radix_tree_root		revmap_tree;
-	struct irq_data __rcu		*revmap[];
+	struct irq_data __rcu		*revmap[] __counted_by(revmap_size);
 };
=20
 /* Irq domain flags */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8c7c2c3c6c65..b56417276042 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1624,6 +1624,8 @@ struct msix_entry {
 	u16	entry;	/* Driver uses to specify entry, OS writes */
 };
=20
+struct msi_domain_template;
+
 #ifdef CONFIG_PCI_MSI
 int pci_msi_vec_count(struct pci_dev *dev);
 void pci_disable_msi(struct pci_dev *dev);
@@ -1656,6 +1658,11 @@ void pci_msix_free_irq(struct pci_dev *pdev, struct ms=
i_map map);
 void pci_free_irq_vectors(struct pci_dev *dev);
 int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
 const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev, int vec);
+bool pci_create_ims_domain(struct pci_dev *pdev, const struct msi_domain_tem=
plate *template,
+			   unsigned int hwsize, void *data);
+struct msi_map pci_ims_alloc_irq(struct pci_dev *pdev, union msi_instance_co=
okie *icookie,
+				 const struct irq_affinity_desc *affdesc);
+void pci_ims_free_irq(struct pci_dev *pdev, struct msi_map map);
=20
 #else
 static inline int pci_msi_vec_count(struct pci_dev *dev) { return -ENOSYS; }
@@ -1719,6 +1726,25 @@ static inline const struct cpumask *pci_irq_get_affini=
ty(struct pci_dev *pdev,
 {
 	return cpu_possible_mask;
 }
+
+static inline bool pci_create_ims_domain(struct pci_dev *pdev,
+					 const struct msi_domain_template *template,
+					 unsigned int hwsize, void *data)
+{ return false; }
+
+static inline struct msi_map pci_ims_alloc_irq(struct pci_dev *pdev,
+					       union msi_instance_cookie *icookie,
+					       const struct irq_affinity_desc *affdesc)
+{
+	struct msi_map map =3D { .index =3D -ENOSYS, };
+
+	return map;
+}
+
+static inline void pci_ims_free_irq(struct pci_dev *pdev, struct msi_map map)
+{
+}
+
 #endif
=20
 /**
@@ -2616,14 +2642,6 @@ static inline bool pci_is_thunderbolt_attached(struct =
pci_dev *pdev)
 void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 #endif
=20
-struct msi_domain_template;
-
-bool pci_create_ims_domain(struct pci_dev *pdev, const struct msi_domain_tem=
plate *template,
-			   unsigned int hwsize, void *data);
-struct msi_map pci_ims_alloc_irq(struct pci_dev *pdev, union msi_instance_co=
okie *icookie,
-				 const struct irq_affinity_desc *affdesc);
-void pci_ims_free_irq(struct pci_dev *pdev, struct msi_map map);
-
 #include <linux/dma-mapping.h>
=20
 #define pci_printk(level, pdev, fmt, arg...) \
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index c653cd31548d..d39a40bc542b 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -219,11 +219,15 @@ void irq_init_generic_chip(struct irq_chip_generic *gc,=
 const char *name,
 			   int num_ct, unsigned int irq_base,
 			   void __iomem *reg_base, irq_flow_handler_t handler)
 {
+	struct irq_chip_type *ct =3D gc->chip_types;
+	int i;
+
 	raw_spin_lock_init(&gc->lock);
 	gc->num_ct =3D num_ct;
 	gc->irq_base =3D irq_base;
 	gc->reg_base =3D reg_base;
-	gc->chip_types->chip.name =3D name;
+	for (i =3D 0; i < num_ct; i++)
+		ct[i].chip.name =3D name;
 	gc->chip_types->handler =3D handler;
 }
=20
@@ -544,21 +548,34 @@ EXPORT_SYMBOL_GPL(irq_setup_alt_chip);
 void irq_remove_generic_chip(struct irq_chip_generic *gc, u32 msk,
 			     unsigned int clr, unsigned int set)
 {
-	unsigned int i =3D gc->irq_base;
+	unsigned int i, virq;
=20
 	raw_spin_lock(&gc_lock);
 	list_del(&gc->list);
 	raw_spin_unlock(&gc_lock);
=20
-	for (; msk; msk >>=3D 1, i++) {
+	for (i =3D 0; msk; msk >>=3D 1, i++) {
 		if (!(msk & 0x01))
 			continue;
=20
+		/*
+		 * Interrupt domain based chips store the base hardware
+		 * interrupt number in gc::irq_base. Otherwise gc::irq_base
+		 * contains the base Linux interrupt number.
+		 */
+		if (gc->domain) {
+			virq =3D irq_find_mapping(gc->domain, gc->irq_base + i);
+			if (!virq)
+				continue;
+		} else {
+			virq =3D gc->irq_base + i;
+		}
+
 		/* Remove handler first. That will mask the irq line */
-		irq_set_handler(i, NULL);
-		irq_set_chip(i, &no_irq_chip);
-		irq_set_chip_data(i, NULL);
-		irq_modify_status(i, clr, set);
+		irq_set_handler(virq, NULL);
+		irq_set_chip(virq, &no_irq_chip);
+		irq_set_chip_data(virq, NULL);
+		irq_modify_status(virq, clr, set);
 	}
 }
 EXPORT_SYMBOL_GPL(irq_remove_generic_chip);
diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 1698e77645ac..75d0ae490e29 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -466,16 +466,16 @@ unsigned int irq_matrix_reserved(struct irq_matrix *m)
 }
=20
 /**
- * irq_matrix_allocated - Get the number of allocated irqs on the local cpu
+ * irq_matrix_allocated - Get the number of allocated non-managed irqs on th=
e local CPU
  * @m:		Pointer to the matrix to search
  *
- * This returns number of allocated irqs
+ * This returns number of allocated non-managed interrupts.
  */
 unsigned int irq_matrix_allocated(struct irq_matrix *m)
 {
 	struct cpumap *cm =3D this_cpu_ptr(m->maps);
=20
-	return cm->allocated;
+	return cm->allocated - cm->managed_allocated;
 }
=20
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS

