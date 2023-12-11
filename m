Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25B780D031
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344533AbjLKP5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344469AbjLKP5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:57:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187ACB4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702310246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U+sz0aAg3eDeTtLeKtB884YEpFTON3wSVy4B1/EJUUg=;
        b=Y4WJL66I/uvnjCdrUU8U2eVG7KPFI6qkvGDWid4xDaZEmR4r3dViBotRMkWD3imFLdlyGN
        icMzBoqhqs8ppNX8x2skhE3l87nxwBi8xxLAappdQ3doQX56Y9i7vGb1fJP4/W0btFHFl8
        a6FhYHc+4h3Ywi61YiDaZ88uQ1umM8E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-x5EZWnqnPL-8WFVv6DDwvA-1; Mon, 11 Dec 2023 10:57:23 -0500
X-MC-Unique: x5EZWnqnPL-8WFVv6DDwvA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9899D101E156;
        Mon, 11 Dec 2023 15:57:07 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EAAC51121306;
        Mon, 11 Dec 2023 15:57:04 +0000 (UTC)
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
Subject: [PATCH v1 04/39] mm/rmap: introduce and use hugetlb_try_dup_anon_rmap()
Date:   Mon, 11 Dec 2023 16:56:17 +0100
Message-ID: <20231211155652.131054-5-david@redhat.com>
In-Reply-To: <20231211155652.131054-1-david@redhat.com>
References: <20231211155652.131054-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
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

hugetlb rmap handling differs quite a lot from "ordinary" rmap code.
For example, hugetlb currently only supports entire mappings, and treats
any mapping as mapped using a single "logical PTE". Let's move it out
of the way so we can overhaul our "ordinary" rmap.
implementation/interface.

So let's introduce and use hugetlb_try_dup_anon_rmap() to make all
hugetlb handling use dedicated hugetlb_* rmap functions.

Note that is_device_private_page() does not apply to hugetlb.

Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h   | 12 +++++++++---
 include/linux/rmap.h | 15 +++++++++++++++
 mm/hugetlb.c         |  3 +--
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b72bf25a45cf..ae547b62f325 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1964,15 +1964,21 @@ static inline bool page_maybe_dma_pinned(struct page *page)
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
index 91178d1aa028..ca42b3db5688 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -213,6 +213,21 @@ void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
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
index 57e898187931..378e460a6ab4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5409,8 +5409,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			 */
 			if (!folio_test_anon(pte_folio)) {
 				hugetlb_add_file_rmap(pte_folio);
-			} else if (page_try_dup_anon_rmap(&pte_folio->page,
-							  true, src_vma)) {
+			} else if (hugetlb_try_dup_anon_rmap(pte_folio, src_vma)) {
 				pte_t src_pte_old = entry;
 				struct folio *new_folio;
 
-- 
2.43.0

