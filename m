Return-Path: <linux-kernel+bounces-138828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A839089FAD1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9412B1F27E19
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F6616F27E;
	Wed, 10 Apr 2024 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cjLI2U3a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1149116EC18;
	Wed, 10 Apr 2024 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712761048; cv=none; b=bIsh3jtTOBeDah3wO1bi9os+4hefwWiqGPHD1Dww2ImzKfvFFFgoYv3ZMDvHDs7u1WSfjD+5eQbb6mIC7415mbqIxSoDvU+71oqihZrpn0IhMMbXVwLjsuUrDYmKHcByLls+iJuESqaYigk4ABc49RIF3JETLlzPgLKGtEPRy+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712761048; c=relaxed/simple;
	bh=qrpqCxK1UpFqStOUDfdy3tEg7Tv9ogj/PVDHOiG29pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CvQXFp525Gvcp+VRFPh3ynxWtGH0T+jgYsfysFrzLgsNVz1ypQxtdrfBpHW5rd2gdW+sPWEGmsnFsovBFZTdCIw6tYWoOisaP92J1oCF0zXF/iDQ/BgUui9izhepNkGAg8DdZ4zn7/1BsC/86zQdxm2BfKPjWnWHEpMhLLOAVzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cjLI2U3a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9BBC43394;
	Wed, 10 Apr 2024 14:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712761047;
	bh=qrpqCxK1UpFqStOUDfdy3tEg7Tv9ogj/PVDHOiG29pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cjLI2U3aYLmZKdl4loB9+S7d+nBQMHiGfbi3w9ao3tgIaCoAzBRg4cGiov6dcJyZH
	 4NmVlhDEUldujNwms4WOvaG3Odp4AxpgJHQflpu5PWGM5uzBgCQowdf08K+5Wpt99S
	 X1rGzKpV8/bPePUBIMYcJ3H7ScEsFgrS1N9s9efk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.85
Date: Wed, 10 Apr 2024 16:57:15 +0200
Message-ID: <2024041015-next-usable-764b@gregkh>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <2024041015-spotlight-unselect-d4a5@gregkh>
References: <2024041015-spotlight-unselect-d4a5@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
index 32a8893e5617..9edb2860a3e1 100644
--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -138,11 +138,10 @@ associated with the source address of the indirect branch. Specifically,
 the BHB might be shared across privilege levels even in the presence of
 Enhanced IBRS.
 
-Currently the only known real-world BHB attack vector is via
-unprivileged eBPF. Therefore, it's highly recommended to not enable
-unprivileged eBPF, especially when eIBRS is used (without retpolines).
-For a full mitigation against BHB attacks, it's recommended to use
-retpolines (or eIBRS combined with retpolines).
+Previously the only known real-world BHB attack vector was via unprivileged
+eBPF. Further research has found attacks that don't require unprivileged eBPF.
+For a full mitigation against BHB attacks it is recommended to set BHI_DIS_S or
+use the BHB clearing sequence.
 
 Attack scenarios
 ----------------
@@ -430,6 +429,23 @@ The possible values in this file are:
   'PBRSB-eIBRS: Not affected'  CPU is not affected by PBRSB
   ===========================  =======================================================
 
+  - Branch History Injection (BHI) protection status:
+
+.. list-table::
+
+ * - BHI: Not affected
+   - System is not affected
+ * - BHI: Retpoline
+   - System is protected by retpoline
+ * - BHI: BHI_DIS_S
+   - System is protected by BHI_DIS_S
+ * - BHI: SW loop; KVM SW loop
+   - System is protected by software clearing sequence
+ * - BHI: Syscall hardening
+   - Syscalls are hardened against BHI
+ * - BHI: Syscall hardening; KVM: SW loop
+   - System is protected from userspace attacks by syscall hardening; KVM is protected by software clearing sequence
+
 Full mitigation might require a microcode update from the CPU
 vendor. When the necessary microcode is not available, the kernel will
 report vulnerability.
@@ -484,7 +500,11 @@ Spectre variant 2
 
    Systems which support enhanced IBRS (eIBRS) enable IBRS protection once at
    boot, by setting the IBRS bit, and they're automatically protected against
-   Spectre v2 variant attacks.
+   some Spectre v2 variant attacks. The BHB can still influence the choice of
+   indirect branch predictor entry, and although branch predictor entries are
+   isolated between modes when eIBRS is enabled, the BHB itself is not isolated
+   between modes. Systems which support BHI_DIS_S will set it to protect against
+   BHI attacks.
 
    On Intel's enhanced IBRS systems, this includes cross-thread branch target
    injections on SMT systems (STIBP). In other words, Intel eIBRS enables
@@ -638,6 +658,22 @@ kernel command line.
 		spectre_v2=off. Spectre variant 1 mitigations
 		cannot be disabled.
 
+	spectre_bhi=
+
+		[X86] Control mitigation of Branch History Injection
+		(BHI) vulnerability. Syscalls are hardened against BHI
+		regardless of this setting. This setting affects the deployment
+		of the HW BHI control and the SW BHB clearing sequence.
+
+		on
+			unconditionally enable.
+		off
+			unconditionally disable.
+		auto
+			enable if hardware mitigation
+			control(BHI_DIS_S) is available, otherwise
+			enable alternate mitigation in KVM.
+
 For spectre_v2_user see Documentation/admin-guide/kernel-parameters.txt
 
 Mitigation selection guide
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 88dffaf8f0a9..b2c7b2f012e9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5733,6 +5733,18 @@
 	sonypi.*=	[HW] Sony Programmable I/O Control Device driver
 			See Documentation/admin-guide/laptops/sonypi.rst
 
+	spectre_bhi=	[X86] Control mitigation of Branch History Injection
+			(BHI) vulnerability. Syscalls are hardened against BHI
+			reglardless of this setting. This setting affects the
+			deployment of the HW BHI control and the SW BHB
+			clearing sequence.
+
+			on   - unconditionally enable.
+			off  - unconditionally disable.
+			auto - (default) enable hardware mitigation
+			       (BHI_DIS_S) if available, otherwise enable
+			       alternate mitigation in KVM.
+
 	spectre_v2=	[X86] Control mitigation of Spectre variant 2
 			(indirect branch speculation) vulnerability.
 			The default operation protects the kernel from
diff --git a/Makefile b/Makefile
index 0e33150db2bf..5dff9ff99998 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 84
+SUBLEVEL = 85
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index eae22e6e97c1..f55ce6f2fdc2 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -923,6 +923,8 @@ bluetooth: bluetooth {
 		vddrf-supply = <&pp1300_l2c>;
 		vddch0-supply = <&pp3300_l10c>;
 		max-speed = <3200000>;
+
+		qcom,local-bd-address-broken;
 	};
 };
 
diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index ec0cab9fbddd..72ec1d9bd3f3 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -319,7 +319,7 @@ unsigned long __must_check clear_user(void __user *to, unsigned long n)
 
 #define __get_kernel_nofault(dst, src, type, err_label)			\
 do {									\
-	long __kr_err;							\
+	long __kr_err = 0;						\
 									\
 	__get_user_nocheck(*((type *)(dst)), (type *)(src), __kr_err);	\
 	if (unlikely(__kr_err))						\
@@ -328,7 +328,7 @@ do {									\
 
 #define __put_kernel_nofault(dst, src, type, err_label)			\
 do {									\
-	long __kr_err;							\
+	long __kr_err = 0;						\
 									\
 	__put_user_nocheck(*((type *)(src)), (type *)(dst), __kr_err);	\
 	if (unlikely(__kr_err))						\
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 8955f2432c2d..6906cc0e5787 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -25,8 +25,6 @@
 #include <asm/thread_info.h>
 #include <asm/cpuidle.h>
 
-register unsigned long gp_in_global __asm__("gp");
-
 #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER_TASK)
 #include <linux/stackprotector.h>
 unsigned long __stack_chk_guard __read_mostly;
@@ -170,7 +168,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	if (unlikely(args->fn)) {
 		/* Kernel thread */
 		memset(childregs, 0, sizeof(struct pt_regs));
-		childregs->gp = gp_in_global;
 		/* Supervisor/Machine, irqs on: */
 		childregs->status = SR_PP | SR_PIE;
 
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index d2a1f2f4f5b8..c9799dec9279 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -699,6 +699,7 @@ ENDPROC(stack_overflow)
 .Lthis_cpu:	.short	0
 .Lstosm_tmp:	.byte	0
 	.section .rodata, "a"
+	.balign	8
 #define SYSCALL(esame,emu)	.quad __s390x_ ## esame
 	.globl	sys_call_table
 sys_call_table:
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index bea53385d31e..ba815ac474a1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2563,6 +2563,31 @@ config MITIGATION_RFDS
 	  stored in floating point, vector and integer registers.
 	  See also <file:Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst>
 
+choice
+	prompt "Clear branch history"
+	depends on CPU_SUP_INTEL
+	default SPECTRE_BHI_ON
+	help
+	  Enable BHI mitigations. BHI attacks are a form of Spectre V2 attacks
+	  where the branch history buffer is poisoned to speculatively steer
+	  indirect branches.
+	  See <file:Documentation/admin-guide/hw-vuln/spectre.rst>
+
+config SPECTRE_BHI_ON
+	bool "on"
+	help
+	  Equivalent to setting spectre_bhi=on command line parameter.
+config SPECTRE_BHI_OFF
+	bool "off"
+	help
+	  Equivalent to setting spectre_bhi=off command line parameter.
+config SPECTRE_BHI_AUTO
+	bool "auto"
+	help
+	  Equivalent to setting spectre_bhi=auto command line parameter.
+
+endchoice
+
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index 1d3ad275c366..801e943fd2b2 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -3,13 +3,17 @@
  * Confidential Computing Platform Capability checks
  *
  * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ * Copyright (C) 2024 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
  *
  * Author: Tom Lendacky <thomas.lendacky@amd.com>
  */
 
 #include <linux/export.h>
 #include <linux/cc_platform.h>
+#include <linux/string.h>
+#include <linux/random.h>
 
+#include <asm/archrandom.h>
 #include <asm/coco.h>
 #include <asm/processor.h>
 
@@ -128,3 +132,40 @@ u64 cc_mkdec(u64 val)
 	}
 }
 EXPORT_SYMBOL_GPL(cc_mkdec);
+
+__init void cc_random_init(void)
+{
+	/*
+	 * The seed is 32 bytes (in units of longs), which is 256 bits, which
+	 * is the security level that the RNG is targeting.
+	 */
+	unsigned long rng_seed[32 / sizeof(long)];
+	size_t i, longs;
+
+	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		return;
+
+	/*
+	 * Since the CoCo threat model includes the host, the only reliable
+	 * source of entropy that can be neither observed nor manipulated is
+	 * RDRAND. Usually, RDRAND failure is considered tolerable, but since
+	 * CoCo guests have no other unobservable source of entropy, it's
+	 * important to at least ensure the RNG gets some initial random seeds.
+	 */
+	for (i = 0; i < ARRAY_SIZE(rng_seed); i += longs) {
+		longs = arch_get_random_longs(&rng_seed[i], ARRAY_SIZE(rng_seed) - i);
+
+		/*
+		 * A zero return value means that the guest doesn't have RDRAND
+		 * or the CPU is physically broken, and in both cases that
+		 * means most crypto inside of the CoCo instance will be
+		 * broken, defeating the purpose of CoCo in the first place. So
+		 * just panic here because it's absolutely unsafe to continue
+		 * executing.
+		 */
+		if (longs == 0)
+			panic("RDRAND is defective.");
+	}
+	add_device_randomness(rng_seed, sizeof(rng_seed));
+	memzero_explicit(rng_seed, sizeof(rng_seed));
+}
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 9c0b26ae5106..e72dac092245 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -48,7 +48,7 @@ static __always_inline bool do_syscall_x64(struct pt_regs *regs, int nr)
 
 	if (likely(unr < NR_syscalls)) {
 		unr = array_index_nospec(unr, NR_syscalls);
-		regs->ax = sys_call_table[unr](regs);
+		regs->ax = x64_sys_call(regs, unr);
 		return true;
 	}
 	return false;
@@ -65,7 +65,7 @@ static __always_inline bool do_syscall_x32(struct pt_regs *regs, int nr)
 
 	if (IS_ENABLED(CONFIG_X86_X32_ABI) && likely(xnr < X32_NR_syscalls)) {
 		xnr = array_index_nospec(xnr, X32_NR_syscalls);
-		regs->ax = x32_sys_call_table[xnr](regs);
+		regs->ax = x32_sys_call(regs, xnr);
 		return true;
 	}
 	return false;
@@ -114,7 +114,7 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs, int nr)
 
 	if (likely(unr < IA32_NR_syscalls)) {
 		unr = array_index_nospec(unr, IA32_NR_syscalls);
-		regs->ax = ia32_sys_call_table[unr](regs);
+		regs->ax = ia32_sys_call(regs, unr);
 	} else if (nr != -1) {
 		regs->ax = __ia32_sys_ni_syscall(regs);
 	}
@@ -141,7 +141,7 @@ static __always_inline bool int80_is_external(void)
 }
 
 /**
- * int80_emulation - 32-bit legacy syscall entry
+ * do_int80_emulation - 32-bit legacy syscall C entry from asm
  *
  * This entry point can be used by 32-bit and 64-bit programs to perform
  * 32-bit system calls.  Instances of INT $0x80 can be found inline in
@@ -159,7 +159,7 @@ static __always_inline bool int80_is_external(void)
  *   eax:				system call number
  *   ebx, ecx, edx, esi, edi, ebp:	arg1 - arg 6
  */
-DEFINE_IDTENTRY_RAW(int80_emulation)
+__visible noinstr void do_int80_emulation(struct pt_regs *regs)
 {
 	int nr;
 
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index c2383c2880ec..6624806e6904 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -116,6 +116,7 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
 	/* clobbers %rax, make sure it is after saving the syscall nr */
 	IBRS_ENTER
 	UNTRAIN_RET
+	CLEAR_BRANCH_HISTORY
 
 	call	do_syscall_64		/* returns with IRQs disabled */
 
@@ -1539,3 +1540,63 @@ SYM_CODE_START(rewind_stack_and_make_dead)
 	call	make_task_dead
 SYM_CODE_END(rewind_stack_and_make_dead)
 .popsection
+
+/*
+ * This sequence executes branches in order to remove user branch information
+ * from the branch history tracker in the Branch Predictor, therefore removing
+ * user influence on subsequent BTB lookups.
+ *
+ * It should be used on parts prior to Alder Lake. Newer parts should use the
+ * BHI_DIS_S hardware control instead. If a pre-Alder Lake part is being
+ * virtualized on newer hardware the VMM should protect against BHI attacks by
+ * setting BHI_DIS_S for the guests.
+ *
+ * CALLs/RETs are necessary to prevent Loop Stream Detector(LSD) from engaging
+ * and not clearing the branch history. The call tree looks like:
+ *
+ * call 1
+ *    call 2
+ *      call 2
+ *        call 2
+ *          call 2
+ * 	      call 2
+ * 	      ret
+ * 	    ret
+ *        ret
+ *      ret
+ *    ret
+ * ret
+ *
+ * This means that the stack is non-constant and ORC can't unwind it with %rsp
+ * alone.  Therefore we unconditionally set up the frame pointer, which allows
+ * ORC to unwind properly.
+ *
+ * The alignment is for performance and not for safety, and may be safely
+ * refactored in the future if needed.
+ */
+SYM_FUNC_START(clear_bhb_loop)
+	push	%rbp
+	mov	%rsp, %rbp
+	movl	$5, %ecx
+	ANNOTATE_INTRA_FUNCTION_CALL
+	call	1f
+	jmp	5f
+	.align 64, 0xcc
+	ANNOTATE_INTRA_FUNCTION_CALL
+1:	call	2f
+	RET
+	.align 64, 0xcc
+2:	movl	$5, %eax
+3:	jmp	4f
+	nop
+4:	sub	$1, %eax
+	jnz	3b
+	sub	$1, %ecx
+	jnz	1b
+	RET
+5:	lfence
+	pop	%rbp
+	RET
+SYM_FUNC_END(clear_bhb_loop)
+EXPORT_SYMBOL_GPL(clear_bhb_loop)
+STACK_FRAME_NON_STANDARD(clear_bhb_loop)
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 4bcd009a232b..b14b8cd85eb2 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -92,6 +92,7 @@ SYM_INNER_LABEL(entry_SYSENTER_compat_after_hwframe, SYM_L_GLOBAL)
 
 	IBRS_ENTER
 	UNTRAIN_RET
+	CLEAR_BRANCH_HISTORY
 
 	/*
 	 * SYSENTER doesn't filter flags, so we need to clear NT and AC
@@ -210,6 +211,7 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_after_hwframe, SYM_L_GLOBAL)
 
 	IBRS_ENTER
 	UNTRAIN_RET
+	CLEAR_BRANCH_HISTORY
 
 	movq	%rsp, %rdi
 	call	do_fast_syscall_32
@@ -278,3 +280,17 @@ SYM_INNER_LABEL(entry_SYSRETL_compat_end, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
 	int3
 SYM_CODE_END(entry_SYSCALL_compat)
+
+/*
+ * int 0x80 is used by 32 bit mode as a system call entry. Normally idt entries
+ * point to C routines, however since this is a system call interface the branch
+ * history needs to be scrubbed to protect against BHI attacks, and that
+ * scrubbing needs to take place in assembly code prior to entering any C
+ * routines.
+ */
+SYM_CODE_START(int80_emulation)
+	ANNOTATE_NOENDBR
+	UNWIND_HINT_FUNC
+	CLEAR_BRANCH_HISTORY
+	jmp do_int80_emulation
+SYM_CODE_END(int80_emulation)
diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 8cfc9bc73e7f..c2235bae17ef 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -18,8 +18,25 @@
 #include <asm/syscalls_32.h>
 #undef __SYSCALL
 
+/*
+ * The sys_call_table[] is no longer used for system calls, but
+ * kernel/trace/trace_syscalls.c still wants to know the system
+ * call address.
+ */
+#ifdef CONFIG_X86_32
 #define __SYSCALL(nr, sym) __ia32_##sym,
-
-__visible const sys_call_ptr_t ia32_sys_call_table[] = {
+const sys_call_ptr_t sys_call_table[] = {
 #include <asm/syscalls_32.h>
 };
+#undef __SYSCALL
+#endif
+
+#define __SYSCALL(nr, sym) case nr: return __ia32_##sym(regs);
+
+long ia32_sys_call(const struct pt_regs *regs, unsigned int nr)
+{
+	switch (nr) {
+	#include <asm/syscalls_32.h>
+	default: return __ia32_sys_ni_syscall(regs);
+	}
+};
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index be120eec1fc9..33b3f09e6f15 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -11,8 +11,23 @@
 #include <asm/syscalls_64.h>
 #undef __SYSCALL
 
+/*
+ * The sys_call_table[] is no longer used for system calls, but
+ * kernel/trace/trace_syscalls.c still wants to know the system
+ * call address.
+ */
 #define __SYSCALL(nr, sym) __x64_##sym,
-
-asmlinkage const sys_call_ptr_t sys_call_table[] = {
+const sys_call_ptr_t sys_call_table[] = {
 #include <asm/syscalls_64.h>
 };
+#undef __SYSCALL
+
+#define __SYSCALL(nr, sym) case nr: return __x64_##sym(regs);
+
+long x64_sys_call(const struct pt_regs *regs, unsigned int nr)
+{
+	switch (nr) {
+	#include <asm/syscalls_64.h>
+	default: return __x64_sys_ni_syscall(regs);
+	}
+};
diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
index bdd0e03a1265..03de4a932131 100644
--- a/arch/x86/entry/syscall_x32.c
+++ b/arch/x86/entry/syscall_x32.c
@@ -11,8 +11,12 @@
 #include <asm/syscalls_x32.h>
 #undef __SYSCALL
 
-#define __SYSCALL(nr, sym) __x64_##sym,
+#define __SYSCALL(nr, sym) case nr: return __x64_##sym(regs);
 
-asmlinkage const sys_call_ptr_t x32_sys_call_table[] = {
-#include <asm/syscalls_x32.h>
+long x32_sys_call(const struct pt_regs *regs, unsigned int nr)
+{
+	switch (nr) {
+	#include <asm/syscalls_x32.h>
+	default: return __x64_sys_ni_syscall(regs);
+	}
 };
diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index fd091b9dd706..3ac069a4559b 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -904,8 +904,8 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 	if (!status)
 		goto done;
 
-	/* Read branch records before unfreezing */
-	if (status & GLOBAL_STATUS_LBRS_FROZEN) {
+	/* Read branch records */
+	if (x86_pmu.lbr_nr) {
 		amd_pmu_lbr_read();
 		status &= ~GLOBAL_STATUS_LBRS_FROZEN;
 	}
diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 38a75216c12c..b8fe74e8e0a6 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -400,10 +400,12 @@ void amd_pmu_lbr_enable_all(void)
 		wrmsrl(MSR_AMD64_LBR_SELECT, lbr_select);
 	}
 
-	rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
-	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
+	if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
+		rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
+		wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+	}
 
-	wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
 	wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg | DBG_EXTN_CFG_LBRV2EN);
 }
 
@@ -416,10 +418,12 @@ void amd_pmu_lbr_disable_all(void)
 		return;
 
 	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
-	rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
-
 	wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg & ~DBG_EXTN_CFG_LBRV2EN);
-	wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+
+	if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
+		rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
+		wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+	}
 }
 
 __init int amd_pmu_lbr_init(void)
diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index 8f80de627c60..5cdccea45554 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -12,6 +12,7 @@
 #include <asm/special_insns.h>
 #include <asm/preempt.h>
 #include <asm/asm.h>
+#include <asm/nospec-branch.h>
 
 #ifndef CONFIG_X86_CMPXCHG64
 extern void cmpxchg8b_emu(void);
diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index 60bb26097da1..1f97d00ad858 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -23,6 +23,7 @@ static inline void cc_set_mask(u64 mask)
 
 u64 cc_mkenc(u64 val);
 u64 cc_mkdec(u64 val);
+void cc_random_init(void);
 #else
 static inline u64 cc_mkenc(u64 val)
 {
@@ -33,6 +34,7 @@ static inline u64 cc_mkdec(u64 val)
 {
 	return val;
 }
+static inline void cc_random_init(void) { }
 #endif
 
 #endif /* _ASM_X86_COCO_H */
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index f835b328ba24..16051c6f3b13 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -33,6 +33,8 @@ enum cpuid_leafs
 	CPUID_7_EDX,
 	CPUID_8000_001F_EAX,
 	CPUID_8000_0021_EAX,
+	CPUID_LNX_5,
+	NR_CPUID_WORDS,
 };
 
 #define X86_CAP_FMT_NUM "%d:%d"
@@ -96,8 +98,9 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 18, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 19, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 20, feature_bit) ||	\
+	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 21, feature_bit) ||	\
 	   REQUIRED_MASK_CHECK					  ||	\
-	   BUILD_BUG_ON_ZERO(NCAPINTS != 21))
+	   BUILD_BUG_ON_ZERO(NCAPINTS != 22))
 
 #define DISABLED_MASK_BIT_SET(feature_bit)				\
 	 ( CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  0, feature_bit) ||	\
@@ -121,8 +124,9 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 18, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 19, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 20, feature_bit) ||	\
+	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 21, feature_bit) ||	\
 	   DISABLED_MASK_CHECK					  ||	\
-	   BUILD_BUG_ON_ZERO(NCAPINTS != 21))
+	   BUILD_BUG_ON_ZERO(NCAPINTS != 22))
 
 #define cpu_has(c, bit)							\
 	(__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 :	\
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 9a157942ae3d..7ded92672414 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -13,7 +13,7 @@
 /*
  * Defines x86 CPU feature bits
  */
-#define NCAPINTS			21	   /* N 32-bit words worth of info */
+#define NCAPINTS			22	   /* N 32-bit words worth of info */
 #define NBUGINTS			2	   /* N 32-bit bug flags */
 
 /*
@@ -432,6 +432,18 @@
 #define X86_FEATURE_IBPB_BRTYPE		(20*32+28) /* "" MSR_PRED_CMD[IBPB] flushes all branch type predictions */
 #define X86_FEATURE_SRSO_NO		(20*32+29) /* "" CPU is not affected by SRSO */
 
+/*
+ * Extended auxiliary flags: Linux defined - for features scattered in various
+ * CPUID levels like 0x80000022, etc and Linux defined features.
+ *
+ * Reuse free bits when adding new feature flags!
+ */
+#define X86_FEATURE_AMD_LBR_PMC_FREEZE	(21*32+ 0) /* AMD LBR and PMC Freeze */
+#define X86_FEATURE_CLEAR_BHB_LOOP	(21*32+ 1) /* "" Clear branch history at syscall entry using SW loop */
+#define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* "" BHI_DIS_S HW control available */
+#define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* "" BHI_DIS_S HW control enabled */
+#define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* "" Clear branch history at vmexit using SW loop */
+
 /*
  * BUG word(s)
  */
@@ -479,4 +491,5 @@
 #define X86_BUG_SRSO			X86_BUG(1*32 + 0) /* AMD SRSO bug */
 #define X86_BUG_DIV0			X86_BUG(1*32 + 1) /* AMD DIV0 speculation bug */
 #define X86_BUG_RFDS			X86_BUG(1*32 + 2) /* CPU is vulnerable to Register File Data Sampling */
+#define X86_BUG_BHI			X86_BUG(1*32 + 3) /* CPU is affected by Branch History Injection */
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 000037078db4..380e963149cc 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -112,6 +112,7 @@
 #define DISABLED_MASK18	0
 #define DISABLED_MASK19	0
 #define DISABLED_MASK20	0
-#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 21)
+#define DISABLED_MASK21	0
+#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 22)
 
 #endif /* _ASM_X86_DISABLED_FEATURES_H */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 33a19ef23644..681e8401b8a3 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -55,10 +55,13 @@
 #define SPEC_CTRL_SSBD			BIT(SPEC_CTRL_SSBD_SHIFT)	/* Speculative Store Bypass Disable */
 #define SPEC_CTRL_RRSBA_DIS_S_SHIFT	6	   /* Disable RRSBA behavior */
 #define SPEC_CTRL_RRSBA_DIS_S		BIT(SPEC_CTRL_RRSBA_DIS_S_SHIFT)
+#define SPEC_CTRL_BHI_DIS_S_SHIFT	10	   /* Disable Branch History Injection behavior */
+#define SPEC_CTRL_BHI_DIS_S		BIT(SPEC_CTRL_BHI_DIS_S_SHIFT)
 
 /* A mask for bits which the kernel toggles when controlling mitigations */
 #define SPEC_CTRL_MITIGATIONS_MASK	(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP | SPEC_CTRL_SSBD \
-							| SPEC_CTRL_RRSBA_DIS_S)
+							| SPEC_CTRL_RRSBA_DIS_S \
+							| SPEC_CTRL_BHI_DIS_S)
 
 #define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
 #define PRED_CMD_IBPB			BIT(0)	   /* Indirect Branch Prediction Barrier */
@@ -157,6 +160,10 @@
 						 * are restricted to targets in
 						 * kernel.
 						 */
+#define ARCH_CAP_BHI_NO			BIT(20)	/*
+						 * CPU is not affected by Branch
+						 * History Injection.
+						 */
 #define ARCH_CAP_PBRSB_NO		BIT(24)	/*
 						 * Not susceptible to Post-Barrier
 						 * Return Stack Buffer Predictions.
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 8f6f17a8617b..1e481d308e18 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -167,11 +167,20 @@
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
 #ifdef CONFIG_CPU_UNRET_ENTRY
-#define CALL_UNTRAIN_RET	"call entry_untrain_ret"
-#else
-#define CALL_UNTRAIN_RET	""
+	ALTERNATIVE_2 "", "call entry_untrain_ret", X86_FEATURE_UNRET, \
+		          "call srso_alias_untrain_ret", X86_FEATURE_SRSO_ALIAS
 #endif
+.endm
 
 /*
  * Mitigate RETBleed for AMD/Hygon Zen uarch. Requires KERNEL CR3 because the
@@ -188,9 +197,8 @@
 #if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
 	defined(CONFIG_CPU_SRSO)
 	ANNOTATE_UNRET_END
-	ALTERNATIVE_2 "",						\
-		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
-		      "call entry_ibpb", X86_FEATURE_ENTRY_IBPB
+	CALL_UNTRAIN_RET
+	ALTERNATIVE "", "call entry_ibpb", X86_FEATURE_ENTRY_IBPB
 #endif
 .endm
 
@@ -207,6 +215,19 @@
 .Lskip_verw_\@:
 .endm
 
+#ifdef CONFIG_X86_64
+.macro CLEAR_BRANCH_HISTORY
+	ALTERNATIVE "", "call clear_bhb_loop", X86_FEATURE_CLEAR_BHB_LOOP
+.endm
+
+.macro CLEAR_BRANCH_HISTORY_VMEXIT
+	ALTERNATIVE "", "call clear_bhb_loop", X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT
+.endm
+#else
+#define CLEAR_BRANCH_HISTORY
+#define CLEAR_BRANCH_HISTORY_VMEXIT
+#endif
+
 #else /* __ASSEMBLY__ */
 
 #define ANNOTATE_RETPOLINE_SAFE					\
@@ -235,6 +256,10 @@ extern void srso_alias_untrain_ret(void);
 extern void entry_untrain_ret(void);
 extern void entry_ibpb(void);
 
+#ifdef CONFIG_X86_64
+extern void clear_bhb_loop(void);
+#endif
+
 extern void (*x86_return_thunk)(void);
 
 #ifdef CONFIG_RETPOLINE
diff --git a/arch/x86/include/asm/required-features.h b/arch/x86/include/asm/required-features.h
index 7ba1726b71c7..e9187ddd3d1f 100644
--- a/arch/x86/include/asm/required-features.h
+++ b/arch/x86/include/asm/required-features.h
@@ -99,6 +99,7 @@
 #define REQUIRED_MASK18	0
 #define REQUIRED_MASK19	0
 #define REQUIRED_MASK20	0
-#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 21)
+#define REQUIRED_MASK21	0
+#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 22)
 
 #endif /* _ASM_X86_REQUIRED_FEATURES_H */
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index 5b85987a5e97..2725a4502321 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -16,19 +16,17 @@
 #include <asm/thread_info.h>	/* for TS_COMPAT */
 #include <asm/unistd.h>
 
+/* This is used purely for kernel/trace/trace_syscalls.c */
 typedef long (*sys_call_ptr_t)(const struct pt_regs *);
 extern const sys_call_ptr_t sys_call_table[];
 
-#if defined(CONFIG_X86_32)
-#define ia32_sys_call_table sys_call_table
-#else
 /*
  * These may not exist, but still put the prototypes in so we
  * can use IS_ENABLED().
  */
-extern const sys_call_ptr_t ia32_sys_call_table[];
-extern const sys_call_ptr_t x32_sys_call_table[];
-#endif
+extern long ia32_sys_call(const struct pt_regs *, unsigned int nr);
+extern long x32_sys_call(const struct pt_regs *, unsigned int nr);
+extern long x64_sys_call(const struct pt_regs *, unsigned int nr);
 
 /*
  * Only the low 32 bits of orig_ax are meaningful, so we return int.
@@ -129,6 +127,7 @@ static inline int syscall_get_arch(struct task_struct *task)
 void do_syscall_64(struct pt_regs *regs, int nr);
 void do_int80_syscall_32(struct pt_regs *regs);
 long do_fast_syscall_32(struct pt_regs *regs);
+void do_int80_emulation(struct pt_regs *regs);
 
 #endif	/* CONFIG_X86_32 */
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index e3fec47a800b..96bd3ee83a48 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1584,6 +1584,79 @@ static void __init spectre_v2_determine_rsb_fill_type_at_vmexit(enum spectre_v2_
 	dump_stack();
 }
 
