Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C287692CA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjGaKLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjGaKLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:11:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA824C9;
        Mon, 31 Jul 2023 03:11:16 -0700 (PDT)
Date:   Mon, 31 Jul 2023 10:11:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690798274;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WpvjYxFI4BzrGEa0puYjd3LNu9omFnS53DfshMviWQw=;
        b=b0rE5NLwh2xybTCMgLFwGn7U1KceX4NIM8sHZZELQbRlZyw4tzy4FpbVlyhg+EEtaVhSTQ
        JAw8ybZIDT3UltA8s00AsvA7dHC1kyCvkiKT9EPY4Z6J69C72g0Vecm04/4v5yf03HraJ3
        TY3PzSnvj76GXKshGUvuhfynd3rW53qMiBnKsUaTHzZ26HXxziF9CQ8H2b+dhll8vfkFd1
        hwzKkw3V2p8QBXIBnZqU2CK8PrYCLayYgcLFYuXKhGpB/UbEuapfmwV9IKO0ZBZZ+ihBaP
        SMDw3ZsOMsB3SnRo18lpDpcCnq1fiHtIuSe4vlFbD3AIkAYYwyaRMAX0fD4o/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690798274;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WpvjYxFI4BzrGEa0puYjd3LNu9omFnS53DfshMviWQw=;
        b=dY3kaiUf1HhsESrjRDRm0WkSjwnA5Xw+nDBt+qxE6ZyvKriNVfQX/5Tm1DG1jabl5lS1jP
        gjob7/rKJgaFjlBQ==
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep/selftests: Use SBRM APIs for wait context tests
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230715235257.110325-1-boqun.feng@gmail.com>
References: <20230715235257.110325-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Message-ID: <169079827354.28540.2671825457338788190.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f66c538098b61e2eb596bb88fae90dbd2cebb378
Gitweb:        https://git.kernel.org/tip/f66c538098b61e2eb596bb88fae90dbd2cebb378
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Sat, 15 Jul 2023 16:52:57 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Jul 2023 12:29:13 +02:00

lockdep/selftests: Use SBRM APIs for wait context tests

The "__cleanup__" attribute is already used for wait context tests, so
using it for locking tests has already been proven working. Now since
SBRM APIs are merged, let's use these APIs instead of a local guard
framework. This also helps testing SBRM APIs.

Note that originally the tests don't rely on the cleanup ordering of
two variables in the same scope, but since now it's something we'd like
to assume and rely on[1], drop the extra scope in inner_in_outer()
function. Again this gives us another opportunity to test the compiler
behavior.

[1]: https://lore.kernel.org/lkml/CAHk-=whEsr6fuVSdsoNPokLR2fZiGuo_hCLyrS-LCw7hT_N7cQ@mail.gmail.com/
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230715235257.110325-1-boqun.feng@gmail.com
---
 lib/locking-selftest.c | 135 ++++++++++------------------------------
 1 file changed, 35 insertions(+), 100 deletions(-)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 8d24279..6f6a5fc 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -2506,94 +2506,29 @@ static void fs_reclaim_tests(void)
 	pr_cont("\n");
 }
 
-#define __guard(cleanup) __maybe_unused __attribute__((__cleanup__(cleanup)))
+/* Defines guard classes to create contexts */
+DEFINE_LOCK_GUARD_0(HARDIRQ, HARDIRQ_ENTER(), HARDIRQ_EXIT())
+DEFINE_LOCK_GUARD_0(NOTTHREADED_HARDIRQ,
+	do {
+		local_irq_disable();
+		__irq_enter();
+		WARN_ON(!in_irq());
+	} while(0), HARDIRQ_EXIT())
+DEFINE_LOCK_GUARD_0(SOFTIRQ, SOFTIRQ_ENTER(), SOFTIRQ_EXIT())
+
+/* Define RCU guards, should go away when RCU has its own guard definitions */
+DEFINE_LOCK_GUARD_0(RCU, rcu_read_lock(), rcu_read_unlock())
+DEFINE_LOCK_GUARD_0(RCU_BH, rcu_read_lock_bh(), rcu_read_unlock_bh())
+DEFINE_LOCK_GUARD_0(RCU_SCHED, rcu_read_lock_sched(), rcu_read_unlock_sched())
 
