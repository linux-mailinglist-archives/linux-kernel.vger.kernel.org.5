Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BEF801191
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378926AbjLARXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379019AbjLARXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:23:17 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71D42121
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:23:03 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db5508d1beeso946708276.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701451383; x=1702056183; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9u4/qlntQPHuxGZvI4lCpbjU+dw7OrCzCrUbXle6isA=;
        b=BDEaQJ425uDt4o9VjK4XJI/rN2N82HVU8UXrupYXmbg7GU/8pER8C7bDernpvHwCyR
         XEd4GX3hcDoliZysJnyYPeGjFcYalsHRfEziIEYXob45GnjgLd9hkiYtModfQ5Sfb0Fo
         sZhlft5BuWmOZxAnOGFayUh3tSh1cfFdQ/eMB5zf6fcZqmpNcLaeS/Dg3MRHaDuBjTZn
         SC3zZFqM8mz1OFXoj3aKLRjl4NRIgGCbN7EdOQMw45ElKOwWceEzCbBN+pmlGzkMgeY3
         XV22bhrgdWGxdxC45vgSSsfL4r9yoxlRTh+HxWtiqljO1oFyhRbdNS4pAlXrj7vCbwCL
         +UiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451383; x=1702056183;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9u4/qlntQPHuxGZvI4lCpbjU+dw7OrCzCrUbXle6isA=;
        b=Z5J6OUfBWcrP7Ocdavj91hR4thHOUcW5snD1QEoi4PVBpRKbV5f3xVpk7vA2sk4c0H
         8yrX9Emhmp+DVkXSqKOf+nnMfhXt5xyYbINUWZ2/zi1DHPGOuNWmvRgxf8BKuiYexMbF
         Xa2vXXUPjxo2N/n1qv+XR9LOd/RNLCGKLACsZCmIQqd7P4/2NeFx53i6jlz6YKOo5VTx
         ttYF6PIM8h+nrgYk1LyC7bhGlXt5RgbFxzWKJuycL+keRnrCtTcXSmlDLj+XRHnZ/gfh
         D5PfEgb8Kf8zUHURVi5J/ILaooc2UhUENii0pFMUGzmBsz6DMTmC4QGzuDin7Tp9e24+
         vXWw==
X-Gm-Message-State: AOJu0YxX7qLTHZBgELsYmtPpn4xGRDcIGz8h4MdFECkBjGMotiKTD9jL
        9PzesxgLnakeybItqKBuFdx/1cwcd1siEg==
X-Google-Smtp-Source: AGHT+IHx1mHgIM6RtODIXyc45zVDJgPz8e7gRB8Lbu6TxghBXHlXqwDQJt2cfBR5ZdtCsayQkMF5NbWh7wxq6A==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a25:3106:0:b0:da3:723b:b2a4 with SMTP id
 x6-20020a253106000000b00da3723bb2a4mr704008ybx.7.1701451382936; Fri, 01 Dec
 2023 09:23:02 -0800 (PST)
Date:   Fri,  1 Dec 2023 17:21:42 +0000
In-Reply-To: <20231201172212.1813387-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201172212.1813387-14-cmllamas@google.com>
Subject: [PATCH v2 13/28] binder: separate the no-space debugging logic
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Alice Ryhl <aliceryhl@google.com>
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

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 71 +++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 31 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index b5c3e56318e1..3dca7b199246 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -319,6 +319,43 @@ static inline struct vm_area_struct *binder_alloc_get_vma(
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
@@ -398,42 +435,14 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
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
2.43.0.rc2.451.g8631bc7472-goog

