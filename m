Return-Path: <linux-kernel+bounces-65146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3B385488F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322B01F21465
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B235B1BC5C;
	Wed, 14 Feb 2024 11:37:46 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD72C1BC31;
	Wed, 14 Feb 2024 11:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910666; cv=none; b=BUFovqR8c1NeIYQwTsXWB7UjSkSroyKMETMFUlCYmyn9SflD0eCYGW63e3sKG/CQISQS0z7IVCGGhH9lNjvpv6mXieBRh09KJ5JxJOqDVCC+3ed8NGN0jMHkj40P5odllbpa5iK1SawhKmzqRYmi/NZcNq2QzASb4KFbaTErXfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910666; c=relaxed/simple;
	bh=/uyNfbbAGyBoNGO8quoCKc4b5P7cnfMZAnnYhYkf9As=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eMbKBAH2Doy3r7ctZUGQHVJSZQIoXcHKAy149xNy8ItVLvk4dnRUCG3loYsYFCLAjBF2LwIoLPbtGeEjDVSZiEx2sSOeTcNXMx5AgSUV4QEJBsnqbyUkmzeVHE8fXDQ8YXh8eI1B+ChwvdowzbytftzYq6a7bGeBmBxCfwdsXoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4TZbQC00hnz9yMLR;
	Wed, 14 Feb 2024 19:22:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 2CCD3140427;
	Wed, 14 Feb 2024 19:37:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.45.156.69])
	by APP1 (Coremail) with SMTP id LxC2BwAHshp7pcxlDJx9Ag--.51624S10;
	Wed, 14 Feb 2024 12:37:40 +0100 (CET)
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
Subject: [PATCH v1 8/8] sbm: x86: lazy TLB flushing
Date: Wed, 14 Feb 2024 12:35:16 +0100
Message-Id: <20240214113516.2307-9-petrtesarik@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwAHshp7pcxlDJx9Ag--.51624S10
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw45Ar4fAFyrZr43XFW8WFg_yoW3Jry3pF
	n7Ga4kGFs7X34Syws7Xrs5AFn8Za1Dta15JasrKryfZa45Xw45Xr4jkw42qFWrZr95W3Wx
	KF4avFs5Cwn8Aa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_
	GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
	x0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
	JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2
	ka0xkIwI1lc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5
	JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr
	0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
	YxBIdaVFxhVjvjDU0xZFpf9x0JU3EfOUUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

Implement lazy TLB flushing in sandbox mode and keep CR4.PGE enabled.

For the transition from sandbox mode to kernel mode:

1. All user page translations (sandbox code and data) are flushed from the
   TLB, because their page protection bits do not include _PAGE_GLOBAL.

2. Any kernel page translations remain valid after the transition. The SBM
   state page is an exception; map it without _PAGE_GLOBAL.

For the transition from kernel mode to sandbox mode:

1. Kernel page translations become stale. However, any access by code
   running in sandbox mode (with CPL 3) causes a protection violation.
   Handle the spurious page faults from such accesses, lazily replacing
   entries in the TLB.

2. If the TLB contains any user page translations before the switch to
   sandbox mode, they are flushed, because their page protection bits do
   not include _PAGE_GLOBAL. This ensures that sandbox mode cannot access
   user mode pages.

Note that the TLB may keep kernel page translations for addresses which are
never accessed by sandbox mode. They remain valid after returning to kernel
mode.

Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
---
 arch/x86/entry/entry_64.S     |  17 +-----
 arch/x86/kernel/sbm/call_64.S |   5 +-
 arch/x86/kernel/sbm/core.c    | 100 +++++++++++++++++++++++++++++++++-
 3 files changed, 102 insertions(+), 20 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index e1364115408a..4ba3eea38102 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -632,10 +632,8 @@ SYM_INNER_LABEL(restore_regs_and_return_to_kernel, SYM_L_GLOBAL)
 	movq	PER_CPU_VAR(pcpu_hot + X86_current_task), %rcx
 	movq	TASK_sbm_state(%rcx), %rcx
 	movq	SBM_sbm_cr3(%rcx), %rcx
