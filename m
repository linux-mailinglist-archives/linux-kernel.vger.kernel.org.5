Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D8476B262
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbjHAKws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbjHAKwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:52:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B000A30D5
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:49:21 -0700 (PDT)
Message-ID: <20230801103818.269222348@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ughx6myInj7tBGUgtVNaK0CKBD3pdVmOGF8WRhhzTa4=;
        b=rHSLn+iroDKBNUKXtw9pPhYsqrmzkwUqLvllzlu3roeIo8eKUELgVIyowKOgpjhQ5ahzU2
        SiqULSqtGRWtA+NsHCojvMHt+mQR8qArElm+gcZJwEe326cPQs4vmEtPw/+E2D9ulakNln
        Erkfx1ebufHlpLZAwbZN4bZ4SbRpOL3KGen8flRCVefaPZqk9xDqHAeaP2vS7TuSydjGfH
        W7oMsCHJW9MaMihU4w5P/dpRy1BdvIZC2rLroPZ2ZFGJCSHyl1+/Crl1T5V6oZFixlLTNP
        S9nzhXY9qE4d+rYbycur740ZJ19zyugcho4QPp59BJSg5EUy9Aiqq6iiuewRtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ughx6myInj7tBGUgtVNaK0CKBD3pdVmOGF8WRhhzTa4=;
        b=QNQIcXi9BMi/myoVMoi004UXU0lGKYIRwNMIv8DSbTRhMtYL/aANXjaSlmBbiyCf6XA2bN
        1GbnopHshC91y3AQ==
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
Subject: [patch V3 57/60] x86/apic: Mark all hotpath APIC callback wrappers
 __always_inline
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:47:51 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no value for instrumentation to look at those wrappers and with the
upcoming conversion to static calls even less so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/apic.h |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -371,48 +371,48 @@ void __init apic_install_driver(struct a
 		pr_info("APIC: %s() replaced with %ps()\n", #_callback, _fn);	\
 }
 
-static inline u32 apic_read(u32 reg)
+static __always_inline u32 apic_read(u32 reg)
 {
 	return apic->read(reg);
 }
 
-static inline void apic_write(u32 reg, u32 val)
+static __always_inline void apic_write(u32 reg, u32 val)
 {
 	apic->write(reg, val);
 }
 
-static inline void apic_eoi(void)
+static __always_inline void apic_eoi(void)
 {
 	apic->eoi();
 }
 
-static inline void apic_native_eoi(void)
+static __always_inline void apic_native_eoi(void)
 {
 	apic->native_eoi();
 }
 
-static inline u64 apic_icr_read(void)
+static __always_inline u64 apic_icr_read(void)
 {
 	return apic->icr_read();
 }
 
-static inline void apic_icr_write(u32 low, u32 high)
+static __always_inline void apic_icr_write(u32 low, u32 high)
 {
 	apic->icr_write(low, high);
 }
 
-static inline void apic_wait_icr_idle(void)
+static __always_inline void apic_wait_icr_idle(void)
 {
 	if (apic->wait_icr_idle)
 		apic->wait_icr_idle();
 }
 
-static inline u32 safe_apic_wait_icr_idle(void)
+static __always_inline u32 safe_apic_wait_icr_idle(void)
 {
 	return apic->safe_wait_icr_idle ? apic->safe_wait_icr_idle() : 0;
 }
 
-static inline bool apic_id_valid(u32 apic_id)
+static __always_inline bool apic_id_valid(u32 apic_id)
 {
 	return apic_id <= apic->max_apic_id;
 }

