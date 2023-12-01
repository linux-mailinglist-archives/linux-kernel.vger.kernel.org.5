Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B52801185
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378763AbjLARWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjLARWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:22:34 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5232D4A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:22:40 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5be10675134so806219a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701451360; x=1702056160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B/6Po4/tnNntaDAeP6ov7pxdzhgx9dRD0K+AuBuXOhY=;
        b=268Dr+wrvadvZwi8cLpjnW9opjet/sLNs2nmulFAaxIMtGkrEdRHHOkyuf6OaYfusB
         O73xjl5yRzV5J+dqi5bzFybdJQERX8+ek9LOue8xNq9TW5eoYluHNPetUNynP2GgfnKd
         8OZs/jlfiTAlPn2wsDbRlBD5AlpjIU9WY/Ymub+b+W/BLQcxqSgpGvVEMAaOs5vhsYQ2
         Rm9DxB1+9UKdFlqD5APNh4Ki4Id9EvclWYTXjlycPMkHmjLDSd8rbEeUqp+aGrUaa9XN
         cmfk4pCH93wFB2sfbCBCM9UGiv2k5ugZgFdDI/5Iyg9j0lb6YxmRAXwvkKVe1eVPGqKY
         XhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451360; x=1702056160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B/6Po4/tnNntaDAeP6ov7pxdzhgx9dRD0K+AuBuXOhY=;
        b=FRqE9AxDo8TuuD6ZePn829Z2NyBes1Q28jephv7oAbOCHlsWEwnKUCkZnXNqUNN+jw
         nRQP3/mj2eGpOyqgdYfgzy0b0/palmhpS44xGstWr8fHd/d/SugmRT8HZ0LFdePnqqjD
         lYM/3RhUph2ZRDdtKdJ7DmQnNOYVXtjazaEecbrBJeysO6NQUpJPgD+xg34nNy3uslFf
         9lH+F0RNp5AupfTvAfosRLrG6IlebJsCyOzxkYHsSDpH89otIHZ/zqIdze6f9ID0mAdz
         oHYMwDPL+GOv+5cXufcECcgBKiqGnb18NkKPsFGcKJogJ7Q9tuQt+vC1sDTRY5nJIBsn
         kxbQ==
X-Gm-Message-State: AOJu0YzFmREjQD1ycPIf/d5tKN0SBuzOlZUf68rpfHWpabeb8OhyoohN
        RoKtYokq/zQlyGCeGqfiwuXzGoZTTmhKUw==
X-Google-Smtp-Source: AGHT+IHWyvK3M0LsZmLaINPZeiMhROek+8yo/ObhMVkrkjJKvC7VWvikZ8pv3h03UnY8F3+XjwkMywJAdk2R5g==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:902:c40d:b0:1cf:8819:a986 with SMTP
 id k13-20020a170902c40d00b001cf8819a986mr5430784plk.8.1701451360090; Fri, 01
 Dec 2023 09:22:40 -0800 (PST)
Date:   Fri,  1 Dec 2023 17:21:32 +0000
In-Reply-To: <20231201172212.1813387-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201172212.1813387-4-cmllamas@google.com>
Subject: [PATCH v2 03/28] binder: fix race between mmput() and do_exit()
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Brian Swetland <swetland@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Alice Ryhl <aliceryhl@google.com>,
        Greg Kroah-Hartman <gregkh@suse.de>
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

Task A calls binder_update_page_range() to allocate and insert pages on
a remote address space from Task B. For this, Task A pins the remote mm
via mmget_not_zero() first. This can race with Task B do_exit() and the
final mmput() refcount decrement will come from Task A.

  Task A            | Task B
  ------------------+------------------
  mmget_not_zero()  |
                    |  do_exit()
                    |    exit_mm()
                    |      mmput()
  mmput()           |
    exit_mmap()     |
      remove_vma()  |
        fput()      |

In this case, the work of ____fput() from Task B is queued up in Task A
as TWA_RESUME. So in theory, Task A returns to userspace and the cleanup
work gets executed. However, Task A instead sleep, waiting for a reply
from Task B that never comes (it's dead).

This means the binder_deferred_release() is blocked until an unrelated
binder event forces Task A to go back to userspace. All the associated
death notifications will also be delayed until then.

In order to fix this use mmput_async() that will schedule the work in
the corresponding mm->async_put_work WQ instead of Task A.

Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 9d2eff70c3ba..adcec5ec0959 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -271,7 +271,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 	}
 	if (mm) {
 		mmap_write_unlock(mm);
-		mmput(mm);
+		mmput_async(mm);
 	}
 	return 0;
 
@@ -304,7 +304,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 err_no_vma:
 	if (mm) {
 		mmap_write_unlock(mm);
-		mmput(mm);
+		mmput_async(mm);
 	}
 	return vma ? -ENOMEM : -ESRCH;
 }
-- 
2.43.0.rc2.451.g8631bc7472-goog

