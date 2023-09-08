Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7AF798AA1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 18:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245060AbjIHQXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 12:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243432AbjIHQXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 12:23:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272441FD9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 09:23:04 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694190182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jn4eRlPtJKnHeG2pf4chEV3J19o5X2lAFc+vObKmtf4=;
        b=X098BhBR1DhgSx08v7uIOtZmzaaLDbxXdEbbj/kIztJWkQv7Nu0uKxFSDfoIhrjUr1sOsN
        rC4+g4IsA0HYXOBjUyC/aupvuTzd6XAJ/WGEHKqtyqtzgfijPjMkWEvpoihpGYtpFVQdD0
        ExWpLPrVS/VR0JRW7oGD69vlFDd4tAkzjWwmgzX2AAdZLL4i0xVXKdZHuxQ3AkhhLJ78U2
        pCuwx+GrnZ7zoOGsDIPZO2FlSdpb/V0321KeVSRsb2NpQPLve+d40qImsg3tUXLnZK4nVu
        ze54EME2wXMd07exv/4RZHW/78muiHGtMO/ZbCs2VVry32ccDv8a4NrvmwuL6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694190182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jn4eRlPtJKnHeG2pf4chEV3J19o5X2lAFc+vObKmtf4=;
        b=gWAhtHIdSP9vLpmF68bXeg3BCyRU51DPT0DXD59lGHxbES8+cIxB7f3gOWi/T6KKL+KNc9
        RCF7jt8ieK14XfCQ==
To:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Cc:     bigeasy@linutronix.de, tglx@linutronix.de, boqun.feng@gmail.com,
        bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        jstultz@google.com, juri.lelli@redhat.com, longman@redhat.com,
        mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org,
        swood@redhat.com, vincent.guittot@linaro.org, vschneid@redhat.com,
        will@kernel.org
Subject: [PATCH v3 2/7] locking/rtmutex: Avoid unconditional slowpath for DEBUG_RT_MUTEXES
Date:   Fri,  8 Sep 2023 18:22:49 +0200
Message-Id: <20230908162254.999499-3-bigeasy@linutronix.de>
In-Reply-To: <20230908162254.999499-1-bigeasy@linutronix.de>
References: <20230908162254.999499-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With DEBUG_RT_MUTEXES enabled the fast-path rt_mutex_cmpxchg_acquire()
always fails and all lock operations take the slow path.

Provide a new helper inline rt_mutex_try_acquire() which maps to
rt_mutex_cmpxchg_acquire() in the non-debug case. For the debug case
it invokes rt_mutex_slowtrylock() which can acquire a non-contended
rtmutex under full debug coverage.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230427111937.2745231-4-bigeasy@linutronix=
.de
Link: https://lore.kernel.org/r/20230815111430.220899937@infradead.org
Link: https://lore.kernel.org/r/20230825181033.504534-3-bigeasy@linutronix.=
de
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/locking/rtmutex.c     | 21 ++++++++++++++++++++-
 kernel/locking/ww_rt_mutex.c |  2 +-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 21db0df0eb000..bcec0533a0cc0 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -218,6 +218,11 @@ static __always_inline bool rt_mutex_cmpxchg_acquire(s=
truct rt_mutex_base *lock,
 	return try_cmpxchg_acquire(&lock->owner, &old, new);
 }
=20
+static __always_inline bool rt_mutex_try_acquire(struct rt_mutex_base *loc=
k)
+{
+	return rt_mutex_cmpxchg_acquire(lock, NULL, current);
+}
+
 static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex_base =
*lock,
 						     struct task_struct *old,
 						     struct task_struct *new)
@@ -297,6 +302,20 @@ static __always_inline bool rt_mutex_cmpxchg_acquire(s=
truct rt_mutex_base *lock,
=20
 }
=20
+static int __sched rt_mutex_slowtrylock(struct rt_mutex_base *lock);
+
+static __always_inline bool rt_mutex_try_acquire(struct rt_mutex_base *loc=
k)
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
 static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex_base =
*lock,
 						     struct task_struct *old,
 						     struct task_struct *new)
@@ -1755,7 +1774,7 @@ static int __sched rt_mutex_slowlock(struct rt_mutex_=
base *lock,
 static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
 					   unsigned int state)
 {
-	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
+	if (likely(rt_mutex_try_acquire(lock)))
 		return 0;
=20
 	return rt_mutex_slowlock(lock, NULL, state);
diff --git a/kernel/locking/ww_rt_mutex.c b/kernel/locking/ww_rt_mutex.c
index d1473c624105c..c7196de838edc 100644
--- a/kernel/locking/ww_rt_mutex.c
+++ b/kernel/locking/ww_rt_mutex.c
@@ -62,7 +62,7 @@ __ww_rt_mutex_lock(struct ww_mutex *lock, struct ww_acqui=
re_ctx *ww_ctx,
 	}
 	mutex_acquire_nest(&rtm->dep_map, 0, 0, nest_lock, ip);
=20
-	if (likely(rt_mutex_cmpxchg_acquire(&rtm->rtmutex, NULL, current))) {
+	if (likely(rt_mutex_try_acquire(&rtm->rtmutex))) {
 		if (ww_ctx)
 			ww_mutex_set_context_fastpath(lock, ww_ctx);
 		return 0;
--=20
2.40.1

