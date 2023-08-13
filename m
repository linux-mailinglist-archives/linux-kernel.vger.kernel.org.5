Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BF177AAD9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 21:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjHMTRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 15:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjHMTRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 15:17:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DF518E
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 12:17:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44FBB611CA
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 19:17:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569AAC433C8;
        Sun, 13 Aug 2023 19:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691954222;
        bh=2QV00GFuIgMlofmAIsG8HxJytGGMRlnLreYgVNFMCiQ=;
        h=From:To:Cc:Subject:Date:From;
        b=f4Sr0GkoAZX9PEQIKUgUH0NLnauJkhCBZJVRByoUtA7uTQk5nGCjD5eSQs+RX2lPL
         b+csgD8E6KQUh1TerAaFc0R9y9wpfwXI+dpyw4tavebeN9omp6RB+Yw1Do4GF9869h
         HYFuN9LM2xQXO+Qs+/+2n6478GXrBoTMsD9MM0eIGeLx8mEBrxQkCiEWmyeqY/1mNm
         fZimxwMG+cPAE1pqdWML83rP5lqjO9jxdwAxhMjIpnLAnIVPeBNlQsgcBnW2+rg45j
         DfGfvWbykECPyBNmpiEyFAFx8BQsgcpS4tLwYQZHvr2fbRo1upEob5rLL3e171WrUL
         BhDwzV0FqZpPQ==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH] ARC: -Wmissing-prototype warning fixes
Date:   Sun, 13 Aug 2023 12:16:55 -0700
Message-Id: <20230813191655.474577-1-vgupta@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anrd reported [1] new compiler warnings due to -Wmissing-protype.
These are for non static functions mostly used in asm code hence not
exported already. Fix this by adding the prototypes.

[1] https://lore.kernel.org/lkml/20230810141947.1236730-1-arnd@kernel.org

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/include/asm/entry.h  | 21 +++++++++++++++++++++
 arch/arc/include/asm/irq.h    |  1 +
 arch/arc/include/asm/mmu.h    |  2 ++
 arch/arc/include/asm/ptrace.h |  3 +++
 arch/arc/include/asm/setup.h  |  2 ++
 arch/arc/include/asm/smp.h    |  2 ++
 arch/arc/kernel/ctx_sw.c      |  2 +-
 arch/arc/kernel/devtree.c     |  1 +
 arch/arc/kernel/intc-arcv2.c  |  2 +-
 arch/arc/kernel/signal.c      |  1 +
 arch/arc/kernel/smp.c         |  7 ++++---
 arch/arc/kernel/stacktrace.c  |  1 +
 arch/arc/kernel/traps.c       |  1 +
 arch/arc/mm/cache.c           |  8 ++++----
 arch/arc/mm/fault.c           |  1 +
 arch/arc/mm/init.c            |  1 +
 arch/arc/mm/tlb.c             |  2 +-
 17 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/arch/arc/include/asm/entry.h b/arch/arc/include/asm/entry.h
index fcdd59d77f42..2980bc9b7653 100644
--- a/arch/arc/include/asm/entry.h
+++ b/arch/arc/include/asm/entry.h
@@ -13,6 +13,8 @@
 #include <asm/processor.h>	/* For VMALLOC_START */
 #include <asm/mmu.h>
 
+#ifdef __ASSEMBLY__
+
 #ifdef CONFIG_ISA_ARCOMPACT
 #include <asm/entry-compact.h>	/* ISA specific bits */
 #else
@@ -295,4 +297,23 @@
 
 #endif	/* CONFIG_ARC_CURR_IN_REG */
 
+#else	/* !__ASSEMBLY__ */
+
+extern void do_signal(struct pt_regs *);
+extern void do_notify_resume(struct pt_regs *);
+extern int do_privilege_fault(unsigned long, struct pt_regs *);
+extern int do_extension_fault(unsigned long, struct pt_regs *);
+extern int insterror_is_error(unsigned long, struct pt_regs *);
+extern int do_memory_error(unsigned long, struct pt_regs *);
+extern int trap_is_brkpt(unsigned long, struct pt_regs *);
+extern int do_misaligned_error(unsigned long, struct pt_regs *);
+extern int do_trap5_error(unsigned long, struct pt_regs *);
+extern int do_misaligned_access(unsigned long, struct pt_regs *, struct callee_regs *);
+extern void do_machine_check_fault(unsigned long, struct pt_regs *);
+extern void do_non_swi_trap(unsigned long, struct pt_regs *);
+extern void do_insterror_or_kprobe(unsigned long, struct pt_regs *);
+extern void do_page_fault(unsigned long, struct pt_regs *);
+
+#endif
+
 #endif  /* __ASM_ARC_ENTRY_H */
diff --git a/arch/arc/include/asm/irq.h b/arch/arc/include/asm/irq.h
index 0309cb405cfb..c574712ad865 100644
--- a/arch/arc/include/asm/irq.h
+++ b/arch/arc/include/asm/irq.h
@@ -25,5 +25,6 @@
 #include <asm-generic/irq.h>
 
 extern void arc_init_IRQ(void);
