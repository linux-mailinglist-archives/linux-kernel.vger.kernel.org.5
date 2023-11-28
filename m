Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122E27FC1DC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346430AbjK1OwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346370AbjK1OwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:52:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAB5D5D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701183138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OTmuEGR3gJmZpzV6zcBNIBMMhBTdNFHIsA/oNnAKXzk=;
        b=Lajk4O61sCSZ46Eo29/44tmEoAt02sWZYeveNXPg5vfLdv3xKlkd5iVPdYadeteDBT4eMW
        xVBHxBsgZwFOp4jusnARHDNeNPsDKLj+zrzCJLkdgHh/HCW0nwXrStRoIa5PHj+6HMgmzY
        dT3mFtjuKc1NE66qp7eGOe/F926OqlQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-vnhnDkNXPWC8poKFInuLGw-1; Tue,
 28 Nov 2023 09:52:12 -0500
X-MC-Unique: vnhnDkNXPWC8poKFInuLGw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDC0C2825E9F;
        Tue, 28 Nov 2023 14:52:11 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D8D0D5028;
        Tue, 28 Nov 2023 14:52:10 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>
Subject: [PATCH v1 4/5] mm/rmap: introduce and use hugetlb_try_dup_anon_rmap()
Date:   Tue, 28 Nov 2023 15:52:04 +0100
Message-ID: <20231128145205.215026-5-david@redhat.com>
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

So let's introduce and use hugetlb_try_dup_anon_rmap() to make all
hugetlb handling use dedicated hugetlb_* rmap functions.

While this is a cleanup, this will also make it easier to change rmap
handling for partially-mappable folios.

Note that is_device_private_page() does not apply to hugetlb.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h   | 12 +++++++++---
 include/linux/rmap.h | 15 +++++++++++++++
 mm/hugetlb.c         |  3 +--
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 418d26608ece..24c1c7c5a99c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1953,15 +1953,21 @@ static inline bool page_maybe_dma_pinned(struct page *page)
  *
  * The caller has to hold the PT lock and the vma->vm_mm->->write_protect_seq.
  */
-static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
-					  struct page *page)
+static inline bool folio_needs_cow_for_dma(struct vm_area_struct *vma,
+					  struct folio *folio)
 {
 	VM_BUG_ON(!(raw_read_seqcount(&vma->vm_mm->write_protect_seq) & 1));
 
 	if (!test_bit(MMF_HAS_PINNED, &vma->vm_mm->flags))
 		return false;
 
-	return page_maybe_dma_pinned(page);
+	return folio_maybe_dma_pinned(folio);
+}
+
+static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
+					  struct page *page)
+{
+	return folio_needs_cow_for_dma(vma, page_folio(page));
 }
 
 /**
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 0a81e8420a96..8068c332e2ce 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -208,6 +208,21 @@ void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
 void hugetlb_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address);
 
+/* See page_try_dup_anon_rmap() */
+static inline int hugetlb_try_dup_anon_rmap(struct folio *folio,
+		struct vm_area_struct *vma)
+{
+	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
+
+	if (PageAnonExclusive(&folio->page)) {
+		if (unlikely(folio_needs_cow_for_dma(vma, folio)))
+			return -EBUSY;
+		ClearPageAnonExclusive(&folio->page);
+	}
+	atomic_inc(&folio->_entire_mapcount);
+	return 0;
+}
+
 static inline void hugetlb_add_file_rmap(struct folio *folio)
 {
 	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 541a8f38cfdc..d927f8b2893c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5402,8 +5402,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			 */
 			if (!folio_test_anon(pte_folio)) {
 				hugetlb_add_file_rmap(pte_folio);
-			} else if (page_try_dup_anon_rmap(&pte_folio->page,
-							  true, src_vma)) {
+			} else if (hugetlb_try_dup_anon_rmap(pte_folio, src_vma)) {
 				pte_t src_pte_old = entry;
 				struct folio *new_folio;
 
-- 
2.41.0

