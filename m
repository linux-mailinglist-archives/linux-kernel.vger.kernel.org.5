Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578437DFAA0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377531AbjKBTBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377439AbjKBTBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:01:06 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4334D65
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 12:00:55 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5b95ee4ae94so942628a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 12:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698951655; x=1699556455; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mG/lwG8JEWpPVjducJFlwZHXq5eCE5Udv0tkKFpDcbw=;
        b=r0zlgGJNthnfLFIOsSAs7Ao0Tc3RdhzkrUBR7EMtZjlL9jh0JFTZ8ADyHTiSwLZSzq
         fjd90U+czkyL7Fb42hukESwjpuucpwe6fWBy1tGQT56OvtIIB4dfnKI8ogIjqNuUNP4U
         qCGlmGi/hPhfYh+hL61MVcqilHMNBkh/udsBCSGHD+o0w51nlctcwxUaZ7wMnMTML8n/
         QYrrboM9rIhKwFVEvoANBQe7KcVmlX+Oz9hA+fQlgHpb7iZCs1797QWww+dV2xgGO0Ih
         vU9t9gFTKIwUtpJ9RyceRGByclVx/sQ/Gu0YzZw/dq6TqE83K351yeZhRBA9fInCC1Jl
         UiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698951655; x=1699556455;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mG/lwG8JEWpPVjducJFlwZHXq5eCE5Udv0tkKFpDcbw=;
        b=iye1vlcDGlhqv7a1+9lcMg+E5wFoAVm/jlefn1r0JIHXa2AhDFKi+OaepWlfH+gUqS
         A7zCGW/Efj8yLSqfmOMN7aohD1ucLytLsHg8Na2qFMyxUa7BW0b4vxgt+Mk7vSMiYv/a
         r97lM0eiX0NNd6jLOTOeTxSP/iL9qmvGGBMBWYyvVLMca8kqs1pwE1jhO8UPY8TKlDFP
         nlDwWAcR5i7bd+LNOarn0N+w0Gjvt1PXC7wE/NiNwQoigoADLJbzhlJv+frd+HnnkRY+
         lRq4u2RiX+VsZhgMO94D8nBqMsckatTjKIh2mJ7L6TYUjWrXrY6dH0jyDNIbIdneZfRL
         IzWw==
X-Gm-Message-State: AOJu0YysechSKsRtDt+aaFNRkRakRxnMD2hHUyZSCbUDr6iTGWe4ZNFB
        kTjJ4BCdiShsT8QiXBwQke/9JjxS5eABNQ==
X-Google-Smtp-Source: AGHT+IEo1OqNSxdrqSIbpldOBdGMfVWPSnh0YFvzjiTb+O8htcT7JIN5HVdG4AuWQgsjDIIxqIzvDk/aRn9VrQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a63:ba1b:0:b0:5bd:3b33:88cc with SMTP id
 k27-20020a63ba1b000000b005bd3b3388ccmr23863pgf.0.1698951655332; Thu, 02 Nov
 2023 12:00:55 -0700 (PDT)
Date:   Thu,  2 Nov 2023 18:59:12 +0000
In-Reply-To: <20231102185934.773885-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-1-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231102185934.773885-12-cmllamas@google.com>
Subject: [PATCH 11/21] binder: remove pid param in binder_alloc_new_buf()
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

Binder attributes the buffer allocation to the current->tgid everytime.
There is no need to pass this as a parameter so drop it.

Also add a few touchups to follow the coding guidelines. No functional
changes are introduced in this patch.

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
index ed1f52f98b0d..eacc5a3ce538 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -323,7 +323,7 @@ static inline struct vm_area_struct *binder_alloc_get_vma(
 	return smp_load_acquire(&alloc->vma);
 }
 
-static bool debug_low_async_space_locked(struct binder_alloc *alloc, int pid)
+static bool debug_low_async_space_locked(struct binder_alloc *alloc)
 {
 	/*
 	 * Find the amount and size of buffers allocated by the current caller;
@@ -332,10 +332,11 @@ static bool debug_low_async_space_locked(struct binder_alloc *alloc, int pid)
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
@@ -369,8 +370,7 @@ static bool debug_low_async_space_locked(struct binder_alloc *alloc, int pid)
 static struct binder_buffer *binder_alloc_new_buf_locked(
 				struct binder_alloc *alloc,
 				size_t size,
-				int is_async,
-				int pid)
+				int is_async)
 {
 	struct rb_node *n = alloc->free_buffers.rb_node;
 	struct binder_buffer *buffer;
@@ -494,7 +494,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 			 * of async space left (which is less than 10% of total
 			 * buffer size).
 			 */
-			buffer->oneway_spam_suspect = debug_low_async_space_locked(alloc, pid);
+			buffer->oneway_spam_suspect = debug_low_async_space_locked(alloc);
 		} else {
 			alloc->oneway_spam_detected = false;
 		}
@@ -515,7 +515,6 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
  * @offsets_size:       user specified buffer offset
  * @extra_buffers_size: size of extra space for meta-data (eg, security context)
  * @is_async:           buffer for async transaction
- * @pid:				pid to attribute allocation to (used for debugging)
  *
  * Allocate a new buffer given the requested sizes. Returns
  * the kernel version of the buffer pointer. The size allocated
@@ -528,8 +527,7 @@ struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 					   size_t data_size,
 					   size_t offsets_size,
 					   size_t extra_buffers_size,
-					   int is_async,
-					   int pid)
+					   int is_async)
 {
 	struct binder_buffer *buffer;
 	size_t size;
@@ -560,7 +558,7 @@ struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 	size = max(size, sizeof(void *));
 
 	mutex_lock(&alloc->mutex);
-	buffer = binder_alloc_new_buf_locked(alloc, size, is_async, pid);
+	buffer = binder_alloc_new_buf_locked(alloc, size, is_async);
 	mutex_unlock(&alloc->mutex);
 
 	if (IS_ERR(buffer))
@@ -570,7 +568,7 @@ struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 	buffer->offsets_size = offsets_size;
 	buffer->async_transaction = is_async;
 	buffer->extra_buffers_size = extra_buffers_size;
-	buffer->pid = pid;
+	buffer->pid = current->tgid;
 
 out:
 	return buffer;
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
2.42.0.869.gea05f2083d-goog

