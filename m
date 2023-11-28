Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61797FC130
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346388AbjK1OwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346347AbjK1OwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:52:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBB710F4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701183136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v3TJbNWNpIXvBErov8koQ5cDTRfHHR66tcHCVvKwONQ=;
        b=RUxfsXEwVlLDutCxgkVC6g65nzDeoOiiDHea83quOvvxeDTT5Fq4gK2dKpNyg+dVp5l6y0
        T3mXxYR6J0sIMATsYc5AzZI5tM7zwzcQoSXjiJ27AqN7ZGJYzMWjgbeDg1Mwmorz2p0Z5s
        yPikfd+Pnjr6eFwxGN4T3v26z3Jsd7E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-Ns9ZSoWwPHWGhnYE2l0gLQ-1; Tue, 28 Nov 2023 09:52:08 -0500
X-MC-Unique: Ns9ZSoWwPHWGhnYE2l0gLQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3029D1019C83;
        Tue, 28 Nov 2023 14:52:08 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 232B85028;
        Tue, 28 Nov 2023 14:52:07 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>
Subject: [PATCH v1 1/5] mm/rmap: rename hugepage_add* to hugetlb_add*
Date:   Tue, 28 Nov 2023 15:52:01 +0100
Message-ID: <20231128145205.215026-2-david@redhat.com>
In-Reply-To: <20231128145205.215026-1-david@redhat.com>
References: <20231128145205.215026-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's just call it "hugetlb_".

Yes, it's all already inconsistent and confusing because we have a lot
of "hugepage_" functions for legacy reasons. But "hugetlb" cannot possibly
be confused with transparent huge pages, and it matches "hugetlb.c" and
"folio_test_hugetlb()". So let's minimize confusion in rmap code.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 4 ++--
 mm/hugetlb.c         | 8 ++++----
 mm/migrate.c         | 4 ++--
 mm/rmap.c            | 8 ++++----
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index b26fe858fd44..4c5bfeb05463 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -203,9 +203,9 @@ void folio_add_file_rmap_range(struct folio *, struct page *, unsigned int nr,
 void page_remove_rmap(struct page *, struct vm_area_struct *,
 		bool compound);
 
-void hugepage_add_anon_rmap(struct folio *, struct vm_area_struct *,
+void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address, rmap_t flags);
-void hugepage_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
+void hugetlb_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address);
 
 static inline void __page_dup_rmap(struct page *page, bool compound)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1169ef2f2176..4cfa0679661e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5278,7 +5278,7 @@ hugetlb_install_folio(struct vm_area_struct *vma, pte_t *ptep, unsigned long add
 	pte_t newpte = make_huge_pte(vma, &new_folio->page, 1);
 
 	__folio_mark_uptodate(new_folio);
-	hugepage_add_new_anon_rmap(new_folio, vma, addr);
+	hugetlb_add_new_anon_rmap(new_folio, vma, addr);
 	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(old))
 		newpte = huge_pte_mkuffd_wp(newpte);
 	set_huge_pte_at(vma->vm_mm, addr, ptep, newpte, sz);
@@ -5981,7 +5981,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		/* Break COW or unshare */
 		huge_ptep_clear_flush(vma, haddr, ptep);
 		page_remove_rmap(&old_folio->page, vma, true);
-		hugepage_add_new_anon_rmap(new_folio, vma, haddr);
+		hugetlb_add_new_anon_rmap(new_folio, vma, haddr);
 		if (huge_pte_uffd_wp(pte))
 			newpte = huge_pte_mkuffd_wp(newpte);
 		set_huge_pte_at(mm, haddr, ptep, newpte, huge_page_size(h));
@@ -6270,7 +6270,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		goto backout;
 
 	if (anon_rmap)
-		hugepage_add_new_anon_rmap(folio, vma, haddr);
+		hugetlb_add_new_anon_rmap(folio, vma, haddr);
 	else
 		page_dup_file_rmap(&folio->page, true);
 	new_pte = make_huge_pte(vma, &folio->page, ((vma->vm_flags & VM_WRITE)
@@ -6725,7 +6725,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 	if (folio_in_pagecache)
 		page_dup_file_rmap(&folio->page, true);
 	else
-		hugepage_add_new_anon_rmap(folio, dst_vma, dst_addr);
+		hugetlb_add_new_anon_rmap(folio, dst_vma, dst_addr);
 
 	/*
 	 * For either: (1) CONTINUE on a non-shared VMA, or (2) UFFDIO_COPY
diff --git a/mm/migrate.c b/mm/migrate.c
index 35a88334bb3c..4cb849fa0dd2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -249,8 +249,8 @@ static bool remove_migration_pte(struct folio *folio,
 
 			pte = arch_make_huge_pte(pte, shift, vma->vm_flags);
 			if (folio_test_anon(folio))
-				hugepage_add_anon_rmap(folio, vma, pvmw.address,
-						       rmap_flags);
+				hugetlb_add_anon_rmap(folio, vma, pvmw.address,
+						      rmap_flags);
 			else
 				page_dup_file_rmap(new, true);
 			set_huge_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte,
diff --git a/mm/rmap.c b/mm/rmap.c
index 7a27a2b41802..112467c30b2c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2583,8 +2583,8 @@ void rmap_walk_locked(struct folio *folio, struct rmap_walk_control *rwc)
  *
  * RMAP_COMPOUND is ignored.
  */
-void hugepage_add_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
-			    unsigned long address, rmap_t flags)
+void hugetlb_add_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
+		unsigned long address, rmap_t flags)
 {
 	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
 
@@ -2595,8 +2595,8 @@ void hugepage_add_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 			 PageAnonExclusive(&folio->page), folio);
 }
 
-void hugepage_add_new_anon_rmap(struct folio *folio,
-			struct vm_area_struct *vma, unsigned long address)
+void hugetlb_add_new_anon_rmap(struct folio *folio,
+		struct vm_area_struct *vma, unsigned long address)
 {
 	BUG_ON(address < vma->vm_start || address >= vma->vm_end);
 	/* increment count (starts at -1) */
-- 
2.41.0

