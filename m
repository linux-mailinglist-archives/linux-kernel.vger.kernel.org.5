Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC007A057A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238880AbjINNX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbjINNX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:23:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CFC1BEB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:23:52 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D13B721845;
        Thu, 14 Sep 2023 13:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694697830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S0whYIHE/5eLeJ3EMarXUuv0HyhCOIzWe9eKez7ur68=;
        b=V/v17t12QMn5qMFut61XXPDPTyoslmwnKjYosG/y5xNNozG74yIJ/iN+bTSzN4BAuZw7SS
        NBXtwV+h+xLQXhKwiyTYxYz4SNW7Nv+VOpDKP0WJGRd93uBQa697VT1OmW2nchg7T3kIvV
        6IrtU0baug35gCtHIIQhJ5GwKZKZQvc=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9C08F2C142;
        Thu, 14 Sep 2023 13:23:50 +0000 (UTC)
Date:   Thu, 14 Sep 2023 15:23:50 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4 2+/8] printk: nbcon: Add acquire/release logic
Message-ID: <ZQMJZiPgfbIAlVqS@alley>
References: <20230908185008.468566-1-john.ogness@linutronix.de>
 <20230908185008.468566-3-john.ogness@linutronix.de>
 <ZQMHqJaNffsKFymG@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQMHqJaNffsKFymG@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

// This patch includes my proposed changes on top of
// https://lore.kernel.org/all/20230908185008.468566-3-john.ogness@linutronix.de/

Add per console acquire/release functionality.

The state of the console is maintained in the "nbcon_state" atomic
variable.

The console is locked when:

  - The 'prio' field contains the priority of the context that owns
    the console. Only a higher priority contexts are allowed
    to take over the lock. A value of 0 (NBCON_PRIO_NONE) means
    the console is not locked.

  - The 'cpu' field denotes on which CPU the console is locked.
    It is used to prevent busy waiting on the same CPU. Also it informs
    the lock owner that it has lost the lock in a more complex scenario
    when the lock was taken over by a higher priority context, released,
    and taken on another CPU with the same priority as the interrupted
    owner.

The acquire mechanism uses few more fields:

  - The 'req_prio' field is used by handover approach to make the current
    user aware that there a context with a higher priority waiting
    for the friendly handover.

  - The 'unsafe' field allows to take over the console a safe way in
    the middle of emitting a message. The filed is set only when accessing
    some shared resources or when the console device is manipulated.
    It can be cleared, for example, after emitting one character when
    the console device is in a consistent state.

  - The 'unsafe_takeover' field is set when a hostile takeover
    took the console in an unsafe state. The console will stay
    in the unsafe state until reinitialized.

The acquire mechanism uses three approaches:

  1) Direct acquire when the console is not owned or is owned by a
     lower priority context and is in a safe state.

  2) Friendly handover mechanism uses a request/grant handshake. It is used
     when the current owner has lower priority and the console is in
     an unsafe state.

     The requesting context:

       a) Sets its priority into the 'req_prio' field.

       b) Waits (with a timeout) for the owning context to unlock the
	     console.

       c) Takes the lock and clears the 'req_prio' field.

     The owning context:

       a) Observes the 'req_prio' field set on exit from the unsafe
	     console state.

       b) Gives up console ownership by clearing the 'prio' and 'cpu'
	     fields.

  3) Unsafe hostile takeover allows to take over the lock even when
     the console is an unsafe state. It is used only in panic() by
     the final attempt to flush consoles in a try and hope mode.

The release function simply clears the 'prio' and 'cpu' fields.

All operations on @console::nbcon_state are atomic cmpxchg based
to handle concurrency.

The acquire/release functions implement only minimal policies:

  - Preference for higher priority contexts.
  - Protection of the panic CPU.

All other policy decisions have to be made at the call sites:

  - What is marked as an unsafe section.
  - Whether to spin-wait if there is already an owner and the
    console is in an unsafe state.
  - Whether to attempt an unsafe hostile takeover.

The design allows to implement the well known:

    acquire()
    output_one_printk_record()
    release()

The output of one printk record might be interrupted with a higher
priority context. The new owner is supposed to reprint the entire
record from scratch.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
---
 include/linux/console.h |   9 +-
 kernel/printk/nbcon.c   | 390 +++++++++++++++++++++++-----------------
 2 files changed, 233 insertions(+), 166 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index eeebb82d6d07..98210fd01f18 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -218,12 +218,9 @@ static_assert(sizeof(struct nbcon_state) <= sizeof(int));
  * @NBCON_PRIO_PANIC:		Panic output
  * @NBCON_PRIO_MAX:		The number of priority levels
  *
