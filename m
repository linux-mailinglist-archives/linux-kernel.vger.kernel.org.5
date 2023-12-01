Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DEA801190
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378986AbjLARXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378965AbjLARXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:23:16 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7894C2108
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:23:01 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1d03cf821e3so7831335ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701451381; x=1702056181; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=inWiD8g9m7hjb3UL8owrGWpVaFU0hU6mcS+3syWXoA8=;
        b=NF++6prFB/ujbJfXcWXaAtBevILWNK1DT+83GwA55Ki9l7oj4PEZy9JdSNe1yesv1v
         ErezM7nohAvIni+MweqeOoL1fTaJcLNa0G6IBHBiHGXNyHOnxqlO4mCJsJfcEERA3bHt
         FRFH59uFEldxbRzIUI3b99gBb6llq0I592H0nRUeYh5exRI4jsprUZrnXl57pL0qYDQ5
         F48sr0WtljZ/sz4+RPDcI5JhFtMLCHugZ56M/OZi1WNvDrCEkfjzKFpm5/CylB8WEtVC
         W0iP+uUODfoKNgAjiuVy0h+XIIu/UpNm3Pl+PNopMcM+UuAltCNMRSfhDmorx3BcWDbX
         5zGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451381; x=1702056181;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=inWiD8g9m7hjb3UL8owrGWpVaFU0hU6mcS+3syWXoA8=;
        b=WvcMumq1kZQEE1At9wF2T5H9jTNma5IPq7Rmawf9yima3CiSDwsZqQy8+XBTpoSc40
         BfZSuxioD0C6E6Y7vtdmquZ5gG49B7LW8boM5oDDmZ8qzyNCGN7YupTUQpAWUVIttWEJ
         cF+CQJoDo1vQAncY30BoNvM5gUCFftV20uwa5cidEz7q/2H+H0SMwVwqc47PZzh3mgNA
         oQ5Q+ak4sJGUUALZEI1Nr1uCzFU4b+Y3Wvj71B/Px0lstlK8+mGmXqysbCLe6Vzoc6WE
         Bf8WHeMPTGpiJlXzsu94ZY6JL4B1HskbZzRrEm7D26Zt+E4YGywvtwDcitzySYuOpNuK
         k8nQ==
X-Gm-Message-State: AOJu0Yy1npdGpCa4tkcYyOTTzs7ObagAarXmxlBrFg+eGCa6HlDs/ZLY
        kTaP2gx9Lkrpru5F7j0Zh/1dhMpDCa8sQQ==
X-Google-Smtp-Source: AGHT+IFeN0G8FLc9KsDnto8RPZ62PSnrYHWvXLh3HQsOpjVa/lNdjF1vgVSTaGjR/aG/M/ZzSmdV9vdVfkanjQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:903:2308:b0:1cc:454f:73dc with SMTP
 id d8-20020a170903230800b001cc454f73dcmr5489572plh.7.1701451380832; Fri, 01
 Dec 2023 09:23:00 -0800 (PST)
Date:   Fri,  1 Dec 2023 17:21:41 +0000
In-Reply-To: <20231201172212.1813387-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201172212.1813387-13-cmllamas@google.com>
Subject: [PATCH v2 12/28] binder: remove pid param in binder_alloc_new_buf()
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

Binder attributes the buffer allocation to the current->tgid everytime.
There is no need to pass this as a parameter so drop it.

