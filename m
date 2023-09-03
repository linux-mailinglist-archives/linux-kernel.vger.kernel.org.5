Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C931790DEB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 22:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347836AbjICUnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 16:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbjICUnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 16:43:04 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E9CB7
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 13:42:59 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68a3d2ff211so269514b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 13:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693773779; x=1694378579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JXGibZhd0taTVixrbZSCfRr4hu2j540PY4zKf4Qgo58=;
        b=qDuCFzRjUG/GedIupVDYshmSd+W54Ypz3JyEXJ2Iaw5BNV6vq4km287CKLJW5jtZ3Q
         /7YfjEbhv0F7UE4XW8LW6hmOEebwf2urVfiXRWWgUrNeIiGOm8MFjy5NIsmqG6+Fb/iD
         xUWKm0yQRt5h4VvcdU4o49Ll33QR7693CRtFXivfI83LSK7PraL+rsASpVEnRGXBlUCU
         lIEdMTH6VS6kAQcLFvE3FritnRXPrhiF9OJ47NhHCcLdQ72g5qynUN3ZPltvlbzefXya
         20nkXDCxyUY8vGBBq66pQH+vJYOOaG6bQ2GTqcw5HltVxsQn6LUnlHePL4boOQd86Yo9
         9XHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693773779; x=1694378579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JXGibZhd0taTVixrbZSCfRr4hu2j540PY4zKf4Qgo58=;
        b=NIDPTdtWTP/fjg8TYDI4cnU4y1yGFA9g80TnUIGOTqEVoq663zhRPX6nq0dbRrPrOe
         MthySUnqSbiHNqG2dUn9SjiZCZlVCzXiqcmzdcsmIk9Nnx2iL7Jhm8CbuZVyqOiTOexr
         B8yYOB5kEeQnwIpl7g+uT/wti+3A0kJQ6r1FxC7kcNsMKC0Jq0VL5dYgc+NCkbcRmheH
         dPN8Br7R7mv6FJJd/rYd4joXJchM7AXXxGmsazh5xHnvrcxpLNkMMI26+PA+jUFqfHPK
         a8n+2krF+o0oYq0Mt3nPYthLitOhqQJH9rtsyvKaRDXdxEkWmAb1bl+6aZEg6BIdPVsr
         08hQ==
X-Gm-Message-State: AOJu0YyIQCHUrVSCxsUj7lTjgwkIOBKx4tCC/f/K546X974Tp2Xw5Xv9
        bs41Ad6xDrA8dVDZMoQ1/GE=
X-Google-Smtp-Source: AGHT+IEl/L3QwigXqov3uKrxBkYzCdkY4ftulgTGmAw6jpo6bKLg3RqHvGRD8LIvaAnuGh1aLipqNQ==
X-Received: by 2002:a17:902:e745:b0:1b8:9fc4:2733 with SMTP id p5-20020a170902e74500b001b89fc42733mr10325866plf.3.1693773778714;
        Sun, 03 Sep 2023 13:42:58 -0700 (PDT)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a018800b002633fa95ac2sm8463749pjc.13.2023.09.03.13.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 13:42:58 -0700 (PDT)
From:   Kuan-Wei Chiu <visitorckw@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, brauner@kernel.org, cmllamas@google.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] binderfs: fix typo in binderfs.c
Date:   Mon,  4 Sep 2023 04:42:50 +0800
Message-Id: <20230903204250.2697370-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The word "wich"
was corrected to "which" for spelling accuracy.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/android/binderfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 81effec17b3d..ae2a8413ec12 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -93,7 +93,7 @@ bool is_binderfs_device(const struct inode *inode)
 /**
  * binderfs_binder_device_create - allocate inode from super block of a
  *                                 binderfs mount
- * @ref_inode: inode from wich the super block will be taken
+ * @ref_inode: inode from which the super block will be taken
  * @userp:     buffer to copy information about new device for userspace to
  * @req:       struct binderfs_device as copied from userspace
  *
-- 
2.25.1

