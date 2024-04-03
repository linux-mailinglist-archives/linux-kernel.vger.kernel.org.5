Return-Path: <linux-kernel+bounces-130022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B27AD89734F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4FBD1C27D0C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D56D14A635;
	Wed,  3 Apr 2024 15:02:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41C814A4FF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156533; cv=none; b=SyhBU6XooknX3gRuOs07zHRVRzMh7beuuGIVNFGhqr4AGLLjwWgsfYxBrYypDjMoeQYb0qz2IA9MTNCecHKUKhtNn2Xjs0MZRI6/3zXBoQvk4CPurN2jgH0HyktAasXbtv5z5SqXkmne20yUuvU6JYsWNDiWLBjuFkhqOCHscpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156533; c=relaxed/simple;
	bh=3TQz803SJKKWWDXdmpXJtdnVe8cb7gnbBOh1swoHYpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YDabxlZjnFFywA5AoD5XMKphluFc0PVraBOvrG0HJx0t3MnqIOuA1OkRyG9UByAThMO4+mVbo9FtG/NSmcNeYM/Q9oFbi/dkJr9wlOzavyDjJPTn+rU1EFSc0ADzbaYscqVKMjFyA3oWtNHum4rroabTRbpmjAoESR+o6YgU/k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E98A1595;
	Wed,  3 Apr 2024 08:02:42 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F00113F7B4;
	Wed,  3 Apr 2024 08:02:09 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: anil.s.keshavamurthy@intel.com,
	aou@eecs.berkeley.edu,
	catalin.marinas@arm.com,
	davem@davemloft.net,
	jarkko@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	mark.rutland@arm.com,
	mhiramat@kernel.org,
	naveen.n.rao@linux.ibm.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	will@kernel.org
Subject: [PATCH v2 4/4] kprobes: Remove core dependency on modules
Date: Wed,  3 Apr 2024 16:01:54 +0100
Message-Id: <20240403150154.667649-5-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240403150154.667649-1-mark.rutland@arm.com>
References: <20240403150154.667649-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko@kernel.org>

Tracing with kprobes while running a monolithic kernel is currently
impossible because KPROBES depends on MODULES. While this dependency is
necessary when HAVE_KPROBES_ALLOC=n and the core kprobes code allocates
memory using module_alloc(), all the other module-specific code only
exist to handle the case when MODULES=y, and can be hidden behind
ifdeffery.

Add the necessary ifdeffery, and remove the dependency on MODULES=y when
HAVE_KPROBES_ALLOC=y.

As of this patch kprobes can be used when MODULES=n on arm64 and
riscv. All other architectures still depend on MODULES, either by virtue
of the core dependency on MODULES when HAVE_KPROBES_ALLOC=n, or by
virtue of an explciit dependency on MODULES in arch code.

Other architectures can enable support by implementing their own
kprobes_alloc_insn_page() and kprobes_free_insn_page() which do not
depend on MODULES.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/lkml/20240326134616.7691-1-jarkko@kernel.org/
[Mark: Remove execmem changes, depend on HAVE_KPROBES_ALLOC]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/Kconfig                |  2 +-
 kernel/kprobes.c            | 46 ++++++++++++++++++++++---------------
 kernel/trace/trace_kprobe.c | 15 ++++++++++--
 3 files changed, 41 insertions(+), 22 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 85bb59f7b8c07..0df2c88547b3c 100644
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
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index fa2ee4e59eca2..ec4493a41b505 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1594,6 +1594,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 			goto out;
 		}
 
+#ifdef CONFIG_MODULES
 		/*
 		 * If the module freed '.init.text', we couldn't insert
 		 * kprobes in there.
@@ -1604,7 +1605,9 @@ static int check_kprobe_address_safe(struct kprobe *p,
 			*probed_mod = NULL;
 			ret = -ENOENT;
 		}
+#endif /* CONFIG_MODULES */
 	}
+
 out:
 	preempt_enable();
 	jump_label_unlock();
@@ -2484,24 +2487,6 @@ int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
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
@@ -2566,6 +2551,25 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
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
@@ -2662,6 +2666,9 @@ static int kprobes_module_callback(struct notifier_block *nb,
 	mutex_unlock(&kprobe_mutex);
 	return NOTIFY_DONE;
 }
+#else
+#define kprobes_module_callback	(NULL)
+#endif /* CONFIG_MODULES */
 
 static struct notifier_block kprobe_module_nb = {
 	.notifier_call = kprobes_module_callback,
@@ -2726,7 +2733,8 @@ static int __init init_kprobes(void)
 	err = arch_init_kprobes();
 	if (!err)
 		err = register_die_notifier(&kprobe_exceptions_nb);
-	if (!err)
+
+	if (!err && IS_ENABLED(CONFIG_MODULES))
 		err = register_module_notifier(&kprobe_module_nb);
 
 	kprobes_initialized = (err == 0);
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 14099cc17fc9e..c509ba776e679 100644
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
@@ -1933,8 +1941,11 @@ static __init int init_kprobe_trace_early(void)
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
2.30.2


