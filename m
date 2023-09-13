Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95DB79E6FE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240423AbjIMLiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240367AbjIMLit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:38:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDF21BC0;
        Wed, 13 Sep 2023 04:38:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2C7F81F45B;
        Wed, 13 Sep 2023 11:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694605122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pys8ZMeihbqu1bWQt/XnMbkpDqMreD1pEdIt/VtSRwk=;
        b=KbCJatsAJtpEHO9X8iEcCiF/f6loxsNqBoDiqyiM0AFZ4RzaFcQc/ha3w17oXxz1bsUNdh
        ZxKyIQhwguDSEfDE0PPBW56VU6oh+zzqVzG9E5Ug9oY+uyW3zHiP4GNhNoOgkrAnhNd8SL
        +/49XOWY03XxzlSOwY3uYIO6t6d8bTY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB6E513582;
        Wed, 13 Sep 2023 11:38:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rzyeLEGfAWV8CwAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 13 Sep 2023 11:38:41 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-trace-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>, Ajay Kaher <akaher@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        xen-devel@lists.xenproject.org
Subject: [PATCH 2/3] x86/xen: move paravirt lazy code
Date:   Wed, 13 Sep 2023 13:38:27 +0200
Message-Id: <20230913113828.18421-3-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230913113828.18421-1-jgross@suse.com>
References: <20230913113828.18421-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only Xen is using the paravirt lazy mode code, so it can be moved to
Xen specific sources.

This allows to make some of the functions static or to merge them into
their only call sites.

While at it do a rename from "paravirt" to "xen" for all moved
specifiers.

No functional change.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt_types.h | 15 ------
 arch/x86/include/asm/xen/hypervisor.h | 26 +++++++++++
 arch/x86/kernel/paravirt.c            | 67 ---------------------------
 arch/x86/xen/enlighten_pv.c           | 39 +++++++++++++---
 arch/x86/xen/mmu_pv.c                 | 55 ++++++++++++++--------
 arch/x86/xen/multicalls.h             |  4 +-
 include/trace/events/xen.h            | 12 ++---
 7 files changed, 102 insertions(+), 116 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 4acbcddddc29..772d03487520 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -9,13 +9,6 @@ struct paravirt_patch_site {
 	u8 type;		/* type of this instruction */
 	u8 len;			/* length of original instruction */
 };
-
-/* Lazy mode for batching updates / context switch */
-enum paravirt_lazy_mode {
-	PARAVIRT_LAZY_NONE,
-	PARAVIRT_LAZY_MMU,
-	PARAVIRT_LAZY_CPU,
-};
 #endif
 
 #ifdef CONFIG_PARAVIRT
@@ -549,14 +542,6 @@ int paravirt_disable_iospace(void);
 	__PVOP_VCALL(op, PVOP_CALL_ARG1(arg1), PVOP_CALL_ARG2(arg2),	\
 		     PVOP_CALL_ARG3(arg3), PVOP_CALL_ARG4(arg4))
 
-enum paravirt_lazy_mode paravirt_get_lazy_mode(void);
-void paravirt_start_context_switch(struct task_struct *prev);
-void paravirt_end_context_switch(struct task_struct *next);
-
-void paravirt_enter_lazy_mmu(void);
-void paravirt_leave_lazy_mmu(void);
-void paravirt_flush_lazy_mmu(void);
-
 void _paravirt_nop(void);
 void paravirt_BUG(void);
 unsigned long paravirt_ret0(void);
diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
index 5fc35f889cd1..ed05ce3df5c7 100644
--- a/arch/x86/include/asm/xen/hypervisor.h
+++ b/arch/x86/include/asm/xen/hypervisor.h
@@ -36,6 +36,7 @@
 extern struct shared_info *HYPERVISOR_shared_info;
 extern struct start_info *xen_start_info;
 
+#include <asm/bug.h>
 #include <asm/processor.h>
 
 #define XEN_SIGNATURE "XenVMMXenVMM"
