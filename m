Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6649A801194
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379265AbjLARYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378821AbjLARXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:23:33 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAB52698
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:23:08 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d3eafe3d17so9680037b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701451387; x=1702056187; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7VGaeHLjFgxbMrAUwcwHUzP2c5AgMWXVt5O9URYAbf8=;
        b=Lldv2uSC8gwNxj2u6Z86sOSGbYgDwvb/23m0Jg/ts6aQKpdCTLPv/jQ3ONIQWhf8lk
         0yafPgMOkHkNRy5gCj8ysJz91z7HBUaF8JogduMtqCNJrf1kDgE7BPiHSgFUS0hT8HrU
         gE/8+kKuPu3B5DQmcVTpKLGueYbyENzJczI7AVM5zKiPNUapSxUZa3oDJxqzB1Qa4dRP
         4Bc6OHY5Jrq0ck/5iZ3DI/KvXIqLi3vKXSQMjH1A34iWHK1lc/PW2lIgrLlBOpDWjDpp
         E/slc5smCPNnziKsVJHTaAd3S9eqI9KICPQQh944D6sTFHktezyyNFWthWcgaPFxxeK7
         qlHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451387; x=1702056187;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7VGaeHLjFgxbMrAUwcwHUzP2c5AgMWXVt5O9URYAbf8=;
        b=KSaSV8qzXsk4vXbQbhkMBcMrU6Nh338qhZGr0SzmDRamsWgx6SWRTeaTXQsguo/+p+
         enL2Lcze6PMYEE21WI84Ai9isY/KhB5G00GXhlSg5fUMD53P3vMgylp3w+7tQ75V46sC
         F9D0WCRvdzmKTD8Z3l+k3i2mELMoIQz3ikRPaq7eDKzT9yJtWsWTH3A7cy3dQEcve2pS
         KNeEwYrP8EMnE/0Ph32qII5/cFZ13zgz+d9ty7eEGDas6ne0rrpJlXGsSbrCY2fpdem+
         b3se6MqRjmwAglXQYrekTeTg+LaimH4dheZem1WFgley2KSpj+DOT6r/VodgisVuG+oA
         ebNg==
X-Gm-Message-State: AOJu0YwD7tAj9p/5j/DcLktLDtSAJF/dr3zv+Fx58mw3Rt4854u5rFo1
        7R6MVkkyiGGb61enEcCITQRYx8PbhsKwHw==
X-Google-Smtp-Source: AGHT+IGKW5IRNUhTDGIGdX/0smqng/4kIbMzvIyWLtSAHc+YTXsGIhZctkCMwnyi8xDYKxHk25x0rFSOko2kxA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a25:a4ea:0:b0:db5:378f:1824 with SMTP id
 g97-20020a25a4ea000000b00db5378f1824mr272615ybi.1.1701451387410; Fri, 01 Dec
 2023 09:23:07 -0800 (PST)
Date:   Fri,  1 Dec 2023 17:21:44 +0000
In-Reply-To: <20231201172212.1813387-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201172212.1813387-16-cmllamas@google.com>
Subject: [PATCH v2 15/28] binder: relocate binder_alloc_clear_buf()
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

Move this function up along with binder_alloc_get_page() so that their
prototypes aren't necessary.

No functional change in this patch.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 124 ++++++++++++++++-----------------
 1 file changed, 61 insertions(+), 63 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 167ee6f871dc..99eacd8782b8 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -704,8 +704,68 @@ static void binder_free_buf_locked(struct binder_alloc *alloc,
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
@@ -1148,68 +1208,6 @@ static inline bool check_buffer(struct binder_alloc *alloc,
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
2.43.0.rc2.451.g8631bc7472-goog

