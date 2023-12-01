Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA2C8006D9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378062AbjLAJ1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378026AbjLAJ1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:27:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96970A0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:27:11 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701422830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l1TO/DAtk+CCicSFDRPTxsBfrzcdsd2AUHicFvATynM=;
        b=lum7zhufPRoUPgr02L0+nr6ewMLlA4ZRnPpDBOK7AYfwxMTiURnHboUx9eXPXfeoKFWlWj
        6K+fqA2/enXeTY+rxTb1bTvUDQYkIxGrDrSeYCwkD//wVE4rieb8koOh1FJ9VKWKxJwN8c
        q5GIv3tz1v6iJiiz2G8tevShutyRoQfx3C46SmF+O6uXo3GD6xEn8IhesLlwiSlwRNdOqM
        FawdCuytlVmtP3sAwki1uQ19SKXShRHkMkfB05uFcoe2elWHOYpMt7SLi2qpM36+ZHZwOy
        k7zjR6RvzhBQMC/lMuSWkxYfSLELuEZ774PPMwGX9rXn+QzoqxVdTm8Aw805Kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701422830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l1TO/DAtk+CCicSFDRPTxsBfrzcdsd2AUHicFvATynM=;
        b=H7J7pHY41+OQTTMvDQDwvpdtt26MF/g+9en13VW2NJaVstqWvRjxzwwVa7UwAS0FehJC09
        PPxAiRB4LLN99jBQ==
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
Subject: [PATCH v9 06/32] timers: Do not IPI for deferrable timers
Date:   Fri,  1 Dec 2023 10:26:28 +0100
Message-Id: <20231201092654.34614-7-anna-maria@linutronix.de>
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

Deferrable timers do not prevent CPU from going idle and are not taken into
account on idle path. Sending an IPI to a remote CPU when a new first
deferrable timer was enqueued will wake up the remote CPU but nothing will
be done regarding the deferrable timers.

Drop IPI completely when a new first deferrable timer was enqueued.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
v9: Only a typo fix

v8: Update comment

v6: new patch
---
 kernel/time/timer.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 46a9b96a3976..a6e31b09637c 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -571,18 +571,15 @@ static int calc_wheel_index(unsigned long expires, unsigned long clk,
 static void
 trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
 {
-	if (!is_timers_nohz_active())
-		return;
-
 	/*
-	 * TODO: This wants some optimizing similar to the code below, but we
-	 * will do that when we switch from push to pull for deferrable timers.
+	 * Deferrable timers do not prevent the CPU from entering dynticks and
+	 * are not taken into account on the idle/nohz_full path. An IPI when a
+	 * new deferrable timer is enqueued will wake up the remote CPU but
+	 * nothing will be done with the deferrable timer base. Therefore skip
+	 * the remote IPI for deferrable timers completely.
 	 */
-	if (timer->flags & TIMER_DEFERRABLE) {
-		if (tick_nohz_full_cpu(base->cpu))
-			wake_up_nohz_cpu(base->cpu);
+	if (!is_timers_nohz_active() || timer->flags & TIMER_DEFERRABLE)
 		return;
-	}
 
 	/*
 	 * We might have to IPI the remote CPU if the base is idle and the
-- 
2.39.2

