Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756AC7585CC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjGRTt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGRTt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:49:26 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E369D1995
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 12:49:25 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-77dcff76e35so55784739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 12:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689709765; x=1692301765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGcQDjq/o6t2ObZfo2BKw3K7TL3Ez2D+npEQSf00g+U=;
        b=GYMNTAwW+OS0zoZ8XObYelbr9fY9Yib+JrDAtJHHTiuw70qayYxL/ylwZIh40Ucbq7
         wDFwyQL0jEAe+MS1C+4QETQ1v++JeT+9s17I7YZ6S/Q+rboxZhtSRkJNvuKr4aPSLq7+
         BvLVr5TulVNpo2Qp+Ylvcv4lcGRN9SuHA+WjUAVLIVtMz0PSeK9uPWrjDg2RkJC5xM9+
         G/0BfnERVgn1kXLDH/Awb7m0ysfkRLp9faGnz44SHdJGk+r/E6kIdw4oEKUz6Dc71nli
         wRK2gTR1Ber0dZiMsKLR6rz1Fg8n2DaZehZ5P1DK8J2DfuiZLnH4g0AX+Q1tswMls1j5
         UeZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689709765; x=1692301765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGcQDjq/o6t2ObZfo2BKw3K7TL3Ez2D+npEQSf00g+U=;
        b=CTEzPeB+fnx3LBVvko7Q9YMMxstat5//+2rYpTO1ZHB3SQKdnx0ZoLoOeW/5+PLxOM
         6uwLs95RTkrP9iGunQE2gOE3oXWzV3uH14TtOeNU6ySbmMDRawb5zeET67rFicA3g5Bt
         5UpY//a50jJG6AjA4ZUxQ6R1c6UMXj8Cx+q9TpGTVfziYHBKcgQdRUzYWvKGsBxAZKFd
         HjdPS6Q7lnW/xVdT0q+wpZfxTSWs1rE7F22NUmkLBiFKlC8w5eN6ADMofCqv8A9fdFVU
         YtSkK57contpKYvZyYioe8d93UW3hbC/EpzU9lQP3KpazCB9F3Aey09zTqI5CxxFC+mq
         jLuA==
X-Gm-Message-State: ABy/qLaIDoIBFFDOZB7TbZB3QEnhYfMEC0Fh8NhcrVNNARJP7CRs8AcP
        NmjIYQz+L+An0tMaQmVT0eTyBNNEPdu6kpq3Dao=
X-Google-Smtp-Source: APBJJlFIO3UOGhj4Q8FZLu786jEuJAwxrtkB8KVTPudnVyvyxdmg+TKa5o8O1UPQHVeMc+GdYyACUg==
X-Received: by 2002:a92:1901:0:b0:345:e438:7381 with SMTP id 1-20020a921901000000b00345e4387381mr2341960ilz.2.1689709765277;
        Tue, 18 Jul 2023 12:49:25 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id v18-20020a92d252000000b00345e3a04f2dsm897463ilg.62.2023.07.18.12.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 12:49:24 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     hch@lst.de, andres@anarazel.de, david@fromorbit.com,
        stable@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: Use io_schedule* in cqring wait
Date:   Tue, 18 Jul 2023 13:49:15 -0600
Message-Id: <20230718194920.1472184-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230718194920.1472184-1-axboe@kernel.dk>
References: <20230718194920.1472184-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andres Freund <andres@anarazel.de>

I observed poor performance of io_uring compared to synchronous IO. That
turns out to be caused by deeper CPU idle states entered with io_uring,
due to io_uring using plain schedule(), whereas synchronous IO uses
io_schedule().

The losses due to this are substantial. On my cascade lake workstation,
t/io_uring from the fio repository e.g. yields regressions between 20%
and 40% with the following command:
./t/io_uring -r 5 -X0 -d 1 -s 1 -c 1 -p 0 -S$use_sync -R 0 /mnt/t2/fio/write.0.0

This is repeatable with different filesystems, using raw block devices
and using different block devices.

Use io_schedule_prepare() / io_schedule_finish() in
io_cqring_wait_schedule() to address the difference.

After that using io_uring is on par or surpassing synchronous IO (using
registered files etc makes it reliably win, but arguably is a less fair
comparison).

There are other calls to schedule() in io_uring/, but none immediately
jump out to be similarly situated, so I did not touch them. Similarly,
it's possible that mutex_lock_io() should be used, but it's not clear if
there are cases where that matters.

Cc: stable@vger.kernel.org # 5.10+
Cc: Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andres Freund <andres@anarazel.de>
Link: https://lore.kernel.org/r/20230707162007.194068-1-andres@anarazel.de
[axboe: minor style fixup]
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/io_uring.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index e8096d502a7c..7505de2428e0 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2489,6 +2489,8 @@ int io_run_task_work_sig(struct io_ring_ctx *ctx)
 static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 					  struct io_wait_queue *iowq)
 {
+	int token, ret;
+
 	if (unlikely(READ_ONCE(ctx->check_cq)))
 		return 1;
 	if (unlikely(!llist_empty(&ctx->work_llist)))
@@ -2499,11 +2501,20 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 		return -EINTR;
 	if (unlikely(io_should_wake(iowq)))
 		return 0;
+
+	/*
+	 * Use io_schedule_prepare/finish, so cpufreq can take into account
+	 * that the task is waiting for IO - turns out to be important for low
+	 * QD IO.
+	 */
+	token = io_schedule_prepare();
+	ret = 0;
 	if (iowq->timeout == KTIME_MAX)
 		schedule();
 	else if (!schedule_hrtimeout(&iowq->timeout, HRTIMER_MODE_ABS))
-		return -ETIME;
-	return 0;
+		ret = -ETIME;
+	io_schedule_finish(token);
+	return ret;
 }
 
 /*
-- 
2.40.1

