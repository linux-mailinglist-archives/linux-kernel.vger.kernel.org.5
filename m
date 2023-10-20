Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944287D0ECD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377449AbjJTLjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377149AbjJTLiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:38:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D43A1FEA;
        Fri, 20 Oct 2023 04:38:07 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:37:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697801873;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vdYHOrN3XM+EccrGn81iU/XtmJFMCAQc9uJD23D4LzI=;
        b=giOQkZAIg9RgOPasC279ekFJq3dufkROdN6p8o6Xd+Tk/18XNsV8f58CAfSofr43l0MkzD
        gBp6w34FowEjZYjgCf2ucMcnSu2IyaWAB9afIufxufl3Hdfjv2Um+7i6KOu/adwgk5nNcd
        EVxNQWLDnEokVQkUnsbx6ZHKUVAGVgLhW9UKSKagEiAXbl+4S7CoLiWVUqSALfTRKoleJk
        vqwE1GS7QvYX5a5YHMDMUo8W9jNcbaN4Su5Va9S182m8OsiNkLamLjfh+WV5/DWK/R7R+2
        YL5TfrDp0JT7qYbEVPqrBLwexyHFg4pAbMMYov/MklN40aGS3hp1AxVIgUxJmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697801873;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vdYHOrN3XM+EccrGn81iU/XtmJFMCAQc9uJD23D4LzI=;
        b=qqdktpSU/ncHeQHWiD2jP9aQtHt12dZ5opNx2g/hZLLJgClWXNIJw29JaBprGbh5C8wE8O
        AQ2Hju85LEBIEZAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Get rid of the schedule work indirection
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231017211723.354748138@linutronix.de>
References: <20231017211723.354748138@linutronix.de>
MIME-Version: 1.0
Message-ID: <169780187303.3135.6617404814622767836.tip-bot2@tip-bot2>
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

Commit-ID:     dda4cedc27cfb76dc07230c501c81c59b62b1db0
Gitweb:        https://git.kernel.org/tip/dda4cedc27cfb76dc07230c501c81c59b62b1db0
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 17 Oct 2023 23:23:58 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 19 Oct 2023 15:53:00 +02:00

x86/microcode: Get rid of the schedule work indirection

Scheduling work on all CPUs to collect the microcode information is just
another extra step for no value. Let the CPU hotplug callback registration
do it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231017211723.354748138@linutronix.de
---
 arch/x86/kernel/cpu/microcode/core.c | 29 +++++++++------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 37145cf..0ed96d2 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -481,8 +481,16 @@ static struct syscore_ops mc_syscore_ops = {
 
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
@@ -503,20 +511,6 @@ static int mc_cpu_down_prep(unsigned int cpu)
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
@@ -562,12 +556,9 @@ static int __init microcode_init(void)
 		}
 	}
 
-	/* Do per-CPU setup */
-	schedule_on_each_cpu(setup_online_cpu);
-
 	register_syscore_ops(&mc_syscore_ops);
-	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "x86/microcode:online",
-				  mc_cpu_online, mc_cpu_down_prep);
+	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/microcode:online",
+			  mc_cpu_online, mc_cpu_down_prep);
 
 	pr_info("Microcode Update Driver: v%s.", DRIVER_VERSION);
 
