Return-Path: <linux-kernel+bounces-7596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4A181AAB0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B9211C21A3C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF087098B;
	Wed, 20 Dec 2023 22:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YteQwhqf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF4F68EB7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HrqmxJFgmC1fiGIelPJz980NZ2Q1oauxy+LU1liPb0o=;
	b=YteQwhqfUU9v0MfsjOjcE9sG12eSnuR7hn4JLPMkPQo9hNAwfOTHgw1N28dv98Y/WljNAB
	TtQSHaTbvR6NdBsaXB/yxCeVfHkQtyrE7fuKPeFZMBXarGeoR238hZ0xEdKeBGlbxw5Y95
	tjWbGw4IE70iXCE65NxPa/cN+Sg0VLA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-IzS3I1BaNGycfEoIX0J4Hw-1; Wed, 20 Dec 2023 17:46:26 -0500
X-MC-Unique: IzS3I1BaNGycfEoIX0J4Hw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99362863B83;
	Wed, 20 Dec 2023 22:46:25 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CDC2940C6EB9;
	Wed, 20 Dec 2023 22:46:22 +0000 (UTC)
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
Subject: [PATCH v2 30/40] mm/rmap: page_remove_rmap() -> folio_remove_rmap_pte()
Date: Wed, 20 Dec 2023 23:44:54 +0100
Message-ID: <20231220224504.646757-31-david@redhat.com>
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

Let's convert try_to_unmap_one() and try_to_migrate_one().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/rmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 1273180753953..a3ec2be484cfc 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1647,7 +1647,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
-	 * in between its ptep_get_and_clear_full() and page_remove_rmap(),
+	 * in between its ptep_get_and_clear_full() and folio_remove_rmap_*(),
 	 * try_to_unmap() may return before page_mapped() has become false,
 	 * if page table locking is skipped: use TTU_SYNC to wait for that.
 	 */
@@ -1928,7 +1928,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		if (unlikely(folio_test_hugetlb(folio)))
 			hugetlb_remove_rmap(folio);
 		else
-			page_remove_rmap(subpage, vma, false);
+			folio_remove_rmap_pte(folio, subpage, vma);
 		if (vma->vm_flags & VM_LOCKED)
 			mlock_drain_local();
 		folio_put(folio);
@@ -1996,7 +1996,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
-	 * in between its ptep_get_and_clear_full() and page_remove_rmap(),
+	 * in between its ptep_get_and_clear_full() and folio_remove_rmap_*(),
 	 * try_to_migrate() may return before page_mapped() has become false,
 	 * if page table locking is skipped: use TTU_SYNC to wait for that.
 	 */
@@ -2289,7 +2289,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 		if (unlikely(folio_test_hugetlb(folio)))
 			hugetlb_remove_rmap(folio);
 		else
-			page_remove_rmap(subpage, vma, false);
+			folio_remove_rmap_pte(folio, subpage, vma);
 		if (vma->vm_flags & VM_LOCKED)
 			mlock_drain_local();
 		folio_put(folio);
@@ -2428,7 +2428,7 @@ static bool page_make_device_exclusive_one(struct folio *folio,
 		 * There is a reference on the page for the swap entry which has
 		 * been removed, so shouldn't take another.
 		 */
-		page_remove_rmap(subpage, vma, false);
+		folio_remove_rmap_pte(folio, subpage, vma);
 	}
 
 	mmu_notifier_invalidate_range_end(&range);
-- 
2.43.0


