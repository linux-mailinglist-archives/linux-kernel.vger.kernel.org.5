Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACEE7F74F1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345660AbjKXN1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbjKXN1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:27:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A5019AE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700832420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a5yfSJmvw+walwOxM5XR2U+SrOM6iOWFmuLu46mrnEU=;
        b=blneaO6Von/7If1kkxAo+LYa5rv//QxgVYhvipio1uf59ixRdPSzdR41gUbs9hq+vqvk5M
        2ZAC6xSD6EvmYcR0DOSBpfzjKvkeJ7koYcTBinUVIQCNVd6HWHqwLzo4XGT6PvnNzVdQlA
        45zF0teKtWOwMSDeBPtLcGhN7cMj5U8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-ORZ29QTLNFSiOT-xdaI3QA-1; Fri,
 24 Nov 2023 08:26:57 -0500
X-MC-Unique: ORZ29QTLNFSiOT-xdaI3QA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD5003C108C7;
        Fri, 24 Nov 2023 13:26:56 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09AB92166B2A;
        Fri, 24 Nov 2023 13:26:53 +0000 (UTC)
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
Subject: [PATCH WIP v1 07/20] mm/rmap_id: track if one ore multiple MMs map a partially-mappable folio
Date:   Fri, 24 Nov 2023 14:26:12 +0100
Message-ID: <20231124132626.235350-8-david@redhat.com>
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

In contrast to small folios and hugetlb folios, for a partially-mappable
folio (i.e., THP), the total mapcount is often not expressive to identify
whether such a folio is "mapped shared" or "mapped exclusively". For small
folios and hugetlb folios that are always entirely mapped, the single
mapcount is traditionally used for that purpose: is it 1? Then the folio
is currently mapped exclusively; is it bigger than 1? Then it's mapped
at least twice, and, therefore, considered "mapped shared".

For a partially-mappable folio, each individual PTE/PMD/... mapping
requires exactly one folio reference and one folio mapcount;
folio_mapcount() > 1 does not imply that the folio is "mapped shared".

While there are some obvious cases when we can conclude that
partially-mappable folios are "mapped shared" -- see
folio_mapped_shared() -- but it is currently not always possible to
precisely tell whether a folio is "mapped exclusively".

For implementing a precise variant of folio_mapped_shared() and for
COW-reuse support of PTE-mapped anon THP, we need an efficient and precise
way to identify "mapped shared" vs. "mapped exclusively".

So how could we track if more than one MM is currently mapping a folio in
its page tables? Having a list of MMs per folio, or even a counter for
each MM for each folio is clearly not feasible.

... but what if we could play some fun math games to perform this
tracking while requiring a handful of counters per folio, the exact number
of counters depending on the size of the folio?

1. !!! Experimental Feature !!!
===============================

We'll only support CONFIG_64BIT and !CONFIG_PREEMPT_RT (implied by THP
support) for now. As we currently never get partially-mappable folios
without CONFIG_TRANSPARENT_HUGEPAGE, let's limit to that to avoid
unnecessary rmap ID allocations for setups without THP.

32bit support might be possible if there is demand, limiting it to 64k
rmap IDs and reasonably sized folio sizes (e.g., <= order-15).
Similarly, RT might be possible if there is ever real demand for it.

The feature will be experimental initially, and, therefore, disabled as
default.

Once the involved math is considered solid, the implementation saw extended
testing, and the performance implications are clear and have either been
optimized (e.g., rmap batching) or mitigated (e.g., do we really have to
perform this tracking for folios that are always assumed shared, like
folios mapping executables or shared libraries? Is some hardware
problematic?), we can consider always enabling it as default.

2. Per-mm rmap IDs
==================

We'll have to assign each MM an rmap ID that is smaller than
16*1024*1024 on 64bit. Note that these are significantly more than the
maximum number of processes we can possibly have in the system. There isn't
really a difference between supporting 16M IDs and 2M/4M IDs.

Due to the ID size limitation, we cannot use the MM pointer value and need
a separate ID allocator. Maybe, we want to cache some rmap IDs per CPU?
Maybe we want to improve the allocation path? We can add such improvements
when deemed necessary.

In the distant future, we might want to allocate rmap IDs for selected
VMAs: for example, imagine a systemcall that does something like fork
(COW-sharing of pages) within a process for a range of anonymous memory,
ending up with a new VMA that wants a separate rmap ID. For now, per-MM
is simple and sufficient.

3. Tracking Overview
====================

We derive a sequence of special sub-IDs from our MM rmap ID.

Any time we map/unmap a part (e.g., PTE, PMD) of a partially-mappable
folio to/from a MM, we:

 (1) Adjust (increment/decrement) the mapcount of the folio
 (2) Adjust (add/remove) the folio rmap values using the MM sub-IDs

So the rmap values are always linked to the folio mapcount. Consequently,
we know that a single rmap value in the folio is the sum of exactly
 #folio_mapcount() rmap sub-IDs. To identify whether a single MM is
responsible for all folio_mapcount() mappings of a folio
("mapped exclusively") or whether other MMs are involved ("mapped shared"),
we perform the following checks:

 (1) Do we have more mappings than the folio has pages? Then the folio is
     certainly shared. That is, when "folio_mapcount() > folio_nr_pages()"
 (2) For each rmap value X, does that rmap value folio->_rmap_valX
     correspond to "folio_mapcount() * sub-ID[X]" of the MM?
     Then the folio is certainly exclusive. Note that we only check that
     when "folio_mapcount() <= folio_nr_pages()".

