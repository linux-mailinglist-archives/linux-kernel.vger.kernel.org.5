Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5CB75706B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjGQXRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjGQXRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:17:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3123DE47
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:16:55 -0700 (PDT)
Message-ID: <20230717223225.037396803@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=NZd5xR1HtDqEMrh0B1hOXEFIalKc6LgOvxIkfivvEsc=;
        b=4WyKvRD03r1sRefT9H8XV9xm5jc3hbqy6kdcvvRCsdBOXA+DEyWI5yorwbxVLJlrkYY+hl
        aIM2Tn2ypEqXAcX8j3F5ucE/OF8osNHnG/kiZT3I564AoA7I2IQfW6junat62MBAgeHoVZ
        M+X6hW/bQnCvkYt8dBbtNG8SCVoA3i/xQ37Yisf9i1dHnypV0+ApTTLDWG7Q4qzvkjVTI6
        s/ZkRRibovsdv+tEClU1L8H6V0/r0kRQfel4gcZQvVACXYR0fU4qVmKGIn4IacSekfrBV2
        GcdToV5d7Zjnq8ouEspuDCm6g9dRx1Dt9aDv5uLQJ/0rQnp4ujEwZywBjHz1Gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=NZd5xR1HtDqEMrh0B1hOXEFIalKc6LgOvxIkfivvEsc=;
        b=7eC6VKmrXMOHZhBfpJUG/fIFo2F27iX4w5tC0x6K1SjZ0JgoMJQemwCfx2TBWec7aOR2Cs
        wgTV8TJd36/IBdBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 33/58] x86/apic: Consolidate wait_icr_idle() implementations
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:15:25 +0200 (CEST)
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
 

