Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B21676607B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 02:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjG1ADI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 20:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjG1ACp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 20:02:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006B1BF
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 17:02:42 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690502558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+2Y16kupdutHjhiUaBB096BqHV4UeSVGmrxKDvfMgWs=;
        b=sgipofk7vGitPK8JkqZ6tuBbrENDClmWXVbTPa43JXKL3wJBb8zRCefBwj83Rpnr0D2mnC
        +ofWrSWlqWlAI1cVj8QU4hIKCjX03YfIvvjFM/yUMotvcn+BurtrxepWdzN+LUSAbLRDMG
        wk8TQrh/awtK438uUGWAoxIBSZwYJK6hSnwevk9Im/3DTk76wAWIYUhyUDIkTBT2bmcTRX
        LocX8AJqRFLO9OikS8e4x/tXumI08M4VdnZ/j4pfdRq7As6pHbgtHJYnKgwSKLvs+xCTCP
        dWYsmiwtojGS/DfX63DdYDcSW5pTsW6I0z7SvFrsq3Kk48SlDAkFMKqx2BAERw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690502558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+2Y16kupdutHjhiUaBB096BqHV4UeSVGmrxKDvfMgWs=;
        b=Ui+XH/mSQ/PmaAfWhLql0P8DmP9eOR63WLUKjroDBUypMeaYhfvNbbqwul4r/A6hNb61hB
        5pbHj2pM091ZISDw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v2 7/8] printk: nbcon: Add emit function and callback function for atomic printing
Date:   Fri, 28 Jul 2023 02:08:32 +0206
Message-Id: <20230728000233.50887-8-john.ogness@linutronix.de>
In-Reply-To: <20230728000233.50887-1-john.ogness@linutronix.de>
References: <20230728000233.50887-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 include/linux/console.h      |  27 ++++++++
 kernel/printk/internal.h     |   6 ++
 kernel/printk/printk.c       |   9 +--
 kernel/printk/printk_nbcon.c | 121 ++++++++++++++++++++++++++++++++++-
 4 files changed, 156 insertions(+), 7 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index a50eaa3b8420..3d129b2b70a1 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -243,6 +243,7 @@ struct printk_buffers;
  * @unsafe:		This context is in an unsafe section
  * @hostile:		Acquire console by hostile takeover
  * @takeover_unsafe:	Acquire console by hostile takeover even if unsafe
+ * @backlog:		Ringbuffer has pending records
  * @pbufs:		Pointer to the text buffer for this context
  * @seq:		The sequence number to print for this context
  */
@@ -255,11 +256,28 @@ struct nbcon_context {
 	unsigned int		hostile			: 1;
 	unsigned int		takeover_unsafe		: 1;
 
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
+ * @hostile_unsafe:	The @unsafe value before a hostile takeover
+ */
+struct nbcon_write_context {
+	struct nbcon_context	__private ctxt;
+	char			*outbuf;
+	unsigned int		len;
+	bool			hostile_unsafe;
+};
+
 /**
  * struct console - The console descriptor structure
  * @name:		The name of the console driver
@@ -280,6 +298,7 @@ struct nbcon_context {
  * @data:		Driver private data
  * @node:		hlist node for the console list
  *
+ * @write_atomic:	Write callback for atomic context
  * @nbcon_state:	State for nbcon consoles
  * @nbcon_seq:		Sequence number of the next record for nbcon to print
  * @pbufs:		Pointer to nbcon private buffer
@@ -304,6 +323,8 @@ struct console {
 	struct hlist_node	node;
 
 	/* nbcon console specific members */
+	bool			(*write_atomic)(struct console *con,
+						struct nbcon_write_context *wctxt);
 	atomic_t		__private nbcon_state;
 	atomic_long_t		__private nbcon_seq;
 	struct printk_buffers	*pbufs;
@@ -433,6 +454,12 @@ static inline bool console_is_registered(const struct console *con)
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
index 1baccddf83b8..96dcb2cc05b1 100644
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
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 64e404aacbc4..0124c433da9d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -716,9 +716,6 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
 	return len;
 }
 
