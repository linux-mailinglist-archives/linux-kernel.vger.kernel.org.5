Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C847CCF40
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344429AbjJQV0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344321AbjJQVZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:25:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595E4131
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:24:08 -0700 (PDT)
Message-ID: <20231017211723.688807375@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697577846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=L9m8W4bdzDuhhTI4cJap7V+acmOzj+yrZ+giYWgienc=;
        b=eMFbUfbn//zHbW26T91mEuzFJyURdXE/G8WGZCvGYbFkFo+qqd593s20T6Snrj6q3AycWZ
        B7nZvUFiWljt6c3NFH4eQ1O00dGHhGGiGYouDw1AQJOO5oFvnvRNHmq4QFo1nN1uRLsxFM
        8P9BohzMx7nqp2DhXCVBobMnJdYUy7Zw+vuns9KY1GN1WsvfId31285yuFQHwfcyQWbApb
        NYpWKdsbJl3qELKhQvtMpR4LlVqdp4ZlbS8jiuwjUuMr77uaNAj7uO61iwWbwTBZGGi2p/
        DTI9Quu/hd32N0oqqCEo6rLZzft/t84zWaFdxhBkAfCAQY4xHmK+6Luinjqe9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697577846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=L9m8W4bdzDuhhTI4cJap7V+acmOzj+yrZ+giYWgienc=;
        b=Hir2o4x4E6IN7gYByVkLrAKiDLDgzKdmWcbf61iXoqbeDyulOsd/AmdNOQlSK0fyDd2Ryn
        s04lVl9+idPIAmBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>
Subject: [patch V5 31/39] x86/microcode: Add per CPU control field
References: <20231017200758.877560658@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 17 Oct 2023 23:24:06 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Add a per CPU control field to ucode_ctrl and define constants for it
which are going to be used to control the loading state machine.

In theory this could be a global control field, but a global control does
not cover the following case:

 15 primary CPUs load microcode successfully
  1 primary CPU fails and returns with an error code

With global control the sibling of the failed CPU would either try again or
the whole operation would be aborted with the consequence that the 15
siblings do not invoke the apply path and end up with inconsistent software
state. The result in dmesg would be inconsistent too.

There are two additional fields added and initialized:

ctrl_cpu and secondaries. ctrl_cpu is the CPU number of the primary thread
for now, but with the upcoming uniform loading at package or system scope
this will be one CPU per package or just one CPU. Secondaries hands the
control CPU a CPU mask which will be required to release the secondary CPUs
out of the wait loop.

Preparatory change for implementing a properly split control flow for
primary and secondary CPUs.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/microcode/core.c |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)
---
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -252,8 +252,19 @@ static struct platform_device	*microcode
  *   requirement can be relaxed in the future. Right now, this is conservative
  *   and good.
  */
+enum sibling_ctrl {
+	/* Spinwait with timeout */
+	SCTRL_WAIT,
+	/* Invoke the microcode_apply() callback */
+	SCTRL_APPLY,
+	/* Proceed without invoking the microcode_apply() callback */
+	SCTRL_DONE,
+};
+
 struct microcode_ctrl {
+	enum sibling_ctrl	ctrl;
 	enum ucode_state	result;
+	unsigned int		ctrl_cpu;
 };
 
 static DEFINE_PER_CPU(struct microcode_ctrl, ucode_ctrl);
@@ -398,7 +409,7 @@ static int load_late_stop_cpus(void)
  */
 static bool setup_cpus(void)
 {
-	struct microcode_ctrl ctrl = { .result = -1, };
+	struct microcode_ctrl ctrl = { .ctrl = SCTRL_WAIT, .result = -1, };
 	unsigned int cpu;
 
 	for_each_cpu_and(cpu, cpu_present_mask, &cpus_booted_once_mask) {
@@ -408,7 +419,12 @@ static bool setup_cpus(void)
 				return false;
 			}
 		}
-		/* Initialize the per CPU state */
+
+		/*
+		 * Initialize the per CPU state. This is core scope for now,
+		 * but prepared to take package or system scope into account.
+		 */
+		ctrl.ctrl_cpu = cpumask_first(topology_sibling_cpumask(cpu));
 		per_cpu(ucode_ctrl, cpu) = ctrl;
 	}
 	return true;

