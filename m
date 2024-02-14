Return-Path: <linux-kernel+bounces-65143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07679854888
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115721C22681
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413221AAC4;
	Wed, 14 Feb 2024 11:37:11 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB431AACE;
	Wed, 14 Feb 2024 11:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910630; cv=none; b=plMhWzxq3sYYcPCA8+3dJBmyDr4dZb+CLDIGv1KnQ/skUDjujokH9+o2/0rLEKkIan/Qsfa9Z2RtmyNpML6cDPnCSs/VTvYUSf452UHybc3KFq/X8Y5md+9HhuEnhIMrfGCDrka0FpIbioEgPFpw5gWzX61LisMWw3QfKoe+V4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910630; c=relaxed/simple;
	bh=a2vh6qq7VHsS7NIXK2cTE7729KXe3Z0csZimJkYwPdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gW16qYIr0U4wFn2yXViwS1+YlxsB8Yf8W3yaCCzeph21xP1HK/fwDhte/OBy8NjuInL3eB9l5nswJcxBm6cQLqnAmoq9ZJiKHiT1MHu8Qgqy7XfB5zc8xkFt2fIDNGPhAWMmdh0Zal9pbxLcrKRNP9UugLapWCadeliI/PKWFvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TZbPT2J9nz9ynSS;
	Wed, 14 Feb 2024 19:21:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id DB5521405A2;
	Wed, 14 Feb 2024 19:36:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.45.156.69])
	by APP1 (Coremail) with SMTP id LxC2BwAHshp7pcxlDJx9Ag--.51624S7;
	Wed, 14 Feb 2024 12:36:55 +0100 (CET)
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
Subject: [PATCH v1 5/8] sbm: x86: handle sandbox mode faults
Date: Wed, 14 Feb 2024 12:35:13 +0100
Message-Id: <20240214113516.2307-6-petrtesarik@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwAHshp7pcxlDJx9Ag--.51624S7
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw48KFW8Jr4DKFy5JFyrWFg_yoWDGryxpF
	9rAFn5GFZxWa4SvF9xAr4vvrW3Aws5Kw1YkF9rKry5Z3W2q345Xr4v9w1qqr4kZ395W3WY
	gFW5Zrn5uan8Jw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUml14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_
	Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x
	IIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_
	Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8c
	xan2IY04v7MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_
	Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r
	1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4U
	JbIYCTnIWIevJa73UjIFyTuYvjfUnzVbDUUUU
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

Provide a fault handler for sandbox mode. Set the sandbox mode instance
error code, abort the sandbox and return to the caller. To allow graceful
return from a fatal fault, save all callee-saved registers (including the
stack pointer) just before passing control to the target function.

Modify the handlers for #PF and #DF CPU exceptions to call this handler if
coming from sandbox mode. The check is based on the saved CS register,
which should be modified in the entry path to a value that is otherwise not
possible (__SBM_CS).

For the page fault handler, make sure that sandbox mode check is placed
before do_kern_addr_fault(). That function calls spurious_kernel_fault(),
which implements lazy TLB invalidation of kernel pages and it assumes that
the faulting instruction ran with kernel-mode page tables; it would produce
false positives for sandbox mode.

Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
---
 arch/x86/include/asm/ptrace.h  | 21 +++++++++++++++++++++
 arch/x86/include/asm/sbm.h     | 24 ++++++++++++++++++++++++
 arch/x86/include/asm/segment.h |  7 +++++++
 arch/x86/kernel/asm-offsets.c  |  5 +++++
 arch/x86/kernel/sbm/call_64.S  | 21 +++++++++++++++++++++
 arch/x86/kernel/sbm/core.c     | 26 ++++++++++++++++++++++++++
 arch/x86/kernel/traps.c        | 11 +++++++++++
 arch/x86/mm/fault.c            |  6 ++++++
 8 files changed, 121 insertions(+)

diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index f4db78b09c8f..f66f16f037b0 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -164,6 +164,27 @@ static inline bool user_64bit_mode(struct pt_regs *regs)
 #endif
 }
 
