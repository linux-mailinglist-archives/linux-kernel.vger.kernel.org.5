Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8F280119A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379109AbjLARY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379101AbjLARX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:23:59 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227901BC1
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:23:18 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-28658658190so1093856a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701451396; x=1702056196; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CfJWTQsOxR7o7mIvZgIJKvNELDtD3CenccOUn7+igsE=;
        b=KgKcjPBkvozTZLGv5jAow7+twZkJWYG3Tyn5kq88Wmq8H34eAGKFVFF12e0gMX+7JV
         QmQ1IBJp9ItofKd/5Ac1Gc7DvSajeMjU5OyK86GcY2Lo35gJG9qHNs/njSuOESCRUjKu
         5EZeNmgmSvyBF7g1FBj/ouX1TeunhGgssd43fj8pZ/+5E+31DgVsRDeb1IzxC0ndXtnn
         TCz6TsdTBhbxpcV3lo1zN/oLkJSowpwEDKE7qZ+bWP2R0j7t3a0VNhDiqONR09xOeodE
         9XDPhm8Ul2fG1lXOkkIhuFaE57OZM8RpRVBML4racaD7o5cpz+7jFkf7NS4GGwTHzLvl
         rB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451396; x=1702056196;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CfJWTQsOxR7o7mIvZgIJKvNELDtD3CenccOUn7+igsE=;
        b=rvCqX3ks9kvSlRPhjXhsyTbJV6IdfvOMmMzg2vHzKSBvp7hos5izJ6zgfXF+/xveuz
         97lXYX/lvIFyL5DM8m9Rrhpq11k7IiPe+ft2xV5da9TMTxSwnKtNCxWXYp5om6vK+ICK
         pc5VSXxtePixzL8EiW3F+RHUh2Hs65wlVUU1bg6/9pfNodsgfqsNjjxSvhoUfmmee9KZ
         X2ya9O0Q0gj43KgC3akn1GJQF4Ltpfd4jhZIxDmzm4aUyWax4KnKtQHXhjhNR9ZUzduh
         bwmNhXK6dzU6DbHdsZbmBdyTG24uOHULIIdytHrh8wq59TYhpAQr0jNMFrA4Dyfe2b5a
         fbUA==
X-Gm-Message-State: AOJu0YwmXrL+UpaLSMD15PE+A184yVg6bQ+MejfcqB0EK2QSQcV4eUTB
        YXZzjrNGMNJy9pkjxZ6fbmH/6lwseYOe9w==
X-Google-Smtp-Source: AGHT+IGK0kTWPq4UBGVfIjjgEWqeKs0R57zUxrwjRnDbO7HWP7CnQGurqY17DNwHdMBtoLAsSIU20cxS36Im3Q==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:90a:ca90:b0:286:487f:22fb with SMTP
 id y16-20020a17090aca9000b00286487f22fbmr568688pjt.5.1701451396356; Fri, 01
 Dec 2023 09:23:16 -0800 (PST)
Date:   Fri,  1 Dec 2023 17:21:48 +0000
In-Reply-To: <20231201172212.1813387-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201172212.1813387-20-cmllamas@google.com>
Subject: [PATCH v2 19/28] binder: perform page installation outside of locks
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

Split out the insertion of pages to be outside of the alloc->mutex in a
separate binder_install_buffer_pages() routine. Since this is no longer
serialized, we must look at the full range of pages used by the buffers.
The installation is protected with mmap_sem in write mode since multiple
tasks might race to install the same page.

Besides avoiding unnecessary nested locking this helps in preparation of
switching the alloc->mutex into a spinlock_t in subsequent patches.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 101 ++++++++++++++++++++++++---------
 1 file changed, 73 insertions(+), 28 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 25efdbb2ad5d..551f08e84408 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -175,6 +175,21 @@ struct binder_buffer *binder_alloc_prepare_to_free(struct binder_alloc *alloc,
 	return buffer;
 }
 
