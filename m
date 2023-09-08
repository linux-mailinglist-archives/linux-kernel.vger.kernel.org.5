Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10D4798E6E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjIHSxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244081AbjIHSxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:53:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00ED19BC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 11:52:33 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694199013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3AhXHgTl54l+2B1p5seos+XuRz43slfuqFnWPDcr6jw=;
        b=wqeA+DS3j4lZ9CtmYTWGxA7Vwv0ozInzpLy02fDJ59KlRkApaENw6u+iXsZkhUW9BzxzoZ
        6CNA6Ewj65Xyrjrr9rF3cDNuop898JA9dB9EKijMWJSj1k6qlpRg1BjVTQmJ/OP+n7dA2p
        1NfMC/d8Av6Yw7Rd+S05eJVuP0LqX068x9Ih2wf5U29gdl/A1hQovDz6L1UhjCi4Zr7uin
        sTE4HLilsqYmvs41zjLgi8Mm5uChtoP+9iE8BJicLP1ZIoFOWzPRaaMiSf+zQPknNYV90F
        sq0RunpIQGJurPLP0jzeCp0Vu27AuYadsseF4Hz3H/ayvhgYjIZBqdMkkYvlxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694199013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3AhXHgTl54l+2B1p5seos+XuRz43slfuqFnWPDcr6jw=;
        b=7L1m2xFCYDXI8ZHN1jJ9/MTYPL7pqILEBKjBdjRjrW1foSnsb/I36X5npEIIftWV8LAF2M
        dxHM9j3C/StrabAQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 5/8] printk: nbcon: Add ownership state functions
Date:   Fri,  8 Sep 2023 20:56:05 +0206
Message-Id: <20230908185008.468566-6-john.ogness@linutronix.de>
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
   These functions are also cancellation points where loss of
   ownership can occur.

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
 kernel/printk/nbcon.c | 110 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index cad1cf663078..644c4b9a4540 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -464,7 +464,6 @@ static bool nbcon_owner_matches(struct nbcon_state *cur, int expected_cpu,
  * nbcon_context_release - Release the console
  * @ctxt:	The nbcon context from nbcon_context_try_acquire()
  */
-__maybe_unused
 static void nbcon_context_release(struct nbcon_context *ctxt)
 {
 	unsigned int cpu = smp_processor_id();
@@ -492,6 +491,115 @@ static void nbcon_context_release(struct nbcon_context *ctxt)
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
+ * Must be invoked after the record was dumped into the assigned buffer
+ * and at appropriate safe places in the driver.
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
+	 * It is not known whether the handover succeeded. The outermost
+	 * callsite has to make the final decision whether printing
+	 * should proceed or not (via reacquire, possibly hostile). The
+	 * console is now unlocked so go back all the way instead of
+	 * trying to implement heuristics in tons of places.
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

