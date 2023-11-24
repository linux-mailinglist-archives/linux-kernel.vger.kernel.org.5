Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D3E7F7514
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjKXN3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbjKXN2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:28:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26EB213A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700832461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uVx5jgkX7VDXu2BOJ112MWVTaXFaq3iLz1p8EjK2pug=;
        b=TiePEiMLX8kRem+4vM/XteE8B3g580adOI01NCZjErMBifJmMhxl5rTjFWFDkK4dEdcB+I
        9QujlixgjEb+wcWOoOXeBOH789xzWDV/gbB8RXHc88HLiK819wT5QlzV2ZOOam5HGanfX1
        Aohc8fxxDfB9PiKyUkL6eCoatGEWqtM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-x3WGX4woMCePcALEhUGVJg-1; Fri, 24 Nov 2023 08:27:37 -0500
X-MC-Unique: x3WGX4woMCePcALEhUGVJg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E919E185A781;
        Fri, 24 Nov 2023 13:27:36 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 887C32166B2A;
        Fri, 24 Nov 2023 13:27:33 +0000 (UTC)
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
Subject: [PATCH WIP v1 18/20] atomic_seqcount: use atomic add-return instead of atomic cmpxchg on 64bit
Date:   Fri, 24 Nov 2023 14:26:23 +0100
Message-ID: <20231124132626.235350-19-david@redhat.com>
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

Turns out that it can be beneficial on some HW to use an add-return instead
of and atomic cmpxchg. However, we have to deal with more possible races
now: in the worst case, each and every CPU might try becoming the exclusive
writer at the same time, so we need the same number of bits as for the
shared writer case.

In case we detect that we didn't end up being the exclusive writer,
simply back off and convert to a shared writer.

