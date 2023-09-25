Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD5E7ADEEF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 20:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbjIYSeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 14:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbjIYSeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 14:34:06 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891A411C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:33:41 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RvWgR3LBbz9v8B;
        Mon, 25 Sep 2023 20:32:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DY12Wtr5iHCV; Mon, 25 Sep 2023 20:32:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RvWg521fFz9vBC;
        Mon, 25 Sep 2023 20:31:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 41E698B763;
        Mon, 25 Sep 2023 20:31:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id NAdHiwTyclYO; Mon, 25 Sep 2023 20:31:45 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.137])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4DEA28B78D;
        Mon, 25 Sep 2023 20:31:44 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 38PIVa1l1499248
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 20:31:36 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 38PIVaqp1499247;
        Mon, 25 Sep 2023 20:31:36 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 29/37] powerpc/nohash: Replace pte_user() by pte_read()
Date:   Mon, 25 Sep 2023 20:31:43 +0200
Message-ID: <72cbb5be595e9ef884140def73815ed0b0b37010.1695659959.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695659959.git.christophe.leroy@csgroup.eu>
References: <cover.1695659959.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695666676; l=3400; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=hItkHyrGPq8AtK6Q59y5B2nP7wSYExpxsghGYlVgmzk=; b=RMDEIKtSp0vvd52lwX4/QHs/EoPGoBy5JIffm3ej/g4yyUHlMkKn8WqnPjdGJ33C8Y5NbxMB0 fE60khimvfHD6dBC8cPmT2wR5vhX8xedwsw6/6uZlTSDpcJBrlDTar2
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pte_user() is now only used in pte_access_permitted() to check
access on vmas. User flag is cleared to make a page unreadable.

So rename it pte_read() and remove pte_user() which isn't used
anymore.

For the time being it checks _PAGE_USER but in the near futur
all plateforms will be converted to _PAGE_READ so lets support
both for now.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/nohash/32/pte-8xx.h |  7 -------
 arch/powerpc/include/asm/nohash/pgtable.h    | 13 +++++++------
 arch/powerpc/mm/ioremap.c                    |  4 ----
 3 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index 62c965a4511a..1ee38befd29a 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -112,13 +112,6 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
 
 #define pte_mkwrite_novma pte_mkwrite_novma
 
-static inline bool pte_user(pte_t pte)
-{
-	return !(pte_val(pte) & _PAGE_SH);
-}
-
-#define pte_user pte_user
-
 static inline pte_t pte_mkhuge(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_SPS | _PAGE_HUGE);
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index ee677162f9e6..aba56fe3b1c6 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -160,9 +160,6 @@ static inline int pte_write(pte_t pte)
 	return pte_val(pte) & _PAGE_WRITE;
 }
 #endif
-#ifndef pte_read
-static inline int pte_read(pte_t pte)		{ return 1; }
-#endif
 static inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & _PAGE_DIRTY; }
 static inline int pte_special(pte_t pte)	{ return pte_val(pte) & _PAGE_SPECIAL; }
 static inline int pte_none(pte_t pte)		{ return (pte_val(pte) & ~_PTE_NONE_MASK) == 0; }
@@ -190,10 +187,14 @@ static inline int pte_young(pte_t pte)
  * and PTE_64BIT, PAGE_KERNEL_X contains _PAGE_BAP_SR which is also in
  * _PAGE_USER.  Need to explicitly match _PAGE_BAP_UR bit in that case too.
  */
-#ifndef pte_user
-static inline bool pte_user(pte_t pte)
+#ifndef pte_read
+static inline bool pte_read(pte_t pte)
 {
+#ifdef _PAGE_READ
+	return (pte_val(pte) & _PAGE_READ) == _PAGE_READ;
+#else
 	return (pte_val(pte) & _PAGE_USER) == _PAGE_USER;
+#endif
 }
 #endif
 
@@ -208,7 +209,7 @@ static inline bool pte_access_permitted(pte_t pte, bool write)
 	 * A read-only access is controlled by _PAGE_USER bit.
 	 * We have _PAGE_READ set for WRITE and EXECUTE
 	 */
-	if (!pte_present(pte) || !pte_user(pte) || !pte_read(pte))
+	if (!pte_present(pte) || !pte_read(pte))
 		return false;
 
 	if (write && !pte_write(pte))
diff --git a/arch/powerpc/mm/ioremap.c b/arch/powerpc/mm/ioremap.c
index 7823c38f09de..7b0afcabd89f 100644
--- a/arch/powerpc/mm/ioremap.c
+++ b/arch/powerpc/mm/ioremap.c
@@ -50,10 +50,6 @@ void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long flags)
 	if (pte_write(pte))
 		pte = pte_mkdirty(pte);
 
-	/* we don't want to let _PAGE_USER leak out */
-	if (WARN_ON(pte_user(pte)))
-		return NULL;
-
 	if (iowa_is_active())
 		return iowa_ioremap(addr, size, pte_pgprot(pte), caller);
 	return __ioremap_caller(addr, size, pte_pgprot(pte), caller);
-- 
2.41.0

