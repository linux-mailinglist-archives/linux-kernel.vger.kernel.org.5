Return-Path: <linux-kernel+bounces-91675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC71C8714E2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 555621F232C6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C897E11E;
	Tue,  5 Mar 2024 04:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N7bSYv1w"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBF37E10D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 04:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709613555; cv=none; b=ohJce1egcoHQdgUi+Xq3qS6I4/UCVn0TuHfCfq/7Rq2n6lPus/LdHqzmAIGvH6QBD8S9zC9nO9B93BMcYHscSSk8gyeI4iNSiV1fwyfzf8Euq8VlbHsVojljNNAf777LxTxK9W0GNxExuZ20rYhbfLUH5ZT0XUngmupfX22M1VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709613555; c=relaxed/simple;
	bh=VAUvY459/rjjHkbEvx6tFGJFumcnQz74iRW2X8YK9fY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukphFdMDdAvsuvUqNjVRi6ZkJ3kbgnL8IyloqCPAxi4qctj06IbP+UoIKxvVd2GAmrUh1fvhZoCEtSC/jsVy/qiMSJRhYaaOY8W0dMkhZMb5zgshKregOxod1dwMggTENpUG8FY0CS3W+MH1HZ1yDsVjmfJ1j8Po+omFbt+BDXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N7bSYv1w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709613552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hOUtTav4hmt5Ys9NOLCCnBkIj5rHL075G12/OtEUkGI=;
	b=N7bSYv1wMc6q2CBU9dKN2ZXRXtRlJbuAda4TCyQBty0BIZ4jTgKeMCcC3/OsuLyb6r0wms
	5CdEE51kHLZ03sAJ8rk3hm8d592sejNRNiII7Swo6pEFiuGnFPV1+ZDougi8TwsfAS2Whd
	AZAsLLxYkNYU0rU0+fo9l//RJyLAcPU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-j9LV1vv2M0S4rC32HpgzeQ-1; Mon,
 04 Mar 2024 23:39:06 -0500
X-MC-Unique: j9LV1vv2M0S4rC32HpgzeQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 400623804A09;
	Tue,  5 Mar 2024 04:39:06 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.31])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7F80BC1F090;
	Tue,  5 Mar 2024 04:39:00 +0000 (UTC)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	x86@kernel.org,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Yang Shi <shy828301@gmail.com>,
	peterx@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org,
	Muchun Song <muchun.song@linux.dev>
Subject: [PATCH v3 09/10] mm/treewide: Drop pXd_large()
Date: Tue,  5 Mar 2024 12:37:49 +0800
Message-ID: <20240305043750.93762-10-peterx@redhat.com>
In-Reply-To: <20240305043750.93762-1-peterx@redhat.com>
References: <20240305043750.93762-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

From: Peter Xu <peterx@redhat.com>

They're not used anymore, drop all of them.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm/include/asm/pgtable-2level.h        |  1 -
 arch/arm/include/asm/pgtable-3level.h        |  1 -
 arch/loongarch/kvm/mmu.c                     |  2 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h |  4 +---
 arch/powerpc/include/asm/pgtable.h           |  4 ----
 arch/s390/include/asm/pgtable.h              |  8 ++++----
 arch/sparc/include/asm/pgtable_64.h          |  8 ++++----
 arch/x86/include/asm/pgtable.h               | 19 +++++++------------
 arch/x86/kvm/mmu/mmu.c                       |  2 +-
 9 files changed, 18 insertions(+), 31 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index ce543cd9380c..b0a262566eb9 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -213,7 +213,6 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 
 #define pmd_pfn(pmd)		(__phys_to_pfn(pmd_val(pmd) & PHYS_MASK))
 
-#define pmd_large(pmd)		(pmd_val(pmd) & 2)
 #define pmd_leaf(pmd)		(pmd_val(pmd) & 2)
 #define pmd_bad(pmd)		(pmd_val(pmd) & 2)
 #define pmd_present(pmd)	(pmd_val(pmd))
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 71c3add6417f..4b1d9eb3908a 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -118,7 +118,6 @@
 						 PMD_TYPE_TABLE)
 #define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
 						 PMD_TYPE_SECT)
-#define pmd_large(pmd)		pmd_sect(pmd)
 #define pmd_leaf(pmd)		pmd_sect(pmd)
 
 #define pud_clear(pudp)			\
diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
index 50a6acd7ffe4..a556cff35740 100644
--- a/arch/loongarch/kvm/mmu.c
+++ b/arch/loongarch/kvm/mmu.c
@@ -723,7 +723,7 @@ static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn,
 	/*
 	 * Read each entry once.  As above, a non-leaf entry can be promoted to
 	 * a huge page _during_ this walk.  Re-reading the entry could send the
-	 * walk into the weeks, e.g. p*d_large() returns false (sees the old
+	 * walk into the weeks, e.g. p*d_leaf() returns false (sees the old
 	 * value) and then p*d_offset() walks into the target huge page instead
 	 * of the old page table (sees the new value).
 	 */
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 3e99e409774a..df66dce8306f 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1437,17 +1437,15 @@ static inline bool is_pte_rw_upgrade(unsigned long old_val, unsigned long new_va
 }
 
 /*
- * Like pmd_huge() and pmd_large(), but works regardless of config options
+ * Like pmd_huge(), but works regardless of config options
  */
 #define pmd_leaf pmd_leaf
-#define pmd_large pmd_leaf
 static inline bool pmd_leaf(pmd_t pmd)
 {
 	return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
 }
 
 #define pud_leaf pud_leaf
