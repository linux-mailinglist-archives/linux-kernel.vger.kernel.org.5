Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A4D7B7F43
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242495AbjJDMgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242358AbjJDMfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:35:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37565DC
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:35:34 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696422932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6DPHaSkgekB2I+0lkcOsz7/7iYLTa5GbGumx2pBBGqU=;
        b=Qd8FZSDAYvAL7lxkOI5jQrs5CgGcU4uAc7nnagLndWZobaOuf/Dvk0zyWZDa/uAw/ItCrc
        3VwoOTu/u1QZWjLt46Th72F4+6gSSj4+p732/V7jTJcFvocbTp/DxqXirqwwjaj8H4t99Z
        7oU5lVYUGnqhJQklI8UJpl+1tBs1yXXhwqGQYnfEIL4DakSLcyrstgXhvslUuIurs3hjRc
        WWeKwnm79rFQvRIh6sG6QbxeNM3quvtE+G0VEe3vpW879Hrhctvp4y/o86iFrBs187XYjJ
        JjxHRZhOZ8xWs2uEoyj1tsMYZEDFAjUKbJl3NiVrMF3yQCAiPLWpxcnXpV2Uxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696422932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6DPHaSkgekB2I+0lkcOsz7/7iYLTa5GbGumx2pBBGqU=;
        b=GF+aQ6268WK32U46sW7y8gJaofxzjHKXNrx1llzCNt/AaQqBRSn1wulaQgmV1OESGvG5gD
        01BmrJM8D6fQPzBw==
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
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH v8 12/25] workqueue: Use global variant for add_timer()
Date:   Wed,  4 Oct 2023 14:34:41 +0200
Message-Id: <20231004123454.15691-13-anna-maria@linutronix.de>
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

The implementation of the NOHZ pull at expiry model will change the timer
bases per CPU. Timers, that have to expire on a specific CPU, require the
TIMER_PINNED flag. If the CPU doesn't matter, the TIMER_PINNED flag must be
dropped. This is required for call sites which use the timer alternately as
pinned and not pinned timer like workqueues do.

Therefore use add_timer_global() to make sure TIMER_PINNED flag is dropped.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
---
v6:
  - New patch: As v6 provides unconditially setting TIMER_PINNED flag in
    add_timer_on() workqueue requires new add_timer_global() variant.
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c85825e17df8..36474a2c4b6f 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1958,7 +1958,7 @@ static void __queue_delayed_work(int cpu, struct workqueue_struct *wq,
 	if (unlikely(cpu != WORK_CPU_UNBOUND))
 		add_timer_on(timer, cpu);
 	else
-		add_timer(timer);
+		add_timer_global(timer);
 }
 
 /**
-- 
2.39.2