+/*
+ * Set BHI_DIS_S to prevent indirect branches in kernel to be influenced by
+ * branch history in userspace. Not needed if BHI_NO is set.
+ */
+static bool __init spec_ctrl_bhi_dis(void)
+{
+	if (!boot_cpu_has(X86_FEATURE_BHI_CTRL))
+		return false;
+
+	x86_spec_ctrl_base |= SPEC_CTRL_BHI_DIS_S;
+	update_spec_ctrl(x86_spec_ctrl_base);
+	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_HW);
+
+	return true;
+}
+
+enum bhi_mitigations {
+	BHI_MITIGATION_OFF,
+	BHI_MITIGATION_ON,
+	BHI_MITIGATION_AUTO,
+};
+
+static enum bhi_mitigations bhi_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_SPECTRE_BHI_ON)  ? BHI_MITIGATION_ON  :
+	IS_ENABLED(CONFIG_SPECTRE_BHI_OFF) ? BHI_MITIGATION_OFF :
+					     BHI_MITIGATION_AUTO;
+
+static int __init spectre_bhi_parse_cmdline(char *str)
+{
+	if (!str)
+		return -EINVAL;
+
+	if (!strcmp(str, "off"))
+		bhi_mitigation = BHI_MITIGATION_OFF;
+	else if (!strcmp(str, "on"))
+		bhi_mitigation = BHI_MITIGATION_ON;
+	else if (!strcmp(str, "auto"))
+		bhi_mitigation = BHI_MITIGATION_AUTO;
+	else
+		pr_err("Ignoring unknown spectre_bhi option (%s)", str);
+
+	return 0;
+}
+early_param("spectre_bhi", spectre_bhi_parse_cmdline);
+
+static void __init bhi_select_mitigation(void)
+{
+	if (bhi_mitigation == BHI_MITIGATION_OFF)
+		return;
+
+	/* Retpoline mitigates against BHI unless the CPU has RRSBA behavior */
+	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE) &&
+	    !(x86_read_arch_cap_msr() & ARCH_CAP_RRSBA))
+		return;
+
+	if (spec_ctrl_bhi_dis())
+		return;
+
+	if (!IS_ENABLED(CONFIG_X86_64))
+		return;
+
+	/* Mitigate KVM by default */
+	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
+	pr_info("Spectre BHI mitigation: SW BHB clearing on vm exit\n");
+
+	if (bhi_mitigation == BHI_MITIGATION_AUTO)
+		return;
+
+	/* Mitigate syscalls when the mitigation is forced =on */
+	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP);
+	pr_info("Spectre BHI mitigation: SW BHB clearing on syscall\n");
+}
+
 static void __init spectre_v2_select_mitigation(void)
 {
 	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
@@ -1694,6 +1767,9 @@ static void __init spectre_v2_select_mitigation(void)
 	    mode == SPECTRE_V2_RETPOLINE)
 		spec_ctrl_disable_kernel_rrsba();
 
+	if (boot_cpu_has(X86_BUG_BHI))
+		bhi_select_mitigation();
+
 	spectre_v2_enabled = mode;
 	pr_info("%s\n", spectre_v2_strings[mode]);
 
@@ -2674,15 +2750,15 @@ static char *stibp_state(void)
 
 	switch (spectre_v2_user_stibp) {
 	case SPECTRE_V2_USER_NONE:
-		return ", STIBP: disabled";
+		return "; STIBP: disabled";
 	case SPECTRE_V2_USER_STRICT:
-		return ", STIBP: forced";
+		return "; STIBP: forced";
 	case SPECTRE_V2_USER_STRICT_PREFERRED:
-		return ", STIBP: always-on";
+		return "; STIBP: always-on";
 	case SPECTRE_V2_USER_PRCTL:
 	case SPECTRE_V2_USER_SECCOMP:
 		if (static_key_enabled(&switch_to_cond_stibp))
-			return ", STIBP: conditional";
+			return "; STIBP: conditional";
 	}
 	return "";
 }
@@ -2691,10 +2767,10 @@ static char *ibpb_state(void)
 {
 	if (boot_cpu_has(X86_FEATURE_IBPB)) {
 		if (static_key_enabled(&switch_mm_always_ibpb))
-			return ", IBPB: always-on";
+			return "; IBPB: always-on";
 		if (static_key_enabled(&switch_mm_cond_ibpb))
-			return ", IBPB: conditional";
-		return ", IBPB: disabled";
+			return "; IBPB: conditional";
+		return "; IBPB: disabled";
 	}
 	return "";
 }
@@ -2704,14 +2780,31 @@ static char *pbrsb_eibrs_state(void)
 	if (boot_cpu_has_bug(X86_BUG_EIBRS_PBRSB)) {
 		if (boot_cpu_has(X86_FEATURE_RSB_VMEXIT_LITE) ||
 		    boot_cpu_has(X86_FEATURE_RSB_VMEXIT))
-			return ", PBRSB-eIBRS: SW sequence";
+			return "; PBRSB-eIBRS: SW sequence";
 		else
-			return ", PBRSB-eIBRS: Vulnerable";
+			return "; PBRSB-eIBRS: Vulnerable";
 	} else {
-		return ", PBRSB-eIBRS: Not affected";
+		return "; PBRSB-eIBRS: Not affected";
 	}
 }
 
+static const char * const spectre_bhi_state(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_BHI))
+		return "; BHI: Not affected";
+	else if  (boot_cpu_has(X86_FEATURE_CLEAR_BHB_HW))
+		return "; BHI: BHI_DIS_S";
+	else if  (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP))
+		return "; BHI: SW loop, KVM: SW loop";
+	else if (boot_cpu_has(X86_FEATURE_RETPOLINE) &&
+		 !(x86_read_arch_cap_msr() & ARCH_CAP_RRSBA))
+		return "; BHI: Retpoline";
+	else if  (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT))
+		return "; BHI: Syscall hardening, KVM: SW loop";
+
+	return "; BHI: Vulnerable (Syscall hardening enabled)";
+}
+
 static ssize_t spectre_v2_show_state(char *buf)
 {
 	if (spectre_v2_enabled == SPECTRE_V2_LFENCE)
@@ -2724,13 +2817,15 @@ static ssize_t spectre_v2_show_state(char *buf)
 	    spectre_v2_enabled == SPECTRE_V2_EIBRS_LFENCE)
 		return sysfs_emit(buf, "Vulnerable: eIBRS+LFENCE with unprivileged eBPF and SMT\n");
 
-	return sysfs_emit(buf, "%s%s%s%s%s%s%s\n",
+	return sysfs_emit(buf, "%s%s%s%s%s%s%s%s\n",
 			  spectre_v2_strings[spectre_v2_enabled],
 			  ibpb_state(),
-			  boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
+			  boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? "; IBRS_FW" : "",
 			  stibp_state(),
-			  boot_cpu_has(X86_FEATURE_RSB_CTXSW) ? ", RSB filling" : "",
+			  boot_cpu_has(X86_FEATURE_RSB_CTXSW) ? "; RSB filling" : "",
 			  pbrsb_eibrs_state(),
+			  spectre_bhi_state(),
+			  /* this should always be at the end */
 			  spectre_v2_module_string());
 }
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ca243d7ba0ea..08fe77d2a3f9 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1144,6 +1144,7 @@ static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
 #define NO_SPECTRE_V2		BIT(8)
 #define NO_MMIO			BIT(9)
 #define NO_EIBRS_PBRSB		BIT(10)
+#define NO_BHI			BIT(11)
 
 #define VULNWL(vendor, family, model, whitelist)	\
 	X86_MATCH_VENDOR_FAM_MODEL(vendor, family, model, whitelist)
@@ -1206,18 +1207,18 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 	VULNWL_INTEL(ATOM_TREMONT_D,		NO_ITLB_MULTIHIT | NO_EIBRS_PBRSB),
 
 	/* AMD Family 0xf - 0x12 */
