Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAD07F7500
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345387AbjKXN2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjKXN1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:27:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB1E1FD5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700832443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vCiq1mHEXhReKPGNK7ma5q/JWzLE5up94nYDqOWMaw0=;
        b=KMtMf+7dmBRtjbwxbYQXOrYTQcwZiZJDTFkfqfBZDVirfeYkN8AH/PvV7p0IXhMRq4/keh
        bYPgAC+g3Q580Km9kmZK6U8f8eP8GSYKjt1GZ0kjLjD9w//Bl75M7BQoShXl0h6+1VUUjC
        Q20c2Ym3edm/eG74EUt849f10Tw5pJc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-EfryieQzPKuzYd766I-Umw-1; Fri,
 24 Nov 2023 08:27:19 -0500
X-MC-Unique: EfryieQzPKuzYd766I-Umw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 805CE1C05142;
        Fri, 24 Nov 2023 13:27:18 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0717E2166B2A;
        Fri, 24 Nov 2023 13:27:14 +0000 (UTC)
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
Subject: [PATCH WIP v1 13/20] mm/huge_memory: batch rmap operations in __split_huge_pmd_locked()
Date:   Fri, 24 Nov 2023 14:26:18 +0100
Message-ID: <20231124132626.235350-14-david@redhat.com>
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

Let's batch the rmap operations, as a preparation to making individual
page_add_anon_rmap() calls more expensive.

While at it, use more folio operations (but only in the code branch we're
touching), use VM_WARN_ON_FOLIO(), and pass RMAP_COMPOUND instead of
manually setting PageAnonExclusive.

We should never see non-anon pages on that branch: otherwise, the
existing page_add_anon_rmap() call would have been flawed already.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index fd7251923557..f47971d1afbf 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2100,6 +2100,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long haddr, bool freeze)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	struct folio *folio;
 	struct page *page;
 	pgtable_t pgtable;
 	pmd_t old_pmd, _pmd;
@@ -2195,16 +2196,18 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		uffd_wp = pmd_swp_uffd_wp(old_pmd);
 	} else {
 		page = pmd_page(old_pmd);
+		folio = page_folio(page);
 		if (pmd_dirty(old_pmd)) {
 			dirty = true;
-			SetPageDirty(page);
+			folio_set_dirty(folio);
 		}
 		write = pmd_write(old_pmd);
 		young = pmd_young(old_pmd);
 		soft_dirty = pmd_soft_dirty(old_pmd);
 		uffd_wp = pmd_uffd_wp(old_pmd);
 
-		VM_BUG_ON_PAGE(!page_count(page), page);
+		VM_WARN_ON_FOLIO(!folio_ref_count(folio), folio);
+		VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
 
 		/*
 		 * Without "freeze", we'll simply split the PMD, propagating the
@@ -2221,11 +2224,18 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		 *
 		 * See page_try_share_anon_rmap(): invalidate PMD first.
 		 */
-		anon_exclusive = PageAnon(page) && PageAnonExclusive(page);
+		anon_exclusive = PageAnonExclusive(page);
 		if (freeze && anon_exclusive && page_try_share_anon_rmap(page))
 			freeze = false;
-		if (!freeze)
-			page_ref_add(page, HPAGE_PMD_NR - 1);
+		if (!freeze) {
+			rmap_t rmap_flags = RMAP_NONE;
+
+			folio_ref_add(folio, HPAGE_PMD_NR - 1);
+			if (anon_exclusive)
+				rmap_flags = RMAP_EXCLUSIVE;
+			folio_add_anon_rmap_range(folio, page, HPAGE_PMD_NR,
+						  vma, haddr, rmap_flags);
+		}
 	}
 
 	/*
@@ -2268,8 +2278,6 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			entry = mk_pte(page + i, READ_ONCE(vma->vm_page_prot));
 			if (write)
 				entry = pte_mkwrite(entry, vma);
-			if (anon_exclusive)
-				SetPageAnonExclusive(page + i);
 			if (!young)
 				entry = pte_mkold(entry);
 			/* NOTE: this may set soft-dirty too on some archs */
@@ -2279,7 +2287,6 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 				entry = pte_mksoft_dirty(entry);
 			if (uffd_wp)
 				entry = pte_mkuffd_wp(entry);
-			page_add_anon_rmap(page + i, vma, addr, RMAP_NONE);
 		}
 		VM_BUG_ON(!pte_none(ptep_get(pte)));
 		set_pte_at(mm, addr, pte, entry);
-- 
2.41.0

