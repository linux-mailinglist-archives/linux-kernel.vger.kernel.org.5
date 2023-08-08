Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99439774ADE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbjHHUgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbjHHUgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:36:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B3EBB;
        Tue,  8 Aug 2023 11:55:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73D2D6233A;
        Tue,  8 Aug 2023 18:55:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEEDC433C8;
        Tue,  8 Aug 2023 18:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691520903;
        bh=cGq7UyuItI3LQyNZ/WZHDF6Zu/PGPeSmYmwaeoufJro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fDa/a3BVC/fcx0sTVaHbjGKF4nLq1S1MWOqiMfN6pqXePTNOKetq/Q4DHgoQJsNgn
         UKy/R8RJAQVtvBaEt+LZfgClhLa1xs3IA9jUkZwXCeBCSKaTUGiFA7wKlgEsNZkP7Z
         F98aFaYJs1+7iqNHXnHLxtmhVgrpub4f4iW029g8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.19.290
Date:   Tue,  8 Aug 2023 20:54:51 +0200
Message-ID: <2023080834-slam-igloo-9da4@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023080833-swivel-jokingly-be9d@gregkh>
References: <2023080833-swivel-jokingly-be9d@gregkh>
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

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index dee993602c31..a531b208902f 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -472,16 +472,17 @@ Description:	information about CPUs heterogeneity.
 		cpu_capacity: capacity of cpu#.
 
 What:		/sys/devices/system/cpu/vulnerabilities
+		/sys/devices/system/cpu/vulnerabilities/gather_data_sampling
+		/sys/devices/system/cpu/vulnerabilities/itlb_multihit
+		/sys/devices/system/cpu/vulnerabilities/l1tf
+		/sys/devices/system/cpu/vulnerabilities/mds
 		/sys/devices/system/cpu/vulnerabilities/meltdown
+		/sys/devices/system/cpu/vulnerabilities/mmio_stale_data
+		/sys/devices/system/cpu/vulnerabilities/spec_store_bypass
 		/sys/devices/system/cpu/vulnerabilities/spectre_v1
 		/sys/devices/system/cpu/vulnerabilities/spectre_v2
-		/sys/devices/system/cpu/vulnerabilities/spec_store_bypass
-		/sys/devices/system/cpu/vulnerabilities/l1tf
-		/sys/devices/system/cpu/vulnerabilities/mds
 		/sys/devices/system/cpu/vulnerabilities/srbds
 		/sys/devices/system/cpu/vulnerabilities/tsx_async_abort
-		/sys/devices/system/cpu/vulnerabilities/itlb_multihit
-		/sys/devices/system/cpu/vulnerabilities/mmio_stale_data
 Date:		January 2018
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
 Description:	Information about CPU vulnerabilities
diff --git a/Documentation/admin-guide/hw-vuln/gather_data_sampling.rst b/Documentation/admin-guide/hw-vuln/gather_data_sampling.rst
new file mode 100644
index 000000000000..264bfa937f7d
--- /dev/null
+++ b/Documentation/admin-guide/hw-vuln/gather_data_sampling.rst
@@ -0,0 +1,109 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+GDS - Gather Data Sampling
+==========================
+
+Gather Data Sampling is a hardware vulnerability which allows unprivileged
+speculative access to data which was previously stored in vector registers.
+
+Problem
+-------
+When a gather instruction performs loads from memory, different data elements
+are merged into the destination vector register. However, when a gather
+instruction that is transiently executed encounters a fault, stale data from
+architectural or internal vector registers may get transiently forwarded to the
+destination vector register instead. This will allow a malicious attacker to
+infer stale data using typical side channel techniques like cache timing
+attacks. GDS is a purely sampling-based attack.
+
+The attacker uses gather instructions to infer the stale vector register data.
+The victim does not need to do anything special other than use the vector
+registers. The victim does not need to use gather instructions to be
+vulnerable.
+
+Because the buffers are shared between Hyper-Threads cross Hyper-Thread attacks
+are possible.
+
+Attack scenarios
+----------------
+Without mitigation, GDS can infer stale data across virtually all
+permission boundaries:
+
+	Non-enclaves can infer SGX enclave data
+	Userspace can infer kernel data
+	Guests can infer data from hosts
+	Guest can infer guest from other guests
+	Users can infer data from other users
+
+Because of this, it is important to ensure that the mitigation stays enabled in
+lower-privilege contexts like guests and when running outside SGX enclaves.
+
+The hardware enforces the mitigation for SGX. Likewise, VMMs should  ensure
+that guests are not allowed to disable the GDS mitigation. If a host erred and
+allowed this, a guest could theoretically disable GDS mitigation, mount an
+attack, and re-enable it.
+
+Mitigation mechanism
+--------------------
+This issue is mitigated in microcode. The microcode defines the following new
+bits:
+
+ ================================   ===   ============================
+ IA32_ARCH_CAPABILITIES[GDS_CTRL]   R/O   Enumerates GDS vulnerability
+                                          and mitigation support.
+ IA32_ARCH_CAPABILITIES[GDS_NO]     R/O   Processor is not vulnerable.
+ IA32_MCU_OPT_CTRL[GDS_MITG_DIS]    R/W   Disables the mitigation
+                                          0 by default.
+ IA32_MCU_OPT_CTRL[GDS_MITG_LOCK]   R/W   Locks GDS_MITG_DIS=0. Writes
+                                          to GDS_MITG_DIS are ignored
+                                          Can't be cleared once set.
+ ================================   ===   ============================
+
+GDS can also be mitigated on systems that don't have updated microcode by
+disabling AVX. This can be done by setting gather_data_sampling="force" or
+"clearcpuid=avx" on the kernel command-line.
+
+If used, these options will disable AVX use by turning off XSAVE YMM support.
+However, the processor will still enumerate AVX support.  Userspace that
+does not follow proper AVX enumeration to check both AVX *and* XSAVE YMM
+support will break.
+
+Mitigation control on the kernel command line
+---------------------------------------------
+The mitigation can be disabled by setting "gather_data_sampling=off" or
+"mitigations=off" on the kernel command line. Not specifying either will default
+to the mitigation being enabled. Specifying "gather_data_sampling=force" will
+use the microcode mitigation when available or disable AVX on affected systems
+where the microcode hasn't been updated to include the mitigation.
+
+GDS System Information
+------------------------
+The kernel provides vulnerability status information through sysfs. For
+GDS this can be accessed by the following sysfs file:
+
+/sys/devices/system/cpu/vulnerabilities/gather_data_sampling
+
+The possible values contained in this file are:
+
+ ============================== =============================================
+ Not affected                   Processor not vulnerable.
+ Vulnerable                     Processor vulnerable and mitigation disabled.
+ Vulnerable: No microcode       Processor vulnerable and microcode is missing
+                                mitigation.
+ Mitigation: AVX disabled,
+ no microcode                   Processor is vulnerable and microcode is missing
+                                mitigation. AVX disabled as mitigation.
+ Mitigation: Microcode          Processor is vulnerable and mitigation is in
+                                effect.
+ Mitigation: Microcode (locked) Processor is vulnerable and mitigation is in
+                                effect and cannot be disabled.
+ Unknown: Dependent on
+ hypervisor status              Running on a virtual guest processor that is
+                                affected but with no way to know if host
+                                processor is mitigated or vulnerable.
+ ============================== =============================================
+
+GDS Default mitigation
+----------------------
+The updated microcode will enable the mitigation by default. The kernel's
+default action is to leave the mitigation enabled.
diff --git a/Documentation/admin-guide/hw-vuln/index.rst b/Documentation/admin-guide/hw-vuln/index.rst
index 2adec1e6520a..245468b0f2be 100644
--- a/Documentation/admin-guide/hw-vuln/index.rst
+++ b/Documentation/admin-guide/hw-vuln/index.rst
@@ -16,3 +16,4 @@ are configurable at compile, boot or run time.
    multihit.rst
    special-register-buffer-data-sampling.rst
    processor_mmio_stale_data.rst
