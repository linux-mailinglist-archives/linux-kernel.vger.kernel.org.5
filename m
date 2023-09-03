Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF3A790C9E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 17:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242681AbjICPGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 11:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242320AbjICPFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 11:05:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875A3115
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 08:05:48 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693753545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lifpF5t2OGOHdVmqj8kSY6dHWUSNKSm/DwAjLQyE6o0=;
        b=J3DGDrryU6XVVVo5xOUPW9+zsVFE3uRHU8GoqvQ6yRqxQyASWasGfCLmKFxadyzQ3Jvt7q
        IIE0I1WdZqZJPsHODoOJhI5QJ9LVrPSrrCdmvfGsX3T2/KNZimrcBXLxp4zucpCEAhAo15
        BAXSQ6+5o7bfosyCPCexH44bRWuJUCbBdWKxT3kiUJvq3k1EP7kx3O7Of50eGxnFPC7TS4
        rmDRmo0/ogBdkikJyEPtARgv4y6lT3Zm14Kyf/1frHVaU/7Rnp59G7y5/hBlmYS8ZcMcL7
        TOPhpc+q5iD2DWJsAfY+GrOTVDronr+6mYIn7Vp9vWiEhGF4cj7fYK0ZNYZ8Kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693753545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lifpF5t2OGOHdVmqj8kSY6dHWUSNKSm/DwAjLQyE6o0=;
        b=oNCFYrbWj/dqfu11KWq2UkY5dF395OEkeGBbY6bQNYdYwEfaIr0bqJ+pgLnVD6VSg+NCk/
        NSSNJlCHwy5WPTAw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v3 6/7] printk: nbcon: Add emit function and callback function for atomic printing
Date:   Sun,  3 Sep 2023 17:11:38 +0206
Message-Id: <20230903150539.245076-7-john.ogness@linutronix.de>
In-Reply-To: <20230903150539.245076-1-john.ogness@linutronix.de>
References: <20230903150539.245076-1-john.ogness@linutronix.de>
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

From: Thomas Gleixner <tglx@linutronix.de>

Implement an emit function for nbcon consoles to output printk
messages. It utilizes the lockless printk_get_next_message() and
console_prepend_dropped() functions to retrieve/build the output
message. The emit function includes the required safety points to
check for handover/takeover and calls a new write_atomic callback
of the console driver to output the message. It also includes
proper handling for updating the nbcon console sequence number.

A new nbcon_write_context struct is introduced. This is provided
to the write_atomic callback and includes only the information
necessary for performing atomic writes.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
---
 include/linux/console.h  |  27 +++++++++
 kernel/printk/internal.h |   6 ++
 kernel/printk/nbcon.c    | 124 ++++++++++++++++++++++++++++++++++++++-
 kernel/printk/printk.c   |   9 +--
 4 files changed, 158 insertions(+), 8 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 8e8dc8d1016b..8d0a309b5286 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -248,6 +248,7 @@ struct printk_buffers;
  *				be used only with NBCON_PRIO_PANIC @prio. It
  *				might cause a system freeze when the console
  *				is used later.
+ * @backlog:			Ringbuffer has pending records
  * @pbufs:			Pointer to the text buffer for this context
  * @seq:			The sequence number to print for this context
  */
@@ -258,11 +259,28 @@ struct nbcon_context {
 	enum nbcon_prio		prio;
 	unsigned int		allow_unsafe_takeover	: 1;
 
+	/* members set by emit */
+	unsigned int		backlog			: 1;
+
 	/* members set by acquire */
 	struct printk_buffers	*pbufs;
 	u64			seq;
 };
 
