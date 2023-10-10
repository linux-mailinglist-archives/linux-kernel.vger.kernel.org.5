Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9CA7C40A3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbjJJUEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjJJUEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:04:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A13F4;
        Tue, 10 Oct 2023 13:03:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A3EC433C8;
        Tue, 10 Oct 2023 20:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696968236;
        bh=pDx3f9r7r4hDWuvFg7bL0zL9tbMze2o/jBHH3sQcqDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2ic4Vr3Cb7bAm3vxPn6tWMWa/ZZNuqrhbyq2tzko54pNjiYJYeWOYW8jlyLTcOenf
         /P4h3MkKV/uw+EDviOAp63ZG08ZxQxCiZA911yxTVNZQFge7J0Wnw5Mlp4Es+gy9qa
         Zg4trcobtWki0hStLwLC4Oweqa4Dw+AoxtAF7KEQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.19.296
Date:   Tue, 10 Oct 2023 22:03:46 +0200
Message-ID: <2023101045-silly-designed-cfa6@gregkh>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <2023101045-knickers-preshow-9c49@gregkh>
References: <2023101045-knickers-preshow-9c49@gregkh>
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
index 6eb08388fa15..002d81755142 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 295
+SUBLEVEL = 296
 EXTRAVERSION =
 NAME = "People's Front"
 
diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
index 67d77eee9433..459720f5f558 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -647,12 +647,12 @@
 /* Configure pwm clock source for timers 8 & 9 */
 &timer8 {
 	assigned-clocks = <&abe_clkctrl OMAP4_TIMER8_CLKCTRL 24>;
-	assigned-clock-parents = <&sys_clkin_ck>;
+	assigned-clock-parents = <&sys_32k_ck>;
 };
 
 &timer9 {
 	assigned-clocks = <&l4_per_clkctrl OMAP4_TIMER9_CLKCTRL 24>;
-	assigned-clock-parents = <&sys_clkin_ck>;
+	assigned-clock-parents = <&sys_32k_ck>;
 };
 
 /*
diff --git a/arch/mips/alchemy/devboards/db1000.c b/arch/mips/alchemy/devboards/db1000.c
index 6fe0f0f95ed7..548bd4db0f97 100644
--- a/arch/mips/alchemy/devboards/db1000.c
+++ b/arch/mips/alchemy/devboards/db1000.c
@@ -173,6 +173,7 @@ static struct platform_device db1x00_audio_dev = {
 
 /******************************************************************************/
 
+#ifdef CONFIG_MMC_AU1X
 static irqreturn_t db1100_mmc_cd(int irq, void *ptr)
 {
 	mmc_detect_change(ptr, msecs_to_jiffies(500));
@@ -380,6 +381,7 @@ static struct platform_device db1100_mmc1_dev = {
 	.num_resources	= ARRAY_SIZE(au1100_mmc1_res),
 	.resource	= au1100_mmc1_res,
 };
+#endif /* CONFIG_MMC_AU1X */
 
 /******************************************************************************/
 
@@ -497,9 +499,11 @@ static struct platform_device *db1000_devs[] = {
 
 static struct platform_device *db1100_devs[] = {
 	&au1100_lcd_device,
+#ifdef CONFIG_MMC_AU1X
 	&db1100_mmc0_dev,
 	&db1100_mmc1_dev,
 	&db1000_irda_dev,
+#endif
 };
 
 int __init db1000_dev_setup(void)
diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
index ae81e05fcb2c..48840e48e79a 100644
--- a/arch/mips/alchemy/devboards/db1200.c
+++ b/arch/mips/alchemy/devboards/db1200.c
@@ -341,6 +341,7 @@ static struct platform_device db1200_ide_dev = {
 
 /**********************************************************************/
 
+#ifdef CONFIG_MMC_AU1X
 /* SD carddetects:  they're supposed to be edge-triggered, but ack
  * doesn't seem to work (CPLD Rev 2).  Instead, the screaming one
  * is disabled and its counterpart enabled.  The 200ms timeout is
@@ -601,6 +602,7 @@ static struct platform_device pb1200_mmc1_dev = {
 	.num_resources	= ARRAY_SIZE(au1200_mmc1_res),
 	.resource	= au1200_mmc1_res,
 };
+#endif /* CONFIG_MMC_AU1X */
 
 /**********************************************************************/
 
@@ -768,7 +770,9 @@ static struct platform_device db1200_audiodma_dev = {
 static struct platform_device *db1200_devs[] __initdata = {
 	NULL,		/* PSC0, selected by S6.8 */
 	&db1200_ide_dev,
+#ifdef CONFIG_MMC_AU1X
 	&db1200_mmc0_dev,
+#endif
 	&au1200_lcd_dev,
 	&db1200_eth_dev,
 	&db1200_nand_dev,
@@ -779,7 +783,9 @@ static struct platform_device *db1200_devs[] __initdata = {
 };
 
 static struct platform_device *pb1200_devs[] __initdata = {
+#ifdef CONFIG_MMC_AU1X
 	&pb1200_mmc1_dev,
+#endif
 };
 
 /* Some peripheral base addresses differ on the PB1200 */
diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
index 0c12fbc07117..664a5a783d2c 100644
--- a/arch/mips/alchemy/devboards/db1300.c
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -448,6 +448,7 @@ static struct platform_device db1300_ide_dev = {
 
 /**********************************************************************/
 
+#ifdef CONFIG_MMC_AU1X
 static irqreturn_t db1300_mmc_cd(int irq, void *ptr)
 {
 	disable_irq_nosync(irq);
@@ -626,6 +627,7 @@ static struct platform_device db1300_sd0_dev = {
 	.resource	= au1300_sd0_res,
 	.num_resources	= ARRAY_SIZE(au1300_sd0_res),
 };
+#endif /* CONFIG_MMC_AU1X */
 
 /**********************************************************************/
 
@@ -756,8 +758,10 @@ static struct platform_device *db1300_dev[] __initdata = {
 	&db1300_5waysw_dev,
 	&db1300_nand_dev,
 	&db1300_ide_dev,
+#ifdef CONFIG_MMC_AU1X
 	&db1300_sd0_dev,
 	&db1300_sd1_dev,
+#endif
 	&db1300_lcd_dev,
 	&db1300_ac97_dev,
 	&db1300_i2s_dev,
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
diff --git a/arch/parisc/kernel/drivers.c b/arch/parisc/kernel/drivers.c
index 01a2ed59d2f2..94037c8512f7 100644
--- a/arch/parisc/kernel/drivers.c
+++ b/arch/parisc/kernel/drivers.c
@@ -903,9 +903,9 @@ static __init void qemu_header(void)
 	pr_info("#define PARISC_MODEL \"%s\"\n\n",
 			boot_cpu_data.pdc.sys_model_name);
 
+	#define p ((unsigned long *)&boot_cpu_data.pdc.model)
 	pr_info("#define PARISC_PDC_MODEL 0x%lx, 0x%lx, 0x%lx, "
 		"0x%lx, 0x%lx, 0x%lx, 0x%lx, 0x%lx, 0x%lx\n\n",
-	#define p ((unsigned long *)&boot_cpu_data.pdc.model)
 		p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8]);
 	#undef p
 
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
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 13fb983b3413..ab3ea47ecce3 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -694,7 +694,7 @@ static void ahci_pci_init_controller(struct ata_host *host)
 
 		/* clear port IRQ */
 		tmp = readl(port_mmio + PORT_IRQ_STAT);
-		VPRINTK("PORT_IRQ_STAT 0x%x\n", tmp);
+		dev_dbg(&pdev->dev, "PORT_IRQ_STAT 0x%x\n", tmp);
 		if (tmp)
 			writel(tmp, port_mmio + PORT_IRQ_STAT);
 	}
@@ -1504,7 +1504,6 @@ static irqreturn_t ahci_thunderx_irq_handler(int irq, void *dev_instance)
 	u32 irq_stat, irq_masked;
 	unsigned int handled = 1;
 
-	VPRINTK("ENTER\n");
 	hpriv = host->private_data;
 	mmio = hpriv->mmio;
 	irq_stat = readl(mmio + HOST_IRQ_STAT);
@@ -1521,7 +1520,6 @@ static irqreturn_t ahci_thunderx_irq_handler(int irq, void *dev_instance)
 		irq_stat = readl(mmio + HOST_IRQ_STAT);
 		spin_unlock(&host->lock);
 	} while (irq_stat);
-	VPRINTK("EXIT\n");
 
 	return IRQ_RETVAL(handled);
 }
@@ -1866,6 +1864,15 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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
index 7e157e1bf65e..04ad6a225014 100644
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
index f1153e7ba3b3..b93fad6939da 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1210,6 +1210,26 @@ static ssize_t ahci_activity_show(struct ata_device *dev, char *buf)
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
@@ -1224,18 +1244,7 @@ static void ahci_port_init(struct device *dev, struct ata_port *ap,
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
@@ -1262,10 +1271,10 @@ void ahci_init_controller(struct ata_host *host)
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
 
@@ -1565,6 +1574,8 @@ int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
 	tf.command = ATA_BUSY;
 	ata_tf_to_fis(&tf, 0, 0, d2h_fis);
 
+	ahci_port_clear_pending_irq(ap);
+
 	rc = sata_link_hardreset(link, timing, deadline, online,
 				 ahci_check_ready);
 
@@ -1916,8 +1927,6 @@ static irqreturn_t ahci_multi_irqs_intr_hard(int irq, void *dev_instance)
 	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 status;
 
-	VPRINTK("ENTER\n");
-
 	status = readl(port_mmio + PORT_IRQ_STAT);
 	writel(status, port_mmio + PORT_IRQ_STAT);
 
@@ -1925,8 +1934,6 @@ static irqreturn_t ahci_multi_irqs_intr_hard(int irq, void *dev_instance)
 	ahci_handle_port_interrupt(ap, port_mmio, status);
 	spin_unlock(ap->lock);
 
-	VPRINTK("EXIT\n");
-
 	return IRQ_HANDLED;
 }
 
@@ -1943,9 +1950,7 @@ u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked)
 		ap = host->ports[i];
 		if (ap) {
 			ahci_port_intr(ap);
-			VPRINTK("port %u\n", i);
 		} else {
-			VPRINTK("port %u (no irq)\n", i);
 			if (ata_ratelimit())
 				dev_warn(host->dev,
 					 "interrupt on disabled port %u\n", i);
@@ -1966,8 +1971,6 @@ static irqreturn_t ahci_single_level_irq_intr(int irq, void *dev_instance)
 	void __iomem *mmio;
 	u32 irq_stat, irq_masked;
 
-	VPRINTK("ENTER\n");
-
 	hpriv = host->private_data;
 	mmio = hpriv->mmio;
 
@@ -1995,8 +1998,6 @@ static irqreturn_t ahci_single_level_irq_intr(int irq, void *dev_instance)
 
 	spin_unlock(&host->lock);
 
-	VPRINTK("EXIT\n");
-
 	return IRQ_RETVAL(rc);
 }
 
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4a7da8f744e0..2b9f6769f80d 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3997,10 +3997,23 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 	case ATA_LPM_MED_POWER_WITH_DIPM:
 	case ATA_LPM_MIN_POWER_WITH_PARTIAL:
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
@@ -5756,17 +5769,19 @@ static void ata_port_request_pm(struct ata_port *ap, pm_message_t mesg,
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
@@ -5778,10 +5793,8 @@ static void ata_port_request_pm(struct ata_port *ap, pm_message_t mesg,
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
-	if (!async) {
+	if (!async)
 		ata_port_wait_eh(ap);
-		WARN_ON(ap->pflags & ATA_PFLAG_PM_PENDING);
-	}
 }
 
 /*
@@ -5947,7 +5960,7 @@ void ata_host_resume(struct ata_host *host)
 #endif
 
 const struct device_type ata_port_type = {
-	.name = "ata_port",
+	.name = ATA_PORT_TYPE_NAME,
 #ifdef CONFIG_PM
 	.pm = &ata_port_pm_ops,
 #endif
@@ -6750,11 +6763,30 @@ static void ata_port_detach(struct ata_port *ap)
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
index fcc3d7985762..73a4dd37d04a 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2922,18 +2922,11 @@ int ata_eh_reset(struct ata_link *link, int classify,
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
index 2295b74714e1..dc5223981270 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4561,7 +4561,7 @@ void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
 		break;
 
 	case MAINTENANCE_IN:
-		if (scsicmd[1] == MI_REPORT_SUPPORTED_OPERATION_CODES)
+		if ((scsicmd[1] & 0x1f) == MI_REPORT_SUPPORTED_OPERATION_CODES)
 			ata_scsi_rbuf_fill(&args, ata_scsiop_maint_in);
 		else
 			ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index f04f4f977400..5eae76d8b655 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -266,6 +266,10 @@ void ata_tport_delete(struct ata_port *ap)
 	put_device(dev);
 }
 
+static const struct device_type ata_port_sas_type = {
+	.name = ATA_PORT_TYPE_NAME,
+};
+
 /** ata_tport_add - initialize a transport ATA port structure
  *
  * @parent:	parent device
@@ -283,7 +287,10 @@ int ata_tport_add(struct device *parent,
 	struct device *dev = &ap->tdev;
 
 	device_initialize(dev);
-	dev->type = &ata_port_type;
+	if (ap->flags & ATA_FLAG_SAS_HOST)
+		dev->type = &ata_port_sas_type;
+	else
+		dev->type = &ata_port_type;
 
 	dev->parent = parent;
 	ata_host_get(ap->host);
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index f953cb4bb1ba..b568d6b9350a 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -46,6 +46,8 @@ enum {
 	ATA_DNXFER_QUIET	= (1 << 31),
 };
 
+#define ATA_PORT_TYPE_NAME	"ata_port"
+
 extern atomic_t ata_print_id;
 extern int atapi_passthru16;
 extern int libata_fua;
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index d89f618231cb..e7cb0c6ade81 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -44,7 +44,7 @@ static ssize_t cpu_capacity_show(struct device *dev,
 {
 	struct cpu *cpu = container_of(dev, struct cpu, dev);
 
-	return sysfs_emit(buf, "%lu\n", topology_get_cpu_scale(NULL, cpu->dev.id));
+	return sprintf(buf, "%lu\n", topology_get_cpu_scale(NULL, cpu->dev.id));
 }
 
 static ssize_t cpu_capacity_store(struct device *dev,
diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 51eb403f89de..ce015ce2977c 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -372,7 +372,7 @@ static ssize_t size_show(struct device *dev,
 {
 	struct cacheinfo *this_leaf = dev_get_drvdata(dev);
 
-	return sysfs_emit(buf, "%uK\n", this_leaf->size >> 10);
+	return sprintf(buf, "%uK\n", this_leaf->size >> 10);
 }
 
 static ssize_t shared_cpumap_show_func(struct device *dev, bool list, char *buf)
@@ -402,11 +402,11 @@ static ssize_t type_show(struct device *dev,
 
 	switch (this_leaf->type) {
 	case CACHE_TYPE_DATA:
-		return sysfs_emit(buf, "Data\n");
+		return sprintf(buf, "Data\n");
 	case CACHE_TYPE_INST:
-		return sysfs_emit(buf, "Instruction\n");
+		return sprintf(buf, "Instruction\n");
 	case CACHE_TYPE_UNIFIED:
-		return sysfs_emit(buf, "Unified\n");
+		return sprintf(buf, "Unified\n");
 	default:
 		return -EINVAL;
 	}
@@ -420,11 +420,11 @@ static ssize_t allocation_policy_show(struct device *dev,
 	int n = 0;
 
 	if ((ci_attr & CACHE_READ_ALLOCATE) && (ci_attr & CACHE_WRITE_ALLOCATE))
-		n = sysfs_emit(buf, "ReadWriteAllocate\n");
+		n = sprintf(buf, "ReadWriteAllocate\n");
 	else if (ci_attr & CACHE_READ_ALLOCATE)
-		n = sysfs_emit(buf, "ReadAllocate\n");
+		n = sprintf(buf, "ReadAllocate\n");
 	else if (ci_attr & CACHE_WRITE_ALLOCATE)
-		n = sysfs_emit(buf, "WriteAllocate\n");
+		n = sprintf(buf, "WriteAllocate\n");
 	return n;
 }
 
@@ -436,9 +436,9 @@ static ssize_t write_policy_show(struct device *dev,
 	int n = 0;
 
 	if (ci_attr & CACHE_WRITE_THROUGH)
-		n = sysfs_emit(buf, "WriteThrough\n");
+		n = sprintf(buf, "WriteThrough\n");
 	else if (ci_attr & CACHE_WRITE_BACK)
-		n = sysfs_emit(buf, "WriteBack\n");
+		n = sprintf(buf, "WriteBack\n");
 	return n;
 }
 
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 0332800dffd8..6e380ad9d08a 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -994,7 +994,7 @@ ssize_t device_show_ulong(struct device *dev,
 			  char *buf)
 {
 	struct dev_ext_attribute *ea = to_ext_attr(attr);
-	return sysfs_emit(buf, "%lx\n", *(unsigned long *)(ea->var));
+	return snprintf(buf, PAGE_SIZE, "%lx\n", *(unsigned long *)(ea->var));
 }
 EXPORT_SYMBOL_GPL(device_show_ulong);
 
@@ -1019,7 +1019,7 @@ ssize_t device_show_int(struct device *dev,
 {
 	struct dev_ext_attribute *ea = to_ext_attr(attr);
 
-	return sysfs_emit(buf, "%d\n", *(int *)(ea->var));
+	return snprintf(buf, PAGE_SIZE, "%d\n", *(int *)(ea->var));
 }
 EXPORT_SYMBOL_GPL(device_show_int);
 
@@ -1040,7 +1040,7 @@ ssize_t device_show_bool(struct device *dev, struct device_attribute *attr,
 {
 	struct dev_ext_attribute *ea = to_ext_attr(attr);
 
-	return sysfs_emit(buf, "%d\n", *(bool *)(ea->var));
+	return snprintf(buf, PAGE_SIZE, "%d\n", *(bool *)(ea->var));
 }
 EXPORT_SYMBOL_GPL(device_show_bool);
 
@@ -1273,7 +1273,7 @@ static ssize_t online_show(struct device *dev, struct device_attribute *attr,
 	device_lock(dev);
 	val = !dev->offline;
 	device_unlock(dev);
-	return sysfs_emit(buf, "%u\n", val);
+	return sprintf(buf, "%u\n", val);
 }
 
 static ssize_t online_store(struct device *dev, struct device_attribute *attr,
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 607fc189e57c..b1bb6f43f896 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -156,7 +156,7 @@ static ssize_t show_crash_notes(struct device *dev, struct device_attribute *att
 	 * operation should be safe. No locking required.
 	 */
 	addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpunum));
-	rc = sysfs_emit(buf, "%Lx\n", addr);
+	rc = sprintf(buf, "%Lx\n", addr);
 	return rc;
 }
 static DEVICE_ATTR(crash_notes, 0400, show_crash_notes, NULL);
@@ -167,7 +167,7 @@ static ssize_t show_crash_notes_size(struct device *dev,
 {
 	ssize_t rc;
 
-	rc = sysfs_emit(buf, "%zu\n", sizeof(note_buf_t));
+	rc = sprintf(buf, "%zu\n", sizeof(note_buf_t));
 	return rc;
 }
 static DEVICE_ATTR(crash_notes_size, 0400, show_crash_notes_size, NULL);
@@ -264,7 +264,7 @@ static ssize_t print_cpus_offline(struct device *dev,
 						      nr_cpu_ids, total_cpus-1);
 	}
 
-	n += sysfs_emit(&buf[n], "\n");
+	n += snprintf(&buf[n], len - n, "\n");
 	return n;
 }
 static DEVICE_ATTR(offline, 0444, print_cpus_offline, NULL);
