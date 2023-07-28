Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBB476607A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 02:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjG1ADE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 20:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjG1ACp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 20:02:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024BAFA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 17:02:42 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690502558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lzKIhztjxshdapDIJ3AGdBj3vg17a8NsL1htiDJV/M4=;
        b=tHN90uawbFBFjdj0vVJAMNJ+QybnaTFkpLt92HjBaa0/GLBhQqBnQHVRKQZ3pK7n9K31PI
        sD3V0aEIVNC2d6yD42OZt7FCtff81/8KvxpINHh3yHHi819kYTDxavSJGgB3UVQ5JzA5Di
        nT3xfo6a6bzuCanhAzpiqvAEDakdys2670nc6YGyB/r6OFptA8CD6zB/FJ96onesCaTwZs
        BfHzXDfR9bwKPyfx44iK7jUBSggdFwxz4/fwuJy1YMV0GLo0DvMgIUYSGxZTkQMbkzr38U
        408YmFJHxVf8pujLV94e3pUjiUKf4MtgP4nfYKJU2VY7ogG8pPgDywikTc1DOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690502558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lzKIhztjxshdapDIJ3AGdBj3vg17a8NsL1htiDJV/M4=;
        b=iz4gHIhd7TSH/GZ8ZRC+eRBVwFHwCZNwztT2vCiqIAHOClz0TiWOcDRMRQ+SGSYIr+QnGL
        HJ5gGyyeQK/L47DQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 6/8] printk: nbcon: Add ownership state functions
Date:   Fri, 28 Jul 2023 02:08:31 +0206
Message-Id: <20230728000233.50887-7-john.ogness@linutronix.de>
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

Provide functions that are related to the safe handover mechanism
and allow console drivers to dynamically specify unsafe regions:

 - nbcon_context_can_proceed()

   Invoked by a console owner to check whether a handover request
   is pending or whether the console was taken over in a hostile
   fashion. If a handover request is pending, this function will
   also perform the handover, thus cancelling its own ownership.

 - nbcon_context_update_unsafe()

   Invoked by a console owner to denote that the driver is about
   to enter or leave a critical region where a hostile take over
   is unsafe. This function is also a cancellation point where
   loss of ownership can occur.

   The unsafe state is stored in the console state and allows a
   new context to make informed decisions whether to attempt a
   takeover of such a console. The unsafe state is also available
   to the driver so that it can make informed decisions about the
   required actions or take a special emergency path.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
---
 kernel/printk/printk_nbcon.c | 113 ++++++++++++++++++++++++++++++++++-
 1 file changed, 112 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk_nbcon.c b/kernel/printk/printk_nbcon.c
index 8229a0a00d5b..e41f2eff5ef6 100644
--- a/kernel/printk/printk_nbcon.c
+++ b/kernel/printk/printk_nbcon.c
@@ -623,7 +623,6 @@ static bool nbcon_owner_matches(struct nbcon_state *cur, int expected_cpu,
  * nbcon_context_release - Release the console
  * @ctxt:	The nbcon context from nbcon_context_try_acquire()
  */
-__maybe_unused
 static void nbcon_context_release(struct nbcon_context *ctxt)
 {
 	unsigned int cpu = smp_processor_id();
@@ -650,6 +649,118 @@ static void nbcon_context_release(struct nbcon_context *ctxt)
 	ctxt->pbufs = NULL;
 }
 
+/**
+ * nbcon_context_can_proceed - Check whether ownership can proceed
+ * @ctxt:	The nbcon context from nbcon_context_try_acquire()
+ * @cur:	The current console state
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
+static bool nbcon_context_can_proceed(struct nbcon_context *ctxt, struct nbcon_state *cur)
+{
+	unsigned int cpu = smp_processor_id();
+
+	/* Make sure this context is still the owner. */
+	if (!nbcon_owner_matches(cur, cpu, ctxt->prio)) {
+		debug_store(1, "handover: cpu%d DETECTED HOSTILE takeover\n", cpu);
+		return false;
+	}
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
+	if (cur->unsafe) {
+		debug_store(cur->req_prio > cur->prio,
+			    "handover: cpu%d IGNORING HANDOVER prio%d -> prio%d (unsafe)\n",
+			    cpu, cur->prio, cur->req_prio);
+		return true;
+	}
+
+	/* Waiters always have higher priorities than owners. */
+	WARN_ON_ONCE(cur->req_prio <= cur->prio);
+
+	debug_store(1, "handover: cpu%d HANDING OVER prio%d -> prio%d\n",
+		    cpu, cur->prio, cur->req_prio);
+
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
+ * Return:	True if the state is correct. False if ownership was
+ *		handed over or taken.
+ *
+ * Typically the unsafe bit is set during acquire. This function allows
+ * modifying the unsafe status without releasing ownership.
+ *
+ * When this function returns false then the calling context is no longer
+ * the owner and is no longer allowed to go forward. In this case it must
+ * back out immediately and carefully. The buffer content is also no longer
+ * trusted since it no longer belongs to the calling context.
+ *
+ * Internal helper to avoid duplicated code
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
+	/* The unsafe bit must not be cleared if @hostile_unsafe is set. */
+	if (!unsafe && cur.hostile_unsafe)
+		return nbcon_context_can_proceed(ctxt, &cur);
+
+	do {
+		if (!nbcon_context_can_proceed(ctxt, &cur))
+			return false;
+
+		new.atom = cur.atom;
+		new.unsafe = unsafe;
+	} while (!nbcon_state_try_cmpxchg(con, &cur, &new));
+
+	ctxt->unsafe = unsafe;
+
+	return true;
+}
+
 /**
  * nbcon_init - Initialize the nbcon console specific data
  * @con:	Console to initialize
-- 
2.39.2

