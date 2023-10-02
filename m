Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC31C7B5518
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237769AbjJBOah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237639AbjJBOag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:30:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32A2B4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 07:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696256998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iuOLWxV07WMAFicgIRp5L49gcu/vw0Qb9ZJxOn72iWI=;
        b=Rp5mwb27nYLeg/ebKD8hUPPEEqGAh7M8PnrgvsHCCLasadeMTcKs+opWXHRbmeIVaRSgdE
        RKoOeLcW4Wvjsr/nufhf8jb+7isNJrCw3GksEfIQJKl9v/bZc2O/8y1hX3dLHXApReTaX4
        cJ6sRzEiboU/KZOpilrmTWHJOy6m0eQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-A63WA2viPemAtiRYluLjVw-1; Mon, 02 Oct 2023 10:29:54 -0400
X-MC-Unique: A63WA2viPemAtiRYluLjVw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26B71802C1A;
        Mon,  2 Oct 2023 14:29:54 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09C2510EE6CE;
        Mon,  2 Oct 2023 14:29:52 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v1 2/3] mm/rmap: convert page_move_anon_rmap() to folio_move_anon_rmap()
Date:   Mon,  2 Oct 2023 16:29:48 +0200
Message-ID: <20231002142949.235104-3-david@redhat.com>
In-Reply-To: <20231002142949.235104-1-david@redhat.com>
References: <20231002142949.235104-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's convert it to consume a folio.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h |  2 +-
 mm/huge_memory.c     |  2 +-
 mm/hugetlb.c         |  2 +-
 mm/memory.c          |  2 +-
 mm/rmap.c            | 16 +++++++---------
 5 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 064b432a4033..8034eda972e5 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -194,7 +194,7 @@ typedef int __bitwise rmap_t;
 /*
  * rmap interfaces called when adding or removing pte of page
  */
-void page_move_anon_rmap(struct page *, struct vm_area_struct *);
+void folio_move_anon_rmap(struct folio *, struct vm_area_struct *);
 void page_add_anon_rmap(struct page *, struct vm_area_struct *,
 		unsigned long address, rmap_t flags);
 void page_add_new_anon_rmap(struct page *, struct vm_area_struct *,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 01d0d65ece13..08245226ccb8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1505,7 +1505,7 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 	if (folio_ref_count(folio) == 1) {
 		pmd_t entry;
 
-		page_move_anon_rmap(page, vma);
+		folio_move_anon_rmap(folio, vma);
 		SetPageAnonExclusive(page);
 		folio_unlock(folio);
 reuse:
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 24591fc145ff..e52c6048e74f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5461,7 +5461,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 */
 	if (folio_mapcount(old_folio) == 1 && folio_test_anon(old_folio)) {
 		if (!PageAnonExclusive(&old_folio->page)) {
-			page_move_anon_rmap(&old_folio->page, vma);
+			folio_move_anon_rmap(old_folio, vma);
 			SetPageAnonExclusive(&old_folio->page);
 		}
 		if (likely(!unshare))
diff --git a/mm/memory.c b/mm/memory.c
index 9de231c92769..1f0e3317cbdd 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3483,7 +3483,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 		 * and the folio is locked, it's dark out, and we're wearing
 		 * sunglasses. Hit it.
 		 */
-		page_move_anon_rmap(vmf->page, vma);
+		folio_move_anon_rmap(folio, vma);
 		SetPageAnonExclusive(vmf->page);
 		folio_unlock(folio);
 reuse:
diff --git a/mm/rmap.c b/mm/rmap.c
index 854ccbd66954..37f05f33559b 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1141,19 +1141,17 @@ int folio_total_mapcount(struct folio *folio)
 }
 
 /**
- * page_move_anon_rmap - move a page to our anon_vma
- * @page:	the page to move to our anon_vma
- * @vma:	the vma the page belongs to
+ * folio_move_anon_rmap - move a folio to our anon_vma
+ * @page:	The folio to move to our anon_vma
+ * @vma:	The vma the folio belongs to
  *
- * When a page belongs exclusively to one process after a COW event,
- * that page can be moved into the anon_vma that belongs to just that
- * process, so the rmap code will not search the parent or sibling
- * processes.
+ * When a folio belongs exclusively to one process after a COW event,
+ * that folio can be moved into the anon_vma that belongs to just that
+ * process, so the rmap code will not search the parent or sibling processes.
  */
-void page_move_anon_rmap(struct page *page, struct vm_area_struct *vma)
+void folio_move_anon_rmap(struct folio *folio, struct vm_area_struct *vma)
 {
 	void *anon_vma = vma->anon_vma;
-	struct folio *folio = page_folio(page);
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_VMA(!anon_vma, vma);
-- 
2.41.0

