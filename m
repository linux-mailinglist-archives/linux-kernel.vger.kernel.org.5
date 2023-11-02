Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B417DFA96
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377478AbjKBTC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377541AbjKBTBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:01:43 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780C5170B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 12:01:19 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5b83d8797f4so952225a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 12:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698951679; x=1699556479; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yUF1AZKVVP6LqOTIChRtZA9igU/wihbCWdNulvRi5Ls=;
        b=w813XxkAQXGUaLi/OobMCk0dpNHWzAVPKTYCf/SVEZG++VZXpD45n6s3YAumLSoFI+
         3O/mBJrmTW7wv04QVa1hwaRsm+KrworGuzv8C2rl8JdhLUFjZXfGz7AfoYRDUnzGsF6r
         X48AOsqPuZjsYPAe84AhEqnDHCwYSfZK3eEqMvCA7pIlxrMTNdW2dEhf1BK9TFOiQVrE
         JSrhsYR5KU7nURupb01dAEbzABjqUXcgdmh4pbTpJxN6I/qHWwHhMSHHlkIJOjlJ2ZXW
         KJ7hLUY5zdLqoWF+xHVjQXDprUyFS47w0xDOY1UFsP1Zdo2OyxeyfiqJMigUuR7wnAFt
         zXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698951679; x=1699556479;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yUF1AZKVVP6LqOTIChRtZA9igU/wihbCWdNulvRi5Ls=;
        b=C+RofXLNd+arXvM4pWoFiEeyUG7Gl/bWOUqm/ncbVALF4+mYE3fI81muftFTRNjJvf
         tDQ4o5f+771F1XknDghAPjCubmNFGwTBTFau7Uy74jBW1ohAoT7T1PJ/zDyFTqBct582
         ukyoOmuwng08ykLVnCmgsVwSnMLVW9AKYe4LIFK/N++6pAF1o/W/2Wnvuhz/W4LFPCpK
         Jenqv+kaDDNzDPqmKl9kNAPG7cm0PtNdwpnQUamzYjyzKL8ibeX9J+1YUAgbWQiRq/gK
         DXmCzWBAoRxaS0gg3fnXBRvg8hSSF2yQL9zKBxZ/Wr4yLTiUUqRQiiZN+0fo+oQ4Z0Wz
         lsmA==
X-Gm-Message-State: AOJu0Yzay+d0qNgjTyy+Ann5RqIMpeSKR3G8csykV0INgAecdlyhLnbH
        0ynJzMdvcGNtsMczYPEX99LwiJ0X3i5luw==
X-Google-Smtp-Source: AGHT+IH9B4hSOu6ISNcCOgf2Ysk5A8Ch9UGul1UF9BzhjZdOsW5BcLk+7LhFLaqL28kpOYIRQt2ZkUBSj/JRCw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a63:4106:0:b0:5bd:3e1c:c163 with SMTP id
 o6-20020a634106000000b005bd3e1cc163mr14672pga.1.1698951678188; Thu, 02 Nov
 2023 12:01:18 -0700 (PDT)
Date:   Thu,  2 Nov 2023 18:59:22 +0000
In-Reply-To: <20231102185934.773885-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-1-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231102185934.773885-22-cmllamas@google.com>
Subject: [PATCH 21/21] binder: switch alloc->mutex to spinlock_t
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com
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
and it sleeps, it becomes difficult for the task to wakeup and complete
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

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 44 +++++++++++++++++-----------------
 drivers/android/binder_alloc.h | 10 ++++----
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 0ba9f524e0ff..a8a3e91ba308 100644
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
 
@@ -572,9 +572,9 @@ struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 	/* Pad 0-size buffers so they get assigned unique addresses */
 	size = max(size, sizeof(void *));
 
-	mutex_lock(&alloc->mutex);
+	spin_lock(&alloc->lock);
 	buffer = binder_alloc_new_buf_locked(alloc, next, size, is_async);
-	mutex_unlock(&alloc->mutex);
+	spin_unlock(&alloc->lock);
 
 	if (IS_ERR(buffer))
 		goto out;
