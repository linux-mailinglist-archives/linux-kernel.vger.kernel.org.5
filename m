Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B352A774840
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236183AbjHHT3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjHHT3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:29:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BF41C129;
        Tue,  8 Aug 2023 11:56:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CB2162A67;
        Tue,  8 Aug 2023 18:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3227BC433C8;
        Tue,  8 Aug 2023 18:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691520979;
        bh=4oMtS0gs3w/M8h4G7bpVXCywPRtVuz9Cv8iF03NZRWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jzGZEVT3ILbMZu5B3GPh0d5exQ3Wg36bCfCJKaC42tRBuXPnvM+axrjrhZ0JRvZPP
         nQkrf59RfcyMvwv7D6U77a5AwvO+VuE5nySlj4+DQ9TFePxnFF3GCJAD/yvFdonPia
         9CPW9VUBa9D/TerHYxfwxS1rDwTr6VV1UZpjjpI0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.189
Date:   Tue,  8 Aug 2023 20:56:08 +0200
Message-ID: <2023080844-gala-duration-094a@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023080844-stitch-promenade-4c70@gregkh>
References: <2023080844-stitch-promenade-4c70@gregkh>
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
index 500d5d8937cb..bfb4f4fada33 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -501,17 +501,18 @@ Description:	information about CPUs heterogeneity.
 		cpu_capacity: capacity of cpu#.
 
 What:		/sys/devices/system/cpu/vulnerabilities
+		/sys/devices/system/cpu/vulnerabilities/gather_data_sampling
+		/sys/devices/system/cpu/vulnerabilities/itlb_multihit
+		/sys/devices/system/cpu/vulnerabilities/l1tf
+		/sys/devices/system/cpu/vulnerabilities/mds
 		/sys/devices/system/cpu/vulnerabilities/meltdown
+		/sys/devices/system/cpu/vulnerabilities/mmio_stale_data
+		/sys/devices/system/cpu/vulnerabilities/retbleed
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
-		/sys/devices/system/cpu/vulnerabilities/retbleed
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
index 2adec1e6520a..84742be223ff 100644
--- a/Documentation/admin-guide/hw-vuln/index.rst
+++ b/Documentation/admin-guide/hw-vuln/index.rst
@@ -16,3 +16,5 @@ are configurable at compile, boot or run time.
    multihit.rst
    special-register-buffer-data-sampling.rst
    processor_mmio_stale_data.rst
+   gather_data_sampling.rst
+   srso
diff --git a/Documentation/admin-guide/hw-vuln/srso.rst b/Documentation/admin-guide/hw-vuln/srso.rst
new file mode 100644
index 000000000000..2f923c805802
--- /dev/null
+++ b/Documentation/admin-guide/hw-vuln/srso.rst
@@ -0,0 +1,133 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Speculative Return Stack Overflow (SRSO)
+========================================
+
+This is a mitigation for the speculative return stack overflow (SRSO)
+vulnerability found on AMD processors. The mechanism is by now the well
+known scenario of poisoning CPU functional units - the Branch Target
+Buffer (BTB) and Return Address Predictor (RAP) in this case - and then
+tricking the elevated privilege domain (the kernel) into leaking
+sensitive data.
+
+AMD CPUs predict RET instructions using a Return Address Predictor (aka
+Return Address Stack/Return Stack Buffer). In some cases, a non-architectural
+CALL instruction (i.e., an instruction predicted to be a CALL but is
+not actually a CALL) can create an entry in the RAP which may be used
+to predict the target of a subsequent RET instruction.
+
+The specific circumstances that lead to this varies by microarchitecture
+but the concern is that an attacker can mis-train the CPU BTB to predict
+non-architectural CALL instructions in kernel space and use this to
+control the speculative target of a subsequent kernel RET, potentially
+leading to information disclosure via a speculative side-channel.
+
+The issue is tracked under CVE-2023-20569.
+
+Affected processors
+-------------------
+
+AMD Zen, generations 1-4. That is, all families 0x17 and 0x19. Older
+processors have not been investigated.
+
+System information and options
+------------------------------
+
+First of all, it is required that the latest microcode be loaded for
+mitigations to be effective.
+
+The sysfs file showing SRSO mitigation status is:
+
+  /sys/devices/system/cpu/vulnerabilities/spec_rstack_overflow
+
+The possible values in this file are:
+
+ - 'Not affected'               The processor is not vulnerable
+
+ - 'Vulnerable: no microcode'   The processor is vulnerable, no
+                                microcode extending IBPB functionality
+                                to address the vulnerability has been
+                                applied.
+
+ - 'Mitigation: microcode'      Extended IBPB functionality microcode
+                                patch has been applied. It does not
+                                address User->Kernel and Guest->Host
+                                transitions protection but it does
+                                address User->User and VM->VM attack
+                                vectors.
+
+                                (spec_rstack_overflow=microcode)
+
+ - 'Mitigation: safe RET'       Software-only mitigation. It complements
+                                the extended IBPB microcode patch
+                                functionality by addressing User->Kernel
+                                and Guest->Host transitions protection.
+
+                                Selected by default or by
+                                spec_rstack_overflow=safe-ret
+
+ - 'Mitigation: IBPB'           Similar protection as "safe RET" above
+                                but employs an IBPB barrier on privilege
+                                domain crossings (User->Kernel,
+                                Guest->Host).
+
+                                (spec_rstack_overflow=ibpb)
+
+ - 'Mitigation: IBPB on VMEXIT' Mitigation addressing the cloud provider
+                                scenario - the Guest->Host transitions
+                                only.
+
+                                (spec_rstack_overflow=ibpb-vmexit)
+
+In order to exploit vulnerability, an attacker needs to:
+
+ - gain local access on the machine
+
+ - break kASLR
+
+ - find gadgets in the running kernel in order to use them in the exploit
+
+ - potentially create and pin an additional workload on the sibling
+   thread, depending on the microarchitecture (not necessary on fam 0x19)
+
+ - run the exploit
+
+Considering the performance implications of each mitigation type, the
+default one is 'Mitigation: safe RET' which should take care of most
+attack vectors, including the local User->Kernel one.
+
+As always, the user is advised to keep her/his system up-to-date by
+applying software updates regularly.
+
+The default setting will be reevaluated when needed and especially when
+new attack vectors appear.
+
+As one can surmise, 'Mitigation: safe RET' does come at the cost of some
+performance depending on the workload. If one trusts her/his userspace
+and does not want to suffer the performance impact, one can always
+disable the mitigation with spec_rstack_overflow=off.
+
+Similarly, 'Mitigation: IBPB' is another full mitigation type employing
+an indrect branch prediction barrier after having applied the required
+microcode patch for one's system. This mitigation comes also at
+a performance cost.
+
+Mitigation: safe RET
+--------------------
+
+The mitigation works by ensuring all RET instructions speculate to
+a controlled location, similar to how speculation is controlled in the
+retpoline sequence.  To accomplish this, the __x86_return_thunk forces
+the CPU to mispredict every function return using a 'safe return'
+sequence.
+
+To ensure the safety of this mitigation, the kernel must ensure that the
+safe return sequence is itself free from attacker interference.  In Zen3
+and Zen4, this is accomplished by creating a BTB alias between the
+untraining function srso_untrain_ret_alias() and the safe return
+function srso_safe_ret_alias() which results in evicting a potentially
+poisoned BTB entry and using that safe one for all function returns.
+
+In older Zen1 and Zen2, this is accomplished using a reinterpretation
+technique similar to Retbleed one: srso_untrain_ret() and
+srso_safe_ret().
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1f4a0523dc1a..f1f7c068cf65 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1447,6 +1447,26 @@
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
@@ -2887,22 +2907,23 @@
 				Disable all optional CPU mitigations.  This
 				improves system performance, but it may also
 				expose users to several CPU vulnerabilities.
-				Equivalent to: nopti [X86,PPC]
+				Equivalent to: gather_data_sampling=off [X86]
 					       kpti=0 [ARM64]
-					       nospectre_v1 [X86,PPC]
-					       nobp=0 [S390]
-					       nospectre_v2 [X86,PPC,S390,ARM64]
-					       spectre_v2_user=off [X86]
-					       spec_store_bypass_disable=off [X86,PPC]
-					       ssbd=force-off [ARM64]
+					       kvm.nx_huge_pages=off [X86]
 					       l1tf=off [X86]
 					       mds=off [X86]
-					       tsx_async_abort=off [X86]
-					       kvm.nx_huge_pages=off [X86]
+					       mmio_stale_data=off [X86]
 					       no_entry_flush [PPC]
 					       no_uaccess_flush [PPC]
-					       mmio_stale_data=off [X86]
+					       nobp=0 [S390]
+					       nopti [X86,PPC]
+					       nospectre_v1 [X86,PPC]
+					       nospectre_v2 [X86,PPC,S390,ARM64]
 					       retbleed=off [X86]
+					       spec_store_bypass_disable=off [X86,PPC]
+					       spectre_v2_user=off [X86]
+					       ssbd=force-off [ARM64]
+					       tsx_async_abort=off [X86]
 
 				Exceptions:
 					       This does not have any effect on
@@ -5120,6 +5141,17 @@
 			Not specifying this option is equivalent to
 			spectre_v2_user=auto.
 
+	spec_rstack_overflow=
+			[X86] Control RAS overflow mitigation on AMD Zen CPUs
+
+			off		- Disable mitigation
+			microcode	- Enable microcode mitigation only
+			safe-ret	- Enable sw-only safe RET mitigation (default)
+			ibpb		- Enable mitigation by issuing IBPB on
+					  kernel entry
+			ibpb-vmexit	- Issue IBPB only on VMEXIT
+					  (cloud-specific mitigation)
+
 	spec_store_bypass_disable=
 			[HW] Control Speculative Store Bypass (SSB) Disable mitigation
 			(Speculative Store Bypass vulnerability)
