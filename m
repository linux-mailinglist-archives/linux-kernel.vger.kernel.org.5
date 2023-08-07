Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA085772699
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbjHGNwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbjHGNwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:52:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C51092
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:52:38 -0700 (PDT)
Message-ID: <20230807135026.528433010@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=WJi6X1yIC43zDH6zaMpRD9ZckoH8t1jG0FLDTsc9drE=;
        b=vo8ZSYrGigDW+lveybRcUyoE0yAeso3KJgDMtkzOSoevZeD5daxgFasvS4bc6pCVEqppTr
        VteiTr5e90OtQrLsi7jNkfxlmZDyBNXISJFX7RBpB2r5mhMYoYppkaPkNzaUeJPO2Clb6A
        E/VEXGrCELg2Ml6T/A20LUvB3cTV3RY+cpm4/28ewHz0D3GZFk7pagLSTq3qPRhmu1pEtA
        I9RgA6vM2ykefyTF9enJ6VPnbXlNwnunhfxTZ3j3SMjrHCOPr58gIxKd5gNmLUuh14LAfi
        UDi3FRmtYSksJBHdm4BNuNN+NJckBX/yiuPfP22/PxKs5ihH8zSPBNAVWMh5LQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=WJi6X1yIC43zDH6zaMpRD9ZckoH8t1jG0FLDTsc9drE=;
        b=WiPf0GwyvOudYS7HOskUAYOK5noAXwaKrsCmKYnyR9v5PzbkCyCsNziXLWouPJiLHSPYiG
        gUwxUfmw3Pe9DnBQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
Subject: [patch 02/53] x86/cpu/topology: Make the APIC mismatch warnings
 complete
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:52:36 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detect all possible combinations of mismatch right in the CPUID evaluation
code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/common.c          |   15 ++-------------
 arch/x86/kernel/cpu/topology_common.c |   10 ++++++++++
 2 files changed, 12 insertions(+), 13 deletions(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1676,22 +1676,11 @@ static void generic_identify(struct cpui
 #endif
 }
 
-/*
- * Validate that ACPI/mptables have the same information about the
- * effective APIC id and update the package map.
- */
-static void validate_apic_and_package_id(struct cpuinfo_x86 *c)
+static void update_package_map(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_SMP
 	unsigned int cpu = smp_processor_id();
-	u32 apicid;
 
-	apicid = apic->cpu_present_to_apicid(cpu);
-
-	if (apicid != c->topo.apicid) {
-		pr_err(FW_BUG "CPU%u: APIC id mismatch. Firmware: %x APIC: %x\n",
-		       cpu, apicid, c->topo.initial_apicid);
-	}
 	BUG_ON(topology_update_package_map(c->topo.pkg_id, cpu));
 	BUG_ON(topology_update_die_map(c->topo.die_id, cpu));
 #else
@@ -1876,7 +1865,7 @@ void identify_secondary_cpu(struct cpuin
 #ifdef CONFIG_X86_32
 	enable_sep_cpu();
 #endif
-	validate_apic_and_package_id(c);
+	update_package_map(c);
 	x86_spec_ctrl_setup_ap();
 	update_srbds_msr();
 
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -176,6 +176,16 @@ void cpu_parse_topology(struct cpuinfo_x
 
 	parse_topology(&tscan, false);
 
+	if (c->topo.initial_apicid != c->topo.apicid) {
+		pr_err(FW_BUG "CPU%4u: APIC ID mismatch. CPUID: 0x%04x APIC: 0x%04x\n",
+		       cpu, c->topo.initial_apicid, c->topo.apicid);
+	}
+
+	if (c->topo.apicid != cpuid_to_apicid[cpu]) {
+		pr_err(FW_BUG "CPU%4u: APIC ID mismatch. Firmware: 0x%04x APIC: 0x%04x\n",
+		       cpu, cpuid_to_apicid[cpu], c->topo.apicid);
+	}
+
 	for (dom = TOPO_SMT_DOMAIN; dom < TOPO_MAX_DOMAIN; dom++) {
 		if (tscan.dom_shifts[dom] == x86_topo_system.dom_shifts[dom])
 			continue;