+   gather_data_sampling.rst
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 42ddd78ea001..84c34f7e8984 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1290,6 +1290,26 @@
 			Format: off | on
 			default: on
 
+	gather_data_sampling=
+			[X86,INTEL] Control the Gather Data Sampling (GDS)
+			mitigation.
+
+			Gather Data Sampling is a hardware vulnerability which
+			allows unprivileged speculative access to data which was
+			previously stored in vector registers.
+
+			This issue is mitigated by default in updated microcode.
+			The mitigation may have a performance impact but can be
+			disabled. On systems without the microcode mitigation
+			disabling AVX serves as a mitigation.
+
+			force:	Disable AVX to mitigate systems without
+				microcode mitigation. No effect if the microcode
+				mitigation is present. Known to cause crashes in
+				userspace with buggy AVX enumeration.
+
+			off:    Disable GDS mitigation.
+
 	gcov_persist=	[GCOV] When non-zero (default), profiling data for
 			kernel modules is saved and remains accessible via
 			debugfs, even when the module is unloaded/reloaded.
@@ -2555,22 +2575,23 @@
 				Disable all optional CPU mitigations.  This
 				improves system performance, but it may also
 				expose users to several CPU vulnerabilities.
-				Equivalent to: nopti [X86,PPC]
+				Equivalent to: gather_data_sampling=off [X86]
 					       kpti=0 [ARM64]
-					       nospectre_v1 [PPC]
+					       kvm.nx_huge_pages=off [X86]
+					       l1tf=off [X86]
+					       mds=off [X86]
+					       mmio_stale_data=off [X86]
+					       no_entry_flush [PPC]
+					       no_uaccess_flush [PPC]
 					       nobp=0 [S390]
+					       nopti [X86,PPC]
+					       nospectre_v1 [PPC]
 					       nospectre_v1 [X86]
 					       nospectre_v2 [X86,PPC,S390,ARM64]
-					       spectre_v2_user=off [X86]
 					       spec_store_bypass_disable=off [X86,PPC]
+					       spectre_v2_user=off [X86]
 					       ssbd=force-off [ARM64]
-					       l1tf=off [X86]
-					       mds=off [X86]
 					       tsx_async_abort=off [X86]
-					       kvm.nx_huge_pages=off [X86]
-					       no_entry_flush [PPC]
-					       no_uaccess_flush [PPC]
-					       mmio_stale_data=off [X86]
 
 				Exceptions:
 					       This does not have any effect on
diff --git a/Makefile b/Makefile
index 9af8ec084269..5cd8768fc083 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 289
+SUBLEVEL = 290
 EXTRAVERSION =
 NAME = "People's Front"
 
diff --git a/arch/Kconfig b/arch/Kconfig
index dd71b34fe4f5..6e77e795517d 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -249,6 +249,9 @@ config ARCH_HAS_FORTIFY_SOURCE
 config ARCH_HAS_SET_MEMORY
 	bool
 
+config ARCH_HAS_CPU_FINALIZE_INIT
+	bool
+
 # Select if arch init_task must go in the __init_task_data section
 config ARCH_TASK_STRUCT_ON_STACK
        bool
diff --git a/arch/alpha/include/asm/bugs.h b/arch/alpha/include/asm/bugs.h
deleted file mode 100644
index 78030d1c7e7e..000000000000
--- a/arch/alpha/include/asm/bugs.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- *  include/asm-alpha/bugs.h
- *
- *  Copyright (C) 1994  Linus Torvalds
- */
-
-/*
- * This is included by init/main.c to check for architecture-dependent bugs.
- *
- * Needs:
- *	void check_bugs(void);
- */
-
-/*
- * I don't know of any alpha bugs yet.. Nice chip
- */
-
-static void check_bugs(void)
-{
-}
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 41bde0e62e90..9b075719a7d9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -4,6 +4,7 @@ config ARM
 	default y
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_DISCARD_MEMBLOCK if !HAVE_ARCH_PFN_VALID && !KEXEC
+	select ARCH_HAS_CPU_FINALIZE_INIT if MMU
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ELF_RANDOMIZE
diff --git a/arch/arm/include/asm/bugs.h b/arch/arm/include/asm/bugs.h
index 73a99c72a930..21b6f742b3ba 100644
--- a/arch/arm/include/asm/bugs.h
+++ b/arch/arm/include/asm/bugs.h
@@ -1,6 +1,4 @@
 /*
- *  arch/arm/include/asm/bugs.h
- *
  *  Copyright (C) 1995-2003 Russell King
  *
  * This program is free software; you can redistribute it and/or modify
@@ -13,10 +11,8 @@
 extern void check_writebuffer_bugs(void);
 
 #ifdef CONFIG_MMU
-extern void check_bugs(void);
 extern void check_other_bugs(void);
 #else
-#define check_bugs() do { } while (0)
 #define check_other_bugs() do { } while (0)
 #endif
 
diff --git a/arch/arm/kernel/bugs.c b/arch/arm/kernel/bugs.c
index d41d3598e5e5..e9fc25350784 100644
--- a/arch/arm/kernel/bugs.c
+++ b/arch/arm/kernel/bugs.c
@@ -1,5 +1,6 @@
 // SPDX-Identifier: GPL-2.0
 #include <linux/init.h>
+#include <linux/cpu.h>
 #include <asm/bugs.h>
 #include <asm/proc-fns.h>
 
@@ -11,7 +12,7 @@ void check_other_bugs(void)
 #endif
 }
 
-void __init check_bugs(void)
+void __init arch_cpu_finalize_init(void)
 {
 	check_writebuffer_bugs();
 	check_other_bugs();
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 0d56b19b7511..58f63446c657 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -8,6 +8,7 @@ menu "Processor type and features"
 
 config IA64
 	bool
+	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select PCI if (!IA64_HP_SIM)
diff --git a/arch/ia64/include/asm/bugs.h b/arch/ia64/include/asm/bugs.h
deleted file mode 100644
index 0d6b9bded56c..000000000000
--- a/arch/ia64/include/asm/bugs.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * This is included by init/main.c to check for architecture-dependent bugs.
- *
- * Needs:
- *	void check_bugs(void);
- *
- * Based on <asm-alpha/bugs.h>.
- *
- * Modified 1998, 1999, 2003
- *	David Mosberger-Tang <davidm@hpl.hp.com>,  Hewlett-Packard Co.
- */
-#ifndef _ASM_IA64_BUGS_H
-#define _ASM_IA64_BUGS_H
-
-#include <asm/processor.h>
-
-extern void check_bugs (void);
-
-#endif /* _ASM_IA64_BUGS_H */
diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
index 0e6c2d9fb498..41af687bc1dc 100644
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -1050,8 +1050,7 @@ cpu_init (void)
 	platform_cpu_init();
 }
 
