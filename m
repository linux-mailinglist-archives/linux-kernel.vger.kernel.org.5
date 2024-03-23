Return-Path: <linux-kernel+bounces-112520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B6F887B19
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 00:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFA97B213F6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 23:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64BC5BAC3;
	Sat, 23 Mar 2024 23:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COx2Wd78"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA59F1DFCE;
	Sat, 23 Mar 2024 23:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711236555; cv=none; b=agxlrBnoVG4ASX8KN2EKBAAQEvD4w+zhwQLWE0AE8AjqEjT2E+mqZJGwcH2ShvlUSfl+ibkUldZWP1xeJKHFY6pzslKtVPnVxGzt4YdVjDuL/f6aM5KAMmpaV+HNwsE7hwNcEzJALE2nK2a/kt4YAtT5i0i8m4IAOUig/M4G/SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711236555; c=relaxed/simple;
	bh=DFLXMyPmscxf4I9XqjyiNOCfh0JkCttt9htibcd+9QE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kb2a58xpmLuAXrfb7/LMeozgEKlueX7ZTNGC9ZDMmXeTl1RxOl0N4Leo6ot6aOAlnjoEgGdeb/HvrJgrVuSpJkpiTFE630AiQ9LJuxOYvavc0q4GeOVwOPkx5F3QgH5BDNyA6VSLeSKDq5yKHn1a/+GsGS26FsZ2ZFxN31KO3Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COx2Wd78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193E6C433F1;
	Sat, 23 Mar 2024 23:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711236554;
	bh=DFLXMyPmscxf4I9XqjyiNOCfh0JkCttt9htibcd+9QE=;
	h=From:To:Cc:Subject:Date:From;
	b=COx2Wd78hfLWC/f2kzH5GeOVaqNKH8iDK8CG/FVir5jZRjxgGoXAdtV4gN39ymnLZ
	 qx/h0CdhVrkaqYeat1Adec4vD/76z0EQxbehcxUo8LkkSZHmDE3qDX6h/INWf0br/Y
	 +sETpy5BMkEEAF2o4gn3PBLU8oSN38OuA2IW3NZPWiMXqScn7VeX1ptUZbOl9t137A
	 rGaaStGYPqGb1tgle2OiRdNdyVIAQjKa9nxWSo/jcz/QAI4DQqBrpCDfe7HZRLHji6
	 FDgk/7E7ewAnbKPlK879m8kP+PF0K4d/P2Xyjc6VMn0rlWKLad5nCWt9ajrkECwkg1
	 wnFmKdxWryYpA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-kernel@vger.kernel.org,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH v2] arch/riscv: Enable kprobes when CONFIG_MODULES=n
Date: Sun, 24 Mar 2024 01:29:08 +0200
Message-ID: <20240323232908.13261-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tracing with kprobes while running a monolithic kernel is currently
impossible due the kernel module allocator dependency.

Address the issue by allowing architectures to implement module_alloc()
and module_memfree() independent of the module subsystem. An arch tree
can signal this by setting HAVE_KPROBES_ALLOC in its Kconfig file.

Realize the feature on RISC-V by separating allocator to module_alloc.c
and implementing module_memfree().

Link: https://www.sochub.fi # for power on testing new SoC's with a minimal stack
Link: https://lore.kernel.org/all/20220608000014.3054333-1-jarkko@profian.com/ # continuation
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2:
- Better late than never right? :-)
- Focus only to RISC-V for now to make the patch more digestable. This
  is the arch where I use the patch on a daily basis to help with QA.
- Introduce HAVE_KPROBES_ALLOC flag to help with more gradual migration.
---
 arch/Kconfig                     |  8 +++++++-
 arch/riscv/Kconfig               |  1 +
 arch/riscv/kernel/Makefile       |  5 +++++
 arch/riscv/kernel/module.c       | 11 -----------
 arch/riscv/kernel/module_alloc.c | 28 ++++++++++++++++++++++++++++
 kernel/kprobes.c                 | 10 ++++++++++
 kernel/trace/trace_kprobe.c      | 18 ++++++++++++++++--
 7 files changed, 67 insertions(+), 14 deletions(-)
 create mode 100644 arch/riscv/kernel/module_alloc.c

