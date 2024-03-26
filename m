Return-Path: <linux-kernel+bounces-119090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EDF88C40E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFFB81F644C5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BF37603B;
	Tue, 26 Mar 2024 13:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpxQFntW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF94D74E03;
	Tue, 26 Mar 2024 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711460783; cv=none; b=FhAGu6xqy6VpItjDuV3Zv4uppkmeo+biO/R1ts6gZaRwYRjNO77k0IKTekEbGmwWzw+jRELkUSzlPjX6iLeXB7Y4wK1L5al0tYY5kwqCFQSo/+5SEKGPeHsEL+B1ljBCvVAYuKsqgNSsJ+G+S1dbFsUWfLhcdKv8mpHCB047zbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711460783; c=relaxed/simple;
	bh=ugt+lztfZImTcLV110+ASPrYHSzYzE7PXstsMv1vj9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XoqdrgHVY0ovliijkzIhi7O3Jud/68RYC073igHoubEvKnrxluElPKpQqDbjYeDB+IiHXWn1ZdlEBB7OPwo2HKfUKkWrqfKEYDtGfZRfw6CDeWmQyB6itLHEgCRb+mLxndHt6ipryZONxBAu5kRF4MKmwL334bclVAayyRLuNGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpxQFntW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C041AC433C7;
	Tue, 26 Mar 2024 13:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711460783;
	bh=ugt+lztfZImTcLV110+ASPrYHSzYzE7PXstsMv1vj9U=;
	h=From:To:Cc:Subject:Date:From;
	b=kpxQFntWmz3pr7aqv9r2hBAx2cZ8EW4VSedwbAjxCmDyH6hpsuLCZTwPpB/nb4yPa
	 +GrJDt8/3ZWpFuDEgCIzzsHfdOvTE/7gr84g7BLQ/fOBRuyU+s2YLg/ItFTD96cGUf
	 9R7MxzmbhqD2NyyWdo5JB2r089+Wh7rnHKSCtDpFlcccSCyvcLTv44aUq3NPeIAnof
	 +yJJ938VU/ujNNnBB3gdG9FD40iMVTFq/LfmR0hqE4b228TPbbPvGFZL26ZXw6f9yw
	 T3C3XhJ7d0nVTNgeDdxxLWLwDUGPlc1rdevvmcdISZB+f6/KK86OYsXpyJ7FJ2MI0C
	 CQzxfwXLZtHgg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-kernel@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-modules@vger.kernel.org,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH v7 1/2] kprobes: Implement trampoline memory allocator for tracing
Date: Tue, 26 Mar 2024 15:46:15 +0200
Message-ID: <20240326134616.7691-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tracing with kprobes while running a monolithic kernel is currently
impossible because CONFIG_KPROBES depends on CONFIG_MODULES.

Introduce alloc_execmem() and free_execmem() for allocating executable
memory. If an arch implements these functions, it can mark this up with
the HAVE_ALLOC_EXECMEM kconfig flag.

The second new kconfig flag is ALLOC_EXECMEM, which can be selected if
either MODULES is selected or HAVE_ALLOC_EXECMEM is support by the arch. If
HAVE_ALLOC_EXECMEM is not supported by an arch, module_alloc() and
module_memfree() are used as a fallback, thus retaining backwards
compatibility to earlier kernel versions.

This will allow architecture to enable kprobes traces without requiring
to enable module.

The support can be implemented with four easy steps:

1. Implement alloc_execmem().
2. Implement free_execmem().
3. Edit arch/<arch>/Makefile.
4. Set HAVE_ALLOC_EXECMEM in arch/<arch>/Kconfig.

Link: https://lore.kernel.org/all/20240325115632.04e37297491cadfbbf382767@kernel.org/
Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v7:
- Use "depends on" for ALLOC_EXECMEM instead of "select"
- Reduced and narrowed CONFIG_MODULES checks further in kprobes.c.
v6:
- Use null pointer for notifiers and register the module notifier only if
  IS_ENABLED(CONFIG_MODULES) is set.
- Fixed typo in the commit message and wrote more verbose description
  of the feature.
v5:
- alloc_execmem() was missing GFP_KERNEL parameter. The patch set did
  compile because 2/2 had the fixup (leaked there when rebasing the
  patch set).