-void __init
-check_bugs (void)
+void __init arch_cpu_finalize_init(void)
 {
 	ia64_patch_mckinley_e9((unsigned long) __start___mckinley_e9_bundles,
 			       (unsigned long) __end___mckinley_e9_bundles);
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 070553791e97..05b7e4cbb16e 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -2,6 +2,7 @@
 config M68K
 	bool
 	default y
+	select ARCH_HAS_CPU_FINALIZE_INIT if MMU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if HAS_DMA
 	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
diff --git a/arch/m68k/include/asm/bugs.h b/arch/m68k/include/asm/bugs.h
deleted file mode 100644
index 745530651e0b..000000000000
--- a/arch/m68k/include/asm/bugs.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *  include/asm-m68k/bugs.h
- *
- *  Copyright (C) 1994  Linus Torvalds
- */
-
-/*
- * This is included by init/main.c to check for architecture-dependent bugs.
- *
- * Needs:
- *	void check_bugs(void);
- */
-
-#ifdef CONFIG_MMU
-extern void check_bugs(void);	/* in arch/m68k/kernel/setup.c */
-#else
-static void check_bugs(void)
-{
-}
-#endif
diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
index de44899c0e61..461e14f46cfe 100644
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/cpu.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
@@ -526,7 +527,7 @@ static int __init proc_hardware_init(void)
 module_init(proc_hardware_init);
 #endif
 
-void check_bugs(void)
+void __init arch_cpu_finalize_init(void)
 {
 #if defined(CONFIG_FPU) && !defined(CONFIG_M68KFPU_EMU)
 	if (m68k_fputype == 0) {
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8a227a80f6bd..8d1d065aac35 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -4,6 +4,7 @@ config MIPS
 	default y
 	select ARCH_BINFMT_ELF_STATE
 	select ARCH_CLOCKSOURCE_DATA
+	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_DISCARD_MEMBLOCK
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
diff --git a/arch/mips/include/asm/bugs.h b/arch/mips/include/asm/bugs.h
index d8ab8b7129b5..6d04d7d3a8f2 100644
--- a/arch/mips/include/asm/bugs.h
+++ b/arch/mips/include/asm/bugs.h
@@ -1,17 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * This is included by init/main.c to check for architecture-dependent bugs.
- *
  * Copyright (C) 2007  Maciej W. Rozycki
- *
- * Needs:
- *	void check_bugs(void);
  */
 #ifndef _ASM_BUGS_H
 #define _ASM_BUGS_H
 
 #include <linux/bug.h>
-#include <linux/delay.h>
 #include <linux/smp.h>
 
 #include <asm/cpu.h>
@@ -31,17 +25,6 @@ static inline void check_bugs_early(void)
 #endif
 }
 
-static inline void check_bugs(void)
-{
-	unsigned int cpu = smp_processor_id();
-
-	cpu_data[cpu].udelay_val = loops_per_jiffy;
-	check_bugs32();
-#ifdef CONFIG_64BIT
-	check_bugs64();
-#endif
-}
-
 static inline int r4k_daddiu_bug(void)
 {
 #ifdef CONFIG_64BIT
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 124bc842306d..b424f5e84487 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -11,6 +11,8 @@
  * Copyright (C) 2000, 2001, 2002, 2007	 Maciej W. Rozycki
  */
 #include <linux/init.h>
+#include <linux/cpu.h>
+#include <linux/delay.h>
 #include <linux/ioport.h>
 #include <linux/export.h>
 #include <linux/screen_info.h>
@@ -1108,3 +1110,14 @@ static int __init setnocoherentio(char *str)
 }
 early_param("nocoherentio", setnocoherentio);
 #endif
+
+void __init arch_cpu_finalize_init(void)
+{
+	unsigned int cpu = smp_processor_id();
+
+	cpu_data[cpu].udelay_val = loops_per_jiffy;
+	check_bugs32();
+
+	if (IS_ENABLED(CONFIG_CPU_R4X00_BUGS64))
+		check_bugs64();
+}
diff --git a/arch/parisc/include/asm/bugs.h b/arch/parisc/include/asm/bugs.h
deleted file mode 100644
index 0a7f9db6bd1c..000000000000
--- a/arch/parisc/include/asm/bugs.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *  include/asm-parisc/bugs.h
- *
- *  Copyright (C) 1999	Mike Shaver
- */
-
-/*
- * This is included by init/main.c to check for architecture-dependent bugs.
- *
- * Needs:
- *	void check_bugs(void);
- */
-
-#include <asm/processor.h>
-
-static inline void check_bugs(void)
-{
-//	identify_cpu(&boot_cpu_data);
-}
diff --git a/arch/powerpc/include/asm/bugs.h b/arch/powerpc/include/asm/bugs.h
deleted file mode 100644
index 42fdb73e3068..000000000000
--- a/arch/powerpc/include/asm/bugs.h
+++ /dev/null
@@ -1,18 +0,0 @@
-#ifndef _ASM_POWERPC_BUGS_H
-#define _ASM_POWERPC_BUGS_H
-
-/*
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-/*
- * This file is included by 'init/main.c' to check for
- * architecture-dependent bugs.
- */
-
-static inline void check_bugs(void) { }
-
-#endif	/* _ASM_POWERPC_BUGS_H */
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 1fb7b6d72baf..63e00320eb3c 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config SUPERH
 	def_bool y
+	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_MIGHT_HAVE_PC_PARPORT
diff --git a/arch/sh/include/asm/bugs.h b/arch/sh/include/asm/bugs.h
deleted file mode 100644
index 030df56bfdb2..000000000000
--- a/arch/sh/include/asm/bugs.h
+++ /dev/null
@@ -1,78 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_SH_BUGS_H
-#define __ASM_SH_BUGS_H
-
-/*
- * This is included by init/main.c to check for architecture-dependent bugs.
- *
- * Needs:
- *	void check_bugs(void);
- */
-
-/*
- * I don't know of any Super-H bugs yet.
- */
-
-#include <asm/processor.h>
-
-extern void select_idle_routine(void);
-
-static void __init check_bugs(void)
-{
-	extern unsigned long loops_per_jiffy;
-	char *p = &init_utsname()->machine[2]; /* "sh" */
-
-	select_idle_routine();
-
-	current_cpu_data.loops_per_jiffy = loops_per_jiffy;
-
-	switch (current_cpu_data.family) {
-	case CPU_FAMILY_SH2:
-		*p++ = '2';
-		break;
-	case CPU_FAMILY_SH2A:
-		*p++ = '2';
-		*p++ = 'a';
-		break;
-	case CPU_FAMILY_SH3:
-		*p++ = '3';
-		break;
-	case CPU_FAMILY_SH4:
-		*p++ = '4';
-		break;
-	case CPU_FAMILY_SH4A:
-		*p++ = '4';
-		*p++ = 'a';
-		break;
-	case CPU_FAMILY_SH4AL_DSP:
-		*p++ = '4';
-		*p++ = 'a';
-		*p++ = 'l';
-		*p++ = '-';
-		*p++ = 'd';
-		*p++ = 's';
-		*p++ = 'p';
-		break;
-	case CPU_FAMILY_SH5:
-		*p++ = '6';
-		*p++ = '4';
-		break;
-	case CPU_FAMILY_UNKNOWN:
-		/*
-		 * Specifically use CPU_FAMILY_UNKNOWN rather than
-		 * default:, so we're able to have the compiler whine
-		 * about unhandled enumerations.
-		 */
-		break;
-	}
-
-	printk("CPU: %s\n", get_cpu_subtype(&current_cpu_data));
-
-#ifndef __LITTLE_ENDIAN__
-	/* 'eb' means 'Endian Big' */
-	*p++ = 'e';
-	*p++ = 'b';
-#endif
-	*p = '\0';
-}
-#endif /* __ASM_SH_BUGS_H */
diff --git a/arch/sh/include/asm/processor.h b/arch/sh/include/asm/processor.h
index 6fbf8c80e498..386786b1594a 100644
--- a/arch/sh/include/asm/processor.h
+++ b/arch/sh/include/asm/processor.h
@@ -173,6 +173,8 @@ extern unsigned int instruction_size(unsigned int insn);
 #define instruction_size(insn)	(4)
 #endif
 
+void select_idle_routine(void);
+
 #endif /* __ASSEMBLY__ */
 
 #ifdef CONFIG_SUPERH32
diff --git a/arch/sh/kernel/idle.c b/arch/sh/kernel/idle.c
index be616ee0cf87..5169309fdf98 100644
--- a/arch/sh/kernel/idle.c
+++ b/arch/sh/kernel/idle.c
@@ -18,6 +18,7 @@
 #include <linux/smp.h>
 #include <linux/atomic.h>
 #include <asm/pgalloc.h>
+#include <asm/processor.h>
 #include <asm/smp.h>
 #include <asm/bl_bit.h>
 
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index b2f44eb7ce19..8ef497062350 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -42,6 +42,7 @@
 #include <asm/smp.h>
 #include <asm/mmu_context.h>
 #include <asm/mmzone.h>
+#include <asm/processor.h>
 #include <asm/sparsemem.h>
 
 /*
@@ -361,3 +362,57 @@ int test_mode_pin(int pin)
 {
 	return sh_mv.mv_mode_pins() & pin;
 }
+
+void __init arch_cpu_finalize_init(void)
+{
+	char *p = &init_utsname()->machine[2]; /* "sh" */
+
+	select_idle_routine();
+
+	current_cpu_data.loops_per_jiffy = loops_per_jiffy;
+
+	switch (current_cpu_data.family) {
+	case CPU_FAMILY_SH2:
+		*p++ = '2';
+		break;
+	case CPU_FAMILY_SH2A:
+		*p++ = '2';
+		*p++ = 'a';
+		break;
+	case CPU_FAMILY_SH3:
+		*p++ = '3';
+		break;
+	case CPU_FAMILY_SH4:
+		*p++ = '4';
+		break;
+	case CPU_FAMILY_SH4A:
+		*p++ = '4';
+		*p++ = 'a';
+		break;
+	case CPU_FAMILY_SH4AL_DSP:
+		*p++ = '4';
+		*p++ = 'a';
+		*p++ = 'l';
+		*p++ = '-';
+		*p++ = 'd';
+		*p++ = 's';
+		*p++ = 'p';
+		break;
+	case CPU_FAMILY_UNKNOWN:
+		/*
+		 * Specifically use CPU_FAMILY_UNKNOWN rather than
+		 * default:, so we're able to have the compiler whine
+		 * about unhandled enumerations.
+		 */
+		break;
+	}
+
+	pr_info("CPU: %s\n", get_cpu_subtype(&current_cpu_data));
+
+#ifndef __LITTLE_ENDIAN__
+	/* 'eb' means 'Endian Big' */
+	*p++ = 'e';
+	*p++ = 'b';
+#endif
+	*p = '\0';
+}
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 426accab2a88..e231779928dd 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -12,6 +12,7 @@ config 64BIT
 config SPARC
 	bool
 	default y
+	select ARCH_HAS_CPU_FINALIZE_INIT if !SMP
 	select ARCH_MIGHT_HAVE_PC_PARPORT if SPARC64 && PCI
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select OF
diff --git a/arch/sparc/include/asm/bugs.h b/arch/sparc/include/asm/bugs.h
deleted file mode 100644
index 02fa369b9c21..000000000000
--- a/arch/sparc/include/asm/bugs.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* include/asm/bugs.h:  Sparc probes for various bugs.
- *
- * Copyright (C) 1996, 2007 David S. Miller (davem@davemloft.net)
- */
-
-#ifdef CONFIG_SPARC32
-#include <asm/cpudata.h>
-#endif
-
-extern unsigned long loops_per_jiffy;
-
-static void __init check_bugs(void)
-{
-#if defined(CONFIG_SPARC32) && !defined(CONFIG_SMP)
-	cpu_data(0).udelay_val = loops_per_jiffy;
-#endif
-}
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 13664c377196..3ee6609e6eb5 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -422,3 +422,10 @@ static int __init topology_init(void)
 }
 
 subsys_initcall(topology_init);
