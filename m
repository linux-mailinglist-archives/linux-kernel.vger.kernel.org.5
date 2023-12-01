Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944D2801189
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378935AbjLARWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378821AbjLARWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:22:39 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DB5197
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:22:44 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5c624e68b45so804508a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701451364; x=1702056164; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=beYmkpS/Tu18Zme3iadSRV/HIEeLF8qFiix2uG+FqSs=;
        b=hUjBaNR1HKHx0U2mqr/61W8gSOz5EQdtGsx2jr1NEGEOysDnGyRPgAPZWylfjlpTrI
         RgOhKRW7aoHNdWuCKy7nhjUa25/dch94bvvrmpPEfqMfMAVD6vyhfK2vG4fHgii17fZB
         fr1DImFAaErCwNUwY17Nhb3ihL9664+1nvQ8ZB4xyGTPYcPgIbnXUSjrUL/dqHoy5hSg
         z+d7ahg8/8ljnreLKKOA9SEfdu9Qmi7koUwyIS+mqa2lNZLYrkrz2wfTXkUeg8cQ7so5
         cgpC+J7GP7ulErWUTL/6s95yCgUvl/0mu3OsmIUL+ysEq+ANu9r/RtGyxV76KjyQVqsC
         5/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451364; x=1702056164;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=beYmkpS/Tu18Zme3iadSRV/HIEeLF8qFiix2uG+FqSs=;
        b=Vm5Pq0C8JS0YBSIl3iC/Pnr+ezj9J+POmUkZbyeF1D+6mmMyCqAMNHxmcSIhupOGKO
         Mwj5QiNLD8sOYI69gdTNAlnkEkt+StJQ6XCIo9E20uz+5xydADotjZjqtPbSs6dRi102
         kFiMLwgW7qgJhkuVq5hp3wN+i8e6fBhZnSC1c+bHT96fjGhMo2pQgeVXCBpgp2oIa6n+
         sN08oNTJRBfTRHn8ux8S2YJnlbYFydt4SCKqYAMTWM8Rdu0viCW2HPEJr2gW87T2B6rq
         89PkYQ4Hfgsf//UKU2gwAOWkLZ9ybfwacrvKjqbcIyUT3ZkMKu6OBrsWtWgNFNIy+QDs
         r26g==
X-Gm-Message-State: AOJu0YxHkSaIxs684a0+MAWlTqoSGiLCftBPSk63zZkWxvpDHklQ3nAF
        /8k1VygzFw/w6oyKOoad3dP7SCQlDZksfw==
X-Google-Smtp-Source: AGHT+IE34OugPrmtYG78WRxo/k5S0QY4yJDHF87iEfRykux2lZbYN+4YpUZRjRV0CTB182Q7aSdrHgDBzZkL8g==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a63:5d49:0:b0:5be:1c3b:9b51 with SMTP id
 o9-20020a635d49000000b005be1c3b9b51mr3812545pgm.5.1701451364489; Fri, 01 Dec
 2023 09:22:44 -0800 (PST)
Date:   Fri,  1 Dec 2023 17:21:34 +0000
In-Reply-To: <20231201172212.1813387-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201172212.1813387-6-cmllamas@google.com>
Subject: [PATCH v2 05/28] binder: fix unused alloc->free_async_space
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sherry Yang <sherryy@android.com>
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

Each transaction is associated with a 'struct binder_buffer' that stores
the metadata about its buffer area. Since commit 74310e06be4d ("android:
binder: Move buffer out of area shared with user space") this struct is
no longer embedded within the buffer itself but is instead allocated on
the heap to prevent userspace access to this driver-exclusive info.

Unfortunately, the space of this struct is still being accounted for in
the total buffer size calculation, specifically for async transactions.
This results in an additional 104 bytes added to every async buffer
request, and this area is never used.

This wasted space can be substantial. If we consider the maximum mmap
buffer space of SZ_4M, the driver will reserve half of it for async
transactions, or 0x200000. This area should, in theory, accommodate up
to 262,144 buffers of the minimum 8-byte size. However, after adding
the extra 'sizeof(struct binder_buffer)', the total number of buffers
drops to only 18,724, which is a sad 7.14% of the actual capacity.

This patch fixes the buffer size calculation to enable the utilization
of the entire async buffer space. This is expected to reduce the number
of -ENOSPC errors that are seen on the field.

Fixes: 74310e06be4d ("android: binder: Move buffer out of area shared with user space")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index abff1bafcc43..9b5c4d446efa 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -344,8 +344,7 @@ static bool debug_low_async_space_locked(struct binder_alloc *alloc, int pid)
 			continue;
 		if (!buffer->async_transaction)
 			continue;
-		total_alloc_size += binder_alloc_buffer_size(alloc, buffer)
-			+ sizeof(struct binder_buffer);
+		total_alloc_size += binder_alloc_buffer_size(alloc, buffer);
 		num_buffers++;
 	}
 
@@ -411,8 +410,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	/* Pad 0-size buffers so they get assigned unique addresses */
 	size = max(size, sizeof(void *));
 
-	if (is_async &&
-	    alloc->free_async_space < size + sizeof(struct binder_buffer)) {
+	if (is_async && alloc->free_async_space < size) {
 		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
 			     "%d: binder_alloc_buf size %zd failed, no async space left\n",
 			      alloc->pid, size);
@@ -520,7 +518,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	buffer->pid = pid;
 	buffer->oneway_spam_suspect = false;
 	if (is_async) {
-		alloc->free_async_space -= size + sizeof(struct binder_buffer);
+		alloc->free_async_space -= size;
 		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC_ASYNC,
 			     "%d: binder_alloc_buf size %zd async free %zd\n",
 			      alloc->pid, size, alloc->free_async_space);
@@ -658,8 +656,7 @@ static void binder_free_buf_locked(struct binder_alloc *alloc,
 	BUG_ON(buffer->user_data > alloc->buffer + alloc->buffer_size);
 
 	if (buffer->async_transaction) {
-		alloc->free_async_space += buffer_size + sizeof(struct binder_buffer);
-
+		alloc->free_async_space += buffer_size;
 		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC_ASYNC,
 			     "%d: binder_free_buf size %zd async free %zd\n",
 			      alloc->pid, size, alloc->free_async_space);
-- 
2.43.0.rc2.451.g8631bc7472-goog

