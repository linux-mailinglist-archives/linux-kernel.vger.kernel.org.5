Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE86880118D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379239AbjLARXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379032AbjLARXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:23:12 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AE91BFA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:22:54 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5bd0c909c50so797374a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701451374; x=1702056174; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mr4OhTiqHpGNgYjitUpNCCDYPirQbtCaNhKyh/2uPU4=;
        b=bex+ubm1pICsDV98xxlfdvnrjidJRFtx/yGHOaGw/EeWyu23Edz3O4E5/r4JKdFbtf
         9hZvFT8GFnlglQ+tZsYuCHWJSkf3x95E79qqReWezxteQFcWmyfWfVreKJQLJkwspH8d
         bpVZX7Y8L5Rc+cRcjIakYYxAEmrODmJxE6oC4xLWebNw5EwW4VoULC+ChNM122i9krAP
         wkWIxQ0qo9vSEZMwFfw9md4QHbR/7sIWEUXkZ4rkGME6Ag4Umd3mnOkRd58KjdA0dBTV
         EunuPYrIAGEVAwbB0pwaSWquP8HD0sVrnnBwRwpMyxZgHGlYfVogyAmz0rP1P5tFqoZ3
         5FFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451374; x=1702056174;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mr4OhTiqHpGNgYjitUpNCCDYPirQbtCaNhKyh/2uPU4=;
        b=SC2gD0ZFUNtzMMJ7sDLcthX4kfpciOGc8+txU4D8Uy+7m/TH6TNPqVNsDz2ZGv+ITw
         DexlUF49zhEKbJw+JNMEgDOiPcv6KLOHjrdh2P+kKT2LnzSXCHT0qor0lRIq/r80+2mV
         iUOFGN+L3bhqWJnJ2pE4DL3xcC1tOkoOboNANozubHpC25nBNCGp9S0rmK6DokAI4N4q
         rFgiFUoBmjbnvR4S6wGulmrGddYXrbd7K4QLR1V4DeEGYkSSTZbzy8swiTiw9n5AxRxo
         JqtJVE8rNBajGHzJrbRIzFDzrYllWf0WqghczLubJQSFYvP+WJY6W1xG/tXNm2cyDHw8
         8GMw==
X-Gm-Message-State: AOJu0YwAAvqE2F/LTtsjJArhCX5T2zxzDdOdZYvojlIa08sHpVvlTipk
        RYdwfr7B0jQOboUhnjLdQScJhqQTc+e9bQ==
X-Google-Smtp-Source: AGHT+IHmm4ogvk2wXuAdJX9Ak9tZV7nkmdmZl2+yHiZupXlUFTo/9FO+QGtKbJAMMwiGhGdH57P1EEFw8vAYlQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a63:a1e:0:b0:5c1:8ec:cbee with SMTP id
 30-20020a630a1e000000b005c108eccbeemr3930658pgk.2.1701451373833; Fri, 01 Dec
 2023 09:22:53 -0800 (PST)
Date:   Fri,  1 Dec 2023 17:21:38 +0000
In-Reply-To: <20231201172212.1813387-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201172212.1813387-10-cmllamas@google.com>
Subject: [PATCH v2 09/28] binder: keep vma addresses type as unsigned long
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

The vma addresses in binder are currently stored as void __user *. This
requires casting back and forth between the mm/ api which uses unsigned
long. Since we also do internal arithmetic on these addresses we end up
having to cast them _again_ to an integer type.

Lets stop all the unnecessary casting which kills code readability and
store the virtual addresses as the native unsigned long from mm/. Note
that this approach is preferred over uintptr_t as Linus explains in [1].

Opportunistically add a few cosmetic touchups.

Link: https://lore.kernel.org/all/CAHk-=wj2OHy-5e+srG1fy+ZU00TmZ1NFp6kFLbVLMXHe7A1d-g@mail.gmail.com/ [1]
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c                | 21 +++---
 drivers/android/binder_alloc.c          | 91 +++++++++++--------------
 drivers/android/binder_alloc.h          |  6 +-
 drivers/android/binder_alloc_selftest.c |  6 +-
 drivers/android/binder_trace.h          |  2 +-
 5 files changed, 57 insertions(+), 69 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 71a40a4c546f..437d1097b118 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2077,9 +2077,8 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 			 * Convert the address to an offset relative to
 			 * the base of the transaction buffer.
 			 */
