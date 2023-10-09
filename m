Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFB27BDBDD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376408AbjJIMaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346534AbjJIM3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:29:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9246F9C;
        Mon,  9 Oct 2023 05:29:48 -0700 (PDT)
Date:   Mon, 09 Oct 2023 12:29:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696854586;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lO+E5Hr/wti7KqSpQqfht50cqcdnfkR4G2TU9Y+CIvQ=;
        b=ER0Kgkzo8H/EfFiVrJGJ/5oU9Nr3ew1zocNoD9UdoFkP9QLIU+0pJz/A5UB8hwt/82KfLr
        ZbW893+0AVsg/E486K+K3yCawZq6bRJ5mMO0xBvINmKQ9AGNwY9ovNoc+cBiPsmqxIHUsc
        +OXryp9yTvuuYqMIkm4KG998oxAgUniSohd+2uhCc2+Vkk381M0FEqu1VpFyE/wYSCmxzz
        HhKaV2uNHJ/t4HzHAOOgi13l1Y+VcrSZbHVVS3bgYhoZrVK4SxFEAgisbPrXfUvrWxNHQm
        P4z/CL0uWMScLjEJUyIkKkbCiXXV3AAb1HJx/ifLaYYF17R7OT7jyaZuTCaUvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696854586;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lO+E5Hr/wti7KqSpQqfht50cqcdnfkR4G2TU9Y+CIvQ=;
        b=gYWIwkxO9JAsaayJswm16VuvMCigJHMfzdT/WIXJMOG1Mwsu0OeJ5tl+vMYzzwKEOt1e0m
        NtWSI5hOrExn7JDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Replace the all-in-one rendevous handler
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231002115903.433704135@linutronix.de>
References: <20231002115903.433704135@linutronix.de>
MIME-Version: 1.0
Message-ID: <169685458597.3135.7900711190722605219.tip-bot2@tip-bot2>
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

Commit-ID:     0eccca7cbc7ff614cb57ba26a8704e842c242c38
Gitweb:        https://git.kernel.org/tip/0eccca7cbc7ff614cb57ba26a8704e842c242c38
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 02 Oct 2023 14:00:03 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 06 Oct 2023 15:12:24 +02:00

x86/microcode: Replace the all-in-one rendevous handler

with a new handler which just separates the control flow of primary and
secondary CPUs.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231002115903.433704135@linutronix.de
---
 arch/x86/kernel/cpu/microcode/core.c | 51 ++++-----------------------
 1 file changed, 9 insertions(+), 42 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index f755b3c..ae23214 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -297,7 +297,7 @@ struct microcode_ctrl {
 };
 
 static DEFINE_PER_CPU(struct microcode_ctrl, ucode_ctrl);
-static atomic_t late_cpus_in, late_cpus_out;
+static atomic_t late_cpus_in;
 
 static bool wait_for_cpus(atomic_t *cnt)
 {
@@ -333,7 +333,7 @@ static bool wait_for_ctrl(void)
 	return false;
 }
 
-static __maybe_unused void load_secondary(unsigned int cpu)
+static void load_secondary(unsigned int cpu)
 {
 	unsigned int ctrl_cpu = this_cpu_read(ucode_ctrl.ctrl_cpu);
 	enum ucode_state ret;
@@ -368,7 +368,7 @@ static __maybe_unused void load_secondary(unsigned int cpu)
 	this_cpu_write(ucode_ctrl.ctrl, SCTRL_DONE);
 }
 
-static __maybe_unused void load_primary(unsigned int cpu)
+static void load_primary(unsigned int cpu)
 {
 	struct cpumask *secondaries = topology_sibling_cpumask(cpu);
 	enum sibling_ctrl ctrl;
@@ -405,46 +405,14 @@ static __maybe_unused void load_primary(unsigned int cpu)
 
 static int load_cpus_stopped(void *unused)
 {
-	int cpu = smp_processor_id();
-	enum ucode_state ret;
-
-	/*
-	 * Wait for all CPUs to arrive. A load will not be attempted unless all
-	 * CPUs show up.
-	 * */
-	if (!wait_for_cpus(&late_cpus_in)) {
-		this_cpu_write(ucode_ctrl.result, UCODE_TIMEOUT);
-		return 0;
-	}
-
-	/*
-	 * On an SMT system, it suffices to load the microcode on one sibling of
-	 * the core because the microcode engine is shared between the threads.
-	 * Synchronization still needs to take place so that no concurrent
-	 * loading attempts happen on multiple threads of an SMT core. See
-	 * below.
-	 */
-	if (cpumask_first(topology_sibling_cpumask(cpu)) != cpu)
-		goto wait_for_siblings;
+	unsigned int cpu = smp_processor_id();
 
-	ret = microcode_ops->apply_microcode(cpu);
-	this_cpu_write(ucode_ctrl.result, ret);
-
-wait_for_siblings:
-	if (!wait_for_cpus(&late_cpus_out))
-		panic("Timeout during microcode update!\n");
-
-	/*
-	 * At least one thread has completed update on each core.
-	 * For others, simply call the update to make sure the
-	 * per-cpu cpuinfo can be updated with right microcode
-	 * revision.
-	 */
-	if (cpumask_first(topology_sibling_cpumask(cpu)) == cpu)
-		return 0;
+	if (this_cpu_read(ucode_ctrl.ctrl_cpu) == cpu)
+		load_primary(cpu);
+	else
+		load_secondary(cpu);
 
-	ret = microcode_ops->apply_microcode(cpu);
-	this_cpu_write(ucode_ctrl.result, ret);
+	/* No point to wait here. The CPUs will all wait in stop_machine(). */
 	return 0;
 }
 
@@ -458,7 +426,6 @@ static int load_late_stop_cpus(void)
 	pr_err("You should switch to early loading, if possible.\n");
 
 	atomic_set(&late_cpus_in, num_online_cpus());
-	atomic_set(&late_cpus_out, num_online_cpus());
 
 	/*
 	 * Take a snapshot before the microcode update in order to compare and
