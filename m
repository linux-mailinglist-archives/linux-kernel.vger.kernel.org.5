Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C9F76B259
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjHAKvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbjHAKvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:51:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D7D49EB
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:48:46 -0700 (PDT)
Message-ID: <20230801103818.159719736@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=TEFG8gkU/838HFgL72fmh8n+4W7BVeF0i1tCpnYKDqA=;
        b=VFbL0HFfrX7TJs82ET0+zn5kp1a2SLQnpxlb1kKGJ/vnK/9i8tNL63nkaCgQWo5q05EEHb
        5ohNGIi/1RUg6ZGfDEZuDNoPnp+ZjQF2dVtYWNg081xD8m88oh1rFIqsrGnpHEBmA2WJjU
        He0p+2vmGzwYpfp8R0b0HhdLcT08zgklwsICPilITdfE8SCOH6/eKYF2oewZvcBf9RVQog
        VfJfeqn0fSXa3cnKY7BaJHFozUa3wYu5NFEAshyI9QApGR2qRxlipPvZ2g3oUW7+WXMGqo
        aTb48NH38aJxk9182quv7onWrqMCRBbWqLApCdaQrUMfvsI9WRF4CByflU35DA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=TEFG8gkU/838HFgL72fmh8n+4W7BVeF0i1tCpnYKDqA=;
        b=qeVFuHPpJc9x5zSL7n0FxobJuFKJMjTRpiDyAl4kFvjSUVdE46G+VbaAb4vE3vHGyWAyxz
        Xl1kWutm2EtnKzBw==
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
Subject: [patch V3 55/60] x86/apic: Convert other overrides to
 apic_update_callback()
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:47:49 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert all places which just assign a new function directly to the apic
callback to use apic_update_callback() which prepares for using static
calls.

Mark snp_set_wakeup_secondary_cpu() and kvm_setup_pv_ipi() __init, as they
are only invoked from init code and otherwise trigger a section mismatch as
they are now invoking a __init function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
V2: Mark snp_set_wakeup_secondary_cpu() and kvm_setup_pv_ipi() __init.
---
 arch/x86/hyperv/hv_apic.c |   20 ++++++++++----------
 arch/x86/kernel/kvm.c     |    6 +++---
 arch/x86/kernel/sev.c     |    4 ++--
 3 files changed, 15 insertions(+), 15 deletions(-)

--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -288,12 +288,12 @@ void __init hv_apic_init(void)
 		 */
 		orig_apic = *apic;
 
-		apic->send_IPI = hv_send_ipi;
-		apic->send_IPI_mask = hv_send_ipi_mask;
-		apic->send_IPI_mask_allbutself = hv_send_ipi_mask_allbutself;
-		apic->send_IPI_allbutself = hv_send_ipi_allbutself;
-		apic->send_IPI_all = hv_send_ipi_all;
-		apic->send_IPI_self = hv_send_ipi_self;
+		apic_update_callback(send_IPI, hv_send_ipi);
+		apic_update_callback(send_IPI_mask, hv_send_ipi_mask);
+		apic_update_callback(send_IPI_mask_allbutself, hv_send_ipi_mask_allbutself);
+		apic_update_callback(send_IPI_allbutself, hv_send_ipi_allbutself);
+		apic_update_callback(send_IPI_all, hv_send_ipi_all);
+		apic_update_callback(send_IPI_self, hv_send_ipi_self);
 	}
 
 	if (ms_hyperv.hints & HV_X64_APIC_ACCESS_RECOMMENDED) {
@@ -312,10 +312,10 @@ void __init hv_apic_init(void)
 		 */
 		apic_update_callback(eoi, hv_apic_eoi_write);
 		if (!x2apic_enabled()) {
-			apic->read      = hv_apic_read;
-			apic->write     = hv_apic_write;
-			apic->icr_write = hv_apic_icr_write;
-			apic->icr_read  = hv_apic_icr_read;
+			apic_update_callback(read, hv_apic_read);
+			apic_update_callback(write, hv_apic_write);
+			apic_update_callback(icr_write, hv_apic_icr_write);
+			apic_update_callback(icr_read, hv_apic_icr_read);
 		}
 	}
 }
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -622,10 +622,10 @@ late_initcall(setup_efi_kvm_sev_migratio
 /*
  * Set the IPI entry points
  */
-static void kvm_setup_pv_ipi(void)
+static __init void kvm_setup_pv_ipi(void)
 {
-	apic->send_IPI_mask = kvm_send_ipi_mask;
-	apic->send_IPI_mask_allbutself = kvm_send_ipi_mask_allbutself;
+	apic_update_callback(send_IPI_mask, kvm_send_ipi_mask);
+	apic_update_callback(send_IPI_mask_allbutself, kvm_send_ipi_mask_allbutself);
 	pr_info("setup PV IPIs\n");
 }
 
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1089,7 +1089,7 @@ static int wakeup_cpu_via_vmgexit(int ap
 	return ret;
 }
 
-void snp_set_wakeup_secondary_cpu(void)
+void __init snp_set_wakeup_secondary_cpu(void)
 {
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return;
@@ -1099,7 +1099,7 @@ void snp_set_wakeup_secondary_cpu(void)
 	 * required method to start APs under SNP. If the hypervisor does
 	 * not support AP creation, then no APs will be started.
 	 */
-	apic->wakeup_secondary_cpu = wakeup_cpu_via_vmgexit;
+	apic_update_callback(wakeup_secondary_cpu, wakeup_cpu_via_vmgexit);
 }
 
 int __init sev_es_setup_ap_jump_table(struct real_mode_header *rmh)

