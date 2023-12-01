Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9CA8006DB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378013AbjLAJ1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378033AbjLAJ1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:27:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582C510F3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:27:12 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701422830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=abaveLygv3WKLQ70azOX5Nhmi35F03D2H7Exz6wvRjs=;
        b=a1nd9r7lEBC9ci6wUVUgi1hN4JCBZlGitekHspDsibrFdu+pl6/3sTyy+324ahw5Rz8T2d
        uZTYVbFq3MMn/Aork8Mx5jwoQm179AXqZBvu+n7AGwyQykOZik6lmJ1xXTsu7yTmC/HkdF
        52j3JYYAPDW4Jg3KME89B0f6l7d6zprctDbQgkcff1pjV5mC/jwRLOLQoZ3LolluWMH1mH
        YXyx1z+xAybkeuZWQL3+Nc/UPifl2f29OmDqW1J2HjXXELtCOe0OrwmJDsD96TOeH86fTW
        Sx8OSCuD5mmbxt7QitqcraPf+7fQ+bdykkWeOR1RtVUiv6anLw2D4wUnaXBKgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701422830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=abaveLygv3WKLQ70azOX5Nhmi35F03D2H7Exz6wvRjs=;
        b=e0qcp8TwrijRK7VdVHlEYhM6yUkMF56vK2jMfSzEgzTaI8OYcOICJciV0hJSwlLduf3n9/
        MRWLn7kdMu364XBA==
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
Subject: [PATCH v9 07/32] timers: Move store of next event into __next_timer_interrupt()
Date:   Fri,  1 Dec 2023 10:26:29 +0100
Message-Id: <20231201092654.34614-8-anna-maria@linutronix.de>
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

Both call sites of __next_timer_interrupt() store the return value directly
in base->next_expiry. Move the store into __next_timer_interrupt() and to
make its purpose more clear, rename the function to next_expiry_recalc().

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
v9: Typo fix only

v6: Fix typos in commit message and drop not required return as suggested
    by Peter Zijlstra

v4: rename function as suggested by Frederic Weisbecker
---
 kernel/time/timer.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index a6e31b09637c..3ca706db1d20 100644
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
@@ -2015,7 +2016,7 @@ static inline void __run_timers(struct timer_base *base)
 		WARN_ON_ONCE(!levels && !base->next_expiry_recalc
 			     && base->timers_pending);
 		base->clk++;
-		base->next_expiry = __next_timer_interrupt(base);
+		next_expiry_recalc(base);
 
 		while (levels--)
 			expire_timers(base, heads + levels);
-- 
2.39.2

