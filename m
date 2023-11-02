Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831917DFA9B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377446AbjKBTBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377417AbjKBTBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:01:09 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2A3D73
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 12:00:58 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5b95ee4ae94so942642a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 12:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698951657; x=1699556457; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uOcLOjhkxzM2IC6JW3hdRFYoIiXgOCTJENqihjXbEf8=;
        b=BOMBt6vnW0Nffs4J7bfPtMA2B8U9PpH0cPfUem7Md66CwDTgTnKbxPP1SxvkjZcQO1
         fsMgPhiWjrA7I0yZ13JysSoKMamp4E85AXA/C01tF8AbxwNsfFJ0YX/muh+JT2NoXavq
         G/Hs8vHInQxHKeJ/VIRwOnp6A9e8wHbuViRwCjLRgsdWFneLbK4ZkFIv00EE00f2ID3e
         3QqODuaCHJNQkMc1Zwk3iy7P1pLM1TYEFLS6dfTqT8SHBUJNkHlt65OQiAZrK7GbYouk
         WJ543d8Chl87/CILf7zSTvtiVE/Ppu3Z9ehZQDdnoe8TY4fvfRGrhqsDfCOX5nxyQRmk
         T2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698951657; x=1699556457;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uOcLOjhkxzM2IC6JW3hdRFYoIiXgOCTJENqihjXbEf8=;
        b=iEY3wBGjexjIWCXuLoBBLDiJT9qmVNRhOrAS7jbBir68DZ2yERX6t7UnqB4evdV8VM
         NaBva96vL96P2SlBnDi1pScyJeFr1czcMKrHR3m0ydWFVaG7S4x4Xza0lV3h+LTziIAC
         e5HHA6oLzPqfm0v/J+a5KUkz25Mak6TzoNzNT0MMhHtLuupJGauSKAnAaDh7WMfEghOA
         uwYmDO6ka9ucjpHp9FfXhNaSS7mHTgM3Pv6AgGNwujT3P6wo5uInuWhLc7dluglZctLY
         Dgq72kUL4LM/7y2T5nKek+hQ2CxsP8jRcFDzQvZRFUUcy7tNojmAcJCIG0hhV8xnD4Vo
         lEdw==
X-Gm-Message-State: AOJu0Ywv0V3EySXk17M8XhMKDo/erD/vF7i1SJEYCOY+/F5BITHNY7bw
        ZQqlvKN+5jUuhG6uYFbbVNK5yhagVVi2GA==
X-Google-Smtp-Source: AGHT+IE/xoRCWMpr5mW2NCFMGyUl11LlnYW8JE8YWvIRk04axQRpsZUfqqEar3fEBeOp4dFG/S4LBsgGEqHj4Q==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a63:3e04:0:b0:5b8:fe99:152d with SMTP id
 l4-20020a633e04000000b005b8fe99152dmr328813pga.7.1698951657514; Thu, 02 Nov
 2023 12:00:57 -0700 (PDT)
Date:   Thu,  2 Nov 2023 18:59:13 +0000
In-Reply-To: <20231102185934.773885-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-1-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231102185934.773885-13-cmllamas@google.com>
Subject: [PATCH 12/21] binder: separate the no-space debugging logic
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

Move the no-space debugging logic into a separate function. Lets also
mark this branch as unlikely in binder_alloc_new_buf_locked() as most
requests will fit without issue.

Also add a few cosmetic changes and suggestions from checkpatch.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 71 +++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 31 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index eacc5a3ce538..3fe5c734c3df 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -323,6 +323,43 @@ static inline struct vm_area_struct *binder_alloc_get_vma(
 	return smp_load_acquire(&alloc->vma);
 }
 
+static void debug_no_space_locked(struct binder_alloc *alloc)
+{
+	size_t largest_alloc_size = 0;
+	struct binder_buffer *buffer;
+	size_t allocated_buffers = 0;
+	size_t largest_free_size = 0;
+	size_t total_alloc_size = 0;
+	size_t total_free_size = 0;
+	size_t free_buffers = 0;
+	size_t buffer_size;
+	struct rb_node *n;
+
+	for (n = rb_first(&alloc->allocated_buffers); n; n = rb_next(n)) {
+		buffer = rb_entry(n, struct binder_buffer, rb_node);
+		buffer_size = binder_alloc_buffer_size(alloc, buffer);
+		allocated_buffers++;
+		total_alloc_size += buffer_size;
+		if (buffer_size > largest_alloc_size)
+			largest_alloc_size = buffer_size;
+	}
+
+	for (n = rb_first(&alloc->free_buffers); n; n = rb_next(n)) {
+		buffer = rb_entry(n, struct binder_buffer, rb_node);
+		buffer_size = binder_alloc_buffer_size(alloc, buffer);
+		free_buffers++;
+		total_free_size += buffer_size;
+		if (buffer_size > largest_free_size)
+			largest_free_size = buffer_size;
+	}
+
+	binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
+			   "allocated: %zd (num: %zd largest: %zd), free: %zd (num: %zd largest: %zd)\n",
+			   total_alloc_size, allocated_buffers,
+			   largest_alloc_size, total_free_size,
+			   free_buffers, largest_free_size);
+}
+
 static bool debug_low_async_space_locked(struct binder_alloc *alloc)
 {
 	/*
@@ -404,42 +441,14 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 		}
 	}
 
-	if (best_fit == NULL) {
-		size_t allocated_buffers = 0;
-		size_t largest_alloc_size = 0;
-		size_t total_alloc_size = 0;
-		size_t free_buffers = 0;
-		size_t largest_free_size = 0;
-		size_t total_free_size = 0;
-
-		for (n = rb_first(&alloc->allocated_buffers); n != NULL;
-		     n = rb_next(n)) {
-			buffer = rb_entry(n, struct binder_buffer, rb_node);
-			buffer_size = binder_alloc_buffer_size(alloc, buffer);
-			allocated_buffers++;
-			total_alloc_size += buffer_size;
-			if (buffer_size > largest_alloc_size)
-				largest_alloc_size = buffer_size;
-		}
-		for (n = rb_first(&alloc->free_buffers); n != NULL;
-		     n = rb_next(n)) {
-			buffer = rb_entry(n, struct binder_buffer, rb_node);
-			buffer_size = binder_alloc_buffer_size(alloc, buffer);
-			free_buffers++;
-			total_free_size += buffer_size;
-			if (buffer_size > largest_free_size)
-				largest_free_size = buffer_size;
-		}
+	if (unlikely(!best_fit)) {
 		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
 				   "%d: binder_alloc_buf size %zd failed, no address space\n",
 				   alloc->pid, size);
-		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
-				   "allocated: %zd (num: %zd largest: %zd), free: %zd (num: %zd largest: %zd)\n",
-				   total_alloc_size, allocated_buffers,
-				   largest_alloc_size, total_free_size,
-				   free_buffers, largest_free_size);
+		debug_no_space_locked(alloc);
 		return ERR_PTR(-ENOSPC);
 	}
+
 	if (n == NULL) {
 		buffer = rb_entry(best_fit, struct binder_buffer, rb_node);
 		buffer_size = binder_alloc_buffer_size(alloc, buffer);
-- 
2.42.0.869.gea05f2083d-goog

