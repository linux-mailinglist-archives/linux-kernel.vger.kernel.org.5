Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E499A7BB2F8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 10:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjJFIW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 04:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjJFIWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 04:22:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CA8E9
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 01:22:19 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BDF481F45F;
        Fri,  6 Oct 2023 08:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696580537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u6SBGQGzlYESoIH6xOm7vdZvHrnG75JguFK7bNCgoCE=;
        b=KdQ4PKYaOyDahDV/SMQI7xizMeFE7j1Wku2izmCQSu9FjD7VG6TcP3EvnN4oXvtBYxb//s
        FdCA3LXgujZ43Mt/5/Tv4RFlu9DypqY+Sorgq2cc9B8X8O1DEhDz5Cy1I7uQLsHZhTODbw
        xkx9hEfyCzLi3XBNB5ABfjvKx55e4Is=
Received: from alley.nue2.suse.org (pmladek.udp.ovpn1.nue.suse.de [10.163.31.190])
        by relay2.suse.de (Postfix) with ESMTP id 6993D2C142;
        Fri,  6 Oct 2023 08:22:17 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Todd Brandt <todd.e.brandt@intel.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 1/2] printk: flush consoles before checking progress
Date:   Fri,  6 Oct 2023 10:21:50 +0200
Message-Id: <20231006082151.6969-2-pmladek@suse.com>
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

From: John Ogness <john.ogness@linutronix.de>

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

Note that console_unlock() does not guarantee flushing all messages
since the commit dbdda842fe96f89 ("printk: Add console owner and waiter
logic to load balance console writes").

Reported-by: Todd Brandt <todd.e.brandt@intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217955
Fixes: 9e70a5e109a4 ("printk: Add per-console suspended state")
Co-developed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 7e0b4dd02398..0b3af1529778 100644
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
 
-- 
2.35.3

