Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8DE7F74FB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345401AbjKXN1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbjKXN1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:27:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D82C10F9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700832429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qOqXc/Lc47PjYVBDjn5tNISm7M7uwGrIMk+t0cHF8N0=;
        b=Ci6nzm9hcHMWZuOapqbpBSXFSXWl0TnzZyMigA7IRrFl1gTanwBv+Yxr8wUCSiBJO071Bt
        MEK/fQHM2ZYEnjZIVNPCV7ntYVs3F6f0Gge60gEQr9Gbs9WlQj3RSxMpCtrZZEzpBXX0pM
        er3r07Kwxy5b54n2RQrliMdEl3Nzk/E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-HfF3hCRgOCiCl6qXEnqmsA-1; Fri, 24 Nov 2023 08:27:04 -0500
X-MC-Unique: HfF3hCRgOCiCl6qXEnqmsA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD25B811E86;
        Fri, 24 Nov 2023 13:27:03 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 477E52166B2A;
        Fri, 24 Nov 2023 13:27:00 +0000 (UTC)
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
Subject: [PATCH WIP v1 09/20] mm: improve folio_mapped_shared() for partially-mappable folios using rmap IDs
Date:   Fri, 24 Nov 2023 14:26:14 +0100
Message-ID: <20231124132626.235350-10-david@redhat.com>
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

Let's make folio_mapped_shared() precise by using or rmap ID
magic to identify if a single MM is responsible for all mappings.

If there is a lot of concurrent (un)map activity, we could theoretically
spin for quite a while. But we're only looking at the rmap values in case
we didn't already identify the folio as "obviously shared". In most
cases, there should only be one or a handful of page tables involved.

For current THPs with ~512 .. 2048 subpages, we really shouldn't see a
lot of concurrent updates that keep us spinning for a long time. Anyhow,
if ever a problem this can be optimized later if there is real demand.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h   | 21 ++++++++++++---
 include/linux/rmap.h |  2 ++
 mm/rmap_id.c         | 63 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 765e688690f1..1081a8faa1a3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2113,6 +2113,17 @@ static inline size_t folio_size(struct folio *folio)
 	return PAGE_SIZE << folio_order(folio);
 }
 
+#ifdef CONFIG_RMAP_ID
+bool __folio_large_mapped_shared(struct folio *folio, struct mm_struct *mm);
+#else
+static inline bool __folio_large_mapped_shared(struct folio *folio,
+		struct mm_struct *mm)
+{
+	/* ... guess based on the mapcount of the first page of the folio. */
+	return atomic_read(&folio->page._mapcount) > 0;
+}
+#endif
+
 /**
  * folio_mapped_shared - Report if a folio is certainly mapped by
  *			 multiple entities in their page tables
@@ -2141,8 +2152,11 @@ static inline size_t folio_size(struct folio *folio)
  * PMD-mapped PMD-sized THP), the result will be exactly correct.
  *
  * For all other (partially-mappable) folios, such as PTE-mapped THP, the
- * return value is partially fuzzy: true is not fuzzy, because it means
- * "certainly mapped shared", but false means "maybe mapped exclusively".
+ * return value is partially fuzzy without CONFIG_RMAP_ID: true is not fuzzy,
+ * because it means "certainly mapped shared", but false means
+ * "maybe mapped exclusively".
+ *
+ * With CONFIG_RMAP_ID, the result will be exactly correct.
  *
  * Note that this function only considers *current* page table mappings
  * tracked via rmap -- that properly adjusts the folio mapcount(s) -- and
@@ -2177,8 +2191,7 @@ static inline bool folio_mapped_shared(struct folio *folio,
 	 */
 	if (total_mapcount > folio_nr_pages(folio))
 		return true;
-	/* ... guess based on the mapcount of the first page of the folio. */
-	return atomic_read(&folio->page._mapcount) > 0;
+	return __folio_large_mapped_shared(folio, mm);
 }
 
 #ifndef HAVE_ARCH_MAKE_PAGE_ACCESSIBLE
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 19c9dc3216df..a73e146d82d1 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -253,6 +253,8 @@ void __folio_set_large_rmap_val(struct folio *folio, int count,
 		struct mm_struct *mm);
 void __folio_add_large_rmap_val(struct folio *folio, int count,
 		struct mm_struct *mm);
