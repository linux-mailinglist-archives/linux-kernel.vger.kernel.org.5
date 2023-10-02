Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF197B5500
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237789AbjJBOav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237778AbjJBOaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:30:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8E0A4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 07:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696256997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=74/4kguVt+JNeClEzh2bgjVFXMUXyl4kPsimySG+lfk=;
        b=Y5U0Y6mUvc8tOXPyv+L+x1UMw0c1OVT8QsrdyGbyM1M/50aKRRxm6XtRpswBuwazG1AzP7
        lV8tLpNd/idC0q8/4mPNDBCJTLSbwbVei6gZ1VJjwg5HYTXSeCmwzEfP0Cw7hYv5EZpVI8
        pIkD6uJfBxaJmPygfwPQdY3+Cd/aZmA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-237-MXePQoblNP-G9nwx88mC8A-1; Mon, 02 Oct 2023 10:29:53 -0400
X-MC-Unique: MXePQoblNP-G9nwx88mC8A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C5A84801779;
        Mon,  2 Oct 2023 14:29:52 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A52811005B90;
        Mon,  2 Oct 2023 14:29:51 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v1 1/3] mm/rmap: move SetPageAnonExclusive() out of page_move_anon_rmap()
Date:   Mon,  2 Oct 2023 16:29:47 +0200
Message-ID: <20231002142949.235104-2-david@redhat.com>
In-Reply-To: <20231002142949.235104-1-david@redhat.com>
References: <20231002142949.235104-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's move it into the caller: there is a difference between whether an
anon folio can only be mapped by one process (e.g., into one VMA), and
whether it is truly exclusive (e.g., no references -- including GUP --
from other processes).

Further, for large folios the page might not actually be pointing at the
head page of the folio, so it better be handled in the caller. This is a
preparation for converting page_move_anon_rmap() to consume a folio.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 1 +
 mm/hugetlb.c     | 4 +++-
 mm/memory.c      | 1 +
 mm/rmap.c        | 1 -
 4 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e54fb9c542bb..01d0d65ece13 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1506,6 +1506,7 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 		pmd_t entry;
 
 		page_move_anon_rmap(page, vma);
+		SetPageAnonExclusive(page);
 		folio_unlock(folio);
 reuse:
 		if (unlikely(unshare)) {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9c22297d9c57..24591fc145ff 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5460,8 +5460,10 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * owner and can reuse this page.
 	 */
 	if (folio_mapcount(old_folio) == 1 && folio_test_anon(old_folio)) {
-		if (!PageAnonExclusive(&old_folio->page))
+		if (!PageAnonExclusive(&old_folio->page)) {
 			page_move_anon_rmap(&old_folio->page, vma);
+			SetPageAnonExclusive(&old_folio->page);
+		}
 		if (likely(!unshare))
 			set_huge_ptep_writable(vma, haddr, ptep);
 
diff --git a/mm/memory.c b/mm/memory.c
index d4820802b01b..9de231c92769 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3484,6 +3484,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 		 * sunglasses. Hit it.
 		 */
 		page_move_anon_rmap(vmf->page, vma);
+		SetPageAnonExclusive(vmf->page);
 		folio_unlock(folio);
 reuse:
 		if (unlikely(unshare)) {
diff --git a/mm/rmap.c b/mm/rmap.c
index 77222adccda1..854ccbd66954 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1165,7 +1165,6 @@ void page_move_anon_rmap(struct page *page, struct vm_area_struct *vma)
 	 * folio_test_anon()) will not see one without the other.
 	 */
 	WRITE_ONCE(folio->mapping, anon_vma);
-	SetPageAnonExclusive(page);
 }
 
 /**
-- 
2.41.0

