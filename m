Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDE5798E6C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbjIHSwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbjIHSw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:52:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E969A10DF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 11:51:50 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694199011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TdUHXK7rHc3QLzmoCiD54LJLsZOtaL7RAJcGFdO6SFw=;
        b=Ht5tYfsaRbAhJ7aq1/mymaDWSDXdqnngiA2kmU/h3czwVts+VsCLdE4ryVQuiG7NxqVz0r
        NzCb1MyEewdTgUNQPtPhN2itgcyQ3qSPiQISctE16daojF+jaRgFa5xhDSp7Wm4cIm8fdx
        JTchfLw/2qkMn8hWA1O4yLan8E/MXI/R8nwSp4ONwKNOo/qzLLORv13+K8Xbz6ZxAp87Nv
        BIsimb0bTcsQ4uM7iOQwMgwZxvhpM2MYlkAkABHA9SUfwkDdkkF+RmrILoXQNnOKk7u7OE
        EYwB51fhH6NbyjisUAd4ck3fuV/RdO3biOcv/SArexECVzun68W5O9rxJkExzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694199011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TdUHXK7rHc3QLzmoCiD54LJLsZOtaL7RAJcGFdO6SFw=;
        b=/RzsUK5atHOhSTF/Fvq4J8t92BgGY4HMbDY9RJVj9hFsawJ/KWPZKkUFBJbZ6EJzI4RR4b
        TWg4gbsUaVRkK3DQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v4 2/8] printk: nbcon: Add acquire/release logic
Date:   Fri,  8 Sep 2023 20:56:02 +0206
Message-Id: <20230908185008.468566-3-john.ogness@linutronix.de>
In-Reply-To: <20230908185008.468566-1-john.ogness@linutronix.de>
References: <20230908185008.468566-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Add per console acquire/release functionality. The console 'locked'
state is a combination of multiple state fields:

  - The 'prio' field contains the priority of the context that owns
    the console. This field is used for decisions whether to attempt
    friendly handovers and also prevents takeovers from a less
    severe context, e.g. to protect the panic CPU. A value of 0
    (NBCON_PRIO_NONE) means the console is not locked.

  - The 'cpu' field denotes on which CPU the console is locked.

The acquire mechanism comes with several flavours:

  - Direct acquire when the console is not owned or is owned by a
    lower priority context and the console is in a safe state.

  - Friendly handover mechanism based on a request/grant handshake.
    The requesting context must have a higher priority than the
    current owner.

    The requesting context:

      1) Sets its priority into the 'req_prio' field.

      2) Waits (with a timeout) for the owning context to unlock the
         console.

      3) Sets the 'prio' field and clears the 'req_prio' field.

    The owning context:

      1) Observes the 'req_prio' field set.

      2) Gives up console ownership by clearing the 'prio' field.

  - Unsafe hostile takeover

      The new owner takes the console over without 'req_prio'
      handshake. The new owner must have a higher priority than
      the previous owner.

      This is required when friendly handovers are not possible,
      i.e. the higher priority context interrupted the owning
      context on the same CPU or the owning context is not able
      to make progress on a remote CPU.

The release is the counterpart that either releases the console
directly or yields it gracefully over to a requester.

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
    output_one_line()
    release()

