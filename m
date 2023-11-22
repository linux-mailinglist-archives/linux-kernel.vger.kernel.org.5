Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476C37F5509
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344484AbjKVXvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344360AbjKVXv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:51:29 -0500
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CF9D4F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:51:24 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700697082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y3qE5L5il8oDBhTKLnVCOy7OUHgjPevBShUas5ZH1Uk=;
        b=PSpl6a2Zn3bHbuRpI4sK9uJeQj6AFlJEZASfU5Qpttm5GrpJ+f55ILGueeFwrtwhqK5LNP
        DGzHzzi8BQZ64w2qUHAIGtWTvMKY0buy182Q4yhvJQE9lW6iu5dj1znEJcev2Ve3xWbxJ4
        GhMoEm1YIGi13AzGERbtWk0X7yg9qgA=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        peterz@infradead.org
Cc:     boqun.feng@gmail.com, longman@redhat.com, will@kernel.org,
        mingo@redhat.com, Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 2/6] locking/lockdep: lockdep_set_no_check_recursion()
Date:   Wed, 22 Nov 2023 18:51:09 -0500
Message-ID: <20231122235113.180132-3-kent.overstreet@linux.dev>
In-Reply-To: <20231122235113.180132-1-kent.overstreet@linux.dev>
References: <20231122235113.180132-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a method to tell lockdep not to check lock ordering within a
lock class - but to still check lock ordering w.r.t. other lock types.

This is for bcachefs, where for btree node locks we have our own
deadlock avoidance strategy w.r.t. other btree node locks (cycle
detection), but we still want lockdep to check lock ordering w.r.t.
other lock types.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/lockdep.h       |  6 ++++++
 include/linux/lockdep_types.h |  2 +-
 kernel/locking/lockdep.c      | 26 ++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index fc86557d2a21..1bc7eb7cb548 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -700,4 +700,10 @@ lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 }
 #endif
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+void lockdep_set_no_check_recursion(struct lockdep_map *map);
+#else
+static inline void lockdep_set_no_check_recursion(struct lockdep_map *map) {}
+#endif
+
 #endif /* __LINUX_LOCKDEP_H */
diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index 2ebc323d345a..aa6bddac2a64 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -137,7 +137,7 @@ struct lock_class {
 	u8				wait_type_inner;
 	u8				wait_type_outer;
 	u8				lock_type;
-	/* u8				hole; */
+	u8				no_check_recursion;
 
 #ifdef CONFIG_LOCK_STAT
 	unsigned long			contention_point[LOCKSTAT_POINTS];
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 38924d90da85..50a0a1ea960a 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3048,6 +3048,9 @@ check_deadlock(struct task_struct *curr, struct held_lock *next)
 
 		class = hlock_class(prev);
 
+		if (class->no_check_recursion)
+			continue;
+
 		if (class->cmp_fn &&
 		    class->cmp_fn(prev->instance, next->instance) < 0)
 			continue;
@@ -3113,6 +3116,10 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 		return 2;
 	}
 
+	if (hlock_class(prev) == hlock_class(next) &&
+	    hlock_class(prev)->no_check_recursion)
+		return 2;
+
 	if (prev->class_idx == next->class_idx) {
 		struct lock_class *class = hlock_class(prev);
 
@@ -6732,3 +6739,22 @@ void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 	warn_rcu_exit(rcu);
 }
 EXPORT_SYMBOL_GPL(lockdep_rcu_suspicious);
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+void lockdep_set_no_check_recursion(struct lockdep_map *lock)
+{
+	struct lock_class *class = lock->class_cache[0];
+	unsigned long flags;
+
+	raw_local_irq_save(flags);
+	lockdep_recursion_inc();
+
+	if (!class)
+		class = register_lock_class(lock, 0, 0);
+	if (class)
+		class->no_check_recursion = true;
+	lockdep_recursion_finish();
+	raw_local_irq_restore(flags);
+}
+EXPORT_SYMBOL_GPL(lockdep_set_no_check_recursion);
+#endif
-- 
2.42.0

