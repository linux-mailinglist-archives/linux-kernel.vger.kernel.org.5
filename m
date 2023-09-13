Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34BC79E855
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240734AbjIMMw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240668AbjIMMwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:52:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5861919B3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694609487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TPywS+lMvCdRAxxYldVBzyiy9uXPhmFWj9jbUK5aT08=;
        b=bFBycnAQdVCR9gfq9lxyHgaN+RZQMxyvjX0f2ec/zjFvKMyrK8SmnqbNmTu39mKt1bGDlj
        ufG6IG7KB1slESFqH0Xwbs3bj6NTbz2DsVJrisC6KzZ03K41pEtaoqlAUrRbhecEJmAHHz
        A8/NoXugx219alLFAuxK1vpnpOIQwbQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-41-FbYiyCTvMFu_-aiiWy3VKA-1; Wed, 13 Sep 2023 08:51:24 -0400
X-MC-Unique: FbYiyCTvMFu_-aiiWy3VKA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD850800045;
        Wed, 13 Sep 2023 12:51:23 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A749F21B2414;
        Wed, 13 Sep 2023 12:51:21 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>
Subject: [PATCH v1 3/6] mm/rmap: move folio_test_anon() check out of __folio_set_anon()
Date:   Wed, 13 Sep 2023 14:51:10 +0200
Message-ID: <20230913125113.313322-4-david@redhat.com>
In-Reply-To: <20230913125113.313322-1-david@redhat.com>
References: <20230913125113.313322-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's handle it in the caller; no need for the "first" check based on
the mapcount.

We really only end up with !anon pages in page_add_anon_rmap() via
do_swap_page(), where we hold the folio lock. So races are not possible.
Add a VM_WARN_ON_FOLIO() to make sure that we really hold the folio
lock.

In the future, we might want to let do_swap_page() use
folio_add_new_anon_rmap() on new pages instead: however, we might have
to pass then whether the folio is exclusive or not. So keep it in there
for now.

For hugetlb we never expect to have a non-anon page in
hugepage_add_anon_rmap(). Remove that code, along with some other checks
that are either not required or were checked in
hugepage_add_new_anon_rmap() already.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/rmap.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index ab16baa0fcb3..1ac5bd1b8169 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1135,9 +1135,6 @@ static void __folio_set_anon(struct folio *folio, struct vm_area_struct *vma,
 
 	BUG_ON(!anon_vma);
 
-	if (folio_test_anon(folio))
-		return;
-
 	/*
 	 * If the folio isn't exclusive to this vma, we must use the _oldest_
 	 * possible anon_vma for the folio mapping!
@@ -1239,12 +1236,12 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 	if (nr)
 		__lruvec_stat_mod_folio(folio, NR_ANON_MAPPED, nr);
 
-	if (likely(!folio_test_ksm(folio))) {
-		if (first)
-			__folio_set_anon(folio, vma, address,
-					 !!(flags & RMAP_EXCLUSIVE));
-		else
-			__page_check_anon_rmap(folio, page, vma, address);
+	if (unlikely(!folio_test_anon(folio))) {
+		VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
+		__folio_set_anon(folio, vma, address,
+				 !!(flags & RMAP_EXCLUSIVE));
+	} else if (likely(!folio_test_ksm(folio))) {
+		__page_check_anon_rmap(folio, page, vma, address);
 	}
 	if (flags & RMAP_EXCLUSIVE)
 		SetPageAnonExclusive(page);
@@ -2528,17 +2525,13 @@ void hugepage_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 			    unsigned long address, rmap_t flags)
 {
 	struct folio *folio = page_folio(page);
-	struct anon_vma *anon_vma = vma->anon_vma;
 	int first;
 
-	BUG_ON(!folio_test_locked(folio));
-	BUG_ON(!anon_vma);
+	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
+
 	first = atomic_inc_and_test(&folio->_entire_mapcount);
 	VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);
 	VM_BUG_ON_PAGE(!first && PageAnonExclusive(page), page);
-	if (first)
-		__folio_set_anon(folio, vma, address,
-				 !!(flags & RMAP_EXCLUSIVE));
 	if (flags & RMAP_EXCLUSIVE)
 		SetPageAnonExclusive(page);
 }
-- 
2.41.0

