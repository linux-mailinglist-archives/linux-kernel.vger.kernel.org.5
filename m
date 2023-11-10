Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7496E7E808A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345276AbjKJSNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345861AbjKJSLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:11:30 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767A03A211;
        Fri, 10 Nov 2023 07:01:28 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 242D11F8BD;
        Fri, 10 Nov 2023 15:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1699628487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YKJC7dIEdCJQv7ibjvsyrm4v+mnfkqXydaj+0yymMtw=;
        b=xAuRL0kGB2BaaxthsVK6f7SgEtLAUDt4OBykZfQC1+reKLp92cAkID/j7ZJ6HDZhn04t/y
        S2fkG013u/bjneLxmdUWWEW4d7MMd3T5MqYZpO6sGeRkJO3cHbu4u8H8A72WT/FAPGVr9m
        rOvw8M4YaR78F/F9xz/acu1xKfmeIKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1699628487;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YKJC7dIEdCJQv7ibjvsyrm4v+mnfkqXydaj+0yymMtw=;
        b=QQG1llf0mFf72EnMYF7MwGoFlUe3JZhW2XWbWcWp9Zih23ZUA3FSiKB5zUOvMWzgJ3f/Cd
        7SffF3aESc9JckCw==
Received: from localhost.cz (unknown [10.100.229.110])
        by relay2.suse.de (Postfix) with ESMTP id 6FED82CF29;
        Fri, 10 Nov 2023 15:01:26 +0000 (UTC)
From:   Lukas Hruska <lhruska@suse.cz>
To:     linux-debuggers@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michal Koutny <mkoutny@suse.com>,
        YOSHIDA Masanori <masanori.yoshida.tv@hitachi.com>
Subject: [RFC PATCH 2/4 v1] livedump: Add write protection management
Date:   Fri, 10 Nov 2023 16:00:55 +0100
Message-ID: <20231110150057.15717-3-lhruska@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231110150057.15717-1-lhruska@suse.cz>
References: <20231110150057.15717-1-lhruska@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes it possible to write-protect pages in kernel space and to
install a handler function that is called every time when page fault occurs
on the protected page. The write protection is executed in the stop-machine
state to protect all pages consistently.

Processing of write protection and fault handling is executed in the order
as follows:

(1) Initialization phase
  - Sets up data structure for write protection management.
  - Splits all large pages in kernel space into 4K pages since currently
    livedump can handle only 4K pages. In the future, this step (page
    splitting) should be eliminated.
(2) Write protection phase
  - Stops machine.
  - Handles sensitive pages.
    (described below about sensitive pages)
  - Sets up write protection.
  - Resumes machine.
(3) Page fault exception handling
  - Calls the handler function before unprotecting the faulted page.
(4) Sweep phase
  - Calls the handler function against the rest of pages.
(5) Uninitialization phase
  - Cleans up all data structure for write protection management.

This module have following 4 phases.
- initialization phase
- write protection phase
- sweep phase
- uninitialization phase

States of processing is as follows. They can transit only in this order.
- STATE_UNINIT
- STATE_INITED
- STATE_STARTED (= write protection already set up)
- STATE_SWEPT

However, this order is protected by a normal integer variable, therefore,
to be exact, this code is not yet safe against concurrent operation.

The livedump module has to acquire consistent memory image of kernel space.
Therefore, write protection is set up while update of memory state is
suspended. To do so, the livedump uses stop_machine currently.

Causing livedump's page fault (LPF) during LPF handling results in nested
LPF handling. Since LPF handler uses spinlocks, this situation may cause
deadlock. Therefore, any pages that can be updated during LPF handling must
not be write-protected. For the same reason, any pages that can be updated
during NMI handling must not be write-protected. NMI can happen during LPF
handling, and so LPF during NMI handling also results in nested LPF
handling. I call such pages that must not be write-protected
"sensitive page". Against the sensitive pages, the handler function is
called during the stop-machine state and they are not write-protected.

I list the sensitive pages in the following:

- Kernel/Exception/Interrupt stacks
- Page table structure
- All task_struct
- ".data" section of kernel
- per_cpu areas

Pages that are not updated don't cause page fault and so the handler
function is not invoked against them. To handle these pages, the livedump
module finally needs to call the handler function against each of them.
I call this phase "sweep", which is triggered by sysfs state attribute.

Currently the pagewalk and sweep through direct-mapped addresses only but it
can already corretly handle multiple page faults from different addresses
pointing to the same physical address. To achieve this there are 2 bitmaps
which are both bound to PFN directly. One of them indicates if wrprotect is
handling addresses pointing at this PFN and second one indicates whether the
content of this PFN was already saved or not.

