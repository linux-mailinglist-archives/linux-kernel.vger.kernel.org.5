Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAD3766078
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 02:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjG1AC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 20:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjG1ACn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 20:02:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DE830FC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 17:02:39 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690502557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+OBt8R0S5ZLGTYLHZc+xPyD6wpLwP3wXA8ac52ked50=;
        b=mX5yNNHU8v6EAiyTOmgHWzRkWgxRUWgDI5VDwmPGwyhGjtbQBUI6dGC3MBO1WTAx/ItqFB
        X+l+vZa4xvY5xY8MaQj/PGxT6nbtzG6Nn715N5CaRWkbEOI62xaORUiagU92sbRnfWK2N9
        SDErw8KCD1LpQQlMpu6ZnOm9AoR49N2ZzYPe7/6XeckBsBAzik1yF986jFfmy22MZEU5YQ
        53rOygmsnOvcjSlfN/xtB7/kjFwPMrJihEpY3uTJ/rtsF/xynd7gVBIpbkgtn7aL/+CRgi
        mLEK1sJnwLnTgJeYq+K4HT9t83f7ch5vswBn5yqt/MwiNO0/P2AgxNjBp6S+vA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690502557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+OBt8R0S5ZLGTYLHZc+xPyD6wpLwP3wXA8ac52ked50=;
        b=pGf+JUzTPnBX2GgRyBKVgZhISfdZSTZ2Jfv1PgZQ6Quvaikxjm8wcpC68szvM/X6G6RcXu
        q3M17jVIG1sE3hDQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v2 3/8] printk: nbcon: Add acquire/release logic
Date:   Fri, 28 Jul 2023 02:08:28 +0206
Message-Id: <20230728000233.50887-4-john.ogness@linutronix.de>
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

Add per console acquire/release functionality. The console 'locked'
state is a combination of multiple state fields:

  - The 'prio' field contains the severity of the context that owns
    the console. This field is used for decisions whether to attempt
    friendly handovers and also prevents takeovers from a less
    severe context, e.g. to protect the panic CPU. A value of 0
    (NBCON_PRIO_NONE) means the console is not locked.

  - The 'cpu' field denotes on which CPU the console is locked.

The acquire mechanism comes with several flavours:

  - Straight forward acquire when the console is not contended.

  - Friendly handover mechanism based on a request/grant handshake.

    The requesting context:

      1) Sets its priority into the 'req_prio' field.

      2) Waits (with a timeout) for the owning context to unlock the
         console.

      3) Sets the 'prio' field and clears the 'req_prio' field.

    The owning context:

      1) Observes the 'req_prio' field set.

      2) Gives up console ownership by clearing the 'prio' field.

  - Hostile takeover

      The new owner takes the console over without 'req_prio'
      handshake.

      This is required when friendly handovers are not possible,
      i.e. the higher priority context interrupted the owning
      context on the same CPU or the owning context is not able
      to make progress on a remote CPU.

The release is the counterpart which either releases the console
directly or yields it gracefully over to a requester.

All operations on console::nbcon_state are atomic cmpxchg based to
handle concurrency.

The acquire/release functions implement only minimal policies:

  - Preference for higher priority contexts.
  - Protection of the panic CPU.

All other policy decisions have to be made at the call sites:

  - What is marked as an unsafe section.
  - Whether to spinwait if there is already an owner.
  - Whether to attempt a hostile takeover when safe.
  - Whether to attempt a hostile takeover when unsafe.

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
 include/linux/console.h      |  59 +++++
 kernel/printk/printk_nbcon.c | 447 +++++++++++++++++++++++++++++++++++
 2 files changed, 506 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index c99265d82b98..e06cd1ce3e82 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -175,13 +175,28 @@ enum cons_flags {
  * struct nbcon_state - console state for nbcon consoles
  * @atom:	Compound of the state fields for atomic operations
  *
+ * @req_prio:		The priority of a handover request
+ * @prio:		The priority of the current usage
+ * @unsafe:		Console is busy in a non takeover region
+ * @hostile_unsafe:	The @unsafe value before a hostile takeover
+ * @cpu:		The CPU on which the owner runs
+ *
  * To be used for reading and preparing of the value stored in the nbcon
  * state variable @console.nbcon_state.
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
+			unsigned int hostile_unsafe	:  1;
+			unsigned int cpu		: 24;
 		};
 	};
 };
