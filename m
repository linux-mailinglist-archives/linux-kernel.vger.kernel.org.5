Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086337FFD5A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376867AbjK3VQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376818AbjK3VQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:16:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD40133;
        Thu, 30 Nov 2023 13:16:31 -0800 (PST)
Date:   Thu, 30 Nov 2023 21:16:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701378990;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yX3GH4Ig3zJLPcZmocLBTO3REi3Ffcp+2bdeAOPF/9I=;
        b=HPuNHV2rzBeMM2AcgCScPh910tiNvGRT5f3PFBwbQAgvF2hVzf0kdxz2cesg/HL9tCTpEZ
        BxmR1Emz1HDMMdPEtvXu2Ks5Vg4sY3Ux/ruCE5hWOQzHBVfrJxoPjyNYXokpDSJTXzPA7U
        Yq786qD+oZBnSefPrZF1OgYIq5dLq5fuy8NJ+oMnIs5ahJegm6TCurO/PylKS+tnHuKUh7
        mQB6i+beiRUef5UyzWLPbF8UEyGv5lSrdh3YrfL4boJU463rxecW9EJJOkYvQaHDSx8hi4
        YAJNHuuoWPIE3v6segHiVeaWp1Gwk9NWvxRdaxChLO0Y1BP53KdLNJztoslbdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701378990;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yX3GH4Ig3zJLPcZmocLBTO3REi3Ffcp+2bdeAOPF/9I=;
        b=5GlV8IXEaCV43hIm2akKSs0HaL1J1S5moCBt8TQCBqrzT9IkjOTamdp8JJfA/z4XDU2YAp
        5bcHKGWdLhq6UUBw==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/smp: Move the call to smp_processor_id() after
 the early exit in native_stop_other_cpus()
Cc:     Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231123203605.3474745-1-ubizjak@gmail.com>
References: <20231123203605.3474745-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <170137898974.398.10685540680447334314.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     9d1c8f21533729b6ead531b676fa7d327cf00819
Gitweb:        https://git.kernel.org/tip/9d1c8f21533729b6ead531b676fa7d327cf00819
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Thu, 23 Nov 2023 21:34:22 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 30 Nov 2023 20:25:09 +01:00

x86/smp: Move the call to smp_processor_id() after the early exit in native_stop_other_cpus()

Improve code generation in native_stop_other_cpus() a tiny bit:
smp_processor_id() accesses a per-CPU variable, so the compiler
is not able to move the call after the early exit on its own.

Also rename the "cpu" variable to a more descriptive "this_cpu", and
use 'cpu' as a separate iterator variable later in the function.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231123203605.3474745-1-ubizjak@gmail.com
---
 arch/x86/kernel/smp.c |  9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 6eb06d0..65dd44e 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -148,14 +148,15 @@ static int register_stop_handler(void)
 
 static void native_stop_other_cpus(int wait)
 {
-	unsigned int cpu = smp_processor_id();
+	unsigned int this_cpu;
 	unsigned long flags, timeout;
 
 	if (reboot_force)
 		return;
 
 	/* Only proceed if this is the first CPU to reach this code */
-	if (atomic_cmpxchg(&stopping_cpu, -1, cpu) != -1)
+	this_cpu = smp_processor_id();
+	if (atomic_cmpxchg(&stopping_cpu, -1, this_cpu) != -1)
 		return;
 
 	/* For kexec, ensure that offline CPUs are out of MWAIT and in HLT */
@@ -190,7 +191,7 @@ static void native_stop_other_cpus(int wait)
 	 * NMIs.
 	 */
 	cpumask_copy(&cpus_stop_mask, cpu_online_mask);
-	cpumask_clear_cpu(cpu, &cpus_stop_mask);
+	cpumask_clear_cpu(this_cpu, &cpus_stop_mask);
 
 	if (!cpumask_empty(&cpus_stop_mask)) {
 		apic_send_IPI_allbutself(REBOOT_VECTOR);
@@ -234,6 +235,8 @@ static void native_stop_other_cpus(int wait)
 		 * CPUs to stop.
 		 */
 		if (!smp_no_nmi_ipi && !register_stop_handler()) {
+			unsigned int cpu;
+
 			pr_emerg("Shutting down cpus with NMI\n");
 
 			for_each_cpu(cpu, &cpus_stop_mask)
