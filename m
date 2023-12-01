Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7222D8006E1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378137AbjLAJ1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378030AbjLAJ1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:27:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E0F1731
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:27:17 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701422835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JrX+uOonkdlgOULBTRJ+tPCkJgZ/y8AeNa7bH45nGMA=;
        b=D5XrFnLBsbY5lkVSgkpnNLWdRfAh8BRN6Ig8U6EK79iQ7Zz6/XWyZ79d2M5HXR5I74m+Pg
        S2hARumZwAdv8qw3krKtquSgSCKHqHiLz+BWE4T0RiujFRl5MC0AqCSeVPs3cVP7Qy8QTt
        BhTFkQaRlJPXDnkOTYvZAkLppDQPesiYyCwodQABI0CGKBDr6ryeU3PvmE3eKTtphN6BN5
        vZ6ZXUk6bXGQAKaLiOeCpTyaEQEBor8J2m5oteVUECBzkbP15etoSFY8qeoidjKwOILaA6
        vmJKuQ90tjl4f8jjJJDBqc7RPGnDbvC09YC3jWkqB+JV1J73vhnXmj6HVmW2MQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701422835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JrX+uOonkdlgOULBTRJ+tPCkJgZ/y8AeNa7bH45nGMA=;
        b=Mla+AechBwy5Fc5CLuvFJk+kdfUcABs97vqRw9ixz3j4sPEqx0f9eeiOBVWA3gXcymuY6G
        1eT8gT1dpYXIoHCA==
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
Subject: [PATCH v9 14/32] timers: Split out get next timer interrupt
Date:   Fri,  1 Dec 2023 10:26:36 +0100
Message-Id: <20231201092654.34614-15-anna-maria@linutronix.de>
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

Split out get_next_timer_interrupt() to be able to extend it and make it
reusable for other call sites.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v9: Move whole get_next_timer_interrupt() into a separate function instead
    of splitting the bits and pieces.
---
 kernel/time/timer.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 9d377ebb7395..c9f7f86e95fd 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1911,15 +1911,7 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
 	return DIV_ROUND_UP_ULL(nextevt, TICK_NSEC) * TICK_NSEC;
 }
 
-/**
- * get_next_timer_interrupt - return the time (clock mono) of the next timer
- * @basej:	base time jiffies
- * @basem:	base time clock monotonic
- *
- * Returns the tick aligned clock monotonic time of the next pending
- * timer or KTIME_MAX if no timer is pending.
- */
-u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
+static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem)
 {
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
 	unsigned long nextevt = basej + NEXT_TIMER_MAX_DELTA;
@@ -1975,6 +1967,19 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	return cmp_next_hrtimer_event(basem, expires);
 }
 
+/**
+ * get_next_timer_interrupt() - return the time (clock mono) of the next timer
+ * @basej:	base time jiffies
+ * @basem:	base time clock monotonic
+ *
+ * Returns the tick aligned clock monotonic time of the next pending
+ * timer or KTIME_MAX if no timer is pending.
+ */
+u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
+{
+	return __get_next_timer_interrupt(basej, basem);
+}
+
 /**
  * timer_clear_idle - Clear the idle state of the timer base
  *
-- 
2.39.2

