Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2329480D035
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344587AbjLKP5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344502AbjLKP5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:57:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E324FEA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702310255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FoY+MxvyMEZDCAVG6BwT9WrYolbRNCvL6DZB18ZE48E=;
        b=hlziBPpc8r1ZZO8+Jyjlj0lLR7Gs9viG31ZMTnbj6hltoT/6pZ8cs4T3TYB8ECSjDWeY19
        sM/v4SK8LQwfU3yLpu/FgkJBLpU/zCrxwtDXGOdd2/YmhWRq/JrHzRLAdWp52pjisp21Xh
        j6sRGqQ6e14bqFLq8+BqYGRgWQ9nJjo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-2BLn_LvuPamqZYZJzhfDrg-1; Mon, 11 Dec 2023 10:57:29 -0500
X-MC-Unique: 2BLn_LvuPamqZYZJzhfDrg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1EEF9870822;
        Mon, 11 Dec 2023 15:57:29 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D51861121306;
        Mon, 11 Dec 2023 15:57:26 +0000 (UTC)
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
Subject: [PATCH v1 13/39] mm/rmap: factor out adding folio mappings into __folio_add_rmap()
Date:   Mon, 11 Dec 2023 16:56:26 +0100
Message-ID: <20231211155652.131054-14-david@redhat.com>
In-Reply-To: <20231211155652.131054-1-david@redhat.com>
References: <20231211155652.131054-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's factor it out to prepare for reuse as we convert
page_add_anon_rmap() to folio_add_anon_rmap_[pte|ptes|pmd]().

Make the compiler always special-case on the granularity by using
__always_inline.

Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/rmap.c | 81 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 45 insertions(+), 36 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 2ff2f11275e5..c5761986a411 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1157,6 +1157,49 @@ int folio_total_mapcount(struct folio *folio)
 	return mapcount;
 }
 
+static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
+		struct page *page, int nr_pages, enum rmap_mode mode,
+		unsigned int *nr_pmdmapped)
+{
+	atomic_t *mapped = &folio->_nr_pages_mapped;
+	int first, nr = 0;
+
+	__folio_rmap_sanity_checks(folio, page, nr_pages, mode);
+
+	/* Is page being mapped by PTE? Is this its first map to be added? */
+	switch (mode) {
+	case RMAP_MODE_PTE:
+		do {
+			first = atomic_inc_and_test(&page->_mapcount);
+			if (first && folio_test_large(folio)) {
+				first = atomic_inc_return_relaxed(mapped);
+				first = (first < COMPOUND_MAPPED);
+			}
+
+			if (first)
+				nr++;
+		} while (page++, --nr_pages > 0);
+		break;
+	case RMAP_MODE_PMD:
+		first = atomic_inc_and_test(&folio->_entire_mapcount);
+		if (first) {
+			nr = atomic_add_return_relaxed(COMPOUND_MAPPED, mapped);
+			if (likely(nr < COMPOUND_MAPPED + COMPOUND_MAPPED)) {
+				*nr_pmdmapped = folio_nr_pages(folio);
+				nr = *nr_pmdmapped - (nr & FOLIO_PAGES_MAPPED);
+				/* Raced ahead of a remove and another add? */
+				if (unlikely(nr < 0))
+					nr = 0;
+			} else {
+				/* Raced ahead of a remove of COMPOUND_MAPPED */
+				nr = 0;
+			}
+		}
+		break;
+	}
+	return nr;
+}
+
 /**
  * folio_move_anon_rmap - move a folio to our anon_vma
  * @folio:	The folio to move to our anon_vma
@@ -1380,45 +1423,11 @@ static __always_inline void __folio_add_file_rmap(struct folio *folio,
 		struct page *page, int nr_pages, struct vm_area_struct *vma,
 		enum rmap_mode mode)
 {
-	atomic_t *mapped = &folio->_nr_pages_mapped;
-	unsigned int nr_pmdmapped = 0, first;
-	int nr = 0;
+	unsigned int nr, nr_pmdmapped = 0;
 
 	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
-	__folio_rmap_sanity_checks(folio, page, nr_pages, mode);
-
-	/* Is page being mapped by PTE? Is this its first map to be added? */
-	switch (mode) {
-	case RMAP_MODE_PTE:
-		do {
-			first = atomic_inc_and_test(&page->_mapcount);
-			if (first && folio_test_large(folio)) {
-				first = atomic_inc_return_relaxed(mapped);
-				first = (first < COMPOUND_MAPPED);
-			}
-
-			if (first)
-				nr++;
-		} while (page++, --nr_pages > 0);
-		break;
-	case RMAP_MODE_PMD:
-		first = atomic_inc_and_test(&folio->_entire_mapcount);
-		if (first) {
-			nr = atomic_add_return_relaxed(COMPOUND_MAPPED, mapped);
-			if (likely(nr < COMPOUND_MAPPED + COMPOUND_MAPPED)) {
-				nr_pmdmapped = folio_nr_pages(folio);
-				nr = nr_pmdmapped - (nr & FOLIO_PAGES_MAPPED);
-				/* Raced ahead of a remove and another add? */
-				if (unlikely(nr < 0))
-					nr = 0;
-			} else {
-				/* Raced ahead of a remove of COMPOUND_MAPPED */
-				nr = 0;
-			}
-		}
-		break;
-	}
 
+	nr = __folio_add_rmap(folio, page, nr_pages, mode, &nr_pmdmapped);
 	if (nr_pmdmapped)
 		__lruvec_stat_mod_folio(folio, folio_test_swapbacked(folio) ?
 			NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED, nr_pmdmapped);
-- 
2.43.0

