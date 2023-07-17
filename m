Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E7D757060
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjGQXQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjGQXQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:16:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A58D170B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:15:28 -0700 (PDT)
Message-ID: <20230717223224.268566460@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=LOe1UoiHO0aHtIvZLfVAh+MlqMt/c3MCV5lR+OfD/ak=;
        b=DP+ucTBLyxyq0EBs0k+ln0LD9AxMX1VyQ/hhPgpJMOnhr+QtIZw+EfjFAkP+DXSk5iRbIP
        0hpeyOn/xyVxTcczHjbCaXTSZd3CT6xDA3OsEercG21qP3isLsEw0n+bIwMpHa6NNhhoe5
        zrC41CD2xPyi+3RrnrbuNlGPvTV40Nn1raqZO1iSepAcIBByu5ORIjAMShN5rEAyGShwLf
        enlkPe1F1b9r55isJkG7JlterUd8SLiuaNT9euIcalvrwhgU92/qoT97JeAqPs8RQv9cig
        hp4OYrX7Hp/HV+dW3wvzL+PBGBl4smrM0dCgWrNyP+hJ88ZUG5STDyJxWhliVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=LOe1UoiHO0aHtIvZLfVAh+MlqMt/c3MCV5lR+OfD/ak=;
        b=RQbAdPYOX2KtL5Tcp4ULrped4lliiLCRgEZOw57CX7AxHODoEhlxpJG9oeqPb4wknIR7+4
        5BvEYYF3dlenBYCQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 20/58] x86/apic/32: Sanitize logical APIC ID handling
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:15:05 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

apic::x86_32_early_logical_apicid() is yet another historical joke.

It is used to preset the x86_cpu_to_logical_apicid per CPU variable during
APIC enumeration with:

  - 1 shifted left by the CPU number
  - the physical APIC ID in case of bigsmp

The latter is hillarious because bigsmp uses physical destination mode
which never can use the logical APIC ID.

It gets even worse. As bigsmp can be enforced late in the boot process the
probe function overwrites the per CPU variable which is never used for this
APIC type once again.

Remove that gunk and store 1 << cpunr unconditionally if and only if the
CPU number is less than 8, because the default logical destination mode
only allows up to 8 CPUs.

This is just an intermediate step before removing the per CPU insanity
completely. Stay tuned.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/apic.h      |   13 -------------
 arch/x86/kernel/apic/apic.c      |    4 ++--
 arch/x86/kernel/apic/apic_noop.c |   11 -----------
 arch/x86/kernel/apic/bigsmp_32.c |   18 ------------------
 arch/x86/kernel/apic/probe_32.c  |    7 -------
 5 files changed, 2 insertions(+), 51 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -315,19 +315,6 @@ struct apic {
 	/* wakeup secondary CPU using 64-bit wakeup point */
 	int	(*wakeup_secondary_cpu_64)(int apicid, unsigned long start_eip);
 
-#ifdef CONFIG_X86_32
-	/*
-	 * Called very early during boot from get_smp_config().  It should
-	 * return the logical apicid.  x86_[bios]_cpu_to_apicid is
-	 * initialized before this function is called.
-	 *
-	 * If logical apicid can't be determined that early, the function
-	 * may return BAD_APICID.  Logical apicid will be configured after
-	 * init_apic_ldr() while bringing up CPUs.  Note that NUMA affinity
-	 * won't be applied properly during early boot in this case.
-	 */
-	int (*x86_32_early_logical_apicid)(int cpu);
-#endif
 	char	*name;
 };
 
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2434,8 +2434,8 @@ static void cpu_update_apic(int cpu, int
 	early_per_cpu(x86_cpu_to_apicid, cpu) = apicid;
 #endif
 #ifdef CONFIG_X86_32
-	early_per_cpu(x86_cpu_to_logical_apicid, cpu) =
-		apic->x86_32_early_logical_apicid(cpu);
+	if (cpu < 8)
+		early_per_cpu(x86_cpu_to_logical_apicid, cpu) = 1U << cpu;
 #endif
 	set_cpu_possible(cpu, true);
 	physid_set(apicid, phys_cpu_present_map);
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -80,13 +80,6 @@ static void noop_apic_write(u32 reg, u32
 	WARN_ON_ONCE(boot_cpu_has(X86_FEATURE_APIC) && !apic_is_disabled);
 }
 
-#ifdef CONFIG_X86_32
-static int noop_x86_32_early_logical_apicid(int cpu)
-{
-	return BAD_APICID;
-}
-#endif
-
 struct apic apic_noop __ro_after_init = {
 	.name				= "noop",
 	.probe				= noop_probe,
@@ -130,8 +123,4 @@ struct apic apic_noop __ro_after_init =
 	.icr_write			= noop_apic_icr_write,
 	.wait_icr_idle			= noop_apic_wait_icr_idle,
 	.safe_wait_icr_idle		= noop_safe_apic_wait_icr_idle,
-
-#ifdef CONFIG_X86_32
-	.x86_32_early_logical_apicid	= noop_x86_32_early_logical_apicid,
-#endif
 };
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -28,12 +28,6 @@ static bool bigsmp_check_apicid_used(phy
 	return false;
 }
 
-static int bigsmp_early_logical_apicid(int cpu)
-{
-	/* on bigsmp, logical apicid is the same as physical */
-	return early_per_cpu(x86_cpu_to_apicid, cpu);
-}
-
 /*
  * bigsmp enables physical destination mode
  * and doesn't use LDR and DFR
@@ -154,27 +148,15 @@ static struct apic apic_bigsmp __ro_afte
 	.icr_write			= native_apic_icr_write,
 	.wait_icr_idle			= native_apic_wait_icr_idle,
 	.safe_wait_icr_idle		= native_safe_apic_wait_icr_idle,
-
-	.x86_32_early_logical_apicid	= bigsmp_early_logical_apicid,
 };
 
 void __init generic_bigsmp_probe(void)
 {
-	unsigned int cpu;
-
 	if (!probe_bigsmp())
 		return;
 
 	apic = &apic_bigsmp;
 
-	for_each_possible_cpu(cpu) {
-		if (early_per_cpu(x86_cpu_to_logical_apicid,
-				  cpu) == BAD_APICID)
-			continue;
-		early_per_cpu(x86_cpu_to_logical_apicid, cpu) =
-			bigsmp_early_logical_apicid(cpu);
-	}
-
 	pr_info("Overriding APIC driver with %s\n", apic_bigsmp.name);
 }
 
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -16,11 +16,6 @@
 
 #include "local.h"
 
-static int default_x86_32_early_logical_apicid(int cpu)
-{
-	return 1 << cpu;
-}
-
 static void setup_apic_flat_routing(void)
 {
 #ifdef CONFIG_X86_IO_APIC
@@ -101,8 +96,6 @@ static struct apic apic_default __ro_aft
 	.icr_write			= native_apic_icr_write,
 	.wait_icr_idle			= native_apic_wait_icr_idle,
 	.safe_wait_icr_idle		= native_safe_apic_wait_icr_idle,
-
-	.x86_32_early_logical_apicid	= default_x86_32_early_logical_apicid,
 };
 
 apic_driver(apic_default);

