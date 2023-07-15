Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0DC754CD4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 01:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjGOXxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 19:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjGOXxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 19:53:12 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD771BFB
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 16:53:11 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-991ef0b464cso941404166b.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 16:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689465190; x=1692057190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BNh6KuuN3cmG0+JrajYXp4ic6pvoK/gD193Fr0qvWKQ=;
        b=iYmDu+8bprAu6sLIH67CAZBPxPbbVfw4G1ucjw8f34Nap8CYOZzlE7NCBLfJNDNOFc
         /2fI54P/Yb7Jb6J6xon5vq3ZGG9FZKaitfaHvd3j0wof88Gw/rQd+d/pqAhJdZKfl6D5
         tbBa8qeiA6H2MhNCjdK+vyF10ezJ983e3WK9DFzwu7pMGTvIml7s00OlOTgSs1hADRZy
         yL7ICjWBA6t6igNM40OpTCLC3n3sj1g1di9DhHrc7O2Bdfh7fbboOkKoTjRsQKX3kc7w
         S3eNDhPykPLGbIVSCG5NwJlPc6PRqIBPFarsBFnz2zrZ0qbSvYdJZXnLa+4Zm3WJFfwr
         iFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689465190; x=1692057190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNh6KuuN3cmG0+JrajYXp4ic6pvoK/gD193Fr0qvWKQ=;
        b=cGAQWUVosPcATS4opHd2mSVYiwfnQi9vG9/Ojtj68MiUHPBQhAyOn7tJoDOFN7fCJN
         f/xPQlZCYo0RXxvjJflrMg+V05xxY4JfzCsN5rF6NQWzoSOxGYVvDNXjB7ZkDVbfj5ol
         u91K/6jFupCEzRbEu3E+OsTRmoQLNAHhFFl23vOEaV7sopHkgj+u0qhlkTNQee6Whq0a
         INkcg4DnXCzvVB5lE1XUFsgfmYfxEywGiDGz2s0/GZ6wHFvByoaicnpRDO76pQRJr0oo
         FLIrqJ72+uLPd0GhQ/Y/TShRtgBBPN5wIuelQOXKLLZec7J97QNi/xZx0EI2jiZDilyr
         Bp8w==
X-Gm-Message-State: ABy/qLYZYdyUCsjiNlHPhHfTc+IKMKkUpMD7lr8OjyRvp7Yd9uB2npKy
        DI3oc1RwSB8CyXKWrzl5yvo=
X-Google-Smtp-Source: APBJJlEJG7dU4kcI58bewkZ2mEZdzhiTuyE9MOjlDK9YzUo68Jt6BkzHEJTRwHYqlo035kgxNqEulA==
X-Received: by 2002:a17:906:10d0:b0:993:f611:7c97 with SMTP id v16-20020a17090610d000b00993f6117c97mr7778043ejv.33.1689465189645;
        Sat, 15 Jul 2023 16:53:09 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id a18-20020a17090680d200b00992d70cc8acsm7184718ejx.112.2023.07.15.16.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 16:53:08 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 71E1727C0054;
        Sat, 15 Jul 2023 19:53:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 15 Jul 2023 19:53:07 -0400
X-ME-Sender: <xms:YjGzZD__Vzxq1uBSycsWStNmzLW10VODhlX3ezJZJchMCHwTZ4oouA>
    <xme:YjGzZPtj1PhHwd665k06M2x0y5Q3G1JK0WE1futMVpcTm2_OR5DmVUIZyafTaQwJJ
    vsJoMHvD41mEVo0Ag>
X-ME-Received: <xmr:YjGzZBBsBpEo2U1nQo94Rk4K5YDCAO1m2d6lQhDw6_VUwVvhiC09NatbDPrFcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeelgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepgeegueekgefhvedukedtveejhefhkeffveeufeduiedvleetledtkeehjefgieev
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:YjGzZPfOdUgW-O0nmhlVFHI6oW8JHSurF3czS8ag8qU1NPoRep_qKQ>
    <xmx:YjGzZIPNEuxMHwlWPg4JM9ga6yYSecBpF2mxJwX3q85OCcaHgDbqKw>
    <xmx:YjGzZBnPT_jwk8BjbCTvm0Mwi0hwCE3BsMSoF0PnFTa6lmxKFGe0ng>
    <xmx:YzGzZFoeivWBmy3DWktVnGXWZyezRr8dl28ykWm9sCXf2CuoHYryxQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 15 Jul 2023 19:53:06 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH] lockdep/selftests: Use SBRM APIs for wait context tests
Date:   Sat, 15 Jul 2023 16:52:57 -0700
Message-ID: <20230715235257.110325-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.41.0
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
---
 lib/locking-selftest.c | 135 +++++++++++------------------------------
 1 file changed, 35 insertions(+), 100 deletions(-)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 8d24279fad05..6f6a5fc85b42 100644
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
 
-- 
2.41.0

