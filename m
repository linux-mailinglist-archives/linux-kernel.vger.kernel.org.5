Return-Path: <linux-kernel+bounces-91676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2798714E3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 531D6282036
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60677E581;
	Tue,  5 Mar 2024 04:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRc3sPI1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2E87E563
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 04:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709613561; cv=none; b=aTbq8ucDRTVwEpZ44hfzTc1KpiOCQI+dR5gj3VpTWeII1FCLXOJQYssSIhgsR+AwZcE9p/bojJ1OmSeTVlWob3oxGP0YGcznz+dv/hEYGz8tp3SRKMA1Sn9MjxrpMujj0to3Wb2U5K/Otmkptxp2WUcRUt8tfmHdwQRyJe+4tr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709613561; c=relaxed/simple;
	bh=JJwF0uimiVgK6AKyNaDALob98YEJRP85dZqZyruT1so=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wnz6dTWvgqlDzAF4mLqal0OmYHTmBcwj7M4EnF+18aLURElNV67/pH+XsbLwgE12TC5P4UGZ7Z6uampK7HC5NowpxbHDNF4XWliTzdxM+TKv5wCiu/rgLgChYo5wzB7JiBZqKifO7/rKNsMzViZi/kXvIhrhsh3D245ibRbaoXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KRc3sPI1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709613558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LjhEXhItmtgWJcOdZcIsr7lX1LpUjnzN2RuMZC/FUxw=;
	b=KRc3sPI1cAWzYJmg+DmilETfghE62dfGBcGC/LpzUCSztD5V+DjrR2g8ntRNKHSyZ1A0CB
	OiTRhsQNrW/ws6oOKRTAvNnLK/1LZ5Z+BMYjdIPCk2GeRI3po72d65JTMW5lwF8XNRtdXf
	T8GL3AeKTWmfUSv4mESTeSndZ5jHbpw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-SJW2FwMcNIWT4KdeDhGtsQ-1; Mon,
 04 Mar 2024 23:39:13 -0500
X-MC-Unique: SJW2FwMcNIWT4KdeDhGtsQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 790DC29AB3F0;
	Tue,  5 Mar 2024 04:39:12 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.31])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0CE65C1F090;
	Tue,  5 Mar 2024 04:39:06 +0000 (UTC)
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
Subject: [PATCH v3 10/10] mm/treewide: Align up pXd_leaf() retval across archs
Date: Tue,  5 Mar 2024 12:37:50 +0800
Message-ID: <20240305043750.93762-11-peterx@redhat.com>
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

Even if pXd_leaf() API is defined globally, it's not clear on the retval,
and there are three types used (bool, int, unsigned log).

Always return a boolean for pXd_leaf() APIs.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/riscv/include/asm/pgtable-64.h | 2 +-
 arch/riscv/include/asm/pgtable.h    | 2 +-
 arch/s390/include/asm/pgtable.h     | 4 ++--
 arch/sparc/include/asm/pgtable_64.h | 4 ++--
 arch/x86/include/asm/pgtable.h      | 8 ++++----
 include/linux/pgtable.h             | 8 ++++----
 6 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index b42017d76924..2c7e1661db01 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -190,7 +190,7 @@ static inline int pud_bad(pud_t pud)
 }
 
 #define pud_leaf	pud_leaf
-static inline int pud_leaf(pud_t pud)
+static inline bool pud_leaf(pud_t pud)
 {
 	return pud_present(pud) && (pud_val(pud) & _PAGE_LEAF);
 }
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index add5cd30ab34..6839520dbcb1 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -241,7 +241,7 @@ static inline int pmd_bad(pmd_t pmd)
 }
 
 #define pmd_leaf	pmd_leaf
-static inline int pmd_leaf(pmd_t pmd)
+static inline bool pmd_leaf(pmd_t pmd)
 {
 	return pmd_present(pmd) && (pmd_val(pmd) & _PAGE_LEAF);
 }
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 9e08af5b9247..60950e7a25f5 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -706,7 +706,7 @@ static inline int pud_none(pud_t pud)
 }
 
 #define pud_leaf pud_leaf
