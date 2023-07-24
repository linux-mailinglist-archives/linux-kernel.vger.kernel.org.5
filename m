Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FDD75F864
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjGXNg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjGXNft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:35:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9E81FF9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:35:13 -0700 (PDT)
Message-ID: <20230724132046.740349345@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690205687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=tVQYxJN/DzHFa1cx/oRePw+d48kC6weMnZb4I/fSkGc=;
        b=V0CBUKz3iYA7FamMURMv7ZC+NR9wh5+xhRt7KaIaqfJ5SrQVy6nO4t8vXg065G2hPTkuZz
        XDgpJpM4FJHkKL2b6req7nYWOYyHtCDu22PVoyXidDTOa1qpAqpxqLXkgu+bPi5S2bp0DK
        mhbN6k6t5NtLDAzkENatRnmp2CKqFiOVPXXCVeQby5lG5jnYGxDh9Z04rMwy5l/qvP1qdG
        F34JQyUvhKmoCIBsQ86EEOwfF5LNpYs5FyWKEXLgel2mRJKFGBC4jsQ0z5H9Qcmh0L23+G
        B4/gpclbPC79mwDoVcXv7MVPjshdp5NpCp5o3hLFCEmezbn5L+ZDBMaqwCZZcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690205687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=tVQYxJN/DzHFa1cx/oRePw+d48kC6weMnZb4I/fSkGc=;
        b=b/r0yCD6AW3mulD2/HfW+rv4hv6jDCZgUXkGTGH6kLI/14Y/t9fl/jswbxfTPl6aFfhqoB
        SA24MojOFAJouJDg==
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
Subject: [patch V2 36/58] x86/apic: Move safe wait_icr_idle() next to
 apic_mem_wait_icr_idle()
References: <20230724131206.500814398@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 15:34:46 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move it next to apic_mem_wait_icr_idle(), rename it so that it's clear what
it does and rewrite it in readable form.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/apic.h         |    1 -
 arch/x86/kernel/apic/apic.c         |   17 -----------------
 arch/x86/kernel/apic/apic_flat_64.c |    4 ++--
 arch/x86/kernel/apic/bigsmp_32.c    |    2 +-
 arch/x86/kernel/apic/ipi.c          |   19 +++++++++++++++++--
 arch/x86/kernel/apic/local.h        |    1 +
 arch/x86/kernel/apic/probe_32.c     |    2 +-
 7 files changed, 22 insertions(+), 24 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -98,7 +98,6 @@ static inline u32 native_apic_mem_read(u
 	return *((volatile u32 *)(APIC_BASE + reg));
 }
 
-extern u32 native_safe_apic_wait_icr_idle(void);
 extern void native_apic_icr_write(u32 low, u32 id);
 extern u64 native_apic_icr_read(void);
 
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -240,23 +240,6 @@ static void __init apic_disable(void)
 	apic = &apic_noop;
 }
 
-u32 native_safe_apic_wait_icr_idle(void)
-{
-	u32 send_status;
-	int timeout;
-
-	timeout = 0;
-	do {
-		send_status = apic_read(APIC_ICR) & APIC_ICR_BUSY;
-		if (!send_status)
-			break;
-		inc_irq_stat(icr_read_retry_count);
-		udelay(100);
-	} while (timeout++ < 1000);
-
-	return send_status;
-}
-
 void native_apic_icr_write(u32 low, u32 id)
 {
 	unsigned long flags;
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -112,7 +112,7 @@ static struct apic apic_flat __ro_after_
 	.icr_read			= native_apic_icr_read,
 	.icr_write			= native_apic_icr_write,
 	.wait_icr_idle			= apic_mem_wait_icr_idle,
-	.safe_wait_icr_idle		= native_safe_apic_wait_icr_idle,
+	.safe_wait_icr_idle		= apic_mem_wait_icr_idle_timeout,
 };
 
 /*
@@ -188,7 +188,7 @@ static struct apic apic_physflat __ro_af
 	.icr_read			= native_apic_icr_read,
 	.icr_write			= native_apic_icr_write,
 	.wait_icr_idle			= apic_mem_wait_icr_idle,
-	.safe_wait_icr_idle		= native_safe_apic_wait_icr_idle,
+	.safe_wait_icr_idle		= apic_mem_wait_icr_idle_timeout,
 };
 
 /*
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -109,7 +109,7 @@ static struct apic apic_bigsmp __ro_afte
 	.icr_read			= native_apic_icr_read,
 	.icr_write			= native_apic_icr_write,
 	.wait_icr_idle			= apic_mem_wait_icr_idle,
-	.safe_wait_icr_idle		= native_safe_apic_wait_icr_idle,
+	.safe_wait_icr_idle		= apic_mem_wait_icr_idle_timeout,
 };
 
 bool __init apic_bigsmp_possible(bool cmdline_override)
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/cpumask.h>
+#include <linux/delay.h>
 #include <linux/smp.h>
+
 #include <asm/io_apic.h>
 
 #include "local.h"
@@ -102,6 +104,19 @@ static inline int __prepare_ICR2(unsigne
 	return SET_XAPIC_DEST_FIELD(mask);
 }
 
+u32 apic_mem_wait_icr_idle_timeout(void)
+{
+	int cnt;
+
+	for (cnt = 0; cnt < 1000; cnt++) {
+		if (!(apic_read(APIC_ICR) & APIC_ICR_BUSY))
+			return 0;
+		inc_irq_stat(icr_read_retry_count);
+		udelay(100);
+	}
+	return APIC_ICR_BUSY;
+}
+
 void apic_mem_wait_icr_idle(void)
 {
 	while (native_apic_mem_read(APIC_ICR) & APIC_ICR_BUSY)
@@ -135,7 +150,7 @@ static void __default_send_IPI_shortcut(
 	 * to stop the others before launching the kdump kernel.
 	 */
 	if (unlikely(vector == NMI_VECTOR))
-		safe_apic_wait_icr_idle();
+		apic_mem_wait_icr_idle_timeout();
 	else
 		apic_mem_wait_icr_idle();
 
@@ -152,7 +167,7 @@ void __default_send_IPI_dest_field(unsig
 {
 	/* See comment in __default_send_IPI_shortcut() */
 	if (unlikely(vector == NMI_VECTOR))
-		safe_apic_wait_icr_idle();
+		apic_mem_wait_icr_idle_timeout();
 	else
 		apic_mem_wait_icr_idle();
 
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -45,6 +45,7 @@ static inline unsigned int __prepare_ICR
 void default_init_apic_ldr(void);
 
 void apic_mem_wait_icr_idle(void);
+u32 apic_mem_wait_icr_idle_timeout(void);
 
 /*
  * This is used to send an IPI with no shorthand notation (the destination is
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -65,7 +65,7 @@ static struct apic apic_default __ro_aft
 	.icr_read			= native_apic_icr_read,
 	.icr_write			= native_apic_icr_write,
 	.wait_icr_idle			= apic_mem_wait_icr_idle,
-	.safe_wait_icr_idle		= native_safe_apic_wait_icr_idle,
+	.safe_wait_icr_idle		= apic_mem_wait_icr_idle_timeout,
 };
 
 apic_driver(apic_default);

