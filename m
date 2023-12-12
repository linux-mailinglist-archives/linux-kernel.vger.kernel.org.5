Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DA180F4C5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376833AbjLLRkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235111AbjLLRk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:40:29 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9259893;
        Tue, 12 Dec 2023 09:40:34 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1d0c4d84bf6so34876415ad.1;
        Tue, 12 Dec 2023 09:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702402833; x=1703007633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wb/zKNdC7bdgAuwTDYO4B+LddWYAbkeeSM8m3zQ/yXU=;
        b=JHMXm8eSQtt7V8ljZuHEYO1L3iSp1bKmcqNcXwpvaboIuxJlg7sDn2ZqQPrOMZLS0i
         1qw26B5PZIZ8gdzJO82b3kNIxu+5shLGCwkEfe7gKtFewIjYSd3+ZkOsg7B5H/jmcoiZ
         Tf73TcrhJOxR9nFWwg8nj418EwEAP1LePScr0RluVxtLGxKRWsx36fg3zWrsvX4xuYw0
         W4taVDCmZUVhOyvUljhYlhZx/tph2hyDENrWTZCDVlQ7iuqUjUgXYxcsSjsXEcle4qEO
         I+TUU6V5OoOM4/XqMfTVzgzhfoF8ADeok3BvhIRUg0jt5lgZlFe4RVsgrKY1xWzw3pf+
         ryhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702402833; x=1703007633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wb/zKNdC7bdgAuwTDYO4B+LddWYAbkeeSM8m3zQ/yXU=;
        b=wvM3fI7liXT5OzjGyIWomS6NblcliK3cOaORm7JzRJG5bQD8pUZKd/yFTOfRTW4QMh
         haS0XNubxrsq5evWCjnJK7IDXgs4ihjnBlCAeInnVkCKqzUs9lCi121qZy3ME9RuIhUL
         8EN839G4c1o4tojHy9X6yi6Jj3iuDjGnakUl6yzouAV9NliWR0j8WzX47PAYIhzupw1S
         32H7NqdHUnVuHfGjzxl9FQYCWCnl/cqE6zph7P8Br8kbJCFvEdJjBgwY1cQ2jSFLbwkW
         mLHZ4fur6r9MnmzxLKQ8JtPTk7DWzflfnZksV6F5sD5FbzcfXvP+matBT1mtuqf95Stt
         yfMA==
X-Gm-Message-State: AOJu0Yx2jXf33LIMIkyZlcPah1YbRCPEsn6S0i0EVNKV9FqsaH+79ruf
        +qlAeGaMl5oDfHXs625umDxWOKBKLTMK7ytq
X-Google-Smtp-Source: AGHT+IGJFnnyjPqba90wmXb62M1AhZ8SGyTgGDijaqgLbH3ttpRtNGK2z/qo18uKCrWvusDQGaklAg==
X-Received: by 2002:a17:903:280e:b0:1d0:6ffd:f1f9 with SMTP id kp14-20020a170903280e00b001d06ffdf1f9mr3099058plb.79.1702402832874;
        Tue, 12 Dec 2023 09:40:32 -0800 (PST)
Received: from localhost.localdomain ([101.0.63.152])
        by smtp.gmail.com with ESMTPSA id jc19-20020a17090325d300b001cc25cfec58sm8903135plb.226.2023.12.12.09.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:40:32 -0800 (PST)
From:   "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, paulmck@kernel.org, Neeraj.Upadhyay@amd.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Subject: [PATCH rcu 1/3] rcu: Restrict access to RCU CPU stall notifiers
Date:   Tue, 12 Dec 2023 23:10:02 +0530
Message-Id: <20231212174004.11754-1-neeraj.iitr10@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212173948.GA11724@neeraj.linux>
References: <20231212173948.GA11724@neeraj.linux>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Although the RCU CPU stall notifiers can be useful for dumping state when
tracking down delicate forward-progress bugs where NUMA effects cause
cache lines to be delivered to a given CPU regularly, but always in a
state that prevents that CPU from making forward progress.  These bugs can
be detected by the RCU CPU stall-warning mechanism, but in some cases,
the stall-warnings printk()s disrupt the forward-progress bug before
any useful state can be obtained.