+/**
+ * struct nbcon_write_context - Context handed to the nbcon write callbacks
+ * @ctxt:		The core console context
+ * @outbuf:		Pointer to the text buffer for output
+ * @len:		Length to write
+ * @unsafe_takeover:	If a hostile takeover in an unsafe state has occurred
+ */
+struct nbcon_write_context {
+	struct nbcon_context	__private ctxt;
+	char			*outbuf;
+	unsigned int		len;
+	bool			unsafe_takeover;
+};
+
 /**
  * struct console - The console descriptor structure
  * @name:		The name of the console driver
@@ -283,6 +301,7 @@ struct nbcon_context {
  * @data:		Driver private data
  * @node:		hlist node for the console list
  *
+ * @write_atomic:	Write callback for atomic context
  * @nbcon_state:	State for nbcon consoles
  * @nbcon_seq:		Sequence number of the next record for nbcon to print
  * @pbufs:		Pointer to nbcon private buffer
@@ -307,6 +326,8 @@ struct console {
 	struct hlist_node	node;
 
 	/* nbcon console specific members */
+	bool			(*write_atomic)(struct console *con,
+						struct nbcon_write_context *wctxt);
 	atomic_t		__private nbcon_state;
 	atomic_long_t		__private nbcon_seq;
 	struct printk_buffers	*pbufs;
@@ -436,6 +457,12 @@ static inline bool console_is_registered(const struct console *con)
 	lockdep_assert_console_list_lock_held();			\
 	hlist_for_each_entry(con, &console_list, node)
 
+#ifdef CONFIG_PRINTK
+extern bool nbcon_can_proceed(struct nbcon_write_context *wctxt);
+#else
+static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) { return false; }
+#endif
+
 extern int console_set_on_cmdline;
 extern struct console *early_console;
 
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 956f65308392..4d532623b3cf 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -128,3 +128,9 @@ struct printk_message {
 };
 
 bool other_cpu_in_panic(void);
+bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
+			     bool is_extended, bool may_supress);
+
+#ifdef CONFIG_PRINTK
+void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped);
+#endif
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index cd8d1e8539af..1a3df603111d 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -176,7 +176,6 @@ void nbcon_seq_force(struct console *con, u64 seq)
  * current context no longer owns the console. In the later case, it will
  * stop printing anyway.
  */
