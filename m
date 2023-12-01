Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2351B801195
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379123AbjLARYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379112AbjLARXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:23:37 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A9CD7E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:23:10 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db53c05f802so730605276.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701451389; x=1702056189; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XPjAcXnouh2o+XmMfaTxFmkabR0/vLLDLuDUEN73D48=;
        b=DaP0newyjse/hhGkIi38DyJzIH1nBW/CmfvgDQ3Thm6oNVUp6Nr26wOazuyDTLcfit
         dn6DY3arGMPnMhAqBsPARxML7R+w7FEXwOqf3PrzuoNDueiRrVyhCtYjTA0KlCJhUzyF
         4qy3buQjqhUYIhgHbdExqmTADkCXAg8qgyE7eK6mgccdFGFXjxY8gCKj8oGQVkzRHWmb
         a+oQMAdHXa9bC1Wro0mRIe8q1UyJ/Jwm8co58q74B5km/GItdeV1Z9yCqZPgX4894crk
         sBLA62okPC9eGgSKc65sdtwbZQ2CF7eH8HZLYItQorZu/LoYVgKUwTI1U2Uk1EdfY4Ux
         gDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451389; x=1702056189;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XPjAcXnouh2o+XmMfaTxFmkabR0/vLLDLuDUEN73D48=;
        b=spXrlBz0Mx8sGJeYbFuDQQrBImsj/XnP10jpCx/t4rOxwl7BeWhhrvhfihT2kAcBrc
         fsZ1c9+gKwp4Y7jzTOtb3/H1I7X2WZnzH4tOSXmDZ8OsrWwAeUOP+HOOixEXIjxlcFnA
         poM9nYzy2+nJHnPpMfbbF/5fuaO3XmVDdW13GAvz+u1TvyemTsfRuNpmYB2MsGbsXFD/
         kd3pld9NfzZWmRi9V4nZHO/NO2Rq5Nungidn+COTRa+En8KWo05qwFDNPKew3uqtiWIA
         4GfW/PvtG7h35dCq6CCxTU6NdpB5hHvwRwXJ6zU4QfoZoSZM6t3HG0Uvbpmf30C/4yFZ
         I+Lw==
X-Gm-Message-State: AOJu0YxPm3jMEmktb3O3wRFzb6YrrBAgy0Inka9mxsIKVaza2/qXBEEb
        /ElnHfa/38gTwiEzdWAd3dJrSxfFuoDBhw==
X-Google-Smtp-Source: AGHT+IESvmBtbsjfeFnQvzKzCLW/p+HSNOeltrLGEFviHPnpS8upuhZnGWFUHNP8U0QGFjZSg5Ta4g/HPqHaQw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a25:33c2:0:b0:da0:6216:7990 with SMTP id
 z185-20020a2533c2000000b00da062167990mr1047568ybz.3.1701451389726; Fri, 01
 Dec 2023 09:23:09 -0800 (PST)
Date:   Fri,  1 Dec 2023 17:21:45 +0000
In-Reply-To: <20231201172212.1813387-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201172212.1813387-17-cmllamas@google.com>
Subject: [PATCH v2 16/28] binder: refactor page range allocation
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

Instead of looping through the page range twice to first determine if
the mmap lock is required, simply do it per-page as needed. Split out
all this logic into a separate binder_install_single_page() function.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 107 +++++++++++++++------------------
 1 file changed, 47 insertions(+), 60 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 99eacd8782b8..1caf0e3d3451 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -199,14 +199,51 @@ static void binder_free_page_range(struct binder_alloc *alloc,
 	}
 }
 
+static int binder_install_single_page(struct binder_alloc *alloc,
+				      struct binder_lru_page *lru_page,
+				      unsigned long addr)
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
@@ -218,32 +255,9 @@ static int binder_allocate_page_range(struct binder_alloc *alloc,
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
@@ -258,26 +272,15 @@ static int binder_allocate_page_range(struct binder_alloc *alloc,
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
+		ret = binder_install_single_page(alloc, page, page_addr);
 		if (ret) {
-			pr_err("%d: binder_alloc_buf failed to map page at %lx in userspace\n",
-			       alloc->pid, page_addr);
-			goto err_vm_insert_page_failed;
+			binder_free_page_range(alloc, start, page_addr);
+			return ret;
 		}
 
 		if (index + 1 > alloc->pages_high)
@@ -285,24 +288,8 @@ static int binder_allocate_page_range(struct binder_alloc *alloc,
 
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
2.43.0.rc2.451.g8631bc7472-goog