Only implement this optimization on 64bit, where we can steal more bits
from the actual sequence without sorrow.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/atomic_seqcount.h | 43 +++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/include/linux/atomic_seqcount.h b/include/linux/atomic_seqcount.h
index 00286a9da221..9cd40903863d 100644
--- a/include/linux/atomic_seqcount.h
+++ b/include/linux/atomic_seqcount.h
@@ -42,9 +42,10 @@ typedef struct raw_atomic_seqcount {
 #define ATOMIC_SEQCOUNT_SHARED_WRITERS_MAX		0x0000000000008000ul
 #define ATOMIC_SEQCOUNT_SHARED_WRITERS_MASK		0x000000000000fffful
 #define ATOMIC_SEQCOUNT_EXCLUSIVE_WRITER		0x0000000000010000ul
-#define ATOMIC_SEQCOUNT_WRITERS_MASK			0x000000000001fffful
-/* We have 48bit for the actual sequence. */
-#define ATOMIC_SEQCOUNT_SEQUENCE_STEP			0x0000000000020000ul
+#define ATOMIC_SEQCOUNT_EXCLUSIVE_WRITERS_MASK		0x00000000ffff0000ul
+#define ATOMIC_SEQCOUNT_WRITERS_MASK			0x00000000fffffffful
+/* We have 32bit for the actual sequence. */
+#define ATOMIC_SEQCOUNT_SEQUENCE_STEP			0x0000000100000000ul
 
 #else /* CONFIG_64BIT */
 
@@ -53,6 +54,7 @@ typedef struct raw_atomic_seqcount {
 #define ATOMIC_SEQCOUNT_SHARED_WRITERS_MAX		0x00000040ul
 #define ATOMIC_SEQCOUNT_SHARED_WRITERS_MASK		0x0000007ful
 #define ATOMIC_SEQCOUNT_EXCLUSIVE_WRITER		0x00000080ul
+#define ATOMIC_SEQCOUNT_EXCLUSIVE_WRITERS_MASK		0x00000080ul
 #define ATOMIC_SEQCOUNT_WRITERS_MASK			0x000000fful
 /* We have 24bit for the actual sequence. */
 #define ATOMIC_SEQCOUNT_SEQUENCE_STEP			0x00000100ul
@@ -144,7 +146,7 @@ static inline bool raw_read_atomic_seqcount_retry(raw_atomic_seqcount_t *s,
 static inline bool raw_write_atomic_seqcount_begin(raw_atomic_seqcount_t *s,
 						   bool try_exclusive)
 {
-	unsigned long seqcount, seqcount_new;
+	unsigned long __maybe_unused seqcount, seqcount_new;
 
 	BUILD_BUG_ON(IS_ENABLED(CONFIG_PREEMPT_RT));
 #ifdef CONFIG_DEBUG_ATOMIC_SEQCOUNT
@@ -160,6 +162,32 @@ static inline bool raw_write_atomic_seqcount_begin(raw_atomic_seqcount_t *s,
 	if (unlikely(seqcount & ATOMIC_SEQCOUNT_WRITERS_MASK))
 		goto shared;
 
+#ifdef CONFIG_64BIT
+	BUILD_BUG_ON(__builtin_popcount(ATOMIC_SEQCOUNT_EXCLUSIVE_WRITERS_MASK) !=
+		     __builtin_popcount(ATOMIC_SEQCOUNT_SHARED_WRITERS_MASK));
+
+	/* See comment for atomic_long_try_cmpxchg() below. */
+	seqcount = atomic_long_add_return(ATOMIC_SEQCOUNT_EXCLUSIVE_WRITER,
+					  &s->sequence);
+	if (likely((seqcount & ATOMIC_SEQCOUNT_WRITERS_MASK) ==
+		    ATOMIC_SEQCOUNT_EXCLUSIVE_WRITER))
+		return true;
+
+	/*
+	 * Whoops, we raced with another writer. Back off, converting ourselves
+	 * to a shared writer and wait for any exclusive writers.
+	 */
+	atomic_long_add(ATOMIC_SEQCOUNT_SHARED_WRITER - ATOMIC_SEQCOUNT_EXCLUSIVE_WRITER,
+			&s->sequence);
+	/*
+	 * No need for __smp_mb__after_atomic(): the reader side already
+	 * realizes that it has to retry and the memory barrier from
+	 * atomic_long_add_return() is sufficient for that.
+	 */
+	while (atomic_long_read(&s->sequence) & ATOMIC_SEQCOUNT_EXCLUSIVE_WRITERS_MASK)
+		cpu_relax();
+	return false;
+#else
 	seqcount_new = seqcount | ATOMIC_SEQCOUNT_EXCLUSIVE_WRITER;
 	/*
 	 * Store the sequence before any store in the critical section. Further,
@@ -168,6 +196,7 @@ static inline bool raw_write_atomic_seqcount_begin(raw_atomic_seqcount_t *s,
 	 */
 	if (atomic_long_try_cmpxchg(&s->sequence, &seqcount, seqcount_new))
 		return true;
+#endif
 shared:
 	/*
 	 * Indicate that there is a shared writer, and spin until the exclusive
@@ -185,10 +214,10 @@ static inline bool raw_write_atomic_seqcount_begin(raw_atomic_seqcount_t *s,
 	DEBUG_LOCKS_WARN_ON((seqcount & ATOMIC_SEQCOUNT_SHARED_WRITERS_MASK) >
 			    ATOMIC_SEQCOUNT_SHARED_WRITERS_MAX);
 #endif /* CONFIG_DEBUG_ATOMIC_SEQCOUNT */
-	if (likely(!(seqcount & ATOMIC_SEQCOUNT_EXCLUSIVE_WRITER)))
+	if (likely(!(seqcount & ATOMIC_SEQCOUNT_EXCLUSIVE_WRITERS_MASK)))
 		return false;
 
-	while (atomic_long_read(&s->sequence) & ATOMIC_SEQCOUNT_EXCLUSIVE_WRITER)
+	while (atomic_long_read(&s->sequence) & ATOMIC_SEQCOUNT_EXCLUSIVE_WRITERS_MASK)
 		cpu_relax();
 	return false;
 }
@@ -209,7 +238,7 @@ static inline void raw_write_atomic_seqcount_end(raw_atomic_seqcount_t *s,
 	if (likely(exclusive)) {
 #ifdef CONFIG_DEBUG_ATOMIC_SEQCOUNT
 		DEBUG_LOCKS_WARN_ON(!(atomic_long_read(&s->sequence) &
-				      ATOMIC_SEQCOUNT_EXCLUSIVE_WRITER));
+				      ATOMIC_SEQCOUNT_EXCLUSIVE_WRITERS_MASK));
 #endif /* CONFIG_DEBUG_ATOMIC_SEQCOUNT */
 		val -= ATOMIC_SEQCOUNT_EXCLUSIVE_WRITER;
 	} else {
-- 
2.41.0