+extern void arch_do_IRQ(unsigned int, struct pt_regs *);
 
 #endif
diff --git a/arch/arc/include/asm/mmu.h b/arch/arc/include/asm/mmu.h
index ca427c30f70e..9febf5bc3de6 100644
--- a/arch/arc/include/asm/mmu.h
+++ b/arch/arc/include/asm/mmu.h
@@ -14,6 +14,8 @@ typedef struct {
 	unsigned long asid[NR_CPUS];	/* 8 bit MMU PID + Generation cycle */
 } mm_context_t;
 
+extern void do_tlb_overlap_fault(unsigned long, unsigned long, struct pt_regs *);
+
 #endif
 
 #include <asm/mmu-arcv2.h>
diff --git a/arch/arc/include/asm/ptrace.h b/arch/arc/include/asm/ptrace.h
index 5869a74c0db2..cf90fcd2a628 100644
--- a/arch/arc/include/asm/ptrace.h
+++ b/arch/arc/include/asm/ptrace.h
@@ -181,6 +181,9 @@ static inline unsigned long regs_get_register(struct pt_regs *regs,
 	return *(unsigned long *)((unsigned long)regs + offset);
 }
 
+extern int syscall_trace_entry(struct pt_regs *);
+extern void syscall_trace_exit(struct pt_regs *);
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_PTRACE_H */
diff --git a/arch/arc/include/asm/setup.h b/arch/arc/include/asm/setup.h
index 028a8cf76206..374138832c5a 100644
--- a/arch/arc/include/asm/setup.h
+++ b/arch/arc/include/asm/setup.h
@@ -42,4 +42,6 @@ extern void arc_cache_init(void);
 extern char *arc_cache_mumbojumbo(int cpu_id, char *buf, int len);
 extern void read_decode_cache_bcr(void);
 
+extern void __init handle_uboot_args(void);
+
 #endif /* __ASMARC_SETUP_H */
diff --git a/arch/arc/include/asm/smp.h b/arch/arc/include/asm/smp.h
index d856491606ac..e0913f52c2cd 100644
--- a/arch/arc/include/asm/smp.h
+++ b/arch/arc/include/asm/smp.h
@@ -29,6 +29,8 @@ extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
 extern void __init smp_init_cpus(void);
 extern void first_lines_of_secondary(void);
 extern const char *arc_platform_smp_cpuinfo(void);
+extern void arc_platform_smp_wait_to_boot(int);
+extern void start_kernel_secondary(void);
 
 /*
  * API expected BY platform smp code (FROM arch smp code)
diff --git a/arch/arc/kernel/ctx_sw.c b/arch/arc/kernel/ctx_sw.c
index 1a76f2d6f694..bf16f777a0bc 100644
--- a/arch/arc/kernel/ctx_sw.c
+++ b/arch/arc/kernel/ctx_sw.c
@@ -12,7 +12,7 @@
  */
 
 #include <asm/asm-offsets.h>
-#include <linux/sched.h>
+#include <asm/switch_to.h>
 #include <linux/sched/debug.h>
 
 #define KSP_WORD_OFF 	((TASK_THREAD + THREAD_KSP) / 4)
diff --git a/arch/arc/kernel/devtree.c b/arch/arc/kernel/devtree.c
index 721d465f1580..4c9e61457b2f 100644
--- a/arch/arc/kernel/devtree.c
+++ b/arch/arc/kernel/devtree.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <asm/mach_desc.h>
+#include <asm/serial.h>
 
 #ifdef CONFIG_SERIAL_EARLYCON
 
diff --git a/arch/arc/kernel/intc-arcv2.c b/arch/arc/kernel/intc-arcv2.c
index 5cda19d0aa91..678898757e47 100644
--- a/arch/arc/kernel/intc-arcv2.c
+++ b/arch/arc/kernel/intc-arcv2.c
@@ -108,7 +108,7 @@ static void arcv2_irq_unmask(struct irq_data *data)
 	write_aux_reg(AUX_IRQ_ENABLE, 1);
 }
 
