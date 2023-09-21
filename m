Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1102E7A9B75
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjIUTBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjIUTBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:01:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D297E4D9;
        Thu, 21 Sep 2023 10:36:03 -0700 (PDT)
Date:   Thu, 21 Sep 2023 17:36:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695317761;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3XRfkGiSd1IkNkmWQtBjb47qPW4JP4rD89hnWo2C6uw=;
        b=T2cEyQkAt2DSbxI7+TQrDQaIC0NuB3hEpUpsKv8xWsxo4vbBYyAUCkK6j3qTxGGK7JDebH
        ZUPB4nV+AQK1OxfVXksw9d8qBDYX0r4pMHJ2NjwgSmUWErlifP7bviw+d3GYr8iQWLYf5E
        wpdaQm6wn+CnPQn4tKNPgjcjgHpx4AngyE9fA4oVZTM4EBtajzwAl08PAdLrqRH4TmSjn5
        GHuijXB9KkSTUhgD0SGOCZz6tZ4qGWyCQL9qucVjAqWelPj2ArhC36RW6SJxGvY84F/HWp
        hN8OUBqlTx6tk7w/3+tqVbU6dGaiYh3C5gUSjYpY1R0z+DSkd4FvxkWAsy2+uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695317761;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3XRfkGiSd1IkNkmWQtBjb47qPW4JP4rD89hnWo2C6uw=;
        b=wo+VX+h/7RE9uKqmxNx5z+q+SzIBIv4hIgenh1okqwynOr51zTda9J2Y6fxQkyewvUeCA4
        P3dihlYLmja7dhBg==
From:   "tip-bot2 for peterz@infradead.org" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Propagate flags into get_futex_key()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230921105248.282857501@noisy.programming.kicks-ass.net>
References: <20230921105248.282857501@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <169531776100.27769.14852378896731331661.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     3b63a55f498b763aba0886b244df613587a73c46
Gitweb:        https://git.kernel.org/tip/3b63a55f498b763aba0886b244df613587a73c46
Author:        peterz@infradead.org <peterz@infradead.org>
AuthorDate:    Thu, 21 Sep 2023 12:45:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Sep 2023 19:22:09 +02:00

futex: Propagate flags into get_futex_key()

Instead of only passing FLAGS_SHARED as a boolean, pass down flags as
a whole.

No functional change intended.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230921105248.282857501@noisy.programming.kicks-ass.net
---
 kernel/futex/core.c     |  7 +++++--
 kernel/futex/futex.h    |  2 +-
 kernel/futex/pi.c       |  4 ++--
 kernel/futex/requeue.c  |  6 +++---
 kernel/futex/waitwake.c | 14 +++++++-------
 5 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index d1d7b3c..ade7c73 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -193,7 +193,7 @@ static u64 get_inode_sequence_number(struct inode *inode)
 /**
  * get_futex_key() - Get parameters which are the keys for a futex
  * @uaddr:	virtual address of the futex
- * @fshared:	false for a PROCESS_PRIVATE futex, true for PROCESS_SHARED
+ * @flags:	FLAGS_*
  * @key:	address where result is stored.
  * @rw:		mapping needs to be read/write (values: FUTEX_READ,
  *              FUTEX_WRITE)
@@ -217,7 +217,7 @@ static u64 get_inode_sequence_number(struct inode *inode)
  *
  * lock_page() might sleep, the caller should not hold a spinlock.
  */
