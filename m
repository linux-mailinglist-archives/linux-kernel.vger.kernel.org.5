Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36744776A41
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbjHIUhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbjHIUg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:36:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EDD211D;
        Wed,  9 Aug 2023 13:36:18 -0700 (PDT)
Date:   Wed, 09 Aug 2023 20:36:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691613377;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6V2eda6tSDiMcWu3bB/es9oPxcHTEiZuS6QOtH2lPkc=;
        b=h2GsWi1v++Y+0otWpeISvuUh/Hqj9K8oh4UMNOjyCdBU6VYRr3Lij7SVjaNupOCLvX8xNL
        ys/7oB8A7pLyeFhoxJryfAi7RJSvlVdFYB2Sd6YhdxmclKBfQ5R/Qx3CXk0lz7naYT2Sij
        cSwHOaV95aKYGLxb4HSfibJSpX38y+1v+PX8TeJ4HWsOQhVPsqvQ8XitM9Uk8jj3LmvsY2
        AN4eGKeNxraQp9iCOpV42rz4Zr1ynRJOy7gRnWE3rSR0LaeymS1m7gcbYnswK5vUv/a8Iw
        MYohAF0f+0n23ozSeeblxn8I1t7Dlhav7b2kt4twpw4LCHVE2H9rBSSZ2QvPhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691613377;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6V2eda6tSDiMcWu3bB/es9oPxcHTEiZuS6QOtH2lPkc=;
        b=dybyrnWG5L+Q+SdHDt6UAOSG84mN1LytkGouJDWzlBpVcAVzggNK3yQ4tr1NPvnXjDXvF8
        Eh3dceAhOF4BzTDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Consolidate wait_icr_idle() implementations
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169161337651.27769.15560408419021834767.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     cfebd0077f3fc083cc139d7851e2068d058a89dd
Gitweb:        https://git.kernel.org/tip/cfebd0077f3fc083cc139d7851e2068d058a89dd
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:04:04 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:28 -07:00

x86/apic: Consolidate wait_icr_idle() implementations

Two copies and also needlessly public. Move it into ipi.c so it can be
inlined. Rename it to apic_mem_wait_icr_idle().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/include/asm/apic.h         | 1 -
 arch/x86/kernel/apic/apic.c         | 6 ------
 arch/x86/kernel/apic/apic_flat_64.c | 4 ++--
 arch/x86/kernel/apic/bigsmp_32.c    | 2 +-
 arch/x86/kernel/apic/ipi.c          | 6 +++---
 arch/x86/kernel/apic/local.h        | 2 ++
 arch/x86/kernel/apic/probe_32.c     | 2 +-
 7 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 4fb71b7..1499865 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -98,7 +98,6 @@ static inline u32 native_apic_mem_read(u32 reg)
 	return *((volatile u32 *)(APIC_BASE + reg));
 }
 
-extern void native_apic_wait_icr_idle(void);
 extern u32 native_safe_apic_wait_icr_idle(void);
 extern void native_apic_icr_write(u32 low, u32 id);
 extern u64 native_apic_icr_read(void);
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 4ee95cb..ab26a61 100644
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
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index a0c875d..57d3afb 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -111,7 +111,7 @@ static struct apic apic_flat __ro_after_init = {
 	.eoi_write			= native_apic_mem_write,
 	.icr_read			= native_apic_icr_read,
 	.icr_write			= native_apic_icr_write,
-	.wait_icr_idle			= native_apic_wait_icr_idle,
+	.wait_icr_idle			= apic_mem_wait_icr_idle,
 	.safe_wait_icr_idle		= native_safe_apic_wait_icr_idle,
 };
 
@@ -187,7 +187,7 @@ static struct apic apic_physflat __ro_after_init = {
 	.eoi_write			= native_apic_mem_write,
 	.icr_read			= native_apic_icr_read,
 	.icr_write			= native_apic_icr_write,
-	.wait_icr_idle			= native_apic_wait_icr_idle,
+	.wait_icr_idle			= apic_mem_wait_icr_idle,
 	.safe_wait_icr_idle		= native_safe_apic_wait_icr_idle,
 };
 
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index ffff294..57077fc 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -108,7 +108,7 @@ static struct apic apic_bigsmp __ro_after_init = {
 	.eoi_write			= native_apic_mem_write,
 	.icr_read			= native_apic_icr_read,
 	.icr_write			= native_apic_icr_write,
-	.wait_icr_idle			= native_apic_wait_icr_idle,
+	.wait_icr_idle			= apic_mem_wait_icr_idle,
 	.safe_wait_icr_idle		= native_safe_apic_wait_icr_idle,
 };
 
diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index 614ac55..e0e0567 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -102,7 +102,7 @@ static inline int __prepare_ICR2(unsigned int mask)
 	return SET_XAPIC_DEST_FIELD(mask);
 }
 
-static inline void __xapic_wait_icr_idle(void)
+void apic_mem_wait_icr_idle(void)
 {
 	while (native_apic_mem_read(APIC_ICR) & APIC_ICR_BUSY)
 		cpu_relax();
@@ -137,7 +137,7 @@ static void __default_send_IPI_shortcut(unsigned int shortcut, int vector)
 	if (unlikely(vector == NMI_VECTOR))
 		safe_apic_wait_icr_idle();
 	else
-		__xapic_wait_icr_idle();
+		apic_mem_wait_icr_idle();
 
 	/* Destination field (ICR2) and the destination mode are ignored */
 	native_apic_mem_write(APIC_ICR, __prepare_ICR(shortcut, vector, 0));
@@ -154,7 +154,7 @@ void __default_send_IPI_dest_field(unsigned int dest_mask, int vector,
 	if (unlikely(vector == NMI_VECTOR))
 		safe_apic_wait_icr_idle();
 	else
-		__xapic_wait_icr_idle();
+		apic_mem_wait_icr_idle();
 
 	/* Set the IPI destination field in the ICR */
 	native_apic_mem_write(APIC_ICR2, __prepare_ICR2(dest_mask));
diff --git a/arch/x86/kernel/apic/local.h b/arch/x86/kernel/apic/local.h
index 5b0a0e7..2eb49d4 100644
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -44,6 +44,8 @@ static inline unsigned int __prepare_ICR(unsigned int shortcut, int vector,
 
 void default_init_apic_ldr(void);
 
+void apic_mem_wait_icr_idle(void);
+
 /*
  * This is used to send an IPI with no shorthand notation (the destination is
  * specified in bits 56 to 63 of the ICR).
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 81c69d7..52f3c6f 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -64,7 +64,7 @@ static struct apic apic_default __ro_after_init = {
 	.eoi_write			= native_apic_mem_write,
 	.icr_read			= native_apic_icr_read,
 	.icr_write			= native_apic_icr_write,
-	.wait_icr_idle			= native_apic_wait_icr_idle,
+	.wait_icr_idle			= apic_mem_wait_icr_idle,
 	.safe_wait_icr_idle		= native_safe_apic_wait_icr_idle,
 };
 
