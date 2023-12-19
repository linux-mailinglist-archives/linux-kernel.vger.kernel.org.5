Return-Path: <linux-kernel+bounces-5960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED7E81922C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844C21C220C0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5FC3E49E;
	Tue, 19 Dec 2023 21:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IR+Whe6+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B0B3D0A2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 21:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703020798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IugD6msAA76PLOkulY8RL+cRtUx1nL2a5VcYM7ZPFvs=;
	b=IR+Whe6+qpxv+At+vArbXY01tYtvfspW3PKw8UAncGDGnEEps0UIMWhP+wPzEx5NxY9M8h
	m1TDVtQZm9HrpXOj1mV5z/Lc+HwiQjOjMkmc/bfj2auMjP1/9llRH/NH6L89Gq+qP7zEz3
	M7vUVsknaJSSv98tDJGKvpfbqCVOHN0=
From: andrey.konovalov@linux.dev
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	kasan-dev@googlegroups.com,
	Evgenii Stepanov <eugenis@google.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>,
	syzbot+186b55175d8360728234@syzkaller.appspotmail.com
Subject: [PATCH v3 mm 2/4] kasan: handle concurrent kasan_record_aux_stack calls
Date: Tue, 19 Dec 2023 22:19:51 +0100
Message-Id: <1606b960e2f746862d1f459515972f9695bf448a.1703020707.git.andreyknvl@google.com>
In-Reply-To: <cover.1703020707.git.andreyknvl@google.com>
References: <cover.1703020707.git.andreyknvl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@google.com>

kasan_record_aux_stack can be called concurrently on the same object.
This might lead to a race condition when rotating the saved aux stack
trace handles, which in turns leads to incorrect accounting of stack
depot handles and refcount underflows in the stack depot code.

Fix by introducing a raw spinlock to protect the aux stack trace handles
in kasan_record_aux_stack.

Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Reported-by: syzbot+186b55175d8360728234@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000784b1c060b0074a2@google.com/
Fixes: 773688a6cb24 ("kasan: use stack_depot_put for Generic mode")
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v2->v3:
- Use raw spinlock to avoid lockdep complaints on RT kernels.

Changes v1->v2:
- Use per-object spinlock instead of a global one.
---
 mm/kasan/generic.c | 32 +++++++++++++++++++++++++++++---
 mm/kasan/kasan.h   |  8 ++++++++
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 54e20b2bc3e1..55e6b5db2cae 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -25,6 +25,7 @@
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/stackdepot.h>
 #include <linux/stacktrace.h>
 #include <linux/string.h>
@@ -471,8 +472,18 @@ void kasan_init_object_meta(struct kmem_cache *cache, const void *object)
 	struct kasan_free_meta *free_meta;
 
 	alloc_meta = kasan_get_alloc_meta(cache, object);
-	if (alloc_meta)
+	if (alloc_meta) {
 		__memset(alloc_meta, 0, sizeof(*alloc_meta));
+
+		/*
+		 * Temporarily disable KASAN bug reporting to allow instrumented
+		 * raw_spin_lock_init to access aux_lock, which resides inside
+		 * of a redzone.
+		 */
+		kasan_disable_current();
+		raw_spin_lock_init(&alloc_meta->aux_lock);
+		kasan_enable_current();
+	}
 	free_meta = kasan_get_free_meta(cache, object);
 	if (free_meta)
 		__memset(free_meta, 0, sizeof(*free_meta));
@@ -502,6 +513,8 @@ static void __kasan_record_aux_stack(void *addr, depot_flags_t depot_flags)
 	struct kmem_cache *cache;
 	struct kasan_alloc_meta *alloc_meta;
 	void *object;
+	depot_stack_handle_t new_handle, old_handle;
+	unsigned long flags;
 
 	if (is_kfence_address(addr) || !slab)
 		return;
@@ -512,9 +525,22 @@ static void __kasan_record_aux_stack(void *addr, depot_flags_t depot_flags)
 	if (!alloc_meta)
 		return;
 
-	stack_depot_put(alloc_meta->aux_stack[1]);
+	new_handle = kasan_save_stack(0, depot_flags);
+
+	/*
+	 * Temporarily disable KASAN bug reporting to allow instrumented
+	 * spinlock functions to access aux_lock, which resides inside of a
+	 * redzone.
+	 */
+	kasan_disable_current();
+	raw_spin_lock_irqsave(&alloc_meta->aux_lock, flags);
+	old_handle = alloc_meta->aux_stack[1];
 	alloc_meta->aux_stack[1] = alloc_meta->aux_stack[0];
-	alloc_meta->aux_stack[0] = kasan_save_stack(0, depot_flags);
+	alloc_meta->aux_stack[0] = new_handle;
+	raw_spin_unlock_irqrestore(&alloc_meta->aux_lock, flags);
+	kasan_enable_current();
+
+	stack_depot_put(old_handle);
 }
 
 void kasan_record_aux_stack(void *addr)
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 5e298e3ac909..69e4f5e58e33 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -6,6 +6,7 @@
 #include <linux/kasan.h>
 #include <linux/kasan-tags.h>
 #include <linux/kfence.h>
+#include <linux/spinlock.h>
 #include <linux/stackdepot.h>
 
 #if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
@@ -249,6 +250,13 @@ struct kasan_global {
 struct kasan_alloc_meta {
 	struct kasan_track alloc_track;
 	/* Free track is stored in kasan_free_meta. */
+	/*
+	 * aux_lock protects aux_stack from accesses from concurrent
+	 * kasan_record_aux_stack calls. It is a raw spinlock to avoid sleeping
+	 * on RT kernels, as kasan_record_aux_stack_noalloc can be called from
+	 * non-sleepable contexts.
+	 */
+	raw_spinlock_t aux_lock;
 	depot_stack_handle_t aux_stack[2];
 };
 
-- 
2.25.1


