Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAAA75F878
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjGXNeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGXNdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:33:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D7D1B3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:33:54 -0700 (PDT)
Message-ID: <20230724132044.883726935@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690205633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=SEdHGmVEi1bYp03gPNqEFMS5i4ouVhk/JVGxKX8FQ3E=;
        b=tbMKtwTWRTTYej8k/jAQUohfMhZ/T+McvSkCmo+G7hSdk2KufN74F0K4iBv28H/LIYe/NA
        7YfAe6lX1wU+Kz2Ga7Dr41zN9yG0PLuY9+Rwvs/YNUc5a0JNdGCUQq6z2UFYB47bndkq1D
        oASP4Qaidithyf5u260BFlJKSiECV87MFIYfFjqa2dX3TV9T3ulOarE5jw39Rh4etcxkrm
        dUH0UYcOOuaIl2O4N1LsfnelXywCw7B22SzOWSXirc5S8BPbYU3WQQyervIn8nEjK/XEHw
        2BFDg1h1B9ktS5AsFYWPGtjx9vPitUMR66zpiaHe/XDIlRfVDBBf6jOL/Eny7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690205633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=SEdHGmVEi1bYp03gPNqEFMS5i4ouVhk/JVGxKX8FQ3E=;
        b=Hdc4FudNrw8+t2jSmeYCBhXdv45w9l7iw0CNbD9XEIH3Lst8MlrQcK2Hle1BrSoRs6Czee
        AT1RyAsNHuYQiuAg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V2 05/58] x86/apic: Remove pointless x86_bios_cpu_apicid
References: <20230724131206.500814398@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 15:33:52 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's a useless copy of x86_cpu_to_apicid.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/apic.h        |    2 --
 arch/x86/include/asm/smp.h         |    1 -
 arch/x86/kernel/apic/apic.c        |    5 +----
 arch/x86/kernel/apic/apic_common.c |    2 +-
 arch/x86/kernel/apic/bigsmp_32.c   |    2 +-
 arch/x86/kernel/apic/probe_64.c    |    4 +---
 arch/x86/kernel/setup_percpu.c     |    3 ---
 7 files changed, 4 insertions(+), 15 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -477,8 +477,6 @@ extern void generic_bigsmp_probe(void);
 
 #define APIC_DFR_VALUE	(APIC_DFR_FLAT)
 
-DECLARE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_bios_cpu_apicid);
-
 extern struct apic apic_noop;
 
 static inline unsigned int read_apic_id(void)
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -22,7 +22,6 @@ DECLARE_PER_CPU_READ_MOSTLY(u16, cpu_l2c
 
 DECLARE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_cpu_to_apicid);
 DECLARE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_acpiid);
-DECLARE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_bios_cpu_apicid);
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86_32)
 DECLARE_EARLY_PER_CPU_READ_MOSTLY(int, x86_cpu_to_logical_apicid);
 #endif
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -108,10 +108,8 @@ unsigned long apic_mmio_base __ro_after_
  * Map cpu index to physical APIC ID
  */
 DEFINE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_cpu_to_apicid, BAD_APICID);
-DEFINE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_bios_cpu_apicid, BAD_APICID);
 DEFINE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_acpiid, U32_MAX);
 EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_apicid);
-EXPORT_EARLY_PER_CPU_SYMBOL(x86_bios_cpu_apicid);
 EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_acpiid);
 
 #ifdef CONFIG_X86_32
@@ -2511,7 +2509,7 @@ int generic_processor_info(int apicid, i
 
 	if (apicid == boot_cpu_physical_apicid) {
 		/*
-		 * x86_bios_cpu_apicid is required to have processors listed
+		 * x86_cpu_to_apicid is required to have processors listed
 		 * in same order as logical cpu numbers. Hence the first
 		 * entry is BSP, and so on.
 		 * boot_cpu_init() already hold bit 0 in cpu_present_mask
@@ -2548,7 +2546,6 @@ int generic_processor_info(int apicid, i
 
 #if defined(CONFIG_SMP) || defined(CONFIG_X86_64)
 	early_per_cpu(x86_cpu_to_apicid, cpu) = apicid;
-	early_per_cpu(x86_bios_cpu_apicid, cpu) = apicid;
 #endif
 #ifdef CONFIG_X86_32
 	early_per_cpu(x86_cpu_to_logical_apicid, cpu) =
--- a/arch/x86/kernel/apic/apic_common.c
+++ b/arch/x86/kernel/apic/apic_common.c
@@ -29,7 +29,7 @@ void default_ioapic_phys_id_map(physid_m
 int default_cpu_present_to_apicid(int mps_cpu)
 {
 	if (mps_cpu < nr_cpu_ids && cpu_present(mps_cpu))
-		return (int)per_cpu(x86_bios_cpu_apicid, mps_cpu);
+		return (int)per_cpu(x86_cpu_to_apicid, mps_cpu);
 	else
 		return BAD_APICID;
 }
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -52,7 +52,7 @@ static void bigsmp_setup_apic_routing(vo
 static int bigsmp_cpu_present_to_apicid(int mps_cpu)
 {
 	if (mps_cpu < nr_cpu_ids)
-		return (int) per_cpu(x86_bios_cpu_apicid, mps_cpu);
+		return (int) per_cpu(x86_cpu_to_apicid, mps_cpu);
 
 	return BAD_APICID;
 }
--- a/arch/x86/kernel/apic/probe_64.c
+++ b/arch/x86/kernel/apic/probe_64.c
@@ -13,9 +13,7 @@
 
 #include "local.h"
 
-/*
- * Check the APIC IDs in bios_cpu_apicid and choose the APIC mode.
- */
+/* Select the appropriate APIC driver */
 void __init default_setup_apic_routing(void)
 {
 	struct apic **drv;
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -181,8 +181,6 @@ void __init setup_per_cpu_areas(void)
 #ifdef CONFIG_X86_LOCAL_APIC
 		per_cpu(x86_cpu_to_apicid, cpu) =
 			early_per_cpu_map(x86_cpu_to_apicid, cpu);
-		per_cpu(x86_bios_cpu_apicid, cpu) =
-			early_per_cpu_map(x86_bios_cpu_apicid, cpu);
 		per_cpu(x86_cpu_to_acpiid, cpu) =
 			early_per_cpu_map(x86_cpu_to_acpiid, cpu);
 #endif
@@ -214,7 +212,6 @@ void __init setup_per_cpu_areas(void)
 	/* indicate the early static arrays will soon be gone */
 #ifdef CONFIG_X86_LOCAL_APIC
 	early_per_cpu_ptr(x86_cpu_to_apicid) = NULL;
-	early_per_cpu_ptr(x86_bios_cpu_apicid) = NULL;
 	early_per_cpu_ptr(x86_cpu_to_acpiid) = NULL;
 #endif
 #ifdef CONFIG_X86_32