-	movq	%cr4, %rax
-	andb	$~X86_CR4_PGE, %al
-	movq	%rax, %cr4
 	movq	%rcx, %cr3
+	invlpg	x86_sbm_state
 	orb	$3, CS(%rsp)
 #endif
 
@@ -897,9 +895,6 @@ SYM_CODE_START(paranoid_entry)
 
 	movq	%cr3, %r14
 	andb	$~3, CS+8(%rsp)
-	movq	%cr4, %rax
-	orb	$X86_CR4_PGE, %al
-	movq	%rax, %cr4
 	movq	%rcx, %cr3
 	jmp	.Lparanoid_gsbase
 #endif
@@ -1073,9 +1068,6 @@ SYM_CODE_START(error_entry)
 	jrcxz	.Lerror_swapgs
 
 	andb	$~3, CS+8(%rsp)
-	movq	%cr4, %rax
-	orb	$X86_CR4_PGE, %al
-	movq	%rax, %cr4
 	movq	%rcx, %cr3
 	jmp	.Lerror_entry_done_lfence
 #endif
@@ -1281,9 +1273,6 @@ SYM_CODE_START(asm_exc_nmi)
 	 * stack. The code is similar to NMI from user mode.
 	 */
 	andb	$~3, CS-RIP+8(%rsp)
-	movq	%cr4, %rdx
-	orb	$X86_CR4_PGE, %dl
-	movq	%rdx, %cr4
 	movq	x86_sbm_state + SBM_kernel_cr3, %rdx
 	movq	%rdx, %cr3
 
@@ -1533,10 +1522,8 @@ end_repeat_nmi:
 	movq	TASK_sbm_state(%rcx), %rcx
 	jrcxz	nmi_no_sbm
 
-	movq	%cr4, %rax
-	andb	$~X86_CR4_PGE, %al
-	movq	%rax, %cr4
 	movq	%r14, %cr3
+	invlpg	x86_sbm_state
 #endif
 
 nmi_no_sbm:
diff --git a/arch/x86/kernel/sbm/call_64.S b/arch/x86/kernel/sbm/call_64.S
index 8b2b524c5b46..21edce5666bc 100644
--- a/arch/x86/kernel/sbm/call_64.S
+++ b/arch/x86/kernel/sbm/call_64.S
@@ -10,7 +10,6 @@
 #include <linux/linkage.h>
 #include <asm/nospec-branch.h>
 #include <asm/percpu.h>
-#include <asm/processor-flags.h>
 #include <asm/segment.h>
 
 .code64
@@ -75,12 +74,10 @@ SYM_FUNC_START(x86_sbm_exec)
 	 * The NMI handler takes extra care to restore CR3 and CR4.
 	 */
 	mov	SBM_sbm_cr3(%rdi), %r11
-	mov	%cr4, %rax
-	and	$~X86_CR4_PGE, %al
 	mov	%rdx, %rdi	/* args */
 	cli
-	mov	%rax, %cr4
 	mov	%r11, %cr3
+	invlpg	x86_sbm_state
 	iretq
 
 SYM_INNER_LABEL(x86_sbm_return, SYM_L_GLOBAL)
diff --git a/arch/x86/kernel/sbm/core.c b/arch/x86/kernel/sbm/core.c
index 0ea193550a83..296f1fde3c22 100644
--- a/arch/x86/kernel/sbm/core.c
+++ b/arch/x86/kernel/sbm/core.c
@@ -33,6 +33,11 @@ union {
 	char page[PAGE_SIZE];
 } x86_sbm_state __page_aligned_bss;
 