diff --git a/Makefile b/Makefile
index 7f9e1667d87d..36047436fae3 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 188
+SUBLEVEL = 189
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/Kconfig b/arch/Kconfig
index 632d60e13494..240277d5626c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -290,6 +290,9 @@ config ARCH_HAS_DMA_SET_UNCACHED
 config ARCH_HAS_DMA_CLEAR_UNCACHED
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
index 985ab0b091a6..335308aff6ce 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -4,6 +4,7 @@ config ARM
 	default y
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_BINFMT_FLAT
+	select ARCH_HAS_CPU_FINALIZE_INIT if MMU
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_DMA_WRITE_COMBINE if !ARM_DMA_MEM_BUFFERABLE
diff --git a/arch/arm/include/asm/bugs.h b/arch/arm/include/asm/bugs.h
index 97a312ba0840..fe385551edec 100644
--- a/arch/arm/include/asm/bugs.h
+++ b/arch/arm/include/asm/bugs.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- *  arch/arm/include/asm/bugs.h
- *
  *  Copyright (C) 1995-2003 Russell King
  */
 #ifndef __ASM_BUGS_H
@@ -10,10 +8,8 @@
 extern void check_writebuffer_bugs(void);
 
 #ifdef CONFIG_MMU
-extern void check_bugs(void);
 extern void check_other_bugs(void);
 #else
-#define check_bugs() do { } while (0)
 #define check_other_bugs() do { } while (0)
 #endif
 
diff --git a/arch/arm/kernel/bugs.c b/arch/arm/kernel/bugs.c
index 14c8dbbb7d2d..087bce6ec8e9 100644
--- a/arch/arm/kernel/bugs.c
+++ b/arch/arm/kernel/bugs.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
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
index 1d0579bc9d65..975b00b6034b 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -8,6 +8,7 @@ menu "Processor type and features"
 
 config IA64
 	bool
+	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_DMA_MARK_CLEAN
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
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
index dd595fbd8006..e7dd6756d5cb 100644
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -1071,8 +1071,7 @@ cpu_init (void)
 	}
 }
 
-void __init
-check_bugs (void)
+void __init arch_cpu_finalize_init(void)
 {
 	ia64_patch_mckinley_e9((unsigned long) __start___mckinley_e9_bundles,
 			       (unsigned long) __end___mckinley_e9_bundles);
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 372e4e69c43a..ad7a4ffd65c9 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -4,6 +4,7 @@ config M68K
 	default y
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_BINFMT_FLAT
+	select ARCH_HAS_CPU_FINALIZE_INIT if MMU
 	select ARCH_HAS_DMA_PREP_COHERENT if HAS_DMA && MMU && !COLDFIRE
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if HAS_DMA
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if RMW_INSNS
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
index ab8aa7be260f..f8116660417f 100644
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/cpu.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
@@ -523,7 +524,7 @@ static int __init proc_hardware_init(void)
 module_init(proc_hardware_init);
 #endif
 
-void check_bugs(void)
+void __init arch_cpu_finalize_init(void)
 {
 #if defined(CONFIG_FPU) && !defined(CONFIG_M68KFPU_EMU)
 	if (m68k_fputype == 0) {
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3442bdd4314c..57839f63074f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -4,6 +4,7 @@ config MIPS
 	default y
 	select ARCH_32BIT_OFF_T if !64BIT
 	select ARCH_BINFMT_ELF_STATE if MIPS_FP_SUPPORT
+	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE if !EVA
diff --git a/arch/mips/include/asm/bugs.h b/arch/mips/include/asm/bugs.h
index d72dc6e1cf3c..8d4cf29861b8 100644
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
@@ -30,17 +24,6 @@ static inline void check_bugs_early(void)
 		check_bugs64_early();
 }
 
-static inline void check_bugs(void)
-{
-	unsigned int cpu = smp_processor_id();
-
-	cpu_data[cpu].udelay_val = loops_per_jiffy;
-	check_bugs32();
-
-	if (IS_ENABLED(CONFIG_CPU_R4X00_BUGS64))
-		check_bugs64();
-}
-
 static inline int r4k_daddiu_bug(void)
 {
 	if (!IS_ENABLED(CONFIG_CPU_R4X00_BUGS64))
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index b49ad569e469..b7eb7dd96e17 100644
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
@@ -829,3 +831,14 @@ static int __init setnocoherentio(char *str)
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
index 01b8f6ca4dbb..000000000000
--- a/arch/powerpc/include/asm/bugs.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-#ifndef _ASM_POWERPC_BUGS_H
-#define _ASM_POWERPC_BUGS_H
-
-/*
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
index b6f3d49991d3..44dffe7ce50a 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -5,6 +5,7 @@ config SUPERH
 	select ARCH_HAVE_CUSTOM_GPIO_H
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if (GUSA_RB || CPU_SH4A)
 	select ARCH_HAS_BINFMT_FLAT if !MMU
+	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_PTE_SPECIAL
diff --git a/arch/sh/include/asm/bugs.h b/arch/sh/include/asm/bugs.h
deleted file mode 100644
index fe52abb69cea..000000000000
--- a/arch/sh/include/asm/bugs.h
+++ /dev/null
@@ -1,74 +0,0 @@
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
index 3820d698846e..97af2d9b0269 100644
--- a/arch/sh/include/asm/processor.h
+++ b/arch/sh/include/asm/processor.h
@@ -167,6 +167,8 @@ extern unsigned int instruction_size(unsigned int insn);
 #define instruction_size(insn)	(2)
 #endif
 
+void select_idle_routine(void);
+
 #endif /* __ASSEMBLY__ */
 
 #include <asm/processor_32.h>
diff --git a/arch/sh/kernel/idle.c b/arch/sh/kernel/idle.c
index f59814983bd5..a80b2a5b25c7 100644
--- a/arch/sh/kernel/idle.c
+++ b/arch/sh/kernel/idle.c
@@ -14,6 +14,7 @@
 #include <linux/irqflags.h>
 #include <linux/smp.h>
 #include <linux/atomic.h>
+#include <asm/processor.h>
 #include <asm/smp.h>
 #include <asm/bl_bit.h>
 
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 556e463a43d2..805c02eef5ac 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -43,6 +43,7 @@
 #include <asm/smp.h>
 #include <asm/mmu_context.h>
 #include <asm/mmzone.h>
+#include <asm/processor.h>
 #include <asm/sparsemem.h>
 #include <asm/platform_early.h>
 
@@ -357,3 +358,57 @@ int test_mode_pin(int pin)
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
index b5ed89342059..7e2ce4c8d657 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -56,6 +56,7 @@ config SPARC
 config SPARC32
 	def_bool !64BIT
 	select ARCH_32BIT_OFF_T
+	select ARCH_HAS_CPU_FINALIZE_INIT if !SMP
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select GENERIC_ATOMIC64
 	select CLZ_TAB
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
index eea43a1aef1b..8e2c7c1aad83 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -415,3 +415,10 @@ static int __init topology_init(void)
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
index 1c57599b82fa..eb1c6880bde4 100644
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
index 55930ca498e9..ca5383a8a988 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  */
 
+#include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/mm.h>
@@ -353,7 +354,7 @@ void __init setup_arch(char **cmdline_p)
 	setup_hostinfo(host_info, sizeof host_info);
 }
 
-void __init check_bugs(void)
+void __init arch_cpu_finalize_init(void)
 {
 	arch_check_bugs();
 	os_check_bugs();
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2284666e8c90..6dc670e36393 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -59,6 +59,7 @@ config X86
 	select ARCH_32BIT_OFF_T			if X86_32
 	select ARCH_CLOCKSOURCE_INIT
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
+	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE	if !X86_PAE
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
@@ -2475,6 +2476,13 @@ config CPU_IBRS_ENTRY
 	  This mitigates both spectre_v2 and retbleed at great cost to
 	  performance.
 
+config CPU_SRSO
+	bool "Mitigate speculative RAS overflow on AMD"
+	depends on CPU_SUP_AMD && X86_64 && RETHUNK
+	default y
+	help
+	  Enable the SRSO mitigation needed on AMD Zen1-4 machines.
+
 config SLS
 	bool "Mitigate Straight-Line-Speculation"
 	depends on CC_HAS_SLS && X86_64
@@ -2484,6 +2492,25 @@ config SLS
 	  against straight line speculation. The kernel image might be slightly
 	  larger.
 
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
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/include/asm/bugs.h b/arch/x86/include/asm/bugs.h
index 92ae28389940..f25ca2d709d4 100644
--- a/arch/x86/include/asm/bugs.h
+++ b/arch/x86/include/asm/bugs.h
@@ -4,8 +4,6 @@
 
 #include <asm/processor.h>
 
-extern void check_bugs(void);
-
 #if defined(CONFIG_CPU_SUP_INTEL) && defined(CONFIG_X86_32)
 int ppro_with_ram_bug(void);
 #else
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index f4cbc01c0bc4..cc3f62f5d551 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -31,6 +31,8 @@ enum cpuid_leafs
 	CPUID_7_ECX,
 	CPUID_8000_0007_EBX,
 	CPUID_7_EDX,
+	CPUID_8000_001F_EAX,
+	CPUID_8000_0021_EAX,
 };
 
 #ifdef CONFIG_X86_FEATURE_NAMES
@@ -89,8 +91,10 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 16, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 17, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 18, feature_bit) ||	\
+	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 19, feature_bit) ||	\
+	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 20, feature_bit) ||	\
 	   REQUIRED_MASK_CHECK					  ||	\
-	   BUILD_BUG_ON_ZERO(NCAPINTS != 19))
+	   BUILD_BUG_ON_ZERO(NCAPINTS != 21))
 
 #define DISABLED_MASK_BIT_SET(feature_bit)				\
 	 ( CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  0, feature_bit) ||	\
@@ -112,8 +116,10 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 16, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 17, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 18, feature_bit) ||	\
+	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 19, feature_bit) ||	\
+	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 20, feature_bit) ||	\
 	   DISABLED_MASK_CHECK					  ||	\