+/*
+ * sandbox_mode() - did a register set come from SandBox Mode?
+ * @regs:  register set
+ */
+static inline bool sandbox_mode(struct pt_regs *regs)
+{
+#ifdef CONFIG_X86_64
+#ifdef CONFIG_SANDBOX_MODE
+	/*
+	 * SandBox Mode always runs in 64-bit and it is not implemented
+	 * on paravirt systems, so this is the only possible value.
+	 */
+	return regs->cs == __SBM_CS;
+#else /* !CONFIG_SANDBOX_MODE */
+	return false;
+#endif
+#else /* !CONFIG_X86_64 */
+	return false;
+#endif
+}
+
 /*
  * Determine whether the register set came from any context that is running in
  * 64-bit mode.
diff --git a/arch/x86/include/asm/sbm.h b/arch/x86/include/asm/sbm.h
index ca4741b449e8..229b1ac3bbd4 100644
--- a/arch/x86/include/asm/sbm.h
+++ b/arch/x86/include/asm/sbm.h
@@ -11,23 +11,29 @@
 
 #include <asm/processor.h>
 
+struct pt_regs;
+
 #if defined(CONFIG_HAVE_ARCH_SBM) && defined(CONFIG_SANDBOX_MODE)
 
 #include <asm/pgtable_types.h>
 
 /**
  * struct x86_sbm_state - Run-time state of the environment.
+ * @sbm:         Link back to the SBM instance.
  * @pgd:         Sandbox mode page global directory.
  * @stack:       Sandbox mode stack.
  * @exc_stack:   Exception and IRQ stack.
+ * @return_sp:   Stack pointer for returning to kernel mode.
  *
  * One instance of this union is allocated for each sandbox and stored as SBM
  * instance private data.
  */
 struct x86_sbm_state {
+	struct sbm *sbm;
 	pgd_t *pgd;
 	unsigned long stack;
 	unsigned long exc_stack;
+	unsigned long return_sp;
 };
 
 /**
@@ -43,6 +49,18 @@ static inline unsigned long top_of_intr_stack(void)
 	return current_top_of_stack();
 }
 
+/**
+ * handle_sbm_fault() - Handle a CPU fault in sandbox mode.
+ * @regs:       Saved registers at fault.
+ * @error_code: CPU error code.
+ * @address:    Fault address (CR2 register).
+ *
+ * Handle a sandbox mode fault. The caller should use sandbox_mode() to
+ * check that @regs came from sandbox mode before calling this function.
+ */
+void handle_sbm_fault(struct pt_regs *regs, unsigned long error_code,
+		      unsigned long address);
+
 #else /* defined(CONFIG_HAVE_ARCH_SBM) && defined(CONFIG_SANDBOX_MODE) */
 
 static inline unsigned long top_of_intr_stack(void)
@@ -50,6 +68,12 @@ static inline unsigned long top_of_intr_stack(void)
 	return current_top_of_stack();
 }
 
+static inline void handle_sbm_fault(struct pt_regs *regs,
+				    unsigned long error_code,
+				    unsigned long address)
+{
+}
+
 #endif /* defined(CONFIG_HAVE_ARCH_SBM) && defined(CONFIG_SANDBOX_MODE) */
 
 #endif /* __ASM_SBM_H */
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 9d6411c65920..966831385d18 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -217,6 +217,13 @@
 #define __USER_CS			(GDT_ENTRY_DEFAULT_USER_CS*8 + 3)
 #define __CPUNODE_SEG			(GDT_ENTRY_CPUNODE*8 + 3)
 
+/*
+ * Sandbox runs with __USER_CS, but the interrupt entry code sets the RPL
+ * in the saved selector to zero to avoid user-mode processing (FPU, signal
+ * delivery, etc.). This is the resulting pseudo-CS.
+ */
+#define __SBM_CS			(GDT_ENTRY_DEFAULT_USER_CS*8)
+
 #endif
 
 #define IDT_ENTRIES			256
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 6913b372ccf7..44d4f0a0cb19 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -20,6 +20,7 @@
 #include <asm/suspend.h>
 #include <asm/tlbflush.h>
 #include <asm/tdx.h>
+#include <asm/sbm.h>
 
 #ifdef CONFIG_XEN
 #include <xen/interface/xen.h>
@@ -120,4 +121,8 @@ static void __used common(void)
 	OFFSET(ARIA_CTX_rounds, aria_ctx, rounds);
 #endif
 
+#if defined(CONFIG_HAVE_ARCH_SBM) && defined(CONFIG_SANDBOX_MODE)
+	COMMENT("SandBox Mode");
+	OFFSET(SBM_return_sp, x86_sbm_state, return_sp);
+#endif
 }
diff --git a/arch/x86/kernel/sbm/call_64.S b/arch/x86/kernel/sbm/call_64.S
index 1b232c8d15b7..6a615b4f6047 100644
--- a/arch/x86/kernel/sbm/call_64.S
+++ b/arch/x86/kernel/sbm/call_64.S
@@ -22,6 +22,17 @@
  * rcx  .. top of sandbox stack
  */
 SYM_FUNC_START(x86_sbm_exec)