+static inline pgprot_t pgprot_nonglobal(pgprot_t prot)
+{
+	return __pgprot(pgprot_val(prot) & ~_PAGE_GLOBAL);
+}
+
 static inline phys_addr_t page_to_ptval(struct page *page)
 {
 	return PFN_PHYS(page_to_pfn(page)) | _PAGE_TABLE;
@@ -287,7 +292,7 @@ int arch_sbm_init(struct sbm *sbm)
 
 	BUILD_BUG_ON(sizeof(x86_sbm_state) != PAGE_SIZE);
 	err = map_page(state, (unsigned long)&x86_sbm_state,
-		       PHYS_PFN(__pa(state)), PAGE_KERNEL);
+		       PHYS_PFN(__pa(state)), pgprot_nonglobal(PAGE_KERNEL));
 	if (err < 0)
 		return err;
 
@@ -379,11 +384,104 @@ int arch_sbm_exec(struct sbm *sbm, sbm_func func, void *args)
 	return err;
 }
 
+static bool spurious_sbm_fault_check(unsigned long error_code, pte_t *pte)
+{
+	if ((error_code & X86_PF_WRITE) && !pte_write(*pte))
+		return false;
+
+	if ((error_code & X86_PF_INSTR) && !pte_exec(*pte))
+		return false;
+
+	return true;
+}
+
+/*
+ * Handle a spurious fault caused by a stale TLB entry.
+ *
+ * This allows us to lazily refresh the TLB when increasing the
+ * permissions of a kernel page (RO -> RW or NX -> X).  Doing it
+ * eagerly is very expensive since that implies doing a full
+ * cross-processor TLB flush, even if no stale TLB entries exist
+ * on other processors.
+ *
+ * Spurious faults may only occur if the TLB contains an entry with
+ * fewer permission than the page table entry.  Non-present (P = 0)
+ * and reserved bit (R = 1) faults are never spurious.
+ *
+ * There are no security implications to leaving a stale TLB when
+ * increasing the permissions on a page.
+ *
+ * Returns true if a spurious fault was handled, false otherwise.
+ *
+ * See Intel Developer's Manual Vol 3 Section 4.10.4.3, bullet 3
+ * (Optional Invalidation).
+ */
+static bool
+spurious_sbm_fault(struct x86_sbm_state *state, unsigned long error_code,
+		   unsigned long address)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+	bool ret;
+
+	if ((error_code & ~(X86_PF_WRITE | X86_PF_INSTR)) !=
+	    (X86_PF_USER | X86_PF_PROT))
+		return false;
+
+	pgd = __va(state->sbm_cr3 & CR3_ADDR_MASK) + pgd_index(address);
+	if (!pgd_present(*pgd))
+		return false;
+
+	p4d = p4d_offset(pgd, address);
+	if (!p4d_present(*p4d))
+		return false;
+
+	if (p4d_large(*p4d))
+		return spurious_sbm_fault_check(error_code, (pte_t *)p4d);
+
+	pud = pud_offset(p4d, address);
+	if (!pud_present(*pud))
+		return false;
+
+	if (pud_large(*pud))
+		return spurious_sbm_fault_check(error_code, (pte_t *)pud);
+
+	pmd = pmd_offset(pud, address);
+	if (!pmd_present(*pmd))
+		return false;
+
+	if (pmd_large(*pmd))
+		return spurious_sbm_fault_check(error_code, (pte_t *)pmd);
+
+	pte = pte_offset_kernel(pmd, address);
+	if (!pte_present(*pte))
+		return false;
+
+	ret = spurious_sbm_fault_check(error_code, pte);
+	if (!ret)
+		return false;
+
+	/*
+	 * Make sure we have permissions in PMD.
+	 * If not, then there's a bug in the page tables:
+	 */
+	ret = spurious_sbm_fault_check(error_code, (pte_t *)pmd);
+	WARN_ONCE(!ret, "PMD has incorrect permission bits\n");
+
+	return ret;
+}
+
 void handle_sbm_fault(struct pt_regs *regs, unsigned long error_code,
 		      unsigned long address)
 {
 	struct x86_sbm_state *state = current_thread_info()->sbm_state;
 
+	if (spurious_sbm_fault(state, error_code, address))
+		return;
+
 	/*
 	 * Force -EFAULT unless the fault was due to a user-mode instruction
 	 * fetch from the designated return address.
-- 
2.34.1


