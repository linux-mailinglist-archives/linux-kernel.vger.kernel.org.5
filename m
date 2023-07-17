Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15A0756D96
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjGQTqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjGQTqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:46:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE77AE1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:46:12 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689623171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zYxFjiA5pT8Tkss7714CbjosntLQofqU6FDmiXsRwno=;
        b=0xy5YEY6VPn1KLxnkTdaH/N1s3U6Bl72pu1O0gQy4nRdXWeCjfe7tILkdgjSaV4xuAXtPq
        lCXOltDUHlcOHseEAgazu+wyf+pEa2XuhVCBsLhmdR7rRFu9CBl6ZfUrsNTW8ejH85YRYG
        GFU3Aw5FziDzXQWaaeQnh4VTF2+t0v5sf77hGnT7AMGpSyjijXkduSVSWo4BeNlrEMLK4I
        Ea0A/X3IT4tQELmC713lbqKF4GsE2utYXNl/TodCmVJ4YDgkWgQRM4KEJyF2msDvbaTD6x
        RQE1QFUbBhRW+dR9q7T2eYQjq0Si7AwfIFyVFduQAp6xddPPa8YAnRPhnF9WcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689623171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zYxFjiA5pT8Tkss7714CbjosntLQofqU6FDmiXsRwno=;
        b=DCfWTAXznE0ikZwXq/ZGI4xmUX0eVHFT5XTWjEEYS5cSLq26RhTLico0oqUvbDcbCxkwU9
        pPMzVCGQ23youGCA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 4/7] printk: Do not take console lock for console_flush_on_panic()
Date:   Mon, 17 Jul 2023 21:52:04 +0206
Message-Id: <20230717194607.145135-5-john.ogness@linutronix.de>
In-Reply-To: <20230717194607.145135-1-john.ogness@linutronix.de>
References: <20230717194607.145135-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently console_flush_on_panic() will attempt to acquire the
console lock when flushing the buffer on panic. If it fails to
acquire the lock, it continues anyway because this is the last
chance to get any pending records printed.

The reason why the console lock was attempted at all was to
prevent any other CPUs from acquiring the console lock for
printing while the panic CPU was printing. But as of the
previous commit, non-panic CPUs will no longer attempt to
acquire the console lock in a panic situation. Therefore it is
no longer strictly necessary for a panic CPU to acquire the
console lock.

Avoiding taking the console lock when flushing in panic has
the additional benefit of avoiding possible deadlocks due to
semaphore usage in NMI context (semaphores are not NMI-safe)
and avoiding possible deadlocks if another CPU accesses the
semaphore and is stopped while holding one of the semaphore's
internal spinlocks.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 7219991885e6..51445e8ea730 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3118,14 +3118,24 @@ void console_unblank(void)
  */
 void console_flush_on_panic(enum con_flush_mode mode)
 {
+	bool handover;
+	u64 next_seq;
+
 	/*
-	 * If someone else is holding the console lock, trylock will fail
-	 * and may_schedule may be set.  Ignore and proceed to unlock so
-	 * that messages are flushed out.  As this can be called from any
-	 * context and we don't want to get preempted while flushing,
-	 * ensure may_schedule is cleared.
+	 * Ignore the console lock and flush out the messages. Attempting a
+	 * trylock would not be useful because:
+	 *
+	 *   - if it is contended, it must be ignored anyway
+	 *   - console_lock() and console_trylock() block and fail
+	 *     respectively in panic for non-panic CPUs
+	 *   - semaphores are not NMI-safe
+	 */
+
+	/*
+	 * If another context is holding the console lock,
+	 * @console_may_schedule might be set. Clear it so that
+	 * this context does not call cond_resched() while flushing.
 	 */
-	console_trylock();
 	console_may_schedule = 0;
 
 	if (mode == CONSOLE_REPLAY_ALL) {
@@ -3138,15 +3148,15 @@ void console_flush_on_panic(enum con_flush_mode mode)
 		cookie = console_srcu_read_lock();
 		for_each_console_srcu(c) {
 			/*
-			 * If the above console_trylock() failed, this is an
-			 * unsynchronized assignment. But in that case, the
+			 * This is an unsynchronized assignment, but the
 			 * kernel is in "hope and pray" mode anyway.
 			 */
 			c->seq = seq;
 		}
 		console_srcu_read_unlock(cookie);
 	}
-	console_unlock();
+
+	console_flush_all(false, &next_seq, &handover);
 }
 
 /*
-- 
2.30.2

