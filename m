Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4D3776A33
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbjHIUgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbjHIUgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:36:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7A42112;
        Wed,  9 Aug 2023 13:36:08 -0700 (PDT)
Date:   Wed, 09 Aug 2023 20:36:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691613367;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=L4/E+IllbdMPEZagDIc603Uq48zuXbP57pSztKeeOwQ=;
        b=IF1925lYp2t43P4rIvwwdEDX/KLBB2TQ6Vvks7VD7eZ9z2CQiub6z9ZmVdTltmBec/rfyf
        lewy7hwZWn+1jXV80OjFVF4LFvQaJK/sVxeYL9elSF+12VY4Z1eCXZhe9awQmzCvyij1UM
        XNEmv4OdTfEamP1ecAOeM7RHEFSXxMmq5i1jS9r0FIRBO00AI3bxqAK876t+v0pg7Xx3Al
        DPxgIMNFjh+CRC2/OxSfFNpqwA9LEPey06/Fbf32hXNlNZN4awp1roAYeG26tx1zPsdjkg
        5ukuOWNCo9r4r9bQMu2BaqSoEjJnjijUhdXzZ07JfTILfjDAq/bBlZ3Af5Tz6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691613367;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=L4/E+IllbdMPEZagDIc603Uq48zuXbP57pSztKeeOwQ=;
        b=/UM5qqh3eCmfTihR2WKpA2NzeJtgHTF5FZfYsXWiMn+LM488eV5LKx6e88+J0ZZvU6JTr6
        UlcKICZqGavhfPCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Replace acpi_wake_cpu_handler_update() and
 apic_set_eoi_cb()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169161336670.27769.11370854432317500189.tip-bot2@tip-bot2>
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

Commit-ID:     2744a7ce34a776444225f20ae11ead6e980a129a
Gitweb:        https://git.kernel.org/tip/2744a7ce34a776444225f20ae11ead6e980a129a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:04:20 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 12:00:46 -07:00

x86/apic: Replace acpi_wake_cpu_handler_update() and apic_set_eoi_cb()

Switch them over to apic_update_callback() and remove the code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Wei Liu <wei.liu@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/hyperv/hv_apic.c   |  2 +-
 arch/x86/hyperv/hv_vtl.c    |  2 +-
 arch/x86/include/asm/apic.h |  3 ---
 arch/x86/kernel/acpi/boot.c |  2 +-
 arch/x86/kernel/apic/init.c | 27 ---------------------------
 arch/x86/kernel/kvm.c       |  4 ++--
 6 files changed, 5 insertions(+), 35 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 5513f60..bfb02f6 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -310,7 +310,7 @@ void __init hv_apic_init(void)
 		 * lazy EOI when available, but the same accessor works for
 		 * both xapic and x2apic because the field layout is the same.
 		 */
-		apic_set_eoi_cb(hv_apic_eoi_write);
+		apic_update_callback(eoi, hv_apic_eoi_write);
 		if (!x2apic_enabled()) {
 			apic->read      = hv_apic_read;
 			apic->write     = hv_apic_write;
diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 85d38b9..9976b77 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -222,7 +222,7 @@ static int __init hv_vtl_early_init(void)
 			  "Please add 'noxsave' to the kernel command line.\n");
 
 	real_mode_header = &hv_vtl_real_mode_header;
-	apic->wakeup_secondary_cpu_64 = hv_vtl_wakeup_secondary_cpu;
+	apic_update_callback(wakeup_secondary_cpu_64, hv_vtl_wakeup_secondary_cpu);
 
 	return 0;
 }
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 6e279c1..1742f97 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -417,8 +417,6 @@ static inline bool apic_id_valid(u32 apic_id)
 	return apic_id <= apic->max_apic_id;
 }
 
-extern void __init apic_set_eoi_cb(void (*eoi)(void));
-
 #else /* CONFIG_X86_LOCAL_APIC */
 
 static inline u32 apic_read(u32 reg) { return 0; }
@@ -478,7 +476,6 @@ static inline unsigned int read_apic_id(void)
 
 #ifdef CONFIG_X86_64
 typedef int (*wakeup_cpu_handler)(int apicid, unsigned long start_eip);
-extern void acpi_wake_cpu_handler_update(wakeup_cpu_handler handler);
 extern int default_acpi_madt_oem_check(char *, char *);
 extern void x86_64_probe_apic(void);
 #else
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 7f5b257..2374989 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1174,7 +1174,7 @@ static int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 
 	acpi_mp_wake_mailbox_paddr = mp_wake->base_address;
 
-	acpi_wake_cpu_handler_update(acpi_wakeup_cpu);
+	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
 
 	return 0;
 }
diff --git a/arch/x86/kernel/apic/init.c b/arch/x86/kernel/apic/init.c
index dab3afa..d7f4aca 100644
--- a/arch/x86/kernel/apic/init.c
+++ b/arch/x86/kernel/apic/init.c
@@ -55,30 +55,3 @@ void __init apic_install_driver(struct apic *driver)
 
 	pr_info("Switched APIC routing to: %s\n", driver->name);
 }
-
-#ifdef CONFIG_X86_64
-void __init acpi_wake_cpu_handler_update(wakeup_cpu_handler handler)
-{
-	struct apic **drv;
-
-	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++)
-		(*drv)->wakeup_secondary_cpu_64 = handler;
-}
-#endif
-
-/*
- * Override the generic EOI implementation with an optimized version.
- * Only called during early boot when only one CPU is active and with
- * interrupts disabled, so we know this does not race with actual APIC driver
- * use.
- */
-void __init apic_set_eoi_cb(void (*eoi)(void))
-{
-	struct apic **drv;
-
-	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++) {
-		/* Should happen once for each apic */
-		WARN_ON((*drv)->eoi == eoi);
-		(*drv)->eoi = eoi;
-	}
-}
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 54625a4..c86cedb 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -332,7 +332,7 @@ static void kvm_register_steal_time(void)
 
 static DEFINE_PER_CPU_DECRYPTED(unsigned long, kvm_apic_eoi) = KVM_PV_EOI_DISABLED;
 
-static notrace void kvm_guest_apic_eoi_write(void)
+static notrace __maybe_unused void kvm_guest_apic_eoi_write(void)
 {
 	/**
 	 * This relies on __test_and_clear_bit to modify the memory
@@ -825,7 +825,7 @@ static void __init kvm_guest_init(void)
 	}
 
 	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
-		apic_set_eoi_cb(kvm_guest_apic_eoi_write);
+		apic_update_callback(eoi, kvm_guest_apic_eoi_write);
 
 	if (kvm_para_has_feature(KVM_FEATURE_ASYNC_PF_INT) && kvmapf) {
 		static_branch_enable(&kvm_async_pf_enabled);
