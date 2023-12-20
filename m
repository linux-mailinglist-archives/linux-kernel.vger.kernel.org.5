Return-Path: <linux-kernel+bounces-7537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFDB81A95A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004661F241AB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291164D125;
	Wed, 20 Dec 2023 22:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M7pnIPf+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E3B4CE14
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ylNzjWXs3fCxjx+PVR/JHpztU6Uk8qsi+uFdQ6XNBcU=;
	b=M7pnIPf+Pq6jzqX0nWN6inEKJ76P76R3DR67P4P78RAB7RTnDZ/Y3WOh07CNLb/GblA/4H
	8us2O57PmeZSrXQ4xhsFlRv+AyjmAsYOwgMTiMTrEYwxwoH1frlQEsgqsDwl1ncki0VVI8
	OUfAxYYxyKH+L5+ZRZVU+MQ9K+5Bexs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-VNQ_qnwZMhu9M2ICFtPKHQ-1; Wed, 20 Dec 2023 17:45:38 -0500
X-MC-Unique: VNQ_qnwZMhu9M2ICFtPKHQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33DEF185A780;
	Wed, 20 Dec 2023 22:45:38 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5D67340C6EB9;
	Wed, 20 Dec 2023 22:45:36 +0000 (UTC)
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
Subject: [PATCH v2 12/40] mm/rmap: remove page_add_file_rmap()
Date: Wed, 20 Dec 2023 23:44:36 +0100
Message-ID: <20231220224504.646757-13-david@redhat.com>
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

All users are gone, let's remove it.

Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h |  2 --
 mm/rmap.c            | 21 ---------------------
 2 files changed, 23 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 3d86a76b28368..6a4db6933e7df 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -237,8 +237,6 @@ void page_add_anon_rmap(struct page *, struct vm_area_struct *,
 		unsigned long address, rmap_t flags);
 void folio_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address);
-void page_add_file_rmap(struct page *, struct vm_area_struct *,
-		bool compound);
 void folio_add_file_rmap_ptes(struct folio *, struct page *, int nr_pages,
 		struct vm_area_struct *);
 #define folio_add_file_rmap_pte(folio, page, vma) \
diff --git a/mm/rmap.c b/mm/rmap.c
index cc1fc2d570f0d..5ab5ef10fbf5e 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1467,27 +1467,6 @@ void folio_add_file_rmap_pmd(struct folio *folio, struct page *page,
 #endif
 }
 
-/**
- * page_add_file_rmap - add pte mapping to a file page
- * @page:	the page to add the mapping to
- * @vma:	the vm area in which the mapping is added
- * @compound:	charge the page as compound or small page
- *
- * The caller needs to hold the pte lock.
- */
-void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
-		bool compound)
-{
-	struct folio *folio = page_folio(page);
-
-	VM_WARN_ON_ONCE_PAGE(compound && !PageTransHuge(page), page);
-
-	if (likely(!compound))
-		folio_add_file_rmap_pte(folio, page, vma);
-	else
-		folio_add_file_rmap_pmd(folio, page, vma);
-}
-
 /**
  * page_remove_rmap - take down pte mapping from a page
  * @page:	page to remove mapping from
-- 
2.43.0


