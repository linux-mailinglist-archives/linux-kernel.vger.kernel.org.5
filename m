Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0198A7B7F50
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242531AbjJDMgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242432AbjJDMfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:35:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03B7121
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:35:39 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696422938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ch0dJixaaY+pPoIMtZ/2D1P4Dl6dWsbaFTlXDeDmHfo=;
        b=EWEnazDZolfpBGPeMVQr4P6bwSvWc5rXvr3cujc035imvKbovtJuoA3eSiXKwGIwg502Is
        aKE/bAslzFSsygvIc/mbRqupzsiPyuW5lngr2Up5h9AszVVMSqO9Af8IFSMyTUfgFfXOqu
        clPbDFGEGxtZlXOKIJEhNpGbQqwSioYrpTr0aFrbgeDPK6ioy/SExPalLFHCLn3nqqOgif
        jC1JNHIQjBb+uF9hrjRm4DwAXGWxwT/kc1ybLhv+MN2icWryR7HBApEU8Uchs8t2a0/r7A
        tuZ/tjtrHP7aUq2Nv8ueCgIZWacA6OeCxNarvL4BJynBNhg9y4Mm4WnaakhOtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696422938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ch0dJixaaY+pPoIMtZ/2D1P4Dl6dWsbaFTlXDeDmHfo=;
        b=jrRtLk7S+jsStbrVpfrcFWHXpIo5Z8IQZdT0KGNlw/PKwrqR97BmQk3LLty8vm43LyZJnp
        j/aQNVezBwbpqkBQ==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Richard Cochran (linutronix GmbH)" <richardcochran@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v8 22/25] tick/sched: Split out jiffies update helper function
Date:   Wed,  4 Oct 2023 14:34:51 +0200
Message-Id: <20231004123454.15691-23-anna-maria@linutronix.de>
In-Reply-To: <20231004123454.15691-1-anna-maria@linutronix.de>
References: <20231004123454.15691-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Richard Cochran (linutronix GmbH)" <richardcochran@gmail.com>

The logic to get the time of the last jiffies update will be needed by
the timer pull model as well.

Move the code into a global function in anticipation of the new caller.

No functional change.

Signed-off-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/tick-internal.h |  1 +
 kernel/time/tick-sched.c    | 18 +++++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 206010ae2a53..7dbf5ab43d06 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -158,6 +158,7 @@ static inline void tick_nohz_init(void) { }
 #ifdef CONFIG_NO_HZ_COMMON
 extern unsigned long tick_nohz_active;
 extern void timers_update_nohz(void);
+extern u64 get_jiffies_update(unsigned long *basej);
 # ifdef CONFIG_SMP
 extern struct static_key_false timers_migration_enabled;
 extern void fetch_next_timer_interrupt_remote(unsigned long basej, u64 basem,
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 7e1fdbc6d5f0..169886a87cc1 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -798,18 +798,30 @@ static inline bool local_timer_softirq_pending(void)
 	return local_softirq_pending() & BIT(TIMER_SOFTIRQ);
 }
 
-static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
+/*
+ * Read jiffies and the time when jiffies were updated last
+ */
+u64 get_jiffies_update(unsigned long *basej)
 {
-	u64 basemono, next_tick, delta, expires;
 	unsigned long basejiff;
 	unsigned int seq;
+	u64 basemono;
 
-	/* Read jiffies and the time when jiffies were updated last */
 	do {
 		seq = read_seqcount_begin(&jiffies_seq);
 		basemono = last_jiffies_update;
 		basejiff = jiffies;
 	} while (read_seqcount_retry(&jiffies_seq, seq));
+	*basej = basejiff;
+	return basemono;
+}
+
+static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
+{
+	u64 basemono, next_tick, delta, expires;
+	unsigned long basejiff;
+
+	basemono = get_jiffies_update(&basejiff);
 	ts->last_jiffies = basejiff;
 	ts->timer_expires_base = basemono;
 
-- 
2.39.2

