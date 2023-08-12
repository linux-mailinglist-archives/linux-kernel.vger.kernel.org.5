Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6532F77A24C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjHLUGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjHLUG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:06:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23521993
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 13:06:02 -0700 (PDT)
Message-ID: <20230812195728.881571946@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691870352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=l6wRx6fDuLz7AVhgf50kqWA5bfrKXDckgGTayzMQhXA=;
        b=h1xfnmqDfKHIVcm23sIPOdlKRTiWnkdP52LkPZek4v4EkEUdPRh4K+UHkrYiVpj1Oyfk+9
        7lTaH6Y7akEzB2X0a6cYazkCCfnqhxgfxd8iSyO936UU2m6/0Xrin1bWp460AiRuTJkqmt
        EOxu660RTkGpaMF4LfQUwCkcNEszuUiWzqqNsT7SVHMdNGIDFvWrmP3fb2+1i5EbMUy+BH
        jfEgJ1DQDtqx1se/2UGw0cc6NsArcXLEN1x5536up9WMdlmIdmq6Tg/nNII3Uph9ap3PzF
        wcrA2SlFYlnuZr0pdnHBvwg2nUoq9JDh8PsOTb34eWDU2TEXrx3wLfgAh3B5NA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691870352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=l6wRx6fDuLz7AVhgf50kqWA5bfrKXDckgGTayzMQhXA=;
        b=B1Qz+4iKBvJZiGkp3POPTyyo0xidh1HdSmIC41F5pPyf5C6ho4QsmpRwYtzI2+LQo7LRZq
        CKVisDdsTlaqi8CA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V2 23/37] x86/microcode: Get rid of the schedule work
 indirection
References: <20230812194003.682298127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 12 Aug 2023 21:59:12 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scheduling work on all CPUs to collect the microcode information is just
another extra step for no value. Let the CPU hotplug callback registration
do it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/kernel/cpu/microcode/core.c |   28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -553,8 +553,15 @@ static struct syscore_ops mc_syscore_ops
 
 static int mc_cpu_online(unsigned int cpu)
 {
+	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 	struct device *dev = get_cpu_device(cpu);
 
+	memset(uci, 0, sizeof(*uci));
+	microcode_ops->collect_cpu_info(cpu, &uci->cpu_sig);
+	this_cpu_write(cpu_info.microcode, uci->cpu_sig.rev);
+	if (!cpu)
+		boot_cpu_data.microcode = uci->cpu_sig.rev;
+
 	if (sysfs_create_group(&dev->kobj, &mc_attr_group))
 		pr_err("Failed to create group for CPU%d\n", cpu);
 	return 0;
@@ -575,20 +582,6 @@ static int mc_cpu_down_prep(unsigned int
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
-	this_cpu_write(cpu_info.microcode, uci->cpu_sig.rev);
-	if (!cpu)
-		boot_cpu_data.microcode = uci->cpu_sig.rev;
-	mc_cpu_online(cpu);
-}
-
 static struct attribute *cpu_root_microcode_attrs[] = {
 #ifdef CONFIG_MICROCODE_LATE_LOADING
 	&dev_attr_reload.attr,
@@ -634,12 +627,9 @@ static int __init microcode_init(void)
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
 