@@ -272,7 +272,7 @@ static DEVICE_ATTR(offline, 0444, print_cpus_offline, NULL);
 static ssize_t print_cpus_isolated(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	int n = 0;
+	int n = 0, len = PAGE_SIZE-2;
 	cpumask_var_t isolated;
 
 	if (!alloc_cpumask_var(&isolated, GFP_KERNEL))
@@ -280,7 +280,7 @@ static ssize_t print_cpus_isolated(struct device *dev,
 
 	cpumask_andnot(isolated, cpu_possible_mask,
 		       housekeeping_cpumask(HK_FLAG_DOMAIN));
-	n = sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(isolated));
+	n = scnprintf(buf, len, "%*pbl\n", cpumask_pr_args(isolated));
 
 	free_cpumask_var(isolated);
 
@@ -292,9 +292,9 @@ static DEVICE_ATTR(isolated, 0444, print_cpus_isolated, NULL);
 static ssize_t print_cpus_nohz_full(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	int n = 0;
+	int n = 0, len = PAGE_SIZE-2;
 
-	n = sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(tick_nohz_full_mask));
+	n = scnprintf(buf, len, "%*pbl\n", cpumask_pr_args(tick_nohz_full_mask));
 
 	return n;
 }
@@ -328,7 +328,7 @@ static ssize_t print_cpu_modalias(struct device *dev,
 	ssize_t n;
 	u32 i;
 
-	n = sysfs_emit(buf, "cpu:type:" CPU_FEATURE_TYPEFMT ":feature:",
+	n = sprintf(buf, "cpu:type:" CPU_FEATURE_TYPEFMT ":feature:",
 		    CPU_FEATURE_TYPEVAL);
 
 	for (i = 0; i < MAX_CPU_FEATURES; i++)
@@ -520,56 +520,56 @@ static void __init cpu_dev_register_generic(void)
 ssize_t __weak cpu_show_meltdown(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "Not affected\n");
+	return sprintf(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_spectre_v1(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "Not affected\n");
+	return sprintf(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_spectre_v2(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "Not affected\n");
+	return sprintf(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_spec_store_bypass(struct device *dev,
 					  struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "Not affected\n");
+	return sprintf(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_l1tf(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "Not affected\n");
+	return sprintf(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_mds(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "Not affected\n");
+	return sprintf(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_tsx_async_abort(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	return sysfs_emit(buf, "Not affected\n");
+	return sprintf(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_itlb_multihit(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "Not affected\n");
+	return sprintf(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_srbds(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "Not affected\n");
+	return sprintf(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_mmio_stale_data(struct device *dev,
diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 2116926cc1d5..821e27bda4ca 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -215,7 +215,7 @@ static ssize_t firmware_loading_show(struct device *dev,
 		loading = fw_sysfs_loading(fw_sysfs->fw_priv);
 	mutex_unlock(&fw_lock);
 
-	return sysfs_emit(buf, "%d\n", loading);
+	return sprintf(buf, "%d\n", loading);
 }
 
 /* one pages buffer should be mapped/unmapped only once */
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 5dbe00a5c7c1..e270abc86d46 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -121,7 +121,7 @@ static ssize_t show_mem_start_phys_index(struct device *dev,
 	unsigned long phys_index;
 
 	phys_index = mem->start_section_nr / sections_per_block;
-	return sysfs_emit(buf, "%08lx\n", phys_index);
+	return sprintf(buf, "%08lx\n", phys_index);
 }
 
 /*
@@ -145,7 +145,7 @@ static ssize_t show_mem_removable(struct device *dev,
 	}
 
 out:
-	return sysfs_emit(buf, "%d\n", ret);
+	return sprintf(buf, "%d\n", ret);
 }
 
 /*
@@ -163,17 +163,17 @@ static ssize_t show_mem_state(struct device *dev,
 	 */
 	switch (mem->state) {
 	case MEM_ONLINE:
-		len = sysfs_emit(buf, "online\n");
+		len = sprintf(buf, "online\n");
 		break;
 	case MEM_OFFLINE:
-		len = sysfs_emit(buf, "offline\n");
+		len = sprintf(buf, "offline\n");
 		break;
 	case MEM_GOING_OFFLINE:
-		len = sysfs_emit(buf, "going-offline\n");
+		len = sprintf(buf, "going-offline\n");
 		break;
 	default:
-		len = sysfs_emit(buf, "ERROR-UNKNOWN-%ld\n",
-				 mem->state);
+		len = sprintf(buf, "ERROR-UNKNOWN-%ld\n",
+				mem->state);
 		WARN_ON(1);
 		break;
 	}
@@ -384,7 +384,7 @@ static ssize_t show_phys_device(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct memory_block *mem = to_memory_block(dev);
-	return sysfs_emit(buf, "%d\n", mem->phys_device);
+	return sprintf(buf, "%d\n", mem->phys_device);
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
@@ -422,7 +422,7 @@ static ssize_t show_valid_zones(struct device *dev,
 		 */
 		if (!test_pages_in_a_zone(start_pfn, start_pfn + nr_pages,
 					  &valid_start_pfn, &valid_end_pfn))
-			return sysfs_emit(buf, "none\n");
+			return sprintf(buf, "none\n");
 		start_pfn = valid_start_pfn;
 		strcat(buf, page_zone(pfn_to_page(start_pfn))->name);
 		goto out;
@@ -456,7 +456,7 @@ static ssize_t
 print_block_size(struct device *dev, struct device_attribute *attr,
 		 char *buf)
 {
-	return sysfs_emit(buf, "%lx\n", get_memory_block_size());
+	return sprintf(buf, "%lx\n", get_memory_block_size());
 }
 
 static DEVICE_ATTR(block_size_bytes, 0444, print_block_size, NULL);
@@ -470,9 +470,9 @@ show_auto_online_blocks(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
 	if (memhp_auto_online)
-		return sysfs_emit(buf, "online\n");
+		return sprintf(buf, "online\n");
 	else
-		return sysfs_emit(buf, "offline\n");
+		return sprintf(buf, "offline\n");
 }
 
 static ssize_t
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 8defeace001e..60c2e32f9f61 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -69,7 +69,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 	struct sysinfo i;
 
 	si_meminfo_node(&i, nid);
-	n = sysfs_emit(buf,
+	n = sprintf(buf,
 		       "Node %d MemTotal:       %8lu kB\n"
 		       "Node %d MemFree:        %8lu kB\n"
 		       "Node %d MemUsed:        %8lu kB\n"
@@ -96,7 +96,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 		       nid, K(sum_zone_node_page_state(nid, NR_MLOCK)));
 
 #ifdef CONFIG_HIGHMEM
-	n += sysfs_emit(buf + n,
+	n += sprintf(buf + n,
 		       "Node %d HighTotal:      %8lu kB\n"
 		       "Node %d HighFree:       %8lu kB\n"
 		       "Node %d LowTotal:       %8lu kB\n"
@@ -106,7 +106,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 		       nid, K(i.totalram - i.totalhigh),
 		       nid, K(i.freeram - i.freehigh));
 #endif
-	n += sysfs_emit(buf + n,
+	n += sprintf(buf + n,
 		       "Node %d Dirty:          %8lu kB\n"
 		       "Node %d Writeback:      %8lu kB\n"
 		       "Node %d FilePages:      %8lu kB\n"
@@ -162,19 +162,19 @@ static DEVICE_ATTR(meminfo, S_IRUGO, node_read_meminfo, NULL);
 static ssize_t node_read_numastat(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf,
-			  "numa_hit %lu\n"
-			  "numa_miss %lu\n"
-			  "numa_foreign %lu\n"
-			  "interleave_hit %lu\n"
-			  "local_node %lu\n"
-			  "other_node %lu\n",
-			  sum_zone_numa_state(dev->id, NUMA_HIT),
-			  sum_zone_numa_state(dev->id, NUMA_MISS),
-			  sum_zone_numa_state(dev->id, NUMA_FOREIGN),
-			  sum_zone_numa_state(dev->id, NUMA_INTERLEAVE_HIT),
-			  sum_zone_numa_state(dev->id, NUMA_LOCAL),
-			  sum_zone_numa_state(dev->id, NUMA_OTHER));
+	return sprintf(buf,
+		       "numa_hit %lu\n"
+		       "numa_miss %lu\n"
+		       "numa_foreign %lu\n"
+		       "interleave_hit %lu\n"
+		       "local_node %lu\n"
+		       "other_node %lu\n",
+		       sum_zone_numa_state(dev->id, NUMA_HIT),
+		       sum_zone_numa_state(dev->id, NUMA_MISS),
+		       sum_zone_numa_state(dev->id, NUMA_FOREIGN),
+		       sum_zone_numa_state(dev->id, NUMA_INTERLEAVE_HIT),
+		       sum_zone_numa_state(dev->id, NUMA_LOCAL),
+		       sum_zone_numa_state(dev->id, NUMA_OTHER));
 }
 static DEVICE_ATTR(numastat, S_IRUGO, node_read_numastat, NULL);
 
@@ -612,7 +612,7 @@ static ssize_t print_nodes_state(enum node_states state, char *buf)
 {
 	int n;
 
-	n = sysfs_emit(buf, "%*pbl",
+	n = scnprintf(buf, PAGE_SIZE - 1, "%*pbl",
 		      nodemask_pr_args(&node_states[state]));
 	buf[n++] = '\n';
 	buf[n] = '\0';
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 1819da6889a7..2f89e618b142 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -927,7 +927,7 @@ static ssize_t driver_override_show(struct device *dev,
 	ssize_t len;
 
 	device_lock(dev);
-	len = sysfs_emit(buf, "%s\n", pdev->driver_override);
+	len = sprintf(buf, "%s\n", pdev->driver_override);
 	device_unlock(dev);
 	return len;
 }
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index c61b50aa1d81..d713738ce796 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -101,7 +101,7 @@ static const char ctrl_on[] = "on";
 static ssize_t control_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
-	return sysfs_emit(buf, "%s\n",
+	return sprintf(buf, "%s\n",
 				dev->power.runtime_auto ? ctrl_auto : ctrl_on);
 }
 
@@ -127,7 +127,7 @@ static ssize_t runtime_active_time_show(struct device *dev,
 	int ret;
 	spin_lock_irq(&dev->power.lock);
 	update_pm_runtime_accounting(dev);
-	ret = sysfs_emit(buf, "%i\n", jiffies_to_msecs(dev->power.active_jiffies));
+	ret = sprintf(buf, "%i\n", jiffies_to_msecs(dev->power.active_jiffies));
 	spin_unlock_irq(&dev->power.lock);
 	return ret;
 }
@@ -140,7 +140,7 @@ static ssize_t runtime_suspended_time_show(struct device *dev,
 	int ret;
 	spin_lock_irq(&dev->power.lock);
 	update_pm_runtime_accounting(dev);
-	ret = sysfs_emit(buf, "%i\n",
+	ret = sprintf(buf, "%i\n",
 		jiffies_to_msecs(dev->power.suspended_jiffies));
 	spin_unlock_irq(&dev->power.lock);
 	return ret;
@@ -175,7 +175,7 @@ static ssize_t runtime_status_show(struct device *dev,
 			return -EIO;
 		}
 	}
-	return sysfs_emit(buf, p);
+	return sprintf(buf, p);
 }
 
 static DEVICE_ATTR_RO(runtime_status);
@@ -185,7 +185,7 @@ static ssize_t autosuspend_delay_ms_show(struct device *dev,
 {
 	if (!dev->power.use_autosuspend)
 		return -EIO;
-	return sysfs_emit(buf, "%d\n", dev->power.autosuspend_delay);
+	return sprintf(buf, "%d\n", dev->power.autosuspend_delay);
 }
 
 static ssize_t autosuspend_delay_ms_store(struct device *dev,
@@ -214,11 +214,11 @@ static ssize_t pm_qos_resume_latency_us_show(struct device *dev,
 	s32 value = dev_pm_qos_requested_resume_latency(dev);
 
 	if (value == 0)
-		return sysfs_emit(buf, "n/a\n");
+		return sprintf(buf, "n/a\n");
 	if (value == PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
 		value = 0;
 
-	return sysfs_emit(buf, "%d\n", value);
+	return sprintf(buf, "%d\n", value);
 }
 
 static ssize_t pm_qos_resume_latency_us_store(struct device *dev,
@@ -258,11 +258,11 @@ static ssize_t pm_qos_latency_tolerance_us_show(struct device *dev,
 	s32 value = dev_pm_qos_get_user_latency_tolerance(dev);
 
 	if (value < 0)
-		return sysfs_emit(buf, "auto\n");
+		return sprintf(buf, "auto\n");
 	if (value == PM_QOS_LATENCY_ANY)
-		return sysfs_emit(buf, "any\n");
+		return sprintf(buf, "any\n");
 
-	return sysfs_emit(buf, "%d\n", value);
+	return sprintf(buf, "%d\n", value);
 }
 
 static ssize_t pm_qos_latency_tolerance_us_store(struct device *dev,
@@ -294,8 +294,8 @@ static ssize_t pm_qos_no_power_off_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	return sysfs_emit(buf, "%d\n", !!(dev_pm_qos_requested_flags(dev)
-					  & PM_QOS_FLAG_NO_POWER_OFF));
+	return sprintf(buf, "%d\n", !!(dev_pm_qos_requested_flags(dev)
+					& PM_QOS_FLAG_NO_POWER_OFF));
 }
 
 static ssize_t pm_qos_no_power_off_store(struct device *dev,
@@ -323,9 +323,9 @@ static const char _disabled[] = "disabled";
 static ssize_t wakeup_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
-	return sysfs_emit(buf, "%s\n", device_can_wakeup(dev)
-			  ? (device_may_wakeup(dev) ? _enabled : _disabled)
-			  : "");
+	return sprintf(buf, "%s\n", device_can_wakeup(dev)
+		? (device_may_wakeup(dev) ? _enabled : _disabled)
+		: "");
 }
 
 static ssize_t wakeup_store(struct device *dev, struct device_attribute *attr,
@@ -511,7 +511,7 @@ static DEVICE_ATTR_RO(wakeup_prevent_sleep_time_ms);
 static ssize_t runtime_usage_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "%d\n", atomic_read(&dev->power.usage_count));
+	return sprintf(buf, "%d\n", atomic_read(&dev->power.usage_count));
 }
 static DEVICE_ATTR_RO(runtime_usage);
 
@@ -519,8 +519,8 @@ static ssize_t runtime_active_kids_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	return sysfs_emit(buf, "%d\n", dev->power.ignore_children ?
-			  0 : atomic_read(&dev->power.child_count));
+	return sprintf(buf, "%d\n", dev->power.ignore_children ?
+		0 : atomic_read(&dev->power.child_count));
 }
 static DEVICE_ATTR_RO(runtime_active_kids);
 
@@ -528,12 +528,12 @@ static ssize_t runtime_enabled_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	if (dev->power.disable_depth && (dev->power.runtime_auto == false))
-		return sysfs_emit(buf, "disabled & forbidden\n");
+		return sprintf(buf, "disabled & forbidden\n");
 	if (dev->power.disable_depth)
-		return sysfs_emit(buf, "disabled\n");
+		return sprintf(buf, "disabled\n");
 	if (dev->power.runtime_auto == false)
-		return sysfs_emit(buf, "forbidden\n");
-	return sysfs_emit(buf, "enabled\n");
+		return sprintf(buf, "forbidden\n");
+	return sprintf(buf, "enabled\n");
 }
 static DEVICE_ATTR_RO(runtime_enabled);
 
@@ -541,9 +541,9 @@ static DEVICE_ATTR_RO(runtime_enabled);
 static ssize_t async_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
-	return sysfs_emit(buf, "%s\n",
-			  device_async_suspend_enabled(dev) ?
-			  _enabled : _disabled);
+	return sprintf(buf, "%s\n",
+			device_async_suspend_enabled(dev) ?
+				_enabled : _disabled);
 }
 
 static ssize_t async_store(struct device *dev, struct device_attribute *attr,
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
diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index 23bc9eb794a2..7e91894a380b 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -72,13 +72,13 @@ static ssize_t soc_info_get(struct device *dev,
 	struct soc_device *soc_dev = container_of(dev, struct soc_device, dev);
 
 	if (attr == &dev_attr_machine)
-		return sysfs_emit(buf, "%s\n", soc_dev->attr->machine);
+		return sprintf(buf, "%s\n", soc_dev->attr->machine);
 	if (attr == &dev_attr_family)
-		return sysfs_emit(buf, "%s\n", soc_dev->attr->family);
+		return sprintf(buf, "%s\n", soc_dev->attr->family);
 	if (attr == &dev_attr_revision)
-		return sysfs_emit(buf, "%s\n", soc_dev->attr->revision);
+		return sprintf(buf, "%s\n", soc_dev->attr->revision);
 	if (attr == &dev_attr_soc_id)
-		return sysfs_emit(buf, "%s\n", soc_dev->attr->soc_id);
+		return sprintf(buf, "%s\n", soc_dev->attr->soc_id);
 
 	return -EINVAL;
 
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
index 01dada561c10..3bdd3334b0f9 100644
--- a/drivers/clk/tegra/clk-bpmp.c
+++ b/drivers/clk/tegra/clk-bpmp.c
@@ -162,7 +162,7 @@ static unsigned long tegra_bpmp_clk_recalc_rate(struct clk_hw *hw,
 
 	err = tegra_bpmp_clk_transfer(clk->bpmp, &msg);
 	if (err < 0)
-		return err;
+		return 0;
 
 	return response.rate;
 }
diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index e627e0e9001a..ba1cd971d50b 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -999,7 +999,7 @@ static int aspeed_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 	else if (param == PIN_CONFIG_BIAS_DISABLE ||
 			param == PIN_CONFIG_BIAS_PULL_DOWN ||
 			param == PIN_CONFIG_DRIVE_STRENGTH)
-		return pinctrl_gpio_set_config(offset, config);
+		return pinctrl_gpio_set_config(chip->base + offset, config);
 	else if (param == PIN_CONFIG_DRIVE_OPEN_DRAIN ||
 			param == PIN_CONFIG_DRIVE_OPEN_SOURCE)
 		/* Return -ENOTSUPP to trigger emulation, as per datasheet */
diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic-eic-sprd.c
index 29e044ff4b17..7697cb96bf36 100644
--- a/drivers/gpio/gpio-pmic-eic-sprd.c
+++ b/drivers/gpio/gpio-pmic-eic-sprd.c
@@ -341,6 +341,7 @@ static int sprd_pmic_eic_probe(struct platform_device *pdev)
 	pmic_eic->chip.set_config = sprd_pmic_eic_set_config;
 	pmic_eic->chip.set = sprd_pmic_eic_set;
 	pmic_eic->chip.get = sprd_pmic_eic_get;
+	pmic_eic->chip.can_sleep = true;
 
 	pmic_eic->intc.name = dev_name(&pdev->dev);
 	pmic_eic->intc.irq_mask = sprd_pmic_eic_irq_mask;
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index bcc6be4a5cb2..61df316e0d17 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -246,6 +246,7 @@ static bool pxa_gpio_has_pinctrl(void)
 	switch (gpio_type) {
 	case PXA3XX_GPIO:
 	case MMP2_GPIO:
+	case MMP_GPIO:
 		return false;
 
 	default:
diff --git a/drivers/gpio/gpio-tb10x.c b/drivers/gpio/gpio-tb10x.c
index a12cd0b5c972..1d80bae86ec9 100644
--- a/drivers/gpio/gpio-tb10x.c
+++ b/drivers/gpio/gpio-tb10x.c
@@ -246,7 +246,7 @@ static int tb10x_gpio_probe(struct platform_device *pdev)
 				handle_edge_irq, IRQ_NOREQUEST, IRQ_NOPROBE,
 				IRQ_GC_INIT_MASK_CACHE);
 		if (ret)
-			return ret;
+			goto err_remove_domain;
 
 		gc = tb10x_gpio->domain->gc->gc[0];
 		gc->reg_base                         = tb10x_gpio->base;
@@ -260,6 +260,10 @@ static int tb10x_gpio_probe(struct platform_device *pdev)
 	}
 
 	return 0;
+
+err_remove_domain:
+	irq_domain_remove(tb10x_gpio->domain);
+	return ret;
 }
 
 static int tb10x_gpio_remove(struct platform_device *pdev)
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index fb0ddaad87d2..6017f6aeee89 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1679,6 +1679,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		"SMBus I801 adapter at %04lx", priv->smba);
 	err = i2c_add_adapter(&priv->adapter);
 	if (err) {
+		platform_device_unregister(priv->tco_pdev);
 		i801_acpi_remove(priv);
 		return err;
 	}
diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index 1b99d0b928a0..092ebc08549f 100644
--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -244,6 +244,10 @@ static int i2c_demux_pinctrl_probe(struct platform_device *pdev)
 
 		props[i].name = devm_kstrdup(&pdev->dev, "status", GFP_KERNEL);
 		props[i].value = devm_kstrdup(&pdev->dev, "ok", GFP_KERNEL);
+		if (!props[i].name || !props[i].value) {
+			err = -ENOMEM;
+			goto err_rollback;
+		}
 		props[i].length = 3;
 
 		of_changeset_init(&priv->chan[i].chgset);
diff --git a/drivers/infiniband/core/cma_configfs.c b/drivers/infiniband/core/cma_configfs.c
index ce183d054785..f9b0303b3a01 100644
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
index 1688c06d5c3c..f7df27c7c634 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2005,7 +2005,7 @@ static inline char *mmap_cmd2str(enum mlx5_ib_mmap_cmd cmd)
 	case MLX5_IB_MMAP_DEVICE_MEM:
 		return "Device Memory";
 	default:
-		return NULL;
+		return "Unknown";
 	}
 }
 
diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index da2bf8259330..0cf9a3787326 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -1188,6 +1188,13 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
 					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
 	},
+	/* See comment on TUXEDO InfinityBook S17 Gen6 / Clevo NS70MU above */
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "PD5x_7xPNP_PNR_PNN_PNT"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOAUX)
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
diff --git a/drivers/media/dvb-frontends/sp8870.c b/drivers/media/dvb-frontends/sp8870.c
index 3a577788041d..c55bcd809458 100644
--- a/drivers/media/dvb-frontends/sp8870.c
+++ b/drivers/media/dvb-frontends/sp8870.c
@@ -619,4 +619,4 @@ MODULE_DESCRIPTION("Spase SP8870 DVB-T Demodulator driver");
 MODULE_AUTHOR("Juergen Peitz");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(sp8870_attach);
+EXPORT_SYMBOL_GPL(sp8870_attach);
diff --git a/drivers/media/tuners/tuner-xc2028.c b/drivers/media/tuners/tuner-xc2028.c
index aa6861dcd3fd..802a4d77f26b 100644
--- a/drivers/media/tuners/tuner-xc2028.c
+++ b/drivers/media/tuners/tuner-xc2028.c
@@ -1513,7 +1513,7 @@ struct dvb_frontend *xc2028_attach(struct dvb_frontend *fe,
 	return NULL;
 }
 
-EXPORT_SYMBOL(xc2028_attach);
+EXPORT_SYMBOL_GPL(xc2028_attach);
 
 MODULE_DESCRIPTION("Xceive xc2028/xc3028 tuner driver");
 MODULE_AUTHOR("Michel Ludwig <michel.ludwig@gmail.com>");
diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index 3eb14c68cb9b..3e7e5b51eafd 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -878,6 +878,13 @@ int ubi_attach_mtd_dev(struct mtd_info *mtd, int ubi_num,
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
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 2c334b56fd42..d668d25ae7e7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2517,8 +2517,13 @@ static u32 hclge_check_event_cause(struct hclge_dev *hdev, u32 *clearval)
 static void hclge_clear_event_cause(struct hclge_dev *hdev, u32 event_type,
 				    u32 regclr)
 {
+#define HCLGE_IMP_RESET_DELAY		5
+
 	switch (event_type) {
 	case HCLGE_VECTOR0_EVENT_RST:
+		if (regclr == BIT(HCLGE_VECTOR0_IMPRESET_INT_B))
+			mdelay(HCLGE_IMP_RESET_DELAY);
+
 		hclge_write_dev(&hdev->hw, HCLGE_MISC_RESET_STS_REG, regclr);
 		break;
 	case HCLGE_VECTOR0_EVENT_MBX:
diff --git a/drivers/net/ethernet/qlogic/qed/qed_ll2.h b/drivers/net/ethernet/qlogic/qed/qed_ll2.h
index f65817012e97..785899d3511c 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_ll2.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.h
@@ -122,9 +122,9 @@ struct qed_ll2_info {
 	enum core_tx_dest tx_dest;
 	u8 tx_stats_en;
 	bool main_func_queue;
+	struct qed_ll2_cbs cbs;
 	struct qed_ll2_rx_queue rx_queue;
 	struct qed_ll2_tx_queue tx_queue;
-	struct qed_ll2_cbs cbs;
 };
 
 /**
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index 7e2e79dedebf..df7fc6b675a5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -57,6 +57,7 @@ struct stm32_ops {
 	int (*parse_data)(struct stm32_dwmac *dwmac,
 			  struct device *dev);
 	u32 syscfg_eth_mask;
+	bool clk_rx_enable_in_suspend;
 };
 
 static int stm32_dwmac_init(struct plat_stmmacenet_data *plat_dat)
@@ -74,7 +75,8 @@ static int stm32_dwmac_init(struct plat_stmmacenet_data *plat_dat)
 	if (ret)
 		return ret;
 
-	if (!dwmac->dev->power.is_suspended) {
+	if (!dwmac->ops->clk_rx_enable_in_suspend ||
+	    !dwmac->dev->power.is_suspended) {
 		ret = clk_prepare_enable(dwmac->clk_rx);
 		if (ret) {
 			clk_disable_unprepare(dwmac->clk_tx);
@@ -413,7 +415,8 @@ static struct stm32_ops stm32mp1_dwmac_data = {
 	.suspend = stm32mp1_suspend,
 	.resume = stm32mp1_resume,
 	.parse_data = stm32mp1_parse_data,
-	.syscfg_eth_mask = SYSCFG_MP1_ETH_MASK
+	.syscfg_eth_mask = SYSCFG_MP1_ETH_MASK,
+	.clk_rx_enable_in_suspend = true
 };
 
 static const struct of_device_id stm32_dwmac_match[] = {
diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 8b5e1ec6aabf..08f9530fd5b1 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2095,7 +2095,12 @@ static const struct ethtool_ops team_ethtool_ops = {
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
@@ -2142,8 +2147,11 @@ static int team_dev_type_check_change(struct net_device *dev,
 
 static void team_setup(struct net_device *dev)
 {
+	struct team *team = netdev_priv(dev);
+
 	ether_setup(dev);
 	dev->max_mtu = ETH_MAX_MTU;
+	team->header_ops_cache = dev->header_ops;
 
 	dev->netdev_ops = &team_netdev_ops;
 	dev->ethtool_ops = &team_ethtool_ops;
diff --git a/drivers/net/thunderbolt.c b/drivers/net/thunderbolt.c
index 51b5442fbc66..e0b4c54e6c08 100644
--- a/drivers/net/thunderbolt.c
+++ b/drivers/net/thunderbolt.c
@@ -961,12 +961,11 @@ static bool tbnet_xmit_csum_and_map(struct tbnet *net, struct sk_buff *skb,
 		*tucso = ~csum_tcpudp_magic(ip_hdr(skb)->saddr,
 					    ip_hdr(skb)->daddr, 0,
 					    ip_hdr(skb)->protocol, 0);
-	} else if (skb_is_gso_v6(skb)) {
+	} else if (skb_is_gso(skb) && skb_is_gso_v6(skb)) {
 		tucso = dest + ((void *)&(tcp_hdr(skb)->check) - data);
 		*tucso = ~csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
 					  &ipv6_hdr(skb)->daddr, 0,
 					  IPPROTO_TCP, 0);
-		return false;
 	} else if (protocol == htons(ETH_P_IPV6)) {
 		tucso = dest + skb_checksum_start_offset(skb) + skb->csum_offset;
 		*tucso = ~csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
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
index 5df6e85e7ccb..c8cff000a931 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -37,6 +37,8 @@
 
 #define TDM_PPPOHT_SLIC_MAXIN
 
+static int uhdlc_close(struct net_device *dev);
+
 static struct ucc_tdm_info utdm_primary_info = {
 	.uf_info = {
 		.tsa = 0,
@@ -661,6 +663,7 @@ static int uhdlc_open(struct net_device *dev)
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	struct ucc_hdlc_private *priv = hdlc->priv;
 	struct ucc_tdm *utdm = priv->utdm;
+	int rc = 0;
 
 	if (priv->hdlc_busy != 1) {
 		if (request_irq(priv->ut_info->uf_info.irq,
@@ -683,10 +686,13 @@ static int uhdlc_open(struct net_device *dev)
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
@@ -775,6 +781,8 @@ static int uhdlc_close(struct net_device *dev)
 	netif_stop_queue(dev);
 	priv->hdlc_busy = 0;
 
+	hdlc_close(dev);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
index 5380fba652cc..1aa0bcdab8ef 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
@@ -986,8 +986,8 @@ void mwifiex_11n_rxba_sync_event(struct mwifiex_private *priv,
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
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b06d2b6bd3fe..163497ef48fd 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2501,8 +2501,6 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	size_t alloc_size;
 
 	node = dev_to_node(&pdev->dev);
-	if (node == NUMA_NO_NODE)
-		set_dev_node(&pdev->dev, first_memory_node);
 
 	dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, node);
 	if (!dev)
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
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index ea0cd2401d6b..133fad284c9f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -758,8 +758,6 @@ static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
 	if (IS_ERR(res->phy_ahb_reset))
 		return PTR_ERR(res->phy_ahb_reset);
 
-	dw_pcie_dbi_ro_wr_dis(pci);
-
 	return 0;
 }
 
diff --git a/drivers/s390/scsi/zfcp_aux.c b/drivers/s390/scsi/zfcp_aux.c
index d1b531fe9ada..e5697ae9b4a3 100644
--- a/drivers/s390/scsi/zfcp_aux.c
+++ b/drivers/s390/scsi/zfcp_aux.c
@@ -493,12 +493,12 @@ struct zfcp_port *zfcp_port_enqueue(struct zfcp_adapter *adapter, u64 wwpn,
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
@@ -521,7 +521,7 @@ struct zfcp_port *zfcp_port_enqueue(struct zfcp_adapter *adapter, u64 wwpn,
 
 	if (dev_set_name(&port->dev, "0x%016llx", (unsigned long long)wwpn)) {
 		kfree(port);
-		goto err_out;
+		goto err_put;
 	}
 	retval = -EINVAL;
 
@@ -538,8 +538,9 @@ struct zfcp_port *zfcp_port_enqueue(struct zfcp_adapter *adapter, u64 wwpn,
 
 	return port;
 
-err_out:
+err_put:
 	zfcp_ccw_adapter_put(adapter);
+err_out:
 	return ERR_PTR(retval);
 }
 
diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
index 67d356d84717..0d7cca9365aa 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -2193,7 +2193,8 @@ struct megasas_instance {
 	u32 secure_jbod_support;
 	u32 support_morethan256jbod; /* FW support for more than 256 PD/JBOD */
 	bool use_seqnum_jbod_fp;   /* Added for PD sequence */
-	spinlock_t crashdump_lock;
+	bool smp_affinity_enable;
+	struct mutex crashdump_lock;
 
 	struct megasas_register_set __iomem *reg_set;
 	u32 __iomem *reply_post_host_index_addr[MR_MAX_MSIX_REG_ARRAY];
@@ -2210,6 +2211,7 @@ struct megasas_instance {
 	u16 ldio_threshold;
 	u16 cur_can_queue;
 	u32 max_sectors_per_req;
+	bool msix_load_balance;
 	struct megasas_aen_event *ev;
 
 	struct megasas_cmd **cmd_list;
@@ -2246,6 +2248,7 @@ struct megasas_instance {
 	atomic_t sge_holes_type1;
 	atomic_t sge_holes_type2;
 	atomic_t sge_holes_type3;
+	atomic64_t total_io_count;
 
 	struct megasas_instance_template *instancet;
 	struct tasklet_struct isr_tasklet;
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 8d1df03386b4..ac4800fb1a7f 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3004,14 +3004,13 @@ megasas_fw_crash_buffer_store(struct device *cdev,
 	struct megasas_instance *instance =
 		(struct megasas_instance *) shost->hostdata;
 	int val = 0;
-	unsigned long flags;
 
 	if (kstrtoint(buf, 0, &val) != 0)
 		return -EINVAL;
 
-	spin_lock_irqsave(&instance->crashdump_lock, flags);
+	mutex_lock(&instance->crashdump_lock);
 	instance->fw_crash_buffer_offset = val;
-	spin_unlock_irqrestore(&instance->crashdump_lock, flags);
+	mutex_unlock(&instance->crashdump_lock);
 	return strlen(buf);
 }
 
@@ -3027,17 +3026,16 @@ megasas_fw_crash_buffer_show(struct device *cdev,
 	unsigned long dmachunk = CRASH_DMA_BUF_SIZE;
 	unsigned long chunk_left_bytes;
 	unsigned long src_addr;
-	unsigned long flags;
 	u32 buff_offset;
 
-	spin_lock_irqsave(&instance->crashdump_lock, flags);
+	mutex_lock(&instance->crashdump_lock);
 	buff_offset = instance->fw_crash_buffer_offset;
 	if (!instance->crash_dump_buf ||
 		!((instance->fw_crash_state == AVAILABLE) ||
 		(instance->fw_crash_state == COPYING))) {
 		dev_err(&instance->pdev->dev,
 			"Firmware crash dump is not available\n");
-		spin_unlock_irqrestore(&instance->crashdump_lock, flags);
+		mutex_unlock(&instance->crashdump_lock);
 		return -EINVAL;
 	}
 
@@ -3046,7 +3044,7 @@ megasas_fw_crash_buffer_show(struct device *cdev,
 	if (buff_offset > (instance->fw_crash_buffer_size * dmachunk)) {
 		dev_err(&instance->pdev->dev,
 			"Firmware crash dump offset is out of range\n");
-		spin_unlock_irqrestore(&instance->crashdump_lock, flags);
+		mutex_unlock(&instance->crashdump_lock);
 		return 0;
 	}
 
@@ -3058,7 +3056,7 @@ megasas_fw_crash_buffer_show(struct device *cdev,
 	src_addr = (unsigned long)instance->crash_buf[buff_offset / dmachunk] +
 		(buff_offset % dmachunk);
 	memcpy(buf, (void *)src_addr, size);
-	spin_unlock_irqrestore(&instance->crashdump_lock, flags);
+	mutex_unlock(&instance->crashdump_lock);
 
 	return size;
 }
@@ -3083,7 +3081,6 @@ megasas_fw_crash_state_store(struct device *cdev,
 	struct megasas_instance *instance =
 		(struct megasas_instance *) shost->hostdata;
 	int val = 0;
-	unsigned long flags;
 
 	if (kstrtoint(buf, 0, &val) != 0)
 		return -EINVAL;
@@ -3097,9 +3094,9 @@ megasas_fw_crash_state_store(struct device *cdev,
 	instance->fw_crash_state = val;
 
 	if ((val == COPIED) || (val == COPY_ERROR)) {
-		spin_lock_irqsave(&instance->crashdump_lock, flags);
+		mutex_lock(&instance->crashdump_lock);
 		megasas_free_host_crash_buffer(instance);
-		spin_unlock_irqrestore(&instance->crashdump_lock, flags);
+		mutex_unlock(&instance->crashdump_lock);
 		if (val == COPY_ERROR)
 			dev_info(&instance->pdev->dev, "application failed to "
 				"copy Firmware crash dump\n");
@@ -5101,6 +5098,7 @@ megasas_setup_irqs_msix(struct megasas_instance *instance, u8 is_probe)
 					 &instance->irq_context[j]);
 			/* Retry irq register for IO_APIC*/
 			instance->msix_vectors = 0;
+			instance->msix_load_balance = false;
 			if (is_probe) {
 				pci_free_irq_vectors(instance->pdev);
 				return megasas_setup_irqs_ioapic(instance);
@@ -5109,6 +5107,7 @@ megasas_setup_irqs_msix(struct megasas_instance *instance, u8 is_probe)
 			}
 		}
 	}
+
 	return 0;
 }
 
@@ -5364,6 +5363,13 @@ static int megasas_init_fw(struct megasas_instance *instance)
 				if (rdpq_enable)
 					instance->is_rdpq = (scratch_pad_2 & MR_RDPQ_MODE_OFFSET) ?
 								1 : 0;
+
+				if (instance->adapter_type >= INVADER_SERIES &&
+				    !instance->msix_combined) {
+					instance->msix_load_balance = true;
+					instance->smp_affinity_enable = false;
+				}
+
 				fw_msix_count = instance->msix_vectors;
 				/* Save 1-15 reply post index address to local memory
 				 * Index 0 is already saved from reg offset
@@ -5382,17 +5388,20 @@ static int megasas_init_fw(struct megasas_instance *instance)
 					instance->msix_vectors);
 		} else /* MFI adapters */
 			instance->msix_vectors = 1;
+
 		/* Don't bother allocating more MSI-X vectors than cpus */
 		instance->msix_vectors = min(instance->msix_vectors,
 					     (unsigned int)num_online_cpus());
-		if (smp_affinity_enable)
+		if (instance->smp_affinity_enable)
 			irq_flags |= PCI_IRQ_AFFINITY;
 		i = pci_alloc_irq_vectors(instance->pdev, 1,
 					  instance->msix_vectors, irq_flags);
-		if (i > 0)
+		if (i > 0) {
 			instance->msix_vectors = i;
-		else
+		} else {
 			instance->msix_vectors = 0;
+			instance->msix_load_balance = false;
+		}
 	}
 	/*
 	 * MSI-X host index 0 is common for all adapter.
@@ -6447,11 +6456,12 @@ static inline void megasas_init_ctrl_params(struct megasas_instance *instance)
 	INIT_LIST_HEAD(&instance->internal_reset_pending_q);
 
 	atomic_set(&instance->fw_outstanding, 0);
+	atomic64_set(&instance->total_io_count, 0);
 
 	init_waitqueue_head(&instance->int_cmd_wait_q);
 	init_waitqueue_head(&instance->abort_cmd_wait_q);
 
-	spin_lock_init(&instance->crashdump_lock);
+	mutex_init(&instance->crashdump_lock);
 	spin_lock_init(&instance->mfi_pool_lock);
 	spin_lock_init(&instance->hba_lock);
 	spin_lock_init(&instance->stream_lock);
@@ -6469,6 +6479,8 @@ static inline void megasas_init_ctrl_params(struct megasas_instance *instance)
 	instance->last_time = 0;
 	instance->disableOnlineCtrlReset = 1;
 	instance->UnevenSpanSupport = 0;
+	instance->smp_affinity_enable = smp_affinity_enable ? true : false;
+	instance->msix_load_balance = false;
 
 	if (instance->adapter_type != MFI_SERIES) {
 		INIT_WORK(&instance->work_init, megasas_fusion_ocr_wq);
@@ -6818,7 +6830,7 @@ megasas_resume(struct pci_dev *pdev)
 	/* Now re-enable MSI-X */
 	if (instance->msix_vectors) {
 		irq_flags = PCI_IRQ_MSIX;
-		if (smp_affinity_enable)
+		if (instance->smp_affinity_enable)
 			irq_flags |= PCI_IRQ_AFFINITY;
 	}
 	rval = pci_alloc_irq_vectors(instance->pdev, 1,
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index b400167f9ad4..294e1a3a6adf 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -2641,8 +2641,13 @@ megasas_build_ldio_fusion(struct megasas_instance *instance,
 			fp_possible = (io_info.fpOkForIo > 0) ? true : false;
 	}
 
-	cmd->request_desc->SCSIIO.MSIxIndex =
-		instance->reply_map[raw_smp_processor_id()];
+	if (instance->msix_load_balance)
+		cmd->request_desc->SCSIIO.MSIxIndex =
+			(mega_mod64(atomic64_add_return(1, &instance->total_io_count),
+				    instance->msix_vectors));
+	else
+		cmd->request_desc->SCSIIO.MSIxIndex =
+			instance->reply_map[raw_smp_processor_id()];
 
 	praid_context = &io_request->RaidContext;
 
@@ -2969,8 +2974,13 @@ megasas_build_syspd_fusion(struct megasas_instance *instance,
 
 	cmd->request_desc->SCSIIO.DevHandle = io_request->DevHandle;
 
-	cmd->request_desc->SCSIIO.MSIxIndex =
-		instance->reply_map[raw_smp_processor_id()];
+	if (instance->msix_load_balance)
+		cmd->request_desc->SCSIIO.MSIxIndex =
+			(mega_mod64(atomic64_add_return(1, &instance->total_io_count),
+				    instance->msix_vectors));
+	else
+		cmd->request_desc->SCSIIO.MSIxIndex =
+			instance->reply_map[raw_smp_processor_id()];
 
 	if (!fp_possible) {
 		/* system pd firmware path */
diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index 6c9095d0aa0f..9a25e92ef1ab 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -2088,8 +2088,6 @@ qla24xx_vport_create(struct fc_vport *fc_vport, bool disable)
 			vha->flags.difdix_supported = 1;
 			ql_dbg(ql_dbg_user, vha, 0x7082,
 			    "Registered for DIF/DIX type 1 and 3 protection.\n");
-			if (ql2xenabledif == 1)
-				prot = SHOST_DIX_TYPE0_PROTECTION;
 			scsi_host_set_prot(vha->host,
 			    prot | SHOST_DIF_TYPE1_PROTECTION
 			    | SHOST_DIF_TYPE2_PROTECTION
diff --git a/drivers/scsi/qla2xxx/qla_dbg.c b/drivers/scsi/qla2xxx/qla_dbg.c
index 36871760a5d3..fcbadd41856c 100644
--- a/drivers/scsi/qla2xxx/qla_dbg.c
+++ b/drivers/scsi/qla2xxx/qla_dbg.c
@@ -22,7 +22,7 @@
  * | Queue Command and IO tracing |       0x3074       | 0x300b         |
  * |                              |                    | 0x3027-0x3028  |
  * |                              |                    | 0x303d-0x3041  |
- * |                              |                    | 0x302d,0x3033  |
+ * |                              |                    | 0x302e,0x3033  |
  * |                              |                    | 0x3036,0x3038  |
  * |                              |                    | 0x303a		|
  * | DPC Thread                   |       0x4023       | 0x4002,0x4013  |
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 4580774b2c3e..36dca08166f2 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -277,6 +277,20 @@ MODULE_PARM_DESC(qla2xuseresexchforels,
 		 "Reserve 1/2 of emergency exchanges for ELS.\n"
 		 " 0 (default): disabled");
 
+int ql2xprotmask;
+module_param(ql2xprotmask, int, 0644);
+MODULE_PARM_DESC(ql2xprotmask,
+		 "Override DIF/DIX protection capabilities mask\n"
+		 "Default is 0 which sets protection mask based on "
+		 "capabilities reported by HBA firmware.\n");
+
+int ql2xprotguard;
+module_param(ql2xprotguard, int, 0644);
+MODULE_PARM_DESC(ql2xprotguard, "Override choice of DIX checksum\n"
+		 "  0 -- Let HBA firmware decide\n"
+		 "  1 -- Force T10 CRC\n"
+		 "  2 -- Force IP checksum\n");
+
 /*
  * SCSI host template entry points
  */
@@ -3055,6 +3069,13 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	host->max_id = ha->max_fibre_devices;
 	host->cmd_per_lun = 3;
 	host->unique_id = host->host_no;
+
+	if (ql2xenabledif && ql2xenabledif != 2) {
+		ql_log(ql_log_warn, base_vha, 0x302d,
+		       "Invalid value for ql2xenabledif, resetting it to default (2)\n");
+		ql2xenabledif = 2;
+	}
+
 	if (IS_T10_PI_CAPABLE(ha) && ql2xenabledif)
 		host->max_cmd_len = 32;
 	else
@@ -3291,15 +3312,16 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 			base_vha->flags.difdix_supported = 1;
 			ql_dbg(ql_dbg_init, base_vha, 0x00f1,
 			    "Registering for DIF/DIX type 1 and 3 protection.\n");
-			if (ql2xenabledif == 1)
-				prot = SHOST_DIX_TYPE0_PROTECTION;
-			scsi_host_set_prot(host,
-			    prot | SHOST_DIF_TYPE1_PROTECTION
-			    | SHOST_DIF_TYPE2_PROTECTION
-			    | SHOST_DIF_TYPE3_PROTECTION
-			    | SHOST_DIX_TYPE1_PROTECTION
-			    | SHOST_DIX_TYPE2_PROTECTION
-			    | SHOST_DIX_TYPE3_PROTECTION);
+			if (ql2xprotmask)
+				scsi_host_set_prot(host, ql2xprotmask);
+			else
+				scsi_host_set_prot(host,
+				    prot | SHOST_DIF_TYPE1_PROTECTION
+				    | SHOST_DIF_TYPE2_PROTECTION
+				    | SHOST_DIF_TYPE3_PROTECTION
+				    | SHOST_DIX_TYPE1_PROTECTION
+				    | SHOST_DIX_TYPE2_PROTECTION
+				    | SHOST_DIX_TYPE3_PROTECTION);
 
 			guard = SHOST_DIX_GUARD_CRC;
 
@@ -3307,7 +3329,10 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 			    (ql2xenabledif > 1 || IS_PI_DIFB_DIX0_CAPABLE(ha)))
 				guard |= SHOST_DIX_GUARD_IP;
 
-			scsi_host_set_guard(host, guard);
+			if (ql2xprotguard)
+				scsi_host_set_guard(host, ql2xprotguard);
+			else
+				scsi_host_set_guard(host, guard);
 		} else
 			base_vha->flags.difdix_supported = 0;
 	}
diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index 1b381519c164..a23dcbe79e14 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -881,7 +881,6 @@ sector_t target_to_linux_sector(struct se_device *dev, sector_t lb)
 EXPORT_SYMBOL(target_to_linux_sector);
 
 struct devices_idr_iter {
-	struct config_item *prev_item;
 	int (*fn)(struct se_device *dev, void *data);
 	void *data;
 };
@@ -891,11 +890,9 @@ static int target_devices_idr_iter(int id, void *p, void *data)
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
@@ -905,12 +902,13 @@ static int target_devices_idr_iter(int id, void *p, void *data)
 	if (!target_dev_configured(dev))
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
@@ -933,7 +931,6 @@ int target_for_each_device(int (*fn)(struct se_device *dev, void *data),
 	mutex_lock(&device_mutex);
 	ret = idr_for_each(&devices_idr, target_devices_idr_iter, &iter);
 	mutex_unlock(&device_mutex);
-	config_item_put(iter.prev_item);
 	return ret;
 }
 
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index d3161be35b1b..7f5d51de622d 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1910,7 +1910,10 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
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
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index afb0c9e4d738..8e224ee27ade 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2085,7 +2085,7 @@ config FB_COBALT
 
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
index b6b3131cb079..960666aba12b 100644
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
@@ -213,6 +203,22 @@ static void set_info_for_irq(unsigned int irq, struct irq_info *info)
 		irq_set_chip_data(irq, info);
 }
 
+static void delayed_free_irq(struct work_struct *work)
+{
+	struct irq_info *info = container_of(to_rcu_work(work), struct irq_info,
+					     rwork);
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
 /* Constructors for packed IRQ information. */
 static int xen_irq_info_common_setup(struct irq_info *info,
 				     unsigned irq,
@@ -547,33 +553,36 @@ static void xen_irq_lateeoi_worker(struct work_struct *work)
 
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
@@ -588,16 +597,15 @@ static void xen_cpu_init_eoi(unsigned int cpu)
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
 
@@ -616,6 +624,7 @@ static void xen_irq_init(unsigned irq)
 
 	info->type = IRQT_UNBOUND;
 	info->refcnt = -1;
+	INIT_RCU_WORK(&info->rwork, delayed_free_irq);
 
 	set_info_for_irq(irq, info);
 
@@ -668,31 +677,18 @@ static int __must_check xen_allocate_irq_gsi(unsigned gsi)
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
+	queue_rcu_work(system_wq, &info->rwork);
 }
 
 static void xen_evtchn_close(unsigned int port)
@@ -1603,7 +1599,14 @@ static void __xen_evtchn_do_upcall(void)
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
@@ -1620,7 +1623,7 @@ static void __xen_evtchn_do_upcall(void)
 	} while (count != 1 || vcpu_info->evtchn_upcall_pending);
 
 out:
-	read_unlock(&evtchn_rwlock);
+	rcu_read_unlock();
 
 	/*
 	 * Increment irq_epoch only now to defer EOIs only for
diff --git a/drivers/xen/events/events_internal.h b/drivers/xen/events/events_internal.h
index cc37b711491c..1d9d9e6f1dee 100644
--- a/drivers/xen/events/events_internal.h
+++ b/drivers/xen/events/events_internal.h
@@ -8,6 +8,7 @@
  */
 #ifndef __EVENTS_INTERNAL_H__
 #define __EVENTS_INTERNAL_H__
+#include <linux/rcupdate.h>
 
 /* Interrupt types. */
 enum xen_irq_type {
@@ -33,6 +34,7 @@ enum xen_irq_type {
 struct irq_info {
 	struct list_head list;
 	struct list_head eoi_list;
+	struct rcu_work rwork;
 	short refcnt;
 	short spurious_cnt;
 	short type;		/* type */
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 64d0b838085d..a7c2efcd0a4a 100644
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
index 521f6c2091ad..a59543951851 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2196,7 +2196,7 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	 * calculated f_bavail.
 	 */
 	if (!mixed && block_rsv->space_info->full &&
-	    total_free_meta - thresh < block_rsv->size)
+	    (total_free_meta < thresh || total_free_meta - thresh < block_rsv->size))
 		buf->f_bavail = 0;
 
 	buf->f_type = BTRFS_SUPER_MAGIC;
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 909f231a387d..fa2579abea7d 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1500,7 +1500,7 @@ struct ext4_sb_info {
 	struct task_struct *s_mmp_tsk;
 
 	/* record the last minlen when FITRIM is called. */
-	atomic_t s_last_trim_minblks;
+	unsigned long s_last_trim_minblks;
 
 	/* Reference to checksum algorithm driver via cryptoapi */
 	struct crypto_shash *s_chksum_driver;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 7692c12b8528..fb2f255c48e8 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/nospec.h>
 #include <linux/backing-dev.h>
+#include <linux/freezer.h>
 #include <trace/events/ext4.h>
 
 #ifdef CONFIG_EXT4_DEBUG
@@ -5149,19 +5150,19 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
  * @sb:		super block for the file system
  * @start:	starting block of the free extent in the alloc. group
  * @count:	number of blocks to TRIM
- * @group:	alloc. group we are working with
  * @e4b:	ext4 buddy for the group
  *
  * Trim "count" blocks starting at "start" in the "group". To assure that no
  * one will allocate those blocks, mark it as used in buddy bitmap. This must
  * be called with under the group lock.
  */
-static int ext4_trim_extent(struct super_block *sb, int start, int count,
-			     ext4_group_t group, struct ext4_buddy *e4b)
+static int ext4_trim_extent(struct super_block *sb,
+		int start, int count, struct ext4_buddy *e4b)
 __releases(bitlock)
 __acquires(bitlock)
 {
 	struct ext4_free_extent ex;
+	ext4_group_t group = e4b->bd_group;
 	int ret = 0;
 
 	trace_ext4_trim_extent(sb, group, start, count);
@@ -5184,6 +5185,71 @@ __acquires(bitlock)
 	return ret;
 }
 
+static ext4_grpblk_t ext4_last_grp_cluster(struct super_block *sb,
+					   ext4_group_t grp)
+{
+	if (grp < ext4_get_groups_count(sb))
+		return EXT4_CLUSTERS_PER_GROUP(sb) - 1;
+	return (ext4_blocks_count(EXT4_SB(sb)->s_es) -
+		ext4_group_first_block_no(sb, grp) - 1) >>
+					EXT4_CLUSTER_BITS(sb);
+}
+
+static bool ext4_trim_interrupted(void)
+{
+	return fatal_signal_pending(current) || freezing(current);
+}
+
+static int ext4_try_to_trim_range(struct super_block *sb,
+		struct ext4_buddy *e4b, ext4_grpblk_t start,
+		ext4_grpblk_t max, ext4_grpblk_t minblocks)
+{
+	ext4_grpblk_t next, count, free_count;
+	bool set_trimmed = false;
+	void *bitmap;
+
+	bitmap = e4b->bd_bitmap;
+	if (start == 0 && max >= ext4_last_grp_cluster(sb, e4b->bd_group))
+		set_trimmed = true;
+	start = max(e4b->bd_info->bb_first_free, start);
+	count = 0;
+	free_count = 0;
+
+	while (start <= max) {
+		start = mb_find_next_zero_bit(bitmap, max + 1, start);
+		if (start > max)
+			break;
+		next = mb_find_next_bit(bitmap, max + 1, start);
+
+		if ((next - start) >= minblocks) {
+			int ret = ext4_trim_extent(sb, start, next - start, e4b);
+
+			if (ret && ret != -EOPNOTSUPP)
+				return count;
+			count += next - start;
+		}
+		free_count += next - start;
+		start = next + 1;
+
+		if (ext4_trim_interrupted())
+			return count;
+
+		if (need_resched()) {
+			ext4_unlock_group(sb, e4b->bd_group);
+			cond_resched();
+			ext4_lock_group(sb, e4b->bd_group);
+		}
+
+		if ((e4b->bd_info->bb_free - free_count) < minblocks)
+			break;
+	}
+
+	if (set_trimmed)
+		EXT4_MB_GRP_SET_TRIMMED(e4b->bd_info);
+
+	return count;
+}
+
 /**
  * ext4_trim_all_free -- function to trim all free space in alloc. group
  * @sb:			super block for file system
@@ -5207,10 +5273,8 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 		   ext4_grpblk_t start, ext4_grpblk_t max,
 		   ext4_grpblk_t minblocks)
 {
-	void *bitmap;
-	ext4_grpblk_t next, count = 0, free_count = 0;
 	struct ext4_buddy e4b;
-	int ret = 0;
+	int ret;
 
 	trace_ext4_trim_all_free(sb, group, start, max);
 
@@ -5220,58 +5284,20 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 			     ret, group);
 		return ret;
 	}
-	bitmap = e4b.bd_bitmap;
 
 	ext4_lock_group(sb, group);
-	if (EXT4_MB_GRP_WAS_TRIMMED(e4b.bd_info) &&
-	    minblocks >= atomic_read(&EXT4_SB(sb)->s_last_trim_minblks))
-		goto out;
-
-	start = (e4b.bd_info->bb_first_free > start) ?
-		e4b.bd_info->bb_first_free : start;
-
-	while (start <= max) {
-		start = mb_find_next_zero_bit(bitmap, max + 1, start);
-		if (start > max)
-			break;
-		next = mb_find_next_bit(bitmap, max + 1, start);
-
-		if ((next - start) >= minblocks) {
-			ret = ext4_trim_extent(sb, start,
-					       next - start, group, &e4b);
-			if (ret && ret != -EOPNOTSUPP)
-				break;
-			ret = 0;
-			count += next - start;
-		}
-		free_count += next - start;
-		start = next + 1;
-
-		if (fatal_signal_pending(current)) {
-			count = -ERESTARTSYS;
-			break;
-		}
-
-		if (need_resched()) {
-			ext4_unlock_group(sb, group);
-			cond_resched();
-			ext4_lock_group(sb, group);
-		}
 
-		if ((e4b.bd_info->bb_free - free_count) < minblocks)
-			break;
-	}
+	if (!EXT4_MB_GRP_WAS_TRIMMED(e4b.bd_info) ||
+	    minblocks < EXT4_SB(sb)->s_last_trim_minblks)
+		ret = ext4_try_to_trim_range(sb, &e4b, start, max, minblocks);
+	else
+		ret = 0;
 
-	if (!ret) {
-		ret = count;
-		EXT4_MB_GRP_SET_TRIMMED(e4b.bd_info);
-	}
-out:
 	ext4_unlock_group(sb, group);
 	ext4_mb_unload_buddy(&e4b);
 
 	ext4_debug("trimmed %d blocks in the group %d\n",
-		count, group);
+		ret, group);
 
 	return ret;
 }
@@ -5316,7 +5342,7 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 		if (minlen > EXT4_CLUSTERS_PER_GROUP(sb))
 			goto out;
 	}
-	if (end >= max_blks)
+	if (end >= max_blks - 1)
 		end = max_blks - 1;
 	if (end <= first_data_blk)
 		goto out;
@@ -5333,6 +5359,8 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 	end = EXT4_CLUSTERS_PER_GROUP(sb) - 1;
 
 	for (group = first_group; group <= last_group; group++) {
+		if (ext4_trim_interrupted())
+			break;
 		grp = ext4_get_group_info(sb, group);
 		/* We only do this if the grp has never been initialized */
 		if (unlikely(EXT4_MB_GRP_NEED_INIT(grp))) {
@@ -5349,10 +5377,9 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 		 */
 		if (group == last_group)
 			end = last_cluster;
-
 		if (grp->bb_free >= minlen) {
 			cnt = ext4_trim_all_free(sb, group, first_cluster,
-						end, minlen);
+						 end, minlen);
 			if (cnt < 0) {
 				ret = cnt;
 				break;
@@ -5368,7 +5395,7 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 	}
 
 	if (!ret)
-		atomic_set(&EXT4_SB(sb)->s_last_trim_minblks, minlen);
+		EXT4_SB(sb)->s_last_trim_minblks = minlen;
 
 out:
 	range->len = EXT4_C2B(EXT4_SB(sb), trimmed) << sb->s_blocksize_bits;
@@ -5397,8 +5424,7 @@ ext4_mballoc_query_range(
 
 	ext4_lock_group(sb, group);
 
-	start = (e4b.bd_info->bb_first_free > start) ?
-		e4b.bd_info->bb_first_free : start;
+	start = max(e4b.bd_info->bb_first_free, start);
 	if (end >= EXT4_CLUSTERS_PER_GROUP(sb))
 		end = EXT4_CLUSTERS_PER_GROUP(sb) - 1;
 
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index db9bba3473b5..93d392576c12 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -322,17 +322,17 @@ static struct ext4_dir_entry_tail *get_dirent_tail(struct inode *inode,
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
@@ -343,7 +343,8 @@ static struct ext4_dir_entry_tail *get_dirent_tail(struct inode *inode,
 #endif
 
 	if (t->det_reserved_zero1 ||
-	    le16_to_cpu(t->det_rec_len) != sizeof(struct ext4_dir_entry_tail) ||
+	    (ext4_rec_len_from_disk(t->det_rec_len, blocksize) !=
+	     sizeof(struct ext4_dir_entry_tail)) ||
 	    t->det_reserved_zero2 ||
 	    t->det_reserved_ft != EXT4_FT_DIR_CSUM)
 		return NULL;
@@ -425,13 +426,14 @@ static struct dx_countlimit *get_dx_countlimit(struct inode *inode,
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
@@ -1244,6 +1246,7 @@ static int dx_make_map(struct inode *dir, struct buffer_head *bh,
 	unsigned int buflen = bh->b_size;
 	char *base = bh->b_data;
 	struct dx_hash_info h = *hinfo;
+	int blocksize = EXT4_BLOCK_SIZE(dir->i_sb);
 
 	if (ext4_has_metadata_csum(dir->i_sb))
 		buflen -= sizeof(struct ext4_dir_entry_tail);
@@ -1257,11 +1260,12 @@ static int dx_make_map(struct inode *dir, struct buffer_head *bh,
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
index fee421da2197..bb10f2b21cc1 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1189,6 +1189,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 		case -EPFNOSUPPORT:
 		case -EPROTONOSUPPORT:
 		case -EOPNOTSUPP:
+		case -EINVAL:
 		case -ECONNREFUSED:
 		case -ECONNRESET:
 		case -EHOSTDOWN:
diff --git a/fs/nilfs2/gcinode.c b/fs/nilfs2/gcinode.c
index 114774ac2185..cef46650102e 100644
--- a/fs/nilfs2/gcinode.c
+++ b/fs/nilfs2/gcinode.c
@@ -73,10 +73,8 @@ int nilfs_gccache_submit_read_data(struct inode *inode, sector_t blkoff,
 		struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
 
 		err = nilfs_dat_translate(nilfs->ns_dat, vbn, &pbn);
-		if (unlikely(err)) { /* -EIO, -ENOMEM, -ENOENT */
-			brelse(bh);
+		if (unlikely(err)) /* -EIO, -ENOMEM, -ENOENT */
 			goto failed;
-		}
 	}
 
 	lock_buffer(bh);
@@ -102,6 +100,8 @@ int nilfs_gccache_submit_read_data(struct inode *inode, sector_t blkoff,
  failed:
 	unlock_page(bh->b_page);
 	put_page(bh->b_page);
+	if (unlikely(err))
+		brelse(bh);
 	return err;
 }
 
diff --git a/include/linux/if_team.h b/include/linux/if_team.h
index ac42da56f7a2..fd32538ae705 100644
--- a/include/linux/if_team.h
+++ b/include/linux/if_team.h
@@ -196,6 +196,8 @@ struct team {
 	struct net_device *dev; /* associated netdevice */
 	struct team_pcpu_stats __percpu *pcpu_stats;
 
+	const struct header_ops *header_ops_cache;
+
 	struct mutex lock; /* used for overall locking, e.g. port lists write */
 
 	/*
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 73cd0182452c..361a52e418f7 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -278,6 +278,10 @@ enum {
 	ATA_HOST_PARALLEL_SCAN	= (1 << 2),	/* Ports on this host can be scanned in parallel */
 	ATA_HOST_IGNORE_ATA	= (1 << 3),	/* Ignore ATA devices on this host. */
 
+	ATA_HOST_NO_PART	= (1 << 4), /* Host does not support partial */
+	ATA_HOST_NO_SSC		= (1 << 5), /* Host does not support slumber */
+	ATA_HOST_NO_DEVSLP	= (1 << 6), /* Host does not support devslp */
+
 	/* bits 24:31 of host->flags are reserved for LLD specific flags */
 
 	/* various lengths of time */
@@ -311,7 +315,7 @@ enum {
 	 * advised to wait only for the following duration before
 	 * doing SRST.
 	 */
-	ATA_TMOUT_PMP_SRST_WAIT	= 5000,
+	ATA_TMOUT_PMP_SRST_WAIT	= 10000,
 
 	/* When the LPM policy is set to ATA_LPM_MAX_POWER, there might
 	 * be a spurious PHY event, so ignore the first PHY event that
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7e9df3854420..e977118111f6 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -162,31 +162,38 @@ static inline bool dev_xmit_complete(int rc)
  *	(unsigned long) so they can be read and written atomically.
  */
 
+#define NET_DEV_STAT(FIELD)			\
+	union {					\
+		unsigned long FIELD;		\
+		atomic_long_t __##FIELD;	\
+	}
+
 struct net_device_stats {
-	unsigned long	rx_packets;
-	unsigned long	tx_packets;
-	unsigned long	rx_bytes;
-	unsigned long	tx_bytes;
-	unsigned long	rx_errors;
-	unsigned long	tx_errors;
-	unsigned long	rx_dropped;
-	unsigned long	tx_dropped;
-	unsigned long	multicast;
-	unsigned long	collisions;
-	unsigned long	rx_length_errors;
-	unsigned long	rx_over_errors;
-	unsigned long	rx_crc_errors;
-	unsigned long	rx_frame_errors;
-	unsigned long	rx_fifo_errors;
-	unsigned long	rx_missed_errors;
-	unsigned long	tx_aborted_errors;
-	unsigned long	tx_carrier_errors;
-	unsigned long	tx_fifo_errors;
-	unsigned long	tx_heartbeat_errors;
-	unsigned long	tx_window_errors;
-	unsigned long	rx_compressed;
-	unsigned long	tx_compressed;
+	NET_DEV_STAT(rx_packets);
+	NET_DEV_STAT(tx_packets);
+	NET_DEV_STAT(rx_bytes);
+	NET_DEV_STAT(tx_bytes);
+	NET_DEV_STAT(rx_errors);
+	NET_DEV_STAT(tx_errors);
+	NET_DEV_STAT(rx_dropped);
+	NET_DEV_STAT(tx_dropped);
+	NET_DEV_STAT(multicast);
+	NET_DEV_STAT(collisions);
+	NET_DEV_STAT(rx_length_errors);
+	NET_DEV_STAT(rx_over_errors);
+	NET_DEV_STAT(rx_crc_errors);
+	NET_DEV_STAT(rx_frame_errors);
+	NET_DEV_STAT(rx_fifo_errors);
+	NET_DEV_STAT(rx_missed_errors);
+	NET_DEV_STAT(tx_aborted_errors);
+	NET_DEV_STAT(tx_carrier_errors);
+	NET_DEV_STAT(tx_fifo_errors);
+	NET_DEV_STAT(tx_heartbeat_errors);
+	NET_DEV_STAT(tx_window_errors);
+	NET_DEV_STAT(rx_compressed);
+	NET_DEV_STAT(tx_compressed);
 };
+#undef NET_DEV_STAT
 
 
 #include <linux/cache.h>
@@ -4842,4 +4849,9 @@ do {								\
 #define PTYPE_HASH_SIZE	(16)
 #define PTYPE_HASH_MASK	(PTYPE_HASH_SIZE - 1)
 
+/* Note: Avoid these macros in fast path, prefer per-cpu or per-queue counters. */
+#define DEV_STATS_INC(DEV, FIELD) atomic_long_inc(&(DEV)->stats.__##FIELD)
+#define DEV_STATS_ADD(DEV, FIELD, VAL) 	\
+		atomic_long_add((VAL), &(DEV)->stats.__##FIELD)
+
 #endif	/* _LINUX_NETDEVICE_H */
diff --git a/include/net/dst.h b/include/net/dst.h
index 50258a813137..97267997601f 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -362,9 +362,8 @@ static inline void __skb_tunnel_rx(struct sk_buff *skb, struct net_device *dev,
 static inline void skb_tunnel_rx(struct sk_buff *skb, struct net_device *dev,
 				 struct net *net)
 {
-	/* TODO : stats should be SMP safe */
-	dev->stats.rx_packets++;
-	dev->stats.rx_bytes += skb->len;
+	DEV_STATS_INC(dev, rx_packets);
+	DEV_STATS_ADD(dev, rx_bytes, skb->len);
 	__skb_tunnel_rx(skb, dev, net);
 }
 
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 9c43299ff870..427553adf82c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -346,12 +346,14 @@ ssize_t tcp_splice_read(struct socket *sk, loff_t *ppos,
 			struct pipe_inode_info *pipe, size_t len,
 			unsigned int flags);
 
-static inline void tcp_dec_quickack_mode(struct sock *sk,
-					 const unsigned int pkts)
+static inline void tcp_dec_quickack_mode(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
 	if (icsk->icsk_ack.quick) {
+		/* How many ACKs S/ACKing new data have we sent? */
+		const unsigned int pkts = inet_csk_ack_scheduled(sk) ? 1 : 0;
+
 		if (pkts >= icsk->icsk_ack.quick) {
 			icsk->icsk_ack.quick = 0;
 			/* Leaving quickack mode we deflate ATO. */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6334aede67fc..91c43f375612 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -693,7 +693,9 @@ union bpf_attr {
  * 		performed again, if the helper is used in combination with
  * 		direct packet access.
  * 	Return
- * 		0 on success, or a negative error in case of failure.
+ * 		0 on success, or a negative error in case of failure. Positive
+ * 		error indicates a potential drop or congestion in the target
+ * 		device. The particular positive error codes are not defined.
  *
  * u64 bpf_get_current_pid_tgid(void)
  * 	Return
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c8a7de7a1d63..320aa60664dc 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1753,6 +1753,8 @@ int ring_buffer_resize(struct ring_buffer *buffer, unsigned long size,
 				err = -ENOMEM;
 				goto out_err;
 			}
+
+			cond_resched();
 		}
 
 		get_online_cpus();
diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 48ddc60b4fbd..c07a47d65c39 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -122,7 +122,7 @@ static int deliver_clone(const struct net_bridge_port *prev,
 
 	skb = skb_clone(skb, GFP_ATOMIC);
 	if (!skb) {
-		dev->stats.tx_dropped++;
+		DEV_STATS_INC(dev, tx_dropped);
 		return -ENOMEM;
 	}
 
@@ -261,7 +261,7 @@ static void maybe_deliver_addr(struct net_bridge_port *p, struct sk_buff *skb,
 
 	skb = skb_copy(skb, GFP_ATOMIC);
 	if (!skb) {
-		dev->stats.tx_dropped++;
+		DEV_STATS_INC(dev, tx_dropped);
 		return;
 	}
 
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 14c2fdc268ea..f3938337ff87 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -146,12 +146,12 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 			if ((mdst && mdst->host_joined) ||
 			    br_multicast_is_router(br)) {
 				local_rcv = true;
-				br->dev->stats.multicast++;
+				DEV_STATS_INC(br->dev, multicast);
 			}
 			mcast_hit = true;
 		} else {
 			local_rcv = true;
-			br->dev->stats.multicast++;
+			DEV_STATS_INC(br->dev, multicast);
 		}
 		break;
 	case BR_PKT_UNICAST:
diff --git a/net/core/dev.c b/net/core/dev.c
index a9c8660a2570..0f9214fb36e0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9035,24 +9035,16 @@ void netdev_run_todo(void)
 void netdev_stats_to_stats64(struct rtnl_link_stats64 *stats64,
 			     const struct net_device_stats *netdev_stats)
 {
-#if BITS_PER_LONG == 64
-	BUILD_BUG_ON(sizeof(*stats64) < sizeof(*netdev_stats));
-	memcpy(stats64, netdev_stats, sizeof(*netdev_stats));
-	/* zero out counters that only exist in rtnl_link_stats64 */
-	memset((char *)stats64 + sizeof(*netdev_stats), 0,
-	       sizeof(*stats64) - sizeof(*netdev_stats));
-#else
-	size_t i, n = sizeof(*netdev_stats) / sizeof(unsigned long);
-	const unsigned long *src = (const unsigned long *)netdev_stats;
+	size_t i, n = sizeof(*netdev_stats) / sizeof(atomic_long_t);
+	const atomic_long_t *src = (atomic_long_t *)netdev_stats;
 	u64 *dst = (u64 *)stats64;
 
 	BUILD_BUG_ON(n > sizeof(*stats64) / sizeof(u64));
 	for (i = 0; i < n; i++)
-		dst[i] = src[i];
+		dst[i] = (unsigned long)atomic_long_read(&src[i]);
 	/* zero out counters that only exist in rtnl_link_stats64 */
 	memset((char *)stats64 + n * sizeof(u64), 0,
 	       sizeof(*stats64) - n * sizeof(u64));
-#endif
 }
 EXPORT_SYMBOL(netdev_stats_to_stats64);
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 794db633f1c9..0d3f724da78b 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2702,10 +2702,7 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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
@@ -2973,9 +2970,12 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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
index 57e2316529d0..9753d07bfc0b 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1215,6 +1215,7 @@ static struct dst_entry *ipv4_dst_check(struct dst_entry *dst, u32 cookie)
 
 static void ipv4_send_dest_unreach(struct sk_buff *skb)
 {
+	struct net_device *dev;
 	struct ip_options opt;
 	int res;
 
@@ -1232,7 +1233,8 @@ static void ipv4_send_dest_unreach(struct sk_buff *skb)
 		opt.optlen = ip_hdr(skb)->ihl * 4 - sizeof(struct iphdr);
 
 		rcu_read_lock();
-		res = __ip_options_compile(dev_net(skb->dev), &opt, skb, NULL);
+		dev = skb->dev ? skb->dev : skb_rtable(skb)->dst.dev;
+		res = __ip_options_compile(dev_net(dev), &opt, skb, NULL);
 		rcu_read_unlock();
 
 		if (res)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 9e1ec69fe5b4..0052a6194cc1 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -172,6 +172,19 @@ static void tcp_measure_rcv_mss(struct sock *sk, const struct sk_buff *skb)
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
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 9299de0da351..dcca9554071d 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -164,8 +164,7 @@ static void tcp_event_data_sent(struct tcp_sock *tp,
 }
 
 /* Account for an ACK we sent. */
-static inline void tcp_event_ack_sent(struct sock *sk, unsigned int pkts,
-				      u32 rcv_nxt)
+static inline void tcp_event_ack_sent(struct sock *sk, u32 rcv_nxt)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
@@ -179,7 +178,7 @@ static inline void tcp_event_ack_sent(struct sock *sk, unsigned int pkts,
 
 	if (unlikely(rcv_nxt != tp->rcv_nxt))
 		return;  /* Special ACK sent by DCTCP to reflect ECN */
-	tcp_dec_quickack_mode(sk, pkts);
+	tcp_dec_quickack_mode(sk);
 	inet_csk_clear_xmit_timer(sk, ICSK_TIME_DACK);
 }
 
@@ -1139,7 +1138,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 	icsk->icsk_af_ops->send_check(sk, skb);
 
 	if (likely(tcb->tcp_flags & TCPHDR_ACK))
-		tcp_event_ack_sent(sk, tcp_skb_pcount(skb), rcv_nxt);
+		tcp_event_ack_sent(sk, rcv_nxt);
 
 	if (skb->len != tcp_header_size) {
 		tcp_event_data_sent(tp, sk);
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index f3f0b4b7c386..7342344d99a9 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -525,7 +525,6 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	 */
 	if (len > INT_MAX - transhdrlen)
 		return -EMSGSIZE;
-	ulen = len + transhdrlen;
 
 	/* Mirror BSD error message compatibility */
 	if (msg->msg_flags & MSG_OOB)
@@ -649,6 +648,7 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 back_from_confirm:
 	lock_sock(sk);
+	ulen = len + skb_queue_empty(&sk->sk_write_queue) ? transhdrlen : 0;
 	err = ip6_append_data(sk, ip_generic_getfrag, msg,
 			      ulen, transhdrlen, &ipc6,
 			      &fl6, (struct rt6_info *)dst,
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index f6af13c16cf5..e0a4f59a68a2 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1510,8 +1510,8 @@ static int make_send_sock(struct netns_ipvs *ipvs, int id,
 	}
 
 	get_mcast_sockaddr(&mcast_addr, &salen, &ipvs->mcfg, id);
-	result = sock->ops->connect(sock, (struct sockaddr *) &mcast_addr,
-				    salen, 0);
+	result = kernel_connect(sock, (struct sockaddr *)&mcast_addr,
+				salen, 0);
 	if (result < 0) {
 		pr_err("Error connecting to the multicast addr\n");
 		goto error;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 0ff8f1006c6b..3e3044116289 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -993,8 +993,7 @@ static int nft_flush_table(struct nft_ctx *ctx)
 		if (!nft_is_active_next(ctx->net, set))
 			continue;
 
-		if (nft_set_is_anonymous(set) &&
-		    !list_empty(&set->bindings))
+		if (nft_set_is_anonymous(set))
 			continue;
 
 		err = nft_delset(ctx, set);
@@ -4902,8 +4901,10 @@ static int nf_tables_delsetelem(struct net *net, struct sock *nlsk,
 	if (IS_ERR(set))
 		return PTR_ERR(set);
 
-	if (!list_empty(&set->bindings) &&
-	    (set->flags & (NFT_SET_CONSTANT | NFT_SET_ANONYMOUS)))
+	if (nft_set_is_anonymous(set))
+		return -EOPNOTSUPP;
+
+	if (!list_empty(&set->bindings) && (set->flags & NFT_SET_CONSTANT))
 		return -EBUSY;
 
 	if (nla[NFTA_SET_ELEM_LIST_ELEMENTS] == NULL) {
diff --git a/net/rds/tcp_connect.c b/net/rds/tcp_connect.c
index 008f50fb25dd..23d6d2612708 100644
--- a/net/rds/tcp_connect.c
+++ b/net/rds/tcp_connect.c
@@ -169,7 +169,7 @@ int rds_tcp_conn_path_connect(struct rds_conn_path *cp)
 	 * own the socket
 	 */
 	rds_tcp_set_callbacks(sock, cp);
-	ret = sock->ops->connect(sock, addr, addrlen, O_NONBLOCK);
+	ret = kernel_connect(sock, addr, addrlen, O_NONBLOCK);
 
 	rdsdebug("connect to address %pI6c returned %d\n", &conn->c_faddr, ret);
 	if (ret == -EINPROGRESS)
diff --git a/net/sctp/associola.c b/net/sctp/associola.c
index d17708800652..78c1429d1301 100644
--- a/net/sctp/associola.c
+++ b/net/sctp/associola.c
@@ -1181,8 +1181,7 @@ int sctp_assoc_update(struct sctp_association *asoc,
 		/* Add any peer addresses from the new association. */
 		list_for_each_entry(trans, &new->peer.transport_addr_list,
 				    transports)
-			if (!sctp_assoc_lookup_paddr(asoc, &trans->ipaddr) &&
-			    !sctp_assoc_add_peer(asoc, &trans->ipaddr,
+			if (!sctp_assoc_add_peer(asoc, &trans->ipaddr,
 						 GFP_ATOMIC, trans->state))
 				return -ENOMEM;
 
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 432dccd37506..f954d3c8876d 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -2578,6 +2578,7 @@ static int sctp_apply_peer_addr_params(struct sctp_paddrparams *params,
 			if (trans) {
 				trans->hbinterval =
 				    msecs_to_jiffies(params->spp_hbinterval);
+				sctp_transport_reset_hb_timer(trans);
 			} else if (asoc) {
 				asoc->hbinterval =
 				    msecs_to_jiffies(params->spp_hbinterval);
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 7f40b6aab689..90868df7865e 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1395,7 +1395,7 @@ void handle_moddevtable(struct module *mod, struct elf_info *info,
 	/* First handle the "special" cases */
 	if (sym_is(name, namelen, "usb"))
 		do_usb_table(symval, sym->st_size, mod);
-	if (sym_is(name, namelen, "of"))
+	else if (sym_is(name, namelen, "of"))
 		do_of_table(symval, sym->st_size, mod);
 	else if (sym_is(name, namelen, "pnp"))
 		do_pnp_device_entry(symval, sym->st_size, mod);
diff --git a/security/smack/smack.h b/security/smack/smack.h
index f7db791fb566..62aa4bc25426 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -120,6 +120,7 @@ struct inode_smack {
 struct task_smack {
 	struct smack_known	*smk_task;	/* label for access control */
 	struct smack_known	*smk_forked;	/* label when forked */
+	struct smack_known	*smk_transmuted;/* label when transmuted */
 	struct list_head	smk_rules;	/* per task access rules */
 	struct mutex		smk_rules_lock;	/* lock for the rules */
 	struct list_head	smk_relabel;	/* transit allowed labels */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 4f65d953fe31..266eb8ca3381 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1032,8 +1032,9 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, const char **name,
 				     void **value, size_t *len)
 {
+	struct task_smack *tsp = current_security();
 	struct inode_smack *issp = inode->i_security;
-	struct smack_known *skp = smk_of_current();
+	struct smack_known *skp = smk_of_task(tsp);
 	struct smack_known *isp = smk_of_inode(inode);
 	struct smack_known *dsp = smk_of_inode(dir);
 	int may;
@@ -1042,20 +1043,34 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 		*name = XATTR_SMACK_SUFFIX;
 
 	if (value && len) {
-		rcu_read_lock();
-		may = smk_access_entry(skp->smk_known, dsp->smk_known,
-				       &skp->smk_rules);
-		rcu_read_unlock();
+		/*
+		 * If equal, transmuting already occurred in
+		 * smack_dentry_create_files_as(). No need to check again.
+		 */
+		if (tsp->smk_task != tsp->smk_transmuted) {
+			rcu_read_lock();
+			may = smk_access_entry(skp->smk_known, dsp->smk_known,
+					       &skp->smk_rules);
+			rcu_read_unlock();
+		}
 
 		/*
-		 * If the access rule allows transmutation and
-		 * the directory requests transmutation then
-		 * by all means transmute.
+		 * In addition to having smk_task equal to smk_transmuted,
+		 * if the access rule allows transmutation and the directory
+		 * requests transmutation then by all means transmute.
 		 * Mark the inode as changed.
 		 */
-		if (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
-		    smk_inode_transmutable(dir)) {
-			isp = dsp;
+		if ((tsp->smk_task == tsp->smk_transmuted) ||
+		    (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
+		     smk_inode_transmutable(dir))) {
+			/*
+			 * The caller of smack_dentry_create_files_as()
+			 * should have overridden the current cred, so the
+			 * inode label was already set correctly in
+			 * smack_inode_alloc_security().
+			 */
+			if (tsp->smk_task != tsp->smk_transmuted)
+				isp = dsp;
 			issp->smk_flags |= SMK_INODE_CHANGED;
 		}
 
@@ -1490,10 +1505,19 @@ static int smack_inode_getsecurity(struct inode *inode,
 	struct super_block *sbp;
 	struct inode *ip = (struct inode *)inode;
 	struct smack_known *isp;
+	struct inode_smack *ispp;
+	size_t label_len;
+	char *label = NULL;
 
-	if (strcmp(name, XATTR_SMACK_SUFFIX) == 0)
+	if (strcmp(name, XATTR_SMACK_SUFFIX) == 0) {
 		isp = smk_of_inode(inode);
-	else {
+	} else if (strcmp(name, XATTR_SMACK_TRANSMUTE) == 0) {
+		ispp = inode->i_security;
+		if (ispp->smk_flags & SMK_INODE_TRANSMUTE)
+			label = TRANS_TRUE;
+		else
+			label = "";
+	} else {
 		/*
 		 * The rest of the Smack xattrs are only on sockets.
 		 */
@@ -1515,13 +1539,18 @@ static int smack_inode_getsecurity(struct inode *inode,
 			return -EOPNOTSUPP;
 	}
 
+	if (!label)
+		label = isp->smk_known;
+
+	label_len = strlen(label);
+
 	if (alloc) {
-		*buffer = kstrdup(isp->smk_known, GFP_KERNEL);
+		*buffer = kstrdup(label, GFP_KERNEL);
 		if (*buffer == NULL)
 			return -ENOMEM;
 	}
 
-	return strlen(isp->smk_known);
+	return label_len;
 }
 
 
@@ -4612,7 +4641,7 @@ static int smack_inode_copy_up(struct dentry *dentry, struct cred **new)
 	/*
 	 * Get label from overlay inode and set it in create_sid
 	 */
-	isp = d_inode(dentry->d_parent)->i_security;
+	isp = d_inode(dentry)->i_security;
 	skp = isp->smk_inode;
 	tsp->smk_task = skp;
 	*new = new_creds;
@@ -4663,8 +4692,10 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
 		 * providing access is transmuting use the containing
 		 * directory label instead of the process label.
 		 */
-		if (may > 0 && (may & MAY_TRANSMUTE))
+		if (may > 0 && (may & MAY_TRANSMUTE)) {
 			ntsp->smk_task = isp->smk_inode;
+			ntsp->smk_transmuted = ntsp->smk_task;
+		}
 	}
 	return 0;
 }
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 40d596248fab..aaca36250dda 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2364,6 +2364,7 @@ static struct snd_pci_quirk power_save_blacklist[] = {
 	SND_PCI_QUIRK(0x8086, 0x2068, "Intel NUC7i3BNB", 0),
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=198611 */
 	SND_PCI_QUIRK(0x17aa, 0x2227, "Lenovo X1 Carbon 3rd Gen", 0),
+	SND_PCI_QUIRK(0x17aa, 0x316e, "Lenovo ThinkCentre M70q", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1689623 */
 	SND_PCI_QUIRK(0x17aa, 0x367b, "Lenovo IdeaCentre B550", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1572975 */
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 0c30ab898e2a..37259bae1501 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -691,7 +691,9 @@ union bpf_attr {
  * 		performed again, if the helper is used in combination with
  * 		direct packet access.
  * 	Return
- * 		0 on success, or a negative error in case of failure.
+ * 		0 on success, or a negative error in case of failure. Positive
+ * 		error indicates a potential drop or congestion in the target
+ * 		device. The particular positive error codes are not defined.
  *
  * u64 bpf_get_current_pid_tgid(void)
  * 	Return
diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 1dd5f4fcffd5..392906c8d3a6 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -278,14 +278,14 @@ clean:
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
 
@@ -299,14 +299,14 @@ install-man:
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
index 4fa0f79144f4..9473934a573a 100644
--- a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
+++ b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
@@ -43,7 +43,7 @@ instance_read() {
 
 instance_set() {
         while :; do
-                echo 1 > foo/events/sched/sched_switch
+                echo 1 > foo/events/sched/sched_switch/enable
         done 2> /dev/null
 }
 
diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 7549d39ccaff..92adfe4df4e6 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -199,11 +199,12 @@ TEST_F(tls, sendmsg_large)
 
 		msg.msg_iov = &vec;
 		msg.msg_iovlen = 1;
-		EXPECT_EQ(sendmsg(self->cfd, &msg, 0), send_len);
+		EXPECT_EQ(sendmsg(self->fd, &msg, 0), send_len);
 	}
 
-	while (recvs++ < sends)
-		EXPECT_NE(recv(self->fd, mem, send_len, 0), -1);
+	while (recvs++ < sends) {
+		EXPECT_NE(recv(self->cfd, mem, send_len, 0), -1);
+	}
 
 	free(mem);
 }
@@ -231,9 +232,9 @@ TEST_F(tls, sendmsg_multiple)
 	msg.msg_iov = vec;
 	msg.msg_iovlen = iov_len;
 
-	EXPECT_EQ(sendmsg(self->cfd, &msg, 0), total_len);
+	EXPECT_EQ(sendmsg(self->fd, &msg, 0), total_len);
 	buf = malloc(total_len);
-	EXPECT_NE(recv(self->fd, buf, total_len, 0), -1);
+	EXPECT_NE(recv(self->cfd, buf, total_len, 0), -1);
 	for (i = 0; i < iov_len; i++) {
 		EXPECT_EQ(memcmp(test_strs[i], buf + len_cmp,
 				 strlen(test_strs[i])),
