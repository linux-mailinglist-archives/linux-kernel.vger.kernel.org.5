Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297FC7B7F3C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242402AbjJDMfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbjJDMfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:35:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF98A9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:35:30 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696422928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fTra8o64I3zbTAJb74gQJVLr6rBx5QpDSUDk/VGWLOU=;
        b=sA0UW/pvV/0I55AunJMU0m83CMjHJk5r5kdLxlyfE5RHs6n2hfsQX33oRxvi9/LC/hLyyf
        acAxxQ3LRzUlbNQApBnpa9BDd6PU0ElLSc88hLv0grsakqDGORuuYTfl5ytsnTF/bMcT+g
        LsWtmKJB8Z932SK3BDWZQXgpBIvlwm3vnS6oVRM18V+RDQzbyOV5I8+v9wg8dSCRrX6sZb
        CX3TGzAQNFADyBimYEDHtOmCjkjKt1NZMvyELWh8/IlYe9CSvymheg5VuMVYjyh/h3+nzS
        qwmncbE0c2RxFcLJ4fwM4jVwBwhPUiKpz4odW2lj6e1xqfYajr6buP+Ip0gpMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696422928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fTra8o64I3zbTAJb74gQJVLr6rBx5QpDSUDk/VGWLOU=;
        b=rPMWo+lOy4PE80VFeDYCp2Y6PFaJPY1u8tmVAKOXxSKx1uhqwSb5Gl87jgPVYAz7ibOnqC
        WpV+cYoGPUx5t9Bw==
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
Subject: [PATCH v8 05/25] timers: Clarify check in forward_timer_base()
Date:   Wed,  4 Oct 2023 14:34:34 +0200
Message-Id: <20231004123454.15691-6-anna-maria@linutronix.de>
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

The current check whether a forward of the timer base is required can be
simplified by using an already existing comparison function which is easier
to read. The related comment is outdated and was not updated when the check
changed in commit 36cd28a4cdd0 ("timers: Lower base clock forwarding
threshold").

Use time_before_eq() for the check and replace the comment by copying the
comment from the same check inside get_next_timer_interrupt().

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timer.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 5e17244a9465..31aed8353db1 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -944,11 +944,10 @@ static inline void forward_timer_base(struct timer_base *base)
 	unsigned long jnow = READ_ONCE(jiffies);
 
 	/*
-	 * No need to forward if we are close enough below jiffies.
-	 * Also while executing timers, base->clk is 1 offset ahead
-	 * of jiffies to avoid endless requeuing to current jiffies.
+	 * Check whether we can forward the base. We can only do that when
+	 * @basej is past base->clk otherwise we might rewind base->clk.
 	 */
-	if ((long)(jnow - base->clk) < 1)
+	if (time_before_eq(jnow, base->clk))
 		return;
 
 	/*
-- 
2.39.2

