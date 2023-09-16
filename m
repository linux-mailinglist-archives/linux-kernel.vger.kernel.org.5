Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBD97A322B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 21:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238487AbjIPTU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 15:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbjIPTUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 15:20:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1134F186
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 12:20:18 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694892014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dCV3i1wQ/bXXG540WfqP1F60ZYpDTCVSQtP5FLHtm5E=;
        b=pQOtxZCoxoPD+9RXbk7QD3yIODoh9u047Qrqj8bRW1APyv7MPSmwlp84kl918W8Xu4PikK
        a1p3LDkzr6ANYIUbik2JZlF1gFZhaZcE4qVzZJLZFL012f7ajv4Bofg+5fMAk4iDTzvEuu
        FtfK+JQa7kEin2z2RPdyt49DUteYDtEkxeILvkBIJHxUx+irIZJMpCyFGy8R6xJOhb/2XQ
        DRhUaoMMpdzxrW1U2IrElCdMVspN1eE3ktJ7HIjfrQkidynEuWwmAzt2asya8ii6BkNhdg
        R7kPX/qa81xrBAjtKzubL8+qRjkTrm13Z1KmHOQAVI4Shis6YDVboDThoQn74A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694892014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dCV3i1wQ/bXXG540WfqP1F60ZYpDTCVSQtP5FLHtm5E=;
        b=zSzkj9zVy+3i7DWujXcU/QZ0hH07sm6Lh/niV+YtVBUO7c3gZULsGbD0iPOxftB+i49pkW
        KnIHTj8r3KKMT3BA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v5 5/8] printk: nbcon: Add ownership state functions
Date:   Sat, 16 Sep 2023 21:26:04 +0206
Message-Id: <20230916192007.608398-6-john.ogness@linutronix.de>
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

