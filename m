Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96157A6F2D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 01:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjISXJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 19:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbjISXJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 19:09:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E4CC9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 16:09:11 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695164948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zprfWcxtWmGsW80DlqzMcGe9h+c0hqNmqd+wr5GO9aw=;
        b=NqrWEArTVkOy9DG7b5frQSYQblAKGvpp22x32+WwFYR9zB6qW/0fsQSr7IV39IfV37Da7q
        Q+hj7kJKWiQnEpNbIZbY5vEwLvjA/N/ELDLTHQNpTLDoRkoGgE7HBGX1u+cvrTsbASjCJw
        yIhIM5NDscnXHQNRStawJyeFrYHLO6bT+WgpyE10s1QsoIslZhViDxVOWo/wApqHgnr9rb
        A72Alx8CHXUD3IR9/KZaidJ0Rwmdmv18/i4JOu52dYZ8ZbW90yp4EaVK+p5/VRqHRdTYJ+
        EGyTfSRGNH9BMpOuvHbq3b/GT+568tcM1kHqWz5ivbxYiGbKCk9MpV6Ey1aJdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695164948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zprfWcxtWmGsW80DlqzMcGe9h+c0hqNmqd+wr5GO9aw=;
        b=rVZGFDSbIEtHTnitVDxJl51V5moAMlVq4GL6Rmxzwt9+Kz/f6jDOnmo/CBN8p5GEZunxnH
        7Y73EIQfaJ1N5cBg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 03/11] printk: Add @flags argument for console_is_usable()
Date:   Wed, 20 Sep 2023 01:14:48 +0206
Message-Id: <20230919230856.661435-4-john.ogness@linutronix.de>
In-Reply-To: <20230919230856.661435-1-john.ogness@linutronix.de>
References: <20230919230856.661435-1-john.ogness@linutronix.de>
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

The caller of console_is_usable() usually needs @console->flags
for its own checks. Rather than having console_is_usable() read
its own copy, make the caller pass in the @flags. This also
ensures that the caller saw the same @flags value.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/internal.h | 8 ++------
 kernel/printk/printk.c   | 5 +++--
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 69c8861be92c..6780911fa8f2 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -83,13 +83,9 @@ void nbcon_free(struct console *con);
  * records. Note that this function does not consider the current context,
  * which can also play a role in deciding if @con can be used to print
  * records.
- *
- * Requires the console_srcu_read_lock.
  */
-static inline bool console_is_usable(struct console *con)
+static inline bool console_is_usable(struct console *con, short flags)
 {
-	short flags = console_srcu_read_flags(con);
-
 	if (!(flags & CON_ENABLED))
 		return false;
 
@@ -136,7 +132,7 @@ static inline bool nbcon_alloc(struct console *con) { return false; }
 static inline void nbcon_init(struct console *con) { }
 static inline void nbcon_free(struct console *con) { }
 
-static inline bool console_is_usable(struct console *con) { return false; }
+static inline bool console_is_usable(struct console *con, short flags) { return false; }
 
 #endif /* CONFIG_PRINTK */
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b6cfae75a574..6ef33cefa4d0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2929,9 +2929,10 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 
 		cookie = console_srcu_read_lock();
 		for_each_console_srcu(con) {
+			short flags = console_srcu_read_flags(con);
 			bool progress;
 
-			if (!console_is_usable(con))
+			if (!console_is_usable(con, flags))
 				continue;
 			any_usable = true;
 
@@ -3754,7 +3755,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			 * that they make forward progress, so only increment
 			 * @diff for usable consoles.
 			 */
-			if (!console_is_usable(c))
+			if (!console_is_usable(c, flags))
 				continue;
 
 			if (flags & CON_NBCON) {
-- 
2.39.2

