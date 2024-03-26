Return-Path: <linux-kernel+bounces-119184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB35388C533
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0D91F3DB17
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FED813C3D2;
	Tue, 26 Mar 2024 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I8XCaH3M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D357413C3C6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711463569; cv=none; b=OeL79u4Jtoz+yBSryXWjTUAq9NhRMNNIkbmatvYtNIbXhOPjiL5wAB40BJIT+WTqbuOUO/fiUc1o0N2ZdOKFnoqP2lmr3ljf6iwZPfdQ3USNYwvQOhConftyrF61YoCBf8a0aN76OUo8q8C6Vb7+DfeHBKl3KvzJPeNmfpPADaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711463569; c=relaxed/simple;
	bh=Ft/fl115PWaojyHnfcG8GXvmIPoq3i6y0/vZnrjpc5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhBBm6pbjL1VSN7rCe9jswvQsUaK4Q+jfQWMO/Z12pZLWgaMJN6l6BcmZ/fkS9HZIDk2zf5hRduFX3gRU9IT5gW3Pm3S5w0SkbPJ8FsX4PmjzC/LhWF10o74Sxo+kOT4q0/RevNjleMEOJq/XCt0CgpIlgRB4Z0Y0q8OwrM9f70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I8XCaH3M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711463566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZdlw1b/kcLUrflUxwTe3odXoIWBotMqjI0wjKr5kQg=;
	b=I8XCaH3MriK0krX9t8Bk33sAUo91Ul5JveN3GaRcSzM8ZGaxIBq1+8sUmftkJOoU0KQmFc
	agxhvV0sEHzHHJdzzIh79ORVUSMnvbzlORpopzUYevhhvpDCr8H5VJlbklKzHFXEec8TvV
	sWZvQJh+OuBOF9NAh/4zO5YYUaFw1Rk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-AuwEDpdsMcGdxkD-3r8M6g-1; Tue, 26 Mar 2024 10:32:43 -0400
X-MC-Unique: AuwEDpdsMcGdxkD-3r8M6g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B404D800266;
	Tue, 26 Mar 2024 14:32:42 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.164])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 43F7540D2982;
	Tue, 26 Mar 2024 14:32:40 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	xingwei lee <xrivendell7@gmail.com>,
	yue sun <samsun1006219@gmail.com>
Subject: [PATCH v2 3/3] mm: merge folio_is_secretmem() and folio_fast_pin_allowed() into gup_fast_folio_allowed()
Date: Tue, 26 Mar 2024 15:32:10 +0100
Message-ID: <20240326143210.291116-4-david@redhat.com>
In-Reply-To: <20240326143210.291116-1-david@redhat.com>
References: <20240326143210.291116-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

folio_is_secretmem() is currently only used during GUP-fast. Nowadays,
folio_fast_pin_allowed() performs similar checks during GUP-fast and
contains a lot of careful handling -- READ_ONCE() -- , sanity checks --
lockdep_assert_irqs_disabled() --  and helpful comments on how this
handling is safe and correct.

So let's merge folio_is_secretmem() into folio_fast_pin_allowed(). Rename
folio_fast_pin_allowed() to gup_fast_folio_allowed(), to better match the
new semantics.

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/secretmem.h | 21 ++---------------
 mm/gup.c                  | 48 +++++++++++++++++++++++----------------
 2 files changed, 30 insertions(+), 39 deletions(-)

diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
index acf7e1a3f3de..e918f96881f5 100644
--- a/include/linux/secretmem.h
+++ b/include/linux/secretmem.h
@@ -6,25 +6,8 @@
 
 extern const struct address_space_operations secretmem_aops;
 
-static inline bool folio_is_secretmem(struct folio *folio)
+static inline bool secretmem_mapping(struct address_space *mapping)
 {
-	struct address_space *mapping;
-
-	/*
-	 * Using folio_mapping() is quite slow because of the actual call
-	 * instruction.
-	 * We know that secretmem pages are not compound, so we can
-	 * save a couple of cycles here.
-	 */
-	if (folio_test_large(folio))
-		return false;
-
-	mapping = (struct address_space *)
-		((unsigned long)folio->mapping & ~PAGE_MAPPING_FLAGS);
-
-	if (!mapping || mapping != folio->mapping)
-		return false;
-
 	return mapping->a_ops == &secretmem_aops;
 }
 
@@ -38,7 +21,7 @@ static inline bool vma_is_secretmem(struct vm_area_struct *vma)
 	return false;
 }
 
-static inline bool folio_is_secretmem(struct folio *folio)
+static inline bool secretmem_mapping(struct address_space *mapping)
 {
 	return false;
 }