- * A context wanting to produce emergency output can carefully takeover the
- * console, even without consent of the owner. Ideally such a takeover is only
- * when @nbcon_state::unsafe is not set. However, a context wanting to produce
- * panic output can ignore the unsafe flag as a last resort. If panic output
- * is active, no takeover is possible until the panic output releases the
- * console.
+ * A higher priority context can takeover the console when it is
+ * in the safe state. The final attempt to flush consoles in panic()
+ * can be allowed to do so even in an unsafe state (Hope and pray).
  */
 enum nbcon_prio {
 	NBCON_PRIO_NONE = 0,
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 57ddfb7f0994..10d2f8b4f86a 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -7,40 +7,98 @@
 #include <linux/delay.h>
 #include "internal.h"
 /*
- * Printk console printing implementation for consoles that do not depend on
+ * Printk console printing implementation for consoles which does not depend on
  * the legacy style console_lock mechanism.
  *
- * Console is locked on a CPU when @nbcon_state::prio is set and
- * @nbcon_state:cpu == current CPU. This is valid for the current execution
- * context.
+ * The state of the console is maintained in the "nbcon_state" atomic
+ * variable.
  *
- * Nesting execution contexts on the same CPU can carefully take over if
- * the driver allows reentrancy via @nbcon_state::unsafe = false. When the
- * interrupted context resumes it checks the state before entering an unsafe
- * region and aborts the operation if it detects a takeover.
+ * The console is locked when:
  *
- * In case of panic the nesting context can take over the console forcefully.
+ *   - The 'prio' field contains the priority of the context that owns
+ *     the console. Only a higher priority contexts are allowed
+ *     to take over the lock. A value of 0 (NBCON_PRIO_NONE) means
+ *     the console is not locked.
  *
- * A concurrent writer on a different CPU with a higher priority can directly
- * take over if the console is not in an unsafe state by carefully writing
- * its priority into @nbcon_state::prio.
+ *   - The 'cpu' field denotes on which CPU the console is locked.
+ *     It is used to prevent busy waiting on the same CPU. Also it informs
+ *     the lock owner that it has lost the lock in a more complex scenario
+ *     when the lock was taken over by a higher priority context, released,
+ *     and taken on another CPU with the same priority as the interrupted
+ *     owner.
  *
- * If the console is in an unsafe state, the concurrent writer with a higher
- * priority can request to take over the console by:
+ * The acquire mechanism uses few more fields:
  *
- *	1) Carefully writing the desired priority into @nbcon_state::req_prio
- *	   if there is no higher priority request pending.
+ *   - The 'req_prio' field is used by handover approach to make the current
+ *     user aware that there a context with a higher priority waiting
+ *     for the friendly handover.
  *
- *	2) Carefully spin on @nbcon_state::prio until it is no longer locked.
+ *   - The 'unsafe' field allows to take over the console a safe way in
+ *     the middle of emitting a message. The filed is set only when accessing
+ *     some shared resources or when the console device is manipulated.
+ *     It can be cleared, for example, after emitting one character when
+ *     the console device is in a consistent state.
  *
- *	3) Attempt to lock the console by carefully writing the desired
- *	   priority to @nbcon_state::prio and carefully removing the desired
- *	   priority from @nbcon_state::req_prio.
+ *   - The 'unsafe_takeover' field is set when a hostile takeover
+ *     took the console in an unsafe state. The console will stay
+ *     in the unsafe state until reinitialized.
  *
- * In case the owner does not react on the request and does not make
- * observable progress, the waiter will timeout and can then decide to do
- * an unsafe hostile takeover. Upon unsafe hostile takeover, the console
- * is kept permanently in the unsafe state.
+ * The acquire mechanism uses three approaches:
+ *
+ *   1) Direct acquire when the console is not owned or is owned by a
+ *      lower priority context and is in a safe state.
+ *
+ *   2) Friendly handover mechanism uses a request/grant handshake. It is used
+ *      when the current owner has lower priority and the console is in
+ *      an unsafe state.
+ *
+ *      The requesting context:
+ *
+ *        a) Sets its priority into the 'req_prio' field.
+ *
+ *        b) Waits (with a timeout) for the owning context to unlock the
+ *	     console.
+ *
+ *        c) Takes the lock and clears the 'req_prio' field.
+ *
+ *      The owning context:
+ *
+ *        a) Observes the 'req_prio' field set on exit from the unsafe
+ *	     console state.
+ *
+ *        b) Gives up console ownership by clearing the 'prio' and 'cpu'
+ *	     fields.
+ *
+ *   3) Unsafe hostile takeover allows to take over the lock even when
+ *      the console is an unsafe state. It is used only in panic() by
+ *      the final attempt to flush consoles in a try and hope mode.
+ *
+ * The release function simply clears the 'prio' and 'cpu' fields.
+ *
+ * All operations on @console::nbcon_state are atomic cmpxchg based
+ * to handle concurrency.
+ *
+ * The acquire/release functions implement only minimal policies:
+ *
+ *   - Preference for higher priority contexts.
+ *   - Protection of the panic CPU.
+ *
+ * All other policy decisions have to be made at the call sites:
+ *
+ *   - What is marked as an unsafe section.
+ *   - Whether to spin-wait if there is already an owner and the
+ *     console is in an unsafe state.
+ *   - Whether to attempt an unsafe hostile takeover.
+ *
+ * The design allows to implement the well known:
+ *
+ *     acquire()
+ *     output_one_printk_record()
+ *     release()
+ *
+ * The output of one printk record might be interrupted with a higher
+ * priority context. The new owner is supposed to reprint the entire
+ * record from scratch.
  */
 
 /**
@@ -85,22 +143,22 @@ static inline bool nbcon_state_try_cmpxchg(struct console *con, struct nbcon_sta
  * @ctxt:	The context of the caller
  * @cur:	The current console state
  *
- * Return:	0 on success and @cur is updated to the new console state.
- *		Otherwise an error code on failure.
+ * Acquire the console when it is released. Also acquire the console when
+ * the current owner has a lower priority and the console is in a safe state.
+ *
+ * Return:	0 on success. Otherwise, an error code on failure. Also @cur
+ *		is updated to the latest state when failed to modify it.
  *
  * Errors:
  *
- *	-EPERM:		A panic is in progress and this is not the panic CPU
- *			or this context does not have a priority above the
- *			current owner or waiter. No acquire method can be
- *			successful for this context.
+ *	-EPERM:		A panic is in progress and this is not the panic CPU.
+ *			Or the current owner or waiter has the same or higher
+ *			priority. No acquire method can be successful in
+ *			this case.
  *
- *	-EBUSY:		The console is in an unsafe state. The caller should
- *			try using the handover acquire method.
- *
- * The general procedure is to change @nbcon_state::prio from unowned to
- * owned. Or, if the console is not in the unsafe state, to change
- * @nbcon_state::prio to a higher priority owner.
+ *	-EBUSY:		The current owner has a lower priority but the console
+ *			in an unsafe state. The caller should try using
+ *			the handover acquire method.
  */
 static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
 					    struct nbcon_state *cur)
