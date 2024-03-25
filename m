Return-Path: <linux-kernel+bounces-117162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1736788A815
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3350A1C6297A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF97012F380;
	Mon, 25 Mar 2024 13:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VVw8RsVd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D7F12EBF5
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374098; cv=none; b=pODqu2AeGLjMoVaWCS+YatGWgnrU6qEO01unTSMA2E3OBgbKSiuMp0aSqDfAltzlRVlqyzecaGwfS2iCOqNSwNpdRgGiTVbElUkiPY+an4Y+i7GfMV11XYSzzPeIpjwjNecn1ddHc0K0k+ezV5Kbi788D39Bt7+NoJNGiR/xfoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374098; c=relaxed/simple;
	bh=ufmhHPno35Aswdh7/D26+ER0Egnsv57oShMgoyo921A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZrM1SdzckvzVxhd7ExTONAOXQKhUjbXf+aCd6PY3rh/bPaRWmFvEYrjTx7b9hGznGUVzdDTvNWDalqHzCWg1GJm/fWhFYRhyJvyMbSeTo+8BCzTG2eAObfh9Ii12gQqu1esKxCWSGU78Af+9MATx5BuNuDd6h41i4q/Uab+0Nvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VVw8RsVd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711374095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CokJpVlNHQkDeOM8Ax0bVh3dvCSI52pFoSUWrkagN08=;
	b=VVw8RsVdD4AFEcUu4arvjMGNaTtSAkqd9JbZufWzX5IKIcmXUQBcHjtQ9brMAkpjtRlPts
	UaxMJRi4HuN3ZVOwHgFJuxOrlpxqKyGSEDSsUzZcopKh3euBHcnuk1sQZ6d+OzeSzAkUzn
	6VojpoQqAmu4i1ovgGNDVQ9f/cn8CvA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-tEBRYUiQPDClGkgaC9S8ug-1; Mon, 25 Mar 2024 09:41:33 -0400
X-MC-Unique: tEBRYUiQPDClGkgaC9S8ug-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A2D5891E69;
	Mon, 25 Mar 2024 13:41:33 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.143])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B5DA62166B35;
	Mon, 25 Mar 2024 13:41:31 +0000 (UTC)
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
Subject: [PATCH v1 3/3] mm: merge folio_is_secretmem() into folio_fast_pin_allowed()
Date: Mon, 25 Mar 2024 14:41:14 +0100
Message-ID: <20240325134114.257544-4-david@redhat.com>
In-Reply-To: <20240325134114.257544-1-david@redhat.com>
References: <20240325134114.257544-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

folio_is_secretmem() is currently only used during GUP-fast, and using
it in wrong context where concurrent truncation might happen, could be
problematic.

Nowadays, folio_fast_pin_allowed() performs similar checks during
GUP-fast and contains a lot of careful handling -- READ_ONCE( -- ), sanity
checks -- lockdep_assert_irqs_disabled() --  and helpful comments on how
this handling is safe and correct.

So let's merge folio_is_secretmem() into folio_fast_pin_allowed(), still
avoiding checking the actual mapping only if really required.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/secretmem.h | 21 ++-------------------
 mm/gup.c                  | 33 +++++++++++++++++++++------------
 2 files changed, 23 insertions(+), 31 deletions(-)

diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
index 6996f1f53f14..e918f96881f5 100644
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
-	 * We know that secretmem pages are not compound and LRU so we can
-	 * save a couple of cycles here.
-	 */
-	if (folio_test_large(folio) || folio_test_lru(folio))
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
index e7510b6ce765..69d8bc8e4451 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2472,6 +2472,8 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
  * This call assumes the caller has pinned the folio, that the lowest page table
  * level still points to this folio, and that interrupts have been disabled.
  *
+ * GUP-fast must reject all secretmem folios.
+ *
  * Writing to pinned file-backed dirty tracked folios is inherently problematic
  * (see comment describing the writable_file_mapping_allowed() function). We
  * therefore try to avoid the most egregious case of a long-term mapping doing
@@ -2484,22 +2486,32 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
 static bool folio_fast_pin_allowed(struct folio *folio, unsigned int flags)
 {
 	struct address_space *mapping;
+	bool check_secretmem = false;
+	bool reject_file_backed = false;
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
+	/* secretmem folios are only order-0 folios and never LRU folios. */
+	if (IS_ENABLED(CONFIG_SECRETMEM) && !folio_test_large(folio) &&
+	    !folio_test_lru(folio))
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
 
@@ -2535,10 +2547,12 @@ static bool folio_fast_pin_allowed(struct folio *folio, unsigned int flags)
 
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
@@ -2624,11 +2638,6 @@ static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
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
-- 
2.43.2