-static bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
-				    bool is_extended, bool may_supress);
-
 /* /dev/kmsg - userspace message inject/listen interface */
 struct devkmsg_user {
 	atomic64_t seq;
@@ -2751,7 +2748,7 @@ static void __console_unlock(void)
  * If @pmsg->pbufs->outbuf is modified, @pmsg->outbuf_len is updated.
  */
 #ifdef CONFIG_PRINTK
-static void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
+void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
 {
 	struct printk_buffers *pbufs = pmsg->pbufs;
 	const size_t scratchbuf_sz = sizeof(pbufs->scratchbuf);
@@ -2805,8 +2802,8 @@ static void console_prepend_dropped(struct printk_message *pmsg, unsigned long d
  * of @pmsg are valid. (See the documentation of struct printk_message
  * for information about the @pmsg fields.)
  */
-static bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
-				    bool is_extended, bool may_suppress)
+bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
+			     bool is_extended, bool may_suppress)
 {
 	static int panic_console_dropped;
 
diff --git a/kernel/printk/printk_nbcon.c b/kernel/printk/printk_nbcon.c
index e41f2eff5ef6..e1f0e4278ffa 100644
--- a/kernel/printk/printk_nbcon.c
+++ b/kernel/printk/printk_nbcon.c
@@ -198,7 +198,6 @@ void nbcon_seq_force(struct console *con, u64 seq)
  * In case of fail the console has been likely taken over. However, the
  * caller must still assume it has ownership and decide how to proceed.
  */
-__maybe_unused
 static bool nbcon_seq_try_update(struct nbcon_context *ctxt)
 {
 	struct console *con = ctxt->console;
@@ -717,6 +716,33 @@ static bool nbcon_context_can_proceed(struct nbcon_context *ctxt, struct nbcon_s
 	return false;
 }
 
+/**
+ * nbcon_can_proceed - Check whether ownership can proceed
+ * @wctxt:	The write context that was handed to the write function
+ *
+ * Return:	True if the state is correct. False if ownership was
+ *		handed over or taken.
+ *
+ * Must be invoked after the record was dumped into the assigned buffer
+ * and at appropriate safe places in the driver.
+ *
+ * When this function returns false then the calling context is no longer
+ * the owner and is no longer allowed to go forward. In this case it must
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
@@ -761,6 +787,99 @@ static bool nbcon_context_update_unsafe(struct nbcon_context *ctxt, bool unsafe)
 	return true;
 }
 
+/**
+ * nbcon_emit_next_record - Emit a record in the acquired context
+ * @wctxt:	The write context that will be handed to the write function
+ *
+ * Return:	True if the state is correct. False if ownership was
+ *		handed over or taken.
+ *
+ * When this function returns false then the calling context is no longer
+ * the owner and is no longer allowed to go forward. In this case it must
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
+	 * @con->dropped is not protected in case of hostile takeovers. In
+	 * that situation the update can be racy so annotate it accordingly.
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
+	wctxt->hostile_unsafe = cur.hostile_unsafe;
+	wctxt->len = pmsg.outbuf_len;
+	if (wctxt->len)
+		wctxt->outbuf = &pmsg.pbufs->outbuf[0];
+	else
+		wctxt->outbuf = NULL;
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
+	if (dropped != con_dropped) {
+		/* Counterpart to the READ_ONCE() above. */
+		WRITE_ONCE(con->dropped, dropped);
+	}
+
+	ctxt->seq = pmsg.seq + 1;
+	if (!nbcon_seq_try_update(ctxt)) {
+		/* This context probably lost ownership. Check. */
+		return nbcon_can_proceed(wctxt);
+	}
+
+	return true;
+}
+
 /**
  * nbcon_init - Initialize the nbcon console specific data
  * @con:	Console to initialize
-- 
2.39.2

