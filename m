Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F3876B25A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbjHAKv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbjHAKvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:51:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E148A49FC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:48:52 -0700 (PDT)
Message-ID: <20230801103818.375110055@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=sWz+PxcXcGjaPN9TPLjLOBXrJmVNdPDAcC06bIjErtY=;
        b=IXst4WTq0037h3F4gIwYb89FxxSwxTTgYJdBppm9eGJx2mAoV/wd4RzOIboBkXw0RpjJiA
        h8uXrMBoIChojdKOUf7pGzLSNtmRUM1FqgWxhbZR3OG9Kcbywol7oJVRuYk8ii267n7lEW
        zAdjXLsP5oKJhHBlaOHkjgdoZQHDS4KV/MrjbUL+d0hJBK+CtwCSMet1yrOzm905vyxKmP
        suy8Vqb2FqBCh+0f4YPPhXscdI555VluUyBRJjY50DS7tNh5F/nHNggN9Ab1xdZuhFiDOq
        7rZPJxk3YEIdJP2G9YNmKP4kQ0QwA+KOEuSP2jkOSPXZxW3z8giAZZD0A84oCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=sWz+PxcXcGjaPN9TPLjLOBXrJmVNdPDAcC06bIjErtY=;
        b=yeN1PUDbWrlCYxo5K5CQL6fJbXf/t5XS6jrSwyHjWlgi6TR68SHu0H04soUhHHNncQvaG+
        EgMbKQnfNsWYZCBw==
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
Subject: [patch V3 59/60] x86/apic: Provide static call infrastructure for
 APIC callbacks
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:47:54 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/apic.h |   21 +++++++++++++++++
 arch/x86/kernel/apic/init.c |   53 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_APIC_H
 
 #include <linux/cpumask.h>
+#include <linux/static_call.h>
 
 #include <asm/alternative.h>
 #include <asm/cpufeature.h>
@@ -368,9 +369,29 @@ void __init apic_install_driver(struct a
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
 
@@ -30,10 +58,34 @@ static __init void restore_override_call
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
@@ -52,6 +104,7 @@ void __init apic_install_driver(struct a
 
 	/* Apply any already installed callback overrides */
 	restore_override_callbacks();
+	update_static_calls();
 
 	pr_info("Switched APIC routing to: %s\n", driver->name);
 }