+
+#if defined(CONFIG_SPARC32) && !defined(CONFIG_SMP)
+void __init arch_cpu_finalize_init(void)
+{
+	cpu_data(0).udelay_val = loops_per_jiffy;
+}
+#endif
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 6b9938919f0b..8f0cb2809939 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -5,6 +5,7 @@ menu "UML-specific options"
 config UML
 	bool
 	default y
+	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_KCOV
 	select ARCH_NO_PREEMPT
 	select HAVE_ARCH_AUDITSYSCALL
diff --git a/arch/um/include/asm/bugs.h b/arch/um/include/asm/bugs.h
deleted file mode 100644
index 4473942a0839..000000000000
--- a/arch/um/include/asm/bugs.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __UM_BUGS_H
-#define __UM_BUGS_H
-
-void check_bugs(void);
-
-#endif
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index c23f8857a798..66390c321155 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -3,6 +3,7 @@
  * Licensed under the GPL
  */
 
+#include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/mm.h>
@@ -352,7 +353,7 @@ void __init setup_arch(char **cmdline_p)
 	setup_hostinfo(host_info, sizeof host_info);
 }
 
-void __init check_bugs(void)
+void __init arch_cpu_finalize_init(void)
 {
 	arch_check_bugs();
 	os_check_bugs();
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index be4403a8e1b4..9fd2e3c2494a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -50,6 +50,7 @@ config X86
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_DISCARD_MEMBLOCK
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
+	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ELF_RANDOMIZE
@@ -2437,6 +2438,25 @@ config ARCH_ENABLE_SPLIT_PMD_PTLOCK
 	def_bool y
 	depends on X86_64 || X86_PAE
 
+config GDS_FORCE_MITIGATION
+	bool "Force GDS Mitigation"
+	depends on CPU_SUP_INTEL
+	default n
+	help
+	  Gather Data Sampling (GDS) is a hardware vulnerability which allows
+	  unprivileged speculative access to data which was previously stored in
+	  vector registers.
+
+	  This option is equivalent to setting gather_data_sampling=force on the
+	  command line. The microcode mitigation is used if present, otherwise
+	  AVX is disabled as a mitigation. On affected systems that are missing
+	  the microcode any userspace code that unconditionally uses AVX will
+	  break with this option set.
+
+	  Setting this option on systems not vulnerable to GDS has no effect.
+
+	  If in doubt, say N.
+
 config ARCH_ENABLE_HUGEPAGE_MIGRATION
 	def_bool y
 	depends on X86_64 && HUGETLB_PAGE && MIGRATION
diff --git a/arch/x86/include/asm/bugs.h b/arch/x86/include/asm/bugs.h
index 542509b53e0f..dd8ff1ca2aef 100644
--- a/arch/x86/include/asm/bugs.h
+++ b/arch/x86/include/asm/bugs.h
@@ -4,8 +4,6 @@
 
 #include <asm/processor.h>
 
-extern void check_bugs(void);
-
 #if defined(CONFIG_CPU_SUP_INTEL)
 void check_mpx_erratum(struct cpuinfo_x86 *c);
 #else
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index bd4374f56651..5cf8dca571cf 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -409,5 +409,6 @@
 #define X86_BUG_MMIO_UNKNOWN		X86_BUG(26) /* CPU is too old and its MMIO Stale Data status is unknown */
 #define X86_BUG_RETBLEED		X86_BUG(27) /* CPU is affected by RETBleed */
 #define X86_BUG_EIBRS_PBRSB		X86_BUG(28) /* EIBRS is vulnerable to Post Barrier RSB Predictions */
+#define X86_BUG_GDS			X86_BUG(29) /* CPU is affected by Gather Data Sampling */
 
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 4f274d851986..51dc8201b51e 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -42,7 +42,7 @@ extern int  dump_fpu(struct pt_regs *ptregs, struct user_i387_struct *fpstate);
 extern void fpu__init_cpu(void);
 extern void fpu__init_system_xstate(void);
 extern void fpu__init_cpu_xstate(void);
-extern void fpu__init_system(struct cpuinfo_x86 *c);
+extern void fpu__init_system(void);
 extern void fpu__init_check_bugs(void);
 extern void fpu__resume_cpu(void);
 extern u64 fpu__get_supported_xfeatures_mask(void);
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 616f8e637bc3..b51ac6eed904 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -80,6 +80,8 @@ early_set_memory_decrypted(unsigned long vaddr, unsigned long size) { return 0;
 static inline int __init
 early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0; }
 
+static inline void mem_encrypt_init(void) { }
+
 #define __bss_decrypted
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index d9c6603dcd63..efedd16231ff 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -138,6 +138,15 @@
 						 * Not susceptible to Post-Barrier
 						 * Return Stack Buffer Predictions.
 						 */
+#define ARCH_CAP_GDS_CTRL		BIT(25)	/*
+						 * CPU is vulnerable to Gather
+						 * Data Sampling (GDS) and
+						 * has controls for mitigation.
+						 */
+#define ARCH_CAP_GDS_NO			BIT(26)	/*
+						 * CPU is not vulnerable to Gather
+						 * Data Sampling (GDS).
+						 */
 
 #define MSR_IA32_FLUSH_CMD		0x0000010b
 #define L1D_FLUSH			BIT(0)	/*
@@ -156,6 +165,8 @@
 #define MSR_IA32_MCU_OPT_CTRL		0x00000123
 #define RNGDS_MITG_DIS			BIT(0)
 #define FB_CLEAR_DIS			BIT(3)	/* CPU Fill buffer clear disable */
+#define GDS_MITG_DIS			BIT(4)	/* Disable GDS mitigation */
+#define GDS_MITG_LOCKED			BIT(5)	/* GDS mitigation locked */
 
 #define MSR_IA32_SYSENTER_CS		0x00000174
 #define MSR_IA32_SYSENTER_ESP		0x00000175
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 680fa070e18b..6e1acbdd27a5 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -9,7 +9,6 @@
  *	- Andrew D. Balsa (code cleanup).
  */
 #include <linux/init.h>
-#include <linux/utsname.h>
 #include <linux/cpu.h>
 #include <linux/module.h>
 #include <linux/nospec.h>
@@ -25,9 +24,7 @@
 #include <asm/msr.h>
 #include <asm/vmx.h>
 #include <asm/paravirt.h>
-#include <asm/alternative.h>
 #include <asm/pgtable.h>
-#include <asm/set_memory.h>
 #include <asm/intel-family.h>
 #include <asm/e820/api.h>
 #include <asm/hypervisor.h>
@@ -47,6 +44,7 @@ static void __init md_clear_select_mitigation(void);
 static void __init taa_select_mitigation(void);
 static void __init mmio_select_mitigation(void);
 static void __init srbds_select_mitigation(void);
+static void __init gds_select_mitigation(void);
 
 /* The base value of the SPEC_CTRL MSR without task-specific bits set */
 u64 x86_spec_ctrl_base;
@@ -115,21 +113,8 @@ EXPORT_SYMBOL_GPL(mds_idle_clear);
 DEFINE_STATIC_KEY_FALSE(mmio_stale_data_clear);
 EXPORT_SYMBOL_GPL(mmio_stale_data_clear);
 
-void __init check_bugs(void)
+void __init cpu_select_mitigations(void)
 {
-	identify_boot_cpu();
-
-	/*
-	 * identify_boot_cpu() initialized SMT support information, let the
-	 * core code know.
-	 */
-	cpu_smt_check_topology();
-
-	if (!IS_ENABLED(CONFIG_SMP)) {
-		pr_info("CPU: ");
-		print_cpu_info(&boot_cpu_data);
-	}
-
 	/*
 	 * Read the SPEC_CTRL MSR to account for reserved bits which may
 	 * have unknown values. AMD64_LS_CFG MSR is cached in the early AMD
@@ -165,39 +150,7 @@ void __init check_bugs(void)
 	l1tf_select_mitigation();
 	md_clear_select_mitigation();
 	srbds_select_mitigation();
-
-	arch_smt_update();
-
-#ifdef CONFIG_X86_32
-	/*
-	 * Check whether we are able to run this kernel safely on SMP.
-	 *
-	 * - i386 is no longer supported.
-	 * - In order to run on anything without a TSC, we need to be
-	 *   compiled for a i486.
-	 */
-	if (boot_cpu_data.x86 < 4)
-		panic("Kernel requires i486+ for 'invlpg' and other features");
-
-	init_utsname()->machine[1] =
-		'0' + (boot_cpu_data.x86 > 6 ? 6 : boot_cpu_data.x86);
-	alternative_instructions();
-
-	fpu__init_check_bugs();
-#else /* CONFIG_X86_64 */
-	alternative_instructions();
-
-	/*
-	 * Make sure the first 2MB area is not mapped by huge pages
-	 * There are typically fixed size MTRRs in there and overlapping
-	 * MTRRs into large pages causes slow downs.
-	 *
-	 * Right now we don't do that with gbpages because there seems
-	 * very little benefit for that case.
-	 */
-	if (!direct_gbpages)
-		set_memory_4k((unsigned long)__va(0), 1);
-#endif
+	gds_select_mitigation();
 }
 
 /*
@@ -648,6 +601,149 @@ static int __init srbds_parse_cmdline(char *str)
 }
 early_param("srbds", srbds_parse_cmdline);
 
+#undef pr_fmt
+#define pr_fmt(fmt)	"GDS: " fmt
+
+enum gds_mitigations {
+	GDS_MITIGATION_OFF,
+	GDS_MITIGATION_UCODE_NEEDED,
+	GDS_MITIGATION_FORCE,
+	GDS_MITIGATION_FULL,
+	GDS_MITIGATION_FULL_LOCKED,
+	GDS_MITIGATION_HYPERVISOR,
+};
+
+#if IS_ENABLED(CONFIG_GDS_FORCE_MITIGATION)
+static enum gds_mitigations gds_mitigation __ro_after_init = GDS_MITIGATION_FORCE;
+#else
+static enum gds_mitigations gds_mitigation __ro_after_init = GDS_MITIGATION_FULL;
+#endif
+
+static const char * const gds_strings[] = {
+	[GDS_MITIGATION_OFF]		= "Vulnerable",
+	[GDS_MITIGATION_UCODE_NEEDED]	= "Vulnerable: No microcode",
+	[GDS_MITIGATION_FORCE]		= "Mitigation: AVX disabled, no microcode",
+	[GDS_MITIGATION_FULL]		= "Mitigation: Microcode",
+	[GDS_MITIGATION_FULL_LOCKED]	= "Mitigation: Microcode (locked)",
+	[GDS_MITIGATION_HYPERVISOR]	= "Unknown: Dependent on hypervisor status",
+};
+
+bool gds_ucode_mitigated(void)
+{
+	return (gds_mitigation == GDS_MITIGATION_FULL ||
+		gds_mitigation == GDS_MITIGATION_FULL_LOCKED);
+}
+EXPORT_SYMBOL_GPL(gds_ucode_mitigated);
+
+void update_gds_msr(void)
+{
+	u64 mcu_ctrl_after;
+	u64 mcu_ctrl;
+
+	switch (gds_mitigation) {
+	case GDS_MITIGATION_OFF:
+		rdmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
+		mcu_ctrl |= GDS_MITG_DIS;
+		break;
+	case GDS_MITIGATION_FULL_LOCKED:
+		/*
+		 * The LOCKED state comes from the boot CPU. APs might not have
+		 * the same state. Make sure the mitigation is enabled on all
+		 * CPUs.
+		 */
+	case GDS_MITIGATION_FULL:
+		rdmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
+		mcu_ctrl &= ~GDS_MITG_DIS;
+		break;
+	case GDS_MITIGATION_FORCE:
+	case GDS_MITIGATION_UCODE_NEEDED:
+	case GDS_MITIGATION_HYPERVISOR:
+		return;
+	};
+
+	wrmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
+
+	/*
+	 * Check to make sure that the WRMSR value was not ignored. Writes to
+	 * GDS_MITG_DIS will be ignored if this processor is locked but the boot
+	 * processor was not.
+	 */
+	rdmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl_after);
+	WARN_ON_ONCE(mcu_ctrl != mcu_ctrl_after);
+}
+
+static void __init gds_select_mitigation(void)
+{
+	u64 mcu_ctrl;
+
+	if (!boot_cpu_has_bug(X86_BUG_GDS))
+		return;
+
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
+		gds_mitigation = GDS_MITIGATION_HYPERVISOR;
+		goto out;
+	}
+
+	if (cpu_mitigations_off())
+		gds_mitigation = GDS_MITIGATION_OFF;
+	/* Will verify below that mitigation _can_ be disabled */
+
+	/* No microcode */
+	if (!(x86_read_arch_cap_msr() & ARCH_CAP_GDS_CTRL)) {
+		if (gds_mitigation == GDS_MITIGATION_FORCE) {
+			/*
+			 * This only needs to be done on the boot CPU so do it
+			 * here rather than in update_gds_msr()
+			 */
+			setup_clear_cpu_cap(X86_FEATURE_AVX);
+			pr_warn("Microcode update needed! Disabling AVX as mitigation.\n");
+		} else {
+			gds_mitigation = GDS_MITIGATION_UCODE_NEEDED;
+		}
+		goto out;
+	}
+
+	/* Microcode has mitigation, use it */
+	if (gds_mitigation == GDS_MITIGATION_FORCE)
+		gds_mitigation = GDS_MITIGATION_FULL;
+
+	rdmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
+	if (mcu_ctrl & GDS_MITG_LOCKED) {
+		if (gds_mitigation == GDS_MITIGATION_OFF)
+			pr_warn("Mitigation locked. Disable failed.\n");
+
+		/*
+		 * The mitigation is selected from the boot CPU. All other CPUs
+		 * _should_ have the same state. If the boot CPU isn't locked
+		 * but others are then update_gds_msr() will WARN() of the state
+		 * mismatch. If the boot CPU is locked update_gds_msr() will
+		 * ensure the other CPUs have the mitigation enabled.
+		 */
+		gds_mitigation = GDS_MITIGATION_FULL_LOCKED;
+	}
+
+	update_gds_msr();
+out:
+	pr_info("%s\n", gds_strings[gds_mitigation]);
+}
+
+static int __init gds_parse_cmdline(char *str)
+{
+	if (!str)
+		return -EINVAL;
+
+	if (!boot_cpu_has_bug(X86_BUG_GDS))
+		return 0;
+
+	if (!strcmp(str, "off"))
+		gds_mitigation = GDS_MITIGATION_OFF;
+	else if (!strcmp(str, "force"))
+		gds_mitigation = GDS_MITIGATION_FORCE;
+
+	return 0;
+}
+early_param("gather_data_sampling", gds_parse_cmdline);
+
 #undef pr_fmt
 #define pr_fmt(fmt)     "Spectre V1 : " fmt
 
