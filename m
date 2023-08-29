Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E3478CA6E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237683AbjH2RNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237715AbjH2RMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:12:52 -0400
Received: from out-252.mta1.migadu.com (out-252.mta1.migadu.com [IPv6:2001:41d0:203:375::fc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2010ECCA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:12:41 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693329159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+57664S6bw4mOO/qPj8h7l/H8qh2Ip2xAdoPp4fmyag=;
        b=xUAvBItl08LNbG+js05Euj/uDwk7mnKgQkEClKLARFeIBi8pvWrOlUBmEdpKyMjEBpe08t
        MZxZZK8u8HPHUPrktgetKtdD93OVx+rnbApYTVTui9WIUJLSE/Xb3wolF7HpROmuiVuy/N
        gklA8fWRmILe9ypho6CUw2WGHHwPn0E=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 06/15] stackdepot: fix and clean-up atomic annotations
Date:   Tue, 29 Aug 2023 19:11:16 +0200
Message-Id: <8ad8f778b43dab49e4e6214b8d90bed31b75436f.1693328501.git.andreyknvl@google.com>
In-Reply-To: <cover.1693328501.git.andreyknvl@google.com>
References: <cover.1693328501.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Simplify comments accompanying the use of atomic accesses in the
stack depot code.

Also turn smp_load_acquire from next_pool_required in depot_init_pool
into READ_ONCE, as both depot_init_pool and the all smp_store_release's
to this variable are executed under the stack depot lock.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

This patch is not strictly required, as the atomic accesses are fully
removed in one of the latter patches. However, I decided to keep the
patch just in case we end up needing these atomics in the following
iterations of this series.
---
 lib/stackdepot.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 93191ee70fc3..9ae71e1ef1a7 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -226,10 +226,10 @@ static void depot_init_pool(void **prealloc)
 	/*
 	 * If the next pool is already initialized or the maximum number of
 	 * pools is reached, do not use the preallocated memory.
-	 * smp_load_acquire() here pairs with smp_store_release() below and
-	 * in depot_alloc_stack().
+	 * READ_ONCE is only used to mark the variable as atomic,
+	 * there are no concurrent writes.
 	 */
-	if (!smp_load_acquire(&next_pool_required))
+	if (!READ_ONCE(next_pool_required))
 		return;
 
 	/* Check if the current pool is not yet allocated. */
@@ -250,8 +250,8 @@ static void depot_init_pool(void **prealloc)
 		 * At this point, either the next pool is initialized or the
 		 * maximum number of pools is reached. In either case, take
 		 * note that initializing another pool is not required.
-		 * This smp_store_release pairs with smp_load_acquire() above
-		 * and in stack_depot_save().
+		 * smp_store_release pairs with smp_load_acquire in
+		 * stack_depot_save.
 		 */
 		smp_store_release(&next_pool_required, 0);
 	}
@@ -275,15 +275,15 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 		/*
 		 * Move on to the next pool.
 		 * WRITE_ONCE pairs with potential concurrent read in
-		 * stack_depot_fetch().
+		 * stack_depot_fetch.
 		 */
 		WRITE_ONCE(pool_index, pool_index + 1);
 		pool_offset = 0;
 		/*
 		 * If the maximum number of pools is not reached, take note
 		 * that the next pool needs to initialized.
-		 * smp_store_release() here pairs with smp_load_acquire() in
-		 * stack_depot_save() and depot_init_pool().
+		 * smp_store_release pairs with smp_load_acquire in
+		 * stack_depot_save.
 		 */
 		if (pool_index + 1 < DEPOT_MAX_POOLS)
 			smp_store_release(&next_pool_required, 1);
@@ -414,8 +414,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 
 	/*
 	 * Fast path: look the stack trace up without locking.
-	 * The smp_load_acquire() here pairs with smp_store_release() to
-	 * |bucket| below.
+	 * smp_load_acquire pairs with smp_store_release to |bucket| below.
 	 */
 	found = find_stack(smp_load_acquire(bucket), entries, nr_entries, hash);
 	if (found)
@@ -425,8 +424,8 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 	 * Check if another stack pool needs to be initialized. If so, allocate
 	 * the memory now - we won't be able to do that under the lock.
 	 *
-	 * The smp_load_acquire() here pairs with smp_store_release() to
-	 * |next_pool_inited| in depot_alloc_stack() and depot_init_pool().
+	 * smp_load_acquire pairs with smp_store_release
+	 * in depot_alloc_stack and depot_init_pool.
 	 */
 	if (unlikely(can_alloc && smp_load_acquire(&next_pool_required))) {
 		/*
@@ -452,8 +451,8 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 		if (new) {
 			new->next = *bucket;
 			/*
-			 * This smp_store_release() pairs with
-			 * smp_load_acquire() from |bucket| above.
+			 * smp_store_release pairs with smp_load_acquire
+			 * from |bucket| above.
 			 */
 			smp_store_release(bucket, new);
 			found = new;
-- 
2.25.1

