Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BAD757097
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjGQXhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjGQXg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:36:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72AA171C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:36:07 -0700 (PDT)
Message-ID: <20230717223226.118922473@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=SE1iSqYJ4ehwEamqhZ1Qn1Xh1qrFRO76iVIsUZ/pjC8=;
        b=r9CDm/xw+hI5tPivegSVDw2QhU4sENJsdZjGHyVr2s0woGUJ7h5Kl3iPBR9ksvCHNV+j63
        JejyxjeVzibJQbwhS8x2/GWk0Sdkl74tUMa+l+lYxuhgxXuzCSjOqTnAhkCOF9VHgOLg33
        LnRutsQEJEpwu1V3EHWTvmyWHJTo5a/B+BI1QR08X1GhiNGME3Z2uFMQvIo8SqfvH/v1Fi
        RcHIE0h24hqvG88KP8MmiSomsz3t+xV1Cf0kJdW7NLDE8okV9VwXT12lXuR+i1pY6l7CKx
        6dJfSSKOIQ9qAcV27Aqybp65znOyEfMn2q6QIWkDgbwc61yGzqoFe5cXyZoqGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=SE1iSqYJ4ehwEamqhZ1Qn1Xh1qrFRO76iVIsUZ/pjC8=;
        b=09GVELt/GpTAFjbYuMVdaAmm3ybHo2iSKr3KLK11c+j2xxCZJh+c8ziFYaC44xOt7Qb6GJ
        JWYDzE0WRZG3R0CA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 51/58] x86/apic: Provide apic_update_callback()
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:15:54 +0200 (CEST)
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
---
 arch/x86/include/asm/apic.h |   25 +++++++++++++++++++++++++
 arch/x86/kernel/apic/init.c |   39 ++++++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/setup.c     |    2 ++
 3 files changed, 65 insertions(+), 1 deletion(-)

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
+		pr_info("APIC::%s() replaced with %ps()\n", #_callback, _fn);	\
+}
+
 static inline u32 apic_read(u32 reg)
 {
 	return apic->read(reg);
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
@@ -1018,6 +1018,8 @@ void __init setup_arch(char **cmdline_p)
 
 	x86_report_nx();
 
+	apic_setup_apic_calls();
+
 	if (acpi_mps_check()) {
 #ifdef CONFIG_X86_LOCAL_APIC
 		apic_is_disabled = true;

