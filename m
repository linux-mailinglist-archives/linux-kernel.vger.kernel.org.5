Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CDF80D03A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344465AbjLKP6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344529AbjLKP5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:57:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5378A10A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702310258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gWnH4eIM4y9lGkdEQ6xWZD6LXOR6bYxTBmelfOqDsXI=;
        b=JU+jXHi53Tz/FWXnxM4ejB5AzKvOp2hzWMbwsggpnvOwEn3S1VeDOaCIr24QRCkBnhAolz
        FDjEY94RfmiaS0exQoEBu9Ly6/6lf7yAkyOk4UgbRwEzVovgRSyG1LsyYferaPszjH93CD
        xZOqZhhi9FqnBXvVkxGrlJPkJa4ahuc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-Z3gSjZ9jPqqQxyKFZIs1PA-1; Mon, 11 Dec 2023 10:57:35 -0500
X-MC-Unique: Z3gSjZ9jPqqQxyKFZIs1PA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 742D1185A788;
        Mon, 11 Dec 2023 15:57:34 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF3641121306;
        Mon, 11 Dec 2023 15:57:31 +0000 (UTC)
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
Subject: [PATCH v1 15/39] mm/huge_memory: batch rmap operations in __split_huge_pmd_locked()
Date:   Mon, 11 Dec 2023 16:56:28 +0100
Message-ID: <20231211155652.131054-16-david@redhat.com>
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

Let's use folio_add_anon_rmap_ptes(), batching the rmap operations.

While at it, use more folio operations (but only in the code branch we're
touching), use VM_WARN_ON_FOLIO(), and pass RMAP_EXCLUSIVE instead of
manually setting PageAnonExclusive.

We should never see non-anon pages on that branch: otherwise, the
existing page_add_anon_rmap() call would have been flawed already.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1f5634b2f374..82ad68fe0d12 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2398,6 +2398,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long haddr, bool freeze)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	struct folio *folio;
 	struct page *page;
 	pgtable_t pgtable;
 	pmd_t old_pmd, _pmd;
@@ -2493,16 +2494,18 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		uffd_wp = pmd_swp_uffd_wp(old_pmd);
 	} else {
 		page = pmd_page(old_pmd);
+		folio = page_folio(page);
 		if (pmd_dirty(old_pmd)) {
 			dirty = true;
-			SetPageDirty(page);
+			folio_set_dirty(folio);
 		}
 		write = pmd_write(old_pmd);
 		young = pmd_young(old_pmd);
 		soft_dirty = pmd_soft_dirty(old_pmd);
 		uffd_wp = pmd_uffd_wp(old_pmd);
 
-		VM_BUG_ON_PAGE(!page_count(page), page);
+		VM_WARN_ON_FOLIO(!folio_ref_count(folio), folio);
+		VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
 
 		/*
 		 * Without "freeze", we'll simply split the PMD, propagating the
@@ -2519,11 +2522,18 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		 *
 		 * See page_try_share_anon_rmap(): invalidate PMD first.
 		 */
-		anon_exclusive = PageAnon(page) && PageAnonExclusive(page);
+		anon_exclusive = PageAnonExclusive(page);
 		if (freeze && anon_exclusive && page_try_share_anon_rmap(page))
 			freeze = false;
-		if (!freeze)
-			page_ref_add(page, HPAGE_PMD_NR - 1);
+		if (!freeze) {
+			rmap_t rmap_flags = RMAP_NONE;
+
+			folio_ref_add(folio, HPAGE_PMD_NR - 1);
+			if (anon_exclusive)
+				rmap_flags |= RMAP_EXCLUSIVE;
+			folio_add_anon_rmap_ptes(folio, page, HPAGE_PMD_NR,
+						 vma, haddr, rmap_flags);
+		}
 	}
 
 	/*
@@ -2566,8 +2576,6 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			entry = mk_pte(page + i, READ_ONCE(vma->vm_page_prot));
 			if (write)
 				entry = pte_mkwrite(entry, vma);
-			if (anon_exclusive)
-				SetPageAnonExclusive(page + i);
 			if (!young)
 				entry = pte_mkold(entry);
 			/* NOTE: this may set soft-dirty too on some archs */
@@ -2577,7 +2585,6 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 				entry = pte_mksoft_dirty(entry);
 			if (uffd_wp)
 				entry = pte_mkuffd_wp(entry);
-			page_add_anon_rmap(page + i, vma, addr, RMAP_NONE);
 		}
 		VM_BUG_ON(!pte_none(ptep_get(pte)));
 		set_pte_at(mm, addr, pte, entry);
-- 
2.43.0