-	   BUILD_BUG_ON_ZERO(NCAPINTS != 19))
+	   BUILD_BUG_ON_ZERO(NCAPINTS != 21))
 
 #define cpu_has(c, bit)							\
 	(__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 :	\
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 1fcda8263554..2c0c495b9cb6 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -13,8 +13,8 @@
 /*
  * Defines x86 CPU feature bits
  */
-#define NCAPINTS			19	   /* N 32-bit words worth of info */
-#define NBUGINTS			1	   /* N 32-bit bug flags */
+#define NCAPINTS			21	   /* N 32-bit words worth of info */
+#define NBUGINTS			2	   /* N 32-bit bug flags */
 
 /*
  * Note: If the comment begins with a quoted string, that string is used
@@ -96,7 +96,7 @@
 #define X86_FEATURE_SYSCALL32		( 3*32+14) /* "" syscall in IA32 userspace */
 #define X86_FEATURE_SYSENTER32		( 3*32+15) /* "" sysenter in IA32 userspace */
 #define X86_FEATURE_REP_GOOD		( 3*32+16) /* REP microcode works well */
-#define X86_FEATURE_SME_COHERENT	( 3*32+17) /* "" AMD hardware-enforced cache coherency */
+/* FREE!                                ( 3*32+17) */
 #define X86_FEATURE_LFENCE_RDTSC	( 3*32+18) /* "" LFENCE synchronizes RDTSC */
 #define X86_FEATURE_ACC_POWER		( 3*32+19) /* AMD Accumulated Power Mechanism */
 #define X86_FEATURE_NOPL		( 3*32+20) /* The NOPL (0F 1F) instructions */
@@ -201,7 +201,7 @@
 #define X86_FEATURE_INVPCID_SINGLE	( 7*32+ 7) /* Effectively INVPCID && CR4.PCIDE=1 */
 #define X86_FEATURE_HW_PSTATE		( 7*32+ 8) /* AMD HW-PState */
 #define X86_FEATURE_PROC_FEEDBACK	( 7*32+ 9) /* AMD ProcFeedbackInterface */
-#define X86_FEATURE_SME			( 7*32+10) /* AMD Secure Memory Encryption */
+/* FREE!                                ( 7*32+10) */
 #define X86_FEATURE_PTI			( 7*32+11) /* Kernel Page Table Isolation enabled */
 #define X86_FEATURE_KERNEL_IBRS		( 7*32+12) /* "" Set/clear IBRS on kernel entry/exit */
 #define X86_FEATURE_RSB_VMEXIT		( 7*32+13) /* "" Fill RSB on VM-Exit */
@@ -211,7 +211,7 @@
 #define X86_FEATURE_SSBD		( 7*32+17) /* Speculative Store Bypass Disable */
 #define X86_FEATURE_MBA			( 7*32+18) /* Memory Bandwidth Allocation */
 #define X86_FEATURE_RSB_CTXSW		( 7*32+19) /* "" Fill RSB on context switches */
-#define X86_FEATURE_SEV			( 7*32+20) /* AMD Secure Encrypted Virtualization */
+/* FREE!                                ( 7*32+20) */
 #define X86_FEATURE_USE_IBPB		( 7*32+21) /* "" Indirect Branch Prediction Barrier enabled */
 #define X86_FEATURE_USE_IBRS_FW		( 7*32+22) /* "" Use IBRS during runtime firmware calls */
 #define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE	( 7*32+23) /* "" Disable Speculative Store Bypass. */
@@ -236,7 +236,6 @@
 #define X86_FEATURE_EPT_AD		( 8*32+17) /* Intel Extended Page Table access-dirty bit */
 #define X86_FEATURE_VMCALL		( 8*32+18) /* "" Hypervisor supports the VMCALL instruction */
 #define X86_FEATURE_VMW_VMMCALL		( 8*32+19) /* "" VMware prefers VMMCALL hypercall instruction */
-#define X86_FEATURE_SEV_ES		( 8*32+20) /* AMD Secure Encrypted Virtualization - Encrypted State */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
 #define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* RDFSBASE, WRFSBASE, RDGSBASE, WRGSBASE instructions*/
@@ -302,6 +301,10 @@
 #define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on VM exit when EIBRS is enabled */
 #define X86_FEATURE_MSR_TSX_CTRL	(11*32+18) /* "" MSR IA32_TSX_CTRL (Intel) implemented */
 
+#define X86_FEATURE_SRSO		(11*32+24) /* "" AMD BTB untrain RETs */
+#define X86_FEATURE_SRSO_ALIAS		(11*32+25) /* "" AMD BTB untrain RETs through aliasing */
+#define X86_FEATURE_IBPB_ON_VMEXIT	(11*32+26) /* "" Issue an IBPB only on VMEXIT */
+
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
 
@@ -393,6 +396,17 @@
 #define X86_FEATURE_CORE_CAPABILITIES	(18*32+30) /* "" IA32_CORE_CAPABILITIES MSR */
 #define X86_FEATURE_SPEC_CTRL_SSBD	(18*32+31) /* "" Speculative Store Bypass Disable */
 
+/* AMD-defined memory encryption features, CPUID level 0x8000001f (EAX), word 19 */
+#define X86_FEATURE_SME			(19*32+ 0) /* AMD Secure Memory Encryption */
+#define X86_FEATURE_SEV			(19*32+ 1) /* AMD Secure Encrypted Virtualization */
+#define X86_FEATURE_VM_PAGE_FLUSH	(19*32+ 2) /* "" VM Page Flush MSR is supported */
+#define X86_FEATURE_SEV_ES		(19*32+ 3) /* AMD Secure Encrypted Virtualization - Encrypted State */
+#define X86_FEATURE_SME_COHERENT	(19*32+10) /* "" AMD hardware-enforced cache coherency */
+
+#define X86_FEATURE_SBPB		(20*32+27) /* "" Selective Branch Prediction Barrier */
+#define X86_FEATURE_IBPB_BRTYPE		(20*32+28) /* "" MSR_PRED_CMD[IBPB] flushes all branch type predictions */
+#define X86_FEATURE_SRSO_NO		(20*32+29) /* "" CPU is not affected by SRSO */
+
 /*
  * BUG word(s)
  */
@@ -433,5 +447,8 @@
 #define X86_BUG_MMIO_UNKNOWN		X86_BUG(26) /* CPU is too old and its MMIO Stale Data status is unknown */
 #define X86_BUG_RETBLEED		X86_BUG(27) /* CPU is affected by RETBleed */
 #define X86_BUG_EIBRS_PBRSB		X86_BUG(28) /* EIBRS is vulnerable to Post Barrier RSB Predictions */
+#define X86_BUG_GDS			X86_BUG(29) /* CPU is affected by Gather Data Sampling */
 
+/* BUG word 2 */
+#define X86_BUG_SRSO			X86_BUG(1*32 + 0) /* AMD SRSO bug */
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 16c24915210d..3c24378e67be 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -101,6 +101,8 @@
 			 DISABLE_ENQCMD)
 #define DISABLED_MASK17	0
 #define DISABLED_MASK18	0
-#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 19)
+#define DISABLED_MASK19	0
+#define DISABLED_MASK20	0
+#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 21)
 
 #endif /* _ASM_X86_DISABLED_FEATURES_H */
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 70b9bc5403c5..94c07151a9e5 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -42,7 +42,7 @@ extern int  fpu__exception_code(struct fpu *fpu, int trap_nr);
 extern void fpu__init_cpu(void);
 extern void fpu__init_system_xstate(void);
 extern void fpu__init_cpu_xstate(void);
-extern void fpu__init_system(struct cpuinfo_x86 *c);
+extern void fpu__init_system(void);
 extern void fpu__init_check_bugs(void);
 extern void fpu__resume_cpu(void);
 extern u64 fpu__get_supported_xfeatures_mask(void);
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 8f3fa55d43ce..4406d58cf7cb 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -47,14 +47,13 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
 
 void __init mem_encrypt_free_decrypted_mem(void);
 
-/* Architecture __weak replacement functions */
-void __init mem_encrypt_init(void);
-
 void __init sev_es_init_vc_handling(void);
 bool sme_active(void);
 bool sev_active(void);
 bool sev_es_active(void);
 
+void __init mem_encrypt_init(void);
+
 #define __bss_decrypted __section(".bss..decrypted")
 
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
@@ -86,6 +85,8 @@ early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0;
 
 static inline void mem_encrypt_free_decrypted_mem(void) { }
 
+static inline void mem_encrypt_init(void) { }
+
 #define __bss_decrypted
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3fab152809ab..202a52e42a36 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -60,6 +60,7 @@
 
 #define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
 #define PRED_CMD_IBPB			BIT(0)	   /* Indirect Branch Prediction Barrier */
+#define PRED_CMD_SBPB			BIT(7)	   /* Selective Branch Prediction Barrier */
 
 #define MSR_PPIN_CTL			0x0000004e
 #define MSR_PPIN			0x0000004f
@@ -156,6 +157,15 @@
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
@@ -174,6 +184,8 @@
 #define MSR_IA32_MCU_OPT_CTRL		0x00000123
 #define RNGDS_MITG_DIS			BIT(0)
 #define FB_CLEAR_DIS			BIT(3)	/* CPU Fill buffer clear disable */
+#define GDS_MITG_DIS			BIT(4)	/* Disable GDS mitigation */
+#define GDS_MITG_LOCKED			BIT(5)	/* GDS mitigation locked */
 
 #define MSR_IA32_SYSENTER_CS		0x00000174
 #define MSR_IA32_SYSENTER_ESP		0x00000175
@@ -519,6 +531,7 @@
 #define MSR_AMD64_ICIBSEXTDCTL		0xc001103c
 #define MSR_AMD64_IBSOPDATA4		0xc001103d
 #define MSR_AMD64_IBS_REG_COUNT_MAX	8 /* includes MSR_AMD64_IBSBRTARGET */
+#define MSR_AMD64_VM_PAGE_FLUSH		0xc001011e
 #define MSR_AMD64_SEV_ES_GHCB		0xc0010130
 #define MSR_AMD64_SEV			0xc0010131
 #define MSR_AMD64_SEV_ENABLED_BIT	0
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index f14cdf951249..99fbce2c1c7c 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -112,7 +112,7 @@
  * eventually turn into it's own annotation.
  */
 .macro ANNOTATE_UNRET_END
-#ifdef CONFIG_DEBUG_ENTRY
+#if (defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_SRSO))
 	ANNOTATE_RETPOLINE_SAFE
 	nop
 #endif