@@ -63,4 +64,29 @@ void __init xen_pvh_init(struct boot_params *boot_params);
 void __init mem_map_via_hcall(struct boot_params *boot_params_p);
 #endif
 
+/* Lazy mode for batching updates / context switch */
+enum xen_lazy_mode {
+	XEN_LAZY_NONE,
+	XEN_LAZY_MMU,
+	XEN_LAZY_CPU,
+};
+
+DECLARE_PER_CPU(enum xen_lazy_mode, xen_lazy_mode);
+
+static inline void enter_lazy(enum xen_lazy_mode mode)
+{
+	BUG_ON(this_cpu_read(xen_lazy_mode) != XEN_LAZY_NONE);
+
+	this_cpu_write(xen_lazy_mode, mode);
+}
+
+static inline void leave_lazy(enum xen_lazy_mode mode)
+{
+	BUG_ON(this_cpu_read(xen_lazy_mode) != mode);
+
+	this_cpu_write(xen_lazy_mode, XEN_LAZY_NONE);
+}
+
+enum xen_lazy_mode xen_get_lazy_mode(void);
+
 #endif /* _ASM_X86_XEN_HYPERVISOR_H */
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 975f98d5eee5..97f1436c1a20 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -143,66 +143,7 @@ int paravirt_disable_iospace(void)
 	return request_resource(&ioport_resource, &reserve_ioports);
 }
 
-static DEFINE_PER_CPU(enum paravirt_lazy_mode, paravirt_lazy_mode) = PARAVIRT_LAZY_NONE;
-
-static inline void enter_lazy(enum paravirt_lazy_mode mode)
-{
-	BUG_ON(this_cpu_read(paravirt_lazy_mode) != PARAVIRT_LAZY_NONE);
-
-	this_cpu_write(paravirt_lazy_mode, mode);
-}
-
-static void leave_lazy(enum paravirt_lazy_mode mode)
-{
-	BUG_ON(this_cpu_read(paravirt_lazy_mode) != mode);
-
-	this_cpu_write(paravirt_lazy_mode, PARAVIRT_LAZY_NONE);
-}
-
-void paravirt_enter_lazy_mmu(void)
-{
-	enter_lazy(PARAVIRT_LAZY_MMU);
-}
-
-void paravirt_leave_lazy_mmu(void)
-{
-	leave_lazy(PARAVIRT_LAZY_MMU);
-}
-
-void paravirt_flush_lazy_mmu(void)
-{
-	preempt_disable();
-
-	if (paravirt_get_lazy_mode() == PARAVIRT_LAZY_MMU) {
-		arch_leave_lazy_mmu_mode();
-		arch_enter_lazy_mmu_mode();
-	}
-
-	preempt_enable();
-}
-
 #ifdef CONFIG_PARAVIRT_XXL
-void paravirt_start_context_switch(struct task_struct *prev)
-{
-	BUG_ON(preemptible());
-
-	if (this_cpu_read(paravirt_lazy_mode) == PARAVIRT_LAZY_MMU) {
-		arch_leave_lazy_mmu_mode();
-		set_ti_thread_flag(task_thread_info(prev), TIF_LAZY_MMU_UPDATES);
-	}
-	enter_lazy(PARAVIRT_LAZY_CPU);
-}
-
-void paravirt_end_context_switch(struct task_struct *next)
-{
-	BUG_ON(preemptible());
-
-	leave_lazy(PARAVIRT_LAZY_CPU);
-
-	if (test_and_clear_ti_thread_flag(task_thread_info(next), TIF_LAZY_MMU_UPDATES))
-		arch_enter_lazy_mmu_mode();
-}
-
 static noinstr void pv_native_write_cr2(unsigned long val)
 {
 	native_write_cr2(val);
@@ -229,14 +170,6 @@ static noinstr void pv_native_safe_halt(void)
 }
 #endif
 
