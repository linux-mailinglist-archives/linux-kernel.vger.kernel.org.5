Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F78975F88D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjGXNjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjGXNi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:38:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D453C27
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:36:49 -0700 (PDT)
Message-ID: <20230724132047.611558040@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690205713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=4GFxWOIrpTfqT5fCSkz52w3aacX6yQNA53PA8dS4E0E=;
        b=zptSSBtO1rWwzGKir+or4dSXyIMymZXnRM5fAuXjhYH/UIPw/y/RozcRA4zvsHrzKVklI3
        Olh1RbHVdR4Z/Aw3KexJuLkOCo/aJdj2uPoRi31J5PIXokFGCAUMvsEWaSrDrYH1tDb7a9
        Xv89knTWJQ8CazKkozhWtI89hEzkSf2nyyZoeAiiMOw6Eq3/BwM4B9DKgFn845ZoBabcU6
        +Z3M7GPxQSBNopy7Qji13fryOt6hg1hB1OKoK+jPCnJwqn5zBJIJLJnpT6Pg9pwekZdUbN
        Zlmt9iiSHlJz6Q0ysv8GR/u0eg8kK1fAY2xxnA9f6CGnDM8j8WuJUXTVGPa5UQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690205713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=4GFxWOIrpTfqT5fCSkz52w3aacX6yQNA53PA8dS4E0E=;
        b=gcKuNfWVF0T7yp825uFEHKQaJHvli5qi5psu7QM2lz/GftTXdUck64n7QcmhEzDoK0r5Ga
        HAmbFg9MlQGMMVAg==
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
Subject: [patch V2 51/58] x86/apic: Provide apic_update_callback()
References: <20230724131206.500814398@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 15:35:12 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are already two variants of update mechanism for particular callbacks
and virtualization just writes into the data structure.

Provide an interface and use a shadow data structure to preserve callbacks
so they can be reapplied when the APIC driver is replaced.

The extra data structure is intentional as any new callback needs to be
also updated in the core code. This also prepares for static calls.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/apic.h |   28 ++++++++++++++++++++++++++++
 arch/x86/kernel/apic/init.c |   39 ++++++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/setup.c     |    2 ++
 3 files changed, 68 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -308,6 +308,23 @@ struct apic {
 	char	*name;
 };
 
+struct apic_override {
+	void	(*eoi)(void);
+	void	(*native_eoi)(void);
+	void	(*write)(u32 reg, u32 v);
+	u32	(*read)(u32 reg);
+	void	(*send_IPI)(int cpu, int vector);
+	void	(*send_IPI_mask)(const struct cpumask *mask, int vector);
+	void	(*send_IPI_mask_allbutself)(const struct cpumask *msk, int vec);
+	void	(*send_IPI_allbutself)(int vector);
+	void	(*send_IPI_all)(int vector);
+	void	(*send_IPI_self)(int vector);
+	u64	(*icr_read)(void);
+	void	(*icr_write)(u32 low, u32 high);
+	int	(*wakeup_secondary_cpu)(int apicid, unsigned long start_eip);
+	int	(*wakeup_secondary_cpu_64)(int apicid, unsigned long start_eip);
+};
+
 /*
  * Pointer to the local APIC driver in use on this system (there's
  * always just one such driver in use - the kernel decides via an
@@ -343,9 +360,17 @@ extern int lapic_can_unplug_cpu(void);
 #endif
 
 #ifdef CONFIG_X86_LOCAL_APIC
+extern struct apic_override __x86_apic_override;
 
+void __init apic_setup_apic_calls(void);
 void __init apic_install_driver(struct apic *driver);
 
+#define apic_update_callback(_callback, _fn) {					\
+		__x86_apic_override._callback = _fn;				\
+		apic->_callback = _fn;						\
+		pr_info("APIC: %s() replaced with %ps()\n", #_callback, _fn);	\
+}
+
 static inline u32 apic_read(u32 reg)
 {
 	return apic->read(reg);
@@ -405,6 +430,9 @@ static inline void apic_wait_icr_idle(vo
 static inline u32 safe_apic_wait_icr_idle(void) { return 0; }
 static inline void apic_set_eoi_cb(void (*eoi)(void)) {}
 static inline void apic_native_eoi(void) { WARN_ON_ONCE(1); }
+static inline void apic_setup_apic_calls(void) { }
+
+#define apic_update_callback(_callback, _fn) do { } while (0)
 
 #endif /* CONFIG_X86_LOCAL_APIC */
 
--- a/arch/x86/kernel/apic/init.c
+++ b/arch/x86/kernel/apic/init.c
@@ -5,6 +5,37 @@
 
 #include "local.h"
 
+/* The container for function call overrides */
+struct apic_override __x86_apic_override __initdata;
+
+#define apply_override(__cb)					\
+	if (__x86_apic_override.__cb)				\
+		apic->__cb = __x86_apic_override.__cb
+
+static __init void restore_override_callbacks(void)
+{
+	apply_override(eoi);
+	apply_override(native_eoi);
+	apply_override(write);
+	apply_override(read);
+	apply_override(send_IPI);
+	apply_override(send_IPI_mask);
+	apply_override(send_IPI_mask_allbutself);
+	apply_override(send_IPI_allbutself);
+	apply_override(send_IPI_all);
+	apply_override(send_IPI_self);
+	apply_override(icr_read);
+	apply_override(icr_write);
+	apply_override(wakeup_secondary_cpu);
+	apply_override(wakeup_secondary_cpu_64);
+}
+
+void __init apic_setup_apic_calls(void)
+{
+	/* Ensure that the default APIC has native_eoi populated */
+	apic->native_eoi = apic->eoi;
+}
+
 void __init apic_install_driver(struct apic *driver)
 {
 	if (apic == driver)
@@ -15,6 +46,13 @@ void __init apic_install_driver(struct a
 	if (IS_ENABLED(CONFIG_X86_X2APIC) && apic->x2apic_set_max_apicid)
 		apic->max_apic_id = x2apic_max_apicid;
 
+	/* Copy the original eoi() callback as KVM/HyperV might overwrite it */
+	if (!apic->native_eoi)
+		apic->native_eoi = apic->eoi;
+
+	/* Apply any already installed callback overrides */
+	restore_override_callbacks();
+
 	pr_info("Switched APIC routing to: %s\n", driver->name);
 }
 
@@ -41,7 +79,6 @@ void __init apic_set_eoi_cb(void (*eoi)(
 	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++) {
 		/* Should happen once for each apic */
 		WARN_ON((*drv)->eoi == eoi);
-		(*drv)->native_eoi = (*drv)->eoi;
 		(*drv)->eoi = eoi;
 	}
 }
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1017,6 +1017,8 @@ void __init setup_arch(char **cmdline_p)
 
 	x86_report_nx();
 
+	apic_setup_apic_calls();
+
 	if (acpi_mps_check()) {
 #ifdef CONFIG_X86_LOCAL_APIC
 		apic_is_disabled = true;