v4:
- Squashed a couple of unrequired CONFIG_MODULES checks.
- See https://lore.kernel.org/all/D034M18D63EC.2Y11D954YSZYK@kernel.org/
v3:
- A new patch added.
- For IS_DEFINED() I need advice as I could not really find that many
  locations where it would be applicable.
---
 arch/Kconfig                | 17 +++++++++++-
 include/linux/execmem.h     | 13 +++++++++
 kernel/kprobes.c            | 53 ++++++++++++++++++++++---------------
 kernel/trace/trace_kprobe.c | 15 +++++++++--
 4 files changed, 73 insertions(+), 25 deletions(-)
 create mode 100644 include/linux/execmem.h

diff --git a/arch/Kconfig b/arch/Kconfig
index a5af0edd3eb8..5e9735f60f3c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -52,8 +52,8 @@ config GENERIC_ENTRY
 
 config KPROBES
 	bool "Kprobes"
-	depends on MODULES
 	depends on HAVE_KPROBES
+	depends on ALLOC_EXECMEM
 	select KALLSYMS
 	select TASKS_RCU if PREEMPTION
 	help
@@ -215,6 +215,21 @@ config HAVE_OPTPROBES
 config HAVE_KPROBES_ON_FTRACE
 	bool
 
+config HAVE_ALLOC_EXECMEM
+	bool
+	help
+	  Architectures that select this option are capable of allocating trampoline
+	  executable memory for tracing subsystems, indepedently of the kernel module
+	  subsystem.
+
+config ALLOC_EXECMEM
+	bool "Executable (trampoline) memory allocation"
+	default y
+	depends on MODULES || HAVE_ALLOC_EXECMEM
+	help
+	  Select this for executable (trampoline) memory. Can be enabled when either
+	  module allocator or arch-specific allocator is available.
+
 config ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
 	bool
 	help
diff --git a/include/linux/execmem.h b/include/linux/execmem.h
new file mode 100644
index 000000000000..ae2ff151523a
--- /dev/null
+++ b/include/linux/execmem.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_EXECMEM_H
+#define _LINUX_EXECMEM_H
+
+#ifdef CONFIG_HAVE_ALLOC_EXECMEM
+void *alloc_execmem(unsigned long size, gfp_t gfp);
+void free_execmem(void *region);
+#else
+#define alloc_execmem(size, gfp)	module_alloc(size)
+#define free_execmem(region)		module_memfree(region)
+#endif
+
+#endif /* _LINUX_EXECMEM_H */
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 9d9095e81792..13bef5de315c 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -44,6 +44,7 @@
 #include <asm/cacheflush.h>
 #include <asm/errno.h>
 #include <linux/uaccess.h>
+#include <linux/execmem.h>
 
 #define KPROBE_HASH_BITS 6
 #define KPROBE_TABLE_SIZE (1 << KPROBE_HASH_BITS)
@@ -113,17 +114,17 @@ enum kprobe_slot_state {
 void __weak *alloc_insn_page(void)
 {
 	/*
-	 * Use module_alloc() so this page is within +/- 2GB of where the
+	 * Use alloc_execmem() so this page is within +/- 2GB of where the
 	 * kernel image and loaded module images reside. This is required
 	 * for most of the architectures.
 	 * (e.g. x86-64 needs this to handle the %rip-relative fixups.)
 	 */
-	return module_alloc(PAGE_SIZE);
+	return alloc_execmem(PAGE_SIZE, GFP_KERNEL);
 }
 
 static void free_insn_page(void *page)
 {
-	module_memfree(page);
+	free_execmem(page);
 }
 
 struct kprobe_insn_cache kprobe_insn_slots = {
@@ -1592,6 +1593,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 			goto out;
 		}
 
+#ifdef CONFIG_MODULES
 		/*
 		 * If the module freed '.init.text', we couldn't insert
 		 * kprobes in there.
@@ -1602,7 +1604,9 @@ static int check_kprobe_address_safe(struct kprobe *p,
 			*probed_mod = NULL;
 			ret = -ENOENT;
 		}
+#endif /* CONFIG_MODULES */
 	}
