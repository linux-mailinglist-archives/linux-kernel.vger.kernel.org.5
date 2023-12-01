Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4658006D7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378053AbjLAJ1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378022AbjLAJ1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:27:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E61A10F9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:27:10 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701422828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EuZUVPY6DwMtX6TE4Diotf1s/Z9ALR3JOBYxJlQlrWo=;
        b=OrC8zJ88T958APlVyh4kv8Y7X5oRZogAMT9iZFq2jQjoc72FPD8+2eqTlL+ycyJp5uoy5l
        3odpYGSoVRz5gOZc3hXdLsfql3bkwEFa/2zEDSpsyfIFvvvxxqEZFmjBeWF+Jr7L72PLnS
        FvVXfQ26Gi46CvgV/kOtMvpQR57EHIzfxazh71tMy3Bg5YX38DelZ+j5ORZOvg8PbycxVF
        j3dWdVvRgCkkDrhD/IRT959lpQGbfkPIeSZo9bczNh3QxvTdSAHLnyYPrVF/8GO85T6psE
        On2U2rnGHPTRScX51/upA2x9kRrpgW2hF4aN7+VFa3SOfqaRuuYbztZrmfHTlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701422828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EuZUVPY6DwMtX6TE4Diotf1s/Z9ALR3JOBYxJlQlrWo=;
        b=iu2NM4FKvnMPiISGNsxUiZzqNgZKsu9vKdvxqy/lJSsO8i3PpLvuA/jj5DgC+UXyMKkZjP
        y9PPX1zlI6jeCzDQ==
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
Subject: [PATCH v9 04/32] tracing/timers: Enhance timer_start tracepoint
Date:   Fri,  1 Dec 2023 10:26:26 +0100
Message-Id: <20231201092654.34614-5-anna-maria@linutronix.de>
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

For starting a timer, the timer is enqueued into a bucket of the timer
wheel. The bucket expiry is the defacto expiry of the timer but it is not
equal the timer expiry because of increasing granularity when bucket is in
a higher level of the wheel. To be able to figure out in a trace whether a
timer expired in time or not, the bucket expiry time is required as well.

Add bucket expiry time to the timer_start tracepoint and thereby simplify
the arguments.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v9: New in v9
---
 include/trace/events/timer.h | 20 ++++++++++----------
 kernel/time/timer.c          |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index b4bc2828fa09..99ada928d445 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -46,22 +46,21 @@ DEFINE_EVENT(timer_class, timer_init,
 
 /**
  * timer_start - called when the timer is started
- * @timer:	pointer to struct timer_list
- * @expires:	the timers expiry time
- * @flags:	the timers flags
+ * @timer:		pointer to struct timer_list
+ * @bucket_expiry:	the bucket expiry time
  */
 TRACE_EVENT(timer_start,
 
 	TP_PROTO(struct timer_list *timer,
-		unsigned long expires,
-		unsigned int flags),
+		unsigned long bucket_expiry),
 
-	TP_ARGS(timer, expires, flags),
+	TP_ARGS(timer, bucket_expiry),
 
 	TP_STRUCT__entry(
 		__field( void *,	timer		)
 		__field( void *,	function	)
 		__field( unsigned long,	expires		)
+		__field( unsigned long,	bucket_expiry	)
 		__field( unsigned long,	now		)
 		__field( unsigned int,	flags		)
 	),
@@ -69,15 +68,16 @@ TRACE_EVENT(timer_start,
 	TP_fast_assign(
 		__entry->timer		= timer;
 		__entry->function	= timer->function;
-		__entry->expires	= expires;
+		__entry->expires	= timer->expires;
+		__entry->bucket_expiry	= bucket_expiry;
 		__entry->now		= jiffies;
-		__entry->flags		= flags;
+		__entry->flags		= timer->flags;
 	),
 
-	TP_printk("timer=%p function=%ps expires=%lu [timeout=%ld] cpu=%u idx=%u flags=%s",
+	TP_printk("timer=%p function=%ps expires=%lu [timeout=%ld] bucket_expiry=%lu cpu=%u idx=%u flags=%s",
 		  __entry->timer, __entry->function, __entry->expires,
 		  (long)__entry->expires - __entry->now,
-		  __entry->flags & TIMER_CPUMASK,
+		  __entry->bucket_expiry, __entry->flags & TIMER_CPUMASK,
 		  __entry->flags >> TIMER_ARRAYSHIFT,
 		  decode_timer_flags(__entry->flags & TIMER_TRACE_FLAGMASK))
 );
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 63a8ce7177dd..a81d793a43d0 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -606,7 +606,7 @@ static void enqueue_timer(struct timer_base *base, struct timer_list *timer,
 	__set_bit(idx, base->pending_map);
 	timer_set_idx(timer, idx);
 
-	trace_timer_start(timer, timer->expires, timer->flags);
+	trace_timer_start(timer, bucket_expiry);
 
 	/*
 	 * Check whether this is the new first expiring timer. The
-- 
2.39.2