Unfortunately, the notifier mechanism added by commit 5b404fdabacf ("rcu:
Add RCU CPU stall notifier") can make matters worse if used at all
carelessly. For example, if the stall warning was caused by a lock not
being released, then any attempt to acquire that lock in the notifier
will hang. This will prevent not only the notifier from producing any
useful output, but it will also prevent the stall-warning message from
ever appearing.

This commit therefore hides this new RCU CPU stall notifier
mechanism under a new RCU_CPU_STALL_NOTIFIER Kconfig option that
depends on both DEBUG_KERNEL and RCU_EXPERT.  In addition, the
rcupdate.rcu_cpu_stall_notifiers=1 kernel boot parameter must also
be specified.  The RCU_CPU_STALL_NOTIFIER Kconfig option's help text
contains a warning and explains the dangers of careless use, recommending
lockless notifier code.  In addition, a WARN() is triggered each time
that an attempt is made to register a stall-warning notifier in kernels
built with CONFIG_RCU_CPU_STALL_NOTIFIER=y.

This combination of measures will keep use of this mechanism confined to
debug kernels and away from routine deployments.

[ paulmck: Apply Dan Carpenter feedback. ]

Fixes: 5b404fdabacf ("rcu: Add RCU CPU stall notifier")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.iitr10@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 +++++
 include/linux/rcu_notifier.h                  |  6 ++---
 kernel/rcu/Kconfig.debug                      | 25 +++++++++++++++++++
 kernel/rcu/rcu.h                              |  8 +++---
 kernel/rcu/rcutorture.c                       | 12 +++++----
 kernel/rcu/tree_stall.h                       | 11 +++++++-
 kernel/rcu/update.c                           |  6 +++++
 7 files changed, 62 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 65731b060e3f..b72e2049c487 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5302,6 +5302,12 @@
 			Dump ftrace buffer after reporting RCU CPU
 			stall warning.
 
+	rcupdate.rcu_cpu_stall_notifiers= [KNL]
+			Provide RCU CPU stall notifiers, but see the
+			warnings in the RCU_CPU_STALL_NOTIFIER Kconfig
+			option's help text.  TL;DR:  You almost certainly
+			do not want rcupdate.rcu_cpu_stall_notifiers.
+
 	rcupdate.rcu_cpu_stall_suppress= [KNL]
 			Suppress RCU CPU stall warning messages.
 
diff --git a/include/linux/rcu_notifier.h b/include/linux/rcu_notifier.h
index ebf371364581..5640f024773b 100644
--- a/include/linux/rcu_notifier.h
+++ b/include/linux/rcu_notifier.h
@@ -13,7 +13,7 @@
 #define RCU_STALL_NOTIFY_NORM	1
 #define RCU_STALL_NOTIFY_EXP	2
 
-#ifdef CONFIG_RCU_STALL_COMMON
+#if defined(CONFIG_RCU_STALL_COMMON) && defined(CONFIG_RCU_CPU_STALL_NOTIFIER)
 
 #include <linux/notifier.h>
 #include <linux/types.h>
@@ -21,12 +21,12 @@
 int rcu_stall_chain_notifier_register(struct notifier_block *n);
 int rcu_stall_chain_notifier_unregister(struct notifier_block *n);
 
-#else // #ifdef CONFIG_RCU_STALL_COMMON
+#else // #if defined(CONFIG_RCU_STALL_COMMON) && defined(CONFIG_RCU_CPU_STALL_NOTIFIER)
 
 // No RCU CPU stall warnings in Tiny RCU.
 static inline int rcu_stall_chain_notifier_register(struct notifier_block *n) { return -EEXIST; }
 static inline int rcu_stall_chain_notifier_unregister(struct notifier_block *n) { return -ENOENT; }
 
-#endif // #else // #ifdef CONFIG_RCU_STALL_COMMON
+#endif // #else // #if defined(CONFIG_RCU_STALL_COMMON) && defined(CONFIG_RCU_CPU_STALL_NOTIFIER)
 
 #endif /* __LINUX_RCU_NOTIFIER_H */
diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 2984de629f74..9b0b52e1836f 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -105,6 +105,31 @@ config RCU_CPU_STALL_CPUTIME
 	  The boot option rcupdate.rcu_cpu_stall_cputime has the same function
 	  as this one, but will override this if it exists.
 
+config RCU_CPU_STALL_NOTIFIER
+	bool "Provide RCU CPU-stall notifiers"
+	depends on RCU_STALL_COMMON
+	depends on DEBUG_KERNEL
+	depends on RCU_EXPERT
+	default n
+	help
+	  WARNING:  You almost certainly do not want this!!!
+
+	  Enable RCU CPU-stall notifiers, which are invoked just before
+	  printing the RCU CPU stall warning.  As such, bugs in notifier
+	  callbacks can prevent stall warnings from being printed.
+	  And the whole reason that a stall warning is being printed is
+	  that something is hung up somewhere.	Therefore, the notifier
+	  callbacks must be written extremely carefully, preferably
+	  containing only lockless code.  After all, it is quite possible
+	  that the whole reason that the RCU CPU stall is happening in
+	  the first place is that someone forgot to release whatever lock
+	  that you are thinking of acquiring.  In which case, having your
+	  notifier callback acquire that lock will hang, preventing the
+	  RCU CPU stall warning from appearing.
+
+	  Say Y here if you want RCU CPU stall notifiers (you don't want them)
+	  Say N if you are unsure.
+
 config RCU_TRACE
 	bool "Enable tracing for RCU"
 	depends on DEBUG_KERNEL
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index b531c33e9545..f94f65877f2b 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -262,6 +262,8 @@ static inline bool rcu_stall_is_suppressed_at_boot(void)
 	return rcu_cpu_stall_suppress_at_boot && !rcu_inkernel_boot_has_ended();
 }
 
+extern int rcu_cpu_stall_notifiers;
+
 #ifdef CONFIG_RCU_STALL_COMMON
 
 extern int rcu_cpu_stall_ftrace_dump;
@@ -659,10 +661,10 @@ static inline bool rcu_cpu_beenfullyonline(int cpu) { return true; }
 bool rcu_cpu_beenfullyonline(int cpu);
 #endif
 
-#ifdef CONFIG_RCU_STALL_COMMON
+#if defined(CONFIG_RCU_STALL_COMMON) && defined(CONFIG_RCU_CPU_STALL_NOTIFIER)
 int rcu_stall_notifier_call_chain(unsigned long val, void *v);
-#else // #ifdef CONFIG_RCU_STALL_COMMON
+#else // #if defined(CONFIG_RCU_STALL_COMMON) && defined(CONFIG_RCU_CPU_STALL_NOTIFIER)
 static inline int rcu_stall_notifier_call_chain(unsigned long val, void *v) { return NOTIFY_DONE; }
-#endif // #else // #ifdef CONFIG_RCU_STALL_COMMON
+#endif // #else // #if defined(CONFIG_RCU_STALL_COMMON) && defined(CONFIG_RCU_CPU_STALL_NOTIFIER)
 
 #endif /* __LINUX_RCU_H */
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 30fc9d34e329..07a6a183c555 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2450,10 +2450,12 @@ static int rcu_torture_stall(void *args)
 	unsigned long stop_at;
 
 	VERBOSE_TOROUT_STRING("rcu_torture_stall task started");
-	ret = rcu_stall_chain_notifier_register(&rcu_torture_stall_block);
-	if (ret)
-		pr_info("%s: rcu_stall_chain_notifier_register() returned %d, %sexpected.\n",
-			__func__, ret, !IS_ENABLED(CONFIG_RCU_STALL_COMMON) ? "un" : "");
+	if (rcu_cpu_stall_notifiers) {
+		ret = rcu_stall_chain_notifier_register(&rcu_torture_stall_block);
+		if (ret)
+			pr_info("%s: rcu_stall_chain_notifier_register() returned %d, %sexpected.\n",
+				__func__, ret, !IS_ENABLED(CONFIG_RCU_STALL_COMMON) ? "un" : "");
+	}
 	if (stall_cpu_holdoff > 0) {
 		VERBOSE_TOROUT_STRING("rcu_torture_stall begin holdoff");
 		schedule_timeout_interruptible(stall_cpu_holdoff * HZ);
@@ -2497,7 +2499,7 @@ static int rcu_torture_stall(void *args)
 		cur_ops->readunlock(idx);
 	}
 	pr_alert("%s end.\n", __func__);
-	if (!ret) {
+	if (rcu_cpu_stall_notifiers && !ret) {
 		ret = rcu_stall_chain_notifier_unregister(&rcu_torture_stall_block);
 		if (ret)
 			pr_info("%s: rcu_stall_chain_notifier_unregister() returned %d.\n", __func__, ret);
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index ac8e86babe44..5d666428546b 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -1061,6 +1061,7 @@ static int __init rcu_sysrq_init(void)
 }
 early_initcall(rcu_sysrq_init);
 
+#ifdef CONFIG_RCU_CPU_STALL_NOTIFIER
 
 //////////////////////////////////////////////////////////////////////////////
 //
@@ -1081,7 +1082,13 @@ static ATOMIC_NOTIFIER_HEAD(rcu_cpu_stall_notifier_list);
  */
 int rcu_stall_chain_notifier_register(struct notifier_block *n)
 {
-	return atomic_notifier_chain_register(&rcu_cpu_stall_notifier_list, n);
+	int rcsn = rcu_cpu_stall_notifiers;
+
+	WARN(1, "Adding %pS() to RCU stall notifier list (%s).\n", n->notifier_call,
+	     rcsn ? "possibly suppressing RCU CPU stall warnings" : "failed, so all is well");
+	if (rcsn)
+		return atomic_notifier_chain_register(&rcu_cpu_stall_notifier_list, n);
+	return -EEXIST;
 }
 EXPORT_SYMBOL_GPL(rcu_stall_chain_notifier_register);
 
@@ -1115,3 +1122,5 @@ int rcu_stall_notifier_call_chain(unsigned long val, void *v)
 {
 	return atomic_notifier_call_chain(&rcu_cpu_stall_notifier_list, val, v);
 }
+
+#endif // #ifdef CONFIG_RCU_CPU_STALL_NOTIFIER
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index c534d6806d3d..46aaaa9fe339 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -538,9 +538,15 @@ long torture_sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 EXPORT_SYMBOL_GPL(torture_sched_setaffinity);
 #endif
 
+int rcu_cpu_stall_notifiers __read_mostly; // !0 = provide stall notifiers (rarely useful)
+EXPORT_SYMBOL_GPL(rcu_cpu_stall_notifiers);
+
 #ifdef CONFIG_RCU_STALL_COMMON
 int rcu_cpu_stall_ftrace_dump __read_mostly;
 module_param(rcu_cpu_stall_ftrace_dump, int, 0644);
+#ifdef CONFIG_RCU_CPU_STALL_NOTIFIER
+module_param(rcu_cpu_stall_notifiers, int, 0444);
+#endif // #ifdef CONFIG_RCU_CPU_STALL_NOTIFIER
 int rcu_cpu_stall_suppress __read_mostly; // !0 = suppress stall warnings.
 EXPORT_SYMBOL_GPL(rcu_cpu_stall_suppress);
 module_param(rcu_cpu_stall_suppress, int, 0644);
-- 
2.40.1

