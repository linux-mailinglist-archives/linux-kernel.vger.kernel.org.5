Return-Path: <linux-kernel+bounces-98367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9002A87792F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 00:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 475C1281ADB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 23:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9493D3BC;
	Sun, 10 Mar 2024 23:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FG1GWYDv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VrnE5CPG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5873B78B
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 23:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710113945; cv=none; b=N3TzdcwN6qZQgB8QCHOam+fpmAGuGxDQLDQNm/iwio903KKYC5O1Q5wlbNcse1vaidRcjU+7/HwsPL1lLjebpxeW4Ot7SxiPRz+6lTi7XKrhCtoE6XGyVnPl1R4fKIPNd434yUfGjO2vsW+bBRO9Xhzhyx6J3ZpnOJLYNjX3yVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710113945; c=relaxed/simple;
	bh=jmcBQql94OP6UtQbiYDfXy7jOySxC6c4cfYljbOd5jM=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=rIgQ/4lmjBdZkIwCRnMjaPAdUioQyNcODU6Pt0oCdul6L+vMP44SkwI9MAeFEV0tRhdsX3+JlW/9r5T9G8c7GAC5aeDQm0S58JDPDswygVgJzKd8oliXo4CHy+RQfm9hZ9+VBmaIMQ6ioDPcoAIMOatbTQtvN+jpLGtqE4y0KOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FG1GWYDv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VrnE5CPG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710113933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=aQcdVPeRonsjrRKkuIy7CwE3gUA8A+MSk5LC+FTtFL0=;
	b=FG1GWYDvDDDxWaXlve/ytHbjA35uErjb/WX8uJ5Exfnqt6j1TSAseau9YMwnzKsyA2qpjI
	DaAFJ9mGdRk192RKKsP9dZVN+MSl1K1Ap8Q1wFgp/OG6eqklp+255CKpFjTbAZVTjhdVDt
	NH9gxj5WNcknUuxM1dKbWVq7mujizBoxUm9Vg3svNfvdVuqEFS3sSpqgeyA8WCO9UeW0fY
	6BEgyf3oWPxJ/AE/Q00EDunaHxXWyZqvTmkYR9tCbjJPsrxGz2g6wK31zUXELhf2g6S/SF
	XJs4fb42uJ6DbGHAbefk17R9DM6Kxss5BnRtN1sCEXOpKDT4m0JZWC18oDzprQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710113933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=aQcdVPeRonsjrRKkuIy7CwE3gUA8A+MSk5LC+FTtFL0=;
	b=VrnE5CPGvYm6I1bg/m6rA6jhtJLvYE7Tboi9FNvNmiXYI9bqez1atSWBeIQ/XS/iRM6nbM
	6ZyhpRWCFC1QQ3AQ==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/msi for v6.9-rc1
References: <171011361246.2468526.10740060923051583953.tglx@xen13>
Message-ID: <171011361412.2468526.4705040722498114628.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 11 Mar 2024 00:38:52 +0100 (CET)

Linus,

please pull the latest irq/msi branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-msi-2024-03-=
10

up to:  678c607ecf8a: irqchip/riscv-intc: Fix low-level interrupt handler set=
up for AIA

Updates for the MSI interrupt subsystem and RISC-V initial MSI support:

  - Core and platform-MSI

    The core changes have been adopted from previous work which converted
    ARM[64] to the new per device MSI domain model, which was merged to
    support multiple MSI domain per device. The ARM[64] changes are being
    worked on too, but have not been ready yet. The core and platform-MSI
    changes have been split out to not hold up RISC-V and to avoid that
    RISC-V builds on the scheduled for removal interfaces.

    The core support provides new interfaces to handle wire to MSI bridges
    in a straight forward way and introduces new platform-MSI interfaces
    which are built on top of the per device MSI domain model.

    Once ARM[64] is converted over the old platform-MSI interfaces and the
    related ugliness in the MSI core code will be removed.

  - Drivers:

    - Add a new driver for the Andes hart-level interrupt controller

    - Rework the SiFive PLIC driver to prepare for MSI suport

    - Expand the RISC-V INTC driver to support the new RISC-V AIA
      controller which provides the basis for MSI on RISC-V

    - A few fixup for the fallout of the core changes.

    The actual MSI parts for RISC-V were finalized late and have been
    post-poned for the next merge window.


Thanks,

	tglx

------------------>
Anup Patel (9):
      irqchip/sifive-plic: Convert PLIC driver into a platform driver
      irqchip/sifive-plic: Use dev_xyz() in-place of pr_xyz()
      irqchip/sifive-plic: Use devm_xyz() for managed allocation
      irqchip/sifive-plic: Use riscv_get_intc_hwnode() to get parent fwnode
      irqchip/sifive-plic: Cleanup PLIC contexts upon irqdomain creation fail=
ure
      irqchip/sifive-plic: Parse number of interrupts and contexts early in p=
lic_probe()
      irqchip/sifive-plic: Improve locking safety by using irqsave/irqrestore
      irqchip/riscv-intc: Add support for RISC-V AIA
      irqchip/riscv-intc: Fix low-level interrupt handler setup for AIA

Bj=C3=B6rn T=C3=B6pel (1):
      genirq/matrix: Dynamic bitmap allocation

Marc Zyngier (1):
      genirq/irqdomain: Don't call ops->select for DOMAIN_BUS_ANY tokens

Thomas Gleixner (16):
      irqchip/gic-v3: Make gic_irq_domain_select() robust for zero parameter =
count
      genirq/irqdomain: Remove the param count restriction from select()
      genirq/msi: Extend msi_parent_ops
      genirq/irqdomain: Add DOMAIN_BUS_DEVICE_MSI
      platform-msi: Prepare for real per device domains
      irqchip: Convert all platform MSI users to the new API
      platform-msi: Remove unused interfaces
      genirq/msi: Provide optional translation op
      genirq/msi: Split msi_domain_alloc_irq_at()
      genirq/msi: Provide DOMAIN_BUS_WIRED_TO_MSI
      genirq/msi: Optionally use dev->fwnode for device domain
      genirq/msi: Provide allocation/free functions for "wired" MSI interrupts
      genirq/irqdomain: Reroute device MSI create_mapping
      genirq/msi: Provide MSI_FLAG_PARENT_PM_DEV
      irqchip/imx-intmux: Handle pure domain searches correctly
      x86/apic/msi: Use DOMAIN_BUS_GENERIC_MSI for HPET/IO-APIC domain search

Yu Chien Peter Lin (2):
      irqchip/riscv-intc: Allow large non-standard interrupt number
      irqchip/riscv-intc: Introduce Andes hart-level interrupt controller


 arch/x86/include/asm/hw_irq.h               |   2 -
 arch/x86/kernel/apic/io_apic.c              |   2 +-
 arch/x86/kernel/hpet.c                      |   2 +-
 drivers/base/platform-msi.c                 | 119 ++++++++++--
 drivers/dma/mv_xor_v2.c                     |   8 +-
 drivers/dma/qcom/hidma.c                    |   6 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   5 +-
 drivers/irqchip/irq-gic-v3.c                |   6 +-
 drivers/irqchip/irq-imx-intmux.c            |   4 +
 drivers/irqchip/irq-riscv-intc.c            | 104 +++++++++--
 drivers/irqchip/irq-sifive-plic.c           | 275 +++++++++++++++++---------=
--
 drivers/mailbox/bcm-flexrm-mailbox.c        |   8 +-
 drivers/perf/arm_smmuv3_pmu.c               |   4 +-
 drivers/ufs/host/ufs-qcom.c                 |   8 +-
 include/linux/irqdomain.h                   |  17 ++
 include/linux/irqdomain_defs.h              |   2 +
 include/linux/msi.h                         |  24 ++-
 include/linux/soc/andes/irq.h               |  18 ++
 kernel/irq/irqdomain.c                      |  28 ++-
 kernel/irq/matrix.c                         |  28 +--
 kernel/irq/msi.c                            | 184 +++++++++++++++----
 21 files changed, 637 insertions(+), 217 deletions(-)
 create mode 100644 include/linux/soc/andes/irq.h

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index b02c3cd3c0f6..edebf1020e04 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -16,8 +16,6 @@
=20
 #include <asm/irq_vectors.h>
=20
-#define IRQ_MATRIX_BITS		NR_VECTORS
-
 #ifndef __ASSEMBLY__
=20
 #include <linux/percpu.h>
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 40c7cf180c20..e66c77529ca9 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2354,7 +2354,7 @@ static int mp_irqdomain_create(int ioapic)
 	fwspec.param_count =3D 1;
 	fwspec.param[0] =3D mpc_ioapic_id(ioapic);
