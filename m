Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC907DFA98
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377471AbjKBTBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377470AbjKBTB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:01:27 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9773C1A4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 12:01:05 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7af53bde4so18440867b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 12:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698951665; x=1699556465; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rg7Y2F3d2P/Lfj0TKe4CpTmzIJyzpFCp7F88tqW9MEo=;
        b=Wz7PEDOpP8bT7uOAqM4YZqcntclQ+VrbTbUY02jVqzFITNkAuVQZa1o4Brzz5YzDos
         qcq2xbeS/bCLvY+Yy5JhSYNLZx2iKVlQR9DPanQnacdbwa8PVSp7Wnjf06+tLO/3o90O
         j2JXo3C7Tw5pD4tgYUC0jk2zDPKQ7Hee7BhFCqOPWrUzDArcqKGjS5sKdU7Mxq/6rfoG
         t7LC5melF/g3AQfVk55O/prxFPQ6g1ObObpVZga4YwkTb9ZxRts1jJguZEBJiuQHSMOr
         syIlRpkv00SbTj5WvCsZV00lKH3DAc5uOE6mlxR2RwGX/b84dZgmGK0nHoEqibWR/yut
         3MBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698951665; x=1699556465;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rg7Y2F3d2P/Lfj0TKe4CpTmzIJyzpFCp7F88tqW9MEo=;
        b=Ev80l5kYEqEKORNdopcOUpTUSyEpa/puP9DKwynWLcehOWss/zbsN+g3zIimuwA2Kr
         fH0f8DsT5xxO4ty5MUNnmxb5keJaNYHTJ6FshuhZ+GbyV0ytQLam3WCJXFm28BPRJu1C
         vGR4OpBvZys4ibkWRlYsiVO2Zrf3zZJ8+BXKa5Vc/J1rQh7Oy2gl8z/pRds7FJR7G3bx
         hBHLHlAYWPn1s60d/mQPurklUKUO/o4dUNsklFPuN+bik1TNA4XemqCKpzWS/wB30Nne
         +I8RypwNP8FLek4H/oFFU79NYMNZwKM/YipLfygBQSaxabKGqENqfM66EAPbVRUzWtnL
         HETQ==
X-Gm-Message-State: AOJu0Yw0IeqOpjmvDY0NNpvj9pBcnbWlYQfyIdBNk/rHOUD5ZtLzhVKH
        +YR0bXt+r8F7m2Q+TG8P6o0FIc13TVv7kg==
X-Google-Smtp-Source: AGHT+IE8n6eTtopja7qu/fau3v6vHCmgrxCSEJDacZC7bHZXWEWiKDj1pjZA5cccI7k4yK5oQgd8OqcSZYjPtQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a81:83c6:0:b0:59b:eea4:a5a6 with SMTP id
 t189-20020a8183c6000000b0059beea4a5a6mr11732ywf.0.1698951664760; Thu, 02 Nov
 2023 12:01:04 -0700 (PDT)
Date:   Thu,  2 Nov 2023 18:59:16 +0000
In-Reply-To: <20231102185934.773885-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-1-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231102185934.773885-16-cmllamas@google.com>
Subject: [PATCH 15/21] binder: relocate binder_alloc_clear_buf()
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

Move this function up along with binder_alloc_get_page() so that their
prototypes aren't necessary.

No functional change in this patch.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 124 ++++++++++++++++-----------------
 1 file changed, 61 insertions(+), 63 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index d2a38dee12db..4821a29799c8 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -699,8 +699,68 @@ static void binder_free_buf_locked(struct binder_alloc *alloc,
 	binder_insert_free_buffer(alloc, buffer);
 }
 
