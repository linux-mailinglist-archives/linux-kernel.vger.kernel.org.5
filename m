Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD19778BC1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbjHKKR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236119AbjHKKRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:17:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30AC18F;
        Fri, 11 Aug 2023 03:17:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 227C166E54;
        Fri, 11 Aug 2023 10:17:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AECCC433C7;
        Fri, 11 Aug 2023 10:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691749036;
        bh=A60BbK4ly7tJQAiG49ws680OYlCBTXWMUkhZCI5Qbu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=foMxgpL5j9pLtk+EaB73+FFJC2m0Sbbx3Fa9J56WL4alJr5AKOpib9fY+IZh959OZ
         /gnTvmhVkodKuCkDFpUz3F+UkPQ+bG3es1CPIC+yhZs+K3HruyXbuvybLOqQC5i+cN
         2MbWWiD+4MMUrdSK3dIUYHQmpt8gE0Qj6Eg0z2gU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.14.322
Date:   Fri, 11 Aug 2023 12:17:02 +0200
Message-ID: <2023081102-justify-backwash-6c7a@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023081101-sulphuric-contest-68d6@gregkh>
References: <2023081101-sulphuric-contest-68d6@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/admin-guide/security-bugs.rst b/Documentation/admin-guide/security-bugs.rst
index 47574b382d75..2ebf5742df27 100644
--- a/Documentation/admin-guide/security-bugs.rst
+++ b/Documentation/admin-guide/security-bugs.rst
@@ -42,20 +42,18 @@ disclosure is from immediate (esp. if it's already publicly known)
 to a few weeks.  As a basic default policy, we expect report date to
 disclosure date to be on the order of 7 days.
 
-Coordination
-------------
+Coordination with other groups
+------------------------------
 
-Fixes for sensitive bugs, such as those that might lead to privilege
-escalations, may need to be coordinated with the private
-<linux-distros@vs.openwall.org> mailing list so that distribution vendors
-are well prepared to issue a fixed kernel upon public disclosure of the
-upstream fix. Distros will need some time to test the proposed patch and
-will generally request at least a few days of embargo, and vendor update
-publication prefers to happen Tuesday through Thursday. When appropriate,
-the security team can assist with this coordination, or the reporter can
-include linux-distros from the start. In this case, remember to prefix
-the email Subject line with "[vs]" as described in the linux-distros wiki:
-<http://oss-security.openwall.org/wiki/mailing-lists/distros#how-to-use-the-lists>
+The kernel security team strongly recommends that reporters of potential
+security issues NEVER contact the "linux-distros" mailing list until
+AFTER discussing it with the kernel security team.  Do not Cc: both
+lists at once.  You may contact the linux-distros mailing list after a
+fix has been agreed on and you fully understand the requirements that
+doing so will impose on you and the kernel community.
+
+The different lists have different goals and the linux-distros rules do
+not contribute to actually fixing any potential security problems.
 
 CVE assignment
 --------------
diff --git a/Makefile b/Makefile
index eb73f214cc92..3e6450cba24b 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 14
-SUBLEVEL = 321
+SUBLEVEL = 322
 EXTRAVERSION =
 NAME = Petit Gorille
 
diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index c3b6ba4db8e3..b48d8336b798 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -449,7 +449,6 @@
 				  "spi_lr_session_done",
 				  "spi_lr_overread";
 		clocks = <&iprocmed>;
-		clock-names = "iprocmed";
 		num-cs = <2>;
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/mach-ep93xx/timer-ep93xx.c b/arch/arm/mach-ep93xx/timer-ep93xx.c
index de998830f534..b07956883e16 100644
--- a/arch/arm/mach-ep93xx/timer-ep93xx.c
+++ b/arch/arm/mach-ep93xx/timer-ep93xx.c
@@ -9,6 +9,7 @@
 #include <linux/io.h>
 #include <asm/mach/time.h>
 #include "soc.h"
+#include "platform.h"
 
 /*************************************************************************
  * Timer handling for EP93xx
@@ -60,7 +61,7 @@ static u64 notrace ep93xx_read_sched_clock(void)
 	return ret;
 }
 
-u64 ep93xx_clocksource_read(struct clocksource *c)
+static u64 ep93xx_clocksource_read(struct clocksource *c)
 {
 	u64 ret;
 
diff --git a/arch/arm/mach-orion5x/board-dt.c b/arch/arm/mach-orion5x/board-dt.c
index 3d36f1d95196..3f651df3a71c 100644
--- a/arch/arm/mach-orion5x/board-dt.c
+++ b/arch/arm/mach-orion5x/board-dt.c
@@ -63,6 +63,9 @@ static void __init orion5x_dt_init(void)
 	if (of_machine_is_compatible("maxtor,shared-storage-2"))
 		mss2_init();
 
+	if (of_machine_is_compatible("lacie,d2-network"))
+		d2net_init();
+
 	of_platform_default_populate(NULL, orion5x_auxdata_lookup, NULL);
 }
 
diff --git a/arch/arm/mach-orion5x/common.h b/arch/arm/mach-orion5x/common.h
index eb96009e21c4..b9cfdb456456 100644
--- a/arch/arm/mach-orion5x/common.h
+++ b/arch/arm/mach-orion5x/common.h
@@ -75,6 +75,12 @@ extern void mss2_init(void);
 static inline void mss2_init(void) {}
 #endif
 
+#ifdef CONFIG_MACH_D2NET_DT
+void d2net_init(void);
+#else
+static inline void d2net_init(void) {}
+#endif
+
 /*****************************************************************************
  * Helpers to access Orion registers
  ****************************************************************************/
diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index d28ecb9ef172..5cce3c1326af 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -518,7 +518,7 @@ static void __init map_sa1100_gpio_regs( void )
  */
 static void __init get_assabet_scr(void)
 {
-	unsigned long uninitialized_var(scr), i;
+	unsigned long scr, i;
 
 	GPDR |= 0x3fc;			/* Configure GPIO 9:2 as outputs */
 	GPSR = 0x3fc;			/* Write 0xFF to GPIO 9:2 */
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index dda0082056b3..a26a22eb1f12 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -448,7 +448,7 @@ static void
 do_copy_task_regs (struct task_struct *task, struct unw_frame_info *info, void *arg)
 {
 	unsigned long mask, sp, nat_bits = 0, ar_rnat, urbs_end, cfm;
-	unsigned long uninitialized_var(ip);	/* GCC be quiet */
+	unsigned long ip;
 	elf_greg_t *dst = arg;
 	struct pt_regs *pt;
 	char nat;
diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
index 99b59a7ec187..5b174e165e80 100644
--- a/arch/ia64/mm/discontig.c
+++ b/arch/ia64/mm/discontig.c
@@ -185,7 +185,7 @@ static void *per_cpu_node_setup(void *cpu_data, int node)
 void __init setup_per_cpu_areas(void)
 {
 	struct pcpu_alloc_info *ai;
-	struct pcpu_group_info *uninitialized_var(gi);
+	struct pcpu_group_info *gi;
 	unsigned int *cpu_map;
 	void *base;
 	unsigned long base_offset;
diff --git a/arch/ia64/mm/tlb.c b/arch/ia64/mm/tlb.c
index 46ecc5d948aa..33d31e8bb776 100644
--- a/arch/ia64/mm/tlb.c
+++ b/arch/ia64/mm/tlb.c
@@ -339,7 +339,7 @@ EXPORT_SYMBOL(flush_tlb_range);
 
 void ia64_tlb_init(void)
 {
-	ia64_ptce_info_t uninitialized_var(ptce_info); /* GCC be quiet */
+	ia64_ptce_info_t ptce_info;
 	u64 tr_pgbits;
 	long status;
 	pal_vm_info_1_u_t vm_info_1;
diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 762bb08b0f59..6c60cc03a53c 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -231,7 +231,7 @@ config PPC_EARLY_DEBUG_40x
 
 config PPC_EARLY_DEBUG_CPM
 	bool "Early serial debugging for Freescale CPM-based serial ports"
-	depends on SERIAL_CPM
+	depends on SERIAL_CPM=y
 	help
 	  Select this to enable early debugging for Freescale chips
 	  using a CPM-based serial port.  This assumes that the bootwrapper
diff --git a/arch/powerpc/include/asm/word-at-a-time.h b/arch/powerpc/include/asm/word-at-a-time.h
index f3f4710d4ff5..99129b0cd8b8 100644
--- a/arch/powerpc/include/asm/word-at-a-time.h
+++ b/arch/powerpc/include/asm/word-at-a-time.h
@@ -34,7 +34,7 @@ static inline long find_zero(unsigned long mask)
 	return leading_zero_bits >> 3;
 }
 
-static inline bool has_zero(unsigned long val, unsigned long *data, const struct word_at_a_time *c)
+static inline unsigned long has_zero(unsigned long val, unsigned long *data, const struct word_at_a_time *c)
 {
 	unsigned long rhs = val | c->low_bits;
 	*data = rhs;
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
index fc98912f42cf..76a8102bdb98 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -340,7 +340,7 @@ static int mpc52xx_irqhost_map(struct irq_domain *h, unsigned int virq,
 {
 	int l1irq;
 	int l2irq;
-	struct irq_chip *uninitialized_var(irqchip);
+	struct irq_chip *irqchip;
 	void *hndlr;
 	int type;
 	u32 reg;
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index d43b48d8f67d..deb42245e200 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -147,7 +147,7 @@ static int pcpu_sigp_retry(struct pcpu *pcpu, u8 order, u32 parm)
 
 static inline int pcpu_stopped(struct pcpu *pcpu)
 {
-	u32 uninitialized_var(status);
+	u32 status;
 
 	if (__pcpu_sigp(pcpu->address, SIGP_SENSE,
 			0, &status) != SIGP_CC_STATUS_STORED)
diff --git a/arch/sh/drivers/dma/dma-sh.c b/arch/sh/drivers/dma/dma-sh.c
index afde2a7d3eb3..e0679d8a9b34 100644
--- a/arch/sh/drivers/dma/dma-sh.c
+++ b/arch/sh/drivers/dma/dma-sh.c
@@ -21,6 +21,18 @@
 #include <cpu/dma-register.h>
 #include <cpu/dma.h>
 
+/*
+ * Some of the SoCs feature two DMAC modules. In such a case, the channels are
+ * distributed equally among them.
+ */
+#ifdef	SH_DMAC_BASE1
+#define	SH_DMAC_NR_MD_CH	(CONFIG_NR_ONCHIP_DMA_CHANNELS / 2)
+#else
+#define	SH_DMAC_NR_MD_CH	CONFIG_NR_ONCHIP_DMA_CHANNELS
+#endif
+
+#define	SH_DMAC_CH_SZ		0x10
+
 /*
  * Define the default configuration for dual address memory-memory transfer.
  * The 0x400 value represents auto-request, external->external.
@@ -32,7 +44,7 @@ static unsigned long dma_find_base(unsigned int chan)
 	unsigned long base = SH_DMAC_BASE0;
 
 #ifdef SH_DMAC_BASE1
-	if (chan >= 6)
+	if (chan >= SH_DMAC_NR_MD_CH)
 		base = SH_DMAC_BASE1;
 #endif
 
@@ -43,13 +55,13 @@ static unsigned long dma_base_addr(unsigned int chan)
 {
 	unsigned long base = dma_find_base(chan);
 
-	/* Normalize offset calculation */
-	if (chan >= 9)
-		chan -= 6;
-	if (chan >= 4)
-		base += 0x10;
+	chan = (chan % SH_DMAC_NR_MD_CH) * SH_DMAC_CH_SZ;
+
+	/* DMAOR is placed inside the channel register space. Step over it. */
+	if (chan >= DMAOR)
+		base += SH_DMAC_CH_SZ;
 
-	return base + (chan * 0x10);
+	return base + chan;
 }
 
 #ifdef CONFIG_SH_DMA_IRQ_MULTI
@@ -253,12 +265,11 @@ static int sh_dmac_get_dma_residue(struct dma_channel *chan)
 #define NR_DMAOR	1
 #endif
 
-/*
- * DMAOR bases are broken out amongst channel groups. DMAOR0 manages
- * channels 0 - 5, DMAOR1 6 - 11 (optional).
- */
-#define dmaor_read_reg(n)		__raw_readw(dma_find_base((n)*6))
-#define dmaor_write_reg(n, data)	__raw_writew(data, dma_find_base(n)*6)
+#define dmaor_read_reg(n)		__raw_readw(dma_find_base((n) * \
+						    SH_DMAC_NR_MD_CH) + DMAOR)
+#define dmaor_write_reg(n, data)	__raw_writew(data, \
+						     dma_find_base((n) * \
+						     SH_DMAC_NR_MD_CH) + DMAOR)
 
 static inline int dmaor_reset(int no)
 {
diff --git a/arch/sh/kernel/cpu/sh2/probe.c b/arch/sh/kernel/cpu/sh2/probe.c
index a5bd03642678..75dcb1d6bc62 100644
--- a/arch/sh/kernel/cpu/sh2/probe.c
+++ b/arch/sh/kernel/cpu/sh2/probe.c
@@ -24,7 +24,7 @@ static int __init scan_cache(unsigned long node, const char *uname,
 	if (!of_flat_dt_is_compatible(node, "jcore,cache"))
 		return 0;
 
-	j2_ccr_base = (u32 __iomem *)of_flat_dt_translate_address(node);
+	j2_ccr_base = ioremap(of_flat_dt_translate_address(node), 4);
 
 	return 1;
 }
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 22fb64951bb8..14366ee8f359 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -532,7 +532,7 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
 
 	/* need to apply patch? */
-	if (rev >= mc_amd->hdr.patch_id) {
+	if (rev > mc_amd->hdr.patch_id) {
 		ret = UCODE_OK;
 		goto out;
 	}
diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
index 736348ead421..2ecf1dcc86b2 100644
--- a/arch/x86/kernel/quirks.c
+++ b/arch/x86/kernel/quirks.c
@@ -96,7 +96,7 @@ static void ich_force_hpet_resume(void)
 static void ich_force_enable_hpet(struct pci_dev *dev)
 {
 	u32 val;
-	u32 uninitialized_var(rcba);
+	u32 rcba;
 	int err = 0;
 
 	if (hpet_address || force_hpet_address)
@@ -186,7 +186,7 @@ static void hpet_print_force_info(void)
 static void old_ich_force_hpet_resume(void)
 {
 	u32 val;
-	u32 uninitialized_var(gen_cntl);
+	u32 gen_cntl;
 
 	if (!force_hpet_address || !cached_dev)
 		return;
@@ -208,7 +208,7 @@ static void old_ich_force_hpet_resume(void)
 static void old_ich_force_enable_hpet(struct pci_dev *dev)
 {
 	u32 val;
-	u32 uninitialized_var(gen_cntl);
+	u32 gen_cntl;
 
 	if (hpet_address || force_hpet_address)
 		return;
@@ -299,7 +299,7 @@ static void vt8237_force_hpet_resume(void)
 
 static void vt8237_force_enable_hpet(struct pci_dev *dev)
 {
-	u32 uninitialized_var(val);
+	u32 val;
 
 	if (hpet_address || force_hpet_address)
 		return;
@@ -430,7 +430,7 @@ static void nvidia_force_hpet_resume(void)
 
 static void nvidia_force_enable_hpet(struct pci_dev *dev)
 {
-	u32 uninitialized_var(val);
+	u32 val;
 
 	if (hpet_address || force_hpet_address)
 		return;
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index aea06e7a6bee..21f6c0357d74 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -94,6 +94,17 @@ DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
 DEFINE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
 EXPORT_PER_CPU_SYMBOL(cpu_info);
 
+struct mwait_cpu_dead {
+	unsigned int	control;
+	unsigned int	status;
+};
+
+/*
+ * Cache line aligned data for mwait_play_dead(). Separate on purpose so
+ * that it's unlikely to be touched by other CPUs.
+ */
+static DEFINE_PER_CPU_ALIGNED(struct mwait_cpu_dead, mwait_cpu_dead);
+
 /* Logical package management. We might want to allocate that dynamically */
 static int *physical_to_logical_pkg __read_mostly;
 static unsigned long *physical_package_map __read_mostly;;
@@ -1638,10 +1649,10 @@ static bool wakeup_cpu0(void)
  */
 static inline void mwait_play_dead(void)
 {
+	struct mwait_cpu_dead *md = this_cpu_ptr(&mwait_cpu_dead);
 	unsigned int eax, ebx, ecx, edx;
 	unsigned int highest_cstate = 0;
 	unsigned int highest_subcstate = 0;
-	void *mwait_ptr;
 	int i;
 
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
@@ -1675,13 +1686,6 @@ static inline void mwait_play_dead(void)
 			(highest_subcstate - 1);
 	}
 
-	/*
-	 * This should be a memory location in a cache line which is
-	 * unlikely to be touched by other processors.  The actual
-	 * content is immaterial as it is not actually modified in any way.
-	 */
-	mwait_ptr = &current_thread_info()->flags;
-
 	wbinvd();
 
 	while (1) {
@@ -1693,9 +1697,9 @@ static inline void mwait_play_dead(void)
 		 * case where we return around the loop.
 		 */
 		mb();
-		clflush(mwait_ptr);
+		clflush(md);
 		mb();
-		__monitor(mwait_ptr, 0, 0);
+		__monitor(md, 0, 0);
 		mb();
 		__mwait(eax, 0);
 		/*
diff --git a/arch/xtensa/platforms/iss/network.c b/arch/xtensa/platforms/iss/network.c
index 66a5d15a9e0e..9cc96907b45d 100644
--- a/arch/xtensa/platforms/iss/network.c
+++ b/arch/xtensa/platforms/iss/network.c
@@ -234,7 +234,7 @@ static int tuntap_probe(struct iss_net_private *lp, int index, char *init)
 
 	init += sizeof(TRANSPORT_TUNTAP_NAME) - 1;
 	if (*init == ',') {
-		rem = split_if_spec(init + 1, &mac_str, &dev_name);
+		rem = split_if_spec(init + 1, &mac_str, &dev_name, NULL);
 		if (rem != NULL) {
 			pr_err("%s: extra garbage on specification : '%s'\n",
 			       dev->name, rem);
diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 552c1f725b6c..40188632958c 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -95,7 +95,7 @@ static void round_robin_cpu(unsigned int tsk_index)
 	cpumask_var_t tmp;
 	int cpu;
 	unsigned long min_weight = -1;
-	unsigned long uninitialized_var(preferred_cpu);
+	unsigned long preferred_cpu;
 
 	if (!alloc_cpumask_var(&tmp, GFP_KERNEL))
 		return;
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 5728f458aad8..b44e8bc759c0 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -176,7 +176,7 @@ static ssize_t ata_scsi_park_show(struct device *device,
 	struct ata_link *link;
 	struct ata_device *dev;
 	unsigned long now;
-	unsigned int uninitialized_var(msecs);
+	unsigned int msecs;
 	int rc = 0;
 
 	ap = ata_shost_to_port(sdev->host);
diff --git a/drivers/ata/pata_ns87415.c b/drivers/ata/pata_ns87415.c
index 84c6b225b56e..9ee4aefca867 100644
--- a/drivers/ata/pata_ns87415.c
+++ b/drivers/ata/pata_ns87415.c
@@ -260,7 +260,7 @@ static u8 ns87560_check_status(struct ata_port *ap)
  *	LOCKING:
  *	Inherited from caller.
  */
-void ns87560_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
+static void ns87560_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
diff --git a/drivers/atm/zatm.c b/drivers/atm/zatm.c
index 817c7edfec0b..b7ae2fe415d1 100644
--- a/drivers/atm/zatm.c
+++ b/drivers/atm/zatm.c
@@ -939,7 +939,7 @@ static int open_tx_first(struct atm_vcc *vcc)
 	    vcc->qos.txtp.max_pcr >= ATM_OC3_PCR);
 	if (unlimited && zatm_dev->ubr != -1) zatm_vcc->shaper = zatm_dev->ubr;
 	else {
-		int uninitialized_var(pcr);
+		int pcr;
 
 		if (unlimited) vcc->qos.txtp.max_sdu = ATM_MAX_AAL5_PDU;
 		if ((zatm_vcc->shaper = alloc_shaper(vcc->dev,&pcr,
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index a64b093a88cf..0f38df5856e1 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2206,10 +2206,10 @@ static int genpd_parse_state(struct genpd_power_state *genpd_state,
 
 	err = of_property_read_u32(state_node, "min-residency-us", &residency);
 	if (!err)
-		genpd_state->residency_ns = 1000 * residency;
+		genpd_state->residency_ns = 1000LL * residency;
 
-	genpd_state->power_on_latency_ns = 1000 * exit_latency;
-	genpd_state->power_off_latency_ns = 1000 * entry_latency;
+	genpd_state->power_on_latency_ns = 1000LL * exit_latency;
+	genpd_state->power_off_latency_ns = 1000LL * entry_latency;
 	genpd_state->fwnode = &state_node->fwnode;
 
 	return 0;
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index bfefa8c4fa16..f55bcc86b4ee 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -3394,7 +3394,7 @@ int drbd_adm_dump_devices(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct nlattr *resource_filter;
 	struct drbd_resource *resource;
-	struct drbd_device *uninitialized_var(device);
+	struct drbd_device *device;
 	int minor, err, retcode;
 	struct drbd_genlmsghdr *dh;
 	struct device_info device_info;
@@ -3483,7 +3483,7 @@ int drbd_adm_dump_connections(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct nlattr *resource_filter;
 	struct drbd_resource *resource = NULL, *next_resource;
-	struct drbd_connection *uninitialized_var(connection);
+	struct drbd_connection *connection;
 	int err = 0, retcode;
 	struct drbd_genlmsghdr *dh;
 	struct connection_info connection_info;
@@ -3645,7 +3645,7 @@ int drbd_adm_dump_peer_devices(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct nlattr *resource_filter;
 	struct drbd_resource *resource;
-	struct drbd_device *uninitialized_var(device);
+	struct drbd_device *device;
 	struct drbd_peer_device *peer_device = NULL;
 	int minor, err, retcode;
 	struct drbd_genlmsghdr *dh;
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 6acb174c9a12..ba2a8a46ee5e 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1846,7 +1846,8 @@ static int loop_add(struct loop_device **l, int i)
 	lo->tag_set.queue_depth = 128;
 	lo->tag_set.numa_node = NUMA_NO_NODE;
 	lo->tag_set.cmd_size = sizeof(struct loop_cmd);
-	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE;
+	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE |
+		BLK_MQ_F_NO_SCHED;
 	lo->tag_set.driver_data = lo;
 
 	err = blk_mq_alloc_tag_set(&lo->tag_set);
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index eb2ca7f6ab3a..33ad48719c12 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1630,7 +1630,8 @@ static int nbd_dev_add(int index)
 		if (err == -ENOSPC)
 			err = -EEXIST;
 	} else {
-		err = idr_alloc(&nbd_index_idr, nbd, 0, 0, GFP_KERNEL);
+		err = idr_alloc(&nbd_index_idr, nbd, 0,
+				(MINORMASK >> part_shift) + 1, GFP_KERNEL);
 		if (err >= 0)
 			index = err;
 	}
diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
index 48194d1a6076..5a31887867d6 100644
--- a/drivers/char/hw_random/imx-rngc.c
+++ b/drivers/char/hw_random/imx-rngc.c
@@ -104,7 +104,7 @@ static int imx_rngc_self_test(struct imx_rngc *rngc)
 	cmd = readl(rngc->base + RNGC_COMMAND);
 	writel(cmd | RNGC_CMD_SELF_TEST, rngc->base + RNGC_COMMAND);
 
-	ret = wait_for_completion_timeout(&rngc->rng_op_done, RNGC_TIMEOUT);
+	ret = wait_for_completion_timeout(&rngc->rng_op_done, msecs_to_jiffies(RNGC_TIMEOUT));
 	if (!ret) {
 		imx_rngc_irq_mask_clear(rngc);
 		return -ETIMEDOUT;
@@ -187,9 +187,7 @@ static int imx_rngc_init(struct hwrng *rng)
 		cmd = readl(rngc->base + RNGC_COMMAND);
 		writel(cmd | RNGC_CMD_SEED, rngc->base + RNGC_COMMAND);
 
-		ret = wait_for_completion_timeout(&rngc->rng_op_done,
-				RNGC_TIMEOUT);
-
+		ret = wait_for_completion_timeout(&rngc->rng_op_done, msecs_to_jiffies(RNGC_TIMEOUT));
 		if (!ret) {
 			imx_rngc_irq_mask_clear(rngc);
 			return -ETIMEDOUT;
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 9e42943f6a59..325581558509 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -209,6 +209,7 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 	int size = 0;
 	int status;
 	u32 expected;
+	int rc;
 
 	if (count < TPM_HEADER_SIZE) {
 		size = -EIO;
@@ -228,8 +229,13 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 		goto out;
 	}
 
-	size += recv_data(chip, &buf[TPM_HEADER_SIZE],
-			  expected - TPM_HEADER_SIZE);
+	rc = recv_data(chip, &buf[TPM_HEADER_SIZE],
+		       expected - TPM_HEADER_SIZE);
+	if (rc < 0) {
+		size = rc;
+		goto out;
+	}
+	size += rc;
 	if (size < expected) {
 		dev_err(&chip->dev, "Unable to read remainder of result\n");
 		size = -ETIME;
diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index 94a539384619..ab460183a13b 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -700,37 +700,21 @@ static struct miscdevice vtpmx_miscdev = {
 	.fops = &vtpmx_fops,
 };
 
-static int vtpmx_init(void)
-{
-	return misc_register(&vtpmx_miscdev);
-}
-
-static void vtpmx_cleanup(void)
-{
-	misc_deregister(&vtpmx_miscdev);
-}
-
 static int __init vtpm_module_init(void)
 {
 	int rc;
 
-	rc = vtpmx_init();
-	if (rc) {
-		pr_err("couldn't create vtpmx device\n");
-		return rc;
-	}
-
 	workqueue = create_workqueue("tpm-vtpm");
 	if (!workqueue) {
 		pr_err("couldn't create workqueue\n");
-		rc = -ENOMEM;
-		goto err_vtpmx_cleanup;
+		return -ENOMEM;
 	}
 
-	return 0;
-
-err_vtpmx_cleanup:
-	vtpmx_cleanup();
+	rc = misc_register(&vtpmx_miscdev);
+	if (rc) {
+		pr_err("couldn't create vtpmx device\n");
+		destroy_workqueue(workqueue);
+	}
 
 	return rc;
 }
@@ -738,7 +722,7 @@ static int __init vtpm_module_init(void)
 static void __exit vtpm_module_exit(void)
 {
 	destroy_workqueue(workqueue);
-	vtpmx_cleanup();
+	misc_deregister(&vtpmx_miscdev);
 }
 
 module_init(vtpm_module_init);
diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index dd82485e09a1..c110f5d40b58 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -43,7 +43,7 @@ static void clk_gate_endisable(struct clk_hw *hw, int enable)
 {
 	struct clk_gate *gate = to_clk_gate(hw);
 	int set = gate->flags & CLK_GATE_SET_TO_DISABLE ? 1 : 0;
-	unsigned long uninitialized_var(flags);
+	unsigned long flags;
 	u32 reg;
 
 	set ^= enable;
diff --git a/drivers/crypto/nx/Makefile b/drivers/crypto/nx/Makefile
index 015155da59c2..76139865d7fa 100644
--- a/drivers/crypto/nx/Makefile
+++ b/drivers/crypto/nx/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CRYPTO_DEV_NX_ENCRYPT) += nx-crypto.o
 nx-crypto-objs := nx.o \
-		  nx_debugfs.o \
 		  nx-aes-cbc.o \
 		  nx-aes-ecb.o \
 		  nx-aes-gcm.o \
@@ -11,6 +10,7 @@ nx-crypto-objs := nx.o \
 		  nx-sha256.o \
 		  nx-sha512.o
 
+nx-crypto-$(CONFIG_DEBUG_FS) += nx_debugfs.o
 obj-$(CONFIG_CRYPTO_DEV_NX_COMPRESS_PSERIES) += nx-compress-pseries.o nx-compress.o
 obj-$(CONFIG_CRYPTO_DEV_NX_COMPRESS_POWERNV) += nx-compress-powernv.o nx-compress.o
 nx-compress-objs := nx-842.o
diff --git a/drivers/crypto/nx/nx.h b/drivers/crypto/nx/nx.h
index c3e54af18645..ebad937a9545 100644
--- a/drivers/crypto/nx/nx.h
+++ b/drivers/crypto/nx/nx.h
@@ -180,8 +180,8 @@ struct nx_sg *nx_walk_and_build(struct nx_sg *, unsigned int,
 int nx_debugfs_init(struct nx_crypto_driver *);
 void nx_debugfs_fini(struct nx_crypto_driver *);
 #else
-#define NX_DEBUGFS_INIT(drv)	(0)
-#define NX_DEBUGFS_FINI(drv)	(0)
+#define NX_DEBUGFS_INIT(drv)	do {} while (0)
+#define NX_DEBUGFS_FINI(drv)	do {} while (0)
 #endif
 
 #define NX_PAGE_NUM(x)		((u64)(x) & 0xfffffffffffff000ULL)
diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 81a552654cc7..e6e3e404052b 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -204,6 +204,14 @@ struct __extcon_info {
  * @attr_name:		"name" sysfs entry
  * @attr_state:		"state" sysfs entry
  * @attrs:		the array pointing to attr_name and attr_state for attr_g
+ * @usb_propval:	the array of USB connector properties
+ * @chg_propval:	the array of charger connector properties
+ * @jack_propval:	the array of jack connector properties
+ * @disp_propval:	the array of display connector properties
+ * @usb_bits:		the bit array of the USB connector property capabilities
+ * @chg_bits:		the bit array of the charger connector property capabilities
+ * @jack_bits:		the bit array of the jack connector property capabilities
+ * @disp_bits:		the bit array of the display connector property capabilities
  */
 struct extcon_cable {
 	struct extcon_dev *edev;
diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index d731b413cb2c..f2b624a440ca 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -1114,7 +1114,7 @@ static void context_tasklet(unsigned long data)
 static int context_add_buffer(struct context *ctx)
 {
 	struct descriptor_buffer *desc;
-	dma_addr_t uninitialized_var(bus_addr);
+	dma_addr_t bus_addr;
 	int offset;
 
 	/*
@@ -1304,7 +1304,7 @@ static int at_context_queue_packet(struct context *ctx,
 				   struct fw_packet *packet)
 {
 	struct fw_ohci *ohci = ctx->ohci;
-	dma_addr_t d_bus, uninitialized_var(payload_bus);
+	dma_addr_t d_bus, payload_bus;
 	struct driver_data *driver_data;
 	struct descriptor *d, *last;
 	__le32 *header;
@@ -2460,7 +2460,7 @@ static int ohci_set_config_rom(struct fw_card *card,
 {
 	struct fw_ohci *ohci;
 	__be32 *next_config_rom;
-	dma_addr_t uninitialized_var(next_config_rom_bus);
+	dma_addr_t next_config_rom_bus;
 
 	ohci = fw_ohci(card);
 
@@ -2949,10 +2949,10 @@ static struct fw_iso_context *ohci_allocate_iso_context(struct fw_card *card,
 				int type, int channel, size_t header_size)
 {
 	struct fw_ohci *ohci = fw_ohci(card);
-	struct iso_context *uninitialized_var(ctx);
-	descriptor_callback_t uninitialized_var(callback);
-	u64 *uninitialized_var(channels);
-	u32 *uninitialized_var(mask), uninitialized_var(regs);
+	struct iso_context *ctx;
+	descriptor_callback_t callback;
+	u64 *channels;
+	u32 *mask, regs;
 	int index, ret = -EBUSY;
 
 	spin_lock_irq(&ohci->lock);
diff --git a/drivers/gpio/gpio-tps68470.c b/drivers/gpio/gpio-tps68470.c
index fa2662f8b026..773c7426fd22 100644
--- a/drivers/gpio/gpio-tps68470.c
+++ b/drivers/gpio/gpio-tps68470.c
@@ -99,13 +99,13 @@ static int tps68470_gpio_output(struct gpio_chip *gc, unsigned int offset,
 	struct tps68470_gpio_data *tps68470_gpio = gpiochip_get_data(gc);
 	struct regmap *regmap = tps68470_gpio->tps68470_regmap;
 
+	/* Set the initial value */
+	tps68470_gpio_set(gc, offset, value);
+
 	/* rest are always outputs */
 	if (offset >= TPS68470_N_REGULAR_GPIO)
 		return 0;
 
-	/* Set the initial value */
-	tps68470_gpio_set(gc, offset, value);
-
 	return regmap_update_bits(regmap, TPS68470_GPIO_CTL_REG_A(offset),
 				 TPS68470_GPIO_MODE_MASK,
 				 TPS68470_GPIO_MODE_OUT_CMOS);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 57b1369aa522..d52e0bc70d45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2712,6 +2712,10 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	int r;
 
+	/* No valid flags defined yet */
+	if (args->in.flags)
+		return -EINVAL;
+
 	switch (args->in.op) {
 	case AMDGPU_VM_OP_RESERVE_VMID:
 		/* current, we only have requirement to reserve vmid from gfxhub */
diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
index 9edb7af37d1e..6e2a6e7f9fd0 100644
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -1011,7 +1011,7 @@ static void sii8620_set_auto_zone(struct sii8620 *ctx)
 
 static void sii8620_stop_video(struct sii8620 *ctx)
 {
-	u8 uninitialized_var(val);
+	u8 val;
 
 	sii8620_write_seq_static(ctx,
 		REG_TPI_INTR_EN, 0,
diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index de5fc79379e8..bb2de59baed0 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -2671,7 +2671,7 @@ static int drm_cvt_modes(struct drm_connector *connector,
 	const u8 empty[3] = { 0, 0, 0 };
 
 	for (i = 0; i < 4; i++) {
-		int uninitialized_var(width), height;
+		int width, height;
 		cvt = &(timing->data.other_data.data.cvt[i]);
 
 		if (!memcmp(cvt->code, empty, 3))
@@ -2679,6 +2679,8 @@ static int drm_cvt_modes(struct drm_connector *connector,
 
 		height = (cvt->code[0] + ((cvt->code[1] & 0xf0) << 4) + 1) * 2;
 		switch (cvt->code[1] & 0x0c) {
+		/* default - because compiler doesn't see that we've enumerated all cases */
+		default:
 		case 0x00:
 			width = height * 4 / 3;
 			break;
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index fbf7f28d9df9..e8d0dbe92048 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -2112,6 +2112,9 @@ static bool drm_target_cloned(struct drm_fb_helper *fb_helper,
 	can_clone = true;
 	dmt_mode = drm_mode_find_dmt(fb_helper->dev, 1024, 768, 60, false);
 
+	if (!dmt_mode)
+		goto fail;
+
 	drm_fb_helper_for_each_connector(fb_helper, i) {
 		if (!enabled[i])
 			continue;
@@ -2124,11 +2127,13 @@ static bool drm_target_cloned(struct drm_fb_helper *fb_helper,
 		if (!modes[i])
 			can_clone = false;
 	}
+	kfree(dmt_mode);
 
 	if (can_clone) {
 		DRM_DEBUG_KMS("can clone using 1024x768\n");
 		return true;
 	}
+fail:
 	DRM_INFO("kms: can't enable cloning when we probably wanted to.\n");
 	return false;
 }
diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index 366c975cde5b..06e52b6fd03f 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -545,9 +545,9 @@ static unsigned long exynos_dsi_pll_find_pms(struct exynos_dsi *dsi,
 	unsigned long best_freq = 0;
 	u32 min_delta = 0xffffffff;
 	u8 p_min, p_max;
-	u8 _p, uninitialized_var(best_p);
-	u16 _m, uninitialized_var(best_m);
-	u8 _s, uninitialized_var(best_s);
+	u8 _p, best_p;
+	u16 _m, best_m;
+	u8 _s, best_s;
 
 	p_min = DIV_ROUND_UP(fin, (12 * MHZ));
 	p_max = fin / (6 * MHZ);
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 6df312ba1826..8bee025c0622 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -407,8 +407,8 @@ static const struct panel_desc ampire_am_480272h3tmqw_t01h = {
 	.num_modes = 1,
 	.bpc = 8,
 	.size = {
-		.width = 105,
-		.height = 67,
+		.width = 99,
+		.height = 58,
 	},
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
 };
diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
index 81bc2b89222f..0403924a2ca6 100644
--- a/drivers/gpu/drm/radeon/ci_dpm.c
+++ b/drivers/gpu/drm/radeon/ci_dpm.c
@@ -5530,6 +5530,7 @@ static int ci_parse_power_table(struct radeon_device *rdev)
 	u8 frev, crev;
 	u8 *power_state_offset;
 	struct ci_ps *ps;
+	int ret;
 
 	if (!atom_parse_data_header(mode_info->atom_context, index, NULL,
 				   &frev, &crev, &data_offset))
@@ -5558,11 +5559,15 @@ static int ci_parse_power_table(struct radeon_device *rdev)
 		non_clock_array_index = power_state->v2.nonClockInfoIndex;
 		non_clock_info = (struct _ATOM_PPLIB_NONCLOCK_INFO *)
 			&non_clock_info_array->nonClockInfo[non_clock_array_index];
-		if (!rdev->pm.power_state[i].clock_info)
-			return -EINVAL;
+		if (!rdev->pm.power_state[i].clock_info) {
+			ret = -EINVAL;
+			goto err_free_ps;
+		}
 		ps = kzalloc(sizeof(struct ci_ps), GFP_KERNEL);
-		if (ps == NULL)
-			return -ENOMEM;
+		if (ps == NULL) {
+			ret = -ENOMEM;
+			goto err_free_ps;
+		}
 		rdev->pm.dpm.ps[i].ps_priv = ps;
 		ci_parse_pplib_non_clock_info(rdev, &rdev->pm.dpm.ps[i],
 					      non_clock_info,
@@ -5602,6 +5607,12 @@ static int ci_parse_power_table(struct radeon_device *rdev)
 	}
 
 	return 0;
+
+err_free_ps:
+	for (i = 0; i < rdev->pm.dpm.num_ps; i++)
+		kfree(rdev->pm.dpm.ps[i].ps_priv);
+	kfree(rdev->pm.dpm.ps);
+	return ret;
 }
 
 static int ci_get_vbios_boot_values(struct radeon_device *rdev,
@@ -5679,25 +5690,26 @@ int ci_dpm_init(struct radeon_device *rdev)
 
 	ret = ci_get_vbios_boot_values(rdev, &pi->vbios_boot_state);
 	if (ret) {
-		ci_dpm_fini(rdev);
+		kfree(rdev->pm.dpm.priv);
 		return ret;
 	}
 
 	ret = r600_get_platform_caps(rdev);
 	if (ret) {
-		ci_dpm_fini(rdev);
+		kfree(rdev->pm.dpm.priv);
 		return ret;
 	}
 
 	ret = r600_parse_extended_power_table(rdev);
 	if (ret) {
-		ci_dpm_fini(rdev);
+		kfree(rdev->pm.dpm.priv);
 		return ret;
 	}
 
 	ret = ci_parse_power_table(rdev);
 	if (ret) {
-		ci_dpm_fini(rdev);
+		kfree(rdev->pm.dpm.priv);
+		r600_free_extended_power_table(rdev);
 		return ret;
 	}
 
diff --git a/drivers/gpu/drm/radeon/cypress_dpm.c b/drivers/gpu/drm/radeon/cypress_dpm.c
index 3eb7899a4035..2c637e04dfeb 100644
--- a/drivers/gpu/drm/radeon/cypress_dpm.c
+++ b/drivers/gpu/drm/radeon/cypress_dpm.c
@@ -558,8 +558,12 @@ static int cypress_populate_mclk_value(struct radeon_device *rdev,
 						     ASIC_INTERNAL_MEMORY_SS, vco_freq)) {
 			u32 reference_clock = rdev->clock.mpll.reference_freq;
 			u32 decoded_ref = rv740_get_decoded_reference_divider(dividers.ref_div);
-			u32 clk_s = reference_clock * 5 / (decoded_ref * ss.rate);
-			u32 clk_v = ss.percentage *
+			u32 clk_s, clk_v;
+
+			if (!decoded_ref)
+				return -EINVAL;
+			clk_s = reference_clock * 5 / (decoded_ref * ss.rate);
+			clk_v = ss.percentage *
 				(0x4000 * dividers.whole_fb_div + 0x800 * dividers.frac_fb_div) / (clk_s * 625);
 
 			mpll_ss1 &= ~CLKV_MASK;
diff --git a/drivers/gpu/drm/radeon/ni_dpm.c b/drivers/gpu/drm/radeon/ni_dpm.c
index fa88c1809946..701c99a55138 100644
--- a/drivers/gpu/drm/radeon/ni_dpm.c
+++ b/drivers/gpu/drm/radeon/ni_dpm.c
@@ -2239,8 +2239,12 @@ static int ni_populate_mclk_value(struct radeon_device *rdev,
 						     ASIC_INTERNAL_MEMORY_SS, vco_freq)) {
 			u32 reference_clock = rdev->clock.mpll.reference_freq;
 			u32 decoded_ref = rv740_get_decoded_reference_divider(dividers.ref_div);
-			u32 clk_s = reference_clock * 5 / (decoded_ref * ss.rate);
-			u32 clk_v = ss.percentage *
+			u32 clk_s, clk_v;
+
+			if (!decoded_ref)
+				return -EINVAL;
+			clk_s = reference_clock * 5 / (decoded_ref * ss.rate);
+			clk_v = ss.percentage *
 				(0x4000 * dividers.whole_fb_div + 0x800 * dividers.frac_fb_div) / (clk_s * 625);
 
 			mpll_ss1 &= ~CLKV_MASK;
diff --git a/drivers/gpu/drm/radeon/rv740_dpm.c b/drivers/gpu/drm/radeon/rv740_dpm.c
index afd597ec5085..50290e93c79d 100644
--- a/drivers/gpu/drm/radeon/rv740_dpm.c
+++ b/drivers/gpu/drm/radeon/rv740_dpm.c
@@ -251,8 +251,12 @@ int rv740_populate_mclk_value(struct radeon_device *rdev,
 						     ASIC_INTERNAL_MEMORY_SS, vco_freq)) {
 			u32 reference_clock = rdev->clock.mpll.reference_freq;
 			u32 decoded_ref = rv740_get_decoded_reference_divider(dividers.ref_div);
-			u32 clk_s = reference_clock * 5 / (decoded_ref * ss.rate);
-			u32 clk_v = 0x40000 * ss.percentage *
+			u32 clk_s, clk_v;
+
+			if (!decoded_ref)
+				return -EINVAL;
+			clk_s = reference_clock * 5 / (decoded_ref * ss.rate);
+			clk_v = 0x40000 * ss.percentage *
 				(dividers.whole_fb_div + (dividers.frac_fb_div / 8)) / (clk_s * 10000);
 
 			mpll_ss1 &= ~CLKV_MASK;
diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
index 779ec8fdfae0..56dd2d6ba9e4 100644
--- a/drivers/hwmon/nct7802.c
+++ b/drivers/hwmon/nct7802.c
@@ -698,7 +698,7 @@ static umode_t nct7802_temp_is_visible(struct kobject *kobj,
 	if (index >= 38 && index < 46 && !(reg & 0x01))		/* PECI 0 */
 		return 0;
 
-	if (index >= 0x46 && (!(reg & 0x02)))			/* PECI 1 */
+	if (index >= 46 && !(reg & 0x02))			/* PECI 1 */
 		return 0;
 
 	return attr->mode;
diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 548089aa9aba..b50476f93a66 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -417,7 +417,7 @@ static void rk3x_i2c_handle_read(struct rk3x_i2c *i2c, unsigned int ipd)
 {
 	unsigned int i;
 	unsigned int len = i2c->msg->len - i2c->processed;
-	u32 uninitialized_var(val);
+	u32 val;
 	u8 byte;
 
 	/* we only care for MBRF here. */
diff --git a/drivers/ide/ide-acpi.c b/drivers/ide/ide-acpi.c
index 7d4e5c08f133..05e18d658141 100644
--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -180,7 +180,7 @@ static int ide_get_dev_handle(struct device *dev, acpi_handle *handle,
 static acpi_handle ide_acpi_hwif_get_handle(ide_hwif_t *hwif)
 {
 	struct device		*dev = hwif->gendev.parent;
-	acpi_handle		uninitialized_var(dev_handle);
+	acpi_handle		dev_handle;
 	u64			pcidevfn;
 	acpi_handle		chan_handle;
 	int			err;
diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index 215558c947de..3ef1afc64918 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -591,7 +591,7 @@ static int ide_delayed_transfer_pc(ide_drive_t *drive)
 
 static ide_startstop_t ide_transfer_pc(ide_drive_t *drive)
 {
-	struct ide_atapi_pc *uninitialized_var(pc);
+	struct ide_atapi_pc *pc;
 	ide_hwif_t *hwif = drive->hwif;
 	struct request *rq = hwif->rq;
 	ide_expiry_t *expiry;
diff --git a/drivers/ide/ide-io-std.c b/drivers/ide/ide-io-std.c
index 19763977568c..508f98ca3fe8 100644
--- a/drivers/ide/ide-io-std.c
+++ b/drivers/ide/ide-io-std.c
@@ -172,7 +172,7 @@ void ide_input_data(ide_drive_t *drive, struct ide_cmd *cmd, void *buf,
 	u8 mmio = (hwif->host_flags & IDE_HFLAG_MMIO) ? 1 : 0;
 
 	if (io_32bit) {
-		unsigned long uninitialized_var(flags);
+		unsigned long flags;
 
 		if ((io_32bit & 2) && !mmio) {
 			local_irq_save(flags);
@@ -216,7 +216,7 @@ void ide_output_data(ide_drive_t *drive, struct ide_cmd *cmd, void *buf,
 	u8 mmio = (hwif->host_flags & IDE_HFLAG_MMIO) ? 1 : 0;
 
 	if (io_32bit) {
-		unsigned long uninitialized_var(flags);
+		unsigned long flags;
 
 		if ((io_32bit & 2) && !mmio) {
 			local_irq_save(flags);
diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 7f34dc49c9b5..70bc469e10c4 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -767,13 +767,13 @@ irqreturn_t ide_intr (int irq, void *dev_id)
 {
 	ide_hwif_t *hwif = (ide_hwif_t *)dev_id;
 	struct ide_host *host = hwif->host;
-	ide_drive_t *uninitialized_var(drive);
+	ide_drive_t *drive;
 	ide_handler_t *handler;
 	unsigned long flags;
 	ide_startstop_t startstop;
 	irqreturn_t irq_ret = IRQ_NONE;
 	int plug_device = 0;
-	struct request *uninitialized_var(rq_in_flight);
+	struct request *rq_in_flight;
 
 	if (host->host_flags & IDE_HFLAG_SERIALIZE) {
 		if (hwif != host->cur_port)
diff --git a/drivers/ide/ide-sysfs.c b/drivers/ide/ide-sysfs.c
index b9dfeb2e8bd6..c08a8a0916e2 100644
--- a/drivers/ide/ide-sysfs.c
+++ b/drivers/ide/ide-sysfs.c
@@ -131,7 +131,7 @@ static struct device_attribute *ide_port_attrs[] = {
 
 int ide_sysfs_register_port(ide_hwif_t *hwif)
 {
-	int i, uninitialized_var(rc);
+	int i, rc;
 
 	for (i = 0; ide_port_attrs[i]; i++) {
 		rc = device_create_file(hwif->portdev, ide_port_attrs[i]);
diff --git a/drivers/ide/umc8672.c b/drivers/ide/umc8672.c
index 3aa0fea0f3d9..1414caa97b40 100644
--- a/drivers/ide/umc8672.c
+++ b/drivers/ide/umc8672.c
@@ -107,7 +107,7 @@ static void umc_set_speeds(u8 speeds[])
 static void umc_set_pio_mode(ide_hwif_t *hwif, ide_drive_t *drive)
 {
 	ide_hwif_t *mate = hwif->mate;
-	unsigned long uninitialized_var(flags);
+	unsigned long flags;
 	const u8 pio = drive->pio_mode - XFER_PIO_0;
 
 	printk("%s: setting umc8672 to PIO mode%d (speed %d)\n",
diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 9b2121f24926..51c8ed9a4e00 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -75,7 +75,7 @@
 	#define MESON_SAR_ADC_REG3_PANEL_DETECT_COUNT_MASK	GENMASK(20, 18)
 	#define MESON_SAR_ADC_REG3_PANEL_DETECT_FILTER_TB_MASK	GENMASK(17, 16)
 	#define MESON_SAR_ADC_REG3_ADC_CLK_DIV_SHIFT		10
-	#define MESON_SAR_ADC_REG3_ADC_CLK_DIV_WIDTH		5
+	#define MESON_SAR_ADC_REG3_ADC_CLK_DIV_WIDTH		6
 	#define MESON_SAR_ADC_REG3_BLOCK_DLY_SEL_MASK		GENMASK(9, 8)
 	#define MESON_SAR_ADC_REG3_BLOCK_DLY_MASK		GENMASK(7, 0)
 
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index f836ed1dd300..e59caabb6cdf 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1738,7 +1738,7 @@ ssize_t ib_uverbs_open_qp(struct ib_uverbs_file *file,
 	struct ib_udata                 udata;
 	struct ib_uqp_object           *obj;
 	struct ib_xrcd		       *xrcd;
-	struct ib_uobject	       *uninitialized_var(xrcd_uobj);
+	struct ib_uobject	       *xrcd_uobj;
 	struct ib_qp                   *qp;
 	struct ib_qp_open_attr          attr;
 	int ret;
@@ -3538,7 +3538,7 @@ static int __uverbs_create_xsrq(struct ib_uverbs_file *file,
 	struct ib_usrq_object           *obj;
 	struct ib_pd                    *pd;
 	struct ib_srq                   *srq;
-	struct ib_uobject               *uninitialized_var(xrcd_uobj);
+	struct ib_uobject               *xrcd_uobj;
 	struct ib_srq_init_attr          attr;
 	int ret;
 
diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index 2ea87fe1184d..357960d48e66 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -3168,7 +3168,7 @@ static int get_lladdr(struct net_device *dev, struct in6_addr *addr,
 
 static int pick_local_ip6addrs(struct c4iw_dev *dev, struct iw_cm_id *cm_id)
 {
-	struct in6_addr uninitialized_var(addr);
+	struct in6_addr addr;
 	struct sockaddr_in6 *la6 = (struct sockaddr_in6 *)&cm_id->m_local_addr;
 	struct sockaddr_in6 *ra6 = (struct sockaddr_in6 *)&cm_id->m_remote_addr;
 
diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index be6612fc33ac..109a21f8ca54 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -1285,7 +1285,7 @@ int mlx5_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata)
 	__be64 *pas;
 	int page_shift;
 	int inlen;
-	int uninitialized_var(cqe_size);
+	int cqe_size;
 	unsigned long flags;
 
 	if (!MLX5_CAP_GEN(dev->mdev, cq_resize)) {
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index d21960cd9a49..1fb3d0a5a880 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -1630,8 +1630,8 @@ int mthca_tavor_post_send(struct ib_qp *ibqp, struct ib_send_wr *wr,
 	 * without initializing f0 and size0, and they are in fact
 	 * never used uninitialized.
 	 */
-	int uninitialized_var(size0);
-	u32 uninitialized_var(f0);
+	int size0;
+	u32 f0;
 	int ind;
 	u8 op0 = 0;
 
@@ -1831,7 +1831,7 @@ int mthca_tavor_post_receive(struct ib_qp *ibqp, struct ib_recv_wr *wr,
 	 * without initializing size0, and it is in fact never used
 	 * uninitialized.
 	 */
-	int uninitialized_var(size0);
+	int size0;
 	int ind;
 	void *wqe;
 	void *prev_wqe;
@@ -1945,8 +1945,8 @@ int mthca_arbel_post_send(struct ib_qp *ibqp, struct ib_send_wr *wr,
 	 * without initializing f0 and size0, and they are in fact
 	 * never used uninitialized.
 	 */
-	int uninitialized_var(size0);
-	u32 uninitialized_var(f0);
+	int size0;
+	u32 f0;
 	int ind;
 	u8 op0 = 0;
 
diff --git a/drivers/input/misc/adxl34x.c b/drivers/input/misc/adxl34x.c
index 2e189646d8fe..d56ab4b25edf 100644
--- a/drivers/input/misc/adxl34x.c
+++ b/drivers/input/misc/adxl34x.c
@@ -811,8 +811,7 @@ struct adxl34x *adxl34x_probe(struct device *dev, int irq,
 	AC_WRITE(ac, POWER_CTL, 0);
 
 	err = request_threaded_irq(ac->irq, NULL, adxl34x_irq,
-				   IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
-				   dev_name(dev), ac);
+				   IRQF_ONESHOT, dev_name(dev), ac);
 	if (err) {
 		dev_err(dev, "irq %d busy?\n", ac->irq);
 		goto err_free_mem;
diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index 17eb84ab4c0b..fe3fbde989be 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -443,6 +443,7 @@ static int drv260x_init(struct drv260x_data *haptics)
 	}
 
 	do {
+		usleep_range(15000, 15500);
 		error = regmap_read(haptics->regmap, DRV260X_GO, &cal_buf);
 		if (error) {
 			dev_err(&haptics->client->dev,
diff --git a/drivers/input/serio/serio_raw.c b/drivers/input/serio/serio_raw.c
index 516f9fe77a17..20d37d6a60c0 100644
--- a/drivers/input/serio/serio_raw.c
+++ b/drivers/input/serio/serio_raw.c
@@ -162,7 +162,7 @@ static ssize_t serio_raw_read(struct file *file, char __user *buffer,
 {
 	struct serio_raw_client *client = file->private_data;
 	struct serio_raw *serio_raw = client->serio_raw;
-	char uninitialized_var(c);
+	char c;
 	ssize_t read = 0;
 	int error;
 
diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l1.c
index 31ea6332ecb8..60dc64b4ac6d 100644
--- a/drivers/irqchip/irq-bcm6345-l1.c
+++ b/drivers/irqchip/irq-bcm6345-l1.c
@@ -85,6 +85,7 @@ struct bcm6345_l1_chip {
 };
 
 struct bcm6345_l1_cpu {
+	struct bcm6345_l1_chip	*intc;
 	void __iomem		*map_base;
 	unsigned int		parent_irq;
 	u32			enable_cache[];
@@ -118,17 +119,11 @@ static inline unsigned int cpu_for_irq(struct bcm6345_l1_chip *intc,
 
 static void bcm6345_l1_irq_handle(struct irq_desc *desc)
 {
-	struct bcm6345_l1_chip *intc = irq_desc_get_handler_data(desc);
-	struct bcm6345_l1_cpu *cpu;
+	struct bcm6345_l1_cpu *cpu = irq_desc_get_handler_data(desc);
+	struct bcm6345_l1_chip *intc = cpu->intc;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int idx;
 
-#ifdef CONFIG_SMP
-	cpu = intc->cpus[cpu_logical_map(smp_processor_id())];
-#else
-	cpu = intc->cpus[0];
-#endif
-
 	chained_irq_enter(chip, desc);
 
 	for (idx = 0; idx < intc->n_words; idx++) {
@@ -260,6 +255,7 @@ static int __init bcm6345_l1_init_one(struct device_node *dn,
 	if (!cpu)
 		return -ENOMEM;
 
+	cpu->intc = intc;
 	cpu->map_base = ioremap(res.start, sz);
 	if (!cpu->map_base)
 		return -ENOMEM;
@@ -275,7 +271,7 @@ static int __init bcm6345_l1_init_one(struct device_node *dn,
 		return -EINVAL;
 	}
 	irq_set_chained_handler_and_data(cpu->parent_irq,
-						bcm6345_l1_irq_handle, intc);
+						bcm6345_l1_irq_handle, cpu);
 
 	return 0;
 }
diff --git a/drivers/mailbox/ti-msgmgr.c b/drivers/mailbox/ti-msgmgr.c
index 54b9e4cb4cfa..0c4d3640fcbf 100644
--- a/drivers/mailbox/ti-msgmgr.c
+++ b/drivers/mailbox/ti-msgmgr.c
@@ -310,14 +310,20 @@ static int ti_msgmgr_send_data(struct mbox_chan *chan, void *data)
 		/* Ensure all unused data is 0 */
 		data_trail &= 0xFFFFFFFF >> (8 * (sizeof(u32) - trail_bytes));
 		writel(data_trail, data_reg);
-		data_reg++;
+		data_reg += sizeof(u32);
 	}
+
 	/*
 	 * 'data_reg' indicates next register to write. If we did not already
 	 * write on tx complete reg(last reg), we must do so for transmit
+	 * In addition, we also need to make sure all intermediate data
+	 * registers(if any required), are reset to 0 for TISCI backward
+	 * compatibility to be maintained.
 	 */
-	if (data_reg <= qinst->queue_buff_end)
-		writel(0, qinst->queue_buff_end);
+	while (data_reg <= qinst->queue_buff_end) {
+		writel(0, data_reg);
+		data_reg += sizeof(u32);
+	}
 
 	return 0;
 }
diff --git a/drivers/md/dm-cache-policy-smq.c b/drivers/md/dm-cache-policy-smq.c
index e5eb9c9b4bc8..4c8eeed2e255 100644
--- a/drivers/md/dm-cache-policy-smq.c
+++ b/drivers/md/dm-cache-policy-smq.c
@@ -841,7 +841,13 @@ struct smq_policy {
 
 	struct background_tracker *bg_work;
 
-	bool migrations_allowed;
+	bool migrations_allowed:1;
+
+	/*
+	 * If this is set the policy will try and clean the whole cache
+	 * even if the device is not idle.
+	 */
+	bool cleaner:1;
 };
 
 /*----------------------------------------------------------------*/
@@ -1120,7 +1126,7 @@ static bool clean_target_met(struct smq_policy *mq, bool idle)
 	 * Cache entries may not be populated.  So we cannot rely on the
 	 * size of the clean queue.
 	 */
-	if (idle) {
+	if (idle || mq->cleaner) {
 		/*
 		 * We'd like to clean everything.
 		 */
@@ -1692,11 +1698,9 @@ static void calc_hotspot_params(sector_t origin_size,
 		*hotspot_block_size /= 2u;
 }
 
-static struct dm_cache_policy *__smq_create(dm_cblock_t cache_size,
-					    sector_t origin_size,
-					    sector_t cache_block_size,
-					    bool mimic_mq,
-					    bool migrations_allowed)
+static struct dm_cache_policy *
+__smq_create(dm_cblock_t cache_size, sector_t origin_size, sector_t cache_block_size,
+	     bool mimic_mq, bool migrations_allowed, bool cleaner)
 {
 	unsigned i;
 	unsigned nr_sentinels_per_queue = 2u * NR_CACHE_LEVELS;
@@ -1783,6 +1787,7 @@ static struct dm_cache_policy *__smq_create(dm_cblock_t cache_size,
 		goto bad_btracker;
 
 	mq->migrations_allowed = migrations_allowed;
+	mq->cleaner = cleaner;
 
 	return &mq->policy;
 
@@ -1806,21 +1811,24 @@ static struct dm_cache_policy *smq_create(dm_cblock_t cache_size,
 					  sector_t origin_size,
 					  sector_t cache_block_size)
 {
-	return __smq_create(cache_size, origin_size, cache_block_size, false, true);
+	return __smq_create(cache_size, origin_size, cache_block_size,
+			    false, true, false);
 }
 
 static struct dm_cache_policy *mq_create(dm_cblock_t cache_size,
 					 sector_t origin_size,
 					 sector_t cache_block_size)
 {
-	return __smq_create(cache_size, origin_size, cache_block_size, true, true);
+	return __smq_create(cache_size, origin_size, cache_block_size,
+			    true, true, false);
 }
 
 static struct dm_cache_policy *cleaner_create(dm_cblock_t cache_size,
 					      sector_t origin_size,
 					      sector_t cache_block_size)
 {
-	return __smq_create(cache_size, origin_size, cache_block_size, false, false);
+	return __smq_create(cache_size, origin_size, cache_block_size,
+			    false, false, true);
 }
 
 /*----------------------------------------------------------------*/
diff --git a/drivers/md/dm-io.c b/drivers/md/dm-io.c
index 56e2c0e079d7..3ac1e907c9b5 100644
--- a/drivers/md/dm-io.c
+++ b/drivers/md/dm-io.c
@@ -306,7 +306,7 @@ static void do_region(int op, int op_flags, unsigned region,
 	struct request_queue *q = bdev_get_queue(where->bdev);
 	unsigned short logical_block_size = queue_logical_block_size(q);
 	sector_t num_sectors;
-	unsigned int uninitialized_var(special_cmd_max_sectors);
+	unsigned int special_cmd_max_sectors;
 
 	/*
 	 * Reject unsupported discard and write same requests.
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index d49a0857cbb8..3e379105f20d 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1821,7 +1821,7 @@ static int ctl_ioctl(struct file *file, uint command, struct dm_ioctl __user *us
 	int ioctl_flags;
 	int param_flags;
 	unsigned int cmd;
-	struct dm_ioctl *uninitialized_var(param);
+	struct dm_ioctl *param;
 	ioctl_fn fn = NULL;
 	size_t input_param_size;
 	struct dm_ioctl param_kernel;
diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 025a36ddf26e..b818cc982e62 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3190,15 +3190,19 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	/* Try to adjust the raid4/5/6 stripe cache size to the stripe size */
 	if (rs_is_raid456(rs)) {
 		r = rs_set_raid456_stripe_cache(rs);
-		if (r)
+		if (r) {
+			mddev_unlock(&rs->md);
 			goto bad_stripe_cache;
+		}
 	}
 
 	/* Now do an early reshape check */
 	if (test_bit(RT_FLAG_RESHAPE_RS, &rs->runtime_flags)) {
 		r = rs_check_reshape(rs);
-		if (r)
+		if (r) {
+			mddev_unlock(&rs->md);
 			goto bad_check_reshape;
+		}
 
 		/* Restore new, ctr requested layout to perform check */
 		rs_config_restore(rs, &rs_layout);
@@ -3207,6 +3211,7 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 			r = rs->md.pers->check_reshape(&rs->md);
 			if (r) {
 				ti->error = "Reshape check failed";
+				mddev_unlock(&rs->md);
 				goto bad_check_reshape;
 			}
 		}
diff --git a/drivers/md/dm-snap-persistent.c b/drivers/md/dm-snap-persistent.c
index 00025569e807..c3b29de70695 100644
--- a/drivers/md/dm-snap-persistent.c
+++ b/drivers/md/dm-snap-persistent.c
@@ -613,7 +613,7 @@ static int persistent_read_metadata(struct dm_exception_store *store,
 						    chunk_t old, chunk_t new),
 				    void *callback_context)
 {
-	int r, uninitialized_var(new_snapshot);
+	int r, new_snapshot;
 	struct pstore *ps = get_info(store);
 
 	/*
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 3b2a880eed68..922ff492ab03 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -670,7 +670,7 @@ static int validate_hardware_logical_block_alignment(struct dm_table *table,
 	 */
 	unsigned short remaining = 0;
 
-	struct dm_target *uninitialized_var(ti);
+	struct dm_target *ti;
 	struct queue_limits ti_limits;
 	unsigned i;
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 69d1501d9160..3c2364d0d88f 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3647,8 +3647,9 @@ int strict_strtoul_scaled(const char *cp, unsigned long *res, int scale)
 static ssize_t
 safe_delay_show(struct mddev *mddev, char *page)
 {
-	int msec = (mddev->safemode_delay*1000)/HZ;
-	return sprintf(page, "%d.%03d\n", msec/1000, msec%1000);
+	unsigned int msec = ((unsigned long)mddev->safemode_delay*1000)/HZ;
+
+	return sprintf(page, "%u.%03u\n", msec/1000, msec%1000);
 }
 static ssize_t
 safe_delay_store(struct mddev *mddev, const char *cbuf, size_t len)
@@ -3660,7 +3661,7 @@ safe_delay_store(struct mddev *mddev, const char *cbuf, size_t len)
 		return -EINVAL;
 	}
 
-	if (strict_strtoul_scaled(cbuf, &msec, 3) < 0)
+	if (strict_strtoul_scaled(cbuf, &msec, 3) < 0 || msec > UINT_MAX / HZ)
 		return -EINVAL;
 	if (msec == 0)
 		mddev->safemode_delay = 0;
@@ -4312,6 +4313,8 @@ max_corrected_read_errors_store(struct mddev *mddev, const char *buf, size_t len
 	rv = kstrtouint(buf, 10, &n);
 	if (rv < 0)
 		return rv;
+	if (n > INT_MAX)
+		return -EINVAL;
 	atomic_set(&mddev->max_corr_read_errors, n);
 	return len;
 }
@@ -4612,11 +4615,21 @@ action_store(struct mddev *mddev, const char *page, size_t len)
 			return -EINVAL;
 		err = mddev_lock(mddev);
 		if (!err) {
-			if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
+			if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
 				err =  -EBUSY;
-			else {
+			} else if (mddev->reshape_position == MaxSector ||
+				   mddev->pers->check_reshape == NULL ||
+				   mddev->pers->check_reshape(mddev)) {
 				clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 				err = mddev->pers->start_reshape(mddev);
+			} else {
+				/*
+				 * If reshape is still in progress, and
+				 * md_check_recovery() can continue to reshape,
+				 * don't restart reshape because data can be
+				 * corrupted for raid456.
+				 */
+				clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 			}
 			mddev_unlock(mddev);
 		}
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index 2c79685a6d45..cba812895318 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -294,6 +294,18 @@ static int create_strip_zones(struct mddev *mddev, struct r0conf **private_conf)
 		goto abort;
 	}
 
+	if (conf->layout == RAID0_ORIG_LAYOUT) {
+		for (i = 1; i < conf->nr_strip_zones; i++) {
+			sector_t first_sector = conf->strip_zone[i-1].zone_end;
+
+			sector_div(first_sector, mddev->chunk_sectors);
+			zone = conf->strip_zone + i;
+			/* disk_shift is first disk index used in the zone */
+			zone->disk_shift = sector_div(first_sector,
+						      zone->nb_dev);
+		}
+	}
+
 	pr_debug("md/raid0:%s: done.\n", mdname(mddev));
 	*private_conf = conf;
 
@@ -480,6 +492,20 @@ static inline int is_io_in_chunk_boundary(struct mddev *mddev,
 	}
 }
 
+/*
+ * Convert disk_index to the disk order in which it is read/written.
+ *  For example, if we have 4 disks, they are numbered 0,1,2,3. If we
+ *  write the disks starting at disk 3, then the read/write order would
+ *  be disk 3, then 0, then 1, and then disk 2 and we want map_disk_shift()
+ *  to map the disks as follows 0,1,2,3 => 1,2,3,0. So disk 0 would map
+ *  to 1, 1 to 2, 2 to 3, and 3 to 0. That way we can compare disks in
+ *  that 'output' space to understand the read/write disk ordering.
+ */
+static int map_disk_shift(int disk_index, int num_disks, int disk_shift)
+{
+	return ((disk_index + num_disks - disk_shift) % num_disks);
+}
+
 static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 {
 	struct r0conf *conf = mddev->private;
@@ -493,7 +519,9 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 	sector_t end_disk_offset;
 	unsigned int end_disk_index;
 	unsigned int disk;
+	sector_t orig_start, orig_end;
 
+	orig_start = start;
 	zone = find_zone(conf, &start);
 
 	if (bio_end_sector(bio) > zone->zone_end) {
@@ -507,6 +535,7 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 	} else
 		end = bio_end_sector(bio);
 
+	orig_end = end;
 	if (zone != conf->strip_zone)
 		end = end - zone[-1].zone_end;
 
@@ -518,13 +547,26 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 	last_stripe_index = end;
 	sector_div(last_stripe_index, stripe_size);
 
-	start_disk_index = (int)(start - first_stripe_index * stripe_size) /
-		mddev->chunk_sectors;
+	/* In the first zone the original and alternate layouts are the same */
+	if ((conf->layout == RAID0_ORIG_LAYOUT) && (zone != conf->strip_zone)) {
+		sector_div(orig_start, mddev->chunk_sectors);
+		start_disk_index = sector_div(orig_start, zone->nb_dev);
+		start_disk_index = map_disk_shift(start_disk_index,
+						  zone->nb_dev,
+						  zone->disk_shift);
+		sector_div(orig_end, mddev->chunk_sectors);
+		end_disk_index = sector_div(orig_end, zone->nb_dev);
+		end_disk_index = map_disk_shift(end_disk_index,
+						zone->nb_dev, zone->disk_shift);
+	} else {
+		start_disk_index = (int)(start - first_stripe_index * stripe_size) /
+			mddev->chunk_sectors;
+		end_disk_index = (int)(end - last_stripe_index * stripe_size) /
+			mddev->chunk_sectors;
+	}
 	start_disk_offset = ((int)(start - first_stripe_index * stripe_size) %
 		mddev->chunk_sectors) +
 		first_stripe_index * mddev->chunk_sectors;
-	end_disk_index = (int)(end - last_stripe_index * stripe_size) /
-		mddev->chunk_sectors;
 	end_disk_offset = ((int)(end - last_stripe_index * stripe_size) %
 		mddev->chunk_sectors) +
 		last_stripe_index * mddev->chunk_sectors;
@@ -533,18 +575,22 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 		sector_t dev_start, dev_end;
 		struct bio *discard_bio = NULL;
 		struct md_rdev *rdev;
+		int compare_disk;
+
+		compare_disk = map_disk_shift(disk, zone->nb_dev,
+					      zone->disk_shift);
 
-		if (disk < start_disk_index)
+		if (compare_disk < start_disk_index)
 			dev_start = (first_stripe_index + 1) *
 				mddev->chunk_sectors;
-		else if (disk > start_disk_index)
+		else if (compare_disk > start_disk_index)
 			dev_start = first_stripe_index * mddev->chunk_sectors;
 		else
 			dev_start = start_disk_offset;
 
-		if (disk < end_disk_index)
+		if (compare_disk < end_disk_index)
 			dev_end = (last_stripe_index + 1) * mddev->chunk_sectors;
-		else if (disk > end_disk_index)
+		else if (compare_disk > end_disk_index)
 			dev_end = last_stripe_index * mddev->chunk_sectors;
 		else
 			dev_end = end_disk_offset;
diff --git a/drivers/md/raid0.h b/drivers/md/raid0.h
index 3816e5477db1..8cc761ca7423 100644
--- a/drivers/md/raid0.h
+++ b/drivers/md/raid0.h
@@ -6,6 +6,7 @@ struct strip_zone {
 	sector_t zone_end;	/* Start of the next zone (in sectors) */
 	sector_t dev_start;	/* Zone offset in real dev (in sectors) */
 	int	 nb_dev;	/* # of devices attached to the zone */
+	int	 disk_shift;	/* start disk for the original layout */
 };
 
 /* Linux 3.14 (20d0189b101) made an unintended change to
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 95c3a21cd733..6ecc68fd702e 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -775,8 +775,16 @@ static struct md_rdev *read_balance(struct r10conf *conf,
 		disk = r10_bio->devs[slot].devnum;
 		rdev = rcu_dereference(conf->mirrors[disk].replacement);
 		if (rdev == NULL || test_bit(Faulty, &rdev->flags) ||
-		    r10_bio->devs[slot].addr + sectors > rdev->recovery_offset)
+		    r10_bio->devs[slot].addr + sectors >
+		    rdev->recovery_offset) {
+			/*
+			 * Read replacement first to prevent reading both rdev
+			 * and replacement as NULL during replacement replace
+			 * rdev.
+			 */
+			smp_mb();
 			rdev = rcu_dereference(conf->mirrors[disk].rdev);
+		}
 		if (rdev == NULL ||
 		    test_bit(Faulty, &rdev->flags))
 			continue;
@@ -916,6 +924,7 @@ static void flush_pending_writes(struct r10conf *conf)
 			else
 				generic_make_request(bio);
 			bio = next;
+			cond_resched();
 		}
 		blk_finish_plug(&plug);
 	} else
@@ -1101,6 +1110,7 @@ static void raid10_unplug(struct blk_plug_cb *cb, bool from_schedule)
 		else
 			generic_make_request(bio);
 		bio = next;
+		cond_resched();
 	}
 	kfree(plug);
 }
@@ -1366,9 +1376,15 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 
 	for (i = 0;  i < conf->copies; i++) {
 		int d = r10_bio->devs[i].devnum;
-		struct md_rdev *rdev = rcu_dereference(conf->mirrors[d].rdev);
-		struct md_rdev *rrdev = rcu_dereference(
-			conf->mirrors[d].replacement);
+		struct md_rdev *rdev, *rrdev;
+
+		rrdev = rcu_dereference(conf->mirrors[d].replacement);
+		/*
+		 * Read replacement first to prevent reading both rdev and
+		 * replacement as NULL during replacement replace rdev.
+		 */
+		smp_mb();
+		rdev = rcu_dereference(conf->mirrors[d].rdev);
 		if (rdev == rrdev)
 			rrdev = NULL;
 		if (rdev && unlikely(test_bit(Blocked, &rdev->flags))) {
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index dc053a43a3dc..d2ac3d189410 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2601,7 +2601,7 @@ static void raid5_end_write_request(struct bio *bi)
 	struct stripe_head *sh = bi->bi_private;
 	struct r5conf *conf = sh->raid_conf;
 	int disks = sh->disks, i;
-	struct md_rdev *uninitialized_var(rdev);
+	struct md_rdev *rdev;
 	sector_t first_bad;
 	int bad_sectors;
 	int replacement = 0;
diff --git a/drivers/media/dvb-frontends/rtl2832.c b/drivers/media/dvb-frontends/rtl2832.c
index 94bf5b7d6f3f..3690ea9dac22 100644
--- a/drivers/media/dvb-frontends/rtl2832.c
+++ b/drivers/media/dvb-frontends/rtl2832.c
@@ -653,7 +653,7 @@ static int rtl2832_read_status(struct dvb_frontend *fe, enum fe_status *status)
 	struct i2c_client *client = dev->client;
 	struct dtv_frontend_properties *c = &fe->dtv_property_cache;
 	int ret;
-	u32 uninitialized_var(tmp);
+	u32 tmp;
 	u8 u8tmp, buf[2];
 	u16 u16tmp;
 
diff --git a/drivers/media/usb/dvb-usb-v2/az6007.c b/drivers/media/usb/dvb-usb-v2/az6007.c
index 1414d59e85ba..1830badb180d 100644
--- a/drivers/media/usb/dvb-usb-v2/az6007.c
+++ b/drivers/media/usb/dvb-usb-v2/az6007.c
@@ -210,7 +210,8 @@ static int az6007_rc_query(struct dvb_usb_device *d)
 	unsigned code;
 	enum rc_proto proto;
 
-	az6007_read(d, AZ6007_READ_IR, 0, 0, st->data, 10);
+	if (az6007_read(d, AZ6007_READ_IR, 0, 0, st->data, 10) < 0)
+		return -EIO;
 
 	if (st->data[1] == 0x44)
 		return 0;
diff --git a/drivers/media/usb/gspca/vicam.c b/drivers/media/usb/gspca/vicam.c
index 554b90ef2200..2b15cb8e077c 100644
--- a/drivers/media/usb/gspca/vicam.c
+++ b/drivers/media/usb/gspca/vicam.c
@@ -234,7 +234,7 @@ static int sd_init(struct gspca_dev *gspca_dev)
 {
 	int ret;
 	const struct ihex_binrec *rec;
-	const struct firmware *uninitialized_var(fw);
+	const struct firmware *fw;
 	u8 *firmware_buf;
 
 	ret = request_ihex_firmware(&fw, VICAM_FIRMWARE,
diff --git a/drivers/media/usb/siano/smsusb.c b/drivers/media/usb/siano/smsusb.c
index cdbc636e8ff8..92a6192f9ab2 100644
--- a/drivers/media/usb/siano/smsusb.c
+++ b/drivers/media/usb/siano/smsusb.c
@@ -191,7 +191,8 @@ static void smsusb_stop_streaming(struct smsusb_device_t *dev)
 
 	for (i = 0; i < MAX_URBS; i++) {
 		usb_kill_urb(&dev->surbs[i].urb);
-		cancel_work_sync(&dev->surbs[i].wq);
+		if (dev->surbs[i].wq.func)
+			cancel_work_sync(&dev->surbs[i].wq);
 
 		if (dev->surbs[i].cb) {
 			smscore_putbuffer(dev->coredev, dev->surbs[i].cb);
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 601782663871..a0440f095515 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -766,9 +766,9 @@ static void uvc_video_stats_decode(struct uvc_streaming *stream,
 	unsigned int header_size;
 	bool has_pts = false;
 	bool has_scr = false;
-	u16 uninitialized_var(scr_sof);
-	u32 uninitialized_var(scr_stc);
-	u32 uninitialized_var(pts);
+	u16 scr_sof;
+	u32 scr_stc;
+	u32 pts;
 
 	if (stream->stats.stream.nb_frames == 0 &&
 	    stream->stats.frame.nb_packets == 0)
@@ -1656,7 +1656,7 @@ static int uvc_init_video(struct uvc_streaming *stream, gfp_t gfp_flags)
 		struct usb_host_endpoint *best_ep = NULL;
 		unsigned int best_psize = UINT_MAX;
 		unsigned int bandwidth;
-		unsigned int uninitialized_var(altsetting);
+		unsigned int altsetting;
 		int intfnum = stream->intfnum;
 
 		/* Isochronous endpoint, select the alternate setting. */
diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
index ba6cd576e997..6c762f4cfac7 100644
--- a/drivers/memstick/host/jmb38x_ms.c
+++ b/drivers/memstick/host/jmb38x_ms.c
@@ -315,7 +315,7 @@ static int jmb38x_ms_transfer_data(struct jmb38x_ms_host *host)
 	}
 
 	while (length) {
-		unsigned int uninitialized_var(p_off);
+		unsigned int p_off;
 
 		if (host->req->long_data) {
 			pg = nth_page(sg_page(&host->req->sg),
diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
index d52c89b2a1d5..a2dbf3331689 100644
--- a/drivers/memstick/host/r592.c
+++ b/drivers/memstick/host/r592.c
@@ -47,12 +47,10 @@ static const char *tpc_names[] = {
  * memstick_debug_get_tpc_name - debug helper that returns string for
  * a TPC number
  */
-const char *memstick_debug_get_tpc_name(int tpc)
+static __maybe_unused const char *memstick_debug_get_tpc_name(int tpc)
 {
 	return tpc_names[tpc-1];
 }
-EXPORT_SYMBOL(memstick_debug_get_tpc_name);
-
 
 /* Read a register*/
 static inline u32 r592_read_reg(struct r592_device *dev, int address)
diff --git a/drivers/memstick/host/tifm_ms.c b/drivers/memstick/host/tifm_ms.c
index 7bafa72f8f57..0625fd92e649 100644
--- a/drivers/memstick/host/tifm_ms.c
+++ b/drivers/memstick/host/tifm_ms.c
@@ -200,7 +200,7 @@ static unsigned int tifm_ms_transfer_data(struct tifm_ms *host)
 		host->block_pos);
 
 	while (length) {
-		unsigned int uninitialized_var(p_off);
+		unsigned int p_off;
 
 		if (host->req->long_data) {
 			pg = nth_page(sg_page(&host->req->sg),
diff --git a/drivers/mfd/intel-lpss-acpi.c b/drivers/mfd/intel-lpss-acpi.c
index fc44fb7c595b..281ef5f52eb5 100644
--- a/drivers/mfd/intel-lpss-acpi.c
+++ b/drivers/mfd/intel-lpss-acpi.c
@@ -92,6 +92,9 @@ static int intel_lpss_acpi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	info->mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!info->mem)
+		return -ENODEV;
+
 	info->irq = platform_get_irq(pdev, 0);
 
 	ret = intel_lpss_probe(&pdev->dev, info);
diff --git a/drivers/mfd/rt5033.c b/drivers/mfd/rt5033.c
index 9bd089c56375..94cdad91c065 100644
--- a/drivers/mfd/rt5033.c
+++ b/drivers/mfd/rt5033.c
@@ -44,9 +44,6 @@ static const struct mfd_cell rt5033_devs[] = {
 	{
 		.name = "rt5033-charger",
 		.of_compatible = "richtek,rt5033-charger",
-	}, {
-		.name = "rt5033-battery",
-		.of_compatible = "richtek,rt5033-battery",
 	}, {
 		.name = "rt5033-led",
 		.of_compatible = "richtek,rt5033-led",
diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index 722ad2c368a5..d752c56d60e4 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -1428,9 +1428,9 @@ int stmpe_probe(struct stmpe_client_info *ci, enum stmpe_partnum partnum)
 
 int stmpe_remove(struct stmpe *stmpe)
 {
-	if (!IS_ERR(stmpe->vio))
+	if (!IS_ERR(stmpe->vio) && regulator_is_enabled(stmpe->vio))
 		regulator_disable(stmpe->vio);
-	if (!IS_ERR(stmpe->vcc))
+	if (!IS_ERR(stmpe->vcc) && regulator_is_enabled(stmpe->vcc))
 		regulator_disable(stmpe->vcc);
 
 	mfd_remove_devices(stmpe->dev);
diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 953af49dd38a..60cf07497e7b 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -425,6 +425,10 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	struct pci_endpoint_test *test = to_endpoint_test(file->private_data);
 
 	mutex_lock(&test->mutex);
+
+	reinit_completion(&test->irq_raised);
+	test->last_irq = -ENODATA;
+
 	switch (cmd) {
 	case PCITEST_BAR:
 		bar = arg;
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index 09897abb79ed..f67401aa3a98 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -90,6 +90,20 @@ static const struct mmc_fixup mmc_blk_fixups[] = {
 	MMC_FIXUP("VZL00M", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
 		  MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
 
+	/*
+	 * Kingston EMMC04G-M627 advertises TRIM but it does not seems to
+	 * support being used to offload WRITE_ZEROES.
+	 */
+	MMC_FIXUP("M62704", CID_MANFID_KINGSTON, 0x0100, add_quirk_mmc,
+		  MMC_QUIRK_TRIM_BROKEN),
+
+	/*
+	 * Micron MTFC4GACAJCN-1M advertises TRIM but it does not seems to
+	 * support being used to offload WRITE_ZEROES.
+	 */
+	MMC_FIXUP("Q2J54A", CID_MANFID_MICRON, 0x014e, add_quirk_mmc,
+		  MMC_QUIRK_TRIM_BROKEN),
+
 	/*
 	 *  On Some Kingston eMMCs, performing trim can result in
 	 *  unrecoverable data conrruption occasionally due to a firmware bug.
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6bde13d9d49f..9f4b11a1aac9 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -374,7 +374,7 @@ static void sdhci_read_block_pio(struct sdhci_host *host)
 {
 	unsigned long flags;
 	size_t blksize, len, chunk;
-	u32 uninitialized_var(scratch);
+	u32 scratch;
 	u8 *buf;
 
 	DBG("PIO reading\n");
diff --git a/drivers/mtd/nand/omap_elm.c b/drivers/mtd/nand/omap_elm.c
index 6736777a4156..02d174038312 100644
--- a/drivers/mtd/nand/omap_elm.c
+++ b/drivers/mtd/nand/omap_elm.c
@@ -184,17 +184,17 @@ static void elm_load_syndrome(struct elm_info *info,
 			switch (info->bch_type) {
 			case BCH8_ECC:
 				/* syndrome fragment 0 = ecc[9-12B] */
-				val = cpu_to_be32(*(u32 *) &ecc[9]);
+				val = (__force u32)cpu_to_be32(*(u32 *)&ecc[9]);
 				elm_write_reg(info, offset, val);
 
 				/* syndrome fragment 1 = ecc[5-8B] */
 				offset += 4;
-				val = cpu_to_be32(*(u32 *) &ecc[5]);
+				val = (__force u32)cpu_to_be32(*(u32 *)&ecc[5]);
 				elm_write_reg(info, offset, val);
 
 				/* syndrome fragment 2 = ecc[1-4B] */
 				offset += 4;
-				val = cpu_to_be32(*(u32 *) &ecc[1]);
+				val = (__force u32)cpu_to_be32(*(u32 *)&ecc[1]);
 				elm_write_reg(info, offset, val);
 
 				/* syndrome fragment 3 = ecc[0B] */
@@ -204,35 +204,35 @@ static void elm_load_syndrome(struct elm_info *info,
 				break;
 			case BCH4_ECC:
 				/* syndrome fragment 0 = ecc[20-52b] bits */
-				val = (cpu_to_be32(*(u32 *) &ecc[3]) >> 4) |
+				val = ((__force u32)cpu_to_be32(*(u32 *)&ecc[3]) >> 4) |
 					((ecc[2] & 0xf) << 28);
 				elm_write_reg(info, offset, val);
 
 				/* syndrome fragment 1 = ecc[0-20b] bits */
 				offset += 4;
-				val = cpu_to_be32(*(u32 *) &ecc[0]) >> 12;
+				val = (__force u32)cpu_to_be32(*(u32 *)&ecc[0]) >> 12;
 				elm_write_reg(info, offset, val);
 				break;
 			case BCH16_ECC:
-				val = cpu_to_be32(*(u32 *) &ecc[22]);
+				val = (__force u32)cpu_to_be32(*(u32 *)&ecc[22]);
 				elm_write_reg(info, offset, val);
 				offset += 4;
-				val = cpu_to_be32(*(u32 *) &ecc[18]);
+				val = (__force u32)cpu_to_be32(*(u32 *)&ecc[18]);
 				elm_write_reg(info, offset, val);
 				offset += 4;
-				val = cpu_to_be32(*(u32 *) &ecc[14]);
+				val = (__force u32)cpu_to_be32(*(u32 *)&ecc[14]);
 				elm_write_reg(info, offset, val);
 				offset += 4;
-				val = cpu_to_be32(*(u32 *) &ecc[10]);
+				val = (__force u32)cpu_to_be32(*(u32 *)&ecc[10]);
 				elm_write_reg(info, offset, val);
 				offset += 4;
-				val = cpu_to_be32(*(u32 *) &ecc[6]);
+				val = (__force u32)cpu_to_be32(*(u32 *)&ecc[6]);
 				elm_write_reg(info, offset, val);
 				offset += 4;
-				val = cpu_to_be32(*(u32 *) &ecc[2]);
+				val = (__force u32)cpu_to_be32(*(u32 *)&ecc[2]);
 				elm_write_reg(info, offset, val);
 				offset += 4;
-				val = cpu_to_be32(*(u32 *) &ecc[0]) >> 16;
+				val = (__force u32)cpu_to_be32(*(u32 *)&ecc[0]) >> 16;
 				elm_write_reg(info, offset, val);
 				break;
 			default:
diff --git a/drivers/mtd/ubi/eba.c b/drivers/mtd/ubi/eba.c
index f452c510fa32..b7aa8cf2c3d7 100644
--- a/drivers/mtd/ubi/eba.c
+++ b/drivers/mtd/ubi/eba.c
@@ -595,7 +595,7 @@ int ubi_eba_read_leb(struct ubi_device *ubi, struct ubi_volume *vol, int lnum,
 	int err, pnum, scrub = 0, vol_id = vol->vol_id;
 	struct ubi_vid_io_buf *vidb;
 	struct ubi_vid_hdr *vid_hdr;
-	uint32_t uninitialized_var(crc);
+	uint32_t crc;
 
 	err = leb_read_lock(ubi, vol_id, lnum);
 	if (err)
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 0ffca2890e9a..e86b21f097b6 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1134,6 +1134,11 @@ static void bond_setup_by_slave(struct net_device *bond_dev,
 
 	memcpy(bond_dev->broadcast, slave_dev->broadcast,
 		slave_dev->addr_len);
+
+	if (slave_dev->flags & IFF_POINTOPOINT) {
+		bond_dev->flags &= ~(IFF_BROADCAST | IFF_MULTICAST);
+		bond_dev->flags |= (IFF_POINTOPOINT | IFF_NOARP);
+	}
 }
 
 /* On bonding slaves other than the currently active slave, suppress
diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 12a53c8e8e1d..386a204685c4 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -1455,7 +1455,7 @@ static int ican3_napi(struct napi_struct *napi, int budget)
 
 	/* process all communication messages */
 	while (true) {
-		struct ican3_msg uninitialized_var(msg);
+		struct ican3_msg msg;
 		ret = ican3_recv_msg(mod, &msg);
 		if (ret)
 			break;
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 5e21486baa22..a43f25de8574 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -740,6 +740,8 @@ static int gs_can_close(struct net_device *netdev)
 	usb_kill_anchored_urbs(&dev->tx_submitted);
 	atomic_set(&dev->active_tx_urbs, 0);
 
+	dev->can.state = CAN_STATE_STOPPED;
+
 	/* reset the device */
 	rc = gs_cmd_reset(parent, dev);
 	if (rc < 0)
diff --git a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
index 0d08039981b5..33a688d8aaba 100644
--- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
+++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
@@ -1650,8 +1650,11 @@ static int atl1e_tso_csum(struct atl1e_adapter *adapter,
 			real_len = (((unsigned char *)ip_hdr(skb) - skb->data)
 					+ ntohs(ip_hdr(skb)->tot_len));
 
-			if (real_len < skb->len)
-				pskb_trim(skb, real_len);
+			if (real_len < skb->len) {
+				err = pskb_trim(skb, real_len);
+				if (err)
+					return err;
+			}
 
 			hdr_len = (skb_transport_offset(skb) + tcp_hdrlen(skb));
 			if (unlikely(skb->len == hdr_len)) {
diff --git a/drivers/net/ethernet/broadcom/bnx2.c b/drivers/net/ethernet/broadcom/bnx2.c
index 299cefe6f94b..fd73294cb11d 100644
--- a/drivers/net/ethernet/broadcom/bnx2.c
+++ b/drivers/net/ethernet/broadcom/bnx2.c
@@ -1460,7 +1460,7 @@ bnx2_test_and_disable_2g5(struct bnx2 *bp)
 static void
 bnx2_enable_forced_2g5(struct bnx2 *bp)
 {
-	u32 uninitialized_var(bmcr);
+	u32 bmcr;
 	int err;
 
 	if (!(bp->phy_flags & BNX2_PHY_FLAG_2_5G_CAPABLE))
@@ -1504,7 +1504,7 @@ bnx2_enable_forced_2g5(struct bnx2 *bp)
 static void
 bnx2_disable_forced_2g5(struct bnx2 *bp)
 {
-	u32 uninitialized_var(bmcr);
+	u32 bmcr;
 	int err;
 
 	if (!(bp->phy_flags & BNX2_PHY_FLAG_2_5G_CAPABLE))
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index e0eacfc46dd4..bc046153edee 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -228,6 +228,7 @@ MODULE_DESCRIPTION("Broadcom Tigon3 ethernet driver");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_MODULE_VERSION);
 MODULE_FIRMWARE(FIRMWARE_TG3);
+MODULE_FIRMWARE(FIRMWARE_TG357766);
 MODULE_FIRMWARE(FIRMWARE_TG3TSO);
 MODULE_FIRMWARE(FIRMWARE_TG3TSO5);
 
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index f8541d0c7bd5..bbe8f4b250d1 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -1132,7 +1132,8 @@ static struct sk_buff *be_lancer_xmit_workarounds(struct be_adapter *adapter,
 	    (lancer_chip(adapter) || BE3_chip(adapter) ||
 	     skb_vlan_tag_present(skb)) && is_ipv4_pkt(skb)) {
 		ip = (struct iphdr *)ip_hdr(skb);
-		pskb_trim(skb, eth_hdr_len + ntohs(ip->tot_len));
+		if (unlikely(pskb_trim(skb, eth_hdr_len + ntohs(ip->tot_len))))
+			goto tx_drop;
 	}
 
 	/* If vlan tag is already inlined in the packet, skip HW VLAN
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 126207be492d..6cf38c7a157e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -1850,7 +1850,7 @@ void i40e_dbg_pf_exit(struct i40e_pf *pf)
 void i40e_dbg_init(void)
 {
 	i40e_dbg_root = debugfs_create_dir(i40e_driver_name, NULL);
-	if (!i40e_dbg_root)
+	if (IS_ERR(i40e_dbg_root))
 		pr_info("init of debugfs failed\n");
 }
 
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index ab54362c0992..d7b531eae819 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -8257,6 +8257,11 @@ static pci_ers_result_t igb_io_error_detected(struct pci_dev *pdev,
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct igb_adapter *adapter = netdev_priv(netdev);
 
+	if (state == pci_channel_io_normal) {
+		dev_warn(&pdev->dev, "Non-correctable non-fatal error reported.\n");
+		return PCI_ERS_RESULT_CAN_RECOVER;
+	}
+
 	netif_device_detach(netdev);
 
 	if (state == pci_channel_io_perm_failure)
diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index dbed8fbedd8a..eff7c65fbe3c 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1402,7 +1402,7 @@ static void mvneta_defaults_set(struct mvneta_port *pp)
 			 */
 			if (txq_number == 1)
 				txq_map = (cpu == pp->rxq_def) ?
-					MVNETA_CPU_TXQ_ACCESS(1) : 0;
+					MVNETA_CPU_TXQ_ACCESS(0) : 0;
 
 		} else {
 			txq_map = MVNETA_CPU_TXQ_ACCESS_ALL_MASK;
@@ -3387,7 +3387,7 @@ static void mvneta_percpu_elect(struct mvneta_port *pp)
 		 */
 		if (txq_number == 1)
 			txq_map = (cpu == elected_cpu) ?
-				MVNETA_CPU_TXQ_ACCESS(1) : 0;
+				MVNETA_CPU_TXQ_ACCESS(0) : 0;
 		else
 			txq_map = mvreg_read(pp, MVNETA_CPU_MAP(cpu)) &
 				MVNETA_CPU_TXQ_ACCESS_ALL_MASK;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
index 4614ddfa91eb..3803e7f23299 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
@@ -119,7 +119,9 @@ static int mlx5e_ipsec_remove_trailer(struct sk_buff *skb, struct xfrm_state *x)
 
 	trailer_len = alen + plen + 2;
 
-	pskb_trim(skb, skb->len - trailer_len);
+	ret = pskb_trim(skb, skb->len - trailer_len);
+	if (unlikely(ret))
+		return ret;
 	if (skb->protocol == htons(ETH_P_IP)) {
 		ipv4hdr->tot_len = htons(ntohs(ipv4hdr->tot_len) - trailer_len);
 		ip_send_check(ipv4hdr);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
index fc880c02459d..c9ba97b400fa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
@@ -471,8 +471,8 @@ void mlx5_core_req_pages_handler(struct mlx5_core_dev *dev, u16 func_id,
 
 int mlx5_satisfy_startup_pages(struct mlx5_core_dev *dev, int boot)
 {
-	u16 uninitialized_var(func_id);
-	s32 uninitialized_var(npages);
+	u16 func_id;
+	s32 npages;
 	int err;
 
 	err = mlx5_cmd_query_pages(dev, &func_id, &npages, boot);
diff --git a/drivers/net/ethernet/neterion/s2io.c b/drivers/net/ethernet/neterion/s2io.c
index cb8094de89d1..de1484197cc0 100644
--- a/drivers/net/ethernet/neterion/s2io.c
+++ b/drivers/net/ethernet/neterion/s2io.c
@@ -7296,7 +7296,7 @@ static int rx_osm_handler(struct ring_info *ring_data, struct RxD_t * rxdp)
 	int ring_no = ring_data->ring_no;
 	u16 l3_csum, l4_csum;
 	unsigned long long err = rxdp->Control_1 & RXD_T_CODE;
-	struct lro *uninitialized_var(lro);
+	struct lro *lro;
 	u8 err_mask;
 	struct swStat *swstats = &sp->mac_control.stats_info->sw_stat;
 
diff --git a/drivers/net/ethernet/qlogic/qla3xxx.c b/drivers/net/ethernet/qlogic/qla3xxx.c
index 82f13d69631f..6c8a591db713 100644
--- a/drivers/net/ethernet/qlogic/qla3xxx.c
+++ b/drivers/net/ethernet/qlogic/qla3xxx.c
@@ -3770,7 +3770,7 @@ static int ql3xxx_probe(struct pci_dev *pdev,
 	struct net_device *ndev = NULL;
 	struct ql3_adapter *qdev = NULL;
 	static int cards_found;
-	int uninitialized_var(pci_using_dac), err;
+	int pci_using_dac, err;
 
 	err = pci_enable_device(pdev);
 	if (err) {
diff --git a/drivers/net/ethernet/sun/cassini.c b/drivers/net/ethernet/sun/cassini.c
index 0d26e8047d70..df46850ac289 100644
--- a/drivers/net/ethernet/sun/cassini.c
+++ b/drivers/net/ethernet/sun/cassini.c
@@ -2303,7 +2303,7 @@ static int cas_rx_ringN(struct cas *cp, int ring, int budget)
 	drops = 0;
 	while (1) {
 		struct cas_rx_comp *rxc = rxcs + entry;
-		struct sk_buff *uninitialized_var(skb);
+		struct sk_buff *skb;
 		int type, len;
 		u64 words[4];
 		int i, dring;
diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index 08ac19884133..9510928eb2c5 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -428,7 +428,7 @@ static int serdes_init_niu_1g_serdes(struct niu *np)
 	struct niu_link_config *lp = &np->link_config;
 	u16 pll_cfg, pll_sts;
 	int max_retry = 100;
-	u64 uninitialized_var(sig), mask, val;
+	u64 sig, mask, val;
 	u32 tx_cfg, rx_cfg;
 	unsigned long i;
 	int err;
@@ -525,7 +525,7 @@ static int serdes_init_niu_10g_serdes(struct niu *np)
 	struct niu_link_config *lp = &np->link_config;
 	u32 tx_cfg, rx_cfg, pll_cfg, pll_sts;
 	int max_retry = 100;
-	u64 uninitialized_var(sig), mask, val;
+	u64 sig, mask, val;
 	unsigned long i;
 	int err;
 
@@ -713,7 +713,7 @@ static int esr_write_glue0(struct niu *np, unsigned long chan, u32 val)
 
 static int esr_reset(struct niu *np)
 {
-	u32 uninitialized_var(reset);
+	u32 reset;
 	int err;
 
 	err = mdio_write(np, np->port, NIU_ESR_DEV_ADDR,
diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index ddd43e09111e..d9db5c23a963 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -67,23 +67,37 @@
 
 static inline int cpsw_ale_get_field(u32 *ale_entry, u32 start, u32 bits)
 {
-	int idx;
+	int idx, idx2;
+	u32 hi_val = 0;
 
 	idx    = start / 32;
+	idx2 = (start + bits - 1) / 32;
+	/* Check if bits to be fetched exceed a word */
+	if (idx != idx2) {
+		idx2 = 2 - idx2; /* flip */
+		hi_val = ale_entry[idx2] << ((idx2 * 32) - start);
+	}
 	start -= idx * 32;
 	idx    = 2 - idx; /* flip */
-	return (ale_entry[idx] >> start) & BITMASK(bits);
+	return (hi_val + (ale_entry[idx] >> start)) & BITMASK(bits);
 }
 
 static inline void cpsw_ale_set_field(u32 *ale_entry, u32 start, u32 bits,
 				      u32 value)
 {
-	int idx;
+	int idx, idx2;
 
 	value &= BITMASK(bits);
-	idx    = start / 32;
+	idx = start / 32;
+	idx2 = (start + bits - 1) / 32;
+	/* Check if bits to be set exceed a word */
+	if (idx != idx2) {
+		idx2 = 2 - idx2; /* flip */
+		ale_entry[idx2] &= ~(BITMASK(bits + start - (idx2 * 32)));
+		ale_entry[idx2] |= (value >> ((idx2 * 32) - start));
+	}
 	start -= idx * 32;
-	idx    = 2 - idx; /* flip */
+	idx = 2 - idx; /* flip */
 	ale_entry[idx] &= ~(BITMASK(bits) << start);
 	ale_entry[idx] |=  (value << start);
 }
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 666f5e5740af..d7bf8212ff04 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -301,7 +301,9 @@ static void __gtp_encap_destroy(struct sock *sk)
 			gtp->sk1u = NULL;
 		udp_sk(sk)->encap_type = 0;
 		rcu_assign_sk_user_data(sk, NULL);
+		release_sock(sk);
 		sock_put(sk);
+		return;
 	}
 	release_sock(sk);
 }
diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index c7c1ff419d75..b318464a4fca 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2095,6 +2095,15 @@ static void team_setup_by_port(struct net_device *dev,
 	dev->mtu = port_dev->mtu;
 	memcpy(dev->broadcast, port_dev->broadcast, port_dev->addr_len);
 	eth_hw_addr_inherit(dev, port_dev);
+
+	if (port_dev->flags & IFF_POINTOPOINT) {
+		dev->flags &= ~(IFF_BROADCAST | IFF_MULTICAST);
+		dev->flags |= (IFF_POINTOPOINT | IFF_NOARP);
+	} else if ((port_dev->flags & (IFF_BROADCAST | IFF_MULTICAST)) ==
+		    (IFF_BROADCAST | IFF_MULTICAST)) {
+		dev->flags |= (IFF_BROADCAST | IFF_MULTICAST);
+		dev->flags &= ~(IFF_POINTOPOINT | IFF_NOARP);
+	}
 }
 
 static int team_dev_type_check_change(struct net_device *dev,
diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
index 0eb417b8f709..ff2f4e02b20f 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -618,9 +618,23 @@ static const struct usb_device_id	products[] = {
 	.match_flags	=   USB_DEVICE_ID_MATCH_INT_INFO
 			  | USB_DEVICE_ID_MATCH_DEVICE,
 	.idVendor		= 0x04DD,
+	.idProduct		= 0x8005,   /* A-300 */
+	ZAURUS_FAKE_INTERFACE,
+	.driver_info        = 0,
+}, {
+	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
+			  | USB_DEVICE_ID_MATCH_DEVICE,
+	.idVendor		= 0x04DD,
 	.idProduct		= 0x8006,	/* B-500/SL-5600 */
 	ZAURUS_MASTER_INTERFACE,
 	.driver_info		= 0,
+}, {
+	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
+			  | USB_DEVICE_ID_MATCH_DEVICE,
+	.idVendor		= 0x04DD,
+	.idProduct		= 0x8006,   /* B-500/SL-5600 */
+	ZAURUS_FAKE_INTERFACE,
+	.driver_info        = 0,
 }, {
 	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
 			  | USB_DEVICE_ID_MATCH_DEVICE,
@@ -628,6 +642,13 @@ static const struct usb_device_id	products[] = {
 	.idProduct		= 0x8007,	/* C-700 */
 	ZAURUS_MASTER_INTERFACE,
 	.driver_info		= 0,
+}, {
+	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
+			  | USB_DEVICE_ID_MATCH_DEVICE,
+	.idVendor		= 0x04DD,
+	.idProduct		= 0x8007,   /* C-700 */
+	ZAURUS_FAKE_INTERFACE,
+	.driver_info        = 0,
 }, {
 	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
 		 | USB_DEVICE_ID_MATCH_DEVICE,
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 71b026277b30..d0b772f433c4 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1771,6 +1771,10 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 	} else if (!info->in || !info->out)
 		status = usbnet_get_endpoints (dev, udev);
 	else {
+		u8 ep_addrs[3] = {
+			info->in + USB_DIR_IN, info->out + USB_DIR_OUT, 0
+		};
+
 		dev->in = usb_rcvbulkpipe (xdev, info->in);
 		dev->out = usb_sndbulkpipe (xdev, info->out);
 		if (!(info->flags & FLAG_NO_SETINT))
@@ -1780,6 +1784,8 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 		else
 			status = 0;
 
+		if (status == 0 && !usb_check_bulk_endpoints(udev, ep_addrs))
+			status = -EINVAL;
 	}
 	if (status >= 0 && dev->status)
 		status = init_status (dev, udev);
diff --git a/drivers/net/usb/zaurus.c b/drivers/net/usb/zaurus.c
index 1f19fc5e6117..9a6ab75752e1 100644
--- a/drivers/net/usb/zaurus.c
+++ b/drivers/net/usb/zaurus.c
@@ -301,9 +301,23 @@ static const struct usb_device_id	products [] = {
 	.match_flags	=   USB_DEVICE_ID_MATCH_INT_INFO
 			  | USB_DEVICE_ID_MATCH_DEVICE,
 	.idVendor		= 0x04DD,
+	.idProduct		= 0x8005,	/* A-300 */
+	ZAURUS_FAKE_INTERFACE,
+	.driver_info = (unsigned long)&bogus_mdlm_info,
+}, {
+	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
+			  | USB_DEVICE_ID_MATCH_DEVICE,
+	.idVendor		= 0x04DD,
 	.idProduct		= 0x8006,	/* B-500/SL-5600 */
 	ZAURUS_MASTER_INTERFACE,
 	.driver_info = ZAURUS_PXA_INFO,
+}, {
+	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
+			  | USB_DEVICE_ID_MATCH_DEVICE,
+	.idVendor		= 0x04DD,
+	.idProduct		= 0x8006,	/* B-500/SL-5600 */
+	ZAURUS_FAKE_INTERFACE,
+	.driver_info = (unsigned long)&bogus_mdlm_info,
 }, {
 	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
 	          | USB_DEVICE_ID_MATCH_DEVICE,
@@ -311,6 +325,13 @@ static const struct usb_device_id	products [] = {
 	.idProduct		= 0x8007,	/* C-700 */
 	ZAURUS_MASTER_INTERFACE,
 	.driver_info = ZAURUS_PXA_INFO,
+}, {
+	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
+			  | USB_DEVICE_ID_MATCH_DEVICE,
+	.idVendor		= 0x04DD,
+	.idProduct		= 0x8007,	/* C-700 */
+	ZAURUS_FAKE_INTERFACE,
+	.driver_info = (unsigned long)&bogus_mdlm_info,
 }, {
 	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
 		 | USB_DEVICE_ID_MATCH_DEVICE,
diff --git a/drivers/net/wan/z85230.c b/drivers/net/wan/z85230.c
index deea41e96f01..96025d42b0ee 100644
--- a/drivers/net/wan/z85230.c
+++ b/drivers/net/wan/z85230.c
@@ -705,7 +705,7 @@ EXPORT_SYMBOL(z8530_nop);
 irqreturn_t z8530_interrupt(int irq, void *dev_id)
 {
 	struct z8530_dev *dev=dev_id;
-	u8 uninitialized_var(intr);
+	u8 intr;
 	static volatile int locker=0;
 	int work=0;
 	struct z8530_irqhandler *irqs;
diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index a4f635820f35..a75a5b56dd9a 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -1657,7 +1657,7 @@ static int ath10k_init_uart(struct ath10k *ar)
 
 static int ath10k_init_hw_params(struct ath10k *ar)
 {
-	const struct ath10k_hw_params *uninitialized_var(hw_params);
+	const struct ath10k_hw_params *hw_params;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(ath10k_hw_params_list); i++) {
diff --git a/drivers/net/wireless/ath/ath6kl/init.c b/drivers/net/wireless/ath/ath6kl/init.c
index 58fb227a849f..49b93a5b7a72 100644
--- a/drivers/net/wireless/ath/ath6kl/init.c
+++ b/drivers/net/wireless/ath/ath6kl/init.c
@@ -1575,7 +1575,7 @@ static int ath6kl_init_upload(struct ath6kl *ar)
 
 int ath6kl_init_hw_params(struct ath6kl *ar)
 {
-	const struct ath6kl_hw *uninitialized_var(hw);
+	const struct ath6kl_hw *hw;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(hw_list); i++) {
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_hw.c b/drivers/net/wireless/ath/ath9k/ar9003_hw.c
index 2fe12b0de5b4..dea8a998fb62 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_hw.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_hw.c
@@ -1099,17 +1099,22 @@ static bool ath9k_hw_verify_hang(struct ath_hw *ah, unsigned int queue)
 {
 	u32 dma_dbg_chain, dma_dbg_complete;
 	u8 dcu_chain_state, dcu_complete_state;
+	unsigned int dbg_reg, reg_offset;
 	int i;
 
-	for (i = 0; i < NUM_STATUS_READS; i++) {
-		if (queue < 6)
-			dma_dbg_chain = REG_READ(ah, AR_DMADBG_4);
-		else
-			dma_dbg_chain = REG_READ(ah, AR_DMADBG_5);
+	if (queue < 6) {
+		dbg_reg = AR_DMADBG_4;
+		reg_offset = queue * 5;
+	} else {
+		dbg_reg = AR_DMADBG_5;
+		reg_offset = (queue - 6) * 5;
+	}
 
+	for (i = 0; i < NUM_STATUS_READS; i++) {
+		dma_dbg_chain = REG_READ(ah, dbg_reg);
 		dma_dbg_complete = REG_READ(ah, AR_DMADBG_6);
 
-		dcu_chain_state = (dma_dbg_chain >> (5 * queue)) & 0x1f;
+		dcu_chain_state = (dma_dbg_chain >> reg_offset) & 0x1f;
 		dcu_complete_state = dma_dbg_complete & 0x3;
 
 		if ((dcu_chain_state != 0x6) || (dcu_complete_state != 0x1))
@@ -1128,6 +1133,7 @@ static bool ar9003_hw_detect_mac_hang(struct ath_hw *ah)
 	u8 dcu_chain_state, dcu_complete_state;
 	bool dcu_wait_frdone = false;
 	unsigned long chk_dcu = 0;
+	unsigned int reg_offset;
 	unsigned int i = 0;
 
 	dma_dbg_4 = REG_READ(ah, AR_DMADBG_4);
@@ -1139,12 +1145,15 @@ static bool ar9003_hw_detect_mac_hang(struct ath_hw *ah)
 		goto exit;
 
 	for (i = 0; i < ATH9K_NUM_TX_QUEUES; i++) {
-		if (i < 6)
+		if (i < 6) {
 			chk_dbg = dma_dbg_4;
-		else
+			reg_offset = i * 5;
+		} else {
 			chk_dbg = dma_dbg_5;
+			reg_offset = (i - 6) * 5;
+		}
 
-		dcu_chain_state = (chk_dbg >> (5 * i)) & 0x1f;
+		dcu_chain_state = (chk_dbg >> reg_offset) & 0x1f;
 		if (dcu_chain_state == 0x6) {
 			dcu_wait_frdone = true;
 			chk_dcu |= BIT(i);
diff --git a/drivers/net/wireless/ath/ath9k/htc_hst.c b/drivers/net/wireless/ath/ath9k/htc_hst.c
index 6331c98088e0..d5e5f9cf4ca8 100644
--- a/drivers/net/wireless/ath/ath9k/htc_hst.c
+++ b/drivers/net/wireless/ath/ath9k/htc_hst.c
@@ -114,7 +114,13 @@ static void htc_process_conn_rsp(struct htc_target *target,
 
 	if (svc_rspmsg->status == HTC_SERVICE_SUCCESS) {
 		epid = svc_rspmsg->endpoint_id;
-		if (epid < 0 || epid >= ENDPOINT_MAX)
+
+		/* Check that the received epid for the endpoint to attach
+		 * a new service is valid. ENDPOINT0 can't be used here as it
+		 * is already reserved for HTC_CTRL_RSVD_SVC service and thus
+		 * should not be modified.
+		 */
+		if (epid <= ENDPOINT0 || epid >= ENDPOINT_MAX)
 			return;
 
 		service_id = be16_to_cpu(svc_rspmsg->service_id);
diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
index b8e520fc2870..ffafd1bcc1e8 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -175,7 +175,7 @@ static unsigned int ath9k_reg_rmw(void *hw_priv, u32 reg_offset, u32 set, u32 cl
 	struct ath_hw *ah = (struct ath_hw *) hw_priv;
 	struct ath_common *common = ath9k_hw_common(ah);
 	struct ath_softc *sc = (struct ath_softc *) common->priv;
-	unsigned long uninitialized_var(flags);
+	unsigned long flags;
 	u32 val;
 
 	if (NR_CPUS > 1 && ah->config.serialize_regmode == SER_REG_MODE_ON) {
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index 507d8c514968..f659bf793727 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -199,7 +199,7 @@ void ath_cancel_work(struct ath_softc *sc)
 void ath_restart_work(struct ath_softc *sc)
 {
 	ieee80211_queue_delayed_work(sc->hw, &sc->hw_check_work,
-				     ATH_HW_CHECK_POLL_INT);
+				     msecs_to_jiffies(ATH_HW_CHECK_POLL_INT));
 
 	if (AR_SREV_9340(sc->sc_ah) || AR_SREV_9330(sc->sc_ah))
 		ieee80211_queue_delayed_work(sc->hw, &sc->hw_pll_work,
@@ -846,7 +846,7 @@ static bool ath9k_txq_list_has_key(struct list_head *txq_list, u32 keyix)
 static bool ath9k_txq_has_key(struct ath_softc *sc, u32 keyix)
 {
 	struct ath_hw *ah = sc->sc_ah;
-	int i;
+	int i, j;
 	struct ath_txq *txq;
 	bool key_in_use = false;
 
@@ -864,8 +864,9 @@ static bool ath9k_txq_has_key(struct ath_softc *sc, u32 keyix)
 		if (sc->sc_ah->caps.hw_caps & ATH9K_HW_CAP_EDMA) {
 			int idx = txq->txq_tailidx;
 
-			while (!key_in_use &&
-			       !list_empty(&txq->txq_fifo[idx])) {
+			for (j = 0; !key_in_use &&
+			     !list_empty(&txq->txq_fifo[idx]) &&
+			     j < ATH_TXFIFO_DEPTH; j++) {
 				key_in_use = ath9k_txq_list_has_key(
 					&txq->txq_fifo[idx], keyix);
 				INCR(idx, ATH_TXFIFO_DEPTH);
@@ -2224,7 +2225,7 @@ void __ath9k_flush(struct ieee80211_hw *hw, u32 queues, bool drop,
 	}
 
 	ieee80211_queue_delayed_work(hw, &sc->hw_check_work,
-				     ATH_HW_CHECK_POLL_INT);
+				     msecs_to_jiffies(ATH_HW_CHECK_POLL_INT));
 }
 
 static bool ath9k_tx_frames_pending(struct ieee80211_hw *hw)
diff --git a/drivers/net/wireless/ath/ath9k/wmi.c b/drivers/net/wireless/ath/ath9k/wmi.c
index 9a17f7a07b1e..7b4e92218119 100644
--- a/drivers/net/wireless/ath/ath9k/wmi.c
+++ b/drivers/net/wireless/ath/ath9k/wmi.c
@@ -217,6 +217,10 @@ static void ath9k_wmi_ctrl_rx(void *priv, struct sk_buff *skb,
 	if (unlikely(wmi->stopped))
 		goto free_skb;
 
+	/* Validate the obtained SKB. */
+	if (unlikely(skb->len < sizeof(struct wmi_cmd_hdr)))
+		goto free_skb;
+
 	hdr = (struct wmi_cmd_hdr *) skb->data;
 	cmd_id = be16_to_cpu(hdr->command_id);
 
diff --git a/drivers/net/wireless/atmel/atmel_cs.c b/drivers/net/wireless/atmel/atmel_cs.c
index 7afc9c5329fb..f5fa1a95b0c1 100644
--- a/drivers/net/wireless/atmel/atmel_cs.c
+++ b/drivers/net/wireless/atmel/atmel_cs.c
@@ -73,6 +73,7 @@ struct local_info {
 static int atmel_probe(struct pcmcia_device *p_dev)
 {
 	struct local_info *local;
+	int ret;
 
 	dev_dbg(&p_dev->dev, "atmel_attach()\n");
 
@@ -83,8 +84,16 @@ static int atmel_probe(struct pcmcia_device *p_dev)
 
 	p_dev->priv = local;
 
-	return atmel_config(p_dev);
-} /* atmel_attach */
+	ret = atmel_config(p_dev);
+	if (ret)
+		goto err_free_priv;
+
+	return 0;
+
+err_free_priv:
+	kfree(p_dev->priv);
+	return ret;
+}
 
 static void atmel_detach(struct pcmcia_device *link)
 {
diff --git a/drivers/net/wireless/broadcom/b43/debugfs.c b/drivers/net/wireless/broadcom/b43/debugfs.c
index 77046384dd80..70b02d664170 100644
--- a/drivers/net/wireless/broadcom/b43/debugfs.c
+++ b/drivers/net/wireless/broadcom/b43/debugfs.c
@@ -506,7 +506,7 @@ static ssize_t b43_debugfs_read(struct file *file, char __user *userbuf,
 	struct b43_wldev *dev;
 	struct b43_debugfs_fops *dfops;
 	struct b43_dfs_file *dfile;
-	ssize_t uninitialized_var(ret);
+	ssize_t ret;
 	char *buf;
 	const size_t bufsize = 1024 * 16; /* 16 kiB buffer */
 	const size_t buforder = get_order(bufsize);
diff --git a/drivers/net/wireless/broadcom/b43/dma.c b/drivers/net/wireless/broadcom/b43/dma.c
index 6837064908be..e0cf2a974121 100644
--- a/drivers/net/wireless/broadcom/b43/dma.c
+++ b/drivers/net/wireless/broadcom/b43/dma.c
@@ -50,7 +50,7 @@
 static u32 b43_dma_address(struct b43_dma *dma, dma_addr_t dmaaddr,
 			   enum b43_addrtype addrtype)
 {
-	u32 uninitialized_var(addr);
+	u32 addr;
 
 	switch (addrtype) {
 	case B43_DMA_ADDR_LOW:
diff --git a/drivers/net/wireless/broadcom/b43/lo.c b/drivers/net/wireless/broadcom/b43/lo.c
index a335f94c72ff..10cc0c0d70c3 100644
--- a/drivers/net/wireless/broadcom/b43/lo.c
+++ b/drivers/net/wireless/broadcom/b43/lo.c
@@ -742,7 +742,7 @@ struct b43_lo_calib *b43_calibrate_lo_setting(struct b43_wldev *dev,
 	};
 	int max_rx_gain;
 	struct b43_lo_calib *cal;
-	struct lo_g_saved_values uninitialized_var(saved_regs);
+	struct lo_g_saved_values saved_regs;
 	/* Values from the "TXCTL Register and Value Table" */
 	u16 txctl_reg;
 	u16 txctl_value;
diff --git a/drivers/net/wireless/broadcom/b43/phy_n.c b/drivers/net/wireless/broadcom/b43/phy_n.c
index 9cbc17c2751c..6f0bf33e923d 100644
--- a/drivers/net/wireless/broadcom/b43/phy_n.c
+++ b/drivers/net/wireless/broadcom/b43/phy_n.c
@@ -5655,7 +5655,7 @@ static int b43_nphy_rev2_cal_rx_iq(struct b43_wldev *dev,
 	u8 rfctl[2];
 	u8 afectl_core;
 	u16 tmp[6];
-	u16 uninitialized_var(cur_hpf1), uninitialized_var(cur_hpf2), cur_lna;
+	u16 cur_hpf1, cur_hpf2, cur_lna;
 	u32 real, imag;
 	enum nl80211_band band;
 
diff --git a/drivers/net/wireless/broadcom/b43/xmit.c b/drivers/net/wireless/broadcom/b43/xmit.c
index 1b9c191e2a22..c123e2204663 100644
--- a/drivers/net/wireless/broadcom/b43/xmit.c
+++ b/drivers/net/wireless/broadcom/b43/xmit.c
@@ -435,10 +435,10 @@ int b43_generate_txhdr(struct b43_wldev *dev,
 	if ((rates[0].flags & IEEE80211_TX_RC_USE_RTS_CTS) ||
 	    (rates[0].flags & IEEE80211_TX_RC_USE_CTS_PROTECT)) {
 		unsigned int len;
-		struct ieee80211_hdr *uninitialized_var(hdr);
+		struct ieee80211_hdr *hdr;
 		int rts_rate, rts_rate_fb;
 		int rts_rate_ofdm, rts_rate_fb_ofdm;
-		struct b43_plcp_hdr6 *uninitialized_var(plcp);
+		struct b43_plcp_hdr6 *plcp;
 		struct ieee80211_rate *rts_cts_rate;
 
 		rts_cts_rate = ieee80211_get_rts_cts_rate(dev->wl->hw, info);
@@ -449,7 +449,7 @@ int b43_generate_txhdr(struct b43_wldev *dev,
 		rts_rate_fb_ofdm = b43_is_ofdm_rate(rts_rate_fb);
 
 		if (rates[0].flags & IEEE80211_TX_RC_USE_CTS_PROTECT) {
-			struct ieee80211_cts *uninitialized_var(cts);
+			struct ieee80211_cts *cts;
 
 			switch (dev->fw.hdr_format) {
 			case B43_FW_HDR_598:
@@ -471,7 +471,7 @@ int b43_generate_txhdr(struct b43_wldev *dev,
 			mac_ctl |= B43_TXH_MAC_SENDCTS;
 			len = sizeof(struct ieee80211_cts);
 		} else {
-			struct ieee80211_rts *uninitialized_var(rts);
+			struct ieee80211_rts *rts;
 
 			switch (dev->fw.hdr_format) {
 			case B43_FW_HDR_598:
@@ -663,8 +663,8 @@ void b43_rx(struct b43_wldev *dev, struct sk_buff *skb, const void *_rxhdr)
 	const struct b43_rxhdr_fw4 *rxhdr = _rxhdr;
 	__le16 fctl;
 	u16 phystat0, phystat3;
-	u16 uninitialized_var(chanstat), uninitialized_var(mactime);
-	u32 uninitialized_var(macstat);
+	u16 chanstat, mactime;
+	u32 macstat;
 	u16 chanid;
 	int padding, rate_idx;
 
diff --git a/drivers/net/wireless/broadcom/b43legacy/debugfs.c b/drivers/net/wireless/broadcom/b43legacy/debugfs.c
index 82ef56ed7ca1..d3c9a916b44c 100644
--- a/drivers/net/wireless/broadcom/b43legacy/debugfs.c
+++ b/drivers/net/wireless/broadcom/b43legacy/debugfs.c
@@ -203,7 +203,7 @@ static ssize_t b43legacy_debugfs_read(struct file *file, char __user *userbuf,
 	struct b43legacy_wldev *dev;
 	struct b43legacy_debugfs_fops *dfops;
 	struct b43legacy_dfs_file *dfile;
-	ssize_t uninitialized_var(ret);
+	ssize_t ret;
 	char *buf;
 	const size_t bufsize = 1024 * 16; /* 16 KiB buffer */
 	const size_t buforder = get_order(bufsize);
diff --git a/drivers/net/wireless/broadcom/b43legacy/main.c b/drivers/net/wireless/broadcom/b43legacy/main.c
index 6f123a52ae2d..2790ea8a3848 100644
--- a/drivers/net/wireless/broadcom/b43legacy/main.c
+++ b/drivers/net/wireless/broadcom/b43legacy/main.c
@@ -2612,7 +2612,7 @@ static void b43legacy_put_phy_into_reset(struct b43legacy_wldev *dev)
 static int b43legacy_switch_phymode(struct b43legacy_wl *wl,
 				      unsigned int new_mode)
 {
-	struct b43legacy_wldev *uninitialized_var(up_dev);
+	struct b43legacy_wldev *up_dev;
 	struct b43legacy_wldev *down_dev;
 	int err;
 	bool gmode = false;
diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
index d06dc446a393..ca4a3330337d 100644
--- a/drivers/net/wireless/cisco/airo.c
+++ b/drivers/net/wireless/cisco/airo.c
@@ -6102,8 +6102,11 @@ static int airo_get_rate(struct net_device *dev,
 {
 	struct airo_info *local = dev->ml_priv;
 	StatusRid status_rid;		/* Card status info */
+	int ret;
 
-	readStatusRid(local, &status_rid, 1);
+	ret = readStatusRid(local, &status_rid, 1);
+	if (ret)
+		return -EBUSY;
 
 	vwrq->value = le16_to_cpu(status_rid.currentXmitRate) * 500000;
 	/* If more than one rate, set auto */
diff --git a/drivers/net/wireless/intel/iwlegacy/3945.c b/drivers/net/wireless/intel/iwlegacy/3945.c
index dbf164d48ed3..7042912410be 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945.c
@@ -2117,7 +2117,7 @@ il3945_txpower_set_from_eeprom(struct il_priv *il)
 
 		/* set tx power value for all OFDM rates */
 		for (rate_idx = 0; rate_idx < IL_OFDM_RATES; rate_idx++) {
-			s32 uninitialized_var(power_idx);
+			s32 power_idx;
 			int rc;
 
 			/* use channel group's clip-power table,
diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index 665e82effb03..86d5a0653bb9 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -2787,7 +2787,7 @@ il4965_hdl_tx(struct il_priv *il, struct il_rx_buf *rxb)
 	struct ieee80211_tx_info *info;
 	struct il4965_tx_resp *tx_resp = (void *)&pkt->u.raw[0];
 	u32 status = le32_to_cpu(tx_resp->u.status);
-	int uninitialized_var(tid);
+	int tid;
 	int sta_id;
 	int freed;
 	u8 *qc = NULL;
diff --git a/drivers/net/wireless/intersil/orinoco/orinoco_cs.c b/drivers/net/wireless/intersil/orinoco/orinoco_cs.c
index a956f965a1e5..03bfd2482656 100644
--- a/drivers/net/wireless/intersil/orinoco/orinoco_cs.c
+++ b/drivers/net/wireless/intersil/orinoco/orinoco_cs.c
@@ -96,6 +96,7 @@ orinoco_cs_probe(struct pcmcia_device *link)
 {
 	struct orinoco_private *priv;
 	struct orinoco_pccard *card;
+	int ret;
 
 	priv = alloc_orinocodev(sizeof(*card), &link->dev,
 				orinoco_cs_hard_reset, NULL);
@@ -107,8 +108,16 @@ orinoco_cs_probe(struct pcmcia_device *link)
 	card->p_dev = link;
 	link->priv = priv;
 
-	return orinoco_cs_config(link);
-}				/* orinoco_cs_attach */
+	ret = orinoco_cs_config(link);
+	if (ret)
+		goto err_free_orinocodev;
+
+	return 0;
+
+err_free_orinocodev:
+	free_orinocodev(priv);
+	return ret;
+}
 
 static void orinoco_cs_detach(struct pcmcia_device *link)
 {
diff --git a/drivers/net/wireless/intersil/orinoco/spectrum_cs.c b/drivers/net/wireless/intersil/orinoco/spectrum_cs.c
index b60048c95e0a..011c86e55923 100644
--- a/drivers/net/wireless/intersil/orinoco/spectrum_cs.c
+++ b/drivers/net/wireless/intersil/orinoco/spectrum_cs.c
@@ -157,6 +157,7 @@ spectrum_cs_probe(struct pcmcia_device *link)
 {
 	struct orinoco_private *priv;
 	struct orinoco_pccard *card;
+	int ret;
 
 	priv = alloc_orinocodev(sizeof(*card), &link->dev,
 				spectrum_cs_hard_reset,
@@ -169,8 +170,16 @@ spectrum_cs_probe(struct pcmcia_device *link)
 	card->p_dev = link;
 	link->priv = priv;
 
-	return spectrum_cs_config(link);
-}				/* spectrum_cs_attach */
+	ret = spectrum_cs_config(link);
+	if (ret)
+		goto err_free_orinocodev;
+
+	return 0;
+
+err_free_orinocodev:
+	free_orinocodev(priv);
+	return ret;
+}
 
 static void spectrum_cs_detach(struct pcmcia_device *link)
 {
diff --git a/drivers/net/wireless/ray_cs.c b/drivers/net/wireless/ray_cs.c
index 1ee150563260..16d2385bd426 100644
--- a/drivers/net/wireless/ray_cs.c
+++ b/drivers/net/wireless/ray_cs.c
@@ -283,13 +283,14 @@ static int ray_probe(struct pcmcia_device *p_dev)
 {
 	ray_dev_t *local;
 	struct net_device *dev;
+	int ret;
 
 	dev_dbg(&p_dev->dev, "ray_attach()\n");
 
 	/* Allocate space for private device-specific data */
 	dev = alloc_etherdev(sizeof(ray_dev_t));
 	if (!dev)
-		goto fail_alloc_dev;
+		return -ENOMEM;
 
 	local = netdev_priv(dev);
 	local->finder = p_dev;
@@ -326,11 +327,16 @@ static int ray_probe(struct pcmcia_device *p_dev)
 	init_timer(&local->timer);
 
 	this_device = p_dev;
-	return ray_config(p_dev);
+	ret = ray_config(p_dev);
+	if (ret)
+		goto err_free_dev;
+
+	return 0;
 
-fail_alloc_dev:
-	return -ENOMEM;
-} /* ray_attach */
+err_free_dev:
+	free_netdev(dev);
+	return ret;
+}
 
 static void ray_detach(struct pcmcia_device *link)
 {
diff --git a/drivers/net/wireless/wl3501_cs.c b/drivers/net/wireless/wl3501_cs.c
index cfde9b94b4b6..2eacd099a812 100644
--- a/drivers/net/wireless/wl3501_cs.c
+++ b/drivers/net/wireless/wl3501_cs.c
@@ -1865,6 +1865,7 @@ static int wl3501_probe(struct pcmcia_device *p_dev)
 {
 	struct net_device *dev;
 	struct wl3501_card *this;
+	int ret;
 
 	/* The io structure describes IO port mapping */
 	p_dev->resource[0]->end	= 16;
@@ -1876,8 +1877,7 @@ static int wl3501_probe(struct pcmcia_device *p_dev)
 
 	dev = alloc_etherdev(sizeof(struct wl3501_card));
 	if (!dev)
-		goto out_link;
-
+		return -ENOMEM;
 
 	dev->netdev_ops		= &wl3501_netdev_ops;
 	dev->watchdog_timeo	= 5 * HZ;
@@ -1890,9 +1890,15 @@ static int wl3501_probe(struct pcmcia_device *p_dev)
 	netif_stop_queue(dev);
 	p_dev->priv = dev;
 
-	return wl3501_config(p_dev);
-out_link:
-	return -ENOMEM;
+	ret = wl3501_config(p_dev);
+	if (ret)
+		goto out_free_etherdev;
+
+	return 0;
+
+out_free_etherdev:
+	free_netdev(dev);
+	return ret;
 }
 
 static int wl3501_config(struct pcmcia_device *link)
diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 72a7981ef73f..05693edaba11 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -1135,12 +1135,17 @@ static struct pci_driver amd_ntb_pci_driver = {
 
 static int __init amd_ntb_pci_driver_init(void)
 {
+	int ret;
 	pr_info("%s %s\n", NTB_DESC, NTB_VER);
 
 	if (debugfs_initialized())
 		debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
 
-	return pci_register_driver(&amd_ntb_pci_driver);
+	ret = pci_register_driver(&amd_ntb_pci_driver);
+	if (ret)
+		debugfs_remove_recursive(debugfs_dir);
+
+	return ret;
 }
 module_init(amd_ntb_pci_driver_init);
 
diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index b68e2cad74cc..d6f68a17bbd9 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -2689,6 +2689,7 @@ static struct pci_driver idt_pci_driver = {
 
 static int __init idt_pci_driver_init(void)
 {
+	int ret;
 	pr_info("%s %s\n", NTB_DESC, NTB_VER);
 
 	/* Create the top DebugFS directory if the FS is initialized */
@@ -2696,7 +2697,11 @@ static int __init idt_pci_driver_init(void)
 		dbgfs_topdir = debugfs_create_dir(KBUILD_MODNAME, NULL);
 
 	/* Register the NTB hardware driver to handle the PCI device */
-	return pci_register_driver(&idt_pci_driver);
+	ret = pci_register_driver(&idt_pci_driver);
+	if (ret)
+		debugfs_remove_recursive(dbgfs_topdir);
+
+	return ret;
 }
 module_init(idt_pci_driver_init);
 
diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index 58068f1447bb..6b1484b4351d 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -3041,12 +3041,17 @@ static struct pci_driver intel_ntb_pci_driver = {
 
 static int __init intel_ntb_pci_driver_init(void)
 {
+	int ret;
 	pr_info("%s %s\n", NTB_DESC, NTB_VER);
 
 	if (debugfs_initialized())
 		debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
 
-	return pci_register_driver(&intel_ntb_pci_driver);
+	ret = pci_register_driver(&intel_ntb_pci_driver);
+	if (ret)
+		debugfs_remove_recursive(debugfs_dir);
+
+	return ret;
 }
 module_init(intel_ntb_pci_driver_init);
 
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 18339b7e88a4..a58ced5d6043 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -395,7 +395,7 @@ int ntb_transport_register_client_dev(char *device_name)
 
 		rc = device_register(dev);
 		if (rc) {
-			kfree(client_dev);
+			put_device(dev);
 			goto err;
 		}
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b9fedf9c77cb..7ca82b8c5c37 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4035,6 +4035,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9220,
 /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c49 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9230,
 			 quirk_dma_func1_alias);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9235,
+			 quirk_dma_func1_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0642,
 			 quirk_dma_func1_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0645,
diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index d39718b4242d..fa4a9ccef1f4 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1040,11 +1040,6 @@ static int chv_config_get(struct pinctrl_dev *pctldev, unsigned pin,
 
 		break;
 
-	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
-		if (!(ctrl1 & CHV_PADCTRL1_ODEN))
-			return -EINVAL;
-		break;
-
 	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE: {
 		u32 cfg;
 
@@ -1054,6 +1049,16 @@ static int chv_config_get(struct pinctrl_dev *pctldev, unsigned pin,
 			return -EINVAL;
 
 		break;
+
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		if (ctrl1 & CHV_PADCTRL1_ODEN)
+			return -EINVAL;
+		break;
+
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		if (!(ctrl1 & CHV_PADCTRL1_ODEN))
+			return -EINVAL;
+		break;
 	}
 
 	default:
diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index c57f91f48423..fbec8a07e942 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -169,18 +169,6 @@ static int amd_gpio_set_debounce(struct gpio_chip *gc, unsigned offset,
 	return ret;
 }
 
-static int amd_gpio_set_config(struct gpio_chip *gc, unsigned offset,
-			       unsigned long config)
-{
-	u32 debounce;
-
-	if (pinconf_to_config_param(config) != PIN_CONFIG_INPUT_DEBOUNCE)
-		return -ENOTSUPP;
-
-	debounce = pinconf_to_config_argument(config);
-	return amd_gpio_set_debounce(gc, offset, debounce);
-}
-
 #ifdef CONFIG_DEBUG_FS
 static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 {
@@ -632,7 +620,7 @@ static int amd_pinconf_get(struct pinctrl_dev *pctldev,
 }
 
 static int amd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
-				unsigned long *configs, unsigned num_configs)
+			   unsigned long *configs, unsigned int num_configs)
 {
 	int i;
 	u32 arg;
@@ -722,6 +710,20 @@ static int amd_pinconf_group_set(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
+static int amd_gpio_set_config(struct gpio_chip *gc, unsigned int pin,
+			       unsigned long config)
+{
+	struct amd_gpio *gpio_dev = gpiochip_get_data(gc);
+
+	if (pinconf_to_config_param(config) == PIN_CONFIG_INPUT_DEBOUNCE) {
+		u32 debounce = pinconf_to_config_argument(config);
+
+		return amd_gpio_set_debounce(gc, pin, debounce);
+	}
+
+	return amd_pinconf_set(gpio_dev->pctrl, pin, &config, 1);
+}
+
 static const struct pinconf_ops amd_pinconf_ops = {
 	.pin_config_get		= amd_pinconf_get,
 	.pin_config_set		= amd_pinconf_set,
diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index 32e863a352a3..8f18a35b66b6 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -983,6 +983,8 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
 		/* Pin naming convention: P(bank_name)(bank_pin_number). */
 		pin_desc[i].name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "P%c%d",
 						  bank + 'A', line);
+		if (!pin_desc[i].name)
+			return -ENOMEM;
 
 		group->name = group_names[i] = pin_desc[i].name;
 		group->pin = pin_desc[i].number;
diff --git a/drivers/platform/x86/hdaps.c b/drivers/platform/x86/hdaps.c
index c26baf77938e..96cc87d12329 100644
--- a/drivers/platform/x86/hdaps.c
+++ b/drivers/platform/x86/hdaps.c
@@ -378,7 +378,7 @@ static ssize_t hdaps_variance_show(struct device *dev,
 static ssize_t hdaps_temp1_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	u8 uninitialized_var(temp);
+	u8 temp;
 	int ret;
 
 	ret = hdaps_readb_one(HDAPS_PORT_TEMP1, &temp);
@@ -391,7 +391,7 @@ static ssize_t hdaps_temp1_show(struct device *dev,
 static ssize_t hdaps_temp2_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	u8 uninitialized_var(temp);
+	u8 temp;
 	int ret;
 
 	ret = hdaps_readb_one(HDAPS_PORT_TEMP2, &temp);
diff --git a/drivers/platform/x86/msi-laptop.c b/drivers/platform/x86/msi-laptop.c
index 42b31c549db0..1781e67781a5 100644
--- a/drivers/platform/x86/msi-laptop.c
+++ b/drivers/platform/x86/msi-laptop.c
@@ -223,7 +223,7 @@ static ssize_t set_device_state(const char *buf, size_t count, u8 mask)
 		return -EINVAL;
 
 	if (quirks->ec_read_only)
-		return -EOPNOTSUPP;
+		return 0;
 
 	/* read current device state */
 	result = ec_read(MSI_STANDARD_EC_COMMAND_ADDRESS, &rdata);
@@ -854,15 +854,15 @@ static bool msi_laptop_i8042_filter(unsigned char data, unsigned char str,
 static void msi_init_rfkill(struct work_struct *ignored)
 {
 	if (rfk_wlan) {
-		rfkill_set_sw_state(rfk_wlan, !wlan_s);
+		msi_rfkill_set_state(rfk_wlan, !wlan_s);
 		rfkill_wlan_set(NULL, !wlan_s);
 	}
 	if (rfk_bluetooth) {
-		rfkill_set_sw_state(rfk_bluetooth, !bluetooth_s);
+		msi_rfkill_set_state(rfk_bluetooth, !bluetooth_s);
 		rfkill_bluetooth_set(NULL, !bluetooth_s);
 	}
 	if (rfk_threeg) {
-		rfkill_set_sw_state(rfk_threeg, !threeg_s);
+		msi_rfkill_set_state(rfk_threeg, !threeg_s);
 		rfkill_threeg_set(NULL, !threeg_s);
 	}
 }
diff --git a/drivers/rtc/rtc-st-lpc.c b/drivers/rtc/rtc-st-lpc.c
index 6f33e705928f..9044c2851a1f 100644
--- a/drivers/rtc/rtc-st-lpc.c
+++ b/drivers/rtc/rtc-st-lpc.c
@@ -236,7 +236,7 @@ static int st_rtc_probe(struct platform_device *pdev)
 	enable_irq_wake(rtc->irq);
 	disable_irq(rtc->irq);
 
-	rtc->clk = clk_get(&pdev->dev, NULL);
+	rtc->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(rtc->clk)) {
 		dev_err(&pdev->dev, "Unable to request clock\n");
 		return PTR_ERR(rtc->clk);
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 7bdc6aaa0ba3..2700e517083b 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -138,6 +138,7 @@ static int dasd_ioctl_resume(struct dasd_block *block)
 	spin_unlock_irqrestore(get_ccwdev_lock(base->cdev), flags);
 
 	dasd_schedule_block_bh(block);
+	dasd_schedule_device_bh(base);
 	return 0;
 }
 
diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
index 961ea6f7def8..7f21d724461e 100644
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -2303,8 +2303,10 @@ static int tw_probe(struct pci_dev *pdev, const struct pci_device_id *dev_id)
 	TW_DISABLE_INTERRUPTS(tw_dev);
 
 	/* Initialize the card */
-	if (tw_reset_sequence(tw_dev))
+	if (tw_reset_sequence(tw_dev)) {
+		retval = -EINVAL;
 		goto out_release_mem_region;
+	}
 
 	/* Set host specific parameters */
 	host->max_id = TW_MAX_UNITS;
diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index f7304ff0e08e..3487ef2c1b23 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -4279,7 +4279,7 @@ static int adapter_sg_tables_alloc(struct AdapterCtlBlk *acb)
 	const unsigned srbs_per_page = PAGE_SIZE/SEGMENTX_LEN;
 	int srb_idx = 0;
 	unsigned i = 0;
-	struct SGentry *uninitialized_var(ptr);
+	struct SGentry *ptr;
 
 	for (i = 0; i < DC395x_MAX_SRB_CNT; i++)
 		acb->srb_array[i].segment_x = NULL;
diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index cc90b5c8d462..6df54c7dc07b 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -4165,7 +4165,7 @@ static int process_oq(struct pm8001_hba_info *pm8001_ha, u8 vec)
 {
 	struct outbound_queue_table *circularQ;
 	void *pMsg1 = NULL;
-	u8 uninitialized_var(bc);
+	u8 bc;
 	u32 ret = MPI_IO_STATUS_FAIL;
 	unsigned long flags;
 
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 4eae727ccfbc..89a343718779 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -3776,7 +3776,7 @@ static int process_oq(struct pm8001_hba_info *pm8001_ha, u8 vec)
 {
 	struct outbound_queue_table *circularQ;
 	void *pMsg1 = NULL;
-	u8 uninitialized_var(bc);
+	u8 bc;
 	u32 ret = MPI_IO_STATUS_FAIL;
 	unsigned long flags;
 	u32 regval;
diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index dbfd703d0f46..895702161d9a 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -1779,6 +1779,7 @@ static void
 qla2x00_terminate_rport_io(struct fc_rport *rport)
 {
 	fc_port_t *fcport = *(fc_port_t **)rport->dd_data;
+	scsi_qla_host_t *vha;
 
 	if (!fcport)
 		return;
@@ -1788,9 +1789,12 @@ qla2x00_terminate_rport_io(struct fc_rport *rport)
 
 	if (test_bit(ABORT_ISP_ACTIVE, &fcport->vha->dpc_flags))
 		return;
+	vha = fcport->vha;
 
 	if (unlikely(pci_channel_offline(fcport->vha->hw->pdev))) {
 		qla2x00_abort_all_cmds(fcport->vha, DID_NO_CONNECT << 16);
+		qla2x00_eh_wait_for_pending_commands(fcport->vha, fcport->d_id.b24,
+			0, WAIT_TARGET);
 		return;
 	}
 	/*
@@ -1805,6 +1809,15 @@ qla2x00_terminate_rport_io(struct fc_rport *rport)
 		else
 			qla2x00_port_logout(fcport->vha, fcport);
 	}
+
+	/* check for any straggling io left behind */
+	if (qla2x00_eh_wait_for_pending_commands(fcport->vha, fcport->d_id.b24, 0, WAIT_TARGET)) {
+		ql_log(ql_log_warn, vha, 0x300b,
+		       "IO not return.  Resetting. \n");
+		set_bit(ISP_ABORT_NEEDED, &vha->dpc_flags);
+		qla2xxx_wake_dpc(vha);
+		qla2x00_wait_for_chip_reset(vha);
+	}
 }
 
 static int
diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
index b50478fa14ad..f051da3288c3 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -264,6 +264,10 @@ qla2x00_process_els(struct bsg_job *bsg_job)
 
 	if (bsg_request->msgcode == FC_BSG_RPT_ELS) {
 		rport = fc_bsg_to_rport(bsg_job);
+		if (!rport) {
+			rval = -ENOMEM;
+			goto done;
+		}
 		fcport = *(fc_port_t **) rport->dd_data;
 		host = rport_to_shost(rport);
 		vha = shost_priv(host);
@@ -2489,6 +2493,8 @@ qla24xx_bsg_request(struct bsg_job *bsg_job)
 
 	if (bsg_request->msgcode == FC_BSG_RPT_ELS) {
 		rport = fc_bsg_to_rport(bsg_job);
+		if (!rport)
+			return ret;
 		host = rport_to_shost(rport);
 		vha = shost_priv(host);
 	} else {
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 85cb4e30f742..99345099b961 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -598,7 +598,8 @@ qla24xx_build_scsi_type_6_iocbs(srb_t *sp, struct cmd_type_6 *cmd_pkt,
 	*((uint32_t *)(&cmd_pkt->entry_type)) = cpu_to_le32(COMMAND_TYPE_6);
 
 	/* No data transfer */
-	if (!scsi_bufflen(cmd) || cmd->sc_data_direction == DMA_NONE) {
+	if (!scsi_bufflen(cmd) || cmd->sc_data_direction == DMA_NONE ||
+	    tot_dsds == 0) {
 		cmd_pkt->byte_count = cpu_to_le32(0);
 		return 0;
 	}
diff --git a/drivers/soc/fsl/qe/Kconfig b/drivers/soc/fsl/qe/Kconfig
index 73a2e08b47ef..e2ccddd348b5 100644
--- a/drivers/soc/fsl/qe/Kconfig
+++ b/drivers/soc/fsl/qe/Kconfig
@@ -37,6 +37,7 @@ config QE_TDM
 
 config QE_USB
 	bool
+	depends on QUICC_ENGINE
 	default y if USB_FSL_QE
 	help
 	  QE USB Controller support
diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 0321ac531df7..cebc06759eee 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1251,13 +1251,9 @@ int bcm_qspi_probe(struct platform_device *pdev,
 		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 						   "mspi");
 
-	if (res) {
-		qspi->base[MSPI]  = devm_ioremap_resource(dev, res);
-		if (IS_ERR(qspi->base[MSPI]))
-			return PTR_ERR(qspi->base[MSPI]);
-	} else {
-		return 0;
-	}
+	qspi->base[MSPI]  = devm_ioremap_resource(dev, res);
+	if (IS_ERR(qspi->base[MSPI]))
+		return PTR_ERR(qspi->base[MSPI]);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "bspi");
 	if (res) {
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index bfe5754768f9..cc6ec3fb5bfd 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -134,7 +134,7 @@ enum bcm63xx_regs_spi {
 	SPI_MSG_DATA_SIZE,
 };
 
-#define BCM63XX_SPI_MAX_PREPEND		15
+#define BCM63XX_SPI_MAX_PREPEND		7
 
 #define BCM63XX_SPI_MAX_CS		8
 #define BCM63XX_SPI_BUS_NUM		0
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 5e49fed487f8..fd15b030b381 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -339,7 +339,7 @@ static int fsl_spi_do_one_msg(struct spi_master *master,
 	struct spi_transfer *t, *first;
 	unsigned int cs_change;
 	const int nsecs = 50;
-	int status;
+	int status, last_bpw;
 
 	/*
 	 * In CPU mode, optimize large byte transfers to use larger
@@ -373,26 +373,27 @@ static int fsl_spi_do_one_msg(struct spi_master *master,
 	}
 
 	/* Don't allow changes if CS is active */
-	first = list_first_entry(&m->transfers, struct spi_transfer,
-			transfer_list);
+	cs_change = 1;
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if ((first->bits_per_word != t->bits_per_word) ||
-			(first->speed_hz != t->speed_hz)) {
+		if (cs_change)
+			first = t;
+		cs_change = t->cs_change;
+		if (first->speed_hz != t->speed_hz) {
 			dev_err(&spi->dev,
-				"bits_per_word/speed_hz should be same for the same SPI transfer\n");
+				"speed_hz cannot change while CS is active\n");
 			return -EINVAL;
 		}
 	}
 
+	last_bpw = -1;
 	cs_change = 1;
 	status = -EINVAL;
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if (t->bits_per_word || t->speed_hz) {
-			if (cs_change)
-				status = fsl_spi_setup_transfer(spi, t);
-			if (status < 0)
-				break;
-		}
+		if (cs_change || last_bpw != t->bits_per_word)
+			status = fsl_spi_setup_transfer(spi, t);
+		if (status < 0)
+			break;
+		last_bpw = t->bits_per_word;
 
 		if (cs_change) {
 			fsl_spi_chipselect(spi, BITBANG_CS_ACTIVE);
diff --git a/drivers/ssb/driver_chipcommon.c b/drivers/ssb/driver_chipcommon.c
index 7cb7d2c8fd86..c766df837ab9 100644
--- a/drivers/ssb/driver_chipcommon.c
+++ b/drivers/ssb/driver_chipcommon.c
@@ -119,7 +119,7 @@ void ssb_chipco_set_clockmode(struct ssb_chipcommon *cc,
 static enum ssb_clksrc chipco_pctl_get_slowclksrc(struct ssb_chipcommon *cc)
 {
 	struct ssb_bus *bus = cc->dev->bus;
-	u32 uninitialized_var(tmp);
+	u32 tmp;
 
 	if (cc->dev->id.revision < 6) {
 		if (bus->bustype == SSB_BUSTYPE_SSB ||
@@ -149,7 +149,7 @@ static enum ssb_clksrc chipco_pctl_get_slowclksrc(struct ssb_chipcommon *cc)
 /* Get maximum or minimum (depending on get_max flag) slowclock frequency. */
 static int chipco_pctl_clockfreqlimit(struct ssb_chipcommon *cc, int get_max)
 {
-	int uninitialized_var(limit);
+	int limit;
 	enum ssb_clksrc clocksrc;
 	int divisor = 1;
 	u32 tmp;
diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index 9b71dc64f9b4..c5c37d4e0c6f 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -1787,8 +1787,10 @@ static int ks_wlan_set_encode_ext(struct net_device *dev,
 			commit |= SME_WEP_FLAG;
 		}
 		if (enc->key_len) {
-			memcpy(&key->key_val[0], &enc->key[0], enc->key_len);
-			key->key_len = enc->key_len;
+			int key_len = clamp_val(enc->key_len, 0, IW_ENCODING_TOKEN_MAX);
+
+			memcpy(&key->key_val[0], &enc->key[0], key_len);
+			key->key_len = key_len;
 			commit |= (SME_WEP_VAL1 << index);
 		}
 		break;
diff --git a/drivers/tty/cyclades.c b/drivers/tty/cyclades.c
index d84214bd7176..3efb12337583 100644
--- a/drivers/tty/cyclades.c
+++ b/drivers/tty/cyclades.c
@@ -3651,7 +3651,7 @@ static int cy_pci_probe(struct pci_dev *pdev,
 	struct cyclades_card *card;
 	void __iomem *addr0 = NULL, *addr2 = NULL;
 	char *card_name = NULL;
-	u32 uninitialized_var(mailbox);
+	u32 mailbox;
 	unsigned int device_id, nchan = 0, card_no, i, j;
 	unsigned char plx_ver;
 	int retval, irq;
diff --git a/drivers/tty/isicom.c b/drivers/tty/isicom.c
index 61ecdd6b2fc2..0a7302d618b6 100644
--- a/drivers/tty/isicom.c
+++ b/drivers/tty/isicom.c
@@ -1545,7 +1545,7 @@ static unsigned int card_count;
 static int isicom_probe(struct pci_dev *pdev,
 	const struct pci_device_id *ent)
 {
-	unsigned int uninitialized_var(signature), index;
+	unsigned int signature, index;
 	int retval = -EPERM;
 	struct isi_board *board = NULL;
 
diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 6e8a54eb9842..5caedf2f1989 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -89,7 +89,6 @@ struct serial8250_config {
 #define UART_BUG_TXEN	(1 << 1)	/* UART has buggy TX IIR status */
 #define UART_BUG_NOMSR	(1 << 2)	/* UART has buggy MSR status bits (Au1x00) */
 #define UART_BUG_THRE	(1 << 3)	/* UART has buggy THRE reassertion */
-#define UART_BUG_PARITY	(1 << 4)	/* UART mishandles parity if FIFO enabled */
 
 
 #ifdef CONFIG_SERIAL_8250_SHARE_IRQ
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index e80d74293244..51d3859f8f91 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1052,14 +1052,6 @@ static int pci_oxsemi_tornado_init(struct pci_dev *dev)
 	return number_uarts;
 }
 
-static int pci_asix_setup(struct serial_private *priv,
-		  const struct pciserial_board *board,
-		  struct uart_8250_port *port, int idx)
-{
-	port->bugs |= UART_BUG_PARITY;
-	return pci_default_setup(priv, board, port, idx);
-}
-
 /* Quatech devices have their own extra interface features */
 
 struct quatech_feature {
@@ -1686,7 +1678,6 @@ pci_wch_ch38x_setup(struct serial_private *priv,
 #define PCI_DEVICE_ID_WCH_CH355_4S	0x7173
 #define PCI_VENDOR_ID_AGESTAR		0x5372
 #define PCI_DEVICE_ID_AGESTAR_9375	0x6872
-#define PCI_VENDOR_ID_ASIX		0x9710
 #define PCI_DEVICE_ID_BROADCOM_TRUMANAGE 0x160a
 #define PCI_DEVICE_ID_AMCC_ADDIDATA_APCI7800 0x818e
 
@@ -2466,16 +2457,6 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice      = PCI_ANY_ID,
 		.setup          = pci_wch_ch38x_setup,
 	},
-	/*
-	 * ASIX devices with FIFO bug
-	 */
-	{
-		.vendor		= PCI_VENDOR_ID_ASIX,
-		.device		= PCI_ANY_ID,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.setup		= pci_asix_setup,
-	},
 	/*
 	 * Broadcom TruManage (NetXtreme)
 	 */
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 78af258111e5..d3083f19d213 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2609,11 +2609,8 @@ static unsigned char serial8250_compute_lcr(struct uart_8250_port *up,
 
 	if (c_cflag & CSTOPB)
 		cval |= UART_LCR_STOP;
-	if (c_cflag & PARENB) {
+	if (c_cflag & PARENB)
 		cval |= UART_LCR_PARITY;
-		if (up->bugs & UART_BUG_PARITY)
-			up->fifo_bug = true;
-	}
 	if (!(c_cflag & PARODD))
 		cval |= UART_LCR_EPAR;
 #ifdef CMSPAR
@@ -2702,8 +2699,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	up->lcr = cval;					/* Save computed LCR */
 
 	if (up->capabilities & UART_CAP_FIFO && port->fifosize > 1) {
-		/* NOTE: If fifo_bug is not set, a user can set RX_trigger. */
-		if ((baud < 2400 && !up->dma) || up->fifo_bug) {
+		if (baud < 2400 && !up->dma) {
 			up->fcr &= ~UART_FCR_TRIGGER_MASK;
 			up->fcr |= UART_FCR_TRIGGER_1;
 		}
@@ -3039,8 +3035,7 @@ static int do_set_rxtrig(struct tty_port *port, unsigned char bytes)
 	struct uart_8250_port *up = up_to_u8250p(uport);
 	int rxtrig;
 
-	if (!(up->capabilities & UART_CAP_FIFO) || uport->fifosize <= 1 ||
-	    up->fifo_bug)
+	if (!(up->capabilities & UART_CAP_FIFO) || uport->fifosize <= 1)
 		return -EINVAL;
 
 	rxtrig = bytes_to_fcr_rxtrig(up, bytes);
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index b167170a2954..6d2ba6ab0e3b 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -798,11 +798,11 @@ static void atmel_complete_tx_dma(void *arg)
 
 	port->icount.tx += atmel_port->tx_len;
 
-	spin_lock_irq(&atmel_port->lock_tx);
+	spin_lock(&atmel_port->lock_tx);
 	async_tx_ack(atmel_port->desc_tx);
 	atmel_port->cookie_tx = -EINVAL;
 	atmel_port->desc_tx = NULL;
-	spin_unlock_irq(&atmel_port->lock_tx);
+	spin_unlock(&atmel_port->lock_tx);
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 3a105b2b7937..a50e80fde223 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1177,8 +1177,12 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
 			continue;
 
 		rate = clk_get_rate(clk);
-		if (!rate)
+		if (!rate) {
+			dev_err(ourport->port.dev,
+				"Failed to get clock rate for %s.\n", clkname);
+			clk_put(clk);
 			continue;
+		}
 
 		if (ourport->info->has_divslot) {
 			unsigned long div = rate / req_baud;
@@ -1204,10 +1208,18 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
 			calc_deviation = -calc_deviation;
 
 		if (calc_deviation < deviation) {
+			/*
+			 * If we find a better clk, release the previous one, if
+			 * any.
+			 */
+			if (!IS_ERR(*best_clk))
+				clk_put(*best_clk);
 			*best_clk = clk;
 			best_quot = quot;
 			*clk_num = cnt;
 			deviation = calc_deviation;
+		} else {
+			clk_put(clk);
 		}
 	}
 
diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index e0ebd3d513c6..f3806f4f2fc3 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -641,7 +641,13 @@ ohci_hcd_at91_drv_resume(struct device *dev)
 
 	at91_start_clock(ohci_at91);
 
-	ohci_resume(hcd, false);
+	/*
+	 * According to the comment in ohci_hcd_at91_drv_suspend()
+	 * we need to do a reset if the 48Mhz clock was stopped,
+	 * that is, if ohci_at91->wakeup is clear. Tell ohci_resume()
+	 * to reset in this case by setting its "hibernated" flag.
+	 */
+	ohci_resume(hcd, !ohci_at91->wakeup);
 
 	ohci_at91_port_suspend(ohci_at91->sfr_regmap, 0);
 
diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 5ad2972114e0..56e78cfdcdd4 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -674,6 +674,7 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 		goto exit_phys;
 
 	device_init_wakeup(dev, true);
+	dma_set_max_seg_size(dev, UINT_MAX);
 
 	xhci = hcd_to_xhci(hcd);
 	xhci->main_hcd = hcd;
diff --git a/drivers/usb/musb/cppi_dma.c b/drivers/usb/musb/cppi_dma.c
index a13bd3625043..1dcab3353344 100644
--- a/drivers/usb/musb/cppi_dma.c
+++ b/drivers/usb/musb/cppi_dma.c
@@ -1145,7 +1145,7 @@ irqreturn_t cppi_interrupt(int irq, void *dev_id)
 	struct musb_hw_ep	*hw_ep = NULL;
 	u32			rx, tx;
 	int			i, index;
-	unsigned long		uninitialized_var(flags);
+	unsigned long		flags;
 
 	cppi = container_of(musb->dma_controller, struct cppi, controller);
 	if (cppi->irq)
diff --git a/drivers/usb/phy/phy-tahvo.c b/drivers/usb/phy/phy-tahvo.c
index e4fc73bf6ee9..c156c051df99 100644
--- a/drivers/usb/phy/phy-tahvo.c
+++ b/drivers/usb/phy/phy-tahvo.c
@@ -406,7 +406,7 @@ static int tahvo_usb_probe(struct platform_device *pdev)
 
 	tu->irq = ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
-		return ret;
+		goto err_remove_phy;
 	ret = request_threaded_irq(tu->irq, NULL, tahvo_usb_vbus_interrupt,
 				   IRQF_ONESHOT,
 				   "tahvo-vbus", tu);
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 5127b651ad5d..22fd7293adb1 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -254,6 +254,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_EM061K_LTA		0x0123
 #define QUECTEL_PRODUCT_EM061K_LMS		0x0124
 #define QUECTEL_PRODUCT_EC25			0x0125
+#define QUECTEL_PRODUCT_EM060K_128		0x0128
 #define QUECTEL_PRODUCT_EG91			0x0191
 #define QUECTEL_PRODUCT_EG95			0x0195
 #define QUECTEL_PRODUCT_BG96			0x0296
@@ -271,6 +272,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_RM520N			0x0801
 #define QUECTEL_PRODUCT_EC200U			0x0901
 #define QUECTEL_PRODUCT_EC200S_CN		0x6002
+#define QUECTEL_PRODUCT_EC200A			0x6005
 #define QUECTEL_PRODUCT_EM061K_LWW		0x6008
 #define QUECTEL_PRODUCT_EM061K_LCN		0x6009
 #define QUECTEL_PRODUCT_EC200T			0x6026
@@ -1154,6 +1156,10 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE(QUALCOMM_VENDOR_ID, 0x90fa),
 	  .driver_info = RSVD(3) },
 	/* u-blox products */
+	{ USB_DEVICE(UBLOX_VENDOR_ID, 0x1311) },	/* u-blox LARA-R6 01B */
+	{ USB_DEVICE(UBLOX_VENDOR_ID, 0x1312),		/* u-blox LARA-R6 01B (RMNET) */
+	  .driver_info = RSVD(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(UBLOX_VENDOR_ID, 0x1313, 0xff) },	/* u-blox LARA-R6 01B (ECM) */
 	{ USB_DEVICE(UBLOX_VENDOR_ID, 0x1341) },	/* u-blox LARA-L6 */
 	{ USB_DEVICE(UBLOX_VENDOR_ID, 0x1342),		/* u-blox LARA-L6 (RMNET) */
 	  .driver_info = RSVD(4) },
@@ -1196,6 +1202,9 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0x00, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_128, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_128, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K_128, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LCN, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LCN, 0xff, 0x00, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LCN, 0xff, 0xff, 0x40) },
@@ -1224,6 +1233,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM520N, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, 0x0900, 0xff, 0, 0), /* RM500U-CN */
 	  .driver_info = ZLP },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200A, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200U, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200S_CN, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200T, 0xff, 0, 0) },
diff --git a/drivers/usb/serial/usb-serial-simple.c b/drivers/usb/serial/usb-serial-simple.c
index 3681e6418262..9377b712ee4e 100644
--- a/drivers/usb/serial/usb-serial-simple.c
+++ b/drivers/usb/serial/usb-serial-simple.c
@@ -41,16 +41,6 @@ static struct usb_serial_driver vendor##_device = {		\
 	{ USB_DEVICE(0x0a21, 0x8001) }	/* MMT-7305WW */
 DEVICE(carelink, CARELINK_IDS);
 
-/* ZIO Motherboard USB driver */
-#define ZIO_IDS()			\
-	{ USB_DEVICE(0x1CBE, 0x0103) }
-DEVICE(zio, ZIO_IDS);
-
-/* Funsoft Serial USB driver */
-#define FUNSOFT_IDS()			\
-	{ USB_DEVICE(0x1404, 0xcddc) }
-DEVICE(funsoft, FUNSOFT_IDS);
-
 /* Infineon Flashloader driver */
 #define FLASHLOADER_IDS()		\
 	{ USB_DEVICE_INTERFACE_CLASS(0x058b, 0x0041, USB_CLASS_CDC_DATA) }, \
@@ -58,6 +48,11 @@ DEVICE(funsoft, FUNSOFT_IDS);
 	{ USB_DEVICE(0x8087, 0x0801) }
 DEVICE(flashloader, FLASHLOADER_IDS);
 
+/* Funsoft Serial USB driver */
+#define FUNSOFT_IDS()			\
+	{ USB_DEVICE(0x1404, 0xcddc) }
+DEVICE(funsoft, FUNSOFT_IDS);
+
 /* Google Serial USB SubClass */
 #define GOOGLE_IDS()						\
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x18d1,			\
@@ -66,16 +61,21 @@ DEVICE(flashloader, FLASHLOADER_IDS);
 					0x01) }
 DEVICE(google, GOOGLE_IDS);
 
+/* HP4x (48/49) Generic Serial driver */
+#define HP4X_IDS()			\
+	{ USB_DEVICE(0x03f0, 0x0121) }
+DEVICE(hp4x, HP4X_IDS);
+
+/* KAUFMANN RKS+CAN VCP */
+#define KAUFMANN_IDS()			\
+	{ USB_DEVICE(0x16d0, 0x0870) }
+DEVICE(kaufmann, KAUFMANN_IDS);
+
 /* Libtransistor USB console */
 #define LIBTRANSISTOR_IDS()			\
 	{ USB_DEVICE(0x1209, 0x8b00) }
 DEVICE(libtransistor, LIBTRANSISTOR_IDS);
 
-/* ViVOpay USB Serial Driver */
-#define VIVOPAY_IDS()			\
-	{ USB_DEVICE(0x1d5f, 0x1004) }	/* ViVOpay 8800 */
-DEVICE(vivopay, VIVOPAY_IDS);
-
 /* Motorola USB Phone driver */
 #define MOTO_IDS()			\
 	{ USB_DEVICE(0x05c6, 0x3197) },	/* unknown Motorola phone */	\
@@ -104,10 +104,10 @@ DEVICE(nokia, NOKIA_IDS);
 	{ USB_DEVICE(0x09d7, 0x0100) }	/* NovAtel FlexPack GPS */
 DEVICE_N(novatel_gps, NOVATEL_IDS, 3);
 
-/* HP4x (48/49) Generic Serial driver */
-#define HP4X_IDS()			\
-	{ USB_DEVICE(0x03f0, 0x0121) }
-DEVICE(hp4x, HP4X_IDS);
+/* Siemens USB/MPI adapter */
+#define SIEMENS_IDS()			\
+	{ USB_DEVICE(0x908, 0x0004) }
+DEVICE(siemens_mpi, SIEMENS_IDS);
 
 /* Suunto ANT+ USB Driver */
 #define SUUNTO_IDS()			\
@@ -115,45 +115,52 @@ DEVICE(hp4x, HP4X_IDS);
 	{ USB_DEVICE(0x0fcf, 0x1009) } /* Dynastream ANT USB-m Stick */
 DEVICE(suunto, SUUNTO_IDS);
 
-/* Siemens USB/MPI adapter */
-#define SIEMENS_IDS()			\
-	{ USB_DEVICE(0x908, 0x0004) }
-DEVICE(siemens_mpi, SIEMENS_IDS);
+/* ViVOpay USB Serial Driver */
+#define VIVOPAY_IDS()			\
+	{ USB_DEVICE(0x1d5f, 0x1004) }	/* ViVOpay 8800 */
+DEVICE(vivopay, VIVOPAY_IDS);
+
+/* ZIO Motherboard USB driver */
+#define ZIO_IDS()			\
+	{ USB_DEVICE(0x1CBE, 0x0103) }
+DEVICE(zio, ZIO_IDS);
 
 /* All of the above structures mushed into two lists */
 static struct usb_serial_driver * const serial_drivers[] = {
 	&carelink_device,
-	&zio_device,
-	&funsoft_device,
 	&flashloader_device,
+	&funsoft_device,
 	&google_device,
+	&hp4x_device,
+	&kaufmann_device,
 	&libtransistor_device,
-	&vivopay_device,
 	&moto_modem_device,
 	&motorola_tetra_device,
 	&nokia_device,
 	&novatel_gps_device,
-	&hp4x_device,
-	&suunto_device,
 	&siemens_mpi_device,
+	&suunto_device,
+	&vivopay_device,
+	&zio_device,
 	NULL
 };
 
 static const struct usb_device_id id_table[] = {
 	CARELINK_IDS(),
-	ZIO_IDS(),
-	FUNSOFT_IDS(),
 	FLASHLOADER_IDS(),
+	FUNSOFT_IDS(),
 	GOOGLE_IDS(),
+	HP4X_IDS(),
+	KAUFMANN_IDS(),
 	LIBTRANSISTOR_IDS(),
-	VIVOPAY_IDS(),
 	MOTO_IDS(),
 	MOTOROLA_TETRA_IDS(),
 	NOKIA_IDS(),
 	NOVATEL_IDS(),
-	HP4X_IDS(),
-	SUUNTO_IDS(),
 	SIEMENS_IDS(),
+	SUUNTO_IDS(),
+	VIVOPAY_IDS(),
+	ZIO_IDS(),
 	{ },
 };
 MODULE_DEVICE_TABLE(usb, id_table);
diff --git a/drivers/usb/storage/sddr55.c b/drivers/usb/storage/sddr55.c
index 147c50b3e00f..4bba646576b1 100644
--- a/drivers/usb/storage/sddr55.c
+++ b/drivers/usb/storage/sddr55.c
@@ -566,8 +566,8 @@ static int sddr55_reset(struct us_data *us)
 
 static unsigned long sddr55_get_capacity(struct us_data *us) {
 
-	unsigned char uninitialized_var(manufacturerID);
-	unsigned char uninitialized_var(deviceID);
+	unsigned char manufacturerID;
+	unsigned char deviceID;
 	int result;
 	struct sddr55_card_info *info = (struct sddr55_card_info *)us->extra;
 
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index c41197402d81..69df50718e4d 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -678,7 +678,7 @@ static int get_rx_bufs(struct vhost_virtqueue *vq,
 	/* len is always initialized before use since we are always called with
 	 * datalen > 0.
 	 */
-	u32 uninitialized_var(len);
+	u32 len;
 
 	while (datalen > 0 && headcount < quota) {
 		if (unlikely(seg >= UIO_MAXIOV)) {
@@ -735,7 +735,7 @@ static void handle_rx(struct vhost_net *net)
 {
 	struct vhost_net_virtqueue *nvq = &net->vqs[VHOST_NET_VQ_RX];
 	struct vhost_virtqueue *vq = &nvq->vq;
-	unsigned uninitialized_var(in), log;
+	unsigned in, log;
 	struct vhost_log *vq_log;
 	struct msghdr msg = {
 		.msg_name = NULL,
diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
index e17a083f849a..cae4a04cba48 100644
--- a/drivers/video/fbdev/au1200fb.c
+++ b/drivers/video/fbdev/au1200fb.c
@@ -1748,6 +1748,9 @@ static int au1200fb_drv_probe(struct platform_device *dev)
 
 	/* Now hook interrupt too */
 	irq = platform_get_irq(dev, 0);
+	if (irq < 0)
+		return irq;
+
 	ret = request_irq(irq, au1200fb_handle_irq,
 			  IRQF_SHARED, "lcd", (void *)dev);
 	if (ret) {
diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index 6589d5f0a5a4..9b1a11bcd921 100644
--- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1348,7 +1348,7 @@ static struct fb_ops imsttfb_ops = {
 	.fb_ioctl 	= imsttfb_ioctl,
 };
 
-static void init_imstt(struct fb_info *info)
+static int init_imstt(struct fb_info *info)
 {
 	struct imstt_par *par = info->par;
 	__u32 i, tmp, *ip, *end;
@@ -1420,7 +1420,7 @@ static void init_imstt(struct fb_info *info)
 	    || !(compute_imstt_regvals(par, info->var.xres, info->var.yres))) {
 		printk("imsttfb: %ux%ux%u not supported\n", info->var.xres, info->var.yres, info->var.bits_per_pixel);
 		framebuffer_release(info);
-		return;
+		return -ENODEV;
 	}
 
 	sprintf(info->fix.id, "IMS TT (%s)", par->ramdac == IBM ? "IBM" : "TVP");
@@ -1460,12 +1460,13 @@ static void init_imstt(struct fb_info *info)
 	if (register_framebuffer(info) < 0) {
 		fb_dealloc_cmap(&info->cmap);
 		framebuffer_release(info);
-		return;
+		return -ENODEV;
 	}
 
 	tmp = (read_reg_le32(par->dc_regs, SSTATUS) & 0x0f00) >> 8;
 	fb_info(info, "%s frame buffer; %uMB vram; chip version %u\n",
 		info->fix.id, info->fix.smem_len >> 20, tmp);
+	return 0;
 }
 
 static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
@@ -1474,7 +1475,8 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct imstt_par *par;
 	struct fb_info *info;
 	struct device_node *dp;
-	
+	int ret;
+
 	dp = pci_device_to_OF_node(pdev);
 	if(dp)
 		printk(KERN_INFO "%s: OF name %s\n",__func__, dp->name);
@@ -1525,10 +1527,10 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	par->cmap_regs_phys = addr + 0x840000;
 	par->cmap_regs = (__u8 *)ioremap(addr + 0x840000, 0x1000);
 	info->pseudo_palette = par->palette;
-	init_imstt(info);
-
-	pci_set_drvdata(pdev, info);
-	return 0;
+	ret = init_imstt(info);
+	if (!ret)
+		pci_set_drvdata(pdev, info);
+	return ret;
 }
 
 static void imsttfb_remove(struct pci_dev *pdev)
diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index ba82f97fb42b..a4dc25fbdd1b 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -601,10 +601,10 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
 	if (var->hsync_len < 1    || var->hsync_len > 64)
 		printk(KERN_ERR "%s: invalid hsync_len %d\n",
 			info->fix.id, var->hsync_len);
-	if (var->left_margin > 255)
+	if (var->left_margin < 3  || var->left_margin > 255)
 		printk(KERN_ERR "%s: invalid left_margin %d\n",
 			info->fix.id, var->left_margin);
-	if (var->right_margin > 255)
+	if (var->right_margin < 1 || var->right_margin > 255)
 		printk(KERN_ERR "%s: invalid right_margin %d\n",
 			info->fix.id, var->right_margin);
 	if (var->yres < 1 || var->yres > ymax_mask)
diff --git a/drivers/video/fbdev/matrox/matroxfb_maven.c b/drivers/video/fbdev/matrox/matroxfb_maven.c
index bf5ce04f9aea..267b31ddb02d 100644
--- a/drivers/video/fbdev/matrox/matroxfb_maven.c
+++ b/drivers/video/fbdev/matrox/matroxfb_maven.c
@@ -299,7 +299,7 @@ static int matroxfb_mavenclock(const struct matrox_pll_ctl *ctl,
 		unsigned int* in, unsigned int* feed, unsigned int* post,
 		unsigned int* htotal2) {
 	unsigned int fvco;
-	unsigned int uninitialized_var(p);
+	unsigned int p;
 
 	fvco = matroxfb_PLL_mavenclock(&maven1000_pll, ctl, htotal, vtotal, in, feed, &p, htotal2);
 	if (!fvco)
@@ -731,8 +731,8 @@ static int maven_find_exact_clocks(unsigned int ht, unsigned int vt,
 
 	for (x = 0; x < 8; x++) {
 		unsigned int c;
-		unsigned int uninitialized_var(a), uninitialized_var(b),
-			     uninitialized_var(h2);
+		unsigned int a, b,
+			     h2;
 		unsigned int h = ht + 2 + x;
 
 		if (!matroxfb_mavenclock((m->mode == MATROXFB_OUTPUT_MODE_PAL) ? &maven_PAL : &maven_NTSC, h, vt, &a, &b, &c, &h2)) {
diff --git a/drivers/video/fbdev/omap/lcd_mipid.c b/drivers/video/fbdev/omap/lcd_mipid.c
index e3a85432f926..5730355ee598 100644
--- a/drivers/video/fbdev/omap/lcd_mipid.c
+++ b/drivers/video/fbdev/omap/lcd_mipid.c
@@ -576,11 +576,15 @@ static int mipid_spi_probe(struct spi_device *spi)
 
 	r = mipid_detect(md);
 	if (r < 0)
-		return r;
+		goto free_md;
 
 	omapfb_register_panel(&md->panel);
 
 	return 0;
+
+free_md:
+	kfree(md);
+	return r;
 }
 
 static int mipid_spi_remove(struct spi_device *spi)
diff --git a/drivers/video/fbdev/pm3fb.c b/drivers/video/fbdev/pm3fb.c
index 6130aa56a1e9..7bd45334dcac 100644
--- a/drivers/video/fbdev/pm3fb.c
+++ b/drivers/video/fbdev/pm3fb.c
@@ -821,9 +821,9 @@ static void pm3fb_write_mode(struct fb_info *info)
 
 	wmb();
 	{
-		unsigned char uninitialized_var(m);	/* ClkPreScale */
-		unsigned char uninitialized_var(n);	/* ClkFeedBackScale */
-		unsigned char uninitialized_var(p);	/* ClkPostScale */
+		unsigned char m;	/* ClkPreScale */
+		unsigned char n;	/* ClkFeedBackScale */
+		unsigned char p;	/* ClkPostScale */
 		unsigned long pixclock = PICOS2KHZ(info->var.pixclock);
 
 		(void)pm3fb_calculate_clock(pixclock, &m, &n, &p);
diff --git a/drivers/video/fbdev/riva/riva_hw.c b/drivers/video/fbdev/riva/riva_hw.c
index 8bdf37f3013b..b2d3e71fd9ae 100644
--- a/drivers/video/fbdev/riva/riva_hw.c
+++ b/drivers/video/fbdev/riva/riva_hw.c
@@ -1242,8 +1242,7 @@ int CalcStateExt
 )
 {
     int pixelDepth;
-    int uninitialized_var(VClk),uninitialized_var(m),
-        uninitialized_var(n),	uninitialized_var(p);
+    int VClk, m, n, p;
 
     /*
      * Save mode parameters.
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 22a4329ed200..fe9fe5c739a5 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -269,7 +269,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct scatterlist *sg;
 	struct vring_desc *desc;
-	unsigned int i, n, avail, descs_used, uninitialized_var(prev), err_idx;
+	unsigned int i, n, avail, descs_used, prev, err_idx;
 	int head;
 	bool indirect;
 
diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index 4d43c373e5c6..cfba277bfd57 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -1233,10 +1233,10 @@ static int __init w1_init(void)
 
 static void __exit w1_fini(void)
 {
-	struct w1_master *dev;
+	struct w1_master *dev, *n;
 
 	/* Set netlink removal messages and some cleanup */
-	list_for_each_entry(dev, &w1_masters, w1_master_entry)
+	list_for_each_entry_safe(dev, n, &w1_masters, w1_master_entry)
 		__w1_remove_master_device(dev);
 
 	w1_fini_netlink();
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 613a77058263..6269ee97eba2 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -579,7 +579,7 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 static int afs_d_revalidate(struct dentry *dentry, unsigned int flags)
 {
 	struct afs_vnode *vnode, *dir;
-	struct afs_fid uninitialized_var(fid);
+	struct afs_fid fid;
 	struct dentry *parent;
 	struct key *key;
 	void *dir_version;
diff --git a/fs/afs/security.c b/fs/afs/security.c
index 859096e25f2c..5fa9c6f5ffd0 100644
--- a/fs/afs/security.c
+++ b/fs/afs/security.c
@@ -288,7 +288,7 @@ static int afs_check_permit(struct afs_vnode *vnode, struct key *key,
 int afs_permission(struct inode *inode, int mask)
 {
 	struct afs_vnode *vnode = AFS_FS_I(inode);
-	afs_access_t uninitialized_var(access);
+	afs_access_t access;
 	struct key *key;
 	int ret;
 
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 4ad588ed5813..3eb5bf1219ae 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -969,7 +969,9 @@ int btrfs_quota_disable(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto out;
 
+	spin_lock(&fs_info->trans_lock);
 	list_del(&quota_root->dirty_list);
+	spin_unlock(&fs_info->trans_lock);
 
 	btrfs_tree_lock(quota_root->node);
 	clean_tree_block(fs_info, quota_root->node);
diff --git a/fs/dlm/netlink.c b/fs/dlm/netlink.c
index 43a96c330570..ea50f59610e5 100644
--- a/fs/dlm/netlink.c
+++ b/fs/dlm/netlink.c
@@ -115,7 +115,7 @@ static void fill_data(struct dlm_lock_data *data, struct dlm_lkb *lkb)
 
 void dlm_timeout_warn(struct dlm_lkb *lkb)
 {
-	struct sk_buff *uninitialized_var(send_skb);
+	struct sk_buff *send_skb;
 	struct dlm_lock_data *data;
 	size_t size;
 	int rv;
diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index b53ca4df7e77..25bf72c15d16 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -366,7 +366,9 @@ int dlm_posix_get(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 		locks_init_lock(fl);
 		fl->fl_type = (op->info.ex) ? F_WRLCK : F_RDLCK;
 		fl->fl_flags = FL_POSIX;
-		fl->fl_pid = -op->info.pid;
+		fl->fl_pid = op->info.pid;
+		if (op->info.nodeid != dlm_our_nodeid())
+			fl->fl_pid = -fl->fl_pid;
 		fl->fl_start = op->info.start;
 		fl->fl_end = op->info.end;
 		rv = 0;
diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index b500fed96a69..7712eb335fdb 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -68,10 +68,7 @@ struct mb_cache;
  * second extended-fs super-block data in memory
  */
 struct ext2_sb_info {
-	unsigned long s_frag_size;	/* Size of a fragment in bytes */
-	unsigned long s_frags_per_block;/* Number of fragments per block */
 	unsigned long s_inodes_per_block;/* Number of inodes per block */
-	unsigned long s_frags_per_group;/* Number of fragments in a group */
 	unsigned long s_blocks_per_group;/* Number of blocks in a group */
 	unsigned long s_inodes_per_group;/* Number of inodes in a group */
 	unsigned long s_itb_per_group;	/* Number of inode table blocks per group */
@@ -185,15 +182,6 @@ static inline struct ext2_sb_info *EXT2_SB(struct super_block *sb)
 #define EXT2_INODE_SIZE(s)		(EXT2_SB(s)->s_inode_size)
 #define EXT2_FIRST_INO(s)		(EXT2_SB(s)->s_first_ino)
 
-/*
- * Macro-instructions used to manage fragments
- */
-#define EXT2_MIN_FRAG_SIZE		1024
-#define	EXT2_MAX_FRAG_SIZE		4096
-#define EXT2_MIN_FRAG_LOG_SIZE		  10
-#define EXT2_FRAG_SIZE(s)		(EXT2_SB(s)->s_frag_size)
-#define EXT2_FRAGS_PER_BLOCK(s)		(EXT2_SB(s)->s_frags_per_block)
-
 /*
  * Structure of a blocks group descriptor
  */
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 7ca9fb0bfc32..a5b95c296ed4 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -684,10 +684,9 @@ static int ext2_setup_super (struct super_block * sb,
 		es->s_max_mnt_count = cpu_to_le16(EXT2_DFL_MAX_MNT_COUNT);
 	le16_add_cpu(&es->s_mnt_count, 1);
 	if (test_opt (sb, DEBUG))
-		ext2_msg(sb, KERN_INFO, "%s, %s, bs=%lu, fs=%lu, gc=%lu, "
+		ext2_msg(sb, KERN_INFO, "%s, %s, bs=%lu, gc=%lu, "
 			"bpg=%lu, ipg=%lu, mo=%04lx]",
 			EXT2FS_VERSION, EXT2FS_DATE, sb->s_blocksize,
-			sbi->s_frag_size,
 			sbi->s_groups_count,
 			EXT2_BLOCKS_PER_GROUP(sb),
 			EXT2_INODES_PER_GROUP(sb),
@@ -1024,14 +1023,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 		}
 	}
 
-	sbi->s_frag_size = EXT2_MIN_FRAG_SIZE <<
-				   le32_to_cpu(es->s_log_frag_size);
-	if (sbi->s_frag_size == 0)
-		goto cantfind_ext2;
-	sbi->s_frags_per_block = sb->s_blocksize / sbi->s_frag_size;
-
 	sbi->s_blocks_per_group = le32_to_cpu(es->s_blocks_per_group);
-	sbi->s_frags_per_group = le32_to_cpu(es->s_frags_per_group);
 	sbi->s_inodes_per_group = le32_to_cpu(es->s_inodes_per_group);
 
 	if (EXT2_INODE_SIZE(sb) == 0)
@@ -1059,11 +1051,10 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 		goto failed_mount;
 	}
 
-	if (sb->s_blocksize != sbi->s_frag_size) {
+	if (es->s_log_frag_size != es->s_log_block_size) {
 		ext2_msg(sb, KERN_ERR,
-			"error: fragsize %lu != blocksize %lu"
-			"(not supported yet)",
-			sbi->s_frag_size, sb->s_blocksize);
+			"error: fragsize log %u != blocksize log %u",
+			le32_to_cpu(es->s_log_frag_size), sb->s_blocksize_bits);
 		goto failed_mount;
 	}
 
@@ -1073,12 +1064,6 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 			sbi->s_blocks_per_group);
 		goto failed_mount;
 	}
-	if (sbi->s_frags_per_group > sb->s_blocksize * 8) {
-		ext2_msg(sb, KERN_ERR,
-			"error: #fragments per group too big: %lu",
-			sbi->s_frags_per_group);
-		goto failed_mount;
-	}
 	if (sbi->s_inodes_per_group < sbi->s_inodes_per_block ||
 	    sbi->s_inodes_per_group > sb->s_blocksize * 8) {
 		ext2_msg(sb, KERN_ERR,
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index 0cc0d22c0856..9bf711d63368 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -642,6 +642,14 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
 
 	ext4_update_inode_fsync_trans(handle, inode, 1);
 	count = ar.len;
+
+	/*
+	 * Update reserved blocks/metadata blocks after successful block
+	 * allocation which had been deferred till now.
+	 */
+	if (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
+		ext4_da_update_reserve_space(inode, count, 1);
+
 got_it:
 	map->m_flags |= EXT4_MAP_MAPPED;
 	map->m_pblk = le32_to_cpu(chain[depth-1].key);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 35c72f8fee75..c07dddc63110 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -665,16 +665,6 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 			 */
 			ext4_clear_inode_state(inode, EXT4_STATE_EXT_MIGRATE);
 		}
-
-		/*
-		 * Update reserved blocks/metadata blocks after successful
-		 * block allocation which had been deferred till now. We don't
-		 * support fallocate for non extent files. So we can update
-		 * reserve space here.
-		 */
-		if ((retval > 0) &&
-			(flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE))
-			ext4_da_update_reserve_space(inode, retval, 1);
 	}
 
 	if (retval > 0) {
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index ce21da3f437f..9a2b25e5905e 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4976,8 +4976,8 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 		 * them with group lock_held
 		 */
 		if (test_opt(sb, DISCARD)) {
-			err = ext4_issue_discard(sb, block_group, bit, count,
-						 NULL);
+			err = ext4_issue_discard(sb, block_group, bit,
+						 count_clusters, NULL);
 			if (err && err != -EOPNOTSUPP)
 				ext4_msg(sb, KERN_WARNING, "discard request in"
 					 " group:%d block:%d count:%lu failed"
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index c2117b985d4a..11b7b8b89f5e 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1757,6 +1757,20 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 		memmove(here, (void *)here + size,
 			(void *)last - (void *)here + sizeof(__u32));
 		memset(last, 0, size);
+
+		/*
+		 * Update i_inline_off - moved ibody region might contain
+		 * system.data attribute.  Handling a failure here won't
+		 * cause other complications for setting an xattr.
+		 */
+		if (!is_block && ext4_has_inline_data(inode)) {
+			ret = ext4_find_inline_data_nolock(inode);
+			if (ret) {
+				ext4_warning_inode(inode,
+					"unable to update i_inline_off");
+				goto out;
+			}
+		}
 	} else if (s->not_found) {
 		/* Insert new name. */
 		size_t size = EXT4_XATTR_LEN(name_len);
diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 971e369517a7..6b350d08340c 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -1287,7 +1287,7 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 	struct super_block *sb = dir->i_sb;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	struct buffer_head *bh, *prev, *bhs[3]; /* 32*slots (672bytes) */
-	struct msdos_dir_entry *uninitialized_var(de);
+	struct msdos_dir_entry *de;
 	int err, free_slots, i, nr_bhs;
 	loff_t pos, i_pos;
 
diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 42bed87dd5ea..2ce990f31322 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -117,7 +117,7 @@ static ssize_t fuse_conn_max_background_write(struct file *file,
 					      const char __user *buf,
 					      size_t count, loff_t *ppos)
 {
-	unsigned uninitialized_var(val);
+	unsigned val;
 	ssize_t ret;
 
 	ret = fuse_conn_limit_write(file, buf, count, ppos, &val,
diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index b15eaa9e6cd7..196fb9847d03 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -268,7 +268,7 @@ static int cuse_parse_one(char **pp, char *end, char **keyp, char **valp)
 static int cuse_parse_devinfo(char *p, size_t len, struct cuse_devinfo *devinfo)
 {
 	char *end = p + len;
-	char *uninitialized_var(key), *uninitialized_var(val);
+	char *key, *val;
 	int rc;
 
 	while (true) {
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 94ecc67292c7..8e5125904762 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -232,7 +232,7 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 			spin_unlock(&fc->lock);
 		}
 		kfree(forget);
-		if (ret == -ENOMEM)
+		if (ret == -ENOMEM || ret == -EINTR)
 			goto out;
 		if (ret || fuse_invalid_attr(&outarg.attr) ||
 		    (outarg.attr.mode ^ inode->i_mode) & S_IFMT)
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a32b2ca3de6f..b6bbb24363d0 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2770,7 +2770,7 @@ static void fuse_register_polled_file(struct fuse_conn *fc,
 {
 	spin_lock(&fc->lock);
 	if (RB_EMPTY_NODE(&ff->polled_node)) {
-		struct rb_node **link, *uninitialized_var(parent);
+		struct rb_node **link, *parent;
 
 		link = fuse_find_polled_node(fc, ff->kh, &parent);
 		BUG_ON(*link);
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 68ed06962537..4e88da58e140 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -379,7 +379,7 @@ static int gfs2_write_cache_jdata(struct address_space *mapping,
 	int done = 0;
 	struct pagevec pvec;
 	int nr_pages;
-	pgoff_t uninitialized_var(writeback_index);
+	pgoff_t writeback_index;
 	pgoff_t index;
 	pgoff_t end;
 	pgoff_t done_index;
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 56bfed0a5873..73290263402a 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1575,6 +1575,14 @@ static void gfs2_evict_inode(struct inode *inode)
 	if (inode->i_nlink || sb_rdonly(sb))
 		goto out;
 
+	/*
+	 * In case of an incomplete mount, gfs2_evict_inode() may be called for
+	 * system files without having an active journal to write to.  In that
+	 * case, skip the filesystem evict.
+	 */
+	if (!sdp->sd_jdesc)
+		goto out;
+
 	if (test_bit(GIF_ALLOC_FAILED, &ip->i_flags)) {
 		BUG_ON(!gfs2_glock_is_locked_by_me(ip->i_gl));
 		gfs2_holder_mark_uninitialized(&gh);
diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
index dfa90c21948f..8250e24e3f2c 100644
--- a/fs/hfsplus/unicode.c
+++ b/fs/hfsplus/unicode.c
@@ -351,7 +351,7 @@ int hfsplus_hash_dentry(const struct dentry *dentry, struct qstr *str)
 	astr = str->name;
 	len = str->len;
 	while (len > 0) {
-		int uninitialized_var(dsize);
+		int dsize;
 		size = asc2unichar(sb, astr, len, &c);
 		astr += size;
 		len -= size;
diff --git a/fs/isofs/namei.c b/fs/isofs/namei.c
index 558e7c51ce0d..58f80e1b3ac0 100644
--- a/fs/isofs/namei.c
+++ b/fs/isofs/namei.c
@@ -153,8 +153,8 @@ isofs_find_entry(struct inode *dir, struct dentry *dentry,
 struct dentry *isofs_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
 {
 	int found;
-	unsigned long uninitialized_var(block);
-	unsigned long uninitialized_var(offset);
+	unsigned long block;
+	unsigned long offset;
 	struct inode *inode;
 	struct page *page;
 
diff --git a/fs/jffs2/build.c b/fs/jffs2/build.c
index 837cd55fd4c5..6ae9d6fefb86 100644
--- a/fs/jffs2/build.c
+++ b/fs/jffs2/build.c
@@ -211,7 +211,10 @@ static int jffs2_build_filesystem(struct jffs2_sb_info *c)
 		ic->scan_dents = NULL;
 		cond_resched();
 	}
-	jffs2_build_xattr_subsystem(c);
+	ret = jffs2_build_xattr_subsystem(c);
+	if (ret)
+		goto exit;
+
 	c->flags &= ~JFFS2_SB_FLAG_BUILDING;
 
 	dbg_fsbuild("FS build complete\n");
diff --git a/fs/jffs2/erase.c b/fs/jffs2/erase.c
index 4a6cf289be24..3e0ea6e75e93 100644
--- a/fs/jffs2/erase.c
+++ b/fs/jffs2/erase.c
@@ -428,7 +428,7 @@ static void jffs2_mark_erased_block(struct jffs2_sb_info *c, struct jffs2_eraseb
 {
 	size_t retlen;
 	int ret;
-	uint32_t uninitialized_var(bad_offset);
+	uint32_t bad_offset;
 
 	switch (jffs2_block_check_erase(c, jeb, &bad_offset)) {
 	case -EAGAIN:	goto refile;
diff --git a/fs/jffs2/xattr.c b/fs/jffs2/xattr.c
index da3e18503c65..acb4492f5970 100644
--- a/fs/jffs2/xattr.c
+++ b/fs/jffs2/xattr.c
@@ -772,10 +772,10 @@ void jffs2_clear_xattr_subsystem(struct jffs2_sb_info *c)
 }
 
 #define XREF_TMPHASH_SIZE	(128)
-void jffs2_build_xattr_subsystem(struct jffs2_sb_info *c)
+int jffs2_build_xattr_subsystem(struct jffs2_sb_info *c)
 {
 	struct jffs2_xattr_ref *ref, *_ref;
-	struct jffs2_xattr_ref *xref_tmphash[XREF_TMPHASH_SIZE];
+	struct jffs2_xattr_ref **xref_tmphash;
 	struct jffs2_xattr_datum *xd, *_xd;
 	struct jffs2_inode_cache *ic;
 	struct jffs2_raw_node_ref *raw;
@@ -784,9 +784,12 @@ void jffs2_build_xattr_subsystem(struct jffs2_sb_info *c)
 
 	BUG_ON(!(c->flags & JFFS2_SB_FLAG_BUILDING));
 
+	xref_tmphash = kcalloc(XREF_TMPHASH_SIZE,
+			       sizeof(struct jffs2_xattr_ref *), GFP_KERNEL);
+	if (!xref_tmphash)
+		return -ENOMEM;
+
 	/* Phase.1 : Merge same xref */
-	for (i=0; i < XREF_TMPHASH_SIZE; i++)
-		xref_tmphash[i] = NULL;
 	for (ref=c->xref_temp; ref; ref=_ref) {
 		struct jffs2_xattr_ref *tmp;
 
@@ -884,6 +887,8 @@ void jffs2_build_xattr_subsystem(struct jffs2_sb_info *c)
 		     "%u of xref (%u dead, %u orphan) found.\n",
 		     xdatum_count, xdatum_unchecked_count, xdatum_orphan_count,
 		     xref_count, xref_dead_count, xref_orphan_count);
+	kfree(xref_tmphash);
+	return 0;
 }
 
 struct jffs2_xattr_datum *jffs2_setup_xattr_datum(struct jffs2_sb_info *c,
diff --git a/fs/jffs2/xattr.h b/fs/jffs2/xattr.h
index 720007b2fd65..1b5030a3349d 100644
--- a/fs/jffs2/xattr.h
+++ b/fs/jffs2/xattr.h
@@ -71,7 +71,7 @@ static inline int is_xattr_ref_dead(struct jffs2_xattr_ref *ref)
 #ifdef CONFIG_JFFS2_FS_XATTR
 
 extern void jffs2_init_xattr_subsystem(struct jffs2_sb_info *c);
-extern void jffs2_build_xattr_subsystem(struct jffs2_sb_info *c);
+extern int jffs2_build_xattr_subsystem(struct jffs2_sb_info *c);
 extern void jffs2_clear_xattr_subsystem(struct jffs2_sb_info *c);
 
 extern struct jffs2_xattr_datum *jffs2_setup_xattr_datum(struct jffs2_sb_info *c,
@@ -103,7 +103,7 @@ extern ssize_t jffs2_listxattr(struct dentry *, char *, size_t);
 #else
 
 #define jffs2_init_xattr_subsystem(c)
-#define jffs2_build_xattr_subsystem(c)
+#define jffs2_build_xattr_subsystem(c)		(0)
 #define jffs2_clear_xattr_subsystem(c)
 
 #define jffs2_xattr_do_crccheck_inode(c, ic)
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 6a0f564e58dd..cc2ac1f324b0 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -191,7 +191,13 @@ int dbMount(struct inode *ipbmap)
 	dbmp_le = (struct dbmap_disk *) mp->data;
 	bmp->db_mapsize = le64_to_cpu(dbmp_le->dn_mapsize);
 	bmp->db_nfree = le64_to_cpu(dbmp_le->dn_nfree);
+
 	bmp->db_l2nbperpage = le32_to_cpu(dbmp_le->dn_l2nbperpage);
+	if (bmp->db_l2nbperpage > L2PSIZE - L2MINBLOCKSIZE) {
+		err = -EINVAL;
+		goto err_release_metapage;
+	}
+
 	bmp->db_numag = le32_to_cpu(dbmp_le->dn_numag);
 	if (!bmp->db_numag) {
 		err = -EINVAL;
diff --git a/fs/jfs/jfs_filsys.h b/fs/jfs/jfs_filsys.h
index 415bfa90607a..0c36ce6318d5 100644
--- a/fs/jfs/jfs_filsys.h
+++ b/fs/jfs/jfs_filsys.h
@@ -135,7 +135,9 @@
 #define NUM_INODE_PER_IAG	INOSPERIAG
 
 #define MINBLOCKSIZE		512
+#define L2MINBLOCKSIZE		9
 #define MAXBLOCKSIZE		4096
+#define L2MAXBLOCKSIZE		12
 #define	MAXFILESIZE		((s64)1 << 52)
 
 #define JFS_LINK_MAX		0xffffffff
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index a82b7d2c8880..d34ed6575e8f 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3361,7 +3361,7 @@ nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_op
 		p = xdr_reserve_space(xdr, 32);
 		if (!p)
 			return nfserr_resource;
-		*p++ = cpu_to_be32(0);
+		*p++ = cpu_to_be32(open->op_recall);
 
 		/*
 		 * TODO: space_limit's in delegations
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 50465ee502c7..69a31642d5fc 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -347,7 +347,7 @@ static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
 static ssize_t write_filehandle(struct file *file, char *buf, size_t size)
 {
 	char *dname, *path;
-	int uninitialized_var(maxsize);
+	int maxsize;
 	char *mesg = buf;
 	int len;
 	struct auth_domain *dom;
diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index 8512f2119241..6dbf26a44485 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -4699,7 +4699,7 @@ int ocfs2_insert_extent(handle_t *handle,
 			struct ocfs2_alloc_context *meta_ac)
 {
 	int status;
-	int uninitialized_var(free_records);
+	int free_records;
 	struct buffer_head *last_eb_bh = NULL;
 	struct ocfs2_insert_type insert = {0, };
 	struct ocfs2_extent_rec rec;
@@ -6889,7 +6889,7 @@ int ocfs2_convert_inline_data_to_extents(struct inode *inode,
 	int need_free = 0;
 	u32 bit_off, num;
 	handle_t *handle;
-	u64 uninitialized_var(block);
+	u64 block;
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
 	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *)di_bh->b_data;
diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index 3c26f2dfedf1..08d902a89213 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -865,9 +865,9 @@ static int ocfs2_dx_dir_lookup(struct inode *inode,
 			       u64 *ret_phys_blkno)
 {
 	int ret = 0;
-	unsigned int cend, uninitialized_var(clen);
-	u32 uninitialized_var(cpos);
-	u64 uninitialized_var(blkno);
+	unsigned int cend, clen;
+	u32 cpos;
+	u64 blkno;
 	u32 name_hash = hinfo->major_hash;
 
 	ret = ocfs2_dx_dir_lookup_rec(inode, el, name_hash, &cpos, &blkno,
@@ -911,7 +911,7 @@ static int ocfs2_dx_dir_search(const char *name, int namelen,
 			       struct ocfs2_dir_lookup_result *res)
 {
 	int ret, i, found;
-	u64 uninitialized_var(phys);
+	u64 phys;
 	struct buffer_head *dx_leaf_bh = NULL;
 	struct ocfs2_dx_leaf *dx_leaf;
 	struct ocfs2_dx_entry *dx_entry = NULL;
@@ -4419,9 +4419,9 @@ static int ocfs2_dx_dir_remove_index(struct inode *dir,
 int ocfs2_dx_dir_truncate(struct inode *dir, struct buffer_head *di_bh)
 {
 	int ret;
-	unsigned int uninitialized_var(clen);
-	u32 major_hash = UINT_MAX, p_cpos, uninitialized_var(cpos);
-	u64 uninitialized_var(blkno);
+	unsigned int clen;
+	u32 major_hash = UINT_MAX, p_cpos, cpos;
+	u64 blkno;
 	struct ocfs2_super *osb = OCFS2_SB(dir->i_sb);
 	struct buffer_head *dx_root_bh = NULL;
 	struct ocfs2_dx_root_block *dx_root;
diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
index e4719e0a3f99..686068e20a90 100644
--- a/fs/ocfs2/extent_map.c
+++ b/fs/ocfs2/extent_map.c
@@ -415,7 +415,7 @@ static int ocfs2_get_clusters_nocache(struct inode *inode,
 {
 	int i, ret, tree_height, len;
 	struct ocfs2_dinode *di;
-	struct ocfs2_extent_block *uninitialized_var(eb);
+	struct ocfs2_extent_block *eb;
 	struct ocfs2_extent_list *el;
 	struct ocfs2_extent_rec *rec;
 	struct buffer_head *eb_bh = NULL;
@@ -612,7 +612,7 @@ int ocfs2_get_clusters(struct inode *inode, u32 v_cluster,
 		       unsigned int *extent_flags)
 {
 	int ret;
-	unsigned int uninitialized_var(hole_len), flags = 0;
+	unsigned int hole_len, flags = 0;
 	struct buffer_head *di_bh = NULL;
 	struct ocfs2_extent_rec rec;
 
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 1dc9304eec89..6ec15ffeb562 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -2506,7 +2506,7 @@ int ocfs2_create_inode_in_orphan(struct inode *dir,
 	struct buffer_head *new_di_bh = NULL;
 	struct ocfs2_alloc_context *inode_ac = NULL;
 	struct ocfs2_dir_lookup_result orphan_insert = { NULL, };
-	u64 uninitialized_var(di_blkno), suballoc_loc;
+	u64 di_blkno, suballoc_loc;
 	u16 suballoc_bit;
 
 	status = ocfs2_inode_lock(dir, &parent_di_bh, 1);
diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
index 3a4e1bca5e31..5f3190905955 100644
--- a/fs/ocfs2/refcounttree.c
+++ b/fs/ocfs2/refcounttree.c
@@ -1069,7 +1069,7 @@ static int ocfs2_get_refcount_rec(struct ocfs2_caching_info *ci,
 				  struct buffer_head **ret_bh)
 {
 	int ret = 0, i, found;
-	u32 low_cpos, uninitialized_var(cpos_end);
+	u32 low_cpos, cpos_end;
 	struct ocfs2_extent_list *el;
 	struct ocfs2_extent_rec *rec = NULL;
 	struct ocfs2_extent_block *eb = NULL;
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 77740ef5a8e8..ceba69bbe04b 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -1218,7 +1218,7 @@ static int ocfs2_xattr_block_get(struct inode *inode,
 	struct ocfs2_xattr_value_root *xv;
 	size_t size;
 	int ret = -ENODATA, name_offset, name_len, i;
-	int uninitialized_var(block_off);
+	int block_off;
 
 	xs->bucket = ocfs2_xattr_bucket_new(inode);
 	if (!xs->bucket) {
diff --git a/fs/omfs/file.c b/fs/omfs/file.c
index bf83e6644333..ce59b2fb50c7 100644
--- a/fs/omfs/file.c
+++ b/fs/omfs/file.c
@@ -220,7 +220,7 @@ static int omfs_get_block(struct inode *inode, sector_t block,
 	struct buffer_head *bh;
 	sector_t next, offset;
 	int ret;
-	u64 uninitialized_var(new_block);
+	u64 new_block;
 	u32 max_extents;
 	int extent_count;
 	struct omfs_extent *oe;
diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
index 31f66053e239..e3d1673b8ec9 100644
--- a/fs/sysv/itree.c
+++ b/fs/sysv/itree.c
@@ -145,6 +145,10 @@ static int alloc_branch(struct inode *inode,
 		 */
 		parent = block_to_cpu(SYSV_SB(inode->i_sb), branch[n-1].key);
 		bh = sb_getblk(inode->i_sb, parent);
+		if (!bh) {
+			sysv_free_block(inode->i_sb, branch[n].key);
+			break;
+		}
 		lock_buffer(bh);
 		memset(bh->b_data, 0, blocksize);
 		branch[n].bh = bh;
diff --git a/fs/ubifs/commit.c b/fs/ubifs/commit.c
index 63f56619991d..5e82d1563c6c 100644
--- a/fs/ubifs/commit.c
+++ b/fs/ubifs/commit.c
@@ -564,11 +564,11 @@ int dbg_old_index_check_init(struct ubifs_info *c, struct ubifs_zbranch *zroot)
  */
 int dbg_check_old_index(struct ubifs_info *c, struct ubifs_zbranch *zroot)
 {
-	int lnum, offs, len, err = 0, uninitialized_var(last_level), child_cnt;
+	int lnum, offs, len, err = 0, last_level, child_cnt;
 	int first = 1, iip;
 	struct ubifs_debug_info *d = c->dbg;
-	union ubifs_key uninitialized_var(lower_key), upper_key, l_key, u_key;
-	unsigned long long uninitialized_var(last_sqnum);
+	union ubifs_key lower_key, upper_key, l_key, u_key;
+	unsigned long long last_sqnum;
 	struct ubifs_idx_node *idx;
 	struct list_head list;
 	struct idx_node *i;
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 0e9cfeca5daf..9be80631b20f 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -233,7 +233,7 @@ static int write_begin_slow(struct address_space *mapping,
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
 	pgoff_t index = pos >> PAGE_SHIFT;
 	struct ubifs_budget_req req = { .new_page = 1 };
-	int uninitialized_var(err), appending = !!(pos + len > inode->i_size);
+	int err, appending = !!(pos + len > inode->i_size);
 	struct page *page;
 
 	dbg_gen("ino %lu, pos %llu, len %u, i_size %lld",
@@ -437,7 +437,7 @@ static int ubifs_write_begin(struct file *file, struct address_space *mapping,
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	pgoff_t index = pos >> PAGE_SHIFT;
-	int uninitialized_var(err), appending = !!(pos + len > inode->i_size);
+	int err, appending = !!(pos + len > inode->i_size);
 	int skipped_read = 0;
 	struct page *page;
 
diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 69051f7a9606..a1f4e7d9b8d6 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -1355,7 +1355,7 @@ int ubifs_jnl_truncate(struct ubifs_info *c, const struct inode *inode,
 	union ubifs_key key, to_key;
 	struct ubifs_ino_node *ino;
 	struct ubifs_trun_node *trun;
-	struct ubifs_data_node *uninitialized_var(dn);
+	struct ubifs_data_node *dn;
 	int err, dlen, len, lnum, offs, bit, sz, sync = IS_SYNC(inode);
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	ino_t inum = inode->i_ino;
diff --git a/fs/ubifs/lpt.c b/fs/ubifs/lpt.c
index 9a517109da0f..dba629c3b0f8 100644
--- a/fs/ubifs/lpt.c
+++ b/fs/ubifs/lpt.c
@@ -285,7 +285,7 @@ uint32_t ubifs_unpack_bits(uint8_t **addr, int *pos, int nrbits)
 	const int k = 32 - nrbits;
 	uint8_t *p = *addr;
 	int b = *pos;
-	uint32_t uninitialized_var(val);
+	uint32_t val;
 	const int bytes = (nrbits + b + 7) >> 3;
 
 	ubifs_assert(nrbits > 0);
diff --git a/fs/ubifs/tnc.c b/fs/ubifs/tnc.c
index 20b70e178c4f..35935b265adb 100644
--- a/fs/ubifs/tnc.c
+++ b/fs/ubifs/tnc.c
@@ -899,7 +899,7 @@ static int fallible_resolve_collision(struct ubifs_info *c,
 				      int adding)
 {
 	struct ubifs_znode *o_znode = NULL, *znode = *zn;
-	int uninitialized_var(o_n), err, cmp, unsure = 0, nn = *n;
+	int o_n, err, cmp, unsure = 0, nn = *n;
 
 	cmp = fallible_matches_name(c, &znode->zbranch[nn], nm);
 	if (unlikely(cmp < 0))
@@ -1520,8 +1520,8 @@ int ubifs_tnc_locate(struct ubifs_info *c, const union ubifs_key *key,
  */
 int ubifs_tnc_get_bu_keys(struct ubifs_info *c, struct bu_info *bu)
 {
-	int n, err = 0, lnum = -1, uninitialized_var(offs);
-	int uninitialized_var(len);
+	int n, err = 0, lnum = -1, offs;
+	int len;
 	unsigned int block = key_block(c, &bu->key);
 	struct ubifs_znode *znode;
 
diff --git a/fs/ubifs/tnc_misc.c b/fs/ubifs/tnc_misc.c
index 93f5b7859e6f..d8477e8eaf22 100644
--- a/fs/ubifs/tnc_misc.c
+++ b/fs/ubifs/tnc_misc.c
@@ -136,8 +136,8 @@ int ubifs_search_zbranch(const struct ubifs_info *c,
 			 const struct ubifs_znode *znode,
 			 const union ubifs_key *key, int *n)
 {
-	int beg = 0, end = znode->child_cnt, uninitialized_var(mid);
-	int uninitialized_var(cmp);
+	int beg = 0, end = znode->child_cnt, mid;
+	int cmp;
 	const struct ubifs_zbranch *zbr = &znode->zbranch[0];
 
 	ubifs_assert(end > beg);
diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index 6f2bfbf248c9..f4f1a278771f 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -552,7 +552,7 @@ static int udf_table_new_block(struct super_block *sb,
 	uint32_t spread = 0xFFFFFFFF, nspread = 0xFFFFFFFF;
 	uint32_t newblock = 0, adsize;
 	uint32_t elen, goal_elen = 0;
-	struct kernel_lb_addr eloc, uninitialized_var(goal_eloc);
+	struct kernel_lb_addr eloc, goal_eloc;
 	struct extent_position epos, goal_epos;
 	int8_t etype;
 	struct udf_inode_info *iinfo = UDF_I(table);
diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 6503cfa44262..8f7e8f31ce9e 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -140,7 +140,7 @@ xfs_bmap_rtalloc(
 	 * pick an extent that will space things out in the rt area.
 	 */
 	if (ap->eof && ap->offset == 0) {
-		xfs_rtblock_t uninitialized_var(rtx); /* realtime extent no */
+		xfs_rtblock_t rtx; /* realtime extent no */
 
 		error = xfs_rtpick_extent(mp, ap->tp, ralen, &rtx);
 		if (error)
diff --git a/include/asm-generic/word-at-a-time.h b/include/asm-generic/word-at-a-time.h
index 20c93f08c993..95a1d214108a 100644
--- a/include/asm-generic/word-at-a-time.h
+++ b/include/asm-generic/word-at-a-time.h
@@ -38,7 +38,7 @@ static inline long find_zero(unsigned long mask)
 	return (mask >> 8) ? byte : byte + 1;
 }
 
-static inline bool has_zero(unsigned long val, unsigned long *data, const struct word_at_a_time *c)
+static inline unsigned long has_zero(unsigned long val, unsigned long *data, const struct word_at_a_time *c)
 {
 	unsigned long rhs = val | c->low_bits;
 	*data = rhs;
diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 50d143995338..5ef76f8cf080 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -189,7 +189,7 @@ u64 hw_nmi_get_sample_period(int watchdog_thresh);
 #endif
 
 #if defined(CONFIG_HARDLOCKUP_CHECK_TIMESTAMP) && \
-    defined(CONFIG_HARDLOCKUP_DETECTOR)
+    defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
 void watchdog_update_hrtimer_threshold(u64 period);
 #else
 static inline void watchdog_update_hrtimer_threshold(u64 period) { }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 521030233c8d..7f93c3919947 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1630,6 +1630,7 @@ static inline struct pci_dev *pci_get_class(unsigned int class,
 #define pci_dev_put(dev)	do { } while (0)
 
 static inline void pci_set_master(struct pci_dev *dev) { }
+static inline void pci_clear_master(struct pci_dev *dev) { }
 static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; }
 static inline void pci_disable_device(struct pci_dev *dev) { }
 static inline int pci_assign_resource(struct pci_dev *dev, int i)
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index bcaba7e8ca6e..916f4807cc9a 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -119,7 +119,7 @@ struct signal_struct {
 #ifdef CONFIG_POSIX_TIMERS
 
 	/* POSIX.1b Interval Timers */
-	int			posix_timer_id;
+	unsigned int		next_posix_timer_id;
 	struct list_head	posix_timers;
 
 	/* ITIMER_REAL timer for the process */
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 791a6be0e394..f539d91ffd3a 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -99,7 +99,6 @@ struct uart_8250_port {
 	struct list_head	list;		/* ports on this IRQ */
 	u32			capabilities;	/* port capabilities */
 	unsigned short		bugs;		/* port bugs */
-	bool			fifo_bug;	/* min RX trigger if enabled */
 	unsigned int		tx_loadsz;	/* transmit fifo load size */
 	unsigned char		acr;
 	unsigned char		fcr;
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index b9bc6e3e4ef9..45a85277c2ea 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -425,7 +425,7 @@ static inline void fastopen_queue_tune(struct sock *sk, int backlog)
 	struct request_sock_queue *queue = &inet_csk(sk)->icsk_accept_queue;
 	int somaxconn = READ_ONCE(sock_net(sk)->core.sysctl_somaxconn);
 
-	queue->fastopenq.max_qlen = min_t(unsigned int, backlog, somaxconn);
+	WRITE_ONCE(queue->fastopenq.max_qlen, min_t(unsigned int, backlog, somaxconn));
 }
 
 static inline void tcp_move_syn(struct tcp_sock *tp,
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 1c527abb1ae5..f25f88823d9a 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -72,7 +72,6 @@ enum {
 	WORK_OFFQ_FLAG_BASE	= WORK_STRUCT_COLOR_SHIFT,
 
 	__WORK_OFFQ_CANCELING	= WORK_OFFQ_FLAG_BASE,
-	WORK_OFFQ_CANCELING	= (1 << __WORK_OFFQ_CANCELING),
 
 	/*
 	 * When a work item is off queue, its high bits point to the last
@@ -83,12 +82,6 @@ enum {
 	WORK_OFFQ_POOL_SHIFT	= WORK_OFFQ_FLAG_BASE + WORK_OFFQ_FLAG_BITS,
 	WORK_OFFQ_LEFT		= BITS_PER_LONG - WORK_OFFQ_POOL_SHIFT,
 	WORK_OFFQ_POOL_BITS	= WORK_OFFQ_LEFT <= 31 ? WORK_OFFQ_LEFT : 31,
-	WORK_OFFQ_POOL_NONE	= (1LU << WORK_OFFQ_POOL_BITS) - 1,
-
-	/* convenience constants */
-	WORK_STRUCT_FLAG_MASK	= (1UL << WORK_STRUCT_FLAG_BITS) - 1,
-	WORK_STRUCT_WQ_DATA_MASK = ~WORK_STRUCT_FLAG_MASK,
-	WORK_STRUCT_NO_POOL	= (unsigned long)WORK_OFFQ_POOL_NONE << WORK_OFFQ_POOL_SHIFT,
 
 	/* bit mask for work_busy() return values */
 	WORK_BUSY_PENDING	= 1 << 0,
@@ -98,6 +91,14 @@ enum {
 	WORKER_DESC_LEN		= 24,
 };
 
+/* Convenience constants - of type 'unsigned long', not 'enum'! */
+#define WORK_OFFQ_CANCELING	(1ul << __WORK_OFFQ_CANCELING)
+#define WORK_OFFQ_POOL_NONE	((1ul << WORK_OFFQ_POOL_BITS) - 1)
+#define WORK_STRUCT_NO_POOL	(WORK_OFFQ_POOL_NONE << WORK_OFFQ_POOL_SHIFT)
+
+#define WORK_STRUCT_FLAG_MASK    ((1ul << WORK_STRUCT_FLAG_BITS) - 1)
+#define WORK_STRUCT_WQ_DATA_MASK (~WORK_STRUCT_FLAG_MASK)
+
 struct work_struct {
 	atomic_long_t data;
 	struct list_head entry;
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 7f7e90c1992f..f127b9a1a307 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -540,12 +540,8 @@ static inline u32 ipv6_addr_hash(const struct in6_addr *a)
 /* more secured version of ipv6_addr_hash() */
 static inline u32 __ipv6_addr_jhash(const struct in6_addr *a, const u32 initval)
 {
-	u32 v = (__force u32)a->s6_addr32[0] ^ (__force u32)a->s6_addr32[1];
-
-	return jhash_3words(v,
-			    (__force u32)a->s6_addr32[2],
-			    (__force u32)a->s6_addr32[3],
-			    initval);
+	return jhash2((__force const u32 *)a->s6_addr32,
+		      ARRAY_SIZE(a->s6_addr32), initval);
 }
 
 static inline bool ipv6_addr_loopback(const struct in6_addr *a)
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 0d625ff7841a..d5e933e6a611 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -725,6 +725,7 @@ struct nft_expr_type {
 
 enum nft_trans_phase {
 	NFT_TRANS_PREPARE,
+	NFT_TRANS_PREPARE_ERROR,
 	NFT_TRANS_ABORT,
 	NFT_TRANS_COMMIT,
 	NFT_TRANS_RELEASE
diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index 85e059d3bc23..7b6024f2d4ea 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -133,7 +133,7 @@ extern const struct nla_policy rtm_tca_policy[TCA_MAX + 1];
  */
 static inline unsigned int psched_mtu(const struct net_device *dev)
 {
-	return dev->mtu + dev->hard_header_len;
+	return READ_ONCE(dev->mtu) + dev->hard_header_len;
 }
 
 static inline bool is_classid_clsact_ingress(u32 classid)
diff --git a/include/net/sock.h b/include/net/sock.h
index eccec5df94b9..def9dc1ddda1 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1738,6 +1738,7 @@ static inline void sock_graft(struct sock *sk, struct socket *parent)
 }
 
 kuid_t sock_i_uid(struct sock *sk);
+unsigned long __sock_i_ino(struct sock *sk);
 unsigned long sock_i_ino(struct sock *sk);
 
 static inline kuid_t sock_net_uid(const struct net *net, const struct sock *sk)
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4f97c0e2d5f3..b1a9e6b1a153 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1887,7 +1887,11 @@ void __tcp_v4_send_check(struct sk_buff *skb, __be32 saddr, __be32 daddr);
 static inline u32 tcp_notsent_lowat(const struct tcp_sock *tp)
 {
 	struct net *net = sock_net((struct sock *)tp);
-	return tp->notsent_lowat ?: READ_ONCE(net->ipv4.sysctl_tcp_notsent_lowat);
+	u32 val;
+
+	val = READ_ONCE(tp->notsent_lowat);
+
+	return val ?: READ_ONCE(net->ipv4.sysctl_tcp_notsent_lowat);
 }
 
 static inline bool tcp_stream_memory_free(const struct sock *sk)
diff --git a/include/uapi/linux/affs_hardblocks.h b/include/uapi/linux/affs_hardblocks.h
index 5e2fb8481252..a5aff2eb5f70 100644
--- a/include/uapi/linux/affs_hardblocks.h
+++ b/include/uapi/linux/affs_hardblocks.h
@@ -7,42 +7,42 @@
 /* Just the needed definitions for the RDB of an Amiga HD. */
 
 struct RigidDiskBlock {
-	__u32	rdb_ID;
+	__be32	rdb_ID;
 	__be32	rdb_SummedLongs;
-	__s32	rdb_ChkSum;
-	__u32	rdb_HostID;
+	__be32	rdb_ChkSum;
+	__be32	rdb_HostID;
 	__be32	rdb_BlockBytes;
-	__u32	rdb_Flags;
-	__u32	rdb_BadBlockList;
+	__be32	rdb_Flags;
+	__be32	rdb_BadBlockList;
 	__be32	rdb_PartitionList;
-	__u32	rdb_FileSysHeaderList;
-	__u32	rdb_DriveInit;
-	__u32	rdb_Reserved1[6];
-	__u32	rdb_Cylinders;
-	__u32	rdb_Sectors;
-	__u32	rdb_Heads;
-	__u32	rdb_Interleave;
-	__u32	rdb_Park;
-	__u32	rdb_Reserved2[3];
-	__u32	rdb_WritePreComp;
-	__u32	rdb_ReducedWrite;
-	__u32	rdb_StepRate;
-	__u32	rdb_Reserved3[5];
-	__u32	rdb_RDBBlocksLo;
-	__u32	rdb_RDBBlocksHi;
-	__u32	rdb_LoCylinder;
-	__u32	rdb_HiCylinder;
-	__u32	rdb_CylBlocks;
-	__u32	rdb_AutoParkSeconds;
-	__u32	rdb_HighRDSKBlock;
-	__u32	rdb_Reserved4;
+	__be32	rdb_FileSysHeaderList;
+	__be32	rdb_DriveInit;
+	__be32	rdb_Reserved1[6];
+	__be32	rdb_Cylinders;
+	__be32	rdb_Sectors;
+	__be32	rdb_Heads;
+	__be32	rdb_Interleave;
+	__be32	rdb_Park;
+	__be32	rdb_Reserved2[3];
+	__be32	rdb_WritePreComp;
+	__be32	rdb_ReducedWrite;
+	__be32	rdb_StepRate;
+	__be32	rdb_Reserved3[5];
+	__be32	rdb_RDBBlocksLo;
+	__be32	rdb_RDBBlocksHi;
+	__be32	rdb_LoCylinder;
+	__be32	rdb_HiCylinder;
+	__be32	rdb_CylBlocks;
+	__be32	rdb_AutoParkSeconds;
+	__be32	rdb_HighRDSKBlock;
+	__be32	rdb_Reserved4;
 	char	rdb_DiskVendor[8];
 	char	rdb_DiskProduct[16];
 	char	rdb_DiskRevision[4];
 	char	rdb_ControllerVendor[8];
 	char	rdb_ControllerProduct[16];
 	char	rdb_ControllerRevision[4];
-	__u32	rdb_Reserved5[10];
+	__be32	rdb_Reserved5[10];
 };
 
 #define	IDNAME_RIGIDDISK	0x5244534B	/* "RDSK" */
@@ -50,16 +50,16 @@ struct RigidDiskBlock {
 struct PartitionBlock {
 	__be32	pb_ID;
 	__be32	pb_SummedLongs;
-	__s32	pb_ChkSum;
-	__u32	pb_HostID;
+	__be32	pb_ChkSum;
+	__be32	pb_HostID;
 	__be32	pb_Next;
-	__u32	pb_Flags;
-	__u32	pb_Reserved1[2];
-	__u32	pb_DevFlags;
+	__be32	pb_Flags;
+	__be32	pb_Reserved1[2];
+	__be32	pb_DevFlags;
 	__u8	pb_DriveName[32];
-	__u32	pb_Reserved2[15];
+	__be32	pb_Reserved2[15];
 	__be32	pb_Environment[17];
-	__u32	pb_EReserved[15];
+	__be32	pb_EReserved[15];
 };
 
 #define	IDNAME_PARTITION	0x50415254	/* "PART" */
diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
index e3c70fe6bf0f..f5e619abcc9a 100644
--- a/include/uapi/linux/blkzoned.h
+++ b/include/uapi/linux/blkzoned.h
@@ -51,13 +51,13 @@ enum blk_zone_type {
  *
  * The Zone Condition state machine in the ZBC/ZAC standards maps the above
  * deinitions as:
- *   - ZC1: Empty         | BLK_ZONE_EMPTY
+ *   - ZC1: Empty         | BLK_ZONE_COND_EMPTY
  *   - ZC2: Implicit Open | BLK_ZONE_COND_IMP_OPEN
  *   - ZC3: Explicit Open | BLK_ZONE_COND_EXP_OPEN
- *   - ZC4: Closed        | BLK_ZONE_CLOSED
- *   - ZC5: Full          | BLK_ZONE_FULL
- *   - ZC6: Read Only     | BLK_ZONE_READONLY
- *   - ZC7: Offline       | BLK_ZONE_OFFLINE
+ *   - ZC4: Closed        | BLK_ZONE_COND_CLOSED
+ *   - ZC5: Full          | BLK_ZONE_COND_FULL
+ *   - ZC6: Read Only     | BLK_ZONE_COND_READONLY
+ *   - ZC7: Offline       | BLK_ZONE_COND_OFFLINE
  *
  * Conditions 0x5 to 0xC are reserved by the current ZBC/ZAC spec and should
  * be considered invalid.
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index b8fd2c303ed0..2ada2122d274 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -1484,7 +1484,7 @@ struct v4l2_input {
 	__u8	     name[32];		/*  Label */
 	__u32	     type;		/*  Type of input */
 	__u32	     audioset;		/*  Associated audios (bitfield) */
-	__u32        tuner;             /*  enum v4l2_tuner_type */
+	__u32        tuner;             /*  Tuner index */
 	v4l2_std_id  std;
 	__u32	     status;
 	__u32	     capabilities;
diff --git a/kernel/async.c b/kernel/async.c
index 4bf1b00a28d8..e59bd2240cb8 100644
--- a/kernel/async.c
+++ b/kernel/async.c
@@ -115,7 +115,7 @@ static void async_run_entry_fn(struct work_struct *work)
 	struct async_entry *entry =
 		container_of(work, struct async_entry, work);
 	unsigned long flags;
-	ktime_t uninitialized_var(calltime), delta, rettime;
+	ktime_t calltime, delta, rettime;
 
 	/* 1) run (and print duration) */
 	if (initcall_debug && system_state < SYSTEM_RUNNING) {
@@ -283,7 +283,7 @@ EXPORT_SYMBOL_GPL(async_synchronize_full_domain);
  */
 void async_synchronize_cookie_domain(async_cookie_t cookie, struct async_domain *domain)
 {
-	ktime_t uninitialized_var(starttime), delta, endtime;
+	ktime_t starttime, delta, endtime;
 
 	if (initcall_debug && system_state < SYSTEM_RUNNING) {
 		pr_debug("async_waiting @ %i\n", task_pid_nr(current));
diff --git a/kernel/audit.c b/kernel/audit.c
index 0ad61f5da661..b694a265533f 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1728,7 +1728,7 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 {
 	struct audit_buffer *ab;
 	struct timespec64 t;
-	unsigned int uninitialized_var(serial);
+	unsigned int serial;
 
 	if (audit_initialized != AUDIT_INITIALIZED)
 		return NULL;
diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
index 9b5eeff72fd3..39a0e768adc3 100644
--- a/kernel/bpf/bpf_lru_list.c
+++ b/kernel/bpf/bpf_lru_list.c
@@ -44,7 +44,12 @@ static struct list_head *local_pending_list(struct bpf_lru_locallist *loc_l)
 /* bpf_lru_node helpers */
 static bool bpf_lru_node_is_ref(const struct bpf_lru_node *node)
 {
-	return node->ref;
+	return READ_ONCE(node->ref);
+}
+
+static void bpf_lru_node_clear_ref(struct bpf_lru_node *node)
+{
+	WRITE_ONCE(node->ref, 0);
 }
 
 static void bpf_lru_list_count_inc(struct bpf_lru_list *l,
@@ -92,7 +97,7 @@ static void __bpf_lru_node_move_in(struct bpf_lru_list *l,
 
 	bpf_lru_list_count_inc(l, tgt_type);
 	node->type = tgt_type;
-	node->ref = 0;
+	bpf_lru_node_clear_ref(node);
 	list_move(&node->list, &l->lists[tgt_type]);
 }
 
@@ -113,7 +118,7 @@ static void __bpf_lru_node_move(struct bpf_lru_list *l,
 		bpf_lru_list_count_inc(l, tgt_type);
 		node->type = tgt_type;
 	}
-	node->ref = 0;
+	bpf_lru_node_clear_ref(node);
 
 	/* If the moving node is the next_inactive_rotation candidate,
 	 * move the next_inactive_rotation pointer also.
@@ -356,7 +361,7 @@ static void __local_list_add_pending(struct bpf_lru *lru,
 	*(u32 *)((void *)node + lru->hash_offset) = hash;
 	node->cpu = cpu;
 	node->type = BPF_LRU_LOCAL_LIST_T_PENDING;
-	node->ref = 0;
+	bpf_lru_node_clear_ref(node);
 	list_add(&node->list, local_pending_list(loc_l));
 }
 
@@ -422,7 +427,7 @@ static struct bpf_lru_node *bpf_percpu_lru_pop_free(struct bpf_lru *lru,
 	if (!list_empty(free_list)) {
 		node = list_first_entry(free_list, struct bpf_lru_node, list);
 		*(u32 *)((void *)node + lru->hash_offset) = hash;
-		node->ref = 0;
+		bpf_lru_node_clear_ref(node);
 		__bpf_lru_node_move(l, node, BPF_LRU_LIST_T_INACTIVE);
 	}
 
@@ -525,7 +530,7 @@ static void bpf_common_lru_push_free(struct bpf_lru *lru,
 		}
 
 		node->type = BPF_LRU_LOCAL_LIST_T_FREE;
-		node->ref = 0;
+		bpf_lru_node_clear_ref(node);
 		list_move(&node->list, local_free_list(loc_l));
 
 		raw_spin_unlock_irqrestore(&loc_l->lock, flags);
@@ -571,7 +576,7 @@ static void bpf_common_lru_populate(struct bpf_lru *lru, void *buf,
 
 		node = (struct bpf_lru_node *)(buf + node_offset);
 		node->type = BPF_LRU_LIST_T_FREE;
-		node->ref = 0;
+		bpf_lru_node_clear_ref(node);
 		list_add(&node->list, &l->lists[BPF_LRU_LIST_T_FREE]);
 		buf += elem_size;
 	}
@@ -597,7 +602,7 @@ static void bpf_percpu_lru_populate(struct bpf_lru *lru, void *buf,
 		node = (struct bpf_lru_node *)(buf + node_offset);
 		node->cpu = cpu;
 		node->type = BPF_LRU_LIST_T_FREE;
-		node->ref = 0;
+		bpf_lru_node_clear_ref(node);
 		list_add(&node->list, &l->lists[BPF_LRU_LIST_T_FREE]);
 		i++;
 		buf += elem_size;
diff --git a/kernel/bpf/bpf_lru_list.h b/kernel/bpf/bpf_lru_list.h
index 7d4f89b7cb84..08da78b59f0b 100644
--- a/kernel/bpf/bpf_lru_list.h
+++ b/kernel/bpf/bpf_lru_list.h
@@ -66,11 +66,8 @@ struct bpf_lru {
 
 static inline void bpf_lru_node_set_ref(struct bpf_lru_node *node)
 {
-	/* ref is an approximation on access frequency.  It does not
-	 * have to be very accurate.  Hence, no protection is used.
-	 */
-	if (!node->ref)
-		node->ref = 1;
+	if (!READ_ONCE(node->ref))
+		WRITE_ONCE(node->ref, 1);
 }
 
 int bpf_lru_init(struct bpf_lru *lru, bool percpu, u32 hash_offset,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 20ba0d90e8ae..6e15f3a9696a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1096,6 +1096,11 @@ static int perf_mux_hrtimer_restart(struct perf_cpu_context *cpuctx)
 	return 0;
 }
 
+static int perf_mux_hrtimer_restart_ipi(void *arg)
+{
+	return perf_mux_hrtimer_restart(arg);
+}
+
 void perf_pmu_disable(struct pmu *pmu)
 {
 	int *count = this_cpu_ptr(pmu->pmu_disable_count);
@@ -9142,8 +9147,7 @@ perf_event_mux_interval_ms_store(struct device *dev,
 		cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
 		cpuctx->hrtimer_interval = ns_to_ktime(NSEC_PER_MSEC * timer);
 
-		cpu_function_call(cpu,
-			(remote_function_f)perf_mux_hrtimer_restart, cpuctx);
+		cpu_function_call(cpu, perf_mux_hrtimer_restart_ipi, cpuctx);
 	}
 	cpus_read_unlock();
 	mutex_unlock(&mux_interval_mutex);
@@ -10043,7 +10047,7 @@ SYSCALL_DEFINE5(perf_event_open,
 	struct perf_event *group_leader = NULL, *output_event = NULL;
 	struct perf_event *event, *sibling;
 	struct perf_event_attr attr;
-	struct perf_event_context *ctx, *uninitialized_var(gctx);
+	struct perf_event_context *ctx, *gctx;
 	struct file *event_file = NULL;
 	struct fd group = {NULL, 0};
 	struct task_struct *task = NULL;
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index f08ba79ee5d1..0559b36b06e1 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1883,7 +1883,7 @@ static void handle_swbp(struct pt_regs *regs)
 {
 	struct uprobe *uprobe;
 	unsigned long bp_vaddr;
-	int uninitialized_var(is_swbp);
+	int is_swbp;
 
 	bp_vaddr = uprobe_get_swbp_addr(regs);
 	if (bp_vaddr == get_trampoline_vaddr())
diff --git a/kernel/exit.c b/kernel/exit.c
index c0ff4461643d..38dc916c94fa 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -139,7 +139,7 @@ static void __exit_signal(struct task_struct *tsk)
 	struct signal_struct *sig = tsk->signal;
 	bool group_dead = thread_group_leader(tsk);
 	struct sighand_struct *sighand;
-	struct tty_struct *uninitialized_var(tty);
+	struct tty_struct *tty;
 	u64 utime, stime;
 
 	sighand = rcu_dereference_check(tsk->sighand,
diff --git a/kernel/futex.c b/kernel/futex.c
index e282c083df59..97bfa29f141a 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1416,7 +1416,7 @@ static int lookup_pi_state(u32 __user *uaddr, u32 uval,
 static int lock_pi_update_atomic(u32 __user *uaddr, u32 uval, u32 newval)
 {
 	int err;
-	u32 uninitialized_var(curval);
+	u32 curval;
 
 	if (unlikely(should_fail_futex(true)))
 		return -EFAULT;
@@ -1587,7 +1587,7 @@ static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
  */
 static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state *pi_state)
 {
-	u32 uninitialized_var(curval), newval;
+	u32 curval, newval;
 	struct task_struct *new_owner;
 	bool postunlock = false;
 	DEFINE_WAKE_Q(wake_q);
@@ -3101,7 +3101,7 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
  */
 static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 {
-	u32 uninitialized_var(curval), uval, vpid = task_pid_vnr(current);
+	u32 curval, uval, vpid = task_pid_vnr(current);
 	union futex_key key = FUTEX_KEY_INIT;
 	struct futex_hash_bucket *hb;
 	struct futex_q *top_waiter;
@@ -3576,7 +3576,7 @@ SYSCALL_DEFINE3(get_robust_list, int, pid,
 static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr,
 			      bool pi, bool pending_op)
 {
-	u32 uval, uninitialized_var(nval), mval;
+	u32 uval, nval, mval;
 	int err;
 
 	/* Futex address must be 32bit aligned */
@@ -3706,7 +3706,7 @@ static void exit_robust_list(struct task_struct *curr)
 	struct robust_list_head __user *head = curr->robust_list;
 	struct robust_list __user *entry, *next_entry, *pending;
 	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip;
-	unsigned int uninitialized_var(next_pi);
+	unsigned int next_pi;
 	unsigned long futex_offset;
 	int rc;
 
@@ -4003,7 +4003,7 @@ static void compat_exit_robust_list(struct task_struct *curr)
 	struct compat_robust_list_head __user *head = curr->compat_robust_list;
 	struct robust_list __user *entry, *next_entry, *pending;
 	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip;
-	unsigned int uninitialized_var(next_pi);
+	unsigned int next_pi;
 	compat_uptr_t uentry, next_uentry, upending;
 	compat_long_t futex_offset;
 	int rc;
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 27cf24e285e0..3d87dcbb9cbd 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1016,6 +1016,7 @@ int crash_shrink_memory(unsigned long new_size)
 	start = crashk_res.start;
 	end = crashk_res.end;
 	old_size = (end == 0) ? 0 : end - start + 1;
+	new_size = roundup(new_size, KEXEC_CRASH_MEM_ALIGN);
 	if (new_size >= old_size) {
 		ret = (new_size == old_size) ? 0 : -EINVAL;
 		goto unlock;
@@ -1027,9 +1028,7 @@ int crash_shrink_memory(unsigned long new_size)
 		goto unlock;
 	}
 
-	start = roundup(start, KEXEC_CRASH_MEM_ALIGN);
-	end = roundup(start + new_size, KEXEC_CRASH_MEM_ALIGN);
-
+	end = start + new_size;
 	crash_free_reserved_phys_range(end, crashk_res.end);
 
 	if ((start == end) && (crashk_res.parent != NULL))
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index ac0725b1ada7..cd93b15aa558 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1282,7 +1282,7 @@ static int noop_count(struct lock_list *entry, void *data)
 static unsigned long __lockdep_count_forward_deps(struct lock_list *this)
 {
 	unsigned long  count = 0;
-	struct lock_list *uninitialized_var(target_entry);
+	struct lock_list *target_entry;
 
 	__bfs_forwards(this, (void *)&count, noop_count, &target_entry);
 
@@ -1310,7 +1310,7 @@ unsigned long lockdep_count_forward_deps(struct lock_class *class)
 static unsigned long __lockdep_count_backward_deps(struct lock_list *this)
 {
 	unsigned long  count = 0;
-	struct lock_list *uninitialized_var(target_entry);
+	struct lock_list *target_entry;
 
 	__bfs_backwards(this, (void *)&count, noop_count, &target_entry);
 
@@ -2706,7 +2706,7 @@ check_usage_backwards(struct task_struct *curr, struct held_lock *this,
 {
 	int ret;
 	struct lock_list root;
-	struct lock_list *uninitialized_var(target_entry);
+	struct lock_list *target_entry;
 
 	root.parent = NULL;
 	root.class = hlock_class(this);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 259996d2dcf7..9d1e7b0bf486 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8142,7 +8142,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 		.sd		= sd,
 		.dst_cpu	= this_cpu,
 		.dst_rq		= this_rq,
-		.dst_grpmask    = sched_group_span(sd->groups),
+		.dst_grpmask    = group_balance_mask(sd->groups),
 		.idle		= idle,
 		.loop_break	= sched_nr_migrate_break,
 		.cpus		= cpus,
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 8b90abd69073..309c551ac18f 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -168,25 +168,30 @@ static struct k_itimer *posix_timer_by_id(timer_t id)
 static int posix_timer_add(struct k_itimer *timer)
 {
 	struct signal_struct *sig = current->signal;
-	int first_free_id = sig->posix_timer_id;
 	struct hlist_head *head;
-	int ret = -ENOENT;
+	unsigned int cnt, id;
 
-	do {
+	/*
+	 * FIXME: Replace this by a per signal struct xarray once there is
+	 * a plan to handle the resulting CRIU regression gracefully.
+	 */
+	for (cnt = 0; cnt <= INT_MAX; cnt++) {
 		spin_lock(&hash_lock);
-		head = &posix_timers_hashtable[hash(sig, sig->posix_timer_id)];
-		if (!__posix_timers_find(head, sig, sig->posix_timer_id)) {
+		id = sig->next_posix_timer_id;
+
+		/* Write the next ID back. Clamp it to the positive space */
+		sig->next_posix_timer_id = (id + 1) & INT_MAX;
+
+		head = &posix_timers_hashtable[hash(sig, id)];
+		if (!__posix_timers_find(head, sig, id)) {
 			hlist_add_head_rcu(&timer->t_hash, head);
-			ret = sig->posix_timer_id;
+			spin_unlock(&hash_lock);
+			return id;
 		}
-		if (++sig->posix_timer_id < 0)
-			sig->posix_timer_id = 0;
-		if ((sig->posix_timer_id == first_free_id) && (ret == -ENOENT))
-			/* Loop over all possible ids completed */
-			ret = -EAGAIN;
 		spin_unlock(&hash_lock);
-	} while (ret == -ENOENT);
-	return ret;
+	}
+	/* POSIX return code when no timer ID could be allocated */
+	return -EAGAIN;
 }
 
 static inline void unlock_timer(struct k_itimer *timr, unsigned long flags)
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index f234c63b59fc..1949d7bbe145 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -464,6 +464,8 @@ struct ring_buffer_per_cpu {
 	unsigned long			read_bytes;
 	u64				write_stamp;
 	u64				read_stamp;
+	/* pages removed since last reset */
+	unsigned long			pages_removed;
 	/* ring buffer pages to update, > 0 to add, < 0 to remove */
 	long				nr_pages_to_update;
 	struct list_head		new_pages; /* new pages to add */
@@ -498,6 +500,7 @@ struct ring_buffer_iter {
 	struct buffer_page		*head_page;
 	struct buffer_page		*cache_reader_page;
 	unsigned long			cache_read;
+	unsigned long			cache_pages_removed;
 	u64				read_stamp;
 };
 
@@ -531,7 +534,7 @@ static void rb_wake_up_waiters(struct irq_work *work)
  */
 int ring_buffer_wait(struct ring_buffer *buffer, int cpu, bool full)
 {
-	struct ring_buffer_per_cpu *uninitialized_var(cpu_buffer);
+	struct ring_buffer_per_cpu *cpu_buffer;
 	DEFINE_WAIT(wait);
 	struct rb_irq_work *work;
 	int ret = 0;
@@ -1447,6 +1450,8 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 		to_remove = rb_list_head(to_remove)->next;
 		head_bit |= (unsigned long)to_remove & RB_PAGE_HEAD;
 	}
+	/* Read iterators need to reset themselves when some pages removed */
+	cpu_buffer->pages_removed += nr_removed;
 
 	next_page = rb_list_head(to_remove)->next;
 
@@ -1468,12 +1473,6 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 		cpu_buffer->head_page = list_entry(next_page,
 						struct buffer_page, list);
 
-	/*
-	 * change read pointer to make sure any read iterators reset
-	 * themselves
-	 */
-	cpu_buffer->read = 0;
-
 	/* pages are removed, resume tracing and then free the pages */
 	atomic_dec(&cpu_buffer->record_disabled);
 	raw_spin_unlock_irq(&cpu_buffer->reader_lock);
@@ -3464,6 +3463,7 @@ static void rb_iter_reset(struct ring_buffer_iter *iter)
 
 	iter->cache_reader_page = iter->head_page;
 	iter->cache_read = cpu_buffer->read;
+	iter->cache_pages_removed = cpu_buffer->pages_removed;
 
 	if (iter->head)
 		iter->read_stamp = cpu_buffer->read_stamp;
@@ -3896,12 +3896,13 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 	buffer = cpu_buffer->buffer;
 
 	/*
-	 * Check if someone performed a consuming read to
-	 * the buffer. A consuming read invalidates the iterator
-	 * and we need to reset the iterator in this case.
+	 * Check if someone performed a consuming read to the buffer
+	 * or removed some pages from the buffer. In these cases,
+	 * iterator was invalidated and we need to reset it.
 	 */
 	if (unlikely(iter->cache_read != cpu_buffer->read ||
-		     iter->cache_reader_page != cpu_buffer->reader_page))
+		     iter->cache_reader_page != cpu_buffer->reader_page ||
+		     iter->cache_pages_removed != cpu_buffer->pages_removed))
 		rb_iter_reset(iter);
 
  again:
@@ -4277,28 +4278,34 @@ unsigned long ring_buffer_size(struct ring_buffer *buffer, int cpu)
 }
 EXPORT_SYMBOL_GPL(ring_buffer_size);
 
+static void rb_clear_buffer_page(struct buffer_page *page)
+{
+	local_set(&page->write, 0);
+	local_set(&page->entries, 0);
+	rb_init_page(page->page);
+	page->read = 0;
+}
+
 static void
 rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 {
+	struct buffer_page *page;
+
 	rb_head_page_deactivate(cpu_buffer);
 
 	cpu_buffer->head_page
 		= list_entry(cpu_buffer->pages, struct buffer_page, list);
-	local_set(&cpu_buffer->head_page->write, 0);
-	local_set(&cpu_buffer->head_page->entries, 0);
-	local_set(&cpu_buffer->head_page->page->commit, 0);
-
-	cpu_buffer->head_page->read = 0;
+	rb_clear_buffer_page(cpu_buffer->head_page);
+	list_for_each_entry(page, cpu_buffer->pages, list) {
+		rb_clear_buffer_page(page);
+	}
 
 	cpu_buffer->tail_page = cpu_buffer->head_page;
 	cpu_buffer->commit_page = cpu_buffer->head_page;
 
 	INIT_LIST_HEAD(&cpu_buffer->reader_page->list);
 	INIT_LIST_HEAD(&cpu_buffer->new_pages);
-	local_set(&cpu_buffer->reader_page->write, 0);
-	local_set(&cpu_buffer->reader_page->entries, 0);
-	local_set(&cpu_buffer->reader_page->page->commit, 0);
-	cpu_buffer->reader_page->read = 0;
+	rb_clear_buffer_page(cpu_buffer->reader_page);
 
 	local_set(&cpu_buffer->entries_bytes, 0);
 	local_set(&cpu_buffer->overrun, 0);
@@ -4317,6 +4324,7 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 	cpu_buffer->last_overrun = 0;
 
 	rb_head_page_activate(cpu_buffer);
+	cpu_buffer->pages_removed = 0;
 }
 
 /**
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 1285ef6e2d14..37be6913cfb2 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -370,7 +370,6 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 {
 	struct trace_event_call *call = file->event_call;
 	struct trace_array *tr = file->tr;
-	unsigned long file_flags = file->flags;
 	int ret = 0;
 	int disable;
 
@@ -394,6 +393,8 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 				break;
 			disable = file->flags & EVENT_FILE_FL_SOFT_DISABLED;
 			clear_bit(EVENT_FILE_FL_SOFT_MODE_BIT, &file->flags);
+			/* Disable use of trace_buffered_event */
+			trace_buffered_event_disable();
 		} else
 			disable = !(file->flags & EVENT_FILE_FL_SOFT_MODE);
 
@@ -432,6 +433,8 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 			if (atomic_inc_return(&file->sm_ref) > 1)
 				break;
 			set_bit(EVENT_FILE_FL_SOFT_MODE_BIT, &file->flags);
+			/* Enable use of trace_buffered_event */
+			trace_buffered_event_enable();
 		}
 
 		if (!(file->flags & EVENT_FILE_FL_ENABLED)) {
@@ -471,15 +474,6 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 		break;
 	}
 
-	/* Enable or disable use of trace_buffered_event */
-	if ((file_flags & EVENT_FILE_FL_SOFT_DISABLED) !=
-	    (file->flags & EVENT_FILE_FL_SOFT_DISABLED)) {
-		if (file->flags & EVENT_FILE_FL_SOFT_DISABLED)
-			trace_buffered_event_enable();
-		else
-			trace_buffered_event_disable();
-	}
-
 	return ret;
 }
 
diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 4ece6028007a..4c2cd69013a6 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -114,14 +114,14 @@ static void watchdog_overflow_callback(struct perf_event *event,
 	/* Ensure the watchdog never gets throttled */
 	event->hw.interrupts = 0;
 
+	if (!watchdog_check_timestamp())
+		return;
+
 	if (__this_cpu_read(watchdog_nmi_touch) == true) {
 		__this_cpu_write(watchdog_nmi_touch, false);
 		return;
 	}
 
-	if (!watchdog_check_timestamp())
-		return;
-
 	/* check for a hardlockup
 	 * This is done by making sure our timer interrupt
 	 * is incrementing.  The timer interrupt should have
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index cf5d8fd7472e..87eca8d1faad 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -682,12 +682,17 @@ static void clear_work_data(struct work_struct *work)
 	set_work_data(work, WORK_STRUCT_NO_POOL, 0);
 }
 
+static inline struct pool_workqueue *work_struct_pwq(unsigned long data)
+{
+	return (struct pool_workqueue *)(data & WORK_STRUCT_WQ_DATA_MASK);
+}
+
 static struct pool_workqueue *get_work_pwq(struct work_struct *work)
 {
 	unsigned long data = atomic_long_read(&work->data);
 
 	if (data & WORK_STRUCT_PWQ)
-		return (void *)(data & WORK_STRUCT_WQ_DATA_MASK);
+		return work_struct_pwq(data);
 	else
 		return NULL;
 }
@@ -715,8 +720,7 @@ static struct worker_pool *get_work_pool(struct work_struct *work)
 	assert_rcu_or_pool_mutex();
 
 	if (data & WORK_STRUCT_PWQ)
-		return ((struct pool_workqueue *)
-			(data & WORK_STRUCT_WQ_DATA_MASK))->pool;
+		return work_struct_pwq(data)->pool;
 
 	pool_id = data >> WORK_OFFQ_POOL_SHIFT;
 	if (pool_id == WORK_OFFQ_POOL_NONE)
@@ -737,8 +741,7 @@ static int get_work_pool_id(struct work_struct *work)
 	unsigned long data = atomic_long_read(&work->data);
 
 	if (data & WORK_STRUCT_PWQ)
-		return ((struct pool_workqueue *)
-			(data & WORK_STRUCT_WQ_DATA_MASK))->pool->id;
+		return work_struct_pwq(data)->pool->id;
 
 	return data >> WORK_OFFQ_POOL_SHIFT;
 }
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index bacb00a9cd9f..b6217c797554 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -280,6 +280,15 @@ static void debug_print_object(struct debug_obj *obj, char *msg)
 	struct debug_obj_descr *descr = obj->descr;
 	static int limit;
 
+	/*
+	 * Don't report if lookup_object_or_alloc() by the current thread
+	 * failed because lookup_object_or_alloc()/debug_objects_oom() by a
+	 * concurrent thread turned off debug_objects_enabled and cleared
+	 * the hash buckets.
+	 */
+	if (!debug_objects_enabled)
+		return;
+
 	if (limit < 5 && descr != descr_test) {
 		void *hint = descr->debug_hint ?
 			descr->debug_hint(obj->object) : NULL;
diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index ff00c816266b..b44ca1210109 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -1499,7 +1499,7 @@ void *radix_tree_tag_clear(struct radix_tree_root *root,
 {
 	struct radix_tree_node *node, *parent;
 	unsigned long maxindex;
-	int uninitialized_var(offset);
+	int offset;
 
 	radix_tree_load_root(root, &node, &maxindex);
 	if (index > maxindex)
diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 1c5e5246bf10..5318c5e18acf 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -621,6 +621,11 @@ static ssize_t trigger_batched_requests_store(struct device *dev,
 
 	mutex_lock(&test_fw_mutex);
 
+        if (test_fw_config->reqs) {
+                rc = -EBUSY;
+                goto out_bail;
+        }
+
 	test_fw_config->reqs = vzalloc(sizeof(struct test_batched_req) *
 				       test_fw_config->num_requests * 2);
 	if (!test_fw_config->reqs) {
@@ -723,6 +728,11 @@ ssize_t trigger_batched_requests_async_store(struct device *dev,
 
 	mutex_lock(&test_fw_mutex);
 
+        if (test_fw_config->reqs) {
+                rc = -EBUSY;
+                goto out_bail;
+        }
+
 	test_fw_config->reqs = vzalloc(sizeof(struct test_batched_req) *
 				       test_fw_config->num_requests * 2);
 	if (!test_fw_config->reqs) {
diff --git a/lib/ts_bm.c b/lib/ts_bm.c
index 9e66ee4020e9..5de382e79a45 100644
--- a/lib/ts_bm.c
+++ b/lib/ts_bm.c
@@ -64,10 +64,12 @@ static unsigned int bm_find(struct ts_config *conf, struct ts_state *state)
 	struct ts_bm *bm = ts_config_priv(conf);
 	unsigned int i, text_len, consumed = state->offset;
 	const u8 *text;
-	int shift = bm->patlen - 1, bs;
+	int bs;
 	const u8 icase = conf->flags & TS_IGNORECASE;
 
 	for (;;) {
+		int shift = bm->patlen - 1;
+
 		text_len = conf->get_next_block(consumed, &text, conf, state);
 
 		if (unlikely(text_len == 0))
diff --git a/mm/frontswap.c b/mm/frontswap.c
index fec8b5044040..c1759c7be972 100644
--- a/mm/frontswap.c
+++ b/mm/frontswap.c
@@ -447,7 +447,7 @@ static int __frontswap_shrink(unsigned long target_pages,
 void frontswap_shrink(unsigned long target_pages)
 {
 	unsigned long pages_to_unuse = 0;
-	int uninitialized_var(type), ret;
+	int type, ret;
 
 	/*
 	 * we don't want to hold swap_lock while doing a very
diff --git a/mm/ksm.c b/mm/ksm.c
index 6d3bc2723c9b..d81c6b1986f9 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2349,7 +2349,7 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
 static void ksm_do_scan(unsigned int scan_npages)
 {
 	struct rmap_item *rmap_item;
-	struct page *uninitialized_var(page);
+	struct page *page;
 
 	while (scan_npages-- && likely(!freezing(current))) {
 		cond_resched();
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 17bfdef686f4..22d13c98e274 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -722,7 +722,7 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 				   struct mem_cgroup *prev,
 				   struct mem_cgroup_reclaim_cookie *reclaim)
 {
-	struct mem_cgroup_reclaim_iter *uninitialized_var(iter);
+	struct mem_cgroup_reclaim_iter *iter;
 	struct cgroup_subsys_state *css = NULL;
 	struct mem_cgroup *memcg = NULL;
 	struct mem_cgroup *pos = NULL;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 19552bcc592d..0411f0e25ce4 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1130,7 +1130,7 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 static struct page *new_page(struct page *page, unsigned long start, int **x)
 {
 	struct vm_area_struct *vma;
-	unsigned long uninitialized_var(address);
+	unsigned long address;
 
 	vma = find_vma(current->mm, start);
 	while (vma) {
@@ -1504,7 +1504,7 @@ SYSCALL_DEFINE5(get_mempolicy, int __user *, policy,
 		unsigned long, addr, unsigned long, flags)
 {
 	int err;
-	int uninitialized_var(pval);
+	int pval;
 	nodemask_t nodes;
 
 	if (nmask != NULL && maxnode < nr_node_ids)
diff --git a/mm/percpu.c b/mm/percpu.c
index b24d6fe6bd5e..29c415d94e5d 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2261,7 +2261,7 @@ static struct pcpu_alloc_info * __init pcpu_build_alloc_info(
 	const size_t static_size = __per_cpu_end - __per_cpu_start;
 	int nr_groups = 1, nr_units = 0;
 	size_t size_sum, min_unit_size, alloc_size;
-	int upa, max_upa, uninitialized_var(best_upa);	/* units_per_alloc */
+	int upa, max_upa, best_upa;	/* units_per_alloc */
 	int last_allocs, group, unit;
 	unsigned int cpu, tcpu;
 	struct pcpu_alloc_info *ai;
diff --git a/mm/slub.c b/mm/slub.c
index 1a0c92ee8b99..7b9b2906aa65 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1190,7 +1190,7 @@ static noinline int free_debug_processing(
 	struct kmem_cache_node *n = get_node(s, page_to_nid(page));
 	void *object = head;
 	int cnt = 0;
-	unsigned long uninitialized_var(flags);
+	unsigned long flags;
 	int ret = 0;
 
 	spin_lock_irqsave(&n->list_lock, flags);
@@ -2835,7 +2835,7 @@ static void __slab_free(struct kmem_cache *s, struct page *page,
 	struct page new;
 	unsigned long counters;
 	struct kmem_cache_node *n = NULL;
-	unsigned long uninitialized_var(flags);
+	unsigned long flags;
 
 	stat(s, FREE_SLOWPATH);
 
diff --git a/mm/swap.c b/mm/swap.c
index a77d68f2c1b6..2c15b15ad71c 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -746,8 +746,8 @@ void release_pages(struct page **pages, int nr, bool cold)
 	LIST_HEAD(pages_to_free);
 	struct pglist_data *locked_pgdat = NULL;
 	struct lruvec *lruvec;
-	unsigned long uninitialized_var(flags);
-	unsigned int uninitialized_var(lock_batch);
+	unsigned long flags;
+	unsigned int lock_batch;
 
 	for (i = 0; i < nr; i++) {
 		struct page *page = pages[i];
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 47a16f6e741b..70b86ef50491 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -45,6 +45,7 @@ static const struct proto_ops l2cap_sock_ops;
 static void l2cap_sock_init(struct sock *sk, struct sock *parent);
 static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 				     int proto, gfp_t prio, int kern);
+static void l2cap_sock_cleanup_listen(struct sock *parent);
 
 bool l2cap_is_socket(struct socket *sock)
 {
@@ -1206,6 +1207,7 @@ static int l2cap_sock_release(struct socket *sock)
 	if (!sk)
 		return 0;
 
+	l2cap_sock_cleanup_listen(sk);
 	bt_sock_unlink(&l2cap_sk_list, sk);
 
 	err = l2cap_sock_shutdown(sock, 2);
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index c8bf044ab534..7229524b4448 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -155,8 +155,9 @@ void br_manage_promisc(struct net_bridge *br)
 			 * This lets us disable promiscuous mode and write
 			 * this config to hw.
 			 */
-			if (br->auto_cnt == 0 ||
-			    (br->auto_cnt == 1 && br_auto_port(p)))
+			if ((p->dev->priv_flags & IFF_UNICAST_FLT) &&
+			    (br->auto_cnt == 0 ||
+			     (br->auto_cnt == 1 && br_auto_port(p))))
 				br_port_clear_promisc(p);
 			else
 				br_port_set_promisc(p);
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 32db244ba2c0..0a082726395a 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1572,6 +1572,12 @@ static int bcm_release(struct socket *sock)
 
 	lock_sock(sk);
 
+#if IS_ENABLED(CONFIG_PROC_FS)
+	/* remove procfs entry */
+	if (net->can.bcmproc_dir && bo->bcm_proc_read)
+		remove_proc_entry(bo->procname, net->can.bcmproc_dir);
+#endif /* CONFIG_PROC_FS */
+
 	list_for_each_entry_safe(op, next, &bo->tx_ops, list)
 		bcm_remove_op(op);
 
@@ -1607,12 +1613,6 @@ static int bcm_release(struct socket *sock)
 	list_for_each_entry_safe(op, next, &bo->rx_ops, list)
 		bcm_remove_op(op);
 
-#if IS_ENABLED(CONFIG_PROC_FS)
-	/* remove procfs entry */
-	if (net->can.bcmproc_dir && bo->bcm_proc_read)
-		remove_proc_entry(bo->procname, net->can.bcmproc_dir);
-#endif /* CONFIG_PROC_FS */
-
 	/* remove device reference */
 	if (bo->bound) {
 		bo->bound   = 0;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index b026128a89d7..7d7b128c01bd 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -3041,17 +3041,24 @@ static int linger_reg_commit_wait(struct ceph_osd_linger_request *lreq)
 	int ret;
 
 	dout("%s lreq %p linger_id %llu\n", __func__, lreq, lreq->linger_id);
-	ret = wait_for_completion_interruptible(&lreq->reg_commit_wait);
+	ret = wait_for_completion_killable(&lreq->reg_commit_wait);
 	return ret ?: lreq->reg_commit_error;
 }
 
-static int linger_notify_finish_wait(struct ceph_osd_linger_request *lreq)
+static int linger_notify_finish_wait(struct ceph_osd_linger_request *lreq,
+				     unsigned long timeout)
 {
-	int ret;
+	long left;
 
 	dout("%s lreq %p linger_id %llu\n", __func__, lreq, lreq->linger_id);
-	ret = wait_for_completion_interruptible(&lreq->notify_finish_wait);
-	return ret ?: lreq->notify_finish_error;
+	left = wait_for_completion_killable_timeout(&lreq->notify_finish_wait,
+						ceph_timeout_jiffies(timeout));
+	if (left <= 0)
+		left = left ?: -ETIMEDOUT;
+	else
+		left = lreq->notify_finish_error; /* completed */
+
+	return left;
 }
 
 /*
@@ -4666,7 +4673,8 @@ int ceph_osdc_notify(struct ceph_osd_client *osdc,
 
 	ret = linger_reg_commit_wait(lreq);
 	if (!ret)
-		ret = linger_notify_finish_wait(lreq);
+		ret = linger_notify_finish_wait(lreq,
+				 msecs_to_jiffies(2 * timeout * MSEC_PER_SEC));
 	else
 		dout("lreq %p failed to initiate notify %d\n", lreq, ret);
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 738514e5c8ba..a76f3024687f 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2976,7 +2976,7 @@ static int nlmsg_populate_fdb_fill(struct sk_buff *skb,
 	ndm->ndm_ifindex = dev->ifindex;
 	ndm->ndm_state   = ndm_state;
 
-	if (nla_put(skb, NDA_LLADDR, ETH_ALEN, addr))
+	if (nla_put(skb, NDA_LLADDR, dev->addr_len, addr))
 		goto nla_put_failure;
 	if (vid)
 		if (nla_put(skb, NDA_VLAN, sizeof(u16), &vid))
@@ -2990,10 +2990,10 @@ static int nlmsg_populate_fdb_fill(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-static inline size_t rtnl_fdb_nlmsg_size(void)
+static inline size_t rtnl_fdb_nlmsg_size(const struct net_device *dev)
 {
 	return NLMSG_ALIGN(sizeof(struct ndmsg)) +
-	       nla_total_size(ETH_ALEN) +	/* NDA_LLADDR */
+	       nla_total_size(dev->addr_len) +	/* NDA_LLADDR */
 	       nla_total_size(sizeof(u16)) +	/* NDA_VLAN */
 	       0;
 }
@@ -3005,7 +3005,7 @@ static void rtnl_fdb_notify(struct net_device *dev, u8 *addr, u16 vid, int type,
 	struct sk_buff *skb;
 	int err = -ENOBUFS;
 
-	skb = nlmsg_new(rtnl_fdb_nlmsg_size(), GFP_ATOMIC);
+	skb = nlmsg_new(rtnl_fdb_nlmsg_size(dev), GFP_ATOMIC);
 	if (!skb)
 		goto errout;
 
diff --git a/net/core/sock.c b/net/core/sock.c
index b05296d79f62..0ff80718f194 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1329,7 +1329,7 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		if (!sock->ops->set_peek_off)
 			return -EOPNOTSUPP;
 
-		v.val = sk->sk_peek_off;
+		v.val = READ_ONCE(sk->sk_peek_off);
 		break;
 	case SO_NOFCS:
 		v.val = sock_flag(sk, SOCK_NOFCS);
@@ -1359,7 +1359,7 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	case SO_BUSY_POLL:
-		v.val = sk->sk_ll_usec;
+		v.val = READ_ONCE(sk->sk_ll_usec);
 		break;
 #endif
 
@@ -1932,13 +1932,24 @@ kuid_t sock_i_uid(struct sock *sk)
 }
 EXPORT_SYMBOL(sock_i_uid);
 
-unsigned long sock_i_ino(struct sock *sk)
+unsigned long __sock_i_ino(struct sock *sk)
 {
 	unsigned long ino;
 
-	read_lock_bh(&sk->sk_callback_lock);
+	read_lock(&sk->sk_callback_lock);
 	ino = sk->sk_socket ? SOCK_INODE(sk->sk_socket)->i_ino : 0;
-	read_unlock_bh(&sk->sk_callback_lock);
+	read_unlock(&sk->sk_callback_lock);
+	return ino;
+}
+EXPORT_SYMBOL(__sock_i_ino);
+
+unsigned long sock_i_ino(struct sock *sk)
+{
+	unsigned long ino;
+
+	local_bh_disable();
+	ino = __sock_i_ino(sk);
+	local_bh_enable();
 	return ino;
 }
 EXPORT_SYMBOL(sock_i_ino);
@@ -2469,7 +2480,7 @@ EXPORT_SYMBOL(__sk_mem_reclaim);
 
 int sk_set_peek_off(struct sock *sk, int val)
 {
-	sk->sk_peek_off = val;
+	WRITE_ONCE(sk->sk_peek_off, val);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sk_set_peek_off);
diff --git a/net/dccp/options.c b/net/dccp/options.c
index 51cdfc3bd8ca..e335cb4e3d79 100644
--- a/net/dccp/options.c
+++ b/net/dccp/options.c
@@ -60,7 +60,7 @@ int dccp_parse_options(struct sock *sk, struct dccp_request_sock *dreq,
 					(dh->dccph_doff * 4);
 	struct dccp_options_received *opt_recv = &dp->dccps_options_received;
 	unsigned char opt, len;
-	unsigned char *uninitialized_var(value);
+	unsigned char *value;
 	u32 elapsed_time;
 	__be32 opt_val;
 	int rc;
diff --git a/net/ipv4/netfilter/nf_socket_ipv4.c b/net/ipv4/netfilter/nf_socket_ipv4.c
index 4824b1e183a1..bff2b85c5fd6 100644
--- a/net/ipv4/netfilter/nf_socket_ipv4.c
+++ b/net/ipv4/netfilter/nf_socket_ipv4.c
@@ -96,11 +96,11 @@ nf_socket_get_sock_v4(struct net *net, struct sk_buff *skb, const int doff,
 struct sock *nf_sk_lookup_slow_v4(struct net *net, const struct sk_buff *skb,
 				  const struct net_device *indev)
 {
-	__be32 uninitialized_var(daddr), uninitialized_var(saddr);
-	__be16 uninitialized_var(dport), uninitialized_var(sport);
+	__be32 daddr, saddr;
+	__be16 dport, sport;
 	const struct iphdr *iph = ip_hdr(skb);
 	struct sk_buff *data_skb = NULL;
-	u8 uninitialized_var(protocol);
+	u8 protocol;
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
 	enum ip_conntrack_info ctinfo;
 	struct nf_conn const *ct;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index c93aa6542d43..0859f968c9b2 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2729,9 +2729,9 @@ static int do_tcp_setsockopt(struct sock *sk, int level,
 
 	case TCP_DEFER_ACCEPT:
 		/* Translate value in seconds to number of retransmits */
-		icsk->icsk_accept_queue.rskq_defer_accept =
-			secs_to_retrans(val, TCP_TIMEOUT_INIT / HZ,
-					TCP_RTO_MAX / HZ);
+		WRITE_ONCE(icsk->icsk_accept_queue.rskq_defer_accept,
+			   secs_to_retrans(val, TCP_TIMEOUT_INIT / HZ,
+					   TCP_RTO_MAX / HZ));
 		break;
 
 	case TCP_WINDOW_CLAMP:
@@ -2810,7 +2810,7 @@ static int do_tcp_setsockopt(struct sock *sk, int level,
 		err = tcp_repair_set_window(tp, optval, optlen);
 		break;
 	case TCP_NOTSENT_LOWAT:
-		tp->notsent_lowat = val;
+		WRITE_ONCE(tp->notsent_lowat, val);
 		sk->sk_write_space(sk);
 		break;
 	default:
@@ -3067,8 +3067,9 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
 			val = (val ? : net->ipv4.sysctl_tcp_fin_timeout) / HZ;
 		break;
 	case TCP_DEFER_ACCEPT:
-		val = retrans_to_secs(icsk->icsk_accept_queue.rskq_defer_accept,
-				      TCP_TIMEOUT_INIT / HZ, TCP_RTO_MAX / HZ);
+		val = READ_ONCE(icsk->icsk_accept_queue.rskq_defer_accept);
+		val = retrans_to_secs(val, TCP_TIMEOUT_INIT / HZ,
+				      TCP_RTO_MAX / HZ);
 		break;
 	case TCP_WINDOW_CLAMP:
 		val = tp->window_clamp;
@@ -3192,7 +3193,7 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
 		break;
 
 	case TCP_FASTOPEN:
-		val = icsk->icsk_accept_queue.fastopenq.max_qlen;
+		val = READ_ONCE(icsk->icsk_accept_queue.fastopenq.max_qlen);
 		break;
 
 	case TCP_FASTOPEN_CONNECT:
@@ -3203,7 +3204,7 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
 		val = tcp_time_stamp_raw() + tp->tsoffset;
 		break;
 	case TCP_NOTSENT_LOWAT:
-		val = tp->notsent_lowat;
+		val = READ_ONCE(tp->notsent_lowat);
 		break;
 	case TCP_SAVE_SYN:
 		val = tp->save_syn;
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 0567edb76522..0edd8d357e3d 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -239,6 +239,7 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
 static bool tcp_fastopen_queue_check(struct sock *sk)
 {
 	struct fastopen_queue *fastopenq;
+	int max_qlen;
 
 	/* Make sure the listener has enabled fastopen, and we don't
 	 * exceed the max # of pending TFO requests allowed before trying
@@ -251,10 +252,11 @@ static bool tcp_fastopen_queue_check(struct sock *sk)
 	 * temporarily vs a server not supporting Fast Open at all.
 	 */
 	fastopenq = &inet_csk(sk)->icsk_accept_queue.fastopenq;
-	if (fastopenq->max_qlen == 0)
+	max_qlen = READ_ONCE(fastopenq->max_qlen);
+	if (max_qlen == 0)
 		return false;
 
-	if (fastopenq->qlen >= fastopenq->max_qlen) {
+	if (fastopenq->qlen >= max_qlen) {
 		struct request_sock *req1;
 		spin_lock(&fastopenq->lock);
 		req1 = fastopenq->rskq_rst_head;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 87095d5ecf95..444ad1728927 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3447,8 +3447,11 @@ static int tcp_ack_update_window(struct sock *sk, const struct sk_buff *skb, u32
 static bool __tcp_oow_rate_limited(struct net *net, int mib_idx,
 				   u32 *last_oow_ack_time)
 {
-	if (*last_oow_ack_time) {
-		s32 elapsed = (s32)(tcp_jiffies32 - *last_oow_ack_time);
+	/* Paired with the WRITE_ONCE() in this function. */
+	u32 val = READ_ONCE(*last_oow_ack_time);
+
+	if (val) {
+		s32 elapsed = (s32)(tcp_jiffies32 - val);
 
 		if (0 <= elapsed && elapsed < sysctl_tcp_invalid_ratelimit) {
 			NET_INC_STATS(net, mib_idx);
@@ -3456,7 +3459,10 @@ static bool __tcp_oow_rate_limited(struct net *net, int mib_idx,
 		}
 	}
 
-	*last_oow_ack_time = tcp_jiffies32;
+	/* Paired with the prior READ_ONCE() and with itself,
+	 * as we might be lockless.
+	 */
+	WRITE_ONCE(*last_oow_ack_time, tcp_jiffies32);
 
 	return false;	/* not rate-limited: go ahead, send dupack now! */
 }
diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index 0f0d740f6c8b..11bb9751a799 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -42,7 +42,7 @@ struct tcp_fastopen_metrics {
 
 struct tcp_metrics_block {
 	struct tcp_metrics_block __rcu	*tcpm_next;
-	possible_net_t			tcpm_net;
+	struct net			*tcpm_net;
 	struct inetpeer_addr		tcpm_saddr;
 	struct inetpeer_addr		tcpm_daddr;
 	unsigned long			tcpm_stamp;
@@ -53,34 +53,38 @@ struct tcp_metrics_block {
 	struct rcu_head			rcu_head;
 };
 
-static inline struct net *tm_net(struct tcp_metrics_block *tm)
+static inline struct net *tm_net(const struct tcp_metrics_block *tm)
 {
-	return read_pnet(&tm->tcpm_net);
+	/* Paired with the WRITE_ONCE() in tcpm_new() */
+	return READ_ONCE(tm->tcpm_net);
 }
 
 static bool tcp_metric_locked(struct tcp_metrics_block *tm,
 			      enum tcp_metric_index idx)
 {
-	return tm->tcpm_lock & (1 << idx);
+	/* Paired with WRITE_ONCE() in tcpm_suck_dst() */
+	return READ_ONCE(tm->tcpm_lock) & (1 << idx);
 }
 
-static u32 tcp_metric_get(struct tcp_metrics_block *tm,
+static u32 tcp_metric_get(const struct tcp_metrics_block *tm,
 			  enum tcp_metric_index idx)
 {
-	return tm->tcpm_vals[idx];
+	/* Paired with WRITE_ONCE() in tcp_metric_set() */
+	return READ_ONCE(tm->tcpm_vals[idx]);
 }
 
 static void tcp_metric_set(struct tcp_metrics_block *tm,
 			   enum tcp_metric_index idx,
 			   u32 val)
 {
-	tm->tcpm_vals[idx] = val;
+	/* Paired with READ_ONCE() in tcp_metric_get() */
+	WRITE_ONCE(tm->tcpm_vals[idx], val);
 }
 
 static bool addr_same(const struct inetpeer_addr *a,
 		      const struct inetpeer_addr *b)
 {
-	return inetpeer_addr_cmp(a, b) == 0;
+	return (a->family == b->family) && !inetpeer_addr_cmp(a, b);
 }
 
 struct tcpm_hash_bucket {
@@ -91,6 +95,7 @@ static struct tcpm_hash_bucket	*tcp_metrics_hash __read_mostly;
 static unsigned int		tcp_metrics_hash_log __read_mostly;
 
 static DEFINE_SPINLOCK(tcp_metrics_lock);
+static DEFINE_SEQLOCK(fastopen_seqlock);
 
 static void tcpm_suck_dst(struct tcp_metrics_block *tm,
 			  const struct dst_entry *dst,
@@ -99,7 +104,7 @@ static void tcpm_suck_dst(struct tcp_metrics_block *tm,
 	u32 msval;
 	u32 val;
 
-	tm->tcpm_stamp = jiffies;
+	WRITE_ONCE(tm->tcpm_stamp, jiffies);
 
 	val = 0;
 	if (dst_metric_locked(dst, RTAX_RTT))
@@ -112,30 +117,42 @@ static void tcpm_suck_dst(struct tcp_metrics_block *tm,
 		val |= 1 << TCP_METRIC_CWND;
 	if (dst_metric_locked(dst, RTAX_REORDERING))
 		val |= 1 << TCP_METRIC_REORDERING;
-	tm->tcpm_lock = val;
+	/* Paired with READ_ONCE() in tcp_metric_locked() */
+	WRITE_ONCE(tm->tcpm_lock, val);
 
 	msval = dst_metric_raw(dst, RTAX_RTT);
-	tm->tcpm_vals[TCP_METRIC_RTT] = msval * USEC_PER_MSEC;
+	tcp_metric_set(tm, TCP_METRIC_RTT, msval * USEC_PER_MSEC);
 
 	msval = dst_metric_raw(dst, RTAX_RTTVAR);
-	tm->tcpm_vals[TCP_METRIC_RTTVAR] = msval * USEC_PER_MSEC;
-	tm->tcpm_vals[TCP_METRIC_SSTHRESH] = dst_metric_raw(dst, RTAX_SSTHRESH);
-	tm->tcpm_vals[TCP_METRIC_CWND] = dst_metric_raw(dst, RTAX_CWND);
-	tm->tcpm_vals[TCP_METRIC_REORDERING] = dst_metric_raw(dst, RTAX_REORDERING);
+	tcp_metric_set(tm, TCP_METRIC_RTTVAR, msval * USEC_PER_MSEC);
+	tcp_metric_set(tm, TCP_METRIC_SSTHRESH,
+		       dst_metric_raw(dst, RTAX_SSTHRESH));
+	tcp_metric_set(tm, TCP_METRIC_CWND,
+		       dst_metric_raw(dst, RTAX_CWND));
+	tcp_metric_set(tm, TCP_METRIC_REORDERING,
+		       dst_metric_raw(dst, RTAX_REORDERING));
 	if (fastopen_clear) {
+		write_seqlock(&fastopen_seqlock);
 		tm->tcpm_fastopen.mss = 0;
 		tm->tcpm_fastopen.syn_loss = 0;
 		tm->tcpm_fastopen.try_exp = 0;
 		tm->tcpm_fastopen.cookie.exp = false;
 		tm->tcpm_fastopen.cookie.len = 0;
+		write_sequnlock(&fastopen_seqlock);
 	}
 }
 
 #define TCP_METRICS_TIMEOUT		(60 * 60 * HZ)
 
-static void tcpm_check_stamp(struct tcp_metrics_block *tm, struct dst_entry *dst)
+static void tcpm_check_stamp(struct tcp_metrics_block *tm,
+			     const struct dst_entry *dst)
 {
-	if (tm && unlikely(time_after(jiffies, tm->tcpm_stamp + TCP_METRICS_TIMEOUT)))
+	unsigned long limit;
+
+	if (!tm)
+		return;
+	limit = READ_ONCE(tm->tcpm_stamp) + TCP_METRICS_TIMEOUT;
+	if (unlikely(time_after(jiffies, limit)))
 		tcpm_suck_dst(tm, dst, false);
 }
 
@@ -176,20 +193,23 @@ static struct tcp_metrics_block *tcpm_new(struct dst_entry *dst,
 		oldest = deref_locked(tcp_metrics_hash[hash].chain);
 		for (tm = deref_locked(oldest->tcpm_next); tm;
 		     tm = deref_locked(tm->tcpm_next)) {
-			if (time_before(tm->tcpm_stamp, oldest->tcpm_stamp))
+			if (time_before(READ_ONCE(tm->tcpm_stamp),
+					READ_ONCE(oldest->tcpm_stamp)))
 				oldest = tm;
 		}
 		tm = oldest;
 	} else {
-		tm = kmalloc(sizeof(*tm), GFP_ATOMIC);
+		tm = kzalloc(sizeof(*tm), GFP_ATOMIC);
 		if (!tm)
 			goto out_unlock;
 	}
-	write_pnet(&tm->tcpm_net, net);
+	/* Paired with the READ_ONCE() in tm_net() */
+	WRITE_ONCE(tm->tcpm_net, net);
+
 	tm->tcpm_saddr = *saddr;
 	tm->tcpm_daddr = *daddr;
 
-	tcpm_suck_dst(tm, dst, true);
+	tcpm_suck_dst(tm, dst, reclaim);
 
 	if (likely(!reclaim)) {
 		tm->tcpm_next = tcp_metrics_hash[hash].chain;
@@ -432,7 +452,7 @@ void tcp_update_metrics(struct sock *sk)
 					       tp->reordering);
 		}
 	}
-	tm->tcpm_stamp = jiffies;
+	WRITE_ONCE(tm->tcpm_stamp, jiffies);
 out_unlock:
 	rcu_read_unlock();
 }
@@ -547,8 +567,6 @@ bool tcp_peer_is_proven(struct request_sock *req, struct dst_entry *dst)
 	return ret;
 }
 
-static DEFINE_SEQLOCK(fastopen_seqlock);
-
 void tcp_fastopen_cache_get(struct sock *sk, u16 *mss,
 			    struct tcp_fastopen_cookie *cookie,
 			    int *syn_loss, unsigned long *last_syn_loss)
@@ -658,7 +676,7 @@ static int tcp_metrics_fill_info(struct sk_buff *msg,
 	}
 
 	if (nla_put_msecs(msg, TCP_METRICS_ATTR_AGE,
-			  jiffies - tm->tcpm_stamp,
+			  jiffies - READ_ONCE(tm->tcpm_stamp),
 			  TCP_METRICS_ATTR_PAD) < 0)
 		goto nla_put_failure;
 
@@ -669,7 +687,7 @@ static int tcp_metrics_fill_info(struct sk_buff *msg,
 		if (!nest)
 			goto nla_put_failure;
 		for (i = 0; i < TCP_METRIC_MAX_KERNEL + 1; i++) {
-			u32 val = tm->tcpm_vals[i];
+			u32 val = tcp_metric_get(tm, i);
 
 			if (!val)
 				continue;
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 0d3e76b160a5..893b93cc5221 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -325,9 +325,8 @@ static void addrconf_del_dad_work(struct inet6_ifaddr *ifp)
 static void addrconf_mod_rs_timer(struct inet6_dev *idev,
 				  unsigned long when)
 {
-	if (!timer_pending(&idev->rs_timer))
+	if (!mod_timer(&idev->rs_timer, jiffies + when))
 		in6_dev_hold(idev);
-	mod_timer(&idev->rs_timer, jiffies + when);
 }
 
 static void addrconf_mod_dad_work(struct inet6_ifaddr *ifp,
@@ -2437,12 +2436,18 @@ static void manage_tempaddrs(struct inet6_dev *idev,
 			ipv6_ifa_notify(0, ift);
 	}
 
-	if ((create || list_empty(&idev->tempaddr_list)) &&
-	    idev->cnf.use_tempaddr > 0) {
+	/* Also create a temporary address if it's enabled but no temporary
+	 * address currently exists.
+	 * However, we get called with valid_lft == 0, prefered_lft == 0, create == false
+	 * as part of cleanup (ie. deleting the mngtmpaddr).
+	 * We don't want that to result in creating a new temporary ip address.
+	 */
+	if (list_empty(&idev->tempaddr_list) && (valid_lft || prefered_lft))
+		create = true;
+
+	if (create && idev->cnf.use_tempaddr > 0) {
 		/* When a new public address is created as described
 		 * in [ADDRCONF], also create a new temporary address.
-		 * Also create a temporary address if it's enabled but
-		 * no temporary address currently exists.
 		 */
 		read_unlock_bh(&idev->lock);
 		ipv6_create_tempaddr(ifp, NULL);
diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index c7458a606e2e..82f2d3fcb246 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -519,7 +519,7 @@ int ipv6_flowlabel_opt_get(struct sock *sk, struct in6_flowlabel_req *freq,
 
 int ipv6_flowlabel_opt(struct sock *sk, char __user *optval, int optlen)
 {
-	int uninitialized_var(err);
+	int err;
 	struct net *net = sock_net(sk);
 	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct in6_flowlabel_req freq;
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index f8d60d511d3e..40dfb9bddb21 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1166,7 +1166,7 @@ static int ip6mr_cache_report(struct mr6_table *mrt, struct sk_buff *pkt,
 		   And all this only to mangle msg->im6_msgtype and
 		   to set msg->im6_mbz to "mbz" :-)
 		 */
-		skb_push(skb, -skb_network_offset(pkt));
+		__skb_pull(skb, skb_network_offset(pkt));
 
 		skb_push(skb, sizeof(*msg));
 		skb_reset_transport_header(skb);
diff --git a/net/ipv6/netfilter/nf_socket_ipv6.c b/net/ipv6/netfilter/nf_socket_ipv6.c
index 58e839e2ce1d..5e5463459563 100644
--- a/net/ipv6/netfilter/nf_socket_ipv6.c
+++ b/net/ipv6/netfilter/nf_socket_ipv6.c
@@ -102,7 +102,7 @@ nf_socket_get_sock_v6(struct net *net, struct sk_buff *skb, int doff,
 struct sock *nf_sk_lookup_slow_v6(struct net *net, const struct sk_buff *skb,
 				  const struct net_device *indev)
 {
-	__be16 uninitialized_var(dport), uninitialized_var(sport);
+	__be16 dport, sport;
 	const struct in6_addr *daddr = NULL, *saddr = NULL;
 	struct ipv6hdr *iph = ipv6_hdr(skb), ipv6_var;
 	struct sk_buff *data_skb = NULL;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index ea681360a522..3fee10cc5d5d 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -99,7 +99,7 @@ static u32 udp6_ehashfn(const struct net *net,
 	fhash = __ipv6_addr_jhash(faddr, udp_ipv6_hash_secret);
 
 	return __inet6_ehashfn(lhash, lport, fhash, fport,
-			       udp_ipv6_hash_secret + net_hash_mix(net));
+			       udp6_ehash_secret + net_hash_mix(net));
 }
 
 static u32 udp6_portaddr_hash(const struct net *net,
diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
index dd3e83328ad5..d5c6fb41be92 100644
--- a/net/llc/llc_input.c
+++ b/net/llc/llc_input.c
@@ -162,9 +162,6 @@ int llc_rcv(struct sk_buff *skb, struct net_device *dev,
 	void (*sta_handler)(struct sk_buff *skb);
 	void (*sap_handler)(struct llc_sap *sap, struct sk_buff *skb);
 
-	if (!net_eq(dev_net(dev), &init_net))
-		goto drop;
-
 	/*
 	 * When the interface is in promisc. mode, drop all the crap that it
 	 * receives, do not try to analyse it.
diff --git a/net/netfilter/nf_conntrack_ftp.c b/net/netfilter/nf_conntrack_ftp.c
index c236c7d1655d..3e4e6aa53491 100644
--- a/net/netfilter/nf_conntrack_ftp.c
+++ b/net/netfilter/nf_conntrack_ftp.c
@@ -383,7 +383,7 @@ static int help(struct sk_buff *skb,
 	int ret;
 	u32 seq;
 	int dir = CTINFO2DIR(ctinfo);
-	unsigned int uninitialized_var(matchlen), uninitialized_var(matchoff);
+	unsigned int matchlen, matchoff;
 	struct nf_ct_ftp_master *ct_ftp_info = nfct_help_data(ct);
 	struct nf_conntrack_expect *exp;
 	union nf_inet_addr *daddr;
diff --git a/net/netfilter/nf_conntrack_helper.c b/net/netfilter/nf_conntrack_helper.c
index a75b11c39312..93f7ddd6c74a 100644
--- a/net/netfilter/nf_conntrack_helper.c
+++ b/net/netfilter/nf_conntrack_helper.c
@@ -402,6 +402,9 @@ int nf_conntrack_helper_register(struct nf_conntrack_helper *me)
 	BUG_ON(me->expect_class_max >= NF_CT_MAX_EXPECT_CLASSES);
 	BUG_ON(strlen(me->name) > NF_CT_HELPER_NAME_LEN - 1);
 
+	if (!nf_ct_helper_hash)
+		return -ENOENT;
+
 	if (me->expect_policy->max_expected > NF_CT_EXPECT_MAX_CNT)
 		return -EINVAL;
 
@@ -572,4 +575,5 @@ void nf_conntrack_helper_fini(void)
 {
 	nf_ct_extend_unregister(&helper_extend);
 	nf_ct_free_hashtable(nf_ct_helper_hash, nf_ct_helper_hsize);
+	nf_ct_helper_hash = NULL;
 }
diff --git a/net/netfilter/nf_conntrack_sip.c b/net/netfilter/nf_conntrack_sip.c
index 3b4c9407d6f2..13c58e2c25c2 100644
--- a/net/netfilter/nf_conntrack_sip.c
+++ b/net/netfilter/nf_conntrack_sip.c
@@ -605,7 +605,7 @@ int ct_sip_parse_numerical_param(const struct nf_conn *ct, const char *dptr,
 	start += strlen(name);
 	*val = simple_strtoul(start, &end, 0);
 	if (start == end)
-		return 0;
+		return -1;
 	if (matchoff && matchlen) {
 		*matchoff = start - dptr;
 		*matchlen = end - start;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index e091c552b0b9..68a13ab584ac 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -140,7 +140,8 @@ static void nft_trans_destroy(struct nft_trans *trans)
 	kfree(trans);
 }
 
-static void nft_set_trans_bind(const struct nft_ctx *ctx, struct nft_set *set)
+static void __nft_set_trans_bind(const struct nft_ctx *ctx, struct nft_set *set,
+				 bool bind)
 {
 	struct net *net = ctx->net;
 	struct nft_trans *trans;
@@ -152,16 +153,26 @@ static void nft_set_trans_bind(const struct nft_ctx *ctx, struct nft_set *set)
 		switch (trans->msg_type) {
 		case NFT_MSG_NEWSET:
 			if (nft_trans_set(trans) == set)
-				nft_trans_set_bound(trans) = true;
+				nft_trans_set_bound(trans) = bind;
 			break;
 		case NFT_MSG_NEWSETELEM:
 			if (nft_trans_elem_set(trans) == set)
-				nft_trans_elem_set_bound(trans) = true;
+				nft_trans_elem_set_bound(trans) = bind;
 			break;
 		}
 	}
 }
 
+static void nft_set_trans_bind(const struct nft_ctx *ctx, struct nft_set *set)
+{
+	return __nft_set_trans_bind(ctx, set, true);
+}
+
+static void nft_set_trans_unbind(const struct nft_ctx *ctx, struct nft_set *set)
+{
+	return __nft_set_trans_bind(ctx, set, false);
+}
+
 static int nf_tables_register_hooks(struct net *net,
 				    const struct nft_table *table,
 				    struct nft_chain *chain,
@@ -2465,7 +2476,8 @@ static int nf_tables_newrule(struct net *net, struct sock *nlsk,
 	return 0;
 
 err2:
-	nf_tables_rule_release(&ctx, rule);
+	nft_rule_expr_deactivate(&ctx, rule, NFT_TRANS_PREPARE_ERROR);
+	nf_tables_rule_destroy(&ctx, rule);
 err1:
 	for (i = 0; i < n; i++) {
 		if (info[i].ops != NULL)
@@ -3445,6 +3457,15 @@ void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 			      enum nft_trans_phase phase)
 {
 	switch (phase) {
+	case NFT_TRANS_PREPARE_ERROR:
+		nft_set_trans_unbind(ctx, set);
+		if (set->flags & NFT_SET_ANONYMOUS)
+			nft_deactivate_next(ctx->net, set);
+		else
+			list_del_rcu(&binding->list);
+
+		set->use--;
+		break;
 	case NFT_TRANS_PREPARE:
 		if (set->flags & NFT_SET_ANONYMOUS)
 			nft_deactivate_next(ctx->net, set);
@@ -5831,6 +5852,9 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 
 	if (!tb[NFTA_VERDICT_CODE])
 		return -EINVAL;
+
+	/* zero padding hole for memcmp */
+	memset(data, 0, sizeof(*data));
 	data->verdict.code = ntohl(nla_get_be32(tb[NFTA_VERDICT_CODE]));
 
 	switch (data->verdict.code) {
diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index 0ccc7c851a78..40ba9c8e3c07 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -638,7 +638,7 @@ nfulnl_log_packet(struct net *net,
 	struct nfnl_log_net *log = nfnl_log_pernet(net);
 	const struct nfnl_ct_hook *nfnl_ct = NULL;
 	struct nf_conn *ct = NULL;
-	enum ip_conntrack_info uninitialized_var(ctinfo);
+	enum ip_conntrack_info ctinfo;
 
 	if (li_user && li_user->type == NF_LOG_TYPE_ULOG)
 		li = li_user;
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 369f1634afe9..0c40438c5b6f 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -369,7 +369,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	struct net_device *indev;
 	struct net_device *outdev;
 	struct nf_conn *ct = NULL;
-	enum ip_conntrack_info uninitialized_var(ctinfo);
+	enum ip_conntrack_info ctinfo;
 	struct nfnl_ct_hook *nfnl_ct;
 	bool csum_verify;
 	char *secdata = NULL;
@@ -1175,7 +1175,7 @@ static int nfqnl_recv_verdict(struct net *net, struct sock *ctnl,
 	struct nfqnl_instance *queue;
 	unsigned int verdict;
 	struct nf_queue_entry *entry;
-	enum ip_conntrack_info uninitialized_var(ctinfo);
+	enum ip_conntrack_info ctinfo;
 	struct nfnl_ct_hook *nfnl_ct;
 	struct nf_conn *ct = NULL;
 	struct nfnl_queue_net *q = nfnl_queue_pernet(net);
diff --git a/net/netfilter/nft_byteorder.c b/net/netfilter/nft_byteorder.c
index 5e1fbdd7b284..dba16126c7ee 100644
--- a/net/netfilter/nft_byteorder.c
+++ b/net/netfilter/nft_byteorder.c
@@ -33,11 +33,11 @@ static void nft_byteorder_eval(const struct nft_expr *expr,
 	const struct nft_byteorder *priv = nft_expr_priv(expr);
 	u32 *src = &regs->data[priv->sreg];
 	u32 *dst = &regs->data[priv->dreg];
-	union { u32 u32; u16 u16; } *s, *d;
+	u16 *s16, *d16;
 	unsigned int i;
 
-	s = (void *)src;
-	d = (void *)dst;
+	s16 = (void *)src;
+	d16 = (void *)dst;
 
 	switch (priv->size) {
 	case 8: {
@@ -63,11 +63,11 @@ static void nft_byteorder_eval(const struct nft_expr *expr,
 		switch (priv->op) {
 		case NFT_BYTEORDER_NTOH:
 			for (i = 0; i < priv->len / 4; i++)
-				d[i].u32 = ntohl((__force __be32)s[i].u32);
+				dst[i] = ntohl((__force __be32)src[i]);
 			break;
 		case NFT_BYTEORDER_HTON:
 			for (i = 0; i < priv->len / 4; i++)
-				d[i].u32 = (__force __u32)htonl(s[i].u32);
+				dst[i] = (__force __u32)htonl(src[i]);
 			break;
 		}
 		break;
@@ -75,11 +75,11 @@ static void nft_byteorder_eval(const struct nft_expr *expr,
 		switch (priv->op) {
 		case NFT_BYTEORDER_NTOH:
 			for (i = 0; i < priv->len / 2; i++)
-				d[i].u16 = ntohs((__force __be16)s[i].u16);
+				d16[i] = ntohs((__force __be16)s16[i]);
 			break;
 		case NFT_BYTEORDER_HTON:
 			for (i = 0; i < priv->len / 2; i++)
-				d[i].u16 = (__force __u16)htons(s[i].u16);
+				d16[i] = (__force __u16)htons(s16[i]);
 			break;
 		}
 		break;
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 4b40edb51b9e..6aa984971577 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1574,6 +1574,7 @@ static int do_one_set_err(struct sock *sk, struct netlink_set_err_data *p)
 int netlink_set_err(struct sock *ssk, u32 portid, u32 group, int code)
 {
 	struct netlink_set_err_data info;
+	unsigned long flags;
 	struct sock *sk;
 	int ret = 0;
 
@@ -1583,12 +1584,12 @@ int netlink_set_err(struct sock *ssk, u32 portid, u32 group, int code)
 	/* sk->sk_err wants a positive error value */
 	info.code = -code;
 
-	read_lock(&nl_table_lock);
+	read_lock_irqsave(&nl_table_lock, flags);
 
 	sk_for_each_bound(sk, &nl_table[ssk->sk_protocol].mc_list)
 		ret += do_one_set_err(sk, &info);
 
-	read_unlock(&nl_table_lock);
+	read_unlock_irqrestore(&nl_table_lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL(netlink_set_err);
diff --git a/net/netlink/diag.c b/net/netlink/diag.c
index 8faa20b4d457..8cbe6de1f075 100644
--- a/net/netlink/diag.c
+++ b/net/netlink/diag.c
@@ -93,6 +93,7 @@ static int __netlink_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 	struct net *net = sock_net(skb->sk);
 	struct netlink_diag_req *req;
 	struct netlink_sock *nlsk;
+	unsigned long flags;
 	struct sock *sk;
 	int num = 2;
 	int ret = 0;
@@ -155,7 +156,7 @@ static int __netlink_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 	num++;
 
 mc_list:
-	read_lock(&nl_table_lock);
+	read_lock_irqsave(&nl_table_lock, flags);
 	sk_for_each_bound(sk, &tbl->mc_list) {
 		if (sk_hashed(sk))
 			continue;
@@ -170,13 +171,13 @@ static int __netlink_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 				 NETLINK_CB(cb->skb).portid,
 				 cb->nlh->nlmsg_seq,
 				 NLM_F_MULTI,
-				 sock_i_ino(sk)) < 0) {
+				 __sock_i_ino(sk)) < 0) {
 			ret = 1;
 			break;
 		}
 		num++;
 	}
-	read_unlock(&nl_table_lock);
+	read_unlock_irqrestore(&nl_table_lock, flags);
 
 done:
 	cb->args[0] = num;
diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index fb0caa500ac8..d14c31129e08 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -29,6 +29,7 @@ static struct tc_action_ops act_pedit_ops;
 
 static const struct nla_policy pedit_policy[TCA_PEDIT_MAX + 1] = {
 	[TCA_PEDIT_PARMS]	= { .len = sizeof(struct tc_pedit) },
+	[TCA_PEDIT_PARMS_EX]	= { .len = sizeof(struct tc_pedit) },
 	[TCA_PEDIT_KEYS_EX]   = { .type = NLA_NESTED },
 };
 
diff --git a/net/sched/cls_flow.c b/net/sched/cls_flow.c
index 85f765cff697..0d364166ccc9 100644
--- a/net/sched/cls_flow.c
+++ b/net/sched/cls_flow.c
@@ -232,7 +232,7 @@ static u32 flow_get_skgid(const struct sk_buff *skb)
 
 static u32 flow_get_vlan_tag(const struct sk_buff *skb)
 {
-	u16 uninitialized_var(tag);
+	u16 tag;
 
 	if (vlan_get_tag(skb, &tag) < 0)
 		return 0;
diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
index 7f45e5ab8afc..e63f9c2e37e5 100644
--- a/net/sched/cls_fw.c
+++ b/net/sched/cls_fw.c
@@ -225,11 +225,6 @@ static int fw_set_parms(struct net *net, struct tcf_proto *tp,
 	if (err < 0)
 		return err;
 
-	if (tb[TCA_FW_CLASSID]) {
-		f->res.classid = nla_get_u32(tb[TCA_FW_CLASSID]);
-		tcf_bind_filter(tp, &f->res, base);
-	}
-
 #ifdef CONFIG_NET_CLS_IND
 	if (tb[TCA_FW_INDEV]) {
 		int ret;
@@ -248,6 +243,11 @@ static int fw_set_parms(struct net *net, struct tcf_proto *tp,
 	} else if (head->mask != 0xFFFFFFFF)
 		return err;
 
+	if (tb[TCA_FW_CLASSID]) {
+		f->res.classid = nla_get_u32(tb[TCA_FW_CLASSID]);
+		tcf_bind_filter(tp, &f->res, base);
+	}
+
 	return 0;
 }
 
diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
index 7483d208c1f7..8ccb3cedce40 100644
--- a/net/sched/cls_route.c
+++ b/net/sched/cls_route.c
@@ -512,7 +512,6 @@ static int route4_change(struct net *net, struct sk_buff *in_skb,
 	if (fold) {
 		f->id = fold->id;
 		f->iif = fold->iif;
-		f->res = fold->res;
 		f->handle = fold->handle;
 
 		f->tp = fold->tp;
diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index fdbdcba44917..8a2fc40ae840 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -774,11 +774,22 @@ static int u32_set_parms(struct net *net, struct tcf_proto *tp,
 			 struct nlattr *est, bool ovr)
 {
 	int err;
+#ifdef CONFIG_NET_CLS_IND
+	int ifindex = -1;
+#endif
 
 	err = tcf_exts_validate(net, tp, tb, est, &n->exts, ovr);
 	if (err < 0)
 		return err;
 
+#ifdef CONFIG_NET_CLS_IND
+	if (tb[TCA_U32_INDEV]) {
+		ifindex = tcf_change_indev(net, tb[TCA_U32_INDEV]);
+		if (ifindex < 0)
+			return -EINVAL;
+	}
+#endif
+
 	if (tb[TCA_U32_LINK]) {
 		u32 handle = nla_get_u32(tb[TCA_U32_LINK]);
 		struct tc_u_hnode *ht_down = NULL, *ht_old;
@@ -806,14 +817,10 @@ static int u32_set_parms(struct net *net, struct tcf_proto *tp,
 	}
 
 #ifdef CONFIG_NET_CLS_IND
-	if (tb[TCA_U32_INDEV]) {
-		int ret;
-		ret = tcf_change_indev(net, tb[TCA_U32_INDEV]);
-		if (ret < 0)
-			return -EINVAL;
-		n->ifindex = ret;
-	}
+	if (ifindex >= 0)
+		n->ifindex = ifindex;
 #endif
+
 	return 0;
 }
 
@@ -863,7 +870,6 @@ static struct tc_u_knode *u32_init_knode(struct tcf_proto *tp,
 	new->ifindex = n->ifindex;
 #endif
 	new->fshift = n->fshift;
-	new->res = n->res;
 	new->flags = n->flags;
 	RCU_INIT_POINTER(new->ht_down, n->ht_down);
 
diff --git a/net/sched/sch_cbq.c b/net/sched/sch_cbq.c
index 8b75a9572d1f..92ff508367e8 100644
--- a/net/sched/sch_cbq.c
+++ b/net/sched/sch_cbq.c
@@ -364,7 +364,7 @@ cbq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	    struct sk_buff **to_free)
 {
 	struct cbq_sched_data *q = qdisc_priv(sch);
-	int uninitialized_var(ret);
+	int ret;
 	struct cbq_class *cl = cbq_classify(skb, sch, &ret);
 
 #ifdef CONFIG_NET_CLS_ACT
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 4faa631139af..8715a043d423 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -191,7 +191,7 @@ static int fq_codel_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	struct fq_codel_sched_data *q = qdisc_priv(sch);
 	unsigned int idx, prev_backlog, prev_qlen;
 	struct fq_codel_flow *flow;
-	int uninitialized_var(ret);
+	int ret;
 	unsigned int pkt_len;
 	bool memory_limited;
 
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 2832e16b6c2e..1a1366b037fb 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -387,8 +387,13 @@ static int qfq_change_agg(struct Qdisc *sch, struct qfq_class *cl, u32 weight,
 			   u32 lmax)
 {
 	struct qfq_sched *q = qdisc_priv(sch);
-	struct qfq_aggregate *new_agg = qfq_find_agg(q, lmax, weight);
+	struct qfq_aggregate *new_agg;
 
+	/* 'lmax' can range from [QFQ_MIN_LMAX, pktlen + stab overhead] */
+	if (lmax > (1UL << QFQ_MTU_SHIFT))
+		return -EINVAL;
+
+	new_agg = qfq_find_agg(q, lmax, weight);
 	if (new_agg == NULL) { /* create new aggregate */
 		new_agg = kzalloc(sizeof(*new_agg), GFP_ATOMIC);
 		if (new_agg == NULL)
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 4a02dd26986e..1eefb3da8164 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -351,7 +351,7 @@ sfq_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 	unsigned int hash, dropped;
 	sfq_index x, qlen;
 	struct sfq_slot *slot;
-	int uninitialized_var(ret);
+	int ret;
 	struct sk_buff *head;
 	int delta;
 
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 8dd368168a84..9414dcb376d2 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -374,9 +374,9 @@ static void sctp_auto_asconf_init(struct sctp_sock *sp)
 	struct net *net = sock_net(&sp->inet.sk);
 
 	if (net->sctp.default_auto_asconf) {
-		spin_lock(&net->sctp.addr_wq_lock);
+		spin_lock_bh(&net->sctp.addr_wq_lock);
 		list_add_tail(&sp->auto_asconf_list, &net->sctp.auto_asconf_splist);
-		spin_unlock(&net->sctp.addr_wq_lock);
+		spin_unlock_bh(&net->sctp.addr_wq_lock);
 		sp->do_auto_asconf = 1;
 	}
 }
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index d6771f3b715b..1f717654b4cb 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -766,12 +766,6 @@ static void svc_tcp_listen_data_ready(struct sock *sk)
 	dprintk("svc: socket %p TCP (listen) state change %d\n",
 		sk, sk->sk_state);
 
-	if (svsk) {
-		/* Refer to svc_setup_socket() for details. */
-		rmb();
-		svsk->sk_odata(sk);
-	}
-
 	/*
 	 * This callback may called twice when a new connection
 	 * is established as a child socket inherits everything
@@ -780,15 +774,20 @@ static void svc_tcp_listen_data_ready(struct sock *sk)
 	 *    when one of child sockets become ESTABLISHED.
 	 * 2) data_ready method of the child socket may be called
 	 *    when it receives data before the socket is accepted.
-	 * In case of 2, we should ignore it silently.
+	 * In case of 2, we should ignore it silently and DO NOT
+	 * dereference svsk.
 	 */
-	if (sk->sk_state == TCP_LISTEN) {
-		if (svsk) {
-			set_bit(XPT_CONN, &svsk->sk_xprt.xpt_flags);
-			svc_xprt_enqueue(&svsk->sk_xprt);
-		} else
-			printk("svc: socket %p: no user data\n", sk);
-	}
+	if (sk->sk_state != TCP_LISTEN)
+		return;
+
+	if (svsk) {
+		/* Refer to svc_setup_socket() for details. */
+		rmb();
+		svsk->sk_odata(sk);
+		set_bit(XPT_CONN, &svsk->sk_xprt.xpt_flags);
+		svc_xprt_enqueue(&svsk->sk_xprt);
+	} else
+		printk("svc: socket %p: no user data\n", sk);
 }
 
 /*
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 375d4e20efd6..c4ec2c2e4c86 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -701,7 +701,7 @@ static int unix_set_peek_off(struct sock *sk, int val)
 	if (mutex_lock_interruptible(&u->iolock))
 		return -EINTR;
 
-	sk->sk_peek_off = val;
+	WRITE_ONCE(sk->sk_peek_off, val);
 	mutex_unlock(&u->iolock);
 
 	return 0;
diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
index b6414c7bef55..4bf33f9b2887 100644
--- a/net/wireless/wext-core.c
+++ b/net/wireless/wext-core.c
@@ -798,6 +798,12 @@ static int ioctl_standard_iw_point(struct iw_point *iwp, unsigned int cmd,
 		}
 	}
 
+	/* Sanity-check to ensure we never end up _allocating_ zero
+	 * bytes of data for extra.
+	 */
+	if (extra_size <= 0)
+		return -EFAULT;
+
 	/* kzalloc() ensures NULL-termination for essid_compat. */
 	extra = kzalloc(extra_size, GFP_KERNEL);
 	if (!extra)
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index ed2b7a16554e..9e177b553112 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1271,6 +1271,10 @@ static Elf_Sym *find_elf_symbol(struct elf_info *elf, Elf64_Sword addr,
 	if (relsym->st_name != 0)
 		return relsym;
 
+	/*
+	 * Strive to find a better symbol name, but the resulting name may not
+	 * match the symbol referenced in the original code.
+	 */
 	relsym_secindex = get_secindex(elf, relsym);
 	for (sym = elf->symtab_start; sym < elf->symtab_stop; sym++) {
 		if (get_secindex(elf, sym) != relsym_secindex)
@@ -1578,7 +1582,7 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 
 static int is_executable_section(struct elf_info* elf, unsigned int section_index)
 {
-	if (section_index > elf->num_sections)
+	if (section_index >= elf->num_sections)
 		fatal("section_index is outside elf->num_sections!\n");
 
 	return ((elf->sechdrs[section_index].sh_flags & SHF_EXECINSTR) == SHF_EXECINSTR);
@@ -1759,19 +1763,33 @@ static int addend_386_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 #define	R_ARM_THM_JUMP19	51
 #endif
 
+static int32_t sign_extend32(int32_t value, int index)
+{
+	uint8_t shift = 31 - index;
+
+	return (int32_t)(value << shift) >> shift;
+}
+
 static int addend_arm_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 {
 	unsigned int r_typ = ELF_R_TYPE(r->r_info);
+	Elf_Sym *sym = elf->symtab_start + ELF_R_SYM(r->r_info);
+	void *loc = reloc_location(elf, sechdr, r);
+	uint32_t inst;
+	int32_t offset;
 
 	switch (r_typ) {
 	case R_ARM_ABS32:
-		/* From ARM ABI: (S + A) | T */
-		r->r_addend = (int)(long)
-			      (elf->symtab_start + ELF_R_SYM(r->r_info));
+		inst = TO_NATIVE(*(uint32_t *)loc);
+		r->r_addend = inst + sym->st_value;
 		break;
 	case R_ARM_PC24:
 	case R_ARM_CALL:
 	case R_ARM_JUMP24:
+		inst = TO_NATIVE(*(uint32_t *)loc);
+		offset = sign_extend32((inst & 0x00ffffff) << 2, 25);
+		r->r_addend = offset + sym->st_value + 8;
+		break;
 	case R_ARM_THM_CALL:
 	case R_ARM_THM_JUMP24:
 	case R_ARM_THM_JUMP19:
diff --git a/scripts/tags.sh b/scripts/tags.sh
index d23dcbf17457..086341e10aa8 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -37,6 +37,13 @@ find_all_archs()
 	done
 }
 
+# gtags(1) refuses to index any file outside of its current working dir.
+# If gtags indexing is requested and the build output directory is not
+# the kernel source tree, index all files in absolute-path form.
+if [[ "$1" == "gtags" && -n "${tree}" ]]; then
+	tree=$(realpath "$tree")/
+fi
+
 # Detect if ALLSOURCE_ARCHS is set. If not, we assume SRCARCH
 if [ "${ALLSOURCE_ARCHS}" = "" ]; then
 	ALLSOURCE_ARCHS=${SRCARCH}
@@ -145,7 +152,7 @@ docscope()
 
 dogtags()
 {
-	all_target_sources | gtags -i -f -
+	all_target_sources | gtags -i -C "${tree:-.}" -f - "$PWD"
 }
 
 # Basic regular expressions with an optional /kind-spec/ for ctags and
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 6e761b07cb3f..9b7516661923 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -427,7 +427,9 @@ void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
 
 /**
  * evm_inode_setattr - prevent updating an invalid EVM extended attribute
+ * @idmap: idmap of the mount
  * @dentry: pointer to the affected dentry
+ * @attr: iattr structure containing the new file attributes
  *
  * Permit update of file attributes when files have a valid EVM signature,
  * except in the case of them having an immutable portable signature.
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index f4a40fb84b1e..e15cf861df7f 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -43,12 +43,10 @@ static struct integrity_iint_cache *__integrity_iint_find(struct inode *inode)
 		else if (inode > iint->inode)
 			n = n->rb_right;
 		else
-			break;
+			return iint;
 	}
-	if (!n)
-		return NULL;
 
-	return iint;
+	return NULL;
 }
 
 /*
@@ -112,10 +110,15 @@ struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
 		parent = *p;
 		test_iint = rb_entry(parent, struct integrity_iint_cache,
 				     rb_node);
-		if (inode < test_iint->inode)
+		if (inode < test_iint->inode) {
 			p = &(*p)->rb_left;
-		else
+		} else if (inode > test_iint->inode) {
 			p = &(*p)->rb_right;
+		} else {
+			write_unlock(&integrity_iint_lock);
+			kmem_cache_free(iint_cache, iint);
+			return test_iint;
+		}
 	}
 
 	iint->inode = inode;
diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index 00d826b048c4..eb6735f16b93 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -236,7 +236,7 @@ static int copy_ctl_value_from_user(struct snd_card *card,
 {
 	struct snd_ctl_elem_value32 __user *data32 = userdata;
 	int i, type, size;
-	int uninitialized_var(count);
+	int count;
 	unsigned int indirect;
 
 	if (copy_from_user(&data->id, &data32->id, sizeof(data->id)))
diff --git a/sound/isa/sb/sb16_csp.c b/sound/isa/sb/sb16_csp.c
index 00d059412c8a..8f3ff23a06a5 100644
--- a/sound/isa/sb/sb16_csp.c
+++ b/sound/isa/sb/sb16_csp.c
@@ -116,7 +116,7 @@ static void info_read(struct snd_info_entry *entry, struct snd_info_buffer *buff
 int snd_sb_csp_new(struct snd_sb *chip, int device, struct snd_hwdep ** rhwdep)
 {
 	struct snd_sb_csp *p;
-	int uninitialized_var(version);
+	int version;
 	int err;
 	struct snd_hwdep *hw;
 
diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index d5dfc7349e70..e37eab3ddc73 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -2026,8 +2026,8 @@ int snd_ac97_mixer(struct snd_ac97_bus *bus, struct snd_ac97_template *template,
 		.dev_disconnect =	snd_ac97_dev_disconnect,
 	};
 
-	if (rac97)
-		*rac97 = NULL;
+	if (!rac97)
+		return -EINVAL;
 	if (snd_BUG_ON(!bus || !template))
 		return -EINVAL;
 	if (snd_BUG_ON(template->num >= 4))
diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 0410f2e5183c..fad918c44ec9 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -45,7 +45,12 @@ static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(dac_vol_tlv, -9600, 50, 1);
 static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(adc_vol_tlv, -9600, 50, 1);
 static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(alc_max_gain_tlv, -650, 150, 0);
 static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(alc_min_gain_tlv, -1200, 150, 0);
-static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(alc_target_tlv, -1650, 150, 0);
+
+static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(alc_target_tlv,
+	0, 10, TLV_DB_SCALE_ITEM(-1650, 150, 0),
+	11, 11, TLV_DB_SCALE_ITEM(-150, 0, 0),
+);
+
 static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(hpmixer_gain_tlv,
 	0, 4, TLV_DB_SCALE_ITEM(-1200, 150, 0),
 	8, 11, TLV_DB_SCALE_ITEM(-450, 150, 0),
@@ -107,7 +112,7 @@ static const struct snd_kcontrol_new es8316_snd_controls[] = {
 		       alc_max_gain_tlv),
 	SOC_SINGLE_TLV("ALC Capture Min Volume", ES8316_ADC_ALC2, 0, 28, 0,
 		       alc_min_gain_tlv),
-	SOC_SINGLE_TLV("ALC Capture Target Volume", ES8316_ADC_ALC3, 4, 10, 0,
+	SOC_SINGLE_TLV("ALC Capture Target Volume", ES8316_ADC_ALC3, 4, 11, 0,
 		       alc_target_tlv),
 	SOC_SINGLE("ALC Capture Hold Time", ES8316_ADC_ALC3, 0, 10, 0),
 	SOC_SINGLE("ALC Capture Decay Time", ES8316_ADC_ALC4, 4, 10, 0),
diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 4fd350e8420d..a1570881551e 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -2261,6 +2261,9 @@ static int wm8904_i2c_probe(struct i2c_client *i2c,
 	regmap_update_bits(wm8904->regmap, WM8904_BIAS_CONTROL_0,
 			    WM8904_POBCTRL, 0);
 
+	/* Fill the cache for the ADC test register */
+	regmap_read(wm8904->regmap, WM8904_ADC_TEST_0, &val);
+
 	/* Can leave the device powered off until we need it */
 	regcache_cache_only(wm8904->regmap, true);
 	regulator_bulk_disable(ARRAY_SIZE(wm8904->supplies), wm8904->supplies);
diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 7e6cc4da0088..b079754aed40 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -618,6 +618,8 @@ static int fsl_spdif_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		regmap_update_bits(regmap, REG_SPDIF_SCR, dmaen, 0);
 		regmap_update_bits(regmap, REG_SPDIF_SIE, intr, 0);
+		regmap_write(regmap, REG_SPDIF_STL, 0x0);
+		regmap_write(regmap, REG_SPDIF_STR, 0x0);
 		break;
 	default:
 		return -EINVAL;
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index eefe3d1c0b93..370e8d17bfa5 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -324,7 +324,7 @@ static void queue_pending_output_urbs(struct snd_usb_endpoint *ep)
 	while (test_bit(EP_FLAG_RUNNING, &ep->flags)) {
 
 		unsigned long flags;
-		struct snd_usb_packet_info *uninitialized_var(packet);
+		struct snd_usb_packet_info *packet;
 		struct snd_urb_ctx *ctx = NULL;
 		struct urb *urb;
 		int err, i;
diff --git a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
new file mode 100644
index 000000000000..319f36ebb9a4
--- /dev/null
+++ b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
@@ -0,0 +1,83 @@
+#!/bin/bash
+# test perf probe of function from different CU
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+# skip if there's no gcc
+if ! [ -x "$(command -v gcc)" ]; then
+        echo "failed: no gcc compiler"
+        exit 2
+fi
+
+temp_dir=$(mktemp -d /tmp/perf-uprobe-different-cu-sh.XXXXXXXXXX)
+
+cleanup()
+{
+	trap - EXIT TERM INT
+	if [[ "${temp_dir}" =~ ^/tmp/perf-uprobe-different-cu-sh.*$ ]]; then
+		echo "--- Cleaning up ---"
+		perf probe -x ${temp_dir}/testfile -d foo || true
+		rm -f "${temp_dir}/"*
+		rmdir "${temp_dir}"
+	fi
+}
+
+trap_cleanup()
+{
+        cleanup
+        exit 1
+}
+
+trap trap_cleanup EXIT TERM INT
+
+cat > ${temp_dir}/testfile-foo.h << EOF
+struct t
+{
+  int *p;
+  int c;
+};
+
+extern int foo (int i, struct t *t);
+EOF
+
+cat > ${temp_dir}/testfile-foo.c << EOF
+#include "testfile-foo.h"
+
+int
+foo (int i, struct t *t)
+{
+  int j, res = 0;
+  for (j = 0; j < i && j < t->c; j++)
+    res += t->p[j];
+
+  return res;
+}
+EOF
+
+cat > ${temp_dir}/testfile-main.c << EOF
+#include "testfile-foo.h"
+
+static struct t g;
+
+int
+main (int argc, char **argv)
+{
+  int i;
+  int j[argc];
+  g.c = argc;
+  g.p = j;
+  for (i = 0; i < argc; i++)
+    j[i] = (int) argv[i][0];
+  return foo (3, &g);
+}
+EOF
+
+gcc -g -Og -flto -c ${temp_dir}/testfile-foo.c -o ${temp_dir}/testfile-foo.o
+gcc -g -Og -c ${temp_dir}/testfile-main.c -o ${temp_dir}/testfile-main.o
+gcc -g -Og -o ${temp_dir}/testfile ${temp_dir}/testfile-foo.o ${temp_dir}/testfile-main.o
+
+perf probe -x ${temp_dir}/testfile --funcs foo
+perf probe -x ${temp_dir}/testfile foo
+
+cleanup
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 7514aa9c68c9..f95c3d43b5cb 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1033,7 +1033,7 @@ int die_get_varname(Dwarf_Die *vr_die, struct strbuf *buf)
 	ret = die_get_typename(vr_die, buf);
 	if (ret < 0) {
 		pr_debug("Failed to get type, make it unknown.\n");
-		ret = strbuf_add(buf, " (unknown_type)", 14);
+		ret = strbuf_add(buf, "(unknown_type)", 14);
 	}
 
 	return ret < 0 ? ret : strbuf_addf(buf, "\t%s", dwarf_diename(vr_die));
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index e2a6c22959f2..aabd42378552 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1499,6 +1499,8 @@ static void intel_pt_calc_cbr(struct intel_pt_decoder *decoder)
 
 	decoder->cbr = cbr;
 	decoder->cbr_cyc_to_tsc = decoder->max_non_turbo_ratio_fp / cbr;
+	decoder->cyc_ref_timestamp = decoder->timestamp;
+	decoder->cycle_cnt = 0;
 }
 
 static void intel_pt_calc_cyc_timestamp(struct intel_pt_decoder *decoder)