@@ -133,8 +191,6 @@ static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
 
 	} while (!nbcon_state_try_cmpxchg(con, cur, &new));
 
-	cur->atom = new.atom;
-
 	return 0;
 }
 
@@ -166,20 +222,23 @@ static bool nbcon_waiter_matches(struct nbcon_state *cur, int expected_prio)
  * @ctxt:	The context of the caller
  * @cur:	The current console state
  *
+ * This is a helper function for nbcon_context_try_acquire_handover().
+ * It is called when the console is in an unsafe state. The current
+ * owner will release the console on exit from the unsafe region.
+ *
  * Return:	0 on success and @cur is updated to the new console state.
  *		Otherwise an error code on failure.
  *
  * Errors:
  *
  *	-EPERM:		A panic is in progress and this is not the panic CPU
- *			or this context is no longer the waiter. For the
- *			former case, the caller must carefully remove the
- *			request before aborting the acquire.
+ *			or this context is no longer the waiter.
  *
  *	-EBUSY:		The console is still locked. The caller should
  *			continue waiting.
  *
- * This is a helper function for nbcon_context_try_acquire_handover().
+ * Note: The caller must still remove the request when an error has occurred
+ *       except when this context is no longer the waiter.
  */
 static int nbcon_context_try_acquire_requested(struct nbcon_context *ctxt,
 					       struct nbcon_state *cur)
