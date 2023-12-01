Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A5C8006DD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378106AbjLAJ1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378065AbjLAJ1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:27:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A8B171A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:27:14 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701422833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+S43URzdkm4GE5deeh35HedlVNn9pKmfGb0vCPSVNJU=;
        b=el5AdGLCIQZcbBus9nb/xgs+vY+Tv76/155OcrpNkNOjUWHu2Iay04ijEup/CZKYAfF+qh
        sLqmjFN9GHKVRUzf9cRZklprE52pJ9L8kUfKjnGdDNVQK2XqUFEQ+6+hzipfaedbaRthZm
        6Kl2Obge+HPzfqeWxSHmaScooCQbrXk8SOQ3Ik/mN0vTv4iSaOEZbdKEONwbdxIV5BJU/E
        WNrcDanyKol7UClRMoZbNgCpdqMNa08bdC3xYLNna5+c2HQf/8kKGMT+GtVdqx2WIXo3RJ
        RgKdDCKh3NQUBx0fiAdJKLos3M2mXq790/QjjGt3MOHAEXZREpaJo/p+qtLbPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701422833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+S43URzdkm4GE5deeh35HedlVNn9pKmfGb0vCPSVNJU=;
        b=HxtFSzHBtGc0DacUydRzFJpAQaTMJ4mc5tul79/rcY9HP9L9pECbfeBHsmnvjQJFudbZJQ
        DO5tluaLRIL1/YCA==
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
Subject: [PATCH v9 10/32] timers: Use already existing function for forwarding timer base
Date:   Fri,  1 Dec 2023 10:26:32 +0100
Message-Id: <20231201092654.34614-11-anna-maria@linutronix.de>
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

There is an already existing function for forwarding the timer
base. Forwarding the timer base is implemented directly in
get_next_timer_interrupt() as well.

Remove the code duplication and invoke __forward_timer_base() instead.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/timer.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index e289cbd84e8c..fee42dda8237 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1939,15 +1939,9 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 
 	/*
 	 * We have a fresh next event. Check whether we can forward the
-	 * base. We can only do that when @basej is past base->clk
-	 * otherwise we might rewind base->clk.
+	 * base.
 	 */
-	if (time_after(basej, base->clk)) {
-		if (time_after(nextevt, basej))
-			base->clk = basej;
-		else if (time_after(nextevt, base->clk))
-			base->clk = nextevt;
-	}
+	__forward_timer_base(base, basej);
 
 	if (time_before_eq(nextevt, basej)) {
 		expires = basem;
-- 
2.39.2

