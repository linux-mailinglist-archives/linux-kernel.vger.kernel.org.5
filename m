Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B399280118F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379263AbjLARX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379073AbjLARXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:23:14 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967BF1FE4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:22:58 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6cdeb43fb26so2361370b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701451378; x=1702056178; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mw9g5oCRTylyC/hZyG54w1/v49iuvboW1UQ/KXPPPpQ=;
        b=gnJ5geTmc9uV1Qg4iI2MuWPsv/gERe6ii0FHIxVlA5QenCpN992+uc6aPRUnBcNO8O
         pU+E23w3ZrS7NVfRMD07pfPSMtt3xHDTM8joK1nt77PgHu5uW3116VmH4VudUY4Pspfz
         1JruZCPdKVbSilwSyB5QojouEzLeGtGvzxUZllRhd7XKByE19V631Ep4ZQsacgtZLxxe
         pNLZyacPELybzU9/R84Rv+wHl2OfuIkmBZcpzaite+yv7+26fcgmA/LEte2sDS28jhnX
         j+O8LY6vV0vCjrXywGiL1KkvAnapz/O1eo1TdoadsIi29Sw086xr9bL8E4sq6Wh9aJQp
         ls9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451378; x=1702056178;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mw9g5oCRTylyC/hZyG54w1/v49iuvboW1UQ/KXPPPpQ=;
        b=CKyOs/AtFFLQav8dQvR3GnNyKgmQLGyzXgPkrtYZz/dFETmQU7ulgYOmL3GmgdM3+p
         DpI8Kbl/koK4S1shqbDrtpaAnGmRmT7MQMSznl75LGUoHNbUVm58+Rk5RRB78p2NI+ik
         pyTVtTGfvTi1tHfcbjFIgMf8jzy1aDZI33Zj7If0yt/kgmU5DcCgjiPMnacaxnvr2Dz1
         3QT+8ULC4vc5I8pGOrcI2DL4VDYu+9lj/3NjZ4VhKwrSG7U4gRWRp6xHwL4LeyMdqgEJ
         YpB8bJjhGgBmB16gHlE6SXwovrGFmOGdotzSHzafdcWV4Oe1oBxyUyTBPjAzZSX7pgDg
         S5WQ==
X-Gm-Message-State: AOJu0YzSgeDkhZ3679r8jcROdfQgNi1YA/iEzxN95yjWlQsQVmwxK3uN
        9yUrRI+fdmXxbNOTzw48tVblRUKYL21M8Q==
X-Google-Smtp-Source: AGHT+IHZ+8v4AioCrr/jj6J9hKfz6mxBqzK3KNzSWGiU8LxhrfYEtQGCznKFq/cWnqQTsoETzMzITbEpQPw6gg==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6a00:b83:b0:6cd:f50c:32ac with SMTP
 id g3-20020a056a000b8300b006cdf50c32acmr700163pfj.6.1701451378100; Fri, 01
 Dec 2023 09:22:58 -0800 (PST)
Date:   Fri,  1 Dec 2023 17:21:40 +0000
In-Reply-To: <20231201172212.1813387-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201172212.1813387-12-cmllamas@google.com>
Subject: [PATCH v2 11/28] binder: do unlocked work in binder_alloc_new_buf()
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

Extract non-critical sections from binder_alloc_new_buf_locked() that
don't require holding the alloc->mutex. While we are here, consolidate
the checks for size overflow and zero-sized padding into a separate
sanitized_size() helper function.

