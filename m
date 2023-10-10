Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF2B7C409E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343759AbjJJUE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjJJUEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:04:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF00CD3;
        Tue, 10 Oct 2023 13:03:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E48C433C9;
        Tue, 10 Oct 2023 20:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696968229;
        bh=dMpX0wNr6lJF7oM8J9hDL395/DiL4CJy7SEfxdvfuaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gx5qUds8nVNyUuk+cY9nz+ko2m1D4990aUnIdWKSi0WO7EcFaQcg9YrFtTY5iGn17
         PGqC3GBB/CWrWaN8ErNG9zFPZ6aXPlnhlPIIRjj34mQ+MEJRPT9xsq7xW9Yu71FuNc
         R24LSl1AWb9Fmlqe1n2ID3wMFcfWTa0jXj3G/XW8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.14.327
Date:   Tue, 10 Oct 2023 22:03:40 +0200
Message-ID: <2023101040-reproach-bath-538c@gregkh>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <2023101040-reattach-dubbed-fd03@gregkh>
References: <2023101040-reattach-dubbed-fd03@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 4a2043c6272c..2f6318924f21 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 14
-SUBLEVEL = 326
+SUBLEVEL = 327
 EXTRAVERSION =
 NAME = Petit Gorille
 
diff --git a/arch/parisc/include/asm/ldcw.h b/arch/parisc/include/asm/ldcw.h
index 3eb4bfc1fb36..5ed52819e956 100644
--- a/arch/parisc/include/asm/ldcw.h
+++ b/arch/parisc/include/asm/ldcw.h
@@ -2,14 +2,28 @@
 #ifndef __PARISC_LDCW_H
 #define __PARISC_LDCW_H
 
-#ifndef CONFIG_PA20
 /* Because kmalloc only guarantees 8-byte alignment for kmalloc'd data,
    and GCC only guarantees 8-byte alignment for stack locals, we can't
    be assured of 16-byte alignment for atomic lock data even if we
    specify "__attribute ((aligned(16)))" in the type declaration.  So,
    we use a struct containing an array of four ints for the atomic lock
    type and dynamically select the 16-byte aligned int from the array
-   for the semaphore.  */
+   for the semaphore. */
+
+/* From: "Jim Hull" <jim.hull of hp.com>
+   I've attached a summary of the change, but basically, for PA 2.0, as
+   long as the ",CO" (coherent operation) completer is implemented, then the
+   16-byte alignment requirement for ldcw and ldcd is relaxed, and instead
+   they only require "natural" alignment (4-byte for ldcw, 8-byte for
+   ldcd).
+
+   Although the cache control hint is accepted by all PA 2.0 processors,
+   it is only implemented on PA8800/PA8900 CPUs. Prior PA8X00 CPUs still
+   require 16-byte alignment. If the address is unaligned, the operation
+   of the instruction is undefined. The ldcw instruction does not generate
+   unaligned data reference traps so misaligned accesses are not detected.
+   This hid the problem for years. So, restore the 16-byte alignment dropped
+   by Kyle McMartin in "Remove __ldcw_align for PA-RISC 2.0 processors". */
 
 #define __PA_LDCW_ALIGNMENT	16
 #define __PA_LDCW_ALIGN_ORDER	4
@@ -19,22 +33,12 @@
 		& ~(__PA_LDCW_ALIGNMENT - 1);			\
 	(volatile unsigned int *) __ret;			\
 })
-#define __LDCW	"ldcw"
 
-#else /*CONFIG_PA20*/
-/* From: "Jim Hull" <jim.hull of hp.com>
-   I've attached a summary of the change, but basically, for PA 2.0, as
-   long as the ",CO" (coherent operation) completer is specified, then the
-   16-byte alignment requirement for ldcw and ldcd is relaxed, and instead
-   they only require "natural" alignment (4-byte for ldcw, 8-byte for
-   ldcd). */
-
-#define __PA_LDCW_ALIGNMENT	4
-#define __PA_LDCW_ALIGN_ORDER	2
-#define __ldcw_align(a) (&(a)->slock)
+#ifdef CONFIG_PA20
 #define __LDCW	"ldcw,co"
-
-#endif /*!CONFIG_PA20*/
+#else
+#define __LDCW	"ldcw"
+#endif
 
 /* LDCW, the only atomic read-write operation PA-RISC has. *sigh*.
    We don't explicitly expose that "*a" may be written as reload
diff --git a/arch/parisc/include/asm/ropes.h b/arch/parisc/include/asm/ropes.h
index 8e51c775c80a..62399c7ea94a 100644
--- a/arch/parisc/include/asm/ropes.h
+++ b/arch/parisc/include/asm/ropes.h
@@ -86,6 +86,9 @@ struct sba_device {
 	struct ioc		ioc[MAX_IOC];
 };
 
+/* list of SBA's in system, see drivers/parisc/sba_iommu.c */
+extern struct sba_device *sba_list;
+
 #define ASTRO_RUNWAY_PORT	0x582
 #define IKE_MERCED_PORT		0x803
 #define REO_MERCED_PORT		0x804
diff --git a/arch/parisc/include/asm/spinlock_types.h b/arch/parisc/include/asm/spinlock_types.h
index 42979c5704dc..82d2384c3f22 100644
--- a/arch/parisc/include/asm/spinlock_types.h
+++ b/arch/parisc/include/asm/spinlock_types.h
@@ -3,13 +3,8 @@
 #define __ASM_SPINLOCK_TYPES_H
 
 typedef struct {
-#ifdef CONFIG_PA20
-	volatile unsigned int slock;
-# define __ARCH_SPIN_LOCK_UNLOCKED { 1 }
-#else
 	volatile unsigned int lock[4];
 # define __ARCH_SPIN_LOCK_UNLOCKED	{ { 1, 1, 1, 1 } }
-#endif
 } arch_spinlock_t;
 
 typedef struct {
diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
index c152c30c2d06..11c1505775f8 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -392,7 +392,7 @@ union irq_stack_union {
 	volatile unsigned int lock[1];
 };
 
-DEFINE_PER_CPU(union irq_stack_union, irq_stack_union) = {
+static DEFINE_PER_CPU(union irq_stack_union, irq_stack_union) = {
 		.slock = { 1,1,1,1 },
 	};
 #endif
diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 2bb798918483..e6eb2b4cf97e 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -1326,7 +1326,7 @@ static int h_24x7_event_init(struct perf_event *event)
 	}
 
 	domain = event_get_domain(event);
-	if (domain >= HV_PERF_DOMAIN_MAX) {
+	if (domain  == 0 || domain >= HV_PERF_DOMAIN_MAX) {
 		pr_devel("invalid domain %d\n", domain);
 		return -EINVAL;
 	}
diff --git a/arch/xtensa/boot/Makefile b/arch/xtensa/boot/Makefile
index 8c20a7965bda..7acb04aeb577 100644
--- a/arch/xtensa/boot/Makefile
+++ b/arch/xtensa/boot/Makefile
@@ -9,8 +9,7 @@
 
 
 # KBUILD_CFLAGS used when building rest of boot (takes effect recursively)
-KBUILD_CFLAGS	+= -fno-builtin -Iarch/$(ARCH)/boot/include
-HOSTFLAGS	+= -Iarch/$(ARCH)/boot/include
+KBUILD_CFLAGS	+= -fno-builtin
 
 BIG_ENDIAN	:= $(shell echo __XTENSA_EB__ | $(CC) -E - | grep -v "\#")
 
diff --git a/arch/xtensa/boot/lib/zmem.c b/arch/xtensa/boot/lib/zmem.c
index e3ecd743c515..b89189355122 100644
--- a/arch/xtensa/boot/lib/zmem.c
+++ b/arch/xtensa/boot/lib/zmem.c
@@ -4,13 +4,14 @@
 /* bits taken from ppc */
 
 extern void *avail_ram, *end_avail;
+void gunzip(void *dst, int dstlen, unsigned char *src, int *lenp);
 
-void exit (void)
+static void exit(void)
 {
   for (;;);
 }
 
-void *zalloc(unsigned size)
+static void *zalloc(unsigned int size)
 {
         void *p = avail_ram;
 
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 0905c07b8c7e..5b810a290b93 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -670,7 +670,7 @@ static void ahci_pci_init_controller(struct ata_host *host)
 
 		/* clear port IRQ */
 		tmp = readl(port_mmio + PORT_IRQ_STAT);
-		VPRINTK("PORT_IRQ_STAT 0x%x\n", tmp);
+		dev_dbg(&pdev->dev, "PORT_IRQ_STAT 0x%x\n", tmp);
 		if (tmp)
 			writel(tmp, port_mmio + PORT_IRQ_STAT);
 	}
@@ -1480,7 +1480,6 @@ static irqreturn_t ahci_thunderx_irq_handler(int irq, void *dev_instance)
 	u32 irq_stat, irq_masked;
 	unsigned int handled = 1;
 
-	VPRINTK("ENTER\n");
 	hpriv = host->private_data;
 	mmio = hpriv->mmio;
 	irq_stat = readl(mmio + HOST_IRQ_STAT);
@@ -1497,7 +1496,6 @@ static irqreturn_t ahci_thunderx_irq_handler(int irq, void *dev_instance)
 		irq_stat = readl(mmio + HOST_IRQ_STAT);
 		spin_unlock(&host->lock);
 	} while (irq_stat);
-	VPRINTK("EXIT\n");
 
 	return IRQ_RETVAL(handled);
 }