-void arcv2_irq_enable(struct irq_data *data)
+static void arcv2_irq_enable(struct irq_data *data)
 {
 	/* set default priority */
 	write_aux_reg(AUX_IRQ_SELECT, data->hwirq);
diff --git a/arch/arc/kernel/signal.c b/arch/arc/kernel/signal.c
index 3c1590c27fae..0b3bb529d246 100644
--- a/arch/arc/kernel/signal.c
+++ b/arch/arc/kernel/signal.c
@@ -53,6 +53,7 @@
 #include <linux/sched/task_stack.h>
 
 #include <asm/ucontext.h>
+#include <asm/entry.h>
 
 struct rt_sigframe {
 	struct siginfo info;
diff --git a/arch/arc/kernel/smp.c b/arch/arc/kernel/smp.c
index 409cfa4675b4..8d9b188caa27 100644
--- a/arch/arc/kernel/smp.c
+++ b/arch/arc/kernel/smp.c
@@ -23,9 +23,10 @@
 #include <linux/export.h>
 #include <linux/of_fdt.h>
 
-#include <asm/processor.h>
-#include <asm/setup.h>
 #include <asm/mach_desc.h>
+#include <asm/setup.h>
+#include <asm/smp.h>
+#include <asm/processor.h>
 
 #ifndef CONFIG_ARC_HAS_LLSC
 arch_spinlock_t smp_atomic_ops_lock = __ARCH_SPIN_LOCK_UNLOCKED;
@@ -351,7 +352,7 @@ static inline int __do_IPI(unsigned long msg)
  * arch-common ISR to handle for inter-processor interrupts
  * Has hooks for platform specific IPI
  */
-irqreturn_t do_IPI(int irq, void *dev_id)
+static irqreturn_t do_IPI(int irq, void *dev_id)
 {
 	unsigned long pending;
 	unsigned long __maybe_unused copy;
diff --git a/arch/arc/kernel/stacktrace.c b/arch/arc/kernel/stacktrace.c
index 5372dc04e784..ea99c066ef25 100644
--- a/arch/arc/kernel/stacktrace.c
+++ b/arch/arc/kernel/stacktrace.c
@@ -29,6 +29,7 @@
 
 #include <asm/arcregs.h>
 #include <asm/unwind.h>
+#include <asm/stacktrace.h>
 #include <asm/switch_to.h>
 
 /*-------------------------------------------------------------------------
diff --git a/arch/arc/kernel/traps.c b/arch/arc/kernel/traps.c
index 6b83e3f2b41c..2f7eb786695b 100644
--- a/arch/arc/kernel/traps.c
+++ b/arch/arc/kernel/traps.c
@@ -16,6 +16,7 @@
 #include <linux/ptrace.h>
 #include <linux/kprobes.h>
 #include <linux/kgdb.h>
+#include <asm/entry.h>
 #include <asm/setup.h>
 #include <asm/unaligned.h>
 #include <asm/kprobes.h>
diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c
index 892f6ef29ff4..e78c3070b517 100644
--- a/arch/arc/mm/cache.c
+++ b/arch/arc/mm/cache.c
@@ -580,7 +580,7 @@ static void __ic_line_inv_vaddr(phys_addr_t paddr, unsigned long vaddr,
 
 #endif /* CONFIG_ARC_HAS_ICACHE */
 
-noinline void slc_op_rgn(phys_addr_t paddr, unsigned long sz, const int op)
+static noinline void slc_op_rgn(phys_addr_t paddr, unsigned long sz, const int op)
 {
 #ifdef CONFIG_ISA_ARCV2
 	/*
@@ -643,7 +643,7 @@ noinline void slc_op_rgn(phys_addr_t paddr, unsigned long sz, const int op)
 #endif
 }
 
-noinline void slc_op_line(phys_addr_t paddr, unsigned long sz, const int op)
+static __maybe_unused noinline void slc_op_line(phys_addr_t paddr, unsigned long sz, const int op)
 {
 #ifdef CONFIG_ISA_ARCV2
 	/*
@@ -966,7 +966,7 @@ SYSCALL_DEFINE3(cacheflush, uint32_t, start, uint32_t, sz, uint32_t, flags)
  * 3. All Caches need to be disabled when setting up IOC to elide any in-flight
  *    Coherency transactions
  */
-noinline void __init arc_ioc_setup(void)
+static noinline void __init arc_ioc_setup(void)
 {
 	unsigned int ioc_base, mem_sz;
 
@@ -1028,7 +1028,7 @@ noinline void __init arc_ioc_setup(void)
  *    one core suffices for all
  *  - IOC setup / dma callbacks only need to be done once
  */
-void __init arc_cache_init_master(void)
+static noinline void __init arc_cache_init_master(void)
 {
 	unsigned int __maybe_unused cpu = smp_processor_id();
 
diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index f59e722d147f..26e5823c5710 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -13,6 +13,7 @@
 #include <linux/kdebug.h>
 #include <linux/perf_event.h>
 #include <linux/mm_types.h>
+#include <asm/entry.h>
 #include <asm/mmu.h>
 
 /*
diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
index 9f64d729c9f8..6a71b23f1383 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -15,6 +15,7 @@
 #include <linux/highmem.h>
 #include <asm/page.h>
 #include <asm/sections.h>
+#include <asm/setup.h>
 #include <asm/arcregs.h>
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __aligned(PAGE_SIZE);
diff --git a/arch/arc/mm/tlb.c b/arch/arc/mm/tlb.c
index 0ebc737d0ac6..b53ad03ae564 100644
--- a/arch/arc/mm/tlb.c
+++ b/arch/arc/mm/tlb.c
@@ -389,7 +389,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 /*
  * Routine to create a TLB entry
  */
-void create_tlb(struct vm_area_struct *vma, unsigned long vaddr, pte_t *ptep)
+static void create_tlb(struct vm_area_struct *vma, unsigned long vaddr, pte_t *ptep)
 {
 	unsigned long flags;
 	unsigned int asid_or_sasid, rwx;
-- 
2.34.1

