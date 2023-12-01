Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8B08006DC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378100AbjLAJ1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378035AbjLAJ1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:27:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB89710FC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:27:13 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701422832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NX2OtYZi8wYLdH4/EBEFqndbEahIgfLRJkHvTArpnf8=;
        b=1ggAH7wj+axl9TgEGJFZ0/uAb3cs+EW+X/QNAiGkGxhubO1WQ+ye67f57geO0uUgLmkZkL
        HvIPqcMu+1kgF6qnb72qlUj9+XGiJQS0qO4JNx9UYCX5iEGrK9FyAavNTYTSNwNpE9ghjY
        AfDEUuun8UgRzUrq7qEydbw/pXjJWUdOCUkmVDsiEWDsuPTYlj3u1B6Lr6HDIQzL2LG76+
        kQcf4y/R6aiDYIlAQdaPPdghBaLiASdU2NCpEJEfA9zsdj9Hf9ZpuCbdej0w3aUOfxFDWQ
        ZNCAwSvoyAy9aMCi13puWX28GeFSL9rfPfL9btfjxsrP8FzpUmD8JWwSRMXaOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701422832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NX2OtYZi8wYLdH4/EBEFqndbEahIgfLRJkHvTArpnf8=;
        b=FWFW6/pnQLncFa4pPnDKR90jyaAVnwrvB+ARbjuC6CzkQWAsi8kK9Gc2XmjQxcA0arZv6p
        oCcqOjNaJyyrPcDg==
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
Subject: [PATCH v9 09/32] timers: Split out forward timer base functionality
Date:   Fri,  1 Dec 2023 10:26:31 +0100
Message-Id: <20231201092654.34614-10-anna-maria@linutronix.de>
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

Forwarding timer base is done when the next expiry value is calculated and
when a new timer is enqueued. When the next expiry value is calculated the
jiffies value is already available and does not need to be reread a second
time.

Splitting out the forward timer base functionality to make it executable
via both contextes - those where jiffies are already known and those, where
jiffies need to be read.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/timer.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 66bac56909ba..e289cbd84e8c 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -939,30 +939,34 @@ get_target_base(struct timer_base *base, unsigned tflags)
 	return get_timer_this_cpu_base(tflags);
 }
 
-static inline void forward_timer_base(struct timer_base *base)
+static inline void __forward_timer_base(struct timer_base *base,
+					unsigned long basej)
 {
-	unsigned long jnow = READ_ONCE(jiffies);
-
 	/*
 	 * Check whether we can forward the base. We can only do that when
 	 * @basej is past base->clk otherwise we might rewind base->clk.
 	 */
-	if (time_before_eq(jnow, base->clk))
+	if (time_before_eq(basej, base->clk))
 		return;
 
 	/*
 	 * If the next expiry value is > jiffies, then we fast forward to
 	 * jiffies otherwise we forward to the next expiry value.
 	 */
-	if (time_after(base->next_expiry, jnow)) {
-		base->clk = jnow;
+	if (time_after(base->next_expiry, basej)) {
+		base->clk = basej;
 	} else {
 		if (WARN_ON_ONCE(time_before(base->next_expiry, base->clk)))
 			return;
 		base->clk = base->next_expiry;
 	}
+
 }
 
+static inline void forward_timer_base(struct timer_base *base)
+{
+	__forward_timer_base(base, READ_ONCE(jiffies));
+}
 
 /*
  * We are using hashed locking: Holding per_cpu(timer_bases[x]).lock means
-- 
2.39.2

