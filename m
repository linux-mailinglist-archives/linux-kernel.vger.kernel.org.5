Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058B27C40A7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343770AbjJJUFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbjJJUEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:04:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616F3115;
        Tue, 10 Oct 2023 13:04:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB82C433BD;
        Tue, 10 Oct 2023 20:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696968245;
        bh=RM0s66sTCq/seyyEREBH8SE1PlDq1QhWKAqf6/tZ38g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xWOODn0UABVrMFARdPXha/PuRzFgULK46Ph2vD+ZsPiEh7k3gEBo2DtiSkOn5SbUW
         xBZhvOdQaN4P+y8MKkyT5GKKeESqEOOit5X/S/WTjmxZLTzxymkXgkyymAjQFBsNm1
         OdAvUwKEOSBc3CuBADFIGwuqdAHoIJfmZUhNso+A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.4.258
Date:   Tue, 10 Oct 2023 22:03:52 +0200
Message-ID: <2023101052-railcar-fragment-ec41@gregkh>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <2023101052-drearily-scrabble-c5d4@gregkh>
References: <2023101052-drearily-scrabble-c5d4@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 94e29594a356..10e57b85abee 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 4
-SUBLEVEL = 257
+SUBLEVEL = 258
 EXTRAVERSION =
 NAME = Kleptomaniac Octopus
 
diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
index a40fe8d49da6..f5dbc241aaf7 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -656,12 +656,12 @@
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
index 50de86eb8784..3183df60ad33 100644
--- a/arch/mips/alchemy/devboards/db1000.c
+++ b/arch/mips/alchemy/devboards/db1000.c
@@ -164,6 +164,7 @@ static struct platform_device db1x00_audio_dev = {
 
 /******************************************************************************/
 
+#ifdef CONFIG_MMC_AU1X
 static irqreturn_t db1100_mmc_cd(int irq, void *ptr)
 {
 	mmc_detect_change(ptr, msecs_to_jiffies(500));
@@ -369,6 +370,7 @@ static struct platform_device db1100_mmc1_dev = {
 	.num_resources	= ARRAY_SIZE(au1100_mmc1_res),
 	.resource	= au1100_mmc1_res,
 };
+#endif /* CONFIG_MMC_AU1X */
 
 /******************************************************************************/
 
@@ -432,8 +434,10 @@ static struct platform_device *db1x00_devs[] = {
 
 static struct platform_device *db1100_devs[] = {
 	&au1100_lcd_device,
+#ifdef CONFIG_MMC_AU1X
 	&db1100_mmc0_dev,
 	&db1100_mmc1_dev,
+#endif
 };
 
 int __init db1000_dev_setup(void)
diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
index b70e2cf8a27b..414f92eacb5e 100644
--- a/arch/mips/alchemy/devboards/db1200.c
+++ b/arch/mips/alchemy/devboards/db1200.c
@@ -326,6 +326,7 @@ static struct platform_device db1200_ide_dev = {
 
 /**********************************************************************/
 
+#ifdef CONFIG_MMC_AU1X
 /* SD carddetects:  they're supposed to be edge-triggered, but ack
  * doesn't seem to work (CPLD Rev 2).  Instead, the screaming one
  * is disabled and its counterpart enabled.  The 200ms timeout is
@@ -584,6 +585,7 @@ static struct platform_device pb1200_mmc1_dev = {
 	.num_resources	= ARRAY_SIZE(au1200_mmc1_res),
 	.resource	= au1200_mmc1_res,
 };
+#endif /* CONFIG_MMC_AU1X */
 
 /**********************************************************************/
 
@@ -751,7 +753,9 @@ static struct platform_device db1200_audiodma_dev = {
 static struct platform_device *db1200_devs[] __initdata = {
 	NULL,		/* PSC0, selected by S6.8 */
 	&db1200_ide_dev,
+#ifdef CONFIG_MMC_AU1X
 	&db1200_mmc0_dev,
+#endif
 	&au1200_lcd_dev,
 	&db1200_eth_dev,
 	&db1200_nand_dev,
@@ -762,7 +766,9 @@ static struct platform_device *db1200_devs[] __initdata = {
 };
 
 static struct platform_device *pb1200_devs[] __initdata = {
+#ifdef CONFIG_MMC_AU1X
 	&pb1200_mmc1_dev,
+#endif
 };
 
 /* Some peripheral base addresses differ on the PB1200 */
diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
index 6f16543c16fc..fcfefa48d260 100644
--- a/arch/mips/alchemy/devboards/db1300.c
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -450,6 +450,7 @@ static struct platform_device db1300_ide_dev = {
 
 /**********************************************************************/
 
+#ifdef CONFIG_MMC_AU1X
 static irqreturn_t db1300_mmc_cd(int irq, void *ptr)
 {
 	disable_irq_nosync(irq);
@@ -632,6 +633,7 @@ static struct platform_device db1300_sd0_dev = {
 	.resource	= au1300_sd0_res,
 	.num_resources	= ARRAY_SIZE(au1300_sd0_res),
 };
+#endif /* CONFIG_MMC_AU1X */
 
 /**********************************************************************/
 
@@ -769,8 +771,10 @@ static struct platform_device *db1300_dev[] __initdata = {
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
index e080143e79a3..b432a67c793c 100644
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
index a1476673062e..f1d494931328 100644
--- a/arch/parisc/kernel/drivers.c
+++ b/arch/parisc/kernel/drivers.c
@@ -924,9 +924,9 @@ static __init void qemu_header(void)
 	pr_info("#define PARISC_MODEL \"%s\"\n\n",
 			boot_cpu_data.pdc.sys_model_name);
 
+	#define p ((unsigned long *)&boot_cpu_data.pdc.model)
 	pr_info("#define PARISC_PDC_MODEL 0x%lx, 0x%lx, 0x%lx, "
 		"0x%lx, 0x%lx, 0x%lx, 0x%lx, 0x%lx, 0x%lx\n\n",
-	#define p ((unsigned long *)&boot_cpu_data.pdc.model)
 		p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8]);
 	#undef p
 
diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
index 4d54aa70ea5f..b4aa5af943ba 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -388,7 +388,7 @@ union irq_stack_union {
 	volatile unsigned int lock[1];
 };
 
-DEFINE_PER_CPU(union irq_stack_union, irq_stack_union) = {
+static DEFINE_PER_CPU(union irq_stack_union, irq_stack_union) = {
 		.slock = { 1,1,1,1 },
 	};
 #endif
diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 1007ec36b4cb..fb736fdb4193 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -247,6 +247,11 @@ static bool stepping_handler(struct pt_regs *regs, struct perf_event *bp,
 	return false;
 }
 
+/*
+ * Handle a DABR or DAWR exception.
+ *
+ * Called in atomic context.
+ */
 int hw_breakpoint_handler(struct die_args *args)
 {
 	int rc = NOTIFY_STOP;
@@ -315,6 +320,8 @@ NOKPROBE_SYMBOL(hw_breakpoint_handler);
 
 /*
  * Handle single-step exceptions following a DABR hit.
+ *
+ * Called in atomic context.
  */
 static int single_step_dabr_instruction(struct die_args *args)
 {
@@ -355,6 +362,8 @@ NOKPROBE_SYMBOL(single_step_dabr_instruction);
 
 /*
  * Handle debug exception notifications.
+ *
+ * Called in atomic context.
  */
 int hw_breakpoint_exceptions_notify(
 		struct notifier_block *unused, unsigned long val, void *data)
diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 48e8f4b17b91..c5c7a30bd0fd 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -1313,7 +1313,7 @@ static int h_24x7_event_init(struct perf_event *event)
 	}
 
 	domain = event_get_domain(event);
-	if (domain >= HV_PERF_DOMAIN_MAX) {
+	if (domain  == 0 || domain >= HV_PERF_DOMAIN_MAX) {
 		pr_devel("invalid domain %d\n", domain);
 		return -EINVAL;
 	}
diff --git a/arch/xtensa/boot/Makefile b/arch/xtensa/boot/Makefile
index 294846117fc2..41ad60bb0fbc 100644
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
 
diff --git a/arch/xtensa/include/asm/core.h b/arch/xtensa/include/asm/core.h
index 5975b244b7b8..02c93e08d592 100644
--- a/arch/xtensa/include/asm/core.h
+++ b/arch/xtensa/include/asm/core.h
@@ -6,6 +6,10 @@
 
 #include <variant/core.h>
 
+#ifndef XCHAL_HAVE_DIV32
+#define XCHAL_HAVE_DIV32 0
+#endif
+
 #ifndef XCHAL_HAVE_EXCLUSIVE
 #define XCHAL_HAVE_EXCLUSIVE 0
 #endif
diff --git a/arch/xtensa/platforms/iss/network.c b/arch/xtensa/platforms/iss/network.c
index cbca91bb5334..d54bcaa194d4 100644
--- a/arch/xtensa/platforms/iss/network.c
+++ b/arch/xtensa/platforms/iss/network.c
@@ -204,7 +204,7 @@ static int tuntap_write(struct iss_net_private *lp, struct sk_buff **skb)
 	return simc_write(lp->tp.info.tuntap.fd, (*skb)->data, (*skb)->len);
 }
 
-unsigned short tuntap_protocol(struct sk_buff *skb)
+static unsigned short tuntap_protocol(struct sk_buff *skb)
 {
 	return eth_type_trans(skb, skb->dev);
 }
@@ -477,7 +477,7 @@ static int iss_net_change_mtu(struct net_device *dev, int new_mtu)
 	return -EINVAL;
 }
 
-void iss_net_user_timer_expire(struct timer_list *unused)
+static void iss_net_user_timer_expire(struct timer_list *unused)
 {
 }
 
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 4069c2a79daa..aa35d1941d1f 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1838,6 +1838,15 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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
 
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index fec2e9754aed..61b5ba8dc1d2 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1199,6 +1199,26 @@ static ssize_t ahci_activity_show(struct ata_device *dev, char *buf)
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
@@ -1213,18 +1233,7 @@ static void ahci_port_init(struct device *dev, struct ata_port *ap,
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
@@ -1554,6 +1563,8 @@ int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
 	tf.command = ATA_BUSY;
 	ata_tf_to_fis(&tf, 0, 0, d2h_fis);
 
+	ahci_port_clear_pending_irq(ap);
+
 	rc = sata_link_hardreset(link, timing, deadline, online,
 				 ahci_check_ready);
 
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c06f618b1aa3..e2cf9859c67b 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3981,10 +3981,23 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
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
@@ -5738,17 +5751,19 @@ static void ata_port_request_pm(struct ata_port *ap, pm_message_t mesg,
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
@@ -5760,10 +5775,8 @@ static void ata_port_request_pm(struct ata_port *ap, pm_message_t mesg,
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
-	if (!async) {
+	if (!async)
 		ata_port_wait_eh(ap);
-		WARN_ON(ap->pflags & ATA_PFLAG_PM_PENDING);
-	}
 }
 
 /*
@@ -5929,7 +5942,7 @@ void ata_host_resume(struct ata_host *host)
 #endif
 
 const struct device_type ata_port_type = {
-	.name = "ata_port",
+	.name = ATA_PORT_TYPE_NAME,
 #ifdef CONFIG_PM
 	.pm = &ata_port_pm_ops,
 #endif
@@ -6732,11 +6745,30 @@ static void ata_port_detach(struct ata_port *ap)
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
index 5c91183b5b73..54b6ec44d3be 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2901,18 +2901,11 @@ int ata_eh_reset(struct ata_link *link, int classify,
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
index 42309ceee21e..c621c98c6057 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4544,7 +4544,7 @@ void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
 		break;
 
 	case MAINTENANCE_IN:
-		if (scsicmd[1] == MI_REPORT_SUPPORTED_OPERATION_CODES)
+		if ((scsicmd[1] & 0x1f) == MI_REPORT_SUPPORTED_OPERATION_CODES)
 			ata_scsi_rbuf_fill(&args, ata_scsiop_maint_in);
 		else
 			ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 1069cda6ff36..9e49dab8dc78 100644
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
index cd8090ad43e5..562635c58d31 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -30,6 +30,8 @@ enum {
 	ATA_DNXFER_QUIET	= (1 << 31),
 };
 
+#define ATA_PORT_TYPE_NAME	"ata_port"
+
 extern atomic_t ata_print_id;
 extern int atapi_passthru16;
 extern int libata_fua;
diff --git a/drivers/base/regmap/regcache-rbtree.c b/drivers/base/regmap/regcache-rbtree.c
index ae6b8788d5f3..d65715b9e129 100644
--- a/drivers/base/regmap/regcache-rbtree.c
+++ b/drivers/base/regmap/regcache-rbtree.c
@@ -453,7 +453,8 @@ static int regcache_rbtree_write(struct regmap *map, unsigned int reg,
 		if (!rbnode)
 			return -ENOMEM;
 		regcache_rbtree_set_register(map, rbnode,
-					     reg - rbnode->base_reg, value);
+					     (reg - rbnode->base_reg) / map->reg_stride,
+					     value);
 		regcache_rbtree_insert(map, &rbtree_ctx->root, rbnode);
 		rbtree_ctx->cached_rbnode = rbnode;
 	}
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 9d21f90f93f0..7117fa490243 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -626,9 +626,8 @@ void rbd_warn(struct rbd_device *rbd_dev, const char *fmt, ...)
 static void rbd_dev_remove_parent(struct rbd_device *rbd_dev);
 
 static int rbd_dev_refresh(struct rbd_device *rbd_dev);
-static int rbd_dev_v2_header_onetime(struct rbd_device *rbd_dev);
-static int rbd_dev_header_info(struct rbd_device *rbd_dev);
-static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev);
+static int rbd_dev_v2_header_onetime(struct rbd_device *rbd_dev,
+				     struct rbd_image_header *header);
 static const char *rbd_dev_v2_snap_name(struct rbd_device *rbd_dev,
 					u64 snap_id);
 static int _rbd_dev_v2_snap_size(struct rbd_device *rbd_dev, u64 snap_id,
@@ -1098,15 +1097,24 @@ static void rbd_init_layout(struct rbd_device *rbd_dev)
 	RCU_INIT_POINTER(rbd_dev->layout.pool_ns, NULL);
 }
 
+static void rbd_image_header_cleanup(struct rbd_image_header *header)
+{
+	kfree(header->object_prefix);
+	ceph_put_snap_context(header->snapc);
+	kfree(header->snap_sizes);
+	kfree(header->snap_names);
+
+	memset(header, 0, sizeof(*header));
+}
+
 /*
  * Fill an rbd image header with information from the given format 1
  * on-disk header.
  */
-static int rbd_header_from_disk(struct rbd_device *rbd_dev,
-				 struct rbd_image_header_ondisk *ondisk)
+static int rbd_header_from_disk(struct rbd_image_header *header,
+				struct rbd_image_header_ondisk *ondisk,
+				bool first_time)
 {
-	struct rbd_image_header *header = &rbd_dev->header;
-	bool first_time = header->object_prefix == NULL;
 	struct ceph_snap_context *snapc;
 	char *object_prefix = NULL;
 	char *snap_names = NULL;
@@ -1173,11 +1181,6 @@ static int rbd_header_from_disk(struct rbd_device *rbd_dev,
 	if (first_time) {
 		header->object_prefix = object_prefix;
 		header->obj_order = ondisk->options.order;
-		rbd_init_layout(rbd_dev);
-	} else {
-		ceph_put_snap_context(header->snapc);
-		kfree(header->snap_names);
-		kfree(header->snap_sizes);
 	}
 
 	/* The remaining fields always get updated (when we refresh) */
@@ -4983,7 +4986,9 @@ static int rbd_obj_read_sync(struct rbd_device *rbd_dev,
  * return, the rbd_dev->header field will contain up-to-date
  * information about the image.
  */
-static int rbd_dev_v1_header_info(struct rbd_device *rbd_dev)
+static int rbd_dev_v1_header_info(struct rbd_device *rbd_dev,
+				  struct rbd_image_header *header,
+				  bool first_time)
 {
 	struct rbd_image_header_ondisk *ondisk = NULL;
 	u32 snap_count = 0;
@@ -5031,7 +5036,7 @@ static int rbd_dev_v1_header_info(struct rbd_device *rbd_dev)
 		snap_count = le32_to_cpu(ondisk->snap_count);
 	} while (snap_count != want_count);
 
-	ret = rbd_header_from_disk(rbd_dev, ondisk);
+	ret = rbd_header_from_disk(header, ondisk, first_time);
 out:
 	kfree(ondisk);
 
@@ -5075,43 +5080,6 @@ static void rbd_dev_update_size(struct rbd_device *rbd_dev)
 	}
 }
 
-static int rbd_dev_refresh(struct rbd_device *rbd_dev)
-{
-	u64 mapping_size;
-	int ret;
-
-	down_write(&rbd_dev->header_rwsem);
-	mapping_size = rbd_dev->mapping.size;
-
-	ret = rbd_dev_header_info(rbd_dev);
-	if (ret)
-		goto out;
-
-	/*
-	 * If there is a parent, see if it has disappeared due to the
-	 * mapped image getting flattened.
-	 */
-	if (rbd_dev->parent) {
-		ret = rbd_dev_v2_parent_info(rbd_dev);
-		if (ret)
-			goto out;
-	}
-
-	if (rbd_dev->spec->snap_id == CEPH_NOSNAP) {
-		rbd_dev->mapping.size = rbd_dev->header.image_size;
-	} else {
-		/* validate mapped snapshot's EXISTS flag */
-		rbd_exists_validate(rbd_dev);
-	}
-
-out:
-	up_write(&rbd_dev->header_rwsem);
-	if (!ret && mapping_size != rbd_dev->mapping.size)
-		rbd_dev_update_size(rbd_dev);
-
-	return ret;
-}
-
 static int rbd_init_request(struct blk_mq_tag_set *set, struct request *rq,
 		unsigned int hctx_idx, unsigned int numa_node)
 {
@@ -5681,17 +5649,12 @@ static int _rbd_dev_v2_snap_size(struct rbd_device *rbd_dev, u64 snap_id,
 	return 0;
 }
 
-static int rbd_dev_v2_image_size(struct rbd_device *rbd_dev)
-{
-	return _rbd_dev_v2_snap_size(rbd_dev, CEPH_NOSNAP,
-					&rbd_dev->header.obj_order,
-					&rbd_dev->header.image_size);
-}
-
-static int rbd_dev_v2_object_prefix(struct rbd_device *rbd_dev)
+static int rbd_dev_v2_object_prefix(struct rbd_device *rbd_dev,
+				    char **pobject_prefix)
 {
 	size_t size;
 	void *reply_buf;
+	char *object_prefix;
 	int ret;
 	void *p;
 
@@ -5709,16 +5672,16 @@ static int rbd_dev_v2_object_prefix(struct rbd_device *rbd_dev)
 		goto out;
 
 	p = reply_buf;
-	rbd_dev->header.object_prefix = ceph_extract_encoded_string(&p,
-						p + ret, NULL, GFP_NOIO);
+	object_prefix = ceph_extract_encoded_string(&p, p + ret, NULL,
+						    GFP_NOIO);
+	if (IS_ERR(object_prefix)) {
+		ret = PTR_ERR(object_prefix);
+		goto out;
+	}
 	ret = 0;
 
-	if (IS_ERR(rbd_dev->header.object_prefix)) {
-		ret = PTR_ERR(rbd_dev->header.object_prefix);
-		rbd_dev->header.object_prefix = NULL;
-	} else {
-		dout("  object_prefix = %s\n", rbd_dev->header.object_prefix);
-	}
+	*pobject_prefix = object_prefix;
+	dout("  object_prefix = %s\n", object_prefix);
 out:
 	kfree(reply_buf);
 
@@ -5763,12 +5726,6 @@ static int _rbd_dev_v2_snap_features(struct rbd_device *rbd_dev, u64 snap_id,
 	return 0;
 }
 
-static int rbd_dev_v2_features(struct rbd_device *rbd_dev)
-{
-	return _rbd_dev_v2_snap_features(rbd_dev, CEPH_NOSNAP,
-						&rbd_dev->header.features);
-}
-
 /*
  * These are generic image flags, but since they are used only for
  * object map, store them in rbd_dev->object_map_flags.
@@ -5805,6 +5762,14 @@ struct parent_image_info {
 	u64		overlap;
 };
 
+static void rbd_parent_info_cleanup(struct parent_image_info *pii)
+{
+	kfree(pii->pool_ns);
+	kfree(pii->image_id);
+
+	memset(pii, 0, sizeof(*pii));
+}
+
 /*
  * The caller is responsible for @pii.
  */
@@ -5874,6 +5839,9 @@ static int __get_parent_info(struct rbd_device *rbd_dev,
 	if (pii->has_overlap)
 		ceph_decode_64_safe(&p, end, pii->overlap, e_inval);
 
+	dout("%s pool_id %llu pool_ns %s image_id %s snap_id %llu has_overlap %d overlap %llu\n",
+	     __func__, pii->pool_id, pii->pool_ns, pii->image_id, pii->snap_id,
+	     pii->has_overlap, pii->overlap);
 	return 0;
 
 e_inval:
@@ -5912,14 +5880,17 @@ static int __get_parent_info_legacy(struct rbd_device *rbd_dev,
 	pii->has_overlap = true;
 	ceph_decode_64_safe(&p, end, pii->overlap, e_inval);
 
+	dout("%s pool_id %llu pool_ns %s image_id %s snap_id %llu has_overlap %d overlap %llu\n",
+	     __func__, pii->pool_id, pii->pool_ns, pii->image_id, pii->snap_id,
+	     pii->has_overlap, pii->overlap);
 	return 0;
 
 e_inval:
 	return -EINVAL;
 }
 
-static int get_parent_info(struct rbd_device *rbd_dev,
-			   struct parent_image_info *pii)
+static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev,
+				  struct parent_image_info *pii)
 {
 	struct page *req_page, *reply_page;
 	void *p;
@@ -5947,7 +5918,7 @@ static int get_parent_info(struct rbd_device *rbd_dev,
 	return ret;
 }
 
-static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev)
+static int rbd_dev_setup_parent(struct rbd_device *rbd_dev)
 {
 	struct rbd_spec *parent_spec;
 	struct parent_image_info pii = { 0 };
@@ -5957,37 +5928,12 @@ static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev)
 	if (!parent_spec)
 		return -ENOMEM;
 
-	ret = get_parent_info(rbd_dev, &pii);
+	ret = rbd_dev_v2_parent_info(rbd_dev, &pii);
 	if (ret)
 		goto out_err;
 
-	dout("%s pool_id %llu pool_ns %s image_id %s snap_id %llu has_overlap %d overlap %llu\n",
-	     __func__, pii.pool_id, pii.pool_ns, pii.image_id, pii.snap_id,
-	     pii.has_overlap, pii.overlap);
-
-	if (pii.pool_id == CEPH_NOPOOL || !pii.has_overlap) {
-		/*
-		 * Either the parent never existed, or we have
-		 * record of it but the image got flattened so it no
-		 * longer has a parent.  When the parent of a
-		 * layered image disappears we immediately set the
-		 * overlap to 0.  The effect of this is that all new
-		 * requests will be treated as if the image had no
-		 * parent.
-		 *
-		 * If !pii.has_overlap, the parent image spec is not
-		 * applicable.  It's there to avoid duplication in each
-		 * snapshot record.
-		 */
-		if (rbd_dev->parent_overlap) {
-			rbd_dev->parent_overlap = 0;
-			rbd_dev_parent_put(rbd_dev);
-			pr_info("%s: clone image has been flattened\n",
-				rbd_dev->disk->disk_name);
-		}
-
+	if (pii.pool_id == CEPH_NOPOOL || !pii.has_overlap)
 		goto out;	/* No parent?  No problem. */
-	}
 
 	/* The ceph file layout needs to fit pool id in 32 bits */
 
@@ -5999,58 +5945,46 @@ static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev)
 	}
 
 	/*
-	 * The parent won't change (except when the clone is
-	 * flattened, already handled that).  So we only need to
-	 * record the parent spec we have not already done so.
+	 * The parent won't change except when the clone is flattened,
+	 * so we only need to record the parent image spec once.
 	 */
-	if (!rbd_dev->parent_spec) {
-		parent_spec->pool_id = pii.pool_id;
-		if (pii.pool_ns && *pii.pool_ns) {
-			parent_spec->pool_ns = pii.pool_ns;
-			pii.pool_ns = NULL;
-		}
-		parent_spec->image_id = pii.image_id;
-		pii.image_id = NULL;
-		parent_spec->snap_id = pii.snap_id;
-
-		rbd_dev->parent_spec = parent_spec;
-		parent_spec = NULL;	/* rbd_dev now owns this */
+	parent_spec->pool_id = pii.pool_id;
+	if (pii.pool_ns && *pii.pool_ns) {
+		parent_spec->pool_ns = pii.pool_ns;
+		pii.pool_ns = NULL;
 	}
+	parent_spec->image_id = pii.image_id;
+	pii.image_id = NULL;
+	parent_spec->snap_id = pii.snap_id;
+
+	rbd_assert(!rbd_dev->parent_spec);
+	rbd_dev->parent_spec = parent_spec;
+	parent_spec = NULL;	/* rbd_dev now owns this */
 
 	/*
-	 * We always update the parent overlap.  If it's zero we issue
-	 * a warning, as we will proceed as if there was no parent.
+	 * Record the parent overlap.  If it's zero, issue a warning as
+	 * we will proceed as if there is no parent.
 	 */
-	if (!pii.overlap) {
-		if (parent_spec) {
-			/* refresh, careful to warn just once */
-			if (rbd_dev->parent_overlap)
-				rbd_warn(rbd_dev,
-				    "clone now standalone (overlap became 0)");
-		} else {
-			/* initial probe */
-			rbd_warn(rbd_dev, "clone is standalone (overlap 0)");
-		}
-	}
+	if (!pii.overlap)
+		rbd_warn(rbd_dev, "clone is standalone (overlap 0)");
 	rbd_dev->parent_overlap = pii.overlap;
 
 out:
 	ret = 0;
 out_err:
-	kfree(pii.pool_ns);
-	kfree(pii.image_id);
+	rbd_parent_info_cleanup(&pii);
 	rbd_spec_put(parent_spec);
 	return ret;
 }
 
-static int rbd_dev_v2_striping_info(struct rbd_device *rbd_dev)
+static int rbd_dev_v2_striping_info(struct rbd_device *rbd_dev,
+				    u64 *stripe_unit, u64 *stripe_count)
 {
 	struct {
 		__le64 stripe_unit;
 		__le64 stripe_count;
 	} __attribute__ ((packed)) striping_info_buf = { 0 };
 	size_t size = sizeof (striping_info_buf);
-	void *p;
 	int ret;
 
 	ret = rbd_obj_method_sync(rbd_dev, &rbd_dev->header_oid,
@@ -6062,27 +5996,33 @@ static int rbd_dev_v2_striping_info(struct rbd_device *rbd_dev)
 	if (ret < size)
 		return -ERANGE;
 
-	p = &striping_info_buf;
-	rbd_dev->header.stripe_unit = ceph_decode_64(&p);
-	rbd_dev->header.stripe_count = ceph_decode_64(&p);
+	*stripe_unit = le64_to_cpu(striping_info_buf.stripe_unit);
+	*stripe_count = le64_to_cpu(striping_info_buf.stripe_count);
+	dout("  stripe_unit = %llu stripe_count = %llu\n", *stripe_unit,
+	     *stripe_count);
+
 	return 0;
 }
 
-static int rbd_dev_v2_data_pool(struct rbd_device *rbd_dev)
+static int rbd_dev_v2_data_pool(struct rbd_device *rbd_dev, s64 *data_pool_id)
 {
-	__le64 data_pool_id;
+	__le64 data_pool_buf;
 	int ret;
 
 	ret = rbd_obj_method_sync(rbd_dev, &rbd_dev->header_oid,
 				  &rbd_dev->header_oloc, "get_data_pool",
-				  NULL, 0, &data_pool_id, sizeof(data_pool_id));
+				  NULL, 0, &data_pool_buf,
+				  sizeof(data_pool_buf));
+	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0)
 		return ret;
-	if (ret < sizeof(data_pool_id))
+	if (ret < sizeof(data_pool_buf))
 		return -EBADMSG;
 
-	rbd_dev->header.data_pool_id = le64_to_cpu(data_pool_id);
-	WARN_ON(rbd_dev->header.data_pool_id == CEPH_NOPOOL);
+	*data_pool_id = le64_to_cpu(data_pool_buf);
+	dout("  data_pool_id = %lld\n", *data_pool_id);
+	WARN_ON(*data_pool_id == CEPH_NOPOOL);
+
 	return 0;
 }
 
@@ -6274,7 +6214,8 @@ static int rbd_spec_fill_names(struct rbd_device *rbd_dev)
 	return ret;
 }
 
-static int rbd_dev_v2_snap_context(struct rbd_device *rbd_dev)
+static int rbd_dev_v2_snap_context(struct rbd_device *rbd_dev,
+				   struct ceph_snap_context **psnapc)
 {
 	size_t size;
 	int ret;
@@ -6335,9 +6276,7 @@ static int rbd_dev_v2_snap_context(struct rbd_device *rbd_dev)
 	for (i = 0; i < snap_count; i++)
 		snapc->snaps[i] = ceph_decode_64(&p);
 
-	ceph_put_snap_context(rbd_dev->header.snapc);
-	rbd_dev->header.snapc = snapc;
-
+	*psnapc = snapc;
 	dout("  snap context seq = %llu, snap_count = %u\n",
 		(unsigned long long)seq, (unsigned int)snap_count);
 out:
@@ -6386,38 +6325,42 @@ static const char *rbd_dev_v2_snap_name(struct rbd_device *rbd_dev,
 	return snap_name;
 }
 
-static int rbd_dev_v2_header_info(struct rbd_device *rbd_dev)
+static int rbd_dev_v2_header_info(struct rbd_device *rbd_dev,
+				  struct rbd_image_header *header,
+				  bool first_time)
 {
-	bool first_time = rbd_dev->header.object_prefix == NULL;
 	int ret;
 
-	ret = rbd_dev_v2_image_size(rbd_dev);
+	ret = _rbd_dev_v2_snap_size(rbd_dev, CEPH_NOSNAP,
+				    first_time ? &header->obj_order : NULL,
+				    &header->image_size);
 	if (ret)
 		return ret;
 
 	if (first_time) {
-		ret = rbd_dev_v2_header_onetime(rbd_dev);
+		ret = rbd_dev_v2_header_onetime(rbd_dev, header);
 		if (ret)
 			return ret;
 	}
 
-	ret = rbd_dev_v2_snap_context(rbd_dev);
-	if (ret && first_time) {
-		kfree(rbd_dev->header.object_prefix);
-		rbd_dev->header.object_prefix = NULL;
-	}
+	ret = rbd_dev_v2_snap_context(rbd_dev, &header->snapc);
+	if (ret)
+		return ret;
 
-	return ret;
+	return 0;
 }
 
-static int rbd_dev_header_info(struct rbd_device *rbd_dev)
+static int rbd_dev_header_info(struct rbd_device *rbd_dev,
+			       struct rbd_image_header *header,
+			       bool first_time)
 {
 	rbd_assert(rbd_image_format_valid(rbd_dev->image_format));
+	rbd_assert(!header->object_prefix && !header->snapc);
 
 	if (rbd_dev->image_format == 1)
-		return rbd_dev_v1_header_info(rbd_dev);
+		return rbd_dev_v1_header_info(rbd_dev, header, first_time);
 
-	return rbd_dev_v2_header_info(rbd_dev);
+	return rbd_dev_v2_header_info(rbd_dev, header, first_time);
 }
 
 /*
@@ -6767,60 +6710,49 @@ static int rbd_dev_image_id(struct rbd_device *rbd_dev)
  */
 static void rbd_dev_unprobe(struct rbd_device *rbd_dev)
 {
-	struct rbd_image_header	*header;
-
 	rbd_dev_parent_put(rbd_dev);
 	rbd_object_map_free(rbd_dev);
 	rbd_dev_mapping_clear(rbd_dev);
 
 	/* Free dynamic fields from the header, then zero it out */
 
-	header = &rbd_dev->header;
-	ceph_put_snap_context(header->snapc);
-	kfree(header->snap_sizes);
-	kfree(header->snap_names);
-	kfree(header->object_prefix);
-	memset(header, 0, sizeof (*header));
+	rbd_image_header_cleanup(&rbd_dev->header);
 }
 
-static int rbd_dev_v2_header_onetime(struct rbd_device *rbd_dev)
+static int rbd_dev_v2_header_onetime(struct rbd_device *rbd_dev,
+				     struct rbd_image_header *header)
 {
 	int ret;
 
-	ret = rbd_dev_v2_object_prefix(rbd_dev);
+	ret = rbd_dev_v2_object_prefix(rbd_dev, &header->object_prefix);
 	if (ret)
-		goto out_err;
+		return ret;
 
 	/*
 	 * Get the and check features for the image.  Currently the
 	 * features are assumed to never change.
 	 */
-	ret = rbd_dev_v2_features(rbd_dev);
+	ret = _rbd_dev_v2_snap_features(rbd_dev, CEPH_NOSNAP,
+					&header->features);
 	if (ret)
-		goto out_err;
+		return ret;
 
 	/* If the image supports fancy striping, get its parameters */
 
-	if (rbd_dev->header.features & RBD_FEATURE_STRIPINGV2) {
-		ret = rbd_dev_v2_striping_info(rbd_dev);
-		if (ret < 0)
-			goto out_err;
+	if (header->features & RBD_FEATURE_STRIPINGV2) {
+		ret = rbd_dev_v2_striping_info(rbd_dev, &header->stripe_unit,
+					       &header->stripe_count);
+		if (ret)
+			return ret;
 	}
 
-	if (rbd_dev->header.features & RBD_FEATURE_DATA_POOL) {
-		ret = rbd_dev_v2_data_pool(rbd_dev);
+	if (header->features & RBD_FEATURE_DATA_POOL) {
+		ret = rbd_dev_v2_data_pool(rbd_dev, &header->data_pool_id);
 		if (ret)
-			goto out_err;
+			return ret;
 	}
 
-	rbd_init_layout(rbd_dev);
 	return 0;
-
-out_err:
-	rbd_dev->header.features = 0;
-	kfree(rbd_dev->header.object_prefix);
-	rbd_dev->header.object_prefix = NULL;
-	return ret;
 }
 
 /*
@@ -6998,10 +6930,12 @@ static int rbd_dev_image_probe(struct rbd_device *rbd_dev, int depth)
 	if (!depth)
 		down_write(&rbd_dev->header_rwsem);
 
-	ret = rbd_dev_header_info(rbd_dev);
+	ret = rbd_dev_header_info(rbd_dev, &rbd_dev->header, true);
 	if (ret)
 		goto err_out_probe;
 
+	rbd_init_layout(rbd_dev);
+
 	/*
 	 * If this image is the one being mapped, we have pool name and
 	 * id, image name and id, and snap name - need to fill snap id.
@@ -7035,7 +6969,7 @@ static int rbd_dev_image_probe(struct rbd_device *rbd_dev, int depth)
 	}
 
 	if (rbd_dev->header.features & RBD_FEATURE_LAYERING) {
-		ret = rbd_dev_v2_parent_info(rbd_dev);
+		ret = rbd_dev_setup_parent(rbd_dev);
 		if (ret)
 			goto err_out_probe;
 	}
@@ -7061,6 +6995,112 @@ static int rbd_dev_image_probe(struct rbd_device *rbd_dev, int depth)
 	return ret;
 }
 
+static void rbd_dev_update_header(struct rbd_device *rbd_dev,
+				  struct rbd_image_header *header)
+{
+	rbd_assert(rbd_image_format_valid(rbd_dev->image_format));
+	rbd_assert(rbd_dev->header.object_prefix); /* !first_time */
+
+	if (rbd_dev->header.image_size != header->image_size) {
+		rbd_dev->header.image_size = header->image_size;
+
+		if (rbd_dev->spec->snap_id == CEPH_NOSNAP) {
+			rbd_dev->mapping.size = header->image_size;
+			rbd_dev_update_size(rbd_dev);
+		}
+	}
+
+	if (rbd_dev->spec->snap_id != CEPH_NOSNAP) {
+		/* validate mapped snapshot's EXISTS flag */
+		rbd_exists_validate(rbd_dev);
+	}
+
+	ceph_put_snap_context(rbd_dev->header.snapc);
+	rbd_dev->header.snapc = header->snapc;
+	header->snapc = NULL;
+
+	if (rbd_dev->image_format == 1) {
+		kfree(rbd_dev->header.snap_names);
+		rbd_dev->header.snap_names = header->snap_names;
+		header->snap_names = NULL;
+
+		kfree(rbd_dev->header.snap_sizes);
+		rbd_dev->header.snap_sizes = header->snap_sizes;
+		header->snap_sizes = NULL;
+	}
+}
+
+static void rbd_dev_update_parent(struct rbd_device *rbd_dev,
+				  struct parent_image_info *pii)
+{
+	if (pii->pool_id == CEPH_NOPOOL || !pii->has_overlap) {
+		/*
+		 * Either the parent never existed, or we have
+		 * record of it but the image got flattened so it no
+		 * longer has a parent.  When the parent of a
+		 * layered image disappears we immediately set the
+		 * overlap to 0.  The effect of this is that all new
+		 * requests will be treated as if the image had no
+		 * parent.
+		 *
+		 * If !pii.has_overlap, the parent image spec is not
+		 * applicable.  It's there to avoid duplication in each
+		 * snapshot record.
+		 */
+		if (rbd_dev->parent_overlap) {
+			rbd_dev->parent_overlap = 0;
+			rbd_dev_parent_put(rbd_dev);
+			pr_info("%s: clone has been flattened\n",
+				rbd_dev->disk->disk_name);
+		}
+	} else {
+		rbd_assert(rbd_dev->parent_spec);
+
+		/*
+		 * Update the parent overlap.  If it became zero, issue
+		 * a warning as we will proceed as if there is no parent.
+		 */
+		if (!pii->overlap && rbd_dev->parent_overlap)
+			rbd_warn(rbd_dev,
+				 "clone has become standalone (overlap 0)");
+		rbd_dev->parent_overlap = pii->overlap;
+	}
+}
+
+static int rbd_dev_refresh(struct rbd_device *rbd_dev)
+{
+	struct rbd_image_header	header = { 0 };
+	struct parent_image_info pii = { 0 };
+	int ret;
+
+	dout("%s rbd_dev %p\n", __func__, rbd_dev);
+
+	ret = rbd_dev_header_info(rbd_dev, &header, false);
+	if (ret)
+		goto out;
+
+	/*
+	 * If there is a parent, see if it has disappeared due to the
+	 * mapped image getting flattened.
+	 */
+	if (rbd_dev->parent) {
+		ret = rbd_dev_v2_parent_info(rbd_dev, &pii);
+		if (ret)
+			goto out;
+	}
+
+	down_write(&rbd_dev->header_rwsem);
+	rbd_dev_update_header(rbd_dev, &header);
+	if (rbd_dev->parent)
+		rbd_dev_update_parent(rbd_dev, &pii);
+	up_write(&rbd_dev->header_rwsem);
+
+out:
+	rbd_parent_info_cleanup(&pii);
+	rbd_image_header_cleanup(&header);
+	return ret;
+}
+
 static ssize_t do_rbd_add(struct bus_type *bus,
 			  const char *buf,
 			  size_t count)
diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index b542c2b2aef4..70339f73181e 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1023,6 +1023,11 @@ static int sysc_enable_module(struct device *dev)
 	if (ddata->cfg.quirks & (SYSC_QUIRK_SWSUP_SIDLE |
 				 SYSC_QUIRK_SWSUP_SIDLE_ACT)) {
 		best_mode = SYSC_IDLE_NO;
+
+		/* Clear WAKEUP */
+		if (regbits->enwkup_shift >= 0 &&
+		    ddata->cfg.sysc_val & BIT(regbits->enwkup_shift))
+			reg &= ~BIT(regbits->enwkup_shift);
 	} else {
 		best_mode = fls(ddata->cfg.sidlemodes) - 1;
 		if (best_mode > SYSC_IDLE_MASK) {
@@ -1143,6 +1148,13 @@ static int sysc_disable_module(struct device *dev)
 		}
 	}
 
+	if (ddata->cfg.quirks & SYSC_QUIRK_SWSUP_SIDLE_ACT) {
+		/* Set WAKEUP */
+		if (regbits->enwkup_shift >= 0 &&
+		    ddata->cfg.sysc_val & BIT(regbits->enwkup_shift))
+			reg |= BIT(regbits->enwkup_shift);
+	}
+
 	reg &= ~(SYSC_IDLE_MASK << regbits->sidle_shift);
 	reg |= best_mode << regbits->sidle_shift;
 	if (regbits->autoidle_shift >= 0 &&
@@ -1371,16 +1383,16 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 	SYSC_QUIRK("timer", 0, 0, 0x10, -ENODEV, 0x4fff1301, 0xffff00ff,
 		   0),
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x00000046, 0xffffffff,
-		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
+		   SYSC_QUIRK_SWSUP_SIDLE_ACT | SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x00000052, 0xffffffff,
-		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
+		   SYSC_QUIRK_SWSUP_SIDLE_ACT | SYSC_QUIRK_LEGACY_IDLE),
 	/* Uarts on omap4 and later */
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x50411e03, 0xffff00ff,
-		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
+		   SYSC_QUIRK_SWSUP_SIDLE_ACT | SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x47422e03, 0xffffffff,
-		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
+		   SYSC_QUIRK_SWSUP_SIDLE_ACT | SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x47424e03, 0xffffffff,
-		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
+		   SYSC_QUIRK_SWSUP_SIDLE_ACT | SYSC_QUIRK_LEGACY_IDLE),
 
 	/* Quirks that need to be set based on the module address */
 	SYSC_QUIRK("mcpdm", 0x40132000, 0, 0x10, -ENODEV, 0x50000800, 0xffffffff,
diff --git a/drivers/char/agp/parisc-agp.c b/drivers/char/agp/parisc-agp.c
index 514f9f287a78..c6f181702b9a 100644
--- a/drivers/char/agp/parisc-agp.c
+++ b/drivers/char/agp/parisc-agp.c
@@ -394,8 +394,6 @@ find_quicksilver(struct device *dev, void *data)
 static int __init
 parisc_agp_init(void)
 {
-	extern struct sba_device *sba_list;
-
 	int err = -1;
 	struct parisc_device *sba = NULL, *lba = NULL;
 	struct lba_device *lbadev = NULL;
diff --git a/drivers/clk/tegra/clk-bpmp.c b/drivers/clk/tegra/clk-bpmp.c
index a66263b6490d..00845044c98e 100644
--- a/drivers/clk/tegra/clk-bpmp.c
+++ b/drivers/clk/tegra/clk-bpmp.c
@@ -159,7 +159,7 @@ static unsigned long tegra_bpmp_clk_recalc_rate(struct clk_hw *hw,
 
 	err = tegra_bpmp_clk_transfer(clk->bpmp, &msg);
 	if (err < 0)
-		return err;
+		return 0;
 
 	return response.rate;
 }
diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 22e0d6fcab1c..b7e93d10a6ab 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -967,7 +967,7 @@ static int aspeed_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 	else if (param == PIN_CONFIG_BIAS_DISABLE ||
 			param == PIN_CONFIG_BIAS_PULL_DOWN ||
 			param == PIN_CONFIG_DRIVE_STRENGTH)
-		return pinctrl_gpio_set_config(offset, config);
+		return pinctrl_gpio_set_config(chip->base + offset, config);
 	else if (param == PIN_CONFIG_DRIVE_OPEN_DRAIN ||
 			param == PIN_CONFIG_DRIVE_OPEN_SOURCE)
 		/* Return -ENOTSUPP to trigger emulation, as per datasheet */
diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic-eic-sprd.c
index 05000cace9b2..abe01518bf19 100644
--- a/drivers/gpio/gpio-pmic-eic-sprd.c
+++ b/drivers/gpio/gpio-pmic-eic-sprd.c
@@ -338,6 +338,7 @@ static int sprd_pmic_eic_probe(struct platform_device *pdev)
 	pmic_eic->chip.set_config = sprd_pmic_eic_set_config;
 	pmic_eic->chip.set = sprd_pmic_eic_set;
 	pmic_eic->chip.get = sprd_pmic_eic_get;
+	pmic_eic->chip.can_sleep = true;
 
 	pmic_eic->intc.name = dev_name(&pdev->dev);
 	pmic_eic->intc.irq_mask = sprd_pmic_eic_irq_mask;
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 432c487f77b4..5c770b7891f7 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -243,6 +243,7 @@ static bool pxa_gpio_has_pinctrl(void)
 	switch (gpio_type) {
 	case PXA3XX_GPIO:
 	case MMP2_GPIO:
+	case MMP_GPIO:
 		return false;
 
 	default:
diff --git a/drivers/gpio/gpio-tb10x.c b/drivers/gpio/gpio-tb10x.c
index 5e375186f90e..2a5e6263570f 100644
--- a/drivers/gpio/gpio-tb10x.c
+++ b/drivers/gpio/gpio-tb10x.c
@@ -195,7 +195,7 @@ static int tb10x_gpio_probe(struct platform_device *pdev)
 				handle_edge_irq, IRQ_NOREQUEST, IRQ_NOPROBE,
 				IRQ_GC_INIT_MASK_CACHE);
 		if (ret)
-			return ret;
+			goto err_remove_domain;
 
 		gc = tb10x_gpio->domain->gc->gc[0];
 		gc->reg_base                         = tb10x_gpio->base;
@@ -209,6 +209,10 @@ static int tb10x_gpio_probe(struct platform_device *pdev)
 	}
 
 	return 0;
+
+err_remove_domain:
+	irq_domain_remove(tb10x_gpio->domain);
+	return ret;
 }
 
 static int tb10x_gpio_remove(struct platform_device *pdev)
diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 7d67cb2c61f0..ed5c9edfdcc5 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -37,8 +37,8 @@
 #define STATIC_SCREEN_RAMP_DELTA_REFRESH_RATE_PER_FRAME ((1000 / 60) * 65)
 /* Number of elements in the render times cache array */
 #define RENDER_TIMES_MAX_COUNT 10
-/* Threshold to exit BTR (to avoid frequent enter-exits at the lower limit) */
-#define BTR_EXIT_MARGIN 2000
+/* Threshold to exit/exit BTR (to avoid frequent enter-exits at the lower limit) */
+#define BTR_MAX_MARGIN 2500
 /* Threshold to change BTR multiplier (to avoid frequent changes) */
 #define BTR_DRIFT_MARGIN 2000
 /*Threshold to exit fixed refresh rate*/
@@ -250,24 +250,22 @@ static void apply_below_the_range(struct core_freesync *core_freesync,
 	unsigned int delta_from_mid_point_in_us_1 = 0xFFFFFFFF;
 	unsigned int delta_from_mid_point_in_us_2 = 0xFFFFFFFF;
 	unsigned int frames_to_insert = 0;
-	unsigned int min_frame_duration_in_ns = 0;
-	unsigned int max_render_time_in_us = in_out_vrr->max_duration_in_us;
 	unsigned int delta_from_mid_point_delta_in_us;
-
-	min_frame_duration_in_ns = ((unsigned int) (div64_u64(
-		(1000000000ULL * 1000000),
-		in_out_vrr->max_refresh_in_uhz)));
+	unsigned int max_render_time_in_us =
+			in_out_vrr->max_duration_in_us - in_out_vrr->btr.margin_in_us;
 
 	/* Program BTR */
-	if (last_render_time_in_us + BTR_EXIT_MARGIN < max_render_time_in_us) {
+	if ((last_render_time_in_us + in_out_vrr->btr.margin_in_us / 2) < max_render_time_in_us) {
 		/* Exit Below the Range */
 		if (in_out_vrr->btr.btr_active) {
 			in_out_vrr->btr.frame_counter = 0;
 			in_out_vrr->btr.btr_active = false;
 		}
-	} else if (last_render_time_in_us > max_render_time_in_us) {
+	} else if (last_render_time_in_us > (max_render_time_in_us + in_out_vrr->btr.margin_in_us / 2)) {
 		/* Enter Below the Range */
-		in_out_vrr->btr.btr_active = true;
+		if (!in_out_vrr->btr.btr_active) {
+			in_out_vrr->btr.btr_active = true;
+		}
 	}
 
 	/* BTR set to "not active" so disengage */
@@ -322,24 +320,50 @@ static void apply_below_the_range(struct core_freesync *core_freesync,
 
 		/* Choose number of frames to insert based on how close it
 		 * can get to the mid point of the variable range.
+		 *  - Delta for CEIL: delta_from_mid_point_in_us_1
+		 *  - Delta for FLOOR: delta_from_mid_point_in_us_2
 		 */
-		if (delta_from_mid_point_in_us_1 < delta_from_mid_point_in_us_2) {
+		if (mid_point_frames_ceil &&
+		    (last_render_time_in_us / mid_point_frames_ceil) <
+		    in_out_vrr->min_duration_in_us) {
+			/* Check for out of range.
+			 * If using CEIL produces a value that is out of range,
+			 * then we are forced to use FLOOR.
+			 */
+			frames_to_insert = mid_point_frames_floor;
+		} else if (mid_point_frames_floor < 2) {
+			/* Check if FLOOR would result in non-LFC. In this case
+			 * choose to use CEIL
+			 */
+			frames_to_insert = mid_point_frames_ceil;
+		} else if (delta_from_mid_point_in_us_1 < delta_from_mid_point_in_us_2) {
+			/* If choosing CEIL results in a frame duration that is
+			 * closer to the mid point of the range.
+			 * Choose CEIL
+			 */
 			frames_to_insert = mid_point_frames_ceil;
-			delta_from_mid_point_delta_in_us = delta_from_mid_point_in_us_2 -
-					delta_from_mid_point_in_us_1;
 		} else {
+			/* If choosing FLOOR results in a frame duration that is
+			 * closer to the mid point of the range.
+			 * Choose FLOOR
+			 */
 			frames_to_insert = mid_point_frames_floor;
-			delta_from_mid_point_delta_in_us = delta_from_mid_point_in_us_1 -
-					delta_from_mid_point_in_us_2;
 		}
 
 		/* Prefer current frame multiplier when BTR is enabled unless it drifts
 		 * too far from the midpoint
 		 */
+		if (delta_from_mid_point_in_us_1 < delta_from_mid_point_in_us_2) {
+			delta_from_mid_point_delta_in_us = delta_from_mid_point_in_us_2 -
+					delta_from_mid_point_in_us_1;
+		} else {
+			delta_from_mid_point_delta_in_us = delta_from_mid_point_in_us_1 -
+					delta_from_mid_point_in_us_2;
+		}
 		if (in_out_vrr->btr.frames_to_insert != 0 &&
 				delta_from_mid_point_delta_in_us < BTR_DRIFT_MARGIN) {
 			if (((last_render_time_in_us / in_out_vrr->btr.frames_to_insert) <
-					in_out_vrr->max_duration_in_us) &&
+					max_render_time_in_us) &&
 				((last_render_time_in_us / in_out_vrr->btr.frames_to_insert) >
 					in_out_vrr->min_duration_in_us))
 				frames_to_insert = in_out_vrr->btr.frames_to_insert;
@@ -348,8 +372,9 @@ static void apply_below_the_range(struct core_freesync *core_freesync,
 		/* Either we've calculated the number of frames to insert,
 		 * or we need to insert min duration frames
 		 */
-		if (last_render_time_in_us / frames_to_insert <
-				in_out_vrr->min_duration_in_us){
+		if (frames_to_insert &&
+		    (last_render_time_in_us / frames_to_insert) <
+		    in_out_vrr->min_duration_in_us){
 			frames_to_insert -= (frames_to_insert > 1) ?
 					1 : 0;
 		}
@@ -792,6 +817,11 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 		refresh_range = in_out_vrr->max_refresh_in_uhz -
 				in_out_vrr->min_refresh_in_uhz;
 
+		in_out_vrr->btr.margin_in_us = in_out_vrr->max_duration_in_us -
+				2 * in_out_vrr->min_duration_in_us;
+		if (in_out_vrr->btr.margin_in_us > BTR_MAX_MARGIN)
+			in_out_vrr->btr.margin_in_us = BTR_MAX_MARGIN;
+
 		in_out_vrr->supported = true;
 	}
 
@@ -808,6 +838,7 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 	in_out_vrr->btr.inserted_duration_in_us = 0;
 	in_out_vrr->btr.frames_to_insert = 0;
 	in_out_vrr->btr.frame_counter = 0;
+
 	in_out_vrr->btr.mid_point_in_us =
 				(in_out_vrr->min_duration_in_us +
 				 in_out_vrr->max_duration_in_us) / 2;
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
index dc187844d10b..dbe7835aabcf 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
@@ -92,6 +92,7 @@ struct mod_vrr_params_btr {
 	uint32_t inserted_duration_in_us;
 	uint32_t frames_to_insert;
 	uint32_t frame_counter;
+	uint32_t margin_in_us;
 };
 
 struct mod_vrr_params_fixed_refresh {
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 2b84db59ab3c..7779f8e50256 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1873,6 +1873,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		"SMBus I801 adapter at %04lx", priv->smba);
 	err = i2c_add_adapter(&priv->adapter);
 	if (err) {
+		platform_device_unregister(priv->tco_pdev);
 		i801_acpi_remove(priv);
 		return err;
 	}
diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index f7a7405d4350..8e8688e8de0f 100644
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
index 726e70b68249..4348adc570a0 100644
--- a/drivers/infiniband/core/cma_configfs.c
+++ b/drivers/infiniband/core/cma_configfs.c
@@ -218,7 +218,7 @@ static int make_cma_ports(struct cma_dev_group *cma_dev_group,
 	}
 
 	for (i = 0; i < ports_num; i++) {
-		char port_str[10];
+		char port_str[11];
 
 		ports[i].port_num = i + 1;
 		snprintf(port_str, sizeof(port_str), "%u", i + 1);
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 88c68d77e6b1..a19e2104ffe9 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -2080,6 +2080,7 @@ static const struct rdma_nl_cbs nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
 	},
 	[RDMA_NLDEV_CMD_SYS_SET] = {
 		.doit = nldev_set_sys_set_doit,
+		.flags = RDMA_NL_ADMIN_PERM,
 	},
 	[RDMA_NLDEV_CMD_STAT_SET] = {
 		.doit = nldev_stat_set_doit,
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index e5fd43162b76..af6dedabd6a5 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -633,7 +633,7 @@ static ssize_t verify_hdr(struct ib_uverbs_cmd_hdr *hdr,
 	if (hdr->in_words * 4 != count)
 		return -EINVAL;
 
-	if (count < method_elm->req_size + sizeof(hdr)) {
+	if (count < method_elm->req_size + sizeof(*hdr)) {
 		/*
 		 * rdma-core v18 and v19 have a bug where they send DESTROY_CQ
 		 * with a 16 byte write instead of 24. Old kernels didn't
diff --git a/drivers/infiniband/hw/mlx4/sysfs.c b/drivers/infiniband/hw/mlx4/sysfs.c
index ea1f3a081b05..6c3a23ee3bc7 100644
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
index 9025086a8932..6698032af87d 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2053,7 +2053,7 @@ static inline char *mmap_cmd2str(enum mlx5_ib_mmap_cmd cmd)
 	case MLX5_IB_MMAP_DEVICE_MEM:
 		return "Device Memory";
 	default:
-		return NULL;
+		return "Unknown";
 	}
 }
 
diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 3d96b649889c..8c4d868dd154 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -981,6 +981,7 @@ static void siw_accept_newconn(struct siw_cep *cep)
 			siw_cep_put(cep);
 			new_cep->listen_cep = NULL;
 			if (rv) {
+				siw_cancel_mpatimer(new_cep);
 				siw_cep_set_free(new_cep);
 				goto error;
 			}
@@ -1105,9 +1106,12 @@ static void siw_cm_work_handler(struct work_struct *w)
 				/*
 				 * Socket close before MPA request received.
 				 */
-				siw_dbg_cep(cep, "no mpareq: drop listener\n");
-				siw_cep_put(cep->listen_cep);
-				cep->listen_cep = NULL;
+				if (cep->listen_cep) {
+					siw_dbg_cep(cep,
+						"no mpareq: drop listener\n");
+					siw_cep_put(cep->listen_cep);
+					cep->listen_cep = NULL;
+				}
 			}
 		}
 		release_cep = 1;
@@ -1230,7 +1234,11 @@ static void siw_cm_llp_data_ready(struct sock *sk)
 	if (!cep)
 		goto out;
 
-	siw_dbg_cep(cep, "state: %d\n", cep->state);
+	siw_dbg_cep(cep, "cep state: %d, socket state %d\n",
+		    cep->state, sk->sk_state);
+
+	if (sk->sk_state != TCP_ESTABLISHED)
+		goto out;
 
 	switch (cep->state) {
 	case SIW_EPSTATE_RDMA_MODE:
diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 92fb2f72511e..700655741bf2 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -1184,6 +1184,13 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
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
diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index f29ed9102ce9..a7169b0d5ba6 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -865,6 +865,13 @@ int ubi_attach_mtd_dev(struct mtd_info *mtd, int ubi_num,
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
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index ca705a0e0961..c1655e595222 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -2149,14 +2149,16 @@ static void mv88e6xxx_hardware_reset(struct mv88e6xxx_chip *chip)
 		 * from the wrong location resulting in the switch booting
 		 * to wrong mode and inoperable.
 		 */
-		mv88e6xxx_g1_wait_eeprom_done(chip);
+		if (chip->info->ops->get_eeprom)
+			mv88e6xxx_g2_eeprom_wait(chip);
 
 		gpiod_set_value_cansleep(gpiod, 1);
 		usleep_range(10000, 20000);
 		gpiod_set_value_cansleep(gpiod, 0);
 		usleep_range(10000, 20000);
 
-		mv88e6xxx_g1_wait_eeprom_done(chip);
+		if (chip->info->ops->get_eeprom)
+			mv88e6xxx_g2_eeprom_wait(chip);
 	}
 }
 
diff --git a/drivers/net/dsa/mv88e6xxx/global1.c b/drivers/net/dsa/mv88e6xxx/global1.c
index 938dd146629f..8a903624fdd7 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.c
+++ b/drivers/net/dsa/mv88e6xxx/global1.c
@@ -75,37 +75,6 @@ static int mv88e6xxx_g1_wait_init_ready(struct mv88e6xxx_chip *chip)
 	return mv88e6xxx_g1_wait_bit(chip, MV88E6XXX_G1_STS, bit, 1);
 }
 
-void mv88e6xxx_g1_wait_eeprom_done(struct mv88e6xxx_chip *chip)
-{
-	const unsigned long timeout = jiffies + 1 * HZ;
-	u16 val;
-	int err;
-
-	/* Wait up to 1 second for the switch to finish reading the
-	 * EEPROM.
-	 */
-	while (time_before(jiffies, timeout)) {
-		err = mv88e6xxx_g1_read(chip, MV88E6XXX_G1_STS, &val);
-		if (err) {
-			dev_err(chip->dev, "Error reading status");
-			return;
-		}
-
-		/* If the switch is still resetting, it may not
-		 * respond on the bus, and so MDIO read returns
-		 * 0xffff. Differentiate between that, and waiting for
-		 * the EEPROM to be done by bit 0 being set.
-		 */
-		if (val != 0xffff &&
-		    val & BIT(MV88E6XXX_G1_STS_IRQ_EEPROM_DONE))
-			return;
-
-		usleep_range(1000, 2000);
-	}
-
-	dev_err(chip->dev, "Timeout waiting for EEPROM done");
-}
-
 /* Offset 0x01: Switch MAC Address Register Bytes 0 & 1
  * Offset 0x02: Switch MAC Address Register Bytes 2 & 3
  * Offset 0x03: Switch MAC Address Register Bytes 4 & 5
diff --git a/drivers/net/dsa/mv88e6xxx/global1.h b/drivers/net/dsa/mv88e6xxx/global1.h
index 08d66ef6aace..0ae96a1e919b 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.h
+++ b/drivers/net/dsa/mv88e6xxx/global1.h
@@ -277,7 +277,6 @@ int mv88e6xxx_g1_set_switch_mac(struct mv88e6xxx_chip *chip, u8 *addr);
 int mv88e6185_g1_reset(struct mv88e6xxx_chip *chip);
 int mv88e6352_g1_reset(struct mv88e6xxx_chip *chip);
 int mv88e6250_g1_reset(struct mv88e6xxx_chip *chip);
-void mv88e6xxx_g1_wait_eeprom_done(struct mv88e6xxx_chip *chip);
 
 int mv88e6185_g1_ppu_enable(struct mv88e6xxx_chip *chip);
 int mv88e6185_g1_ppu_disable(struct mv88e6xxx_chip *chip);
diff --git a/drivers/net/dsa/mv88e6xxx/global2.c b/drivers/net/dsa/mv88e6xxx/global2.c
index 6240976679e1..7674b0b8cc70 100644
--- a/drivers/net/dsa/mv88e6xxx/global2.c
+++ b/drivers/net/dsa/mv88e6xxx/global2.c
@@ -310,7 +310,7 @@ int mv88e6xxx_g2_pot_clear(struct mv88e6xxx_chip *chip)
  * Offset 0x15: EEPROM Addr (for 8-bit data access)
  */
 
-static int mv88e6xxx_g2_eeprom_wait(struct mv88e6xxx_chip *chip)
+int mv88e6xxx_g2_eeprom_wait(struct mv88e6xxx_chip *chip)
 {
 	int bit = __bf_shf(MV88E6XXX_G2_EEPROM_CMD_BUSY);
 	int err;
diff --git a/drivers/net/dsa/mv88e6xxx/global2.h b/drivers/net/dsa/mv88e6xxx/global2.h
index 42da4bca73e8..12807e52ecea 100644
--- a/drivers/net/dsa/mv88e6xxx/global2.h
+++ b/drivers/net/dsa/mv88e6xxx/global2.h
@@ -340,6 +340,7 @@ int mv88e6xxx_g2_trunk_clear(struct mv88e6xxx_chip *chip);
 
 int mv88e6xxx_g2_device_mapping_write(struct mv88e6xxx_chip *chip, int target,
 				      int port);
+int mv88e6xxx_g2_eeprom_wait(struct mv88e6xxx_chip *chip);
 
 extern const struct mv88e6xxx_irq_ops mv88e6097_watchdog_ops;
 extern const struct mv88e6xxx_irq_ops mv88e6250_watchdog_ops;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 08277c3cf280..6b2d54c972b7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2939,8 +2939,13 @@ static u32 hclge_check_event_cause(struct hclge_dev *hdev, u32 *clearval)
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
diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb.c b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
index 200a1cb3b536..9de503c5f99b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
@@ -889,7 +889,9 @@ i40e_status i40e_init_dcb(struct i40e_hw *hw, bool enable_mib_change)
 
 		ret = i40e_read_nvm_module_data(hw,
 						I40E_SR_EMP_SR_SETTINGS_PTR,
-						offset, 1,
+						offset,
+						I40E_LLDP_CURRENT_STATUS_OFFSET,
+						I40E_LLDP_CURRENT_STATUS_SIZE,
 						&lldp_cfg.adminstatus);
 	} else {
 		ret = i40e_read_lldp_cfg(hw, &lldp_cfg);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb.h b/drivers/net/ethernet/intel/i40e/i40e_dcb.h
index 2a80c5daa376..ba86ad833bee 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb.h
@@ -32,6 +32,9 @@
 #define I40E_CEE_MAX_FEAT_TYPE		3
 #define I40E_LLDP_CURRENT_STATUS_XL710_OFFSET	0x2B
 #define I40E_LLDP_CURRENT_STATUS_X722_OFFSET	0x31
+#define I40E_LLDP_CURRENT_STATUS_OFFSET		1
+#define I40E_LLDP_CURRENT_STATUS_SIZE		1
+
 /* Defines for LLDP TLV header */
 #define I40E_LLDP_TLV_LEN_SHIFT		0
 #define I40E_LLDP_TLV_LEN_MASK		(0x01FF << I40E_LLDP_TLV_LEN_SHIFT)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index 37a29b5fc2af..6b1996451a4b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -323,20 +323,24 @@ i40e_status i40e_read_nvm_word(struct i40e_hw *hw, u16 offset,
 
 /**
  * i40e_read_nvm_module_data - Reads NVM Buffer to specified memory location
- * @hw: pointer to the HW structure
+ * @hw: Pointer to the HW structure
  * @module_ptr: Pointer to module in words with respect to NVM beginning
- * @offset: offset in words from module start
+ * @module_offset: Offset in words from module start
+ * @data_offset: Offset in words from reading data area start
  * @words_data_size: Words to read from NVM
  * @data_ptr: Pointer to memory location where resulting buffer will be stored
  **/
-i40e_status i40e_read_nvm_module_data(struct i40e_hw *hw,
-				      u8 module_ptr, u16 offset,
-				      u16 words_data_size,
-				      u16 *data_ptr)
+enum i40e_status_code i40e_read_nvm_module_data(struct i40e_hw *hw,
+						u8 module_ptr,
+						u16 module_offset,
+						u16 data_offset,
+						u16 words_data_size,
+						u16 *data_ptr)
 {
 	i40e_status status;
+	u16 specific_ptr = 0;
 	u16 ptr_value = 0;
-	u32 flat_offset;
+	u32 offset = 0;
 
 	if (module_ptr != 0) {
 		status = i40e_read_nvm_word(hw, module_ptr, &ptr_value);
@@ -352,36 +356,35 @@ i40e_status i40e_read_nvm_module_data(struct i40e_hw *hw,
 
 	/* Pointer not initialized */
 	if (ptr_value == I40E_NVM_INVALID_PTR_VAL ||
-	    ptr_value == I40E_NVM_INVALID_VAL)
+	    ptr_value == I40E_NVM_INVALID_VAL) {
+		i40e_debug(hw, I40E_DEBUG_ALL, "Pointer not initialized.\n");
 		return I40E_ERR_BAD_PTR;
+	}
 
 	/* Check whether the module is in SR mapped area or outside */
 	if (ptr_value & I40E_PTR_TYPE) {
 		/* Pointer points outside of the Shared RAM mapped area */
-		ptr_value &= ~I40E_PTR_TYPE;
+		i40e_debug(hw, I40E_DEBUG_ALL,
+			   "Reading nvm data failed. Pointer points outside of the Shared RAM mapped area.\n");
 
-		/* PtrValue in 4kB units, need to convert to words */
-		ptr_value /= 2;
-		flat_offset = ((u32)ptr_value * 0x1000) + (u32)offset;
-		status = i40e_acquire_nvm(hw, I40E_RESOURCE_READ);
-		if (!status) {
-			status = i40e_aq_read_nvm(hw, 0, 2 * flat_offset,
-						  2 * words_data_size,
-						  data_ptr, true, NULL);
-			i40e_release_nvm(hw);
-			if (status) {
-				i40e_debug(hw, I40E_DEBUG_ALL,
-					   "Reading nvm aq failed.Error code: %d.\n",
-					   status);
-				return I40E_ERR_NVM;
-			}
-		} else {
-			return I40E_ERR_NVM;
-		}
+		return I40E_ERR_PARAM;
 	} else {
 		/* Read from the Shadow RAM */
-		status = i40e_read_nvm_buffer(hw, ptr_value + offset,
-					      &words_data_size, data_ptr);
+
+		status = i40e_read_nvm_word(hw, ptr_value + module_offset,
+					    &specific_ptr);
+		if (status) {
+			i40e_debug(hw, I40E_DEBUG_ALL,
+				   "Reading nvm word failed.Error code: %d.\n",
+				   status);
+			return I40E_ERR_NVM;
+		}
+
+		offset = ptr_value + module_offset + specific_ptr +
+			data_offset;
+
+		status = i40e_read_nvm_buffer(hw, offset, &words_data_size,
+					      data_ptr);
 		if (status) {
 			i40e_debug(hw, I40E_DEBUG_ALL,
 				   "Reading nvm buffer failed.Error code: %d.\n",
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index 5250441bf75b..7effe5010e32 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -315,10 +315,12 @@ i40e_status i40e_acquire_nvm(struct i40e_hw *hw,
 void i40e_release_nvm(struct i40e_hw *hw);
 i40e_status i40e_read_nvm_word(struct i40e_hw *hw, u16 offset,
 					 u16 *data);
-i40e_status i40e_read_nvm_module_data(struct i40e_hw *hw,
-				      u8 module_ptr, u16 offset,
-				      u16 words_data_size,
-				      u16 *data_ptr);
+enum i40e_status_code i40e_read_nvm_module_data(struct i40e_hw *hw,
+						u8 module_ptr,
+						u16 module_offset,
+						u16 data_offset,
+						u16 words_data_size,
+						u16 *data_ptr);
 i40e_status i40e_read_nvm_buffer(struct i40e_hw *hw, u16 offset,
 				 u16 *words, u16 *data);
 i40e_status i40e_update_nvm_checksum(struct i40e_hw *hw);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index be07148a7b29..37ce764ed373 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -130,17 +130,18 @@ void i40e_vc_notify_vf_reset(struct i40e_vf *vf)
 /***********************misc routines*****************************/
 
 /**
- * i40e_vc_disable_vf
+ * i40e_vc_reset_vf
  * @vf: pointer to the VF info
- *
- * Disable the VF through a SW reset.
+ * @notify_vf: notify vf about reset or not
+ * Reset VF handler.
  **/
-static inline void i40e_vc_disable_vf(struct i40e_vf *vf)
+static void i40e_vc_reset_vf(struct i40e_vf *vf, bool notify_vf)
 {
 	struct i40e_pf *pf = vf->pf;
 	int i;
 
-	i40e_vc_notify_vf_reset(vf);
+	if (notify_vf)
+		i40e_vc_notify_vf_reset(vf);
 
 	/* We want to ensure that an actual reset occurs initiated after this
 	 * function was called. However, we do not want to wait forever, so
@@ -158,9 +159,14 @@ static inline void i40e_vc_disable_vf(struct i40e_vf *vf)
 		usleep_range(10000, 20000);
 	}
 
-	dev_warn(&vf->pf->pdev->dev,
-		 "Failed to initiate reset for VF %d after 200 milliseconds\n",
-		 vf->vf_id);
+	if (notify_vf)
+		dev_warn(&vf->pf->pdev->dev,
+			 "Failed to initiate reset for VF %d after 200 milliseconds\n",
+			 vf->vf_id);
+	else
+		dev_dbg(&vf->pf->pdev->dev,
+			"Failed to initiate reset for VF %d after 200 milliseconds\n",
+			vf->vf_id);
 }
 
 /**
@@ -1110,39 +1116,98 @@ static int i40e_quiesce_vf_pci(struct i40e_vf *vf)
 	return -EIO;
 }
 
-static inline int i40e_getnum_vf_vsi_vlan_filters(struct i40e_vsi *vsi);
+/**
+ * __i40e_getnum_vf_vsi_vlan_filters
+ * @vsi: pointer to the vsi
+ *
+ * called to get the number of VLANs offloaded on this VF
+ **/
+static int __i40e_getnum_vf_vsi_vlan_filters(struct i40e_vsi *vsi)
+{
+	struct i40e_mac_filter *f;
+	u16 num_vlans = 0, bkt;
+
+	hash_for_each(vsi->mac_filter_hash, bkt, f, hlist) {
+		if (f->vlan >= 0 && f->vlan <= I40E_MAX_VLANID)
+			num_vlans++;
+	}
+
+	return num_vlans;
+}
 
 /**
- * i40e_config_vf_promiscuous_mode
- * @vf: pointer to the VF info
- * @vsi_id: VSI id
- * @allmulti: set MAC L2 layer multicast promiscuous enable/disable
- * @alluni: set MAC L2 layer unicast promiscuous enable/disable
+ * i40e_getnum_vf_vsi_vlan_filters
+ * @vsi: pointer to the vsi
  *
- * Called from the VF to configure the promiscuous mode of
- * VF vsis and from the VF reset path to reset promiscuous mode.
+ * wrapper for __i40e_getnum_vf_vsi_vlan_filters() with spinlock held
  **/
-static i40e_status i40e_config_vf_promiscuous_mode(struct i40e_vf *vf,
-						   u16 vsi_id,
-						   bool allmulti,
-						   bool alluni)
+static int i40e_getnum_vf_vsi_vlan_filters(struct i40e_vsi *vsi)
+{
+	int num_vlans;
+
+	spin_lock_bh(&vsi->mac_filter_hash_lock);
+	num_vlans = __i40e_getnum_vf_vsi_vlan_filters(vsi);
+	spin_unlock_bh(&vsi->mac_filter_hash_lock);
+
+	return num_vlans;
+}
+
+/**
+ * i40e_get_vlan_list_sync
+ * @vsi: pointer to the VSI
+ * @num_vlans: number of VLANs in mac_filter_hash, returned to caller
+ * @vlan_list: list of VLANs present in mac_filter_hash, returned to caller.
+ *             This array is allocated here, but has to be freed in caller.
+ *
+ * Called to get number of VLANs and VLAN list present in mac_filter_hash.
+ **/
+static void i40e_get_vlan_list_sync(struct i40e_vsi *vsi, u16 *num_vlans,
+				    s16 **vlan_list)
 {
-	struct i40e_pf *pf = vf->pf;
-	struct i40e_hw *hw = &pf->hw;
 	struct i40e_mac_filter *f;
-	i40e_status aq_ret = 0;
-	struct i40e_vsi *vsi;
+	int i = 0;
 	int bkt;
 
-	vsi = i40e_find_vsi_from_id(pf, vsi_id);
-	if (!i40e_vc_isvalid_vsi_id(vf, vsi_id) || !vsi)
-		return I40E_ERR_PARAM;
+	spin_lock_bh(&vsi->mac_filter_hash_lock);
+	*num_vlans = __i40e_getnum_vf_vsi_vlan_filters(vsi);
+	*vlan_list = kcalloc(*num_vlans, sizeof(**vlan_list), GFP_ATOMIC);
+	if (!(*vlan_list))
+		goto err;
 
-	if (vf->port_vlan_id) {
-		aq_ret = i40e_aq_set_vsi_mc_promisc_on_vlan(hw, vsi->seid,
-							    allmulti,
-							    vf->port_vlan_id,
-							    NULL);
+	hash_for_each(vsi->mac_filter_hash, bkt, f, hlist) {
+		if (f->vlan < 0 || f->vlan > I40E_MAX_VLANID)
+			continue;
+		(*vlan_list)[i++] = f->vlan;
+	}
+err:
+	spin_unlock_bh(&vsi->mac_filter_hash_lock);
+}
+
+/**
+ * i40e_set_vsi_promisc
+ * @vf: pointer to the VF struct
+ * @seid: VSI number
+ * @multi_enable: set MAC L2 layer multicast promiscuous enable/disable
+ *                for a given VLAN
+ * @unicast_enable: set MAC L2 layer unicast promiscuous enable/disable
+ *                  for a given VLAN
+ * @vl: List of VLANs - apply filter for given VLANs
+ * @num_vlans: Number of elements in @vl
+ **/
+static i40e_status
+i40e_set_vsi_promisc(struct i40e_vf *vf, u16 seid, bool multi_enable,
+		     bool unicast_enable, s16 *vl, u16 num_vlans)
+{
+	i40e_status aq_ret, aq_tmp = 0;
+	struct i40e_pf *pf = vf->pf;
+	struct i40e_hw *hw = &pf->hw;
+	int i;
+
+	/* No VLAN to set promisc on, set on VSI */
+	if (!num_vlans || !vl) {
+		aq_ret = i40e_aq_set_vsi_multicast_promiscuous(hw, seid,
+							       multi_enable,
+							       NULL);
 		if (aq_ret) {
 			int aq_err = pf->hw.aq.asq_last_status;
 
@@ -1151,13 +1216,14 @@ static i40e_status i40e_config_vf_promiscuous_mode(struct i40e_vf *vf,
 				vf->vf_id,
 				i40e_stat_str(&pf->hw, aq_ret),
 				i40e_aq_str(&pf->hw, aq_err));
+
 			return aq_ret;
 		}
 
-		aq_ret = i40e_aq_set_vsi_uc_promisc_on_vlan(hw, vsi->seid,
-							    alluni,
-							    vf->port_vlan_id,
-							    NULL);
+		aq_ret = i40e_aq_set_vsi_unicast_promiscuous(hw, seid,
+							     unicast_enable,
+							     NULL, true);
+
 		if (aq_ret) {
 			int aq_err = pf->hw.aq.asq_last_status;
 
@@ -1167,68 +1233,94 @@ static i40e_status i40e_config_vf_promiscuous_mode(struct i40e_vf *vf,
 				i40e_stat_str(&pf->hw, aq_ret),
 				i40e_aq_str(&pf->hw, aq_err));
 		}
+
 		return aq_ret;
-	} else if (i40e_getnum_vf_vsi_vlan_filters(vsi)) {
-		hash_for_each(vsi->mac_filter_hash, bkt, f, hlist) {
-			if (f->vlan < 0 || f->vlan > I40E_MAX_VLANID)
-				continue;
-			aq_ret = i40e_aq_set_vsi_mc_promisc_on_vlan(hw,
-								    vsi->seid,
-								    allmulti,
-								    f->vlan,
-								    NULL);
-			if (aq_ret) {
-				int aq_err = pf->hw.aq.asq_last_status;
+	}
 
-				dev_err(&pf->pdev->dev,
-					"Could not add VLAN %d to multicast promiscuous domain err %s aq_err %s\n",
-					f->vlan,
-					i40e_stat_str(&pf->hw, aq_ret),
-					i40e_aq_str(&pf->hw, aq_err));
-			}
+	for (i = 0; i < num_vlans; i++) {
+		aq_ret = i40e_aq_set_vsi_mc_promisc_on_vlan(hw, seid,
+							    multi_enable,
+							    vl[i], NULL);
+		if (aq_ret) {
+			int aq_err = pf->hw.aq.asq_last_status;
 
-			aq_ret = i40e_aq_set_vsi_uc_promisc_on_vlan(hw,
-								    vsi->seid,
-								    alluni,
-								    f->vlan,
-								    NULL);
-			if (aq_ret) {
-				int aq_err = pf->hw.aq.asq_last_status;
+			dev_err(&pf->pdev->dev,
+				"VF %d failed to set multicast promiscuous mode err %s aq_err %s\n",
+				vf->vf_id,
+				i40e_stat_str(&pf->hw, aq_ret),
+				i40e_aq_str(&pf->hw, aq_err));
 
-				dev_err(&pf->pdev->dev,
-					"Could not add VLAN %d to Unicast promiscuous domain err %s aq_err %s\n",
-					f->vlan,
-					i40e_stat_str(&pf->hw, aq_ret),
-					i40e_aq_str(&pf->hw, aq_err));
-			}
+			if (!aq_tmp)
+				aq_tmp = aq_ret;
+		}
+
+		aq_ret = i40e_aq_set_vsi_uc_promisc_on_vlan(hw, seid,
+							    unicast_enable,
+							    vl[i], NULL);
+		if (aq_ret) {
+			int aq_err = pf->hw.aq.asq_last_status;
+
+			dev_err(&pf->pdev->dev,
+				"VF %d failed to set unicast promiscuous mode err %s aq_err %s\n",
+				vf->vf_id,
+				i40e_stat_str(&pf->hw, aq_ret),
+				i40e_aq_str(&pf->hw, aq_err));
+
+			if (!aq_tmp)
+				aq_tmp = aq_ret;
 		}
-		return aq_ret;
 	}
-	aq_ret = i40e_aq_set_vsi_multicast_promiscuous(hw, vsi->seid, allmulti,
-						       NULL);
-	if (aq_ret) {
-		int aq_err = pf->hw.aq.asq_last_status;
 
-		dev_err(&pf->pdev->dev,
-			"VF %d failed to set multicast promiscuous mode err %s aq_err %s\n",
-			vf->vf_id,
-			i40e_stat_str(&pf->hw, aq_ret),
-			i40e_aq_str(&pf->hw, aq_err));
+	if (aq_tmp)
+		aq_ret = aq_tmp;
+
+	return aq_ret;
+}
+
+/**
+ * i40e_config_vf_promiscuous_mode
+ * @vf: pointer to the VF info
+ * @vsi_id: VSI id
+ * @allmulti: set MAC L2 layer multicast promiscuous enable/disable
+ * @alluni: set MAC L2 layer unicast promiscuous enable/disable
+ *
+ * Called from the VF to configure the promiscuous mode of
+ * VF vsis and from the VF reset path to reset promiscuous mode.
+ **/
+static i40e_status i40e_config_vf_promiscuous_mode(struct i40e_vf *vf,
+						   u16 vsi_id,
+						   bool allmulti,
+						   bool alluni)
+{
+	i40e_status aq_ret = I40E_SUCCESS;
+	struct i40e_pf *pf = vf->pf;
+	struct i40e_vsi *vsi;
+	u16 num_vlans;
+	s16 *vl;
+
+	vsi = i40e_find_vsi_from_id(pf, vsi_id);
+	if (!i40e_vc_isvalid_vsi_id(vf, vsi_id) || !vsi)
+		return I40E_ERR_PARAM;
+
+	if (vf->port_vlan_id) {
+		aq_ret = i40e_set_vsi_promisc(vf, vsi->seid, allmulti,
+					      alluni, &vf->port_vlan_id, 1);
 		return aq_ret;
-	}
+	} else if (i40e_getnum_vf_vsi_vlan_filters(vsi)) {
+		i40e_get_vlan_list_sync(vsi, &num_vlans, &vl);
 
-	aq_ret = i40e_aq_set_vsi_unicast_promiscuous(hw, vsi->seid, alluni,
-						     NULL, true);
-	if (aq_ret) {
-		int aq_err = pf->hw.aq.asq_last_status;
+		if (!vl)
+			return I40E_ERR_NO_MEMORY;
 
-		dev_err(&pf->pdev->dev,
-			"VF %d failed to set unicast promiscuous mode err %s aq_err %s\n",
-			vf->vf_id,
-			i40e_stat_str(&pf->hw, aq_ret),
-			i40e_aq_str(&pf->hw, aq_err));
+		aq_ret = i40e_set_vsi_promisc(vf, vsi->seid, allmulti, alluni,
+					      vl, num_vlans);
+		kfree(vl);
+		return aq_ret;
 	}
 
+	/* no VLANs to set on, set on VSI */
+	aq_ret = i40e_set_vsi_promisc(vf, vsi->seid, allmulti, alluni,
+				      NULL, 0);
 	return aq_ret;
 }
 
@@ -2038,39 +2130,6 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 	return ret;
 }
 
-/**
- * i40e_vc_reset_vf_msg
- * @vf: pointer to the VF info
- *
- * called from the VF to reset itself,
- * unlike other virtchnl messages, PF driver
- * doesn't send the response back to the VF
- **/
-static void i40e_vc_reset_vf_msg(struct i40e_vf *vf)
-{
-	if (test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states))
-		i40e_reset_vf(vf, false);
-}
-
-/**
- * i40e_getnum_vf_vsi_vlan_filters
- * @vsi: pointer to the vsi
- *
- * called to get the number of VLANs offloaded on this VF
- **/
-static inline int i40e_getnum_vf_vsi_vlan_filters(struct i40e_vsi *vsi)
-{
-	struct i40e_mac_filter *f;
-	int num_vlans = 0, bkt;
-
-	hash_for_each(vsi->mac_filter_hash, bkt, f, hlist) {
-		if (f->vlan >= 0 && f->vlan <= I40E_MAX_VLANID)
-			num_vlans++;
-	}
-
-	return num_vlans;
-}
-
 /**
  * i40e_vc_config_promiscuous_mode_msg
  * @vf: pointer to the VF info
@@ -2624,8 +2683,7 @@ static int i40e_vc_request_queues_msg(struct i40e_vf *vf, u8 *msg)
 	} else {
 		/* successful request */
 		vf->num_req_queues = req_pairs;
-		i40e_vc_notify_vf_reset(vf);
-		i40e_reset_vf(vf, false);
+		i40e_vc_reset_vf(vf, true);
 		return 0;
 	}
 
@@ -3817,8 +3875,7 @@ static int i40e_vc_add_qch_msg(struct i40e_vf *vf, u8 *msg)
 	vf->adq_enabled = true;
 
 	/* reset the VF in order to allocate resources */
-	i40e_vc_notify_vf_reset(vf);
-	i40e_reset_vf(vf, false);
+	i40e_vc_reset_vf(vf, true);
 
 	return I40E_SUCCESS;
 
@@ -3858,8 +3915,7 @@ static int i40e_vc_del_qch_msg(struct i40e_vf *vf, u8 *msg)
 	}
 
 	/* reset the VF in order to allocate resources */
-	i40e_vc_notify_vf_reset(vf);
-	i40e_reset_vf(vf, false);
+	i40e_vc_reset_vf(vf, true);
 
 	return I40E_SUCCESS;
 
@@ -3921,7 +3977,7 @@ int i40e_vc_process_vf_msg(struct i40e_pf *pf, s16 vf_id, u32 v_opcode,
 		i40e_vc_notify_vf_link_state(vf);
 		break;
 	case VIRTCHNL_OP_RESET_VF:
-		i40e_vc_reset_vf_msg(vf);
+		i40e_vc_reset_vf(vf, false);
 		ret = 0;
 		break;
 	case VIRTCHNL_OP_CONFIG_PROMISCUOUS_MODE:
@@ -4175,7 +4231,7 @@ int i40e_ndo_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 	/* Force the VF interface down so it has to bring up with new MAC
 	 * address
 	 */
-	i40e_vc_disable_vf(vf);
+	i40e_vc_reset_vf(vf, true);
 	dev_info(&pf->pdev->dev, "Bring down and up the VF interface to make this change effective.\n");
 
 error_param:
@@ -4239,9 +4295,6 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev, int vf_id,
 		/* duplicate request, so just return success */
 		goto error_pvid;
 
-	i40e_vc_disable_vf(vf);
-	/* During reset the VF got a new VSI, so refresh a pointer. */
-	vsi = pf->vsi[vf->lan_vsi_idx];
 	/* Locked once because multiple functions below iterate list */
 	spin_lock_bh(&vsi->mac_filter_hash_lock);
 
@@ -4327,6 +4380,10 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev, int vf_id,
 	 */
 	vf->port_vlan_id = le16_to_cpu(vsi->info.pvid);
 
+	i40e_vc_reset_vf(vf, true);
+	/* During reset the VF got a new VSI, so refresh a pointer. */
+	vsi = pf->vsi[vf->lan_vsi_idx];
+
 	ret = i40e_config_vf_promiscuous_mode(vf, vsi->id, allmulti, alluni);
 	if (ret) {
 		dev_err(&pf->pdev->dev, "Unable to config vf promiscuous mode\n");
@@ -4622,7 +4679,7 @@ int i40e_ndo_set_vf_trust(struct net_device *netdev, int vf_id, bool setting)
 		goto out;
 
 	vf->trusted = setting;
-	i40e_vc_disable_vf(vf);
+	i40e_vc_reset_vf(vf, true);
 	dev_info(&pf->pdev->dev, "VF %u is now %strusted\n",
 		 vf_id, setting ? "" : "un");
 
diff --git a/drivers/net/ethernet/qlogic/qed/qed_ll2.h b/drivers/net/ethernet/qlogic/qed/qed_ll2.h
index 5f01fbd3c073..1e0e2dbecc76 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_ll2.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.h
@@ -123,9 +123,9 @@ struct qed_ll2_info {
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
index 4ef041bdf6a1..5bb97f0ec6a2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -111,6 +111,7 @@ struct stm32_ops {
 	int (*parse_data)(struct stm32_dwmac *dwmac,
 			  struct device *dev);
 	u32 syscfg_eth_mask;
+	bool clk_rx_enable_in_suspend;
 };
 
 static int stm32_dwmac_init(struct plat_stmmacenet_data *plat_dat)
@@ -128,7 +129,8 @@ static int stm32_dwmac_init(struct plat_stmmacenet_data *plat_dat)
 	if (ret)
 		return ret;
 
-	if (!dwmac->dev->power.is_suspended) {
+	if (!dwmac->ops->clk_rx_enable_in_suspend ||
+	    !dwmac->dev->power.is_suspended) {
 		ret = clk_prepare_enable(dwmac->clk_rx);
 		if (ret) {
 			clk_disable_unprepare(dwmac->clk_tx);
@@ -508,7 +510,8 @@ static struct stm32_ops stm32mp1_dwmac_data = {
 	.suspend = stm32mp1_suspend,
 	.resume = stm32mp1_resume,
 	.parse_data = stm32mp1_parse_data,
-	.syscfg_eth_mask = SYSCFG_MP1_ETH_MASK
+	.syscfg_eth_mask = SYSCFG_MP1_ETH_MASK,
+	.clk_rx_enable_in_suspend = true
 };
 
 static const struct of_device_id stm32_dwmac_match[] = {
diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 4dc98832bbba..60af6956286d 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2121,7 +2121,12 @@ static const struct ethtool_ops team_ethtool_ops = {
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
@@ -2168,8 +2173,11 @@ static int team_dev_type_check_change(struct net_device *dev,
 
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
index ce7f0f604a5e..c1f0195464b1 100644
--- a/drivers/net/thunderbolt.c
+++ b/drivers/net/thunderbolt.c
@@ -958,12 +958,11 @@ static bool tbnet_xmit_csum_and_map(struct tbnet *net, struct sk_buff *skb,
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
index bd533827af8b..9656561fc77f 100644
--- a/drivers/net/usb/smsc75xx.c
+++ b/drivers/net/usb/smsc75xx.c
@@ -90,7 +90,9 @@ static int __must_check __smsc75xx_read_reg(struct usbnet *dev, u32 index,
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
index 46077cef855b..8a0c2ea03ff9 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -34,6 +34,8 @@
 #define TDM_PPPOHT_SLIC_MAXIN
 #define RX_BD_ERRORS (R_CD_S | R_OV_S | R_CR_S | R_AB_S | R_NO_S | R_LG_S)
 
+static int uhdlc_close(struct net_device *dev);
+
 static struct ucc_tdm_info utdm_primary_info = {
 	.uf_info = {
 		.tsa = 0,
@@ -710,6 +712,7 @@ static int uhdlc_open(struct net_device *dev)
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	struct ucc_hdlc_private *priv = hdlc->priv;
 	struct ucc_tdm *utdm = priv->utdm;
+	int rc = 0;
 
 	if (priv->hdlc_busy != 1) {
 		if (request_irq(priv->ut_info->uf_info.irq,
@@ -733,10 +736,13 @@ static int uhdlc_open(struct net_device *dev)
 		napi_enable(&priv->napi);
 		netdev_reset_queue(dev);
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
@@ -826,6 +832,8 @@ static int uhdlc_close(struct net_device *dev)
 	netdev_reset_queue(dev);
 	priv->hdlc_busy = 0;
 
+	hdlc_close(dev);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
index 2e763678dbdb..36bfc195a772 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
@@ -332,9 +332,9 @@ struct iwl_fw_ini_fifo_hdr {
 struct iwl_fw_ini_error_dump_range {
 	__le32 range_data_size;
 	union {
-		__le32 internal_base_addr;
-		__le64 dram_base_addr;
-		__le32 page_num;
+		__le32 internal_base_addr __packed;
+		__le64 dram_base_addr __packed;
+		__le32 page_num __packed;
 		struct iwl_fw_ini_fifo_hdr fifo_hdr;
 	};
 	__le32 data[];
diff --git a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
index 05a3c61ac603..793be2835134 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
@@ -977,8 +977,8 @@ void mwifiex_11n_rxba_sync_event(struct mwifiex_private *priv,
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
index a42b8ff33b23..98157fd245f7 100644
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
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c b/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
index c54c50fd639a..c0227b20b6a3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
@@ -131,15 +131,8 @@ u8 mt76x02_get_lna_gain(struct mt76x02_dev *dev,
 			s8 *lna_2g, s8 *lna_5g,
 			struct ieee80211_channel *chan)
 {
-	u16 val;
 	u8 lna;
 
-	val = mt76x02_eeprom_get(dev, MT_EE_NIC_CONF_1);
-	if (val & MT_EE_NIC_CONF_1_LNA_EXT_2G)
-		*lna_2g = 0;
-	if (val & MT_EE_NIC_CONF_1_LNA_EXT_5G)
-		memset(lna_5g, 0, sizeof(s8) * 3);
-
 	if (chan->band == NL80211_BAND_2GHZ)
 		lna = *lna_2g;
 	else if (chan->hw_value <= 64)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
index 9f91556c7f38..3ee945eafa4d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
@@ -251,7 +251,8 @@ void mt76x2_read_rx_gain(struct mt76x02_dev *dev)
 	struct ieee80211_channel *chan = dev->mt76.chandef.chan;
 	int channel = chan->hw_value;
 	s8 lna_5g[3], lna_2g;
-	u8 lna;
+	bool use_lna;
+	u8 lna = 0;
 	u16 val;
 
 	if (chan->band == NL80211_BAND_2GHZ)
@@ -270,7 +271,15 @@ void mt76x2_read_rx_gain(struct mt76x02_dev *dev)
 	dev->cal.rx.mcu_gain |= (lna_5g[1] & 0xff) << 16;
 	dev->cal.rx.mcu_gain |= (lna_5g[2] & 0xff) << 24;
 
-	lna = mt76x02_get_lna_gain(dev, &lna_2g, lna_5g, chan);
+	val = mt76x02_eeprom_get(dev, MT_EE_NIC_CONF_1);
+	if (chan->band == NL80211_BAND_2GHZ)
+		use_lna = !(val & MT_EE_NIC_CONF_1_LNA_EXT_2G);
+	else
+		use_lna = !(val & MT_EE_NIC_CONF_1_LNA_EXT_5G);
+
+	if (use_lna)
+		lna = mt76x02_get_lna_gain(dev, &lna_2g, lna_5g, chan);
+
 	dev->cal.rx.lna_gain = mt76x02_sign_extend(lna, 8);
 }
 EXPORT_SYMBOL_GPL(mt76x2_read_rx_gain);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a58711c48850..486e44d20b43 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2841,8 +2841,6 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	size_t alloc_size;
 
 	node = dev_to_node(&pdev->dev);
-	if (node == NUMA_NO_NODE)
-		set_dev_node(&pdev->dev, first_memory_node);
 
 	dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, node);
 	if (!dev)
diff --git a/drivers/parisc/iosapic.c b/drivers/parisc/iosapic.c
index 7914cf3fd24f..a5d9ec7950de 100644
--- a/drivers/parisc/iosapic.c
+++ b/drivers/parisc/iosapic.c
@@ -202,9 +202,9 @@ static inline void iosapic_write(void __iomem *iosapic, unsigned int reg, u32 va
 
 static DEFINE_SPINLOCK(iosapic_lock);
 
-static inline void iosapic_eoi(void __iomem *addr, unsigned int data)
+static inline void iosapic_eoi(__le32 __iomem *addr, __le32 data)
 {
-	__raw_writel(data, addr);
+	__raw_writel((__force u32)data, addr);
 }
 
 /*
diff --git a/drivers/parisc/iosapic_private.h b/drivers/parisc/iosapic_private.h
index 73ecc657ad95..bd8ff40162b4 100644
--- a/drivers/parisc/iosapic_private.h
+++ b/drivers/parisc/iosapic_private.h
@@ -118,8 +118,8 @@ struct iosapic_irt {
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
index 24dbb6968831..17f411772f0c 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -807,8 +807,6 @@ static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
 			return PTR_ERR(res->phy_ahb_reset);
 	}
 
-	dw_pcie_dbi_ro_wr_dis(pci);
-
 	return 0;
 }
 
diff --git a/drivers/s390/scsi/zfcp_aux.c b/drivers/s390/scsi/zfcp_aux.c
index e390f8c6d5f3..0d57432066ca 100644
--- a/drivers/s390/scsi/zfcp_aux.c
+++ b/drivers/s390/scsi/zfcp_aux.c
@@ -488,12 +488,12 @@ struct zfcp_port *zfcp_port_enqueue(struct zfcp_adapter *adapter, u64 wwpn,
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
@@ -516,7 +516,7 @@ struct zfcp_port *zfcp_port_enqueue(struct zfcp_adapter *adapter, u64 wwpn,
 
 	if (dev_set_name(&port->dev, "0x%016llx", (unsigned long long)wwpn)) {
 		kfree(port);
-		goto err_out;
+		goto err_put;
 	}
 	retval = -EINVAL;
 
@@ -533,7 +533,8 @@ struct zfcp_port *zfcp_port_enqueue(struct zfcp_adapter *adapter, u64 wwpn,
 
 	return port;
 
-err_out:
+err_put:
 	zfcp_ccw_adapter_put(adapter);
+err_out:
 	return ERR_PTR(retval);
 }
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index f6d5d77ea45b..8a0ac87f70a9 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -485,6 +485,7 @@ static
 void qla24xx_handle_adisc_event(scsi_qla_host_t *vha, struct event_arg *ea)
 {
 	struct fc_port *fcport = ea->fcport;
+	unsigned long flags;
 
 	ql_dbg(ql_dbg_disc, vha, 0x20d2,
 	    "%s %8phC DS %d LS %d rc %d login %d|%d rscn %d|%d lid %d\n",
@@ -499,9 +500,15 @@ void qla24xx_handle_adisc_event(scsi_qla_host_t *vha, struct event_arg *ea)
 		ql_dbg(ql_dbg_disc, vha, 0x2066,
 		    "%s %8phC: adisc fail: post delete\n",
 		    __func__, ea->fcport->port_name);
+
+		spin_lock_irqsave(&vha->work_lock, flags);
 		/* deleted = 0 & logout_on_delete = force fw cleanup */
-		fcport->deleted = 0;
+		if (fcport->deleted == QLA_SESS_DELETED)
+			fcport->deleted = 0;
+
 		fcport->logout_on_delete = 1;
+		spin_unlock_irqrestore(&vha->work_lock, flags);
+
 		qlt_schedule_sess_for_deletion(ea->fcport);
 		return;
 	}
@@ -1402,7 +1409,6 @@ void __qla24xx_handle_gpdb_event(scsi_qla_host_t *vha, struct event_arg *ea)
 
 	spin_lock_irqsave(&vha->hw->tgt.sess_lock, flags);
 	ea->fcport->login_gen++;
-	ea->fcport->deleted = 0;
 	ea->fcport->logout_on_delete = 1;
 
 	if (!ea->fcport->login_succ && !IS_SW_RESV_ADDR(ea->fcport->d_id)) {
@@ -5475,6 +5481,8 @@ qla2x00_reg_remote_port(scsi_qla_host_t *vha, fc_port_t *fcport)
 void
 qla2x00_update_fcport(scsi_qla_host_t *vha, fc_port_t *fcport)
 {
+	unsigned long flags;
+
 	if (IS_SW_RESV_ADDR(fcport->d_id))
 		return;
 
@@ -5484,8 +5492,15 @@ qla2x00_update_fcport(scsi_qla_host_t *vha, fc_port_t *fcport)
 	qla2x00_set_fcport_disc_state(fcport, DSC_UPD_FCPORT);
 	fcport->login_retry = vha->hw->login_retry_count;
 	fcport->flags &= ~(FCF_LOGIN_NEEDED | FCF_ASYNC_SENT);
+
+	spin_lock_irqsave(&vha->work_lock, flags);
 	fcport->deleted = 0;
-	fcport->logout_on_delete = 1;
+	spin_unlock_irqrestore(&vha->work_lock, flags);
+
+	if (vha->hw->current_topology == ISP_CFG_NL)
+		fcport->logout_on_delete = 0;
+	else
+		fcport->logout_on_delete = 1;
 	fcport->n2n_chip_reset = fcport->n2n_link_reset_cnt = 0;
 
 	switch (vha->hw->current_topology) {
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index cb97565b6a33..a95ea2f70f97 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -1046,10 +1046,6 @@ void qlt_free_session_done(struct work_struct *work)
 			(struct imm_ntfy_from_isp *)sess->iocb, SRB_NACK_LOGO);
 	}
 
-	spin_lock_irqsave(&vha->work_lock, flags);
-	sess->flags &= ~FCF_ASYNC_SENT;
-	spin_unlock_irqrestore(&vha->work_lock, flags);
-
 	spin_lock_irqsave(&ha->tgt.sess_lock, flags);
 	if (sess->se_sess) {
 		sess->se_sess = NULL;
@@ -1059,7 +1055,6 @@ void qlt_free_session_done(struct work_struct *work)
 
 	qla2x00_set_fcport_disc_state(sess, DSC_DELETED);
 	sess->fw_login_state = DSC_LS_PORT_UNAVAIL;
-	sess->deleted = QLA_SESS_DELETED;
 
 	if (sess->login_succ && !IS_SW_RESV_ADDR(sess->d_id)) {
 		vha->fcport_count--;
@@ -1111,7 +1106,12 @@ void qlt_free_session_done(struct work_struct *work)
 
 	sess->explicit_logout = 0;
 	spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
+
+	spin_lock_irqsave(&vha->work_lock, flags);
+	sess->flags &= ~FCF_ASYNC_SENT;
+	sess->deleted = QLA_SESS_DELETED;
 	sess->free_pending = 0;
+	spin_unlock_irqrestore(&vha->work_lock, flags);
 
 	ql_dbg(ql_dbg_disc, vha, 0xf001,
 	    "Unregistration of sess %p %8phC finished fcp_cnt %d\n",
@@ -1161,12 +1161,12 @@ void qlt_unreg_sess(struct fc_port *sess)
 	 * management from being sent.
 	 */
 	sess->flags |= FCF_ASYNC_SENT;
+	sess->deleted = QLA_SESS_DELETION_IN_PROGRESS;
 	spin_unlock_irqrestore(&sess->vha->work_lock, flags);
 
 	if (sess->se_sess)
 		vha->hw->tgt.tgt_ops->clear_nacl_from_fcport_map(sess);
 
-	sess->deleted = QLA_SESS_DELETION_IN_PROGRESS;
 	qla2x00_set_fcport_disc_state(sess, DSC_DELETE_PEND);
 	sess->last_rscn_gen = sess->rscn_gen;
 	sess->last_login_gen = sess->login_gen;
diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 36a44a837031..ee1b488d7ded 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -897,6 +897,13 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
 	fspi_writel(f, FSPI_AHBCR_PREF_EN | FSPI_AHBCR_RDADDROPT,
 		 base + FSPI_AHBCR);
 
+	/* Reset the FLSHxCR1 registers. */
+	reg = FSPI_FLSHXCR1_TCSH(0x3) | FSPI_FLSHXCR1_TCSS(0x3);
+	fspi_writel(f, reg, base + FSPI_FLSHA1CR1);
+	fspi_writel(f, reg, base + FSPI_FLSHA2CR1);
+	fspi_writel(f, reg, base + FSPI_FLSHB1CR1);
+	fspi_writel(f, reg, base + FSPI_FLSHB2CR1);
+
 	/* AHB Read - Set lut sequence ID for all CS. */
 	fspi_writel(f, SEQID_LUT, base + FSPI_FLSHA1CR2);
 	fspi_writel(f, SEQID_LUT, base + FSPI_FLSHA2CR2);
diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index 20fe28703985..8ba134ccd3b9 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -856,7 +856,6 @@ sector_t target_to_linux_sector(struct se_device *dev, sector_t lb)
 EXPORT_SYMBOL(target_to_linux_sector);
 
 struct devices_idr_iter {
-	struct config_item *prev_item;
 	int (*fn)(struct se_device *dev, void *data);
 	void *data;
 };
@@ -866,11 +865,9 @@ static int target_devices_idr_iter(int id, void *p, void *data)
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
@@ -880,12 +877,13 @@ static int target_devices_idr_iter(int id, void *p, void *data)
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
@@ -908,7 +906,6 @@ int target_for_each_device(int (*fn)(struct se_device *dev, void *data),
 	mutex_lock(&device_mutex);
 	ret = idr_for_each(&devices_idr, target_devices_idr_iter, &iter);
 	mutex_unlock(&device_mutex);
-	config_item_put(iter.prev_item);
 	return ret;
 }
 
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 4770513944d4..5d8022cdb50a 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1865,7 +1865,10 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
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
index 124ed0e8454e..0396df868bc7 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2032,7 +2032,7 @@ config FB_COBALT
 
 config FB_SH7760
 	bool "SH7760/SH7763/SH7720/SH7721 LCDC support"
-	depends on FB && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763 \
+	depends on FB=y && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763 \
 		|| CPU_SUBTYPE_SH7720 || CPU_SUBTYPE_SH7721)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index e707c4797f76..134237d8b8fc 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -413,6 +413,20 @@ static unsigned int iTCO_wdt_get_timeleft(struct watchdog_device *wd_dev)
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
@@ -501,9 +515,6 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
 		return -ENODEV;	/* Cannot reset NO_REBOOT bit */
 	}
 
-	/* Set the NO_REBOOT bit to prevent later reboots, just for sure */
-	p->update_no_reboot_bit(p->no_reboot_priv, true);
-
 	if (turn_SMI_watchdog_clear_off >= p->iTCO_version) {
 		/*
 		 * Bit 13: TCO_EN -> 0
@@ -555,8 +566,13 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
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
index 544711104989..230e77f9637c 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -83,23 +83,13 @@ const struct evtchn_ops *evtchn_ops;
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
@@ -214,6 +204,22 @@ static void set_info_for_irq(unsigned int irq, struct irq_info *info)
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
@@ -548,33 +554,36 @@ static void xen_irq_lateeoi_worker(struct work_struct *work)
 
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
@@ -589,16 +598,15 @@ static void xen_cpu_init_eoi(unsigned int cpu)
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
 
@@ -617,6 +625,7 @@ static void xen_irq_init(unsigned irq)
 
 	info->type = IRQT_UNBOUND;
 	info->refcnt = -1;
+	INIT_RCU_WORK(&info->rwork, delayed_free_irq);
 
 	set_info_for_irq(irq, info);
 
@@ -669,31 +678,18 @@ static int __must_check xen_allocate_irq_gsi(unsigned gsi)
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
@@ -1604,7 +1600,14 @@ static void __xen_evtchn_do_upcall(void)
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
@@ -1621,7 +1624,7 @@ static void __xen_evtchn_do_upcall(void)
 	} while (count != 1 || vcpu_info->evtchn_upcall_pending);
 
 out:
-	read_unlock(&evtchn_rwlock);
+	rcu_read_unlock();
 
 	/*
 	 * Increment irq_epoch only now to defer EOIs only for
diff --git a/drivers/xen/events/events_internal.h b/drivers/xen/events/events_internal.h
index eb012fbb62e7..db64f48124c2 100644
--- a/drivers/xen/events/events_internal.h
+++ b/drivers/xen/events/events_internal.h
@@ -6,6 +6,7 @@
  */
 #ifndef __EVENTS_INTERNAL_H__
 #define __EVENTS_INTERNAL_H__
+#include <linux/rcupdate.h>
 
 /* Interrupt types. */
 enum xen_irq_type {
@@ -31,6 +32,7 @@ enum xen_irq_type {
 struct irq_info {
 	struct list_head list;
 	struct list_head eoi_list;
+	struct rcu_work rwork;
 	short refcnt;
 	short spurious_cnt;
 	short type;		/* type */
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 39bcbfab386d..28aef31a6e6f 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -345,10 +345,9 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
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
index 8d21019bbbab..ea8b5b2d859d 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2135,7 +2135,7 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	 * calculated f_bavail.
 	 */
 	if (!mixed && block_rsv->space_info->full &&
-	    total_free_meta - thresh < block_rsv->size)
+	    (total_free_meta < thresh || total_free_meta - thresh < block_rsv->size))
 		buf->f_bavail = 0;
 
 	buf->f_type = BTRFS_SUPER_MAGIC;
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 604fef3b2ddf..4d02116193de 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1529,7 +1529,7 @@ struct ext4_sb_info {
 	struct task_struct *s_mmp_tsk;
 
 	/* record the last minlen when FITRIM is called. */
-	atomic_t s_last_trim_minblks;
+	unsigned long s_last_trim_minblks;
 
 	/* Reference to checksum algorithm driver via cryptoapi */
 	struct crypto_shash *s_chksum_driver;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index be5c2e53b636..9099e112fda5 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/nospec.h>
 #include <linux/backing-dev.h>
+#include <linux/freezer.h>
 #include <trace/events/ext4.h>
 
 #ifdef CONFIG_EXT4_DEBUG
@@ -5159,19 +5160,19 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
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
@@ -5194,6 +5195,71 @@ __acquires(bitlock)
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
@@ -5217,10 +5283,8 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 		   ext4_grpblk_t start, ext4_grpblk_t max,
 		   ext4_grpblk_t minblocks)
 {
-	void *bitmap;
-	ext4_grpblk_t next, count = 0, free_count = 0;
 	struct ext4_buddy e4b;
-	int ret = 0;
+	int ret;
 
 	trace_ext4_trim_all_free(sb, group, start, max);
 
@@ -5230,58 +5294,20 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
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
@@ -5326,7 +5352,7 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 		if (minlen > EXT4_CLUSTERS_PER_GROUP(sb))
 			goto out;
 	}
-	if (end >= max_blks)
+	if (end >= max_blks - 1)
 		end = max_blks - 1;
 	if (end <= first_data_blk)
 		goto out;
@@ -5343,6 +5369,8 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 	end = EXT4_CLUSTERS_PER_GROUP(sb) - 1;
 
 	for (group = first_group; group <= last_group; group++) {
+		if (ext4_trim_interrupted())
+			break;
 		grp = ext4_get_group_info(sb, group);
 		/* We only do this if the grp has never been initialized */
 		if (unlikely(EXT4_MB_GRP_NEED_INIT(grp))) {
@@ -5359,10 +5387,9 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
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
@@ -5378,7 +5405,7 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 	}
 
 	if (!ret)
-		atomic_set(&EXT4_SB(sb)->s_last_trim_minblks, minlen);
+		EXT4_SB(sb)->s_last_trim_minblks = minlen;
 
 out:
 	range->len = EXT4_C2B(EXT4_SB(sb), trimmed) << sb->s_blocksize_bits;
@@ -5407,8 +5434,7 @@ ext4_mballoc_query_range(
 
 	ext4_lock_group(sb, group);
 
-	start = (e4b.bd_info->bb_first_free > start) ?
-		e4b.bd_info->bb_first_free : start;
+	start = max(e4b.bd_info->bb_first_free, start);
 	if (end >= EXT4_CLUSTERS_PER_GROUP(sb))
 		end = EXT4_CLUSTERS_PER_GROUP(sb) - 1;
 
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index fa1c920afb49..1b88b78f40be 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1280,6 +1280,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 		case -EPFNOSUPPORT:
 		case -EPROTONOSUPPORT:
 		case -EOPNOTSUPP:
+		case -EINVAL:
 		case -ECONNREFUSED:
 		case -ECONNRESET:
 		case -EHOSTDOWN:
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index a4dc182e8989..fcd35c98a937 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -411,7 +411,9 @@ extern int __init register_nfs_fs(void);
 extern void __exit unregister_nfs_fs(void);
 extern bool nfs_sb_active(struct super_block *sb);
 extern void nfs_sb_deactive(struct super_block *sb);
-
+extern int nfs_client_for_each_server(struct nfs_client *clp,
+				      int (*fn)(struct nfs_server *, void *),
+				      void *data);
 /* io.c */
 extern void nfs_start_io_read(struct inode *inode);
 extern void nfs_end_io_read(struct inode *inode);
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 01b185670594..1aacb0aa07f0 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -61,6 +61,7 @@
 #include "nfs4session.h"
 #include "pnfs.h"
 #include "netns.h"
+#include "nfs4trace.h"
 
 #define NFSDBG_FACILITY		NFSDBG_STATE
 
@@ -2525,6 +2526,7 @@ static void nfs4_state_manager(struct nfs_client *clp)
 
 	/* Ensure exclusive access to NFSv4 state */
 	do {
+		trace_nfs4_state_mgr(clp);
 		clear_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
 		if (test_bit(NFS4CLNT_PURGE_STATE, &clp->cl_state)) {
 			section = "purge state";
@@ -2621,6 +2623,13 @@ static void nfs4_state_manager(struct nfs_client *clp)
 		nfs4_end_drain_session(clp);
 		nfs4_clear_state_manager_bit(clp);
 
+		if (test_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state) &&
+		    !test_and_set_bit(NFS4CLNT_MANAGER_RUNNING,
+				      &clp->cl_state)) {
+			memflags = memalloc_nofs_save();
+			continue;
+		}
+
 		if (!test_and_set_bit(NFS4CLNT_DELEGRETURN_RUNNING, &clp->cl_state)) {
 			if (test_and_clear_bit(NFS4CLNT_DELEGRETURN, &clp->cl_state)) {
 				nfs_client_return_marked_delegations(clp);
@@ -2641,6 +2650,7 @@ static void nfs4_state_manager(struct nfs_client *clp)
 out_error:
 	if (strlen(section))
 		section_sep = ": ";
+	trace_nfs4_state_mgr_failed(clp, section, status);
 	pr_warn_ratelimited("NFS: state manager%s%s failed on NFSv4 server %s"
 			" with error %d\n", section_sep, section,
 			clp->cl_hostname, -status);
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 2295a934a154..010ee5e6fa32 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -563,6 +563,99 @@ TRACE_EVENT(nfs4_setup_sequence,
 		)
 );
 
+TRACE_DEFINE_ENUM(NFS4CLNT_MANAGER_RUNNING);
+TRACE_DEFINE_ENUM(NFS4CLNT_CHECK_LEASE);
+TRACE_DEFINE_ENUM(NFS4CLNT_LEASE_EXPIRED);
+TRACE_DEFINE_ENUM(NFS4CLNT_RECLAIM_REBOOT);
+TRACE_DEFINE_ENUM(NFS4CLNT_RECLAIM_NOGRACE);
+TRACE_DEFINE_ENUM(NFS4CLNT_DELEGRETURN);
+TRACE_DEFINE_ENUM(NFS4CLNT_SESSION_RESET);
+TRACE_DEFINE_ENUM(NFS4CLNT_LEASE_CONFIRM);
+TRACE_DEFINE_ENUM(NFS4CLNT_SERVER_SCOPE_MISMATCH);
+TRACE_DEFINE_ENUM(NFS4CLNT_PURGE_STATE);
+TRACE_DEFINE_ENUM(NFS4CLNT_BIND_CONN_TO_SESSION);
+TRACE_DEFINE_ENUM(NFS4CLNT_MOVED);
+TRACE_DEFINE_ENUM(NFS4CLNT_LEASE_MOVED);
+TRACE_DEFINE_ENUM(NFS4CLNT_DELEGATION_EXPIRED);
+TRACE_DEFINE_ENUM(NFS4CLNT_RUN_MANAGER);
+TRACE_DEFINE_ENUM(NFS4CLNT_DELEGRETURN_RUNNING);
+
+#define show_nfs4_clp_state(state) \
+	__print_flags(state, "|", \
+		{ NFS4CLNT_MANAGER_RUNNING,	"MANAGER_RUNNING" }, \
+		{ NFS4CLNT_CHECK_LEASE,		"CHECK_LEASE" }, \
+		{ NFS4CLNT_LEASE_EXPIRED,	"LEASE_EXPIRED" }, \
+		{ NFS4CLNT_RECLAIM_REBOOT,	"RECLAIM_REBOOT" }, \
+		{ NFS4CLNT_RECLAIM_NOGRACE,	"RECLAIM_NOGRACE" }, \
+		{ NFS4CLNT_DELEGRETURN,		"DELEGRETURN" }, \
+		{ NFS4CLNT_SESSION_RESET,	"SESSION_RESET" }, \
+		{ NFS4CLNT_LEASE_CONFIRM,	"LEASE_CONFIRM" }, \
+		{ NFS4CLNT_SERVER_SCOPE_MISMATCH, \
+						"SERVER_SCOPE_MISMATCH" }, \
+		{ NFS4CLNT_PURGE_STATE,		"PURGE_STATE" }, \
+		{ NFS4CLNT_BIND_CONN_TO_SESSION, \
+						"BIND_CONN_TO_SESSION" }, \
+		{ NFS4CLNT_MOVED,		"MOVED" }, \
+		{ NFS4CLNT_LEASE_MOVED,		"LEASE_MOVED" }, \
+		{ NFS4CLNT_DELEGATION_EXPIRED,	"DELEGATION_EXPIRED" }, \
+		{ NFS4CLNT_RUN_MANAGER,		"RUN_MANAGER" }, \
+		{ NFS4CLNT_DELEGRETURN_RUNNING,	"DELEGRETURN_RUNNING" })
+
+TRACE_EVENT(nfs4_state_mgr,
+		TP_PROTO(
+			const struct nfs_client *clp
+		),
+
+		TP_ARGS(clp),
+
+		TP_STRUCT__entry(
+			__field(unsigned long, state)
+			__string(hostname, clp->cl_hostname)
+		),
+
+		TP_fast_assign(
+			__entry->state = clp->cl_state;
+			__assign_str(hostname, clp->cl_hostname)
+		),
+
+		TP_printk(
+			"hostname=%s clp state=%s", __get_str(hostname),
+			show_nfs4_clp_state(__entry->state)
+		)
+)
+
+TRACE_EVENT(nfs4_state_mgr_failed,
+		TP_PROTO(
+			const struct nfs_client *clp,
+			const char *section,
+			int status
+		),
+
+		TP_ARGS(clp, section, status),
+
+		TP_STRUCT__entry(
+			__field(unsigned long, error)
+			__field(unsigned long, state)
+			__string(hostname, clp->cl_hostname)
+			__string(section, section)
+		),
+
+		TP_fast_assign(
+			__entry->error = status;
+			__entry->state = clp->cl_state;
+			__assign_str(hostname, clp->cl_hostname);
+			__assign_str(section, section);
+		),
+
+		TP_printk(
+			"hostname=%s clp state=%s error=%ld (%s) section=%s",
+			__get_str(hostname),
+			show_nfs4_clp_state(__entry->state), -__entry->error,
+			show_nfsv4_errors(__entry->error), __get_str(section)
+
+		)
+)
+
 TRACE_EVENT(nfs4_xdr_status,
 		TP_PROTO(
 			const struct xdr_stream *xdr,
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index ecc7277b3eda..c7ca8cdc8801 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -436,6 +436,41 @@ void nfs_sb_deactive(struct super_block *sb)
 }
 EXPORT_SYMBOL_GPL(nfs_sb_deactive);
 
+static int __nfs_list_for_each_server(struct list_head *head,
+		int (*fn)(struct nfs_server *, void *),
+		void *data)
+{
+	struct nfs_server *server, *last = NULL;
+	int ret = 0;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(server, head, client_link) {
+		if (!(server->super && nfs_sb_active(server->super)))
+			continue;
+		rcu_read_unlock();
+		if (last)
+			nfs_sb_deactive(last->super);
+		last = server;
+		ret = fn(server, data);
+		if (ret)
+			goto out;
+		rcu_read_lock();
+	}
+	rcu_read_unlock();
+out:
+	if (last)
+		nfs_sb_deactive(last->super);
+	return ret;
+}
+
+int nfs_client_for_each_server(struct nfs_client *clp,
+		int (*fn)(struct nfs_server *, void *),
+		void *data)
+{
+	return __nfs_list_for_each_server(&clp->cl_superblocks, fn, data);
+}
+EXPORT_SYMBOL_GPL(nfs_client_for_each_server);
+
 /*
  * Deliver file system statistics to userspace
  */
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
index b216a28920f2..4182fa746d49 100644
--- a/include/linux/if_team.h
+++ b/include/linux/if_team.h
@@ -192,6 +192,8 @@ struct team {
 	struct net_device *dev; /* associated netdevice */
 	struct team_pcpu_stats __percpu *pcpu_stats;
 
+	const struct header_ops *header_ops_cache;
+
 	struct mutex lock; /* used for overall locking, e.g. port lists write */
 
 	/*
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 2e448d65a04c..c0ecda7e7f08 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -261,6 +261,10 @@ enum {
 	ATA_HOST_PARALLEL_SCAN	= (1 << 2),	/* Ports on this host can be scanned in parallel */
 	ATA_HOST_IGNORE_ATA	= (1 << 3),	/* Ignore ATA devices on this host. */
 
+	ATA_HOST_NO_PART	= (1 << 4), /* Host does not support partial */
+	ATA_HOST_NO_SSC		= (1 << 5), /* Host does not support slumber */
+	ATA_HOST_NO_DEVSLP	= (1 << 6), /* Host does not support devslp */
+
 	/* bits 24:31 of host->flags are reserved for LLD specific flags */
 
 	/* various lengths of time */
@@ -294,7 +298,7 @@ enum {
 	 * advised to wait only for the following duration before
 	 * doing SRST.
 	 */
-	ATA_TMOUT_PMP_SRST_WAIT	= 5000,
+	ATA_TMOUT_PMP_SRST_WAIT	= 10000,
 
 	/* When the LPM policy is set to ATA_LPM_MAX_POWER, there might
 	 * be a spurious PHY event, so ignore the first PHY event that
diff --git a/include/linux/netfilter/nf_conntrack_sctp.h b/include/linux/netfilter/nf_conntrack_sctp.h
index 625f491b95de..fb31312825ae 100644
--- a/include/linux/netfilter/nf_conntrack_sctp.h
+++ b/include/linux/netfilter/nf_conntrack_sctp.h
@@ -9,6 +9,7 @@ struct ip_ct_sctp {
 	enum sctp_conntrack state;
 
 	__be32 vtag[IP_CT_DIR_MAX];
+	u8 init[IP_CT_DIR_MAX];
 	u8 last_dir;
 	u8 flags;
 };
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 3192ade55ad1..2a17c0b42394 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -343,12 +343,14 @@ ssize_t tcp_splice_read(struct socket *sk, loff_t *ppos,
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
index cb0631098f91..e5250a9b813d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -780,7 +780,9 @@ union bpf_attr {
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
diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
index f697647ceb54..26ba7cb01136 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -118,7 +118,12 @@ static int __queue_map_get(struct bpf_map *map, void *value, bool delete)
 	int err = 0;
 	void *ptr;
 
-	raw_spin_lock_irqsave(&qs->lock, flags);
+	if (in_nmi()) {
+		if (!raw_spin_trylock_irqsave(&qs->lock, flags))
+			return -EBUSY;
+	} else {
+		raw_spin_lock_irqsave(&qs->lock, flags);
+	}
 
 	if (queue_stack_map_is_empty(qs)) {
 		memset(value, 0, qs->map.value_size);
@@ -148,7 +153,12 @@ static int __stack_map_get(struct bpf_map *map, void *value, bool delete)
 	void *ptr;
 	u32 index;
 
-	raw_spin_lock_irqsave(&qs->lock, flags);
+	if (in_nmi()) {
+		if (!raw_spin_trylock_irqsave(&qs->lock, flags))
+			return -EBUSY;
+	} else {
+		raw_spin_lock_irqsave(&qs->lock, flags);
+	}
 
 	if (queue_stack_map_is_empty(qs)) {
 		memset(value, 0, qs->map.value_size);
@@ -213,7 +223,12 @@ static int queue_stack_map_push_elem(struct bpf_map *map, void *value,
 	if (flags & BPF_NOEXIST || flags > BPF_EXIST)
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&qs->lock, irq_flags);
+	if (in_nmi()) {
+		if (!raw_spin_trylock_irqsave(&qs->lock, irq_flags))
+			return -EBUSY;
+	} else {
+		raw_spin_lock_irqsave(&qs->lock, irq_flags);
+	}
 
 	if (queue_stack_map_is_full(qs)) {
 		if (!replace) {
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 445475c229b3..9d6ba3879196 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -742,6 +742,9 @@ __poll_t ring_buffer_poll_wait(struct ring_buffer *buffer, int cpu,
 	if (full) {
 		poll_wait(filp, &work->full_waiters, poll_table);
 		work->full_waiters_pending = true;
+		if (!cpu_buffer->shortest_full ||
+		    cpu_buffer->shortest_full > full)
+			cpu_buffer->shortest_full = full;
 	} else {
 		poll_wait(filp, &work->waiters, poll_table);
 		work->waiters_pending = true;
@@ -1821,6 +1824,8 @@ int ring_buffer_resize(struct ring_buffer *buffer, unsigned long size,
 				err = -ENOMEM;
 				goto out_err;
 			}
+
+			cond_resched();
 		}
 
 		get_online_cpus();
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f9c64329ec15..85ad403006a2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4244,6 +4244,33 @@ int tracing_open_generic_tr(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+/*
+ * The private pointer of the inode is the trace_event_file.
+ * Update the tr ref count associated to it.
+ */
+int tracing_open_file_tr(struct inode *inode, struct file *filp)
+{
+	struct trace_event_file *file = inode->i_private;
+	int ret;
+
+	ret = tracing_check_open_get_tr(file->tr);
+	if (ret)
+		return ret;
+
+	filp->private_data = inode->i_private;
+
+	return 0;
+}
+
+int tracing_release_file_tr(struct inode *inode, struct file *filp)
+{
+	struct trace_event_file *file = inode->i_private;
+
+	trace_array_put(file->tr);
+
+	return 0;
+}
+
 static int tracing_release(struct inode *inode, struct file *file)
 {
 	struct trace_array *tr = inode->i_private;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 21f85c0bd66e..f1f54111b856 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -680,6 +680,8 @@ void tracing_reset_all_online_cpus(void);
 void tracing_reset_all_online_cpus_unlocked(void);
 int tracing_open_generic(struct inode *inode, struct file *filp);
 int tracing_open_generic_tr(struct inode *inode, struct file *filp);
+int tracing_open_file_tr(struct inode *inode, struct file *filp);
+int tracing_release_file_tr(struct inode *inode, struct file *filp);
 bool tracing_is_disabled(void);
 bool tracer_tracing_is_on(struct trace_array *tr);
 void tracer_tracing_on(struct trace_array *tr);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 0c21da12b650..51adf0817ef3 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1699,9 +1699,10 @@ static const struct file_operations ftrace_set_event_pid_fops = {
 };
 
 static const struct file_operations ftrace_enable_fops = {
-	.open = tracing_open_generic,
+	.open = tracing_open_file_tr,
 	.read = event_enable_read,
 	.write = event_enable_write,
+	.release = tracing_release_file_tr,
 	.llseek = default_llseek,
 };
 
@@ -1718,9 +1719,10 @@ static const struct file_operations ftrace_event_id_fops = {
 };
 
 static const struct file_operations ftrace_event_filter_fops = {
-	.open = tracing_open_generic,
+	.open = tracing_open_file_tr,
 	.read = event_filter_read,
 	.write = event_filter_write,
+	.release = tracing_release_file_tr,
 	.llseek = default_llseek,
 };
 
diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index a92d5359b5c0..4f8eb83976f1 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -118,7 +118,7 @@ static int deliver_clone(const struct net_bridge_port *prev,
 
 	skb = skb_clone(skb, GFP_ATOMIC);
 	if (!skb) {
-		dev->stats.tx_dropped++;
+		DEV_STATS_INC(dev, tx_dropped);
 		return -ENOMEM;
 	}
 
@@ -255,7 +255,7 @@ static void maybe_deliver_addr(struct net_bridge_port *p, struct sk_buff *skb,
 
 	skb = skb_copy(skb, GFP_ATOMIC);
 	if (!skb) {
-		dev->stats.tx_dropped++;
+		DEV_STATS_INC(dev, tx_dropped);
 		return;
 	}
 
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 464f6a619444..3d07dedd93bd 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -141,12 +141,12 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
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
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 154490415231..c0489d8812c0 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -935,7 +935,9 @@ static void neigh_periodic_work(struct work_struct *work)
 			    (state == NUD_FAILED ||
 			     !time_in_range_open(jiffies, n->used,
 						 n->used + NEIGH_VAR(n->parms, GC_STALETIME)))) {
-				*np = n->next;
+				rcu_assign_pointer(*np,
+					rcu_dereference_protected(n->next,
+						lockdep_is_held(&tbl->lock)));
 				neigh_mark_dead(n);
 				write_unlock(&n->lock);
 				neigh_cleanup_and_release(n);
diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index bc4fef1250f4..249beb41ff89 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -243,13 +243,8 @@ static int dccp_v4_err(struct sk_buff *skb, u32 info)
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
+		return -EINVAL;
 	dh = (struct dccp_hdr *)(skb->data + offset);
 	if (!pskb_may_pull(skb, offset + __dccp_basic_hdr_len(dh)))
 		return -EINVAL;
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index 5554752c2182..a7e393902253 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -76,13 +76,8 @@ static int dccp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
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
+		return -EINVAL;
 	dh = (struct dccp_hdr *)(skb->data + offset);
 	if (!pskb_may_pull(skb, offset + __dccp_basic_hdr_len(dh)))
 		return -EINVAL;
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 7004e379c325..f82d456afd0e 100644
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
index 1dfc1a5c21cd..ec3c23adbab4 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -178,6 +178,19 @@ static void tcp_measure_rcv_mss(struct sock *sk, const struct sk_buff *skb)
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
index 6ac84b273ffb..4c90a61148da 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -179,8 +179,7 @@ static void tcp_event_data_sent(struct tcp_sock *tp,
 }
 
 /* Account for an ACK we sent. */
-static inline void tcp_event_ack_sent(struct sock *sk, unsigned int pkts,
-				      u32 rcv_nxt)
+static inline void tcp_event_ack_sent(struct sock *sk, u32 rcv_nxt)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
@@ -194,7 +193,7 @@ static inline void tcp_event_ack_sent(struct sock *sk, unsigned int pkts,
 
 	if (unlikely(rcv_nxt != tp->rcv_nxt))
 		return;  /* Special ACK sent by DCTCP to reflect ECN */
-	tcp_dec_quickack_mode(sk, pkts);
+	tcp_dec_quickack_mode(sk);
 	inet_csk_clear_xmit_timer(sk, ICSK_TIME_DACK);
 }
 
@@ -1152,7 +1151,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 	icsk->icsk_af_ops->send_check(sk, skb);
 
 	if (likely(tcb->tcp_flags & TCPHDR_ACK))
-		tcp_event_ack_sent(sk, tcp_skb_pcount(skb), rcv_nxt);
+		tcp_event_ack_sent(sk, rcv_nxt);
 
 	if (skb->len != tcp_header_size) {
 		tcp_event_data_sent(tp, sk);
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index 307cf20b6649..f91542e2f679 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -521,7 +521,6 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	 */
 	if (len > INT_MAX - transhdrlen)
 		return -EMSGSIZE;
-	ulen = len + transhdrlen;
 
 	/* Mirror BSD error message compatibility */
 	if (msg->msg_flags & MSG_OOB)
@@ -645,6 +644,7 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 back_from_confirm:
 	lock_sock(sk);
+	ulen = len + skb_queue_empty(&sk->sk_write_queue) ? transhdrlen : 0;
 	err = ip6_append_data(sk, ip_generic_getfrag, msg,
 			      ulen, transhdrlen, &ipc6,
 			      &fl6, (struct rt6_info *)dst,
diff --git a/net/ncsi/ncsi-aen.c b/net/ncsi/ncsi-aen.c
index 62fb1031763d..f8854bff286c 100644
--- a/net/ncsi/ncsi-aen.c
+++ b/net/ncsi/ncsi-aen.c
@@ -89,6 +89,11 @@ static int ncsi_aen_handler_lsc(struct ncsi_dev_priv *ndp,
 	if ((had_link == has_link) || chained)
 		return 0;
 
+	if (had_link)
+		netif_carrier_off(ndp->ndev.dev);
+	else
+		netif_carrier_on(ndp->ndev.dev);
+
 	if (!ndp->multi_package && !nc->package->multi_channel) {
 		if (had_link) {
 			ndp->flags |= NCSI_DEV_RESHUFFLE;
diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 1cf143f5df2e..d3be0d0b0bda 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -530,6 +530,14 @@ __ip_set_put(struct ip_set *set)
 /* set->ref can be swapped out by ip_set_swap, netlink events (like dump) need
  * a separate reference counter
  */
+static void
+__ip_set_get_netlink(struct ip_set *set)
+{
+	write_lock_bh(&ip_set_ref_lock);
+	set->ref_netlink++;
+	write_unlock_bh(&ip_set_ref_lock);
+}
+
 static inline void
 __ip_set_put_netlink(struct ip_set *set)
 {
@@ -1529,11 +1537,11 @@ call_ad(struct sock *ctnl, struct sk_buff *skb, struct ip_set *set,
 
 	do {
 		if (retried) {
-			__ip_set_get(set);
+			__ip_set_get_netlink(set);
 			nfnl_unlock(NFNL_SUBSYS_IPSET);
 			cond_resched();
 			nfnl_lock(NFNL_SUBSYS_IPSET);
-			__ip_set_put(set);
+			__ip_set_put_netlink(set);
 		}
 
 		ip_set_lock(set);
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index 0c1bc654245c..b0054bdf92a2 100644
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
diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf_conntrack_proto_sctp.c
index 21cbaf6dac33..e7545bcca805 100644
--- a/net/netfilter/nf_conntrack_proto_sctp.c
+++ b/net/netfilter/nf_conntrack_proto_sctp.c
@@ -112,7 +112,7 @@ static const u8 sctp_conntracks[2][11][SCTP_CONNTRACK_MAX] = {
 /* shutdown_ack */ {sSA, sCL, sCW, sCE, sES, sSA, sSA, sSA, sSA},
 /* error        */ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sSA, sCL},/* Can't have Stale cookie*/
 /* cookie_echo  */ {sCL, sCL, sCE, sCE, sES, sSS, sSR, sSA, sCL},/* 5.2.4 - Big TODO */
-/* cookie_ack   */ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sSA, sCL},/* Can't come in orig dir */
+/* cookie_ack   */ {sCL, sCL, sCW, sES, sES, sSS, sSR, sSA, sCL},/* Can't come in orig dir */
 /* shutdown_comp*/ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sCL, sCL},
 /* heartbeat    */ {sHS, sCL, sCW, sCE, sES, sSS, sSR, sSA, sHS},
 /* heartbeat_ack*/ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sSA, sHS},
@@ -126,7 +126,7 @@ static const u8 sctp_conntracks[2][11][SCTP_CONNTRACK_MAX] = {
 /* shutdown     */ {sIV, sCL, sCW, sCE, sSR, sSS, sSR, sSA, sIV},
 /* shutdown_ack */ {sIV, sCL, sCW, sCE, sES, sSA, sSA, sSA, sIV},
 /* error        */ {sIV, sCL, sCW, sCL, sES, sSS, sSR, sSA, sIV},
-/* cookie_echo  */ {sIV, sCL, sCW, sCE, sES, sSS, sSR, sSA, sIV},/* Can't come in reply dir */
+/* cookie_echo  */ {sIV, sCL, sCE, sCE, sES, sSS, sSR, sSA, sIV},/* Can't come in reply dir */
 /* cookie_ack   */ {sIV, sCL, sCW, sES, sES, sSS, sSR, sSA, sIV},
 /* shutdown_comp*/ {sIV, sCL, sCW, sCE, sES, sSS, sSR, sCL, sIV},
 /* heartbeat    */ {sIV, sCL, sCW, sCE, sES, sSS, sSR, sSA, sHS},
@@ -426,6 +426,9 @@ int nf_conntrack_sctp_packet(struct nf_conn *ct,
 			/* (D) vtag must be same as init_vtag as found in INIT_ACK */
 			if (sh->vtag != ct->proto.sctp.vtag[dir])
 				goto out_unlock;
+		} else if (sch->type == SCTP_CID_COOKIE_ACK) {
+			ct->proto.sctp.init[dir] = 0;
+			ct->proto.sctp.init[!dir] = 0;
 		} else if (sch->type == SCTP_CID_HEARTBEAT) {
 			if (ct->proto.sctp.vtag[dir] == 0) {
 				pr_debug("Setting %d vtag %x for dir %d\n", sch->type, sh->vtag, dir);
@@ -474,16 +477,18 @@ int nf_conntrack_sctp_packet(struct nf_conn *ct,
 		}
 
 		/* If it is an INIT or an INIT ACK note down the vtag */
-		if (sch->type == SCTP_CID_INIT ||
-		    sch->type == SCTP_CID_INIT_ACK) {
-			struct sctp_inithdr _inithdr, *ih;
+		if (sch->type == SCTP_CID_INIT) {
+			struct sctp_inithdr _ih, *ih;
 
-			ih = skb_header_pointer(skb, offset + sizeof(_sch),
-						sizeof(_inithdr), &_inithdr);
-			if (ih == NULL)
+			ih = skb_header_pointer(skb, offset + sizeof(_sch), sizeof(*ih), &_ih);
+			if (!ih)
 				goto out_unlock;
-			pr_debug("Setting vtag %x for dir %d\n",
-				 ih->init_tag, !dir);
+
+			if (ct->proto.sctp.init[dir] && ct->proto.sctp.init[!dir])
+				ct->proto.sctp.init[!dir] = 0;
+			ct->proto.sctp.init[dir] = 1;
+
+			pr_debug("Setting vtag %x for dir %d\n", ih->init_tag, !dir);
 			ct->proto.sctp.vtag[!dir] = ih->init_tag;
 
 			/* don't renew timeout on init retransmit so
@@ -494,6 +499,24 @@ int nf_conntrack_sctp_packet(struct nf_conn *ct,
 			    old_state == SCTP_CONNTRACK_CLOSED &&
 			    nf_ct_is_confirmed(ct))
 				ignore = true;
+		} else if (sch->type == SCTP_CID_INIT_ACK) {
+			struct sctp_inithdr _ih, *ih;
+			__be32 vtag;
+
+			ih = skb_header_pointer(skb, offset + sizeof(_sch), sizeof(*ih), &_ih);
+			if (!ih)
+				goto out_unlock;
+
+			vtag = ct->proto.sctp.vtag[!dir];
+			if (!ct->proto.sctp.init[!dir] && vtag && vtag != ih->init_tag)
+				goto out_unlock;
+			/* collision */
+			if (ct->proto.sctp.init[dir] && ct->proto.sctp.init[!dir] &&
+			    vtag != ih->init_tag)
+				goto out_unlock;
+
+			pr_debug("Setting vtag %x for dir %d\n", ih->init_tag, !dir);
+			ct->proto.sctp.vtag[!dir] = ih->init_tag;
 		}
 
 		ct->proto.sctp.state = new_state;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index a1a1f715fb62..9fc4431242e2 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1047,8 +1047,7 @@ static int nft_flush_table(struct nft_ctx *ctx)
 		if (!nft_is_active_next(ctx->net, set))
 			continue;
 
-		if (nft_set_is_anonymous(set) &&
-		    !list_empty(&set->bindings))
+		if (nft_set_is_anonymous(set))
 			continue;
 
 		err = nft_delset(ctx, set);
@@ -5066,8 +5065,10 @@ static int nf_tables_delsetelem(struct net *net, struct sock *nlsk,
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
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index ddfd159f64e1..b1107570eaee 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1646,7 +1646,9 @@ int nfc_llcp_register_device(struct nfc_dev *ndev)
 	timer_setup(&local->sdreq_timer, nfc_llcp_sdreq_timer, 0);
 	INIT_WORK(&local->sdreq_timeout_work, nfc_llcp_sdreq_timeout_work);
 
+	spin_lock(&llcp_devices_lock);
 	list_add(&local->list, &llcp_devices);
+	spin_unlock(&llcp_devices_lock);
 
 	return 0;
 }
diff --git a/net/rds/rdma_transport.c b/net/rds/rdma_transport.c
index 5f741e51b4ba..bb38124a5d3d 100644
--- a/net/rds/rdma_transport.c
+++ b/net/rds/rdma_transport.c
@@ -86,10 +86,12 @@ static int rds_rdma_cm_event_handler_cmn(struct rdma_cm_id *cm_id,
 		break;
 
 	case RDMA_CM_EVENT_ADDR_RESOLVED:
-		rdma_set_service_type(cm_id, conn->c_tos);
-		/* XXX do we need to clean up if this fails? */
-		ret = rdma_resolve_route(cm_id,
+		if (conn) {
+			rdma_set_service_type(cm_id, conn->c_tos);
+			/* XXX do we need to clean up if this fails? */
+			ret = rdma_resolve_route(cm_id,
 					 RDS_RDMA_RESOLVE_TIMEOUT_MS);
+		}
 		break;
 
 	case RDMA_CM_EVENT_ROUTE_RESOLVED:
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
index f960b0e1e552..2cdcb72c8826 100644
--- a/net/sctp/associola.c
+++ b/net/sctp/associola.c
@@ -1156,8 +1156,7 @@ int sctp_assoc_update(struct sctp_association *asoc,
 		/* Add any peer addresses from the new association. */
 		list_for_each_entry(trans, &new->peer.transport_addr_list,
 				    transports)
-			if (!sctp_assoc_lookup_paddr(asoc, &trans->ipaddr) &&
-			    !sctp_assoc_add_peer(asoc, &trans->ipaddr,
+			if (!sctp_assoc_add_peer(asoc, &trans->ipaddr,
 						 GFP_ATOMIC, trans->state))
 				return -ENOMEM;
 
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index d1dd261e8b01..cbcbc92748ba 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -2486,6 +2486,7 @@ static int sctp_apply_peer_addr_params(struct sctp_paddrparams *params,
 			if (trans) {
 				trans->hbinterval =
 				    msecs_to_jiffies(params->spp_hbinterval);
+				sctp_transport_reset_hb_timer(trans);
 			} else if (asoc) {
 				asoc->hbinterval =
 				    msecs_to_jiffies(params->spp_hbinterval);
diff --git a/net/socket.c b/net/socket.c
index 146d0733a622..c12e01c4a353 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -641,6 +641,14 @@ static inline int sock_sendmsg_nosec(struct socket *sock, struct msghdr *msg)
 	return ret;
 }
 
+static int __sock_sendmsg(struct socket *sock, struct msghdr *msg)
+{
+	int err = security_socket_sendmsg(sock, msg,
+					  msg_data_left(msg));
+
+	return err ?: sock_sendmsg_nosec(sock, msg);
+}
+
 /**
  *	sock_sendmsg - send a message through @sock
  *	@sock: socket
@@ -651,10 +659,19 @@ static inline int sock_sendmsg_nosec(struct socket *sock, struct msghdr *msg)
  */
 int sock_sendmsg(struct socket *sock, struct msghdr *msg)
 {
-	int err = security_socket_sendmsg(sock, msg,
-					  msg_data_left(msg));
+	struct sockaddr_storage *save_addr = (struct sockaddr_storage *)msg->msg_name;
+	struct sockaddr_storage address;
+	int ret;
 
-	return err ?: sock_sendmsg_nosec(sock, msg);
+	if (msg->msg_name) {
+		memcpy(&address, msg->msg_name, msg->msg_namelen);
+		msg->msg_name = &address;
+	}
+
+	ret = __sock_sendmsg(sock, msg);
+	msg->msg_name = save_addr;
+
+	return ret;
 }
 EXPORT_SYMBOL(sock_sendmsg);
 
@@ -986,7 +1003,7 @@ static ssize_t sock_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (sock->type == SOCK_SEQPACKET)
 		msg.msg_flags |= MSG_EOR;
 
-	res = sock_sendmsg(sock, &msg);
+	res = __sock_sendmsg(sock, &msg);
 	*from = msg.msg_iter;
 	return res;
 }
@@ -1938,7 +1955,7 @@ int __sys_sendto(int fd, void __user *buff, size_t len, unsigned int flags,
 	if (sock->file->f_flags & O_NONBLOCK)
 		flags |= MSG_DONTWAIT;
 	msg.msg_flags = flags;
-	err = sock_sendmsg(sock, &msg);
+	err = __sock_sendmsg(sock, &msg);
 
 out_put:
 	fput_light(sock->file, fput_needed);
@@ -2283,7 +2300,7 @@ static int ____sys_sendmsg(struct socket *sock, struct msghdr *msg_sys,
 		err = sock_sendmsg_nosec(sock, msg_sys);
 		goto out_freectl;
 	}
-	err = sock_sendmsg(sock, msg_sys);
+	err = __sock_sendmsg(sock, msg_sys);
 	/*
 	 * If this is sendmmsg() and sending to current destination address was
 	 * successful, remember it.
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 629c05ff1f3e..9071dc6928ac 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2684,6 +2684,7 @@ rpc_decode_header(struct rpc_task *task, struct xdr_stream *xdr)
 	case rpc_autherr_rejectedverf:
 	case rpcsec_gsserr_credproblem:
 	case rpcsec_gsserr_ctxproblem:
+		rpcauth_invalcred(task);
 		if (!task->tk_cred_retry)
 			break;
 		task->tk_cred_retry--;
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index c91eba751804..8c0d1c191d55 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1455,7 +1455,7 @@ void handle_moddevtable(struct module *mod, struct elf_info *info,
 	/* First handle the "special" cases */
 	if (sym_is(name, namelen, "usb"))
 		do_usb_table(symval, sym->st_size, mod);
-	if (sym_is(name, namelen, "of"))
+	else if (sym_is(name, namelen, "of"))
 		do_of_table(symval, sym->st_size, mod);
 	else if (sym_is(name, namelen, "pnp"))
 		do_pnp_device_entry(symval, sym->st_size, mod);
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index c97ce6265fc6..425c0d5e0a75 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -29,9 +29,11 @@ config IMA
 	  to learn more about IMA.
 	  If unsure, say N.
 
+if IMA
+
 config IMA_KEXEC
 	bool "Enable carrying the IMA measurement list across a soft boot"
-	depends on IMA && TCG_TPM && HAVE_IMA_KEXEC
+	depends on TCG_TPM && HAVE_IMA_KEXEC
 	default n
 	help
 	   TPM PCRs are only reset on a hard reboot.  In order to validate
@@ -43,7 +45,6 @@ config IMA_KEXEC
 
 config IMA_MEASURE_PCR_IDX
 	int
-	depends on IMA
 	range 8 14
 	default 10
 	help
@@ -53,7 +54,7 @@ config IMA_MEASURE_PCR_IDX
 
 config IMA_LSM_RULES
 	bool
-	depends on IMA && AUDIT && (SECURITY_SELINUX || SECURITY_SMACK)
+	depends on AUDIT && (SECURITY_SELINUX || SECURITY_SMACK)
 	default y
 	help
 	  Disabling this option will disregard LSM based policy rules.
@@ -61,7 +62,6 @@ config IMA_LSM_RULES
 choice
 	prompt "Default template"
 	default IMA_NG_TEMPLATE
-	depends on IMA
 	help
 	  Select the default IMA measurement template.
 
@@ -80,14 +80,12 @@ endchoice
 
 config IMA_DEFAULT_TEMPLATE
 	string
-	depends on IMA
 	default "ima-ng" if IMA_NG_TEMPLATE
 	default "ima-sig" if IMA_SIG_TEMPLATE
 
 choice
 	prompt "Default integrity hash algorithm"
 	default IMA_DEFAULT_HASH_SHA1
-	depends on IMA
 	help
 	   Select the default hash algorithm used for the measurement
 	   list, integrity appraisal and audit log.  The compiled default
@@ -113,7 +111,6 @@ endchoice
 
 config IMA_DEFAULT_HASH
 	string
-	depends on IMA
 	default "sha1" if IMA_DEFAULT_HASH_SHA1
 	default "sha256" if IMA_DEFAULT_HASH_SHA256
 	default "sha512" if IMA_DEFAULT_HASH_SHA512
@@ -121,7 +118,6 @@ config IMA_DEFAULT_HASH
 
 config IMA_WRITE_POLICY
 	bool "Enable multiple writes to the IMA policy"
-	depends on IMA
 	default n
 	help
 	  IMA policy can now be updated multiple times.  The new rules get
@@ -132,7 +128,6 @@ config IMA_WRITE_POLICY
 
 config IMA_READ_POLICY
 	bool "Enable reading back the current IMA policy"
-	depends on IMA
 	default y if IMA_WRITE_POLICY
 	default n if !IMA_WRITE_POLICY
 	help
@@ -142,7 +137,6 @@ config IMA_READ_POLICY
 
 config IMA_APPRAISE
 	bool "Appraise integrity measurements"
-	depends on IMA
 	default n
 	help
 	  This option enables local measurement integrity appraisal.
@@ -263,7 +257,7 @@ config IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
 config IMA_BLACKLIST_KEYRING
 	bool "Create IMA machine owner blacklist keyrings (EXPERIMENTAL)"
 	depends on SYSTEM_TRUSTED_KEYRING
-	depends on IMA_TRUSTED_KEYRING
+	depends on INTEGRITY_TRUSTED_KEYRING
 	default n
 	help
 	   This option creates an IMA blacklist keyring, which contains all
@@ -273,7 +267,7 @@ config IMA_BLACKLIST_KEYRING
 
 config IMA_LOAD_X509
 	bool "Load X509 certificate onto the '.ima' trusted keyring"
-	depends on IMA_TRUSTED_KEYRING
+	depends on INTEGRITY_TRUSTED_KEYRING
 	default n
 	help
 	   File signature verification is based on the public keys
@@ -295,3 +289,5 @@ config IMA_APPRAISE_SIGNED_INIT
 	default n
 	help
 	   This option requires user-space init to be signed.
+
+endif
diff --git a/security/smack/smack.h b/security/smack/smack.h
index 335d2411abe4..a567b3808184 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -117,6 +117,7 @@ struct inode_smack {
 struct task_smack {
 	struct smack_known	*smk_task;	/* label for access control */
 	struct smack_known	*smk_forked;	/* label when forked */
+	struct smack_known	*smk_transmuted;/* label when transmuted */
 	struct list_head	smk_rules;	/* per task access rules */
 	struct mutex		smk_rules_lock;	/* lock for the rules */
 	struct list_head	smk_relabel;	/* transit allowed labels */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 0253cd2e2358..9e48c8b36b67 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -982,8 +982,9 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, const char **name,
 				     void **value, size_t *len)
 {
+	struct task_smack *tsp = smack_cred(current_cred());
 	struct inode_smack *issp = smack_inode(inode);
-	struct smack_known *skp = smk_of_current();
+	struct smack_known *skp = smk_of_task(tsp);
 	struct smack_known *isp = smk_of_inode(inode);
 	struct smack_known *dsp = smk_of_inode(dir);
 	int may;
@@ -992,20 +993,34 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
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
 
@@ -1439,10 +1454,19 @@ static int smack_inode_getsecurity(struct inode *inode,
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
+		ispp = smack_inode(inode);
+		if (ispp->smk_flags & SMK_INODE_TRANSMUTE)
+			label = TRANS_TRUE;
+		else
+			label = "";
+	} else {
 		/*
 		 * The rest of the Smack xattrs are only on sockets.
 		 */
@@ -1464,13 +1488,18 @@ static int smack_inode_getsecurity(struct inode *inode,
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
 
 
@@ -4515,7 +4544,7 @@ static int smack_inode_copy_up(struct dentry *dentry, struct cred **new)
 	/*
 	 * Get label from overlay inode and set it in create_sid
 	 */
-	isp = smack_inode(d_inode(dentry->d_parent));
+	isp = smack_inode(d_inode(dentry));
 	skp = isp->smk_inode;
 	tsp->smk_task = skp;
 	*new = new_creds;
@@ -4566,8 +4595,10 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
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
index 9b7a345233cf..01e53f1444ae 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2237,6 +2237,7 @@ static struct snd_pci_quirk power_save_blacklist[] = {
 	SND_PCI_QUIRK(0x8086, 0x2068, "Intel NUC7i3BNB", 0),
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=198611 */
 	SND_PCI_QUIRK(0x17aa, 0x2227, "Lenovo X1 Carbon 3rd Gen", 0),
+	SND_PCI_QUIRK(0x17aa, 0x316e, "Lenovo ThinkCentre M70q", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1689623 */
 	SND_PCI_QUIRK(0x17aa, 0x367b, "Lenovo IdeaCentre B550", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1572975 */
diff --git a/sound/soc/fsl/imx-audmix.c b/sound/soc/fsl/imx-audmix.c
index 08c044a72250..119a3a9684f5 100644
--- a/sound/soc/fsl/imx-audmix.c
+++ b/sound/soc/fsl/imx-audmix.c
@@ -322,7 +322,7 @@ static int imx_audmix_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->cpu_mclk)) {
 		ret = PTR_ERR(priv->cpu_mclk);
 		dev_err(&cpu_pdev->dev, "failed to get DAI mclk1: %d\n", ret);
-		return -EINVAL;
+		return ret;
 	}
 
 	priv->audmix_pdev = audmix_pdev;
diff --git a/sound/soc/meson/axg-spdifin.c b/sound/soc/meson/axg-spdifin.c
index d0d09f945b48..7aaded1fc376 100644
--- a/sound/soc/meson/axg-spdifin.c
+++ b/sound/soc/meson/axg-spdifin.c
@@ -112,34 +112,6 @@ static int axg_spdifin_prepare(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int axg_spdifin_startup(struct snd_pcm_substream *substream,
-			       struct snd_soc_dai *dai)
-{
-	struct axg_spdifin *priv = snd_soc_dai_get_drvdata(dai);
-	int ret;
-
-	ret = clk_prepare_enable(priv->refclk);
-	if (ret) {
-		dev_err(dai->dev,
-			"failed to enable spdifin reference clock\n");
-		return ret;
-	}
-
-	regmap_update_bits(priv->map, SPDIFIN_CTRL0, SPDIFIN_CTRL0_EN,
-			   SPDIFIN_CTRL0_EN);
-
-	return 0;
-}
-
-static void axg_spdifin_shutdown(struct snd_pcm_substream *substream,
-				 struct snd_soc_dai *dai)
-{
-	struct axg_spdifin *priv = snd_soc_dai_get_drvdata(dai);
-
-	regmap_update_bits(priv->map, SPDIFIN_CTRL0, SPDIFIN_CTRL0_EN, 0);
-	clk_disable_unprepare(priv->refclk);
-}
-
 static void axg_spdifin_write_mode_param(struct regmap *map, int mode,
 					 unsigned int val,
 					 unsigned int num_per_reg,
@@ -251,25 +223,38 @@ static int axg_spdifin_dai_probe(struct snd_soc_dai *dai)
 	ret = axg_spdifin_sample_mode_config(dai, priv);
 	if (ret) {
 		dev_err(dai->dev, "mode configuration failed\n");
-		clk_disable_unprepare(priv->pclk);
-		return ret;
+		goto pclk_err;
 	}
 
+	ret = clk_prepare_enable(priv->refclk);
+	if (ret) {
+		dev_err(dai->dev,
+			"failed to enable spdifin reference clock\n");
+		goto pclk_err;
+	}
+
+	regmap_update_bits(priv->map, SPDIFIN_CTRL0, SPDIFIN_CTRL0_EN,
+			   SPDIFIN_CTRL0_EN);
+
 	return 0;
+
+pclk_err:
+	clk_disable_unprepare(priv->pclk);
+	return ret;
 }
 
 static int axg_spdifin_dai_remove(struct snd_soc_dai *dai)
 {
 	struct axg_spdifin *priv = snd_soc_dai_get_drvdata(dai);
 
+	regmap_update_bits(priv->map, SPDIFIN_CTRL0, SPDIFIN_CTRL0_EN, 0);
+	clk_disable_unprepare(priv->refclk);
 	clk_disable_unprepare(priv->pclk);
 	return 0;
 }
 
 static const struct snd_soc_dai_ops axg_spdifin_ops = {
 	.prepare	= axg_spdifin_prepare,
-	.startup	= axg_spdifin_startup,
-	.shutdown	= axg_spdifin_shutdown,
 };
 
 static int axg_spdifin_iec958_info(struct snd_kcontrol *kcontrol,
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index cb0631098f91..e5250a9b813d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -780,7 +780,9 @@ union bpf_attr {
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
index c8622497ef23..73146c23eb2c 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -270,14 +270,14 @@ clean:
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
 	$(INSTALL) -d $(DESTDIR)${bash_completion_dir}
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
index 0ea44d975b6c..837206dbe5d6 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -311,11 +311,12 @@ TEST_F(tls, sendmsg_large)
 
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
@@ -343,9 +344,9 @@ TEST_F(tls, sendmsg_multiple)
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