-enum paravirt_lazy_mode paravirt_get_lazy_mode(void)
-{
-	if (in_interrupt())
-		return PARAVIRT_LAZY_NONE;
-
-	return this_cpu_read(paravirt_lazy_mode);
-}
-
 struct pv_info pv_info = {
 	.name = "bare hardware",
 #ifdef CONFIG_PARAVIRT_XXL
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 49352fad7d1d..54b83825c4b6 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -101,6 +101,16 @@ struct tls_descs {
 	struct desc_struct desc[3];
 };
 
+DEFINE_PER_CPU(enum xen_lazy_mode, xen_lazy_mode) = XEN_LAZY_NONE;
+
+enum xen_lazy_mode xen_get_lazy_mode(void)
+{
+	if (in_interrupt())
+		return XEN_LAZY_NONE;
+
+	return this_cpu_read(xen_lazy_mode);
+}
+
 /*
  * Updating the 3 TLS descriptors in the GDT on every task switch is
  * surprisingly expensive so we avoid updating them if they haven't
@@ -362,10 +372,25 @@ static noinstr unsigned long xen_get_debugreg(int reg)
 	return HYPERVISOR_get_debugreg(reg);
 }
 
+static void xen_start_context_switch(struct task_struct *prev)
+{
+	BUG_ON(preemptible());
+
+	if (this_cpu_read(xen_lazy_mode) == XEN_LAZY_MMU) {
+		arch_leave_lazy_mmu_mode();
+		set_ti_thread_flag(task_thread_info(prev), TIF_LAZY_MMU_UPDATES);
+	}
+	enter_lazy(XEN_LAZY_CPU);
+}
+
 static void xen_end_context_switch(struct task_struct *next)
 {
+	BUG_ON(preemptible());
+
 	xen_mc_flush();
-	paravirt_end_context_switch(next);
+	leave_lazy(XEN_LAZY_CPU);
+	if (test_and_clear_ti_thread_flag(task_thread_info(next), TIF_LAZY_MMU_UPDATES))
+		arch_enter_lazy_mmu_mode();
 }
 
 static unsigned long xen_store_tr(void)
@@ -472,7 +497,7 @@ static void xen_set_ldt(const void *addr, unsigned entries)
 
 	MULTI_mmuext_op(mcs.mc, op, 1, NULL, DOMID_SELF);
 
-	xen_mc_issue(PARAVIRT_LAZY_CPU);
+	xen_mc_issue(XEN_LAZY_CPU);
 }
 
 static void xen_load_gdt(const struct desc_ptr *dtr)
@@ -568,7 +593,7 @@ static void xen_load_tls(struct thread_struct *t, unsigned int cpu)
 	 * exception between the new %fs descriptor being loaded and
 	 * %fs being effectively cleared at __switch_to().
 	 */
-	if (paravirt_get_lazy_mode() == PARAVIRT_LAZY_CPU)
+	if (xen_get_lazy_mode() == XEN_LAZY_CPU)
 		loadsegment(fs, 0);
 
 	xen_mc_batch();
@@ -577,7 +602,7 @@ static void xen_load_tls(struct thread_struct *t, unsigned int cpu)
 	load_TLS_descriptor(t, cpu, 1);
 	load_TLS_descriptor(t, cpu, 2);
 
-	xen_mc_issue(PARAVIRT_LAZY_CPU);
+	xen_mc_issue(XEN_LAZY_CPU);
 }
 
 static void xen_load_gs_index(unsigned int idx)
@@ -909,7 +934,7 @@ static void xen_load_sp0(unsigned long sp0)
 
 	mcs = xen_mc_entry(0);
 	MULTI_stack_switch(mcs.mc, __KERNEL_DS, sp0);
-	xen_mc_issue(PARAVIRT_LAZY_CPU);
+	xen_mc_issue(XEN_LAZY_CPU);
 	this_cpu_write(cpu_tss_rw.x86_tss.sp0, sp0);
 }
 
@@ -973,7 +998,7 @@ static void xen_write_cr0(unsigned long cr0)
 
 	MULTI_fpu_taskswitch(mcs.mc, (cr0 & X86_CR0_TS) != 0);
 
