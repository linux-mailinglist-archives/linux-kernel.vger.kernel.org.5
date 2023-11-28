Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B51E7FC112
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346407AbjK1OwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346384AbjK1OwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:52:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83001701
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701183137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2oP52ROWQFWEf94d+ZcdDH9xIN9/viIr5hzxAC40F1s=;
        b=A1RS3WSs73Ghrw8nLtKzKhrT9wn7+PWalZ5oMzMSXyufOj5BE4gpTjHSFmQbzuBUALBbGU
        z0Eo1JzQo3dB20Yred1YjI/WtgESh8bDiJW1c3rvYVYUiymO/qmgQz9z4dhQlOGue6OhS3
        8NpXtobQVhVHV7Ky9rF4nSeQk5cSEcs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-n6VIUHicO2m-dt6V1ZNSMQ-1; Tue,
 28 Nov 2023 09:52:13 -0500
X-MC-Unique: n6VIUHicO2m-dt6V1ZNSMQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 237E03C100B4;
        Tue, 28 Nov 2023 14:52:13 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24AC310E45;
        Tue, 28 Nov 2023 14:52:12 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>
Subject: [PATCH v1 5/5] mm/rmap: add hugetlb sanity checks
Date:   Tue, 28 Nov 2023 15:52:05 +0100
Message-ID: <20231128145205.215026-6-david@redhat.com>
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

Let's make sure we end up with the right folios in the right functions.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 6 ++++++
 mm/rmap.c            | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 8068c332e2ce..9625b6551d01 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -212,6 +212,7 @@ void hugetlb_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
 static inline int hugetlb_try_dup_anon_rmap(struct folio *folio,
 		struct vm_area_struct *vma)
 {
+	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
 	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
 
 	if (PageAnonExclusive(&folio->page)) {
@@ -225,6 +226,7 @@ static inline int hugetlb_try_dup_anon_rmap(struct folio *folio,
 
 static inline void hugetlb_add_file_rmap(struct folio *folio)
 {
+	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
 	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
 
 	atomic_inc(&folio->_entire_mapcount);
@@ -232,11 +234,15 @@ static inline void hugetlb_add_file_rmap(struct folio *folio)
 
 static inline void hugetlb_remove_rmap(struct folio *folio)
 {
+	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
+
 	atomic_dec(&folio->_entire_mapcount);
 }
 
 static inline void __page_dup_rmap(struct page *page, bool compound)
 {
+	VM_WARN_ON(folio_test_hugetlb(page_folio(page)));
+
 	if (compound) {
 		struct folio *folio = (struct folio *)page;
 
diff --git a/mm/rmap.c b/mm/rmap.c
index 5037581b79ec..466f1ea5d0a6 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1313,6 +1313,7 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 {
 	int nr;
 
+	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
 	__folio_set_swapbacked(folio);
 
@@ -1353,6 +1354,7 @@ void folio_add_file_rmap_range(struct folio *folio, struct page *page,
 	unsigned int nr_pmdmapped = 0, first;
 	int nr = 0;
 
+	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 	VM_WARN_ON_FOLIO(compound && !folio_test_pmd_mappable(folio), folio);
 
 	/* Is page being mapped by PTE? Is this its first map to be added? */
@@ -1438,6 +1440,7 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
 	bool last;
 	enum node_stat_item idx;
 
+	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 	VM_BUG_ON_PAGE(compound && !PageHead(page), page);
 
 	/* Is page being unmapped by PTE? Is this its last map to be removed? */
@@ -2585,6 +2588,7 @@ void rmap_walk_locked(struct folio *folio, struct rmap_walk_control *rwc)
 void hugetlb_add_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 		unsigned long address, rmap_t flags)
 {
+	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
 	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
 
 	atomic_inc(&folio->_entire_mapcount);
@@ -2597,6 +2601,8 @@ void hugetlb_add_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 void hugetlb_add_new_anon_rmap(struct folio *folio,
 		struct vm_area_struct *vma, unsigned long address)
 {
+	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
+
 	BUG_ON(address < vma->vm_start || address >= vma->vm_end);
 	/* increment count (starts at -1) */
 	atomic_set(&folio->_entire_mapcount, 0);
-- 
2.41.0

