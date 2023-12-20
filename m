Return-Path: <linux-kernel+bounces-7529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD4481A94C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A7228428F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB414BAA0;
	Wed, 20 Dec 2023 22:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OWTzei8a"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A804B5A7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TnwuPzh6vqXFM/JzpFan02MNs+lZlbvUqepTeKYzv68=;
	b=OWTzei8agv5dk0zqVJX+/pcd6pnLltQVoBLKipaTVAvbGQBEeu+Nr35K46XGpaHxtze2Ev
	xzN1ywi1tKVZO6MCLxdzPHKE4VNPqFU75lIB5YBIcnUEhik8CscQTxmA+S2BCbdO8EWo0Q
	lz3+Z+TzYv0IA1z04ww9SHbcPfzac9g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-jRqZUihhOO6Rc9G1XGUnEA-1; Wed,
 20 Dec 2023 17:45:18 -0500
X-MC-Unique: jRqZUihhOO6Rc9G1XGUnEA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B24DC1C41B26;
	Wed, 20 Dec 2023 22:45:17 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 899DD40C6EB9;
	Wed, 20 Dec 2023 22:45:15 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 04/40] mm/rmap: introduce and use hugetlb_try_dup_anon_rmap()
Date: Wed, 20 Dec 2023 23:44:28 +0100
Message-ID: <20231220224504.646757-5-david@redhat.com>
In-Reply-To: <20231220224504.646757-1-david@redhat.com>
References: <20231220224504.646757-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

hugetlb rmap handling differs quite a lot from "ordinary" rmap code.
For example, hugetlb currently only supports entire mappings, and treats
any mapping as mapped using a single "logical PTE". Let's move it out
of the way so we can overhaul our "ordinary" rmap.
implementation/interface.

So let's introduce and use hugetlb_try_dup_anon_rmap() to make all
hugetlb handling use dedicated hugetlb_* rmap functions.

Add sanity checks that we end up with the right folios in the right
functions.

Note that is_device_private_page() does not apply to hugetlb.

Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h   | 12 +++++++++---
 include/linux/rmap.h | 18 ++++++++++++++++++
 mm/hugetlb.c         |  3 +--
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b72bf25a45cfd..ae547b62f3252 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1964,15 +1964,21 @@ static inline bool page_maybe_dma_pinned(struct page *page)
  *
  * The caller has to hold the PT lock and the vma->vm_mm->->write_protect_seq.
  */
-static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
-					  struct page *page)
+static inline bool folio_needs_cow_for_dma(struct vm_area_struct *vma,
+					  struct folio *folio)
 {
 	VM_BUG_ON(!(raw_read_seqcount(&vma->vm_mm->write_protect_seq) & 1));
 
 	if (!test_bit(MMF_HAS_PINNED, &vma->vm_mm->flags))
 		return false;
 
-	return page_maybe_dma_pinned(page);
+	return folio_maybe_dma_pinned(folio);
+}
+
+static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
+					  struct page *page)
+{
+	return folio_needs_cow_for_dma(vma, page_folio(page));
 }
 
 /**
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 56900a16f41a6..5f26752de945c 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -211,6 +211,22 @@ void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
 void hugetlb_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address);
 
+/* See page_try_dup_anon_rmap() */
+static inline int hugetlb_try_dup_anon_rmap(struct folio *folio,
+		struct vm_area_struct *vma)
+{
+	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
+	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
+
+	if (PageAnonExclusive(&folio->page)) {
+		if (unlikely(folio_needs_cow_for_dma(vma, folio)))
+			return -EBUSY;
+		ClearPageAnonExclusive(&folio->page);
+	}
+	atomic_inc(&folio->_entire_mapcount);
+	return 0;
+}
+
 static inline void hugetlb_add_file_rmap(struct folio *folio)
 {
 	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
@@ -228,6 +244,8 @@ static inline void hugetlb_remove_rmap(struct folio *folio)
 
 static inline void __page_dup_rmap(struct page *page, bool compound)
 {
+	VM_WARN_ON(folio_test_hugetlb(page_folio(page)));
+
 	if (compound) {
 		struct folio *folio = (struct folio *)page;
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 57e8981879314..378e460a6ab41 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5409,8 +5409,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			 */
 			if (!folio_test_anon(pte_folio)) {
 				hugetlb_add_file_rmap(pte_folio);
-			} else if (page_try_dup_anon_rmap(&pte_folio->page,
-							  true, src_vma)) {
+			} else if (hugetlb_try_dup_anon_rmap(pte_folio, src_vma)) {
 				pte_t src_pte_old = entry;
 				struct folio *new_folio;
 
-- 
2.43.0


