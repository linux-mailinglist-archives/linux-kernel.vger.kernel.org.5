Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66517F7512
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345232AbjKXN3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbjKXN2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:28:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CF72686
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700832462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BnEHwgivpdbaZgh54Ih7L1AobW4tDWwZEN96Ch5d2sI=;
        b=Hizn47stOY0bjcCAapanjWMo1DctKX6iH+q4hCiCWA0XhmT2hRBOUWfHfCXBdsEZQQsJiU
        PwgKXtiLA4TJss8Dutnh2w5T8tDYEclkU4NKPAOWGGLBOp0UWz2wZUCxxhYje3Xa4IQL8/
        TGJ7vu7hxWsuWfYCnpXM3IRr5scvSJ8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-EU4DmTN2O1ar0sjJ8gqpbQ-1; Fri, 24 Nov 2023 08:27:41 -0500
X-MC-Unique: EU4DmTN2O1ar0sjJ8gqpbQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3AD05185A783;
        Fri, 24 Nov 2023 13:27:40 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 550AE2166B2A;
        Fri, 24 Nov 2023 13:27:37 +0000 (UTC)
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
Subject: [PATCH WIP v1 19/20] mm/rmap: factor out removing folio range into __folio_remove_rmap_range()
Date:   Fri, 24 Nov 2023 14:26:24 +0100
Message-ID: <20231124132626.235350-20-david@redhat.com>
In-Reply-To: <20231124132626.235350-1-david@redhat.com>
References: <20231124132626.235350-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's factor it out, optimize for small folios, and compact it a bit.

Well, we're adding the range part, but that will surely come in handy
soon -- and it's now wasier to compare it with __folio_add_rmap_range().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/rmap.c | 90 +++++++++++++++++++++++++++++++++----------------------
 1 file changed, 55 insertions(+), 35 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index da7fa46a18fc..80ac53633332 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1155,6 +1155,57 @@ static unsigned int __folio_add_rmap_range(struct folio *folio,
 	return nr;
 }
 
+static unsigned int __folio_remove_rmap_range(struct folio *folio,
+		struct page *page, unsigned int nr_pages,
+		struct vm_area_struct *vma, bool compound, int *nr_pmdmapped)
+{
+	atomic_t *mapped = &folio->_nr_pages_mapped;
+	int last, count, nr = 0;
+
+	VM_WARN_ON_FOLIO(compound && page != &folio->page, folio);
+	VM_WARN_ON_FOLIO(compound && !folio_test_pmd_mappable(folio), folio);
+	VM_WARN_ON_FOLIO(compound && nr_pages != folio_nr_pages(folio), folio);
+	VM_WARN_ON_FOLIO(!folio_test_large(folio) && nr_pages != 1, folio);
+
+	if (likely(!folio_test_large(folio)))
+		return atomic_add_negative(-1, &page->_mapcount);
+
+	/* Is page being unmapped by PTE? Is this its last map to be removed? */
+	if (!compound) {
+		folio_add_large_mapcount(folio, -nr_pages, vma);
+		count = nr_pages;
+		do {
+			last = atomic_add_negative(-1, &page->_mapcount);
+			if (last) {
+				last = atomic_dec_return_relaxed(mapped);
+				if (last < COMPOUND_MAPPED)
+					nr++;
+			}
+		} while (page++, --count > 0);
+	} else if (folio_test_pmd_mappable(folio)) {
+		/* That test is redundant: it's for safety or to optimize out */
+
+		folio_dec_large_mapcount(folio, vma);
+		last = atomic_add_negative(-1, &folio->_entire_mapcount);
+		if (last) {
+			nr = atomic_sub_return_relaxed(COMPOUND_MAPPED, mapped);
+			if (likely(nr < COMPOUND_MAPPED)) {
+				*nr_pmdmapped = folio_nr_pages(folio);
+				nr = *nr_pmdmapped - (nr & FOLIO_PAGES_MAPPED);
+				/* Raced ahead of another remove and an add? */
+				if (unlikely(nr < 0))
+					nr = 0;
+			} else {
+				/* An add of COMPOUND_MAPPED raced ahead */
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
@@ -1439,13 +1490,10 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
 		bool compound)
 {
 	struct folio *folio = page_folio(page);
-	atomic_t *mapped = &folio->_nr_pages_mapped;
-	int nr = 0, nr_pmdmapped = 0;
-	bool last;
+	unsigned long nr_pages = compound ? folio_nr_pages(folio) : 1;
+	unsigned int nr, nr_pmdmapped = 0;
 	enum node_stat_item idx;
 
-	VM_BUG_ON_PAGE(compound && !PageHead(page), page);
-
 	/* Hugetlb pages are not counted in NR_*MAPPED */
 	if (unlikely(folio_test_hugetlb(folio))) {
 		/* hugetlb pages are always mapped with pmds */
@@ -1454,36 +1502,8 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
 		return;
 	}
 
-	if (folio_test_large(folio))
-		folio_dec_large_mapcount(folio, vma);
-
-	/* Is page being unmapped by PTE? Is this its last map to be removed? */
-	if (likely(!compound)) {
-		last = atomic_add_negative(-1, &page->_mapcount);
-		nr = last;
-		if (last && folio_test_large(folio)) {
-			nr = atomic_dec_return_relaxed(mapped);
-			nr = (nr < COMPOUND_MAPPED);
-		}
-	} else if (folio_test_pmd_mappable(folio)) {
-		/* That test is redundant: it's for safety or to optimize out */
-
-		last = atomic_add_negative(-1, &folio->_entire_mapcount);
-		if (last) {
-			nr = atomic_sub_return_relaxed(COMPOUND_MAPPED, mapped);
-			if (likely(nr < COMPOUND_MAPPED)) {
-				nr_pmdmapped = folio_nr_pages(folio);
-				nr = nr_pmdmapped - (nr & FOLIO_PAGES_MAPPED);
-				/* Raced ahead of another remove and an add? */
-				if (unlikely(nr < 0))
-					nr = 0;
-			} else {
-				/* An add of COMPOUND_MAPPED raced ahead */
-				nr = 0;
-			}
-		}
-	}
-
+	nr = __folio_remove_rmap_range(folio, page, nr_pages, vma, compound,
+				       &nr_pmdmapped);
 	if (nr_pmdmapped) {
 		if (folio_test_anon(folio))
 			idx = NR_ANON_THPS;
-- 
2.41.0

