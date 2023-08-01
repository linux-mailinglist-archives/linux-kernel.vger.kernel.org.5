Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A557876B5B9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjHANZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjHANY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:24:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF091985
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 06:24:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DD4F61586
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 13:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B81DC433C8;
        Tue,  1 Aug 2023 13:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690896295;
        bh=feqQBtIQhDcLNaK5yV5c0SoBbM4IgwK6op+QnaFp2wY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hJ1VvodxVi5EP11Bjtgw6Oj0x5oqLYcCDP6Jfz/HKcjqeloi1SlufqjWZ14f0Wpco
         1AUGhZ2yRxdEFjieO2AJkIxl1upO9jbBluXpIcvFnyNSe3D1sPqeiVTFtlraJPeRFj
         UYCyv4B8zEjo13yezuB34uFq8Q+CNAtxh4bV104867QpLikgOnv2FzxpKbB/vYIg7j
         R2Hez7VsHhP1DtV/hANNbPwxjqTvqa+nse/MjQWu1+GMAMSF1Ta8dARfDl2oNBoLdv
         ZTEEPOXW0M/ww/bfXlau7+mEp6IPb/yVTo8/xIQlA78omsqY7eZBrhhWolq81ik3rN
         pIXQiO8N55kVA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Eric Dumazet <edumazet@google.com>
Subject: [RFC PATCH 3/6] softirq: Introduce softirq disabled mask
Date:   Tue,  1 Aug 2023 15:24:38 +0200
Message-Id: <20230801132441.559222-4-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801132441.559222-1-frederic@kernel.org>
References: <20230801132441.559222-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(DISCLAIMER: contains -RT bits)

When softirq vectors will be able to re-enable softirqs when deemed
safe, for example when a timer callback is tagged as soft-interruptible
by other softirq vectors, care must be taken to ensure a given vector
is not re-entrant. Ie: a vector can be interrupted by others but not
by itself.

In order to prepare for this, introduce a softirq disabled mask so that
vectors can disable themselves before re-enabling softirqs.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/Kconfig                |  3 +++
 include/linux/bottom_half.h |  2 ++
 include/linux/interrupt.h   | 15 ++++++++++++---
 kernel/softirq.c            | 16 +++++++++++++++-
 4 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 205fd23e0cad..d23968860ddf 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1358,6 +1358,9 @@ config RELR
 config ARCH_HAS_MEM_ENCRYPT
 	bool
 
+config ARCH_HAS_SOFTIRQ_DISABLED_MASK
+       bool
+
 config ARCH_HAS_CC_PLATFORM
 	bool
 
diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index 2243c7de4917..d5b37b580c79 100644
--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -42,6 +42,8 @@ extern void local_bh_exit(void);
 
 #ifdef CONFIG_PREEMPT_RT
 extern bool local_bh_blocked(void);
+extern void local_bh_vec_enable(int vec);
+extern void local_bh_vec_disable(int vec);
 #else
 static inline bool local_bh_blocked(void) { return false; }
 #endif
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 2099fe3980bc..7819d16d8d6f 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -523,8 +523,16 @@ DECLARE_STATIC_KEY_FALSE(force_irqthreads_key);
 #define local_softirq_pending_ref irq_stat.__softirq_pending
 #endif
 
-#define local_softirq_pending()	(__this_cpu_read(local_softirq_pending_ref))
-#define reset_softirq_pending()	(__this_cpu_write(local_softirq_pending_ref, 0))
+#if defined(CONFIG_PREEMPT_RT) && defined(CONFIG_ARCH_HAS_SOFTIRQ_DISABLED_MASK)
+#define local_softirq_disabled()	(__this_cpu_read(local_softirq_disabled_ref))
+#else
+#define local_softirq_disabled()	(0)
+#endif
+
+#define local_softirq_pending()	(__this_cpu_read(local_softirq_pending_ref) & \
+				 ~local_softirq_disabled())
+#define reset_softirq_pending() (__this_cpu_and(local_softirq_pending_ref, \
+				local_softirq_disabled()))
 #define or_softirq_pending(x)	(__this_cpu_or(local_softirq_pending_ref, (x)))
 
 #endif /* local_softirq_pending */
@@ -614,7 +622,8 @@ extern void raise_hrtimer_softirq(void);
 
 static inline unsigned int local_pending_timers(void)
 {
-        return __this_cpu_read(pending_timer_softirq);
+        return __this_cpu_read(pending_timer_softirq) &
+		~local_softirq_disabled();
 }
 
 #else
diff --git a/kernel/softirq.c b/kernel/softirq.c
index ba998d572ef4..a394f78de627 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -297,6 +297,18 @@ void do_softirq_post_smp_call_flush(unsigned int was_pending)
 		invoke_softirq();
 }
 
+#ifdef CONFIG_ARCH_HAS_SOFTIRQ_DISABLED_MASK
+void local_bh_vec_enable(int vec)
+{
+	__this_cpu_and(local_softirq_disabled_ref, ~vec);
+}
+
+void local_bh_vec_disable(int vec)
+{
+	__this_cpu_or(local_softirq_disabled_ref, vec);
+}
+#endif
+
 #else /* CONFIG_PREEMPT_RT */
 
 /*
@@ -1009,11 +1021,13 @@ static int timersd_should_run(unsigned int cpu)
 static void run_timersd(unsigned int cpu)
 {
 	unsigned int timer_si;
+	unsigned long timersd_vecs = (1 << TIMER_SOFTIRQ) | (1 << HRTIMER_SOFTIRQ);
 
 	ksoftirqd_run_begin();
 
 	timer_si = local_pending_timers();
-	__this_cpu_write(pending_timer_softirq, 0);
+	__this_cpu_and(pending_timer_softirq,
+		       local_softirq_disabled() & timersd_vecs);
 	or_softirq_pending(timer_si);
 
 	__do_softirq();
-- 
2.34.1