diff --git a/mm/gup.c b/mm/gup.c
index e7510b6ce765..03b74b148e30 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2466,12 +2466,14 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
 #ifdef CONFIG_HAVE_FAST_GUP
 
 /*
- * Used in the GUP-fast path to determine whether a pin is permitted for a
- * specific folio.
+ * Used in the GUP-fast path to determine whether GUP is permitted to work on
+ * a specific folio.
  *
  * This call assumes the caller has pinned the folio, that the lowest page table
  * level still points to this folio, and that interrupts have been disabled.
  *
+ * GUP-fast must reject all secretmem folios.
+ *
  * Writing to pinned file-backed dirty tracked folios is inherently problematic
  * (see comment describing the writable_file_mapping_allowed() function). We
  * therefore try to avoid the most egregious case of a long-term mapping doing
@@ -2481,25 +2483,34 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
  * in the fast path, so instead we whitelist known good cases and if in doubt,
  * fall back to the slow path.
  */
-static bool folio_fast_pin_allowed(struct folio *folio, unsigned int flags)
+static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
 {
+	bool reject_file_backed = false;
 	struct address_space *mapping;
+	bool check_secretmem = false;
 	unsigned long mapping_flags;
 
 	/*
 	 * If we aren't pinning then no problematic write can occur. A long term
 	 * pin is the most egregious case so this is the one we disallow.
 	 */
-	if ((flags & (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE)) !=
+	if ((flags & (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE)) ==
 	    (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE))
-		return true;
+		reject_file_backed = true;
+
+	/* We hold a folio reference, so we can safely access folio fields. */
 
-	/* The folio is pinned, so we can safely access folio fields. */
+	/* secretmem folios are always order-0 folios. */
+	if (IS_ENABLED(CONFIG_SECRETMEM) && !folio_test_large(folio))
+		check_secretmem = true;
+
+	if (!reject_file_backed && !check_secretmem)
+		return true;
 
 	if (WARN_ON_ONCE(folio_test_slab(folio)))
 		return false;
 
-	/* hugetlb mappings do not require dirty-tracking. */
+	/* hugetlb neither requires dirty-tracking nor can be secretmem. */
 	if (folio_test_hugetlb(folio))
 		return true;
 
@@ -2535,10 +2546,12 @@ static bool folio_fast_pin_allowed(struct folio *folio, unsigned int flags)
 
 	/*
 	 * At this point, we know the mapping is non-null and points to an
-	 * address_space object. The only remaining whitelisted file system is
-	 * shmem.
+	 * address_space object.
 	 */
-	return shmem_mapping(mapping);
+	if (check_secretmem && secretmem_mapping(mapping))
+		return false;
+	/* The only remaining allowed file system is shmem. */
+	return !reject_file_backed || shmem_mapping(mapping);
 }
 
 static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
@@ -2624,18 +2637,13 @@ static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 		if (!folio)
 			goto pte_unmap;
 
-		if (unlikely(folio_is_secretmem(folio))) {
-			gup_put_folio(folio, 1, flags);
-			goto pte_unmap;
-		}
-
 		if (unlikely(pmd_val(pmd) != pmd_val(*pmdp)) ||
 		    unlikely(pte_val(pte) != pte_val(ptep_get(ptep)))) {
 			gup_put_folio(folio, 1, flags);
 			goto pte_unmap;
 		}
 
-		if (!folio_fast_pin_allowed(folio, flags)) {
+		if (!gup_fast_folio_allowed(folio, flags)) {
 			gup_put_folio(folio, 1, flags);
 			goto pte_unmap;
 		}
@@ -2832,7 +2840,7 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 		return 0;
 	}
 
-	if (!folio_fast_pin_allowed(folio, flags)) {
+	if (!gup_fast_folio_allowed(folio, flags)) {
 		gup_put_folio(folio, refs, flags);
 		return 0;
 	}
@@ -2903,7 +2911,7 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 		return 0;
 	}
 
-	if (!folio_fast_pin_allowed(folio, flags)) {
+	if (!gup_fast_folio_allowed(folio, flags)) {
 		gup_put_folio(folio, refs, flags);
 		return 0;
 	}
@@ -2947,7 +2955,7 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 		return 0;
 	}
 
-	if (!folio_fast_pin_allowed(folio, flags)) {
+	if (!gup_fast_folio_allowed(folio, flags)) {
 		gup_put_folio(folio, refs, flags);
 		return 0;
 	}
@@ -2992,7 +3000,7 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
 		return 0;
 	}
 
-	if (!folio_fast_pin_allowed(folio, flags)) {
+	if (!gup_fast_folio_allowed(folio, flags)) {
 		gup_put_folio(folio, refs, flags);
 		return 0;
 	}
-- 
2.43.2


