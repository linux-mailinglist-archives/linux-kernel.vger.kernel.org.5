Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F324C7A323C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 21:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239287AbjIPTVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 15:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbjIPTUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 15:20:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C44CE7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 12:20:18 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694892015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8OChr0GSn67JR7FwwS4ZNocQPb8t+7M7snweDbUlbX8=;
        b=aT8Ylp/DkL4rl4EZbGh+o+g0+2iSZqy0bHXmjjM5jsPNwsETUas5UQIZ0WHxsMEonTvynf
        lnWB7ItDwCKlT9hHOhUr005/vG/aj9+Qje+5/gMVWeDa7H5evCHt6qpVl+RfauXR+mHdOv
        RIc32Y95iaYAyMbo9K+DruY7LU0JiYB/XQkYxcLGabtnzQ4CvfiUHDvOXYkwxKC5JHPERI
        DRDrDWU9i5g15AUkkJ2jX/lxb5eV+XuFFGG2uL8oCHUx2GnHhXdHvcXcqs/zZ/ThAt6qaT
        m5aBc3Hj9Lu7zE+K7dkWSbCNFJSW+rDrE27ybz9IJdFHlWtyl0mDBF+HHuFnPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694892015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8OChr0GSn67JR7FwwS4ZNocQPb8t+7M7snweDbUlbX8=;
        b=GueiIGDUlsstqm3XSF4HTQN3M3L1puY78xucWAQqU84DQa/4oLVAR5Jm0FaSLr4BHC2l/M
        oFr+O7AtjqJgzTCw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v5 7/8] printk: nbcon: Add emit function and callback function for atomic printing
Date:   Sat, 16 Sep 2023 21:26:06 +0206
Message-Id: <20230916192007.608398-8-john.ogness@linutronix.de>
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
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/console.h  |  21 ++++++++
 kernel/printk/internal.h |   6 +++
 kernel/printk/nbcon.c    | 106 ++++++++++++++++++++++++++++++++++++++-
 kernel/printk/printk.c   |   9 ++--
 4 files changed, 134 insertions(+), 8 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 20cd486b76ad..14563dcb34b1 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -242,6 +242,7 @@ struct printk_buffers;
  *				be used only with NBCON_PRIO_PANIC @prio. It
  *				might cause a system freeze when the console
  *				is used later.
+ * @backlog:			Ringbuffer has pending records
  * @pbufs:			Pointer to the text buffer for this context
  * @seq:			The sequence number to print for this context
  */
@@ -252,11 +253,28 @@ struct nbcon_context {
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
@@ -277,6 +295,7 @@ struct nbcon_context {
  * @data:		Driver private data
  * @node:		hlist node for the console list
  *
+ * @write_atomic:	Write callback for atomic context
  * @nbcon_state:	State for nbcon consoles
  * @nbcon_seq:		Sequence number of the next record for nbcon to print
  * @pbufs:		Pointer to nbcon private buffer
@@ -301,6 +320,8 @@ struct console {
 	struct hlist_node	node;
 
 	/* nbcon console specific members */
+	bool			(*write_atomic)(struct console *con,
+						struct nbcon_write_context *wctxt);
 	atomic_t		__private nbcon_state;
 	atomic_long_t		__private nbcon_seq;
 	struct printk_buffers	*pbufs;
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 6473f5ae4a18..6c2afee5ef62 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -130,3 +130,9 @@ struct printk_message {
 };
 
 bool other_cpu_in_panic(void);
+bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
+			     bool is_extended, bool may_supress);
+
+#ifdef CONFIG_PRINTK
+void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped);
+#endif
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index e076096b31c0..6e05d263fd22 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -221,7 +221,6 @@ void nbcon_seq_force(struct console *con, u64 seq)
  * nbcon_seq_force() was used or the current context no longer owns the
  * console. In the later case, it will stop printing anyway.
  */
-__maybe_unused
 static void nbcon_seq_try_update(struct nbcon_context *ctxt, u64 new_seq)
 {
 	unsigned long nbcon_seq = __seq_to_nbcon_seq(ctxt->seq);
@@ -755,7 +754,6 @@ static bool nbcon_context_can_proceed(struct nbcon_context *ctxt, struct nbcon_s
  *
  * Internal helper to avoid duplicated code.
  */
-__maybe_unused
 static bool __nbcon_context_update_unsafe(struct nbcon_context *ctxt, bool unsafe)
 {
 	struct console *con = ctxt->console;
@@ -784,6 +782,110 @@ static bool __nbcon_context_update_unsafe(struct nbcon_context *ctxt, bool unsaf
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
+	/*
+	 * The printk buffers are filled within an unsafe section. This
+	 * prevents NBCON_PRIO_NORMAL and NBCON_PRIO_EMERGENCY from
+	 * clobbering each other.
+	 */
+
+	if (!nbcon_context_enter_unsafe(ctxt))
+		return false;
+
+	ctxt->backlog = printk_get_next_message(&pmsg, ctxt->seq, is_extended, true);
+	if (!ctxt->backlog)
+		return nbcon_context_exit_unsafe(ctxt);
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
+	if (!nbcon_context_exit_unsafe(ctxt))
+		return false;
+
+	/* For skipped records just update seq/dropped in @con. */
+	if (pmsg.outbuf_len == 0)
+		goto update_con;
+
+	/* Initialize the write context for driver callbacks. */
+	wctxt->outbuf = &pmsg.pbufs->outbuf[0];
+	wctxt->len = pmsg.outbuf_len;
+	nbcon_state_read(con, &cur);
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
+	if (!nbcon_context_enter_unsafe(ctxt))
+		return false;
+
+	if (dropped != con_dropped) {
+		/* Counterpart to the READ_ONCE() above. */
+		WRITE_ONCE(con->dropped, dropped);
+	}
+
+	nbcon_seq_try_update(ctxt, pmsg.seq + 1);
+
+	return nbcon_context_exit_unsafe(ctxt);
+}
+
 /**
  * nbcon_alloc - Allocate buffers needed by the nbcon console
  * @con:	Console to allocate buffers for
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 77857d2118ca..778359b21761 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -698,9 +698,6 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
 	return len;
 }
 
-static bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
-				    bool is_extended, bool may_supress);
-
 /* /dev/kmsg - userspace message inject/listen interface */
 struct devkmsg_user {
 	atomic64_t seq;
@@ -2733,7 +2730,7 @@ static void __console_unlock(void)
  * If @pmsg->pbufs->outbuf is modified, @pmsg->outbuf_len is updated.
  */
 #ifdef CONFIG_PRINTK
-static void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
+void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
 {
 	struct printk_buffers *pbufs = pmsg->pbufs;
 	const size_t scratchbuf_sz = sizeof(pbufs->scratchbuf);
@@ -2787,8 +2784,8 @@ static void console_prepend_dropped(struct printk_message *pmsg, unsigned long d
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

