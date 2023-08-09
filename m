Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77ADA776842
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjHITNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjHITM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:12:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58F5210B;
        Wed,  9 Aug 2023 12:12:36 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:12:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691608345;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ZOOnlytwjdniYUrv8HLfKwwBshoQq0BLjDC3lVUi74U=;
        b=aM8go1BW0LBb2/TPETRHj/3sN/Az2fBDIIJ8NIg3mQvLg0XVSGLqIu9pZcV6e7Pf8hJpNo
        4SP0VjTB3vKcr2aNdax/pLjMTqMG9K2SzpqnNgMFXOsHLG7GhnS4VJ4f/v898WTgqHLj90
        /tmkacAKkrKW3yUSbdw3XaMiK/oa6Qqgin0tJQuNusINWBhuUpEWtMfDdXuIESh3uJ+c7j
        h+VBTBQFut0auN4ndodihoULfcuOKuid4rVFkIPPFJYgTGMQXXfl7lSKFzlTRkBSiRywal
        Gxh/qIKESVoSHQ7p1gbIyUmZnOaeCsS8VZRQn15B3o9Oxc4088wGy+4GuLxtKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691608345;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ZOOnlytwjdniYUrv8HLfKwwBshoQq0BLjDC3lVUi74U=;
        b=XnLhBDbIbJE2aj+MS6VHOZHIKmUfeWPrBbuEtpzn+pgJa8Q9Q6wUWTnI+KiT/8+GFi7ktY
        UatcB0R9hknw6KAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Make some APIC init functions bool
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169160834490.27769.7553485649731661081.tip-bot2@tip-bot2>
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

Commit-ID:     1751adedbd601d6a9da35de0c1e2592ac980fdfe
Gitweb:        https://git.kernel.org/tip/1751adedbd601d6a9da35de0c1e2592ac980fdfe
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:48 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:20 -07:00

x86/apic: Make some APIC init functions bool

Quite some APIC init functions are pure boolean, but use the success = 0,
fail < 0 model. That's confusing as hell when reading through the code.

Convert them to boolean.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/include/asm/apic.h  |  6 +++---
 arch/x86/kernel/apic/apic.c  | 36 +++++++++++++++++------------------
 arch/x86/kernel/devicetree.c |  2 +-
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 108fdc2..35d236b 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -135,12 +135,12 @@ extern void setup_secondary_APIC_clock(void);
 extern void lapic_update_tsc_freq(void);
 
 #ifdef CONFIG_X86_64
-static inline int apic_force_enable(unsigned long addr)
+static inline bool apic_force_enable(unsigned long addr)
 {
-	return -1;
+	return false;
 }
 #else
-extern int apic_force_enable(unsigned long addr);
+extern bool apic_force_enable(unsigned long addr);
 #endif
 
 extern void apic_ap_setup(void);
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 32275ca..d0f4cca 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2000,19 +2000,19 @@ void __init enable_IR_x2apic(void)
  * On AMD64 we trust the BIOS - if it says no APIC it is likely
  * not correctly set up (usually the APIC timer won't work etc.)
  */
-static int __init detect_init_APIC(void)
+static bool __init detect_init_APIC(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_APIC)) {
 		pr_info("No local APIC present\n");
-		return -1;
+		return false;
 	}
 
 	mp_lapic_addr = APIC_DEFAULT_PHYS_BASE;
-	return 0;
+	return true;
 }
 #else
 
-static int __init apic_verify(void)
+static bool __init apic_verify(void)
 {
 	u32 features, h, l;
 
@@ -2023,7 +2023,7 @@ static int __init apic_verify(void)
 	features = cpuid_edx(1);
 	if (!(features & (1 << X86_FEATURE_APIC))) {
 		pr_warn("Could not enable APIC!\n");
-		return -1;
+		return false;
 	}
 	set_cpu_cap(&boot_cpu_data, X86_FEATURE_APIC);
 	mp_lapic_addr = APIC_DEFAULT_PHYS_BASE;
@@ -2036,15 +2036,15 @@ static int __init apic_verify(void)
 	}
 
 	pr_info("Found and enabled local APIC!\n");
-	return 0;
+	return true;
 }
 
-int __init apic_force_enable(unsigned long addr)
+bool __init apic_force_enable(unsigned long addr)
 {
 	u32 h, l;
 
 	if (apic_is_disabled)
-		return -1;
+		return false;
 
 	/*
 	 * Some BIOSes disable the local APIC in the APIC_BASE
@@ -2067,11 +2067,11 @@ int __init apic_force_enable(unsigned long addr)
 /*
  * Detect and initialize APIC
  */
-static int __init detect_init_APIC(void)
+static bool __init detect_init_APIC(void)
 {
 	/* Disabled by kernel option? */
 	if (apic_is_disabled)
-		return -1;
+		return false;
 
 	switch (boot_cpu_data.x86_vendor) {
 	case X86_VENDOR_AMD:
@@ -2098,22 +2098,22 @@ static int __init detect_init_APIC(void)
 		if (!force_enable_local_apic) {
 			pr_info("Local APIC disabled by BIOS -- "
 				"you can enable it with \"lapic\"\n");
-			return -1;
+			return false;
 		}
-		if (apic_force_enable(APIC_DEFAULT_PHYS_BASE))
-			return -1;
+		if (!apic_force_enable(APIC_DEFAULT_PHYS_BASE))
+			return false;
 	} else {
-		if (apic_verify())
-			return -1;
+		if (!apic_verify())
+			return false;
 	}
 
 	apic_pm_activate();
 
-	return 0;
+	return true;
 
 no_apic:
 	pr_info("No local APIC present or hardware disabled\n");
-	return -1;
+	return false;
 }
 #endif
 
@@ -2129,7 +2129,7 @@ void __init init_apic_mappings(void)
 		return;
 
 	/* If no local APIC can be found return early */
-	if (!smp_found_config && detect_init_APIC()) {
+	if (!smp_found_config && !detect_init_APIC()) {
 		/* lets NOP'ify apic operations */
 		pr_info("APIC: disable apic facility\n");
 		apic_disable();
diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 8f94eb6..87d38f1 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -158,7 +158,7 @@ static void __init dtb_lapic_setup(void)
 	/* Did the boot loader setup the local APIC ? */
 	if (!boot_cpu_has(X86_FEATURE_APIC)) {
 		/* Try force enabling, which registers the APIC address */
-		if (apic_force_enable(lapic_addr))
+		if (!apic_force_enable(lapic_addr))
 			return;
 	} else {
 		register_lapic_address(lapic_addr);
