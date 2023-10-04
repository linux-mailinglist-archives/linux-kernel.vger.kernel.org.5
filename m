Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C695D7B7F3B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242373AbjJDMfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242362AbjJDMfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:35:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A438193
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:35:30 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696422929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W54m7rvqf/KqCMpTV79oOtmZr9LItvdWHEN45lcUeaw=;
        b=Efrc1xoorJOzy8tsALP1Bhr1M7Nxl+bJb/TLuAn1JJNB+EXwQE2BEjWHaW9r482myE0wWL
        uyLPSjVJw/V3m5a2xAAfe0w7iX/ytMsCbLv2tlTECGXATITJthK/1y6An9HyHv+7ky8UNx
        fnHJSOY2T7+agSXCrPYFIOj9ItFLcUo0G7iR/mN98qfQSUB2Ws3EteNzW/outR2GYMFdcx
        ZFt0ZjSVe6aKa5SGx5o1vMRv+CpHEF2kFZa1OL6kuHQgkcL0dIRC0Sc9kL61V9WnqSZppx
        f6yrhTvO2oWkhTA1l9pdm8ybiwUDZcfyp9uv9BD0L4FC9nMTEMZCKyY5jcB3Pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696422929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W54m7rvqf/KqCMpTV79oOtmZr9LItvdWHEN45lcUeaw=;
        b=HnIgZMU7Y2g9X5WBxvEHh86H4zJMqVCS4RU8TGz0WgX52KTUJ1COlkvacxUBh/tihoDYYG
        6WDL1TBNzELczOCg==
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
Subject: [PATCH v8 06/25] timers: Split out forward timer base functionality
Date:   Wed,  4 Oct 2023 14:34:35 +0200
Message-Id: <20231004123454.15691-7-anna-maria@linutronix.de>
In-Reply-To: <20231004123454.15691-1-anna-maria@linutronix.de>
References: <20231004123454.15691-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
---
 kernel/time/timer.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 31aed8353db1..2f6afd1da891 100644
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

