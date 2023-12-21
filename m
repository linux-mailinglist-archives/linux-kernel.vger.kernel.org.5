Return-Path: <linux-kernel+bounces-8056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B040981B1BA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655DD1F23E5D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82C84BAAA;
	Thu, 21 Dec 2023 09:03:40 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CED64C3B9;
	Thu, 21 Dec 2023 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4SwkxN5mzlz9v53;
	Thu, 21 Dec 2023 10:03:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tm02GcTpcMgN; Thu, 21 Dec 2023 10:03:36 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4Swkwl2gZCz9v9j;
	Thu, 21 Dec 2023 10:03:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 547208B788;
	Thu, 21 Dec 2023 10:03:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id g2LunAC6MO_5; Thu, 21 Dec 2023 10:03:03 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (PO25106.IDSI0.si.c-s.fr [192.168.232.169])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DB8878B765;
	Thu, 21 Dec 2023 10:03:02 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Luis Chamberlain <mcgrof@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-modules@vger.kernel.org
Subject: [PATCH 1/3] init: Declare rodata_enabled and mark_rodata_ro() at all time
Date: Thu, 21 Dec 2023 10:02:46 +0100
Message-ID: <7b5df1782e94a755b4a18733af44d17d8dd8b37b.1703149011.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703149365; l=2195; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=/AIa48/U2JNmUZJkGyrwlJh42cfDMW1BNtC2uinCoaY=; b=LrnKh2JOl5Cp+V1qOy+g9kRkNM6HoOyag17kloED7mt/LyBc2hyuX4Up/SKP6y038By7URw0z /xyreKV1/AzDtiLswENNb9DcheB/ZUVRR/JTz+ksnCELBXJtMfwI597
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Declaring rodata_enabled and mark_rodata_ro() at all time
helps removing related #ifdefery in C files.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/linux/init.h |  4 ----
 init/main.c          | 21 +++++++--------------
 2 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index 01b52c9c7526..d2b47be38a07 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -168,12 +168,8 @@ extern initcall_entry_t __initcall_end[];
 
 extern struct file_system_type rootfs_fs_type;
 
-#if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_STRICT_MODULE_RWX)
 extern bool rodata_enabled;
-#endif
-#ifdef CONFIG_STRICT_KERNEL_RWX
 void mark_rodata_ro(void);
-#endif
 
 extern void (*late_time_init)(void);
 
diff --git a/init/main.c b/init/main.c
index e24b0780fdff..807df08c501f 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1396,10 +1396,9 @@ static int __init set_debug_rodata(char *str)
 early_param("rodata", set_debug_rodata);
 #endif
 
-#ifdef CONFIG_STRICT_KERNEL_RWX
 static void mark_readonly(void)
 {
-	if (rodata_enabled) {
+	if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX) && rodata_enabled) {
 		/*
 		 * load_module() results in W+X mappings, which are cleaned
 		 * up with call_rcu().  Let's make sure that queued work is
@@ -1409,20 +1408,14 @@ static void mark_readonly(void)
 		rcu_barrier();
 		mark_rodata_ro();
 		rodata_test();
-	} else
+	} else if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX)) {
 		pr_info("Kernel memory protection disabled.\n");
+	} else if (IS_ENABLED(CONFIG_ARCH_HAS_STRICT_KERNEL_RWX)) {
+		pr_warn("Kernel memory protection not selected by kernel config.\n");
+	} else {
+		pr_warn("This architecture does not have kernel memory protection.\n");
+	}
 }
-#elif defined(CONFIG_ARCH_HAS_STRICT_KERNEL_RWX)
-static inline void mark_readonly(void)
-{
-	pr_warn("Kernel memory protection not selected by kernel config.\n");
-}
-#else
-static inline void mark_readonly(void)
-{
-	pr_warn("This architecture does not have kernel memory protection.\n");
-}
-#endif
 
 void __weak free_initmem(void)
 {
-- 
2.41.0


