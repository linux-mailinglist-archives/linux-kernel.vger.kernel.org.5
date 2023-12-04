Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F006280367D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345192AbjLDOYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbjLDOYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:24:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0756B210A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701699773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wmC0HbMgxf2wn+iz2jDhVN1M/dlanF/535x+xcS2yyw=;
        b=NqqW0uZEQlsoBadTPWHP/iGo1h4bNQCRSHnmK2iKLGnE0NSSOOkbWn+bSCTIKQtZeIR6Jw
        UqXNQYT8PJbOF4363mdtsh8GouYZLzhcITRpBUk9TjDypHAij6uXIzaKq4ciLz72AYQzWV
        IpEYAGnGTeljVlLsqrgvO0scSac/mAw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-0wmHc9idP7KPtoNc59ZDjA-1; Mon, 04 Dec 2023 09:22:47 -0500
X-MC-Unique: 0wmHc9idP7KPtoNc59ZDjA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FEA085A5B5;
        Mon,  4 Dec 2023 14:22:45 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.195.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA6A22026D4C;
        Mon,  4 Dec 2023 14:22:43 +0000 (UTC)
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
Subject: [PATCH RFC 30/39] mm/rmap: page_remove_rmap() -> folio_remove_rmap_pte()
Date:   Mon,  4 Dec 2023 15:21:37 +0100
Message-ID: <20231204142146.91437-31-david@redhat.com>
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

Let's convert try_to_unmap_one() and try_to_migrate_one().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/rmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 50b6909157ac1..4a0114d04ab48 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1598,7 +1598,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
-	 * in between its ptep_get_and_clear_full() and page_remove_rmap(),
+	 * in between its ptep_get_and_clear_full() and folio_remove_rmap_*(),
 	 * try_to_unmap() may return before page_mapped() has become false,
 	 * if page table locking is skipped: use TTU_SYNC to wait for that.
 	 */
@@ -1879,7 +1879,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		if (unlikely(folio_test_hugetlb(folio)))
 			hugetlb_remove_rmap(folio);
 		else
-			page_remove_rmap(subpage, vma, false);
+			folio_remove_rmap_pte(folio, subpage, vma);
 		if (vma->vm_flags & VM_LOCKED)
 			mlock_drain_local();
 		folio_put(folio);
@@ -1947,7 +1947,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
-	 * in between its ptep_get_and_clear_full() and page_remove_rmap(),
+	 * in between its ptep_get_and_clear_full() and folio_remove_rmap_*(),
 	 * try_to_migrate() may return before page_mapped() has become false,
 	 * if page table locking is skipped: use TTU_SYNC to wait for that.
 	 */
@@ -2240,7 +2240,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 		if (unlikely(folio_test_hugetlb(folio)))
 			hugetlb_remove_rmap(folio);
 		else
-			page_remove_rmap(subpage, vma, false);
+			folio_remove_rmap_pte(folio, subpage, vma);
 		if (vma->vm_flags & VM_LOCKED)
 			mlock_drain_local();
 		folio_put(folio);
@@ -2379,7 +2379,7 @@ static bool page_make_device_exclusive_one(struct folio *folio,
 		 * There is a reference on the page for the swap entry which has
 		 * been removed, so shouldn't take another.
 		 */
-		page_remove_rmap(subpage, vma, false);
+		folio_remove_rmap_pte(folio, subpage, vma);
 	}
 
 	mmu_notifier_invalidate_range_end(&range);
-- 
2.41.0