@@ -173,12 +173,18 @@
  * where we have a stack but before any RET instruction.
  */
 .macro UNTRAIN_RET
-#if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY)
+#if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
+	defined(CONFIG_CPU_SRSO)
 	ANNOTATE_UNRET_END
 	ALTERNATIVE_2 "",						\
 	              CALL_ZEN_UNTRAIN_RET, X86_FEATURE_UNRET,		\
 		      "call entry_ibpb", X86_FEATURE_ENTRY_IBPB
 #endif
+
+#ifdef CONFIG_CPU_SRSO
+	ALTERNATIVE_2 "", "call srso_untrain_ret", X86_FEATURE_SRSO, \
+			  "call srso_untrain_ret_alias", X86_FEATURE_SRSO_ALIAS
+#endif
 .endm
 
 #else /* __ASSEMBLY__ */
@@ -191,6 +197,8 @@
 
 extern void __x86_return_thunk(void);
 extern void zen_untrain_ret(void);
+extern void srso_untrain_ret(void);
+extern void srso_untrain_ret_alias(void);
 extern void entry_ibpb(void);
 
 #ifdef CONFIG_RETPOLINE
@@ -300,11 +308,11 @@ void alternative_msr_write(unsigned int msr, u64 val, unsigned int feature)
 		: "memory");
 }
 
+extern u64 x86_pred_cmd;
+
 static inline void indirect_branch_prediction_barrier(void)
 {
-	u64 val = PRED_CMD_IBPB;
-
-	alternative_msr_write(MSR_IA32_PRED_CMD, val, X86_FEATURE_USE_IBPB);
+	alternative_msr_write(MSR_IA32_PRED_CMD, x86_pred_cmd, X86_FEATURE_USE_IBPB);
 }
 
 /* The Intel SPEC CTRL MSR base value cache */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 60514502ead6..6a9de5b1fe45 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -808,9 +808,11 @@ DECLARE_PER_CPU(u64, msr_misc_features_shadow);
 #ifdef CONFIG_CPU_SUP_AMD
 extern u16 amd_get_nb_id(int cpu);
 extern u32 amd_get_nodes_per_socket(void);
+extern bool cpu_has_ibpb_brtype_microcode(void);
 #else
 static inline u16 amd_get_nb_id(int cpu)		{ return 0; }
 static inline u32 amd_get_nodes_per_socket(void)	{ return 0; }
+static inline bool cpu_has_ibpb_brtype_microcode(void)	{ return false; }
 #endif
 
 static inline uint32_t hypervisor_cpuid_base(const char *sig, uint32_t leaves)
diff --git a/arch/x86/include/asm/required-features.h b/arch/x86/include/asm/required-features.h
index 3ff0d48469f2..9bf60a8b9e9c 100644
--- a/arch/x86/include/asm/required-features.h
+++ b/arch/x86/include/asm/required-features.h
@@ -101,6 +101,8 @@
 #define REQUIRED_MASK16	0
 #define REQUIRED_MASK17	0
 #define REQUIRED_MASK18	0
-#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 19)
+#define REQUIRED_MASK19	0
+#define REQUIRED_MASK20	0
+#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 21)
 
 #endif /* _ASM_X86_REQUIRED_FEATURES_H */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 3d99a823ffac..ffecf4e9444e 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1282,6 +1282,25 @@ void set_dr_addr_mask(unsigned long mask, int dr)
 	}
 }
 
+bool cpu_has_ibpb_brtype_microcode(void)
+{
+	switch (boot_cpu_data.x86) {
+	/* Zen1/2 IBPB flushes branch type predictions too. */
+	case 0x17:
+		return boot_cpu_has(X86_FEATURE_AMD_IBPB);
+	case 0x19:
+		/* Poke the MSR bit on Zen3/4 to check its presence. */
+		if (!wrmsrl_safe(MSR_IA32_PRED_CMD, PRED_CMD_SBPB)) {
+			setup_force_cpu_cap(X86_FEATURE_SBPB);
+			return true;
+		} else {
+			return false;
+		}
+	default:
+		return false;
+	}
+}
+
 static void zenbleed_check_cpu(void *unused)
 {
 	struct cpuinfo_x86 *c = &cpu_data(smp_processor_id());
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index c81b8b029b68..d31639e3ce28 100644
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
@@ -27,8 +26,6 @@
 #include <asm/msr.h>
 #include <asm/vmx.h>
 #include <asm/paravirt.h>
-#include <asm/alternative.h>
-#include <asm/set_memory.h>
 #include <asm/intel-family.h>
 #include <asm/e820/api.h>
 #include <asm/hypervisor.h>
@@ -48,6 +45,8 @@ static void __init md_clear_select_mitigation(void);
 static void __init taa_select_mitigation(void);
 static void __init mmio_select_mitigation(void);
 static void __init srbds_select_mitigation(void);
+static void __init gds_select_mitigation(void);
+static void __init srso_select_mitigation(void);
 
 /* The base value of the SPEC_CTRL MSR without task-specific bits set */
 u64 x86_spec_ctrl_base;
@@ -57,6 +56,9 @@ EXPORT_SYMBOL_GPL(x86_spec_ctrl_base);
 DEFINE_PER_CPU(u64, x86_spec_ctrl_current);
 EXPORT_SYMBOL_GPL(x86_spec_ctrl_current);
 
+u64 x86_pred_cmd __ro_after_init = PRED_CMD_IBPB;
+EXPORT_SYMBOL_GPL(x86_pred_cmd);
+
 static DEFINE_MUTEX(spec_ctrl_mutex);
 
 /* Update SPEC_CTRL MSR and its cached copy unconditionally */
@@ -116,21 +118,8 @@ EXPORT_SYMBOL_GPL(mds_idle_clear);
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
@@ -166,39 +155,8 @@ void __init check_bugs(void)
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
+	srso_select_mitigation();
 }
 
 /*
@@ -656,6 +614,149 @@ static int __init srbds_parse_cmdline(char *str)
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
 
@@ -2137,6 +2238,165 @@ static int __init l1tf_cmdline(char *str)
 }
 early_param("l1tf", l1tf_cmdline);
 
+#undef pr_fmt
+#define pr_fmt(fmt)	"Speculative Return Stack Overflow: " fmt
+
+enum srso_mitigation {
+	SRSO_MITIGATION_NONE,
+	SRSO_MITIGATION_MICROCODE,
+	SRSO_MITIGATION_SAFE_RET,
+	SRSO_MITIGATION_IBPB,
+	SRSO_MITIGATION_IBPB_ON_VMEXIT,
+};
+
+enum srso_mitigation_cmd {
+	SRSO_CMD_OFF,
+	SRSO_CMD_MICROCODE,
+	SRSO_CMD_SAFE_RET,
+	SRSO_CMD_IBPB,
+	SRSO_CMD_IBPB_ON_VMEXIT,
+};
+
+static const char * const srso_strings[] = {
+	[SRSO_MITIGATION_NONE]           = "Vulnerable",
+	[SRSO_MITIGATION_MICROCODE]      = "Mitigation: microcode",
+	[SRSO_MITIGATION_SAFE_RET]	 = "Mitigation: safe RET",
+	[SRSO_MITIGATION_IBPB]		 = "Mitigation: IBPB",
+	[SRSO_MITIGATION_IBPB_ON_VMEXIT] = "Mitigation: IBPB on VMEXIT only"
+};
+
+static enum srso_mitigation srso_mitigation __ro_after_init = SRSO_MITIGATION_NONE;
+static enum srso_mitigation_cmd srso_cmd __ro_after_init = SRSO_CMD_SAFE_RET;
+
+static int __init srso_parse_cmdline(char *str)
+{
+	if (!str)
+		return -EINVAL;
+
+	if (!strcmp(str, "off"))
+		srso_cmd = SRSO_CMD_OFF;
+	else if (!strcmp(str, "microcode"))
+		srso_cmd = SRSO_CMD_MICROCODE;
+	else if (!strcmp(str, "safe-ret"))
+		srso_cmd = SRSO_CMD_SAFE_RET;
+	else if (!strcmp(str, "ibpb"))
+		srso_cmd = SRSO_CMD_IBPB;
+	else if (!strcmp(str, "ibpb-vmexit"))
+		srso_cmd = SRSO_CMD_IBPB_ON_VMEXIT;
+	else
+		pr_err("Ignoring unknown SRSO option (%s).", str);
+
+	return 0;
+}
+early_param("spec_rstack_overflow", srso_parse_cmdline);
+
+#define SRSO_NOTICE "WARNING: See https://kernel.org/doc/html/latest/admin-guide/hw-vuln/srso.html for mitigation options."
+
+static void __init srso_select_mitigation(void)
+{
+	bool has_microcode;
+
+	if (!boot_cpu_has_bug(X86_BUG_SRSO) || cpu_mitigations_off())
+		goto pred_cmd;
+
+	/*
+	 * The first check is for the kernel running as a guest in order
+	 * for guests to verify whether IBPB is a viable mitigation.
+	 */
+	has_microcode = boot_cpu_has(X86_FEATURE_IBPB_BRTYPE) || cpu_has_ibpb_brtype_microcode();
+	if (!has_microcode) {
+		pr_warn("IBPB-extending microcode not applied!\n");
+		pr_warn(SRSO_NOTICE);
+	} else {
+		/*
+		 * Enable the synthetic (even if in a real CPUID leaf)
+		 * flags for guests.
+		 */
+		setup_force_cpu_cap(X86_FEATURE_IBPB_BRTYPE);
+
+		/*
+		 * Zen1/2 with SMT off aren't vulnerable after the right
+		 * IBPB microcode has been applied.
+		 */
+		if ((boot_cpu_data.x86 < 0x19) &&
+		    (!cpu_smt_possible() || (cpu_smt_control == CPU_SMT_DISABLED)))
+			setup_force_cpu_cap(X86_FEATURE_SRSO_NO);
+	}
+
+	if (retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
+		if (has_microcode) {
+			pr_err("Retbleed IBPB mitigation enabled, using same for SRSO\n");
+			srso_mitigation = SRSO_MITIGATION_IBPB;
+			goto pred_cmd;
+		}
+	}
+
+	switch (srso_cmd) {
+	case SRSO_CMD_OFF:
+		return;
+
+	case SRSO_CMD_MICROCODE:
+		if (has_microcode) {
+			srso_mitigation = SRSO_MITIGATION_MICROCODE;
+			pr_warn(SRSO_NOTICE);
+		}
+		break;
+
+	case SRSO_CMD_SAFE_RET:
+		if (IS_ENABLED(CONFIG_CPU_SRSO)) {
+			/*
+			 * Enable the return thunk for generated code
+			 * like ftrace, static_call, etc.
+			 */
+			setup_force_cpu_cap(X86_FEATURE_RETHUNK);
+
+			if (boot_cpu_data.x86 == 0x19)
+				setup_force_cpu_cap(X86_FEATURE_SRSO_ALIAS);
+			else
+				setup_force_cpu_cap(X86_FEATURE_SRSO);
+			srso_mitigation = SRSO_MITIGATION_SAFE_RET;
+		} else {
+			pr_err("WARNING: kernel not compiled with CPU_SRSO.\n");
+			goto pred_cmd;
+		}
+		break;
+
+	case SRSO_CMD_IBPB:
+		if (IS_ENABLED(CONFIG_CPU_IBPB_ENTRY)) {
+			if (has_microcode) {
+				setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
+				srso_mitigation = SRSO_MITIGATION_IBPB;
+			}
+		} else {
+			pr_err("WARNING: kernel not compiled with CPU_IBPB_ENTRY.\n");
+			goto pred_cmd;
+		}
+		break;
+
+	case SRSO_CMD_IBPB_ON_VMEXIT:
+		if (IS_ENABLED(CONFIG_CPU_SRSO)) {
+			if (!boot_cpu_has(X86_FEATURE_ENTRY_IBPB) && has_microcode) {
+				setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
+				srso_mitigation = SRSO_MITIGATION_IBPB_ON_VMEXIT;
+			}
+		} else {
+			pr_err("WARNING: kernel not compiled with CPU_SRSO.\n");
+			goto pred_cmd;
+                }
+		break;
+
+	default:
+		break;
+	}
+
+	pr_info("%s%s\n", srso_strings[srso_mitigation], (has_microcode ? "" : ", no microcode"));
+
+pred_cmd:
+	if ((boot_cpu_has(X86_FEATURE_SRSO_NO) || srso_cmd == SRSO_CMD_OFF) &&
+	     boot_cpu_has(X86_FEATURE_SBPB))
+		x86_pred_cmd = PRED_CMD_SBPB;
+}
+
 #undef pr_fmt
 #define pr_fmt(fmt) fmt
 
