Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C36A7DFA91
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377377AbjKBTAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbjKBTAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:00:38 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5615C182
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 12:00:36 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5bd18d54a48so1001298a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 12:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698951636; x=1699556436; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QB2XELWyUcHbwxMPwoh6o4DxLx3LMH175ftg3GV0qrE=;
        b=UnpDaF2X+wY//sVHfcElHJ+GOjFIaz6dlasDN77KPeQtZyBoBVWOJkxGDX94T2Qumv
         gFoIrYn/2RXxtHMV5LqiJVHIk7sVMh66ahoFQpuR3Hsbb9tDTuLYyryHcgKhVcaK42kK
         lgv+zZKcQRDzUnDKMvY4ddFenQLQoXPuYMX4F/H02RA4SOaqMhFo5kCLcnxm1TTn1tK5
         Acxh0ofyjKbop6GCjA2pjfDGBe07X3XlEoJDZtA8d6851CoEkh5N8jTMPsM6yA7twQzL
         XOQu4msePWDblqcmL7wY8d2A4WnF22lXcco/YDMTC7ntm0nFmLgARQIodFzm4AZqAA3V
         Xt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698951636; x=1699556436;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QB2XELWyUcHbwxMPwoh6o4DxLx3LMH175ftg3GV0qrE=;
        b=hNbDWGKPZGKqWOdkQOy93qIQma75d40RxgYFGoF5XodBAWbD2bgEvG3UbZCG1KYeE8
         zsp69iTR7xiffukM8vVC+mnpE9Ee6Ft3jKoqikoDc/axT9ntiLyefj+cb+hXXoxhvZ7X
         JcOjP2UBArKxX+SkaHEp7U+h20/NTKOg89Aqtz3+b8MvaKbk5UUl3tUUY1jZZUZixEuL
         vvuHGVtMWpfrLNc0icE47ZLKuKFdmjp9bhj3TPkHXQCeSnwXSMDIWZAdYgF4tCkHe0Xg
         4NFKb7jTH+DtFY4odGCFiXAP3DpZV/QikEcOvw/ci+mr86STeiX+7mv3dYH3cxYr1EzE
         wgww==
X-Gm-Message-State: AOJu0YxTpJMwrrpvP/2BIJGIsaI0Xd/FXHfwKm+cGyrp7xnO4jdV4WHu
        6OM/v7GhYreNet02oufqNpl3MB8oPx/UbQ==
X-Google-Smtp-Source: AGHT+IFEF7OdYJkPslpLaSXr+OnkymRgONHP1iHEmwOTxZGUbGO8+biuiw8h6xFyRh+xJYaCkmNATjCuy6oRzw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a63:35c3:0:b0:5b0:c0b0:4cd3 with SMTP id
 c186-20020a6335c3000000b005b0c0b04cd3mr343744pga.6.1698951635832; Thu, 02 Nov
 2023 12:00:35 -0700 (PDT)
Date:   Thu,  2 Nov 2023 18:59:04 +0000
In-Reply-To: <20231102185934.773885-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-1-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231102185934.773885-4-cmllamas@google.com>
Subject: [PATCH 03/21] binder: fix race between mmput() and do_exit()
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
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index c4d60d81221b..046c3ae9eb8f 100644
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
2.42.0.869.gea05f2083d-goog