4. Synchronization
==================

We're using an atomic seqcount, stored in the folio, to allow for readers
to detect concurrent (un)mapping, whereby they could obtain a wrong
snapshot of the mapcount+rmap values and make a wrong decision.

Further, the mapcount and all rmap values are updated using RMW atomics,
to allow for concurrent updates.

5. sub-IDs
==========

To achieve (2), we generate sub-IDs that have the following property,
assuming that our folio has P=folio_nr_pages() pages.
  "2 * sub-ID" cannot be represented by the sum of any other *2* sub-IDs
  "3 * sub-ID" cannot be represented by the sum of any other *3* sub-IDs
  "4 * sub-ID" cannot be represented by the sum of any other *4* sub-IDs
  ...
  "P * sub-ID" cannot be represented by the sum of any other *P* sub-IDs

The sub-IDs are generated in generations, whereby
(1) Generation #0 is the number 0
(2) Generation #N takes all numbers from generations #0..#N-1 and adds
    (P + 1)^(N - 1), effectively doubling the number of sub-IDs

Consequently, the smallest number S in gen #N is:
  S[#N] = (P + 1)^(N - 1)

The largest number L in gen #N is:
  L[#N] = (P + 1)^(N - 1) + (P + 1)^(N - 2) + ... (P + 1)^0 + 0.
  -> [geometric sum with "P + 1 != 1"]
        = (1 - (P + 1)^N) / (1 - (P + 1))
        = (1 - (P + 1)^N) / (-P)
        = ((P + 1)^N - 1) / P

Example with P=4 (order-2 folio):

Generation #0:      0
------------------------     + (4 + 1)^0 = 1
Generation #1:      1
------------------------     + (4 + 1)^1 = 5
Generation #2:      5
                    6
------------------------     + (4 + 1)^2 = 25
Generation #3:     25
                   26
                   30
                   31
------------------------     + (4 + 1)^3 = 125
[...]

Intuitively, we are working with sub-counters that cannot overflow as
long as we have <= P components. Let's consider the simple case of P=3,
whereby our sub-counters are exactly 2-bit wide.

Subid |      Bits | Sub-counters
--------------------------------
 0    | 0000 0000 |   0,0,0,0
 1    | 0000 0001 |   0,0,0,1
 4    | 0000 0100 |   0,0,1,0
 5    | 0000 0101 |   0,0,1,1
 16   | 0001 0000 |   0,1,0,0
 17   | 0001 0001 |   0,1,0,1
 20   | 0001 0100 |   0,1,1,0
 21   | 0001 0101 |   0,1,1,1
 64   | 0100 0000 |   1,0,0,0
 65   | 0100 0001 |   1,0,0,1
 68   | 0100 0100 |   1,0,1,0
 69   | 0100 0101 |   1,0,1,1
 80   | 0101 0100 |   1,1,0,0
 81   | 0101 0001 |   1,1,0,1
 84   | 0101 0100 |   1,1,1,0
 85   | 0101 0101 |   1,1,1,1

So if we, say, have:
	3 * 17 = 0,3,0,3
how could we possible get to that number by using 3 other subids? It's
impossible, because the sub-counters won't overflow as long as we stay
<= 3.

Interesting side note that might come in handy at some point: we also
cannot get to 0,3,0,3 by using 1 or 2 other subids. But, we could get to
1 * 17 = 0,1,0,1 by using 2 subids (16 and 1) or similarly to 2 * 17 =
0,2,0,2 by using 4 subids (2x16 and 2x1). Looks like we cannot get to
X * subid using any 1..X other subids.

Note 1: we'll add the actual detection logic used to be used by
folio_mapped_shared() and wp_can_reuse_anon_folio() separately.

Note 2: we might want to use that infrastructure for hugetlb as well in the
future: there is nothing THP-specific about rmap ID handling.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm_types.h |  58 +++++++
 include/linux/rmap.h     | 126 +++++++++++++-
 kernel/fork.c            |  26 +++
 mm/Kconfig               |  21 +++
 mm/Makefile              |   1 +
 mm/huge_memory.c         |  16 +-
 mm/init-mm.c             |   4 +
 mm/page_alloc.c          |   9 +
 mm/rmap_id.c             | 351 +++++++++++++++++++++++++++++++++++++++
 9 files changed, 604 insertions(+), 8 deletions(-)
 create mode 100644 mm/rmap_id.c

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 99b84b4797b9..75305c57ef64 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -18,6 +18,7 @@
 #include <linux/page-flags-layout.h>
 #include <linux/workqueue.h>
 #include <linux/seqlock.h>
+#include <linux/atomic_seqcount.h>
 #include <linux/percpu_counter.h>
 
 #include <asm/mmu.h>
@@ -273,6 +274,14 @@ typedef struct {
  * @_hugetlb_cgroup_rsvd: Do not use directly, use accessor in hugetlb_cgroup.h.
  * @_hugetlb_hwpoison: Do not use directly, call raw_hwp_list_head().
  * @_deferred_list: Folios to be split under memory pressure.
+ * @_rmap_atomic_seqcount: Seqcount protecting _total_mapcount and _rmapX.
+ *     Does not apply to hugetlb.
+ * @_rmap_val0 Do not use outside of rmap code. Does not apply to hugetlb.
+ * @_rmap_val1 Do not use outside of rmap code. Does not apply to hugetlb.
+ * @_rmap_val2 Do not use outside of rmap code. Does not apply to hugetlb.
+ * @_rmap_val3 Do not use outside of rmap code. Does not apply to hugetlb.
+ * @_rmap_val4 Do not use outside of rmap code. Does not apply to hugetlb.
+ * @_rmap_val5 Do not use outside of rmap code. Does not apply to hugetlb.
  *
  * A folio is a physically, virtually and logically contiguous set
  * of bytes.  It is a power-of-two in size, and it is aligned to that
@@ -331,6 +340,9 @@ struct folio {
 			atomic_t _pincount;
 #ifdef CONFIG_64BIT
 			unsigned int _folio_nr_pages;
+#ifdef CONFIG_RMAP_ID
+			raw_atomic_seqcount_t _rmap_atomic_seqcount;
+#endif /* CONFIG_RMAP_ID */
 #endif
 	/* private: the union with struct page is transitional */
 		};
@@ -356,6 +368,34 @@ struct folio {
 		};
 		struct page __page_2;
 	};
+	union {
+		struct {
+			unsigned long _flags_3;
+			unsigned long _head_3;
+	/* public: */
+#ifdef CONFIG_RMAP_ID
+			atomic_long_t _rmap_val0;
+			atomic_long_t _rmap_val1;
+			atomic_long_t _rmap_val2;
+			atomic_long_t _rmap_val3;
+#endif /* CONFIG_RMAP_ID */
+	/* private: the union with struct page is transitional */
+		};
+		struct page __page_3;
+	};
+	union {
+		struct {
+			unsigned long _flags_4;
+			unsigned long _head_4;
+	/* public: */
+#ifdef CONFIG_RMAP_ID
+			atomic_long_t _rmap_val4;
+			atomic_long_t _rmap_val5;
+#endif /* CONFIG_RMAP_ID */
+	/* private: the union with struct page is transitional */
+		};
+		struct page __page_4;
+	};
 };
 
 #define FOLIO_MATCH(pg, fl)						\
@@ -392,6 +432,20 @@ FOLIO_MATCH(compound_head, _head_2);
 FOLIO_MATCH(flags, _flags_2a);
 FOLIO_MATCH(compound_head, _head_2a);
 #undef FOLIO_MATCH
+#define FOLIO_MATCH(pg, fl)						\
+	static_assert(offsetof(struct folio, fl) ==			\
+			offsetof(struct page, pg) + 3 * sizeof(struct page))
+FOLIO_MATCH(flags, _flags_3);
+FOLIO_MATCH(compound_head, _head_3);
+#undef FOLIO_MATCH
+#undef FOLIO_MATCH
+#define FOLIO_MATCH(pg, fl)						\
+	static_assert(offsetof(struct folio, fl) ==			\
+			offsetof(struct page, pg) + 4 * sizeof(struct page))
+FOLIO_MATCH(flags, _flags_4);
+FOLIO_MATCH(compound_head, _head_4);
+#undef FOLIO_MATCH
+
 
 /**
  * struct ptdesc -    Memory descriptor for page tables.
@@ -975,6 +1029,10 @@ struct mm_struct {
 #endif
 		} lru_gen;
 #endif /* CONFIG_LRU_GEN */
+
+#ifdef CONFIG_RMAP_ID
+		int mm_rmap_id;
+#endif /* CONFIG_RMAP_ID */
 	} __randomize_layout;
 
 	/*
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 9d5c2ed6ced5..19c9dc3216df 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -168,6 +168,116 @@ static inline void anon_vma_merge(struct vm_area_struct *vma,
 
 struct anon_vma *folio_get_anon_vma(struct folio *folio);
 
+#ifdef CONFIG_RMAP_ID
+/*
+ * For init_mm and friends, we don't actually expect to ever rmap pages. So
+ * we use a reserved dummy ID that we'll never hand out the normal way.
+ */
+#define RMAP_ID_DUMMY		0
+#define RMAP_ID_MIN	(RMAP_ID_DUMMY + 1)
+#define RMAP_ID_MAX	(16 * 1024 * 1024u - 1)
+
+void free_rmap_id(int id);
+int alloc_rmap_id(void);
+
+#define RMAP_SUBID_4_MAX_ORDER		10
+#define RMAP_SUBID_5_MIN_ORDER		11
+#define RMAP_SUBID_5_MAX_ORDER		12
+#define RMAP_SUBID_6_MIN_ORDER		13
+#define RMAP_SUBID_6_MAX_ORDER		15
+
+static inline void __folio_prep_large_rmap(struct folio *folio)
+{
+	const unsigned int order = folio_order(folio);
+
+	raw_seqcount_init(&folio->_rmap_atomic_seqcount);
+	switch (order) {
+#if MAX_ORDER >= RMAP_SUBID_6_MIN_ORDER
+	case RMAP_SUBID_6_MIN_ORDER ... RMAP_SUBID_6_MAX_ORDER:
+		atomic_long_set(&folio->_rmap_val5, 0);
+		fallthrough;
+#endif
+#if MAX_ORDER >= RMAP_SUBID_5_MIN_ORDER
+	case RMAP_SUBID_5_MIN_ORDER ... RMAP_SUBID_5_MAX_ORDER:
+		atomic_long_set(&folio->_rmap_val4, 0);
+		fallthrough;
+#endif
+	default:
+		atomic_long_set(&folio->_rmap_val3, 0);
+		atomic_long_set(&folio->_rmap_val2, 0);
+		atomic_long_set(&folio->_rmap_val1, 0);
+		atomic_long_set(&folio->_rmap_val0, 0);
+		break;
+	}
+}
+
+static inline void __folio_undo_large_rmap(struct folio *folio)
+{
+#ifdef CONFIG_DEBUG_VM
+	const unsigned int order = folio_order(folio);
+
+	switch (order) {
+#if MAX_ORDER >= RMAP_SUBID_6_MIN_ORDER
+	case RMAP_SUBID_6_MIN_ORDER ... RMAP_SUBID_6_MAX_ORDER:
+		VM_WARN_ON_ONCE(atomic_long_read(&folio->_rmap_val5));
+		fallthrough;
+#endif
+#if MAX_ORDER >= RMAP_SUBID_5_MIN_ORDER
+	case RMAP_SUBID_5_MIN_ORDER ... RMAP_SUBID_5_MAX_ORDER:
+		VM_WARN_ON_ONCE(atomic_long_read(&folio->_rmap_val4));
+		fallthrough;
+#endif
+	default:
+		VM_WARN_ON_ONCE(atomic_long_read(&folio->_rmap_val3));
+		VM_WARN_ON_ONCE(atomic_long_read(&folio->_rmap_val2));
+		VM_WARN_ON_ONCE(atomic_long_read(&folio->_rmap_val1));
+		VM_WARN_ON_ONCE(atomic_long_read(&folio->_rmap_val0));
+		break;
+	}
+#endif
+}
+
+static inline void __folio_write_large_rmap_begin(struct folio *folio)
+{
+	VM_WARN_ON_FOLIO(!folio_test_large_rmappable(folio), folio);
+	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
+	raw_write_atomic_seqcount_begin(&folio->_rmap_atomic_seqcount);
+}
+
+static inline void __folio_write_large_rmap_end(struct folio *folio)
+{
+	raw_write_atomic_seqcount_end(&folio->_rmap_atomic_seqcount);
+}
+
+void __folio_set_large_rmap_val(struct folio *folio, int count,
+		struct mm_struct *mm);
+void __folio_add_large_rmap_val(struct folio *folio, int count,
+		struct mm_struct *mm);
+#else
+static inline void __folio_prep_large_rmap(struct folio *folio)
+{
+}
+static inline void __folio_undo_large_rmap(struct folio *folio)
+{
+}
+static inline void __folio_write_large_rmap_begin(struct folio *folio)
+{
+	VM_WARN_ON_FOLIO(!folio_test_large_rmappable(folio), folio);
+	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
+}
+static inline void __folio_write_large_rmap_end(struct folio *folio)
+{
+}
+static inline void __folio_set_large_rmap_val(struct folio *folio, int count,
+		struct mm_struct *mm)
+{
+}
+static inline void __folio_add_large_rmap_val(struct folio *folio, int count,
+		struct mm_struct *mm)
+{
+}
+#endif /* CONFIG_RMAP_ID */
+
 static inline void folio_set_large_mapcount(struct folio *folio,
 		int count, struct vm_area_struct *vma)
 {
@@ -175,30 +285,34 @@ static inline void folio_set_large_mapcount(struct folio *folio,
 	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 	/* increment count (starts at -1) */
 	atomic_set(&folio->_total_mapcount, count - 1);
+	__folio_set_large_rmap_val(folio, count, vma->vm_mm);
 }
 
 static inline void folio_inc_large_mapcount(struct folio *folio,
 		struct vm_area_struct *vma)
 {
-	VM_WARN_ON_FOLIO(!folio_test_large_rmappable(folio), folio);
-	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
+	__folio_write_large_rmap_begin(folio);
 	atomic_inc(&folio->_total_mapcount);
+	__folio_add_large_rmap_val(folio, 1, vma->vm_mm);
+	__folio_write_large_rmap_end(folio);
 }
 
 static inline void folio_add_large_mapcount(struct folio *folio,
 		int count, struct vm_area_struct *vma)
 {
-	VM_WARN_ON_FOLIO(!folio_test_large_rmappable(folio), folio);
-	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
+	__folio_write_large_rmap_begin(folio);
 	atomic_add(count, &folio->_total_mapcount);
+	__folio_add_large_rmap_val(folio, count, vma->vm_mm);
+	__folio_write_large_rmap_end(folio);
 }
 
 static inline void folio_dec_large_mapcount(struct folio *folio,
 		struct vm_area_struct *vma)
 {
-	VM_WARN_ON_FOLIO(!folio_test_large_rmappable(folio), folio);
-	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
+	__folio_write_large_rmap_begin(folio);
 	atomic_dec(&folio->_total_mapcount);
+	__folio_add_large_rmap_val(folio, -1, vma->vm_mm);
+	__folio_write_large_rmap_end(folio);
 }
 
 /* RMAP flags, currently only relevant for some anon rmap operations. */
diff --git a/kernel/fork.c b/kernel/fork.c
index 10917c3e1f03..773c93613ca2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -814,6 +814,26 @@ static int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 #define mm_free_pgd(mm)
 #endif /* CONFIG_MMU */
 
+#ifdef CONFIG_RMAP_ID
+static inline int mm_alloc_rmap_id(struct mm_struct *mm)
+{
+	int id = alloc_rmap_id();
+
+	if (id < 0)
+		return id;
+	mm->mm_rmap_id = id;
+	return 0;
+}
+
+static inline void mm_free_rmap_id(struct mm_struct *mm)
+{
+	free_rmap_id(mm->mm_rmap_id);
+}
+#else
+#define mm_alloc_rmap_id(mm)	(0)
+#define mm_free_rmap_id(mm)
+#endif /* CONFIG_RMAP_ID */
+
 static void check_mm(struct mm_struct *mm)
 {
 	int i;
@@ -917,6 +937,7 @@ void __mmdrop(struct mm_struct *mm)
 
 	WARN_ON_ONCE(mm == current->active_mm);
 	mm_free_pgd(mm);
+	mm_free_rmap_id(mm);
 	destroy_context(mm);
 	mmu_notifier_subscriptions_destroy(mm);
 	check_mm(mm);
@@ -1298,6 +1319,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	if (mm_alloc_pgd(mm))
 		goto fail_nopgd;
 
+	if (mm_alloc_rmap_id(mm))
+		goto fail_normapid;
+
 	if (init_new_context(p, mm))
 		goto fail_nocontext;
 
@@ -1317,6 +1341,8 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 fail_cid:
 	destroy_context(mm);
 fail_nocontext:
+	mm_free_rmap_id(mm);
+fail_normapid:
 	mm_free_pgd(mm);
 fail_nopgd:
 	free_mm(mm);
diff --git a/mm/Kconfig b/mm/Kconfig
index 89971a894b60..bb0b7b885ada 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -861,6 +861,27 @@ choice
 	  benefit.
 endchoice
 
+menuconfig RMAP_ID
+	bool "Rmap ID tracking (EXPERIMENTAL)"
+	depends on TRANSPARENT_HUGEPAGE && 64BIT
+	help
+	  Use per-MM rmap IDs and the unleashed power of math to track
+	  whether partially-mappable hugepages (i.e., THPs for now) are
+	  "mapped shared" or "mapped exclusively".
+
+	  This tracking allow for efficiently and precisely detecting
+	  whether a PTE-mapped THP is mapped by a single process
+	  ("mapped exclusively") or mapped by multiple ones ("mapped
+	  shared"), with the cost of additional tracking when (un)mapping
+	  (parts of) such a THP.
+
+	  If this configuration is not enabled, an heuristic is used
+	  instead that might result in false "mapped exclusively"
+	  detection; some features relying on this information might
+	  operate slightly imprecise (e.g., MADV_PAGEOUT succeeds although
+	  it should fail) or might not be available at all (e.g.,
+	  Copy-on-Write reuse support).
+
 config THP_SWAP
 	def_bool y
 	depends on TRANSPARENT_HUGEPAGE && ARCH_WANTS_THP_SWAP && SWAP && 64BIT
diff --git a/mm/Makefile b/mm/Makefile
index 33873c8aedb3..b0cf2563f33a 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -138,3 +138,4 @@ obj-$(CONFIG_IO_MAPPING) += io-mapping.o
 obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
 obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
 obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
+obj-$(CONFIG_RMAP_ID) += rmap_id.o
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 51a878efca0e..0228b04c4053 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -614,6 +614,7 @@ void folio_prep_large_rmappable(struct folio *folio)
 {
 	VM_BUG_ON_FOLIO(folio_order(folio) < 2, folio);
 	INIT_LIST_HEAD(&folio->_deferred_list);
+	__folio_prep_large_rmap(folio);
 	folio_set_large_rmappable(folio);
 }
 
@@ -2478,8 +2479,8 @@ static void __split_huge_page_tail(struct folio *folio, int tail,
 			 (1L << PG_dirty) |
 			 LRU_GEN_MASK | LRU_REFS_MASK));
 
-	/* ->mapping in first and second tail page is replaced by other uses */
-	VM_BUG_ON_PAGE(tail > 2 && page_tail->mapping != TAIL_MAPPING,
+	/* ->mapping in some tail page is replaced by other uses */
+	VM_BUG_ON_PAGE(tail > 4 && page_tail->mapping != TAIL_MAPPING,
 			page_tail);
 	page_tail->mapping = head->mapping;
 	page_tail->index = head->index + tail;
@@ -2550,6 +2551,16 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 
 	ClearPageHasHWPoisoned(head);
 
+#ifdef CONFIG_RMAP_ID
+	/*
+	 * Make sure folio->_rmap_atomic_seqcount, which overlays
+	 * tail->private, is 0. All other folio->_rmap_valX should be 0
+	 * after unmapping the folio.
+	 */
+	if (likely(nr >= 4))
+		raw_seqcount_init(&folio->_rmap_atomic_seqcount);
+#endif /* CONFIG_RMAP_ID */
+
 	for (i = nr - 1; i >= 1; i--) {
 		__split_huge_page_tail(folio, i, lruvec, list);
 		/* Some pages can be beyond EOF: drop them from page cache */
@@ -2809,6 +2820,7 @@ void folio_undo_large_rmappable(struct folio *folio)
 	struct deferred_split *ds_queue;
 	unsigned long flags;
 
+	__folio_undo_large_rmap(folio);
 	/*
 	 * At this point, there is no one trying to add the folio to
 	 * deferred_list. If folio is not in deferred_list, it's safe
diff --git a/mm/init-mm.c b/mm/init-mm.c
index cfd367822cdd..8890271b50c6 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -7,6 +7,7 @@
 #include <linux/cpumask.h>
 #include <linux/mman.h>
 #include <linux/pgtable.h>
+#include <linux/rmap.h>
 
 #include <linux/atomic.h>
 #include <linux/user_namespace.h>
@@ -46,6 +47,9 @@ struct mm_struct init_mm = {
 	.cpu_bitmap	= CPU_BITS_NONE,
 #ifdef CONFIG_IOMMU_SVA
 	.pasid		= IOMMU_PASID_INVALID,
+#endif
+#ifdef CONFIG_RMAP_ID
+	.mm_rmap_id	= RMAP_ID_DUMMY,
 #endif
 	INIT_MM_CONTEXT(init_mm)
 };
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index aad45758c0c7..c1dd039801e7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1007,6 +1007,15 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 		 * deferred_list.next -- ignore value.
 		 */
 		break;
+#ifdef CONFIG_RMAP_ID
+	case 3:
+	case 4:
+		/*
+		 * the third and fourth tail page: ->mapping may be
+		 * used to store RMAP values for RMAP ID tracking.
+		 */
+		break;
+#endif /* CONFIG_RMAP_ID */
 	default:
 		if (page->mapping != TAIL_MAPPING) {
 			bad_page(page, "corrupted mapping in tail page");
diff --git a/mm/rmap_id.c b/mm/rmap_id.c
new file mode 100644
index 000000000000..e66b0f5aea2d
--- /dev/null
+++ b/mm/rmap_id.c
@@ -0,0 +1,351 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * rmap ID tracking for precise "mapped shared" vs. "mapped exclusively"
+ * detection of partially-mappable folios (e.g., PTE-mapped THP).
+ *
+ * Copyright Red Hat, Inc. 2023
+ *
+ * Author(s): David Hildenbrand <david@redhat.com>
+ */
+
+#include <linux/mm.h>
+#include <linux/rmap.h>
+#include <linux/idr.h>
+
+#include "internal.h"
+
+static DEFINE_SPINLOCK(rmap_id_lock);
+static DEFINE_IDA(rmap_ida);
+
+/* For now we only expect folios from the buddy, not hugetlb folios. */
+#if MAX_ORDER > RMAP_SUBID_6_MAX_ORDER
+#error "rmap ID tracking does not support such large MAX_ORDER"
+#endif
+
+/*
+ * We assign each MM a unique rmap ID and derive from it a sequence of
+ * special sub-IDs. We add/remove these sub-IDs to/from the corresponding
+ * folio rmap values (folio->rmap_valX) whenever (un)mapping (parts of) a
+ * partially mappable folio.
+ *
+ * With 24bit rmap IDs, and a folio size that is compatible with 4
+ * rmap values (more below), we calculate the sub-ID sequence like this:
+ *
+ * rmap ID    :  | 3 3 3 3 3 3 | 2 2 2 2 2 2 | 1 1 1 1 1 1 | 0 0 0 0 0 0 |
+ * sub-ID IDX :  |   IDX #3    |   IDX #2    |   IDX #1    |   IDX #0    |
+ *
+ * sub-IDs    :  [ subid_4(#3), subid_4(#2), subid_4(#1), subid_4(#0) ]
+ * rmap value :  [  _rmap_val3,  _rmap_val2,  _rmap_val1,  _rmap_val0 ]
+ *
+ * Any time we map/unmap a part (e.g., PTE, PMD) of a partially-mappable
+ * folio to/from a MM, we:
+ *  (1) Adjust (increment/decrement) the mapcount of the folio
+ *  (2) Adjust (add/remove) the folio rmap values using the MM sub-IDs
+ *
+ * So the rmap values are always linked to the folio mapcount.
+ * Consequently, we know that a single rmap value in the folio is the sum
+ * of exactly #folio_mapcount() rmap sub-IDs. As one example, if the folio
+ * is completely unmapped, the rmap values must be 0. As another example,
+ * if the folio is mapped exactly once, the rmap values correspond to the
+ * MM sub-IDs.
+ *
+ * To identify whether a given MM is responsible for all #folio_mapcount()
+ * mappings of a folio ("mapped exclusively") or whether other MMs are
+ * involved ("mapped shared"), we perform the following checks:
+ *  (1) Do we have more mappings than the folio has pages? Then the folio
+ *      is mapped shared. So when "folio_mapcount() > folio_nr_pages()".
+ *  (2) Do the rmap values corresond to "#folio_mapcount() * sub-IDs" of
+ *      the MM? Then the folio is mapped exclusive.
+ *
+ * To achieve (2), we generate sub-IDs that have the following property,
+ * assuming that our folio has P=folio_nr_pages() pages.
+ *   "2 * sub-ID" cannot be represented by the sum of any other *2* sub-IDs
+ *   "3 * sub-ID" cannot be represented by the sum of any other *3* sub-IDs
+ *   "4 * sub-ID" cannot be represented by the sum of any other *4* sub-IDs
+ *   ...
+ *   "P * sub-ID" cannot be represented by the sum of any other *P* sub-IDs
+ *
+ * Further, we want "P * sub-ID" (the maximum number we will ever look at)
+ * to not overflow. If we overflow with " > P" mappings, we don't care as
+ * we won't be looking at the numbers until theya re fully expressive
+ * again.
+ *
+ * Consequently, to not overflow 64bit values with "P * sub-ID", folios
+ * with large P require more rmap values (we cannot generate that many sub
+ * IDs), whereby folios with smaller P can get away with less rmap values
+ * (we can generate more sub-IDs).
+ *
+ * The sub-IDs are generated in generations, whereby
+ * (1) Generation #0 is the number 0
+ * (2) Generation #N takes all numbers from generations #0..#N-1 and adds
+ *     (P + 1)^(N - 1), effectively doubling the number of sub-IDs
+ *
+ * Note: a PMD-sized THP can, for a short time while PTE-mapping it, be
+ *       mapped using PTEs and a single PMD, resulting in "P + 1" mappings.
+ *       For now, we don't consider this case, as we are ususally not
+ *       looking at such folios while they being remapped, because the
+ *       involved page tables are locked and stop any page table walkers.
+ */
+
+/*
+ * With 1024 (order-10) possible exclusive mappings per folio, we can have 64
+ * sub-IDs per 64bit value.
+ *
+ * With 4 such 64bit values, we can support 64^4 == 16M IDs.
+ */
+static const unsigned long rmap_subids_4[64] = {
+	0ul,
+	1ul,
+	1025ul,
+	1026ul,
+	1050625ul,
+	1050626ul,
+	1051650ul,
+	1051651ul,
+	1076890625ul,
+	1076890626ul,
+	1076891650ul,
+	1076891651ul,
+	1077941250ul,
+	1077941251ul,
+	1077942275ul,
+	1077942276ul,
+	1103812890625ul,
+	1103812890626ul,
+	1103812891650ul,
+	1103812891651ul,
+	1103813941250ul,
+	1103813941251ul,
+	1103813942275ul,
+	1103813942276ul,
+	1104889781250ul,
+	1104889781251ul,
+	1104889782275ul,
+	1104889782276ul,
+	1104890831875ul,
+	1104890831876ul,
+	1104890832900ul,
+	1104890832901ul,
+	1131408212890625ul,
+	1131408212890626ul,
+	1131408212891650ul,
+	1131408212891651ul,
+	1131408213941250ul,
+	1131408213941251ul,
+	1131408213942275ul,
+	1131408213942276ul,
+	1131409289781250ul,
+	1131409289781251ul,
+	1131409289782275ul,
+	1131409289782276ul,
+	1131409290831875ul,
+	1131409290831876ul,
+	1131409290832900ul,
+	1131409290832901ul,
+	1132512025781250ul,
+	1132512025781251ul,
+	1132512025782275ul,
+	1132512025782276ul,
+	1132512026831875ul,
+	1132512026831876ul,
+	1132512026832900ul,
+	1132512026832901ul,
+	1132513102671875ul,
+	1132513102671876ul,
+	1132513102672900ul,
+	1132513102672901ul,
+	1132513103722500ul,
+	1132513103722501ul,
+	1132513103723525ul,
+	1132513103723526ul,
+};
+
+static unsigned long get_rmap_subid_4(struct mm_struct *mm, int nr)
+{
+	const unsigned int rmap_id = mm->mm_rmap_id;
+
+	VM_WARN_ON_ONCE(rmap_id < RMAP_ID_MIN || rmap_id > RMAP_ID_MAX || nr > 3);
+	return rmap_subids_4[(rmap_id >> (nr * 6)) & 0x3f];
+}
+
+#if MAX_ORDER >= RMAP_SUBID_5_MIN_ORDER
+/*
+ * With 4096 (order-12) possible exclusive mappings per folio, we can have
+ * 32 sub-IDs per 64bit value.
+ *
+ * With 5 such 64bit values, we can support 32^5 > 16M IDs.
+ */
+static const unsigned long rmap_subids_5[32] = {
+	0ul,
+	1ul,
+	4097ul,
+	4098ul,
+	16785409ul,
+	16785410ul,
+	16789506ul,
+	16789507ul,
+	68769820673ul,
+	68769820674ul,
+	68769824770ul,
+	68769824771ul,
+	68786606082ul,
+	68786606083ul,
+	68786610179ul,
+	68786610180ul,
+	281749955297281ul,
+	281749955297282ul,
+	281749955301378ul,
+	281749955301379ul,
+	281749972082690ul,
+	281749972082691ul,
+	281749972086787ul,
+	281749972086788ul,
+	281818725117954ul,
+	281818725117955ul,
+	281818725122051ul,
+	281818725122052ul,
+	281818741903363ul,
+	281818741903364ul,
+	281818741907460ul,
+	281818741907461ul,
+};
+
+static unsigned long get_rmap_subid_5(struct mm_struct *mm, int nr)
+{
+	const unsigned int rmap_id = mm->mm_rmap_id;
+
+	VM_WARN_ON_ONCE(rmap_id < RMAP_ID_MIN || rmap_id > RMAP_ID_MAX || nr > 4);
+	return rmap_subids_5[(rmap_id >> (nr * 5)) & 0x1f];
+}
+#endif
+
+#if MAX_ORDER >= RMAP_SUBID_6_MIN_ORDER
+/*
+ * With 32768 (order-15) possible exclusive mappings per folio, we can have
+ * 16 sub-IDs per 64bit value.
+ *
+ * With 6 such 64bit values, we can support 8^6 == 16M IDs.
+ */
+static const unsigned long rmap_subids_6[16] = {
+	0ul,
+	1ul,
+	32769ul,
+	32770ul,
+	1073807361ul,
+	1073807362ul,
+	1073840130ul,
+	1073840131ul,
+	35187593412609ul,
+	35187593412610ul,
+	35187593445378ul,
+	35187593445379ul,
+	35188667219970ul,
+	35188667219971ul,
+	35188667252739ul,
+	35188667252740ul,
+};
+
+static unsigned long get_rmap_subid_6(struct mm_struct *mm, int nr)
+{
+	const unsigned int rmap_id = mm->mm_rmap_id;
+
+	VM_WARN_ON_ONCE(rmap_id < RMAP_ID_MIN || rmap_id > RMAP_ID_MAX || nr > 15);
+	return rmap_subids_6[(rmap_id >> (nr * 4)) & 0xf];
+}
+#endif
+
+void __folio_set_large_rmap_val(struct folio *folio, int count,
+		struct mm_struct *mm)
+{
+	const unsigned int order = folio_order(folio);
+
+	switch (order) {
+#if MAX_ORDER >= RMAP_SUBID_6_MIN_ORDER
+	case RMAP_SUBID_6_MIN_ORDER ... RMAP_SUBID_6_MAX_ORDER:
+		atomic_long_set(&folio->_rmap_val0, get_rmap_subid_6(mm, 0) * count);
+		atomic_long_set(&folio->_rmap_val1, get_rmap_subid_6(mm, 1) * count);
+		atomic_long_set(&folio->_rmap_val2, get_rmap_subid_6(mm, 2) * count);
+		atomic_long_set(&folio->_rmap_val3, get_rmap_subid_6(mm, 3) * count);
+		atomic_long_set(&folio->_rmap_val4, get_rmap_subid_6(mm, 4) * count);
+		atomic_long_set(&folio->_rmap_val5, get_rmap_subid_6(mm, 5) * count);
+		break;
+#endif
+#if MAX_ORDER >= RMAP_SUBID_5_MIN_ORDER
+	case RMAP_SUBID_5_MIN_ORDER ... RMAP_SUBID_5_MAX_ORDER:
+		atomic_long_set(&folio->_rmap_val0, get_rmap_subid_5(mm, 0) * count);
+		atomic_long_set(&folio->_rmap_val1, get_rmap_subid_5(mm, 1) * count);
+		atomic_long_set(&folio->_rmap_val2, get_rmap_subid_5(mm, 2) * count);
+		atomic_long_set(&folio->_rmap_val3, get_rmap_subid_5(mm, 3) * count);
+		atomic_long_set(&folio->_rmap_val4, get_rmap_subid_5(mm, 4) * count);
+		break;
+#endif
+	default:
+		atomic_long_set(&folio->_rmap_val0, get_rmap_subid_4(mm, 0) * count);
+		atomic_long_set(&folio->_rmap_val1, get_rmap_subid_4(mm, 1) * count);
+		atomic_long_set(&folio->_rmap_val2, get_rmap_subid_4(mm, 2) * count);
+		atomic_long_set(&folio->_rmap_val3, get_rmap_subid_4(mm, 3) * count);
+		break;
+	}
+}
+
+void __folio_add_large_rmap_val(struct folio *folio, int count,
+		struct mm_struct *mm)
+{
+	const unsigned int order = folio_order(folio);
+
+	switch (order) {
+#if MAX_ORDER >= RMAP_SUBID_6_MIN_ORDER
+	case RMAP_SUBID_6_MIN_ORDER ... RMAP_SUBID_6_MAX_ORDER:
+		atomic_long_add(get_rmap_subid_6(mm, 0) * count, &folio->_rmap_val0);
+		atomic_long_add(get_rmap_subid_6(mm, 1) * count, &folio->_rmap_val1);
+		atomic_long_add(get_rmap_subid_6(mm, 2) * count, &folio->_rmap_val2);
+		atomic_long_add(get_rmap_subid_6(mm, 3) * count, &folio->_rmap_val3);
+		atomic_long_add(get_rmap_subid_6(mm, 4) * count, &folio->_rmap_val4);
+		atomic_long_add(get_rmap_subid_6(mm, 5) * count, &folio->_rmap_val5);
+		break;
+#endif
+#if MAX_ORDER >= RMAP_SUBID_5_MIN_ORDER
+	case RMAP_SUBID_5_MIN_ORDER ... RMAP_SUBID_5_MAX_ORDER:
+		atomic_long_add(get_rmap_subid_5(mm, 0) * count, &folio->_rmap_val0);
+		atomic_long_add(get_rmap_subid_5(mm, 1) * count, &folio->_rmap_val1);
+		atomic_long_add(get_rmap_subid_5(mm, 2) * count, &folio->_rmap_val2);
+		atomic_long_add(get_rmap_subid_5(mm, 3) * count, &folio->_rmap_val3);
+		atomic_long_add(get_rmap_subid_5(mm, 4) * count, &folio->_rmap_val4);
+		break;
+#endif
+	default:
+		atomic_long_add(get_rmap_subid_4(mm, 0) * count, &folio->_rmap_val0);
+		atomic_long_add(get_rmap_subid_4(mm, 1) * count, &folio->_rmap_val1);
+		atomic_long_add(get_rmap_subid_4(mm, 2) * count, &folio->_rmap_val2);
+		atomic_long_add(get_rmap_subid_4(mm, 3) * count, &folio->_rmap_val3);
+		break;
+	}
+}
+
+int alloc_rmap_id(void)
+{
+	int id;
+
+	/*
+	 * We cannot use a mutex, because free_rmap_id() might get called
+	 * when we are not allowed to sleep.
+	 *
+	 * TODO: do we need something like idr_preload()?
+	 */
+	spin_lock(&rmap_id_lock);
+	id = ida_alloc_range(&rmap_ida, RMAP_ID_MIN, RMAP_ID_MAX, GFP_ATOMIC);
+	spin_unlock(&rmap_id_lock);
+
+	return id;
+}
+
+void free_rmap_id(int id)
+{
+	if (id == RMAP_ID_DUMMY)
+		return;
+	if (WARN_ON_ONCE(id < RMAP_ID_MIN || id > RMAP_ID_MAX))
+		return;
+	spin_lock(&rmap_id_lock);
+	ida_free(&rmap_ida, id);
+	spin_unlock(&rmap_id_lock);
+}
-- 
2.41.0

