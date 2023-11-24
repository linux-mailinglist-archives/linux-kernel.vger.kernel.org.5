Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754387F74F0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345621AbjKXN1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbjKXN1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:27:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39E019B1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700832420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ujZJ3g6hK6oBZOKXOf3RJw4ZrpKoYgRWOTMhG7TrjzA=;
        b=SeTVvvm8Xc2oDJVbQuCbZFFk5U1dRzA3boOM/6Af8TardoT+WGyfOelh/gXMBEFo38N5d4
        GBafbBUjG7moggr6Jqp4J5VRey9az6Mucx/P9NsXuikXQsz2isTSj5pU7k+JOrYqOElRmc
        RlAtB9tnF/ws1RxrqzSo7UWmn3aArzs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-U_verE8yOyS0gXTE1oEkOw-1; Fri,
 24 Nov 2023 08:26:54 -0500
X-MC-Unique: U_verE8yOyS0gXTE1oEkOw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1C4538116E0;
        Fri, 24 Nov 2023 13:26:53 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 232362166B2A;
        Fri, 24 Nov 2023 13:26:50 +0000 (UTC)
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
Subject: [PATCH WIP v1 06/20] atomic_seqcount: new (raw) seqcount variant to support concurrent writers
Date:   Fri, 24 Nov 2023 14:26:11 +0100
Message-ID: <20231124132626.235350-7-david@redhat.com>
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

Assume we have a writer side that is fairly simple and only updates some
counters by adding some values:
	folio->counter_a += diff_a;
	folio->counter_b += diff_b;
	folio->counter_c += diff_c;
	...

Further, assume that our readers want to always read consistent
set of counters. That is, they not only want to read each counter
atomically, but also get a consistent/atomic view across *all*
counters, detecting the case where there are concurrent modifications of
the counters.

Traditionally, we'd use a seqcount protected by some locking on the
writer side. The readers can run lockless, detect when there were
concurrent updates, to simply retry again to re-read all values.

However, a seqcount requires to serialize all writers to only allow for a
single writer at a time. Alternatives might include per-cpu
counters / local atomics, but for the target use cases, both primitives
are not applicable:

We want to store counters (2 to 7 for now, depending on the folio size) in
the "struct folio" of some larger folios (order >=2 ) whereby the counters
get adjusted whenever we (un)map part of a folio.

(a) The reader side must be able to get a consistent view of the
    counters and be able to detect concurrent changes (i.e., concurrent
    (un)mapping), as described above. In some cases we can simply stop
    immediately if we detect any concurrent writer -- any concurrent
    (un)map activity.
(b) The writer side updates the counters as described above and should
    ideally run completely lockless. In many cases, we always have a
    single write at a time. But in some scenarios, we can trigger
    a lot of concurrent writers. We want the writer
    side to be able to make progress instead of repeadetly spinning,
    waiting for possibly many other writers.
(c) Space in the "struct folio" especially for smallish folios is very
    limited, and the "struct page" layout imposes various restrictions
    on where we can even put new data; growing the size of the
    "struct page" is not desired because it can result in serious metadata
    overhead and easily has performance implications (cache-line). So we
    cannot place ordinary spinlocks in there (especially also because they
    change their size based on lockdep and actual implementation), and the
    only real alternative is a bit spinlock, which is really undesired.

If we want to allow concurrent writers, we can use atomic RMW operations
when updating the counters:
	atomic_add(diff_a, &folio->counter_a);
	atomic_add(diff_b, &folio->counter_b);
	atomic_add(diff_c, &folio->counter_c);
	...

But the existing seqcount to make the reader size detect concurrent
updates is not capable of handling concurrent writers.

So let's add a new atomic seqcount for exactly that purpose. Instead of
using a single LSB in the seqcount to detect a single concurrent writer, it
uses multiple LSBs to detect multiple concurrent writers. As the
seqcount can be modified concurrently, it ends up being an atomic type. In
theory, each CPU can participate, so we have to steal quite some LSBs on
64bit. As that reduces the bits available for the actual sequence quite
drastically especially on 64bit, and there is the concern that 16bit for
the sequence might not be sufficient, just use an atomic_long_t for now.

