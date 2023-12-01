Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6958006D8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378059AbjLAJ1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378024AbjLAJ1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:27:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E533510F3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:27:10 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701422829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x5NV8oLmppm4cChtNeoTUNwitHPz66rl4TtkJG1MsVE=;
        b=ACJG9BLnPweNxaHJJ9w1pbi+SRth6MXk+ue7mImxGjl0rf06m9//BXNESvnefcAi865eVp
        HYPHH88orIdDbxTxm6maC9Z7zjntcMuoGw+mucvviLDTWAizOZTFZb3cR0lB9l9VR/YNZ2
        XThDs7w8kH85z4y9wuHUBDLuV04+NHpj5jZFQwuLoD1AFW0uGzvPXdi0y5cYapX6LTZk+6
        sRTA+PR1Tq1vVNVKY5wlJ92DCMEjLBV6bANERRrmFxSDeOraYXvp1AI2n+5WJao2xPnuyI
        wNBYPxJiugPji/XfpCYlL5YpmVuIMRE2jvgKEs6sgx+JgsjcFf/iMB+WUJNczg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701422829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x5NV8oLmppm4cChtNeoTUNwitHPz66rl4TtkJG1MsVE=;
        b=lV7jqkG/73jefeFGIVa0cvbImUlcDQjpHBuRgRZzzHojWnwJUlYoDZ+Hr85NjGiyrNZEyE
        1qQTNsPXqXlEXZCQ==
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
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v9 05/32] tracing/timers: Add tracepoint for tracking timer base is_idle flag
Date:   Fri,  1 Dec 2023 10:26:27 +0100
Message-Id: <20231201092654.34614-6-anna-maria@linutronix.de>
In-Reply-To: <20231201092654.34614-1-anna-maria@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When debugging timer code the timer tracepoints are very important. There
is no tracepoint when the is_idle flag of the timer base changes. Instead
of always adding manually trace_printk(), add tracepoints which can be
easily enabled whenever required.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v9: New in v9
---
 include/trace/events/timer.h | 20 ++++++++++++++++++++
 kernel/time/timer.c          |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index 99ada928d445..1ef58a04fc57 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -142,6 +142,26 @@ DEFINE_EVENT(timer_class, timer_cancel,
 	TP_ARGS(timer)
 );
 
+TRACE_EVENT(timer_base_idle,
+
+	TP_PROTO(bool is_idle, unsigned int cpu),
+
+	TP_ARGS(is_idle, cpu),
+
+	TP_STRUCT__entry(
+		__field( bool,		is_idle	)
+		__field( unsigned int,	cpu	)
+	),
+
+	TP_fast_assign(
+		__entry->is_idle	= is_idle;
+		__entry->cpu		= cpu;
+	),
+
+	TP_printk("is_idle=%d cpu=%d",
+		  __entry->is_idle, __entry->cpu)
+);
+
 #define decode_clockid(type)						\
 	__print_symbolic(type,						\
 		{ CLOCK_REALTIME,	"CLOCK_REALTIME"	},	\
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index a81d793a43d0..46a9b96a3976 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1964,6 +1964,7 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 		if ((expires - basem) > TICK_NSEC)
 			base->is_idle = true;
 	}
+	trace_timer_base_idle(base->is_idle, base->cpu);
 	raw_spin_unlock(&base->lock);
 
 	return cmp_next_hrtimer_event(basem, expires);
@@ -1985,6 +1986,7 @@ void timer_clear_idle(void)
 	 * the lock in the exit from idle path.
 	 */
 	base->is_idle = false;
+	trace_timer_base_idle(0, smp_processor_id());
 }
 #endif
 
-- 
2.39.2