Also add a few touchups to follow the coding guidelines. No functional
changes are introduced in this patch.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c                |  2 +-
 drivers/android/binder_alloc.c          | 18 ++++++++----------
 drivers/android/binder_alloc.h          |  7 ++-----
 drivers/android/binder_alloc_selftest.c |  2 +-
 4 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 437d1097b118..45674af6310f 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3225,7 +3225,7 @@ static void binder_transaction(struct binder_proc *proc,
 
 	t->buffer = binder_alloc_new_buf(&target_proc->alloc, tr->data_size,
 		tr->offsets_size, extra_buffers_size,
-		!reply && (t->flags & TF_ONE_WAY), current->tgid);
+		!reply && (t->flags & TF_ONE_WAY));
 	if (IS_ERR(t->buffer)) {
 		char *s;
 
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 40a2ca0c0dea..b5c3e56318e1 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -319,7 +319,7 @@ static inline struct vm_area_struct *binder_alloc_get_vma(
 	return smp_load_acquire(&alloc->vma);
 }
 
-static bool debug_low_async_space_locked(struct binder_alloc *alloc, int pid)
+static bool debug_low_async_space_locked(struct binder_alloc *alloc)
 {
 	/*
 	 * Find the amount and size of buffers allocated by the current caller;
@@ -328,10 +328,11 @@ static bool debug_low_async_space_locked(struct binder_alloc *alloc, int pid)
 	 * and at some point we'll catch them in the act. This is more efficient
 	 * than keeping a map per pid.
 	 */
-	struct rb_node *n;
 	struct binder_buffer *buffer;
 	size_t total_alloc_size = 0;
+	int pid = current->tgid;
 	size_t num_buffers = 0;
+	struct rb_node *n;
 
 	for (n = rb_first(&alloc->allocated_buffers); n != NULL;
 		 n = rb_next(n)) {
@@ -364,8 +365,7 @@ static bool debug_low_async_space_locked(struct binder_alloc *alloc, int pid)
 static struct binder_buffer *binder_alloc_new_buf_locked(
 				struct binder_alloc *alloc,
 				size_t size,
-				int is_async,
-				int pid)
+				int is_async)
 {
 	struct rb_node *n = alloc->free_buffers.rb_node;
 	struct binder_buffer *buffer;
@@ -476,7 +476,6 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 		     "%d: binder_alloc_buf size %zd got %pK\n",
 		      alloc->pid, size, buffer);
 	buffer->async_transaction = is_async;
-	buffer->pid = pid;
 	buffer->oneway_spam_suspect = false;
 	if (is_async) {
 		alloc->free_async_space -= size;
@@ -489,7 +488,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 			 * of async space left (which is less than 10% of total
 			 * buffer size).
 			 */
-			buffer->oneway_spam_suspect = debug_low_async_space_locked(alloc, pid);
+			buffer->oneway_spam_suspect = debug_low_async_space_locked(alloc);
 		} else {
 			alloc->oneway_spam_detected = false;
 		}
@@ -532,7 +531,6 @@ static inline size_t sanitized_size(size_t data_size,
  * @offsets_size:       user specified buffer offset
  * @extra_buffers_size: size of extra space for meta-data (eg, security context)
  * @is_async:           buffer for async transaction
- * @pid:				pid to attribute allocation to (used for debugging)
  *
  * Allocate a new buffer given the requested sizes. Returns
  * the kernel version of the buffer pointer. The size allocated
@@ -545,8 +543,7 @@ struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 					   size_t data_size,
 					   size_t offsets_size,
 					   size_t extra_buffers_size,
-					   int is_async,
-					   int pid)
+					   int is_async)
 {
 	struct binder_buffer *buffer;
 	size_t size;
@@ -569,7 +566,7 @@ struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 	}
 
 	mutex_lock(&alloc->mutex);
-	buffer = binder_alloc_new_buf_locked(alloc, size, is_async, pid);
+	buffer = binder_alloc_new_buf_locked(alloc, size, is_async);
 	if (IS_ERR(buffer)) {
 		mutex_unlock(&alloc->mutex);
 		goto out;
@@ -578,6 +575,7 @@ struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 	buffer->data_size = data_size;
 	buffer->offsets_size = offsets_size;
 	buffer->extra_buffers_size = extra_buffers_size;
+	buffer->pid = current->tgid;
 	mutex_unlock(&alloc->mutex);
 
 out:
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index cb19677a5c15..bbc16bc6d5ac 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -49,15 +49,13 @@ struct binder_buffer {
 	unsigned async_transaction:1;
 	unsigned oneway_spam_suspect:1;
 	unsigned debug_id:27;
-
 	struct binder_transaction *transaction;
-
 	struct binder_node *target_node;
 	size_t data_size;
 	size_t offsets_size;
 	size_t extra_buffers_size;
 	unsigned long user_data;
-	int    pid;
+	int pid;
 };
 
 /**
@@ -125,8 +123,7 @@ struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 					   size_t data_size,
 					   size_t offsets_size,
 					   size_t extra_buffers_size,
-					   int is_async,
-					   int pid);
+					   int is_async);
 void binder_alloc_init(struct binder_alloc *alloc);
 int binder_alloc_shrinker_init(void);
 void binder_alloc_shrinker_exit(void);
diff --git a/drivers/android/binder_alloc_selftest.c b/drivers/android/binder_alloc_selftest.c
index 341c73b4a807..ed753747e54c 100644
--- a/drivers/android/binder_alloc_selftest.c
+++ b/drivers/android/binder_alloc_selftest.c
@@ -119,7 +119,7 @@ static void binder_selftest_alloc_buf(struct binder_alloc *alloc,
 	int i;
 
 	for (i = 0; i < BUFFER_NUM; i++) {
-		buffers[i] = binder_alloc_new_buf(alloc, sizes[i], 0, 0, 0, 0);
+		buffers[i] = binder_alloc_new_buf(alloc, sizes[i], 0, 0, 0);
 		if (IS_ERR(buffers[i]) ||
 		    !check_buffer_pages_allocated(alloc, buffers[i],
 						  sizes[i])) {
-- 
2.43.0.rc2.451.g8631bc7472-goog

