Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401F17DFA9D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377562AbjKBTB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377485AbjKBTBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:01:32 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96951B3
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 12:01:07 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5b9a1494e65so955006a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 12:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698951667; x=1699556467; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aVzeNsrhFxDI/jOpRx8dBpYw5Z5e6SHn+B/lZdoXIWc=;
        b=O0kw0Mgoje4pYGsmFeJcdjG1CJO06LpZC1UU0bYWUZsrVBdz6EcCfjyTCpIS13cJO5
         SKkeRR3er7hN12nPml93bUKVjMCVctVKLSS0ctZRrnjO9kvUOj1CtymP7BDnsQAj/MRS
         TEHXbWoc3XtYLzKOw5Zol+YsIJY6bLXWaGs1UyDFoSm6HRlg4GyrQmYa+V1URa+8TUms
         /JIwitUra/r0A0Pfy3LqVpYvSPucPZj0PBDDec1byWh5W5YaFadYSwd7uBGuTc4Sihti
         qkVNOe6Bm9iUAQ09ujkhYyjqnknh/kymBCTQOusCP0S2hGegUwmnZgFDKdttzRupCxBK
         e5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698951667; x=1699556467;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aVzeNsrhFxDI/jOpRx8dBpYw5Z5e6SHn+B/lZdoXIWc=;
        b=Vmh4zFofdCgShnVud1otQo86ieZ+lRsnJfXAqiGi1YSaT7qkev6TNK/r+0+w2YMKrD
         XHlm2Pg9XPKxcc5Dazi+3d4xoWomFNOhWgYOlFkOCbOsGp8YS0fTltChRDGQTofUOTzg
         rOxWpHDglJTBGFbzA2ilbGms7Ulg2XISkyo/1p4i3yNfAhe+Zmia6T+JC9YVioNKkBvv
         qaUjo3Tu/VLOctp1qXpItlyPo7/68g+65E2UieNK7Ygo+c9fYAuOaKIbCibaI9YYnqMp
         xe/P5SDkG5Az4AT5PdpbAS0mT0C2uwEFvPf7e2QewW6bTVYG5scsdsgWs0E66r/QZq90
         uw7A==
X-Gm-Message-State: AOJu0YwX0BGXsV9OPa7NcdLUeyDPYP+Su6kOHi+yFyxFkQCuddiwKHW4
        +Gecac0wLYCw533PzcS36MI6SYigbR3ruA==
X-Google-Smtp-Source: AGHT+IGC+gTosBpbNifDSoF4YeNYx4QzxVdvqPxSVnhtp5e49MURkp36/roScjs4oz5FkSSIQbXiXmkQBVFgMA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a63:4106:0:b0:5bd:3e1c:c163 with SMTP id
 o6-20020a634106000000b005bd3e1cc163mr14660pga.1.1698951667091; Thu, 02 Nov
 2023 12:01:07 -0700 (PDT)
Date:   Thu,  2 Nov 2023 18:59:17 +0000
In-Reply-To: <20231102185934.773885-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-1-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231102185934.773885-17-cmllamas@google.com>
Subject: [PATCH 16/21] binder: refactor page range allocation
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

Instead of looping through the page range twice to first determine if
the mmap lock is required, simply do it per-page as needed. Split out
all this logic into a separate binder_get_user_page_remote() function.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 107 +++++++++++++++------------------
 1 file changed, 47 insertions(+), 60 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 4821a29799c8..56936430954f 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -203,14 +203,51 @@ static void binder_free_page_range(struct binder_alloc *alloc,
 	}
 }
 
