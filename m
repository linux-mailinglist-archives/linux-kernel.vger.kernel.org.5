Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725797B7F44
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242413AbjJDMgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242404AbjJDMfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:35:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC677F0
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:35:35 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696422934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pz8RP5Igf6Tpz8GzWwXPtm9q6OrinBuBcc/7z4I5pxE=;
        b=BOmtu4ivdYU3oYnKkDb5HmQBpDOSvMbX/dkOE0+254ai79drRP/yGbyo9UEPydHO/zVnNu
        53pEjywBAMuqf8OQtAnBwuVHO2JCD1u62IQikBtYiR+ALUoPYJxG0X2/LQt2gG0Mv07XwD
        A8bZHp5I9/zuLlGZt+P/XHY/qcZdq7UGxqp4mGouASlDhToFw2cTAPjDRIs6YMY4+Czodv
        1Srrd72499fupEzwkagwz6M8N5hgGh+4XikHbtJwE6ptxPX+g707DMIkjGb/T+e6h+WiE4
        j2izWFog0+uPaxcCy0L75B5Qx+c1KSwNwiId4uUHos46AIdl0thPu0qD5F+fxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696422934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pz8RP5Igf6Tpz8GzWwXPtm9q6OrinBuBcc/7z4I5pxE=;
        b=V2dSsPDW7CR9I5JAq3+WZfAkcwN/At9CYrDwXDO/EusJ8FoXnZAClGdw4eUR1ozqH1XMvV
        +/AHhP4uQ+bf3zCQ==
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
Subject: [PATCH v8 15/25] timer: Split next timer interrupt logic
Date:   Wed,  4 Oct 2023 14:34:44 +0200
Message-Id: <20231004123454.15691-16-anna-maria@linutronix.de>
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

Logic for getting next timer interrupt (no matter of recalculated or
already stored in base->next_expiry) is split into a separate function
"next_timer_interrupt()" to make it available for new call sites.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/timer.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 1aafa0edc74c..7468a805d302 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1951,14 +1951,20 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
 	return DIV_ROUND_UP_ULL(nextevt, TICK_NSEC) * TICK_NSEC;
 }
 
+static unsigned long next_timer_interrupt(struct timer_base *base)
+{
+	if (base->next_expiry_recalc)
+		next_expiry_recalc(base);
+
+	return base->next_expiry;
+}
+
 static inline unsigned long __get_next_timer_interrupt(unsigned long basej,
 						       struct timer_base *base)
 {
 	unsigned long nextevt;
 
-	if (base->next_expiry_recalc)
-		next_expiry_recalc(base);
-	nextevt = base->next_expiry;
+	nextevt = next_timer_interrupt(base);
 
 	if (base->timers_pending) {
 		/* If we missed a tick already, force 0 delta */
-- 
2.39.2