=20
-	parent =3D irq_find_matching_fwspec(&fwspec, DOMAIN_BUS_ANY);
+	parent =3D irq_find_matching_fwspec(&fwspec, DOMAIN_BUS_GENERIC_MSI);
 	if (!parent) {
 		if (!cfg->dev)
 			irq_domain_free_fwnode(fn);
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index a38d0c93a66e..c96ae8fee95e 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -568,7 +568,7 @@ static struct irq_domain *hpet_create_irq_domain(int hpet=
_id)
 	fwspec.param_count =3D 1;
 	fwspec.param[0] =3D hpet_id;
=20
-	parent =3D irq_find_matching_fwspec(&fwspec, DOMAIN_BUS_ANY);
+	parent =3D irq_find_matching_fwspec(&fwspec, DOMAIN_BUS_GENERIC_MSI);
 	if (!parent) {
 		irq_domain_free_fwnode(fn);
 		kfree(domain_info);
diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index f37ad34c80ec..0d01890160f3 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -13,6 +13,8 @@
 #include <linux/msi.h>
 #include <linux/slab.h>
=20
+/* Begin of removal area. Once everything is converted over. Cleanup the inc=
ludes too! */
+
 #define DEV_ID_SHIFT	21
 #define MAX_DEV_MSIS	(1 << (32 - DEV_ID_SHIFT))
=20
@@ -204,8 +206,8 @@ static void platform_msi_free_priv_data(struct device *de=
v)
  * Returns:
  * Zero for success, or an error code in case of failure
  */
-int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
-				   irq_write_msi_msg_t write_msi_msg)
+static int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int n=
vec,
+					  irq_write_msi_msg_t write_msi_msg)
 {
 	int err;
=20
@@ -219,18 +221,6 @@ int platform_msi_domain_alloc_irqs(struct device *dev, u=
nsigned int nvec,
=20
 	return err;
 }
-EXPORT_SYMBOL_GPL(platform_msi_domain_alloc_irqs);
-
-/**
- * platform_msi_domain_free_irqs - Free MSI interrupts for @dev
- * @dev:	The device for which to free interrupts
- */
-void platform_msi_domain_free_irqs(struct device *dev)
-{
-	msi_domain_free_irqs_all(dev, MSI_DEFAULT_DOMAIN);
-	platform_msi_free_priv_data(dev);
-}
-EXPORT_SYMBOL_GPL(platform_msi_domain_free_irqs);
=20
 /**
  * platform_msi_get_host_data - Query the private data associated with
@@ -350,3 +340,104 @@ int platform_msi_device_domain_alloc(struct irq_domain =
*domain, unsigned int vir
=20
 	return msi_domain_populate_irqs(domain->parent, dev, virq, nr_irqs, &data->=
arg);
 }
+
+/* End of removal area */
+
+/* Real per device domain interfaces */
+
+/*
+ * This indirection can go when platform_device_msi_init_and_alloc_irqs()
+ * is switched to a proper irq_chip::irq_write_msi_msg() callback. Keep it
+ * simple for now.
+ */
+static void platform_msi_write_msi_msg(struct irq_data *d, struct msi_msg *m=
sg)
+{
+	irq_write_msi_msg_t cb =3D d->chip_data;
+
+	cb(irq_data_get_msi_desc(d), msg);
+}
+
+static void platform_msi_set_desc_byindex(msi_alloc_info_t *arg, struct msi_=
desc *desc)
+{
+	arg->desc =3D desc;
+	arg->hwirq =3D desc->msi_index;
+}
+
+static const struct msi_domain_template platform_msi_template =3D {
+	.chip =3D {
+		.name			=3D "pMSI",
+		.irq_mask		=3D irq_chip_mask_parent,
+		.irq_unmask		=3D irq_chip_unmask_parent,
+		.irq_write_msi_msg	=3D platform_msi_write_msi_msg,
+		/* The rest is filled in by the platform MSI parent */
+	},
+
+	.ops =3D {
+		.set_desc		=3D platform_msi_set_desc_byindex,
+	},
+
+	.info =3D {
+		.bus_token		=3D DOMAIN_BUS_DEVICE_MSI,
+	},
+};
+
+/**
+ * platform_device_msi_init_and_alloc_irqs - Initialize platform device MSI
+ *					     and allocate interrupts for @dev
+ * @dev:		The device for which to allocate interrupts
+ * @nvec:		The number of interrupts to allocate
+ * @write_msi_msg:	Callback to write an interrupt message for @dev
+ *
+ * Returns:
+ * Zero for success, or an error code in case of failure
+ *
+ * This creates a MSI domain on @dev which has @dev->msi.domain as
+ * parent. The parent domain sets up the new domain. The domain has
+ * a fixed size of @nvec. The domain is managed by devres and will
+ * be removed when the device is removed.
+ *
+ * Note: For migration purposes this falls back to the original platform_msi=
 code
+ *	 up to the point where all platforms have been converted to the MSI
+ *	 parent model.
+ */
+int platform_device_msi_init_and_alloc_irqs(struct device *dev, unsigned int=
 nvec,
+					    irq_write_msi_msg_t write_msi_msg)
+{
+	struct irq_domain *domain =3D dev->msi.domain;
+
+	if (!domain || !write_msi_msg)
+		return -EINVAL;
+
+	/* Migration support. Will go away once everything is converted */
+	if (!irq_domain_is_msi_parent(domain))
+		return platform_msi_domain_alloc_irqs(dev, nvec, write_msi_msg);
+
+	/*
+	 * @write_msi_msg is stored in the resulting msi_domain_info::data.
+	 * The underlying domain creation mechanism will assign that
+	 * callback to the resulting irq chip.
+	 */
+	if (!msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN,
+					  &platform_msi_template,
+					  nvec, NULL, write_msi_msg))
+		return -ENODEV;
+
+	return msi_domain_alloc_irqs_range(dev, MSI_DEFAULT_DOMAIN, 0, nvec - 1);
+}
+EXPORT_SYMBOL_GPL(platform_device_msi_init_and_alloc_irqs);
+
+/**
+ * platform_device_msi_free_irqs_all - Free all interrupts for @dev
+ * @dev:	The device for which to free interrupts
+ */
+void platform_device_msi_free_irqs_all(struct device *dev)
+{
+	struct irq_domain *domain =3D dev->msi.domain;
+
+	msi_domain_free_irqs_all(dev, MSI_DEFAULT_DOMAIN);
+
+	/* Migration support. Will go away once everything is converted */
+	if (!irq_domain_is_msi_parent(domain))
+		platform_msi_free_priv_data(dev);
+}
+EXPORT_SYMBOL_GPL(platform_device_msi_free_irqs_all);
diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index 1ebfbe88e733..97ebc791a30b 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -747,8 +747,8 @@ static int mv_xor_v2_probe(struct platform_device *pdev)
 	if (IS_ERR(xor_dev->clk))
 		return PTR_ERR(xor_dev->clk);
=20
-	ret =3D platform_msi_domain_alloc_irqs(&pdev->dev, 1,
-					     mv_xor_v2_set_msi_msg);
+	ret =3D platform_device_msi_init_and_alloc_irqs(&pdev->dev, 1,
+						      mv_xor_v2_set_msi_msg);
 	if (ret)
 		return ret;
=20
@@ -851,7 +851,7 @@ static int mv_xor_v2_probe(struct platform_device *pdev)
 			  xor_dev->desc_size * MV_XOR_V2_DESC_NUM,
 			  xor_dev->hw_desq_virt, xor_dev->hw_desq);
 free_msi_irqs:
-	platform_msi_domain_free_irqs(&pdev->dev);
+	platform_device_msi_free_irqs_all(&pdev->dev);
 	return ret;
 }
=20
@@ -867,7 +867,7 @@ static void mv_xor_v2_remove(struct platform_device *pdev)
=20
 	devm_free_irq(&pdev->dev, xor_dev->irq, xor_dev);
=20
-	platform_msi_domain_free_irqs(&pdev->dev);
+	platform_device_msi_free_irqs_all(&pdev->dev);
=20
 	tasklet_kill(&xor_dev->irq_tasklet);
 }
diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index d63b93dc7047..202ac95227cb 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -696,7 +696,7 @@ static void hidma_free_msis(struct hidma_dev *dmadev)
 			devm_free_irq(dev, virq, &dmadev->lldev);
 	}
=20
-	platform_msi_domain_free_irqs(dev);
+	platform_device_msi_free_irqs_all(dev);
 #endif
 }
=20
@@ -706,8 +706,8 @@ static int hidma_request_msi(struct hidma_dev *dmadev,
 #ifdef CONFIG_GENERIC_MSI_IRQ
 	int rc, i, virq;
=20
-	rc =3D platform_msi_domain_alloc_irqs(&pdev->dev, HIDMA_MSI_INTS,
-					    hidma_write_msi_msg);
+	rc =3D platform_device_msi_init_and_alloc_irqs(&pdev->dev, HIDMA_MSI_INTS,
+						     hidma_write_msi_msg);
 	if (rc)
 		return rc;
=20
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/=
arm-smmu-v3/arm-smmu-v3.c
index 0ffb1cf17e0b..a74a509bcd63 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3125,7 +3125,8 @@ static int arm_smmu_update_gbpa(struct arm_smmu_device =
*smmu, u32 set, u32 clr)
 static void arm_smmu_free_msis(void *data)
 {
 	struct device *dev =3D data;
-	platform_msi_domain_free_irqs(dev);
+
+	platform_device_msi_free_irqs_all(dev);
 }
=20
 static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *ms=
g)
@@ -3166,7 +3167,7 @@ static void arm_smmu_setup_msis(struct arm_smmu_device =
*smmu)
 	}
=20
 	/* Allocate MSIs for evtq, gerror and priq. Ignore cmdq */
