Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD90678E261
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239195AbjH3WiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbjH3WiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:38:08 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04E795
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:37:47 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RbdpH6VCbz10d;
        Thu, 31 Aug 2023 00:12:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1693433576; bh=t/kD0OqosBjlNxJKTVM29xqUs/q7bG5kVqBAhX1egi8=;
        h=Date:Subject:From:To:Cc:From;
        b=chZFYXgDelKsyBV85ufordrD6F6ZiqeCTUA6QEq3KRVUml0AFqwk6LREIjmp5uceu
         WCdlcHHIQdkBr56ZrZQ0+sVhi9Lx4Inu3jkHRyNJIXpA47VktcTMYFXr/2lYM0e45p
         LRe0pmUps5JsvcuS1/cedpO7YZTT9V2goKmhH7WShDb7QX9tWzDrUt/oZE9Upa4WUW
         ZQBmWEn6k4+0fZzdIh+eiDB8qvGQlYTKQJnFxfaW5CrIA+xaMBxcmsXeCW1T7GxrPA
         7X7+URNdlecKyFg2wfUPP4fxtzOxskb4zt4yWXG+5DvjVCU1y6dyT3k+iJ3LOc4gvn
         jdw3LnenJUA0w==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Thu, 31 Aug 2023 00:12:55 +0200
Message-Id: <76a1d64e683ee9a9f507114dfbc2d5121da8c3f3.1693433504.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH] locking/mutex: remove redundant argument from
 __mutex_lock_common()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use_ww_ctx is equivalent to ww_ctx != NULL. The one case where
use_ww_ctx was true but ww_ctx == NULL leads to the same
__mutex_add_waiter() call via __ww_mutex_add_waiter().

Since now __ww_mutex_add_waiter() is called only with ww_mutex != NULL,
remove the branch there.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 kernel/locking/mutex.c    | 16 ++++++----------
 kernel/locking/ww_mutex.h |  5 -----
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index d973fe6041bf..2f0e318233f5 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -568,15 +568,12 @@ EXPORT_SYMBOL(ww_mutex_unlock);
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
@@ -627,12 +624,11 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 
 	debug_mutex_lock_common(lock, &waiter);
 	waiter.task = current;
-	if (use_ww_ctx)
-		waiter.ww_ctx = ww_ctx;
+	waiter.ww_ctx = ww_ctx;
 
 	lock_contended(&lock->dep_map, ip);
 
-	if (!use_ww_ctx) {
+	if (!ww_ctx) {
 		/* add waiting tasks to the end of the waitqueue (FIFO): */
 		__mutex_add_waiter(lock, &waiter, &lock->wait_list);
 	} else {
@@ -744,14 +740,14 @@ static int __sched
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
@@ -831,7 +827,7 @@ mutex_lock_io_nested(struct mutex *lock, unsigned int subclass)
 
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

