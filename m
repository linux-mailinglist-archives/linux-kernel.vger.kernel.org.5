Return-Path: <linux-kernel+bounces-44394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27374842177
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD08928A65D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68D96772E;
	Tue, 30 Jan 2024 10:36:49 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF91465BB9;
	Tue, 30 Jan 2024 10:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611009; cv=none; b=VqhA4IVX24XoyGeeJHunJr0OB9a9fV3lSuWS1M1Q1L8ATXIgGBsdvRGnLNK13LB2EzI+1p57VaQ7JLyLM0epYJmOdGf1u8OcKqwmiIEy6VUwPYu3Q2nhU4WVeDOsito+u07k8fWa2c+SckEbWoiQXdD8QHqxQg33O7k3opc95IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611009; c=relaxed/simple;
	bh=bb3S88Yvg8QpRseQmACLuXZiVFZjaEpDowsFLtdjjAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DY6thFhe4pfXdecWWBeXWGrp/LKc/rsuX+pKThQlp5rMv6tixOlraFYrDYGMWEZtv5z+0Iimn5r+V65YjUSaXDMyzfuBTBcMyTXMFiWJWRuGx6AAPkPx62uX4UaH7Pr5W1MDsrwSuH28FmZa7pW7uMn/JcX3tRs36t7UPXySF4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4TPM681h4bz9scH;
	Tue, 30 Jan 2024 11:36:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cZwUjiuwfEk7; Tue, 30 Jan 2024 11:36:32 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4TPM4X1FsXz9v9N;
	Tue, 30 Jan 2024 11:35:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 2229B8B76D;
	Tue, 30 Jan 2024 11:35:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id PHLQbxrVfhNu; Tue, 30 Jan 2024 11:35:08 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.134])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 9C7538B76C;
	Tue, 30 Jan 2024 11:35:06 +0100 (CET)
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
Subject: [PATCH v2 3/5] powerpc,s390: ptdump: Define ptdump_check_wx() regardless of CONFIG_DEBUG_WX
Date: Tue, 30 Jan 2024 11:34:34 +0100
Message-ID: <07bfb04c7fec58e84413e91d2533581be357a696.1706610398.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706610398.git.christophe.leroy@csgroup.eu>
References: <cover.1706610398.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706610876; l=3171; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=bb3S88Yvg8QpRseQmACLuXZiVFZjaEpDowsFLtdjjAQ=; b=x0gpc6EGu0yH2XscctlYCktpakujE8CZJRZncJQIF0g06b7Y7Hq6Mvhcu1/d2nAOLeJFqfmh6 BTlFYvDjZnaBzRZ7joo/Zb7ANesjnwXYbuz1WBppoGr+Zl+SP+ywNIp
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Following patch will use ptdump_check_wx() regardless of
CONFIG_DEBUG_WX, so define it at all times on powerpc and s390
just like other architectures. Though keep the WARN_ON_ONCE()
only when CONFIG_DEBUG_WX is set.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/ptdump/ptdump.c | 7 +++----
 arch/s390/mm/dump_pagetables.c  | 7 ++-----
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
index 620d4917ebe8..b835c80371cd 100644
--- a/arch/powerpc/mm/ptdump/ptdump.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -184,13 +184,14 @@ static void note_prot_wx(struct pg_state *st, unsigned long addr)
 {
 	pte_t pte = __pte(st->current_flags);
 
-	if (!IS_ENABLED(CONFIG_DEBUG_WX) || !st->check_wx)
+	if (!st->check_wx)
 		return;
 
 	if (!pte_write(pte) || !pte_exec(pte))
 		return;
 
-	WARN_ONCE(1, "powerpc/mm: Found insecure W+X mapping at address %p/%pS\n",
+	WARN_ONCE(IS_ENABLED(CONFIG_DEBUG_WX),
+		  "powerpc/mm: Found insecure W+X mapping at address %p/%pS\n",
 		  (void *)st->start_address, (void *)st->start_address);
 
 	st->wx_pages += (addr - st->start_address) / PAGE_SIZE;
@@ -326,7 +327,6 @@ static void __init build_pgtable_complete_mask(void)
 				pg_level[i].mask |= pg_level[i].flag[j].mask;
 }
 
-#ifdef CONFIG_DEBUG_WX
 void ptdump_check_wx(void)
 {
 	struct pg_state st = {
@@ -354,7 +354,6 @@ void ptdump_check_wx(void)
 	else
 		pr_info("Checked W+X mappings: passed, no W+X pages found\n");
 }
-#endif
 
 static int __init ptdump_init(void)
 {
diff --git a/arch/s390/mm/dump_pagetables.c b/arch/s390/mm/dump_pagetables.c
index 8dcb4e0c71bd..99da5a5602a8 100644
--- a/arch/s390/mm/dump_pagetables.c
+++ b/arch/s390/mm/dump_pagetables.c
@@ -121,7 +121,6 @@ static void print_prot(struct seq_file *m, unsigned int pr, int level)
 
 static void note_prot_wx(struct pg_state *st, unsigned long addr)
 {
-#ifdef CONFIG_DEBUG_WX
 	if (!st->check_wx)
 		return;
 	if (st->current_prot & _PAGE_INVALID)
@@ -138,10 +137,10 @@ static void note_prot_wx(struct pg_state *st, unsigned long addr)
 	 */
 	if (addr == PAGE_SIZE && (nospec_uses_trampoline() || !static_key_enabled(&cpu_has_bear)))
 		return;
-	WARN_ONCE(1, "s390/mm: Found insecure W+X mapping at address %pS\n",
+	WARN_ONCE(IS_ENABLED(CONFIG_DEBUG_WX),
+		  "s390/mm: Found insecure W+X mapping at address %pS\n",
 		  (void *)st->start_address);
 	st->wx_pages += (addr - st->start_address) / PAGE_SIZE;
-#endif /* CONFIG_DEBUG_WX */
 }
 
 static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level, u64 val)
@@ -193,7 +192,6 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 	}
 }
 
-#ifdef CONFIG_DEBUG_WX
 void ptdump_check_wx(void)
 {
 	struct pg_state st = {
@@ -226,7 +224,6 @@ void ptdump_check_wx(void)
 			(nospec_uses_trampoline() || !static_key_enabled(&cpu_has_bear)) ?
 			"unexpected " : "");
 }
-#endif /* CONFIG_DEBUG_WX */
 
 #ifdef CONFIG_PTDUMP_DEBUGFS
 static int ptdump_show(struct seq_file *m, void *v)
-- 
2.43.0