diff --git a/arch/Kconfig b/arch/Kconfig
index a5af0edd3eb8..c931f1de98a7 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -52,7 +52,7 @@ config GENERIC_ENTRY
 
 config KPROBES
 	bool "Kprobes"
-	depends on MODULES
+	depends on MODULES || HAVE_KPROBES_ALLOC
 	depends on HAVE_KPROBES
 	select KALLSYMS
 	select TASKS_RCU if PREEMPTION
@@ -215,6 +215,12 @@ config HAVE_OPTPROBES
 config HAVE_KPROBES_ON_FTRACE
 	bool
 
+config HAVE_KPROBES_ALLOC
+	bool
+	help
+	  Architectures that select this option are capable of allocating memory
+	  for kprobes withou the kernel module allocator.
+
 config ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
 	bool
 	help
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e3142ce531a0..4f1b925e83d8 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -132,6 +132,7 @@ config RISCV
 	select HAVE_KPROBES if !XIP_KERNEL
 	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
 	select HAVE_KRETPROBES if !XIP_KERNEL
+	select HAVE_KPROBES_ALLOC if !XIP_KERNEL
 	# https://github.com/ClangBuiltLinux/linux/issues/1881
 	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if !LD_IS_LLD
 	select HAVE_MOVE_PMD
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 604d6bf7e476..46318194bce1 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -73,6 +73,11 @@ obj-$(CONFIG_SMP)		+= cpu_ops.o
 
 obj-$(CONFIG_RISCV_BOOT_SPINWAIT) += cpu_ops_spinwait.o
 obj-$(CONFIG_MODULES)		+= module.o
+ifeq ($(CONFIG_MODULES),y)
+obj-y				+= module_alloc.o
+else
+obj-$(CONFIG_KPROBES)		+= module_alloc.o
+endif
 obj-$(CONFIG_MODULE_SECTIONS)	+= module-sections.o
 
 obj-$(CONFIG_CPU_PM)		+= suspend_entry.o suspend.o
diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 5e5a82644451..cc324b450f2e 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -905,17 +905,6 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 	return 0;
 }
 
-#if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
-void *module_alloc(unsigned long size)
-{
-	return __vmalloc_node_range(size, 1, MODULES_VADDR,
-				    MODULES_END, GFP_KERNEL,
-				    PAGE_KERNEL, VM_FLUSH_RESET_PERMS,
-				    NUMA_NO_NODE,
-				    __builtin_return_address(0));
-}
-#endif
-
 int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *me)
diff --git a/arch/riscv/kernel/module_alloc.c b/arch/riscv/kernel/module_alloc.c
new file mode 100644
index 000000000000..3d9aa8dbca8a
--- /dev/null
+++ b/arch/riscv/kernel/module_alloc.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  Copyright (c) 2017 Zihao Yu
+ *  Copyright (c) 2024 Jarkko Sakkinen
+ */
+
+#include <linux/mm.h>
+#include <linux/moduleloader.h>
+#include <linux/vmalloc.h>
+#include <asm/sections.h>
+
+#if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
+void *module_alloc(unsigned long size)
+{
+	return __vmalloc_node_range(size, 1, MODULES_VADDR,
+				    MODULES_END, GFP_KERNEL,
+				    PAGE_KERNEL, 0, NUMA_NO_NODE,
+				    __builtin_return_address(0));
+}
+
+void module_memfree(void *module_region)
+{
+	if (in_interrupt())
+		pr_warn("In interrupt context: vmalloc may not work.\n");
+
+	vfree(module_region);
+}
+#endif
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 9d9095e81792..2c583ab6efc4 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1580,6 +1580,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 		goto out;
 	}
 
+#ifdef CONFIG_MODULES
 	/* Check if 'p' is probing a module. */
 	*probed_mod = __module_text_address((unsigned long) p->addr);
 	if (*probed_mod) {
@@ -1603,6 +1604,8 @@ static int check_kprobe_address_safe(struct kprobe *p,
 			ret = -ENOENT;
 		}
 	}
+#endif
+
 out:
 	preempt_enable();
 	jump_label_unlock();
@@ -2482,6 +2485,7 @@ int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
 	return 0;
 }
 