+static int binder_get_user_page_remote(struct binder_alloc *alloc,
+				       struct binder_lru_page *lru_page,
+				       unsigned long addr)
+{
+	struct page *page;
+	int ret = 0;
+
+	if (!mmget_not_zero(alloc->mm))
+		return -ESRCH;
+
+	mmap_write_lock(alloc->mm);
+	if (!alloc->vma) {
+		pr_err("%d: %s failed, no vma\n", alloc->pid, __func__);
+		ret = -ESRCH;
+		goto out;
+	}
+
+	page = alloc_page(GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO);
+	if (!page) {
+		pr_err("%d: failed to allocate page\n", alloc->pid);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = vm_insert_page(alloc->vma, addr, page);
+	if (ret) {
+		pr_err("%d: %s failed to insert page at %lx with %d\n",
+		       alloc->pid, __func__, addr, ret);
+		__free_page(page);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	lru_page->page_ptr = page;
+out:
+	mmap_write_unlock(alloc->mm);
+	mmput_async(alloc->mm);
+	return ret;
+}
+
 static int binder_allocate_page_range(struct binder_alloc *alloc,
 				      unsigned long start, unsigned long end)
 {
-	struct vm_area_struct *vma = NULL;
 	struct binder_lru_page *page;
-	struct mm_struct *mm = NULL;
 	unsigned long page_addr;
-	bool need_mm = false;
 
 	binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
 			   "%d: allocate pages %lx-%lx\n",
@@ -222,32 +259,9 @@ static int binder_allocate_page_range(struct binder_alloc *alloc,
 	trace_binder_update_page_range(alloc, true, start, end);
 
 	for (page_addr = start; page_addr < end; page_addr += PAGE_SIZE) {
-		page = &alloc->pages[(page_addr - alloc->buffer) / PAGE_SIZE];
-		if (!page->page_ptr) {
-			need_mm = true;
-			break;
-		}
-	}
-
-	if (need_mm && mmget_not_zero(alloc->mm))
-		mm = alloc->mm;
-
-	if (mm) {
-		mmap_write_lock(mm);
-		vma = alloc->vma;
-	}
-
-	if (!vma && need_mm) {
-		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
-				   "%d: binder_alloc_buf failed to map pages in userspace, no vma\n",
-				   alloc->pid);
-		goto err_no_vma;
-	}
-
-	for (page_addr = start; page_addr < end; page_addr += PAGE_SIZE) {
-		int ret;
+		unsigned long index;
 		bool on_lru;
-		size_t index;
+		int ret;
 
 		index = (page_addr - alloc->buffer) / PAGE_SIZE;
 		page = &alloc->pages[index];
@@ -262,26 +276,15 @@ static int binder_allocate_page_range(struct binder_alloc *alloc,
 			continue;
 		}
 
-		if (WARN_ON(!vma))
-			goto err_page_ptr_cleared;
-
 		trace_binder_alloc_page_start(alloc, index);
-		page->page_ptr = alloc_page(GFP_KERNEL |
-					    __GFP_HIGHMEM |
-					    __GFP_ZERO);
-		if (!page->page_ptr) {
-			pr_err("%d: binder_alloc_buf failed for page at %lx\n",
-			       alloc->pid, page_addr);
-			goto err_alloc_page_failed;
-		}
+
 		page->alloc = alloc;
 		INIT_LIST_HEAD(&page->lru);
 
-		ret = vm_insert_page(vma, page_addr, page->page_ptr);
+		ret = binder_get_user_page_remote(alloc, page, page_addr);
 		if (ret) {
-			pr_err("%d: binder_alloc_buf failed to map page at %lx in userspace\n",
-			       alloc->pid, page_addr);
-			goto err_vm_insert_page_failed;
+			binder_free_page_range(alloc, start, page_addr);
+			return ret;
 		}
 
 		if (index + 1 > alloc->pages_high)
@@ -289,24 +292,8 @@ static int binder_allocate_page_range(struct binder_alloc *alloc,
 
 		trace_binder_alloc_page_end(alloc, index);
 	}
-	if (mm) {
-		mmap_write_unlock(mm);
-		mmput_async(mm);
-	}
-	return 0;
 
-err_vm_insert_page_failed:
-	__free_page(page->page_ptr);
-	page->page_ptr = NULL;
-err_alloc_page_failed:
-err_page_ptr_cleared:
-	binder_free_page_range(alloc, start, page_addr);
-err_no_vma:
-	if (mm) {
-		mmap_write_unlock(mm);
-		mmput_async(mm);
-	}
-	return vma ? -ENOMEM : -ESRCH;
+	return 0;
 }
 
 static inline void binder_alloc_set_vma(struct binder_alloc *alloc,
-- 
2.42.0.869.gea05f2083d-goog

