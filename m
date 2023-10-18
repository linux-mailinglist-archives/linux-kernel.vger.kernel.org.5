Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F817CE81B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjJRTtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjJRTsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:48:54 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF71129;
        Wed, 18 Oct 2023 12:48:51 -0700 (PDT)
Received: from smtp.gmail.com (1.general.jsalisbury.us.vpn [10.172.66.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A72573F185;
        Wed, 18 Oct 2023 19:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697658526;
        bh=y3puGuxr9d+D67/apJbhs8shSXYt9V9lGXA+J0Jh0ME=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Y4b5hIqsFBvdghOJ8xpWLLwiFuDW8QKe3O28eUBhm9QPaxzyvu25550BYknQD2+0H
         CseV6wfIqzrPgC7amckq4GCaxymUgnyqI8/2m8WanXwv+XR1tfV/nfN7KJlJ1SfEBm
         qmWwFOq5JPoHm82+7N333FojCQxW8j2SFtEEU1Br5udFC/W6LAasEX58Rfmjcp/IJG
         0Z/7bdX5vxFClzZ7D0PmpN6WcP8yTlMQfMTDwmHhQ6Z48sZ/FRqgteAx4l6xOTU5ih
         udffNpNcgqE18qfXW34I2gedR328nj/3Tvc1MB+gF0l1X4aMqJYgfJdi35bT6l6l5S
         7ogCX0X5trySg==
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>,
        Joseph Salisbury <joseph.salisbury@canonical.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH RT 05/12] debugobjects,locking: Annotate debug_object_fill_pool() wait type violation
Date:   Wed, 18 Oct 2023 15:48:26 -0400
Message-Id: <20231018194833.651674-6-joseph.salisbury@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018194833.651674-1-joseph.salisbury@canonical.com>
References: <20231018194833.651674-1-joseph.salisbury@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

v5.15.133-rt70-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


There is an explicit wait-type violation in debug_object_fill_pool()
for PREEMPT_RT=n kernels which allows them to more easily fill the
object pool and reduce the chance of allocation failures.

Lockdep's wait-type checks are designed to check the PREEMPT_RT
locking rules even for PREEMPT_RT=n kernels and object to this, so
create a lockdep annotation to allow this to stand.

Specifically, create a 'lock' type that overrides the inner wait-type
while it is held -- allowing one to temporarily raise it, such that
the violation is hidden.

Reported-by: Vlastimil Babka <vbabka@suse.cz>
Reported-by: Qi Zheng <zhengqi.arch@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Qi Zheng <zhengqi.arch@bytedance.com>
Link: https://lkml.kernel.org/r/20230429100614.GA1489784@hirez.programming.kicks-ass.net
(cherry picked from commit 0cce06ba859a515bd06224085d3addb870608b6d)
Signed-off-by: Joseph Salisbury <joseph.salisbury@canonical.com>
---
 include/linux/lockdep.h       | 14 ++++++++++++++
 include/linux/lockdep_types.h |  1 +
 kernel/locking/lockdep.c      | 28 +++++++++++++++++++++-------
 lib/debugobjects.c            | 15 +++++++++++++--
 4 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index aa0ecfc6cdb4..d28669208e00 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -340,6 +340,16 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
 #define lockdep_repin_lock(l,c)	lock_repin_lock(&(l)->dep_map, (c))
 #define lockdep_unpin_lock(l,c)	lock_unpin_lock(&(l)->dep_map, (c))
 
+/*
+ * Must use lock_map_aquire_try() with override maps to avoid
+ * lockdep thinking they participate in the block chain.
+ */
+#define DEFINE_WAIT_OVERRIDE_MAP(_name, _wait_type)	\
+	struct lockdep_map _name = {			\
+		.name = #_name "-wait-type-override",	\
+		.wait_type_inner = _wait_type,		\
+		.lock_type = LD_LOCK_WAIT_OVERRIDE, }
+
 #else /* !CONFIG_LOCKDEP */
 
 static inline void lockdep_init_task(struct task_struct *task)
@@ -427,6 +437,9 @@ extern int lockdep_is_held(const void *);
 #define lockdep_repin_lock(l, c)		do { (void)(l); (void)(c); } while (0)
 #define lockdep_unpin_lock(l, c)		do { (void)(l); (void)(c); } while (0)
 
+#define DEFINE_WAIT_OVERRIDE_MAP(_name, _wait_type)	\
+	struct lockdep_map __maybe_unused _name = {}
+
 #endif /* !LOCKDEP */
 
 enum xhlock_context_t {
@@ -569,6 +582,7 @@ do {									\
 #define rwsem_release(l, i)			lock_release(l, i)
 
 #define lock_map_acquire(l)			lock_acquire_exclusive(l, 0, 0, NULL, _THIS_IP_)
+#define lock_map_acquire_try(l)			lock_acquire_exclusive(l, 0, 1, NULL, _THIS_IP_)
 #define lock_map_acquire_read(l)		lock_acquire_shared_recursive(l, 0, 0, NULL, _THIS_IP_)
 #define lock_map_acquire_tryread(l)		lock_acquire_shared_recursive(l, 0, 1, NULL, _THIS_IP_)
 #define lock_map_release(l)			lock_release(l, _THIS_IP_)
diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index 3e726ace5c62..a5f1519489df 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -33,6 +33,7 @@ enum lockdep_wait_type {
 enum lockdep_lock_type {
 	LD_LOCK_NORMAL = 0,	/* normal, catch all */
 	LD_LOCK_PERCPU,		/* percpu */
+	LD_LOCK_WAIT_OVERRIDE,	/* annotation */
 	LD_LOCK_MAX,
 };
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index ce3c8a4a5506..a3de5f06a2de 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2208,6 +2208,9 @@ static inline bool usage_match(struct lock_list *entry, void *mask)
 
 static inline bool usage_skip(struct lock_list *entry, void *mask)
 {
+	if (entry->class->lock_type == LD_LOCK_NORMAL)
+		return false;
+
 	/*
 	 * Skip local_lock() for irq inversion detection.
 	 *
@@ -2234,14 +2237,16 @@ static inline bool usage_skip(struct lock_list *entry, void *mask)
 	 * As a result, we will skip local_lock(), when we search for irq
 	 * inversion bugs.
 	 */
-	if (entry->class->lock_type == LD_LOCK_PERCPU) {
-		if (DEBUG_LOCKS_WARN_ON(entry->class->wait_type_inner < LD_WAIT_CONFIG))
-			return false;
+	if (entry->class->lock_type == LD_LOCK_PERCPU &&
+	    DEBUG_LOCKS_WARN_ON(entry->class->wait_type_inner < LD_WAIT_CONFIG))
+		return false;
 
-		return true;
-	}
+	/*
+	 * Skip WAIT_OVERRIDE for irq inversion detection -- it's not actually
+	 * a lock and only used to override the wait_type.
+	 */
 
-	return false;
+	return true;
 }
 
 /*
@@ -4707,7 +4712,8 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
 
 	for (; depth < curr->lockdep_depth; depth++) {
 		struct held_lock *prev = curr->held_locks + depth;
-		u8 prev_inner = hlock_class(prev)->wait_type_inner;
+		struct lock_class *class = hlock_class(prev);
+		u8 prev_inner = class->wait_type_inner;
 
 		if (prev_inner) {
 			/*
@@ -4717,6 +4723,14 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
 			 * Also due to trylocks.
 			 */
 			curr_inner = min(curr_inner, prev_inner);
+
+			/*
+			 * Allow override for annotations -- this is typically
+			 * only valid/needed for code that only exists when
+			 * CONFIG_PREEMPT_RT=n.
+			 */
+			if (unlikely(class->lock_type == LD_LOCK_WAIT_OVERRIDE))
+				curr_inner = prev_inner;
 		}
 	}
 
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 4c39678c03ee..e6b0cabdcb2c 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -594,10 +594,21 @@ static void debug_objects_fill_pool(void)
 {
 	/*
 	 * On RT enabled kernels the pool refill must happen in preemptible
-	 * context:
+	 * context -- for !RT kernels we rely on the fact that spinlock_t and
+	 * raw_spinlock_t are basically the same type and this lock-type
+	 * inversion works just fine.
 	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
+		/*
+		 * Annotate away the spinlock_t inside raw_spinlock_t warning
+		 * by temporarily raising the wait-type to WAIT_SLEEP, matching
+		 * the preemptible() condition above.
+		 */
+		static DEFINE_WAIT_OVERRIDE_MAP(fill_pool_map, LD_WAIT_SLEEP);
+		lock_map_acquire_try(&fill_pool_map);
 		fill_pool();
+		lock_map_release(&fill_pool_map);
+	}
 }
 
 static void
-- 
2.34.1

