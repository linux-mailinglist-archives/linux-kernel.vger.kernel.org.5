Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157827DFA97
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377436AbjKBTCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377362AbjKBTBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:01:33 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA277D43
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 12:01:09 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5aaae6f46e1so1135866a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 12:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698951669; x=1699556469; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2EYYglLrWMuT8diATiDQEtjr6lQUpJbLriEGEDzsKkc=;
        b=M+ZHdpkpbILcxzQ+mtQWxCsVeO02QVqK9DrlKXmB99z1YwnM+tFIxCLDWaR7Ortrz6
         lfeii8ntddEcFtzY0isTxQN72KZOKxhy5pW8ny1E3J8m94orf8C0CoVlTZd23eZY1gEy
         M9H6EKzy2yr0xElgHeE4ICS1ecapfTLi+K5kO6Y3v9NE/qBfrs98UJHi3NnRtqw7agGb
         jxS3nLejgXCNhX1FQX7+E1ZvUPj3Mua7fsd7WxjmxYQDbgSoSbOWH0v5TKkipVSSYl1m
         9xnRmzj+2AinbviL28wBycdA02JgvN/+BTM4RxWlcwNBWFTEpmagpNVIGvbbkOZOrjFt
         +sFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698951669; x=1699556469;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2EYYglLrWMuT8diATiDQEtjr6lQUpJbLriEGEDzsKkc=;
        b=QeCTMPcXJdvLxE9+jLHNDs7u/4feAnKrr+hBqwLJTtUNFCKddOMXY6HTMEJHNwgAt8
         KanF9qkl8Y5t8zbpVzHHABZys8wZDAXSe6obAnY3F4yohwtJOXWS4bkQ9EsKdJMKi/Jf
         0qk349rKdK2aeeXLwxQquROGOCtN6Q4TZU874vyQ6xkwLOjbzsXaLf3UFIty8XgmGA4K
         +DVdMiDL0K+fvcBu5hLbOyHUMxlLHbGLv2kGtvV5qNLkGzXCiPq39WOkRV6EJatPkm0R
         S4c0s4vDM0LekwHaHLaK37j7kVj6ho+LJPFOoS64B8aoeXFcSO1JVEe8l/TNETTL9f8Q
         /Iow==
X-Gm-Message-State: AOJu0YwSwCEAI+Aw/WCNR3MQbPSnUKILnaRXTo+hbJlHsc2Tdnsw7BFS
        qCXMs/4X3LzwC+/kx92AcPYHnJQKl5k+5g==
X-Google-Smtp-Source: AGHT+IHTOlc4eWVW3RriG4G9sSdU4gX4XMpQ4WYbT5gJhIjUc04Z1OA+GsYD626ToJJfOT1ppy3v0MCweUxObQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6a02:60e:b0:5bd:3b33:88c7 with SMTP
 id bz14-20020a056a02060e00b005bd3b3388c7mr30754pgb.0.1698951669362; Thu, 02
 Nov 2023 12:01:09 -0700 (PDT)
Date:   Thu,  2 Nov 2023 18:59:18 +0000
In-Reply-To: <20231102185934.773885-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-1-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231102185934.773885-18-cmllamas@google.com>
Subject: [PATCH 17/21] binder: malloc new_buffer outside of locks
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
 drivers/android/binder_alloc.c | 38 +++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 56936430954f..da6c62567ffb 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -400,17 +400,19 @@ static bool debug_low_async_space_locked(struct binder_alloc *alloc)
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
 
 	if (is_async &&
@@ -461,22 +463,17 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
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
@@ -497,12 +494,10 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 			buffer->oneway_spam_suspect = true;
 	}
 
+out:
+	/* discard possibly unused new_buffer */
+	kfree(new_buffer);
 	return buffer;
-
-err_alloc_buf_struct_failed:
-	binder_free_page_range(alloc, PAGE_ALIGN(buffer->user_data),
-			       end_page_addr);
-	return ERR_PTR(-ENOMEM);
 }
 
 /**
@@ -526,7 +521,7 @@ struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 					   size_t extra_buffers_size,
 					   int is_async)
 {
-	struct binder_buffer *buffer;
+	struct binder_buffer *buffer, *next;
 	size_t size;
 
 	/* Check binder_alloc is fully initialized */
@@ -551,11 +546,16 @@ struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 		return ERR_PTR(-EINVAL);
 	}
 
+	/* preallocate the next buffer */
+	next = kzalloc(sizeof(*next), GFP_KERNEL);
+	if (!next)
+		return ERR_PTR(-ENOMEM);
+
 	/* Pad 0-size buffers so they get assigned unique addresses */
 	size = max(size, sizeof(void *));
 
 	mutex_lock(&alloc->mutex);
-	buffer = binder_alloc_new_buf_locked(alloc, size, is_async);
+	buffer = binder_alloc_new_buf_locked(alloc, next, size, is_async);
 	mutex_unlock(&alloc->mutex);
 
 	if (IS_ERR(buffer))
-- 
2.42.0.869.gea05f2083d-goog

