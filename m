Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB70A7D0EC6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377317AbjJTLj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377321AbjJTLis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:38:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE4A1FCE;
        Fri, 20 Oct 2023 04:38:04 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:37:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697801870;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ocsKzyOUr/16fDTcTBRS8aGWUodMXw4pSwzkLBtnLpo=;
        b=piJruyvDqnXkhlHfypNwROFT3xv3RhCSr+N8vTFDZByV/48OiXbW8sgUPdJFYifXRquceM
        r7AJDWfuhjp+IcXwMza2TP6hIvf7ldVkbYSONvt0I8APCioKsVp71WB1mQHXzKr8/ppMwx
        BKzhp1PbK6h5kXrGayN/crB1ZpPdWs5PqbMXmILRj7gNq3aRj8L4SXNZCczzqXLlziaUSM
        Uc+oIUIYgmvJpQsmI8N9yXmRpbeYWVGCXqY1cejOks6O/r9UJwoQeCmttO+MFfgaltkSkE
        G2L/jVLuRp8V9vOKchvNvJtBBmodWnbruBnI7vj3T1uL7WbFCOxVW7SmlwtI8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697801870;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ocsKzyOUr/16fDTcTBRS8aGWUodMXw4pSwzkLBtnLpo=;
        b=x2duohogZGb2kk0faZt3YnqQwFZ2/o0wXZBkC2eJRn9w/NyP4ZUN8x3+xT9ln8DF1Yj+Hq
        6syhfR2wAsaxG8Bg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Add per CPU control field
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231002115903.319959519@linutronix.de>
References: <20231002115903.319959519@linutronix.de>
MIME-Version: 1.0
Message-ID: <169780186976.3135.4532528855543599789.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     c91feaf8c8fabfccf32e78cc3576049fdb37ecf4
Gitweb:        https://git.kernel.org/tip/c91feaf8c8fabfccf32e78cc3576049fdb37ecf4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 02 Oct 2023 14:00:01 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 19 Oct 2023 15:57:56 +02:00

x86/microcode: Add per CPU control field

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
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231002115903.319959519@linutronix.de
---
 arch/x86/kernel/cpu/microcode/core.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 67b8932..001c004 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -252,8 +252,19 @@ static struct platform_device	*microcode_pdev;
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
