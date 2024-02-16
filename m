Return-Path: <linux-kernel+bounces-68222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF05685777C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3FBF1C20B57
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD961B969;
	Fri, 16 Feb 2024 08:15:06 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEC01B805;
	Fri, 16 Feb 2024 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708071306; cv=none; b=P7hdsEZ1TM/W8jLnJhX+XpZK0lIndZ3/KqSkVOidjbATztw+HpF2UGfpLXPnG7uxVs/MwNRy/EVrXMCTj8Gbzy3ol1C1BaAg/ZZlhM52Nv4Vmye1Ut8d1Yp5dqGfQ+DqYfEEkaMYQi4MMUHIjY0kKToIfAvixVBC0UwN49PSvpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708071306; c=relaxed/simple;
	bh=9GN9iBufDM+/oHP89fEYbJjbEjzPtGj8kAlRejRoEWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fyzYXKJ06v2eu214Gc1gh1/rw1b9QI0VconqyM/YOopKxhkjvEsy0u+7HhOD3sVUUikNxQPQgWgY3WuYjPOi0mgwKZhYsohvHrT518FH794bvyS+j9qm41huA6Sef9rVGogAkU9VZHq3YaD88UdmE4BCiJCInKZ56C7ui4hM+xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4Tbl8q6gv6z9tBG;
	Fri, 16 Feb 2024 09:14:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UWwJpXI0bjU3; Fri, 16 Feb 2024 09:14:51 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4Tbl8q633Lz9t0b;
	Fri, 16 Feb 2024 09:14:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CB3308B786;
	Fri, 16 Feb 2024 09:14:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id WuF13jiKnWvS; Fri, 16 Feb 2024 09:14:51 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.102])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 52ADA8B765;
	Fri, 16 Feb 2024 09:14:51 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Luis Chamberlain <mcgrof@kernel.org>,
	linux-modules@vger.kernel.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	"linux-hardening @ vger . kernel . org" <linux-hardening@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2] module: Don't ignore errors from set_memory_XX()
Date: Fri, 16 Feb 2024 09:14:27 +0100
Message-ID: <21037bf38438a285f5dff9501668f1675bc45989.1708070781.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708071268; l=6327; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=9GN9iBufDM+/oHP89fEYbJjbEjzPtGj8kAlRejRoEWg=; b=P3K6GlVBRBPXlxEvy+H6K/9xCzTD9h8+3DfVm6efkKz4SvieMaKF0/Xdr3B//ZCDOUWES9Nu4 EFuABmForTxC7yh5vGIiI6aREv22Jix23WCiyGo4JRXUYwDzWjrxPH7
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

set_memory_ro(), set_memory_nx(), set_memory_x() and other helpers
can fail and return an error. In that case the memory might not be
protected as expected and the module loading has to be aborted to
avoid security issues.

Check return value of all calls to set_memory_XX() and handle
error if any.

Add a check to not call set_memory_XX() on NULL pointers as some
architectures may not like it allthough numpages is always 0 in that
case. This also avoid a useless call to set_vm_flush_reset_perms().

Link: https://github.com/KSPP/linux/issues/7
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2:
- Bail out early from module_set_memory() when address is NULL.
- Properly clear bug list when module_set_memory() fails in complete_formation().

This patch applies on top of modules/modules-next branch
---
 kernel/module/internal.h   |  6 ++---
 kernel/module/main.c       | 20 ++++++++++++---
 kernel/module/strict_rwx.c | 51 +++++++++++++++++++++++++++-----------
 3 files changed, 55 insertions(+), 22 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 4f1b98f011da..2ebece8a789f 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -322,9 +322,9 @@ static inline struct module *mod_find(unsigned long addr, struct mod_tree_root *
 }
 #endif /* CONFIG_MODULES_TREE_LOOKUP */
 
-void module_enable_rodata_ro(const struct module *mod, bool after_init);
-void module_enable_data_nx(const struct module *mod);
-void module_enable_text_rox(const struct module *mod);
+int module_enable_rodata_ro(const struct module *mod, bool after_init);
+int module_enable_data_nx(const struct module *mod);
+int module_enable_text_rox(const struct module *mod);
 int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
 				char *secstrings, struct module *mod);
 
diff --git a/kernel/module/main.c b/kernel/module/main.c
index a9a4a4885102..689def7676c4 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2571,7 +2571,9 @@ static noinline int do_init_module(struct module *mod)
 	/* Switch to core kallsyms now init is done: kallsyms may be walking! */
 	rcu_assign_pointer(mod->kallsyms, &mod->core_kallsyms);
 #endif