-__maybe_unused
 static void nbcon_seq_try_update(struct nbcon_context *ctxt, u64 new_seq)
 {
 	unsigned long nbcon_seq = __seq_to_nbcon_seq(ctxt->seq);
@@ -684,6 +683,32 @@ static bool nbcon_context_can_proceed(struct nbcon_context *ctxt, struct nbcon_s
 	return false;
 }
 
+/**
+ * nbcon_can_proceed - Check whether ownership can proceed
+ * @wctxt:	The write context that was handed to the write function
+ *
+ * Return:	True if this context still owns the console. False if
+ *		ownership was handed over or taken.
+ *
+ * Must be invoked at appropriate safe places in the driver.
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
 /**
  * nbcon_context_update_unsafe - Update the unsafe bit in @con->nbcon_state
  * @ctxt:	The nbcon context from nbcon_context_try_acquire()
@@ -703,7 +728,6 @@ static bool nbcon_context_can_proceed(struct nbcon_context *ctxt, struct nbcon_s
  *
  * Internal helper to avoid duplicated code.
  */
-__maybe_unused
 static bool nbcon_context_update_unsafe(struct nbcon_context *ctxt, bool unsafe)
 {
 	struct console *con = ctxt->console;
@@ -732,6 +756,102 @@ static bool nbcon_context_update_unsafe(struct nbcon_context *ctxt, bool unsafe)
 	return nbcon_context_can_proceed(ctxt, &cur);
 }
 
+/**
+ * nbcon_emit_next_record - Emit a record in the acquired context
+ * @wctxt:	The write context that will be handed to the write function
+ *
+ * Return:	True if this context still owns the console. False if
+ *		ownership was handed over or taken.
+ *
+ * When this function returns false then the calling context no longer owns
+ * the console and is no longer allowed to go forward. In this case it must
+ * back out immediately and carefully. The buffer content is also no longer
+ * trusted since it no longer belongs to the calling context. If the caller
+ * wants to do more it must reacquire the console first.
+ *
+ * When true is returned, @wctxt->ctxt.backlog indicates whether there are
+ * still records pending in the ringbuffer,
+ */
+__maybe_unused
+static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+	struct console *con = ctxt->console;
+	bool is_extended = console_srcu_read_flags(con) & CON_EXTENDED;
+	struct printk_message pmsg = {
+		.pbufs = ctxt->pbufs,
+	};
+	unsigned long con_dropped;
+	struct nbcon_state cur;
+	unsigned long dropped;
+	bool done;
+
+	ctxt->backlog = printk_get_next_message(&pmsg, ctxt->seq, is_extended, true);
+	if (!ctxt->backlog)
+		return true;
+
+	/*
+	 * @con->dropped is not protected in case of an unsafe hostile
+	 * takeover. In that situation the update can be racy so
+	 * annotate it accordingly.
+	 */
+	con_dropped = data_race(READ_ONCE(con->dropped));
+
+	dropped = con_dropped + pmsg.dropped;
+	if (dropped && !is_extended)
+		console_prepend_dropped(&pmsg, dropped);
+
+	/* Safety point. Do not touch state in case of takeover. */
+	nbcon_state_read(con, &cur);
+	if (!nbcon_context_can_proceed(ctxt, &cur))
+		return false;
+
+	/* For skipped records just update seq/dropped in @con. */
+	if (pmsg.outbuf_len == 0)
+		goto update_con;
+
+	/* Set the write context before calling write callback. */
+	wctxt->outbuf = &pmsg.pbufs->outbuf[0];
+	wctxt->len = pmsg.outbuf_len;
+	wctxt->unsafe_takeover = cur.unsafe_takeover;
+
+	if (con->write_atomic) {
+		done = con->write_atomic(con, wctxt);
+	} else {
+		nbcon_context_release(ctxt);
+		WARN_ON_ONCE(1);
+		done = false;
+	}
+
+	/* If not done, the emit was aborted. */
+	if (!done)
+		return false;
+
+	/*
+	 * Since any dropped message was successfully output, reset the
+	 * dropped count for the console.
+	 */
+	dropped = 0;
+update_con:
+	/*
+	 * The dropped count and the sequence number are updated within an
+	 * unsafe section. This limits update races to the panic context and
+	 * allows the panic context to win.
+	 */
+
+	if (!nbcon_context_update_unsafe(ctxt, true))
+		return false;
+
+	if (dropped != con_dropped) {
+		/* Counterpart to the READ_ONCE() above. */
+		WRITE_ONCE(con->dropped, dropped);
+	}
+
+	nbcon_seq_try_update(ctxt, pmsg.seq + 1);
+
+	return nbcon_context_update_unsafe(ctxt, false);
+}
+
 /**
  * nbcon_alloc - Allocate buffers needed by the nbcon console
  * @con:	Console to initialize
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 4e22ff8d065e..f6e1fca2a2cb 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -696,9 +696,6 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
 	return len;
 }
 
-static bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
-				    bool is_extended, bool may_supress);
-
 /* /dev/kmsg - userspace message inject/listen interface */
 struct devkmsg_user {
 	atomic64_t seq;
@@ -2731,7 +2728,7 @@ static void __console_unlock(void)
  * If @pmsg->pbufs->outbuf is modified, @pmsg->outbuf_len is updated.
  */
 #ifdef CONFIG_PRINTK
-static void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
+void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
 {
 	struct printk_buffers *pbufs = pmsg->pbufs;
 	const size_t scratchbuf_sz = sizeof(pbufs->scratchbuf);
@@ -2785,8 +2782,8 @@ static void console_prepend_dropped(struct printk_message *pmsg, unsigned long d
  * of @pmsg are valid. (See the documentation of struct printk_message
  * for information about the @pmsg fields.)
  */
-static bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
-				    bool is_extended, bool may_suppress)
+bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
+			     bool is_extended, bool may_suppress)
 {
 	static int panic_console_dropped;
 
-- 
2.39.2

