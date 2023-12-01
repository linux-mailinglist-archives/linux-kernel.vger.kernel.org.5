Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E728011A2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379032AbjLARZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379432AbjLARYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:24:40 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F79B2D75
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:23:37 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d3911218b3so26215777b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701451417; x=1702056217; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rsven0GeNIdTKJEEiBvOK7Cfq3DMyu3RbsA4BcvpV2Q=;
        b=17LWgAy3eOqkVIjGuxZoP11bLErBXW+TCBF8Si+JE4wQoSJ1GMNtIc+GLnELR3Wsmg
         LuE3RlzPQrc5uWTJ05ngoq/+wYhm4nZj7Cvw58fJdvshgZOa9t03TfURxd7OD8D9QuE9
         NbZqypZefdMd9DNE6oCfrowpWIvciOLY4A6ECVFx7SPpJSpr3Q3Lv6vNgQjwTJyXmD6c
         RHJQgip7QhQuCaDls/LaFqoTTP+4ZBOFyZH5sES9PNqfIAYc/duRgnpEeWYc1aiEQEVz
         C64AcQHSNXX0NSlzSHJKQJh1MEavT3G8+QBrjBgm+moqLZxy0IqN2P0zewGpww7/1OJs
         ECKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451417; x=1702056217;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rsven0GeNIdTKJEEiBvOK7Cfq3DMyu3RbsA4BcvpV2Q=;
        b=NGS+UsXvrzeW5HdVszSp0NfxUuMR+SBwq/I96284DjcaWaGhtQcXxHi6PhnuCTRDTc
         LJGEOVJseM0l+dgGdmcEH0XE3/TH/nUsDcqzuDwGg8Xq73arhm2risCL6ujKMqtW71TP
         kE2UU9hs9Uj9fKvf7ZneZWNVLZXDxNUnVbUM3Af2PMIRX9jZDmgBQ0NLn3klnxgU/XZg
         +bZ8ggrpivQ3JUReNpBMHwTCstJ1ze7iQacPf71eMQO/lJMXopfasKd828gdcavGV5Wq
         3iC3XlHhyLZ7XyN6sXHG9cwSbv5l733LxP3kM/XMRgNayEAgs/5U3uMlGJIXUUb8iKms
         5Ahw==
X-Gm-Message-State: AOJu0YyESpu1rouSTYhVJdy39PVskpnnYAGXOKtsTpyCTfBwe2Iv6F5n
        xSP2+LiNPI9r1GeJCKpJaez+Tjur+btlYg==
X-Google-Smtp-Source: AGHT+IFiO56NR6qyv9H4F3ld5HJ5Ncel4BXcp57KDrfw5XjelSj7Q3XDGwuONh1wAwx47qIBS/rSNP9GQPY5ow==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:690c:fcd:b0:5ca:fef:82a4 with SMTP id
 dg13-20020a05690c0fcd00b005ca0fef82a4mr962453ywb.4.1701451417060; Fri, 01 Dec
 2023 09:23:37 -0800 (PST)
Date:   Fri,  1 Dec 2023 17:21:57 +0000
In-Reply-To: <20231201172212.1813387-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201172212.1813387-29-cmllamas@google.com>
Subject: [PATCH v2 28/28] binder: switch alloc->mutex to spinlock_t
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The alloc->mutex is a highly contended lock that causes performance
issues on Android devices. When a low-priority task is given this lock
and it sleeps, it becomes difficult for the task to wake up and complete
its work. This delays other tasks that are also waiting on the mutex.

The problem gets worse when there is memory pressure in the system,
because this increases the contention on the alloc->mutex while the
shrinker reclaims binder pages.

Switching to a spinlock helps to keep the waiters running and avoids the
overhead of waking up tasks. This significantly improves the transaction
latency when the problematic scenario occurs.

The performance impact of this patchset was measured by stress-testing
the binder alloc contention. In this test, several clients of different
priorities send thousands of transactions of different sizes to a single
server. In parallel, pages get reclaimed using the shinker's debugfs.

The test was run on a Pixel 8, Pixel 6 and qemu machine. The results
were similar on all three devices:

after:
  | sched  | prio | average | max       | min     |
  |--------+------+---------+-----------+---------|
  | fifo   |   99 | 0.135ms |   1.197ms | 0.022ms |
  | fifo   |   01 | 0.136ms |   5.232ms | 0.018ms |
  | other  |  -20 | 0.180ms |   7.403ms | 0.019ms |
  | other  |   19 | 0.241ms |  58.094ms | 0.018ms |

