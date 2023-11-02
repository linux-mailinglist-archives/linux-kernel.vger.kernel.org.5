Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9B87DFA9C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377525AbjKBTCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377516AbjKBTBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:01:36 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7451010D9
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 12:01:14 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5a08e5c7debso1021895a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 12:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698951674; x=1699556474; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wUibwtAc1IWnU68Zw2Q1xytGZZQWnXYrj0ZwNzGtCCI=;
        b=Sok05ZNWUXTIQMGJ6VAwBCOH7clSyuNYbp/fikdGSITgmbND+2zn6MduBgoyLVwSIu
         J7VKg+x6gHr93ebN/XJEjB2uEaiK7QRHhFEFmR/0Ix3iqg9/GPVlfyU5PuV/tfEHsL7o
         tVFrBiOZlQb9FIXFscOARf9sWVHlWjjfXXLaL2FMn8Pwbu3iywrwGAvJJqNYgn1lNnt2
         XzBwV/Ze1Mu5Myy26FbxhI5d6xUzOKpufEDES7EGcin9eADWvrz2iTMDh0KuHFtpdCMu
         funobyZX2yyjn6IXxjhPmkj3161uGvFzaXM97TGKyoKOGTVymCSiLL6pEFKuXqV/G0KA
         CFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698951674; x=1699556474;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wUibwtAc1IWnU68Zw2Q1xytGZZQWnXYrj0ZwNzGtCCI=;
        b=YHKZAqkZLojG00yBCvDL0tZfMmjoV8ffE7qanYSmESBt3+VOT/W7vRakAuaivz4pCL
         gbjwM5lHjCVwNIZnkstOGqJ/YucHfcgpyRMM2bKuAW4VBgz9wPJ5+vrpkW7L3oDnARXJ
         a5XVrNxWuhCEqwchvceqH/j4JLiDda4oLqLzCsOJ9U625Gcb5LTEYz7buWLeD1trzYZX
         3P2KmNquJvrQE2fei6YpEYqoeEMKZQpJ7jTDYntdMyZcnR4SI0XmKSEWEU1ymbwmppz3
         exaRO1bhwqyt/pFtob0dFw0Liwj8uQ0Vf2TNNijTwwAKTVLv16KJTGhc1VQcdXBorvFp
         ubRg==
X-Gm-Message-State: AOJu0YxIRE2mQDSrKlHqJ5108V/RQtMjhG2hHx19zeJ7o2SlcDwwuqNu
        dq+Q00dDmLOEsA6iscVAq67umdrmVmjpqw==
X-Google-Smtp-Source: AGHT+IGg7tSZSm1VIJd4sWv53kOYTbUXQN2p3he89Hstrd+TXBZk+RBkHkkLH3qeMTUw/YW6yCvaw9Zcaa/rTw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a63:344b:0:b0:5a9:fb7b:7f1d with SMTP id
 b72-20020a63344b000000b005a9fb7b7f1dmr359399pga.0.1698951673785; Thu, 02 Nov
 2023 12:01:13 -0700 (PDT)
Date:   Thu,  2 Nov 2023 18:59:20 +0000
In-Reply-To: <20231102185934.773885-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-1-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231102185934.773885-20-cmllamas@google.com>
Subject: [PATCH 19/21] binder: perform page allocation outside of locks
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

Split out the insertion of pages to be done outside of the alloc->mutex
in a separate binder_get_pages_range() routine. Since this is no longer
serialized with other requests we need to make sure we look at the full
range of pages for this buffer, including those shared with neighboring
buffers. The insertion of pages into the vma is still serialized with
the mmap write lock.

