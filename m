Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7C075FE54
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjGXRrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjGXRqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:46:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4B626B8;
        Mon, 24 Jul 2023 10:44:31 -0700 (PDT)
Message-ID: <20230724172845.093176653@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690220669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=v1jagm3qezJbhLi1KwbMq1PXX83lXTZZ+4TGqrP0z90=;
        b=OkHXybNQQevV6glW3A2Mf6eoeYhUxke0k0HD+rpOPjuVGZ6TnXuObV/WYGTB64PHH2z3ea
        HKFaPqZYT853uTM64gPVidE0jWdQ4rQuVCJKKalORZrp9hHAYwlhHTj+iBbaqiBEhh6SXd
        ArO94NdNMJ0a51RGjo1LXON+xvjiOrqRuLw2sgYS+c3btuMJ3EYIg1YK+Z9BecLZPgCv+3
        FF+blwmBHA96byoG9OJ4DhB0YaHiA4xKnwwjFJOYNT9oQJ8PWlXdNCzshp6MzEIr9uWSiD
        Hit5O2GsziwCczYaPPleJ7HzSPxFiais1FI+8wBBR+8cmp0oAI7OPuJuQmgtnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690220669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=v1jagm3qezJbhLi1KwbMq1PXX83lXTZZ+4TGqrP0z90=;
        b=fZcd3cXW+uJASR5ZGQiUcmQm8+REqm2w/l2vqi5pQrVP+FlvnSet/BUrcyOfC1rL0YC633
        fCiPh7LmDSwkmECg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: [patch 24/29] x86/mm/numa: Use core domain size on AMD
References: <20230724155329.474037902@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 19:44:28 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