For the use case discussed, we will place the new atomic seqcount into the
"struct folio"/"struct page", where the limitations as described above
apply. For that use case, the "raw" variant -- raw_atomic_seqcount_t -- is
required, so we only add that.

For the normal seqcount on the writer side, we have the following memory
ordering:

	s->sequence++
	smp_wmb();
	[critical section]
	smp_wmb();
	s->sequence++

It's important that other CPUs don't observe stores to the sequence
to be reordered with stores in the critical section.

For the atomic seqcount, we could have similarly used:

	atomic_long_add(SHARED, &s->sequence);
	smp_wmb();
	[critical section]
	smp_wmb();
	atomic_long_add(STEP - SHARED, &s->sequence);

But especially on x86_64, the atomic_long_add() already implies a full
memory barrier. So instead, we can do:

	atomic_long_add(SHARED, &s->sequence);
	__smp_mb__after_atomic();
	[critical section]
	__smp_mb__before_atomic();
	atomic_long_add(STEP - SHARED, &s->sequence);

Or alternatively:

	atomic_long_add_return(SHARED, &s->sequence);
	[critical section]
	atomic_long_add_return(STEP - SHARED, &s->sequence);

Could we use acquire-release semantics? Like the following:

	atomic_long_add_return_acquire(SHARED, &s->sequence)
	[critical section]
	atomic_long_add_return_release(STEP - SHARED, &s->sequence)

Maybe, but (a) it would make it different to normal seqcounts,
because stores before/after the atomic_long_add_*() could now be reordered
and; (b) memory-barriers.txt might indicate that the sequence counter store
might be reordered: "For compound atomics performing both a load and a
store, ACQUIRE semantics apply only to the load and RELEASE semantics
apply only to the store portion of the operation.".

So let's keep it simple for now.

Effectively, with the atomic seqcount We end up with more atomic RMW
operations in the critical section but get no writer starvation / lock
contention in return.

We'll limit the implementation to !PREEMPT_RT and disallowing
readers/writers from interrupt context.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/atomic_seqcount.h | 170 ++++++++++++++++++++++++++++++++
 lib/Kconfig.debug               |  11 +++
 2 files changed, 181 insertions(+)
 create mode 100644 include/linux/atomic_seqcount.h