+
 out:
 	preempt_enable();
 	jump_label_unlock();
@@ -2482,24 +2486,6 @@ int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
 	return 0;
 }
 
-/* Remove all symbols in given area from kprobe blacklist */
-static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
-{
-	struct kprobe_blacklist_entry *ent, *n;
-
-	list_for_each_entry_safe(ent, n, &kprobe_blacklist, list) {
-		if (ent->start_addr < start || ent->start_addr >= end)
-			continue;
-		list_del(&ent->list);
-		kfree(ent);
-	}
-}
-
-static void kprobe_remove_ksym_blacklist(unsigned long entry)
-{
-	kprobe_remove_area_blacklist(entry, entry + 1);
-}
-
 int __weak arch_kprobe_get_kallsym(unsigned int *symnum, unsigned long *value,
 				   char *type, char *sym)
 {
@@ -2564,6 +2550,25 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
 	return ret ? : arch_populate_kprobe_blacklist();
 }
 
+#ifdef CONFIG_MODULES
+/* Remove all symbols in given area from kprobe blacklist */
+static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
+{
+	struct kprobe_blacklist_entry *ent, *n;
+
+	list_for_each_entry_safe(ent, n, &kprobe_blacklist, list) {
+		if (ent->start_addr < start || ent->start_addr >= end)
+			continue;
+		list_del(&ent->list);
+		kfree(ent);
+	}
+}
+
+static void kprobe_remove_ksym_blacklist(unsigned long entry)
+{
+	kprobe_remove_area_blacklist(entry, entry + 1);
+}
+
 static void add_module_kprobe_blacklist(struct module *mod)
 {
 	unsigned long start, end;
@@ -2660,6 +2665,9 @@ static int kprobes_module_callback(struct notifier_block *nb,
 	mutex_unlock(&kprobe_mutex);
 	return NOTIFY_DONE;
 }
+#else
+#define kprobes_module_callback	(NULL)
+#endif /* CONFIG_MODULES */
 
 static struct notifier_block kprobe_module_nb = {
 	.notifier_call = kprobes_module_callback,
@@ -2724,7 +2732,8 @@ static int __init init_kprobes(void)
 	err = arch_init_kprobes();
 	if (!err)
 		err = register_die_notifier(&kprobe_exceptions_nb);
-	if (!err)
+
+	if (!err && IS_ENABLED(CONFIG_MODULES))
 		err = register_module_notifier(&kprobe_module_nb);
 
 	kprobes_initialized = (err == 0);
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index c4c6e0e0068b..13ea0d0994d5 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -111,6 +111,7 @@ static nokprobe_inline bool trace_kprobe_within_module(struct trace_kprobe *tk,
 	return strncmp(module_name(mod), name, len) == 0 && name[len] == ':';
 }
 
+#ifdef CONFIG_MODULES
 static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
 {
 	char *p;
@@ -129,6 +130,9 @@ static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
 
 	return ret;
 }
+#else
+#define trace_kprobe_module_exist(tk) false /* aka a module never exists */
+#endif /* CONFIG_MODULES */
 
 static bool trace_kprobe_is_busy(struct dyn_event *ev)
 {
@@ -670,6 +674,7 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
 	return ret;
 }
 
+#ifdef CONFIG_MODULES
 /* Module notifier call back, checking event on the module */
 static int trace_kprobe_module_callback(struct notifier_block *nb,
 				       unsigned long val, void *data)
@@ -699,6 +704,9 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
 
 	return NOTIFY_DONE;
 }
+#else
+#define trace_kprobe_module_callback (NULL)
+#endif /* CONFIG_MODULES */
 
 static struct notifier_block trace_kprobe_module_nb = {
 	.notifier_call = trace_kprobe_module_callback,
@@ -1897,8 +1905,11 @@ static __init int init_kprobe_trace_early(void)
 	if (ret)
 		return ret;
 
-	if (register_module_notifier(&trace_kprobe_module_nb))
-		return -EINVAL;
+	if (IS_ENABLED(CONFIG_MODULES)) {
+		ret = register_module_notifier(&trace_kprobe_module_nb);
+		if (ret)
+			return -EINVAL;
+	}
 
 	return 0;
 }
-- 
2.44.0


