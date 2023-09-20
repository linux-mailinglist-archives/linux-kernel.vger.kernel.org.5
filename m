Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AC57A744A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbjITHgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbjITHgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:36:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94AE97;
        Wed, 20 Sep 2023 00:36:13 -0700 (PDT)
Date:   Wed, 20 Sep 2023 07:36:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695195372;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GhnQdh3aDDST7xlz508UlVS8mV8568WrTsIsRp7Ojao=;
        b=H9+FmkVCOi2XMD31Tc57Z3xtreXGD8Kf9OVY3zHj2ZIwtNBbR+wAnZSaM8jgBBqmJ532ab
        WX1jfaI7majNA9P2eYCP8QARPmjY1EOJJKXgCwxSpyM6Q6L284mjnDqMFMFfJJ2lL7XS45
        qcuz4rSSgerRtntdG4IizsS2TyWgxD62tdIRZZuOqvnqaa/wgLM3yjduxuOCn7ENnjnAgR
        3BDk/gC0x17TYn6z2+EsIHdRjjSfaToNUK/gTQs4XB63HDRQOiN2mAg7zudjp1I0GBFe4A
        efZ3nxawrlI64BEXZxZwPknwq+XY/CBEnY8UrZMeP+Omn/BTmYdQV6/2slmTKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695195372;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GhnQdh3aDDST7xlz508UlVS8mV8568WrTsIsRp7Ojao=;
        b=NNv8BEPtnUCt1GLqlwcByUxwetvnlNafbTSRD10dBpfbbQDufvgvWt/Hsurm483tUpvGzv
        U6ADxCjS2lKjgJBg==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Avoid unconditional slowpath for
 DEBUG_RT_MUTEXES
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230908162254.999499-3-bigeasy@linutronix.de>
References: <20230908162254.999499-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <169519537199.27769.4944666008849551688.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     af9f006393b53409be0ca83ae234bef840cdef4a
Gitweb:        https://git.kernel.org/tip/af9f006393b53409be0ca83ae234bef840cdef4a
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 08 Sep 2023 18:22:49 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 20 Sep 2023 09:31:11 +02:00

locking/rtmutex: Avoid unconditional slowpath for DEBUG_RT_MUTEXES

With DEBUG_RT_MUTEXES enabled the fast-path rt_mutex_cmpxchg_acquire()
always fails and all lock operations take the slow path.

Provide a new helper inline rt_mutex_try_acquire() which maps to
rt_mutex_cmpxchg_acquire() in the non-debug case. For the debug case
it invokes rt_mutex_slowtrylock() which can acquire a non-contended
rtmutex under full debug coverage.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230908162254.999499-3-bigeasy@linutronix.de
---
 kernel/locking/rtmutex.c     | 21 ++++++++++++++++++++-
 kernel/locking/ww_rt_mutex.c |  2 +-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 21db0df..bcec053 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -218,6 +218,11 @@ static __always_inline bool rt_mutex_cmpxchg_acquire(struct rt_mutex_base *lock,
 	return try_cmpxchg_acquire(&lock->owner, &old, new);
 }
 
+static __always_inline bool rt_mutex_try_acquire(struct rt_mutex_base *lock)
+{
+	return rt_mutex_cmpxchg_acquire(lock, NULL, current);
+}
+
 static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex_base *lock,
 						     struct task_struct *old,
 						     struct task_struct *new)
@@ -297,6 +302,20 @@ static __always_inline bool rt_mutex_cmpxchg_acquire(struct rt_mutex_base *lock,
 
 }
 
+static int __sched rt_mutex_slowtrylock(struct rt_mutex_base *lock);
+
+static __always_inline bool rt_mutex_try_acquire(struct rt_mutex_base *lock)
+{
+	/*
+	 * With debug enabled rt_mutex_cmpxchg trylock() will always fail.
+	 *
+	 * Avoid unconditionally taking the slow path by using
+	 * rt_mutex_slow_trylock() which is covered by the debug code and can
+	 * acquire a non-contended rtmutex.
+	 */
+	return rt_mutex_slowtrylock(lock);
+}
+
 static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex_base *lock,
 						     struct task_struct *old,
 						     struct task_struct *new)
@@ -1755,7 +1774,7 @@ static int __sched rt_mutex_slowlock(struct rt_mutex_base *lock,
 static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
 					   unsigned int state)
 {
-	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
+	if (likely(rt_mutex_try_acquire(lock)))
 		return 0;
 
 	return rt_mutex_slowlock(lock, NULL, state);
diff --git a/kernel/locking/ww_rt_mutex.c b/kernel/locking/ww_rt_mutex.c
index d1473c6..c7196de 100644
--- a/kernel/locking/ww_rt_mutex.c
+++ b/kernel/locking/ww_rt_mutex.c
@@ -62,7 +62,7 @@ __ww_rt_mutex_lock(struct ww_mutex *lock, struct ww_acquire_ctx *ww_ctx,
 	}
 	mutex_acquire_nest(&rtm->dep_map, 0, 0, nest_lock, ip);
 
-	if (likely(rt_mutex_cmpxchg_acquire(&rtm->rtmutex, NULL, current))) {
+	if (likely(rt_mutex_try_acquire(&rtm->rtmutex))) {
 		if (ww_ctx)
 			ww_mutex_set_context_fastpath(lock, ww_ctx);
 		return 0;