diff --git a/include/linux/atomic_seqcount.h b/include/linux/atomic_seqcount.h
new file mode 100644
index 000000000000..109447b663a1
--- /dev/null
+++ b/include/linux/atomic_seqcount.h
@@ -0,0 +1,170 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __LINUX_ATOMIC_SEQLOCK_H
+#define __LINUX_ATOMIC_SEQLOCK_H
+
+#include <linux/compiler.h>
+#include <linux/threads.h>
+#include <linux/preempt.h>
+
+/*
+ * raw_atomic_seqcount_t -- a reader-writer consistency mechanism with
+ * lockless readers (read-only retry loops), and lockless writers.
+ * The writers must use atomic RMW operations in the critical section.
+ *
+ * This locking mechanism is applicable when all individual operations
+ * performed by writers can be expressed using atomic RMW operations
+ * (so they can run lockless) and readers only need a way to get an atomic
+ * view over all individual atomic values: like writers atomically updating
+ * multiple counters, and readers wanting to observe a consistent state
+ * across all these counters.
+ *
+ * For now, only the raw variant is implemented, that doesn't perform any
+ * lockdep checks.
+ *
+ * Copyright Red Hat, Inc. 2023
+ *
+ * Author(s): David Hildenbrand <david@redhat.com>
+ */
+
+typedef struct raw_atomic_seqcount {
+	atomic_long_t sequence;
+} raw_atomic_seqcount_t;
+
+#define raw_seqcount_init(s) atomic_long_set(&((s)->sequence), 0)
+
+#ifdef CONFIG_64BIT
+
+#define ATOMIC_SEQCOUNT_SHARED_WRITER			0x0000000000000001ul
+/* 65536 CPUs */
+#define ATOMIC_SEQCOUNT_SHARED_WRITERS_MAX		0x0000000000008000ul
+#define ATOMIC_SEQCOUNT_SHARED_WRITERS_MASK		0x000000000000fffful
+#define ATOMIC_SEQCOUNT_WRITERS_MASK			0x000000000000fffful
+/* We have 48bit for the actual sequence. */
+#define ATOMIC_SEQCOUNT_SEQUENCE_STEP			0x0000000000010000ul
+
+#else /* CONFIG_64BIT */
+
+#define ATOMIC_SEQCOUNT_SHARED_WRITER			0x00000001ul
+/* 64 CPUs */
+#define ATOMIC_SEQCOUNT_SHARED_WRITERS_MAX		0x00000040ul
+#define ATOMIC_SEQCOUNT_SHARED_WRITERS_MASK		0x0000007ful
+#define ATOMIC_SEQCOUNT_WRITERS_MASK			0x0000007ful
+/* We have 25bit for the actual sequence. */
+#define ATOMIC_SEQCOUNT_SEQUENCE_STEP			0x00000080ul
+
+#endif /* CONFIG_64BIT */
+
+#if CONFIG_NR_CPUS > ATOMIC_SEQCOUNT_SHARED_WRITERS_MAX
+#error "raw_atomic_seqcount_t does not support such large CONFIG_NR_CPUS"
+#endif
+
+/**
+ * raw_read_atomic_seqcount() - read the raw_atomic_seqcount_t counter value
+ * @s: Pointer to the raw_atomic_seqcount_t
+ *
+ * raw_read_atomic_seqcount() opens a read critical section of the given
+ * raw_atomic_seqcount_t, and without checking or masking the sequence counter
+ * LSBs (using ATOMIC_SEQCOUNT_WRITERS_MASK). Calling code is responsible for
+ * handling that.
+ *
+ * Return: count to be passed to raw_read_atomic_seqcount_retry()
+ */
+static inline unsigned long raw_read_atomic_seqcount(raw_atomic_seqcount_t *s)
+{
+	unsigned long seq = atomic_long_read(&s->sequence);
+
+	/* Read the sequence before anything in the critical section */
+	smp_rmb();
+	return seq;
+}
+
+/**
+ * raw_read_atomic_seqcount_begin() - begin a raw_seqcount_t read section
+ * @s: Pointer to the raw_atomic_seqcount_t
+ *
+ * raw_read_atomic_seqcount_begin() opens a read critical section of the
+ * given raw_seqcount_t. This function must not be used in interrupt context.
+ *
+ * Return: count to be passed to raw_read_atomic_seqcount_retry()
+ */
+static inline unsigned long raw_read_atomic_seqcount_begin(raw_atomic_seqcount_t *s)
+{
+	unsigned long seq;
+
+	BUILD_BUG_ON(IS_ENABLED(CONFIG_PREEMPT_RT));
+#ifdef CONFIG_DEBUG_ATOMIC_SEQCOUNT
+	DEBUG_LOCKS_WARN_ON(in_interrupt());
+#endif /* CONFIG_DEBUG_ATOMIC_SEQCOUNT */
+	while ((seq = atomic_long_read(&s->sequence)) &
+		ATOMIC_SEQCOUNT_WRITERS_MASK)
+		cpu_relax();
+
+	/* Load the sequence before any load in the critical section. */
+	smp_rmb();
+	return seq;
+}
+
+/**
+ * raw_read_atomic_seqcount_retry() - end a raw_seqcount_t read critical section
+ * @s: Pointer to the raw_atomic_seqcount_t
+ * @start: count, for example from raw_read_atomic_seqcount_begin()
+ *
+ * raw_read_atomic_seqcount_retry() closes the read critical section of the
+ * given raw_seqcount_t.  If the critical section was invalid, it must be ignored
+ * (and typically retried).
+ *
+ * Return: true if a read section retry is required, else false
+ */
+static inline bool raw_read_atomic_seqcount_retry(raw_atomic_seqcount_t *s,
+		unsigned long start)
+{
+	/* Load the sequence after any load in the critical section. */
+	smp_rmb();
+	return unlikely(atomic_long_read(&s->sequence) != start);
+}
+
+/**
+ * raw_write_seqcount_begin() - start a raw_seqcount_t write critical section
+ * @s: Pointer to the raw_atomic_seqcount_t
+ *
+ * raw_write_seqcount_begin() opens the write critical section of the
+ * given raw_seqcount_t. This function must not be used in interrupt context.
+ */
+static inline void raw_write_atomic_seqcount_begin(raw_atomic_seqcount_t *s)
+{
+	BUILD_BUG_ON(IS_ENABLED(CONFIG_PREEMPT_RT));
+#ifdef CONFIG_DEBUG_ATOMIC_SEQCOUNT
+	DEBUG_LOCKS_WARN_ON(in_interrupt());
+#endif /* CONFIG_DEBUG_ATOMIC_SEQCOUNT */
+	preempt_disable();
+	atomic_long_add(ATOMIC_SEQCOUNT_SHARED_WRITER, &s->sequence);
+	/* Store the sequence before any store in the critical section. */
+	smp_mb__after_atomic();
+#ifdef CONFIG_DEBUG_ATOMIC_SEQCOUNT
+	DEBUG_LOCKS_WARN_ON((atomic_long_read(&s->sequence) &
+			     ATOMIC_SEQCOUNT_SHARED_WRITERS_MASK) >
+			    ATOMIC_SEQCOUNT_SHARED_WRITERS_MAX);
+#endif /* CONFIG_DEBUG_ATOMIC_SEQCOUNT */
+}
+
+/**
+ * raw_write_seqcount_end() - end a raw_seqcount_t write critical section
+ * @s: Pointer to the raw_atomic_seqcount_t
+ *
+ * raw_write_seqcount_end() closes the write critical section of the
+ * given raw_seqcount_t.
+ */
+static inline void raw_write_atomic_seqcount_end(raw_atomic_seqcount_t *s)
+{
+#ifdef CONFIG_DEBUG_ATOMIC_SEQCOUNT
+	DEBUG_LOCKS_WARN_ON(!(atomic_long_read(&s->sequence) &
+			      ATOMIC_SEQCOUNT_SHARED_WRITERS_MASK));
+#endif /* CONFIG_DEBUG_ATOMIC_SEQCOUNT */
+	/* Store the sequence after any store in the critical section. */
+	smp_mb__before_atomic();
+	atomic_long_add(ATOMIC_SEQCOUNT_SEQUENCE_STEP -
+			ATOMIC_SEQCOUNT_SHARED_WRITER, &s->sequence);
+	preempt_enable();
+}
+
+#endif /* __LINUX_ATOMIC_SEQLOCK_H */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index cc7d53d9dc01..569c2c6ed47f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1298,6 +1298,7 @@ config PROVE_LOCKING
 	select DEBUG_MUTEXES if !PREEMPT_RT
 	select DEBUG_RT_MUTEXES if RT_MUTEXES
 	select DEBUG_RWSEMS
+	select DEBUG_ATOMIC_SEQCOUNT if !PREEMPT_RT
 	select DEBUG_WW_MUTEX_SLOWPATH
 	select DEBUG_LOCK_ALLOC
 	select PREEMPT_COUNT if !ARCH_NO_PREEMPT
@@ -1425,6 +1426,16 @@ config DEBUG_RWSEMS
 	  This debugging feature allows mismatched rw semaphore locks
 	  and unlocks to be detected and reported.
 
+config DEBUG_ATOMIC_SEQCOUNT
+	bool "Atomic seqcount debugging: basic checks"
+	depends on DEBUG_KERNEL && !PREEMPT_RT
+	help
+	 This feature allows some atomic seqcount semantics violations to be
+	 detected and reported.
+
+	 The debug checks are only performed when running code that actively
+	 uses atomic seqcounts; there are no dedicated test cases yet.
+
 config DEBUG_LOCK_ALLOC
 	bool "Lock debugging: detect incorrect freeing of live locks"
 	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
-- 
2.41.0

