Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1297F74FE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjKXN2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345445AbjKXN1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:27:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCD01717
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700832432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tnmd+tFa3nPIVK41hUx6D+f5FKMgV+UNk16uwK5iEbI=;
        b=W8rcl+FEAblkz91paxNS587GZI3bA4FlrwNi5tf3HGti1990LJVaXQml2IsAVRnpPStdlU
        JUdXdiW4G76G/hc0kMxACrlKbdzh705lBQG2NyajZ3MXnIqthc2QD+Wy5JYScAgby4mwsK
        FrgDozJzPtD/GsmFLjltgBXylILvgGY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-n03FLBEbPOa7jDqGNMEHgQ-1; Fri, 24 Nov 2023 08:27:11 -0500
X-MC-Unique: n03FLBEbPOa7jDqGNMEHgQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EACB085A58C;
        Fri, 24 Nov 2023 13:27:10 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29FE22166B2A;
        Fri, 24 Nov 2023 13:27:07 +0000 (UTC)
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
Subject: [PATCH WIP v1 11/20] mm/rmap_id: support for 1, 2 and 3 values by manual calculation
Date:   Fri, 24 Nov 2023 14:26:16 +0100
Message-ID: <20231124132626.235350-12-david@redhat.com>
In-Reply-To: <20231124132626.235350-1-david@redhat.com>
References: <20231124132626.235350-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For smaller folios, we can use less rmap values:
* <= order-2: 1x 64bit value
* <= order-5: 2x 64bit values
* <= order-9: 3x 64bit values

We end up with a lot of subids, so we cannot really use lookup tables.
Pre-calculate the subids per MM.

For order-9 we could think about having a lookup table with 128bit
entries. Further, we could calcualte them only when really required.

With 2 MiB THP this now implies only 3 instead of 4 values.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm_types.h |  3 ++
 include/linux/rmap.h     | 58 ++++++++++++++++++++++++++++-
 kernel/fork.c            |  6 +++
 mm/rmap_id.c             | 79 +++++++++++++++++++++++++++++++++++++---
 4 files changed, 139 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 75305c57ef64..0ca5004e8f4a 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1032,6 +1032,9 @@ struct mm_struct {
 
 #ifdef CONFIG_RMAP_ID
 		int mm_rmap_id;
+		unsigned long mm_rmap_subid_1;
+		unsigned long mm_rmap_subid_2[2];
+		unsigned long mm_rmap_subid_3[3];
 #endif /* CONFIG_RMAP_ID */
 	} __randomize_layout;
 
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index a73e146d82d1..39aeab457f4a 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -180,12 +180,54 @@ struct anon_vma *folio_get_anon_vma(struct folio *folio);
 void free_rmap_id(int id);
 int alloc_rmap_id(void);
 
+#define RMAP_SUBID_1_MAX_ORDER		2
+#define RMAP_SUBID_2_MIN_ORDER		3
+#define RMAP_SUBID_2_MAX_ORDER		5
+#define RMAP_SUBID_3_MIN_ORDER		6
+#define RMAP_SUBID_3_MAX_ORDER		9
+#define RMAP_SUBID_4_MIN_ORDER		10
 #define RMAP_SUBID_4_MAX_ORDER		10
 #define RMAP_SUBID_5_MIN_ORDER		11
 #define RMAP_SUBID_5_MAX_ORDER		12
 #define RMAP_SUBID_6_MIN_ORDER		13
 #define RMAP_SUBID_6_MAX_ORDER		15
 
