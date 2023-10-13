Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF327C8E6F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 22:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjJMUn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 16:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjJMUnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 16:43:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A929BF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 13:43:48 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697229827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=57p/+gSPfOoKdSF21ACUMUWvxO7+D7FS68Md7CNw7GE=;
        b=0xRJBwAVH/UTiYtp6zcbdVc+c0Ujn60Jf4rk/D5a8G9mOgHOZAlf9xbncVwPRgT3whA8UG
        usAZZVImCxA+5LUkUX0pJbTfFkF1Yyr+0nmjnyGfkoUytdC8YI9aWYIgqGLDhCKKBFyxX9
        CcRrjmMV8iv5MYOaJNPKVsKKxKn+VCqJlQbjgaTwgonRP8+hD5HZmDhxl2DgY/BOIVl/om
        S7tGO1eHr5WwQ7uUHQfXpjE+XzYi8PZvYqZRPWmQtNC+sh6+w2D6p2OAEIA37PuOIukljA
        zm/FT01ylYVPgmyNl8aWYntBnyO0qKWK7xYqKINUcfPQG7M4Uje1SdMcTe6How==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697229827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=57p/+gSPfOoKdSF21ACUMUWvxO7+D7FS68Md7CNw7GE=;
        b=sWpIK1b2zhiGcoMSIFK4I5BAQHavPrQ7DURfIvSsasFZVR8eX4g/mmO0MgjRzw/pR7aUyp
        JRrs1TGPK14eyhAg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 4/4] printk: Ignore waiter on panic
Date:   Fri, 13 Oct 2023 22:49:40 +0206
Message-Id: <20231013204340.1112036-5-john.ogness@linutronix.de>
In-Reply-To: <20231013204340.1112036-1-john.ogness@linutronix.de>
References: <20231013204340.1112036-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d51507098ff91 ("printk: disable optimistic spin during
panic") added checks to avoid becoming a console waiter if a
panic is in progress. However, the transition to panic can occur
while there is already a waiter. If the panic occurred in a
context that does not support printing from the printk() caller
context, the waiter CPU may become stopped while still stored as
@console_waiter. Then when console_flush_on_panic() is called,
the panic CPU will see @console_waiter and handover to the
stopped CPU.

Here a simple example:

CPU0                                CPU1
----                                ----
console_lock_spinning_enable()
                                    console_trylock_spinning()
                                      [set as console waiter]
NMI: panic()
panic_other_cpus_shutdown()
                                    [stopped as console waiter]
console_flush_on_panic()
  console_lock_spinning_enable()
    [print 1 record]
  console_lock_spinning_disable_and_check()
    [handover to stopped CPU1]

This results in panic() not flushing the panic messages.

Fix this by ignoring any console waiter if the panic CPU is
printing.

Fixes: dbdda842fe96 ("printk: Add console owner and waiter logic to load balance console writes")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 56d9b4acbbf2..cd6493f12970 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1904,7 +1904,8 @@ static int console_lock_spinning_disable_and_check(int cookie)
 	console_owner = NULL;
 	raw_spin_unlock(&console_owner_lock);
 
-	if (!waiter) {
+	/* Waiters are ignored by the panic CPU. */
+	if (!waiter || this_cpu_in_panic()) {
 		spin_release(&console_owner_dep_map, _THIS_IP_);
 		return 0;
 	}
-- 
2.39.2

