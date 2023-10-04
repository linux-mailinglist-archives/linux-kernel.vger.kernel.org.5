Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392C47B7F39
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242384AbjJDMfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242313AbjJDMfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:35:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EF8BF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:35:29 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696422927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AXGP/cV38TkuwT0IRhJ9YYY7aFG2G6iSF6EqZ7aAS+o=;
        b=mCLdP9Sz8EnBzXJX1cpWsLaMbxR7yBHBthK1dXImUp5/1a4RJY6/2zTW9g9VG6gxLbEvqB
        LB2zeTRuEBPLCCKi+VE7dWf6Wv9JBXfrDO9D74AyVgcMYJ1gHqXZ3ts5N4npijeFIx3DVS
        kTJg98s0HfyGgpqdC6SeijQ4uy3dwi9efOfXk7q9gxXvoafo61HdiFs9pEt3Nbusy4hbT1
        hH9wZJshZI6kvoop02euzfKTrCm+kFU8NvNWVmxqx7us6gPr+eWw1YzCfCTS4vZTqB5HCj
        dFFL4hQ39Gyt2IiUpM+3QqV5+wBEcqceFz5bL0JMvqgypKiG4NA8en71090VcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696422927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AXGP/cV38TkuwT0IRhJ9YYY7aFG2G6iSF6EqZ7aAS+o=;
        b=GWXVBCrmoEVjjFNM0cucO6c5WGmhbmj1qsAX4zXMVXYQfZsTYVYDDA0RuF72hw13/S3+U5
        UmBtuN00urfORyBw==
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
Subject: [PATCH v8 03/25] timer: Do not IPI for deferrable timers
Date:   Wed,  4 Oct 2023 14:34:32 +0200
Message-Id: <20231004123454.15691-4-anna-maria@linutronix.de>
In-Reply-To: <20231004123454.15691-1-anna-maria@linutronix.de>
References: <20231004123454.15691-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deferrable timers do not prevent CPU from going idle and are not taken into
account on idle path. Sending an IPI to a remote CPU when a new first
deferrable timer was enqueued will wake up the remote CPU and but nothing
will be done regarding the deferrable timers.

Drop IPI completely when a new first deferrable timer was enqueued.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
v8: Update comment

v6: new patch
---
 kernel/time/timer.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 63a8ce7177dd..7d06351aff54 100644
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
+	 * Deferrable timers do not prevent CPU from entering dynticks and are
+	 * not taken into account on idle/nohz_full path. An IPI when a new
+	 * deferrable timer is enqueued will wake up the remote CPU but nothing
+	 * will be done with the deferrable timer base. Therefore skip remote
+	 * IPI for deferrable timers completely.
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

