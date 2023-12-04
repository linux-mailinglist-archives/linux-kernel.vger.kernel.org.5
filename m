Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868CC8037C6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbjLDO4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235947AbjLDOYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:24:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFAB2130
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701699782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v4HAiul36EO+vclRiaij572sHtWWM/DwfWC2VtVH9HE=;
        b=a76vBY38PqDSwobO96nI3/5poYp/A9ihfLT48/Y7WQS+BVYdwy3pozrFyougVaFzQN88D9
        Jwv8YvIgN5AX91Mk/4ZeQAmHOecPBlZqbYp+8JZO6Ev63LRvRXkncO19PM1eMDnudLqQbx
        LnMM4vxKYFOhjecZ7cCkntwEGgOWwG8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-f9IMTYTNM3mqQeNw2EDP9A-1; Mon, 04 Dec 2023 09:22:59 -0500
X-MC-Unique: f9IMTYTNM3mqQeNw2EDP9A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0378589CA00;
        Mon,  4 Dec 2023 14:22:59 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.195.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 661192026D4C;
        Mon,  4 Dec 2023 14:22:57 +0000 (UTC)
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
Subject: [PATCH RFC 37/39] mm/rmap: remove page_try_dup_anon_rmap()
Date:   Mon,  4 Dec 2023 15:21:44 +0100
Message-ID: <20231204142146.91437-38-david@redhat.com>
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

All users are gone, remove page_try_dup_anon_rmap() and any remaining
traces.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 84439f7720c62..3c1df8e020188 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -251,7 +251,7 @@ void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
 void hugetlb_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address);
 
-/* See page_try_dup_anon_rmap() */
+/* See folio_try_dup_anon_rmap_*() */
 static inline int hugetlb_try_dup_anon_rmap(struct folio *folio,
 		struct vm_area_struct *vma)
 {
@@ -463,16 +463,6 @@ static inline int folio_try_dup_anon_rmap_pmd(struct folio *folio,
 #endif
 }
 
-static inline int page_try_dup_anon_rmap(struct page *page, bool compound,
-					 struct vm_area_struct *vma)
-{
-	struct folio *folio = page_folio(page);
-
-	if (likely(!compound))
-		return folio_try_dup_anon_rmap_pte(folio, page, vma);
-	return folio_try_dup_anon_rmap_pmd(folio, page, vma);
-}
-
 /**
  * page_try_share_anon_rmap - try marking an exclusive anonymous page possibly
  *			      shared to prepare for KSM or temporary unmapping
@@ -481,8 +471,8 @@ static inline int page_try_dup_anon_rmap(struct page *page, bool compound,
  * The caller needs to hold the PT lock and has to have the page table entry
  * cleared/invalidated.
  *
- * This is similar to page_try_dup_anon_rmap(), however, not used during fork()
- * to duplicate a mapping, but instead to prepare for KSM or temporarily
+ * This is similar to folio_try_dup_anon_rmap_*(), however, not used during
+ * fork() to duplicate a mapping, but instead to prepare for KSM or temporarily
  * unmapping a page (swap, migration) via folio_remove_rmap_*().
  *
  * Marking the page shared can only fail if the page may be pinned; device
-- 
2.41.0

