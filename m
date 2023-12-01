Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170078006D5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378040AbjLAJ1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378020AbjLAJ1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:27:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A980E194
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:27:09 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701422828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TpL4QHNJmRbyjNaiO3+z9ClPjQHijZRgI0ccvQpegrw=;
        b=UJJq6nocAW/HiAnWK8GyTPEfN1oOPO+9lXJFr9C7HGZTAE0APcdz0FcSis+Nc63mNgmw7f
        DQPc5vLiU1FzKvIj7a/2povI1jdnoqtwEcyQ4eoRRnp+/slR/Hg9n99bO/DdzE97DLkd42
        hzRcSz+mTyBFBysF7BFmGGc2ExkPoKocraYbLNw8ngI0NZCg+akvnglvPjX9CmYUNTqa0i
        Z+SVu3HynyVTQZWf/Bm6/K2wD5JvHi04S7bTy8ANUEXKTMjAfXPp71O+NVOGHyTBwtWZ62
        Jt2ZkJr4otEraNlGF8lGS4zufaLNY/yoA57SyGoui/zyn0ZZgM4oNgQ8y6fvlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701422828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TpL4QHNJmRbyjNaiO3+z9ClPjQHijZRgI0ccvQpegrw=;
        b=iUF3pD/b/ZHxN9ryp4qCxj+pHqQ1FCpLeP6M2yWc0rOxGEeo31fEwzQLExz/7zDZSZEI2g
        JFxHUEpcXyBZvzCA==
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
Subject: [PATCH v9 03/32] tick-sched: Warn when next tick seems to be in the past
Date:   Fri,  1 Dec 2023 10:26:25 +0100
Message-Id: <20231201092654.34614-4-anna-maria@linutronix.de>
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

When the next tick is in the past, the delta between basemono and the next
tick gets negativ. But the next tick should never be in the past. The
negative effect of a wrong next tick might be a stop of the tick and timers
might expire late.

To prevent expensive debugging when changing underlying code, add a
WARN_ON_ONCE into this code path. To prevent complete misbehaviour, also
reset next_tick to basemono in this case.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v9: Add reset of next_tick to basemono
---
 kernel/time/tick-sched.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 89517cfb6510..b1b591de781e 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -839,6 +839,10 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 		ts->next_timer = next_tick;
 	}
 
+	/* Make sure next_tick is never before basemono! */
+	if (WARN_ON_ONCE(basemono > next_tick))
+		next_tick = basemono;
+
 	/*
 	 * If the tick is due in the next period, keep it ticking or
 	 * force prod the timer.
-- 
2.39.2