@@ -1777,6 +1775,15 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	else
 		dev_info(&pdev->dev, "SSS flag set, parallel bus scan disabled\n");
 
+	if (!(hpriv->cap & HOST_CAP_PART))
+		host->flags |= ATA_HOST_NO_PART;
+
+	if (!(hpriv->cap & HOST_CAP_SSC))
+		host->flags |= ATA_HOST_NO_SSC;
+
+	if (!(hpriv->cap2 & HOST_CAP2_SDS))
+		host->flags |= ATA_HOST_NO_DEVSLP;
+
 	if (pi.flags & ATA_FLAG_EM)
 		ahci_reset_em(host);
 
diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index ad58da7c9aff..06826ec47454 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -601,8 +601,6 @@ static irqreturn_t xgene_ahci_irq_intr(int irq, void *dev_instance)
 	void __iomem *mmio;
 	u32 irq_stat, irq_masked;
 
-	VPRINTK("ENTER\n");
-
 	hpriv = host->private_data;
 	mmio = hpriv->mmio;
 
@@ -625,8 +623,6 @@ static irqreturn_t xgene_ahci_irq_intr(int irq, void *dev_instance)
 
 	spin_unlock(&host->lock);
 
-	VPRINTK("EXIT\n");
-
 	return IRQ_RETVAL(rc);
 }
 
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 1fe18a4983f0..563fcef14b7c 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1196,6 +1196,26 @@ static ssize_t ahci_activity_show(struct ata_device *dev, char *buf)
 	return sprintf(buf, "%d\n", emp->blink_policy);
 }
 
+static void ahci_port_clear_pending_irq(struct ata_port *ap)
+{
+	struct ahci_host_priv *hpriv = ap->host->private_data;
+	void __iomem *port_mmio = ahci_port_base(ap);
+	u32 tmp;
+
+	/* clear SError */
+	tmp = readl(port_mmio + PORT_SCR_ERR);
+	dev_dbg(ap->host->dev, "PORT_SCR_ERR 0x%x\n", tmp);
+	writel(tmp, port_mmio + PORT_SCR_ERR);
+
+	/* clear port IRQ */
+	tmp = readl(port_mmio + PORT_IRQ_STAT);
+	dev_dbg(ap->host->dev, "PORT_IRQ_STAT 0x%x\n", tmp);
+	if (tmp)
+		writel(tmp, port_mmio + PORT_IRQ_STAT);
+
+	writel(1 << ap->port_no, hpriv->mmio + HOST_IRQ_STAT);
+}
+
 static void ahci_port_init(struct device *dev, struct ata_port *ap,
 			   int port_no, void __iomem *mmio,
 			   void __iomem *port_mmio)
@@ -1210,18 +1230,7 @@ static void ahci_port_init(struct device *dev, struct ata_port *ap,
 	if (rc)
 		dev_warn(dev, "%s (%d)\n", emsg, rc);
 
-	/* clear SError */
-	tmp = readl(port_mmio + PORT_SCR_ERR);
-	VPRINTK("PORT_SCR_ERR 0x%x\n", tmp);
-	writel(tmp, port_mmio + PORT_SCR_ERR);
-
-	/* clear port IRQ */
-	tmp = readl(port_mmio + PORT_IRQ_STAT);
-	VPRINTK("PORT_IRQ_STAT 0x%x\n", tmp);
-	if (tmp)
-		writel(tmp, port_mmio + PORT_IRQ_STAT);
-
-	writel(1 << port_no, mmio + HOST_IRQ_STAT);
+	ahci_port_clear_pending_irq(ap);
 
 	/* mark esata ports */
 	tmp = readl(port_mmio + PORT_CMD);
@@ -1248,10 +1257,10 @@ void ahci_init_controller(struct ata_host *host)
 	}
 
 	tmp = readl(mmio + HOST_CTL);
-	VPRINTK("HOST_CTL 0x%x\n", tmp);
+	dev_dbg(host->dev, "HOST_CTL 0x%x\n", tmp);
 	writel(tmp | HOST_IRQ_EN, mmio + HOST_CTL);
 	tmp = readl(mmio + HOST_CTL);
-	VPRINTK("HOST_CTL 0x%x\n", tmp);
+	dev_dbg(host->dev, "HOST_CTL 0x%x\n", tmp);
 }
 EXPORT_SYMBOL_GPL(ahci_init_controller);
 
@@ -1551,6 +1560,8 @@ int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
 	tf.command = ATA_BUSY;
 	ata_tf_to_fis(&tf, 0, 0, d2h_fis);
 
+	ahci_port_clear_pending_irq(ap);
+
 	rc = sata_link_hardreset(link, timing, deadline, online,
 				 ahci_check_ready);
 
@@ -1902,8 +1913,6 @@ static irqreturn_t ahci_multi_irqs_intr_hard(int irq, void *dev_instance)
 	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 status;
 
-	VPRINTK("ENTER\n");
-
 	status = readl(port_mmio + PORT_IRQ_STAT);
 	writel(status, port_mmio + PORT_IRQ_STAT);
 
@@ -1911,8 +1920,6 @@ static irqreturn_t ahci_multi_irqs_intr_hard(int irq, void *dev_instance)
 	ahci_handle_port_interrupt(ap, port_mmio, status);
 	spin_unlock(ap->lock);
 
-	VPRINTK("EXIT\n");
-
 	return IRQ_HANDLED;
 }
 
@@ -1929,9 +1936,7 @@ u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked)
 		ap = host->ports[i];
 		if (ap) {
 			ahci_port_intr(ap);
-			VPRINTK("port %u\n", i);
 		} else {
-			VPRINTK("port %u (no irq)\n", i);
 			if (ata_ratelimit())
 				dev_warn(host->dev,
 					 "interrupt on disabled port %u\n", i);
@@ -1952,8 +1957,6 @@ static irqreturn_t ahci_single_level_irq_intr(int irq, void *dev_instance)
 	void __iomem *mmio;
 	u32 irq_stat, irq_masked;
 
-	VPRINTK("ENTER\n");
-
 	hpriv = host->private_data;
 	mmio = hpriv->mmio;
 
@@ -1981,8 +1984,6 @@ static irqreturn_t ahci_single_level_irq_intr(int irq, void *dev_instance)
 
 	spin_unlock(&host->lock);
 
-	VPRINTK("EXIT\n");
-
 	return IRQ_RETVAL(rc);
 }
 
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 08dc37a62f5a..d17107cb1e09 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3993,10 +3993,23 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 		scontrol |= (0x6 << 8);
 		break;
 	case ATA_LPM_MIN_POWER:
