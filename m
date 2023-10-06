Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C6E7BB2FA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 10:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjJFIWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 04:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjJFIWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 04:22:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EE3FD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 01:22:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 195D91F45F;
        Fri,  6 Oct 2023 08:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696580549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WSmnkbiXNcms5De0+4SZuPr7BeXTZtGKvtsnAwyE9jk=;
        b=JW4N2tk5qgw7RYAA3OFBrzdMc/f0B1Zxur+qGQpunG1O1bh85cAG0hJmOpJVCW4oQbwqMb
        iOysJjttuKdNby5J39QAeFT0vUdfEjARkQeIa4YthyYFhOU0ZJWSAzhjJU3DLiOrIhr/Xb
        sRPCtjAQp19pS/XqWvAWAfliLvAHA7A=
Received: from alley.nue2.suse.org (pmladek.udp.ovpn1.nue.suse.de [10.163.31.190])
        by relay2.suse.de (Postfix) with ESMTP id BB6512C142;
        Fri,  6 Oct 2023 08:22:28 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Todd Brandt <todd.e.brandt@intel.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 2/2] printk: Reduce pr_flush() pooling time
Date:   Fri,  6 Oct 2023 10:21:51 +0200
Message-Id: <20231006082151.6969-3-pmladek@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231006082151.6969-1-pmladek@suse.com>
References: <20231006082151.6969-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pr_flush() does not guarantee that all messages would really get flushed
to the console. The best it could do is to wait with a given timeout.[*]

The current interval 100ms for checking the progress might seem too
long in some situations. For example, such delays are not appreciated
during suspend and resume especially when the consoles have been flushed
"long" time before the check.

One the other hand, the sleeping wait might be useful in other situations.
Especially, it would allow flushing the messages using printk kthreads
on the same CPU[*].

Use msleep(1) as a compromise.

Also measure the time using jiffies. msleep() does not guarantee
precise wakeup after the given delay. It might be much longer,
especially for times < 20s. See Documentation/timers/timers-howto.rst
for more details.

Note that msecs_to_jiffies() already translates a negative value into
an infinite timeout.

[*] console_unlock() does not guarantee flushing the consoles since
    the commit dbdda842fe96f893 ("printk: Add console owner and waiter
    logic to load balance console writes").

    It would be possible to guarantee it another way. For example,
    the spinning might be enabled only when the console_lock has been
    taken via console_trylock().

    But the load balancing is helpful. And more importantly, the flush
    with a timeout has been added as a preparation step for introducing
    printk kthreads.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 0b3af1529778..c0e13c0e68b2 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3728,7 +3728,8 @@ late_initcall(printk_late_init);
 /* If @con is specified, only wait for that console. Otherwise wait for all. */
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress)
 {
-	int remaining = timeout_ms;
+	unsigned long timeout_jiffies = msecs_to_jiffies(timeout_ms);
+	unsigned long remaining_jiffies = timeout_jiffies;
 	struct console *c;
 	u64 last_diff = 0;
 	u64 printk_seq;
@@ -3745,6 +3746,9 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 	console_unlock();
 
 	for (;;) {
+		unsigned long begin_jiffies;
+		unsigned long slept_jiffies;
+
 		diff = 0;
 
 		/*
@@ -3773,24 +3777,20 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 		console_srcu_read_unlock(cookie);
 
 		if (diff != last_diff && reset_on_progress)
-			remaining = timeout_ms;
+			remaining_jiffies = timeout_jiffies;
 
 		console_unlock();
 
 		/* Note: @diff is 0 if there are no usable consoles. */
-		if (diff == 0 || remaining == 0)
+		if (diff == 0 || remaining_jiffies == 0)
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
+		/* msleep(1) might sleep much longer. Check time by jiffies. */
+		begin_jiffies = jiffies;
+		msleep(1);
+		slept_jiffies = jiffies - begin_jiffies;
+
+		remaining_jiffies -= min(slept_jiffies, remaining_jiffies);
 
 		last_diff = diff;
 	}
-- 
2.35.3

