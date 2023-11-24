Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BF87F7511
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345510AbjKXN3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbjKXN2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:28:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05012127
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700832459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cfr/GJlqpI78eOuvYmduIMFro8OwYW0A0XSs9rIUuNI=;
        b=FyleEjPmcwZ5n7ImKP66cqRkRswiA9IpSxNvsIieRWS/LEflfM1PWjI2g+dFYK5KMRl49O
        olhGwz5OI+B8DDvezMOJuBmkjIHYo7jUI/faxGNty1H6/rCwxBjMRq8vOeZPQeoqpoC8p6
        XOwh8XYVOs5lfH4YjqeeLspq7YPlY9c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-8WRNY9xWPlSFJQ6I882kqQ-1; Fri,
 24 Nov 2023 08:27:33 -0500
X-MC-Unique: 8WRNY9xWPlSFJQ6I882kqQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28DBB1C04357;
        Fri, 24 Nov 2023 13:27:33 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 953662166B2A;
        Fri, 24 Nov 2023 13:27:29 +0000 (UTC)
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
Subject: [PATCH WIP v1 17/20] mm/rmap_id: reduce atomic RMW operations when we are the exclusive writer
Date:   Fri, 24 Nov 2023 14:26:22 +0100
Message-ID: <20231124132626.235350-18-david@redhat.com>
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

We can reduce the number of atomic RMW operations when we are the
single exclusive writer -- the common case.

So instead of always requiring

(1) 2 atomic RMW operations for adjusting the atomic seqcount
(2) 1 atomic RMW operation for adjusting the total mapcount
(3) 1 to 6 atomic RMW operation for adjusting the rmap values

We can avoid (2) and (3) if we are the exclusive writer and limit it
to the 2 atomic RMW operations from (1).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 81 +++++++++++++++++++++++++++++++++-----------
 mm/rmap_id.c         | 52 ++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+), 19 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 0758dddc5528..538c23d3c0c9 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -291,23 +291,36 @@ static inline void __folio_undo_large_rmap(struct folio *folio)
 #endif
 }
 
-static inline void __folio_write_large_rmap_begin(struct folio *folio)
+static inline bool __folio_write_large_rmap_begin(struct folio *folio)
 {
+	bool exclusive;
+
 	VM_WARN_ON_FOLIO(!folio_test_large_rmappable(folio), folio);
 	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
-	raw_write_atomic_seqcount_begin(&folio->_rmap_atomic_seqcount,
-					false);
+
+	exclusive = raw_write_atomic_seqcount_begin(&folio->_rmap_atomic_seqcount,
+						    true);
+	if (likely(exclusive)) {
+		prefetchw(&folio->_rmap_val0);
+		if (unlikely(folio_order(folio) > RMAP_SUBID_4_MAX_ORDER))
+			prefetchw(&folio->_rmap_val4);
+	}
+	return exclusive;
 }
 
-static inline void __folio_write_large_rmap_end(struct folio *folio)
+static inline void __folio_write_large_rmap_end(struct folio *folio,
+		bool exclusive)
 {
-	raw_write_atomic_seqcount_end(&folio->_rmap_atomic_seqcount, false);
+	raw_write_atomic_seqcount_end(&folio->_rmap_atomic_seqcount,
+				      exclusive);
 }
 
 void __folio_set_large_rmap_val(struct folio *folio, int count,
 		struct mm_struct *mm);
 void __folio_add_large_rmap_val(struct folio *folio, int count,
 		struct mm_struct *mm);
+void __folio_add_large_rmap_val_exclusive(struct folio *folio, int count,
+		struct mm_struct *mm);
 bool __folio_has_large_matching_rmap_val(struct folio *folio, int count,
 		struct mm_struct *mm);
 #else
@@ -317,12 +330,14 @@ static inline void __folio_prep_large_rmap(struct folio *folio)
 static inline void __folio_undo_large_rmap(struct folio *folio)
 {
 }
