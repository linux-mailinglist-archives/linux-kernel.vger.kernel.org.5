Return-Path: <linux-kernel+bounces-7604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A4581AABC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD26C1C238B7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F5279953;
	Wed, 20 Dec 2023 22:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FLuJJv/N"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3AD79948
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9XkiTziRJNAJJWRX4gshftH/Gk4w9uSE1IPr6jMrvv0=;
	b=FLuJJv/NGSs52X47AWDQeItoiey9nMqObOEkxpYx2C2HPw3m0KaTdCHY32HBLIPFR16fSL
	u4BMFVNsycp809VGV2pFdFqtH2MQ6o8+rohgF3UEy79s16tBxNCAck2wBXmxUK+eInjXIo
	EzDD9mWpeDI8YQluPGOuitc3fHBD8GA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-NmSSg2uJMuaP3fhgO4P08A-1; Wed,
 20 Dec 2023 17:46:44 -0500
X-MC-Unique: NmSSg2uJMuaP3fhgO4P08A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62C1E38425AD;
	Wed, 20 Dec 2023 22:46:44 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 61C2740C6EB9;
	Wed, 20 Dec 2023 22:46:42 +0000 (UTC)
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
Subject: [PATCH v2 37/40] mm/rmap: remove page_try_dup_anon_rmap()
Date: Wed, 20 Dec 2023 23:45:01 +0100
Message-ID: <20231220224504.646757-38-david@redhat.com>
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

All users are gone, remove page_try_dup_anon_rmap() and any remaining
traces.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 850aa74b6724c..0ad2ea2734e4a 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -253,7 +253,7 @@ void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
 void hugetlb_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address);
 
-/* See page_try_dup_anon_rmap() */
+/* See folio_try_dup_anon_rmap_*() */
 static inline int hugetlb_try_dup_anon_rmap(struct folio *folio,
 		struct vm_area_struct *vma)
 {
@@ -478,16 +478,6 @@ static inline int folio_try_dup_anon_rmap_pmd(struct folio *folio,
 #endif
 }
 
-static inline int page_try_dup_anon_rmap(struct page *page, bool compound,
-					 struct vm_area_struct *vma)
-{
-	struct folio *folio = page_folio(page);
-
-	if (likely(!compound))
-		return folio_try_dup_anon_rmap_pte(folio, page, vma);
-	return folio_try_dup_anon_rmap_pmd(folio, page, vma);
-}
-
 /**
  * page_try_share_anon_rmap - try marking an exclusive anonymous page possibly
  *			      shared to prepare for KSM or temporary unmapping
@@ -496,8 +486,8 @@ static inline int page_try_dup_anon_rmap(struct page *page, bool compound,
  * The caller needs to hold the PT lock and has to have the page table entry
  * cleared/invalidated.
  *
- * This is similar to page_try_dup_anon_rmap(), however, not used during fork()
- * to duplicate a mapping, but instead to prepare for KSM or temporarily
+ * This is similar to folio_try_dup_anon_rmap_*(), however, not used during
+ * fork() to duplicate a mapping, but instead to prepare for KSM or temporarily
  * unmapping a page (swap, migration) via folio_remove_rmap_*().
  *
  * Marking the page shared can only fail if the page may be pinned; device
-- 
2.43.0


