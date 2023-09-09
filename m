Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8E2799585
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 03:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243954AbjIIBW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 21:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjIIBWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 21:22:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8329C19B4;
        Fri,  8 Sep 2023 18:22:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64530C4160E;
        Sat,  9 Sep 2023 01:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694221998;
        bh=YmHKoHw/5Wjf88hKQrmi1bnwBWJekzSHtK/DDtE+C+M=;
        h=From:To:Cc:Subject:Date:From;
        b=U5EGEIFU06K7uDiXBcMeUhoLrUdWXgFMUlG1wKR4Rrzn0MLY+qFmaOm9A5mQ+7kSu
         IiOpJVBIEjG7qQlP4mJKDuk08/cDLjWNhI0lrJDsyrDMMHPd9iiJFfn4J03Mwu3nR9
         /wZ7zcKiG+D25uiAGZre9E2uBhH2WLg4qacz06o3yNFNi1SCzx7z6FvLwXpnxZAIYS
         /VsNlb9ajq5PMQKO38dHvyLYr7KBQlZn8fIPJXGaOJQM99KV3ss31mrE0Tj/R0vhsa
         qmJAATCUx9/kyI1SziqzgcPuDb8j6WVuOVUThjjS/rUwL6PHLyPBXy+mHvQpva9CBC
         FzYLCUGSnpn+Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 1/3] printk: Keep non-panic-CPUs out of console lock
Date:   Fri,  8 Sep 2023 21:13:12 -0400
Message-Id: <20230909011314.3581953-1-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.52
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
index e4f1e7478b521..4b9429f3fd6d8 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2552,6 +2552,25 @@ static int console_cpu_notify(unsigned int cpu)
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
  * console_lock - lock the console system for exclusive use.
  *
@@ -2564,6 +2583,10 @@ void console_lock(void)
 {
 	might_sleep();
 
+	/* On panic, the console_lock must be left to the panic cpu. */
+	while (abandon_console_lock_in_panic())
+		msleep(1000);
+
 	down_console_sem();
 	if (console_suspended)
 		return;
@@ -2582,6 +2605,9 @@ EXPORT_SYMBOL(console_lock);
  */
 int console_trylock(void)
 {
+	/* On panic, the console_lock must be left to the panic cpu. */
+	if (abandon_console_lock_in_panic())
+		return 0;
 	if (down_trylock_console_sem())
 		return 0;
 	if (console_suspended) {
@@ -2600,25 +2626,6 @@ int is_console_locked(void)
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