Also add a few touchups to follow the coding guidelines.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 95 ++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 39 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 3051ea7ca44f..40a2ca0c0dea 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -363,9 +363,7 @@ static bool debug_low_async_space_locked(struct binder_alloc *alloc, int pid)
 
 static struct binder_buffer *binder_alloc_new_buf_locked(
 				struct binder_alloc *alloc,
-				size_t data_size,
-				size_t offsets_size,
-				size_t extra_buffers_size,
+				size_t size,
 				int is_async,
 				int pid)
 {
@@ -373,39 +371,10 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	struct binder_buffer *buffer;
 	size_t buffer_size;
 	struct rb_node *best_fit = NULL;
-	size_t size, data_offsets_size;
 	unsigned long has_page_addr;
 	unsigned long end_page_addr;
 	int ret;
 
-	/* Check binder_alloc is fully initialized */
-	if (!binder_alloc_get_vma(alloc)) {
-		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
-				   "%d: binder_alloc_buf, no vma\n",
-				   alloc->pid);
-		return ERR_PTR(-ESRCH);
-	}
-
-	data_offsets_size = ALIGN(data_size, sizeof(void *)) +
-		ALIGN(offsets_size, sizeof(void *));
-
-	if (data_offsets_size < data_size || data_offsets_size < offsets_size) {
-		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
-				"%d: got transaction with invalid size %zd-%zd\n",
-				alloc->pid, data_size, offsets_size);
-		return ERR_PTR(-EINVAL);
-	}
-	size = data_offsets_size + ALIGN(extra_buffers_size, sizeof(void *));
-	if (size < data_offsets_size || size < extra_buffers_size) {
-		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
-				"%d: got transaction with invalid extra_buffers_size %zd\n",
-				alloc->pid, extra_buffers_size);
-		return ERR_PTR(-EINVAL);
-	}
-
-	/* Pad 0-size buffers so they get assigned unique addresses */
-	size = max(size, sizeof(void *));
-
 	if (is_async && alloc->free_async_space < size) {
 		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
 			     "%d: binder_alloc_buf size %zd failed, no async space left\n",
@@ -421,13 +390,14 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 		if (size < buffer_size) {
 			best_fit = n;
 			n = n->rb_left;
-		} else if (size > buffer_size)
+		} else if (size > buffer_size) {
 			n = n->rb_right;
-		else {
+		} else {
 			best_fit = n;
 			break;
 		}
 	}
+
 	if (best_fit == NULL) {
 		size_t allocated_buffers = 0;
 		size_t largest_alloc_size = 0;
@@ -505,10 +475,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
 		     "%d: binder_alloc_buf size %zd got %pK\n",
 		      alloc->pid, size, buffer);
-	buffer->data_size = data_size;
-	buffer->offsets_size = offsets_size;
 	buffer->async_transaction = is_async;
-	buffer->extra_buffers_size = extra_buffers_size;
 	buffer->pid = pid;
 	buffer->oneway_spam_suspect = false;
 	if (is_async) {
@@ -527,6 +494,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 			alloc->oneway_spam_detected = false;
 		}
 	}
+
 	return buffer;
 
 err_alloc_buf_struct_failed:
@@ -535,6 +503,28 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	return ERR_PTR(-ENOMEM);
 }
 
+/* Calculate the sanitized total size, returns 0 for invalid request */
+static inline size_t sanitized_size(size_t data_size,
+				    size_t offsets_size,
+				    size_t extra_buffers_size)
+{
+	size_t total, tmp;
+
+	/* Align to pointer size and check for overflows */
+	tmp = ALIGN(data_size, sizeof(void *)) +
+		ALIGN(offsets_size, sizeof(void *));
+	if (tmp < data_size || tmp < offsets_size)
+		return 0;
+	total = tmp + ALIGN(extra_buffers_size, sizeof(void *));
+	if (total < tmp || total < extra_buffers_size)
+		return 0;
+
+	/* Pad 0-sized buffers so they get a unique address */
+	total = max(total, sizeof(void *));
+
+	return total;
+}
+
 /**
  * binder_alloc_new_buf() - Allocate a new binder buffer
  * @alloc:              binder_alloc for this proc
@@ -559,11 +549,38 @@ struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 					   int pid)
 {
 	struct binder_buffer *buffer;
+	size_t size;
+
+	/* Check binder_alloc is fully initialized */
+	if (!binder_alloc_get_vma(alloc)) {
+		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
+				   "%d: binder_alloc_buf, no vma\n",
+				   alloc->pid);
+		return ERR_PTR(-ESRCH);
+	}
+
+	size = sanitized_size(data_size, offsets_size, extra_buffers_size);
+	if (unlikely(!size)) {
+		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
+				   "%d: got transaction with invalid size %zd-%zd-%zd\n",
+				   alloc->pid, data_size, offsets_size,
+				   extra_buffers_size);
+		return ERR_PTR(-EINVAL);
+	}
 
 	mutex_lock(&alloc->mutex);
-	buffer = binder_alloc_new_buf_locked(alloc, data_size, offsets_size,
-					     extra_buffers_size, is_async, pid);
+	buffer = binder_alloc_new_buf_locked(alloc, size, is_async, pid);
+	if (IS_ERR(buffer)) {
+		mutex_unlock(&alloc->mutex);
+		goto out;
+	}
+
+	buffer->data_size = data_size;
+	buffer->offsets_size = offsets_size;
+	buffer->extra_buffers_size = extra_buffers_size;
 	mutex_unlock(&alloc->mutex);
+
+out:
 	return buffer;
 }
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