-			fda_offset =
-			    (parent->buffer - (uintptr_t)buffer->user_data) +
-			    fda->parent_offset;
+			fda_offset = parent->buffer - buffer->user_data +
+				fda->parent_offset;
 			for (fd_index = 0; fd_index < fda->num_fds;
 			     fd_index++) {
 				u32 fd;
@@ -2597,7 +2596,7 @@ static int binder_translate_fd_array(struct list_head *pf_head,
 	 * Convert the address to an offset relative to
 	 * the base of the transaction buffer.
 	 */
-	fda_offset = (parent->buffer - (uintptr_t)t->buffer->user_data) +
+	fda_offset = parent->buffer - t->buffer->user_data +
 		fda->parent_offset;
 	sender_ufda_base = (void __user *)(uintptr_t)sender_uparent->buffer +
 				fda->parent_offset;
@@ -2672,8 +2671,9 @@ static int binder_fixup_parent(struct list_head *pf_head,
 				  proc->pid, thread->pid);
 		return -EINVAL;
 	}
-	buffer_offset = bp->parent_offset +
-			(uintptr_t)parent->buffer - (uintptr_t)b->user_data;
+
+	buffer_offset = bp->parent_offset + parent->buffer - b->user_data;
+
 	return binder_add_fixup(pf_head, buffer_offset, bp->buffer, 0);
 }
 
@@ -3250,7 +3250,7 @@ static void binder_transaction(struct binder_proc *proc,
 				    ALIGN(extra_buffers_size, sizeof(void *)) -
 				    ALIGN(secctx_sz, sizeof(u64));
 
-		t->security_ctx = (uintptr_t)t->buffer->user_data + buf_offset;
+		t->security_ctx = t->buffer->user_data + buf_offset;
 		err = binder_alloc_copy_to_buffer(&target_proc->alloc,
 						  t->buffer, buf_offset,
 						  secctx, secctx_sz);
@@ -3527,8 +3527,7 @@ static void binder_transaction(struct binder_proc *proc,
 				goto err_translate_failed;
 			}
 			/* Fixup buffer pointer to target proc address space */
-			bp->buffer = (uintptr_t)
-				t->buffer->user_data + sg_buf_offset;
+			bp->buffer = t->buffer->user_data + sg_buf_offset;
 			sg_buf_offset += ALIGN(bp->length, sizeof(u64));
 
 			num_valid = (buffer_offset - off_start_offset) /
@@ -4698,7 +4697,7 @@ static int binder_thread_read(struct binder_proc *proc,
 		}
 		trd->data_size = t->buffer->data_size;
 		trd->offsets_size = t->buffer->offsets_size;
-		trd->data.ptr.buffer = (uintptr_t)t->buffer->user_data;
+		trd->data.ptr.buffer = t->buffer->user_data;
 		trd->data.ptr.offsets = trd->data.ptr.buffer +
 					ALIGN(t->buffer->data_size,
 					    sizeof(void *));
@@ -5981,7 +5980,7 @@ static void print_binder_transaction_ilocked(struct seq_file *m,
 	}
 	if (buffer->target_node)
 		seq_printf(m, " node %d", buffer->target_node->debug_id);
-	seq_printf(m, " size %zd:%zd data %pK\n",
+	seq_printf(m, " size %zd:%zd data %lx\n",
 		   buffer->data_size, buffer->offsets_size,
 		   buffer->user_data);
 }
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index a56cbfd9ba44..179b67a3ef70 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -125,23 +125,20 @@ static void binder_insert_allocated_buffer_locked(
 
 static struct binder_buffer *binder_alloc_prepare_to_free_locked(
 		struct binder_alloc *alloc,
-		uintptr_t user_ptr)
+		unsigned long user_ptr)
 {
 	struct rb_node *n = alloc->allocated_buffers.rb_node;
 	struct binder_buffer *buffer;
-	void __user *uptr;
-
-	uptr = (void __user *)user_ptr;
 
 	while (n) {
 		buffer = rb_entry(n, struct binder_buffer, rb_node);
 		BUG_ON(buffer->free);
 
-		if (uptr < buffer->user_data)
+		if (user_ptr < buffer->user_data) {
 			n = n->rb_left;
-		else if (uptr > buffer->user_data)
+		} else if (user_ptr > buffer->user_data) {
 			n = n->rb_right;
-		else {
+		} else {
 			/*
 			 * Guard against user threads attempting to
 			 * free the buffer when in use by kernel or
@@ -168,7 +165,7 @@ static struct binder_buffer *binder_alloc_prepare_to_free_locked(
  * Return:	Pointer to buffer or NULL
  */
 struct binder_buffer *binder_alloc_prepare_to_free(struct binder_alloc *alloc,
-						   uintptr_t user_ptr)
+						   unsigned long user_ptr)
 {
 	struct binder_buffer *buffer;
 
@@ -179,18 +176,17 @@ struct binder_buffer *binder_alloc_prepare_to_free(struct binder_alloc *alloc,
 }
 
 static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
-				    void __user *start, void __user *end)
+				    unsigned long start, unsigned long end)
 {
-	void __user *page_addr;
-	unsigned long user_page_addr;
-	struct binder_lru_page *page;
 	struct vm_area_struct *vma = NULL;
+	struct binder_lru_page *page;
 	struct mm_struct *mm = NULL;
+	unsigned long page_addr;
 	bool need_mm = false;
 
 	binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
-		     "%d: %s pages %pK-%pK\n", alloc->pid,
-		     allocate ? "allocate" : "free", start, end);
+			   "%d: %s allocate pages %lx-%lx\n", alloc->pid,
+			   allocate ? "allocate" : "free", start, end);
 
 	if (end <= start)
 		return 0;
@@ -249,18 +245,17 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 					    __GFP_HIGHMEM |
 					    __GFP_ZERO);
 		if (!page->page_ptr) {
-			pr_err("%d: binder_alloc_buf failed for page at %pK\n",
-				alloc->pid, page_addr);
+			pr_err("%d: binder_alloc_buf failed for page at %lx\n",
+			       alloc->pid, page_addr);
 			goto err_alloc_page_failed;
 		}
 		page->alloc = alloc;
 		INIT_LIST_HEAD(&page->lru);
 
-		user_page_addr = (uintptr_t)page_addr;
-		ret = vm_insert_page(vma, user_page_addr, page[0].page_ptr);
+		ret = vm_insert_page(vma, page_addr, page->page_ptr);
 		if (ret) {
 			pr_err("%d: binder_alloc_buf failed to map page at %lx in userspace\n",
-			       alloc->pid, user_page_addr);
+			       alloc->pid, page_addr);
 			goto err_vm_insert_page_failed;
 		}
 
