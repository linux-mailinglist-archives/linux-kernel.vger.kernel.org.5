Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FDA801196
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379040AbjLARYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379284AbjLARXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:23:42 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9534D2703
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:23:12 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5c6260b60b1so853825a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701451392; x=1702056192; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GgpobR+FdeoXXQhISo2D3a14T7LkRftKpGNdNH3rHWQ=;
        b=QGHHvOXYvNj8Sn22EK+KhtavyquCh51rVlIXqGMqAGil2owEPeqMGAsnG7B1qgasTh
         AOiVzPnpUZ9oGX1yR3M+Z72uAmXbrWy9rd+DU3sqzHHe5Fqk7hrgY6zUzMK2xlHFzQxK
         npVLrLQWsUwwjHi2BahF+IertwXzOvithmp4SWxUE6cEBaWvf4TUEZbJRe0qXV/tLfSi
         gXqB+ScAdYRTJk0WBGXv84Pkt6on8tG1zSoVpOlCRJk9s1pokQlMxJsnAejB1VtGNTuD
         g/jumPzcMLN0jStmdYtXDvXE34d9kpHrMwjRx5tOrrBIURC2hG9bIR0mFN+L2S+nc2a6
         u2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451392; x=1702056192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GgpobR+FdeoXXQhISo2D3a14T7LkRftKpGNdNH3rHWQ=;
        b=Su68Y88W1wIspSy+hDRER7lg0627fU+X4e0H8i0CW8Bn5GsdUfpcm91D4VfMi62BN7
         R1nJyNNQbjp33yA7Yx61XSNYftUZ9BtJfXeJSpSsGtlQP8ACSIaUgzTtPhBXhdJHusGv
         x6SQ8WzFDb7WKGeFGrv0NBY/rqlQwtriNip31KQ4coBJPQVGOcR6shulBI5uAMq3eBq5
         Q0mwMH4YWlpI23oInQdf0WQS4T0a48QppFa2rNpwyobnv9sIMkSZiRK68d0zt1KrT8fc
         +joqWPtHRegnUYdZSFxhNznTpi8f3qrWrJTpmXkzC1Y3Zr/cXiYk4fOlMJCerzIv8Pdt
         5UcQ==
X-Gm-Message-State: AOJu0Yy/ga8T3LnQUW0h0WK5z+7HAXs+Y+NGuoYG3E0Qb6sKLsNBFSmu
        KSZBOsKRq4SUVRQoFxr1vW5c+1L6ppdLQQ==
X-Google-Smtp-Source: AGHT+IFk7qb1XOgk/gPR/Z8wAQIKxkz6qvGd/kOvDS3EGu/2JEu6PsWnk1K2U/O3ynDscfczmotPw9j51lRhvw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a63:f902:0:b0:5bd:8130:d2a3 with SMTP id
 h2-20020a63f902000000b005bd8130d2a3mr4059895pgi.5.1701451391957; Fri, 01 Dec
 2023 09:23:11 -0800 (PST)
Date:   Fri,  1 Dec 2023 17:21:46 +0000
In-Reply-To: <20231201172212.1813387-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201172212.1813387-18-cmllamas@google.com>
Subject: [PATCH v2 17/28] binder: malloc new_buffer outside of locks
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

Preallocate new_buffer before acquiring the alloc->mutex and hand it
down to binder_alloc_new_buf_locked(). The new buffer will be used in
the vast majority of requests (measured at 98.2% in field data). The
buffer is discarded otherwise. This change is required in preparation
for transitioning alloc->mutex into a spinlock in subsequent commits.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 44 ++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 1caf0e3d3451..86f4929a55d5 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -395,24 +395,27 @@ static bool debug_low_async_space_locked(struct binder_alloc *alloc)
 	return false;
 }
 
+/* Callers preallocate @new_buffer, it is freed by this function if unused */
 static struct binder_buffer *binder_alloc_new_buf_locked(
 				struct binder_alloc *alloc,
+				struct binder_buffer *new_buffer,
 				size_t size,
 				int is_async)
 {
 	struct rb_node *n = alloc->free_buffers.rb_node;
-	struct binder_buffer *buffer;
-	size_t buffer_size;
 	struct rb_node *best_fit = NULL;
+	struct binder_buffer *buffer;
 	unsigned long has_page_addr;
 	unsigned long end_page_addr;
+	size_t buffer_size;
 	int ret;
 
 	if (is_async && alloc->free_async_space < size) {
 		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
 			     "%d: binder_alloc_buf size %zd failed, no async space left\n",
 			      alloc->pid, size);
-		return ERR_PTR(-ENOSPC);
+		buffer = ERR_PTR(-ENOSPC);
+		goto out;
 	}
 
 	while (n) {
@@ -436,7 +439,8 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 				   "%d: binder_alloc_buf size %zd failed, no address space\n",
 				   alloc->pid, size);
 		debug_no_space_locked(alloc);
-		return ERR_PTR(-ENOSPC);
+		buffer = ERR_PTR(-ENOSPC);
+		goto out;
 	}
 
 	if (n == NULL) {
@@ -455,22 +459,17 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 		end_page_addr = has_page_addr;
 	ret = binder_allocate_page_range(alloc, PAGE_ALIGN(buffer->user_data),
 					 end_page_addr);
-	if (ret)
-		return ERR_PTR(ret);
+	if (ret) {
+		buffer = ERR_PTR(ret);
+		goto out;
+	}
 
 	if (buffer_size != size) {
-		struct binder_buffer *new_buffer;
-
-		new_buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
-		if (!new_buffer) {
-			pr_err("%s: %d failed to alloc new buffer struct\n",
-			       __func__, alloc->pid);
-			goto err_alloc_buf_struct_failed;
-		}
 		new_buffer->user_data = buffer->user_data + size;
 		list_add(&new_buffer->entry, &buffer->entry);
 		new_buffer->free = 1;
 		binder_insert_free_buffer(alloc, new_buffer);
+		new_buffer = NULL;
 	}
 
 	rb_erase(best_fit, &alloc->free_buffers);
@@ -491,12 +490,10 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 			buffer->oneway_spam_suspect = true;
 	}
 
+out:
+	/* Discard possibly unused new_buffer */
+	kfree(new_buffer);
 	return buffer;
-
-err_alloc_buf_struct_failed:
-	binder_free_page_range(alloc, PAGE_ALIGN(buffer->user_data),
-			       end_page_addr);
-	return ERR_PTR(-ENOMEM);
 }
 
 /* Calculate the sanitized total size, returns 0 for invalid request */
@@ -542,7 +539,7 @@ struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 					   size_t extra_buffers_size,
 					   int is_async)
 {
-	struct binder_buffer *buffer;
+	struct binder_buffer *buffer, *next;
 	size_t size;
 
 	/* Check binder_alloc is fully initialized */
@@ -562,8 +559,13 @@ struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 		return ERR_PTR(-EINVAL);
 	}
 
+	/* Preallocate the next buffer */
+	next = kzalloc(sizeof(*next), GFP_KERNEL);
+	if (!next)
+		return ERR_PTR(-ENOMEM);
+
 	mutex_lock(&alloc->mutex);
-	buffer = binder_alloc_new_buf_locked(alloc, size, is_async);
+	buffer = binder_alloc_new_buf_locked(alloc, next, size, is_async);
 	if (IS_ERR(buffer)) {
 		mutex_unlock(&alloc->mutex);
 		goto out;
-- 
2.43.0.rc2.451.g8631bc7472-goog

