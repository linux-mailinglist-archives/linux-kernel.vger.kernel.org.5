Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E36680118E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378882AbjLARXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378848AbjLARXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:23:12 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC719133
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:22:56 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5c6260b60b1so853635a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701451376; x=1702056176; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2XMLjsKVgFXDqbwClm2y57AnQEwkfKvfWDrmnLFGLG8=;
        b=eBQr1aPIZXGNHT7h4sEwbpN07MxFgzwojyCMmEJo3ZsiltTwwdsccZaKay4e4itWAa
         5fh0n9jQV4BKlcaWoTD1j0rdrjqUXp2q43cuqt1109jWyz8RqB6i7oVlnDJ/177jnzjn
         txuRmdLGF7Mfka/2PaQv+B/osSdFvILbO+EPOBrk1mI+syNlCiWL2d8L/SCxDQqjqAQ/
         dWWLvUb7vbs2+wZvZ+09tRu4eiAUlLjyTBd0/cFyeAqbtmTxjI4Dd96VyWj9V7f89U77
         X99XCNEYRfGi5sI2XKoLKEvI84pPsjSiJFSJx0yBlYyq8rqrle3mSvkT/yCAF9A5aBYl
         DBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451376; x=1702056176;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2XMLjsKVgFXDqbwClm2y57AnQEwkfKvfWDrmnLFGLG8=;
        b=R2YCK7bkImDikoZhMxvYfpYA9Ph84BBzyhmJwqF5xUgFEdJ6BGDbbQviHAY7LWi5Wh
         W+Ek0C18Kz1GTjGGq2n+eXpq8IW+8R8+v0xi45lM1uHot48HekzkBlhMK1HLvi3pByDP
         YfOYx992UNjFM8U3eqgXORf8/ctEuEzfOb7dHplqMhiitWsi5IzHoaImFgVZdJib+6MZ
         1vpJAvzFxct/ioIEoi751nGlE8fRcux37WSeGSCDIXzLS677L7Qrwf25q00xnRQ2InDS
         XQwBgLNJC7KHqSaf9NP1zvE1wHiHkMjlbInbcePmKpEYRwPoqhrdNyHqJNXH6XxCXspr
         Ysgg==
X-Gm-Message-State: AOJu0YzLhi00wYl6JuwAww5nq8J577JkxHRi4NTts0gKT95iLNfV5+Ug
        y0DtrIF518G/EQFcRFwemmAHROhR8DoU2Q==
X-Google-Smtp-Source: AGHT+IE4FVte1zRulBliJ0XtXfb1AjnqxtEwpYk4kH/odOXTIM8TwtL4QRAn1Z2CLNkxFNDtFxieVMuPbAzmZw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a65:6785:0:b0:5c6:2ae2:8284 with SMTP id
 e5-20020a656785000000b005c62ae28284mr568923pgr.7.1701451375983; Fri, 01 Dec
 2023 09:22:55 -0800 (PST)
Date:   Fri,  1 Dec 2023 17:21:39 +0000
In-Reply-To: <20231201172212.1813387-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201172212.1813387-11-cmllamas@google.com>
Subject: [PATCH v2 10/28] binder: split up binder_update_page_range()
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

The binder_update_page_range() function performs both allocation and
freeing of binder pages. However, these two operations are unrelated and
have no common logic. In fact, when a free operation is requested, the
allocation logic is skipped entirely. This behavior makes the error path
unnecessarily complex. To improve readability of the code, this patch
splits the allocation and freeing operations into separate functions.

No functional changes are introduced by this patch.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 79 +++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 39 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 179b67a3ef70..3051ea7ca44f 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -175,8 +175,32 @@ struct binder_buffer *binder_alloc_prepare_to_free(struct binder_alloc *alloc,
 	return buffer;
 }
 
