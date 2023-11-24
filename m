Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42817F750E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbjKXN3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbjKXN2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:28:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2662108
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700832453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IWxh+srF4eII3yzN2Ch68mHrKm0yO3+Xlp6snuZfYi4=;
        b=R/Vj3wZQr5otgXJxdaACSiB4pyJvJfVdaSa+/u5vg6ZjxlQfHjqKf1vDePuZ1Ux96U7ypJ
        LQ/g0nPGw0usvd7PfsyDn/PwqVMuhyIOJzePDIR/r7Usi3JnRd+Ioz0c0i7+5oAQKMuk8e
        QFvLt9A+cZI52SKnua9hOTuQ9Cf6lWY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-yC66DjjfM-2TnstsUc80dA-1; Fri, 24 Nov 2023 08:27:30 -0500
X-MC-Unique: yC66DjjfM-2TnstsUc80dA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C903185A780;
        Fri, 24 Nov 2023 13:27:29 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 150282166B2A;
        Fri, 24 Nov 2023 13:27:25 +0000 (UTC)
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
Subject: [PATCH WIP v1 16/20] atomic_seqcount: support a single exclusive writer in the absence of other writers
Date:   Fri, 24 Nov 2023 14:26:21 +0100
Message-ID: <20231124132626.235350-17-david@redhat.com>
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

The current atomic seqcount requires that all writers must use atomic
RMW operations in the critical section, which can result in quite some
overhead on some platforms. In the common case, there is only a single
writer, and ideally we'd be able to not use atomic RMW operations in that
case, to reduce the overall number of atomic RMW operations on the
fast path.

So let's add support for a single exclusive writer. If there are no
other writers, a writer can become the single exclusive writer by using
an atomic cmpxchg on the atomic seqcount. However, if there is any
concurrent writer (shared or exclusive), the writers become shared and
only have to wait for a single exclusive writer to finish.

So shared writers might be delayed a bit by the single exclusive writer,
but they don't starve as they are guaranteed to make progress after the
exclusive writer finished (that ideally runs faster than any shared writer
due to no atomic RMW operations in the critical section).

The exclusive path now effectively acts as a lock: if the trylock fails,
we fallback to the shared path. We need acquire-release semantics that are
implied by the full memory barriers that we are enforcing.

Instead of the atomic_long_add_return(), we could keep using an
atomic_long_add() + atomic_long_read(). But I suspect that doesn't
really matter. If it ever matters, if will be easy to optimize.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/atomic_seqcount.h | 101 ++++++++++++++++++++++++++------
 include/linux/rmap.h            |   5 +-
 2 files changed, 85 insertions(+), 21 deletions(-)

diff --git a/include/linux/atomic_seqcount.h b/include/linux/atomic_seqcount.h
index 109447b663a1..00286a9da221 100644
--- a/include/linux/atomic_seqcount.h
+++ b/include/linux/atomic_seqcount.h
@@ -8,8 +8,11 @@
 
 /*
  * raw_atomic_seqcount_t -- a reader-writer consistency mechanism with
- * lockless readers (read-only retry loops), and lockless writers.
- * The writers must use atomic RMW operations in the critical section.
+ * lockless readers (read-only retry loops), and (almost) lockless writers.
+ * Shared writers must use atomic RMW operations in the critical section,
+ * a single exclusive writer can avoid atomic RMW operations in the critical
+ * section. Shared writers will always have to wait for at most one exclusive
+ * writer to finish in order to make progress.
  *
  * This locking mechanism is applicable when all individual operations
  * performed by writers can be expressed using atomic RMW operations
@@ -38,9 +41,10 @@ typedef struct raw_atomic_seqcount {
 /* 65536 CPUs */
 #define ATOMIC_SEQCOUNT_SHARED_WRITERS_MAX		0x0000000000008000ul
 #define ATOMIC_SEQCOUNT_SHARED_WRITERS_MASK		0x000000000000fffful
-#define ATOMIC_SEQCOUNT_WRITERS_MASK			0x000000000000fffful
+#define ATOMIC_SEQCOUNT_EXCLUSIVE_WRITER		0x0000000000010000ul
+#define ATOMIC_SEQCOUNT_WRITERS_MASK			0x000000000001fffful
 /* We have 48bit for the actual sequence. */