before:
  | sched  | prio | average | max       | min     |
  |--------+------+---------+-----------+---------|
  | fifo   |   99 | 0.350ms | 248.730ms | 0.020ms |
  | fifo   |   01 | 0.357ms | 248.817ms | 0.024ms |
  | other  |  -20 | 0.399ms | 249.906ms | 0.020ms |
  | other  |   19 | 0.477ms | 297.756ms | 0.022ms |

The key metrics above are the average and max latencies (wall time).
These improvements should roughly translate to p95-p99 latencies on real
workloads. The response time is up to 200x faster in these scenarios and
there is no penalty in the regular path.

Note that it is only possible to convert this lock after a series of
changes made by previous patches. These mainly include refactoring the
sections that might_sleep() and changing the locking order with the
mmap_lock amongst others.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 46 +++++++++++++++++-----------------
 drivers/android/binder_alloc.h | 10 ++++----
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index a3e56637db4f..a4a4dc87ba53 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -169,9 +169,9 @@ struct binder_buffer *binder_alloc_prepare_to_free(struct binder_alloc *alloc,
 {
 	struct binder_buffer *buffer;
 
-	mutex_lock(&alloc->mutex);
+	spin_lock(&alloc->lock);
 	buffer = binder_alloc_prepare_to_free_locked(alloc, user_ptr);
-	mutex_unlock(&alloc->mutex);
+	spin_unlock(&alloc->lock);
 	return buffer;
 }
 
@@ -597,10 +597,10 @@ struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 	if (!next)
 		return ERR_PTR(-ENOMEM);
 
-	mutex_lock(&alloc->mutex);
+	spin_lock(&alloc->lock);
 	buffer = binder_alloc_new_buf_locked(alloc, next, size, is_async);
 	if (IS_ERR(buffer)) {
-		mutex_unlock(&alloc->mutex);
+		spin_unlock(&alloc->lock);
 		goto out;
 	}
 
@@ -608,7 +608,7 @@ struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 	buffer->offsets_size = offsets_size;
 	buffer->extra_buffers_size = extra_buffers_size;
 	buffer->pid = current->tgid;
-	mutex_unlock(&alloc->mutex);
+	spin_unlock(&alloc->lock);
 
 	ret = binder_install_buffer_pages(alloc, buffer, size);
 	if (ret) {
@@ -785,17 +785,17 @@ void binder_alloc_free_buf(struct binder_alloc *alloc,
 	 * We could eliminate the call to binder_alloc_clear_buf()
 	 * from binder_alloc_deferred_release() by moving this to
 	 * binder_free_buf_locked(). However, that could
-	 * increase contention for the alloc mutex if clear_on_free
-	 * is used frequently for large buffers. The mutex is not
+	 * increase contention for the alloc->lock if clear_on_free
+	 * is used frequently for large buffers. This lock is not
 	 * needed for correctness here.
 	 */
 	if (buffer->clear_on_free) {
 		binder_alloc_clear_buf(alloc, buffer);
 		buffer->clear_on_free = false;
 	}
-	mutex_lock(&alloc->mutex);
+	spin_lock(&alloc->lock);
 	binder_free_buf_locked(alloc, buffer);
-	mutex_unlock(&alloc->mutex);
+	spin_unlock(&alloc->lock);
 }
 
 /**
@@ -893,7 +893,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 	struct binder_buffer *buffer;
 
 	buffers = 0;
-	mutex_lock(&alloc->mutex);
+	spin_lock(&alloc->lock);
 	BUG_ON(alloc->vma);
 
 	while ((n = rb_first(&alloc->allocated_buffers))) {
@@ -943,7 +943,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 		}
 		kfree(alloc->pages);
 	}
-	mutex_unlock(&alloc->mutex);
+	spin_unlock(&alloc->lock);
 	if (alloc->mm)
 		mmdrop(alloc->mm);
 
@@ -966,7 +966,7 @@ void binder_alloc_print_allocated(struct seq_file *m,
 	struct binder_buffer *buffer;
 	struct rb_node *n;
 
-	mutex_lock(&alloc->mutex);
+	spin_lock(&alloc->lock);
 	for (n = rb_first(&alloc->allocated_buffers); n; n = rb_next(n)) {
 		buffer = rb_entry(n, struct binder_buffer, rb_node);
 		seq_printf(m, "  buffer %d: %lx size %zd:%zd:%zd %s\n",
@@ -976,7 +976,7 @@ void binder_alloc_print_allocated(struct seq_file *m,
 			   buffer->extra_buffers_size,
 			   buffer->transaction ? "active" : "delivered");
 	}
-	mutex_unlock(&alloc->mutex);
+	spin_unlock(&alloc->lock);
 }
 
 /**
@@ -993,7 +993,7 @@ void binder_alloc_print_pages(struct seq_file *m,
 	int lru = 0;
 	int free = 0;
 
-	mutex_lock(&alloc->mutex);
+	spin_lock(&alloc->lock);
 	/*
 	 * Make sure the binder_alloc is fully initialized, otherwise we might
 	 * read inconsistent state.
@@ -1009,7 +1009,7 @@ void binder_alloc_print_pages(struct seq_file *m,
 				lru++;
 		}
 	}
-	mutex_unlock(&alloc->mutex);
+	spin_unlock(&alloc->lock);
 	seq_printf(m, "  pages: %d:%d:%d\n", active, lru, free);
 	seq_printf(m, "  pages high watermark: %zu\n", alloc->pages_high);
 }
@@ -1025,10 +1025,10 @@ int binder_alloc_get_allocated_count(struct binder_alloc *alloc)
 	struct rb_node *n;
 	int count = 0;
 
-	mutex_lock(&alloc->mutex);
+	spin_lock(&alloc->lock);
 	for (n = rb_first(&alloc->allocated_buffers); n != NULL; n = rb_next(n))
 		count++;
-	mutex_unlock(&alloc->mutex);
+	spin_unlock(&alloc->lock);
 	return count;
 }
 
@@ -1073,8 +1073,8 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 		goto err_mmget;
 	if (!mmap_read_trylock(mm))
 		goto err_mmap_read_lock_failed;
-	if (!mutex_trylock(&alloc->mutex))
-		goto err_get_alloc_mutex_failed;
+	if (!spin_trylock(&alloc->lock))
+		goto err_get_alloc_lock_failed;
 	if (!page->page_ptr)
 		goto err_page_already_freed;
 
@@ -1093,7 +1093,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	trace_binder_unmap_kernel_end(alloc, index);
 
 	list_lru_isolate(lru, item);
-	mutex_unlock(&alloc->mutex);
+	spin_unlock(&alloc->lock);
 	spin_unlock(lock);
 
 	if (vma) {
@@ -1113,8 +1113,8 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 
 err_invalid_vma:
 err_page_already_freed:
-	mutex_unlock(&alloc->mutex);
-err_get_alloc_mutex_failed:
+	spin_unlock(&alloc->lock);
+err_get_alloc_lock_failed:
 	mmap_read_unlock(mm);
 err_mmap_read_lock_failed:
 	mmput_async(mm);
@@ -1149,7 +1149,7 @@ void binder_alloc_init(struct binder_alloc *alloc)
 	alloc->pid = current->group_leader->pid;
 	alloc->mm = current->mm;
 	mmgrab(alloc->mm);
-	mutex_init(&alloc->mutex);
+	spin_lock_init(&alloc->lock);
 	INIT_LIST_HEAD(&alloc->buffers);
 }
 
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index a5181916942e..70387234477e 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -9,7 +9,7 @@
 #include <linux/rbtree.h>
 #include <linux/list.h>
 #include <linux/mm.h>
-#include <linux/rtmutex.h>
+#include <linux/spinlock.h>
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
 #include <linux/list_lru.h>
@@ -72,7 +72,7 @@ struct binder_lru_page {
 
 /**
  * struct binder_alloc - per-binder proc state for binder allocator
- * @mutex:              protects binder_alloc fields
+ * @lock:               protects binder_alloc fields
  * @vma:                vm_area_struct passed to mmap_handler
  *                      (invariant after mmap)
  * @mm:                 copy of task->mm (invariant after open)
@@ -96,7 +96,7 @@ struct binder_lru_page {
  * struct binder_buffer objects used to track the user buffers
  */
 struct binder_alloc {
-	struct mutex mutex;
+	spinlock_t lock;
 	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 	unsigned long buffer;
@@ -153,9 +153,9 @@ binder_alloc_get_free_async_space(struct binder_alloc *alloc)
 {
 	size_t free_async_space;
 
-	mutex_lock(&alloc->mutex);
+	spin_lock(&alloc->lock);
 	free_async_space = alloc->free_async_space;
-	mutex_unlock(&alloc->mutex);
+	spin_unlock(&alloc->lock);
 	return free_async_space;
 }
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