@@ -188,47 +247,40 @@ static int nbcon_context_try_acquire_requested(struct nbcon_context *ctxt,
 	struct console *con = ctxt->console;
 	struct nbcon_state new;
 
-	do {
+	/* Note that the caller must still remove the request! */
+	if (other_cpu_in_panic())
+		return -EPERM;
+
+	if (!nbcon_waiter_matches(cur, ctxt->prio))
+		return -EPERM;
+
+	/* If still locked, caller should continue waiting. */
+	if (cur->prio != NBCON_PRIO_NONE)
+		return -EBUSY;
+
+	/*
+	 * The previous owner should have never released ownership
+	 * in an unsafe region. And this function should not be
+	 * called when the 'unsafe_takeover' is set.
+	 */
+	WARN_ON_ONCE(cur->unsafe);
+
+	new.atom = cur->atom;
+	new.prio	= ctxt->prio;
+	new.req_prio	= NBCON_PRIO_NONE;
+	new.unsafe	= cur->unsafe_takeover;
+	new.cpu		= cpu;
+
+	if (!nbcon_state_try_cmpxchg(con, cur, &new)) {
 		/*
-		 * Note: If the acquire is aborted due to a panic CPU,
-		 * the caller must still remove the request!
+		 * The acquire could fail only when it has been taken
+		 * over by a higher priority context.
 		 */
-		if (other_cpu_in_panic())
-			return -EPERM;
-
-		/*
-		 * If an unsafe hostile takeover has occurred, a handover
-		 * is no longer possible.
-		 */
-		if (cur->unsafe_takeover)
-			return -EPERM;
-
-		/* Is this context still the requester? */
-		if (!nbcon_waiter_matches(cur, ctxt->prio))
-			return -EPERM;
-
-		/* If still locked, caller should continue waiting. */
-		if (cur->prio != NBCON_PRIO_NONE)
-			return -EBUSY;
-
-		/*
-		 * The previous owner should have never released ownership
-		 * in an unsafe region.
-		 */
-		WARN_ON_ONCE(cur->unsafe);
-
-		new.atom = cur->atom;
-		new.prio	= ctxt->prio;
-		new.req_prio	= NBCON_PRIO_NONE;
-		new.unsafe	= cur->unsafe_takeover;
-		new.cpu		= cpu;
-
-	} while (!nbcon_state_try_cmpxchg(con, cur, &new));
+		WARN_ON_ONCE(nbcon_waiter_matches(cur, ctxt->prio));
+		return -EPERM;
+	}
 
 	/* Handover success. This context now owns the console. */
-
-	cur->atom = new.atom;
-
 	return 0;
 }
 
