Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5517B3172
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 13:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbjI2Lck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 07:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjI2Lcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 07:32:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2C294
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 04:32:35 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695987154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UIipO+SgaQkwOUgqbE7dftCadTipucHktt7Dz7VlEvw=;
        b=r0S/zBzCESwXq+yQNhp+72oEodba2w5Q87jwg/Wb+Q4mFjid2uFBD9anORdTgth7gKGg9W
        Qdx0rxID6I+zsRwm/HyNJ6TDE8qLPJRO4vmh9LVj0rRbCEYyCVBgMUz87TOF8wOtTS2m7Q
        m6lJNfzGYwtC2QkZSo6dZRPRKeCCnE4ML8O18KP8PDjPahYbwjTY/3TwC8aV0LCjjVaYer
        koMPc1AdEccb0OXgUywdw54RoxnDOOlr6zszE2ISn2H9ZAwpCP3i3gvBaD+bJrWZp9pWvE
        yzYhvB+3CbKyfxZ/Ih7o3S2JXKPzFFvuVXv//EsqwyQv/FrNuDjJgjJY8VK2HQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695987154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UIipO+SgaQkwOUgqbE7dftCadTipucHktt7Dz7VlEvw=;
        b=0X1loJtvalKL2keyu/6BHQPhV1aCbcE1sPE4dCfaNYEdpEVVkvBTU92IeatfUoTi4gpI9t
        wMjJXO1s65fLNQBA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Todd Brandt <todd.e.brandt@intel.com>
Subject: [PATCH printk] printk: flush consoles before checking progress
Date:   Fri, 29 Sep 2023 13:38:33 +0206
Message-Id: <20230929113233.863824-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9e70a5e109a4 ("printk: Add per-console suspended state")
removed console lock usage during resume and replaced it with
the clearly defined console_list_lock and srcu mechanisms.

However, the console lock usage had an important side-effect
of flushing the consoles. After its removal, consoles were no
longer flushed before checking their progress.

Add the console_lock/console_unlock dance to the beginning
of __pr_flush() to actually flush the consoles before checking
their progress. Also add comments to clarify this additional
usage of the console lock.

Finally, in case pr_flush() needs to poll-wait (for example,
because there has been a handover to another CPU), reduce the
polling interval from 100ms to 1ms. In the bug report it was
mentioned that 100ms is unnecessarily long.

Reported-by: Todd Brandt <todd.e.brandt@intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217955
Fixes: 9e70a5e109a4 ("printk: Add per-console suspended state")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 7e0b4dd02398..cf7841fc6eef 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3740,12 +3740,18 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 
 	seq = prb_next_seq(prb);
 
+	/* Flush the consoles so that records up to @seq are printed. */
+	console_lock();
+	console_unlock();
+
 	for (;;) {
 		diff = 0;
 
 		/*
 		 * Hold the console_lock to guarantee safe access to
-		 * console->seq.
+		 * console->seq. Releasing console_lock flushes more
+		 * records in case @seq is still not printed on all
+		 * usable consoles.
 		 */
 		console_lock();
 
@@ -3775,16 +3781,11 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 		if (diff == 0 || remaining == 0)
 			break;
 
-		if (remaining < 0) {
-			/* no timeout limit */
-			msleep(100);
-		} else if (remaining < 100) {
-			msleep(remaining);
-			remaining = 0;
-		} else {
-			msleep(100);
-			remaining -= 100;
-		}
+		msleep(1);
+
+		/* If @remaining < 0, there is no timeout limit. */
+		if (remaining > 0)
+			remaining--;
 
 		last_diff = diff;
 	}

base-commit: 4952801fc6adb5b50b8ec2bcc5aeef92fcce8730
-- 
2.39.2

