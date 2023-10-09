Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD1B7BDBF6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376587AbjJIMaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346564AbjJIM3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:29:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D5BDF;
        Mon,  9 Oct 2023 05:29:52 -0700 (PDT)
Date:   Mon, 09 Oct 2023 12:29:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696854590;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d4DCucT7/EZFCI+kh4lJsqBUmDcTN+vyqxUnjFD4UII=;
        b=JavF7j9xutBTHRG68IG3yFubc/40y+bYiuZdo1mYB4uTplcBboSENOocCaAbjDM2Ou9Yfz
        WvyGTuHDiHCSs8bHrzJ6vRB59WOJe+Z53NnFapNk2xlq9oJFgGkK72tgOWtUZQ9AbSdIrK
        UYPZS9MjwWo/aojy39ev2qEqzVTtGNHAlmaJKVf9TvH7l8JHM592/U8DauO6EasovVR31F
        OOh12S9FpbE7CfRC5rRSmxHOEil6suy95+Zu3z7a4xyUc6T/JOm0fZxSXixt1s+1opuiRj
        G91X1FtDJJ6YOPZdTiLbQCdl28FuSM2O0H27hkfbTeA7yeevuPqy6RsFTddftA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696854590;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d4DCucT7/EZFCI+kh4lJsqBUmDcTN+vyqxUnjFD4UII=;
        b=U+zGahwU5kwPSoCEZDbQ+jeUi27BmdDXMx102VEMiot+U8bO0ivCI+PW4HPw42R8EldI/4
        XRTnUZ6Npx1jlPDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Get rid of the schedule work indirection
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231002115902.971709581@linutronix.de>
References: <20231002115902.971709581@linutronix.de>
MIME-Version: 1.0
Message-ID: <169685458989.3135.1074830869300543674.tip-bot2@tip-bot2>
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

Commit-ID:     f4a21dcbdbfaaa6841d528e5124c581e90c945fe
Gitweb:        https://git.kernel.org/tip/f4a21dcbdbfaaa6841d528e5124c581e90c945fe
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 02 Oct 2023 13:59:54 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 06 Oct 2023 15:12:19 +02:00

x86/microcode: Get rid of the schedule work indirection

Scheduling work on all CPUs to collect the microcode information is just
another extra step for no value. Let the CPU hotplug callback registration
do it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231002115902.971709581@linutronix.de
---
 arch/x86/kernel/cpu/microcode/core.c | 29 +++++++++------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 6f7632f..17b7578 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -519,8 +519,16 @@ static int mc_cpu_starting(unsigned int cpu)
 
 static int mc_cpu_online(unsigned int cpu)
 {
+	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 	struct device *dev = get_cpu_device(cpu);
 
+	memset(uci, 0, sizeof(*uci));
+
+	microcode_ops->collect_cpu_info(cpu, &uci->cpu_sig);
+	cpu_data(cpu).microcode = uci->cpu_sig.rev;
+	if (!cpu)
+		boot_cpu_data.microcode = uci->cpu_sig.rev;
+
 	if (sysfs_create_group(&dev->kobj, &mc_attr_group))
 		pr_err("Failed to create group for CPU%d\n", cpu);
 	return 0;
@@ -541,20 +549,6 @@ static int mc_cpu_down_prep(unsigned int cpu)
 	return 0;
 }
 
-static void setup_online_cpu(struct work_struct *work)
-{
-	int cpu = smp_processor_id();
-	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-
-	memset(uci, 0, sizeof(*uci));
-
-	microcode_ops->collect_cpu_info(cpu, &uci->cpu_sig);
-	cpu_data(cpu).microcode = uci->cpu_sig.rev;
-	if (!cpu)
-		boot_cpu_data.microcode = uci->cpu_sig.rev;
-	mc_cpu_online(cpu);
-}
-
 static struct attribute *cpu_root_microcode_attrs[] = {
 #ifdef CONFIG_MICROCODE_LATE_LOADING
 	&dev_attr_reload.attr,
@@ -600,14 +594,11 @@ static int __init microcode_init(void)
 		}
 	}
 
-	/* Do per-CPU setup */
-	schedule_on_each_cpu(setup_online_cpu);
-
 	register_syscore_ops(&mc_syscore_ops);
 	cpuhp_setup_state_nocalls(CPUHP_AP_MICROCODE_LOADER, "x86/microcode:starting",
 				  mc_cpu_starting, NULL);
-	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "x86/microcode:online",
-				  mc_cpu_online, mc_cpu_down_prep);
+	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/microcode:online",
+			  mc_cpu_online, mc_cpu_down_prep);
 
 	pr_info("Microcode Update Driver: v%s.", DRIVER_VERSION);
 
