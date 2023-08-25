Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE97788E46
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjHYSK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjHYSKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:10:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21EE1BF1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 11:10:39 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692987038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qx5o5NWuongItLawGnYT3eYixJKHNqubNZ7Gbs6vpvI=;
        b=r8sH32SWQe+RFNOfsM7sBQTrtyCKJSbyEmJihL7cyPasvs3mqvJJloypILxgiTF8a8K5yQ
        b92E1Tw5pEw8vAQxwCvzTaXUkm7LQfokPXjzSK8gB6hdtQ8GBZZWSmbFNNsmD9r39i2yUa
        g4gnLfL0b9YkcwDc0RB06AFI79gf6wAidcrD8Crswhxk+QnDGHYZx8L86szS4zz1O6tcFo
        W3WGk45rLBu/c/MA5OJG6W+AZAIGbT+Ihdw6f6e0OkThvJnaLYa9kWTjffe8FT6mnQ+M9K
        P3RfLsdQFj2G4pXaNyOhz72qB7gBk2s0BBN70dB6EEZw+9gkpSwoQjSiOEqRKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692987038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qx5o5NWuongItLawGnYT3eYixJKHNqubNZ7Gbs6vpvI=;
        b=OiTe5S48gckWMNd+eXzMWGMgAI7oY+aP+qgi61j45/z7WgbsOQHKvYbNYrPBhwtcR5+6PE
        h2FIxwpLeAoZN2Ag==
To:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Cc:     bigeasy@linutronix.de, tglx@linutronix.de, boqun.feng@gmail.com,
        bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        jstultz@google.com, juri.lelli@redhat.com, longman@redhat.com,
        mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org,
        swood@redhat.com, vincent.guittot@linaro.org, vschneid@redhat.com,
        will@kernel.org
Subject: [PATCH v2 6/6] locking/rtmutex: Add a lockdep assert to catch potential nested blocking
Date:   Fri, 25 Aug 2023 20:10:33 +0200
Message-Id: <20230825181033.504534-7-bigeasy@linutronix.de>
In-Reply-To: <20230825181033.504534-1-bigeasy@linutronix.de>
References: <20230825181033.504534-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

There used to be a BUG_ON(current->pi_blocked_on) in the lock acquisition
functions, but that vanished in one of the rtmutex overhauls.

Bring it back in form of a lockdep assert to catch code paths which take
rtmutex based locks with current::pi_blocked_on !=3D NULL.

Reported-by: Crystal Wood <swood@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230427111937.2745231-5-bigeasy@linutronix=
.de
Link: https://lore.kernel.org/r/20230815111430.488430699@infradead.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/locking/rtmutex.c     | 2 ++
 kernel/locking/rwbase_rt.c   | 2 ++
 kernel/locking/spinlock_rt.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index a3fe05dfd0d8f..4a10e8c16fd2b 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1784,6 +1784,8 @@ static int __sched rt_mutex_slowlock(struct rt_mutex_=
base *lock,
 static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
 					   unsigned int state)
 {
+	lockdep_assert(!current->pi_blocked_on);
+
 	if (likely(rt_mutex_try_acquire(lock)))
 		return 0;
=20
diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index 7d57bfb909001..b5e881250fec5 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -133,6 +133,8 @@ static int __sched __rwbase_read_lock(struct rwbase_rt =
*rwb,
 static __always_inline int rwbase_read_lock(struct rwbase_rt *rwb,
 					    unsigned int state)
 {
+	lockdep_assert(!current->pi_blocked_on);
+
 	if (rwbase_read_trylock(rwb))
 		return 0;
=20
diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index 842037b2ba548..38e292454fccb 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -37,6 +37,8 @@
=20
 static __always_inline void rtlock_lock(struct rt_mutex_base *rtm)
 {
+	lockdep_assert(!current->pi_blocked_on);
+
 	if (unlikely(!rt_mutex_cmpxchg_acquire(rtm, NULL, current)))
 		rtlock_slowlock(rtm);
 }
--=20
2.40.1