-	module_enable_rodata_ro(mod, true);
+	ret = module_enable_rodata_ro(mod, true);
+	if (ret)
+		goto fail_mutex_unlock;
 	mod_tree_remove_init(mod);
 	module_arch_freeing_init(mod);
 	for_class_mod_mem_type(type, init) {
@@ -2609,6 +2611,8 @@ static noinline int do_init_module(struct module *mod)
 
 	return 0;
 
+fail_mutex_unlock:
+	mutex_unlock(&module_mutex);
 fail_free_freeinit:
 	kfree(freeinit);
 fail:
@@ -2736,9 +2740,15 @@ static int complete_formation(struct module *mod, struct load_info *info)
 	module_bug_finalize(info->hdr, info->sechdrs, mod);
 	module_cfi_finalize(info->hdr, info->sechdrs, mod);
 
-	module_enable_rodata_ro(mod, false);
-	module_enable_data_nx(mod);
-	module_enable_text_rox(mod);
+	err = module_enable_rodata_ro(mod, false);
+	if (err)
+		goto out_strict_rwx;
+	err = module_enable_data_nx(mod);
+	if (err)
+		goto out_strict_rwx;
+	err = module_enable_text_rox(mod);
+	if (err)
+		goto out_strict_rwx;
 
 	/*
 	 * Mark state as coming so strong_try_module_get() ignores us,
@@ -2749,6 +2759,8 @@ static int complete_formation(struct module *mod, struct load_info *info)
 
 	return 0;
 
+out_strict_rwx:
+	module_bug_cleanup(mod);
 out:
 	mutex_unlock(&module_mutex);
 	return err;
diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
index b36d93983465..c45caa4690e5 100644
--- a/kernel/module/strict_rwx.c
+++ b/kernel/module/strict_rwx.c
@@ -11,13 +11,16 @@
 #include <linux/set_memory.h>
 #include "internal.h"
 
-static void module_set_memory(const struct module *mod, enum mod_mem_type type,
-			      int (*set_memory)(unsigned long start, int num_pages))
+static int module_set_memory(const struct module *mod, enum mod_mem_type type,
+			     int (*set_memory)(unsigned long start, int num_pages))
 {
 	const struct module_memory *mod_mem = &mod->mem[type];
 
+	if (!mod_mem->base)
+		return 0;
+
 	set_vm_flush_reset_perms(mod_mem->base);
-	set_memory((unsigned long)mod_mem->base, mod_mem->size >> PAGE_SHIFT);
+	return set_memory((unsigned long)mod_mem->base, mod_mem->size >> PAGE_SHIFT);
 }
 
 /*
@@ -26,35 +29,53 @@ static void module_set_memory(const struct module *mod, enum mod_mem_type type,
  * CONFIG_STRICT_MODULE_RWX because they are needed regardless of whether we
  * are strict.
  */
-void module_enable_text_rox(const struct module *mod)
+int module_enable_text_rox(const struct module *mod)
 {
 	for_class_mod_mem_type(type, text) {
+		int ret;
+
 		if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
-			module_set_memory(mod, type, set_memory_rox);
+			ret = module_set_memory(mod, type, set_memory_rox);
 		else
-			module_set_memory(mod, type, set_memory_x);
+			ret = module_set_memory(mod, type, set_memory_x);
+		if (ret)
+			return ret;
 	}
+	return 0;
 }
 
-void module_enable_rodata_ro(const struct module *mod, bool after_init)
+int module_enable_rodata_ro(const struct module *mod, bool after_init)
 {
+	int ret;
+
 	if (!IS_ENABLED(CONFIG_STRICT_MODULE_RWX) || !rodata_enabled)
-		return;
+		return 0;
 
-	module_set_memory(mod, MOD_RODATA, set_memory_ro);
-	module_set_memory(mod, MOD_INIT_RODATA, set_memory_ro);
+	ret = module_set_memory(mod, MOD_RODATA, set_memory_ro);
+	if (ret)
+		return ret;
+	ret = module_set_memory(mod, MOD_INIT_RODATA, set_memory_ro);
+	if (ret)
+		return ret;
 
 	if (after_init)
-		module_set_memory(mod, MOD_RO_AFTER_INIT, set_memory_ro);
+		return module_set_memory(mod, MOD_RO_AFTER_INIT, set_memory_ro);
+
+	return 0;
 }
 
-void module_enable_data_nx(const struct module *mod)
+int module_enable_data_nx(const struct module *mod)
 {
 	if (!IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
-		return;
+		return 0;
 
-	for_class_mod_mem_type(type, data)
-		module_set_memory(mod, type, set_memory_nx);
+	for_class_mod_mem_type(type, data) {
+		int ret = module_set_memory(mod, type, set_memory_nx);
+
+		if (ret)
+			return ret;
+	}
+	return 0;
 }
 
 int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
-- 
2.43.0


