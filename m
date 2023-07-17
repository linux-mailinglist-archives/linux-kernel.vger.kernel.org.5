Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C52757086
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjGQXcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjGQXcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:32:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194B810C7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:31:26 -0700 (PDT)
Message-ID: <20230717223225.215108043@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=rgmHkZejpS0qXydJ9Am1q5T6I2ZzaAIkhjBamrktz/k=;
        b=00T/e6sXThT1a85ZqQWdu4xc7BpHBKIk3Qhl9MSi4pTKDhJ/pMd6BApjqpH2BGrQLrhxxt
        1s79dzgkYBcIKnwpf6IGXIfCfZU6AMwqT7dStRocDbGuhg+qqlo1zvgLz5mIJfljLQBza4
        xsTvlFgCq6cHXBrSESzgYSMW2CG6bveLkiCdTBgaD/ME0c7CpbLioRHO+WjDiAbS+oyigY
        /DKRO860dhFktAeMTG/qFGvcMSCWEfv9zFV86X9Aoyats4xyFA8WXp5vyIgxXejShgFqaf
        djmiJKzZfweQmFHkJdl1+XkzZdxphlUvlKk6NQUTemrAG8p7azBCC39eEvDPxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=rgmHkZejpS0qXydJ9Am1q5T6I2ZzaAIkhjBamrktz/k=;
        b=BcG88HF8RG3MClC7We1N4mClZ4OL32G72fXeOqgkXZZNutvTPHKBw7OJJ5/JBwqHppsCsT
        ePH+1GPO1XU6v8Dw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 36/58] x86/apic: Move safe wait_icr_idle() next to
 apic_mem_wait_icr_idle()
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:15:30 +0200 (CEST)
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