+/**
+ * binder_alloc_get_page() - get kernel pointer for given buffer offset
+ * @alloc: binder_alloc for this proc
+ * @buffer: binder buffer to be accessed
+ * @buffer_offset: offset into @buffer data
+ * @pgoffp: address to copy final page offset to
+ *
+ * Lookup the struct page corresponding to the address
+ * at @buffer_offset into @buffer->user_data. If @pgoffp is not
+ * NULL, the byte-offset into the page is written there.
+ *
+ * The caller is responsible to ensure that the offset points
+ * to a valid address within the @buffer and that @buffer is
+ * not freeable by the user. Since it can't be freed, we are
+ * guaranteed that the corresponding elements of @alloc->pages[]
+ * cannot change.
+ *
+ * Return: struct page
+ */
+static struct page *binder_alloc_get_page(struct binder_alloc *alloc,
+					  struct binder_buffer *buffer,
+					  binder_size_t buffer_offset,
+					  pgoff_t *pgoffp)
+{
+	binder_size_t buffer_space_offset = buffer_offset +
+		(buffer->user_data - alloc->buffer);
+	pgoff_t pgoff = buffer_space_offset & ~PAGE_MASK;
+	size_t index = buffer_space_offset >> PAGE_SHIFT;
+	struct binder_lru_page *lru_page;
+
+	lru_page = &alloc->pages[index];
+	*pgoffp = pgoff;
+	return lru_page->page_ptr;
+}
+
+/**
+ * binder_alloc_clear_buf() - zero out buffer
+ * @alloc: binder_alloc for this proc
+ * @buffer: binder buffer to be cleared
+ *
+ * memset the given buffer to 0
+ */
 static void binder_alloc_clear_buf(struct binder_alloc *alloc,
-				   struct binder_buffer *buffer);
+				   struct binder_buffer *buffer)
+{
+	size_t bytes = binder_alloc_buffer_size(alloc, buffer);
+	binder_size_t buffer_offset = 0;
+
+	while (bytes) {
+		unsigned long size;
+		struct page *page;
+		pgoff_t pgoff;
+
+		page = binder_alloc_get_page(alloc, buffer,
+					     buffer_offset, &pgoff);
+		size = min_t(size_t, bytes, PAGE_SIZE - pgoff);
+		memset_page(page, pgoff, 0, size);
+		bytes -= size;
+		buffer_offset += size;
+	}
+}
+
 /**
  * binder_alloc_free_buf() - free a binder buffer
  * @alloc:	binder_alloc for this proc
@@ -1137,68 +1197,6 @@ static inline bool check_buffer(struct binder_alloc *alloc,
 		(!buffer->allow_user_free || !buffer->transaction);
 }
 
-/**
- * binder_alloc_get_page() - get kernel pointer for given buffer offset
- * @alloc: binder_alloc for this proc
- * @buffer: binder buffer to be accessed
- * @buffer_offset: offset into @buffer data
- * @pgoffp: address to copy final page offset to
- *
- * Lookup the struct page corresponding to the address
- * at @buffer_offset into @buffer->user_data. If @pgoffp is not
- * NULL, the byte-offset into the page is written there.
- *
- * The caller is responsible to ensure that the offset points
- * to a valid address within the @buffer and that @buffer is
- * not freeable by the user. Since it can't be freed, we are
- * guaranteed that the corresponding elements of @alloc->pages[]
- * cannot change.
- *
- * Return: struct page
- */
-static struct page *binder_alloc_get_page(struct binder_alloc *alloc,
-					  struct binder_buffer *buffer,
-					  binder_size_t buffer_offset,
-					  pgoff_t *pgoffp)
-{
-	binder_size_t buffer_space_offset = buffer_offset +
-		(buffer->user_data - alloc->buffer);
-	pgoff_t pgoff = buffer_space_offset & ~PAGE_MASK;
-	size_t index = buffer_space_offset >> PAGE_SHIFT;
-	struct binder_lru_page *lru_page;
-
-	lru_page = &alloc->pages[index];
-	*pgoffp = pgoff;
-	return lru_page->page_ptr;
-}
-
-/**
- * binder_alloc_clear_buf() - zero out buffer
- * @alloc: binder_alloc for this proc
- * @buffer: binder buffer to be cleared
- *
- * memset the given buffer to 0
- */
-static void binder_alloc_clear_buf(struct binder_alloc *alloc,
-				   struct binder_buffer *buffer)
-{
-	size_t bytes = binder_alloc_buffer_size(alloc, buffer);
-	binder_size_t buffer_offset = 0;
-
-	while (bytes) {
-		unsigned long size;
-		struct page *page;
-		pgoff_t pgoff;
-
-		page = binder_alloc_get_page(alloc, buffer,
-					     buffer_offset, &pgoff);
-		size = min_t(size_t, bytes, PAGE_SIZE - pgoff);
-		memset_page(page, pgoff, 0, size);
-		bytes -= size;
-		buffer_offset += size;
-	}
-}
-
 /**
  * binder_alloc_copy_user_to_buffer() - copy src user to tgt user
  * @alloc: binder_alloc for this proc
-- 
2.42.0.869.gea05f2083d-goog

