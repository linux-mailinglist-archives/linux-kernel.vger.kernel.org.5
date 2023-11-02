Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67CC7DFA99
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377459AbjKBTCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377529AbjKBTBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:01:37 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0867310EF
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 12:01:16 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5af9ad9341fso18541757b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 12:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698951676; x=1699556476; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EUiKZhwaB9LOz49GV27F2hA/6y1jP5A4xHlwi/O/CeY=;
        b=2SXr7sY6AXx43vESgdhG1g77pCui8W4jEDT+m8iCFHWyQY4Wlp4ngel2+c/G2hcRsq
         fM6RXneLXqaVC0dp02UrAd/Ui/BT+GE9Hv5/JfIClPLUGNGmwu698mXFDUaHNFEuDSJn
         7bAm7fbfMm8cW29n71SUKRUeGmqsqOo0BhM20Evk9IiSm4r4q0yjJ2ff0WaCQiqMy7ej
         /otfuoqOQZnQ5VTjuFTOgSYOtlWgNC2dKs9Q+16jRmIsKkG8ovPYvy2o6zOYwpSdi6Cy
         5i1467c6wsd9Qo6p4ETW6JpJ6QV2KhYA/ZhLE/MKE9z2YInK3nbjawpvBkrxa023KRtR
         nB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698951676; x=1699556476;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EUiKZhwaB9LOz49GV27F2hA/6y1jP5A4xHlwi/O/CeY=;
        b=Y4kOnlHYnx2alGvZfQ8WDQ0FSzuryYr69TWrGsafWZ65cdnSW5gUdDLiiZbBqv5psh
         Sd3DbUQGCL0J8zIJAqfLo37fXoXhNh/ZIGYLLl11RPRLgYC8RBdNHMV/L1dI3remJw4e
         hMhQK646wIMwT/DAWCDvxaSZWAYUpZYJRyOY8sYlTfLR1Rw30JskhPeT07GBQoqxIpJX
         GOMa++V6vuxr+W8YHcUUmO6Cn89aipDc1DmFuRdsB+PQcf5JNyVdEmKqnbGjwWJzgl7u
         TrzyZoXU2i9O0OWebYlG8L+0Nv1AKGcOZ7e+aTmCDqJhLKfuC5zp0M2tySKpcxJxI6cb
         Pulw==
X-Gm-Message-State: AOJu0YwofXYRvH5ghYwDJjL7maZ1M2W+R1uGd8v8kpqbHyZGZp0+r0fn
        /gSGS48FD+JAIWBe7oBua+XMrDRxyFWB9g==
X-Google-Smtp-Source: AGHT+IH38mulzYoIlQB4Az75C4xyqFrdVV2/+L6sa2zNhWwL19HMiUObBZFUYbME6dnnjeklJ/sHJNp9HUzrEQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a81:9c47:0:b0:5a4:f657:36d9 with SMTP id
 n7-20020a819c47000000b005a4f65736d9mr11320ywa.9.1698951676038; Thu, 02 Nov
 2023 12:01:16 -0700 (PDT)
Date:   Thu,  2 Nov 2023 18:59:21 +0000
In-Reply-To: <20231102185934.773885-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-1-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231102185934.773885-21-cmllamas@google.com>
Subject: [PATCH 20/21] binder: reverse locking order in shrinker callback
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
 drivers/android/binder_alloc.c | 44 ++++++++++++++++------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index e739be7f2dd4..0ba9f524e0ff 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -1065,35 +1065,38 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
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
+	__free_page(page->page_ptr);
+	page->page_ptr = NULL;
+
+	trace_binder_unmap_kernel_end(alloc, index);
+
 	list_lru_isolate(lru, item);
+	mutex_unlock(&alloc->mutex);
 	spin_unlock(lock);
 
 	if (vma) {
@@ -1103,28 +1106,21 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 
 		trace_binder_unmap_user_end(alloc, index);
 	}
+
 	mmap_read_unlock(mm);
 	mmput_async(mm);
 
-	trace_binder_unmap_kernel_start(alloc, index);
-
-	__free_page(page->page_ptr);
-	page->page_ptr = NULL;
-
-	trace_binder_unmap_kernel_end(alloc, index);
-
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
2.42.0.869.gea05f2083d-goog