@@ -237,30 +289,37 @@ static int nbcon_context_try_acquire_requested(struct nbcon_context *ctxt,
  * @ctxt:	The context of the caller
  * @cur:	The current console state
  *
- * Return:	0 on success and @cur is updated to the new console state.
- *		Otherwise an error code on failure.
+ * The function must be called only when the context has higher priority
+ * than the current owner and the console is in an unsafe state.
+ * It is the case when nbcon_context_try_acquire_direct() returns -EBUSY.
+ *
+ * The function sets "req_prio" field to make the current owner aware of
+ * the request. Then it waits until the current context until the current
+ * owner releases the console, or even higher context takes over the request,
+ * or timeout expires.
+ *
+ * The current owner checks the "req_prio" field on exit from the unsafe
+ * region and releases the console. It does not touch "req_prio" filed
+ * so that the console stays reserved for the waiter.
+ *
+ * Return:	0 on success. Otherwise, an error code on failure. Also @cur
+ *		is updated to the latest state when failed to modify it.
  *
  * Errors:
  *
- *	-EPERM:		This context is on the same CPU as the current owner
- *			or the console is permanently in an unsafe state or
- *			this context is unwilling to wait or a panic is in
- *			progress and this is not the panic CPU. This is not
- *			the panic context, so no acquire method can be
- *			successful for this context.
+ *	-EPERM:		A panic is in progress and this is not the panic CPU.
+ *			A higher priority context has taken over the console
+ *			or the handover request.
  *
- *	-EBUSY:		The current owner or waiter is such that this context
- *			is not able to execute a handover. The caller can use
- *			an unsafe hostile takeover to acquire.
+ *	-EBUSY:		The current owner is on the same CPU so that the hand
+ *			shake could not work. The current owner is not willing
+ *			to wait (zero timeout). The console does not enter
+ *			the safe state before timeout passed. The caller
+ *			might still use the unsafe hostile takeover when
+ *			allowed.
  *
- *	-EAGAIN:	@cur is not the current console state. @cur has been
- *			updated. The caller should retry with direct acquire.
- *
- * The general procedure is to set @req_prio and wait until unowned. Then
- * set @prio (claiming ownership) and clearing @req_prio.
- *
- * Note that it is expected that the caller tried
- * nbcon_context_try_acquire_direct() with @cur before calling this function.
+ *	-EAGAIN:	@cur has changed when creating the handover request.
+ *			The caller should retry with direct acquire.
  */
 static int nbcon_context_try_acquire_handover(struct nbcon_context *ctxt,
 					      struct nbcon_state *cur)
@@ -269,20 +328,35 @@ static int nbcon_context_try_acquire_handover(struct nbcon_context *ctxt,
 	struct console *con = ctxt->console;
 	struct nbcon_state new;
 	int timeout;
-	int err = 0;
+	int request_err = -EBUSY;
 
 	/*
-	 * Handovers are not possible on the same CPU or when the console
-	 * is permanently in an unsafe state or if the caller is unwilling
-	 * to wait.
+	 * Check that the handover is called when the direct acquire failed
+	 * with -EBUSY.
 	 */
-	if (cur->cpu == cpu ||
-	    cur->unsafe_takeover ||
-	    ctxt->spinwait_max_us == 0) {
-		goto fail_handover;
-	}
+	WARN_ON_ONCE(ctxt->prio <= cur->prio || ctxt->prio <= cur->req_prio);
+	WARN_ON_ONCE(!cur->unsafe);
 
-	/* Setup a request for handover. */
+	/* Handover is not possible on the same CPU. */
+	if (cur->cpu == cpu)
+		return -EBUSY;
+
+	/*
+	 * Console stays unsafe after an unsafe takeover until re-initialized.
+	 * Waiting is not going to help in this case.
+	 */
+	if (cur->unsafe_takeover)
+		return -EBUSY;
+
+	/* Is the caller willing to wait? */
+	if (ctxt->spinwait_max_us == 0)
+		return -EBUSY;
+
+
+	/*
+	 * Setup a request for the handover. The caller should try to acquire
+	 * the conosle directly when the current state has been modified.
+	 */
 	new.atom = cur->atom;
 	new.req_prio = ctxt->prio;
 	if (!nbcon_state_try_cmpxchg(con, cur, &new))
@@ -290,18 +364,18 @@ static int nbcon_context_try_acquire_handover(struct nbcon_context *ctxt,
 
 	cur->atom = new.atom;
 
-	/* Wait until there is no owner and then acquire directly. */
+	/* Wait until there is no owner and then acquire the console. */
 	for (timeout = ctxt->spinwait_max_us; timeout >= 0; timeout--) {
 		/* On successful acquire, this request is cleared. */
-		err = nbcon_context_try_acquire_requested(ctxt, cur);
-		if (!err)
+		request_err = nbcon_context_try_acquire_requested(ctxt, cur);
+		if (!request_err)
 			return 0;
 
 		/*
 		 * If the acquire should be aborted, it must be ensured
 		 * that the request is removed before returning to caller.
 		 */
-		if (err == -EPERM)
+		if (request_err == -EPERM)
 			break;
 
 		udelay(1);
@@ -310,11 +384,11 @@ static int nbcon_context_try_acquire_handover(struct nbcon_context *ctxt,
 		nbcon_state_read(con, cur);
 	}
 
-	/* Timed out or should abort. Carefully remove handover request. */
+	/* Timed out or aborted. Carefully remove handover request. */
 	do {
 		/* No need to remove request if there is a new waiter. */
 		if (!nbcon_waiter_matches(cur, ctxt->prio))
-			goto fail_handover;
+			return -EPERM;
 
 		/* Unset request for handover. */
 		new.atom = cur->atom;
@@ -325,7 +399,7 @@ static int nbcon_context_try_acquire_handover(struct nbcon_context *ctxt,
 			 * acquiring via handover.
 			 */
 			cur->atom = new.atom;
-			goto fail_handover;
+			return request_err;
 		}
 
 		/*
@@ -334,40 +408,48 @@ static int nbcon_context_try_acquire_handover(struct nbcon_context *ctxt,
 		 */
 	} while (nbcon_context_try_acquire_requested(ctxt, cur));
 
-	/* Acquire at timeout succeeded! */
+	/* Lucky timing. The acquire succeeded while removing the request. */
 	return 0;
-
-fail_handover:
-	/*
-	 * If this is the panic context, the caller can try to acquire using
-	 * the unsafe hostile takeover method.
-	 */
-	if (ctxt->prio == NBCON_PRIO_PANIC &&
-	    ctxt->prio > cur->prio &&
-	    ctxt->prio > cur->req_prio &&
-	    !other_cpu_in_panic()) {
-		return -EBUSY;
-	}
-	return -EPERM;
 }
 
 /**
- * nbcon_context_acquire_hostile - Acquire via unsafe hostile takeover
+ * nbcon_context_try_acquire_hostile - Acquire via unsafe hostile takeover
  * @ctxt:	The context of the caller
  * @cur:	The current console state
  *
- * @cur is updated to the new console state.
+ * Acquire the console even in the unsafe state.
  *
- * The general procedure is to set @prio (forcing ownership). This method
- * must only be used as a final attempt during panic.
+ * It can be permitted by setting the 'allow_unsafe_takeover' field only
+ * by the final attempt to flush messages in panic().
+ *
+ * Return:	0 on success. -EPERM when not allowed by the context.
  */
-static void nbcon_context_acquire_hostile(struct nbcon_context *ctxt,
-					  struct nbcon_state *cur)
+static int nbcon_context_try_acquire_hostile(struct nbcon_context *ctxt,
+					     struct nbcon_state *cur)
 {
 	unsigned int cpu = smp_processor_id();
 	struct console *con = ctxt->console;
 	struct nbcon_state new;
 
+	if (!ctxt->allow_unsafe_takeover)
+		return -EPERM;
+
+	/*
+	 * Check that the system is going to die and lower priorities will
+	 * always be ignored. Using an unsafe consoles could break the running
+	 * system. Also switching back to lower priorities would create a race
+	 * in nbcon_waiter_matches().
+	 */
+	if (WARN_ON_ONCE(ctxt->prio != NBCON_PRIO_PANIC))
+		return -EPERM;
+
+	/*
+	 * Check that try_acquire_direct() and try_acquire_handover() returned
+	 * -EBUSY in the right situation.
+	 */
+	WARN_ON_ONCE(ctxt->prio <= cur->prio || ctxt->prio <= cur->req_prio);
+	WARN_ON_ONCE(cur->unsafe != true);
+
 	do {
 		new.atom = cur->atom;
 		new.cpu			= cpu;
@@ -377,7 +459,7 @@ static void nbcon_context_acquire_hostile(struct nbcon_context *ctxt,
 
 	} while (!nbcon_state_try_cmpxchg(con, cur, &new));
 
-	cur->atom = new.atom;
+	return 0;
 }
 
 /**
@@ -400,33 +482,21 @@ static bool nbcon_context_try_acquire(struct nbcon_context *ctxt)
 	struct nbcon_state cur;
 	int err;
 
-	/* unsafe hostile takeovers are only allowed for panic */
-	WARN_ON_ONCE(ctxt->allow_unsafe_takeover && (ctxt->prio != NBCON_PRIO_PANIC));
-
 	nbcon_state_read(con, &cur);
+try_again:
+	err = nbcon_context_try_acquire_direct(ctxt, &cur);
+	if (err != -EBUSY)
+		goto out;
 
-	do {
-		err = nbcon_context_try_acquire_direct(ctxt, &cur);
-		if (!err)
-			goto success;
-		else if (err == -EPERM)
-			return false;
+	err = nbcon_context_try_acquire_handover(ctxt, &cur);
+	if (err == -EAGAIN)
+		goto try_again;
+	if (err != -EBUSY)
+		goto out;
 
-		err = nbcon_context_try_acquire_handover(ctxt, &cur);
-		if (!err)
-			goto success;
-		else if (err == -EPERM)
-			return false;
-
-	} while (err == -EAGAIN);
-
-	/* Only attempt unsafe hostile takeover if explicitly requested. */
-	if (!ctxt->allow_unsafe_takeover)
-		return false;
-
-	nbcon_context_acquire_hostile(ctxt, &cur);
-success:
-	return true;
+	err = nbcon_context_try_acquire_hostile(ctxt, &cur);
+out:
+	return !err;
 }
 
 static bool nbcon_owner_matches(struct nbcon_state *cur, int expected_cpu,
-- 
2.35.3

