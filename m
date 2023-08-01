Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F089476B248
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbjHAKt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbjHAKtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:49:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557AC3ABA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:47:45 -0700 (PDT)
Message-ID: <20230801103817.079672072@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1p6M+HuhFutrVv6xarMScHVasdihs8aPDhQcOtKs0Y8=;
        b=L2VnB2bWVDToPq/sHERaiQL9m+S544m04dbw6ZcpksNGvjmkIBqnS9sa2l2p5qqgzeqry8
        NqgoKldNSXWGF1vV4vS0ENt2c3KrzKN8n8LUmkTDQSvABNy6QPUuTEmJKz2EW2ert5ElDH
        kT9lh91caWM1h4lvgbZW2HTzknmbMDAO7RVWmplRA95utw15UL4RKxVY0hdi2XRGvBdY1P
        2r6x4cqwJVHvRa09sKYAm932FLLuYr3cuzAfMOsx8heF/GjwUaSzn+8EySgw8945rFGXEA
        mjqABGDLqLi9UdnTO+VKmmuiALCjNHaUUQG5tilrHh4f79Go1zaVSjeZjvR1xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1p6M+HuhFutrVv6xarMScHVasdihs8aPDhQcOtKs0Y8=;
        b=Zq4hg45uWsKnwNdFk4opDhUwOHSqmSyRD5HRCj5o9c6NJB58Ds12XzEcHEu6N7Fwmat1Nu
        yl/gleBkobULV9Aw==
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
Subject: [patch V3 35/60] x86/apic: Allow apic::wait_icr_idle() to be NULL
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:47:24 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nuke more NOOP callbacks and make the invocation conditional. Will be
replaced with a static call later.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/apic.h           |    9 ++-------
 arch/x86/kernel/apic/apic_noop.c      |    2 --
 arch/x86/kernel/apic/apic_numachip.c  |    7 -------
 arch/x86/kernel/apic/x2apic_cluster.c |    1 -
 arch/x86/kernel/apic/x2apic_phys.c    |    1 -
 arch/x86/kernel/apic/x2apic_uv_x.c    |    1 -
 arch/x86/xen/apic.c                   |    5 -----
 7 files changed, 2 insertions(+), 24 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -206,12 +206,6 @@ static inline u32 native_apic_msr_read(u
 	return (u32)msr;
 }
 
-static inline void native_x2apic_wait_icr_idle(void)
-{
-	/* no need to wait for icr idle in x2apic */
-	return;
-}
-
 static inline u32 native_safe_x2apic_wait_icr_idle(void)
 {
 	/* no need to wait for icr idle in x2apic */
@@ -376,7 +370,8 @@ static inline void apic_icr_write(u32 lo
 
 static inline void apic_wait_icr_idle(void)
 {
-	apic->wait_icr_idle();
+	if (apic->wait_icr_idle)
+		apic->wait_icr_idle();
 }
 
 static inline u32 safe_apic_wait_icr_idle(void)
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -20,7 +20,6 @@ static void noop_send_IPI_mask_allbutsel
 static void noop_send_IPI_allbutself(int vector) { }
 static void noop_send_IPI_all(int vector) { }
 static void noop_send_IPI_self(int vector) { }
-static void noop_apic_wait_icr_idle(void) { }
 static void noop_apic_icr_write(u32 low, u32 id) { }
 
 static int noop_wakeup_secondary_cpu(int apicid, unsigned long start_eip)
@@ -105,6 +104,5 @@ struct apic apic_noop __ro_after_init =
 	.eoi_write			= noop_apic_write,
 	.icr_read			= noop_apic_icr_read,
 	.icr_write			= noop_apic_icr_write,
-	.wait_icr_idle			= noop_apic_wait_icr_idle,
 	.safe_wait_icr_idle		= noop_safe_apic_wait_icr_idle,
 };
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -223,11 +223,6 @@ static int numachip2_acpi_madt_oem_check
 	return 1;
 }
 
-/* APIC IPIs are queued */
-static void numachip_apic_wait_icr_idle(void)
-{
-}
-
 /* APIC NMI IPIs are queued */
 static u32 numachip_safe_apic_wait_icr_idle(void)
 {
@@ -269,7 +264,6 @@ static const struct apic apic_numachip1
 	.eoi_write			= native_apic_mem_write,
 	.icr_read			= native_apic_icr_read,
 	.icr_write			= native_apic_icr_write,
-	.wait_icr_idle			= numachip_apic_wait_icr_idle,
 	.safe_wait_icr_idle		= numachip_safe_apic_wait_icr_idle,
 };
 
@@ -310,7 +304,6 @@ static const struct apic apic_numachip2
 	.eoi_write			= native_apic_mem_write,
 	.icr_read			= native_apic_icr_read,
 	.icr_write			= native_apic_icr_write,
-	.wait_icr_idle			= numachip_apic_wait_icr_idle,
 	.safe_wait_icr_idle		= numachip_safe_apic_wait_icr_idle,
 };
 
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -266,7 +266,6 @@ static struct apic apic_x2apic_cluster _
 	.eoi_write			= native_apic_msr_eoi_write,
 	.icr_read			= native_x2apic_icr_read,
 	.icr_write			= native_x2apic_icr_write,
-	.wait_icr_idle			= native_x2apic_wait_icr_idle,
 	.safe_wait_icr_idle		= native_safe_x2apic_wait_icr_idle,
 };
 
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -180,7 +180,6 @@ static struct apic apic_x2apic_phys __ro
 	.eoi_write			= native_apic_msr_eoi_write,
 	.icr_read			= native_x2apic_icr_read,
 	.icr_write			= native_x2apic_icr_write,
-	.wait_icr_idle			= native_x2apic_wait_icr_idle,
 	.safe_wait_icr_idle		= native_safe_x2apic_wait_icr_idle,
 };
 
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -854,7 +854,6 @@ static struct apic apic_x2apic_uv_x __ro
 	.eoi_write			= native_apic_msr_eoi_write,
 	.icr_read			= native_x2apic_icr_read,
 	.icr_write			= native_x2apic_icr_write,
-	.wait_icr_idle			= native_x2apic_wait_icr_idle,
 	.safe_wait_icr_idle		= native_safe_x2apic_wait_icr_idle,
 };
 
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -120,10 +120,6 @@ static int xen_phys_pkg_id(int initial_a
 	return initial_apic_id >> index_msb;
 }
 
-static void xen_noop(void)
-{
-}
-
 static int xen_cpu_present_to_apicid(int cpu)
 {
 	if (cpu_present(cpu))
@@ -165,7 +161,6 @@ static struct apic xen_pv_apic = {
 
 	.icr_read 			= xen_apic_icr_read,
 	.icr_write 			= xen_apic_icr_write,
-	.wait_icr_idle 			= xen_noop,
 	.safe_wait_icr_idle 		= xen_safe_apic_wait_icr_idle,
 };
 

