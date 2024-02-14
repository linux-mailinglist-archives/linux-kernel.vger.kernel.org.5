Return-Path: <linux-kernel+bounces-65144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E710F85488A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F9CD281B27
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A051BDC9;
	Wed, 14 Feb 2024 11:37:17 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E511BC4F;
	Wed, 14 Feb 2024 11:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910636; cv=none; b=LyBxqH0u8wsdVDIuQye0gEdkHJM4+2GiRGwhHr3H9/tt478OL295cEb+8nvEQuVRCu9g9q3vXPqyGBiT+BKpssnNUwNMIcIcakXXNnXCyDQRprIn6QRvo3qHUQEskLGkd7UulEYM1ReQ079OQ7qEMJTSwHMyyD1TRNaAay6BueU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910636; c=relaxed/simple;
	bh=3KIpfTvqNgYyjl5w8d86enZgWo8Yqf3eaTAdxYPmWyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qHBskDOHw529uH7CDI2cmUovzcNC+poIcAtXYpp7W2Y6miDR8eV2uoyiYKrDyiwkVG9/pgAeDvYRfd3plO3rliP06xDqTswQWTMq73jVNeHgWt6sFqHFUe+Y5IdlM00XTnU70Hj59HRltRsiymLuZ9enJ6VnnoBW55e4vCMAtTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4TZbPc5qBjz9yMLF;
	Wed, 14 Feb 2024 19:21:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id F3FBE1404FC;
	Wed, 14 Feb 2024 19:37:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.45.156.69])
	by APP1 (Coremail) with SMTP id LxC2BwAHshp7pcxlDJx9Ag--.51624S8;
	Wed, 14 Feb 2024 12:37:10 +0100 (CET)
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Xin Li <xin3.li@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kees Cook <keescook@chromium.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Pengfei Xu <pengfei.xu@intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ze Gao <zegao2021@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Brian Gerst <brgerst@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <jroedel@suse.de>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Tina Zhang <tina.zhang@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
	petr@tesarici.cz,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: [PATCH v1 6/8] sbm: x86: switch to sandbox mode pages in arch_sbm_exec()
Date: Wed, 14 Feb 2024 12:35:14 +0100
Message-Id: <20240214113516.2307-7-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214113516.2307-1-petrtesarik@huaweicloud.com>
References: <20240214113516.2307-1-petrtesarik@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAHshp7pcxlDJx9Ag--.51624S8
X-Coremail-Antispam: 1UD129KBjvAXoW3uw4kWFy7Wr47tr1fGFWDXFb_yoW8Gr15Ko
	WagF43Kr4xJr9I9a4kAr18Ka4FqFyvqw4kX3WYyw4YvF9xJan5Xry8Gan0y34ruF1Ygwsx
	Z3y3WFy7Kan2qwnxn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOT7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
	Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
	84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j
	6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7V
	C0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j
	6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x0262
	8vn2kIc2xKxwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
	6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
	C2zVAF1VAY17CE14v26rWY6r4UJwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j
	6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rV
	WUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWx
	JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjyCJPUUUUU==
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

Change CR3 to the sandbox page tables while running in sandbox mode. Since
interrupts are enabled, but interrupt handlers cannot run in sandbox mode,
modify the interrupt entry and exit paths to leave/reenter sandbox mode as
needed. For now, these modifications are not implemented for Xen PV, so add
a conflict with CONFIG_XEN_PV.

For interrupt entry, save the kernel-mode CR3 value in a dynamically
allocated state page and map this page to a fixed virtual address in
sandbox mode, so it can be found without relying on any CPU state other
than paging. In kernel-mode, this address maps to a zero-filled page in the
kernel BSS section.

Special care is needed to flush the TLB when entering and leaving sandbox
mode, because it changes the mapping of kernel addresses. Kernel page table
entries are marked as global and thus normally not flushed when a new value
is written to CR3. To flush them, turn off the PGE bit in CR4 when entering
sandbox mode (and restore CR4.PGE when leaving sandbox mode). Albeit not
very efficient, this method is simple and works.

Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
---
 arch/x86/Kconfig              |   2 +-
 arch/x86/entry/entry_64.S     | 136 ++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/sbm.h    |   4 +
 arch/x86/kernel/asm-offsets.c |   5 ++
 arch/x86/kernel/sbm/call_64.S |  48 ++++++++++--
 arch/x86/kernel/sbm/core.c    |  23 +++++-
 6 files changed, 209 insertions(+), 9 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 090d46c7ee7c..e6ee1d3a273b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -188,7 +188,7 @@ config X86
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if MMU && COMPAT
 	select HAVE_ARCH_COMPAT_MMAP_BASES	if MMU && COMPAT
 	select HAVE_ARCH_PREL32_RELOCATIONS
