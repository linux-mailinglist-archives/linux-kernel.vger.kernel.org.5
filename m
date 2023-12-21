Return-Path: <linux-kernel+bounces-7930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D0681AF5E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5CB61C21242
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EFA11737;
	Thu, 21 Dec 2023 07:24:46 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA3E15AE9;
	Thu, 21 Dec 2023 07:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4Swhl16bdKz9v7S;
	Thu, 21 Dec 2023 08:24:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yer27FJBrBxH; Thu, 21 Dec 2023 08:24:29 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4Swhl02G7Qz9syd;
	Thu, 21 Dec 2023 08:24:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4A2AD8B765;
	Thu, 21 Dec 2023 08:24:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id I1ETZd44Eo2D; Thu, 21 Dec 2023 08:24:28 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (PO25106.IDSI0.si.c-s.fr [192.168.232.169])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id EBC488B788;
	Thu, 21 Dec 2023 08:24:27 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Luis Chamberlain <mcgrof@kernel.org>,
	linux-modules@vger.kernel.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] module: Don't ignore errors from set_memory_XX()
Date: Thu, 21 Dec 2023 08:24:25 +0100
Message-ID: <90d6698d32841ac15f6616d7bf02b0b488b867c9.1703143382.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <98d4db94f19737fe05fd811a4188ff277b83a334.1703143382.git.christophe.leroy@csgroup.eu>
References: <98d4db94f19737fe05fd811a4188ff277b83a334.1703143382.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703143462; l=5572; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=B8NSNulQUqM9b0rkRsYEGn1/i1x8QVDr7Mrn6+JIkQg=; b=TQ7EyGle6pMMnVsDoXKuRCK4fpTgrpKnPKETBVY84COsP6nQUkXnvKm3NLIw/5oNZx/CDBLPD PXDO1TPTXLlBLLxOvlo7zqu/zpvZWkKe4y9fWDx1T4pwXwBrqHP6a0Y
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

set_memory_ro(), set_memory_nx(), set_memory_x() and other helps
can fail an return an error. In that case the memory might not be
protected as expected and the module loading has to be aborted to
avoid security issues.

Check return value of all calls to set_memory_XX() and handle
error if any.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 kernel/module/internal.h   |  6 ++---
 kernel/module/main.c       | 18 ++++++++++----
 kernel/module/strict_rwx.c | 48 ++++++++++++++++++++++++++------------
 3 files changed, 50 insertions(+), 22 deletions(-)

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
index 64662e55e275..cfe197455d64 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2568,7 +2568,9 @@ static noinline int do_init_module(struct module *mod)
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
@@ -2606,6 +2608,8 @@ static noinline int do_init_module(struct module *mod)
 
 	return 0;
 
+fail_mutex_unlock:
+	mutex_unlock(&module_mutex);
 fail_free_freeinit:
 	kfree(freeinit);
 fail:
@@ -2733,9 +2737,15 @@ static int complete_formation(struct module *mod, struct load_info *info)
 	module_bug_finalize(info->hdr, info->sechdrs, mod);
 	module_cfi_finalize(info->hdr, info->sechdrs, mod);
 
-	module_enable_rodata_ro(mod, false);
-	module_enable_data_nx(mod);
-	module_enable_text_rox(mod);
+	err = module_enable_rodata_ro(mod, false);
+	if (err)
+		goto out;
+	err = module_enable_data_nx(mod);
+	if (err)
+		goto out;
+	err = module_enable_text_rox(mod);
+	if (err)
+		goto out;
 
 	/*
 	 * Mark state as coming so strong_try_module_get() ignores us,
diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
index 9b2d58a8d59d..a14df9655dbe 100644
--- a/kernel/module/strict_rwx.c
+++ b/kernel/module/strict_rwx.c
@@ -11,13 +11,13 @@
 #include <linux/set_memory.h>
 #include "internal.h"
 
-static void module_set_memory(const struct module *mod, enum mod_mem_type type,
+static int module_set_memory(const struct module *mod, enum mod_mem_type type,
 			      int (*set_memory)(unsigned long start, int num_pages))
 {
 	const struct module_memory *mod_mem = &mod->mem[type];
 
 	set_vm_flush_reset_perms(mod_mem->base);
-	set_memory((unsigned long)mod_mem->base, mod_mem->size >> PAGE_SHIFT);
+	return set_memory((unsigned long)mod_mem->base, mod_mem->size >> PAGE_SHIFT);
 }
 
 /*
@@ -26,39 +26,57 @@ static void module_set_memory(const struct module *mod, enum mod_mem_type type,
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
 	if (!IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
-		return;
+		return 0;
 #ifdef CONFIG_STRICT_MODULE_RWX
 	if (!rodata_enabled)
-		return;
+		return 0;
 #endif
 
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
+
+	for_class_mod_mem_type(type, data) {
+		int ret = module_set_memory(mod, type, set_memory_nx);
 
-	for_class_mod_mem_type(type, data)
-		module_set_memory(mod, type, set_memory_nx);
+		if (ret)
+			return ret;
+	}
+	return 0;
 }
 
 int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
-- 
2.41.0


