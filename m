Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5027F79F040
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjIMRRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjIMRRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:17:15 -0400
Received: from out-220.mta1.migadu.com (out-220.mta1.migadu.com [IPv6:2001:41d0:203:375::dc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422D72685
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:17:04 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694625422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P7zzoSFiMvzmGoSw/qnaD/dTzTEPv955C3ixzUuxzB0=;
        b=dUDWfm9GQJCwXn5Ns2lo8cMMrhaO+r45+sngvwNP0vGullsCgE1WTcWwBv1boZZKILIxby
        Iwf95QD/YaEE0XqYwS1ZkwuDWLFwJogmyau0zsHzueAIHLAi5uTqqsd2dYHi8ddYBLSeuh
        ZXP72m6TnkiIFBuVA1VHgbYB3a0DFuM=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 17/19] kasan: remove atomic accesses to stack ring entries
Date:   Wed, 13 Sep 2023 19:14:42 +0200
Message-Id: <556085476eb7d2e3703d62dc2fa920931aadf459.1694625260.git.andreyknvl@google.com>
In-Reply-To: <cover.1694625260.git.andreyknvl@google.com>
References: <cover.1694625260.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Remove the atomic accesses to entry fields in save_stack_info and
kasan_complete_mode_report_info for tag-based KASAN modes.

These atomics are not required, as the read/write lock prevents the
entries from being read (in kasan_complete_mode_report_info) while being
written (in save_stack_info) and the try_cmpxchg prevents the same entry
from being rewritten (in save_stack_info) in the unlikely case of wrapping
during writing.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v1->v2:
- This is a new patch.
---
 mm/kasan/report_tags.c | 25 +++++++------------------
 mm/kasan/tags.c        | 13 +++++--------
 2 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
index 8b8bfdb3cfdb..78abdcde5da9 100644
--- a/mm/kasan/report_tags.c
+++ b/mm/kasan/report_tags.c
@@ -31,10 +31,6 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
 	unsigned long flags;
 	u64 pos;
 	struct kasan_stack_ring_entry *entry;
-	void *ptr;
-	u32 pid;
-	depot_stack_handle_t stack;
-	bool is_free;
 	bool alloc_found = false, free_found = false;
 
 	if ((!info->cache || !info->object) && !info->bug_type) {
@@ -61,18 +57,11 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
 
 		entry = &stack_ring.entries[i % stack_ring.size];
 
-		/* Paired with smp_store_release() in save_stack_info(). */
-		ptr = (void *)smp_load_acquire(&entry->ptr);
-
-		if (kasan_reset_tag(ptr) != info->object ||
-		    get_tag(ptr) != get_tag(info->access_addr))
+		if (kasan_reset_tag(entry->ptr) != info->object ||
+		    get_tag(entry->ptr) != get_tag(info->access_addr))
 			continue;
 
-		pid = READ_ONCE(entry->pid);
-		stack = READ_ONCE(entry->stack);
-		is_free = READ_ONCE(entry->is_free);
-
-		if (is_free) {
+		if (entry->is_free) {
 			/*
 			 * Second free of the same object.
 			 * Give up on trying to find the alloc entry.
@@ -80,8 +69,8 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
 			if (free_found)
 				break;
 
-			info->free_track.pid = pid;
-			info->free_track.stack = stack;
+			info->free_track.pid = entry->pid;
+			info->free_track.stack = entry->stack;
 			free_found = true;
 
 			/*
@@ -95,8 +84,8 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
 			if (alloc_found)
 				break;
 
-			info->alloc_track.pid = pid;
-			info->alloc_track.stack = stack;
+			info->alloc_track.pid = entry->pid;
+			info->alloc_track.stack = entry->stack;
 			alloc_found = true;
 
 			/*
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index 4fd32121b0fd..b6c017e670d8 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -121,15 +121,12 @@ static void save_stack_info(struct kmem_cache *cache, void *object,
 	if (!try_cmpxchg(&entry->ptr, &old_ptr, STACK_RING_BUSY_PTR))
 		goto next; /* Busy slot. */
 
-	WRITE_ONCE(entry->size, cache->object_size);
-	WRITE_ONCE(entry->pid, current->pid);
-	WRITE_ONCE(entry->stack, stack);
-	WRITE_ONCE(entry->is_free, is_free);
+	entry->size = cache->object_size;
+	entry->pid = current->pid;
+	entry->stack = stack;
+	entry->is_free = is_free;
 
-	/*
-	 * Paired with smp_load_acquire() in kasan_complete_mode_report_info().
-	 */
-	smp_store_release(&entry->ptr, (s64)object);
+	entry->ptr = object;
 
 	read_unlock_irqrestore(&stack_ring.lock, flags);
 }
-- 
2.25.1

