Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860857B7F37
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242390AbjJDMfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242353AbjJDMfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:35:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5EEC1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:35:29 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696422928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MAxMuF84OJMFwj1mVQcHjPmQ7zTcHiYKK0tzuJi+A1g=;
        b=NGiVHVMKQ89c2HqOfoJKJwMmDbG3+ohTltyLW1E7IzR22caosCulch2P490f0kWBtaRGbd
        KP5bDXJydfUfFPuGaFqTJoEaiU4X8XdW6VuMYFTjcxawK5VKBkZp+P2ru5yzT2IChIeBl2
        h9hafLvRBdvbqm0ZSRTQGkIVtuQFJzvxqKInsDdDPIe81yEn0wy1tWSjjQPQSDbV/6nhi7
        2FxeM2e2LTe97EvaNLypD/daOhdNiUaZmnv+Q8j7qp8W8Z9S7NKJCWlmEyeQhv7w42HX9O
        rLCLIWFywCAaqkpPlmTd+TFh4v4M0AjIXALAy3o2Gjit+veJaQMQ0+7mS/TAfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696422928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MAxMuF84OJMFwj1mVQcHjPmQ7zTcHiYKK0tzuJi+A1g=;
        b=gKxbWVn7euG7rhu4l9t6pbj4lH9l8lg3FF9JrO40qXbMHGCaS/OLkU6TC5pL3M6jikIBzB
        /JJFsQ9FYtojaeBg==
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
Subject: [PATCH v8 04/25] timer: Move store of next event into __next_timer_interrupt()
Date:   Wed,  4 Oct 2023 14:34:33 +0200
Message-Id: <20231004123454.15691-5-anna-maria@linutronix.de>
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

Both call sites of __next_timer_interrupt() store return value directly in
base->next_expiry. Move the store into __next_timer_interrupt() and to make
its purpose more clear, rename function to next_expiry_recalc().

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
v6: Fix typos in commit message and drop not required return as suggested
    by Peter Zijlstra

v4: rename function as suggested by Frederic Weisbecker
---
 kernel/time/timer.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 7d06351aff54..5e17244a9465 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1800,8 +1800,10 @@ static int next_pending_bucket(struct timer_base *base, unsigned offset,
 /*
  * Search the first expiring timer in the various clock levels. Caller must
  * hold base->lock.
+ *
+ * Store next expiry time in base->next_expiry.
  */
-static unsigned long __next_timer_interrupt(struct timer_base *base)
+static void next_expiry_recalc(struct timer_base *base)
 {
 	unsigned long clk, next, adj;
 	unsigned lvl, offset = 0;
@@ -1867,10 +1869,9 @@ static unsigned long __next_timer_interrupt(struct timer_base *base)
 		clk += adj;
 	}
 
+	base->next_expiry = next;
 	base->next_expiry_recalc = false;
 	base->timers_pending = !(next == base->clk + NEXT_TIMER_MAX_DELTA);
-
-	return next;
 }
 
 #ifdef CONFIG_NO_HZ_COMMON
@@ -1930,7 +1931,7 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 
 	raw_spin_lock(&base->lock);
 	if (base->next_expiry_recalc)
-		base->next_expiry = __next_timer_interrupt(base);
+		next_expiry_recalc(base);
 	nextevt = base->next_expiry;
 
 	/*
@@ -2013,7 +2014,7 @@ static inline void __run_timers(struct timer_base *base)
 		WARN_ON_ONCE(!levels && !base->next_expiry_recalc
 			     && base->timers_pending);
 		base->clk++;
-		base->next_expiry = __next_timer_interrupt(base);
+		next_expiry_recalc(base);
 
 		while (levels--)
 			expire_timers(base, heads + levels);
-- 
2.39.2