@@ -194,6 +209,50 @@ struct nbcon_state {
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
+ * @console:		The associated console
+ * @spinwait_max_us:	Limit for spinwait acquire
+ * @prio:		Priority of the context
+ * @unsafe:		This context is in an unsafe section
+ * @hostile:		Acquire console by hostile takeover
+ * @takeover_unsafe:	Acquire console by hostile takeover even if unsafe
+ */
+struct nbcon_context {
+	/* members set by caller */
+	struct console		*console;
+	unsigned int		spinwait_max_us;
+	enum nbcon_prio		prio;
+	unsigned int		unsafe			: 1;
+	unsigned int		hostile			: 1;
+	unsigned int		takeover_unsafe		: 1;
+};
+
 /**
  * struct console - The console descriptor structure
  * @name:		The name of the console driver
diff --git a/kernel/printk/printk_nbcon.c b/kernel/printk/printk_nbcon.c
index f9462b088439..b0acde0cb949 100644
--- a/kernel/printk/printk_nbcon.c
+++ b/kernel/printk/printk_nbcon.c
@@ -4,10 +4,38 @@
 
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
+ * the driver allows reentrancy via nbcon_state::unsafe = false. When the
+ * interrupted context resumes it checks the state before entering an unsafe
+ * region and aborts the operation if it detects a takeover.
+ *
+ * In case of panic the nesting context can take over the console forcefully.
+ *
+ * A concurrent writer on a different CPU with a higher priority can request
+ * to take over the console by:
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
+ * In case that the owner does not react on the request and does not make
+ * observable progress, the waiter will timeout and can then decide to do
+ * a hostile takeover.
  */
 
 /*
@@ -76,6 +104,425 @@ static inline bool nbcon_state_try_cmpxchg(struct console *con, struct nbcon_sta
 	return atomic_try_cmpxchg(&ACCESS_PRIVATE(con, nbcon_state), &cur->atom, new->atom);
 }
 
+/**
+ * nbcon_context_try_acquire_direct - Try to acquire directly
+ * @ctxt:		The context of the caller
+ * @cur:		The current console state
+ *
+ * Return:	0 on success and @cur is updated to the new console state.
+ *		Otherwise an error code on failure.
+ *
+ * Errors:
+ *
+ *	-EPERM:		A panic is in progress an this is not the panic CPU.
+ *			Retrying the acquire will not be immediately useful.
+ *
+ *	-EBUSY:		The console already has an owner. Retrying the
+ *			acquire will not be immediately useful.
+ *
+ *	-EAGAIN:	An unexpected state change occurred. @cur has been
+ *			updated. The caller should retry the acquire.
+ *
+ * The general procedure is to change @prio from unowned to owned.
+ */
+static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
+					    struct nbcon_state *cur)
+{
+	unsigned int cpu = smp_processor_id();
+	struct console *con = ctxt->console;
+	struct nbcon_state new = {
+		.cpu			= cpu,
+		.prio			= ctxt->prio,
+		.unsafe			= cur->hostile_unsafe | ctxt->unsafe,
+		.hostile_unsafe		= cur->hostile_unsafe,
+	};
+
+	if (other_cpu_in_panic())
+		return -EPERM;
+
+	/*
+	 * Direct not possible if owner in unsafe region. If there
+	 * was previously a hostile takeover, the console may be left
+	 * in an unsafe state, even if it is now unowned.
+	 */
+	if (cur->unsafe)
+		return -EBUSY;
+
+	/* Direct is only possible if it is unowned. */
+	if (cur->prio != NBCON_PRIO_NONE)
+		return -EBUSY;
+
+	/* Higher priority waiters are allowed to keep waiting. */
+	if (cur->req_prio > ctxt->prio)
+		new.req_prio = cur->req_prio;
+	else
+		new.req_prio = 0;
+
+	/* All looks good. Try to take ownership. */
+
+	if (!nbcon_state_try_cmpxchg(con, cur, &new))
+		return -EAGAIN;
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
+ *	-EPERM:		A panic is in progress an this is not the panic CPU.
+ *			Retrying the acquire will not be immediately useful.
+ *
+ *	-EBUSY:		The current owner or waiter is such that this context
+ *			is not able to execute a handover. Retrying the
+ *			acquire will not be immediately useful.
+ *
+ *	-EAGAIN:	An unexpected state change occurred. @cur has been
+ *			updated. The caller should retry the acquire.
+ *
+ * The general procedure is to set @req_prio and wait until unowned. Then
+ * set @prio (claiming ownership) and clearing @req_prio.
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
+	/* Cannot request handover if owner has same or higher priority. */
+	if (cur->prio >= ctxt->prio)
+		return -EBUSY;
+
+	/* Cannot request handover if a waiter has same or higher priority. */
+	if (cur->req_prio >= ctxt->prio)
+		return -EBUSY;
+
+	/*
+	 * If there is no owner, a handover may be in progress and this
+	 * context (having a higher priority) could jump in directly.
+	 */
+	if (cur->prio == NBCON_PRIO_NONE)
+		return nbcon_context_try_acquire_direct(ctxt, cur);
+
+	/* Cannot handover on same CPU. */
+	if (cur->cpu == cpu)
+		return -EBUSY;
+
+	/* Cannot request handover if caller unwilling to wait. */
+	if (ctxt->spinwait_max_us == 0)
+		return -EBUSY;
+
+	/* Set request for handover. */
+	new.atom = cur->atom;
+	new.req_prio = ctxt->prio;
+	if (!nbcon_state_try_cmpxchg(con, cur, &new))
+		return -EAGAIN;
+
+	cur->atom = new.atom;
+
+	debug_store(1, "handover: cpu%d SPINNING to acquire for prio%d\n", cpu, ctxt->prio);
+
+	/* Wait until there is no owner and then acquire directly. */
+	for (timeout = ctxt->spinwait_max_us; timeout >= 0; timeout--) {
+		/* On successful acquire, this request is cleared. */
+		err = nbcon_context_try_acquire_direct(ctxt, cur);
+		if (!err)
+			return 0;
+
+		/*
+		 * If another CPU is in panic, the request must be removed
+		 * before returning to the caller.
+		 */
+		if (err == -EPERM)
+			break;
+
+		/* Continue spinwaiting on -EAGAIN and -EBUSY. */
+
+		udelay(1);
+
+		/* Re-read the state because some time has passed. */
+		nbcon_state_read(con, cur);
+
+		/*
+		 * If the waiter unexpectedly changed, this request is
+		 * no longer set. Have the caller try again rather than
+		 * guessing what has happened.
+		 */
+		if (cur->req_prio != ctxt->prio)
+			return -EAGAIN;
+	}
+
+	/* Timeout. Safely remove handover request and report failure. */
+	do {
+		/* No need to remove request if there is another waiter. */
+		if (cur->req_prio != ctxt->prio) {
+			if (err == -EPERM)
+				return err;
+			return -EBUSY;
+		}
+
+		/* Unset request for handover. */
+		new.atom = cur->atom;
+		new.req_prio = NBCON_PRIO_NONE;
+		if (nbcon_state_try_cmpxchg(con, cur, &new)) {
+			debug_store(1, "handover: cpu%d TIMEOUT to acquire for prio%d\n",
+				    cpu, ctxt->prio);
+			/*
+			 * Request successfully unset. Report failure of
+			 * acquiring via handover.
+			 */
+			cur->atom = new.atom;
+			return -EBUSY;
+		}
+
+		/*
+		 * Unable to remove request. Try direct acquire. If
+		 * successful, this request is also cleared.
+		 */
+		err = nbcon_context_try_acquire_direct(ctxt, cur);
+	} while (err);
+
+	/* Direct acquire at timeout succeeded! */
+	return 0;
+}
+
+/**
+ * nbcon_context_try_acquire_hostile - Try to acquire via hostile takeover
+ * @ctxt:	The context of the caller
+ * @cur:	The current console state
+ *
+ * Return:	0 on success and @cur is updated to the new console state.
+ *		Otherwise an error code on failure.
+ *
+ * Errors:
+ *
+ *	-EPERM:		A panic is in progress an this is not the panic CPU
+ *			or this context is not the single panic context.
+ *			Retrying the acquire will not be immediately useful.
+ *
+ *	-EBUSY:		The current owner is in an unsafe region and
+ *			@takeover_unsafe was not set. Retrying the acquire
+ *			is only immediately useful if @takeover_unsafe is
+ *			set.
+ *
+ *	-EAGAIN:	An unexpected state change occurred. @cur has been
+ *			updated. The caller should retry the acquire.
+ *
+ * The general procedure is to set @prio (forcing ownership). This method
+ * must only be used as a final attempt during panic.
+ */
+static int nbcon_context_try_acquire_hostile(struct nbcon_context *ctxt,
+					     struct nbcon_state *cur)
+{
+	unsigned int cpu = smp_processor_id();
+	struct console *con = ctxt->console;
+	struct nbcon_state new = {
+		.cpu			= cpu,
+		.prio			= ctxt->prio,
+		.unsafe			= cur->hostile_unsafe | ctxt->unsafe,
+		.hostile_unsafe		= cur->hostile_unsafe | cur->unsafe,
+	};
+
+	if (other_cpu_in_panic())
+		return -EPERM;
+
+	/* Hostile takeovers must only be in the single panic context! */
+	if (WARN_ON_ONCE(ctxt->prio != NBCON_PRIO_PANIC || cur->prio == NBCON_PRIO_PANIC))
+		return -EPERM;
+
+	/*
+	 * If a hostile takeover in unsafe regions is wanted,
+	 * this is additionally requested.
+	 */
+	if (cur->unsafe && !ctxt->takeover_unsafe)
+		return -EBUSY;
+
+	if (!nbcon_state_try_cmpxchg(con, cur, &new))
+		return -EAGAIN;
+
+	cur->atom = new.atom;
+
+	return 0;
+}
+
+/**
+ * nbcon_context_try_acquire - Try to acquire nbcon console
+ * @ctxt:	The context of the caller
+ *
+ * Return:	True if the console was acquired. False otherwise.
+ *
+ * The attempts to acquire always begin with the safest methods and only
+ * upon failure move to more aggressive methods.
+ *
+ * If the caller requested a hostile takeover, on success @ctxt is
+ * updated so that the caller can see if indeed a hostile (and
+ * possibly unsafe) takeover occurred.
+ */
+__maybe_unused
+static bool nbcon_context_try_acquire(struct nbcon_context *ctxt)
+{
+	__maybe_unused
+	unsigned int cpu = smp_processor_id();
+	struct console *con = ctxt->console;
+	struct nbcon_state cur;
+	bool hostile;
+	int err;
+
+	/* @takeover_unsafe is only valid when hostile takeover requested. */
+	WARN_ON_ONCE(ctxt->takeover_unsafe && !ctxt->hostile);
+
+	nbcon_state_read(con, &cur);
+
+try_again:
+	hostile = false;
+
+	/* ACQUIRE DIRECT */
+
+	debug_store(ctxt->prio > NBCON_PRIO_NORMAL,
+		    "direct: cpu%d trying DIRECT acquire prio%d\n", cpu, ctxt->prio);
+	err = nbcon_context_try_acquire_direct(ctxt, &cur);
+	if (!err) {
+		debug_store(ctxt->prio > NBCON_PRIO_NORMAL,
+			    "direct: cpu%d SUCCESS prio%d\n", cpu, ctxt->prio);
+		goto success;
+	} else if (err == -EPERM) {
+		debug_store(1, "direct: cpu%d FAILED prio%d (non-panic cpu)\n",
+			    cpu, ctxt->prio);
+		return false;
+	} else if (err == -EAGAIN) {
+		debug_store(1, "direct: cpu%d FAILED prio%d (state race)\n",
+			    cpu, ctxt->prio);
+		goto try_again;
+	} else {
+		debug_store(1, "direct: cpu%d FAILED prio%d (already owned by cpu%d)\n",
+			    cpu, ctxt->prio, cur.cpu);
+		/* Continue to next method. */
+	}
+
+	/* ACQUIRE VIA HANDOVER */
+
+	debug_store(1, "handover: cpu%d REQUESTING prio%d from cpu%d\n",
+		    cpu, ctxt->prio, cur.cpu);
+	err = nbcon_context_try_acquire_handover(ctxt, &cur);
+	if (!err) {
+		debug_store(1, "handover: cpu%d SUCCESS prio%d\n",
+			    cpu, ctxt->prio);
+		goto success;
+	} else if (err == -EPERM) {
+		debug_store(1, "handover: cpu%d FAILED requesting prio%d (non-panic cpu)\n",
+			    cpu, ctxt->prio);
+		return false;
+	} else if (err == -EAGAIN) {
+		debug_store(1, "handover: cpu%d FAILED requesting prio%d (state race)\n",
+			    cpu, ctxt->prio);
+		goto try_again;
+	} else {
+		debug_store(1, "handover: cpu%d FAILED requesting prio%d (cpu%d/prio%d/timeout)\n",
+			    cpu, ctxt->prio, cur.cpu, cur.prio);
+		/* Continue to next method. */
+	}
+
+	/* ACQUIRE VIA HOSTILE TAKEOVER */
+
+	/* Only attempt hostile takeover if explicitly requested. */
+	if (!ctxt->hostile)
+		return false;
+
+	debug_store(1,
+		    "hostile: cpu%d trying HOSTILE acquire for prio%d from cpu%d (takeover_unsafe=%d)\n",
+		    cpu, ctxt->prio, cur.cpu, ctxt->takeover_unsafe);
+	err = nbcon_context_try_acquire_hostile(ctxt, &cur);
+	if (!err) {
+		debug_store(1, "hostile: cpu%d SUCCESS prio%d\n", cpu, ctxt->prio);
+		/* Let caller know if the takeover was unsafe. */
+		ctxt->takeover_unsafe = cur.hostile_unsafe;
+		hostile = true;
+		goto success;
+	} else if (err == -EPERM) {
+		debug_store(1, "hostile: cpu%d FAILED acquire prio%d (non-panic cpu)\n",
+			    cpu, ctxt->prio);
+		return false;
+	} else if (err == -EAGAIN) {
+		debug_store(1, "hostile: cpu%d FAILED acquire prio%d (state race)\n",
+			    cpu, ctxt->prio);
+		goto try_again;
+	} else {
+		debug_store(1, "hostile: cpu%d FAILED acquire prio%d (unsafe)\n",
+			    cpu, ctxt->prio);
+		/* Continue to next method. */
+	}
+
+	/* No methods left to try. */
+	return false;
+success:
+	if (!hostile) {
+		/* Let caller know it was not a hostile takeover. */
+		ctxt->hostile = 0;
+		ctxt->takeover_unsafe = 0;
+	}
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
+	do {
+		if (!nbcon_owner_matches(&cur, cpu, ctxt->prio))
+			return;
+
+		new.atom = cur.atom;
+		new.prio = NBCON_PRIO_NONE;
+		new.unsafe = cur.hostile_unsafe;
+
+		/*
+		 * If @hostile_unsafe is set, it is kept set so that
+		 * the state remains permanently unsafe.
+		 */
+
+	} while (!nbcon_state_try_cmpxchg(con, &cur, &new));
+}
+
 /**
  * nbcon_init - Initialize the nbcon console specific data
  * @con:	Console to initialize
-- 
2.39.2

