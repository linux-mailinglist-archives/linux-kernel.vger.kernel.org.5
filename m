Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D498006DE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378114AbjLAJ1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378047AbjLAJ1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:27:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7992E172E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:27:16 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701422835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eWAzXEfpMywLlqp587KxIHRrk44Rp7dtxL6JlN1/eF4=;
        b=nrPDcWG6y+EdgnAwLZJrMGEaTSj4fpLZbHu1F5MYX4pNfm8XwdDmfbaq3+Qfw75U13WXlN
        Wn/03lvZN5wgl5keYEfUyqe+Ren56ovfCTN73gvsCHyVcgnrOaxR6UU35FeZKoPn9cXLqx
        HnQJ41b5XrnUqb9KygJlhKObBRbD0CBisK8MgF7pi4EzW1AySz6TKSzWbQeWz/O25sSOGI
        mUcxSvIcwOCrfPKPMKcjfpRPDQXVMO/6pXJSNwHje+BVCkdOMwdyCG52Y5obMfOKXuqsrz
        xPK5vVvU53qVkzQ12pNGeND+dF67+YhA8Kfco1uSKz+rFzdJHkWzTHobUjGZJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701422835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eWAzXEfpMywLlqp587KxIHRrk44Rp7dtxL6JlN1/eF4=;
        b=ejl4p2jWf2hUodAxU46BdlFPsS0jUview2NzC2fTxisTms7SzXjFDnFPfiT065gMEKHznq
        UDzdpbW485YF6UAw==
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
Subject: [PATCH v9 13/32] timers: Restructure get_next_timer_interrupt()
Date:   Fri,  1 Dec 2023 10:26:35 +0100
Message-Id: <20231201092654.34614-14-anna-maria@linutronix.de>
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

get_next_timer_interrupt() contains two parts for the next timer interrupt
calculation. Those two parts are separated by forwarding the base
clock. But the second part does not depend on the forwarded base
clock.

Therefore restructure get_next_timer_interrupt() to keep things together
which belong together.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v9: New patch to eases patch "timers: Split out get next timer functionality"
---
 kernel/time/timer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 4dffe966424c..9d377ebb7395 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1936,12 +1936,6 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	if (base->next_expiry_recalc)
 		next_expiry_recalc(base);
 
-	/*
-	 * We have a fresh next event. Check whether we can forward the
-	 * base.
-	 */
-	__forward_timer_base(base, basej);
-
 	if (base->timers_pending) {
 		nextevt = base->next_expiry;
 
@@ -1959,6 +1953,12 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 		base->next_expiry = nextevt;
 	}
 
+	/*
+	 * We have a fresh next event. Check whether we can forward the
+	 * base.
+	 */
+	__forward_timer_base(base, basej);
+
 	/*
 	 * Base is idle if the next event is more than a tick away.
 	 *
-- 
2.39.2

