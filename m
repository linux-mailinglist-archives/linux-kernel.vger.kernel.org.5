Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1065679E859
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240777AbjIMMwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240587AbjIMMwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:52:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 787C719BB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694609492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t7xwwUMm6Z1sTtxTNKBbcilCnHU1Bmn/mrplLkXOKnQ=;
        b=XjRh1VaHkxphM4qrtl5pZCD5YZrVeBkTtuXJ2mFaj7A0cLGZEDtzoflWtxzEYyJ95oxgxb
        sYWJJoIslHmcWZcvuF6wWJhHpPS/q0H5uScJqP2hesramQf7thyUMIUT9iHgfqupYBcucn
        KpQku2qKfrQD+M/yRcYGJvtu5G7cPZU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-389-tgr1yN5WMfuxKuox-CRlxA-1; Wed, 13 Sep 2023 08:51:29 -0400
X-MC-Unique: tgr1yN5WMfuxKuox-CRlxA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06B9A857A9E;
        Wed, 13 Sep 2023 12:51:29 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD4432156722;
        Wed, 13 Sep 2023 12:51:27 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>
Subject: [PATCH v1 6/6] mm/rmap: pass folio to hugepage_add_anon_rmap()
Date:   Wed, 13 Sep 2023 14:51:13 +0200
Message-ID: <20230913125113.313322-7-david@redhat.com>
In-Reply-To: <20230913125113.313322-1-david@redhat.com>
References: <20230913125113.313322-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's pass a folio; we are always mapping the entire thing.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 2 +-
 mm/migrate.c         | 2 +-
 mm/rmap.c            | 8 +++-----
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 51cc21ebb568..d22f4d21a11c 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -203,7 +203,7 @@ void folio_add_file_rmap_range(struct folio *, struct page *, unsigned int nr,
 void page_remove_rmap(struct page *, struct vm_area_struct *,
 		bool compound);
 
-void hugepage_add_anon_rmap(struct page *, struct vm_area_struct *,
+void hugepage_add_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address, rmap_t flags);
 void hugepage_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address);
diff --git a/mm/migrate.c b/mm/migrate.c
index 123fc4dc0bc4..d4e8cbf0a704 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -247,7 +247,7 @@ static bool remove_migration_pte(struct folio *folio,
 
 			pte = arch_make_huge_pte(pte, shift, vma->vm_flags);
 			if (folio_test_anon(folio))
-				hugepage_add_anon_rmap(new, vma, pvmw.address,
+				hugepage_add_anon_rmap(folio, vma, pvmw.address,
 						       rmap_flags);
 			else
 				page_dup_file_rmap(new, true);
diff --git a/mm/rmap.c b/mm/rmap.c
index 10d477a0991f..789a2beb8b3a 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2527,18 +2527,16 @@ void rmap_walk_locked(struct folio *folio, struct rmap_walk_control *rwc)
  *
  * RMAP_COMPOUND is ignored.
  */
-void hugepage_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
+void hugepage_add_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 			    unsigned long address, rmap_t flags)
 {
-	struct folio *folio = page_folio(page);
-
 	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
 
 	atomic_inc(&folio->_entire_mapcount);
 	if (flags & RMAP_EXCLUSIVE)
-		SetPageAnonExclusive(page);
+		SetPageAnonExclusive(&folio->page);
 	VM_WARN_ON_FOLIO(folio_entire_mapcount(folio) > 1 &&
-			 PageAnonExclusive(page), folio);
+			 PageAnonExclusive(&folio->page), folio);
 }
 
 void hugepage_add_new_anon_rmap(struct folio *folio,
-- 
2.41.0

