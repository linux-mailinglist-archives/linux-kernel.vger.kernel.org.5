Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDF080118A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378877AbjLARW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378875AbjLARWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:22:42 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D78D40
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:22:47 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cfccc9d6bcso8814175ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701451367; x=1702056167; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VC2uJLzEqyfXA07DP6aRcEwY5WDZYJjFpRfi6yvMkTY=;
        b=DM4YkdGpaS+Q4/yBF4UQ7iF6WTlEMj4+z4R6cDBPMZOrlBrBkCtTGniUQ6rSvNfH7z
         kp3iOVYyXQuoieP7RCz6lXojvaRY0OBSIzC9oZV/Q/GIa0H6EOBJCHR6XF3NHflK8i/C
         X54aVeJ20Uib0ooDcDRg4LMEIkyK1DxW/ApZmB0t1zHrli6lDWMIexG1wpQ4KFZlDab4
         JR3vHbveX2MhCQ933OEBI7BlEVI8RVLJuvsfW5I/GOtOXn2FZP68uLw9u1LMpcYP6GxM
         ct0aimurUfOBHvxNy4ZUHVcAuD5Q8JueDR7AEB+gZ0k8L86jBdX18ORkkQzn+JAsGinY
         ElTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451367; x=1702056167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VC2uJLzEqyfXA07DP6aRcEwY5WDZYJjFpRfi6yvMkTY=;
        b=JUq6gmCS7kX3dwcvQlnuSHVqIhWW8/PgPS6vR7LzvtGDJXl5k4KplB0djWnYkMP3m7
         N8zymS7dpCwfb6MMBKNtx+wCbruaiCGh3LWYm+4VoA6LOE/dCTKU29xNBstvjEVXLc6V
         ykVul0clktf8813ZIjfibor5KkyLgA1U32nGecN+t9vHt/nXUbkaGx+bYuie6r/uT5Pm
         M4+6YnQSRdaxuCzm9uicIdAxBfrGVbcjGReebEWOvaMpiBdrMnTk/6B8hF6VUmlt5e8w
         hPEVZqdCAoD8lM74RyoFJLaEukHzvvOaLD+HpxYZ5+4g1tzWTpEVavCXxvWxWcZf84MR
         XchQ==
X-Gm-Message-State: AOJu0YykC1+/tl8l6zFZPDM0It14LcHBZPrsey6eXa8zoKgfi/0oa+tk
        fC3bPAk4U2VNA7B3QosFmClVSv0ePhdNSg==
X-Google-Smtp-Source: AGHT+IEkcV1p6eqdu0bez7LWIawyKVoI1FER2wUkLTAiVsOWMewcldTbRdmYDL1RqOrJrrmFZZ1q2xec/67Bmg==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:902:8644:b0:1d0:3090:957d with SMTP
 id y4-20020a170902864400b001d03090957dmr668283plt.11.1701451366752; Fri, 01
 Dec 2023 09:22:46 -0800 (PST)
Date:   Fri,  1 Dec 2023 17:21:35 +0000
In-Reply-To: <20231201172212.1813387-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201172212.1813387-7-cmllamas@google.com>
Subject: [PATCH v2 06/28] binder: fix trivial typo of binder_free_buf_locked()
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
        stable@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>,
        Todd Kjos <tkjos@google.com>
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

Fix minor misspelling of the function in the comment section.

No functional changes in this patch.

Cc: stable@vger.kernel.org
Fixes: 0f966cba95c7 ("binder: add flag to clear buffer on txn complete")
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 9b5c4d446efa..a124d2743c69 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -704,7 +704,7 @@ void binder_alloc_free_buf(struct binder_alloc *alloc,
 	/*
 	 * We could eliminate the call to binder_alloc_clear_buf()
 	 * from binder_alloc_deferred_release() by moving this to
-	 * binder_alloc_free_buf_locked(). However, that could
+	 * binder_free_buf_locked(). However, that could
 	 * increase contention for the alloc mutex if clear_on_free
 	 * is used frequently for large buffers. The mutex is not
 	 * needed for correctness here.
-- 
2.43.0.rc2.451.g8631bc7472-goog

