Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8057801197
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379299AbjLARYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379175AbjLARXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:23:44 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22B8D67
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:23:14 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6cdce35ba97so2290093b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701451394; x=1702056194; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QR9ctGv6DD/cqnUAnvJkNGQFqKISSIWTJ6FZIk1lfN4=;
        b=wCbM/KSaVwi7PC7GtldqNVElZrfj1iPzjGR1U+YLPcdsVRh95S6QRJC3MLzvV1nWLz
         25cx73QUO7eNj+/r1lKLQnP6dCj03xr+0WoD5AFtWY/L4BHTE+oCVZSrgo/rsA2sJ/Ar
         xAOw+j/CPPqOdqOqV1mKPwpVtXdzjzVhOfYJW3j83hBniuo+FbnphVAJCQS0N9Gqbut4
         9MGgmoxyNhed9EgnSy/TVHeUzvl9WhqWO0UrQLuqF7X2Q5BNLsGSshEUOYIqG0nwiJ4W
         kr8n45DN881EUNHA3cL1UdHPS5PzMK2biTdMuY+UAgF3sVfQPo/INA/UK3P7sKZAM8i0
         tSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451394; x=1702056194;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QR9ctGv6DD/cqnUAnvJkNGQFqKISSIWTJ6FZIk1lfN4=;
        b=Lh1nokrCchsNWqlFsrbVHx2DSNdM5DHLa2zRdCRsEG3POuw1wbdfxP6C665EK39OCt
         0EzQrCScrjudrSx3W471/4gRMEnpwtOEq8+eheygBQS5olpKdeLWwZu/up3afJvbb3zR
         Su+WCUIYbA5G2UDAkCGvVeTL0fQj9yDL25Vao9j/Wu5me7gfphW2okwXm5OoSN20LZFx
         LFoZH2ApDBNHxMcyIhzSNOEWn2/l1X5U93dbuuyKVoBDMf10U+NcPjZdqD5iYfGwCEjV
         0is1F5ZsrcS0fdcxiOxwLHXcJl04+yGhK7pbm0rAyzOl0pgRaOoW8+z0YhyfqNj7V3sp
         YDTw==
X-Gm-Message-State: AOJu0YyLxKLu5b0FsZb/KGg8PKT+yoJ6qD4eADGhEpZbC38y+WdmPdpn
        +CE5SH/a96qN1QJnPtEvoptIXLwIU3d+1Q==
X-Google-Smtp-Source: AGHT+IEexwbU8eN6740SghoQkSxMhFv/B/1u51ES3uwG8/KHafMGFnD86hKF60W+Rzj1qsnFaJzcX5jfs7xDAQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6a00:179a:b0:6cd:dda3:4a5e with SMTP
 id s26-20020a056a00179a00b006cddda34a5emr1443775pfg.0.1701451394219; Fri, 01
 Dec 2023 09:23:14 -0800 (PST)
Date:   Fri,  1 Dec 2023 17:21:47 +0000
In-Reply-To: <20231201172212.1813387-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201172212.1813387-19-cmllamas@google.com>
Subject: [PATCH v2 18/28] binder: initialize lru pages in mmap callback
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

Rather than repeatedly initializing some of the binder_lru_page members
during binder_alloc_new_buf(), perform this initialization just once in
binder_alloc_mmap_handler(), after the pages have been created.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 86f4929a55d5..25efdbb2ad5d 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -274,9 +274,6 @@ static int binder_allocate_page_range(struct binder_alloc *alloc,
 
 		trace_binder_alloc_page_start(alloc, index);
 
-		page->alloc = alloc;
-		INIT_LIST_HEAD(&page->lru);
-
 		ret = binder_install_single_page(alloc, page, page_addr);
 		if (ret) {
 			binder_free_page_range(alloc, start, page_addr);
@@ -798,9 +795,9 @@ void binder_alloc_free_buf(struct binder_alloc *alloc,
 int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 			      struct vm_area_struct *vma)
 {
-	int ret;
-	const char *failure_string;
 	struct binder_buffer *buffer;
+	const char *failure_string;
+	int ret, i;
 
 	if (unlikely(vma->vm_mm != alloc->mm)) {
 		ret = -EINVAL;
@@ -829,6 +826,11 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 		goto err_alloc_pages_failed;
 	}
 
+	for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
+		alloc->pages[i].alloc = alloc;
+		INIT_LIST_HEAD(&alloc->pages[i].lru);
+	}
+
 	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
 	if (!buffer) {
 		ret = -ENOMEM;
-- 
2.43.0.rc2.451.g8631bc7472-goog

