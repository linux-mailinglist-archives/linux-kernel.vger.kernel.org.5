Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BFF7DFA9F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377482AbjKBTBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377479AbjKBTBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:01:32 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3389F198
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 12:01:03 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5b31e000e97so18639207b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 12:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698951662; x=1699556462; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oN3oUcQsTgTPsIY3AHyFFUbULTKH4LCUoSZPTgPHKOY=;
        b=ciON/JXY+k2YGz5mdGncR+PJ7cZkDmMXyViq4be9Cpurog03QmipxDOx7HCSepz0eg
         kUIxSqGQUrI7TnNDPvRdH5GOHC7ODj3wTKigVnJHxHNxYuFwDihohm2VfUD/b2CnlTgs
         zuyga6eaUlYsq8S0Eg0w721USyoY/e/P+5StaOWr3fPsoEZ1hZwrVIBSoqeiNGwLDtcj
         ou+d9OA3t/yIeixkicg3xsPRYB/+f35/eHGLGJy1HUWYK9mr1c939or3ESxK7pweXGSF
         D/ChZzvZK7ibw5GqFlIkVml9UELrQX4XSHMxtt/WMTh6tSy7K3sumsUePKUz7jPqqXOd
         1CJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698951662; x=1699556462;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oN3oUcQsTgTPsIY3AHyFFUbULTKH4LCUoSZPTgPHKOY=;
        b=cL3T4JyGPeeFdwy8Qm2fcOHOsDyRrOFJYWkfA84s+A8FEnwuQUFshAdncGmNmfgvd+
         vhlCA5GSJhH07pIy1y4HXcgRg2qi1GedI8xLk5zPpHYYRpaIiPPAGexwPlda4aiUlKC7
         ae27vLfu19wy1G80SP3PLXOh7nBSET7Q+GlZMyVf2hSJOOsTjwT4js/rj2rIsrVL0r60
         VO2aHoTPcMojalTWsORje0nMmsGH/7c+ucXx5+FZc5ln/HZOm3slWAWPyUe0iWGAi8GJ
         wS07n92R33v7vTbkxYJmZxWBCZuni1CppfZuYGRaDUH0bI8G9x63rWZkQSBck1FgetyI
         wsSA==
X-Gm-Message-State: AOJu0YxPetjWo1bBNqE0OMEnu4q7YsSlF/scSmp3eXkY2/2IHldcMuX/
        /tKpyWOCcQgdXlB///vEh480OAYG01i5mg==
X-Google-Smtp-Source: AGHT+IH/HfKwwn+101UYJKTPkqQwh5PM8yvvbcYea3Ne0R0v14bjuyb3QLx6qSN/6834UfZCB7n9rV3yS8kO0A==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6902:1083:b0:da0:567d:f819 with SMTP
 id v3-20020a056902108300b00da0567df819mr466083ybu.10.1698951662085; Thu, 02
 Nov 2023 12:01:02 -0700 (PDT)
Date:   Thu,  2 Nov 2023 18:59:15 +0000
In-Reply-To: <20231102185934.773885-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-1-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231102185934.773885-15-cmllamas@google.com>
Subject: [PATCH 14/21] binder: do not add pages to LRU in release path
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
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In binder_alloc_deferred_release() pages are added to the LRU list via
binder_free_buf_locked(). However, this is pointless because these pages
are kfree'd immediately afterwards. Add an option to skip the LRU list.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index cc627c106a01..d2a38dee12db 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -595,16 +595,16 @@ static unsigned long prev_buffer_end_page(struct binder_buffer *buffer)
 }
 
 static void binder_delete_free_buffer(struct binder_alloc *alloc,
-				      struct binder_buffer *buffer)
+				      struct binder_buffer *buffer,
+				      bool free_pages)
 {
 	struct binder_buffer *prev, *next = NULL;
-	bool to_free = true;
 
 	BUG_ON(alloc->buffers.next == &buffer->entry);
 	prev = binder_buffer_prev(buffer);
 	BUG_ON(!prev->free);
 	if (prev_buffer_end_page(prev) == buffer_start_page(buffer)) {
-		to_free = false;
+		free_pages = false;
 		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
 				   "%d: merge free, buffer %lx share page with %lx\n",
 				   alloc->pid, buffer->user_data,
@@ -614,7 +614,7 @@ static void binder_delete_free_buffer(struct binder_alloc *alloc,
 	if (!list_is_last(&buffer->entry, &alloc->buffers)) {
 		next = binder_buffer_next(buffer);
 		if (buffer_start_page(next) == buffer_start_page(buffer)) {
-			to_free = false;
+			free_pages = false;
 			binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
 					   "%d: merge free, buffer %lx share page with %lx\n",
 					   alloc->pid,
@@ -627,10 +627,10 @@ static void binder_delete_free_buffer(struct binder_alloc *alloc,
 		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
 				   "%d: merge free, buffer start %lx is page aligned\n",
 				   alloc->pid, buffer->user_data);
-		to_free = false;
+		free_pages = false;
 	}
 
-	if (to_free) {
+	if (free_pages) {
 		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
 				   "%d: merge free, buffer %lx do not share page with %lx or %lx\n",
 				   alloc->pid, buffer->user_data,
@@ -644,7 +644,8 @@ static void binder_delete_free_buffer(struct binder_alloc *alloc,
 }
 
 static void binder_free_buf_locked(struct binder_alloc *alloc,
-				   struct binder_buffer *buffer)
+				   struct binder_buffer *buffer,
+				   bool free_pages)
 {
 	size_t size, buffer_size;
 
@@ -672,8 +673,9 @@ static void binder_free_buf_locked(struct binder_alloc *alloc,
 			      alloc->pid, size, alloc->free_async_space);
 	}
 
-	binder_free_page_range(alloc, PAGE_ALIGN(buffer->user_data),
-			       (buffer->user_data + buffer_size) & PAGE_MASK);
+	if (free_pages)
+		binder_free_page_range(alloc, PAGE_ALIGN(buffer->user_data),
+				       (buffer->user_data + buffer_size) & PAGE_MASK);
 
 	rb_erase(&buffer->rb_node, &alloc->allocated_buffers);
 	buffer->free = 1;
@@ -682,14 +684,14 @@ static void binder_free_buf_locked(struct binder_alloc *alloc,
 
 		if (next->free) {
 			rb_erase(&next->rb_node, &alloc->free_buffers);
-			binder_delete_free_buffer(alloc, next);
+			binder_delete_free_buffer(alloc, next, free_pages);
 		}
 	}
 	if (alloc->buffers.next != &buffer->entry) {
 		struct binder_buffer *prev = binder_buffer_prev(buffer);
 
 		if (prev->free) {
-			binder_delete_free_buffer(alloc, buffer);
+			binder_delete_free_buffer(alloc, buffer, free_pages);
 			rb_erase(&prev->rb_node, &alloc->free_buffers);
 			buffer = prev;
 		}
@@ -722,7 +724,7 @@ void binder_alloc_free_buf(struct binder_alloc *alloc,
 		buffer->clear_on_free = false;
 	}
 	mutex_lock(&alloc->mutex);
-	binder_free_buf_locked(alloc, buffer);
+	binder_free_buf_locked(alloc, buffer, true);
 	mutex_unlock(&alloc->mutex);
 }
 
@@ -829,7 +831,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 			binder_alloc_clear_buf(alloc, buffer);
 			buffer->clear_on_free = false;
 		}
-		binder_free_buf_locked(alloc, buffer);
+		binder_free_buf_locked(alloc, buffer, false);
 		buffers++;
 	}
 
-- 
2.42.0.869.gea05f2083d-goog

