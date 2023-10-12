Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964FE7C75FE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379701AbjJLSgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 14:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235786AbjJLSgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:36:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B9A114;
        Thu, 12 Oct 2023 11:35:57 -0700 (PDT)
Date:   Thu, 12 Oct 2023 18:35:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697135755;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AaaP0/zh6OCb+5ToMe9sajJWn4xGggVgNktRglPzutM=;
        b=0qZIclCDsX1rZaYJ73003speA4HZliX5+prUDXS+qG1rrDEew8eXXCj1uc7/LudEdqory6
        HDq/oG9ms2WqKmb7/+JsnZHVIKFc2xKwKBdDH7trGNd2A63bua+wgCC6O3hD9q6CMnrYfW
        FAdRITq6Uy5CbMWW7OSBrLkkav487036dKotp4tt8CXLGbljAxWqlu1IMRXCWFQ0DjAaej
        /Kb4ISzdHcrD4Z4orLUcTH68Ag7q6UMVVi0Lqu/lIDVrWzcD/5F7MlAK7f6gvtD0BpG0W5
        4AQsso/+mHkLn4S5bZxkn80i9acatqVo9vjkPH7jD1ma9SwYiIzDfyMiBKj0cQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697135755;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AaaP0/zh6OCb+5ToMe9sajJWn4xGggVgNktRglPzutM=;
        b=8fVDPzka9nHsdsW4Ls/a/xWKkkwDFY8myA7YsYmX5R+fmM545Dfj9CYmckNMFY/bygQcWL
        N8Zgjou8jYmkZxAQ==
From:   "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/seqlock: Simplify SEQCOUNT_LOCKNAME()
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231012143158.GA16133@redhat.com>
References: <20231012143158.GA16133@redhat.com>
MIME-Version: 1.0
Message-ID: <169713575506.3135.7190411037772365188.tip-bot2@tip-bot2>
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

Commit-ID:     f995443f01b4dbcce723539b99050ce69b319e58
Gitweb:        https://git.kernel.org/tip/f995443f01b4dbcce723539b99050ce69b319e58
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Thu, 12 Oct 2023 16:31:58 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 12 Oct 2023 20:18:20 +02:00

locking/seqlock: Simplify SEQCOUNT_LOCKNAME()

1. Kill the "lockmember" argument. It is always s->lock plus
   __seqprop_##lockname##_sequence() already uses s->lock and
   ignores "lockmember".

2. Kill the "lock_acquire" argument. __seqprop_##lockname##_sequence()
   can use the same "lockbase" prefix for _lock and _unlock.

Apart from line numbers, gcc -E outputs the same code.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20231012143158.GA16133@redhat.com
---
 include/linux/seqlock.h | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index af518e4..7e7109d 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -191,11 +191,9 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
  * @lockname:		"LOCKNAME" part of seqcount_LOCKNAME_t
  * @locktype:		LOCKNAME canonical C data type
  * @preemptible:	preemptibility of above locktype
- * @lockmember:		argument for lockdep_assert_held()
- * @lockbase:		associated lock release function (prefix only)
- * @lock_acquire:	associated lock acquisition function (full call)
+ * @lockbase:		prefix for associated lock/unlock
  */
-#define SEQCOUNT_LOCKNAME(lockname, locktype, preemptible, lockmember, lockbase, lock_acquire) \
+#define SEQCOUNT_LOCKNAME(lockname, locktype, preemptible, lockbase)	\
 typedef struct seqcount_##lockname {					\
 	seqcount_t		seqcount;				\
 	__SEQ_LOCK(locktype	*lock);					\
@@ -216,7 +214,7 @@ __seqprop_##lockname##_sequence(const seqcount_##lockname##_t *s)	\
 		return seq;						\
 									\
 	if (preemptible && unlikely(seq & 1)) {				\
-		__SEQ_LOCK(lock_acquire);				\
+		__SEQ_LOCK(lockbase##_lock(s->lock));			\
 		__SEQ_LOCK(lockbase##_unlock(s->lock));			\
 									\
 		/*							\
@@ -242,7 +240,7 @@ __seqprop_##lockname##_preemptible(const seqcount_##lockname##_t *s)	\
 static __always_inline void						\
 __seqprop_##lockname##_assert(const seqcount_##lockname##_t *s)		\
 {									\
-	__SEQ_LOCK(lockdep_assert_held(lockmember));			\
+	__SEQ_LOCK(lockdep_assert_held(s->lock));			\
 }
 
 /*
@@ -271,10 +269,10 @@ static inline void __seqprop_assert(const seqcount_t *s)
 
 #define __SEQ_RT	IS_ENABLED(CONFIG_PREEMPT_RT)
 
-SEQCOUNT_LOCKNAME(raw_spinlock, raw_spinlock_t,  false,    s->lock,        raw_spin, raw_spin_lock(s->lock))
-SEQCOUNT_LOCKNAME(spinlock,     spinlock_t,      __SEQ_RT, s->lock,        spin,     spin_lock(s->lock))
-SEQCOUNT_LOCKNAME(rwlock,       rwlock_t,        __SEQ_RT, s->lock,        read,     read_lock(s->lock))
-SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     s->lock,        mutex,    mutex_lock(s->lock))
+SEQCOUNT_LOCKNAME(raw_spinlock, raw_spinlock_t,  false,    raw_spin)
+SEQCOUNT_LOCKNAME(spinlock,     spinlock_t,      __SEQ_RT, spin)
+SEQCOUNT_LOCKNAME(rwlock,       rwlock_t,        __SEQ_RT, read)
+SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
 
 /*
  * SEQCNT_LOCKNAME_ZERO - static initializer for seqcount_LOCKNAME_t
