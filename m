Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F2976B244
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbjHAKto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbjHAKtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:49:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AF435BB
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:47:39 -0700 (PDT)
Message-ID: <20230801103816.969106021@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=gTGbbDL5HBuwEB2u+LxYM2ki0P05Jj6Bwt/DqClxZRM=;
        b=O4gGV7ZOTVqqbE6WSzsywAE5Cpx7g7mSLkc5363gGwi7+ahrylAyXCJPa9zNdfozz+j5UE
        17tQSbwgejhr/4IjXgpWuImY0feIHZEcv47fhed5mlH5gT4HZ0ZO+1+H3w5Ifew1duomZK
        YLph3O3TvX68sg1OPZj8IitHGh9l+7F13b7IbbiinGXsflqEWvwRAC8vfK8i0sqjMtOSi3
        lCEXKTb+MNEixXo2UqiWPXIMGqnqG8suKZJvmXhzhgkSGtL+osXBcW+NqBWs+AmWifzl9c
        lvMmaYe5nEMZhNUkjYl2S6loeHR5DzSiyFCPAz44ss080GeUvWzvGB/UF790Yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=gTGbbDL5HBuwEB2u+LxYM2ki0P05Jj6Bwt/DqClxZRM=;
        b=cM7usDf8nyzMnAL7AVpjBBqvxDJiBHwi0Mya4JKi36rmvsACYGj91OylKsdZEo6ZvfLQ1N
        P/RYVAgzEdrHLFCA==
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
Subject: [patch V3 33/60] x86/apic/ipi: Tidy up the code and fixup comments
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:47:22 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the undecodable comment on top of the function, replace the space
consuming zero content comments with useful ones and tidy up the
implementation to prevent further eye bleed.

Make __default_send_IPI_shortcut() static as it has no other users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/apic/ipi.c   |   74 ++++++++++++++++++-------------------------
 arch/x86/kernel/apic/local.h |    2 -
 2 files changed, 32 insertions(+), 44 deletions(-)

--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -108,68 +108,58 @@ static inline void __xapic_wait_icr_idle
 		cpu_relax();
 }
 
-void __default_send_IPI_shortcut(unsigned int shortcut, int vector)
+/*
+ * This is safe against interruption because it only writes the lower 32
+ * bits of the APIC_ICR register. The destination field is ignored for
+ * short hand IPIs.
+ *
+ *  wait_icr_idle()
+ *  write(ICR2, dest)
+ *  NMI
+ *	wait_icr_idle()
+ *	write(ICR)
+ *	wait_icr_idle()
+ *  write(ICR)
+ *
+ * This function does not need to disable interrupts as there is no ICR2
+ * interaction. The memory write is direct except when the machine is
+ * affected by the 11AP Pentium erratum, which turns the plain write into
+ * an XCHG operation.
+ */
+static void __default_send_IPI_shortcut(unsigned int shortcut, int vector)
 {
 	/*
-	 * Subtle. In the case of the 'never do double writes' workaround
-	 * we have to lock out interrupts to be safe.  As we don't care
-	 * of the value read we use an atomic rmw access to avoid costly
-	 * cli/sti.  Otherwise we use an even cheaper single atomic write
-	 * to the APIC.
-	 */
-	unsigned int cfg;
-
-	/*
-	 * Wait for idle.
+	 * Wait for the previous ICR command to complete.  Use
+	 * safe_apic_wait_icr_idle() for the NMI vector as there have been
+	 * issues where otherwise the system hangs when the panic CPU tries
+	 * to stop the others before launching the kdump kernel.
 	 */
 	if (unlikely(vector == NMI_VECTOR))
 		safe_apic_wait_icr_idle();
 	else
 		__xapic_wait_icr_idle();
 
-	/*
-	 * No need to touch the target chip field. Also the destination
-	 * mode is ignored when a shorthand is used.
-	 */
-	cfg = __prepare_ICR(shortcut, vector, 0);
-
-	/*
-	 * Send the IPI. The write to APIC_ICR fires this off.
-	 */
-	native_apic_mem_write(APIC_ICR, cfg);
+	/* Destination field (ICR2) and the destination mode are ignored */
+	native_apic_mem_write(APIC_ICR, __prepare_ICR(shortcut, vector, 0));
 }
 
 /*
  * This is used to send an IPI with no shorthand notation (the destination is
  * specified in bits 56 to 63 of the ICR).
  */
-void __default_send_IPI_dest_field(unsigned int mask, int vector, unsigned int dest)
+void __default_send_IPI_dest_field(unsigned int dest_mask, int vector,
+				   unsigned int dest_mode)
 {
-	unsigned long cfg;
-
-	/*
-	 * Wait for idle.
-	 */
+	/* See comment in __default_send_IPI_shortcut() */
 	if (unlikely(vector == NMI_VECTOR))
 		safe_apic_wait_icr_idle();
 	else
 		__xapic_wait_icr_idle();
 
-	/*
-	 * prepare target chip field
-	 */
-	cfg = __prepare_ICR2(mask);
-	native_apic_mem_write(APIC_ICR2, cfg);
-
-	/*
-	 * program the ICR
-	 */
-	cfg = __prepare_ICR(0, vector, dest);
-
-	/*
-	 * Send the IPI. The write to APIC_ICR fires this off.
-	 */
-	native_apic_mem_write(APIC_ICR, cfg);
+	/* Set the IPI destination field in the ICR */
+	native_apic_mem_write(APIC_ICR2, __prepare_ICR2(dest_mask));
+	/* Send it with the proper destination mode */
+	native_apic_mem_write(APIC_ICR, __prepare_ICR(0, vector, dest_mode));
 }
 
 void default_send_IPI_single_phys(int cpu, int vector)
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -44,8 +44,6 @@ static inline unsigned int __prepare_ICR
 
 void default_init_apic_ldr(void);
 
-void __default_send_IPI_shortcut(unsigned int shortcut, int vector);
-
 /*
  * This is used to send an IPI with no shorthand notation (the destination is
  * specified in bits 56 to 63 of the ICR).