+	/* save all callee-saved registers */
+	push	%rbp
+	push	%rbx
+	push	%r12
+	push	%r13
+	push	%r14
+	push	%r15
+
+	/* to be used by sandbox abort */
+	mov	%rsp, SBM_return_sp(%rdi)
+
 	/*
 	 * Set up the sandbox stack:
 	 * 1. Store the old stack pointer at the top of the sandbox stack,
@@ -37,5 +48,15 @@ SYM_FUNC_START(x86_sbm_exec)
 
 	pop	%rsp
 
+SYM_INNER_LABEL(x86_sbm_return, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR	// IRET target via x86_sbm_fault()
+
+	/* restore callee-saved registers and return */
+	pop	%r15
+	pop	%r14
+	pop	%r13
+	pop	%r12
+	pop	%rbx
+	pop	%rbp
 	RET
 SYM_FUNC_END(x86_sbm_exec)
diff --git a/arch/x86/kernel/sbm/core.c b/arch/x86/kernel/sbm/core.c
index 81f1b0093537..d4c378847e93 100644
--- a/arch/x86/kernel/sbm/core.c
+++ b/arch/x86/kernel/sbm/core.c
@@ -13,6 +13,8 @@
 #include <asm/page.h>
 #include <asm/sbm.h>
 #include <asm/sections.h>
+#include <asm/segment.h>
+#include <asm/trap_pf.h>
 #include <linux/cpumask.h>
 #include <linux/mm.h>
 #include <linux/sbm.h>
@@ -23,6 +25,7 @@
 
 asmlinkage int x86_sbm_exec(struct x86_sbm_state *state, sbm_func func,
 			    void *args, unsigned long sbm_tos);
+extern char x86_sbm_return[];
 
 static inline phys_addr_t page_to_ptval(struct page *page)
 {
@@ -343,6 +346,8 @@ int arch_sbm_exec(struct sbm *sbm, sbm_func func, void *args)
 	struct x86_sbm_state *state = sbm->private;
 	int err;
 
+	state->sbm = sbm;
+
 	/* let interrupt handlers use the sandbox state page */
 	barrier();
 	WRITE_ONCE(current_thread_info()->sbm_state, state);
@@ -354,3 +359,24 @@ int arch_sbm_exec(struct sbm *sbm, sbm_func func, void *args)
 
 	return err;
 }
+
+void handle_sbm_fault(struct pt_regs *regs, unsigned long error_code,
+		      unsigned long address)
+{
+	struct x86_sbm_state *state = current_thread_info()->sbm_state;
+
+	/*
+	 * Force -EFAULT unless the fault was due to a user-mode instruction
+	 * fetch from the designated return address.
+	 */
+	if (error_code != (X86_PF_PROT | X86_PF_USER | X86_PF_INSTR) ||
+	    address != (unsigned long)x86_sbm_return)
+		state->sbm->error = -EFAULT;
+
+	/* modify IRET frame to exit from sandbox */
+	regs->ip = (unsigned long)x86_sbm_return;
+	regs->cs = __KERNEL_CS;
+	regs->flags = X86_EFLAGS_IF;
+	regs->sp = state->return_sp;
+	regs->ss = __KERNEL_DS;
+}
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index b9c9c74314e7..8fc5b17b8fb4 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -416,6 +416,12 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
 
 	irqentry_nmi_enter(regs);
 	instrumentation_begin();
+
+	if (sandbox_mode(regs)) {
+		handle_sbm_fault(regs, error_code, 0);
+		return;
+	}
+
 	notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_DF, SIGSEGV);
 
 	tsk->thread.error_code = error_code;
@@ -675,6 +681,11 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 		goto exit;
 	}
 
+	if (sandbox_mode(regs)) {
+		handle_sbm_fault(regs, error_code, 0);
+		return;
+	}
+
 	if (gp_try_fixup_and_notify(regs, X86_TRAP_GP, error_code, desc, 0))
 		goto exit;
 
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 679b09cfe241..f223b258e53f 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -34,6 +34,7 @@
 #include <asm/kvm_para.h>		/* kvm_handle_async_pf		*/
 #include <asm/vdso.h>			/* fixup_vdso_exception()	*/
 #include <asm/irq_stack.h>
+#include <asm/sbm.h>
 
 #define CREATE_TRACE_POINTS
 #include <asm/trace/exceptions.h>
@@ -1500,6 +1501,11 @@ handle_page_fault(struct pt_regs *regs, unsigned long error_code,
 	if (unlikely(kmmio_fault(regs, address)))
 		return;
 
+	if (sandbox_mode(regs)) {
+		handle_sbm_fault(regs, error_code, address);
+		return;
+	}
+
 	/* Was the fault on kernel-controlled part of the address space? */
 	if (unlikely(fault_in_kernel_space(address))) {
 		do_kern_addr_fault(regs, error_code, address);
-- 
2.34.1


