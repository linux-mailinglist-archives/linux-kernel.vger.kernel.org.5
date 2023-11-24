Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438E17F74FC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345658AbjKXN1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345407AbjKXN1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:27:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C26C170A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700832431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QUP8GR2DnkC5694xV/qGgIseF+xugXnf+IpocEcF75Q=;
        b=f2v4Nd9MWqwmzWHvH54xxheGVyGAyt5tAxJIMVpfBd0QdgkTuJFTFXpNhTI0bmsb+XtBuw
        kKskpr0b9PT+eBiQ0HxvdQMgwW0ZzTWmPnqV9y9qoUWFdhaGf7jJhOjxbtF0fnoulpXgZl
        +uGVUW0gJA7SwIMywIZvNl0TsromnDE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-EVwlOeefM6O30sNZp-JA9g-1; Fri, 24 Nov 2023 08:27:08 -0500
X-MC-Unique: EVwlOeefM6O30sNZp-JA9g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC99C811E93;
        Fri, 24 Nov 2023 13:27:07 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ECEBC2166B2B;
        Fri, 24 Nov 2023 13:27:03 +0000 (UTC)
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
Subject: [PATCH WIP v1 10/20] mm/memory: COW reuse support for PTE-mapped THP with rmap IDs
Date:   Fri, 24 Nov 2023 14:26:15 +0100
Message-ID: <20231124132626.235350-11-david@redhat.com>
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

For now, we only end up reusing small folios and PMD-mapped large folios
(i.e., THP) after fork(); PTE-mapped THPs are never reused, except when
only a single page of the folio remains mapped. Instead, we end up copying
each subpage even though the THP might be exclusive to the MM.

The logic we're using for small folios and PMD-mapped THPs is the
following: Is the only reference to the folio from a single page table
mapping? Then:
  (a) There are no other references to the folio from other MMs
      (e.g., page table mapping, GUP)
  (b) There are no other references to the folio from page migration/
      swapout/swapcache that might temporarily unmap the folio.

Consequently, the folio is exclusive to that process and can be reused.
In that case, we end up with folio_refcount(folio) == 1 and an implied
folio_mapcount(folio) == 1, while holding the page table lock and the
page lock to protect against possible races.

For PTE-mapped THP, however, we have not one, but multiple references
from page tables, whereby such THPs can be mapped into multiple
page tables in the MM.

Reusing the logic that we use for small folios and PMD-mapped THPs means,
that when reusing a PTE-mapped THP, we want to make sure that:
  (1) All folio references are from page table mappings.
  (2) All page table mappings belong to the same MM.
  (3) We didn't race with (un)mapping of the page related to other page
      tables, such that the mapcount and refcount are stable.

For (1), we can check
	folio_refcount(folio) == folio_mapcount(folio)
For (2) and (3), we can use our new rmap ID infrastructure.

We won't bother with the swapcache and LRU cache for now. Add some sanity
checks under CONFIG_DEBUG_VM, to identify any obvious problems early.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 5048d58d6174..fb533995ff68 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3360,6 +3360,95 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf, struct folio *folio)
 static bool wp_can_reuse_anon_folio(struct folio *folio,
 				    struct vm_area_struct *vma)
 {
+#ifdef CONFIG_RMAP_ID
+	if (folio_test_large(folio)) {
+		bool retried = false;
+		unsigned long start;
+		int mapcount, i;
+
+		/*
+		 * The assumption for anonymous folios is that each page can
+		 * only get mapped once into a MM.  This also holds for
+		 * small folios -- except when KSM is involved. KSM does
+		 * currently not apply to large folios.
+		 *
+		 * Further, each taken mapcount must be paired with exactly one
+		 * taken reference, whereby references must be incremented
+		 * before the mapcount when mapping a page, and references must
+		 * be decremented after the mapcount when unmapping a page.
+		 *
+		 * So if all references to a folio are from mappings, and all
+		 * mappings are due to our (MM) page tables, and there was no
+		 * concurrent (un)mapping, this folio is certainly exclusive.
+		 *
+		 * We currently don't optimize for:
+		 * (a) folio is mapped into multiple page tables in this
+		 *     MM (e.g., mremap) and other page tables are
+		 *     concurrently (un)mapping the folio.
+		 * (b) the folio is in the swapcache. Likely the other PTEs
+		 *     are still swap entries and folio_free_swap() would fail.
+		 * (c) the folio is in the LRU cache.
+		 */
+retry:
+		start = raw_read_atomic_seqcount(&folio->_rmap_atomic_seqcount);
+		if (start & ATOMIC_SEQCOUNT_WRITERS_MASK)
+			return false;
+		mapcount = folio_mapcount(folio);
+
+		/* Is this folio possibly exclusive ... */
+		if (mapcount > folio_nr_pages(folio) || folio_entire_mapcount(folio))
+			return false;
+
+		/* ... and are all references from mappings ... */
+		if (folio_ref_count(folio) != mapcount)
+			return false;
+
+		/* ... and do all mappings belong to us ... */
+		if (!__folio_has_large_matching_rmap_val(folio, mapcount, vma->vm_mm))
+			return false;
+
+		/* ... and was there no concurrent (un)mapping ? */
+		if (raw_read_atomic_seqcount_retry(&folio->_rmap_atomic_seqcount,
+						   start))
+			return false;
+
+		/* Safety checks we might want to drop in the future. */
+		if (IS_ENABLED(CONFIG_DEBUG_VM)) {
+			unsigned int mapcount;
+
+			if (WARN_ON_ONCE(folio_test_ksm(folio)))
+				return false;
+			/*
+			 * We might have raced against swapout code adding
+			 * the folio to the swapcache (which, by itself, is not
+			 * problematic). Let's simply check again if we would
+			 * properly detect the additional reference now and
+			 * properly fail.
+			 */
+			if (unlikely(folio_test_swapcache(folio))) {
+				if (WARN_ON_ONCE(retried))
+					return false;
+				retried = true;
+				goto retry;
+			}
+			for (i = 0; i < folio_nr_pages(folio); i++) {
+				mapcount = page_mapcount(folio_page(folio, i));
+				if (WARN_ON_ONCE(mapcount > 1))
+					return false;
+			}
+		}
+
+		/*
+		 * This folio is exclusive to us. Do we need the page lock?
+		 * Likely not, and a trylock would be unfortunate if this
+		 * folio is mapped into multiple page tables and we get
+		 * concurrent page faults. If there would be references from
+		 * page migration/swapout/swapcache, we would have detected
+		 * an additional reference and never ended up here.
+		 */
+		return true;
+	}
+#endif /* CONFIG_RMAP_ID */
 	/*
 	 * We have to verify under folio lock: these early checks are
 	 * just an optimization to avoid locking the folio and freeing
-- 
2.41.0

