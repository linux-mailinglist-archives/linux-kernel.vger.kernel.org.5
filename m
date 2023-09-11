Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC84D79B1FC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237985AbjIKUxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244079AbjIKTDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:03:53 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3570BD8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:03:48 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4Rkx2G0x31z9vQh;
        Mon, 11 Sep 2023 21:03:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fdOHe6Tf7tYQ; Mon, 11 Sep 2023 21:03:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Rkx276fQZz9vRb;
        Mon, 11 Sep 2023 21:03:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A1AE78B794;
        Mon, 11 Sep 2023 21:03:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PRHz-g3_kRVn; Mon, 11 Sep 2023 21:03:27 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.38])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 008CC8B78B;
        Mon, 11 Sep 2023 21:03:26 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 38BJ3Ip63544217
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 21:03:18 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 38BJ3I7x3544216;
        Mon, 11 Sep 2023 21:03:18 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 08/19] powerpc/nohash: Remove {pte/pmd}_protnone()
Date:   Mon, 11 Sep 2023 21:03:14 +0200
Message-ID: <adefc8e2f4608ddfb64a27213d87c17e6d8f069d.1694443576.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694443576.git.christophe.leroy@csgroup.eu>
References: <cover.1694443576.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694458986; l=1403; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=frJnHMudykDKuyMsR4TbIV7G7snC+XFESYdDeFBdnmU=; b=OnoyTMERTgMWt64lpcEoQYm/CKlQyfoJXcbWdjnL6xnULwg4XXTrgcx8yIMuVFhSaxck0MiIa JF3HGRtnPAPDSLiM/t6taLdEkc67c7v0eyQeXnZ3h0OEwUKvVyt4Z1b
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only book3s/64 selects ARCH_SUPPORTS_NUMA_BALANCING so
CONFIG_NUMA_BALANCING can't be selected on nohash targets.

Remove pte_protnone() and pmd_protnone().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/nohash/pgtable.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index a9056f4fad48..ab26af2b421a 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -35,23 +35,6 @@ static inline bool pte_hashpte(pte_t pte)	{ return false; }
 static inline bool pte_ci(pte_t pte)		{ return pte_val(pte) & _PAGE_NO_CACHE; }
 static inline bool pte_exec(pte_t pte)		{ return pte_val(pte) & _PAGE_EXEC; }
 
-#ifdef CONFIG_NUMA_BALANCING
-/*
- * These work without NUMA balancing but the kernel does not care. See the
- * comment in include/linux/pgtable.h . On powerpc, this will only
- * work for user pages and always return true for kernel pages.
- */
-static inline int pte_protnone(pte_t pte)
-{
-	return pte_present(pte) && !pte_user(pte);
-}
-
-static inline int pmd_protnone(pmd_t pmd)
-{
-	return pte_protnone(pmd_pte(pmd));
-}
-#endif /* CONFIG_NUMA_BALANCING */
-
 static inline int pte_present(pte_t pte)
 {
 	return pte_val(pte) & _PAGE_PRESENT;
-- 
2.41.0