@@ -2196,6 +2292,11 @@ static ssize_t retbleed_show_state(char *buf)
 	return sprintf(buf, "%s\n", retbleed_strings[retbleed_mitigation]);
 }
 
+static ssize_t gds_show_state(char *buf)
+{
+	return sysfs_emit(buf, "%s\n", gds_strings[gds_mitigation]);
+}
+
 static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
 			       char *buf, unsigned int bug)
 {
@@ -2245,6 +2346,9 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
 	case X86_BUG_RETBLEED:
 		return retbleed_show_state(buf);
 
+	case X86_BUG_GDS:
+		return gds_show_state(buf);
+
 	default:
 		break;
 	}
@@ -2309,4 +2413,9 @@ ssize_t cpu_show_retbleed(struct device *dev, struct device_attribute *attr, cha
 {
 	return cpu_show_common(dev, attr, buf, X86_BUG_RETBLEED);
 }
+
+ssize_t cpu_show_gds(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return cpu_show_common(dev, attr, buf, X86_BUG_GDS);
+}
 #endif
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ec324be00603..d315e928b95c 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -13,14 +13,20 @@
 #include <linux/sched/mm.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/task.h>
+#include <linux/sched/smt.h>
 #include <linux/init.h>
 #include <linux/kprobes.h>
 #include <linux/kgdb.h>
+#include <linux/mem_encrypt.h>
 #include <linux/smp.h>
+#include <linux/cpu.h>
 #include <linux/io.h>
 #include <linux/syscore_ops.h>
 
 #include <asm/stackprotector.h>
+#include <linux/utsname.h>
+
+#include <asm/alternative.h>
 #include <asm/perf_event.h>
 #include <asm/mmu_context.h>
 #include <asm/archrandom.h>
@@ -56,6 +62,7 @@
 #ifdef CONFIG_X86_LOCAL_APIC
 #include <asm/uv/uv.h>
 #endif
+#include <asm/set_memory.h>
 
 #include "cpu.h"
 
@@ -1040,6 +1047,12 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 #define MMIO_SBDS	BIT(2)
 /* CPU is affected by RETbleed, speculating where you would not expect it */
 #define RETBLEED	BIT(3)
+/* CPU is affected by SMT (cross-thread) return predictions */
+#define SMT_RSB		BIT(4)
+/* CPU is affected by SRSO */
+#define SRSO		BIT(5)
+/* CPU is affected by GDS */
+#define GDS		BIT(6)
 
 static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL_STEPPINGS(IVYBRIDGE,	X86_STEPPING_ANY,		SRBDS),
@@ -1052,18 +1065,20 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL_STEPPINGS(BROADWELL_X,	X86_STEPPING_ANY,		MMIO),
 	VULNBL_INTEL_STEPPINGS(BROADWELL_CORE,	X86_STEPPING_ANY,		SRBDS),
 	VULNBL_INTEL_STEPPINGS(SKYLAKE_MOBILE,	X86_STEPPING_ANY,		SRBDS | MMIO | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(SKYLAKE_X,	X86_STEPPING_ANY,		MMIO | RETBLEED),
+	VULNBL_INTEL_STEPPINGS(SKYLAKE_X,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS),
 	VULNBL_INTEL_STEPPINGS(SKYLAKE_DESKTOP,	X86_STEPPING_ANY,		SRBDS | MMIO | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(KABYLAKE_MOBILE,	X86_STEPPING_ANY,		SRBDS | MMIO | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(KABYLAKE_DESKTOP,X86_STEPPING_ANY,		SRBDS | MMIO | RETBLEED),
+	VULNBL_INTEL_STEPPINGS(KABYLAKE_MOBILE,	X86_STEPPING_ANY,		SRBDS | MMIO | RETBLEED | GDS),
+	VULNBL_INTEL_STEPPINGS(KABYLAKE_DESKTOP,X86_STEPPING_ANY,		SRBDS | MMIO | RETBLEED | GDS),
 	VULNBL_INTEL_STEPPINGS(CANNONLAKE_MOBILE,X86_STEPPING_ANY,		RETBLEED),
-	VULNBL_INTEL_STEPPINGS(ICELAKE_MOBILE,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(ICELAKE_XEON_D,	X86_STEPPING_ANY,		MMIO),
-	VULNBL_INTEL_STEPPINGS(ICELAKE_X,	X86_STEPPING_ANY,		MMIO),
-	VULNBL_INTEL_STEPPINGS(COMETLAKE,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED),
+	VULNBL_INTEL_STEPPINGS(ICELAKE_MOBILE,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS),
+	VULNBL_INTEL_STEPPINGS(ICELAKE_XEON_D,	X86_STEPPING_ANY,		MMIO | GDS),
+	VULNBL_INTEL_STEPPINGS(ICELAKE_X,	X86_STEPPING_ANY,		MMIO | GDS),
+	VULNBL_INTEL_STEPPINGS(COMETLAKE,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS),
+	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS),
+	VULNBL_INTEL_STEPPINGS(TIGERLAKE_L,	X86_STEPPING_ANY,		GDS),
+	VULNBL_INTEL_STEPPINGS(TIGERLAKE,	X86_STEPPING_ANY,		GDS),
 	VULNBL_INTEL_STEPPINGS(LAKEFIELD,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(ROCKETLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED),
+	VULNBL_INTEL_STEPPINGS(ROCKETLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS),
 	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS),
 	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT_X,	X86_STEPPING_ANY,		MMIO),
 	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS),
@@ -1186,6 +1201,16 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	    !(ia32_cap & ARCH_CAP_PBRSB_NO))
 		setup_force_cpu_bug(X86_BUG_EIBRS_PBRSB);
 
+	/*
+	 * Check if CPU is vulnerable to GDS. If running in a virtual machine on
+	 * an affected processor, the VMM may have disabled the use of GATHER by
+	 * disabling AVX2. The only way to do this in HW is to clear XCR0[2],
+	 * which means that AVX will be disabled.
+	 */
+	if (cpu_matches(cpu_vuln_blacklist, GDS) && !(ia32_cap & ARCH_CAP_GDS_NO) &&
+	    boot_cpu_has(X86_FEATURE_AVX))
+		setup_force_cpu_bug(X86_BUG_GDS);
+
 	if (cpu_matches(cpu_vuln_whitelist, NO_MELTDOWN))
 		return;
 
@@ -1271,8 +1296,6 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 
 	cpu_set_bug_bits(c);
 
-	fpu__init_system(c);
-
 #ifdef CONFIG_X86_32
 	/*
 	 * Regardless of whether PCID is enumerated, the SDM says
@@ -1661,6 +1684,8 @@ void identify_secondary_cpu(struct cpuinfo_x86 *c)
 	validate_apic_and_package_id(c);
 	x86_spec_ctrl_setup_ap();
 	update_srbds_msr();
+	if (boot_cpu_has_bug(X86_BUG_GDS))
+		update_gds_msr();
 }
 
 static __init int setup_noclflush(char *arg)
@@ -1978,8 +2003,6 @@ void cpu_init(void)
 	clear_all_debug_regs();
 	dbg_restore_debug_regs();
 
-	fpu__init_cpu();
-
 	if (is_uv_system())
 		uv_cpu_init();
 
@@ -2043,8 +2066,6 @@ void cpu_init(void)
 	clear_all_debug_regs();
 	dbg_restore_debug_regs();
 
-	fpu__init_cpu();
-
 	load_fixmap_gdt(cpu);
 }
 #endif
@@ -2097,3 +2118,69 @@ void microcode_check(void)
 	pr_warn("x86/CPU: CPU features have changed after loading microcode, but might not take effect.\n");
 	pr_warn("x86/CPU: Please consider either early loading through initrd/built-in or a potential BIOS update.\n");
 }
+
+void __init arch_cpu_finalize_init(void)
+{
+	identify_boot_cpu();
+
+	/*
+	 * identify_boot_cpu() initialized SMT support information, let the
+	 * core code know.
+	 */
+	cpu_smt_check_topology();
+
+	if (!IS_ENABLED(CONFIG_SMP)) {
+		pr_info("CPU: ");
+		print_cpu_info(&boot_cpu_data);
+	}
+
+	cpu_select_mitigations();
+
+	arch_smt_update();
+
+	if (IS_ENABLED(CONFIG_X86_32)) {
+		/*
+		 * Check whether this is a real i386 which is not longer
+		 * supported and fixup the utsname.
+		 */
+		if (boot_cpu_data.x86 < 4)
+			panic("Kernel requires i486+ for 'invlpg' and other features");
+
+		init_utsname()->machine[1] =
+			'0' + (boot_cpu_data.x86 > 6 ? 6 : boot_cpu_data.x86);
+	}
+
+	/*
+	 * Must be before alternatives because it might set or clear
+	 * feature bits.
+	 */
+	fpu__init_system();
+	fpu__init_cpu();
+
+	alternative_instructions();
+
+	if (IS_ENABLED(CONFIG_X86_64)) {
+		/*
+		 * Make sure the first 2MB area is not mapped by huge pages
+		 * There are typically fixed size MTRRs in there and overlapping
+		 * MTRRs into large pages causes slow downs.
+		 *
+		 * Right now we don't do that with gbpages because there seems
+		 * very little benefit for that case.
+		 */
+		if (!direct_gbpages)
+			set_memory_4k((unsigned long)__va(0), 1);
+	} else {
+		fpu__init_check_bugs();
+	}
+
+	/*
+	 * This needs to be called before any devices perform DMA
+	 * operations that might use the SWIOTLB bounce buffers. It will
+	 * mark the bounce buffers as decrypted so that their usage will
+	 * not cause "plain-text" data to be decrypted when accessed. It
+	 * must be called after late_time_init() so that Hyper-V x86/x64
+	 * hypercalls work when the SWIOTLB bounce buffers are decrypted.
+	 */
+	mem_encrypt_init();
+}
diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index 4eb9bf68b122..ca1b8bf380a2 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -79,9 +79,11 @@ extern void detect_ht(struct cpuinfo_x86 *c);
 extern void check_null_seg_clears_base(struct cpuinfo_x86 *c);
 
 unsigned int aperfmperf_get_khz(int cpu);
