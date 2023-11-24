Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E832D7F74E6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjKXN0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjKXN0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:26:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B1810C6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700832400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2NlC2FNJ1Esba7mAbHYEoZIvTqXmerwYmRl67CA2zqk=;
        b=huSZIS7ZCZkJGKeKPRlHnAkMuo0OBY7JGZP8+/BCn5J+kOXfC8lbohmLRLnKrmKgA4EZ+/
        zDgLByYhMR+rTvLoZXxVtaR0MAdWmZaXLgMvZDRISqJPtOYUoimusBtF4sBq9huyh2Ky6V
        KL5Di6fvd7+5QHda4J3e4hx32PKVACw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-4jiaO-6aNt2opR94wzdfSg-1; Fri, 24 Nov 2023 08:26:35 -0500
X-MC-Unique: 4jiaO-6aNt2opR94wzdfSg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C5F185A58A;
        Fri, 24 Nov 2023 13:26:35 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B2C32166B2A;
        Fri, 24 Nov 2023 13:26:31 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH WIP v1 01/20] mm/rmap: factor out adding folio range into __folio_add_rmap_range()
Date:   Fri, 24 Nov 2023 14:26:06 +0100
Message-ID: <20231124132626.235350-2-david@redhat.com>
In-Reply-To: <20231124132626.235350-1-david@redhat.com>
References: <20231124132626.235350-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's factor it out, optimize for small folios, and add some more sanity
checks.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/rmap.c | 119 ++++++++++++++++++++++++------------------------------
 1 file changed, 53 insertions(+), 66 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 7a27a2b41802..afddf3d82a8f 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1127,6 +1127,54 @@ int folio_total_mapcount(struct folio *folio)
 	return mapcount;
 }
 
+static unsigned int __folio_add_rmap_range(struct folio *folio,
+		struct page *page, unsigned int nr_pages, bool compound,
+		int *nr_pmdmapped)
+{
+	atomic_t *mapped = &folio->_nr_pages_mapped;
+	int first, nr = 0;
+
+	VM_WARN_ON_FOLIO(compound && page != &folio->page, folio);
+	VM_WARN_ON_FOLIO(compound && !folio_test_pmd_mappable(folio), folio);
+	VM_WARN_ON_FOLIO(compound && nr_pages != folio_nr_pages(folio), folio);
+	VM_WARN_ON_FOLIO(!folio_test_large(folio) && nr_pages != 1, folio);
+
+	if (likely(!folio_test_large(folio)))
+		return atomic_inc_and_test(&page->_mapcount);
+
+	/* Is page being mapped by PTE? Is this its first map to be added? */
+	if (!compound) {
+		do {
+			first = atomic_inc_and_test(&page->_mapcount);
+			if (first) {
+				first = atomic_inc_return_relaxed(mapped);
+				if (first < COMPOUND_MAPPED)
+					nr++;
+			}
+		} while (page++, --nr_pages > 0);
+	} else if (folio_test_pmd_mappable(folio)) {
+		/* That test is redundant: it's for safety or to optimize out */
+
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
+	} else {
+		VM_WARN_ON_ONCE_FOLIO(true, folio);
+	}
+	return nr;
+}
+
 /**
  * folio_move_anon_rmap - move a folio to our anon_vma
  * @folio:	The folio to move to our anon_vma
@@ -1227,38 +1275,10 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 		unsigned long address, rmap_t flags)
 {
 	struct folio *folio = page_folio(page);
-	atomic_t *mapped = &folio->_nr_pages_mapped;
-	int nr = 0, nr_pmdmapped = 0;
+	unsigned int nr, nr_pmdmapped = 0;
 	bool compound = flags & RMAP_COMPOUND;
-	bool first;
-
-	/* Is page being mapped by PTE? Is this its first map to be added? */
-	if (likely(!compound)) {
-		first = atomic_inc_and_test(&page->_mapcount);
-		nr = first;
-		if (first && folio_test_large(folio)) {
-			nr = atomic_inc_return_relaxed(mapped);
-			nr = (nr < COMPOUND_MAPPED);
-		}
-	} else if (folio_test_pmd_mappable(folio)) {
-		/* That test is redundant: it's for safety or to optimize out */
-
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
-	}
 
+	nr = __folio_add_rmap_range(folio, page, 1, compound, &nr_pmdmapped);
 	if (nr_pmdmapped)
 		__lruvec_stat_mod_folio(folio, NR_ANON_THPS, nr_pmdmapped);
 	if (nr)
@@ -1349,43 +1369,10 @@ void folio_add_file_rmap_range(struct folio *folio, struct page *page,
 			unsigned int nr_pages, struct vm_area_struct *vma,
 			bool compound)
 {
-	atomic_t *mapped = &folio->_nr_pages_mapped;
-	unsigned int nr_pmdmapped = 0, first;
-	int nr = 0;
-
-	VM_WARN_ON_FOLIO(compound && !folio_test_pmd_mappable(folio), folio);
-
-	/* Is page being mapped by PTE? Is this its first map to be added? */
-	if (likely(!compound)) {
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
-	} else if (folio_test_pmd_mappable(folio)) {
-		/* That test is redundant: it's for safety or to optimize out */
-
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
-	}
+	unsigned int nr, nr_pmdmapped = 0;
 
+	nr = __folio_add_rmap_range(folio, page, nr_pages, compound,
+				    &nr_pmdmapped);
 	if (nr_pmdmapped)
 		__lruvec_stat_mod_folio(folio, folio_test_swapbacked(folio) ?
 			NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED, nr_pmdmapped);
-- 
2.41.0

