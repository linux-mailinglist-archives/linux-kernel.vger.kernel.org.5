Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD95C80D034
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344518AbjLKP5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344509AbjLKP50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:57:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3863110A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702310252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DP/TBY2FfVhMMZMh3t2xGvG39Fvp3GsRcAEgonPxhwA=;
        b=Xzn5cTat5p+eejld5q+0GDwHOrr1gaA5SJeWrbTL0izXJqSM4fcSiUhswhyJtNb3nq3d7r
        bhYV4e5N50AUhiGZJyVAzlSjDq4l9i5Fbjxl4VobvYJRjCNaHHJ1ETQKJJmSyffs0MMlbf
        AAh2EEsbz+zkSodsG/NoPZ708vNxq1A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-nYAYGRlYOBO4fpab-9MmDA-1; Mon, 11 Dec 2023 10:57:27 -0500
X-MC-Unique: nYAYGRlYOBO4fpab-9MmDA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7362810133A0;
        Mon, 11 Dec 2023 15:57:26 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9447E1121306;
        Mon, 11 Dec 2023 15:57:24 +0000 (UTC)
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
Subject: [PATCH v1 12/39] mm/rmap: remove page_add_file_rmap()
Date:   Mon, 11 Dec 2023 16:56:25 +0100
Message-ID: <20231211155652.131054-13-david@redhat.com>
In-Reply-To: <20231211155652.131054-1-david@redhat.com>
References: <20231211155652.131054-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All users are gone, let's remove it.

Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h |  2 --
 mm/rmap.c            | 21 ---------------------
 2 files changed, 23 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 1753900f4aed..7198905dc8be 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -240,8 +240,6 @@ void page_add_new_anon_rmap(struct page *, struct vm_area_struct *,
 		unsigned long address);
 void folio_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address);
-void page_add_file_rmap(struct page *, struct vm_area_struct *,
-		bool compound);
 void folio_add_file_rmap_ptes(struct folio *, struct page *, int nr_pages,
 		struct vm_area_struct *);
 #define folio_add_file_rmap_pte(folio, page, vma) \
diff --git a/mm/rmap.c b/mm/rmap.c
index 4f30930a1162..2ff2f11275e5 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1467,27 +1467,6 @@ void folio_add_file_rmap_pmd(struct folio *folio, struct page *page,
 #endif
 }
 
-/**
- * page_add_file_rmap - add pte mapping to a file page
- * @page:	the page to add the mapping to
- * @vma:	the vm area in which the mapping is added
- * @compound:	charge the page as compound or small page
- *
- * The caller needs to hold the pte lock.
- */
-void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
-		bool compound)
-{
-	struct folio *folio = page_folio(page);
-
-	VM_WARN_ON_ONCE_PAGE(compound && !PageTransHuge(page), page);
-
-	if (likely(!compound))
-		folio_add_file_rmap_pte(folio, page, vma);
-	else
-		folio_add_file_rmap_pmd(folio, page, vma);
-}
-
 /**
  * page_remove_rmap - take down pte mapping from a page
  * @page:	page to remove mapping from
-- 
2.43.0

