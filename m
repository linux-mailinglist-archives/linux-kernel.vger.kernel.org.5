Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AD2750E45
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbjGLQVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjGLQVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:21:33 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B682A273F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 09:20:29 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-77dcff76e35so81661539f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 09:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689178827; x=1691770827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Li5VUmBD5+tr8pBWbZ9fykm8VJdjqz7ksPG6941uuhk=;
        b=Yl/wYoTkNUqB72V61FVqDtz0+LLheQNv9R8JCM7IBxUtZnn2/pw0neDhpgO1SZf44W
         i2GWeqToXgARRH6R0u4LwHRHU+oNqr4aM6FjuuKxxkpz/o6VHbSbzZBTZH8h0P0oBxNX
         1UmzZl+VoHluXd2AYc+uIKSPTmSLPKGzBxpELj1d8me4kI0d6KYP8rBMf1gqOjXUoCGo
         O1Ja/PqrQrod8vDr0U8ySKvdMOp/SMeXrC2zBEFWTh4LojrDWYLhHQVvQO5llLO2Luc0
         aq2I1NJr8z8DRT4ULyp3BXpZgWD9dqN7FuOJ3XEgErfknw57VvsbxvhnQcG5JxZQ/j4c
         nFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689178827; x=1691770827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Li5VUmBD5+tr8pBWbZ9fykm8VJdjqz7ksPG6941uuhk=;
        b=lOOytD8mLCPvpfZFD9kcTMuaLGSTcoMGq7wqohTUaYlRP+RfBcobiulevD8CzyQ3u+
         CLSYN+TWv8kNHtJjlyFNxvsTqwsY+QtG/jEe0W5DDcXh83UyhHnYG0BfZGFT+YCswjlK
         3p7mmBNwCV2AoVngSGhTJVFfwZ/d6A060lQoAXpFsPExvDSCVikxajjKAG8FzyoD2UTB
         QqkNXQ003asPb7G/qaok6rId+qTUIRdw54Xu5LwLiRbTx5x612nhxca+g+yez0wN/L14
         sMXzJ3kFEwINKu9cjv3ikofJiFaODhAKT5/aS+eYbNZdll/sFXja+KaYyejrCY0bcMvo
         aoXQ==
X-Gm-Message-State: ABy/qLaXUMkY7D7x7L4MPYwRhdAJdTmhNnWKSz0pk6pa4I6L43vHczsK
        rPxNeAe8DUppeGb+sf+//zLX0w==
X-Google-Smtp-Source: APBJJlGfNbne5XFAmbsGlYyDbp0UAulBuB6Yi3u4d/gt/7W7E9P/f2PcLov6tJw9rqRSRTYd62TXAQ==
X-Received: by 2002:a6b:5a0a:0:b0:780:cb36:6f24 with SMTP id o10-20020a6b5a0a000000b00780cb366f24mr18730421iob.2.1689178827660;
        Wed, 12 Jul 2023 09:20:27 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x24-20020a029718000000b0042aec33bc26sm1328775jai.18.2023.07.12.09.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 09:20:26 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        andres@anarazel.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/8] futex: abstract out a __futex_wake_mark() helper
Date:   Wed, 12 Jul 2023 10:20:12 -0600
Message-Id: <20230712162017.391843-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230712162017.391843-1-axboe@kernel.dk>
References: <20230712162017.391843-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the unqueue and lock_ptr clear into a helper that futex_wake_mark()
calls. Add it to the public functions as well, in preparation for using
it outside the core futex code.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 kernel/futex/futex.h    |  1 +
 kernel/futex/waitwake.c | 33 ++++++++++++++++++++++-----------
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 54b7de21ef00..1d531244fb71 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -148,6 +148,7 @@ extern int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
 			    struct futex_q *q, struct futex_hash_bucket **hb);
 extern void futex_wait_queue(struct futex_hash_bucket *hb, struct futex_q *q,
 				   struct hrtimer_sleeper *timeout);
+extern bool __futex_wake_mark(struct futex_q *q);
 extern void futex_wake_mark(struct wake_q_head *wake_q, struct futex_q *q);
 
 extern int fault_in_user_writeable(u32 __user *uaddr);
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index 3471af87cb7d..f8fb6550061d 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -106,20 +106,11 @@
  * double_lock_hb() and double_unlock_hb(), respectively.
  */
 
-/*
- * The hash bucket lock must be held when this is called.
- * Afterwards, the futex_q must not be accessed. Callers
- * must ensure to later call wake_up_q() for the actual
- * wakeups to occur.
- */
-void futex_wake_mark(struct wake_q_head *wake_q, struct futex_q *q)
+bool __futex_wake_mark(struct futex_q *q)
 {
-	struct task_struct *p = q->task;
-
 	if (WARN(q->pi_state || q->rt_waiter, "refusing to wake PI futex\n"))
-		return;
+		return false;
 
-	get_task_struct(p);
 	__futex_unqueue(q);
 	/*
 	 * The waiting task can free the futex_q as soon as q->lock_ptr = NULL
@@ -130,6 +121,26 @@ void futex_wake_mark(struct wake_q_head *wake_q, struct futex_q *q)
 	 */
 	smp_store_release(&q->lock_ptr, NULL);
 
+	return true;
+}
+
+/*
+ * The hash bucket lock must be held when this is called.
+ * Afterwards, the futex_q must not be accessed. Callers
+ * must ensure to later call wake_up_q() for the actual
+ * wakeups to occur.
+ */
+void futex_wake_mark(struct wake_q_head *wake_q, struct futex_q *q)
+{
+	struct task_struct *p = q->task;
+
+	get_task_struct(p);
+
+	if (!__futex_wake_mark(q)) {
+		put_task_struct(p);
+		return;
+	}
+
 	/*
 	 * Queue the task for later wakeup for after we've released
 	 * the hb->lock.
-- 
2.40.1

