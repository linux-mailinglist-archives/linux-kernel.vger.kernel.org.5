Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CC27A7441
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbjITHgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbjITHgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:36:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAFECA;
        Wed, 20 Sep 2023 00:36:11 -0700 (PDT)
Date:   Wed, 20 Sep 2023 07:36:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695195370;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v+JgXwP57sgUiUMevhm4cL25gu1CKeVHdhZhw9WaQac=;
        b=3Ow5R83qQtQi7n8EtEk+ltH7aqOKx9XV5njBhCjROmjLL31cPfqQYZAlNpHHOxGQ6Ab0Jr
        CNLfUqc28U5iR79jNAqTlqJ8mmm7uhuTnbJcRfl1o+RIYQLG2s+Fz4iAOwjI/L/tppfXmm
        ThS5wRzyRG6oIoCijZM53osmw2xCHwS2C0jnR2WcdR4HA4+hBOeBZHCfHC5NyIxIE2xdTu
        at7XAtlW3fIOqp7ftbxHR6jFU7lbW3qwpPNq4DILAJlhGtm3wpnZH3qS/r+w9/x7SHUwsX
        XQ4KJfcNrLB0+UYaFU+Ypd9+NUGJPOpQAp8mrJ72le1i0C2sgm+8ODEgjGg41Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695195370;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v+JgXwP57sgUiUMevhm4cL25gu1CKeVHdhZhw9WaQac=;
        b=TR2tqJI+dE0HLy1YvHzEarAjsMfpgixABJJi2Qpd04kzhkz47yL9HaOOpDKCGojHw0zkwt
        JADFyVlCSf14qtDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Add a lockdep assert to catch
 potential nested blocking
Cc:     Crystal Wood <swood@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230908162254.999499-7-bigeasy@linutronix.de>
References: <20230908162254.999499-7-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <169519536955.27769.443350425283875935.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     45f67f30a22f264bc7a0a61255c2ee1a838e9403
Gitweb:        https://git.kernel.org/tip/45f67f30a22f264bc7a0a61255c2ee1a838e9403
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 08 Sep 2023 18:22:53 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 20 Sep 2023 09:31:14 +02:00

locking/rtmutex: Add a lockdep assert to catch potential nested blocking

There used to be a BUG_ON(current->pi_blocked_on) in the lock acquisition
functions, but that vanished in one of the rtmutex overhauls.

Bring it back in form of a lockdep assert to catch code paths which take
rtmutex based locks with current::pi_blocked_on != NULL.

Reported-by: Crystal Wood <swood@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230908162254.999499-7-bigeasy@linutronix.de
---
 kernel/locking/rtmutex.c     | 2 ++
 kernel/locking/rwbase_rt.c   | 2 ++
 kernel/locking/spinlock_rt.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index a3fe05d..4a10e8c 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1784,6 +1784,8 @@ static int __sched rt_mutex_slowlock(struct rt_mutex_base *lock,
 static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
 					   unsigned int state)
 {
+	lockdep_assert(!current->pi_blocked_on);
+
 	if (likely(rt_mutex_try_acquire(lock)))
 		return 0;
 
diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index c7258cb..34a5956 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -133,6 +133,8 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
 static __always_inline int rwbase_read_lock(struct rwbase_rt *rwb,
 					    unsigned int state)
 {
+	lockdep_assert(!current->pi_blocked_on);
+
 	if (rwbase_read_trylock(rwb))
 		return 0;
 
diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index 842037b..38e2924 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -37,6 +37,8 @@
 
 static __always_inline void rtlock_lock(struct rt_mutex_base *rtm)
 {
+	lockdep_assert(!current->pi_blocked_on);
+
 	if (unlikely(!rt_mutex_cmpxchg_acquire(rtm, NULL, current)))
 		rtlock_slowlock(rtm);
 }
