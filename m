Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647F87DFA89
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377466AbjKBTBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377414AbjKBTBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:01:04 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69FDD4B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 12:00:51 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5a08e5c7debso1021432a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 12:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698951650; x=1699556450; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KYYieItknPiCtxwCYKnjZi9BM7umY3rgkgJMMlAtQUw=;
        b=SFSWZvemkfN/YOyWDcEAnnhazzcitvuJ8PYSOGZ3ssSVuItpnsSLdYAeqKA01l4sMq
         4DQlfQNPPGpGDu6mdy3BSZ96H3mtuOy8Nl+LFDy9yHmUPMNCI9wKNAXXa9SVFrTolpUJ
         9KN76j8+QYeeN0+y60KXHcsjr0v1qhqafHcZDBxYPysIp6R8+WYOYvQ2mlGFeoJ5/4hf
         6p6bsxk4CARPh4m+K/uOQMPSKU7ympVRIcQfIEzETvOHYjPAlPWXMTngXmGKbeygX3zJ
         YMG67ZHHrKWnBWkajxWbBibtNc23qi336VS0mUMS/8uJ3z83L5LLEc9MR8krd12OHT2U
         okKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698951650; x=1699556450;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KYYieItknPiCtxwCYKnjZi9BM7umY3rgkgJMMlAtQUw=;
        b=rpFIeCDAe4voVNMHa9MkJTD+rb0N3zGUx+uUInyxgraYNFryErn+ivH/OVP8h/jq+z
         6/Qjx5ha1zDpPiB0cuxzdFmlDc/zuKHH+Z/4KJbmQpt8hlUkVtEi3RBQZtTMo0Ll2AzP
         lJTfUKeE07mpJviKfxUULPgCUSxY0EfLjbJokZeVjBrtVnD79Bazkt2YMP1lwF90u8+r
         c1ELyrQlaKkn5Ij2ULn59oSm0/tagwlJT42AQHap4zo5HvgwXTcb2pXQWaApkxeS0HYq
         FAnsNGlZh1ToYxXmOunJWTv5GyIAS2tRjHCM6Xq7fIJa+/Rq5xfUUUpCOC6LIKxSidIo
         EPtA==
X-Gm-Message-State: AOJu0YxWnCgo2BDioXZnQlvybNI701lZfvbELWRfpVPah7rAwM3o13jj
        QBO+8tS5eo2LJVyGB84UdmBUScaFCOPiWw==
X-Google-Smtp-Source: AGHT+IG+GyWie1dfPsL2P0v1sGINVnLZo59HsC3njKDqd6isVseRIudWw+EGB5GXKhFByuoPWjXf0a6ODiRu5A==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a63:154d:0:b0:5bd:39ba:ac0a with SMTP id
 13-20020a63154d000000b005bd39baac0amr28925pgv.2.1698951650435; Thu, 02 Nov
 2023 12:00:50 -0700 (PDT)
Date:   Thu,  2 Nov 2023 18:59:10 +0000
In-Reply-To: <20231102185934.773885-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-1-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231102185934.773885-10-cmllamas@google.com>
Subject: [PATCH 09/21] binder: split up binder_update_page_range()
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

The binder_update_page_range() function performs both allocation and
freeing of binder pages. However, these two operations are unrelated and
have no common logic. In fact, when a free operation is requested, the
allocation logic is skipped entirely. This behavior makes the error path
unnecessarily complex. To improve readability of the code, this patch
splits the allocation and freeing operations into separate functions.

No functional changes are introduced by this patch.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 83 ++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 39 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index b99d9845d69a..27c7163761c4 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -175,8 +175,36 @@ struct binder_buffer *binder_alloc_prepare_to_free(struct binder_alloc *alloc,
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
+	binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
+			   "%d: free pages %lx-%lx\n",
+			   alloc->pid, start, end);
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
@@ -185,16 +213,13 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
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
@@ -270,32 +295,12 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
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
@@ -479,8 +484,8 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	end_page_addr = PAGE_ALIGN(buffer->user_data + size);
 	if (end_page_addr > has_page_addr)
 		end_page_addr = has_page_addr;
-	ret = binder_update_page_range(alloc, 1, PAGE_ALIGN(buffer->user_data),
-				       end_page_addr);
+	ret = binder_allocate_page_range(alloc, PAGE_ALIGN(buffer->user_data),
+					 end_page_addr);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -531,8 +536,8 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	return buffer;
 
 err_alloc_buf_struct_failed:
-	binder_update_page_range(alloc, 0, PAGE_ALIGN(buffer->user_data),
-				 end_page_addr);
+	binder_free_page_range(alloc, PAGE_ALIGN(buffer->user_data),
+			       end_page_addr);
 	return ERR_PTR(-ENOMEM);
 }
 
@@ -620,8 +625,8 @@ static void binder_delete_free_buffer(struct binder_alloc *alloc,
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
@@ -656,8 +661,8 @@ static void binder_free_buf_locked(struct binder_alloc *alloc,
 			      alloc->pid, size, alloc->free_async_space);
 	}
 
-	binder_update_page_range(alloc, 0, PAGE_ALIGN(buffer->user_data),
-				 (buffer->user_data + buffer_size) & PAGE_MASK);
+	binder_free_page_range(alloc, PAGE_ALIGN(buffer->user_data),
+			       (buffer->user_data + buffer_size) & PAGE_MASK);
 
 	rb_erase(&buffer->rb_node, &alloc->allocated_buffers);
 	buffer->free = 1;
-- 
2.42.0.869.gea05f2083d-goog

