Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F39D7B51FA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbjJBMAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236941AbjJBMAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:00:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CBACC4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 04:59:55 -0700 (PDT)
Message-ID: <20231002115902.971709581@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696247994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=lI3+LwrA6MimboCQf/gMpTVBIb07iXYJSWw2tVS61ec=;
        b=Wp9I6xd7IiOCzUoPlpJhDGFCm4aPZSxN44w28ehk4bNry/LR1yYU3kgepXt+pfXPSpBkR6
        3lwXXjKzsgs9U/hB9IgPuyY+NkiHW8jp12DBN/jETmyBwChSXYmVNB54n9b3zq4/8PlXcJ
        /Uh2GTcaq/x2J2GLk+Vm7pIgPp2+A01lGl0+hm4xkCNOigXZgxslJEVsQMu/6D2edD76TE
        qoQNRe0tYGCTstO6jXkkCUusOrOgHbgk7qG30yKXPtQ24TEv8W3Ent5Yq0c4IvfG4SI9re
        8fLqJGl7EPawOAHod9KTRh3YjZonx3pA/7r9aNYMQrjyxcjgA0uDRl1u7sD20g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696247994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=lI3+LwrA6MimboCQf/gMpTVBIb07iXYJSWw2tVS61ec=;
        b=dvJTVZRIaGkey0iEnVOKIxdRNzx5888IbAez8+qbXsGEHDlaUdW3m0/EMis7sILeMqgdgR
        z3j4OpvJrOzKq+BA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V4 16/30] x86/microcode: Get rid of the schedule work
 indirection
References: <20231002115506.217091296@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  2 Oct 2023 13:59:54 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 arch/x86/kernel/cpu/microcode/core.c |   29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -510,8 +510,16 @@ static struct syscore_ops mc_syscore_ops
 
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
@@ -532,20 +540,6 @@ static int mc_cpu_down_prep(unsigned int
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
@@ -591,12 +585,9 @@ static int __init microcode_init(void)
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
 

