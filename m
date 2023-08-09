Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EDB776A20
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbjHIUgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbjHIUgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:36:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62398210D;
        Wed,  9 Aug 2023 13:36:05 -0700 (PDT)
Date:   Wed, 09 Aug 2023 20:36:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691613364;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=YMHRE6vpczkT2y70DcYjQV5Ow6Pn3URx8WJOxHSyjYk=;
        b=GM0vEt6l7c4AMnlWfSJf95/+inYI01n1OSXGMLXZQga8mmKKO5+12A1BeFJrgXCi1SkO1A
        LnXE+/2h6eBCrdjKtKQFX25V82/lnnIjd2G3HWg2XgnY4TKHzhLRXNzBL6uT7lTYAHChI3
        x9K8utFc8TWZP2VmEKli15teaE+LOD++6beCcpY04L1jgDYZgdQ63cterNthaMJRWmzVt7
        NK0Qk0x4fuqfuG5zcfFhfvq4BYBnAaCqm1F3jmcB5mdg0P7N9kmLQKdowPo9rz/LoRe/Uy
        QDZJGeZrQKPRFdRIvIISrR70teEUAvtmjdjbFgloUuF7KHpGo6P4Knrvz1rxvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691613364;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=YMHRE6vpczkT2y70DcYjQV5Ow6Pn3URx8WJOxHSyjYk=;
        b=e5hZEsdE6yhq9K+aUFqDUzGjxALbTJUpKOwVVe1FJ/44YMJCxPEOWI+cqureZ1Hspgo1+A
        qGB60dhTRJvzOLCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Provide static call infrastructure for APIC
 callbacks
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169161336347.27769.10345804539414758133.tip-bot2@tip-bot2>
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

Commit-ID:     3b7c27e6789911359867a9e8d3d7889fc94a3d55
Gitweb:        https://git.kernel.org/tip/3b7c27e6789911359867a9e8d3d7889fc94a3d55
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:04:23 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 12:00:55 -07:00

x86/apic: Provide static call infrastructure for APIC callbacks

Declare and define the static calls for the hotpath APIC callbacks. Note
this deliberately uses STATIC_CALL_NULL() because otherwise it would be
required to have the definitions in the 32bit and the 64bit default APIC
implementations and it's hard to keep the calls in sync. The other option
would be to have stub functions for each callback type. Not pretty either

So the NULL capable calls are used and filled in during early boot after
the static key infrastructure has been initialized. The calls will be
static_call() except for the wait_irc_idle() callback which is valid to be
NULL for X2APIC systems.

Update the calls when a new APIC driver is installed and when a callback
override is invoked.

Export the trampolines for the two calls which are used in KVM and MCE
error inject modules.

Test the setup and let the next step convert the inline wrappers to make it
effective.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/include/asm/apic.h | 21 ++++++++++++++-
 arch/x86/kernel/apic/init.c | 53 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 74 insertions(+)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 62471e2..ddafd14 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_APIC_H
 
 #include <linux/cpumask.h>
+#include <linux/static_call.h>
 
 #include <asm/alternative.h>
 #include <asm/cpufeature.h>
@@ -368,9 +369,29 @@ void __init apic_install_driver(struct apic *driver);
 #define apic_update_callback(_callback, _fn) {					\
 		__x86_apic_override._callback = _fn;				\
 		apic->_callback = _fn;						\