-int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
+int get_futex_key(u32 __user *uaddr, unsigned int flags, union futex_key *key,
 		  enum futex_access rw)
 {
 	unsigned long address = (unsigned long)uaddr;
@@ -226,6 +226,9 @@ int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
 	struct folio *folio;
 	struct address_space *mapping;
 	int err, ro = 0;
+	bool fshared;
+
+	fshared = flags & FLAGS_SHARED;
 
 	/*
 	 * The futex address must be "naturally" aligned.
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index e74888a..a8ea5ef 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -184,7 +184,7 @@ enum futex_access {
 	FUTEX_WRITE
 };
 
-extern int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
+extern int get_futex_key(u32 __user *uaddr, unsigned int flags, union futex_key *key,
 			 enum futex_access rw);
 
 extern struct hrtimer_sleeper *
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index d636a1b..90e5197 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -933,7 +933,7 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int tryl
 	to = futex_setup_timer(time, &timeout, flags, 0);
 
 retry:
-	ret = get_futex_key(uaddr, flags & FLAGS_SHARED, &q.key, FUTEX_WRITE);
+	ret = get_futex_key(uaddr, flags, &q.key, FUTEX_WRITE);
 	if (unlikely(ret != 0))
 		goto out;
 
@@ -1129,7 +1129,7 @@ retry:
 	if ((uval & FUTEX_TID_MASK) != vpid)
 		return -EPERM;
 
-	ret = get_futex_key(uaddr, flags & FLAGS_SHARED, &key, FUTEX_WRITE);
+	ret = get_futex_key(uaddr, flags, &key, FUTEX_WRITE);
 	if (ret)
 		return ret;
 
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index 4c73e0b..5bf6958 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -424,10 +424,10 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 	}
 
 retry:
-	ret = get_futex_key(uaddr1, flags & FLAGS_SHARED, &key1, FUTEX_READ);
+	ret = get_futex_key(uaddr1, flags, &key1, FUTEX_READ);
 	if (unlikely(ret != 0))
 		return ret;
-	ret = get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2,
+	ret = get_futex_key(uaddr2, flags, &key2,
 			    requeue_pi ? FUTEX_WRITE : FUTEX_READ);
 	if (unlikely(ret != 0))
 		return ret;
@@ -789,7 +789,7 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	 */
 	rt_mutex_init_waiter(&rt_waiter);
 
-	ret = get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2, FUTEX_WRITE);
+	ret = get_futex_key(uaddr2, flags, &key2, FUTEX_WRITE);
 	if (unlikely(ret != 0))
 		goto out;
 
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index b109a08..37860f7 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -145,13 +145,13 @@ int futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
 	struct futex_hash_bucket *hb;
 	struct futex_q *this, *next;
 	union futex_key key = FUTEX_KEY_INIT;
-	int ret;
 	DEFINE_WAKE_Q(wake_q);
+	int ret;
 
 	if (!bitset)
 		return -EINVAL;
 
-	ret = get_futex_key(uaddr, flags & FLAGS_SHARED, &key, FUTEX_READ);
+	ret = get_futex_key(uaddr, flags, &key, FUTEX_READ);
 	if (unlikely(ret != 0))
 		return ret;
 
@@ -248,10 +248,10 @@ int futex_wake_op(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 	DEFINE_WAKE_Q(wake_q);
 
 retry:
-	ret = get_futex_key(uaddr1, flags & FLAGS_SHARED, &key1, FUTEX_READ);
+	ret = get_futex_key(uaddr1, flags, &key1, FUTEX_READ);
 	if (unlikely(ret != 0))
 		return ret;
-	ret = get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2, FUTEX_WRITE);
+	ret = get_futex_key(uaddr2, flags, &key2, FUTEX_WRITE);
 	if (unlikely(ret != 0))
 		return ret;
 
@@ -426,7 +426,7 @@ retry:
 			continue;
 
 		ret = get_futex_key(u64_to_user_ptr(vs[i].w.uaddr),
-				    vs[i].w.flags & FLAGS_SHARED,
+				    vs[i].w.flags,
 				    &vs[i].q.key, FUTEX_READ);
 
 		if (unlikely(ret))
@@ -438,7 +438,7 @@ retry:
 	for (i = 0; i < count; i++) {
 		u32 __user *uaddr = (u32 __user *)(unsigned long)vs[i].w.uaddr;
 		struct futex_q *q = &vs[i].q;
-		u32 val = (u32)vs[i].w.val;
+		u32 val = vs[i].w.val;
 
 		hb = futex_q_lock(q);
 		ret = futex_get_value_locked(&uval, uaddr);
@@ -602,7 +602,7 @@ int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
 	 * while the syscall executes.
 	 */
 retry:
-	ret = get_futex_key(uaddr, flags & FLAGS_SHARED, &q->key, FUTEX_READ);
+	ret = get_futex_key(uaddr, flags, &q->key, FUTEX_READ);
 	if (unlikely(ret != 0))
 		return ret;
 
