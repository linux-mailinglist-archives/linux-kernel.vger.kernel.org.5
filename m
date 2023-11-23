Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD7C7F58B9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344828AbjKWG5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbjKWG5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:57:48 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6232B0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:57:53 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b83fc26e4cso383936b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700722673; x=1701327473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBzEAwR1u2ognGkokbPIcjTus0Wt1Liku1PeiEAYDPA=;
        b=S/H2AlAr/1MUQFwrBdW46YqR5RbP5zbByBEvYryy9hz3u34Pv81eJKK+qi02859+jS
         DbQ9UIxxydshX0/q9N/kON4EYMyICgjCgMLAk7KSVHJ8sl9HvbYou44iyks68izHqW8B
         EgWOt6XoDLIdvtqp59Gz9Mcaz2YDO7TjGMyU5pn8LCZrON7MVhWPVgY2gGuPvqOnpoh9
         NagoWjczCmci290KpkMSaChqhGGMvEXMTCxuuw9EW9u+/5FiU1rVZVzQhbneFHhMiy8j
         Av90HkcANyMvai646X2uoLV0lYa5Zv0T0ayvmckt3kC4+rQPqRE0ayPFIpJK3HmcrRxL
         Z+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700722673; x=1701327473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBzEAwR1u2ognGkokbPIcjTus0Wt1Liku1PeiEAYDPA=;
        b=DNAWKjlMJIerkWtHpKDm+al3mB/Pnjm590MsprFSKAN+rrMmdPsT5DlSp985qCwg8q
         E7ZdhVkekKXdRS806Gd18NbC/+zuJFZz06QW64cFvvaDuIV1g5xPK+C4fVN1lCF84iKB
         uAl49DV/FU7y3dQvraCfSZf+Y6TGARaEQ63vo08XfMcuy3i3VhynZDN4bUSOTCij7fNQ
         DFExRb8Z237zA9hPv8FYqjLVkj6teaSJy01530QJjdwgMERAvvTCgnvuVxrd2L8gdvKF
         uRkCw7frTp+97KvfahCzioDLFqlNZhNSvWvATidutVSROrTQ3qWKYyX+ioRWIxJZAiKz
         XyqA==
X-Gm-Message-State: AOJu0YyUdCz2YWeOTteUGnOk5vA+mJZ2X8+PhpSUUzpm3qOJOaEmbkiE
        shv+GcRv5959x+tdusE3Kg6rUw==
X-Google-Smtp-Source: AGHT+IGHKuk0EJS7EQTCzidInz2QrgpsRuY4bxBytkNm9OOr3Q4F5OcNYuewzXuJd5Dzw7DfQuJfmg==
X-Received: by 2002:a54:4885:0:b0:3af:b6d3:cda0 with SMTP id r5-20020a544885000000b003afb6d3cda0mr5487295oic.40.1700722673045;
        Wed, 22 Nov 2023 22:57:53 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id w37-20020a634765000000b005bd2b3a03eesm615437pgk.6.2023.11.22.22.57.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Nov 2023 22:57:52 -0800 (PST)
From:   Xu Lu <luxu.kernel@bytedance.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, ardb@kernel.org, anup@brainfault.org,
        atishp@atishpatra.org
Cc:     dengliang.1214@bytedance.com, xieyongji@bytedance.com,
        lihangjing@bytedance.com, songmuchun@bytedance.com,
        punit.agrawal@bytedance.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH V1 05/11] riscv: Decouple pmd operations and pte operations
Date:   Thu, 23 Nov 2023 14:57:02 +0800
Message-Id: <20231123065708.91345-6-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231123065708.91345-1-luxu.kernel@bytedance.com>
References: <20231123065708.91345-1-luxu.kernel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Existing pmd operations are usually implemented via pte operations. For
example, the pmd_mkdirty function, which is used to mark a pmd_t struct
as dirty, will transfer pmd_t struct to pte_t struct via pmd_pte first,
mark the generated pte_t as dirty then, and finally transfer it back to
pmd_t struct via pte_pmd function. Such implementation introduces
unnecessary overhead of struct transferring. Also, Now that pte_t struct
is a number of page table entries, which can be larger than pmd_t
struct, functions like set_pmd_at implemented via set_pte_at will cause
write amplifications.

This commit decouples pmd operations and pte operations. Pmd operations
are now implemented independently of pte operations.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/pgtable-64.h |   6 ++
 arch/riscv/include/asm/pgtable.h    | 124 +++++++++++++++++++++-------
 include/asm-generic/pgtable-nopmd.h |   1 +
 include/linux/pgtable.h             |   6 ++
 4 files changed, 108 insertions(+), 29 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 1926727698fc..95e785f2160c 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -206,6 +206,12 @@ static inline int pud_leaf(pud_t pud)
 	return pud_present(pud) && (pud_val(pud) & _PAGE_LEAF);
 }
 
