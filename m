Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4EE75F876
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjGXNgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbjGXNfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:35:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9D21BE8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:34:59 -0700 (PDT)
Message-ID: <20230724132046.565793939@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690205682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=XotObdBbNP3ucbQgBWCj/e0HCpzDGhDJU7P6fYqyeq4=;
        b=THs3gdozYYmFcI0pLJTE5EoDS5sPb6gkNRNXObRZ1Q3mjIt5bUez4JiC0G37eAPx9vJS3n
        rFnl/IuTDPZ5LL9ek5TyHh4MIl3Xxe5rwYylGucoNsNeu+SZb6rnJuDAHvpl97yKi4EXKa
        qBCwp3oCyQucZ2Wy2VMGavSAVLikewNPTXjCUFJDh145L+SrT/ockSQcT6AGDP22vG5zFI
        xYqU/aZRKJF5uruyH9gzAG2/hw4xsrDPJlpzciVzVjc00lP6gK60MH0+eCBSo+55NGMgmp
        r8Fm15nzezLTBNjB+5B1GlLhlZ94QVQtqqfG705BP4x0CN63+dBZRj6hpnYeAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690205682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=XotObdBbNP3ucbQgBWCj/e0HCpzDGhDJU7P6fYqyeq4=;
        b=VBjiFS/Qnb09J/I4zLv2EuyWZSIP+g9d8cJ0H0N7MdAo1W6uuL+OzSlZmqODDfnfn4+Pp8
        9/dvder+swhQocBQ==
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
Subject: [patch V2 33/58] x86/apic: Consolidate wait_icr_idle() implementations
References: <20230724131206.500814398@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 15:34:41 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two copies and also needlessly public. Move it into ipi.c so it can be
inlined. Rename it to apic_mem_wait_icr_idle().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/apic.h         |    1 -
 arch/x86/kernel/apic/apic.c         |    6 ------
 arch/x86/kernel/apic/apic_flat_64.c |    4 ++--
 arch/x86/kernel/apic/bigsmp_32.c    |    2 +-
 arch/x86/kernel/apic/ipi.c          |    6 +++---
 arch/x86/kernel/apic/local.h        |    2 ++
 arch/x86/kernel/apic/probe_32.c     |    2 +-
 7 files changed, 9 insertions(+), 14 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -98,7 +98,6 @@ static inline u32 native_apic_mem_read(u
 	return *((volatile u32 *)(APIC_BASE + reg));
 }
 
-extern void native_apic_wait_icr_idle(void);
 extern u32 native_safe_apic_wait_icr_idle(void);
 extern void native_apic_icr_write(u32 low, u32 id);
 extern u64 native_apic_icr_read(void);
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -240,12 +240,6 @@ static void __init apic_disable(void)
 	apic = &apic_noop;
 }
 
-void native_apic_wait_icr_idle(void)
-{
-	while (apic_read(APIC_ICR) & APIC_ICR_BUSY)
-		cpu_relax();
-}
-
 u32 native_safe_apic_wait_icr_idle(void)
 {
 	u32 send_status;
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -111,7 +111,7 @@ static struct apic apic_flat __ro_after_
 	.eoi_write			= native_apic_mem_write,
 	.icr_read			= native_apic_icr_read,
 	.icr_write			= native_apic_icr_write,
-	.wait_icr_idle			= native_apic_wait_icr_idle,
+	.wait_icr_idle			= apic_mem_wait_icr_idle,
 	.safe_wait_icr_idle		= native_safe_apic_wait_icr_idle,
 };
 
@@ -187,7 +187,7 @@ static struct apic apic_physflat __ro_af
 	.eoi_write			= native_apic_mem_write,
 	.icr_read			= native_apic_icr_read,
 	.icr_write			= native_apic_icr_write,
-	.wait_icr_idle			= native_apic_wait_icr_idle,
+	.wait_icr_idle			= apic_mem_wait_icr_idle,
 	.safe_wait_icr_idle		= native_safe_apic_wait_icr_idle,
 };
 
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -108,7 +108,7 @@ static struct apic apic_bigsmp __ro_afte
 	.eoi_write			= native_apic_mem_write,
 	.icr_read			= native_apic_icr_read,
 	.icr_write			= native_apic_icr_write,
-	.wait_icr_idle			= native_apic_wait_icr_idle,
+	.wait_icr_idle			= apic_mem_wait_icr_idle,
 	.safe_wait_icr_idle		= native_safe_apic_wait_icr_idle,
 };
 
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -102,7 +102,7 @@ static inline int __prepare_ICR2(unsigne
 	return SET_XAPIC_DEST_FIELD(mask);
 }
 
-static inline void __xapic_wait_icr_idle(void)
+void apic_mem_wait_icr_idle(void)
 {
 	while (native_apic_mem_read(APIC_ICR) & APIC_ICR_BUSY)
 		cpu_relax();
@@ -137,7 +137,7 @@ static void __default_send_IPI_shortcut(
 	if (unlikely(vector == NMI_VECTOR))
 		safe_apic_wait_icr_idle();
 	else
-		__xapic_wait_icr_idle();
+		apic_mem_wait_icr_idle();
 
 	/* Destination field (ICR2) and the destination mode are ignored */
 	native_apic_mem_write(APIC_ICR, __prepare_ICR(shortcut, vector, 0));
@@ -154,7 +154,7 @@ void __default_send_IPI_dest_field(unsig
 	if (unlikely(vector == NMI_VECTOR))
 		safe_apic_wait_icr_idle();
 	else
-		__xapic_wait_icr_idle();
+		apic_mem_wait_icr_idle();
 
 	/* Set the IPI destination field in the ICR */
 	native_apic_mem_write(APIC_ICR2, __prepare_ICR2(dest_mask));
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -44,6 +44,8 @@ static inline unsigned int __prepare_ICR
 
 void default_init_apic_ldr(void);
 
+void apic_mem_wait_icr_idle(void);
+
 /*
  * This is used to send an IPI with no shorthand notation (the destination is
  * specified in bits 56 to 63 of the ICR).
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -64,7 +64,7 @@ static struct apic apic_default __ro_aft
 	.eoi_write			= native_apic_mem_write,
 	.icr_read			= native_apic_icr_read,
 	.icr_write			= native_apic_icr_write,
-	.wait_icr_idle			= native_apic_wait_icr_idle,
+	.wait_icr_idle			= apic_mem_wait_icr_idle,
 	.safe_wait_icr_idle		= native_safe_apic_wait_icr_idle,
 };
 

