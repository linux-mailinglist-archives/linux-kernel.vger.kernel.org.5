Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353EB7B7F40
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242458AbjJDMgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242399AbjJDMfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:35:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670A8E8
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:35:35 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696422934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mz5QdBnNgn288WAkuPYs1KdwbgiRL6T25mdaPooSrW8=;
        b=dcV/kah2sZANpyHtK1hKbSQiHNfz+pTcJF2EgsNt7jDpGibYjJsseIJ7OFgnJMkHFiv3p2
        /pbWKF0G4x6E3qkx2rEANukPZvRYE1LHnMXvnEc0VSk7n1BnDGThcVuwfs7+fWy4PGfXiF
        m6Ktz2/fpAJR4AEpNbwPzA176y6uo/OHjupwRhUnC6boE1L07Gbka/dayr5kIc4PQt9GMu
        EUk86yjNl4sTOh8cfbdkIOKy6o99zD2Dx/pZ+BSZgQIMQY6U9PMg94SFos12YntSw1yhmY
        j3nz4JCISPYPboOLSG0QxW5N7DpZKPC0PrBxcGPqnCNwGh0taOVkx5dZTfFZpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696422934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mz5QdBnNgn288WAkuPYs1KdwbgiRL6T25mdaPooSrW8=;
        b=6yDPT0oLpbTKkm3ZNkk1/ZTUhSmoN0AelRNlyHvFGnRA2sh9eda4y8KSlCP0/klza4pdeO
        o+ABVbI11HfuZcAA==
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
Subject: [PATCH v8 14/25] timers: Ease code in run_local_timers()
Date:   Wed,  4 Oct 2023 14:34:43 +0200
Message-Id: <20231004123454.15691-15-anna-maria@linutronix.de>
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

The logic for raising a softirq the way it is implemented right now, is
readable for two timer bases. When increasing numbers of timer bases, code
gets harder to read. With the introduction of the timer migration
hierarchy, there will be three timer bases.

Therefore ease the code. No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
v5: New patch to decrease patch size of follow up patches
---
 kernel/time/timer.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 853a8ee48ffc..1aafa0edc74c 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2123,16 +2123,14 @@ static void run_local_timers(void)
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
 
 	hrtimer_run_queues();
-	/* Raise the softirq only if required. */
-	if (time_before(jiffies, base->next_expiry)) {
-		if (!IS_ENABLED(CONFIG_NO_HZ_COMMON))
-			return;
-		/* CPU is awake, so check the deferrable base. */
-		base++;
-		if (time_before(jiffies, base->next_expiry))
+
+	for (int i = 0; i < NR_BASES; i++, base++) {
+		/* Raise the softirq only if required. */
+		if (time_after_eq(jiffies, base->next_expiry)) {
+			raise_softirq(TIMER_SOFTIRQ);
 			return;
+		}
 	}
-	raise_softirq(TIMER_SOFTIRQ);
 }
 
 /*
-- 
2.39.2

