Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3626075705B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjGQXPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGQXPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:15:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5072B198B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:15:00 -0700 (PDT)
Message-ID: <20230717223223.971994770@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=8u5DJ4HOBNg4NQW33fRGAZF4EOI10KBFaQA+4tROpKs=;
        b=QLI6o7zZfUJ6uEVO0T/AOaNQcFm6gfKddASqWmV7W5RXFSwy+nUSFe+jExElnmyMygYN6h
        O+A5BETXOY1qqqEmS9oY4XobPnGU8HRsrbtcHv5Dn94m867kCJI7J+ttmS9qV65vU6Vssm
        FsumQO6gxgYEnklbeiHdvqw0/jtVCo/zvPRZ9UXkKY2VfzJlu/StHZP59Sn0pHK3a8g24R
        BjRFse4HgOgghai1BtadP3xVsgPMXnCBCavZHPnwdRl+ZHOfRdGz/Ev2KB4az9ANz9MAnQ
        FKYADvdw62f6MK9bCryiUKZcK/pPQbhyeq/Ju/O8+m534u8J+HoKFD3u44SOuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=8u5DJ4HOBNg4NQW33fRGAZF4EOI10KBFaQA+4tROpKs=;
        b=6oIKa1QrGezq5SuZ1jAJQe+seQVOmDV0SoWdTq18WSUjH1qD+gBOI2S4ha/qprGXeVBtCz
        C8rL0lbTGf5dxABA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 15/58] x86/apic: Sanitize APIC address setup
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:14:57 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert places which just write mp_lapic_addr and let them register the
local APIC address directly instead of relying on magic other code to do
so.

Add a WARN_ON() into register_lapic_address() which is raised when
register_lapic_address() is invoked more than once during boot.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/apic.c |   25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2009,12 +2009,12 @@ static bool __init detect_init_APIC(void
 		return false;
 	}
 
-	mp_lapic_addr = APIC_DEFAULT_PHYS_BASE;
+	register_lapic_address(APIC_DEFAULT_PHYS_BASE);
 	return true;
 }
 #else
 
-static bool __init apic_verify(void)
+static bool __init apic_verify(unsigned long addr)
 {
 	u32 features, h, l;
 
@@ -2028,15 +2028,15 @@ static bool __init apic_verify(void)
 		return false;
 	}
 	set_cpu_cap(&boot_cpu_data, X86_FEATURE_APIC);
-	mp_lapic_addr = APIC_DEFAULT_PHYS_BASE;
 
 	/* The BIOS may have set up the APIC at some other address */
 	if (boot_cpu_data.x86 >= 6) {
 		rdmsr(MSR_IA32_APICBASE, l, h);
 		if (l & MSR_IA32_APICBASE_ENABLE)
-			mp_lapic_addr = l & MSR_IA32_APICBASE_BASE;
+			addr = l & MSR_IA32_APICBASE_BASE;
 	}
 
+	register_lapic_address(addr);
 	pr_info("Found and enabled local APIC!\n");
 	return true;
 }
@@ -2063,7 +2063,7 @@ bool __init apic_force_enable(unsigned l
 			enabled_via_apicbase = 1;
 		}
 	}
-	return apic_verify();
+	return apic_verify(addr);
 }
 
 /*
@@ -2105,7 +2105,7 @@ static bool __init detect_init_APIC(void
 		if (!apic_force_enable(APIC_DEFAULT_PHYS_BASE))
 			return false;
 	} else {
-		if (!apic_verify())
+		if (!apic_verify(APIC_DEFAULT_PHYS_BASE))
 			return false;
 	}
 
@@ -2130,20 +2130,9 @@ void __init init_apic_mappings(void)
 	if (x2apic_mode)
 		return;
 
-	/* If no local APIC can be found return early */
 	if (!smp_found_config && !detect_init_APIC()) {
-		/* lets NOP'ify apic operations */
 		pr_info("APIC: disable apic facility\n");
 		apic_disable();
-	} else {
-		apic_phys = mp_lapic_addr;
-
-		/*
-		 * If the system has ACPI MADT tables or MP info, the LAPIC
-		 * address is already registered.
-		 */
-		if (!acpi_lapic && !smp_found_config)
-			register_lapic_address(apic_phys);
 	}
 }
 
@@ -2158,6 +2147,8 @@ static __init void apic_set_fixmap(void)
 
 void __init register_lapic_address(unsigned long address)
 {
+	/* This should only happen once */
+	WARN_ON_ONCE(mp_lapic_addr);
 	mp_lapic_addr = address;
 
 	if (!x2apic_mode)

