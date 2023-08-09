Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BC9776A2F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbjHIUg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbjHIUgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:36:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEF42109;
        Wed,  9 Aug 2023 13:36:09 -0700 (PDT)
Date:   Wed, 09 Aug 2023 20:36:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691613367;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=HfUWz6QDof0eaP1RS1dsvScAIJcevBHYPir4cDnEYrI=;
        b=I5Nl/C68h5GGy336T/7usjNgNUprSYJFcHTnCREzfk54UdQFcBiS5cuLs6LPcU0naV2DmZ
        eQrEvCXoKIdcU91s9LbFMExXrMadhiookMq26sTDSmKg6OaIFnGAqPerSvvTd5GIYxKE1+
        ewHLyiSbe0KX/EdngTuP/Mqu6FMHb+B/1ZBhTU1AlsL0KP9Di2d0O9jdgQgyzkJdV882cd
        8JlAl1gEJ0uNGumeDMWBjDcn3s9HFUTL3XX8J8VKf7694THjtvkgB7aACsav3FjZnik1MP
        DPfQrM19t/ouenc+ePe3cdddG+FGuk8nXzx4n33OQR8w7/CyV2kQ3qgCZcOZxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691613367;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=HfUWz6QDof0eaP1RS1dsvScAIJcevBHYPir4cDnEYrI=;
        b=zGarAqutFXghF+38msqlgLKt0fzRbsBe/ppMtTy1uE2eOJVVw4080HLiXmwu/tO+bpF0lO
        4YNBHu2vsYhyShAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Provide apic_update_callback()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169161336718.27769.12478895840101814238.tip-bot2@tip-bot2>
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

Commit-ID:     bef4f379e953af49a9bd81790954e78fcb264920
Gitweb:        https://git.kernel.org/tip/bef4f379e953af49a9bd81790954e78fcb264920
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:04:19 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 12:00:46 -07:00

x86/apic: Provide apic_update_callback()

There are already two variants of update mechanism for particular callbacks
and virtualization just writes into the data structure.

Provide an interface and use a shadow data structure to preserve callbacks
so they can be reapplied when the APIC driver is replaced.

The extra data structure is intentional as any new callback needs to be
also updated in the core code. This also prepares for static calls.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/include/asm/apic.h | 28 ++++++++++++++++++++++++++-
 arch/x86/kernel/apic/init.c | 39 +++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/setup.c     |  2 ++-
 3 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 90814ec..6e279c1 100644
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
@@ -405,6 +430,9 @@ static inline void apic_wait_icr_idle(void) { }
 static inline u32 safe_apic_wait_icr_idle(void) { return 0; }
 static inline void apic_set_eoi_cb(void (*eoi)(void)) {}
 static inline void apic_native_eoi(void) { WARN_ON_ONCE(1); }
+static inline void apic_setup_apic_calls(void) { }
+
+#define apic_update_callback(_callback, _fn) do { } while (0)
 
 #endif /* CONFIG_X86_LOCAL_APIC */
 
diff --git a/arch/x86/kernel/apic/init.c b/arch/x86/kernel/apic/init.c
index 25cf39b..dab3afa 100644
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
@@ -15,6 +46,13 @@ void __init apic_install_driver(struct apic *driver)
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
 
@@ -41,7 +79,6 @@ void __init apic_set_eoi_cb(void (*eoi)(void))
 	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++) {
 		/* Should happen once for each apic */
 		WARN_ON((*drv)->eoi == eoi);
-		(*drv)->native_eoi = (*drv)->eoi;
 		(*drv)->eoi = eoi;
 	}
 }
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index f83d02b..b9145a6 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1017,6 +1017,8 @@ void __init setup_arch(char **cmdline_p)
 
 	x86_report_nx();
 
+	apic_setup_apic_calls();
+
 	if (acpi_mps_check()) {
 #ifdef CONFIG_X86_LOCAL_APIC
 		apic_is_disabled = true;
