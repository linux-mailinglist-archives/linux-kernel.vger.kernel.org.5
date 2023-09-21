Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EFD7AA16D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjIUVCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbjIUVB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:01:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E7F7E4D2;
        Thu, 21 Sep 2023 10:36:02 -0700 (PDT)
Date:   Thu, 21 Sep 2023 17:36:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695317761;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GbltNKSEFxaaB7VGzgXS8G1Qsg+F+A8ssGGhxytvu40=;
        b=euLBJ2br2Fvthu232sqmqm1mPOtiSWn0sNE7UWb/dwPtjxyh0WaJlZDE1aBFFSZv7xq6HF
        3VnMr3Y8o4D9uY+P91q4/ZF0TpdxUqft6yYsJ+mAKfTHepVOvdUlzjlFWQbGkDltcu+26j
        5Y8e5NMo3u8g/by7LZbB9pLjJxkpl5bzEfDiXHj4xf284vevkyy593n2JE0j/tnT9dqJ4z
        eLHF+NoXWWxI86VAmZwJKXIazWB+2grXOY72L6DudRRtgGru7Xo9wWUoRRGZf30GLPK+tw
        6A5kETH/gUCU8LhZLrtrjhASPVgOlUrEywoefnbXxdD6nhsSVqfJ5njk+GTXDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695317761;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GbltNKSEFxaaB7VGzgXS8G1Qsg+F+A8ssGGhxytvu40=;
        b=pVkaMbw7bgjDTXAfUJEwo4dvSAhHys2QAc0UDEvCM+Nre2zXdebOA49vXsVB6D/AmjUpxH
        KB7JqlCKOX9xkpBg==
From:   "tip-bot2 for peterz@infradead.org" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Add flags2 argument to futex_requeue()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230921105248.396780136@noisy.programming.kicks-ass.net>
References: <20230921105248.396780136@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <169531776042.27769.15557593072618205773.tip-bot2@tip-bot2>
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

Commit-ID:     27b88f3519e72d71c8cead6b835a26c171109c9b
Gitweb:        https://git.kernel.org/tip/27b88f3519e72d71c8cead6b835a26c171109c9b
Author:        peterz@infradead.org <peterz@infradead.org>
AuthorDate:    Thu, 21 Sep 2023 12:45:14 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Sep 2023 19:22:09 +02:00

futex: Add flags2 argument to futex_requeue()

In order to support mixed size requeue, add a second flags argument to
the internal futex_requeue() function.

No functional change intended.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230921105248.396780136@noisy.programming.kicks-ass.net
---
 kernel/futex/futex.h    |  5 +++--
 kernel/futex/requeue.c  | 12 +++++++-----
 kernel/futex/syscalls.c |  6 +++---
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index a8ea5ef..a06030a 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -328,8 +328,9 @@ extern int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags, u32
 				 val, ktime_t *abs_time, u32 bitset, u32 __user
 				 *uaddr2);
 
-extern int futex_requeue(u32 __user *uaddr1, unsigned int flags,
-			 u32 __user *uaddr2, int nr_wake, int nr_requeue,
+extern int futex_requeue(u32 __user *uaddr1, unsigned int flags1,
+			 u32 __user *uaddr2, unsigned int flags2,
+			 int nr_wake, int nr_requeue,
 			 u32 *cmpval, int requeue_pi);
 
 extern int __futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index 5bf6958..a0a7995 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -346,8 +346,9 @@ futex_proxy_trylock_atomic(u32 __user *pifutex, struct futex_hash_bucket *hb1,
 /**
  * futex_requeue() - Requeue waiters from uaddr1 to uaddr2
  * @uaddr1:	source futex user address
- * @flags:	futex flags (FLAGS_SHARED, etc.)
+ * @flags1:	futex flags (FLAGS_SHARED, etc.)
  * @uaddr2:	target futex user address
+ * @flags2:	futex flags (FLAGS_SHARED, etc.)
  * @nr_wake:	number of waiters to wake (must be 1 for requeue_pi)
  * @nr_requeue:	number of waiters to requeue (0-INT_MAX)
  * @cmpval:	@uaddr1 expected value (or %NULL)
@@ -361,7 +362,8 @@ futex_proxy_trylock_atomic(u32 __user *pifutex, struct futex_hash_bucket *hb1,
  *  - >=0 - on success, the number of tasks requeued or woken;
  *  -  <0 - on error
  */
-int futex_requeue(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
+int futex_requeue(u32 __user *uaddr1, unsigned int flags1,
+		  u32 __user *uaddr2, unsigned int flags2,
 		  int nr_wake, int nr_requeue, u32 *cmpval, int requeue_pi)
 {
 	union futex_key key1 = FUTEX_KEY_INIT, key2 = FUTEX_KEY_INIT;
@@ -424,10 +426,10 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 	}
 
 retry:
-	ret = get_futex_key(uaddr1, flags, &key1, FUTEX_READ);
+	ret = get_futex_key(uaddr1, flags1, &key1, FUTEX_READ);
 	if (unlikely(ret != 0))
 		return ret;
-	ret = get_futex_key(uaddr2, flags, &key2,
+	ret = get_futex_key(uaddr2, flags2, &key2,
 			    requeue_pi ? FUTEX_WRITE : FUTEX_READ);
 	if (unlikely(ret != 0))
 		return ret;
@@ -459,7 +461,7 @@ retry_private:
 			if (ret)
 				return ret;
 
-			if (!(flags & FLAGS_SHARED))
+			if (!(flags1 & FLAGS_SHARED))
 				goto retry_private;
 
 			goto retry;
diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index e4c8ec7..dde9b74 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -106,9 +106,9 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	case FUTEX_WAKE_BITSET:
 		return futex_wake(uaddr, flags, val, val3);
 	case FUTEX_REQUEUE:
-		return futex_requeue(uaddr, flags, uaddr2, val, val2, NULL, 0);
+		return futex_requeue(uaddr, flags, uaddr2, flags, val, val2, NULL, 0);
 	case FUTEX_CMP_REQUEUE:
-		return futex_requeue(uaddr, flags, uaddr2, val, val2, &val3, 0);
+		return futex_requeue(uaddr, flags, uaddr2, flags, val, val2, &val3, 0);
 	case FUTEX_WAKE_OP:
 		return futex_wake_op(uaddr, flags, uaddr2, val, val2, val3);
 	case FUTEX_LOCK_PI:
@@ -125,7 +125,7 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 		return futex_wait_requeue_pi(uaddr, flags, val, timeout, val3,
 					     uaddr2);
 	case FUTEX_CMP_REQUEUE_PI:
-		return futex_requeue(uaddr, flags, uaddr2, val, val2, &val3, 1);
+		return futex_requeue(uaddr, flags, uaddr2, flags, val, val2, &val3, 1);
 	}
 	return -ENOSYS;
 }