Besides avoiding unnecessary nested locking this helps in preparation of
switching the alloc->mutex into a spinlock_t in subsequent patches.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 85 ++++++++++++++++++++++------------
 1 file changed, 56 insertions(+), 29 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 7e0af1786b20..e739be7f2dd4 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -194,6 +194,9 @@ static void binder_free_page_range(struct binder_alloc *alloc,
 		index = (page_addr - alloc->buffer) / PAGE_SIZE;
 		page = &alloc->pages[index];
 
+		if (!page->page_ptr)
+			continue;
+
 		trace_binder_free_lru_start(alloc, index);
 
 		ret = list_lru_add(&binder_alloc_lru, &page->lru);
@@ -214,6 +217,9 @@ static int binder_get_user_page_remote(struct binder_alloc *alloc,
 		return -ESRCH;
 
 	mmap_write_lock(alloc->mm);
+	if (lru_page->page_ptr)
+		goto out;
+
 	if (!alloc->vma) {
 		pr_err("%d: %s failed, no vma\n", alloc->pid, __func__);
 		ret = -ESRCH;
@@ -236,32 +242,64 @@ static int binder_get_user_page_remote(struct binder_alloc *alloc,
 		goto out;
 	}
 
-	lru_page->page_ptr = page;
+	/* mark page insertion complete and safe to acquire */
+	smp_store_release(&lru_page->page_ptr, page);
 out:
 	mmap_write_unlock(alloc->mm);
 	mmput_async(alloc->mm);
 	return ret;
 }
 
-static int binder_allocate_page_range(struct binder_alloc *alloc,
-				      unsigned long start, unsigned long end)
+/* The range of pages should include those shared with other buffers */
+static int binder_get_page_range(struct binder_alloc *alloc,
+				 unsigned long start, unsigned long end)
 {
 	struct binder_lru_page *page;
 	unsigned long page_addr;
 
 	binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
-			   "%d: allocate pages %lx-%lx\n",
+			   "%d: get pages %lx-%lx\n",
 			   alloc->pid, start, end);
 
-	if (end <= start)
-		return 0;
+	for (page_addr = start; page_addr < end; page_addr += PAGE_SIZE) {
+		unsigned long index;
+		int ret;
+
+		index = (page_addr - alloc->buffer) / PAGE_SIZE;
+		page = &alloc->pages[index];
+
+		/* check if page insertion is marked complete by release */
+		if (smp_load_acquire(&page->page_ptr))
+			continue;
+
+		trace_binder_alloc_page_start(alloc, index);
+
+		ret = binder_get_user_page_remote(alloc, page, page_addr);
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
+{
+	struct binder_lru_page *page;
+	unsigned long page_addr;
+
+	binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
+			   "%d: allocate pages %lx-%lx\n",
+			   alloc->pid, start, end);
 
 	trace_binder_update_page_range(alloc, true, start, end);
 
 	for (page_addr = start; page_addr < end; page_addr += PAGE_SIZE) {
 		unsigned long index;
 		bool on_lru;
-		int ret;
 
 		index = (page_addr - alloc->buffer) / PAGE_SIZE;
 		page = &alloc->pages[index];
@@ -276,21 +314,9 @@ static int binder_allocate_page_range(struct binder_alloc *alloc,
 			continue;
 		}
 
-		trace_binder_alloc_page_start(alloc, index);
-
-		ret = binder_get_user_page_remote(alloc, page, page_addr);
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
@@ -410,7 +436,6 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	unsigned long has_page_addr;
 	unsigned long end_page_addr;
 	size_t buffer_size;
-	int ret;
 
 	if (is_async &&
 	    alloc->free_async_space < size + sizeof(struct binder_buffer)) {
@@ -453,18 +478,14 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
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
@@ -491,7 +512,6 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 			buffer->oneway_spam_suspect = true;
 	}
 
-out:
 	/* discard possibly unused new_buffer */
 	kfree(new_buffer);
 	return buffer;
@@ -520,6 +540,7 @@ struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 {
 	struct binder_buffer *buffer, *next;
 	size_t size;
+	int ret;
 
 	/* Check binder_alloc is fully initialized */
 	if (!binder_alloc_get_vma(alloc)) {
@@ -564,6 +585,12 @@ struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 	buffer->extra_buffers_size = extra_buffers_size;
 	buffer->pid = current->tgid;
 
+	ret = binder_get_page_range(alloc, buffer->user_data & PAGE_MASK,
+				    PAGE_ALIGN(buffer->user_data + size));
+	if (ret) {
+		binder_alloc_free_buf(alloc, buffer);
+		buffer = ERR_PTR(ret);
+	}
 out:
 	return buffer;
 }
-- 
2.42.0.869.gea05f2083d-goog