@@ -2335,6 +2595,18 @@ static ssize_t retbleed_show_state(char *buf)
 	return sprintf(buf, "%s\n", retbleed_strings[retbleed_mitigation]);
 }
 
+static ssize_t gds_show_state(char *buf)
+{
+	return sysfs_emit(buf, "%s\n", gds_strings[gds_mitigation]);
+}
+
+static ssize_t srso_show_state(char *buf)
+{
+	return sysfs_emit(buf, "%s%s\n",
+			  srso_strings[srso_mitigation],
+			  (cpu_has_ibpb_brtype_microcode() ? "" : ", no microcode"));
+}
+
 static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
 			       char *buf, unsigned int bug)
 {
@@ -2384,6 +2656,12 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
 	case X86_BUG_RETBLEED:
 		return retbleed_show_state(buf);
 
+	case X86_BUG_GDS:
+		return gds_show_state(buf);
+
+	case X86_BUG_SRSO:
+		return srso_show_state(buf);
+
 	default:
 		break;
 	}
@@ -2448,4 +2726,14 @@ ssize_t cpu_show_retbleed(struct device *dev, struct device_attribute *attr, cha
 {
 	return cpu_show_common(dev, attr, buf, X86_BUG_RETBLEED);
 }
+
+ssize_t cpu_show_gds(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return cpu_show_common(dev, attr, buf, X86_BUG_GDS);
+}
+
+ssize_t cpu_show_spec_rstack_overflow(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return cpu_show_common(dev, attr, buf, X86_BUG_SRSO);
+}
 #endif
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index f41781d06a5f..c1f236030912 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -18,11 +18,15 @@
 #include <linux/init.h>
 #include <linux/kprobes.h>
 #include <linux/kgdb.h>
+#include <linux/mem_encrypt.h>
 #include <linux/smp.h>
+#include <linux/cpu.h>
 #include <linux/io.h>
 #include <linux/syscore_ops.h>
 #include <linux/pgtable.h>
+#include <linux/utsname.h>
 
+#include <asm/alternative.h>
 #include <asm/cmdline.h>
 #include <asm/stackprotector.h>
 #include <asm/perf_event.h>
@@ -58,6 +62,7 @@
 #include <asm/intel-family.h>
 #include <asm/cpu_device_id.h>
 #include <asm/uv/uv.h>
+#include <asm/set_memory.h>
 
 #include "cpu.h"
 
@@ -961,6 +966,12 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 	if (c->extended_cpuid_level >= 0x8000000a)
 		c->x86_capability[CPUID_8000_000A_EDX] = cpuid_edx(0x8000000a);
 
+	if (c->extended_cpuid_level >= 0x8000001f)
+		c->x86_capability[CPUID_8000_001F_EAX] = cpuid_eax(0x8000001f);
+
+	if (c->extended_cpuid_level >= 0x80000021)
+		c->x86_capability[CPUID_8000_0021_EAX] = cpuid_eax(0x80000021);
+
 	init_scattered_cpuid_features(c);
 	init_speculation_control(c);
 
@@ -1122,6 +1133,12 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
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
@@ -1134,27 +1151,30 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL_STEPPINGS(BROADWELL_X,	X86_STEPPING_ANY,		MMIO),
 	VULNBL_INTEL_STEPPINGS(BROADWELL,	X86_STEPPING_ANY,		SRBDS),
 	VULNBL_INTEL_STEPPINGS(SKYLAKE_L,	X86_STEPPING_ANY,		SRBDS | MMIO | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(SKYLAKE_X,	X86_STEPPING_ANY,		MMIO | RETBLEED),
+	VULNBL_INTEL_STEPPINGS(SKYLAKE_X,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS),
 	VULNBL_INTEL_STEPPINGS(SKYLAKE,		X86_STEPPING_ANY,		SRBDS | MMIO | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(KABYLAKE_L,	X86_STEPPING_ANY,		SRBDS | MMIO | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(KABYLAKE,	X86_STEPPING_ANY,		SRBDS | MMIO | RETBLEED),
+	VULNBL_INTEL_STEPPINGS(KABYLAKE_L,	X86_STEPPING_ANY,		SRBDS | MMIO | RETBLEED | GDS),
+	VULNBL_INTEL_STEPPINGS(KABYLAKE,	X86_STEPPING_ANY,		SRBDS | MMIO | RETBLEED | GDS),
 	VULNBL_INTEL_STEPPINGS(CANNONLAKE_L,	X86_STEPPING_ANY,		RETBLEED),
-	VULNBL_INTEL_STEPPINGS(ICELAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(ICELAKE_D,	X86_STEPPING_ANY,		MMIO),
-	VULNBL_INTEL_STEPPINGS(ICELAKE_X,	X86_STEPPING_ANY,		MMIO),
-	VULNBL_INTEL_STEPPINGS(COMETLAKE,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED),
+	VULNBL_INTEL_STEPPINGS(ICELAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS),
+	VULNBL_INTEL_STEPPINGS(ICELAKE_D,	X86_STEPPING_ANY,		MMIO | GDS),
+	VULNBL_INTEL_STEPPINGS(ICELAKE_X,	X86_STEPPING_ANY,		MMIO | GDS),
+	VULNBL_INTEL_STEPPINGS(COMETLAKE,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS),
 	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPINGS(0x0, 0x0),	MMIO | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED),
+	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS),
+	VULNBL_INTEL_STEPPINGS(TIGERLAKE_L,	X86_STEPPING_ANY,		GDS),
+	VULNBL_INTEL_STEPPINGS(TIGERLAKE,	X86_STEPPING_ANY,		GDS),
 	VULNBL_INTEL_STEPPINGS(LAKEFIELD,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(ROCKETLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED),
+	VULNBL_INTEL_STEPPINGS(ROCKETLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS),
 	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS),
 	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT_D,	X86_STEPPING_ANY,		MMIO),
 	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS),
 
 	VULNBL_AMD(0x15, RETBLEED),
 	VULNBL_AMD(0x16, RETBLEED),
-	VULNBL_AMD(0x17, RETBLEED),
+	VULNBL_AMD(0x17, RETBLEED | SRSO),
 	VULNBL_HYGON(0x18, RETBLEED),
+	VULNBL_AMD(0x19, SRSO),
 	{}
 };
 
@@ -1272,6 +1292,21 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
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
+	if (!cpu_has(c, X86_FEATURE_SRSO_NO)) {
+		if (cpu_matches(cpu_vuln_blacklist, SRSO))
+			setup_force_cpu_bug(X86_BUG_SRSO);
+	}
+
 	if (cpu_matches(cpu_vuln_whitelist, NO_MELTDOWN))
 		return;
 
@@ -1413,8 +1448,6 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 
 	cpu_set_core_cap_bits(c);
 
-	fpu__init_system(c);
-
 #ifdef CONFIG_X86_32
 	/*
 	 * Regardless of whether PCID is enumerated, the SDM says
@@ -1792,6 +1825,8 @@ void identify_secondary_cpu(struct cpuinfo_x86 *c)
 	validate_apic_and_package_id(c);
 	x86_spec_ctrl_setup_ap();
 	update_srbds_msr();
+	if (boot_cpu_has_bug(X86_BUG_GDS))
+		update_gds_msr();
 }
 
 static __init int setup_noclflush(char *arg)
@@ -2109,8 +2144,6 @@ void cpu_init(void)
 
 	doublefault_init_cpu_tss();
 
-	fpu__init_cpu();
-
 	if (is_uv_system())
 		uv_cpu_init();
 
@@ -2126,6 +2159,7 @@ void cpu_init_secondary(void)
 	 */
 	cpu_init_exception_handling();
 	cpu_init();