-	ret =3D platform_msi_domain_alloc_irqs(dev, nvec, arm_smmu_write_msi_msg);
+	ret =3D platform_device_msi_init_and_alloc_irqs(dev, nvec, arm_smmu_write_m=
si_msg);
 	if (ret) {
 		dev_warn(dev, "failed to allocate MSIs - falling back to wired irqs\n");
 		return;
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 98b0329b7154..35b9362d178f 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1702,9 +1702,13 @@ static int gic_irq_domain_select(struct irq_domain *d,
 	irq_hw_number_t hwirq;
=20
 	/* Not for us */
-        if (fwspec->fwnode !=3D d->fwnode)
+	if (fwspec->fwnode !=3D d->fwnode)
 		return 0;
=20
+	/* Handle pure domain searches */
+	if (!fwspec->param_count)
+		return d->bus_token =3D=3D bus_token;
+
 	/* If this is not DT, then we have a single domain */
 	if (!is_of_node(fwspec->fwnode))
 		return 1;
diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmu=
x.c
index aa041e4dfee0..65084c7619b0 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -166,6 +166,10 @@ static int imx_intmux_irq_select(struct irq_domain *d, s=
truct irq_fwspec *fwspec
 	if (fwspec->fwnode !=3D d->fwnode)
 		return false;
=20
+	/* Handle pure domain searches */
+	if (!fwspec->param_count)
+		return d->bus_token =3D=3D bus_token;
+
 	return irqchip_data->chanidx =3D=3D fwspec->param[1];
 }
=20
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-int=
c.c
index e8d01b14ccdd..f87aeab460eb 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -17,17 +17,29 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/smp.h>
+#include <linux/soc/andes/irq.h>
+
+#include <asm/hwcap.h>
=20
 static struct irq_domain *intc_domain;
+static unsigned int riscv_intc_nr_irqs __ro_after_init =3D BITS_PER_LONG;
+static unsigned int riscv_intc_custom_base __ro_after_init =3D BITS_PER_LONG;
+static unsigned int riscv_intc_custom_nr_irqs __ro_after_init;
=20
 static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
 {
 	unsigned long cause =3D regs->cause & ~CAUSE_IRQ_FLAG;
=20
-	if (unlikely(cause >=3D BITS_PER_LONG))
-		panic("unexpected interrupt cause");
+	if (generic_handle_domain_irq(intc_domain, cause))
+		pr_warn_ratelimited("Failed to handle interrupt (cause: %ld)\n", cause);
+}
+
+static asmlinkage void riscv_intc_aia_irq(struct pt_regs *regs)
+{
+	unsigned long topi;
=20
-	generic_handle_domain_irq(intc_domain, cause);
+	while ((topi =3D csr_read(CSR_TOPI)))
+		generic_handle_domain_irq(intc_domain, topi >> TOPI_IID_SHIFT);
 }
=20
 /*
@@ -39,12 +51,43 @@ static asmlinkage void riscv_intc_irq(struct pt_regs *reg=
s)
=20
 static void riscv_intc_irq_mask(struct irq_data *d)
 {
-	csr_clear(CSR_IE, BIT(d->hwirq));
+	if (IS_ENABLED(CONFIG_32BIT) && d->hwirq >=3D BITS_PER_LONG)
+		csr_clear(CSR_IEH, BIT(d->hwirq - BITS_PER_LONG));
+	else
+		csr_clear(CSR_IE, BIT(d->hwirq));
 }
=20
 static void riscv_intc_irq_unmask(struct irq_data *d)
 {
-	csr_set(CSR_IE, BIT(d->hwirq));
+	if (IS_ENABLED(CONFIG_32BIT) && d->hwirq >=3D BITS_PER_LONG)
+		csr_set(CSR_IEH, BIT(d->hwirq - BITS_PER_LONG));
+	else
+		csr_set(CSR_IE, BIT(d->hwirq));
+}
+
+static void andes_intc_irq_mask(struct irq_data *d)
+{
+	/*
+	 * Andes specific S-mode local interrupt causes (hwirq)
+	 * are defined as (256 + n) and controlled by n-th bit
+	 * of SLIE.
+	 */
+	unsigned int mask =3D BIT(d->hwirq % BITS_PER_LONG);
+
+	if (d->hwirq < ANDES_SLI_CAUSE_BASE)
+		csr_clear(CSR_IE, mask);
+	else
+		csr_clear(ANDES_CSR_SLIE, mask);
+}
+
+static void andes_intc_irq_unmask(struct irq_data *d)
+{
+	unsigned int mask =3D BIT(d->hwirq % BITS_PER_LONG);
+
+	if (d->hwirq < ANDES_SLI_CAUSE_BASE)
+		csr_set(CSR_IE, mask);
+	else
+		csr_set(ANDES_CSR_SLIE, mask);
 }
=20
 static void riscv_intc_irq_eoi(struct irq_data *d)
@@ -70,12 +113,21 @@ static struct irq_chip riscv_intc_chip =3D {
 	.irq_eoi =3D riscv_intc_irq_eoi,
 };
=20
+static struct irq_chip andes_intc_chip =3D {
+	.name		=3D "RISC-V INTC",
+	.irq_mask	=3D andes_intc_irq_mask,
+	.irq_unmask	=3D andes_intc_irq_unmask,
+	.irq_eoi	=3D riscv_intc_irq_eoi,
+};
+
 static int riscv_intc_domain_map(struct irq_domain *d, unsigned int irq,
 				 irq_hw_number_t hwirq)
 {
+	struct irq_chip *chip =3D d->host_data;
+
 	irq_set_percpu_devid(irq);
-	irq_domain_set_info(d, irq, hwirq, &riscv_intc_chip, d->host_data,
-			    handle_percpu_devid_irq, NULL, NULL);
+	irq_domain_set_info(d, irq, hwirq, chip, NULL, handle_percpu_devid_irq,
+			    NULL, NULL);
=20
 	return 0;
 }
@@ -93,6 +145,14 @@ static int riscv_intc_domain_alloc(struct irq_domain *dom=
ain,
 	if (ret)
 		return ret;
=20
+	/*
+	 * Only allow hwirq for which we have corresponding standard or
+	 * custom interrupt enable register.
+	 */
+	if ((hwirq >=3D riscv_intc_nr_irqs && hwirq < riscv_intc_custom_base) ||
+	    (hwirq >=3D riscv_intc_custom_base + riscv_intc_custom_nr_irqs))
+		return -EINVAL;
+
 	for (i =3D 0; i < nr_irqs; i++) {
 		ret =3D riscv_intc_domain_map(domain, virq + i, hwirq + i);
 		if (ret)
@@ -113,18 +173,20 @@ static struct fwnode_handle *riscv_intc_hwnode(void)
 	return intc_domain->fwnode;
 }
=20
-static int __init riscv_intc_init_common(struct fwnode_handle *fn)
+static int __init riscv_intc_init_common(struct fwnode_handle *fn, struct ir=
q_chip *chip)
 {
 	int rc;
=20
-	intc_domain =3D irq_domain_create_linear(fn, BITS_PER_LONG,
-					       &riscv_intc_domain_ops, NULL);
+	intc_domain =3D irq_domain_create_tree(fn, &riscv_intc_domain_ops, chip);
 	if (!intc_domain) {
 		pr_err("unable to add IRQ domain\n");
 		return -ENXIO;
 	}
=20
-	rc =3D set_handle_irq(&riscv_intc_irq);
+	if (riscv_isa_extension_available(NULL, SxAIA))
+		rc =3D set_handle_irq(&riscv_intc_aia_irq);
+	else
+		rc =3D set_handle_irq(&riscv_intc_irq);
 	if (rc) {
 		pr_err("failed to set irq handler\n");
 		return rc;
@@ -132,7 +194,11 @@ static int __init riscv_intc_init_common(struct fwnode_h=
andle *fn)
=20
 	riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
=20
-	pr_info("%d local interrupts mapped\n", BITS_PER_LONG);
+	pr_info("%d local interrupts mapped%s\n",
+		riscv_isa_extension_available(NULL, SxAIA) ? 64 : riscv_intc_nr_irqs,
+		riscv_isa_extension_available(NULL, SxAIA) ? " using AIA" : "");
+	if (riscv_intc_custom_nr_irqs)
+		pr_info("%d custom local interrupts mapped\n", riscv_intc_custom_nr_irqs);
=20
 	return 0;
 }
@@ -140,8 +206,9 @@ static int __init riscv_intc_init_common(struct fwnode_ha=
ndle *fn)
 static int __init riscv_intc_init(struct device_node *node,
 				  struct device_node *parent)
 {
-	int rc;
+	struct irq_chip *chip =3D &riscv_intc_chip;
 	unsigned long hartid;
+	int rc;
=20
 	rc =3D riscv_of_parent_hartid(node, &hartid);
 	if (rc < 0) {
@@ -166,10 +233,17 @@ static int __init riscv_intc_init(struct device_node *n=
ode,
 		return 0;
 	}
=20
-	return riscv_intc_init_common(of_node_to_fwnode(node));
+	if (of_device_is_compatible(node, "andestech,cpu-intc")) {
+		riscv_intc_custom_base =3D ANDES_SLI_CAUSE_BASE;
+		riscv_intc_custom_nr_irqs =3D ANDES_RV_IRQ_LAST;
+		chip =3D &andes_intc_chip;
+	}
+
+	return riscv_intc_init_common(of_node_to_fwnode(node), chip);
 }
=20
 IRQCHIP_DECLARE(riscv, "riscv,cpu-intc", riscv_intc_init);
+IRQCHIP_DECLARE(andes, "andestech,cpu-intc", riscv_intc_init);
=20
 #ifdef CONFIG_ACPI
=20
@@ -196,7 +270,7 @@ static int __init riscv_intc_acpi_init(union acpi_subtabl=
e_headers *header,
 		return -ENOMEM;
 	}
=20
-	return riscv_intc_init_common(fn);
+	return riscv_intc_init_common(fn, &riscv_intc_chip);
 }
=20
 IRQCHIP_ACPI_DECLARE(riscv_intc, ACPI_MADT_TYPE_RINTC, NULL,
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-p=
lic.c
index 5b7bc4fd9517..601000d2a351 100644
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
@@ -64,6 +63,7 @@
 #define PLIC_QUIRK_EDGE_INTERRUPT	0
=20
 struct plic_priv {
+	struct device *dev;
 	struct cpumask lmask;
 	struct irq_domain *irqdomain;
 	void __iomem *regs;
@@ -103,9 +103,11 @@ static void __plic_toggle(void __iomem *enable_base, int=
 hwirq, int enable)
=20
 static void plic_toggle(struct plic_handler *handler, int hwirq, int enable)
 {
-	raw_spin_lock(&handler->enable_lock);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&handler->enable_lock, flags);
 	__plic_toggle(handler->enable_base, hwirq, enable);
-	raw_spin_unlock(&handler->enable_lock);
+	raw_spin_unlock_irqrestore(&handler->enable_lock, flags);
 }
=20
 static inline void plic_irq_toggle(const struct cpumask *mask,
@@ -236,6 +238,7 @@ static int plic_irq_set_type(struct irq_data *d, unsigned=
 int type)
 static int plic_irq_suspend(void)
 {
 	unsigned int i, cpu;
+	unsigned long flags;
 	u32 __iomem *reg;
 	struct plic_priv *priv;
=20
@@ -253,12 +256,12 @@ static int plic_irq_suspend(void)
 		if (!handler->present)
 			continue;
=20
-		raw_spin_lock(&handler->enable_lock);
+		raw_spin_lock_irqsave(&handler->enable_lock, flags);
 		for (i =3D 0; i < DIV_ROUND_UP(priv->nr_irqs, 32); i++) {
 			reg =3D handler->enable_base + i * sizeof(u32);
 			handler->enable_save[i] =3D readl(reg);
 		}
-		raw_spin_unlock(&handler->enable_lock);
+		raw_spin_unlock_irqrestore(&handler->enable_lock, flags);
 	}
=20
 	return 0;
@@ -267,6 +270,7 @@ static int plic_irq_suspend(void)
 static void plic_irq_resume(void)
 {
 	unsigned int i, index, cpu;
+	unsigned long flags;
 	u32 __iomem *reg;
 	struct plic_priv *priv;
=20
@@ -284,12 +288,12 @@ static void plic_irq_resume(void)
 		if (!handler->present)
 			continue;
=20
-		raw_spin_lock(&handler->enable_lock);
+		raw_spin_lock_irqsave(&handler->enable_lock, flags);
 		for (i =3D 0; i < DIV_ROUND_UP(priv->nr_irqs, 32); i++) {
 			reg =3D handler->enable_base + i * sizeof(u32);
 			writel(handler->enable_save[i], reg);
 		}
-		raw_spin_unlock(&handler->enable_lock);
+		raw_spin_unlock_irqrestore(&handler->enable_lock, flags);
 	}
 }
=20
@@ -370,9 +374,10 @@ static void plic_handle_irq(struct irq_desc *desc)
 	while ((hwirq =3D readl(claim))) {
 		int err =3D generic_handle_domain_irq(handler->priv->irqdomain,
 						    hwirq);
-		if (unlikely(err))
-			pr_warn_ratelimited("can't find mapping for hwirq %lu\n",
-					hwirq);
+		if (unlikely(err)) {
+			dev_warn_ratelimited(handler->priv->dev,
+					     "can't find mapping for hwirq %lu\n", hwirq);
+		}
 	}
=20
 	chained_irq_exit(chip, desc);
@@ -400,63 +405,122 @@ static int plic_starting_cpu(unsigned int cpu)
 		enable_percpu_irq(plic_parent_irq,
 				  irq_get_trigger_type(plic_parent_irq));
 	else
-		pr_warn("cpu%d: parent irq not available\n", cpu);
+		dev_warn(handler->priv->dev, "cpu%d: parent irq not available\n", cpu);
 	plic_set_threshold(handler, PLIC_ENABLE_THRESHOLD);
=20
 	return 0;
 }
=20
-static int __init __plic_init(struct device_node *node,
-			      struct device_node *parent,
-			      unsigned long plic_quirks)
+static const struct of_device_id plic_match[] =3D {
+	{ .compatible =3D "sifive,plic-1.0.0" },
+	{ .compatible =3D "riscv,plic0" },
+	{ .compatible =3D "andestech,nceplic100",
+	  .data =3D (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
+	{ .compatible =3D "thead,c900-plic",
+	  .data =3D (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
+	{}
+};
+
+static int plic_parse_nr_irqs_and_contexts(struct platform_device *pdev,
+					   u32 *nr_irqs, u32 *nr_contexts)
 {
-	int error =3D 0, nr_contexts, nr_handlers =3D 0, i;
-	u32 nr_irqs;
-	struct plic_priv *priv;
-	struct plic_handler *handler;
-	unsigned int cpu;
+	struct device *dev =3D &pdev->dev;
+	int rc;
=20
-	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	/*
+	 * Currently, only OF fwnode is supported so extend this
+	 * function for ACPI support.
+	 */
+	if (!is_of_node(dev->fwnode))
+		return -EINVAL;
=20
-	priv->plic_quirks =3D plic_quirks;
+	rc =3D of_property_read_u32(to_of_node(dev->fwnode), "riscv,ndev", nr_irqs);
+	if (rc) {
+		dev_err(dev, "riscv,ndev property not available\n");
+		return rc;
+	}
=20
-	priv->regs =3D of_iomap(node, 0);
-	if (WARN_ON(!priv->regs)) {
-		error =3D -EIO;
-		goto out_free_priv;
+	*nr_contexts =3D of_irq_count(to_of_node(dev->fwnode));
+	if (WARN_ON(!(*nr_contexts))) {
+		dev_err(dev, "no PLIC context available\n");
+		return -EINVAL;
 	}
=20
-	error =3D -EINVAL;
-	of_property_read_u32(node, "riscv,ndev", &nr_irqs);
-	if (WARN_ON(!nr_irqs))
-		goto out_iounmap;
+	return 0;
+}
+
+static int plic_parse_context_parent(struct platform_device *pdev, u32 conte=
xt,
+				     u32 *parent_hwirq, int *parent_cpu)
+{
+	struct device *dev =3D &pdev->dev;
+	struct of_phandle_args parent;
+	unsigned long hartid;
+	int rc;
=20
-	priv->nr_irqs =3D nr_irqs;
+	/*
+	 * Currently, only OF fwnode is supported so extend this
+	 * function for ACPI support.
+	 */
+	if (!is_of_node(dev->fwnode))
+		return -EINVAL;
=20
-	priv->prio_save =3D bitmap_alloc(nr_irqs, GFP_KERNEL);
-	if (!priv->prio_save)
-		goto out_free_priority_reg;
+	rc =3D of_irq_parse_one(to_of_node(dev->fwnode), context, &parent);
+	if (rc)
+		return rc;
=20
-	nr_contexts =3D of_irq_count(node);
-	if (WARN_ON(!nr_contexts))
-		goto out_free_priority_reg;
+	rc =3D riscv_of_parent_hartid(parent.np, &hartid);
+	if (rc)
+		return rc;
=20
-	error =3D -ENOMEM;
-	priv->irqdomain =3D irq_domain_add_linear(node, nr_irqs + 1,
-			&plic_irqdomain_ops, priv);
-	if (WARN_ON(!priv->irqdomain))
-		goto out_free_priority_reg;
+	*parent_hwirq =3D parent.args[0];
+	*parent_cpu =3D riscv_hartid_to_cpuid(hartid);
+	return 0;
+}
=20
-	for (i =3D 0; i < nr_contexts; i++) {
-		struct of_phandle_args parent;
-		irq_hw_number_t hwirq;
-		int cpu;
-		unsigned long hartid;
+static int plic_probe(struct platform_device *pdev)
+{
+	int error =3D 0, nr_contexts, nr_handlers =3D 0, cpu, i;
+	struct device *dev =3D &pdev->dev;
+	unsigned long plic_quirks =3D 0;
+	struct plic_handler *handler;
+	u32 nr_irqs, parent_hwirq;
+	struct irq_domain *domain;
+	struct plic_priv *priv;
+	irq_hw_number_t hwirq;
+	bool cpuhp_setup;
+
+	if (is_of_node(dev->fwnode)) {
+		const struct of_device_id *id;
+
+		id =3D of_match_node(plic_match, to_of_node(dev->fwnode));
+		if (id)
+			plic_quirks =3D (unsigned long)id->data;
+	}
+
+	error =3D plic_parse_nr_irqs_and_contexts(pdev, &nr_irqs, &nr_contexts);
+	if (error)
+		return error;
+
+	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev =3D dev;
+	priv->plic_quirks =3D plic_quirks;
+	priv->nr_irqs =3D nr_irqs;
+
+	priv->regs =3D devm_platform_ioremap_resource(pdev, 0);
+	if (WARN_ON(!priv->regs))
+		return -EIO;
=20
-		if (of_irq_parse_one(node, i, &parent)) {
-			pr_err("failed to parse parent for context %d.\n", i);
+	priv->prio_save =3D devm_bitmap_zalloc(dev, nr_irqs, GFP_KERNEL);
+	if (!priv->prio_save)
+		return -ENOMEM;
+
+	for (i =3D 0; i < nr_contexts; i++) {
+		error =3D plic_parse_context_parent(pdev, i, &parent_hwirq, &cpu);
+		if (error) {
+			dev_warn(dev, "hwirq for context%d not found\n", i);
 			continue;
 		}
=20
@@ -464,7 +528,7 @@ static int __init __plic_init(struct device_node *node,
 		 * Skip contexts other than external interrupts for our
 		 * privilege level.
 		 */
-		if (parent.args[0] !=3D RV_IRQ_EXT) {
+		if (parent_hwirq !=3D RV_IRQ_EXT) {
 			/* Disable S-mode enable bits if running in M-mode. */
 			if (IS_ENABLED(CONFIG_RISCV_M_MODE)) {
 				void __iomem *enable_base =3D priv->regs +
@@ -477,24 +541,17 @@ static int __init __plic_init(struct device_node *node,
 			continue;
 		}
=20
-		error =3D riscv_of_parent_hartid(parent.np, &hartid);
-		if (error < 0) {
-			pr_warn("failed to parse hart ID for context %d.\n", i);
-			continue;
-		}
-
-		cpu =3D riscv_hartid_to_cpuid(hartid);
 		if (cpu < 0) {
-			pr_warn("Invalid cpuid for context %d\n", i);
+			dev_warn(dev, "Invalid cpuid for context %d\n", i);
 			continue;
 		}
=20
 		/* Find parent domain and register chained handler */
-		if (!plic_parent_irq && irq_find_host(parent.np)) {
-			plic_parent_irq =3D irq_of_parse_and_map(node, i);
+		domain =3D irq_find_matching_fwnode(riscv_get_intc_hwnode(), DOMAIN_BUS_AN=
Y);
+		if (!plic_parent_irq && domain) {
+			plic_parent_irq =3D irq_create_mapping(domain, RV_IRQ_EXT);
 			if (plic_parent_irq)
-				irq_set_chained_handler(plic_parent_irq,
-							plic_handle_irq);
+				irq_set_chained_handler(plic_parent_irq, plic_handle_irq);
 		}
=20
 		/*
@@ -504,7 +561,7 @@ static int __init __plic_init(struct device_node *node,
 		 */
 		handler =3D per_cpu_ptr(&plic_handlers, cpu);
 		if (handler->present) {
-			pr_warn("handler already present for context %d.\n", i);
+			dev_warn(dev, "handler already present for context %d.\n", i);
 			plic_set_threshold(handler, PLIC_DISABLE_THRESHOLD);
 			goto done;
 		}
@@ -518,10 +575,10 @@ static int __init __plic_init(struct device_node *node,
 			i * CONTEXT_ENABLE_SIZE;
 		handler->priv =3D priv;
=20
-		handler->enable_save =3D  kcalloc(DIV_ROUND_UP(nr_irqs, 32),
-						sizeof(*handler->enable_save), GFP_KERNEL);
+		handler->enable_save =3D devm_kcalloc(dev, DIV_ROUND_UP(nr_irqs, 32),
+						    sizeof(*handler->enable_save), GFP_KERNEL);
 		if (!handler->enable_save)
-			goto out_free_enable_reg;
+			goto fail_cleanup_contexts;
 done:
 		for (hwirq =3D 1; hwirq <=3D nr_irqs; hwirq++) {
 			plic_toggle(handler, hwirq, 0);
@@ -531,52 +588,60 @@ static int __init __plic_init(struct device_node *node,
 		nr_handlers++;
 	}
=20
+	priv->irqdomain =3D irq_domain_add_linear(to_of_node(dev->fwnode), nr_irqs =
+ 1,
+						&plic_irqdomain_ops, priv);
+	if (WARN_ON(!priv->irqdomain))
+		goto fail_cleanup_contexts;
+
 	/*
 	 * We can have multiple PLIC instances so setup cpuhp state
-	 * and register syscore operations only when context handler
-	 * for current/boot CPU is present.
+	 * and register syscore operations only once after context
+	 * handlers of all online CPUs are initialized.
 	 */
-	handler =3D this_cpu_ptr(&plic_handlers);
-	if (handler->present && !plic_cpuhp_setup_done) {
-		cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
-				  "irqchip/sifive/plic:starting",
-				  plic_starting_cpu, plic_dying_cpu);
-		register_syscore_ops(&plic_irq_syscore_ops);
-		plic_cpuhp_setup_done =3D true;
+	if (!plic_cpuhp_setup_done) {
+		cpuhp_setup =3D true;
+		for_each_online_cpu(cpu) {
+			handler =3D per_cpu_ptr(&plic_handlers, cpu);
+			if (!handler->present) {
+				cpuhp_setup =3D false;
+				break;
+			}
+		}
+		if (cpuhp_setup) {
+			cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
+					  "irqchip/sifive/plic:starting",
+					  plic_starting_cpu, plic_dying_cpu);
+			register_syscore_ops(&plic_irq_syscore_ops);
+			plic_cpuhp_setup_done =3D true;
+		}
 	}
=20
-	pr_info("%pOFP: mapped %d interrupts with %d handlers for"
-		" %d contexts.\n", node, nr_irqs, nr_handlers, nr_contexts);
+	dev_info(dev, "mapped %d interrupts with %d handlers for %d contexts.\n",
+		 nr_irqs, nr_handlers, nr_contexts);
 	return 0;
=20
-out_free_enable_reg:
-	for_each_cpu(cpu, cpu_present_mask) {
+fail_cleanup_contexts:
+	for (i =3D 0; i < nr_contexts; i++) {
+		if (plic_parse_context_parent(pdev, i, &parent_hwirq, &cpu))
+			continue;
+		if (parent_hwirq !=3D RV_IRQ_EXT || cpu < 0)
+			continue;
+
 		handler =3D per_cpu_ptr(&plic_handlers, cpu);
-		kfree(handler->enable_save);
+		handler->present =3D false;
+		handler->hart_base =3D NULL;
+		handler->enable_base =3D NULL;
+		handler->enable_save =3D NULL;
+		handler->priv =3D NULL;
 	}
-out_free_priority_reg:
-	kfree(priv->prio_save);
-out_iounmap:
-	iounmap(priv->regs);
-out_free_priv:
-	kfree(priv);
-	return error;
+	return -ENOMEM;
 }
=20
-static int __init plic_init(struct device_node *node,
-			    struct device_node *parent)
-{
-	return __plic_init(node, parent, 0);
-}
-
-IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
-IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy system=
s */
-
-static int __init plic_edge_init(struct device_node *node,
-				 struct device_node *parent)
-{
-	return __plic_init(node, parent, BIT(PLIC_QUIRK_EDGE_INTERRUPT));
-}
-
-IRQCHIP_DECLARE(andestech_nceplic100, "andestech,nceplic100", plic_edge_init=
);
-IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", plic_edge_init);
+static struct platform_driver plic_driver =3D {
+	.driver =3D {
+		.name		=3D "riscv-plic",
+		.of_match_table	=3D plic_match,
+	},
+	.probe =3D plic_probe,
+};
+builtin_platform_driver(plic_driver);
diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexr=
m-mailbox.c
index e3e28a4f7d01..b1abc2a0c971 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1587,8 +1587,8 @@ static int flexrm_mbox_probe(struct platform_device *pd=
ev)
 	}
=20
 	/* Allocate platform MSIs for each ring */
-	ret =3D platform_msi_domain_alloc_irqs(dev, mbox->num_rings,
-						flexrm_mbox_msi_write);
+	ret =3D platform_device_msi_init_and_alloc_irqs(dev, mbox->num_rings,
+						      flexrm_mbox_msi_write);
 	if (ret)
 		goto fail_destroy_cmpl_pool;
=20
@@ -1641,7 +1641,7 @@ static int flexrm_mbox_probe(struct platform_device *pd=
ev)
=20
 fail_free_debugfs_root:
 	debugfs_remove_recursive(mbox->root);
-	platform_msi_domain_free_irqs(dev);
+	platform_device_msi_free_irqs_all(dev);
 fail_destroy_cmpl_pool:
 	dma_pool_destroy(mbox->cmpl_pool);
 fail_destroy_bd_pool:
@@ -1657,7 +1657,7 @@ static void flexrm_mbox_remove(struct platform_device *=
pdev)
=20
 	debugfs_remove_recursive(mbox->root);
=20
-	platform_msi_domain_free_irqs(dev);
+	platform_device_msi_free_irqs_all(dev);
=20
 	dma_pool_destroy(mbox->cmpl_pool);
 	dma_pool_destroy(mbox->bd_pool);
diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 6303b82566f9..9e5d7fa647b6 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -716,7 +716,7 @@ static void smmu_pmu_free_msis(void *data)
 {
 	struct device *dev =3D data;
=20
-	platform_msi_domain_free_irqs(dev);
+	platform_device_msi_free_irqs_all(dev);
 }
=20
 static void smmu_pmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *ms=
g)
@@ -746,7 +746,7 @@ static void smmu_pmu_setup_msi(struct smmu_pmu *pmu)
 	if (!(readl(pmu->reg_base + SMMU_PMCG_CFGR) & SMMU_PMCG_CFGR_MSI))
 		return;
=20
-	ret =3D platform_msi_domain_alloc_irqs(dev, 1, smmu_pmu_write_msi_msg);
+	ret =3D platform_device_msi_init_and_alloc_irqs(dev, 1, smmu_pmu_write_msi_=
msg);
 	if (ret) {
 		dev_warn(dev, "failed to allocate MSIs\n");
 		return;
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 39eef470f8fa..8fde5204e88b 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1712,8 +1712,8 @@ static int ufs_qcom_config_esi(struct ufs_hba *hba)
 	 * 2. Poll queues do not need ESI.
 	 */
 	nr_irqs =3D hba->nr_hw_queues - hba->nr_queues[HCTX_TYPE_POLL];
-	ret =3D platform_msi_domain_alloc_irqs(hba->dev, nr_irqs,
-					     ufs_qcom_write_msi_msg);
+	ret =3D platform_device_msi_init_and_alloc_irqs(hba->dev, nr_irqs,
+						      ufs_qcom_write_msi_msg);
 	if (ret) {
 		dev_err(hba->dev, "Failed to request Platform MSI %d\n", ret);
 		return ret;
@@ -1742,7 +1742,7 @@ static int ufs_qcom_config_esi(struct ufs_hba *hba)
 			devm_free_irq(hba->dev, desc->irq, hba);
 		}
 		msi_unlock_descs(hba->dev);
-		platform_msi_domain_free_irqs(hba->dev);
+		platform_device_msi_free_irqs_all(hba->dev);
 	} else {
 		if (host->hw_ver.major =3D=3D 6 && host->hw_ver.minor =3D=3D 0 &&
 		    host->hw_ver.step =3D=3D 0)
@@ -1818,7 +1818,7 @@ static void ufs_qcom_remove(struct platform_device *pde=
v)
=20
 	pm_runtime_get_sync(&(pdev)->dev);
 	ufshcd_remove(hba);
-	platform_msi_domain_free_irqs(hba->dev);
+	platform_device_msi_free_irqs_all(hba->dev);
 }
=20
 static const struct of_device_id ufs_qcom_of_match[] __maybe_unused =3D {
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index ee0a82c60508..21ecf582a0fe 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -619,6 +619,23 @@ static inline bool irq_domain_is_msi_device(struct irq_d=
omain *domain)
=20
 #endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
=20
+#ifdef CONFIG_GENERIC_MSI_IRQ
+int msi_device_domain_alloc_wired(struct irq_domain *domain, unsigned int hw=
irq,
+				  unsigned int type);
+void msi_device_domain_free_wired(struct irq_domain *domain, unsigned int vi=
rq);
+#else
+static inline int msi_device_domain_alloc_wired(struct irq_domain *domain, u=
nsigned int hwirq,
+						unsigned int type)
+{
+	WARN_ON_ONCE(1);
+	return -EINVAL;
+}
+static inline void msi_device_domain_free_wired(struct irq_domain *domain, u=
nsigned int virq)
+{
+	WARN_ON_ONCE(1);
+}
+#endif
+
 #else /* CONFIG_IRQ_DOMAIN */
 static inline void irq_dispose_mapping(unsigned int virq) { }
 static inline struct irq_domain *irq_find_matching_fwnode(
diff --git a/include/linux/irqdomain_defs.h b/include/linux/irqdomain_defs.h
index c29921fd8cd1..5c1fe6f1fcde 100644
--- a/include/linux/irqdomain_defs.h
+++ b/include/linux/irqdomain_defs.h
@@ -26,6 +26,8 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_DMAR,
 	DOMAIN_BUS_AMDVI,
 	DOMAIN_BUS_PCI_DEVICE_IMS,
+	DOMAIN_BUS_DEVICE_MSI,
+	DOMAIN_BUS_WIRED_TO_MSI,
 };
=20
 #endif /* _LINUX_IRQDOMAIN_DEFS_H */
diff --git a/include/linux/msi.h b/include/linux/msi.h
index ddace8c34dcf..26d07e23052e 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -412,6 +412,7 @@ bool arch_restore_msi_irqs(struct pci_dev *dev);
 struct irq_domain;
 struct irq_domain_ops;
 struct irq_chip;
+struct irq_fwspec;
 struct device_node;
 struct fwnode_handle;
 struct msi_domain_info;
@@ -431,6 +432,8 @@ struct msi_domain_info;
  *			function.
  * @msi_post_free:	Optional function which is invoked after freeing
  *			all interrupts.
+ * @msi_translate:	Optional translate callback to support the odd wire to
+ *			MSI bridges, e.g. MBIGEN
  *
  * @get_hwirq, @msi_init and @msi_free are callbacks used by the underlying
  * irqdomain.
@@ -468,6 +471,8 @@ struct msi_domain_ops {
 					    struct device *dev);
 	void		(*msi_post_free)(struct irq_domain *domain,
 					 struct device *dev);
+	int		(*msi_translate)(struct irq_domain *domain, struct irq_fwspec *fwspec,
+					 irq_hw_number_t *hwirq, unsigned int *type);
 };
=20
 /**
@@ -547,6 +552,10 @@ enum {
 	MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS	=3D (1 << 5),
 	/* Free MSI descriptors */
 	MSI_FLAG_FREE_MSI_DESCS		=3D (1 << 6),
+	/* Use dev->fwnode for MSI device domain creation */
+	MSI_FLAG_USE_DEV_FWNODE		=3D (1 << 7),
+	/* Set parent->dev into domain->pm_dev on device domain creation */
+	MSI_FLAG_PARENT_PM_DEV		=3D (1 << 8),
=20
 	/* Mask for the generic functionality */
 	MSI_GENERIC_FLAGS_MASK		=3D GENMASK(15, 0),
@@ -572,6 +581,11 @@ enum {
  * struct msi_parent_ops - MSI parent domain callbacks and configuration info
  *
  * @supported_flags:	Required: The supported MSI flags of the parent domain
+ * @required_flags:	Optional: The required MSI flags of the parent MSI domain
+ * @bus_select_token:	Optional: The bus token of the real parent domain for
+ *			irq_domain::select()
+ * @bus_select_mask:	Optional: A mask of supported BUS_DOMAINs for
+ *			irq_domain::select()
  * @prefix:		Optional: Prefix for the domain and chip name
  * @init_dev_msi_info:	Required: Callback for MSI parent domains to setup pa=
rent
  *			domain specific domain flags, domain ops and interrupt chip
@@ -579,6 +593,9 @@ enum {
  */
 struct msi_parent_ops {
 	u32		supported_flags;
+	u32		required_flags;
+	u32		bus_select_token;
+	u32		bus_select_mask;
 	const char	*prefix;
 	bool		(*init_dev_msi_info)(struct device *dev, struct irq_domain *domain,
 					     struct irq_domain *msi_parent_domain,
@@ -627,9 +644,6 @@ struct msi_domain_info *msi_get_domain_info(struct irq_do=
main *domain);
 struct irq_domain *platform_msi_create_irq_domain(struct fwnode_handle *fwno=
de,
 						  struct msi_domain_info *info,
 						  struct irq_domain *parent);
-int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
-				   irq_write_msi_msg_t write_msi_msg);
-void platform_msi_domain_free_irqs(struct device *dev);
=20
 /* When an MSI domain is used as an intermediate domain */
 int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
@@ -656,6 +670,10 @@ int platform_msi_device_domain_alloc(struct irq_domain *=
domain, unsigned int vir
 void platform_msi_device_domain_free(struct irq_domain *domain, unsigned int=
 virq,
 				     unsigned int nvec);
 void *platform_msi_get_host_data(struct irq_domain *domain);
+/* Per device platform MSI */
+int platform_device_msi_init_and_alloc_irqs(struct device *dev, unsigned int=
 nvec,
+					    irq_write_msi_msg_t write_msi_msg);
+void platform_device_msi_free_irqs_all(struct device *dev);
=20
 bool msi_device_has_isolated_msi(struct device *dev);
 #else /* CONFIG_GENERIC_MSI_IRQ */
diff --git a/include/linux/soc/andes/irq.h b/include/linux/soc/andes/irq.h
new file mode 100644
index 000000000000..edc3182d6e66
--- /dev/null
+++ b/include/linux/soc/andes/irq.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 Andes Technology Corporation
+ */
+#ifndef __ANDES_IRQ_H
+#define __ANDES_IRQ_H
+
+/* Andes PMU irq number */
+#define ANDES_RV_IRQ_PMOVI		18
+#define ANDES_RV_IRQ_LAST		ANDES_RV_IRQ_PMOVI
+#define ANDES_SLI_CAUSE_BASE		256
+
+/* Andes PMU related registers */
+#define ANDES_CSR_SLIE			0x9c4
+#define ANDES_CSR_SLIP			0x9c5
+#define ANDES_CSR_SCOUNTEROF		0x9d4
+
+#endif /* __ANDES_IRQ_H */
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 0bdef4fe925b..3dd1c871e091 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -29,6 +29,7 @@ static int irq_domain_alloc_irqs_locked(struct irq_domain *=
domain, int irq_base,
 					unsigned int nr_irqs, int node, void *arg,
 					bool realloc, const struct irq_affinity_desc *affinity);
 static void irq_domain_check_hierarchy(struct irq_domain *domain);
+static void irq_domain_free_one_irq(struct irq_domain *domain, unsigned int =
virq);
=20
 struct irqchip_fwid {
 	struct fwnode_handle	fwnode;
@@ -448,7 +449,7 @@ struct irq_domain *irq_find_matching_fwspec(struct irq_fw=
spec *fwspec,
 	 */
 	mutex_lock(&irq_domain_mutex);
 	list_for_each_entry(h, &irq_domain_list, link) {
-		if (h->ops->select && fwspec->param_count)
+		if (h->ops->select && bus_token !=3D DOMAIN_BUS_ANY)
 			rc =3D h->ops->select(h, fwspec, bus_token);
 		else if (h->ops->match)
 			rc =3D h->ops->match(h, to_of_node(fwnode), bus_token);
@@ -858,8 +859,13 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec=
 *fwspec)
 	}
=20
 	if (irq_domain_is_hierarchy(domain)) {
-		virq =3D irq_domain_alloc_irqs_locked(domain, -1, 1, NUMA_NO_NODE,
-						    fwspec, false, NULL);
+		if (irq_domain_is_msi_device(domain)) {
+			mutex_unlock(&domain->root->mutex);
+			virq =3D msi_device_domain_alloc_wired(domain, hwirq, type);
+			mutex_lock(&domain->root->mutex);
+		} else
+			virq =3D irq_domain_alloc_irqs_locked(domain, -1, 1, NUMA_NO_NODE,
+							    fwspec, false, NULL);
 		if (virq <=3D 0) {
 			virq =3D 0;
 			goto out;
@@ -914,7 +920,7 @@ void irq_dispose_mapping(unsigned int virq)
 		return;
=20
 	if (irq_domain_is_hierarchy(domain)) {
-		irq_domain_free_irqs(virq, 1);
+		irq_domain_free_one_irq(domain, virq);
 	} else {
 		irq_domain_disassociate(domain, virq);
 		irq_free_desc(virq);
@@ -1755,6 +1761,14 @@ void irq_domain_free_irqs(unsigned int virq, unsigned =
int nr_irqs)
 	irq_free_descs(virq, nr_irqs);
 }
=20
+static void irq_domain_free_one_irq(struct irq_domain *domain, unsigned int =
virq)
+{
+	if (irq_domain_is_msi_device(domain))
+		msi_device_domain_free_wired(domain, virq);
+	else
+		irq_domain_free_irqs(virq, 1);
+}
+
 /**
  * irq_domain_alloc_irqs_parent - Allocate interrupts from parent domain
  * @domain:	Domain below which interrupts must be allocated
@@ -1907,9 +1921,9 @@ static int irq_domain_alloc_irqs_locked(struct irq_doma=
in *domain, int irq_base,
 	return -EINVAL;
 }
=20
-static void irq_domain_check_hierarchy(struct irq_domain *domain)
-{
-}
+static void irq_domain_check_hierarchy(struct irq_domain *domain) { }
+static void irq_domain_free_one_irq(struct irq_domain *domain, unsigned int =
virq) { }
+
 #endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
=20
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 75d0ae490e29..8f222d1cccec 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -8,8 +8,6 @@
 #include <linux/cpu.h>
 #include <linux/irq.h>
=20
-#define IRQ_MATRIX_SIZE	(BITS_TO_LONGS(IRQ_MATRIX_BITS))
-
 struct cpumap {
 	unsigned int		available;
 	unsigned int		allocated;
@@ -17,8 +15,8 @@ struct cpumap {
 	unsigned int		managed_allocated;
 	bool			initialized;
 	bool			online;
-	unsigned long		alloc_map[IRQ_MATRIX_SIZE];
-	unsigned long		managed_map[IRQ_MATRIX_SIZE];
+	unsigned long		*managed_map;
+	unsigned long		alloc_map[];
 };
=20
 struct irq_matrix {
@@ -32,8 +30,8 @@ struct irq_matrix {
 	unsigned int		total_allocated;
 	unsigned int		online_maps;
 	struct cpumap __percpu	*maps;
-	unsigned long		scratch_map[IRQ_MATRIX_SIZE];
-	unsigned long		system_map[IRQ_MATRIX_SIZE];
+	unsigned long		*system_map;
+	unsigned long		scratch_map[];
 };
=20
 #define CREATE_TRACE_POINTS
@@ -50,24 +48,32 @@ __init struct irq_matrix *irq_alloc_matrix(unsigned int m=
atrix_bits,
 					   unsigned int alloc_start,
 					   unsigned int alloc_end)
 {
+	unsigned int cpu, matrix_size =3D BITS_TO_LONGS(matrix_bits);
 	struct irq_matrix *m;
=20
-	if (matrix_bits > IRQ_MATRIX_BITS)
-		return NULL;
-
-	m =3D kzalloc(sizeof(*m), GFP_KERNEL);
+	m =3D kzalloc(struct_size(m, scratch_map, matrix_size * 2), GFP_KERNEL);
 	if (!m)
 		return NULL;
=20
+	m->system_map =3D &m->scratch_map[matrix_size];
+
 	m->matrix_bits =3D matrix_bits;
 	m->alloc_start =3D alloc_start;
 	m->alloc_end =3D alloc_end;
 	m->alloc_size =3D alloc_end - alloc_start;
-	m->maps =3D alloc_percpu(*m->maps);
+	m->maps =3D __alloc_percpu(struct_size(m->maps, alloc_map, matrix_size * 2),
+				 __alignof__(*m->maps));
 	if (!m->maps) {
 		kfree(m);
 		return NULL;
 	}
+
+	for_each_possible_cpu(cpu) {
+		struct cpumap *cm =3D per_cpu_ptr(m->maps, cpu);
+
+		cm->managed_map =3D &cm->alloc_map[matrix_size];
+	}
+
 	return m;
 }
=20
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 79b4a58ba9c3..f90952ebc494 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -726,11 +726,26 @@ static void msi_domain_free(struct irq_domain *domain, =
unsigned int virq,
 	irq_domain_free_irqs_top(domain, virq, nr_irqs);
 }
=20
+static int msi_domain_translate(struct irq_domain *domain, struct irq_fwspec=
 *fwspec,
+				irq_hw_number_t *hwirq, unsigned int *type)
+{
+	struct msi_domain_info *info =3D domain->host_data;
+
+	/*
+	 * This will catch allocations through the regular irqdomain path except
+	 * for MSI domains which really support this, e.g. MBIGEN.
+	 */
+	if (!info->ops->msi_translate)
+		return -ENOTSUPP;
+	return info->ops->msi_translate(domain, fwspec, hwirq, type);
+}
+
 static const struct irq_domain_ops msi_domain_ops =3D {
 	.alloc		=3D msi_domain_alloc,
 	.free		=3D msi_domain_free,
 	.activate	=3D msi_domain_activate,
 	.deactivate	=3D msi_domain_deactivate,
+	.translate	=3D msi_domain_translate,
 };
=20
 static irq_hw_number_t msi_domain_ops_get_hwirq(struct msi_domain_info *info,
@@ -830,8 +845,11 @@ static struct irq_domain *__msi_create_irq_domain(struct=
 fwnode_handle *fwnode,
 	domain =3D irq_domain_create_hierarchy(parent, flags | IRQ_DOMAIN_FLAG_MSI,=
 0,
 					     fwnode, &msi_domain_ops, info);
=20
-	if (domain)
+	if (domain) {
 		irq_domain_update_bus_token(domain, info->bus_token);
+		if (info->flags & MSI_FLAG_PARENT_PM_DEV)
+			domain->pm_dev =3D parent->pm_dev;
+	}
=20
 	return domain;
 }
@@ -945,9 +963,9 @@ bool msi_create_device_irq_domain(struct device *dev, uns=
igned int domid,
 				  void *chip_data)
 {
 	struct irq_domain *domain, *parent =3D dev->msi.domain;
-	const struct msi_parent_ops *pops;
+	struct fwnode_handle *fwnode, *fwnalloced =3D NULL;
 	struct msi_domain_template *bundle;
-	struct fwnode_handle *fwnode;
+	const struct msi_parent_ops *pops;
=20
 	if (!irq_domain_is_msi_parent(parent))
 		return false;
@@ -970,7 +988,19 @@ bool msi_create_device_irq_domain(struct device *dev, un=
signed int domid,
 		 pops->prefix ? : "", bundle->chip.name, dev_name(dev));
 	bundle->chip.name =3D bundle->name;
=20
-	fwnode =3D irq_domain_alloc_named_fwnode(bundle->name);
+	/*
+	 * Using the device firmware node is required for wire to MSI
+	 * device domains so that the existing firmware results in a domain
+	 * match.
+	 * All other device domains like PCI/MSI use the named firmware
+	 * node as they are not guaranteed to have a fwnode. They are never
+	 * looked up and always handled in the context of the device.
+	 */
+	if (bundle->info.flags & MSI_FLAG_USE_DEV_FWNODE)
+		fwnode =3D dev->fwnode;
+	else
+		fwnode =3D fwnalloced =3D irq_domain_alloc_named_fwnode(bundle->name);
+
 	if (!fwnode)
 		goto free_bundle;
=20
@@ -997,7 +1027,7 @@ bool msi_create_device_irq_domain(struct device *dev, un=
signed int domid,
 fail:
 	msi_unlock_descs(dev);
 free_fwnode:
-	irq_domain_free_fwnode(fwnode);
+	irq_domain_free_fwnode(fwnalloced);
 free_bundle:
 	kfree(bundle);
 	return false;
@@ -1431,34 +1461,10 @@ int msi_domain_alloc_irqs_all_locked(struct device *d=
ev, unsigned int domid, int
 	return msi_domain_alloc_locked(dev, &ctrl);
 }
=20
-/**
- * msi_domain_alloc_irq_at - Allocate an interrupt from a MSI interrupt doma=
in at
- *			     a given index - or at the next free index
- *
- * @dev:	Pointer to device struct of the device for which the interrupts
- *		are allocated
- * @domid:	Id of the interrupt domain to operate on
- * @index:	Index for allocation. If @index =3D=3D %MSI_ANY_INDEX the allocat=
ion
- *		uses the next free index.
- * @affdesc:	Optional pointer to an interrupt affinity descriptor structure
- * @icookie:	Optional pointer to a domain specific per instance cookie. If
- *		non-NULL the content of the cookie is stored in msi_desc::data.
- *		Must be NULL for MSI-X allocations
- *
- * This requires a MSI interrupt domain which lets the core code manage the
- * MSI descriptors.
- *
- * Return: struct msi_map
- *
- *	On success msi_map::index contains the allocated index number and
- *	msi_map::virq the corresponding Linux interrupt number
- *
- *	On failure msi_map::index contains the error code and msi_map::virq
- *	is %0.
- */
-struct msi_map msi_domain_alloc_irq_at(struct device *dev, unsigned int domi=
d, unsigned int index,
-				       const struct irq_affinity_desc *affdesc,
-				       union msi_instance_cookie *icookie)
+static struct msi_map __msi_domain_alloc_irq_at(struct device *dev, unsigned=
 int domid,
+						unsigned int index,
+						const struct irq_affinity_desc *affdesc,
+						union msi_instance_cookie *icookie)
 {
 	struct msi_ctrl ctrl =3D { .domid	=3D domid, .nirqs =3D 1, };
 	struct irq_domain *domain;
@@ -1466,17 +1472,16 @@ struct msi_map msi_domain_alloc_irq_at(struct device =
*dev, unsigned int domid, u
 	struct msi_desc *desc;
 	int ret;
=20
-	msi_lock_descs(dev);
 	domain =3D msi_get_device_domain(dev, domid);
 	if (!domain) {
 		map.index =3D -ENODEV;
-		goto unlock;
+		return map;
 	}
=20
 	desc =3D msi_alloc_desc(dev, 1, affdesc);
 	if (!desc) {
 		map.index =3D -ENOMEM;
-		goto unlock;
+		return map;
 	}
=20
 	if (icookie)
@@ -1485,7 +1490,7 @@ struct msi_map msi_domain_alloc_irq_at(struct device *d=
ev, unsigned int domid, u
 	ret =3D msi_insert_desc(dev, desc, domid, index);
 	if (ret) {
 		map.index =3D ret;
-		goto unlock;
+		return map;
 	}
=20
 	ctrl.first =3D ctrl.last =3D desc->msi_index;
@@ -1498,11 +1503,90 @@ struct msi_map msi_domain_alloc_irq_at(struct device =
*dev, unsigned int domid, u
 		map.index =3D desc->msi_index;
 		map.virq =3D desc->irq;
 	}
-unlock:
+	return map;
+}
+
+/**
+ * msi_domain_alloc_irq_at - Allocate an interrupt from a MSI interrupt doma=
in at
+ *			     a given index - or at the next free index
+ *
+ * @dev:	Pointer to device struct of the device for which the interrupts
+ *		are allocated
+ * @domid:	Id of the interrupt domain to operate on
+ * @index:	Index for allocation. If @index =3D=3D %MSI_ANY_INDEX the allocat=
ion
+ *		uses the next free index.
+ * @affdesc:	Optional pointer to an interrupt affinity descriptor structure
+ * @icookie:	Optional pointer to a domain specific per instance cookie. If
+ *		non-NULL the content of the cookie is stored in msi_desc::data.
+ *		Must be NULL for MSI-X allocations
+ *
+ * This requires a MSI interrupt domain which lets the core code manage the
+ * MSI descriptors.
+ *
+ * Return: struct msi_map
+ *
+ *	On success msi_map::index contains the allocated index number and
+ *	msi_map::virq the corresponding Linux interrupt number
+ *
+ *	On failure msi_map::index contains the error code and msi_map::virq
+ *	is %0.
+ */
+struct msi_map msi_domain_alloc_irq_at(struct device *dev, unsigned int domi=
d, unsigned int index,
+				       const struct irq_affinity_desc *affdesc,
+				       union msi_instance_cookie *icookie)
+{
+	struct msi_map map;
+
+	msi_lock_descs(dev);
+	map =3D __msi_domain_alloc_irq_at(dev, domid, index, affdesc, icookie);
 	msi_unlock_descs(dev);
 	return map;
 }
=20
+/**
+ * msi_device_domain_alloc_wired - Allocate a "wired" interrupt on @domain
+ * @domain:	The domain to allocate on
+ * @hwirq:	The hardware interrupt number to allocate for
+ * @type:	The interrupt type
+ *
+ * This weirdness supports wire to MSI controllers like MBIGEN.
+ *
+ * @hwirq is the hardware interrupt number which is handed in from
+ * irq_create_fwspec_mapping(). As the wire to MSI domain is sparse, but
+ * sized in firmware, the hardware interrupt number cannot be used as MSI
+ * index. For the underlying irq chip the MSI index is irrelevant and
+ * all it needs is the hardware interrupt number.
+ *
+ * To handle this the MSI index is allocated with MSI_ANY_INDEX and the
+ * hardware interrupt number is stored along with the type information in
+ * msi_desc::cookie so the underlying interrupt chip and domain code can
+ * retrieve it.
+ *
+ * Return: The Linux interrupt number (> 0) or an error code
+ */
+int msi_device_domain_alloc_wired(struct irq_domain *domain, unsigned int hw=
irq,
+				  unsigned int type)
+{
+	unsigned int domid =3D MSI_DEFAULT_DOMAIN;
+	union msi_instance_cookie icookie =3D { };
+	struct device *dev =3D domain->dev;
+	struct msi_map map =3D { };
+
+	if (WARN_ON_ONCE(!dev || domain->bus_token !=3D DOMAIN_BUS_WIRED_TO_MSI))
+		return -EINVAL;
+
+	icookie.value =3D ((u64)type << 32) | hwirq;
+
+	msi_lock_descs(dev);
+	if (WARN_ON_ONCE(msi_get_device_domain(dev, domid) !=3D domain))
+		map.index =3D -EINVAL;
+	else
+		map =3D __msi_domain_alloc_irq_at(dev, domid, MSI_ANY_INDEX, NULL, &icooki=
e);
+	msi_unlock_descs(dev);
+
+	return map.index >=3D 0 ? map.virq : map.index;
+}
+
 static void __msi_domain_free_irqs(struct device *dev, struct irq_domain *do=
main,
 				   struct msi_ctrl *ctrl)
 {
@@ -1628,6 +1712,30 @@ void msi_domain_free_irqs_all(struct device *dev, unsi=
gned int domid)
 	msi_unlock_descs(dev);
 }
=20
+/**
+ * msi_device_domain_free_wired - Free a wired interrupt in @domain
+ * @domain:	The domain to free the interrupt on
+ * @virq:	The Linux interrupt number to free
+ *
+ * This is the counterpart of msi_device_domain_alloc_wired() for the
+ * weird wired to MSI converting domains.
+ */
+void msi_device_domain_free_wired(struct irq_domain *domain, unsigned int vi=
rq)
+{
+	struct msi_desc *desc =3D irq_get_msi_desc(virq);
+	struct device *dev =3D domain->dev;
+
+	if (WARN_ON_ONCE(!dev || !desc || domain->bus_token !=3D DOMAIN_BUS_WIRED_T=
O_MSI))
+		return;
+
+	msi_lock_descs(dev);
+	if (!WARN_ON_ONCE(msi_get_device_domain(dev, MSI_DEFAULT_DOMAIN) !=3D domai=
n)) {
+		msi_domain_free_irqs_range_locked(dev, MSI_DEFAULT_DOMAIN, desc->msi_index,
+						  desc->msi_index);
+	}
+	msi_unlock_descs(dev);
+}
+
 /**
  * msi_get_domain_info - Get the MSI interrupt domain info for @domain
  * @domain:	The interrupt domain to retrieve data from


