Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092D4779589
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbjHKRBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbjHKRBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:01:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5E530FC
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:01:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF77065939
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 17:01:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9360CC433CB;
        Fri, 11 Aug 2023 17:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691773277;
        bh=P4hs1/vw36aQkpeJTSOOps59gS7gR0fhrgXS9eBIDR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NrrMLc0j8bQVcFnhM/w9g+r6Jx7CbJC1Aptg+KGJMQYywqTu8zZGMtNNk2L+HG9z0
         tqpckeIrYK2wdaicMpSB3HMZKuo+d98Tz6kQ5+JSek8FQffuhop5UonVZXQPUj1g1g
         vuvlBpHO6d31PCOCW5avnN1CjyuoYN6vwOpFMN1oM2kKu5cWwfkRlDAa05OdPN3LkG
         aIvAmc1WKA9b01Qv2qvPwQPLVzPviCfRZVpPtd8hwOEUe25TgQMLdZ7FdMnn00CYt8
         vBcppA144m1gmulthZZ7oeI49eYC85SAMKw0YZVCbAd/fUMOVrMWfnNendhXccnQbg
         j7psMNPqSQTkg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 10/10] sched/timers: Explain why idle task schedules out on remote timer enqueue
Date:   Fri, 11 Aug 2023 19:00:49 +0200
Message-Id: <20230811170049.308866-11-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811170049.308866-1-frederic@kernel.org>
References: <20230811170049.308866-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to avoid that didn't bring much value after testing, add comment
about this.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/sched/core.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c52c2eba7c73..e53b892167ad 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1135,6 +1135,28 @@ static void wake_up_idle_cpu(int cpu)
 	if (cpu == smp_processor_id())
 		return;
 
+	/*
+	 * Set TIF_NEED_RESCHED and send an IPI if in the non-polling
+	 * part of the idle loop. This forces an exit from the idle loop
+	 * and a round trip to schedule(). Now this could be optimized
+	 * because a simple new idle loop iteration is enough to
+	 * re-evaluate the next tick. Provided some re-ordering of tick
+	 * nohz functions that would need to follow TIF_NR_POLLING
+	 * clearing:
+	 *
+	 * - On most archs, a simple fetch_or on ti::flags with a
+	 *   "0" value would be enough to know if an IPI needs to be sent.
+	 *
+	 * - x86 needs to perform a last need_resched() check between
+	 *   monitor and mwait which doesn't take timers into account.
+	 *   There a dedicated TIF_TIMER flag would be required to
+	 *   fetch_or here and be checked along with TIF_NEED_RESCHED
+	 *   before mwait().
+	 *
+	 * However, remote timer enqueue is not such a frequent event
+	 * and testing of the above solutions didn't appear to report
+	 * much benefits.
+	 */
 	if (set_nr_and_not_polling(rq->idle))
 		smp_send_reschedule(cpu);
 	else
-- 
2.34.1

