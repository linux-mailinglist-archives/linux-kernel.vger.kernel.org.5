Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DE47F79AF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjKXQst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 11:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjKXQsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:48:47 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F48173D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:48:53 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40b367a0a12so108005e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700844532; x=1701449332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1dT0G2gbK38DhronxeBhd+QT3xLvMQeHXnzz480DWvs=;
        b=4OkkkphAtLvN8ZVjIZtBNL9hKsLCrAF+OsMfE1A9+akr/Z+cqgyP88X26Gw+xxle+S
         7kXy0FonuEZnKwzx6s4Dc/7Kg0aaWazkf96LaFzoNZBOasoHJgfk5+ixf+XrBS/tdeF2
         YW7q+ZsLluW46RNJk0aU+4IfKWnm2ugD0+ibtZaiu3eNquTGPMzNlIrnBDdRxx56keCa
         g8WgCwK+zXqCr2tciL8fPbA59M6V2u66wXhpCkASqMsu1h8Ve6py4jl3BJOTSR/sxSGo
         7Wla9LO6yUroLb3yqUSXZ5OftmmARz54XkTsvZ7h6K+8Jg9VUjP0yJx7UDozolM7YDuP
         0aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700844532; x=1701449332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dT0G2gbK38DhronxeBhd+QT3xLvMQeHXnzz480DWvs=;
        b=mTAROIK635JXp7QLjLtOtpBjH5ir5hhxFi7JbHpPblFlkNnE9Z8Xw1me4Ewd+Rlobx
         9MhRR6Yesf6hKMckVtxv5gbVHa0YGfr9d6Q7zKzq3+H1lpyooujyCi2H1HA6oUQaYpA+
         IUUj7EA08+YziCQd1aFGe0mDz+3VvMt9iXY6NmVtJ7iKfdpBEPMFuFg/ZaNcPJoLgtto
         bSL301SDzfPWR8TFFi4XQQw7dfmU3TypTOSFfeKnWkktxtg64G7RVkf2oE1iNE+6n196
         GgJ6ZFeaUk+eIRSQ01a8z6Y6smXPRou6oF77BbvgsNNyh9wDtw0+vh/mOqTzUwa7+tCb
         fRGw==
X-Gm-Message-State: AOJu0YwUwKRU7d/8Y3QcH8W7nngKDD1nyW/Hzguo8fAzmD8jbD8lReON
        bmbGzgu/qVA5/oZXsiELaitVaQ==
X-Google-Smtp-Source: AGHT+IHm49oNMlWY5POiCh3hcUR/gUWi3s3eZ2aj6/aRqdwGBTLr0vtdenVwTcOUiUNpRiIbMhdJzA==
X-Received: by 2002:a05:600c:4f44:b0:408:3727:92c5 with SMTP id m4-20020a05600c4f4400b00408372792c5mr394412wmq.2.1700844531642;
        Fri, 24 Nov 2023 08:48:51 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:4ea2:a7ce:d5d3:86af])
        by smtp.gmail.com with ESMTPSA id h11-20020a5d504b000000b0032d96dd703bsm4706487wrt.70.2023.11.24.08.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 08:48:50 -0800 (PST)
From:   Jann Horn <jannh@google.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Alex Lyakas <alex.bolshoy.btrfs@gmail.com>,
        Alexander Block <ablock84@googlemail.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: [PATCH] btrfs: send: Ensure send_fd is writable
Date:   Fri, 24 Nov 2023 17:48:31 +0100
Message-ID: <20231124164831.2191549-1-jannh@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel_write() requires the caller to ensure that the file is writable.
Let's do that directly after looking up the ->send_fd.

(We don't need a separate bailout path because the "out" path already
does fput() if ->send_filp is non-NULL.)

This has no security impact for two reasons:

 - the ioctl requires CAP_SYS_ADMIN
 - __kernel_write() bails out on read-only files - but only since 5.8,
   see commit a01ac27be472 ("fs: check FMODE_WRITE in __kernel_write")

Reported-and-tested-by: syzbot+12e098239d20385264d3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=12e098239d20385264d3
Fixes: 31db9f7c23fb ("Btrfs: introduce BTRFS_IOC_SEND for btrfs send/receive")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/btrfs/send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 3b929f0e8f04..4e36550618e5 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -8158,7 +8158,7 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 	}
 
 	sctx->send_filp = fget(arg->send_fd);
-	if (!sctx->send_filp) {
+	if (!sctx->send_filp || !(sctx->send_filp->f_mode & FMODE_WRITE)) {
 		ret = -EBADF;
 		goto out;
 	}

base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
-- 
2.43.0.rc1.413.gea7ed67945-goog

