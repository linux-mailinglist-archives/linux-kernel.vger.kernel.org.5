Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9391A80D029
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344475AbjLKP5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344477AbjLKP5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:57:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CFB10B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702310235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NEVRdWv5MmhzBcZ7w5tNkRp7uojKujUjmq26NniU0lw=;
        b=bEMFaQXfk0hztuuzstaaJvONUWUpQgUpBaijog4k4rH4OtdQTi4AMKwa+xzwuCEKreJVvR
        1FyCLgS5Rz85I1SDOQ+0n/YDbXe3HXnngsZ2YGDc+DEJCJF80MUttMVC5x/JYXOECsUwD5
        q+VmeCIylVb/jts0COGyhPB3cCUL4M0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-qBz2N7eWPmuxhrmCuHZ-Dw-1; Mon,
 11 Dec 2023 10:57:12 -0500
X-MC-Unique: qBz2N7eWPmuxhrmCuHZ-Dw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3226A28078D6;
        Mon, 11 Dec 2023 15:57:10 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 071301121306;
        Mon, 11 Dec 2023 15:57:07 +0000 (UTC)
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
Subject: [PATCH v1 05/39] mm/rmap: introduce and use hugetlb_try_share_anon_rmap()
Date:   Mon, 11 Dec 2023 16:56:18 +0100
Message-ID: <20231211155652.131054-6-david@redhat.com>
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

Note that try_to_unmap_one() does not need care. Easy to spot because
among all that nasty hugetlb special-casing in that function, we're not
using set_huge_pte_at() on the anon path -- well, and that code assumes
that we would want to swapout.

Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 23 +++++++++++++++++++++++
 mm/rmap.c            | 15 ++++++++++-----
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index ca42b3db5688..4c0650e9f6db 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -228,6 +228,29 @@ static inline int hugetlb_try_dup_anon_rmap(struct folio *folio,
 	return 0;
 }
 
+/* See page_try_share_anon_rmap() */
+static inline int hugetlb_try_share_anon_rmap(struct folio *folio)
+{
+	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
+	VM_WARN_ON_FOLIO(!PageAnonExclusive(&folio->page), folio);
+
+	/* Paired with the memory barrier in try_grab_folio(). */
+	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP))
+		smp_mb();
+
+	if (unlikely(folio_maybe_dma_pinned(folio)))
+		return -EBUSY;
+	ClearPageAnonExclusive(&folio->page);
+
+	/*
+	 * This is conceptually a smp_wmb() paired with the smp_rmb() in
+	 * gup_must_unshare().
+	 */
+	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP))
+		smp_mb__after_atomic();
+	return 0;
+}
+
 static inline void hugetlb_add_file_rmap(struct folio *folio)
 {
 	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
diff --git a/mm/rmap.c b/mm/rmap.c
index 4e60c1f38eaa..e210ac1b73de 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2147,13 +2147,18 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 				       !anon_exclusive, subpage);
 
 			/* See page_try_share_anon_rmap(): clear PTE first. */
-			if (anon_exclusive &&
-			    page_try_share_anon_rmap(subpage)) {
-				if (folio_test_hugetlb(folio))
+			if (folio_test_hugetlb(folio)) {
+				if (anon_exclusive &&
+				    hugetlb_try_share_anon_rmap(folio)) {
 					set_huge_pte_at(mm, address, pvmw.pte,
 							pteval, hsz);
-				else
-					set_pte_at(mm, address, pvmw.pte, pteval);
+					ret = false;
+					page_vma_mapped_walk_done(&pvmw);
+					break;
+				}
+			} else if (anon_exclusive &&
+				   page_try_share_anon_rmap(subpage)) {
+				set_pte_at(mm, address, pvmw.pte, pteval);
 				ret = false;
 				page_vma_mapped_walk_done(&pvmw);
 				break;
-- 
2.43.0