+static inline void
+binder_set_installed_page(struct binder_lru_page *lru_page,
+			  struct page *page)
+{
+	/* Pairs with acquire in binder_get_installed_page() */
+	smp_store_release(&lru_page->page_ptr, page);
+}
+
+static inline struct page *
+binder_get_installed_page(struct binder_lru_page *lru_page)
+{
+	/* Pairs with release in binder_set_installed_page() */
+	return smp_load_acquire(&lru_page->page_ptr);
+}
+
 static void binder_free_page_range(struct binder_alloc *alloc,
 				   unsigned long start, unsigned long end)
 {
@@ -190,6 +205,9 @@ static void binder_free_page_range(struct binder_alloc *alloc,
 		index = (page_addr - alloc->buffer) / PAGE_SIZE;
 		page = &alloc->pages[index];
 
+		if (!binder_get_installed_page(page))
+			continue;
+
 		trace_binder_free_lru_start(alloc, index);
 
 		ret = list_lru_add(&binder_alloc_lru, &page->lru);
@@ -209,7 +227,14 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 	if (!mmget_not_zero(alloc->mm))
 		return -ESRCH;
 
+	/*
+	 * Protected with mmap_sem in write mode as multiple tasks
+	 * might race to install the same page.
+	 */
 	mmap_write_lock(alloc->mm);
+	if (binder_get_installed_page(lru_page))
+		goto out;
+
 	if (!alloc->vma) {
 		pr_err("%d: %s failed, no vma\n", alloc->pid, __func__);
 		ret = -ESRCH;
@@ -232,15 +257,50 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 		goto out;
 	}
 
-	lru_page->page_ptr = page;
+	/* Mark page installation complete and safe to use */
+	binder_set_installed_page(lru_page, page);
 out:
 	mmap_write_unlock(alloc->mm);
 	mmput_async(alloc->mm);
 	return ret;
 }
 
-static int binder_allocate_page_range(struct binder_alloc *alloc,
-				      unsigned long start, unsigned long end)
+static int binder_install_buffer_pages(struct binder_alloc *alloc,
+				       struct binder_buffer *buffer,
+				       size_t size)
+{
+	struct binder_lru_page *page;
+	unsigned long start, final;
+	unsigned long page_addr;
+
+	start = buffer->user_data & PAGE_MASK;
+	final = PAGE_ALIGN(buffer->user_data + size);
+
+	for (page_addr = start; page_addr < final; page_addr += PAGE_SIZE) {
+		unsigned long index;
+		int ret;
+
+		index = (page_addr - alloc->buffer) / PAGE_SIZE;
+		page = &alloc->pages[index];
+
+		if (binder_get_installed_page(page))
+			continue;
+
+		trace_binder_alloc_page_start(alloc, index);
+
+		ret = binder_install_single_page(alloc, page, page_addr);
+		if (ret)
+			return ret;
+
+		trace_binder_alloc_page_end(alloc, index);
+	}
+
+	return 0;
+}
+
+/* The range of pages should exclude those shared with other buffers */
+static void binder_allocate_page_range(struct binder_alloc *alloc,
+				       unsigned long start, unsigned long end)
 {
 	struct binder_lru_page *page;
 	unsigned long page_addr;
@@ -249,15 +309,11 @@ static int binder_allocate_page_range(struct binder_alloc *alloc,
 			   "%d: allocate pages %lx-%lx\n",
 			   alloc->pid, start, end);
 
-	if (end <= start)
-		return 0;
-
 	trace_binder_update_page_range(alloc, true, start, end);
 
 	for (page_addr = start; page_addr < end; page_addr += PAGE_SIZE) {
 		unsigned long index;
 		bool on_lru;
-		int ret;
 
 		index = (page_addr - alloc->buffer) / PAGE_SIZE;
 		page = &alloc->pages[index];
@@ -272,21 +328,9 @@ static int binder_allocate_page_range(struct binder_alloc *alloc,
 			continue;
 		}
 
-		trace_binder_alloc_page_start(alloc, index);
-
-		ret = binder_install_single_page(alloc, page, page_addr);
-		if (ret) {
-			binder_free_page_range(alloc, start, page_addr);
-			return ret;
-		}
-
 		if (index + 1 > alloc->pages_high)
 			alloc->pages_high = index + 1;
-
-		trace_binder_alloc_page_end(alloc, index);
 	}
-
-	return 0;
 }
 
 static inline void binder_alloc_set_vma(struct binder_alloc *alloc,
@@ -405,7 +449,6 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	unsigned long has_page_addr;
 	unsigned long end_page_addr;
 	size_t buffer_size;
-	int ret;
 
 	if (is_async && alloc->free_async_space < size) {
 		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
@@ -449,18 +492,14 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 		     "%d: binder_alloc_buf size %zd got buffer %pK size %zd\n",
 		      alloc->pid, size, buffer, buffer_size);
 
-	has_page_addr = (buffer->user_data + buffer_size) & PAGE_MASK;
 	WARN_ON(n && buffer_size != size);
+
+	has_page_addr = (buffer->user_data + buffer_size) & PAGE_MASK;
 	end_page_addr = PAGE_ALIGN(buffer->user_data + size);
 	if (end_page_addr > has_page_addr)
 		end_page_addr = has_page_addr;
-	ret = binder_allocate_page_range(alloc, PAGE_ALIGN(buffer->user_data),
-					 end_page_addr);
-	if (ret) {
-		buffer = ERR_PTR(ret);
-		goto out;
-	}
-
+	binder_allocate_page_range(alloc, PAGE_ALIGN(buffer->user_data),
+				   end_page_addr);
 	if (buffer_size != size) {
 		new_buffer->user_data = buffer->user_data + size;
 		list_add(&new_buffer->entry, &buffer->entry);
@@ -538,6 +577,7 @@ struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 {
 	struct binder_buffer *buffer, *next;
 	size_t size;
+	int ret;
 
 	/* Check binder_alloc is fully initialized */
 	if (!binder_alloc_get_vma(alloc)) {
@@ -574,6 +614,11 @@ struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 	buffer->pid = current->tgid;
 	mutex_unlock(&alloc->mutex);
 
+	ret = binder_install_buffer_pages(alloc, buffer, size);
+	if (ret) {
+		binder_alloc_free_buf(alloc, buffer);
+		buffer = ERR_PTR(ret);
+	}
 out:
 	return buffer;
 }
-- 
2.43.0.rc2.451.g8631bc7472-goog