-#define pud_large pud_leaf
 static inline bool pud_leaf(pud_t pud)
 {
 	return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index e6edf1cdbc5b..239709a2f68e 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -101,10 +101,6 @@ void poking_init(void);
 extern unsigned long ioremap_bot;
 extern const pgprot_t protection_map[16];
 
-#ifndef pmd_large
-#define pmd_large(pmd)		0
-#endif
-
 /* can we use this in kvm */
 unsigned long vmalloc_to_phys(void *vmalloc_addr);
 
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index a5f16a244a64..9e08af5b9247 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -705,16 +705,16 @@ static inline int pud_none(pud_t pud)
 	return pud_val(pud) == _REGION3_ENTRY_EMPTY;
 }
 
-#define pud_leaf	pud_large
-static inline int pud_large(pud_t pud)
+#define pud_leaf pud_leaf
+static inline int pud_leaf(pud_t pud)
 {
 	if ((pud_val(pud) & _REGION_ENTRY_TYPE_MASK) != _REGION_ENTRY_TYPE_R3)
 		return 0;
 	return !!(pud_val(pud) & _REGION3_ENTRY_LARGE);
 }
 
-#define pmd_leaf	pmd_large
-static inline int pmd_large(pmd_t pmd)
+#define pmd_leaf pmd_leaf
+static inline int pmd_leaf(pmd_t pmd)
 {
 	return (pmd_val(pmd) & _SEGMENT_ENTRY_LARGE) != 0;
 }
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 652af9d63fa2..6ff0a28d5fd1 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -680,8 +680,8 @@ static inline unsigned long pte_special(pte_t pte)
 	return pte_val(pte) & _PAGE_SPECIAL;
 }
 
-#define pmd_leaf	pmd_large
-static inline unsigned long pmd_large(pmd_t pmd)
+#define pmd_leaf pmd_leaf
+static inline unsigned long pmd_leaf(pmd_t pmd)
 {
 	pte_t pte = __pte(pmd_val(pmd));
 
@@ -867,8 +867,8 @@ static inline pmd_t *pud_pgtable(pud_t pud)
 /* only used by the stubbed out hugetlb gup code, should never be called */
 #define p4d_page(p4d)			NULL
 
-#define pud_leaf	pud_large
-static inline unsigned long pud_large(pud_t pud)
+#define pud_leaf pud_leaf
+static inline unsigned long pud_leaf(pud_t pud)
 {
 	pte_t pte = __pte(pud_val(pud));
 
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 9db7a38a0e9f..cfc84c55d0e6 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -251,8 +251,8 @@ static inline unsigned long pgd_pfn(pgd_t pgd)
 	return (pgd_val(pgd) & PTE_PFN_MASK) >> PAGE_SHIFT;
 }
 
-#define p4d_leaf	p4d_large
-static inline int p4d_large(p4d_t p4d)
+#define p4d_leaf p4d_leaf
+static inline int p4d_leaf(p4d_t p4d)
 {
 	/* No 512 GiB pages yet */
 	return 0;
@@ -260,14 +260,14 @@ static inline int p4d_large(p4d_t p4d)
 
 #define pte_page(pte)	pfn_to_page(pte_pfn(pte))
 
-#define pmd_leaf	pmd_large
-static inline int pmd_large(pmd_t pte)
+#define pmd_leaf pmd_leaf
+static inline int pmd_leaf(pmd_t pte)
 {
 	return pmd_flags(pte) & _PAGE_PSE;
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-/* NOTE: when predicate huge page, consider also pmd_devmap, or use pmd_large */
+/* NOTE: when predicate huge page, consider also pmd_devmap, or use pmd_leaf */
 static inline int pmd_trans_huge(pmd_t pmd)
 {
 	return (pmd_val(pmd) & (_PAGE_PSE|_PAGE_DEVMAP)) == _PAGE_PSE;
@@ -1085,8 +1085,8 @@ static inline pmd_t *pud_pgtable(pud_t pud)
  */
 #define pud_page(pud)	pfn_to_page(pud_pfn(pud))
 
-#define pud_leaf	pud_large
-static inline int pud_large(pud_t pud)
+#define pud_leaf pud_leaf
+static inline int pud_leaf(pud_t pud)
 {
 	return (pud_val(pud) & (_PAGE_PSE | _PAGE_PRESENT)) ==
 		(_PAGE_PSE | _PAGE_PRESENT);
@@ -1096,11 +1096,6 @@ static inline int pud_bad(pud_t pud)
 {
 	return (pud_flags(pud) & ~(_KERNPG_TABLE | _PAGE_USER)) != 0;
 }
-#else
-static inline int pud_large(pud_t pud)
-{
-	return 0;
-}
 #endif	/* CONFIG_PGTABLE_LEVELS > 2 */
 
 #if CONFIG_PGTABLE_LEVELS > 3
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 5cb5bc4a72c4..58f5e6b637b4 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3110,7 +3110,7 @@ static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn,
 	/*
 	 * Read each entry once.  As above, a non-leaf entry can be promoted to
 	 * a huge page _during_ this walk.  Re-reading the entry could send the
-	 * walk into the weeks, e.g. p*d_large() returns false (sees the old
+	 * walk into the weeks, e.g. p*d_leaf() returns false (sees the old
 	 * value) and then p*d_offset() walks into the target huge page instead
 	 * of the old page table (sees the new value).
 	 */
-- 
2.44.0


