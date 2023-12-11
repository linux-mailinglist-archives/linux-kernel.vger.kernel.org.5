Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC50880D028
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344471AbjLKP5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344472AbjLKP5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:57:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6F6F3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702310230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eQFoT8xrLd9LUZRih2ZF29493QEHiYzpAeVB57UisD0=;
        b=cK/oeP1ouam/D+5+S4uhtaHIB7DBFVudnPTmX7aEjMpRgaClH695MluwewQAhP22ob9dVc
        GFPnwk9nS1q1Y7huvCaxx2lx//1oG1beysZJP1TcN6MFe1QsOAzCZrIlcwt7FSXYHMoy2j
        pKCjW4VFUrzdyRZFWKKxH+KecZ79IJw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-xxnUSZcjMXupZYk_PaLjmg-1; Mon,
 11 Dec 2023 10:57:05 -0500
X-MC-Unique: xxnUSZcjMXupZYk_PaLjmg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D0001C01B3A;
        Mon, 11 Dec 2023 15:57:04 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2EA5E1121306;
        Mon, 11 Dec 2023 15:57:01 +0000 (UTC)
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
Subject: [PATCH v1 03/39] mm/rmap: introduce and use hugetlb_add_file_rmap()
Date:   Mon, 11 Dec 2023 16:56:16 +0100
Message-ID: <20231211155652.131054-4-david@redhat.com>
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

hugetlb rmap handling differs quite a lot from "ordinary" rmap code.
For example, hugetlb currently only supports entire mappings, and treats
any mapping as mapped using a single "logical PTE". Let's move it out
of the way so we can overhaul our "ordinary" rmap.
implementation/interface.

Right now we're using page_dup_file_rmap() in some cases where "ordinary"
rmap code would have used page_add_file_rmap(). So let's introduce and
use hugetlb_add_file_rmap() instead. We won't be adding a
"hugetlb_dup_file_rmap()" functon for the fork() case, as it would be
doing the same: "dup" is just an optimization for "add".

What remains is a single page_dup_file_rmap() call in fork() code.

Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 7 +++++++
 mm/hugetlb.c         | 6 +++---
 mm/migrate.c         | 2 +-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index d85bd1d4de04..91178d1aa028 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -213,6 +213,13 @@ void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
 void hugetlb_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address);
 
+static inline void hugetlb_add_file_rmap(struct folio *folio)
+{
+	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
+
+	atomic_inc(&folio->_entire_mapcount);
+}
+
 static inline void hugetlb_remove_rmap(struct folio *folio)
 {
 	atomic_dec(&folio->_entire_mapcount);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ef48ae673890..57e898187931 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5408,7 +5408,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			 * sleep during the process.
 			 */
 			if (!folio_test_anon(pte_folio)) {
-				page_dup_file_rmap(&pte_folio->page, true);
+				hugetlb_add_file_rmap(pte_folio);
 			} else if (page_try_dup_anon_rmap(&pte_folio->page,
 							  true, src_vma)) {
 				pte_t src_pte_old = entry;
@@ -6279,7 +6279,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	if (anon_rmap)
 		hugetlb_add_new_anon_rmap(folio, vma, haddr);
 	else
-		page_dup_file_rmap(&folio->page, true);
+		hugetlb_add_file_rmap(folio);
 	new_pte = make_huge_pte(vma, &folio->page, ((vma->vm_flags & VM_WRITE)
 				&& (vma->vm_flags & VM_SHARED)));
 	/*
@@ -6730,7 +6730,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 		goto out_release_unlock;
 
 	if (folio_in_pagecache)
-		page_dup_file_rmap(&folio->page, true);
+		hugetlb_add_file_rmap(folio);
 	else
 		hugetlb_add_new_anon_rmap(folio, dst_vma, dst_addr);
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 4cb849fa0dd2..de9d94b99ab7 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -252,7 +252,7 @@ static bool remove_migration_pte(struct folio *folio,
 				hugetlb_add_anon_rmap(folio, vma, pvmw.address,
 						      rmap_flags);
 			else
-				page_dup_file_rmap(new, true);
+				hugetlb_add_file_rmap(folio);
 			set_huge_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte,
 					psize);
 		} else
-- 
2.43.0

