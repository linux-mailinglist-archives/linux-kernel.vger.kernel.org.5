Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9067A3232
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 21:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239204AbjIPTU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 15:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235791AbjIPTUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 15:20:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A45CED
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 12:20:18 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694892015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yvzwbYjYpGtpc5SL3eYC1oLQ+jH59dIYahpYWig24cg=;
        b=VkbUFqDyZl8/l9mPXvEDjVV+VgN/M6UFDEgWCGl/RQY4mCdPXYwaEcNUiq3phqceQ7kW5Y
        FVY6cW2Z2FesXBIF+TPqoYKVmxHPG4mBmkT9In8LVLc60vBFWdRUyAcbLd8acooKUpZr9e
        9P0cGs69gWKfnTmHge8+tMF7WbKGU7+pKDXe+mHCyGmhOPYPLmtJ1aBKdnCcJZs3ljLN64
        m67Iow7k0GhDV6FQnYkw49aE7Fd1x1L6T6Cj5nfdJJM4sohj2a6xy8NDRVK0naNaBwQiVe
        Q9qnme2TldT5metvCczh3vatIQEH6zNLz+Kvks7ep30GOt08StnohxUiHB8R4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694892015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yvzwbYjYpGtpc5SL3eYC1oLQ+jH59dIYahpYWig24cg=;
        b=+4VZC6DkSp7M5hHDrnM79OpSeQNGG1cmmFZBmqswG5kN+OntG02/H5moO6+Z1MwsWplG+/
        Mb+YEkbKbyaZxOCw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v5 8/8] printk: nbcon: Allow drivers to mark unsafe regions and check state
Date:   Sat, 16 Sep 2023 21:26:07 +0206
Message-Id: <20230916192007.608398-9-john.ogness@linutronix.de>
In-Reply-To: <20230916192007.608398-1-john.ogness@linutronix.de>
References: <20230916192007.608398-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

For the write_atomic callback, the console driver may have unsafe
regions that need to be appropriately marked. Provide functions
that accept the nbcon_write_context struct to allow for the driver
to enter and exit unsafe regions.

Also provide a function for drivers to check if they are still the
owner of the console.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/console.h | 10 ++++++
 kernel/printk/nbcon.c   | 75 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index 14563dcb34b1..e4fc6f7c1496 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -451,6 +451,16 @@ static inline bool console_is_registered(const struct console *con)
 	lockdep_assert_console_list_lock_held();			\
 	hlist_for_each_entry(con, &console_list, node)
 
+#ifdef CONFIG_PRINTK
+extern bool nbcon_can_proceed(struct nbcon_write_context *wctxt);
+extern bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt);
+extern bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt);
+#else
+static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) { return false; }
+static inline bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt) { return false; }
+static inline bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt) { return false; }
+#endif
+
 extern int console_set_on_cmdline;
 extern struct console *early_console;
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 6e05d263fd22..b96077152f49 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -732,6 +732,41 @@ static bool nbcon_context_can_proceed(struct nbcon_context *ctxt, struct nbcon_s
 	return false;
 }
 
+/**
+ * nbcon_can_proceed - Check whether ownership can proceed
+ * @wctxt:	The write context that was handed to the write function
+ *
+ * Return:	True if this context still owns the console. False if
+ *		ownership was handed over or taken.
+ *
+ * It is used in nbcon_enter_unsafe() to make sure that it still owns the
+ * lock. Also it is used in nbcon_exit_unsafe() to eventually free the lock
+ * for a higher priority context which asked for the friendly handover.
+ *
+ * It can be called inside an unsafe section when the console is just
+ * temporary in safe state instead of exiting and entering the unsafe state.
+ *
+ * Also it can be called in the safe context before doing an expensive safe
+ * operation. It does not make sense to do the operation when a higher
+ * priority context took the lock.
+ *
+ * When this function returns false then the calling context no longer owns
+ * the console and is no longer allowed to go forward. In this case it must
+ * back out immediately and carefully. The buffer content is also no longer
+ * trusted since it no longer belongs to the calling context.
+ */
+bool nbcon_can_proceed(struct nbcon_write_context *wctxt)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+	struct console *con = ctxt->console;
+	struct nbcon_state cur;
+
+	nbcon_state_read(con, &cur);
+
+	return nbcon_context_can_proceed(ctxt, &cur);
+}
+EXPORT_SYMBOL_GPL(nbcon_can_proceed);
+
 #define nbcon_context_enter_unsafe(c)	__nbcon_context_update_unsafe(c, true)
 #define nbcon_context_exit_unsafe(c)	__nbcon_context_update_unsafe(c, false)
 
@@ -782,6 +817,46 @@ static bool __nbcon_context_update_unsafe(struct nbcon_context *ctxt, bool unsaf
 	return nbcon_context_can_proceed(ctxt, &cur);
 }
 
+/**
+ * nbcon_enter_unsafe - Enter an unsafe region in the driver
+ * @wctxt:	The write context that was handed to the write function
+ *
+ * Return:	True if this context still owns the console. False if
+ *		ownership was handed over or taken.
+ *
+ * When this function returns false then the calling context no longer owns
+ * the console and is no longer allowed to go forward. In this case it must
+ * back out immediately and carefully. The buffer content is also no longer
+ * trusted since it no longer belongs to the calling context.
+ */
+bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+
+	return nbcon_context_enter_unsafe(ctxt);
+}
+EXPORT_SYMBOL_GPL(nbcon_enter_unsafe);
+
+/**
+ * nbcon_exit_unsafe - Exit an unsafe region in the driver
+ * @wctxt:	The write context that was handed to the write function
+ *
+ * Return:	True if this context still owns the console. False if
+ *		ownership was handed over or taken.
+ *
+ * When this function returns false then the calling context no longer owns
+ * the console and is no longer allowed to go forward. In this case it must
+ * back out immediately and carefully. The buffer content is also no longer
+ * trusted since it no longer belongs to the calling context.
+ */
+bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+
+	return nbcon_context_exit_unsafe(ctxt);
+}
+EXPORT_SYMBOL_GPL(nbcon_exit_unsafe);
+
 /**
  * nbcon_emit_next_record - Emit a record in the acquired context
  * @wctxt:	The write context that will be handed to the write function
-- 
2.39.2