+#ifdef CONFIG_MODULES
 /* Remove all symbols in given area from kprobe blacklist */
 static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
 {
@@ -2499,6 +2503,7 @@ static void kprobe_remove_ksym_blacklist(unsigned long entry)
 {
 	kprobe_remove_area_blacklist(entry, entry + 1);
 }
+#endif /* CONFIG_MODULES */
 
 int __weak arch_kprobe_get_kallsym(unsigned int *symnum, unsigned long *value,
 				   char *type, char *sym)
@@ -2564,6 +2569,7 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
 	return ret ? : arch_populate_kprobe_blacklist();
 }
 
+#ifdef CONFIG_MODULES
 static void add_module_kprobe_blacklist(struct module *mod)
 {
 	unsigned long start, end;
@@ -2665,6 +2671,7 @@ static struct notifier_block kprobe_module_nb = {
 	.notifier_call = kprobes_module_callback,
 	.priority = 0
 };
+#endif /* CONFIG_MODULES */
 
 void kprobe_free_init_mem(void)
 {
@@ -2724,8 +2731,11 @@ static int __init init_kprobes(void)
 	err = arch_init_kprobes();
 	if (!err)
 		err = register_die_notifier(&kprobe_exceptions_nb);
+
+#ifdef CONFIG_MODULES
 	if (!err)
 		err = register_module_notifier(&kprobe_module_nb);
+#endif
 
 	kprobes_initialized = (err == 0);
 	kprobe_sysctls_init();
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index c4c6e0e0068b..f8fbd5e76dda 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -111,6 +111,7 @@ static nokprobe_inline bool trace_kprobe_within_module(struct trace_kprobe *tk,
 	return strncmp(module_name(mod), name, len) == 0 && name[len] == ':';
 }
 
+#ifdef CONFIG_MODULES
 static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
 {
 	char *p;
@@ -129,6 +130,7 @@ static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
 
 	return ret;
 }
+#endif /* CONFIG_MODULES */
 
 static bool trace_kprobe_is_busy(struct dyn_event *ev)
 {
@@ -608,7 +610,11 @@ static int append_trace_kprobe(struct trace_kprobe *tk, struct trace_kprobe *to)
 
 	/* Register k*probe */
 	ret = __register_trace_kprobe(tk);
-	if (ret == -ENOENT && !trace_kprobe_module_exist(tk)) {
+#ifdef CONFIG_MODULES
+	if (ret == -ENOENT && trace_kprobe_module_exist(tk))
+		ret = 0;
+#endif /* CONFIG_MODULES */
+	if (ret == -ENOENT) {
 		pr_warn("This probe might be able to register after target module is loaded. Continue.\n");
 		ret = 0;
 	}
@@ -655,7 +661,11 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
 
 	/* Register k*probe */
 	ret = __register_trace_kprobe(tk);
-	if (ret == -ENOENT && !trace_kprobe_module_exist(tk)) {
+#ifdef CONFIG_MODULES
+	if (ret == -ENOENT && trace_kprobe_module_exist(tk))
+		ret = 0;
+#endif /* CONFIG_MODULES */
+	if (ret == -ENOENT) {
 		pr_warn("This probe might be able to register after target module is loaded. Continue.\n");
 		ret = 0;
 	}
@@ -670,6 +680,7 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
 	return ret;
 }
 
+#ifdef CONFIG_MODULES
 /* Module notifier call back, checking event on the module */
 static int trace_kprobe_module_callback(struct notifier_block *nb,
 				       unsigned long val, void *data)
@@ -704,6 +715,7 @@ static struct notifier_block trace_kprobe_module_nb = {
 	.notifier_call = trace_kprobe_module_callback,
 	.priority = 1	/* Invoked after kprobe module callback */
 };
+#endif /* CONFIG_MODULES */
 
 static int count_symbols(void *data, unsigned long unused)
 {
@@ -1897,8 +1909,10 @@ static __init int init_kprobe_trace_early(void)
 	if (ret)
 		return ret;
 
+#ifdef CONFIG_MODULES
 	if (register_module_notifier(&trace_kprobe_module_nb))
 		return -EINVAL;
+#endif /* CONFIG_MODULES */
 
 	return 0;
 }
-- 
2.44.0


