Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFC580119D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379175AbjLARYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379023AbjLARYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:24:12 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3771FCA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:23:26 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db4038d7cfdso991283276.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701451405; x=1702056205; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UowIgf2Hkvsym+UG5nPcinbceA5kAaZjExn8YUFB188=;
        b=JeJgN5THSgb9SB3EgUpbUjM/6cX43vwHFvAQM+2kTreoVPNSKs7NccJSYHolJNlb5d
         yt9a4DkrKkrHftyD2M3i0jY004t/HkldkZ72/wt7Wm/6ULUdIiC/v5/VCR985Q/gK66+
         PEmzG7hgHjOr4CxHtNf0JdmFqJ48w8lBGbaEzTmxLJYByumsjUYbaQYuNLU0ze6t4aOp
         dkrwAqSFwORW4IJdS2RXLUIXoAAgjcCkkHiZs4fRkCMmzqHEdP7teT4pUmGkbHEDQcAB
         cXiytKUpONJXeJe9z9TIqpQUTomU0Zr43TBY7Cw6ZkvMQqf/BRArlxNiPlhV5wVAOnef
         nQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451405; x=1702056205;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UowIgf2Hkvsym+UG5nPcinbceA5kAaZjExn8YUFB188=;
        b=KLir2x/eI1nZ18wRYGN7GA8QUATs2+Ke4ncjX1xiKvcwFYwWFGudv4O5QU6CzlMzAW
         aYr3OIizSamRRcA9dE/yz5Qmct3pV7orvzpBCf0IQRiZ5EBUw8wc7bdFBX84vOEBydPa
         uQe8LlBTUrwQEtWM2OORJdf68XUMAKf+4xrctkr7N9gmiN3uEUI0UUB64xRn/i8rR/zy
         FJmoyMXW2g/e09mPsa0I/4PONr3JG0bi0a0LqG29PninY/3FaP11LLCR560R+wJwinrI
         Kgvz+HQhLbSx9IceIbPoyKp+RvD8s5XLS5hR0ZITVIB6I+BZX2AjS0yIkUYMKIfdQBE5
         0HeQ==
X-Gm-Message-State: AOJu0Yyu/dkpJDldX7u40qbwRNnch92In5LlM3POagpbxCn6z2pqdePz
        OucNrudtg+tUI3xkL4TiwrWoW8yLku4+vQ==
X-Google-Smtp-Source: AGHT+IFxE/YZI8XAIHX/EFeweT5gpBgj3wRk384Ua9bcBWH5K5/1ssVdxRKeQmEELlewcCRtjXcK/bCiYAi6ZQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a25:ccc1:0:b0:db5:f536:17d4 with SMTP id
 l184-20020a25ccc1000000b00db5f53617d4mr77092ybf.11.1701451405614; Fri, 01 Dec
 2023 09:23:25 -0800 (PST)
Date:   Fri,  1 Dec 2023 17:21:52 +0000
In-Reply-To: <20231201172212.1813387-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201172212.1813387-24-cmllamas@google.com>
Subject: [PATCH v2 23/28] binder: document the final page calculation
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

The code to determine the page range for binder_lru_freelist_del() is
quite obscure. It leverages the buffer_size calculated before doing an
oversized buffer split. This is used to figure out if the last page is
being shared with another active buffer. If so, the page gets trimmed
out of the range as it has been previously removed from the freelist.

This would be equivalent to getting the start page of the next in-use
buffer explicitly. However, the code for this is much larger as we can
see in binder_free_buf_locked() routine. Instead, lets settle on
documenting the tricky step and using better names for now.

I believe an ideal solution would be to count the binder_page->users to
determine when a page should be added or removed from the freelist.
However, this is a much bigger change than what I'm willing to risk at
this time.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 052a8c3b0ce1..edd9714ec9f5 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -446,8 +446,8 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	struct rb_node *n = alloc->free_buffers.rb_node;
 	struct rb_node *best_fit = NULL;
 	struct binder_buffer *buffer;
-	unsigned long has_page_addr;
-	unsigned long end_page_addr;
+	unsigned long next_used_page;
+	unsigned long curr_last_page;
 	size_t buffer_size;
 
 	if (is_async && alloc->free_async_space < size) {
@@ -500,12 +500,16 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 		     "%d: binder_alloc_buf size %zd got buffer %pK size %zd\n",
 		      alloc->pid, size, buffer, buffer_size);
 
-	has_page_addr = (buffer->user_data + buffer_size) & PAGE_MASK;
-	end_page_addr = PAGE_ALIGN(buffer->user_data + size);
-	if (end_page_addr > has_page_addr)
-		end_page_addr = has_page_addr;
+	/*
+	 * Now we remove the pages from the freelist. A clever calculation
+	 * with buffer_size determines if the last page is shared with an
+	 * adjacent in-use buffer. In such case, the page has been already
+	 * removed from the freelist so we trim our range short.
+	 */
+	next_used_page = (buffer->user_data + buffer_size) & PAGE_MASK;
+	curr_last_page = PAGE_ALIGN(buffer->user_data + size);
 	binder_lru_freelist_del(alloc, PAGE_ALIGN(buffer->user_data),
-				end_page_addr);
+				min(next_used_page, curr_last_page));
 
 	rb_erase(&buffer->rb_node, &alloc->free_buffers);
 	buffer->free = 0;
-- 
2.43.0.rc2.451.g8631bc7472-goog

