Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A297B7F4B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242365AbjJDMgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242425AbjJDMfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:35:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76ED111D
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:35:39 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696422938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KnlNVqR9WmkhQaFL3egg7gM5XjHK7g3gYDo7hW6w0sA=;
        b=2TZ9kJex3ROSXsaXZ7E6YlGyRhNQcoeofEqkGjEFrQtNA9JI7/+5BOxaf2P5Qtw7d4zpO+
        G9MR1zjHfkvsM/a4vDvRz7ReaEAwvgoe3n9HMc9v4xD1vanpbtMRDsIj9wGujTkHP3gOUG
        gruyK2jWfbvnZEOMbkyXr1voAKd0tCNCb9FxxoTmzb9N1M5GXMzEPBwEQ+3Wd8unB0QEfn
        y6GK7wMm4vbwVbFIhiAutGYsQHZhE74BiYMb/GkfGbfrHSUfykP3IWSdlVVSIln5ixxECx
        1YperYHSE3JgjrLQu+PGPrV3K/aXXfkCq7RCaTYE9KDf0CjzCDpIe7cxgzv5Tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696422938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KnlNVqR9WmkhQaFL3egg7gM5XjHK7g3gYDo7hW6w0sA=;
        b=ls2cXdt0RpOukfXjfgEx4zuqZfQoPuAoG1FP29n6w5srR0nfJ/iEL78XXgngJh8lvaP0T8
        GMX4WEeUul/0XzDQ==
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
Subject: [PATCH v8 21/25] timer: Check if timers base is handled already
Date:   Wed,  4 Oct 2023 14:34:50 +0200
Message-Id: <20231004123454.15691-22-anna-maria@linutronix.de>
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

Due to the conversion of the NOHZ timer placement to a pull at expiry
time model, the per CPU timer bases with non pinned timers are no
longer handled only by the local CPU. In case a remote CPU already
expires the non pinned timers base of the local cpu, nothing more
needs to be done by the local CPU. A check at the begin of the expire
timers routine is required, because timer base lock is dropped before
executing the timer callback function.

This is a preparatory work, but has no functional impact right now.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v6: Drop double negation
---
 kernel/time/timer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 8893f5dd1d66..7f06553e44de 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2232,6 +2232,9 @@ static inline void __run_timers(struct timer_base *base)
 
 	lockdep_assert_held(&base->lock);
 
+	if (base->running_timer)
+		return;
+
 	while (time_after_eq(jiffies, base->clk) &&
 	       time_after_eq(jiffies, base->next_expiry)) {
 		levels = collect_expired_timers(base, heads);
-- 
2.39.2