+void cpu_select_mitigations(void);
 
 extern void x86_spec_ctrl_setup_ap(void);
 extern void update_srbds_msr(void);
+extern void update_gds_msr(void);
 
 extern u64 x86_read_arch_cap_msr(void);
 
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 9692ccc583bb..644372a10c89 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -49,7 +49,7 @@ void fpu__init_cpu(void)
 	fpu__init_cpu_xstate();
 }
 
-static bool fpu__probe_without_cpuid(void)
+static bool __init fpu__probe_without_cpuid(void)
 {
 	unsigned long cr0;
 	u16 fsw, fcw;
@@ -67,7 +67,7 @@ static bool fpu__probe_without_cpuid(void)
 	return fsw == 0 && (fcw & 0x103f) == 0x003f;
 }
 
-static void fpu__init_system_early_generic(struct cpuinfo_x86 *c)
+static void __init fpu__init_system_early_generic(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_CPUID) &&
 	    !test_bit(X86_FEATURE_FPU, (unsigned long *)cpu_caps_cleared)) {
@@ -297,10 +297,10 @@ static void __init fpu__init_parse_early_param(void)
  * Called on the boot CPU once per system bootup, to set up the initial
  * FPU state that is later cloned into all processes:
  */
-void __init fpu__init_system(struct cpuinfo_x86 *c)
+void __init fpu__init_system(void)
 {
 	fpu__init_parse_early_param();
-	fpu__init_system_early_generic(c);
+	fpu__init_system_early_generic();
 
 	/*
 	 * The FPU has to be operational for some of the
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 8783d065f927..1f1298f6cbc2 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -231,6 +231,7 @@ static void notrace start_secondary(void *unused)
 #endif
 	load_current_idt();
 	cpu_init();
+	fpu__init_cpu();
 	x86_cpuinit.early_percpu_clock_init();
 	preempt_disable();
 	smp_callin();
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ff7ec9b507e3..cdf2cb1eb923 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -217,6 +217,8 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 
 u64 __read_mostly host_xcr0;
 
+extern bool gds_ucode_mitigated(void);
+
 static int emulator_fix_hypercall(struct x86_emulate_ctxt *ctxt);
 
 static inline void kvm_async_pf_hash_reset(struct kvm_vcpu *vcpu)
@@ -1224,6 +1226,9 @@ u64 kvm_get_arch_capabilities(void)
 	/* Guests don't need to know "Fill buffer clear control" exists */
 	data &= ~ARCH_CAP_FB_CLEAR_CTRL;
 
+	if (!boot_cpu_has_bug(X86_BUG_GDS) || gds_ucode_mitigated())
+		data |= ARCH_CAP_GDS_NO;
+
 	return data;
 }
 
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 75807c2a1e17..66f83562d329 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -27,6 +27,7 @@
 #include <asm/desc.h>
 #include <asm/pgtable.h>
 #include <asm/cpu.h>
+#include <asm/fpu/internal.h>
 
 #include <xen/interface/xen.h>
 #include <xen/interface/vcpu.h>
@@ -58,6 +59,7 @@ static void cpu_bringup(void)
 	int cpu;
 
 	cpu_init();
+	fpu__init_cpu();
 	touch_softlockup_watchdog();
 	preempt_disable();
 
diff --git a/arch/xtensa/include/asm/bugs.h b/arch/xtensa/include/asm/bugs.h
deleted file mode 100644
index 69b29d198249..000000000000
--- a/arch/xtensa/include/asm/bugs.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * include/asm-xtensa/bugs.h
- *
- * This is included by init/main.c to check for architecture-dependent bugs.
- *
- * Xtensa processors don't have any bugs.  :)
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License.  See the file "COPYING" in the main directory of
- * this archive for more details.
- */
-
-#ifndef _XTENSA_BUGS_H
-#define _XTENSA_BUGS_H
-
-static void check_bugs(void) { }
-
-#endif /* _XTENSA_BUGS_H */
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 878ed43d8753..b1bb6f43f896 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -584,6 +584,12 @@ ssize_t __weak cpu_show_retbleed(struct device *dev,
 	return sysfs_emit(buf, "Not affected\n");
 }
 
+ssize_t __weak cpu_show_gds(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "Not affected\n");
+}
+
 static DEVICE_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
 static DEVICE_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
 static DEVICE_ATTR(spectre_v2, 0444, cpu_show_spectre_v2, NULL);