-static inline void __folio_write_large_rmap_begin(struct folio *folio)
+static inline bool __folio_write_large_rmap_begin(struct folio *folio)
 {
 	VM_WARN_ON_FOLIO(!folio_test_large_rmappable(folio), folio);
 	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
+	return false;
 }
-static inline void __folio_write_large_rmap_end(struct folio *folio)
+static inline void __folio_write_large_rmap_end(struct folio *folio,
+		bool exclusive)
 {
 }
 static inline void __folio_set_large_rmap_val(struct folio *folio, int count,
@@ -333,6 +348,10 @@ static inline void __folio_add_large_rmap_val(struct folio *folio, int count,
 		struct mm_struct *mm)
 {
 }
+static inline void __folio_add_large_rmap_val_exclusive(struct folio *folio,
+		int count, struct mm_struct *mm)
+{
+}
 #endif /* CONFIG_RMAP_ID */
 
 static inline void folio_set_large_mapcount(struct folio *folio,
@@ -348,28 +367,52 @@ static inline void folio_set_large_mapcount(struct folio *folio,
 static inline void folio_inc_large_mapcount(struct folio *folio,
 		struct vm_area_struct *vma)
 {
-	__folio_write_large_rmap_begin(folio);
-	atomic_inc(&folio->_total_mapcount);
-	__folio_add_large_rmap_val(folio, 1, vma->vm_mm);
-	__folio_write_large_rmap_end(folio);
+	bool exclusive;
+
+	exclusive = __folio_write_large_rmap_begin(folio);
+	if (likely(exclusive)) {
+		atomic_set(&folio->_total_mapcount,
+			   atomic_read(&folio->_total_mapcount) + 1);
+		__folio_add_large_rmap_val_exclusive(folio, 1, vma->vm_mm);
+	} else {
+		atomic_inc(&folio->_total_mapcount);
+		__folio_add_large_rmap_val(folio, 1, vma->vm_mm);
+	}
+	__folio_write_large_rmap_end(folio, exclusive);
 }
 
 static inline void folio_add_large_mapcount(struct folio *folio,
 		int count, struct vm_area_struct *vma)
 {
-	__folio_write_large_rmap_begin(folio);
-	atomic_add(count, &folio->_total_mapcount);
-	__folio_add_large_rmap_val(folio, count, vma->vm_mm);
-	__folio_write_large_rmap_end(folio);
+	bool exclusive;
+
+	exclusive = __folio_write_large_rmap_begin(folio);
+	if (likely(exclusive)) {
+		atomic_set(&folio->_total_mapcount,
+			   atomic_read(&folio->_total_mapcount) + count);
+		__folio_add_large_rmap_val_exclusive(folio, count, vma->vm_mm);
+	} else {
+		atomic_add(count, &folio->_total_mapcount);
+		__folio_add_large_rmap_val(folio, count, vma->vm_mm);
+	}
+	__folio_write_large_rmap_end(folio, exclusive);
 }
 
 static inline void folio_dec_large_mapcount(struct folio *folio,
 		struct vm_area_struct *vma)
 {
-	__folio_write_large_rmap_begin(folio);
-	atomic_dec(&folio->_total_mapcount);
-	__folio_add_large_rmap_val(folio, -1, vma->vm_mm);
-	__folio_write_large_rmap_end(folio);
+	bool exclusive;
+
+	exclusive = __folio_write_large_rmap_begin(folio);
+	if (likely(exclusive)) {
+		atomic_set(&folio->_total_mapcount,
+			   atomic_read(&folio->_total_mapcount) - 1);
+		__folio_add_large_rmap_val_exclusive(folio, -1, vma->vm_mm);
+	} else {
+		atomic_dec(&folio->_total_mapcount);
+		__folio_add_large_rmap_val(folio, -1, vma->vm_mm);
+	}
+	__folio_write_large_rmap_end(folio, exclusive);
 }
 
 /* RMAP flags, currently only relevant for some anon rmap operations. */
diff --git a/mm/rmap_id.c b/mm/rmap_id.c
index 421d8d2b646c..5009c6e43965 100644
--- a/mm/rmap_id.c
+++ b/mm/rmap_id.c
@@ -379,6 +379,58 @@ void __folio_add_large_rmap_val(struct folio *folio, int count,
 	}
 }
 
+void __folio_add_large_rmap_val_exclusive(struct folio *folio, int count,
+		struct mm_struct *mm)
+{
+	const unsigned int order = folio_order(folio);
+
+	/*
+	 * Concurrent rmap value modifications are impossible. We don't care
+	 * about store tearing because readers will realize the concurrent
+	 * updates using the seqcount and simply retry. So adjust the bare
+	 * atomic counter instead.
+	 */
+	switch (order) {
+#if MAX_ORDER >= RMAP_SUBID_6_MIN_ORDER
+	case RMAP_SUBID_6_MIN_ORDER ... RMAP_SUBID_6_MAX_ORDER:
+		folio->_rmap_val0.counter += get_rmap_subid_6(mm, 0) * count;
+		folio->_rmap_val1.counter += get_rmap_subid_6(mm, 1) * count;
+		folio->_rmap_val2.counter += get_rmap_subid_6(mm, 2) * count;
+		folio->_rmap_val3.counter += get_rmap_subid_6(mm, 3) * count;
+		folio->_rmap_val4.counter += get_rmap_subid_6(mm, 4) * count;
+		folio->_rmap_val5.counter += get_rmap_subid_6(mm, 5) * count;
+		break;
+#endif
+#if MAX_ORDER >= RMAP_SUBID_5_MIN_ORDER
+	case RMAP_SUBID_5_MIN_ORDER ... RMAP_SUBID_5_MAX_ORDER:
+		folio->_rmap_val0.counter += get_rmap_subid_5(mm, 0) * count;
+		folio->_rmap_val1.counter += get_rmap_subid_5(mm, 1) * count;
+		folio->_rmap_val2.counter += get_rmap_subid_5(mm, 2) * count;
+		folio->_rmap_val3.counter += get_rmap_subid_5(mm, 3) * count;
+		folio->_rmap_val4.counter += get_rmap_subid_5(mm, 4) * count;
+		break;
+#endif
+	case RMAP_SUBID_4_MIN_ORDER ... RMAP_SUBID_4_MAX_ORDER:
+		folio->_rmap_val0.counter += get_rmap_subid_4(mm, 0) * count;
+		folio->_rmap_val1.counter += get_rmap_subid_4(mm, 1) * count;
+		folio->_rmap_val2.counter += get_rmap_subid_4(mm, 2) * count;
+		folio->_rmap_val3.counter += get_rmap_subid_4(mm, 3) * count;
+		break;
+	case RMAP_SUBID_3_MIN_ORDER ... RMAP_SUBID_3_MAX_ORDER:
+		folio->_rmap_val0.counter += get_rmap_subid_3(mm, 0) * count;
+		folio->_rmap_val1.counter += get_rmap_subid_3(mm, 1) * count;
+		folio->_rmap_val2.counter += get_rmap_subid_3(mm, 2) * count;
+		break;
+	case RMAP_SUBID_2_MIN_ORDER ... RMAP_SUBID_2_MAX_ORDER:
+		folio->_rmap_val0.counter += get_rmap_subid_2(mm, 0) * count;
+		folio->_rmap_val1.counter += get_rmap_subid_2(mm, 1) * count;
+		break;
+	default:
+		folio->_rmap_val0.counter += get_rmap_subid_1(mm);
+		break;
+	}
+}
+
 bool __folio_has_large_matching_rmap_val(struct folio *folio, int count,
 		 struct mm_struct *mm)
 {
-- 
2.41.0