-	xen_mc_issue(PARAVIRT_LAZY_CPU);
+	xen_mc_issue(XEN_LAZY_CPU);
 }
 
 static void xen_write_cr4(unsigned long cr4)
@@ -1156,7 +1181,7 @@ static const typeof(pv_ops) xen_cpu_ops __initconst = {
 #endif
 		.io_delay = xen_io_delay,
 
-		.start_context_switch = paravirt_start_context_switch,
+		.start_context_switch = xen_start_context_switch,
 		.end_context_switch = xen_end_context_switch,
 	},
 };
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 1652c39e3dfb..b6830554ff69 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -236,7 +236,7 @@ static void xen_set_pmd_hyper(pmd_t *ptr, pmd_t val)
 	u.val = pmd_val_ma(val);
 	xen_extend_mmu_update(&u);
 
-	xen_mc_issue(PARAVIRT_LAZY_MMU);
+	xen_mc_issue(XEN_LAZY_MMU);
 
 	preempt_enable();
 }
@@ -270,7 +270,7 @@ static bool xen_batched_set_pte(pte_t *ptep, pte_t pteval)
 {
 	struct mmu_update u;
 
-	if (paravirt_get_lazy_mode() != PARAVIRT_LAZY_MMU)
+	if (xen_get_lazy_mode() != XEN_LAZY_MMU)
 		return false;
 
 	xen_mc_batch();
@@ -279,7 +279,7 @@ static bool xen_batched_set_pte(pte_t *ptep, pte_t pteval)
 	u.val = pte_val_ma(pteval);
 	xen_extend_mmu_update(&u);
 
-	xen_mc_issue(PARAVIRT_LAZY_MMU);
+	xen_mc_issue(XEN_LAZY_MMU);
 
 	return true;
 }
@@ -325,7 +325,7 @@ void xen_ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
 	u.val = pte_val_ma(pte);
 	xen_extend_mmu_update(&u);
 
-	xen_mc_issue(PARAVIRT_LAZY_MMU);
+	xen_mc_issue(XEN_LAZY_MMU);
 }
 
 /* Assume pteval_t is equivalent to all the other *val_t types. */
@@ -419,7 +419,7 @@ static void xen_set_pud_hyper(pud_t *ptr, pud_t val)
 	u.val = pud_val_ma(val);
 	xen_extend_mmu_update(&u);
 
-	xen_mc_issue(PARAVIRT_LAZY_MMU);
+	xen_mc_issue(XEN_LAZY_MMU);
 
 	preempt_enable();
 }
@@ -499,7 +499,7 @@ static void __init xen_set_p4d_hyper(p4d_t *ptr, p4d_t val)
 
 	__xen_set_p4d_hyper(ptr, val);
 
-	xen_mc_issue(PARAVIRT_LAZY_MMU);
+	xen_mc_issue(XEN_LAZY_MMU);
 
 	preempt_enable();
 }
@@ -531,7 +531,7 @@ static void xen_set_p4d(p4d_t *ptr, p4d_t val)
 	if (user_ptr)
 		__xen_set_p4d_hyper((p4d_t *)user_ptr, val);
 
-	xen_mc_issue(PARAVIRT_LAZY_MMU);
+	xen_mc_issue(XEN_LAZY_MMU);
 }
 
 #if CONFIG_PGTABLE_LEVELS >= 5
@@ -1245,7 +1245,7 @@ static noinline void xen_flush_tlb(void)
 	op->cmd = MMUEXT_TLB_FLUSH_LOCAL;
 	MULTI_mmuext_op(mcs.mc, op, 1, NULL, DOMID_SELF);
 
-	xen_mc_issue(PARAVIRT_LAZY_MMU);
+	xen_mc_issue(XEN_LAZY_MMU);
 
 	preempt_enable();
 }
