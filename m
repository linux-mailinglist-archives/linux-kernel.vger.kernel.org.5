Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24EB766CEF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbjG1MQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbjG1MPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:15:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C1949CC;
        Fri, 28 Jul 2023 05:13:24 -0700 (PDT)
Message-ID: <20230728120931.448157949@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690546402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=v1jagm3qezJbhLi1KwbMq1PXX83lXTZZ+4TGqrP0z90=;
        b=OaTxVvEkBn8or9jvNdmQrVSkU7kbk6MdUYHBPqPvE3wbQk91EKdmBkdwW5cTUh0ohjVeZ/
        12rsXDyg/bDlbfRu5PQDd2wnvaxpTqYmed4W8xQCBeFIZeHfFqTxccMjm77jD4t/LmEE1g
        FzqGG24CYrpgWPN7yF8zMw0SMqm4PojNWv4ohANuHzeA3Li1O2Pe+7cmHFI1eZyI9awM4i
        5KVSm+7/Ts4oVObTBC5T2vcvMjy6g7yyQdZBQnWV85yhhrZTdopob/PWtaIJvjWCOGAWBk
        g2OaccF3YJckfYJfKdtYSxcpKSvoS2/OGETHJUXA5WkQa0e7kFfVHE67BYw5qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690546402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=v1jagm3qezJbhLi1KwbMq1PXX83lXTZZ+4TGqrP0z90=;
        b=vjKBc1lAvNSZpBzqQct6EMy+KlJwl47uNDI5KZB7JlhCw7KdOCBpBKMVBDQ/FCoheBWmal
        ewVNnLaHvO6uwXDw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: [patch v2 32/38] x86/mm/numa: Use core domain size on AMD
References: <20230728105650.565799744@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 28 Jul 2023 14:13:22 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