+		static_call_update(apic_call_##_callback, _fn);			\
 		pr_info("APIC: %s() replaced with %ps()\n", #_callback, _fn);	\
 }
 
+#define DECLARE_APIC_CALL(__cb)							\
+	DECLARE_STATIC_CALL(apic_call_##__cb, *apic->__cb)
+
+DECLARE_APIC_CALL(eoi);
+DECLARE_APIC_CALL(native_eoi);
+DECLARE_APIC_CALL(icr_read);
+DECLARE_APIC_CALL(icr_write);
+DECLARE_APIC_CALL(read);
+DECLARE_APIC_CALL(send_IPI);
+DECLARE_APIC_CALL(send_IPI_mask);
+DECLARE_APIC_CALL(send_IPI_mask_allbutself);
+DECLARE_APIC_CALL(send_IPI_allbutself);
+DECLARE_APIC_CALL(send_IPI_all);
+DECLARE_APIC_CALL(send_IPI_self);
+DECLARE_APIC_CALL(wait_icr_idle);
+DECLARE_APIC_CALL(wakeup_secondary_cpu);
+DECLARE_APIC_CALL(wakeup_secondary_cpu_64);
+DECLARE_APIC_CALL(write);
+
 static __always_inline u32 apic_read(u32 reg)
 {
 	return apic->read(reg);
diff --git a/arch/x86/kernel/apic/init.c b/arch/x86/kernel/apic/init.c
index d7f4aca..821e2e5 100644
--- a/arch/x86/kernel/apic/init.c
+++ b/arch/x86/kernel/apic/init.c
@@ -5,6 +5,34 @@
 
 #include "local.h"
 
+/*
+ * Use DEFINE_STATIC_CALL_NULL() to avoid having to provide stub functions
+ * for each callback. The callbacks are setup during boot and all except
+ * wait_icr_idle() must be initialized before usage. The IPI wrappers
+ * use static_call() and not static_call_cond() to catch any fails.
+ */
+#define DEFINE_APIC_CALL(__cb)						\
+	DEFINE_STATIC_CALL_NULL(apic_call_##__cb, *apic->__cb)
+
+DEFINE_APIC_CALL(eoi);
+DEFINE_APIC_CALL(native_eoi);
+DEFINE_APIC_CALL(icr_read);
+DEFINE_APIC_CALL(icr_write);
+DEFINE_APIC_CALL(read);
+DEFINE_APIC_CALL(send_IPI);
+DEFINE_APIC_CALL(send_IPI_mask);
+DEFINE_APIC_CALL(send_IPI_mask_allbutself);
+DEFINE_APIC_CALL(send_IPI_allbutself);
+DEFINE_APIC_CALL(send_IPI_all);
+DEFINE_APIC_CALL(send_IPI_self);
+DEFINE_APIC_CALL(wait_icr_idle);
+DEFINE_APIC_CALL(wakeup_secondary_cpu);
+DEFINE_APIC_CALL(wakeup_secondary_cpu_64);
+DEFINE_APIC_CALL(write);
+
+EXPORT_STATIC_CALL_TRAMP_GPL(apic_call_send_IPI_mask);
+EXPORT_STATIC_CALL_TRAMP_GPL(apic_call_send_IPI_self);
+
 /* The container for function call overrides */
 struct apic_override __x86_apic_override __initdata;
 
@@ -30,10 +58,34 @@ static __init void restore_override_callbacks(void)
 	apply_override(wakeup_secondary_cpu_64);
 }
 
+#define update_call(__cb)					\
+	static_call_update(apic_call_##__cb, *apic->__cb)
+
+static __init void update_static_calls(void)
+{
+	update_call(eoi);
+	update_call(native_eoi);
+	update_call(write);
+	update_call(read);
+	update_call(send_IPI);
+	update_call(send_IPI_mask);
+	update_call(send_IPI_mask_allbutself);
+	update_call(send_IPI_allbutself);
+	update_call(send_IPI_all);
+	update_call(send_IPI_self);
+	update_call(icr_read);
+	update_call(icr_write);
+	update_call(wait_icr_idle);
+	update_call(wakeup_secondary_cpu);
+	update_call(wakeup_secondary_cpu_64);
+}
+
 void __init apic_setup_apic_calls(void)
 {
 	/* Ensure that the default APIC has native_eoi populated */
 	apic->native_eoi = apic->eoi;
+	update_static_calls();
+	pr_info("Static calls initialized\n");
 }
 
 void __init apic_install_driver(struct apic *driver)
@@ -52,6 +104,7 @@ void __init apic_install_driver(struct apic *driver)
 
 	/* Apply any already installed callback overrides */
 	restore_override_callbacks();
+	update_static_calls();
 
 	pr_info("Switched APIC routing to: %s\n", driver->name);
 }