+	fpu__init_cpu();
 }
 #endif
 
@@ -2188,3 +2222,69 @@ void arch_smt_update(void)
 	/* Check whether IPI broadcasting can be enabled */
 	apic_smt_update();
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
index 91df90abc1d9..66e19380a899 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -78,9 +78,11 @@ extern void detect_ht(struct cpuinfo_x86 *c);
 extern void check_null_seg_clears_base(struct cpuinfo_x86 *c);
 
 unsigned int aperfmperf_get_khz(int cpu);
+void cpu_select_mitigations(void);
 
 extern void x86_spec_ctrl_setup_ap(void);
 extern void update_srbds_msr(void);
+extern void update_gds_msr(void);
 
 extern u64 x86_read_arch_cap_msr(void);
 
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 82fe492121bb..f1cd1b6fb99e 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -41,10 +41,6 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
-	{ X86_FEATURE_SME,		CPUID_EAX,  0, 0x8000001f, 0 },
-	{ X86_FEATURE_SEV,		CPUID_EAX,  1, 0x8000001f, 0 },
-	{ X86_FEATURE_SEV_ES,		CPUID_EAX,  3, 0x8000001f, 0 },
-	{ X86_FEATURE_SME_COHERENT,	CPUID_EAX, 10, 0x8000001f, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
 
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 3c0a621b9792..ed73f9b40706 100644
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
@@ -237,9 +237,9 @@ static void __init fpu__init_system_ctx_switch(void)
  * Called on the boot CPU once per system bootup, to set up the initial
  * FPU state that is later cloned into all processes:
  */
-void __init fpu__init_system(struct cpuinfo_x86 *c)
+void __init fpu__init_system(void)
 {
-	fpu__init_system_early_generic(c);
+	fpu__init_system_early_generic();
 
 	/*
 	 * The FPU has to be operational for some of the
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index a21cd2381fa8..4955cb5cc001 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -133,7 +133,20 @@ SECTIONS
 		LOCK_TEXT
 		KPROBES_TEXT
 		ALIGN_ENTRY_TEXT_BEGIN
+#ifdef CONFIG_CPU_SRSO
+		*(.text.__x86.rethunk_untrain)
+#endif
+
 		ENTRY_TEXT
+
+#ifdef CONFIG_CPU_SRSO
+		/*
+		 * See the comment above srso_untrain_ret_alias()'s
+		 * definition.
+		 */
+		. = srso_untrain_ret_alias | (1 << 2) | (1 << 8) | (1 << 14) | (1 << 20);
+		*(.text.__x86.rethunk_safe)
+#endif
 		ALIGN_ENTRY_TEXT_END
 		SOFTIRQENTRY_TEXT
 		STATIC_CALL_TEXT
@@ -142,13 +155,15 @@ SECTIONS
 
 #ifdef CONFIG_RETPOLINE
 		__indirect_thunk_start = .;
-		*(.text.__x86.*)
+		*(.text.__x86.indirect_thunk)
+		*(.text.__x86.return_thunk)
 		__indirect_thunk_end = .;
 #endif
 	} :text =0xcccc
 
 	/* End of text section, which should occupy whole number of pages */
 	_etext = .;
+
 	. = ALIGN(PAGE_SIZE);
 
 	X86_ALIGN_RODATA_BEGIN
@@ -502,6 +517,21 @@ INIT_PER_CPU(irq_stack_backing_store);
            "fixed_percpu_data is not at start of per-cpu area");
 #endif
 
+#ifdef CONFIG_RETHUNK
+. = ASSERT((__ret & 0x3f) == 0, "__ret not cacheline-aligned");
+. = ASSERT((srso_safe_ret & 0x3f) == 0, "srso_safe_ret not cacheline-aligned");
+#endif
+
+#ifdef CONFIG_CPU_SRSO
+/*
+ * GNU ld cannot do XOR so do: (A | B) - (A & B) in order to compute the XOR
+ * of the two function addresses:
+ */
+. = ASSERT(((srso_untrain_ret_alias | srso_safe_ret_alias) -
+		(srso_untrain_ret_alias & srso_safe_ret_alias)) == ((1 << 2) | (1 << 8) | (1 << 14) | (1 << 20)),
+		"SRSO function pair won't alias");
+#endif
+
 #endif /* CONFIG_X86_32 */
 
 #ifdef CONFIG_KEXEC_CORE
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index de4b171cb76b..8b07e48612d7 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -491,6 +491,9 @@ void kvm_set_cpu_caps(void)
 	    !boot_cpu_has(X86_FEATURE_AMD_SSBD))
 		kvm_cpu_cap_set(X86_FEATURE_VIRT_SSBD);
 
+	if (cpu_feature_enabled(X86_FEATURE_SRSO_NO))
+		kvm_cpu_cap_set(X86_FEATURE_SRSO_NO);
+
 	/*
 	 * Hide all SVM features by default, SVM will set the cap bits for
 	 * features it emulates and/or exposes for L1.
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index dc921d76e42e..1ba9313d26b9 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -63,6 +63,7 @@ static const struct cpuid_reg reverse_cpuid[] = {
 	[CPUID_8000_0007_EBX] = {0x80000007, 0, CPUID_EBX},
 	[CPUID_7_EDX]         = {         7, 0, CPUID_EDX},
 	[CPUID_7_1_EAX]       = {         7, 1, CPUID_EAX},
+	[CPUID_8000_0021_EAX] = {0x80000021, 0, CPUID_EAX},
 };
 
 /*
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 7b2b61309d8a..8544bca6b335 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1392,7 +1392,9 @@ static void svm_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	if (sd->current_vmcb != svm->vmcb) {
 		sd->current_vmcb = svm->vmcb;
-		indirect_branch_prediction_barrier();
+
+		if (!cpu_feature_enabled(X86_FEATURE_IBPB_ON_VMEXIT))
+			indirect_branch_prediction_barrier();
 	}
 	avic_vcpu_load(vcpu, cpu);
 }
diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index c18d812d00cd..a8859c173258 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -137,6 +137,9 @@ SYM_FUNC_START(__svm_vcpu_run)
 	 */
 	UNTRAIN_RET
 
+	/* SRSO */
+	ALTERNATIVE "", "call entry_ibpb", X86_FEATURE_IBPB_ON_VMEXIT
+
 	/*
 	 * Clear all general purpose registers except RSP and RAX to prevent
 	 * speculative use of the guest's values, even those that are reloaded
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 34670943f543..cf4739200566 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -255,6 +255,8 @@ static struct kmem_cache *x86_fpu_cache;
 
 static struct kmem_cache *x86_emulator_cache;
 
+extern bool gds_ucode_mitigated(void);
+
 /*
  * When called, it means the previous get/set msr reached an invalid msr.
  * Return true if we want to ignore/silent this failed msr access.
@@ -1389,7 +1391,7 @@ static unsigned int num_msr_based_features;
 	 ARCH_CAP_SKIP_VMENTRY_L1DFLUSH | ARCH_CAP_SSB_NO | ARCH_CAP_MDS_NO | \
 	 ARCH_CAP_PSCHANGE_MC_NO | ARCH_CAP_TSX_CTRL_MSR | ARCH_CAP_TAA_NO | \
 	 ARCH_CAP_SBDR_SSDP_NO | ARCH_CAP_FBSDP_NO | ARCH_CAP_PSDP_NO | \
-	 ARCH_CAP_FB_CLEAR | ARCH_CAP_RRSBA | ARCH_CAP_PBRSB_NO)
+	 ARCH_CAP_FB_CLEAR | ARCH_CAP_RRSBA | ARCH_CAP_PBRSB_NO | ARCH_CAP_GDS_NO)
 
 static u64 kvm_get_arch_capabilities(void)
 {
@@ -1446,6 +1448,9 @@ static u64 kvm_get_arch_capabilities(void)
 		 */
 	}
 
+	if (!boot_cpu_has_bug(X86_BUG_GDS) || gds_ucode_mitigated())
+		data |= ARCH_CAP_GDS_NO;
+
 	return data;
 }
 
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 1221bb099afb..5f7eed97487e 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -9,6 +9,7 @@
 #include <asm/nospec-branch.h>
 #include <asm/unwind_hints.h>
 #include <asm/frame.h>
+#include <asm/nops.h>
 
 	.section .text.__x86.indirect_thunk
 
@@ -73,6 +74,45 @@ SYM_CODE_END(__x86_indirect_thunk_array)
  */
 #ifdef CONFIG_RETHUNK
 
