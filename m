Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4A87A6F2C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 01:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbjISXJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 19:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbjISXJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 19:09:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC62C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 16:09:12 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695164950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RXYljq1O5mwfZU+NDYT3eBF6WGuYpS+t9+Qc7DTVOZs=;
        b=0n9rSWKKgFMMM8oe7OxgVm25UuFUBlbW3YAo2v2icNrgjeHRizUJRTeSvdYT/eGtVcIKJp
        vjFkpAkv6JhdILbdaNar/Oq0AUKclYJykk+XE3DwtMKMr8FEc7H+1SaJH25CtVSuHK98ez
        WwHcrluKf3t95h8bAz12tGmzMFDSf6+/jogu926ViKIIYtUAF+G1Tz8vx++q9tfw/Pj2o4
        xounm7rjfOk6MvfeuxnCZ0PLv6l9SSFbqTHZQ5rbFR8jD+dXYcV+AhvyPeM6DKLRG4tBMs
        yIllyCVpEpRJEjNbm+qMif91wyzGcF33SOvNDJvM0qn2yVJvqmo/tDDJh/bNZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695164950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RXYljq1O5mwfZU+NDYT3eBF6WGuYpS+t9+Qc7DTVOZs=;
        b=SF2ALktfgmDTzBDMjoVe+9Uw9oVXGPK8VIxJwdu/Otl/ztdreIl9fLaUgdg5d9EvAO66IX
        8+xRq32MGQwOnXBQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v2 04/11] printk: nbcon: Provide functions to mark atomic write sections
Date:   Wed, 20 Sep 2023 01:14:49 +0206
Message-Id: <20230919230856.661435-5-john.ogness@linutronix.de>
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

WARN/OOPS/PANIC require printing out immediately since the
regular printing method (and in the future, the printing
threads) might not be able to run.

Add per-CPU state to denote the priority/urgency of the output
and provide functions to mark the beginning and end of sections
where the urgent messages are generated.

Note that when a CPU is in a priority elevated state, flushing
only occurs when dropping back to a lower priority. This allows
the full set of printk records (WARN/OOPS/PANIC output) to be
stored in the ringbuffer before beginning to flush the backlog.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
---
 include/linux/console.h |  4 ++
 kernel/printk/nbcon.c   | 89 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index e4fc6f7c1496..25a3ddd39083 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -452,10 +452,14 @@ static inline bool console_is_registered(const struct console *con)
 	hlist_for_each_entry(con, &console_list, node)
 
 #ifdef CONFIG_PRINTK
+extern enum nbcon_prio nbcon_atomic_enter(enum nbcon_prio prio);
+extern void nbcon_atomic_exit(enum nbcon_prio prio, enum nbcon_prio prev_prio);
 extern bool nbcon_can_proceed(struct nbcon_write_context *wctxt);
 extern bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt);
 extern bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt);
 #else
+static inline enum nbcon_prio nbcon_atomic_enter(enum nbcon_prio prio) { return NBCON_PRIO_NONE; }
+static inline void nbcon_atomic_exit(enum nbcon_prio prio, enum nbcon_prio prev_prio) { }
 static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt) { return false; }
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index b96077152f49..9359906b575b 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -961,6 +961,95 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 	return nbcon_context_exit_unsafe(ctxt);
 }
 
+/**
+ * struct nbcon_cpu_state - Per CPU printk context state
+ * @prio:	The current context priority level
+ * @nesting:	Per priority nest counter
+ */
+struct nbcon_cpu_state {
+	enum nbcon_prio		prio;
+	int			nesting[NBCON_PRIO_MAX];
+};
+
+static DEFINE_PER_CPU(struct nbcon_cpu_state, nbcon_pcpu_state);
+static struct nbcon_cpu_state early_nbcon_pcpu_state __initdata;
+
+/**
+ * nbcon_get_cpu_state - Get the per CPU console state pointer
+ *
+ * Returns either a pointer to the per CPU state of the current CPU or to
+ * the init data state during early boot.
+ */
+static __ref struct nbcon_cpu_state *nbcon_get_cpu_state(void)
+{
+	if (!printk_percpu_data_ready())
+		return &early_nbcon_pcpu_state;
+
+	return this_cpu_ptr(&nbcon_pcpu_state);
+}
+
+/**
+ * nbcon_atomic_enter - Enter a context that enforces atomic printing
+ * @prio:	Priority of the context
+ *
+ * Return:	The previous priority that needs to be fed into
+ *		the corresponding nbcon_atomic_exit()
+ * Context:	Any context. Disables migration.
+ */
+enum nbcon_prio nbcon_atomic_enter(enum nbcon_prio prio)
+{
+	struct nbcon_cpu_state *cpu_state;
+	enum nbcon_prio prev_prio;
+
+	migrate_disable();
+
+	cpu_state = nbcon_get_cpu_state();
+
+	prev_prio = cpu_state->prio;
+	if (prio > prev_prio)
+		cpu_state->prio = prio;
+
+	/*
+	 * Increment the nesting on @cpu_state->prio (instead of
+	 * @prio) so that a WARN() nested within a panic printout
+	 * does not attempt to scribble state.
+	 */
+	cpu_state->nesting[cpu_state->prio]++;
+
+	return prev_prio;
+}
+
+/**
+ * nbcon_atomic_exit - Exit a context that enforces atomic printing
+ * @prio:	Priority of the context to leave
+ * @prev_prio:	Priority of the previous context for restore
+ *
+ * Context:	Any context. Enables migration.
+ *
+ * @prev_prio is the priority returned by the corresponding
+ * nbcon_atomic_enter().
+ */
+void nbcon_atomic_exit(enum nbcon_prio prio, enum nbcon_prio prev_prio)
+{
+	struct nbcon_cpu_state *cpu_state;
+
+	cpu_state = nbcon_get_cpu_state();
+
+	/*
+	 * Undo the nesting of nbcon_atomic_enter() at the CPU state
+	 * priority.
+	 */
+	cpu_state->nesting[cpu_state->prio]--;
+
+	/*
+	 * Restore the previous priority, which was returned by
+	 * nbcon_atomic_enter().
+	 */
+	cpu_state->prio = prev_prio;
+
+	migrate_enable();
+}
+
 /**
  * nbcon_alloc - Allocate buffers needed by the nbcon console
  * @con:	Console to allocate buffers for
-- 
2.39.2

