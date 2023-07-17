Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D89756D95
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjGQTqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjGQTqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:46:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830A6132
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:46:12 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689623170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hUG7rmDDTw+xlr6RHyGSOKwcBgloT4DosW3IMTd7BBM=;
        b=Vce1JtuAQVTv1l9cEzg9q2Ye7ZGBCw2tUxBjqQO8CiFQ2iXh+JVQtedPmmFMr42UznzGCX
        JsxKsPvXPq4iZE9b9CHwxQChMI2TmGXlAfnndFIr4htHVULONnWsQV67Jw/Nmca+6NvFpE
        u1G/eWkXTTJZ+W5jex4Z76bIdLcdg2kGocvXdvwNDJIQhmdfJ4ZFH8XpfxPjwlVDBqVeHi
        TvXvU0JGVEXAV+eBS2uOtS9sB2pMF0hb7v3ITgcQe1x+m/KmXKD9p157jzQPPTJWvAsS5D
        fSCTmtTqD8YMuVXzcSZm0jyaC7A7nigcZThCrH5FZDzs6YbZi5D21Dgor8VTOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689623170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hUG7rmDDTw+xlr6RHyGSOKwcBgloT4DosW3IMTd7BBM=;
        b=rSQkVG8qtKI051ietdCwRmm/xszJIswC45WrfVnbv6TkDIHdhVsmyTtEaOh0WluSoKDPCJ
        ohlMLPTrlUhmHKDA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 2/7] printk: Reduce console_unblank() usage in unsafe scenarios
Date:   Mon, 17 Jul 2023 21:52:02 +0206
Message-Id: <20230717194607.145135-3-john.ogness@linutronix.de>
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

A semaphore is not NMI-safe, even when using down_trylock(). Both
down_trylock() and up() are using internal spinlocks and up()
might even call wake_up_process().

In the panic() code path it gets even worse because the internal
spinlocks of the semaphore may have been taken by a CPU that has
been stopped.

To reduce the risk of deadlocks caused by the console semaphore in
the panic path, make the following changes:

- First check if any consoles have implemented the unblank()
  callback. If not, then there is no reason to take the console
  semaphore anyway. (This check is also useful for the non-panic
  path since the locking/unlocking of the console lock can be
  quite expensive due to console printing.)

- If the panic path is in NMI context, bail out without attempting
  to take the console semaphore or calling any unblank() callbacks.
  Bailing out is acceptable because console_unblank() would already
  bail out if the console semaphore is contended. The alternative of
  ignoring the console semaphore and calling the unblank() callbacks
  anyway is a bad idea because these callbacks are also not NMI-safe.

If consoles with unblank() callbacks exist and console_unblank() is
called from a non-NMI panic context, it will still attempt a
down_trylock(). This could still result in a deadlock if one of the
stopped CPUs is holding the semaphore internal spinlock. But this
is a risk that the kernel has been (and continues to be) willing
to take.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 9644f6e5bf15..7aa9dbee12e8 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3043,9 +3043,27 @@ EXPORT_SYMBOL(console_conditional_schedule);
 
 void console_unblank(void)
 {
+	bool found_unblank = false;
 	struct console *c;
 	int cookie;
 
+	/*
+	 * First check if there are any consoles implementing the unblank()
+	 * callback. If not, there is no reason to continue and take the
+	 * console lock, which in particular can be dangerous if
+	 * @oops_in_progress is set.
+	 */
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(c) {
+		if ((console_srcu_read_flags(c) & CON_ENABLED) && c->unblank) {
+			found_unblank = true;
+			break;
+		}
+	}
+	console_srcu_read_unlock(cookie);
+	if (!found_unblank)
+		return;
+
 	/*
 	 * Stop console printing because the unblank() callback may
 	 * assume the console is not within its write() callback.
@@ -3054,6 +3072,16 @@ void console_unblank(void)
 	 * In that case, attempt a trylock as best-effort.
 	 */
 	if (oops_in_progress) {
+		/* Semaphores are not NMI-safe. */
+		if (in_nmi())
+			return;
+
+		/*
+		 * Attempting to trylock the console lock can deadlock
+		 * if another CPU was stopped while modifying the
+		 * semaphore. "Hope and pray" that this is not the
+		 * current situation.
+		 */
 		if (down_trylock_console_sem() != 0)
 			return;
 	} else
-- 
2.30.2

