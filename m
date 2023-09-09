Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013D7799558
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 03:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346019AbjIIBOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 21:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345203AbjIIBNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 21:13:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491EC26A3;
        Fri,  8 Sep 2023 18:13:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4C8C433D9;
        Sat,  9 Sep 2023 01:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694221978;
        bh=dZRi5b2kY9+Tg93BCopVpnTyANrGl71wd727KNQe18w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uuYcwvTr5xDijLGNnsXaOFH7kMJ4Fa6OSKiE0PpFz7AJPOmYOYvg7PDX1r3O1gSX/
         /M5gU+tYRB2LcImwl0525pYhStf7kglql75XLQh53Y24pNNwfC4P3FACdfyySo5nMA
         a+y/0gr1eEgnYodPy3NYsQ9e4gPzn973sTCOLXum525ioS0FZzt+11ad6B3IECz0d/
         0CPsb/mA61+fBwlaDwYemWEL+2ngjz2HkJr0RH7LMU12EpNG53wrdnVv9vysZDcD/w
         Nd+HgqyaNExJj2PnY9UuXGahyqLfuzMZ2tbGCHt5xOtctA5mIX+7Y7bM4sQnLr6+5H
         d3ioiacxhUSvA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.5 2/6] printk: Keep non-panic-CPUs out of console lock
Date:   Fri,  8 Sep 2023 21:12:50 -0400
Message-Id: <20230909011254.3581788-2-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909011254.3581788-1-sashal@kernel.org>
References: <20230909011254.3581788-1-sashal@kernel.org>
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

[ Upstream commit 51a1d258e50e03a0216bf42b6af9ff34ec402ac1 ]

When in a panic situation, non-panic CPUs should avoid holding the
console lock so as not to contend with the panic CPU. This is already
implemented with abandon_console_lock_in_panic(), which is checked
after each printed line. However, non-panic CPUs should also avoid
trying to acquire the console lock during a panic.

Modify console_trylock() to fail and console_lock() to block() when
called from a non-panic CPU during a panic.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20230717194607.145135-4-john.ogness@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/printk/printk.c | 45 ++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 7d3f30eb35862..591c11888200d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2585,6 +2585,25 @@ static int console_cpu_notify(unsigned int cpu)
 	return 0;
 }
 
+/*
+ * Return true when this CPU should unlock console_sem without pushing all
+ * messages to the console. This reduces the chance that the console is
+ * locked when the panic CPU tries to use it.
+ */
+static bool abandon_console_lock_in_panic(void)
+{
+	if (!panic_in_progress())
+		return false;
+
+	/*
+	 * We can use raw_smp_processor_id() here because it is impossible for
+	 * the task to be migrated to the panic_cpu, or away from it. If
+	 * panic_cpu has already been set, and we're not currently executing on
+	 * that CPU, then we never will be.
+	 */
+	return atomic_read(&panic_cpu) != raw_smp_processor_id();
+}
+
 /**
  * console_lock - block the console subsystem from printing
  *
@@ -2597,6 +2616,10 @@ void console_lock(void)
 {
 	might_sleep();
 
+	/* On panic, the console_lock must be left to the panic cpu. */
+	while (abandon_console_lock_in_panic())
+		msleep(1000);
+
 	down_console_sem();
 	if (console_suspended)
 		return;
@@ -2615,6 +2638,9 @@ EXPORT_SYMBOL(console_lock);
  */
 int console_trylock(void)
 {
+	/* On panic, the console_lock must be left to the panic cpu. */
+	if (abandon_console_lock_in_panic())
+		return 0;
 	if (down_trylock_console_sem())
 		return 0;
 	if (console_suspended) {
@@ -2633,25 +2659,6 @@ int is_console_locked(void)
 }
 EXPORT_SYMBOL(is_console_locked);
 
-/*
- * Return true when this CPU should unlock console_sem without pushing all
- * messages to the console. This reduces the chance that the console is
- * locked when the panic CPU tries to use it.
- */
-static bool abandon_console_lock_in_panic(void)
-{
-	if (!panic_in_progress())
-		return false;
-
-	/*
-	 * We can use raw_smp_processor_id() here because it is impossible for
-	 * the task to be migrated to the panic_cpu, or away from it. If
-	 * panic_cpu has already been set, and we're not currently executing on
-	 * that CPU, then we never will be.
-	 */
-	return atomic_read(&panic_cpu) != raw_smp_processor_id();
-}
-
 /*
  * Check if the given console is currently capable and allowed to print
  * records.
-- 
2.40.1

