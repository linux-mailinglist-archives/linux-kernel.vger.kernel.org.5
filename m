Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DDA798E68
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242039AbjIHSvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjIHSvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:51:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB9C19BC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 11:51:18 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694199012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZN61Yy4XSz9CP6DFAbMX5JI5My6PbyQNjYXE4FEmNGo=;
        b=YHEupqhklhm8R/QAhZK9ScmnErHg9LEyYAlTnnnN90vZPgN7SpKF3fGxOZbF5trtDarXVZ
        +1r2oxC4p3ICWejXGwxTwZpktKFhDORm2TVsya4vh8FfSPaRI3BQg2IasV5YmIoe12MrSU
        NvnoSUtq0wPu0aiXSIs+RfQO92nF6MloFcrgcZKvLPh0Xg7yMx7D/JleiOv93K4iSIoDcA
        5kTC3hJ7FZLiS1e4SvIypSBx+7Qt+xDKTFTaZwLb3zl4G/nUbACiy4ozu8j3TVHfMaUVVy
        eOMj2/hLWFaZEihcVBIdg9kVj9l9/fIs+fx0iNe/ubtz/Akbt5xwJrk2zN3TcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694199012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZN61Yy4XSz9CP6DFAbMX5JI5My6PbyQNjYXE4FEmNGo=;
        b=31OH1/qaNXMWm4TVF2X5SrE+xp20PFUhRf6u6fh4PARwj8J/3eg4/E6ipgCWHgPFIxLdVZ
        3gstFOM77rUx0LDw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 3/8] printk: Make static printk buffers available to nbcon
Date:   Fri,  8 Sep 2023 20:56:03 +0206
Message-Id: <20230908185008.468566-4-john.ogness@linutronix.de>
In-Reply-To: <20230908185008.468566-1-john.ogness@linutronix.de>
References: <20230908185008.468566-1-john.ogness@linutronix.de>
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

The nbcon boot consoles also need printk buffers that are available
very early. Since the nbcon boot consoles will also be serialized
by the console_lock, they can use the same static printk buffers
that the legacy consoles are using.

Make the legacy static printk buffers available outside of printk.c
so they can be used by nbcon.c.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/internal.h |  2 ++
 kernel/printk/printk.c   | 13 +++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 2ca0ab78802c..7199d60bfc25 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -86,6 +86,8 @@ static inline void nbcon_cleanup(struct console *con) { }
 
 #endif /* CONFIG_PRINTK */
 
+extern struct printk_buffers printk_shared_pbufs;
+
 /**
  * struct printk_buffers - Buffers to read/format/output printk messages.
  * @outbuf:	After formatting, contains text to output.
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c0246093ea41..9a2ddab16abe 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2844,6 +2844,13 @@ static bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 	return true;
 }
 
+/*
+ * Used as the printk buffers for non-panic, serialized console printing.
+ * This is for legacy (!CON_NBCON) as well as all boot (CON_BOOT) consoles.
+ * Its usage requires the console_lock held.
+ */
+struct printk_buffers printk_shared_pbufs;
+
 /*
  * Print one record for the given console. The record printed is whatever
  * record is the next available record for the given console.
@@ -2861,12 +2868,10 @@ static bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
  */
 static bool console_emit_next_record(struct console *con, bool *handover, int cookie)
 {
-	static struct printk_buffers pbufs;
-
 	bool is_extended = console_srcu_read_flags(con) & CON_EXTENDED;
-	char *outbuf = &pbufs.outbuf[0];
+	char *outbuf = &printk_shared_pbufs.outbuf[0];
 	struct printk_message pmsg = {
-		.pbufs = &pbufs,
+		.pbufs = &printk_shared_pbufs,
 	};
 	unsigned long flags;
 
-- 
2.39.2

