Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450D3779584
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbjHKRBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236137AbjHKRBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:01:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B943F358D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:01:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B6C4645D4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 17:01:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C8EC433C8;
        Fri, 11 Aug 2023 17:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691773266;
        bh=S08tGTg2h98OGDPV+poOPJ31ZbhjI75bLqTCYfR8VLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rMyizXCKChWj0nTYNr5wnl6eRtZ4EEFVV37VHgROtV2bk77XB8WECJhMjGHeVS7WZ
         BMoZ6/X6yfFy33d1vj2Hv8Bc2DtvbP8Ef1H99meYWnt3BmuxqvnCWhnfeWo7wFg/eB
         ZtQlfZxqqZxOKqklVkyphHAhpysYvKQCErpy83U9EzDTPhmLR9rxIqJ9pMmviOx7wk
         LwbbNqaxxFuyTdM50rLCYvFP7iPCyZf1qJCJxtwzPfz9K4HCO1HrmNcqkNObPZdC92
         +nMDMROWFF1t+ZI4Gq1drjVj5d/dgXYmCvMI1ZxuqEGs8C/gTsXhNXQQLjVwklg3MD
         Tsga622F1V/6Q==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 05/10] cpuidle: Comment about timers requirements VS idle handler
Date:   Fri, 11 Aug 2023 19:00:44 +0200
Message-Id: <20230811170049.308866-6-frederic@kernel.org>
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

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/sched/idle.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 342f58a329f5..d52f6e3e3854 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -258,6 +258,36 @@ static void do_idle(void)
 	while (!need_resched()) {
 		rmb();
 
+		/*
+		 * Interrupts shouldn't be re-enabled from that point on until
+		 * the CPU sleeping instruction is reached. Otherwise an interrupt
+		 * may fire and queue a timer that would be ignored until the CPU
+		 * wakes from the sleeping instruction. And testing need_resched()
+		 * doesn't tell about pending needed timer reprogram.
+		 *
+		 * Several cases to consider:
+		 *
+		 * - SLEEP-UNTIL-PENDING-INTERRUPT based instructions such as
+		 *   "wfi" or "mwait" are fine because they can be entered with
+		 *   interrupt disabled.
+		 *
+		 * - sti;mwait() couple is fine because the interrupts are
+		 *   re-enabled only upon the execution of mwait, leaving no gap
+		 *   in-between.
+		 *
+		 * - ROLLBACK based idle handlers with the sleeping instruction
+		 *   called with interrupts enabled are NOT fine. In this scheme
+		 *   when the interrupt detects it has interrupted an idle handler,
+		 *   it rolls back to its beginning which performs the
+		 *   need_resched() check before re-executing the sleeping
+		 *   instruction. This can leak a pending needed timer reprogram.
+		 *   If such a scheme is really mandatory due to the lack of an
+		 *   appropriate CPU sleeping instruction, then a FAST-FORWARD
+		 *   must instead be applied: when the interrupt detects it has
+		 *   interrupted an idle handler, it must resume to the end of
+		 *   this idle handler so that the generic idle loop is iterated
+		 *   again to reprogram the tick.
+		 */
 		local_irq_disable();
 
 		if (cpu_is_offline(cpu)) {
-- 
2.34.1

