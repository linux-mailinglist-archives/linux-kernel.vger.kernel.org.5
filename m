Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18E1803653
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235841AbjLDOWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345095AbjLDOV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:21:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6703AA0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701699721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CldTAIMRJWc6rWIvSdlg20t+rIQF+KSKFiNVs+JtPQE=;
        b=LUzB0TssQaPwMcBy7PHK/8CHv/UUKZrB39+csy3bIPQG/xnlJS7fKoa5L7C2yS29qFbNMC
        ND+B4PkGyDpE2TiCPGj48iG0cDc29ZicSQm9gCeFbmF0J4XkJ1Qn6ti5W+/VqtCZ/l1Uri
        TmKDbKgQxTagGpkG4ucvqUGSU17NCGA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-IrgCM3BPPOeYAKNDeamZgw-1; Mon,
 04 Dec 2023 09:21:56 -0500
X-MC-Unique: IrgCM3BPPOeYAKNDeamZgw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E5A73C0FCAD;
        Mon,  4 Dec 2023 14:21:56 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.195.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79B642026D4C;
        Mon,  4 Dec 2023 14:21:54 +0000 (UTC)
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
Subject: [PATCH RFC 04/39] mm/rmap: introduce and use hugetlb_try_dup_anon_rmap()
Date:   Mon,  4 Dec 2023 15:21:11 +0100
Message-ID: <20231204142146.91437-5-david@redhat.com>
In-Reply-To: <20231204142146.91437-1-david@redhat.com>
References: <20231204142146.91437-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h   | 12 +++++++++---
 include/linux/rmap.h | 15 +++++++++++++++
 mm/hugetlb.c         |  3 +--
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 418d26608ece7..24c1c7c5a99c0 100644
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
index 0a81e8420a961..8068c332e2ce5 100644
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
index 541a8f38cfdc7..d927f8b2893c0 100644
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

