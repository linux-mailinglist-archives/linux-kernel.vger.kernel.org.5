Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FC476CAB3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbjHBKWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjHBKVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:21:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC0630D1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 03:21:20 -0700 (PDT)
Message-ID: <20230802101933.453524827@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690971678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=axWsLWrT43omLwQZ83u4QKHGIXaDqvWCJze4cehqf28=;
        b=WKlvsn7Z8S7Z569PBt4IzG9+PQese99tsFzpGXySXMQR4ASEQl0I5yylVadRpA2z+UvDkl
        fvKGXLFgcyeb8FT04A6UCFFVT1cJRoih5Pz8X+T4TLnaxfMy26f1WONnQ3R7Bz6zO06iVx
        AlKwVDFbplAXgoNKjb0w6vXD3i9ryZ5JJu0X2I+P2RUGWJtNd+/f++w21KrPTR31xn6xYL
        9k7mPVu9twSsWkhCa3LII4pIqV77yNMyVUnZy80NKbVqog/qMSG1nwZDD2SbsSrU+oV+8V
        1gELZBIceklbCUvR/E/Cwv4wcWfwM1x2jWpAGM55SVt14NLdMDxHkqrj1egb/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690971678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=axWsLWrT43omLwQZ83u4QKHGIXaDqvWCJze4cehqf28=;
        b=VV6pxm4wqevoFpM6kZDiaE79cewcMMMk36+NiNp8Iox5xIYIBHQVHFHGzZ6gpAwhhloH5m
        +doygJjo+YJ0X2AA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: [patch V3 13/40] x86/apic: Use BAD_APICID consistently
References: <20230802101635.459108805@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed,  2 Aug 2023 12:21:18 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

APIC ID checks compare with BAD_APICID all over the place, but some
initializers and some code which fiddles with global data structure use
-1[U] instead. That simply cannot work at all.

Fix it up and use BAD_APICID consistently all over the place.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Fixed changelog typos - Sohil
---
 arch/x86/kernel/acpi/boot.c |    2 +-
 arch/x86/kernel/apic/apic.c |    6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -852,7 +852,7 @@ int acpi_unmap_cpu(int cpu)
 	set_apicid_to_node(per_cpu(x86_cpu_to_apicid, cpu), NUMA_NO_NODE);
 #endif
 
-	per_cpu(x86_cpu_to_apicid, cpu) = -1;
+	per_cpu(x86_cpu_to_apicid, cpu) = BAD_APICID;
 	set_cpu_present(cpu, false);
 	num_processors--;
 
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -70,7 +70,7 @@ unsigned int num_processors;
 unsigned disabled_cpus;
 
 /* Processor that is doing the boot up */
-unsigned int boot_cpu_physical_apicid __ro_after_init = -1U;
+unsigned int boot_cpu_physical_apicid __ro_after_init = BAD_APICID;
 EXPORT_SYMBOL_GPL(boot_cpu_physical_apicid);
 
 u8 boot_cpu_apic_version __ro_after_init;
@@ -2316,9 +2316,7 @@ static int nr_logical_cpuids = 1;
 /*
  * Used to store mapping between logical CPU IDs and APIC IDs.
  */
-int cpuid_to_apicid[] = {
-	[0 ... NR_CPUS - 1] = -1,
-};
+int cpuid_to_apicid[] = { [0 ... NR_CPUS - 1] = BAD_APICID, };
 
 bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
 {

