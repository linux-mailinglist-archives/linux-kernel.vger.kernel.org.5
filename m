Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5962E8011A0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjLARY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378910AbjLARYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:24:23 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C971D2737
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:23:32 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-6cdec0b65c4so1870595b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701451412; x=1702056212; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pojnWfM9KfFlArpt4ThBC/czdXQ48psB9v2KZMp+fZQ=;
        b=TKmBf6K0sX9Z+lAUvGuzAhWgwUDtugLUOp9NHL8zaVi5VZ/b89nY7l0Et3AfSpf48+
         NFrcODgNSNlRHgfaIV8tsvu9tTzYWTYyVMgvyYXstAqUcI4Tz5spK5RzZPC0AAKB6oC/
         qgWYeZdq9f8jKBTcOB74bDIpLLv1y+m/rzRQQFDZ83qi8yo56w/DTUM4wyzafyYiXBN6
         MDCdfQroM6jT3YbGtZBhyoNC5AlEziHKtFh6FMaaG179vZRkIQ6nuGgNWE8L6hhZA6bT
         BFpx4Yo/zwjFx0U695K5QlgglTe03OAy26NtG5i8upT1FjQYG2gr6H5DwLSUKtMfzk5e
         ayqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451412; x=1702056212;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pojnWfM9KfFlArpt4ThBC/czdXQ48psB9v2KZMp+fZQ=;
        b=W5eYrS2Z6Dzw0G/QlVLCd1oSAVSzhEralYeYUcfNzo5anNM9trXFts2uMD2FqigjMj
         30fz1VZyGdhqrDeppWKjKAAtwaYXMtJgzLn8TiON9akbjfWSOHfNyzjlqzhEWJppiUM2
         wylb+s9my3pawftJ83KgFHDbTmL4dxCfpG30T0Z0FJ9pnMTyx5jvZ+1tGdwrch9lkNmY
         Tqherc82PFoIjo/2p+IUudft70YZQsqj+8T+poXDo8rs/sqh5fQ7aYT6GHUHuX8fdvfY
         VjsQc187mJxnf9g6Ep2uVCWladqzzb+zQNBBo3vw6tdums0dqe7nXbdHDFhV16m5i1/W
         CKRA==
X-Gm-Message-State: AOJu0YxOxkKUDaGXp6X4Q9Y2QtuaeR97uMA01wjS7VIMPBFDe3FTExMM
        uWV+DKZkXSTc+gJTh/LTHJVKRZkmgwr09Q==
X-Google-Smtp-Source: AGHT+IH8Wl4IidUllInIFp6F5TJKA20s9fFSsUJD/TVmJAxfFMx2EotfByvGpls+s3Ml2UbBJ9rmQtVSWorYVw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6a00:1881:b0:6cd:dd05:8974 with SMTP
 id x1-20020a056a00188100b006cddd058974mr1577387pfh.3.1701451412254; Fri, 01
 Dec 2023 09:23:32 -0800 (PST)
Date:   Fri,  1 Dec 2023 17:21:55 +0000
In-Reply-To: <20231201172212.1813387-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201172212.1813387-27-cmllamas@google.com>
Subject: [PATCH v2 26/28] binder: avoid user addresses in debug logs
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

Prefer logging vma offsets instead of addresses or simply drop the debug
log altogether if not useful. Note this covers the instances affected by
the switch to store addresses as unsigned long. However, there are other
sections in the driver that could do the same.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c       |  4 ++--
 drivers/android/binder_alloc.c | 15 ++++++---------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 45674af6310f..c4bb18305e77 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5980,9 +5980,9 @@ static void print_binder_transaction_ilocked(struct seq_file *m,
 	}
 	if (buffer->target_node)
 		seq_printf(m, " node %d", buffer->target_node->debug_id);
-	seq_printf(m, " size %zd:%zd data %lx\n",
+	seq_printf(m, " size %zd:%zd offset %lx\n",
 		   buffer->data_size, buffer->offsets_size,
-		   buffer->user_data);
+		   proc->alloc.buffer - buffer->user_data);
 }
 
 static void print_binder_work_ilocked(struct seq_file *m,
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index c3fc90966867..5783675f2970 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -250,8 +250,8 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 
 	ret = vm_insert_page(alloc->vma, addr, page);
 	if (ret) {
-		pr_err("%d: %s failed to insert page at %lx with %d\n",
-		       alloc->pid, __func__, addr, ret);
+		pr_err("%d: %s failed to insert page at offset %lx with %d\n",
+		       alloc->pid, __func__, addr - alloc->buffer, ret);
 		__free_page(page);
 		ret = -ENOMEM;
 		goto out;
@@ -305,10 +305,6 @@ static void binder_lru_freelist_del(struct binder_alloc *alloc,
 	struct binder_lru_page *page;
 	unsigned long page_addr;
 
-	binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
-			   "%d: pages %lx-%lx\n",
-			   alloc->pid, start, end);
-
 	trace_binder_update_page_range(alloc, true, start, end);
 
 	for (page_addr = start; page_addr < end; page_addr += PAGE_SIZE) {
@@ -939,8 +935,8 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 					      &alloc->pages[i].lru);
 			page_addr = alloc->buffer + i * PAGE_SIZE;
 			binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
-				     "%s: %d: page %d at %lx %s\n",
-				     __func__, alloc->pid, i, page_addr,
+				     "%s: %d: page %d %s\n",
+				     __func__, alloc->pid, i,
 				     on_lru ? "on lru" : "active");
 			__free_page(alloc->pages[i].page_ptr);
 			page_count++;
@@ -974,7 +970,8 @@ void binder_alloc_print_allocated(struct seq_file *m,
 	for (n = rb_first(&alloc->allocated_buffers); n; n = rb_next(n)) {
 		buffer = rb_entry(n, struct binder_buffer, rb_node);
 		seq_printf(m, "  buffer %d: %lx size %zd:%zd:%zd %s\n",
-			   buffer->debug_id, buffer->user_data,
+			   buffer->debug_id,
+			   buffer->user_data - alloc->buffer,
 			   buffer->data_size, buffer->offsets_size,
 			   buffer->extra_buffers_size,
 			   buffer->transaction ? "active" : "delivered");
-- 
2.43.0.rc2.451.g8631bc7472-goog

