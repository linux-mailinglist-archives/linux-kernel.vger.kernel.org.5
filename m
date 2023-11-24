Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D75C7F862D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 23:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjKXWck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 17:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjKXWch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 17:32:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5756810FB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 14:32:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90621C433C7;
        Fri, 24 Nov 2023 22:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700865164;
        bh=CXS0kf7QfS6H/bXiY0zJwq5tEcqIiy9tCvQovQrbkN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HPa6VZmhmx1d/lcTIANzys+lP9tpG585RQPkJGTDl5qaYFfx4ng4+D3Ue51VjCGVl
         +YxcXCxqvYdyVGph2cL4+kMGm5zFSgpCHg5EBFOVd/8zwyRWjqOFBk6snNRHBTH1wR
         OFJBStdXapHsWXqoti/A4nXAHrp8NESBWDq5BJBGYQ1eOE1jlVlHkg3NaSap/6tNoS
         yb6GgWzrn1W2nuFIxs8TJFNr334MzPXjLxHCmzBN3R1FFILiFAcXnSztVzBPWlNXWN
         N/zdiw303k4a4e8NdAGfP9X1Loxo+a/jrmE/Qe/uz4Z/Bq5ZE758VybQJPlKasDCZI
         V7UcKca+vdGMQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 1/7] x86: Fix CPUIDLE_FLAG_IRQ_ENABLE leaking timer reprogram
Date:   Fri, 24 Nov 2023 23:32:20 +0100
Message-ID: <20231124223226.24249-2-frederic@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231124223226.24249-1-frederic@kernel.org>
References: <20231124223226.24249-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

intel_idle_irq() re-enables IRQs very early. As a result, an interrupt
may fire before mwait() is eventually called. If such an interrupt queues
a timer, it may go unnoticed until mwait returns and the idle loop
handles the tick re-evaluation. And monitoring TIF_NEED_RESCHED doesn't
help because a local timer enqueue doesn't set that flag.

The issue is mitigated by the fact that this idle handler is only invoked
for shallow C-states when, presumably, the next tick is supposed to be
close enough. There may still be rare cases though when the next tick
is far away and the selected C-state is shallow, resulting in a timer
getting ignored for a while.

Fix this with using sti_mwait() whose IRQ-reenablement only triggers
upon calling mwait(), dealing with the race while keeping the interrupt
latency within acceptable bounds.

Fixes: c227233ad64c (intel_idle: enable interrupts before C1 on Xeons)
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/x86/include/asm/mwait.h | 11 +++++++++--
 drivers/idle/intel_idle.c    | 19 +++++++------------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 778df05f8539..bae83810505b 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -115,8 +115,15 @@ static __always_inline void mwait_idle_with_hints(unsigned long eax, unsigned lo
 		}
 
 		__monitor((void *)&current_thread_info()->flags, 0, 0);
-		if (!need_resched())
-			__mwait(eax, ecx);
+
+		if (!need_resched()) {
+			if (ecx & 1) {
+				__mwait(eax, ecx);
+			} else {
+				__sti_mwait(eax, ecx);
+				raw_local_irq_disable();
+			}
+		}
 	}
 	current_clr_polling();
 }
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index dcda0afecfc5..3e01a6b23e75 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -131,11 +131,12 @@ static unsigned int mwait_substates __initdata;
 #define MWAIT2flg(eax) ((eax & 0xFF) << 24)
 
 static __always_inline int __intel_idle(struct cpuidle_device *dev,
-					struct cpuidle_driver *drv, int index)
+					struct cpuidle_driver *drv,
+					int index, bool irqoff)
 {
 	struct cpuidle_state *state = &drv->states[index];
 	unsigned long eax = flg2MWAIT(state->flags);
-	unsigned long ecx = 1; /* break on interrupt flag */
+	unsigned long ecx = 1*irqoff; /* break on interrupt flag */
 
 	mwait_idle_with_hints(eax, ecx);
 
@@ -159,19 +160,13 @@ static __always_inline int __intel_idle(struct cpuidle_device *dev,
 static __cpuidle int intel_idle(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv, int index)
 {
-	return __intel_idle(dev, drv, index);
+	return __intel_idle(dev, drv, index, true);
 }
 
 static __cpuidle int intel_idle_irq(struct cpuidle_device *dev,
 				    struct cpuidle_driver *drv, int index)
 {
-	int ret;
-
-	raw_local_irq_enable();
-	ret = __intel_idle(dev, drv, index);
-	raw_local_irq_disable();
-
-	return ret;
+	return __intel_idle(dev, drv, index, false);
 }
 
 static __cpuidle int intel_idle_ibrs(struct cpuidle_device *dev,
@@ -184,7 +179,7 @@ static __cpuidle int intel_idle_ibrs(struct cpuidle_device *dev,
 	if (smt_active)
 		__update_spec_ctrl(0);
 
-	ret = __intel_idle(dev, drv, index);
+	ret = __intel_idle(dev, drv, index, true);
 
 	if (smt_active)
 		__update_spec_ctrl(spec_ctrl);
@@ -196,7 +191,7 @@ static __cpuidle int intel_idle_xstate(struct cpuidle_device *dev,
 				       struct cpuidle_driver *drv, int index)
 {
 	fpu_idle_fpregs();
-	return __intel_idle(dev, drv, index);
+	return __intel_idle(dev, drv, index, true);
 }
 
 /**
-- 
2.42.1