+static inline unsigned long calc_rmap_subid(unsigned int n, unsigned int i)
+{
+	unsigned long nr = 0, mult = 1;
+
+	while (i) {
+		if (i & 1)
+			nr += mult;
+		mult *= (n + 1);
+		i >>= 1;
+	}
+	return nr;
+}
+
+static inline unsigned long calc_rmap_subid_1(int rmap_id)
+{
+	VM_WARN_ON_ONCE(rmap_id < RMAP_ID_MIN || rmap_id > RMAP_ID_MAX);
+
+	return calc_rmap_subid(1u << RMAP_SUBID_1_MAX_ORDER, rmap_id);
+}
+
+static inline unsigned long calc_rmap_subid_2(int rmap_id, int nr)
+{
+	VM_WARN_ON_ONCE(rmap_id < RMAP_ID_MIN || rmap_id > RMAP_ID_MAX || nr > 1);
+
+	return calc_rmap_subid(1u << RMAP_SUBID_2_MAX_ORDER,
+			       (rmap_id >> (nr * 12)) & 0xfff);
+}
+
+static inline unsigned long calc_rmap_subid_3(int rmap_id, int nr)
+{
+	VM_WARN_ON_ONCE(rmap_id < RMAP_ID_MIN || rmap_id > RMAP_ID_MAX || nr > 2);
+
+	return calc_rmap_subid(1u << RMAP_SUBID_3_MAX_ORDER,
+			       (rmap_id >> (nr * 8)) & 0xff);
+}
+
 static inline void __folio_prep_large_rmap(struct folio *folio)
 {
 	const unsigned int order = folio_order(folio);
@@ -202,10 +244,16 @@ static inline void __folio_prep_large_rmap(struct folio *folio)
 		atomic_long_set(&folio->_rmap_val4, 0);
 		fallthrough;
 #endif
-	default:
+	case RMAP_SUBID_4_MIN_ORDER ... RMAP_SUBID_4_MAX_ORDER:
 		atomic_long_set(&folio->_rmap_val3, 0);
+		fallthrough;
+	case RMAP_SUBID_3_MIN_ORDER ... RMAP_SUBID_3_MAX_ORDER:
 		atomic_long_set(&folio->_rmap_val2, 0);
+		fallthrough;
+	case RMAP_SUBID_2_MIN_ORDER ... RMAP_SUBID_2_MAX_ORDER:
 		atomic_long_set(&folio->_rmap_val1, 0);
+		fallthrough;
+	default:
 		atomic_long_set(&folio->_rmap_val0, 0);
 		break;
 	}
@@ -227,10 +275,16 @@ static inline void __folio_undo_large_rmap(struct folio *folio)
 		VM_WARN_ON_ONCE(atomic_long_read(&folio->_rmap_val4));
 		fallthrough;
 #endif
-	default:
+	case RMAP_SUBID_4_MIN_ORDER ... RMAP_SUBID_4_MAX_ORDER:
 		VM_WARN_ON_ONCE(atomic_long_read(&folio->_rmap_val3));
+		fallthrough;
+	case RMAP_SUBID_3_MIN_ORDER ... RMAP_SUBID_3_MAX_ORDER:
 		VM_WARN_ON_ONCE(atomic_long_read(&folio->_rmap_val2));
+		fallthrough;
+	case RMAP_SUBID_2_MIN_ORDER ... RMAP_SUBID_2_MAX_ORDER:
 		VM_WARN_ON_ONCE(atomic_long_read(&folio->_rmap_val1));
+		fallthrough;
+	default:
 		VM_WARN_ON_ONCE(atomic_long_read(&folio->_rmap_val0));
 		break;
 	}
diff --git a/kernel/fork.c b/kernel/fork.c
index 773c93613ca2..1d2f6248c83e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -822,6 +822,12 @@ static inline int mm_alloc_rmap_id(struct mm_struct *mm)
 	if (id < 0)
 		return id;
 	mm->mm_rmap_id = id;
+	mm->mm_rmap_subid_1 = calc_rmap_subid_1(id);
+	mm->mm_rmap_subid_2[0] = calc_rmap_subid_2(id, 0);
+	mm->mm_rmap_subid_2[1] = calc_rmap_subid_2(id, 1);
+	mm->mm_rmap_subid_3[0] = calc_rmap_subid_3(id, 0);
+	mm->mm_rmap_subid_3[1] = calc_rmap_subid_3(id, 1);
+	mm->mm_rmap_subid_3[2] = calc_rmap_subid_3(id, 2);
 	return 0;
 }
 
diff --git a/mm/rmap_id.c b/mm/rmap_id.c
index 85a61c830f19..6c3187547741 100644
--- a/mm/rmap_id.c
+++ b/mm/rmap_id.c
@@ -87,6 +87,39 @@ static DEFINE_IDA(rmap_ida);
  *       involved page tables are locked and stop any page table walkers.
  */
 
