Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD9379955C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 03:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346161AbjIIBOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 21:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346176AbjIIBOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 21:14:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1873D1FFF;
        Fri,  8 Sep 2023 18:13:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C67DC433CD;
        Sat,  9 Sep 2023 01:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694221982;
        bh=Hw9YG2owkMQ0RPUJCIdGQaSnw8/tR0YSX4/eQkukG08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CMv8PBcTPGsrGpG2RtgHqWOM7WOip0mWQRAeIPvsmuCbTkN4/IS/M6bB3dQwNmsLG
         fI3h5fbSiu3wkugULB5q3ZoDOa4FnywW56BjsWPlzKb96qAHUk7eULtHWvhBfYp0YN
         j9/TNC4WYzLg6XoReC3fubeBtC5KePBDNmh+Q1WoPLDqwhWU4E7ifyenrYE2saeDAA
         AME8OPLXInj1g70cVUsKEGPeIhhwXJ/Lbm1VxfcobAVxdZuA8avhomxq4uz0AuGcZ2
         CVRawtuVyUtuQwued3RqkLdO4t3QGS3evB3lOuEQn+jRh6eQx4v6ELa3yo6powx9OO
         KXaDZ9HjdHsZA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.5 5/6] printk: Rename abandon_console_lock_in_panic() to other_cpu_in_panic()
Date:   Fri,  8 Sep 2023 21:12:53 -0400
Message-Id: <20230909011254.3581788-5-sashal@kernel.org>
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

[ Upstream commit 132a90d1527fedba2d95085c951ccf00dbbebe41 ]

Currently abandon_console_lock_in_panic() is only used to determine if
the current CPU should immediately release the console lock because
another CPU is in panic. However, later this function will be used by
the CPU to immediately release other resources in this situation.

Rename the function to other_cpu_in_panic(), which is a better
description and does not assume it is related to the console lock.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20230717194607.145135-8-john.ogness@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/printk/internal.h |  2 ++
 kernel/printk/printk.c   | 15 ++++++++-------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 2a17704136f1d..7d4979d5c3ce6 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -103,3 +103,5 @@ struct printk_message {
 	u64			seq;
 	unsigned long		dropped;
 };
+
+bool other_cpu_in_panic(void);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d5e29fad84234..08a9419046b65 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2590,11 +2590,12 @@ static int console_cpu_notify(unsigned int cpu)
 }
 
 /*
- * Return true when this CPU should unlock console_sem without pushing all
- * messages to the console. This reduces the chance that the console is
- * locked when the panic CPU tries to use it.
+ * Return true if a panic is in progress on a remote CPU.
+ *
+ * On true, the local CPU should immediately release any printing resources
+ * that may be needed by the panic CPU.
  */
-static bool abandon_console_lock_in_panic(void)
+bool other_cpu_in_panic(void)
 {
 	if (!panic_in_progress())
 		return false;
@@ -2621,7 +2622,7 @@ void console_lock(void)
 	might_sleep();
 
 	/* On panic, the console_lock must be left to the panic cpu. */
-	while (abandon_console_lock_in_panic())
+	while (other_cpu_in_panic())
 		msleep(1000);
 
 	down_console_sem();
@@ -2643,7 +2644,7 @@ EXPORT_SYMBOL(console_lock);
 int console_trylock(void)
 {
 	/* On panic, the console_lock must be left to the panic cpu. */
-	if (abandon_console_lock_in_panic())
+	if (other_cpu_in_panic())
 		return 0;
 	if (down_trylock_console_sem())
 		return 0;
@@ -2959,7 +2960,7 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 			any_progress = true;
 
 			/* Allow panic_cpu to take over the consoles safely. */
-			if (abandon_console_lock_in_panic())
+			if (other_cpu_in_panic())
 				goto abandon;
 
 			if (do_cond_resched)
-- 
2.40.1