-	select HAVE_ARCH_SBM			if X86_64
+	select HAVE_ARCH_SBM			if X86_64 && !XEN_PV
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_STACKLEAK
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index c40f89ab1b4c..e1364115408a 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -623,6 +623,23 @@ SYM_INNER_LABEL(restore_regs_and_return_to_kernel, SYM_L_GLOBAL)
 	ud2
 1:
 #endif
+
+#ifdef CONFIG_SANDBOX_MODE
+	/* Restore CR3 if the exception came from sandbox mode. */
+	cmpw	$__SBM_CS, CS(%rsp)
+	jne	.Lreturn_cr3_done
+
+	movq	PER_CPU_VAR(pcpu_hot + X86_current_task), %rcx
+	movq	TASK_sbm_state(%rcx), %rcx
+	movq	SBM_sbm_cr3(%rcx), %rcx
+	movq	%cr4, %rax
+	andb	$~X86_CR4_PGE, %al
+	movq	%rax, %cr4
+	movq	%rcx, %cr3
+	orb	$3, CS(%rsp)
+#endif
+
+.Lreturn_cr3_done:
 	POP_REGS
 	addq	$8, %rsp	/* skip regs->orig_ax */
 	/*
@@ -867,6 +884,27 @@ SYM_CODE_START(paranoid_entry)
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
 
+#ifdef CONFIG_SANDBOX_MODE
+	/*
+	 * If sandbox mode was active, adjust the saved CS, switch to
+	 * kernel CR3 and skip non-sandbox CR3 handling. Save old CR3
+	 * in %r14 even if not using PAGE_TABLE_ISOLATION. This is
+	 * needed during transition to sandbox mode, when CR3 is already
+	 * set, but CS is still __KERNEL_CS.
+	 */
+	movq	x86_sbm_state + SBM_kernel_cr3, %rcx
+	jrcxz	.Lparanoid_switch_to_kernel
+
+	movq	%cr3, %r14
+	andb	$~3, CS+8(%rsp)
+	movq	%cr4, %rax
+	orb	$X86_CR4_PGE, %al
+	movq	%rax, %cr4
+	movq	%rcx, %cr3
+	jmp	.Lparanoid_gsbase
+#endif
+
+.Lparanoid_switch_to_kernel:
 	/*
 	 * Always stash CR3 in %r14.  This value will be restored,
 	 * verbatim, at exit.  Needed if paranoid_entry interrupted
@@ -884,6 +922,7 @@ SYM_CODE_START(paranoid_entry)
 	 */
 	SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg=%rax save_reg=%r14
 
+.Lparanoid_gsbase:
 	/*
 	 * Handling GSBASE depends on the availability of FSGSBASE.
 	 *
@@ -967,6 +1006,22 @@ SYM_CODE_START_LOCAL(paranoid_exit)
 	 */
 	IBRS_EXIT save_reg=%r15
 
+#ifdef CONFIG_SANDBOX_MODE
+	/*
+	 * When returning to sandbox mode, the sandbox CR3 is restored in
+	 * restore_regs_and_return_to_kernel. When returning to kernel mode,
+	 * but sandbox mode is active, restore CR3 from %r14 here.
+	 */
+	cmpw	$__SBM_CS, CS(%rsp)
+	je	.Lparanoid_exit_fsgs
+	movq	PER_CPU_VAR(pcpu_hot + X86_current_task), %rax
+	cmpq	$0, TASK_sbm_state(%rax)
+	je	.Lparanoid_exit_no_sbm
+	movq	%r14, %cr3
+	jmp	.Lparanoid_exit_fsgs
+#endif
+
+.Lparanoid_exit_no_sbm:
 	/*
 	 * The order of operations is important. RESTORE_CR3 requires
 	 * kernel GSBASE.
@@ -977,6 +1032,7 @@ SYM_CODE_START_LOCAL(paranoid_exit)
 	 */
 	RESTORE_CR3	scratch_reg=%rax save_reg=%r14
 
