Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BC280119F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379297AbjLARYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379207AbjLARYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:24:14 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6521FD9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:23:30 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cfccc9d6bcso8819645ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701451410; x=1702056210; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5z21SLbjWHo/KErnPrmSLWG6J9kVLmV3Tx7d+8xOII4=;
        b=qv2u5+xEx7COcMCTCkZEOPNlSnmnXkEiKMYMQMEefftCmQG85icMGWcLJSF3QlUdI2
         5WilxB3KniBlc5vvazxGJ+F+Kw8YqT1hkTdX3zCfndM0HKxbjVtLBBfJiy6iaEnJQR7f
         VW06y8Q1F9q2E6o8Yd+0V6djsZTp7XzmYfxSsbo7Bz0gv3w6GOsKAWjB26TflFbtRbFf
         fSdjbUL5FlDBN7FjpbDZxnZ/aMD58QbTJtQs2E97PXuCXEArMTcbUSHbbUO71pse/xR2
         ajTel1ub5ieNvZVbKtuFtmPYl5fbq/XVetin/14jB2yY2xH4jfamLRo6DBq4xl9Ay33o
         o16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451410; x=1702056210;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5z21SLbjWHo/KErnPrmSLWG6J9kVLmV3Tx7d+8xOII4=;
        b=quNq1rkoJx8ybhnFQS422yEhiH0KK/xuLitfn5gWR+d4uUon+nkEkMi3O+FSxMY1Br
         KCYym/4Ra5PCIWzkcpqMGL42MvcA6bJ7FSR3fMgtz5wA7UW8dPd/KAOtJdVy2DJ3ujjY
         L2gGIG39ukUfB81F2crE5dife5k1XABjyqT8eRB7O633MBRmrcETQYeYsrLq85uy8ie6
         9a8/hjpj7DWPUstXizXCWzX1uDuZRPtM552L3Jv9PNzoAaQRAGBVKHFC6+LyNwgXzzt1
         nk/e9bXb9cR5I1AvILQx3pA1KPIy0IqKFm2t3QUvMr+/xrtR7ILcElB/EIj3ABzJchfE
         ue3w==
X-Gm-Message-State: AOJu0Yy3DeB//TZYMR50eKVGAcSvHC815+XOjU9mjEugYUiywDRkX1qk
        /rAT8JlLiaIMzjnyjrgx8+5S/1clUM8qRw==
X-Google-Smtp-Source: AGHT+IE/KKSKjvxzW0LsOzIHnxB/CHY5U3+186iQaS5nWM7NixehyMgbBFvN8eErQX8jIAWyRzrNcDU24bgF1w==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:902:8644:b0:1d0:3090:957d with SMTP
 id y4-20020a170902864400b001d03090957dmr668385plt.11.1701451409865; Fri, 01
 Dec 2023 09:23:29 -0800 (PST)
Date:   Fri,  1 Dec 2023 17:21:54 +0000
In-Reply-To: <20231201172212.1813387-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201172212.1813387-26-cmllamas@google.com>
Subject: [PATCH v2 25/28] binder: refactor binder_delete_free_buffer()
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

Skip the freelist call immediately as needed, instead of continuing the
pointless checks. Also, drop the debug logs that we don't really need.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 44 +++++++++-------------------------
 1 file changed, 11 insertions(+), 33 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 60c829506d31..c3fc90966867 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -636,48 +636,26 @@ static unsigned long prev_buffer_end_page(struct binder_buffer *buffer)
 static void binder_delete_free_buffer(struct binder_alloc *alloc,
 				      struct binder_buffer *buffer)
 {
-	struct binder_buffer *prev, *next = NULL;
-	bool to_free = true;
+	struct binder_buffer *prev, *next;
+
+	if (PAGE_ALIGNED(buffer->user_data))
+		goto skip_freelist;
 
 	BUG_ON(alloc->buffers.next == &buffer->entry);
 	prev = binder_buffer_prev(buffer);
 	BUG_ON(!prev->free);
-	if (prev_buffer_end_page(prev) == buffer_start_page(buffer)) {
-		to_free = false;
-		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
-				   "%d: merge free, buffer %lx share page with %lx\n",
-				   alloc->pid, buffer->user_data,
-				   prev->user_data);
-	}
+	if (prev_buffer_end_page(prev) == buffer_start_page(buffer))
+		goto skip_freelist;
 
 	if (!list_is_last(&buffer->entry, &alloc->buffers)) {
 		next = binder_buffer_next(buffer);
-		if (buffer_start_page(next) == buffer_start_page(buffer)) {
-			to_free = false;
-			binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
-					   "%d: merge free, buffer %lx share page with %lx\n",
-					   alloc->pid,
-					   buffer->user_data,
-					   next->user_data);
-		}
+		if (buffer_start_page(next) == buffer_start_page(buffer))
+			goto skip_freelist;
 	}
 
-	if (PAGE_ALIGNED(buffer->user_data)) {
-		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
-				   "%d: merge free, buffer start %lx is page aligned\n",
-				   alloc->pid, buffer->user_data);
-		to_free = false;
-	}
-
-	if (to_free) {
-		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
-				   "%d: merge free, buffer %lx do not share page with %lx or %lx\n",
-				   alloc->pid, buffer->user_data,
-				   prev->user_data,
-				   next ? next->user_data : 0);
-		binder_lru_freelist_add(alloc, buffer_start_page(buffer),
-					buffer_start_page(buffer) + PAGE_SIZE);
-	}
+	binder_lru_freelist_add(alloc, buffer_start_page(buffer),
+				buffer_start_page(buffer) + PAGE_SIZE);
+skip_freelist:
 	list_del(&buffer->entry);
 	kfree(buffer);
 }
-- 
2.43.0.rc2.451.g8631bc7472-goog

