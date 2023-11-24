Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2777F7507
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345465AbjKXN2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjKXN2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:28:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA4F2105
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700832451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8wkdTzr4ovr6JqvWUuBFMPrmTwPV2fAdlmREPfnLqjk=;
        b=P3OryhCwrrW3/y4KdyQKeVXl4ZsGXGCqICZDVyfWOr3qPxyr9OAPSTyhSzJPwo15ndIdhf
        M9IMRawBLym9dumKCK8uEAQfKEZt9+p2UK+VeGksUrqDmGNIoljzhaRSXa/a2ERoC8pkii
        QVZwgR8zn6qn35NAhZmGrVTX0kFoxO4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-Mzyg-U9HMR2q8VnSaYE9mw-1; Fri, 24 Nov 2023 08:27:23 -0500
X-MC-Unique: Mzyg-U9HMR2q8VnSaYE9mw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F79C85A58C;
        Fri, 24 Nov 2023 13:27:22 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E251F2166B2B;
        Fri, 24 Nov 2023 13:27:18 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH WIP v1 14/20] mm/huge_memory: avoid folio_refcount() < folio_mapcount() in __split_huge_pmd_locked()
Date:   Fri, 24 Nov 2023 14:26:19 +0100
Message-ID: <20231124132626.235350-15-david@redhat.com>
In-Reply-To: <20231124132626.235350-1-david@redhat.com>
References: <20231124132626.235350-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there is a short period in time where the refcount is smaller
than the mapcount. Let's just make sure we obey the rules of refcount
vs. mapcount: increment the refcount before incrementing the mapcount
and decrement the refcount after decrementing the mapcount.

While this could make code like can_split_folio() fail to detect other
folio references, such code is (currently) racy already and this change
shouldn't actually be considered a real fix but rather an improvement/
cleanup.

The refcount vs. mapcount changes are now well balanced in the code, with
the cost of one additional refcount change, which really shouldn't matter
here that much -- we're usually touching >= 512 subpage mapcounts and
much more after all.

Found while playing with some sanity checks to detect such cases, which
we might add at some later point.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f47971d1afbf..9639b4edc8a5 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2230,7 +2230,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		if (!freeze) {
 			rmap_t rmap_flags = RMAP_NONE;
 
-			folio_ref_add(folio, HPAGE_PMD_NR - 1);
+			folio_ref_add(folio, HPAGE_PMD_NR);
 			if (anon_exclusive)
 				rmap_flags = RMAP_EXCLUSIVE;
 			folio_add_anon_rmap_range(folio, page, HPAGE_PMD_NR,
@@ -2294,10 +2294,10 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	}
 	pte_unmap(pte - 1);
 
-	if (!pmd_migration)
+	if (!pmd_migration) {
 		page_remove_rmap(page, vma, true);
-	if (freeze)
 		put_page(page);
+	}
 
 	smp_wmb(); /* make pte visible before pmd */
 	pmd_populate(mm, pmd, pgtable);
-- 
2.41.0

