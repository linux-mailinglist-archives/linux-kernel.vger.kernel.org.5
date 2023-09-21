Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1807AA16E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjIUVCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjIUVBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:01:52 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943DF580B1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:12:15 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-404fbfac998so14743435e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695319934; x=1695924734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08cpvcrCpdCUD29e4UfDmA8S+Uy08AnVrTRRsGrC/bY=;
        b=HSIHYQK5bawTfqMQGWEK07nFoZMPZTh0XmGRrXdx9dibJr5ATt03wbQx7pdZTRXxbW
         9fdMrlWf4VfH6IKxHV6N5C6bFDVbHDGJLhlmY+KrruiA3dbXOVIC26B19PSE7WHMsGy4
         cP3I4Snm14Pid2nDj0++/MLW5LtBfKrBiNJZM8qFNnlNcWmBJ1M3sJo02nwRJVQZgIg0
         dbox8VpfRu/QQc377XXSYdhvyycnICd813pKUP9GjzenCDAk2HE0W47G3XLfq6XoNiAK
         TVfvZcKXiUjMbAJKa0ajq2ryJx4BO6TLUFlCYuVPqWxhu32gyLWUrctQWTzBfKwKggts
         m6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319934; x=1695924734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=08cpvcrCpdCUD29e4UfDmA8S+Uy08AnVrTRRsGrC/bY=;
        b=RF7846pSWoY5aUfU3k5dJZXCEIc7jIJs23pOu/dmBGiHX0lvD6aWqbdYtwtAwwfxrY
         1Pf8xyEqGg5jn0ZcqrmEFzl4vAqUFxKqIbX9OFV20Q1zGW4kjfZhDjvbDbb/kQOdaKHZ
         UNrrAOYYso6GBPxeZ4z+KcJOUbRlKP+R97Ciuf7lWtBzHaH5SCiPIPt+yiWvMSvlFza4
         S/RYqxp2Hha4PeZAdG/5JzdDobIwsFUitxYhc2WzyJo1CXlst5cMRvunS4oQXuiZBhsA
         kJeAoBAwF16LKot7vDt2wPx3dLC6BmLKlJebehWhEDOeAp3FravtJmMJSDuNMuMhSJKo
         Jx/A==
X-Gm-Message-State: AOJu0YxmY58AFwWJgmF7khush1p0eayzqgbD8DUaebBYGRUhdc+G7uKX
        9ArQYHysnl1up+//+In8P+YNcw9W5SurWBS9NlY=
X-Google-Smtp-Source: AGHT+IHKMTqeR6eWT3SKwedq8Ouyyzy3Vjxtlx04nLKDFKoBcTp5eNB7RjdnrInQXt2I0atyD2orOQ==
X-Received: by 2002:a05:600c:21ce:b0:401:519:d2 with SMTP id x14-20020a05600c21ce00b00401051900d2mr4093726wmj.23.1695283083252;
        Thu, 21 Sep 2023 00:58:03 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f209c00529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f20:9c00:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id v4-20020a05600c214400b003fef19bb55csm1151252wml.34.2023.09.21.00.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 00:58:03 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, howells@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 3/4] fs/pipe: remove unnecessary spinlock from pipe_write()
Date:   Thu, 21 Sep 2023 09:57:54 +0200
Message-Id: <20230921075755.1378787-3-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230921075755.1378787-1-max.kellermann@ionos.com>
References: <20230921075755.1378787-1-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 8df441294dd3 ("pipe: Check for ring full inside of
the spinlock in pipe_write()") which was obsoleted by commit
c73be61cede ("pipe: Add general notification queue support") because
now pipe_write() fails early with -EXDEV if there is a watch_queue.

Without a watch_queue, no notifications can be posted to the pipe and
mutex protection is enough, as can be seen in splice_pipe_to_pipe()
which does not use the spinlock either.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/pipe.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 6ecaccb48738..939def02c18c 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -505,16 +505,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 			 * it, either the reader will consume it or it'll still
 			 * be there for the next write.
 			 */
-			spin_lock_irq(&pipe->rd_wait.lock);
-
-			head = pipe->head;
-			if (pipe_full(head, pipe->tail, pipe->max_usage)) {
-				spin_unlock_irq(&pipe->rd_wait.lock);
-				continue;
-			}
-
 			pipe->head = head + 1;
-			spin_unlock_irq(&pipe->rd_wait.lock);
 
 			/* Insert it into the buffer array */
 			buf = &pipe->bufs[head & mask];
-- 
2.39.2

