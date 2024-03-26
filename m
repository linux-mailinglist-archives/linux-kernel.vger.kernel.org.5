Return-Path: <linux-kernel+bounces-119481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 963C988C982
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DBF0324F13
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3981CFA0;
	Tue, 26 Mar 2024 16:36:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3151CD31
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471009; cv=none; b=H23R/jjMsZQIouhguRFLW+BATNH8k899cS8YA47GL/eBm3XH5QjbBUL5W1bRgEd7DbRdsISSIieSngFfb6tek9+zZNU8Prs+3i3ogmtBaz3bCh2OgMoOjQy86UlHnBInMWbN0W1pmO/4ggIwOCpg3NWGii36VoysGYSQQdJcAGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471009; c=relaxed/simple;
	bh=73nytPs1DC6qdn9JiVobsO0hPD+TdOEHuR2bX1aCIZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xjdj77pu6/Q9IRaJgB5oKNVZfVpu6DEDoiobIaGTtz4Z7SAM7uJuhoz0bN+V7Yay+m8Evt3fKFcFEdlkhNNrb+mM2qOML57/RWIYyMKlpJY8l9luGlYcbM8kIRYnuS0ZyL4HhYMQxL5nstyTMdwPu+66DBwVpLPrNHKgjuKcbWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5D101516;
	Tue, 26 Mar 2024 09:37:20 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 742E03F694;
	Tue, 26 Mar 2024 09:36:44 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: agordeev@linux.ibm.com,
	anil.s.keshavamurthy@intel.com,
	aou@eecs.berkeley.edu,
	bp@alien8.de,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	davem@davemloft.net,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	jarkko@kernel.org,
	jcalvinowens@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	mark.rutland@arm.com,
	mhiramat@kernel.org,
	mingo@redhat.com,
	mpe@ellerman.id.au,
	naveen.n.rao@linux.ibm.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	tglx@linutronix.de,
	will@kernel.org
Subject: [PATCH 4/4] kprobes: Remove core dependency on modules
Date: Tue, 26 Mar 2024 16:36:24 +0000
Message-Id: <20240326163624.3253157-5-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240326163624.3253157-1-mark.rutland@arm.com>
References: <20240326163624.3253157-1-mark.rutland@arm.com>
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
necessary when KPROBES_USE_MODULE_ALLOC=y, all the other module-specific
code only exist to handle the case when MODULES=y, and can be hidden
behind ifdeffery.

Add the necessary ifdeffery, and remove the dependency on MODULES=N when
KPROBES_USE_MODULE_ALLOC=n.

Currently this allows kprobes to be used when CONFIG_MODULES=n on arm64
and riscv, and other architectures can enable support by implementing
their own kprobes_alloc_insn_page() and kprobes_free_insn_page() which
do not depend on MODULES.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/all/20240326012102.27438-1-jarkko@kernel.org/
[Mark: Remove execmem changes, depend on !KPROBES_USE_MODULE_ALLOC]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
---
 arch/Kconfig                |  2 +-
 kernel/kprobes.c            | 12 +++++++++++-
 kernel/trace/trace_kprobe.c | 15 +++++++++++++--
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 85bb59f7b8c07..cf43de9ffb5b9 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -52,7 +52,7 @@ config GENERIC_ENTRY
 
 config KPROBES
 	bool "Kprobes"
-	depends on MODULES
+	depends on MODULES || !KPROBES_USE_MODULE_ALLOC
 	depends on HAVE_KPROBES
 	select KALLSYMS
 	select TASKS_RCU if PREEMPTION
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index fa2ee4e59eca2..7c2f0b504cdcb 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1582,6 +1582,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 		goto out;
 	}
 
+#ifdef CONFIG_MODULES
 	/* Check if 'p' is probing a module. */
 	*probed_mod = __module_text_address((unsigned long) p->addr);
 	if (*probed_mod) {
@@ -1605,6 +1606,8 @@ static int check_kprobe_address_safe(struct kprobe *p,
 			ret = -ENOENT;
 		}
 	}
+#endif
+
 out:
 	preempt_enable();
 	jump_label_unlock();
@@ -2484,6 +2487,7 @@ int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
 	return 0;
 }
 
+#ifdef CONFIG_MODULES
 /* Remove all symbols in given area from kprobe blacklist */
 static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
 {
@@ -2501,6 +2505,7 @@ static void kprobe_remove_ksym_blacklist(unsigned long entry)
 {
 	kprobe_remove_area_blacklist(entry, entry + 1);
 }
+#endif /* CONFIG_MODULES */
 
 int __weak arch_kprobe_get_kallsym(unsigned int *symnum, unsigned long *value,
 				   char *type, char *sym)
@@ -2566,6 +2571,7 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
 	return ret ? : arch_populate_kprobe_blacklist();
 }
 
+#ifdef CONFIG_MODULES
 static void add_module_kprobe_blacklist(struct module *mod)
 {
 	unsigned long start, end;
@@ -2662,6 +2668,9 @@ static int kprobes_module_callback(struct notifier_block *nb,
 	mutex_unlock(&kprobe_mutex);
 	return NOTIFY_DONE;
 }
+#else
+#define kprobes_module_callback	(NULL)
+#endif /* CONFIG_MODULES */
 
 static struct notifier_block kprobe_module_nb = {
 	.notifier_call = kprobes_module_callback,
@@ -2726,7 +2735,8 @@ static int __init init_kprobes(void)
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


