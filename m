Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6B37FDACD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbjK2Ozz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbjK2Ozv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:55:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDD0BE;
        Wed, 29 Nov 2023 06:55:57 -0800 (PST)
Date:   Wed, 29 Nov 2023 14:55:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701269755;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nt6Krllh0mQwdWox8Qj0Ef6jN+mnzfU9kFcSAETUC3o=;
        b=gq715mBss1D6hmeL9Dlxv4hcDsX5oQhPUeffKyl7NI3SZJjd+WE5gOOhhML8Ws/J5m8b8k
        huxBHjcjpFYRzyt1Gznf0jRJV/Ce8ygg/GYT+cwVERhYJLs8s7YTDyHQqhbF9ASB1er7qz
        1uXXnKuShFs2jFj4crtjmHB4li8zh1bBk+ZPajJzdlgb6yWShrpU17eEmhn11y+jlFyyV3
        NMiZWdFkny0bA6vKnSxaRDdx2ytPO/lX3Sttf42GBpsoe7tvSWEMQMXu7W3LetQo8BbMLS
        VzgjBWcApUjgByh34m0EoAU6+qTP/1qS4c1WOrKGvIilax9GgJ6FMg/BjNGACQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701269755;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nt6Krllh0mQwdWox8Qj0Ef6jN+mnzfU9kFcSAETUC3o=;
        b=S+lft88A0i7CNT3TInDWp/o1ZXDcrkSCuK5KvDQ0JXgywnMgrYBzEEjqIaUYln/iUUk0u+
        7Ug0s4lj0PMDptAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86: Fix CPUIDLE_FLAG_IRQ_ENABLE leaking timer reprogram
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231115151325.6262-3-frederic@kernel.org>
References: <20231115151325.6262-3-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <170126975511.398.12493947150541739641.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     edc8fc01f608108b0b7580cb2c29dfb5135e5f0e
Gitweb:        https://git.kernel.org/tip/edc8fc01f608108b0b7580cb2c29dfb5135e5f0e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 15 Nov 2023 10:13:23 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Nov 2023 15:44:01 +01:00

x86: Fix CPUIDLE_FLAG_IRQ_ENABLE leaking timer reprogram

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Link: https://lkml.kernel.org/r/20231115151325.6262-3-frederic@kernel.org
---
 arch/x86/include/asm/mwait.h | 11 +++++++++--
 drivers/idle/intel_idle.c    | 19 +++++++------------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 341ee4f..920426d 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -124,8 +124,15 @@ static __always_inline void mwait_idle_with_hints(unsigned long eax, unsigned lo
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
index dcda0af..3e01a6b 100644
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
