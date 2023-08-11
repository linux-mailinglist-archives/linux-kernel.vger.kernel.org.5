Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFADD779583
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236260AbjHKRBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbjHKRBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:01:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC4730F8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:01:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C08267762
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 17:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5125AC433C7;
        Fri, 11 Aug 2023 17:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691773264;
        bh=avuix5bG15MMoG/1/mFgPThQIvzwkN7p3FXy26I7Giw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SvV+gp5g5gzELLIxJzVjWBy9jH4Dr1dph56JxNHJDLbhjtbBPcfgWx0fDvwBMR8JJ
         MFdvd12oxGLPVAL1BUDpG4jC4IM2ohaqHWnv/6dfM/2rhE1kGmdk7bUHTRNTo4PGBS
         TH/3EkVf3lwQIgRieERTjBvL/JCtKKilmJ27qqWlNevT0W38UOdZOcL0dS6iZu+ijL
         rbTuO2gtnRwuiWmqYHvryTQgFj19MKL4UZ0q72ZgZkGhv53ssZ1hxogu7li5d80XSL
         r+P44pFqvg3cG1DSuwaVBnGRNq6v5NbRGeEu3UHQEe5S2vCO2ZqcF8OWUNtjEFcOuy
         N0lLJgBOpbUUw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Bibo Mao <maobibo@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>, Bibo@vger.kernel.org
Subject: [PATCH 04/10] loongson: Fix idle VS timer enqueue
Date:   Fri, 11 Aug 2023 19:00:43 +0200
Message-Id: <20230811170049.308866-5-frederic@kernel.org>
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

From: Peter Zijlstra <peterz@infradead.org>

Loongson re-enables interrupts on its idle routine and performs a
TIF_NEED_RESCHED check afterwards before putting the CPU to sleep.

The IRQs firing between the check and the idling instruction may set the
TIF_NEED_RESCHED flag. In order to deal with the such a race, IRQs
interrupting __arch_cpu_idle() rollback their return address to the
beginning of __arch_cpu_idle() so that TIF_NEED_RESCHED is checked
again before going back to sleep.

However idle IRQs can also queue timers that may require a tick
reprogramming through a new generic idle loop iteration but those timers
would go unnoticed here because __arch_cpu_idle() only checks
TIF_NEED_RESCHED. It doesn't check for pending timers.

Fix this with fast-forwarding idle IRQs return value to the end of the
idle routine instead of the beginning, so that the generic idle loop
handles both TIF_NEED_RESCHED and pending timers.

Fixes: 0603839b18f4 (LoongArch: Add exception/interrupt handling)
Tested-by: Bibo, Mao <maobibo@loongson.cn>
Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/loongarch/kernel/genex.S | 32 ++++++++++++++++++--------------
 arch/loongarch/kernel/idle.c  |  1 -
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
index 78f066384657..359d693f112e 100644
--- a/arch/loongarch/kernel/genex.S
+++ b/arch/loongarch/kernel/genex.S
@@ -18,27 +18,31 @@
 
 	.align	5
 SYM_FUNC_START(__arch_cpu_idle)
-	/* start of rollback region */
-	LONG_L	t0, tp, TI_FLAGS
-	nop
-	andi	t0, t0, _TIF_NEED_RESCHED
-	bnez	t0, 1f
-	nop
-	nop
-	nop
+	/* start of idle interrupt region */
+	move	t0, CSR_CRMD_IE
+	csrxchg	t0, t0, LOONGARCH_CSR_CRMD
+	/*
+	 * If an interrupt lands here; between enabling interrupts above and
+	 * going idle on the next instruction, we must *NOT* go idle since the
+	 * interrupt could have set TIF_NEED_RESCHED or caused an timer to need
+	 * reprogramming. Fall through -- see handle_vint() below -- and have
+	 * the idle loop take care of things.
+	 */
 	idle	0
-	/* end of rollback region */
-1:	jr	ra
+	nop
+	/* end of idle interrupt region */
+SYM_INNER_LABEL(__arch_cpu_idle_exit, SYM_L_LOCAL)
+	jr	ra
 SYM_FUNC_END(__arch_cpu_idle)
 
 SYM_FUNC_START(handle_vint)
 	BACKUP_T0T1
 	SAVE_ALL
-	la_abs	t1, __arch_cpu_idle
+	la_abs	t1, __arch_cpu_idle_exit
 	LONG_L	t0, sp, PT_ERA
-	/* 32 byte rollback region */
-	ori	t0, t0, 0x1f
-	xori	t0, t0, 0x1f
+	/* 16 byte idle interrupt region */
+	ori	t0, t0, 0x0f
+	addi.d	t0, t0, 1
 	bne	t0, t1, 1f
 	LONG_S	t0, sp, PT_ERA
 1:	move	a0, sp
diff --git a/arch/loongarch/kernel/idle.c b/arch/loongarch/kernel/idle.c
index 0b5dd2faeb90..5ba72d229920 100644
--- a/arch/loongarch/kernel/idle.c
+++ b/arch/loongarch/kernel/idle.c
@@ -11,7 +11,6 @@
 
 void __cpuidle arch_cpu_idle(void)
 {
-	raw_local_irq_enable();
 	__arch_cpu_idle(); /* idle instruction needs irq enabled */
 	raw_local_irq_disable();
 }
-- 
2.34.1

