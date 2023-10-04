Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7900D7B7F3A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242452AbjJDMfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242369AbjJDMfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:35:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49125BF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:35:31 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696422929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TACaL1lFRKPWpkhfzVfD3M8bG5zQsJmcuSPp/gOAMUM=;
        b=LW5O10L3K/13uU8Y/WizuaxwUjNbbEFTne4OjEEzLrAOTlX0f5E1sU9zYiEDesd9RStzju
        rcdIC9V+wKtNSFXHSiKXzApMmy4s0mz3BSHlJCEF7yyClrGObOgR5wRIDVVRu29cA9OGER
        4bZaDCZgHutQ6vKti5lxrmQJPtJVHx/sA1V5jaPVPU+ruJsQrsjZrkobBWNVIRHbkaP+ba
        vo3F2FnwjvkuFSxEkxrSg7lhbUkKBGNh0rjeyRE3E9+EvEnXoqMmLIHQA7CoM4scSouyM7
        57E4l5kJU7wTMQdxf6lZwGRmH2tQ57seDXgvk/DIueRaDeJBCZD3N0TfKoEhDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696422929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TACaL1lFRKPWpkhfzVfD3M8bG5zQsJmcuSPp/gOAMUM=;
        b=f/cvwydXPVYbloV/MLHuClxhZ4pur5aHlYO74vCB/JxgoWTJfTrH14sdSnUTBJu/CdxMxy
        AqNgfFlMXVer0rAw==
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
Subject: [PATCH v8 07/25] timers: Use already existing function for forwarding timer base
Date:   Wed,  4 Oct 2023 14:34:36 +0200
Message-Id: <20231004123454.15691-8-anna-maria@linutronix.de>
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

There is an already existing function for forwarding the timer
base. Forwarding the timer base is implemented directly in
get_next_timer_interrupt() as well.

To avoid code duplication, replace implementation for forwarding timer base
with the direct call to the already existing function.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timer.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 2f6afd1da891..dc58c479d35a 100644
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

