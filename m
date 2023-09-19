Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9B87A6F30
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 01:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbjISXJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 19:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbjISXJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 19:09:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABD1C4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 16:09:13 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695164951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2k78cqDo2n7jFkD6ttaAHGW5bS6OdfJnhB22UhQNM+I=;
        b=wWn2bTaDLV85/e0NSwumigrW7EOYaHluwC1GA+TskQsBYIcgwTfiQTT1XIGsc4e7Lolo/J
        8bfGthQvsDUkyYJHSpwZZRachIyaYxbumFVeA9NmNJHH/CwAWXf4w5AL0YU5147hNqZWMs
        cwXkq9TzbOcZ4M/fL9C8Alrocb9w10J/rM2a/kTH67o+rfbeo417CYM13QSNtkNqncxTvA
        8uvDQ31BqcYhvRsKc6borUdAN5uZfCq3XKVP2c97K3K2gSlMitvIcoiNJHDkF+kaBawyd8
        KYgteUKbOiAH+X4OLMG7cjGMHlRSXbXe10CxRsccwqCYVPs7hbvfiniuIJZoiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695164951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2k78cqDo2n7jFkD6ttaAHGW5bS6OdfJnhB22UhQNM+I=;
        b=OXehBxL7RFUdwevTFoCOQzppzyc04cD606hS5sOvQwxbLMn0eblxrkUeq0gSede7p1JRcf
        lr4ReQILCVn5jiBQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 05/11] printk: nbcon: Provide function for atomic flushing
Date:   Wed, 20 Sep 2023 01:14:50 +0206
Message-Id: <20230919230856.661435-6-john.ogness@linutronix.de>
In-Reply-To: <20230919230856.661435-1-john.ogness@linutronix.de>
References: <20230919230856.661435-1-john.ogness@linutronix.de>
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

Provide nbcon_atomic_flush() to perform atomic write flushing
of all registered nbcon consoles. Like with legacy consoles,
the nbcon consoles are flushed one record per console. This
allows all nbcon consoles to generate pseudo-simultaneously,
rather than one console waiting for the full ringbuffer to
dump to another console before printing anything.

Note that if the current CPU is in a nested elevated priority
state (EMERGENCY/PANIC), nbcon_atomic_flush() does nothing.
This is in case the printing itself generates urgent messages
(OOPS/WARN/PANIC), that those messages are fully stored into
the ringbuffer before any printing resumes.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
---
 include/linux/printk.h |   6 +++
 kernel/printk/nbcon.c  | 101 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 105 insertions(+), 2 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 8ef499ab3c1e..58e5f34d6df1 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -192,6 +192,7 @@ void show_regs_print_info(const char *log_lvl);
 extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
 void printk_trigger_flush(void);
+extern void nbcon_atomic_flush_all(void);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -271,6 +272,11 @@ static inline void dump_stack(void)
 static inline void printk_trigger_flush(void)
 {
 }
+
+static inline void nbcon_atomic_flush_all(void)
+{
+}
+
 #endif
 
 #ifdef CONFIG_SMP
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 9359906b575b..2a9ff18fc78c 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -571,7 +571,6 @@ static struct printk_buffers panic_nbcon_pbufs;
  * in an unsafe state. Otherwise, on success the caller may assume
  * the console is not in an unsafe state.
  */
-__maybe_unused
 static bool nbcon_context_try_acquire(struct nbcon_context *ctxt)
 {
 	unsigned int cpu = smp_processor_id();
@@ -873,7 +872,6 @@ EXPORT_SYMBOL_GPL(nbcon_exit_unsafe);
  * When true is returned, @wctxt->ctxt.backlog indicates whether there are
  * still records pending in the ringbuffer,
  */
-__maybe_unused
 static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
@@ -988,6 +986,105 @@ static __ref struct nbcon_cpu_state *nbcon_get_cpu_state(void)
 	return this_cpu_ptr(&nbcon_pcpu_state);
 }
 
+/**
+ * nbcon_atomic_emit_one - Print one record for a console in atomic mode
+ * @wctxt:			An initialized write context struct to use
+ *				for this context
+ *
+ * Returns false if the given console could not print a record or there are
+ * no more records to print, otherwise true.
+ *
+ * This is an internal helper to handle the locking of the console before
+ * calling nbcon_emit_next_record().
+ */
+static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+
+	if (!nbcon_context_try_acquire(ctxt))
+		return false;
+
+	/*
+	 * nbcon_emit_next_record() returns false when the console was
+	 * handed over or taken over. In both cases the context is no
+	 * longer valid.
+	 */
+	if (!nbcon_emit_next_record(wctxt))
+		return false;
+
+	nbcon_context_release(ctxt);
+
+	return prb_read_valid(prb, ctxt->seq, NULL);
+}
+
+/**
+ * __nbcon_atomic_flush_all - Flush all nbcon consoles in atomic mode
+ * @allow_unsafe_takeover:	True, to allow unsafe hostile takeovers
+ */
+static void __nbcon_atomic_flush_all(bool allow_unsafe_takeover)
+{
+	struct nbcon_write_context wctxt = { };
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
+	struct nbcon_cpu_state *cpu_state;
+	struct console *con;
+	bool any_progress;
+	int cookie;
+
+	cpu_state = nbcon_get_cpu_state();
+
+	/*
+	 * Let the outermost flush of this priority print. This avoids
+	 * nasty hackery for nested WARN() where the printing itself
+	 * generates one and ensures such nested messages are stored to
+	 * the ringbuffer before any printing resumes.
+	 *
+	 * cpu_state->prio <= NBCON_PRIO_NORMAL is not subject to nesting
+	 * and can proceed in order to allow any atomic printing for
+	 * regular kernel messages.
+	 */
+	if (cpu_state->prio > NBCON_PRIO_NORMAL &&
+	    cpu_state->nesting[cpu_state->prio] != 1)
+		return;
+
+	do {
+		any_progress = false;
+
+		cookie = console_srcu_read_lock();
+		for_each_console_srcu(con) {
+			short flags = console_srcu_read_flags(con);
+			bool progress;
+
+			if (!(flags & CON_NBCON))
+				continue;
+
+			if (!console_is_usable(con, flags))
+				continue;
+
+			memset(ctxt, 0, sizeof(*ctxt));
+			ctxt->console			= con;
+			ctxt->spinwait_max_us		= 2000;
+			ctxt->prio			= cpu_state->prio;
+			ctxt->allow_unsafe_takeover	= allow_unsafe_takeover;
+
+			progress = nbcon_atomic_emit_one(&wctxt);
+			if (!progress)
+				continue;
+			any_progress = true;
+		}
+		console_srcu_read_unlock(cookie);
+	} while (any_progress);
+}
+
+/**
+ * nbcon_atomic_flush_all - Flush all nbcon consoles in atomic mode
+ *
+ * Context:	Any context where migration is disabled.
+ */
+void nbcon_atomic_flush_all(void)
+{
+	__nbcon_atomic_flush_all(false);
+}
+
 /**
  * nbcon_atomic_enter - Enter a context that enforces atomic printing
  * @prio:	Priority of the context
-- 
2.39.2