To support vmap area the wrprotect must correctly handle synchronization
primitives which are currently defined as static (vmap_area_lock,
free_vmap_area_lock, ...), so either export of these variables or
implementation of vmap area walk which would handle the correct synchronization
before calling the provided function is needed.

Because PTE's R/W permissions might change during all wrprotect's phases the
module needs to track these changes and correctly modify the PTE's _PAGE_SOFTW1
value which hold the value to which the current R/O permissions are then
restored to by calling the protect_pte(addr, 0).

Signed-off-by: YOSHIDA Masanori <masanori.yoshida.tv@hitachi.com>
Signed-off-by: Lukas Hruska <lhruska@suse.cz>
---
 arch/x86/Kconfig                 |  14 +
 arch/x86/include/asm/wrprotect.h |  41 ++
 arch/x86/mm/Makefile             |   2 +
 arch/x86/mm/fault.c              |   8 +
 arch/x86/mm/wrprotect.c          | 754 +++++++++++++++++++++++++++++++
 5 files changed, 819 insertions(+)
 create mode 100644 arch/x86/include/asm/wrprotect.h
 create mode 100644 arch/x86/mm/wrprotect.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3604074a878b..ef3550697be1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2448,6 +2448,20 @@ config CMDLINE_OVERRIDE
 	  This is used to work around broken boot loaders.  This should
 	  be set to 'N' under normal conditions.
 
+config WRPROTECT
+	bool "Write protection on kernel space"
+	depends on X86_64
+	help
+	  Set this option to 'Y' to allow the kernel to write protect
+	  its own memory space and to handle page fault caused by the
+	  write protection.
+
+	  This feature regularly causes small overhead on kernel.
+	  Once this feature is activated, it causes much more overhead
+	  on kernel.
+
+	  If in doubt, say N.
+
 config MODIFY_LDT_SYSCALL
 	bool "Enable the LDT (local descriptor table)" if EXPERT
 	default y
diff --git a/arch/x86/include/asm/wrprotect.h b/arch/x86/include/asm/wrprotect.h
new file mode 100644
index 000000000000..f0cb2da870c5
--- /dev/null
+++ b/arch/x86/include/asm/wrprotect.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * wrprortect.h - Kernel space write protection support
+ * Copyright (C) 2012 Hitachi, Ltd.
+ * Copyright (C) 2023 SUSE
+ * Author: YOSHIDA Masanori <masanori.yoshida.tv@hitachi.com>
+ * Author: Lukas Hruska <lhruska@suse.cz>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _WRPROTECT_H
+#define _WRPROTECT_H
+
+#include <linux/mm.h>		/* PAGE_SIZE */
+
+typedef void (*fn_handle_page_t)(unsigned long pfn, unsigned long addr, int for_sweep);
+typedef void (*fn_sm_init_t)(void);
+
+extern int wrprotect_init(
+		fn_handle_page_t fn_handle_page,
+		fn_sm_init_t fn_sm_init);
+extern void wrprotect_uninit(void);
+extern int wrprotect_start(void);
+extern int wrprotect_sweep(void);
+extern void wrprotect_unselect_pages(
+		unsigned long start,
+		unsigned long len);
+extern int wrprotect_page_fault_handler(unsigned long error_code);
+
+extern int wrprotect_is_on;
+
+#endif /* _WRPROTECT_H */
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index c80febc44cd2..795d0f202ed3 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -58,6 +58,8 @@ obj-$(CONFIG_AMD_NUMA)		+= amdtopology.o
 obj-$(CONFIG_ACPI_NUMA)		+= srat.o
 obj-$(CONFIG_NUMA_EMU)		+= numa_emulation.o
 
+obj-$(CONFIG_WRPROTECT)		+= wrprotect.o
+
 obj-$(CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS)	+= pkeys.o
 obj-$(CONFIG_RANDOMIZE_MEMORY)			+= kaslr.o
 obj-$(CONFIG_PAGE_TABLE_ISOLATION)		+= pti.o
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 7b0d4ab894c8..02752f1f78a5 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -33,6 +33,7 @@
 #include <asm/kvm_para.h>		/* kvm_handle_async_pf		*/
 #include <asm/vdso.h>			/* fixup_vdso_exception()	*/
 #include <asm/irq_stack.h>
+#include <asm/wrprotect.h>		/* wrprotect_is_on, ...		*/
 
 #define CREATE_TRACE_POINTS
 #include <asm/trace/exceptions.h>
