Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E9C790C98
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 17:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242351AbjICPFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 11:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjICPFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 11:05:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AF511A
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 08:05:46 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693753545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xBRaZ+TuG03wNRILh9l2iuLdaj2YHt+tf5m0T3yqwpg=;
        b=uL1EPIudwHHMYR6/IwUw1jVHP8AbXR4ZxobZnvHPiaeReJXD5BY/3OR3btmg12mk3KzDYh
        iaWWUJFCohHRPxSVNUy4qn5RgREaYGYnK9i5C9SFhRnhoSKrbrmVjFLzkOnyGhPV/CMLT/
        QfBLEfZoWmPa786qsU1CJxFng1xV/1BjmxjDNKhL1Zm0pWNZGZ5vynNLK3J1JsV7yrCnWi
        YYHBNIHJiiu5C2P9Ug57vk/nIImN5Q9+g/ocRBx9v+3IJMT3VUuN8x6jZ33p63ALqCpgWF
        9xnX07CjIExP8SabH3MPQWDSrFr5gOU668IR5QaU+0NRYo2/+8ujSwDX2Q16pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693753545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xBRaZ+TuG03wNRILh9l2iuLdaj2YHt+tf5m0T3yqwpg=;
        b=2E1+iy4RBqjks1KLzdHsfvia4Lv+hzW2kZ+A6Wt75UIby8ld9H0a2mnXwxWv+oa1MvLIIw
        kkvXGyKPxTgIbMBw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 4/7] printk: nbcon: Add ownership state functions
Date:   Sun,  3 Sep 2023 17:11:36 +0206
Message-Id: <20230903150539.245076-5-john.ogness@linutronix.de>
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

Provide functions that are related to the safe handover mechanism
and allow console drivers to dynamically specify unsafe regions:

 - nbcon_context_can_proceed()

   Invoked by a console owner to check whether a handover request
   is pending or whether the console has been taken over by another
   context. If a handover request is pending, this function will
   also perform the handover, thus cancelling its own ownership.

 - nbcon_context_update_unsafe()

   Invoked by a console owner to denote that the driver is about
   to enter or leave a critical region where a take over is unsafe.
   This function is also a cancellation point where loss of
   ownership can occur.

   The unsafe state is stored in the console state and allows a
   new context to make informed decisions whether to attempt a
   takeover of such a console. The unsafe state is also available
   to the driver so that it can make informed decisions about the
   required actions and possibly take a special emergency path.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
---
 kernel/printk/nbcon.c | 107 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index c148467b39b8..76e39538bdec 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -490,7 +490,6 @@ static bool nbcon_owner_matches(struct nbcon_state *cur, int expected_cpu,
  * nbcon_context_release - Release the console
  * @ctxt:	The nbcon context from nbcon_context_try_acquire()
  */
-__maybe_unused
 static void nbcon_context_release(struct nbcon_context *ctxt)
 {
 	unsigned int cpu = smp_processor_id();
@@ -518,6 +517,112 @@ static void nbcon_context_release(struct nbcon_context *ctxt)
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
+/**
+ * nbcon_context_update_unsafe - Update the unsafe bit in @con->nbcon_state
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
+static bool nbcon_context_update_unsafe(struct nbcon_context *ctxt, bool unsafe)
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
  * @con:	Console to initialize
-- 
2.39.2