+.Lparanoid_exit_fsgs:
 	/* Handle the three GSBASE cases */
 	ALTERNATIVE "jmp .Lparanoid_exit_checkgs", "", X86_FEATURE_FSGSBASE
 
@@ -1007,6 +1063,24 @@ SYM_CODE_START(error_entry)
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
 
+#ifdef CONFIG_SANDBOX_MODE
+	/*
+	 * If sandbox mode was active, adjust the saved CS,
+	 * unconditionally switch to kernel CR3 and continue
+	 * as if the interrupt was from kernel space.
+	 */
+	movq	x86_sbm_state + SBM_kernel_cr3, %rcx
+	jrcxz	.Lerror_swapgs
+
+	andb	$~3, CS+8(%rsp)
+	movq	%cr4, %rax
+	orb	$X86_CR4_PGE, %al
+	movq	%rax, %cr4
+	movq	%rcx, %cr3
+	jmp	.Lerror_entry_done_lfence
+#endif
+
+.Lerror_swapgs:
 	/*
 	 * We entered from user mode or we're pretending to have entered
 	 * from user mode due to an IRET fault.
@@ -1149,6 +1223,11 @@ SYM_CODE_START(asm_exc_nmi)
 	testb	$3, CS-RIP+8(%rsp)
 	jz	.Lnmi_from_kernel
 
+#ifdef CONFIG_SANDBOX_MODE
+	cmpq	$0, x86_sbm_state + SBM_kernel_cr3
+	jne	.Lnmi_from_sbm
+#endif
+
 	/*
 	 * NMI from user mode.  We need to run on the thread stack, but we
 	 * can't go through the normal entry paths: NMIs are masked, and
@@ -1194,6 +1273,47 @@ SYM_CODE_START(asm_exc_nmi)
 	 */
 	jmp	swapgs_restore_regs_and_return_to_usermode
 
+#ifdef CONFIG_SANDBOX_MODE
+.Lnmi_from_sbm:
+	/*
+	 * If NMI from sandbox mode, this cannot be a nested NMI. Adjust
+	 * saved CS, load kernel CR3 and continue on the sandbox exception
+	 * stack. The code is similar to NMI from user mode.
+	 */
+	andb	$~3, CS-RIP+8(%rsp)
+	movq	%cr4, %rdx
+	orb	$X86_CR4_PGE, %dl
+	movq	%rdx, %cr4
+	movq	x86_sbm_state + SBM_kernel_cr3, %rdx
+	movq	%rdx, %cr3
+
+	movq	PER_CPU_VAR(pcpu_hot + X86_current_task), %rdx
+	movq	TASK_sbm_state(%rdx), %rdx
+	movq	SBM_exc_stack(%rdx), %rdx
+	addq	$EXCEPTION_STKSZ, %rdx
+	xchgq	%rsp, %rdx
+	UNWIND_HINT_IRET_REGS base=%rdx offset=8
+	pushq	5*8(%rdx)	/* pt_regs->ss */
+	pushq	4*8(%rdx)	/* pt_regs->rsp */
+	pushq	3*8(%rdx)	/* pt_regs->flags */
+	pushq	2*8(%rdx)	/* pt_regs->cs */
+	pushq	1*8(%rdx)	/* pt_regs->rip */
+	UNWIND_HINT_IRET_REGS
+	pushq   $-1		/* pt_regs->orig_ax */
+	PUSH_AND_CLEAR_REGS rdx=(%rdx)
+	ENCODE_FRAME_POINTER
+
+	FENCE_SWAPGS_KERNEL_ENTRY
+	movq	%rsp, %rdi
+	call	exc_nmi
+
+	/*
+	 * Take the kernel return path. This will take care of restoring
+	 * CR3 and return CS.
+	 */
+	jmp	restore_regs_and_return_to_kernel
+#endif
+
 .Lnmi_from_kernel:
 	/*
 	 * Here's what our stack frame will look like:
@@ -1404,6 +1524,22 @@ end_repeat_nmi:
 	/* Always restore stashed SPEC_CTRL value (see paranoid_entry) */
 	IBRS_EXIT save_reg=%r15
 
