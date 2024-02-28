Return-Path: <linux-kernel+bounces-84709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 729DD86AA82
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A56B61C23C59
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5FF36B0E;
	Wed, 28 Feb 2024 08:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jO72XYs+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D015436AE7
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110483; cv=none; b=BF9yojMc5zOCg7FPNaY1yA5hOJxJNBXDblpC8LfxsUAbluE7sdIW8M61XR3808evji/QuebhjBY0XZXT5A+t2TryGFeEXhC+AYY6vd2nM195olVY81jZjOQk6gZPA2I1m/4wG3+0rzw9+IyUA9rT4UdO4NtjouaQrXTpEiNA5Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110483; c=relaxed/simple;
	bh=FtxnQT1/dleTlk5AMuTsoIkyeQ/Sdg6xrRFLkejJL1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MdbcCB92bWFPFZ2j6kmZuMjcaW0QJgzG/J3R/9jsT+GYrOBuC34rWtdJFsII9Ve8Hhj2cZxZqewsAAOSN/qgwgKKkqHe7YXiu7svhozkpwvWPm5Gj4WWj/Q8iXD8HPGMKSkh5x6JBhiUwZYLV7KG1hQNNZSWBXI6wiN8Th527ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jO72XYs+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709110481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AlPPB19GveccKF6q5GC4EGyOTsyd3+7/CoVODcDmFpU=;
	b=jO72XYs+w3ZkKDEQ6k2WD2lf6PZzoBPA4F3/8S1nKYNPZpSbW2znyKSu7nquINNrwq2+Oy
	xt0aUuFVzjHHbsUzYE7/9ZXidNVuUj/l/kTI84gkXJMWfUmbk3KZw2FHDeIsxpWCsRZIK4
	P7Y9Zxv4UphdRNLDLP/Eyh8LNZI6QF0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-jkzvL2X3OE2u2sJzQFKwag-1; Wed, 28 Feb 2024 03:54:32 -0500
X-MC-Unique: jkzvL2X3OE2u2sJzQFKwag-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A249108BFCC;
	Wed, 28 Feb 2024 08:54:32 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 58914200A382;
	Wed, 28 Feb 2024 08:54:26 +0000 (UTC)
From: peterx@redhat.com
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Yang Shi <shy828301@gmail.com>,
	Muchun Song <muchun.song@linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	x86@kernel.org,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	peterx@redhat.com
Subject: [PATCH 5/5] mm/treewide: Drop pXd_large()
Date: Wed, 28 Feb 2024 16:53:50 +0800
Message-ID: <20240228085350.520953-6-peterx@redhat.com>
In-Reply-To: <20240228085350.520953-1-peterx@redhat.com>
References: <20240228085350.520953-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

From: Peter Xu <peterx@redhat.com>

They're not used anymore, drop all of them.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm/include/asm/pgtable-2level.h        |  1 -
 arch/arm/include/asm/pgtable-3level.h        |  1 -
 arch/powerpc/include/asm/book3s/64/pgtable.h |  2 --
 arch/powerpc/include/asm/pgtable.h           |  4 ----
 arch/s390/include/asm/pgtable.h              |  8 ++++----
 arch/sparc/include/asm/pgtable_64.h          |  8 ++++----
 arch/x86/include/asm/pgtable.h               | 15 +++++++--------
 7 files changed, 15 insertions(+), 24 deletions(-)

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
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index d1318e8582ac..176d63ec5c3a 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1441,7 +1441,6 @@ static inline bool is_pte_rw_upgrade(unsigned long old_val, unsigned long new_va
  */
 #define pmd_is_leaf pmd_is_leaf
 #define pmd_leaf pmd_is_leaf
-#define pmd_large pmd_leaf
 static inline bool pmd_is_leaf(pmd_t pmd)
 {
 	return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
@@ -1449,7 +1448,6 @@ static inline bool pmd_is_leaf(pmd_t pmd)
 
 #define pud_is_leaf pud_is_leaf
 #define pud_leaf pud_is_leaf
-#define pud_large pud_leaf
 static inline bool pud_is_leaf(pud_t pud)
 {
 	return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 5928b3c1458d..8a19066e5e12 100644
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
index 69ed0ea0641b..87be73474e8d 100644
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
@@ -260,8 +260,8 @@ static inline int p4d_large(p4d_t p4d)
 
 #define pte_page(pte)	pfn_to_page(pte_pfn(pte))
 
-#define pmd_leaf	pmd_large
-static inline int pmd_large(pmd_t pte)
+#define pmd_leaf pmd_leaf
+static inline int pmd_leaf(pmd_t pte)
 {
 	return pmd_flags(pte) & _PAGE_PSE;
 }
@@ -1085,8 +1085,7 @@ static inline pmd_t *pud_pgtable(pud_t pud)
  */
 #define pud_page(pud)	pfn_to_page(pud_pfn(pud))
 
-#define pud_leaf	pud_large
-static inline int pud_large(pud_t pud)
+static inline int pud_leaf(pud_t pud)
 {
 	return (pud_val(pud) & (_PAGE_PSE | _PAGE_PRESENT)) ==
 		(_PAGE_PSE | _PAGE_PRESENT);
@@ -1097,12 +1096,12 @@ static inline int pud_bad(pud_t pud)
 	return (pud_flags(pud) & ~(_KERNPG_TABLE | _PAGE_USER)) != 0;
 }
 #else
-#define pud_leaf	pud_large
-static inline int pud_large(pud_t pud)
+static inline int pud_leaf(pud_t pud)
 {
 	return 0;
 }
 #endif	/* CONFIG_PGTABLE_LEVELS > 2 */
+#define pud_leaf pud_leaf
 
 #if CONFIG_PGTABLE_LEVELS > 3
 static inline int p4d_none(p4d_t p4d)
-- 
2.43.0


