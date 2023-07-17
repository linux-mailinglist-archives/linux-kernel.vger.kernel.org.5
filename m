Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C69757075
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjGQXVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjGQXVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:21:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880A51985
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:21:06 -0700 (PDT)
Message-ID: <20230717223226.476875329@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=uvvFxpQ0CI+6SWZBIuqun6zkxQpCJ5cWHxgeYGNpJp4=;
        b=R7XXJFQedNE1ITW18jUJikCpSy2EgGM78+g7kuY4J0NjIBXiFLx9LG13GlCoP9aifrsJMh
        CkHjg1CL3GAAgS3MmlJwjnONKAxcs+AHjux4Ml2ZebTzy8UdjmoBVBqFH7/ZYm+qb58WAo
        JezrWWHQrlRDlazcIDxlruB2H4vUTLNxqWjaFf/Mr6SESYel0J229UdBhMXcR3VONNNb77
        laMAJV5i92KoX4GLlbS13ZUzyP8DkrdFbp8Isq1LJ6Ov2rrLXcLfz/zYlsToU0XVFhep11
        mWSU9XiaM43zP5Ues8OyNzyMHGU9mmEKVZcamIsrzMwGxZTuVwnUx3lihvDhjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=uvvFxpQ0CI+6SWZBIuqun6zkxQpCJ5cWHxgeYGNpJp4=;
        b=St1HOkoMMFZWekCyT4k0WO5nKepjmvc+lUlUo1dPEnSWCYqOwWh1wMnaOMExWfWVsBY2uT
        D29BEcM7++KDrgCQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 57/58] x86/apic: Provide static call infrastructure for APIC callbacks
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:16:03 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
---
 arch/x86/include/asm/apic.h |   21 +++++++++++++++++++
 arch/x86/kernel/apic/init.c |   47 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

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
+		static_call_update(apic_call_##_callback, _fn);		\
 		pr_info("APIC::%s() replaced with %ps()\n", #_callback, _fn);	\
 }
 
+#define DECLARE_APIC_CALL(__cb)						\
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
@@ -5,6 +5,28 @@
 
 #include "local.h"
 
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
 
@@ -30,10 +52,34 @@ static __init void restore_override_call
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
@@ -52,6 +98,7 @@ void __init apic_install_driver(struct a
 
 	/* Apply any already installed callback overrides */
 	restore_override_callbacks();
+	update_static_calls();
 
 	pr_info("Switched APIC routing to: %s\n", driver->name);
 }

