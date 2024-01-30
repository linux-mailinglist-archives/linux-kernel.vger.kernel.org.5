Return-Path: <linux-kernel+bounces-44392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F72684217C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BD1BB2AF64
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DE7664BC;
	Tue, 30 Jan 2024 10:36:42 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2889D60ED2;
	Tue, 30 Jan 2024 10:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611001; cv=none; b=azwQFEOR81ta1rg6gLVYXgZ9cVUlGdHFhNpHqYYN0FNI5uY/gOiynxCUKam0CIBkvfXKydiUbkqTgTsO+Hv0I5n786EiVc4oo6SjBVohPO1QARs0c/7uiA8zRCtbyCTo7i7Pa1s5KkerZn9+5OgICby2qMryGuWIvttxmHn84ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611001; c=relaxed/simple;
	bh=QmuRLYanqkqd6xSNOGiFGga1t8t/c6NljZiedRJBwPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbtp8pbbQqj+x978s/Sh2pGK2RbU8s6o+NFk8mvayGGjDbNmt0JfFB6W3wAICBNQR5Df6x9F8Z5scFXgaRWlor/67GGD1O8jk9nhgEAP6WfVTLUmuFxW8vT5efLlwTvkuTxPkHUW1Ghp4n0Q2LqQb+LmKogGXU7ExAIW8VJaTa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4TPM6473Twz9sCk;
	Tue, 30 Jan 2024 11:36:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vvJSyJCgcG_B; Tue, 30 Jan 2024 11:36:28 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4TPM4T10z0z9vFr;
	Tue, 30 Jan 2024 11:35:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 18A1C8B76C;
	Tue, 30 Jan 2024 11:35:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id nKiNczyoyHZd; Tue, 30 Jan 2024 11:35:04 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.134])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 91DDE8B76D;
	Tue, 30 Jan 2024 11:35:03 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-mm@kvack.org,
	steven.price@arm.com,
	Phong Tran <tranmanphong@gmail.com>,
	mark.rutland@arm.com,
	Greg KH <greg@kroah.com>
Subject: [PATCH v2 1/5] arm: ptdump: Rename CONFIG_DEBUG_WX to CONFIG_ARM_DEBUG_WX
Date: Tue, 30 Jan 2024 11:34:32 +0100
Message-ID: <fa297aa90caeb61eee2b70c6c5897a2ab58a9562.1706610398.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706610398.git.christophe.leroy@csgroup.eu>
References: <cover.1706610398.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706610876; l=2817; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=QmuRLYanqkqd6xSNOGiFGga1t8t/c6NljZiedRJBwPI=; b=g81FwyS7zti2ruoaUhxUSuzPsw5HpSfIlCY4oQ1NTkvQpTXA2xsMuADC0BH0QgZEr2/l/J3ix J+FpAWf8ERMCsda1rh9tv/mv27RLjAtsKIaQFX8QXy6defhUmKE6s+X
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

CONFIG_DEBUG_WX is a core option defined in mm/Kconfig.debug

To avoid any future conflict, rename ARM version
into CONFIG_ARM_DEBUG_WX.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Fixed left-over debug_checkwx() in mark_rodata_ro() and updated defconfigs
---
 arch/arm/Kconfig.debug               | 2 +-
 arch/arm/configs/aspeed_g4_defconfig | 2 +-
 arch/arm/configs/aspeed_g5_defconfig | 2 +-
 arch/arm/include/asm/ptdump.h        | 6 +++---
 arch/arm/mm/init.c                   | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 5fbbac1b708b..f1fc278081d0 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -17,7 +17,7 @@ config ARM_PTDUMP_DEBUGFS
 	  kernel.
 	  If in doubt, say "N"
 
-config DEBUG_WX
+config ARM_DEBUG_WX
 	bool "Warn on W+X mappings at boot"
 	depends on MMU
 	select ARM_PTDUMP_CORE
diff --git a/arch/arm/configs/aspeed_g4_defconfig b/arch/arm/configs/aspeed_g4_defconfig
index b3dc0465796f..28b724d59e7e 100644
--- a/arch/arm/configs/aspeed_g4_defconfig
+++ b/arch/arm/configs/aspeed_g4_defconfig
@@ -252,7 +252,7 @@ CONFIG_DEBUG_INFO_REDUCED=y
 CONFIG_GDB_SCRIPTS=y
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
-CONFIG_DEBUG_WX=y
+CONFIG_ARM_DEBUG_WX=y
 CONFIG_SCHED_STACK_END_CHECK=y
 CONFIG_PANIC_ON_OOPS=y
 CONFIG_PANIC_TIMEOUT=-1
diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index 3fdf4dbfdea5..61cee1e7ebea 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -302,7 +302,7 @@ CONFIG_DEBUG_INFO_REDUCED=y
 CONFIG_GDB_SCRIPTS=y
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
-CONFIG_DEBUG_WX=y
+CONFIG_ARM_DEBUG_WX=y
 CONFIG_SCHED_STACK_END_CHECK=y
 CONFIG_PANIC_ON_OOPS=y
 CONFIG_PANIC_TIMEOUT=-1
diff --git a/arch/arm/include/asm/ptdump.h b/arch/arm/include/asm/ptdump.h
index aad1d034136c..46a4575146ee 100644
--- a/arch/arm/include/asm/ptdump.h
+++ b/arch/arm/include/asm/ptdump.h
@@ -32,10 +32,10 @@ void ptdump_check_wx(void);
 
 #endif /* CONFIG_ARM_PTDUMP_CORE */
 
-#ifdef CONFIG_DEBUG_WX
-#define debug_checkwx() ptdump_check_wx()
+#ifdef CONFIG_ARM_DEBUG_WX
+#define arm_debug_checkwx() ptdump_check_wx()
 #else
-#define debug_checkwx() do { } while (0)
+#define arm_debug_checkwx() do { } while (0)
 #endif
 
 #endif /* __ASM_PTDUMP_H */
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index a42e4cd11db2..4c3d78691279 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -458,7 +458,7 @@ static int __mark_rodata_ro(void *unused)
 void mark_rodata_ro(void)
 {
 	stop_machine(__mark_rodata_ro, NULL, NULL);
-	debug_checkwx();
+	arm_debug_checkwx();
 }
 
 #else
-- 
2.43.0