-#define ATOMIC_SEQCOUNT_SEQUENCE_STEP			0x0000000000010000ul
+#define ATOMIC_SEQCOUNT_SEQUENCE_STEP			0x0000000000020000ul
 
 #else /* CONFIG_64BIT */
 
@@ -48,9 +52,10 @@ typedef struct raw_atomic_seqcount {
 /* 64 CPUs */
 #define ATOMIC_SEQCOUNT_SHARED_WRITERS_MAX		0x00000040ul
 #define ATOMIC_SEQCOUNT_SHARED_WRITERS_MASK		0x0000007ful
-#define ATOMIC_SEQCOUNT_WRITERS_MASK			0x0000007ful
-/* We have 25bit for the actual sequence. */
-#define ATOMIC_SEQCOUNT_SEQUENCE_STEP			0x00000080ul
+#define ATOMIC_SEQCOUNT_EXCLUSIVE_WRITER		0x00000080ul
+#define ATOMIC_SEQCOUNT_WRITERS_MASK			0x000000fful
+/* We have 24bit for the actual sequence. */
+#define ATOMIC_SEQCOUNT_SEQUENCE_STEP			0x00000100ul
 
 #endif /* CONFIG_64BIT */
 
@@ -126,44 +131,102 @@ static inline bool raw_read_atomic_seqcount_retry(raw_atomic_seqcount_t *s,
 /**
  * raw_write_seqcount_begin() - start a raw_seqcount_t write critical section
  * @s: Pointer to the raw_atomic_seqcount_t
+ * @try_exclusive: Whether to try becoming the exclusive writer.
  *
  * raw_write_seqcount_begin() opens the write critical section of the
  * given raw_seqcount_t. This function must not be used in interrupt context.
+ *
+ * Return: "true" when we are the exclusive writer and can avoid atomic RMW
+ *         operations in the critical section. Otherwise, we are a shared
+ *         writer and have to use atomic RMW operations in the critical
+ *         section. Will always return "false" if @try_exclusive is not "true".
  */
-static inline void raw_write_atomic_seqcount_begin(raw_atomic_seqcount_t *s)
+static inline bool raw_write_atomic_seqcount_begin(raw_atomic_seqcount_t *s,
+						   bool try_exclusive)
 {
+	unsigned long seqcount, seqcount_new;
+
 	BUILD_BUG_ON(IS_ENABLED(CONFIG_PREEMPT_RT));
 #ifdef CONFIG_DEBUG_ATOMIC_SEQCOUNT
 	DEBUG_LOCKS_WARN_ON(in_interrupt());
 #endif /* CONFIG_DEBUG_ATOMIC_SEQCOUNT */
 	preempt_disable();
-	atomic_long_add(ATOMIC_SEQCOUNT_SHARED_WRITER, &s->sequence);
-	/* Store the sequence before any store in the critical section. */
-	smp_mb__after_atomic();
+
+	/* If requested, can we just become the exclusive writer? */
+	if (!try_exclusive)
+		goto shared;
+
+	seqcount = atomic_long_read(&s->sequence);
+	if (unlikely(seqcount & ATOMIC_SEQCOUNT_WRITERS_MASK))
+		goto shared;
+
+	seqcount_new = seqcount | ATOMIC_SEQCOUNT_EXCLUSIVE_WRITER;
+	/*
+	 * Store the sequence before any store in the critical section. Further,
+	 * this implies an acquire so loads within the critical section are
+	 * not reordered to be outside the critical section.
+	 */
+	if (atomic_long_try_cmpxchg(&s->sequence, &seqcount, seqcount_new))
+		return true;
+shared:
+	/*
+	 * Indicate that there is a shared writer, and spin until the exclusive
+	 * writer is done. This avoids writer starvation, because we'll always
+	 * have to wait for at most one writer.
+	 *
+	 * We spin with preemption disabled to not reschedule to a reader that
+	 * cannot make any progress either way.
+	 *
+	 * Store the sequence before any store in the critical section.
+	 */
+	seqcount = atomic_long_add_return(ATOMIC_SEQCOUNT_SHARED_WRITER,
+					  &s->sequence);
 #ifdef CONFIG_DEBUG_ATOMIC_SEQCOUNT
-	DEBUG_LOCKS_WARN_ON((atomic_long_read(&s->sequence) &
-			     ATOMIC_SEQCOUNT_SHARED_WRITERS_MASK) >
+	DEBUG_LOCKS_WARN_ON((seqcount & ATOMIC_SEQCOUNT_SHARED_WRITERS_MASK) >
 			    ATOMIC_SEQCOUNT_SHARED_WRITERS_MAX);
 #endif /* CONFIG_DEBUG_ATOMIC_SEQCOUNT */
+	if (likely(!(seqcount & ATOMIC_SEQCOUNT_EXCLUSIVE_WRITER)))
+		return false;
+
+	while (atomic_long_read(&s->sequence) & ATOMIC_SEQCOUNT_EXCLUSIVE_WRITER)
+		cpu_relax();
+	return false;
 }
 
 /**
  * raw_write_seqcount_end() - end a raw_seqcount_t write critical section
  * @s: Pointer to the raw_atomic_seqcount_t
+ * @exclusive: Return value of raw_write_atomic_seqcount_begin().
  *
  * raw_write_seqcount_end() closes the write critical section of the
  * given raw_seqcount_t.
  */
-static inline void raw_write_atomic_seqcount_end(raw_atomic_seqcount_t *s)
+static inline void raw_write_atomic_seqcount_end(raw_atomic_seqcount_t *s,
+						 bool exclusive)
 {
+	unsigned long val = ATOMIC_SEQCOUNT_SEQUENCE_STEP;
+
+	if (likely(exclusive)) {
+#ifdef CONFIG_DEBUG_ATOMIC_SEQCOUNT
+		DEBUG_LOCKS_WARN_ON(!(atomic_long_read(&s->sequence) &
+				      ATOMIC_SEQCOUNT_EXCLUSIVE_WRITER));
+#endif /* CONFIG_DEBUG_ATOMIC_SEQCOUNT */
+		val -= ATOMIC_SEQCOUNT_EXCLUSIVE_WRITER;
+	} else {
 #ifdef CONFIG_DEBUG_ATOMIC_SEQCOUNT
-	DEBUG_LOCKS_WARN_ON(!(atomic_long_read(&s->sequence) &
-			      ATOMIC_SEQCOUNT_SHARED_WRITERS_MASK));
+		DEBUG_LOCKS_WARN_ON(!(atomic_long_read(&s->sequence) &
+				      ATOMIC_SEQCOUNT_SHARED_WRITERS_MASK));
 #endif /* CONFIG_DEBUG_ATOMIC_SEQCOUNT */
-	/* Store the sequence after any store in the critical section. */
+		val -= ATOMIC_SEQCOUNT_SHARED_WRITER;
+	}
+	/*
+	 * Store the sequence after any store in the critical section. For
+	 * the exclusive path, this further implies a release, so loads
+	 * within the critical section are not reordered to be outside the
+	 * cricial section.
+	 */
 	smp_mb__before_atomic();
-	atomic_long_add(ATOMIC_SEQCOUNT_SEQUENCE_STEP -
-			ATOMIC_SEQCOUNT_SHARED_WRITER, &s->sequence);
+	atomic_long_add(val, &s->sequence);
 	preempt_enable();
 }
 
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 76e6fb1dad5c..0758dddc5528 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -295,12 +295,13 @@ static inline void __folio_write_large_rmap_begin(struct folio *folio)
 {
 	VM_WARN_ON_FOLIO(!folio_test_large_rmappable(folio), folio);
 	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
-	raw_write_atomic_seqcount_begin(&folio->_rmap_atomic_seqcount);
+	raw_write_atomic_seqcount_begin(&folio->_rmap_atomic_seqcount,
+					false);
 }
 
 static inline void __folio_write_large_rmap_end(struct folio *folio)
 {
-	raw_write_atomic_seqcount_end(&folio->_rmap_atomic_seqcount);
+	raw_write_atomic_seqcount_end(&folio->_rmap_atomic_seqcount, false);
 }
 
 void __folio_set_large_rmap_val(struct folio *folio, int count,
-- 
2.41.0