-	VULNWL_AMD(0x0f,	NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
-	VULNWL_AMD(0x10,	NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
-	VULNWL_AMD(0x11,	NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
-	VULNWL_AMD(0x12,	NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
+	VULNWL_AMD(0x0f,	NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO | NO_BHI),
+	VULNWL_AMD(0x10,	NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO | NO_BHI),
+	VULNWL_AMD(0x11,	NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO | NO_BHI),
+	VULNWL_AMD(0x12,	NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO | NO_BHI),
 
 	/* FAMILY_ANY must be last, otherwise 0x0f - 0x12 matches won't work */
-	VULNWL_AMD(X86_FAMILY_ANY,	NO_MELTDOWN | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO | NO_EIBRS_PBRSB),
-	VULNWL_HYGON(X86_FAMILY_ANY,	NO_MELTDOWN | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO | NO_EIBRS_PBRSB),
+	VULNWL_AMD(X86_FAMILY_ANY,	NO_MELTDOWN | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO | NO_EIBRS_PBRSB | NO_BHI),
+	VULNWL_HYGON(X86_FAMILY_ANY,	NO_MELTDOWN | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO | NO_EIBRS_PBRSB | NO_BHI),
 
 	/* Zhaoxin Family 7 */
-	VULNWL(CENTAUR,	7, X86_MODEL_ANY,	NO_SPECTRE_V2 | NO_SWAPGS | NO_MMIO),
-	VULNWL(ZHAOXIN,	7, X86_MODEL_ANY,	NO_SPECTRE_V2 | NO_SWAPGS | NO_MMIO),
+	VULNWL(CENTAUR,	7, X86_MODEL_ANY,	NO_SPECTRE_V2 | NO_SWAPGS | NO_MMIO | NO_BHI),
+	VULNWL(ZHAOXIN,	7, X86_MODEL_ANY,	NO_SPECTRE_V2 | NO_SWAPGS | NO_MMIO | NO_BHI),
 	{}
 };
 
@@ -1454,6 +1455,13 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	if (vulnerable_to_rfds(ia32_cap))
 		setup_force_cpu_bug(X86_BUG_RFDS);
 
+	/* When virtualized, eIBRS could be hidden, assume vulnerable */
+	if (!(ia32_cap & ARCH_CAP_BHI_NO) &&
+	    !cpu_matches(cpu_vuln_whitelist, NO_BHI) &&
+	    (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED) ||
+	     boot_cpu_has(X86_FEATURE_HYPERVISOR)))
+		setup_force_cpu_bug(X86_BUG_BHI);
+
 	if (cpu_matches(cpu_vuln_whitelist, NO_MELTDOWN))
 		return;
 
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index cad6ea1911e9..359218bc1b34 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2471,12 +2471,14 @@ static ssize_t set_bank(struct device *s, struct device_attribute *attr,
 		return -EINVAL;
 
 	b = &per_cpu(mce_banks_array, s->id)[bank];
-
 	if (!b->init)
 		return -ENODEV;
 
 	b->ctl = new;
+
+	mutex_lock(&mce_sysfs_mutex);
 	mce_restart();
+	mutex_unlock(&mce_sysfs_mutex);
 
 	return size;
 }
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index fc01f81f6e2a..28c357cf7c75 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -28,6 +28,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_EPB,		CPUID_ECX,  3, 0x00000006, 0 },
 	{ X86_FEATURE_INTEL_PPIN,	CPUID_EBX,  0, 0x00000007, 1 },
 	{ X86_FEATURE_RRSBA_CTRL,	CPUID_EDX,  2, 0x00000007, 2 },
+	{ X86_FEATURE_BHI_CTRL,		CPUID_EDX,  4, 0x00000007, 2 },
 	{ X86_FEATURE_CQM_LLC,		CPUID_EDX,  1, 0x0000000f, 0 },
 	{ X86_FEATURE_CQM_OCCUP_LLC,	CPUID_EDX,  0, 0x0000000f, 1 },
 	{ X86_FEATURE_CQM_MBM_TOTAL,	CPUID_EDX,  1, 0x0000000f, 1 },
@@ -46,6 +47,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
+	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index d1ffac9ad611..18a034613d94 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -33,6 +33,7 @@
 #include <asm/numa.h>
 #include <asm/bios_ebda.h>
 #include <asm/bugs.h>
+#include <asm/coco.h>
 #include <asm/cpu.h>
 #include <asm/efi.h>
 #include <asm/gart.h>
@@ -1132,6 +1133,7 @@ void __init setup_arch(char **cmdline_p)
 	 * memory size.
 	 */
 	sev_setup_arch();
+	cc_random_init();
 
 	efi_fake_memmap();
 	efi_find_mirror();
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index 7c8e2b20a13b..e43909d6504a 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -42,7 +42,7 @@ enum kvm_only_cpuid_leafs {
 #define X86_FEATURE_IPRED_CTRL		KVM_X86_FEATURE(CPUID_7_2_EDX, 1)
 #define KVM_X86_FEATURE_RRSBA_CTRL	KVM_X86_FEATURE(CPUID_7_2_EDX, 2)
 #define X86_FEATURE_DDPD_U		KVM_X86_FEATURE(CPUID_7_2_EDX, 3)
-#define X86_FEATURE_BHI_CTRL		KVM_X86_FEATURE(CPUID_7_2_EDX, 4)
+#define KVM_X86_FEATURE_BHI_CTRL	KVM_X86_FEATURE(CPUID_7_2_EDX, 4)
 #define X86_FEATURE_MCDT_NO		KVM_X86_FEATURE(CPUID_7_2_EDX, 5)
 
 struct cpuid_reg {
@@ -83,10 +83,12 @@ static const struct cpuid_reg reverse_cpuid[] = {
  */
 static __always_inline void reverse_cpuid_check(unsigned int x86_leaf)
 {
+	BUILD_BUG_ON(NR_CPUID_WORDS != NCAPINTS);
 	BUILD_BUG_ON(x86_leaf == CPUID_LNX_1);
 	BUILD_BUG_ON(x86_leaf == CPUID_LNX_2);
 	BUILD_BUG_ON(x86_leaf == CPUID_LNX_3);
 	BUILD_BUG_ON(x86_leaf == CPUID_LNX_4);
+	BUILD_BUG_ON(x86_leaf == CPUID_LNX_5);
 	BUILD_BUG_ON(x86_leaf >= ARRAY_SIZE(reverse_cpuid));
 	BUILD_BUG_ON(reverse_cpuid[x86_leaf].function == 0);
 }
@@ -104,6 +106,7 @@ static __always_inline u32 __feature_translate(int x86_feature)
 	KVM_X86_TRANSLATE_FEATURE(SGX1);
 	KVM_X86_TRANSLATE_FEATURE(SGX2);
 	KVM_X86_TRANSLATE_FEATURE(RRSBA_CTRL);
+	KVM_X86_TRANSLATE_FEATURE(BHI_CTRL);
 	default:
 		return x86_feature;
 	}
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 3dc0ee1fe9db..d8e192ad5953 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -76,9 +76,10 @@ struct enc_region {
 };
 
 /* Called with the sev_bitmap_lock held, or on shutdown  */
-static int sev_flush_asids(int min_asid, int max_asid)
+static int sev_flush_asids(unsigned int min_asid, unsigned int max_asid)
 {
-	int ret, asid, error = 0;
+	int ret, error = 0;
+	unsigned int asid;
 
 	/* Check if there are any ASIDs to reclaim before performing a flush */
 	asid = find_next_bit(sev_reclaim_asid_bitmap, nr_asids, min_asid);
@@ -108,7 +109,7 @@ static inline bool is_mirroring_enc_context(struct kvm *kvm)
 }
 
 /* Must be called with the sev_bitmap_lock held */
-static bool __sev_recycle_asids(int min_asid, int max_asid)
+static bool __sev_recycle_asids(unsigned int min_asid, unsigned int max_asid)
 {
 	if (sev_flush_asids(min_asid, max_asid))
 		return false;
@@ -135,8 +136,20 @@ static void sev_misc_cg_uncharge(struct kvm_sev_info *sev)
 
 static int sev_asid_new(struct kvm_sev_info *sev)
 {
-	int asid, min_asid, max_asid, ret;
+	/*
+	 * SEV-enabled guests must use asid from min_sev_asid to max_sev_asid.
+	 * SEV-ES-enabled guest can use from 1 to min_sev_asid - 1.
+	 * Note: min ASID can end up larger than the max if basic SEV support is
+	 * effectively disabled by disallowing use of ASIDs for SEV guests.
+	 */
+	unsigned int min_asid = sev->es_active ? 1 : min_sev_asid;
+	unsigned int max_asid = sev->es_active ? min_sev_asid - 1 : max_sev_asid;
+	unsigned int asid;
 	bool retry = true;
+	int ret;
+
+	if (min_asid > max_asid)
+		return -ENOTTY;
 
 	WARN_ON(sev->misc_cg);
 	sev->misc_cg = get_current_misc_cg();
@@ -149,12 +162,6 @@ static int sev_asid_new(struct kvm_sev_info *sev)
 
 	mutex_lock(&sev_bitmap_lock);
 
-	/*
-	 * SEV-enabled guests must use asid from min_sev_asid to max_sev_asid.
-	 * SEV-ES-enabled guest can use from 1 to min_sev_asid - 1.
-	 */
-	min_asid = sev->es_active ? 1 : min_sev_asid;
-	max_asid = sev->es_active ? min_sev_asid - 1 : max_sev_asid;
 again:
 	asid = find_next_zero_bit(sev_asid_bitmap, max_asid + 1, min_asid);
 	if (asid > max_asid) {
@@ -179,7 +186,7 @@ static int sev_asid_new(struct kvm_sev_info *sev)
 	return ret;
 }
 
-static int sev_get_asid(struct kvm *kvm)
+static unsigned int sev_get_asid(struct kvm *kvm)
 {
 	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
 
@@ -276,8 +283,8 @@ static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
 static int sev_bind_asid(struct kvm *kvm, unsigned int handle, int *error)
 {
+	unsigned int asid = sev_get_asid(kvm);
 	struct sev_data_activate activate;
-	int asid = sev_get_asid(kvm);
 	int ret;
 
 	/* activate ASID on the given handle */
@@ -2213,11 +2220,10 @@ void __init sev_hardware_setup(void)
 		goto out;
 	}
 
-	sev_asid_count = max_sev_asid - min_sev_asid + 1;
-	if (misc_cg_set_capacity(MISC_CG_RES_SEV, sev_asid_count))
-		goto out;
-
-	pr_info("SEV supported: %u ASIDs\n", sev_asid_count);
+	if (min_sev_asid <= max_sev_asid) {
+		sev_asid_count = max_sev_asid - min_sev_asid + 1;
+		WARN_ON_ONCE(misc_cg_set_capacity(MISC_CG_RES_SEV, sev_asid_count));
+	}
 	sev_supported = true;
 
 	/* SEV-ES support requested? */
@@ -2242,13 +2248,21 @@ void __init sev_hardware_setup(void)
 		goto out;
 
 	sev_es_asid_count = min_sev_asid - 1;
-	if (misc_cg_set_capacity(MISC_CG_RES_SEV_ES, sev_es_asid_count))
-		goto out;
-
-	pr_info("SEV-ES supported: %u ASIDs\n", sev_es_asid_count);
+	WARN_ON_ONCE(misc_cg_set_capacity(MISC_CG_RES_SEV_ES, sev_es_asid_count));
 	sev_es_supported = true;
 
 out:
+	if (boot_cpu_has(X86_FEATURE_SEV))
+		pr_info("SEV %s (ASIDs %u - %u)\n",
+			sev_supported ? min_sev_asid <= max_sev_asid ? "enabled" :
+								       "unusable" :
+								       "disabled",
+			min_sev_asid, max_sev_asid);
+	if (boot_cpu_has(X86_FEATURE_SEV_ES))
+		pr_info("SEV-ES %s (ASIDs %u - %u)\n",
+			sev_es_supported ? "enabled" : "disabled",
+			min_sev_asid > 1 ? 1 : 0, min_sev_asid - 1);
+
 	sev_enabled = sev_supported;
 	sev_es_enabled = sev_es_supported;
 #endif
@@ -2287,7 +2301,7 @@ int sev_cpu_init(struct svm_cpu_data *sd)
  */
 static void sev_flush_encrypted_page(struct kvm_vcpu *vcpu, void *va)
 {
-	int asid = to_kvm_svm(vcpu->kvm)->sev_info.asid;
+	unsigned int asid = sev_get_asid(vcpu->kvm);
 
 	/*
 	 * Note!  The address must be a kernel address, as regular page walk
@@ -2608,7 +2622,7 @@ void sev_es_unmap_ghcb(struct vcpu_svm *svm)
 void pre_sev_run(struct vcpu_svm *svm, int cpu)
 {
 	struct svm_cpu_data *sd = per_cpu_ptr(&svm_data, cpu);
-	int asid = sev_get_asid(svm->vcpu.kvm);
+	unsigned int asid = sev_get_asid(svm->vcpu.kvm);
 
 	/* Assign the asid allocated with this SEV guest */
 	svm->asid = asid;
diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index bc25589ad588..6c1dcf44c4fa 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -729,13 +729,13 @@ TRACE_EVENT(kvm_nested_intr_vmexit,
  * Tracepoint for nested #vmexit because of interrupt pending
  */
 TRACE_EVENT(kvm_invlpga,
-	    TP_PROTO(__u64 rip, int asid, u64 address),
+	    TP_PROTO(__u64 rip, unsigned int asid, u64 address),
 	    TP_ARGS(rip, asid, address),
 
 	TP_STRUCT__entry(
-		__field(	__u64,	rip	)
-		__field(	int,	asid	)
-		__field(	__u64,	address	)
+		__field(	__u64,		rip	)
+		__field(	unsigned int,	asid	)
+		__field(	__u64,		address	)
 	),
 
 	TP_fast_assign(
@@ -744,7 +744,7 @@ TRACE_EVENT(kvm_invlpga,
 		__entry->address	=	address;
 	),
 
-	TP_printk("rip: 0x%016llx asid: %d address: 0x%016llx",
+	TP_printk("rip: 0x%016llx asid: %u address: 0x%016llx",
 		  __entry->rip, __entry->asid, __entry->address)
 );
 
diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index 0b2cad66dee1..b4f8937226c2 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -242,6 +242,8 @@ SYM_INNER_LABEL(vmx_vmexit, SYM_L_GLOBAL)
 
 	call vmx_spec_ctrl_restore_host
 
+	CLEAR_BRANCH_HISTORY_VMEXIT
+
 	/* Put return value in AX */
 	mov %_ASM_BX, %_ASM_AX
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0e6e63a8f094..f724765032bc 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1614,7 +1614,7 @@ static unsigned int num_msr_based_features;
 	 ARCH_CAP_PSCHANGE_MC_NO | ARCH_CAP_TSX_CTRL_MSR | ARCH_CAP_TAA_NO | \
 	 ARCH_CAP_SBDR_SSDP_NO | ARCH_CAP_FBSDP_NO | ARCH_CAP_PSDP_NO | \
 	 ARCH_CAP_FB_CLEAR | ARCH_CAP_RRSBA | ARCH_CAP_PBRSB_NO | ARCH_CAP_GDS_NO | \
-	 ARCH_CAP_RFDS_NO | ARCH_CAP_RFDS_CLEAR)
+	 ARCH_CAP_RFDS_NO | ARCH_CAP_RFDS_CLEAR | ARCH_CAP_BHI_NO)
 
 static u64 kvm_get_arch_capabilities(void)
 {
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 65c5c44f006b..055955c9bfcb 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -110,6 +110,7 @@ SYM_START(srso_alias_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	ret
 	int3
 SYM_FUNC_END(srso_alias_untrain_ret)
+__EXPORT_THUNK(srso_alias_untrain_ret)
 #endif
 
 SYM_START(srso_alias_safe_ret, SYM_L_GLOBAL, SYM_A_NONE)
@@ -252,9 +253,7 @@ SYM_CODE_START(srso_return_thunk)
 SYM_CODE_END(srso_return_thunk)
 
 SYM_FUNC_START(entry_untrain_ret)
-	ALTERNATIVE_2 "jmp retbleed_untrain_ret", \
-		      "jmp srso_untrain_ret", X86_FEATURE_SRSO, \
-		      "jmp srso_alias_untrain_ret", X86_FEATURE_SRSO_ALIAS
+	ALTERNATIVE "jmp retbleed_untrain_ret", "jmp srso_untrain_ret", X86_FEATURE_SRSO
 SYM_FUNC_END(entry_untrain_ret)
 __EXPORT_THUNK(entry_untrain_ret)
 
@@ -262,6 +261,7 @@ SYM_CODE_START(__x86_return_thunk)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
 	ANNOTATE_UNRET_SAFE
+	ANNOTATE_NOENDBR
 	ret
 	int3
 SYM_CODE_END(__x86_return_thunk)
diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index f50cc210a981..968d7005f4a7 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -26,31 +26,18 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
 	for (; addr < end; addr = next) {
 		pud_t *pud = pud_page + pud_index(addr);
 		pmd_t *pmd;
-		bool use_gbpage;
 
 		next = (addr & PUD_MASK) + PUD_SIZE;
 		if (next > end)
 			next = end;
 
-		/* if this is already a gbpage, this portion is already mapped */
-		if (pud_large(*pud))
-			continue;
-
-		/* Is using a gbpage allowed? */
-		use_gbpage = info->direct_gbpages;
-
-		/* Don't use gbpage if it maps more than the requested region. */
-		/* at the begining: */
-		use_gbpage &= ((addr & ~PUD_MASK) == 0);
-		/* ... or at the end: */
-		use_gbpage &= ((next & ~PUD_MASK) == 0);
-
-		/* Never overwrite existing mappings */
-		use_gbpage &= !pud_present(*pud);
-
-		if (use_gbpage) {
+		if (info->direct_gbpages) {
 			pud_t pudval;
 
+			if (pud_present(*pud))
+				continue;
+
+			addr &= PUD_MASK;
 			pudval = __pud((addr - info->offset) | info->page_flag);
 			set_pud(pud, pudval);
 			continue;
diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 66a209f7eb86..d6fe9093ea91 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -997,6 +997,38 @@ static void free_pfn_range(u64 paddr, unsigned long size)
 		memtype_free(paddr, paddr + size);
 }
 
+static int get_pat_info(struct vm_area_struct *vma, resource_size_t *paddr,
+		pgprot_t *pgprot)
+{
+	unsigned long prot;
+
+	VM_WARN_ON_ONCE(!(vma->vm_flags & VM_PAT));
+
+	/*
+	 * We need the starting PFN and cachemode used for track_pfn_remap()
+	 * that covered the whole VMA. For most mappings, we can obtain that
+	 * information from the page tables. For COW mappings, we might now
+	 * suddenly have anon folios mapped and follow_phys() will fail.
+	 *
+	 * Fallback to using vma->vm_pgoff, see remap_pfn_range_notrack(), to
+	 * detect the PFN. If we need the cachemode as well, we're out of luck
+	 * for now and have to fail fork().
+	 */
+	if (!follow_phys(vma, vma->vm_start, 0, &prot, paddr)) {
+		if (pgprot)
+			*pgprot = __pgprot(prot);
+		return 0;
+	}
+	if (is_cow_mapping(vma->vm_flags)) {
+		if (pgprot)
+			return -EINVAL;
+		*paddr = (resource_size_t)vma->vm_pgoff << PAGE_SHIFT;
+		return 0;
+	}
+	WARN_ON_ONCE(1);
+	return -EINVAL;
+}
+
 /*
  * track_pfn_copy is called when vma that is covering the pfnmap gets
  * copied through copy_page_range().
@@ -1007,20 +1039,13 @@ static void free_pfn_range(u64 paddr, unsigned long size)
 int track_pfn_copy(struct vm_area_struct *vma)
 {
 	resource_size_t paddr;
-	unsigned long prot;
 	unsigned long vma_size = vma->vm_end - vma->vm_start;
 	pgprot_t pgprot;
 
 	if (vma->vm_flags & VM_PAT) {
-		/*
-		 * reserve the whole chunk covered by vma. We need the
-		 * starting address and protection from pte.
-		 */
-		if (follow_phys(vma, vma->vm_start, 0, &prot, &paddr)) {
-			WARN_ON_ONCE(1);
+		if (get_pat_info(vma, &paddr, &pgprot))
 			return -EINVAL;
-		}
-		pgprot = __pgprot(prot);
+		/* reserve the whole chunk covered by vma. */
 		return reserve_pfn_range(paddr, vma_size, &pgprot, 1);
 	}
 
@@ -1095,7 +1120,6 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 		 unsigned long size)
 {
 	resource_size_t paddr;
-	unsigned long prot;
 
 	if (vma && !(vma->vm_flags & VM_PAT))
 		return;
@@ -1103,11 +1127,8 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 	/* free the chunk starting from pfn or the whole chunk */
 	paddr = (resource_size_t)pfn << PAGE_SHIFT;
 	if (!paddr && !size) {
-		if (follow_phys(vma, vma->vm_start, 0, &prot, &paddr)) {
-			WARN_ON_ONCE(1);
+		if (get_pat_info(vma, &paddr, NULL))
 			return;
-		}
-
 		size = vma->vm_end - vma->vm_start;
 	}
 	free_pfn_range(paddr, size);
diff --git a/drivers/acpi/acpica/dbnames.c b/drivers/acpi/acpica/dbnames.c
index b91155ea9c34..c9131259f717 100644
--- a/drivers/acpi/acpica/dbnames.c
+++ b/drivers/acpi/acpica/dbnames.c
@@ -550,8 +550,12 @@ acpi_db_walk_for_fields(acpi_handle obj_handle,
 	ACPI_FREE(buffer.pointer);
 
 	buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
-	acpi_evaluate_object(obj_handle, NULL, NULL, &buffer);
-
+	status = acpi_evaluate_object(obj_handle, NULL, NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		acpi_os_printf("Could Not evaluate object %p\n",
+			       obj_handle);
+		return (AE_OK);
+	}
 	/*
 	 * Since this is a field unit, surround the output in braces
 	 */
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 17f9062b0eaa..9cf540017a5e 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -787,37 +787,6 @@ static const struct ata_port_info mv_port_info[] = {
 	},
 };
 
-static const struct pci_device_id mv_pci_tbl[] = {
-	{ PCI_VDEVICE(MARVELL, 0x5040), chip_504x },
-	{ PCI_VDEVICE(MARVELL, 0x5041), chip_504x },
-	{ PCI_VDEVICE(MARVELL, 0x5080), chip_5080 },
-	{ PCI_VDEVICE(MARVELL, 0x5081), chip_508x },
-	/* RocketRAID 1720/174x have different identifiers */
-	{ PCI_VDEVICE(TTI, 0x1720), chip_6042 },
-	{ PCI_VDEVICE(TTI, 0x1740), chip_6042 },
-	{ PCI_VDEVICE(TTI, 0x1742), chip_6042 },
-
-	{ PCI_VDEVICE(MARVELL, 0x6040), chip_604x },
-	{ PCI_VDEVICE(MARVELL, 0x6041), chip_604x },
-	{ PCI_VDEVICE(MARVELL, 0x6042), chip_6042 },
-	{ PCI_VDEVICE(MARVELL, 0x6080), chip_608x },
-	{ PCI_VDEVICE(MARVELL, 0x6081), chip_608x },
-
-	{ PCI_VDEVICE(ADAPTEC2, 0x0241), chip_604x },
-
-	/* Adaptec 1430SA */
-	{ PCI_VDEVICE(ADAPTEC2, 0x0243), chip_7042 },
-
-	/* Marvell 7042 support */
-	{ PCI_VDEVICE(MARVELL, 0x7042), chip_7042 },
-
-	/* Highpoint RocketRAID PCIe series */
-	{ PCI_VDEVICE(TTI, 0x2300), chip_7042 },
-	{ PCI_VDEVICE(TTI, 0x2310), chip_7042 },
-
-	{ }			/* terminate list */
-};
-
 static const struct mv_hw_ops mv5xxx_ops = {
 	.phy_errata		= mv5_phy_errata,
 	.enable_leds		= mv5_enable_leds,
@@ -4301,6 +4270,36 @@ static int mv_pci_init_one(struct pci_dev *pdev,
 static int mv_pci_device_resume(struct pci_dev *pdev);
 #endif
 
+static const struct pci_device_id mv_pci_tbl[] = {
+	{ PCI_VDEVICE(MARVELL, 0x5040), chip_504x },
+	{ PCI_VDEVICE(MARVELL, 0x5041), chip_504x },
+	{ PCI_VDEVICE(MARVELL, 0x5080), chip_5080 },
+	{ PCI_VDEVICE(MARVELL, 0x5081), chip_508x },
+	/* RocketRAID 1720/174x have different identifiers */
+	{ PCI_VDEVICE(TTI, 0x1720), chip_6042 },
+	{ PCI_VDEVICE(TTI, 0x1740), chip_6042 },
+	{ PCI_VDEVICE(TTI, 0x1742), chip_6042 },
+
+	{ PCI_VDEVICE(MARVELL, 0x6040), chip_604x },
+	{ PCI_VDEVICE(MARVELL, 0x6041), chip_604x },
+	{ PCI_VDEVICE(MARVELL, 0x6042), chip_6042 },
+	{ PCI_VDEVICE(MARVELL, 0x6080), chip_608x },
+	{ PCI_VDEVICE(MARVELL, 0x6081), chip_608x },
+
+	{ PCI_VDEVICE(ADAPTEC2, 0x0241), chip_604x },
+
+	/* Adaptec 1430SA */
+	{ PCI_VDEVICE(ADAPTEC2, 0x0243), chip_7042 },
+
+	/* Marvell 7042 support */
+	{ PCI_VDEVICE(MARVELL, 0x7042), chip_7042 },
+
+	/* Highpoint RocketRAID PCIe series */
+	{ PCI_VDEVICE(TTI, 0x2300), chip_7042 },
+	{ PCI_VDEVICE(TTI, 0x2310), chip_7042 },
+
+	{ }			/* terminate list */
+};
 
 static struct pci_driver mv_pci_driver = {
 	.name			= DRV_NAME,
@@ -4313,6 +4312,7 @@ static struct pci_driver mv_pci_driver = {
 #endif
 
 };
+MODULE_DEVICE_TABLE(pci, mv_pci_tbl);
 
 /**
  *      mv_print_info - Dump key info to kernel log for perusal.
@@ -4485,7 +4485,6 @@ static void __exit mv_exit(void)
 MODULE_AUTHOR("Brett Russ");
 MODULE_DESCRIPTION("SCSI low-level driver for Marvell SATA controllers");
 MODULE_LICENSE("GPL v2");
-MODULE_DEVICE_TABLE(pci, mv_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 MODULE_ALIAS("platform:" DRV_NAME);
 
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index 6ceec59cb291..fa1966638c06 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -958,8 +958,7 @@ static void pdc20621_get_from_dimm(struct ata_host *host, void *psource,
 
 	offset -= (idx * window_size);
 	idx++;
-	dist = ((long) (window_size - (offset + size))) >= 0 ? size :
-		(long) (window_size - offset);
+	dist = min(size, window_size - offset);
 	memcpy_fromio(psource, dimm_mmio + offset / 4, dist);
 
 	psource += dist;
@@ -1006,8 +1005,7 @@ static void pdc20621_put_to_dimm(struct ata_host *host, void *psource,
 	readl(mmio + PDC_DIMM_WINDOW_CTLR);
 	offset -= (idx * window_size);
 	idx++;
-	dist = ((long)(s32)(window_size - (offset + size))) >= 0 ? size :
-		(long) (window_size - offset);
+	dist = min(size, window_size - offset);
 	memcpy_toio(dimm_mmio + offset / 4, psource, dist);
 	writel(0x01, mmio + PDC_GENERAL_CTLR);
 	readl(mmio + PDC_GENERAL_CTLR);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3078f44dc186..8d87808cdb8a 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -56,6 +56,7 @@ static bool fw_devlink_is_permissive(void);
 static void __fw_devlink_link_to_consumers(struct device *dev);
 static bool fw_devlink_drv_reg_done;
 static bool fw_devlink_best_effort;
+static struct workqueue_struct *device_link_wq;
 
 /**
  * __fwnode_link_add - Create a link between two fwnode_handles.
@@ -585,12 +586,26 @@ static void devlink_dev_release(struct device *dev)
 	/*
 	 * It may take a while to complete this work because of the SRCU
 	 * synchronization in device_link_release_fn() and if the consumer or
-	 * supplier devices get deleted when it runs, so put it into the "long"
-	 * workqueue.
+	 * supplier devices get deleted when it runs, so put it into the
+	 * dedicated workqueue.
 	 */
-	queue_work(system_long_wq, &link->rm_work);
+	queue_work(device_link_wq, &link->rm_work);
 }
 
+/**
+ * device_link_wait_removal - Wait for ongoing devlink removal jobs to terminate
+ */
+void device_link_wait_removal(void)
+{
+	/*
+	 * devlink removal jobs are queued in the dedicated work queue.
+	 * To be sure that all removal jobs are terminated, ensure that any
+	 * scheduled work has run to completion.
+	 */
+	flush_workqueue(device_link_wq);
+}
+EXPORT_SYMBOL_GPL(device_link_wait_removal);
+
 static struct class devlink_class = {
 	.name = "devlink",
 	.owner = THIS_MODULE,
@@ -4132,9 +4147,14 @@ int __init devices_init(void)
 	sysfs_dev_char_kobj = kobject_create_and_add("char", dev_kobj);
 	if (!sysfs_dev_char_kobj)
 		goto char_kobj_err;
+	device_link_wq = alloc_workqueue("device_link_wq", 0, 0);
+	if (!device_link_wq)
+		goto wq_err;
 
 	return 0;
 
+ wq_err:
+	kobject_put(sysfs_dev_char_kobj);
  char_kobj_err:
 	kobject_put(sysfs_dev_block_kobj);
  block_kobj_err:
diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 0211f704a358..5277090c6d6d 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -758,11 +758,15 @@ EXPORT_SYMBOL_GPL(qca_uart_setup);
 
 int qca_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 {
+	bdaddr_t bdaddr_swapped;
 	struct sk_buff *skb;
 	int err;
 
-	skb = __hci_cmd_sync_ev(hdev, EDL_WRITE_BD_ADDR_OPCODE, 6, bdaddr,
-				HCI_EV_VENDOR, HCI_INIT_TIMEOUT);
+	baswap(&bdaddr_swapped, bdaddr);
+
+	skb = __hci_cmd_sync_ev(hdev, EDL_WRITE_BD_ADDR_OPCODE, 6,
+				&bdaddr_swapped, HCI_EV_VENDOR,
+				HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		err = PTR_ERR(skb);
 		bt_dev_err(hdev, "QCA Change address cmd failed (%d)", err);
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 2acda547f4f3..33956ddec933 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -7,7 +7,6 @@
  *
  *  Copyright (C) 2007 Texas Instruments, Inc.
  *  Copyright (c) 2010, 2012, 2018 The Linux Foundation. All rights reserved.
- *  Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
  *
  *  Acknowledgements:
  *  This file is based on hci_ll.c, which was...
@@ -226,6 +225,7 @@ struct qca_serdev {
 	struct qca_power *bt_power;
 	u32 init_speed;
 	u32 oper_speed;
+	bool bdaddr_property_broken;
 	const char *firmware_name;
 };
 
@@ -1788,6 +1788,7 @@ static int qca_setup(struct hci_uart *hu)
 	const char *firmware_name = qca_get_firmware_name(hu);
 	int ret;
 	struct qca_btsoc_version ver;
+	struct qca_serdev *qcadev;
 	const char *soc_name;
 
 	ret = qca_check_speeds(hu);
@@ -1845,16 +1846,11 @@ static int qca_setup(struct hci_uart *hu)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
+		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
 
-		/* Set BDA quirk bit for reading BDA value from fwnode property
-		 * only if that property exist in DT.
-		 */
-		if (fwnode_property_present(dev_fwnode(hdev->dev.parent), "local-bd-address")) {
-			set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
-			bt_dev_info(hdev, "setting quirk bit to read BDA from fwnode later");
-		} else {
-			bt_dev_dbg(hdev, "local-bd-address` is not present in the devicetree so not setting quirk bit for BDA");
-		}
+		qcadev = serdev_device_get_drvdata(hu->serdev);
+		if (qcadev->bdaddr_property_broken)
+			set_bit(HCI_QUIRK_BDADDR_PROPERTY_BROKEN, &hdev->quirks);
 
 		hci_set_aosp_capable(hdev);
 
@@ -2223,6 +2219,9 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	if (!qcadev->oper_speed)
 		BT_DBG("UART will pick default operating speed");
 
+	qcadev->bdaddr_property_broken = device_property_read_bool(&serdev->dev,
+			"qcom,local-bd-address-broken");
+
 	if (data)
 		qcadev->btsoc_type = data->soc_type;
 	else
diff --git a/drivers/dma-buf/st-dma-fence-chain.c b/drivers/dma-buf/st-dma-fence-chain.c
index 0a9b099d0518..d90479d830fc 100644
--- a/drivers/dma-buf/st-dma-fence-chain.c
+++ b/drivers/dma-buf/st-dma-fence-chain.c
@@ -84,11 +84,11 @@ static int sanitycheck(void *arg)
 		return -ENOMEM;
 
 	chain = mock_chain(NULL, f, 1);
-	if (!chain)
+	if (chain)
+		dma_fence_enable_sw_signaling(chain);
+	else
 		err = -ENOMEM;
 
-	dma_fence_enable_sw_signaling(chain);
-
 	dma_fence_signal(f);
 	dma_fence_put(f);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e636c7850f77..dd22d2559720 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1342,6 +1342,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 void amdgpu_driver_release_kms(struct drm_device *dev);
 
 int amdgpu_device_ip_suspend(struct amdgpu_device *adev);
+int amdgpu_device_prepare(struct drm_device *dev);
 int amdgpu_device_suspend(struct drm_device *dev, bool fbcon);
 int amdgpu_device_resume(struct drm_device *dev, bool fbcon);
 u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6a4749c0c5a5..b11690a816e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1639,6 +1639,7 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
 	} else {
 		pr_info("switched off\n");
 		dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
+		amdgpu_device_prepare(dev);
 		amdgpu_device_suspend(dev, true);
 		amdgpu_device_cache_pci_state(pdev);
 		/* Shut down the device */
@@ -4167,6 +4168,43 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
 /*
  * Suspend & resume.
  */
+/**
+ * amdgpu_device_prepare - prepare for device suspend
+ *
+ * @dev: drm dev pointer
+ *
+ * Prepare to put the hw in the suspend state (all asics).
+ * Returns 0 for success or an error on failure.
+ * Called at driver suspend.
+ */
+int amdgpu_device_prepare(struct drm_device *dev)
+{
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	int i, r;
+
+	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
+		return 0;
+
+	/* Evict the majority of BOs before starting suspend sequence */
+	r = amdgpu_device_evict_resources(adev);
+	if (r)
+		return r;
+
+	flush_delayed_work(&adev->gfx.gfx_off_delay_work);
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (!adev->ip_blocks[i].status.valid)
+			continue;
+		if (!adev->ip_blocks[i].version->funcs->prepare_suspend)
+			continue;
+		r = adev->ip_blocks[i].version->funcs->prepare_suspend((void *)adev);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
 /**
  * amdgpu_device_suspend - initiate device suspend
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index f24c3a20e901..9a5416331f02 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2391,8 +2391,9 @@ static int amdgpu_pmops_prepare(struct device *dev)
 	/* Return a positive number here so
 	 * DPM_FLAG_SMART_SUSPEND works properly
 	 */
-	if (amdgpu_device_supports_boco(drm_dev))
-		return pm_runtime_suspended(dev);
+	if (amdgpu_device_supports_boco(drm_dev) &&
+	    pm_runtime_suspended(dev))
+		return 1;
 
 	/* if we will not support s3 or s2i for the device
 	 *  then skip suspend
@@ -2401,7 +2402,7 @@ static int amdgpu_pmops_prepare(struct device *dev)
 	    !amdgpu_acpi_is_s3_active(adev))
 		return 1;
 
-	return 0;
+	return amdgpu_device_prepare(drm_dev);
 }
 
 static void amdgpu_pmops_complete(struct device *dev)
@@ -2600,6 +2601,9 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	if (amdgpu_device_supports_boco(drm_dev))
 		adev->mp1_state = PP_MP1_STATE_UNLOAD;
 
+	ret = amdgpu_device_prepare(drm_dev);
+	if (ret)
+		return ret;
 	ret = amdgpu_device_suspend(drm_dev, false);
 	if (ret) {
 		adev->in_runpm = false;
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index f175e65b853a..34467427c9f9 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -294,6 +294,7 @@ struct amd_ip_funcs {
 	int (*hw_init)(void *handle);
 	int (*hw_fini)(void *handle);
 	void (*late_fini)(void *handle);
+	int (*prepare_suspend)(void *handle);
 	int (*suspend)(void *handle);
 	int (*resume)(void *handle);
 	bool (*is_idle)(void *handle);
diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
index 55d243048516..40b631445992 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
@@ -379,19 +379,19 @@ void panfrost_gpu_power_off(struct panfrost_device *pfdev)
 
 	gpu_write(pfdev, SHADER_PWROFF_LO, pfdev->features.shader_present);
 	ret = readl_relaxed_poll_timeout(pfdev->iomem + SHADER_PWRTRANS_LO,
-					 val, !val, 1, 1000);
+					 val, !val, 1, 2000);
 	if (ret)
 		dev_err(pfdev->dev, "shader power transition timeout");
 
 	gpu_write(pfdev, TILER_PWROFF_LO, pfdev->features.tiler_present);
 	ret = readl_relaxed_poll_timeout(pfdev->iomem + TILER_PWRTRANS_LO,
-					 val, !val, 1, 1000);
+					 val, !val, 1, 2000);
 	if (ret)
 		dev_err(pfdev->dev, "tiler power transition timeout");
 
 	gpu_write(pfdev, L2_PWROFF_LO, pfdev->features.l2_present);
 	ret = readl_poll_timeout(pfdev->iomem + L2_PWRTRANS_LO,
-				 val, !val, 0, 1000);
+				 val, !val, 0, 2000);
 	if (ret)
 		dev_err(pfdev->dev, "l2 power transition timeout");
 }
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 9c9e2b50c63c..696365f8f3b5 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -4167,7 +4167,7 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned int argc, char **argv
 		} else if (sscanf(opt_string, "sectors_per_bit:%llu%c", &llval, &dummy) == 1) {
 			log2_sectors_per_bitmap_bit = !llval ? 0 : __ilog2_u64(llval);
 		} else if (sscanf(opt_string, "bitmap_flush_interval:%u%c", &val, &dummy) == 1) {
-			if (val >= (uint64_t)UINT_MAX * 1000 / HZ) {
+			if ((uint64_t)val >= (uint64_t)UINT_MAX * 1000 / HZ) {
 				r = -EINVAL;
 				ti->error = "Invalid bitmap_flush_interval argument";
 				goto bad;
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 97d12c7eea77..ebff14b0837d 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2236,8 +2236,6 @@ static int fec_enet_mii_probe(struct net_device *ndev)
 	fep->link = 0;
 	fep->full_duplex = 0;
 
-	phy_dev->mac_managed_pm = 1;
-
 	phy_attached_info(phy_dev);
 
 	return 0;
@@ -2249,10 +2247,12 @@ static int fec_enet_mii_init(struct platform_device *pdev)
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	bool suppress_preamble = false;
+	struct phy_device *phydev;
 	struct device_node *node;
 	int err = -ENXIO;
 	u32 mii_speed, holdtime;
 	u32 bus_freq;
+	int addr;
 
 	/*
 	 * The i.MX28 dual fec interfaces are not equal.
@@ -2362,6 +2362,13 @@ static int fec_enet_mii_init(struct platform_device *pdev)
 		goto err_out_free_mdiobus;
 	of_node_put(node);
 
+	/* find all the PHY devices on the bus and set mac_managed_pm to true */
+	for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
+		phydev = mdiobus_get_phy(fep->mii_bus, addr);
+		if (phydev)
+			phydev->mac_managed_pm = true;
+	}
+
 	mii_cnt++;
 
 	/* save fec0 mii_bus */
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c
index f3c9395d8351..618f66d9586b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c
@@ -85,7 +85,7 @@ int hclge_comm_tqps_update_stats(struct hnae3_handle *handle,
 		hclge_comm_cmd_setup_basic_desc(&desc, HCLGE_OPC_QUERY_TX_STATS,
 						true);
 
-		desc.data[0] = cpu_to_le32(tqp->index & 0x1ff);
+		desc.data[0] = cpu_to_le32(tqp->index);
 		ret = hclge_comm_cmd_send(hw, &desc, 1);
 		if (ret) {
 			dev_err(&hw->cmq.csq.pdev->dev,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index e22835ae8a94..9fce976a08f0 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -78,6 +78,9 @@ static const struct hns3_stats hns3_rxq_stats[] = {
 #define HNS3_NIC_LB_TEST_NO_MEM_ERR	1
 #define HNS3_NIC_LB_TEST_TX_CNT_ERR	2
 #define HNS3_NIC_LB_TEST_RX_CNT_ERR	3
+#define HNS3_NIC_LB_TEST_UNEXECUTED	4
+
+static int hns3_get_sset_count(struct net_device *netdev, int stringset);
 
 static int hns3_lp_setup(struct net_device *ndev, enum hnae3_loop loop, bool en)
 {
@@ -419,18 +422,26 @@ static void hns3_do_external_lb(struct net_device *ndev,
 static void hns3_self_test(struct net_device *ndev,
 			   struct ethtool_test *eth_test, u64 *data)
 {
+	int cnt = hns3_get_sset_count(ndev, ETH_SS_TEST);
 	struct hns3_nic_priv *priv = netdev_priv(ndev);
 	struct hnae3_handle *h = priv->ae_handle;
 	int st_param[HNAE3_LOOP_NONE][2];
 	bool if_running = netif_running(ndev);
+	int i;
+
+	/* initialize the loopback test result, avoid marking an unexcuted
+	 * loopback test as PASS.
+	 */
+	for (i = 0; i < cnt; i++)
+		data[i] = HNS3_NIC_LB_TEST_UNEXECUTED;
 
 	if (hns3_nic_resetting(ndev)) {
 		netdev_err(ndev, "dev resetting!");
-		return;
+		goto failure;
 	}
 
 	if (!(eth_test->flags & ETH_TEST_FL_OFFLINE))
-		return;
+		goto failure;
 
 	if (netif_msg_ifdown(h))
 		netdev_info(ndev, "self test start\n");
@@ -452,6 +463,10 @@ static void hns3_self_test(struct net_device *ndev,
 
 	if (netif_msg_ifdown(h))
 		netdev_info(ndev, "self test end\n");
+	return;
+
+failure:
+	eth_test->flags |= ETH_TEST_FL_FAILED;
 }
 
 static void hns3_update_limit_promisc_mode(struct net_device *netdev,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 27037ce79590..9db363fbc34f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -11604,6 +11604,8 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 	if (ret)
 		goto err_pci_uninit;
 
+	devl_lock(hdev->devlink);
+
 	/* Firmware command queue initialize */
 	ret = hclge_comm_cmd_queue_init(hdev->pdev, &hdev->hw.hw);
 	if (ret)
@@ -11778,6 +11780,7 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 
 	hclge_task_schedule(hdev, round_jiffies_relative(HZ));
 
+	devl_unlock(hdev->devlink);
 	return 0;
 
 err_mdiobus_unreg:
@@ -11790,6 +11793,7 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 err_cmd_uninit:
 	hclge_comm_cmd_uninit(hdev->ae_dev, &hdev->hw.hw);
 err_devlink_uninit:
+	devl_unlock(hdev->devlink);
 	hclge_devlink_uninit(hdev);
 err_pci_uninit:
 	pcim_iounmap(pdev, hdev->hw.hw.io_base);
diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 7d4cc4eafd59..5293fc00938c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -108,7 +108,7 @@
 #define I40E_MAX_BW_INACTIVE_ACCUM	4 /* accumulate 4 credits max */
 
 /* driver state flags */
-enum i40e_state_t {
+enum i40e_state {
 	__I40E_TESTING,
 	__I40E_CONFIG_BUSY,
 	__I40E_CONFIG_DONE,
@@ -156,7 +156,7 @@ enum i40e_state_t {
 	BIT_ULL(__I40E_PF_RESET_AND_REBUILD_REQUESTED)
 
 /* VSI state flags */
-enum i40e_vsi_state_t {
+enum i40e_vsi_state {
 	__I40E_VSI_DOWN,
 	__I40E_VSI_NEEDS_RESTART,
 	__I40E_VSI_SYNCING_FILTERS,
@@ -992,6 +992,8 @@ struct i40e_q_vector {
 	struct rcu_head rcu;	/* to avoid race with update stats on free */
 	char name[I40E_INT_NAME_STR_LEN];
 	bool arm_wb_state;
+	bool in_busy_poll;
+	int irq_num;		/* IRQ assigned to this q_vector */
 } ____cacheline_internodealigned_in_smp;
 
 /* lan device */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d8a7fb21b7b7..a9db1ed74d3f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1249,8 +1249,11 @@ int i40e_count_filters(struct i40e_vsi *vsi)
 	int bkt;
 	int cnt = 0;
 
-	hash_for_each_safe(vsi->mac_filter_hash, bkt, h, f, hlist)
-		++cnt;
+	hash_for_each_safe(vsi->mac_filter_hash, bkt, h, f, hlist) {
+		if (f->state == I40E_FILTER_NEW ||
+		    f->state == I40E_FILTER_ACTIVE)
+			++cnt;
+	}
 
 	return cnt;
 }
@@ -3888,6 +3891,12 @@ static void i40e_vsi_configure_msix(struct i40e_vsi *vsi)
 		     q_vector->tx.target_itr >> 1);
 		q_vector->tx.current_itr = q_vector->tx.target_itr;
 
+		/* Set ITR for software interrupts triggered after exiting
+		 * busy-loop polling.
+		 */
+		wr32(hw, I40E_PFINT_ITRN(I40E_SW_ITR, vector - 1),
+		     I40E_ITR_20K);
+
 		wr32(hw, I40E_PFINT_RATEN(vector - 1),
 		     i40e_intrl_usec_to_reg(vsi->int_rate_limit));
 
@@ -4142,6 +4151,7 @@ static int i40e_vsi_request_irq_msix(struct i40e_vsi *vsi, char *basename)
 		}
 
 		/* register for affinity change notifications */
+		q_vector->irq_num = irq_num;
 		q_vector->affinity_notify.notify = i40e_irq_affinity_notify;
 		q_vector->affinity_notify.release = i40e_irq_affinity_release;
 		irq_set_affinity_notifier(irq_num, &q_vector->affinity_notify);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 97a9efe7b713..5f2555848a69 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -34,7 +34,7 @@ enum i40e_ptp_pin {
 	GPIO_4
 };
 
-enum i40e_can_set_pins_t {
+enum i40e_can_set_pins {
 	CANT_DO_PINS = -1,
 	CAN_SET_PINS,
 	CAN_DO_PINS
@@ -192,7 +192,7 @@ static bool i40e_is_ptp_pin_dev(struct i40e_hw *hw)
  * return CAN_DO_PINS if pins can be manipulated within a NIC or
  * return CANT_DO_PINS otherwise.
  **/
-static enum i40e_can_set_pins_t i40e_can_set_pins(struct i40e_pf *pf)
+static enum i40e_can_set_pins i40e_can_set_pins(struct i40e_pf *pf)
 {
 	if (!i40e_is_ptp_pin_dev(&pf->hw)) {
 		dev_warn(&pf->pdev->dev,
@@ -1081,7 +1081,7 @@ static void i40e_ptp_set_pins_hw(struct i40e_pf *pf)
 static int i40e_ptp_set_pins(struct i40e_pf *pf,
 			     struct i40e_ptp_pins_settings *pins)
 {
-	enum i40e_can_set_pins_t pin_caps = i40e_can_set_pins(pf);
+	enum i40e_can_set_pins pin_caps = i40e_can_set_pins(pf);
 	int i = 0;
 
 	if (pin_caps == CANT_DO_PINS)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h b/drivers/net/ethernet/intel/i40e/i40e_register.h
index 7339003aa17c..694cb3e45c1e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_register.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
@@ -328,8 +328,11 @@
 #define I40E_PFINT_DYN_CTLN_ITR_INDX_SHIFT 3
 #define I40E_PFINT_DYN_CTLN_ITR_INDX_MASK I40E_MASK(0x3, I40E_PFINT_DYN_CTLN_ITR_INDX_SHIFT)
 #define I40E_PFINT_DYN_CTLN_INTERVAL_SHIFT 5
+#define I40E_PFINT_DYN_CTLN_INTERVAL_MASK I40E_MASK(0xFFF, I40E_PFINT_DYN_CTLN_INTERVAL_SHIFT)
 #define I40E_PFINT_DYN_CTLN_SW_ITR_INDX_ENA_SHIFT 24
 #define I40E_PFINT_DYN_CTLN_SW_ITR_INDX_ENA_MASK I40E_MASK(0x1, I40E_PFINT_DYN_CTLN_SW_ITR_INDX_ENA_SHIFT)
+#define I40E_PFINT_DYN_CTLN_SW_ITR_INDX_SHIFT 25
+#define I40E_PFINT_DYN_CTLN_SW_ITR_INDX_MASK I40E_MASK(0x3, I40E_PFINT_DYN_CTLN_SW_ITR_INDX_SHIFT)
 #define I40E_PFINT_ICR0 0x00038780 /* Reset: CORER */
 #define I40E_PFINT_ICR0_INTEVENT_SHIFT 0
 #define I40E_PFINT_ICR0_INTEVENT_MASK I40E_MASK(0x1, I40E_PFINT_ICR0_INTEVENT_SHIFT)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 94cf82668efa..3d83fccf742b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2571,7 +2571,22 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 	return failure ? budget : (int)total_rx_packets;
 }
 
-static inline u32 i40e_buildreg_itr(const int type, u16 itr)
+/**
+ * i40e_buildreg_itr - build a value for writing to I40E_PFINT_DYN_CTLN register
+ * @itr_idx: interrupt throttling index
+ * @interval: interrupt throttling interval value in usecs
+ * @force_swint: force software interrupt
+ *
+ * The function builds a value for I40E_PFINT_DYN_CTLN register that
+ * is used to update interrupt throttling interval for specified ITR index
+ * and optionally enforces a software interrupt. If the @itr_idx is equal
+ * to I40E_ITR_NONE then no interval change is applied and only @force_swint
+ * parameter is taken into account. If the interval change and enforced
+ * software interrupt are not requested then the built value just enables
+ * appropriate vector interrupt.
+ **/
+static u32 i40e_buildreg_itr(enum i40e_dyn_idx itr_idx, u16 interval,
+			     bool force_swint)
 {
 	u32 val;
 
@@ -2585,23 +2600,33 @@ static inline u32 i40e_buildreg_itr(const int type, u16 itr)
 	 * an event in the PBA anyway so we need to rely on the automask
 	 * to hold pending events for us until the interrupt is re-enabled
 	 *
-	 * The itr value is reported in microseconds, and the register
-	 * value is recorded in 2 microsecond units. For this reason we
-	 * only need to shift by the interval shift - 1 instead of the
-	 * full value.
+	 * We have to shift the given value as it is reported in microseconds
+	 * and the register value is recorded in 2 microsecond units.
 	 */
-	itr &= I40E_ITR_MASK;
+	interval >>= 1;
 
+	/* 1. Enable vector interrupt
+	 * 2. Update the interval for the specified ITR index
+	 *    (I40E_ITR_NONE in the register is used to indicate that
+	 *     no interval update is requested)
+	 */
 	val = I40E_PFINT_DYN_CTLN_INTENA_MASK |
-	      (type << I40E_PFINT_DYN_CTLN_ITR_INDX_SHIFT) |
-	      (itr << (I40E_PFINT_DYN_CTLN_INTERVAL_SHIFT - 1));
+	      FIELD_PREP(I40E_PFINT_DYN_CTLN_ITR_INDX_MASK, itr_idx) |
+	      FIELD_PREP(I40E_PFINT_DYN_CTLN_INTERVAL_MASK, interval);
+
+	/* 3. Enforce software interrupt trigger if requested
+	 *    (These software interrupts rate is limited by ITR2 that is
+	 *     set to 20K interrupts per second)
+	 */
+	if (force_swint)
+		val |= I40E_PFINT_DYN_CTLN_SWINT_TRIG_MASK |
+		       I40E_PFINT_DYN_CTLN_SW_ITR_INDX_ENA_MASK |
+		       FIELD_PREP(I40E_PFINT_DYN_CTLN_SW_ITR_INDX_MASK,
+				  I40E_SW_ITR);
 
 	return val;
 }
 
-/* a small macro to shorten up some long lines */
-#define INTREG I40E_PFINT_DYN_CTLN
-
 /* The act of updating the ITR will cause it to immediately trigger. In order
  * to prevent this from throwing off adaptive update statistics we defer the
  * update so that it can only happen so often. So after either Tx or Rx are
@@ -2620,8 +2645,10 @@ static inline u32 i40e_buildreg_itr(const int type, u16 itr)
 static inline void i40e_update_enable_itr(struct i40e_vsi *vsi,
 					  struct i40e_q_vector *q_vector)
 {
+	enum i40e_dyn_idx itr_idx = I40E_ITR_NONE;
 	struct i40e_hw *hw = &vsi->back->hw;
-	u32 intval;
+	u16 interval = 0;
+	u32 itr_val;
 
 	/* If we don't have MSIX, then we only need to re-enable icr0 */
 	if (!(vsi->back->flags & I40E_FLAG_MSIX_ENABLED)) {
@@ -2643,8 +2670,8 @@ static inline void i40e_update_enable_itr(struct i40e_vsi *vsi,
 	 */
 	if (q_vector->rx.target_itr < q_vector->rx.current_itr) {
 		/* Rx ITR needs to be reduced, this is highest priority */
-		intval = i40e_buildreg_itr(I40E_RX_ITR,
-					   q_vector->rx.target_itr);
+		itr_idx = I40E_RX_ITR;
+		interval = q_vector->rx.target_itr;
 		q_vector->rx.current_itr = q_vector->rx.target_itr;
 		q_vector->itr_countdown = ITR_COUNTDOWN_START;
 	} else if ((q_vector->tx.target_itr < q_vector->tx.current_itr) ||
@@ -2653,25 +2680,36 @@ static inline void i40e_update_enable_itr(struct i40e_vsi *vsi,
 		/* Tx ITR needs to be reduced, this is second priority
 		 * Tx ITR needs to be increased more than Rx, fourth priority
 		 */
-		intval = i40e_buildreg_itr(I40E_TX_ITR,
-					   q_vector->tx.target_itr);
+		itr_idx = I40E_TX_ITR;
+		interval = q_vector->tx.target_itr;
 		q_vector->tx.current_itr = q_vector->tx.target_itr;
 		q_vector->itr_countdown = ITR_COUNTDOWN_START;
 	} else if (q_vector->rx.current_itr != q_vector->rx.target_itr) {
 		/* Rx ITR needs to be increased, third priority */
-		intval = i40e_buildreg_itr(I40E_RX_ITR,
-					   q_vector->rx.target_itr);
+		itr_idx = I40E_RX_ITR;
+		interval = q_vector->rx.target_itr;
 		q_vector->rx.current_itr = q_vector->rx.target_itr;
 		q_vector->itr_countdown = ITR_COUNTDOWN_START;
 	} else {
 		/* No ITR update, lowest priority */
-		intval = i40e_buildreg_itr(I40E_ITR_NONE, 0);
 		if (q_vector->itr_countdown)
 			q_vector->itr_countdown--;
 	}
 
-	if (!test_bit(__I40E_VSI_DOWN, vsi->state))
-		wr32(hw, INTREG(q_vector->reg_idx), intval);
+	/* Do not update interrupt control register if VSI is down */
+	if (test_bit(__I40E_VSI_DOWN, vsi->state))
+		return;
+
+	/* Update ITR interval if necessary and enforce software interrupt
+	 * if we are exiting busy poll.
+	 */
+	if (q_vector->in_busy_poll) {
+		itr_val = i40e_buildreg_itr(itr_idx, interval, true);
+		q_vector->in_busy_poll = false;
+	} else {
+		itr_val = i40e_buildreg_itr(itr_idx, interval, false);
+	}
+	wr32(hw, I40E_PFINT_DYN_CTLN(q_vector->reg_idx), itr_val);
 }
 
 /**
@@ -2778,6 +2816,8 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
 	 */
 	if (likely(napi_complete_done(napi, work_done)))
 		i40e_update_enable_itr(vsi, q_vector);
+	else
+		q_vector->in_busy_poll = true;
 
 	return min(work_done, budget - 1);
 }
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index 768290dc6f48..6e567d343e03 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -57,7 +57,7 @@ static inline u16 i40e_intrl_usec_to_reg(int intrl)
  * mentioning ITR_INDX, ITR_NONE cannot be used as an index 'n' into any
  * register but instead is a special value meaning "don't update" ITR0/1/2.
  */
-enum i40e_dyn_idx_t {
+enum i40e_dyn_idx {
 	I40E_IDX_ITR0 = 0,
 	I40E_IDX_ITR1 = 1,
 	I40E_IDX_ITR2 = 2,
@@ -67,6 +67,7 @@ enum i40e_dyn_idx_t {
 /* these are indexes into ITRN registers */
 #define I40E_RX_ITR    I40E_IDX_ITR0
 #define I40E_TX_ITR    I40E_IDX_ITR1
+#define I40E_SW_ITR    I40E_IDX_ITR2
 
 /* Supported RSS offloads */
 #define I40E_DEFAULT_RSS_HENA ( \
@@ -304,7 +305,7 @@ struct i40e_rx_queue_stats {
 	u64 page_busy_count;
 };
 
-enum i40e_ring_state_t {
+enum i40e_ring_state {
 	__I40E_TX_FDIR_INIT_DONE,
 	__I40E_TX_XPS_INIT_DONE,
 	__I40E_RING_STATE_NBITS /* must be last */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index ed4be80fec2a..a5f0c95cba8b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1626,8 +1626,8 @@ bool i40e_reset_all_vfs(struct i40e_pf *pf, bool flr)
 {
 	struct i40e_hw *hw = &pf->hw;
 	struct i40e_vf *vf;
-	int i, v;
 	u32 reg;
+	int i;
 
 	/* If we don't have any VFs, then there is nothing to reset */
 	if (!pf->num_alloc_vfs)
@@ -1638,11 +1638,10 @@ bool i40e_reset_all_vfs(struct i40e_pf *pf, bool flr)
 		return false;
 
 	/* Begin reset on all VFs at once */
-	for (v = 0; v < pf->num_alloc_vfs; v++) {
-		vf = &pf->vf[v];
+	for (vf = &pf->vf[0]; vf < &pf->vf[pf->num_alloc_vfs]; ++vf) {
 		/* If VF is being reset no need to trigger reset again */
 		if (!test_bit(I40E_VF_STATE_RESETTING, &vf->vf_states))
-			i40e_trigger_vf_reset(&pf->vf[v], flr);
+			i40e_trigger_vf_reset(vf, flr);
 	}
 
 	/* HW requires some time to make sure it can flush the FIFO for a VF
@@ -1651,14 +1650,13 @@ bool i40e_reset_all_vfs(struct i40e_pf *pf, bool flr)
 	 * the VFs using a simple iterator that increments once that VF has
 	 * finished resetting.
 	 */
-	for (i = 0, v = 0; i < 10 && v < pf->num_alloc_vfs; i++) {
+	for (i = 0, vf = &pf->vf[0]; i < 10 && vf < &pf->vf[pf->num_alloc_vfs]; ++i) {
 		usleep_range(10000, 20000);
 
 		/* Check each VF in sequence, beginning with the VF to fail
 		 * the previous check.
 		 */
-		while (v < pf->num_alloc_vfs) {
-			vf = &pf->vf[v];
+		while (vf < &pf->vf[pf->num_alloc_vfs]) {
 			if (!test_bit(I40E_VF_STATE_RESETTING, &vf->vf_states)) {
 				reg = rd32(hw, I40E_VPGEN_VFRSTAT(vf->vf_id));
 				if (!(reg & I40E_VPGEN_VFRSTAT_VFRD_MASK))
@@ -1668,7 +1666,7 @@ bool i40e_reset_all_vfs(struct i40e_pf *pf, bool flr)
 			/* If the current VF has finished resetting, move on
 			 * to the next VF in sequence.
 			 */
-			v++;
+			++vf;
 		}
 	}
 
@@ -1678,39 +1676,39 @@ bool i40e_reset_all_vfs(struct i40e_pf *pf, bool flr)
 	/* Display a warning if at least one VF didn't manage to reset in
 	 * time, but continue on with the operation.
 	 */
-	if (v < pf->num_alloc_vfs)
+	if (vf < &pf->vf[pf->num_alloc_vfs])
 		dev_err(&pf->pdev->dev, "VF reset check timeout on VF %d\n",
-			pf->vf[v].vf_id);
+			vf->vf_id);
 	usleep_range(10000, 20000);
 
 	/* Begin disabling all the rings associated with VFs, but do not wait
 	 * between each VF.
 	 */
-	for (v = 0; v < pf->num_alloc_vfs; v++) {
+	for (vf = &pf->vf[0]; vf < &pf->vf[pf->num_alloc_vfs]; ++vf) {
 		/* On initial reset, we don't have any queues to disable */
-		if (pf->vf[v].lan_vsi_idx == 0)
+		if (vf->lan_vsi_idx == 0)
 			continue;
 
 		/* If VF is reset in another thread just continue */
 		if (test_bit(I40E_VF_STATE_RESETTING, &vf->vf_states))
 			continue;
 
-		i40e_vsi_stop_rings_no_wait(pf->vsi[pf->vf[v].lan_vsi_idx]);
+		i40e_vsi_stop_rings_no_wait(pf->vsi[vf->lan_vsi_idx]);
 	}
 
 	/* Now that we've notified HW to disable all of the VF rings, wait
 	 * until they finish.
 	 */
-	for (v = 0; v < pf->num_alloc_vfs; v++) {
+	for (vf = &pf->vf[0]; vf < &pf->vf[pf->num_alloc_vfs]; ++vf) {
 		/* On initial reset, we don't have any queues to disable */
-		if (pf->vf[v].lan_vsi_idx == 0)
+		if (vf->lan_vsi_idx == 0)
 			continue;
 
 		/* If VF is reset in another thread just continue */
 		if (test_bit(I40E_VF_STATE_RESETTING, &vf->vf_states))
 			continue;
 
-		i40e_vsi_wait_queues_disabled(pf->vsi[pf->vf[v].lan_vsi_idx]);
+		i40e_vsi_wait_queues_disabled(pf->vsi[vf->lan_vsi_idx]);
 	}
 
 	/* Hw may need up to 50ms to finish disabling the RX queues. We
@@ -1719,12 +1717,12 @@ bool i40e_reset_all_vfs(struct i40e_pf *pf, bool flr)
 	mdelay(50);
 
 	/* Finish the reset on each VF */
-	for (v = 0; v < pf->num_alloc_vfs; v++) {
+	for (vf = &pf->vf[0]; vf < &pf->vf[pf->num_alloc_vfs]; ++vf) {
 		/* If VF is reset in another thread just continue */
 		if (test_bit(I40E_VF_STATE_RESETTING, &vf->vf_states))
 			continue;
 
-		i40e_cleanup_reset_vf(&pf->vf[v]);
+		i40e_cleanup_reset_vf(vf);
 	}
 
 	i40e_flush(hw);
@@ -3078,11 +3076,12 @@ static int i40e_vc_del_mac_addr_msg(struct i40e_vf *vf, u8 *msg)
 		/* Allow to delete VF primary MAC only if it was not set
 		 * administratively by PF or if VF is trusted.
 		 */
-		if (ether_addr_equal(addr, vf->default_lan_addr.addr) &&
-		    i40e_can_vf_change_mac(vf))
-			was_unimac_deleted = true;
-		else
-			continue;
+		if (ether_addr_equal(addr, vf->default_lan_addr.addr)) {
+			if (i40e_can_vf_change_mac(vf))
+				was_unimac_deleted = true;
+			else
+				continue;
+		}
 
 		if (i40e_del_mac_filter(vsi, al->list[i].addr)) {
 			ret = I40E_ERR_INVALID_MAC_ADDR;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index 774de63dd93a..15fc2acffb87 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -908,7 +908,13 @@ int ixgbe_ipsec_vf_add_sa(struct ixgbe_adapter *adapter, u32 *msgbuf, u32 vf)
 		goto err_out;
 	}
 
-	xs = kzalloc(sizeof(*xs), GFP_KERNEL);
+	algo = xfrm_aead_get_byname(aes_gcm_name, IXGBE_IPSEC_AUTH_BITS, 1);
+	if (unlikely(!algo)) {
+		err = -ENOENT;
+		goto err_out;
+	}
+
+	xs = kzalloc(sizeof(*xs), GFP_ATOMIC);
 	if (unlikely(!xs)) {
 		err = -ENOMEM;
 		goto err_out;
@@ -924,14 +930,8 @@ int ixgbe_ipsec_vf_add_sa(struct ixgbe_adapter *adapter, u32 *msgbuf, u32 vf)
 		memcpy(&xs->id.daddr.a4, sam->addr, sizeof(xs->id.daddr.a4));
 	xs->xso.dev = adapter->netdev;
 
-	algo = xfrm_aead_get_byname(aes_gcm_name, IXGBE_IPSEC_AUTH_BITS, 1);
-	if (unlikely(!algo)) {
-		err = -ENOENT;
-		goto err_xs;
-	}
-
 	aead_len = sizeof(*xs->aead) + IXGBE_IPSEC_KEY_BITS / 8;
-	xs->aead = kzalloc(aead_len, GFP_KERNEL);
+	xs->aead = kzalloc(aead_len, GFP_ATOMIC);
 	if (unlikely(!xs->aead)) {
 		err = -ENOMEM;
 		goto err_xs;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index e6fe599f7bf3..254cad45a555 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -814,6 +814,11 @@ static int cgx_lmac_enadis_pause_frm(void *cgxd, int lmac_id,
 	if (!is_lmac_valid(cgx, lmac_id))
 		return -ENODEV;
 
+	cfg = cgx_read(cgx, lmac_id, CGXX_GMP_GMI_RXX_FRM_CTL);
+	cfg &= ~CGX_GMP_GMI_RXX_FRM_CTL_CTL_BCK;
+	cfg |= rx_pause ? CGX_GMP_GMI_RXX_FRM_CTL_CTL_BCK : 0x0;
+	cgx_write(cgx, lmac_id, CGXX_GMP_GMI_RXX_FRM_CTL, cfg);
+
 	cfg = cgx_read(cgx, lmac_id, CGXX_SMUX_RX_FRM_CTL);
 	cfg &= ~CGX_SMUX_RX_FRM_CTL_CTL_BCK;
 	cfg |= rx_pause ? CGX_SMUX_RX_FRM_CTL_CTL_BCK : 0x0;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index d1e6b12ecfa7..cc6d6c94f400 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -160,6 +160,8 @@ static int rvu_map_cgx_lmac_pf(struct rvu *rvu)
 			continue;
 		lmac_bmap = cgx_get_lmac_bmap(rvu_cgx_pdata(cgx, rvu));
 		for_each_set_bit(iter, &lmac_bmap, rvu->hw->lmac_per_cgx) {
+			if (iter >= MAX_LMAC_COUNT)
+				continue;
 			lmac = cgx_get_lmacid(rvu_cgx_pdata(cgx, rvu),
 					      iter);
 			rvu->pf2cgxlmac_map[pf] = cgxlmac_id_to_bmap(cgx, lmac);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 55639c133dd0..91a4ea529d07 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -1669,7 +1669,7 @@ static int npc_fwdb_detect_load_prfl_img(struct rvu *rvu, uint64_t prfl_sz,
 	struct npc_coalesced_kpu_prfl *img_data = NULL;
 	int i = 0, rc = -EINVAL;
 	void __iomem *kpu_prfl_addr;
-	u16 offset;
+	u32 offset;
 
 	img_data = (struct npc_coalesced_kpu_prfl __force *)rvu->kpu_prfl_addr;
 	if (le64_to_cpu(img_data->signature) == KPU_SIGN &&
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 7e2c30927c31..6b7fb324e756 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1914,7 +1914,7 @@ int otx2_open(struct net_device *netdev)
 	 * mcam entries are enabled to receive the packets. Hence disable the
 	 * packet I/O.
 	 */
-	if (err == EIO)
+	if (err == -EIO)
 		goto err_disable_rxtx;
 	else if (err)
 		goto err_tx_stop_queues;
diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
index 83c4659390fd..d6b4d163bbbf 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/phy.h>
 #include <linux/platform_device.h>
+#include <linux/rtnetlink.h>
 #include <linux/skbuff.h>
 
 #include "mlxbf_gige.h"
@@ -139,13 +140,10 @@ static int mlxbf_gige_open(struct net_device *netdev)
 	control |= MLXBF_GIGE_CONTROL_PORT_EN;
 	writeq(control, priv->base + MLXBF_GIGE_CONTROL);
 
-	err = mlxbf_gige_request_irqs(priv);
-	if (err)
-		return err;
 	mlxbf_gige_cache_stats(priv);
 	err = mlxbf_gige_clean_port(priv);
 	if (err)
-		goto free_irqs;
+		return err;
 
 	/* Clear driver's valid_polarity to match hardware,
 	 * since the above call to clean_port() resets the
@@ -157,7 +155,7 @@ static int mlxbf_gige_open(struct net_device *netdev)
 
 	err = mlxbf_gige_tx_init(priv);
 	if (err)
-		goto free_irqs;
+		goto phy_deinit;
 	err = mlxbf_gige_rx_init(priv);
 	if (err)
 		goto tx_deinit;
@@ -166,6 +164,10 @@ static int mlxbf_gige_open(struct net_device *netdev)
 	napi_enable(&priv->napi);
 	netif_start_queue(netdev);
 
+	err = mlxbf_gige_request_irqs(priv);
+	if (err)
+		goto napi_deinit;
+
 	/* Set bits in INT_EN that we care about */
 	int_en = MLXBF_GIGE_INT_EN_HW_ACCESS_ERROR |
 		 MLXBF_GIGE_INT_EN_TX_CHECKSUM_INPUTS |
@@ -182,11 +184,17 @@ static int mlxbf_gige_open(struct net_device *netdev)
 
 	return 0;
 
+napi_deinit:
+	netif_stop_queue(netdev);
+	napi_disable(&priv->napi);
+	netif_napi_del(&priv->napi);
+	mlxbf_gige_rx_deinit(priv);
+
 tx_deinit:
 	mlxbf_gige_tx_deinit(priv);
 
-free_irqs:
-	mlxbf_gige_free_irqs(priv);
+phy_deinit:
+	phy_stop(phydev);
 	return err;
 }
 
@@ -410,8 +418,13 @@ static void mlxbf_gige_shutdown(struct platform_device *pdev)
 {
 	struct mlxbf_gige *priv = platform_get_drvdata(pdev);
 
-	writeq(0, priv->base + MLXBF_GIGE_INT_EN);
-	mlxbf_gige_clean_port(priv);
+	rtnl_lock();
+	netif_device_detach(priv->netdev);
+
+	if (netif_running(priv->netdev))
+		dev_close(priv->netdev);
+
+	rtnl_unlock();
 }
 
 static const struct acpi_device_id __maybe_unused mlxbf_gige_acpi_match[] = {
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index e804613faa1f..d5123e8c4a9f 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -25,6 +25,8 @@
 #define PCS_POWER_STATE_DOWN	0x6
 #define PCS_POWER_STATE_UP	0x4
 
+#define RFE_RD_FIFO_TH_3_DWORDS	0x3
+
 static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
 {
 	u32 chip_rev;
@@ -3217,6 +3219,21 @@ static void lan743x_full_cleanup(struct lan743x_adapter *adapter)
 	lan743x_pci_cleanup(adapter);
 }
 
+static void pci11x1x_set_rfe_rd_fifo_threshold(struct lan743x_adapter *adapter)
+{
+	u16 rev = adapter->csr.id_rev & ID_REV_CHIP_REV_MASK_;
+
+	if (rev == ID_REV_CHIP_REV_PCI11X1X_B0_) {
+		u32 misc_ctl;
+
+		misc_ctl = lan743x_csr_read(adapter, MISC_CTL_0);
+		misc_ctl &= ~MISC_CTL_0_RFE_READ_FIFO_MASK_;
+		misc_ctl |= FIELD_PREP(MISC_CTL_0_RFE_READ_FIFO_MASK_,
+				       RFE_RD_FIFO_TH_3_DWORDS);
+		lan743x_csr_write(adapter, MISC_CTL_0, misc_ctl);
+	}
+}
+
 static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 				 struct pci_dev *pdev)
 {
@@ -3232,6 +3249,7 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 		pci11x1x_strap_get_status(adapter);
 		spin_lock_init(&adapter->eth_syslock_spinlock);
 		mutex_init(&adapter->sgmii_rw_lock);
+		pci11x1x_set_rfe_rd_fifo_threshold(adapter);
 	} else {
 		adapter->max_tx_channels = LAN743X_MAX_TX_CHANNELS;
 		adapter->used_tx_channels = LAN743X_USED_TX_CHANNELS;
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 67877d3b6dd9..d304be17b9d8 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -26,6 +26,7 @@
 #define ID_REV_CHIP_REV_MASK_		(0x0000FFFF)
 #define ID_REV_CHIP_REV_A0_		(0x00000000)
 #define ID_REV_CHIP_REV_B0_		(0x00000010)
+#define ID_REV_CHIP_REV_PCI11X1X_B0_	(0x000000B0)
 
 #define FPGA_REV			(0x04)
 #define FPGA_REV_GET_MINOR_(fpga_rev)	(((fpga_rev) >> 8) & 0x000000FF)
@@ -311,6 +312,9 @@
 #define SGMII_CTL_LINK_STATUS_SOURCE_	BIT(8)
 #define SGMII_CTL_SGMII_POWER_DN_	BIT(1)
 
+#define MISC_CTL_0			(0x920)
+#define MISC_CTL_0_RFE_READ_FIFO_MASK_	GENMASK(6, 4)
+
 /* Vendor Specific SGMII MMD details */
 #define SR_VSMMD_PCS_ID1		0x0004
 #define SR_VSMMD_PCS_ID2		0x0005
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 06663c11ca96..6e3417712e40 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -615,6 +615,9 @@ struct rtl8169_private {
 		struct work_struct work;
 	} wk;
 
+	spinlock_t config25_lock;
+	spinlock_t mac_ocp_lock;
+
 	unsigned supports_gmii:1;
 	unsigned aspm_manageable:1;
 	unsigned dash_enabled:1;
@@ -678,6 +681,28 @@ static void rtl_pci_commit(struct rtl8169_private *tp)
 	RTL_R8(tp, ChipCmd);
 }
 
+static void rtl_mod_config2(struct rtl8169_private *tp, u8 clear, u8 set)
+{
+	unsigned long flags;
+	u8 val;
+
+	spin_lock_irqsave(&tp->config25_lock, flags);
+	val = RTL_R8(tp, Config2);
+	RTL_W8(tp, Config2, (val & ~clear) | set);
+	spin_unlock_irqrestore(&tp->config25_lock, flags);
+}
+
+static void rtl_mod_config5(struct rtl8169_private *tp, u8 clear, u8 set)
+{
+	unsigned long flags;
+	u8 val;
+
+	spin_lock_irqsave(&tp->config25_lock, flags);
+	val = RTL_R8(tp, Config5);
+	RTL_W8(tp, Config5, (val & ~clear) | set);
+	spin_unlock_irqrestore(&tp->config25_lock, flags);
+}
+
 static bool rtl_is_8125(struct rtl8169_private *tp)
 {
 	return tp->mac_version >= RTL_GIGA_MAC_VER_61;
@@ -850,7 +875,7 @@ static int r8168_phy_ocp_read(struct rtl8169_private *tp, u32 reg)
 		(RTL_R32(tp, GPHY_OCP) & 0xffff) : -ETIMEDOUT;
 }
 
-static void r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
+static void __r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
 {
 	if (rtl_ocp_reg_failure(reg))
 		return;
@@ -858,7 +883,16 @@ static void r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
 	RTL_W32(tp, OCPDR, OCPAR_FLAG | (reg << 15) | data);
 }
 
-static u16 r8168_mac_ocp_read(struct rtl8169_private *tp, u32 reg)
+static void r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&tp->mac_ocp_lock, flags);
+	__r8168_mac_ocp_write(tp, reg, data);
+	spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
+}
+
+static u16 __r8168_mac_ocp_read(struct rtl8169_private *tp, u32 reg)
 {
 	if (rtl_ocp_reg_failure(reg))
 		return 0;
@@ -868,12 +902,28 @@ static u16 r8168_mac_ocp_read(struct rtl8169_private *tp, u32 reg)
 	return RTL_R32(tp, OCPDR);
 }
 
+static u16 r8168_mac_ocp_read(struct rtl8169_private *tp, u32 reg)
+{
+	unsigned long flags;
+	u16 val;
+
+	spin_lock_irqsave(&tp->mac_ocp_lock, flags);
+	val = __r8168_mac_ocp_read(tp, reg);
+	spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
+
+	return val;
+}
+
 static void r8168_mac_ocp_modify(struct rtl8169_private *tp, u32 reg, u16 mask,
 				 u16 set)
 {
-	u16 data = r8168_mac_ocp_read(tp, reg);
+	unsigned long flags;
+	u16 data;
 
-	r8168_mac_ocp_write(tp, reg, (data & ~mask) | set);
+	spin_lock_irqsave(&tp->mac_ocp_lock, flags);
+	data = __r8168_mac_ocp_read(tp, reg);
+	__r8168_mac_ocp_write(tp, reg, (data & ~mask) | set);
+	spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
 }
 
 /* Work around a hw issue with RTL8168g PHY, the quirk disables
@@ -1135,17 +1185,40 @@ static void rtl8168ep_stop_cmac(struct rtl8169_private *tp)
 	RTL_W8(tp, IBCR0, RTL_R8(tp, IBCR0) & ~0x01);
 }
 
+static void rtl_dash_loop_wait(struct rtl8169_private *tp,
+			       const struct rtl_cond *c,
+			       unsigned long usecs, int n, bool high)
+{
+	if (!tp->dash_enabled)
+		return;
+	rtl_loop_wait(tp, c, usecs, n, high);
+}
+
+static void rtl_dash_loop_wait_high(struct rtl8169_private *tp,
+				    const struct rtl_cond *c,
+				    unsigned long d, int n)
+{
+	rtl_dash_loop_wait(tp, c, d, n, true);
+}
+
+static void rtl_dash_loop_wait_low(struct rtl8169_private *tp,
+				   const struct rtl_cond *c,
+				   unsigned long d, int n)
+{
+	rtl_dash_loop_wait(tp, c, d, n, false);
+}
+
 static void rtl8168dp_driver_start(struct rtl8169_private *tp)
 {
 	r8168dp_oob_notify(tp, OOB_CMD_DRIVER_START);
-	rtl_loop_wait_high(tp, &rtl_dp_ocp_read_cond, 10000, 10);
+	rtl_dash_loop_wait_high(tp, &rtl_dp_ocp_read_cond, 10000, 10);
 }
 
 static void rtl8168ep_driver_start(struct rtl8169_private *tp)
 {
 	r8168ep_ocp_write(tp, 0x01, 0x180, OOB_CMD_DRIVER_START);
 	r8168ep_ocp_write(tp, 0x01, 0x30, r8168ep_ocp_read(tp, 0x30) | 0x01);
-	rtl_loop_wait_high(tp, &rtl_ep_ocp_read_cond, 10000, 30);
+	rtl_dash_loop_wait_high(tp, &rtl_ep_ocp_read_cond, 10000, 30);
 }
 
 static void rtl8168_driver_start(struct rtl8169_private *tp)
@@ -1159,7 +1232,7 @@ static void rtl8168_driver_start(struct rtl8169_private *tp)
 static void rtl8168dp_driver_stop(struct rtl8169_private *tp)
 {
 	r8168dp_oob_notify(tp, OOB_CMD_DRIVER_STOP);
-	rtl_loop_wait_low(tp, &rtl_dp_ocp_read_cond, 10000, 10);
+	rtl_dash_loop_wait_low(tp, &rtl_dp_ocp_read_cond, 10000, 10);
 }
 
 static void rtl8168ep_driver_stop(struct rtl8169_private *tp)
@@ -1167,7 +1240,7 @@ static void rtl8168ep_driver_stop(struct rtl8169_private *tp)
 	rtl8168ep_stop_cmac(tp);
 	r8168ep_ocp_write(tp, 0x01, 0x180, OOB_CMD_DRIVER_STOP);
 	r8168ep_ocp_write(tp, 0x01, 0x30, r8168ep_ocp_read(tp, 0x30) | 0x01);
-	rtl_loop_wait_low(tp, &rtl_ep_ocp_read_cond, 10000, 10);
+	rtl_dash_loop_wait_low(tp, &rtl_ep_ocp_read_cond, 10000, 10);
 }
 
 static void rtl8168_driver_stop(struct rtl8169_private *tp)
@@ -1351,6 +1424,7 @@ static void __rtl8169_set_wol(struct rtl8169_private *tp, u32 wolopts)
 		{ WAKE_MAGIC, Config3, MagicPacket }
 	};
 	unsigned int i, tmp = ARRAY_SIZE(cfg);
+	unsigned long flags;
 	u8 options;
 
 	rtl_unlock_config_regs(tp);
@@ -1369,12 +1443,14 @@ static void __rtl8169_set_wol(struct rtl8169_private *tp, u32 wolopts)
 			r8168_mac_ocp_modify(tp, 0xc0b6, BIT(0), 0);
 	}
 
+	spin_lock_irqsave(&tp->config25_lock, flags);
 	for (i = 0; i < tmp; i++) {
 		options = RTL_R8(tp, cfg[i].reg) & ~cfg[i].mask;
 		if (wolopts & cfg[i].opt)
 			options |= cfg[i].mask;
 		RTL_W8(tp, cfg[i].reg, options);
 	}
+	spin_unlock_irqrestore(&tp->config25_lock, flags);
 
 	switch (tp->mac_version) {
 	case RTL_GIGA_MAC_VER_02 ... RTL_GIGA_MAC_VER_06:
@@ -1386,10 +1462,10 @@ static void __rtl8169_set_wol(struct rtl8169_private *tp, u32 wolopts)
 	case RTL_GIGA_MAC_VER_34:
 	case RTL_GIGA_MAC_VER_37:
 	case RTL_GIGA_MAC_VER_39 ... RTL_GIGA_MAC_VER_63:
-		options = RTL_R8(tp, Config2) & ~PME_SIGNAL;
 		if (wolopts)
-			options |= PME_SIGNAL;
-		RTL_W8(tp, Config2, options);
+			rtl_mod_config2(tp, 0, PME_SIGNAL);
+		else
+			rtl_mod_config2(tp, PME_SIGNAL, 0);
 		break;
 	default:
 		break;
@@ -2696,10 +2772,13 @@ static void rtl_disable_exit_l1(struct rtl8169_private *tp)
 
 static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 {
+	if (tp->mac_version < RTL_GIGA_MAC_VER_32)
+		return;
+
 	/* Don't enable ASPM in the chip if OS can't control ASPM */
 	if (enable && tp->aspm_manageable) {
-		RTL_W8(tp, Config5, RTL_R8(tp, Config5) | ASPM_en);
-		RTL_W8(tp, Config2, RTL_R8(tp, Config2) | ClkReqEn);
+		rtl_mod_config5(tp, 0, ASPM_en);
+		rtl_mod_config2(tp, 0, ClkReqEn);
 
 		switch (tp->mac_version) {
 		case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
@@ -2722,11 +2801,9 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 			break;
 		}
 
-		RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
-		RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
+		rtl_mod_config2(tp, ClkReqEn, 0);
+		rtl_mod_config5(tp, ASPM_en, 0);
 	}
-
-	udelay(10);
 }
 
 static void rtl_set_fifo_size(struct rtl8169_private *tp, u16 rx_stat,
@@ -2884,7 +2961,7 @@ static void rtl_hw_start_8168e_1(struct rtl8169_private *tp)
 	RTL_W32(tp, MISC, RTL_R32(tp, MISC) | TXPLA_RST);
 	RTL_W32(tp, MISC, RTL_R32(tp, MISC) & ~TXPLA_RST);
 
-	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~Spi_en);
+	rtl_mod_config5(tp, Spi_en, 0);
 }
 
 static void rtl_hw_start_8168e_2(struct rtl8169_private *tp)
@@ -2917,7 +2994,7 @@ static void rtl_hw_start_8168e_2(struct rtl8169_private *tp)
 
 	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) | PFM_EN);
 	RTL_W32(tp, MISC, RTL_R32(tp, MISC) | PWM_EN);
-	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~Spi_en);
+	rtl_mod_config5(tp, Spi_en, 0);
 
 	rtl_hw_aspm_clkreq_enable(tp, true);
 }
@@ -2940,7 +3017,7 @@ static void rtl_hw_start_8168f(struct rtl8169_private *tp)
 	RTL_W8(tp, MCU, RTL_R8(tp, MCU) & ~NOW_IS_OOB);
 	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) | PFM_EN);
 	RTL_W32(tp, MISC, RTL_R32(tp, MISC) | PWM_EN);
-	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~Spi_en);
+	rtl_mod_config5(tp, Spi_en, 0);
 
 	rtl8168_config_eee_mac(tp);
 }
@@ -5032,6 +5109,15 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 	struct mii_bus *new_bus;
 	int ret;
 
+	/* On some boards with this chip version the BIOS is buggy and misses
+	 * to reset the PHY page selector. This results in the PHY ID read
+	 * accessing registers on a different page, returning a more or
+	 * less random value. Fix this by resetting the page selector first.
+	 */
+	if (tp->mac_version == RTL_GIGA_MAC_VER_25 ||
+	    tp->mac_version == RTL_GIGA_MAC_VER_26)
+		r8169_mdio_write(tp, 0x1f, 0);
+
 	new_bus = devm_mdiobus_alloc(&pdev->dev);
 	if (!new_bus)
 		return -ENOMEM;
@@ -5062,7 +5148,7 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 		return -EUNATCH;
 	}
 
-	tp->phydev->mac_managed_pm = 1;
+	tp->phydev->mac_managed_pm = true;
 
 	phy_support_asym_pause(tp->phydev);
 
@@ -5200,6 +5286,9 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	tp->eee_adv = -1;
 	tp->ocp_base = OCP_STD_PHY_BASE;
 
+	spin_lock_init(&tp->config25_lock);
+	spin_lock_init(&tp->mac_ocp_lock);
+
 	dev->tstats = devm_netdev_alloc_pcpu_stats(&pdev->dev,
 						   struct pcpu_sw_netstats);
 	if (!dev->tstats)
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index e7b70006261f..756ac4a07f60 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1290,25 +1290,16 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 	struct net_device *ndev = napi->dev;
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
-	bool gptp = info->gptp || info->ccc_gac;
-	struct ravb_rx_desc *desc;
 	unsigned long flags;
 	int q = napi - priv->napi;
 	int mask = BIT(q);
 	int quota = budget;
-	unsigned int entry;
+	bool unmask;
 
-	if (!gptp) {
-		entry = priv->cur_rx[q] % priv->num_rx_ring[q];
-		desc = &priv->gbeth_rx_ring[entry];
-	}
 	/* Processing RX Descriptor Ring */
 	/* Clear RX interrupt */
 	ravb_write(ndev, ~(mask | RIS0_RESERVED), RIS0);
-	if (gptp || desc->die_dt != DT_FEMPTY) {
-		if (ravb_rx(ndev, &quota, q))
-			goto out;
-	}
+	unmask = !ravb_rx(ndev, &quota, q);
 
 	/* Processing TX Descriptor Ring */
 	spin_lock_irqsave(&priv->lock, flags);
@@ -1318,6 +1309,18 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 	netif_wake_subqueue(ndev, q);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
+	/* Receive error message handling */
+	priv->rx_over_errors = priv->stats[RAVB_BE].rx_over_errors;
+	if (info->nc_queues)
+		priv->rx_over_errors += priv->stats[RAVB_NC].rx_over_errors;
+	if (priv->rx_over_errors != ndev->stats.rx_over_errors)
+		ndev->stats.rx_over_errors = priv->rx_over_errors;
+	if (priv->rx_fifo_errors != ndev->stats.rx_fifo_errors)
+		ndev->stats.rx_fifo_errors = priv->rx_fifo_errors;
+
+	if (!unmask)
+		goto out;
+
 	napi_complete(napi);
 
 	/* Re-enable RX/TX interrupts */
@@ -1331,14 +1334,6 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 	}
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	/* Receive error message handling */
-	priv->rx_over_errors =  priv->stats[RAVB_BE].rx_over_errors;
-	if (info->nc_queues)
-		priv->rx_over_errors += priv->stats[RAVB_NC].rx_over_errors;
-	if (priv->rx_over_errors != ndev->stats.rx_over_errors)
-		ndev->stats.rx_over_errors = priv->rx_over_errors;
-	if (priv->rx_fifo_errors != ndev->stats.rx_fifo_errors)
-		ndev->stats.rx_fifo_errors = priv->rx_fifo_errors;
 out:
 	return budget - quota;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 84276eb681d7..39112d5cb5b8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -87,19 +87,41 @@ static void dwmac4_rx_queue_priority(struct mac_device_info *hw,
 				     u32 prio, u32 queue)
 {
 	void __iomem *ioaddr = hw->pcsr;
-	u32 base_register;
-	u32 value;
+	u32 clear_mask = 0;
+	u32 ctrl2, ctrl3;
+	int i;
 
-	base_register = (queue < 4) ? GMAC_RXQ_CTRL2 : GMAC_RXQ_CTRL3;
-	if (queue >= 4)
-		queue -= 4;
+	ctrl2 = readl(ioaddr + GMAC_RXQ_CTRL2);
+	ctrl3 = readl(ioaddr + GMAC_RXQ_CTRL3);
 
-	value = readl(ioaddr + base_register);
+	/* The software must ensure that the same priority
+	 * is not mapped to multiple Rx queues
+	 */
+	for (i = 0; i < 4; i++)
+		clear_mask |= ((prio << GMAC_RXQCTRL_PSRQX_SHIFT(i)) &
+						GMAC_RXQCTRL_PSRQX_MASK(i));
 
-	value &= ~GMAC_RXQCTRL_PSRQX_MASK(queue);
-	value |= (prio << GMAC_RXQCTRL_PSRQX_SHIFT(queue)) &
+	ctrl2 &= ~clear_mask;
+	ctrl3 &= ~clear_mask;
+
+	/* First assign new priorities to a queue, then
+	 * clear them from others queues
+	 */
+	if (queue < 4) {
+		ctrl2 |= (prio << GMAC_RXQCTRL_PSRQX_SHIFT(queue)) &
 						GMAC_RXQCTRL_PSRQX_MASK(queue);
-	writel(value, ioaddr + base_register);
+
+		writel(ctrl2, ioaddr + GMAC_RXQ_CTRL2);
+		writel(ctrl3, ioaddr + GMAC_RXQ_CTRL3);
+	} else {
+		queue -= 4;
+
+		ctrl3 |= (prio << GMAC_RXQCTRL_PSRQX_SHIFT(queue)) &
+						GMAC_RXQCTRL_PSRQX_MASK(queue);
+
+		writel(ctrl3, ioaddr + GMAC_RXQ_CTRL3);
+		writel(ctrl2, ioaddr + GMAC_RXQ_CTRL2);
+	}
 }
 
 static void dwmac4_tx_queue_priority(struct mac_device_info *hw,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index ec1616ffbfa7..dd73f38ec08d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -97,17 +97,41 @@ static void dwxgmac2_rx_queue_prio(struct mac_device_info *hw, u32 prio,
 				   u32 queue)
 {
 	void __iomem *ioaddr = hw->pcsr;
-	u32 value, reg;
+	u32 clear_mask = 0;
+	u32 ctrl2, ctrl3;
+	int i;
 
-	reg = (queue < 4) ? XGMAC_RXQ_CTRL2 : XGMAC_RXQ_CTRL3;
-	if (queue >= 4)
+	ctrl2 = readl(ioaddr + XGMAC_RXQ_CTRL2);
+	ctrl3 = readl(ioaddr + XGMAC_RXQ_CTRL3);
+
+	/* The software must ensure that the same priority
+	 * is not mapped to multiple Rx queues
+	 */
+	for (i = 0; i < 4; i++)
+		clear_mask |= ((prio << XGMAC_PSRQ_SHIFT(i)) &
+						XGMAC_PSRQ(i));
+
+	ctrl2 &= ~clear_mask;
+	ctrl3 &= ~clear_mask;
+
+	/* First assign new priorities to a queue, then
+	 * clear them from others queues
+	 */
+	if (queue < 4) {
+		ctrl2 |= (prio << XGMAC_PSRQ_SHIFT(queue)) &
+						XGMAC_PSRQ(queue);
+
+		writel(ctrl2, ioaddr + XGMAC_RXQ_CTRL2);
+		writel(ctrl3, ioaddr + XGMAC_RXQ_CTRL3);
+	} else {
 		queue -= 4;
 
-	value = readl(ioaddr + reg);
-	value &= ~XGMAC_PSRQ(queue);
-	value |= (prio << XGMAC_PSRQ_SHIFT(queue)) & XGMAC_PSRQ(queue);
+		ctrl3 |= (prio << XGMAC_PSRQ_SHIFT(queue)) &
+						XGMAC_PSRQ(queue);
 
-	writel(value, ioaddr + reg);
+		writel(ctrl3, ioaddr + XGMAC_RXQ_CTRL3);
+		writel(ctrl2, ioaddr + XGMAC_RXQ_CTRL2);
+	}
 }
 
 static void dwxgmac2_tx_queue_prio(struct mac_device_info *hw, u32 prio,
diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 9481f172830f..2cbb1d1830bb 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -2188,6 +2188,7 @@ static int lan8814_hwtstamp(struct mii_timestamper *mii_ts, struct ifreq *ifr)
 	struct hwtstamp_config config;
 	int txcfg = 0, rxcfg = 0;
 	int pkt_ts_enable;
+	int tx_mod;
 
 	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
 		return -EFAULT;
@@ -2237,9 +2238,14 @@ static int lan8814_hwtstamp(struct mii_timestamper *mii_ts, struct ifreq *ifr)
 	lanphy_write_page_reg(ptp_priv->phydev, 5, PTP_RX_TIMESTAMP_EN, pkt_ts_enable);
 	lanphy_write_page_reg(ptp_priv->phydev, 5, PTP_TX_TIMESTAMP_EN, pkt_ts_enable);
 
-	if (ptp_priv->hwts_tx_type == HWTSTAMP_TX_ONESTEP_SYNC)
+	tx_mod = lanphy_read_page_reg(ptp_priv->phydev, 5, PTP_TX_MOD);
+	if (ptp_priv->hwts_tx_type == HWTSTAMP_TX_ONESTEP_SYNC) {
 		lanphy_write_page_reg(ptp_priv->phydev, 5, PTP_TX_MOD,
-				      PTP_TX_MOD_TX_PTP_SYNC_TS_INSERT_);
+				      tx_mod | PTP_TX_MOD_TX_PTP_SYNC_TS_INSERT_);
+	} else if (ptp_priv->hwts_tx_type == HWTSTAMP_TX_ON) {
+		lanphy_write_page_reg(ptp_priv->phydev, 5, PTP_TX_MOD,
+				      tx_mod & ~PTP_TX_MOD_TX_PTP_SYNC_TS_INSERT_);
+	}
 
 	if (config.rx_filter != HWTSTAMP_FILTER_NONE)
 		lan8814_config_ts_intr(ptp_priv->phydev, true);
@@ -2297,7 +2303,7 @@ static void lan8814_txtstamp(struct mii_timestamper *mii_ts,
 	}
 }
 
-static void lan8814_get_sig_rx(struct sk_buff *skb, u16 *sig)
+static bool lan8814_get_sig_rx(struct sk_buff *skb, u16 *sig)
 {
 	struct ptp_header *ptp_header;
 	u32 type;
@@ -2307,7 +2313,11 @@ static void lan8814_get_sig_rx(struct sk_buff *skb, u16 *sig)
 	ptp_header = ptp_parse_header(skb, type);
 	skb_pull_inline(skb, ETH_HLEN);
 
+	if (!ptp_header)
+		return false;
+
 	*sig = (__force u16)(ntohs(ptp_header->sequence_id));
+	return true;
 }
 
 static bool lan8814_match_rx_ts(struct kszphy_ptp_priv *ptp_priv,
@@ -2319,7 +2329,8 @@ static bool lan8814_match_rx_ts(struct kszphy_ptp_priv *ptp_priv,
 	bool ret = false;
 	u16 skb_sig;
 
-	lan8814_get_sig_rx(skb, &skb_sig);
+	if (!lan8814_get_sig_rx(skb, &skb_sig))
+		return ret;
 
 	/* Iterate over all RX timestamps and match it with the received skbs */
 	spin_lock_irqsave(&ptp_priv->rx_ts_lock, flags);
@@ -2599,7 +2610,7 @@ static int lan8814_ptpci_adjfine(struct ptp_clock_info *ptpci, long scaled_ppm)
 	return 0;
 }
 
-static void lan8814_get_sig_tx(struct sk_buff *skb, u16 *sig)
+static bool lan8814_get_sig_tx(struct sk_buff *skb, u16 *sig)
 {
 	struct ptp_header *ptp_header;
 	u32 type;
@@ -2607,7 +2618,11 @@ static void lan8814_get_sig_tx(struct sk_buff *skb, u16 *sig)
 	type = ptp_classify_raw(skb);
 	ptp_header = ptp_parse_header(skb, type);
 
+	if (!ptp_header)
+		return false;
+
 	*sig = (__force u16)(ntohs(ptp_header->sequence_id));
+	return true;
 }
 
 static void lan8814_dequeue_tx_skb(struct kszphy_ptp_priv *ptp_priv)
@@ -2625,7 +2640,8 @@ static void lan8814_dequeue_tx_skb(struct kszphy_ptp_priv *ptp_priv)
 
 	spin_lock_irqsave(&ptp_priv->tx_queue.lock, flags);
 	skb_queue_walk_safe(&ptp_priv->tx_queue, skb, skb_tmp) {
-		lan8814_get_sig_tx(skb, &skb_sig);
+		if (!lan8814_get_sig_tx(skb, &skb_sig))
+			continue;
 
 		if (memcmp(&skb_sig, &seq_id, sizeof(seq_id)))
 			continue;
@@ -2669,7 +2685,8 @@ static bool lan8814_match_skb(struct kszphy_ptp_priv *ptp_priv,
 
 	spin_lock_irqsave(&ptp_priv->rx_queue.lock, flags);
 	skb_queue_walk_safe(&ptp_priv->rx_queue, skb, skb_tmp) {
-		lan8814_get_sig_rx(skb, &skb_sig);
+		if (!lan8814_get_sig_rx(skb, &skb_sig))
+			continue;
 
 		if (memcmp(&skb_sig, &rx_ts->seq_id, sizeof(rx_ts->seq_id)))
 			continue;
diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index 6eacbf17f1c0..34cd568b27f1 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -714,7 +714,7 @@ static int ax88772_init_phy(struct usbnet *dev)
 	}
 
 	phy_suspend(priv->phydev);
-	priv->phydev->mac_managed_pm = 1;
+	priv->phydev->mac_managed_pm = true;
 
 	phy_attached_info(priv->phydev);
 
@@ -734,7 +734,7 @@ static int ax88772_init_phy(struct usbnet *dev)
 		return -ENODEV;
 	}
 
-	priv->phydev_int->mac_managed_pm = 1;
+	priv->phydev_int->mac_managed_pm = true;
 	phy_suspend(priv->phydev_int);
 
 	return 0;
diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index d837c1887416..e0e9b4c53cb0 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1273,6 +1273,8 @@ static void ax88179_get_mac_addr(struct usbnet *dev)
 
 	if (is_valid_ether_addr(mac)) {
 		eth_hw_addr_set(dev->net, mac);
+		if (!is_local_ether_addr(mac))
+			dev->net->addr_assign_type = NET_ADDR_PERM;
 	} else {
 		netdev_info(dev->net, "invalid MAC address, using random\n");
 		eth_hw_addr_random(dev->net);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c b/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c
index bb77bc9aa821..fb2408c0551d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c
@@ -122,14 +122,18 @@ struct iwl_rfi_freq_table_resp_cmd *iwl_rfi_get_freq_table(struct iwl_mvm *mvm)
 	if (ret)
 		return ERR_PTR(ret);
 
-	if (WARN_ON_ONCE(iwl_rx_packet_payload_len(cmd.resp_pkt) != resp_size))
+	if (WARN_ON_ONCE(iwl_rx_packet_payload_len(cmd.resp_pkt) !=
+			 resp_size)) {
+		iwl_free_resp(&cmd);
 		return ERR_PTR(-EIO);
+	}
 
 	resp = kmemdup(cmd.resp_pkt->data, resp_size, GFP_KERNEL);
+	iwl_free_resp(&cmd);
+
 	if (!resp)
 		return ERR_PTR(-ENOMEM);
 
-	iwl_free_resp(&cmd);
 	return resp;
 }
 
diff --git a/drivers/net/wwan/t7xx/t7xx_cldma.c b/drivers/net/wwan/t7xx/t7xx_cldma.c
index 9f43f256db1d..f0a4783baf1f 100644
--- a/drivers/net/wwan/t7xx/t7xx_cldma.c
+++ b/drivers/net/wwan/t7xx/t7xx_cldma.c
@@ -106,7 +106,7 @@ bool t7xx_cldma_tx_addr_is_set(struct t7xx_cldma_hw *hw_info, unsigned int qno)
 {
 	u32 offset = REG_CLDMA_UL_START_ADDRL_0 + qno * ADDR_SIZE;
 
-	return ioread64(hw_info->ap_pdn_base + offset);
+	return ioread64_lo_hi(hw_info->ap_pdn_base + offset);
 }
 
 void t7xx_cldma_hw_set_start_addr(struct t7xx_cldma_hw *hw_info, unsigned int qno, u64 address,
@@ -117,7 +117,7 @@ void t7xx_cldma_hw_set_start_addr(struct t7xx_cldma_hw *hw_info, unsigned int qn
 
 	reg = tx_rx == MTK_RX ? hw_info->ap_ao_base + REG_CLDMA_DL_START_ADDRL_0 :
 				hw_info->ap_pdn_base + REG_CLDMA_UL_START_ADDRL_0;
-	iowrite64(address, reg + offset);
+	iowrite64_lo_hi(address, reg + offset);
 }
 
 void t7xx_cldma_hw_resume_queue(struct t7xx_cldma_hw *hw_info, unsigned int qno,
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c b/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
index 6ff30cb8eb16..5d6032ceb9e5 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
@@ -139,8 +139,9 @@ static int t7xx_cldma_gpd_rx_from_q(struct cldma_queue *queue, int budget, bool
 				return -ENODEV;
 			}
 
-			gpd_addr = ioread64(hw_info->ap_pdn_base + REG_CLDMA_DL_CURRENT_ADDRL_0 +
-					    queue->index * sizeof(u64));
+			gpd_addr = ioread64_lo_hi(hw_info->ap_pdn_base +
+						  REG_CLDMA_DL_CURRENT_ADDRL_0 +
+						  queue->index * sizeof(u64));
 			if (req->gpd_addr == gpd_addr || hwo_polling_count++ >= 100)
 				return 0;
 
@@ -318,8 +319,8 @@ static void t7xx_cldma_txq_empty_hndl(struct cldma_queue *queue)
 		struct t7xx_cldma_hw *hw_info = &md_ctrl->hw_info;
 
 		/* Check current processing TGPD, 64-bit address is in a table by Q index */
-		ul_curr_addr = ioread64(hw_info->ap_pdn_base + REG_CLDMA_UL_CURRENT_ADDRL_0 +
-					queue->index * sizeof(u64));
+		ul_curr_addr = ioread64_lo_hi(hw_info->ap_pdn_base + REG_CLDMA_UL_CURRENT_ADDRL_0 +
+					      queue->index * sizeof(u64));
 		if (req->gpd_addr != ul_curr_addr) {
 			spin_unlock_irqrestore(&md_ctrl->cldma_lock, flags);
 			dev_err(md_ctrl->dev, "CLDMA%d queue %d is not empty\n",
diff --git a/drivers/net/wwan/t7xx/t7xx_pcie_mac.c b/drivers/net/wwan/t7xx/t7xx_pcie_mac.c
index 76da4c15e3de..f071ec7ff23d 100644
--- a/drivers/net/wwan/t7xx/t7xx_pcie_mac.c
+++ b/drivers/net/wwan/t7xx/t7xx_pcie_mac.c
@@ -75,7 +75,7 @@ static void t7xx_pcie_mac_atr_tables_dis(void __iomem *pbase, enum t7xx_atr_src_
 	for (i = 0; i < ATR_TABLE_NUM_PER_ATR; i++) {
 		offset = ATR_PORT_OFFSET * port + ATR_TABLE_OFFSET * i;
 		reg = pbase + ATR_PCIE_WIN0_T0_ATR_PARAM_SRC_ADDR + offset;
-		iowrite64(0, reg);
+		iowrite64_lo_hi(0, reg);
 	}
 }
 
@@ -112,17 +112,17 @@ static int t7xx_pcie_mac_atr_cfg(struct t7xx_pci_dev *t7xx_dev, struct t7xx_atr_
 
 	reg = pbase + ATR_PCIE_WIN0_T0_TRSL_ADDR + offset;
 	value = cfg->trsl_addr & ATR_PCIE_WIN0_ADDR_ALGMT;
-	iowrite64(value, reg);
+	iowrite64_lo_hi(value, reg);
 
 	reg = pbase + ATR_PCIE_WIN0_T0_TRSL_PARAM + offset;
 	iowrite32(cfg->trsl_id, reg);
 
 	reg = pbase + ATR_PCIE_WIN0_T0_ATR_PARAM_SRC_ADDR + offset;
 	value = (cfg->src_addr & ATR_PCIE_WIN0_ADDR_ALGMT) | (atr_size << 1) | BIT(0);
-	iowrite64(value, reg);
+	iowrite64_lo_hi(value, reg);
 
 	/* Ensure ATR is set */
-	ioread64(reg);
+	ioread64_lo_hi(reg);
 	return 0;
 }
 
diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index dc404e05970c..95b5ab4b964e 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -285,6 +285,7 @@ static struct sk_buff *xennet_alloc_one_rx_buffer(struct netfront_queue *queue)
 		return NULL;
 	}
 	skb_add_rx_frag(skb, 0, page, 0, 0, PAGE_SIZE);
+	skb_mark_for_recycle(skb);
 
 	/* Align ip header to a 16 bytes boundary */
 	skb_reserve(skb, NET_IP_ALIGN);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d7516e99275b..20160683e868 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1151,7 +1151,7 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	return effects;
 }
 
-void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
+void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 		       struct nvme_command *cmd, int status)
 {
 	if (effects & NVME_CMD_EFFECTS_CSE_MASK) {
@@ -1167,6 +1167,8 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
 		nvme_queue_scan(ctrl);
 		flush_work(&ctrl->scan_work);
 	}
+	if (ns)
+		return;
 
 	switch (cmd->common.opcode) {
 	case nvme_admin_set_features:
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 91e6d0347579..b3e322e4ade3 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -147,6 +147,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
 		u32 meta_seed, u64 *result, unsigned timeout, bool vec)
 {
+	struct nvme_ns *ns = q->queuedata;
 	struct nvme_ctrl *ctrl;
 	struct request *req;
 	void *meta = NULL;
@@ -181,7 +182,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	blk_mq_free_request(req);
 
 	if (effects)
-		nvme_passthru_end(ctrl, effects, cmd, ret);
+		nvme_passthru_end(ctrl, ns, effects, cmd, ret);
 
 	return ret;
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a892d679e338..8e28d2de45c0 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1063,7 +1063,7 @@ static inline void nvme_auth_free(struct nvme_ctrl *ctrl) {};
 u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			 u8 opcode);
 int nvme_execute_passthru_rq(struct request *rq, u32 *effects);
-void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
+void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 		       struct nvme_command *cmd, int status);
 struct nvme_ctrl *nvme_ctrl_from_file(struct file *file);
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid);
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index adc0958755d6..a0a292d49588 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -216,6 +216,7 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 	struct nvmet_req *req = container_of(w, struct nvmet_req, p.work);
 	struct request *rq = req->p.rq;
 	struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
+	struct nvme_ns *ns = rq->q->queuedata;
 	u32 effects;
 	int status;
 
@@ -242,7 +243,7 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 	blk_mq_free_request(rq);
 
 	if (effects)
-		nvme_passthru_end(ctrl, effects, req->cmd, status);
+		nvme_passthru_end(ctrl, ns, effects, req->cmd, status);
 }
 
 static enum rq_end_io_ret nvmet_passthru_req_done(struct request *rq,
diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 9bb9fe0fad07..e2a9651014c6 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -9,6 +9,7 @@
 
 #define pr_fmt(fmt)	"OF: " fmt
 
+#include <linux/device.h>
 #include <linux/of.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
@@ -679,6 +680,17 @@ void of_changeset_destroy(struct of_changeset *ocs)
 {
 	struct of_changeset_entry *ce, *cen;
 
+	/*
+	 * When a device is deleted, the device links to/from it are also queued
+	 * for deletion. Until these device links are freed, the devices
+	 * themselves aren't freed. If the device being deleted is due to an
+	 * overlay change, this device might be holding a reference to a device
+	 * node that will be freed. So, wait until all already pending device
+	 * links are deleted before freeing a device node. This ensures we don't
+	 * free any device node that has a non-zero reference count.
+	 */
+	device_link_wait_removal();
+
 	list_for_each_entry_safe_reverse(ce, cen, &ocs->entries, node)
 		__of_changeset_entry_destroy(ce);
 }
diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
index 56897d4d4fd3..2d5cf135e8a1 100644
--- a/drivers/perf/riscv_pmu.c
+++ b/drivers/perf/riscv_pmu.c
@@ -246,6 +246,10 @@ static int riscv_pmu_event_init(struct perf_event *event)
 	u64 event_config = 0;
 	uint64_t cmask;
 
+	/* driver does not support branch stack sampling */
+	if (has_branch_stack(event))
+		return -EOPNOTSUPP;
+
 	hwc->flags = 0;
 	mapped_event = rvpmu->event_map(event, &event_config);
 	if (mapped_event < 0) {
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index ae4b6d24bc90..1e6340e2c258 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1179,6 +1179,20 @@ static int qeth_check_irb_error(struct qeth_card *card, struct ccw_device *cdev,
 	}
 }
 
+/**
+ * qeth_irq() - qeth interrupt handler
+ * @cdev: ccw device
+ * @intparm: expect pointer to iob
+ * @irb: Interruption Response Block
+ *
+ * In the good path:
+ * corresponding qeth channel is locked with last used iob as active_cmd.
+ * But this function is also called for error interrupts.
+ *
+ * Caller ensures that:
+ * Interrupts are disabled; ccw device lock is held;
+ *
+ */
 static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
 		struct irb *irb)
 {
@@ -1220,11 +1234,10 @@ static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
 		iob = (struct qeth_cmd_buffer *) (addr_t)intparm;
 	}
 
-	qeth_unlock_channel(card, channel);
-
 	rc = qeth_check_irb_error(card, cdev, irb);
 	if (rc) {
 		/* IO was terminated, free its resources. */
+		qeth_unlock_channel(card, channel);
 		if (iob)
 			qeth_cancel_cmd(iob, rc);
 		return;
@@ -1268,6 +1281,7 @@ static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
 		rc = qeth_get_problem(card, cdev, irb);
 		if (rc) {
 			card->read_or_write_problem = 1;
+			qeth_unlock_channel(card, channel);
 			if (iob)
 				qeth_cancel_cmd(iob, rc);
 			qeth_clear_ipacmd_list(card);
@@ -1276,6 +1290,26 @@ static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
 		}
 	}
 
+	if (scsw_cmd_is_valid_cc(&irb->scsw) && irb->scsw.cmd.cc == 1 && iob) {
+		/* channel command hasn't started: retry.
+		 * active_cmd is still set to last iob
+		 */
+		QETH_CARD_TEXT(card, 2, "irqcc1");
+		rc = ccw_device_start_timeout(cdev, __ccw_from_cmd(iob),
+					      (addr_t)iob, 0, 0, iob->timeout);
+		if (rc) {
+			QETH_DBF_MESSAGE(2,
+					 "ccw retry on %x failed, rc = %i\n",
+					 CARD_DEVID(card), rc);
+			QETH_CARD_TEXT_(card, 2, " err%d", rc);
+			qeth_unlock_channel(card, channel);
+			qeth_cancel_cmd(iob, rc);
+		}
+		return;
+	}
+
+	qeth_unlock_channel(card, channel);
+
 	if (iob) {
 		/* sanity check: */
 		if (irb->scsw.cmd.count > iob->length) {
diff --git a/drivers/scsi/myrb.c b/drivers/scsi/myrb.c
index e885c1dbf61f..e2f1b186efd0 100644
--- a/drivers/scsi/myrb.c
+++ b/drivers/scsi/myrb.c
@@ -1775,9 +1775,9 @@ static ssize_t raid_state_show(struct device *dev,
 
 		name = myrb_devstate_name(ldev_info->state);
 		if (name)
-			ret = snprintf(buf, 32, "%s\n", name);
+			ret = snprintf(buf, 64, "%s\n", name);
 		else
-			ret = snprintf(buf, 32, "Invalid (%02X)\n",
+			ret = snprintf(buf, 64, "Invalid (%02X)\n",
 				       ldev_info->state);
 	} else {
 		struct myrb_pdev_state *pdev_info = sdev->hostdata;
@@ -1796,9 +1796,9 @@ static ssize_t raid_state_show(struct device *dev,
 		else
 			name = myrb_devstate_name(pdev_info->state);
 		if (name)
-			ret = snprintf(buf, 32, "%s\n", name);
+			ret = snprintf(buf, 64, "%s\n", name);
 		else
-			ret = snprintf(buf, 32, "Invalid (%02X)\n",
+			ret = snprintf(buf, 64, "Invalid (%02X)\n",
 				       pdev_info->state);
 	}
 	return ret;
@@ -1886,11 +1886,11 @@ static ssize_t raid_level_show(struct device *dev,
 
 		name = myrb_raidlevel_name(ldev_info->raid_level);
 		if (!name)
-			return snprintf(buf, 32, "Invalid (%02X)\n",
+			return snprintf(buf, 64, "Invalid (%02X)\n",
 					ldev_info->state);
-		return snprintf(buf, 32, "%s\n", name);
+		return snprintf(buf, 64, "%s\n", name);
 	}
-	return snprintf(buf, 32, "Physical Drive\n");
+	return snprintf(buf, 64, "Physical Drive\n");
 }
 static DEVICE_ATTR_RO(raid_level);
 
@@ -1903,15 +1903,15 @@ static ssize_t rebuild_show(struct device *dev,
 	unsigned char status;
 
 	if (sdev->channel < myrb_logical_channel(sdev->host))
-		return snprintf(buf, 32, "physical device - not rebuilding\n");
+		return snprintf(buf, 64, "physical device - not rebuilding\n");
 
 	status = myrb_get_rbld_progress(cb, &rbld_buf);
 
 	if (rbld_buf.ldev_num != sdev->id ||
 	    status != MYRB_STATUS_SUCCESS)
-		return snprintf(buf, 32, "not rebuilding\n");
+		return snprintf(buf, 64, "not rebuilding\n");
 
-	return snprintf(buf, 32, "rebuilding block %u of %u\n",
+	return snprintf(buf, 64, "rebuilding block %u of %u\n",
 			rbld_buf.ldev_size - rbld_buf.blocks_left,
 			rbld_buf.ldev_size);
 }
diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
index 7eb8c39da366..95e7c00cb7e5 100644
--- a/drivers/scsi/myrs.c
+++ b/drivers/scsi/myrs.c
@@ -947,9 +947,9 @@ static ssize_t raid_state_show(struct device *dev,
 
 		name = myrs_devstate_name(ldev_info->dev_state);
 		if (name)
-			ret = snprintf(buf, 32, "%s\n", name);
+			ret = snprintf(buf, 64, "%s\n", name);
 		else
-			ret = snprintf(buf, 32, "Invalid (%02X)\n",
+			ret = snprintf(buf, 64, "Invalid (%02X)\n",
 				       ldev_info->dev_state);
 	} else {
 		struct myrs_pdev_info *pdev_info;
@@ -958,9 +958,9 @@ static ssize_t raid_state_show(struct device *dev,
 		pdev_info = sdev->hostdata;
 		name = myrs_devstate_name(pdev_info->dev_state);
 		if (name)
-			ret = snprintf(buf, 32, "%s\n", name);
+			ret = snprintf(buf, 64, "%s\n", name);
 		else
-			ret = snprintf(buf, 32, "Invalid (%02X)\n",
+			ret = snprintf(buf, 64, "Invalid (%02X)\n",
 				       pdev_info->dev_state);
 	}
 	return ret;
@@ -1066,13 +1066,13 @@ static ssize_t raid_level_show(struct device *dev,
 		ldev_info = sdev->hostdata;
 		name = myrs_raid_level_name(ldev_info->raid_level);
 		if (!name)
-			return snprintf(buf, 32, "Invalid (%02X)\n",
+			return snprintf(buf, 64, "Invalid (%02X)\n",
 					ldev_info->dev_state);
 
 	} else
 		name = myrs_raid_level_name(MYRS_RAID_PHYSICAL);
 
-	return snprintf(buf, 32, "%s\n", name);
+	return snprintf(buf, 64, "%s\n", name);
 }
 static DEVICE_ATTR_RO(raid_level);
 
@@ -1086,7 +1086,7 @@ static ssize_t rebuild_show(struct device *dev,
 	unsigned char status;
 
 	if (sdev->channel < cs->ctlr_info->physchan_present)
-		return snprintf(buf, 32, "physical device - not rebuilding\n");
+		return snprintf(buf, 64, "physical device - not rebuilding\n");
 
 	ldev_info = sdev->hostdata;
 	ldev_num = ldev_info->ldev_num;
@@ -1098,11 +1098,11 @@ static ssize_t rebuild_show(struct device *dev,
 		return -EIO;
 	}
 	if (ldev_info->rbld_active) {
-		return snprintf(buf, 32, "rebuilding block %zu of %zu\n",
+		return snprintf(buf, 64, "rebuilding block %zu of %zu\n",
 				(size_t)ldev_info->rbld_lba,
 				(size_t)ldev_info->cfg_devsize);
 	} else
-		return snprintf(buf, 32, "not rebuilding\n");
+		return snprintf(buf, 64, "not rebuilding\n");
 }
 
 static ssize_t rebuild_store(struct device *dev,
@@ -1190,7 +1190,7 @@ static ssize_t consistency_check_show(struct device *dev,
 	unsigned short ldev_num;
 
 	if (sdev->channel < cs->ctlr_info->physchan_present)
-		return snprintf(buf, 32, "physical device - not checking\n");
+		return snprintf(buf, 64, "physical device - not checking\n");
 
 	ldev_info = sdev->hostdata;
 	if (!ldev_info)
@@ -1198,11 +1198,11 @@ static ssize_t consistency_check_show(struct device *dev,
 	ldev_num = ldev_info->ldev_num;
 	myrs_get_ldev_info(cs, ldev_num, ldev_info);
 	if (ldev_info->cc_active)
-		return snprintf(buf, 32, "checking block %zu of %zu\n",
+		return snprintf(buf, 64, "checking block %zu of %zu\n",
 				(size_t)ldev_info->cc_lba,
 				(size_t)ldev_info->cfg_devsize);
 	else
-		return snprintf(buf, 32, "not checking\n");
+		return snprintf(buf, 64, "not checking\n");
 }
 
 static ssize_t consistency_check_store(struct device *dev,
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index c793bca88223..f32236c3f81c 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3636,7 +3636,7 @@ static int sd_probe(struct device *dev)
 
 	error = device_add_disk(dev, gd, NULL);
 	if (error) {
-		put_device(&sdkp->disk_dev);
+		device_unregister(&sdkp->disk_dev);
 		put_disk(gd);
 		goto out;
 	}
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index e4522e86e984..8d15959004ad 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2889,12 +2889,9 @@ static void
 nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
 {
 	struct nfs4_client *clp = cb->cb_clp;
-	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 
-	spin_lock(&nn->client_lock);
 	clear_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
-	put_client_renew_locked(clp);
-	spin_unlock(&nn->client_lock);
+	drop_client(clp);
 }
 
 static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops = {
@@ -6231,7 +6228,7 @@ deleg_reaper(struct nfsd_net *nn)
 		list_add(&clp->cl_ra_cblist, &cblist);
 
 		/* release in nfsd4_cb_recall_any_release */
-		atomic_inc(&clp->cl_rpc_users);
+		kref_get(&clp->cl_nfsdfs.cl_ref);
 		set_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
 		clp->cl_ra_time = ktime_get_boottime_seconds();
 	}
diff --git a/fs/pipe.c b/fs/pipe.c
index 9873a6030df5..aa8e6ffe1cb5 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -424,6 +424,18 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	bool was_empty = false;
 	bool wake_next_writer = false;
 
+	/*
+	 * Reject writing to watch queue pipes before the point where we lock
+	 * the pipe.
+	 * Otherwise, lockdep would be unhappy if the caller already has another
+	 * pipe locked.
+	 * If we had to support locking a normal pipe and a notification pipe at
+	 * the same time, we could set up lockdep annotations for that, but
+	 * since we don't actually need that, it's simpler to just bail here.
+	 */
+	if (pipe_has_watch_queue(pipe))
+		return -EXDEV;
+
 	/* Null write succeeds. */
 	if (unlikely(total_len == 0))
 		return 0;
@@ -436,11 +448,6 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		goto out;
 	}
 
-	if (pipe_has_watch_queue(pipe)) {
-		ret = -EXDEV;
-		goto out;
-	}
-
 	/*
 	 * If it wasn't empty we try to merge new data into
 	 * the last buffer.
diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
index 86fe433b1d32..f4ad343b06c1 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -370,6 +370,7 @@ smb2_close_cached_fid(struct kref *ref)
 {
 	struct cached_fid *cfid = container_of(ref, struct cached_fid,
 					       refcount);
+	int rc;
 
 	spin_lock(&cfid->cfids->cfid_list_lock);
 	if (cfid->on_list) {
@@ -383,9 +384,10 @@ smb2_close_cached_fid(struct kref *ref)
 	cfid->dentry = NULL;
 
 	if (cfid->is_open) {
-		SMB2_close(0, cfid->tcon, cfid->fid.persistent_fid,
+		rc = SMB2_close(0, cfid->tcon, cfid->fid.persistent_fid,
 			   cfid->fid.volatile_fid);
-		atomic_dec(&cfid->tcon->num_remote_opens);
+		if (rc != -EBUSY && rc != -EAGAIN)
+			atomic_dec(&cfid->tcon->num_remote_opens);
 	}
 
 	free_cached_dir(cfid);
diff --git a/fs/smb/client/cifs_debug.c b/fs/smb/client/cifs_debug.c
index 5df8d9323337..a2afdf9c5f80 100644
--- a/fs/smb/client/cifs_debug.c
+++ b/fs/smb/client/cifs_debug.c
@@ -186,6 +186,8 @@ static int cifs_debug_files_proc_show(struct seq_file *m, void *v)
 	spin_lock(&cifs_tcp_ses_lock);
 	list_for_each_entry(server, &cifs_tcp_ses_list, tcp_ses_list) {
 		list_for_each_entry(ses, &server->smb_ses_list, smb_ses_list) {
+			if (cifs_ses_exiting(ses))
+				continue;
 			list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
 				spin_lock(&tcon->open_file_lock);
 				list_for_each_entry(cfile, &tcon->openFileList, tlist) {
@@ -566,6 +568,8 @@ static ssize_t cifs_stats_proc_write(struct file *file,
 			}
 #endif /* CONFIG_CIFS_STATS2 */
 			list_for_each_entry(ses, &server->smb_ses_list, smb_ses_list) {
+				if (cifs_ses_exiting(ses))
+					continue;
 				list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
 					atomic_set(&tcon->num_smbs_sent, 0);
 					spin_lock(&tcon->stat_lock);
@@ -644,6 +648,8 @@ static int cifs_stats_proc_show(struct seq_file *m, void *v)
 			}
 #endif /* STATS2 */
 		list_for_each_entry(ses, &server->smb_ses_list, smb_ses_list) {
+			if (cifs_ses_exiting(ses))
+				continue;
 			list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
 				i++;
 				seq_printf(m, "\n%d) %s", i, tcon->tree_name);
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 7286a56aebfa..0a79771c8f33 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -154,6 +154,7 @@ struct workqueue_struct	*decrypt_wq;
 struct workqueue_struct	*fileinfo_put_wq;
 struct workqueue_struct	*cifsoplockd_wq;
 struct workqueue_struct	*deferredclose_wq;
+struct workqueue_struct	*serverclose_wq;
 __u32 cifs_lock_secret;
 
 /*
@@ -1866,6 +1867,13 @@ init_cifs(void)
 		goto out_destroy_cifsoplockd_wq;
 	}
 
+	serverclose_wq = alloc_workqueue("serverclose",
+					   WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
+	if (!serverclose_wq) {
+		rc = -ENOMEM;
+		goto out_destroy_serverclose_wq;
+	}
+
 	rc = cifs_init_inodecache();
 	if (rc)
 		goto out_destroy_deferredclose_wq;
@@ -1940,6 +1948,8 @@ init_cifs(void)
 	destroy_workqueue(decrypt_wq);
 out_destroy_cifsiod_wq:
 	destroy_workqueue(cifsiod_wq);
+out_destroy_serverclose_wq:
+	destroy_workqueue(serverclose_wq);
 out_clean_proc:
 	cifs_proc_clean();
 	return rc;
@@ -1969,6 +1979,7 @@ exit_cifs(void)
 	destroy_workqueue(cifsoplockd_wq);
 	destroy_workqueue(decrypt_wq);
 	destroy_workqueue(fileinfo_put_wq);
+	destroy_workqueue(serverclose_wq);
 	destroy_workqueue(cifsiod_wq);
 	cifs_proc_clean();
 }
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 58bb54994e22..e5a72f9c793e 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -389,10 +389,10 @@ struct smb_version_operations {
 	/* set fid protocol-specific info */
 	void (*set_fid)(struct cifsFileInfo *, struct cifs_fid *, __u32);
 	/* close a file */
-	void (*close)(const unsigned int, struct cifs_tcon *,
+	int (*close)(const unsigned int, struct cifs_tcon *,
 		      struct cifs_fid *);
 	/* close a file, returning file attributes and timestamps */
-	void (*close_getattr)(const unsigned int xid, struct cifs_tcon *tcon,
+	int (*close_getattr)(const unsigned int xid, struct cifs_tcon *tcon,
 		      struct cifsFileInfo *pfile_info);
 	/* send a flush request to the server */
 	int (*flush)(const unsigned int, struct cifs_tcon *, struct cifs_fid *);
@@ -1359,6 +1359,7 @@ struct cifsFileInfo {
 	bool invalidHandle:1;	/* file closed via session abend */
 	bool swapfile:1;
 	bool oplock_break_cancelled:1;
+	bool offload:1; /* offload final part of _put to a wq */
 	unsigned int oplock_epoch; /* epoch from the lease break */
 	__u32 oplock_level; /* oplock/lease level from the lease break */
 	int count;
@@ -1367,6 +1368,7 @@ struct cifsFileInfo {
 	struct cifs_search_info srch_inf;
 	struct work_struct oplock_break; /* work for oplock breaks */
 	struct work_struct put; /* work for the final part of _put */
+	struct work_struct serverclose; /* work for serverclose */
 	struct delayed_work deferred;
 	bool deferred_close_scheduled; /* Flag to indicate close is scheduled */
 	char *symlink_target;
@@ -2005,6 +2007,7 @@ extern struct workqueue_struct *decrypt_wq;
 extern struct workqueue_struct *fileinfo_put_wq;
 extern struct workqueue_struct *cifsoplockd_wq;
 extern struct workqueue_struct *deferredclose_wq;
+extern struct workqueue_struct *serverclose_wq;
 extern __u32 cifs_lock_secret;
 
 extern mempool_t *cifs_mid_poolp;
@@ -2175,4 +2178,14 @@ static inline struct scatterlist *cifs_sg_set_buf(struct scatterlist *sg,
 	return sg;
 }
 
+static inline bool cifs_ses_exiting(struct cifs_ses *ses)
+{
+	bool ret;
+
+	spin_lock(&ses->ses_lock);
+	ret = ses->ses_status == SES_EXITING;
+	spin_unlock(&ses->ses_lock);
+	return ret;
+}
+
 #endif	/* _CIFS_GLOB_H */
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 49fdc6dfdcf8..8c2a784200ec 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -216,6 +216,8 @@ cifs_signal_cifsd_for_reconnect(struct TCP_Server_Info *server,
 
 	spin_lock(&cifs_tcp_ses_lock);
 	list_for_each_entry(ses, &pserver->smb_ses_list, smb_ses_list) {
+		if (cifs_ses_exiting(ses))
+			continue;
 		spin_lock(&ses->chan_lock);
 		for (i = 0; i < ses->chan_count; i++) {
 			spin_lock(&ses->chans[i].server->srv_lock);
diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
index e382b794acbe..863c7bc3db86 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -180,6 +180,7 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 	int disposition;
 	struct TCP_Server_Info *server = tcon->ses->server;
 	struct cifs_open_parms oparms;
+	int rdwr_for_fscache = 0;
 
 	*oplock = 0;
 	if (tcon->ses->server->oplocks)
@@ -191,6 +192,10 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 		return PTR_ERR(full_path);
 	}
 
+	/* If we're caching, we need to be able to fill in around partial writes. */
+	if (cifs_fscache_enabled(inode) && (oflags & O_ACCMODE) == O_WRONLY)
+		rdwr_for_fscache = 1;
+
 #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
 	if (tcon->unix_ext && cap_unix(tcon->ses) && !tcon->broken_posix_open &&
 	    (CIFS_UNIX_POSIX_PATH_OPS_CAP &
@@ -267,6 +272,8 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 		desired_access |= GENERIC_READ; /* is this too little? */
 	if (OPEN_FMODE(oflags) & FMODE_WRITE)
 		desired_access |= GENERIC_WRITE;
+	if (rdwr_for_fscache == 1)
+		desired_access |= GENERIC_READ;
 
 	disposition = FILE_OVERWRITE_IF;
 	if ((oflags & (O_CREAT | O_EXCL)) == (O_CREAT | O_EXCL))
@@ -295,6 +302,7 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 	if (!tcon->unix_ext && (mode & S_IWUGO) == 0)
 		create_options |= CREATE_OPTION_READONLY;
 
+retry_open:
 	oparms = (struct cifs_open_parms) {
 		.tcon = tcon,
 		.cifs_sb = cifs_sb,
@@ -308,8 +316,15 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 	rc = server->ops->open(xid, &oparms, oplock, buf);
 	if (rc) {
 		cifs_dbg(FYI, "cifs_create returned 0x%x\n", rc);
+		if (rc == -EACCES && rdwr_for_fscache == 1) {
+			desired_access &= ~GENERIC_READ;
+			rdwr_for_fscache = 2;
+			goto retry_open;
+		}
 		goto out;
 	}
+	if (rdwr_for_fscache == 2)
+		cifs_invalidate_cache(inode, FSCACHE_INVAL_DIO_WRITE);
 
 #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
 	/*
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 0f3405e0f2e4..d23dfc83de50 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -77,12 +77,12 @@ cifs_mark_open_files_invalid(struct cifs_tcon *tcon)
 	 */
 }
 
-static inline int cifs_convert_flags(unsigned int flags)
+static inline int cifs_convert_flags(unsigned int flags, int rdwr_for_fscache)
 {
 	if ((flags & O_ACCMODE) == O_RDONLY)
 		return GENERIC_READ;
 	else if ((flags & O_ACCMODE) == O_WRONLY)
-		return GENERIC_WRITE;
+		return rdwr_for_fscache == 1 ? (GENERIC_READ | GENERIC_WRITE) : GENERIC_WRITE;
 	else if ((flags & O_ACCMODE) == O_RDWR) {
 		/* GENERIC_ALL is too much permission to request
 		   can cause unnecessary access denied on create */
@@ -219,11 +219,16 @@ static int cifs_nt_open(const char *full_path, struct inode *inode, struct cifs_
 	int create_options = CREATE_NOT_DIR;
 	struct TCP_Server_Info *server = tcon->ses->server;
 	struct cifs_open_parms oparms;
+	int rdwr_for_fscache = 0;
 
 	if (!server->ops->open)
 		return -ENOSYS;
 
-	desired_access = cifs_convert_flags(f_flags);
+	/* If we're caching, we need to be able to fill in around partial writes. */
+	if (cifs_fscache_enabled(inode) && (f_flags & O_ACCMODE) == O_WRONLY)
+		rdwr_for_fscache = 1;
+
+	desired_access = cifs_convert_flags(f_flags, rdwr_for_fscache);
 
 /*********************************************************************
  *  open flag mapping table:
@@ -260,6 +265,7 @@ static int cifs_nt_open(const char *full_path, struct inode *inode, struct cifs_
 	if (f_flags & O_DIRECT)
 		create_options |= CREATE_NO_BUFFER;
 
+retry_open:
 	oparms = (struct cifs_open_parms) {
 		.tcon = tcon,
 		.cifs_sb = cifs_sb,
@@ -271,8 +277,16 @@ static int cifs_nt_open(const char *full_path, struct inode *inode, struct cifs_
 	};
 
 	rc = server->ops->open(xid, &oparms, oplock, buf);
-	if (rc)
+	if (rc) {
+		if (rc == -EACCES && rdwr_for_fscache == 1) {
+			desired_access = cifs_convert_flags(f_flags, 0);
+			rdwr_for_fscache = 2;
+			goto retry_open;
+		}
 		return rc;
+	}
+	if (rdwr_for_fscache == 2)
+		cifs_invalidate_cache(inode, FSCACHE_INVAL_DIO_WRITE);
 
 	/* TODO: Add support for calling posix query info but with passing in fid */
 	if (tcon->unix_ext)
@@ -316,6 +330,7 @@ cifs_down_write(struct rw_semaphore *sem)
 }
 
 static void cifsFileInfo_put_work(struct work_struct *work);
+void serverclose_work(struct work_struct *work);
 
 struct cifsFileInfo *cifs_new_fileinfo(struct cifs_fid *fid, struct file *file,
 				       struct tcon_link *tlink, __u32 oplock,
@@ -362,6 +377,7 @@ struct cifsFileInfo *cifs_new_fileinfo(struct cifs_fid *fid, struct file *file,
 	cfile->tlink = cifs_get_tlink(tlink);
 	INIT_WORK(&cfile->oplock_break, cifs_oplock_break);
 	INIT_WORK(&cfile->put, cifsFileInfo_put_work);
+	INIT_WORK(&cfile->serverclose, serverclose_work);
 	INIT_DELAYED_WORK(&cfile->deferred, smb2_deferred_work_close);
 	mutex_init(&cfile->fh_mutex);
 	spin_lock_init(&cfile->file_info_lock);
@@ -453,6 +469,40 @@ static void cifsFileInfo_put_work(struct work_struct *work)
 	cifsFileInfo_put_final(cifs_file);
 }
 
+void serverclose_work(struct work_struct *work)
+{
+	struct cifsFileInfo *cifs_file = container_of(work,
+			struct cifsFileInfo, serverclose);
+
+	struct cifs_tcon *tcon = tlink_tcon(cifs_file->tlink);
+
+	struct TCP_Server_Info *server = tcon->ses->server;
+	int rc = 0;
+	int retries = 0;
+	int MAX_RETRIES = 4;
+
+	do {
+		if (server->ops->close_getattr)
+			rc = server->ops->close_getattr(0, tcon, cifs_file);
+		else if (server->ops->close)
+			rc = server->ops->close(0, tcon, &cifs_file->fid);
+
+		if (rc == -EBUSY || rc == -EAGAIN) {
+			retries++;
+			msleep(250);
+		}
+	} while ((rc == -EBUSY || rc == -EAGAIN) && (retries < MAX_RETRIES)
+	);
+
+	if (retries == MAX_RETRIES)
+		pr_warn("Serverclose failed %d times, giving up\n", MAX_RETRIES);
+
+	if (cifs_file->offload)
+		queue_work(fileinfo_put_wq, &cifs_file->put);
+	else
+		cifsFileInfo_put_final(cifs_file);
+}
+
 /**
  * cifsFileInfo_put - release a reference of file priv data
  *
@@ -493,10 +543,13 @@ void _cifsFileInfo_put(struct cifsFileInfo *cifs_file,
 	struct cifs_fid fid = {};
 	struct cifs_pending_open open;
 	bool oplock_break_cancelled;
+	bool serverclose_offloaded = false;
 
 	spin_lock(&tcon->open_file_lock);
 	spin_lock(&cifsi->open_file_lock);
 	spin_lock(&cifs_file->file_info_lock);
+
+	cifs_file->offload = offload;
 	if (--cifs_file->count > 0) {
 		spin_unlock(&cifs_file->file_info_lock);
 		spin_unlock(&cifsi->open_file_lock);
@@ -538,13 +591,20 @@ void _cifsFileInfo_put(struct cifsFileInfo *cifs_file,
 	if (!tcon->need_reconnect && !cifs_file->invalidHandle) {
 		struct TCP_Server_Info *server = tcon->ses->server;
 		unsigned int xid;
+		int rc = 0;
 
 		xid = get_xid();
 		if (server->ops->close_getattr)
-			server->ops->close_getattr(xid, tcon, cifs_file);
+			rc = server->ops->close_getattr(xid, tcon, cifs_file);
 		else if (server->ops->close)
-			server->ops->close(xid, tcon, &cifs_file->fid);
+			rc = server->ops->close(xid, tcon, &cifs_file->fid);
 		_free_xid(xid);
+
+		if (rc == -EBUSY || rc == -EAGAIN) {
+			// Server close failed, hence offloading it as an async op
+			queue_work(serverclose_wq, &cifs_file->serverclose);
+			serverclose_offloaded = true;
+		}
 	}
 
 	if (oplock_break_cancelled)
@@ -552,10 +612,15 @@ void _cifsFileInfo_put(struct cifsFileInfo *cifs_file,
 
 	cifs_del_pending_open(&open);
 
-	if (offload)
-		queue_work(fileinfo_put_wq, &cifs_file->put);
-	else
-		cifsFileInfo_put_final(cifs_file);
+	// if serverclose has been offloaded to wq (on failure), it will
+	// handle offloading put as well. If serverclose not offloaded,
+	// we need to handle offloading put here.
+	if (!serverclose_offloaded) {
+		if (offload)
+			queue_work(fileinfo_put_wq, &cifs_file->put);
+		else
+			cifsFileInfo_put_final(cifs_file);
+	}
 }
 
 int cifs_open(struct inode *inode, struct file *file)
@@ -705,11 +770,11 @@ int cifs_open(struct inode *inode, struct file *file)
 use_cache:
 	fscache_use_cookie(cifs_inode_cookie(file_inode(file)),
 			   file->f_mode & FMODE_WRITE);
-	if (file->f_flags & O_DIRECT &&
-	    (!((file->f_flags & O_ACCMODE) != O_RDONLY) ||
-	     file->f_flags & O_APPEND))
-		cifs_invalidate_cache(file_inode(file),
-				      FSCACHE_INVAL_DIO_WRITE);
+	if (!(file->f_flags & O_DIRECT))
+		goto out;
+	if ((file->f_flags & (O_ACCMODE | O_APPEND)) == O_RDONLY)
+		goto out;
+	cifs_invalidate_cache(file_inode(file), FSCACHE_INVAL_DIO_WRITE);
 
 out:
 	free_dentry_path(page);
@@ -774,6 +839,7 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 	int disposition = FILE_OPEN;
 	int create_options = CREATE_NOT_DIR;
 	struct cifs_open_parms oparms;
+	int rdwr_for_fscache = 0;
 
 	xid = get_xid();
 	mutex_lock(&cfile->fh_mutex);
@@ -837,7 +903,11 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 	}
 #endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
 
-	desired_access = cifs_convert_flags(cfile->f_flags);
+	/* If we're caching, we need to be able to fill in around partial writes. */
+	if (cifs_fscache_enabled(inode) && (cfile->f_flags & O_ACCMODE) == O_WRONLY)
+		rdwr_for_fscache = 1;
+
+	desired_access = cifs_convert_flags(cfile->f_flags, rdwr_for_fscache);
 
 	/* O_SYNC also has bit for O_DSYNC so following check picks up either */
 	if (cfile->f_flags & O_SYNC)
@@ -849,6 +919,7 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 	if (server->ops->get_lease_key)
 		server->ops->get_lease_key(inode, &cfile->fid);
 
+retry_open:
 	oparms = (struct cifs_open_parms) {
 		.tcon = tcon,
 		.cifs_sb = cifs_sb,
@@ -874,6 +945,11 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 		/* indicate that we need to relock the file */
 		oparms.reconnect = true;
 	}
+	if (rc == -EACCES && rdwr_for_fscache == 1) {
+		desired_access = cifs_convert_flags(cfile->f_flags, 0);
+		rdwr_for_fscache = 2;
+		goto retry_open;
+	}
 
 	if (rc) {
 		mutex_unlock(&cfile->fh_mutex);
@@ -882,6 +958,9 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 		goto reopen_error_exit;
 	}
 
+	if (rdwr_for_fscache == 2)
+		cifs_invalidate_cache(inode, FSCACHE_INVAL_DIO_WRITE);
+
 #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
 reopen_success:
 #endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
diff --git a/fs/smb/client/fscache.c b/fs/smb/client/fscache.c
index f64bad513ba6..6df4ab2a6e5d 100644
--- a/fs/smb/client/fscache.c
+++ b/fs/smb/client/fscache.c
@@ -12,6 +12,16 @@
 #include "cifs_fs_sb.h"
 #include "cifsproto.h"
 
+/*
+ * Key for fscache inode.  [!] Contents must match comparisons in cifs_find_inode().
+ */
+struct cifs_fscache_inode_key {
+
+	__le64  uniqueid;	/* server inode number */
+	__le64  createtime;	/* creation time on server */
+	u8	type;		/* S_IFMT file type */
+} __packed;
+
 static void cifs_fscache_fill_volume_coherency(
 	struct cifs_tcon *tcon,
 	struct cifs_fscache_volume_coherency_data *cd)
@@ -97,15 +107,19 @@ void cifs_fscache_release_super_cookie(struct cifs_tcon *tcon)
 void cifs_fscache_get_inode_cookie(struct inode *inode)
 {
 	struct cifs_fscache_inode_coherency_data cd;
+	struct cifs_fscache_inode_key key;
 	struct cifsInodeInfo *cifsi = CIFS_I(inode);
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 	struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
 
+	key.uniqueid	= cpu_to_le64(cifsi->uniqueid);
+	key.createtime	= cpu_to_le64(cifsi->createtime);
+	key.type	= (inode->i_mode & S_IFMT) >> 12;
 	cifs_fscache_fill_coherency(&cifsi->netfs.inode, &cd);
 
 	cifsi->netfs.cache =
 		fscache_acquire_cookie(tcon->fscache, 0,
-				       &cifsi->uniqueid, sizeof(cifsi->uniqueid),
+				       &key, sizeof(key),
 				       &cd, sizeof(cd),
 				       i_size_read(&cifsi->netfs.inode));
 	if (cifsi->netfs.cache)
diff --git a/fs/smb/client/fscache.h b/fs/smb/client/fscache.h
index 67b601041f0a..c691b98b442a 100644
--- a/fs/smb/client/fscache.h
+++ b/fs/smb/client/fscache.h
@@ -108,6 +108,11 @@ static inline void cifs_readpage_to_fscache(struct inode *inode,
 		__cifs_readpage_to_fscache(inode, page);
 }
 
+static inline bool cifs_fscache_enabled(struct inode *inode)
+{
+	return fscache_cookie_enabled(cifs_inode_cookie(inode));
+}
+
 #else /* CONFIG_CIFS_FSCACHE */
 static inline
 void cifs_fscache_fill_coherency(struct inode *inode,
@@ -123,6 +128,7 @@ static inline void cifs_fscache_release_inode_cookie(struct inode *inode) {}
 static inline void cifs_fscache_unuse_inode_cookie(struct inode *inode, bool update) {}
 static inline struct fscache_cookie *cifs_inode_cookie(struct inode *inode) { return NULL; }
 static inline void cifs_invalidate_cache(struct inode *inode, unsigned int flags) {}
+static inline bool cifs_fscache_enabled(struct inode *inode) { return false; }
 
 static inline int cifs_fscache_query_occupancy(struct inode *inode,
 					       pgoff_t first, unsigned int nr_pages,
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 5343898bac8a..634f28f0d331 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -1274,6 +1274,8 @@ cifs_find_inode(struct inode *inode, void *opaque)
 {
 	struct cifs_fattr *fattr = opaque;
 
+	/* [!] The compared values must be the same in struct cifs_fscache_inode_key. */
+
 	/* don't match inode with different uniqueid */
 	if (CIFS_I(inode)->uniqueid != fattr->cf_uniqueid)
 		return 0;
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 41290c12d0bc..3826f7176608 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -476,6 +476,8 @@ is_valid_oplock_break(char *buffer, struct TCP_Server_Info *srv)
 	/* look up tcon based on tid & uid */
 	spin_lock(&cifs_tcp_ses_lock);
 	list_for_each_entry(ses, &pserver->smb_ses_list, smb_ses_list) {
+		if (cifs_ses_exiting(ses))
+			continue;
 		list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
 			if (tcon->tid != buf->Tid)
 				continue;
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index 7d1b3fc014d9..d4045925f857 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -750,11 +750,11 @@ cifs_set_fid(struct cifsFileInfo *cfile, struct cifs_fid *fid, __u32 oplock)
 	cinode->can_cache_brlcks = CIFS_CACHE_WRITE(cinode);
 }
 
-static void
+static int
 cifs_close_file(const unsigned int xid, struct cifs_tcon *tcon,
 		struct cifs_fid *fid)
 {
-	CIFSSMBClose(xid, tcon, fid->netfid);
+	return CIFSSMBClose(xid, tcon, fid->netfid);
 }
 
 static int
diff --git a/fs/smb/client/smb2misc.c b/fs/smb/client/smb2misc.c
index 15fa022e7999..8c149cb531d3 100644
--- a/fs/smb/client/smb2misc.c
+++ b/fs/smb/client/smb2misc.c
@@ -622,6 +622,8 @@ smb2_is_valid_lease_break(char *buffer, struct TCP_Server_Info *server)
 	/* look up tcon based on tid & uid */
 	spin_lock(&cifs_tcp_ses_lock);
 	list_for_each_entry(ses, &pserver->smb_ses_list, smb_ses_list) {
+		if (cifs_ses_exiting(ses))
+			continue;
 		list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
 			spin_lock(&tcon->open_file_lock);
 			cifs_stats_inc(
@@ -697,6 +699,8 @@ smb2_is_valid_oplock_break(char *buffer, struct TCP_Server_Info *server)
 	/* look up tcon based on tid & uid */
 	spin_lock(&cifs_tcp_ses_lock);
 	list_for_each_entry(ses, &pserver->smb_ses_list, smb_ses_list) {
+		if (cifs_ses_exiting(ses))
+			continue;
 		list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
 
 			spin_lock(&tcon->open_file_lock);
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 34d1262004df..2291081653a8 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -1392,14 +1392,14 @@ smb2_set_fid(struct cifsFileInfo *cfile, struct cifs_fid *fid, __u32 oplock)
 	memcpy(cfile->fid.create_guid, fid->create_guid, 16);
 }
 
-static void
+static int
 smb2_close_file(const unsigned int xid, struct cifs_tcon *tcon,
 		struct cifs_fid *fid)
 {
-	SMB2_close(xid, tcon, fid->persistent_fid, fid->volatile_fid);
+	return SMB2_close(xid, tcon, fid->persistent_fid, fid->volatile_fid);
 }
 
-static void
+static int
 smb2_close_getattr(const unsigned int xid, struct cifs_tcon *tcon,
 		   struct cifsFileInfo *cfile)
 {
@@ -1410,7 +1410,7 @@ smb2_close_getattr(const unsigned int xid, struct cifs_tcon *tcon,
 	rc = __SMB2_close(xid, tcon, cfile->fid.persistent_fid,
 		   cfile->fid.volatile_fid, &file_inf);
 	if (rc)
-		return;
+		return rc;
 
 	inode = d_inode(cfile->dentry);
 
@@ -1436,6 +1436,7 @@ smb2_close_getattr(const unsigned int xid, struct cifs_tcon *tcon,
 
 	/* End of file and Attributes should not have to be updated on close */
 	spin_unlock(&inode->i_lock);
+	return rc;
 }
 
 static int
@@ -2436,6 +2437,8 @@ smb2_is_network_name_deleted(char *buf, struct TCP_Server_Info *server)
 
 	spin_lock(&cifs_tcp_ses_lock);
 	list_for_each_entry(ses, &pserver->smb_ses_list, smb_ses_list) {
+		if (cifs_ses_exiting(ses))
+			continue;
 		list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
 			if (tcon->tid == le32_to_cpu(shdr->Id.SyncId.TreeId)) {
 				spin_lock(&tcon->tc_lock);
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 4c1231496a72..cc425a616899 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -3452,9 +3452,9 @@ __SMB2_close(const unsigned int xid, struct cifs_tcon *tcon,
 			memcpy(&pbuf->network_open_info,
 			       &rsp->network_open_info,
 			       sizeof(pbuf->network_open_info));
+		atomic_dec(&tcon->num_remote_opens);
 	}
 
-	atomic_dec(&tcon->num_remote_opens);
 close_exit:
 	SMB2_close_free(&rqst);
 	free_rsp_buf(resp_buftype, rsp);
diff --git a/fs/smb/server/ksmbd_netlink.h b/fs/smb/server/ksmbd_netlink.h
index 0ebf91ffa236..4464a62228cf 100644
--- a/fs/smb/server/ksmbd_netlink.h
+++ b/fs/smb/server/ksmbd_netlink.h
@@ -166,7 +166,8 @@ struct ksmbd_share_config_response {
 	__u16	force_uid;
 	__u16	force_gid;
 	__s8	share_name[KSMBD_REQ_MAX_SHARE_NAME];
-	__u32	reserved[112];		/* Reserved room */
+	__u32	reserved[111];		/* Reserved room */
+	__u32	payload_sz;
 	__u32	veto_list_sz;
 	__s8	____payload[];
 };
diff --git a/fs/smb/server/mgmt/share_config.c b/fs/smb/server/mgmt/share_config.c
index 328a412259dc..a2f0a2edceb8 100644
--- a/fs/smb/server/mgmt/share_config.c
+++ b/fs/smb/server/mgmt/share_config.c
@@ -158,7 +158,12 @@ static struct ksmbd_share_config *share_config_request(struct unicode_map *um,
 	share->name = kstrdup(name, GFP_KERNEL);
 
 	if (!test_share_config_flag(share, KSMBD_SHARE_FLAG_PIPE)) {
-		share->path = kstrdup(ksmbd_share_config_path(resp),
+		int path_len = PATH_MAX;
+
+		if (resp->payload_sz)
+			path_len = resp->payload_sz - resp->veto_list_sz;
+
+		share->path = kstrndup(ksmbd_share_config_path(resp), path_len,
 				      GFP_KERNEL);
 		if (share->path)
 			share->path_sz = strlen(share->path);
diff --git a/fs/smb/server/smb2ops.c b/fs/smb/server/smb2ops.c
index 27a9dce3e03a..8600f32c981a 100644
--- a/fs/smb/server/smb2ops.c
+++ b/fs/smb/server/smb2ops.c
@@ -228,6 +228,11 @@ void init_smb3_0_server(struct ksmbd_conn *conn)
 	    conn->cli_cap & SMB2_GLOBAL_CAP_ENCRYPTION)
 		conn->vals->capabilities |= SMB2_GLOBAL_CAP_ENCRYPTION;
 
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION ||
+	    (!(server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION_OFF) &&
+	     conn->cli_cap & SMB2_GLOBAL_CAP_ENCRYPTION))
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_ENCRYPTION;
+
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL)
 		conn->vals->capabilities |= SMB2_GLOBAL_CAP_MULTI_CHANNEL;
 }
@@ -275,11 +280,6 @@ int init_smb3_11_server(struct ksmbd_conn *conn)
 		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING |
 			SMB2_GLOBAL_CAP_DIRECTORY_LEASING;
 
-	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION ||
-	    (!(server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION_OFF) &&
-	     conn->cli_cap & SMB2_GLOBAL_CAP_ENCRYPTION))
-		conn->vals->capabilities |= SMB2_GLOBAL_CAP_ENCRYPTION;
-
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL)
 		conn->vals->capabilities |= SMB2_GLOBAL_CAP_MULTI_CHANNEL;
 
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 39fc078284c8..c02b1772cb80 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -5579,8 +5579,9 @@ static int smb2_rename(struct ksmbd_work *work,
 	if (!file_info->ReplaceIfExists)
 		flags = RENAME_NOREPLACE;
 
-	smb_break_all_levII_oplock(work, fp, 0);
 	rc = ksmbd_vfs_rename(work, &fp->filp->f_path, new_name, flags);
+	if (!rc)
+		smb_break_all_levII_oplock(work, fp, 0);
 out:
 	kfree(new_name);
 	return rc;
diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index f29bb03f0dc4..8752ac82c557 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -65,6 +65,7 @@ struct ipc_msg_table_entry {
 	struct hlist_node	ipc_table_hlist;
 
 	void			*response;
+	unsigned int		msg_sz;
 };
 
 static struct delayed_work ipc_timer_work;
@@ -275,6 +276,7 @@ static int handle_response(int type, void *payload, size_t sz)
 		}
 
 		memcpy(entry->response, payload, sz);
+		entry->msg_sz = sz;
 		wake_up_interruptible(&entry->wait);
 		ret = 0;
 		break;
@@ -453,6 +455,34 @@ static int ipc_msg_send(struct ksmbd_ipc_msg *msg)
 	return ret;
 }
 
+static int ipc_validate_msg(struct ipc_msg_table_entry *entry)
+{
+	unsigned int msg_sz = entry->msg_sz;
+
+	if (entry->type == KSMBD_EVENT_RPC_REQUEST) {
+		struct ksmbd_rpc_command *resp = entry->response;
+
+		msg_sz = sizeof(struct ksmbd_rpc_command) + resp->payload_sz;
+	} else if (entry->type == KSMBD_EVENT_SPNEGO_AUTHEN_REQUEST) {
+		struct ksmbd_spnego_authen_response *resp = entry->response;
+
+		msg_sz = sizeof(struct ksmbd_spnego_authen_response) +
+				resp->session_key_len + resp->spnego_blob_len;
+	} else if (entry->type == KSMBD_EVENT_SHARE_CONFIG_REQUEST) {
+		struct ksmbd_share_config_response *resp = entry->response;
+
+		if (resp->payload_sz) {
+			if (resp->payload_sz < resp->veto_list_sz)
+				return -EINVAL;
+
+			msg_sz = sizeof(struct ksmbd_share_config_response) +
+					resp->payload_sz;
+		}
+	}
+
+	return entry->msg_sz != msg_sz ? -EINVAL : 0;
+}
+
 static void *ipc_msg_send_request(struct ksmbd_ipc_msg *msg, unsigned int handle)
 {
 	struct ipc_msg_table_entry entry;
@@ -477,6 +507,13 @@ static void *ipc_msg_send_request(struct ksmbd_ipc_msg *msg, unsigned int handle
 	ret = wait_event_interruptible_timeout(entry.wait,
 					       entry.response != NULL,
 					       IPC_WAIT_TIMEOUT);
+	if (entry.response) {
+		ret = ipc_validate_msg(&entry);
+		if (ret) {
+			kvfree(entry.response);
+			entry.response = NULL;
+		}
+	}
 out:
 	down_write(&ipc_msg_table_lock);
 	hash_del(&entry.ipc_table_hlist);
diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
index d2f6df69f611..74952e58cca0 100644
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -151,7 +151,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
 		if (!sbi->nls) {
 			vbg_err("vboxsf: Count not load '%s' nls\n", nls_name);
 			err = -EINVAL;
-			goto fail_free;
+			goto fail_destroy_idr;
 		}
 	}
 
@@ -224,6 +224,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
 		ida_simple_remove(&vboxsf_bdi_ida, sbi->bdi_id);
 	if (sbi->nls)
 		unload_nls(sbi->nls);
+fail_destroy_idr:
 	idr_destroy(&sbi->ino_idr);
 	kfree(sbi);
 	return err;
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index 96b192139a23..6196b71c5eb5 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -85,7 +85,7 @@ void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu);
  */
 #define kvm_pmu_update_vcpu_events(vcpu)				\
 	do {								\
-		if (!has_vhe() && kvm_vcpu_has_pmu(vcpu))		\
+		if (!has_vhe() && kvm_arm_support_pmu_v3())		\
 			vcpu->arch.pmu.events = *kvm_get_pmu_events();	\
 	} while (0)
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 5520bb546a4a..f88b498ee9da 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1099,6 +1099,7 @@ void device_link_del(struct device_link *link);
 void device_link_remove(void *consumer, struct device *supplier);
 void device_links_supplier_sync_state_pause(void);
 void device_links_supplier_sync_state_resume(void);
+void device_link_wait_removal(void);
 
 extern __printf(3, 4)
 int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
index 988528b5da43..48ffe325184c 100644
--- a/include/linux/secretmem.h
+++ b/include/linux/secretmem.h
@@ -14,10 +14,10 @@ static inline bool page_is_secretmem(struct page *page)
 	 * Using page_mapping() is quite slow because of the actual call
 	 * instruction and repeated compound_head(page) inside the
 	 * page_mapping() function.
-	 * We know that secretmem pages are not compound and LRU so we can
+	 * We know that secretmem pages are not compound, so we can
 	 * save a couple of cycles here.
 	 */
-	if (PageCompound(page) || !PageLRU(page))
+	if (PageCompound(page))
 		return false;
 
 	mapping = (struct address_space *)
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index c30d419ebf54..c4a8520dc748 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -745,8 +745,6 @@ typedef unsigned char *sk_buff_data_t;
  *	@list: queue head
  *	@ll_node: anchor in an llist (eg socket defer_list)
  *	@sk: Socket we are owned by
- *	@ip_defrag_offset: (aka @sk) alternate use of @sk, used in
- *		fragmentation management
  *	@dev: Device we arrived on/are leaving by
  *	@dev_scratch: (aka @dev) alternate use of @dev when @dev would be %NULL
  *	@cb: Control buffer. Free for use by every layer. Put private vars here
@@ -870,10 +868,7 @@ struct sk_buff {
 		struct llist_node	ll_node;
 	};
 
-	union {
-		struct sock		*sk;
-		int			ip_defrag_offset;
-	};
+	struct sock		*sk;
 
 	union {
 		ktime_t		tstamp;
diff --git a/include/linux/udp.h b/include/linux/udp.h
index efd9ab6df379..79a4eae6f1f8 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -140,6 +140,24 @@ static inline void udp_cmsg_recv(struct msghdr *msg, struct sock *sk,
 	}
 }
 
+DECLARE_STATIC_KEY_FALSE(udp_encap_needed_key);
+#if IS_ENABLED(CONFIG_IPV6)
+DECLARE_STATIC_KEY_FALSE(udpv6_encap_needed_key);
+#endif
+
+static inline bool udp_encap_needed(void)
+{
+	if (static_branch_unlikely(&udp_encap_needed_key))
+		return true;
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (static_branch_unlikely(&udpv6_encap_needed_key))
+		return true;
+#endif
+
+	return false;
+}
+
 static inline bool udp_unexpected_gso(struct sock *sk, struct sk_buff *skb)
 {
 	if (!skb_is_gso(skb))
@@ -153,6 +171,16 @@ static inline bool udp_unexpected_gso(struct sock *sk, struct sk_buff *skb)
 	    !udp_test_bit(ACCEPT_FRAGLIST, sk))
 		return true;
 
+	/* GSO packets lacking the SKB_GSO_UDP_TUNNEL/_CSUM bits might still
+	 * land in a tunnel as the socket check in udp_gro_receive cannot be
+	 * foolproof.
+	 */
+	if (udp_encap_needed() &&
+	    READ_ONCE(udp_sk(sk)->encap_rcv) &&
+	    !(skb_shinfo(skb)->gso_type &
+	      (SKB_GSO_UDP_TUNNEL | SKB_GSO_UDP_TUNNEL_CSUM)))
+		return true;
+
 	return false;
 }
 
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c69e09909449..09bc4bf805c6 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -175,6 +175,15 @@ enum {
 	 */
 	HCI_QUIRK_USE_BDADDR_PROPERTY,
 
+	/* When this quirk is set, the Bluetooth Device Address provided by
+	 * the 'local-bd-address' fwnode property is incorrectly specified in
+	 * big-endian order.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_BDADDR_PROPERTY_BROKEN,
+
 	/* When this quirk is set, the duplicate filtering during
 	 * scanning is based on Bluetooth devices addresses. To allow
 	 * RSSI based updates, restart scanning if needed.
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 080968d6e6c5..8132f330306d 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -172,6 +172,7 @@ void inet_csk_init_xmit_timers(struct sock *sk,
 			       void (*delack_handler)(struct timer_list *),
 			       void (*keepalive_handler)(struct timer_list *));
 void inet_csk_clear_xmit_timers(struct sock *sk);
+void inet_csk_clear_xmit_timers_sync(struct sock *sk);
 
 static inline void inet_csk_schedule_ack(struct sock *sk)
 {
diff --git a/include/net/sock.h b/include/net/sock.h
index 579732d47dfc..60577751ea9e 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1833,6 +1833,13 @@ static inline void sock_owned_by_me(const struct sock *sk)
 #endif
 }
 
+static inline void sock_not_owned_by_me(const struct sock *sk)
+{
+#ifdef CONFIG_LOCKDEP
+	WARN_ON_ONCE(lockdep_sock_is_held(sk) && debug_locks);
+#endif
+}
+
 static inline bool sock_owned_by_user(const struct sock *sk)
 {
 	sock_owned_by_me(sk);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1a29ac4db6ea..27cc6e3db5a8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4965,6 +4965,11 @@ static int check_stack_access_within_bounds(
 	err = check_stack_slot_within_bounds(min_off, state, type);
 	if (!err && max_off > 0)
 		err = -EINVAL; /* out of stack access into non-negative offsets */
+	if (!err && access_size < 0)
+		/* access_size should not be negative (or overflow an int); others checks
+		 * along the way should have prevented such an access.
+		 */
+		err = -EFAULT; /* invalid negative access size; integer overflow? */
 
 	if (err) {
 		if (tnum_is_const(reg->var_off)) {
diff --git a/mm/memory.c b/mm/memory.c
index fb83cf56377a..301c74c44438 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5593,6 +5593,10 @@ int follow_phys(struct vm_area_struct *vma,
 		goto out;
 	pte = *ptep;
 
+	/* Never return PFNs of anon folios in COW mappings. */
+	if (vm_normal_folio(vma, address, pte))
+		goto unlock;
+
 	if ((flags & FOLL_WRITE) && !pte_write(pte))
 		goto unlock;
 
diff --git a/net/9p/client.c b/net/9p/client.c
index 84b93b04d0f0..1d9a8a1f3f10 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1581,7 +1581,7 @@ p9_client_read_once(struct p9_fid *fid, u64 offset, struct iov_iter *to,
 		received = rsize;
 	}
 
-	p9_debug(P9_DEBUG_9P, "<<< RREAD count %d\n", count);
+	p9_debug(P9_DEBUG_9P, "<<< RREAD count %d\n", received);
 
 	if (non_zc) {
 		int n = copy_to_iter(dataptr, received, to);
@@ -1607,9 +1607,6 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
 	int total = 0;
 	*err = 0;
 
-	p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu count %zd\n",
-		 fid->fid, offset, iov_iter_count(from));
-
 	while (iov_iter_count(from)) {
 		int count = iov_iter_count(from);
 		int rsize = fid->iounit;
@@ -1621,6 +1618,9 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
 		if (count < rsize)
 			rsize = count;
 
+		p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu count %d (/%d)\n",
+			 fid->fid, offset, rsize, count);
+
 		/* Don't bother zerocopy for small IO (< 1024) */
 		if (clnt->trans_mod->zc_request && rsize > 1024) {
 			req = p9_client_zc_rpc(clnt, P9_TWRITE, NULL, from, 0,
@@ -1648,7 +1648,7 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
 			written = rsize;
 		}
 
-		p9_debug(P9_DEBUG_9P, "<<< RWRITE count %d\n", count);
+		p9_debug(P9_DEBUG_9P, "<<< RWRITE count %d\n", written);
 
 		p9_req_put(clnt, req);
 		iov_iter_revert(from, count - written - iov_iter_count(from));
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 6124b3425f35..c9400a7d93d7 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -217,10 +217,12 @@ static int conn_info_min_age_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
 
-	if (val == 0 || val > hdev->conn_info_max_age)
+	hci_dev_lock(hdev);
+	if (val == 0 || val > hdev->conn_info_max_age) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->conn_info_min_age = val;
 	hci_dev_unlock(hdev);
 
@@ -245,10 +247,12 @@ static int conn_info_max_age_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
 
-	if (val == 0 || val < hdev->conn_info_min_age)
+	hci_dev_lock(hdev);
+	if (val == 0 || val < hdev->conn_info_min_age) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->conn_info_max_age = val;
 	hci_dev_unlock(hdev);
 
@@ -566,10 +570,12 @@ static int sniff_min_interval_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
 
-	if (val == 0 || val % 2 || val > hdev->sniff_max_interval)
+	hci_dev_lock(hdev);
+	if (val == 0 || val % 2 || val > hdev->sniff_max_interval) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->sniff_min_interval = val;
 	hci_dev_unlock(hdev);
 
@@ -594,10 +600,12 @@ static int sniff_max_interval_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
 
-	if (val == 0 || val % 2 || val < hdev->sniff_min_interval)
+	hci_dev_lock(hdev);
+	if (val == 0 || val % 2 || val < hdev->sniff_min_interval) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->sniff_max_interval = val;
 	hci_dev_unlock(hdev);
 
@@ -849,10 +857,12 @@ static int conn_min_interval_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
 
-	if (val < 0x0006 || val > 0x0c80 || val > hdev->le_conn_max_interval)
+	hci_dev_lock(hdev);
+	if (val < 0x0006 || val > 0x0c80 || val > hdev->le_conn_max_interval) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->le_conn_min_interval = val;
 	hci_dev_unlock(hdev);
 
@@ -877,10 +887,12 @@ static int conn_max_interval_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
 
-	if (val < 0x0006 || val > 0x0c80 || val < hdev->le_conn_min_interval)
+	hci_dev_lock(hdev);
+	if (val < 0x0006 || val > 0x0c80 || val < hdev->le_conn_min_interval) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->le_conn_max_interval = val;
 	hci_dev_unlock(hdev);
 
@@ -989,10 +1001,12 @@ static int adv_min_interval_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
 
-	if (val < 0x0020 || val > 0x4000 || val > hdev->le_adv_max_interval)
+	hci_dev_lock(hdev);
+	if (val < 0x0020 || val > 0x4000 || val > hdev->le_adv_max_interval) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->le_adv_min_interval = val;
 	hci_dev_unlock(hdev);
 
@@ -1017,10 +1031,12 @@ static int adv_max_interval_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
 
-	if (val < 0x0020 || val > 0x4000 || val < hdev->le_adv_min_interval)
+	hci_dev_lock(hdev);
+	if (val < 0x0020 || val > 0x4000 || val < hdev->le_adv_min_interval) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->le_adv_max_interval = val;
 	hci_dev_unlock(hdev);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b150dee88f35..bc14223f6693 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3234,6 +3234,31 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 		if (test_bit(HCI_ENCRYPT, &hdev->flags))
 			set_bit(HCI_CONN_ENCRYPT, &conn->flags);
 
+		/* "Link key request" completed ahead of "connect request" completes */
+		if (ev->encr_mode == 1 && !test_bit(HCI_CONN_ENCRYPT, &conn->flags) &&
+		    ev->link_type == ACL_LINK) {
+			struct link_key *key;
+			struct hci_cp_read_enc_key_size cp;
+
+			key = hci_find_link_key(hdev, &ev->bdaddr);
+			if (key) {
+				set_bit(HCI_CONN_ENCRYPT, &conn->flags);
+
+				if (!(hdev->commands[20] & 0x10)) {
+					conn->enc_key_size = HCI_LINK_KEY_SIZE;
+				} else {
+					cp.handle = cpu_to_le16(conn->handle);
+					if (hci_send_cmd(hdev, HCI_OP_READ_ENC_KEY_SIZE,
+							 sizeof(cp), &cp)) {
+						bt_dev_err(hdev, "sending read key size failed");
+						conn->enc_key_size = HCI_LINK_KEY_SIZE;
+					}
+				}
+
+				hci_encrypt_cfm(conn, ev->status);
+			}
+		}
+
 		/* Get remote features */
 		if (conn->type == ACL_LINK) {
 			struct hci_cp_read_remote_features cp;
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 7e64cf880f9f..e24b211b10ff 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3293,7 +3293,10 @@ static void hci_dev_get_bd_addr_from_property(struct hci_dev *hdev)
 	if (ret < 0 || !bacmp(&ba, BDADDR_ANY))
 		return;
 
-	bacpy(&hdev->public_addr, &ba);
+	if (test_bit(HCI_QUIRK_BDADDR_PROPERTY_BROKEN, &hdev->quirks))
+		baswap(&hdev->public_addr, &ba);
+	else
+		bacpy(&hdev->public_addr, &ba);
 }
 
 struct hci_init_stage {
diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index aa23479b20b2..ed62c1026fe9 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1111,6 +1111,8 @@ static int do_replace(struct net *net, sockptr_t arg, unsigned int len)
 	struct ebt_table_info *newinfo;
 	struct ebt_replace tmp;
 
+	if (len < sizeof(tmp))
+		return -EINVAL;
 	if (copy_from_sockptr(&tmp, arg, sizeof(tmp)) != 0)
 		return -EFAULT;
 
@@ -1423,6 +1425,8 @@ static int update_counters(struct net *net, sockptr_t arg, unsigned int len)
 {
 	struct ebt_replace hlp;
 
+	if (len < sizeof(hlp))
+		return -EINVAL;
 	if (copy_from_sockptr(&hlp, arg, sizeof(hlp)))
 		return -EFAULT;
 
@@ -2352,6 +2356,8 @@ static int compat_update_counters(struct net *net, sockptr_t arg,
 {
 	struct compat_ebt_replace hlp;
 
+	if (len < sizeof(hlp))
+		return -EINVAL;
 	if (copy_from_sockptr(&hlp, arg, sizeof(hlp)))
 		return -EFAULT;
 
diff --git a/net/core/gro.c b/net/core/gro.c
index 352f966cb1da..47118e97ecfd 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -252,8 +252,9 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 	}
 
 merge:
-	/* sk owenrship - if any - completely transferred to the aggregated packet */
+	/* sk ownership - if any - completely transferred to the aggregated packet */
 	skb->destructor = NULL;
+	skb->sk = NULL;
 	delta_truesize = skb->truesize;
 	if (offset > headlen) {
 		unsigned int eat = offset - headlen;
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 91140bc0541f..aa7ff6a46429 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -413,6 +413,9 @@ static int __sock_map_delete(struct bpf_stab *stab, struct sock *sk_test,
 	struct sock *sk;
 	int err = 0;
 
+	if (irqs_disabled())
+		return -EOPNOTSUPP; /* locks here are hardirq-unsafe */
+
 	raw_spin_lock_bh(&stab->lock);
 	sk = *psk;
 	if (!sk_test || sk_test == sk)
@@ -926,6 +929,9 @@ static int sock_hash_delete_elem(struct bpf_map *map, void *key)
 	struct bpf_shtab_elem *elem;
 	int ret = -ENOENT;
 
+	if (irqs_disabled())
+		return -EOPNOTSUPP; /* locks here are hardirq-unsafe */
+
 	hash = sock_hash_bucket_hash(key, key_size);
 	bucket = sock_hash_select_bucket(htab, hash);
 
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 79fa19a36bbd..8407098a5939 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -289,6 +289,7 @@ static bool inet_bhash2_addr_any_conflict(const struct sock *sk, int port, int l
 	struct sock_reuseport *reuseport_cb;
 	struct inet_bind_hashbucket *head2;
 	struct inet_bind2_bucket *tb2;
+	bool conflict = false;
 	bool reuseport_cb_ok;
 
 	rcu_read_lock();
@@ -301,18 +302,20 @@ static bool inet_bhash2_addr_any_conflict(const struct sock *sk, int port, int l
 
 	spin_lock(&head2->lock);
 
-	inet_bind_bucket_for_each(tb2, &head2->chain)
-		if (inet_bind2_bucket_match_addr_any(tb2, net, port, l3mdev, sk))
-			break;
+	inet_bind_bucket_for_each(tb2, &head2->chain) {
+		if (!inet_bind2_bucket_match_addr_any(tb2, net, port, l3mdev, sk))
+			continue;
 
-	if (tb2 && inet_bhash2_conflict(sk, tb2, uid, relax, reuseport_cb_ok,
-					reuseport_ok)) {
-		spin_unlock(&head2->lock);
-		return true;
+		if (!inet_bhash2_conflict(sk, tb2, uid, relax, reuseport_cb_ok,	reuseport_ok))
+			continue;
+
+		conflict = true;
+		break;
 	}
 
 	spin_unlock(&head2->lock);
-	return false;
+
+	return conflict;
 }
 
 /*
@@ -771,6 +774,20 @@ void inet_csk_clear_xmit_timers(struct sock *sk)
 }
 EXPORT_SYMBOL(inet_csk_clear_xmit_timers);
 
+void inet_csk_clear_xmit_timers_sync(struct sock *sk)
+{
+	struct inet_connection_sock *icsk = inet_csk(sk);
+
+	/* ongoing timer handlers need to acquire socket lock. */
+	sock_not_owned_by_me(sk);
+
+	icsk->icsk_pending = icsk->icsk_ack.pending = 0;
+
+	sk_stop_timer_sync(sk, &icsk->icsk_retransmit_timer);
+	sk_stop_timer_sync(sk, &icsk->icsk_delack_timer);
+	sk_stop_timer_sync(sk, &sk->sk_timer);
+}
+
 void inet_csk_delete_keepalive_timer(struct sock *sk)
 {
 	sk_stop_timer(sk, &sk->sk_timer);
diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index c9f9ac5013a7..834cdc57755f 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -24,6 +24,8 @@
 #include <net/ip.h>
 #include <net/ipv6.h>
 
+#include "../core/sock_destructor.h"
+
 /* Use skb->cb to track consecutive/adjacent fragments coming at
  * the end of the queue. Nodes in the rb-tree queue will
  * contain "runs" of one or more adjacent fragments.
@@ -39,6 +41,7 @@ struct ipfrag_skb_cb {
 	};
 	struct sk_buff		*next_frag;
 	int			frag_run_len;
+	int			ip_defrag_offset;
 };
 
 #define FRAG_CB(skb)		((struct ipfrag_skb_cb *)((skb)->cb))
@@ -390,12 +393,12 @@ int inet_frag_queue_insert(struct inet_frag_queue *q, struct sk_buff *skb,
 	 */
 	if (!last)
 		fragrun_create(q, skb);  /* First fragment. */
-	else if (last->ip_defrag_offset + last->len < end) {
+	else if (FRAG_CB(last)->ip_defrag_offset + last->len < end) {
 		/* This is the common case: skb goes to the end. */
 		/* Detect and discard overlaps. */
-		if (offset < last->ip_defrag_offset + last->len)
+		if (offset < FRAG_CB(last)->ip_defrag_offset + last->len)
 			return IPFRAG_OVERLAP;
-		if (offset == last->ip_defrag_offset + last->len)
+		if (offset == FRAG_CB(last)->ip_defrag_offset + last->len)
 			fragrun_append_to_last(q, skb);
 		else
 			fragrun_create(q, skb);
@@ -412,13 +415,13 @@ int inet_frag_queue_insert(struct inet_frag_queue *q, struct sk_buff *skb,
 
 			parent = *rbn;
 			curr = rb_to_skb(parent);
-			curr_run_end = curr->ip_defrag_offset +
+			curr_run_end = FRAG_CB(curr)->ip_defrag_offset +
 					FRAG_CB(curr)->frag_run_len;
-			if (end <= curr->ip_defrag_offset)
+			if (end <= FRAG_CB(curr)->ip_defrag_offset)
 				rbn = &parent->rb_left;
 			else if (offset >= curr_run_end)
 				rbn = &parent->rb_right;
-			else if (offset >= curr->ip_defrag_offset &&
+			else if (offset >= FRAG_CB(curr)->ip_defrag_offset &&
 				 end <= curr_run_end)
 				return IPFRAG_DUP;
 			else
@@ -432,7 +435,7 @@ int inet_frag_queue_insert(struct inet_frag_queue *q, struct sk_buff *skb,
 		rb_insert_color(&skb->rbnode, &q->rb_fragments);
 	}
 
-	skb->ip_defrag_offset = offset;
+	FRAG_CB(skb)->ip_defrag_offset = offset;
 
 	return IPFRAG_OK;
 }
@@ -442,13 +445,28 @@ void *inet_frag_reasm_prepare(struct inet_frag_queue *q, struct sk_buff *skb,
 			      struct sk_buff *parent)
 {
 	struct sk_buff *fp, *head = skb_rb_first(&q->rb_fragments);
-	struct sk_buff **nextp;
+	void (*destructor)(struct sk_buff *);
+	unsigned int orig_truesize = 0;
+	struct sk_buff **nextp = NULL;
+	struct sock *sk = skb->sk;
 	int delta;
 
+	if (sk && is_skb_wmem(skb)) {
+		/* TX: skb->sk might have been passed as argument to
+		 * dst->output and must remain valid until tx completes.
+		 *
+		 * Move sk to reassembled skb and fix up wmem accounting.
+		 */
+		orig_truesize = skb->truesize;
+		destructor = skb->destructor;
+	}
+
 	if (head != skb) {
 		fp = skb_clone(skb, GFP_ATOMIC);
-		if (!fp)
-			return NULL;
+		if (!fp) {
+			head = skb;
+			goto out_restore_sk;
+		}
 		FRAG_CB(fp)->next_frag = FRAG_CB(skb)->next_frag;
 		if (RB_EMPTY_NODE(&skb->rbnode))
 			FRAG_CB(parent)->next_frag = fp;
@@ -457,6 +475,12 @@ void *inet_frag_reasm_prepare(struct inet_frag_queue *q, struct sk_buff *skb,
 					&q->rb_fragments);
 		if (q->fragments_tail == skb)
 			q->fragments_tail = fp;
+
+		if (orig_truesize) {
+			/* prevent skb_morph from releasing sk */
+			skb->sk = NULL;
+			skb->destructor = NULL;
+		}
 		skb_morph(skb, head);
 		FRAG_CB(skb)->next_frag = FRAG_CB(head)->next_frag;
 		rb_replace_node(&head->rbnode, &skb->rbnode,
@@ -464,13 +488,13 @@ void *inet_frag_reasm_prepare(struct inet_frag_queue *q, struct sk_buff *skb,
 		consume_skb(head);
 		head = skb;
 	}
-	WARN_ON(head->ip_defrag_offset != 0);
+	WARN_ON(FRAG_CB(head)->ip_defrag_offset != 0);
 
 	delta = -head->truesize;
 
 	/* Head of list must not be cloned. */
 	if (skb_unclone(head, GFP_ATOMIC))
-		return NULL;
+		goto out_restore_sk;
 
 	delta += head->truesize;
 	if (delta)
@@ -486,7 +510,7 @@ void *inet_frag_reasm_prepare(struct inet_frag_queue *q, struct sk_buff *skb,
 
 		clone = alloc_skb(0, GFP_ATOMIC);
 		if (!clone)
-			return NULL;
+			goto out_restore_sk;
 		skb_shinfo(clone)->frag_list = skb_shinfo(head)->frag_list;
 		skb_frag_list_init(head);
 		for (i = 0; i < skb_shinfo(head)->nr_frags; i++)
@@ -503,6 +527,21 @@ void *inet_frag_reasm_prepare(struct inet_frag_queue *q, struct sk_buff *skb,
 		nextp = &skb_shinfo(head)->frag_list;
 	}
 
+out_restore_sk:
+	if (orig_truesize) {
+		int ts_delta = head->truesize - orig_truesize;
+
+		/* if this reassembled skb is fragmented later,
+		 * fraglist skbs will get skb->sk assigned from head->sk,
+		 * and each frag skb will be released via sock_wfree.
+		 *
+		 * Update sk_wmem_alloc.
+		 */
+		head->sk = sk;
+		head->destructor = destructor;
+		refcount_add(ts_delta, &sk->sk_wmem_alloc);
+	}
+
 	return nextp;
 }
 EXPORT_SYMBOL(inet_frag_reasm_prepare);
@@ -510,6 +549,8 @@ EXPORT_SYMBOL(inet_frag_reasm_prepare);
 void inet_frag_reasm_finish(struct inet_frag_queue *q, struct sk_buff *head,
 			    void *reasm_data, bool try_coalesce)
 {
+	struct sock *sk = is_skb_wmem(head) ? head->sk : NULL;
+	const unsigned int head_truesize = head->truesize;
 	struct sk_buff **nextp = reasm_data;
 	struct rb_node *rbn;
 	struct sk_buff *fp;
@@ -573,6 +614,9 @@ void inet_frag_reasm_finish(struct inet_frag_queue *q, struct sk_buff *head,
 	head->prev = NULL;
 	head->tstamp = q->stamp;
 	head->mono_delivery_time = q->mono_delivery_time;
+
+	if (sk)
+		refcount_add(sum_truesize - head_truesize, &sk->sk_wmem_alloc);
 }
 EXPORT_SYMBOL(inet_frag_reasm_finish);
 
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index fb153569889e..6c309c1ec3b0 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -378,6 +378,7 @@ static int ip_frag_queue(struct ipq *qp, struct sk_buff *skb)
 	}
 
 	skb_dst_drop(skb);
+	skb_orphan(skb);
 	return -EINPROGRESS;
 
 insert_error:
@@ -480,7 +481,6 @@ int ip_defrag(struct net *net, struct sk_buff *skb, u32 user)
 	struct ipq *qp;
 
 	__IP_INC_STATS(net, IPSTATS_MIB_REASMREQDS);
-	skb_orphan(skb);
 
 	/* Lookup (or create) queue header */
 	qp = ip_find(net, ip_hdr(skb), user, vif);
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index d67d026d7f97..0267fa05374a 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -280,8 +280,13 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 					  tpi->flags | TUNNEL_NO_KEY,
 					  iph->saddr, iph->daddr, 0);
 	} else {
+		if (unlikely(!pskb_may_pull(skb,
+					    gre_hdr_len + sizeof(*ershdr))))
+			return PACKET_REJECT;
+
 		ershdr = (struct erspan_base_hdr *)(skb->data + gre_hdr_len);
 		ver = ershdr->ver;
+		iph = ip_hdr(skb);
 		tunnel = ip_tunnel_lookup(itn, skb->dev->ifindex,
 					  tpi->flags | TUNNEL_KEY,
 					  iph->saddr, iph->daddr, tpi->key);
diff --git a/net/ipv4/netfilter/arp_tables.c b/net/ipv4/netfilter/arp_tables.c
index 2407066b0fec..b150c9929b12 100644
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -956,6 +956,8 @@ static int do_replace(struct net *net, sockptr_t arg, unsigned int len)
 	void *loc_cpu_entry;
 	struct arpt_entry *iter;
 
+	if (len < sizeof(tmp))
+		return -EINVAL;
 	if (copy_from_sockptr(&tmp, arg, sizeof(tmp)) != 0)
 		return -EFAULT;
 
@@ -1254,6 +1256,8 @@ static int compat_do_replace(struct net *net, sockptr_t arg, unsigned int len)
 	void *loc_cpu_entry;
 	struct arpt_entry *iter;
 
+	if (len < sizeof(tmp))
+		return -EINVAL;
 	if (copy_from_sockptr(&tmp, arg, sizeof(tmp)) != 0)
 		return -EFAULT;
 
diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
index da5998011ab9..1f365e28e316 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -1110,6 +1110,8 @@ do_replace(struct net *net, sockptr_t arg, unsigned int len)
 	void *loc_cpu_entry;
 	struct ipt_entry *iter;
 
+	if (len < sizeof(tmp))
+		return -EINVAL;
 	if (copy_from_sockptr(&tmp, arg, sizeof(tmp)) != 0)
 		return -EFAULT;
 
@@ -1494,6 +1496,8 @@ compat_do_replace(struct net *net, sockptr_t arg, unsigned int len)
 	void *loc_cpu_entry;
 	struct ipt_entry *iter;
 
+	if (len < sizeof(tmp))
+		return -EINVAL;
 	if (copy_from_sockptr(&tmp, arg, sizeof(tmp)) != 0)
 		return -EFAULT;
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 5a165e29f7be..f01c0a5d2c37 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3052,6 +3052,8 @@ void tcp_close(struct sock *sk, long timeout)
 	lock_sock(sk);
 	__tcp_close(sk, timeout);
 	release_sock(sk);
+	if (!sk->sk_net_refcnt)
+		inet_csk_clear_xmit_timers_sync(sk);
 	sock_put(sk);
 }
 EXPORT_SYMBOL(tcp_close);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 7856b7a3e0ee..2a78c78186c3 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -603,6 +603,13 @@ static inline bool __udp_is_mcast_sock(struct net *net, struct sock *sk,
 }
 
 DEFINE_STATIC_KEY_FALSE(udp_encap_needed_key);
+EXPORT_SYMBOL(udp_encap_needed_key);
+
+#if IS_ENABLED(CONFIG_IPV6)
+DEFINE_STATIC_KEY_FALSE(udpv6_encap_needed_key);
+EXPORT_SYMBOL(udpv6_encap_needed_key);
+#endif
+
 void udp_encap_enable(void)
 {
 	static_branch_inc(&udp_encap_needed_key);
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 8096576fd9bd..84b7d6089f76 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -441,8 +441,9 @@ static int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
 	NAPI_GRO_CB(p)->count++;
 	p->data_len += skb->len;
 
-	/* sk owenrship - if any - completely transferred to the aggregated packet */
+	/* sk ownership - if any - completely transferred to the aggregated packet */
 	skb->destructor = NULL;
+	skb->sk = NULL;
 	p->truesize += skb->truesize;
 	p->len += skb->len;
 
@@ -543,11 +544,19 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
 	unsigned int off = skb_gro_offset(skb);
 	int flush = 1;
 
-	/* we can do L4 aggregation only if the packet can't land in a tunnel
-	 * otherwise we could corrupt the inner stream
+	/* We can do L4 aggregation only if the packet can't land in a tunnel
+	 * otherwise we could corrupt the inner stream. Detecting such packets
+	 * cannot be foolproof and the aggregation might still happen in some
+	 * cases. Such packets should be caught in udp_unexpected_gso later.
 	 */
 	NAPI_GRO_CB(skb)->is_flist = 0;
 	if (!sk || !udp_sk(sk)->gro_receive) {
+		/* If the packet was locally encapsulated in a UDP tunnel that
+		 * wasn't detected above, do not GRO.
+		 */
+		if (skb->encapsulation)
+			goto out;
+
 		if (skb->dev->features & NETIF_F_GRO_FRAGLIST)
 			NAPI_GRO_CB(skb)->is_flist = sk ? !udp_test_bit(GRO_ENABLED, sk) : 1;
 
@@ -707,13 +716,7 @@ INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int nhoff)
 		skb_shinfo(skb)->gso_type |= (SKB_GSO_FRAGLIST|SKB_GSO_UDP_L4);
 		skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
 
-		if (skb->ip_summed == CHECKSUM_UNNECESSARY) {
-			if (skb->csum_level < SKB_MAX_CSUM_LEVEL)
-				skb->csum_level++;
-		} else {
-			skb->ip_summed = CHECKSUM_UNNECESSARY;
-			skb->csum_level = 0;
-		}
+		__skb_incr_checksum_unnecessary(skb);
 
 		return 0;
 	}
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 1840735e9cb0..e606374854ce 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -646,19 +646,19 @@ static int inet6_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 	if (!w) {
 		/* New dump:
 		 *
-		 * 1. hook callback destructor.
-		 */
-		cb->args[3] = (long)cb->done;
-		cb->done = fib6_dump_done;
-
-		/*
-		 * 2. allocate and initialize walker.
+		 * 1. allocate and initialize walker.
 		 */
 		w = kzalloc(sizeof(*w), GFP_ATOMIC);
 		if (!w)
 			return -ENOMEM;
 		w->func = fib6_dump_node;
 		cb->args[2] = (long)w;
+
+		/* 2. hook callback destructor.
+		 */
+		cb->args[3] = (long)cb->done;
+		cb->done = fib6_dump_done;
+
 	}
 
 	arg.skb = skb;
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index d3fba7d8dec4..b3e2d658af80 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -528,6 +528,9 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 	struct ip6_tnl *tunnel;
 	u8 ver;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ershdr))))
+		return PACKET_REJECT;
+
 	ipv6h = ipv6_hdr(skb);
 	ershdr = (struct erspan_base_hdr *)skb->data;
 	ver = ershdr->ver;
diff --git a/net/ipv6/netfilter/ip6_tables.c b/net/ipv6/netfilter/ip6_tables.c
index 0ce0ed17c758..37a2b3301e42 100644
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -1127,6 +1127,8 @@ do_replace(struct net *net, sockptr_t arg, unsigned int len)
 	void *loc_cpu_entry;
 	struct ip6t_entry *iter;
 
+	if (len < sizeof(tmp))
+		return -EINVAL;
 	if (copy_from_sockptr(&tmp, arg, sizeof(tmp)) != 0)
 		return -EFAULT;
 
@@ -1503,6 +1505,8 @@ compat_do_replace(struct net *net, sockptr_t arg, unsigned int len)
 	void *loc_cpu_entry;
 	struct ip6t_entry *iter;
 
+	if (len < sizeof(tmp))
+		return -EINVAL;
 	if (copy_from_sockptr(&tmp, arg, sizeof(tmp)) != 0)
 		return -EFAULT;
 
diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index 38db0064d661..87a394179092 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -293,6 +293,7 @@ static int nf_ct_frag6_queue(struct frag_queue *fq, struct sk_buff *skb,
 	}
 
 	skb_dst_drop(skb);
+	skb_orphan(skb);
 	return -EINPROGRESS;
 
 insert_error:
@@ -468,7 +469,6 @@ int nf_ct_frag6_gather(struct net *net, struct sk_buff *skb, u32 user)
 	hdr = ipv6_hdr(skb);
 	fhdr = (struct frag_hdr *)skb_transport_header(skb);
 
-	skb_orphan(skb);
 	fq = fq_find(net, fhdr->identification, user, hdr,
 		     skb->dev ? skb->dev->ifindex : 0);
 	if (fq == NULL) {
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index c2c02dea6c38..1775e9b9b85a 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -476,7 +476,7 @@ int udpv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	goto try_again;
 }
 
-DEFINE_STATIC_KEY_FALSE(udpv6_encap_needed_key);
+DECLARE_STATIC_KEY_FALSE(udpv6_encap_needed_key);
 void udpv6_encap_enable(void)
 {
 	static_branch_inc(&udpv6_encap_needed_key);
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index 7720d04ed396..b98c4c8d8e27 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -169,13 +169,7 @@ INDIRECT_CALLABLE_SCOPE int udp6_gro_complete(struct sk_buff *skb, int nhoff)
 		skb_shinfo(skb)->gso_type |= (SKB_GSO_FRAGLIST|SKB_GSO_UDP_L4);
 		skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
 
-		if (skb->ip_summed == CHECKSUM_UNNECESSARY) {
-			if (skb->csum_level < SKB_MAX_CSUM_LEVEL)
-				skb->csum_level++;
-		} else {
-			skb->ip_summed = CHECKSUM_UNNECESSARY;
-			skb->csum_level = 0;
-		}
+		__skb_incr_checksum_unnecessary(skb);
 
 		return 0;
 	}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3bc21581486a..c652c8ca765c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3349,9 +3349,6 @@ static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
 
 		newsk = new_mptcp_sock;
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEPASSIVEACK);
-	} else {
-		MPTCP_INC_STATS(sock_net(sk),
-				MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
 	}
 
 out:
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 891c2f4fed08..f1d422396b28 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -816,6 +816,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	return child;
 
 fallback:
+	if (fallback)
+		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
 	mptcp_subflow_drop_ctx(child);
 	return child;
 }
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 2a5d9075a081..8d38cd504769 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2372,6 +2372,9 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 		struct nft_stats __percpu *stats = NULL;
 		struct nft_chain_hook hook;
 
+		if (table->flags & __NFT_TABLE_F_UPDATE)
+			return -EINVAL;
+
 		if (flags & NFT_CHAIN_BINDING)
 			return -EOPNOTSUPP;
 
@@ -7838,11 +7841,12 @@ static int nft_flowtable_parse_hook(const struct nft_ctx *ctx,
 	return err;
 }
 
+/* call under rcu_read_lock */
 static const struct nf_flowtable_type *__nft_flowtable_type_get(u8 family)
 {
 	const struct nf_flowtable_type *type;
 
-	list_for_each_entry(type, &nf_tables_flowtables, list) {
+	list_for_each_entry_rcu(type, &nf_tables_flowtables, list) {
 		if (family == type->family)
 			return type;
 	}
@@ -7854,9 +7858,13 @@ nft_flowtable_type_get(struct net *net, u8 family)
 {
 	const struct nf_flowtable_type *type;
 
+	rcu_read_lock();
 	type = __nft_flowtable_type_get(family);
-	if (type != NULL && try_module_get(type->owner))
+	if (type != NULL && try_module_get(type->owner)) {
+		rcu_read_unlock();
 		return type;
+	}
+	rcu_read_unlock();
 
 	lockdep_nfnl_nft_mutex_not_held();
 #ifdef CONFIG_MODULES
@@ -10978,6 +10986,7 @@ static void __exit nf_tables_module_exit(void)
 	unregister_netdevice_notifier(&nf_tables_flowtable_notifier);
 	nft_chain_filter_fini();
 	nft_chain_route_fini();
+	nf_tables_trans_destroy_flush_work();
 	unregister_pernet_subsys(&nf_tables_net_ops);
 	cancel_work_sync(&trans_gc_work);
 	cancel_work_sync(&trans_destroy_work);
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index b5071a2f597d..f76a2d806034 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1512,6 +1512,11 @@ static void nci_rx_work(struct work_struct *work)
 		nfc_send_to_raw_sock(ndev->nfc_dev, skb,
 				     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);
 
+		if (!nci_plen(skb->data)) {
+			kfree_skb(skb);
+			break;
+		}
+
 		/* Process frame */
 		switch (nci_mt(skb->data)) {
 		case NCI_MT_RSP_PKT:
diff --git a/net/rds/rdma.c b/net/rds/rdma.c
index a4e3c5de998b..00dbcd4d28e6 100644
--- a/net/rds/rdma.c
+++ b/net/rds/rdma.c
@@ -302,7 +302,7 @@ static int __rds_rdma_map(struct rds_sock *rs, struct rds_get_mr_args *args,
 		}
 		ret = PTR_ERR(trans_private);
 		/* Trigger connection so that its ready for the next retry */
-		if (ret == -ENODEV)
+		if (ret == -ENODEV && cp)
 			rds_conn_connect_if_down(cp->cp_conn);
 		goto out;
 	}
diff --git a/net/sched/act_skbmod.c b/net/sched/act_skbmod.c
index d98758a63934..744ff9729469 100644
--- a/net/sched/act_skbmod.c
+++ b/net/sched/act_skbmod.c
@@ -239,13 +239,13 @@ static int tcf_skbmod_dump(struct sk_buff *skb, struct tc_action *a,
 	struct tcf_skbmod *d = to_skbmod(a);
 	unsigned char *b = skb_tail_pointer(skb);
 	struct tcf_skbmod_params  *p;
-	struct tc_skbmod opt = {
-		.index   = d->tcf_index,
-		.refcnt  = refcount_read(&d->tcf_refcnt) - ref,
-		.bindcnt = atomic_read(&d->tcf_bindcnt) - bind,
-	};
+	struct tc_skbmod opt;
 	struct tcf_t t;
 
+	memset(&opt, 0, sizeof(opt));
+	opt.index   = d->tcf_index;
+	opt.refcnt  = refcount_read(&d->tcf_refcnt) - ref,
+	opt.bindcnt = atomic_read(&d->tcf_bindcnt) - bind;
 	spin_lock_bh(&d->tcf_lock);
 	opt.action = d->tcf_action;
 	p = rcu_dereference_protected(d->skbmod_p,
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index e8f988e1c7e6..334a563e0bc1 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -806,7 +806,7 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
 		notify = !sch->q.qlen && !WARN_ON_ONCE(!n &&
 						       !qdisc_is_offloaded);
 		/* TODO: perform the search on a per txq basis */
-		sch = qdisc_lookup(qdisc_dev(sch), TC_H_MAJ(parentid));
+		sch = qdisc_lookup_rcu(qdisc_dev(sch), TC_H_MAJ(parentid));
 		if (sch == NULL) {
 			WARN_ON_ONCE(parentid != TC_H_ROOT);
 			break;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index bdb5153f3788..348abadbc2d8 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2062,10 +2062,10 @@ int tls_sw_recvmsg(struct sock *sk,
 	if (unlikely(flags & MSG_ERRQUEUE))
 		return sock_recv_errqueue(sk, msg, len, SOL_IP, IP_RECVERR);
 
-	psock = sk_psock_get(sk);
 	err = tls_rx_reader_lock(sk, ctx, flags & MSG_DONTWAIT);
 	if (err < 0)
 		return err;
+	psock = sk_psock_get(sk);
 	bpf_strp_enabled = sk_psock_strp_enabled(psock);
 
 	/* If crypto failed the connection is broken */
@@ -2238,12 +2238,15 @@ int tls_sw_recvmsg(struct sock *sk,
 		}
 
 		/* Drain records from the rx_list & copy if required */
-		if (is_peek || is_kvec)
+		if (is_peek)
 			err = process_rx_list(ctx, msg, &control, copied + peeked,
 					      decrypted - peeked, is_peek, NULL);
 		else
 			err = process_rx_list(ctx, msg, &control, 0,
 					      async_copy_bytes, is_peek, NULL);
+
+		/* we could have copied less than we wanted, and possibly nothing */
+		decrypted += max(err, 0) - async_copy_bytes;
 	}
 
 	copied += decrypted;
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 16575ea83659..5434c9f11d28 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -109,7 +109,6 @@ virtio_transport_send_pkt_work(struct work_struct *work)
 		if (!skb)
 			break;
 
-		virtio_transport_deliver_tap_pkt(skb);
 		reply = virtio_vsock_skb_reply(skb);
 
 		sg_init_one(&hdr, virtio_vsock_hdr(skb), sizeof(*virtio_vsock_hdr(skb)));
@@ -128,6 +127,8 @@ virtio_transport_send_pkt_work(struct work_struct *work)
 			break;
 		}
 
+		virtio_transport_deliver_tap_pkt(skb);
+
 		if (reply) {
 			struct virtqueue *rx_vq = vsock->vqs[VSOCK_VQ_RX];
 			int val;
diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index 4de98b7bbea9..c2da6ed32104 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -396,8 +396,8 @@ class PrinterRST(Printer):
             version = version.stdout.decode().rstrip()
         except:
             try:
-                version = subprocess.run(['make', 'kernelversion'], cwd=linuxRoot,
-                                         capture_output=True, check=True)
+                version = subprocess.run(['make', '-s', '--no-print-directory', 'kernelversion'],
+                                         cwd=linuxRoot, capture_output=True, check=True)
                 version = version.stdout.decode().rstrip()
             except:
                 return 'Linux'
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index fb12034d464e..e8cf38dc8a5e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9905,7 +9905,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x10ec, 0x1252, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0x10ec, 0x1254, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0x10ec, 0x12cc, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
-	SND_PCI_QUIRK(0x10f7, 0x8338, "Panasonic CF-SZ6", ALC269_FIXUP_HEADSET_MODE),
+	SND_PCI_QUIRK(0x10f7, 0x8338, "Panasonic CF-SZ6", ALC269_FIXUP_ASPIRE_HEADSET_MIC),
 	SND_PCI_QUIRK(0x144d, 0xc109, "Samsung Ativ book 9 (NP900X3G)", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x144d, 0xc169, "Samsung Notebook 9 Pen (NP930SBE-K01US)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x144d, 0xc176, "Samsung Notebook 9 Pro (NP930MBE-K04US)", ALC298_FIXUP_SAMSUNG_AMP),
@@ -10121,6 +10121,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d05, 0x1147, "TongFang GMxTGxx", ALC269_FIXUP_NO_SHUTUP),
 	SND_PCI_QUIRK(0x1d05, 0x115c, "TongFang GMxTGxx", ALC269_FIXUP_NO_SHUTUP),
 	SND_PCI_QUIRK(0x1d05, 0x121b, "TongFang GMxAGxx", ALC269_FIXUP_NO_SHUTUP),
+	SND_PCI_QUIRK(0x1d05, 0x1387, "TongFang GMxIXxx", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1602, "RedmiBook", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1701, "XiaomiNotebook Pro", ALC298_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1d72, 0x1901, "RedmiBook 14", ALC256_FIXUP_ASUS_HEADSET_MIC),
diff --git a/sound/soc/codecs/rt5682-sdw.c b/sound/soc/codecs/rt5682-sdw.c
index 868a61c8b060..7685011a0935 100644
--- a/sound/soc/codecs/rt5682-sdw.c
+++ b/sound/soc/codecs/rt5682-sdw.c
@@ -787,12 +787,12 @@ static int __maybe_unused rt5682_dev_resume(struct device *dev)
 		return 0;
 
 	if (!slave->unattach_request) {
+		mutex_lock(&rt5682->disable_irq_lock);
 		if (rt5682->disable_irq == true) {
-			mutex_lock(&rt5682->disable_irq_lock);
 			sdw_write_no_pm(slave, SDW_SCP_INTMASK1, SDW_SCP_INT1_IMPL_DEF);
 			rt5682->disable_irq = false;
-			mutex_unlock(&rt5682->disable_irq_lock);
 		}
+		mutex_unlock(&rt5682->disable_irq_lock);
 		goto regmap_sync;
 	}
 
diff --git a/sound/soc/codecs/rt711-sdca-sdw.c b/sound/soc/codecs/rt711-sdca-sdw.c
index 487d3010ddc1..931dbc68548e 100644
--- a/sound/soc/codecs/rt711-sdca-sdw.c
+++ b/sound/soc/codecs/rt711-sdca-sdw.c
@@ -443,13 +443,13 @@ static int __maybe_unused rt711_sdca_dev_resume(struct device *dev)
 		return 0;
 
 	if (!slave->unattach_request) {
+		mutex_lock(&rt711->disable_irq_lock);
 		if (rt711->disable_irq == true) {
-			mutex_lock(&rt711->disable_irq_lock);
 			sdw_write_no_pm(slave, SDW_SCP_SDCA_INTMASK1, SDW_SCP_SDCA_INTMASK_SDCA_0);
 			sdw_write_no_pm(slave, SDW_SCP_SDCA_INTMASK2, SDW_SCP_SDCA_INTMASK_SDCA_8);
 			rt711->disable_irq = false;
-			mutex_unlock(&rt711->disable_irq_lock);
 		}
+		mutex_unlock(&rt711->disable_irq_lock);
 		goto regmap_sync;
 	}
 
diff --git a/sound/soc/codecs/rt711-sdw.c b/sound/soc/codecs/rt711-sdw.c
index 9545b8a7eb19..af7a0ab5669f 100644
--- a/sound/soc/codecs/rt711-sdw.c
+++ b/sound/soc/codecs/rt711-sdw.c
@@ -542,12 +542,12 @@ static int __maybe_unused rt711_dev_resume(struct device *dev)
 		return 0;
 
 	if (!slave->unattach_request) {
+		mutex_lock(&rt711->disable_irq_lock);
 		if (rt711->disable_irq == true) {
-			mutex_lock(&rt711->disable_irq_lock);
 			sdw_write_no_pm(slave, SDW_SCP_INTMASK1, SDW_SCP_INT1_IMPL_DEF);
 			rt711->disable_irq = false;
-			mutex_unlock(&rt711->disable_irq_lock);
 		}
+		mutex_unlock(&rt711->disable_irq_lock);
 		goto regmap_sync;
 	}
 
diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 2d25748ca706..b27e89ff6a16 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -263,7 +263,7 @@ int snd_soc_get_volsw(struct snd_kcontrol *kcontrol,
 	int max = mc->max;
 	int min = mc->min;
 	int sign_bit = mc->sign_bit;
-	unsigned int mask = (1 << fls(max)) - 1;
+	unsigned int mask = (1ULL << fls(max)) - 1;
 	unsigned int invert = mc->invert;
 	int val;
 	int ret;
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 18c9b00ca058..dacf4cf2246d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -439,6 +439,7 @@ do_transfer()
 	local stat_cookierx_last=$(get_mib_counter "${listener_ns}" "TcpExtSyncookiesRecv")
 	local stat_csum_err_s=$(get_mib_counter "${listener_ns}" "MPTcpExtDataCsumErr")
 	local stat_csum_err_c=$(get_mib_counter "${connector_ns}" "MPTcpExtDataCsumErr")
+	local stat_tcpfb_last_l=$(get_mib_counter "${listener_ns}" "MPTcpExtMPCapableFallbackACK")
 
 	timeout ${timeout_test} \
 		ip netns exec ${listener_ns} \
@@ -504,6 +505,7 @@ do_transfer()
 	local stat_cookietx_now=$(get_mib_counter "${listener_ns}" "TcpExtSyncookiesSent")
 	local stat_cookierx_now=$(get_mib_counter "${listener_ns}" "TcpExtSyncookiesRecv")
 	local stat_ooo_now=$(get_mib_counter "${listener_ns}" "TcpExtTCPOFOQueue")
+	local stat_tcpfb_now_l=$(get_mib_counter "${listener_ns}" "MPTcpExtMPCapableFallbackACK")
 
 	expect_synrx=$((stat_synrx_last_l))
 	expect_ackrx=$((stat_ackrx_last_l))
@@ -548,6 +550,11 @@ do_transfer()
 		fi
 	fi
 
+	if [ ${stat_ooo_now} -eq 0 ] && [ ${stat_tcpfb_last_l} -ne ${stat_tcpfb_now_l} ]; then
+		printf "[ FAIL ]\nunexpected fallback to TCP"
+		rets=1
+	fi
+
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
 		printf "[ OK ]"
 	fi
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a20dca9d26d6..635a1624b47d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -725,7 +725,7 @@ pm_nl_check_endpoint()
 			[ -n "$_flags" ]; flags="flags $_flags"
 			shift
 		elif [ $1 = "dev" ]; then
-			[ -n "$2" ]; dev="dev $1"
+			[ -n "$2" ]; dev="dev $2"
 			shift
 		elif [ $1 = "id" ]; then
 			_id=$2
@@ -1771,7 +1771,10 @@ chk_rm_nr()
 		# in case of simult flush, the subflow removal count on each side is
 		# unreliable
 		count=$((count + cnt))
-		[ "$count" != "$rm_subflow_nr" ] && suffix="$count in [$rm_subflow_nr:$((rm_subflow_nr*2))]"
+		if [ "$count" != "$rm_subflow_nr" ]; then
+			suffix="$count in [$rm_subflow_nr:$((rm_subflow_nr*2))]"
+			extra_msg="$extra_msg simult"
+		fi
 		if [ $count -ge "$rm_subflow_nr" ] && \
 		   [ "$count" -le "$((rm_subflow_nr *2 ))" ]; then
 			echo -n "[ ok ] $suffix"
diff --git a/tools/testing/selftests/net/reuseaddr_conflict.c b/tools/testing/selftests/net/reuseaddr_conflict.c
index 7c5b12664b03..bfb07dc49518 100644
--- a/tools/testing/selftests/net/reuseaddr_conflict.c
+++ b/tools/testing/selftests/net/reuseaddr_conflict.c
@@ -109,6 +109,6 @@ int main(void)
 	fd1 = open_port(0, 1);
 	if (fd1 >= 0)
 		error(1, 0, "Was allowed to create an ipv4 reuseport on an already bound non-reuseport socket with no ipv6");
-	fprintf(stderr, "Success");
+	fprintf(stderr, "Success\n");
 	return 0;
 }
diff --git a/tools/testing/selftests/net/udpgro_fwd.sh b/tools/testing/selftests/net/udpgro_fwd.sh
index 9690a5d7ffd7..9e9b4644e0ea 100755
--- a/tools/testing/selftests/net/udpgro_fwd.sh
+++ b/tools/testing/selftests/net/udpgro_fwd.sh
@@ -239,7 +239,7 @@ for family in 4 6; do
 
 	create_vxlan_pair
 	ip netns exec $NS_DST ethtool -K veth$DST rx-gro-list on
-	run_test "GRO frag list over UDP tunnel" $OL_NET$DST 1 1
+	run_test "GRO frag list over UDP tunnel" $OL_NET$DST 10 10
 	cleanup
 
 	# use NAT to circumvent GRO FWD check
@@ -252,13 +252,7 @@ for family in 4 6; do
 	# load arp cache before running the test to reduce the amount of
 	# stray traffic on top of the UDP tunnel
 	ip netns exec $NS_SRC $PING -q -c 1 $OL_NET$DST_NAT >/dev/null
-	run_test "GRO fwd over UDP tunnel" $OL_NET$DST_NAT 1 1 $OL_NET$DST
-	cleanup
-
-	create_vxlan_pair
-	run_bench "UDP tunnel fwd perf" $OL_NET$DST
-	ip netns exec $NS_DST ethtool -K veth$DST rx-udp-gro-forwarding on
-	run_bench "UDP tunnel GRO fwd perf" $OL_NET$DST
+	run_test "GRO fwd over UDP tunnel" $OL_NET$DST_NAT 10 10 $OL_NET$DST
 	cleanup
 done
 