@@ -595,6 +601,7 @@ static DEVICE_ATTR(itlb_multihit, 0444, cpu_show_itlb_multihit, NULL);
 static DEVICE_ATTR(srbds, 0444, cpu_show_srbds, NULL);
 static DEVICE_ATTR(mmio_stale_data, 0444, cpu_show_mmio_stale_data, NULL);
 static DEVICE_ATTR(retbleed, 0444, cpu_show_retbleed, NULL);
+static DEVICE_ATTR(gather_data_sampling, 0444, cpu_show_gds, NULL);
 
 static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_meltdown.attr,
@@ -608,6 +615,7 @@ static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_srbds.attr,
 	&dev_attr_mmio_stale_data.attr,
 	&dev_attr_retbleed.attr,
+	&dev_attr_gather_data_sampling.attr,
 	NULL
 };
 
diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
index d2b79d7c0b88..6faf36bfdeaf 100644
--- a/drivers/net/xen-netback/netback.c
+++ b/drivers/net/xen-netback/netback.c
@@ -389,7 +389,7 @@ static void xenvif_get_requests(struct xenvif_queue *queue,
 	struct gnttab_map_grant_ref *gop = queue->tx_map_ops + *map_ops;
 	struct xen_netif_tx_request *txp = first;
 
-	nr_slots = shinfo->nr_frags + 1;
+	nr_slots = shinfo->nr_frags + frag_overflow + 1;
 
 	copy_count(skb) = 0;
 	XENVIF_TX_CB(skb)->split_mask = 0;
@@ -455,8 +455,8 @@ static void xenvif_get_requests(struct xenvif_queue *queue,
 		}
 	}
 