@@ -1265,7 +1265,7 @@ static void xen_flush_tlb_one_user(unsigned long addr)
 	op->arg1.linear_addr = addr & PAGE_MASK;
 	MULTI_mmuext_op(mcs.mc, op, 1, NULL, DOMID_SELF);
 
-	xen_mc_issue(PARAVIRT_LAZY_MMU);
+	xen_mc_issue(XEN_LAZY_MMU);
 
 	preempt_enable();
 }
@@ -1302,7 +1302,7 @@ static void xen_flush_tlb_multi(const struct cpumask *cpus,
 
 	MULTI_mmuext_op(mcs.mc, &args->op, 1, NULL, DOMID_SELF);
 
-	xen_mc_issue(PARAVIRT_LAZY_MMU);
+	xen_mc_issue(XEN_LAZY_MMU);
 }
 
 static unsigned long xen_read_cr3(void)
@@ -1361,7 +1361,7 @@ static void xen_write_cr3(unsigned long cr3)
 	else
 		__xen_write_cr3(false, 0);
 
-	xen_mc_issue(PARAVIRT_LAZY_CPU);  /* interrupts restored */
+	xen_mc_issue(XEN_LAZY_CPU);  /* interrupts restored */
 }
 
 /*
@@ -1396,7 +1396,7 @@ static void __init xen_write_cr3_init(unsigned long cr3)
 
 	__xen_write_cr3(true, cr3);
 
-	xen_mc_issue(PARAVIRT_LAZY_CPU);  /* interrupts restored */
+	xen_mc_issue(XEN_LAZY_CPU);  /* interrupts restored */
 }
 
 static int xen_pgd_alloc(struct mm_struct *mm)
@@ -1557,7 +1557,7 @@ static inline void xen_alloc_ptpage(struct mm_struct *mm, unsigned long pfn,
 		if (level == PT_PTE && USE_SPLIT_PTE_PTLOCKS && !pinned)
 			__pin_pagetable_pfn(MMUEXT_PIN_L1_TABLE, pfn);
 
-		xen_mc_issue(PARAVIRT_LAZY_MMU);
+		xen_mc_issue(XEN_LAZY_MMU);
 	}
 }
 
@@ -1587,7 +1587,7 @@ static inline void xen_release_ptpage(unsigned long pfn, unsigned level)
 
 		__set_pfn_prot(pfn, PAGE_KERNEL);
 
-		xen_mc_issue(PARAVIRT_LAZY_MMU);
+		xen_mc_issue(XEN_LAZY_MMU);
 
 		ClearPagePinned(page);
 	}
@@ -1804,7 +1804,7 @@ void __init xen_setup_kernel_pagetable(pgd_t *pgd, unsigned long max_pfn)
 	 */
 	xen_mc_batch();
 	__xen_write_cr3(true, __pa(init_top_pgt));
