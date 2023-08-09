Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CE2776A2A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbjHIUgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbjHIUgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:36:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135792111;
        Wed,  9 Aug 2023 13:36:08 -0700 (PDT)
Date:   Wed, 09 Aug 2023 20:36:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691613366;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BKgymA0Nyj04yj+S/5v9Z2cdQX5tomjetwTLfJopQm0=;
        b=ogkd9tFf7INt7FItVYdJ4dXgsQYy3Sip3yTNrcgGstUjGUQ/rdRVS9xrG5defcFNyWEmN4
        r8c3wttb4zXGDrRuZ2aNZHROrK5z3NuSefM/nRacbkcbAIIFwVEHlnQqfuxlnws++yR7l8
        dvtrD/OCbIIIqW/IA/i3SJKKNvscbZsoXRX0hDVfyjIOPFiVzzZDhXMp4/RztvH/8FD+hj
        6fyhBqh2YqLhTMCvJXI7sdqETr9xREJ9j/Vjy2ImeyVVVoD3YaRAJrSLYVXvFPvx+EsDh3
        2SzoNyOLPZ8BMMx0Ectckx51KHIKutvbXzrp0bOSLgy8M6lfSxtsXoank2Pgpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691613366;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BKgymA0Nyj04yj+S/5v9Z2cdQX5tomjetwTLfJopQm0=;
        b=nnPNM5ZpS6foRg3rdgujadq2Jz5nEiJRTnuTM6xs5w8X4DgW7YpRAUSn5IxmFoUj2V+VRF
        Msndf+er6fNayODA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Convert other overrides to apic_update_callback()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169161336618.27769.10942135525224144038.tip-bot2@tip-bot2>
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

Commit-ID:     d6f361ea706710f8d582bb176793b779a3b8b2ca
Gitweb:        https://git.kernel.org/tip/d6f361ea706710f8d582bb176793b779a3b8b2ca
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:04:20 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 12:00:46 -07:00

x86/apic: Convert other overrides to apic_update_callback()

Convert all places which just assign a new function directly to the apic
callback to use apic_update_callback() which prepares for using static
calls.

Mark snp_set_wakeup_secondary_cpu() and kvm_setup_pv_ipi() __init, as they
are only invoked from init code and otherwise trigger a section mismatch as
they are now invoking a __init function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/hyperv/hv_apic.c | 20 ++++++++++----------
 arch/x86/kernel/kvm.c     |  6 +++---
 arch/x86/kernel/sev.c     |  4 ++--
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index bfb02f6..72d9931 100644
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
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index c86cedb..6a36db4 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -622,10 +622,10 @@ late_initcall(setup_efi_kvm_sev_migration);
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
 
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 1ee7bed..a2b50ae 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1089,7 +1089,7 @@ static int wakeup_cpu_via_vmgexit(int apic_id, unsigned long start_ip)
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
