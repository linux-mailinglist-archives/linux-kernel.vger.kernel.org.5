Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A1377A1F9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 21:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjHLT1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 15:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjHLT1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 15:27:41 -0400
Received: from out-72.mta1.migadu.com (out-72.mta1.migadu.com [95.215.58.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6E4171C
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:27:43 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691868462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uFhnb5Aeyg7ibiHxps+oguX37hlZVERnmE8f4QyTYWo=;
        b=MPXU/W7jn5UrmkZ2doI71eQn2IdC73L/+OlCwe7eRjtlc7VvRGbUoaSTyXVuWo5bpk07s9
        bG3PCR1GJ6GYW9WUXgqU9LzyY7npR1SVwixypDYuA8xKAzeUoFepwvDsfkWBQlkwq3bnvx
        rsHUhfEe6+zBCvno9/iprexYIqKGh+E=
From:   Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bcachefs: six locks: Fix missing barrier on wait->lock_acquired
Date:   Sat, 12 Aug 2023 15:27:20 -0400
Message-Id: <20230812192720.2703874-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,TO_EQ_FM_DIRECT_MX,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Six locks do lock handoff via the wakeup path: the thread doing the
wakeup also takes the lock on behalf of the waiter, which means the
waiter only has to look at its waitlist entry, and doesn't have to touch
the lock cacheline while another thread is using it.

Linus noticed that this needs a real barrier, which this patch fixes.

Also add a comment for the should_sleep_fn() error path.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-bcachefs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/bcachefs/six.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/fs/bcachefs/six.c b/fs/bcachefs/six.c
index 581aee565e..b6ca53c852 100644
--- a/fs/bcachefs/six.c
+++ b/fs/bcachefs/six.c
@@ -223,14 +223,16 @@ static void __six_lock_wakeup(struct six_lock *lock, enum six_lock_type lock_typ
 		if (ret <= 0)
 			goto unlock;
 
-		__list_del(w->list.prev, w->list.next);
 		task = w->task;
+		__list_del(w->list.prev, w->list.next);
 		/*
-		 * Do no writes to @w besides setting lock_acquired - otherwise
-		 * we would need a memory barrier:
+		 * The release barrier here ensures the ordering of the
+		 * __list_del before setting w->lock_acquired; @w is on the
+		 * stack of the thread doing the waiting and will be reused
+		 * after it sees w->lock_acquired with no other locking:
+		 * pairs with smp_load_acquire() in six_lock_slowpath()
 		 */
-		barrier();
-		w->lock_acquired = true;
+		smp_store_release(&w->lock_acquired, true);
 		wake_up_process(task);
 	}
 
@@ -502,17 +504,32 @@ static int six_lock_slowpath(struct six_lock *lock, enum six_lock_type type,
 	while (1) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 
-		if (wait->lock_acquired)
+		/*
+		 * Ensures that writes to the waitlist entry happen after we see
+		 * wait->lock_acquired: pairs with the smp_store_release in
+		 * __six_lock_wakeup
+		 */
+		if (smp_load_acquire(&wait->lock_acquired))
 			break;
 
 		ret = should_sleep_fn ? should_sleep_fn(lock, p) : 0;
 		if (unlikely(ret)) {
+			bool acquired;
+
+			/*
+			 * If should_sleep_fn() returns an error, we are
+			 * required to return that error even if we already
+			 * acquired the lock - should_sleep_fn() might have
+			 * modified external state (e.g. when the deadlock cycle
+			 * detector in bcachefs issued a transaction restart)
+			 */
 			raw_spin_lock(&lock->wait_lock);
-			if (!wait->lock_acquired)
+			acquired = wait->lock_acquired;
+			if (!acquired)
 				list_del(&wait->list);
 			raw_spin_unlock(&lock->wait_lock);
 
-			if (unlikely(wait->lock_acquired))
+			if (unlikely(acquired))
 				do_six_unlock_type(lock, type);
 			break;
 		}
-- 
2.40.1

