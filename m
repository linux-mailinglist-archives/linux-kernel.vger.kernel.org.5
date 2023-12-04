Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D2180365D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235847AbjLDOWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345241AbjLDOWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:22:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830F611A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701699734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O9+7fynWu7ZwbI+2ouLA8wkNah+BDZS2kzyGsyNToAE=;
        b=fNC1J8D/0iuCGNB1IqlYZ6TXf75nLxeC1QVgjBvLFcW+cTsbaBkGvKXsPMsUsa3sVW4l77
        UpT65iKhAkfTyuyjAJYNMSxan4ZqAjRKMi4MHqFJhrnb4xd0RbL105RP4VR8+kQQedJLB/
        xYpq3CAw0kCkB0NaBCXU6/z/0PC7TqE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-ekuHhhc4MEqvFS8uO4ctFw-1; Mon, 04 Dec 2023 09:22:11 -0500
X-MC-Unique: ekuHhhc4MEqvFS8uO4ctFw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E725811E7E;
        Mon,  4 Dec 2023 14:22:11 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.195.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 616822026D68;
        Mon,  4 Dec 2023 14:22:09 +0000 (UTC)
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
Subject: [PATCH RFC 12/39] mm/rmap: remove page_add_file_rmap()
Date:   Mon,  4 Dec 2023 15:21:19 +0100
Message-ID: <20231204142146.91437-13-david@redhat.com>
In-Reply-To: <20231204142146.91437-1-david@redhat.com>
References: <20231204142146.91437-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h |  2 --
 mm/rmap.c            | 21 ---------------------
 2 files changed, 23 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index a4a30c361ac50..95f7b94a70295 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -235,8 +235,6 @@ void page_add_new_anon_rmap(struct page *, struct vm_area_struct *,
 		unsigned long address);
 void folio_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address);
-void page_add_file_rmap(struct page *, struct vm_area_struct *,
-		bool compound);
 void folio_add_file_rmap_ptes(struct folio *, struct page *, unsigned int nr,
 		struct vm_area_struct *);
 #define folio_add_file_rmap_pte(folio, page, vma) \
diff --git a/mm/rmap.c b/mm/rmap.c
index 1614d98062948..53e2c653be99a 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1422,27 +1422,6 @@ void folio_add_file_rmap_pmd(struct folio *folio, struct page *page,
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
2.41.0

