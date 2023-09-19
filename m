Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122CE7A6F34
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 01:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbjISXKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 19:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbjISXJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 19:09:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E13DCA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 16:09:16 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695164954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f7cOYAQI8bFPp8osUlYoxxP2Ba8k68CcPtU2QUq7Vj8=;
        b=0wJVDuRdeBg8KXv7SeT18I2SbRqNOuaWrFR18sqA1Qs0bwXzOLmQvI2BokJIiYRHrq4IQO
        dRLw90yNKjM3bJZpe+A7wT+Q3L4u3eDQlf2tYGqBJwq1f4UPwiCW16D4d5JSvwJQQNH+oY
        A1rgJS226R8X2BxamsHtB9Z9JQUWeGCQtTLLzVPSt6BK2vldKE/x1j02eTR1g0EJL1afve
        v+b3sB79UFDd3TNgdjS+TegOMa0pdaXi+So8hlARdRNfQoCn7OeJMDuToEm0h7ikEK5tdu
        lfjUFS7mkos3WyOC+tmY2sQurFZvqqMte57FoKDY/w3MCjdFJyATtpLimQ3+Ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695164954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f7cOYAQI8bFPp8osUlYoxxP2Ba8k68CcPtU2QUq7Vj8=;
        b=lfk75Op2Kc+6bJGMuCyAAe07X6uD47Jj8MI6BoQE/nwM14DL61HyRbd6dJIcTkNbfSF/Qk
        axDXN3aUdZTc5SBA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 07/11] printk: nbcon: Wire up nbcon into console_flush_all()
Date:   Wed, 20 Sep 2023 01:14:52 +0206
Message-Id: <20230919230856.661435-8-john.ogness@linutronix.de>
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

In atomic printing sections, the atomic nbcon consoles have
their own behavior of allowing all urgent messages to be
stored into the ringbuffer and then flushing afterwards.

However, the nbcon consoles must also emit messages when not
within atomic printing sections. For this, the existing
console_flush_all() function can be used.

Provide nbcon_console_emit_next_record(), which acts as the
nbcon variant of console_emit_next_record(). Call this variant
within console_flush_all() for nbcon consoles.

Note that when in an atomic printing section,
nbcon_console_emit_next_record() does nothing. This is because
atomic printing sections will handle the nbcon flushing when
exiting the outermost atomic printing section.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/internal.h |  2 ++
 kernel/printk/nbcon.c    | 46 ++++++++++++++++++++++++++++++++++++++++
 kernel/printk/printk.c   | 26 +++++++++++++++--------
 3 files changed, 65 insertions(+), 9 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 6780911fa8f2..a3c6b5ce80e4 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -77,6 +77,7 @@ void nbcon_seq_force(struct console *con, u64 seq);
 bool nbcon_alloc(struct console *con);
 void nbcon_init(struct console *con);
 void nbcon_free(struct console *con);
+bool nbcon_console_emit_next_record(struct console *con);
 
 /*
  * Check if the given console is currently capable and allowed to print
@@ -131,6 +132,7 @@ static inline void nbcon_seq_force(struct console *con, u64 seq) { }
 static inline bool nbcon_alloc(struct console *con) { return false; }
 static inline void nbcon_init(struct console *con) { }
 static inline void nbcon_free(struct console *con) { }
+static bool nbcon_console_emit_next_record(struct console *con) { return false; }
 
 static inline bool console_is_usable(struct console *con, short flags) { return false; }
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 82e6a1678363..de473a1003d8 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1017,6 +1017,52 @@ static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
 	return prb_read_valid(prb, ctxt->seq, NULL);
 }
 
+/**
+ * nbcon_console_emit_next_record - Print one record for an nbcon console
+ *					in atomic mode
+ * @con:	The console to print on
+ *
+ * Return:	True if a record could be printed, otherwise false.
+ *
+ * This function is meant to be called by console_flush_all() to atomically
+ * print records on nbcon consoles. Essentially it is the nbcon version of
+ * console_emit_next_record().
+ *
+ * This function also returns false if the current CPU is in an elevated
+ * atomic priority state in order to allow the CPU to get all of the
+ * emergency messages into the ringbuffer first.
+ */
+bool nbcon_console_emit_next_record(struct console *con)
+{
+	struct nbcon_cpu_state *cpu_state;
+	bool progress = false;
+
+	migrate_disable();
+
+	cpu_state = nbcon_get_cpu_state();
+
+	/*
+	 * Atomic printing from console_flush_all() only occurs if this
+	 * CPU is not in an elevated atomic priority state. If it is, the
+	 * atomic printing will occur when this CPU exits that state. This
+	 * allows a set of emergency messages to be completely stored in
+	 * the ringbuffer before this CPU begins flushing.
+	 */
+	if (cpu_state->prio <= NBCON_PRIO_NORMAL) {
+		struct nbcon_write_context wctxt = { };
+		struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
+
+		ctxt->console	= con;
+		ctxt->prio	= NBCON_PRIO_NORMAL;
+
+		progress = nbcon_atomic_emit_one(&wctxt);
+	}
+
+	migrate_enable();
+
+	return progress;
+}
+
 /**
  * __nbcon_atomic_flush_all - Flush all nbcon consoles in atomic mode
  * @allow_unsafe_takeover:	True, to allow unsafe hostile takeovers
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 419c0fabc481..e5e192318b8e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2930,24 +2930,32 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 		cookie = console_srcu_read_lock();
 		for_each_console_srcu(con) {
 			short flags = console_srcu_read_flags(con);
+			u64 printk_seq;
 			bool progress;
 
 			if (!console_is_usable(con, flags))
 				continue;
 			any_usable = true;
 
-			progress = console_emit_next_record(con, handover, cookie);
+			if (flags & CON_NBCON) {
+				progress = nbcon_console_emit_next_record(con);
+				printk_seq = nbcon_seq_read(con);
+			} else {
+				progress = console_emit_next_record(con, handover, cookie);
 
-			/*
-			 * If a handover has occurred, the SRCU read lock
-			 * is already released.
-			 */
-			if (*handover)
-				return false;
+				/*
+				 * If a handover has occurred, the SRCU read
+				 * lock is already released.
+				 */
+				if (*handover)
+					return false;
+
+				printk_seq = con->seq;
+			}
 
 			/* Track the next of the highest seq flushed. */
-			if (con->seq > *next_seq)
-				*next_seq = con->seq;
+			if (printk_seq > *next_seq)
+				*next_seq = printk_seq;
 
 			if (!progress)
 				continue;
-- 
2.39.2

