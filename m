Return-Path: <linux-kernel+bounces-129796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9216E897006
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280F629132F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95EF147C6C;
	Wed,  3 Apr 2024 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="neR/PJ2X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184CD1487C7;
	Wed,  3 Apr 2024 13:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150192; cv=none; b=EidnU8pnpxjUqnLSuJBYaUYxi4w7ijMkEBaPm5GlrKtonQau3n0qHOrZvBIRh3VM7DYmS64dEc1yZ0+WXeEsBqQH0Xpxi1DGBd7v2RR4l/WiY8OGoERK6356MxB0ZQG4yCIRoTQQg9fJFvtW86sQm9dUXXJNtmE5XQ+2tNlUTak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150192; c=relaxed/simple;
	bh=hp5TyjTuTMexX8n6UwBYWnkLWitiUS/tL5nO0W2jt9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P9w0VCDY+od844M/XdCnQTupkxp6jlmoPXwX7Fw2xZMy084BpIFZ6BRmOBwptABsOAnm54Hc7wDlTsWUQDQILDPjbULH6/FvlXfLYayQwz7R3yhxedKZ17xCtRQctoHcAdG+WUpQDD3mAPrpbCwwH2mvetZQCkW7Dis9dS4RKTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=neR/PJ2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838D8C43399;
	Wed,  3 Apr 2024 13:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712150190;
	bh=hp5TyjTuTMexX8n6UwBYWnkLWitiUS/tL5nO0W2jt9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=neR/PJ2Xrg8T5LD0V7JyowD9hTKgOwY/45TNNW3BFp3MYYeIrutRa2S07+Fd8YpBB
	 nDOEeClljWq4x4JdIAnrjjncaYRS+Hz4umkztWGpkXPPZ+HW/qwSxifiXr0TAAybBW
	 PX9ZskozCkTxphmtVYT0TDaQxVZepCVjsJOLAcWc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.7.12
Date: Wed,  3 Apr 2024 15:16:02 +0200
Message-ID: <2024040316-removing-freezing-4d66@gregkh>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <2024040316-sports-conceal-dbbb@gregkh>
References: <2024040316-sports-conceal-dbbb@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 40b89dd7c0bb..7120c4e1692f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3327,9 +3327,7 @@
 
 	mem_encrypt=	[X86-64] AMD Secure Memory Encryption (SME) control
 			Valid arguments: on, off
-			Default (depends on kernel configuration option):
-			  on  (CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y)
-			  off (CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=n)
+			Default: off
 			mem_encrypt=on:		Activate SME
 			mem_encrypt=off:	Do not activate SME
 
diff --git a/Documentation/arch/x86/amd-memory-encryption.rst b/Documentation/arch/x86/amd-memory-encryption.rst
index 07caa8fff852..414bc7402ae7 100644
--- a/Documentation/arch/x86/amd-memory-encryption.rst
+++ b/Documentation/arch/x86/amd-memory-encryption.rst
@@ -87,14 +87,14 @@ The state of SME in the Linux kernel can be documented as follows:
 	  kernel is non-zero).
 
 SME can also be enabled and activated in the BIOS. If SME is enabled and
-activated in the BIOS, then all memory accesses will be encrypted and it will
-not be necessary to activate the Linux memory encryption support.  If the BIOS
-merely enables SME (sets bit 23 of the MSR_AMD64_SYSCFG), then Linux can activate
-memory encryption by default (CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y) or
-by supplying mem_encrypt=on on the kernel command line.  However, if BIOS does
-not enable SME, then Linux will not be able to activate memory encryption, even
-if configured to do so by default or the mem_encrypt=on command line parameter
-is specified.
+activated in the BIOS, then all memory accesses will be encrypted and it
+will not be necessary to activate the Linux memory encryption support.
+
+If the BIOS merely enables SME (sets bit 23 of the MSR_AMD64_SYSCFG),
+then memory encryption can be enabled by supplying mem_encrypt=on on the
+kernel command line.  However, if BIOS does not enable SME, then Linux
+will not be able to activate memory encryption, even if configured to do
+so by default or the mem_encrypt=on command line parameter is specified.
 
 Secure Nested Paging (SNP)
 ==========================
diff --git a/Documentation/conf.py b/Documentation/conf.py
index dfc19c915d5c..e385e24fe9e7 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -345,9 +345,9 @@ sys.stderr.write("Using %s theme\n" % html_theme)
 html_static_path = ['sphinx-static']
 
 # If true, Docutils "smart quotes" will be used to convert quotes and dashes
-# to typographically correct entities.  This will convert "--" to "—",
-# which is not always what we want, so disable it.
-smartquotes = False
+# to typographically correct entities.  However, conversion of "--" to "—"
+# is not always what we want, so enable only quotes.
+smartquotes_action = 'q'
 
 # Custom sidebar templates, maps document names to template names.
 # Note that the RTD theme ignores this
diff --git a/Documentation/userspace-api/media/mediactl/media-types.rst b/Documentation/userspace-api/media/mediactl/media-types.rst
index 0ffeece1e0c8..6332e8395263 100644
--- a/Documentation/userspace-api/media/mediactl/media-types.rst
+++ b/Documentation/userspace-api/media/mediactl/media-types.rst
@@ -375,12 +375,11 @@ Types and flags used to represent the media graph elements
 	  are origins of links.
 
     *  -  ``MEDIA_PAD_FL_MUST_CONNECT``
-       -  If this flag is set and the pad is linked to any other pad, then
-	  at least one of those links must be enabled for the entity to be
-	  able to stream. There could be temporary reasons (e.g. device
-	  configuration dependent) for the pad to need enabled links even
-	  when this flag isn't set; the absence of the flag doesn't imply
-	  there is none.
+       -  If this flag is set, then for this pad to be able to stream, it must
+	  be connected by at least one enabled link. There could be temporary
+	  reasons (e.g. device configuration dependent) for the pad to need
+	  enabled links even when this flag isn't set; the absence of the flag
+	  doesn't imply there is none.
 
 
 One and only one of ``MEDIA_PAD_FL_SINK`` and ``MEDIA_PAD_FL_SOURCE``
diff --git a/Makefile b/Makefile
index 6e3182cdf016..190ed2b2e0ac 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 7
-SUBLEVEL = 11
+SUBLEVEL = 12
 EXTRAVERSION =
 NAME = Hurr durr I'ma ninja sloth
 
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8f47d6762ea4..f53832383a63 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -591,8 +591,8 @@ source "arch/arm/mm/Kconfig"
 
 config IWMMXT
 	bool "Enable iWMMXt support"
-	depends on CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_PJ4 || CPU_PJ4B
-	default y if PXA27x || PXA3xx || ARCH_MMP || CPU_PJ4 || CPU_PJ4B
+	depends on CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK
+	default y if PXA27x || PXA3xx || ARCH_MMP
 	help
 	  Enable support for iWMMXt context switching at run time if
 	  running on a CPU that supports it.
diff --git a/arch/arm/boot/dts/marvell/mmp2-brownstone.dts b/arch/arm/boot/dts/marvell/mmp2-brownstone.dts
index 04f1ae1382e7..bc64348b8218 100644
--- a/arch/arm/boot/dts/marvell/mmp2-brownstone.dts
+++ b/arch/arm/boot/dts/marvell/mmp2-brownstone.dts
@@ -28,7 +28,7 @@ &uart3 {
 &twsi1 {
 	status = "okay";
 	pmic: max8925@3c {
-		compatible = "maxium,max8925";
+		compatible = "maxim,max8925";
 		reg = <0x3c>;
 		interrupts = <1>;
 		interrupt-parent = <&intcmux4>;
diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 0a90583f9f01..8f9dbe8d9029 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -297,6 +297,7 @@ CONFIG_FB_MODE_HELPERS=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_L4F00242T03=y
 CONFIG_LCD_PLATFORM=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_PWM=y
 CONFIG_BACKLIGHT_GPIO=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
diff --git a/arch/arm/include/asm/mman.h b/arch/arm/include/asm/mman.h
new file mode 100644
index 000000000000..2189e507c8e0
--- /dev/null
+++ b/arch/arm/include/asm/mman.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_MMAN_H__
+#define __ASM_MMAN_H__
+
+#include <asm/system_info.h>
+#include <uapi/asm/mman.h>
+
+static inline bool arch_memory_deny_write_exec_supported(void)
+{
+	return cpu_architecture() >= CPU_ARCH_ARMv6;
+}
+#define arch_memory_deny_write_exec_supported arch_memory_deny_write_exec_supported
+
+#endif /* __ASM_MMAN_H__ */
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 771264d4726a..ae2f2b2b4e5a 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -75,8 +75,6 @@ obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_CPU_XSCALE)	+= xscale-cp0.o
 obj-$(CONFIG_CPU_XSC3)		+= xscale-cp0.o
 obj-$(CONFIG_CPU_MOHAWK)	+= xscale-cp0.o
-obj-$(CONFIG_CPU_PJ4)		+= pj4-cp0.o
-obj-$(CONFIG_CPU_PJ4B)		+= pj4-cp0.o
 obj-$(CONFIG_IWMMXT)		+= iwmmxt.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_regs.o perf_callchain.o
 obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event_xscale.o perf_event_v6.o \
diff --git a/arch/arm/kernel/iwmmxt.S b/arch/arm/kernel/iwmmxt.S
index a0218c4867b9..4a335d3c5969 100644
--- a/arch/arm/kernel/iwmmxt.S
+++ b/arch/arm/kernel/iwmmxt.S
@@ -18,18 +18,6 @@
 #include <asm/assembler.h>
 #include "iwmmxt.h"
 
-#if defined(CONFIG_CPU_PJ4) || defined(CONFIG_CPU_PJ4B)
-#define PJ4(code...)		code
-#define XSC(code...)
-#elif defined(CONFIG_CPU_MOHAWK) || \
-	defined(CONFIG_CPU_XSC3) || \
-	defined(CONFIG_CPU_XSCALE)
-#define PJ4(code...)
-#define XSC(code...)		code
-#else
-#error "Unsupported iWMMXt architecture"
-#endif
-
 #define MMX_WR0		 	(0x00)
 #define MMX_WR1		 	(0x08)
 #define MMX_WR2		 	(0x10)
@@ -81,17 +69,13 @@ ENDPROC(iwmmxt_undef_handler)
 ENTRY(iwmmxt_task_enable)
 	inc_preempt_count r10, r3
 
-	XSC(mrc	p15, 0, r2, c15, c1, 0)
-	PJ4(mrc p15, 0, r2, c1, c0, 2)
+	mrc	p15, 0, r2, c15, c1, 0
 	@ CP0 and CP1 accessible?
-	XSC(tst	r2, #0x3)
-	PJ4(tst	r2, #0xf)
+	tst	r2, #0x3
 	bne	4f				@ if so no business here
 	@ enable access to CP0 and CP1
-	XSC(orr	r2, r2, #0x3)
-	XSC(mcr	p15, 0, r2, c15, c1, 0)
-	PJ4(orr	r2, r2, #0xf)
-	PJ4(mcr	p15, 0, r2, c1, c0, 2)
+	orr	r2, r2, #0x3
+	mcr	p15, 0, r2, c15, c1, 0
 
 	ldr	r3, =concan_owner
 	ldr	r2, [r0, #S_PC]			@ current task pc value
@@ -218,12 +202,9 @@ ENTRY(iwmmxt_task_disable)
 	bne	1f				@ no: quit
 
 	@ enable access to CP0 and CP1
-	XSC(mrc	p15, 0, r4, c15, c1, 0)
-	XSC(orr	r4, r4, #0x3)
-	XSC(mcr	p15, 0, r4, c15, c1, 0)
-	PJ4(mrc p15, 0, r4, c1, c0, 2)
-	PJ4(orr	r4, r4, #0xf)
-	PJ4(mcr	p15, 0, r4, c1, c0, 2)
+	mrc	p15, 0, r4, c15, c1, 0
+	orr	r4, r4, #0x3
+	mcr	p15, 0, r4, c15, c1, 0
 
 	mov	r0, #0				@ nothing to load
 	str	r0, [r3]			@ no more current owner
@@ -232,10 +213,8 @@ ENTRY(iwmmxt_task_disable)
 	bl	concan_save
 
 	@ disable access to CP0 and CP1
-	XSC(bic	r4, r4, #0x3)
-	XSC(mcr	p15, 0, r4, c15, c1, 0)
-	PJ4(bic	r4, r4, #0xf)
-	PJ4(mcr	p15, 0, r4, c1, c0, 2)
+	bic	r4, r4, #0x3
+	mcr	p15, 0, r4, c15, c1, 0
 
 	mrc	p15, 0, r2, c2, c0, 0
 	mov	r2, r2				@ cpwait
@@ -330,11 +309,9 @@ ENDPROC(iwmmxt_task_restore)
  */
 ENTRY(iwmmxt_task_switch)
 
-	XSC(mrc	p15, 0, r1, c15, c1, 0)
-	PJ4(mrc	p15, 0, r1, c1, c0, 2)
+	mrc	p15, 0, r1, c15, c1, 0
 	@ CP0 and CP1 accessible?
-	XSC(tst	r1, #0x3)
-	PJ4(tst	r1, #0xf)
+	tst	r1, #0x3
 	bne	1f				@ yes: block them for next task
 
 	ldr	r2, =concan_owner
@@ -344,10 +321,8 @@ ENTRY(iwmmxt_task_switch)
 	retne	lr				@ no: leave Concan disabled
 
 1:	@ flip Concan access
-	XSC(eor	r1, r1, #0x3)
-	XSC(mcr	p15, 0, r1, c15, c1, 0)
-	PJ4(eor r1, r1, #0xf)
-	PJ4(mcr	p15, 0, r1, c1, c0, 2)
+	eor	r1, r1, #0x3
+	mcr	p15, 0, r1, c15, c1, 0
 
 	mrc	p15, 0, r1, c2, c0, 0
 	sub	pc, lr, r1, lsr #32		@ cpwait and return
diff --git a/arch/arm/kernel/pj4-cp0.c b/arch/arm/kernel/pj4-cp0.c
deleted file mode 100644
index 4bca8098c4ff..000000000000
--- a/arch/arm/kernel/pj4-cp0.c
+++ /dev/null
@@ -1,135 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * linux/arch/arm/kernel/pj4-cp0.c
- *
- * PJ4 iWMMXt coprocessor context switching and handling
- *
- * Copyright (c) 2010 Marvell International Inc.
- */
-
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <asm/thread_notify.h>
-#include <asm/cputype.h>
-
-static int iwmmxt_do(struct notifier_block *self, unsigned long cmd, void *t)
-{
-	struct thread_info *thread = t;
-
-	switch (cmd) {
-	case THREAD_NOTIFY_FLUSH:
-		/*
-		 * flush_thread() zeroes thread->fpstate, so no need
-		 * to do anything here.
-		 *
-		 * FALLTHROUGH: Ensure we don't try to overwrite our newly
-		 * initialised state information on the first fault.
-		 */
-
-	case THREAD_NOTIFY_EXIT:
-		iwmmxt_task_release(thread);
-		break;
-
-	case THREAD_NOTIFY_SWITCH:
-		iwmmxt_task_switch(thread);
-		break;
-	}
-
-	return NOTIFY_DONE;
-}
-
-static struct notifier_block __maybe_unused iwmmxt_notifier_block = {
-	.notifier_call	= iwmmxt_do,
-};
-
-
-static u32 __init pj4_cp_access_read(void)
-{
-	u32 value;
-
-	__asm__ __volatile__ (
-		"mrc	p15, 0, %0, c1, c0, 2\n\t"
-		: "=r" (value));
-	return value;
-}
-
-static void __init pj4_cp_access_write(u32 value)
-{
-	u32 temp;
-
-	__asm__ __volatile__ (
-		"mcr	p15, 0, %1, c1, c0, 2\n\t"
-#ifdef CONFIG_THUMB2_KERNEL
-		"isb\n\t"
-#else
-		"mrc	p15, 0, %0, c1, c0, 2\n\t"
-		"mov	%0, %0\n\t"
-		"sub	pc, pc, #4\n\t"
-#endif
-		: "=r" (temp) : "r" (value));
-}
-
-static int __init pj4_get_iwmmxt_version(void)
-{
-	u32 cp_access, wcid;
-
-	cp_access = pj4_cp_access_read();
-	pj4_cp_access_write(cp_access | 0xf);
-
-	/* check if coprocessor 0 and 1 are available */
-	if ((pj4_cp_access_read() & 0xf) != 0xf) {
-		pj4_cp_access_write(cp_access);
-		return -ENODEV;
-	}
-
-	/* read iWMMXt coprocessor id register p1, c0 */
-	__asm__ __volatile__ ("mrc    p1, 0, %0, c0, c0, 0\n" : "=r" (wcid));
-
-	pj4_cp_access_write(cp_access);
-
-	/* iWMMXt v1 */
-	if ((wcid & 0xffffff00) == 0x56051000)
-		return 1;
-	/* iWMMXt v2 */
-	if ((wcid & 0xffffff00) == 0x56052000)
-		return 2;
-
-	return -EINVAL;
-}
-
-/*
- * Disable CP0/CP1 on boot, and let call_fpe() and the iWMMXt lazy
- * switch code handle iWMMXt context switching.
- */
-static int __init pj4_cp0_init(void)
-{
-	u32 __maybe_unused cp_access;
-	int vers;
-
-	if (!cpu_is_pj4())
-		return 0;
-
-	vers = pj4_get_iwmmxt_version();
-	if (vers < 0)
-		return 0;
-
-#ifndef CONFIG_IWMMXT
-	pr_info("PJ4 iWMMXt coprocessor detected, but kernel support is missing.\n");
-#else
-	cp_access = pj4_cp_access_read() & ~0xf;
-	pj4_cp_access_write(cp_access);
-
-	pr_info("PJ4 iWMMXt v%d coprocessor enabled.\n", vers);
-	elf_hwcap |= HWCAP_IWMMXT;
-	thread_register_notifier(&iwmmxt_notifier_block);
-	register_iwmmxt_undef_handler();
-#endif
-
-	return 0;
-}
-
-late_initcall(pj4_cp0_init);
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index d19d140a10c7..0749cf8a6637 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -296,6 +296,9 @@ void __sync_icache_dcache(pte_t pteval)
 		return;
 
 	folio = page_folio(pfn_to_page(pfn));
+	if (folio_test_reserved(folio))
+		return;
+
 	if (cache_is_vipt_aliasing())
 		mapping = folio_flush_mapping(folio);
 	else
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 84de20c88a86..e456c9512f9c 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2147,8 +2147,16 @@ pcie1: pci@1c08000 {
 			ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
 
-			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi";
+			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi0", "msi1", "msi2", "msi3",
+					  "msi4", "msi5", "msi6", "msi7";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 0 0 434 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index f2055899ae7a..a993ad15ea9a 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -721,6 +721,8 @@ &pcie3a_phy {
 };
 
 &pcie4 {
+	max-link-speed = <2>;
+
 	perst-gpios = <&tlmm 141 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 139 GPIO_ACTIVE_LOW>;
 
diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index 20153d08edde..ff346be5c916 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
@@ -930,8 +930,8 @@ &sound {
 			"TX DMIC3", "MIC BIAS1",
 			"TX SWR_INPUT0", "ADC1_OUTPUT",
 			"TX SWR_INPUT1", "ADC2_OUTPUT",
-			"TX SWR_INPUT2", "ADC3_OUTPUT",
-			"TX SWR_INPUT3", "ADC4_OUTPUT";
+			"TX SWR_INPUT0", "ADC3_OUTPUT",
+			"TX SWR_INPUT1", "ADC4_OUTPUT";
 
 	wcd-playback-dai-link {
 		link-name = "WCD Playback";
diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index 9a70875028b7..3098bb6b93d6 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -745,7 +745,7 @@ &swr2 {
 	wcd_tx: codec@0,3 {
 		compatible = "sdw20217010d00";
 		reg = <0 3>;
-		qcom,tx-port-mapping = <1 1 2 3>;
+		qcom,tx-port-mapping = <2 2 3 4>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index eef811def39b..ad3d7ac29c6d 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -842,7 +842,7 @@ &swr2 {
 	wcd_tx: codec@0,3 {
 		compatible = "sdw20217010d00";
 		reg = <0 3>;
-		qcom,tx-port-mapping = <1 1 2 3>;
+		qcom,tx-port-mapping = <2 2 3 4>;
 	};
 };
 
diff --git a/arch/hexagon/kernel/vmlinux.lds.S b/arch/hexagon/kernel/vmlinux.lds.S
index 1140051a0c45..1150b77fa281 100644
--- a/arch/hexagon/kernel/vmlinux.lds.S
+++ b/arch/hexagon/kernel/vmlinux.lds.S
@@ -63,6 +63,7 @@ SECTIONS
 	STABS_DEBUG
 	DWARF_DEBUG
 	ELF_DETAILS
+	.hexagon.attributes 0 : { *(.hexagon.attributes) }
 
 	DISCARDS
 }
diff --git a/arch/loongarch/crypto/crc32-loongarch.c b/arch/loongarch/crypto/crc32-loongarch.c
index a49e507af38c..3eebea3a7b47 100644
--- a/arch/loongarch/crypto/crc32-loongarch.c
+++ b/arch/loongarch/crypto/crc32-loongarch.c
@@ -44,7 +44,6 @@ static u32 crc32_loongarch_hw(u32 crc_, const u8 *p, unsigned int len)
 
 		CRC32(crc, value, w);
 		p += sizeof(u32);
-		len -= sizeof(u32);
 	}
 
 	if (len & sizeof(u16)) {
@@ -80,7 +79,6 @@ static u32 crc32c_loongarch_hw(u32 crc_, const u8 *p, unsigned int len)
 
 		CRC32C(crc, value, w);
 		p += sizeof(u32);
-		len -= sizeof(u32);
 	}
 
 	if (len & sizeof(u16)) {
diff --git a/arch/loongarch/include/asm/Kbuild b/arch/loongarch/include/asm/Kbuild
index 93783fa24f6e..dede0b422cfb 100644
--- a/arch/loongarch/include/asm/Kbuild
+++ b/arch/loongarch/include/asm/Kbuild
@@ -4,6 +4,7 @@ generic-y += mcs_spinlock.h
 generic-y += parport.h
 generic-y += early_ioremap.h
 generic-y += qrwlock.h
+generic-y += qspinlock.h
 generic-y += rwsem.h
 generic-y += segment.h
 generic-y += user.h
diff --git a/arch/loongarch/include/asm/io.h b/arch/loongarch/include/asm/io.h
index c486c2341b66..4a8adcca329b 100644
--- a/arch/loongarch/include/asm/io.h
+++ b/arch/loongarch/include/asm/io.h
@@ -71,6 +71,8 @@ extern void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t
 #define memcpy_fromio(a, c, l) __memcpy_fromio((a), (c), (l))
 #define memcpy_toio(c, a, l)   __memcpy_toio((c), (a), (l))
 
+#define __io_aw() mmiowb()
+
 #include <asm-generic/io.h>
 
 #define ARCH_HAS_VALID_PHYS_ADDR_RANGE
diff --git a/arch/loongarch/include/asm/percpu.h b/arch/loongarch/include/asm/percpu.h
index 9b36ac003f89..8f290e5546cf 100644
--- a/arch/loongarch/include/asm/percpu.h
+++ b/arch/loongarch/include/asm/percpu.h
@@ -29,7 +29,12 @@ static inline void set_my_cpu_offset(unsigned long off)
 	__my_cpu_offset = off;
 	csr_write64(off, PERCPU_BASE_KS);
 }
-#define __my_cpu_offset __my_cpu_offset
+
+#define __my_cpu_offset					\
+({							\
+	__asm__ __volatile__("":"+r"(__my_cpu_offset));	\
+	__my_cpu_offset;				\
+})
 
 #define PERCPU_OP(op, asm_op, c_op)					\
 static __always_inline unsigned long __percpu_##op(void *ptr,		\
diff --git a/arch/loongarch/include/asm/qspinlock.h b/arch/loongarch/include/asm/qspinlock.h
deleted file mode 100644
index 34f43f8ad591..000000000000
--- a/arch/loongarch/include/asm/qspinlock.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_QSPINLOCK_H
-#define _ASM_QSPINLOCK_H
-
-#include <asm-generic/qspinlock_types.h>
-
-#define queued_spin_unlock queued_spin_unlock
-
-static inline void queued_spin_unlock(struct qspinlock *lock)
-{
-	compiletime_assert_atomic_type(lock->locked);
-	c_sync();
-	WRITE_ONCE(lock->locked, 0);
-}
-
-#include <asm-generic/qspinlock.h>
-
-#endif /* _ASM_QSPINLOCK_H */
diff --git a/arch/parisc/include/asm/assembly.h b/arch/parisc/include/asm/assembly.h
index 5937d5edaba1..000a28e1c5e8 100644
--- a/arch/parisc/include/asm/assembly.h
+++ b/arch/parisc/include/asm/assembly.h
@@ -97,26 +97,28 @@
 	 * version takes two arguments: a src and destination register.
 	 * However, the source and destination registers can not be
 	 * the same register.
+	 *
+	 * We use add,l to avoid clobbering the C/B bits in the PSW.
 	 */
 
 	.macro  tophys  grvirt, grphys
-	ldil    L%(__PAGE_OFFSET), \grphys
-	sub     \grvirt, \grphys, \grphys
+	ldil    L%(-__PAGE_OFFSET), \grphys
+	addl    \grvirt, \grphys, \grphys
 	.endm
-	
+
 	.macro  tovirt  grphys, grvirt
 	ldil    L%(__PAGE_OFFSET), \grvirt
-	add     \grphys, \grvirt, \grvirt
+	addl    \grphys, \grvirt, \grvirt
 	.endm
 
 	.macro  tophys_r1  gr
-	ldil    L%(__PAGE_OFFSET), %r1
-	sub     \gr, %r1, \gr
+	ldil    L%(-__PAGE_OFFSET), %r1
+	addl    \gr, %r1, \gr
 	.endm
-	
+
 	.macro  tovirt_r1  gr
 	ldil    L%(__PAGE_OFFSET), %r1
-	add     \gr, %r1, \gr
+	addl    \gr, %r1, \gr
 	.endm
 
 	.macro delay value
diff --git a/arch/parisc/include/asm/checksum.h b/arch/parisc/include/asm/checksum.h
index 3c43baca7b39..2aceebcd695c 100644
--- a/arch/parisc/include/asm/checksum.h
+++ b/arch/parisc/include/asm/checksum.h
@@ -40,7 +40,7 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 "	addc		%0, %5, %0\n"
 "	addc		%0, %3, %0\n"
 "1:	ldws,ma		4(%1), %3\n"
-"	addib,<		0, %2, 1b\n"
+"	addib,>		-1, %2, 1b\n"
 "	addc		%0, %3, %0\n"
 "\n"
 "	extru		%0, 31, 16, %4\n"
@@ -126,6 +126,7 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 	** Try to keep 4 registers with "live" values ahead of the ALU.
 	*/
 
+"	depdi		0, 31, 32, %0\n"/* clear upper half of incoming checksum */
 "	ldd,ma		8(%1), %4\n"	/* get 1st saddr word */
 "	ldd,ma		8(%2), %5\n"	/* get 1st daddr word */
 "	add		%4, %0, %0\n"
@@ -137,8 +138,8 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 "	add,dc		%3, %0, %0\n"  /* fold in proto+len | carry bit */
 "	extrd,u		%0, 31, 32, %4\n"/* copy upper half down */
 "	depdi		0, 31, 32, %0\n"/* clear upper half */
-"	add		%4, %0, %0\n"	/* fold into 32-bits */
-"	addc		0, %0, %0\n"	/* add carry */
+"	add,dc		%4, %0, %0\n"	/* fold into 32-bits, plus carry */
+"	addc		0, %0, %0\n"	/* add final carry */
 
 #else
 
@@ -163,7 +164,8 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 "	ldw,ma		4(%2), %7\n"	/* 4th daddr */
 "	addc		%6, %0, %0\n"
 "	addc		%7, %0, %0\n"
-"	addc		%3, %0, %0\n"	/* fold in proto+len, catch carry */
+"	addc		%3, %0, %0\n"	/* fold in proto+len */
+"	addc		0, %0, %0\n"	/* add carry */
 
 #endif
 	: "=r" (sum), "=r" (saddr), "=r" (daddr), "=r" (len),
diff --git a/arch/parisc/include/asm/mman.h b/arch/parisc/include/asm/mman.h
new file mode 100644
index 000000000000..47c5a1991d10
--- /dev/null
+++ b/arch/parisc/include/asm/mman.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_MMAN_H__
+#define __ASM_MMAN_H__
+
+#include <uapi/asm/mman.h>
+
+/* PARISC cannot allow mdwe as it needs writable stacks */
+static inline bool arch_memory_deny_write_exec_supported(void)
+{
+	return false;
+}
+#define arch_memory_deny_write_exec_supported arch_memory_deny_write_exec_supported
+
+#endif /* __ASM_MMAN_H__ */
diff --git a/arch/parisc/kernel/unaligned.c b/arch/parisc/kernel/unaligned.c
index c520e551a165..a8e75e5b884a 100644
--- a/arch/parisc/kernel/unaligned.c
+++ b/arch/parisc/kernel/unaligned.c
@@ -169,6 +169,7 @@ static int emulate_ldw(struct pt_regs *regs, int toreg, int flop)
 static int emulate_ldd(struct pt_regs *regs, int toreg, int flop)
 {
 	unsigned long saddr = regs->ior;
+	unsigned long shift, temp1;
 	__u64 val = 0;
 	ASM_EXCEPTIONTABLE_VAR(ret);
 
@@ -180,25 +181,22 @@ static int emulate_ldd(struct pt_regs *regs, int toreg, int flop)
 
 #ifdef CONFIG_64BIT
 	__asm__ __volatile__  (
-"	depd,z	%3,60,3,%%r19\n"		/* r19=(ofs&7)*8 */
-"	mtsp	%4, %%sr1\n"
-"	depd	%%r0,63,3,%3\n"
-"1:	ldd	0(%%sr1,%3),%0\n"
-"2:	ldd	8(%%sr1,%3),%%r20\n"
-"	subi	64,%%r19,%%r19\n"
-"	mtsar	%%r19\n"
-"	shrpd	%0,%%r20,%%sar,%0\n"
+"	depd,z	%2,60,3,%3\n"		/* shift=(ofs&7)*8 */
+"	mtsp	%5, %%sr1\n"
+"	depd	%%r0,63,3,%2\n"
+"1:	ldd	0(%%sr1,%2),%0\n"
+"2:	ldd	8(%%sr1,%2),%4\n"
+"	subi	64,%3,%3\n"
+"	mtsar	%3\n"
+"	shrpd	%0,%4,%%sar,%0\n"
 "3:	\n"
 	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 3b, "%1")
 	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(2b, 3b, "%1")
-	: "=r" (val), "+r" (ret)
-	: "0" (val), "r" (saddr), "r" (regs->isr)
-	: "r19", "r20" );
+	: "+r" (val), "+r" (ret), "+r" (saddr), "=&r" (shift), "=&r" (temp1)
+	: "r" (regs->isr) );
 #else
-    {
-	unsigned long shift, temp1;
 	__asm__ __volatile__  (
-"	zdep	%2,29,2,%3\n"		/* r19=(ofs&3)*8 */
+"	zdep	%2,29,2,%3\n"		/* shift=(ofs&3)*8 */
 "	mtsp	%5, %%sr1\n"
 "	dep	%%r0,31,2,%2\n"
 "1:	ldw	0(%%sr1,%2),%0\n"
@@ -214,7 +212,6 @@ static int emulate_ldd(struct pt_regs *regs, int toreg, int flop)
 	ASM_EXCEPTIONTABLE_ENTRY_EFAULT(3b, 4b, "%1")
 	: "+r" (val), "+r" (ret), "+r" (saddr), "=&r" (shift), "=&r" (temp1)
 	: "r" (regs->isr) );
-    }
 #endif
 
 	DPRINTF("val = 0x%llx\n", val);
diff --git a/arch/powerpc/include/asm/reg_fsl_emb.h b/arch/powerpc/include/asm/reg_fsl_emb.h
index a21f529c43d9..8359c06d92d9 100644
--- a/arch/powerpc/include/asm/reg_fsl_emb.h
+++ b/arch/powerpc/include/asm/reg_fsl_emb.h
@@ -12,9 +12,16 @@
 #ifndef __ASSEMBLY__
 /* Performance Monitor Registers */
 #define mfpmr(rn)	({unsigned int rval; \
-			asm volatile("mfpmr %0," __stringify(rn) \
+			asm volatile(".machine push; " \
+				     ".machine e300; " \
+				     "mfpmr %0," __stringify(rn) ";" \
+				     ".machine pop; " \
 				     : "=r" (rval)); rval;})
-#define mtpmr(rn, v)	asm volatile("mtpmr " __stringify(rn) ",%0" : : "r" (v))
+#define mtpmr(rn, v)	asm volatile(".machine push; " \
+				     ".machine e300; " \
+				     "mtpmr " __stringify(rn) ",%0; " \
+				     ".machine pop; " \
+				     : : "r" (v))
 #endif /* __ASSEMBLY__ */
 
 /* Freescale Book E Performance Monitor APU Registers */
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 0b5878c3125b..77364729a1b6 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -375,6 +375,18 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	if (IS_ENABLED(CONFIG_PPC64))
 		boot_cpu_hwid = be32_to_cpu(intserv[found_thread]);
 
+	if (nr_cpu_ids % nthreads != 0) {
+		set_nr_cpu_ids(ALIGN(nr_cpu_ids, nthreads));
+		pr_warn("nr_cpu_ids was not a multiple of threads_per_core, adjusted to %d\n",
+			nr_cpu_ids);
+	}
+
+	if (boot_cpuid >= nr_cpu_ids) {
+		set_nr_cpu_ids(min(CONFIG_NR_CPUS, ALIGN(boot_cpuid + 1, nthreads)));
+		pr_warn("Boot CPU %d >= nr_cpu_ids, adjusted nr_cpu_ids to %d\n",
+			boot_cpuid, nr_cpu_ids);
+	}
+
 	/*
 	 * PAPR defines "logical" PVR values for cpus that
 	 * meet various levels of the architecture:
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 6eac63e79a89..0ab65eeb93ee 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -76,7 +76,7 @@ obj-$(CONFIG_PPC_LIB_RHEAP) += rheap.o
 obj-$(CONFIG_FTR_FIXUP_SELFTEST) += feature-fixups-test.o
 
 obj-$(CONFIG_ALTIVEC)	+= xor_vmx.o xor_vmx_glue.o
-CFLAGS_xor_vmx.o += -maltivec $(call cc-option,-mabi=altivec)
+CFLAGS_xor_vmx.o += -mhard-float -maltivec $(call cc-option,-mabi=altivec)
 # Enable <altivec.h>
 CFLAGS_xor_vmx.o += -isystem $(shell $(CC) -print-file-name=include)
 
diff --git a/arch/sparc/include/asm/parport.h b/arch/sparc/include/asm/parport.h
index 0a7ffcfd59cd..e2eed8f97665 100644
--- a/arch/sparc/include/asm/parport.h
+++ b/arch/sparc/include/asm/parport.h
@@ -1,256 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* parport.h: sparc64 specific parport initialization and dma.
- *
- * Copyright (C) 1999  Eddie C. Dost  (ecd@skynet.be)
- */
+#ifndef ___ASM_SPARC_PARPORT_H
+#define ___ASM_SPARC_PARPORT_H
 
-#ifndef _ASM_SPARC64_PARPORT_H
-#define _ASM_SPARC64_PARPORT_H 1
-
-#include <linux/of.h>
-#include <linux/platform_device.h>
-
-#include <asm/ebus_dma.h>
-#include <asm/ns87303.h>
-#include <asm/prom.h>
-
-#define PARPORT_PC_MAX_PORTS	PARPORT_MAX
-
-/*
- * While sparc64 doesn't have an ISA DMA API, we provide something that looks
- * close enough to make parport_pc happy
- */
-#define HAS_DMA
-
-#ifdef CONFIG_PARPORT_PC_FIFO
-static DEFINE_SPINLOCK(dma_spin_lock);
-
-#define claim_dma_lock() \
-({	unsigned long flags; \
-	spin_lock_irqsave(&dma_spin_lock, flags); \
-	flags; \
-})
-
-#define release_dma_lock(__flags) \
-	spin_unlock_irqrestore(&dma_spin_lock, __flags);
+#if defined(__sparc__) && defined(__arch64__)
+#include <asm/parport_64.h>
+#else
+#include <asm-generic/parport.h>
+#endif
 #endif
 
-static struct sparc_ebus_info {
-	struct ebus_dma_info info;
-	unsigned int addr;
-	unsigned int count;
-	int lock;
-
-	struct parport *port;
-} sparc_ebus_dmas[PARPORT_PC_MAX_PORTS];
-
-static DECLARE_BITMAP(dma_slot_map, PARPORT_PC_MAX_PORTS);
-
-static inline int request_dma(unsigned int dmanr, const char *device_id)
-{
-	if (dmanr >= PARPORT_PC_MAX_PORTS)
-		return -EINVAL;
-	if (xchg(&sparc_ebus_dmas[dmanr].lock, 1) != 0)
-		return -EBUSY;
-	return 0;
-}
-
-static inline void free_dma(unsigned int dmanr)
-{
-	if (dmanr >= PARPORT_PC_MAX_PORTS) {
-		printk(KERN_WARNING "Trying to free DMA%d\n", dmanr);
-		return;
-	}
-	if (xchg(&sparc_ebus_dmas[dmanr].lock, 0) == 0) {
-		printk(KERN_WARNING "Trying to free free DMA%d\n", dmanr);
-		return;
-	}
-}
-
-static inline void enable_dma(unsigned int dmanr)
-{
-	ebus_dma_enable(&sparc_ebus_dmas[dmanr].info, 1);
-
-	if (ebus_dma_request(&sparc_ebus_dmas[dmanr].info,
-			     sparc_ebus_dmas[dmanr].addr,
-			     sparc_ebus_dmas[dmanr].count))
-		BUG();
-}
-
-static inline void disable_dma(unsigned int dmanr)
-{
-	ebus_dma_enable(&sparc_ebus_dmas[dmanr].info, 0);
-}
-
-static inline void clear_dma_ff(unsigned int dmanr)
-{
-	/* nothing */
-}
-
-static inline void set_dma_mode(unsigned int dmanr, char mode)
-{
-	ebus_dma_prepare(&sparc_ebus_dmas[dmanr].info, (mode != DMA_MODE_WRITE));
-}
-
-static inline void set_dma_addr(unsigned int dmanr, unsigned int addr)
-{
-	sparc_ebus_dmas[dmanr].addr = addr;
-}
-
-static inline void set_dma_count(unsigned int dmanr, unsigned int count)
-{
-	sparc_ebus_dmas[dmanr].count = count;
-}
-
-static inline unsigned int get_dma_residue(unsigned int dmanr)
-{
-	return ebus_dma_residue(&sparc_ebus_dmas[dmanr].info);
-}
-
-static int ecpp_probe(struct platform_device *op)
-{
-	unsigned long base = op->resource[0].start;
-	unsigned long config = op->resource[1].start;
-	unsigned long d_base = op->resource[2].start;
-	unsigned long d_len;
-	struct device_node *parent;
-	struct parport *p;
-	int slot, err;
-
-	parent = op->dev.of_node->parent;
-	if (of_node_name_eq(parent, "dma")) {
-		p = parport_pc_probe_port(base, base + 0x400,
-					  op->archdata.irqs[0], PARPORT_DMA_NOFIFO,
-					  op->dev.parent->parent, 0);
-		if (!p)
-			return -ENOMEM;
-		dev_set_drvdata(&op->dev, p);
-		return 0;
-	}
-
-	for (slot = 0; slot < PARPORT_PC_MAX_PORTS; slot++) {
-		if (!test_and_set_bit(slot, dma_slot_map))
-			break;
-	}
-	err = -ENODEV;
-	if (slot >= PARPORT_PC_MAX_PORTS)
-		goto out_err;
-
-	spin_lock_init(&sparc_ebus_dmas[slot].info.lock);
-
-	d_len = (op->resource[2].end - d_base) + 1UL;
-	sparc_ebus_dmas[slot].info.regs =
-		of_ioremap(&op->resource[2], 0, d_len, "ECPP DMA");
-
-	if (!sparc_ebus_dmas[slot].info.regs)
-		goto out_clear_map;
-
-	sparc_ebus_dmas[slot].info.flags = 0;
-	sparc_ebus_dmas[slot].info.callback = NULL;
-	sparc_ebus_dmas[slot].info.client_cookie = NULL;
-	sparc_ebus_dmas[slot].info.irq = 0xdeadbeef;
-	strcpy(sparc_ebus_dmas[slot].info.name, "parport");
-	if (ebus_dma_register(&sparc_ebus_dmas[slot].info))
-		goto out_unmap_regs;
-
-	ebus_dma_irq_enable(&sparc_ebus_dmas[slot].info, 1);
-
-	/* Configure IRQ to Push Pull, Level Low */
-	/* Enable ECP, set bit 2 of the CTR first */
-	outb(0x04, base + 0x02);
-	ns87303_modify(config, PCR,
-		       PCR_EPP_ENABLE |
-		       PCR_IRQ_ODRAIN,
-		       PCR_ECP_ENABLE |
-		       PCR_ECP_CLK_ENA |
-		       PCR_IRQ_POLAR);
-
-	/* CTR bit 5 controls direction of port */
-	ns87303_modify(config, PTR,
-		       0, PTR_LPT_REG_DIR);
-
-	p = parport_pc_probe_port(base, base + 0x400,
-				  op->archdata.irqs[0],
-				  slot,
-				  op->dev.parent,
-				  0);
-	err = -ENOMEM;
-	if (!p)
-		goto out_disable_irq;
-
-	dev_set_drvdata(&op->dev, p);
-
-	return 0;
-
-out_disable_irq:
-	ebus_dma_irq_enable(&sparc_ebus_dmas[slot].info, 0);
-	ebus_dma_unregister(&sparc_ebus_dmas[slot].info);
-
-out_unmap_regs:
-	of_iounmap(&op->resource[2], sparc_ebus_dmas[slot].info.regs, d_len);
-
-out_clear_map:
-	clear_bit(slot, dma_slot_map);
-
-out_err:
-	return err;
-}
-
-static int ecpp_remove(struct platform_device *op)
-{
-	struct parport *p = dev_get_drvdata(&op->dev);
-	int slot = p->dma;
-
-	parport_pc_unregister_port(p);
-
-	if (slot != PARPORT_DMA_NOFIFO) {
-		unsigned long d_base = op->resource[2].start;
-		unsigned long d_len;
-
-		d_len = (op->resource[2].end - d_base) + 1UL;
-
-		ebus_dma_irq_enable(&sparc_ebus_dmas[slot].info, 0);
-		ebus_dma_unregister(&sparc_ebus_dmas[slot].info);
-		of_iounmap(&op->resource[2],
-			   sparc_ebus_dmas[slot].info.regs,
-			   d_len);
-		clear_bit(slot, dma_slot_map);
-	}
-
-	return 0;
-}
-
-static const struct of_device_id ecpp_match[] = {
-	{
-		.name = "ecpp",
-	},
-	{
-		.name = "parallel",
-		.compatible = "ecpp",
-	},
-	{
-		.name = "parallel",
-		.compatible = "ns87317-ecpp",
-	},
-	{
-		.name = "parallel",
-		.compatible = "pnpALI,1533,3",
-	},
-	{},
-};
-
-static struct platform_driver ecpp_driver = {
-	.driver = {
-		.name = "ecpp",
-		.of_match_table = ecpp_match,
-	},
-	.probe			= ecpp_probe,
-	.remove			= ecpp_remove,
-};
-
-static int parport_pc_find_nonpci_ports(int autoirq, int autodma)
-{
-	return platform_driver_register(&ecpp_driver);
-}
-
-#endif /* !(_ASM_SPARC64_PARPORT_H */
diff --git a/arch/sparc/include/asm/parport_64.h b/arch/sparc/include/asm/parport_64.h
new file mode 100644
index 000000000000..0a7ffcfd59cd
--- /dev/null
+++ b/arch/sparc/include/asm/parport_64.h
@@ -0,0 +1,256 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* parport.h: sparc64 specific parport initialization and dma.
+ *
+ * Copyright (C) 1999  Eddie C. Dost  (ecd@skynet.be)
+ */
+
+#ifndef _ASM_SPARC64_PARPORT_H
+#define _ASM_SPARC64_PARPORT_H 1
+
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include <asm/ebus_dma.h>
+#include <asm/ns87303.h>
+#include <asm/prom.h>
+
+#define PARPORT_PC_MAX_PORTS	PARPORT_MAX
+
+/*
+ * While sparc64 doesn't have an ISA DMA API, we provide something that looks
+ * close enough to make parport_pc happy
+ */
+#define HAS_DMA
+
+#ifdef CONFIG_PARPORT_PC_FIFO
+static DEFINE_SPINLOCK(dma_spin_lock);
+
+#define claim_dma_lock() \
+({	unsigned long flags; \
+	spin_lock_irqsave(&dma_spin_lock, flags); \
+	flags; \
+})
+
+#define release_dma_lock(__flags) \
+	spin_unlock_irqrestore(&dma_spin_lock, __flags);
+#endif
+
+static struct sparc_ebus_info {
+	struct ebus_dma_info info;
+	unsigned int addr;
+	unsigned int count;
+	int lock;
+
+	struct parport *port;
+} sparc_ebus_dmas[PARPORT_PC_MAX_PORTS];
+
+static DECLARE_BITMAP(dma_slot_map, PARPORT_PC_MAX_PORTS);
+
+static inline int request_dma(unsigned int dmanr, const char *device_id)
+{
+	if (dmanr >= PARPORT_PC_MAX_PORTS)
+		return -EINVAL;
+	if (xchg(&sparc_ebus_dmas[dmanr].lock, 1) != 0)
+		return -EBUSY;
+	return 0;
+}
+
+static inline void free_dma(unsigned int dmanr)
+{
+	if (dmanr >= PARPORT_PC_MAX_PORTS) {
+		printk(KERN_WARNING "Trying to free DMA%d\n", dmanr);
+		return;
+	}
+	if (xchg(&sparc_ebus_dmas[dmanr].lock, 0) == 0) {
+		printk(KERN_WARNING "Trying to free free DMA%d\n", dmanr);
+		return;
+	}
+}
+
+static inline void enable_dma(unsigned int dmanr)
+{
+	ebus_dma_enable(&sparc_ebus_dmas[dmanr].info, 1);
+
+	if (ebus_dma_request(&sparc_ebus_dmas[dmanr].info,
+			     sparc_ebus_dmas[dmanr].addr,
+			     sparc_ebus_dmas[dmanr].count))
+		BUG();
+}
+
+static inline void disable_dma(unsigned int dmanr)
+{
+	ebus_dma_enable(&sparc_ebus_dmas[dmanr].info, 0);
+}
+
+static inline void clear_dma_ff(unsigned int dmanr)
+{
+	/* nothing */
+}
+
+static inline void set_dma_mode(unsigned int dmanr, char mode)
+{
+	ebus_dma_prepare(&sparc_ebus_dmas[dmanr].info, (mode != DMA_MODE_WRITE));
+}
+
+static inline void set_dma_addr(unsigned int dmanr, unsigned int addr)
+{
+	sparc_ebus_dmas[dmanr].addr = addr;
+}
+
+static inline void set_dma_count(unsigned int dmanr, unsigned int count)
+{
+	sparc_ebus_dmas[dmanr].count = count;
+}
+
+static inline unsigned int get_dma_residue(unsigned int dmanr)
+{
+	return ebus_dma_residue(&sparc_ebus_dmas[dmanr].info);
+}
+
+static int ecpp_probe(struct platform_device *op)
+{
+	unsigned long base = op->resource[0].start;
+	unsigned long config = op->resource[1].start;
+	unsigned long d_base = op->resource[2].start;
+	unsigned long d_len;
+	struct device_node *parent;
+	struct parport *p;
+	int slot, err;
+
+	parent = op->dev.of_node->parent;
+	if (of_node_name_eq(parent, "dma")) {
+		p = parport_pc_probe_port(base, base + 0x400,
+					  op->archdata.irqs[0], PARPORT_DMA_NOFIFO,
+					  op->dev.parent->parent, 0);
+		if (!p)
+			return -ENOMEM;
+		dev_set_drvdata(&op->dev, p);
+		return 0;
+	}
+
+	for (slot = 0; slot < PARPORT_PC_MAX_PORTS; slot++) {
+		if (!test_and_set_bit(slot, dma_slot_map))
+			break;
+	}
+	err = -ENODEV;
+	if (slot >= PARPORT_PC_MAX_PORTS)
+		goto out_err;
+
+	spin_lock_init(&sparc_ebus_dmas[slot].info.lock);
+
+	d_len = (op->resource[2].end - d_base) + 1UL;
+	sparc_ebus_dmas[slot].info.regs =
+		of_ioremap(&op->resource[2], 0, d_len, "ECPP DMA");
+
+	if (!sparc_ebus_dmas[slot].info.regs)
+		goto out_clear_map;
+
+	sparc_ebus_dmas[slot].info.flags = 0;
+	sparc_ebus_dmas[slot].info.callback = NULL;
+	sparc_ebus_dmas[slot].info.client_cookie = NULL;
+	sparc_ebus_dmas[slot].info.irq = 0xdeadbeef;
+	strcpy(sparc_ebus_dmas[slot].info.name, "parport");
+	if (ebus_dma_register(&sparc_ebus_dmas[slot].info))
+		goto out_unmap_regs;
+
+	ebus_dma_irq_enable(&sparc_ebus_dmas[slot].info, 1);
+
+	/* Configure IRQ to Push Pull, Level Low */
+	/* Enable ECP, set bit 2 of the CTR first */
+	outb(0x04, base + 0x02);
+	ns87303_modify(config, PCR,
+		       PCR_EPP_ENABLE |
+		       PCR_IRQ_ODRAIN,
+		       PCR_ECP_ENABLE |
+		       PCR_ECP_CLK_ENA |
+		       PCR_IRQ_POLAR);
+
+	/* CTR bit 5 controls direction of port */
+	ns87303_modify(config, PTR,
+		       0, PTR_LPT_REG_DIR);
+
+	p = parport_pc_probe_port(base, base + 0x400,
+				  op->archdata.irqs[0],
+				  slot,
+				  op->dev.parent,
+				  0);
+	err = -ENOMEM;
+	if (!p)
+		goto out_disable_irq;
+
+	dev_set_drvdata(&op->dev, p);
+
+	return 0;
+
+out_disable_irq:
+	ebus_dma_irq_enable(&sparc_ebus_dmas[slot].info, 0);
+	ebus_dma_unregister(&sparc_ebus_dmas[slot].info);
+
+out_unmap_regs:
+	of_iounmap(&op->resource[2], sparc_ebus_dmas[slot].info.regs, d_len);
+
+out_clear_map:
+	clear_bit(slot, dma_slot_map);
+
+out_err:
+	return err;
+}
+
+static int ecpp_remove(struct platform_device *op)
+{
+	struct parport *p = dev_get_drvdata(&op->dev);
+	int slot = p->dma;
+
+	parport_pc_unregister_port(p);
+
+	if (slot != PARPORT_DMA_NOFIFO) {
+		unsigned long d_base = op->resource[2].start;
+		unsigned long d_len;
+
+		d_len = (op->resource[2].end - d_base) + 1UL;
+
+		ebus_dma_irq_enable(&sparc_ebus_dmas[slot].info, 0);
+		ebus_dma_unregister(&sparc_ebus_dmas[slot].info);
+		of_iounmap(&op->resource[2],
+			   sparc_ebus_dmas[slot].info.regs,
+			   d_len);
+		clear_bit(slot, dma_slot_map);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id ecpp_match[] = {
+	{
+		.name = "ecpp",
+	},
+	{
+		.name = "parallel",
+		.compatible = "ecpp",
+	},
+	{
+		.name = "parallel",
+		.compatible = "ns87317-ecpp",
+	},
+	{
+		.name = "parallel",
+		.compatible = "pnpALI,1533,3",
+	},
+	{},
+};
+
+static struct platform_driver ecpp_driver = {
+	.driver = {
+		.name = "ecpp",
+		.of_match_table = ecpp_match,
+	},
+	.probe			= ecpp_probe,
+	.remove			= ecpp_remove,
+};
+
+static int parport_pc_find_nonpci_ports(int autoirq, int autodma)
+{
+	return platform_driver_register(&ecpp_driver);
+}
+
+#endif /* !(_ASM_SPARC64_PARPORT_H */
diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
index 17cdfdbf1f3b..149adc094753 100644
--- a/arch/sparc/kernel/nmi.c
+++ b/arch/sparc/kernel/nmi.c
@@ -279,7 +279,7 @@ static int __init setup_nmi_watchdog(char *str)
 	if (!strncmp(str, "panic", 5))
 		panic_on_timeout = 1;
 
-	return 0;
+	return 1;
 }
 __setup("nmi_watchdog=", setup_nmi_watchdog);
 
diff --git a/arch/sparc/vdso/vma.c b/arch/sparc/vdso/vma.c
index 136c78f28f8b..1bbf4335de45 100644
--- a/arch/sparc/vdso/vma.c
+++ b/arch/sparc/vdso/vma.c
@@ -449,9 +449,8 @@ static __init int vdso_setup(char *s)
 	unsigned long val;
 
 	err = kstrtoul(s, 10, &val);
-	if (err)
-		return err;
-	vdso_enabled = val;
-	return 0;
+	if (!err)
+		vdso_enabled = val;
+	return 1;
 }
 __setup("vdso=", vdso_setup);
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d2003865b7cf..92412748582c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1539,19 +1539,6 @@ config AMD_MEM_ENCRYPT
 	  This requires an AMD processor that supports Secure Memory
 	  Encryption (SME).
 
-config AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
-	bool "Activate AMD Secure Memory Encryption (SME) by default"
-	depends on AMD_MEM_ENCRYPT
-	help
-	  Say yes to have system memory encrypted by default if running on
-	  an AMD processor that supports Secure Memory Encryption (SME).
-
-	  If set to Y, then the encryption of system memory can be
-	  deactivated with the mem_encrypt=off command line option.
-
-	  If set to N, then the encryption of system memory can be
-	  activated with the mem_encrypt=on command line option.
-
 # Common NUMA Features
 config NUMA
 	bool "NUMA Memory Allocation and Scheduler Support"
diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index f4e22ef774ab..876fc6d46a13 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -15,10 +15,12 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/asm-offsets.h>
 #include <asm/msr.h>
 #include <asm/page_types.h>
 #include <asm/processor-flags.h>
 #include <asm/segment.h>
+#include <asm/setup.h>
 
 	.code64
 	.text
@@ -49,6 +51,11 @@ SYM_FUNC_START(startup_64_mixed_mode)
 	lea	efi32_boot_args(%rip), %rdx
 	mov	0(%rdx), %edi
 	mov	4(%rdx), %esi
+
+	/* Switch to the firmware's stack */
+	movl	efi32_boot_sp(%rip), %esp
+	andl	$~7, %esp
+
 #ifdef CONFIG_EFI_HANDOVER_PROTOCOL
 	mov	8(%rdx), %edx		// saved bootparams pointer
 	test	%edx, %edx
@@ -144,6 +151,7 @@ SYM_FUNC_END(__efi64_thunk)
 SYM_FUNC_START(efi32_stub_entry)
 	call	1f
 1:	popl	%ecx
+	leal	(efi32_boot_args - 1b)(%ecx), %ebx
 
 	/* Clear BSS */
 	xorl	%eax, %eax
@@ -158,6 +166,7 @@ SYM_FUNC_START(efi32_stub_entry)
 	popl	%ecx
 	popl	%edx
 	popl	%esi
+	movl	%esi, 8(%ebx)
 	jmp	efi32_entry
 SYM_FUNC_END(efi32_stub_entry)
 #endif
@@ -234,8 +243,6 @@ SYM_FUNC_END(efi_enter32)
  *
  * Arguments:	%ecx	image handle
  * 		%edx	EFI system table pointer
- *		%esi	struct bootparams pointer (or NULL when not using
- *			the EFI handover protocol)
  *
  * Since this is the point of no return for ordinary execution, no registers
  * are considered live except for the function parameters. [Note that the EFI
@@ -254,13 +261,25 @@ SYM_FUNC_START_LOCAL(efi32_entry)
 	/* Store firmware IDT descriptor */
 	sidtl	(efi32_boot_idt - 1b)(%ebx)
 
+	/* Store firmware stack pointer */
+	movl	%esp, (efi32_boot_sp - 1b)(%ebx)
+
 	/* Store boot arguments */
 	leal	(efi32_boot_args - 1b)(%ebx), %ebx
 	movl	%ecx, 0(%ebx)
 	movl	%edx, 4(%ebx)
-	movl	%esi, 8(%ebx)
 	movb	$0x0, 12(%ebx)          // efi_is64
 
+	/*
+	 * Allocate some memory for a temporary struct boot_params, which only
+	 * needs the minimal pieces that startup_32() relies on.
+	 */
+	subl	$PARAM_SIZE, %esp
+	movl	%esp, %esi
+	movl	$PAGE_SIZE, BP_kernel_alignment(%esi)
+	movl	$_end - 1b, BP_init_size(%esi)
+	subl	$startup_32 - 1b, BP_init_size(%esi)
+
 	/* Disable paging */
 	movl	%cr0, %eax
 	btrl	$X86_CR0_PG_BIT, %eax
@@ -286,8 +305,7 @@ SYM_FUNC_START(efi32_pe_entry)
 
 	movl	8(%ebp), %ecx			// image_handle
 	movl	12(%ebp), %edx			// sys_table
-	xorl	%esi, %esi
-	jmp	efi32_entry			// pass %ecx, %edx, %esi
+	jmp	efi32_entry			// pass %ecx, %edx
 						// no other registers remain live
 
 2:	popl	%edi				// restore callee-save registers
@@ -318,5 +336,6 @@ SYM_DATA_END(efi32_boot_idt)
 
 SYM_DATA_LOCAL(efi32_boot_cs, .word 0)
 SYM_DATA_LOCAL(efi32_boot_ds, .word 0)
+SYM_DATA_LOCAL(efi32_boot_sp, .long 0)
 SYM_DATA_LOCAL(efi32_boot_args, .long 0, 0, 0)
 SYM_DATA(efi_is64, .byte 1)
diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index eeec9986570e..d07be9d05cd0 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -14,7 +14,7 @@
 #include <asm/processor.h>
 
 enum cc_vendor cc_vendor __ro_after_init = CC_VENDOR_NONE;
-static u64 cc_mask __ro_after_init;
+u64 cc_mask __ro_after_init;
 
 static bool noinstr intel_cc_platform_has(enum cc_attr attr)
 {
@@ -148,8 +148,3 @@ u64 cc_mkdec(u64 val)
 	}
 }
 EXPORT_SYMBOL_GPL(cc_mkdec);
-
-__init void cc_set_mask(u64 mask)
-{
-	cc_mask = mask;
-}
diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index b1a98fa38828..0e82074517f6 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -13,6 +13,7 @@
 #include <asm/preempt.h>
 #include <asm/asm.h>
 #include <asm/gsseg.h>
+#include <asm/nospec-branch.h>
 
 #ifndef CONFIG_X86_CMPXCHG64
 extern void cmpxchg8b_emu(void);
diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index fbcfec4dc4cc..ca8eed1d496a 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -113,6 +113,20 @@
 
 #endif
 
+#ifndef __ASSEMBLY__
+#ifndef __pic__
+static __always_inline __pure void *rip_rel_ptr(void *p)
+{
+	asm("leaq %c1(%%rip), %0" : "=r"(p) : "i"(p));
+
+	return p;
+}
+#define RIP_REL_REF(var)	(*(typeof(&(var)))rip_rel_ptr(&(var)))
+#else
+#define RIP_REL_REF(var)	(var)
+#endif
+#endif
+
 /*
  * Macros to generate condition code outputs from inline assembly,
  * The output operand must be type "bool".
diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index 6ae2d16a7613..21940ef8d290 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_COCO_H
 #define _ASM_X86_COCO_H
 
+#include <asm/asm.h>
 #include <asm/types.h>
 
 enum cc_vendor {
@@ -11,9 +12,14 @@ enum cc_vendor {
 };
 
 extern enum cc_vendor cc_vendor;
+extern u64 cc_mask;
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
-void cc_set_mask(u64 mask);
+static inline void cc_set_mask(u64 mask)
+{
+	RIP_REL_REF(cc_mask) = mask;
+}
+
 u64 cc_mkenc(u64 val);
 u64 cc_mkdec(u64 val);
 #else
diff --git a/arch/x86/include/asm/crash_core.h b/arch/x86/include/asm/crash_core.h
index 76af98f4e801..041020da8d56 100644
--- a/arch/x86/include/asm/crash_core.h
+++ b/arch/x86/include/asm/crash_core.h
@@ -39,4 +39,6 @@ static inline unsigned long crash_low_size_default(void)
 #endif
 }
 
+#define HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
+
 #endif /* _X86_CRASH_CORE_H */
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 359ada486fa9..b31eb9fd5954 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -15,7 +15,8 @@
 #include <linux/init.h>
 #include <linux/cc_platform.h>
 
-#include <asm/bootparam.h>
+#include <asm/asm.h>
+struct boot_params;
 
 #ifdef CONFIG_X86_MEM_ENCRYPT
 void __init mem_encrypt_init(void);
@@ -58,6 +59,11 @@ void __init mem_encrypt_free_decrypted_mem(void);
 
 void __init sev_es_init_vc_handling(void);
 
+static inline u64 sme_get_me_mask(void)
+{
+	return RIP_REL_REF(sme_me_mask);
+}
+
 #define __bss_decrypted __section(".bss..decrypted")
 
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
@@ -89,6 +95,8 @@ early_set_mem_enc_dec_hypercall(unsigned long vaddr, unsigned long size, bool en
 
 static inline void mem_encrypt_free_decrypted_mem(void) { }
 
+static inline u64 sme_get_me_mask(void) { return 0; }
+
 #define __bss_decrypted
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
@@ -106,11 +114,6 @@ void add_encrypt_protection_map(void);
 
 extern char __start_bss_decrypted[], __end_bss_decrypted[], __start_bss_decrypted_unused[];
 
-static inline u64 sme_get_me_mask(void)
-{
-	return sme_me_mask;
-}
-
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* __X86_MEM_ENCRYPT_H__ */
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index d15b35815eba..4e33cc834bf8 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -271,11 +271,20 @@
 .Lskip_rsb_\@:
 .endm
 
+/*
+ * The CALL to srso_alias_untrain_ret() must be patched in directly at
+ * the spot where untraining must be done, ie., srso_alias_untrain_ret()
+ * must be the target of a CALL instruction instead of indirectly
+ * jumping to a wrapper which then calls it. Therefore, this macro is
+ * called outside of __UNTRAIN_RET below, for the time being, before the
+ * kernel can support nested alternatives with arbitrary nesting.
+ */
+.macro CALL_UNTRAIN_RET
 #if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_SRSO)
-#define CALL_UNTRAIN_RET	"call entry_untrain_ret"
-#else
-#define CALL_UNTRAIN_RET	""
+	ALTERNATIVE_2 "", "call entry_untrain_ret", X86_FEATURE_UNRET, \
+		          "call srso_alias_untrain_ret", X86_FEATURE_SRSO_ALIAS
 #endif
+.endm
 
 /*
  * Mitigate RETBleed for AMD/Hygon Zen uarch. Requires KERNEL CR3 because the
@@ -291,8 +300,8 @@
 .macro __UNTRAIN_RET ibpb_feature, call_depth_insns
 #if defined(CONFIG_RETHUNK) || defined(CONFIG_CPU_IBPB_ENTRY)
 	VALIDATE_UNRET_END
-	ALTERNATIVE_3 "",						\
-		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
+	CALL_UNTRAIN_RET
+	ALTERNATIVE_2 "",						\
 		      "call entry_ibpb", \ibpb_feature,			\
 		     __stringify(\call_depth_insns), X86_FEATURE_CALL_DEPTH
 #endif
@@ -351,6 +360,8 @@ extern void retbleed_return_thunk(void);
 static inline void retbleed_return_thunk(void) {}
 #endif
 
+extern void srso_alias_untrain_ret(void);
+
 #ifdef CONFIG_CPU_SRSO
 extern void srso_return_thunk(void);
 extern void srso_alias_return_thunk(void);
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 5b4a1ce3d368..36f905797075 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -203,12 +203,12 @@ void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 					 unsigned long npages);
 void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
 					unsigned long npages);
-void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op);
 void snp_set_memory_shared(unsigned long vaddr, unsigned long npages);
 void snp_set_memory_private(unsigned long vaddr, unsigned long npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void __init __noreturn snp_abort(void);
+void snp_dmi_setup(void);
 int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 snp_get_unsupported_features(u64 status);
@@ -227,12 +227,12 @@ static inline void __init
 early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr, unsigned long npages) { }
 static inline void __init
 early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, unsigned long npages) { }
-static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op) { }
 static inline void snp_set_memory_shared(unsigned long vaddr, unsigned long npages) { }
 static inline void snp_set_memory_private(unsigned long vaddr, unsigned long npages) { }
 static inline void snp_set_wakeup_secondary_cpu(void) { }
 static inline bool snp_init(struct boot_params *bp) { return false; }
 static inline void snp_abort(void) { }
+static inline void snp_dmi_setup(void) { }
 static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio)
 {
 	return -ENOTTY;
diff --git a/arch/x86/include/asm/suspend_32.h b/arch/x86/include/asm/suspend_32.h
index a800abb1a992..d8416b3bf832 100644
--- a/arch/x86/include/asm/suspend_32.h
+++ b/arch/x86/include/asm/suspend_32.h
@@ -12,11 +12,6 @@
 
 /* image of the saved processor state */
 struct saved_context {
-	/*
-	 * On x86_32, all segment registers except gs are saved at kernel
-	 * entry in pt_regs.
-	 */
-	u16 gs;
 	unsigned long cr0, cr2, cr3, cr4;
 	u64 misc_enable;
 	struct saved_msrs saved_msrs;
@@ -27,6 +22,11 @@ struct saved_context {
 	unsigned long tr;
 	unsigned long safety;
 	unsigned long return_address;
+	/*
+	 * On x86_32, all segment registers except gs are saved at kernel
+	 * entry in pt_regs.
+	 */
+	u16 gs;
 	bool misc_enable_saved;
 } __attribute__((packed));
 
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index c878616a18b8..550dcbbbb175 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -30,12 +30,13 @@ struct x86_init_mpparse {
  * @reserve_resources:		reserve the standard resources for the
  *				platform
  * @memory_setup:		platform specific memory setup
- *
+ * @dmi_setup:			platform specific DMI setup
  */
 struct x86_init_resources {
 	void (*probe_roms)(void);
 	void (*reserve_resources)(void);
 	char *(*memory_setup)(void);
+	void (*dmi_setup)(void);
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 2055fb308f5b..77a1ceb717d0 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1002,11 +1002,11 @@ static bool cpu_has_zenbleed_microcode(void)
 	u32 good_rev = 0;
 
 	switch (boot_cpu_data.x86_model) {
-	case 0x30 ... 0x3f: good_rev = 0x0830107a; break;
-	case 0x60 ... 0x67: good_rev = 0x0860010b; break;
-	case 0x68 ... 0x6f: good_rev = 0x08608105; break;
-	case 0x70 ... 0x7f: good_rev = 0x08701032; break;
-	case 0xa0 ... 0xaf: good_rev = 0x08a00008; break;
+	case 0x30 ... 0x3f: good_rev = 0x0830107b; break;
+	case 0x60 ... 0x67: good_rev = 0x0860010c; break;
+	case 0x68 ... 0x6f: good_rev = 0x08608107; break;
+	case 0x70 ... 0x7f: good_rev = 0x08701033; break;
+	case 0xa0 ... 0xaf: good_rev = 0x08a00009; break;
 
 	default:
 		return false;
diff --git a/arch/x86/kernel/eisa.c b/arch/x86/kernel/eisa.c
index e963344b0449..53935b4d62e3 100644
--- a/arch/x86/kernel/eisa.c
+++ b/arch/x86/kernel/eisa.c
@@ -2,6 +2,7 @@
 /*
  * EISA specific code
  */
+#include <linux/cc_platform.h>
 #include <linux/ioport.h>
 #include <linux/eisa.h>
 #include <linux/io.h>
@@ -12,7 +13,7 @@ static __init int eisa_bus_probe(void)
 {
 	void __iomem *p;
 
-	if (xen_pv_domain() && !xen_initial_domain())
+	if ((xen_pv_domain() && !xen_initial_domain()) || cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return 0;
 
 	p = ioremap(0x0FFFD9, 4);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 117e74c44e75..33a214b1a4ce 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -178,10 +178,11 @@ void fpu__init_cpu_xstate(void)
 	 * Must happen after CR4 setup and before xsetbv() to allow KVM
 	 * lazy passthrough.  Write independent of the dynamic state static
 	 * key as that does not work on the boot CPU. This also ensures
-	 * that any stale state is wiped out from XFD.
+	 * that any stale state is wiped out from XFD. Reset the per CPU
+	 * xfd cache too.
 	 */
 	if (cpu_feature_enabled(X86_FEATURE_XFD))
-		wrmsrl(MSR_IA32_XFD, init_fpstate.xfd);
+		xfd_set_state(init_fpstate.xfd);
 
 	/*
 	 * XCR_XFEATURE_ENABLED_MASK (aka. XCR0) sets user features
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 3518fb26d06b..19ca623ffa2a 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -148,20 +148,26 @@ static inline void xfd_validate_state(struct fpstate *fpstate, u64 mask, bool rs
 #endif
 
 #ifdef CONFIG_X86_64
+static inline void xfd_set_state(u64 xfd)
+{
+	wrmsrl(MSR_IA32_XFD, xfd);
+	__this_cpu_write(xfd_state, xfd);
+}
+
 static inline void xfd_update_state(struct fpstate *fpstate)
 {
 	if (fpu_state_size_dynamic()) {
 		u64 xfd = fpstate->xfd;
 
-		if (__this_cpu_read(xfd_state) != xfd) {
-			wrmsrl(MSR_IA32_XFD, xfd);
-			__this_cpu_write(xfd_state, xfd);
-		}
+		if (__this_cpu_read(xfd_state) != xfd)
+			xfd_set_state(xfd);
 	}
 }
 
 extern int __xfd_enable_feature(u64 which, struct fpu_guest *guest_fpu);
 #else
+static inline void xfd_set_state(u64 xfd) { }
+
 static inline void xfd_update_state(struct fpstate *fpstate) { }
 
 static inline int __xfd_enable_feature(u64 which, struct fpu_guest *guest_fpu) {
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index a0ce46c0a2d8..a6a3475e1d60 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -335,7 +335,16 @@ static int can_probe(unsigned long paddr)
 kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offset,
 					 bool *on_func_entry)
 {
-	if (is_endbr(*(u32 *)addr)) {
+	u32 insn;
+
+	/*
+	 * Since 'addr' is not guaranteed to be safe to access, use
+	 * copy_from_kernel_nofault() to read the instruction:
+	 */
+	if (copy_from_kernel_nofault(&insn, (void *)addr, sizeof(u32)))
+		return NULL;
+
+	if (is_endbr(insn)) {
 		*on_func_entry = !offset || offset == 4;
 		if (*on_func_entry)
 			offset = 4;
diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index b223922248e9..15c700d35870 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -196,12 +196,12 @@ static int __init smp_read_mpc(struct mpc_table *mpc, unsigned early)
 	if (!smp_check_mpc(mpc, oem, str))
 		return 0;
 
-	/* Initialize the lapic mapping */
-	if (!acpi_lapic)
-		register_lapic_address(mpc->lapic);
-
-	if (early)
+	if (early) {
+		/* Initialize the lapic mapping */
+		if (!acpi_lapic)
+			register_lapic_address(mpc->lapic);
 		return 1;
+	}
 
 	/* Now process the configuration blocks. */
 	while (count < mpc->length) {
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 3082cf24b69e..6da2cfa23c29 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -636,7 +636,7 @@ void nmi_backtrace_stall_check(const struct cpumask *btp)
 			msgp = nmi_check_stall_msg[idx];
 			if (nsp->idt_ignored_snap != READ_ONCE(nsp->idt_ignored) && (idx & 0x1))
 				modp = ", but OK because ignore_nmis was set";
-			if (nmi_seq & ~0x1)
+			if (nmi_seq & 0x1)
 				msghp = " (CPU currently in NMI handler function)";
 			else if (nsp->idt_nmi_seq_snap + 1 == nmi_seq)
 				msghp = " (CPU exited one NMI handler function)";
diff --git a/arch/x86/kernel/probe_roms.c b/arch/x86/kernel/probe_roms.c
index 319fef37d9dc..cc2c34ba7228 100644
--- a/arch/x86/kernel/probe_roms.c
+++ b/arch/x86/kernel/probe_roms.c
@@ -203,16 +203,6 @@ void __init probe_roms(void)
 	unsigned char c;
 	int i;
 
-	/*
-	 * The ROM memory range is not part of the e820 table and is therefore not
-	 * pre-validated by BIOS. The kernel page table maps the ROM region as encrypted
-	 * memory, and SNP requires encrypted memory to be validated before access.
-	 * Do that here.
-	 */
-	snp_prep_memory(video_rom_resource.start,
-			((system_rom_resource.end + 1) - video_rom_resource.start),
-			SNP_PAGE_STATE_PRIVATE);
-
 	/* video rom */
 	upper = adapter_rom_resources[0].start;
 	for (start = video_rom_resource.start; start < upper; start += 2048) {
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 1526747bedf2..b002ebf024d3 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -9,7 +9,6 @@
 #include <linux/console.h>
 #include <linux/crash_dump.h>
 #include <linux/dma-map-ops.h>
-#include <linux/dmi.h>
 #include <linux/efi.h>
 #include <linux/ima.h>
 #include <linux/init_ohci1394_dma.h>
@@ -904,7 +903,7 @@ void __init setup_arch(char **cmdline_p)
 		efi_init();
 
 	reserve_ibft_region();
-	dmi_setup();
+	x86_init.resources.dmi_setup();
 
 	/*
 	 * VMware detection requires dmi to be available, so this
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index ccb0915e84e1..466fe09898cc 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -556,9 +556,9 @@ static int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_le
 		leaf->eax = leaf->ebx = leaf->ecx = leaf->edx = 0;
 
 		/* Skip post-processing for out-of-range zero leafs. */
-		if (!(leaf->fn <= cpuid_std_range_max ||
-		      (leaf->fn >= 0x40000000 && leaf->fn <= cpuid_hyp_range_max) ||
-		      (leaf->fn >= 0x80000000 && leaf->fn <= cpuid_ext_range_max)))
+		if (!(leaf->fn <= RIP_REL_REF(cpuid_std_range_max) ||
+		      (leaf->fn >= 0x40000000 && leaf->fn <= RIP_REL_REF(cpuid_hyp_range_max)) ||
+		      (leaf->fn >= 0x80000000 && leaf->fn <= RIP_REL_REF(cpuid_ext_range_max))))
 			return 0;
 	}
 
@@ -1063,11 +1063,11 @@ static void __init setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
 		const struct snp_cpuid_fn *fn = &cpuid_table->fn[i];
 
 		if (fn->eax_in == 0x0)
-			cpuid_std_range_max = fn->eax;
+			RIP_REL_REF(cpuid_std_range_max) = fn->eax;
 		else if (fn->eax_in == 0x40000000)
-			cpuid_hyp_range_max = fn->eax;
+			RIP_REL_REF(cpuid_hyp_range_max) = fn->eax;
 		else if (fn->eax_in == 0x80000000)
-			cpuid_ext_range_max = fn->eax;
+			RIP_REL_REF(cpuid_ext_range_max) = fn->eax;
 	}
 }
 
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index c67285824e82..0f58242b54b8 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/psp-sev.h>
+#include <linux/dmi.h>
 #include <uapi/linux/sev-guest.h>
 
 #include <asm/cpu_entry_area.h>
@@ -748,7 +749,7 @@ void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 	 * This eliminates worries about jump tables or checking boot_cpu_data
 	 * in the cc_platform_has() function.
 	 */
-	if (!(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
+	if (!(RIP_REL_REF(sev_status) & MSR_AMD64_SEV_SNP_ENABLED))
 		return;
 
 	 /*
@@ -767,28 +768,13 @@ void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
 	 * This eliminates worries about jump tables or checking boot_cpu_data
 	 * in the cc_platform_has() function.
 	 */
-	if (!(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
+	if (!(RIP_REL_REF(sev_status) & MSR_AMD64_SEV_SNP_ENABLED))
 		return;
 
 	 /* Ask hypervisor to mark the memory pages shared in the RMP table. */
 	early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_SHARED);
 }
 
-void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op)
-{
-	unsigned long vaddr, npages;
-
-	vaddr = (unsigned long)__va(paddr);
-	npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
-
-	if (op == SNP_PAGE_STATE_PRIVATE)
-		early_snp_set_memory_private(vaddr, paddr, npages);
-	else if (op == SNP_PAGE_STATE_SHARED)
-		early_snp_set_memory_shared(vaddr, paddr, npages);
-	else
-		WARN(1, "invalid memory op %d\n", op);
-}
-
 static unsigned long __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
 				       unsigned long vaddr_end, int op)
 {
@@ -2112,6 +2098,17 @@ void __init __noreturn snp_abort(void)
 	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 }
 
+/*
+ * SEV-SNP guests should only execute dmi_setup() if EFI_CONFIG_TABLES are
+ * enabled, as the alternative (fallback) logic for DMI probing in the legacy
+ * ROM region can cause a crash since this region is not pre-validated.
+ */
+void __init snp_dmi_setup(void)
+{
+	if (efi_enabled(EFI_CONFIG_TABLES))
+		dmi_setup();
+}
+
 static void dump_cpuid_table(void)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index a37ebd3b4773..3f0718b4a7d2 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -3,6 +3,7 @@
  *
  *  For licencing details see kernel-base/COPYING
  */
+#include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/export.h>
@@ -66,6 +67,7 @@ struct x86_init_ops x86_init __initdata = {
 		.probe_roms		= probe_roms,
 		.reserve_resources	= reserve_standard_io_resources,
 		.memory_setup		= e820__memory_setup_default,
+		.dmi_setup		= dmi_setup,
 	},
 
 	.mpparse = {
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index dda6fc4cfae8..1811a9ddfe1d 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -679,6 +679,11 @@ void kvm_set_cpu_caps(void)
 		F(AMX_COMPLEX)
 	);
 
+	kvm_cpu_cap_init_kvm_defined(CPUID_7_2_EDX,
+		F(INTEL_PSFD) | F(IPRED_CTRL) | F(RRSBA_CTRL) | F(DDPD_U) |
+		F(BHI_CTRL) | F(MCDT_NO)
+	);
+
 	kvm_cpu_cap_mask(CPUID_D_1_EAX,
 		F(XSAVEOPT) | F(XSAVEC) | F(XGETBV1) | F(XSAVES) | f_xfd
 	);
@@ -960,13 +965,13 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		break;
 	/* function 7 has additional index. */
 	case 7:
-		entry->eax = min(entry->eax, 1u);
+		max_idx = entry->eax = min(entry->eax, 2u);
 		cpuid_entry_override(entry, CPUID_7_0_EBX);
 		cpuid_entry_override(entry, CPUID_7_ECX);
 		cpuid_entry_override(entry, CPUID_7_EDX);
 
-		/* KVM only supports 0x7.0 and 0x7.1, capped above via min(). */
-		if (entry->eax == 1) {
+		/* KVM only supports up to 0x7.2, capped above via min(). */
+		if (max_idx >= 1) {
 			entry = do_host_cpuid(array, function, 1);
 			if (!entry)
 				goto out;
@@ -976,6 +981,16 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 			entry->ebx = 0;
 			entry->ecx = 0;
 		}
+		if (max_idx >= 2) {
+			entry = do_host_cpuid(array, function, 2);
+			if (!entry)
+				goto out;
+
+			cpuid_entry_override(entry, CPUID_7_2_EDX);
+			entry->ecx = 0;
+			entry->ebx = 0;
+			entry->eax = 0;
+		}
 		break;
 	case 0xa: { /* Architectural Performance Monitoring */
 		union cpuid10_eax eax;
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 238afd7335e4..4943f6b2bbee 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2388,7 +2388,7 @@ static u16 kvm_hvcall_signal_event(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *h
 	if (!eventfd)
 		return HV_STATUS_INVALID_PORT_ID;
 
-	eventfd_signal(eventfd, 1);
+	eventfd_signal(eventfd);
 	return HV_STATUS_SUCCESS;
 }
 
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 245b20973cae..23fab75993a5 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -41,6 +41,7 @@
 #include "ioapic.h"
 #include "trace.h"
 #include "x86.h"
+#include "xen.h"
 #include "cpuid.h"
 #include "hyperv.h"
 #include "smm.h"
@@ -499,8 +500,10 @@ static inline void apic_set_spiv(struct kvm_lapic *apic, u32 val)
 	}
 
 	/* Check if there are APF page ready requests pending */
-	if (enabled)
+	if (enabled) {
 		kvm_make_request(KVM_REQ_APF_READY, apic->vcpu);
+		kvm_xen_sw_enable_lapic(apic->vcpu);
+	}
 }
 
 static inline void kvm_apic_set_xapic_id(struct kvm_lapic *apic, u8 id)
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index b81650678375..aadefcaa9561 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -16,6 +16,7 @@ enum kvm_only_cpuid_leafs {
 	CPUID_7_1_EDX,
 	CPUID_8000_0007_EDX,
 	CPUID_8000_0022_EAX,
+	CPUID_7_2_EDX,
 	NR_KVM_CPU_CAPS,
 
 	NKVMCAPINTS = NR_KVM_CPU_CAPS - NCAPINTS,
@@ -46,6 +47,14 @@ enum kvm_only_cpuid_leafs {
 #define X86_FEATURE_AMX_COMPLEX         KVM_X86_FEATURE(CPUID_7_1_EDX, 8)
 #define X86_FEATURE_PREFETCHITI         KVM_X86_FEATURE(CPUID_7_1_EDX, 14)
 
+/* Intel-defined sub-features, CPUID level 0x00000007:2 (EDX) */
+#define X86_FEATURE_INTEL_PSFD		KVM_X86_FEATURE(CPUID_7_2_EDX, 0)
+#define X86_FEATURE_IPRED_CTRL		KVM_X86_FEATURE(CPUID_7_2_EDX, 1)
+#define KVM_X86_FEATURE_RRSBA_CTRL	KVM_X86_FEATURE(CPUID_7_2_EDX, 2)
+#define X86_FEATURE_DDPD_U		KVM_X86_FEATURE(CPUID_7_2_EDX, 3)
+#define X86_FEATURE_BHI_CTRL		KVM_X86_FEATURE(CPUID_7_2_EDX, 4)
+#define X86_FEATURE_MCDT_NO		KVM_X86_FEATURE(CPUID_7_2_EDX, 5)
+
 /* CPUID level 0x80000007 (EDX). */
 #define KVM_X86_FEATURE_CONSTANT_TSC	KVM_X86_FEATURE(CPUID_8000_0007_EDX, 8)
 
@@ -80,6 +89,7 @@ static const struct cpuid_reg reverse_cpuid[] = {
 	[CPUID_8000_0007_EDX] = {0x80000007, 0, CPUID_EDX},
 	[CPUID_8000_0021_EAX] = {0x80000021, 0, CPUID_EAX},
 	[CPUID_8000_0022_EAX] = {0x80000022, 0, CPUID_EAX},
+	[CPUID_7_2_EDX]       = {         7, 2, CPUID_EDX},
 };
 
 /*
@@ -106,18 +116,19 @@ static __always_inline void reverse_cpuid_check(unsigned int x86_leaf)
  */
 static __always_inline u32 __feature_translate(int x86_feature)
 {
-	if (x86_feature == X86_FEATURE_SGX1)
-		return KVM_X86_FEATURE_SGX1;
-	else if (x86_feature == X86_FEATURE_SGX2)
-		return KVM_X86_FEATURE_SGX2;
-	else if (x86_feature == X86_FEATURE_SGX_EDECCSSA)
-		return KVM_X86_FEATURE_SGX_EDECCSSA;
-	else if (x86_feature == X86_FEATURE_CONSTANT_TSC)
-		return KVM_X86_FEATURE_CONSTANT_TSC;
-	else if (x86_feature == X86_FEATURE_PERFMON_V2)
-		return KVM_X86_FEATURE_PERFMON_V2;
-
-	return x86_feature;
+#define KVM_X86_TRANSLATE_FEATURE(f)	\
+	case X86_FEATURE_##f: return KVM_X86_FEATURE_##f
+
+	switch (x86_feature) {
+	KVM_X86_TRANSLATE_FEATURE(SGX1);
+	KVM_X86_TRANSLATE_FEATURE(SGX2);
+	KVM_X86_TRANSLATE_FEATURE(SGX_EDECCSSA);
+	KVM_X86_TRANSLATE_FEATURE(CONSTANT_TSC);
+	KVM_X86_TRANSLATE_FEATURE(PERFMON_V2);
+	KVM_X86_TRANSLATE_FEATURE(RRSBA_CTRL);
+	default:
+		return x86_feature;
+	}
 }
 
 static __always_inline u32 __feature_leaf(int x86_feature)
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 6ee925d66648..1226bb215193 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -57,7 +57,7 @@ static bool sev_es_enabled = true;
 module_param_named(sev_es, sev_es_enabled, bool, 0444);
 
 /* enable/disable SEV-ES DebugSwap support */
-static bool sev_es_debug_swap_enabled = true;
+static bool sev_es_debug_swap_enabled = false;
 module_param_named(debug_swap, sev_es_debug_swap_enabled, bool, 0444);
 #else
 #define sev_enabled false
@@ -612,8 +612,11 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
 	save->xss  = svm->vcpu.arch.ia32_xss;
 	save->dr6  = svm->vcpu.arch.dr6;
 
-	if (sev_es_debug_swap_enabled)
+	if (sev_es_debug_swap_enabled) {
 		save->sev_features |= SVM_SEV_FEAT_DEBUG_SWAP;
+		pr_warn_once("Enabling DebugSwap with KVM_SEV_ES_INIT. "
+			     "This will not work starting with Linux 6.10\n");
+	}
 
 	pr_debug("Virtual Machine Save Area (VMSA):\n");
 	print_hex_dump_debug("", DUMP_PREFIX_NONE, 16, 1, save, sizeof(*save), false);
@@ -1975,20 +1978,22 @@ int sev_mem_enc_register_region(struct kvm *kvm,
 		goto e_free;
 	}
 
-	region->uaddr = range->addr;
-	region->size = range->size;
-
-	list_add_tail(&region->list, &sev->regions_list);
-	mutex_unlock(&kvm->lock);
-
 	/*
 	 * The guest may change the memory encryption attribute from C=0 -> C=1
 	 * or vice versa for this memory range. Lets make sure caches are
 	 * flushed to ensure that guest data gets written into memory with
-	 * correct C-bit.
+	 * correct C-bit.  Note, this must be done before dropping kvm->lock,
+	 * as region and its array of pages can be freed by a different task
+	 * once kvm->lock is released.
 	 */
 	sev_clflush_pages(region->pages, region->npages);
 
+	region->uaddr = range->addr;
+	region->size = range->size;
+
+	list_add_tail(&region->list, &sev->regions_list);
+	mutex_unlock(&kvm->lock);
+
 	return ret;
 
 e_free:
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8021c62b0e7b..365caf732805 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7951,6 +7951,16 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
 
 	if (r < 0)
 		return X86EMUL_UNHANDLEABLE;
+
+	/*
+	 * Mark the page dirty _before_ checking whether or not the CMPXCHG was
+	 * successful, as the old value is written back on failure.  Note, for
+	 * live migration, this is unnecessarily conservative as CMPXCHG writes
+	 * back the original value and the access is atomic, but KVM's ABI is
+	 * that all writes are dirty logged, regardless of the value written.
+	 */
+	kvm_vcpu_mark_page_dirty(vcpu, gpa_to_gfn(gpa));
+
 	if (r)
 		return X86EMUL_CMPXCHG_FAILED;
 
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index e53fad915a62..c069521f249e 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -493,7 +493,7 @@ void kvm_xen_update_runstate(struct kvm_vcpu *v, int state)
 		kvm_xen_update_runstate_guest(v, state == RUNSTATE_runnable);
 }
 
-static void kvm_xen_inject_vcpu_vector(struct kvm_vcpu *v)
+void kvm_xen_inject_vcpu_vector(struct kvm_vcpu *v)
 {
 	struct kvm_lapic_irq irq = { };
 	int r;
@@ -2088,7 +2088,7 @@ static bool kvm_xen_hcall_evtchn_send(struct kvm_vcpu *vcpu, u64 param, u64 *r)
 		if (ret < 0 && ret != -ENOTCONN)
 			return false;
 	} else {
-		eventfd_signal(evtchnfd->deliver.eventfd.ctx, 1);
+		eventfd_signal(evtchnfd->deliver.eventfd.ctx);
 	}
 
 	*r = 0;
diff --git a/arch/x86/kvm/xen.h b/arch/x86/kvm/xen.h
index f8f1fe22d090..f5841d9000ae 100644
--- a/arch/x86/kvm/xen.h
+++ b/arch/x86/kvm/xen.h
@@ -18,6 +18,7 @@ extern struct static_key_false_deferred kvm_xen_enabled;
 
 int __kvm_xen_has_interrupt(struct kvm_vcpu *vcpu);
 void kvm_xen_inject_pending_events(struct kvm_vcpu *vcpu);
+void kvm_xen_inject_vcpu_vector(struct kvm_vcpu *vcpu);
 int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data);
 int kvm_xen_vcpu_get_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data);
 int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data);
@@ -36,6 +37,19 @@ int kvm_xen_setup_evtchn(struct kvm *kvm,
 			 const struct kvm_irq_routing_entry *ue);
 void kvm_xen_update_tsc_info(struct kvm_vcpu *vcpu);
 
+static inline void kvm_xen_sw_enable_lapic(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * The local APIC is being enabled. If the per-vCPU upcall vector is
+	 * set and the vCPU's evtchn_upcall_pending flag is set, inject the
+	 * interrupt.
+	 */
+	if (static_branch_unlikely(&kvm_xen_enabled.key) &&
+	    vcpu->arch.xen.vcpu_info_cache.active &&
+	    vcpu->arch.xen.upcall_vector && __kvm_xen_has_interrupt(vcpu))
+		kvm_xen_inject_vcpu_vector(vcpu);
+}
+
 static inline bool kvm_xen_msr_enabled(struct kvm *kvm)
 {
 	return static_branch_unlikely(&kvm_xen_enabled.key) &&
@@ -101,6 +115,10 @@ static inline void kvm_xen_destroy_vcpu(struct kvm_vcpu *vcpu)
 {
 }
 
+static inline void kvm_xen_sw_enable_lapic(struct kvm_vcpu *vcpu)
+{
+}
+
 static inline bool kvm_xen_msr_enabled(struct kvm *kvm)
 {
 	return false;
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 7b2589877d06..1e59367b4681 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -163,6 +163,7 @@ SYM_CODE_START_NOALIGN(srso_alias_untrain_ret)
 	lfence
 	jmp srso_alias_return_thunk
 SYM_FUNC_END(srso_alias_untrain_ret)
+__EXPORT_THUNK(srso_alias_untrain_ret)
 	.popsection
 
 	.pushsection .text..__x86.rethunk_safe
@@ -224,10 +225,12 @@ SYM_CODE_START(srso_return_thunk)
 SYM_CODE_END(srso_return_thunk)
 
 #define JMP_SRSO_UNTRAIN_RET "jmp srso_untrain_ret"
-#define JMP_SRSO_ALIAS_UNTRAIN_RET "jmp srso_alias_untrain_ret"
 #else /* !CONFIG_CPU_SRSO */
 #define JMP_SRSO_UNTRAIN_RET "ud2"
-#define JMP_SRSO_ALIAS_UNTRAIN_RET "ud2"
+/* Dummy for the alternative in CALL_UNTRAIN_RET. */
+SYM_CODE_START(srso_alias_untrain_ret)
+	RET
+SYM_FUNC_END(srso_alias_untrain_ret)
 #endif /* CONFIG_CPU_SRSO */
 
 #ifdef CONFIG_CPU_UNRET_ENTRY
@@ -319,9 +322,7 @@ SYM_FUNC_END(retbleed_untrain_ret)
 #if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_SRSO)
 
 SYM_FUNC_START(entry_untrain_ret)
-	ALTERNATIVE_2 JMP_RETBLEED_UNTRAIN_RET,				\
-		      JMP_SRSO_UNTRAIN_RET, X86_FEATURE_SRSO,		\
-		      JMP_SRSO_ALIAS_UNTRAIN_RET, X86_FEATURE_SRSO_ALIAS
+	ALTERNATIVE JMP_RETBLEED_UNTRAIN_RET, JMP_SRSO_UNTRAIN_RET, X86_FEATURE_SRSO
 SYM_FUNC_END(entry_untrain_ret)
 __EXPORT_THUNK(entry_untrain_ret)
 
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 70b91de2e053..94cd06d4b0af 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -492,6 +492,24 @@ void __init sme_early_init(void)
 	 */
 	if (sev_status & MSR_AMD64_SEV_ENABLED)
 		ia32_disable();
+
+	/*
+	 * Override init functions that scan the ROM region in SEV-SNP guests,
+	 * as this memory is not pre-validated and would thus cause a crash.
+	 */
+	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED) {
+		x86_init.mpparse.find_smp_config = x86_init_noop;
+		x86_init.pci.init_irq = x86_init_noop;
+		x86_init.resources.probe_roms = x86_init_noop;
+
+		/*
+		 * DMI setup behavior for SEV-SNP guests depends on
+		 * efi_enabled(EFI_CONFIG_TABLES), which hasn't been
+		 * parsed yet. snp_dmi_setup() will run after that
+		 * parsing has happened.
+		 */
+		x86_init.resources.dmi_setup = snp_dmi_setup;
+	}
 }
 
 void __init mem_encrypt_free_decrypted_mem(void)
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 7f72472a34d6..0166ab1780cc 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -97,7 +97,6 @@ static char sme_workarea[2 * PMD_SIZE] __section(".init.scratch");
 
 static char sme_cmdline_arg[] __initdata = "mem_encrypt";
 static char sme_cmdline_on[]  __initdata = "on";
-static char sme_cmdline_off[] __initdata = "off";
 
 static void __init sme_clear_pgd(struct sme_populate_pgd_data *ppd)
 {
@@ -305,7 +304,8 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	 * instrumentation or checking boot_cpu_data in the cc_platform_has()
 	 * function.
 	 */
-	if (!sme_get_me_mask() || sev_status & MSR_AMD64_SEV_ENABLED)
+	if (!sme_get_me_mask() ||
+	    RIP_REL_REF(sev_status) & MSR_AMD64_SEV_ENABLED)
 		return;
 
 	/*
@@ -504,7 +504,7 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 
 void __init sme_enable(struct boot_params *bp)
 {
-	const char *cmdline_ptr, *cmdline_arg, *cmdline_on, *cmdline_off;
+	const char *cmdline_ptr, *cmdline_arg, *cmdline_on;
 	unsigned int eax, ebx, ecx, edx;
 	unsigned long feature_mask;
 	unsigned long me_mask;
@@ -542,11 +542,11 @@ void __init sme_enable(struct boot_params *bp)
 	me_mask = 1UL << (ebx & 0x3f);
 
 	/* Check the SEV MSR whether SEV or SME is enabled */
-	sev_status   = __rdmsr(MSR_AMD64_SEV);
-	feature_mask = (sev_status & MSR_AMD64_SEV_ENABLED) ? AMD_SEV_BIT : AMD_SME_BIT;
+	RIP_REL_REF(sev_status) = msr = __rdmsr(MSR_AMD64_SEV);
+	feature_mask = (msr & MSR_AMD64_SEV_ENABLED) ? AMD_SEV_BIT : AMD_SME_BIT;
 
 	/* The SEV-SNP CC blob should never be present unless SEV-SNP is enabled. */
-	if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
+	if (snp && !(msr & MSR_AMD64_SEV_SNP_ENABLED))
 		snp_abort();
 
 	/* Check if memory encryption is enabled */
@@ -572,7 +572,6 @@ void __init sme_enable(struct boot_params *bp)
 			return;
 	} else {
 		/* SEV state cannot be controlled by a command line option */
-		sme_me_mask = me_mask;
 		goto out;
 	}
 
@@ -587,28 +586,17 @@ void __init sme_enable(struct boot_params *bp)
 	asm ("lea sme_cmdline_on(%%rip), %0"
 	     : "=r" (cmdline_on)
 	     : "p" (sme_cmdline_on));
-	asm ("lea sme_cmdline_off(%%rip), %0"
-	     : "=r" (cmdline_off)
-	     : "p" (sme_cmdline_off));
-
-	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT))
-		sme_me_mask = me_mask;
 
 	cmdline_ptr = (const char *)((u64)bp->hdr.cmd_line_ptr |
 				     ((u64)bp->ext_cmd_line_ptr << 32));
 
-	if (cmdline_find_option(cmdline_ptr, cmdline_arg, buffer, sizeof(buffer)) < 0)
-		goto out;
-
-	if (!strncmp(buffer, cmdline_on, sizeof(buffer)))
-		sme_me_mask = me_mask;
-	else if (!strncmp(buffer, cmdline_off, sizeof(buffer)))
-		sme_me_mask = 0;
+	if (cmdline_find_option(cmdline_ptr, cmdline_arg, buffer, sizeof(buffer)) < 0 ||
+	    strncmp(buffer, cmdline_on, sizeof(buffer)))
+		return;
 
 out:
-	if (sme_me_mask) {
-		physical_mask &= ~sme_me_mask;
-		cc_vendor = CC_VENDOR_AMD;
-		cc_set_mask(sme_me_mask);
-	}
+	RIP_REL_REF(sme_me_mask) = me_mask;
+	physical_mask &= ~me_mask;
+	cc_vendor = CC_VENDOR_AMD;
+	cc_set_mask(me_mask);
 }
diff --git a/block/bio.c b/block/bio.c
index 270f6b99926e..62419aa09d73 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1149,7 +1149,7 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
 
 	bio_for_each_folio_all(fi, bio) {
 		struct page *page;
-		size_t done = 0;
+		size_t nr_pages;
 
 		if (mark_dirty) {
 			folio_lock(fi.folio);
@@ -1157,10 +1157,11 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
 			folio_unlock(fi.folio);
 		}
 		page = folio_page(fi.folio, fi.offset / PAGE_SIZE);
+		nr_pages = (fi.offset + fi.length - 1) / PAGE_SIZE -
+			   fi.offset / PAGE_SIZE + 1;
 		do {
 			bio_release_page(bio, page++);
-			done += PAGE_SIZE;
-		} while (done < fi.length);
+		} while (--nr_pages != 0);
 	}
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a02d3d922c58..a71974a5e57c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -772,16 +772,11 @@ static void req_bio_endio(struct request *rq, struct bio *bio,
 		/*
 		 * Partial zone append completions cannot be supported as the
 		 * BIO fragments may end up not being written sequentially.
-		 * For such case, force the completed nbytes to be equal to
-		 * the BIO size so that bio_advance() sets the BIO remaining
-		 * size to 0 and we end up calling bio_endio() before returning.
 		 */
-		if (bio->bi_iter.bi_size != nbytes) {
+		if (bio->bi_iter.bi_size != nbytes)
 			bio->bi_status = BLK_STS_IOERR;
-			nbytes = bio->bi_iter.bi_size;
-		} else {
+		else
 			bio->bi_iter.bi_sector = rq->__sector;
-		}
 	}
 
 	bio_advance(bio, nbytes);
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 0046b447268f..7019b8e204d9 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -686,6 +686,10 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 	t->zone_write_granularity = max(t->zone_write_granularity,
 					b->zone_write_granularity);
 	t->zoned = max(t->zoned, b->zoned);
+	if (!t->zoned) {
+		t->zone_write_granularity = 0;
+		t->max_zone_append_sectors = 0;
+	}
 	return ret;
 }
 EXPORT_SYMBOL(blk_stack_limits);
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index f958e79277b8..02a916ba62ee 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -646,9 +646,8 @@ static void dd_depth_updated(struct blk_mq_hw_ctx *hctx)
 	struct request_queue *q = hctx->queue;
 	struct deadline_data *dd = q->elevator->elevator_data;
 	struct blk_mq_tags *tags = hctx->sched_tags;
-	unsigned int shift = tags->bitmap_tags.sb.shift;
 
-	dd->async_depth = max(1U, 3 * (1U << shift)  / 4);
+	dd->async_depth = max(1UL, 3 * q->nr_requests / 4);
 
 	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, dd->async_depth);
 }
diff --git a/crypto/asymmetric_keys/mscode_parser.c b/crypto/asymmetric_keys/mscode_parser.c
index 05402ef8964e..8aecbe4637f3 100644
--- a/crypto/asymmetric_keys/mscode_parser.c
+++ b/crypto/asymmetric_keys/mscode_parser.c
@@ -75,6 +75,9 @@ int mscode_note_digest_algo(void *context, size_t hdrlen,
 
 	oid = look_up_OID(value, vlen);
 	switch (oid) {
+	case OID_sha1:
+		ctx->digest_algo = "sha1";
+		break;
 	case OID_sha256:
 		ctx->digest_algo = "sha256";
 		break;
diff --git a/crypto/asymmetric_keys/pkcs7_parser.c b/crypto/asymmetric_keys/pkcs7_parser.c
index 5b08c50722d0..231ad7b3789d 100644
--- a/crypto/asymmetric_keys/pkcs7_parser.c
+++ b/crypto/asymmetric_keys/pkcs7_parser.c
@@ -227,6 +227,9 @@ int pkcs7_sig_note_digest_algo(void *context, size_t hdrlen,
 	struct pkcs7_parse_context *ctx = context;
 
 	switch (ctx->last_oid) {
+	case OID_sha1:
+		ctx->sinfo->sig->hash_algo = "sha1";
+		break;
 	case OID_sha256:
 		ctx->sinfo->sig->hash_algo = "sha256";
 		break;
@@ -278,6 +281,7 @@ int pkcs7_sig_note_pkey_algo(void *context, size_t hdrlen,
 		ctx->sinfo->sig->pkey_algo = "rsa";
 		ctx->sinfo->sig->encoding = "pkcs1";
 		break;
+	case OID_id_ecdsa_with_sha1:
 	case OID_id_ecdsa_with_sha224:
 	case OID_id_ecdsa_with_sha256:
 	case OID_id_ecdsa_with_sha384:
diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index e5f22691febd..e314fd57e6f8 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -115,7 +115,8 @@ software_key_determine_akcipher(const struct public_key *pkey,
 		 */
 		if (!hash_algo)
 			return -EINVAL;
-		if (strcmp(hash_algo, "sha224") != 0 &&
+		if (strcmp(hash_algo, "sha1") != 0 &&
+		    strcmp(hash_algo, "sha224") != 0 &&
 		    strcmp(hash_algo, "sha256") != 0 &&
 		    strcmp(hash_algo, "sha384") != 0 &&
 		    strcmp(hash_algo, "sha512") != 0 &&
diff --git a/crypto/asymmetric_keys/signature.c b/crypto/asymmetric_keys/signature.c
index 398983be77e8..2deff81f8af5 100644
--- a/crypto/asymmetric_keys/signature.c
+++ b/crypto/asymmetric_keys/signature.c
@@ -115,7 +115,7 @@ EXPORT_SYMBOL_GPL(decrypt_blob);
  * Sign the specified data blob using the private key specified by params->key.
  * The signature is wrapped in an encoding if params->encoding is specified
  * (eg. "pkcs1").  If the encoding needs to know the digest type, this can be
- * passed through params->hash_algo (eg. "sha512").
+ * passed through params->hash_algo (eg. "sha1").
  *
  * Returns the length of the data placed in the signature buffer or an error.
  */
diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index 487204d39426..bb0bffa271b5 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -198,6 +198,10 @@ int x509_note_sig_algo(void *context, size_t hdrlen, unsigned char tag,
 	default:
 		return -ENOPKG; /* Unsupported combination */
 
+	case OID_sha1WithRSAEncryption:
+		ctx->cert->sig->hash_algo = "sha1";
+		goto rsa_pkcs1;
+
 	case OID_sha256WithRSAEncryption:
 		ctx->cert->sig->hash_algo = "sha256";
 		goto rsa_pkcs1;
@@ -214,6 +218,10 @@ int x509_note_sig_algo(void *context, size_t hdrlen, unsigned char tag,
 		ctx->cert->sig->hash_algo = "sha224";
 		goto rsa_pkcs1;
 
+	case OID_id_ecdsa_with_sha1:
+		ctx->cert->sig->hash_algo = "sha1";
+		goto ecdsa;
+
 	case OID_id_rsassa_pkcs1_v1_5_with_sha3_256:
 		ctx->cert->sig->hash_algo = "sha3-256";
 		goto rsa_pkcs1;
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index d7e98397549b..0cd6e0600255 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -653,6 +653,30 @@ static const struct akcipher_testvec rsa_tv_template[] = {
 static const struct akcipher_testvec ecdsa_nist_p192_tv_template[] = {
 	{
 	.key =
+	"\x04\xf7\x46\xf8\x2f\x15\xf6\x22\x8e\xd7\x57\x4f\xcc\xe7\xbb\xc1"
+	"\xd4\x09\x73\xcf\xea\xd0\x15\x07\x3d\xa5\x8a\x8a\x95\x43\xe4\x68"
+	"\xea\xc6\x25\xc1\xc1\x01\x25\x4c\x7e\xc3\x3c\xa6\x04\x0a\xe7\x08"
+	"\x98",
+	.key_len = 49,
+	.params =
+	"\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
+	"\xce\x3d\x03\x01\x01",
+	.param_len = 21,
+	.m =
+	"\xcd\xb9\xd2\x1c\xb7\x6f\xcd\x44\xb3\xfd\x63\xea\xa3\x66\x7f\xae"
+	"\x63\x85\xe7\x82",
+	.m_size = 20,
+	.algo = OID_id_ecdsa_with_sha1,
+	.c =
+	"\x30\x35\x02\x19\x00\xba\xe5\x93\x83\x6e\xb6\x3b\x63\xa0\x27\x91"
+	"\xc6\xf6\x7f\xc3\x09\xad\x59\xad\x88\x27\xd6\x92\x6b\x02\x18\x10"
+	"\x68\x01\x9d\xba\xce\x83\x08\xef\x95\x52\x7b\xa0\x0f\xe4\x18\x86"
+	"\x80\x6f\xa5\x79\x77\xda\xd0",
+	.c_size = 55,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	}, {
+	.key =
 	"\x04\xb6\x4b\xb1\xd1\xac\xba\x24\x8f\x65\xb2\x60\x00\x90\xbf\xbd"
 	"\x78\x05\x73\xe9\x79\x1d\x6f\x7c\x0b\xd2\xc3\x93\xa7\x28\xe1\x75"
 	"\xf7\xd5\x95\x1d\x28\x10\xc0\x75\x50\x5c\x1a\x4f\x3f\x8f\xa5\xee"
@@ -756,6 +780,32 @@ static const struct akcipher_testvec ecdsa_nist_p192_tv_template[] = {
 static const struct akcipher_testvec ecdsa_nist_p256_tv_template[] = {
 	{
 	.key =
+	"\x04\xb9\x7b\xbb\xd7\x17\x64\xd2\x7e\xfc\x81\x5d\x87\x06\x83\x41"
+	"\x22\xd6\x9a\xaa\x87\x17\xec\x4f\x63\x55\x2f\x94\xba\xdd\x83\xe9"
+	"\x34\x4b\xf3\xe9\x91\x13\x50\xb6\xcb\xca\x62\x08\xe7\x3b\x09\xdc"
+	"\xc3\x63\x4b\x2d\xb9\x73\x53\xe4\x45\xe6\x7c\xad\xe7\x6b\xb0\xe8"
+	"\xaf",
+	.key_len = 65,
+	.params =
+	"\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
+	"\xce\x3d\x03\x01\x07",
+	.param_len = 21,
+	.m =
+	"\xc2\x2b\x5f\x91\x78\x34\x26\x09\x42\x8d\x6f\x51\xb2\xc5\xaf\x4c"
+	"\x0b\xde\x6a\x42",
+	.m_size = 20,
+	.algo = OID_id_ecdsa_with_sha1,
+	.c =
+	"\x30\x46\x02\x21\x00\xf9\x25\xce\x9f\x3a\xa6\x35\x81\xcf\xd4\xe7"
+	"\xb7\xf0\x82\x56\x41\xf7\xd4\xad\x8d\x94\x5a\x69\x89\xee\xca\x6a"
+	"\x52\x0e\x48\x4d\xcc\x02\x21\x00\xd7\xe4\xef\x52\x66\xd3\x5b\x9d"
+	"\x8a\xfa\x54\x93\x29\xa7\x70\x86\xf1\x03\x03\xf3\x3b\xe2\x73\xf7"
+	"\xfb\x9d\x8b\xde\xd4\x8d\x6f\xad",
+	.c_size = 72,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	}, {
+	.key =
 	"\x04\x8b\x6d\xc0\x33\x8e\x2d\x8b\x67\xf5\xeb\xc4\x7f\xa0\xf5\xd9"
 	"\x7b\x03\xa5\x78\x9a\xb5\xea\x14\xe4\x23\xd0\xaf\xd7\x0e\x2e\xa0"
 	"\xc9\x8b\xdb\x95\xf8\xb3\xaf\xac\x00\x2c\x2c\x1f\x7a\xfd\x95\x88"
@@ -866,6 +916,36 @@ static const struct akcipher_testvec ecdsa_nist_p256_tv_template[] = {
 
 static const struct akcipher_testvec ecdsa_nist_p384_tv_template[] = {
 	{
+	.key = /* secp384r1(sha1) */
+	"\x04\x89\x25\xf3\x97\x88\xcb\xb0\x78\xc5\x72\x9a\x14\x6e\x7a\xb1"
+	"\x5a\xa5\x24\xf1\x95\x06\x9e\x28\xfb\xc4\xb9\xbe\x5a\x0d\xd9\x9f"
+	"\xf3\xd1\x4d\x2d\x07\x99\xbd\xda\xa7\x66\xec\xbb\xea\xba\x79\x42"
+	"\xc9\x34\x89\x6a\xe7\x0b\xc3\xf2\xfe\x32\x30\xbe\xba\xf9\xdf\x7e"
+	"\x4b\x6a\x07\x8e\x26\x66\x3f\x1d\xec\xa2\x57\x91\x51\xdd\x17\x0e"
+	"\x0b\x25\xd6\x80\x5c\x3b\xe6\x1a\x98\x48\x91\x45\x7a\x73\xb0\xc3"
+	"\xf1",
+	.key_len = 97,
+	.params =
+	"\x30\x10\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x05\x2b\x81\x04"
+	"\x00\x22",
+	.param_len = 18,
+	.m =
+	"\x12\x55\x28\xf0\x77\xd5\xb6\x21\x71\x32\x48\xcd\x28\xa8\x25\x22"
+	"\x3a\x69\xc1\x93",
+	.m_size = 20,
+	.algo = OID_id_ecdsa_with_sha1,
+	.c =
+	"\x30\x66\x02\x31\x00\xf5\x0f\x24\x4c\x07\x93\x6f\x21\x57\x55\x07"
+	"\x20\x43\x30\xde\xa0\x8d\x26\x8e\xae\x63\x3f\xbc\x20\x3a\xc6\xf1"
+	"\x32\x3c\xce\x70\x2b\x78\xf1\x4c\x26\xe6\x5b\x86\xcf\xec\x7c\x7e"
+	"\xd0\x87\xd7\xd7\x6e\x02\x31\x00\xcd\xbb\x7e\x81\x5d\x8f\x63\xc0"
+	"\x5f\x63\xb1\xbe\x5e\x4c\x0e\xa1\xdf\x28\x8c\x1b\xfa\xf9\x95\x88"
+	"\x74\xa0\x0f\xbf\xaf\xc3\x36\x76\x4a\xa1\x59\xf1\x1c\xa4\x58\x26"
+	"\x79\x12\x2a\xb7\xc5\x15\x92\xc5",
+	.c_size = 104,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	}, {
 	.key = /* secp384r1(sha224) */
 	"\x04\x69\x6c\xcf\x62\xee\xd0\x0d\xe5\xb5\x2f\x70\x54\xcf\x26\xa0"
 	"\xd9\x98\x8d\x92\x2a\xab\x9b\x11\xcb\x48\x18\xa1\xa9\x0d\xd5\x18"
diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index 9290d4374551..83821e175753 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -2047,7 +2047,7 @@ static void hl_notifier_event_send(struct hl_notifier_event *notifier_event, u64
 	notifier_event->events_mask |= event_mask;
 
 	if (notifier_event->eventfd)
-		eventfd_signal(notifier_event->eventfd, 1);
+		eventfd_signal(notifier_event->eventfd);
 
 	mutex_unlock(&notifier_event->lock);
 }
diff --git a/drivers/accessibility/speakup/synth.c b/drivers/accessibility/speakup/synth.c
index eea2a2fa4f01..45f906103133 100644
--- a/drivers/accessibility/speakup/synth.c
+++ b/drivers/accessibility/speakup/synth.c
@@ -208,8 +208,10 @@ void spk_do_flush(void)
 	wake_up_process(speakup_task);
 }
 
-void synth_write(const char *buf, size_t count)
+void synth_write(const char *_buf, size_t count)
 {
+	const unsigned char *buf = (const unsigned char *) _buf;
+
 	while (count--)
 		synth_buffer_add(*buf++);
 	synth_start();
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index da2e74fce2d9..df3fd6474bf2 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -671,11 +671,6 @@ MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
 static void ahci_pci_save_initial_config(struct pci_dev *pdev,
 					 struct ahci_host_priv *hpriv)
 {
-	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA && pdev->device == 0x1166) {
-		dev_info(&pdev->dev, "ASM1166 has only six ports\n");
-		hpriv->saved_port_map = 0x3f;
-	}
-
 	if (pdev->vendor == PCI_VENDOR_ID_JMICRON && pdev->device == 0x2361) {
 		dev_info(&pdev->dev, "JMB361 has only one port\n");
 		hpriv->saved_port_map = 1;
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index b0d6e69c4a5b..214b935c2ced 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -712,8 +712,10 @@ void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap)
 				ehc->saved_ncq_enabled |= 1 << devno;
 
 			/* If we are resuming, wake up the device */
-			if (ap->pflags & ATA_PFLAG_RESUMING)
+			if (ap->pflags & ATA_PFLAG_RESUMING) {
+				dev->flags |= ATA_DFLAG_RESUMING;
 				ehc->i.dev_action[devno] |= ATA_EH_SET_ACTIVE;
+			}
 		}
 	}
 
@@ -3169,6 +3171,7 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 	return 0;
 
  err:
+	dev->flags &= ~ATA_DFLAG_RESUMING;
 	*r_failed_dev = dev;
 	return rc;
 }
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 0a0f483124c3..2f4c58837641 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4730,6 +4730,7 @@ void ata_scsi_dev_rescan(struct work_struct *work)
 	struct ata_link *link;
 	struct ata_device *dev;
 	unsigned long flags;
+	bool do_resume;
 	int ret = 0;
 
 	mutex_lock(&ap->scsi_scan_mutex);
@@ -4751,7 +4752,15 @@ void ata_scsi_dev_rescan(struct work_struct *work)
 			if (scsi_device_get(sdev))
 				continue;
 
+			do_resume = dev->flags & ATA_DFLAG_RESUMING;
+
 			spin_unlock_irqrestore(ap->lock, flags);
+			if (do_resume) {
+				ret = scsi_resume_device(sdev);
+				if (ret == -EWOULDBLOCK)
+					goto unlock;
+				dev->flags &= ~ATA_DFLAG_RESUMING;
+			}
 			ret = scsi_rescan_device(sdev);
 			scsi_device_put(sdev);
 			spin_lock_irqsave(ap->lock, flags);
diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
index 42171f766dcb..5a5a9e978e85 100644
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -313,8 +313,10 @@ void dev_pm_enable_wake_irq_complete(struct device *dev)
 		return;
 
 	if (wirq->status & WAKE_IRQ_DEDICATED_MANAGED &&
-	    wirq->status & WAKE_IRQ_DEDICATED_REVERSE)
+	    wirq->status & WAKE_IRQ_DEDICATED_REVERSE) {
 		enable_irq(wirq->irq);
+		wirq->status |= WAKE_IRQ_DEDICATED_ENABLED;
+	}
 }
 
 /**
diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 951fe3014a3f..abccd571cf3e 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1234,6 +1234,9 @@ static int btnxpuart_close(struct hci_dev *hdev)
 
 	ps_wakeup(nxpdev);
 	serdev_device_close(nxpdev->serdev);
+	skb_queue_purge(&nxpdev->txq);
+	kfree_skb(nxpdev->rx_skb);
+	nxpdev->rx_skb = NULL;
 	clear_bit(BTNXPUART_SERDEV_OPEN, &nxpdev->tx_state);
 	return 0;
 }
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 1b350412d8a6..64c875657687 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -919,8 +919,6 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
 	int rc;
 	u32 int_status;
 
-	INIT_WORK(&priv->free_irq_work, tpm_tis_free_irq_func);
-
 	rc = devm_request_threaded_irq(chip->dev.parent, irq, NULL,
 				       tis_int_handler, IRQF_ONESHOT | flags,
 				       dev_name(&chip->dev), chip);
@@ -1132,6 +1130,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	priv->phy_ops = phy_ops;
 	priv->locality_count = 0;
 	mutex_init(&priv->locality_count_mutex);
+	INIT_WORK(&priv->free_irq_work, tpm_tis_free_irq_func);
 
 	dev_set_drvdata(&chip->dev, priv);
 
diff --git a/drivers/clk/qcom/gcc-ipq5018.c b/drivers/clk/qcom/gcc-ipq5018.c
index e2bd54826a4c..c1732d70e3a2 100644
--- a/drivers/clk/qcom/gcc-ipq5018.c
+++ b/drivers/clk/qcom/gcc-ipq5018.c
@@ -857,6 +857,7 @@ static struct clk_rcg2 lpass_sway_clk_src = {
 
 static const struct freq_tbl ftbl_pcie0_aux_clk_src[] = {
 	F(2000000, P_XO, 12, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 pcie0_aux_clk_src = {
@@ -1099,6 +1100,7 @@ static const struct freq_tbl ftbl_qpic_io_macro_clk_src[] = {
 	F(100000000, P_GPLL0, 8, 0, 0),
 	F(200000000, P_GPLL0, 4, 0, 0),
 	F(320000000, P_GPLL0, 2.5, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 qpic_io_macro_clk_src = {
@@ -1194,6 +1196,7 @@ static struct clk_rcg2 ubi0_axi_clk_src = {
 static const struct freq_tbl ftbl_ubi0_core_clk_src[] = {
 	F(850000000, P_UBI32_PLL, 1, 0, 0),
 	F(1000000000, P_UBI32_PLL, 1, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 ubi0_core_clk_src = {
diff --git a/drivers/clk/qcom/gcc-ipq6018.c b/drivers/clk/qcom/gcc-ipq6018.c
index b366912cd648..ef1e2ce4804d 100644
--- a/drivers/clk/qcom/gcc-ipq6018.c
+++ b/drivers/clk/qcom/gcc-ipq6018.c
@@ -1554,6 +1554,7 @@ static struct clk_regmap_div nss_ubi0_div_clk_src = {
 
 static const struct freq_tbl ftbl_pcie_aux_clk_src[] = {
 	F(24000000, P_XO, 1, 0, 0),
+	{ }
 };
 
 static const struct clk_parent_data gcc_xo_gpll0_core_pi_sleep_clk[] = {
@@ -1734,6 +1735,7 @@ static const struct freq_tbl ftbl_sdcc_ice_core_clk_src[] = {
 	F(160000000, P_GPLL0, 5, 0, 0),
 	F(216000000, P_GPLL6, 5, 0, 0),
 	F(308570000, P_GPLL6, 3.5, 0, 0),
+	{ }
 };
 
 static const struct clk_parent_data gcc_xo_gpll0_gpll6_gpll0_div2[] = {
diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
index b7faf12a511a..7bc679871f32 100644
--- a/drivers/clk/qcom/gcc-ipq8074.c
+++ b/drivers/clk/qcom/gcc-ipq8074.c
@@ -644,6 +644,7 @@ static struct clk_rcg2 pcie0_axi_clk_src = {
 
 static const struct freq_tbl ftbl_pcie_aux_clk_src[] = {
 	F(19200000, P_XO, 1, 0, 0),
+	{ }
 };
 
 static const struct clk_parent_data gcc_xo_gpll0_sleep_clk[] = {
@@ -795,6 +796,7 @@ static const struct freq_tbl ftbl_sdcc_ice_core_clk_src[] = {
 	F(19200000, P_XO, 1, 0, 0),
 	F(160000000, P_GPLL0, 5, 0, 0),
 	F(308570000, P_GPLL6, 3.5, 0, 0),
+	{ }
 };
 
 static const struct clk_parent_data gcc_xo_gpll0_gpll6_gpll0_div2[] = {
diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
index e8190108e1ae..0a3f846695b8 100644
--- a/drivers/clk/qcom/gcc-ipq9574.c
+++ b/drivers/clk/qcom/gcc-ipq9574.c
@@ -2082,6 +2082,7 @@ static struct clk_branch gcc_sdcc1_apps_clk = {
 static const struct freq_tbl ftbl_sdcc_ice_core_clk_src[] = {
 	F(150000000, P_GPLL4, 8, 0, 0),
 	F(300000000, P_GPLL4, 4, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 sdcc1_ice_core_clk_src = {
diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index 725cd52d2398..ea4c3bf4fb9b 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -4037,3 +4037,4 @@ module_exit(gcc_sdm845_exit);
 MODULE_DESCRIPTION("QTI GCC SDM845 Driver");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:gcc-sdm845");
+MODULE_SOFTDEP("pre: rpmhpd");
diff --git a/drivers/clk/qcom/mmcc-apq8084.c b/drivers/clk/qcom/mmcc-apq8084.c
index 02fc21208dd1..c89700ab93f9 100644
--- a/drivers/clk/qcom/mmcc-apq8084.c
+++ b/drivers/clk/qcom/mmcc-apq8084.c
@@ -348,6 +348,7 @@ static struct freq_tbl ftbl_mmss_axi_clk[] = {
 	F(333430000, P_MMPLL1, 3.5, 0, 0),
 	F(400000000, P_MMPLL0, 2, 0, 0),
 	F(466800000, P_MMPLL1, 2.5, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 mmss_axi_clk_src = {
@@ -372,6 +373,7 @@ static struct freq_tbl ftbl_ocmemnoc_clk[] = {
 	F(150000000, P_GPLL0, 4, 0, 0),
 	F(228570000, P_MMPLL0, 3.5, 0, 0),
 	F(320000000, P_MMPLL0, 2.5, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 ocmemnoc_clk_src = {
diff --git a/drivers/clk/qcom/mmcc-msm8974.c b/drivers/clk/qcom/mmcc-msm8974.c
index a31f6cf0c4e0..36f460b78be2 100644
--- a/drivers/clk/qcom/mmcc-msm8974.c
+++ b/drivers/clk/qcom/mmcc-msm8974.c
@@ -290,6 +290,7 @@ static struct freq_tbl ftbl_mmss_axi_clk[] = {
 	F(291750000, P_MMPLL1, 4, 0, 0),
 	F(400000000, P_MMPLL0, 2, 0, 0),
 	F(466800000, P_MMPLL1, 2.5, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 mmss_axi_clk_src = {
@@ -314,6 +315,7 @@ static struct freq_tbl ftbl_ocmemnoc_clk[] = {
 	F(150000000, P_GPLL0, 4, 0, 0),
 	F(291750000, P_MMPLL1, 4, 0, 0),
 	F(400000000, P_MMPLL0, 2, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 ocmemnoc_clk_src = {
diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index 44a61dc6f932..e1c773bb5535 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -32,7 +32,7 @@
 #define GT_CONTROL_IRQ_ENABLE		BIT(2)	/* banked */
 #define GT_CONTROL_AUTO_INC		BIT(3)	/* banked */
 #define GT_CONTROL_PRESCALER_SHIFT      8
-#define GT_CONTROL_PRESCALER_MAX        0xF
+#define GT_CONTROL_PRESCALER_MAX        0xFF
 #define GT_CONTROL_PRESCALER_MASK       (GT_CONTROL_PRESCALER_MAX << \
 					 GT_CONTROL_PRESCALER_SHIFT)
 
diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 57857c0dfba9..1c732479a2c8 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -101,6 +101,9 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
 {
 	struct clock_event_device *ce = per_cpu_ptr(&riscv_clock_event, cpu);
 
+	/* Clear timer interrupt */
+	riscv_clock_event_stop();
+
 	ce->cpumask = cpumask_of(cpu);
 	ce->irq = riscv_clock_event_irq;
 	if (riscv_timer_cannot_wake_cpu)
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 1791d37fbc53..07f341995439 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -570,7 +570,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	if (target_perf < capacity)
 		des_perf = DIV_ROUND_UP(cap_perf * target_perf, capacity);
 
-	min_perf = READ_ONCE(cpudata->highest_perf);
+	min_perf = READ_ONCE(cpudata->lowest_perf);
 	if (_min_perf < capacity)
 		min_perf = DIV_ROUND_UP(cap_perf * _min_perf, capacity);
 
diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 8bd6e5e8f121..2d83bbc65dd0 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -208,7 +208,7 @@ static int dt_cpufreq_early_init(struct device *dev, int cpu)
 	if (!priv)
 		return -ENOMEM;
 
-	if (!alloc_cpumask_var(&priv->cpus, GFP_KERNEL))
+	if (!zalloc_cpumask_var(&priv->cpus, GFP_KERNEL))
 		return -ENOMEM;
 
 	cpumask_set_cpu(cpu, priv->cpus);
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
index 8d4c42863a62..d2cf9619018b 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
@@ -299,22 +299,6 @@ static int sun8i_ce_cipher_prepare(struct crypto_engine *engine, void *async_req
 	return err;
 }
 
-static void sun8i_ce_cipher_run(struct crypto_engine *engine, void *areq)
-{
-	struct skcipher_request *breq = container_of(areq, struct skcipher_request, base);
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(breq);
-	struct sun8i_cipher_tfm_ctx *op = crypto_skcipher_ctx(tfm);
-	struct sun8i_ce_dev *ce = op->ce;
-	struct sun8i_cipher_req_ctx *rctx = skcipher_request_ctx(breq);
-	int flow, err;
-
-	flow = rctx->flow;
-	err = sun8i_ce_run_task(ce, flow, crypto_tfm_alg_name(breq->base.tfm));
-	local_bh_disable();
-	crypto_finalize_skcipher_request(engine, breq, err);
-	local_bh_enable();
-}
-
 static void sun8i_ce_cipher_unprepare(struct crypto_engine *engine,
 				      void *async_req)
 {
@@ -360,6 +344,23 @@ static void sun8i_ce_cipher_unprepare(struct crypto_engine *engine,
 	dma_unmap_single(ce->dev, rctx->addr_key, op->keylen, DMA_TO_DEVICE);
 }
 
+static void sun8i_ce_cipher_run(struct crypto_engine *engine, void *areq)
+{
+	struct skcipher_request *breq = container_of(areq, struct skcipher_request, base);
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(breq);
+	struct sun8i_cipher_tfm_ctx *op = crypto_skcipher_ctx(tfm);
+	struct sun8i_ce_dev *ce = op->ce;
+	struct sun8i_cipher_req_ctx *rctx = skcipher_request_ctx(breq);
+	int flow, err;
+
+	flow = rctx->flow;
+	err = sun8i_ce_run_task(ce, flow, crypto_tfm_alg_name(breq->base.tfm));
+	sun8i_ce_cipher_unprepare(engine, areq);
+	local_bh_disable();
+	crypto_finalize_skcipher_request(engine, breq, err);
+	local_bh_enable();
+}
+
 int sun8i_ce_cipher_do_one(struct crypto_engine *engine, void *areq)
 {
 	int err = sun8i_ce_cipher_prepare(engine, areq);
@@ -368,7 +369,6 @@ int sun8i_ce_cipher_do_one(struct crypto_engine *engine, void *areq)
 		return err;
 
 	sun8i_ce_cipher_run(engine, areq);
-	sun8i_ce_cipher_unprepare(engine, areq);
 	return 0;
 }
 
diff --git a/drivers/crypto/intel/qat/qat_common/adf_aer.c b/drivers/crypto/intel/qat/qat_common/adf_aer.c
index a39e70bd4b21..621d14ea3b81 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_aer.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_aer.c
@@ -92,7 +92,8 @@ static void adf_device_reset_worker(struct work_struct *work)
 	if (adf_dev_restart(accel_dev)) {
 		/* The device hanged and we can't restart it so stop here */
 		dev_err(&GET_DEV(accel_dev), "Restart device failed\n");
-		if (reset_data->mode == ADF_DEV_RESET_ASYNC)
+		if (reset_data->mode == ADF_DEV_RESET_ASYNC ||
+		    completion_done(&reset_data->compl))
 			kfree(reset_data);
 		WARN(1, "QAT: device restart failed. Device is unusable\n");
 		return;
@@ -100,11 +101,19 @@ static void adf_device_reset_worker(struct work_struct *work)
 	adf_dev_restarted_notify(accel_dev);
 	clear_bit(ADF_STATUS_RESTARTING, &accel_dev->status);
 
-	/* The dev is back alive. Notify the caller if in sync mode */
-	if (reset_data->mode == ADF_DEV_RESET_SYNC)
-		complete(&reset_data->compl);
-	else
+	/*
+	 * The dev is back alive. Notify the caller if in sync mode
+	 *
+	 * If device restart will take a more time than expected,
+	 * the schedule_reset() function can timeout and exit. This can be
+	 * detected by calling the completion_done() function. In this case
+	 * the reset_data structure needs to be freed here.
+	 */
+	if (reset_data->mode == ADF_DEV_RESET_ASYNC ||
+	    completion_done(&reset_data->compl))
 		kfree(reset_data);
+	else
+		complete(&reset_data->compl);
 }
 
 static int adf_dev_aer_schedule_reset(struct adf_accel_dev *accel_dev,
@@ -137,8 +146,9 @@ static int adf_dev_aer_schedule_reset(struct adf_accel_dev *accel_dev,
 			dev_err(&GET_DEV(accel_dev),
 				"Reset device timeout expired\n");
 			ret = -EFAULT;
+		} else {
+			kfree(reset_data);
 		}
-		kfree(reset_data);
 		return ret;
 	}
 	return 0;
diff --git a/drivers/crypto/intel/qat/qat_common/adf_rl.c b/drivers/crypto/intel/qat/qat_common/adf_rl.c
index de1b214dba1f..d4f2db3c53d8 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_rl.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_rl.c
@@ -788,6 +788,24 @@ static void clear_sla(struct adf_rl *rl_data, struct rl_sla *sla)
 	sla_type_arr[node_id] = NULL;
 }
 
+static void free_all_sla(struct adf_accel_dev *accel_dev)
+{
+	struct adf_rl *rl_data = accel_dev->rate_limiting;
+	int sla_id;
+
+	mutex_lock(&rl_data->rl_lock);
+
+	for (sla_id = 0; sla_id < RL_NODES_CNT_MAX; sla_id++) {
+		if (!rl_data->sla[sla_id])
+			continue;
+
+		kfree(rl_data->sla[sla_id]);
+		rl_data->sla[sla_id] = NULL;
+	}
+
+	mutex_unlock(&rl_data->rl_lock);
+}
+
 /**
  * add_update_sla() - handles the creation and the update of an SLA
  * @accel_dev: pointer to acceleration device structure
@@ -1155,7 +1173,7 @@ void adf_rl_stop(struct adf_accel_dev *accel_dev)
 		return;
 
 	adf_sysfs_rl_rm(accel_dev);
-	adf_rl_remove_sla_all(accel_dev, true);
+	free_all_sla(accel_dev);
 }
 
 void adf_rl_exit(struct adf_accel_dev *accel_dev)
diff --git a/drivers/crypto/rockchip/rk3288_crypto_ahash.c b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
index 1b13b4aa16ec..a235e6c300f1 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_ahash.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
@@ -332,12 +332,12 @@ static int rk_hash_run(struct crypto_engine *engine, void *breq)
 theend:
 	pm_runtime_put_autosuspend(rkc->dev);
 
+	rk_hash_unprepare(engine, breq);
+
 	local_bh_disable();
 	crypto_finalize_hash_request(engine, breq, err);
 	local_bh_enable();
 
-	rk_hash_unprepare(engine, breq);
-
 	return 0;
 }
 
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index a0b5819bc70b..f01d0709c9c3 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -642,18 +642,18 @@ u64 cxl_trace_hpa(struct cxl_region *cxlr, struct cxl_memdev *memdev, u64 dpa);
 
 TRACE_EVENT(cxl_poison,
 
-	TP_PROTO(struct cxl_memdev *cxlmd, struct cxl_region *region,
+	TP_PROTO(struct cxl_memdev *cxlmd, struct cxl_region *cxlr,
 		 const struct cxl_poison_record *record, u8 flags,
 		 __le64 overflow_ts, enum cxl_poison_trace_type trace_type),
 
-	TP_ARGS(cxlmd, region, record, flags, overflow_ts, trace_type),
+	TP_ARGS(cxlmd, cxlr, record, flags, overflow_ts, trace_type),
 
 	TP_STRUCT__entry(
 		__string(memdev, dev_name(&cxlmd->dev))
 		__string(host, dev_name(cxlmd->dev.parent))
 		__field(u64, serial)
 		__field(u8, trace_type)
-		__string(region, region)
+		__string(region, cxlr ? dev_name(&cxlr->dev) : "")
 		__field(u64, overflow_ts)
 		__field(u64, hpa)
 		__field(u64, dpa)
@@ -673,10 +673,10 @@ TRACE_EVENT(cxl_poison,
 		__entry->source = cxl_poison_record_source(record);
 		__entry->trace_type = trace_type;
 		__entry->flags = flags;
-		if (region) {
-			__assign_str(region, dev_name(&region->dev));
-			memcpy(__entry->uuid, &region->params.uuid, 16);
-			__entry->hpa = cxl_trace_hpa(region, cxlmd,
+		if (cxlr) {
+			__assign_str(region, dev_name(&cxlr->dev));
+			memcpy(__entry->uuid, &cxlr->params.uuid, 16);
+			__entry->hpa = cxl_trace_hpa(cxlr, cxlmd,
 						     __entry->dpa);
 		} else {
 			__assign_str(region, "");
diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 9db9290c3269..7bc71f4be64a 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -3773,6 +3773,7 @@ static int pci_probe(struct pci_dev *dev,
 	return 0;
 
  fail_msi:
+	devm_free_irq(&dev->dev, dev->irq, ohci);
 	pci_disable_msi(dev);
 
 	return err;
@@ -3800,6 +3801,7 @@ static void pci_remove(struct pci_dev *dev)
 
 	software_reset(ohci);
 
+	devm_free_irq(&dev->dev, dev->irq, ohci);
 	pci_disable_msi(dev);
 
 	dev_notice(&dev->dev, "removing fw-ohci device\n");
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 9d3910d1abe1..abdfcb5aa470 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -199,6 +199,8 @@ static bool generic_ops_supported(void)
 
 	name_size = sizeof(name);
 
+	if (!efi.get_next_variable)
+		return false;
 	status = efi.get_next_variable(&name_size, &name, &guid);
 	if (status == EFI_UNSUPPORTED)
 		return false;
diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
index 4e96a855fdf4..c41e7b2091cd 100644
--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -120,7 +120,7 @@ efi_status_t efi_random_alloc(unsigned long size,
 			continue;
 		}
 
-		target = round_up(md->phys_addr, align) + target_slot * align;
+		target = round_up(max_t(u64, md->phys_addr, alloc_min), align) + target_slot * align;
 		pages = size / EFI_PAGE_SIZE;
 
 		status = efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index c9857ee3880c..dd80082aac1a 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -487,6 +487,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	hdr->vid_mode	= 0xffff;
 
 	hdr->type_of_loader = 0x21;
+	hdr->initrd_addr_max = INT_MAX;
 
 	/* Convert unicode cmdline to ascii */
 	cmdline_ptr = efi_convert_cmdline(image, &options_size);
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index dd7a783d53b5..e73f88050f08 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1872,7 +1872,7 @@ static irqreturn_t dfl_irq_handler(int irq, void *arg)
 {
 	struct eventfd_ctx *trigger = arg;
 
-	eventfd_signal(trigger, 1);
+	eventfd_signal(trigger);
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 31d4b5a2c5e8..13c62a26aa19 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -198,6 +198,7 @@ extern uint amdgpu_dc_debug_mask;
 extern uint amdgpu_dc_visual_confirm;
 extern uint amdgpu_dm_abm_level;
 extern int amdgpu_backlight;
+extern int amdgpu_damage_clips;
 extern struct amdgpu_mgpu_info mgpu_info;
 extern int amdgpu_ras_enable;
 extern uint amdgpu_ras_mask;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 10c4a8cfa18a..855ab596323c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -209,6 +209,7 @@ int amdgpu_umsch_mm;
 int amdgpu_seamless = -1; /* auto */
 uint amdgpu_debug_mask;
 int amdgpu_agp = -1; /* auto */
+int amdgpu_damage_clips = -1; /* auto */
 
 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
 
@@ -857,6 +858,18 @@ int amdgpu_backlight = -1;
 MODULE_PARM_DESC(backlight, "Backlight control (0 = pwm, 1 = aux, -1 auto (default))");
 module_param_named(backlight, amdgpu_backlight, bint, 0444);
 
+/**
+ * DOC: damageclips (int)
+ * Enable or disable damage clips support. If damage clips support is disabled,
+ * we will force full frame updates, irrespective of what user space sends to
+ * us.
+ *
+ * Defaults to -1 (where it is enabled unless a PSR-SU display is detected).
+ */
+MODULE_PARM_DESC(damageclips,
+		 "Damage clips support (0 = disable, 1 = enable, -1 auto (default))");
+module_param_named(damageclips, amdgpu_damage_clips, int, 0444);
+
 /**
  * DOC: tmz (int)
  * Trusted Memory Zone (TMZ) is a method to protect data being written
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index 081267161d40..57516a8c5db3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -129,13 +129,25 @@ static const struct mmu_interval_notifier_ops amdgpu_hmm_hsa_ops = {
  */
 int amdgpu_hmm_register(struct amdgpu_bo *bo, unsigned long addr)
 {
+	int r;
+
 	if (bo->kfd_bo)
-		return mmu_interval_notifier_insert(&bo->notifier, current->mm,
+		r = mmu_interval_notifier_insert(&bo->notifier, current->mm,
 						    addr, amdgpu_bo_size(bo),
 						    &amdgpu_hmm_hsa_ops);
-	return mmu_interval_notifier_insert(&bo->notifier, current->mm, addr,
-					    amdgpu_bo_size(bo),
-					    &amdgpu_hmm_gfx_ops);
+	else
+		r = mmu_interval_notifier_insert(&bo->notifier, current->mm, addr,
+							amdgpu_bo_size(bo),
+							&amdgpu_hmm_gfx_ops);
+	if (r)
+		/*
+		 * Make sure amdgpu_hmm_unregister() doesn't call
+		 * mmu_interval_notifier_remove() when the notifier isn't properly
+		 * initialized.
+		 */
+		bo->notifier.mm = NULL;
+
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 45424ebf9681..4e526d773033 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -524,46 +524,58 @@ static ssize_t amdgpu_debugfs_mqd_read(struct file *f, char __user *buf,
 {
 	struct amdgpu_ring *ring = file_inode(f)->i_private;
 	volatile u32 *mqd;
-	int r;
+	u32 *kbuf;
+	int r, i;
 	uint32_t value, result;
 
 	if (*pos & 3 || size & 3)
 		return -EINVAL;
 
-	result = 0;
+	kbuf = kmalloc(ring->mqd_size, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
 
 	r = amdgpu_bo_reserve(ring->mqd_obj, false);
 	if (unlikely(r != 0))
-		return r;
+		goto err_free;
 
 	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&mqd);
-	if (r) {
-		amdgpu_bo_unreserve(ring->mqd_obj);
-		return r;
-	}
+	if (r)
+		goto err_unreserve;
 
+	/*
+	 * Copy to local buffer to avoid put_user(), which might fault
+	 * and acquire mmap_sem, under reservation_ww_class_mutex.
+	 */
+	for (i = 0; i < ring->mqd_size/sizeof(u32); i++)
+		kbuf[i] = mqd[i];
+
+	amdgpu_bo_kunmap(ring->mqd_obj);
+	amdgpu_bo_unreserve(ring->mqd_obj);
+
+	result = 0;
 	while (size) {
 		if (*pos >= ring->mqd_size)
-			goto done;
+			break;
 
-		value = mqd[*pos/4];
+		value = kbuf[*pos/4];
 		r = put_user(value, (uint32_t *)buf);
 		if (r)
-			goto done;
+			goto err_free;
 		buf += 4;
 		result += 4;
 		size -= 4;
 		*pos += 4;
 	}
 
-done:
-	amdgpu_bo_kunmap(ring->mqd_obj);
-	mqd = NULL;
-	amdgpu_bo_unreserve(ring->mqd_obj);
-	if (r)
-		return r;
-
+	kfree(kbuf);
 	return result;
+
+err_unreserve:
+	amdgpu_bo_unreserve(ring->mqd_obj);
+err_free:
+	kfree(kbuf);
+	return r;
 }
 
 static const struct file_operations amdgpu_debugfs_mqd_fops = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 75c9fd2c6c2a..b0ed10f4de60 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -869,6 +869,7 @@ static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
 		amdgpu_gart_bind(adev, gtt->offset, ttm->num_pages,
 				 gtt->ttm.dma_address, flags);
 	}
+	gtt->bound = true;
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 71445ab63b5e..02d1d9afbf66 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1466,7 +1466,7 @@ void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type);
 
 static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
 {
-	return KFD_GC_VERSION(dev) > IP_VERSION(9, 4, 2) ||
+	return KFD_GC_VERSION(dev) >= IP_VERSION(9, 4, 2) ||
 	       (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) && dev->sdma_fw_version >= 18) ||
 	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 49f0c9454a6e..dafe9562a737 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5129,6 +5129,10 @@ static inline void fill_dc_dirty_rect(struct drm_plane *plane,
  * @new_plane_state: New state of @plane
  * @crtc_state: New state of CRTC connected to the @plane
  * @flip_addrs: DC flip tracking struct, which also tracts dirty rects
+ * @is_psr_su: Flag indicating whether Panel Self Refresh Selective Update (PSR SU) is enabled.
+ *             If PSR SU is enabled and damage clips are available, only the regions of the screen
+ *             that have changed will be updated. If PSR SU is not enabled,
+ *             or if damage clips are not available, the entire screen will be updated.
  * @dirty_regions_changed: dirty regions changed
  *
  * For PSR SU, DC informs the DMUB uController of dirty rectangle regions
@@ -5147,6 +5151,7 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
 				struct drm_plane_state *new_plane_state,
 				struct drm_crtc_state *crtc_state,
 				struct dc_flip_addrs *flip_addrs,
+				bool is_psr_su,
 				bool *dirty_regions_changed)
 {
 	struct dm_crtc_state *dm_crtc_state = to_dm_crtc_state(crtc_state);
@@ -5171,6 +5176,10 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
 	num_clips = drm_plane_get_damage_clips_count(new_plane_state);
 	clips = drm_plane_get_damage_clips(new_plane_state);
 
+	if (num_clips && (!amdgpu_damage_clips || (amdgpu_damage_clips < 0 &&
+						   is_psr_su)))
+		goto ffu;
+
 	if (!dm_crtc_state->mpo_requested) {
 		if (!num_clips || num_clips > DC_MAX_DIRTY_RECTS)
 			goto ffu;
@@ -6163,9 +6172,8 @@ create_stream_for_sink(struct drm_connector *connector,
 
 	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
 		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket);
-	else if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT ||
-			 stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST ||
-			 stream->signal == SIGNAL_TYPE_EDP) {
+
+	if (stream->link->psr_settings.psr_feature_enabled || stream->link->replay_settings.replay_feature_enabled) {
 		//
 		// should decide stream support vsc sdp colorimetry capability
 		// before building vsc info packet
@@ -6181,9 +6189,8 @@ create_stream_for_sink(struct drm_connector *connector,
 		if (stream->out_transfer_func->tf == TRANSFER_FUNCTION_GAMMA22)
 			tf = TRANSFER_FUNC_GAMMA_22;
 		mod_build_vsc_infopacket(stream, &stream->vsc_infopacket, stream->output_color_space, tf);
+		aconnector->psr_skip_count = AMDGPU_DM_PSR_ENTRY_DELAY;
 
-		if (stream->link->psr_settings.psr_feature_enabled)
-			aconnector->psr_skip_count = AMDGPU_DM_PSR_ENTRY_DELAY;
 	}
 finish:
 	dc_sink_release(sink);
@@ -8218,6 +8225,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			fill_dc_dirty_rects(plane, old_plane_state,
 					    new_plane_state, new_crtc_state,
 					    &bundle->flip_addrs[planes_count],
+					    acrtc_state->stream->link->psr_settings.psr_version ==
+					    DC_PSR_VERSION_SU_1,
 					    &dirty_rects_changed);
 
 			/*
@@ -10839,18 +10848,24 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	if (!adev->dm.freesync_module)
 		goto update;
 
-	if (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT
-		|| sink->sink_signal == SIGNAL_TYPE_EDP) {
+	if (edid && (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT ||
+		     sink->sink_signal == SIGNAL_TYPE_EDP)) {
 		bool edid_check_required = false;
 
-		if (edid) {
-			edid_check_required = is_dp_capable_without_timing_msa(
-						adev->dm.dc,
-						amdgpu_dm_connector);
+		if (is_dp_capable_without_timing_msa(adev->dm.dc,
+						     amdgpu_dm_connector)) {
+			if (edid->features & DRM_EDID_FEATURE_CONTINUOUS_FREQ) {
+				freesync_capable = true;
+				amdgpu_dm_connector->min_vfreq = connector->display_info.monitor_range.min_vfreq;
+				amdgpu_dm_connector->max_vfreq = connector->display_info.monitor_range.max_vfreq;
+			} else {
+				edid_check_required = edid->version > 1 ||
+						      (edid->version == 1 &&
+						       edid->revision > 1);
+			}
 		}
 
-		if (edid_check_required == true && (edid->version > 1 ||
-		   (edid->version == 1 && edid->revision > 1))) {
+		if (edid_check_required) {
 			for (i = 0; i < 4; i++) {
 
 				timing	= &edid->detailed_timings[i];
@@ -10870,14 +10885,23 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 				if (range->flags != 1)
 					continue;
 
-				amdgpu_dm_connector->min_vfreq = range->min_vfreq;
-				amdgpu_dm_connector->max_vfreq = range->max_vfreq;
-				amdgpu_dm_connector->pixel_clock_mhz =
-					range->pixel_clock_mhz * 10;
-
 				connector->display_info.monitor_range.min_vfreq = range->min_vfreq;
 				connector->display_info.monitor_range.max_vfreq = range->max_vfreq;
 
+				if (edid->revision >= 4) {
+					if (data->pad2 & DRM_EDID_RANGE_OFFSET_MIN_VFREQ)
+						connector->display_info.monitor_range.min_vfreq += 255;
+					if (data->pad2 & DRM_EDID_RANGE_OFFSET_MAX_VFREQ)
+						connector->display_info.monitor_range.max_vfreq += 255;
+				}
+
+				amdgpu_dm_connector->min_vfreq =
+					connector->display_info.monitor_range.min_vfreq;
+				amdgpu_dm_connector->max_vfreq =
+					connector->display_info.monitor_range.max_vfreq;
+				amdgpu_dm_connector->pixel_clock_mhz =
+					range->pixel_clock_mhz * 10;
+
 				break;
 			}
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index a496930b1f9c..289918ea7298 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -217,6 +217,16 @@ void dcn32_init_clocks(struct clk_mgr *clk_mgr_base)
 	if (clk_mgr_base->bw_params->dc_mode_limit.dispclk_mhz > 1950)
 		clk_mgr_base->bw_params->dc_mode_limit.dispclk_mhz = 1950;
 
+	/* DPPCLK */
+	dcn32_init_single_clock(clk_mgr, PPCLK_DPPCLK,
+			&clk_mgr_base->bw_params->clk_table.entries[0].dppclk_mhz,
+			&num_entries_per_clk->num_dppclk_levels);
+	num_levels = num_entries_per_clk->num_dppclk_levels;
+	clk_mgr_base->bw_params->dc_mode_limit.dppclk_mhz = dcn30_smu_get_dc_mode_max_dpm_freq(clk_mgr, PPCLK_DPPCLK);
+	//HW recommends limit of 1950 MHz in display clock for all DCN3.2.x
+	if (clk_mgr_base->bw_params->dc_mode_limit.dppclk_mhz > 1950)
+		clk_mgr_base->bw_params->dc_mode_limit.dppclk_mhz = 1950;
+
 	if (num_entries_per_clk->num_dcfclk_levels &&
 			num_entries_per_clk->num_dtbclk_levels &&
 			num_entries_per_clk->num_dispclk_levels)
@@ -241,6 +251,10 @@ void dcn32_init_clocks(struct clk_mgr *clk_mgr_base)
 					= khz_to_mhz_ceil(clk_mgr_base->ctx->dc->debug.min_dpp_clk_khz);
 	}
 
+	for (i = 0; i < num_levels; i++)
+		if (clk_mgr_base->bw_params->clk_table.entries[i].dppclk_mhz > 1950)
+			clk_mgr_base->bw_params->clk_table.entries[i].dppclk_mhz = 1950;
+
 	/* Get UCLK, update bounding box */
 	clk_mgr_base->funcs->get_memclk_states_from_smu(clk_mgr_base);
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 54df6cac19c8..353d5fb9e3f8 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -705,7 +705,7 @@ static void dcn35_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *clk
 		clock_table->NumFclkLevelsEnabled;
 	max_fclk = find_max_clk_value(clock_table->FclkClocks_Freq, num_fclk);
 
-	num_dcfclk = (clock_table->NumFclkLevelsEnabled > NUM_DCFCLK_DPM_LEVELS) ? NUM_DCFCLK_DPM_LEVELS :
+	num_dcfclk = (clock_table->NumDcfClkLevelsEnabled > NUM_DCFCLK_DPM_LEVELS) ? NUM_DCFCLK_DPM_LEVELS :
 		clock_table->NumDcfClkLevelsEnabled;
 	for (i = 0; i < num_dcfclk; i++) {
 		int j;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index bbdeda489768..b51208f44c24 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2258,23 +2258,16 @@ struct dc_state *dc_copy_state(struct dc_state *src_ctx)
 {
 	int i, j;
 	struct dc_state *new_ctx = kvmalloc(sizeof(struct dc_state), GFP_KERNEL);
-#ifdef CONFIG_DRM_AMD_DC_FP
-	struct dml2_context *dml2 =  NULL;
-#endif
 
 	if (!new_ctx)
 		return NULL;
 	memcpy(new_ctx, src_ctx, sizeof(struct dc_state));
 
 #ifdef CONFIG_DRM_AMD_DC_FP
-	if (new_ctx->bw_ctx.dml2) {
-		dml2 = kzalloc(sizeof(struct dml2_context), GFP_KERNEL);
-		if (!dml2)
-			return NULL;
-
-		memcpy(dml2, src_ctx->bw_ctx.dml2, sizeof(struct dml2_context));
-		new_ctx->bw_ctx.dml2 = dml2;
-	}
+	if (new_ctx->bw_ctx.dml2 && !dml2_create_copy(&new_ctx->bw_ctx.dml2, src_ctx->bw_ctx.dml2)) {
+		dc_release_state(new_ctx);
+		return NULL;
+ 	}
 #endif
 
 	for (i = 0; i < MAX_PIPES; i++) {
@@ -3340,6 +3333,9 @@ static bool dc_dmub_should_send_dirty_rect_cmd(struct dc *dc, struct dc_stream_s
 	if (stream->link->replay_settings.config.replay_supported)
 		return true;
 
+	if (stream->ctx->dce_version >= DCN_VERSION_3_5 && stream->abm_level)
+		return true;
+
 	return false;
 }
 
@@ -4929,22 +4925,16 @@ void dc_allow_idle_optimizations(struct dc *dc, bool allow)
 
 bool dc_dmub_is_ips_idle_state(struct dc *dc)
 {
-	uint32_t idle_state = 0;
-
 	if (dc->debug.disable_idle_power_optimizations)
 		return false;
 
 	if (!dc->caps.ips_support || (dc->config.disable_ips == DMUB_IPS_DISABLE_ALL))
 		return false;
 
-	if (dc->hwss.get_idle_state)
-		idle_state = dc->hwss.get_idle_state(dc);
-
-	if (!(idle_state & DMUB_IPS1_ALLOW_MASK) ||
-		!(idle_state & DMUB_IPS2_ALLOW_MASK))
-		return true;
+	if (!dc->ctx->dmub_srv)
+		return false;
 
-	return false;
+	return dc->ctx->dmub_srv->idle_allowed;
 }
 
 /* set min and max memory clock to lowest and highest DPM level, respectively */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
index d1500b223858..2f9da981a8be 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
@@ -44,6 +44,36 @@
 #define NUM_ELEMENTS(a) (sizeof(a) / sizeof((a)[0]))
 
 
+void mpc3_mpc_init(struct mpc *mpc)
+{
+	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
+	int opp_id;
+
+	mpc1_mpc_init(mpc);
+
+	for (opp_id = 0; opp_id < MAX_OPP; opp_id++) {
+		if (REG(MUX[opp_id]))
+			/* disable mpc out rate and flow control */
+			REG_UPDATE_2(MUX[opp_id], MPC_OUT_RATE_CONTROL_DISABLE,
+					1, MPC_OUT_FLOW_CONTROL_COUNT, 0);
+	}
+}
+
+void mpc3_mpc_init_single_inst(struct mpc *mpc, unsigned int mpcc_id)
+{
+	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
+
+	mpc1_mpc_init_single_inst(mpc, mpcc_id);
+
+	/* assuming mpc out mux is connected to opp with the same index at this
+	 * point in time (e.g. transitioning from vbios to driver)
+	 */
+	if (mpcc_id < MAX_OPP && REG(MUX[mpcc_id]))
+		/* disable mpc out rate and flow control */
+		REG_UPDATE_2(MUX[mpcc_id], MPC_OUT_RATE_CONTROL_DISABLE,
+				1, MPC_OUT_FLOW_CONTROL_COUNT, 0);
+}
+
 bool mpc3_is_dwb_idle(
 	struct mpc *mpc,
 	int dwb_id)
@@ -80,25 +110,6 @@ void mpc3_disable_dwb_mux(
 		MPC_DWB0_MUX, 0xf);
 }
 
-void mpc3_set_out_rate_control(
-	struct mpc *mpc,
-	int opp_id,
-	bool enable,
-	bool rate_2x_mode,
-	struct mpc_dwb_flow_control *flow_control)
-{
-	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
-
-	REG_UPDATE_2(MUX[opp_id],
-			MPC_OUT_RATE_CONTROL_DISABLE, !enable,
-			MPC_OUT_RATE_CONTROL, rate_2x_mode);
-
-	if (flow_control)
-		REG_UPDATE_2(MUX[opp_id],
-			MPC_OUT_FLOW_CONTROL_MODE, flow_control->flow_ctrl_mode,
-			MPC_OUT_FLOW_CONTROL_COUNT, flow_control->flow_ctrl_cnt1);
-}
-
 enum dc_lut_mode mpc3_get_ogam_current(struct mpc *mpc, int mpcc_id)
 {
 	/*Contrary to DCN2 and DCN1 wherein a single status register field holds this info;
@@ -1386,8 +1397,8 @@ static const struct mpc_funcs dcn30_mpc_funcs = {
 	.read_mpcc_state = mpc1_read_mpcc_state,
 	.insert_plane = mpc1_insert_plane,
 	.remove_mpcc = mpc1_remove_mpcc,
-	.mpc_init = mpc1_mpc_init,
-	.mpc_init_single_inst = mpc1_mpc_init_single_inst,
+	.mpc_init = mpc3_mpc_init,
+	.mpc_init_single_inst = mpc3_mpc_init_single_inst,
 	.update_blending = mpc2_update_blending,
 	.cursor_lock = mpc1_cursor_lock,
 	.get_mpcc_for_dpp = mpc1_get_mpcc_for_dpp,
@@ -1404,7 +1415,6 @@ static const struct mpc_funcs dcn30_mpc_funcs = {
 	.set_dwb_mux = mpc3_set_dwb_mux,
 	.disable_dwb_mux = mpc3_disable_dwb_mux,
 	.is_dwb_idle = mpc3_is_dwb_idle,
-	.set_out_rate_control = mpc3_set_out_rate_control,
 	.set_gamut_remap = mpc3_set_gamut_remap,
 	.program_shaper = mpc3_program_shaper,
 	.acquire_rmu = mpcc3_acquire_rmu,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h
index 5198f2167c7c..d3b904517a22 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h
@@ -1007,6 +1007,13 @@ void dcn30_mpc_construct(struct dcn30_mpc *mpc30,
 	int num_mpcc,
 	int num_rmu);
 
+void mpc3_mpc_init(
+	struct mpc *mpc);
+
+void mpc3_mpc_init_single_inst(
+	struct mpc *mpc,
+	unsigned int mpcc_id);
+
 bool mpc3_program_shaper(
 		struct mpc *mpc,
 		const struct pwl_params *params,
@@ -1074,13 +1081,6 @@ bool mpc3_is_dwb_idle(
 	struct mpc *mpc,
 	int dwb_id);
 
-void mpc3_set_out_rate_control(
-	struct mpc *mpc,
-	int opp_id,
-	bool enable,
-	bool rate_2x_mode,
-	struct mpc_dwb_flow_control *flow_control);
-
 void mpc3_power_on_ogam_lut(
 	struct mpc *mpc, int mpcc_id,
 	bool power_on);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
index 994b21ed272f..3279b61022f1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
@@ -47,7 +47,7 @@ void mpc32_mpc_init(struct mpc *mpc)
 	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
 	int mpcc_id;
 
-	mpc1_mpc_init(mpc);
+	mpc3_mpc_init(mpc);
 
 	if (mpc->ctx->dc->debug.enable_mem_low_power.bits.mpc) {
 		if (mpc30->mpc_mask->MPCC_MCM_SHAPER_MEM_LOW_PWR_MODE && mpc30->mpc_mask->MPCC_MCM_3DLUT_MEM_LOW_PWR_MODE) {
@@ -990,7 +990,7 @@ static const struct mpc_funcs dcn32_mpc_funcs = {
 	.insert_plane = mpc1_insert_plane,
 	.remove_mpcc = mpc1_remove_mpcc,
 	.mpc_init = mpc32_mpc_init,
-	.mpc_init_single_inst = mpc1_mpc_init_single_inst,
+	.mpc_init_single_inst = mpc3_mpc_init_single_inst,
 	.update_blending = mpc2_update_blending,
 	.cursor_lock = mpc1_cursor_lock,
 	.get_mpcc_for_dpp = mpc1_get_mpcc_for_dpp,
@@ -1007,7 +1007,6 @@ static const struct mpc_funcs dcn32_mpc_funcs = {
 	.set_dwb_mux = mpc3_set_dwb_mux,
 	.disable_dwb_mux = mpc3_disable_dwb_mux,
 	.is_dwb_idle = mpc3_is_dwb_idle,
-	.set_out_rate_control = mpc3_set_out_rate_control,
 	.set_gamut_remap = mpc3_set_gamut_remap,
 	.program_shaper = mpc32_program_shaper,
 	.program_3dlut = mpc32_program_3dlut,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index e940dd0f92b7..f663de1cdcdc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1866,6 +1866,7 @@ static bool dml1_validate(struct dc *dc, struct dc_state *context, bool fast_val
 	dc->res_pool->funcs->calculate_wm_and_dlg(dc, context, pipes, pipe_cnt, vlevel);
 
 	dcn32_override_min_req_memclk(dc, context);
+	dcn32_override_min_req_dcfclk(dc, context);
 
 	BW_VAL_TRACE_END_WATERMARKS();
 
@@ -1924,7 +1925,21 @@ int dcn32_populate_dml_pipes_from_context(
 		dcn32_zero_pipe_dcc_fraction(pipes, pipe_cnt);
 		DC_FP_END();
 		pipes[pipe_cnt].pipe.dest.vfront_porch = timing->v_front_porch;
-		pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_dal;
+		if (dc->config.enable_windowed_mpo_odm &&
+				dc->debug.enable_single_display_2to1_odm_policy) {
+			switch (resource_get_odm_slice_count(pipe)) {
+			case 2:
+				pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_2to1;
+				break;
+			case 4:
+				pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_4to1;
+				break;
+			default:
+				pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_dal;
+			}
+		} else {
+			pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_dal;
+		}
 		pipes[pipe_cnt].pipe.src.gpuvm_min_page_size_kbytes = 256; // according to spreadsheet
 		pipes[pipe_cnt].pipe.src.unbounded_req_mode = false;
 		pipes[pipe_cnt].pipe.scale_ratio_depth.lb_depth = dm_lb_19;
@@ -2011,6 +2026,8 @@ static void dcn32_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw
 {
 	DC_FP_START();
 	dcn32_update_bw_bounding_box_fpu(dc, bw_params);
+	if (dc->debug.using_dml2 && dc->current_state && dc->current_state->bw_ctx.dml2)
+		dml2_reinit(dc, &dc->dml2_options, &dc->current_state->bw_ctx.dml2);
 	DC_FP_END();
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index b931008114c9..351c8a28438c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -41,6 +41,7 @@
 #define SUBVP_HIGH_REFRESH_LIST_LEN 4
 #define DCN3_2_MAX_SUBVP_PIXEL_RATE_MHZ 1800
 #define DCN3_2_VMIN_DISPCLK_HZ 717000000
+#define MIN_SUBVP_DCFCLK_KHZ 400000
 
 #define TO_DCN32_RES_POOL(pool)\
 	container_of(pool, struct dcn32_resource_pool, base)
@@ -183,6 +184,10 @@ bool dcn32_subvp_drr_admissable(struct dc *dc, struct dc_state *context);
 
 bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int vlevel);
 
+void dcn32_update_dml_pipes_odm_policy_based_on_context(struct dc *dc, struct dc_state *context, display_e2e_pipe_params_st *pipes);
+
+void dcn32_override_min_req_dcfclk(struct dc *dc, struct dc_state *context);
+
 /* definitions for run time init of reg offsets */
 
 /* CLK SRC */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index bc5f0db23d0c..1f89428499f7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -778,3 +778,35 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
 
 	return result;
 }
+
+void dcn32_update_dml_pipes_odm_policy_based_on_context(struct dc *dc, struct dc_state *context,
+		display_e2e_pipe_params_st *pipes)
+{
+	int i, pipe_cnt;
+	struct resource_context *res_ctx = &context->res_ctx;
+	struct pipe_ctx *pipe = NULL;
+
+	for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
+		int odm_slice_count = 0;
+
+		if (!res_ctx->pipe_ctx[i].stream)
+			continue;
+		pipe = &res_ctx->pipe_ctx[i];
+		odm_slice_count = resource_get_odm_slice_count(pipe);
+
+		if (odm_slice_count == 1)
+			pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_dal;
+		else if (odm_slice_count == 2)
+			pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_2to1;
+		else if (odm_slice_count == 4)
+			pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_4to1;
+
+		pipe_cnt++;
+	}
+}
+
+void dcn32_override_min_req_dcfclk(struct dc *dc, struct dc_state *context)
+{
+	if (dcn32_subvp_in_use(dc, context) && context->bw_ctx.bw.dcn.clk.dcfclk_khz <= MIN_SUBVP_DCFCLK_KHZ)
+		context->bw_ctx.bw.dcn.clk.dcfclk_khz = MIN_SUBVP_DCFCLK_KHZ;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 4156a8cc2bc7..3b7505b5f0a4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1579,6 +1579,8 @@ static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *b
 {
 	DC_FP_START();
 	dcn321_update_bw_bounding_box_fpu(dc, bw_params);
+	if (dc->debug.using_dml2 && dc->current_state && dc->current_state->bw_ctx.dml2)
+		dml2_reinit(dc, &dc->dml2_options, &dc->current_state->bw_ctx.dml2);
 	DC_FP_END();
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index fe2b67d745f0..b315ca6f1cee 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1265,7 +1265,7 @@ static bool update_pipes_with_split_flags(struct dc *dc, struct dc_state *contex
 	return updated;
 }
 
-static bool should_allow_odm_power_optimization(struct dc *dc,
+static bool should_apply_odm_power_optimization(struct dc *dc,
 		struct dc_state *context, struct vba_vars_st *v, int *split,
 		bool *merge)
 {
@@ -1369,9 +1369,12 @@ static void try_odm_power_optimization_and_revalidate(
 {
 	int i;
 	unsigned int new_vlevel;
+	unsigned int cur_policy[MAX_PIPES];
 
-	for (i = 0; i < pipe_cnt; i++)
+	for (i = 0; i < pipe_cnt; i++) {
+		cur_policy[i] = pipes[i].pipe.dest.odm_combine_policy;
 		pipes[i].pipe.dest.odm_combine_policy = dm_odm_combine_policy_2to1;
+	}
 
 	new_vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
 
@@ -1380,6 +1383,9 @@ static void try_odm_power_optimization_and_revalidate(
 		memset(merge, 0, MAX_PIPES * sizeof(bool));
 		*vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, new_vlevel, split, merge);
 		context->bw_ctx.dml.vba.VoltageLevel = *vlevel;
+	} else {
+		for (i = 0; i < pipe_cnt; i++)
+			pipes[i].pipe.dest.odm_combine_policy = cur_policy[i];
 	}
 }
 
@@ -1550,7 +1556,7 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 		}
 	}
 
-	if (should_allow_odm_power_optimization(dc, context, vba, split, merge))
+	if (should_apply_odm_power_optimization(dc, context, vba, split, merge))
 		try_odm_power_optimization_and_revalidate(
 				dc, context, pipes, split, merge, vlevel, *pipe_cnt);
 
@@ -2178,6 +2184,8 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 		int i;
 
 		pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes, fast_validate);
+		if (!dc->config.enable_windowed_mpo_odm)
+			dcn32_update_dml_pipes_odm_policy_based_on_context(dc, context, pipes);
 
 		/* repopulate_pipes = 1 means the pipes were either split or merged. In this case
 		 * we have to re-calculate the DET allocation and run through DML once more to
@@ -2186,7 +2194,9 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 		 * */
 		context->bw_ctx.dml.soc.allow_for_pstate_or_stutter_in_vblank_final =
 					dm_prefetch_support_uclk_fclk_and_stutter_if_possible;
+
 		vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
+
 		if (vlevel == context->bw_ctx.dml.soc.num_states) {
 			/* failed after DET size changes */
 			goto validate_fail;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 16452dae4aca..b6744ad778fe 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -228,17 +228,13 @@ void dml2_init_socbb_params(struct dml2_context *dml2, const struct dc *in_dc, s
 		break;
 
 	case dml_project_dcn35:
+	case dml_project_dcn351:
 		out->num_chans = 4;
 		out->round_trip_ping_latency_dcfclk_cycles = 106;
 		out->smn_latency_us = 2;
 		out->dispclk_dppclk_vco_speed_mhz = 3600;
 		break;
 
-	case dml_project_dcn351:
-		out->num_chans = 16;
-		out->round_trip_ping_latency_dcfclk_cycles = 1100;
-		out->smn_latency_us = 2;
-		break;
 	}
 	/* ---Overrides if available--- */
 	if (dml2->config.bbox_overrides.dram_num_chan)
@@ -824,13 +820,25 @@ static struct scaler_data get_scaler_data_for_plane(const struct dc_plane_state
 
 static void populate_dummy_dml_plane_cfg(struct dml_plane_cfg_st *out, unsigned int location, const struct dc_stream_state *in)
 {
+	dml_uint_t width, height;
+
+	if (in->timing.h_addressable > 3840)
+		width = 3840;
+	else
+		width = in->timing.h_addressable;	// 4K max
+
+	if (in->timing.v_addressable > 2160)
+		height = 2160;
+	else
+		height = in->timing.v_addressable;	// 4K max
+
 	out->CursorBPP[location] = dml_cur_32bit;
 	out->CursorWidth[location] = 256;
 
 	out->GPUVMMinPageSizeKBytes[location] = 256;
 
-	out->ViewportWidth[location] = in->timing.h_addressable;
-	out->ViewportHeight[location] = in->timing.v_addressable;
+	out->ViewportWidth[location] = width;
+	out->ViewportHeight[location] = height;
 	out->ViewportStationary[location] = false;
 	out->ViewportWidthChroma[location] = 0;
 	out->ViewportHeightChroma[location] = 0;
@@ -849,7 +857,7 @@ static void populate_dummy_dml_plane_cfg(struct dml_plane_cfg_st *out, unsigned
 	out->HTapsChroma[location] = 0;
 	out->VTapsChroma[location] = 0;
 	out->SourceScan[location] = dml_rotation_0;
-	out->ScalerRecoutWidth[location] = in->timing.h_addressable;
+	out->ScalerRecoutWidth[location] = width;
 
 	out->LBBitPerPixel[location] = 57;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index c62b61ac45d2..269bfb14c239 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -696,13 +696,13 @@ bool dml2_validate(const struct dc *in_dc, struct dc_state *context, bool fast_v
 	return out;
 }
 
-bool dml2_create(const struct dc *in_dc, const struct dml2_configuration_options *config, struct dml2_context **dml2)
+static inline struct dml2_context *dml2_allocate_memory(void)
 {
-	// Allocate Mode Lib Ctx
-	*dml2 = (struct dml2_context *) kzalloc(sizeof(struct dml2_context), GFP_KERNEL);
+	return (struct dml2_context *) kzalloc(sizeof(struct dml2_context), GFP_KERNEL);
+}
 
-	if (!(*dml2))
-		return false;
+static void dml2_init(const struct dc *in_dc, const struct dml2_configuration_options *config, struct dml2_context **dml2)
+{
 
 	// Store config options
 	(*dml2)->config = *config;
@@ -730,9 +730,18 @@ bool dml2_create(const struct dc *in_dc, const struct dml2_configuration_options
 	initialize_dml2_soc_bbox(*dml2, in_dc, &(*dml2)->v20.dml_core_ctx.soc);
 
 	initialize_dml2_soc_states(*dml2, in_dc, &(*dml2)->v20.dml_core_ctx.soc, &(*dml2)->v20.dml_core_ctx.states);
+}
+
+bool dml2_create(const struct dc *in_dc, const struct dml2_configuration_options *config, struct dml2_context **dml2)
+{
+	// Allocate Mode Lib Ctx
+	*dml2 = dml2_allocate_memory();
+
+	if (!(*dml2))
+		return false;
+
+	dml2_init(in_dc, config, dml2);
 
-	/*Initialize DML20 instance which calls dml2_core_create, and core_dcn3_populate_informative*/
-	//dml2_initialize_instance(&(*dml_ctx)->v20.dml_init);
 	return true;
 }
 
@@ -750,3 +759,33 @@ void dml2_extract_dram_and_fclk_change_support(struct dml2_context *dml2,
 	*fclk_change_support = (unsigned int) dml2->v20.dml_core_ctx.ms.support.FCLKChangeSupport[0];
 	*dram_clk_change_support = (unsigned int) dml2->v20.dml_core_ctx.ms.support.DRAMClockChangeSupport[0];
 }
+
+void dml2_copy(struct dml2_context *dst_dml2,
+	struct dml2_context *src_dml2)
+{
+	/* copy Mode Lib Ctx */
+	memcpy(dst_dml2, src_dml2, sizeof(struct dml2_context));
+}
+
+bool dml2_create_copy(struct dml2_context **dst_dml2,
+	struct dml2_context *src_dml2)
+{
+	/* Allocate Mode Lib Ctx */
+	*dst_dml2 = dml2_allocate_memory();
+
+	if (!(*dst_dml2))
+		return false;
+
+	/* copy Mode Lib Ctx */
+	dml2_copy(*dst_dml2, src_dml2);
+
+	return true;
+}
+
+void dml2_reinit(const struct dc *in_dc,
+				 const struct dml2_configuration_options *config,
+				 struct dml2_context **dml2)
+{
+
+	dml2_init(in_dc, config, dml2);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
index fe15baa4bf09..548504d7de1e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
@@ -191,6 +191,13 @@ bool dml2_create(const struct dc *in_dc,
 				 struct dml2_context **dml2);
 
 void dml2_destroy(struct dml2_context *dml2);
+void dml2_copy(struct dml2_context *dst_dml2,
+	struct dml2_context *src_dml2);
+bool dml2_create_copy(struct dml2_context **dst_dml2,
+	struct dml2_context *src_dml2);
+void dml2_reinit(const struct dc *in_dc,
+				 const struct dml2_configuration_options *config,
+				 struct dml2_context **dml2);
 
 /*
  * dml2_validate - Determines if a display configuration is supported or not.
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index c1f1665e553d..3642c069bd1b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1184,7 +1184,8 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 		if (dccg) {
 			dccg->funcs->disable_symclk32_se(dccg, dp_hpo_inst);
 			dccg->funcs->set_dpstreamclk(dccg, REFCLK, tg->inst, dp_hpo_inst);
-			dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
+			if (dccg && dccg->funcs->set_dtbclk_dto)
+				dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
 		}
 	} else if (dccg && dccg->funcs->disable_symclk_se) {
 		dccg->funcs->disable_symclk_se(dccg, stream_enc->stream_enc_inst,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index c966f38583cb..e3f547e0613c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1385,6 +1385,11 @@ static void dcn20_detect_pipe_changes(struct pipe_ctx *old_pipe, struct pipe_ctx
 		return;
 	}
 
+	if (resource_is_pipe_type(new_pipe, OTG_MASTER) &&
+			resource_is_odm_topology_changed(new_pipe, old_pipe))
+		/* Detect odm changes */
+		new_pipe->update_flags.bits.odm = 1;
+
 	/* Exit on unchanged, unused pipe */
 	if (!old_pipe->plane_state && !new_pipe->plane_state)
 		return;
@@ -1434,10 +1439,6 @@ static void dcn20_detect_pipe_changes(struct pipe_ctx *old_pipe, struct pipe_ctx
 
 	/* Detect top pipe only changes */
 	if (resource_is_pipe_type(new_pipe, OTG_MASTER)) {
-		/* Detect odm changes */
-		if (resource_is_odm_topology_changed(new_pipe, old_pipe))
-			new_pipe->update_flags.bits.odm = 1;
-
 		/* Detect global sync changes */
 		if (old_pipe->pipe_dlg_param.vready_offset != new_pipe->pipe_dlg_param.vready_offset
 				|| old_pipe->pipe_dlg_param.vstartup_start != new_pipe->pipe_dlg_param.vstartup_start
@@ -1879,19 +1880,20 @@ void dcn20_program_front_end_for_ctx(
 	DC_LOGGER_INIT(dc->ctx->logger);
 	unsigned int prev_hubp_count = 0;
 	unsigned int hubp_count = 0;
+	struct pipe_ctx *pipe;
 
 	if (resource_is_pipe_topology_changed(dc->current_state, context))
 		resource_log_pipe_topology_update(dc, context);
 
 	if (dc->hwss.program_triplebuffer != NULL && dc->debug.enable_tri_buf) {
 		for (i = 0; i < dc->res_pool->pipe_count; i++) {
-			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+			pipe = &context->res_ctx.pipe_ctx[i];
 
-			if (!pipe_ctx->top_pipe && !pipe_ctx->prev_odm_pipe && pipe_ctx->plane_state) {
-				ASSERT(!pipe_ctx->plane_state->triplebuffer_flips);
+			if (!pipe->top_pipe && !pipe->prev_odm_pipe && pipe->plane_state) {
+				ASSERT(!pipe->plane_state->triplebuffer_flips);
 				/*turn off triple buffer for full update*/
 				dc->hwss.program_triplebuffer(
-						dc, pipe_ctx, pipe_ctx->plane_state->triplebuffer_flips);
+						dc, pipe, pipe->plane_state->triplebuffer_flips);
 			}
 		}
 	}
@@ -1965,12 +1967,22 @@ void dcn20_program_front_end_for_ctx(
 			DC_LOG_DC("Reset mpcc for pipe %d\n", dc->current_state->res_ctx.pipe_ctx[i].pipe_idx);
 		}
 
+	/* update ODM for blanked OTG master pipes */
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		pipe = &context->res_ctx.pipe_ctx[i];
+		if (resource_is_pipe_type(pipe, OTG_MASTER) &&
+				!resource_is_pipe_type(pipe, DPP_PIPE) &&
+				pipe->update_flags.bits.odm &&
+				hws->funcs.update_odm)
+			hws->funcs.update_odm(dc, context, pipe);
+	}
+
 	/*
 	 * Program all updated pipes, order matters for mpcc setup. Start with
 	 * top pipe and program all pipes that follow in order
 	 */
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+		pipe = &context->res_ctx.pipe_ctx[i];
 
 		if (pipe->plane_state && !pipe->top_pipe) {
 			while (pipe) {
@@ -2009,17 +2021,6 @@ void dcn20_program_front_end_for_ctx(
 			context->stream_status[0].plane_count > 1) {
 			pipe->plane_res.hubp->funcs->hubp_wait_pipe_read_start(pipe->plane_res.hubp);
 		}
-
-		/* when dynamic ODM is active, pipes must be reconfigured when all planes are
-		 * disabled, as some transitions will leave software and hardware state
-		 * mismatched.
-		 */
-		if (dc->debug.enable_single_display_2to1_odm_policy &&
-			pipe->stream &&
-			pipe->update_flags.bits.disable &&
-			!pipe->prev_odm_pipe &&
-			hws->funcs.update_odm)
-			hws->funcs.update_odm(dc, context, pipe);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 772dc0db916f..c89149d15302 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -656,10 +656,20 @@ void dcn30_set_avmute(struct pipe_ctx *pipe_ctx, bool enable)
 	if (pipe_ctx == NULL)
 		return;
 
-	if (dc_is_hdmi_signal(pipe_ctx->stream->signal) && pipe_ctx->stream_res.stream_enc != NULL)
+	if (dc_is_hdmi_signal(pipe_ctx->stream->signal) && pipe_ctx->stream_res.stream_enc != NULL) {
 		pipe_ctx->stream_res.stream_enc->funcs->set_avmute(
 				pipe_ctx->stream_res.stream_enc,
 				enable);
+
+		/* Wait for two frame to make sure AV mute is sent out */
+		if (enable) {
+			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
+			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VBLANK);
+			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
+			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VBLANK);
+			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
+		}
+	}
 }
 
 void dcn30_update_info_frame(struct pipe_ctx *pipe_ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index 3a9cc8ac0c07..093f4387553c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -69,29 +69,6 @@
 #define FN(reg_name, field_name) \
 	hws->shifts->field_name, hws->masks->field_name
 
-static int calc_mpc_flow_ctrl_cnt(const struct dc_stream_state *stream,
-		int opp_cnt)
-{
-	bool hblank_halved = optc2_is_two_pixels_per_containter(&stream->timing);
-	int flow_ctrl_cnt;
-
-	if (opp_cnt >= 2)
-		hblank_halved = true;
-
-	flow_ctrl_cnt = stream->timing.h_total - stream->timing.h_addressable -
-			stream->timing.h_border_left -
-			stream->timing.h_border_right;
-
-	if (hblank_halved)
-		flow_ctrl_cnt /= 2;
-
-	/* ODM combine 4:1 case */
-	if (opp_cnt == 4)
-		flow_ctrl_cnt /= 2;
-
-	return flow_ctrl_cnt;
-}
-
 static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 {
 	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
@@ -183,10 +160,6 @@ void dcn314_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx
 	struct pipe_ctx *odm_pipe;
 	int opp_cnt = 0;
 	int opp_inst[MAX_PIPES] = {0};
-	bool rate_control_2x_pclk = (pipe_ctx->stream->timing.flags.INTERLACE || optc2_is_two_pixels_per_containter(&pipe_ctx->stream->timing));
-	struct mpc_dwb_flow_control flow_control;
-	struct mpc *mpc = dc->res_pool->mpc;
-	int i;
 
 	opp_cnt = get_odm_config(pipe_ctx, opp_inst);
 
@@ -199,20 +172,6 @@ void dcn314_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx
 		pipe_ctx->stream_res.tg->funcs->set_odm_bypass(
 				pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing);
 
-	rate_control_2x_pclk = rate_control_2x_pclk || opp_cnt > 1;
-	flow_control.flow_ctrl_mode = 0;
-	flow_control.flow_ctrl_cnt0 = 0x80;
-	flow_control.flow_ctrl_cnt1 = calc_mpc_flow_ctrl_cnt(pipe_ctx->stream, opp_cnt);
-	if (mpc->funcs->set_out_rate_control) {
-		for (i = 0; i < opp_cnt; ++i) {
-			mpc->funcs->set_out_rate_control(
-					mpc, opp_inst[i],
-					true,
-					rate_control_2x_pclk,
-					&flow_control);
-		}
-	}
-
 	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
 		odm_pipe->stream_res.opp->funcs->opp_pipe_clock_control(
 				odm_pipe->stream_res.opp,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index cb9d8389329f..580afb0088d7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -969,29 +969,6 @@ void dcn32_init_hw(struct dc *dc)
 	}
 }
 
-static int calc_mpc_flow_ctrl_cnt(const struct dc_stream_state *stream,
-		int opp_cnt)
-{
-	bool hblank_halved = optc2_is_two_pixels_per_containter(&stream->timing);
-	int flow_ctrl_cnt;
-
-	if (opp_cnt >= 2)
-		hblank_halved = true;
-
-	flow_ctrl_cnt = stream->timing.h_total - stream->timing.h_addressable -
-			stream->timing.h_border_left -
-			stream->timing.h_border_right;
-
-	if (hblank_halved)
-		flow_ctrl_cnt /= 2;
-
-	/* ODM combine 4:1 case */
-	if (opp_cnt == 4)
-		flow_ctrl_cnt /= 2;
-
-	return flow_ctrl_cnt;
-}
-
 static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 {
 	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
@@ -1106,10 +1083,6 @@ void dcn32_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 	struct pipe_ctx *odm_pipe;
 	int opp_cnt = 0;
 	int opp_inst[MAX_PIPES] = {0};
-	bool rate_control_2x_pclk = (pipe_ctx->stream->timing.flags.INTERLACE || optc2_is_two_pixels_per_containter(&pipe_ctx->stream->timing));
-	struct mpc_dwb_flow_control flow_control;
-	struct mpc *mpc = dc->res_pool->mpc;
-	int i;
 
 	opp_cnt = get_odm_config(pipe_ctx, opp_inst);
 
@@ -1122,20 +1095,6 @@ void dcn32_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 		pipe_ctx->stream_res.tg->funcs->set_odm_bypass(
 				pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing);
 
-	rate_control_2x_pclk = rate_control_2x_pclk || opp_cnt > 1;
-	flow_control.flow_ctrl_mode = 0;
-	flow_control.flow_ctrl_cnt0 = 0x80;
-	flow_control.flow_ctrl_cnt1 = calc_mpc_flow_ctrl_cnt(pipe_ctx->stream, opp_cnt);
-	if (mpc->funcs->set_out_rate_control) {
-		for (i = 0; i < opp_cnt; ++i) {
-			mpc->funcs->set_out_rate_control(
-					mpc, opp_inst[i],
-					true,
-					rate_control_2x_pclk,
-					&flow_control);
-		}
-	}
-
 	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
 		odm_pipe->stream_res.opp->funcs->opp_pipe_clock_control(
 				odm_pipe->stream_res.opp,
@@ -1159,6 +1118,13 @@ void dcn32_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 			dsc->funcs->dsc_disconnect(dsc);
 		}
 	}
+
+	if (!resource_is_pipe_type(pipe_ctx, DPP_PIPE))
+		/*
+		 * blank pattern is generated by OPP, reprogram blank pattern
+		 * due to OPP count change
+		 */
+		dc->hwseq->funcs.blank_pixel_data(dc, pipe_ctx, true);
 }
 
 unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *k1_div, unsigned int *k2_div)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index cf26d2ad4008..325a711a14e3 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -338,29 +338,6 @@ void dcn35_init_hw(struct dc *dc)
 	}
 }
 
-static int calc_mpc_flow_ctrl_cnt(const struct dc_stream_state *stream,
-		int opp_cnt)
-{
-	bool hblank_halved = optc2_is_two_pixels_per_containter(&stream->timing);
-	int flow_ctrl_cnt;
-
-	if (opp_cnt >= 2)
-		hblank_halved = true;
-
-	flow_ctrl_cnt = stream->timing.h_total - stream->timing.h_addressable -
-			stream->timing.h_border_left -
-			stream->timing.h_border_right;
-
-	if (hblank_halved)
-		flow_ctrl_cnt /= 2;
-
-	/* ODM combine 4:1 case */
-	if (opp_cnt == 4)
-		flow_ctrl_cnt /= 2;
-
-	return flow_ctrl_cnt;
-}
-
 static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 {
 	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
@@ -454,10 +431,6 @@ void dcn35_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 	struct pipe_ctx *odm_pipe;
 	int opp_cnt = 0;
 	int opp_inst[MAX_PIPES] = {0};
-	bool rate_control_2x_pclk = (pipe_ctx->stream->timing.flags.INTERLACE || optc2_is_two_pixels_per_containter(&pipe_ctx->stream->timing));
-	struct mpc_dwb_flow_control flow_control;
-	struct mpc *mpc = dc->res_pool->mpc;
-	int i;
 
 	opp_cnt = get_odm_config(pipe_ctx, opp_inst);
 
@@ -470,20 +443,6 @@ void dcn35_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 		pipe_ctx->stream_res.tg->funcs->set_odm_bypass(
 				pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing);
 
-	rate_control_2x_pclk = rate_control_2x_pclk || opp_cnt > 1;
-	flow_control.flow_ctrl_mode = 0;
-	flow_control.flow_ctrl_cnt0 = 0x80;
-	flow_control.flow_ctrl_cnt1 = calc_mpc_flow_ctrl_cnt(pipe_ctx->stream, opp_cnt);
-	if (mpc->funcs->set_out_rate_control) {
-		for (i = 0; i < opp_cnt; ++i) {
-			mpc->funcs->set_out_rate_control(
-					mpc, opp_inst[i],
-					true,
-					rate_control_2x_pclk,
-					&flow_control);
-		}
-	}
-
 	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
 		odm_pipe->stream_res.opp->funcs->opp_pipe_clock_control(
 				odm_pipe->stream_res.opp,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 06ca8bfb91e7..3d7244393807 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -427,22 +427,18 @@ struct pipe_ctx *resource_get_primary_dpp_pipe(const struct pipe_ctx *dpp_pipe);
 int resource_get_mpc_slice_index(const struct pipe_ctx *dpp_pipe);
 
 /*
- * Get number of MPC "cuts" of the plane associated with the pipe. MPC slice
- * count is equal to MPC splits + 1. For example if a plane is cut 3 times, it
- * will have 4 pieces of slice.
- * return - 0 if pipe is not used for a plane with MPCC combine. otherwise
- * the number of MPC "cuts" for the plane.
+ * Get the number of MPC slices associated with the pipe.
+ * The function returns 0 if the pipe is not associated with an MPC combine
+ * pipe topology.
  */
-int resource_get_mpc_slice_count(const struct pipe_ctx *opp_head);
+int resource_get_mpc_slice_count(const struct pipe_ctx *pipe);
 
 /*
- * Get number of ODM "cuts" of the timing associated with the pipe. ODM slice
- * count is equal to ODM splits + 1. For example if a timing is cut 3 times, it
- * will have 4 pieces of slice.
- * return - 0 if pipe is not used for ODM combine. otherwise
- * the number of ODM "cuts" for the timing.
+ * Get the number of ODM slices associated with the pipe.
+ * The function returns 0 if the pipe is not associated with an ODM combine
+ * pipe topology.
  */
-int resource_get_odm_slice_count(const struct pipe_ctx *otg_master);
+int resource_get_odm_slice_count(const struct pipe_ctx *pipe);
 
 /* Get the ODM slice index counting from 0 from left most slice */
 int resource_get_odm_slice_index(const struct pipe_ctx *opp_head);
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index ee67a35c2a8e..ff930a71e496 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -513,6 +513,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_create_session(struct mod_hdcp *hdcp)
 	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.context.mem_context.shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
 
+	if (!display)
+		return MOD_HDCP_STATUS_DISPLAY_NOT_FOUND;
+
 	hdcp_cmd->in_msg.hdcp2_create_session_v2.display_handle = display->index;
 
 	if (hdcp->connection.link.adjust.hdcp2.force_type == MOD_HDCP_FORCE_TYPE_0)
diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 738ee763f24a..84f9b412a4f1 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -147,15 +147,12 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 	}
 
 	/* VSC packet set to 4 for PSR-SU, or 2 for PSR1 */
-	if (stream->link->psr_settings.psr_feature_enabled) {
-		if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
-			vsc_packet_revision = vsc_packet_rev4;
-		else if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_1)
-			vsc_packet_revision = vsc_packet_rev2;
-	}
-
-	if (stream->link->replay_settings.config.replay_supported)
+	if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
+		vsc_packet_revision = vsc_packet_rev4;
+	else if (stream->link->replay_settings.config.replay_supported)
 		vsc_packet_revision = vsc_packet_rev4;
+	else if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_1)
+		vsc_packet_revision = vsc_packet_rev2;
 
 	/* Update to revision 5 for extended colorimetry support */
 	if (stream->use_vsc_sdp_for_colorimetry)
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 20c53eefd680..fee86be55c4e 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2518,6 +2518,7 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	int err, ret;
+	u32 pwm_mode;
 	int value;
 
 	if (amdgpu_in_reset(adev))
@@ -2529,13 +2530,22 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
 	if (err)
 		return err;
 
+	if (value == 0)
+		pwm_mode = AMD_FAN_CTRL_NONE;
+	else if (value == 1)
+		pwm_mode = AMD_FAN_CTRL_MANUAL;
+	else if (value == 2)
+		pwm_mode = AMD_FAN_CTRL_AUTO;
+	else
+		return -EINVAL;
+
 	ret = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (ret < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 		return ret;
 	}
 
-	ret = amdgpu_dpm_set_fan_control_mode(adev, value);
+	ret = amdgpu_dpm_set_fan_control_mode(adev, pwm_mode);
 
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 294a890beceb..ac04ed1e49f3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1285,8 +1285,9 @@ static int arcturus_get_power_limit(struct smu_context *smu,
 {
 	struct smu_11_0_powerplay_table *powerplay_table =
 		(struct smu_11_0_powerplay_table *)smu->smu_table.power_play_table;
+	struct smu_11_0_overdrive_table *od_settings = smu->od_settings;
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
-	uint32_t power_limit, od_percent_upper, od_percent_lower;
+	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 0;
 
 	if (smu_v11_0_get_current_power_limit(smu, &power_limit)) {
 		/* the last hope to figure out the ppt limit */
@@ -1303,12 +1304,16 @@ static int arcturus_get_power_limit(struct smu_context *smu,
 	if (default_power_limit)
 		*default_power_limit = power_limit;
 
-	if (smu->od_enabled)
-		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
-	else
-		od_percent_upper = 0;
-
-	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+	if (powerplay_table) {
+		if (smu->od_enabled &&
+				od_settings->cap[SMU_11_0_ODCAP_POWER_LIMIT]) {
+			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+		} else if (od_settings->cap[SMU_11_0_ODCAP_POWER_LIMIT]) {
+			od_percent_upper = 0;
+			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+		}
+	}
 
 	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
 							od_percent_upper, od_percent_lower, power_limit);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index aefe72c8abd2..082101845968 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2339,7 +2339,7 @@ static int navi10_get_power_limit(struct smu_context *smu,
 		(struct smu_11_0_powerplay_table *)smu->smu_table.power_play_table;
 	struct smu_11_0_overdrive_table *od_settings = smu->od_settings;
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
-	uint32_t power_limit, od_percent_upper, od_percent_lower;
+	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 0;
 
 	if (smu_v11_0_get_current_power_limit(smu, &power_limit)) {
 		/* the last hope to figure out the ppt limit */
@@ -2356,13 +2356,16 @@ static int navi10_get_power_limit(struct smu_context *smu,
 	if (default_power_limit)
 		*default_power_limit = power_limit;
 
-	if (smu->od_enabled &&
-		    navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT))
-		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
-	else
-		od_percent_upper = 0;
-
-	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+	if (powerplay_table) {
+		if (smu->od_enabled &&
+			    navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT)) {
+			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+		} else if (navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT)) {
+			od_percent_upper = 0;
+			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+		}
+	}
 
 	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
 					od_percent_upper, od_percent_lower, power_limit);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index fa953d444548..6f37ca7a0618 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -617,6 +617,12 @@ static uint32_t sienna_cichlid_get_throttler_status_locked(struct smu_context *s
 	return throttler_status;
 }
 
+static bool sienna_cichlid_is_od_feature_supported(struct smu_11_0_7_overdrive_table *od_table,
+						   enum SMU_11_0_7_ODFEATURE_CAP cap)
+{
+	return od_table->cap[cap];
+}
+
 static int sienna_cichlid_get_power_limit(struct smu_context *smu,
 					  uint32_t *current_power_limit,
 					  uint32_t *default_power_limit,
@@ -625,7 +631,8 @@ static int sienna_cichlid_get_power_limit(struct smu_context *smu,
 {
 	struct smu_11_0_7_powerplay_table *powerplay_table =
 		(struct smu_11_0_7_powerplay_table *)smu->smu_table.power_play_table;
-	uint32_t power_limit, od_percent_upper, od_percent_lower;
+	struct smu_11_0_7_overdrive_table *od_settings = smu->od_settings;
+	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 0;
 	uint16_t *table_member;
 
 	GET_PPTABLE_MEMBER(SocketPowerLimitAc, &table_member);
@@ -640,12 +647,16 @@ static int sienna_cichlid_get_power_limit(struct smu_context *smu,
 	if (default_power_limit)
 		*default_power_limit = power_limit;
 
-	if (smu->od_enabled)
-		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
-	else
-		od_percent_upper = 0;
-
-	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
+	if (powerplay_table) {
+		if (smu->od_enabled &&
+				sienna_cichlid_is_od_feature_supported(od_settings, SMU_11_0_7_ODCAP_POWER_LIMIT)) {
+			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
+			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
+		} else if ((sienna_cichlid_is_od_feature_supported(od_settings, SMU_11_0_7_ODCAP_POWER_LIMIT))) {
+			od_percent_upper = 0;
+			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
+		}
+	}
 
 	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
 					od_percent_upper, od_percent_lower, power_limit);
@@ -1250,12 +1261,6 @@ static bool sienna_cichlid_is_support_fine_grained_dpm(struct smu_context *smu,
 	return dpm_desc->SnapToDiscrete == 0;
 }
 
-static bool sienna_cichlid_is_od_feature_supported(struct smu_11_0_7_overdrive_table *od_table,
-						   enum SMU_11_0_7_ODFEATURE_CAP cap)
-{
-	return od_table->cap[cap];
-}
-
 static void sienna_cichlid_get_od_setting_range(struct smu_11_0_7_overdrive_table *od_table,
 						enum SMU_11_0_7_ODSETTING_ID setting,
 						uint32_t *min, uint32_t *max)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index ac3c9e0966ed..9ac6c408d2b6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2351,7 +2351,7 @@ static int smu_v13_0_0_get_power_limit(struct smu_context *smu,
 		(struct smu_13_0_0_powerplay_table *)table_context->power_play_table;
 	PPTable_t *pptable = table_context->driver_pptable;
 	SkuTable_t *skutable = &pptable->SkuTable;
-	uint32_t power_limit, od_percent_upper, od_percent_lower;
+	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 0;
 	uint32_t msg_limit = skutable->MsgLimits.Power[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
 
 	if (smu_v13_0_get_current_power_limit(smu, &power_limit))
@@ -2364,12 +2364,16 @@ static int smu_v13_0_0_get_power_limit(struct smu_context *smu,
 	if (default_power_limit)
 		*default_power_limit = power_limit;
 
-	if (smu->od_enabled)
-		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
-	else
-		od_percent_upper = 0;
-
-	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
+	if (powerplay_table) {
+		if (smu->od_enabled &&
+				smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_PPT_BIT)) {
+			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
+			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
+		} else if (smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_PPT_BIT)) {
+			od_percent_upper = 0;
+			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
+		}
+	}
 
 	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
 					od_percent_upper, od_percent_lower, power_limit);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index b296c5f9d98d..402e0d184e14 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2315,7 +2315,7 @@ static int smu_v13_0_7_get_power_limit(struct smu_context *smu,
 		(struct smu_13_0_7_powerplay_table *)table_context->power_play_table;
 	PPTable_t *pptable = table_context->driver_pptable;
 	SkuTable_t *skutable = &pptable->SkuTable;
-	uint32_t power_limit, od_percent_upper, od_percent_lower;
+	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 0;
 	uint32_t msg_limit = skutable->MsgLimits.Power[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
 
 	if (smu_v13_0_get_current_power_limit(smu, &power_limit))
@@ -2328,12 +2328,16 @@ static int smu_v13_0_7_get_power_limit(struct smu_context *smu,
 	if (default_power_limit)
 		*default_power_limit = power_limit;
 
-	if (smu->od_enabled)
-		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
-	else
-		od_percent_upper = 0;
-
-	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
+	if (powerplay_table) {
+		if (smu->od_enabled &&
+				(smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_PPT_BIT))) {
+			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
+			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
+		} else if (smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_PPT_BIT)) {
+			od_percent_upper = 0;
+			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
+		}
+	}
 
 	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
 					od_percent_upper, od_percent_lower, power_limit);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index d8f8ad0e7137..01f2ab456724 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -229,8 +229,6 @@ int smu_v14_0_check_fw_version(struct smu_context *smu)
 		smu->smc_driver_if_version = SMU14_DRIVER_IF_VERSION_SMU_V14_0_2;
 		break;
 	case IP_VERSION(14, 0, 0):
-		if ((smu->smc_fw_version < 0x5d3a00))
-			dev_warn(smu->adev->dev, "The PMFW version(%x) is behind in this BIOS!\n", smu->smc_fw_version);
 		smu->smc_driver_if_version = SMU14_DRIVER_IF_VERSION_SMU_V14_0_0;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 94ccdbfd7090..24a43374a753 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -261,7 +261,10 @@ static int smu_v14_0_0_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->MpipuclkFrequency;
 		break;
 	case METRICS_AVERAGE_GFXACTIVITY:
-		*value = metrics->GfxActivity / 100;
+		if ((smu->smc_fw_version > 0x5d4600))
+			*value = metrics->GfxActivity;
+		else
+			*value = metrics->GfxActivity / 100;
 		break;
 	case METRICS_AVERAGE_VCNACTIVITY:
 		*value = metrics->VcnActivity / 100;
diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index 03532efb893b..e5839c89a355 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -429,26 +429,24 @@ lt8912_connector_mode_valid(struct drm_connector *connector,
 
 static int lt8912_connector_get_modes(struct drm_connector *connector)
 {
-	struct edid *edid;
-	int ret = -1;
-	int num = 0;
+	const struct drm_edid *drm_edid;
 	struct lt8912 *lt = connector_to_lt8912(connector);
 	u32 bus_format = MEDIA_BUS_FMT_RGB888_1X24;
+	int ret, num;
 
-	edid = drm_bridge_get_edid(lt->hdmi_port, connector);
-	if (edid) {
-		drm_connector_update_edid_property(connector, edid);
-		num = drm_add_edid_modes(connector, edid);
-	} else {
-		return ret;
-	}
+	drm_edid = drm_bridge_edid_read(lt->hdmi_port, connector);
+	drm_edid_connector_update(connector, drm_edid);
+	if (!drm_edid)
+		return 0;
+
+	num = drm_edid_connector_add_modes(connector);
 
 	ret = drm_display_info_set_bus_formats(&connector->display_info,
 					       &bus_format, 1);
-	if (ret)
-		num = ret;
+	if (ret < 0)
+		num = 0;
 
-	kfree(edid);
+	drm_edid_free(drm_edid);
 	return num;
 }
 
diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 30d66bee0ec6..e1cfba2ff583 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -27,8 +27,9 @@
 #include <linux/mutex.h>
 
 #include <drm/drm_atomic_state_helper.h>
-#include <drm/drm_debugfs.h>
 #include <drm/drm_bridge.h>
+#include <drm/drm_debugfs.h>
+#include <drm/drm_edid.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_file.h>
 #include <drm/drm_of.h>
@@ -1206,6 +1207,47 @@ int drm_bridge_get_modes(struct drm_bridge *bridge,
 }
 EXPORT_SYMBOL_GPL(drm_bridge_get_modes);
 
+/**
+ * drm_bridge_edid_read - read the EDID data of the connected display
+ * @bridge: bridge control structure
+ * @connector: the connector to read EDID for
+ *
+ * If the bridge supports output EDID retrieval, as reported by the
+ * DRM_BRIDGE_OP_EDID bridge ops flag, call &drm_bridge_funcs.edid_read to get
+ * the EDID and return it. Otherwise return NULL.
+ *
+ * If &drm_bridge_funcs.edid_read is not set, fall back to using
+ * drm_bridge_get_edid() and wrapping it in struct drm_edid.
+ *
+ * RETURNS:
+ * The retrieved EDID on success, or NULL otherwise.
+ */
+const struct drm_edid *drm_bridge_edid_read(struct drm_bridge *bridge,
+					    struct drm_connector *connector)
+{
+	if (!(bridge->ops & DRM_BRIDGE_OP_EDID))
+		return NULL;
+
+	/* Transitional: Fall back to ->get_edid. */
+	if (!bridge->funcs->edid_read) {
+		const struct drm_edid *drm_edid;
+		struct edid *edid;
+
+		edid = drm_bridge_get_edid(bridge, connector);
+		if (!edid)
+			return NULL;
+
+		drm_edid = drm_edid_alloc(edid, (edid->extensions + 1) * EDID_LENGTH);
+
+		kfree(edid);
+
+		return drm_edid;
+	}
+
+	return bridge->funcs->edid_read(bridge, connector);
+}
+EXPORT_SYMBOL_GPL(drm_bridge_edid_read);
+
 /**
  * drm_bridge_get_edid - get the EDID data of the connected display
  * @bridge: bridge control structure
@@ -1215,6 +1257,8 @@ EXPORT_SYMBOL_GPL(drm_bridge_get_modes);
  * DRM_BRIDGE_OP_EDID bridge ops flag, call &drm_bridge_funcs.get_edid to
  * get the EDID and return it. Otherwise return NULL.
  *
+ * Deprecated. Prefer using drm_bridge_edid_read().
+ *
  * RETURNS:
  * The retrieved EDID on success, or NULL otherwise.
  */
diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index e814020bbcd3..cfbe020de54e 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -274,19 +274,24 @@ EXPORT_SYMBOL(drm_panel_disable);
  * The modes probed from the panel are automatically added to the connector
  * that the panel is attached to.
  *
- * Return: The number of modes available from the panel on success or a
- * negative error code on failure.
+ * Return: The number of modes available from the panel on success, or 0 on
+ * failure (no modes).
  */
 int drm_panel_get_modes(struct drm_panel *panel,
 			struct drm_connector *connector)
 {
 	if (!panel)
-		return -EINVAL;
+		return 0;
 
-	if (panel->funcs && panel->funcs->get_modes)
-		return panel->funcs->get_modes(panel, connector);
+	if (panel->funcs && panel->funcs->get_modes) {
+		int num;
 
-	return -EOPNOTSUPP;
+		num = panel->funcs->get_modes(panel, connector);
+		if (num > 0)
+			return num;
+	}
+
+	return 0;
 }
 EXPORT_SYMBOL(drm_panel_get_modes);
 
diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index 3f479483d7d8..15ed974bcb98 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -419,6 +419,13 @@ static int drm_helper_probe_get_modes(struct drm_connector *connector)
 
 	count = connector_funcs->get_modes(connector);
 
+	/* The .get_modes() callback should not return negative values. */
+	if (count < 0) {
+		drm_err(connector->dev, ".get_modes() returned %pe\n",
+			ERR_PTR(count));
+		count = 0;
+	}
+
 	/*
 	 * Fallback for when DDC probe failed in drm_get_edid() and thus skipped
 	 * override/firmware EDID.
diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 5860428da8de..f0bdcfc0c2e7 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -1367,7 +1367,7 @@ static void syncobj_eventfd_entry_fence_func(struct dma_fence *fence,
 	struct syncobj_eventfd_entry *entry =
 		container_of(cb, struct syncobj_eventfd_entry, fence_cb);
 
-	eventfd_signal(entry->ev_fd_ctx, 1);
+	eventfd_signal(entry->ev_fd_ctx);
 	syncobj_eventfd_entry_free(entry);
 }
 
@@ -1401,13 +1401,13 @@ syncobj_eventfd_entry_func(struct drm_syncobj *syncobj,
 	entry->fence = fence;
 
 	if (entry->flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE) {
-		eventfd_signal(entry->ev_fd_ctx, 1);
+		eventfd_signal(entry->ev_fd_ctx);
 		syncobj_eventfd_entry_free(entry);
 	} else {
 		ret = dma_fence_add_callback(fence, &entry->fence_cb,
 					     syncobj_eventfd_entry_fence_func);
 		if (ret == -ENOENT) {
-			eventfd_signal(entry->ev_fd_ctx, 1);
+			eventfd_signal(entry->ev_fd_ctx);
 			syncobj_eventfd_entry_free(entry);
 		}
 	}
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index a8d3fa81e4ec..f9bc837e22bd 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -494,7 +494,7 @@ static const struct drm_driver etnaviv_drm_driver = {
 	.desc               = "etnaviv DRM",
 	.date               = "20151214",
 	.major              = 1,
-	.minor              = 3,
+	.minor              = 4,
 };
 
 /*
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
index 67201242438b..8665f2658d51 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
@@ -265,6 +265,9 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
 bool etnaviv_fill_identity_from_hwdb(struct etnaviv_gpu *gpu)
 {
 	struct etnaviv_chip_identity *ident = &gpu->identity;
+	const u32 product_id = ident->product_id;
+	const u32 customer_id = ident->customer_id;
+	const u32 eco_id = ident->eco_id;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(etnaviv_chip_identities); i++) {
@@ -278,6 +281,12 @@ bool etnaviv_fill_identity_from_hwdb(struct etnaviv_gpu *gpu)
 			 etnaviv_chip_identities[i].eco_id == ~0U)) {
 			memcpy(ident, &etnaviv_chip_identities[i],
 			       sizeof(*ident));
+
+			/* Restore some id values as ~0U aka 'don't care' might been used. */
+			ident->product_id = product_id;
+			ident->customer_id = customer_id;
+			ident->eco_id = eco_id;
+
 			return true;
 		}
 	}
diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index f5e1adfcaa51..fb941a8c99f0 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -316,14 +316,14 @@ static int vidi_get_modes(struct drm_connector *connector)
 	 */
 	if (!ctx->raw_edid) {
 		DRM_DEV_DEBUG_KMS(ctx->dev, "raw_edid is null.\n");
-		return -EFAULT;
+		return 0;
 	}
 
 	edid_len = (1 + ctx->raw_edid->extensions) * EDID_LENGTH;
 	edid = kmemdup(ctx->raw_edid, edid_len, GFP_KERNEL);
 	if (!edid) {
 		DRM_DEV_DEBUG_KMS(ctx->dev, "failed to allocate edid\n");
-		return -ENOMEM;
+		return 0;
 	}
 
 	drm_connector_update_edid_property(connector, edid);
diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index dd9903eab563..eff51bfc4644 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -887,11 +887,11 @@ static int hdmi_get_modes(struct drm_connector *connector)
 	int ret;
 
 	if (!hdata->ddc_adpt)
-		return -ENODEV;
+		return 0;
 
 	edid = drm_get_edid(connector, hdata->ddc_adpt);
 	if (!edid)
-		return -ENODEV;
+		return 0;
 
 	hdata->dvi_mode = !connector->display_info.is_hdmi;
 	DRM_DEV_DEBUG_KMS(hdata->dev, "%s : width[%d] x height[%d]\n",
diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
index bf0dbd7d0697..67143a0f5189 100644
--- a/drivers/gpu/drm/i915/display/icl_dsi.c
+++ b/drivers/gpu/drm/i915/display/icl_dsi.c
@@ -1155,7 +1155,6 @@ static void gen11_dsi_powerup_panel(struct intel_encoder *encoder)
 	}
 
 	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_INIT_OTP);
-	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_DISPLAY_ON);
 
 	/* ensure all panel commands dispatched before enabling transcoder */
 	wait_for_cmds_dispatched_to_panel(encoder);
@@ -1256,6 +1255,8 @@ static void gen11_dsi_enable(struct intel_atomic_state *state,
 	/* step6d: enable dsi transcoder */
 	gen11_dsi_enable_transcoder(encoder);
 
+	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_DISPLAY_ON);
+
 	/* step7: enable backlight */
 	intel_backlight_enable(crtc_state, conn_state);
 	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_BACKLIGHT_ON);
diff --git a/drivers/gpu/drm/i915/display/intel_bios.c b/drivers/gpu/drm/i915/display/intel_bios.c
index 4e8f1e91bb08..e7ea2878455d 100644
--- a/drivers/gpu/drm/i915/display/intel_bios.c
+++ b/drivers/gpu/drm/i915/display/intel_bios.c
@@ -1952,16 +1952,12 @@ static int get_init_otp_deassert_fragment_len(struct drm_i915_private *i915,
  * these devices we split the init OTP sequence into a deassert sequence and
  * the actual init OTP part.
  */
-static void fixup_mipi_sequences(struct drm_i915_private *i915,
-				 struct intel_panel *panel)
+static void vlv_fixup_mipi_sequences(struct drm_i915_private *i915,
+				     struct intel_panel *panel)
 {
 	u8 *init_otp;
 	int len;
 
-	/* Limit this to VLV for now. */
-	if (!IS_VALLEYVIEW(i915))
-		return;
-
 	/* Limit this to v1 vid-mode sequences */
 	if (panel->vbt.dsi.config->is_cmd_mode ||
 	    panel->vbt.dsi.seq_version != 1)
@@ -1997,6 +1993,41 @@ static void fixup_mipi_sequences(struct drm_i915_private *i915,
 	panel->vbt.dsi.sequence[MIPI_SEQ_INIT_OTP] = init_otp + len - 1;
 }
 
+/*
+ * Some machines (eg. Lenovo 82TQ) appear to have broken
+ * VBT sequences:
+ * - INIT_OTP is not present at all
+ * - what should be in INIT_OTP is in DISPLAY_ON
+ * - what should be in DISPLAY_ON is in BACKLIGHT_ON
+ *   (along with the actual backlight stuff)
+ *
+ * To make those work we simply swap DISPLAY_ON and INIT_OTP.
+ *
+ * TODO: Do we need to limit this to specific machines,
+ *       or examine the contents of the sequences to
+ *       avoid false positives?
+ */
+static void icl_fixup_mipi_sequences(struct drm_i915_private *i915,
+				     struct intel_panel *panel)
+{
+	if (!panel->vbt.dsi.sequence[MIPI_SEQ_INIT_OTP] &&
+	    panel->vbt.dsi.sequence[MIPI_SEQ_DISPLAY_ON]) {
+		drm_dbg_kms(&i915->drm, "Broken VBT: Swapping INIT_OTP and DISPLAY_ON sequences\n");
+
+		swap(panel->vbt.dsi.sequence[MIPI_SEQ_INIT_OTP],
+		     panel->vbt.dsi.sequence[MIPI_SEQ_DISPLAY_ON]);
+	}
+}
+
+static void fixup_mipi_sequences(struct drm_i915_private *i915,
+				 struct intel_panel *panel)
+{
+	if (DISPLAY_VER(i915) >= 11)
+		icl_fixup_mipi_sequences(i915, panel);
+	else if (IS_VALLEYVIEW(i915))
+		vlv_fixup_mipi_sequences(i915, panel);
+}
+
 static void
 parse_mipi_sequence(struct drm_i915_private *i915,
 		    struct intel_panel *panel)
@@ -3321,6 +3352,9 @@ bool intel_bios_encoder_supports_dp_dual_mode(const struct intel_bios_encoder_da
 {
 	const struct child_device_config *child = &devdata->child;
 
+	if (!devdata)
+		return false;
+
 	if (!intel_bios_encoder_supports_dp(devdata) ||
 	    !intel_bios_encoder_supports_hdmi(devdata))
 		return false;
diff --git a/drivers/gpu/drm/i915/display/intel_display_power_well.c b/drivers/gpu/drm/i915/display/intel_display_power_well.c
index 07d650050099..82dd5be72ee2 100644
--- a/drivers/gpu/drm/i915/display/intel_display_power_well.c
+++ b/drivers/gpu/drm/i915/display/intel_display_power_well.c
@@ -246,7 +246,14 @@ static enum phy icl_aux_pw_to_phy(struct drm_i915_private *i915,
 	enum aux_ch aux_ch = icl_aux_pw_to_ch(power_well);
 	struct intel_digital_port *dig_port = aux_ch_to_digital_port(i915, aux_ch);
 
-	return intel_port_to_phy(i915, dig_port->base.port);
+	/*
+	 * FIXME should we care about the (VBT defined) dig_port->aux_ch
+	 * relationship or should this be purely defined by the hardware layout?
+	 * Currently if the port doesn't appear in the VBT, or if it's declared
+	 * as HDMI-only and routed to a combo PHY, the encoder either won't be
+	 * present at all or it will not have an aux_ch assigned.
+	 */
+	return dig_port ? intel_port_to_phy(i915, dig_port->base.port) : PHY_NONE;
 }
 
 static void hsw_wait_for_power_well_enable(struct drm_i915_private *dev_priv,
@@ -414,7 +421,8 @@ icl_combo_phy_aux_power_well_enable(struct drm_i915_private *dev_priv,
 
 	intel_de_rmw(dev_priv, regs->driver, 0, HSW_PWR_WELL_CTL_REQ(pw_idx));
 
-	if (DISPLAY_VER(dev_priv) < 12)
+	/* FIXME this is a mess */
+	if (phy != PHY_NONE)
 		intel_de_rmw(dev_priv, ICL_PORT_CL_DW12(phy),
 			     0, ICL_LANE_ENABLE_AUX);
 
@@ -437,7 +445,10 @@ icl_combo_phy_aux_power_well_disable(struct drm_i915_private *dev_priv,
 
 	drm_WARN_ON(&dev_priv->drm, !IS_ICELAKE(dev_priv));
 
-	intel_de_rmw(dev_priv, ICL_PORT_CL_DW12(phy), ICL_LANE_ENABLE_AUX, 0);
+	/* FIXME this is a mess */
+	if (phy != PHY_NONE)
+		intel_de_rmw(dev_priv, ICL_PORT_CL_DW12(phy),
+			     ICL_LANE_ENABLE_AUX, 0);
 
 	intel_de_rmw(dev_priv, regs->driver, HSW_PWR_WELL_CTL_REQ(pw_idx), 0);
 
diff --git a/drivers/gpu/drm/i915/display/intel_display_trace.h b/drivers/gpu/drm/i915/display/intel_display_trace.h
index 99bdb833591c..7862e7cefe02 100644
--- a/drivers/gpu/drm/i915/display/intel_display_trace.h
+++ b/drivers/gpu/drm/i915/display/intel_display_trace.h
@@ -411,7 +411,7 @@ TRACE_EVENT(intel_fbc_activate,
 			   struct intel_crtc *crtc = intel_crtc_for_pipe(to_i915(plane->base.dev),
 									 plane->pipe);
 			   __assign_str(dev, __dev_name_kms(plane));
-			   __assign_str(name, plane->base.name)
+			   __assign_str(name, plane->base.name);
 			   __entry->pipe = crtc->pipe;
 			   __entry->frame = intel_crtc_get_vblank_counter(crtc);
 			   __entry->scanline = intel_get_crtc_scanline(crtc);
@@ -438,7 +438,7 @@ TRACE_EVENT(intel_fbc_deactivate,
 			   struct intel_crtc *crtc = intel_crtc_for_pipe(to_i915(plane->base.dev),
 									 plane->pipe);
 			   __assign_str(dev, __dev_name_kms(plane));
-			   __assign_str(name, plane->base.name)
+			   __assign_str(name, plane->base.name);
 			   __entry->pipe = crtc->pipe;
 			   __entry->frame = intel_crtc_get_vblank_counter(crtc);
 			   __entry->scanline = intel_get_crtc_scanline(crtc);
@@ -465,7 +465,7 @@ TRACE_EVENT(intel_fbc_nuke,
 			   struct intel_crtc *crtc = intel_crtc_for_pipe(to_i915(plane->base.dev),
 									 plane->pipe);
 			   __assign_str(dev, __dev_name_kms(plane));
-			   __assign_str(name, plane->base.name)
+			   __assign_str(name, plane->base.name);
 			   __entry->pipe = crtc->pipe;
 			   __entry->frame = intel_crtc_get_vblank_counter(crtc);
 			   __entry->scanline = intel_get_crtc_scanline(crtc);
diff --git a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
index 399653a20f98..fb694ff9dc61 100644
--- a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
+++ b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
@@ -631,9 +631,9 @@ static const struct intel_shared_dpll_funcs ibx_pch_dpll_funcs = {
 };
 
 static const struct dpll_info pch_plls[] = {
-	{ "PCH DPLL A", &ibx_pch_dpll_funcs, DPLL_ID_PCH_PLL_A, 0 },
-	{ "PCH DPLL B", &ibx_pch_dpll_funcs, DPLL_ID_PCH_PLL_B, 0 },
-	{ },
+	{ .name = "PCH DPLL A", .funcs = &ibx_pch_dpll_funcs, .id = DPLL_ID_PCH_PLL_A, },
+	{ .name = "PCH DPLL B", .funcs = &ibx_pch_dpll_funcs, .id = DPLL_ID_PCH_PLL_B, },
+	{}
 };
 
 static const struct intel_dpll_mgr pch_pll_mgr = {
@@ -1239,13 +1239,16 @@ static const struct intel_shared_dpll_funcs hsw_ddi_lcpll_funcs = {
 };
 
 static const struct dpll_info hsw_plls[] = {
-	{ "WRPLL 1",    &hsw_ddi_wrpll_funcs, DPLL_ID_WRPLL1,     0 },
-	{ "WRPLL 2",    &hsw_ddi_wrpll_funcs, DPLL_ID_WRPLL2,     0 },
-	{ "SPLL",       &hsw_ddi_spll_funcs,  DPLL_ID_SPLL,       0 },
-	{ "LCPLL 810",  &hsw_ddi_lcpll_funcs, DPLL_ID_LCPLL_810,  INTEL_DPLL_ALWAYS_ON },
-	{ "LCPLL 1350", &hsw_ddi_lcpll_funcs, DPLL_ID_LCPLL_1350, INTEL_DPLL_ALWAYS_ON },
-	{ "LCPLL 2700", &hsw_ddi_lcpll_funcs, DPLL_ID_LCPLL_2700, INTEL_DPLL_ALWAYS_ON },
-	{ },
+	{ .name = "WRPLL 1", .funcs = &hsw_ddi_wrpll_funcs, .id = DPLL_ID_WRPLL1, },
+	{ .name = "WRPLL 2", .funcs = &hsw_ddi_wrpll_funcs, .id = DPLL_ID_WRPLL2, },
+	{ .name = "SPLL", .funcs = &hsw_ddi_spll_funcs, .id = DPLL_ID_SPLL, },
+	{ .name = "LCPLL 810", .funcs = &hsw_ddi_lcpll_funcs, .id = DPLL_ID_LCPLL_810,
+	  .flags = INTEL_DPLL_ALWAYS_ON, },
+	{ .name = "LCPLL 1350", .funcs = &hsw_ddi_lcpll_funcs, .id = DPLL_ID_LCPLL_1350,
+	  .flags = INTEL_DPLL_ALWAYS_ON, },
+	{ .name = "LCPLL 2700", .funcs = &hsw_ddi_lcpll_funcs, .id = DPLL_ID_LCPLL_2700,
+	  .flags = INTEL_DPLL_ALWAYS_ON, },
+	{}
 };
 
 static const struct intel_dpll_mgr hsw_pll_mgr = {
@@ -1921,11 +1924,12 @@ static const struct intel_shared_dpll_funcs skl_ddi_dpll0_funcs = {
 };
 
 static const struct dpll_info skl_plls[] = {
-	{ "DPLL 0", &skl_ddi_dpll0_funcs, DPLL_ID_SKL_DPLL0, INTEL_DPLL_ALWAYS_ON },
-	{ "DPLL 1", &skl_ddi_pll_funcs,   DPLL_ID_SKL_DPLL1, 0 },
-	{ "DPLL 2", &skl_ddi_pll_funcs,   DPLL_ID_SKL_DPLL2, 0 },
-	{ "DPLL 3", &skl_ddi_pll_funcs,   DPLL_ID_SKL_DPLL3, 0 },
-	{ },
+	{ .name = "DPLL 0", .funcs = &skl_ddi_dpll0_funcs, .id = DPLL_ID_SKL_DPLL0,
+	  .flags = INTEL_DPLL_ALWAYS_ON, },
+	{ .name = "DPLL 1", .funcs = &skl_ddi_pll_funcs, .id = DPLL_ID_SKL_DPLL1, },
+	{ .name = "DPLL 2", .funcs = &skl_ddi_pll_funcs, .id = DPLL_ID_SKL_DPLL2, },
+	{ .name = "DPLL 3", .funcs = &skl_ddi_pll_funcs, .id = DPLL_ID_SKL_DPLL3, },
+	{}
 };
 
 static const struct intel_dpll_mgr skl_pll_mgr = {
@@ -2376,10 +2380,10 @@ static const struct intel_shared_dpll_funcs bxt_ddi_pll_funcs = {
 };
 
 static const struct dpll_info bxt_plls[] = {
-	{ "PORT PLL A", &bxt_ddi_pll_funcs, DPLL_ID_SKL_DPLL0, 0 },
-	{ "PORT PLL B", &bxt_ddi_pll_funcs, DPLL_ID_SKL_DPLL1, 0 },
-	{ "PORT PLL C", &bxt_ddi_pll_funcs, DPLL_ID_SKL_DPLL2, 0 },
-	{ },
+	{ .name = "PORT PLL A", .funcs = &bxt_ddi_pll_funcs, .id = DPLL_ID_SKL_DPLL0, },
+	{ .name = "PORT PLL B", .funcs = &bxt_ddi_pll_funcs, .id = DPLL_ID_SKL_DPLL1, },
+	{ .name = "PORT PLL C", .funcs = &bxt_ddi_pll_funcs, .id = DPLL_ID_SKL_DPLL2, },
+	{}
 };
 
 static const struct intel_dpll_mgr bxt_pll_mgr = {
@@ -2485,7 +2489,7 @@ static void icl_wrpll_params_populate(struct skl_wrpll_params *params,
 static bool
 ehl_combo_pll_div_frac_wa_needed(struct drm_i915_private *i915)
 {
-	return (((IS_ELKHARTLAKE(i915) || IS_JASPERLAKE(i915)) &&
+	return ((IS_ELKHARTLAKE(i915) &&
 		 IS_DISPLAY_STEP(i915, STEP_B0, STEP_FOREVER)) ||
 		 IS_TIGERLAKE(i915) || IS_ALDERLAKE_S(i915) || IS_ALDERLAKE_P(i915)) &&
 		 i915->display.dpll.ref_clks.nssc == 38400;
@@ -3284,6 +3288,8 @@ static int icl_compute_tc_phy_dplls(struct intel_atomic_state *state,
 	struct drm_i915_private *i915 = to_i915(state->base.dev);
 	struct intel_crtc_state *crtc_state =
 		intel_atomic_get_new_crtc_state(state, crtc);
+	const struct intel_crtc_state *old_crtc_state =
+		intel_atomic_get_old_crtc_state(state, crtc);
 	struct icl_port_dpll *port_dpll =
 		&crtc_state->icl_port_dplls[ICL_PORT_DPLL_DEFAULT];
 	struct skl_wrpll_params pll_params = {};
@@ -3302,7 +3308,11 @@ static int icl_compute_tc_phy_dplls(struct intel_atomic_state *state,
 		return ret;
 
 	/* this is mainly for the fastset check */
-	icl_set_active_port_dpll(crtc_state, ICL_PORT_DPLL_MG_PHY);
+	if (old_crtc_state->shared_dpll &&
+	    old_crtc_state->shared_dpll->info->id == DPLL_ID_ICL_TBTPLL)
+		icl_set_active_port_dpll(crtc_state, ICL_PORT_DPLL_DEFAULT);
+	else
+		icl_set_active_port_dpll(crtc_state, ICL_PORT_DPLL_MG_PHY);
 
 	crtc_state->port_clock = icl_ddi_mg_pll_get_freq(i915, NULL,
 							 &port_dpll->hw_state);
@@ -4014,14 +4024,15 @@ static const struct intel_shared_dpll_funcs mg_pll_funcs = {
 };
 
 static const struct dpll_info icl_plls[] = {
-	{ "DPLL 0",   &combo_pll_funcs, DPLL_ID_ICL_DPLL0,  0 },
-	{ "DPLL 1",   &combo_pll_funcs, DPLL_ID_ICL_DPLL1,  0 },
-	{ "TBT PLL",  &tbt_pll_funcs, DPLL_ID_ICL_TBTPLL, 0 },
-	{ "MG PLL 1", &mg_pll_funcs, DPLL_ID_ICL_MGPLL1, 0 },
-	{ "MG PLL 2", &mg_pll_funcs, DPLL_ID_ICL_MGPLL2, 0 },
-	{ "MG PLL 3", &mg_pll_funcs, DPLL_ID_ICL_MGPLL3, 0 },
-	{ "MG PLL 4", &mg_pll_funcs, DPLL_ID_ICL_MGPLL4, 0 },
-	{ },
+	{ .name = "DPLL 0", .funcs = &combo_pll_funcs, .id = DPLL_ID_ICL_DPLL0, },
+	{ .name = "DPLL 1", .funcs = &combo_pll_funcs, .id = DPLL_ID_ICL_DPLL1, },
+	{ .name = "TBT PLL", .funcs = &tbt_pll_funcs, .id = DPLL_ID_ICL_TBTPLL,
+	  .flags = INTEL_DPLL_IS_ALT_PORT_DPLL, },
+	{ .name = "MG PLL 1", .funcs = &mg_pll_funcs, .id = DPLL_ID_ICL_MGPLL1, },
+	{ .name = "MG PLL 2", .funcs = &mg_pll_funcs, .id = DPLL_ID_ICL_MGPLL2, },
+	{ .name = "MG PLL 3", .funcs = &mg_pll_funcs, .id = DPLL_ID_ICL_MGPLL3, },
+	{ .name = "MG PLL 4", .funcs = &mg_pll_funcs, .id = DPLL_ID_ICL_MGPLL4, },
+	{}
 };
 
 static const struct intel_dpll_mgr icl_pll_mgr = {
@@ -4035,10 +4046,10 @@ static const struct intel_dpll_mgr icl_pll_mgr = {
 };
 
 static const struct dpll_info ehl_plls[] = {
-	{ "DPLL 0", &combo_pll_funcs, DPLL_ID_ICL_DPLL0, 0 },
-	{ "DPLL 1", &combo_pll_funcs, DPLL_ID_ICL_DPLL1, 0 },
-	{ "DPLL 4", &combo_pll_funcs, DPLL_ID_EHL_DPLL4, 0 },
-	{ },
+	{ .name = "DPLL 0", .funcs = &combo_pll_funcs, .id = DPLL_ID_ICL_DPLL0, },
+	{ .name = "DPLL 1", .funcs = &combo_pll_funcs, .id = DPLL_ID_ICL_DPLL1, },
+	{ .name = "DPLL 4", .funcs = &combo_pll_funcs, .id = DPLL_ID_EHL_DPLL4, },
+	{}
 };
 
 static const struct intel_dpll_mgr ehl_pll_mgr = {
@@ -4058,16 +4069,17 @@ static const struct intel_shared_dpll_funcs dkl_pll_funcs = {
 };
 
 static const struct dpll_info tgl_plls[] = {
-	{ "DPLL 0", &combo_pll_funcs, DPLL_ID_ICL_DPLL0,  0 },
-	{ "DPLL 1", &combo_pll_funcs, DPLL_ID_ICL_DPLL1,  0 },
-	{ "TBT PLL",  &tbt_pll_funcs, DPLL_ID_ICL_TBTPLL, 0 },
-	{ "TC PLL 1", &dkl_pll_funcs, DPLL_ID_ICL_MGPLL1, 0 },
-	{ "TC PLL 2", &dkl_pll_funcs, DPLL_ID_ICL_MGPLL2, 0 },
-	{ "TC PLL 3", &dkl_pll_funcs, DPLL_ID_ICL_MGPLL3, 0 },
-	{ "TC PLL 4", &dkl_pll_funcs, DPLL_ID_ICL_MGPLL4, 0 },
-	{ "TC PLL 5", &dkl_pll_funcs, DPLL_ID_TGL_MGPLL5, 0 },
-	{ "TC PLL 6", &dkl_pll_funcs, DPLL_ID_TGL_MGPLL6, 0 },
-	{ },
+	{ .name = "DPLL 0", .funcs = &combo_pll_funcs, .id = DPLL_ID_ICL_DPLL0, },
+	{ .name = "DPLL 1", .funcs = &combo_pll_funcs, .id = DPLL_ID_ICL_DPLL1, },
+	{ .name = "TBT PLL", .funcs = &tbt_pll_funcs, .id = DPLL_ID_ICL_TBTPLL,
+	  .flags = INTEL_DPLL_IS_ALT_PORT_DPLL, },
+	{ .name = "TC PLL 1", .funcs = &dkl_pll_funcs, .id = DPLL_ID_ICL_MGPLL1, },
+	{ .name = "TC PLL 2", .funcs = &dkl_pll_funcs, .id = DPLL_ID_ICL_MGPLL2, },
+	{ .name = "TC PLL 3", .funcs = &dkl_pll_funcs, .id = DPLL_ID_ICL_MGPLL3, },
+	{ .name = "TC PLL 4", .funcs = &dkl_pll_funcs, .id = DPLL_ID_ICL_MGPLL4, },
+	{ .name = "TC PLL 5", .funcs = &dkl_pll_funcs, .id = DPLL_ID_TGL_MGPLL5, },
+	{ .name = "TC PLL 6", .funcs = &dkl_pll_funcs, .id = DPLL_ID_TGL_MGPLL6, },
+	{}
 };
 
 static const struct intel_dpll_mgr tgl_pll_mgr = {
@@ -4081,10 +4093,10 @@ static const struct intel_dpll_mgr tgl_pll_mgr = {
 };
 
 static const struct dpll_info rkl_plls[] = {
-	{ "DPLL 0", &combo_pll_funcs, DPLL_ID_ICL_DPLL0, 0 },
-	{ "DPLL 1", &combo_pll_funcs, DPLL_ID_ICL_DPLL1, 0 },
-	{ "DPLL 4", &combo_pll_funcs, DPLL_ID_EHL_DPLL4, 0 },
-	{ },
+	{ .name = "DPLL 0", .funcs = &combo_pll_funcs, .id = DPLL_ID_ICL_DPLL0, },
+	{ .name = "DPLL 1", .funcs = &combo_pll_funcs, .id = DPLL_ID_ICL_DPLL1, },
+	{ .name = "DPLL 4", .funcs = &combo_pll_funcs, .id = DPLL_ID_EHL_DPLL4, },
+	{}
 };
 
 static const struct intel_dpll_mgr rkl_pll_mgr = {
@@ -4097,11 +4109,11 @@ static const struct intel_dpll_mgr rkl_pll_mgr = {
 };
 
 static const struct dpll_info dg1_plls[] = {
-	{ "DPLL 0", &combo_pll_funcs, DPLL_ID_DG1_DPLL0, 0 },
-	{ "DPLL 1", &combo_pll_funcs, DPLL_ID_DG1_DPLL1, 0 },
-	{ "DPLL 2", &combo_pll_funcs, DPLL_ID_DG1_DPLL2, 0 },
-	{ "DPLL 3", &combo_pll_funcs, DPLL_ID_DG1_DPLL3, 0 },
-	{ },
+	{ .name = "DPLL 0", .funcs = &combo_pll_funcs, .id = DPLL_ID_DG1_DPLL0, },
+	{ .name = "DPLL 1", .funcs = &combo_pll_funcs, .id = DPLL_ID_DG1_DPLL1, },
+	{ .name = "DPLL 2", .funcs = &combo_pll_funcs, .id = DPLL_ID_DG1_DPLL2, },
+	{ .name = "DPLL 3", .funcs = &combo_pll_funcs, .id = DPLL_ID_DG1_DPLL3, },
+	{}
 };
 
 static const struct intel_dpll_mgr dg1_pll_mgr = {
@@ -4114,11 +4126,11 @@ static const struct intel_dpll_mgr dg1_pll_mgr = {
 };
 
 static const struct dpll_info adls_plls[] = {
-	{ "DPLL 0", &combo_pll_funcs, DPLL_ID_ICL_DPLL0, 0 },
-	{ "DPLL 1", &combo_pll_funcs, DPLL_ID_ICL_DPLL1, 0 },
-	{ "DPLL 2", &combo_pll_funcs, DPLL_ID_DG1_DPLL2, 0 },
-	{ "DPLL 3", &combo_pll_funcs, DPLL_ID_DG1_DPLL3, 0 },
-	{ },
+	{ .name = "DPLL 0", .funcs = &combo_pll_funcs, .id = DPLL_ID_ICL_DPLL0, },
+	{ .name = "DPLL 1", .funcs = &combo_pll_funcs, .id = DPLL_ID_ICL_DPLL1, },
+	{ .name = "DPLL 2", .funcs = &combo_pll_funcs, .id = DPLL_ID_DG1_DPLL2, },
+	{ .name = "DPLL 3", .funcs = &combo_pll_funcs, .id = DPLL_ID_DG1_DPLL3, },
+	{}
 };
 
 static const struct intel_dpll_mgr adls_pll_mgr = {
@@ -4131,14 +4143,15 @@ static const struct intel_dpll_mgr adls_pll_mgr = {
 };
 
 static const struct dpll_info adlp_plls[] = {
-	{ "DPLL 0", &combo_pll_funcs, DPLL_ID_ICL_DPLL0,  0 },
-	{ "DPLL 1", &combo_pll_funcs, DPLL_ID_ICL_DPLL1,  0 },
-	{ "TBT PLL",  &tbt_pll_funcs, DPLL_ID_ICL_TBTPLL, 0 },
-	{ "TC PLL 1", &dkl_pll_funcs, DPLL_ID_ICL_MGPLL1, 0 },
-	{ "TC PLL 2", &dkl_pll_funcs, DPLL_ID_ICL_MGPLL2, 0 },
-	{ "TC PLL 3", &dkl_pll_funcs, DPLL_ID_ICL_MGPLL3, 0 },
-	{ "TC PLL 4", &dkl_pll_funcs, DPLL_ID_ICL_MGPLL4, 0 },
-	{ },
+	{ .name = "DPLL 0", .funcs = &combo_pll_funcs, .id = DPLL_ID_ICL_DPLL0, },
+	{ .name = "DPLL 1", .funcs = &combo_pll_funcs, .id = DPLL_ID_ICL_DPLL1, },
+	{ .name = "TBT PLL", .funcs = &tbt_pll_funcs, .id = DPLL_ID_ICL_TBTPLL,
+	  .flags = INTEL_DPLL_IS_ALT_PORT_DPLL, },
+	{ .name = "TC PLL 1", .funcs = &dkl_pll_funcs, .id = DPLL_ID_ICL_MGPLL1, },
+	{ .name = "TC PLL 2", .funcs = &dkl_pll_funcs, .id = DPLL_ID_ICL_MGPLL2, },
+	{ .name = "TC PLL 3", .funcs = &dkl_pll_funcs, .id = DPLL_ID_ICL_MGPLL3, },
+	{ .name = "TC PLL 4", .funcs = &dkl_pll_funcs, .id = DPLL_ID_ICL_MGPLL4, },
+	{}
 };
 
 static const struct intel_dpll_mgr adlp_pll_mgr = {
@@ -4462,31 +4475,29 @@ verify_single_dpll_state(struct drm_i915_private *i915,
 			 struct intel_crtc *crtc,
 			 const struct intel_crtc_state *new_crtc_state)
 {
-	struct intel_dpll_hw_state dpll_hw_state;
+	struct intel_dpll_hw_state dpll_hw_state = {};
 	u8 pipe_mask;
 	bool active;
 
-	memset(&dpll_hw_state, 0, sizeof(dpll_hw_state));
-
-	drm_dbg_kms(&i915->drm, "%s\n", pll->info->name);
-
 	active = intel_dpll_get_hw_state(i915, pll, &dpll_hw_state);
 
 	if (!(pll->info->flags & INTEL_DPLL_ALWAYS_ON)) {
 		I915_STATE_WARN(i915, !pll->on && pll->active_mask,
-				"pll in active use but not on in sw tracking\n");
+				"%s: pll in active use but not on in sw tracking\n",
+				pll->info->name);
 		I915_STATE_WARN(i915, pll->on && !pll->active_mask,
-				"pll is on but not used by any active pipe\n");
+				"%s: pll is on but not used by any active pipe\n",
+				pll->info->name);
 		I915_STATE_WARN(i915, pll->on != active,
-				"pll on state mismatch (expected %i, found %i)\n",
-				pll->on, active);
+				"%s: pll on state mismatch (expected %i, found %i)\n",
+				pll->info->name, pll->on, active);
 	}
 
 	if (!crtc) {
 		I915_STATE_WARN(i915,
 				pll->active_mask & ~pll->state.pipe_mask,
-				"more active pll users than references: 0x%x vs 0x%x\n",
-				pll->active_mask, pll->state.pipe_mask);
+				"%s: more active pll users than references: 0x%x vs 0x%x\n",
+				pll->info->name, pll->active_mask, pll->state.pipe_mask);
 
 		return;
 	}
@@ -4495,21 +4506,30 @@ verify_single_dpll_state(struct drm_i915_private *i915,
 
 	if (new_crtc_state->hw.active)
 		I915_STATE_WARN(i915, !(pll->active_mask & pipe_mask),
-				"pll active mismatch (expected pipe %c in active mask 0x%x)\n",
-				pipe_name(crtc->pipe), pll->active_mask);
+				"%s: pll active mismatch (expected pipe %c in active mask 0x%x)\n",
+				pll->info->name, pipe_name(crtc->pipe), pll->active_mask);
 	else
 		I915_STATE_WARN(i915, pll->active_mask & pipe_mask,
-				"pll active mismatch (didn't expect pipe %c in active mask 0x%x)\n",
-				pipe_name(crtc->pipe), pll->active_mask);
+				"%s: pll active mismatch (didn't expect pipe %c in active mask 0x%x)\n",
+				pll->info->name, pipe_name(crtc->pipe), pll->active_mask);
 
 	I915_STATE_WARN(i915, !(pll->state.pipe_mask & pipe_mask),
-			"pll enabled crtcs mismatch (expected 0x%x in 0x%x)\n",
-			pipe_mask, pll->state.pipe_mask);
+			"%s: pll enabled crtcs mismatch (expected 0x%x in 0x%x)\n",
+			pll->info->name, pipe_mask, pll->state.pipe_mask);
 
 	I915_STATE_WARN(i915,
 			pll->on && memcmp(&pll->state.hw_state, &dpll_hw_state,
 					  sizeof(dpll_hw_state)),
-			"pll hw state mismatch\n");
+			"%s: pll hw state mismatch\n",
+			pll->info->name);
+}
+
+static bool has_alt_port_dpll(const struct intel_shared_dpll *old_pll,
+			      const struct intel_shared_dpll *new_pll)
+{
+	return old_pll && new_pll && old_pll != new_pll &&
+		(old_pll->info->flags & INTEL_DPLL_IS_ALT_PORT_DPLL ||
+		 new_pll->info->flags & INTEL_DPLL_IS_ALT_PORT_DPLL);
 }
 
 void intel_shared_dpll_state_verify(struct intel_atomic_state *state,
@@ -4531,11 +4551,15 @@ void intel_shared_dpll_state_verify(struct intel_atomic_state *state,
 		struct intel_shared_dpll *pll = old_crtc_state->shared_dpll;
 
 		I915_STATE_WARN(i915, pll->active_mask & pipe_mask,
-				"pll active mismatch (didn't expect pipe %c in active mask (0x%x))\n",
-				pipe_name(crtc->pipe), pll->active_mask);
-		I915_STATE_WARN(i915, pll->state.pipe_mask & pipe_mask,
-				"pll enabled crtcs mismatch (found %x in enabled mask (0x%x))\n",
-				pipe_name(crtc->pipe), pll->state.pipe_mask);
+				"%s: pll active mismatch (didn't expect pipe %c in active mask (0x%x))\n",
+				pll->info->name, pipe_name(crtc->pipe), pll->active_mask);
+
+		/* TC ports have both MG/TC and TBT PLL referenced simultaneously */
+		I915_STATE_WARN(i915, !has_alt_port_dpll(old_crtc_state->shared_dpll,
+							 new_crtc_state->shared_dpll) &&
+				pll->state.pipe_mask & pipe_mask,
+				"%s: pll enabled crtcs mismatch (found pipe %c in enabled mask (0x%x))\n",
+				pll->info->name, pipe_name(crtc->pipe), pll->state.pipe_mask);
 	}
 }
 
diff --git a/drivers/gpu/drm/i915/display/intel_dpll_mgr.h b/drivers/gpu/drm/i915/display/intel_dpll_mgr.h
index dd4796a61751..1a88ccc98344 100644
--- a/drivers/gpu/drm/i915/display/intel_dpll_mgr.h
+++ b/drivers/gpu/drm/i915/display/intel_dpll_mgr.h
@@ -271,12 +271,16 @@ struct dpll_info {
 	enum intel_dpll_id id;
 
 #define INTEL_DPLL_ALWAYS_ON	(1 << 0)
+#define INTEL_DPLL_IS_ALT_PORT_DPLL	(1 << 1)
 	/**
 	 * @flags:
 	 *
 	 * INTEL_DPLL_ALWAYS_ON
 	 *     Inform the state checker that the DPLL is kept enabled even if
 	 *     not in use by any CRTC.
+	 * INTEL_DPLL_IS_ALT_PORT_DPLL
+	 *     Inform the state checker that the DPLL can be used as a fallback
+	 *     (for TC->TBT fallback).
 	 */
 	u32 flags;
 };
diff --git a/drivers/gpu/drm/i915/display/intel_dsb.c b/drivers/gpu/drm/i915/display/intel_dsb.c
index 7fd6280c54a7..15c3dd5d388b 100644
--- a/drivers/gpu/drm/i915/display/intel_dsb.c
+++ b/drivers/gpu/drm/i915/display/intel_dsb.c
@@ -339,6 +339,17 @@ static int intel_dsb_dewake_scanline(const struct intel_crtc_state *crtc_state)
 	return max(0, vblank_start - intel_usecs_to_scanlines(adjusted_mode, latency));
 }
 
+static u32 dsb_chicken(struct intel_crtc *crtc)
+{
+	if (crtc->mode_flags & I915_MODE_FLAG_VRR)
+		return DSB_CTRL_WAIT_SAFE_WINDOW |
+			DSB_CTRL_NO_WAIT_VBLANK |
+			DSB_INST_WAIT_SAFE_WINDOW |
+			DSB_INST_NO_WAIT_VBLANK;
+	else
+		return 0;
+}
+
 static void _intel_dsb_commit(struct intel_dsb *dsb, u32 ctrl,
 			      int dewake_scanline)
 {
@@ -360,6 +371,9 @@ static void _intel_dsb_commit(struct intel_dsb *dsb, u32 ctrl,
 	intel_de_write_fw(dev_priv, DSB_CTRL(pipe, dsb->id),
 			  ctrl | DSB_ENABLE);
 
+	intel_de_write_fw(dev_priv, DSB_CHICKEN(pipe, dsb->id),
+			  dsb_chicken(crtc));
+
 	intel_de_write_fw(dev_priv, DSB_HEAD(pipe, dsb->id),
 			  i915_ggtt_offset(dsb->vma));
 
diff --git a/drivers/gpu/drm/i915/display/intel_vrr.c b/drivers/gpu/drm/i915/display/intel_vrr.c
index 5d905f932cb4..eb5bd0743902 100644
--- a/drivers/gpu/drm/i915/display/intel_vrr.c
+++ b/drivers/gpu/drm/i915/display/intel_vrr.c
@@ -187,10 +187,11 @@ void intel_vrr_set_transcoder_timings(const struct intel_crtc_state *crtc_state)
 	enum transcoder cpu_transcoder = crtc_state->cpu_transcoder;
 
 	/*
-	 * TRANS_SET_CONTEXT_LATENCY with VRR enabled
-	 * requires this chicken bit on ADL/DG2.
+	 * This bit seems to have two meanings depending on the platform:
+	 * TGL: generate VRR "safe window" for DSB vblank waits
+	 * ADL/DG2: make TRANS_SET_CONTEXT_LATENCY effective with VRR
 	 */
-	if (DISPLAY_VER(dev_priv) == 13)
+	if (IS_DISPLAY_VER(dev_priv, 12, 13))
 		intel_de_rmw(dev_priv, CHICKEN_TRANS(cpu_transcoder),
 			     0, PIPE_VBLANK_WITH_DELAY);
 
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
index 1d3ebdf4069b..c08b67593565 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
@@ -379,6 +379,9 @@ i915_gem_userptr_release(struct drm_i915_gem_object *obj)
 {
 	GEM_WARN_ON(obj->userptr.page_ref);
 
+	if (!obj->userptr.notifier.mm)
+		return;
+
 	mmu_interval_notifier_remove(&obj->userptr.notifier);
 	obj->userptr.notifier.mm = NULL;
 }
diff --git a/drivers/gpu/drm/i915/gt/intel_engine_pm.c b/drivers/gpu/drm/i915/gt/intel_engine_pm.c
index e91fc881dbf1..5a3a5b29d150 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_pm.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_pm.c
@@ -278,9 +278,6 @@ static int __engine_park(struct intel_wakeref *wf)
 	intel_engine_park_heartbeat(engine);
 	intel_breadcrumbs_park(engine->breadcrumbs);
 
-	/* Must be reset upon idling, or we may miss the busy wakeup. */
-	GEM_BUG_ON(engine->sched_engine->queue_priority_hint != INT_MIN);
-
 	if (engine->park)
 		engine->park(engine);
 
diff --git a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
index e8f42ec6b1b4..42e09f158920 100644
--- a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
+++ b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
@@ -3272,6 +3272,9 @@ static void execlists_park(struct intel_engine_cs *engine)
 {
 	cancel_timer(&engine->execlists.timer);
 	cancel_timer(&engine->execlists.preempt);
+
+	/* Reset upon idling, or we may delay the busy wakeup. */
+	WRITE_ONCE(engine->sched_engine->queue_priority_hint, INT_MIN);
 }
 
 static void add_to_engine(struct i915_request *rq)
diff --git a/drivers/gpu/drm/i915/gvt/interrupt.c b/drivers/gpu/drm/i915/gvt/interrupt.c
index de3f5903d1a7..c8e7dfc9f791 100644
--- a/drivers/gpu/drm/i915/gvt/interrupt.c
+++ b/drivers/gpu/drm/i915/gvt/interrupt.c
@@ -422,7 +422,7 @@ static void init_irq_map(struct intel_gvt_irq *irq)
 #define MSI_CAP_DATA(offset) (offset + 8)
 #define MSI_CAP_EN 0x1
 
-static int inject_virtual_interrupt(struct intel_vgpu *vgpu)
+static void inject_virtual_interrupt(struct intel_vgpu *vgpu)
 {
 	unsigned long offset = vgpu->gvt->device_info.msi_cap_offset;
 	u16 control, data;
@@ -434,10 +434,10 @@ static int inject_virtual_interrupt(struct intel_vgpu *vgpu)
 
 	/* Do not generate MSI if MSIEN is disabled */
 	if (!(control & MSI_CAP_EN))
-		return 0;
+		return;
 
 	if (WARN(control & GENMASK(15, 1), "only support one MSI format\n"))
-		return -EINVAL;
+		return;
 
 	trace_inject_msi(vgpu->id, addr, data);
 
@@ -451,10 +451,9 @@ static int inject_virtual_interrupt(struct intel_vgpu *vgpu)
 	 * returned and don't inject interrupt into guest.
 	 */
 	if (!test_bit(INTEL_VGPU_STATUS_ATTACHED, vgpu->status))
-		return -ESRCH;
-	if (vgpu->msi_trigger && eventfd_signal(vgpu->msi_trigger, 1) != 1)
-		return -EFAULT;
-	return 0;
+		return;
+	if (vgpu->msi_trigger)
+		eventfd_signal(vgpu->msi_trigger);
 }
 
 static void propagate_event(struct intel_gvt_irq *irq,
diff --git a/drivers/gpu/drm/i915/i915_hwmon.c b/drivers/gpu/drm/i915/i915_hwmon.c
index 8c3f443c8347..b758fd110c20 100644
--- a/drivers/gpu/drm/i915/i915_hwmon.c
+++ b/drivers/gpu/drm/i915/i915_hwmon.c
@@ -72,12 +72,13 @@ hwm_locked_with_pm_intel_uncore_rmw(struct hwm_drvdata *ddat,
 	struct intel_uncore *uncore = ddat->uncore;
 	intel_wakeref_t wakeref;
 
-	mutex_lock(&hwmon->hwmon_lock);
+	with_intel_runtime_pm(uncore->rpm, wakeref) {
+		mutex_lock(&hwmon->hwmon_lock);
 
-	with_intel_runtime_pm(uncore->rpm, wakeref)
 		intel_uncore_rmw(uncore, reg, clear, set);
 
-	mutex_unlock(&hwmon->hwmon_lock);
+		mutex_unlock(&hwmon->hwmon_lock);
+	}
 }
 
 /*
@@ -136,20 +137,21 @@ hwm_energy(struct hwm_drvdata *ddat, long *energy)
 	else
 		rgaddr = hwmon->rg.energy_status_all;
 
-	mutex_lock(&hwmon->hwmon_lock);
+	with_intel_runtime_pm(uncore->rpm, wakeref) {
+		mutex_lock(&hwmon->hwmon_lock);
 
-	with_intel_runtime_pm(uncore->rpm, wakeref)
 		reg_val = intel_uncore_read(uncore, rgaddr);
 
-	if (reg_val >= ei->reg_val_prev)
-		ei->accum_energy += reg_val - ei->reg_val_prev;
-	else
-		ei->accum_energy += UINT_MAX - ei->reg_val_prev + reg_val;
-	ei->reg_val_prev = reg_val;
+		if (reg_val >= ei->reg_val_prev)
+			ei->accum_energy += reg_val - ei->reg_val_prev;
+		else
+			ei->accum_energy += UINT_MAX - ei->reg_val_prev + reg_val;
+		ei->reg_val_prev = reg_val;
 
-	*energy = mul_u64_u32_shr(ei->accum_energy, SF_ENERGY,
-				  hwmon->scl_shift_energy);
-	mutex_unlock(&hwmon->hwmon_lock);
+		*energy = mul_u64_u32_shr(ei->accum_energy, SF_ENERGY,
+					  hwmon->scl_shift_energy);
+		mutex_unlock(&hwmon->hwmon_lock);
+	}
 }
 
 static ssize_t
@@ -404,6 +406,7 @@ hwm_power_max_write(struct hwm_drvdata *ddat, long val)
 
 	/* Block waiting for GuC reset to complete when needed */
 	for (;;) {
+		wakeref = intel_runtime_pm_get(ddat->uncore->rpm);
 		mutex_lock(&hwmon->hwmon_lock);
 
 		prepare_to_wait(&ddat->waitq, &wait, TASK_INTERRUPTIBLE);
@@ -417,14 +420,13 @@ hwm_power_max_write(struct hwm_drvdata *ddat, long val)
 		}
 
 		mutex_unlock(&hwmon->hwmon_lock);
+		intel_runtime_pm_put(ddat->uncore->rpm, wakeref);
 
 		schedule();
 	}
 	finish_wait(&ddat->waitq, &wait);
 	if (ret)
-		goto unlock;
-
-	wakeref = intel_runtime_pm_get(ddat->uncore->rpm);
+		goto exit;
 
 	/* Disable PL1 limit and verify, because the limit cannot be disabled on all platforms */
 	if (val == PL1_DISABLE) {
@@ -444,9 +446,8 @@ hwm_power_max_write(struct hwm_drvdata *ddat, long val)
 	intel_uncore_rmw(ddat->uncore, hwmon->rg.pkg_rapl_limit,
 			 PKG_PWR_LIM_1_EN | PKG_PWR_LIM_1, nval);
 exit:
-	intel_runtime_pm_put(ddat->uncore->rpm, wakeref);
-unlock:
 	mutex_unlock(&hwmon->hwmon_lock);
+	intel_runtime_pm_put(ddat->uncore->rpm, wakeref);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/i915/i915_reg.h b/drivers/gpu/drm/i915/i915_reg.h
index 135e8d8dbdf0..b89cf2041f73 100644
--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -4599,7 +4599,7 @@
 #define MTL_CHICKEN_TRANS(trans)	_MMIO_TRANS((trans), \
 						    _MTL_CHICKEN_TRANS_A, \
 						    _MTL_CHICKEN_TRANS_B)
-#define   PIPE_VBLANK_WITH_DELAY	REG_BIT(31) /* ADL/DG2 */
+#define   PIPE_VBLANK_WITH_DELAY	REG_BIT(31) /* tgl+ */
 #define   SKL_UNMASK_VBL_TO_PIPE_IN_SRD	REG_BIT(30) /* skl+ */
 #define   HSW_FRAME_START_DELAY_MASK	REG_GENMASK(28, 27)
 #define   HSW_FRAME_START_DELAY(x)	REG_FIELD_PREP(HSW_FRAME_START_DELAY_MASK, x)
diff --git a/drivers/gpu/drm/imx/ipuv3/parallel-display.c b/drivers/gpu/drm/imx/ipuv3/parallel-display.c
index 70349739dd89..55dedd73f528 100644
--- a/drivers/gpu/drm/imx/ipuv3/parallel-display.c
+++ b/drivers/gpu/drm/imx/ipuv3/parallel-display.c
@@ -72,14 +72,14 @@ static int imx_pd_connector_get_modes(struct drm_connector *connector)
 		int ret;
 
 		if (!mode)
-			return -EINVAL;
+			return 0;
 
 		ret = of_get_drm_display_mode(np, &imxpd->mode,
 					      &imxpd->bus_flags,
 					      OF_USE_NATIVE_MODE);
 		if (ret) {
 			drm_mode_destroy(connector->dev, mode);
-			return ret;
+			return 0;
 		}
 
 		drm_mode_copy(mode, &imxpd->mode);
diff --git a/drivers/gpu/drm/nouveau/include/nvkm/core/client.h b/drivers/gpu/drm/nouveau/include/nvkm/core/client.h
index 0d9fc741a719..932c9fd0b2d8 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/core/client.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/core/client.h
@@ -11,6 +11,7 @@ struct nvkm_client {
 	u32 debug;
 
 	struct rb_root objroot;
+	spinlock_t obj_lock;
 
 	void *data;
 	int (*event)(u64 token, void *argv, u32 argc);
diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 12feecf71e75..6fb65b01d778 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -378,9 +378,9 @@ nouveau_dmem_evict_chunk(struct nouveau_dmem_chunk *chunk)
 	dma_addr_t *dma_addrs;
 	struct nouveau_fence *fence;
 
-	src_pfns = kcalloc(npages, sizeof(*src_pfns), GFP_KERNEL);
-	dst_pfns = kcalloc(npages, sizeof(*dst_pfns), GFP_KERNEL);
-	dma_addrs = kcalloc(npages, sizeof(*dma_addrs), GFP_KERNEL);
+	src_pfns = kvcalloc(npages, sizeof(*src_pfns), GFP_KERNEL | __GFP_NOFAIL);
+	dst_pfns = kvcalloc(npages, sizeof(*dst_pfns), GFP_KERNEL | __GFP_NOFAIL);
+	dma_addrs = kvcalloc(npages, sizeof(*dma_addrs), GFP_KERNEL | __GFP_NOFAIL);
 
 	migrate_device_range(src_pfns, chunk->pagemap.range.start >> PAGE_SHIFT,
 			npages);
@@ -406,11 +406,11 @@ nouveau_dmem_evict_chunk(struct nouveau_dmem_chunk *chunk)
 	migrate_device_pages(src_pfns, dst_pfns, npages);
 	nouveau_dmem_fence_done(&fence);
 	migrate_device_finalize(src_pfns, dst_pfns, npages);
-	kfree(src_pfns);
-	kfree(dst_pfns);
+	kvfree(src_pfns);
+	kvfree(dst_pfns);
 	for (i = 0; i < npages; i++)
 		dma_unmap_page(chunk->drm->dev->dev, dma_addrs[i], PAGE_SIZE, DMA_BIDIRECTIONAL);
-	kfree(dma_addrs);
+	kvfree(dma_addrs);
 }
 
 void
diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index a0d303e5ce3d..7b69e6df5748 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -758,7 +758,7 @@ nouveau_gem_ioctl_pushbuf(struct drm_device *dev, void *data,
 		return -ENOMEM;
 
 	if (unlikely(nouveau_cli_uvmm(cli)))
-		return -ENOSYS;
+		return nouveau_abi16_put(abi16, -ENOSYS);
 
 	list_for_each_entry(temp, &abi16->channels, head) {
 		if (temp->chan->chid == req->channel) {
diff --git a/drivers/gpu/drm/nouveau/nvkm/core/client.c b/drivers/gpu/drm/nouveau/nvkm/core/client.c
index ebdeb8eb9e77..c55662937ab2 100644
--- a/drivers/gpu/drm/nouveau/nvkm/core/client.c
+++ b/drivers/gpu/drm/nouveau/nvkm/core/client.c
@@ -180,6 +180,7 @@ nvkm_client_new(const char *name, u64 device, const char *cfg, const char *dbg,
 	client->device = device;
 	client->debug = nvkm_dbgopt(dbg, "CLIENT");
 	client->objroot = RB_ROOT;
+	spin_lock_init(&client->obj_lock);
 	client->event = event;
 	INIT_LIST_HEAD(&client->umem);
 	spin_lock_init(&client->lock);
diff --git a/drivers/gpu/drm/nouveau/nvkm/core/object.c b/drivers/gpu/drm/nouveau/nvkm/core/object.c
index 7c554c14e884..aea3ba72027a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/core/object.c
+++ b/drivers/gpu/drm/nouveau/nvkm/core/object.c
@@ -30,8 +30,10 @@ nvkm_object_search(struct nvkm_client *client, u64 handle,
 		   const struct nvkm_object_func *func)
 {
 	struct nvkm_object *object;
+	unsigned long flags;
 
 	if (handle) {
+		spin_lock_irqsave(&client->obj_lock, flags);
 		struct rb_node *node = client->objroot.rb_node;
 		while (node) {
 			object = rb_entry(node, typeof(*object), node);
@@ -40,9 +42,12 @@ nvkm_object_search(struct nvkm_client *client, u64 handle,
 			else
 			if (handle > object->object)
 				node = node->rb_right;
-			else
+			else {
+				spin_unlock_irqrestore(&client->obj_lock, flags);
 				goto done;
+			}
 		}
+		spin_unlock_irqrestore(&client->obj_lock, flags);
 		return ERR_PTR(-ENOENT);
 	} else {
 		object = &client->object;
@@ -57,30 +62,39 @@ nvkm_object_search(struct nvkm_client *client, u64 handle,
 void
 nvkm_object_remove(struct nvkm_object *object)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&object->client->obj_lock, flags);
 	if (!RB_EMPTY_NODE(&object->node))
 		rb_erase(&object->node, &object->client->objroot);
+	spin_unlock_irqrestore(&object->client->obj_lock, flags);
 }
 
 bool
 nvkm_object_insert(struct nvkm_object *object)
 {
-	struct rb_node **ptr = &object->client->objroot.rb_node;
+	struct rb_node **ptr;
 	struct rb_node *parent = NULL;
+	unsigned long flags;
 
+	spin_lock_irqsave(&object->client->obj_lock, flags);
+	ptr = &object->client->objroot.rb_node;
 	while (*ptr) {
 		struct nvkm_object *this = rb_entry(*ptr, typeof(*this), node);
 		parent = *ptr;
-		if (object->object < this->object)
+		if (object->object < this->object) {
 			ptr = &parent->rb_left;
-		else
-		if (object->object > this->object)
+		} else if (object->object > this->object) {
 			ptr = &parent->rb_right;
-		else
+		} else {
+			spin_unlock_irqrestore(&object->client->obj_lock, flags);
 			return false;
+		}
 	}
 
 	rb_link_node(&object->node, parent, ptr);
 	rb_insert_color(&object->node, &object->client->objroot);
+	spin_unlock_irqrestore(&object->client->obj_lock, flags);
 	return true;
 }
 
diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 0a7a7e4ad8d1..9ee92898216b 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -71,13 +71,19 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 	entity->guilty = guilty;
 	entity->num_sched_list = num_sched_list;
 	entity->priority = priority;
+	/*
+	 * It's perfectly valid to initialize an entity without having a valid
+	 * scheduler attached. It's just not valid to use the scheduler before it
+	 * is initialized itself.
+	 */
 	entity->sched_list = num_sched_list > 1 ? sched_list : NULL;
 	RCU_INIT_POINTER(entity->last_scheduled, NULL);
 	RB_CLEAR_NODE(&entity->rb_tree_node);
 
-	if (!sched_list[0]->sched_rq) {
-		/* Warn drivers not to do this and to fix their DRM
-		 * calling order.
+	if (num_sched_list && !sched_list[0]->sched_rq) {
+		/* Since every entry covered by num_sched_list
+		 * should be non-NULL and therefore we warn drivers
+		 * not to do this and to fix their DRM calling order.
 		 */
 		pr_warn("%s: called with uninitialized scheduler\n", __func__);
 	} else if (num_sched_list) {
diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index fd9fd3d15101..0b3f4267130c 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -294,7 +294,13 @@ pgprot_t ttm_io_prot(struct ttm_buffer_object *bo, struct ttm_resource *res,
 	enum ttm_caching caching;
 
 	man = ttm_manager_type(bo->bdev, res->mem_type);
-	caching = man->use_tt ? bo->ttm->caching : res->bus.caching;
+	if (man->use_tt) {
+		caching = bo->ttm->caching;
+		if (bo->ttm->page_flags & TTM_TT_FLAG_DECRYPTED)
+			tmp = pgprot_decrypted(tmp);
+	} else  {
+		caching = res->bus.caching;
+	}
 
 	return ttm_prot_from_caching(caching, tmp);
 }
@@ -337,6 +343,8 @@ static int ttm_bo_kmap_ttm(struct ttm_buffer_object *bo,
 		.no_wait_gpu = false
 	};
 	struct ttm_tt *ttm = bo->ttm;
+	struct ttm_resource_manager *man =
+			ttm_manager_type(bo->bdev, bo->resource->mem_type);
 	pgprot_t prot;
 	int ret;
 
@@ -346,7 +354,8 @@ static int ttm_bo_kmap_ttm(struct ttm_buffer_object *bo,
 	if (ret)
 		return ret;
 
-	if (num_pages == 1 && ttm->caching == ttm_cached) {
+	if (num_pages == 1 && ttm->caching == ttm_cached &&
+	    !(man->use_tt && (ttm->page_flags & TTM_TT_FLAG_DECRYPTED))) {
 		/*
 		 * We're mapping a single page, and the desired
 		 * page protection is consistent with the bo.
diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
index e0a77671edd6..43eaffa7faae 100644
--- a/drivers/gpu/drm/ttm/ttm_tt.c
+++ b/drivers/gpu/drm/ttm/ttm_tt.c
@@ -31,11 +31,14 @@
 
 #define pr_fmt(fmt) "[TTM] " fmt
 
+#include <linux/cc_platform.h>
 #include <linux/sched.h>
 #include <linux/shmem_fs.h>
 #include <linux/file.h>
 #include <linux/module.h>
 #include <drm/drm_cache.h>
+#include <drm/drm_device.h>
+#include <drm/drm_util.h>
 #include <drm/ttm/ttm_bo.h>
 #include <drm/ttm/ttm_tt.h>
 
@@ -60,6 +63,7 @@ static atomic_long_t ttm_dma32_pages_allocated;
 int ttm_tt_create(struct ttm_buffer_object *bo, bool zero_alloc)
 {
 	struct ttm_device *bdev = bo->bdev;
+	struct drm_device *ddev = bo->base.dev;
 	uint32_t page_flags = 0;
 
 	dma_resv_assert_held(bo->base.resv);
@@ -81,6 +85,15 @@ int ttm_tt_create(struct ttm_buffer_object *bo, bool zero_alloc)
 		pr_err("Illegal buffer object type\n");
 		return -EINVAL;
 	}
+	/*
+	 * When using dma_alloc_coherent with memory encryption the
+	 * mapped TT pages need to be decrypted or otherwise the drivers
+	 * will end up sending encrypted mem to the gpu.
+	 */
+	if (bdev->pool.use_dma_alloc && cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
+		page_flags |= TTM_TT_FLAG_DECRYPTED;
+		drm_info(ddev, "TT memory decryption enabled.");
+	}
 
 	bo->ttm = bdev->funcs->ttm_tt_create(bo, page_flags);
 	if (unlikely(bo->ttm == NULL))
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 25c9c71256d3..4626fe9aac56 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -508,7 +508,7 @@ static int vc4_hdmi_connector_get_modes(struct drm_connector *connector)
 	edid = drm_get_edid(connector, vc4_hdmi->ddc);
 	cec_s_phys_addr_from_edid(vc4_hdmi->cec_adap, edid);
 	if (!edid)
-		return -ENODEV;
+		return 0;
 
 	drm_connector_update_edid_property(connector, edid);
 	ret = drm_add_edid_modes(connector, edid);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index d3e308fdfd5b..c7d90f96d16a 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -1444,12 +1444,15 @@ static void vmw_debugfs_resource_managers_init(struct vmw_private *vmw)
 					    root, "system_ttm");
 	ttm_resource_manager_create_debugfs(ttm_manager_type(&vmw->bdev, TTM_PL_VRAM),
 					    root, "vram_ttm");
-	ttm_resource_manager_create_debugfs(ttm_manager_type(&vmw->bdev, VMW_PL_GMR),
-					    root, "gmr_ttm");
-	ttm_resource_manager_create_debugfs(ttm_manager_type(&vmw->bdev, VMW_PL_MOB),
-					    root, "mob_ttm");
-	ttm_resource_manager_create_debugfs(ttm_manager_type(&vmw->bdev, VMW_PL_SYSTEM),
-					    root, "system_mob_ttm");
+	if (vmw->has_gmr)
+		ttm_resource_manager_create_debugfs(ttm_manager_type(&vmw->bdev, VMW_PL_GMR),
+						    root, "gmr_ttm");
+	if (vmw->has_mob) {
+		ttm_resource_manager_create_debugfs(ttm_manager_type(&vmw->bdev, VMW_PL_MOB),
+						    root, "mob_ttm");
+		ttm_resource_manager_create_debugfs(ttm_manager_type(&vmw->bdev, VMW_PL_SYSTEM),
+						    root, "system_mob_ttm");
+	}
 }
 
 static int vmwgfx_pm_notifier(struct notifier_block *nb, unsigned long val,
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index 36987ef3fc30..5fef0b31c117 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -447,7 +447,7 @@ static int vmw_resource_context_res_add(struct vmw_private *dev_priv,
 	    vmw_res_type(ctx) == vmw_res_dx_context) {
 		for (i = 0; i < cotable_max; ++i) {
 			res = vmw_context_cotable(ctx, i);
-			if (IS_ERR(res))
+			if (IS_ERR_OR_NULL(res))
 				continue;
 
 			ret = vmw_execbuf_res_val_add(sw_context, res,
@@ -1266,6 +1266,8 @@ static int vmw_cmd_dx_define_query(struct vmw_private *dev_priv,
 		return -EINVAL;
 
 	cotable_res = vmw_context_cotable(ctx_node->ctx, SVGA_COTABLE_DXQUERY);
+	if (IS_ERR_OR_NULL(cotable_res))
+		return cotable_res ? PTR_ERR(cotable_res) : -EINVAL;
 	ret = vmw_cotable_notify(cotable_res, cmd->body.queryId);
 
 	return ret;
@@ -2484,6 +2486,8 @@ static int vmw_cmd_dx_view_define(struct vmw_private *dev_priv,
 		return ret;
 
 	res = vmw_context_cotable(ctx_node->ctx, vmw_view_cotables[view_type]);
+	if (IS_ERR_OR_NULL(res))
+		return res ? PTR_ERR(res) : -EINVAL;
 	ret = vmw_cotable_notify(res, cmd->defined_id);
 	if (unlikely(ret != 0))
 		return ret;
@@ -2569,8 +2573,8 @@ static int vmw_cmd_dx_so_define(struct vmw_private *dev_priv,
 
 	so_type = vmw_so_cmd_to_type(header->id);
 	res = vmw_context_cotable(ctx_node->ctx, vmw_so_cotables[so_type]);
-	if (IS_ERR(res))
-		return PTR_ERR(res);
+	if (IS_ERR_OR_NULL(res))
+		return res ? PTR_ERR(res) : -EINVAL;
 	cmd = container_of(header, typeof(*cmd), header);
 	ret = vmw_cotable_notify(res, cmd->defined_id);
 
@@ -2689,6 +2693,8 @@ static int vmw_cmd_dx_define_shader(struct vmw_private *dev_priv,
 		return -EINVAL;
 
 	res = vmw_context_cotable(ctx_node->ctx, SVGA_COTABLE_DXSHADER);
+	if (IS_ERR_OR_NULL(res))
+		return res ? PTR_ERR(res) : -EINVAL;
 	ret = vmw_cotable_notify(res, cmd->body.shaderId);
 	if (ret)
 		return ret;
@@ -3010,6 +3016,8 @@ static int vmw_cmd_dx_define_streamoutput(struct vmw_private *dev_priv,
 	}
 
 	res = vmw_context_cotable(ctx_node->ctx, SVGA_COTABLE_STREAMOUTPUT);
+	if (IS_ERR_OR_NULL(res))
+		return res ? PTR_ERR(res) : -EINVAL;
 	ret = vmw_cotable_notify(res, cmd->body.soid);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index b51578918cf8..5681a1b42aa2 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -184,13 +184,12 @@ static u32 vmw_du_cursor_mob_size(u32 w, u32 h)
  */
 static u32 *vmw_du_cursor_plane_acquire_image(struct vmw_plane_state *vps)
 {
-	bool is_iomem;
 	if (vps->surf) {
 		if (vps->surf_mapped)
 			return vmw_bo_map_and_cache(vps->surf->res.guest_memory_bo);
 		return vps->surf->snooper.image;
 	} else if (vps->bo)
-		return ttm_kmap_obj_virtual(&vps->bo->map, &is_iomem);
+		return vmw_bo_map_and_cache(vps->bo);
 	return NULL;
 }
 
@@ -652,22 +651,12 @@ vmw_du_cursor_plane_cleanup_fb(struct drm_plane *plane,
 {
 	struct vmw_cursor_plane *vcp = vmw_plane_to_vcp(plane);
 	struct vmw_plane_state *vps = vmw_plane_state_to_vps(old_state);
-	bool is_iomem;
 
 	if (vps->surf_mapped) {
 		vmw_bo_unmap(vps->surf->res.guest_memory_bo);
 		vps->surf_mapped = false;
 	}
 
-	if (vps->bo && ttm_kmap_obj_virtual(&vps->bo->map, &is_iomem)) {
-		const int ret = ttm_bo_reserve(&vps->bo->tbo, true, false, NULL);
-
-		if (likely(ret == 0)) {
-			ttm_bo_kunmap(&vps->bo->map);
-			ttm_bo_unreserve(&vps->bo->tbo);
-		}
-	}
-
 	vmw_du_cursor_plane_unmap_cm(vps);
 	vmw_du_put_cursor_mob(vcp, vps);
 
@@ -703,6 +692,10 @@ vmw_du_cursor_plane_prepare_fb(struct drm_plane *plane,
 	int ret = 0;
 
 	if (vps->surf) {
+		if (vps->surf_mapped) {
+			vmw_bo_unmap(vps->surf->res.guest_memory_bo);
+			vps->surf_mapped = false;
+		}
 		vmw_surface_unreference(&vps->surf);
 		vps->surf = NULL;
 	}
diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index 2a7a4b6b0094..9b02b304c2f5 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -934,10 +934,21 @@ static const struct i2c_device_id amc6821_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, amc6821_id);
 
+static const struct of_device_id __maybe_unused amc6821_of_match[] = {
+	{
+		.compatible = "ti,amc6821",
+		.data = (void *)amc6821,
+	},
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, amc6821_of_match);
+
 static struct i2c_driver amc6821_driver = {
 	.class = I2C_CLASS_HWMON,
 	.driver = {
 		.name	= "amc6821",
+		.of_match_table = of_match_ptr(amc6821_of_match),
 	},
 	.probe = amc6821_probe,
 	.id_table = amc6821_id,
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 6a5a93cf4ecc..643a816883ad 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1414,7 +1414,6 @@ static void i801_add_mux(struct i801_priv *priv)
 		lookup->table[i] = GPIO_LOOKUP(mux_config->gpio_chip,
 					       mux_config->gpios[i], "mux", 0);
 	gpiod_add_lookup_table(lookup);
-	priv->lookup = lookup;
 
 	/*
 	 * Register the mux device, we use PLATFORM_DEVID_NONE here
@@ -1428,7 +1427,10 @@ static void i801_add_mux(struct i801_priv *priv)
 				sizeof(struct i2c_mux_gpio_platform_data));
 	if (IS_ERR(priv->mux_pdev)) {
 		gpiod_remove_lookup_table(lookup);
+		devm_kfree(dev, lookup);
 		dev_err(dev, "Failed to register i2c-mux-gpio device\n");
+	} else {
+		priv->lookup = lookup;
 	}
 }
 
@@ -1740,9 +1742,9 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	i801_enable_host_notify(&priv->adapter);
 
-	i801_probe_optional_slaves(priv);
 	/* We ignore errors - multiplexing is optional */
 	i801_add_mux(priv);
+	i801_probe_optional_slaves(priv);
 
 	pci_set_drvdata(dev, priv);
 
diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index 90b7ae6d42b7..484fe2e9fb17 100644
--- a/drivers/iio/accel/adxl367.c
+++ b/drivers/iio/accel/adxl367.c
@@ -1429,9 +1429,11 @@ static int adxl367_verify_devid(struct adxl367_state *st)
 	unsigned int val;
 	int ret;
 
-	ret = regmap_read_poll_timeout(st->regmap, ADXL367_REG_DEVID, val,
-				       val == ADXL367_DEVID_AD, 1000, 10000);
+	ret = regmap_read(st->regmap, ADXL367_REG_DEVID, &val);
 	if (ret)
+		return dev_err_probe(st->dev, ret, "Failed to read dev id\n");
+
+	if (val != ADXL367_DEVID_AD)
 		return dev_err_probe(st->dev, -ENODEV,
 				     "Invalid dev id 0x%02X, expected 0x%02X\n",
 				     val, ADXL367_DEVID_AD);
@@ -1510,6 +1512,8 @@ int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
 	if (ret)
 		return ret;
 
+	fsleep(15000);
+
 	ret = adxl367_verify_devid(st);
 	if (ret)
 		return ret;
diff --git a/drivers/iio/accel/adxl367_i2c.c b/drivers/iio/accel/adxl367_i2c.c
index b595fe94f3a3..62c74bdc0d77 100644
--- a/drivers/iio/accel/adxl367_i2c.c
+++ b/drivers/iio/accel/adxl367_i2c.c
@@ -11,7 +11,7 @@
 
 #include "adxl367.h"
 
-#define ADXL367_I2C_FIFO_DATA	0x42
+#define ADXL367_I2C_FIFO_DATA	0x18
 
 struct adxl367_i2c_state {
 	struct regmap *regmap;
diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index dd94667a623b..1c0042fbbb54 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -52,7 +52,7 @@
 #define SARADC2_START			BIT(4)
 #define SARADC2_SINGLE_MODE		BIT(5)
 
-#define SARADC2_CONV_CHANNELS GENMASK(15, 0)
+#define SARADC2_CONV_CHANNELS GENMASK(3, 0)
 
 struct rockchip_saradc;
 
@@ -102,12 +102,12 @@ static void rockchip_saradc_start_v2(struct rockchip_saradc *info, int chn)
 	writel_relaxed(0xc, info->regs + SARADC_T_DAS_SOC);
 	writel_relaxed(0x20, info->regs + SARADC_T_PD_SOC);
 	val = FIELD_PREP(SARADC2_EN_END_INT, 1);
-	val |= val << 16;
+	val |= SARADC2_EN_END_INT << 16;
 	writel_relaxed(val, info->regs + SARADC2_END_INT_EN);
 	val = FIELD_PREP(SARADC2_START, 1) |
 	      FIELD_PREP(SARADC2_SINGLE_MODE, 1) |
 	      FIELD_PREP(SARADC2_CONV_CHANNELS, chn);
-	val |= val << 16;
+	val |= (SARADC2_START | SARADC2_SINGLE_MODE | SARADC2_CONV_CHANNELS) << 16;
 	writel(val, info->regs + SARADC2_CONV_CON);
 }
 
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 66d4ba088e70..d4f9b5d8d28d 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -109,6 +109,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	/* compute and process only all complete datum */
 	nb = fifo_count / bytes_per_datum;
 	fifo_count = nb * bytes_per_datum;
+	if (nb == 0)
+		goto end_session;
 	/* Each FIFO data contains all sensors, so same number for FIFO and sensor data */
 	fifo_period = NSEC_PER_SEC / INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);
 	inv_sensors_timestamp_interrupt(&st->timestamp, fifo_period, nb, nb, pf->timestamp);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index 676704f9151f..e6e6e94452a3 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -111,6 +111,7 @@ int inv_mpu6050_prepare_fifo(struct inv_mpu6050_state *st, bool enable)
 	if (enable) {
 		/* reset timestamping */
 		inv_sensors_timestamp_reset(&st->timestamp);
+		inv_sensors_timestamp_apply_odr(&st->timestamp, 0, 0, 0);
 		/* reset FIFO */
 		d = st->chip_config.user_ctrl | INV_MPU6050_BIT_FIFO_RST;
 		ret = regmap_write(st->map, st->reg->user_ctrl, d);
@@ -184,6 +185,10 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
 		if (result)
 			goto error_power_off;
 	} else {
+		st->chip_config.gyro_fifo_enable = 0;
+		st->chip_config.accl_fifo_enable = 0;
+		st->chip_config.temp_fifo_enable = 0;
+		st->chip_config.magn_fifo_enable = 0;
 		result = inv_mpu6050_prepare_fifo(st, false);
 		if (result)
 			goto error_power_off;
diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 6e19974ecf6e..253fea374a72 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -2498,7 +2498,7 @@ static void dispatch_event_fd(struct list_head *fd_list,
 
 	list_for_each_entry_rcu(item, fd_list, xa_list) {
 		if (item->eventfd)
-			eventfd_signal(item->eventfd, 1);
+			eventfd_signal(item->eventfd);
 		else
 			deliver_event(item, data);
 	}
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index d0bb3edfd0a0..c11af4441cf2 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -130,7 +130,12 @@ static const struct xpad_device {
 	{ 0x0079, 0x18d4, "GPD Win 2 X-Box Controller", 0, XTYPE_XBOX360 },
 	{ 0x03eb, 0xff01, "Wooting One (Legacy)", 0, XTYPE_XBOX360 },
 	{ 0x03eb, 0xff02, "Wooting Two (Legacy)", 0, XTYPE_XBOX360 },
+	{ 0x03f0, 0x038D, "HyperX Clutch", 0, XTYPE_XBOX360 },			/* wired */
+	{ 0x03f0, 0x048D, "HyperX Clutch", 0, XTYPE_XBOX360 },			/* wireless */
 	{ 0x03f0, 0x0495, "HyperX Clutch Gladiate", 0, XTYPE_XBOXONE },
+	{ 0x03f0, 0x07A0, "HyperX Clutch Gladiate RGB", 0, XTYPE_XBOXONE },
+	{ 0x03f0, 0x08B6, "HyperX Clutch Gladiate", 0, XTYPE_XBOXONE },		/* v2 */
+	{ 0x03f0, 0x09B4, "HyperX Clutch Tanto", 0, XTYPE_XBOXONE },
 	{ 0x044f, 0x0f00, "Thrustmaster Wheel", 0, XTYPE_XBOX },
 	{ 0x044f, 0x0f03, "Thrustmaster Wheel", 0, XTYPE_XBOX },
 	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", 0, XTYPE_XBOX },
@@ -463,6 +468,7 @@ static const struct usb_device_id xpad_table[] = {
 	{ USB_INTERFACE_INFO('X', 'B', 0) },	/* Xbox USB-IF not-approved class */
 	XPAD_XBOX360_VENDOR(0x0079),		/* GPD Win 2 controller */
 	XPAD_XBOX360_VENDOR(0x03eb),		/* Wooting Keyboards (Legacy) */
+	XPAD_XBOX360_VENDOR(0x03f0),		/* HP HyperX Xbox 360 controllers */
 	XPAD_XBOXONE_VENDOR(0x03f0),		/* HP HyperX Xbox One controllers */
 	XPAD_XBOX360_VENDOR(0x044f),		/* Thrustmaster Xbox 360 controllers */
 	XPAD_XBOX360_VENDOR(0x045e),		/* Microsoft Xbox 360 controllers */
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 037fcf826407..a0767ce1bd13 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1706,6 +1706,14 @@ static size_t iommu_dma_opt_mapping_size(void)
 	return iova_rcache_range();
 }
 
+static size_t iommu_dma_max_mapping_size(struct device *dev)
+{
+	if (dev_is_untrusted(dev))
+		return swiotlb_max_mapping_size(dev);
+
+	return SIZE_MAX;
+}
+
 static const struct dma_map_ops iommu_dma_ops = {
 	.flags			= DMA_F_PCI_P2PDMA_SUPPORTED,
 	.alloc			= iommu_dma_alloc,
@@ -1728,6 +1736,7 @@ static const struct dma_map_ops iommu_dma_ops = {
 	.unmap_resource		= iommu_dma_unmap_resource,
 	.get_merge_boundary	= iommu_dma_get_merge_boundary,
 	.opt_mapping_size	= iommu_dma_opt_mapping_size,
+	.max_mapping_size       = iommu_dma_max_mapping_size,
 };
 
 /*
diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index fe8d516f3614..dc822111fc5d 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -28,8 +28,7 @@
 #define ISCR				0x10
 #define IITSR				0x14
 #define TSCR				0x20
-#define TITSR0				0x24
-#define TITSR1				0x28
+#define TITSR(n)			(0x24 + (n) * 4)
 #define TITSR0_MAX_INT			16
 #define TITSEL_WIDTH			0x2
 #define TSSR(n)				(0x30 + ((n) * 4))
@@ -67,28 +66,43 @@ static struct rzg2l_irqc_priv *irq_data_to_priv(struct irq_data *data)
 	return data->domain->host_data;
 }
 
-static void rzg2l_irq_eoi(struct irq_data *d)
+static void rzg2l_clear_irq_int(struct rzg2l_irqc_priv *priv, unsigned int hwirq)
 {
-	unsigned int hw_irq = irqd_to_hwirq(d) - IRQC_IRQ_START;
-	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
+	unsigned int hw_irq = hwirq - IRQC_IRQ_START;
 	u32 bit = BIT(hw_irq);
-	u32 reg;
+	u32 iitsr, iscr;
 
-	reg = readl_relaxed(priv->base + ISCR);
-	if (reg & bit)
-		writel_relaxed(reg & ~bit, priv->base + ISCR);
+	iscr = readl_relaxed(priv->base + ISCR);
+	iitsr = readl_relaxed(priv->base + IITSR);
+
+	/*
+	 * ISCR can only be cleared if the type is falling-edge, rising-edge or
+	 * falling/rising-edge.
+	 */
+	if ((iscr & bit) && (iitsr & IITSR_IITSEL_MASK(hw_irq))) {
+		writel_relaxed(iscr & ~bit, priv->base + ISCR);
+		/*
+		 * Enforce that the posted write is flushed to prevent that the
+		 * just handled interrupt is raised again.
+		 */
+		readl_relaxed(priv->base + ISCR);
+	}
 }
 
-static void rzg2l_tint_eoi(struct irq_data *d)
+static void rzg2l_clear_tint_int(struct rzg2l_irqc_priv *priv, unsigned int hwirq)
 {
-	unsigned int hw_irq = irqd_to_hwirq(d) - IRQC_TINT_START;
-	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
-	u32 bit = BIT(hw_irq);
+	u32 bit = BIT(hwirq - IRQC_TINT_START);
 	u32 reg;
 
 	reg = readl_relaxed(priv->base + TSCR);
-	if (reg & bit)
+	if (reg & bit) {
 		writel_relaxed(reg & ~bit, priv->base + TSCR);
+		/*
+		 * Enforce that the posted write is flushed to prevent that the
+		 * just handled interrupt is raised again.
+		 */
+		readl_relaxed(priv->base + TSCR);
+	}
 }
 
 static void rzg2l_irqc_eoi(struct irq_data *d)
@@ -98,9 +112,9 @@ static void rzg2l_irqc_eoi(struct irq_data *d)
 
 	raw_spin_lock(&priv->lock);
 	if (hw_irq >= IRQC_IRQ_START && hw_irq <= IRQC_IRQ_COUNT)
-		rzg2l_irq_eoi(d);
+		rzg2l_clear_irq_int(priv, hw_irq);
 	else if (hw_irq >= IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ)
-		rzg2l_tint_eoi(d);
+		rzg2l_clear_tint_int(priv, hw_irq);
 	raw_spin_unlock(&priv->lock);
 	irq_chip_eoi_parent(d);
 }
@@ -148,8 +162,10 @@ static void rzg2l_irqc_irq_enable(struct irq_data *d)
 
 static int rzg2l_irq_set_type(struct irq_data *d, unsigned int type)
 {
-	unsigned int hw_irq = irqd_to_hwirq(d) - IRQC_IRQ_START;
 	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
+	unsigned int hwirq = irqd_to_hwirq(d);
+	u32 iitseln = hwirq - IRQC_IRQ_START;
+	bool clear_irq_int = false;
 	u16 sense, tmp;
 
 	switch (type & IRQ_TYPE_SENSE_MASK) {
@@ -159,14 +175,17 @@ static int rzg2l_irq_set_type(struct irq_data *d, unsigned int type)
 
 	case IRQ_TYPE_EDGE_FALLING:
 		sense = IITSR_IITSEL_EDGE_FALLING;
+		clear_irq_int = true;
 		break;
 
 	case IRQ_TYPE_EDGE_RISING:
 		sense = IITSR_IITSEL_EDGE_RISING;
+		clear_irq_int = true;
 		break;
 
 	case IRQ_TYPE_EDGE_BOTH:
 		sense = IITSR_IITSEL_EDGE_BOTH;
+		clear_irq_int = true;
 		break;
 
 	default:
@@ -175,22 +194,40 @@ static int rzg2l_irq_set_type(struct irq_data *d, unsigned int type)
 
 	raw_spin_lock(&priv->lock);
 	tmp = readl_relaxed(priv->base + IITSR);
-	tmp &= ~IITSR_IITSEL_MASK(hw_irq);
-	tmp |= IITSR_IITSEL(hw_irq, sense);
+	tmp &= ~IITSR_IITSEL_MASK(iitseln);
+	tmp |= IITSR_IITSEL(iitseln, sense);
+	if (clear_irq_int)
+		rzg2l_clear_irq_int(priv, hwirq);
 	writel_relaxed(tmp, priv->base + IITSR);
 	raw_spin_unlock(&priv->lock);
 
 	return 0;
 }
 
+static u32 rzg2l_disable_tint_and_set_tint_source(struct irq_data *d, struct rzg2l_irqc_priv *priv,
+						  u32 reg, u32 tssr_offset, u8 tssr_index)
+{
+	u32 tint = (u32)(uintptr_t)irq_data_get_irq_chip_data(d);
+	u32 tien = reg & (TIEN << TSSEL_SHIFT(tssr_offset));
+
+	/* Clear the relevant byte in reg */
+	reg &= ~(TSSEL_MASK << TSSEL_SHIFT(tssr_offset));
+	/* Set TINT and leave TIEN clear */
+	reg |= tint << TSSEL_SHIFT(tssr_offset);
+	writel_relaxed(reg, priv->base + TSSR(tssr_index));
+
+	return reg | tien;
+}
+
 static int rzg2l_tint_set_edge(struct irq_data *d, unsigned int type)
 {
 	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
 	unsigned int hwirq = irqd_to_hwirq(d);
 	u32 titseln = hwirq - IRQC_TINT_START;
-	u32 offset;
-	u8 sense;
-	u32 reg;
+	u32 tssr_offset = TSSR_OFFSET(titseln);
+	u8 tssr_index = TSSR_INDEX(titseln);
+	u8 index, sense;
+	u32 reg, tssr;
 
 	switch (type & IRQ_TYPE_SENSE_MASK) {
 	case IRQ_TYPE_EDGE_RISING:
@@ -205,17 +242,21 @@ static int rzg2l_tint_set_edge(struct irq_data *d, unsigned int type)
 		return -EINVAL;
 	}
 
-	offset = TITSR0;
+	index = 0;
 	if (titseln >= TITSR0_MAX_INT) {
 		titseln -= TITSR0_MAX_INT;
-		offset = TITSR1;
+		index = 1;
 	}
 
 	raw_spin_lock(&priv->lock);
-	reg = readl_relaxed(priv->base + offset);
+	tssr = readl_relaxed(priv->base + TSSR(tssr_index));
+	tssr = rzg2l_disable_tint_and_set_tint_source(d, priv, tssr, tssr_offset, tssr_index);
+	reg = readl_relaxed(priv->base + TITSR(index));
 	reg &= ~(IRQ_MASK << (titseln * TITSEL_WIDTH));
 	reg |= sense << (titseln * TITSEL_WIDTH);
-	writel_relaxed(reg, priv->base + offset);
+	writel_relaxed(reg, priv->base + TITSR(index));
+	rzg2l_clear_tint_int(priv, hwirq);
+	writel_relaxed(tssr, priv->base + TSSR(tssr_index));
 	raw_spin_unlock(&priv->lock);
 
 	return 0;
diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index d76214fa9ad8..79719fc8a08f 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -462,12 +462,12 @@ static int netdev_trig_notify(struct notifier_block *nb,
 	trigger_data->duplex = DUPLEX_UNKNOWN;
 	switch (evt) {
 	case NETDEV_CHANGENAME:
-		get_device_state(trigger_data);
-		fallthrough;
 	case NETDEV_REGISTER:
 		dev_put(trigger_data->net_dev);
 		dev_hold(dev);
 		trigger_data->net_dev = dev;
+		if (evt == NETDEV_CHANGENAME)
+			get_device_state(trigger_data);
 		break;
 	case NETDEV_UNREGISTER:
 		dev_put(trigger_data->net_dev);
diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 13eb47b997f9..d97355e9b9a6 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -213,6 +213,7 @@ struct raid_dev {
 #define RT_FLAG_RS_IN_SYNC		6
 #define RT_FLAG_RS_RESYNCING		7
 #define RT_FLAG_RS_GROW			8
+#define RT_FLAG_RS_FROZEN		9
 
 /* Array elements of 64 bit needed for rebuild/failed disk bits */
 #define DISKS_ARRAY_ELEMS ((MAX_RAID_DEVICES + (sizeof(uint64_t) * 8 - 1)) / sizeof(uint64_t) / 8)
@@ -3240,11 +3241,12 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	rs->md.ro = 1;
 	rs->md.in_sync = 1;
 
-	/* Keep array frozen until resume. */
-	set_bit(MD_RECOVERY_FROZEN, &rs->md.recovery);
-
 	/* Has to be held on running the array */
 	mddev_suspend_and_lock_nointr(&rs->md);
+
+	/* Keep array frozen until resume. */
+	md_frozen_sync_thread(&rs->md);
+
 	r = md_run(&rs->md);
 	rs->md.in_sync = 0; /* Assume already marked dirty */
 	if (r) {
@@ -3339,7 +3341,8 @@ static int raid_map(struct dm_target *ti, struct bio *bio)
 	if (unlikely(bio_has_data(bio) && bio_end_sector(bio) > mddev->array_sectors))
 		return DM_MAPIO_REQUEUE;
 
-	md_handle_request(mddev, bio);
+	if (unlikely(!md_handle_request(mddev, bio)))
+		return DM_MAPIO_REQUEUE;
 
 	return DM_MAPIO_SUBMITTED;
 }
@@ -3718,21 +3721,33 @@ static int raid_message(struct dm_target *ti, unsigned int argc, char **argv,
 {
 	struct raid_set *rs = ti->private;
 	struct mddev *mddev = &rs->md;
+	int ret = 0;
 
 	if (!mddev->pers || !mddev->pers->sync_request)
 		return -EINVAL;
 
-	if (!strcasecmp(argv[0], "frozen"))
-		set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-	else
-		clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+	if (test_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags) ||
+	    test_bit(RT_FLAG_RS_FROZEN, &rs->runtime_flags))
+		return -EBUSY;
 
-	if (!strcasecmp(argv[0], "idle") || !strcasecmp(argv[0], "frozen")) {
-		if (mddev->sync_thread) {
-			set_bit(MD_RECOVERY_INTR, &mddev->recovery);
-			md_reap_sync_thread(mddev);
-		}
-	} else if (decipher_sync_action(mddev, mddev->recovery) != st_idle)
+	if (!strcasecmp(argv[0], "frozen")) {
+		ret = mddev_lock(mddev);
+		if (ret)
+			return ret;
+
+		md_frozen_sync_thread(mddev);
+		mddev_unlock(mddev);
+	} else if (!strcasecmp(argv[0], "idle")) {
+		ret = mddev_lock(mddev);
+		if (ret)
+			return ret;
+
+		md_idle_sync_thread(mddev);
+		mddev_unlock(mddev);
+	}
+
+	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+	if (decipher_sync_action(mddev, mddev->recovery) != st_idle)
 		return -EBUSY;
 	else if (!strcasecmp(argv[0], "resync"))
 		; /* MD_RECOVERY_NEEDED set below */
@@ -3791,15 +3806,46 @@ static void raid_io_hints(struct dm_target *ti, struct queue_limits *limits)
 	blk_limits_io_opt(limits, chunk_size_bytes * mddev_data_stripes(rs));
 }
 
+static void raid_presuspend(struct dm_target *ti)
+{
+	struct raid_set *rs = ti->private;
+	struct mddev *mddev = &rs->md;
+
+	/*
+	 * From now on, disallow raid_message() to change sync_thread until
+	 * resume, raid_postsuspend() is too late.
+	 */
+	set_bit(RT_FLAG_RS_FROZEN, &rs->runtime_flags);
+
+	if (!reshape_interrupted(mddev))
+		return;
+
+	/*
+	 * For raid456, if reshape is interrupted, IO across reshape position
+	 * will never make progress, while caller will wait for IO to be done.
+	 * Inform raid456 to handle those IO to prevent deadlock.
+	 */
+	if (mddev->pers && mddev->pers->prepare_suspend)
+		mddev->pers->prepare_suspend(mddev);
+}
+
+static void raid_presuspend_undo(struct dm_target *ti)
+{
+	struct raid_set *rs = ti->private;
+
+	clear_bit(RT_FLAG_RS_FROZEN, &rs->runtime_flags);
+}
+
 static void raid_postsuspend(struct dm_target *ti)
 {
 	struct raid_set *rs = ti->private;
 
 	if (!test_and_set_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags)) {
-		/* Writes have to be stopped before suspending to avoid deadlocks. */
-		if (!test_bit(MD_RECOVERY_FROZEN, &rs->md.recovery))
-			md_stop_writes(&rs->md);
-
+		/*
+		 * sync_thread must be stopped during suspend, and writes have
+		 * to be stopped before suspending to avoid deadlocks.
+		 */
+		md_stop_writes(&rs->md);
 		mddev_suspend(&rs->md, false);
 	}
 }
@@ -4012,8 +4058,6 @@ static int raid_preresume(struct dm_target *ti)
 	}
 
 	/* Check for any resize/reshape on @rs and adjust/initiate */
-	/* Be prepared for mddev_resume() in raid_resume() */
-	set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 	if (mddev->recovery_cp && mddev->recovery_cp < MaxSector) {
 		set_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
 		mddev->resync_min = mddev->recovery_cp;
@@ -4047,7 +4091,9 @@ static void raid_resume(struct dm_target *ti)
 		 * Take this opportunity to check whether any failed
 		 * devices are reachable again.
 		 */
+		mddev_lock_nointr(mddev);
 		attempt_restore_of_faulty_devices(rs);
+		mddev_unlock(mddev);
 	}
 
 	if (test_and_clear_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags)) {
@@ -4055,10 +4101,13 @@ static void raid_resume(struct dm_target *ti)
 		if (mddev->delta_disks < 0)
 			rs_set_capacity(rs);
 
+		WARN_ON_ONCE(!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery));
+		WARN_ON_ONCE(test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
+		clear_bit(RT_FLAG_RS_FROZEN, &rs->runtime_flags);
 		mddev_lock_nointr(mddev);
-		clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 		mddev->ro = 0;
 		mddev->in_sync = 0;
+		md_unfrozen_sync_thread(mddev);
 		mddev_unlock_and_resume(mddev);
 	}
 }
@@ -4074,6 +4123,8 @@ static struct target_type raid_target = {
 	.message = raid_message,
 	.iterate_devices = raid_iterate_devices,
 	.io_hints = raid_io_hints,
+	.presuspend = raid_presuspend,
+	.presuspend_undo = raid_presuspend_undo,
 	.postsuspend = raid_postsuspend,
 	.preresume = raid_preresume,
 	.resume = raid_resume,
diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index bf7a574499a3..0ace06d1bee3 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -684,8 +684,10 @@ static void dm_exception_table_exit(struct dm_exception_table *et,
 	for (i = 0; i < size; i++) {
 		slot = et->table + i;
 
-		hlist_bl_for_each_entry_safe(ex, pos, n, slot, hash_list)
+		hlist_bl_for_each_entry_safe(ex, pos, n, slot, hash_list) {
 			kmem_cache_free(mem, ex);
+			cond_resched();
+		}
 	}
 
 	kvfree(et->table);
diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 9672f75c3050..a4976ceae868 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -234,7 +234,8 @@ static int __write_sb_page(struct md_rdev *rdev, struct bitmap *bitmap,
 	sector_t doff;
 
 	bdev = (rdev->meta_bdev) ? rdev->meta_bdev : rdev->bdev;
-	if (pg_index == store->file_pages - 1) {
+	/* we compare length (page numbers), not page offset. */
+	if ((pg_index - store->sb_index) == store->file_pages - 1) {
 		unsigned int last_page_size = store->bytes & (PAGE_SIZE - 1);
 
 		if (last_page_size == 0)
@@ -438,8 +439,8 @@ static void filemap_write_page(struct bitmap *bitmap, unsigned long pg_index,
 	struct page *page = store->filemap[pg_index];
 
 	if (mddev_is_clustered(bitmap->mddev)) {
-		pg_index += bitmap->cluster_slot *
-			DIV_ROUND_UP(store->bytes, PAGE_SIZE);
+		/* go to node bitmap area starting point */
+		pg_index += store->sb_index;
 	}
 
 	if (store->file)
@@ -952,6 +953,7 @@ static void md_bitmap_file_set_bit(struct bitmap *bitmap, sector_t block)
 	unsigned long index = file_page_index(store, chunk);
 	unsigned long node_offset = 0;
 
+	index += store->sb_index;
 	if (mddev_is_clustered(bitmap->mddev))
 		node_offset = bitmap->cluster_slot * store->file_pages;
 
@@ -982,6 +984,7 @@ static void md_bitmap_file_clear_bit(struct bitmap *bitmap, sector_t block)
 	unsigned long index = file_page_index(store, chunk);
 	unsigned long node_offset = 0;
 
+	index += store->sb_index;
 	if (mddev_is_clustered(bitmap->mddev))
 		node_offset = bitmap->cluster_slot * store->file_pages;
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 99b60d37114c..67befb598cdd 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -99,18 +99,6 @@ static void mddev_detach(struct mddev *mddev);
 static void export_rdev(struct md_rdev *rdev, struct mddev *mddev);
 static void md_wakeup_thread_directly(struct md_thread __rcu *thread);
 
-enum md_ro_state {
-	MD_RDWR,
-	MD_RDONLY,
-	MD_AUTO_READ,
-	MD_MAX_STATE
-};
-
-static bool md_is_rdwr(struct mddev *mddev)
-{
-	return (mddev->ro == MD_RDWR);
-}
-
 /*
  * Default number of read corrections we'll attempt on an rdev
  * before ejecting it from the array. We divide the read error
@@ -378,7 +366,7 @@ static bool is_suspended(struct mddev *mddev, struct bio *bio)
 	return true;
 }
 
-void md_handle_request(struct mddev *mddev, struct bio *bio)
+bool md_handle_request(struct mddev *mddev, struct bio *bio)
 {
 check_suspended:
 	if (is_suspended(mddev, bio)) {
@@ -386,7 +374,7 @@ void md_handle_request(struct mddev *mddev, struct bio *bio)
 		/* Bail out if REQ_NOWAIT is set for the bio */
 		if (bio->bi_opf & REQ_NOWAIT) {
 			bio_wouldblock_error(bio);
-			return;
+			return true;
 		}
 		for (;;) {
 			prepare_to_wait(&mddev->sb_wait, &__wait,
@@ -402,10 +390,13 @@ void md_handle_request(struct mddev *mddev, struct bio *bio)
 
 	if (!mddev->pers->make_request(mddev, bio)) {
 		percpu_ref_put(&mddev->active_io);
+		if (!mddev->gendisk && mddev->pers->prepare_suspend)
+			return false;
 		goto check_suspended;
 	}
 
 	percpu_ref_put(&mddev->active_io);
+	return true;
 }
 EXPORT_SYMBOL(md_handle_request);
 
@@ -4945,6 +4936,35 @@ static void stop_sync_thread(struct mddev *mddev, bool locked, bool check_seq)
 		mddev_lock_nointr(mddev);
 }
 
+void md_idle_sync_thread(struct mddev *mddev)
+{
+	lockdep_assert_held(&mddev->reconfig_mutex);
+
+	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+	stop_sync_thread(mddev, true, true);
+}
+EXPORT_SYMBOL_GPL(md_idle_sync_thread);
+
+void md_frozen_sync_thread(struct mddev *mddev)
+{
+	lockdep_assert_held(&mddev->reconfig_mutex);
+
+	set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+	stop_sync_thread(mddev, true, false);
+}
+EXPORT_SYMBOL_GPL(md_frozen_sync_thread);
+
+void md_unfrozen_sync_thread(struct mddev *mddev)
+{
+	lockdep_assert_held(&mddev->reconfig_mutex);
+
+	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
+	md_wakeup_thread(mddev->thread);
+	sysfs_notify_dirent_safe(mddev->sysfs_action);
+}
+EXPORT_SYMBOL_GPL(md_unfrozen_sync_thread);
+
 static void idle_sync_thread(struct mddev *mddev)
 {
 	mutex_lock(&mddev->sync_mutex);
@@ -6064,7 +6084,10 @@ int md_run(struct mddev *mddev)
 			pr_warn("True protection against single-disk failure might be compromised.\n");
 	}
 
-	mddev->recovery = 0;
+	/* dm-raid expect sync_thread to be frozen until resume */
+	if (mddev->gendisk)
+		mddev->recovery = 0;
+
 	/* may be over-ridden by personality */
 	mddev->resync_max_sectors = mddev->dev_sectors;
 
@@ -6349,7 +6372,6 @@ static void md_clean(struct mddev *mddev)
 
 static void __md_stop_writes(struct mddev *mddev)
 {
-	stop_sync_thread(mddev, true, false);
 	del_timer_sync(&mddev->safemode_timer);
 
 	if (mddev->pers && mddev->pers->quiesce) {
@@ -6374,6 +6396,8 @@ static void __md_stop_writes(struct mddev *mddev)
 void md_stop_writes(struct mddev *mddev)
 {
 	mddev_lock_nointr(mddev);
+	set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+	stop_sync_thread(mddev, true, false);
 	__md_stop_writes(mddev);
 	mddev_unlock(mddev);
 }
@@ -8769,6 +8793,23 @@ void md_account_bio(struct mddev *mddev, struct bio **bio)
 }
 EXPORT_SYMBOL_GPL(md_account_bio);
 
+void md_free_cloned_bio(struct bio *bio)
+{
+	struct md_io_clone *md_io_clone = bio->bi_private;
+	struct bio *orig_bio = md_io_clone->orig_bio;
+	struct mddev *mddev = md_io_clone->mddev;
+
+	if (bio->bi_status && !orig_bio->bi_status)
+		orig_bio->bi_status = bio->bi_status;
+
+	if (md_io_clone->start_time)
+		bio_end_io_acct(orig_bio, md_io_clone->start_time);
+
+	bio_put(bio);
+	percpu_ref_put(&mddev->active_io);
+}
+EXPORT_SYMBOL_GPL(md_free_cloned_bio);
+
 /* md_allow_write(mddev)
  * Calling this ensures that the array is marked 'active' so that writes
  * may proceed without blocking.  It is important to call this before
@@ -9302,9 +9343,14 @@ static bool md_spares_need_change(struct mddev *mddev)
 {
 	struct md_rdev *rdev;
 
-	rdev_for_each(rdev, mddev)
-		if (rdev_removeable(rdev) || rdev_addable(rdev))
+	rcu_read_lock();
+	rdev_for_each_rcu(rdev, mddev) {
+		if (rdev_removeable(rdev) || rdev_addable(rdev)) {
+			rcu_read_unlock();
 			return true;
+		}
+	}
+	rcu_read_unlock();
 	return false;
 }
 
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 27d187ca6258..375ad4a2df71 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -559,6 +559,37 @@ enum recovery_flags {
 	MD_RESYNCING_REMOTE,	/* remote node is running resync thread */
 };
 
+enum md_ro_state {
+	MD_RDWR,
+	MD_RDONLY,
+	MD_AUTO_READ,
+	MD_MAX_STATE
+};
+
+static inline bool md_is_rdwr(struct mddev *mddev)
+{
+	return (mddev->ro == MD_RDWR);
+}
+
+static inline bool reshape_interrupted(struct mddev *mddev)
+{
+	/* reshape never start */
+	if (mddev->reshape_position == MaxSector)
+		return false;
+
+	/* interrupted */
+	if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
+		return true;
+
+	/* running reshape will be interrupted soon. */
+	if (test_bit(MD_RECOVERY_WAIT, &mddev->recovery) ||
+	    test_bit(MD_RECOVERY_INTR, &mddev->recovery) ||
+	    test_bit(MD_RECOVERY_FROZEN, &mddev->recovery))
+		return true;
+
+	return false;
+}
+
 static inline int __must_check mddev_lock(struct mddev *mddev)
 {
 	return mutex_lock_interruptible(&mddev->reconfig_mutex);
@@ -618,6 +649,7 @@ struct md_personality
 	int (*start_reshape) (struct mddev *mddev);
 	void (*finish_reshape) (struct mddev *mddev);
 	void (*update_reshape_pos) (struct mddev *mddev);
+	void (*prepare_suspend) (struct mddev *mddev);
 	/* quiesce suspends or resumes internal processing.
 	 * 1 - stop new actions and wait for action io to complete
 	 * 0 - return to normal behaviour
@@ -751,6 +783,7 @@ extern void md_finish_reshape(struct mddev *mddev);
 void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
 			struct bio *bio, sector_t start, sector_t size);
 void md_account_bio(struct mddev *mddev, struct bio **bio);
+void md_free_cloned_bio(struct bio *bio);
 
 extern bool __must_check md_flush_request(struct mddev *mddev, struct bio *bio);
 extern void md_super_write(struct mddev *mddev, struct md_rdev *rdev,
@@ -779,9 +812,12 @@ extern void md_stop_writes(struct mddev *mddev);
 extern int md_rdev_init(struct md_rdev *rdev);
 extern void md_rdev_clear(struct md_rdev *rdev);
 
-extern void md_handle_request(struct mddev *mddev, struct bio *bio);
+extern bool md_handle_request(struct mddev *mddev, struct bio *bio);
 extern int mddev_suspend(struct mddev *mddev, bool interruptible);
 extern void mddev_resume(struct mddev *mddev);
+extern void md_idle_sync_thread(struct mddev *mddev);
+extern void md_frozen_sync_thread(struct mddev *mddev);
+extern void md_unfrozen_sync_thread(struct mddev *mddev);
 
 extern void md_reload_sb(struct mddev *mddev, int raid_disk);
 extern void md_update_sb(struct mddev *mddev, int force);
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index f03e4231bec1..e1d8b5199f81 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -763,6 +763,7 @@ enum stripe_result {
 	STRIPE_RETRY,
 	STRIPE_SCHEDULE_AND_RETRY,
 	STRIPE_FAIL,
+	STRIPE_WAIT_RESHAPE,
 };
 
 struct stripe_request_ctx {
@@ -2422,7 +2423,7 @@ static int grow_one_stripe(struct r5conf *conf, gfp_t gfp)
 	atomic_inc(&conf->active_stripes);
 
 	raid5_release_stripe(sh);
-	conf->max_nr_stripes++;
+	WRITE_ONCE(conf->max_nr_stripes, conf->max_nr_stripes + 1);
 	return 1;
 }
 
@@ -2717,7 +2718,7 @@ static int drop_one_stripe(struct r5conf *conf)
 	shrink_buffers(sh);
 	free_stripe(conf->slab_cache, sh);
 	atomic_dec(&conf->active_stripes);
-	conf->max_nr_stripes--;
+	WRITE_ONCE(conf->max_nr_stripes, conf->max_nr_stripes - 1);
 	return 1;
 }
 
@@ -5991,7 +5992,8 @@ static enum stripe_result make_stripe_request(struct mddev *mddev,
 			if (ahead_of_reshape(mddev, logical_sector,
 					     conf->reshape_safe)) {
 				spin_unlock_irq(&conf->device_lock);
-				return STRIPE_SCHEDULE_AND_RETRY;
+				ret = STRIPE_SCHEDULE_AND_RETRY;
+				goto out;
 			}
 		}
 		spin_unlock_irq(&conf->device_lock);
@@ -6070,6 +6072,12 @@ static enum stripe_result make_stripe_request(struct mddev *mddev,
 
 out_release:
 	raid5_release_stripe(sh);
+out:
+	if (ret == STRIPE_SCHEDULE_AND_RETRY && reshape_interrupted(mddev)) {
+		bi->bi_status = BLK_STS_RESOURCE;
+		ret = STRIPE_WAIT_RESHAPE;
+		pr_err_ratelimited("dm-raid456: io across reshape position while reshape can't make progress");
+	}
 	return ret;
 }
 
@@ -6191,7 +6199,7 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 	while (1) {
 		res = make_stripe_request(mddev, conf, &ctx, logical_sector,
 					  bi);
-		if (res == STRIPE_FAIL)
+		if (res == STRIPE_FAIL || res == STRIPE_WAIT_RESHAPE)
 			break;
 
 		if (res == STRIPE_RETRY)
@@ -6229,6 +6237,11 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 
 	if (rw == WRITE)
 		md_write_end(mddev);
+	if (res == STRIPE_WAIT_RESHAPE) {
+		md_free_cloned_bio(bi);
+		return false;
+	}
+
 	bio_endio(bi);
 	return true;
 }
@@ -6878,7 +6891,7 @@ raid5_set_cache_size(struct mddev *mddev, int size)
 	if (size <= 16 || size > 32768)
 		return -EINVAL;
 
-	conf->min_nr_stripes = size;
+	WRITE_ONCE(conf->min_nr_stripes, size);
 	mutex_lock(&conf->cache_size_mutex);
 	while (size < conf->max_nr_stripes &&
 	       drop_one_stripe(conf))
@@ -6890,7 +6903,7 @@ raid5_set_cache_size(struct mddev *mddev, int size)
 	mutex_lock(&conf->cache_size_mutex);
 	while (size > conf->max_nr_stripes)
 		if (!grow_one_stripe(conf, GFP_KERNEL)) {
-			conf->min_nr_stripes = conf->max_nr_stripes;
+			WRITE_ONCE(conf->min_nr_stripes, conf->max_nr_stripes);
 			result = -ENOMEM;
 			break;
 		}
@@ -7448,11 +7461,13 @@ static unsigned long raid5_cache_count(struct shrinker *shrink,
 				       struct shrink_control *sc)
 {
 	struct r5conf *conf = shrink->private_data;
+	int max_stripes = READ_ONCE(conf->max_nr_stripes);
+	int min_stripes = READ_ONCE(conf->min_nr_stripes);
 
-	if (conf->max_nr_stripes < conf->min_nr_stripes)
+	if (max_stripes < min_stripes)
 		/* unlikely, but not impossible */
 		return 0;
-	return conf->max_nr_stripes - conf->min_nr_stripes;
+	return max_stripes - min_stripes;
 }
 
 static struct r5conf *setup_conf(struct mddev *mddev)
@@ -8981,6 +8996,18 @@ static int raid5_start(struct mddev *mddev)
 	return r5l_start(conf->log);
 }
 
+/*
+ * This is only used for dm-raid456, caller already frozen sync_thread, hence
+ * if rehsape is still in progress, io that is waiting for reshape can never be
+ * done now, hence wake up and handle those IO.
+ */
+static void raid5_prepare_suspend(struct mddev *mddev)
+{
+	struct r5conf *conf = mddev->private;
+
+	wake_up(&conf->wait_for_overlap);
+}
+
 static struct md_personality raid6_personality =
 {
 	.name		= "raid6",
@@ -9004,6 +9031,7 @@ static struct md_personality raid6_personality =
 	.quiesce	= raid5_quiesce,
 	.takeover	= raid6_takeover,
 	.change_consistency_policy = raid5_change_consistency_policy,
+	.prepare_suspend = raid5_prepare_suspend,
 };
 static struct md_personality raid5_personality =
 {
@@ -9028,6 +9056,7 @@ static struct md_personality raid5_personality =
 	.quiesce	= raid5_quiesce,
 	.takeover	= raid5_takeover,
 	.change_consistency_policy = raid5_change_consistency_policy,
+	.prepare_suspend = raid5_prepare_suspend,
 };
 
 static struct md_personality raid4_personality =
@@ -9053,6 +9082,7 @@ static struct md_personality raid4_personality =
 	.quiesce	= raid5_quiesce,
 	.takeover	= raid4_takeover,
 	.change_consistency_policy = raid5_change_consistency_policy,
+	.prepare_suspend = raid5_prepare_suspend,
 };
 
 static int __init raid5_init(void)
diff --git a/drivers/media/mc/mc-entity.c b/drivers/media/mc/mc-entity.c
index 543a392f8635..0e28b9a7936e 100644
--- a/drivers/media/mc/mc-entity.c
+++ b/drivers/media/mc/mc-entity.c
@@ -535,14 +535,15 @@ static int media_pipeline_walk_push(struct media_pipeline_walk *walk,
 
 /*
  * Move the top entry link cursor to the next link. If all links of the entry
- * have been visited, pop the entry itself.
+ * have been visited, pop the entry itself. Return true if the entry has been
+ * popped.
  */
-static void media_pipeline_walk_pop(struct media_pipeline_walk *walk)
+static bool media_pipeline_walk_pop(struct media_pipeline_walk *walk)
 {
 	struct media_pipeline_walk_entry *entry;
 
 	if (WARN_ON(walk->stack.top < 0))
-		return;
+		return false;
 
 	entry = media_pipeline_walk_top(walk);
 
@@ -552,7 +553,7 @@ static void media_pipeline_walk_pop(struct media_pipeline_walk *walk)
 			walk->stack.top);
 
 		walk->stack.top--;
-		return;
+		return true;
 	}
 
 	entry->links = entry->links->next;
@@ -560,6 +561,8 @@ static void media_pipeline_walk_pop(struct media_pipeline_walk *walk)
 	dev_dbg(walk->mdev->dev,
 		"media pipeline: moved entry %u to next link\n",
 		walk->stack.top);
+
+	return false;
 }
 
 /* Free all memory allocated while walking the pipeline. */
@@ -605,30 +608,24 @@ static int media_pipeline_explore_next_link(struct media_pipeline *pipe,
 					    struct media_pipeline_walk *walk)
 {
 	struct media_pipeline_walk_entry *entry = media_pipeline_walk_top(walk);
-	struct media_pad *pad;
+	struct media_pad *origin;
 	struct media_link *link;
 	struct media_pad *local;
 	struct media_pad *remote;
+	bool last_link;
 	int ret;
 
-	pad = entry->pad;
+	origin = entry->pad;
 	link = list_entry(entry->links, typeof(*link), list);
-	media_pipeline_walk_pop(walk);
+	last_link = media_pipeline_walk_pop(walk);
 
 	dev_dbg(walk->mdev->dev,
 		"media pipeline: exploring link '%s':%u -> '%s':%u\n",
 		link->source->entity->name, link->source->index,
 		link->sink->entity->name, link->sink->index);
 
-	/* Skip links that are not enabled. */
-	if (!(link->flags & MEDIA_LNK_FL_ENABLED)) {
-		dev_dbg(walk->mdev->dev,
-			"media pipeline: skipping link (disabled)\n");
-		return 0;
-	}
-
 	/* Get the local pad and remote pad. */
-	if (link->source->entity == pad->entity) {
+	if (link->source->entity == origin->entity) {
 		local = link->source;
 		remote = link->sink;
 	} else {
@@ -640,25 +637,64 @@ static int media_pipeline_explore_next_link(struct media_pipeline *pipe,
 	 * Skip links that originate from a different pad than the incoming pad
 	 * that is not connected internally in the entity to the incoming pad.
 	 */
-	if (pad != local &&
-	    !media_entity_has_pad_interdep(pad->entity, pad->index, local->index)) {
+	if (origin != local &&
+	    !media_entity_has_pad_interdep(origin->entity, origin->index,
+					   local->index)) {
 		dev_dbg(walk->mdev->dev,
 			"media pipeline: skipping link (no route)\n");
-		return 0;
+		goto done;
 	}
 
 	/*
-	 * Add the local and remote pads of the link to the pipeline and push
-	 * them to the stack, if they're not already present.
+	 * Add the local pad of the link to the pipeline and push it to the
+	 * stack, if not already present.
 	 */
 	ret = media_pipeline_add_pad(pipe, walk, local);
 	if (ret)
 		return ret;
 
+	/* Similarly, add the remote pad, but only if the link is enabled. */
+	if (!(link->flags & MEDIA_LNK_FL_ENABLED)) {
+		dev_dbg(walk->mdev->dev,
+			"media pipeline: skipping link (disabled)\n");
+		goto done;
+	}
+
 	ret = media_pipeline_add_pad(pipe, walk, remote);
 	if (ret)
 		return ret;
 
+done:
+	/*
+	 * If we're done iterating over links, iterate over pads of the entity.
+	 * This is necessary to discover pads that are not connected with any
+	 * link. Those are dead ends from a pipeline exploration point of view,
+	 * but are still part of the pipeline and need to be added to enable
+	 * proper validation.
+	 */
+	if (!last_link)
+		return 0;
+
+	dev_dbg(walk->mdev->dev,
+		"media pipeline: adding unconnected pads of '%s'\n",
+		local->entity->name);
+
+	media_entity_for_each_pad(origin->entity, local) {
+		/*
+		 * Skip the origin pad (already handled), pad that have links
+		 * (already discovered through iterating over links) and pads
+		 * not internally connected.
+		 */
+		if (origin == local || !local->num_links ||
+		    !media_entity_has_pad_interdep(origin->entity, origin->index,
+						   local->index))
+			continue;
+
+		ret = media_pipeline_add_pad(pipe, walk, local);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -770,7 +806,6 @@ __must_check int __media_pipeline_start(struct media_pad *pad,
 		struct media_pad *pad = ppad->pad;
 		struct media_entity *entity = pad->entity;
 		bool has_enabled_link = false;
-		bool has_link = false;
 		struct media_link *link;
 
 		dev_dbg(mdev->dev, "Validating pad '%s':%u\n", pad->entity->name,
@@ -800,7 +835,6 @@ __must_check int __media_pipeline_start(struct media_pad *pad,
 			/* Record if the pad has links and enabled links. */
 			if (link->flags & MEDIA_LNK_FL_ENABLED)
 				has_enabled_link = true;
-			has_link = true;
 
 			/*
 			 * Validate the link if it's enabled and has the
@@ -838,7 +872,7 @@ __must_check int __media_pipeline_start(struct media_pad *pad,
 		 * 3. If the pad has the MEDIA_PAD_FL_MUST_CONNECT flag set,
 		 * ensure that it has either no link or an enabled link.
 		 */
-		if ((pad->flags & MEDIA_PAD_FL_MUST_CONNECT) && has_link &&
+		if ((pad->flags & MEDIA_PAD_FL_MUST_CONNECT) &&
 		    !has_enabled_link) {
 			dev_dbg(mdev->dev,
 				"Pad '%s':%u must be connected by an enabled link\n",
@@ -1038,6 +1072,9 @@ static void __media_entity_remove_link(struct media_entity *entity,
 
 	/* Remove the reverse links for a data link. */
 	if ((link->flags & MEDIA_LNK_FL_LINK_TYPE) == MEDIA_LNK_FL_DATA_LINK) {
+		link->source->num_links--;
+		link->sink->num_links--;
+
 		if (link->source->entity == entity)
 			remote = link->sink->entity;
 		else
@@ -1092,6 +1129,11 @@ media_create_pad_link(struct media_entity *source, u16 source_pad,
 	struct media_link *link;
 	struct media_link *backlink;
 
+	if (flags & MEDIA_LNK_FL_LINK_TYPE)
+		return -EINVAL;
+
+	flags |= MEDIA_LNK_FL_DATA_LINK;
+
 	if (WARN_ON(!source || !sink) ||
 	    WARN_ON(source_pad >= source->num_pads) ||
 	    WARN_ON(sink_pad >= sink->num_pads))
@@ -1107,7 +1149,7 @@ media_create_pad_link(struct media_entity *source, u16 source_pad,
 
 	link->source = &source->pads[source_pad];
 	link->sink = &sink->pads[sink_pad];
-	link->flags = flags & ~MEDIA_LNK_FL_INTERFACE_LINK;
+	link->flags = flags;
 
 	/* Initialize graph object embedded at the new link */
 	media_gobj_create(source->graph_obj.mdev, MEDIA_GRAPH_LINK,
@@ -1138,6 +1180,9 @@ media_create_pad_link(struct media_entity *source, u16 source_pad,
 	sink->num_links++;
 	source->num_links++;
 
+	link->source->num_links++;
+	link->sink->num_links++;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(media_create_pad_link);
diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
index 792f031e032a..c9a4d091b570 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
@@ -161,7 +161,6 @@ mxc_isi_crossbar_xlate_streams(struct mxc_isi_crossbar *xbar,
 
 	pad = media_pad_remote_pad_first(&xbar->pads[sink_pad]);
 	sd = media_entity_to_v4l2_subdev(pad->entity);
-
 	if (!sd) {
 		dev_dbg(xbar->isi->dev,
 			"no entity connected to crossbar input %u\n",
@@ -465,7 +464,8 @@ int mxc_isi_crossbar_init(struct mxc_isi_dev *isi)
 	}
 
 	for (i = 0; i < xbar->num_sinks; ++i)
-		xbar->pads[i].flags = MEDIA_PAD_FL_SINK;
+		xbar->pads[i].flags = MEDIA_PAD_FL_SINK
+				    | MEDIA_PAD_FL_MUST_CONNECT;
 	for (i = 0; i < xbar->num_sources; ++i)
 		xbar->pads[i + xbar->num_sinks].flags = MEDIA_PAD_FL_SOURCE;
 
diff --git a/drivers/media/tuners/xc4000.c b/drivers/media/tuners/xc4000.c
index 57ded9ff3f04..29bc63021c5a 100644
--- a/drivers/media/tuners/xc4000.c
+++ b/drivers/media/tuners/xc4000.c
@@ -1515,10 +1515,10 @@ static int xc4000_get_frequency(struct dvb_frontend *fe, u32 *freq)
 {
 	struct xc4000_priv *priv = fe->tuner_priv;
 
+	mutex_lock(&priv->lock);
 	*freq = priv->freq_hz + priv->freq_offset;
 
 	if (debug) {
-		mutex_lock(&priv->lock);
 		if ((priv->cur_fw.type
 		     & (BASE | FM | DTV6 | DTV7 | DTV78 | DTV8)) == BASE) {
 			u16	snr = 0;
@@ -1529,8 +1529,8 @@ static int xc4000_get_frequency(struct dvb_frontend *fe, u32 *freq)
 				return 0;
 			}
 		}
-		mutex_unlock(&priv->lock);
 	}
+	mutex_unlock(&priv->lock);
 
 	dprintk(1, "%s()\n", __func__);
 
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 68d71b4b55bd..f8fdf8223818 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1773,6 +1773,7 @@ config TWL4030_CORE
 	bool "TI TWL4030/TWL5030/TWL6030/TPS659x0 Support"
 	depends on I2C=y
 	select IRQ_DOMAIN
+	select MFD_CORE
 	select REGMAP_I2C
 	help
 	  Say yes here if you have TWL4030 / TWL6030 family chip on your board.
diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index ae5759200622..cab11ed23b4f 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -18,18 +18,29 @@
 
 #include "intel-lpss.h"
 
-/* Some DSDTs have an unused GEXP ACPI device conflicting with I2C4 resources */
-static const struct pci_device_id ignore_resource_conflicts_ids[] = {
-	/* Microsoft Surface Go (version 1) I2C4 */
-	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1182), },
-	/* Microsoft Surface Go 2 I2C4 */
-	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1237), },
+static const struct pci_device_id quirk_ids[] = {
+	{
+		/* Microsoft Surface Go (version 1) I2C4 */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1182),
+		.driver_data = QUIRK_IGNORE_RESOURCE_CONFLICTS,
+	},
+	{
+		/* Microsoft Surface Go 2 I2C4 */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1237),
+		.driver_data = QUIRK_IGNORE_RESOURCE_CONFLICTS,
+	},
+	{
+		/* Dell XPS 9530 (2023) */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x51fb, 0x1028, 0x0beb),
+		.driver_data = QUIRK_CLOCK_DIVIDER_UNITY,
+	},
 	{ }
 };
 
 static int intel_lpss_pci_probe(struct pci_dev *pdev,
 				const struct pci_device_id *id)
 {
+	const struct pci_device_id *quirk_pci_info;
 	struct intel_lpss_platform_info *info;
 	int ret;
 
@@ -45,8 +56,9 @@ static int intel_lpss_pci_probe(struct pci_dev *pdev,
 	info->mem = &pdev->resource[0];
 	info->irq = pdev->irq;
 
-	if (pci_match_id(ignore_resource_conflicts_ids, pdev))
-		info->ignore_resource_conflicts = true;
+	quirk_pci_info = pci_match_id(quirk_ids, pdev);
+	if (quirk_pci_info)
+		info->quirks = quirk_pci_info->driver_data;
 
 	pdev->d3cold_delay = 0;
 
diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index 00e7b578bb3e..d422e88ba491 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -292,6 +292,7 @@ static int intel_lpss_register_clock_divider(struct intel_lpss *lpss,
 {
 	char name[32];
 	struct clk *tmp = *clk;
+	int ret;
 
 	snprintf(name, sizeof(name), "%s-enable", devname);
 	tmp = clk_register_gate(NULL, name, __clk_get_name(tmp), 0,
@@ -308,6 +309,12 @@ static int intel_lpss_register_clock_divider(struct intel_lpss *lpss,
 		return PTR_ERR(tmp);
 	*clk = tmp;
 
+	if (lpss->info->quirks & QUIRK_CLOCK_DIVIDER_UNITY) {
+		ret = clk_set_rate(tmp, lpss->info->clk_rate);
+		if (ret)
+			return ret;
+	}
+
 	snprintf(name, sizeof(name), "%s-update", devname);
 	tmp = clk_register_gate(NULL, name, __clk_get_name(tmp),
 				CLK_SET_RATE_PARENT, lpss->priv, 31, 0, NULL);
@@ -401,7 +408,7 @@ int intel_lpss_probe(struct device *dev,
 		return ret;
 
 	lpss->cell->swnode = info->swnode;
-	lpss->cell->ignore_resource_conflicts = info->ignore_resource_conflicts;
+	lpss->cell->ignore_resource_conflicts = info->quirks & QUIRK_IGNORE_RESOURCE_CONFLICTS;
 
 	intel_lpss_init_dev(lpss);
 
diff --git a/drivers/mfd/intel-lpss.h b/drivers/mfd/intel-lpss.h
index 062ce95b68b9..f50d11d60d94 100644
--- a/drivers/mfd/intel-lpss.h
+++ b/drivers/mfd/intel-lpss.h
@@ -11,16 +11,28 @@
 #ifndef __MFD_INTEL_LPSS_H
 #define __MFD_INTEL_LPSS_H
 
+#include <linux/bits.h>
 #include <linux/pm.h>
 
+/*
+ * Some DSDTs have an unused GEXP ACPI device conflicting with I2C4 resources.
+ * Set to ignore resource conflicts with ACPI declared SystemMemory regions.
+ */
+#define QUIRK_IGNORE_RESOURCE_CONFLICTS BIT(0)
+/*
+ * Some devices have misconfigured clock divider due to a firmware bug.
+ * Set this to force the clock divider to 1:1 ratio.
+ */
+#define QUIRK_CLOCK_DIVIDER_UNITY		BIT(1)
+
 struct device;
 struct resource;
 struct software_node;
 
 struct intel_lpss_platform_info {
 	struct resource *mem;
-	bool ignore_resource_conflicts;
 	int irq;
+	unsigned int quirks;
 	unsigned long clk_rate;
 	const char *clk_con_id;
 	const struct software_node *swnode;
diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 03319a1fa97f..dbd26c3b245b 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -263,7 +263,6 @@ struct fastrpc_channel_ctx {
 	int domain_id;
 	int sesscount;
 	int vmcount;
-	u64 perms;
 	struct qcom_scm_vmperm vmperms[FASTRPC_MAX_VMIDS];
 	struct rpmsg_device *rpdev;
 	struct fastrpc_session_ctx session[FASTRPC_MAX_SESSIONS];
@@ -1279,9 +1278,11 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 
 		/* Map if we have any heap VMIDs associated with this ADSP Static Process. */
 		if (fl->cctx->vmcount) {
+			u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
+
 			err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
 							(u64)fl->cctx->remote_heap->size,
-							&fl->cctx->perms,
+							&src_perms,
 							fl->cctx->vmperms, fl->cctx->vmcount);
 			if (err) {
 				dev_err(fl->sctx->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d",
@@ -1915,8 +1916,10 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 
 	/* Add memory to static PD pool, protection thru hypervisor */
 	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR && fl->cctx->vmcount) {
+		u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
+
 		err = qcom_scm_assign_mem(buf->phys, (u64)buf->size,
-			&fl->cctx->perms, fl->cctx->vmperms, fl->cctx->vmcount);
+			&src_perms, fl->cctx->vmperms, fl->cctx->vmcount);
 		if (err) {
 			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
 					buf->phys, buf->size, err);
@@ -2290,7 +2293,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 
 	if (vmcount) {
 		data->vmcount = vmcount;
-		data->perms = BIT(QCOM_SCM_VMID_HLOS);
 		for (i = 0; i < data->vmcount; i++) {
 			data->vmperms[i].vmid = vmids[i];
 			data->vmperms[i].perm = QCOM_SCM_PERM_RWX;
diff --git a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c b/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
index c6eb27d46cb0..15119584473c 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
@@ -198,8 +198,14 @@ static int lis3lv02d_i2c_suspend(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lis3lv02d *lis3 = i2c_get_clientdata(client);
 
-	if (!lis3->pdata || !lis3->pdata->wakeup_flags)
+	/* Turn on for wakeup if turned off by runtime suspend */
+	if (lis3->pdata && lis3->pdata->wakeup_flags) {
+		if (pm_runtime_suspended(dev))
+			lis3lv02d_poweron(lis3);
+	/* For non wakeup turn off if not already turned off by runtime suspend */
+	} else if (!pm_runtime_suspended(dev))
 		lis3lv02d_poweroff(lis3);
+
 	return 0;
 }
 
@@ -208,13 +214,12 @@ static int lis3lv02d_i2c_resume(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lis3lv02d *lis3 = i2c_get_clientdata(client);
 
-	/*
-	 * pm_runtime documentation says that devices should always
-	 * be powered on at resume. Pm_runtime turns them off after system
-	 * wide resume is complete.
-	 */
-	if (!lis3->pdata || !lis3->pdata->wakeup_flags ||
-		pm_runtime_suspended(dev))
+	/* Turn back off if turned on for wakeup and runtime suspended*/
+	if (lis3->pdata && lis3->pdata->wakeup_flags) {
+		if (pm_runtime_suspended(dev))
+			lis3lv02d_poweroff(lis3);
+	/* For non wakeup turn back on if not runtime suspended */
+	} else if (!pm_runtime_suspended(dev))
 		lis3lv02d_poweron(lis3);
 
 	return 0;
diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index 961e5d53a27a..aac36750d2c5 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -112,6 +112,8 @@
 #define MEI_DEV_ID_RPL_S      0x7A68  /* Raptor Lake Point S */
 
 #define MEI_DEV_ID_MTL_M      0x7E70  /* Meteor Lake Point M */
+#define MEI_DEV_ID_ARL_S      0x7F68  /* Arrow Lake Point S */
+#define MEI_DEV_ID_ARL_H      0x7770  /* Arrow Lake Point H */
 
 /*
  * MEI HW Section
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 676d566f38dd..8cf636c54032 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -119,6 +119,8 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 	{MEI_PCI_DEVICE(MEI_DEV_ID_RPL_S, MEI_ME_PCH15_CFG)},
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_MTL_M, MEI_ME_PCH15_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_ARL_S, MEI_ME_PCH15_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_ARL_H, MEI_ME_PCH15_CFG)},
 
 	/* required last entry */
 	{0, }
diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
index ac69b7f361f5..7eb74711ac96 100644
--- a/drivers/misc/ocxl/file.c
+++ b/drivers/misc/ocxl/file.c
@@ -184,7 +184,7 @@ static irqreturn_t irq_handler(void *private)
 {
 	struct eventfd_ctx *ev_ctx = private;
 
-	eventfd_signal(ev_ctx, 1);
+	eventfd_signal(ev_ctx);
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 32d49100dff5..3564a0f63c9c 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -413,7 +413,7 @@ static struct mmc_blk_ioc_data *mmc_blk_ioctl_copy_from_user(
 	struct mmc_blk_ioc_data *idata;
 	int err;
 
-	idata = kmalloc(sizeof(*idata), GFP_KERNEL);
+	idata = kzalloc(sizeof(*idata), GFP_KERNEL);
 	if (!idata) {
 		err = -ENOMEM;
 		goto out;
@@ -488,7 +488,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	if (idata->flags & MMC_BLK_IOC_DROP)
 		return 0;
 
-	if (idata->flags & MMC_BLK_IOC_SBC)
+	if (idata->flags & MMC_BLK_IOC_SBC && i > 0)
 		prev_idata = idatas[i - 1];
 
 	/*
@@ -874,10 +874,11 @@ static const struct block_device_operations mmc_bdops = {
 static int mmc_blk_part_switch_pre(struct mmc_card *card,
 				   unsigned int part_type)
 {
-	const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_RPMB;
+	const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_MASK;
+	const unsigned int rpmb = EXT_CSD_PART_CONFIG_ACC_RPMB;
 	int ret = 0;
 
-	if ((part_type & mask) == mask) {
+	if ((part_type & mask) == rpmb) {
 		if (card->ext_csd.cmdq_en) {
 			ret = mmc_cmdq_disable(card);
 			if (ret)
@@ -892,10 +893,11 @@ static int mmc_blk_part_switch_pre(struct mmc_card *card,
 static int mmc_blk_part_switch_post(struct mmc_card *card,
 				    unsigned int part_type)
 {
-	const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_RPMB;
+	const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_MASK;
+	const unsigned int rpmb = EXT_CSD_PART_CONFIG_ACC_RPMB;
 	int ret = 0;
 
-	if ((part_type & mask) == mask) {
+	if ((part_type & mask) == rpmb) {
 		mmc_retune_unpause(card->host);
 		if (card->reenable_cmdq && !card->ext_csd.cmdq_en)
 			ret = mmc_cmdq_enable(card);
diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 3a3bae6948a8..a0524127ca07 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -584,6 +584,17 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	return err;
 }
 
+static void dwcmshc_disable_card_clk(struct sdhci_host *host)
+{
+	u16 ctrl;
+
+	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	if (ctrl & SDHCI_CLOCK_CARD_EN) {
+		ctrl &= ~SDHCI_CLOCK_CARD_EN;
+		sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
+	}
+}
+
 static void dwcmshc_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
@@ -591,8 +602,14 @@ static void dwcmshc_remove(struct platform_device *pdev)
 	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
 	struct rk35xx_priv *rk_priv = priv->priv;
 
+	pm_runtime_get_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+
 	sdhci_remove_host(host, 0);
 
+	dwcmshc_disable_card_clk(host);
+
 	clk_disable_unprepare(pltfm_host->clk);
 	clk_disable_unprepare(priv->bus_clk);
 	if (rk_priv)
@@ -684,17 +701,6 @@ static void dwcmshc_enable_card_clk(struct sdhci_host *host)
 	}
 }
 
-static void dwcmshc_disable_card_clk(struct sdhci_host *host)
-{
-	u16 ctrl;
-
-	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-	if (ctrl & SDHCI_CLOCK_CARD_EN) {
-		ctrl &= ~SDHCI_CLOCK_CARD_EN;
-		sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
-	}
-}
-
 static int dwcmshc_runtime_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 1e0bc7bace1b..0a26831b3b67 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -1439,6 +1439,9 @@ static int __maybe_unused sdhci_omap_runtime_suspend(struct device *dev)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
 
+	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
+		mmc_retune_needed(host->mmc);
+
 	if (omap_host->con != -EINVAL)
 		sdhci_runtime_suspend_host(host);
 
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index be7f18fd4836..c253d176db69 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -259,6 +259,8 @@ static void tmio_mmc_reset_work(struct work_struct *work)
 	else
 		mrq->cmd->error = -ETIMEDOUT;
 
+	/* No new calls yet, but disallow concurrent tmio_mmc_done_work() */
+	host->mrq = ERR_PTR(-EBUSY);
 	host->cmd = NULL;
 	host->data = NULL;
 
diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index 71ec4052e52a..b3a881cbcd23 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -63,7 +63,7 @@
 #define CMDRWGEN(cmd_dir, ran, bch, short_mode, page_size, pages)	\
 	(								\
 		(cmd_dir)			|			\
-		((ran) << 19)			|			\
+		(ran)				|			\
 		((bch) << 14)			|			\
 		((short_mode) << 13)		|			\
 		(((page_size) & 0x7f) << 6)	|			\
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index bbdcfbe643f3..ccbd42a427e7 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -1207,21 +1207,36 @@ static int nand_lp_exec_read_page_op(struct nand_chip *chip, unsigned int page,
 	return nand_exec_op(chip, &op);
 }
 
+static unsigned int rawnand_last_page_of_lun(unsigned int pages_per_lun, unsigned int lun)
+{
+	/* lun is expected to be very small */
+	return (lun * pages_per_lun) + pages_per_lun - 1;
+}
+
 static void rawnand_cap_cont_reads(struct nand_chip *chip)
 {
 	struct nand_memory_organization *memorg;
-	unsigned int pages_per_lun, first_lun, last_lun;
+	unsigned int ppl, first_lun, last_lun;
 
 	memorg = nanddev_get_memorg(&chip->base);
-	pages_per_lun = memorg->pages_per_eraseblock * memorg->eraseblocks_per_lun;
-	first_lun = chip->cont_read.first_page / pages_per_lun;
-	last_lun = chip->cont_read.last_page / pages_per_lun;
+	ppl = memorg->pages_per_eraseblock * memorg->eraseblocks_per_lun;
+	first_lun = chip->cont_read.first_page / ppl;
+	last_lun = chip->cont_read.last_page / ppl;
 
 	/* Prevent sequential cache reads across LUN boundaries */
 	if (first_lun != last_lun)
-		chip->cont_read.pause_page = first_lun * pages_per_lun + pages_per_lun - 1;
+		chip->cont_read.pause_page = rawnand_last_page_of_lun(ppl, first_lun);
 	else
 		chip->cont_read.pause_page = chip->cont_read.last_page;
+
+	if (chip->cont_read.first_page == chip->cont_read.pause_page) {
+		chip->cont_read.first_page++;
+		chip->cont_read.pause_page = min(chip->cont_read.last_page,
+						 rawnand_last_page_of_lun(ppl, first_lun + 1));
+	}
+
+	if (chip->cont_read.first_page >= chip->cont_read.last_page)
+		chip->cont_read.ongoing = false;
 }
 
 static int nand_lp_exec_cont_read_page_op(struct nand_chip *chip, unsigned int page,
@@ -1288,12 +1303,11 @@ static int nand_lp_exec_cont_read_page_op(struct nand_chip *chip, unsigned int p
 	if (!chip->cont_read.ongoing)
 		return 0;
 
-	if (page == chip->cont_read.pause_page &&
-	    page != chip->cont_read.last_page) {
-		chip->cont_read.first_page = chip->cont_read.pause_page + 1;
-		rawnand_cap_cont_reads(chip);
-	} else if (page == chip->cont_read.last_page) {
+	if (page == chip->cont_read.last_page) {
 		chip->cont_read.ongoing = false;
+	} else if (page == chip->cont_read.pause_page) {
+		chip->cont_read.first_page++;
+		rawnand_cap_cont_reads(chip);
 	}
 
 	return 0;
@@ -3460,30 +3474,36 @@ static void rawnand_enable_cont_reads(struct nand_chip *chip, unsigned int page,
 				      u32 readlen, int col)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
-	unsigned int end_page, end_col;
+	unsigned int first_page, last_page;
 
 	chip->cont_read.ongoing = false;
 
 	if (!chip->controller->supported_op.cont_read)
 		return;
 
-	end_page = DIV_ROUND_UP(col + readlen, mtd->writesize);
-	end_col = (col + readlen) % mtd->writesize;
+	/*
+	 * Don't bother making any calculations if the length is too small.
+	 * Side effect: avoids possible integer underflows below.
+	 */
+	if (readlen < (2 * mtd->writesize))
+		return;
 
+	/* Derive the page where continuous read should start (the first full page read) */
+	first_page = page;
 	if (col)
-		page++;
+		first_page++;
 
-	if (end_col && end_page)
-		end_page--;
+	/* Derive the page where continuous read should stop (the last full page read) */
+	last_page = page + ((col + readlen) / mtd->writesize) - 1;
 
-	if (page + 1 > end_page)
-		return;
-
-	chip->cont_read.first_page = page;
-	chip->cont_read.last_page = end_page;
-	chip->cont_read.ongoing = true;
-
-	rawnand_cap_cont_reads(chip);
+	/* Configure and enable continuous read when suitable */
+	if (first_page < last_page) {
+		chip->cont_read.first_page = first_page;
+		chip->cont_read.last_page = last_page;
+		chip->cont_read.ongoing = true;
+		/* May reset the ongoing flag */
+		rawnand_cap_cont_reads(chip);
+	}
 }
 
 static void rawnand_cont_read_skip_first_page(struct nand_chip *chip, unsigned int page)
@@ -3492,10 +3512,7 @@ static void rawnand_cont_read_skip_first_page(struct nand_chip *chip, unsigned i
 		return;
 
 	chip->cont_read.first_page++;
-	if (chip->cont_read.first_page == chip->cont_read.pause_page)
-		chip->cont_read.first_page++;
-	if (chip->cont_read.first_page >= chip->cont_read.last_page)
-		chip->cont_read.ongoing = false;
+	rawnand_cap_cont_reads(chip);
 }
 
 /**
@@ -3571,7 +3588,8 @@ static int nand_do_read_ops(struct nand_chip *chip, loff_t from,
 	oob = ops->oobbuf;
 	oob_required = oob ? 1 : 0;
 
-	rawnand_enable_cont_reads(chip, page, readlen, col);
+	if (likely(ops->mode != MTD_OPS_RAW))
+		rawnand_enable_cont_reads(chip, page, readlen, col);
 
 	while (1) {
 		struct mtd_ecc_stats ecc_stats = mtd->ecc_stats;
@@ -5189,6 +5207,15 @@ static void rawnand_late_check_supported_ops(struct nand_chip *chip)
 	if (!nand_has_exec_op(chip))
 		return;
 
+	/*
+	 * For now, continuous reads can only be used with the core page helpers.
+	 * This can be extended later.
+	 */
+	if (!(chip->ecc.read_page == nand_read_page_hwecc ||
+	      chip->ecc.read_page == nand_read_page_syndrome ||
+	      chip->ecc.read_page == nand_read_page_swecc))
+		return;
+
 	rawnand_check_cont_read_support(chip);
 }
 
diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
index 2a728c31e6b8..9a4940874be5 100644
--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -85,9 +85,10 @@ size_t ubi_calc_fm_size(struct ubi_device *ubi)
 		sizeof(struct ubi_fm_scan_pool) +
 		sizeof(struct ubi_fm_scan_pool) +
 		(ubi->peb_count * sizeof(struct ubi_fm_ec)) +
-		(sizeof(struct ubi_fm_eba) +
-		(ubi->peb_count * sizeof(__be32))) +
-		sizeof(struct ubi_fm_volhdr) * UBI_MAX_VOLUMES;
+		((sizeof(struct ubi_fm_eba) +
+		  sizeof(struct ubi_fm_volhdr)) *
+		 (UBI_MAX_VOLUMES + UBI_INT_VOL_COUNT)) +
+		(ubi->peb_count * sizeof(__be32));
 	return roundup(size, ubi->leb_size);
 }
 
diff --git a/drivers/mtd/ubi/vtbl.c b/drivers/mtd/ubi/vtbl.c
index f700f0e4f2ec..6e5489e233dd 100644
--- a/drivers/mtd/ubi/vtbl.c
+++ b/drivers/mtd/ubi/vtbl.c
@@ -791,6 +791,12 @@ int ubi_read_volume_table(struct ubi_device *ubi, struct ubi_attach_info *ai)
 	 * The number of supported volumes is limited by the eraseblock size
 	 * and by the UBI_MAX_VOLUMES constant.
 	 */
+
+	if (ubi->leb_size < UBI_VTBL_RECORD_SIZE) {
+		ubi_err(ubi, "LEB size too small for a volume record");
+		return -EINVAL;
+	}
+
 	ubi->vtbl_slots = ubi->leb_size / UBI_VTBL_RECORD_SIZE;
 	if (ubi->vtbl_slots > UBI_MAX_VOLUMES)
 		ubi->vtbl_slots = UBI_MAX_VOLUMES;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h
index 8510b88d4982..f3cd5a376eca 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h
@@ -24,7 +24,7 @@ TRACE_EVENT(hclge_pf_mbx_get,
 		__field(u8, code)
 		__field(u8, subcode)
 		__string(pciname, pci_name(hdev->pdev))
-		__string(devname, &hdev->vport[0].nic.kinfo.netdev->name)
+		__string(devname, hdev->vport[0].nic.kinfo.netdev->name)
 		__array(u32, mbx_data, PF_GET_MBX_LEN)
 	),
 
@@ -33,7 +33,7 @@ TRACE_EVENT(hclge_pf_mbx_get,
 		__entry->code = req->msg.code;
 		__entry->subcode = req->msg.subcode;
 		__assign_str(pciname, pci_name(hdev->pdev));
-		__assign_str(devname, &hdev->vport[0].nic.kinfo.netdev->name);
+		__assign_str(devname, hdev->vport[0].nic.kinfo.netdev->name);
 		memcpy(__entry->mbx_data, req,
 		       sizeof(struct hclge_mbx_vf_to_pf_cmd));
 	),
@@ -56,7 +56,7 @@ TRACE_EVENT(hclge_pf_mbx_send,
 		__field(u8, vfid)
 		__field(u16, code)
 		__string(pciname, pci_name(hdev->pdev))
-		__string(devname, &hdev->vport[0].nic.kinfo.netdev->name)
+		__string(devname, hdev->vport[0].nic.kinfo.netdev->name)
 		__array(u32, mbx_data, PF_SEND_MBX_LEN)
 	),
 
@@ -64,7 +64,7 @@ TRACE_EVENT(hclge_pf_mbx_send,
 		__entry->vfid = req->dest_vfid;
 		__entry->code = le16_to_cpu(req->msg.code);
 		__assign_str(pciname, pci_name(hdev->pdev));
-		__assign_str(devname, &hdev->vport[0].nic.kinfo.netdev->name);
+		__assign_str(devname, hdev->vport[0].nic.kinfo.netdev->name);
 		memcpy(__entry->mbx_data, req,
 		       sizeof(struct hclge_mbx_pf_to_vf_cmd));
 	),
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h
index 5d4895bb57a1..b259e95dd53c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h
@@ -23,7 +23,7 @@ TRACE_EVENT(hclge_vf_mbx_get,
 		__field(u8, vfid)
 		__field(u16, code)
 		__string(pciname, pci_name(hdev->pdev))
-		__string(devname, &hdev->nic.kinfo.netdev->name)
+		__string(devname, hdev->nic.kinfo.netdev->name)
 		__array(u32, mbx_data, VF_GET_MBX_LEN)
 	),
 
@@ -31,7 +31,7 @@ TRACE_EVENT(hclge_vf_mbx_get,
 		__entry->vfid = req->dest_vfid;
 		__entry->code = le16_to_cpu(req->msg.code);
 		__assign_str(pciname, pci_name(hdev->pdev));
-		__assign_str(devname, &hdev->nic.kinfo.netdev->name);
+		__assign_str(devname, hdev->nic.kinfo.netdev->name);
 		memcpy(__entry->mbx_data, req,
 		       sizeof(struct hclge_mbx_pf_to_vf_cmd));
 	),
@@ -55,7 +55,7 @@ TRACE_EVENT(hclge_vf_mbx_send,
 		__field(u8, code)
 		__field(u8, subcode)
 		__string(pciname, pci_name(hdev->pdev))
-		__string(devname, &hdev->nic.kinfo.netdev->name)
+		__string(devname, hdev->nic.kinfo.netdev->name)
 		__array(u32, mbx_data, VF_SEND_MBX_LEN)
 	),
 
@@ -64,7 +64,7 @@ TRACE_EVENT(hclge_vf_mbx_send,
 		__entry->code = req->msg.code;
 		__entry->subcode = req->msg.subcode;
 		__assign_str(pciname, pci_name(hdev->pdev));
-		__assign_str(devname, &hdev->nic.kinfo.netdev->name);
+		__assign_str(devname, hdev->nic.kinfo.netdev->name);
 		memcpy(__entry->mbx_data, req,
 		       sizeof(struct hclge_mbx_vf_to_pf_cmd));
 	),
diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index 9df39cf8b097..1072e2210aed 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -1443,7 +1443,7 @@ static int temac_probe(struct platform_device *pdev)
 	}
 
 	/* map device registers */
-	lp->regs = devm_platform_ioremap_resource_byname(pdev, 0);
+	lp->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(lp->regs)) {
 		dev_err(&pdev->dev, "could not map TEMAC registers\n");
 		return -ENOMEM;
diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
index e220d761b1f2..f7055180ba4a 100644
--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -164,8 +164,8 @@ get_peer(struct wg_peer *peer, struct sk_buff *skb, struct dump_ctx *ctx)
 	if (!allowedips_node)
 		goto no_allowedips;
 	if (!ctx->allowedips_seq)
-		ctx->allowedips_seq = peer->device->peer_allowedips.seq;
-	else if (ctx->allowedips_seq != peer->device->peer_allowedips.seq)
+		ctx->allowedips_seq = ctx->wg->peer_allowedips.seq;
+	else if (ctx->allowedips_seq != ctx->wg->peer_allowedips.seq)
 		goto no_allowedips;
 
 	allowedips_nest = nla_nest_start(skb, WGPEER_A_ALLOWEDIPS);
@@ -255,17 +255,17 @@ static int wg_get_device_dump(struct sk_buff *skb, struct netlink_callback *cb)
 	if (!peers_nest)
 		goto out;
 	ret = 0;
-	/* If the last cursor was removed via list_del_init in peer_remove, then
+	lockdep_assert_held(&wg->device_update_lock);
+	/* If the last cursor was removed in peer_remove or peer_remove_all, then
 	 * we just treat this the same as there being no more peers left. The
 	 * reason is that seq_nr should indicate to userspace that this isn't a
 	 * coherent dump anyway, so they'll try again.
 	 */
 	if (list_empty(&wg->peer_list) ||
-	    (ctx->next_peer && list_empty(&ctx->next_peer->peer_list))) {
+	    (ctx->next_peer && ctx->next_peer->is_dead)) {
 		nla_nest_cancel(skb, peers_nest);
 		goto out;
 	}
-	lockdep_assert_held(&wg->device_update_lock);
 	peer = list_prepare_entry(ctx->next_peer, &wg->peer_list, peer_list);
 	list_for_each_entry_continue(peer, &wg->peer_list, peer_list) {
 		if (get_peer(peer, skb, ctx)) {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/core.c
index ac3a36fa3640..a963c242975a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/core.c
@@ -7,21 +7,16 @@
 #include <core.h>
 #include <bus.h>
 #include <fwvid.h>
+#include <feature.h>
 
 #include "vops.h"
 
-static int brcmf_bca_attach(struct brcmf_pub *drvr)
+static void brcmf_bca_feat_attach(struct brcmf_if *ifp)
 {
-	pr_err("%s: executing\n", __func__);
-	return 0;
-}
-
-static void brcmf_bca_detach(struct brcmf_pub *drvr)
-{
-	pr_err("%s: executing\n", __func__);
+	/* SAE support not confirmed so disabling for now */
+	ifp->drvr->feat_flags &= ~BIT(BRCMF_FEAT_SAE);
 }
 
 const struct brcmf_fwvid_ops brcmf_bca_ops = {
-	.attach = brcmf_bca_attach,
-	.detach = brcmf_bca_detach,
+	.feat_attach = brcmf_bca_feat_attach,
 };
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 8facd40d713e..0ff15d4083e1 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -32,6 +32,7 @@
 #include "vendor.h"
 #include "bus.h"
 #include "common.h"
+#include "fwvid.h"
 
 #define BRCMF_SCAN_IE_LEN_MAX		2048
 
@@ -1179,8 +1180,7 @@ s32 brcmf_notify_escan_complete(struct brcmf_cfg80211_info *cfg,
 	scan_request = cfg->scan_request;
 	cfg->scan_request = NULL;
 
-	if (timer_pending(&cfg->escan_timeout))
-		del_timer_sync(&cfg->escan_timeout);
+	timer_delete_sync(&cfg->escan_timeout);
 
 	if (fw_abort) {
 		/* Do a scan abort to stop the driver's scan engine */
@@ -1687,52 +1687,39 @@ static u16 brcmf_map_fw_linkdown_reason(const struct brcmf_event_msg *e)
 	return reason;
 }
 
-static int brcmf_set_pmk(struct brcmf_if *ifp, const u8 *pmk_data, u16 pmk_len)
+int brcmf_set_wsec(struct brcmf_if *ifp, const u8 *key, u16 key_len, u16 flags)
 {
 	struct brcmf_pub *drvr = ifp->drvr;
 	struct brcmf_wsec_pmk_le pmk;
 	int err;
 
+	if (key_len > sizeof(pmk.key)) {
+		bphy_err(drvr, "key must be less than %zu bytes\n",
+			 sizeof(pmk.key));
+		return -EINVAL;
+	}
+
 	memset(&pmk, 0, sizeof(pmk));
 
-	/* pass pmk directly */
-	pmk.key_len = cpu_to_le16(pmk_len);
-	pmk.flags = cpu_to_le16(0);
-	memcpy(pmk.key, pmk_data, pmk_len);
+	/* pass key material directly */
+	pmk.key_len = cpu_to_le16(key_len);
+	pmk.flags = cpu_to_le16(flags);
+	memcpy(pmk.key, key, key_len);
 
-	/* store psk in firmware */
+	/* store key material in firmware */
 	err = brcmf_fil_cmd_data_set(ifp, BRCMF_C_SET_WSEC_PMK,
 				     &pmk, sizeof(pmk));
 	if (err < 0)
 		bphy_err(drvr, "failed to change PSK in firmware (len=%u)\n",
-			 pmk_len);
+			 key_len);
 
 	return err;
 }
+BRCMF_EXPORT_SYMBOL_GPL(brcmf_set_wsec);
 
-static int brcmf_set_sae_password(struct brcmf_if *ifp, const u8 *pwd_data,
-				  u16 pwd_len)
+static int brcmf_set_pmk(struct brcmf_if *ifp, const u8 *pmk_data, u16 pmk_len)
 {
-	struct brcmf_pub *drvr = ifp->drvr;
-	struct brcmf_wsec_sae_pwd_le sae_pwd;
-	int err;
-
-	if (pwd_len > BRCMF_WSEC_MAX_SAE_PASSWORD_LEN) {
-		bphy_err(drvr, "sae_password must be less than %d\n",
-			 BRCMF_WSEC_MAX_SAE_PASSWORD_LEN);
-		return -EINVAL;
-	}
-
-	sae_pwd.key_len = cpu_to_le16(pwd_len);
-	memcpy(sae_pwd.key, pwd_data, pwd_len);
-
-	err = brcmf_fil_iovar_data_set(ifp, "sae_password", &sae_pwd,
-				       sizeof(sae_pwd));
-	if (err < 0)
-		bphy_err(drvr, "failed to set SAE password in firmware (len=%u)\n",
-			 pwd_len);
-
-	return err;
+	return brcmf_set_wsec(ifp, pmk_data, pmk_len, 0);
 }
 
 static void brcmf_link_down(struct brcmf_cfg80211_vif *vif, u16 reason,
@@ -2503,8 +2490,7 @@ brcmf_cfg80211_connect(struct wiphy *wiphy, struct net_device *ndev,
 			bphy_err(drvr, "failed to clean up user-space RSNE\n");
 			goto done;
 		}
-		err = brcmf_set_sae_password(ifp, sme->crypto.sae_pwd,
-					     sme->crypto.sae_pwd_len);
+		err = brcmf_fwvid_set_sae_password(ifp, &sme->crypto);
 		if (!err && sme->crypto.psk)
 			err = brcmf_set_pmk(ifp, sme->crypto.psk,
 					    BRCMF_WSEC_MAX_PSK_LEN);
@@ -5257,8 +5243,7 @@ brcmf_cfg80211_start_ap(struct wiphy *wiphy, struct net_device *ndev,
 		if (crypto->sae_pwd) {
 			brcmf_dbg(INFO, "using SAE offload\n");
 			profile->use_fwauth |= BIT(BRCMF_PROFILE_FWAUTH_SAE);
-			err = brcmf_set_sae_password(ifp, crypto->sae_pwd,
-						     crypto->sae_pwd_len);
+			err = brcmf_fwvid_set_sae_password(ifp, crypto);
 			if (err < 0)
 				goto exit;
 		}
@@ -5365,10 +5350,12 @@ static int brcmf_cfg80211_stop_ap(struct wiphy *wiphy, struct net_device *ndev,
 		msleep(400);
 
 		if (profile->use_fwauth != BIT(BRCMF_PROFILE_FWAUTH_NONE)) {
+			struct cfg80211_crypto_settings crypto = {};
+
 			if (profile->use_fwauth & BIT(BRCMF_PROFILE_FWAUTH_PSK))
 				brcmf_set_pmk(ifp, NULL, 0);
 			if (profile->use_fwauth & BIT(BRCMF_PROFILE_FWAUTH_SAE))
-				brcmf_set_sae_password(ifp, NULL, 0);
+				brcmf_fwvid_set_sae_password(ifp, &crypto);
 			profile->use_fwauth = BIT(BRCMF_PROFILE_FWAUTH_NONE);
 		}
 
@@ -8440,6 +8427,7 @@ void brcmf_cfg80211_detach(struct brcmf_cfg80211_info *cfg)
 	brcmf_btcoex_detach(cfg);
 	wiphy_unregister(cfg->wiphy);
 	wl_deinit_priv(cfg);
+	cancel_work_sync(&cfg->escan_timeout_work);
 	brcmf_free_wiphy(cfg->wiphy);
 	kfree(cfg);
 }
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
index 0e1fa3f0dea2..dc3a6a537507 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
@@ -468,4 +468,6 @@ void brcmf_set_mpc(struct brcmf_if *ndev, int mpc);
 void brcmf_abort_scanning(struct brcmf_cfg80211_info *cfg);
 void brcmf_cfg80211_free_netdev(struct net_device *ndev);
 
+int brcmf_set_wsec(struct brcmf_if *ifp, const u8 *key, u16 key_len, u16 flags);
+
 #endif /* BRCMFMAC_CFG80211_H */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
index b75652ba9359..bec5748310b9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
@@ -7,21 +7,36 @@
 #include <core.h>
 #include <bus.h>
 #include <fwvid.h>
+#include <fwil.h>
 
 #include "vops.h"
 
-static int brcmf_cyw_attach(struct brcmf_pub *drvr)
+static int brcmf_cyw_set_sae_pwd(struct brcmf_if *ifp,
+				 struct cfg80211_crypto_settings *crypto)
 {
-	pr_err("%s: executing\n", __func__);
-	return 0;
-}
+	struct brcmf_pub *drvr = ifp->drvr;
+	struct brcmf_wsec_sae_pwd_le sae_pwd;
+	u16 pwd_len = crypto->sae_pwd_len;
+	int err;
 
-static void brcmf_cyw_detach(struct brcmf_pub *drvr)
-{
-	pr_err("%s: executing\n", __func__);
+	if (pwd_len > BRCMF_WSEC_MAX_SAE_PASSWORD_LEN) {
+		bphy_err(drvr, "sae_password must be less than %d\n",
+			 BRCMF_WSEC_MAX_SAE_PASSWORD_LEN);
+		return -EINVAL;
+	}
+
+	sae_pwd.key_len = cpu_to_le16(pwd_len);
+	memcpy(sae_pwd.key, crypto->sae_pwd, pwd_len);
+
+	err = brcmf_fil_iovar_data_set(ifp, "sae_password", &sae_pwd,
+				       sizeof(sae_pwd));
+	if (err < 0)
+		bphy_err(drvr, "failed to set SAE password in firmware (len=%u)\n",
+			 pwd_len);
+
+	return err;
 }
 
 const struct brcmf_fwvid_ops brcmf_cyw_ops = {
-	.attach = brcmf_cyw_attach,
-	.detach = brcmf_cyw_detach,
+	.set_sae_password = brcmf_cyw_set_sae_pwd,
 };
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
index 6d10c9efbe93..909a34a1ab50 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
@@ -13,6 +13,7 @@
 #include "debug.h"
 #include "fwil.h"
 #include "fwil_types.h"
+#include "fwvid.h"
 #include "feature.h"
 #include "common.h"
 
@@ -339,6 +340,8 @@ void brcmf_feat_attach(struct brcmf_pub *drvr)
 	brcmf_feat_iovar_int_get(ifp, BRCMF_FEAT_FWSUP, "sup_wpa");
 	brcmf_feat_iovar_int_get(ifp, BRCMF_FEAT_SCAN_V2, "scan_ver");
 
+	brcmf_fwvid_feat_attach(ifp);
+
 	if (drvr->settings->feature_disable) {
 		brcmf_dbg(INFO, "Features: 0x%02x, disable: 0x%02x\n",
 			  ifp->drvr->feat_flags,
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c
index 72fe8bce6eaf..a9514d72f770 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c
@@ -239,6 +239,7 @@ brcmf_fil_iovar_data_set(struct brcmf_if *ifp, const char *name, const void *dat
 	mutex_unlock(&drvr->proto_block);
 	return err;
 }
+BRCMF_EXPORT_SYMBOL_GPL(brcmf_fil_iovar_data_set);
 
 s32
 brcmf_fil_iovar_data_get(struct brcmf_if *ifp, const char *name, void *data,
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
index 9d248ba1c0b2..e74a23e11830 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
@@ -584,7 +584,7 @@ struct brcmf_wsec_key_le {
 struct brcmf_wsec_pmk_le {
 	__le16  key_len;
 	__le16  flags;
-	u8 key[2 * BRCMF_WSEC_MAX_PSK_LEN + 1];
+	u8 key[BRCMF_WSEC_MAX_SAE_PASSWORD_LEN];
 };
 
 /**
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
index 86eafdb40541..b427782554b5 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
@@ -89,8 +89,7 @@ int brcmf_fwvid_register_vendor(enum brcmf_fwvendor fwvid, struct module *vmod,
 	if (fwvid >= BRCMF_FWVENDOR_NUM)
 		return -ERANGE;
 
-	if (WARN_ON(!vmod) || WARN_ON(!vops) ||
-	    WARN_ON(!vops->attach) || WARN_ON(!vops->detach))
+	if (WARN_ON(!vmod) || WARN_ON(!vops))
 		return -EINVAL;
 
 	if (WARN_ON(fwvid_list[fwvid].vmod))
@@ -150,7 +149,7 @@ static inline int brcmf_fwvid_request_module(enum brcmf_fwvendor fwvid)
 }
 #endif
 
-int brcmf_fwvid_attach_ops(struct brcmf_pub *drvr)
+int brcmf_fwvid_attach(struct brcmf_pub *drvr)
 {
 	enum brcmf_fwvendor fwvid = drvr->bus_if->fwvid;
 	int ret;
@@ -175,7 +174,7 @@ int brcmf_fwvid_attach_ops(struct brcmf_pub *drvr)
 	return ret;
 }
 
-void brcmf_fwvid_detach_ops(struct brcmf_pub *drvr)
+void brcmf_fwvid_detach(struct brcmf_pub *drvr)
 {
 	enum brcmf_fwvendor fwvid = drvr->bus_if->fwvid;
 
@@ -187,9 +186,10 @@ void brcmf_fwvid_detach_ops(struct brcmf_pub *drvr)
 
 	mutex_lock(&fwvid_list_lock);
 
-	drvr->vops = NULL;
-	list_del(&drvr->bus_if->list);
-
+	if (drvr->vops) {
+		drvr->vops = NULL;
+		list_del(&drvr->bus_if->list);
+	}
 	mutex_unlock(&fwvid_list_lock);
 }
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
index 43df58bb70ad..dac22534d033 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
@@ -6,12 +6,14 @@
 #define FWVID_H_
 
 #include "firmware.h"
+#include "cfg80211.h"
 
 struct brcmf_pub;
+struct brcmf_if;
 
 struct brcmf_fwvid_ops {
-	int (*attach)(struct brcmf_pub *drvr);
-	void (*detach)(struct brcmf_pub *drvr);
+	void (*feat_attach)(struct brcmf_if *ifp);
+	int (*set_sae_password)(struct brcmf_if *ifp, struct cfg80211_crypto_settings *crypto);
 };
 
 /* exported functions */
@@ -20,28 +22,29 @@ int brcmf_fwvid_register_vendor(enum brcmf_fwvendor fwvid, struct module *mod,
 int brcmf_fwvid_unregister_vendor(enum brcmf_fwvendor fwvid, struct module *mod);
 
 /* core driver functions */
-int brcmf_fwvid_attach_ops(struct brcmf_pub *drvr);
-void brcmf_fwvid_detach_ops(struct brcmf_pub *drvr);
+int brcmf_fwvid_attach(struct brcmf_pub *drvr);
+void brcmf_fwvid_detach(struct brcmf_pub *drvr);
 const char *brcmf_fwvid_vendor_name(struct brcmf_pub *drvr);
 
-static inline int brcmf_fwvid_attach(struct brcmf_pub *drvr)
+static inline void brcmf_fwvid_feat_attach(struct brcmf_if *ifp)
 {
-	int ret;
+	const struct brcmf_fwvid_ops *vops = ifp->drvr->vops;
 
-	ret = brcmf_fwvid_attach_ops(drvr);
-	if (ret)
-		return ret;
+	if (!vops->feat_attach)
+		return;
 
-	return drvr->vops->attach(drvr);
+	vops->feat_attach(ifp);
 }
 
-static inline void brcmf_fwvid_detach(struct brcmf_pub *drvr)
+static inline int brcmf_fwvid_set_sae_password(struct brcmf_if *ifp,
+					       struct cfg80211_crypto_settings *crypto)
 {
-	if (!drvr->vops)
-		return;
+	const struct brcmf_fwvid_ops *vops = ifp->drvr->vops;
+
+	if (!vops || !vops->set_sae_password)
+		return -EOPNOTSUPP;
 
-	drvr->vops->detach(drvr);
-	brcmf_fwvid_detach_ops(drvr);
+	return vops->set_sae_password(ifp, crypto);
 }
 
 #endif /* FWVID_H_ */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c
index 5573a47766ad..fd593b93ad40 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c
@@ -7,21 +7,17 @@
 #include <core.h>
 #include <bus.h>
 #include <fwvid.h>
+#include <cfg80211.h>
 
 #include "vops.h"
 
-static int brcmf_wcc_attach(struct brcmf_pub *drvr)
+static int brcmf_wcc_set_sae_pwd(struct brcmf_if *ifp,
+				 struct cfg80211_crypto_settings *crypto)
 {
-	pr_debug("%s: executing\n", __func__);
-	return 0;
-}
-
-static void brcmf_wcc_detach(struct brcmf_pub *drvr)
-{
-	pr_debug("%s: executing\n", __func__);
+	return brcmf_set_wsec(ifp, crypto->sae_pwd, crypto->sae_pwd_len,
+			      BRCMF_WSEC_PASSPHRASE);
 }
 
 const struct brcmf_fwvid_ops brcmf_wcc_ops = {
-	.attach = brcmf_wcc_attach,
-	.detach = brcmf_wcc_detach,
+	.set_sae_password = brcmf_wcc_set_sae_pwd,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 3975a53a9f20..57ddd8aefa42 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -3075,8 +3075,6 @@ static void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 	struct iwl_fw_dbg_params params = {0};
 	struct iwl_fwrt_dump_data *dump_data =
 		&fwrt->dump.wks[wk_idx].dump_data;
-	u32 policy;
-	u32 time_point;
 	if (!test_bit(wk_idx, &fwrt->dump.active_wks))
 		return;
 
@@ -3107,13 +3105,16 @@ static void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 
 	iwl_fw_dbg_stop_restart_recording(fwrt, &params, false);
 
-	policy = le32_to_cpu(dump_data->trig->apply_policy);
-	time_point = le32_to_cpu(dump_data->trig->time_point);
+	if (iwl_trans_dbg_ini_valid(fwrt->trans)) {
+		u32 policy = le32_to_cpu(dump_data->trig->apply_policy);
+		u32 time_point = le32_to_cpu(dump_data->trig->time_point);
 
-	if (policy & IWL_FW_INI_APPLY_POLICY_DUMP_COMPLETE_CMD) {
-		IWL_DEBUG_FW_INFO(fwrt, "WRT: sending dump complete\n");
-		iwl_send_dbg_dump_complete_cmd(fwrt, time_point, 0);
+		if (policy & IWL_FW_INI_APPLY_POLICY_DUMP_COMPLETE_CMD) {
+			IWL_DEBUG_FW_INFO(fwrt, "WRT: sending dump complete\n");
+			iwl_send_dbg_dump_complete_cmd(fwrt, time_point, 0);
+		}
 	}
+
 	if (fwrt->trans->dbg.last_tp_resetfw == IWL_FW_INI_RESET_FW_MODE_STOP_FW_ONLY)
 		iwl_force_nmi(fwrt->trans);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
index e8b881596baf..34b8771d1eda 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
@@ -735,7 +735,9 @@ void iwl_mvm_vif_dbgfs_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
 	struct dentry *dbgfs_dir = vif->debugfs_dir;
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	char buf[100];
+	char buf[3 * 3 + 11 + (NL80211_WIPHY_NAME_MAXLEN + 1) +
+		 (7 + IFNAMSIZ + 1) + 6 + 1];
+	char name[7 + IFNAMSIZ + 1];
 
 	/* this will happen in monitor mode */
 	if (!dbgfs_dir)
@@ -748,10 +750,11 @@ void iwl_mvm_vif_dbgfs_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	 * find
 	 * netdev:wlan0 -> ../../../ieee80211/phy0/netdev:wlan0/iwlmvm/
 	 */
-	snprintf(buf, 100, "../../../%pd3/iwlmvm", dbgfs_dir);
+	snprintf(name, sizeof(name), "%pd", dbgfs_dir);
+	snprintf(buf, sizeof(buf), "../../../%pd3/iwlmvm", dbgfs_dir);
 
-	mvmvif->dbgfs_slink = debugfs_create_symlink(dbgfs_dir->d_name.name,
-						     mvm->debugfs_dir, buf);
+	mvmvif->dbgfs_slink =
+		debugfs_create_symlink(name, mvm->debugfs_dir, buf);
 }
 
 void iwl_mvm_vif_dbgfs_rm_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 68c3d54f587c..168e4a2ffeb5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -344,7 +344,7 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 	if (mvm->mld_api_is_used && mvm->nvm_data->sku_cap_11be_enable &&
 	    !iwlwifi_mod_params.disable_11ax &&
 	    !iwlwifi_mod_params.disable_11be)
-		hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO;
+		hw->wiphy->flags |= WIPHY_FLAG_DISABLE_WEXT;
 
 	/* With MLD FW API, it tracks timing by itself,
 	 * no need for any timing from the host
diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index 298663b03580..0c1c1ff31085 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -309,6 +309,13 @@ static int rtw_mac_power_switch(struct rtw_dev *rtwdev, bool pwr_on)
 	pwr_seq = pwr_on ? chip->pwr_on_seq : chip->pwr_off_seq;
 	ret = rtw_pwr_seq_parser(rtwdev, pwr_seq);
 
+	if (pwr_on && rtw_hci_type(rtwdev) == RTW_HCI_TYPE_USB) {
+		if (chip->id == RTW_CHIP_TYPE_8822C ||
+		    chip->id == RTW_CHIP_TYPE_8822B ||
+		    chip->id == RTW_CHIP_TYPE_8821C)
+			rtw_write8_clr(rtwdev, REG_SYS_STATUS1 + 1, BIT(0));
+	}
+
 	if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_SDIO)
 		rtw_write32(rtwdev, REG_SDIO_HIMR, imr);
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821cu.c b/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
index 7a5cbdc31ef7..e2c7d9f87683 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
@@ -9,24 +9,36 @@
 #include "usb.h"
 
 static const struct usb_device_id rtw_8821cu_id_table[] = {
-	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xb82b, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* 8821CU */
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0x2006, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0x8731, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0x8811, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xb820, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* 8821CU */
-	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc821, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* 8821CU */
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xb82b, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc80c, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc811, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc820, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* 8821CU */
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc821, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc82a, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* 8821CU */
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc82b, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* 8821CU */
-	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc811, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* 8811CU */
-	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0x8811, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* 8811CU */
-	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0x2006, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* TOTOLINK A650UA v3 */
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc82c, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x331d, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* D-Link */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xc811, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* Edimax */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xd811, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* Edimax */
 	{},
 };
 MODULE_DEVICE_TABLE(usb, rtw_8821cu_id_table);
diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index b922df99f9bc..33678d0af2c2 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -47,7 +47,6 @@ static int meson_efuse_probe(struct platform_device *pdev)
 	struct nvmem_config *econfig;
 	struct clk *clk;
 	unsigned int size;
-	int ret;
 
 	sm_np = of_parse_phandle(pdev->dev.of_node, "secure-monitor", 0);
 	if (!sm_np) {
@@ -60,27 +59,9 @@ static int meson_efuse_probe(struct platform_device *pdev)
 	if (!fw)
 		return -EPROBE_DEFER;
 
-	clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get efuse gate");
-		return ret;
-	}
-
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		dev_err(dev, "failed to enable gate");
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(dev,
-				       (void(*)(void *))clk_disable_unprepare,
-				       clk);
-	if (ret) {
-		dev_err(dev, "failed to add disable callback");
-		return ret;
-	}
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "failed to get efuse gate");
 
 	if (meson_sm_call(fw, SM_EFUSE_USER_MAX, &size, 0, 0, 0, 0, 0) < 0) {
 		dev_err(dev, "failed to get max user");
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index c2630db74560..19b6708f60ef 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -692,8 +692,13 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 		nbars = (reg & PCI_REBAR_CTRL_NBAR_MASK) >>
 			PCI_REBAR_CTRL_NBAR_SHIFT;
 
+		/*
+		 * PCIe r6.0, sec 7.8.6.2 require us to support at least one
+		 * size in the range from 1 MB to 512 GB. Advertise support
+		 * for 1 MB BAR size only.
+		 */
 		for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL)
-			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, 0x0);
+			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, BIT(4));
 	}
 
 	/*
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index cbc3f0881770..e3dc27f2acf7 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -53,6 +53,7 @@
 #define PARF_SLV_ADDR_SPACE_SIZE		0x358
 #define PARF_DEVICE_TYPE			0x1000
 #define PARF_BDF_TO_SID_TABLE_N			0x2000
+#define PARF_BDF_TO_SID_CFG			0x2c00
 
 /* ELBI registers */
 #define ELBI_SYS_CTRL				0x04
@@ -120,6 +121,9 @@
 /* PARF_DEVICE_TYPE register fields */
 #define DEVICE_TYPE_RC				0x4
 
+/* PARF_BDF_TO_SID_CFG fields */
+#define BDF_TO_SID_BYPASS			BIT(0)
+
 /* ELBI_SYS_CTRL register fields */
 #define ELBI_SYS_CTRL_LT_ENABLE			BIT(0)
 
@@ -229,6 +233,7 @@ struct qcom_pcie_ops {
 
 struct qcom_pcie_cfg {
 	const struct qcom_pcie_ops *ops;
+	bool no_l0s;
 };
 
 struct qcom_pcie {
@@ -272,6 +277,26 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
 	return 0;
 }
 
+static void qcom_pcie_clear_aspm_l0s(struct dw_pcie *pci)
+{
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+	u16 offset;
+	u32 val;
+
+	if (!pcie->cfg->no_l0s)
+		return;
+
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+
+	dw_pcie_dbi_ro_wr_en(pci);
+
+	val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
+	val &= ~PCI_EXP_LNKCAP_ASPM_L0S;
+	writel(val, pci->dbi_base + offset + PCI_EXP_LNKCAP);
+
+	dw_pcie_dbi_ro_wr_dis(pci);
+}
+
 static void qcom_pcie_clear_hpc(struct dw_pcie *pci)
 {
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
@@ -961,6 +986,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 
 static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 {
+	qcom_pcie_clear_aspm_l0s(pcie->pci);
 	qcom_pcie_clear_hpc(pcie->pci);
 
 	return 0;
@@ -1008,11 +1034,17 @@ static int qcom_pcie_config_sid_1_9_0(struct qcom_pcie *pcie)
 	u8 qcom_pcie_crc8_table[CRC8_TABLE_SIZE];
 	int i, nr_map, size = 0;
 	u32 smmu_sid_base;
+	u32 val;
 
 	of_get_property(dev->of_node, "iommu-map", &size);
 	if (!size)
 		return 0;
 
+	/* Enable BDF to SID translation by disabling bypass mode (default) */
+	val = readl(pcie->parf + PARF_BDF_TO_SID_CFG);
+	val &= ~BDF_TO_SID_BYPASS;
+	writel(val, pcie->parf + PARF_BDF_TO_SID_CFG);
+
 	map = kzalloc(size, GFP_KERNEL);
 	if (!map)
 		return -ENOMEM;
@@ -1358,6 +1390,11 @@ static const struct qcom_pcie_cfg cfg_2_9_0 = {
 	.ops = &ops_2_9_0,
 };
 
+static const struct qcom_pcie_cfg cfg_sc8280xp = {
+	.ops = &ops_1_9_0,
+	.no_l0s = true,
+};
+
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 	.start_link = qcom_pcie_start_link,
@@ -1629,11 +1666,11 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
 	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
 	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
-	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_1_9_0 },
+	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_sc8280xp },
 	{ .compatible = "qcom,pcie-sa8775p", .data = &cfg_1_9_0},
 	{ .compatible = "qcom,pcie-sc7280", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sc8180x", .data = &cfg_1_9_0 },
-	{ .compatible = "qcom,pcie-sc8280xp", .data = &cfg_1_9_0 },
+	{ .compatible = "qcom,pcie-sc8280xp", .data = &cfg_sc8280xp },
 	{ .compatible = "qcom,pcie-sdm845", .data = &cfg_2_7_0 },
 	{ .compatible = "qcom,pcie-sdx55", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8150", .data = &cfg_1_9_0 },
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 30c7dfeccb16..11cc354a30ea 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -49,6 +49,7 @@
 #include <linux/refcount.h>
 #include <linux/irqdomain.h>
 #include <linux/acpi.h>
+#include <linux/sizes.h>
 #include <asm/mshyperv.h>
 
 /*
@@ -465,7 +466,7 @@ struct pci_eject_response {
 	u32 status;
 } __packed;
 
-static int pci_ring_size = (4 * PAGE_SIZE);
+static int pci_ring_size = VMBUS_RING_SIZE(SZ_16K);
 
 /*
  * Driver specific state.
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 51ec9e7e784f..9c59bf03d657 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -473,6 +473,13 @@ static void pci_device_remove(struct device *dev)
 
 	if (drv->remove) {
 		pm_runtime_get_sync(dev);
+		/*
+		 * If the driver provides a .runtime_idle() callback and it has
+		 * started to run already, it may continue to run in parallel
+		 * with the code below, so wait until all of the runtime PM
+		 * activity has completed.
+		 */
+		pm_runtime_barrier(dev);
 		drv->remove(pci_dev);
 		pm_runtime_put_noidle(dev);
 	}
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 59c90d04a609..705893b5f7b0 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -13,6 +13,7 @@
 #define dev_fmt(fmt) "AER: " fmt
 
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -85,6 +86,18 @@ static int report_error_detected(struct pci_dev *dev,
 	return 0;
 }
 
+static int pci_pm_runtime_get_sync(struct pci_dev *pdev, void *data)
+{
+	pm_runtime_get_sync(&pdev->dev);
+	return 0;
+}
+
+static int pci_pm_runtime_put(struct pci_dev *pdev, void *data)
+{
+	pm_runtime_put(&pdev->dev);
+	return 0;
+}
+
 static int report_frozen_detected(struct pci_dev *dev, void *data)
 {
 	return report_error_detected(dev, pci_channel_io_frozen, data);
@@ -207,6 +220,8 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	else
 		bridge = pci_upstream_bridge(dev);
 
+	pci_walk_bridge(bridge, pci_pm_runtime_get_sync, NULL);
+
 	pci_dbg(bridge, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
 		pci_walk_bridge(bridge, report_frozen_detected, &status);
@@ -251,10 +266,15 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		pcie_clear_device_status(dev);
 		pci_aer_clear_nonfatal_status(dev);
 	}
+
+	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
+
 	pci_info(bridge, "device recovery successful\n");
 	return status;
 
 failed:
+	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
+
 	pci_uevent_ers(bridge, PCI_ERS_RESULT_DISCONNECT);
 
 	/* TODO: Should kernel panic here? */
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 528044237bf9..fa770601c655 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6219,6 +6219,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2b, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa73f, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa76e, dpc_log_size);
 #endif
 
 /*
diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 142ebe0247cc..983a6e6173bd 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -1531,6 +1531,19 @@ int tegra_xusb_padctl_get_usb3_companion(struct tegra_xusb_padctl *padctl,
 }
 EXPORT_SYMBOL_GPL(tegra_xusb_padctl_get_usb3_companion);
 
+int tegra_xusb_padctl_get_port_number(struct phy *phy)
+{
+	struct tegra_xusb_lane *lane;
+
+	if (!phy)
+		return -ENODEV;
+
+	lane = phy_get_drvdata(phy);
+
+	return lane->index;
+}
+EXPORT_SYMBOL_GPL(tegra_xusb_padctl_get_port_number);
+
 MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
 MODULE_DESCRIPTION("Tegra XUSB Pad Controller driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
index 311abcac894a..c2f6e20b45bc 100644
--- a/drivers/platform/x86/intel/tpmi.c
+++ b/drivers/platform/x86/intel/tpmi.c
@@ -96,7 +96,7 @@ struct intel_tpmi_pfs_entry {
  */
 struct intel_tpmi_pm_feature {
 	struct intel_tpmi_pfs_entry pfs_header;
-	unsigned int vsec_offset;
+	u64 vsec_offset;
 	struct intel_vsec_device *vsec_dev;
 };
 
@@ -389,7 +389,7 @@ static int tpmi_pfs_dbg_show(struct seq_file *s, void *unused)
 			read_blocked = feature_state.read_blocked ? 'Y' : 'N';
 			write_blocked = feature_state.write_blocked ? 'Y' : 'N';
 		}
-		seq_printf(s, "0x%02x\t\t0x%02x\t\t0x%04x\t\t0x%04x\t\t0x%02x\t\t0x%08x\t%c\t%c\t\t%c\t\t%c\n",
+		seq_printf(s, "0x%02x\t\t0x%02x\t\t0x%04x\t\t0x%04x\t\t0x%02x\t\t0x%016llx\t%c\t%c\t\t%c\t\t%c\n",
 			   pfs->pfs_header.tpmi_id, pfs->pfs_header.num_entries,
 			   pfs->pfs_header.entry_size, pfs->pfs_header.cap_offset,
 			   pfs->pfs_header.attribute, pfs->vsec_offset, locked, disabled,
@@ -408,7 +408,8 @@ static int tpmi_mem_dump_show(struct seq_file *s, void *unused)
 	struct intel_tpmi_pm_feature *pfs = s->private;
 	int count, ret = 0;
 	void __iomem *mem;
-	u32 off, size;
+	u32 size;
+	u64 off;
 	u8 *buffer;
 
 	size = TPMI_GET_SINGLE_ENTRY_SIZE(pfs);
@@ -424,7 +425,7 @@ static int tpmi_mem_dump_show(struct seq_file *s, void *unused)
 	mutex_lock(&tpmi_dev_lock);
 
 	for (count = 0; count < pfs->pfs_header.num_entries; ++count) {
-		seq_printf(s, "TPMI Instance:%d offset:0x%x\n", count, off);
+		seq_printf(s, "TPMI Instance:%d offset:0x%llx\n", count, off);
 
 		mem = ioremap(off, size);
 		if (!mem) {
diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 2feed036c1cd..9d3e102f1a76 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -5,6 +5,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/cleanup.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/list.h>
@@ -759,6 +760,11 @@ static int rapl_config(struct rapl_package *rp)
 	default:
 		return -EINVAL;
 	}
+
+	/* defaults_msr can be NULL on unsupported platforms */
+	if (!rp->priv->defaults || !rp->priv->rpi)
+		return -ENODEV;
+
 	return 0;
 }
 
@@ -1499,7 +1505,7 @@ static int rapl_detect_domains(struct rapl_package *rp)
 }
 
 /* called from CPU hotplug notifier, hotplug lock held */
-void rapl_remove_package(struct rapl_package *rp)
+void rapl_remove_package_cpuslocked(struct rapl_package *rp)
 {
 	struct rapl_domain *rd, *rd_package = NULL;
 
@@ -1528,10 +1534,18 @@ void rapl_remove_package(struct rapl_package *rp)
 	list_del(&rp->plist);
 	kfree(rp);
 }
+EXPORT_SYMBOL_GPL(rapl_remove_package_cpuslocked);
+
+void rapl_remove_package(struct rapl_package *rp)
+{
+	guard(cpus_read_lock)();
+	rapl_remove_package_cpuslocked(rp);
+}
 EXPORT_SYMBOL_GPL(rapl_remove_package);
 
 /* caller to ensure CPU hotplug lock is held */
-struct rapl_package *rapl_find_package_domain(int id, struct rapl_if_priv *priv, bool id_is_cpu)
+struct rapl_package *rapl_find_package_domain_cpuslocked(int id, struct rapl_if_priv *priv,
+							 bool id_is_cpu)
 {
 	struct rapl_package *rp;
 	int uid;
@@ -1549,10 +1563,17 @@ struct rapl_package *rapl_find_package_domain(int id, struct rapl_if_priv *priv,
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(rapl_find_package_domain_cpuslocked);
+
+struct rapl_package *rapl_find_package_domain(int id, struct rapl_if_priv *priv, bool id_is_cpu)
+{
+	guard(cpus_read_lock)();
+	return rapl_find_package_domain_cpuslocked(id, priv, id_is_cpu);
+}
 EXPORT_SYMBOL_GPL(rapl_find_package_domain);
 
 /* called from CPU hotplug notifier, hotplug lock held */
-struct rapl_package *rapl_add_package(int id, struct rapl_if_priv *priv, bool id_is_cpu)
+struct rapl_package *rapl_add_package_cpuslocked(int id, struct rapl_if_priv *priv, bool id_is_cpu)
 {
 	struct rapl_package *rp;
 	int ret;
@@ -1598,6 +1619,13 @@ struct rapl_package *rapl_add_package(int id, struct rapl_if_priv *priv, bool id
 	kfree(rp);
 	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL_GPL(rapl_add_package_cpuslocked);
+
+struct rapl_package *rapl_add_package(int id, struct rapl_if_priv *priv, bool id_is_cpu)
+{
+	guard(cpus_read_lock)();
+	return rapl_add_package_cpuslocked(id, priv, id_is_cpu);
+}
 EXPORT_SYMBOL_GPL(rapl_add_package);
 
 static void power_limit_state_save(void)
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 250bd41a588c..b4b6930cacb0 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -73,9 +73,9 @@ static int rapl_cpu_online(unsigned int cpu)
 {
 	struct rapl_package *rp;
 
-	rp = rapl_find_package_domain(cpu, rapl_msr_priv, true);
+	rp = rapl_find_package_domain_cpuslocked(cpu, rapl_msr_priv, true);
 	if (!rp) {
-		rp = rapl_add_package(cpu, rapl_msr_priv, true);
+		rp = rapl_add_package_cpuslocked(cpu, rapl_msr_priv, true);
 		if (IS_ERR(rp))
 			return PTR_ERR(rp);
 	}
@@ -88,14 +88,14 @@ static int rapl_cpu_down_prep(unsigned int cpu)
 	struct rapl_package *rp;
 	int lead_cpu;
 
-	rp = rapl_find_package_domain(cpu, rapl_msr_priv, true);
+	rp = rapl_find_package_domain_cpuslocked(cpu, rapl_msr_priv, true);
 	if (!rp)
 		return 0;
 
 	cpumask_clear_cpu(cpu, &rp->cpumask);
 	lead_cpu = cpumask_first(&rp->cpumask);
 	if (lead_cpu >= nr_cpu_ids)
-		rapl_remove_package(rp);
+		rapl_remove_package_cpuslocked(rp);
 	else if (rp->lead_cpu == cpu)
 		rp->lead_cpu = lead_cpu;
 	return 0;
diff --git a/drivers/powercap/intel_rapl_tpmi.c b/drivers/powercap/intel_rapl_tpmi.c
index 891c90fefd8b..f6b7f085977c 100644
--- a/drivers/powercap/intel_rapl_tpmi.c
+++ b/drivers/powercap/intel_rapl_tpmi.c
@@ -40,6 +40,7 @@ enum tpmi_rapl_register {
 	TPMI_RAPL_REG_ENERGY_STATUS,
 	TPMI_RAPL_REG_PERF_STATUS,
 	TPMI_RAPL_REG_POWER_INFO,
+	TPMI_RAPL_REG_DOMAIN_INFO,
 	TPMI_RAPL_REG_INTERRUPT,
 	TPMI_RAPL_REG_MAX = 15,
 };
@@ -130,6 +131,12 @@ static void trp_release(struct tpmi_rapl_package *trp)
 	mutex_unlock(&tpmi_rapl_lock);
 }
 
+/*
+ * Bit 0 of TPMI_RAPL_REG_DOMAIN_INFO indicates if the current package is a domain
+ * root or not. Only domain root packages can enumerate System (Psys) Domain.
+ */
+#define TPMI_RAPL_DOMAIN_ROOT	BIT(0)
+
 static int parse_one_domain(struct tpmi_rapl_package *trp, u32 offset)
 {
 	u8 tpmi_domain_version;
@@ -139,6 +146,7 @@ static int parse_one_domain(struct tpmi_rapl_package *trp, u32 offset)
 	enum rapl_domain_reg_id reg_id;
 	int tpmi_domain_size, tpmi_domain_flags;
 	u64 tpmi_domain_header = readq(trp->base + offset);
+	u64 tpmi_domain_info;
 
 	/* Domain Parent bits are ignored for now */
 	tpmi_domain_version = tpmi_domain_header & 0xff;
@@ -169,6 +177,13 @@ static int parse_one_domain(struct tpmi_rapl_package *trp, u32 offset)
 		domain_type = RAPL_DOMAIN_PACKAGE;
 		break;
 	case TPMI_RAPL_DOMAIN_SYSTEM:
+		if (!(tpmi_domain_flags & BIT(TPMI_RAPL_REG_DOMAIN_INFO))) {
+			pr_warn(FW_BUG "System domain must support Domain Info register\n");
+			return -ENODEV;
+		}
+		tpmi_domain_info = readq(trp->base + offset + TPMI_RAPL_REG_DOMAIN_INFO);
+		if (!(tpmi_domain_info & TPMI_RAPL_DOMAIN_ROOT))
+			return 0;
 		domain_type = RAPL_DOMAIN_PLATFORM;
 		break;
 	case TPMI_RAPL_DOMAIN_MEMORY:
diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index 116fa060e302..29dcf38f3b52 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -288,9 +288,9 @@ static int img_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(imgchip->sys_clk);
 	}
 
-	imgchip->pwm_clk = devm_clk_get(&pdev->dev, "imgchip");
+	imgchip->pwm_clk = devm_clk_get(&pdev->dev, "pwm");
 	if (IS_ERR(imgchip->pwm_clk)) {
-		dev_err(&pdev->dev, "failed to get imgchip clock\n");
+		dev_err(&pdev->dev, "failed to get pwm clock\n");
 		return PTR_ERR(imgchip->pwm_clk);
 	}
 
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index 83d76915a6ad..25b66b113b69 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -351,6 +351,9 @@ static void rproc_virtio_dev_release(struct device *dev)
 
 	kfree(vdev);
 
+	of_reserved_mem_device_release(&rvdev->pdev->dev);
+	dma_release_coherent_memory(&rvdev->pdev->dev);
+
 	put_device(&rvdev->pdev->dev);
 }
 
@@ -584,9 +587,6 @@ static void rproc_virtio_remove(struct platform_device *pdev)
 	rproc_remove_subdev(rproc, &rvdev->subdev);
 	rproc_remove_rvdev(rvdev);
 
-	of_reserved_mem_device_release(&pdev->dev);
-	dma_release_coherent_memory(&pdev->dev);
-
 	put_device(&rproc->dev);
 }
 
diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_chp.c
index d3f3a611f95b..38c176cf6295 100644
--- a/drivers/s390/cio/vfio_ccw_chp.c
+++ b/drivers/s390/cio/vfio_ccw_chp.c
@@ -115,7 +115,7 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private,
 
 	/* Notify the guest if more CRWs are on our queue */
 	if (!list_empty(&private->crw) && private->crw_trigger)
-		eventfd_signal(private->crw_trigger, 1);
+		eventfd_signal(private->crw_trigger);
 
 	return ret;
 }
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 43601816ea4e..bfb35cfce1ef 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -112,7 +112,7 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
 		private->state = VFIO_CCW_STATE_IDLE;
 
 	if (private->io_trigger)
-		eventfd_signal(private->io_trigger, 1);
+		eventfd_signal(private->io_trigger);
 }
 
 void vfio_ccw_crw_todo(struct work_struct *work)
@@ -122,7 +122,7 @@ void vfio_ccw_crw_todo(struct work_struct *work)
 	private = container_of(work, struct vfio_ccw_private, crw_work);
 
 	if (!list_empty(&private->crw) && private->crw_trigger)
-		eventfd_signal(private->crw_trigger, 1);
+		eventfd_signal(private->crw_trigger);
 }
 
 /*
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index cba4971618ff..ea532a8a4a0c 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -421,7 +421,7 @@ static int vfio_ccw_mdev_set_irqs(struct vfio_ccw_private *private,
 	case VFIO_IRQ_SET_DATA_NONE:
 	{
 		if (*ctx)
-			eventfd_signal(*ctx, 1);
+			eventfd_signal(*ctx);
 		return 0;
 	}
 	case VFIO_IRQ_SET_DATA_BOOL:
@@ -432,7 +432,7 @@ static int vfio_ccw_mdev_set_irqs(struct vfio_ccw_private *private,
 			return -EFAULT;
 
 		if (trigger && *ctx)
-			eventfd_signal(*ctx, 1);
+			eventfd_signal(*ctx);
 		return 0;
 	}
 	case VFIO_IRQ_SET_DATA_EVENTFD:
@@ -612,7 +612,7 @@ static void vfio_ccw_mdev_request(struct vfio_device *vdev, unsigned int count)
 					       "Relaying device request to user (#%u)\n",
 					       count);
 
-		eventfd_signal(private->req_trigger, 1);
+		eventfd_signal(private->req_trigger);
 	} else if (count == 0) {
 		dev_notice(dev,
 			   "No device request channel registered, blocked until released by user\n");
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index d6ea2fd4c2a0..76429585c1bc 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1862,7 +1862,7 @@ static void vfio_ap_mdev_request(struct vfio_device *vdev, unsigned int count)
 					       "Relaying device request to user (#%u)\n",
 					       count);
 
-		eventfd_signal(matrix_mdev->req_trigger, 1);
+		eventfd_signal(matrix_mdev->req_trigger);
 	} else if (count == 0) {
 		dev_notice(dev,
 			   "No device request registered, blocked until released by user\n");
diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index dcd6c7299fa9..973aa937536e 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -579,6 +579,7 @@ static inline struct zcrypt_queue *zcrypt_pick_queue(struct zcrypt_card *zc,
 {
 	if (!zq || !try_module_get(zq->queue->ap_dev.device.driver->owner))
 		return NULL;
+	zcrypt_card_get(zc);
 	zcrypt_queue_get(zq);
 	get_device(&zq->queue->ap_dev.device);
 	atomic_add(weight, &zc->load);
@@ -598,6 +599,7 @@ static inline void zcrypt_drop_queue(struct zcrypt_card *zc,
 	atomic_sub(weight, &zq->load);
 	put_device(&zq->queue->ap_dev.device);
 	zcrypt_queue_put(zq);
+	zcrypt_card_put(zc);
 	module_put(mod);
 }
 
diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index d7f51b84f3c7..445f4a220df3 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -353,12 +353,13 @@ static void scsi_host_dev_release(struct device *dev)
 
 	if (shost->shost_state == SHOST_CREATED) {
 		/*
-		 * Free the shost_dev device name here if scsi_host_alloc()
-		 * and scsi_host_put() have been called but neither
+		 * Free the shost_dev device name and remove the proc host dir
+		 * here if scsi_host_{alloc,put}() have been called but neither
 		 * scsi_host_add() nor scsi_remove_host() has been called.
 		 * This avoids that the memory allocated for the shost_dev
-		 * name is leaked.
+		 * name as well as the proc dir structure are leaked.
 		 */
+		scsi_proc_hostdir_rm(shost->hostt);
 		kfree(dev_name(&shost->shost_dev));
 	}
 
diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index a2204674b680..5c261005b74e 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -1621,6 +1621,16 @@ int sas_discover_root_expander(struct domain_device *dev)
 
 /* ---------- Domain revalidation ---------- */
 
+static void sas_get_sas_addr_and_dev_type(struct smp_disc_resp *disc_resp,
+					  u8 *sas_addr,
+					  enum sas_device_type *type)
+{
+	memcpy(sas_addr, disc_resp->disc.attached_sas_addr, SAS_ADDR_SIZE);
+	*type = to_dev_type(&disc_resp->disc);
+	if (*type == SAS_PHY_UNUSED)
+		memset(sas_addr, 0, SAS_ADDR_SIZE);
+}
+
 static int sas_get_phy_discover(struct domain_device *dev,
 				int phy_id, struct smp_disc_resp *disc_resp)
 {
@@ -1674,13 +1684,8 @@ int sas_get_phy_attached_dev(struct domain_device *dev, int phy_id,
 		return -ENOMEM;
 
 	res = sas_get_phy_discover(dev, phy_id, disc_resp);
-	if (res == 0) {
-		memcpy(sas_addr, disc_resp->disc.attached_sas_addr,
-		       SAS_ADDR_SIZE);
-		*type = to_dev_type(&disc_resp->disc);
-		if (*type == 0)
-			memset(sas_addr, 0, SAS_ADDR_SIZE);
-	}
+	if (res == 0)
+		sas_get_sas_addr_and_dev_type(disc_resp, sas_addr, type);
 	kfree(disc_resp);
 	return res;
 }
@@ -1940,6 +1945,7 @@ static int sas_rediscover_dev(struct domain_device *dev, int phy_id,
 	struct expander_device *ex = &dev->ex_dev;
 	struct ex_phy *phy = &ex->ex_phy[phy_id];
 	enum sas_device_type type = SAS_PHY_UNUSED;
+	struct smp_disc_resp *disc_resp;
 	u8 sas_addr[SAS_ADDR_SIZE];
 	char msg[80] = "";
 	int res;
@@ -1951,33 +1957,41 @@ static int sas_rediscover_dev(struct domain_device *dev, int phy_id,
 		 SAS_ADDR(dev->sas_addr), phy_id, msg);
 
 	memset(sas_addr, 0, SAS_ADDR_SIZE);
-	res = sas_get_phy_attached_dev(dev, phy_id, sas_addr, &type);
+	disc_resp = alloc_smp_resp(DISCOVER_RESP_SIZE);
+	if (!disc_resp)
+		return -ENOMEM;
+
+	res = sas_get_phy_discover(dev, phy_id, disc_resp);
 	switch (res) {
 	case SMP_RESP_NO_PHY:
 		phy->phy_state = PHY_NOT_PRESENT;
 		sas_unregister_devs_sas_addr(dev, phy_id, last);
-		return res;
+		goto out_free_resp;
 	case SMP_RESP_PHY_VACANT:
 		phy->phy_state = PHY_VACANT;
 		sas_unregister_devs_sas_addr(dev, phy_id, last);
-		return res;
+		goto out_free_resp;
 	case SMP_RESP_FUNC_ACC:
 		break;
 	case -ECOMM:
 		break;
 	default:
-		return res;
+		goto out_free_resp;
 	}
 
+	if (res == 0)
+		sas_get_sas_addr_and_dev_type(disc_resp, sas_addr, &type);
+
 	if ((SAS_ADDR(sas_addr) == 0) || (res == -ECOMM)) {
 		phy->phy_state = PHY_EMPTY;
 		sas_unregister_devs_sas_addr(dev, phy_id, last);
 		/*
-		 * Even though the PHY is empty, for convenience we discover
-		 * the PHY to update the PHY info, like negotiated linkrate.
+		 * Even though the PHY is empty, for convenience we update
+		 * the PHY info, like negotiated linkrate.
 		 */
-		sas_ex_phy_discover(dev, phy_id);
-		return res;
+		if (res == 0)
+			sas_set_ex_phy(dev, phy_id, disc_resp);
+		goto out_free_resp;
 	} else if (SAS_ADDR(sas_addr) == SAS_ADDR(phy->attached_sas_addr) &&
 		   dev_type_flutter(type, phy->attached_dev_type)) {
 		struct domain_device *ata_dev = sas_ex_to_ata(dev, phy_id);
@@ -1989,7 +2003,7 @@ static int sas_rediscover_dev(struct domain_device *dev, int phy_id,
 			action = ", needs recovery";
 		pr_debug("ex %016llx phy%02d broadcast flutter%s\n",
 			 SAS_ADDR(dev->sas_addr), phy_id, action);
-		return res;
+		goto out_free_resp;
 	}
 
 	/* we always have to delete the old device when we went here */
@@ -1998,7 +2012,10 @@ static int sas_rediscover_dev(struct domain_device *dev, int phy_id,
 		SAS_ADDR(phy->attached_sas_addr));
 	sas_unregister_devs_sas_addr(dev, phy_id, last);
 
-	return sas_discover_new(dev, phy_id);
+	res = sas_discover_new(dev, phy_id);
+out_free_resp:
+	kfree(disc_resp);
+	return res;
 }
 
 /**
diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index 595dca92e8db..2919579fa084 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -3169,10 +3169,10 @@ lpfc_bsg_diag_loopback_run(struct bsg_job *job)
 	}
 
 	cmdwqe = &cmdiocbq->wqe;
-	memset(cmdwqe, 0, sizeof(union lpfc_wqe));
+	memset(cmdwqe, 0, sizeof(*cmdwqe));
 	if (phba->sli_rev < LPFC_SLI_REV4) {
 		rspwqe = &rspiocbq->wqe;
-		memset(rspwqe, 0, sizeof(union lpfc_wqe));
+		memset(rspwqe, 0, sizeof(*rspwqe));
 	}
 
 	INIT_LIST_HEAD(&head);
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 425328d9c2d8..d41fea53e41e 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1586,7 +1586,7 @@ lpfc_nvmet_setup_io_context(struct lpfc_hba *phba)
 		wqe = &nvmewqe->wqe;
 
 		/* Initialize WQE */
-		memset(wqe, 0, sizeof(union lpfc_wqe));
+		memset(wqe, 0, sizeof(*wqe));
 
 		ctx_buf->iocbq->cmd_dmabuf = NULL;
 		spin_lock(&phba->sli4_hba.sgl_list_lock);
diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index 44449c70a375..76eeba435fd0 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -2741,7 +2741,13 @@ qla2x00_dev_loss_tmo_callbk(struct fc_rport *rport)
 		return;
 
 	if (unlikely(pci_channel_offline(fcport->vha->hw->pdev))) {
-		qla2x00_abort_all_cmds(fcport->vha, DID_NO_CONNECT << 16);
+		/* Will wait for wind down of adapter */
+		ql_dbg(ql_dbg_aer, fcport->vha, 0x900c,
+		    "%s pci offline detected (id %06x)\n", __func__,
+		    fcport->d_id.b24);
+		qla_pci_set_eeh_busy(fcport->vha);
+		qla2x00_eh_wait_for_pending_commands(fcport->vha, fcport->d_id.b24,
+		    0, WAIT_TARGET);
 		return;
 	}
 }
@@ -2763,7 +2769,11 @@ qla2x00_terminate_rport_io(struct fc_rport *rport)
 	vha = fcport->vha;
 
 	if (unlikely(pci_channel_offline(fcport->vha->hw->pdev))) {
-		qla2x00_abort_all_cmds(fcport->vha, DID_NO_CONNECT << 16);
+		/* Will wait for wind down of adapter */
+		ql_dbg(ql_dbg_aer, fcport->vha, 0x900b,
+		    "%s pci offline detected (id %06x)\n", __func__,
+		    fcport->d_id.b24);
+		qla_pci_set_eeh_busy(vha);
 		qla2x00_eh_wait_for_pending_commands(fcport->vha, fcport->d_id.b24,
 			0, WAIT_TARGET);
 		return;
diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index deb642607deb..2f49baf131e2 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -82,7 +82,7 @@ typedef union {
 #include "qla_nvme.h"
 #define QLA2XXX_DRIVER_NAME	"qla2xxx"
 #define QLA2XXX_APIDEV		"ql2xapidev"
-#define QLA2XXX_MANUFACTURER	"Marvell Semiconductor, Inc."
+#define QLA2XXX_MANUFACTURER	"Marvell"
 
 /*
  * We have MAILBOX_REGISTER_COUNT sized arrays in a few places,
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index 09cb9413670a..7309310d2ab9 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -44,7 +44,7 @@ extern int qla2x00_fabric_login(scsi_qla_host_t *, fc_port_t *, uint16_t *);
 extern int qla2x00_local_device_login(scsi_qla_host_t *, fc_port_t *);
 
 extern int qla24xx_els_dcmd_iocb(scsi_qla_host_t *, int, port_id_t);
-extern int qla24xx_els_dcmd2_iocb(scsi_qla_host_t *, int, fc_port_t *, bool);
+extern int qla24xx_els_dcmd2_iocb(scsi_qla_host_t *, int, fc_port_t *);
 extern void qla2x00_els_dcmd2_free(scsi_qla_host_t *vha,
 				   struct els_plogi *els_plogi);
 
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index a314cfc5b263..8377624d76c9 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1193,8 +1193,12 @@ int qla24xx_async_gnl(struct scsi_qla_host *vha, fc_port_t *fcport)
 	return rval;
 
 done_free_sp:
-	/* ref: INIT */
-	kref_put(&sp->cmd_kref, qla2x00_sp_release);
+	/*
+	 * use qla24xx_async_gnl_sp_done to purge all pending gnl request.
+	 * kref_put is call behind the scene.
+	 */
+	sp->u.iocb_cmd.u.mbx.in_mb[0] = MBS_COMMAND_ERROR;
+	qla24xx_async_gnl_sp_done(sp, QLA_COMMAND_ERROR);
 	fcport->flags &= ~(FCF_ASYNC_SENT);
 done:
 	fcport->flags &= ~(FCF_ASYNC_ACTIVE);
@@ -2665,6 +2669,40 @@ qla83xx_nic_core_fw_load(scsi_qla_host_t *vha)
 	return rval;
 }
 
+static void qla_enable_fce_trace(scsi_qla_host_t *vha)
+{
+	int rval;
+	struct qla_hw_data *ha = vha->hw;
+
+	if (ha->fce) {
+		ha->flags.fce_enabled = 1;
+		memset(ha->fce, 0, fce_calc_size(ha->fce_bufs));
+		rval = qla2x00_enable_fce_trace(vha,
+		    ha->fce_dma, ha->fce_bufs, ha->fce_mb, &ha->fce_bufs);
+
+		if (rval) {
+			ql_log(ql_log_warn, vha, 0x8033,
+			    "Unable to reinitialize FCE (%d).\n", rval);
+			ha->flags.fce_enabled = 0;
+		}
+	}
+}
+
+static void qla_enable_eft_trace(scsi_qla_host_t *vha)
+{
+	int rval;
+	struct qla_hw_data *ha = vha->hw;
+
+	if (ha->eft) {
+		memset(ha->eft, 0, EFT_SIZE);
+		rval = qla2x00_enable_eft_trace(vha, ha->eft_dma, EFT_NUM_BUFFERS);
+
+		if (rval) {
+			ql_log(ql_log_warn, vha, 0x8034,
+			    "Unable to reinitialize EFT (%d).\n", rval);
+		}
+	}
+}
 /*
 * qla2x00_initialize_adapter
 *      Initialize board.
@@ -3668,9 +3706,8 @@ qla24xx_chip_diag(scsi_qla_host_t *vha)
 }
 
 static void
-qla2x00_init_fce_trace(scsi_qla_host_t *vha)
+qla2x00_alloc_fce_trace(scsi_qla_host_t *vha)
 {
-	int rval;
 	dma_addr_t tc_dma;
 	void *tc;
 	struct qla_hw_data *ha = vha->hw;
@@ -3699,27 +3736,17 @@ qla2x00_init_fce_trace(scsi_qla_host_t *vha)
 		return;
 	}
 
-	rval = qla2x00_enable_fce_trace(vha, tc_dma, FCE_NUM_BUFFERS,
-					ha->fce_mb, &ha->fce_bufs);
-	if (rval) {
-		ql_log(ql_log_warn, vha, 0x00bf,
-		       "Unable to initialize FCE (%d).\n", rval);
-		dma_free_coherent(&ha->pdev->dev, FCE_SIZE, tc, tc_dma);
-		return;
-	}
-
 	ql_dbg(ql_dbg_init, vha, 0x00c0,
 	       "Allocated (%d KB) for FCE...\n", FCE_SIZE / 1024);
 
-	ha->flags.fce_enabled = 1;
 	ha->fce_dma = tc_dma;
 	ha->fce = tc;
+	ha->fce_bufs = FCE_NUM_BUFFERS;
 }
 
 static void
-qla2x00_init_eft_trace(scsi_qla_host_t *vha)
+qla2x00_alloc_eft_trace(scsi_qla_host_t *vha)
 {
-	int rval;
 	dma_addr_t tc_dma;
 	void *tc;
 	struct qla_hw_data *ha = vha->hw;
@@ -3744,14 +3771,6 @@ qla2x00_init_eft_trace(scsi_qla_host_t *vha)
 		return;
 	}
 
-	rval = qla2x00_enable_eft_trace(vha, tc_dma, EFT_NUM_BUFFERS);
-	if (rval) {
-		ql_log(ql_log_warn, vha, 0x00c2,
-		       "Unable to initialize EFT (%d).\n", rval);
-		dma_free_coherent(&ha->pdev->dev, EFT_SIZE, tc, tc_dma);
-		return;
-	}
-
 	ql_dbg(ql_dbg_init, vha, 0x00c3,
 	       "Allocated (%d KB) EFT ...\n", EFT_SIZE / 1024);
 
@@ -3759,13 +3778,6 @@ qla2x00_init_eft_trace(scsi_qla_host_t *vha)
 	ha->eft = tc;
 }
 
-static void
-qla2x00_alloc_offload_mem(scsi_qla_host_t *vha)
-{
-	qla2x00_init_fce_trace(vha);
-	qla2x00_init_eft_trace(vha);
-}
-
 void
 qla2x00_alloc_fw_dump(scsi_qla_host_t *vha)
 {
@@ -3820,10 +3832,10 @@ qla2x00_alloc_fw_dump(scsi_qla_host_t *vha)
 		if (ha->tgt.atio_ring)
 			mq_size += ha->tgt.atio_q_length * sizeof(request_t);
 
-		qla2x00_init_fce_trace(vha);
+		qla2x00_alloc_fce_trace(vha);
 		if (ha->fce)
 			fce_size = sizeof(struct qla2xxx_fce_chain) + FCE_SIZE;
-		qla2x00_init_eft_trace(vha);
+		qla2x00_alloc_eft_trace(vha);
 		if (ha->eft)
 			eft_size = EFT_SIZE;
 	}
@@ -4253,7 +4265,6 @@ qla2x00_setup_chip(scsi_qla_host_t *vha)
 	struct qla_hw_data *ha = vha->hw;
 	struct device_reg_2xxx __iomem *reg = &ha->iobase->isp;
 	unsigned long flags;
-	uint16_t fw_major_version;
 	int done_once = 0;
 
 	if (IS_P3P_TYPE(ha)) {
@@ -4320,7 +4331,6 @@ qla2x00_setup_chip(scsi_qla_host_t *vha)
 					goto failed;
 
 enable_82xx_npiv:
-				fw_major_version = ha->fw_major_version;
 				if (IS_P3P_TYPE(ha))
 					qla82xx_check_md_needed(vha);
 				else
@@ -4349,12 +4359,11 @@ qla2x00_setup_chip(scsi_qla_host_t *vha)
 				if (rval != QLA_SUCCESS)
 					goto failed;
 
-				if (!fw_major_version && !(IS_P3P_TYPE(ha)))
-					qla2x00_alloc_offload_mem(vha);
-
 				if (ql2xallocfwdump && !(IS_P3P_TYPE(ha)))
 					qla2x00_alloc_fw_dump(vha);
 
+				qla_enable_fce_trace(vha);
+				qla_enable_eft_trace(vha);
 			} else {
 				goto failed;
 			}
@@ -7487,12 +7496,12 @@ qla2x00_abort_isp_cleanup(scsi_qla_host_t *vha)
 int
 qla2x00_abort_isp(scsi_qla_host_t *vha)
 {
-	int rval;
 	uint8_t        status = 0;
 	struct qla_hw_data *ha = vha->hw;
 	struct scsi_qla_host *vp, *tvp;
 	struct req_que *req = ha->req_q_map[0];
 	unsigned long flags;
+	fc_port_t *fcport;
 
 	if (vha->flags.online) {
 		qla2x00_abort_isp_cleanup(vha);
@@ -7561,6 +7570,15 @@ qla2x00_abort_isp(scsi_qla_host_t *vha)
 			       "ISP Abort - ISP reg disconnect post nvmram config, exiting.\n");
 			return status;
 		}
+
+		/* User may have updated [fcp|nvme] prefer in flash */
+		list_for_each_entry(fcport, &vha->vp_fcports, list) {
+			if (NVME_PRIORITY(ha, fcport))
+				fcport->do_prli_nvme = 1;
+			else
+				fcport->do_prli_nvme = 0;
+		}
+
 		if (!qla2x00_restart_isp(vha)) {
 			clear_bit(RESET_MARKER_NEEDED, &vha->dpc_flags);
 
@@ -7581,31 +7599,7 @@ qla2x00_abort_isp(scsi_qla_host_t *vha)
 
 			if (IS_QLA81XX(ha) || IS_QLA8031(ha))
 				qla2x00_get_fw_version(vha);
-			if (ha->fce) {
-				ha->flags.fce_enabled = 1;
-				memset(ha->fce, 0,
-				    fce_calc_size(ha->fce_bufs));
-				rval = qla2x00_enable_fce_trace(vha,
-				    ha->fce_dma, ha->fce_bufs, ha->fce_mb,
-				    &ha->fce_bufs);
-				if (rval) {
-					ql_log(ql_log_warn, vha, 0x8033,
-					    "Unable to reinitialize FCE "
-					    "(%d).\n", rval);
-					ha->flags.fce_enabled = 0;
-				}
-			}
 
-			if (ha->eft) {
-				memset(ha->eft, 0, EFT_SIZE);
-				rval = qla2x00_enable_eft_trace(vha,
-				    ha->eft_dma, EFT_NUM_BUFFERS);
-				if (rval) {
-					ql_log(ql_log_warn, vha, 0x8034,
-					    "Unable to reinitialize EFT "
-					    "(%d).\n", rval);
-				}
-			}
 		} else {	/* failed the ISP abort */
 			vha->flags.online = 1;
 			if (test_bit(ISP_ABORT_RETRY, &vha->dpc_flags)) {
@@ -7655,6 +7649,14 @@ qla2x00_abort_isp(scsi_qla_host_t *vha)
 				atomic_inc(&vp->vref_count);
 				spin_unlock_irqrestore(&ha->vport_slock, flags);
 
+				/* User may have updated [fcp|nvme] prefer in flash */
+				list_for_each_entry(fcport, &vp->vp_fcports, list) {
+					if (NVME_PRIORITY(ha, fcport))
+						fcport->do_prli_nvme = 1;
+					else
+						fcport->do_prli_nvme = 0;
+				}
+
 				qla2x00_vp_abort_isp(vp);
 
 				spin_lock_irqsave(&ha->vport_slock, flags);
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index df90169f8244..0b41e8a06602 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2587,6 +2587,33 @@ void
 qla2x00_sp_release(struct kref *kref)
 {
 	struct srb *sp = container_of(kref, struct srb, cmd_kref);
+	struct scsi_qla_host *vha = sp->vha;
+
+	switch (sp->type) {
+	case SRB_CT_PTHRU_CMD:
+		/* GPSC & GFPNID use fcport->ct_desc.ct_sns for both req & rsp */
+		if (sp->u.iocb_cmd.u.ctarg.req &&
+			(!sp->fcport ||
+			 sp->u.iocb_cmd.u.ctarg.req != sp->fcport->ct_desc.ct_sns)) {
+			dma_free_coherent(&vha->hw->pdev->dev,
+			    sp->u.iocb_cmd.u.ctarg.req_allocated_size,
+			    sp->u.iocb_cmd.u.ctarg.req,
+			    sp->u.iocb_cmd.u.ctarg.req_dma);
+			sp->u.iocb_cmd.u.ctarg.req = NULL;
+		}
+		if (sp->u.iocb_cmd.u.ctarg.rsp &&
+			(!sp->fcport ||
+			 sp->u.iocb_cmd.u.ctarg.rsp != sp->fcport->ct_desc.ct_sns)) {
+			dma_free_coherent(&vha->hw->pdev->dev,
+			    sp->u.iocb_cmd.u.ctarg.rsp_allocated_size,
+			    sp->u.iocb_cmd.u.ctarg.rsp,
+			    sp->u.iocb_cmd.u.ctarg.rsp_dma);
+			sp->u.iocb_cmd.u.ctarg.rsp = NULL;
+		}
+		break;
+	default:
+		break;
+	}
 
 	sp->free(sp);
 }
@@ -2610,7 +2637,8 @@ static void qla2x00_els_dcmd_sp_free(srb_t *sp)
 {
 	struct srb_iocb *elsio = &sp->u.iocb_cmd;
 
-	kfree(sp->fcport);
+	if (sp->fcport)
+		qla2x00_free_fcport(sp->fcport);
 
 	if (elsio->u.els_logo.els_logo_pyld)
 		dma_free_coherent(&sp->vha->hw->pdev->dev, DMA_POOL_SIZE,
@@ -2692,7 +2720,7 @@ qla24xx_els_dcmd_iocb(scsi_qla_host_t *vha, int els_opcode,
 	 */
 	sp = qla2x00_get_sp(vha, fcport, GFP_KERNEL);
 	if (!sp) {
-		kfree(fcport);
+		qla2x00_free_fcport(fcport);
 		ql_log(ql_log_info, vha, 0x70e6,
 		 "SRB allocation failed\n");
 		return -ENOMEM;
@@ -2723,6 +2751,7 @@ qla24xx_els_dcmd_iocb(scsi_qla_host_t *vha, int els_opcode,
 	if (!elsio->u.els_logo.els_logo_pyld) {
 		/* ref: INIT */
 		kref_put(&sp->cmd_kref, qla2x00_sp_release);
+		qla2x00_free_fcport(fcport);
 		return QLA_FUNCTION_FAILED;
 	}
 
@@ -2747,6 +2776,7 @@ qla24xx_els_dcmd_iocb(scsi_qla_host_t *vha, int els_opcode,
 	if (rval != QLA_SUCCESS) {
 		/* ref: INIT */
 		kref_put(&sp->cmd_kref, qla2x00_sp_release);
+		qla2x00_free_fcport(fcport);
 		return QLA_FUNCTION_FAILED;
 	}
 
@@ -3012,7 +3042,7 @@ static void qla2x00_els_dcmd2_sp_done(srb_t *sp, int res)
 
 int
 qla24xx_els_dcmd2_iocb(scsi_qla_host_t *vha, int els_opcode,
-    fc_port_t *fcport, bool wait)
+			fc_port_t *fcport)
 {
 	srb_t *sp;
 	struct srb_iocb *elsio = NULL;
@@ -3027,8 +3057,7 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *vha, int els_opcode,
 	if (!sp) {
 		ql_log(ql_log_info, vha, 0x70e6,
 		 "SRB allocation failed\n");
-		fcport->flags &= ~FCF_ASYNC_ACTIVE;
-		return -ENOMEM;
+		goto done;
 	}
 
 	fcport->flags |= FCF_ASYNC_SENT;
@@ -3037,9 +3066,6 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *vha, int els_opcode,
 	ql_dbg(ql_dbg_io, vha, 0x3073,
 	       "%s Enter: PLOGI portid=%06x\n", __func__, fcport->d_id.b24);
 
-	if (wait)
-		sp->flags = SRB_WAKEUP_ON_COMP;
-
 	sp->type = SRB_ELS_DCMD;
 	sp->name = "ELS_DCMD";
 	sp->fcport = fcport;
@@ -3055,7 +3081,7 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *vha, int els_opcode,
 
 	if (!elsio->u.els_plogi.els_plogi_pyld) {
 		rval = QLA_FUNCTION_FAILED;
-		goto out;
+		goto done_free_sp;
 	}
 
 	resp_ptr = elsio->u.els_plogi.els_resp_pyld =
@@ -3064,7 +3090,7 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *vha, int els_opcode,
 
 	if (!elsio->u.els_plogi.els_resp_pyld) {
 		rval = QLA_FUNCTION_FAILED;
-		goto out;
+		goto done_free_sp;
 	}
 
 	ql_dbg(ql_dbg_io, vha, 0x3073, "PLOGI %p %p\n", ptr, resp_ptr);
@@ -3080,7 +3106,6 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *vha, int els_opcode,
 
 	if (els_opcode == ELS_DCMD_PLOGI && DBELL_ACTIVE(vha)) {
 		struct fc_els_flogi *p = ptr;
-
 		p->fl_csp.sp_features |= cpu_to_be16(FC_SP_FT_SEC);
 	}
 
@@ -3089,10 +3114,11 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *vha, int els_opcode,
 	    (uint8_t *)elsio->u.els_plogi.els_plogi_pyld,
 	    sizeof(*elsio->u.els_plogi.els_plogi_pyld));
 
-	init_completion(&elsio->u.els_plogi.comp);
 	rval = qla2x00_start_sp(sp);
 	if (rval != QLA_SUCCESS) {
-		rval = QLA_FUNCTION_FAILED;
+		fcport->flags |= FCF_LOGIN_NEEDED;
+		set_bit(RELOGIN_NEEDED, &vha->dpc_flags);
+		goto done_free_sp;
 	} else {
 		ql_dbg(ql_dbg_disc, vha, 0x3074,
 		    "%s PLOGI sent, hdl=%x, loopid=%x, to port_id %06x from port_id %06x\n",
@@ -3100,21 +3126,15 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *vha, int els_opcode,
 		    fcport->d_id.b24, vha->d_id.b24);
 	}
 
-	if (wait) {
-		wait_for_completion(&elsio->u.els_plogi.comp);
-
-		if (elsio->u.els_plogi.comp_status != CS_COMPLETE)
-			rval = QLA_FUNCTION_FAILED;
-	} else {
-		goto done;
-	}
+	return rval;
 
-out:
-	fcport->flags &= ~(FCF_ASYNC_SENT | FCF_ASYNC_ACTIVE);
+done_free_sp:
 	qla2x00_els_dcmd2_free(vha, &elsio->u.els_plogi);
 	/* ref: INIT */
 	kref_put(&sp->cmd_kref, qla2x00_sp_release);
 done:
+	fcport->flags &= ~(FCF_ASYNC_SENT | FCF_ASYNC_ACTIVE);
+	qla2x00_set_fcport_disc_state(fcport, DSC_DELETED);
 	return rval;
 }
 
@@ -3918,7 +3938,7 @@ qla2x00_start_sp(srb_t *sp)
 		return -EAGAIN;
 	}
 
-	pkt = __qla2x00_alloc_iocbs(sp->qpair, sp);
+	pkt = qla2x00_alloc_iocbs_ready(sp->qpair, sp);
 	if (!pkt) {
 		rval = -EAGAIN;
 		ql_log(ql_log_warn, vha, 0x700c,
diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 21ec32b4fb28..0cd6f3e14882 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -194,7 +194,7 @@ qla2x00_mailbox_command(scsi_qla_host_t *vha, mbx_cmd_t *mcp)
 	if (ha->flags.purge_mbox || chip_reset != ha->chip_reset ||
 	    ha->flags.eeh_busy) {
 		ql_log(ql_log_warn, vha, 0xd035,
-		       "Error detected: purge[%d] eeh[%d] cmd=0x%x, Exiting.\n",
+		       "Purge mbox: purge[%d] eeh[%d] cmd=0x%x, Exiting.\n",
 		       ha->flags.purge_mbox, ha->flags.eeh_busy, mcp->mb[0]);
 		rval = QLA_ABORTED;
 		goto premature_exit;
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 03348f605c2e..931bdaeaee1d 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -4602,6 +4602,7 @@ qla2x00_mem_alloc(struct qla_hw_data *ha, uint16_t req_len, uint16_t rsp_len,
 	ha->init_cb_dma = 0;
 fail_free_vp_map:
 	kfree(ha->vp_map);
+	ha->vp_map = NULL;
 fail:
 	ql_log(ql_log_fatal, NULL, 0x0030,
 	    "Memory allocation failure.\n");
@@ -5583,7 +5584,7 @@ qla2x00_do_work(struct scsi_qla_host *vha)
 			break;
 		case QLA_EVT_ELS_PLOGI:
 			qla24xx_els_dcmd2_iocb(vha, ELS_DCMD_PLOGI,
-			    e->u.fcport.fcport, false);
+			    e->u.fcport.fcport);
 			break;
 		case QLA_EVT_SA_REPLACE:
 			rc = qla24xx_issue_sa_replace_iocb(vha, e);
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 2ef2dbac0db2..d7551b1443e4 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -1062,6 +1062,16 @@ void qlt_free_session_done(struct work_struct *work)
 		    "%s: sess %p logout completed\n", __func__, sess);
 	}
 
+	/* check for any straggling io left behind */
+	if (!(sess->flags & FCF_FCP2_DEVICE) &&
+	    qla2x00_eh_wait_for_pending_commands(sess->vha, sess->d_id.b24, 0, WAIT_TARGET)) {
+		ql_log(ql_log_warn, vha, 0x3027,
+		    "IO not return. Resetting.\n");
+		set_bit(ISP_ABORT_NEEDED, &vha->dpc_flags);
+		qla2xxx_wake_dpc(vha);
+		qla2x00_wait_for_chip_reset(vha);
+	}
+
 	if (sess->logo_ack_needed) {
 		sess->logo_ack_needed = 0;
 		qla24xx_async_notify_ack(vha, sess,
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 44680f65ea14..ca99be7341d9 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -1619,6 +1619,40 @@ int scsi_add_device(struct Scsi_Host *host, uint channel,
 }
 EXPORT_SYMBOL(scsi_add_device);
 
+int scsi_resume_device(struct scsi_device *sdev)
+{
+	struct device *dev = &sdev->sdev_gendev;
+	int ret = 0;
+
+	device_lock(dev);
+
+	/*
+	 * Bail out if the device or its queue are not running. Otherwise,
+	 * the rescan may block waiting for commands to be executed, with us
+	 * holding the device lock. This can result in a potential deadlock
+	 * in the power management core code when system resume is on-going.
+	 */
+	if (sdev->sdev_state != SDEV_RUNNING ||
+	    blk_queue_pm_only(sdev->request_queue)) {
+		ret = -EWOULDBLOCK;
+		goto unlock;
+	}
+
+	if (dev->driver && try_module_get(dev->driver->owner)) {
+		struct scsi_driver *drv = to_scsi_driver(dev->driver);
+
+		if (drv->resume)
+			ret = drv->resume(dev);
+		module_put(dev->driver->owner);
+	}
+
+unlock:
+	device_unlock(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL(scsi_resume_device);
+
 int scsi_rescan_device(struct scsi_device *sdev)
 {
 	struct device *dev = &sdev->sdev_gendev;
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index a12ff43ac8fd..f76dbeade0c4 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3948,7 +3948,21 @@ static int sd_suspend_runtime(struct device *dev)
 	return sd_suspend_common(dev, true);
 }
 
-static int sd_resume(struct device *dev, bool runtime)
+static int sd_resume(struct device *dev)
+{
+	struct scsi_disk *sdkp = dev_get_drvdata(dev);
+
+	sd_printk(KERN_NOTICE, sdkp, "Starting disk\n");
+
+	if (opal_unlock_from_suspend(sdkp->opal_dev)) {
+		sd_printk(KERN_NOTICE, sdkp, "OPAL unlock failed\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int sd_resume_common(struct device *dev, bool runtime)
 {
 	struct scsi_disk *sdkp = dev_get_drvdata(dev);
 	int ret;
@@ -3964,7 +3978,7 @@ static int sd_resume(struct device *dev, bool runtime)
 	sd_printk(KERN_NOTICE, sdkp, "Starting disk\n");
 	ret = sd_start_stop_device(sdkp, 1);
 	if (!ret) {
-		opal_unlock_from_suspend(sdkp->opal_dev);
+		sd_resume(dev);
 		sdkp->suspended = false;
 	}
 
@@ -3983,7 +3997,7 @@ static int sd_resume_system(struct device *dev)
 		return 0;
 	}
 
-	return sd_resume(dev, false);
+	return sd_resume_common(dev, false);
 }
 
 static int sd_resume_runtime(struct device *dev)
@@ -4010,7 +4024,7 @@ static int sd_resume_runtime(struct device *dev)
 				  "Failed to clear sense data\n");
 	}
 
-	return sd_resume(dev, true);
+	return sd_resume_common(dev, true);
 }
 
 static const struct dev_pm_ops sd_pm_ops = {
@@ -4033,6 +4047,7 @@ static struct scsi_driver sd_template = {
 		.pm		= &sd_pm_ops,
 	},
 	.rescan			= sd_rescan,
+	.resume			= sd_resume,
 	.init_command		= sd_init_command,
 	.uninit_command		= sd_uninit_command,
 	.done			= sd_done,
diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index d43873bb5fe6..01cbd4621981 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -436,8 +436,8 @@ static int slim_device_alloc_laddr(struct slim_device *sbdev,
 		if (ret < 0)
 			goto err;
 	} else if (report_present) {
-		ret = ida_simple_get(&ctrl->laddr_ida,
-				     0, SLIM_LA_MANAGER - 1, GFP_KERNEL);
+		ret = ida_alloc_max(&ctrl->laddr_ida,
+				    SLIM_LA_MANAGER - 1, GFP_KERNEL);
 		if (ret < 0)
 			goto err;
 
diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 739e4eee6b75..7e9074519ad2 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -991,7 +991,7 @@ struct qman_portal {
 	/* linked-list of CSCN handlers. */
 	struct list_head cgr_cbs;
 	/* list lock */
-	spinlock_t cgr_lock;
+	raw_spinlock_t cgr_lock;
 	struct work_struct congestion_work;
 	struct work_struct mr_work;
 	char irqname[MAX_IRQNAME];
@@ -1281,7 +1281,7 @@ static int qman_create_portal(struct qman_portal *portal,
 		/* if the given mask is NULL, assume all CGRs can be seen */
 		qman_cgrs_fill(&portal->cgrs[0]);
 	INIT_LIST_HEAD(&portal->cgr_cbs);
-	spin_lock_init(&portal->cgr_lock);
+	raw_spin_lock_init(&portal->cgr_lock);
 	INIT_WORK(&portal->congestion_work, qm_congestion_task);
 	INIT_WORK(&portal->mr_work, qm_mr_process_task);
 	portal->bits = 0;
@@ -1456,11 +1456,14 @@ static void qm_congestion_task(struct work_struct *work)
 	union qm_mc_result *mcr;
 	struct qman_cgr *cgr;
 
-	spin_lock(&p->cgr_lock);
+	/*
+	 * FIXME: QM_MCR_TIMEOUT is 10ms, which is too long for a raw spinlock!
+	 */
+	raw_spin_lock_irq(&p->cgr_lock);
 	qm_mc_start(&p->p);
 	qm_mc_commit(&p->p, QM_MCC_VERB_QUERYCONGESTION);
 	if (!qm_mc_result_timeout(&p->p, &mcr)) {
-		spin_unlock(&p->cgr_lock);
+		raw_spin_unlock_irq(&p->cgr_lock);
 		dev_crit(p->config->dev, "QUERYCONGESTION timeout\n");
 		qman_p_irqsource_add(p, QM_PIRQ_CSCI);
 		return;
@@ -1476,7 +1479,7 @@ static void qm_congestion_task(struct work_struct *work)
 	list_for_each_entry(cgr, &p->cgr_cbs, node)
 		if (cgr->cb && qman_cgrs_get(&c, cgr->cgrid))
 			cgr->cb(p, cgr, qman_cgrs_get(&rr, cgr->cgrid));
-	spin_unlock(&p->cgr_lock);
+	raw_spin_unlock_irq(&p->cgr_lock);
 	qman_p_irqsource_add(p, QM_PIRQ_CSCI);
 }
 
@@ -2440,7 +2443,7 @@ int qman_create_cgr(struct qman_cgr *cgr, u32 flags,
 	preempt_enable();
 
 	cgr->chan = p->config->channel;
-	spin_lock(&p->cgr_lock);
+	raw_spin_lock_irq(&p->cgr_lock);
 
 	if (opts) {
 		struct qm_mcc_initcgr local_opts = *opts;
@@ -2477,7 +2480,7 @@ int qman_create_cgr(struct qman_cgr *cgr, u32 flags,
 	    qman_cgrs_get(&p->cgrs[1], cgr->cgrid))
 		cgr->cb(p, cgr, 1);
 out:
-	spin_unlock(&p->cgr_lock);
+	raw_spin_unlock_irq(&p->cgr_lock);
 	put_affine_portal();
 	return ret;
 }
@@ -2512,7 +2515,7 @@ int qman_delete_cgr(struct qman_cgr *cgr)
 		return -EINVAL;
 
 	memset(&local_opts, 0, sizeof(struct qm_mcc_initcgr));
-	spin_lock_irqsave(&p->cgr_lock, irqflags);
+	raw_spin_lock_irqsave(&p->cgr_lock, irqflags);
 	list_del(&cgr->node);
 	/*
 	 * If there are no other CGR objects for this CGRID in the list,
@@ -2537,7 +2540,7 @@ int qman_delete_cgr(struct qman_cgr *cgr)
 		/* add back to the list */
 		list_add(&cgr->node, &p->cgr_cbs);
 release_lock:
-	spin_unlock_irqrestore(&p->cgr_lock, irqflags);
+	raw_spin_unlock_irqrestore(&p->cgr_lock, irqflags);
 	put_affine_portal();
 	return ret;
 }
@@ -2577,9 +2580,9 @@ static int qman_update_cgr(struct qman_cgr *cgr, struct qm_mcc_initcgr *opts)
 	if (!p)
 		return -EINVAL;
 
-	spin_lock_irqsave(&p->cgr_lock, irqflags);
+	raw_spin_lock_irqsave(&p->cgr_lock, irqflags);
 	ret = qm_modify_cgr(cgr, 0, opts);
-	spin_unlock_irqrestore(&p->cgr_lock, irqflags);
+	raw_spin_unlock_irqrestore(&p->cgr_lock, irqflags);
 	put_affine_portal();
 	return ret;
 }
diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c b/drivers/staging/media/ipu3/ipu3-v4l2.c
index e530767e80a5..55cc44a401bc 100644
--- a/drivers/staging/media/ipu3/ipu3-v4l2.c
+++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
@@ -1069,6 +1069,11 @@ static int imgu_v4l2_subdev_register(struct imgu_device *imgu,
 	struct imgu_media_pipe *imgu_pipe = &imgu->imgu_pipe[pipe];
 
 	/* Initialize subdev media entity */
+	imgu_sd->subdev.entity.ops = &imgu_media_ops;
+	for (i = 0; i < IMGU_NODE_NUM; i++) {
+		imgu_sd->subdev_pads[i].flags = imgu_pipe->nodes[i].output ?
+			MEDIA_PAD_FL_SINK : MEDIA_PAD_FL_SOURCE;
+	}
 	r = media_entity_pads_init(&imgu_sd->subdev.entity, IMGU_NODE_NUM,
 				   imgu_sd->subdev_pads);
 	if (r) {
@@ -1076,11 +1081,6 @@ static int imgu_v4l2_subdev_register(struct imgu_device *imgu,
 			"failed initialize subdev media entity (%d)\n", r);
 		return r;
 	}
-	imgu_sd->subdev.entity.ops = &imgu_media_ops;
-	for (i = 0; i < IMGU_NODE_NUM; i++) {
-		imgu_sd->subdev_pads[i].flags = imgu_pipe->nodes[i].output ?
-			MEDIA_PAD_FL_SINK : MEDIA_PAD_FL_SOURCE;
-	}
 
 	/* Initialize subdev */
 	v4l2_subdev_init(&imgu_sd->subdev, &imgu_subdev_ops);
@@ -1177,15 +1177,15 @@ static int imgu_v4l2_node_setup(struct imgu_device *imgu, unsigned int pipe,
 	}
 
 	/* Initialize media entities */
+	node->vdev_pad.flags = node->output ?
+		MEDIA_PAD_FL_SOURCE : MEDIA_PAD_FL_SINK;
+	vdev->entity.ops = NULL;
 	r = media_entity_pads_init(&vdev->entity, 1, &node->vdev_pad);
 	if (r) {
 		dev_err(dev, "failed initialize media entity (%d)\n", r);
 		mutex_destroy(&node->lock);
 		return r;
 	}
-	node->vdev_pad.flags = node->output ?
-		MEDIA_PAD_FL_SOURCE : MEDIA_PAD_FL_SINK;
-	vdev->entity.ops = NULL;
 
 	/* Initialize vbq */
 	vbq->type = node->vdev_fmt.type;
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 258aa0e37f55..4c3684dd902e 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -937,8 +937,9 @@ static int create_component(struct vchiq_mmal_instance *instance,
 	/* build component create message */
 	m.h.type = MMAL_MSG_TYPE_COMPONENT_CREATE;
 	m.u.component_create.client_component = component->client_component;
-	strncpy(m.u.component_create.name, name,
-		sizeof(m.u.component_create.name));
+	strscpy_pad(m.u.component_create.name, name,
+		    sizeof(m.u.component_create.name));
+	m.u.component_create.pid = 0;
 
 	ret = send_synchronous_mmal_msg(instance, &m,
 					sizeof(m.u.component_create),
diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
index 4b1092127694..1892e49a8e6a 100644
--- a/drivers/tee/optee/device.c
+++ b/drivers/tee/optee/device.c
@@ -90,13 +90,14 @@ static int optee_register_device(const uuid_t *device_uuid, u32 func)
 	if (rc) {
 		pr_err("device registration failed, err: %d\n", rc);
 		put_device(&optee_device->dev);
+		return rc;
 	}
 
 	if (func == PTA_CMD_GET_DEVICES_SUPP)
 		device_create_file(&optee_device->dev,
 				   &dev_attr_need_supplicant);
 
-	return rc;
+	return 0;
 }
 
 static int __optee_enumerate_devices(u32 func)
diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 262e62ab6cf2..90b828bcca24 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -201,7 +201,7 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
 
 		res = dfc->power_ops->get_real_power(df, power, freq, voltage);
 		if (!res) {
-			state = dfc->capped_state;
+			state = dfc->max_state - dfc->capped_state;
 
 			/* Convert EM power into milli-Watts first */
 			dfc->res_util = dfc->em_pd->table[state].power;
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index 649f67fdf345..d75fae7b7ed2 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -176,14 +176,14 @@ static int proc_thermal_get_zone_temp(struct thermal_zone_device *zone,
 					 int *temp)
 {
 	int cpu;
-	int curr_temp;
+	int curr_temp, ret;
 
 	*temp = 0;
 
 	for_each_online_cpu(cpu) {
-		curr_temp = intel_tcc_get_temp(cpu, false);
-		if (curr_temp < 0)
-			return curr_temp;
+		ret = intel_tcc_get_temp(cpu, &curr_temp, false);
+		if (ret < 0)
+			return ret;
 		if (!*temp || curr_temp > *temp)
 			*temp = curr_temp;
 	}
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
index 2f00fc3bf274..e964a9375722 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
@@ -27,9 +27,9 @@ static int rapl_mmio_cpu_online(unsigned int cpu)
 	if (topology_physical_package_id(cpu))
 		return 0;
 
-	rp = rapl_find_package_domain(cpu, &rapl_mmio_priv, true);
+	rp = rapl_find_package_domain_cpuslocked(cpu, &rapl_mmio_priv, true);
 	if (!rp) {
-		rp = rapl_add_package(cpu, &rapl_mmio_priv, true);
+		rp = rapl_add_package_cpuslocked(cpu, &rapl_mmio_priv, true);
 		if (IS_ERR(rp))
 			return PTR_ERR(rp);
 	}
@@ -42,14 +42,14 @@ static int rapl_mmio_cpu_down_prep(unsigned int cpu)
 	struct rapl_package *rp;
 	int lead_cpu;
 
-	rp = rapl_find_package_domain(cpu, &rapl_mmio_priv, true);
+	rp = rapl_find_package_domain_cpuslocked(cpu, &rapl_mmio_priv, true);
 	if (!rp)
 		return 0;
 
 	cpumask_clear_cpu(cpu, &rp->cpumask);
 	lead_cpu = cpumask_first(&rp->cpumask);
 	if (lead_cpu >= nr_cpu_ids)
-		rapl_remove_package(rp);
+		rapl_remove_package_cpuslocked(rp);
 	else if (rp->lead_cpu == cpu)
 		rp->lead_cpu = lead_cpu;
 	return 0;
diff --git a/drivers/thermal/intel/intel_tcc.c b/drivers/thermal/intel/intel_tcc.c
index 2e5c741c41ca..5e8b7f34b395 100644
--- a/drivers/thermal/intel/intel_tcc.c
+++ b/drivers/thermal/intel/intel_tcc.c
@@ -103,18 +103,19 @@ EXPORT_SYMBOL_NS_GPL(intel_tcc_set_offset, INTEL_TCC);
 /**
  * intel_tcc_get_temp() - returns the current temperature
  * @cpu: cpu that the MSR should be run on, nagative value means any cpu.
+ * @temp: pointer to the memory for saving cpu temperature.
  * @pkg: true: Package Thermal Sensor. false: Core Thermal Sensor.
  *
  * Get the current temperature returned by the CPU core/package level
  * thermal sensor, in degrees C.
  *
- * Return: Temperature in degrees C on success, negative error code otherwise.
+ * Return: 0 on success, negative error code otherwise.
  */
-int intel_tcc_get_temp(int cpu, bool pkg)
+int intel_tcc_get_temp(int cpu, int *temp, bool pkg)
 {
 	u32 low, high;
 	u32 msr = pkg ? MSR_IA32_PACKAGE_THERM_STATUS : MSR_IA32_THERM_STATUS;
-	int tjmax, temp, err;
+	int tjmax, err;
 
 	tjmax = intel_tcc_get_tjmax(cpu);
 	if (tjmax < 0)
@@ -131,9 +132,8 @@ int intel_tcc_get_temp(int cpu, bool pkg)
 	if (!(low & BIT(31)))
 		return -ENODATA;
 
-	temp = tjmax - ((low >> 16) & 0x7f);
+	*temp = tjmax - ((low >> 16) & 0x7f);
 
-	/* Do not allow negative CPU temperature */
-	return temp >= 0 ? temp : -ENODATA;
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(intel_tcc_get_temp, INTEL_TCC);
diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index 11a7f8108bbb..61c3d450ee60 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -108,11 +108,11 @@ static struct zone_device *pkg_temp_thermal_get_dev(unsigned int cpu)
 static int sys_get_curr_temp(struct thermal_zone_device *tzd, int *temp)
 {
 	struct zone_device *zonedev = thermal_zone_device_priv(tzd);
-	int val;
+	int val, ret;
 
-	val = intel_tcc_get_temp(zonedev->cpu, true);
-	if (val < 0)
-		return val;
+	ret = intel_tcc_get_temp(zonedev->cpu, &val, true);
+	if (ret < 0)
+		return ret;
 
 	*temp = val * 1000;
 	pr_debug("sys_get_curr_temp %d\n", *temp);
diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
index 8b0edb204844..9ee2e7283435 100644
--- a/drivers/thermal/mediatek/auxadc_thermal.c
+++ b/drivers/thermal/mediatek/auxadc_thermal.c
@@ -690,6 +690,9 @@ static const struct mtk_thermal_data mt7986_thermal_data = {
 	.adcpnp = mt7986_adcpnp,
 	.sensor_mux_values = mt7986_mux_values,
 	.version = MTK_THERMAL_V3,
+	.apmixed_buffer_ctl_reg = APMIXED_SYS_TS_CON1,
+	.apmixed_buffer_ctl_mask = GENMASK(31, 6) | BIT(3),
+	.apmixed_buffer_ctl_set = BIT(0),
 };
 
 static bool mtk_thermal_temp_is_valid(int temp)
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 44e9b09de47a..a3c68c808eeb 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1265,6 +1265,9 @@ int tb_port_update_credits(struct tb_port *port)
 	ret = tb_port_do_update_credits(port);
 	if (ret)
 		return ret;
+
+	if (!port->dual_link_port)
+		return 0;
 	return tb_port_do_update_credits(port->dual_link_port);
 }
 
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 8ca061d3bbb9..1d65055dde27 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1329,9 +1329,6 @@ static void autoconfig_irq(struct uart_8250_port *up)
 		inb_p(ICP);
 	}
 
-	if (uart_console(port))
-		console_lock();
-
 	/* forget possible initially masked and pending IRQ */
 	probe_irq_off(probe_irq_on());
 	save_mcr = serial8250_in_MCR(up);
@@ -1371,9 +1368,6 @@ static void autoconfig_irq(struct uart_8250_port *up)
 	if (port->flags & UPF_FOURPORT)
 		outb_p(save_ICP, ICP);
 
-	if (uart_console(port))
-		console_unlock();
-
 	port->irq = (irq > 0) ? irq : 0;
 }
 
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 6d0cfb2e86b4..71d0cbd74807 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2345,9 +2345,12 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	lpuart32_write(&sport->port, bd, UARTBAUD);
 	lpuart32_serial_setbrg(sport, baud);
-	lpuart32_write(&sport->port, modem, UARTMODIR);
-	lpuart32_write(&sport->port, ctrl, UARTCTRL);
+	/* disable CTS before enabling UARTCTRL_TE to avoid pending idle preamble */
+	lpuart32_write(&sport->port, modem & ~UARTMODIR_TXCTSE, UARTMODIR);
 	/* restore control register */
+	lpuart32_write(&sport->port, ctrl, UARTCTRL);
+	/* re-enable the CTS if needed */
+	lpuart32_write(&sport->port, modem, UARTMODIR);
 
 	if ((ctrl & (UARTCTRL_PE | UARTCTRL_M)) == UARTCTRL_PE)
 		sport->is_cs7 = true;
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 81557a58f86f..5545bf4a79fc 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -462,8 +462,7 @@ static void imx_uart_stop_tx(struct uart_port *port)
 	}
 }
 
-/* called with port.lock taken and irqs off */
-static void imx_uart_stop_rx(struct uart_port *port)
+static void imx_uart_stop_rx_with_loopback_ctrl(struct uart_port *port, bool loopback)
 {
 	struct imx_port *sport = (struct imx_port *)port;
 	u32 ucr1, ucr2, ucr4, uts;
@@ -485,7 +484,7 @@ static void imx_uart_stop_rx(struct uart_port *port)
 	/* See SER_RS485_ENABLED/UTS_LOOP comment in imx_uart_probe() */
 	if (port->rs485.flags & SER_RS485_ENABLED &&
 	    port->rs485.flags & SER_RS485_RTS_ON_SEND &&
-	    sport->have_rtscts && !sport->have_rtsgpio) {
+	    sport->have_rtscts && !sport->have_rtsgpio && loopback) {
 		uts = imx_uart_readl(sport, imx_uart_uts_reg(sport));
 		uts |= UTS_LOOP;
 		imx_uart_writel(sport, uts, imx_uart_uts_reg(sport));
@@ -497,6 +496,16 @@ static void imx_uart_stop_rx(struct uart_port *port)
 	imx_uart_writel(sport, ucr2, UCR2);
 }
 
+/* called with port.lock taken and irqs off */
+static void imx_uart_stop_rx(struct uart_port *port)
+{
+	/*
+	 * Stop RX and enable loopback in order to make sure RS485 bus
+	 * is not blocked. Se comment in imx_uart_probe().
+	 */
+	imx_uart_stop_rx_with_loopback_ctrl(port, true);
+}
+
 /* called with port.lock taken and irqs off */
 static void imx_uart_enable_ms(struct uart_port *port)
 {
@@ -682,9 +691,14 @@ static void imx_uart_start_tx(struct uart_port *port)
 				imx_uart_rts_inactive(sport, &ucr2);
 			imx_uart_writel(sport, ucr2, UCR2);
 
+			/*
+			 * Since we are about to transmit we can not stop RX
+			 * with loopback enabled because that will make our
+			 * transmitted data being just looped to RX.
+			 */
 			if (!(port->rs485.flags & SER_RS485_RX_DURING_TX) &&
 			    !port->rs485_rx_during_tx_gpio)
-				imx_uart_stop_rx(port);
+				imx_uart_stop_rx_with_loopback_ctrl(port, false);
 
 			sport->tx_state = WAIT_AFTER_RTS;
 
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 5aff179bf297..1a4bb55652af 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1635,13 +1635,16 @@ static unsigned short max310x_i2c_slave_addr(unsigned short addr,
 
 static int max310x_i2c_probe(struct i2c_client *client)
 {
-	const struct max310x_devtype *devtype =
-			device_get_match_data(&client->dev);
+	const struct max310x_devtype *devtype;
 	struct i2c_client *port_client;
 	struct regmap *regmaps[4];
 	unsigned int i;
 	u8 port_addr;
 
+	devtype = device_get_match_data(&client->dev);
+	if (!devtype)
+		return dev_err_probe(&client->dev, -ENODEV, "Failed to match device\n");
+
 	if (client->addr < devtype->slave_addr.min ||
 		client->addr > devtype->slave_addr.max)
 		return dev_err_probe(&client->dev, -EINVAL,
diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 7e78f97e8f43..549909644011 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -851,19 +851,21 @@ static void qcom_geni_serial_stop_tx(struct uart_port *uport)
 }
 
 static void qcom_geni_serial_send_chunk_fifo(struct uart_port *uport,
-					     unsigned int remaining)
+					     unsigned int chunk)
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	struct circ_buf *xmit = &uport->state->xmit;
-	unsigned int tx_bytes;
+	unsigned int tx_bytes, c, remaining = chunk;
 	u8 buf[BYTES_PER_FIFO_WORD];
 
 	while (remaining) {
 		memset(buf, 0, sizeof(buf));
 		tx_bytes = min(remaining, BYTES_PER_FIFO_WORD);
 
-		memcpy(buf, &xmit->buf[xmit->tail], tx_bytes);
-		uart_xmit_advance(uport, tx_bytes);
+		for (c = 0; c < tx_bytes ; c++) {
+			buf[c] = xmit->buf[xmit->tail];
+			uart_xmit_advance(uport, 1);
+		}
 
 		iowrite32_rep(uport->membase + SE_GENI_TX_FIFOn, buf, 1);
 
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 39fa9ae5099b..e383d9a10ace 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2603,7 +2603,12 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 			port->type = PORT_UNKNOWN;
 			flags |= UART_CONFIG_TYPE;
 		}
+		/* Synchronize with possible boot console. */
+		if (uart_console(port))
+			console_lock();
 		port->ops->config_port(port, flags);
+		if (uart_console(port))
+			console_unlock();
 	}
 
 	if (port->type != PORT_UNKNOWN) {
@@ -2611,6 +2616,10 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 
 		uart_report_port(drv, port);
 
+		/* Synchronize with possible boot console. */
+		if (uart_console(port))
+			console_lock();
+
 		/* Power up port for set_mctrl() */
 		uart_change_pm(state, UART_PM_STATE_ON);
 
@@ -2627,6 +2636,9 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 
 		uart_rs485_config(port);
 
+		if (uart_console(port))
+			console_unlock();
+
 		/*
 		 * If this driver supports console, and it hasn't been
 		 * successfully registered yet, try to re-register it.
diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
index 88975a4df306..72b6f4f326e2 100644
--- a/drivers/tty/serial/serial_port.c
+++ b/drivers/tty/serial/serial_port.c
@@ -46,8 +46,31 @@ static int serial_port_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static int serial_port_runtime_suspend(struct device *dev)
+{
+	struct serial_port_device *port_dev = to_serial_base_port_device(dev);
+	struct uart_port *port = port_dev->port;
+	unsigned long flags;
+	bool busy;
+
+	if (port->flags & UPF_DEAD)
+		return 0;
+
+	uart_port_lock_irqsave(port, &flags);
+	busy = __serial_port_busy(port);
+	if (busy)
+		port->ops->start_tx(port);
+	uart_port_unlock_irqrestore(port, flags);
+
+	if (busy)
+		pm_runtime_mark_last_busy(dev);
+
+	return busy ? -EBUSY : 0;
+}
+
 static DEFINE_RUNTIME_DEV_PM_OPS(serial_port_pm,
-				 NULL, serial_port_runtime_resume, NULL);
+				 serial_port_runtime_suspend,
+				 serial_port_runtime_resume, NULL);
 
 static int serial_port_probe(struct device *dev)
 {
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 6617d3a8e84c..52e6ca1ba21d 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -381,7 +381,7 @@ static void vc_uniscr_delete(struct vc_data *vc, unsigned int nr)
 		u32 *ln = vc->vc_uni_lines[vc->state.y];
 		unsigned int x = vc->state.x, cols = vc->vc_cols;
 
-		memcpy(&ln[x], &ln[x + nr], (cols - x - nr) * sizeof(*ln));
+		memmove(&ln[x], &ln[x + nr], (cols - x - nr) * sizeof(*ln));
 		memset32(&ln[cols - nr], ' ', nr);
 	}
 }
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 0f4b3f16d3d7..0d3886455375 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1397,8 +1397,10 @@ static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba, bool is_scale_up)
 
 	list_for_each_entry(clki, head, list) {
 		if (!IS_ERR_OR_NULL(clki->clk) &&
-			!strcmp(clki->name, "core_clk_unipro")) {
-			if (is_scale_up)
+		    !strcmp(clki->name, "core_clk_unipro")) {
+			if (!clki->max_freq)
+				cycles_in_1us = 150; /* default for backwards compatibility */
+			else if (is_scale_up)
 				cycles_in_1us = ceil(clki->max_freq, (1000 * 1000));
 			else
 				cycles_in_1us = ceil(clk_get_rate(clki->clk), (1000 * 1000));
diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index c553decb5461..c8262e2f2917 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -485,6 +485,7 @@ static ssize_t wdm_write
 static int service_outstanding_interrupt(struct wdm_device *desc)
 {
 	int rv = 0;
+	int used;
 
 	/* submit read urb only if the device is waiting for it */
 	if (!desc->resp_count || !--desc->resp_count)
@@ -499,7 +500,10 @@ static int service_outstanding_interrupt(struct wdm_device *desc)
 		goto out;
 	}
 
-	set_bit(WDM_RESPONDING, &desc->flags);
+	used = test_and_set_bit(WDM_RESPONDING, &desc->flags);
+	if (used)
+		goto out;
+
 	spin_unlock_irq(&desc->iuspin);
 	rv = usb_submit_urb(desc->response, GFP_KERNEL);
 	spin_lock_irq(&desc->iuspin);
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 4854d883e601..80145bd4b5c9 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -123,7 +123,6 @@ EXPORT_SYMBOL_GPL(ehci_cf_port_reset_rwsem);
 #define HUB_DEBOUNCE_STEP	  25
 #define HUB_DEBOUNCE_STABLE	 100
 
-static void hub_release(struct kref *kref);
 static int usb_reset_and_verify_device(struct usb_device *udev);
 static int hub_port_disable(struct usb_hub *hub, int port1, int set_state);
 static bool hub_port_warm_reset_required(struct usb_hub *hub, int port1,
@@ -685,14 +684,14 @@ static void kick_hub_wq(struct usb_hub *hub)
 	 */
 	intf = to_usb_interface(hub->intfdev);
 	usb_autopm_get_interface_no_resume(intf);
-	kref_get(&hub->kref);
+	hub_get(hub);
 
 	if (queue_work(hub_wq, &hub->events))
 		return;
 
 	/* the work has already been scheduled */
 	usb_autopm_put_interface_async(intf);
-	kref_put(&hub->kref, hub_release);
+	hub_put(hub);
 }
 
 void usb_kick_hub_wq(struct usb_device *hdev)
@@ -1060,7 +1059,7 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 			goto init2;
 		goto init3;
 	}
-	kref_get(&hub->kref);
+	hub_get(hub);
 
 	/* The superspeed hub except for root hub has to use Hub Depth
 	 * value as an offset into the route string to locate the bits
@@ -1308,7 +1307,7 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 		device_unlock(&hdev->dev);
 	}
 
-	kref_put(&hub->kref, hub_release);
+	hub_put(hub);
 }
 
 /* Implement the continuations for the delays above */
@@ -1724,6 +1723,16 @@ static void hub_release(struct kref *kref)
 	kfree(hub);
 }
 
+void hub_get(struct usb_hub *hub)
+{
+	kref_get(&hub->kref);
+}
+
+void hub_put(struct usb_hub *hub)
+{
+	kref_put(&hub->kref, hub_release);
+}
+
 static unsigned highspeed_hubs;
 
 static void hub_disconnect(struct usb_interface *intf)
@@ -1772,7 +1781,7 @@ static void hub_disconnect(struct usb_interface *intf)
 
 	onboard_hub_destroy_pdevs(&hub->onboard_hub_devs);
 
-	kref_put(&hub->kref, hub_release);
+	hub_put(hub);
 }
 
 static bool hub_descriptor_is_sane(struct usb_host_interface *desc)
@@ -5894,7 +5903,7 @@ static void hub_event(struct work_struct *work)
 
 	/* Balance the stuff in kick_hub_wq() and allow autosuspend */
 	usb_autopm_put_interface(intf);
-	kref_put(&hub->kref, hub_release);
+	hub_put(hub);
 
 	kcov_remote_stop();
 }
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index 43ce21c96a51..183b69dc2955 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -129,6 +129,8 @@ extern void usb_hub_remove_port_device(struct usb_hub *hub,
 extern int usb_hub_set_port_power(struct usb_device *hdev, struct usb_hub *hub,
 		int port1, bool set);
 extern struct usb_hub *usb_hub_to_struct_hub(struct usb_device *hdev);
+extern void hub_get(struct usb_hub *hub);
+extern void hub_put(struct usb_hub *hub);
 extern int hub_port_debounce(struct usb_hub *hub, int port1,
 		bool must_be_connected);
 extern int usb_clear_port_feature(struct usb_device *hdev,
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index c628c1abc907..a5776531ba4d 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -55,11 +55,22 @@ static ssize_t disable_show(struct device *dev,
 	u16 portstatus, unused;
 	bool disabled;
 	int rc;
+	struct kernfs_node *kn;
 
+	hub_get(hub);
 	rc = usb_autopm_get_interface(intf);
 	if (rc < 0)
-		return rc;
+		goto out_hub_get;
 
+	/*
+	 * Prevent deadlock if another process is concurrently
+	 * trying to unregister hdev.
+	 */
+	kn = sysfs_break_active_protection(&dev->kobj, &attr->attr);
+	if (!kn) {
+		rc = -ENODEV;
+		goto out_autopm;
+	}
 	usb_lock_device(hdev);
 	if (hub->disconnected) {
 		rc = -ENODEV;
@@ -69,9 +80,13 @@ static ssize_t disable_show(struct device *dev,
 	usb_hub_port_status(hub, port1, &portstatus, &unused);
 	disabled = !usb_port_is_power_on(hub, portstatus);
 
-out_hdev_lock:
+ out_hdev_lock:
 	usb_unlock_device(hdev);
+	sysfs_unbreak_active_protection(kn);
+ out_autopm:
 	usb_autopm_put_interface(intf);
+ out_hub_get:
+	hub_put(hub);
 
 	if (rc)
 		return rc;
@@ -89,15 +104,26 @@ static ssize_t disable_store(struct device *dev, struct device_attribute *attr,
 	int port1 = port_dev->portnum;
 	bool disabled;
 	int rc;
+	struct kernfs_node *kn;
 
 	rc = kstrtobool(buf, &disabled);
 	if (rc)
 		return rc;
 
+	hub_get(hub);
 	rc = usb_autopm_get_interface(intf);
 	if (rc < 0)
-		return rc;
+		goto out_hub_get;
 
+	/*
+	 * Prevent deadlock if another process is concurrently
+	 * trying to unregister hdev.
+	 */
+	kn = sysfs_break_active_protection(&dev->kobj, &attr->attr);
+	if (!kn) {
+		rc = -ENODEV;
+		goto out_autopm;
+	}
 	usb_lock_device(hdev);
 	if (hub->disconnected) {
 		rc = -ENODEV;
@@ -118,9 +144,13 @@ static ssize_t disable_store(struct device *dev, struct device_attribute *attr,
 	if (!rc)
 		rc = count;
 
-out_hdev_lock:
+ out_hdev_lock:
 	usb_unlock_device(hdev);
+	sysfs_unbreak_active_protection(kn);
+ out_autopm:
 	usb_autopm_put_interface(intf);
+ out_hub_get:
+	hub_put(hub);
 
 	return rc;
 }
@@ -573,7 +603,7 @@ static int match_location(struct usb_device *peer_hdev, void *p)
 	struct usb_hub *peer_hub = usb_hub_to_struct_hub(peer_hdev);
 	struct usb_device *hdev = to_usb_device(port_dev->dev.parent->parent);
 
-	if (!peer_hub)
+	if (!peer_hub || port_dev->connect_type == USB_PORT_NOT_USED)
 		return 0;
 
 	hcd = bus_to_hcd(hdev->bus);
@@ -584,7 +614,8 @@ static int match_location(struct usb_device *peer_hdev, void *p)
 
 	for (port1 = 1; port1 <= peer_hdev->maxchild; port1++) {
 		peer = peer_hub->ports[port1 - 1];
-		if (peer && peer->location == port_dev->location) {
+		if (peer && peer->connect_type != USB_PORT_NOT_USED &&
+		    peer->location == port_dev->location) {
 			link_peers_report(port_dev, peer);
 			return 1; /* done */
 		}
diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index 5d21718afb05..f91f543ec636 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -1168,14 +1168,24 @@ static ssize_t interface_authorized_store(struct device *dev,
 {
 	struct usb_interface *intf = to_usb_interface(dev);
 	bool val;
+	struct kernfs_node *kn;
 
 	if (kstrtobool(buf, &val) != 0)
 		return -EINVAL;
 
-	if (val)
+	if (val) {
 		usb_authorize_interface(intf);
-	else
-		usb_deauthorize_interface(intf);
+	} else {
+		/*
+		 * Prevent deadlock if another process is concurrently
+		 * trying to unregister intf.
+		 */
+		kn = sysfs_break_active_protection(&dev->kobj, &attr->attr);
+		if (kn) {
+			usb_deauthorize_interface(intf);
+			sysfs_unbreak_active_protection(kn);
+		}
+	}
 
 	return count;
 }
diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index c92a1da46a01..a141f83aba0c 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -729,8 +729,14 @@ struct dwc2_dregs_backup {
  * struct dwc2_hregs_backup - Holds host registers state before
  * entering partial power down
  * @hcfg:		Backup of HCFG register
+ * @hflbaddr:		Backup of HFLBADDR register
  * @haintmsk:		Backup of HAINTMSK register
+ * @hcchar:		Backup of HCCHAR register
+ * @hcsplt:		Backup of HCSPLT register
  * @hcintmsk:		Backup of HCINTMSK register
+ * @hctsiz:		Backup of HCTSIZ register
+ * @hdma:		Backup of HCDMA register
+ * @hcdmab:		Backup of HCDMAB register
  * @hprt0:		Backup of HPTR0 register
  * @hfir:		Backup of HFIR register
  * @hptxfsiz:		Backup of HPTXFSIZ register
@@ -738,8 +744,14 @@ struct dwc2_dregs_backup {
  */
 struct dwc2_hregs_backup {
 	u32 hcfg;
+	u32 hflbaddr;
 	u32 haintmsk;
+	u32 hcchar[MAX_EPS_CHANNELS];
+	u32 hcsplt[MAX_EPS_CHANNELS];
 	u32 hcintmsk[MAX_EPS_CHANNELS];
+	u32 hctsiz[MAX_EPS_CHANNELS];
+	u32 hcidma[MAX_EPS_CHANNELS];
+	u32 hcidmab[MAX_EPS_CHANNELS];
 	u32 hprt0;
 	u32 hfir;
 	u32 hptxfsiz;
@@ -1086,6 +1098,7 @@ struct dwc2_hsotg {
 	bool needs_byte_swap;
 
 	/* DWC OTG HW Release versions */
+#define DWC2_CORE_REV_4_30a	0x4f54430a
 #define DWC2_CORE_REV_2_71a	0x4f54271a
 #define DWC2_CORE_REV_2_72a     0x4f54272a
 #define DWC2_CORE_REV_2_80a	0x4f54280a
@@ -1323,6 +1336,7 @@ int dwc2_backup_global_registers(struct dwc2_hsotg *hsotg);
 int dwc2_restore_global_registers(struct dwc2_hsotg *hsotg);
 
 void dwc2_enable_acg(struct dwc2_hsotg *hsotg);
+void dwc2_wakeup_from_lpm_l1(struct dwc2_hsotg *hsotg, bool remotewakeup);
 
 /* This function should be called on every hardware interrupt. */
 irqreturn_t dwc2_handle_common_intr(int irq, void *dev);
diff --git a/drivers/usb/dwc2/core_intr.c b/drivers/usb/dwc2/core_intr.c
index 158ede753854..26d752a4c3ca 100644
--- a/drivers/usb/dwc2/core_intr.c
+++ b/drivers/usb/dwc2/core_intr.c
@@ -297,7 +297,8 @@ static void dwc2_handle_session_req_intr(struct dwc2_hsotg *hsotg)
 
 			/* Exit gadget mode clock gating. */
 			if (hsotg->params.power_down ==
-			    DWC2_POWER_DOWN_PARAM_NONE && hsotg->bus_suspended)
+			    DWC2_POWER_DOWN_PARAM_NONE && hsotg->bus_suspended &&
+			    !hsotg->params.no_clock_gating)
 				dwc2_gadget_exit_clock_gating(hsotg, 0);
 		}
 
@@ -322,10 +323,11 @@ static void dwc2_handle_session_req_intr(struct dwc2_hsotg *hsotg)
  * @hsotg: Programming view of DWC_otg controller
  *
  */
-static void dwc2_wakeup_from_lpm_l1(struct dwc2_hsotg *hsotg)
+void dwc2_wakeup_from_lpm_l1(struct dwc2_hsotg *hsotg, bool remotewakeup)
 {
 	u32 glpmcfg;
-	u32 i = 0;
+	u32 pcgctl;
+	u32 dctl;
 
 	if (hsotg->lx_state != DWC2_L1) {
 		dev_err(hsotg->dev, "Core isn't in DWC2_L1 state\n");
@@ -334,37 +336,57 @@ static void dwc2_wakeup_from_lpm_l1(struct dwc2_hsotg *hsotg)
 
 	glpmcfg = dwc2_readl(hsotg, GLPMCFG);
 	if (dwc2_is_device_mode(hsotg)) {
-		dev_dbg(hsotg->dev, "Exit from L1 state\n");
+		dev_dbg(hsotg->dev, "Exit from L1 state, remotewakeup=%d\n", remotewakeup);
 		glpmcfg &= ~GLPMCFG_ENBLSLPM;
-		glpmcfg &= ~GLPMCFG_HIRD_THRES_EN;
+		glpmcfg &= ~GLPMCFG_HIRD_THRES_MASK;
 		dwc2_writel(hsotg, glpmcfg, GLPMCFG);
 
-		do {
-			glpmcfg = dwc2_readl(hsotg, GLPMCFG);
+		pcgctl = dwc2_readl(hsotg, PCGCTL);
+		pcgctl &= ~PCGCTL_ENBL_SLEEP_GATING;
+		dwc2_writel(hsotg, pcgctl, PCGCTL);
 
-			if (!(glpmcfg & (GLPMCFG_COREL1RES_MASK |
-					 GLPMCFG_L1RESUMEOK | GLPMCFG_SLPSTS)))
-				break;
+		glpmcfg = dwc2_readl(hsotg, GLPMCFG);
+		if (glpmcfg & GLPMCFG_ENBESL) {
+			glpmcfg |= GLPMCFG_RSTRSLPSTS;
+			dwc2_writel(hsotg, glpmcfg, GLPMCFG);
+		}
+
+		if (remotewakeup) {
+			if (dwc2_hsotg_wait_bit_set(hsotg, GLPMCFG, GLPMCFG_L1RESUMEOK, 1000)) {
+				dev_warn(hsotg->dev, "%s: timeout GLPMCFG_L1RESUMEOK\n", __func__);
+				goto fail;
+				return;
+			}
+
+			dctl = dwc2_readl(hsotg, DCTL);
+			dctl |= DCTL_RMTWKUPSIG;
+			dwc2_writel(hsotg, dctl, DCTL);
 
-			udelay(1);
-		} while (++i < 200);
+			if (dwc2_hsotg_wait_bit_set(hsotg, GINTSTS, GINTSTS_WKUPINT, 1000)) {
+				dev_warn(hsotg->dev, "%s: timeout GINTSTS_WKUPINT\n", __func__);
+				goto fail;
+				return;
+			}
+		}
 
-		if (i == 200) {
-			dev_err(hsotg->dev, "Failed to exit L1 sleep state in 200us.\n");
+		glpmcfg = dwc2_readl(hsotg, GLPMCFG);
+		if (glpmcfg & GLPMCFG_COREL1RES_MASK || glpmcfg & GLPMCFG_SLPSTS ||
+		    glpmcfg & GLPMCFG_L1RESUMEOK) {
+			goto fail;
 			return;
 		}
-		dwc2_gadget_init_lpm(hsotg);
+
+		/* Inform gadget to exit from L1 */
+		call_gadget(hsotg, resume);
+		/* Change to L0 state */
+		hsotg->lx_state = DWC2_L0;
+		hsotg->bus_suspended = false;
+fail:		dwc2_gadget_init_lpm(hsotg);
 	} else {
 		/* TODO */
 		dev_err(hsotg->dev, "Host side LPM is not supported.\n");
 		return;
 	}
-
-	/* Change to L0 state */
-	hsotg->lx_state = DWC2_L0;
-
-	/* Inform gadget to exit from L1 */
-	call_gadget(hsotg, resume);
 }
 
 /*
@@ -385,7 +407,7 @@ static void dwc2_handle_wakeup_detected_intr(struct dwc2_hsotg *hsotg)
 	dev_dbg(hsotg->dev, "%s lxstate = %d\n", __func__, hsotg->lx_state);
 
 	if (hsotg->lx_state == DWC2_L1) {
-		dwc2_wakeup_from_lpm_l1(hsotg);
+		dwc2_wakeup_from_lpm_l1(hsotg, false);
 		return;
 	}
 
@@ -408,7 +430,8 @@ static void dwc2_handle_wakeup_detected_intr(struct dwc2_hsotg *hsotg)
 
 			/* Exit gadget mode clock gating. */
 			if (hsotg->params.power_down ==
-			    DWC2_POWER_DOWN_PARAM_NONE && hsotg->bus_suspended)
+			    DWC2_POWER_DOWN_PARAM_NONE && hsotg->bus_suspended &&
+			    !hsotg->params.no_clock_gating)
 				dwc2_gadget_exit_clock_gating(hsotg, 0);
 		} else {
 			/* Change to L0 state */
@@ -425,7 +448,8 @@ static void dwc2_handle_wakeup_detected_intr(struct dwc2_hsotg *hsotg)
 			}
 
 			if (hsotg->params.power_down ==
-			    DWC2_POWER_DOWN_PARAM_NONE && hsotg->bus_suspended)
+			    DWC2_POWER_DOWN_PARAM_NONE && hsotg->bus_suspended &&
+			    !hsotg->params.no_clock_gating)
 				dwc2_host_exit_clock_gating(hsotg, 1);
 
 			/*
diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index b517a7216de2..b2f6da5b65cc 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -1415,6 +1415,10 @@ static int dwc2_hsotg_ep_queue(struct usb_ep *ep, struct usb_request *req,
 		ep->name, req, req->length, req->buf, req->no_interrupt,
 		req->zero, req->short_not_ok);
 
+	if (hs->lx_state == DWC2_L1) {
+		dwc2_wakeup_from_lpm_l1(hs, true);
+	}
+
 	/* Prevent new request submission when controller is suspended */
 	if (hs->lx_state != DWC2_L0) {
 		dev_dbg(hs->dev, "%s: submit request only in active state\n",
@@ -3727,6 +3731,12 @@ static irqreturn_t dwc2_hsotg_irq(int irq, void *pw)
 		if (hsotg->in_ppd && hsotg->lx_state == DWC2_L2)
 			dwc2_exit_partial_power_down(hsotg, 0, true);
 
+		/* Exit gadget mode clock gating. */
+		if (hsotg->params.power_down ==
+		    DWC2_POWER_DOWN_PARAM_NONE && hsotg->bus_suspended &&
+		    !hsotg->params.no_clock_gating)
+			dwc2_gadget_exit_clock_gating(hsotg, 0);
+
 		hsotg->lx_state = DWC2_L0;
 	}
 
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 35c7a4df8e71..dd5b1c5691e1 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -2701,8 +2701,11 @@ enum dwc2_transaction_type dwc2_hcd_select_transactions(
 			hsotg->available_host_channels--;
 		}
 		qh = list_entry(qh_ptr, struct dwc2_qh, qh_list_entry);
-		if (dwc2_assign_and_init_hc(hsotg, qh))
+		if (dwc2_assign_and_init_hc(hsotg, qh)) {
+			if (hsotg->params.uframe_sched)
+				hsotg->available_host_channels++;
 			break;
+		}
 
 		/*
 		 * Move the QH from the periodic ready schedule to the
@@ -2735,8 +2738,11 @@ enum dwc2_transaction_type dwc2_hcd_select_transactions(
 			hsotg->available_host_channels--;
 		}
 
-		if (dwc2_assign_and_init_hc(hsotg, qh))
+		if (dwc2_assign_and_init_hc(hsotg, qh)) {
+			if (hsotg->params.uframe_sched)
+				hsotg->available_host_channels++;
 			break;
+		}
 
 		/*
 		 * Move the QH from the non-periodic inactive schedule to the
@@ -4143,6 +4149,8 @@ void dwc2_host_complete(struct dwc2_hsotg *hsotg, struct dwc2_qtd *qtd,
 			 urb->actual_length);
 
 	if (usb_pipetype(urb->pipe) == PIPE_ISOCHRONOUS) {
+		if (!hsotg->params.dma_desc_enable)
+			urb->start_frame = qtd->qh->start_active_frame;
 		urb->error_count = dwc2_hcd_urb_get_error_count(qtd->urb);
 		for (i = 0; i < urb->number_of_packets; ++i) {
 			urb->iso_frame_desc[i].actual_length =
@@ -4649,7 +4657,7 @@ static int _dwc2_hcd_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
 	}
 
 	if (hsotg->params.power_down == DWC2_POWER_DOWN_PARAM_NONE &&
-	    hsotg->bus_suspended) {
+	    hsotg->bus_suspended && !hsotg->params.no_clock_gating) {
 		if (dwc2_is_device_mode(hsotg))
 			dwc2_gadget_exit_clock_gating(hsotg, 0);
 		else
@@ -5406,9 +5414,16 @@ int dwc2_backup_host_registers(struct dwc2_hsotg *hsotg)
 	/* Backup Host regs */
 	hr = &hsotg->hr_backup;
 	hr->hcfg = dwc2_readl(hsotg, HCFG);
+	hr->hflbaddr = dwc2_readl(hsotg, HFLBADDR);
 	hr->haintmsk = dwc2_readl(hsotg, HAINTMSK);
-	for (i = 0; i < hsotg->params.host_channels; ++i)
+	for (i = 0; i < hsotg->params.host_channels; ++i) {
+		hr->hcchar[i] = dwc2_readl(hsotg, HCCHAR(i));
+		hr->hcsplt[i] = dwc2_readl(hsotg, HCSPLT(i));
 		hr->hcintmsk[i] = dwc2_readl(hsotg, HCINTMSK(i));
+		hr->hctsiz[i] = dwc2_readl(hsotg, HCTSIZ(i));
+		hr->hcidma[i] = dwc2_readl(hsotg, HCDMA(i));
+		hr->hcidmab[i] = dwc2_readl(hsotg, HCDMAB(i));
+	}
 
 	hr->hprt0 = dwc2_read_hprt0(hsotg);
 	hr->hfir = dwc2_readl(hsotg, HFIR);
@@ -5442,10 +5457,17 @@ int dwc2_restore_host_registers(struct dwc2_hsotg *hsotg)
 	hr->valid = false;
 
 	dwc2_writel(hsotg, hr->hcfg, HCFG);
+	dwc2_writel(hsotg, hr->hflbaddr, HFLBADDR);
 	dwc2_writel(hsotg, hr->haintmsk, HAINTMSK);
 
-	for (i = 0; i < hsotg->params.host_channels; ++i)
+	for (i = 0; i < hsotg->params.host_channels; ++i) {
+		dwc2_writel(hsotg, hr->hcchar[i], HCCHAR(i));
+		dwc2_writel(hsotg, hr->hcsplt[i], HCSPLT(i));
 		dwc2_writel(hsotg, hr->hcintmsk[i], HCINTMSK(i));
+		dwc2_writel(hsotg, hr->hctsiz[i], HCTSIZ(i));
+		dwc2_writel(hsotg, hr->hcidma[i], HCDMA(i));
+		dwc2_writel(hsotg, hr->hcidmab[i], HCDMAB(i));
+	}
 
 	dwc2_writel(hsotg, hr->hprt0, HPRT0);
 	dwc2_writel(hsotg, hr->hfir, HFIR);
@@ -5610,10 +5632,12 @@ int dwc2_host_exit_hibernation(struct dwc2_hsotg *hsotg, int rem_wakeup,
 	dwc2_writel(hsotg, hr->hcfg, HCFG);
 
 	/* De-assert Wakeup Logic */
-	gpwrdn = dwc2_readl(hsotg, GPWRDN);
-	gpwrdn &= ~GPWRDN_PMUACTV;
-	dwc2_writel(hsotg, gpwrdn, GPWRDN);
-	udelay(10);
+	if (!(rem_wakeup && hsotg->hw_params.snpsid >= DWC2_CORE_REV_4_30a)) {
+		gpwrdn = dwc2_readl(hsotg, GPWRDN);
+		gpwrdn &= ~GPWRDN_PMUACTV;
+		dwc2_writel(hsotg, gpwrdn, GPWRDN);
+		udelay(10);
+	}
 
 	hprt0 = hr->hprt0;
 	hprt0 |= HPRT0_PWR;
@@ -5638,6 +5662,13 @@ int dwc2_host_exit_hibernation(struct dwc2_hsotg *hsotg, int rem_wakeup,
 		hprt0 |= HPRT0_RES;
 		dwc2_writel(hsotg, hprt0, HPRT0);
 
+		/* De-assert Wakeup Logic */
+		if ((rem_wakeup && hsotg->hw_params.snpsid >= DWC2_CORE_REV_4_30a)) {
+			gpwrdn = dwc2_readl(hsotg, GPWRDN);
+			gpwrdn &= ~GPWRDN_PMUACTV;
+			dwc2_writel(hsotg, gpwrdn, GPWRDN);
+			udelay(10);
+		}
 		/* Wait for Resume time and then program HPRT again */
 		mdelay(100);
 		hprt0 &= ~HPRT0_RES;
diff --git a/drivers/usb/dwc2/hcd_ddma.c b/drivers/usb/dwc2/hcd_ddma.c
index 6b4d825e97a2..79582b102c7e 100644
--- a/drivers/usb/dwc2/hcd_ddma.c
+++ b/drivers/usb/dwc2/hcd_ddma.c
@@ -559,7 +559,7 @@ static void dwc2_init_isoc_dma_desc(struct dwc2_hsotg *hsotg,
 	idx = qh->td_last;
 	inc = qh->host_interval;
 	hsotg->frame_number = dwc2_hcd_get_frame_number(hsotg);
-	cur_idx = dwc2_frame_list_idx(hsotg->frame_number);
+	cur_idx = idx;
 	next_idx = dwc2_desclist_idx_inc(qh->td_last, inc, qh->dev_speed);
 
 	/*
@@ -866,6 +866,8 @@ static int dwc2_cmpl_host_isoc_dma_desc(struct dwc2_hsotg *hsotg,
 {
 	struct dwc2_dma_desc *dma_desc;
 	struct dwc2_hcd_iso_packet_desc *frame_desc;
+	u16 frame_desc_idx;
+	struct urb *usb_urb = qtd->urb->priv;
 	u16 remain = 0;
 	int rc = 0;
 
@@ -878,8 +880,11 @@ static int dwc2_cmpl_host_isoc_dma_desc(struct dwc2_hsotg *hsotg,
 				DMA_FROM_DEVICE);
 
 	dma_desc = &qh->desc_list[idx];
+	frame_desc_idx = (idx - qtd->isoc_td_first) & (usb_urb->number_of_packets - 1);
 
-	frame_desc = &qtd->urb->iso_descs[qtd->isoc_frame_index_last];
+	frame_desc = &qtd->urb->iso_descs[frame_desc_idx];
+	if (idx == qtd->isoc_td_first)
+		usb_urb->start_frame = dwc2_hcd_get_frame_number(hsotg);
 	dma_desc->buf = (u32)(qtd->urb->dma + frame_desc->offset);
 	if (chan->ep_is_in)
 		remain = (dma_desc->status & HOST_DMA_ISOC_NBYTES_MASK) >>
@@ -900,7 +905,7 @@ static int dwc2_cmpl_host_isoc_dma_desc(struct dwc2_hsotg *hsotg,
 		frame_desc->status = 0;
 	}
 
-	if (++qtd->isoc_frame_index == qtd->urb->packet_count) {
+	if (++qtd->isoc_frame_index == usb_urb->number_of_packets) {
 		/*
 		 * urb->status is not used for isoc transfers here. The
 		 * individual frame_desc status are used instead.
@@ -1005,11 +1010,11 @@ static void dwc2_complete_isoc_xfer_ddma(struct dwc2_hsotg *hsotg,
 				return;
 			idx = dwc2_desclist_idx_inc(idx, qh->host_interval,
 						    chan->speed);
-			if (!rc)
+			if (rc == 0)
 				continue;
 
-			if (rc == DWC2_CMPL_DONE)
-				break;
+			if (rc == DWC2_CMPL_DONE || rc == DWC2_CMPL_STOP)
+				goto stop_scan;
 
 			/* rc == DWC2_CMPL_STOP */
 
diff --git a/drivers/usb/dwc2/hw.h b/drivers/usb/dwc2/hw.h
index 13abdd5f6752..12f8c7f86dc9 100644
--- a/drivers/usb/dwc2/hw.h
+++ b/drivers/usb/dwc2/hw.h
@@ -698,7 +698,7 @@
 #define TXSTS_QTOP_TOKEN_MASK		(0x3 << 25)
 #define TXSTS_QTOP_TOKEN_SHIFT		25
 #define TXSTS_QTOP_TERMINATE		BIT(24)
-#define TXSTS_QSPCAVAIL_MASK		(0xff << 16)
+#define TXSTS_QSPCAVAIL_MASK		(0x7f << 16)
 #define TXSTS_QSPCAVAIL_SHIFT		16
 #define TXSTS_FSPCAVAIL_MASK		(0xffff << 0)
 #define TXSTS_FSPCAVAIL_SHIFT		0
diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index b1d48019e944..7b84416dfc2b 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -331,7 +331,7 @@ static void dwc2_driver_remove(struct platform_device *dev)
 
 	/* Exit clock gating when driver is removed. */
 	if (hsotg->params.power_down == DWC2_POWER_DOWN_PARAM_NONE &&
-	    hsotg->bus_suspended) {
+	    hsotg->bus_suspended && !hsotg->params.no_clock_gating) {
 		if (dwc2_is_device_mode(hsotg))
 			dwc2_gadget_exit_clock_gating(hsotg, 0);
 		else
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index f50b5575d588..8de1ab851793 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1507,6 +1507,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	else
 		dwc->sysdev = dwc->dev;
 
+	dwc->sys_wakeup = device_may_wakeup(dwc->sysdev);
+
 	ret = device_property_read_string(dev, "usb-psy-name", &usb_psy_name);
 	if (ret >= 0) {
 		dwc->usb_psy = power_supply_get_by_name(usb_psy_name);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index efe6caf4d0e8..80265ef608aa 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1127,6 +1127,7 @@ struct dwc3_scratchpad_array {
  *	3	- Reserved
  * @dis_metastability_quirk: set to disable metastability quirk.
  * @dis_split_quirk: set to disable split boundary.
+ * @sys_wakeup: set if the device may do system wakeup.
  * @wakeup_configured: set if the device is configured for remote wakeup.
  * @suspended: set to track suspend event due to U3/L2.
  * @imod_interval: set the interrupt moderation interval in 250ns
@@ -1350,6 +1351,7 @@ struct dwc3 {
 
 	unsigned		dis_split_quirk:1;
 	unsigned		async_callbacks:1;
+	unsigned		sys_wakeup:1;
 	unsigned		wakeup_configured:1;
 	unsigned		suspended:1;
 
diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 90a587bc29b7..ea6e29091c0c 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -267,21 +267,15 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int dwc3_ti_remove_core(struct device *dev, void *c)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-
-	platform_device_unregister(pdev);
-	return 0;
-}
-
 static void dwc3_ti_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct dwc3_am62 *am62 = platform_get_drvdata(pdev);
 	u32 reg;
 
-	device_for_each_child(dev, NULL, dwc3_ti_remove_core);
+	pm_runtime_get_sync(dev);
+	device_init_wakeup(dev, false);
+	of_platform_depopulate(dev);
 
 	/* Clear mode valid bit */
 	reg = dwc3_ti_readl(am62, USBSS_MODE_CONTROL);
@@ -289,7 +283,6 @@ static void dwc3_ti_remove(struct platform_device *pdev)
 	dwc3_ti_writel(am62, USBSS_MODE_CONTROL, reg);
 
 	pm_runtime_put_sync(dev);
-	clk_disable_unprepare(am62->usb2_refclk);
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
 }
diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 39564e17f3b0..497deed38c0c 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -51,7 +51,6 @@
 #define PCI_DEVICE_ID_INTEL_MTLP		0x7ec1
 #define PCI_DEVICE_ID_INTEL_MTLS		0x7f6f
 #define PCI_DEVICE_ID_INTEL_MTL			0x7e7e
-#define PCI_DEVICE_ID_INTEL_ARLH		0x7ec1
 #define PCI_DEVICE_ID_INTEL_ARLH_PCH		0x777e
 #define PCI_DEVICE_ID_INTEL_TGL			0x9a15
 #define PCI_DEVICE_ID_AMD_MR			0x163a
@@ -423,7 +422,6 @@ static const struct pci_device_id dwc3_pci_id_table[] = {
 	{ PCI_DEVICE_DATA(INTEL, MTLP, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, MTL, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, MTLS, &dwc3_pci_intel_swnode) },
-	{ PCI_DEVICE_DATA(INTEL, ARLH, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, ARLH_PCH, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, TGL, &dwc3_pci_intel_swnode) },
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 28f49400f3e8..07820b1a88a2 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2968,6 +2968,9 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 	dwc->gadget_driver	= driver;
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	if (dwc->sys_wakeup)
+		device_wakeup_enable(dwc->sysdev);
+
 	return 0;
 }
 
@@ -2983,6 +2986,9 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
 	struct dwc3		*dwc = gadget_to_dwc(g);
 	unsigned long		flags;
 
+	if (dwc->sys_wakeup)
+		device_wakeup_disable(dwc->sysdev);
+
 	spin_lock_irqsave(&dwc->lock, flags);
 	dwc->gadget_driver	= NULL;
 	dwc->max_cfg_eps = 0;
@@ -4664,6 +4670,10 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	else
 		dwc3_gadget_set_speed(dwc->gadget, dwc->maximum_speed);
 
+	/* No system wakeup if no gadget driver bound */
+	if (dwc->sys_wakeup)
+		device_wakeup_disable(dwc->sysdev);
+
 	return 0;
 
 err5:
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index 43230915323c..f6a020d77fa1 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -123,6 +123,14 @@ int dwc3_host_init(struct dwc3 *dwc)
 		goto err;
 	}
 
+	if (dwc->sys_wakeup) {
+		/* Restore wakeup setting if switched from device */
+		device_wakeup_enable(dwc->sysdev);
+
+		/* Pass on wakeup setting to the new xhci platform device */
+		device_init_wakeup(&xhci->dev, true);
+	}
+
 	return 0;
 err:
 	platform_device_put(xhci);
@@ -131,6 +139,9 @@ int dwc3_host_init(struct dwc3 *dwc)
 
 void dwc3_host_exit(struct dwc3 *dwc)
 {
+	if (dwc->sys_wakeup)
+		device_init_wakeup(&dwc->xhci->dev, false);
+
 	platform_device_unregister(dwc->xhci);
 	dwc->xhci = NULL;
 }
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index efe3e3b85769..fdd0fc7b8f25 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -831,7 +831,7 @@ static void ffs_user_copy_worker(struct work_struct *work)
 	io_data->kiocb->ki_complete(io_data->kiocb, ret);
 
 	if (io_data->ffs->ffs_eventfd && !kiocb_has_eventfd)
-		eventfd_signal(io_data->ffs->ffs_eventfd, 1);
+		eventfd_signal(io_data->ffs->ffs_eventfd);
 
 	if (io_data->read)
 		kfree(io_data->to_free);
@@ -2738,7 +2738,7 @@ static void __ffs_event_add(struct ffs_data *ffs,
 	ffs->ev.types[ffs->ev.count++] = type;
 	wake_up_locked(&ffs->ev.waitq);
 	if (ffs->ffs_eventfd)
-		eventfd_signal(ffs->ffs_eventfd, 1);
+		eventfd_signal(ffs->ffs_eventfd);
 }
 
 static void ffs_event_add(struct ffs_data *ffs,
diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index 5712883a7527..f3456b8bf415 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1333,7 +1333,7 @@ static int ncm_unwrap_ntb(struct gether *port,
 	if (to_process == 1 &&
 	    (*(unsigned char *)(ntb_ptr + block_len) == 0x00)) {
 		to_process--;
-	} else if (to_process > 0) {
+	} else if ((to_process > 0) && (block_len != 0)) {
 		ntb_ptr = (unsigned char *)(ntb_ptr + block_len);
 		goto parse_ntb;
 	}
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index d59f94464b87..8ac29f7230fc 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -292,7 +292,9 @@ int usb_ep_queue(struct usb_ep *ep,
 {
 	int ret = 0;
 
-	if (WARN_ON_ONCE(!ep->enabled && ep->address)) {
+	if (!ep->enabled && ep->address) {
+		pr_debug("USB gadget: queue request to disabled ep 0x%x (%s)\n",
+				 ep->address, ep->name);
 		ret = -ESHUTDOWN;
 		goto out;
 	}
diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index cb85168fd00c..7aa46d426f31 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -3491,8 +3491,8 @@ static void tegra_xudc_device_params_init(struct tegra_xudc *xudc)
 
 static int tegra_xudc_phy_get(struct tegra_xudc *xudc)
 {
-	int err = 0, usb3;
-	unsigned int i;
+	int err = 0, usb3_companion_port;
+	unsigned int i, j;
 
 	xudc->utmi_phy = devm_kcalloc(xudc->dev, xudc->soc->num_phys,
 					   sizeof(*xudc->utmi_phy), GFP_KERNEL);
@@ -3520,7 +3520,7 @@ static int tegra_xudc_phy_get(struct tegra_xudc *xudc)
 		if (IS_ERR(xudc->utmi_phy[i])) {
 			err = PTR_ERR(xudc->utmi_phy[i]);
 			dev_err_probe(xudc->dev, err,
-				      "failed to get usb2-%d PHY\n", i);
+				"failed to get PHY for phy-name usb2-%d\n", i);
 			goto clean_up;
 		} else if (xudc->utmi_phy[i]) {
 			/* Get usb-phy, if utmi phy is available */
@@ -3539,19 +3539,30 @@ static int tegra_xudc_phy_get(struct tegra_xudc *xudc)
 		}
 
 		/* Get USB3 phy */
-		usb3 = tegra_xusb_padctl_get_usb3_companion(xudc->padctl, i);
-		if (usb3 < 0)
+		usb3_companion_port = tegra_xusb_padctl_get_usb3_companion(xudc->padctl, i);
+		if (usb3_companion_port < 0)
 			continue;
 
-		snprintf(phy_name, sizeof(phy_name), "usb3-%d", usb3);
-		xudc->usb3_phy[i] = devm_phy_optional_get(xudc->dev, phy_name);
-		if (IS_ERR(xudc->usb3_phy[i])) {
-			err = PTR_ERR(xudc->usb3_phy[i]);
-			dev_err_probe(xudc->dev, err,
-				      "failed to get usb3-%d PHY\n", usb3);
-			goto clean_up;
-		} else if (xudc->usb3_phy[i])
-			dev_dbg(xudc->dev, "usb3-%d PHY registered", usb3);
+		for (j = 0; j < xudc->soc->num_phys; j++) {
+			snprintf(phy_name, sizeof(phy_name), "usb3-%d", j);
+			xudc->usb3_phy[i] = devm_phy_optional_get(xudc->dev, phy_name);
+			if (IS_ERR(xudc->usb3_phy[i])) {
+				err = PTR_ERR(xudc->usb3_phy[i]);
+				dev_err_probe(xudc->dev, err,
+					"failed to get PHY for phy-name usb3-%d\n", j);
+				goto clean_up;
+			} else if (xudc->usb3_phy[i]) {
+				int usb2_port =
+					tegra_xusb_padctl_get_port_number(xudc->utmi_phy[i]);
+				int usb3_port =
+					tegra_xusb_padctl_get_port_number(xudc->usb3_phy[i]);
+				if (usb3_port == usb3_companion_port) {
+					dev_dbg(xudc->dev, "USB2 port %d is paired with USB3 port %d for device mode port %d\n",
+					 usb2_port, usb3_port, i);
+					break;
+				}
+			}
+		}
 	}
 
 	return err;
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 9673354d70d5..2647245d5b35 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -326,7 +326,13 @@ static unsigned int xhci_ring_expansion_needed(struct xhci_hcd *xhci, struct xhc
 	/* how many trbs will be queued past the enqueue segment? */
 	trbs_past_seg = enq_used + num_trbs - (TRBS_PER_SEGMENT - 1);
 
-	if (trbs_past_seg <= 0)
+	/*
+	 * Consider expanding the ring already if num_trbs fills the current
+	 * segment (i.e. trbs_past_seg == 0), not only when num_trbs goes into
+	 * the next segment. Avoids confusing full ring with special empty ring
+	 * case below
+	 */
+	if (trbs_past_seg < 0)
 		return 0;
 
 	/* Empty ring special case, enqueue stuck on link trb while dequeue advanced */
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 884b0898d9c9..943b87d15f7b 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1202,6 +1202,8 @@ static int xhci_map_temp_buffer(struct usb_hcd *hcd, struct urb *urb)
 
 	temp = kzalloc_node(buf_len, GFP_ATOMIC,
 			    dev_to_node(hcd->self.sysdev));
+	if (!temp)
+		return -ENOMEM;
 
 	if (usb_urb_dir_out(urb))
 		sg_pcopy_to_buffer(urb->sg, urb->num_sgs,
diff --git a/drivers/usb/misc/usb-ljca.c b/drivers/usb/misc/usb-ljca.c
index 35770e608c64..2d30fc1be306 100644
--- a/drivers/usb/misc/usb-ljca.c
+++ b/drivers/usb/misc/usb-ljca.c
@@ -518,8 +518,10 @@ static int ljca_new_client_device(struct ljca_adapter *adap, u8 type, u8 id,
 	int ret;
 
 	client = kzalloc(sizeof *client, GFP_KERNEL);
-	if (!client)
+	if (!client) {
+		kfree(data);
 		return -ENOMEM;
+	}
 
 	client->type = type;
 	client->id = id;
@@ -535,8 +537,10 @@ static int ljca_new_client_device(struct ljca_adapter *adap, u8 type, u8 id,
 	auxdev->dev.release = ljca_auxdev_release;
 
 	ret = auxiliary_device_init(auxdev);
-	if (ret)
+	if (ret) {
+		kfree(data);
 		goto err_free;
+	}
 
 	ljca_auxdev_acpi_bind(adap, auxdev, adr, id);
 
@@ -590,12 +594,8 @@ static int ljca_enumerate_gpio(struct ljca_adapter *adap)
 		valid_pin[i] = get_unaligned_le32(&desc->bank_desc[i].valid_pins);
 	bitmap_from_arr32(gpio_info->valid_pin_map, valid_pin, gpio_num);
 
-	ret = ljca_new_client_device(adap, LJCA_CLIENT_GPIO, 0, "ljca-gpio",
+	return ljca_new_client_device(adap, LJCA_CLIENT_GPIO, 0, "ljca-gpio",
 				     gpio_info, LJCA_GPIO_ACPI_ADR);
-	if (ret)
-		kfree(gpio_info);
-
-	return ret;
 }
 
 static int ljca_enumerate_i2c(struct ljca_adapter *adap)
@@ -629,10 +629,8 @@ static int ljca_enumerate_i2c(struct ljca_adapter *adap)
 		ret = ljca_new_client_device(adap, LJCA_CLIENT_I2C, i,
 					     "ljca-i2c", i2c_info,
 					     LJCA_I2C1_ACPI_ADR + i);
-		if (ret) {
-			kfree(i2c_info);
+		if (ret)
 			return ret;
-		}
 	}
 
 	return 0;
@@ -669,10 +667,8 @@ static int ljca_enumerate_spi(struct ljca_adapter *adap)
 		ret = ljca_new_client_device(adap, LJCA_CLIENT_SPI, i,
 					     "ljca-spi", spi_info,
 					     LJCA_SPI1_ACPI_ADR + i);
-		if (ret) {
-			kfree(spi_info);
+		if (ret)
 			return ret;
-		}
 	}
 
 	return 0;
diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic.c
index b855d291dfe6..770081b828a4 100644
--- a/drivers/usb/phy/phy-generic.c
+++ b/drivers/usb/phy/phy-generic.c
@@ -268,13 +268,6 @@ int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_generic *nop)
 		return dev_err_probe(dev, PTR_ERR(nop->vbus_draw),
 				     "could not get vbus regulator\n");
 
-	nop->vbus_draw = devm_regulator_get_exclusive(dev, "vbus");
-	if (PTR_ERR(nop->vbus_draw) == -ENODEV)
-		nop->vbus_draw = NULL;
-	if (IS_ERR(nop->vbus_draw))
-		return dev_err_probe(dev, PTR_ERR(nop->vbus_draw),
-				     "could not get vbus regulator\n");
-
 	nop->dev		= dev;
 	nop->phy.dev		= nop->dev;
 	nop->phy.label		= "nop-xceiv";
diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 923e0ed85444..21fd26609252 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -56,6 +56,8 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x0471, 0x066A) }, /* AKTAKOM ACE-1001 cable */
 	{ USB_DEVICE(0x0489, 0xE000) }, /* Pirelli Broadband S.p.A, DP-L10 SIP/GSM Mobile */
 	{ USB_DEVICE(0x0489, 0xE003) }, /* Pirelli Broadband S.p.A, DP-L10 SIP/GSM Mobile */
+	{ USB_DEVICE(0x04BF, 0x1301) }, /* TDK Corporation NC0110013M - Network Controller */
+	{ USB_DEVICE(0x04BF, 0x1303) }, /* TDK Corporation MM0110113M - i3 Micro Module */
 	{ USB_DEVICE(0x0745, 0x1000) }, /* CipherLab USB CCD Barcode Scanner 1000 */
 	{ USB_DEVICE(0x0846, 0x1100) }, /* NetGear Managed Switch M4100 series, M5300 series, M7100 series */
 	{ USB_DEVICE(0x08e6, 0x5501) }, /* Gemalto Prox-PU/CU contactless smartcard reader */
@@ -144,6 +146,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x10C4, 0x85EA) }, /* AC-Services IBUS-IF */
 	{ USB_DEVICE(0x10C4, 0x85EB) }, /* AC-Services CIS-IBUS */
 	{ USB_DEVICE(0x10C4, 0x85F8) }, /* Virtenio Preon32 */
+	{ USB_DEVICE(0x10C4, 0x863C) }, /* MGP Instruments PDS100 */
 	{ USB_DEVICE(0x10C4, 0x8664) }, /* AC-Services CAN-IF */
 	{ USB_DEVICE(0x10C4, 0x8665) }, /* AC-Services OBD-IF */
 	{ USB_DEVICE(0x10C4, 0x87ED) }, /* IMST USB-Stick for Smart Meter */
@@ -177,6 +180,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x10C4, 0xF004) }, /* Elan Digital Systems USBcount50 */
 	{ USB_DEVICE(0x10C5, 0xEA61) }, /* Silicon Labs MobiData GPRS USB Modem */
 	{ USB_DEVICE(0x10CE, 0xEA6A) }, /* Silicon Labs MobiData GPRS USB Modem 100EU */
+	{ USB_DEVICE(0x11CA, 0x0212) }, /* Verifone USB to Printer (UART, CP2102) */
 	{ USB_DEVICE(0x12B8, 0xEC60) }, /* Link G4 ECU */
 	{ USB_DEVICE(0x12B8, 0xEC62) }, /* Link G4+ ECU */
 	{ USB_DEVICE(0x13AD, 0x9999) }, /* Baltech card reader */
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 13a56783830d..22d01a0f10fb 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1077,6 +1077,8 @@ static const struct usb_device_id id_table_combined[] = {
 		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
 	{ USB_DEVICE(FTDI_VID, FTDI_FALCONIA_JTAG_UNBUF_PID),
 		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
+	/* GMC devices */
+	{ USB_DEVICE(GMC_VID, GMC_Z216C_PID) },
 	{ }					/* Terminating entry */
 };
 
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index 21a2b5a25fc0..5ee60ba2a73c 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -1606,3 +1606,9 @@
 #define UBLOX_VID			0x1546
 #define UBLOX_C099F9P_ZED_PID		0x0502
 #define UBLOX_C099F9P_ODIN_PID		0x0503
+
+/*
+ * GMC devices
+ */
+#define GMC_VID				0x1cd7
+#define GMC_Z216C_PID			0x0217 /* GMC Z216C Adapter IR-USB */
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 2ae124c49d44..55a65d941ccb 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -613,6 +613,11 @@ static void option_instat_callback(struct urb *urb);
 /* Luat Air72*U series based on UNISOC UIS8910 uses UNISOC's vendor ID */
 #define LUAT_PRODUCT_AIR720U			0x4e00
 
+/* MeiG Smart Technology products */
+#define MEIGSMART_VENDOR_ID			0x2dee
+/* MeiG Smart SLM320 based on UNISOC UIS8910 */
+#define MEIGSMART_PRODUCT_SLM320		0x4d41
+
 /* Device flags */
 
 /* Highest interface number which can be used with NCTRL() and RSVD() */
@@ -2282,6 +2287,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, TOZED_PRODUCT_LT70C, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, LUAT_PRODUCT_AIR720U, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SLM320, 0xff, 0, 0) },
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);
diff --git a/drivers/usb/storage/isd200.c b/drivers/usb/storage/isd200.c
index 4e0eef1440b7..300aeef160e7 100644
--- a/drivers/usb/storage/isd200.c
+++ b/drivers/usb/storage/isd200.c
@@ -1105,7 +1105,7 @@ static void isd200_dump_driveid(struct us_data *us, u16 *id)
 static int isd200_get_inquiry_data( struct us_data *us )
 {
 	struct isd200_info *info = (struct isd200_info *)us->extra;
-	int retStatus = ISD200_GOOD;
+	int retStatus;
 	u16 *id = info->id;
 
 	usb_stor_dbg(us, "Entering isd200_get_inquiry_data\n");
@@ -1137,6 +1137,13 @@ static int isd200_get_inquiry_data( struct us_data *us )
 				isd200_fix_driveid(id);
 				isd200_dump_driveid(us, id);
 
+				/* Prevent division by 0 in isd200_scsi_to_ata() */
+				if (id[ATA_ID_HEADS] == 0 || id[ATA_ID_SECTORS] == 0) {
+					usb_stor_dbg(us, "   Invalid ATA Identify data\n");
+					retStatus = ISD200_ERROR;
+					goto Done;
+				}
+
 				memset(&info->InquiryData, 0, sizeof(info->InquiryData));
 
 				/* Standard IDE interface only supports disks */
@@ -1202,6 +1209,7 @@ static int isd200_get_inquiry_data( struct us_data *us )
 		}
 	}
 
+ Done:
 	usb_stor_dbg(us, "Leaving isd200_get_inquiry_data %08X\n", retStatus);
 
 	return(retStatus);
@@ -1481,22 +1489,27 @@ static int isd200_init_info(struct us_data *us)
 
 static int isd200_Initialization(struct us_data *us)
 {
+	int rc = 0;
+
 	usb_stor_dbg(us, "ISD200 Initialization...\n");
 
 	/* Initialize ISD200 info struct */
 
-	if (isd200_init_info(us) == ISD200_ERROR) {
+	if (isd200_init_info(us) < 0) {
 		usb_stor_dbg(us, "ERROR Initializing ISD200 Info struct\n");
+		rc = -ENOMEM;
 	} else {
 		/* Get device specific data */
 
-		if (isd200_get_inquiry_data(us) != ISD200_GOOD)
+		if (isd200_get_inquiry_data(us) != ISD200_GOOD) {
 			usb_stor_dbg(us, "ISD200 Initialization Failure\n");
-		else
+			rc = -EINVAL;
+		} else {
 			usb_stor_dbg(us, "ISD200 Initialization complete\n");
+		}
 	}
 
-	return 0;
+	return rc;
 }
 
 
diff --git a/drivers/usb/storage/uas.c b/drivers/usb/storage/uas.c
index 299a6767b7b3..d002eead62b4 100644
--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -533,7 +533,7 @@ static struct urb *uas_alloc_cmd_urb(struct uas_dev_info *devinfo, gfp_t gfp,
  * daft to me.
  */
 
-static struct urb *uas_submit_sense_urb(struct scsi_cmnd *cmnd, gfp_t gfp)
+static int uas_submit_sense_urb(struct scsi_cmnd *cmnd, gfp_t gfp)
 {
 	struct uas_dev_info *devinfo = cmnd->device->hostdata;
 	struct urb *urb;
@@ -541,30 +541,28 @@ static struct urb *uas_submit_sense_urb(struct scsi_cmnd *cmnd, gfp_t gfp)
 
 	urb = uas_alloc_sense_urb(devinfo, gfp, cmnd);
 	if (!urb)
-		return NULL;
+		return -ENOMEM;
 	usb_anchor_urb(urb, &devinfo->sense_urbs);
 	err = usb_submit_urb(urb, gfp);
 	if (err) {
 		usb_unanchor_urb(urb);
 		uas_log_cmd_state(cmnd, "sense submit err", err);
 		usb_free_urb(urb);
-		return NULL;
 	}
-	return urb;
+	return err;
 }
 
 static int uas_submit_urbs(struct scsi_cmnd *cmnd,
 			   struct uas_dev_info *devinfo)
 {
 	struct uas_cmd_info *cmdinfo = scsi_cmd_priv(cmnd);
-	struct urb *urb;
 	int err;
 
 	lockdep_assert_held(&devinfo->lock);
 	if (cmdinfo->state & SUBMIT_STATUS_URB) {
-		urb = uas_submit_sense_urb(cmnd, GFP_ATOMIC);
-		if (!urb)
-			return SCSI_MLQUEUE_DEVICE_BUSY;
+		err = uas_submit_sense_urb(cmnd, GFP_ATOMIC);
+		if (err)
+			return err;
 		cmdinfo->state &= ~SUBMIT_STATUS_URB;
 	}
 
@@ -572,7 +570,7 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,
 		cmdinfo->data_in_urb = uas_alloc_data_urb(devinfo, GFP_ATOMIC,
 							cmnd, DMA_FROM_DEVICE);
 		if (!cmdinfo->data_in_urb)
-			return SCSI_MLQUEUE_DEVICE_BUSY;
+			return -ENOMEM;
 		cmdinfo->state &= ~ALLOC_DATA_IN_URB;
 	}
 
@@ -582,7 +580,7 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,
 		if (err) {
 			usb_unanchor_urb(cmdinfo->data_in_urb);
 			uas_log_cmd_state(cmnd, "data in submit err", err);
-			return SCSI_MLQUEUE_DEVICE_BUSY;
+			return err;
 		}
 		cmdinfo->state &= ~SUBMIT_DATA_IN_URB;
 		cmdinfo->state |= DATA_IN_URB_INFLIGHT;
@@ -592,7 +590,7 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,
 		cmdinfo->data_out_urb = uas_alloc_data_urb(devinfo, GFP_ATOMIC,
 							cmnd, DMA_TO_DEVICE);
 		if (!cmdinfo->data_out_urb)
-			return SCSI_MLQUEUE_DEVICE_BUSY;
+			return -ENOMEM;
 		cmdinfo->state &= ~ALLOC_DATA_OUT_URB;
 	}
 
@@ -602,7 +600,7 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,
 		if (err) {
 			usb_unanchor_urb(cmdinfo->data_out_urb);
 			uas_log_cmd_state(cmnd, "data out submit err", err);
-			return SCSI_MLQUEUE_DEVICE_BUSY;
+			return err;
 		}
 		cmdinfo->state &= ~SUBMIT_DATA_OUT_URB;
 		cmdinfo->state |= DATA_OUT_URB_INFLIGHT;
@@ -611,7 +609,7 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,
 	if (cmdinfo->state & ALLOC_CMD_URB) {
 		cmdinfo->cmd_urb = uas_alloc_cmd_urb(devinfo, GFP_ATOMIC, cmnd);
 		if (!cmdinfo->cmd_urb)
-			return SCSI_MLQUEUE_DEVICE_BUSY;
+			return -ENOMEM;
 		cmdinfo->state &= ~ALLOC_CMD_URB;
 	}
 
@@ -621,7 +619,7 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,
 		if (err) {
 			usb_unanchor_urb(cmdinfo->cmd_urb);
 			uas_log_cmd_state(cmnd, "cmd submit err", err);
-			return SCSI_MLQUEUE_DEVICE_BUSY;
+			return err;
 		}
 		cmdinfo->cmd_urb = NULL;
 		cmdinfo->state &= ~SUBMIT_CMD_URB;
@@ -698,7 +696,7 @@ static int uas_queuecommand_lck(struct scsi_cmnd *cmnd)
 	 * of queueing, no matter how fatal the error
 	 */
 	if (err == -ENODEV) {
-		set_host_byte(cmnd, DID_ERROR);
+		set_host_byte(cmnd, DID_NO_CONNECT);
 		scsi_done(cmnd);
 		goto zombie;
 	}
diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index f81bec0c7b86..f8ea3054be54 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -559,16 +559,21 @@ static ssize_t hpd_show(struct device *dev, struct device_attribute *attr, char
 }
 static DEVICE_ATTR_RO(hpd);
 
-static struct attribute *dp_altmode_attrs[] = {
+static struct attribute *displayport_attrs[] = {
 	&dev_attr_configuration.attr,
 	&dev_attr_pin_assignment.attr,
 	&dev_attr_hpd.attr,
 	NULL
 };
 
-static const struct attribute_group dp_altmode_group = {
+static const struct attribute_group displayport_group = {
 	.name = "displayport",
-	.attrs = dp_altmode_attrs,
+	.attrs = displayport_attrs,
+};
+
+static const struct attribute_group *displayport_groups[] = {
+	&displayport_group,
+	NULL,
 };
 
 int dp_altmode_probe(struct typec_altmode *alt)
@@ -576,7 +581,6 @@ int dp_altmode_probe(struct typec_altmode *alt)
 	const struct typec_altmode *port = typec_altmode_get_partner(alt);
 	struct fwnode_handle *fwnode;
 	struct dp_altmode *dp;
-	int ret;
 
 	/* FIXME: Port can only be DFP_U. */
 
@@ -587,10 +591,6 @@ int dp_altmode_probe(struct typec_altmode *alt)
 	      DP_CAP_PIN_ASSIGN_DFP_D(alt->vdo)))
 		return -ENODEV;
 
-	ret = sysfs_create_group(&alt->dev.kobj, &dp_altmode_group);
-	if (ret)
-		return ret;
-
 	dp = devm_kzalloc(&alt->dev, sizeof(*dp), GFP_KERNEL);
 	if (!dp)
 		return -ENOMEM;
@@ -624,7 +624,6 @@ void dp_altmode_remove(struct typec_altmode *alt)
 {
 	struct dp_altmode *dp = typec_altmode_get_drvdata(alt);
 
-	sysfs_remove_group(&alt->dev.kobj, &dp_altmode_group);
 	cancel_work_sync(&dp->work);
 
 	if (dp->connector_fwnode) {
@@ -649,6 +648,7 @@ static struct typec_altmode_driver dp_altmode_driver = {
 	.driver = {
 		.name = "typec_displayport",
 		.owner = THIS_MODULE,
+		.dev_groups = displayport_groups,
 	},
 };
 module_typec_altmode_driver(dp_altmode_driver);
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 2da19feacd91..2373cd39b484 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1310,6 +1310,7 @@ static ssize_t select_usb_power_delivery_store(struct device *dev,
 {
 	struct typec_port *port = to_typec_port(dev);
 	struct usb_power_delivery *pd;
+	int ret;
 
 	if (!port->ops || !port->ops->pd_set)
 		return -EOPNOTSUPP;
@@ -1318,7 +1319,11 @@ static ssize_t select_usb_power_delivery_store(struct device *dev,
 	if (!pd)
 		return -EINVAL;
 
-	return port->ops->pd_set(port, pd);
+	ret = port->ops->pd_set(port, pd);
+	if (ret)
+		return ret;
+
+	return size;
 }
 
 static ssize_t select_usb_power_delivery_show(struct device *dev,
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index a8e03cfde9dd..c5776b3c9677 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4859,8 +4859,11 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case PORT_RESET:
 		tcpm_reset_port(port);
-		tcpm_set_cc(port, tcpm_default_state(port) == SNK_UNATTACHED ?
-			    TYPEC_CC_RD : tcpm_rp_cc(port));
+		if (port->self_powered)
+			tcpm_set_cc(port, TYPEC_CC_OPEN);
+		else
+			tcpm_set_cc(port, tcpm_default_state(port) == SNK_UNATTACHED ?
+				    TYPEC_CC_RD : tcpm_rp_cc(port));
 		tcpm_set_state(port, PORT_RESET_WAIT_OFF,
 			       PD_T_ERROR_RECOVERY);
 		break;
diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 8f9dff993b3d..70d9f4eebf1a 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -138,8 +138,12 @@ static int ucsi_exec_command(struct ucsi *ucsi, u64 cmd)
 	if (!(cci & UCSI_CCI_COMMAND_COMPLETE))
 		return -EIO;
 
-	if (cci & UCSI_CCI_NOT_SUPPORTED)
+	if (cci & UCSI_CCI_NOT_SUPPORTED) {
+		if (ucsi_acknowledge_command(ucsi) < 0)
+			dev_err(ucsi->dev,
+				"ACK of unsupported command failed\n");
 		return -EOPNOTSUPP;
+	}
 
 	if (cci & UCSI_CCI_ERROR) {
 		if (cmd == UCSI_GET_ERROR_STATUS)
@@ -933,11 +937,11 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 	if (con->status.change & UCSI_CONSTAT_CAM_CHANGE)
 		ucsi_partner_task(con, ucsi_check_altmodes, 1, 0);
 
-	clear_bit(EVENT_PENDING, &con->ucsi->flags);
-
 	mutex_lock(&ucsi->ppm_lock);
+	clear_bit(EVENT_PENDING, &con->ucsi->flags);
 	ret = ucsi_acknowledge_connector_change(ucsi);
 	mutex_unlock(&ucsi->ppm_lock);
+
 	if (ret)
 		dev_err(ucsi->dev, "%s: ACK failed (%d)", __func__, ret);
 
@@ -978,13 +982,47 @@ static int ucsi_reset_connector(struct ucsi_connector *con, bool hard)
 
 static int ucsi_reset_ppm(struct ucsi *ucsi)
 {
-	u64 command = UCSI_PPM_RESET;
+	u64 command;
 	unsigned long tmo;
 	u32 cci;
 	int ret;
 
 	mutex_lock(&ucsi->ppm_lock);
 
+	ret = ucsi->ops->read(ucsi, UCSI_CCI, &cci, sizeof(cci));
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * If UCSI_CCI_RESET_COMPLETE is already set we must clear
+	 * the flag before we start another reset. Send a
+	 * UCSI_SET_NOTIFICATION_ENABLE command to achieve this.
+	 * Ignore a timeout and try the reset anyway if this fails.
+	 */
+	if (cci & UCSI_CCI_RESET_COMPLETE) {
+		command = UCSI_SET_NOTIFICATION_ENABLE;
+		ret = ucsi->ops->async_write(ucsi, UCSI_CONTROL, &command,
+					     sizeof(command));
+		if (ret < 0)
+			goto out;
+
+		tmo = jiffies + msecs_to_jiffies(UCSI_TIMEOUT_MS);
+		do {
+			ret = ucsi->ops->read(ucsi, UCSI_CCI,
+					      &cci, sizeof(cci));
+			if (ret < 0)
+				goto out;
+			if (cci & UCSI_CCI_COMMAND_COMPLETE)
+				break;
+			if (time_is_before_jiffies(tmo))
+				break;
+			msleep(20);
+		} while (1);
+
+		WARN_ON(cci & UCSI_CCI_RESET_COMPLETE);
+	}
+
+	command = UCSI_PPM_RESET;
 	ret = ucsi->ops->async_write(ucsi, UCSI_CONTROL, &command,
 				     sizeof(command));
 	if (ret < 0)
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 474315a72c77..13ec976b1c74 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -221,12 +221,12 @@ struct ucsi_cable_property {
 #define UCSI_CABLE_PROP_FLAG_VBUS_IN_CABLE	BIT(0)
 #define UCSI_CABLE_PROP_FLAG_ACTIVE_CABLE	BIT(1)
 #define UCSI_CABLE_PROP_FLAG_DIRECTIONALITY	BIT(2)
-#define UCSI_CABLE_PROP_FLAG_PLUG_TYPE(_f_)	((_f_) & GENMASK(3, 0))
+#define UCSI_CABLE_PROP_FLAG_PLUG_TYPE(_f_)	(((_f_) & GENMASK(4, 3)) >> 3)
 #define   UCSI_CABLE_PROPERTY_PLUG_TYPE_A	0
 #define   UCSI_CABLE_PROPERTY_PLUG_TYPE_B	1
 #define   UCSI_CABLE_PROPERTY_PLUG_TYPE_C	2
 #define   UCSI_CABLE_PROPERTY_PLUG_OTHER	3
-#define UCSI_CABLE_PROP_MODE_SUPPORT		BIT(5)
+#define UCSI_CABLE_PROP_FLAG_MODE_SUPPORT	BIT(5)
 	u8 latency;
 } __packed;
 
diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 928eacbeb21a..7b3ac133ef86 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -23,10 +23,11 @@ struct ucsi_acpi {
 	void *base;
 	struct completion complete;
 	unsigned long flags;
+#define UCSI_ACPI_SUPPRESS_EVENT	0
+#define UCSI_ACPI_COMMAND_PENDING	1
+#define UCSI_ACPI_ACK_PENDING		2
 	guid_t guid;
 	u64 cmd;
-	bool dell_quirk_probed;
-	bool dell_quirk_active;
 };
 
 static int ucsi_acpi_dsm(struct ucsi_acpi *ua, int func)
@@ -79,9 +80,9 @@ static int ucsi_acpi_sync_write(struct ucsi *ucsi, unsigned int offset,
 	int ret;
 
 	if (ack)
-		set_bit(ACK_PENDING, &ua->flags);
+		set_bit(UCSI_ACPI_ACK_PENDING, &ua->flags);
 	else
-		set_bit(COMMAND_PENDING, &ua->flags);
+		set_bit(UCSI_ACPI_COMMAND_PENDING, &ua->flags);
 
 	ret = ucsi_acpi_async_write(ucsi, offset, val, val_len);
 	if (ret)
@@ -92,9 +93,9 @@ static int ucsi_acpi_sync_write(struct ucsi *ucsi, unsigned int offset,
 
 out_clear_bit:
 	if (ack)
-		clear_bit(ACK_PENDING, &ua->flags);
+		clear_bit(UCSI_ACPI_ACK_PENDING, &ua->flags);
 	else
-		clear_bit(COMMAND_PENDING, &ua->flags);
+		clear_bit(UCSI_ACPI_COMMAND_PENDING, &ua->flags);
 
 	return ret;
 }
@@ -129,51 +130,40 @@ static const struct ucsi_operations ucsi_zenbook_ops = {
 };
 
 /*
- * Some Dell laptops expect that an ACK command with the
- * UCSI_ACK_CONNECTOR_CHANGE bit set is followed by a (separate)
- * ACK command that only has the UCSI_ACK_COMMAND_COMPLETE bit set.
- * If this is not done events are not delivered to OSPM and
- * subsequent commands will timeout.
+ * Some Dell laptops don't like ACK commands with the
+ * UCSI_ACK_CONNECTOR_CHANGE but not the UCSI_ACK_COMMAND_COMPLETE
+ * bit set. To work around this send a dummy command and bundle the
+ * UCSI_ACK_CONNECTOR_CHANGE with the UCSI_ACK_COMMAND_COMPLETE
+ * for the dummy command.
  */
 static int
 ucsi_dell_sync_write(struct ucsi *ucsi, unsigned int offset,
 		     const void *val, size_t val_len)
 {
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
-	u64 cmd = *(u64 *)val, ack = 0;
+	u64 cmd = *(u64 *)val;
+	u64 dummycmd = UCSI_GET_CAPABILITY;
 	int ret;
 
-	if (UCSI_COMMAND(cmd) == UCSI_ACK_CC_CI &&
-	    cmd & UCSI_ACK_CONNECTOR_CHANGE)
-		ack = UCSI_ACK_CC_CI | UCSI_ACK_COMMAND_COMPLETE;
-
-	ret = ucsi_acpi_sync_write(ucsi, offset, val, val_len);
-	if (ret != 0)
-		return ret;
-	if (ack == 0)
-		return ret;
-
-	if (!ua->dell_quirk_probed) {
-		ua->dell_quirk_probed = true;
-
-		cmd = UCSI_GET_CAPABILITY;
-		ret = ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &cmd,
-					   sizeof(cmd));
-		if (ret == 0)
-			return ucsi_acpi_sync_write(ucsi, UCSI_CONTROL,
-						    &ack, sizeof(ack));
-		if (ret != -ETIMEDOUT)
+	if (cmd == (UCSI_ACK_CC_CI | UCSI_ACK_CONNECTOR_CHANGE)) {
+		cmd |= UCSI_ACK_COMMAND_COMPLETE;
+
+		/*
+		 * The UCSI core thinks it is sending a connector change ack
+		 * and will accept new connector change events. We don't want
+		 * this to happen for the dummy command as its response will
+		 * still report the very event that the core is trying to clear.
+		 */
+		set_bit(UCSI_ACPI_SUPPRESS_EVENT, &ua->flags);
+		ret = ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &dummycmd,
+					   sizeof(dummycmd));
+		clear_bit(UCSI_ACPI_SUPPRESS_EVENT, &ua->flags);
+
+		if (ret < 0)
 			return ret;
-
-		ua->dell_quirk_active = true;
-		dev_err(ua->dev, "Firmware bug: Additional ACK required after ACKing a connector change.\n");
-		dev_err(ua->dev, "Firmware bug: Enabling workaround\n");
 	}
 
-	if (!ua->dell_quirk_active)
-		return ret;
-
-	return ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &ack, sizeof(ack));
+	return ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &cmd, sizeof(cmd));
 }
 
 static const struct ucsi_operations ucsi_dell_ops = {
@@ -209,13 +199,14 @@ static void ucsi_acpi_notify(acpi_handle handle, u32 event, void *data)
 	if (ret)
 		return;
 
-	if (UCSI_CCI_CONNECTOR(cci))
+	if (UCSI_CCI_CONNECTOR(cci) &&
+	    !test_bit(UCSI_ACPI_SUPPRESS_EVENT, &ua->flags))
 		ucsi_connector_change(ua->ucsi, UCSI_CCI_CONNECTOR(cci));
 
 	if (cci & UCSI_CCI_ACK_COMPLETE && test_bit(ACK_PENDING, &ua->flags))
 		complete(&ua->complete);
 	if (cci & UCSI_CCI_COMMAND_COMPLETE &&
-	    test_bit(COMMAND_PENDING, &ua->flags))
+	    test_bit(UCSI_ACPI_COMMAND_PENDING, &ua->flags))
 		complete(&ua->complete);
 }
 
diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 4853141cd10c..894622b6556a 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -254,6 +254,20 @@ static void pmic_glink_ucsi_notify(struct work_struct *work)
 static void pmic_glink_ucsi_register(struct work_struct *work)
 {
 	struct pmic_glink_ucsi *ucsi = container_of(work, struct pmic_glink_ucsi, register_work);
+	int orientation;
+	int i;
+
+	for (i = 0; i < PMIC_GLINK_MAX_PORTS; i++) {
+		if (!ucsi->port_orientation[i])
+			continue;
+		orientation = gpiod_get_value(ucsi->port_orientation[i]);
+
+		if (orientation >= 0) {
+			typec_switch_set(ucsi->port_switch[i],
+					 orientation ? TYPEC_ORIENTATION_REVERSE
+					     : TYPEC_ORIENTATION_NORMAL);
+		}
+	}
 
 	ucsi_register(ucsi->ucsi);
 }
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 0ddd4b8abecb..6cb5ce4a8b9a 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -493,7 +493,7 @@ static void vduse_vq_kick(struct vduse_virtqueue *vq)
 		goto unlock;
 
 	if (vq->kickfd)
-		eventfd_signal(vq->kickfd, 1);
+		eventfd_signal(vq->kickfd);
 	else
 		vq->kicked = true;
 unlock:
@@ -911,7 +911,7 @@ static int vduse_kickfd_setup(struct vduse_dev *dev,
 		eventfd_ctx_put(vq->kickfd);
 	vq->kickfd = ctx;
 	if (vq->ready && vq->kicked && vq->kickfd) {
-		eventfd_signal(vq->kickfd, 1);
+		eventfd_signal(vq->kickfd);
 		vq->kicked = false;
 	}
 	spin_unlock(&vq->kick_lock);
@@ -960,7 +960,7 @@ static bool vduse_vq_signal_irqfd(struct vduse_virtqueue *vq)
 
 	spin_lock_irq(&vq->irq_lock);
 	if (vq->ready && vq->cb.trigger) {
-		eventfd_signal(vq->cb.trigger, 1);
+		eventfd_signal(vq->cb.trigger);
 		signal = true;
 	}
 	spin_unlock_irq(&vq->irq_lock);
diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c b/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
index c51229fccbd6..82b2afa9b7e3 100644
--- a/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
+++ b/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
@@ -54,7 +54,7 @@ static irqreturn_t vfio_fsl_mc_irq_handler(int irq_num, void *arg)
 {
 	struct vfio_fsl_mc_irq *mc_irq = (struct vfio_fsl_mc_irq *)arg;
 
-	eventfd_signal(mc_irq->trigger, 1);
+	eventfd_signal(mc_irq->trigger);
 	return IRQ_HANDLED;
 }
 
@@ -141,13 +141,14 @@ static int vfio_fsl_mc_set_irq_trigger(struct vfio_fsl_mc_device *vdev,
 	irq = &vdev->mc_irqs[index];
 
 	if (flags & VFIO_IRQ_SET_DATA_NONE) {
-		vfio_fsl_mc_irq_handler(hwirq, irq);
+		if (irq->trigger)
+			eventfd_signal(irq->trigger);
 
 	} else if (flags & VFIO_IRQ_SET_DATA_BOOL) {
 		u8 trigger = *(u8 *)data;
 
-		if (trigger)
-			vfio_fsl_mc_irq_handler(hwirq, irq);
+		if (trigger && irq->trigger)
+			eventfd_signal(irq->trigger);
 	}
 
 	return 0;
diff --git a/drivers/vfio/pci/pds/lm.c b/drivers/vfio/pci/pds/lm.c
index 79fe2e66bb49..6b94cc0bf45b 100644
--- a/drivers/vfio/pci/pds/lm.c
+++ b/drivers/vfio/pci/pds/lm.c
@@ -92,8 +92,10 @@ static void pds_vfio_put_lm_file(struct pds_vfio_lm_file *lm_file)
 {
 	mutex_lock(&lm_file->lock);
 
+	lm_file->disabled = true;
 	lm_file->size = 0;
 	lm_file->alloc_size = 0;
+	lm_file->filep->f_pos = 0;
 
 	/* Free scatter list of file pages */
 	sg_free_table(&lm_file->sg_table);
@@ -183,6 +185,12 @@ static ssize_t pds_vfio_save_read(struct file *filp, char __user *buf,
 	pos = &filp->f_pos;
 
 	mutex_lock(&lm_file->lock);
+
+	if (lm_file->disabled) {
+		done = -ENODEV;
+		goto out_unlock;
+	}
+
 	if (*pos > lm_file->size) {
 		done = -EINVAL;
 		goto out_unlock;
@@ -283,6 +291,11 @@ static ssize_t pds_vfio_restore_write(struct file *filp, const char __user *buf,
 
 	mutex_lock(&lm_file->lock);
 
+	if (lm_file->disabled) {
+		done = -ENODEV;
+		goto out_unlock;
+	}
+
 	while (len) {
 		size_t page_offset;
 		struct page *page;
diff --git a/drivers/vfio/pci/pds/lm.h b/drivers/vfio/pci/pds/lm.h
index 13be893198b7..9511b1afc6a1 100644
--- a/drivers/vfio/pci/pds/lm.h
+++ b/drivers/vfio/pci/pds/lm.h
@@ -27,6 +27,7 @@ struct pds_vfio_lm_file {
 	struct scatterlist *last_offset_sg;	/* Iterator */
 	unsigned int sg_last_entry;
 	unsigned long last_offset;
+	bool disabled;
 };
 
 struct pds_vfio_pci_device;
diff --git a/drivers/vfio/pci/pds/vfio_dev.c b/drivers/vfio/pci/pds/vfio_dev.c
index 4c351c59d05a..a286ebcc7112 100644
--- a/drivers/vfio/pci/pds/vfio_dev.c
+++ b/drivers/vfio/pci/pds/vfio_dev.c
@@ -32,9 +32,9 @@ void pds_vfio_state_mutex_unlock(struct pds_vfio_pci_device *pds_vfio)
 	mutex_lock(&pds_vfio->reset_mutex);
 	if (pds_vfio->deferred_reset) {
 		pds_vfio->deferred_reset = false;
+		pds_vfio_put_restore_file(pds_vfio);
+		pds_vfio_put_save_file(pds_vfio);
 		if (pds_vfio->state == VFIO_DEVICE_STATE_ERROR) {
-			pds_vfio_put_restore_file(pds_vfio);
-			pds_vfio_put_save_file(pds_vfio);
 			pds_vfio_dirty_disable(pds_vfio, false);
 		}
 		pds_vfio->state = pds_vfio->deferred_reset_state;
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 1929103ee59a..1cbc990d42e0 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -443,7 +443,7 @@ static int vfio_pci_core_runtime_resume(struct device *dev)
 	 */
 	down_write(&vdev->memory_lock);
 	if (vdev->pm_wake_eventfd_ctx) {
-		eventfd_signal(vdev->pm_wake_eventfd_ctx, 1);
+		eventfd_signal(vdev->pm_wake_eventfd_ctx);
 		__vfio_pci_runtime_pm_exit(vdev);
 	}
 	up_write(&vdev->memory_lock);
@@ -1883,7 +1883,7 @@ void vfio_pci_core_request(struct vfio_device *core_vdev, unsigned int count)
 			pci_notice_ratelimited(pdev,
 				"Relaying device request to user (#%u)\n",
 				count);
-		eventfd_signal(vdev->req_trigger, 1);
+		eventfd_signal(vdev->req_trigger);
 	} else if (count == 0) {
 		pci_warn(pdev,
 			"No device request channel registered, blocked until released by user\n");
@@ -2302,7 +2302,7 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
 	mutex_lock(&vdev->igate);
 
 	if (vdev->err_trigger)
-		eventfd_signal(vdev->err_trigger, 1);
+		eventfd_signal(vdev->err_trigger);
 
 	mutex_unlock(&vdev->igate);
 
diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index cbb4bcbfbf83..fb5392b749ff 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -90,22 +90,28 @@ static void vfio_send_intx_eventfd(void *opaque, void *unused)
 
 	if (likely(is_intx(vdev) && !vdev->virq_disabled)) {
 		struct vfio_pci_irq_ctx *ctx;
+		struct eventfd_ctx *trigger;
 
 		ctx = vfio_irq_ctx_get(vdev, 0);
 		if (WARN_ON_ONCE(!ctx))
 			return;
-		eventfd_signal(ctx->trigger, 1);
+
+		trigger = READ_ONCE(ctx->trigger);
+		if (likely(trigger))
+			eventfd_signal(trigger);
 	}
 }
 
 /* Returns true if the INTx vfio_pci_irq_ctx.masked value is changed. */
-bool vfio_pci_intx_mask(struct vfio_pci_core_device *vdev)
+static bool __vfio_pci_intx_mask(struct vfio_pci_core_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
 	struct vfio_pci_irq_ctx *ctx;
 	unsigned long flags;
 	bool masked_changed = false;
 
+	lockdep_assert_held(&vdev->igate);
+
 	spin_lock_irqsave(&vdev->irqlock, flags);
 
 	/*
@@ -143,6 +149,17 @@ bool vfio_pci_intx_mask(struct vfio_pci_core_device *vdev)
 	return masked_changed;
 }
 
+bool vfio_pci_intx_mask(struct vfio_pci_core_device *vdev)
+{
+	bool mask_changed;
+
+	mutex_lock(&vdev->igate);
+	mask_changed = __vfio_pci_intx_mask(vdev);
+	mutex_unlock(&vdev->igate);
+
+	return mask_changed;
+}
+
 /*
  * If this is triggered by an eventfd, we can't call eventfd_signal
  * or else we'll deadlock on the eventfd wait queue.  Return >0 when
@@ -194,12 +211,21 @@ static int vfio_pci_intx_unmask_handler(void *opaque, void *unused)
 	return ret;
 }
 
-void vfio_pci_intx_unmask(struct vfio_pci_core_device *vdev)
+static void __vfio_pci_intx_unmask(struct vfio_pci_core_device *vdev)
 {
+	lockdep_assert_held(&vdev->igate);
+
 	if (vfio_pci_intx_unmask_handler(vdev, NULL) > 0)
 		vfio_send_intx_eventfd(vdev, NULL);
 }
 
+void vfio_pci_intx_unmask(struct vfio_pci_core_device *vdev)
+{
+	mutex_lock(&vdev->igate);
+	__vfio_pci_intx_unmask(vdev);
+	mutex_unlock(&vdev->igate);
+}
+
 static irqreturn_t vfio_intx_handler(int irq, void *dev_id)
 {
 	struct vfio_pci_core_device *vdev = dev_id;
@@ -231,97 +257,100 @@ static irqreturn_t vfio_intx_handler(int irq, void *dev_id)
 	return ret;
 }
 
-static int vfio_intx_enable(struct vfio_pci_core_device *vdev)
+static int vfio_intx_enable(struct vfio_pci_core_device *vdev,
+			    struct eventfd_ctx *trigger)
 {
+	struct pci_dev *pdev = vdev->pdev;
 	struct vfio_pci_irq_ctx *ctx;
+	unsigned long irqflags;
+	char *name;
+	int ret;
 
 	if (!is_irq_none(vdev))
 		return -EINVAL;
 
-	if (!vdev->pdev->irq)
+	if (!pdev->irq)
 		return -ENODEV;
 
+	name = kasprintf(GFP_KERNEL_ACCOUNT, "vfio-intx(%s)", pci_name(pdev));
+	if (!name)
+		return -ENOMEM;
+
 	ctx = vfio_irq_ctx_alloc(vdev, 0);
 	if (!ctx)
 		return -ENOMEM;
 
+	ctx->name = name;
+	ctx->trigger = trigger;
+
 	/*
-	 * If the virtual interrupt is masked, restore it.  Devices
-	 * supporting DisINTx can be masked at the hardware level
-	 * here, non-PCI-2.3 devices will have to wait until the
-	 * interrupt is enabled.
+	 * Fill the initial masked state based on virq_disabled.  After
+	 * enable, changing the DisINTx bit in vconfig directly changes INTx
+	 * masking.  igate prevents races during setup, once running masked
+	 * is protected via irqlock.
+	 *
+	 * Devices supporting DisINTx also reflect the current mask state in
+	 * the physical DisINTx bit, which is not affected during IRQ setup.
+	 *
+	 * Devices without DisINTx support require an exclusive interrupt.
+	 * IRQ masking is performed at the IRQ chip.  Again, igate protects
+	 * against races during setup and IRQ handlers and irqfds are not
+	 * yet active, therefore masked is stable and can be used to
+	 * conditionally auto-enable the IRQ.
+	 *
+	 * irq_type must be stable while the IRQ handler is registered,
+	 * therefore it must be set before request_irq().
 	 */
 	ctx->masked = vdev->virq_disabled;
-	if (vdev->pci_2_3)
-		pci_intx(vdev->pdev, !ctx->masked);
+	if (vdev->pci_2_3) {
+		pci_intx(pdev, !ctx->masked);
+		irqflags = IRQF_SHARED;
+	} else {
+		irqflags = ctx->masked ? IRQF_NO_AUTOEN : 0;
+	}
 
 	vdev->irq_type = VFIO_PCI_INTX_IRQ_INDEX;
 
+	ret = request_irq(pdev->irq, vfio_intx_handler,
+			  irqflags, ctx->name, vdev);
+	if (ret) {
+		vdev->irq_type = VFIO_PCI_NUM_IRQS;
+		kfree(name);
+		vfio_irq_ctx_free(vdev, ctx, 0);
+		return ret;
+	}
+
 	return 0;
 }
 
-static int vfio_intx_set_signal(struct vfio_pci_core_device *vdev, int fd)
+static int vfio_intx_set_signal(struct vfio_pci_core_device *vdev,
+				struct eventfd_ctx *trigger)
 {
 	struct pci_dev *pdev = vdev->pdev;
-	unsigned long irqflags = IRQF_SHARED;
 	struct vfio_pci_irq_ctx *ctx;
-	struct eventfd_ctx *trigger;
-	unsigned long flags;
-	int ret;
+	struct eventfd_ctx *old;
 
 	ctx = vfio_irq_ctx_get(vdev, 0);
 	if (WARN_ON_ONCE(!ctx))
 		return -EINVAL;
 
-	if (ctx->trigger) {
-		free_irq(pdev->irq, vdev);
-		kfree(ctx->name);
-		eventfd_ctx_put(ctx->trigger);
-		ctx->trigger = NULL;
-	}
-
-	if (fd < 0) /* Disable only */
-		return 0;
+	old = ctx->trigger;
 
-	ctx->name = kasprintf(GFP_KERNEL_ACCOUNT, "vfio-intx(%s)",
-			      pci_name(pdev));
-	if (!ctx->name)
-		return -ENOMEM;
+	WRITE_ONCE(ctx->trigger, trigger);
 
-	trigger = eventfd_ctx_fdget(fd);
-	if (IS_ERR(trigger)) {
-		kfree(ctx->name);
-		return PTR_ERR(trigger);
+	/* Releasing an old ctx requires synchronizing in-flight users */
+	if (old) {
+		synchronize_irq(pdev->irq);
+		vfio_virqfd_flush_thread(&ctx->unmask);
+		eventfd_ctx_put(old);
 	}
 
-	ctx->trigger = trigger;
-
-	if (!vdev->pci_2_3)
-		irqflags = 0;
-
-	ret = request_irq(pdev->irq, vfio_intx_handler,
-			  irqflags, ctx->name, vdev);
-	if (ret) {
-		ctx->trigger = NULL;
-		kfree(ctx->name);
-		eventfd_ctx_put(trigger);
-		return ret;
-	}
-
-	/*
-	 * INTx disable will stick across the new irq setup,
-	 * disable_irq won't.
-	 */
-	spin_lock_irqsave(&vdev->irqlock, flags);
-	if (!vdev->pci_2_3 && ctx->masked)
-		disable_irq_nosync(pdev->irq);
-	spin_unlock_irqrestore(&vdev->irqlock, flags);
-
 	return 0;
 }
 
 static void vfio_intx_disable(struct vfio_pci_core_device *vdev)
 {
+	struct pci_dev *pdev = vdev->pdev;
 	struct vfio_pci_irq_ctx *ctx;
 
 	ctx = vfio_irq_ctx_get(vdev, 0);
@@ -329,10 +358,13 @@ static void vfio_intx_disable(struct vfio_pci_core_device *vdev)
 	if (ctx) {
 		vfio_virqfd_disable(&ctx->unmask);
 		vfio_virqfd_disable(&ctx->mask);
+		free_irq(pdev->irq, vdev);
+		if (ctx->trigger)
+			eventfd_ctx_put(ctx->trigger);
+		kfree(ctx->name);
+		vfio_irq_ctx_free(vdev, ctx, 0);
 	}
-	vfio_intx_set_signal(vdev, -1);
 	vdev->irq_type = VFIO_PCI_NUM_IRQS;
-	vfio_irq_ctx_free(vdev, ctx, 0);
 }
 
 /*
@@ -342,7 +374,7 @@ static irqreturn_t vfio_msihandler(int irq, void *arg)
 {
 	struct eventfd_ctx *trigger = arg;
 
-	eventfd_signal(trigger, 1);
+	eventfd_signal(trigger);
 	return IRQ_HANDLED;
 }
 
@@ -560,11 +592,11 @@ static int vfio_pci_set_intx_unmask(struct vfio_pci_core_device *vdev,
 		return -EINVAL;
 
 	if (flags & VFIO_IRQ_SET_DATA_NONE) {
-		vfio_pci_intx_unmask(vdev);
+		__vfio_pci_intx_unmask(vdev);
 	} else if (flags & VFIO_IRQ_SET_DATA_BOOL) {
 		uint8_t unmask = *(uint8_t *)data;
 		if (unmask)
-			vfio_pci_intx_unmask(vdev);
+			__vfio_pci_intx_unmask(vdev);
 	} else if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {
 		struct vfio_pci_irq_ctx *ctx = vfio_irq_ctx_get(vdev, 0);
 		int32_t fd = *(int32_t *)data;
@@ -591,11 +623,11 @@ static int vfio_pci_set_intx_mask(struct vfio_pci_core_device *vdev,
 		return -EINVAL;
 
 	if (flags & VFIO_IRQ_SET_DATA_NONE) {
-		vfio_pci_intx_mask(vdev);
+		__vfio_pci_intx_mask(vdev);
 	} else if (flags & VFIO_IRQ_SET_DATA_BOOL) {
 		uint8_t mask = *(uint8_t *)data;
 		if (mask)
-			vfio_pci_intx_mask(vdev);
+			__vfio_pci_intx_mask(vdev);
 	} else if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {
 		return -ENOTTY; /* XXX implement me */
 	}
@@ -616,19 +648,23 @@ static int vfio_pci_set_intx_trigger(struct vfio_pci_core_device *vdev,
 		return -EINVAL;
 
 	if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {
+		struct eventfd_ctx *trigger = NULL;
 		int32_t fd = *(int32_t *)data;
 		int ret;
 
-		if (is_intx(vdev))
-			return vfio_intx_set_signal(vdev, fd);
+		if (fd >= 0) {
+			trigger = eventfd_ctx_fdget(fd);
+			if (IS_ERR(trigger))
+				return PTR_ERR(trigger);
+		}
 
-		ret = vfio_intx_enable(vdev);
-		if (ret)
-			return ret;
+		if (is_intx(vdev))
+			ret = vfio_intx_set_signal(vdev, trigger);
+		else
+			ret = vfio_intx_enable(vdev, trigger);
 
-		ret = vfio_intx_set_signal(vdev, fd);
-		if (ret)
-			vfio_intx_disable(vdev);
+		if (ret && trigger)
+			eventfd_ctx_put(trigger);
 
 		return ret;
 	}
@@ -689,11 +725,11 @@ static int vfio_pci_set_msi_trigger(struct vfio_pci_core_device *vdev,
 		if (!ctx)
 			continue;
 		if (flags & VFIO_IRQ_SET_DATA_NONE) {
-			eventfd_signal(ctx->trigger, 1);
+			eventfd_signal(ctx->trigger);
 		} else if (flags & VFIO_IRQ_SET_DATA_BOOL) {
 			uint8_t *bools = data;
 			if (bools[i - start])
-				eventfd_signal(ctx->trigger, 1);
+				eventfd_signal(ctx->trigger);
 		}
 	}
 	return 0;
@@ -707,7 +743,7 @@ static int vfio_pci_set_ctx_trigger_single(struct eventfd_ctx **ctx,
 	if (flags & VFIO_IRQ_SET_DATA_NONE) {
 		if (*ctx) {
 			if (count) {
-				eventfd_signal(*ctx, 1);
+				eventfd_signal(*ctx);
 			} else {
 				eventfd_ctx_put(*ctx);
 				*ctx = NULL;
@@ -722,7 +758,7 @@ static int vfio_pci_set_ctx_trigger_single(struct eventfd_ctx **ctx,
 
 		trigger = *(uint8_t *)data;
 		if (trigger && *ctx)
-			eventfd_signal(*ctx, 1);
+			eventfd_signal(*ctx);
 
 		return 0;
 	} else if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {
diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
index 665197caed89..ef41ecef83af 100644
--- a/drivers/vfio/platform/vfio_platform_irq.c
+++ b/drivers/vfio/platform/vfio_platform_irq.c
@@ -136,6 +136,16 @@ static int vfio_platform_set_irq_unmask(struct vfio_platform_device *vdev,
 	return 0;
 }
 
+/*
+ * The trigger eventfd is guaranteed valid in the interrupt path
+ * and protected by the igate mutex when triggered via ioctl.
+ */
+static void vfio_send_eventfd(struct vfio_platform_irq *irq_ctx)
+{
+	if (likely(irq_ctx->trigger))
+		eventfd_signal(irq_ctx->trigger);
+}
+
 static irqreturn_t vfio_automasked_irq_handler(int irq, void *dev_id)
 {
 	struct vfio_platform_irq *irq_ctx = dev_id;
@@ -155,7 +165,7 @@ static irqreturn_t vfio_automasked_irq_handler(int irq, void *dev_id)
 	spin_unlock_irqrestore(&irq_ctx->lock, flags);
 
 	if (ret == IRQ_HANDLED)
-		eventfd_signal(irq_ctx->trigger, 1);
+		vfio_send_eventfd(irq_ctx);
 
 	return ret;
 }
@@ -164,52 +174,40 @@ static irqreturn_t vfio_irq_handler(int irq, void *dev_id)
 {
 	struct vfio_platform_irq *irq_ctx = dev_id;
 
-	eventfd_signal(irq_ctx->trigger, 1);
+	vfio_send_eventfd(irq_ctx);
 
 	return IRQ_HANDLED;
 }
 
 static int vfio_set_trigger(struct vfio_platform_device *vdev, int index,
-			    int fd, irq_handler_t handler)
+			    int fd)
 {
 	struct vfio_platform_irq *irq = &vdev->irqs[index];
 	struct eventfd_ctx *trigger;
-	int ret;
 
 	if (irq->trigger) {
-		irq_clear_status_flags(irq->hwirq, IRQ_NOAUTOEN);
-		free_irq(irq->hwirq, irq);
-		kfree(irq->name);
+		disable_irq(irq->hwirq);
 		eventfd_ctx_put(irq->trigger);
 		irq->trigger = NULL;
 	}
 
 	if (fd < 0) /* Disable only */
 		return 0;
-	irq->name = kasprintf(GFP_KERNEL_ACCOUNT, "vfio-irq[%d](%s)",
-			      irq->hwirq, vdev->name);
-	if (!irq->name)
-		return -ENOMEM;
 
 	trigger = eventfd_ctx_fdget(fd);
-	if (IS_ERR(trigger)) {
-		kfree(irq->name);
+	if (IS_ERR(trigger))
 		return PTR_ERR(trigger);
-	}
 
 	irq->trigger = trigger;
 
-	irq_set_status_flags(irq->hwirq, IRQ_NOAUTOEN);
-	ret = request_irq(irq->hwirq, handler, 0, irq->name, irq);
-	if (ret) {
-		kfree(irq->name);
-		eventfd_ctx_put(trigger);
-		irq->trigger = NULL;
-		return ret;
-	}
-
-	if (!irq->masked)
-		enable_irq(irq->hwirq);
+	/*
+	 * irq->masked effectively provides nested disables within the overall
+	 * enable relative to trigger.  Specifically request_irq() is called
+	 * with NO_AUTOEN, therefore the IRQ is initially disabled.  The user
+	 * may only further disable the IRQ with a MASK operations because
+	 * irq->masked is initially false.
+	 */
+	enable_irq(irq->hwirq);
 
 	return 0;
 }
@@ -228,7 +226,7 @@ static int vfio_platform_set_irq_trigger(struct vfio_platform_device *vdev,
 		handler = vfio_irq_handler;
 
 	if (!count && (flags & VFIO_IRQ_SET_DATA_NONE))
-		return vfio_set_trigger(vdev, index, -1, handler);
+		return vfio_set_trigger(vdev, index, -1);
 
 	if (start != 0 || count != 1)
 		return -EINVAL;
@@ -236,7 +234,7 @@ static int vfio_platform_set_irq_trigger(struct vfio_platform_device *vdev,
 	if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {
 		int32_t fd = *(int32_t *)data;
 
-		return vfio_set_trigger(vdev, index, fd, handler);
+		return vfio_set_trigger(vdev, index, fd);
 	}
 
 	if (flags & VFIO_IRQ_SET_DATA_NONE) {
@@ -260,6 +258,14 @@ int vfio_platform_set_irqs_ioctl(struct vfio_platform_device *vdev,
 		    unsigned start, unsigned count, uint32_t flags,
 		    void *data) = NULL;
 
+	/*
+	 * For compatibility, errors from request_irq() are local to the
+	 * SET_IRQS path and reflected in the name pointer.  This allows,
+	 * for example, polling mode fallback for an exclusive IRQ failure.
+	 */
+	if (IS_ERR(vdev->irqs[index].name))
+		return PTR_ERR(vdev->irqs[index].name);
+
 	switch (flags & VFIO_IRQ_SET_ACTION_TYPE_MASK) {
 	case VFIO_IRQ_SET_ACTION_MASK:
 		func = vfio_platform_set_irq_mask;
@@ -280,7 +286,7 @@ int vfio_platform_set_irqs_ioctl(struct vfio_platform_device *vdev,
 
 int vfio_platform_irq_init(struct vfio_platform_device *vdev)
 {
-	int cnt = 0, i;
+	int cnt = 0, i, ret = 0;
 
 	while (vdev->get_irq(vdev, cnt) >= 0)
 		cnt++;
@@ -292,37 +298,70 @@ int vfio_platform_irq_init(struct vfio_platform_device *vdev)
 
 	for (i = 0; i < cnt; i++) {
 		int hwirq = vdev->get_irq(vdev, i);
+		irq_handler_t handler = vfio_irq_handler;
 
-		if (hwirq < 0)
+		if (hwirq < 0) {
+			ret = -EINVAL;
 			goto err;
+		}
 
 		spin_lock_init(&vdev->irqs[i].lock);
 
 		vdev->irqs[i].flags = VFIO_IRQ_INFO_EVENTFD;
 
-		if (irq_get_trigger_type(hwirq) & IRQ_TYPE_LEVEL_MASK)
+		if (irq_get_trigger_type(hwirq) & IRQ_TYPE_LEVEL_MASK) {
 			vdev->irqs[i].flags |= VFIO_IRQ_INFO_MASKABLE
 						| VFIO_IRQ_INFO_AUTOMASKED;
+			handler = vfio_automasked_irq_handler;
+		}
 
 		vdev->irqs[i].count = 1;
 		vdev->irqs[i].hwirq = hwirq;
 		vdev->irqs[i].masked = false;
+		vdev->irqs[i].name = kasprintf(GFP_KERNEL_ACCOUNT,
+					       "vfio-irq[%d](%s)", hwirq,
+					       vdev->name);
+		if (!vdev->irqs[i].name) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		ret = request_irq(hwirq, handler, IRQF_NO_AUTOEN,
+				  vdev->irqs[i].name, &vdev->irqs[i]);
+		if (ret) {
+			kfree(vdev->irqs[i].name);
+			vdev->irqs[i].name = ERR_PTR(ret);
+		}
 	}
 
 	vdev->num_irqs = cnt;
 
 	return 0;
 err:
+	for (--i; i >= 0; i--) {
+		if (!IS_ERR(vdev->irqs[i].name)) {
+			free_irq(vdev->irqs[i].hwirq, &vdev->irqs[i]);
+			kfree(vdev->irqs[i].name);
+		}
+	}
 	kfree(vdev->irqs);
-	return -EINVAL;
+	return ret;
 }
 
 void vfio_platform_irq_cleanup(struct vfio_platform_device *vdev)
 {
 	int i;
 
-	for (i = 0; i < vdev->num_irqs; i++)
-		vfio_set_trigger(vdev, i, -1, NULL);
+	for (i = 0; i < vdev->num_irqs; i++) {
+		vfio_virqfd_disable(&vdev->irqs[i].mask);
+		vfio_virqfd_disable(&vdev->irqs[i].unmask);
+		if (!IS_ERR(vdev->irqs[i].name)) {
+			free_irq(vdev->irqs[i].hwirq, &vdev->irqs[i]);
+			if (vdev->irqs[i].trigger)
+				eventfd_ctx_put(vdev->irqs[i].trigger);
+			kfree(vdev->irqs[i].name);
+		}
+	}
 
 	vdev->num_irqs = 0;
 	kfree(vdev->irqs);
diff --git a/drivers/vfio/virqfd.c b/drivers/vfio/virqfd.c
index 29c564b7a6e1..532269133801 100644
--- a/drivers/vfio/virqfd.c
+++ b/drivers/vfio/virqfd.c
@@ -101,6 +101,13 @@ static void virqfd_inject(struct work_struct *work)
 		virqfd->thread(virqfd->opaque, virqfd->data);
 }
 
+static void virqfd_flush_inject(struct work_struct *work)
+{
+	struct virqfd *virqfd = container_of(work, struct virqfd, flush_inject);
+
+	flush_work(&virqfd->inject);
+}
+
 int vfio_virqfd_enable(void *opaque,
 		       int (*handler)(void *, void *),
 		       void (*thread)(void *, void *),
@@ -124,6 +131,7 @@ int vfio_virqfd_enable(void *opaque,
 
 	INIT_WORK(&virqfd->shutdown, virqfd_shutdown);
 	INIT_WORK(&virqfd->inject, virqfd_inject);
+	INIT_WORK(&virqfd->flush_inject, virqfd_flush_inject);
 
 	irqfd = fdget(fd);
 	if (!irqfd.file) {
@@ -213,3 +221,16 @@ void vfio_virqfd_disable(struct virqfd **pvirqfd)
 	flush_workqueue(vfio_irqfd_cleanup_wq);
 }
 EXPORT_SYMBOL_GPL(vfio_virqfd_disable);
+
+void vfio_virqfd_flush_thread(struct virqfd **pvirqfd)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&virqfd_lock, flags);
+	if (*pvirqfd && (*pvirqfd)->thread)
+		queue_work(vfio_irqfd_cleanup_wq, &(*pvirqfd)->flush_inject);
+	spin_unlock_irqrestore(&virqfd_lock, flags);
+
+	flush_workqueue(vfio_irqfd_cleanup_wq);
+}
+EXPORT_SYMBOL_GPL(vfio_virqfd_flush_thread);
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index da7ec77cdaff..173beda74b38 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -178,7 +178,7 @@ static irqreturn_t vhost_vdpa_virtqueue_cb(void *private)
 	struct eventfd_ctx *call_ctx = vq->call_ctx.ctx;
 
 	if (call_ctx)
-		eventfd_signal(call_ctx, 1);
+		eventfd_signal(call_ctx);
 
 	return IRQ_HANDLED;
 }
@@ -189,7 +189,7 @@ static irqreturn_t vhost_vdpa_config_cb(void *private)
 	struct eventfd_ctx *config_ctx = v->config_ctx;
 
 	if (config_ctx)
-		eventfd_signal(config_ctx, 1);
+		eventfd_signal(config_ctx);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index e0c181ad17e3..045f666b4f12 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2248,7 +2248,7 @@ int vhost_log_write(struct vhost_virtqueue *vq, struct vhost_log *log,
 		len -= l;
 		if (!len) {
 			if (vq->log_ctx)
-				eventfd_signal(vq->log_ctx, 1);
+				eventfd_signal(vq->log_ctx);
 			return 0;
 		}
 	}
@@ -2271,7 +2271,7 @@ static int vhost_update_used_flags(struct vhost_virtqueue *vq)
 		log_used(vq, (used - (void __user *)vq->used),
 			 sizeof vq->used->flags);
 		if (vq->log_ctx)
-			eventfd_signal(vq->log_ctx, 1);
+			eventfd_signal(vq->log_ctx);
 	}
 	return 0;
 }
@@ -2289,7 +2289,7 @@ static int vhost_update_avail_event(struct vhost_virtqueue *vq)
 		log_used(vq, (used - (void __user *)vq->used),
 			 sizeof *vhost_avail_event(vq));
 		if (vq->log_ctx)
-			eventfd_signal(vq->log_ctx, 1);
+			eventfd_signal(vq->log_ctx);
 	}
 	return 0;
 }
@@ -2715,7 +2715,7 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
 		log_used(vq, offsetof(struct vring_used, idx),
 			 sizeof vq->used->idx);
 		if (vq->log_ctx)
-			eventfd_signal(vq->log_ctx, 1);
+			eventfd_signal(vq->log_ctx);
 	}
 	return r;
 }
@@ -2763,7 +2763,7 @@ void vhost_signal(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 {
 	/* Signal the Guest tell them we used something up. */
 	if (vq->call_ctx.ctx && vhost_notify(dev, vq))
-		eventfd_signal(vq->call_ctx.ctx, 1);
+		eventfd_signal(vq->call_ctx.ctx);
 }
 EXPORT_SYMBOL_GPL(vhost_signal);
 
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index f60d5f7bef94..9e942fcda5c3 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -249,7 +249,7 @@ void vhost_iotlb_map_free(struct vhost_iotlb *iotlb,
 #define vq_err(vq, fmt, ...) do {                                  \
 		pr_debug(pr_fmt(fmt), ##__VA_ARGS__);       \
 		if ((vq)->error_ctx)                               \
-				eventfd_signal((vq)->error_ctx, 1);\
+				eventfd_signal((vq)->error_ctx);\
 	} while (0)
 
 enum {
diff --git a/drivers/virt/acrn/ioeventfd.c b/drivers/virt/acrn/ioeventfd.c
index ac4037e9f947..4e845c6ca0b5 100644
--- a/drivers/virt/acrn/ioeventfd.c
+++ b/drivers/virt/acrn/ioeventfd.c
@@ -223,7 +223,7 @@ static int acrn_ioeventfd_handler(struct acrn_ioreq_client *client,
 	mutex_lock(&client->vm->ioeventfds_lock);
 	p = hsm_ioeventfd_match(client->vm, addr, val, size, req->type);
 	if (p)
-		eventfd_signal(p->eventfd, 1);
+		eventfd_signal(p->eventfd);
 	mutex_unlock(&client->vm->ioeventfds_lock);
 
 	return 0;
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 3893dc29eb26..71dee622b771 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -489,13 +489,19 @@ EXPORT_SYMBOL_GPL(unregister_virtio_device);
 int virtio_device_freeze(struct virtio_device *dev)
 {
 	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
+	int ret;
 
 	virtio_config_disable(dev);
 
 	dev->failed = dev->config->get_status(dev) & VIRTIO_CONFIG_S_FAILED;
 
-	if (drv && drv->freeze)
-		return drv->freeze(dev);
+	if (drv && drv->freeze) {
+		ret = drv->freeze(dev);
+		if (ret) {
+			virtio_config_enable(dev);
+			return ret;
+		}
+	}
 
 	return 0;
 }
diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 0eb337a8ec0f..35b6e306026a 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -1147,7 +1147,7 @@ static irqreturn_t ioeventfd_interrupt(int irq, void *dev_id)
 		if (ioreq->addr == kioeventfd->addr + VIRTIO_MMIO_QUEUE_NOTIFY &&
 		    ioreq->size == kioeventfd->addr_len &&
 		    (ioreq->data & QUEUE_NOTIFY_VQ_MASK) == kioeventfd->vq) {
-			eventfd_signal(kioeventfd->eventfd, 1);
+			eventfd_signal(kioeventfd->eventfd);
 			state = STATE_IORESP_READY;
 			break;
 		}
diff --git a/fs/aio.c b/fs/aio.c
index 3235d4e6cc62..be12d7c049ef 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -590,8 +590,8 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 
 void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
 {
-	struct aio_kiocb *req = container_of(iocb, struct aio_kiocb, rw);
-	struct kioctx *ctx = req->ki_ctx;
+	struct aio_kiocb *req;
+	struct kioctx *ctx;
 	unsigned long flags;
 
 	/*
@@ -601,9 +601,13 @@ void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
 	if (!(iocb->ki_flags & IOCB_AIO_RW))
 		return;
 
+	req = container_of(iocb, struct aio_kiocb, rw);
+
 	if (WARN_ON_ONCE(!list_empty(&req->ki_list)))
 		return;
 
+	ctx = req->ki_ctx;
+
 	spin_lock_irqsave(&ctx->ctx_lock, flags);
 	list_add_tail(&req->ki_list, &ctx->active_reqs);
 	req->ki_cancel = cancel;
@@ -1173,7 +1177,7 @@ static void aio_complete(struct aio_kiocb *iocb)
 	 * from IRQ context.
 	 */
 	if (iocb->ki_eventfd)
-		eventfd_signal(iocb->ki_eventfd, 1);
+		eventfd_signal(iocb->ki_eventfd);
 
 	/*
 	 * We have to order our ring_info tail store above and test
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index aca24186d66b..52bab8cf7867 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1562,7 +1562,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		 * needing to allocate extents from the block group.
 		 */
 		used = btrfs_space_info_used(space_info, true);
-		if (space_info->total_bytes - block_group->length < used) {
+		if (space_info->total_bytes - block_group->length < used &&
+		    block_group->zone_unusable < block_group->length) {
 			/*
 			 * Add a reference for the list, compensate for the ref
 			 * drop under the "next" label for the
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index eade0432bd9c..87082f9732bd 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2734,16 +2734,34 @@ static int fiemap_process_hole(struct btrfs_inode *inode,
 	 * it beyond i_size.
 	 */
 	while (cur_offset < end && cur_offset < i_size) {
+		struct extent_state *cached_state = NULL;
 		u64 delalloc_start;
 		u64 delalloc_end;
 		u64 prealloc_start;
+		u64 lockstart;
+		u64 lockend;
 		u64 prealloc_len = 0;
 		bool delalloc;
 
+		lockstart = round_down(cur_offset, inode->root->fs_info->sectorsize);
+		lockend = round_up(end, inode->root->fs_info->sectorsize);
+
+		/*
+		 * We are only locking for the delalloc range because that's the
+		 * only thing that can change here.  With fiemap we have a lock
+		 * on the inode, so no buffered or direct writes can happen.
+		 *
+		 * However mmaps and normal page writeback will cause this to
+		 * change arbitrarily.  We have to lock the extent lock here to
+		 * make sure that nobody messes with the tree while we're doing
+		 * btrfs_find_delalloc_in_range.
+		 */
+		lock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 		delalloc = btrfs_find_delalloc_in_range(inode, cur_offset, end,
 							delalloc_cached_state,
 							&delalloc_start,
 							&delalloc_end);
+		unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 		if (!delalloc)
 			break;
 
@@ -2911,15 +2929,15 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		  u64 start, u64 len)
 {
 	const u64 ino = btrfs_ino(inode);
-	struct extent_state *cached_state = NULL;
 	struct extent_state *delalloc_cached_state = NULL;
 	struct btrfs_path *path;
 	struct fiemap_cache cache = { 0 };
 	struct btrfs_backref_share_check_ctx *backref_ctx;
 	u64 last_extent_end;
 	u64 prev_extent_end;
-	u64 lockstart;
-	u64 lockend;
+	u64 range_start;
+	u64 range_end;
+	const u64 sectorsize = inode->root->fs_info->sectorsize;
 	bool stopped = false;
 	int ret;
 
@@ -2930,12 +2948,11 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		goto out;
 	}
 
-	lockstart = round_down(start, inode->root->fs_info->sectorsize);
-	lockend = round_up(start + len, inode->root->fs_info->sectorsize);
-	prev_extent_end = lockstart;
+	range_start = round_down(start, sectorsize);
+	range_end = round_up(start + len, sectorsize);
+	prev_extent_end = range_start;
 
 	btrfs_inode_lock(inode, BTRFS_ILOCK_SHARED);
-	lock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 
 	ret = fiemap_find_last_extent_offset(inode, path, &last_extent_end);
 	if (ret < 0)
@@ -2943,7 +2960,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 	btrfs_release_path(path);
 
 	path->reada = READA_FORWARD;
-	ret = fiemap_search_slot(inode, path, lockstart);
+	ret = fiemap_search_slot(inode, path, range_start);
 	if (ret < 0) {
 		goto out_unlock;
 	} else if (ret > 0) {
@@ -2955,7 +2972,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		goto check_eof_delalloc;
 	}
 
-	while (prev_extent_end < lockend) {
+	while (prev_extent_end < range_end) {
 		struct extent_buffer *leaf = path->nodes[0];
 		struct btrfs_file_extent_item *ei;
 		struct btrfs_key key;
@@ -2978,19 +2995,19 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		 * The first iteration can leave us at an extent item that ends
 		 * before our range's start. Move to the next item.
 		 */
-		if (extent_end <= lockstart)
+		if (extent_end <= range_start)
 			goto next_item;
 
 		backref_ctx->curr_leaf_bytenr = leaf->start;
 
 		/* We have in implicit hole (NO_HOLES feature enabled). */
 		if (prev_extent_end < key.offset) {
-			const u64 range_end = min(key.offset, lockend) - 1;
+			const u64 hole_end = min(key.offset, range_end) - 1;
 
 			ret = fiemap_process_hole(inode, fieinfo, &cache,
 						  &delalloc_cached_state,
 						  backref_ctx, 0, 0, 0,
-						  prev_extent_end, range_end);
+						  prev_extent_end, hole_end);
 			if (ret < 0) {
 				goto out_unlock;
 			} else if (ret > 0) {
@@ -3000,7 +3017,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 			}
 
 			/* We've reached the end of the fiemap range, stop. */
-			if (key.offset >= lockend) {
+			if (key.offset >= range_end) {
 				stopped = true;
 				break;
 			}
@@ -3094,29 +3111,41 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 	btrfs_free_path(path);
 	path = NULL;
 
-	if (!stopped && prev_extent_end < lockend) {
+	if (!stopped && prev_extent_end < range_end) {
 		ret = fiemap_process_hole(inode, fieinfo, &cache,
 					  &delalloc_cached_state, backref_ctx,
-					  0, 0, 0, prev_extent_end, lockend - 1);
+					  0, 0, 0, prev_extent_end, range_end - 1);
 		if (ret < 0)
 			goto out_unlock;
-		prev_extent_end = lockend;
+		prev_extent_end = range_end;
 	}
 
 	if (cache.cached && cache.offset + cache.len >= last_extent_end) {
 		const u64 i_size = i_size_read(&inode->vfs_inode);
 
 		if (prev_extent_end < i_size) {
+			struct extent_state *cached_state = NULL;
 			u64 delalloc_start;
 			u64 delalloc_end;
+			u64 lockstart;
+			u64 lockend;
 			bool delalloc;
 
+			lockstart = round_down(prev_extent_end, sectorsize);
+			lockend = round_up(i_size, sectorsize);
+
+			/*
+			 * See the comment in fiemap_process_hole as to why
+			 * we're doing the locking here.
+			 */
+			lock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 			delalloc = btrfs_find_delalloc_in_range(inode,
 								prev_extent_end,
 								i_size - 1,
 								&delalloc_cached_state,
 								&delalloc_start,
 								&delalloc_end);
+			unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 			if (!delalloc)
 				cache.flags |= FIEMAP_EXTENT_LAST;
 		} else {
@@ -3127,7 +3156,6 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 	ret = emit_last_fiemap_cache(fieinfo, &cache);
 
 out_unlock:
-	unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 out:
 	free_extent_state(delalloc_cached_state);
@@ -4024,6 +4052,19 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 	if (test_and_set_bit(EXTENT_BUFFER_READING, &eb->bflags))
 		goto done;
 
+	/*
+	 * Between the initial test_bit(EXTENT_BUFFER_UPTODATE) and the above
+	 * test_and_set_bit(EXTENT_BUFFER_READING), someone else could have
+	 * started and finished reading the same eb.  In this case, UPTODATE
+	 * will now be set, and we shouldn't read it in again.
+	 */
+	if (unlikely(test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))) {
+		clear_bit(EXTENT_BUFFER_READING, &eb->bflags);
+		smp_mb__after_atomic();
+		wake_up_bit(&eb->bflags, EXTENT_BUFFER_READING);
+		return 0;
+	}
+
 	clear_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
 	eb->read_mirror = 0;
 	check_buffer_tree_ref(eb);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index bbfa44b89bc4..1dcf5bb8dfa6 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2959,11 +2959,6 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 				ctx.roots = NULL;
 			}
 
-			/* Free the reserved data space */
-			btrfs_qgroup_free_refroot(fs_info,
-					record->data_rsv_refroot,
-					record->data_rsv,
-					BTRFS_QGROUP_RSV_DATA);
 			/*
 			 * Use BTRFS_SEQ_LAST as time_seq to do special search,
 			 * which doesn't lock tree or delayed_refs and search
@@ -2987,6 +2982,11 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 			record->old_roots = NULL;
 			new_roots = NULL;
 		}
+		/* Free the reserved data space */
+		btrfs_qgroup_free_refroot(fs_info,
+				record->data_rsv_refroot,
+				record->data_rsv,
+				BTRFS_QGROUP_RSV_DATA);
 cleanup:
 		ulist_free(record->old_roots);
 		ulist_free(new_roots);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 443d2519f0a9..258b3e5585f7 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2809,7 +2809,17 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
 		gen = btrfs_get_last_trans_committed(fs_info);
 
 	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
-		bytenr = btrfs_sb_offset(i);
+		ret = btrfs_sb_log_location(scrub_dev, i, 0, &bytenr);
+		if (ret == -ENOENT)
+			break;
+
+		if (ret) {
+			spin_lock(&sctx->stat_lock);
+			sctx->stat.super_errors++;
+			spin_unlock(&sctx->stat_lock);
+			continue;
+		}
+
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >
 		    scrub_dev->commit_total_bytes)
 			break;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f627674b37db..fd30dc3d59c8 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -683,6 +683,16 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 	device->bdev = bdev_handle->bdev;
 	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 
+	if (device->devt != device->bdev->bd_dev) {
+		btrfs_warn(NULL,
+			   "device %s maj:min changed from %d:%d to %d:%d",
+			   device->name->str, MAJOR(device->devt),
+			   MINOR(device->devt), MAJOR(device->bdev->bd_dev),
+			   MINOR(device->bdev->bd_dev));
+
+		device->devt = device->bdev->bd_dev;
+	}
+
 	fs_devices->open_devices++;
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
 	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
@@ -1290,6 +1300,47 @@ int btrfs_forget_devices(dev_t devt)
 	return ret;
 }
 
+static bool btrfs_skip_registration(struct btrfs_super_block *disk_super,
+				    const char *path, dev_t devt,
+				    bool mount_arg_dev)
+{
+	struct btrfs_fs_devices *fs_devices;
+
+	/*
+	 * Do not skip device registration for mounted devices with matching
+	 * maj:min but different paths. Booting without initrd relies on
+	 * /dev/root initially, later replaced with the actual root device.
+	 * A successful scan ensures grub2-probe selects the correct device.
+	 */
+	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
+		struct btrfs_device *device;
+
+		mutex_lock(&fs_devices->device_list_mutex);
+
+		if (!fs_devices->opened) {
+			mutex_unlock(&fs_devices->device_list_mutex);
+			continue;
+		}
+
+		list_for_each_entry(device, &fs_devices->devices, dev_list) {
+			if (device->bdev && (device->bdev->bd_dev == devt) &&
+			    strcmp(device->name->str, path) != 0) {
+				mutex_unlock(&fs_devices->device_list_mutex);
+
+				/* Do not skip registration. */
+				return false;
+			}
+		}
+		mutex_unlock(&fs_devices->device_list_mutex);
+	}
+
+	if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
+	    !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING))
+		return true;
+
+	return false;
+}
+
 /*
  * Look for a btrfs signature on a device. This may be called out of the mount path
  * and we are not allowed to call set_blocksize during the scan. The superblock
@@ -1346,18 +1397,14 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 		goto error_bdev_put;
 	}
 
-	if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
-	    !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)) {
-		dev_t devt;
+	if (btrfs_skip_registration(disk_super, path, bdev_handle->bdev->bd_dev,
+				    mount_arg_dev)) {
+		pr_debug("BTRFS: skip registering single non-seed device %s (%d:%d)\n",
+			  path, MAJOR(bdev_handle->bdev->bd_dev),
+			  MINOR(bdev_handle->bdev->bd_dev));
 
-		ret = lookup_bdev(path, &devt);
-		if (ret)
-			btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
-				   path, ret);
-		else
-			btrfs_free_stale_devices(devt, NULL);
+		btrfs_free_stale_devices(bdev_handle->bdev->bd_dev, NULL);
 
-		pr_debug("BTRFS: skip registering single non-seed device %s\n", path);
 		device = NULL;
 		goto free_disk_super;
 	}
@@ -1392,7 +1439,7 @@ static bool contains_pending_extent(struct btrfs_device *device, u64 *start,
 
 		if (in_range(physical_start, *start, len) ||
 		    in_range(*start, physical_start,
-			     physical_end - physical_start)) {
+			     physical_end + 1 - physical_start)) {
 			*start = physical_end + 1;
 			return true;
 		}
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 034a617cb1a5..a40da0065433 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -751,13 +751,28 @@ static void __debugfs_file_removed(struct dentry *dentry)
 	if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)
 		return;
 
-	/* if we hit zero, just wait for all to finish */
-	if (!refcount_dec_and_test(&fsd->active_users)) {
-		wait_for_completion(&fsd->active_users_drained);
+	/* if this was the last reference, we're done */
+	if (refcount_dec_and_test(&fsd->active_users))
 		return;
-	}
 
-	/* if we didn't hit zero, try to cancel any we can */
+	/*
+	 * If there's still a reference, the code that obtained it can
+	 * be in different states:
+	 *  - The common case of not using cancellations, or already
+	 *    after debugfs_leave_cancellation(), where we just need
+	 *    to wait for debugfs_file_put() which signals the completion;
+	 *  - inside a cancellation section, i.e. between
+	 *    debugfs_enter_cancellation() and debugfs_leave_cancellation(),
+	 *    in which case we need to trigger the ->cancel() function,
+	 *    and then wait for debugfs_file_put() just like in the
+	 *    previous case;
+	 *  - before debugfs_enter_cancellation() (but obviously after
+	 *    debugfs_file_get()), in which case we may not see the
+	 *    cancellation in the list on the first round of the loop,
+	 *    but debugfs_enter_cancellation() signals the completion
+	 *    after adding it, so this code gets woken up to call the
+	 *    ->cancel() function.
+	 */
 	while (refcount_read(&fsd->active_users)) {
 		struct debugfs_cancellation *c;
 
diff --git a/fs/dlm/user.c b/fs/dlm/user.c
index 695e691b38b3..9f9b68448830 100644
--- a/fs/dlm/user.c
+++ b/fs/dlm/user.c
@@ -806,7 +806,7 @@ static ssize_t device_read(struct file *file, char __user *buf, size_t count,
 	struct dlm_lkb *lkb;
 	DECLARE_WAITQUEUE(wait, current);
 	struct dlm_callback *cb;
-	int rv, copy_lvb = 0;
+	int rv, ret, copy_lvb = 0;
 	int old_mode, new_mode;
 
 	if (count == sizeof(struct dlm_device_version)) {
@@ -906,9 +906,9 @@ static ssize_t device_read(struct file *file, char __user *buf, size_t count,
 		trace_dlm_ast(lkb->lkb_resource->res_ls, lkb);
 	}
 
-	rv = copy_result_to_user(lkb->lkb_ua,
-				 test_bit(DLM_PROC_FLAGS_COMPAT, &proc->flags),
-				 cb->flags, cb->mode, copy_lvb, buf, count);
+	ret = copy_result_to_user(lkb->lkb_ua,
+				  test_bit(DLM_PROC_FLAGS_COMPAT, &proc->flags),
+				  cb->flags, cb->mode, copy_lvb, buf, count);
 
 	kref_put(&cb->ref, dlm_release_callback);
 
@@ -916,7 +916,7 @@ static ssize_t device_read(struct file *file, char __user *buf, size_t count,
 	if (rv == DLM_DEQUEUE_CALLBACK_LAST)
 		dlm_put_lkb(lkb);
 
-	return rv;
+	return ret;
 }
 
 static __poll_t device_poll(struct file *file, poll_table *wait)
diff --git a/fs/eventfd.c b/fs/eventfd.c
index 33a918f9566c..d2f7d2d8a351 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -72,22 +72,19 @@ __u64 eventfd_signal_mask(struct eventfd_ctx *ctx, __u64 n, __poll_t mask)
 }
 
 /**
- * eventfd_signal - Adds @n to the eventfd counter.
+ * eventfd_signal - Increment the event counter
  * @ctx: [in] Pointer to the eventfd context.
- * @n: [in] Value of the counter to be added to the eventfd internal counter.
- *          The value cannot be negative.
  *
  * This function is supposed to be called by the kernel in paths that do not
  * allow sleeping. In this function we allow the counter to reach the ULLONG_MAX
  * value, and we signal this as overflow condition by returning a EPOLLERR
  * to poll(2).
  *
- * Returns the amount by which the counter was incremented.  This will be less
- * than @n if the counter has overflowed.
+ * Returns the amount by which the counter was incremented.
  */
-__u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
+__u64 eventfd_signal(struct eventfd_ctx *ctx)
 {
-	return eventfd_signal_mask(ctx, n, 0);
+	return eventfd_signal_mask(ctx, 1, 0);
 }
 EXPORT_SYMBOL_GPL(eventfd_signal);
 
diff --git a/fs/exec.c b/fs/exec.c
index 6d9ed2d765ef..7a1861a718c2 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -894,6 +894,7 @@ int transfer_args_to_stack(struct linux_binprm *bprm,
 			goto out;
 	}
 
+	bprm->exec += *sp_location - MAX_ARG_PAGES * PAGE_SIZE;
 	*sp_location = sp;
 
 out:
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 7497a789d002..38ec0fdb3395 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5173,10 +5173,16 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 			.fe_len = ac->ac_orig_goal_len,
 		};
 		loff_t orig_goal_end = extent_logical_end(sbi, &ex);
+		loff_t o_ex_end = extent_logical_end(sbi, &ac->ac_o_ex);
 
-		/* we can't allocate as much as normalizer wants.
-		 * so, found space must get proper lstart
-		 * to cover original request */
+		/*
+		 * We can't allocate as much as normalizer wants, so we try
+		 * to get proper lstart to cover the original request, except
+		 * when the goal doesn't cover the original request as below:
+		 *
+		 * orig_ex:2045/2055(10), isize:8417280 -> normalized:0/2048
+		 * best_ex:0/200(200) -> adjusted: 1848/2048(200)
+		 */
 		BUG_ON(ac->ac_g_ex.fe_logical > ac->ac_o_ex.fe_logical);
 		BUG_ON(ac->ac_g_ex.fe_len < ac->ac_o_ex.fe_len);
 
@@ -5188,7 +5194,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 		 * 1. Check if best ex can be kept at end of goal (before
 		 *    cr_best_avail trimmed it) and still cover original start
 		 * 2. Else, check if best ex can be kept at start of goal and
-		 *    still cover original start
+		 *    still cover original end
 		 * 3. Else, keep the best ex at start of original request.
 		 */
 		ex.fe_len = ac->ac_b_ex.fe_len;
@@ -5198,7 +5204,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 			goto adjust_bex;
 
 		ex.fe_logical = ac->ac_g_ex.fe_logical;
-		if (ac->ac_o_ex.fe_logical < extent_logical_end(sbi, &ex))
+		if (o_ex_end <= extent_logical_end(sbi, &ex))
 			goto adjust_bex;
 
 		ex.fe_logical = ac->ac_o_ex.fe_logical;
@@ -5206,7 +5212,6 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 		ac->ac_b_ex.fe_logical = ex.fe_logical;
 
 		BUG_ON(ac->ac_o_ex.fe_logical < ac->ac_b_ex.fe_logical);
-		BUG_ON(ac->ac_o_ex.fe_len > ac->ac_b_ex.fe_len);
 		BUG_ON(extent_logical_end(sbi, &ex) > orig_goal_end);
 	}
 
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index e168a9f59600..9a39596d2ac4 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1592,7 +1592,8 @@ static int ext4_flex_group_add(struct super_block *sb,
 		int gdb_num = group / EXT4_DESC_PER_BLOCK(sb);
 		int gdb_num_end = ((group + flex_gd->count - 1) /
 				   EXT4_DESC_PER_BLOCK(sb));
-		int meta_bg = ext4_has_feature_meta_bg(sb);
+		int meta_bg = ext4_has_feature_meta_bg(sb) &&
+			      gdb_num >= le32_to_cpu(es->s_first_meta_bg);
 		sector_t padding_blocks = meta_bg ? 0 : sbi->s_sbh->b_blocknr -
 					 ext4_group_first_block_no(sb, 0);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 200e1e43ef9b..3b6133c865a2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3025,6 +3025,7 @@ static inline void __mark_inode_dirty_flag(struct inode *inode,
 	case FI_INLINE_DOTS:
 	case FI_PIN_FILE:
 	case FI_COMPRESS_RELEASED:
+	case FI_ATOMIC_COMMITTED:
 		f2fs_mark_inode_dirty_sync(inode, true);
 	}
 }
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index dfc7fd8aa1e8..7a0143825e19 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -192,6 +192,9 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
 	if (!f2fs_is_atomic_file(inode))
 		return;
 
+	if (clean)
+		truncate_inode_pages_final(inode->i_mapping);
+
 	release_atomic_write_cnt(inode);
 	clear_inode_flag(inode, FI_ATOMIC_COMMITTED);
 	clear_inode_flag(inode, FI_ATOMIC_REPLACE);
@@ -201,7 +204,6 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
 	F2FS_I(inode)->atomic_write_task = NULL;
 
 	if (clean) {
-		truncate_inode_pages_final(inode->i_mapping);
 		f2fs_i_size_write(inode, fi->original_i_size);
 		fi->original_i_size = 0;
 	}
diff --git a/fs/fat/nfs.c b/fs/fat/nfs.c
index c52e63e10d35..509eea96a457 100644
--- a/fs/fat/nfs.c
+++ b/fs/fat/nfs.c
@@ -130,6 +130,12 @@ fat_encode_fh_nostale(struct inode *inode, __u32 *fh, int *lenp,
 		fid->parent_i_gen = parent->i_generation;
 		type = FILEID_FAT_WITH_PARENT;
 		*lenp = FAT_FID_SIZE_WITH_PARENT;
+	} else {
+		/*
+		 * We need to initialize this field because the fh is actually
+		 * 12 bytes long
+		 */
+		fid->parent_i_pos_hi = 0;
 	}
 
 	return type;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index d19cbf34c634..9307bb4393b8 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -391,6 +391,10 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 	err = -EIO;
 	if (fuse_invalid_attr(&outarg->attr))
 		goto out_put_forget;
+	if (outarg->nodeid == FUSE_ROOT_ID && outarg->generation != 0) {
+		pr_warn_once("root generation should be zero\n");
+		outarg->generation = 0;
+	}
 
 	*inode = fuse_iget(sb, outarg->nodeid, outarg->generation,
 			   &outarg->attr, ATTR_TIMEOUT(outarg),
@@ -1210,7 +1214,7 @@ static int fuse_do_statx(struct inode *inode, struct file *file,
 	if (((sx->mask & STATX_SIZE) && !fuse_valid_size(sx->size)) ||
 	    ((sx->mask & STATX_TYPE) && (!fuse_valid_type(sx->mode) ||
 					 inode_wrong_type(inode, sx->mode)))) {
-		make_bad_inode(inode);
+		fuse_make_bad(inode);
 		return -EIO;
 	}
 
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a660f1f21540..cc9651a01351 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2467,7 +2467,8 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 		return fuse_dax_mmap(file, vma);
 
 	if (ff->open_flags & FOPEN_DIRECT_IO) {
-		/* Can't provide the coherency needed for MAP_SHARED
+		/*
+		 * Can't provide the coherency needed for MAP_SHARED
 		 * if FUSE_DIRECT_IO_ALLOW_MMAP isn't set.
 		 */
 		if ((vma->vm_flags & VM_MAYSHARE) && !fc->direct_io_allow_mmap)
@@ -2475,7 +2476,10 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 
 		invalidate_inode_pages2(file->f_mapping);
 
-		return generic_file_mmap(file, vma);
+		if (!(vma->vm_flags & VM_MAYSHARE)) {
+			/* MAP_PRIVATE */
+			return generic_file_mmap(file, vma);
+		}
 	}
 
 	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 1df83eebda92..b5c241e16964 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -939,7 +939,6 @@ static inline bool fuse_stale_inode(const struct inode *inode, int generation,
 
 static inline void fuse_make_bad(struct inode *inode)
 {
-	remove_inode_hash(inode);
 	set_bit(FUSE_I_BAD, &get_fuse_inode(inode)->state);
 }
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 2a6d44f91729..b676c72c62ad 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -469,8 +469,11 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 	} else if (fuse_stale_inode(inode, generation, attr)) {
 		/* nodeid was reused, any I/O on the old inode should fail */
 		fuse_make_bad(inode);
-		iput(inode);
-		goto retry;
+		if (inode != d_inode(sb->s_root)) {
+			remove_inode_hash(inode);
+			iput(inode);
+			goto retry;
+		}
 	}
 	fi = get_fuse_inode(inode);
 	spin_lock(&fi->lock);
diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 5918c67dae0d..b6f801e73bfd 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -668,10 +668,17 @@ static void nfs_direct_commit_schedule(struct nfs_direct_req *dreq)
 	LIST_HEAD(mds_list);
 
 	nfs_init_cinfo_from_dreq(&cinfo, dreq);
+	nfs_commit_begin(cinfo.mds);
 	nfs_scan_commit(dreq->inode, &mds_list, &cinfo);
 	res = nfs_generic_commit_list(dreq->inode, &mds_list, 0, &cinfo);
-	if (res < 0) /* res == -ENOMEM */
-		nfs_direct_write_reschedule(dreq);
+	if (res < 0) { /* res == -ENOMEM */
+		spin_lock(&dreq->lock);
+		if (dreq->flags == 0)
+			dreq->flags = NFS_ODIRECT_RESCHED_WRITES;
+		spin_unlock(&dreq->lock);
+	}
+	if (nfs_commit_end(cinfo.mds))
+		nfs_direct_write_complete(dreq);
 }
 
 static void nfs_direct_write_clear_reqs(struct nfs_direct_req *dreq)
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 7dc21a48e3e7..a142287d86f6 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -305,6 +305,8 @@ int nfs_read_add_folio(struct nfs_pageio_descriptor *pgio,
 	new = nfs_page_create_from_folio(ctx, folio, 0, aligned_len);
 	if (IS_ERR(new)) {
 		error = PTR_ERR(new);
+		if (nfs_netfs_folio_unlock(folio))
+			folio_unlock(folio);
 		goto out;
 	}
 
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 9e345d3c305a..5c2ff4a31a34 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1663,7 +1663,7 @@ static int wait_on_commit(struct nfs_mds_commit_info *cinfo)
 				       !atomic_read(&cinfo->rpcs_out));
 }
 
-static void nfs_commit_begin(struct nfs_mds_commit_info *cinfo)
+void nfs_commit_begin(struct nfs_mds_commit_info *cinfo)
 {
 	atomic_inc(&cinfo->rpcs_out);
 }
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index fbc0ccb40424..4c7a296c4189 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -843,7 +843,7 @@ DECLARE_EVENT_CLASS(nfsd_clid_class,
 		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
 		__field(unsigned long, flavor)
 		__array(unsigned char, verifier, NFS4_VERIFIER_SIZE)
-		__string_len(name, name, clp->cl_name.len)
+		__string_len(name, clp->cl_name.data, clp->cl_name.len)
 	),
 	TP_fast_assign(
 		__entry->cl_boot = clp->cl_clientid.cl_boot;
diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index 13592e82eaf6..65659fa0372e 100644
--- a/fs/nilfs2/btree.c
+++ b/fs/nilfs2/btree.c
@@ -724,7 +724,7 @@ static int nilfs_btree_lookup_contig(const struct nilfs_bmap *btree,
 		dat = nilfs_bmap_get_dat(btree);
 		ret = nilfs_dat_translate(dat, ptr, &blocknr);
 		if (ret < 0)
-			goto out;
+			goto dat_error;
 		ptr = blocknr;
 	}
 	cnt = 1;
@@ -743,7 +743,7 @@ static int nilfs_btree_lookup_contig(const struct nilfs_bmap *btree,
 			if (dat) {
 				ret = nilfs_dat_translate(dat, ptr2, &blocknr);
 				if (ret < 0)
-					goto out;
+					goto dat_error;
 				ptr2 = blocknr;
 			}
 			if (ptr2 != ptr + cnt || ++cnt == maxblocks)
@@ -781,6 +781,11 @@ static int nilfs_btree_lookup_contig(const struct nilfs_bmap *btree,
  out:
 	nilfs_btree_free_path(path);
 	return ret;
+
+ dat_error:
+	if (ret == -ENOENT)
+		ret = -EINVAL;  /* Notify bmap layer of metadata corruption */
+	goto out;
 }
 
 static void nilfs_btree_promote_key(struct nilfs_bmap *btree,
diff --git a/fs/nilfs2/direct.c b/fs/nilfs2/direct.c
index 4c85914f2abc..893ab36824cc 100644
--- a/fs/nilfs2/direct.c
+++ b/fs/nilfs2/direct.c
@@ -66,7 +66,7 @@ static int nilfs_direct_lookup_contig(const struct nilfs_bmap *direct,
 		dat = nilfs_bmap_get_dat(direct);
 		ret = nilfs_dat_translate(dat, ptr, &blocknr);
 		if (ret < 0)
-			return ret;
+			goto dat_error;
 		ptr = blocknr;
 	}
 
@@ -79,7 +79,7 @@ static int nilfs_direct_lookup_contig(const struct nilfs_bmap *direct,
 		if (dat) {
 			ret = nilfs_dat_translate(dat, ptr2, &blocknr);
 			if (ret < 0)
-				return ret;
+				goto dat_error;
 			ptr2 = blocknr;
 		}
 		if (ptr2 != ptr + cnt)
@@ -87,6 +87,11 @@ static int nilfs_direct_lookup_contig(const struct nilfs_bmap *direct,
 	}
 	*ptrp = ptr;
 	return cnt;
+
+ dat_error:
+	if (ret == -ENOENT)
+		ret = -EINVAL;  /* Notify bmap layer of metadata corruption */
+	return ret;
 }
 
 static __u64
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index f861f3a0bf5c..da97149f832f 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -112,7 +112,7 @@ int nilfs_get_block(struct inode *inode, sector_t blkoff,
 					   "%s (ino=%lu): a race condition while inserting a data block at offset=%llu",
 					   __func__, inode->i_ino,
 					   (unsigned long long)blkoff);
-				err = 0;
+				err = -EAGAIN;
 			}
 			nilfs_transaction_abort(inode->i_sb);
 			goto out;
diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
index 5730c65ffb40..15e1215bc4e5 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -233,7 +233,8 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 		.tcon = tcon,
 		.path = path,
 		.create_options = cifs_create_options(cifs_sb, CREATE_NOT_FILE),
-		.desired_access =  FILE_READ_DATA | FILE_READ_ATTRIBUTES,
+		.desired_access =  FILE_READ_DATA | FILE_READ_ATTRIBUTES |
+				   FILE_READ_EA,
 		.disposition = FILE_OPEN,
 		.fid = pfid,
 	};
diff --git a/fs/smb/client/cifs_debug.c b/fs/smb/client/cifs_debug.c
index 60027f5aebe8..04a6351a9295 100644
--- a/fs/smb/client/cifs_debug.c
+++ b/fs/smb/client/cifs_debug.c
@@ -488,6 +488,8 @@ static int cifs_debug_data_proc_show(struct seq_file *m, void *v)
 				ses->ses_count, ses->serverOS, ses->serverNOS,
 				ses->capabilities, ses->ses_status);
 			}
+			if (ses->expired_pwd)
+				seq_puts(m, "password no longer valid ");
 			spin_unlock(&ses->ses_lock);
 
 			seq_printf(m, "\n\tSecurity type: %s ",
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 462554917e5a..35a12413bbee 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -339,6 +339,9 @@ struct smb_version_operations {
 	/* informational QFS call */
 	void (*qfs_tcon)(const unsigned int, struct cifs_tcon *,
 			 struct cifs_sb_info *);
+	/* query for server interfaces */
+	int (*query_server_interfaces)(const unsigned int, struct cifs_tcon *,
+				       bool);
 	/* check if a path is accessible or not */
 	int (*is_path_accessible)(const unsigned int, struct cifs_tcon *,
 				  struct cifs_sb_info *, const char *);
@@ -1052,6 +1055,7 @@ struct cifs_ses {
 	enum securityEnum sectype; /* what security flavor was specified? */
 	bool sign;		/* is signing required? */
 	bool domainAuto:1;
+	bool expired_pwd;  /* track if access denied or expired pwd so can know if need to update */
 	unsigned int flags;
 	__u16 session_flags;
 	__u8 smb3signingkey[SMB3_SIGN_KEY_SIZE];
@@ -1562,6 +1566,7 @@ struct cifsInodeInfo {
 	spinlock_t deferred_lock; /* protection on deferred list */
 	bool lease_granted; /* Flag to indicate whether lease or oplock is granted. */
 	char *symlink_target;
+	__u32 reparse_tag;
 };
 
 static inline struct cifsInodeInfo *
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 9516f5732324..13131957d961 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -144,7 +144,8 @@ extern int cifs_reconnect(struct TCP_Server_Info *server,
 extern int checkSMB(char *buf, unsigned int len, struct TCP_Server_Info *srvr);
 extern bool is_valid_oplock_break(char *, struct TCP_Server_Info *);
 extern bool backup_cred(struct cifs_sb_info *);
-extern bool is_size_safe_to_change(struct cifsInodeInfo *, __u64 eof);
+extern bool is_size_safe_to_change(struct cifsInodeInfo *cifsInode, __u64 eof,
+				   bool from_readdir);
 extern void cifs_update_eof(struct cifsInodeInfo *cifsi, loff_t offset,
 			    unsigned int bytes_written);
 extern struct cifsFileInfo *find_writable_file(struct cifsInodeInfo *, int);
@@ -201,7 +202,8 @@ extern void cifs_unix_basic_to_fattr(struct cifs_fattr *fattr,
 				     struct cifs_sb_info *cifs_sb);
 extern void cifs_dir_info_to_fattr(struct cifs_fattr *, FILE_DIRECTORY_INFO *,
 					struct cifs_sb_info *);
-extern int cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr);
+extern int cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr,
+			       bool from_readdir);
 extern struct inode *cifs_iget(struct super_block *sb,
 			       struct cifs_fattr *fattr);
 
@@ -652,7 +654,7 @@ cifs_chan_is_iface_active(struct cifs_ses *ses,
 			  struct TCP_Server_Info *server);
 void
 cifs_disable_secondary_channels(struct cifs_ses *ses);
-int
+void
 cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server);
 int
 SMB3_request_interfaces(const unsigned int xid, struct cifs_tcon *tcon, bool in_mount);
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index c3d805ecb7f1..bc8d09bab18b 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -123,12 +123,16 @@ static void smb2_query_server_interfaces(struct work_struct *work)
 	struct cifs_tcon *tcon = container_of(work,
 					struct cifs_tcon,
 					query_interfaces.work);
+	struct TCP_Server_Info *server = tcon->ses->server;
 
 	/*
 	 * query server network interfaces, in case they change
 	 */
+	if (!server->ops->query_server_interfaces)
+		return;
+
 	xid = get_xid();
-	rc = SMB3_request_interfaces(xid, tcon, false);
+	rc = server->ops->query_server_interfaces(xid, tcon, false);
 	free_xid(xid);
 
 	if (rc) {
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index c156460eb558..c711d5eb2987 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -329,7 +329,7 @@ int cifs_posix_open(const char *full_path, struct inode **pinode,
 		}
 	} else {
 		cifs_revalidate_mapping(*pinode);
-		rc = cifs_fattr_to_inode(*pinode, &fattr);
+		rc = cifs_fattr_to_inode(*pinode, &fattr, false);
 	}
 
 posix_open_ret:
@@ -4766,12 +4766,14 @@ static int is_inode_writable(struct cifsInodeInfo *cifs_inode)
    refreshing the inode only on increases in the file size
    but this is tricky to do without racing with writebehind
    page caching in the current Linux kernel design */
-bool is_size_safe_to_change(struct cifsInodeInfo *cifsInode, __u64 end_of_file)
+bool is_size_safe_to_change(struct cifsInodeInfo *cifsInode, __u64 end_of_file,
+			    bool from_readdir)
 {
 	if (!cifsInode)
 		return true;
 
-	if (is_inode_writable(cifsInode)) {
+	if (is_inode_writable(cifsInode) ||
+		((cifsInode->oplock & CIFS_CACHE_RW_FLG) != 0 && from_readdir)) {
 		/* This inode is open for write at least once */
 		struct cifs_sb_info *cifs_sb;
 
diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index 6ecbf48d0f0c..e4a6b240d226 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -771,7 +771,7 @@ static void smb3_fs_context_free(struct fs_context *fc)
  */
 static int smb3_verify_reconfigure_ctx(struct fs_context *fc,
 				       struct smb3_fs_context *new_ctx,
-				       struct smb3_fs_context *old_ctx)
+				       struct smb3_fs_context *old_ctx, bool need_recon)
 {
 	if (new_ctx->posix_paths != old_ctx->posix_paths) {
 		cifs_errorf(fc, "can not change posixpaths during remount\n");
@@ -797,8 +797,15 @@ static int smb3_verify_reconfigure_ctx(struct fs_context *fc,
 	}
 	if (new_ctx->password &&
 	    (!old_ctx->password || strcmp(new_ctx->password, old_ctx->password))) {
-		cifs_errorf(fc, "can not change password during remount\n");
-		return -EINVAL;
+		if (need_recon == false) {
+			cifs_errorf(fc,
+				    "can not change password of active session during remount\n");
+			return -EINVAL;
+		} else if (old_ctx->sectype == Kerberos) {
+			cifs_errorf(fc,
+				    "can not change password for Kerberos via remount\n");
+			return -EINVAL;
+		}
 	}
 	if (new_ctx->domainname &&
 	    (!old_ctx->domainname || strcmp(new_ctx->domainname, old_ctx->domainname))) {
@@ -842,9 +849,14 @@ static int smb3_reconfigure(struct fs_context *fc)
 	struct smb3_fs_context *ctx = smb3_fc2context(fc);
 	struct dentry *root = fc->root;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(root->d_sb);
+	struct cifs_ses *ses = cifs_sb_master_tcon(cifs_sb)->ses;
+	bool need_recon = false;
 	int rc;
 
-	rc = smb3_verify_reconfigure_ctx(fc, ctx, cifs_sb->ctx);
+	if (ses->expired_pwd)
+		need_recon = true;
+
+	rc = smb3_verify_reconfigure_ctx(fc, ctx, cifs_sb->ctx, need_recon);
 	if (rc)
 		return rc;
 
@@ -857,7 +869,12 @@ static int smb3_reconfigure(struct fs_context *fc)
 	STEAL_STRING(cifs_sb, ctx, UNC);
 	STEAL_STRING(cifs_sb, ctx, source);
 	STEAL_STRING(cifs_sb, ctx, username);
-	STEAL_STRING_SENSITIVE(cifs_sb, ctx, password);
+	if (need_recon == false)
+		STEAL_STRING_SENSITIVE(cifs_sb, ctx, password);
+	else  {
+		kfree_sensitive(ses->password);
+		ses->password = kstrdup(ctx->password, GFP_KERNEL);
+	}
 	STEAL_STRING(cifs_sb, ctx, domainname);
 	STEAL_STRING(cifs_sb, ctx, nodename);
 	STEAL_STRING(cifs_sb, ctx, iocharset);
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index eb54e4893777..cb9e719e67ae 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -147,7 +147,8 @@ cifs_nlink_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr)
 
 /* populate an inode with info from a cifs_fattr struct */
 int
-cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr)
+cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr,
+		    bool from_readdir)
 {
 	struct cifsInodeInfo *cifs_i = CIFS_I(inode);
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
@@ -182,6 +183,7 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr)
 		inode->i_mode = fattr->cf_mode;
 
 	cifs_i->cifsAttrs = fattr->cf_cifsattrs;
+	cifs_i->reparse_tag = fattr->cf_cifstag;
 
 	if (fattr->cf_flags & CIFS_FATTR_NEED_REVAL)
 		cifs_i->time = 0;
@@ -198,7 +200,7 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr)
 	 * Can't safely change the file size here if the client is writing to
 	 * it due to potential races.
 	 */
-	if (is_size_safe_to_change(cifs_i, fattr->cf_eof)) {
+	if (is_size_safe_to_change(cifs_i, fattr->cf_eof, from_readdir)) {
 		i_size_write(inode, fattr->cf_eof);
 
 		/*
@@ -209,7 +211,7 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr)
 		inode->i_blocks = (512 - 1 + fattr->cf_bytes) >> 9;
 	}
 
-	if (S_ISLNK(fattr->cf_mode)) {
+	if (S_ISLNK(fattr->cf_mode) && fattr->cf_symlink_target) {
 		kfree(cifs_i->symlink_target);
 		cifs_i->symlink_target = fattr->cf_symlink_target;
 		fattr->cf_symlink_target = NULL;
@@ -367,7 +369,7 @@ static int update_inode_info(struct super_block *sb,
 		CIFS_I(*inode)->time = 0; /* force reval */
 		return -ESTALE;
 	}
-	return cifs_fattr_to_inode(*inode, fattr);
+	return cifs_fattr_to_inode(*inode, fattr, false);
 }
 
 #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
@@ -402,7 +404,7 @@ cifs_get_file_info_unix(struct file *filp)
 	} else
 		goto cifs_gfiunix_out;
 
-	rc = cifs_fattr_to_inode(inode, &fattr);
+	rc = cifs_fattr_to_inode(inode, &fattr, false);
 
 cifs_gfiunix_out:
 	free_xid(xid);
@@ -927,7 +929,7 @@ cifs_get_file_info(struct file *filp)
 	fattr.cf_uniqueid = CIFS_I(inode)->uniqueid;
 	fattr.cf_flags |= CIFS_FATTR_NEED_REVAL;
 	/* if filetype is different, return error */
-	rc = cifs_fattr_to_inode(inode, &fattr);
+	rc = cifs_fattr_to_inode(inode, &fattr, false);
 cgfi_exit:
 	cifs_free_open_info(&data);
 	free_xid(xid);
@@ -1103,6 +1105,7 @@ static int reparse_info_to_fattr(struct cifs_open_info_data *data,
 
 	cifs_open_info_to_fattr(fattr, data, sb);
 out:
+	fattr->cf_cifstag = data->reparse.tag;
 	free_rsp_buf(rsp_buftype, rsp_iov.iov_base);
 	return rc;
 }
@@ -1465,7 +1468,7 @@ cifs_iget(struct super_block *sb, struct cifs_fattr *fattr)
 		}
 
 		/* can't fail - see cifs_find_inode() */
-		cifs_fattr_to_inode(inode, fattr);
+		cifs_fattr_to_inode(inode, fattr, false);
 		if (sb->s_flags & SB_NOATIME)
 			inode->i_flags |= S_NOATIME | S_NOCMTIME;
 		if (inode->i_state & I_NEW) {
diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
index e23cd216bffb..56033e4e4bae 100644
--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -55,6 +55,23 @@ static inline void dump_cifs_file_struct(struct file *file, char *label)
 }
 #endif /* DEBUG2 */
 
+/*
+ * Match a reparse point inode if reparse tag and ctime haven't changed.
+ *
+ * Windows Server updates ctime of reparse points when their data have changed.
+ * The server doesn't allow changing reparse tags from existing reparse points,
+ * though it's worth checking.
+ */
+static inline bool reparse_inode_match(struct inode *inode,
+				       struct cifs_fattr *fattr)
+{
+	struct timespec64 ctime = inode_get_ctime(inode);
+
+	return (CIFS_I(inode)->cifsAttrs & ATTR_REPARSE) &&
+		CIFS_I(inode)->reparse_tag == fattr->cf_cifstag &&
+		timespec64_equal(&ctime, &fattr->cf_ctime);
+}
+
 /*
  * Attempt to preload the dcache with the results from the FIND_FIRST/NEXT
  *
@@ -71,6 +88,7 @@ cifs_prime_dcache(struct dentry *parent, struct qstr *name,
 	struct super_block *sb = parent->d_sb;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
+	int rc;
 
 	cifs_dbg(FYI, "%s: for %s\n", __func__, name->name);
 
@@ -82,9 +100,11 @@ cifs_prime_dcache(struct dentry *parent, struct qstr *name,
 		 * We'll end up doing an on the wire call either way and
 		 * this spares us an invalidation.
 		 */
-		if (fattr->cf_flags & CIFS_FATTR_NEED_REVAL)
-			return;
 retry:
+		if ((fattr->cf_cifsattrs & ATTR_REPARSE) ||
+		    (fattr->cf_flags & CIFS_FATTR_NEED_REVAL))
+			return;
+
 		dentry = d_alloc_parallel(parent, name, &wq);
 	}
 	if (IS_ERR(dentry))
@@ -104,12 +124,34 @@ cifs_prime_dcache(struct dentry *parent, struct qstr *name,
 			if (!(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM))
 				fattr->cf_uniqueid = CIFS_I(inode)->uniqueid;
 
-			/* update inode in place
-			 * if both i_ino and i_mode didn't change */
-			if (CIFS_I(inode)->uniqueid == fattr->cf_uniqueid &&
-			    cifs_fattr_to_inode(inode, fattr) == 0) {
-				dput(dentry);
-				return;
+			/*
+			 * Update inode in place if both i_ino and i_mode didn't
+			 * change.
+			 */
+			if (CIFS_I(inode)->uniqueid == fattr->cf_uniqueid) {
+				/*
+				 * Query dir responses don't provide enough
+				 * information about reparse points other than
+				 * their reparse tags.  Save an invalidation by
+				 * not clobbering the existing mode, size and
+				 * symlink target (if any) when reparse tag and
+				 * ctime haven't changed.
+				 */
+				rc = 0;
+				if (fattr->cf_cifsattrs & ATTR_REPARSE) {
+					if (likely(reparse_inode_match(inode, fattr))) {
+						fattr->cf_mode = inode->i_mode;
+						fattr->cf_eof = CIFS_I(inode)->server_eof;
+						fattr->cf_symlink_target = NULL;
+					} else {
+						CIFS_I(inode)->time = 0;
+						rc = -ESTALE;
+					}
+				}
+				if (!rc && !cifs_fattr_to_inode(inode, fattr, true)) {
+					dput(dentry);
+					return;
+				}
 			}
 		}
 		d_invalidate(dentry);
@@ -127,29 +169,6 @@ cifs_prime_dcache(struct dentry *parent, struct qstr *name,
 	dput(dentry);
 }
 
-static bool reparse_file_needs_reval(const struct cifs_fattr *fattr)
-{
-	if (!(fattr->cf_cifsattrs & ATTR_REPARSE))
-		return false;
-	/*
-	 * The DFS tags should be only intepreted by server side as per
-	 * MS-FSCC 2.1.2.1, but let's include them anyway.
-	 *
-	 * Besides, if cf_cifstag is unset (0), then we still need it to be
-	 * revalidated to know exactly what reparse point it is.
-	 */
-	switch (fattr->cf_cifstag) {
-	case IO_REPARSE_TAG_DFS:
-	case IO_REPARSE_TAG_DFSR:
-	case IO_REPARSE_TAG_SYMLINK:
-	case IO_REPARSE_TAG_NFS:
-	case IO_REPARSE_TAG_MOUNT_POINT:
-	case 0:
-		return true;
-	}
-	return false;
-}
-
 static void
 cifs_fill_common_info(struct cifs_fattr *fattr, struct cifs_sb_info *cifs_sb)
 {
@@ -181,14 +200,6 @@ cifs_fill_common_info(struct cifs_fattr *fattr, struct cifs_sb_info *cifs_sb)
 	}
 
 out_reparse:
-	/*
-	 * We need to revalidate it further to make a decision about whether it
-	 * is a symbolic link, DFS referral or a reparse point with a direct
-	 * access like junctions, deduplicated files, NFS symlinks.
-	 */
-	if (reparse_file_needs_reval(fattr))
-		fattr->cf_flags |= CIFS_FATTR_NEED_REVAL;
-
 	/* non-unix readdir doesn't provide nlink */
 	fattr->cf_flags |= CIFS_FATTR_UNKNOWN_NLINK;
 
@@ -269,9 +280,6 @@ cifs_posix_to_fattr(struct cifs_fattr *fattr, struct smb2_posix_info *info,
 		fattr->cf_dtype = DT_REG;
 	}
 
-	if (reparse_file_needs_reval(fattr))
-		fattr->cf_flags |= CIFS_FATTR_NEED_REVAL;
-
 	sid_to_id(cifs_sb, &parsed.owner, fattr, SIDOWNER);
 	sid_to_id(cifs_sb, &parsed.group, fattr, SIDGROUP);
 }
@@ -333,38 +341,6 @@ cifs_std_info_to_fattr(struct cifs_fattr *fattr, FIND_FILE_STANDARD_INFO *info,
 	cifs_fill_common_info(fattr, cifs_sb);
 }
 
-/* BB eventually need to add the following helper function to
-      resolve NT_STATUS_STOPPED_ON_SYMLINK return code when
-      we try to do FindFirst on (NTFS) directory symlinks */
-/*
-int get_symlink_reparse_path(char *full_path, struct cifs_sb_info *cifs_sb,
-			     unsigned int xid)
-{
-	__u16 fid;
-	int len;
-	int oplock = 0;
-	int rc;
-	struct cifs_tcon *ptcon = cifs_sb_tcon(cifs_sb);
-	char *tmpbuffer;
-
-	rc = CIFSSMBOpen(xid, ptcon, full_path, FILE_OPEN, GENERIC_READ,
-			OPEN_REPARSE_POINT, &fid, &oplock, NULL,
-			cifs_sb->local_nls,
-			cifs_remap(cifs_sb);
-	if (!rc) {
-		tmpbuffer = kmalloc(maxpath);
-		rc = CIFSSMBQueryReparseLinkInfo(xid, ptcon, full_path,
-				tmpbuffer,
-				maxpath -1,
-				fid,
-				cifs_sb->local_nls);
-		if (CIFSSMBClose(xid, ptcon, fid)) {
-			cifs_dbg(FYI, "Error closing temporary reparsepoint open\n");
-		}
-	}
-}
- */
-
 static int
 _initiate_cifs_search(const unsigned int xid, struct file *file,
 		     const char *full_path)
@@ -433,13 +409,10 @@ _initiate_cifs_search(const unsigned int xid, struct file *file,
 					  &cifsFile->fid, search_flags,
 					  &cifsFile->srch_inf);
 
-	if (rc == 0)
+	if (rc == 0) {
 		cifsFile->invalidHandle = false;
-	/* BB add following call to handle readdir on new NTFS symlink errors
-	else if STATUS_STOPPED_ON_SYMLINK
-		call get_symlink_reparse_path and retry with new path */
-	else if ((rc == -EOPNOTSUPP) &&
-		(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM)) {
+	} else if ((rc == -EOPNOTSUPP) &&
+		   (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM)) {
 		cifs_sb->mnt_cifs_flags &= ~CIFS_MOUNT_SERVER_INUM;
 		goto ffirst_retry;
 	}
diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index 94c5d50aa347..5de32640f026 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -230,7 +230,7 @@ int cifs_try_adding_channels(struct cifs_ses *ses)
 		spin_lock(&ses->iface_lock);
 		if (!ses->iface_count) {
 			spin_unlock(&ses->iface_lock);
-			cifs_dbg(VFS, "server %s does not advertise interfaces\n",
+			cifs_dbg(ONCE, "server %s does not advertise interfaces\n",
 				      ses->server->hostname);
 			break;
 		}
@@ -361,10 +361,9 @@ cifs_disable_secondary_channels(struct cifs_ses *ses)
 
 /*
  * update the iface for the channel if necessary.
- * will return 0 when iface is updated, 1 if removed, 2 otherwise
  * Must be called with chan_lock held.
  */
-int
+void
 cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 {
 	unsigned int chan_index;
@@ -373,20 +372,19 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 	struct cifs_server_iface *old_iface = NULL;
 	struct cifs_server_iface *last_iface = NULL;
 	struct sockaddr_storage ss;
-	int rc = 0;
 
 	spin_lock(&ses->chan_lock);
 	chan_index = cifs_ses_get_chan_index(ses, server);
 	if (chan_index == CIFS_INVAL_CHAN_INDEX) {
 		spin_unlock(&ses->chan_lock);
-		return 0;
+		return;
 	}
 
 	if (ses->chans[chan_index].iface) {
 		old_iface = ses->chans[chan_index].iface;
 		if (old_iface->is_active) {
 			spin_unlock(&ses->chan_lock);
-			return 1;
+			return;
 		}
 	}
 	spin_unlock(&ses->chan_lock);
@@ -398,8 +396,8 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 	spin_lock(&ses->iface_lock);
 	if (!ses->iface_count) {
 		spin_unlock(&ses->iface_lock);
-		cifs_dbg(VFS, "server %s does not advertise interfaces\n", ses->server->hostname);
-		return 0;
+		cifs_dbg(ONCE, "server %s does not advertise interfaces\n", ses->server->hostname);
+		return;
 	}
 
 	last_iface = list_last_entry(&ses->iface_list, struct cifs_server_iface,
@@ -439,7 +437,6 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 	}
 
 	if (list_entry_is_head(iface, &ses->iface_list, iface_head)) {
-		rc = 1;
 		iface = NULL;
 		cifs_dbg(FYI, "unable to find a suitable iface\n");
 	}
@@ -454,7 +451,7 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 		}
 
 		spin_unlock(&ses->iface_lock);
-		return 0;
+		return;
 	}
 
 	/* now drop the ref to the current iface */
@@ -472,28 +469,24 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 		kref_put(&old_iface->refcount, release_iface);
 	} else if (!chan_index) {
 		/* special case: update interface for primary channel */
-		if (iface) {
-			cifs_dbg(FYI, "referencing primary channel iface: %pIS\n",
-				 &iface->sockaddr);
-			iface->num_channels++;
-			iface->weight_fulfilled++;
-		}
+		cifs_dbg(FYI, "referencing primary channel iface: %pIS\n",
+			 &iface->sockaddr);
+		iface->num_channels++;
+		iface->weight_fulfilled++;
 	}
 	spin_unlock(&ses->iface_lock);
 
-	if (iface) {
-		spin_lock(&ses->chan_lock);
-		chan_index = cifs_ses_get_chan_index(ses, server);
-		if (chan_index == CIFS_INVAL_CHAN_INDEX) {
-			spin_unlock(&ses->chan_lock);
-			return 0;
-		}
-
-		ses->chans[chan_index].iface = iface;
+	spin_lock(&ses->chan_lock);
+	chan_index = cifs_ses_get_chan_index(ses, server);
+	if (chan_index == CIFS_INVAL_CHAN_INDEX) {
 		spin_unlock(&ses->chan_lock);
+		return;
 	}
 
-	return rc;
+	ses->chans[chan_index].iface = iface;
+	spin_unlock(&ses->chan_lock);
+
+	return;
 }
 
 /*
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index ba734395b036..4852afe3929b 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -5429,6 +5429,7 @@ struct smb_version_operations smb30_operations = {
 	.tree_connect = SMB2_tcon,
 	.tree_disconnect = SMB2_tdis,
 	.qfs_tcon = smb3_qfs_tcon,
+	.query_server_interfaces = SMB3_request_interfaces,
 	.is_path_accessible = smb2_is_path_accessible,
 	.can_echo = smb2_can_echo,
 	.echo = SMB2_echo,
@@ -5543,6 +5544,7 @@ struct smb_version_operations smb311_operations = {
 	.tree_connect = SMB2_tcon,
 	.tree_disconnect = SMB2_tdis,
 	.qfs_tcon = smb3_qfs_tcon,
+	.query_server_interfaces = SMB3_request_interfaces,
 	.is_path_accessible = smb2_is_path_accessible,
 	.can_echo = smb2_can_echo,
 	.echo = SMB2_echo,
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 9d34a55fdb5e..4d7d0bdf7a47 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -409,14 +409,15 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 	spin_unlock(&ses->ses_lock);
 
 	if (!rc &&
-	    (server->capabilities & SMB2_GLOBAL_CAP_MULTI_CHANNEL)) {
+	    (server->capabilities & SMB2_GLOBAL_CAP_MULTI_CHANNEL) &&
+	    server->ops->query_server_interfaces) {
 		mutex_unlock(&ses->session_mutex);
 
 		/*
 		 * query server network interfaces, in case they change
 		 */
 		xid = get_xid();
-		rc = SMB3_request_interfaces(xid, tcon, false);
+		rc = server->ops->query_server_interfaces(xid, tcon, false);
 		free_xid(xid);
 
 		if (rc == -EOPNOTSUPP && ses->chan_count > 1) {
@@ -1536,6 +1537,11 @@ SMB2_sess_sendreceive(struct SMB2_sess_data *sess_data)
 			    &sess_data->buf0_type,
 			    CIFS_LOG_ERROR | CIFS_SESS_OP, &rsp_iov);
 	cifs_small_buf_release(sess_data->iov[0].iov_base);
+	if (rc == 0)
+		sess_data->ses->expired_pwd = false;
+	else if ((rc == -EACCES) || (rc == -EKEYEXPIRED) || (rc == -EKEYREVOKED))
+		sess_data->ses->expired_pwd = true;
+
 	memcpy(&sess_data->iov[0], &rsp_iov, sizeof(struct kvec));
 
 	return rc;
diff --git a/fs/smb/server/smb2misc.c b/fs/smb/server/smb2misc.c
index 03dded29a980..727cb49926ee 100644
--- a/fs/smb/server/smb2misc.c
+++ b/fs/smb/server/smb2misc.c
@@ -101,13 +101,17 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 		*len = le16_to_cpu(((struct smb2_sess_setup_req *)hdr)->SecurityBufferLength);
 		break;
 	case SMB2_TREE_CONNECT:
-		*off = le16_to_cpu(((struct smb2_tree_connect_req *)hdr)->PathOffset);
+		*off = max_t(unsigned short int,
+			     le16_to_cpu(((struct smb2_tree_connect_req *)hdr)->PathOffset),
+			     offsetof(struct smb2_tree_connect_req, Buffer));
 		*len = le16_to_cpu(((struct smb2_tree_connect_req *)hdr)->PathLength);
 		break;
 	case SMB2_CREATE:
 	{
 		unsigned short int name_off =
-			le16_to_cpu(((struct smb2_create_req *)hdr)->NameOffset);
+			max_t(unsigned short int,
+			      le16_to_cpu(((struct smb2_create_req *)hdr)->NameOffset),
+			      offsetof(struct smb2_create_req, Buffer));
 		unsigned short int name_len =
 			le16_to_cpu(((struct smb2_create_req *)hdr)->NameLength);
 
@@ -128,11 +132,15 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 		break;
 	}
 	case SMB2_QUERY_INFO:
-		*off = le16_to_cpu(((struct smb2_query_info_req *)hdr)->InputBufferOffset);
+		*off = max_t(unsigned int,
+			     le16_to_cpu(((struct smb2_query_info_req *)hdr)->InputBufferOffset),
+			     offsetof(struct smb2_query_info_req, Buffer));
 		*len = le32_to_cpu(((struct smb2_query_info_req *)hdr)->InputBufferLength);
 		break;
 	case SMB2_SET_INFO:
-		*off = le16_to_cpu(((struct smb2_set_info_req *)hdr)->BufferOffset);
+		*off = max_t(unsigned int,
+			     le16_to_cpu(((struct smb2_set_info_req *)hdr)->BufferOffset),
+			     offsetof(struct smb2_set_info_req, Buffer));
 		*len = le32_to_cpu(((struct smb2_set_info_req *)hdr)->BufferLength);
 		break;
 	case SMB2_READ:
@@ -142,7 +150,7 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 	case SMB2_WRITE:
 		if (((struct smb2_write_req *)hdr)->DataOffset ||
 		    ((struct smb2_write_req *)hdr)->Length) {
-			*off = max_t(unsigned int,
+			*off = max_t(unsigned short int,
 				     le16_to_cpu(((struct smb2_write_req *)hdr)->DataOffset),
 				     offsetof(struct smb2_write_req, Buffer));
 			*len = le32_to_cpu(((struct smb2_write_req *)hdr)->Length);
@@ -153,7 +161,9 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 		*len = le16_to_cpu(((struct smb2_write_req *)hdr)->WriteChannelInfoLength);
 		break;
 	case SMB2_QUERY_DIRECTORY:
-		*off = le16_to_cpu(((struct smb2_query_directory_req *)hdr)->FileNameOffset);
+		*off = max_t(unsigned short int,
+			     le16_to_cpu(((struct smb2_query_directory_req *)hdr)->FileNameOffset),
+			     offsetof(struct smb2_query_directory_req, Buffer));
 		*len = le16_to_cpu(((struct smb2_query_directory_req *)hdr)->FileNameLength);
 		break;
 	case SMB2_LOCK:
@@ -168,7 +178,9 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 		break;
 	}
 	case SMB2_IOCTL:
-		*off = le32_to_cpu(((struct smb2_ioctl_req *)hdr)->InputOffset);
+		*off = max_t(unsigned int,
+			     le32_to_cpu(((struct smb2_ioctl_req *)hdr)->InputOffset),
+			     offsetof(struct smb2_ioctl_req, Buffer));
 		*len = le32_to_cpu(((struct smb2_ioctl_req *)hdr)->InputCount);
 		break;
 	default:
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 0c97d3c86072..88db6e207e0e 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1951,7 +1951,7 @@ int smb2_tree_connect(struct ksmbd_work *work)
 
 	WORK_BUFFERS(work, req, rsp);
 
-	treename = smb_strndup_from_utf16(req->Buffer,
+	treename = smb_strndup_from_utf16((char *)req + le16_to_cpu(req->PathOffset),
 					  le16_to_cpu(req->PathLength), true,
 					  conn->local_nls);
 	if (IS_ERR(treename)) {
@@ -2704,7 +2704,7 @@ int smb2_open(struct ksmbd_work *work)
 			goto err_out2;
 		}
 
-		name = smb2_get_name(req->Buffer,
+		name = smb2_get_name((char *)req + le16_to_cpu(req->NameOffset),
 				     le16_to_cpu(req->NameLength),
 				     work->conn->local_nls);
 		if (IS_ERR(name)) {
@@ -3828,11 +3828,16 @@ static int process_query_dir_entries(struct smb2_query_dir_private *priv)
 		}
 
 		ksmbd_kstat.kstat = &kstat;
-		if (priv->info_level != FILE_NAMES_INFORMATION)
-			ksmbd_vfs_fill_dentry_attrs(priv->work,
-						    idmap,
-						    dent,
-						    &ksmbd_kstat);
+		if (priv->info_level != FILE_NAMES_INFORMATION) {
+			rc = ksmbd_vfs_fill_dentry_attrs(priv->work,
+							 idmap,
+							 dent,
+							 &ksmbd_kstat);
+			if (rc) {
+				dput(dent);
+				continue;
+			}
+		}
 
 		rc = smb2_populate_readdir_entry(priv->work->conn,
 						 priv->info_level,
@@ -4075,7 +4080,7 @@ int smb2_query_dir(struct ksmbd_work *work)
 	}
 
 	srch_flag = req->Flags;
-	srch_ptr = smb_strndup_from_utf16(req->Buffer,
+	srch_ptr = smb_strndup_from_utf16((char *)req + le16_to_cpu(req->FileNameOffset),
 					  le16_to_cpu(req->FileNameLength), 1,
 					  conn->local_nls);
 	if (IS_ERR(srch_ptr)) {
@@ -4335,7 +4340,8 @@ static int smb2_get_ea(struct ksmbd_work *work, struct ksmbd_file *fp,
 		    sizeof(struct smb2_ea_info_req))
 			return -EINVAL;
 
-		ea_req = (struct smb2_ea_info_req *)req->Buffer;
+		ea_req = (struct smb2_ea_info_req *)((char *)req +
+						     le16_to_cpu(req->InputBufferOffset));
 	} else {
 		/* need to send all EAs, if no specific EA is requested*/
 		if (le32_to_cpu(req->Flags) & SL_RETURN_SINGLE_ENTRY)
@@ -4480,6 +4486,7 @@ static int get_file_basic_info(struct smb2_query_info_rsp *rsp,
 	struct smb2_file_basic_info *basic_info;
 	struct kstat stat;
 	u64 time;
+	int ret;
 
 	if (!(fp->daccess & FILE_READ_ATTRIBUTES_LE)) {
 		pr_err("no right to read the attributes : 0x%x\n",
@@ -4487,9 +4494,12 @@ static int get_file_basic_info(struct smb2_query_info_rsp *rsp,
 		return -EACCES;
 	}
 
+	ret = vfs_getattr(&fp->filp->f_path, &stat, STATX_BASIC_STATS,
+			  AT_STATX_SYNC_AS_STAT);
+	if (ret)
+		return ret;
+
 	basic_info = (struct smb2_file_basic_info *)rsp->Buffer;
-	generic_fillattr(file_mnt_idmap(fp->filp), STATX_BASIC_STATS,
-			 file_inode(fp->filp), &stat);
 	basic_info->CreationTime = cpu_to_le64(fp->create_time);
 	time = ksmbd_UnixTimeToNT(stat.atime);
 	basic_info->LastAccessTime = cpu_to_le64(time);
@@ -4504,27 +4514,31 @@ static int get_file_basic_info(struct smb2_query_info_rsp *rsp,
 	return 0;
 }
 
-static void get_file_standard_info(struct smb2_query_info_rsp *rsp,
-				   struct ksmbd_file *fp, void *rsp_org)
+static int get_file_standard_info(struct smb2_query_info_rsp *rsp,
+				  struct ksmbd_file *fp, void *rsp_org)
 {
 	struct smb2_file_standard_info *sinfo;
 	unsigned int delete_pending;
-	struct inode *inode;
 	struct kstat stat;
+	int ret;
 
-	inode = file_inode(fp->filp);
-	generic_fillattr(file_mnt_idmap(fp->filp), STATX_BASIC_STATS, inode, &stat);
+	ret = vfs_getattr(&fp->filp->f_path, &stat, STATX_BASIC_STATS,
+			  AT_STATX_SYNC_AS_STAT);
+	if (ret)
+		return ret;
 
 	sinfo = (struct smb2_file_standard_info *)rsp->Buffer;
 	delete_pending = ksmbd_inode_pending_delete(fp);
 
-	sinfo->AllocationSize = cpu_to_le64(inode->i_blocks << 9);
+	sinfo->AllocationSize = cpu_to_le64(stat.blocks << 9);
 	sinfo->EndOfFile = S_ISDIR(stat.mode) ? 0 : cpu_to_le64(stat.size);
 	sinfo->NumberOfLinks = cpu_to_le32(get_nlink(&stat) - delete_pending);
 	sinfo->DeletePending = delete_pending;
 	sinfo->Directory = S_ISDIR(stat.mode) ? 1 : 0;
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_standard_info));
+
+	return 0;
 }
 
 static void get_file_alignment_info(struct smb2_query_info_rsp *rsp,
@@ -4546,11 +4560,11 @@ static int get_file_all_info(struct ksmbd_work *work,
 	struct ksmbd_conn *conn = work->conn;
 	struct smb2_file_all_info *file_info;
 	unsigned int delete_pending;
-	struct inode *inode;
 	struct kstat stat;
 	int conv_len;
 	char *filename;
 	u64 time;
+	int ret;
 
 	if (!(fp->daccess & FILE_READ_ATTRIBUTES_LE)) {
 		ksmbd_debug(SMB, "no right to read the attributes : 0x%x\n",
@@ -4562,8 +4576,10 @@ static int get_file_all_info(struct ksmbd_work *work,
 	if (IS_ERR(filename))
 		return PTR_ERR(filename);
 
-	inode = file_inode(fp->filp);
-	generic_fillattr(file_mnt_idmap(fp->filp), STATX_BASIC_STATS, inode, &stat);
+	ret = vfs_getattr(&fp->filp->f_path, &stat, STATX_BASIC_STATS,
+			  AT_STATX_SYNC_AS_STAT);
+	if (ret)
+		return ret;
 
 	ksmbd_debug(SMB, "filename = %s\n", filename);
 	delete_pending = ksmbd_inode_pending_delete(fp);
@@ -4579,7 +4595,7 @@ static int get_file_all_info(struct ksmbd_work *work,
 	file_info->Attributes = fp->f_ci->m_fattr;
 	file_info->Pad1 = 0;
 	file_info->AllocationSize =
-		cpu_to_le64(inode->i_blocks << 9);
+		cpu_to_le64(stat.blocks << 9);
 	file_info->EndOfFile = S_ISDIR(stat.mode) ? 0 : cpu_to_le64(stat.size);
 	file_info->NumberOfLinks =
 			cpu_to_le32(get_nlink(&stat) - delete_pending);
@@ -4623,10 +4639,10 @@ static void get_file_alternate_info(struct ksmbd_work *work,
 		cpu_to_le32(sizeof(struct smb2_file_alt_name_info) + conv_len);
 }
 
-static void get_file_stream_info(struct ksmbd_work *work,
-				 struct smb2_query_info_rsp *rsp,
-				 struct ksmbd_file *fp,
-				 void *rsp_org)
+static int get_file_stream_info(struct ksmbd_work *work,
+				struct smb2_query_info_rsp *rsp,
+				struct ksmbd_file *fp,
+				void *rsp_org)
 {
 	struct ksmbd_conn *conn = work->conn;
 	struct smb2_file_stream_info *file_info;
@@ -4637,9 +4653,13 @@ static void get_file_stream_info(struct ksmbd_work *work,
 	int nbytes = 0, streamlen, stream_name_len, next, idx = 0;
 	int buf_free_len;
 	struct smb2_query_info_req *req = ksmbd_req_buf_next(work);
+	int ret;
+
+	ret = vfs_getattr(&fp->filp->f_path, &stat, STATX_BASIC_STATS,
+			  AT_STATX_SYNC_AS_STAT);
+	if (ret)
+		return ret;
 
-	generic_fillattr(file_mnt_idmap(fp->filp), STATX_BASIC_STATS,
-			 file_inode(fp->filp), &stat);
 	file_info = (struct smb2_file_stream_info *)rsp->Buffer;
 
 	buf_free_len =
@@ -4720,29 +4740,37 @@ static void get_file_stream_info(struct ksmbd_work *work,
 	kvfree(xattr_list);
 
 	rsp->OutputBufferLength = cpu_to_le32(nbytes);
+
+	return 0;
 }
 
-static void get_file_internal_info(struct smb2_query_info_rsp *rsp,
-				   struct ksmbd_file *fp, void *rsp_org)
+static int get_file_internal_info(struct smb2_query_info_rsp *rsp,
+				  struct ksmbd_file *fp, void *rsp_org)
 {
 	struct smb2_file_internal_info *file_info;
 	struct kstat stat;
+	int ret;
+
+	ret = vfs_getattr(&fp->filp->f_path, &stat, STATX_BASIC_STATS,
+			  AT_STATX_SYNC_AS_STAT);
+	if (ret)
+		return ret;
 
-	generic_fillattr(file_mnt_idmap(fp->filp), STATX_BASIC_STATS,
-			 file_inode(fp->filp), &stat);
 	file_info = (struct smb2_file_internal_info *)rsp->Buffer;
 	file_info->IndexNumber = cpu_to_le64(stat.ino);
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_internal_info));
+
+	return 0;
 }
 
 static int get_file_network_open_info(struct smb2_query_info_rsp *rsp,
 				      struct ksmbd_file *fp, void *rsp_org)
 {
 	struct smb2_file_ntwrk_info *file_info;
-	struct inode *inode;
 	struct kstat stat;
 	u64 time;
+	int ret;
 
 	if (!(fp->daccess & FILE_READ_ATTRIBUTES_LE)) {
 		pr_err("no right to read the attributes : 0x%x\n",
@@ -4750,10 +4778,12 @@ static int get_file_network_open_info(struct smb2_query_info_rsp *rsp,
 		return -EACCES;
 	}
 
-	file_info = (struct smb2_file_ntwrk_info *)rsp->Buffer;
+	ret = vfs_getattr(&fp->filp->f_path, &stat, STATX_BASIC_STATS,
+			  AT_STATX_SYNC_AS_STAT);
+	if (ret)
+		return ret;
 
-	inode = file_inode(fp->filp);
-	generic_fillattr(file_mnt_idmap(fp->filp), STATX_BASIC_STATS, inode, &stat);
+	file_info = (struct smb2_file_ntwrk_info *)rsp->Buffer;
 
 	file_info->CreationTime = cpu_to_le64(fp->create_time);
 	time = ksmbd_UnixTimeToNT(stat.atime);
@@ -4763,8 +4793,7 @@ static int get_file_network_open_info(struct smb2_query_info_rsp *rsp,
 	time = ksmbd_UnixTimeToNT(stat.ctime);
 	file_info->ChangeTime = cpu_to_le64(time);
 	file_info->Attributes = fp->f_ci->m_fattr;
-	file_info->AllocationSize =
-		cpu_to_le64(inode->i_blocks << 9);
+	file_info->AllocationSize = cpu_to_le64(stat.blocks << 9);
 	file_info->EndOfFile = S_ISDIR(stat.mode) ? 0 : cpu_to_le64(stat.size);
 	file_info->Reserved = cpu_to_le32(0);
 	rsp->OutputBufferLength =
@@ -4804,14 +4833,17 @@ static void get_file_mode_info(struct smb2_query_info_rsp *rsp,
 		cpu_to_le32(sizeof(struct smb2_file_mode_info));
 }
 
-static void get_file_compression_info(struct smb2_query_info_rsp *rsp,
-				      struct ksmbd_file *fp, void *rsp_org)
+static int get_file_compression_info(struct smb2_query_info_rsp *rsp,
+				     struct ksmbd_file *fp, void *rsp_org)
 {
 	struct smb2_file_comp_info *file_info;
 	struct kstat stat;
+	int ret;
 
-	generic_fillattr(file_mnt_idmap(fp->filp), STATX_BASIC_STATS,
-			 file_inode(fp->filp), &stat);
+	ret = vfs_getattr(&fp->filp->f_path, &stat, STATX_BASIC_STATS,
+			  AT_STATX_SYNC_AS_STAT);
+	if (ret)
+		return ret;
 
 	file_info = (struct smb2_file_comp_info *)rsp->Buffer;
 	file_info->CompressedFileSize = cpu_to_le64(stat.blocks << 9);
@@ -4823,6 +4855,8 @@ static void get_file_compression_info(struct smb2_query_info_rsp *rsp,
 
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_comp_info));
+
+	return 0;
 }
 
 static int get_file_attribute_tag_info(struct smb2_query_info_rsp *rsp,
@@ -4844,7 +4878,7 @@ static int get_file_attribute_tag_info(struct smb2_query_info_rsp *rsp,
 	return 0;
 }
 
-static void find_file_posix_info(struct smb2_query_info_rsp *rsp,
+static int find_file_posix_info(struct smb2_query_info_rsp *rsp,
 				struct ksmbd_file *fp, void *rsp_org)
 {
 	struct smb311_posix_qinfo *file_info;
@@ -4852,24 +4886,31 @@ static void find_file_posix_info(struct smb2_query_info_rsp *rsp,
 	struct mnt_idmap *idmap = file_mnt_idmap(fp->filp);
 	vfsuid_t vfsuid = i_uid_into_vfsuid(idmap, inode);
 	vfsgid_t vfsgid = i_gid_into_vfsgid(idmap, inode);
+	struct kstat stat;
 	u64 time;
 	int out_buf_len = sizeof(struct smb311_posix_qinfo) + 32;
+	int ret;
+
+	ret = vfs_getattr(&fp->filp->f_path, &stat, STATX_BASIC_STATS,
+			  AT_STATX_SYNC_AS_STAT);
+	if (ret)
+		return ret;
 
 	file_info = (struct smb311_posix_qinfo *)rsp->Buffer;
 	file_info->CreationTime = cpu_to_le64(fp->create_time);
-	time = ksmbd_UnixTimeToNT(inode_get_atime(inode));
+	time = ksmbd_UnixTimeToNT(stat.atime);
 	file_info->LastAccessTime = cpu_to_le64(time);
-	time = ksmbd_UnixTimeToNT(inode_get_mtime(inode));
+	time = ksmbd_UnixTimeToNT(stat.mtime);
 	file_info->LastWriteTime = cpu_to_le64(time);
-	time = ksmbd_UnixTimeToNT(inode_get_ctime(inode));
+	time = ksmbd_UnixTimeToNT(stat.ctime);
 	file_info->ChangeTime = cpu_to_le64(time);
 	file_info->DosAttributes = fp->f_ci->m_fattr;
-	file_info->Inode = cpu_to_le64(inode->i_ino);
-	file_info->EndOfFile = cpu_to_le64(inode->i_size);
-	file_info->AllocationSize = cpu_to_le64(inode->i_blocks << 9);
-	file_info->HardLinks = cpu_to_le32(inode->i_nlink);
-	file_info->Mode = cpu_to_le32(inode->i_mode & 0777);
-	file_info->DeviceId = cpu_to_le32(inode->i_rdev);
+	file_info->Inode = cpu_to_le64(stat.ino);
+	file_info->EndOfFile = cpu_to_le64(stat.size);
+	file_info->AllocationSize = cpu_to_le64(stat.blocks << 9);
+	file_info->HardLinks = cpu_to_le32(stat.nlink);
+	file_info->Mode = cpu_to_le32(stat.mode & 0777);
+	file_info->DeviceId = cpu_to_le32(stat.rdev);
 
 	/*
 	 * Sids(32) contain two sids(Domain sid(16), UNIX group sid(16)).
@@ -4882,6 +4923,8 @@ static void find_file_posix_info(struct smb2_query_info_rsp *rsp,
 		  SIDUNIX_GROUP, (struct smb_sid *)&file_info->Sids[16]);
 
 	rsp->OutputBufferLength = cpu_to_le32(out_buf_len);
+
+	return 0;
 }
 
 static int smb2_get_info_file(struct ksmbd_work *work,
@@ -4930,7 +4973,7 @@ static int smb2_get_info_file(struct ksmbd_work *work,
 		break;
 
 	case FILE_STANDARD_INFORMATION:
-		get_file_standard_info(rsp, fp, work->response_buf);
+		rc = get_file_standard_info(rsp, fp, work->response_buf);
 		break;
 
 	case FILE_ALIGNMENT_INFORMATION:
@@ -4946,11 +4989,11 @@ static int smb2_get_info_file(struct ksmbd_work *work,
 		break;
 
 	case FILE_STREAM_INFORMATION:
-		get_file_stream_info(work, rsp, fp, work->response_buf);
+		rc = get_file_stream_info(work, rsp, fp, work->response_buf);
 		break;
 
 	case FILE_INTERNAL_INFORMATION:
-		get_file_internal_info(rsp, fp, work->response_buf);
+		rc = get_file_internal_info(rsp, fp, work->response_buf);
 		break;
 
 	case FILE_NETWORK_OPEN_INFORMATION:
@@ -4974,7 +5017,7 @@ static int smb2_get_info_file(struct ksmbd_work *work,
 		break;
 
 	case FILE_COMPRESSION_INFORMATION:
-		get_file_compression_info(rsp, fp, work->response_buf);
+		rc = get_file_compression_info(rsp, fp, work->response_buf);
 		break;
 
 	case FILE_ATTRIBUTE_TAG_INFORMATION:
@@ -4985,7 +5028,7 @@ static int smb2_get_info_file(struct ksmbd_work *work,
 			pr_err("client doesn't negotiate with SMB3.1.1 POSIX Extensions\n");
 			rc = -EOPNOTSUPP;
 		} else {
-			find_file_posix_info(rsp, fp, work->response_buf);
+			rc = find_file_posix_info(rsp, fp, work->response_buf);
 		}
 		break;
 	default:
@@ -5398,7 +5441,6 @@ int smb2_close(struct ksmbd_work *work)
 	struct smb2_close_rsp *rsp;
 	struct ksmbd_conn *conn = work->conn;
 	struct ksmbd_file *fp;
-	struct inode *inode;
 	u64 time;
 	int err = 0;
 
@@ -5453,24 +5495,33 @@ int smb2_close(struct ksmbd_work *work)
 	rsp->Reserved = 0;
 
 	if (req->Flags == SMB2_CLOSE_FLAG_POSTQUERY_ATTRIB) {
+		struct kstat stat;
+		int ret;
+
 		fp = ksmbd_lookup_fd_fast(work, volatile_id);
 		if (!fp) {
 			err = -ENOENT;
 			goto out;
 		}
 
-		inode = file_inode(fp->filp);
+		ret = vfs_getattr(&fp->filp->f_path, &stat, STATX_BASIC_STATS,
+				  AT_STATX_SYNC_AS_STAT);
+		if (ret) {
+			ksmbd_fd_put(work, fp);
+			goto out;
+		}
+
 		rsp->Flags = SMB2_CLOSE_FLAG_POSTQUERY_ATTRIB;
-		rsp->AllocationSize = S_ISDIR(inode->i_mode) ? 0 :
-			cpu_to_le64(inode->i_blocks << 9);
-		rsp->EndOfFile = cpu_to_le64(inode->i_size);
+		rsp->AllocationSize = S_ISDIR(stat.mode) ? 0 :
+			cpu_to_le64(stat.blocks << 9);
+		rsp->EndOfFile = cpu_to_le64(stat.size);
 		rsp->Attributes = fp->f_ci->m_fattr;
 		rsp->CreationTime = cpu_to_le64(fp->create_time);
-		time = ksmbd_UnixTimeToNT(inode_get_atime(inode));
+		time = ksmbd_UnixTimeToNT(stat.atime);
 		rsp->LastAccessTime = cpu_to_le64(time);
-		time = ksmbd_UnixTimeToNT(inode_get_mtime(inode));
+		time = ksmbd_UnixTimeToNT(stat.mtime);
 		rsp->LastWriteTime = cpu_to_le64(time);
-		time = ksmbd_UnixTimeToNT(inode_get_ctime(inode));
+		time = ksmbd_UnixTimeToNT(stat.ctime);
 		rsp->ChangeTime = cpu_to_le64(time);
 		ksmbd_fd_put(work, fp);
 	} else {
@@ -5759,15 +5810,21 @@ static int set_file_allocation_info(struct ksmbd_work *work,
 
 	loff_t alloc_blks;
 	struct inode *inode;
+	struct kstat stat;
 	int rc;
 
 	if (!(fp->daccess & FILE_WRITE_DATA_LE))
 		return -EACCES;
 
+	rc = vfs_getattr(&fp->filp->f_path, &stat, STATX_BASIC_STATS,
+			 AT_STATX_SYNC_AS_STAT);
+	if (rc)
+		return rc;
+
 	alloc_blks = (le64_to_cpu(file_alloc_info->AllocationSize) + 511) >> 9;
 	inode = file_inode(fp->filp);
 
-	if (alloc_blks > inode->i_blocks) {
+	if (alloc_blks > stat.blocks) {
 		smb_break_all_levII_oplock(work, fp, 1);
 		rc = vfs_fallocate(fp->filp, FALLOC_FL_KEEP_SIZE, 0,
 				   alloc_blks * 512);
@@ -5775,7 +5832,7 @@ static int set_file_allocation_info(struct ksmbd_work *work,
 			pr_err("vfs_fallocate is failed : %d\n", rc);
 			return rc;
 		}
-	} else if (alloc_blks < inode->i_blocks) {
+	} else if (alloc_blks < stat.blocks) {
 		loff_t size;
 
 		/*
@@ -5930,6 +5987,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			      struct ksmbd_share_config *share)
 {
 	unsigned int buf_len = le32_to_cpu(req->BufferLength);
+	char *buffer = (char *)req + le16_to_cpu(req->BufferOffset);
 
 	switch (req->FileInfoClass) {
 	case FILE_BASIC_INFORMATION:
@@ -5937,7 +5995,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 		if (buf_len < sizeof(struct smb2_file_basic_info))
 			return -EINVAL;
 
-		return set_file_basic_info(fp, (struct smb2_file_basic_info *)req->Buffer, share);
+		return set_file_basic_info(fp, (struct smb2_file_basic_info *)buffer, share);
 	}
 	case FILE_ALLOCATION_INFORMATION:
 	{
@@ -5945,7 +6003,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return set_file_allocation_info(work, fp,
-						(struct smb2_file_alloc_info *)req->Buffer);
+						(struct smb2_file_alloc_info *)buffer);
 	}
 	case FILE_END_OF_FILE_INFORMATION:
 	{
@@ -5953,7 +6011,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return set_end_of_file_info(work, fp,
-					    (struct smb2_file_eof_info *)req->Buffer);
+					    (struct smb2_file_eof_info *)buffer);
 	}
 	case FILE_RENAME_INFORMATION:
 	{
@@ -5961,7 +6019,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return set_rename_info(work, fp,
-				       (struct smb2_file_rename_info *)req->Buffer,
+				       (struct smb2_file_rename_info *)buffer,
 				       buf_len);
 	}
 	case FILE_LINK_INFORMATION:
@@ -5970,7 +6028,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return smb2_create_link(work, work->tcon->share_conf,
-					(struct smb2_file_link_info *)req->Buffer,
+					(struct smb2_file_link_info *)buffer,
 					buf_len, fp->filp,
 					work->conn->local_nls);
 	}
@@ -5980,7 +6038,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return set_file_disposition_info(fp,
-						 (struct smb2_file_disposition_info *)req->Buffer);
+						 (struct smb2_file_disposition_info *)buffer);
 	}
 	case FILE_FULL_EA_INFORMATION:
 	{
@@ -5993,7 +6051,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 		if (buf_len < sizeof(struct smb2_ea_info))
 			return -EINVAL;
 
-		return smb2_set_ea((struct smb2_ea_info *)req->Buffer,
+		return smb2_set_ea((struct smb2_ea_info *)buffer,
 				   buf_len, &fp->filp->f_path, true);
 	}
 	case FILE_POSITION_INFORMATION:
@@ -6001,14 +6059,14 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 		if (buf_len < sizeof(struct smb2_file_pos_info))
 			return -EINVAL;
 
-		return set_file_position_info(fp, (struct smb2_file_pos_info *)req->Buffer);
+		return set_file_position_info(fp, (struct smb2_file_pos_info *)buffer);
 	}
 	case FILE_MODE_INFORMATION:
 	{
 		if (buf_len < sizeof(struct smb2_file_mode_info))
 			return -EINVAL;
 
-		return set_file_mode_info(fp, (struct smb2_file_mode_info *)req->Buffer);
+		return set_file_mode_info(fp, (struct smb2_file_mode_info *)buffer);
 	}
 	}
 
@@ -6089,7 +6147,7 @@ int smb2_set_info(struct ksmbd_work *work)
 		}
 		rc = smb2_set_info_sec(fp,
 				       le32_to_cpu(req->AdditionalInformation),
-				       req->Buffer,
+				       (char *)req + le16_to_cpu(req->BufferOffset),
 				       le32_to_cpu(req->BufferLength));
 		ksmbd_revert_fsids(work);
 		break;
@@ -7535,7 +7593,7 @@ static int fsctl_pipe_transceive(struct ksmbd_work *work, u64 id,
 				 struct smb2_ioctl_rsp *rsp)
 {
 	struct ksmbd_rpc_command *rpc_resp;
-	char *data_buf = (char *)&req->Buffer[0];
+	char *data_buf = (char *)req + le32_to_cpu(req->InputOffset);
 	int nbytes = 0;
 
 	rpc_resp = ksmbd_rpc_ioctl(work->sess, id, data_buf,
@@ -7648,6 +7706,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 	u64 id = KSMBD_NO_FID;
 	struct ksmbd_conn *conn = work->conn;
 	int ret = 0;
+	char *buffer;
 
 	if (work->next_smb2_rcv_hdr_off) {
 		req = ksmbd_req_buf_next(work);
@@ -7670,6 +7729,8 @@ int smb2_ioctl(struct ksmbd_work *work)
 		goto out;
 	}
 
+	buffer = (char *)req + le32_to_cpu(req->InputOffset);
+
 	cnt_code = le32_to_cpu(req->CtlCode);
 	ret = smb2_calc_max_out_buf_len(work, 48,
 					le32_to_cpu(req->MaxOutputResponse));
@@ -7727,7 +7788,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 		}
 
 		ret = fsctl_validate_negotiate_info(conn,
-			(struct validate_negotiate_info_req *)&req->Buffer[0],
+			(struct validate_negotiate_info_req *)buffer,
 			(struct validate_negotiate_info_rsp *)&rsp->Buffer[0],
 			in_buf_len);
 		if (ret < 0)
@@ -7780,7 +7841,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 		rsp->VolatileFileId = req->VolatileFileId;
 		rsp->PersistentFileId = req->PersistentFileId;
 		fsctl_copychunk(work,
-				(struct copychunk_ioctl_req *)&req->Buffer[0],
+				(struct copychunk_ioctl_req *)buffer,
 				le32_to_cpu(req->CtlCode),
 				le32_to_cpu(req->InputCount),
 				req->VolatileFileId,
@@ -7793,8 +7854,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 			goto out;
 		}
 
-		ret = fsctl_set_sparse(work, id,
-				       (struct file_sparse *)&req->Buffer[0]);
+		ret = fsctl_set_sparse(work, id, (struct file_sparse *)buffer);
 		if (ret < 0)
 			goto out;
 		break;
@@ -7817,7 +7877,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 		}
 
 		zero_data =
-			(struct file_zero_data_information *)&req->Buffer[0];
+			(struct file_zero_data_information *)buffer;
 
 		off = le64_to_cpu(zero_data->FileOffset);
 		bfz = le64_to_cpu(zero_data->BeyondFinalZero);
@@ -7848,7 +7908,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 		}
 
 		ret = fsctl_query_allocated_ranges(work, id,
-			(struct file_allocated_range_buffer *)&req->Buffer[0],
+			(struct file_allocated_range_buffer *)buffer,
 			(struct file_allocated_range_buffer *)&rsp->Buffer[0],
 			out_buf_len /
 			sizeof(struct file_allocated_range_buffer), &nbytes);
@@ -7892,7 +7952,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 			goto out;
 		}
 
-		dup_ext = (struct duplicate_extents_to_file *)&req->Buffer[0];
+		dup_ext = (struct duplicate_extents_to_file *)buffer;
 
 		fp_in = ksmbd_lookup_fd_slow(work, dup_ext->VolatileFileHandle,
 					     dup_ext->PersistentFileHandle);
diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index 7c98bf699772..fcaf373cc008 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -457,10 +457,13 @@ int ksmbd_populate_dot_dotdot_entries(struct ksmbd_work *work, int info_level,
 			}
 
 			ksmbd_kstat.kstat = &kstat;
-			ksmbd_vfs_fill_dentry_attrs(work,
-						    idmap,
-						    dentry,
-						    &ksmbd_kstat);
+			rc = ksmbd_vfs_fill_dentry_attrs(work,
+							 idmap,
+							 dentry,
+							 &ksmbd_kstat);
+			if (rc)
+				break;
+
 			rc = fn(conn, info_level, d_info, &ksmbd_kstat);
 			if (rc)
 				break;
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 4277750a6da1..a8936aba7710 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1669,11 +1669,19 @@ int ksmbd_vfs_fill_dentry_attrs(struct ksmbd_work *work,
 				struct dentry *dentry,
 				struct ksmbd_kstat *ksmbd_kstat)
 {
+	struct ksmbd_share_config *share_conf = work->tcon->share_conf;
 	u64 time;
 	int rc;
+	struct path path = {
+		.mnt = share_conf->vfs_path.mnt,
+		.dentry = dentry,
+	};
 
-	generic_fillattr(idmap, STATX_BASIC_STATS, d_inode(dentry),
-			 ksmbd_kstat->kstat);
+	rc = vfs_getattr(&path, ksmbd_kstat->kstat,
+			 STATX_BASIC_STATS | STATX_BTIME,
+			 AT_STATX_SYNC_AS_STAT);
+	if (rc)
+		return rc;
 
 	time = ksmbd_UnixTimeToNT(ksmbd_kstat->kstat->ctime);
 	ksmbd_kstat->create_time = time;
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 2d2b39f843ce..abf4a77584cf 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -261,9 +261,6 @@ static int write_begin_slow(struct address_space *mapping,
 				return err;
 			}
 		}
-
-		SetPageUptodate(page);
-		ClearPageError(page);
 	}
 
 	if (PagePrivate(page))
@@ -462,9 +459,6 @@ static int ubifs_write_begin(struct file *file, struct address_space *mapping,
 				return err;
 			}
 		}
-
-		SetPageUptodate(page);
-		ClearPageError(page);
 	}
 
 	err = allocate_budget(c, page, ui, appending);
@@ -474,10 +468,8 @@ static int ubifs_write_begin(struct file *file, struct address_space *mapping,
 		 * If we skipped reading the page because we were going to
 		 * write all of it, then it is not up to date.
 		 */
-		if (skipped_read) {
+		if (skipped_read)
 			ClearPageChecked(page);
-			ClearPageUptodate(page);
-		}
 		/*
 		 * Budgeting failed which means it would have to force
 		 * write-back but didn't, because we set the @fast flag in the
@@ -568,6 +560,9 @@ static int ubifs_write_end(struct file *file, struct address_space *mapping,
 		goto out;
 	}
 
+	if (len == PAGE_SIZE)
+		SetPageUptodate(page);
+
 	if (!PagePrivate(page)) {
 		attach_page_private(page, (void *)1);
 		atomic_long_inc(&c->dirty_pg_cnt);
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 9ef461aa9b9e..99aea536013e 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -557,6 +557,37 @@ struct drm_bridge_funcs {
 	int (*get_modes)(struct drm_bridge *bridge,
 			 struct drm_connector *connector);
 
+	/**
+	 * @edid_read:
+	 *
+	 * Read the EDID data of the connected display.
+	 *
+	 * The @edid_read callback is the preferred way of reporting mode
+	 * information for a display connected to the bridge output. Bridges
+	 * that support reading EDID shall implement this callback and leave
+	 * the @get_modes callback unimplemented.
+	 *
+	 * The caller of this operation shall first verify the output
+	 * connection status and refrain from reading EDID from a disconnected
+	 * output.
+	 *
+	 * This callback is optional. Bridges that implement it shall set the
+	 * DRM_BRIDGE_OP_EDID flag in their &drm_bridge->ops.
+	 *
+	 * The connector parameter shall be used for the sole purpose of EDID
+	 * retrieval, and shall not be stored internally by bridge drivers for
+	 * future usage.
+	 *
+	 * RETURNS:
+	 *
+	 * An edid structure newly allocated with drm_edid_alloc() or returned
+	 * from drm_edid_read() family of functions on success, or NULL
+	 * otherwise. The caller is responsible for freeing the returned edid
+	 * structure with drm_edid_free().
+	 */
+	const struct drm_edid *(*edid_read)(struct drm_bridge *bridge,
+					    struct drm_connector *connector);
+
 	/**
 	 * @get_edid:
 	 *
@@ -888,6 +919,8 @@ drm_atomic_helper_bridge_propagate_bus_fmt(struct drm_bridge *bridge,
 enum drm_connector_status drm_bridge_detect(struct drm_bridge *bridge);
 int drm_bridge_get_modes(struct drm_bridge *bridge,
 			 struct drm_connector *connector);
+const struct drm_edid *drm_bridge_edid_read(struct drm_bridge *bridge,
+					    struct drm_connector *connector);
 struct edid *drm_bridge_get_edid(struct drm_bridge *bridge,
 				 struct drm_connector *connector);
 void drm_bridge_hpd_enable(struct drm_bridge *bridge,
diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
index e3c3ac615909..159213786e6e 100644
--- a/include/drm/drm_modeset_helper_vtables.h
+++ b/include/drm/drm_modeset_helper_vtables.h
@@ -898,7 +898,8 @@ struct drm_connector_helper_funcs {
 	 *
 	 * RETURNS:
 	 *
-	 * The number of modes added by calling drm_mode_probed_add().
+	 * The number of modes added by calling drm_mode_probed_add(). Return 0
+	 * on failures (no modes) instead of negative error codes.
 	 */
 	int (*get_modes)(struct drm_connector *connector);
 
diff --git a/include/drm/ttm/ttm_tt.h b/include/drm/ttm/ttm_tt.h
index a4eff85b1f44..2b9d856ff388 100644
--- a/include/drm/ttm/ttm_tt.h
+++ b/include/drm/ttm/ttm_tt.h
@@ -79,6 +79,12 @@ struct ttm_tt {
 	 *   page_flags = TTM_TT_FLAG_EXTERNAL |
 	 *		  TTM_TT_FLAG_EXTERNAL_MAPPABLE;
 	 *
+	 * TTM_TT_FLAG_DECRYPTED: The mapped ttm pages should be marked as
+	 * not encrypted. The framework will try to match what the dma layer
+	 * is doing, but note that it is a little fragile because ttm page
+	 * fault handling abuses the DMA api a bit and dma_map_attrs can't be
+	 * used to assure pgprot always matches.
+	 *
 	 * TTM_TT_FLAG_PRIV_POPULATED: TTM internal only. DO NOT USE. This is
 	 * set by TTM after ttm_tt_populate() has successfully returned, and is
 	 * then unset when TTM calls ttm_tt_unpopulate().
@@ -87,8 +93,9 @@ struct ttm_tt {
 #define TTM_TT_FLAG_ZERO_ALLOC		BIT(1)
 #define TTM_TT_FLAG_EXTERNAL		BIT(2)
 #define TTM_TT_FLAG_EXTERNAL_MAPPABLE	BIT(3)
+#define TTM_TT_FLAG_DECRYPTED		BIT(4)
 
-#define TTM_TT_FLAG_PRIV_POPULATED	BIT(4)
+#define TTM_TT_FLAG_PRIV_POPULATED	BIT(5)
 	uint32_t page_flags;
 	/** @num_pages: Number of pages in the page array. */
 	uint32_t num_pages;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 1c5ca92a0555..90f8bd1736a2 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1021,6 +1021,18 @@ static inline int cpufreq_table_find_index_c(struct cpufreq_policy *policy,
 						   efficiencies);
 }
 
+static inline bool cpufreq_is_in_limits(struct cpufreq_policy *policy, int idx)
+{
+	unsigned int freq;
+
+	if (idx < 0)
+		return false;
+
+	freq = policy->freq_table[idx].frequency;
+
+	return freq == clamp_val(freq, policy->min, policy->max);
+}
+
 static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
 						 unsigned int target_freq,
 						 unsigned int relation)
@@ -1054,7 +1066,8 @@ static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
 		return 0;
 	}
 
-	if (idx < 0 && efficiencies) {
+	/* Limit frequency index to honor policy->min/max */
+	if (!cpufreq_is_in_limits(policy, idx) && efficiencies) {
 		efficiencies = false;
 		goto retry;
 	}
diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index b9d83652c097..562089431551 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -35,7 +35,7 @@ void eventfd_ctx_put(struct eventfd_ctx *ctx);
 struct file *eventfd_fget(int fd);
 struct eventfd_ctx *eventfd_ctx_fdget(int fd);
 struct eventfd_ctx *eventfd_ctx_fileget(struct file *file);
-__u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n);
+__u64 eventfd_signal(struct eventfd_ctx *ctx);
 __u64 eventfd_signal_mask(struct eventfd_ctx *ctx, __u64 n, __poll_t mask);
 int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx, wait_queue_entry_t *wait,
 				  __u64 *cnt);
@@ -58,7 +58,7 @@ static inline struct eventfd_ctx *eventfd_ctx_fdget(int fd)
 	return ERR_PTR(-ENOSYS);
 }
 
-static inline int eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
+static inline int eventfd_signal(struct eventfd_ctx *ctx)
 {
 	return -ENOSYS;
 }
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index de292a007138..e2a916cf29c4 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -353,6 +353,15 @@ static inline bool gfp_has_io_fs(gfp_t gfp)
 	return (gfp & (__GFP_IO | __GFP_FS)) == (__GFP_IO | __GFP_FS);
 }
 
+/*
+ * Check if the gfp flags allow compaction - GFP_NOIO is a really
+ * tricky context because the migration might require IO.
+ */
+static inline bool gfp_compaction_allowed(gfp_t gfp_mask)
+{
+	return IS_ENABLED(CONFIG_COMPACTION) && (gfp_mask & __GFP_IO);
+}
+
 extern gfp_t vma_thp_gfp_mask(struct vm_area_struct *vma);
 
 #ifdef CONFIG_CONTIG_ALLOC
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 2b00faf98017..6ef0557b4bff 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -164,8 +164,28 @@ struct hv_ring_buffer {
 	u8 buffer[];
 } __packed;
 
+
+/*
+ * If the requested ring buffer size is at least 8 times the size of the
+ * header, steal space from the ring buffer for the header. Otherwise, add
+ * space for the header so that is doesn't take too much of the ring buffer
+ * space.
+ *
+ * The factor of 8 is somewhat arbitrary. The goal is to prevent adding a
+ * relatively small header (4 Kbytes on x86) to a large-ish power-of-2 ring
+ * buffer size (such as 128 Kbytes) and so end up making a nearly twice as
+ * large allocation that will be almost half wasted. As a contrasting example,
+ * on ARM64 with 64 Kbyte page size, we don't want to take 64 Kbytes for the
+ * header from a 128 Kbyte allocation, leaving only 64 Kbytes for the ring.
+ * In this latter case, we must add 64 Kbytes for the header and not worry
+ * about what's wasted.
+ */
+#define VMBUS_HEADER_ADJ(payload_sz) \
+	((payload_sz) >=  8 * sizeof(struct hv_ring_buffer) ? \
+	0 : sizeof(struct hv_ring_buffer))
+
 /* Calculate the proper size of a ringbuffer, it must be page-aligned */
-#define VMBUS_RING_SIZE(payload_sz) PAGE_ALIGN(sizeof(struct hv_ring_buffer) + \
+#define VMBUS_RING_SIZE(payload_sz) PAGE_ALIGN(VMBUS_HEADER_ADJ(payload_sz) + \
 					       (payload_sz))
 
 struct hv_ring_buffer_info {
diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index 33f21bd85dbf..f3196f82fd8a 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -178,6 +178,12 @@ struct rapl_package {
 	struct rapl_if_priv *priv;
 };
 
+struct rapl_package *rapl_find_package_domain_cpuslocked(int id, struct rapl_if_priv *priv,
+						       bool id_is_cpu);
+struct rapl_package *rapl_add_package_cpuslocked(int id, struct rapl_if_priv *priv,
+						 bool id_is_cpu);
+void rapl_remove_package_cpuslocked(struct rapl_package *rp);
+
 struct rapl_package *rapl_find_package_domain(int id, struct rapl_if_priv *priv, bool id_is_cpu);
 struct rapl_package *rapl_add_package(int id, struct rapl_if_priv *priv, bool id_is_cpu);
 void rapl_remove_package(struct rapl_package *rp);
diff --git a/include/linux/intel_tcc.h b/include/linux/intel_tcc.h
index f422612c28d6..8ff8eabb4a98 100644
--- a/include/linux/intel_tcc.h
+++ b/include/linux/intel_tcc.h
@@ -13,6 +13,6 @@
 int intel_tcc_get_tjmax(int cpu);
 int intel_tcc_get_offset(int cpu);
 int intel_tcc_set_offset(int cpu, int offset);
-int intel_tcc_get_temp(int cpu, bool pkg);
+int intel_tcc_get_temp(int cpu, int *temp, bool pkg);
 
 #endif /* __INTEL_TCC_H__ */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 1dbb14daccfa..1d2afcd47523 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -107,6 +107,7 @@ enum {
 
 	ATA_DFLAG_NCQ_PRIO_ENABLED = (1 << 20), /* Priority cmds sent to dev */
 	ATA_DFLAG_CDL_ENABLED	= (1 << 21), /* cmd duration limits is enabled */
+	ATA_DFLAG_RESUMING	= (1 << 22),  /* Device is resuming */
 	ATA_DFLAG_DETACH	= (1 << 24),
 	ATA_DFLAG_DETACHED	= (1 << 25),
 	ATA_DFLAG_DA		= (1 << 26), /* device supports Device Attention */
diff --git a/include/linux/mman.h b/include/linux/mman.h
index dc7048824be8..bcb201ab7a41 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -162,6 +162,14 @@ calc_vm_flag_bits(unsigned long flags)
 
 unsigned long vm_commit_limit(void);
 
+#ifndef arch_memory_deny_write_exec_supported
+static inline bool arch_memory_deny_write_exec_supported(void)
+{
+	return true;
+}
+#define arch_memory_deny_write_exec_supported arch_memory_deny_write_exec_supported
+#endif
+
 /*
  * Denies creating a writable executable mapping or gaining executable permissions.
  *
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index badb4c1ac079..5c19ead60499 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -169,7 +169,7 @@
 struct spinand_op;
 struct spinand_device;
 
-#define SPINAND_MAX_ID_LEN	4
+#define SPINAND_MAX_ID_LEN	5
 /*
  * For erase, write and read operation, we got the following timings :
  * tBERS (erase) 1ms to 4ms
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 279262057a92..832b7e354b4e 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -612,6 +612,7 @@ int nfs_wb_folio_cancel(struct inode *inode, struct folio *folio);
 extern int  nfs_commit_inode(struct inode *, int);
 extern struct nfs_commit_data *nfs_commitdata_alloc(void);
 extern void nfs_commit_free(struct nfs_commit_data *data);
+void nfs_commit_begin(struct nfs_mds_commit_info *cinfo);
 bool nfs_commit_end(struct nfs_mds_commit_info *cinfo);
 
 static inline bool nfs_have_writebacks(const struct inode *inode)
diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
index 3921fbed0b28..51421fdbb0ba 100644
--- a/include/linux/oid_registry.h
+++ b/include/linux/oid_registry.h
@@ -17,10 +17,12 @@
  *	  build_OID_registry.pl to generate the data for look_up_OID().
  */
 enum OID {
+	OID_id_dsa_with_sha1,		/* 1.2.840.10030.4.3 */
 	OID_id_dsa,			/* 1.2.840.10040.4.1 */
 	OID_id_ecPublicKey,		/* 1.2.840.10045.2.1 */
 	OID_id_prime192v1,		/* 1.2.840.10045.3.1.1 */
 	OID_id_prime256v1,		/* 1.2.840.10045.3.1.7 */
+	OID_id_ecdsa_with_sha1,		/* 1.2.840.10045.4.1 */
 	OID_id_ecdsa_with_sha224,	/* 1.2.840.10045.4.3.1 */
 	OID_id_ecdsa_with_sha256,	/* 1.2.840.10045.4.3.2 */
 	OID_id_ecdsa_with_sha384,	/* 1.2.840.10045.4.3.3 */
@@ -28,6 +30,7 @@ enum OID {
 
 	/* PKCS#1 {iso(1) member-body(2) us(840) rsadsi(113549) pkcs(1) pkcs-1(1)} */
 	OID_rsaEncryption,		/* 1.2.840.113549.1.1.1 */
+	OID_sha1WithRSAEncryption,	/* 1.2.840.113549.1.1.5 */
 	OID_sha256WithRSAEncryption,	/* 1.2.840.113549.1.1.11 */
 	OID_sha384WithRSAEncryption,	/* 1.2.840.113549.1.1.12 */
 	OID_sha512WithRSAEncryption,	/* 1.2.840.113549.1.1.13 */
@@ -64,6 +67,7 @@ enum OID {
 	OID_PKU2U,			/* 1.3.5.1.5.2.7 */
 	OID_Scram,			/* 1.3.6.1.5.5.14 */
 	OID_certAuthInfoAccess,		/* 1.3.6.1.5.5.7.1.1 */
+	OID_sha1,			/* 1.3.14.3.2.26 */
 	OID_id_ansip384r1,		/* 1.3.132.0.34 */
 	OID_sha256,			/* 2.16.840.1.101.3.4.2.1 */
 	OID_sha384,			/* 2.16.840.1.101.3.4.2.2 */
diff --git a/include/linux/phy/tegra/xusb.h b/include/linux/phy/tegra/xusb.h
index 70998e6dd6fd..6ca51e0080ec 100644
--- a/include/linux/phy/tegra/xusb.h
+++ b/include/linux/phy/tegra/xusb.h
@@ -26,6 +26,7 @@ void tegra_phy_xusb_utmi_pad_power_down(struct phy *phy);
 int tegra_phy_xusb_utmi_port_reset(struct phy *phy);
 int tegra_xusb_padctl_get_usb3_companion(struct tegra_xusb_padctl *padctl,
 					 unsigned int port);
+int tegra_xusb_padctl_get_port_number(struct phy *phy);
 int tegra_xusb_padctl_enable_phy_sleepwalk(struct tegra_xusb_padctl *padctl, struct phy *phy,
 					   enum usb_device_speed speed);
 int tegra_xusb_padctl_disable_phy_sleepwalk(struct tegra_xusb_padctl *padctl, struct phy *phy);
diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 782e14f62201..ded528d23f85 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -98,6 +98,7 @@ __ring_buffer_alloc(unsigned long size, unsigned flags, struct lock_class_key *k
 	__ring_buffer_alloc((size), (flags), &__key);	\
 })
 
+typedef bool (*ring_buffer_cond_fn)(void *data);
 int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full);
 __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 			  struct file *filp, poll_table *poll_table, int full);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index f43aca7f3b01..678409c47b88 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -786,7 +786,8 @@ enum UART_TX_FLAGS {
 	if (pending < WAKEUP_CHARS) {					      \
 		uart_write_wakeup(__port);				      \
 									      \
-		if (!((flags) & UART_TX_NOSTOP) && pending == 0)	      \
+		if (!((flags) & UART_TX_NOSTOP) && pending == 0 &&	      \
+		    __port->ops->tx_empty(__port))			      \
 			__port->ops->stop_tx(__port);			      \
 	}								      \
 									      \
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 763e9264402f..bd06942757f5 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3438,6 +3438,16 @@ static inline void skb_frag_ref(struct sk_buff *skb, int f)
 
 bool napi_pp_put_page(struct page *page, bool napi_safe);
 
+static inline void
+skb_page_unref(const struct sk_buff *skb, struct page *page, bool napi_safe)
+{
+#ifdef CONFIG_PAGE_POOL
+	if (skb->pp_recycle && napi_pp_put_page(page, napi_safe))
+		return;
+#endif
+	put_page(page);
+}
+
 static inline void
 napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
 {
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index a65b2513f8cd..5ac5f182ce0b 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -349,6 +349,7 @@ struct virqfd {
 	wait_queue_entry_t		wait;
 	poll_table		pt;
 	struct work_struct	shutdown;
+	struct work_struct	flush_inject;
 	struct virqfd		**pvirqfd;
 };
 
@@ -356,5 +357,6 @@ int vfio_virqfd_enable(void *opaque, int (*handler)(void *, void *),
 		       void (*thread)(void *, void *), void *data,
 		       struct virqfd **pvirqfd, int fd);
 void vfio_virqfd_disable(struct virqfd **pvirqfd);
+void vfio_virqfd_flush_thread(struct virqfd **pvirqfd);
 
 #endif /* VFIO_H */
diff --git a/include/media/media-entity.h b/include/media/media-entity.h
index 2b6cd343ee9e..4d95893c8984 100644
--- a/include/media/media-entity.h
+++ b/include/media/media-entity.h
@@ -225,6 +225,7 @@ enum media_pad_signal_type {
  * @graph_obj:	Embedded structure containing the media object common data
  * @entity:	Entity this pad belongs to
  * @index:	Pad index in the entity pads array, numbered from 0 to n
+ * @num_links:	Number of links connected to this pad
  * @sig_type:	Type of the signal inside a media pad
  * @flags:	Pad flags, as defined in
  *		:ref:`include/uapi/linux/media.h <media_header>`
@@ -236,6 +237,7 @@ struct media_pad {
 	struct media_gobj graph_obj;	/* must be first field in struct */
 	struct media_entity *entity;
 	u16 index;
+	u16 num_links;
 	enum media_pad_signal_type sig_type;
 	unsigned long flags;
 
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 8f2c48761833..e90596e21cfc 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4914,6 +4914,7 @@ struct cfg80211_ops {
  *	NL80211_REGDOM_SET_BY_DRIVER.
  * @WIPHY_FLAG_CHANNEL_CHANGE_ON_BEACON: reg_call_notifier() is called if driver
  *	set this flag to update channels on beacon hints.
+ * @WIPHY_FLAG_DISABLE_WEXT: disable wireless extensions for this device
  */
 enum wiphy_flags {
 	WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK		= BIT(0),
@@ -4925,6 +4926,7 @@ enum wiphy_flags {
 	WIPHY_FLAG_4ADDR_STATION		= BIT(6),
 	WIPHY_FLAG_CONTROL_PORT_PROTOCOL	= BIT(7),
 	WIPHY_FLAG_IBSS_RSN			= BIT(8),
+	WIPHY_FLAG_DISABLE_WEXT			= BIT(9),
 	WIPHY_FLAG_MESH_AUTH			= BIT(10),
 	WIPHY_FLAG_SUPPORTS_EXT_KCK_32          = BIT(11),
 	/* use hole at 12 */
diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index f79ce133e51a..519d23941b54 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -378,6 +378,7 @@ struct ieee802154_llsec_key {
 
 struct ieee802154_llsec_key_entry {
 	struct list_head list;
+	struct rcu_head rcu;
 
 	struct ieee802154_llsec_key_id id;
 	struct ieee802154_llsec_key *key;
diff --git a/include/scsi/scsi_driver.h b/include/scsi/scsi_driver.h
index 4ce1988b2ba0..f40915d2ecee 100644
--- a/include/scsi/scsi_driver.h
+++ b/include/scsi/scsi_driver.h
@@ -12,6 +12,7 @@ struct request;
 struct scsi_driver {
 	struct device_driver	gendrv;
 
+	int (*resume)(struct device *);
 	void (*rescan)(struct device *);
 	blk_status_t (*init_command)(struct scsi_cmnd *);
 	void (*uninit_command)(struct scsi_cmnd *);
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 3b907fc2ef08..510f594b0636 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -767,6 +767,7 @@ scsi_template_proc_dir(const struct scsi_host_template *sht);
 #define scsi_template_proc_dir(sht) NULL
 #endif
 extern void scsi_scan_host(struct Scsi_Host *);
+extern int scsi_resume_device(struct scsi_device *sdev);
 extern int scsi_rescan_device(struct scsi_device *sdev);
 extern void scsi_remove_host(struct Scsi_Host *);
 extern struct Scsi_Host *scsi_host_get(struct Scsi_Host *);
diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index 8881aea60f6f..2445f365bce7 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -52,7 +52,7 @@
  * rest are per-device feature bits.
  */
 #define VIRTIO_TRANSPORT_F_START	28
-#define VIRTIO_TRANSPORT_F_END		41
+#define VIRTIO_TRANSPORT_F_END		42
 
 #ifndef VIRTIO_CONFIG_NO_LEGACY
 /* Do we get callbacks when the ring is completely used, even if we've
@@ -114,4 +114,10 @@
  * This feature indicates that the driver can reset a queue individually.
  */
 #define VIRTIO_F_RING_RESET		40
+
+/*
+ * This feature indicates that the device support administration virtqueues.
+ */
+#define VIRTIO_F_ADMIN_VQ		41
+
 #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
diff --git a/init/Kconfig b/init/Kconfig
index bfde8189c2be..e4ff62f58340 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -876,14 +876,14 @@ config CC_IMPLICIT_FALLTHROUGH
 	default "-Wimplicit-fallthrough=5" if CC_IS_GCC && $(cc-option,-Wimplicit-fallthrough=5)
 	default "-Wimplicit-fallthrough" if CC_IS_CLANG && $(cc-option,-Wunreachable-code-fallthrough)
 
-# Currently, disable gcc-11+ array-bounds globally.
+# Currently, disable gcc-10+ array-bounds globally.
 # It's still broken in gcc-13, so no upper bound yet.
-config GCC11_NO_ARRAY_BOUNDS
+config GCC10_NO_ARRAY_BOUNDS
 	def_bool y
 
 config CC_NO_ARRAY_BOUNDS
 	bool
-	default y if CC_IS_GCC && GCC_VERSION >= 110000 && GCC11_NO_ARRAY_BOUNDS
+	default y if CC_IS_GCC && GCC_VERSION >= 100000 && GCC10_NO_ARRAY_BOUNDS
 
 #
 # For architectures that know their GCC __int128 support is sound
diff --git a/init/initramfs.c b/init/initramfs.c
index 8d0fd946cdd2..efc477b905a4 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -673,7 +673,7 @@ static void __init populate_initrd_image(char *err)
 
 	printk(KERN_INFO "rootfs image is not initramfs (%s); looks like an initrd\n",
 			err);
-	file = filp_open("/initrd.image", O_WRONLY | O_CREAT, 0700);
+	file = filp_open("/initrd.image", O_WRONLY|O_CREAT|O_LARGEFILE, 0700);
 	if (IS_ERR(file))
 		return;
 
diff --git a/io_uring/futex.c b/io_uring/futex.c
index 3c3575303c3d..792a03df58de 100644
--- a/io_uring/futex.c
+++ b/io_uring/futex.c
@@ -159,6 +159,7 @@ bool io_futex_remove_all(struct io_ring_ctx *ctx, struct task_struct *task,
 	hlist_for_each_entry_safe(req, tmp, &ctx->futex_list, hash_node) {
 		if (!io_match_task_safe(req, task, cancel_all))
 			continue;
+		hlist_del_init(&req->hash_node);
 		__io_futex_cancel(ctx, req);
 		found = true;
 	}
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 45d6e440bdc0..13a9d9fcd2ec 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2757,14 +2757,15 @@ static void io_rings_free(struct io_ring_ctx *ctx)
 	if (!(ctx->flags & IORING_SETUP_NO_MMAP)) {
 		io_mem_free(ctx->rings);
 		io_mem_free(ctx->sq_sqes);
-		ctx->rings = NULL;
-		ctx->sq_sqes = NULL;
 	} else {
 		io_pages_free(&ctx->ring_pages, ctx->n_ring_pages);
 		ctx->n_ring_pages = 0;
 		io_pages_free(&ctx->sqe_pages, ctx->n_sqe_pages);
 		ctx->n_sqe_pages = 0;
 	}
+
+	ctx->rings = NULL;
+	ctx->sq_sqes = NULL;
 }
 
 void *io_mem_alloc(size_t size)
diff --git a/io_uring/net.c b/io_uring/net.c
index 4aaeada03f1e..5a4001139e28 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -87,7 +87,7 @@ static inline bool io_check_multishot(struct io_kiocb *req,
 	 * generic paths but multipoll may decide to post extra cqes.
 	 */
 	return !(issue_flags & IO_URING_F_IOWQ) ||
-		!(issue_flags & IO_URING_F_MULTISHOT) ||
+		!(req->flags & REQ_F_APOLL_MULTISHOT) ||
 		!req->ctx->task_complete;
 }
 
@@ -915,7 +915,8 @@ int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags)
 			kfree(kmsg->free_iov);
 		io_netmsg_recycle(req, issue_flags);
 		req->flags &= ~REQ_F_NEED_CLEANUP;
-	}
+	} else if (ret == -EAGAIN)
+		return io_setup_async_msg(req, kmsg, issue_flags);
 
 	return ret;
 }
diff --git a/io_uring/poll.c b/io_uring/poll.c
index 58b7556f621e..c6f4789623cb 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -539,14 +539,6 @@ static void __io_queue_proc(struct io_poll *poll, struct io_poll_table *pt,
 	poll->wait.private = (void *) wqe_private;
 
 	if (poll->events & EPOLLEXCLUSIVE) {
-		/*
-		 * Exclusive waits may only wake a limited amount of entries
-		 * rather than all of them, this may interfere with lazy
-		 * wake if someone does wait(events > 1). Ensure we don't do
-		 * lazy wake for those, as we need to process each one as they
-		 * come in.
-		 */
-		req->flags |= REQ_F_POLL_NO_LAZY;
 		add_wait_queue_exclusive(head, &poll->wait);
 	} else {
 		add_wait_queue(head, &poll->wait);
@@ -618,6 +610,17 @@ static int __io_arm_poll_handler(struct io_kiocb *req,
 	if (issue_flags & IO_URING_F_UNLOCKED)
 		req->flags &= ~REQ_F_HASH_LOCKED;
 
+
+	/*
+	 * Exclusive waits may only wake a limited amount of entries
+	 * rather than all of them, this may interfere with lazy
+	 * wake if someone does wait(events > 1). Ensure we don't do
+	 * lazy wake for those, as we need to process each one as they
+	 * come in.
+	 */
+	if (poll->events & EPOLLEXCLUSIVE)
+		req->flags |= REQ_F_POLL_NO_LAZY;
+
 	mask = vfs_poll(req->file, &ipt->pt) & poll->events;
 
 	if (unlikely(ipt->error || !ipt->nr_entries)) {
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 9394bf83e835..70c5beb05d4e 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -926,6 +926,8 @@ int io_read_mshot(struct io_kiocb *req, unsigned int issue_flags)
 	 */
 	if (!file_can_poll(req->file))
 		return -EBADFD;
+	if (issue_flags & IO_URING_F_IOWQ)
+		return -EAGAIN;
 
 	ret = __io_read(req, issue_flags);
 
@@ -940,6 +942,8 @@ int io_read_mshot(struct io_kiocb *req, unsigned int issue_flags)
 		 */
 		if (io_kbuf_recycle(req, issue_flags))
 			rw->len = 0;
+		if (issue_flags & IO_URING_F_MULTISHOT)
+			return IOU_ISSUE_SKIP_COMPLETE;
 		return -EAGAIN;
 	}
 
diff --git a/io_uring/waitid.c b/io_uring/waitid.c
index 6f851978606d..77d340666cb9 100644
--- a/io_uring/waitid.c
+++ b/io_uring/waitid.c
@@ -125,12 +125,6 @@ static void io_waitid_complete(struct io_kiocb *req, int ret)
 
 	lockdep_assert_held(&req->ctx->uring_lock);
 
-	/*
-	 * Did cancel find it meanwhile?
-	 */
-	if (hlist_unhashed(&req->hash_node))
-		return;
-
 	hlist_del_init(&req->hash_node);
 
 	ret = io_waitid_finish(req, ret);
@@ -202,6 +196,7 @@ bool io_waitid_remove_all(struct io_ring_ctx *ctx, struct task_struct *task,
 	hlist_for_each_entry_safe(req, tmp, &ctx->waitid_list, hash_node) {
 		if (!io_match_task_safe(req, task, cancel_all))
 			continue;
+		hlist_del_init(&req->hash_node);
 		__io_waitid_cancel(ctx, req);
 		found = true;
 	}
diff --git a/kernel/bounds.c b/kernel/bounds.c
index b529182e8b04..c5a9fcd2d622 100644
--- a/kernel/bounds.c
+++ b/kernel/bounds.c
@@ -19,7 +19,7 @@ int main(void)
 	DEFINE(NR_PAGEFLAGS, __NR_PAGEFLAGS);
 	DEFINE(MAX_NR_ZONES, __MAX_NR_ZONES);
 #ifdef CONFIG_SMP
-	DEFINE(NR_CPUS_BITS, ilog2(CONFIG_NR_CPUS));
+	DEFINE(NR_CPUS_BITS, bits_per(CONFIG_NR_CPUS));
 #endif
 	DEFINE(SPINLOCK_SIZE, sizeof(spinlock_t));
 #ifdef CONFIG_LRU_GEN
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 615daaf87f1f..ffe0e0029437 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2466,7 +2466,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 		update_partition_sd_lb(cs, old_prs);
 out_free:
 	free_cpumasks(NULL, &tmp);
-	return 0;
+	return retval;
 }
 
 /**
@@ -2502,9 +2502,6 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	if (cpumask_equal(cs->exclusive_cpus, trialcs->exclusive_cpus))
 		return 0;
 
-	if (alloc_cpumasks(NULL, &tmp))
-		return -ENOMEM;
-
 	if (*buf)
 		compute_effective_exclusive_cpumask(trialcs, NULL);
 
@@ -2519,6 +2516,9 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	if (retval)
 		return retval;
 
+	if (alloc_cpumasks(NULL, &tmp))
+		return -ENOMEM;
+
 	if (old_prs) {
 		if (cpumask_empty(trialcs->effective_xcpus)) {
 			invalidate = true;
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 755d8d4ef5b0..9e337493d7f5 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -377,6 +377,9 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
 
 	crashk_low_res.start = low_base;
 	crashk_low_res.end   = low_base + low_size - 1;
+#ifdef HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
+	insert_resource(&iomem_resource, &crashk_low_res);
+#endif
 #endif
 	return 0;
 }
@@ -458,8 +461,12 @@ void __init reserve_crashkernel_generic(char *cmdline,
 
 	crashk_res.start = crash_base;
 	crashk_res.end = crash_base + crash_size - 1;
+#ifdef HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
+	insert_resource(&iomem_resource, &crashk_res);
+#endif
 }
 
+#ifndef HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
 static __init int insert_crashkernel_resources(void)
 {
 	if (crashk_res.start < crashk_res.end)
@@ -472,6 +479,7 @@ static __init int insert_crashkernel_resources(void)
 }
 early_initcall(insert_crashkernel_resources);
 #endif
+#endif
 
 int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 			  void **addr, unsigned long *sz)
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 33d942615be5..9edfb3b7702b 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -981,8 +981,7 @@ static int swiotlb_area_find_slots(struct device *dev, struct io_tlb_pool *pool,
 	dma_addr_t tbl_dma_addr =
 		phys_to_dma_unencrypted(dev, pool->start) & boundary_mask;
 	unsigned long max_slots = get_max_slots(boundary_mask);
-	unsigned int iotlb_align_mask =
-		dma_get_min_align_mask(dev) | alloc_align_mask;
+	unsigned int iotlb_align_mask = dma_get_min_align_mask(dev);
 	unsigned int nslots = nr_slots(alloc_size), stride;
 	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
 	unsigned int index, slots_checked, count = 0, i;
@@ -994,18 +993,25 @@ static int swiotlb_area_find_slots(struct device *dev, struct io_tlb_pool *pool,
 	BUG_ON(area_index >= pool->nareas);
 
 	/*
-	 * For allocations of PAGE_SIZE or larger only look for page aligned
-	 * allocations.
+	 * Ensure that the allocation is at least slot-aligned and update
+	 * 'iotlb_align_mask' to ignore bits that will be preserved when
+	 * offsetting into the allocation.
 	 */
-	if (alloc_size >= PAGE_SIZE)
-		iotlb_align_mask |= ~PAGE_MASK;
-	iotlb_align_mask &= ~(IO_TLB_SIZE - 1);
+	alloc_align_mask |= (IO_TLB_SIZE - 1);
+	iotlb_align_mask &= ~alloc_align_mask;
 
 	/*
 	 * For mappings with an alignment requirement don't bother looping to
 	 * unaligned slots once we found an aligned one.
 	 */
-	stride = (iotlb_align_mask >> IO_TLB_SHIFT) + 1;
+	stride = get_max_slots(max(alloc_align_mask, iotlb_align_mask));
+
+	/*
+	 * For allocations of PAGE_SIZE or larger only look for page aligned
+	 * allocations.
+	 */
+	if (alloc_size >= PAGE_SIZE)
+		stride = umax(stride, PAGE_SHIFT - IO_TLB_SHIFT + 1);
 
 	spin_lock_irqsave(&area->lock, flags);
 	if (unlikely(nslots > pool->area_nslabs - area->used))
@@ -1015,11 +1021,14 @@ static int swiotlb_area_find_slots(struct device *dev, struct io_tlb_pool *pool,
 	index = area->index;
 
 	for (slots_checked = 0; slots_checked < pool->area_nslabs; ) {
+		phys_addr_t tlb_addr;
+
 		slot_index = slot_base + index;
+		tlb_addr = slot_addr(tbl_dma_addr, slot_index);
 
-		if (orig_addr &&
-		    (slot_addr(tbl_dma_addr, slot_index) &
-		     iotlb_align_mask) != (orig_addr & iotlb_align_mask)) {
+		if ((tlb_addr & alloc_align_mask) ||
+		    (orig_addr && (tlb_addr & iotlb_align_mask) !=
+				  (orig_addr & iotlb_align_mask))) {
 			index = wrap_area_index(pool, index + 1);
 			slots_checked++;
 			continue;
@@ -1608,12 +1617,14 @@ struct page *swiotlb_alloc(struct device *dev, size_t size)
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	struct io_tlb_pool *pool;
 	phys_addr_t tlb_addr;
+	unsigned int align;
 	int index;
 
 	if (!mem)
 		return NULL;
 
-	index = swiotlb_find_slots(dev, 0, size, 0, &pool);
+	align = (1 << (get_order(size) + PAGE_SHIFT)) - 1;
+	index = swiotlb_find_slots(dev, 0, size, align, &pool);
 	if (index == -1)
 		return NULL;
 
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index d7ee4bc3f2ba..5ff4f1cd3644 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -77,8 +77,14 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 	/* Either of the above might have changed the syscall number */
 	syscall = syscall_get_nr(current, regs);
 
-	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
+	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT)) {
 		trace_sys_enter(regs, syscall);
+		/*
+		 * Probes or BPF hooks in the tracepoint may have changed the
+		 * system call number as well.
+		 */
+		syscall = syscall_get_nr(current, regs);
+	}
 
 	syscall_enter_audit(regs, syscall);
 
diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 0ea1b2970a23..28db5b7589eb 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -236,6 +236,10 @@ choice
 	  possible to load a signed module containing the algorithm to check
 	  the signature on that module.
 
+config MODULE_SIG_SHA1
+	bool "Sign modules with SHA-1"
+	select CRYPTO_SHA1
+
 config MODULE_SIG_SHA256
 	bool "Sign modules with SHA-256"
 	select CRYPTO_SHA256
@@ -265,6 +269,7 @@ endchoice
 config MODULE_SIG_HASH
 	string
 	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
+	default "sha1" if MODULE_SIG_SHA1
 	default "sha256" if MODULE_SIG_SHA256
 	default "sha384" if MODULE_SIG_SHA384
 	default "sha512" if MODULE_SIG_SHA512
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index fa3bf161d13f..a718067deece 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -192,6 +192,7 @@ static int __init mem_sleep_default_setup(char *str)
 		if (mem_sleep_labels[state] &&
 		    !strcmp(str, mem_sleep_labels[state])) {
 			mem_sleep_default = state;
+			mem_sleep_current = state;
 			break;
 		}
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 72f6a564e832..7a835b277e98 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2026,6 +2026,12 @@ static int console_trylock_spinning(void)
 	 */
 	mutex_acquire(&console_lock_dep_map, 0, 1, _THIS_IP_);
 
+	/*
+	 * Update @console_may_schedule for trylock because the previous
+	 * owner may have been schedulable.
+	 */
+	console_may_schedule = 0;
+
 	return 1;
 }
 
@@ -3295,6 +3301,21 @@ static int __init keep_bootcon_setup(char *str)
 
 early_param("keep_bootcon", keep_bootcon_setup);
 
+static int console_call_setup(struct console *newcon, char *options)
+{
+	int err;
+
+	if (!newcon->setup)
+		return 0;
+
+	/* Synchronize with possible boot console. */
+	console_lock();
+	err = newcon->setup(newcon, options);
+	console_unlock();
+
+	return err;
+}
+
 /*
  * This is called by register_console() to try to match
  * the newly registered console with any of the ones selected
@@ -3330,8 +3351,8 @@ static int try_enable_preferred_console(struct console *newcon,
 			if (_braille_register_console(newcon, c))
 				return 0;
 
-			if (newcon->setup &&
-			    (err = newcon->setup(newcon, c->options)) != 0)
+			err = console_call_setup(newcon, c->options);
+			if (err)
 				return err;
 		}
 		newcon->flags |= CON_ENABLED;
@@ -3357,7 +3378,7 @@ static void try_enable_default_console(struct console *newcon)
 	if (newcon->index < 0)
 		newcon->index = 0;
 
-	if (newcon->setup && newcon->setup(newcon, NULL) != 0)
+	if (console_call_setup(newcon, NULL) != 0)
 		return;
 
 	newcon->flags |= CON_ENABLED;
diff --git a/kernel/sys.c b/kernel/sys.c
index f8e543f1e38a..8bb106a56b3a 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2408,8 +2408,11 @@ static inline int prctl_set_mdwe(unsigned long bits, unsigned long arg3,
 	if (bits & PR_MDWE_NO_INHERIT && !(bits & PR_MDWE_REFUSE_EXEC_GAIN))
 		return -EINVAL;
 
-	/* PARISC cannot allow mdwe as it needs writable stacks */
-	if (IS_ENABLED(CONFIG_PARISC))
+	/*
+	 * EOPNOTSUPP might be more appropriate here in principle, but
+	 * existing userspace depends on EINVAL specifically.
+	 */
+	if (!arch_memory_deny_write_exec_supported())
 		return -EINVAL;
 
 	current_bits = get_current_mdwe();
diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index 9de66bbbb3d1..4782edcbe7b9 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -129,15 +129,17 @@ static int posix_clock_open(struct inode *inode, struct file *fp)
 		goto out;
 	}
 	pccontext->clk = clk;
-	fp->private_data = pccontext;
-	if (clk->ops.open)
+	if (clk->ops.open) {
 		err = clk->ops.open(pccontext, fp->f_mode);
-	else
-		err = 0;
-
-	if (!err) {
-		get_device(clk->dev);
+		if (err) {
+			kfree(pccontext);
+			goto out;
+		}
 	}
+
+	fp->private_data = pccontext;
+	get_device(clk->dev);
+	err = 0;
 out:
 	up_read(&clk->rwsem);
 	return err;
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 6fa67c297e8f..140f8eed83da 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -412,7 +412,6 @@ struct rb_irq_work {
 	struct irq_work			work;
 	wait_queue_head_t		waiters;
 	wait_queue_head_t		full_waiters;
-	long				wait_index;
 	bool				waiters_pending;
 	bool				full_waiters_pending;
 	bool				wakeup_full;
@@ -903,8 +902,19 @@ static void rb_wake_up_waiters(struct irq_work *work)
 
 	wake_up_all(&rbwork->waiters);
 	if (rbwork->full_waiters_pending || rbwork->wakeup_full) {
+		/* Only cpu_buffer sets the above flags */
+		struct ring_buffer_per_cpu *cpu_buffer =
+			container_of(rbwork, struct ring_buffer_per_cpu, irq_work);
+
+		/* Called from interrupt context */
+		raw_spin_lock(&cpu_buffer->reader_lock);
 		rbwork->wakeup_full = false;
 		rbwork->full_waiters_pending = false;
+
+		/* Waking up all waiters, they will reset the shortest full */
+		cpu_buffer->shortest_full = 0;
+		raw_spin_unlock(&cpu_buffer->reader_lock);
+
 		wake_up_all(&rbwork->full_waiters);
 	}
 }
@@ -945,14 +955,95 @@ void ring_buffer_wake_waiters(struct trace_buffer *buffer, int cpu)
 		rbwork = &cpu_buffer->irq_work;
 	}
 
-	rbwork->wait_index++;
-	/* make sure the waiters see the new index */
-	smp_wmb();
-
 	/* This can be called in any context */
 	irq_work_queue(&rbwork->work);
 }
 
+static bool rb_watermark_hit(struct trace_buffer *buffer, int cpu, int full)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	bool ret = false;
+
+	/* Reads of all CPUs always waits for any data */
+	if (cpu == RING_BUFFER_ALL_CPUS)
+		return !ring_buffer_empty(buffer);
+
+	cpu_buffer = buffer->buffers[cpu];
+
+	if (!ring_buffer_empty_cpu(buffer, cpu)) {
+		unsigned long flags;
+		bool pagebusy;
+
+		if (!full)
+			return true;
+
+		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+		pagebusy = cpu_buffer->reader_page == cpu_buffer->commit_page;
+		ret = !pagebusy && full_hit(buffer, cpu, full);
+
+		if (!ret && (!cpu_buffer->shortest_full ||
+			     cpu_buffer->shortest_full > full)) {
+		    cpu_buffer->shortest_full = full;
+		}
+		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+	}
+	return ret;
+}
+
+static inline bool
+rb_wait_cond(struct rb_irq_work *rbwork, struct trace_buffer *buffer,
+	     int cpu, int full, ring_buffer_cond_fn cond, void *data)
+{
+	if (rb_watermark_hit(buffer, cpu, full))
+		return true;
+
+	if (cond(data))
+		return true;
+
+	/*
+	 * The events can happen in critical sections where
+	 * checking a work queue can cause deadlocks.
+	 * After adding a task to the queue, this flag is set
+	 * only to notify events to try to wake up the queue
+	 * using irq_work.
+	 *
+	 * We don't clear it even if the buffer is no longer
+	 * empty. The flag only causes the next event to run
+	 * irq_work to do the work queue wake up. The worse
+	 * that can happen if we race with !trace_empty() is that
+	 * an event will cause an irq_work to try to wake up
+	 * an empty queue.
+	 *
+	 * There's no reason to protect this flag either, as
+	 * the work queue and irq_work logic will do the necessary
+	 * synchronization for the wake ups. The only thing
+	 * that is necessary is that the wake up happens after
+	 * a task has been queued. It's OK for spurious wake ups.
+	 */
+	if (full)
+		rbwork->full_waiters_pending = true;
+	else
+		rbwork->waiters_pending = true;
+
+	return false;
+}
+
+/*
+ * The default wait condition for ring_buffer_wait() is to just to exit the
+ * wait loop the first time it is woken up.
+ */
+static bool rb_wait_once(void *data)
+{
+	long *once = data;
+
+	/* wait_event() actually calls this twice before scheduling*/
+	if (*once > 1)
+		return true;
+
+	(*once)++;
+	return false;
+}
+
 /**
  * ring_buffer_wait - wait for input to the ring buffer
  * @buffer: buffer to wait on
@@ -966,101 +1057,39 @@ void ring_buffer_wake_waiters(struct trace_buffer *buffer, int cpu)
 int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
-	DEFINE_WAIT(wait);
-	struct rb_irq_work *work;
-	long wait_index;
+	struct wait_queue_head *waitq;
+	ring_buffer_cond_fn cond;
+	struct rb_irq_work *rbwork;
+	void *data;
+	long once = 0;
 	int ret = 0;
 
+	cond = rb_wait_once;
+	data = &once;
+
 	/*
 	 * Depending on what the caller is waiting for, either any
 	 * data in any cpu buffer, or a specific buffer, put the
 	 * caller on the appropriate wait queue.
 	 */
 	if (cpu == RING_BUFFER_ALL_CPUS) {
-		work = &buffer->irq_work;
+		rbwork = &buffer->irq_work;
 		/* Full only makes sense on per cpu reads */
 		full = 0;
 	} else {
 		if (!cpumask_test_cpu(cpu, buffer->cpumask))
 			return -ENODEV;
 		cpu_buffer = buffer->buffers[cpu];
-		work = &cpu_buffer->irq_work;
-	}
-
-	wait_index = READ_ONCE(work->wait_index);
-
-	while (true) {
-		if (full)
-			prepare_to_wait(&work->full_waiters, &wait, TASK_INTERRUPTIBLE);
-		else
-			prepare_to_wait(&work->waiters, &wait, TASK_INTERRUPTIBLE);
-
-		/*
-		 * The events can happen in critical sections where
-		 * checking a work queue can cause deadlocks.
-		 * After adding a task to the queue, this flag is set
-		 * only to notify events to try to wake up the queue
-		 * using irq_work.
-		 *
-		 * We don't clear it even if the buffer is no longer
-		 * empty. The flag only causes the next event to run
-		 * irq_work to do the work queue wake up. The worse
-		 * that can happen if we race with !trace_empty() is that
-		 * an event will cause an irq_work to try to wake up
-		 * an empty queue.
-		 *
-		 * There's no reason to protect this flag either, as
-		 * the work queue and irq_work logic will do the necessary
-		 * synchronization for the wake ups. The only thing
-		 * that is necessary is that the wake up happens after
-		 * a task has been queued. It's OK for spurious wake ups.
-		 */
-		if (full)
-			work->full_waiters_pending = true;
-		else
-			work->waiters_pending = true;
-
-		if (signal_pending(current)) {
-			ret = -EINTR;
-			break;
-		}
-
-		if (cpu == RING_BUFFER_ALL_CPUS && !ring_buffer_empty(buffer))
-			break;
-
-		if (cpu != RING_BUFFER_ALL_CPUS &&
-		    !ring_buffer_empty_cpu(buffer, cpu)) {
-			unsigned long flags;
-			bool pagebusy;
-			bool done;
-
-			if (!full)
-				break;
-
-			raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
-			pagebusy = cpu_buffer->reader_page == cpu_buffer->commit_page;
-			done = !pagebusy && full_hit(buffer, cpu, full);
-
-			if (!cpu_buffer->shortest_full ||
-			    cpu_buffer->shortest_full > full)
-				cpu_buffer->shortest_full = full;
-			raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
-			if (done)
-				break;
-		}
-
-		schedule();
-
-		/* Make sure to see the new wait index */
-		smp_rmb();
-		if (wait_index != work->wait_index)
-			break;
+		rbwork = &cpu_buffer->irq_work;
 	}
 
 	if (full)
-		finish_wait(&work->full_waiters, &wait);
+		waitq = &rbwork->full_waiters;
 	else
-		finish_wait(&work->waiters, &wait);
+		waitq = &rbwork->waiters;
+
+	ret = wait_event_interruptible((*waitq),
+				rb_wait_cond(rbwork, buffer, cpu, full, cond, data));
 
 	return ret;
 }
@@ -1084,30 +1113,51 @@ __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 			  struct file *filp, poll_table *poll_table, int full)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
-	struct rb_irq_work *work;
+	struct rb_irq_work *rbwork;
 
 	if (cpu == RING_BUFFER_ALL_CPUS) {
-		work = &buffer->irq_work;
+		rbwork = &buffer->irq_work;
 		full = 0;
 	} else {
 		if (!cpumask_test_cpu(cpu, buffer->cpumask))
 			return EPOLLERR;
 
 		cpu_buffer = buffer->buffers[cpu];
-		work = &cpu_buffer->irq_work;
+		rbwork = &cpu_buffer->irq_work;
 	}
 
 	if (full) {
-		poll_wait(filp, &work->full_waiters, poll_table);
-		work->full_waiters_pending = true;
+		unsigned long flags;
+
+		poll_wait(filp, &rbwork->full_waiters, poll_table);
+
+		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 		if (!cpu_buffer->shortest_full ||
 		    cpu_buffer->shortest_full > full)
 			cpu_buffer->shortest_full = full;
-	} else {
-		poll_wait(filp, &work->waiters, poll_table);
-		work->waiters_pending = true;
+		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+		if (full_hit(buffer, cpu, full))
+			return EPOLLIN | EPOLLRDNORM;
+		/*
+		 * Only allow full_waiters_pending update to be seen after
+		 * the shortest_full is set. If the writer sees the
+		 * full_waiters_pending flag set, it will compare the
+		 * amount in the ring buffer to shortest_full. If the amount
+		 * in the ring buffer is greater than the shortest_full
+		 * percent, it will call the irq_work handler to wake up
+		 * this list. The irq_handler will reset shortest_full
+		 * back to zero. That's done under the reader_lock, but
+		 * the below smp_mb() makes sure that the update to
+		 * full_waiters_pending doesn't leak up into the above.
+		 */
+		smp_mb();
+		rbwork->full_waiters_pending = true;
+		return 0;
 	}
 
+	poll_wait(filp, &rbwork->waiters, poll_table);
+	rbwork->waiters_pending = true;
+
 	/*
 	 * There's a tight race between setting the waiters_pending and
 	 * checking if the ring buffer is empty.  Once the waiters_pending bit
@@ -1123,9 +1173,6 @@ __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 	 */
 	smp_mb();
 
-	if (full)
-		return full_hit(buffer, cpu, full) ? EPOLLIN | EPOLLRDNORM : 0;
-
 	if ((cpu == RING_BUFFER_ALL_CPUS && !ring_buffer_empty(buffer)) ||
 	    (cpu != RING_BUFFER_ALL_CPUS && !ring_buffer_empty_cpu(buffer, cpu)))
 		return EPOLLIN | EPOLLRDNORM;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 3fdc57450e79..e03960f9f4cf 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8352,6 +8352,20 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
 	return size;
 }
 
+static int tracing_buffers_flush(struct file *file, fl_owner_t id)
+{
+	struct ftrace_buffer_info *info = file->private_data;
+	struct trace_iterator *iter = &info->iter;
+
+	iter->wait_index++;
+	/* Make sure the waiters see the new wait_index */
+	smp_wmb();
+
+	ring_buffer_wake_waiters(iter->array_buffer->buffer, iter->cpu_file);
+
+	return 0;
+}
+
 static int tracing_buffers_release(struct inode *inode, struct file *file)
 {
 	struct ftrace_buffer_info *info = file->private_data;
@@ -8363,12 +8377,6 @@ static int tracing_buffers_release(struct inode *inode, struct file *file)
 
 	__trace_array_put(iter->tr);
 
-	iter->wait_index++;
-	/* Make sure the waiters see the new wait_index */
-	smp_wmb();
-
-	ring_buffer_wake_waiters(iter->array_buffer->buffer, iter->cpu_file);
-
 	if (info->spare)
 		ring_buffer_free_read_page(iter->array_buffer->buffer,
 					   info->spare_cpu, info->spare);
@@ -8582,6 +8590,7 @@ static const struct file_operations tracing_buffers_fops = {
 	.read		= tracing_buffers_read,
 	.poll		= tracing_buffers_poll,
 	.release	= tracing_buffers_release,
+	.flush		= tracing_buffers_flush,
 	.splice_read	= tracing_buffers_splice_read,
 	.unlocked_ioctl = tracing_buffers_ioctl,
 	.llseek		= no_llseek,
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 6f7cb619aa5e..8f761417a9fa 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -7109,7 +7109,7 @@ void __init workqueue_init_early(void)
 					      WQ_FREEZABLE, 0);
 	system_power_efficient_wq = alloc_workqueue("events_power_efficient",
 					      WQ_POWER_EFFICIENT, 0);
-	system_freezable_power_efficient_wq = alloc_workqueue("events_freezable_power_efficient",
+	system_freezable_power_efficient_wq = alloc_workqueue("events_freezable_pwr_efficient",
 					      WQ_FREEZABLE | WQ_POWER_EFFICIENT,
 					      0);
 	BUG_ON(!system_wq || !system_highpri_wq || !system_long_wq ||
diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c
index ce39ce9f3526..2829ddb0e316 100644
--- a/lib/pci_iomap.c
+++ b/lib/pci_iomap.c
@@ -170,8 +170,8 @@ void pci_iounmap(struct pci_dev *dev, void __iomem *p)
 
 	if (addr >= start && addr < start + IO_SPACE_LIMIT)
 		return;
-	iounmap(p);
 #endif
+	iounmap(p);
 }
 EXPORT_SYMBOL(pci_iounmap);
 
diff --git a/mm/compaction.c b/mm/compaction.c
index 01ba298739dd..f31d18741a0d 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2701,16 +2701,11 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 		unsigned int alloc_flags, const struct alloc_context *ac,
 		enum compact_priority prio, struct page **capture)
 {
-	int may_perform_io = (__force int)(gfp_mask & __GFP_IO);
 	struct zoneref *z;
 	struct zone *zone;
 	enum compact_result rc = COMPACT_SKIPPED;
 
-	/*
-	 * Check if the GFP flags allow compaction - GFP_NOIO is really
-	 * tricky context because the migration might require IO
-	 */
-	if (!may_perform_io)
+	if (!gfp_compaction_allowed(gfp_mask))
 		return COMPACT_SKIPPED;
 
 	trace_mm_compaction_try_to_compact_pages(order, gfp_mask, prio);
diff --git a/mm/filemap.c b/mm/filemap.c
index 5be7887957c7..321349e2c9c7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4150,7 +4150,23 @@ static void filemap_cachestat(struct address_space *mapping,
 				/* shmem file - in swap cache */
 				swp_entry_t swp = radix_to_swp_entry(folio);
 
+				/* swapin error results in poisoned entry */
+				if (non_swap_entry(swp))
+					goto resched;
+
+				/*
+				 * Getting a swap entry from the shmem
+				 * inode means we beat
+				 * shmem_unuse(). rcu_read_lock()
+				 * ensures swapoff waits for us before
+				 * freeing the swapper space. However,
+				 * we can race with swapping and
+				 * invalidation, so there might not be
+				 * a shadow in the swapcache (yet).
+				 */
 				shadow = get_shadow_from_swap_cache(swp);
+				if (!shadow)
+					goto resched;
 			}
 #endif
 			if (workingset_test_recent(shadow, true, &workingset))
diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index 34515a106ca5..23906e886b57 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -451,7 +451,8 @@ static void kmalloc_oob_16(struct kunit *test)
 	/* This test is specifically crafted for the generic mode. */
 	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_GENERIC);
 
-	ptr1 = kmalloc(sizeof(*ptr1) - 3, GFP_KERNEL);
+	/* RELOC_HIDE to prevent gcc from warning about short alloc */
+	ptr1 = RELOC_HIDE(kmalloc(sizeof(*ptr1) - 3, GFP_KERNEL), 0);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
 
 	ptr2 = kmalloc(sizeof(*ptr2), GFP_KERNEL);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 792fb3a5ce3b..27c9f451d40d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4379,7 +4379,7 @@ static void __mem_cgroup_threshold(struct mem_cgroup *memcg, bool swap)
 	 * only one element of the array here.
 	 */
 	for (; i >= 0 && unlikely(t->entries[i].threshold > usage); i--)
-		eventfd_signal(t->entries[i].eventfd, 1);
+		eventfd_signal(t->entries[i].eventfd);
 
 	/* i = current_threshold + 1 */
 	i++;
@@ -4391,7 +4391,7 @@ static void __mem_cgroup_threshold(struct mem_cgroup *memcg, bool swap)
 	 * only one element of the array here.
 	 */
 	for (; i < t->size && unlikely(t->entries[i].threshold <= usage); i++)
-		eventfd_signal(t->entries[i].eventfd, 1);
+		eventfd_signal(t->entries[i].eventfd);
 
 	/* Update current_threshold */
 	t->current_threshold = i - 1;
@@ -4431,7 +4431,7 @@ static int mem_cgroup_oom_notify_cb(struct mem_cgroup *memcg)
 	spin_lock(&memcg_oom_lock);
 
 	list_for_each_entry(ev, &memcg->oom_notify, list)
-		eventfd_signal(ev->eventfd, 1);
+		eventfd_signal(ev->eventfd);
 
 	spin_unlock(&memcg_oom_lock);
 	return 0;
@@ -4650,7 +4650,7 @@ static int mem_cgroup_oom_register_event(struct mem_cgroup *memcg,
 
 	/* already in OOM ? */
 	if (memcg->under_oom)
-		eventfd_signal(eventfd, 1);
+		eventfd_signal(eventfd);
 	spin_unlock(&memcg_oom_lock);
 
 	return 0;
@@ -4942,7 +4942,7 @@ static void memcg_event_remove(struct work_struct *work)
 	event->unregister_event(memcg, event->eventfd);
 
 	/* Notify userspace the event is going away. */
-	eventfd_signal(event->eventfd, 1);
+	eventfd_signal(event->eventfd);
 
 	eventfd_ctx_put(event->eventfd);
 	kfree(event);
diff --git a/mm/memtest.c b/mm/memtest.c
index 32f3e9dda837..c2c609c39119 100644
--- a/mm/memtest.c
+++ b/mm/memtest.c
@@ -51,10 +51,10 @@ static void __init memtest(u64 pattern, phys_addr_t start_phys, phys_addr_t size
 	last_bad = 0;
 
 	for (p = start; p < end; p++)
-		*p = pattern;
+		WRITE_ONCE(*p, pattern);
 
 	for (p = start; p < end; p++, start_phys_aligned += incr) {
-		if (*p == pattern)
+		if (READ_ONCE(*p) == pattern)
 			continue;
 		if (start_phys_aligned == last_bad + incr) {
 			last_bad += incr;
diff --git a/mm/mmap.c b/mm/mmap.c
index b9a43872acad..23072589fe83 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -954,13 +954,21 @@ static struct vm_area_struct
 	} else if (merge_prev) {			/* case 2 */
 		if (curr) {
 			vma_start_write(curr);
-			err = dup_anon_vma(prev, curr, &anon_dup);
 			if (end == curr->vm_end) {	/* case 7 */
+				/*
+				 * can_vma_merge_after() assumed we would not be
+				 * removing prev vma, so it skipped the check
+				 * for vm_ops->close, but we are removing curr
+				 */
+				if (curr->vm_ops && curr->vm_ops->close)
+					err = -EINVAL;
 				remove = curr;
 			} else {			/* case 5 */
 				adjust = curr;
 				adj_start = (end - curr->vm_start);
 			}
+			if (!err)
+				err = dup_anon_vma(prev, curr, &anon_dup);
 		}
 	} else { /* merge_next */
 		vma_start_write(next);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6d2a74138f45..b1d9dcdabd03 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4042,6 +4042,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 						struct alloc_context *ac)
 {
 	bool can_direct_reclaim = gfp_mask & __GFP_DIRECT_RECLAIM;
+	bool can_compact = gfp_compaction_allowed(gfp_mask);
 	const bool costly_order = order > PAGE_ALLOC_COSTLY_ORDER;
 	struct page *page = NULL;
 	unsigned int alloc_flags;
@@ -4112,7 +4113,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * Don't try this for allocations that are allowed to ignore
 	 * watermarks, as the ALLOC_NO_WATERMARKS attempt didn't yet happen.
 	 */
-	if (can_direct_reclaim &&
+	if (can_direct_reclaim && can_compact &&
 			(costly_order ||
 			   (order > 0 && ac->migratetype != MIGRATE_MOVABLE))
 			&& !gfp_pfmemalloc_allowed(gfp_mask)) {
@@ -4210,9 +4211,10 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 
 	/*
 	 * Do not retry costly high order allocations unless they are
-	 * __GFP_RETRY_MAYFAIL
+	 * __GFP_RETRY_MAYFAIL and we can compact
 	 */
-	if (costly_order && !(gfp_mask & __GFP_RETRY_MAYFAIL))
+	if (costly_order && (!can_compact ||
+			     !(gfp_mask & __GFP_RETRY_MAYFAIL)))
 		goto nopage;
 
 	if (should_reclaim_retry(gfp_mask, order, ac, alloc_flags,
@@ -4225,7 +4227,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * implementation of the compaction depends on the sufficient amount
 	 * of free memory (see __compaction_suitable)
 	 */
-	if (did_some_progress > 0 &&
+	if (did_some_progress > 0 && can_compact &&
 			should_compact_retry(ac, order, alloc_flags,
 				compact_result, &compact_priority,
 				&compaction_retries))
diff --git a/mm/shmem_quota.c b/mm/shmem_quota.c
index 062d1c1097ae..ce514e700d2f 100644
--- a/mm/shmem_quota.c
+++ b/mm/shmem_quota.c
@@ -116,7 +116,7 @@ static int shmem_free_file_info(struct super_block *sb, int type)
 static int shmem_get_next_id(struct super_block *sb, struct kqid *qid)
 {
 	struct mem_dqinfo *info = sb_dqinfo(sb, qid->type);
-	struct rb_node *node = ((struct rb_root *)info->dqi_priv)->rb_node;
+	struct rb_node *node;
 	qid_t id = from_kqid(&init_user_ns, *qid);
 	struct quota_info *dqopt = sb_dqopt(sb);
 	struct quota_id *entry = NULL;
@@ -126,6 +126,7 @@ static int shmem_get_next_id(struct super_block *sb, struct kqid *qid)
 		return -ESRCH;
 
 	down_read(&dqopt->dqio_sem);
+	node = ((struct rb_root *)info->dqi_priv)->rb_node;
 	while (node) {
 		entry = rb_entry(node, struct quota_id, node);
 
@@ -165,7 +166,7 @@ static int shmem_get_next_id(struct super_block *sb, struct kqid *qid)
 static int shmem_acquire_dquot(struct dquot *dquot)
 {
 	struct mem_dqinfo *info = sb_dqinfo(dquot->dq_sb, dquot->dq_id.type);
-	struct rb_node **n = &((struct rb_root *)info->dqi_priv)->rb_node;
+	struct rb_node **n;
 	struct shmem_sb_info *sbinfo = dquot->dq_sb->s_fs_info;
 	struct rb_node *parent = NULL, *new_node = NULL;
 	struct quota_id *new_entry, *entry;
@@ -176,6 +177,8 @@ static int shmem_acquire_dquot(struct dquot *dquot)
 	mutex_lock(&dquot->dq_lock);
 
 	down_write(&dqopt->dqio_sem);
+	n = &((struct rb_root *)info->dqi_priv)->rb_node;
+
 	while (*n) {
 		parent = *n;
 		entry = rb_entry(parent, struct quota_id, node);
@@ -264,7 +267,7 @@ static bool shmem_is_empty_dquot(struct dquot *dquot)
 static int shmem_release_dquot(struct dquot *dquot)
 {
 	struct mem_dqinfo *info = sb_dqinfo(dquot->dq_sb, dquot->dq_id.type);
-	struct rb_node *node = ((struct rb_root *)info->dqi_priv)->rb_node;
+	struct rb_node *node;
 	qid_t id = from_kqid(&init_user_ns, dquot->dq_id);
 	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
 	struct quota_id *entry = NULL;
@@ -275,6 +278,7 @@ static int shmem_release_dquot(struct dquot *dquot)
 		goto out_dqlock;
 
 	down_write(&dqopt->dqio_sem);
+	node = ((struct rb_root *)info->dqi_priv)->rb_node;
 	while (node) {
 		entry = rb_entry(node, struct quota_id, node);
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 022581ec40be..91397a2539cb 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1226,6 +1226,11 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
  * with get_swap_device() and put_swap_device(), unless the swap
  * functions call get/put_swap_device() by themselves.
  *
+ * Note that when only holding the PTL, swapoff might succeed immediately
+ * after freeing a swap entry. Therefore, immediately after
+ * __swap_entry_free(), the swap info might become stale and should not
+ * be touched without a prior get_swap_device().
+ *
  * Check whether swap entry is valid in the swap device.  If so,
  * return pointer to swap_info_struct, and keep the swap entry valid
  * via preventing the swap device from being swapoff, until
@@ -1603,13 +1608,19 @@ int free_swap_and_cache(swp_entry_t entry)
 	if (non_swap_entry(entry))
 		return 1;
 
-	p = _swap_info_get(entry);
+	p = get_swap_device(entry);
 	if (p) {
+		if (WARN_ON(data_race(!p->swap_map[swp_offset(entry)]))) {
+			put_swap_device(p);
+			return 0;
+		}
+
 		count = __swap_entry_free(p, entry);
 		if (count == SWAP_HAS_CACHE &&
 		    !swap_page_trans_huge_swapped(p, entry))
 			__try_to_reclaim_swap(p, swp_offset(entry),
 					      TTRS_UNMAPPED | TTRS_FULL);
+		put_swap_device(p);
 	}
 	return p != NULL;
 }
diff --git a/mm/vmpressure.c b/mm/vmpressure.c
index 22c6689d9302..bd5183dfd879 100644
--- a/mm/vmpressure.c
+++ b/mm/vmpressure.c
@@ -169,7 +169,7 @@ static bool vmpressure_event(struct vmpressure *vmpr,
 			continue;
 		if (level < ev->level)
 			continue;
-		eventfd_signal(ev->efd, 1);
+		eventfd_signal(ev->efd);
 		ret = true;
 	}
 	mutex_unlock(&vmpr->events_lock);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index bba207f41b14..ebaf79d6830e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5733,7 +5733,7 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 /* Use reclaim/compaction for costly allocs or under memory pressure */
 static bool in_reclaim_compaction(struct scan_control *sc)
 {
-	if (IS_ENABLED(CONFIG_COMPACTION) && sc->order &&
+	if (gfp_compaction_allowed(sc->gfp_mask) && sc->order &&
 			(sc->order > PAGE_ALLOC_COSTLY_ORDER ||
 			 sc->priority < DEF_PRIORITY - 2))
 		return true;
@@ -5978,6 +5978,9 @@ static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
 {
 	unsigned long watermark;
 
+	if (!gfp_compaction_allowed(sc->gfp_mask))
+		return false;
+
 	/* Allocation can already succeed, nothing to do */
 	if (zone_watermark_ok(zone, sc->order, min_wmark_pages(zone),
 			      sc->reclaim_idx, 0))
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7d5334b52983..0592369579ab 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2842,7 +2842,7 @@ static void hci_cancel_cmd_sync(struct hci_dev *hdev, int err)
 	cancel_delayed_work_sync(&hdev->ncmd_timer);
 	atomic_set(&hdev->cmd_cnt, 1);
 
-	hci_cmd_sync_cancel_sync(hdev, -err);
+	hci_cmd_sync_cancel_sync(hdev, err);
 }
 
 /* Suspend HCI device */
@@ -2862,7 +2862,7 @@ int hci_suspend_dev(struct hci_dev *hdev)
 		return 0;
 
 	/* Cancel potentially blocking sync operation before suspend */
-	hci_cancel_cmd_sync(hdev, -EHOSTDOWN);
+	hci_cancel_cmd_sync(hdev, EHOSTDOWN);
 
 	hci_req_sync_lock(hdev);
 	ret = hci_suspend_sync(hdev);
@@ -4178,7 +4178,7 @@ static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 
 	err = hci_send_frame(hdev, skb);
 	if (err < 0) {
-		hci_cmd_sync_cancel_sync(hdev, err);
+		hci_cmd_sync_cancel_sync(hdev, -err);
 		return;
 	}
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 183501f92181..5ce71c483b7c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -679,7 +679,10 @@ void hci_cmd_sync_cancel_sync(struct hci_dev *hdev, int err)
 	bt_dev_dbg(hdev, "err 0x%2.2x", err);
 
 	if (hdev->req_status == HCI_REQ_PEND) {
-		hdev->req_result = err;
+		/* req_result is __u32 so error must be positive to be properly
+		 * propagated.
+		 */
+		hdev->req_result = err < 0 ? -err : err;
 		hdev->req_status = HCI_REQ_CANCELED;
 
 		wake_up_interruptible(&hdev->req_wait_q);
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 4ccfc104f13a..fe501d2186bc 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -95,7 +95,7 @@ static inline struct scatterlist *esp_req_sg(struct crypto_aead *aead,
 			     __alignof__(struct scatterlist));
 }
 
-static void esp_ssg_unref(struct xfrm_state *x, void *tmp)
+static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 {
 	struct crypto_aead *aead = x->data;
 	int extralen = 0;
@@ -114,7 +114,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp)
 	 */
 	if (req->src != req->dst)
 		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
-			put_page(sg_page(sg));
+			skb_page_unref(skb, sg_page(sg), false);
 }
 
 #ifdef CONFIG_INET_ESPINTCP
@@ -260,7 +260,7 @@ static void esp_output_done(void *data, int err)
 	}
 
 	tmp = ESP_SKB_CB(skb)->tmp;
-	esp_ssg_unref(x, tmp);
+	esp_ssg_unref(x, tmp, skb);
 	kfree(tmp);
 
 	if (xo && (xo->flags & XFRM_DEV_RESUME)) {
@@ -639,7 +639,7 @@ int esp_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *
 	}
 
 	if (sg != dsg)
-		esp_ssg_unref(x, tmp);
+		esp_ssg_unref(x, tmp, skb);
 
 	if (!err && x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP)
 		err = esp_output_tail_tcp(x, skb);
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 2cc1a45742d8..a3fa3eda388a 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -112,7 +112,7 @@ static inline struct scatterlist *esp_req_sg(struct crypto_aead *aead,
 			     __alignof__(struct scatterlist));
 }
 
-static void esp_ssg_unref(struct xfrm_state *x, void *tmp)
+static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 {
 	struct crypto_aead *aead = x->data;
 	int extralen = 0;
@@ -131,7 +131,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp)
 	 */
 	if (req->src != req->dst)
 		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
-			put_page(sg_page(sg));
+			skb_page_unref(skb, sg_page(sg), false);
 }
 
 #ifdef CONFIG_INET6_ESPINTCP
@@ -294,7 +294,7 @@ static void esp_output_done(void *data, int err)
 	}
 
 	tmp = ESP_SKB_CB(skb)->tmp;
-	esp_ssg_unref(x, tmp);
+	esp_ssg_unref(x, tmp, skb);
 	kfree(tmp);
 
 	esp_output_encap_csum(skb);
@@ -677,7 +677,7 @@ int esp6_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info
 	}
 
 	if (sg != dsg)
-		esp_ssg_unref(x, tmp);
+		esp_ssg_unref(x, tmp, skb);
 
 	if (!err && x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP)
 		err = esp_output_tail_tcp(x, skb);
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b382c2e0a39a..ebaf930bb4c9 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1869,7 +1869,7 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 					      sband->band);
 	}
 
-	ieee80211_sta_set_rx_nss(link_sta);
+	ieee80211_sta_init_nss(link_sta);
 
 	return ret;
 }
@@ -2164,15 +2164,14 @@ static int ieee80211_change_station(struct wiphy *wiphy,
 		}
 
 		if (sta->sdata->vif.type == NL80211_IFTYPE_AP_VLAN &&
-		    sta->sdata->u.vlan.sta) {
-			ieee80211_clear_fast_rx(sta);
+		    sta->sdata->u.vlan.sta)
 			RCU_INIT_POINTER(sta->sdata->u.vlan.sta, NULL);
-		}
 
 		if (test_sta_flag(sta, WLAN_STA_AUTHORIZED))
 			ieee80211_vif_dec_num_mcast(sta->sdata);
 
 		sta->sdata = vlansdata;
+		ieee80211_check_fast_rx(sta);
 		ieee80211_check_fast_xmit(sta);
 
 		if (test_sta_flag(sta, WLAN_STA_AUTHORIZED)) {
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 84df104f272b..e0a792a7707c 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2109,7 +2109,7 @@ enum ieee80211_sta_rx_bandwidth
 ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta);
 enum ieee80211_sta_rx_bandwidth
 ieee80211_sta_cur_vht_bw(struct link_sta_info *link_sta);
-void ieee80211_sta_set_rx_nss(struct link_sta_info *link_sta);
+void ieee80211_sta_init_nss(struct link_sta_info *link_sta);
 enum ieee80211_sta_rx_bandwidth
 ieee80211_chan_width_to_rx_bw(enum nl80211_chan_width width);
 enum nl80211_chan_width
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 9d33fd2377c8..0efdaa8f2a92 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -37,7 +37,7 @@ void rate_control_rate_init(struct sta_info *sta)
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_chanctx_conf *chanctx_conf;
 
-	ieee80211_sta_set_rx_nss(&sta->deflink);
+	ieee80211_sta_init_nss(&sta->deflink);
 
 	if (!ref)
 		return;
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 7acf2223e47a..f4713046728a 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -3,7 +3,7 @@
  * Copyright 2002-2005, Devicescape Software, Inc.
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright(c) 2015-2017 Intel Deutschland GmbH
- * Copyright(c) 2020-2023 Intel Corporation
+ * Copyright(c) 2020-2024 Intel Corporation
  */
 
 #ifndef STA_INFO_H
@@ -482,6 +482,8 @@ struct ieee80211_fragment_cache {
  *	same for non-MLD STA. This is used as key for searching link STA
  * @link_id: Link ID uniquely identifying the link STA. This is 0 for non-MLD
  *	and set to the corresponding vif LinkId for MLD STA
+ * @op_mode_nss: NSS limit as set by operating mode notification, or 0
+ * @capa_nss: NSS limit as determined by local and peer capabilities
  * @link_hash_node: hash node for rhashtable
  * @sta: Points to the STA info
  * @gtk: group keys negotiated with this station, if any
@@ -518,6 +520,8 @@ struct link_sta_info {
 	u8 addr[ETH_ALEN];
 	u8 link_id;
 
+	u8 op_mode_nss, capa_nss;
+
 	struct rhlist_head link_hash_node;
 
 	struct sta_info *sta;
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index b3a5c3e96a72..bc13b1419981 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -4,7 +4,7 @@
  *
  * Portions of this file
  * Copyright(c) 2015 - 2016 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2023 Intel Corporation
+ * Copyright (C) 2018 - 2024 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -541,15 +541,11 @@ ieee80211_sta_cur_vht_bw(struct link_sta_info *link_sta)
 	return bw;
 }
 
-void ieee80211_sta_set_rx_nss(struct link_sta_info *link_sta)
+void ieee80211_sta_init_nss(struct link_sta_info *link_sta)
 {
 	u8 ht_rx_nss = 0, vht_rx_nss = 0, he_rx_nss = 0, eht_rx_nss = 0, rx_nss;
 	bool support_160;
 
-	/* if we received a notification already don't overwrite it */
-	if (link_sta->pub->rx_nss)
-		return;
-
 	if (link_sta->pub->eht_cap.has_eht) {
 		int i;
 		const u8 *rx_nss_mcs = (void *)&link_sta->pub->eht_cap.eht_mcs_nss_supp;
@@ -627,7 +623,15 @@ void ieee80211_sta_set_rx_nss(struct link_sta_info *link_sta)
 	rx_nss = max(vht_rx_nss, ht_rx_nss);
 	rx_nss = max(he_rx_nss, rx_nss);
 	rx_nss = max(eht_rx_nss, rx_nss);
-	link_sta->pub->rx_nss = max_t(u8, 1, rx_nss);
+	rx_nss = max_t(u8, 1, rx_nss);
+	link_sta->capa_nss = rx_nss;
+
+	/* that shouldn't be set yet, but we can handle it anyway */
+	if (link_sta->op_mode_nss)
+		link_sta->pub->rx_nss =
+			min_t(u8, rx_nss, link_sta->op_mode_nss);
+	else
+		link_sta->pub->rx_nss = rx_nss;
 }
 
 u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
@@ -637,7 +641,7 @@ u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 	enum ieee80211_sta_rx_bandwidth new_bw;
 	struct sta_opmode_info sta_opmode = {};
 	u32 changed = 0;
-	u8 nss, cur_nss;
+	u8 nss;
 
 	/* ignore - no support for BF yet */
 	if (opmode & IEEE80211_OPMODE_NOTIF_RX_NSS_TYPE_BF)
@@ -647,23 +651,17 @@ u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 	nss >>= IEEE80211_OPMODE_NOTIF_RX_NSS_SHIFT;
 	nss += 1;
 
-	if (link_sta->pub->rx_nss != nss) {
-		cur_nss = link_sta->pub->rx_nss;
-		/* Reset rx_nss and call ieee80211_sta_set_rx_nss() which
-		 * will set the same to max nss value calculated based on capability.
-		 */
-		link_sta->pub->rx_nss = 0;
-		ieee80211_sta_set_rx_nss(link_sta);
-		/* Do not allow an nss change to rx_nss greater than max_nss
-		 * negotiated and capped to APs capability during association.
-		 */
-		if (nss <= link_sta->pub->rx_nss) {
-			link_sta->pub->rx_nss = nss;
-			sta_opmode.rx_nss = nss;
-			changed |= IEEE80211_RC_NSS_CHANGED;
-			sta_opmode.changed |= STA_OPMODE_N_SS_CHANGED;
+	if (link_sta->op_mode_nss != nss) {
+		if (nss <= link_sta->capa_nss) {
+			link_sta->op_mode_nss = nss;
+
+			if (nss != link_sta->pub->rx_nss) {
+				link_sta->pub->rx_nss = nss;
+				changed |= IEEE80211_RC_NSS_CHANGED;
+				sta_opmode.rx_nss = link_sta->pub->rx_nss;
+				sta_opmode.changed |= STA_OPMODE_N_SS_CHANGED;
+			}
 		} else {
-			link_sta->pub->rx_nss = cur_nss;
 			pr_warn_ratelimited("Ignoring NSS change in VHT Operating Mode Notification from %pM with invalid nss %d",
 					    link_sta->pub->addr, nss);
 		}
diff --git a/net/mac802154/llsec.c b/net/mac802154/llsec.c
index 8d2eabc71bbe..f13b07ebfb98 100644
--- a/net/mac802154/llsec.c
+++ b/net/mac802154/llsec.c
@@ -265,19 +265,27 @@ int mac802154_llsec_key_add(struct mac802154_llsec *sec,
 	return -ENOMEM;
 }
 
+static void mac802154_llsec_key_del_rcu(struct rcu_head *rcu)
+{
+	struct ieee802154_llsec_key_entry *pos;
+	struct mac802154_llsec_key *mkey;
+
+	pos = container_of(rcu, struct ieee802154_llsec_key_entry, rcu);
+	mkey = container_of(pos->key, struct mac802154_llsec_key, key);
+
+	llsec_key_put(mkey);
+	kfree_sensitive(pos);
+}
+
 int mac802154_llsec_key_del(struct mac802154_llsec *sec,
 			    const struct ieee802154_llsec_key_id *key)
 {
 	struct ieee802154_llsec_key_entry *pos;
 
 	list_for_each_entry(pos, &sec->table.keys, list) {
-		struct mac802154_llsec_key *mkey;
-
-		mkey = container_of(pos->key, struct mac802154_llsec_key, key);
-
 		if (llsec_key_id_equal(&pos->id, key)) {
 			list_del_rcu(&pos->list);
-			llsec_key_put(mkey);
+			call_rcu(&pos->rcu, mac802154_llsec_key_del_rcu);
 			return 0;
 		}
 	}
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 0130c2782cdc..d07872814fee 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5000,6 +5000,12 @@ static int nf_tables_newset(struct sk_buff *skb, const struct nfnl_info *info,
 		if ((flags & (NFT_SET_EVAL | NFT_SET_OBJECT)) ==
 			     (NFT_SET_EVAL | NFT_SET_OBJECT))
 			return -EOPNOTSUPP;
+		if ((flags & (NFT_SET_ANONYMOUS | NFT_SET_TIMEOUT | NFT_SET_EVAL)) ==
+			     (NFT_SET_ANONYMOUS | NFT_SET_TIMEOUT))
+			return -EOPNOTSUPP;
+		if ((flags & (NFT_SET_CONSTANT | NFT_SET_TIMEOUT)) ==
+			     (NFT_SET_CONSTANT | NFT_SET_TIMEOUT))
+			return -EOPNOTSUPP;
 	}
 
 	desc.dtype = 0;
@@ -5423,6 +5429,7 @@ static void nf_tables_unbind_set(const struct nft_ctx *ctx, struct nft_set *set,
 
 	if (list_empty(&set->bindings) && nft_set_is_anonymous(set)) {
 		list_del_rcu(&set->list);
+		set->dead = 1;
 		if (event)
 			nf_tables_set_notify(ctx, set, NFT_MSG_DELSET,
 					     GFP_KERNEL);
diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
index a161c64d1765..838ad6541a17 100644
--- a/net/wireless/wext-core.c
+++ b/net/wireless/wext-core.c
@@ -4,6 +4,7 @@
  * Authors :	Jean Tourrilhes - HPL - <jt@hpl.hp.com>
  * Copyright (c) 1997-2007 Jean Tourrilhes, All Rights Reserved.
  * Copyright	2009 Johannes Berg <johannes@sipsolutions.net>
+ * Copyright (C) 2024 Intel Corporation
  *
  * (As all part of the Linux kernel, this file is GPL)
  */
@@ -662,7 +663,8 @@ struct iw_statistics *get_wireless_stats(struct net_device *dev)
 	    dev->ieee80211_ptr->wiphy->wext &&
 	    dev->ieee80211_ptr->wiphy->wext->get_wireless_stats) {
 		wireless_warn_cfg80211_wext();
-		if (dev->ieee80211_ptr->wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO)
+		if (dev->ieee80211_ptr->wiphy->flags & (WIPHY_FLAG_SUPPORTS_MLO |
+							WIPHY_FLAG_DISABLE_WEXT))
 			return NULL;
 		return dev->ieee80211_ptr->wiphy->wext->get_wireless_stats(dev);
 	}
@@ -704,7 +706,8 @@ static iw_handler get_handler(struct net_device *dev, unsigned int cmd)
 #ifdef CONFIG_CFG80211_WEXT
 	if (dev->ieee80211_ptr && dev->ieee80211_ptr->wiphy) {
 		wireless_warn_cfg80211_wext();
-		if (dev->ieee80211_ptr->wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO)
+		if (dev->ieee80211_ptr->wiphy->flags & (WIPHY_FLAG_SUPPORTS_MLO |
+							WIPHY_FLAG_DISABLE_WEXT))
 			return NULL;
 		handlers = dev->ieee80211_ptr->wiphy->wext;
 	}
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index ad01997c3aa9..444e58bc3f44 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2017,6 +2017,9 @@ static int copy_to_user_tmpl(struct xfrm_policy *xp, struct sk_buff *skb)
 	if (xp->xfrm_nr == 0)
 		return 0;
 
+	if (xp->xfrm_nr > XFRM_MAX_DEPTH)
+		return -ENOBUFS;
+
 	for (i = 0; i < xp->xfrm_nr; i++) {
 		struct xfrm_user_tmpl *up = &vec[i];
 		struct xfrm_tmpl *kp = &xp->xfrm_vec[i];
diff --git a/samples/vfio-mdev/mtty.c b/samples/vfio-mdev/mtty.c
index 69ba0281f9e0..2284b3751240 100644
--- a/samples/vfio-mdev/mtty.c
+++ b/samples/vfio-mdev/mtty.c
@@ -234,10 +234,10 @@ static void mtty_trigger_interrupt(struct mdev_state *mdev_state)
 
 	if (is_msi(mdev_state)) {
 		if (mdev_state->msi_evtfd)
-			eventfd_signal(mdev_state->msi_evtfd, 1);
+			eventfd_signal(mdev_state->msi_evtfd);
 	} else if (is_intx(mdev_state)) {
 		if (mdev_state->intx_evtfd && !mdev_state->intx_mask) {
-			eventfd_signal(mdev_state->intx_evtfd, 1);
+			eventfd_signal(mdev_state->intx_evtfd);
 			mdev_state->intx_mask = true;
 		}
 	}
diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 2fe6f2828d37..16c750bb95fa 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -143,6 +143,8 @@ KBUILD_CFLAGS += $(call cc-disable-warning, pointer-to-enum-cast)
 KBUILD_CFLAGS += -Wno-tautological-constant-out-of-range-compare
 KBUILD_CFLAGS += $(call cc-disable-warning, unaligned-access)
 KBUILD_CFLAGS += $(call cc-disable-warning, cast-function-type-strict)
+KBUILD_CFLAGS += -Wno-enum-compare-conditional
+KBUILD_CFLAGS += -Wno-enum-enum-conversion
 endif
 
 endif
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 898358f57fa0..6788e73b6681 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -33,6 +33,18 @@
 #include "ruleset.h"
 #include "setup.h"
 
+static bool is_initialized(void)
+{
+	if (likely(landlock_initialized))
+		return true;
+
+	pr_warn_once(
+		"Disabled but requested by user space. "
+		"You should enable Landlock at boot time: "
+		"https://docs.kernel.org/userspace-api/landlock.html#boot-time-configuration\n");
+	return false;
+}
+
 /**
  * copy_min_struct_from_user - Safe future-proof argument copying
  *
@@ -173,7 +185,7 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 	/* Build-time checks. */
 	build_check_abi();
 
-	if (!landlock_initialized)
+	if (!is_initialized())
 		return -EOPNOTSUPP;
 
 	if (flags) {
@@ -398,7 +410,7 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 	struct landlock_ruleset *ruleset;
 	int err;
 
-	if (!landlock_initialized)
+	if (!is_initialized())
 		return -EOPNOTSUPP;
 
 	/* No flag for now. */
@@ -458,7 +470,7 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	struct landlock_cred_security *new_llcred;
 	int err;
 
-	if (!landlock_initialized)
+	if (!is_initialized())
 		return -EOPNOTSUPP;
 
 	/*
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 1f1ea8529421..e1e297deb02e 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1312,7 +1312,8 @@ static int smack_inode_setxattr(struct mnt_idmap *idmap,
 		check_star = 1;
 	} else if (strcmp(name, XATTR_NAME_SMACKTRANSMUTE) == 0) {
 		check_priv = 1;
-		if (size != TRANS_TRUE_SIZE ||
+		if (!S_ISDIR(d_backing_inode(dentry)->i_mode) ||
+		    size != TRANS_TRUE_SIZE ||
 		    strncmp(value, TRANS_TRUE, TRANS_TRUE_SIZE) != 0)
 			rc = -EINVAL;
 	} else
@@ -2853,6 +2854,15 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 	if (value == NULL || size > SMK_LONGLABEL || size == 0)
 		return -EINVAL;
 
+	if (strcmp(name, XATTR_SMACK_TRANSMUTE) == 0) {
+		if (!S_ISDIR(inode->i_mode) || size != TRANS_TRUE_SIZE ||
+		    strncmp(value, TRANS_TRUE, TRANS_TRUE_SIZE) != 0)
+			return -EINVAL;
+
+		nsp->smk_flags |= SMK_INODE_TRANSMUTE;
+		return 0;
+	}
+
 	skp = smk_import_entry(value, size);
 	if (IS_ERR(skp))
 		return PTR_ERR(skp);
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 0c746613c5ae..27be1feb8c53 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10045,6 +10045,10 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8c70, "HP EliteBook 835 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c71, "HP EliteBook 845 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c72, "HP EliteBook 865 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8c8a, "HP EliteBook 630", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8c8c, "HP EliteBook 660", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8c90, "HP EliteBook 640", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8c91, "HP EliteBook 660", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c96, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8c97, "HP ZBook", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8ca1, "HP ZBook Power", ALC236_FIXUP_HP_GPIO_LED),
@@ -11046,6 +11050,8 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
  *   at most one tbl is allowed to define for the same vendor and same codec
  */
 static const struct snd_hda_pin_quirk alc269_fallback_pin_fixup_tbl[] = {
+	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1025, "Acer", ALC2XX_FIXUP_HEADSET_MIC,
+		{0x19, 0x40000000}),
 	SND_HDA_PIN_QUIRK(0x10ec0289, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
 		{0x19, 0x40000000},
 		{0x1b, 0x40000000}),
@@ -11735,8 +11741,7 @@ static void alc897_hp_automute_hook(struct hda_codec *codec,
 
 	snd_hda_gen_hp_automute(codec, jack);
 	vref = spec->gen.hp_jack_present ? (PIN_HP | AC_PINCTL_VREF_100) : PIN_HP;
-	snd_hda_codec_write(codec, 0x1b, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
-			    vref);
+	snd_hda_set_pin_ctl(codec, 0x1b, vref);
 }
 
 static void alc897_fixup_lenovo_headset_mic(struct hda_codec *codec,
@@ -11745,6 +11750,10 @@ static void alc897_fixup_lenovo_headset_mic(struct hda_codec *codec,
 	struct alc_spec *spec = codec->spec;
 	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
 		spec->gen.hp_automute_hook = alc897_hp_automute_hook;
+		spec->no_shutup_pins = 1;
+	}
+	if (action == HDA_FIXUP_ACT_PROBE) {
+		snd_hda_set_pin_ctl_cache(codec, 0x1a, PIN_IN | AC_PINCTL_VREF_100);
 	}
 }
 
diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 5179b69e403a..9f3dc13a3b6a 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -71,7 +71,7 @@ struct tas2781_hda {
 	struct snd_kcontrol *dsp_prog_ctl;
 	struct snd_kcontrol *dsp_conf_ctl;
 	struct snd_kcontrol *prof_ctl;
-	struct snd_kcontrol *snd_ctls[3];
+	struct snd_kcontrol *snd_ctls[2];
 };
 
 static int tas2781_get_i2c_res(struct acpi_resource *ares, void *data)
@@ -179,8 +179,12 @@ static int tasdevice_get_profile_id(struct snd_kcontrol *kcontrol,
 {
 	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
 
+	mutex_lock(&tas_priv->codec_lock);
+
 	ucontrol->value.integer.value[0] = tas_priv->rcabin.profile_cfg_id;
 
+	mutex_unlock(&tas_priv->codec_lock);
+
 	return 0;
 }
 
@@ -194,11 +198,15 @@ static int tasdevice_set_profile_id(struct snd_kcontrol *kcontrol,
 
 	val = clamp(nr_profile, 0, max);
 
+	mutex_lock(&tas_priv->codec_lock);
+
 	if (tas_priv->rcabin.profile_cfg_id != val) {
 		tas_priv->rcabin.profile_cfg_id = val;
 		ret = 1;
 	}
 
+	mutex_unlock(&tas_priv->codec_lock);
+
 	return ret;
 }
 
@@ -235,8 +243,12 @@ static int tasdevice_program_get(struct snd_kcontrol *kcontrol,
 {
 	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
 
+	mutex_lock(&tas_priv->codec_lock);
+
 	ucontrol->value.integer.value[0] = tas_priv->cur_prog;
 
+	mutex_unlock(&tas_priv->codec_lock);
+
 	return 0;
 }
 
@@ -251,11 +263,15 @@ static int tasdevice_program_put(struct snd_kcontrol *kcontrol,
 
 	val = clamp(nr_program, 0, max);
 
+	mutex_lock(&tas_priv->codec_lock);
+
 	if (tas_priv->cur_prog != val) {
 		tas_priv->cur_prog = val;
 		ret = 1;
 	}
 
+	mutex_unlock(&tas_priv->codec_lock);
+
 	return ret;
 }
 
@@ -264,8 +280,12 @@ static int tasdevice_config_get(struct snd_kcontrol *kcontrol,
 {
 	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
 
+	mutex_lock(&tas_priv->codec_lock);
+
 	ucontrol->value.integer.value[0] = tas_priv->cur_conf;
 
+	mutex_unlock(&tas_priv->codec_lock);
+
 	return 0;
 }
 
@@ -280,33 +300,16 @@ static int tasdevice_config_put(struct snd_kcontrol *kcontrol,
 
 	val = clamp(nr_config, 0, max);
 
+	mutex_lock(&tas_priv->codec_lock);
+
 	if (tas_priv->cur_conf != val) {
 		tas_priv->cur_conf = val;
 		ret = 1;
 	}
 
-	return ret;
-}
+	mutex_unlock(&tas_priv->codec_lock);
 
-/*
- * tas2781_digital_getvol - get the volum control
- * @kcontrol: control pointer
- * @ucontrol: User data
- * Customer Kcontrol for tas2781 is primarily for regmap booking, paging
- * depends on internal regmap mechanism.
- * tas2781 contains book and page two-level register map, especially
- * book switching will set the register BXXP00R7F, after switching to the
- * correct book, then leverage the mechanism for paging to access the
- * register.
- */
-static int tas2781_digital_getvol(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
-
-	return tasdevice_digital_getvol(tas_priv, ucontrol, mc);
+	return ret;
 }
 
 static int tas2781_amp_getvol(struct snd_kcontrol *kcontrol,
@@ -315,19 +318,15 @@ static int tas2781_amp_getvol(struct snd_kcontrol *kcontrol,
 	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
+	int ret;
 
-	return tasdevice_amp_getvol(tas_priv, ucontrol, mc);
-}
+	mutex_lock(&tas_priv->codec_lock);
 
-static int tas2781_digital_putvol(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
+	ret = tasdevice_amp_getvol(tas_priv, ucontrol, mc);
+
+	mutex_unlock(&tas_priv->codec_lock);
 
-	/* The check of the given value is in tasdevice_digital_putvol. */
-	return tasdevice_digital_putvol(tas_priv, ucontrol, mc);
+	return ret;
 }
 
 static int tas2781_amp_putvol(struct snd_kcontrol *kcontrol,
@@ -336,9 +335,16 @@ static int tas2781_amp_putvol(struct snd_kcontrol *kcontrol,
 	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
+	int ret;
+
+	mutex_lock(&tas_priv->codec_lock);
 
 	/* The check of the given value is in tasdevice_amp_putvol. */
-	return tasdevice_amp_putvol(tas_priv, ucontrol, mc);
+	ret = tasdevice_amp_putvol(tas_priv, ucontrol, mc);
+
+	mutex_unlock(&tas_priv->codec_lock);
+
+	return ret;
 }
 
 static int tas2781_force_fwload_get(struct snd_kcontrol *kcontrol,
@@ -346,10 +352,14 @@ static int tas2781_force_fwload_get(struct snd_kcontrol *kcontrol,
 {
 	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
 
+	mutex_lock(&tas_priv->codec_lock);
+
 	ucontrol->value.integer.value[0] = (int)tas_priv->force_fwload_status;
 	dev_dbg(tas_priv->dev, "%s : Force FWload %s\n", __func__,
 			tas_priv->force_fwload_status ? "ON" : "OFF");
 
+	mutex_unlock(&tas_priv->codec_lock);
+
 	return 0;
 }
 
@@ -359,6 +369,8 @@ static int tas2781_force_fwload_put(struct snd_kcontrol *kcontrol,
 	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
 	bool change, val = (bool)ucontrol->value.integer.value[0];
 
+	mutex_lock(&tas_priv->codec_lock);
+
 	if (tas_priv->force_fwload_status == val)
 		change = false;
 	else {
@@ -368,6 +380,8 @@ static int tas2781_force_fwload_put(struct snd_kcontrol *kcontrol,
 	dev_dbg(tas_priv->dev, "%s : Force FWload %s\n", __func__,
 		tas_priv->force_fwload_status ? "ON" : "OFF");
 
+	mutex_unlock(&tas_priv->codec_lock);
+
 	return change;
 }
 
@@ -375,9 +389,6 @@ static const struct snd_kcontrol_new tas2781_snd_controls[] = {
 	ACARD_SINGLE_RANGE_EXT_TLV("Speaker Analog Gain", TAS2781_AMP_LEVEL,
 		1, 0, 20, 0, tas2781_amp_getvol,
 		tas2781_amp_putvol, amp_vol_tlv),
-	ACARD_SINGLE_RANGE_EXT_TLV("Speaker Digital Gain", TAS2781_DVC_LVL,
-		0, 0, 200, 1, tas2781_digital_getvol,
-		tas2781_digital_putvol, dvc_tlv),
 	ACARD_SINGLE_BOOL_EXT("Speaker Force Firmware Load", 0,
 		tas2781_force_fwload_get, tas2781_force_fwload_put),
 };
diff --git a/sound/sh/aica.c b/sound/sh/aica.c
index 320ac792c7fe..3182c634464d 100644
--- a/sound/sh/aica.c
+++ b/sound/sh/aica.c
@@ -278,7 +278,8 @@ static void run_spu_dma(struct work_struct *work)
 		dreamcastcard->clicks++;
 		if (unlikely(dreamcastcard->clicks >= AICA_PERIOD_NUMBER))
 			dreamcastcard->clicks %= AICA_PERIOD_NUMBER;
-		mod_timer(&dreamcastcard->timer, jiffies + 1);
+		if (snd_pcm_running(dreamcastcard->substream))
+			mod_timer(&dreamcastcard->timer, jiffies + 1);
 	}
 }
 
@@ -290,6 +291,8 @@ static void aica_period_elapsed(struct timer_list *t)
 	/*timer function - so cannot sleep */
 	int play_period;
 	struct snd_pcm_runtime *runtime;
+	if (!snd_pcm_running(substream))
+		return;
 	runtime = substream->runtime;
 	dreamcastcard = substream->pcm->private_data;
 	/* Have we played out an additional period? */
@@ -350,12 +353,19 @@ static int snd_aicapcm_pcm_open(struct snd_pcm_substream
 	return 0;
 }
 
+static int snd_aicapcm_pcm_sync_stop(struct snd_pcm_substream *substream)
+{
+	struct snd_card_aica *dreamcastcard = substream->pcm->private_data;
+
+	del_timer_sync(&dreamcastcard->timer);
+	cancel_work_sync(&dreamcastcard->spu_dma_work);
+	return 0;
+}
+
 static int snd_aicapcm_pcm_close(struct snd_pcm_substream
 				 *substream)
 {
 	struct snd_card_aica *dreamcastcard = substream->pcm->private_data;
-	flush_work(&(dreamcastcard->spu_dma_work));
-	del_timer(&dreamcastcard->timer);
 	dreamcastcard->substream = NULL;
 	kfree(dreamcastcard->channel);
 	spu_disable();
@@ -401,6 +411,7 @@ static const struct snd_pcm_ops snd_aicapcm_playback_ops = {
 	.prepare = snd_aicapcm_pcm_prepare,
 	.trigger = snd_aicapcm_pcm_trigger,
 	.pointer = snd_aicapcm_pcm_pointer,
+	.sync_stop = snd_aicapcm_pcm_sync_stop,
 };
 
 /* TO DO: set up to handle more than one pcm instance */
diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 90360f8b3e81..1d1452c29ed0 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -199,13 +199,6 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21HY"),
 		}
 	},
-	{
-		.driver_data = &acp6x_card,
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "21J2"),
-		}
-	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
index 72535f00572f..72ea363d434d 100644
--- a/tools/include/linux/btf_ids.h
+++ b/tools/include/linux/btf_ids.h
@@ -3,6 +3,8 @@
 #ifndef _LINUX_BTF_IDS_H
 #define _LINUX_BTF_IDS_H
 
+#include <linux/types.h> /* for u32 */
+
 struct btf_id_set {
 	u32 cnt;
 	u32 ids[];
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 8d7c31bd2ebf..cd64ae44ccbd 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1027,8 +1027,8 @@ static int perf_top__start_counters(struct perf_top *top)
 
 	evlist__for_each_entry(evlist, counter) {
 try_again:
-		if (evsel__open(counter, top->evlist->core.user_requested_cpus,
-				     top->evlist->core.threads) < 0) {
+		if (evsel__open(counter, counter->core.cpus,
+				counter->core.threads) < 0) {
 
 			/*
 			 * Specially handle overwrite fall back.
diff --git a/tools/testing/selftests/mm/gup_test.c b/tools/testing/selftests/mm/gup_test.c
index ec2229136384..18a49c70d4c6 100644
--- a/tools/testing/selftests/mm/gup_test.c
+++ b/tools/testing/selftests/mm/gup_test.c
@@ -50,39 +50,41 @@ static char *cmd_to_str(unsigned long cmd)
 void *gup_thread(void *data)
 {
 	struct gup_test gup = *(struct gup_test *)data;
-	int i;
+	int i, status;
 
 	/* Only report timing information on the *_BENCHMARK commands: */
 	if ((cmd == PIN_FAST_BENCHMARK) || (cmd == GUP_FAST_BENCHMARK) ||
 	     (cmd == PIN_LONGTERM_BENCHMARK)) {
 		for (i = 0; i < repeats; i++) {
 			gup.size = size;
-			if (ioctl(gup_fd, cmd, &gup))
-				perror("ioctl"), exit(1);
+			status = ioctl(gup_fd, cmd, &gup);
+			if (status)
+				break;
 
 			pthread_mutex_lock(&print_mutex);
-			printf("%s: Time: get:%lld put:%lld us",
-			       cmd_to_str(cmd), gup.get_delta_usec,
-			       gup.put_delta_usec);
+			ksft_print_msg("%s: Time: get:%lld put:%lld us",
+				       cmd_to_str(cmd), gup.get_delta_usec,
+				       gup.put_delta_usec);
 			if (gup.size != size)
-				printf(", truncated (size: %lld)", gup.size);
-			printf("\n");
+				ksft_print_msg(", truncated (size: %lld)", gup.size);
+			ksft_print_msg("\n");
 			pthread_mutex_unlock(&print_mutex);
 		}
 	} else {
 		gup.size = size;
-		if (ioctl(gup_fd, cmd, &gup)) {
-			perror("ioctl");
-			exit(1);
-		}
+		status = ioctl(gup_fd, cmd, &gup);
+		if (status)
+			goto return_;
 
 		pthread_mutex_lock(&print_mutex);
-		printf("%s: done\n", cmd_to_str(cmd));
+		ksft_print_msg("%s: done\n", cmd_to_str(cmd));
 		if (gup.size != size)
-			printf("Truncated (size: %lld)\n", gup.size);
+			ksft_print_msg("Truncated (size: %lld)\n", gup.size);
 		pthread_mutex_unlock(&print_mutex);
 	}
 
+return_:
+	ksft_test_result(!status, "ioctl status %d\n", status);
 	return NULL;
 }
 
@@ -170,7 +172,7 @@ int main(int argc, char **argv)
 			touch = 1;
 			break;
 		default:
-			return -1;
+			ksft_exit_fail_msg("Wrong argument\n");
 		}
 	}
 
@@ -198,11 +200,12 @@ int main(int argc, char **argv)
 		}
 	}
 
-	filed = open(file, O_RDWR|O_CREAT);
-	if (filed < 0) {
-		perror("open");
-		exit(filed);
-	}
+	ksft_print_header();
+	ksft_set_plan(nthreads);
+
+	filed = open(file, O_RDWR|O_CREAT, 0664);
+	if (filed < 0)
+		ksft_exit_fail_msg("Unable to open %s: %s\n", file, strerror(errno));
 
 	gup.nr_pages_per_call = nr_pages;
 	if (write)
@@ -213,27 +216,24 @@ int main(int argc, char **argv)
 		switch (errno) {
 		case EACCES:
 			if (getuid())
-				printf("Please run this test as root\n");
+				ksft_print_msg("Please run this test as root\n");
 			break;
 		case ENOENT:
-			if (opendir("/sys/kernel/debug") == NULL) {
-				printf("mount debugfs at /sys/kernel/debug\n");
-				break;
-			}
-			printf("check if CONFIG_GUP_TEST is enabled in kernel config\n");
+			if (opendir("/sys/kernel/debug") == NULL)
+				ksft_print_msg("mount debugfs at /sys/kernel/debug\n");
+			ksft_print_msg("check if CONFIG_GUP_TEST is enabled in kernel config\n");
 			break;
 		default:
-			perror("failed to open " GUP_TEST_FILE);
+			ksft_print_msg("failed to open %s: %s\n", GUP_TEST_FILE, strerror(errno));
 			break;
 		}
-		exit(KSFT_SKIP);
+		ksft_test_result_skip("Please run this test as root\n");
+		return ksft_exit_pass();
 	}
 
 	p = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, filed, 0);
-	if (p == MAP_FAILED) {
-		perror("mmap");
-		exit(1);
-	}
+	if (p == MAP_FAILED)
+		ksft_exit_fail_msg("mmap: %s\n", strerror(errno));
 	gup.addr = (unsigned long)p;
 
 	if (thp == 1)
@@ -264,7 +264,8 @@ int main(int argc, char **argv)
 		ret = pthread_join(tid[i], NULL);
 		assert(ret == 0);
 	}
+
 	free(tid);
 
-	return 0;
+	return ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
index cc5f144430d4..7dbfa53d93a0 100644
--- a/tools/testing/selftests/mm/soft-dirty.c
+++ b/tools/testing/selftests/mm/soft-dirty.c
@@ -137,7 +137,7 @@ static void test_mprotect(int pagemap_fd, int pagesize, bool anon)
 		if (!map)
 			ksft_exit_fail_msg("anon mmap failed\n");
 	} else {
-		test_fd = open(fname, O_RDWR | O_CREAT);
+		test_fd = open(fname, O_RDWR | O_CREAT, 0664);
 		if (test_fd < 0) {
 			ksft_test_result_skip("Test %s open() file failed\n", __func__);
 			return;
diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 0e74635c8c3d..dff3be23488b 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -253,7 +253,7 @@ void split_file_backed_thp(void)
 		goto cleanup;
 	}
 
-	fd = open(testfile, O_CREAT|O_WRONLY);
+	fd = open(testfile, O_CREAT|O_WRONLY, 0664);
 	if (fd == -1) {
 		perror("Cannot open testing file\n");
 		goto cleanup;
diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 02b89860e193..ba6777cdf423 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -17,6 +17,7 @@ bool map_shared;
 bool test_uffdio_wp = true;
 unsigned long long *count_verify;
 uffd_test_ops_t *uffd_test_ops;
+atomic_bool ready_for_fork;
 
 static int uffd_mem_fd_create(off_t mem_size, bool hugetlb)
 {
@@ -507,6 +508,8 @@ void *uffd_poll_thread(void *arg)
 	pollfd[1].fd = pipefd[cpu*2];
 	pollfd[1].events = POLLIN;
 
+	ready_for_fork = true;
+
 	for (;;) {
 		ret = poll(pollfd, 2, -1);
 		if (ret <= 0) {
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 7c4fa964c3b0..1f0d573f3067 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -32,6 +32,7 @@
 #include <inttypes.h>
 #include <stdint.h>
 #include <sys/random.h>
+#include <stdatomic.h>
 
 #include "../kselftest.h"
 #include "vm_util.h"
@@ -97,6 +98,7 @@ extern bool map_shared;
 extern bool test_uffdio_wp;
 extern unsigned long long *count_verify;
 extern volatile bool test_uffdio_copy_eexist;
+extern atomic_bool ready_for_fork;
 
 extern uffd_test_ops_t anon_uffd_test_ops;
 extern uffd_test_ops_t shmem_uffd_test_ops;
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 2c68709062da..92d51768b7be 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -770,6 +770,8 @@ static void uffd_sigbus_test_common(bool wp)
 	char c;
 	struct uffd_args args = { 0 };
 
+	ready_for_fork = false;
+
 	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
 
 	if (uffd_register(uffd, area_dst, nr_pages * page_size,
@@ -785,6 +787,9 @@ static void uffd_sigbus_test_common(bool wp)
 	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
 		err("uffd_poll_thread create");
 
+	while (!ready_for_fork)
+		; /* Wait for the poll_thread to start executing before forking */
+
 	pid = fork();
 	if (pid < 0)
 		err("fork");
@@ -824,6 +829,8 @@ static void uffd_events_test_common(bool wp)
 	char c;
 	struct uffd_args args = { 0 };
 
+	ready_for_fork = false;
+
 	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
 	if (uffd_register(uffd, area_dst, nr_pages * page_size,
 			  true, wp, false))
@@ -833,6 +840,9 @@ static void uffd_events_test_common(bool wp)
 	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
 		err("uffd_poll_thread create");
 
+	while (!ready_for_fork)
+		; /* Wait for the poll_thread to start executing before forking */
+
 	pid = fork();
 	if (pid < 0)
 		err("fork");
@@ -1219,7 +1229,8 @@ uffd_test_case_t uffd_tests[] = {
 		.uffd_fn = uffd_sigbus_wp_test,
 		.mem_targets = MEM_ALL,
 		.uffd_feature_required = UFFD_FEATURE_SIGBUS |
-		UFFD_FEATURE_EVENT_FORK | UFFD_FEATURE_PAGEFAULT_FLAG_WP,
+		UFFD_FEATURE_EVENT_FORK | UFFD_FEATURE_PAGEFAULT_FLAG_WP |
+		UFFD_FEATURE_WP_HUGETLBFS_SHMEM,
 	},
 	{
 		.name = "events",
diff --git a/tools/testing/selftests/mqueue/setting b/tools/testing/selftests/mqueue/setting
new file mode 100644
index 000000000000..a953c96aa16e
--- /dev/null
+++ b/tools/testing/selftests/mqueue/setting
@@ -0,0 +1 @@
+timeout=180
diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 4d8c59be1b30..7f89623f1080 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -69,7 +69,7 @@ __chk_nr()
 		else
 			echo "[ fail ] expected $expected found $nr"
 			mptcp_lib_result_fail "${msg}"
-			ret=$test_cnt
+			ret=${KSFT_FAIL}
 		fi
 	else
 		echo "[  ok  ]"
@@ -115,11 +115,11 @@ wait_msk_nr()
 	if [ $i -ge $timeout ]; then
 		echo "[ fail ] timeout while expecting $expected max $max last $nr"
 		mptcp_lib_result_fail "${msg} # timeout"
-		ret=$test_cnt
+		ret=${KSFT_FAIL}
 	elif [ $nr != $expected ]; then
 		echo "[ fail ] expected $expected found $nr"
 		mptcp_lib_result_fail "${msg} # unexpected result"
-		ret=$test_cnt
+		ret=${KSFT_FAIL}
 	else
 		echo "[  ok  ]"
 		mptcp_lib_result_pass "${msg}"
diff --git a/tools/testing/selftests/wireguard/qemu/arch/riscv32.config b/tools/testing/selftests/wireguard/qemu/arch/riscv32.config
index 2fc36efb166d..a7f8e8a95625 100644
--- a/tools/testing/selftests/wireguard/qemu/arch/riscv32.config
+++ b/tools/testing/selftests/wireguard/qemu/arch/riscv32.config
@@ -3,6 +3,7 @@ CONFIG_ARCH_RV32I=y
 CONFIG_MMU=y
 CONFIG_FPU=y
 CONFIG_SOC_VIRT=y
+CONFIG_RISCV_ISA_FALLBACK=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
diff --git a/tools/testing/selftests/wireguard/qemu/arch/riscv64.config b/tools/testing/selftests/wireguard/qemu/arch/riscv64.config
index dc266f3b1915..daeb3e5e0965 100644
--- a/tools/testing/selftests/wireguard/qemu/arch/riscv64.config
+++ b/tools/testing/selftests/wireguard/qemu/arch/riscv64.config
@@ -2,6 +2,7 @@ CONFIG_ARCH_RV64I=y
 CONFIG_MMU=y
 CONFIG_FPU=y
 CONFIG_SOC_VIRT=y
+CONFIG_RISCV_ISA_FALLBACK=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
diff --git a/virt/kvm/async_pf.c b/virt/kvm/async_pf.c
index e033c79d528e..28658b9e0d96 100644
--- a/virt/kvm/async_pf.c
+++ b/virt/kvm/async_pf.c
@@ -87,7 +87,27 @@ static void async_pf_execute(struct work_struct *work)
 	__kvm_vcpu_wake_up(vcpu);
 
 	mmput(mm);
-	kvm_put_kvm(vcpu->kvm);
+}
+
+static void kvm_flush_and_free_async_pf_work(struct kvm_async_pf *work)
+{
+	/*
+	 * The async #PF is "done", but KVM must wait for the work item itself,
+	 * i.e. async_pf_execute(), to run to completion.  If KVM is a module,
+	 * KVM must ensure *no* code owned by the KVM (the module) can be run
+	 * after the last call to module_put().  Note, flushing the work item
+	 * is always required when the item is taken off the completion queue.
+	 * E.g. even if the vCPU handles the item in the "normal" path, the VM
+	 * could be terminated before async_pf_execute() completes.
+	 *
+	 * Wake all events skip the queue and go straight done, i.e. don't
+	 * need to be flushed (but sanity check that the work wasn't queued).
+	 */
+	if (work->wakeup_all)
+		WARN_ON_ONCE(work->work.func);
+	else
+		flush_work(&work->work);
+	kmem_cache_free(async_pf_cache, work);
 }
 
 void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu)
@@ -114,7 +134,6 @@ void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu)
 #else
 		if (cancel_work_sync(&work->work)) {
 			mmput(work->mm);
-			kvm_put_kvm(vcpu->kvm); /* == work->vcpu->kvm */
 			kmem_cache_free(async_pf_cache, work);
 		}
 #endif
@@ -126,7 +145,10 @@ void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu)
 			list_first_entry(&vcpu->async_pf.done,
 					 typeof(*work), link);
 		list_del(&work->link);
-		kmem_cache_free(async_pf_cache, work);
+
+		spin_unlock(&vcpu->async_pf.lock);
+		kvm_flush_and_free_async_pf_work(work);
+		spin_lock(&vcpu->async_pf.lock);
 	}
 	spin_unlock(&vcpu->async_pf.lock);
 
@@ -151,7 +173,7 @@ void kvm_check_async_pf_completion(struct kvm_vcpu *vcpu)
 
 		list_del(&work->queue);
 		vcpu->async_pf.queued--;
-		kmem_cache_free(async_pf_cache, work);
+		kvm_flush_and_free_async_pf_work(work);
 	}
 }
 
@@ -186,7 +208,6 @@ bool kvm_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	work->arch = *arch;
 	work->mm = current->mm;
 	mmget(work->mm);
-	kvm_get_kvm(work->vcpu->kvm);
 
 	INIT_WORK(&work->work, async_pf_execute);
 
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 89912a17f5d5..c0e230f4c3e9 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -61,7 +61,7 @@ static void irqfd_resampler_notify(struct kvm_kernel_irqfd_resampler *resampler)
 
 	list_for_each_entry_srcu(irqfd, &resampler->list, resampler_link,
 				 srcu_read_lock_held(&resampler->kvm->irq_srcu))
-		eventfd_signal(irqfd->resamplefd, 1);
+		eventfd_signal(irqfd->resamplefd);
 }
 
 /*
@@ -786,7 +786,7 @@ ioeventfd_write(struct kvm_vcpu *vcpu, struct kvm_io_device *this, gpa_t addr,
 	if (!ioeventfd_in_range(p, addr, len, val))
 		return -EOPNOTSUPP;
 
-	eventfd_signal(p->eventfd, 1);
+	eventfd_signal(p->eventfd);
 	return 0;
 }
 

