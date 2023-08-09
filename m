Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7537763DE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbjHIPef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbjHIPeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:34:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30102100;
        Wed,  9 Aug 2023 08:34:16 -0700 (PDT)
Date:   Wed, 09 Aug 2023 15:34:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691595255;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WmZc5ouId9UjNyGbd7Bbnaagn8dsX3E7rAiU6YFNTTY=;
        b=UOKuuAvT5dr6XUEBv/rrn5jomDnXHPKVhhNoOjFMtqYAB1i3IqOMfwzG9jS7uI8MTky/Ms
        gTpKLunIL/NMvXYfcfW3vb6eLwr5ilayue4Ww/DBAcecghRIflaBRcIJFLVUAbDQS29Wqa
        rbcAp1i0Pg+Nm8t8KRjSnKvB7Axq17xY3ry0v82XdtE4Vy1tk5o//u9kZKZ+OYEMCa6bNJ
        JjTHKYG0WI6W90hI18LlCDh4z1VwVsryC+XDr+0Cpwdv6x11C7Ck5BL7sTMLuQJ42DcN2a
        jjQ0uzWo96Cwmpi1monaPIaadKTwAHWnZ2fW+LFiQUnqup9LhmXXOKb73tly7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691595255;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WmZc5ouId9UjNyGbd7Bbnaagn8dsX3E7rAiU6YFNTTY=;
        b=xn2qhbTHNugRmdPN9Ll7Ca6KKlRav7IXYylde6H+aJYqbVsLAIpFx9CGT7f89DkqEmP5JC
        pD1PjG7CEWWK5lAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Make some APIC init functions bool
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169159525491.27769.10225809299126599321.tip-bot2@tip-bot2>
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

Commit-ID:     b2f0f97b396baaac08b74ee3d2e6c49cbe70e664
Gitweb:        https://git.kernel.org/tip/b2f0f97b396baaac08b74ee3d2e6c49cbe70e664
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:48 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 08:10:11 -07:00

x86/apic: Make some APIC init functions bool

Quite some APIC init functions are pure boolean, but use the success = 0,
fail < 0 model. That's confusing as hell when reading through the code.

Convert them to boolean.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
