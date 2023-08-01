Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C36076B246
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbjHAKtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbjHAKtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:49:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C6F3AB8
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:47:45 -0700 (PDT)
Message-ID: <20230801103817.025388065@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=XotObdBbNP3ucbQgBWCj/e0HCpzDGhDJU7P6fYqyeq4=;
        b=jYhhjFcsLCvW+/EDGAgzDQdpnkodJxfel+16jjleHFqHApDJQU6tD/+COmE9DkztwD85Pm
        N1dmNA7HAT8YzyVPMalVYkcc8VBV1cu1ujZrKeZvVC1d5SuHz7M0mjTfIIFHHOKUhPTCng
        b6yp0vHy4dX8zptK0QLZBA3lCkpVc1roa9QpnOr5iycBl1opJoA/tCiKpzK077GBl5pgmu
        XfJ7YfJqt7ENgtAxyZgXKpqrUwHLQc7GbZ95JTv2zQGtzS/5Wr3wRO65PKXEvLtHAy1AAh
        UInc9mFim0Dz2rlao/NHWSZN/+WPbv0SgWA5zedf7oPXgx/LKjHajCgJNuW7jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=XotObdBbNP3ucbQgBWCj/e0HCpzDGhDJU7P6fYqyeq4=;
        b=lyFuWaDJ5I/E6Q2YA7vXXaWucask2hDGUiiCu8FoIhvysnqkMFKYELTIUzHd0O1H+qplsw
        klKH/+B7Oxx6gDBw==
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
Subject: [patch V3 34/60] x86/apic: Consolidate wait_icr_idle()
 implementations
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:47:23 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
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
 