-		if (ata_link_nr_enabled(link) > 0)
-			/* no restrictions on LPM transitions */
+		if (ata_link_nr_enabled(link) > 0) {
+			/* assume no restrictions on LPM transitions */
 			scontrol &= ~(0x7 << 8);
-		else {
+
+			/*
+			 * If the controller does not support partial, slumber,
+			 * or devsleep, then disallow these transitions.
+			 */
+			if (link->ap->host->flags & ATA_HOST_NO_PART)
+				scontrol |= (0x1 << 8);
+
+			if (link->ap->host->flags & ATA_HOST_NO_SSC)
+				scontrol |= (0x2 << 8);
+
+			if (link->ap->host->flags & ATA_HOST_NO_DEVSLP)
+				scontrol |= (0x4 << 8);
+		} else {
 			/* empty port, power off */
 			scontrol &= ~0xf;
 			scontrol |= (0x1 << 2);
@@ -5708,17 +5721,19 @@ static void ata_port_request_pm(struct ata_port *ap, pm_message_t mesg,
 	struct ata_link *link;
 	unsigned long flags;
 
-	/* Previous resume operation might still be in
-	 * progress.  Wait for PM_PENDING to clear.
+	spin_lock_irqsave(ap->lock, flags);
+
+	/*
+	 * A previous PM operation might still be in progress. Wait for
+	 * ATA_PFLAG_PM_PENDING to clear.
 	 */
 	if (ap->pflags & ATA_PFLAG_PM_PENDING) {
+		spin_unlock_irqrestore(ap->lock, flags);
 		ata_port_wait_eh(ap);
-		WARN_ON(ap->pflags & ATA_PFLAG_PM_PENDING);
+		spin_lock_irqsave(ap->lock, flags);
 	}
 
-	/* request PM ops to EH */
-	spin_lock_irqsave(ap->lock, flags);
-
+	/* Request PM operation to EH */
 	ap->pm_mesg = mesg;
 	ap->pflags |= ATA_PFLAG_PM_PENDING;
 	ata_for_each_link(link, ap, HOST_FIRST) {
@@ -5730,10 +5745,8 @@ static void ata_port_request_pm(struct ata_port *ap, pm_message_t mesg,
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
-	if (!async) {
+	if (!async)
 		ata_port_wait_eh(ap);
-		WARN_ON(ap->pflags & ATA_PFLAG_PM_PENDING);
-	}
 }
 
 /*
@@ -6672,11 +6685,30 @@ static void ata_port_detach(struct ata_port *ap)
 	if (!ap->ops->error_handler)
 		goto skip_eh;
 
-	/* tell EH we're leaving & flush EH */
+	/* Wait for any ongoing EH */
+	ata_port_wait_eh(ap);
+
+	mutex_lock(&ap->scsi_scan_mutex);
 	spin_lock_irqsave(ap->lock, flags);
+
+	/* Remove scsi devices */
+	ata_for_each_link(link, ap, HOST_FIRST) {
+		ata_for_each_dev(dev, link, ALL) {
+			if (dev->sdev) {
+				spin_unlock_irqrestore(ap->lock, flags);
+				scsi_remove_device(dev->sdev);
+				spin_lock_irqsave(ap->lock, flags);
+				dev->sdev = NULL;
+			}
+		}
+	}
+
+	/* Tell EH to disable all devices */
 	ap->pflags |= ATA_PFLAG_UNLOADING;
 	ata_port_schedule_eh(ap);
+
 	spin_unlock_irqrestore(ap->lock, flags);
+	mutex_unlock(&ap->scsi_scan_mutex);
 
 	/* wait till EH commits suicide */
 	ata_port_wait_eh(ap);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index cbe9af624a06..8a789de05680 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2948,18 +2948,11 @@ int ata_eh_reset(struct ata_link *link, int classify,
 			postreset(slave, classes);
 	}
 
-	/*
-	 * Some controllers can't be frozen very well and may set spurious
-	 * error conditions during reset.  Clear accumulated error
-	 * information and re-thaw the port if frozen.  As reset is the
-	 * final recovery action and we cross check link onlineness against
-	 * device classification later, no hotplug event is lost by this.
-	 */
+	/* clear cached SError */
 	spin_lock_irqsave(link->ap->lock, flags);
-	memset(&link->eh_info, 0, sizeof(link->eh_info));
+	link->eh_info.serror = 0;
 	if (slave)
-		memset(&slave->eh_info, 0, sizeof(link->eh_info));
-	ap->pflags &= ~ATA_PFLAG_EH_PENDING;
+		slave->eh_info.serror = 0;
 	spin_unlock_irqrestore(link->ap->lock, flags);
 
 	if (ap->pflags & ATA_PFLAG_FROZEN)
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b44e8bc759c0..38df4346fb58 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4562,7 +4562,7 @@ void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
 		break;
 
 	case MAINTENANCE_IN:
-		if (scsicmd[1] == MI_REPORT_SUPPORTED_OPERATION_CODES)
+		if ((scsicmd[1] & 0x1f) == MI_REPORT_SUPPORTED_OPERATION_CODES)
 			ata_scsi_rbuf_fill(&args, ata_scsiop_maint_in);
 		else
 			ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
diff --git a/drivers/base/regmap/regcache-rbtree.c b/drivers/base/regmap/regcache-rbtree.c
index 7353c5527087..b6f8f4059e25 100644
--- a/drivers/base/regmap/regcache-rbtree.c
+++ b/drivers/base/regmap/regcache-rbtree.c
@@ -467,7 +467,8 @@ static int regcache_rbtree_write(struct regmap *map, unsigned int reg,
 		if (!rbnode)
 			return -ENOMEM;
 		regcache_rbtree_set_register(map, rbnode,
-					     reg - rbnode->base_reg, value);
+					     (reg - rbnode->base_reg) / map->reg_stride,
+					     value);
 		regcache_rbtree_insert(map, &rbtree_ctx->root, rbnode);
 		rbtree_ctx->cached_rbnode = rbnode;
 	}
diff --git a/drivers/char/agp/parisc-agp.c b/drivers/char/agp/parisc-agp.c
index 1d5510cb6db4..1962ff624b7c 100644
--- a/drivers/char/agp/parisc-agp.c
+++ b/drivers/char/agp/parisc-agp.c
@@ -385,8 +385,6 @@ find_quicksilver(struct device *dev, void *data)
 static int __init
 parisc_agp_init(void)
 {
-	extern struct sba_device *sba_list;
-
 	int err = -1;
 	struct parisc_device *sba = NULL, *lba = NULL;
 	struct lba_device *lbadev = NULL;
diff --git a/drivers/clk/tegra/clk-bpmp.c b/drivers/clk/tegra/clk-bpmp.c
index 6c933b0e29a3..fcb7c599583b 100644
--- a/drivers/clk/tegra/clk-bpmp.c
+++ b/drivers/clk/tegra/clk-bpmp.c
@@ -154,7 +154,7 @@ static unsigned long tegra_bpmp_clk_recalc_rate(struct clk_hw *hw,
 
 	err = tegra_bpmp_clk_transfer(clk->bpmp, &msg);
 	if (err < 0)
-		return err;
+		return 0;
 
 	return response.rate;
 }
diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index f6d1bda8a802..035b2aee9e1f 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -763,7 +763,7 @@ static int aspeed_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 	else if (param == PIN_CONFIG_BIAS_DISABLE ||
 			param == PIN_CONFIG_BIAS_PULL_DOWN ||
 			param == PIN_CONFIG_DRIVE_STRENGTH)
-		return pinctrl_gpio_set_config(offset, config);
+		return pinctrl_gpio_set_config(chip->base + offset, config);
 	else if (param == PIN_CONFIG_DRIVE_OPEN_DRAIN ||
 			param == PIN_CONFIG_DRIVE_OPEN_SOURCE)
 		/* Return -ENOTSUPP to trigger emulation, as per datasheet */
diff --git a/drivers/gpio/gpio-tb10x.c b/drivers/gpio/gpio-tb10x.c
index 091ffaaec635..97a9d9823475 100644
--- a/drivers/gpio/gpio-tb10x.c
+++ b/drivers/gpio/gpio-tb10x.c
@@ -244,7 +244,7 @@ static int tb10x_gpio_probe(struct platform_device *pdev)
 				handle_edge_irq, IRQ_NOREQUEST, IRQ_NOPROBE,
 				IRQ_GC_INIT_MASK_CACHE);
 		if (ret)
-			return ret;
+			goto err_remove_domain;
 
 		gc = tb10x_gpio->domain->gc->gc[0];
 		gc->reg_base                         = tb10x_gpio->base;
@@ -258,6 +258,10 @@ static int tb10x_gpio_probe(struct platform_device *pdev)
 	}
 
 	return 0;
+
+err_remove_domain:
+	irq_domain_remove(tb10x_gpio->domain);
+	return ret;
 }
 
 static int tb10x_gpio_remove(struct platform_device *pdev)
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index c817e3d4b52b..f544118f121b 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1670,6 +1670,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		"SMBus I801 adapter at %04lx", priv->smba);
 	err = i2c_add_adapter(&priv->adapter);
 	if (err) {
+		platform_device_unregister(priv->tco_pdev);
 		i801_acpi_remove(priv);
 		return err;
 	}
diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index c638b2fc7fa2..647b5ff69a9c 100644
--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -243,6 +243,10 @@ static int i2c_demux_pinctrl_probe(struct platform_device *pdev)
 
 		props[i].name = devm_kstrdup(&pdev->dev, "status", GFP_KERNEL);
 		props[i].value = devm_kstrdup(&pdev->dev, "ok", GFP_KERNEL);
+		if (!props[i].name || !props[i].value) {
+			err = -ENOMEM;
+			goto err_rollback;
+		}
 		props[i].length = 3;
 
 		of_changeset_init(&priv->chan[i].chgset);