-static void hardirq_exit(int *_)
-{
-	HARDIRQ_EXIT();
-}
-
-#define HARDIRQ_CONTEXT(name, ...)					\
-	int hardirq_guard_##name __guard(hardirq_exit);			\
-	HARDIRQ_ENTER();
-
-#define NOTTHREADED_HARDIRQ_CONTEXT(name, ...)				\
-	int notthreaded_hardirq_guard_##name __guard(hardirq_exit);	\
-	local_irq_disable();						\
-	__irq_enter();							\
-	WARN_ON(!in_irq());
-
-static void softirq_exit(int *_)
-{
-	SOFTIRQ_EXIT();
-}
-
-#define SOFTIRQ_CONTEXT(name, ...)				\
-	int softirq_guard_##name __guard(softirq_exit);		\
-	SOFTIRQ_ENTER();
-
-static void rcu_exit(int *_)
-{
-	rcu_read_unlock();
-}
-
-#define RCU_CONTEXT(name, ...)					\
-	int rcu_guard_##name __guard(rcu_exit);			\
-	rcu_read_lock();
-
-static void rcu_bh_exit(int *_)
-{
-	rcu_read_unlock_bh();
-}
-
-#define RCU_BH_CONTEXT(name, ...)				\
-	int rcu_bh_guard_##name __guard(rcu_bh_exit);		\
-	rcu_read_lock_bh();
-
-static void rcu_sched_exit(int *_)
-{
-	rcu_read_unlock_sched();
-}
-
-#define RCU_SCHED_CONTEXT(name, ...)				\
-	int rcu_sched_guard_##name __guard(rcu_sched_exit);	\
-	rcu_read_lock_sched();
-
-static void raw_spinlock_exit(raw_spinlock_t **lock)
-{
-	raw_spin_unlock(*lock);
-}
-
-#define RAW_SPINLOCK_CONTEXT(name, lock)						\
-	raw_spinlock_t *raw_spinlock_guard_##name __guard(raw_spinlock_exit) = &(lock);	\
-	raw_spin_lock(&(lock));
-
-static void spinlock_exit(spinlock_t **lock)
-{
-	spin_unlock(*lock);
-}
-
-#define SPINLOCK_CONTEXT(name, lock)						\
-	spinlock_t *spinlock_guard_##name __guard(spinlock_exit) = &(lock);	\
-	spin_lock(&(lock));
-
-static void mutex_exit(struct mutex **lock)
-{
-	mutex_unlock(*lock);
-}
-
-#define MUTEX_CONTEXT(name, lock)					\
-	struct mutex *mutex_guard_##name __guard(mutex_exit) = &(lock);	\
-	mutex_lock(&(lock));
 
 #define GENERATE_2_CONTEXT_TESTCASE(outer, outer_lock, inner, inner_lock)	\
 										\
 static void __maybe_unused inner##_in_##outer(void)				\
 {										\
-	outer##_CONTEXT(_, outer_lock);						\
-	{									\
-		inner##_CONTEXT(_, inner_lock);					\
-	}									\
+	/* Relies the reversed clean-up ordering: inner first */		\
+	guard(outer)(outer_lock);						\
+	guard(inner)(inner_lock);						\
 }
 
 /*
@@ -2632,21 +2567,21 @@ GENERATE_2_CONTEXT_TESTCASE(SOFTIRQ, , inner, inner_lock)			\
 GENERATE_2_CONTEXT_TESTCASE(RCU, , inner, inner_lock)				\
 GENERATE_2_CONTEXT_TESTCASE(RCU_BH, , inner, inner_lock)			\
 GENERATE_2_CONTEXT_TESTCASE(RCU_SCHED, , inner, inner_lock)			\
-GENERATE_2_CONTEXT_TESTCASE(RAW_SPINLOCK, raw_lock_A, inner, inner_lock)	\
-GENERATE_2_CONTEXT_TESTCASE(SPINLOCK, lock_A, inner, inner_lock)		\
-GENERATE_2_CONTEXT_TESTCASE(MUTEX, mutex_A, inner, inner_lock)
+GENERATE_2_CONTEXT_TESTCASE(raw_spinlock, &raw_lock_A, inner, inner_lock)	\
+GENERATE_2_CONTEXT_TESTCASE(spinlock, &lock_A, inner, inner_lock)		\
+GENERATE_2_CONTEXT_TESTCASE(mutex, &mutex_A, inner, inner_lock)
 
 GENERATE_2_CONTEXT_TESTCASE_FOR_ALL_OUTER(RCU, )
-GENERATE_2_CONTEXT_TESTCASE_FOR_ALL_OUTER(RAW_SPINLOCK, raw_lock_B)
-GENERATE_2_CONTEXT_TESTCASE_FOR_ALL_OUTER(SPINLOCK, lock_B)
-GENERATE_2_CONTEXT_TESTCASE_FOR_ALL_OUTER(MUTEX, mutex_B)
+GENERATE_2_CONTEXT_TESTCASE_FOR_ALL_OUTER(raw_spinlock, &raw_lock_B)
+GENERATE_2_CONTEXT_TESTCASE_FOR_ALL_OUTER(spinlock, &lock_B)
+GENERATE_2_CONTEXT_TESTCASE_FOR_ALL_OUTER(mutex, &mutex_B)
 
 /* the outer context allows all kinds of preemption */
 #define DO_CONTEXT_TESTCASE_OUTER_PREEMPTIBLE(outer)			\
 	dotest(RCU_in_##outer, SUCCESS, LOCKTYPE_RWLOCK);		\
-	dotest(RAW_SPINLOCK_in_##outer, SUCCESS, LOCKTYPE_SPIN);	\
-	dotest(SPINLOCK_in_##outer, SUCCESS, LOCKTYPE_SPIN);		\
-	dotest(MUTEX_in_##outer, SUCCESS, LOCKTYPE_MUTEX);		\
+	dotest(raw_spinlock_in_##outer, SUCCESS, LOCKTYPE_SPIN);	\
+	dotest(spinlock_in_##outer, SUCCESS, LOCKTYPE_SPIN);		\
+	dotest(mutex_in_##outer, SUCCESS, LOCKTYPE_MUTEX);		\
 
 /*
  * the outer context only allows the preemption introduced by spinlock_t (which
@@ -2654,16 +2589,16 @@ GENERATE_2_CONTEXT_TESTCASE_FOR_ALL_OUTER(MUTEX, mutex_B)
  */
 #define DO_CONTEXT_TESTCASE_OUTER_LIMITED_PREEMPTIBLE(outer)		\
 	dotest(RCU_in_##outer, SUCCESS, LOCKTYPE_RWLOCK);		\
-	dotest(RAW_SPINLOCK_in_##outer, SUCCESS, LOCKTYPE_SPIN);	\
-	dotest(SPINLOCK_in_##outer, SUCCESS, LOCKTYPE_SPIN);		\
-	dotest(MUTEX_in_##outer, FAILURE, LOCKTYPE_MUTEX);		\
+	dotest(raw_spinlock_in_##outer, SUCCESS, LOCKTYPE_SPIN);	\
+	dotest(spinlock_in_##outer, SUCCESS, LOCKTYPE_SPIN);		\
+	dotest(mutex_in_##outer, FAILURE, LOCKTYPE_MUTEX);		\
 
 /* the outer doesn't allows any kind of preemption */
 #define DO_CONTEXT_TESTCASE_OUTER_NOT_PREEMPTIBLE(outer)			\
 	dotest(RCU_in_##outer, SUCCESS, LOCKTYPE_RWLOCK);		\
-	dotest(RAW_SPINLOCK_in_##outer, SUCCESS, LOCKTYPE_SPIN);	\
-	dotest(SPINLOCK_in_##outer, FAILURE, LOCKTYPE_SPIN);		\
-	dotest(MUTEX_in_##outer, FAILURE, LOCKTYPE_MUTEX);		\
+	dotest(raw_spinlock_in_##outer, SUCCESS, LOCKTYPE_SPIN);	\
+	dotest(spinlock_in_##outer, FAILURE, LOCKTYPE_SPIN);		\
+	dotest(mutex_in_##outer, FAILURE, LOCKTYPE_MUTEX);		\
 
 static void wait_context_tests(void)
 {
@@ -2697,15 +2632,15 @@ static void wait_context_tests(void)
 	pr_cont("\n");
 
 	print_testname("in RAW_SPINLOCK context");
-	DO_CONTEXT_TESTCASE_OUTER_NOT_PREEMPTIBLE(RAW_SPINLOCK);
+	DO_CONTEXT_TESTCASE_OUTER_NOT_PREEMPTIBLE(raw_spinlock);
 	pr_cont("\n");
 
 	print_testname("in SPINLOCK context");
-	DO_CONTEXT_TESTCASE_OUTER_LIMITED_PREEMPTIBLE(SPINLOCK);
+	DO_CONTEXT_TESTCASE_OUTER_LIMITED_PREEMPTIBLE(spinlock);
 	pr_cont("\n");
 
 	print_testname("in MUTEX context");
-	DO_CONTEXT_TESTCASE_OUTER_PREEMPTIBLE(MUTEX);
+	DO_CONTEXT_TESTCASE_OUTER_PREEMPTIBLE(mutex);
 	pr_cont("\n");
 }
 
