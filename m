Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93EA2757098
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjGQXhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjGQXhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:37:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D76171E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:36:09 -0700 (PDT)
Message-ID: <20230717223226.178478466@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=UsgerkQJ/HhbA2AbXpANMMQuwJxS8UzMeOUa8nnw3cg=;
        b=LHZGeCb7nf55OTUyQt+8eKj8zeR2DihYQFUGhVGoktuWtOV4acP4pzMDaOeDrygIArkINK
        mfbXOoiR3rJe69kvbb5gFPf1IlBjn3LUWpMfxkFZPgOfhA60MBz4tkKH6r/RFUuSBewYN3
        CqPLE+36Wr/F330F00c2Y6eWkL/91hnlvNh/4zUP3czKP+HbrRDFKvM3cJ8ZxPA+KmdXSo
        TkQyzZb7cgUzJcOgDETog+Q7XX89wUlS5zzB0ob0p/AqDIrgfGqQPF9+rabFcIDFOshG0W
        WgTv3RbzBeU08WLY9QUwOvLpDOgOOw2vCvnAJIYCFWRSUJ/vM7e9U8U8gknyMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=UsgerkQJ/HhbA2AbXpANMMQuwJxS8UzMeOUa8nnw3cg=;
        b=qIM43iQoGCywG4fyfcL0617AiK0I9LgvnRCOzpI5eiGyRFKotQFqSDtvTo36EDtea4GmK0
        pxON6r6oR5M491Ag==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 52/58] x86/apic: Replace acpi_wake_cpu_handler_update() and
 apic_set_eoi_cb()
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:15:55 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch them over to apic_update_callback() and remove the code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/hyperv/hv_apic.c   |    2 +-
 arch/x86/hyperv/hv_vtl.c    |    2 +-
 arch/x86/include/asm/apic.h |    3 ---
 arch/x86/kernel/acpi/boot.c |    2 +-
 arch/x86/kernel/apic/init.c |   27 ---------------------------
 arch/x86/kernel/kvm.c       |    2 +-
 6 files changed, 4 insertions(+), 34 deletions(-)

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
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -222,7 +222,7 @@ static int __init hv_vtl_early_init(void
 			  "Please add 'noxsave' to the kernel command line.\n");
 
 	real_mode_header = &hv_vtl_real_mode_header;
-	apic->wakeup_secondary_cpu_64 = hv_vtl_wakeup_secondary_cpu;
+	apic_update_callback(wakeup_secondary_cpu_64, hv_vtl_wakeup_secondary_cpu);
 
 	return 0;
 }
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -417,8 +417,6 @@ static inline bool apic_id_valid(u32 api
 	return apic_id <= apic->max_apic_id;
 }
 
-extern void __init apic_set_eoi_cb(void (*eoi)(void));
-
 #else /* CONFIG_X86_LOCAL_APIC */
 
 static inline u32 apic_read(u32 reg) { return 0; }
@@ -474,7 +472,6 @@ static inline unsigned int read_apic_id(
 
 #ifdef CONFIG_X86_64
 typedef int (*wakeup_cpu_handler)(int apicid, unsigned long start_eip);
-extern void acpi_wake_cpu_handler_update(wakeup_cpu_handler handler);
 extern int default_acpi_madt_oem_check(char *, char *);
 extern void x86_64_probe_apic(void);
 #else
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1174,7 +1174,7 @@ static int __init acpi_parse_mp_wake(uni
 
 	acpi_mp_wake_mailbox_paddr = mp_wake->base_address;
 
-	acpi_wake_cpu_handler_update(acpi_wakeup_cpu);
+	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
 
 	return 0;
 }
--- a/arch/x86/kernel/apic/init.c
+++ b/arch/x86/kernel/apic/init.c
@@ -55,30 +55,3 @@ void __init apic_install_driver(struct a
 
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
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -825,7 +825,7 @@ static void __init kvm_guest_init(void)
 	}
 
 	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
-		apic_set_eoi_cb(kvm_guest_apic_eoi_write);
+		apic_update_callback(eoi, kvm_guest_apic_eoi_write);
 
 	if (kvm_para_has_feature(KVM_FEATURE_ASYNC_PF_INT) && kvmapf) {
 		static_branch_enable(&kvm_async_pf_enabled);

