Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2060E80D02D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344496AbjLKP5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344478AbjLKP5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:57:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5650E5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702310239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lrIUJZ6x1JeaI9Xj6nWMq9GTptSO/huW1R5CZYvfzvo=;
        b=MYMPNIJrFkWKlQjd4Nj5jE+WjyI259JNrFy53IVks/m3evAkrhw8lZTrUeX2z3exmK+kFw
        mL8VV33svvzlsfAZYwfEzhvu1ooSuyMNO0Ww0bqrOOlGDPM94FzW3o6mWYiW23H60mxywc
        6yPabYI+wol5Q5Oj1nH9N5UTGhWBHtM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-1tzqxM8YMK2PmJTvvwdWZQ-1; Mon,
 11 Dec 2023 10:57:13 -0500
X-MC-Unique: 1tzqxM8YMK2PmJTvvwdWZQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 864033C28644;
        Mon, 11 Dec 2023 15:57:12 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A5831121306;
        Mon, 11 Dec 2023 15:57:10 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH v1 06/39] mm/rmap: add hugetlb sanity checks
Date:   Mon, 11 Dec 2023 16:56:19 +0100
Message-ID: <20231211155652.131054-7-david@redhat.com>
In-Reply-To: <20231211155652.131054-1-david@redhat.com>
References: <20231211155652.131054-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's make sure we end up with the right folios in the right functions.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 7 +++++++
 mm/rmap.c            | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 4c0650e9f6db..e3857d26b944 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -217,6 +217,7 @@ void hugetlb_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
 static inline int hugetlb_try_dup_anon_rmap(struct folio *folio,
 		struct vm_area_struct *vma)
 {
+	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
 	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
 
 	if (PageAnonExclusive(&folio->page)) {
@@ -231,6 +232,7 @@ static inline int hugetlb_try_dup_anon_rmap(struct folio *folio,
 /* See page_try_share_anon_rmap() */
 static inline int hugetlb_try_share_anon_rmap(struct folio *folio)
 {
+	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
 	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
 	VM_WARN_ON_FOLIO(!PageAnonExclusive(&folio->page), folio);
 
@@ -253,6 +255,7 @@ static inline int hugetlb_try_share_anon_rmap(struct folio *folio)
 
 static inline void hugetlb_add_file_rmap(struct folio *folio)
 {
+	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
 	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
 
 	atomic_inc(&folio->_entire_mapcount);
@@ -260,11 +263,15 @@ static inline void hugetlb_add_file_rmap(struct folio *folio)
 
 static inline void hugetlb_remove_rmap(struct folio *folio)
 {
+	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
+
 	atomic_dec(&folio->_entire_mapcount);
 }
 
 static inline void __page_dup_rmap(struct page *page, bool compound)
 {
+	VM_WARN_ON(folio_test_hugetlb(page_folio(page)));
+
 	if (compound) {
 		struct folio *folio = (struct folio *)page;
 
diff --git a/mm/rmap.c b/mm/rmap.c
index e210ac1b73de..41597da14f26 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1343,6 +1343,7 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 {
 	int nr = folio_nr_pages(folio);
 
+	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 	VM_BUG_ON_VMA(address < vma->vm_start ||
 			address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
 	__folio_set_swapbacked(folio);
@@ -1395,6 +1396,7 @@ void folio_add_file_rmap_range(struct folio *folio, struct page *page,
 	unsigned int nr_pmdmapped = 0, first;
 	int nr = 0;
 
+	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 	VM_WARN_ON_FOLIO(compound && !folio_test_pmd_mappable(folio), folio);
 
 	/* Is page being mapped by PTE? Is this its first map to be added? */
@@ -1480,6 +1482,7 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
 	bool last;
 	enum node_stat_item idx;
 
+	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 	VM_BUG_ON_PAGE(compound && !PageHead(page), page);
 
 	/* Is page being unmapped by PTE? Is this its last map to be removed? */
@@ -2632,6 +2635,7 @@ void rmap_walk_locked(struct folio *folio, struct rmap_walk_control *rwc)
 void hugetlb_add_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 		unsigned long address, rmap_t flags)
 {
+	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
 	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
 
 	atomic_inc(&folio->_entire_mapcount);
@@ -2644,6 +2648,8 @@ void hugetlb_add_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
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