+#ifdef CONFIG_SANDBOX_MODE
+	/*
+	 * Always restore saved CR3 when sandbox mode is active. This is
+	 * needed if an NMI occurs during transition to sandbox mode.
+	 */
+	movq	PER_CPU_VAR(pcpu_hot + X86_current_task), %rcx
+	movq	TASK_sbm_state(%rcx), %rcx
+	jrcxz	nmi_no_sbm
+
+	movq	%cr4, %rax
+	andb	$~X86_CR4_PGE, %al
+	movq	%rax, %cr4
+	movq	%r14, %cr3
+#endif
+
+nmi_no_sbm:
 	/* Always restore stashed CR3 value (see paranoid_entry) */
 	RESTORE_CR3 scratch_reg=%r15 save_reg=%r14
 
diff --git a/arch/x86/include/asm/sbm.h b/arch/x86/include/asm/sbm.h
index 229b1ac3bbd4..e38dcf9a8017 100644
--- a/arch/x86/include/asm/sbm.h
+++ b/arch/x86/include/asm/sbm.h
@@ -24,6 +24,8 @@ struct pt_regs;
  * @stack:       Sandbox mode stack.
  * @exc_stack:   Exception and IRQ stack.
  * @return_sp:   Stack pointer for returning to kernel mode.
+ * @kernel_cr3:  Kernel mode CR3 value.
+ * @sbm_cr3:     Sandbox mode CR3 value.
  *
  * One instance of this union is allocated for each sandbox and stored as SBM
  * instance private data.
@@ -34,6 +36,8 @@ struct x86_sbm_state {
 	unsigned long stack;
 	unsigned long exc_stack;
 	unsigned long return_sp;
+	unsigned long kernel_cr3;
+	unsigned long sbm_cr3;
 };
 
 /**
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 44d4f0a0cb19..cc2751822532 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -17,6 +17,7 @@
 #include <asm/thread_info.h>
 #include <asm/sigframe.h>
 #include <asm/bootparam.h>
+#include <asm/sbm.h>
 #include <asm/suspend.h>
 #include <asm/tlbflush.h>
 #include <asm/tdx.h>
@@ -123,6 +124,10 @@ static void __used common(void)
 
 #if defined(CONFIG_HAVE_ARCH_SBM) && defined(CONFIG_SANDBOX_MODE)
 	COMMENT("SandBox Mode");
+	OFFSET(TASK_sbm_state, task_struct, thread_info.sbm_state);
+	OFFSET(SBM_exc_stack, x86_sbm_state, exc_stack);
 	OFFSET(SBM_return_sp, x86_sbm_state, return_sp);
+	OFFSET(SBM_kernel_cr3, x86_sbm_state, kernel_cr3);
+	OFFSET(SBM_sbm_cr3, x86_sbm_state, sbm_cr3);
 #endif
 }
diff --git a/arch/x86/kernel/sbm/call_64.S b/arch/x86/kernel/sbm/call_64.S
index 6a615b4f6047..8b2b524c5b46 100644
--- a/arch/x86/kernel/sbm/call_64.S
+++ b/arch/x86/kernel/sbm/call_64.S
@@ -10,6 +10,8 @@
 #include <linux/linkage.h>
 #include <asm/nospec-branch.h>
 #include <asm/percpu.h>
+#include <asm/processor-flags.h>
+#include <asm/segment.h>
 
 .code64
 .section .entry.text, "ax"
@@ -20,6 +22,7 @@
  * rsi  .. func
  * rdx  .. args
  * rcx  .. top of sandbox stack
+ * r8   .. top of exception stack
  */
 SYM_FUNC_START(x86_sbm_exec)
 	/* save all callee-saved registers */
@@ -29,6 +32,7 @@ SYM_FUNC_START(x86_sbm_exec)
 	push	%r13
 	push	%r14
 	push	%r15
+	UNWIND_HINT_SAVE
 
 	/* to be used by sandbox abort */
 	mov	%rsp, SBM_return_sp(%rdi)
@@ -38,18 +42,50 @@ SYM_FUNC_START(x86_sbm_exec)
 	 * 1. Store the old stack pointer at the top of the sandbox stack,
 	 *    where various unwinders can find it and link back to the
 	 *    kernel stack.
