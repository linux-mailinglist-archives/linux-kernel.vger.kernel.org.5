Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E70A7E89E2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 09:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjKKIh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 03:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjKKIhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 03:37:55 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FED33C3C;
        Sat, 11 Nov 2023 00:37:52 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0C4FD20B74C0;
        Sat, 11 Nov 2023 00:37:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0C4FD20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1699691872;
        bh=zbDWAPIzznRNV4elr6XvwFsGYrHF7a5O7SZKO+Ys2fU=;
        h=From:To:Cc:Subject:Date:From;
        b=tNT+XvlHT2BC8YzvppYf4rY9JG7lwqdImsQ8lCLh+JCNuJzwIvJ37pj8C15bMhAhJ
         s07GqOoQve+WmQi4emGwWsCQNEUXxmD6CXX9yCHmWSbbl8scnpXwS8Dr7LQAlFCB6w
         cHgj6kdSUB988nnsSS2kMp1jw6Kf+80XHrLDcQRc=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ssengar@microsoft.com
Subject: [PATCH v2] x86/hyperv: Fix the detection of E820_TYPE_PRAM in a Gen2 VM
Date:   Sat, 11 Nov 2023 00:37:47 -0800
Message-Id: <1699691867-9827-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A Gen2 VM doesn't support legacy PCI/PCIe, so both raw_pci_ops and
raw_pci_ext_ops are NULL, and pci_subsys_init() -> pcibios_init()
doesn't call pcibios_resource_survey() -> e820__reserve_resources_late();
as a result, any emulated persistent memory of E820_TYPE_PRAM (12) via
the kernel parameter memmap=nn[KMG]!ss is not added into iomem_resource
and hence can't be detected by register_e820_pmem().

Fix this by directly calling e820__reserve_resources_late() in
hv_pci_init(), which is called from arch_initcall(pci_arch_init).

It's ok to move a Gen2 VM's e820__reserve_resources_late() from
subsys_initcall(pci_subsys_init) to arch_initcall(pci_arch_init) because
the code in-between doesn't depend on the E820 resources.
e820__reserve_resources_late() depends on e820__reserve_resources(),
which has been called earlier from setup_arch().

For a Gen-2 VM, the new hv_pci_init() also adds any memory of
E820_TYPE_PMEM (7) into iomem_resource, and acpi_nfit_register_region() ->
acpi_nfit_insert_resource() -> region_intersects() returns
REGION_INTERSECTS, so the memory of E820_TYPE_PMEM won't get added twice.

Changed the local variable "int gen2vm" to "bool gen2vm".

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
[V2] Rebase to latest

 arch/x86/hyperv/hv_init.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 21556ad87f4b..8f3a4d16bb79 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <asm/apic.h>
 #include <asm/desc.h>
+#include <asm/e820/api.h>
 #include <asm/sev.h>
 #include <asm/ibt.h>
 #include <asm/hypervisor.h>
@@ -286,15 +287,31 @@ static int hv_cpu_die(unsigned int cpu)
 
 static int __init hv_pci_init(void)
 {
-	int gen2vm = efi_enabled(EFI_BOOT);
+	bool gen2vm = efi_enabled(EFI_BOOT);
 
 	/*
-	 * For Generation-2 VM, we exit from pci_arch_init() by returning 0.
-	 * The purpose is to suppress the harmless warning:
+	 * A Generation-2 VM doesn't support legacy PCI/PCIe, so both
+	 * raw_pci_ops and raw_pci_ext_ops are NULL, and pci_subsys_init() ->
+	 * pcibios_init() doesn't call pcibios_resource_survey() ->
+	 * e820__reserve_resources_late(); as a result, any emulated persistent
+	 * memory of E820_TYPE_PRAM (12) via the kernel parameter
+	 * memmap=nn[KMG]!ss is not added into iomem_resource and hence can't be
+	 * detected by register_e820_pmem(). Fix this by directly calling
+	 * e820__reserve_resources_late() here: e820__reserve_resources_late()
+	 * depends on e820__reserve_resources(), which has been called earlier
+	 * from setup_arch(). Note: e820__reserve_resources_late() also adds
+	 * any memory of E820_TYPE_PMEM (7) into iomem_resource, and
+	 * acpi_nfit_register_region() -> acpi_nfit_insert_resource() ->
+	 * region_intersects() returns REGION_INTERSECTS, so the memory of
+	 * E820_TYPE_PMEM won't get added twice.
+	 *
+	 * We return 0 here so that pci_arch_init() won't print the warning:
 	 * "PCI: Fatal: No config space access function found"
 	 */
-	if (gen2vm)
+	if (gen2vm) {
+		e820__reserve_resources_late();
 		return 0;
+	}
 
 	/* For Generation-1 VM, we'll proceed in pci_arch_init().  */
 	return 1;
-- 
2.34.1