diff --git a/drivers/infiniband/core/cma_configfs.c b/drivers/infiniband/core/cma_configfs.c
index ac47e8a1dfbf..b71332086d27 100644
--- a/drivers/infiniband/core/cma_configfs.c
+++ b/drivers/infiniband/core/cma_configfs.c
@@ -215,7 +215,7 @@ static int make_cma_ports(struct cma_dev_group *cma_dev_group,
 	}
 
 	for (i = 0; i < ports_num; i++) {
-		char port_str[10];
+		char port_str[11];
 
 		ports[i].port_num = i + 1;
 		snprintf(port_str, sizeof(port_str), "%u", i + 1);
diff --git a/drivers/infiniband/hw/mlx4/sysfs.c b/drivers/infiniband/hw/mlx4/sysfs.c
index d2da28d613f2..eb95292d12dc 100644
--- a/drivers/infiniband/hw/mlx4/sysfs.c
+++ b/drivers/infiniband/hw/mlx4/sysfs.c
@@ -221,7 +221,7 @@ void del_sysfs_port_mcg_attr(struct mlx4_ib_dev *device, int port_num,
 static int add_port_entries(struct mlx4_ib_dev *device, int port_num)
 {
 	int i;
-	char buff[11];
+	char buff[12];
 	struct mlx4_ib_iov_port *port = NULL;
 	int ret = 0 ;
 	struct ib_port_attr attr;
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 3fbe3962d53b..7d8bd97274f3 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1680,7 +1680,7 @@ static inline char *mmap_cmd2str(enum mlx5_ib_mmap_cmd cmd)
 	case MLX5_IB_MMAP_NC_PAGE:
 		return "NC";
 	default:
-		return NULL;
+		return "Unknown";
 	}
 }
 
diff --git a/drivers/media/dvb-frontends/sp8870.c b/drivers/media/dvb-frontends/sp8870.c
index a5782d1133df..1f6df162279e 100644
--- a/drivers/media/dvb-frontends/sp8870.c
+++ b/drivers/media/dvb-frontends/sp8870.c
@@ -619,4 +619,4 @@ MODULE_DESCRIPTION("Spase SP8870 DVB-T Demodulator driver");
 MODULE_AUTHOR("Juergen Peitz");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(sp8870_attach);
+EXPORT_SYMBOL_GPL(sp8870_attach);
diff --git a/drivers/media/tuners/tuner-xc2028.c b/drivers/media/tuners/tuner-xc2028.c
index b5b62b08159e..2639d70de867 100644
--- a/drivers/media/tuners/tuner-xc2028.c
+++ b/drivers/media/tuners/tuner-xc2028.c
@@ -1516,7 +1516,7 @@ struct dvb_frontend *xc2028_attach(struct dvb_frontend *fe,
 	return NULL;
 }
 
-EXPORT_SYMBOL(xc2028_attach);
+EXPORT_SYMBOL_GPL(xc2028_attach);
 
 MODULE_DESCRIPTION("Xceive xc2028/xc3028 tuner driver");
 MODULE_AUTHOR("Michel Ludwig <michel.ludwig@gmail.com>");
diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index 4ee1ff84076d..f42e4b9fdea1 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -869,6 +869,13 @@ int ubi_attach_mtd_dev(struct mtd_info *mtd, int ubi_num,
 		return -EINVAL;
 	}
 
+	/* UBI cannot work on flashes with zero erasesize. */
+	if (!mtd->erasesize) {
+		pr_err("ubi: refuse attaching mtd%d - zero erasesize flash is not supported\n",
+			mtd->index);
+		return -EINVAL;
+	}
+
 	if (ubi_num == UBI_DEV_NUM_AUTO) {
 		/* Search for an empty slot in the @ubi_devices array */
 		for (ubi_num = 0; ubi_num < UBI_MAX_DEVICES; ubi_num++)
diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 7b6cae28f6d3..db7069e46eff 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2087,7 +2087,12 @@ static const struct ethtool_ops team_ethtool_ops = {
 static void team_setup_by_port(struct net_device *dev,
 			       struct net_device *port_dev)
 {
-	dev->header_ops	= port_dev->header_ops;
+	struct team *team = netdev_priv(dev);
+
+	if (port_dev->type == ARPHRD_ETHER)
+		dev->header_ops	= team->header_ops_cache;
+	else
+		dev->header_ops	= port_dev->header_ops;
 	dev->type = port_dev->type;
 	dev->hard_header_len = port_dev->hard_header_len;
 	dev->needed_headroom = port_dev->needed_headroom;
@@ -2134,8 +2139,11 @@ static int team_dev_type_check_change(struct net_device *dev,
 
 static void team_setup(struct net_device *dev)
 {
+	struct team *team = netdev_priv(dev);
+
 	ether_setup(dev);
 	dev->max_mtu = ETH_MAX_MTU;
+	team->header_ops_cache = dev->header_ops;
 
 	dev->netdev_ops = &team_netdev_ops;
 	dev->ethtool_ops = &team_ethtool_ops;
diff --git a/drivers/net/usb/smsc75xx.c b/drivers/net/usb/smsc75xx.c
index 313a4b0edc6b..573d7ad2e708 100644
--- a/drivers/net/usb/smsc75xx.c
+++ b/drivers/net/usb/smsc75xx.c
@@ -102,7 +102,9 @@ static int __must_check __smsc75xx_read_reg(struct usbnet *dev, u32 index,
 	ret = fn(dev, USB_VENDOR_REQUEST_READ_REGISTER, USB_DIR_IN
 		 | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 		 0, index, &buf, 4);
-	if (unlikely(ret < 0)) {
+	if (unlikely(ret < 4)) {
+		ret = ret < 0 ? ret : -ENODATA;
+
 		netdev_warn(dev->net, "Failed to read reg index 0x%08x: %d\n",
 			    index, ret);
 		return ret;
diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 978f642daced..00cc9b755a85 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -37,6 +37,8 @@
 
 #define TDM_PPPOHT_SLIC_MAXIN
 
+static int uhdlc_close(struct net_device *dev);
+
 static struct ucc_tdm_info utdm_primary_info = {
 	.uf_info = {
 		.tsa = 0,
@@ -662,6 +664,7 @@ static int uhdlc_open(struct net_device *dev)
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	struct ucc_hdlc_private *priv = hdlc->priv;
 	struct ucc_tdm *utdm = priv->utdm;
+	int rc = 0;
 
 	if (priv->hdlc_busy != 1) {
 		if (request_irq(priv->ut_info->uf_info.irq,
@@ -684,10 +687,13 @@ static int uhdlc_open(struct net_device *dev)
 		netif_device_attach(priv->ndev);
 		napi_enable(&priv->napi);
 		netif_start_queue(dev);
-		hdlc_open(dev);
+
+		rc = hdlc_open(dev);
+		if (rc)
+			uhdlc_close(dev);
 	}
 
-	return 0;
+	return rc;
 }
 
 static void uhdlc_memclean(struct ucc_hdlc_private *priv)
@@ -776,6 +782,8 @@ static int uhdlc_close(struct net_device *dev)
 	netif_stop_queue(dev);
 	priv->hdlc_busy = 0;
 
+	hdlc_close(dev);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
index 274dd5a1574a..73aff9b79958 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
@@ -992,8 +992,8 @@ void mwifiex_11n_rxba_sync_event(struct mwifiex_private *priv,
 			}
 		}
 
-		tlv_buf_left -= (sizeof(*tlv_rxba) + tlv_len);
-		tmp = (u8 *)tlv_rxba + tlv_len + sizeof(*tlv_rxba);
+		tlv_buf_left -= (sizeof(tlv_rxba->header) + tlv_len);
+		tmp = (u8 *)tlv_rxba  + sizeof(tlv_rxba->header) + tlv_len;
 		tlv_rxba = (struct mwifiex_ie_types_rxba_sync *)tmp;
 	}
 }
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_rx.c b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
index f3c6daeba1b8..346e91b9f2ad 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_rx.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
@@ -98,7 +98,8 @@ int mwifiex_process_rx_packet(struct mwifiex_private *priv,
 	rx_pkt_len = le16_to_cpu(local_rx_pd->rx_pkt_length);
 	rx_pkt_hdr = (void *)local_rx_pd + rx_pkt_off;
 
-	if (sizeof(*rx_pkt_hdr) + rx_pkt_off > skb->len) {
+	if (sizeof(rx_pkt_hdr->eth803_hdr) + sizeof(rfc1042_header) +
+	    rx_pkt_off > skb->len) {
 		mwifiex_dbg(priv->adapter, ERROR,
 			    "wrong rx packet offset: len=%d, rx_pkt_off=%d\n",
 			    skb->len, rx_pkt_off);
@@ -107,12 +108,13 @@ int mwifiex_process_rx_packet(struct mwifiex_private *priv,
 		return -1;
 	}
 
-	if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
-		     sizeof(bridge_tunnel_header))) ||
-	    (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
-		     sizeof(rfc1042_header)) &&
-	     ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) != ETH_P_AARP &&
-	     ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) != ETH_P_IPX)) {
+	if (sizeof(*rx_pkt_hdr) + rx_pkt_off <= skb->len &&
+	    ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
+		      sizeof(bridge_tunnel_header))) ||
+	     (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
+		      sizeof(rfc1042_header)) &&
+	      ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) != ETH_P_AARP &&
+	      ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) != ETH_P_IPX))) {
 		/*
 		 *  Replace the 803 header and rfc1042 header (llc/snap) with an
 		 *    EthernetII header, keep the src/dst and snap_type
diff --git a/drivers/parisc/iosapic.c b/drivers/parisc/iosapic.c
index eb9137faccf7..4cc08d13b82f 100644
--- a/drivers/parisc/iosapic.c
+++ b/drivers/parisc/iosapic.c
@@ -216,9 +216,9 @@ static inline void iosapic_write(void __iomem *iosapic, unsigned int reg, u32 va
 
 static DEFINE_SPINLOCK(iosapic_lock);
 
-static inline void iosapic_eoi(void __iomem *addr, unsigned int data)
+static inline void iosapic_eoi(__le32 __iomem *addr, __le32 data)
 {
-	__raw_writel(data, addr);
+	__raw_writel((__force u32)data, addr);
 }
 
 /*
diff --git a/drivers/parisc/iosapic_private.h b/drivers/parisc/iosapic_private.h
index 6e05e30a2450..7a928c03d520 100644
--- a/drivers/parisc/iosapic_private.h
+++ b/drivers/parisc/iosapic_private.h
@@ -132,8 +132,8 @@ struct iosapic_irt {
 struct vector_info {
 	struct iosapic_info *iosapic;	/* I/O SAPIC this vector is on */
 	struct irt_entry *irte;		/* IRT entry */
-	u32 __iomem *eoi_addr;		/* precalculate EOI reg address */
-	u32	eoi_data;		/* IA64: ?       PA: swapped txn_data */
+	__le32 __iomem *eoi_addr;	/* precalculate EOI reg address */
+	__le32	eoi_data;		/* IA64: ?       PA: swapped txn_data */
 	int	txn_irq;		/* virtual IRQ number for processor */
 	ulong	txn_addr;		/* IA64: id_eid  PA: partial HPA */
 	u32	txn_data;		/* CPU interrupt bit */
diff --git a/drivers/s390/scsi/zfcp_aux.c b/drivers/s390/scsi/zfcp_aux.c
index fab02bd73d85..843c5aa62933 100644
--- a/drivers/s390/scsi/zfcp_aux.c
+++ b/drivers/s390/scsi/zfcp_aux.c
@@ -492,12 +492,12 @@ struct zfcp_port *zfcp_port_enqueue(struct zfcp_adapter *adapter, u64 wwpn,
 	if (port) {
 		put_device(&port->dev);
 		retval = -EEXIST;
-		goto err_out;
+		goto err_put;
 	}
 
 	port = kzalloc(sizeof(struct zfcp_port), GFP_KERNEL);
 	if (!port)
-		goto err_out;
+		goto err_put;
 
 	rwlock_init(&port->unit_list_lock);
 	INIT_LIST_HEAD(&port->unit_list);
@@ -520,7 +520,7 @@ struct zfcp_port *zfcp_port_enqueue(struct zfcp_adapter *adapter, u64 wwpn,
 
 	if (dev_set_name(&port->dev, "0x%016llx", (unsigned long long)wwpn)) {
 		kfree(port);
-		goto err_out;
+		goto err_put;
 	}
 	retval = -EINVAL;
 
@@ -537,8 +537,9 @@ struct zfcp_port *zfcp_port_enqueue(struct zfcp_adapter *adapter, u64 wwpn,
 
 	return port;
 
-err_out:
+err_put:
 	zfcp_ccw_adapter_put(adapter);
+err_out:
 	return ERR_PTR(retval);
 }
 
diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index 68b2fa562201..907b06056f02 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -906,7 +906,6 @@ struct se_device *target_find_device(int id, bool do_depend)
 EXPORT_SYMBOL(target_find_device);
 
 struct devices_idr_iter {
-	struct config_item *prev_item;
 	int (*fn)(struct se_device *dev, void *data);
 	void *data;
 };
@@ -916,11 +915,9 @@ static int target_devices_idr_iter(int id, void *p, void *data)
 {
 	struct devices_idr_iter *iter = data;
 	struct se_device *dev = p;
+	struct config_item *item;
 	int ret;
 
-	config_item_put(iter->prev_item);
-	iter->prev_item = NULL;
-
 	/*
 	 * We add the device early to the idr, so it can be used
 	 * by backend modules during configuration. We do not want
@@ -930,12 +927,13 @@ static int target_devices_idr_iter(int id, void *p, void *data)
 	if (!(dev->dev_flags & DF_CONFIGURED))
 		return 0;
 
-	iter->prev_item = config_item_get_unless_zero(&dev->dev_group.cg_item);
-	if (!iter->prev_item)
+	item = config_item_get_unless_zero(&dev->dev_group.cg_item);
+	if (!item)
 		return 0;
 	mutex_unlock(&device_mutex);
 
 	ret = iter->fn(dev, iter->data);
+	config_item_put(item);
 
 	mutex_lock(&device_mutex);
 	return ret;
@@ -958,7 +956,6 @@ int target_for_each_device(int (*fn)(struct se_device *dev, void *data),
 	mutex_lock(&device_mutex);
 	ret = idr_for_each(&devices_idr, target_devices_idr_iter, &iter);
 	mutex_unlock(&device_mutex);
-	config_item_put(iter.prev_item);
 	return ret;
 }
 
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 21a94bb75065..a2bca94e99d1 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1911,7 +1911,10 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 		skip_rx = true;
 
 	if (status & (UART_LSR_DR | UART_LSR_BI) && !skip_rx) {
-		if (irqd_is_wakeup_set(irq_get_irq_data(port->irq)))
+		struct irq_data *d;
+
+		d = irq_get_irq_data(port->irq);
+		if (d && irqd_is_wakeup_set(d))
 			pm_wakeup_event(tport->tty->dev, 0);
 		if (!up->dma || handle_rx_dma(up, iir))
 			status = serial8250_rx_chars(up, status);
diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 85b6634f518a..42c9ef64108f 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -437,10 +437,17 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 			}
 		}
 
-		/* The vcs_size might have changed while we slept to grab
-		 * the user buffer, so recheck.
+		/* The vc might have been freed or vcs_size might have changed
+		 * while we slept to grab the user buffer, so recheck.
 		 * Return data written up to now on failure.
 		 */
+		vc = vcs_vc(inode, &viewed);
+		if (!vc) {
+			if (written)
+				break;
+			ret = -ENXIO;
+			goto unlock_out;
+		}
 		size = vcs_size(inode);
 		if (size < 0) {
 			if (written)
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index a7e8db955ef6..30654608297f 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2197,7 +2197,7 @@ config FB_COBALT
 
 config FB_SH7760
 	bool "SH7760/SH7763/SH7720/SH7721 LCDC support"
-	depends on FB && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763 \
+	depends on FB=y && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763 \
 		|| CPU_SUBTYPE_SH7720 || CPU_SUBTYPE_SH7721)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index 347f0389b089..5ec52032117a 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -401,6 +401,20 @@ static unsigned int iTCO_wdt_get_timeleft(struct watchdog_device *wd_dev)
 	return time_left;
 }
 
+/* Returns true if the watchdog was running */
+static bool iTCO_wdt_set_running(struct iTCO_wdt_private *p)
+{
+	u16 val;
+
+	/* Bit 11: TCO Timer Halt -> 0 = The TCO timer is enabled */
+	val = inw(TCO1_CNT(p));
+	if (!(val & BIT(11))) {
+		set_bit(WDOG_HW_RUNNING, &p->wddev.status);
+		return true;
+	}
+	return false;
+}
+
 /*
  *	Kernel Interfaces
  */
@@ -476,9 +490,6 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
 		return -ENODEV;	/* Cannot reset NO_REBOOT bit */
 	}
 
-	/* Set the NO_REBOOT bit to prevent later reboots, just for sure */
-	p->update_no_reboot_bit(p->no_reboot_priv, true);
-
 	/* The TCO logic uses the TCO_EN bit in the SMI_EN register */
 	if (!devm_request_region(dev, p->smi_res->start,
 				 resource_size(p->smi_res),
@@ -537,8 +548,13 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
 	watchdog_set_drvdata(&p->wddev, p);
 	platform_set_drvdata(pdev, p);
 
-	/* Make sure the watchdog is not running */
-	iTCO_wdt_stop(&p->wddev);
+	if (!iTCO_wdt_set_running(p)) {
+		/*
+		 * If the watchdog was not running set NO_REBOOT now to
+		 * prevent later reboots.
+		 */
+		p->update_no_reboot_bit(p->no_reboot_priv, true);
+	}
 
 	/* Check that the heartbeat value is within it's range;
 	   if not reset to the default */
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index d138027034fd..de6d3029f589 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -82,23 +82,13 @@ const struct evtchn_ops *evtchn_ops;
  */
 static DEFINE_MUTEX(irq_mapping_update_lock);
 
-/*
- * Lock protecting event handling loop against removing event channels.
- * Adding of event channels is no issue as the associated IRQ becomes active
- * only after everything is setup (before request_[threaded_]irq() the handler
- * can't be entered for an event, as the event channel will be unmasked only
- * then).
- */
-static DEFINE_RWLOCK(evtchn_rwlock);
-
 /*
  * Lock hierarchy:
  *
  * irq_mapping_update_lock
- *   evtchn_rwlock
- *     IRQ-desc lock
- *       percpu eoi_list_lock
- *         irq_info->lock
+ *   IRQ-desc lock
+ *     percpu eoi_list_lock
+ *       irq_info->lock
  */
 
 static LIST_HEAD(xen_irq_list_head);
@@ -213,6 +203,29 @@ static void set_info_for_irq(unsigned int irq, struct irq_info *info)
 		irq_set_chip_data(irq, info);
 }
 
+static void delayed_free_irq(struct work_struct *work)
+{
+	struct irq_info *info = container_of(work, struct irq_info,
+					     work);
+	unsigned int irq = info->irq;
+
+	/* Remove the info pointer only now, with no potential users left. */
+	set_info_for_irq(irq, NULL);
+
+	kfree(info);
+
+	/* Legacy IRQ descriptors are managed by the arch. */
+	if (irq >= nr_legacy_irqs())
+		irq_free_desc(irq);
+}
+
+static void rcu_free_irq(struct rcu_head *rcu_head)
+{
+	struct irq_info *info = container_of(rcu_head, struct irq_info, rcu);
+
+	queue_work(system_wq, &info->work);
+}
+
 /* Constructors for packed IRQ information. */
 static int xen_irq_info_common_setup(struct irq_info *info,
 				     unsigned irq,
@@ -547,33 +560,36 @@ static void xen_irq_lateeoi_worker(struct work_struct *work)
 
 	eoi = container_of(to_delayed_work(work), struct lateeoi_work, delayed);
 
-	read_lock_irqsave(&evtchn_rwlock, flags);
+	rcu_read_lock();
 
 	while (true) {
-		spin_lock(&eoi->eoi_list_lock);
+		spin_lock_irqsave(&eoi->eoi_list_lock, flags);
 
 		info = list_first_entry_or_null(&eoi->eoi_list, struct irq_info,
 						eoi_list);
 
-		if (info == NULL || now < info->eoi_time) {
-			spin_unlock(&eoi->eoi_list_lock);
+		if (info == NULL)
+			break;
+
+		if (now < info->eoi_time) {
+			mod_delayed_work_on(info->eoi_cpu, system_wq,
+					    &eoi->delayed,
+					    info->eoi_time - now);
 			break;
 		}
 
 		list_del_init(&info->eoi_list);
 
-		spin_unlock(&eoi->eoi_list_lock);
+		spin_unlock_irqrestore(&eoi->eoi_list_lock, flags);
 
 		info->eoi_time = 0;
 
 		xen_irq_lateeoi_locked(info, false);
 	}
 
-	if (info)
-		mod_delayed_work_on(info->eoi_cpu, system_wq,
-				    &eoi->delayed, info->eoi_time - now);
+	spin_unlock_irqrestore(&eoi->eoi_list_lock, flags);
 
-	read_unlock_irqrestore(&evtchn_rwlock, flags);
+	rcu_read_unlock();
 }
 
 static void xen_cpu_init_eoi(unsigned int cpu)
@@ -588,16 +604,15 @@ static void xen_cpu_init_eoi(unsigned int cpu)
 void xen_irq_lateeoi(unsigned int irq, unsigned int eoi_flags)
 {
 	struct irq_info *info;
-	unsigned long flags;
 
-	read_lock_irqsave(&evtchn_rwlock, flags);
+	rcu_read_lock();
 
 	info = info_for_irq(irq);
 
 	if (info)
 		xen_irq_lateeoi_locked(info, eoi_flags & XEN_EOI_FLAG_SPURIOUS);
 
-	read_unlock_irqrestore(&evtchn_rwlock, flags);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(xen_irq_lateeoi);
 
@@ -616,6 +631,7 @@ static void xen_irq_init(unsigned irq)
 
 	info->type = IRQT_UNBOUND;
 	info->refcnt = -1;
+	INIT_WORK(&info->work, delayed_free_irq);
 
 	set_info_for_irq(irq, info);
 
@@ -668,31 +684,18 @@ static int __must_check xen_allocate_irq_gsi(unsigned gsi)
 static void xen_free_irq(unsigned irq)
 {
 	struct irq_info *info = info_for_irq(irq);
-	unsigned long flags;
 
 	if (WARN_ON(!info))
 		return;
 
-	write_lock_irqsave(&evtchn_rwlock, flags);
-
 	if (!list_empty(&info->eoi_list))
 		lateeoi_list_del(info);
 
 	list_del(&info->list);
 
-	set_info_for_irq(irq, NULL);
-
 	WARN_ON(info->refcnt > 0);
 
-	write_unlock_irqrestore(&evtchn_rwlock, flags);
-
-	kfree(info);
-
-	/* Legacy IRQ descriptors are managed by the arch. */
-	if (irq < nr_legacy_irqs())
-		return;
-
-	irq_free_desc(irq);
+	call_rcu(&info->rcu, rcu_free_irq);
 }
 
 static void xen_evtchn_close(unsigned int port)
@@ -1603,7 +1606,14 @@ static void __xen_evtchn_do_upcall(void)
 	unsigned count;
 	struct evtchn_loop_ctrl ctrl = { 0 };
 
-	read_lock(&evtchn_rwlock);
+	/*
+	 * When closing an event channel the associated IRQ must not be freed
+	 * until all cpus have left the event handling loop. This is ensured
+	 * by taking the rcu_read_lock() while handling events, as freeing of
+	 * the IRQ is handled via queue_rcu_work() _after_ closing the event
+	 * channel.
+	 */
+	rcu_read_lock();
 
 	do {
 		vcpu_info->evtchn_upcall_pending = 0;
@@ -1620,7 +1630,7 @@ static void __xen_evtchn_do_upcall(void)
 	} while (count != 1 || vcpu_info->evtchn_upcall_pending);
 
 out:
-	read_unlock(&evtchn_rwlock);
+	rcu_read_unlock();
 
 	/*
 	 * Increment irq_epoch only now to defer EOIs only for
diff --git a/drivers/xen/events/events_internal.h b/drivers/xen/events/events_internal.h
index cc37b711491c..0e0d9e531712 100644
--- a/drivers/xen/events/events_internal.h
+++ b/drivers/xen/events/events_internal.h
@@ -8,6 +8,8 @@
  */
 #ifndef __EVENTS_INTERNAL_H__
 #define __EVENTS_INTERNAL_H__
+#include <linux/rcupdate.h>
+#include <linux/workqueue.h>
 
 /* Interrupt types. */
 enum xen_irq_type {
@@ -33,6 +35,8 @@ enum xen_irq_type {
 struct irq_info {
 	struct list_head list;
 	struct list_head eoi_list;
+	struct rcu_head rcu;
+	struct work_struct work;
 	short refcnt;
 	short spurious_cnt;
 	short type;		/* type */
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index e70c039ac190..010a312af5de 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -349,10 +349,9 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 	/* there's now no turning back... the old userspace image is dead,
 	 * defunct, deceased, etc.
 	 */
+	SET_PERSONALITY(exec_params.hdr);
 	if (elf_check_fdpic(&exec_params.hdr))
-		set_personality(PER_LINUX_FDPIC);
-	else
-		set_personality(PER_LINUX);
+		current->personality |= PER_LINUX_FDPIC;
 	if (elf_read_implies_exec(&exec_params.hdr, executable_stack))
 		current->personality |= READ_IMPLIES_EXEC;
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 4edfd26594ed..8fe3b4b23e65 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2138,7 +2138,7 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	 * calculated f_bavail.
 	 */
 	if (!mixed && block_rsv->space_info->full &&
-	    total_free_meta - thresh < block_rsv->size)
+	    (total_free_meta < thresh || total_free_meta - thresh < block_rsv->size))
 		buf->f_bavail = 0;
 
 	buf->f_type = BTRFS_SUPER_MAGIC;
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 57c78a7a7425..a763216e1c15 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -321,17 +321,17 @@ static struct ext4_dir_entry_tail *get_dirent_tail(struct inode *inode,
 						   struct ext4_dir_entry *de)
 {
 	struct ext4_dir_entry_tail *t;
+	int blocksize = EXT4_BLOCK_SIZE(inode->i_sb);
 
 #ifdef PARANOID
 	struct ext4_dir_entry *d, *top;
 
 	d = de;
 	top = (struct ext4_dir_entry *)(((void *)de) +
-		(EXT4_BLOCK_SIZE(inode->i_sb) -
-		sizeof(struct ext4_dir_entry_tail)));
-	while (d < top && d->rec_len)
+		(blocksize - sizeof(struct ext4_dir_entry_tail)));
+	while (d < top && ext4_rec_len_from_disk(d->rec_len, blocksize))
 		d = (struct ext4_dir_entry *)(((void *)d) +
-		    le16_to_cpu(d->rec_len));
+		    ext4_rec_len_from_disk(d->rec_len, blocksize));
 
 	if (d != top)
 		return NULL;
@@ -342,7 +342,8 @@ static struct ext4_dir_entry_tail *get_dirent_tail(struct inode *inode,
 #endif
 
 	if (t->det_reserved_zero1 ||
-	    le16_to_cpu(t->det_rec_len) != sizeof(struct ext4_dir_entry_tail) ||
+	    (ext4_rec_len_from_disk(t->det_rec_len, blocksize) !=
+	     sizeof(struct ext4_dir_entry_tail)) ||
 	    t->det_reserved_zero2 ||
 	    t->det_reserved_ft != EXT4_FT_DIR_CSUM)
 		return NULL;
@@ -424,13 +425,14 @@ static struct dx_countlimit *get_dx_countlimit(struct inode *inode,
 	struct ext4_dir_entry *dp;
 	struct dx_root_info *root;
 	int count_offset;
+	int blocksize = EXT4_BLOCK_SIZE(inode->i_sb);
+	unsigned int rlen = ext4_rec_len_from_disk(dirent->rec_len, blocksize);
 
-	if (le16_to_cpu(dirent->rec_len) == EXT4_BLOCK_SIZE(inode->i_sb))
+	if (rlen == blocksize)
 		count_offset = 8;
-	else if (le16_to_cpu(dirent->rec_len) == 12) {
+	else if (rlen == 12) {
 		dp = (struct ext4_dir_entry *)(((void *)dirent) + 12);
-		if (le16_to_cpu(dp->rec_len) !=
-		    EXT4_BLOCK_SIZE(inode->i_sb) - 12)
+		if (ext4_rec_len_from_disk(dp->rec_len, blocksize) != blocksize - 12)
 			return NULL;
 		root = (struct dx_root_info *)(((void *)dp + 12));
 		if (root->reserved_zero ||
@@ -1243,6 +1245,7 @@ static int dx_make_map(struct inode *dir, struct buffer_head *bh,
 	unsigned int buflen = bh->b_size;
 	char *base = bh->b_data;
 	struct dx_hash_info h = *hinfo;
+	int blocksize = EXT4_BLOCK_SIZE(dir->i_sb);
 
 	if (ext4_has_metadata_csum(dir->i_sb))
 		buflen -= sizeof(struct ext4_dir_entry_tail);
@@ -1256,11 +1259,12 @@ static int dx_make_map(struct inode *dir, struct buffer_head *bh,
 			map_tail--;
 			map_tail->hash = h.hash;
 			map_tail->offs = ((char *) de - base)>>2;
-			map_tail->size = le16_to_cpu(de->rec_len);
+			map_tail->size = ext4_rec_len_from_disk(de->rec_len,
+								blocksize);
 			count++;
 			cond_resched();
 		}
-		de = ext4_next_entry(de, dir->i_sb->s_blocksize);
+		de = ext4_next_entry(de, blocksize);
 	}
 	return count;
 }
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 9d99e19d98bd..c87f3a7c5cdf 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1195,6 +1195,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 		case -EPFNOSUPPORT:
 		case -EPROTONOSUPPORT:
 		case -EOPNOTSUPP:
+		case -EINVAL:
 		case -ECONNREFUSED:
 		case -ECONNRESET:
 		case -EHOSTDOWN:
diff --git a/fs/nilfs2/gcinode.c b/fs/nilfs2/gcinode.c
index 1bbd0f50ce9d..d8c0a9d55230 100644
--- a/fs/nilfs2/gcinode.c
+++ b/fs/nilfs2/gcinode.c
@@ -82,10 +82,8 @@ int nilfs_gccache_submit_read_data(struct inode *inode, sector_t blkoff,
 		struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
 
 		err = nilfs_dat_translate(nilfs->ns_dat, vbn, &pbn);
-		if (unlikely(err)) { /* -EIO, -ENOMEM, -ENOENT */
-			brelse(bh);
+		if (unlikely(err)) /* -EIO, -ENOMEM, -ENOENT */
 			goto failed;
-		}
 	}
 
 	lock_buffer(bh);
@@ -111,6 +109,8 @@ int nilfs_gccache_submit_read_data(struct inode *inode, sector_t blkoff,
  failed:
 	unlock_page(bh->b_page);
 	put_page(bh->b_page);
+	if (unlikely(err))
+		brelse(bh);
 	return err;
 }
 
diff --git a/include/linux/if_team.h b/include/linux/if_team.h
index 30294603526f..31e1798aa6b0 100644
--- a/include/linux/if_team.h
+++ b/include/linux/if_team.h
@@ -178,6 +178,8 @@ struct team {
 	struct net_device *dev; /* associated netdevice */
 	struct team_pcpu_stats __percpu *pcpu_stats;
 
+	const struct header_ops *header_ops_cache;
+
 	struct mutex lock; /* used for overall locking, e.g. port lists write */
 
 	/*
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 0e9f8fd37eb9..484703fb8b16 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -279,6 +279,10 @@ enum {
 	ATA_HOST_PARALLEL_SCAN	= (1 << 2),	/* Ports on this host can be scanned in parallel */
 	ATA_HOST_IGNORE_ATA	= (1 << 3),	/* Ignore ATA devices on this host. */
 
+	ATA_HOST_NO_PART	= (1 << 4), /* Host does not support partial */
+	ATA_HOST_NO_SSC		= (1 << 5), /* Host does not support slumber */
+	ATA_HOST_NO_DEVSLP	= (1 << 6), /* Host does not support devslp */
+
 	/* bits 24:31 of host->flags are reserved for LLD specific flags */
 
 	/* various lengths of time */
@@ -312,7 +316,7 @@ enum {
 	 * advised to wait only for the following duration before
 	 * doing SRST.
 	 */
-	ATA_TMOUT_PMP_SRST_WAIT	= 5000,
+	ATA_TMOUT_PMP_SRST_WAIT	= 10000,
 
 	/* When the LPM policy is set to ATA_LPM_MAX_POWER, there might
 	 * be a spurious PHY event, so ignore the first PHY event that
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1949d7bbe145..f0d4ff2db2ef 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1686,6 +1686,8 @@ int ring_buffer_resize(struct ring_buffer *buffer, unsigned long size,
 				err = -ENOMEM;
 				goto out_err;
 			}
+
+			cond_resched();
 		}
 
 		get_online_cpus();
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 0478f8cddd96..f4b98f74842a 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2311,10 +2311,7 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	ifm = nlmsg_data(nlh);
 	if (ifm->ifi_index > 0)
 		dev = __dev_get_by_index(net, ifm->ifi_index);
-	else if (ifm->ifi_index < 0) {
-		NL_SET_ERR_MSG(extack, "ifindex can't be negative");
-		return -EINVAL;
-	} else if (tb[IFLA_IFNAME])
+	else if (tb[IFLA_IFNAME])
 		dev = __dev_get_by_name(net, ifname);
 	else
 		goto errout;
@@ -2550,9 +2547,12 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		ifname[0] = '\0';
 
 	ifm = nlmsg_data(nlh);
-	if (ifm->ifi_index > 0)
+	if (ifm->ifi_index > 0) {
 		dev = __dev_get_by_index(net, ifm->ifi_index);
-	else {
+	} else if (ifm->ifi_index < 0) {
+		NL_SET_ERR_MSG(extack, "ifindex can't be negative");
+		return -EINVAL;
+	} else {
 		if (ifname[0])
 			dev = __dev_get_by_name(net, ifname);
 		else
diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index b2fc9ef7708f..892fbd1f650d 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -247,13 +247,8 @@ static void dccp_v4_err(struct sk_buff *skb, u32 info)
 	int err;
 	struct net *net = dev_net(skb->dev);
 
-	/* For the first __dccp_basic_hdr_len() check, we only need dh->dccph_x,
-	 * which is in byte 7 of the dccp header.
-	 * Our caller (icmp_socket_deliver()) already pulled 8 bytes for us.
-	 *
-	 * Later on, we want to access the sequence number fields, which are
-	 * beyond 8 bytes, so we have to pskb_may_pull() ourselves.
-	 */
+	if (!pskb_may_pull(skb, offset + sizeof(*dh)))
+		return;
 	dh = (struct dccp_hdr *)(skb->data + offset);
 	if (!pskb_may_pull(skb, offset + __dccp_basic_hdr_len(dh)))
 		return;
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index f8d8caa967b1..9b8c6cf0e5ee 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -80,13 +80,8 @@ static void dccp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	__u64 seq;
 	struct net *net = dev_net(skb->dev);
 
-	/* For the first __dccp_basic_hdr_len() check, we only need dh->dccph_x,
-	 * which is in byte 7 of the dccp header.
-	 * Our caller (icmpv6_notify()) already pulled 8 bytes for us.
-	 *
-	 * Later on, we want to access the sequence number fields, which are
-	 * beyond 8 bytes, so we have to pskb_may_pull() ourselves.
-	 */
+	if (!pskb_may_pull(skb, offset + sizeof(*dh)))
+		return;
 	dh = (struct dccp_hdr *)(skb->data + offset);
 	if (!pskb_may_pull(skb, offset + __dccp_basic_hdr_len(dh)))
 		return;
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 52c4098e1deb..4a6f4ef369d0 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1221,6 +1221,7 @@ static struct dst_entry *ipv4_dst_check(struct dst_entry *dst, u32 cookie)
 
 static void ipv4_send_dest_unreach(struct sk_buff *skb)
 {
+	struct net_device *dev;
 	struct ip_options opt;
 	int res;
 
@@ -1238,7 +1239,8 @@ static void ipv4_send_dest_unreach(struct sk_buff *skb)
 		opt.optlen = ip_hdr(skb)->ihl * 4 - sizeof(struct iphdr);
 
 		rcu_read_lock();
-		res = __ip_options_compile(dev_net(skb->dev), &opt, skb, NULL);
+		dev = skb->dev ? skb->dev : skb_rtable(skb)->dst.dev;
+		res = __ip_options_compile(dev_net(dev), &opt, skb, NULL);
 		rcu_read_unlock();
 
 		if (res)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 444ad1728927..491c16d8e9dd 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -166,6 +166,19 @@ static void tcp_measure_rcv_mss(struct sock *sk, const struct sk_buff *skb)
 		if (unlikely(len > icsk->icsk_ack.rcv_mss +
 				   MAX_TCP_OPTION_SPACE))
 			tcp_gro_dev_warn(sk, skb, len);
+		/* If the skb has a len of exactly 1*MSS and has the PSH bit
+		 * set then it is likely the end of an application write. So
+		 * more data may not be arriving soon, and yet the data sender
+		 * may be waiting for an ACK if cwnd-bound or using TX zero
+		 * copy. So we set ICSK_ACK_PUSHED here so that
+		 * tcp_cleanup_rbuf() will send an ACK immediately if the app
+		 * reads all of the data and is not ping-pong. If len > MSS
+		 * then this logic does not matter (and does not hurt) because
+		 * tcp_cleanup_rbuf() will always ACK immediately if the app
+		 * reads data and there is more than an MSS of unACKed data.
+		 */
+		if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_PSH)
+			icsk->icsk_ack.pending |= ICSK_ACK_PUSHED;
 	} else {
 		/* Otherwise, we make more careful check taking into account,
 		 * that SACKs block is variable.
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index a241ead3dd92..d797708a1a5e 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -532,7 +532,6 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	 */
 	if (len > INT_MAX - transhdrlen)
 		return -EMSGSIZE;
-	ulen = len + transhdrlen;
 
 	/* Mirror BSD error message compatibility */
 	if (msg->msg_flags & MSG_OOB)
@@ -659,6 +658,7 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 back_from_confirm:
 	lock_sock(sk);
+	ulen = len + skb_queue_empty(&sk->sk_write_queue) ? transhdrlen : 0;
 	err = ip6_append_data(sk, ip_generic_getfrag, msg,
 			      ulen, transhdrlen, &ipc6,
 			      &fl6, (struct rt6_info *)dst,
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 3f88b75488b0..3a43abe4d9c4 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1020,6 +1020,8 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 		if (parent == NULL)
 			return -ENOENT;
 	}
+	if (!(parent->cl_flags & HFSC_FSC) && parent != &q->root)
+		return -EINVAL;
 
 	if (classid == 0 || TC_H_MAJ(classid ^ sch->handle) != 0)
 		return -EINVAL;
diff --git a/net/sctp/associola.c b/net/sctp/associola.c
index 0a5764016721..629f56cbe22c 100644
--- a/net/sctp/associola.c
+++ b/net/sctp/associola.c
@@ -1204,8 +1204,7 @@ int sctp_assoc_update(struct sctp_association *asoc,
 		/* Add any peer addresses from the new association. */
 		list_for_each_entry(trans, &new->peer.transport_addr_list,
 				    transports)
-			if (!sctp_assoc_lookup_paddr(asoc, &trans->ipaddr) &&
-			    !sctp_assoc_add_peer(asoc, &trans->ipaddr,
+			if (!sctp_assoc_add_peer(asoc, &trans->ipaddr,
 						 GFP_ATOMIC, trans->state))
 				return -ENOMEM;
 
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index e5c3c37108e4..fe26395690f3 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -2479,6 +2479,7 @@ static int sctp_apply_peer_addr_params(struct sctp_paddrparams *params,
 			if (trans) {
 				trans->hbinterval =
 				    msecs_to_jiffies(params->spp_hbinterval);
+				sctp_transport_reset_hb_timer(trans);
 			} else if (asoc) {
 				asoc->hbinterval =
 				    msecs_to_jiffies(params->spp_hbinterval);
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 55b4c0dc2b93..ac2b11ef37c4 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1331,7 +1331,7 @@ void handle_moddevtable(struct module *mod, struct elf_info *info,
 	/* First handle the "special" cases */
 	if (sym_is(name, namelen, "usb"))
 		do_usb_table(symval, sym->st_size, mod);
-	if (sym_is(name, namelen, "of"))
+	else if (sym_is(name, namelen, "of"))
 		do_of_table(symval, sym->st_size, mod);
 	else if (sym_is(name, namelen, "pnp"))
 		do_pnp_device_entry(symval, sym->st_size, mod);
diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index d6e1c02ddcfe..543e58771b5e 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -272,14 +272,14 @@ clean:
 	$(MAKE) -C bench O=$(OUTPUT) clean
 
 
-install-lib:
+install-lib: libcpupower
 	$(INSTALL) -d $(DESTDIR)${libdir}
 	$(CP) $(OUTPUT)libcpupower.so* $(DESTDIR)${libdir}/
 	$(INSTALL) -d $(DESTDIR)${includedir}
 	$(INSTALL_DATA) lib/cpufreq.h $(DESTDIR)${includedir}/cpufreq.h
 	$(INSTALL_DATA) lib/cpuidle.h $(DESTDIR)${includedir}/cpuidle.h
 
-install-tools:
+install-tools: $(OUTPUT)cpupower
 	$(INSTALL) -d $(DESTDIR)${bindir}
 	$(INSTALL_PROGRAM) $(OUTPUT)cpupower $(DESTDIR)${bindir}
 
@@ -293,14 +293,14 @@ install-man:
 	$(INSTALL_DATA) -D man/cpupower-info.1 $(DESTDIR)${mandir}/man1/cpupower-info.1
 	$(INSTALL_DATA) -D man/cpupower-monitor.1 $(DESTDIR)${mandir}/man1/cpupower-monitor.1
 
-install-gmo:
+install-gmo: create-gmo
 	$(INSTALL) -d $(DESTDIR)${localedir}
 	for HLANG in $(LANGUAGES); do \
 		echo '$(INSTALL_DATA) -D $(OUTPUT)po/$$HLANG.gmo $(DESTDIR)${localedir}/$$HLANG/LC_MESSAGES/cpupower.mo'; \
 		$(INSTALL_DATA) -D $(OUTPUT)po/$$HLANG.gmo $(DESTDIR)${localedir}/$$HLANG/LC_MESSAGES/cpupower.mo; \
 	done;
 
-install-bench:
+install-bench: compile-bench
 	@#DESTDIR must be set from outside to survive
 	@sbindir=$(sbindir) bindir=$(bindir) docdir=$(docdir) confdir=$(confdir) $(MAKE) -C bench O=$(OUTPUT) install
 
diff --git a/tools/power/cpupower/bench/Makefile b/tools/power/cpupower/bench/Makefile
index f68b4bc55273..d9d9923af85c 100644
--- a/tools/power/cpupower/bench/Makefile
+++ b/tools/power/cpupower/bench/Makefile
@@ -27,7 +27,7 @@ $(OUTPUT)cpufreq-bench: $(OBJS)
 
 all: $(OUTPUT)cpufreq-bench
 
-install:
+install: $(OUTPUT)cpufreq-bench
 	mkdir -p $(DESTDIR)/$(sbindir)
 	mkdir -p $(DESTDIR)/$(bindir)
 	mkdir -p $(DESTDIR)/$(docdir)
diff --git a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
index d7f48b55df51..ee11b42014c8 100644
--- a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
+++ b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
@@ -43,7 +43,7 @@ instance_read() {
 
 instance_set() {
         while :; do
-                echo 1 > foo/events/sched/sched_switch
+                echo 1 > foo/events/sched/sched_switch/enable
         done 2> /dev/null
 }
 
