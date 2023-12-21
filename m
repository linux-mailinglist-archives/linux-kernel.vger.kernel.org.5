Return-Path: <linux-kernel+bounces-7928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2514381AF59
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57E0A1C21FA6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2C711733;
	Thu, 21 Dec 2023 07:24:38 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC548D29B;
	Thu, 21 Dec 2023 07:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4Swhkz59SFz9tc8;
	Thu, 21 Dec 2023 08:24:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ulR_xm6ViK8S; Thu, 21 Dec 2023 08:24:27 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4Swhkz4YDKz9syd;
	Thu, 21 Dec 2023 08:24:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 993B38B788;
	Thu, 21 Dec 2023 08:24:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id FVzVcIjuToW3; Thu, 21 Dec 2023 08:24:27 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (PO25106.IDSI0.si.c-s.fr [192.168.232.169])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4C1C28B765;
	Thu, 21 Dec 2023 08:24:27 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Luis Chamberlain <mcgrof@kernel.org>,
	linux-modules@vger.kernel.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] module: Use set_memory_rox()
Date: Thu, 21 Dec 2023 08:24:23 +0100
Message-ID: <98d4db94f19737fe05fd811a4188ff277b83a334.1703143382.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703143462; l=2853; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=fvdEu1g3oU+npOOr1r+DfsJNfJGf1OafsTf7iK2mRkI=; b=64I5v6Hs0XBRBbSRMSfk2yP/ixtRh9tuYw2hF6AufW7WxUChiYZFUF0DakXUl16sLknSjAOHc b0CkxcIx8v6CaKDCRMyMMHyu74+FmBS64loeQ7tbfxv4j6lL1aZqZUv
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

A couple of architectures seem concerned about calling set_memory_ro()
and set_memory_x() too frequently and have implemented a version of
set_memory_rox(), see commit 60463628c9e0 ("x86/mm: Implement native
set_memory_rox()") and commit 22e99fa56443 ("s390/mm: implement
set_memory_rox()")

Use set_memory_rox() in modules when STRICT_MODULES_RWX is set.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 kernel/module/internal.h   |  2 +-
 kernel/module/main.c       |  2 +-
 kernel/module/strict_rwx.c | 12 +++++++-----
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index c8b7b4dcf782..a647ab17193d 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -324,7 +324,7 @@ static inline struct module *mod_find(unsigned long addr, struct mod_tree_root *
 
 void module_enable_ro(const struct module *mod, bool after_init);
 void module_enable_nx(const struct module *mod);
-void module_enable_x(const struct module *mod);
+void module_enable_rox(const struct module *mod);
 int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
 				char *secstrings, struct module *mod);
 
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 98fedfdb8db5..1c8f328ca015 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2735,7 +2735,7 @@ static int complete_formation(struct module *mod, struct load_info *info)
 
 	module_enable_ro(mod, false);
 	module_enable_nx(mod);
-	module_enable_x(mod);
+	module_enable_rox(mod);
 
 	/*
 	 * Mark state as coming so strong_try_module_get() ignores us,
diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
index a2b656b4e3d2..9345b09f28a5 100644
--- a/kernel/module/strict_rwx.c
+++ b/kernel/module/strict_rwx.c
@@ -26,10 +26,14 @@ static void module_set_memory(const struct module *mod, enum mod_mem_type type,
  * CONFIG_STRICT_MODULE_RWX because they are needed regardless of whether we
  * are strict.
  */
-void module_enable_x(const struct module *mod)
+void module_enable_rox(const struct module *mod)
 {
-	for_class_mod_mem_type(type, text)
-		module_set_memory(mod, type, set_memory_x);
+	for_class_mod_mem_type(type, text) {
+		if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
+			module_set_memory(mod, type, set_memory_rox);
+		else
+			module_set_memory(mod, type, set_memory_x);
+	}
 }
 
 void module_enable_ro(const struct module *mod, bool after_init)
@@ -41,8 +45,6 @@ void module_enable_ro(const struct module *mod, bool after_init)
 		return;
 #endif
 
-	module_set_memory(mod, MOD_TEXT, set_memory_ro);
-	module_set_memory(mod, MOD_INIT_TEXT, set_memory_ro);
 	module_set_memory(mod, MOD_RODATA, set_memory_ro);
 	module_set_memory(mod, MOD_INIT_RODATA, set_memory_ro);
 
-- 
2.41.0