@@ -377,9 +372,9 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	struct binder_buffer *buffer;
 	size_t buffer_size;
 	struct rb_node *best_fit = NULL;
-	void __user *has_page_addr;
-	void __user *end_page_addr;
 	size_t size, data_offsets_size;
+	unsigned long has_page_addr;
+	unsigned long end_page_addr;
 	int ret;
 
 	/* Check binder_alloc is fully initialized */
@@ -477,15 +472,13 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 		     "%d: binder_alloc_buf size %zd got buffer %pK size %zd\n",
 		      alloc->pid, size, buffer, buffer_size);
 
-	has_page_addr = (void __user *)
-		(((uintptr_t)buffer->user_data + buffer_size) & PAGE_MASK);
+	has_page_addr = (buffer->user_data + buffer_size) & PAGE_MASK;
 	WARN_ON(n && buffer_size != size);
-	end_page_addr =
-		(void __user *)PAGE_ALIGN((uintptr_t)buffer->user_data + size);
+	end_page_addr = PAGE_ALIGN(buffer->user_data + size);
 	if (end_page_addr > has_page_addr)
 		end_page_addr = has_page_addr;
-	ret = binder_update_page_range(alloc, 1, (void __user *)
-		PAGE_ALIGN((uintptr_t)buffer->user_data), end_page_addr);
+	ret = binder_update_page_range(alloc, 1, PAGE_ALIGN(buffer->user_data),
+				       end_page_addr);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -498,7 +491,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 			       __func__, alloc->pid);
 			goto err_alloc_buf_struct_failed;
 		}
-		new_buffer->user_data = (u8 __user *)buffer->user_data + size;
+		new_buffer->user_data = buffer->user_data + size;
 		list_add(&new_buffer->entry, &buffer->entry);
 		new_buffer->free = 1;
 		binder_insert_free_buffer(alloc, new_buffer);
@@ -536,8 +529,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	return buffer;
 
 err_alloc_buf_struct_failed:
-	binder_update_page_range(alloc, 0, (void __user *)
-				 PAGE_ALIGN((uintptr_t)buffer->user_data),
+	binder_update_page_range(alloc, 0, PAGE_ALIGN(buffer->user_data),
 				 end_page_addr);
 	return ERR_PTR(-ENOMEM);
 }
