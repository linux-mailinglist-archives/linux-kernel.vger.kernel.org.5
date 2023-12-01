Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129CF8011A1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbjLARZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378876AbjLARY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:24:26 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD11A2D4D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:23:34 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1d03cf821e3so7835885ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701451414; x=1702056214; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R10QbbE1tAg2TnHXRI/Zyee2GHyhPtiuv08ug3U3iUY=;
        b=yFf5V7MJ4PvsaX8SHZ9BSjzZyTufQ656+I+JS8Y7hwD354dBoGhY9RHIR44RIQ/imG
         +by5cfeZXToSrkux3nCt74KM517CowJDHvjefiQm71hGRNcWS9viE7arck49CtfGX3tk
         26lYySfkrrmqma83AAqyBILMA1z8dCt5RXyKmsFRKMRJpmDbfEB84ydbdUM+g+PNO/oz
         L/OlXc4Z+ZAQlCf4b1D08bP0mUwPtzghza00+Uj3DY+TwZgGb6L5GwoSqD+EJmZhTgT7
         PTDcCcA0X6HzN9hCqSTzn4hKV5ACenZWoenvGrEK4EUmfdvg8/CDjcEwW3AV+pa7rEzV
         Jg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451414; x=1702056214;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R10QbbE1tAg2TnHXRI/Zyee2GHyhPtiuv08ug3U3iUY=;
        b=jBUB4K/HUvyLuMmkboMhT7GhK0Qpixj43xUXsNlMCXQIHZZSZFtjX3wWRm5Hll6nS1
         fdko3y4XZY0Ugvmp0k7NTXd5iGg78qKisTUuspyPyjrdrSV/yj5MDjdVCAbM3kzjum7I
         LHkm3lFXRt3j3dFaH6uNvzzAjhafKSeb1XGGNH1QlkTugQziypnN6OpLdYONbQbyIFB3
         ZaSp2fbn7o8o2otRGVbReo2HVW9sY3CPjl+n6LKTTLm4bpKKPUkLLjIHwjJl/GP8PXF/
         0VdWJD4EHuonvXQlt7Ik+C3CQlZ0ALVuLzSo3HAgMDLRX/YcTeJaytNMaVRtC87x8rxj
         WQfw==
X-Gm-Message-State: AOJu0YyZAQ345R5pIhPptvUidomIfll+RAHWh4gRkewgvITFYtGo2k1w
        9drjXWSdDK1stvRA9BBXomsLmnto54nTxA==
X-Google-Smtp-Source: AGHT+IEQEt7/aVDjFByl7qyESinjbF3pWH3tz08mrdD2ebSJZjVDK43SXCxfESVWjSnKwirxGk/MqNcR2gbgKQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:902:daca:b0:1cf:c518:fa3b with SMTP
 id q10-20020a170902daca00b001cfc518fa3bmr3943995plx.4.1701451414403; Fri, 01
 Dec 2023 09:23:34 -0800 (PST)
Date:   Fri,  1 Dec 2023 17:21:56 +0000
In-Reply-To: <20231201172212.1813387-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201172212.1813387-28-cmllamas@google.com>
Subject: [PATCH v2 27/28] binder: reverse locking order in shrinker callback
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

The locking order currently requires the alloc->mutex to be acquired
first followed by the mmap lock. However, the alloc->mutex is converted
into a spinlock in subsequent commits so the order needs to be reversed
to avoid nesting the sleeping mmap lock under the spinlock.

The shrinker's callback binder_alloc_free_page() is the only place that
needs to be reordered since other functions have been refactored and no
longer nest these locks.

Some minor cosmetic changes are also included in this patch.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 46 ++++++++++++++++------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 5783675f2970..a3e56637db4f 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -1061,35 +1061,39 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 				       void *cb_arg)
 	__must_hold(lock)
 {
-	struct mm_struct *mm = NULL;
-	struct binder_lru_page *page = container_of(item,
-						    struct binder_lru_page,
-						    lru);
-	struct binder_alloc *alloc;
+	struct binder_lru_page *page = container_of(item, typeof(*page), lru);
+	struct binder_alloc *alloc = page->alloc;
+	struct mm_struct *mm = alloc->mm;
+	struct vm_area_struct *vma;
+	struct page *page_to_free;
 	unsigned long page_addr;
 	size_t index;
-	struct vm_area_struct *vma;
 
-	alloc = page->alloc;
+	if (!mmget_not_zero(mm))
+		goto err_mmget;
+	if (!mmap_read_trylock(mm))
+		goto err_mmap_read_lock_failed;
 	if (!mutex_trylock(&alloc->mutex))
 		goto err_get_alloc_mutex_failed;
-
 	if (!page->page_ptr)
 		goto err_page_already_freed;
 
 	index = page - alloc->pages;
 	page_addr = alloc->buffer + index * PAGE_SIZE;
 
-	mm = alloc->mm;
-	if (!mmget_not_zero(mm))
-		goto err_mmget;
-	if (!mmap_read_trylock(mm))
-		goto err_mmap_read_lock_failed;
 	vma = vma_lookup(mm, page_addr);
 	if (vma && vma != binder_alloc_get_vma(alloc))
 		goto err_invalid_vma;
 
+	trace_binder_unmap_kernel_start(alloc, index);
+
+	page_to_free = page->page_ptr;
+	page->page_ptr = NULL;
+
+	trace_binder_unmap_kernel_end(alloc, index);
+
 	list_lru_isolate(lru, item);
+	mutex_unlock(&alloc->mutex);
 	spin_unlock(lock);
 
 	if (vma) {
@@ -1099,28 +1103,22 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 
 		trace_binder_unmap_user_end(alloc, index);
 	}
+
 	mmap_read_unlock(mm);
 	mmput_async(mm);
-
-	trace_binder_unmap_kernel_start(alloc, index);
-
-	__free_page(page->page_ptr);
-	page->page_ptr = NULL;
-
-	trace_binder_unmap_kernel_end(alloc, index);
+	__free_page(page_to_free);
 
 	spin_lock(lock);
-	mutex_unlock(&alloc->mutex);
 	return LRU_REMOVED_RETRY;
 
 err_invalid_vma:
+err_page_already_freed:
+	mutex_unlock(&alloc->mutex);
+err_get_alloc_mutex_failed:
 	mmap_read_unlock(mm);
 err_mmap_read_lock_failed:
 	mmput_async(mm);
 err_mmget:
-err_page_already_freed:
-	mutex_unlock(&alloc->mutex);
-err_get_alloc_mutex_failed:
 	return LRU_SKIP;
 }
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