@@ -1512,6 +1513,13 @@ handle_page_fault(struct pt_regs *regs, unsigned long error_code,
 	if (unlikely(kmmio_fault(regs, address)))
 		return;
 
+#ifdef CONFIG_WRPROTECT
+	/* only react on protection fault with write access */
+	if (unlikely(wrprotect_is_on))
+		if (wrprotect_page_fault_handler(error_code))
+			return;
+#endif /* CONFIG_WRPROTECT */
+
 	/* Was the fault on kernel-controlled part of the address space? */
 	if (unlikely(fault_in_kernel_space(address))) {
 		do_kern_addr_fault(regs, error_code, address);
diff --git a/arch/x86/mm/wrprotect.c b/arch/x86/mm/wrprotect.c
new file mode 100644
index 000000000000..534f7c133709
--- /dev/null
+++ b/arch/x86/mm/wrprotect.c
@@ -0,0 +1,754 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * wrprotect.c - Kernel space write protection support
+ * Copyright (C) 2012 Hitachi, Ltd.
+ * Copyright (C) 2023 SUSE
+ * Author: YOSHIDA Masanori <masanori.yoshida.tv@hitachi.com>
+ * Author: Lukas Hruska <lhruska@suse.cz>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <asm/wrprotect.h>
+#include <linux/mm.h>		/* __get_free_page, etc. */
+#include <linux/bitmap.h>	/* bit operations */
+#include <linux/memblock.h> /* max_pfn */
+#include <linux/vmalloc.h>	/* vzalloc, vfree */
+#include <linux/hugetlb.h>	/* __flush_tlb_all */
+#include <linux/pagewalk.h>	/* walk_page_range_novma */
+#include <linux/stop_machine.h>	/* stop_machine */
+#include <asm/sections.h>	/* __per_cpu_* */
+#include <asm/set_memory.h> /* set_memory_4k */
+#include <asm/e820/api.h>	/* e820__mapped_any */
+#include <asm/e820/types.h>	/* E820_TYPE_RAM */
+
+#define PGBMP_LEN			PAGE_ALIGN(sizeof(long) * BITS_TO_LONGS(max_pfn))
+#define DIRECT_MAP_SIZE		(1UL << MAX_PHYSMEM_BITS)
+
+enum state {
+	WRPROTECT_STATE_UNINIT,
+	WRPROTECT_STATE_INITED,
+	WRPROTECT_STATE_STARTED,
+	WRPROTECT_STATE_SWEPT,
+};
+
+/* wrprotect's stuffs */
+struct wrprotect_state {
+	enum state state;
+
+	/*
+	 * r/o bitmap after initialization
+	 * 0: there is no virt-address pointing at this pfn which
+	 *    this module ever holded
+	 * 1: there exists an virt-address pointing at this pfn which
+	 *    is wprotect interested in
+	 */
+	unsigned long *pgbmp_original;
+	/*
+	 * r/w bitmap
+	 * 0: content of this pfn was already saved
+	 * 1: content of this pfn was still not saved yet
+	 */
+	unsigned long *pgbmp_save;
+
+	fn_handle_page_t handle_page;
+	fn_sm_init_t sm_init;
+} __aligned(PAGE_SIZE);
+
+int wrprotect_is_on;
+struct wrprotect_state wrprotect_state;
+
+static int split_large_pages_walk_pud(pud_t *pud, unsigned long addr, unsigned long next,
+	struct mm_walk *walk)
+{
+	int ret = 0;
+
+	if (pud_present(*pud) && pud_large(*pud))
+		ret = set_memory_4k(addr, 1);
+	if (ret)
+		return -EFAULT;
+
+	return 0;
+}
+
+static int split_large_pages_walk_pmd(pmd_t *pmd, unsigned long addr, unsigned long next,
+	struct mm_walk *walk)
+{
+	int ret = 0;
+
+	if (pmd_present(*pmd) && pmd_large(*pmd))
+		ret = set_memory_4k(addr, 1);
+	if (ret)
+		return -EFAULT;
+
+	return 0;
+}
+
+/* split_large_pages
+ *
+ * This function splits all large pages in straight mapping area into 4K ones.
+ * Currently wrprotect supports only 4K pages, and so this is needed.
+ */
+static int split_large_pages(void)
+{
+	int ret;
+	struct mm_walk_ops split_large_pages_walk_ops;
+
+	memset(&split_large_pages_walk_ops, 0, sizeof(struct mm_walk_ops));
+	split_large_pages_walk_ops.pud_entry = split_large_pages_walk_pud;
+	split_large_pages_walk_ops.pmd_entry = split_large_pages_walk_pmd;
+
+	mmap_write_lock(&init_mm);
+	ret = walk_page_range_novma(&init_mm, PAGE_OFFSET, PAGE_OFFSET + DIRECT_MAP_SIZE,
+		&split_large_pages_walk_ops, init_mm.pgd, NULL);
+	mmap_write_unlock(&init_mm);
+
+	return 0;
+}
+
+struct sm_context {
+	int leader_cpu;
+	int leader_done;
+	int (*fn_leader)(void *arg);
+	int (*fn_follower)(void *arg);
+	void *arg;
+};
+
+static int call_leader_follower(void *data)
+{
+	int ret;
+	struct sm_context *ctx = data;
+
+	if (smp_processor_id() == ctx->leader_cpu) {
+		ret = ctx->fn_leader(ctx->arg);
+		ctx->leader_done = 1;
+	} else {
+		while (!ctx->leader_done)
+			cpu_relax();
+		ret = ctx->fn_follower(ctx->arg);
+	}
+
+	return ret;
+}
+
+/* stop_machine_leader_follower
+ *
+ * Calls stop_machine with a leader CPU and follower CPUs
+ * executing different codes.
+ * At first, the leader CPU is selected randomly and executes its code.
+ * After that, follower CPUs execute their codes.
+ */
+static int stop_machine_leader_follower(
+		int (*fn_leader)(void *),
+		int (*fn_follower)(void *),
+		void *arg)
+{
+	int cpu;
+	struct sm_context ctx;
+
+	preempt_disable();
+	cpu = smp_processor_id();
+	preempt_enable();
+
+	memset(&ctx, 0, sizeof(ctx));
+	ctx.leader_cpu = cpu;
+	ctx.leader_done = 0;
+	ctx.fn_leader = fn_leader;
+	ctx.fn_follower = fn_follower;
+	ctx.arg = arg;
+
+	return stop_machine(call_leader_follower, &ctx, cpu_online_mask);
+}
+
+/*
+ * This functions converts kernel address to it's pfn in most optimal way:
+ * direct mapping address -> __pa
+ * other address -> lookup_address -> pte_pfn
+ */
+static unsigned long kernel_address_to_pfn(unsigned long addr, int *level)
+{
+	pte_t *ptep;
+	unsigned long pfn;
+
+	if (addr >= PAGE_OFFSET && addr < PAGE_OFFSET + DIRECT_MAP_SIZE) {
+		// Direct-mapped addresses
+		pfn = __pa(addr) >> PAGE_SHIFT;
+	} else {
+		// Non-direct-mapped addresses
+		ptep = lookup_address((unsigned long)addr, level);
+		if (ptep && pte_present(*ptep))
+			pfn = pte_pfn(*ptep);
+		else
+			pfn = 0;
+	}
+
+	return pfn;
+}
+
+/* wrprotect_unselect_pages
+ *
+ * This function clears bits corresponding to pages that cover a range
+ * from start to start+len.
+ */
+void wrprotect_unselect_pages(
+		unsigned long start,
+		unsigned long len)
+{
+	unsigned long addr, pfn;
+	int level;
+
+	BUG_ON(start & ~PAGE_MASK);
+	BUG_ON(len & ~PAGE_MASK);
+
+	for (addr = start; addr < start + len; addr += PAGE_SIZE) {
+		pfn = kernel_address_to_pfn(addr, &level);
+		clear_bit(pfn, wrprotect_state.pgbmp_original);
+	}
+}
+
+/* handle_addr_range
+ *
+ * This function executes wrprotect_state.handle_page in turns against pages that
+ * cover a range from start to start+len.
+ * At the same time, it clears bits corresponding to the pages.
+ */
+static void handle_addr_range(unsigned long start, unsigned long len)
+{
+	int level;
+	unsigned long end = start + len;
+	unsigned long pfn;
+
+	start &= PAGE_MASK;
+	while (start < end) {
+		pfn = kernel_address_to_pfn(start, &level);
+		if (test_bit(pfn, wrprotect_state.pgbmp_original)) {
+			wrprotect_state.handle_page(pfn, start, 0);
+			clear_bit(pfn, wrprotect_state.pgbmp_original);
+		}
+		start += PAGE_SIZE;
+	}
+}
+
+/* handle_task
+ *
+ * This function executes handle_addr_range against task_struct & thread_info.
+ */
+static void handle_task(struct task_struct *t)
+{
+	BUG_ON(!t);
+	BUG_ON(!t->stack);
+	BUG_ON((unsigned long)t->stack & ~PAGE_MASK);
+	handle_addr_range((unsigned long)t, sizeof(*t));
+	handle_addr_range((unsigned long)t->stack, THREAD_SIZE);
+}
+
+/* handle_tasks
+ *
+ * This function executes handle_task against all tasks (including idle_task).
+ */
+static void handle_tasks(void)
+{
+	struct task_struct *p, *t;
+	unsigned int cpu;
+
+	do_each_thread(p, t) {
+		handle_task(t);
+	} while_each_thread(p, t);
+
+	for_each_online_cpu(cpu)
+		handle_task(idle_task(cpu));
+}
+
+static void handle_pmd(pmd_t *pmd)
+{
+	unsigned long i;
+
+	handle_addr_range((unsigned long)pmd, PAGE_SIZE);
+	for (i = 0; i < PTRS_PER_PMD; i++) {
+		if (pmd_present(pmd[i]) && !pmd_large(pmd[i]))
+			handle_addr_range(pmd_page_vaddr(pmd[i]), PAGE_SIZE);
+	}
+}
+
+static void handle_pud(pud_t *pud)
+{
+	unsigned long i;
+
+	handle_addr_range((unsigned long)pud, PAGE_SIZE);
+	for (i = 0; i < PTRS_PER_PUD; i++) {
+		if (pud_present(pud[i]) && !pud_large(pud[i]))
+			handle_pmd((pmd_t *)pud_pgtable(pud[i]));
+	}
+}
+
+static void handle_p4d(p4d_t *p4d)
+{
+	unsigned long i;
+
+	handle_addr_range((unsigned long)p4d, PAGE_SIZE);
+	for (i = 0; i < PTRS_PER_P4D; i++) {
+		if (p4d_present(p4d[i]))
+			handle_pud((pud_t *)p4d_pgtable(p4d[i]));
+	}
+}
+
+/* handle_page_table
+ *
+ * This function executes wrprotect_state.handle_page against all pages that make up
+ * page table structure and clears all bits corresponding to the pages.
+ */
+static void handle_page_table(void)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	unsigned long i;
+
+	pgd = init_mm.pgd;
+	handle_addr_range((unsigned long)pgd, PAGE_SIZE);
+	for (i = pgd_index(PAGE_OFFSET); i < PTRS_PER_PGD; i++) {
+		if (pgd_present(pgd[i])) {
+			if (!pgtable_l5_enabled())
+				p4d = (p4d_t *)(pgd+i);
+			else
+				p4d = (p4d_t *)pgd_page_vaddr(pgd[i]);
+			handle_p4d(p4d);
+		}
+	}
+}
+
+/* handle_sensitive_pages
+ *
+ * This function executes wrprotect_state.handle_page against the following pages and
+ * clears bits corresponding to them.
+ * - All pages that include task_struct & thread_info
+ * - All pages that make up page table structure
+ * - All pages that include per_cpu variables
+ * - All pages that cover kernel's data section
+ */
+static void handle_sensitive_pages(void)
+{
+	handle_tasks();
+	handle_page_table();
+	handle_addr_range((unsigned long)__per_cpu_offset[0], HPAGE_SIZE);
+	handle_addr_range((unsigned long)_sdata, _edata - _sdata);
+}
+
+/* protect_pte
+ *
+ * Changes a specified page's _PAGE_RW flag and _PAGE_SOFTW1 flag.
+ * If the argument protect is non-zero:
+ *  - _PAGE_RW flag is cleared
+ *  - _PAGE_SOFTW1 flag is set to original value of _PAGE_RW
+ * If the argument protect is zero:
+ *  - _PAGE_RW flag is set to _PAGE_SOFTW1
+ *
+ * The change is executed only when all the following are true.
+ *  - The page is mapped as 4K page.
+ *  - The page is originally writable.
+ *
+ * Returns 1 if the change is actually executed, otherwise returns 0.
+ */
+static int protect_pte(unsigned long addr, int protect)
+{
+	pte_t *ptep, pte;
+	unsigned int level;
+
+	ptep = lookup_address(addr, &level);
+	if (WARN(!ptep, "livedump: Page=%016lx isn't mapped.\n", addr) ||
+	    WARN(!pte_present(*ptep),
+		    "livedump: Page=%016lx isn't mapped.\n", addr) ||
+	    WARN(level == PG_LEVEL_NONE,
+		    "livedump: Page=%016lx isn't mapped.\n", addr) ||
+	    WARN(level == PG_LEVEL_2M,
+		    "livedump: Page=%016lx is consisted of 2M page.\n", addr) ||
+	    WARN(level == PG_LEVEL_1G,
+		    "livedump: Page=%016lx is consisted of 1G page.\n", addr)) {
+		return 0;
+	}
+
+	pte = *ptep;
+	if (protect) {
+		if (pte_write(pte)) {
+			pte = pte_wrprotect(pte);
+			pte = pte_set_flags(pte, _PAGE_SOFTW1);
+		} else
+			pte = pte_clear_flags(pte, _PAGE_SOFTW1);
+	} else if (pte_flags(pte) && _PAGE_SOFTW1)
+		pte = pte_mkwrite(pte);
+	*ptep = pte;
+
+	return 1;
+}
+
+/*
+ * Page fault error code bits:
+ *
+ *   bit 0 ==	 0: no page found	1: protection fault
+ *   bit 1 ==	 0: read access		1: write access
+ *   bit 2 ==	 0: kernel-mode access	1: user-mode access
+ *   bit 3 ==				1: use of reserved bit detected
+ *   bit 4 ==				1: fault was an instruction fetch
+ */
+enum x86_pf_error_code {
+	PF_PROT		=		1 << 0,
+	PF_WRITE	=		1 << 1,
+	PF_USER		=		1 << 2,
+	PF_RSVD		=		1 << 3,
+	PF_INSTR	=		1 << 4,
+};
+
+int wrprotect_page_fault_handler(unsigned long error_code)
+{
+	unsigned int level;
+	unsigned long pfn, addr;
+
+	/*
+	 * Handle only kernel-mode write access
+	 *
+	 * error_code must be:
+	 *  (1) PF_PROT
+	 *  (2) PF_WRITE
+	 *  (3) not PF_USER
+	 *  (4) not PF_RSVD
+	 *  (5) not PF_INSTR
+	 */
+	if (!(PF_PROT  & error_code) ||
+	    !(PF_WRITE & error_code) ||
+	     (PF_USER  & error_code) ||
+	     (PF_RSVD  & error_code) ||
+	     (PF_INSTR & error_code))
+		goto not_processed;
+
+	addr = (unsigned long)read_cr2();
+	addr = addr & PAGE_MASK;
+
+	if (addr >= PAGE_OFFSET && addr < PAGE_OFFSET + DIRECT_MAP_SIZE) {
+		pfn = __pa(addr) >> PAGE_SHIFT;
+	} else {
+		pfn = kernel_address_to_pfn(addr, &level);
+		if (pfn == 0 || level != PG_LEVEL_4K)
+			goto not_processed;
+	}
+
+	if (!test_bit(pfn, wrprotect_state.pgbmp_original))
+		goto not_processed;
+
+	if (test_and_clear_bit(pfn, wrprotect_state.pgbmp_save))
+		wrprotect_state.handle_page(pfn, addr, 0);
+
+	protect_pte(addr, 0);
+
+	return true;
+
+not_processed:
+	return false;
+}
+
+static int generic_page_walk_pmd(pmd_t *pmd, unsigned long addr, unsigned long next,
+	struct mm_walk *walk)
+{
+	if (WARN(pmd_large(*pmd), "livedump: Page=%016lx is consisted of 2M page.\n", addr))
+		return 0;
+
+	return 0;
+}
+
+static int sm_leader_page_walk_pte(pte_t *pte, unsigned long addr, unsigned long next,
+	struct mm_walk *walk)
+{
+	unsigned long pfn;
+
+	if (!pte || !pte_present(*pte))
+		return 0;
+
+	pfn = pte_pfn(*pte);
+
+	if (test_bit(pfn, wrprotect_state.pgbmp_original)) {
+		if (!protect_pte(addr, 1))
+			clear_bit(pfn, wrprotect_state.pgbmp_original);
+	}
+
+	return 0;
+}
+
+/* sm_leader
+ *
+ * Is executed by a leader CPU during stop-machine.
+ *
+ * This function does the following:
+ * (1)Handle pages that must not be write-protected.
+ * (2)Turn on the callback in the page fault handler.
+ * (3)Write-protect pages which are specified by the bitmap.
+ * (4)Flush TLB cache of the leader CPU.
+ */
+static int sm_leader(void *arg)
+{
+	int ret;
+	struct mm_walk_ops sm_leader_walk_ops;
+
+	memset(&sm_leader_walk_ops, 0, sizeof(struct mm_walk_ops));
+	sm_leader_walk_ops.pmd_entry = generic_page_walk_pmd;
+	sm_leader_walk_ops.pte_entry = sm_leader_page_walk_pte;
+
+	handle_sensitive_pages();
+
+	wrprotect_state.sm_init();
+
+	wrprotect_is_on = true;
+
+	mmap_write_lock(&init_mm);
+	ret = walk_page_range_novma(&init_mm, PAGE_OFFSET, PAGE_OFFSET + DIRECT_MAP_SIZE,
+	    &sm_leader_walk_ops, init_mm.pgd, NULL);
+	mmap_write_unlock(&init_mm);
+
+	if (ret)
+		return ret;
+
+	memcpy(wrprotect_state.pgbmp_save, wrprotect_state.pgbmp_original,
+			PGBMP_LEN);
+
+	__flush_tlb_all();
+
+	return 0;
+}
+
+/* sm_follower
+ *
+ * Is executed by follower CPUs during stop-machine.
+ * Flushes TLB cache of each CPU.
+ */
+static int sm_follower(void *arg)
+{
+	__flush_tlb_all();
+	return 0;
+}
+
+/* wrprotect_start
+ *
+ * This function sets up write protection on the kernel space during the
+ * stop-machine state.
+ */
+int wrprotect_start(void)
+{
+	int ret;
+
+	if (wrprotect_state.state != WRPROTECT_STATE_INITED) {
+		pr_warn("livedump: wrprotect isn't initialized yet.\n");
+		return 0;
+	}
+
+	ret = stop_machine_leader_follower(sm_leader, sm_follower, NULL);
+	if (WARN(ret, "livedump: Failed to protect pages w/errno=%d.\n", ret))
+		return ret;
+
+	wrprotect_state.state = WRPROTECT_STATE_STARTED;
+	return 0;
+}
+
+static int sweep_page_walk_pte(pte_t *pte, unsigned long addr, unsigned long next,
+	struct mm_walk *walk)
+{
+	unsigned long pfn;
+
+	if (!pte || !pte_present(*pte))
+		return 0;
+
+	pfn = pte_pfn(*pte);
+
+	if (test_and_clear_bit(pfn, wrprotect_state.pgbmp_save))
+		wrprotect_state.handle_page(pfn, addr, 1);
+	if (test_bit(pfn, wrprotect_state.pgbmp_original))
+		protect_pte(addr, 0);
+	if (!(pfn & 0xffUL))
+		cond_resched();
+
+	return 0;
+}
+
+/* wrprotect_sweep
+ *
+ * On every page specified by the bitmap, this function executes the following.
+ *  - Handle the page by calling wrprotect_state.handle_page.
+ *  - Unprotect the page by calling protect_page.
+ *
+ * The above work may be executed on the same page at the same time
+ * by the notifer-call-chain.
+ * test_and_clear_bit is used for exclusion control.
+ */
+int wrprotect_sweep(void)
+{
+	int ret;
+	struct mm_walk_ops sweep_walk_ops;
+
+	memset(&sweep_walk_ops, 0, sizeof(struct mm_walk_ops));
+	sweep_walk_ops.pmd_entry = generic_page_walk_pmd;
+	sweep_walk_ops.pte_entry = sweep_page_walk_pte;
+
+	if (wrprotect_state.state != WRPROTECT_STATE_STARTED) {
+		pr_warn("livedump: Pages aren't protected yet.\n");
+		return 0;
+	}
+
+	mmap_write_lock(&init_mm);
+	ret = walk_page_range_novma(&init_mm, PAGE_OFFSET, PAGE_OFFSET + DIRECT_MAP_SIZE,
+	    &sweep_walk_ops, init_mm.pgd, NULL);
+	mmap_write_unlock(&init_mm);
+	if (ret)
+		return ret;
+
+	wrprotect_state.state = WRPROTECT_STATE_SWEPT;
+	return 0;
+}
+
+/* wrprotect_create_page_bitmap
+ *
+ * This function creates bitmap of which each bit corresponds to physical page.
+ * Here, all ram pages are selected as being write-protected.
+ */
+static int wrprotect_create_page_bitmap(void)
+{
+	unsigned long pfn;
+
+	/* allocate on vmap area */
+	wrprotect_state.pgbmp_original = vzalloc(PGBMP_LEN);
+	if (!wrprotect_state.pgbmp_original)
+		return -ENOMEM;
+	wrprotect_state.pgbmp_save = vzalloc(PGBMP_LEN);
+	if (!wrprotect_state.pgbmp_original)
+		return -ENOMEM;
+
+	/* select all ram pages */
+	for (pfn = 0; pfn < max_pfn; pfn++) {
+		if (e820__mapped_any(pfn << PAGE_SHIFT,
+				    (pfn + 1) << PAGE_SHIFT,
+				    E820_TYPE_RAM))
+			set_bit(pfn, wrprotect_state.pgbmp_original);
+		if (!(pfn & 0xffUL))
+			cond_resched();
+	}
+
+	return 0;
+}
+
+/* wrprotect_destroy_page_bitmap
+ *
+ * This function frees both page bitmaps created by wrprotect_create_page_bitmap.
+ */
+static void wrprotect_destroy_page_bitmap(void)
+{
+	vfree(wrprotect_state.pgbmp_original);
+	vfree(wrprotect_state.pgbmp_save);
+	wrprotect_state.pgbmp_original = NULL;
+	wrprotect_state.pgbmp_save = NULL;
+}
+
+static void default_handle_page(unsigned long pfn, unsigned long addr, int for_sweep)
+{
+}
+
+/* wrprotect_init
+ *
+ * fn_handle_page:
+ *   This callback is invoked to handle faulting pages.
+ *   This function takes 3 arguments.
+ *   First one is PFN that tells where is this address physically located.
+ *   Second one is address that tells which page caused page fault.
+ *   Third one is a flag that tells whether it's called in the sweep phase.
+ */
+int wrprotect_init(fn_handle_page_t fn_handle_page, fn_sm_init_t fn_sm_init)
+{
+	int ret;
+
+	if (wrprotect_state.state != WRPROTECT_STATE_UNINIT) {
+		pr_warn("livedump: wrprotect is already initialized.\n");
+		return 0;
+	}
+
+	ret = wrprotect_create_page_bitmap();
+	if (ret < 0) {
+		pr_warn("livedump: not enough memory for wrprotect bitmaps\n");
+		return -ENOMEM;
+	}
+
+	/* split all large pages in straight mapping area */
+	ret = split_large_pages();
+	if (ret)
+		goto err;
+
+	/* unselect internal stuffs of wrprotect */
+	wrprotect_unselect_pages(
+			(unsigned long)&wrprotect_state, sizeof(wrprotect_state));
+	wrprotect_unselect_pages(
+			(unsigned long)wrprotect_state.pgbmp_original, PGBMP_LEN);
+	wrprotect_unselect_pages(
+			(unsigned long)wrprotect_state.pgbmp_save, PGBMP_LEN);
+
+	wrprotect_state.handle_page = fn_handle_page ?: default_handle_page;
+	wrprotect_state.sm_init = fn_sm_init;
+
+	wrprotect_state.state = WRPROTECT_STATE_INITED;
+	return 0;
+
+err:
+	return ret;
+}
+
+static int uninit_page_walk_pte(pte_t *pte, unsigned long addr, unsigned long next,
+	struct mm_walk *walk)
+{
+	unsigned long pfn;
+
+	if (!pte || !pte_present(*pte))
+		return 0;
+
+	pfn = pte_pfn(*pte);
+
+	if (!test_bit(pfn, wrprotect_state.pgbmp_original))
+		return 0;
+	protect_pte(addr, 0);
+	*pte = pte_clear_flags(*pte, _PAGE_SOFTW1);
+
+	if (!(pfn & 0xffUL))
+		cond_resched();
+
+	return 0;
+}
+
+void wrprotect_uninit(void)
+{
+	int ret;
+	struct mm_walk_ops uninit_walk_ops;
+
+	if (wrprotect_state.state == WRPROTECT_STATE_UNINIT)
+		return;
+
+	if (wrprotect_state.state == WRPROTECT_STATE_STARTED) {
+		memset(&uninit_walk_ops, 0, sizeof(struct mm_walk_ops));
+		uninit_walk_ops.pmd_entry = generic_page_walk_pmd;
+		uninit_walk_ops.pte_entry = uninit_page_walk_pte;
+
+		mmap_write_lock(&init_mm);
+		ret = walk_page_range_novma(&init_mm, PAGE_OFFSET, PAGE_OFFSET + DIRECT_MAP_SIZE,
+		    &uninit_walk_ops, init_mm.pgd, NULL);
+		mmap_write_unlock(&init_mm);
+
+		flush_tlb_all();
+	}
+
+	if (wrprotect_state.state >= WRPROTECT_STATE_STARTED)
+		wrprotect_is_on = false;
+
+	wrprotect_destroy_page_bitmap();
+
+	wrprotect_state.handle_page = NULL;
+	wrprotect_state.state = WRPROTECT_STATE_UNINIT;
+}
-- 
2.39.2