@@ -574,15 +566,14 @@ struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 	return buffer;
 }
 
-static void __user *buffer_start_page(struct binder_buffer *buffer)
+static unsigned long buffer_start_page(struct binder_buffer *buffer)
 {
-	return (void __user *)((uintptr_t)buffer->user_data & PAGE_MASK);
+	return buffer->user_data & PAGE_MASK;
 }
 
-static void __user *prev_buffer_end_page(struct binder_buffer *buffer)
+static unsigned long prev_buffer_end_page(struct binder_buffer *buffer)
 {
-	return (void __user *)
-		(((uintptr_t)(buffer->user_data) - 1) & PAGE_MASK);
+	return (buffer->user_data - 1) & PAGE_MASK;
 }
 
 static void binder_delete_free_buffer(struct binder_alloc *alloc,
@@ -597,7 +588,7 @@ static void binder_delete_free_buffer(struct binder_alloc *alloc,
 	if (prev_buffer_end_page(prev) == buffer_start_page(buffer)) {
 		to_free = false;
 		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
-				   "%d: merge free, buffer %pK share page with %pK\n",
+				   "%d: merge free, buffer %lx share page with %lx\n",
 				   alloc->pid, buffer->user_data,
 				   prev->user_data);
 	}
@@ -607,7 +598,7 @@ static void binder_delete_free_buffer(struct binder_alloc *alloc,
 		if (buffer_start_page(next) == buffer_start_page(buffer)) {
 			to_free = false;
 			binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
-					   "%d: merge free, buffer %pK share page with %pK\n",
+					   "%d: merge free, buffer %lx share page with %lx\n",
 					   alloc->pid,
 					   buffer->user_data,
 					   next->user_data);
@@ -616,17 +607,17 @@ static void binder_delete_free_buffer(struct binder_alloc *alloc,
 
 	if (PAGE_ALIGNED(buffer->user_data)) {
 		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
-				   "%d: merge free, buffer start %pK is page aligned\n",
+				   "%d: merge free, buffer start %lx is page aligned\n",
 				   alloc->pid, buffer->user_data);
 		to_free = false;
 	}
 
 	if (to_free) {
 		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
-				   "%d: merge free, buffer %pK do not share page with %pK or %pK\n",
+				   "%d: merge free, buffer %lx do not share page with %lx or %lx\n",
 				   alloc->pid, buffer->user_data,
 				   prev->user_data,
-				   next ? next->user_data : NULL);
+				   next ? next->user_data : 0);
 		binder_update_page_range(alloc, 0, buffer_start_page(buffer),
 					 buffer_start_page(buffer) + PAGE_SIZE);
 	}
@@ -662,10 +653,8 @@ static void binder_free_buf_locked(struct binder_alloc *alloc,
 			      alloc->pid, size, alloc->free_async_space);
 	}
 
-	binder_update_page_range(alloc, 0,
-		(void __user *)PAGE_ALIGN((uintptr_t)buffer->user_data),
-		(void __user *)(((uintptr_t)
-			  buffer->user_data + buffer_size) & PAGE_MASK));
+	binder_update_page_range(alloc, 0, PAGE_ALIGN(buffer->user_data),
+				 (buffer->user_data + buffer_size) & PAGE_MASK);
 
 	rb_erase(&buffer->rb_node, &alloc->allocated_buffers);
 	buffer->free = 1;
@@ -754,7 +743,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 				   SZ_4M);
 	mutex_unlock(&binder_alloc_mmap_lock);
 
-	alloc->buffer = (void __user *)vma->vm_start;
+	alloc->buffer = vma->vm_start;
 
 	alloc->pages = kcalloc(alloc->buffer_size / PAGE_SIZE,
 			       sizeof(alloc->pages[0]),
@@ -787,7 +776,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 	kfree(alloc->pages);
 	alloc->pages = NULL;
 err_alloc_pages_failed:
-	alloc->buffer = NULL;
+	alloc->buffer = 0;
 	mutex_lock(&binder_alloc_mmap_lock);
 	alloc->buffer_size = 0;
 err_already_mapped:
@@ -840,7 +829,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 		int i;
 
 		for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
-			void __user *page_addr;
+			unsigned long page_addr;
 			bool on_lru;
 
 			if (!alloc->pages[i].page_ptr)
@@ -850,7 +839,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 					      &alloc->pages[i].lru);
 			page_addr = alloc->buffer + i * PAGE_SIZE;
 			binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
