Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6516F79E85A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240772AbjIMMwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240648AbjIMMwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:52:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2DB41BC8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694609489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z+qQSwZU5O6LoNzg+Y0KcgzyFROGp1piGCQLbieshoU=;
        b=TDI9gnm7p5CsZag3dSNEos0XRJbYI9BFE07jjbQZU4fl2m26IOFN8D/sslG+yZzbSOh2r2
        WSHILd1vDnfCO7fpNzNnjAPiQ3kJuIhE/Iidwyz/qmTGVcvoA4YrhbTIJPTvfE0b/CgQTm
        XGcewk4cmosbvnJzQt2XwD7hRxr8K3I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-4zJ54y7iMkaiv39wEbMctA-1; Wed, 13 Sep 2023 08:51:27 -0400
X-MC-Unique: 4zJ54y7iMkaiv39wEbMctA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E9678011AD;
        Wed, 13 Sep 2023 12:51:27 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F56421B20B1;
        Wed, 13 Sep 2023 12:51:26 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>
Subject: [PATCH v1 5/6] mm/rmap: simplify PageAnonExclusive sanity checks when adding anon rmap
Date:   Wed, 13 Sep 2023 14:51:12 +0200
Message-ID: <20230913125113.313322-6-david@redhat.com>
In-Reply-To: <20230913125113.313322-1-david@redhat.com>
References: <20230913125113.313322-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's sanity-check PageAnonExclusive vs. mapcount in page_add_anon_rmap()
and hugepage_add_anon_rmap() after setting PageAnonExclusive simply by
re-reading the mapcounts.

We can stop initializing the "first" variable in page_add_anon_rmap()
and no longer need an atomic_inc_and_test() in hugepage_add_anon_rmap().

While at it, switch to VM_WARN_ON_FOLIO().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/rmap.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 489c142d073b..10d477a0991f 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1199,7 +1199,7 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 	atomic_t *mapped = &folio->_nr_pages_mapped;
 	int nr = 0, nr_pmdmapped = 0;
 	bool compound = flags & RMAP_COMPOUND;
-	bool first = true;
+	bool first;
 
 	/* Is page being mapped by PTE? Is this its first map to be added? */
 	if (likely(!compound)) {
@@ -1228,9 +1228,6 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 		}
 	}
 
-	VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);
-	VM_BUG_ON_PAGE(!first && PageAnonExclusive(page), page);
-
 	if (nr_pmdmapped)
 		__lruvec_stat_mod_folio(folio, NR_ANON_THPS, nr_pmdmapped);
 	if (nr)
@@ -1252,6 +1249,8 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 	}
 	if (flags & RMAP_EXCLUSIVE)
 		SetPageAnonExclusive(page);
+	VM_WARN_ON_FOLIO(page_mapcount(page) > 1 && PageAnonExclusive(page),
+			 folio);
 
 	mlock_vma_folio(folio, vma, compound);
 }
@@ -2532,15 +2531,14 @@ void hugepage_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 			    unsigned long address, rmap_t flags)
 {
 	struct folio *folio = page_folio(page);
-	int first;
 
 	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
 
-	first = atomic_inc_and_test(&folio->_entire_mapcount);
-	VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);
-	VM_BUG_ON_PAGE(!first && PageAnonExclusive(page), page);
+	atomic_inc(&folio->_entire_mapcount);
 	if (flags & RMAP_EXCLUSIVE)
 		SetPageAnonExclusive(page);
+	VM_WARN_ON_FOLIO(folio_entire_mapcount(folio) > 1 &&
+			 PageAnonExclusive(page), folio);
 }
 
 void hugepage_add_new_anon_rmap(struct folio *folio,
-- 
2.41.0