+bool __folio_has_large_matching_rmap_val(struct folio *folio, int count,
+		struct mm_struct *mm);
 #else
 static inline void __folio_prep_large_rmap(struct folio *folio)
 {
diff --git a/mm/rmap_id.c b/mm/rmap_id.c
index e66b0f5aea2d..85a61c830f19 100644
--- a/mm/rmap_id.c
+++ b/mm/rmap_id.c
@@ -322,6 +322,69 @@ void __folio_add_large_rmap_val(struct folio *folio, int count,
 	}
 }
 
+bool __folio_has_large_matching_rmap_val(struct folio *folio, int count,
+		 struct mm_struct *mm)
+{
+	const unsigned int order = folio_order(folio);
+	unsigned long diff = 0;
+
+	switch (order) {
+#if MAX_ORDER >= RMAP_SUBID_6_MIN_ORDER
+	case RMAP_SUBID_6_MIN_ORDER .. RMAP_SUBID_6_MAX_ORDER:
+		diff |= atomic_long_read(&folio->_rmap_val0) ^ (get_rmap_subid_6(mm, 0) * count);
+		diff |= atomic_long_read(&folio->_rmap_val1) ^ (get_rmap_subid_6(mm, 1) * count);
+		diff |= atomic_long_read(&folio->_rmap_val2) ^ (get_rmap_subid_6(mm, 2) * count);
+		diff |= atomic_long_read(&folio->_rmap_val3) ^ (get_rmap_subid_6(mm, 3) * count);
+		diff |= atomic_long_read(&folio->_rmap_val4) ^ (get_rmap_subid_6(mm, 4) * count);
+		diff |= atomic_long_read(&folio->_rmap_val5) ^ (get_rmap_subid_6(mm, 5) * count);
+		break;
+#endif
+#if MAX_ORDER >= RMAP_SUBID_5_MIN_ORDER
+	case RMAP_SUBID_5_MIN_ORDER .. RMAP_SUBID_5_MAX_ORDER:
+		diff |= atomic_long_read(&folio->_rmap_val0) ^ (get_rmap_subid_5(mm, 0) * count);
+		diff |= atomic_long_read(&folio->_rmap_val1) ^ (get_rmap_subid_5(mm, 1) * count);
+		diff |= atomic_long_read(&folio->_rmap_val2) ^ (get_rmap_subid_5(mm, 2) * count);
+		diff |= atomic_long_read(&folio->_rmap_val3) ^ (get_rmap_subid_5(mm, 3) * count);
+		diff |= atomic_long_read(&folio->_rmap_val4) ^ (get_rmap_subid_5(mm, 4) * count);
+		break;
+#endif
+	default:
+		diff |= atomic_long_read(&folio->_rmap_val0) ^ (get_rmap_subid_4(mm, 0) * count);
+		diff |= atomic_long_read(&folio->_rmap_val1) ^ (get_rmap_subid_4(mm, 1) * count);
+		diff |= atomic_long_read(&folio->_rmap_val2) ^ (get_rmap_subid_4(mm, 2) * count);
+		diff |= atomic_long_read(&folio->_rmap_val3) ^ (get_rmap_subid_4(mm, 3) * count);
+		break;
+	}
+	return !diff;
+}
+
+bool __folio_large_mapped_shared(struct folio *folio, struct mm_struct *mm)
+{
+	unsigned long start;
+	bool exclusive;
+	int mapcount;
+
+	VM_WARN_ON_ONCE(!folio_test_large_rmappable(folio));
+	VM_WARN_ON_ONCE(folio_test_hugetlb(folio));
+
+	/*
+	 * Livelocking here is unlikely, as the caller already handles the
+	 * "obviously shared" cases. If ever an issue and there is too much
+	 * concurrent (un)mapping happening (using different page tables), we
+	 * could stop earlier and just return "shared".
+	 */
+	do {
+		start = raw_read_atomic_seqcount_begin(&folio->_rmap_atomic_seqcount);
+		mapcount = folio_mapcount(folio);
+		if (unlikely(mapcount > folio_nr_pages(folio)))
+			return true;
+		exclusive = __folio_has_large_matching_rmap_val(folio, mapcount, mm);
+	} while (raw_read_atomic_seqcount_retry(&folio->_rmap_atomic_seqcount,
+						start));
+
+	return !exclusive;
+}
+
 int alloc_rmap_id(void)
 {
 	int id;
-- 
2.41.0