+/*
+ * With 4 (order-2) possible exclusive mappings per folio, we can have
+ * 16777216 = 16M sub-IDs per 64bit value.
+ */
+static unsigned long get_rmap_subid_1(struct mm_struct *mm)
+{
+	return mm->mm_rmap_subid_1;
+}
+
+/*
+ * With 32 (order-5) possible exclusive mappings per folio, we can have
+ * 4096 sub-IDs per 64bit value.
+ *
+ * With 2 such 64bit values, we can support 4096^2 == 16M IDs.
+ */
+static unsigned long get_rmap_subid_2(struct mm_struct *mm, int nr)
+{
+	VM_WARN_ON_ONCE(nr > 1);
+	return mm->mm_rmap_subid_2[nr];
+}
+
+/*
+ * With 512 (order-9) possible exclusive mappings per folio, we can have
+ * 128 sub-IDs per 64bit value.
+ *
+ * With 3 such 64bit values, we can support 128^3 == 16M IDs.
+ */
+static unsigned long get_rmap_subid_3(struct mm_struct *mm, int nr)
+{
+	VM_WARN_ON_ONCE(nr > 2);
+	return mm->mm_rmap_subid_3[nr];
+}
+
 /*
  * With 1024 (order-10) possible exclusive mappings per folio, we can have 64
  * sub-IDs per 64bit value.
@@ -279,12 +312,24 @@ void __folio_set_large_rmap_val(struct folio *folio, int count,
 		atomic_long_set(&folio->_rmap_val4, get_rmap_subid_5(mm, 4) * count);
 		break;
 #endif
-	default:
+	case RMAP_SUBID_4_MIN_ORDER ... RMAP_SUBID_4_MAX_ORDER:
 		atomic_long_set(&folio->_rmap_val0, get_rmap_subid_4(mm, 0) * count);
 		atomic_long_set(&folio->_rmap_val1, get_rmap_subid_4(mm, 1) * count);
 		atomic_long_set(&folio->_rmap_val2, get_rmap_subid_4(mm, 2) * count);
 		atomic_long_set(&folio->_rmap_val3, get_rmap_subid_4(mm, 3) * count);
 		break;
+	case RMAP_SUBID_3_MIN_ORDER ... RMAP_SUBID_3_MAX_ORDER:
+		atomic_long_set(&folio->_rmap_val0, get_rmap_subid_3(mm, 0) * count);
+		atomic_long_set(&folio->_rmap_val1, get_rmap_subid_3(mm, 1) * count);
+		atomic_long_set(&folio->_rmap_val2, get_rmap_subid_3(mm, 2) * count);
+		break;
+	case RMAP_SUBID_2_MIN_ORDER ... RMAP_SUBID_2_MAX_ORDER:
+		atomic_long_set(&folio->_rmap_val0, get_rmap_subid_2(mm, 0) * count);
+		atomic_long_set(&folio->_rmap_val1, get_rmap_subid_2(mm, 1) * count);
+		break;
+	default:
+		atomic_long_set(&folio->_rmap_val0, get_rmap_subid_1(mm) * count);
+		break;
 	}
 }
 
@@ -313,12 +358,24 @@ void __folio_add_large_rmap_val(struct folio *folio, int count,
 		atomic_long_add(get_rmap_subid_5(mm, 4) * count, &folio->_rmap_val4);
 		break;
 #endif
-	default:
+	case RMAP_SUBID_4_MIN_ORDER ... RMAP_SUBID_4_MAX_ORDER:
 		atomic_long_add(get_rmap_subid_4(mm, 0) * count, &folio->_rmap_val0);
 		atomic_long_add(get_rmap_subid_4(mm, 1) * count, &folio->_rmap_val1);
 		atomic_long_add(get_rmap_subid_4(mm, 2) * count, &folio->_rmap_val2);
 		atomic_long_add(get_rmap_subid_4(mm, 3) * count, &folio->_rmap_val3);
 		break;
+	case RMAP_SUBID_3_MIN_ORDER ... RMAP_SUBID_3_MAX_ORDER:
+		atomic_long_add(get_rmap_subid_3(mm, 0) * count, &folio->_rmap_val0);
+		atomic_long_add(get_rmap_subid_3(mm, 1) * count, &folio->_rmap_val1);
+		atomic_long_add(get_rmap_subid_3(mm, 2) * count, &folio->_rmap_val2);
+		break;
+	case RMAP_SUBID_2_MIN_ORDER ... RMAP_SUBID_2_MAX_ORDER:
+		atomic_long_add(get_rmap_subid_2(mm, 0) * count, &folio->_rmap_val0);
+		atomic_long_add(get_rmap_subid_2(mm, 1) * count, &folio->_rmap_val1);
+		break;
+	default:
+		atomic_long_add(get_rmap_subid_1(mm) * count, &folio->_rmap_val0);
+		break;
 	}
 }
 
@@ -330,7 +387,7 @@ bool __folio_has_large_matching_rmap_val(struct folio *folio, int count,
 
 	switch (order) {
 #if MAX_ORDER >= RMAP_SUBID_6_MIN_ORDER
-	case RMAP_SUBID_6_MIN_ORDER .. RMAP_SUBID_6_MAX_ORDER:
+	case RMAP_SUBID_6_MIN_ORDER ... RMAP_SUBID_6_MAX_ORDER:
 		diff |= atomic_long_read(&folio->_rmap_val0) ^ (get_rmap_subid_6(mm, 0) * count);
 		diff |= atomic_long_read(&folio->_rmap_val1) ^ (get_rmap_subid_6(mm, 1) * count);
 		diff |= atomic_long_read(&folio->_rmap_val2) ^ (get_rmap_subid_6(mm, 2) * count);
@@ -340,7 +397,7 @@ bool __folio_has_large_matching_rmap_val(struct folio *folio, int count,
 		break;
 #endif
 #if MAX_ORDER >= RMAP_SUBID_5_MIN_ORDER
-	case RMAP_SUBID_5_MIN_ORDER .. RMAP_SUBID_5_MAX_ORDER:
+	case RMAP_SUBID_5_MIN_ORDER ... RMAP_SUBID_5_MAX_ORDER:
 		diff |= atomic_long_read(&folio->_rmap_val0) ^ (get_rmap_subid_5(mm, 0) * count);
 		diff |= atomic_long_read(&folio->_rmap_val1) ^ (get_rmap_subid_5(mm, 1) * count);
 		diff |= atomic_long_read(&folio->_rmap_val2) ^ (get_rmap_subid_5(mm, 2) * count);
@@ -348,12 +405,24 @@ bool __folio_has_large_matching_rmap_val(struct folio *folio, int count,
 		diff |= atomic_long_read(&folio->_rmap_val4) ^ (get_rmap_subid_5(mm, 4) * count);
 		break;
 #endif
-	default:
+	case RMAP_SUBID_4_MIN_ORDER ... RMAP_SUBID_4_MAX_ORDER:
 		diff |= atomic_long_read(&folio->_rmap_val0) ^ (get_rmap_subid_4(mm, 0) * count);
 		diff |= atomic_long_read(&folio->_rmap_val1) ^ (get_rmap_subid_4(mm, 1) * count);
 		diff |= atomic_long_read(&folio->_rmap_val2) ^ (get_rmap_subid_4(mm, 2) * count);
 		diff |= atomic_long_read(&folio->_rmap_val3) ^ (get_rmap_subid_4(mm, 3) * count);
 		break;
+	case RMAP_SUBID_3_MIN_ORDER ... RMAP_SUBID_3_MAX_ORDER:
+		diff |= atomic_long_read(&folio->_rmap_val0) ^ (get_rmap_subid_3(mm, 0) * count);
+		diff |= atomic_long_read(&folio->_rmap_val1) ^ (get_rmap_subid_3(mm, 1) * count);
+		diff |= atomic_long_read(&folio->_rmap_val2) ^ (get_rmap_subid_3(mm, 2) * count);
+		break;
+	case RMAP_SUBID_2_MIN_ORDER ... RMAP_SUBID_2_MAX_ORDER:
+		diff |= atomic_long_read(&folio->_rmap_val0) ^ (get_rmap_subid_2(mm, 0) * count);
+		diff |= atomic_long_read(&folio->_rmap_val1) ^ (get_rmap_subid_2(mm, 1) * count);
+		break;
+	default:
+		diff |= atomic_long_read(&folio->_rmap_val0) ^ (get_rmap_subid_1(mm) * count);
+		break;
 	}
 	return !diff;
 }
-- 
2.41.0

