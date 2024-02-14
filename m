Return-Path: <linux-kernel+bounces-65138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7887185487C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE9A3B29F78
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D076219BA2;
	Wed, 14 Feb 2024 11:36:10 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC2E19473;
	Wed, 14 Feb 2024 11:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910570; cv=none; b=E8CsBzio5PGrUusOTUkKNLQsFD+3Bxv28+O7IFpa2UwsGXr6gskRV3c6rNqYITxPo+rWp/lpRA3XjyVY4+GA0sp15ZttsL+6HCc8MWHyJo4e8pm/P7eTdwkCqCclZeKs+GJ+xDjCB/cfahxvLXZH7+qzDwz2dQdzV9UyVIIS4Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910570; c=relaxed/simple;
	bh=5vKTvZD+aG1spyEdS1uTQQ4reDy9589yJ+R2Yy1zvE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PsQZnbG7QZtXMCW7lpVSf6gbOBLP0YqJhN0KDkWc4RpDeXlyl/EWlkte24EbQSsgBYagvXnyqO8mdrzUdXqO2/OibSmS2MWprbJ122mxDOdOyti1gEHmv6Nai3+lqpsXA6ftJrD+0sYHcQOjlDD+ScXsIK4kWpN/o6VH2KPlcyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4TZbHt3kGHz9yLnQ;
	Wed, 14 Feb 2024 19:16:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 7E9F814061E;
	Wed, 14 Feb 2024 19:35:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.45.156.69])
	by APP1 (Coremail) with SMTP id LxC2BwAHshp7pcxlDJx9Ag--.51624S3;
	Wed, 14 Feb 2024 12:35:54 +0100 (CET)
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
Subject: [PATCH v1 1/8] sbm: x86: page table arch hooks
Date: Wed, 14 Feb 2024 12:35:09 +0100
Message-Id: <20240214113516.2307-2-petrtesarik@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwAHshp7pcxlDJx9Ag--.51624S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw48XrykWF1rJry3Zr1DZFb_yoWDJFW8pF
	s7AF1FgF42q3sxK397Jryv9rn8Jws7Ka1rKFZrWa45XF13tayrGF929392qr48ZrykCay5
	Ka9xtFn8Ca1UJw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmq14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIY
	CTnIWIevJa73UjIFyTuYvjfUnBT5DUUUU
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

Add arch hooks for the x86 architecture and select CONFIG_HAVE_ARCH_SBM.

Implement arch_sbm_init(): Allocate an arch-specific state page and store
it as SBM instance private data. Set up mappings for kernel text, static
data, current task and current thread stack into the.

Implement arch_sbm_map_readonly() and arch_sbm_map_writable(): Set the PTE
value, allocating additional page tables as necessary.

Implement arch_sbm_destroy(): Walk the page table hierarchy and free all
page tables, including the page global directory.

Provide a trivial implementation of arch_sbm_exec() to avoid build
failures, but do not switch to the constructed page tables yet.

Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
---
 arch/x86/Kconfig             |   1 +
 arch/x86/include/asm/sbm.h   |  29 ++++
 arch/x86/kernel/Makefile     |   2 +
 arch/x86/kernel/sbm/Makefile |  10 ++
 arch/x86/kernel/sbm/core.c   | 248 +++++++++++++++++++++++++++++++++++
 5 files changed, 290 insertions(+)
 create mode 100644 arch/x86/include/asm/sbm.h
 create mode 100644 arch/x86/kernel/sbm/Makefile
 create mode 100644 arch/x86/kernel/sbm/core.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5edec175b9bf..41fa4ab84c15 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -188,6 +188,7 @@ config X86
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if MMU && COMPAT
 	select HAVE_ARCH_COMPAT_MMAP_BASES	if MMU && COMPAT
 	select HAVE_ARCH_PREL32_RELOCATIONS
+	select HAVE_ARCH_SBM
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_STACKLEAK
diff --git a/arch/x86/include/asm/sbm.h b/arch/x86/include/asm/sbm.h
new file mode 100644
index 000000000000..01c8d357550b
--- /dev/null
+++ b/arch/x86/include/asm/sbm.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Petr Tesarik <petr.tesarik1@huawei-partners.com>
+ *
+ * SandBox Mode (SBM) declarations for the x86 architecture.
+ */
+#ifndef __ASM_SBM_H
+#define __ASM_SBM_H
+
+#if defined(CONFIG_HAVE_ARCH_SBM) && defined(CONFIG_SANDBOX_MODE)
+
+#include <asm/pgtable_types.h>
+
+/**
+ * struct x86_sbm_state - Run-time state of the environment.
+ * @pgd:         Sandbox mode page global directory.
+ *
+ * One instance of this union is allocated for each sandbox and stored as SBM
+ * instance private data.
+ */
+struct x86_sbm_state {
+	pgd_t *pgd;
+};
+
+#endif /* defined(CONFIG_HAVE_ARCH_SBM) && defined(CONFIG_SANDBOX_MODE) */
+
+#endif /* __ASM_SBM_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 0000325ab98f..4ad63b7d13ee 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -150,6 +150,8 @@ obj-$(CONFIG_X86_CET)			+= cet.o
 
 obj-$(CONFIG_X86_USER_SHADOW_STACK)	+= shstk.o
 
