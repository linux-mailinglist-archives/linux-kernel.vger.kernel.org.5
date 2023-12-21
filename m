Return-Path: <linux-kernel+bounces-7929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A562181AF5B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D58C71C2167A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5EE156CB;
	Thu, 21 Dec 2023 07:24:41 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08C9154B1;
	Thu, 21 Dec 2023 07:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4Swhl00jRsz9v53;
	Thu, 21 Dec 2023 08:24:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yYf08Ml6v6m5; Thu, 21 Dec 2023 08:24:28 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4Swhl005W9z9syd;
	Thu, 21 Dec 2023 08:24:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id F34738B78B;
	Thu, 21 Dec 2023 08:24:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Y0itt8VriYQB; Thu, 21 Dec 2023 08:24:27 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (PO25106.IDSI0.si.c-s.fr [192.168.232.169])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 9F0148B765;
	Thu, 21 Dec 2023 08:24:27 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Luis Chamberlain <mcgrof@kernel.org>,
	linux-modules@vger.kernel.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] module: Change module_enable_{nx/x/ro}() to more explicit names
Date: Thu, 21 Dec 2023 08:24:24 +0100
Message-ID: <fc3a0c1d2254a85bc50693c265b5b1ddbb34ca30.1703143382.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <98d4db94f19737fe05fd811a4188ff277b83a334.1703143382.git.christophe.leroy@csgroup.eu>
References: <98d4db94f19737fe05fd811a4188ff277b83a334.1703143382.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703143462; l=3472; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=QFcBndRL8VAEfnsHhYaocMTU1i5wqmmzuLoeFYit1jY=; b=mmMFRfmWA3N5AicawGZ2q8ic238QubUvcwoK3wBNSpTd4IzuWi+BuY8efN1QsoMzFWMTQdjGD Z0nhzzvU2EFBQqK2TTwA+X7L4M0flrwFwHygqSAe2b6YX4bjL00i2Qq
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

It's a bit puzzling to see a call to module_enable_nx() followed by a
call to module_enable_x(). This is because one applies on text while
the other applies on data.

Change name to make that more clear.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 kernel/module/internal.h   | 6 +++---
 kernel/module/main.c       | 8 ++++----
 kernel/module/strict_rwx.c | 6 +++---
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index a647ab17193d..4f1b98f011da 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -322,9 +322,9 @@ static inline struct module *mod_find(unsigned long addr, struct mod_tree_root *
 }
 #endif /* CONFIG_MODULES_TREE_LOOKUP */
 
-void module_enable_ro(const struct module *mod, bool after_init);
-void module_enable_nx(const struct module *mod);
-void module_enable_rox(const struct module *mod);
+void module_enable_rodata_ro(const struct module *mod, bool after_init);
+void module_enable_data_nx(const struct module *mod);
+void module_enable_text_rox(const struct module *mod);
 int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
 				char *secstrings, struct module *mod);
 
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 1c8f328ca015..64662e55e275 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2568,7 +2568,7 @@ static noinline int do_init_module(struct module *mod)
 	/* Switch to core kallsyms now init is done: kallsyms may be walking! */
 	rcu_assign_pointer(mod->kallsyms, &mod->core_kallsyms);
 #endif
-	module_enable_ro(mod, true);
+	module_enable_rodata_ro(mod, true);
 	mod_tree_remove_init(mod);
 	module_arch_freeing_init(mod);
 	for_class_mod_mem_type(type, init) {
@@ -2733,9 +2733,9 @@ static int complete_formation(struct module *mod, struct load_info *info)
 	module_bug_finalize(info->hdr, info->sechdrs, mod);
 	module_cfi_finalize(info->hdr, info->sechdrs, mod);
 
-	module_enable_ro(mod, false);
-	module_enable_nx(mod);
-	module_enable_rox(mod);
+	module_enable_rodata_ro(mod, false);
+	module_enable_data_nx(mod);
+	module_enable_text_rox(mod);
 
 	/*
 	 * Mark state as coming so strong_try_module_get() ignores us,
diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
index 9345b09f28a5..9b2d58a8d59d 100644
--- a/kernel/module/strict_rwx.c
+++ b/kernel/module/strict_rwx.c
@@ -26,7 +26,7 @@ static void module_set_memory(const struct module *mod, enum mod_mem_type type,
  * CONFIG_STRICT_MODULE_RWX because they are needed regardless of whether we
  * are strict.
  */
-void module_enable_rox(const struct module *mod)
+void module_enable_text_rox(const struct module *mod)
 {
 	for_class_mod_mem_type(type, text) {
 		if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
@@ -36,7 +36,7 @@ void module_enable_rox(const struct module *mod)
 	}
 }
 
-void module_enable_ro(const struct module *mod, bool after_init)
+void module_enable_rodata_ro(const struct module *mod, bool after_init)
 {
 	if (!IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
 		return;
@@ -52,7 +52,7 @@ void module_enable_ro(const struct module *mod, bool after_init)
 		module_set_memory(mod, MOD_RO_AFTER_INIT, set_memory_ro);
 }
 
-void module_enable_nx(const struct module *mod)
+void module_enable_data_nx(const struct module *mod)
 {
 	if (!IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
 		return;
-- 
2.41.0


