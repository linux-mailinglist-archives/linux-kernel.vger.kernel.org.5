Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC937B7F3E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242396AbjJDMgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242398AbjJDMfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:35:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC939E3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:35:34 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696422933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9vhsM+uCD+bRTV7auZs4wdMq75JFKQoeaDSLzvQWIuw=;
        b=AZrpuIUBupEwhI/vllltdbYxH4NadgULzlfSmoFHxwCreO6WBp4lvLieme4ivLCZ4s9eKz
        jMv/s3vINkZmsWe6iGANmXnwh8+jqwrcyvbFNtkXRgrmI+U4OluF54NPcQhX+IM0/C4guD
        WZpGDczq3Xn1JLyxcAzHWlFKL9Rg3NQAISXN0Kr3/Lsb+rFkMMdZVCq8uTHoqPMcswjf26
        ZR0ntNmKWnt3MH3ym/xDiSCSuHSvSa0Ghm8I5kiEn2f/HlRK0cVNGhO7kfHSLHuqDHdvo9
        jZKrHU+wETRoLbfZ+8e/YnDiYNsk/pfQzV24S3G/OHp/oTNeaEHS+QyDJPtezQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696422933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9vhsM+uCD+bRTV7auZs4wdMq75JFKQoeaDSLzvQWIuw=;
        b=aTFajETp4frynwLO5rtXBAmWDbop9zYbQLoj4X5p5R3VeHN0d6zgHdqNtmphS9NNxh08SO
        c1dWsIdJFU315qDA==
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
Subject: [PATCH v8 13/25] timer: add_timer_on(): Make sure TIMER_PINNED flag is set
Date:   Wed,  4 Oct 2023 14:34:42 +0200
Message-Id: <20231004123454.15691-14-anna-maria@linutronix.de>
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

When adding a timer to the timer wheel using add_timer_on(), it is an
implicitly pinned timer. With the timer pull at expiry time model in place,
TIMER_PINNED flag is required to make sure timers end up in proper base.

Add TIMER_PINNED flag unconditionally when add_timer_on() is executed.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/timer.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 3172b8094097..853a8ee48ffc 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1284,7 +1284,10 @@ EXPORT_SYMBOL(add_timer_global);
  * @timer:	The timer to be started
  * @cpu:	The CPU to start it on
  *
- * Same as add_timer() except that it starts the timer on the given CPU.
+ * Same as add_timer() except that it starts the timer on the given CPU and
+ * the TIMER_PINNED flag is set. When timer shouldn't be a pinned timer in
+ * the next round, add_timer_global() should be used instead as it unsets
+ * the TIMER_PINNED flag.
  *
  * See add_timer() for further details.
  */
@@ -1298,6 +1301,9 @@ void add_timer_on(struct timer_list *timer, int cpu)
 	if (WARN_ON_ONCE(timer_pending(timer)))
 		return;
 
+	/* Make sure timer flags have TIMER_PINNED flag set */
+	timer->flags |= TIMER_PINNED;
+
 	new_base = get_timer_cpu_base(timer->flags, cpu);
 
 	/*
-- 
2.39.2

