Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8147976B249
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbjHAKuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbjHAKtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:49:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4037E5C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:47:46 -0700 (PDT)
Message-ID: <20230801103817.133626893@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=z2S2U2bO6X4QfT3xQwa1JPftqd1coMzUZ0B6XjGeK1c=;
        b=ragoNH5RrV00Hle+87rjWfZO5gf5Wf1Mx2zN71u5IhYYzp2IbBBnoB9qfqUFNzubxgBr/E
        Rdbf1hguEHIrpbJsTHLdANRwJZ8LGiHfriVukaMGr7LnKUMxmbrIM+V5PSCVzFJmHNTjC6
        3rcQmNaZ0vfHKbPdtFu1APGNStLjitwyOkNBjykgOLMQbwhSE59UarxuSI0u24t2nA0Olb
        dRz/Ib6MC5YuopgVlOIV/HEm8Fd0kgIWD78WZxNKTDvY6duJPITkL5DrzJQZw8WhIdxFkP
        yYE8chfiqdJx1Dm0DUp2w5BqeWHAaB/T7c+1OS0AoCTUuqd66JRGlqWUq56qcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=z2S2U2bO6X4QfT3xQwa1JPftqd1coMzUZ0B6XjGeK1c=;
        b=+wuDTLPasGlcm1nymr3UFjOm6MKuaWQMKZ1u7VCaeUcEek9C3y7PzGygAkwFYx6s2RkRNw
        c7sKEVvdzzN0IbCA==
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
Subject: [patch V3 36/60] x86/apic: Allow apic::safe_wait_icr_idle() to be
 NULL
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:47:25 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove tons of NOOP callbacks by making the invocation of
safe_wait_icr_idle() conditional in the inline wrapper.

Will be replaced by a static_call_cond() later.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/apic.h           |    8 +-------
 arch/x86/kernel/apic/apic_noop.c      |    6 ------
 arch/x86/kernel/apic/apic_numachip.c  |    8 --------
 arch/x86/kernel/apic/x2apic_cluster.c |    1 -
 arch/x86/kernel/apic/x2apic_phys.c    |    1 -
 arch/x86/kernel/apic/x2apic_uv_x.c    |    1 -
 arch/x86/xen/apic.c                   |    6 ------
 7 files changed, 1 insertion(+), 30 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -206,12 +206,6 @@ static inline u32 native_apic_msr_read(u
 	return (u32)msr;
 }
 
-static inline u32 native_safe_x2apic_wait_icr_idle(void)
-{
-	/* no need to wait for icr idle in x2apic */
-	return 0;
-}
-
 static inline void native_x2apic_icr_write(u32 low, u32 id)
 {
 	wrmsrl(APIC_BASE_MSR + (APIC_ICR >> 4), ((__u64) id) << 32 | low);
@@ -376,7 +370,7 @@ static inline void apic_wait_icr_idle(vo
 
 static inline u32 safe_apic_wait_icr_idle(void)
 {
-	return apic->safe_wait_icr_idle();
+	return apic->safe_wait_icr_idle ? apic->safe_wait_icr_idle() : 0;
 }
 
 extern void __init apic_set_eoi_write(void (*eoi_write)(u32 reg, u32 v));
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -27,11 +27,6 @@ static int noop_wakeup_secondary_cpu(int
 	return -1;
 }
 
-static u32 noop_safe_apic_wait_icr_idle(void)
-{
-	return 0;
-}
-
 static u64 noop_apic_icr_read(void)
 {
 	return 0;
@@ -104,5 +99,4 @@ struct apic apic_noop __ro_after_init =
 	.eoi_write			= noop_apic_write,
 	.icr_read			= noop_apic_icr_read,
 	.icr_write			= noop_apic_icr_write,
-	.safe_wait_icr_idle		= noop_safe_apic_wait_icr_idle,
 };
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -223,12 +223,6 @@ static int numachip2_acpi_madt_oem_check
 	return 1;
 }
 
-/* APIC NMI IPIs are queued */
-static u32 numachip_safe_apic_wait_icr_idle(void)
-{
-	return 0;
-}
-
 static const struct apic apic_numachip1 __refconst = {
 	.name				= "NumaConnect system",
 	.probe				= numachip1_probe,
@@ -264,7 +258,6 @@ static const struct apic apic_numachip1
 	.eoi_write			= native_apic_mem_write,
 	.icr_read			= native_apic_icr_read,
 	.icr_write			= native_apic_icr_write,
-	.safe_wait_icr_idle		= numachip_safe_apic_wait_icr_idle,
 };
 
 apic_driver(apic_numachip1);
@@ -304,7 +297,6 @@ static const struct apic apic_numachip2
 	.eoi_write			= native_apic_mem_write,
 	.icr_read			= native_apic_icr_read,
 	.icr_write			= native_apic_icr_write,
-	.safe_wait_icr_idle		= numachip_safe_apic_wait_icr_idle,
 };
 
 apic_driver(apic_numachip2);
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -266,7 +266,6 @@ static struct apic apic_x2apic_cluster _
 	.eoi_write			= native_apic_msr_eoi_write,
 	.icr_read			= native_x2apic_icr_read,
 	.icr_write			= native_x2apic_icr_write,
-	.safe_wait_icr_idle		= native_safe_x2apic_wait_icr_idle,
 };
 
 apic_driver(apic_x2apic_cluster);
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -180,7 +180,6 @@ static struct apic apic_x2apic_phys __ro
 	.eoi_write			= native_apic_msr_eoi_write,
 	.icr_read			= native_x2apic_icr_read,
 	.icr_write			= native_x2apic_icr_write,
-	.safe_wait_icr_idle		= native_safe_x2apic_wait_icr_idle,
 };
 
 apic_driver(apic_x2apic_phys);
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -854,7 +854,6 @@ static struct apic apic_x2apic_uv_x __ro
 	.eoi_write			= native_apic_msr_eoi_write,
 	.icr_read			= native_x2apic_icr_read,
 	.icr_write			= native_x2apic_icr_write,
-	.safe_wait_icr_idle		= native_safe_x2apic_wait_icr_idle,
 };
 
 #define	UVH_RH_GAM_ALIAS210_REDIRECT_CONFIG_LENGTH	3
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -92,11 +92,6 @@ static void xen_apic_icr_write(u32 low,
 	WARN_ON(1);
 }
 
-static u32 xen_safe_apic_wait_icr_idle(void)
-{
-        return 0;
-}
-
 static int xen_apic_probe_pv(void)
 {
 	if (xen_pv_domain())
@@ -161,7 +156,6 @@ static struct apic xen_pv_apic = {
 
 	.icr_read 			= xen_apic_icr_read,
 	.icr_write 			= xen_apic_icr_write,
-	.safe_wait_icr_idle 		= xen_safe_apic_wait_icr_idle,
 };
 
 static void __init xen_apic_check(void)

