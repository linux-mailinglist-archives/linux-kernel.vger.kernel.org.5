Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927707726AA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbjHGNyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbjHGNxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:53:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEFDF3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:53:04 -0700 (PDT)
Message-ID: <20230807135027.376971897@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=yHYtAXx6N+Nk90fJ68YHnOml1CTtFncFuulQcHEIemo=;
        b=sUlBhXS3CeJIVrozDtyIqT0AiVrVCCwyVOZPaJcE5XbABJz6THG5116OY0/t4X0AAlVVo5
        7NhxRlcpmwm2Ahm3z/odYBqqxJrwFoU4lgchBEKzhevXi/UVEisYcJkIyEmX2Ew9sukaQH
        30/TMsqtsImsY8I40f4jIpH84OaqVggDb12Tf7SJECueCNwknE8CeWc/uycb2vb2koU8dT
        xqC17cTFcsA20QdRUEBqGRcDUCvQ4oTHAJEjJJBfTAKadit20UMxdQhH9VFdr7tJotJFin
        D6B5W1xqulHftJ9ArZkel4r9m8SAIOSXORvrqdv0b8dxYluopJaroGWHUQlrpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=yHYtAXx6N+Nk90fJ68YHnOml1CTtFncFuulQcHEIemo=;
        b=Q97rvNeZksJfDAPWmSUaS97IrlyN0EWGYpWrZNFUZyZQIiBf6fQ3z6AEMJ488VMB8r0YTX
        9X+BYZJ88LHtpUDA==
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
Subject: [patch 18/53] x86/mm/numa: Move early mptable evaluation into common
 code
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:01 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to have the early mptable evaluation conditionally
invoked only from the AMD numa topology code.

Make it explicit and invoke it from setup_arch() right after the
corresponding ACPI init call. Remove the pointless wrapper and invoke
x86_init::mpparse::early_parse_smp_config() directly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/mpspec.h |    5 -----
 arch/x86/kernel/setup.c       |    2 ++
 arch/x86/mm/amdtopology.c     |    7 -------
 3 files changed, 2 insertions(+), 12 deletions(-)

--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -46,11 +46,6 @@ extern int smp_found_config;
 # define smp_found_config 0
 #endif
 
-static inline void early_get_smp_config(void)
-{
-	x86_init.mpparse.early_parse_smp_cfg();
-}
-
 #ifdef CONFIG_X86_MPPARSE
 extern void e820__memblock_alloc_reserved_mpc_new(void);
 extern int enable_update_mptable;
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1217,7 +1217,9 @@ void __init setup_arch(char **cmdline_p)
 
 	early_platform_quirks();
 
+	/* Some platforms need the APIC registered for NUMA configuration */
 	early_acpi_boot_init();
+	x86_init.mpparse.early_parse_smp_cfg();
 
 	initmem_init();
 	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
--- a/arch/x86/mm/amdtopology.c
+++ b/arch/x86/mm/amdtopology.c
@@ -161,13 +161,6 @@ int __init amd_numa_init(void)
 	 */
 	cores = topology_get_domain_size(TOPO_CORE_DOMAIN);
 
-	/*
-	 * Scan MPTABLE to map the local APIC and ensure that the boot CPU
-	 * APIC ID is valid. This is required because on pre ACPI/SRAT
-	 * systems IO-APICs are mapped before the boot CPU.
-	 */
-	early_get_smp_config();
-
 	apicid = boot_cpu_physical_apicid;
 	if (apicid > 0)
 		pr_info("BSP APIC ID: %02x\n", apicid);

