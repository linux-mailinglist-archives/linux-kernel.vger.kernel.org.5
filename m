Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2482D7FC2E4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346385AbjK1OwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346396AbjK1OwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:52:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC7710F6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701183136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PsWlt7VFXdpW+l7o+7c53krc3omwX16daxLcjKx1KOM=;
        b=EtKcCPEc9go8qRPBXkw9/0Pr69JStzpTJci1tePwfDL8ZvcbGTRJnCuRmY0sq5zQ+WCHxq
        Yv4d0QhBfNjEehHmlekEBRJXX/Ag6lyAOGyz1+leT23/ZwOZLPol8Tef1wzO0JBktGK1XH
        dSwYzT72PnSyZPn12xAb1OlP6M8K/KA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-OEY_3b4gMlmzc9twX3txxQ-1; Tue,
 28 Nov 2023 09:52:15 -0500
X-MC-Unique: OEY_3b4gMlmzc9twX3txxQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A088B3812597;
        Tue, 28 Nov 2023 14:52:10 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E85F503A;
        Tue, 28 Nov 2023 14:52:09 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>
Subject: [PATCH v1 3/5] mm/rmap: introduce and use hugetlb_add_file_rmap()
Date:   Tue, 28 Nov 2023 15:52:03 +0100
Message-ID: <20231128145205.215026-4-david@redhat.com>
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

hugetlb rmap handling differs quite a lot from "ordinary" rmap code, and
we already have dedicated functions for adding anon hugetlb folios and
removing hugetlb folios.

Right now we're using page_dup_file_rmap() in some cases where "ordinary"
rmap code would have used page_add_file_rmap(). So let's introduce and
use hugetlb_add_file_rmap() instead. We won't be adding a
"hugetlb_dup_file_rmap()" functon for the fork() case, as it would be
doing the same: "dup" is just an optimization for "add".

While this is a cleanup, this will also make it easier to change rmap
handling for partially-mappable folios.

What remains is a single page_dup_file_rmap() call in fork() code.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 7 +++++++
 mm/hugetlb.c         | 6 +++---
 mm/migrate.c         | 2 +-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index e8d1dc1d5361..0a81e8420a96 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -208,6 +208,13 @@ void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
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
index d17bb53b19ff..541a8f38cfdc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5401,7 +5401,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			 * sleep during the process.
 			 */
 			if (!folio_test_anon(pte_folio)) {
-				page_dup_file_rmap(&pte_folio->page, true);
+				hugetlb_add_file_rmap(pte_folio);
 			} else if (page_try_dup_anon_rmap(&pte_folio->page,
 							  true, src_vma)) {
 				pte_t src_pte_old = entry;
@@ -6272,7 +6272,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	if (anon_rmap)
 		hugetlb_add_new_anon_rmap(folio, vma, haddr);
 	else
-		page_dup_file_rmap(&folio->page, true);
+		hugetlb_add_file_rmap(folio);
 	new_pte = make_huge_pte(vma, &folio->page, ((vma->vm_flags & VM_WRITE)
 				&& (vma->vm_flags & VM_SHARED)));
 	/*
@@ -6723,7 +6723,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
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
2.41.0

