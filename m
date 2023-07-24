Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8AA75F89A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjGXNjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjGXNis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:38:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD4A10FE
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:37:04 -0700 (PDT)
Message-ID: <20230724132048.008763662@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690205725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=4thjqk06PAC51pOMOTPF8ETngeGfrVOo3TNMYdEenIA=;
        b=QNqojH3yNGauj6S7jtVUTgfJIY4hOseZ1pizUb25/YRuFX4otRsjkWDPtuY1QKbcJkSLBD
        2XD2bJvdAWarJmifj9IDwWhRxNG7wcEQNx88/58d9NF1JuHlt4UevfZL1ByTBsBHcp1kPq
        kXCHEPXBk5IUL4VyvjkfZ0vlurst+nHAeGhIdFx06TFRXNnrAqt8q0GSnOWStRsRQ5B8q4
        /FLHCJes/y5UDcMIjbusZk1cMmel6qTKshOuYA/ZSWTM/yIA9rx0Z352Ue9LBdiy+7HSsu
        S2wfBJo3ASeQNbJUHxQYcFPOuvB7gi8V89Z6/f/c2ptjiH60bkNRzIStChS1VQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690205725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=4thjqk06PAC51pOMOTPF8ETngeGfrVOo3TNMYdEenIA=;
        b=8QoYiXFcmJJLbG4UzxIoYsSbQhp0iHF0cun7+IpTntZ8Zdhh7X3AJmLJ/I0CUdfEkWmxXH
        tKlV5XGYdndZ6BCg==
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
Subject: [patch V2 58/58] x86/apic: Turn on static calls
References: <20230724131206.500814398@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 15:35:24 +0200 (CEST)
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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/apic.h |   27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -394,68 +394,67 @@ DECLARE_APIC_CALL(write);
 
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
+	static_call_mod(apic_call_send_IPI_mask)(mask, vector);
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
+	static_call_mod(apic_call_send_IPI_self)(vector);
 }
 
 static __always_inline void apic_wait_icr_idle(void)
 {
-	if (apic->wait_icr_idle)
-		apic->wait_icr_idle();
+	static_call_cond(apic_call_wait_icr_idle)();
 }
 
 static __always_inline u32 safe_apic_wait_icr_idle(void)

