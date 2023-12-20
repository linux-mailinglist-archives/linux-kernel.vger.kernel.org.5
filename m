Return-Path: <linux-kernel+bounces-7540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A6C81A960
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67FCC1C231F1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F8F4E1C6;
	Wed, 20 Dec 2023 22:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hYqtFG22"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C994E1A5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mdoP1mKHev+ysUrRTdfAENapfdNdps+V0pIhMC543AQ=;
	b=hYqtFG22CAKkpD8DYrLLcPMtYKF/zT82ukF2VcRgQS7rNJ/lnDq8PiG4BMy61Noei1bFUw
	iYofkWvd6yYNGXkWabJ/A8t7V61CprEjmuHmXMu+W6O7nO0Y6lDVtvp+3hzjk3WgrFm6qV
	BhX+mT2GGls/YHsfIQMrku2bNY+LVpY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-BWaSJ04ZMwKSE-3aJaWQ3A-1; Wed, 20 Dec 2023 17:45:47 -0500
X-MC-Unique: BWaSJ04ZMwKSE-3aJaWQ3A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39804863B84;
	Wed, 20 Dec 2023 22:45:47 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B7D4F40C6EB9;
	Wed, 20 Dec 2023 22:45:44 +0000 (UTC)
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
Subject: [PATCH v2 15/40] mm/huge_memory: batch rmap operations in __split_huge_pmd_locked()
Date: Wed, 20 Dec 2023 23:44:39 +0100
Message-ID: <20231220224504.646757-16-david@redhat.com>
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

Let's use folio_add_anon_rmap_ptes(), batching the rmap operations.

While at it, use more folio operations (but only in the code branch we're
touching), use VM_WARN_ON_FOLIO(), and pass RMAP_EXCLUSIVE instead of
manually setting PageAnonExclusive.

We should never see non-anon pages on that branch: otherwise, the
existing page_add_anon_rmap() call would have been flawed already.

Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index bce6f987f36a3..d4c5d22d16117 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2398,6 +2398,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long haddr, bool freeze)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	struct folio *folio;
 	struct page *page;
 	pgtable_t pgtable;
 	pmd_t old_pmd, _pmd;
@@ -2493,16 +2494,18 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		uffd_wp = pmd_swp_uffd_wp(old_pmd);
 	} else {
 		page = pmd_page(old_pmd);
+		folio = page_folio(page);
 		if (pmd_dirty(old_pmd)) {
 			dirty = true;
-			SetPageDirty(page);
+			folio_set_dirty(folio);
 		}
 		write = pmd_write(old_pmd);
 		young = pmd_young(old_pmd);
 		soft_dirty = pmd_soft_dirty(old_pmd);
 		uffd_wp = pmd_uffd_wp(old_pmd);
 
-		VM_BUG_ON_PAGE(!page_count(page), page);
+		VM_WARN_ON_FOLIO(!folio_ref_count(folio), folio);
+		VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
 
 		/*
 		 * Without "freeze", we'll simply split the PMD, propagating the
@@ -2519,11 +2522,18 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		 *
 		 * See page_try_share_anon_rmap(): invalidate PMD first.
 		 */
-		anon_exclusive = PageAnon(page) && PageAnonExclusive(page);
+		anon_exclusive = PageAnonExclusive(page);
 		if (freeze && anon_exclusive && page_try_share_anon_rmap(page))
 			freeze = false;
-		if (!freeze)
-			page_ref_add(page, HPAGE_PMD_NR - 1);
+		if (!freeze) {
+			rmap_t rmap_flags = RMAP_NONE;
+
+			folio_ref_add(folio, HPAGE_PMD_NR - 1);
+			if (anon_exclusive)
+				rmap_flags |= RMAP_EXCLUSIVE;
+			folio_add_anon_rmap_ptes(folio, page, HPAGE_PMD_NR,
+						 vma, haddr, rmap_flags);
+		}
 	}
 
 	/*
@@ -2566,8 +2576,6 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			entry = mk_pte(page + i, READ_ONCE(vma->vm_page_prot));
 			if (write)
 				entry = pte_mkwrite(entry, vma);
-			if (anon_exclusive)
-				SetPageAnonExclusive(page + i);
 			if (!young)
 				entry = pte_mkold(entry);
 			/* NOTE: this may set soft-dirty too on some archs */
@@ -2577,7 +2585,6 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 				entry = pte_mksoft_dirty(entry);
 			if (uffd_wp)
 				entry = pte_mkuffd_wp(entry);
-			page_add_anon_rmap(page + i, vma, addr, RMAP_NONE);
 		}
 		VM_BUG_ON(!pte_none(ptep_get(pte)));
 		set_pte_at(mm, addr, pte, entry);
-- 
2.43.0


