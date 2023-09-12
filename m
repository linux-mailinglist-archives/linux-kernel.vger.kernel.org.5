Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF37979D9CE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbjILTzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjILTzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:55:20 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346451AE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 12:55:16 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RlZ7P3vzrzB1;
        Tue, 12 Sep 2023 21:55:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1694548513; bh=hQNQ4QCGqogXkkq7quiXHYiRdH8sQiU3p2y0WgbusoQ=;
        h=Date:Subject:From:To:Cc:From;
        b=lmOpXkrUV529cwb3qYNI2wBT30mIicDUa0eryPCudafDE5DcDSGg7Pl7LZJKkkg3P
         bxtKM3jx+1RHManGMndEC38D4U2YC0ggtwHzyWNh7i0b0TfvixbA4A0dW/L3GF9jmb
         +UFIayaa1D1wuv4rAOzZ47jS7UUulgyTRNeOP1twtPedLUKdVhVo4QHwsAhsh3dzrH
         nI6kXLsy8Z9yZuGYGd4ITYm/i6F1JqGARRGax11k7x8nEDDgN1MwAT5W5GkSLYXpM3
         ay78rKGbF5SPd9OPVF7T3rARuB6GeJXgF+RTtCpNaYhIwvniqBNNYIvmdSv5tT5u2x
         5HxKrlP6gGoOQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Tue, 12 Sep 2023 21:55:13 +0200
Message-Id: <13334f7016362b2031eb65b03cb1a49b6500957f.1694548262.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3] locking/mutex: remove redundant argument from
 __mutex_lock_common()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use_ww_ctx is equivalent to ww_ctx != NULL. The one case where
use_ww_ctx was true but ww_ctx == NULL leads to the same
__mutex_add_waiter() call via __ww_mutex_add_waiter().

Since now __ww_mutex_add_waiter() is called only with ww_mutex != NULL
(from both regular and PREEMPT_RT implementations), remove the
branch there.

Resulting object size diffs (by gcc-12) are minor:

   text    data     bss     dec     hex filename (x86-64)
  22603    4696      16   27315    6ab3 /tmp/before.o
  22593    4696      16   27305    6aa9 /tmp/after.o

   text    data     bss     dec     hex filename (arm)
  13488      56       8   13552    34f0 /tmp/before.o
  13492      56       8   13556    34f4 /tmp/after.o

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
v3: extended commit message with `size` diffs
  + added back `if (ww_ctx)`-guarded store: compiler hoists it into the
    following branch anyway and so it avoids the unnecessary store in
    the `ww_ctx == NULL` case.
v2: extended commit message to note that PREEMPT_RT does not call
    __ww_mutex_add_waiter() with ww_ctx == NULL
---
 kernel/locking/mutex.c    | 15 ++++++---------
 kernel/locking/ww_mutex.h |  5 -----
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 4a3c006c41fb..045f7da4e473 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -578,15 +578,12 @@ EXPORT_SYMBOL(ww_mutex_unlock);
 static __always_inline int __sched
 __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclass,
 		    struct lockdep_map *nest_lock, unsigned long ip,
-		    struct ww_acquire_ctx *ww_ctx, const bool use_ww_ctx)
+		    struct ww_acquire_ctx *ww_ctx)
 {
 	struct mutex_waiter waiter;
 	struct ww_mutex *ww;
 	int ret;
 
-	if (!use_ww_ctx)
-		ww_ctx = NULL;
-
 	might_sleep();
 
 	MUTEX_WARN_ON(lock->magic != lock);
@@ -637,12 +634,12 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 
 	debug_mutex_lock_common(lock, &waiter);
 	waiter.task = current;
-	if (use_ww_ctx)
+	if (ww_ctx)
 		waiter.ww_ctx = ww_ctx;
 
 	lock_contended(&lock->dep_map, ip);
 
-	if (!use_ww_ctx) {
+	if (!ww_ctx) {
 		/* add waiting tasks to the end of the waitqueue (FIFO): */
 		__mutex_add_waiter(lock, &waiter, &lock->wait_list);
 	} else {
@@ -754,14 +751,14 @@ static int __sched
 __mutex_lock(struct mutex *lock, unsigned int state, unsigned int subclass,
 	     struct lockdep_map *nest_lock, unsigned long ip)
 {
-	return __mutex_lock_common(lock, state, subclass, nest_lock, ip, NULL, false);
+	return __mutex_lock_common(lock, state, subclass, nest_lock, ip, NULL);
 }
 
 static int __sched
 __ww_mutex_lock(struct mutex *lock, unsigned int state, unsigned int subclass,
 		unsigned long ip, struct ww_acquire_ctx *ww_ctx)
 {
-	return __mutex_lock_common(lock, state, subclass, NULL, ip, ww_ctx, true);
+	return __mutex_lock_common(lock, state, subclass, NULL, ip, ww_ctx);
 }
 
 /**
@@ -841,7 +838,7 @@ mutex_lock_io_nested(struct mutex *lock, unsigned int subclass)
 
 	token = io_schedule_prepare();
 	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE,
-			    subclass, NULL, _RET_IP_, NULL, 0);
+			    subclass, NULL, _RET_IP_, NULL);
 	io_schedule_finish(token);
 }
 EXPORT_SYMBOL_GPL(mutex_lock_io_nested);
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 3ad2cc4823e5..11acb2efe976 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -493,11 +493,6 @@ __ww_mutex_add_waiter(struct MUTEX_WAITER *waiter,
 	struct MUTEX_WAITER *cur, *pos = NULL;
 	bool is_wait_die;
 
-	if (!ww_ctx) {
-		__ww_waiter_add(lock, waiter, NULL);
-		return 0;
-	}
-
 	is_wait_die = ww_ctx->is_wait_die;
 
 	/*
-- 
2.39.2

