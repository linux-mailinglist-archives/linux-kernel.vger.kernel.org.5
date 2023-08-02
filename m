Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1008876CAC8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbjHBKYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbjHBKXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:23:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB032698
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 03:22:10 -0700 (PDT)
Message-ID: <20230802101934.641924080@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690971711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=v1jagm3qezJbhLi1KwbMq1PXX83lXTZZ+4TGqrP0z90=;
        b=kcLGAGr8vM7wxvnJDZAIm84qWUyLQbZ131GYhWR2nUBgH0BXNc6LRZhNc/r/nhMZvhkC7j
        Er15Y6d7blSR2skuIbHBbCvfp5fXidLCf64XMiEKMBXXEbPyP9oooFaiGhP4eKLie51jAf
        h/KCzGBHBZ9Jj0Fh6QI3ebmNfejCLflyATl2tyQID9NDC8tCDPVn+EZMcag5IEPeFxiEWW
        UB2Z0wfmpAxVeBMaDu8W5HvJ8w6Jgb1Ksda7mDKPa4hjvaJ1Y2ixw1yHXW9nl17d/adP7F
        2cvFJ5D67t+7WuhCcRmEZbIOOpje8O410+DVWt0vYwBhzM16foHhf+zv5MJTdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690971711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=v1jagm3qezJbhLi1KwbMq1PXX83lXTZZ+4TGqrP0z90=;
        b=Rld9lTpVgQxq7V1PlqmPdI+w4f3FHxOXbaCI/j/VRhw5TtTS+OHW0NxB/T8ZpUPqMrWNFD
        l95uR0m/lpfAqzBg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: [patch V3 34/40] x86/mm/numa: Use core domain size on AMD
References: <20230802101635.459108805@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed,  2 Aug 2023 12:21:51 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpuinfo::topo::x86_coreid_bits is about to be phased out. Use the core
domain size from the topology information.

Add a comment why the early MPTABLE parsing is required and decrapify the
loop which sets the APIC ID to node map.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/mm/amdtopology.c |   35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

--- a/arch/x86/mm/amdtopology.c
+++ b/arch/x86/mm/amdtopology.c
@@ -54,13 +54,11 @@ static __init int find_northbridge(void)
 
 int __init amd_numa_init(void)
 {
-	u64 start = PFN_PHYS(0);
+	unsigned int numnodes, cores, apicid;
+	u64 prevbase, start = PFN_PHYS(0);
 	u64 end = PFN_PHYS(max_pfn);
-	unsigned numnodes;
-	u64 prevbase;
-	int i, j, nb;
 	u32 nodeid, reg;
-	unsigned int bits, cores, apicid_base;
+	int i, j, nb;
 
 	if (!early_pci_allowed())
 		return -EINVAL;
@@ -158,26 +156,25 @@ int __init amd_numa_init(void)
 		return -ENOENT;
 
 	/*
-	 * We seem to have valid NUMA configuration.  Map apicids to nodes
-	 * using the coreid bits from early_identify_cpu.
+	 * We seem to have valid NUMA configuration. Map apicids to nodes
+	 * using the size of the core domain in the APIC space.
 	 */
-	bits = boot_cpu_data.x86_coreid_bits;
-	cores = 1 << bits;
-	apicid_base = 0;
+	cores = topology_get_domain_size(TOPO_CORE_DOMAIN);
 
 	/*
-	 * get boot-time SMP configuration:
+	 * Scan MPTABLE to map the local APIC and ensure that the boot CPU
+	 * APIC ID is valid. This is required because on pre ACPI/SRAT
+	 * systems IO-APICs are mapped before the boot CPU.
 	 */
 	early_get_smp_config();
 
-	if (boot_cpu_physical_apicid > 0) {
-		pr_info("BSP APIC ID: %02x\n", boot_cpu_physical_apicid);
-		apicid_base = boot_cpu_physical_apicid;
+	apicid = boot_cpu_physical_apicid;
+	if (apicid > 0)
+		pr_info("BSP APIC ID: %02x\n", apicid);
+
+	for_each_node_mask(i, numa_nodes_parsed) {
+		for (j = 0; j < cores; j++, apicid++)
+			set_apicid_to_node(apicid, i);
 	}
-
-	for_each_node_mask(i, numa_nodes_parsed)
-		for (j = apicid_base; j < cores + apicid_base; j++)
-			set_apicid_to_node((i << bits) + j, i);
-
 	return 0;
 }

