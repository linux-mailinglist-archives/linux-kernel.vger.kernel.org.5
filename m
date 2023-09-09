Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B9A799555
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 03:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343716AbjIIBNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 21:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343900AbjIIBNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 21:13:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D342113;
        Fri,  8 Sep 2023 18:13:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6836C433CA;
        Sat,  9 Sep 2023 01:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694221977;
        bh=CzklFaf6l/QP/hUegJSKGvs3+PeuS6TpFbLBB1HrXOE=;
        h=From:To:Cc:Subject:Date:From;
        b=NzkjheXQt4FBNGd33UL+E9ArkebgGjBBxUJ91qjBdvX674rBrrGhMZEAiSnq0ZURZ
         1cyrei5h5ugtMnF0N5ky/qj238sCrIRyddahuiXtS56oZbuUoXnqRcMW7BEoOzBRYM
         LzogXmw3zNgC//aI9Yx2/G6ksYM6bGatEsJBd4Y6z0lWp2kvGMvR/IgJPNhH5sErI0
         /Rcs7NdJzWpd3xmhfa2wf1p+qpPwUP1AiLpshllP+I8/+iZaeIe0H/TzQv5R9OWnSC
         L/4TEndhhEhPh/SN5N0YFfgwmSnrrn5hrAtN7GvZ4XxaCj+DfZjo9OK4LJk6xPpToJ
         pmO6lUqv22JIQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.5 1/6] printk: Reduce console_unblank() usage in unsafe scenarios
Date:   Fri,  8 Sep 2023 21:12:49 -0400
Message-Id: <20230909011254.3581788-1-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
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

From: John Ogness <john.ogness@linutronix.de>

[ Upstream commit 7b23a66db55ed0a55b020e913f0d6f6d52a1ad2c ]

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
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20230717194607.145135-3-john.ogness@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/printk/printk.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 357a4d18f6387..7d3f30eb35862 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3045,9 +3045,27 @@ EXPORT_SYMBOL(console_conditional_schedule);
 
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
@@ -3056,6 +3074,16 @@ void console_unblank(void)
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
2.40.1

