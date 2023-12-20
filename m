Return-Path: <linux-kernel+bounces-7603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A58581AABB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD71283E39
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E2979951;
	Wed, 20 Dec 2023 22:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RWtcPZMO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E124A9B7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fTcpbW98US35msxaiX+BCXxL5QAKVhrGk2lkGfrSlfw=;
	b=RWtcPZMOs2ViklG1qKmVeBaCJjxoLP1zOd2tbhDo4FwsPb4HAUv1AC8L860z8OQzQ+leqj
	FcqPdnBbFXeFAUKBCYoxnngEWhC1oowRUKyKWIDBj7yXpufLM8edW1ATCDs7OSN7pDDToM
	EiQbFoZ5V9g5jVn0+Vc0hD/W7fd/Ht4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-7CmBAUaHOZWiWfdpU_xHgA-1; Wed, 20 Dec 2023 17:46:42 -0500
X-MC-Unique: 7CmBAUaHOZWiWfdpU_xHgA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 034AF85A58B;
	Wed, 20 Dec 2023 22:46:42 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8F08C40C6EB9;
	Wed, 20 Dec 2023 22:46:39 +0000 (UTC)
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
Subject: [PATCH v2 36/40] mm/memory: page_try_dup_anon_rmap() -> folio_try_dup_anon_rmap_pte()
Date: Wed, 20 Dec 2023 23:45:00 +0100
Message-ID: <20231220224504.646757-37-david@redhat.com>
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

Let's convert copy_nonpresent_pte(). While at it, perform some more
folio conversion.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index dc2a8e6858179..d995ead7a3933 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -785,6 +785,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	unsigned long vm_flags = dst_vma->vm_flags;
 	pte_t orig_pte = ptep_get(src_pte);
 	pte_t pte = orig_pte;
+	struct folio *folio;
 	struct page *page;
 	swp_entry_t entry = pte_to_swp_entry(orig_pte);
 
@@ -829,6 +830,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		}
 	} else if (is_device_private_entry(entry)) {
 		page = pfn_swap_entry_to_page(entry);
+		folio = page_folio(page);
 
 		/*
 		 * Update rss count even for unaddressable pages, as
@@ -839,10 +841,10 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		 * for unaddressable pages, at some point. But for now
 		 * keep things as they are.
 		 */
-		get_page(page);
+		folio_get(folio);
 		rss[mm_counter(page)]++;
 		/* Cannot fail as these pages cannot get pinned. */
-		BUG_ON(page_try_dup_anon_rmap(page, false, src_vma));
+		folio_try_dup_anon_rmap_pte(folio, page, src_vma);
 
 		/*
 		 * We do not preserve soft-dirty information, because so
@@ -956,7 +958,7 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		 * future.
 		 */
 		folio_get(folio);
-		if (unlikely(page_try_dup_anon_rmap(page, false, src_vma))) {
+		if (unlikely(folio_try_dup_anon_rmap_pte(folio, page, src_vma))) {
 			/* Page may be pinned, we have to copy. */
 			folio_put(folio);
 			return copy_present_page(dst_vma, src_vma, dst_pte, src_pte,
-- 
2.43.0