-static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
-				    unsigned long start, unsigned long end)
+static void binder_free_page_range(struct binder_alloc *alloc,
+				   unsigned long start, unsigned long end)
+{
+	struct binder_lru_page *page;
+	unsigned long page_addr;
+
+	trace_binder_update_page_range(alloc, false, start, end);
+
+	for (page_addr = start; page_addr < end; page_addr += PAGE_SIZE) {
+		size_t index;
+		int ret;
+
+		index = (page_addr - alloc->buffer) / PAGE_SIZE;
+		page = &alloc->pages[index];
+
+		trace_binder_free_lru_start(alloc, index);
+
+		ret = list_lru_add(&binder_alloc_lru, &page->lru);
+		WARN_ON(!ret);
+
+		trace_binder_free_lru_end(alloc, index);
+	}
+}
+
+static int binder_allocate_page_range(struct binder_alloc *alloc,
+				      unsigned long start, unsigned long end)
 {
 	struct vm_area_struct *vma = NULL;
 	struct binder_lru_page *page;
@@ -185,16 +209,13 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 	bool need_mm = false;
 
 	binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
-			   "%d: %s allocate pages %lx-%lx\n", alloc->pid,
-			   allocate ? "allocate" : "free", start, end);
+			   "%d: allocate pages %lx-%lx\n",
+			   alloc->pid, start, end);
 
 	if (end <= start)
 		return 0;
 
-	trace_binder_update_page_range(alloc, allocate, start, end);
-
-	if (allocate == 0)
-		goto free_range;
+	trace_binder_update_page_range(alloc, true, start, end);
 
 	for (page_addr = start; page_addr < end; page_addr += PAGE_SIZE) {
 		page = &alloc->pages[(page_addr - alloc->buffer) / PAGE_SIZE];
@@ -270,32 +291,12 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 	}
 	return 0;
 
-free_range:
-	for (page_addr = end - PAGE_SIZE; 1; page_addr -= PAGE_SIZE) {
-		bool ret;
-		size_t index;
-
-		index = (page_addr - alloc->buffer) / PAGE_SIZE;
-		page = &alloc->pages[index];
-
-		trace_binder_free_lru_start(alloc, index);
-
-		ret = list_lru_add(&binder_alloc_lru, &page->lru);
-		WARN_ON(!ret);
-
-		trace_binder_free_lru_end(alloc, index);
-		if (page_addr == start)
-			break;
-		continue;
-
 err_vm_insert_page_failed:
-		__free_page(page->page_ptr);
-		page->page_ptr = NULL;
+	__free_page(page->page_ptr);
+	page->page_ptr = NULL;
 err_alloc_page_failed:
 err_page_ptr_cleared:
-		if (page_addr == start)
-			break;
-	}
+	binder_free_page_range(alloc, start, page_addr);
 err_no_vma:
 	if (mm) {
 		mmap_write_unlock(mm);
@@ -477,8 +478,8 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	end_page_addr = PAGE_ALIGN(buffer->user_data + size);
 	if (end_page_addr > has_page_addr)
 		end_page_addr = has_page_addr;
-	ret = binder_update_page_range(alloc, 1, PAGE_ALIGN(buffer->user_data),
-				       end_page_addr);
+	ret = binder_allocate_page_range(alloc, PAGE_ALIGN(buffer->user_data),
+					 end_page_addr);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -529,8 +530,8 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	return buffer;
 
 err_alloc_buf_struct_failed:
-	binder_update_page_range(alloc, 0, PAGE_ALIGN(buffer->user_data),
-				 end_page_addr);
+	binder_free_page_range(alloc, PAGE_ALIGN(buffer->user_data),
+			       end_page_addr);
 	return ERR_PTR(-ENOMEM);
 }
 
@@ -618,8 +619,8 @@ static void binder_delete_free_buffer(struct binder_alloc *alloc,
 				   alloc->pid, buffer->user_data,
 				   prev->user_data,
 				   next ? next->user_data : 0);
-		binder_update_page_range(alloc, 0, buffer_start_page(buffer),
-					 buffer_start_page(buffer) + PAGE_SIZE);
+		binder_free_page_range(alloc, buffer_start_page(buffer),
+				       buffer_start_page(buffer) + PAGE_SIZE);
 	}
 	list_del(&buffer->entry);
 	kfree(buffer);
@@ -653,8 +654,8 @@ static void binder_free_buf_locked(struct binder_alloc *alloc,
 			      alloc->pid, size, alloc->free_async_space);
 	}
 
-	binder_update_page_range(alloc, 0, PAGE_ALIGN(buffer->user_data),
-				 (buffer->user_data + buffer_size) & PAGE_MASK);
+	binder_free_page_range(alloc, PAGE_ALIGN(buffer->user_data),
+			       (buffer->user_data + buffer_size) & PAGE_MASK);
 
 	rb_erase(&buffer->rb_node, &alloc->allocated_buffers);
 	buffer->free = 1;
-- 
2.43.0.rc2.451.g8631bc7472-goog

