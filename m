Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3060D803660
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345294AbjLDOXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235862AbjLDOWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:22:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF871721
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701699738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HK+wCLAanK8icsaUODtbkemdg+UtHwl4vMlZjDb9LtY=;
        b=LbDNQUwdJBEAHZMfx+lR6r5w8iMrULA6uwC/6tX35g+cBE5972WwWne56a4OG9h1cY96L/
        NhntiOHu29TjxTP7KkdcJzgHgeT7oYFFsPxfiNOMK+D9Ut16+I2BqJkEv3VDU8k6dQj7T5
        wk0kLdB+n+gpxoS4uXJvSC1vHiGJUSM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-tU-ty63bN-Gpvd547o2MWA-1; Mon,
 04 Dec 2023 09:22:13 -0500
X-MC-Unique: tU-ty63bN-Gpvd547o2MWA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0D0129AA3AE;
        Mon,  4 Dec 2023 14:22:12 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.195.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 477C72026D6E;
        Mon,  4 Dec 2023 14:22:11 +0000 (UTC)
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
Subject: [PATCH RFC 13/39] mm/rmap: factor out adding folio mappings into __folio_add_rmap()
Date:   Mon,  4 Dec 2023 15:21:20 +0100
Message-ID: <20231204142146.91437-14-david@redhat.com>
In-Reply-To: <20231204142146.91437-1-david@redhat.com>
References: <20231204142146.91437-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

Let's factor it out to prepare for reuse as we convert
page_add_anon_rmap() to folio_add_anon_rmap_[pte|ptes|pmd]().

Make the compiler always special-case on the granularity by using
__always_inline.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/rmap.c | 75 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 33 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 53e2c653be99a..c09b360402599 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1127,6 +1127,46 @@ int folio_total_mapcount(struct folio *folio)
 	return mapcount;
 }
 
+static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
+		struct page *page, unsigned int nr_pages, enum rmap_mode mode,
+		int *nr_pmdmapped)
+{
+	atomic_t *mapped = &folio->_nr_pages_mapped;
+	int first, nr = 0;
+
+	__folio_rmap_sanity_checks(folio, page, nr_pages, mode);
+
+	/* Is page being mapped by PTE? Is this its first map to be added? */
+	if (likely(mode == RMAP_MODE_PTE)) {
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
+	} else if (mode == RMAP_MODE_PMD) {
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
+	}
+	return nr;
+}
+
 /**
  * folio_move_anon_rmap - move a folio to our anon_vma
  * @folio:	The folio to move to our anon_vma
@@ -1338,42 +1378,11 @@ static __always_inline void __folio_add_file_rmap(struct folio *folio,
 		struct page *page, unsigned int nr_pages,
 		struct vm_area_struct *vma, enum rmap_mode mode)
 {
-	atomic_t *mapped = &folio->_nr_pages_mapped;
-	unsigned int nr_pmdmapped = 0, first;
-	int nr = 0;
+	unsigned int nr, nr_pmdmapped = 0;
 
 	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
-	__folio_rmap_sanity_checks(folio, page, nr_pages, mode);
-
-	/* Is page being mapped by PTE? Is this its first map to be added? */
-	if (likely(mode == RMAP_MODE_PTE)) {
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
-	} else if (mode == RMAP_MODE_PMD) {
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
 
+	nr = __folio_add_rmap(folio, page, nr_pages, mode, &nr_pmdmapped);
 	if (nr_pmdmapped)
 		__lruvec_stat_mod_folio(folio, folio_test_swapbacked(folio) ?
 			NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED, nr_pmdmapped);
-- 
2.41.0

