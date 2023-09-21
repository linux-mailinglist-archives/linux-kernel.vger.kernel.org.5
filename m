Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB757A9D72
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjIUThS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjIUThB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:37:01 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C41FBB33
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:12:33 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9ad8bba8125so172000466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695323552; x=1695928352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ln8pAXov2i3W9jm1L6DymijJbQvZk3PVbO+zm8QE4Tk=;
        b=S373tAqMm0OSLe8ccVaqtclKSPf62bjkwoM5pxazLkqmEKdxhANXGyVBOnJ7cl67qI
         uKgX5YBDYRB52PJeAvKAnzl47FChzi1EfnmrOlgAm0hTPJ2WXUBzPYbAoQSoHMtczQqL
         4Pl7/deynA/1c9WoEHSFX+9WsBnSFV7mzyi6deZkdVOWpmB1NNL3nLt1IxON6QR5hnb5
         Nye9kUbKCHU1XH+0eVRxFe0P9XIVUpEqRO4MF+RjURkWSWTurYab3OeWtoIKVXvTZ7EE
         52kqwsVEGbb8+UC0oLuVKRHSm3WnFm5c9pxyfg6lazHyYOlmSYQrPNt63lwWPUy0QKOO
         domQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695323552; x=1695928352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ln8pAXov2i3W9jm1L6DymijJbQvZk3PVbO+zm8QE4Tk=;
        b=YaYHJXVwHgS2LbUv+i3zzpKgKpnjCBNNySNSD/PwLDMC6CmzQhQaiVIUXCysVHfVKU
         VgyErS/Qi2VCyKr3WwD5ZuzEarecTHrPlXMhCSpzhZ9UyQUf06Yot7kW56QfjS5ziuNZ
         mqs7EGG7qRsf/RRLCxvWnvqbRLFkCbSWxiJp1Xwbow94fHtq76sVv9rQbYmNtmT7ZuB1
         u1l5ksi0MdiivoAkfCRm10UOPlowMgGi5psjDiQhFE8smawWkwttSWrU0RItCLotevxA
         4LPlSyCihl/rYRqjKdbk6kjApX2YC5WB/qvMejus5E2xuIElYsQtvPmE0OEgyXoEE/pd
         JhIg==
X-Gm-Message-State: AOJu0YynWRxy//oE23VqrT5VZltlx/O2lsfP5StkclBZQGLrd+Mzf38a
        dfONiusWyToYWSXvA+6587uUVg2m/zLnc0l/Rvc=
X-Google-Smtp-Source: AGHT+IHSDm/lGTyJTnqjqg3B4/6aDvlgdKLxA2WrrHf6uT8+eulEAGpPC8J4aUHwdlDrn7eA8iqZAg==
X-Received: by 2002:a7b:c3cf:0:b0:402:f536:2d3e with SMTP id t15-20020a7bc3cf000000b00402f5362d3emr4452684wmj.14.1695283084637;
        Thu, 21 Sep 2023 00:58:04 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f209c00529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f20:9c00:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id v4-20020a05600c214400b003fef19bb55csm1151252wml.34.2023.09.21.00.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 00:58:04 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, howells@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 4/4] fs/pipe: use spinlock in pipe_read() only if there is a watch_queue
Date:   Thu, 21 Sep 2023 09:57:55 +0200
Message-Id: <20230921075755.1378787-4-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230921075755.1378787-1-max.kellermann@ionos.com>
References: <20230921075755.1378787-1-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is no watch_queue, holding the pipe mutex is enough to
prevent concurrent writes, and we can avoid the spinlock.

O_NOTIFICATION_QUEUE is an exotic and rarely used feature, and of all
the pipes that exist at any given time, only very few actually have a
watch_queue, therefore it appears worthwile to optimize the common
case.

This patch does not optimize pipe_resize_ring() where the spinlocks
could be avoided as well; that does not seem like a worthwile
optimization because this function is not called often.

Related commits:

- commit 8df441294dd3 ("pipe: Check for ring full inside of the
  spinlock in pipe_write()")
- commit b667b8673443 ("pipe: Advance tail pointer inside of wait
  spinlock in pipe_read()")
- commit 189b0ddc2451 ("pipe: Fix missing lock in pipe_resize_ring()")

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/pipe.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 939def02c18c..da557eff9560 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -322,14 +322,34 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 
 			if (!buf->len) {
 				pipe_buf_release(pipe, buf);
-				spin_lock_irq(&pipe->rd_wait.lock);
+
+				if (pipe_has_watch_queue(pipe)) {
+					/* if the pipe has a
+					 * watch_queue, we need
+					 * additional protection by
+					 * the spinlock because
+					 * notifications get posted
+					 * with only this spinlock, no
+					 * mutex
+					 */
+
+					spin_lock_irq(&pipe->rd_wait.lock);
 #ifdef CONFIG_WATCH_QUEUE
-				if (buf->flags & PIPE_BUF_FLAG_LOSS)
-					pipe->note_loss = true;
+					if (buf->flags & PIPE_BUF_FLAG_LOSS)
+						pipe->note_loss = true;
 #endif
-				tail++;
-				pipe->tail = tail;
-				spin_unlock_irq(&pipe->rd_wait.lock);
+					tail++;
+					pipe->tail = tail;
+					spin_unlock_irq(&pipe->rd_wait.lock);
+				} else {
+					/* without a watch_queue, we
+					 * can simply increment the
+					 * tail without the spinlock -
+					 * the mutex is enough
+					 */
+
+					pipe->tail = ++tail;
+				}
 			}
 			total_len -= chars;
 			if (!total_len)
-- 
2.39.2

