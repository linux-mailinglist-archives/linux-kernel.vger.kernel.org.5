Return-Path: <linux-kernel+bounces-7532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB46C81A950
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90EB71F24246
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC40F4AF6C;
	Wed, 20 Dec 2023 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eoTXJITF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B1E4C618
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w6z2XPcaQaFkvw9bopV7cZh6Qr6jUgqju9ezjmrboLY=;
	b=eoTXJITFpHJkUItZjnxNWkHAhQ3ZjJBJkSoJMfXMAAlsQ1sfGF+vhMDNDQosXjx1gj4wr1
	MOsS4xSluQZfig/x5t7TKI6vnQDHm5oPZQxAhBU/ic6DwyDrEH+rUpAZ6dWVWNYgp1dqKA
	LQlzIBuS0jFhEPnmbYDTtGPFZ3zA7kQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-ykSjz5bzOj2Bw6ZSVoP9RQ-1; Wed, 20 Dec 2023 17:45:23 -0500
X-MC-Unique: ykSjz5bzOj2Bw6ZSVoP9RQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 122D5848C03;
	Wed, 20 Dec 2023 22:45:23 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DA27740C6EB9;
	Wed, 20 Dec 2023 22:45:20 +0000 (UTC)
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
Subject: [PATCH v2 06/40] mm/rmap: add hugetlb sanity checks for anon rmap handling
Date: Wed, 20 Dec 2023 23:44:30 +0100
Message-ID: <20231220224504.646757-7-david@redhat.com>
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

Let's make sure we end up with the right folios in the right functions
when adding an anon rmap, just like we already do in the other rmap
functions.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/rmap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/rmap.c b/mm/rmap.c
index c229e48cf5a9e..6a1829324053e 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1262,6 +1262,8 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 	bool compound = flags & RMAP_COMPOUND;
 	bool first;
 
+	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
+
 	/* Is page being mapped by PTE? Is this its first map to be added? */
 	if (likely(!compound)) {
 		first = atomic_inc_and_test(&page->_mapcount);
@@ -1343,6 +1345,7 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 {
 	int nr = folio_nr_pages(folio);
 
+	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 	VM_BUG_ON_VMA(address < vma->vm_start ||
 			address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
 	__folio_set_swapbacked(folio);
@@ -2634,6 +2637,7 @@ void rmap_walk_locked(struct folio *folio, struct rmap_walk_control *rwc)
 void hugetlb_add_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 		unsigned long address, rmap_t flags)
 {
+	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
 	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
 
 	atomic_inc(&folio->_entire_mapcount);
@@ -2646,6 +2650,8 @@ void hugetlb_add_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 void hugetlb_add_new_anon_rmap(struct folio *folio,
 		struct vm_area_struct *vma, unsigned long address)
 {
+	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
+
 	BUG_ON(address < vma->vm_start || address >= vma->vm_end);
 	/* increment count (starts at -1) */
 	atomic_set(&folio->_entire_mapcount, 0);
-- 
2.43.0


