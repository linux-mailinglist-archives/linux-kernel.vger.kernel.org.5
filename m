Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350127726BA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbjHGNym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbjHGNxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:53:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EC710DB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:53:25 -0700 (PDT)
Message-ID: <20230807135028.108994145@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=O0KDW/sYTBHvu9oVtl0ZsFwyd9vxUlUG4W0MOjFJymI=;
        b=t3Hs084e3DoW05cKYoExyL5JqxGOQGeY6g/3Npa24OxX90/jIAWvoJp2VZtl/PzH60CFM4
        AWoC3TVzfhyTs/Zl1hICLPVl4bwsA3H5hSed5QJUj3vioP5D3t3yaUfCwgOe306cCLDIX2
        lwUy7n+PMbEIRaugop6WVeJyUN5CADV7tSscsT/eT5dMnVkt0iFJIq4qh0o7GG8YsjFv+q
        WYOPA+5tp5qsIwDJLc+SZMDSPGYLnXDWvgLZ/rWNbwFXnAcFkn1elRVd2MYvmIxXYHagfP
        OEc+/6TetFXtuGlhnMsIwQt3p5cCK+zxUiKKqMNpVqu9r/nD1UeZukD+9klNMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=O0KDW/sYTBHvu9oVtl0ZsFwyd9vxUlUG4W0MOjFJymI=;
        b=Kea/zMbKfuGzr86Q6qS2z1eetowyMK2zJNpkKtEP9NI/IRd7eQqlClwf5OTXTDdRM1Op7L
        8tpp/zPts7qcGDCQ==
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
Subject: [patch 32/53] x86/cpu/topology: Simplify APIC registration
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:23 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having the same check whether the number of assigned CPUs has reached the
nr_cpu_ids limit twice in the same code path is pointless. Repeating the
information that CPUs are ignored over and over is also pointless noise.

Remove the redundant check and reduce the noise by using a pr_warn_once().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/topology.c |   23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -102,14 +102,6 @@ static int allocate_logical_cpuid(u32 ap
 	if (cpu >= 0)
 		return cpu;
 
-	/* Allocate a new cpuid. */
-	if (nr_logical_cpuids >= nr_cpu_ids) {
-		WARN_ONCE(1, "APIC: NR_CPUS/possible_cpus limit of %u reached. "
-			     "Processor %d/0x%x and the rest are ignored.\n",
-			     nr_cpu_ids, nr_logical_cpuids, apic_id);
-		return -EINVAL;
-	}
-
 	cpuid_to_apicid[nr_logical_cpuids] = apic_id;
 	return nr_logical_cpuids++;
 }
@@ -130,7 +122,7 @@ static void cpu_update_apic(int cpu, u32
 
 static int generic_processor_info(int apicid)
 {
-	int cpu, max = nr_cpu_ids;
+	int cpu;
 
 	/* The boot CPU must be set before MADT/MPTABLE parsing happens */
 	if (cpuid_to_apicid[0] == BAD_APICID)
@@ -150,21 +142,12 @@ static int generic_processor_info(int ap
 	}
 
 	if (num_processors >= nr_cpu_ids) {
-		int thiscpu = max + disabled_cpus;
-
-		pr_warn("APIC: NR_CPUS/possible_cpus limit of %i reached. "
-			"Processor %d/0x%x ignored.\n", max, thiscpu, apicid);
-
+		pr_warn_once("APIC: CPU limit of %d reached. Ignoring further CPUs\n", nr_cpu_ids);
 		disabled_cpus++;
-		return -EINVAL;
+		return -ENOSPC;
 	}
 
 	cpu = allocate_logical_cpuid(apicid);
-	if (cpu < 0) {
-		disabled_cpus++;
-		return -EINVAL;
-	}
-
 	cpu_update_apic(cpu, apicid);
 	return cpu;
 }