-static inline int pud_leaf(pud_t pud)
+static inline bool pud_leaf(pud_t pud)
 {
 	if ((pud_val(pud) & _REGION_ENTRY_TYPE_MASK) != _REGION_ENTRY_TYPE_R3)
 		return 0;
@@ -714,7 +714,7 @@ static inline int pud_leaf(pud_t pud)
 }
 
 #define pmd_leaf pmd_leaf
-static inline int pmd_leaf(pmd_t pmd)
+static inline bool pmd_leaf(pmd_t pmd)
 {
 	return (pmd_val(pmd) & _SEGMENT_ENTRY_LARGE) != 0;
 }
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 6ff0a28d5fd1..4d1bafaba942 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -681,7 +681,7 @@ static inline unsigned long pte_special(pte_t pte)
 }
 
 #define pmd_leaf pmd_leaf
-static inline unsigned long pmd_leaf(pmd_t pmd)
+static inline bool pmd_leaf(pmd_t pmd)
 {
 	pte_t pte = __pte(pmd_val(pmd));
 
@@ -868,7 +868,7 @@ static inline pmd_t *pud_pgtable(pud_t pud)
 #define p4d_page(p4d)			NULL
 
 #define pud_leaf pud_leaf
-static inline unsigned long pud_leaf(pud_t pud)
+static inline bool pud_leaf(pud_t pud)
 {
 	pte_t pte = __pte(pud_val(pud));
 
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index cfc84c55d0e6..7621a5acb13e 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -252,7 +252,7 @@ static inline unsigned long pgd_pfn(pgd_t pgd)
 }
 
 #define p4d_leaf p4d_leaf
-static inline int p4d_leaf(p4d_t p4d)
+static inline bool p4d_leaf(p4d_t p4d)
 {
 	/* No 512 GiB pages yet */
 	return 0;
@@ -261,7 +261,7 @@ static inline int p4d_leaf(p4d_t p4d)
 #define pte_page(pte)	pfn_to_page(pte_pfn(pte))
 
 #define pmd_leaf pmd_leaf
-static inline int pmd_leaf(pmd_t pte)
+static inline bool pmd_leaf(pmd_t pte)
 {
 	return pmd_flags(pte) & _PAGE_PSE;
 }
@@ -1086,7 +1086,7 @@ static inline pmd_t *pud_pgtable(pud_t pud)
 #define pud_page(pud)	pfn_to_page(pud_pfn(pud))
 
 #define pud_leaf pud_leaf
-static inline int pud_leaf(pud_t pud)
+static inline bool pud_leaf(pud_t pud)
 {
 	return (pud_val(pud) & (_PAGE_PSE | _PAGE_PRESENT)) ==
 		(_PAGE_PSE | _PAGE_PRESENT);
@@ -1413,7 +1413,7 @@ static inline bool pgdp_maps_userspace(void *__ptr)
 }
 
 #define pgd_leaf	pgd_leaf
-static inline int pgd_leaf(pgd_t pgd) { return 0; }
+static inline bool pgd_leaf(pgd_t pgd) { return false; }
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 /*
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index a36cf4e124b0..85fc7554cd52 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1777,16 +1777,16 @@ typedef unsigned int pgtbl_mod_mask;
  * Only meaningful when called on a valid entry.
  */
 #ifndef pgd_leaf
-#define pgd_leaf(x)	0
+#define pgd_leaf(x)	false
 #endif
 #ifndef p4d_leaf
-#define p4d_leaf(x)	0
+#define p4d_leaf(x)	false
 #endif
 #ifndef pud_leaf
-#define pud_leaf(x)	0
+#define pud_leaf(x)	false
 #endif
 #ifndef pmd_leaf
-#define pmd_leaf(x)	0
+#define pmd_leaf(x)	false
 #endif
 
 #ifndef pgd_leaf_size
-- 
2.44.0


