Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47157BDBE3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376421AbjJIMaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376354AbjJIM3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:29:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA542B4;
        Mon,  9 Oct 2023 05:29:48 -0700 (PDT)
Date:   Mon, 09 Oct 2023 12:29:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696854587;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j9BuK/0JPmjKJakucrgKTSIufK36d99jTQsjk5iGSwU=;
        b=Ear2xpDEYTc7cNgTvaTptIICqywX9Lmwu5FZmBDQusfAUUrioLdiintV8Z8vjynrNNVcZI
        XwQZT8ykEPeR38xWADe1GslxYzrU2pWkMg3AozjTH9QT6KH98wXDk6m/xYyEAl1lA+Awt2
        3Ot9Pg81R0H5GmU1n+hsxYOO0/3bMYMnfNPRX7ww0/D0QNfrrQe1Pnc0fySc0U4dVKQRDY
        J8k8ldPZO1m3iwRge4iaVl1We6SYBJ2EEPebS46ruWXdIb4w5MnD37t3SR27n5FS7di1y+
        ugNLy8I3SU6aymxw/46J05RzKsqX78DUdLHhQAKT2x8HFS2W5mftXworeJj8IQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696854587;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j9BuK/0JPmjKJakucrgKTSIufK36d99jTQsjk5iGSwU=;
        b=m2+rdpNs+xCCUqx656jTugqh0aN85hG7EaUD8bnWBNABd6d8ABCW+OakNXvri8Kpztlgky
        FF88EO0yC56A6QAg==
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
Message-ID: <169685458692.3135.13853962369912296438.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     537929fe93b931a13ab1830a9c9f27a95634c797
Gitweb:        https://git.kernel.org/tip/537929fe93b931a13ab1830a9c9f27a95634c797
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 02 Oct 2023 14:00:01 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 06 Oct 2023 15:12:24 +02:00

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
index b72ef3b..35d37de 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -281,8 +281,19 @@ static struct platform_device	*microcode_pdev;
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
@@ -427,7 +438,7 @@ static int load_late_stop_cpus(void)
  */
 static bool setup_cpus(void)
 {
-	struct microcode_ctrl ctrl = { .result = -1, };
+	struct microcode_ctrl ctrl = { .ctrl = SCTRL_WAIT, .result = -1, };
 	unsigned int cpu;
 
 	for_each_cpu_and(cpu, cpu_present_mask, &cpus_booted_once_mask) {
@@ -437,7 +448,12 @@ static bool setup_cpus(void)
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
