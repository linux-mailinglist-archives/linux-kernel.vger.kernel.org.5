Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC0A7B7F4F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242635AbjJDMgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242393AbjJDMfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:35:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FB6D9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:35:33 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696422932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R6p91zzmcTgFtBegVAgz86f9rPOZl2ESGLLtaCGNKmE=;
        b=tD5J+oiaWrqrU1ELhMzwRcDVY01AqSqRWzluw0BE0LA9bqRLkpt/mTPfu/6X5qYIQm7/6r
        azGNPmxrTGX7M2KTsSaEQRGMORPVKnsrDvvFjl+6VtmnFZkZxfhv0EHg11C43a9GDqIK8v
        hObFc6IZs5xltBwsQNQqQdhb+2tQyhVnb2M8nZ9EOzfOPwZT9WKv38d4wGpGPnyYvdfBa4
        haJBSp9CEa4z2BOe6Gn/QavcG2GTsHfKTbAklvgqN2PhubiqwOBTL4eEuIe42UwiNbHReY
        QIK0UzjalspQk7MYaH2vRt2OIs8Hy+joCll0qaReQlsAc9J9mxb6NkTJmI3QmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696422932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R6p91zzmcTgFtBegVAgz86f9rPOZl2ESGLLtaCGNKmE=;
        b=p4HI0TmibWqsmsZsVt86GITKCM8Cm5JkQzQKKPtx1yqL/g4yCL49TSeheoAImYhl51+X6o
        DFLUUenUA6uxCwAw==
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
Subject: [PATCH v8 11/25] timers: Introduce add_timer() variants which modify timer flags
Date:   Wed,  4 Oct 2023 14:34:40 +0200
Message-Id: <20231004123454.15691-12-anna-maria@linutronix.de>
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

Timer might be used as pinned timer (using add_timer_on()) and later on as
non pinned timers using add_timer(). When the NOHZ timer pull at expiry
model is in place, TIMER_PINNED flag is required to be used whenever a
timer needs to expire on a dedicated CPU. Flag must no be set, if
expiration on a dedicated CPU is not required.

add_timer_on()'s behavior will be changed during the preparation patches
for the NOHZ timer pull at expiry model to unconditionally set TIMER_PINNED
flag. To be able to reset/set the flag when queueing a timer, two variants
of add_timer() are introduced.

This is a preparatory patch and has no functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
New in v6
---
 include/linux/timer.h |  2 ++
 kernel/time/timer.c   | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 9162f275819a..6f96661480dd 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -180,6 +180,8 @@ extern int timer_reduce(struct timer_list *timer, unsigned long expires);
 #define NEXT_TIMER_MAX_DELTA	((1UL << 30) - 1)
 
 extern void add_timer(struct timer_list *timer);
+extern void add_timer_local(struct timer_list *timer);
+extern void add_timer_global(struct timer_list *timer);
 
 extern int try_to_del_timer_sync(struct timer_list *timer);
 extern int timer_delete_sync(struct timer_list *timer);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 8518f7aa7319..3172b8094097 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1245,6 +1245,40 @@ void add_timer(struct timer_list *timer)
 }
 EXPORT_SYMBOL(add_timer);
 
+/**
+ * add_timer_local - Start a timer on the local CPU
+ * @timer:	The timer to be started
+ *
+ * Same as add_timer() except that the timer flag TIMER_PINNED is set.
+ *
+ * See add_timer() for further details.
+ */
+void add_timer_local(struct timer_list *timer)
+{
+	if (WARN_ON_ONCE(timer_pending(timer)))
+		return;
+	timer->flags |= TIMER_PINNED;
+	__mod_timer(timer, timer->expires, MOD_TIMER_NOTPENDING);
+}
+EXPORT_SYMBOL(add_timer_local);
+
+/**
+ * add_timer_global - Start a timer without TIMER_PINNED flag set
+ * @timer:	The timer to be started
+ *
+ * Same as add_timer() except that the timer flag TIMER_PINNED is unset.
+ *
+ * See add_timer() for further details.
+ */
+void add_timer_global(struct timer_list *timer)
+{
+	if (WARN_ON_ONCE(timer_pending(timer)))
+		return;
+	timer->flags &= ~TIMER_PINNED;
+	__mod_timer(timer, timer->expires, MOD_TIMER_NOTPENDING);
+}
+EXPORT_SYMBOL(add_timer_global);
+
 /**
  * add_timer_on - Start a timer on a particular CPU
  * @timer:	The timer to be started
-- 
2.39.2