+	 * 2. Put a return address at the top of the sandbox stack. Although
+	 *    the target code is not executable in sandbox mode, the page
+	 *    fault handler can check the fault address to know that the
+	 *    target function returned.
 	 */
-	sub	$8, %rcx
-	mov	%rsp, (%rcx)
-	mov	%rcx, %rsp
+	sub	$8 * 2, %rcx
+	mov	%rsp, 8(%rcx)
+	movq	$x86_sbm_return, (%rcx)
 
-	mov	%rdx, %rdi	/* args */
-	CALL_NOSPEC rsi
+	/*
+	 * Move to the sandbox exception stack.
+	 * This stack is mapped as writable supervisor pages both in kernel
+	 * mode and in sandbox mode, so it survives a CR3 change.
+	 */
+	sub	$8, %r8
+	mov	%rsp, (%r8)
+	mov	%r8, %rsp
+
+	/* set up the IRET frame */
+	pushq	$__USER_DS
+	push	%rcx
+	pushfq
+	pushq	$__USER_CS
+	push	%rsi
 
-	pop	%rsp
+	/*
+	 * Switch to sandbox address space. Interrupt handlers cannot cope
+	 * with sandbox CR3 in kernel mode. Disable interrupts before setting
+	 * CR4, because if this task gets preempted, global pages would stay
+	 * disabled, which is really bad for performance.
+	 * The NMI handler takes extra care to restore CR3 and CR4.
+	 */
+	mov	SBM_sbm_cr3(%rdi), %r11
+	mov	%cr4, %rax
+	and	$~X86_CR4_PGE, %al
+	mov	%rdx, %rdi	/* args */
+	cli
+	mov	%rax, %cr4
+	mov	%r11, %cr3
+	iretq
 
 SYM_INNER_LABEL(x86_sbm_return, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR	// IRET target via x86_sbm_fault()
+	UNWIND_HINT_RESTORE
 
 	/* restore callee-saved registers and return */
 	pop	%r15
diff --git a/arch/x86/kernel/sbm/core.c b/arch/x86/kernel/sbm/core.c
index d4c378847e93..0ea193550a83 100644
--- a/arch/x86/kernel/sbm/core.c
+++ b/arch/x86/kernel/sbm/core.c
@@ -24,9 +24,15 @@
 #define PGD_ORDER	get_order(sizeof(pgd_t) * PTRS_PER_PGD)
 
 asmlinkage int x86_sbm_exec(struct x86_sbm_state *state, sbm_func func,
-			    void *args, unsigned long sbm_tos);
+			    void *args, unsigned long sbm_tos,
+			    unsigned long exc_tos);
 extern char x86_sbm_return[];
 
+union {
+	struct x86_sbm_state state;
+	char page[PAGE_SIZE];
+} x86_sbm_state __page_aligned_bss;
+
 static inline phys_addr_t page_to_ptval(struct page *page)
 {
 	return PFN_PHYS(page_to_pfn(page)) | _PAGE_TABLE;
@@ -279,6 +285,12 @@ int arch_sbm_init(struct sbm *sbm)
 	if (err)
 		return err;
 
+	BUILD_BUG_ON(sizeof(x86_sbm_state) != PAGE_SIZE);
+	err = map_page(state, (unsigned long)&x86_sbm_state,
+		       PHYS_PFN(__pa(state)), PAGE_KERNEL);
+	if (err < 0)
+		return err;
+
 	return 0;
 }
 
@@ -348,11 +360,18 @@ int arch_sbm_exec(struct sbm *sbm, sbm_func func, void *args)
 
 	state->sbm = sbm;
 
+	/* save current (kernel) CR3 for interrupt entry path */
+	state->kernel_cr3 = __read_cr3();
+
+	/* CR3 while running in sandbox */
+	state->sbm_cr3 = __sme_pa(state->pgd);
+
 	/* let interrupt handlers use the sandbox state page */
 	barrier();
 	WRITE_ONCE(current_thread_info()->sbm_state, state);
 
-	err = x86_sbm_exec(state, func, args, state->stack + THREAD_SIZE);
+	err = x86_sbm_exec(state, func, args, state->stack + THREAD_SIZE,
+			   state->exc_stack + EXCEPTION_STKSZ);
 
 	/* NULLify the state page pointer before it becomes stale */
 	WRITE_ONCE(current_thread_info()->sbm_state, NULL);
-- 
2.34.1