+#define pud_exec	pud_exec
+static inline int pud_exec(pud_t pud)
+{
+	return pud_val(pud) & _PAGE_EXEC;
+}
+
 static inline int pud_user(pud_t pud)
 {
 	return pud_val(pud) & _PAGE_USER;
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index d50c4588c1ed..9f81fe046cb8 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -272,6 +272,18 @@ static inline int pmd_leaf(pmd_t pmd)
 	return pmd_present(pmd) && (pmd_val(pmd) & _PAGE_LEAF);
 }
 
+#define pmd_exec	pmd_exec
+static inline int pmd_exec(pmd_t pmd)
+{
+	return pmd_val(pmd) & _PAGE_EXEC;
+}
+
+#define __HAVE_ARCH_PMD_SAME
+static inline int pmd_same(pmd_t pmd_a, pmd_t pmd_b)
+{
+	return pmd_val(pmd_a) == pmd_val(pmd_b);
+}
+
 static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
 	*pmdp = pmd;
@@ -506,7 +518,7 @@ static inline int pte_protnone(pte_t pte)
 
 static inline int pmd_protnone(pmd_t pmd)
 {
-	return pte_protnone(pmd_pte(pmd));
+	return (pmd_val(pmd) & (_PAGE_PRESENT | _PAGE_PROT_NONE)) == _PAGE_PROT_NONE;
 }
 #endif
 
@@ -740,73 +752,95 @@ static inline unsigned long pud_pfn(pud_t pud)
 
 static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 {
-	return pte_pmd(pte_modify(pmd_pte(pmd), newprot));
+	unsigned long newprot_val = pgprot_val(newprot);
+
+	ALT_THEAD_PMA(newprot_val);
+
+	return __pmd((pmd_val(pmd) & _PAGE_CHG_MASK) | newprot_val);
 }
 
 #define pmd_write pmd_write
 static inline int pmd_write(pmd_t pmd)
 {
-	return pte_write(pmd_pte(pmd));
+	return pmd_val(pmd) & _PAGE_WRITE;
 }
 
 static inline int pmd_dirty(pmd_t pmd)
 {
-	return pte_dirty(pmd_pte(pmd));
+	return pmd_val(pmd) & _PAGE_DIRTY;
 }
 
 #define pmd_young pmd_young
 static inline int pmd_young(pmd_t pmd)
 {
-	return pte_young(pmd_pte(pmd));
+	return pmd_val(pmd) & _PAGE_ACCESSED;
 }
 
 static inline int pmd_user(pmd_t pmd)
 {
-	return pte_user(pmd_pte(pmd));
+	return pmd_val(pmd) & _PAGE_USER;
 }
 
 static inline pmd_t pmd_mkold(pmd_t pmd)
 {
-	return pte_pmd(pte_mkold(pmd_pte(pmd)));
+	return __pmd(pmd_val(pmd) & ~(_PAGE_ACCESSED));
 }
 
 static inline pmd_t pmd_mkyoung(pmd_t pmd)
 {
-	return pte_pmd(pte_mkyoung(pmd_pte(pmd)));
+	return __pmd(pmd_val(pmd) | _PAGE_ACCESSED);
 }
 
 static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 {
-	return pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)));
+	return __pmd(pmd_val(pmd) | _PAGE_WRITE);
 }
 
 static inline pmd_t pmd_wrprotect(pmd_t pmd)
 {
-	return pte_pmd(pte_wrprotect(pmd_pte(pmd)));
+	return __pmd(pmd_val(pmd) & (~_PAGE_WRITE));
 }
 
 static inline pmd_t pmd_mkclean(pmd_t pmd)
 {
-	return pte_pmd(pte_mkclean(pmd_pte(pmd)));
+	return __pmd(pmd_val(pmd) & (~_PAGE_DIRTY));
 }
 
 static inline pmd_t pmd_mkdirty(pmd_t pmd)
 {
-	return pte_pmd(pte_mkdirty(pmd_pte(pmd)));
+	return __pmd(pmd_val(pmd) | _PAGE_DIRTY);
+}
+
+#define pmd_accessible(mm, pmd)		((void)(pmd), 1)
+
+static inline void __set_pmd_at(pmd_t *pmdp, pmd_t pmd)
+{
+	if (pmd_present(pmd) && pmd_exec(pmd))
+		flush_icache_pte(pmd_pte(pmd));
+
+	set_pmd(pmdp, pmd);
 }
 
 static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 				pmd_t *pmdp, pmd_t pmd)
 {
 	page_table_check_pmd_set(mm, pmdp, pmd);
-	return __set_pte_at((pte_t *)pmdp, pmd_pte(pmd));
+	return __set_pmd_at(pmdp, pmd);
+}
+
+static inline void __set_pud_at(pud_t *pudp, pud_t pud)
+{
+	if (pud_present(pud) && pud_exec(pud))
+		flush_icache_pte(pud_pte(pud));
+
+	set_pud(pudp, pud);
 }
 
 static inline void set_pud_at(struct mm_struct *mm, unsigned long addr,
 				pud_t *pudp, pud_t pud)
 {
 	page_table_check_pud_set(mm, pudp, pud);
-	return __set_pte_at((pte_t *)pudp, pud_pte(pud));
+	return __set_pud_at(pudp, pud);
 }
 
 #ifdef CONFIG_PAGE_TABLE_CHECK