Provide functions that are related to the safe handover mechanism
and allow console drivers to dynamically specify unsafe regions:

 - nbcon_context_can_proceed()

   Invoked by a console owner to check whether a handover request
   is pending or whether the console has been taken over by another
   context. If a handover request is pending, this function will
   also perform the handover, thus cancelling its own ownership.

 - nbcon_context_enter_unsafe()/nbcon_context_exit_unsafe()

   Invoked by a console owner to denote that the driver is about
   to enter or leave a critical region where a take over is unsafe.
   The exit variant is the point where the current owner releases
   the lock for a higher priority context which asked for the
   friendly handover.

   The unsafe state is stored in the console state and allows a
   new context to make informed decisions whether to attempt a
   takeover of such a console. The unsafe state is also available
   to the driver so that it can make informed decisions about the
   required actions and possibly take a special emergency path.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/nbcon.c | 123 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 122 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index ba1febf15db6..98e4be5429f0 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -537,7 +537,6 @@ static bool nbcon_owner_matches(struct nbcon_state *cur, int expected_cpu,
  * nbcon_context_release - Release the console
  * @ctxt:	The nbcon context from nbcon_context_try_acquire()
  */
-__maybe_unused
 static void nbcon_context_release(struct nbcon_context *ctxt)
 {
 	unsigned int cpu = smp_processor_id();
@@ -565,6 +564,128 @@ static void nbcon_context_release(struct nbcon_context *ctxt)
 	ctxt->pbufs = NULL;
 }
 
+/**
+ * nbcon_context_can_proceed - Check whether ownership can proceed
+ * @ctxt:	The nbcon context from nbcon_context_try_acquire()
+ * @cur:	The current console state
+ *
+ * Return:	True if this context still owns the console. False if
+ *		ownership was handed over or taken.
+ *
+ * Must be invoked when entering the unsafe state to make sure that it still
+ * owns the lock. Also must be invoked when exiting the unsafe context
+ * to eventually free the lock for a higher priority context which asked
+ * for the friendly handover.
+ *
+ * It can be called inside an unsafe section when the console is just
+ * temporary in safe state instead of exiting and entering the unsafe
+ * state.
+ *
+ * Also it can be called in the safe context before doing an expensive
+ * safe operation. It does not make sense to do the operation when
+ * a higher priority context took the lock.
+ *
+ * When this function returns false then the calling context no longer owns
+ * the console and is no longer allowed to go forward. In this case it must
+ * back out immediately and carefully. The buffer content is also no longer
+ * trusted since it no longer belongs to the calling context.
+ */
+static bool nbcon_context_can_proceed(struct nbcon_context *ctxt, struct nbcon_state *cur)
+{
+	unsigned int cpu = smp_processor_id();
+
+	/* Make sure this context still owns the console. */
+	if (!nbcon_owner_matches(cur, cpu, ctxt->prio))
+		return false;
+
+	/* The console owner can proceed if there is no waiter. */
+	if (cur->req_prio == NBCON_PRIO_NONE)
+		return true;
+
+	/*
+	 * A console owner within an unsafe region is always allowed to
+	 * proceed, even if there are waiters. It can perform a handover
+	 * when exiting the unsafe region. Otherwise the waiter will
+	 * need to perform an unsafe hostile takeover.
+	 */
+	if (cur->unsafe)
+		return true;
+
+	/* Waiters always have higher priorities than owners. */
+	WARN_ON_ONCE(cur->req_prio <= cur->prio);
+
+	/*
+	 * Having a safe point for take over and eventually a few
+	 * duplicated characters or a full line is way better than a
+	 * hostile takeover. Post processing can take care of the garbage.
+	 * Release and hand over.
+	 */
+	nbcon_context_release(ctxt);
+
+	/*
+	 * It is not clear whether the waiter really took over ownership. The
+	 * outermost callsite must make the final decision whether console
+	 * ownership is needed for it to proceed. If yes, it must reacquire
+	 * ownership (possibly hostile) before carefully proceeding.
+	 *
+	 * The calling context no longer owns the console so go back all the
+	 * way instead of trying to implement reacquire heuristics in tons of
+	 * places.
+	 */
+	return false;
+}
+
+#define nbcon_context_enter_unsafe(c)	__nbcon_context_update_unsafe(c, true)
+#define nbcon_context_exit_unsafe(c)	__nbcon_context_update_unsafe(c, false)
+
+/**
+ * __nbcon_context_update_unsafe - Update the unsafe bit in @con->nbcon_state
+ * @ctxt:	The nbcon context from nbcon_context_try_acquire()
+ * @unsafe:	The new value for the unsafe bit
+ *
+ * Return:	True if the unsafe state was updated and this context still
+ *		owns the console. Otherwise false if ownership was handed
+ *		over or taken.
+ *
+ * This function allows console owners to modify the unsafe status of the
+ * console.
+ *
+ * When this function returns false then the calling context no longer owns
+ * the console and is no longer allowed to go forward. In this case it must
+ * back out immediately and carefully. The buffer content is also no longer
+ * trusted since it no longer belongs to the calling context.
+ *
+ * Internal helper to avoid duplicated code.
+ */
+__maybe_unused
+static bool __nbcon_context_update_unsafe(struct nbcon_context *ctxt, bool unsafe)
+{
+	struct console *con = ctxt->console;
+	struct nbcon_state cur;
+	struct nbcon_state new;
+
+	nbcon_state_read(con, &cur);
+
+	do {
+		/*
+		 * The unsafe bit must not be cleared if an
+		 * unsafe hostile takeover has occurred.
+		 */
+		if (!unsafe && cur.unsafe_takeover)
+			goto out;
+
+		if (!nbcon_context_can_proceed(ctxt, &cur))
+			return false;
+
+		new.atom = cur.atom;
+		new.unsafe = unsafe;
+	} while (!nbcon_state_try_cmpxchg(con, &cur, &new));
+
+	cur.atom = new.atom;
+out:
+	return nbcon_context_can_proceed(ctxt, &cur);
+}
+
 /**
  * nbcon_alloc - Allocate buffers needed by the nbcon console
  * @con:	Console to allocate buffers for
-- 
2.39.2

