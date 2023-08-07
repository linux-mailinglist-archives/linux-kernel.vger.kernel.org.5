Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB217726B6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbjHGNyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbjHGNx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:53:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34FA19AF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:53:20 -0700 (PDT)
Message-ID: <20230807135027.952716842@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=vSSLVehnXeqS3aVj1Xv9tp4/rOAt2y9JlTCXEhijejo=;
        b=3JHKTqT/JB1OCS3rE+TjyX4ojVXKcl3pi5D+1q0Hxzz2cHQn6xiu8bYejUmq6MWVHzVJnK
        WDnG2Px15NK3s+Tda5aCc069U/CtWD0vtJ61ODL1WNuvCCvbN2jziGxilWWhLrpSkhNF4t
        bez/EVljFOELvX7KfsCnTs55VfvsY5QO/W+F31/j77FPWa7p8qc0r3PEut5L0LJIZbUNit
        QiJii7bO65YWFV20+w3KglFpULbf+h9uYPpnJ/RGm6UdAecKn2EzhT/NLfWkvzsQY+Vd7D
        iB/ylLGEIdxUw2GkmHeUI/C450YN0n9FxKzqHIoYT7J/o+CsBM8u6CGRrZ1aUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=vSSLVehnXeqS3aVj1Xv9tp4/rOAt2y9JlTCXEhijejo=;
        b=HpF6jWC3yZXhuGINlovj1jL1sdISUapsfIv1P+MYPN22W8hGyIXv8FqV6QkUR39npPxKxd
        3FAC6hYBCT90JECw==
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
Subject: [patch 29/53] x86/acpi: Dont invoke topology_register_apic() for XEN
 PV
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:18 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MADT table for XEN/PV dom0 is not really useful and registering the
APICs is momentarily a pointless exercise because XENPV does not use an
APIC at all.

It overrides the x86_init.mpparse.parse_smp_config() callback, resets
num_processors and counts how many of them are provided by the hypervisor.

This is in the way of cleaning up the APIC registration. Prevent MADT
registration for XEN/PV temporarily until the rework is completed and
XEN/PV can use the MADT again.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/acpi/boot.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -23,6 +23,8 @@
 #include <linux/serial_core.h>
 #include <linux/pgtable.h>
 
+#include <xen/xen.h>
+
 #include <asm/e820/api.h>
 #include <asm/irqdomain.h>
 #include <asm/pci_x86.h>
@@ -161,7 +163,8 @@ static int __init acpi_parse_madt(struct
 
 static __init void acpi_register_lapic(u32 apic_id, u32 acpi_id, bool present)
 {
-	topology_register_apic(apic_id, acpi_id, present);
+	if (!xen_pv_domain())
+		topology_register_apic(apic_id, acpi_id, present);
 }
 
 static bool __init acpi_is_processor_usable(u32 lapic_flags)
@@ -1070,7 +1073,8 @@ static int __init early_acpi_parse_madt_
 		return count;
 	}
 
-	register_lapic_address(acpi_lapic_addr);
+	if (!xen_pv_domain())
+		register_lapic_address(acpi_lapic_addr);
 
 	return count;
 }

