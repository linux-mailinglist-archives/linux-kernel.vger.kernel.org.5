Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B370376B25B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbjHAKwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbjHAKvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:51:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C212B49FF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:48:54 -0700 (PDT)
Message-ID: <20230801103818.426750252@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=4thjqk06PAC51pOMOTPF8ETngeGfrVOo3TNMYdEenIA=;
        b=hYq2NTJtqwAScfWO5/gnhubO+QfkSxyd+M/MkH18g+s6QzqQGLTr5NHI0VHPb5aCP48OHg
        PpFQ8uBWK69rIEQUX9eEzC+eLRpzJVjLEBImVvvEQ7v1znmeLMMmRoL+HBZ7VfYabF8IHW
        d/yZJvuNJoGMSpysSpkj5wFNo9pruXInHmrCKN9uNsehrbrRWHHpoqTvwXP4KgS5Vvp0Ph
        TiqYD2eADMpQWdWOSsXmFnkTZJ771S/W3bC6akAMIpwLLpxVdXLODTabWDHBGoKGjADFm/
        TqNLXZ6uAIYiJNdr5payrEJHQebxL2Zz0E1WconNHVWwdkhAe9oSo+fSAKunmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=4thjqk06PAC51pOMOTPF8ETngeGfrVOo3TNMYdEenIA=;
        b=QUEU8Xbzi99gYLvCQ3CQp5znOVPD5tJCENMJ/3H3hk/jTPMYFYqu2vwt8AKRepk5KCjcaC
        Uu1eIqlbQyhCFLDA==
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
Subject: [patch V3 60/60] x86/apic: Turn on static calls
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:47:55 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
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

