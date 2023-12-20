Return-Path: <linux-kernel+bounces-7530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C83A381A94D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7A6283FFB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460F94C3C8;
	Wed, 20 Dec 2023 22:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OMguaNlZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF644C3B6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mTgg+xMXQdacmBIURVO4NXuqVVzQK4rkW7J9Pz1Od1g=;
	b=OMguaNlZPxU0XYBLdbuBPw1r7WH+hbxY08SPeSPIDoFz2NQ+UBsrQOIUWQ+hcKf37aZrVp
	T3LH8urMgbir08uwJz7ZNrVwVCW6fJwQQjyhWSyLoVb2cnxDFWfwDo+Cxuze+TKYImrULD
	QS46K8v99PPdNlps6XqXBn0j3P3I2ag=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-WcUjTUD5MXKhfmT8SK5HuA-1; Wed, 20 Dec 2023 17:45:21 -0500
X-MC-Unique: WcUjTUD5MXKhfmT8SK5HuA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 793E986EB22;
	Wed, 20 Dec 2023 22:45:20 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1E03C40C6EB9;
	Wed, 20 Dec 2023 22:45:17 +0000 (UTC)
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
Subject: [PATCH v2 05/40] mm/rmap: introduce and use hugetlb_try_share_anon_rmap()
Date: Wed, 20 Dec 2023 23:44:29 +0100
Message-ID: <20231220224504.646757-6-david@redhat.com>
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

Note that try_to_unmap_one() does not need care. Easy to spot because
among all that nasty hugetlb special-casing in that function, we're not
using set_huge_pte_at() on the anon path -- well, and that code assumes
that we would want to swapout.

Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 25 +++++++++++++++++++++++++
 mm/rmap.c            | 15 ++++++++++-----
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 5f26752de945c..d6fefa0f04105 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -227,6 +227,30 @@ static inline int hugetlb_try_dup_anon_rmap(struct folio *folio,
 	return 0;
 }
 
+/* See page_try_share_anon_rmap() */
+static inline int hugetlb_try_share_anon_rmap(struct folio *folio)
+{
+	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
+	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
+	VM_WARN_ON_FOLIO(!PageAnonExclusive(&folio->page), folio);
+
+	/* Paired with the memory barrier in try_grab_folio(). */
+	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP))
+		smp_mb();
+
+	if (unlikely(folio_maybe_dma_pinned(folio)))
+		return -EBUSY;
+	ClearPageAnonExclusive(&folio->page);
+
+	/*
+	 * This is conceptually a smp_wmb() paired with the smp_rmb() in
+	 * gup_must_unshare().
+	 */
+	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP))
+		smp_mb__after_atomic();
+	return 0;
+}
+
 static inline void hugetlb_add_file_rmap(struct folio *folio)
 {
 	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
@@ -331,6 +355,7 @@ static inline int page_try_dup_anon_rmap(struct page *page, bool compound,
  */
 static inline int page_try_share_anon_rmap(struct page *page)
 {
+	VM_WARN_ON(folio_test_hugetlb(page_folio(page)));
 	VM_BUG_ON_PAGE(!PageAnon(page) || !PageAnonExclusive(page), page);
 
 	/* device private pages cannot get pinned via GUP. */
diff --git a/mm/rmap.c b/mm/rmap.c
index a57ec926daf0c..c229e48cf5a9e 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2149,13 +2149,18 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 				       !anon_exclusive, subpage);
 
 			/* See page_try_share_anon_rmap(): clear PTE first. */
-			if (anon_exclusive &&
-			    page_try_share_anon_rmap(subpage)) {
-				if (folio_test_hugetlb(folio))
+			if (folio_test_hugetlb(folio)) {
+				if (anon_exclusive &&
+				    hugetlb_try_share_anon_rmap(folio)) {
 					set_huge_pte_at(mm, address, pvmw.pte,
 							pteval, hsz);
-				else
-					set_pte_at(mm, address, pvmw.pte, pteval);
+					ret = false;
+					page_vma_mapped_walk_done(&pvmw);
+					break;
+				}
+			} else if (anon_exclusive &&
+				   page_try_share_anon_rmap(subpage)) {
+				set_pte_at(mm, address, pvmw.pte, pteval);
 				ret = false;
 				page_vma_mapped_walk_done(&pvmw);
 				break;
-- 
2.43.0


