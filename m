Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D8079E858
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240688AbjIMMwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240665AbjIMMwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:52:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC0D519B9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694609485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fi954WhfJTlnxfu/yTjvI+IMpqyRN+5DQHmUbjacTd0=;
        b=N9QboO8pqvkY2+aoMzgt2I2CD2heVX7NfV38zGIuWDZcC8B8jxNciyuHG1ETRXEA1l8tlN
        gP+wVhD7YMoTCwK//+fpeQ4bqJGv5oO8fAregzrbLFjKpLrP0MEWFrdwI26qBhlJd87L4C
        fg4kREN+oQXMSME2MVcHMZlKLP2vlvk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-60-IQGL421PNvK9ZlO5bNgMvQ-1; Wed, 13 Sep 2023 08:51:21 -0400
X-MC-Unique: IQGL421PNvK9ZlO5bNgMvQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4CBBA101A550;
        Wed, 13 Sep 2023 12:51:21 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A48BE2156722;
        Wed, 13 Sep 2023 12:51:19 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>
Subject: [PATCH v1 2/6] mm/rmap: move SetPageAnonExclusive out of __page_set_anon_rmap()
Date:   Wed, 13 Sep 2023 14:51:09 +0200
Message-ID: <20230913125113.313322-3-david@redhat.com>
In-Reply-To: <20230913125113.313322-1-david@redhat.com>
References: <20230913125113.313322-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's handle it in the caller. No need to pass the page. While at it,
rename the function to __folio_set_anon() and pass "bool exclusive" instead
of "int exclusive".

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/rmap.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index ca2787c1fe05..ab16baa0fcb3 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1122,27 +1122,25 @@ void page_move_anon_rmap(struct page *page, struct vm_area_struct *vma)
 }
 
 /**
- * __page_set_anon_rmap - set up new anonymous rmap
- * @folio:	Folio which contains page.
- * @page:	Page to add to rmap.
- * @vma:	VM area to add page to.
+ * __folio_set_anon - set up a new anonymous rmap for a folio
+ * @folio:	The folio to set up the new anonymous rmap for.
+ * @vma:	VM area to add the folio to.
  * @address:	User virtual address of the mapping
- * @exclusive:	the page is exclusively owned by the current process
+ * @exclusive:	Whether the folio is exclusive to the process.
  */
-static void __page_set_anon_rmap(struct folio *folio, struct page *page,
-	struct vm_area_struct *vma, unsigned long address, int exclusive)
+static void __folio_set_anon(struct folio *folio, struct vm_area_struct *vma,
+			     unsigned long address, bool exclusive)
 {
 	struct anon_vma *anon_vma = vma->anon_vma;
 
 	BUG_ON(!anon_vma);
 
 	if (folio_test_anon(folio))
-		goto out;
+		return;
 
 	/*
-	 * If the page isn't exclusively mapped into this vma,
-	 * we must use the _oldest_ possible anon_vma for the
-	 * page mapping!
+	 * If the folio isn't exclusive to this vma, we must use the _oldest_
+	 * possible anon_vma for the folio mapping!
 	 */
 	if (!exclusive)
 		anon_vma = anon_vma->root;
@@ -1156,9 +1154,6 @@ static void __page_set_anon_rmap(struct folio *folio, struct page *page,
 	anon_vma = (void *) anon_vma + PAGE_MAPPING_ANON;
 	WRITE_ONCE(folio->mapping, (struct address_space *) anon_vma);
 	folio->index = linear_page_index(vma, address);
-out:
-	if (exclusive)
-		SetPageAnonExclusive(page);
 }
 
 /**
@@ -1246,11 +1241,13 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 
 	if (likely(!folio_test_ksm(folio))) {
 		if (first)
-			__page_set_anon_rmap(folio, page, vma, address,
-					     !!(flags & RMAP_EXCLUSIVE));
+			__folio_set_anon(folio, vma, address,
+					 !!(flags & RMAP_EXCLUSIVE));
 		else
 			__page_check_anon_rmap(folio, page, vma, address);
 	}
+	if (flags & RMAP_EXCLUSIVE)
+		SetPageAnonExclusive(page);
 
 	mlock_vma_folio(folio, vma, compound);
 }
@@ -1289,7 +1286,8 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 	}
 
 	__lruvec_stat_mod_folio(folio, NR_ANON_MAPPED, nr);
-	__page_set_anon_rmap(folio, &folio->page, vma, address, 1);
+	__folio_set_anon(folio, vma, address, true);
+	SetPageAnonExclusive(&folio->page);
 }
 
 /**
@@ -2539,8 +2537,10 @@ void hugepage_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 	VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);
 	VM_BUG_ON_PAGE(!first && PageAnonExclusive(page), page);
 	if (first)
-		__page_set_anon_rmap(folio, page, vma, address,
-				     !!(flags & RMAP_EXCLUSIVE));
+		__folio_set_anon(folio, vma, address,
+				 !!(flags & RMAP_EXCLUSIVE));
+	if (flags & RMAP_EXCLUSIVE)
+		SetPageAnonExclusive(page);
 }
 
 void hugepage_add_new_anon_rmap(struct folio *folio,
@@ -2550,6 +2550,7 @@ void hugepage_add_new_anon_rmap(struct folio *folio,
 	/* increment count (starts at -1) */
 	atomic_set(&folio->_entire_mapcount, 0);
 	folio_clear_hugetlb_restore_reserve(folio);
-	__page_set_anon_rmap(folio, &folio->page, vma, address, 1);
+	__folio_set_anon(folio, vma, address, true);
+	SetPageAnonExclusive(&folio->page);
 }
 #endif /* CONFIG_HUGETLB_PAGE */
-- 
2.41.0