+obj-$(CONFIG_SANDBOX_MODE)		+= sbm/
+
 ###
 # 64 bit specific files
 ifeq ($(CONFIG_X86_64),y)
diff --git a/arch/x86/kernel/sbm/Makefile b/arch/x86/kernel/sbm/Makefile
new file mode 100644
index 000000000000..92d368b526cd
--- /dev/null
+++ b/arch/x86/kernel/sbm/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+#
+# Author: Petr Tesarik <petr.tesarik1@huawei-partners.com>
+#
+# Makefile for the x86 SandBox Mode (SBM) implementation.
+#
+
+obj-y := core.o
diff --git a/arch/x86/kernel/sbm/core.c b/arch/x86/kernel/sbm/core.c
new file mode 100644
index 000000000000..b775e3b387b1
--- /dev/null
+++ b/arch/x86/kernel/sbm/core.c
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Petr Tesarik <petr.tesarik1@huawei-partners.com>
+ *
+ * SandBox Mode (SBM) implementation for the x86 architecture.
+ */
+
+#include <asm/pgtable.h>
+#include <asm/sbm.h>
+#include <asm/sections.h>
+#include <linux/mm.h>
+#include <linux/sbm.h>
+#include <linux/sched/task_stack.h>
+
+#define GFP_SBM_PGTABLE	(GFP_KERNEL | __GFP_ZERO)
+#define PGD_ORDER	get_order(sizeof(pgd_t) * PTRS_PER_PGD)
+
+static inline phys_addr_t page_to_ptval(struct page *page)
+{
+	return PFN_PHYS(page_to_pfn(page)) | _PAGE_TABLE;
+}
+
+static int map_page(struct x86_sbm_state *state, unsigned long addr,
+		    unsigned long pfn, pgprot_t prot)
+{
+	struct page *page;
+	pgd_t *pgdp;
+	p4d_t *p4dp;
+	pud_t *pudp;
+	pmd_t *pmdp;
+	pte_t *ptep;
+
+	pgdp = pgd_offset_pgd(state->pgd, addr);
+	if (pgd_none(*pgdp)) {
+		page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+		if (!page)
+			return -ENOMEM;
+		set_pgd(pgdp, __pgd(page_to_ptval(page)));
+		p4dp = (p4d_t *)page_address(page) + p4d_index(addr);
+	} else
+		p4dp = p4d_offset(pgdp, addr);
+
+	if (p4d_none(*p4dp)) {
+		page = alloc_page(GFP_SBM_PGTABLE);
+		if (!page)
+			return -ENOMEM;
+		set_p4d(p4dp, __p4d(page_to_ptval(page)));
+		pudp = (pud_t *)page_address(page) + pud_index(addr);
+	} else
+		pudp = pud_offset(p4dp, addr);
+
+	if (pud_none(*pudp)) {
+		page = alloc_page(GFP_SBM_PGTABLE);
+		if (!page)
+			return -ENOMEM;
+		set_pud(pudp, __pud(page_to_ptval(page)));
+		pmdp = (pmd_t *)page_address(page) + pmd_index(addr);
+	} else
+		pmdp = pmd_offset(pudp, addr);
+
+	if (pmd_none(*pmdp)) {
+		page = alloc_page(GFP_SBM_PGTABLE);
+		if (!page)
+			return -ENOMEM;
+		set_pmd(pmdp, __pmd(page_to_ptval(page)));
+		ptep = (pte_t *)page_address(page) + pte_index(addr);
+	} else
+		ptep = pte_offset_kernel(pmdp, addr);
+
+	set_pte(ptep, pfn_pte(pfn, prot));
+	return 0;
+}
+
+static int map_range(struct x86_sbm_state *state, unsigned long start,
+		     unsigned long end, pgprot_t prot)
+{
+	unsigned long pfn;
+	int err;
+
+	start = PAGE_ALIGN_DOWN(start);
+	while (start < end) {
+		if (is_vmalloc_or_module_addr((void *)start))
+			pfn = vmalloc_to_pfn((void *)start);
+		else
+			pfn = PHYS_PFN(__pa(start));
+		err = map_page(state, start, pfn, prot);
+		if (err)
+			return err;
+		start += PAGE_SIZE;
+	}
+
+	return 0;
+}
+
+int arch_sbm_map_readonly(struct sbm *sbm, const struct sbm_buf *buf)
+{
+	return map_range(sbm->private, (unsigned long)buf->sbm_ptr,
+			 (unsigned long)buf->sbm_ptr + buf->size,
+			 PAGE_READONLY);
+}
+
+int arch_sbm_map_writable(struct sbm *sbm, const struct sbm_buf *buf)
+{
+	return map_range(sbm->private, (unsigned long)buf->sbm_ptr,
+			 (unsigned long)buf->sbm_ptr + buf->size,
+			 PAGE_SHARED);
+}
+
+/* Map kernel text, data, rodata, BSS and static per-cpu sections. */
+static int map_kernel(struct x86_sbm_state *state)
+{
+	int __maybe_unused cpu;
+	int err;
+
+	err = map_range(state, (unsigned long)_stext, (unsigned long)_etext,
+			PAGE_READONLY_EXEC);
+	if (err)
+		return err;
+
+	err = map_range(state, (unsigned long)__entry_text_start,
+			(unsigned long)__entry_text_end, PAGE_KERNEL_ROX);
+	if (err)
+		return err;
+
+	err = map_range(state, (unsigned long)_sdata, (unsigned long)_edata,
+			PAGE_READONLY);
+	if (err)
+		return err;
+	err = map_range(state, (unsigned long)__bss_start,
+			(unsigned long)__bss_stop, PAGE_READONLY);
+	if (err)
+		return err;
+	err = map_range(state, (unsigned long)__start_rodata,
+			(unsigned long)__end_rodata, PAGE_READONLY);
+	if (err)
+		return err;
+
+#ifdef CONFIG_SMP
+	for_each_possible_cpu(cpu) {
+		unsigned long off = per_cpu_offset(cpu);
+
+		err = map_range(state, (unsigned long)__per_cpu_start + off,
+				(unsigned long)__per_cpu_end + off,
+				PAGE_READONLY);
+		if (err)
+			return err;
+	}
+#endif
+
+	return 0;
+}
+
+int arch_sbm_init(struct sbm *sbm)
+{
+	struct x86_sbm_state *state;
+	unsigned long stack;
+	int err;
+
+	BUILD_BUG_ON(sizeof(*state) > PAGE_SIZE);
+	state = (struct x86_sbm_state *)__get_free_page(GFP_KERNEL);
+	if (!state)
+		return -ENOMEM;
+	sbm->private = state;
+
+	state->pgd = (pgd_t *)__get_free_pages(GFP_SBM_PGTABLE, PGD_ORDER);
+	if (!state->pgd)
+		return -ENOMEM;
+
+	err = map_kernel(state);
+	if (err)
+		return err;
+
+	err = map_range(state, (unsigned long)current,
+			(unsigned long)(current + 1), PAGE_READONLY);
+	if (err)
+		return err;
+
+	stack = (unsigned long)task_stack_page(current);
+	err = map_range(state, stack, stack + THREAD_SIZE, PAGE_READONLY);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static void free_pmd(pmd_t *pmd)
+{
+	pmd_t *pmdp;
+
+	for (pmdp = pmd; pmdp < pmd + PTRS_PER_PMD; ++pmdp)
+		if (!pmd_none(*pmdp))
+			free_page(pmd_page_vaddr(*pmdp));
+	if (PTRS_PER_PMD > 1)
+		free_page((unsigned long)pmd);
+}
+
+static void free_pud(pud_t *pud)
+{
+	pud_t *pudp;
+
+	for (pudp = pud; pudp < pud + PTRS_PER_PUD; ++pudp)
+		if (!pud_none(*pudp))
+			free_pmd(pmd_offset(pudp, 0));
+	if (PTRS_PER_PUD > 1)
+		free_page((unsigned long)pud);
+}
+
+static void free_p4d(p4d_t *p4d)
+{
+	p4d_t *p4dp;
+
+	for (p4dp = p4d; p4dp < p4d + PTRS_PER_P4D; ++p4dp)
+		if (!p4d_none(*p4dp))
+			free_pud(pud_offset(p4dp, 0));
+	if (PTRS_PER_P4D > 1)
+		free_page((unsigned long)p4d);
+}
+
+static void free_pgd(pgd_t *pgd)
+{
+	pgd_t *pgdp;
+
+	for (pgdp = pgd; pgdp < pgd + PTRS_PER_PGD; ++pgdp)
+		if (!pgd_none(*pgdp))
+			free_p4d(p4d_offset(pgdp, 0));
+}
+
+void arch_sbm_destroy(struct sbm *sbm)
+{
+	struct x86_sbm_state *state = sbm->private;
+
+	if (!state)
+		return;
+
+	if (state->pgd) {
+		free_pgd(state->pgd);
+		free_pages((unsigned long)state->pgd, PGD_ORDER);
+	}
+	free_page((unsigned long)state);
+	sbm->private = NULL;
+}
+
+int arch_sbm_exec(struct sbm *sbm, sbm_func func, void *args)
+{
+	return func(args);
+}
-- 
2.34.1


