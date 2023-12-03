Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC798026C5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 20:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbjLCTdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 14:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbjLCTdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 14:33:08 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D01BA0
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 11:33:15 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5d2d0661a8dso42510117b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 11:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701631994; x=1702236794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbntnK4HNa/CvcX2c9tw9yKQZtz2j41lTpG1pzcXcKI=;
        b=JEi84IjLCDP6Bcdy/X8FpsPf+UnLM5gnKigYNvc1ZCJRUFChXE0sgsSOIoCLEYpqdG
         Nb7IV4qhuqD1xQcqKCBFE1SvofH8wvWo/WKyO6O0dIbVt0alzh44oZ/HHQEcvfrHQ1pz
         l9zQRyL5YlfT5oV7zpiT3H4gDR2i0mrGMZyy4LMjWBPa+txtf897c+x02YR45gN7v4AM
         /BFL2IKCAYntE4uEWQVagYtGjNkrp3FmZkQQMJf3vcYl3XUC6SPy/DKMcbyCL3LfN7ni
         Cn9JWRR505cbwoVBIdZVExNuBAK/RP2fn8pinhOWt2EUpWdxG+GaDTHYHfssi2+kI8bo
         ETRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701631994; x=1702236794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbntnK4HNa/CvcX2c9tw9yKQZtz2j41lTpG1pzcXcKI=;
        b=rLMyIqpunh5e42HO0lnNn25MxvG5lkXaUhQ78oZiFGyjX/HWBjgIkq36HAY4JvXlc8
         JLTJeysYlEUK3pBgBAAdWqDIDDBvbfhCh9ro/y+f6lKD7QRU2l1JRlt79o24wify5Jdv
         uZ1Gw7j93R5aDf+cN0qWYfBqMjRsZzU+AOoDvKavFyvmPVeZ67t/eckdyi1gMM8zaHKI
         N93NBzh4jZY6y4SKJQU6e7+0PeJtq7+KluPZ9zzVsfNPVqDpRQqgQBIuTWHS/97t/E8K
         mA6Eq6DlxiFIJAzztc32LFbjb9l10KrJ3zK8SewFBM21AYUCCtqeoJWNTrLFu7kuPxf/
         /8pA==
X-Gm-Message-State: AOJu0YyuWDeeYZUF+tMRciWp0lbrXZk0lJbPB4dWJa0Lp9OSRHG+zIg2
        If1A7EDnOgWgGq8K5FRh3fp41HhUz6SD8Q==
X-Google-Smtp-Source: AGHT+IHgeXaowsjx0YriHDw1Z7pAh0ypv84ybJigHlgV/N/hQyXn5pkJ+iNy6uVgh1RxJtiY8ZzPyg==
X-Received: by 2002:a05:690c:dd0:b0:5d7:1940:b38a with SMTP id db16-20020a05690c0dd000b005d71940b38amr3091785ywb.86.1701631993664;
        Sun, 03 Dec 2023 11:33:13 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cb98:c3e:57c:8191])
        by smtp.gmail.com with ESMTPSA id o18-20020a0dcc12000000b005d5424c93c7sm1933768ywd.14.2023.12.03.11.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:33:13 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Siddh Raman Pant <code@siddh.me>,
        Yury Norov <yury.norov@gmail.com>,
        Dave Airlie <airlied@redhat.com>,
        David Disseldorp <ddiss@suse.de>,
        Philipp Stanner <pstanner@redhat.com>,
        Nick Alcock <nick.alcock@oracle.com>
Cc:     Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2 04/35] watch_queue: use atomic find_bit() in post_one_notification()
Date:   Sun,  3 Dec 2023 11:32:36 -0800
Message-Id: <20231203193307.542794-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203193307.542794-1-yury.norov@gmail.com>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

post_one_notification() searches for a set bit in wqueue->notes_bitmap,
and after some housekeeping work clears it, firing a BUG() if someone
else cleared the bit in-between.

We can allocate the bit atomically with an atomic find_and_clear_bit(),
and remove the BUG() possibility entirely.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/watch_queue.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 778b4056700f..07edd4a2b463 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -112,7 +112,7 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	if (pipe_full(head, tail, pipe->ring_size))
 		goto lost;
 
-	note = find_first_bit(wqueue->notes_bitmap, wqueue->nr_notes);
+	note = find_and_clear_bit(wqueue->notes_bitmap, wqueue->nr_notes);
 	if (note >= wqueue->nr_notes)
 		goto lost;
 
@@ -133,10 +133,6 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	buf->flags = PIPE_BUF_FLAG_WHOLE;
 	smp_store_release(&pipe->head, head + 1); /* vs pipe_read() */
 
-	if (!test_and_clear_bit(note, wqueue->notes_bitmap)) {
-		spin_unlock_irq(&pipe->rd_wait.lock);
-		BUG();
-	}
 	wake_up_interruptible_sync_poll_locked(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
 	done = true;
 
-- 
2.40.1