-	for (shinfo->nr_frags = 0; shinfo->nr_frags < nr_slots;
-	     shinfo->nr_frags++, gop++) {
+	for (shinfo->nr_frags = 0; nr_slots > 0 && shinfo->nr_frags < MAX_SKB_FRAGS;
+	     shinfo->nr_frags++, gop++, nr_slots--) {
 		index = pending_index(queue->pending_cons++);
 		pending_idx = queue->pending_ring[index];
 		xenvif_tx_create_map_op(queue, pending_idx, txp,
@@ -469,12 +469,12 @@ static void xenvif_get_requests(struct xenvif_queue *queue,
 			txp++;
 	}
 
-	if (frag_overflow) {
+	if (nr_slots > 0) {
 
 		shinfo = skb_shinfo(nskb);
 		frags = shinfo->frags;
 
-		for (shinfo->nr_frags = 0; shinfo->nr_frags < frag_overflow;
+		for (shinfo->nr_frags = 0; shinfo->nr_frags < nr_slots;
 		     shinfo->nr_frags++, txp++, gop++) {
 			index = pending_index(queue->pending_cons++);
 			pending_idx = queue->pending_ring[index];
@@ -485,6 +485,11 @@ static void xenvif_get_requests(struct xenvif_queue *queue,
 		}
 
 		skb_shinfo(skb)->frag_list = nskb;
+	} else if (nskb) {
+		/* A frag_list skb was allocated but it is no longer needed
+		 * because enough slots were converted to copy ops above.
+		 */
+		kfree_skb(nskb);
 	}
 
 	(*copy_ops) = cop - queue->tx_copy_ops;
diff --git a/include/asm-generic/bugs.h b/include/asm-generic/bugs.h
deleted file mode 100644
index 69021830f078..000000000000
--- a/include/asm-generic/bugs.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_GENERIC_BUGS_H
-#define __ASM_GENERIC_BUGS_H
-/*
- * This file is included by 'init/main.c' to check for
- * architecture-dependent bugs.
- */
-
-static inline void check_bugs(void) { }
-
-#endif	/* __ASM_GENERIC_BUGS_H */
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 12ed4cb751de..c376a59a3e42 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -170,6 +170,12 @@ void arch_cpu_idle_enter(void);
 void arch_cpu_idle_exit(void);
 void arch_cpu_idle_dead(void);
 
+#ifdef CONFIG_ARCH_HAS_CPU_FINALIZE_INIT
+void arch_cpu_finalize_init(void);
+#else
+static inline void arch_cpu_finalize_init(void) { }
+#endif
+
 int cpu_report_state(int cpu);
 int cpu_check_up_prepare(int cpu);
 void cpu_set_state_online(int cpu);
diff --git a/init/main.c b/init/main.c
index 489a5aa7ba53..08c312abbaf1 100644
--- a/init/main.c
+++ b/init/main.c
@@ -91,10 +91,8 @@
 #include <linux/cache.h>
 #include <linux/rodata_test.h>
 #include <linux/jump_label.h>
-#include <linux/mem_encrypt.h>
 
 #include <asm/io.h>
-#include <asm/bugs.h>
 #include <asm/setup.h>
 #include <asm/sections.h>
 #include <asm/cacheflush.h>
@@ -493,8 +491,6 @@ void __init __weak thread_stack_cache_init(void)
 }
 #endif
 
-void __init __weak mem_encrypt_init(void) { }
-
 bool initcall_debug;
 core_param(initcall_debug, initcall_debug, bool, 0644);
 
@@ -674,14 +670,6 @@ asmlinkage __visible void __init start_kernel(void)
 	 */
 	locking_selftest();
 
-	/*
-	 * This needs to be called before any devices perform DMA
-	 * operations that might use the SWIOTLB bounce buffers. It will
-	 * mark the bounce buffers as decrypted so that their usage will
-	 * not cause "plain-text" data to be decrypted when accessed.
-	 */
-	mem_encrypt_init();
-
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start && !initrd_below_start_ok &&
 	    page_to_pfn(virt_to_page((void *)initrd_start)) < min_low_pfn) {
@@ -700,6 +688,9 @@ asmlinkage __visible void __init start_kernel(void)
 		late_time_init();
 	sched_clock_init();
 	calibrate_delay();
+
+	arch_cpu_finalize_init();
+
 	pid_idr_init();
 	anon_vma_init();
 #ifdef CONFIG_X86
@@ -726,7 +717,6 @@ asmlinkage __visible void __init start_kernel(void)
 	taskstats_init_early();
 	delayacct_init();
 
-	check_bugs();
 
 	acpi_subsystem_init();
 	arch_post_acpi_subsys_init();