+/*
+ * srso_untrain_ret_alias() and srso_safe_ret_alias() are placed at
+ * special addresses:
+ *
+ * - srso_untrain_ret_alias() is 2M aligned
+ * - srso_safe_ret_alias() is also in the same 2M page but bits 2, 8, 14
+ * and 20 in its virtual address are set (while those bits in the
+ * srso_untrain_ret_alias() function are cleared).
+ *
+ * This guarantees that those two addresses will alias in the branch
+ * target buffer of Zen3/4 generations, leading to any potential
+ * poisoned entries at that BTB slot to get evicted.
+ *
+ * As a result, srso_safe_ret_alias() becomes a safe return.
+ */
+#ifdef CONFIG_CPU_SRSO
+	.section .text.__x86.rethunk_untrain
+
+SYM_START(srso_untrain_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
+	ASM_NOP2
+	lfence
+	jmp __x86_return_thunk
+SYM_FUNC_END(srso_untrain_ret_alias)
+__EXPORT_THUNK(srso_untrain_ret_alias)
+
+	.section .text.__x86.rethunk_safe
+#endif
+
+/* Needs a definition for the __x86_return_thunk alternative below. */
+SYM_START(srso_safe_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
+#ifdef CONFIG_CPU_SRSO
+	add $8, %_ASM_SP
+	UNWIND_HINT_FUNC
+#endif
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+SYM_FUNC_END(srso_safe_ret_alias)
+
 	.section .text.__x86.return_thunk
 
 /*
@@ -85,7 +125,7 @@ SYM_CODE_END(__x86_indirect_thunk_array)
  *    from re-poisioning the BTB prediction.
  */
 	.align 64
-	.skip 63, 0xcc
+	.skip 64 - (__ret - zen_untrain_ret), 0xcc
 SYM_FUNC_START_NOALIGN(zen_untrain_ret);
 
 	/*
@@ -117,10 +157,10 @@ SYM_FUNC_START_NOALIGN(zen_untrain_ret);
 	 * evicted, __x86_return_thunk will suffer Straight Line Speculation
 	 * which will be contained safely by the INT3.
 	 */
-SYM_INNER_LABEL(__x86_return_thunk, SYM_L_GLOBAL)
+SYM_INNER_LABEL(__ret, SYM_L_GLOBAL)
 	ret
 	int3
-SYM_CODE_END(__x86_return_thunk)
+SYM_CODE_END(__ret)
 
 	/*
 	 * Ensure the TEST decoding / BTB invalidation is complete.
@@ -131,11 +171,44 @@ SYM_CODE_END(__x86_return_thunk)
 	 * Jump back and execute the RET in the middle of the TEST instruction.
 	 * INT3 is for SLS protection.
 	 */
-	jmp __x86_return_thunk
+	jmp __ret
 	int3
 SYM_FUNC_END(zen_untrain_ret)
 __EXPORT_THUNK(zen_untrain_ret)
 
+/*
+ * SRSO untraining sequence for Zen1/2, similar to zen_untrain_ret()
+ * above. On kernel entry, srso_untrain_ret() is executed which is a
+ *
+ * movabs $0xccccccc308c48348,%rax
+ *
+ * and when the return thunk executes the inner label srso_safe_ret()
+ * later, it is a stack manipulation and a RET which is mispredicted and
+ * thus a "safe" one to use.
+ */
+	.align 64
+	.skip 64 - (srso_safe_ret - srso_untrain_ret), 0xcc
+SYM_START(srso_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
+	.byte 0x48, 0xb8
+
+SYM_INNER_LABEL(srso_safe_ret, SYM_L_GLOBAL)
+	add $8, %_ASM_SP
+	ret
+	int3
+	int3
+	int3
+	lfence
+	call srso_safe_ret
+	int3
+SYM_CODE_END(srso_safe_ret)
+SYM_FUNC_END(srso_untrain_ret)
+__EXPORT_THUNK(srso_untrain_ret)
+
+SYM_FUNC_START(__x86_return_thunk)
+	ALTERNATIVE_2 "jmp __ret", "call srso_safe_ret", X86_FEATURE_SRSO, \
+			"call srso_safe_ret_alias", X86_FEATURE_SRSO_ALIAS
+	int3
+SYM_CODE_END(__x86_return_thunk)
 EXPORT_SYMBOL(__x86_return_thunk)
 
 #endif /* CONFIG_RETHUNK */
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index ff3b0d8fe048..dd15fdee4536 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -7,6 +7,7 @@
 #include <linux/swapops.h>
 #include <linux/kmemleak.h>
 #include <linux/sched/task.h>
+#include <linux/sched/mm.h>
 
 #include <asm/set_memory.h>
 #include <asm/cpu_device_id.h>
@@ -27,6 +28,7 @@
 #include <asm/pti.h>
 #include <asm/text-patching.h>
 #include <asm/memtype.h>
+#include <asm/paravirt.h>
 
 /*
  * We need to define the tracepoints somewhere, and tlb.c
@@ -804,9 +806,12 @@ void __init poking_init(void)
 	spinlock_t *ptl;
 	pte_t *ptep;
 
-	poking_mm = copy_init_mm();
+	poking_mm = mm_alloc();
 	BUG_ON(!poking_mm);
 
+	/* Xen PV guests need the PGD to be pinned. */
+	paravirt_arch_dup_mmap(NULL, poking_mm);
+
 	/*
 	 * Randomize the poking address, but make sure that the following page
 	 * will be mapped at the same PMD. We need 2 pages, so find space for 3,
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 64873937cd1d..755e939db3ed 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -30,6 +30,7 @@
 #include <asm/desc.h>
 #include <asm/cpu.h>
 #include <asm/io_apic.h>
+#include <asm/fpu/internal.h>
 
 #include <xen/interface/xen.h>
 #include <xen/interface/vcpu.h>
@@ -63,6 +64,7 @@ static void cpu_bringup(void)
 
 	cr4_init();
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
index 33e0526907eb..2db1e0e8c1a7 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -579,6 +579,18 @@ ssize_t __weak cpu_show_retbleed(struct device *dev,
 	return sysfs_emit(buf, "Not affected\n");
 }
 
+ssize_t __weak cpu_show_gds(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "Not affected\n");
+}
+
+ssize_t __weak cpu_show_spec_rstack_overflow(struct device *dev,
+					     struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "Not affected\n");
+}
+
 static DEVICE_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
 static DEVICE_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
 static DEVICE_ATTR(spectre_v2, 0444, cpu_show_spectre_v2, NULL);
@@ -590,6 +602,8 @@ static DEVICE_ATTR(itlb_multihit, 0444, cpu_show_itlb_multihit, NULL);
 static DEVICE_ATTR(srbds, 0444, cpu_show_srbds, NULL);
 static DEVICE_ATTR(mmio_stale_data, 0444, cpu_show_mmio_stale_data, NULL);
 static DEVICE_ATTR(retbleed, 0444, cpu_show_retbleed, NULL);
+static DEVICE_ATTR(gather_data_sampling, 0444, cpu_show_gds, NULL);
+static DEVICE_ATTR(spec_rstack_overflow, 0444, cpu_show_spec_rstack_overflow, NULL);
 
 static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_meltdown.attr,
@@ -603,6 +617,8 @@ static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_srbds.attr,
 	&dev_attr_mmio_stale_data.attr,
 	&dev_attr_retbleed.attr,
+	&dev_attr_gather_data_sampling.attr,
+	&dev_attr_spec_rstack_overflow.attr,
 	NULL
 };
 
diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
index 379ac9ca60b7..1c366ddf62bc 100644
--- a/drivers/net/xen-netback/netback.c
+++ b/drivers/net/xen-netback/netback.c
@@ -396,7 +396,7 @@ static void xenvif_get_requests(struct xenvif_queue *queue,
 	struct gnttab_map_grant_ref *gop = queue->tx_map_ops + *map_ops;
 	struct xen_netif_tx_request *txp = first;
 
-	nr_slots = shinfo->nr_frags + 1;
+	nr_slots = shinfo->nr_frags + frag_overflow + 1;
 
 	copy_count(skb) = 0;
 	XENVIF_TX_CB(skb)->split_mask = 0;
@@ -462,8 +462,8 @@ static void xenvif_get_requests(struct xenvif_queue *queue,
 		}
 	}
 
-	for (shinfo->nr_frags = 0; shinfo->nr_frags < nr_slots;
-	     shinfo->nr_frags++, gop++) {
+	for (shinfo->nr_frags = 0; nr_slots > 0 && shinfo->nr_frags < MAX_SKB_FRAGS;
+	     shinfo->nr_frags++, gop++, nr_slots--) {
 		index = pending_index(queue->pending_cons++);
 		pending_idx = queue->pending_ring[index];
 		xenvif_tx_create_map_op(queue, pending_idx, txp,
@@ -476,12 +476,12 @@ static void xenvif_get_requests(struct xenvif_queue *queue,
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
@@ -492,6 +492,11 @@ static void xenvif_get_requests(struct xenvif_queue *queue,
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
index 24e5f237244d..358905a85993 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -70,6 +70,8 @@ extern ssize_t cpu_show_mmio_stale_data(struct device *dev,
 					char *buf);
 extern ssize_t cpu_show_retbleed(struct device *dev,
 				 struct device_attribute *attr, char *buf);
+extern ssize_t cpu_show_spec_rstack_overflow(struct device *dev,
+					     struct device_attribute *attr, char *buf);
 
 extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,
@@ -188,6 +190,12 @@ void arch_cpu_idle_enter(void);
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
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 2832cc6be062..e8304e929e28 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -63,6 +63,7 @@ extern void sched_dead(struct task_struct *p);
 void __noreturn do_task_dead(void);
 void __noreturn make_task_dead(int signr);
 
+extern void mm_cache_init(void);
 extern void proc_caches_init(void);
 
 extern void fork_init(void);
@@ -89,7 +90,6 @@ extern void exit_itimers(struct task_struct *);
 extern pid_t kernel_clone(struct kernel_clone_args *kargs);
 struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node);
 struct task_struct *fork_idle(int);
-struct mm_struct *copy_init_mm(void);
 extern pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
 extern long kernel_wait4(pid_t, int __user *, int, struct rusage *);
 int kernel_wait(pid_t pid, int *stat);
diff --git a/init/main.c b/init/main.c
index d8bfe61b5a88..298989b0d4e8 100644
--- a/init/main.c
+++ b/init/main.c
@@ -95,12 +95,10 @@
 #include <linux/cache.h>
 #include <linux/rodata_test.h>
 #include <linux/jump_label.h>
-#include <linux/mem_encrypt.h>
 #include <linux/kcsan.h>
 #include <linux/init_syscalls.h>
 
 #include <asm/io.h>
-#include <asm/bugs.h>
 #include <asm/setup.h>
 #include <asm/sections.h>
 #include <asm/cacheflush.h>
@@ -774,8 +772,6 @@ void __init __weak thread_stack_cache_init(void)
 }
 #endif
 
-void __init __weak mem_encrypt_init(void) { }
-
 void __init __weak poking_init(void) { }
 
 void __init __weak pgtable_cache_init(void) { }
@@ -839,6 +835,7 @@ static void __init mm_init(void)
 	init_espfix_bsp();
 	/* Should be run after espfix64 is set up. */
 	pti_init();
+	mm_cache_init();
 }
 
 void __init __weak arch_call_rest_init(void)
@@ -903,7 +900,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	sort_main_extable();
 	trap_init();
 	mm_init();
-
+	poking_init();
 	ftrace_init();
 
 	/* trace_printk can be enabled here */
@@ -993,14 +990,6 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
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
@@ -1017,6 +1006,9 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 		late_time_init();
 	sched_clock_init();
 	calibrate_delay();
+
+	arch_cpu_finalize_init();
+
 	pid_idr_init();
 	anon_vma_init();
 #ifdef CONFIG_X86
@@ -1043,9 +1035,6 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	taskstats_init_early();
 	delayacct_init();
 
-	poking_init();
-	check_bugs();
-
 	acpi_subsystem_init();
 	arch_post_acpi_subsys_init();
 	sfi_init_late();
diff --git a/kernel/fork.c b/kernel/fork.c
index c6a289317e89..31455f5ab015 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2424,11 +2424,6 @@ struct task_struct * __init fork_idle(int cpu)
 	return task;
 }
 
-struct mm_struct *copy_init_mm(void)
-{
-	return dup_mm(NULL, &init_mm);
-}
-
 /*
  * This is like kernel_clone(), but shaved down and tailored to just
  * creating io_uring workers. It returns a created task, or an error pointer.
@@ -2823,10 +2818,27 @@ static void sighand_ctor(void *data)
 	init_waitqueue_head(&sighand->signalfd_wqh);
 }
 
-void __init proc_caches_init(void)
+void __init mm_cache_init(void)
 {
 	unsigned int mm_size;
 
+	/*
+	 * The mm_cpumask is located at the end of mm_struct, and is
+	 * dynamically sized based on the maximum CPU number this system
+	 * can have, taking hotplug into account (nr_cpu_ids).
+	 */
+	mm_size = sizeof(struct mm_struct) + cpumask_size();
+
+	mm_cachep = kmem_cache_create_usercopy("mm_struct",
+			mm_size, ARCH_MIN_MMSTRUCT_ALIGN,
+			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
+			offsetof(struct mm_struct, saved_auxv),
+			sizeof_field(struct mm_struct, saved_auxv),
+			NULL);
+}
+
+void __init proc_caches_init(void)
+{
 	sighand_cachep = kmem_cache_create("sighand_cache",
 			sizeof(struct sighand_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
@@ -2844,19 +2856,6 @@ void __init proc_caches_init(void)
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
 			NULL);
 
-	/*
-	 * The mm_cpumask is located at the end of mm_struct, and is
-	 * dynamically sized based on the maximum CPU number this system
-	 * can have, taking hotplug into account (nr_cpu_ids).
-	 */
-	mm_size = sizeof(struct mm_struct) + cpumask_size();
-
-	mm_cachep = kmem_cache_create_usercopy("mm_struct",
-			mm_size, ARCH_MIN_MMSTRUCT_ALIGN,
-			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
-			offsetof(struct mm_struct, saved_auxv),
-			sizeof_field(struct mm_struct, saved_auxv),
-			NULL);
 	vm_area_cachep = KMEM_CACHE(vm_area_struct, SLAB_PANIC|SLAB_ACCOUNT);
 	mmap_init();
 	nsproxy_cache_init();
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index ec53f52a06a5..2ae4d74ee73b 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -13,8 +13,8 @@
 /*
  * Defines x86 CPU feature bits
  */
-#define NCAPINTS			19	   /* N 32-bit words worth of info */
-#define NBUGINTS			1	   /* N 32-bit bug flags */
+#define NCAPINTS			20	   /* N 32-bit words worth of info */
+#define NBUGINTS			2	   /* N 32-bit bug flags */
 
 /*
  * Note: If the comment begins with a quoted string, that string is used
@@ -96,7 +96,7 @@
 #define X86_FEATURE_SYSCALL32		( 3*32+14) /* "" syscall in IA32 userspace */
 #define X86_FEATURE_SYSENTER32		( 3*32+15) /* "" sysenter in IA32 userspace */
 #define X86_FEATURE_REP_GOOD		( 3*32+16) /* REP microcode works well */
-#define X86_FEATURE_SME_COHERENT	( 3*32+17) /* "" AMD hardware-enforced cache coherency */
+/* FREE!                                ( 3*32+17) */
 #define X86_FEATURE_LFENCE_RDTSC	( 3*32+18) /* "" LFENCE synchronizes RDTSC */
 #define X86_FEATURE_ACC_POWER		( 3*32+19) /* AMD Accumulated Power Mechanism */
 #define X86_FEATURE_NOPL		( 3*32+20) /* The NOPL (0F 1F) instructions */
@@ -201,7 +201,7 @@
 #define X86_FEATURE_INVPCID_SINGLE	( 7*32+ 7) /* Effectively INVPCID && CR4.PCIDE=1 */
 #define X86_FEATURE_HW_PSTATE		( 7*32+ 8) /* AMD HW-PState */
 #define X86_FEATURE_PROC_FEEDBACK	( 7*32+ 9) /* AMD ProcFeedbackInterface */
-#define X86_FEATURE_SME			( 7*32+10) /* AMD Secure Memory Encryption */
+/* FREE!                                ( 7*32+10) */
 #define X86_FEATURE_PTI			( 7*32+11) /* Kernel Page Table Isolation enabled */
 #define X86_FEATURE_KERNEL_IBRS		( 7*32+12) /* "" Set/clear IBRS on kernel entry/exit */
 #define X86_FEATURE_RSB_VMEXIT		( 7*32+13) /* "" Fill RSB on VM-Exit */
@@ -211,7 +211,7 @@
 #define X86_FEATURE_SSBD		( 7*32+17) /* Speculative Store Bypass Disable */
 #define X86_FEATURE_MBA			( 7*32+18) /* Memory Bandwidth Allocation */
 #define X86_FEATURE_RSB_CTXSW		( 7*32+19) /* "" Fill RSB on context switches */
-#define X86_FEATURE_SEV			( 7*32+20) /* AMD Secure Encrypted Virtualization */
+/* FREE!                                ( 7*32+20) */
 #define X86_FEATURE_USE_IBPB		( 7*32+21) /* "" Indirect Branch Prediction Barrier enabled */
 #define X86_FEATURE_USE_IBRS_FW		( 7*32+22) /* "" Use IBRS during runtime firmware calls */
 #define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE	( 7*32+23) /* "" Disable Speculative Store Bypass. */
@@ -236,7 +236,6 @@
 #define X86_FEATURE_EPT_AD		( 8*32+17) /* Intel Extended Page Table access-dirty bit */
 #define X86_FEATURE_VMCALL		( 8*32+18) /* "" Hypervisor supports the VMCALL instruction */
 #define X86_FEATURE_VMW_VMMCALL		( 8*32+19) /* "" VMware prefers VMMCALL hypercall instruction */
-#define X86_FEATURE_SEV_ES		( 8*32+20) /* AMD Secure Encrypted Virtualization - Encrypted State */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
 #define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* RDFSBASE, WRFSBASE, RDGSBASE, WRGSBASE instructions*/
@@ -299,6 +298,7 @@
 #define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on VM-Exit when EIBRS is enabled */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
+#define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
 
 /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
@@ -343,6 +343,7 @@
 #define X86_FEATURE_AVIC		(15*32+13) /* Virtual Interrupt Controller */
 #define X86_FEATURE_V_VMSAVE_VMLOAD	(15*32+15) /* Virtual VMSAVE VMLOAD */
 #define X86_FEATURE_VGIF		(15*32+16) /* Virtual GIF */
+#define X86_FEATURE_SVME_ADDR_CHK	(15*32+28) /* "" SVME addr check */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (ECX), word 16 */
 #define X86_FEATURE_AVX512VBMI		(16*32+ 1) /* AVX512 Vector Bit Manipulation instructions*/
@@ -389,6 +390,13 @@
 #define X86_FEATURE_CORE_CAPABILITIES	(18*32+30) /* "" IA32_CORE_CAPABILITIES MSR */
 #define X86_FEATURE_SPEC_CTRL_SSBD	(18*32+31) /* "" Speculative Store Bypass Disable */
 
+/* AMD-defined memory encryption features, CPUID level 0x8000001f (EAX), word 19 */
+#define X86_FEATURE_SME			(19*32+ 0) /* AMD Secure Memory Encryption */
+#define X86_FEATURE_SEV			(19*32+ 1) /* AMD Secure Encrypted Virtualization */
+#define X86_FEATURE_VM_PAGE_FLUSH	(19*32+ 2) /* "" VM Page Flush MSR is supported */
+#define X86_FEATURE_SEV_ES		(19*32+ 3) /* AMD Secure Encrypted Virtualization - Encrypted State */
+#define X86_FEATURE_SME_COHERENT	(19*32+10) /* "" AMD hardware-enforced cache coherency */
+
 /*
  * BUG word(s)
  */
diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
index d109c5ec967c..a50f075244b4 100644
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ b/tools/arch/x86/include/asm/disabled-features.h
@@ -104,6 +104,7 @@
 			 DISABLE_ENQCMD)
 #define DISABLED_MASK17	0
 #define DISABLED_MASK18	0
-#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 19)
+#define DISABLED_MASK19	0
+#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 20)
 
 #endif /* _ASM_X86_DISABLED_FEATURES_H */
diff --git a/tools/arch/x86/include/asm/required-features.h b/tools/arch/x86/include/asm/required-features.h
index 3ff0d48469f2..b2d504f11937 100644
--- a/tools/arch/x86/include/asm/required-features.h
+++ b/tools/arch/x86/include/asm/required-features.h
@@ -101,6 +101,7 @@
 #define REQUIRED_MASK16	0
 #define REQUIRED_MASK17	0
 #define REQUIRED_MASK18	0
-#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 19)
+#define REQUIRED_MASK19	0
+#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 20)
 
 #endif /* _ASM_X86_REQUIRED_FEATURES_H */
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index d8f47704fd85..5b915ebb6116 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -652,5 +652,8 @@ bool arch_is_retpoline(struct symbol *sym)
 
 bool arch_is_rethunk(struct symbol *sym)
 {
-	return !strcmp(sym->name, "__x86_return_thunk");
+	return !strcmp(sym->name, "__x86_return_thunk") ||
+	       !strcmp(sym->name, "srso_untrain_ret") ||
+	       !strcmp(sym->name, "srso_safe_ret") ||
+	       !strcmp(sym->name, "__ret");
 }
