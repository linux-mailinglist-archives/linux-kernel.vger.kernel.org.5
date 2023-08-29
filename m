Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BB678CA7D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237728AbjH2ROx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236139AbjH2ROb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:14:31 -0400
Received: from out-243.mta1.migadu.com (out-243.mta1.migadu.com [IPv6:2001:41d0:203:375::f3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167D510CC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:13:57 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693329224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c+OqyPrsOPGHg5XrLPNZBNE7kZ+J8BEkGBD6zb/JuYQ=;
        b=T1iG7qQWFqXknvW3oxV4ppqhlGJ2B4GzTHDs5oEMMGMfeCMjQjH9IJfBalbYfv0NVvUDzy
        EwkpyMnG6Nxt+AMl/9tnMXZ4f/nw+qGm5hpPJdpaKfCfaWqaErDfKrIusJZnN6iT+BpvCJ
        ObS/4jb3NCEUDuj8JPJ9Tc91Spi4dxo=
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
Subject: [PATCH 14/15] stackdepot: allow users to evict stack traces
Date:   Tue, 29 Aug 2023 19:11:24 +0200
Message-Id: <99cd7ac4a312e86c768b933332364272b9e3fb40.1693328501.git.andreyknvl@google.com>
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

Add stack_depot_evict, a function that decrements a reference counter
on a stack record and removes it from the stack depot once the counter
reaches 0.

Internally, when removing a stack record, the function unlinks it from
the hash table bucket and returns to the freelist.

With this change, the users of stack depot can call stack_depot_evict
when keeping a stack trace in the stack depot is not needed anymore.
This allows avoiding polluting the stack depot with irrelevant stack
traces and thus have more space to store the relevant ones before the
stack depot reaches its capacity.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/stackdepot.h | 11 ++++++++++
 lib/stackdepot.c           | 43 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index e58306783d8e..b14da6797714 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -121,6 +121,17 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
 unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 			       unsigned long **entries);
 
+/**
+ * stack_depot_evict - Drop a reference to a stack trace from stack depot
+ *
+ * @handle:	Stack depot handle returned from stack_depot_save()
+ *
+ * The stack trace gets fully removed from stack depot once all references
+ * to it has been dropped (once the number of stack_depot_evict calls matches
+ * the number of stack_depot_save calls for this stack trace).
+ */
+void stack_depot_evict(depot_stack_handle_t handle);
+
 /**
  * stack_depot_print - Print a stack trace from stack depot
  *
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 641db97d8c7c..cf28720b842d 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -384,6 +384,13 @@ static struct stack_record *depot_fetch_stack(depot_stack_handle_t handle)
 	return stack;
 }
 
+/* Frees stack into the freelist. */
+static void depot_free_stack(struct stack_record *stack)
+{
+	stack->next = next_stack;
+	next_stack = stack;
+}
+
 /* Calculates the hash for a stack. */
 static inline u32 hash_stack(unsigned long *entries, unsigned int size)
 {
@@ -555,6 +562,42 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 }
 EXPORT_SYMBOL_GPL(stack_depot_fetch);
 
+void stack_depot_evict(depot_stack_handle_t handle)
+{
+	struct stack_record *stack, **bucket;
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
+		/* Drop stack from the hash table. */
+		if (stack->next)
+			stack->next->prev = stack->prev;
+		if (stack->prev)
+			stack->prev->next = stack->next;
+		else {
+			bucket = &stack_table[stack->hash & stack_hash_mask];
+			*bucket = stack->next;
+		}
+		stack->next = NULL;
+		stack->prev = NULL;
+
+		/* Free stack. */
+		depot_free_stack(stack);
+	}
+
+out:
+	write_unlock_irqrestore(&pool_rwlock, flags);
+}
+EXPORT_SYMBOL_GPL(stack_depot_evict);
+
 void stack_depot_print(depot_stack_handle_t stack)
 {
 	unsigned long *entries;
-- 
2.25.1