@@ -786,17 +786,17 @@ void binder_alloc_free_buf(struct binder_alloc *alloc,
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
 	binder_free_buf_locked(alloc, buffer, true);
-	mutex_unlock(&alloc->mutex);
+	spin_unlock(&alloc->lock);
 }
 
 /**
@@ -894,7 +894,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 	struct binder_buffer *buffer;
 
 	buffers = 0;
-	mutex_lock(&alloc->mutex);
+	spin_lock(&alloc->lock);
 	BUG_ON(alloc->vma);
 
 	while ((n = rb_first(&alloc->allocated_buffers))) {
@@ -944,7 +944,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 		}
 		kfree(alloc->pages);
 	}
-	mutex_unlock(&alloc->mutex);
+	spin_unlock(&alloc->lock);
 	if (alloc->mm)
 		mmdrop(alloc->mm);
 
@@ -976,11 +976,11 @@ void binder_alloc_print_allocated(struct seq_file *m,
 {
 	struct rb_node *n;
 
-	mutex_lock(&alloc->mutex);
+	spin_lock(&alloc->lock);
 	for (n = rb_first(&alloc->allocated_buffers); n != NULL; n = rb_next(n))
 		print_binder_buffer(m, "  buffer",
 				    rb_entry(n, struct binder_buffer, rb_node));
-	mutex_unlock(&alloc->mutex);
+	spin_unlock(&alloc->lock);
 }
 
 /**
@@ -997,7 +997,7 @@ void binder_alloc_print_pages(struct seq_file *m,
 	int lru = 0;
 	int free = 0;
 
-	mutex_lock(&alloc->mutex);
+	spin_lock(&alloc->lock);
 	/*
 	 * Make sure the binder_alloc is fully initialized, otherwise we might
 	 * read inconsistent state.
@@ -1013,7 +1013,7 @@ void binder_alloc_print_pages(struct seq_file *m,
 				lru++;
 		}
 	}
-	mutex_unlock(&alloc->mutex);
+	spin_unlock(&alloc->lock);
 	seq_printf(m, "  pages: %d:%d:%d\n", active, lru, free);
 	seq_printf(m, "  pages high watermark: %zu\n", alloc->pages_high);
 }
@@ -1029,10 +1029,10 @@ int binder_alloc_get_allocated_count(struct binder_alloc *alloc)
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
 
@@ -1076,8 +1076,8 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 		goto err_mmget;
 	if (!mmap_read_trylock(mm))
 		goto err_mmap_read_lock_failed;
-	if (!mutex_trylock(&alloc->mutex))
-		goto err_get_alloc_mutex_failed;
+	if (!spin_trylock(&alloc->lock))
+		goto err_get_alloc_lock_failed;
 	if (!page->page_ptr)
 		goto err_page_already_freed;
 
@@ -1096,7 +1096,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	trace_binder_unmap_kernel_end(alloc, index);
 
 	list_lru_isolate(lru, item);
-	mutex_unlock(&alloc->mutex);
+	spin_unlock(&alloc->lock);
 	spin_unlock(lock);
 
 	if (vma) {
@@ -1115,8 +1115,8 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 
 err_invalid_vma:
 err_page_already_freed:
-	mutex_unlock(&alloc->mutex);
-err_get_alloc_mutex_failed:
+	spin_unlock(&alloc->lock);
+err_get_alloc_lock_failed:
 	mmap_read_unlock(mm);
 err_mmap_read_lock_failed:
 	mmput_async(mm);
@@ -1155,7 +1155,7 @@ void binder_alloc_init(struct binder_alloc *alloc)
 	alloc->pid = current->group_leader->pid;
 	alloc->mm = current->mm;
 	mmgrab(alloc->mm);
-	mutex_init(&alloc->mutex);
+	spin_lock_init(&alloc->lock);
 	INIT_LIST_HEAD(&alloc->buffers);
 }
 
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index bbc16bc6d5ac..3602a60d9609 100644
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
2.42.0.869.gea05f2083d-goog