@@ -826,25 +860,64 @@ static inline bool pud_user_accessible_page(pud_t pud)
 }
 #endif
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static inline int pmd_trans_huge(pmd_t pmd)
-{
-	return pmd_leaf(pmd);
-}
-
 #define __HAVE_ARCH_PMDP_SET_ACCESS_FLAGS
 static inline int pmdp_set_access_flags(struct vm_area_struct *vma,
 					unsigned long address, pmd_t *pmdp,
 					pmd_t entry, int dirty)
 {
-	return ptep_set_access_flags(vma, address, (pte_t *)pmdp, pmd_pte(entry), dirty);
+	if (!pmd_same(*pmdp, entry))
+		set_pmd_at(vma->vm_mm, address, pmdp, entry);
+	/*
+	 * update_mmu_cache will unconditionally execute, handling both
+	 * the case that the PMD changed and the spurious fault case.
+	 */
+	return true;
+}
+
+#define __HAVE_ARCH_PMDP_GET_AND_CLEAR
+static inline pmd_t pmdp_get_and_clear(struct mm_struct *mm,
+					unsigned long address, pmd_t *pmdp)
+{
+	pmd_t pmd = __pmd(atomic_long_xchg((atomic_long_t *)pmdp, 0));
+
+	page_table_check_pmd_clear(mm, pmd);
+
+	return pmd;
+}
+
+#define __HAVE_ARCH_PMDP_SET_WRPROTECT
+static inline void pmdp_set_wrprotect(struct mm_struct *mm,
+					unsigned long address, pmd_t *pmdp)
+{
+	atomic_long_and(~(unsigned long)_PAGE_WRITE, (atomic_long_t *)pmdp);
+}
+
+#define __HAVE_ARCH_PMDP_CLEAR_FLUSH
+static inline pmd_t pmdp_clear_flush(struct vm_area_struct *vma,
+					unsigned long address, pmd_t *pmdp)
+{
+	struct mm_struct *mm = (vma)->vm_mm;
+	pmd_t pmd = pmdp_get_and_clear(mm, address, pmdp);
+
+	if (pmd_accessible(mm, pmd))
+		flush_tlb_page(vma, address);
+
+	return pmd;
 }
 
 #define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
 static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 					unsigned long address, pmd_t *pmdp)
 {
-	return ptep_test_and_clear_young(vma, address, (pte_t *)pmdp);
+	if (!pmd_young(*pmdp))
+		return 0;
+	return test_and_clear_bit(_PAGE_ACCESSED_OFFSET, &pmd_val(*pmdp));
+}
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static inline int pmd_trans_huge(pmd_t pmd)
+{
+	return pmd_leaf(pmd);
 }
 
 #define __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
@@ -858,13 +931,6 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 	return pmd;
 }
 
-#define __HAVE_ARCH_PMDP_SET_WRPROTECT
-static inline void pmdp_set_wrprotect(struct mm_struct *mm,
-					unsigned long address, pmd_t *pmdp)
-{
-	ptep_set_wrprotect(mm, address, (pte_t *)pmdp);
-}
-
 #define pmdp_establish pmdp_establish
 static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 				unsigned long address, pmd_t *pmdp, pmd_t pmd)
diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/pgtable-nopmd.h
index 8ffd64e7a24c..acef201b29f5 100644
--- a/include/asm-generic/pgtable-nopmd.h
+++ b/include/asm-generic/pgtable-nopmd.h
@@ -32,6 +32,7 @@ static inline int pud_bad(pud_t pud)		{ return 0; }
 static inline int pud_present(pud_t pud)	{ return 1; }
 static inline int pud_user(pud_t pud)		{ return 0; }
 static inline int pud_leaf(pud_t pud)		{ return 0; }
+static inline int pud_exec(pud_t pud)		{ return 0; }
 static inline void pud_clear(pud_t *pud)	{ }
 #define pmd_ERROR(pmd)				(pud_ERROR((pmd).pud))
 
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index af7639c3b0a3..b8d6e39fefc2 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1630,9 +1630,15 @@ typedef unsigned int pgtbl_mod_mask;
 #ifndef pud_leaf
 #define pud_leaf(x)	0
 #endif
+#ifndef pud_exec
+#define pud_exec(x)	0
+#endif
 #ifndef pmd_leaf
 #define pmd_leaf(x)	0
 #endif
+#ifndef pmd_exec
+#define pmd_exec(x)	0
+#endif
 
 #ifndef pgd_leaf_size
 #define pgd_leaf_size(x) (1ULL << PGDIR_SHIFT)
-- 
2.20.1

