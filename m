Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102107F1B89
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbjKTRu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbjKTRtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:49:52 -0500
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [IPv6:2001:41d0:1004:224b::aa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E621708
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:49:42 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700502580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=taQhm6+sqq7C99vuNmST7zKoEFBrlbi2ArfSWbY49ok=;
        b=DLuotPQZ2ya2ze/Uk9qdks6Velp5g/ufNOpAnZ3F0CTG4bBuTmqBJZX+8HrA4Dqfb+h/XH
        cXG4e43rc7TxqEGmM94O/sylDTL5wKtysxQVD2NH08lAvJQHMJZz91DKB754x+wRKfj68K
        mQIu1A/BqCWkTls4JakGGQmnxTCxoCg=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v4 17/22] lib/stackdepot: allow users to evict stack traces
Date:   Mon, 20 Nov 2023 18:47:15 +0100
Message-Id: <1d1ad5692ee43d4fc2b3fd9d221331d30b36123f.1700502145.git.andreyknvl@google.com>
In-Reply-To: <cover.1700502145.git.andreyknvl@google.com>
References: <cover.1700502145.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Add stack_depot_put, a function that decrements the reference counter
on a stack record and removes it from the stack depot once the counter
reaches 0.

Internally, when removing a stack record, the function unlinks it from
the hash table bucket and returns to the freelist.

With this change, the users of stack depot can call stack_depot_put
when keeping a stack trace in the stack depot is not needed anymore.
This allows avoiding polluting the stack depot with irrelevant stack
traces and thus have more space to store the relevant ones before the
stack depot reaches its capacity.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v1->v2:
- Comments fixes as suggested by Marco.
- Add lockdep_assert annotation.
- Adapt to using list_head's.
- Rename stack_depot_evict to stack_depot_put.
---
 include/linux/stackdepot.h | 14 ++++++++++++++
 lib/stackdepot.c           | 37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index 611716702d73..a6796f178913 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -97,6 +97,8 @@ static inline int stack_depot_early_init(void)	{ return 0; }
  *
  * If STACK_DEPOT_FLAG_GET is set in @depot_flags, stack depot will increment
  * the refcount on the saved stack trace if it already exists in stack depot.
+ * Users of this flag must also call stack_depot_put() when keeping the stack
+ * trace is no longer required to avoid overflowing the refcount.
  *
  * If the provided stack trace comes from the interrupt context, only the part
  * up to the interrupt entry is saved.
@@ -162,6 +164,18 @@ void stack_depot_print(depot_stack_handle_t stack);
 int stack_depot_snprint(depot_stack_handle_t handle, char *buf, size_t size,
 		       int spaces);
 
+/**
+ * stack_depot_put - Drop a reference to a stack trace from stack depot
+ *
+ * @handle:	Stack depot handle returned from stack_depot_save()
+ *
+ * The stack trace is evicted from stack depot once all references to it have
+ * been dropped (once the number of stack_depot_evict() calls matches the
+ * number of stack_depot_save_flags() calls with STACK_DEPOT_FLAG_GET set for
+ * this stack trace).
+ */
+void stack_depot_put(depot_stack_handle_t handle);
+
 /**
  * stack_depot_set_extra_bits - Set extra bits in a stack depot handle
  *
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 911dee11bf39..c1b31160f4b4 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -394,7 +394,7 @@ static struct stack_record *depot_fetch_stack(depot_stack_handle_t handle)
 	size_t offset = parts.offset << DEPOT_STACK_ALIGN;
 	struct stack_record *stack;
 
-	lockdep_assert_held_read(&pool_rwlock);
+	lockdep_assert_held(&pool_rwlock);
 
 	if (parts.pool_index > pools_num) {
 		WARN(1, "pool index %d out of bounds (%d) for stack id %08x\n",
@@ -410,6 +410,14 @@ static struct stack_record *depot_fetch_stack(depot_stack_handle_t handle)
 	return stack;
 }
 
+/* Links stack into the freelist. */
+static void depot_free_stack(struct stack_record *stack)
+{
+	lockdep_assert_held_write(&pool_rwlock);
+
+	list_add(&stack->list, &free_stacks);
+}
+
 /* Calculates the hash for a stack. */
 static inline u32 hash_stack(unsigned long *entries, unsigned int size)
 {
@@ -592,6 +600,33 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 }
 EXPORT_SYMBOL_GPL(stack_depot_fetch);
 
+void stack_depot_put(depot_stack_handle_t handle)
+{
+	struct stack_record *stack;
+	unsigned long flags;
+
+	if (!handle || stack_depot_disabled)
+		return;
+
+	write_lock_irqsave(&pool_rwlock, flags);
+
+	stack = depot_fetch_stack(handle);
+	if (WARN_ON(!stack))
+		goto out;
+
+	if (refcount_dec_and_test(&stack->count)) {
+		/* Unlink stack from the hash table. */
+		list_del(&stack->list);
+
+		/* Free stack. */
+		depot_free_stack(stack);
+	}
+
+out:
+	write_unlock_irqrestore(&pool_rwlock, flags);
+}
+EXPORT_SYMBOL_GPL(stack_depot_put);
+
 void stack_depot_print(depot_stack_handle_t stack)
 {
 	unsigned long *entries;
-- 
2.25.1