-				     "%s: %d: page %d at %pK %s\n",
+				     "%s: %d: page %d at %lx %s\n",
 				     __func__, alloc->pid, i, page_addr,
 				     on_lru ? "on lru" : "active");
 			__free_page(alloc->pages[i].page_ptr);
@@ -870,7 +859,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 static void print_binder_buffer(struct seq_file *m, const char *prefix,
 				struct binder_buffer *buffer)
 {
-	seq_printf(m, "%s %d: %pK size %zd:%zd:%zd %s\n",
+	seq_printf(m, "%s %d: %lx size %zd:%zd:%zd %s\n",
 		   prefix, buffer->debug_id, buffer->user_data,
 		   buffer->data_size, buffer->offsets_size,
 		   buffer->extra_buffers_size,
@@ -984,7 +973,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 						    struct binder_lru_page,
 						    lru);
 	struct binder_alloc *alloc;
-	uintptr_t page_addr;
+	unsigned long page_addr;
 	size_t index;
 	struct vm_area_struct *vma;
 
@@ -996,7 +985,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 		goto err_page_already_freed;
 
 	index = page - alloc->pages;
-	page_addr = (uintptr_t)alloc->buffer + index * PAGE_SIZE;
+	page_addr = alloc->buffer + index * PAGE_SIZE;
 
 	mm = alloc->mm;
 	if (!mmget_not_zero(mm))
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index 82380febdd85..cb19677a5c15 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -56,7 +56,7 @@ struct binder_buffer {
 	size_t data_size;
 	size_t offsets_size;
 	size_t extra_buffers_size;
-	void __user *user_data;
+	unsigned long user_data;
 	int    pid;
 };
 
@@ -101,7 +101,7 @@ struct binder_alloc {
 	struct mutex mutex;
 	struct vm_area_struct *vma;
 	struct mm_struct *mm;
-	void __user *buffer;
+	unsigned long buffer;
 	struct list_head buffers;
 	struct rb_root free_buffers;
 	struct rb_root allocated_buffers;
@@ -133,7 +133,7 @@ void binder_alloc_shrinker_exit(void);
 void binder_alloc_vma_close(struct binder_alloc *alloc);
 struct binder_buffer *
 binder_alloc_prepare_to_free(struct binder_alloc *alloc,
-			     uintptr_t user_ptr);
+			     unsigned long user_ptr);
 void binder_alloc_free_buf(struct binder_alloc *alloc,
 			   struct binder_buffer *buffer);
 int binder_alloc_mmap_handler(struct binder_alloc *alloc,
diff --git a/drivers/android/binder_alloc_selftest.c b/drivers/android/binder_alloc_selftest.c
index c2b323bc3b3a..341c73b4a807 100644
--- a/drivers/android/binder_alloc_selftest.c
+++ b/drivers/android/binder_alloc_selftest.c
@@ -93,11 +93,11 @@ static bool check_buffer_pages_allocated(struct binder_alloc *alloc,
 					 struct binder_buffer *buffer,
 					 size_t size)
 {
-	void __user *page_addr;
-	void __user *end;
+	unsigned long page_addr;
+	unsigned long end;
 	int page_index;
 
-	end = (void __user *)PAGE_ALIGN((uintptr_t)buffer->user_data + size);
+	end = PAGE_ALIGN(buffer->user_data + size);
 	page_addr = buffer->user_data;
 	for (; page_addr < end; page_addr += PAGE_SIZE) {
 		page_index = (page_addr - alloc->buffer) / PAGE_SIZE;
diff --git a/drivers/android/binder_trace.h b/drivers/android/binder_trace.h
index 8cc07e6a4273..fe38c6fc65d0 100644
--- a/drivers/android/binder_trace.h
+++ b/drivers/android/binder_trace.h
@@ -317,7 +317,7 @@ DEFINE_EVENT(binder_buffer_class, binder_transaction_update_buffer_release,
 
 TRACE_EVENT(binder_update_page_range,
 	TP_PROTO(struct binder_alloc *alloc, bool allocate,
-		 void __user *start, void __user *end),
+		 unsigned long start, unsigned long end),
 	TP_ARGS(alloc, allocate, start, end),
 	TP_STRUCT__entry(
 		__field(int, proc)
-- 
2.43.0.rc2.451.g8631bc7472-goog

