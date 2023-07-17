Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F77D757077
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjGQXXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjGQXX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:23:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BCC10D1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:22:44 -0700 (PDT)
Message-ID: <20230717223226.538475803@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=lvMFdpWMYEl6iHAh9VQaIAf2jL32y7ajYh4Uo2YtOzA=;
        b=zP26Q09tzOOZnXWdUFGaMQFD74L+qpdu5/OQGvyYyiZlRQ5bUEwJc9a8Svzr0wS8GNpvbZ
        pn24Act9J/RMcTSkWXQtfsI8I+fnlIz8p8i+j0emei5GoLnUzr3k3AoMlqDF1HXGA/v18D
        vPIMEmawCFpThhaJjspLXUK5kI1WLzA8r2rEf27zychn1pucRO+gONlIWDKebkD+ZXfOmZ
        t91yZQOsWB6Tc0WFrSG4gp4oETKvug2OuN+JNbnKINIU4u4UByfZJ9461d5hjKjCf5B774
        79dlHcsLHI9mdvmMDcfWW0sbmQP7pJ/Ml/NdDhfqoH54tudnOutCc2zqtkkQcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=lvMFdpWMYEl6iHAh9VQaIAf2jL32y7ajYh4Uo2YtOzA=;
        b=7JEu7Jpz1sP45XzkyVnLD6yXyYOgSEsQ+LVyXwPbyLst41zW3d69yIstXz1C78ob3B91dy
        UZExU6MTiMrW32Cw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 58/58] x86/apic: Turn on static calls
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:16:05 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert all the APIC callback inline wrappers from apic->foo() to
static_call(apic_call_foo)(), except for the safe_wait_icr_idle() one which
is only used during SMP bringup when sending INIT/SIPI. That really can do
the conditional callback. The regular wait_icr_idle() matters as it is used
in irq_work_raise(), so X2APIC machines spare the conditional.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/apic.h |   27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -397,68 +397,67 @@ EXPORT_STATIC_CALL_TRAMP_GPL(apic_call_s
 
 static __always_inline u32 apic_read(u32 reg)
 {
-	return apic->read(reg);
+	return static_call(apic_call_read)(reg);
 }
 
 static __always_inline void apic_write(u32 reg, u32 val)
 {
-	apic->write(reg, val);
+	static_call(apic_call_write)(reg, val);
 }
 
 static __always_inline void apic_eoi(void)
 {
-	apic->eoi();
+	static_call(apic_call_eoi)();
 }
 
 static __always_inline void apic_native_eoi(void)
 {
-	apic->native_eoi();
+	static_call(apic_call_native_eoi)();
 }
 
 static __always_inline u64 apic_icr_read(void)
 {
-	return apic->icr_read();
+	return static_call(apic_call_icr_read)();
 }
 
 static __always_inline void apic_icr_write(u32 low, u32 high)
 {
-	apic->icr_write(low, high);
+	static_call(apic_call_icr_write)(low, high);
 }
 
 static __always_inline void __apic_send_IPI(int cpu, int vector)
 {
-	apic->send_IPI(cpu, vector);
+	static_call(apic_call_send_IPI)(cpu, vector);
 }
 
 static __always_inline void __apic_send_IPI_mask(const struct cpumask *mask, int vector)
 {
-	apic->send_IPI_mask(mask, vector);
+	static_call(apic_call_send_IPI_mask)(mask, vector);
 }
 
 static __always_inline void __apic_send_IPI_mask_allbutself(const struct cpumask *mask, int vector)
 {
-	apic->send_IPI_mask_allbutself(mask, vector);
+	static_call(apic_call_send_IPI_mask_allbutself)(mask, vector);
 }
 
 static __always_inline void __apic_send_IPI_allbutself(int vector)
 {
-	apic->send_IPI_allbutself(vector);
+	static_call(apic_call_send_IPI_allbutself)(vector);
 }
 
 static __always_inline void __apic_send_IPI_all(int vector)
 {
-	apic->send_IPI_all(vector);
+	static_call(apic_call_send_IPI_all)(vector);
 }
 
 static __always_inline void __apic_send_IPI_self(int vector)
 {
-	apic->send_IPI_self(vector);
+	static_call(apic_call_send_IPI_self)(vector);
 }
 
 static __always_inline void apic_wait_icr_idle(void)
 {
-	if (apic->wait_icr_idle)
-		apic->wait_icr_idle();
+	static_call_cond(apic_call_wait_icr_idle)();
 }
 
 static __always_inline u32 safe_apic_wait_icr_idle(void)