algorithm, but also allows to avoid the per line acquire/release for
e.g. panic situations by doing the acquire once and then relying on
the panic CPU protection for the rest.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
---
 include/linux/console.h |  59 ++++++
 kernel/printk/nbcon.c   | 432 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 491 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index a2d37a7a98a8..eeebb82d6d07 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -175,13 +175,29 @@ enum cons_flags {
  * struct nbcon_state - console state for nbcon consoles
  * @atom:	Compound of the state fields for atomic operations
  *
+ * @req_prio:		The priority of a handover request
+ * @prio:		The priority of the current owner
+ * @unsafe:		Console is busy in a non takeover region
+ * @unsafe_takeover:	A hostile takeover in an unsafe state happened in the
+ *			past. The console cannot be safe until re-initialized.
+ * @cpu:		The CPU on which the owner runs
+ *
  * To be used for reading and preparing of the value stored in the nbcon
  * state variable @console::nbcon_state.
+ *
+ * The @prio and @req_prio fields are particularly important to allow
+ * spin-waiting to timeout and give up without the risk of a waiter being
+ * assigned the lock after giving up.
  */
 struct nbcon_state {
 	union {
 		unsigned int	atom;
 		struct {
+			unsigned int prio		:  2;
+			unsigned int req_prio		:  2;
+			unsigned int unsafe		:  1;
+			unsigned int unsafe_takeover	:  1;
+			unsigned int cpu		: 24;
 		};
 	};
 };
@@ -194,6 +210,49 @@ struct nbcon_state {
  */
 static_assert(sizeof(struct nbcon_state) <= sizeof(int));
 
+/**
+ * nbcon_prio - console owner priority for nbcon consoles
+ * @NBCON_PRIO_NONE:		Unused
+ * @NBCON_PRIO_NORMAL:		Normal (non-emergency) usage
+ * @NBCON_PRIO_EMERGENCY:	Emergency output (WARN/OOPS...)
+ * @NBCON_PRIO_PANIC:		Panic output
+ * @NBCON_PRIO_MAX:		The number of priority levels
+ *
+ * A context wanting to produce emergency output can carefully takeover the
+ * console, even without consent of the owner. Ideally such a takeover is only
+ * when @nbcon_state::unsafe is not set. However, a context wanting to produce
+ * panic output can ignore the unsafe flag as a last resort. If panic output
+ * is active, no takeover is possible until the panic output releases the
+ * console.
+ */
+enum nbcon_prio {
+	NBCON_PRIO_NONE = 0,
+	NBCON_PRIO_NORMAL,
+	NBCON_PRIO_EMERGENCY,
+	NBCON_PRIO_PANIC,
+	NBCON_PRIO_MAX,
+};
+
+struct console;
+
+/**
+ * struct nbcon_context - Context for console acquire/release
+ * @console:			The associated console
+ * @spinwait_max_us:		Limit for spin-wait acquire
+ * @prio:			Priority of the context
+ * @allow_unsafe_takeover:	Allow performing takeover even if unsafe. Can
+ *				be used only with NBCON_PRIO_PANIC @prio. It
+ *				might cause a system freeze when the console
+ *				is used later.
+ */
+struct nbcon_context {
+	/* members set by caller */
+	struct console		*console;
+	unsigned int		spinwait_max_us;
+	enum nbcon_prio		prio;
+	unsigned int		allow_unsafe_takeover	: 1;
+};
+
 /**
  * struct console - The console descriptor structure
  * @name:		The name of the console driver
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 10266d3e7883..57ddfb7f0994 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -4,10 +4,43 @@
 
 #include <linux/kernel.h>
 #include <linux/console.h>
+#include <linux/delay.h>
 #include "internal.h"
 /*
  * Printk console printing implementation for consoles that do not depend on
  * the legacy style console_lock mechanism.
+ *
+ * Console is locked on a CPU when @nbcon_state::prio is set and
+ * @nbcon_state:cpu == current CPU. This is valid for the current execution
+ * context.
+ *
+ * Nesting execution contexts on the same CPU can carefully take over if
+ * the driver allows reentrancy via @nbcon_state::unsafe = false. When the
+ * interrupted context resumes it checks the state before entering an unsafe
+ * region and aborts the operation if it detects a takeover.
+ *
+ * In case of panic the nesting context can take over the console forcefully.
+ *
+ * A concurrent writer on a different CPU with a higher priority can directly
+ * take over if the console is not in an unsafe state by carefully writing
+ * its priority into @nbcon_state::prio.
+ *
+ * If the console is in an unsafe state, the concurrent writer with a higher
+ * priority can request to take over the console by:
+ *
+ *	1) Carefully writing the desired priority into @nbcon_state::req_prio
+ *	   if there is no higher priority request pending.
+ *
+ *	2) Carefully spin on @nbcon_state::prio until it is no longer locked.
+ *
+ *	3) Attempt to lock the console by carefully writing the desired
+ *	   priority to @nbcon_state::prio and carefully removing the desired
+ *	   priority from @nbcon_state::req_prio.
+ *
+ * In case the owner does not react on the request and does not make
+ * observable progress, the waiter will timeout and can then decide to do
+ * an unsafe hostile takeover. Upon unsafe hostile takeover, the console
+ * is kept permanently in the unsafe state.
  */
 
 /**
@@ -47,6 +80,405 @@ static inline bool nbcon_state_try_cmpxchg(struct console *con, struct nbcon_sta
 	return atomic_try_cmpxchg(&ACCESS_PRIVATE(con, nbcon_state), &cur->atom, new->atom);
 }
 
+/**
+ * nbcon_context_try_acquire_direct - Try to acquire directly
+ * @ctxt:	The context of the caller
+ * @cur:	The current console state
+ *
+ * Return:	0 on success and @cur is updated to the new console state.
+ *		Otherwise an error code on failure.
+ *
+ * Errors:
+ *
+ *	-EPERM:		A panic is in progress and this is not the panic CPU
+ *			or this context does not have a priority above the
+ *			current owner or waiter. No acquire method can be
+ *			successful for this context.
+ *
+ *	-EBUSY:		The console is in an unsafe state. The caller should
+ *			try using the handover acquire method.
+ *
+ * The general procedure is to change @nbcon_state::prio from unowned to
+ * owned. Or, if the console is not in the unsafe state, to change
+ * @nbcon_state::prio to a higher priority owner.
+ */
+static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
+					    struct nbcon_state *cur)
+{
+	unsigned int cpu = smp_processor_id();
+	struct console *con = ctxt->console;
+	struct nbcon_state new;
+
+	do {
+		if (other_cpu_in_panic())
+			return -EPERM;
+
+		if (ctxt->prio <= cur->prio || ctxt->prio <= cur->req_prio)
+			return -EPERM;
+
+		if (cur->unsafe)
+			return -EBUSY;
+
+		/*
+		 * The console should never be safe for a direct acquire
+		 * if an unsafe hostile takeover has ever happened.
+		 */
+		WARN_ON_ONCE(cur->unsafe_takeover);
+
+		new.atom = cur->atom;
+		new.prio	= ctxt->prio;
+		new.req_prio	= NBCON_PRIO_NONE;
+		new.unsafe	= cur->unsafe_takeover;
+		new.cpu		= cpu;
+
+	} while (!nbcon_state_try_cmpxchg(con, cur, &new));
+
+	cur->atom = new.atom;
+
+	return 0;
+}
+
+static bool nbcon_waiter_matches(struct nbcon_state *cur, int expected_prio)
+{
+	/*
+	 * The request context is well defined by the @req_prio because:
+	 *
+	 * - Only a context with a higher priority can take over the request.
+	 * - There are only three priorities.
+	 * - Only one CPU is allowed to request PANIC priority.
+	 * - Lower priorities are ignored during panic() until reboot.
+	 *
+	 * As a result, the following scenario is *not* possible:
+	 *
+	 * 1. Another context with a higher priority directly takes ownership.
+	 * 2. The higher priority context releases the ownership.
+	 * 3. A lower priority context takes the ownership.
+	 * 4. Another context with the same priority as this context
+	 *    creates a request and starts waiting.
+	 */
+
+	return (cur->req_prio == expected_prio);
+}
+
+/**
+ * nbcon_context_try_acquire_requested - Try to acquire after having
+ *					 requested a handover
+ * @ctxt:	The context of the caller
+ * @cur:	The current console state
+ *
+ * Return:	0 on success and @cur is updated to the new console state.
+ *		Otherwise an error code on failure.
+ *
+ * Errors:
+ *
+ *	-EPERM:		A panic is in progress and this is not the panic CPU
+ *			or this context is no longer the waiter. For the
+ *			former case, the caller must carefully remove the
+ *			request before aborting the acquire.
+ *
+ *	-EBUSY:		The console is still locked. The caller should
+ *			continue waiting.
+ *
+ * This is a helper function for nbcon_context_try_acquire_handover().
+ */
+static int nbcon_context_try_acquire_requested(struct nbcon_context *ctxt,
+					       struct nbcon_state *cur)
+{
+	unsigned int cpu = smp_processor_id();
+	struct console *con = ctxt->console;
+	struct nbcon_state new;
+
+	do {
+		/*
+		 * Note: If the acquire is aborted due to a panic CPU,
+		 * the caller must still remove the request!
+		 */
+		if (other_cpu_in_panic())
+			return -EPERM;
+
+		/*
+		 * If an unsafe hostile takeover has occurred, a handover
+		 * is no longer possible.
+		 */
+		if (cur->unsafe_takeover)
+			return -EPERM;
+
+		/* Is this context still the requester? */
+		if (!nbcon_waiter_matches(cur, ctxt->prio))
+			return -EPERM;
+
+		/* If still locked, caller should continue waiting. */
+		if (cur->prio != NBCON_PRIO_NONE)
+			return -EBUSY;
+
+		/*
+		 * The previous owner should have never released ownership
+		 * in an unsafe region.
+		 */
+		WARN_ON_ONCE(cur->unsafe);
+
+		new.atom = cur->atom;
+		new.prio	= ctxt->prio;
+		new.req_prio	= NBCON_PRIO_NONE;
+		new.unsafe	= cur->unsafe_takeover;
+		new.cpu		= cpu;
+
+	} while (!nbcon_state_try_cmpxchg(con, cur, &new));
+
+	/* Handover success. This context now owns the console. */
+
+	cur->atom = new.atom;
+
+	return 0;
+}
+
+/**
+ * nbcon_context_try_acquire_handover - Try to acquire via handover
+ * @ctxt:	The context of the caller
+ * @cur:	The current console state
+ *
+ * Return:	0 on success and @cur is updated to the new console state.
+ *		Otherwise an error code on failure.
+ *
+ * Errors:
+ *
+ *	-EPERM:		This context is on the same CPU as the current owner
+ *			or the console is permanently in an unsafe state or
+ *			this context is unwilling to wait or a panic is in
+ *			progress and this is not the panic CPU. This is not
+ *			the panic context, so no acquire method can be
+ *			successful for this context.
+ *
+ *	-EBUSY:		The current owner or waiter is such that this context
+ *			is not able to execute a handover. The caller can use
+ *			an unsafe hostile takeover to acquire.
+ *
+ *	-EAGAIN:	@cur is not the current console state. @cur has been
+ *			updated. The caller should retry with direct acquire.
+ *
+ * The general procedure is to set @req_prio and wait until unowned. Then
+ * set @prio (claiming ownership) and clearing @req_prio.
+ *
+ * Note that it is expected that the caller tried
+ * nbcon_context_try_acquire_direct() with @cur before calling this function.
+ */
+static int nbcon_context_try_acquire_handover(struct nbcon_context *ctxt,
+					      struct nbcon_state *cur)
+{
+	unsigned int cpu = smp_processor_id();
+	struct console *con = ctxt->console;
+	struct nbcon_state new;
+	int timeout;
+	int err = 0;
+
+	/*
+	 * Handovers are not possible on the same CPU or when the console
+	 * is permanently in an unsafe state or if the caller is unwilling
+	 * to wait.
+	 */
+	if (cur->cpu == cpu ||
+	    cur->unsafe_takeover ||
+	    ctxt->spinwait_max_us == 0) {
+		goto fail_handover;
+	}
+
+	/* Setup a request for handover. */
+	new.atom = cur->atom;
+	new.req_prio = ctxt->prio;
+	if (!nbcon_state_try_cmpxchg(con, cur, &new))
+		return -EAGAIN;
+
+	cur->atom = new.atom;
+
+	/* Wait until there is no owner and then acquire directly. */
+	for (timeout = ctxt->spinwait_max_us; timeout >= 0; timeout--) {
+		/* On successful acquire, this request is cleared. */
+		err = nbcon_context_try_acquire_requested(ctxt, cur);
+		if (!err)
+			return 0;
+
+		/*
+		 * If the acquire should be aborted, it must be ensured
+		 * that the request is removed before returning to caller.
+		 */
+		if (err == -EPERM)
+			break;
+
+		udelay(1);
+
+		/* Re-read the state because some time has passed. */
+		nbcon_state_read(con, cur);
+	}
+
+	/* Timed out or should abort. Carefully remove handover request. */
+	do {
+		/* No need to remove request if there is a new waiter. */
+		if (!nbcon_waiter_matches(cur, ctxt->prio))
+			goto fail_handover;
+
+		/* Unset request for handover. */
+		new.atom = cur->atom;
+		new.req_prio = NBCON_PRIO_NONE;
+		if (nbcon_state_try_cmpxchg(con, cur, &new)) {
+			/*
+			 * Request successfully unset. Report failure of
+			 * acquiring via handover.
+			 */
+			cur->atom = new.atom;
+			goto fail_handover;
+		}
+
+		/*
+		 * Unable to remove request. Try to acquire in case
+		 * the owner has released the lock.
+		 */
+	} while (nbcon_context_try_acquire_requested(ctxt, cur));
+
+	/* Acquire at timeout succeeded! */
+	return 0;
+
+fail_handover:
+	/*
+	 * If this is the panic context, the caller can try to acquire using
+	 * the unsafe hostile takeover method.
+	 */
+	if (ctxt->prio == NBCON_PRIO_PANIC &&
+	    ctxt->prio > cur->prio &&
+	    ctxt->prio > cur->req_prio &&
+	    !other_cpu_in_panic()) {
+		return -EBUSY;
+	}
+	return -EPERM;
+}
+
+/**
+ * nbcon_context_acquire_hostile - Acquire via unsafe hostile takeover
+ * @ctxt:	The context of the caller
+ * @cur:	The current console state
+ *
+ * @cur is updated to the new console state.
+ *
+ * The general procedure is to set @prio (forcing ownership). This method
+ * must only be used as a final attempt during panic.
+ */
+static void nbcon_context_acquire_hostile(struct nbcon_context *ctxt,
+					  struct nbcon_state *cur)
+{
+	unsigned int cpu = smp_processor_id();
+	struct console *con = ctxt->console;
+	struct nbcon_state new;
+
+	do {
+		new.atom = cur->atom;
+		new.cpu			= cpu;
+		new.prio		= ctxt->prio;
+		new.unsafe		|= cur->unsafe_takeover;
+		new.unsafe_takeover	|= cur->unsafe;
+
+	} while (!nbcon_state_try_cmpxchg(con, cur, &new));
+
+	cur->atom = new.atom;
+}
+
+/**
+ * nbcon_context_try_acquire - Try to acquire nbcon console
+ * @ctxt:	The context of the caller
+ *
+ * Return:	True if the console was acquired. False otherwise.
+ *
+ * If the caller allowed an unsafe hostile takeover, on success the
+ * caller should check the current console state to see if it is
+ * in an unsafe state. Otherwise, on success the caller may assume
+ * the console is not in an unsafe state.
+ */
+__maybe_unused
+static bool nbcon_context_try_acquire(struct nbcon_context *ctxt)
+{
+	__maybe_unused
+	unsigned int cpu = smp_processor_id();
+	struct console *con = ctxt->console;
+	struct nbcon_state cur;
+	int err;
+
+	/* unsafe hostile takeovers are only allowed for panic */
+	WARN_ON_ONCE(ctxt->allow_unsafe_takeover && (ctxt->prio != NBCON_PRIO_PANIC));
+
+	nbcon_state_read(con, &cur);
+
+	do {
+		err = nbcon_context_try_acquire_direct(ctxt, &cur);
+		if (!err)
+			goto success;
+		else if (err == -EPERM)
+			return false;
+
+		err = nbcon_context_try_acquire_handover(ctxt, &cur);
+		if (!err)
+			goto success;
+		else if (err == -EPERM)
+			return false;
+
+	} while (err == -EAGAIN);
+
+	/* Only attempt unsafe hostile takeover if explicitly requested. */
+	if (!ctxt->allow_unsafe_takeover)
+		return false;
+
+	nbcon_context_acquire_hostile(ctxt, &cur);
+success:
+	return true;
+}
+
+static bool nbcon_owner_matches(struct nbcon_state *cur, int expected_cpu,
+				int expected_prio)
+{
+	/*
+	 * Since consoles can only be acquired by higher priorities,
+	 * owning contexts are uniquely identified by @prio. However,
+	 * since contexts can unexpectedly lose ownership, it is
+	 * possible that later another owner appears with the same
+	 * priority. For this reason @cpu is also needed.
+	 */
+
+	if (cur->prio != expected_prio)
+		return false;
+
+	if (cur->cpu != expected_cpu)
+		return false;
+
+	return true;
+}
+
+/**
+ * nbcon_context_release - Release the console
+ * @ctxt:	The nbcon context from nbcon_context_try_acquire()
+ */
+__maybe_unused
+static void nbcon_context_release(struct nbcon_context *ctxt)
+{
+	unsigned int cpu = smp_processor_id();
+	struct console *con = ctxt->console;
+	struct nbcon_state cur;
+	struct nbcon_state new;
+
+	nbcon_state_read(con, &cur);
+
+	do {
+		if (!nbcon_owner_matches(&cur, cpu, ctxt->prio))
+			return;
+
+		new.atom = cur.atom;
+		new.prio = NBCON_PRIO_NONE;
+
+		/*
+		 * If @unsafe_takeover is set, it is kept set so that
+		 * the state remains permanently unsafe.
+		 */
+		new.unsafe |= cur.unsafe_takeover;
+
+	} while (!nbcon_state_try_cmpxchg(con, &cur, &new));
+}
+
 /**
  * nbcon_init - Initialize the nbcon console specific data
  * @con:	Console to initialize
-- 
2.39.2

