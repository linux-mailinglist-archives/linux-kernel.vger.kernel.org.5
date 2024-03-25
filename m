Return-Path: <linux-kernel+bounces-117949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF0788B1B0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE491C320BF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA8E5C613;
	Mon, 25 Mar 2024 20:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmUixln5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D8A5C60D;
	Mon, 25 Mar 2024 20:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399087; cv=none; b=juGQtjE5YKn20q84ZYZk78Ct7MQKXD9ilK9Zy3e7OXk1cbFC6cQrFMUJXW6PAM2osjbmKeV9zeCWeZroJOAXHkHX+HBBK65fonlsS2VVUYd8x37kFSW06k2jeyQfmXvsPPhXGnNFXGvp5RlOfvbMzmGT3l1KP+MF6LboIAmwb/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399087; c=relaxed/simple;
	bh=O+nH8ew9YCyT1eBzJVNI7NhlU/W38tr3dfunGVakyyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U9+c+v8PGx4tIq0iqRLAi6OC5+yhRGxEqsGC2TBAgpZdLJLiiObxF1sz3qk/sfxZOf7k1Y4vYmSbcAH0WvBV3UvZgSmz2Qmz1tz0sjElhWZykQYflA2SPoQvKykZOQtGwLj4uPWYOikToTvqW6iONckIiw0vu+vCLE2ILg0V96M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmUixln5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE27C433F1;
	Mon, 25 Mar 2024 20:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711399086;
	bh=O+nH8ew9YCyT1eBzJVNI7NhlU/W38tr3dfunGVakyyQ=;
	h=From:To:Cc:Subject:Date:From;
	b=BmUixln5eSjDKD7hwgJRY3Uw7PdEicb7INTOAemawVhpepZKd89Gx+C/t245sF/LW
	 hSfVLAXMXIiJUCVluoAMrrdguBdDR+80rL9R88BzzAhMPF3R+ahSDuHw08z32t3/Ls
	 4GxNZmDp2XWbzr/GjX4AUbU2qJwb4ECOaWZAtd2Pq0I56+plTiAYnuaK+U+fC1w3k3
	 O/SFVsEQvyVNHQ5/UXgfIAkSCnqhz5xLvzGEMyB/0A5XV0DtPSSBfQy+/5C0lV/9pJ
	 BJhmrXyPeunFW36qJiLaVtyxu0x3TafJ0dphKd1Pbr7FooQlEK18dyel8qP9+kNC4R
	 j4zTmy4STZE2A==
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
Subject: [PATCH v3 1/2] kprobes: textmem API
Date: Mon, 25 Mar 2024 22:37:54 +0200
Message-ID: <20240325203755.1811-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tracing with kprobes while running a monolithic kernel is currently
impossible because CONFIG_KPROBES depends on CONFIG_MODULES because it uses
the kernel module allocator.

Introduce alloc_textmem() and free_textmem() for allocating executable
memory. If an arch implements these functions, it can mark this up with
the HAVE_ALLOC_EXECMEM kconfig flag.

At first this feature will be used for enabling kprobes without
modules support for arch/riscv.

Link: https://lore.kernel.org/all/20240325115632.04e37297491cadfbbf382767@kernel.org/
Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v3:
- A new patch added.
- For IS_DEFINED() I need advice as I could not really find that many
  locations where it would be applicable.
---
 arch/Kconfig                | 16 +++++++++++++++-
 include/linux/execmem.h     | 13 +++++++++++++
 kernel/kprobes.c            | 17 ++++++++++++++---
 kernel/trace/trace_kprobe.c | 18 ++++++++++++++++--
 4 files changed, 58 insertions(+), 6 deletions(-)
 create mode 100644 include/linux/execmem.h

diff --git a/arch/Kconfig b/arch/Kconfig
index a5af0edd3eb8..33ba68b7168f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -52,8 +52,8 @@ config GENERIC_ENTRY
 
 config KPROBES
 	bool "Kprobes"
-	depends on MODULES
 	depends on HAVE_KPROBES
+	select ALLOC_EXECMEM
 	select KALLSYMS
 	select TASKS_RCU if PREEMPTION
 	help
@@ -215,6 +215,20 @@ config HAVE_OPTPROBES
 config HAVE_KPROBES_ON_FTRACE
 	bool
 
+config HAVE_ALLOC_EXECMEM
+	bool
+	help
+	  Architectures that select this option are capable of allocating executable
+	  memory, which can be used by subsystems but is not dependent of any of its
+	  clients.
+
+config ALLOC_EXECMEM
+	bool "Executable (trampoline) memory allocation"
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
index 9d9095e81792..a1a547723c3c 100644
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
+	return alloc_execmem(PAGE_SIZE);
 }
 
 static void free_insn_page(void *page)
 {
-	module_memfree(page);
+	free_execmem(page);
 }
 
 struct kprobe_insn_cache kprobe_insn_slots = {
@@ -1580,6 +1581,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 		goto out;
 	}
 
+#ifdef CONFIG_MODULES
 	/* Check if 'p' is probing a module. */
 	*probed_mod = __module_text_address((unsigned long) p->addr);
 	if (*probed_mod) {
@@ -1603,6 +1605,8 @@ static int check_kprobe_address_safe(struct kprobe *p,
 			ret = -ENOENT;
 		}
 	}
+#endif
+
 out:
 	preempt_enable();
 	jump_label_unlock();
@@ -2482,6 +2486,7 @@ int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
 	return 0;
 }
 
+#ifdef CONFIG_MODULES
 /* Remove all symbols in given area from kprobe blacklist */
 static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
 {
@@ -2499,6 +2504,7 @@ static void kprobe_remove_ksym_blacklist(unsigned long entry)
 {
 	kprobe_remove_area_blacklist(entry, entry + 1);
 }
+#endif /* CONFIG_MODULES */
 
 int __weak arch_kprobe_get_kallsym(unsigned int *symnum, unsigned long *value,
 				   char *type, char *sym)
@@ -2564,6 +2570,7 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
 	return ret ? : arch_populate_kprobe_blacklist();
 }
 
+#ifdef CONFIG_MODULES
 static void add_module_kprobe_blacklist(struct module *mod)
 {
 	unsigned long start, end;
@@ -2665,6 +2672,7 @@ static struct notifier_block kprobe_module_nb = {
 	.notifier_call = kprobes_module_callback,
 	.priority = 0
 };
+#endif /* CONFIG_MODULES */
 
 void kprobe_free_init_mem(void)
 {
@@ -2724,8 +2732,11 @@ static int __init init_kprobes(void)
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