-	xen_mc_issue(PARAVIRT_LAZY_CPU);
+	xen_mc_issue(XEN_LAZY_CPU);
 
 	/* We can't that easily rip out L3 and L2, as the Xen pagetables are
 	 * set out this way: [L4], [L1], [L2], [L3], [L1], [L1] ...  for
@@ -2083,6 +2083,23 @@ static void xen_set_fixmap(unsigned idx, phys_addr_t phys, pgprot_t prot)
 #endif
 }
 
+static void xen_enter_lazy_mmu(void)
+{
+	enter_lazy(XEN_LAZY_MMU);
+}
+
+static void xen_flush_lazy_mmu(void)
+{
+	preempt_disable();
+
+	if (xen_get_lazy_mode() == XEN_LAZY_MMU) {
+		arch_leave_lazy_mmu_mode();
+		arch_enter_lazy_mmu_mode();
+	}
+
+	preempt_enable();
+}
+
 static void __init xen_post_allocator_init(void)
 {
 	pv_ops.mmu.set_pte = xen_set_pte;
@@ -2107,7 +2124,7 @@ static void xen_leave_lazy_mmu(void)
 {
 	preempt_disable();
 	xen_mc_flush();
-	paravirt_leave_lazy_mmu();
+	leave_lazy(XEN_LAZY_MMU);
 	preempt_enable();
 }
 
@@ -2166,9 +2183,9 @@ static const typeof(pv_ops) xen_mmu_ops __initconst = {
 		.exit_mmap = xen_exit_mmap,
 
 		.lazy_mode = {
-			.enter = paravirt_enter_lazy_mmu,
+			.enter = xen_enter_lazy_mmu,
 			.leave = xen_leave_lazy_mmu,
-			.flush = paravirt_flush_lazy_mmu,
+			.flush = xen_flush_lazy_mmu,
 		},
 
 		.set_fixmap = xen_set_fixmap,
@@ -2385,7 +2402,7 @@ static noinline void xen_flush_tlb_all(void)
 	op->cmd = MMUEXT_TLB_FLUSH_ALL;
 	MULTI_mmuext_op(mcs.mc, op, 1, NULL, DOMID_SELF);
 
-	xen_mc_issue(PARAVIRT_LAZY_MMU);
+	xen_mc_issue(XEN_LAZY_MMU);
 
 	preempt_enable();
 }
diff --git a/arch/x86/xen/multicalls.h b/arch/x86/xen/multicalls.h
index 1c51b2c87f30..c3867b585e0d 100644
--- a/arch/x86/xen/multicalls.h
+++ b/arch/x86/xen/multicalls.h
@@ -26,7 +26,7 @@ static inline void xen_mc_batch(void)
 
 	/* need to disable interrupts until this entry is complete */
 	local_irq_save(flags);
-	trace_xen_mc_batch(paravirt_get_lazy_mode());
+	trace_xen_mc_batch(xen_get_lazy_mode());
 	__this_cpu_write(xen_mc_irq_flags, flags);
 }
 
@@ -44,7 +44,7 @@ static inline void xen_mc_issue(unsigned mode)
 {
 	trace_xen_mc_issue(mode);
 
-	if ((paravirt_get_lazy_mode() & mode) == 0)
+	if ((xen_get_lazy_mode() & mode) == 0)
 		xen_mc_flush();
 
 	/* restore flags saved in xen_mc_batch */
diff --git a/include/trace/events/xen.h b/include/trace/events/xen.h
index 44a3f565264d..0577f0cdd231 100644
--- a/include/trace/events/xen.h
+++ b/include/trace/events/xen.h
@@ -6,26 +6,26 @@
 #define _TRACE_XEN_H
 
 #include <linux/tracepoint.h>
-#include <asm/paravirt_types.h>
+#include <asm/xen/hypervisor.h>
 #include <asm/xen/trace_types.h>
 
 struct multicall_entry;
 
 /* Multicalls */
 DECLARE_EVENT_CLASS(xen_mc__batch,
-	    TP_PROTO(enum paravirt_lazy_mode mode),
+	    TP_PROTO(enum xen_lazy_mode mode),
 	    TP_ARGS(mode),
 	    TP_STRUCT__entry(
-		    __field(enum paravirt_lazy_mode, mode)
+		    __field(enum xen_lazy_mode, mode)
 		    ),
 	    TP_fast_assign(__entry->mode = mode),
 	    TP_printk("start batch LAZY_%s",
-		      (__entry->mode == PARAVIRT_LAZY_MMU) ? "MMU" :
-		      (__entry->mode == PARAVIRT_LAZY_CPU) ? "CPU" : "NONE")
+		      (__entry->mode == XEN_LAZY_MMU) ? "MMU" :
+		      (__entry->mode == XEN_LAZY_CPU) ? "CPU" : "NONE")
 	);
 #define DEFINE_XEN_MC_BATCH(name)			\
 	DEFINE_EVENT(xen_mc__batch, name,		\
-		TP_PROTO(enum paravirt_lazy_mode mode),	\
+		TP_PROTO(enum xen_lazy_mode mode),	\
 		     TP_ARGS(mode))
 
 DEFINE_XEN_MC_BATCH(xen_mc_batch);
-- 
2.35.3

