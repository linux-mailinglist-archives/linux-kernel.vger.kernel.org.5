Return-Path: <linux-kernel+bounces-20834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E678285DD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2EDB1F25359
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E482238DE8;
	Tue,  9 Jan 2024 12:15:16 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED74138DD2;
	Tue,  9 Jan 2024 12:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4T8VHW2g2sz9v7L;
	Tue,  9 Jan 2024 13:15:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8XzZft3ylMw5; Tue,  9 Jan 2024 13:15:03 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4T8VHW1lylz9v2V;
	Tue,  9 Jan 2024 13:15:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3309B8B77E;
	Tue,  9 Jan 2024 13:15:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id e9KbMbZ3ey5e; Tue,  9 Jan 2024 13:15:03 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.126])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 94A4B8B774;
	Tue,  9 Jan 2024 13:15:01 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: linux-hardening@vger.kernel.org,
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
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
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
Subject: [PATCH 3/4] powerpc,s390: Define ptdump_check_wx() regardless of CONFIG_DEBUG_WX
Date: Tue,  9 Jan 2024 13:14:37 +0100
Message-ID: <b167c913a6a8dcc6ad63f832e4248add1e30943e.1704800524.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1704800524.git.christophe.leroy@csgroup.eu>
References: <cover.1704800524.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704802474; l=3171; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=gAR8VjyaAG7V6eTyCXLso37q5nl2ZEcy4Y3IXEExBcI=; b=J51UzMklatGSquOss6DQxbZMh9/Fb67T2JHhLz1lpwFrSYWGcJ1wDOpaEmQDZtFgVNu/csOyt n1ORNiqAxsCAWdzF7bTDeravP/7xGeOUEa1YEh9Fy7LFTdSnsTpNTzL
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Following patch will use ptdump_check_wx() regardless of
CONFIG_DEBUG_WX, so define it at all times of powerpc and s390
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
2.41.0


