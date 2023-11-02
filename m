Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF847DFA8A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377375AbjKBTB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377432AbjKBTBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:01:05 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2042DD59
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 12:00:54 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5b95ee4ae94so942607a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 12:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698951653; x=1699556453; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gSE9dYv++c4k7PvE4esAvLpKmpkaeD7lAM2vlPuDfos=;
        b=lM4HQNkjkz/G/wuWD8kfFlkgtfKGdmNTbNibsHVwDNrCYAe+4/tdnRX+jybBF8/dMz
         hvJMPxNGmFB23I3M2FyjUm/qModJfqyRdOpevFLeBT7u4BZxGNv/pXu/pxLEbC04i0v0
         sviHpE0dft7z+URjGjnIA3ZAlr9evT48vaK52jDOlq0w0gBaEJJBNu7A15DHwMwpXccl
         mXIJn00TdSq9GvXTTCYc2kJyOrvY21wfjO94rngaYrUQvOSuwcqlPXdOES7ATFuiD3cx
         t0JMmNC61qC+3KZRCP+shUbQrK7C24EbYY3rpR0E++RX0bzj0x6noHve3slz7YNGo7SB
         XM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698951653; x=1699556453;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gSE9dYv++c4k7PvE4esAvLpKmpkaeD7lAM2vlPuDfos=;
        b=qhGNbrmmz36quh8wbcpRtHFASd4O58erFFPho0MWE/n4A0vK0CDsERSe2wSDYkZN2N
         V9PcctJonhtBo36JyKb0QPVF2444UdtYYoPJ/fcY/DcjZ49vRlAIfQmKzoC60r9wUI37
         HQKAzT+/bLLbvSSOqTW5c+cVDtWdBP2aFcSSFJN0gWKcYQNpT2lcZONj2peOPQSHvdsA
         hih69xOgdjthG3SEZ30aNChuV9ifAIV8+t2X+XE4E/h2gEl0azJ0BCmF1vN5/7My55h1
         11ktZuQ4Hp1/0o43OakWp496dKca0f4aKZ5IrcC2aLtN6ajlDpVLlaUxUrqxWWz6x2no
         1Bng==
X-Gm-Message-State: AOJu0YwWXTHegPNMoqZpBxn6DSPAuTgmdrxGBZwEV4MQJRgD1ZUcvEH7
        yFcZ++htd2M94ZCIpXEeFiQeG0KDYXHsow==
X-Google-Smtp-Source: AGHT+IEcAv2D5BZEcxGnxR9Hc0d9ePGDG6npb7R+6KLlXDJClAJ8v6VdTFmYroFe5nLNx3/Gf1OQDAl/Ju2GOA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a63:9316:0:b0:5ae:3966:b620 with SMTP id
 b22-20020a639316000000b005ae3966b620mr368253pge.1.1698951652810; Thu, 02 Nov
 2023 12:00:52 -0700 (PDT)
Date:   Thu,  2 Nov 2023 18:59:11 +0000
In-Reply-To: <20231102185934.773885-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-1-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231102185934.773885-11-cmllamas@google.com>
Subject: [PATCH 10/21] binder: do unlocked work in binder_alloc_new_buf()
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
the multiple checks for size overflow into a single statement.

Also add a few touchups to follow the coding guidelines.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 85 ++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 41 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 27c7163761c4..ed1f52f98b0d 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -368,9 +368,7 @@ static bool debug_low_async_space_locked(struct binder_alloc *alloc, int pid)
 
 static struct binder_buffer *binder_alloc_new_buf_locked(
 				struct binder_alloc *alloc,
-				size_t data_size,
-				size_t offsets_size,
-				size_t extra_buffers_size,
+				size_t size,
 				int is_async,
 				int pid)
 {
@@ -378,39 +376,10 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
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
 	if (is_async &&
 	    alloc->free_async_space < size + sizeof(struct binder_buffer)) {
 		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
@@ -427,13 +396,14 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
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
@@ -511,11 +481,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
 		     "%d: binder_alloc_buf size %zd got %pK\n",
 		      alloc->pid, size, buffer);
-	buffer->data_size = data_size;
-	buffer->offsets_size = offsets_size;
-	buffer->async_transaction = is_async;
-	buffer->extra_buffers_size = extra_buffers_size;
-	buffer->pid = pid;
+
 	buffer->oneway_spam_suspect = false;
 	if (is_async) {
 		alloc->free_async_space -= size + sizeof(struct binder_buffer);
@@ -533,6 +499,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 			alloc->oneway_spam_detected = false;
 		}
 	}
+
 	return buffer;
 
 err_alloc_buf_struct_failed:
@@ -565,11 +532,47 @@ struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
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
+	size = ALIGN(data_size, sizeof(void *)) +
+		ALIGN(offsets_size, sizeof(void *)) +
+		ALIGN(extra_buffers_size, sizeof(void *));
+
+	if (size < data_size ||
+	    size < offsets_size ||
+	    size < extra_buffers_size) {
+		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
+				   "%d: got transaction with invalid size %zd-%zd-%zd\n",
+				   alloc->pid, data_size, offsets_size,
+				   extra_buffers_size);
+		return ERR_PTR(-EINVAL);
+	}
+
+	/* Pad 0-size buffers so they get assigned unique addresses */
+	size = max(size, sizeof(void *));
 
 	mutex_lock(&alloc->mutex);
-	buffer = binder_alloc_new_buf_locked(alloc, data_size, offsets_size,
-					     extra_buffers_size, is_async, pid);
+	buffer = binder_alloc_new_buf_locked(alloc, size, is_async, pid);
 	mutex_unlock(&alloc->mutex);
+
+	if (IS_ERR(buffer))
+		goto out;
+
+	buffer->data_size = data_size;
+	buffer->offsets_size = offsets_size;
+	buffer->async_transaction = is_async;
+	buffer->extra_buffers_size = extra_buffers_size;
+	buffer->pid = pid;
+
+out:
 	return buffer;
 }
 
-- 
2.42.0.869.gea05f2083d-goog

