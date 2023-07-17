Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8177D757094
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjGQXhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjGQXgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:36:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5047171B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:36:07 -0700 (PDT)
Message-ID: <20230717223226.358014177@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=uX/kplLo5CTyEGcDpdLq/uLjlYQ837jWRls5Fa0d2bQ=;
        b=V2g8TK5/irCDXKjbQaXb1r7SKbrw79jOasZOrc22otmaawYm41oZ4SIYN0FoOb0YNp7rBT
        GBHawf+UV+/eGE0x/Ibnd426wPBM8PnMKgmDkWPpU1u0xd1pPNJJnmAFjJWudkI07Z1qBN
        AwfO+tH823Q4kD89cPbCZG3yWVHLDW8taIfeioZdloikGhfK9EaWh0KkpoHpqXVup82ZJT
        aSDoHi3jbBIsOeJt/WSyaMcX++jfPTHLJlXgfgJlcYk4kK8epMcgNwfT75FLfiSdDdTU5Z
        AipS3khCPFaeLx+j0Cd4sch+8CN00fp3FFf2ALcvZTEw6Zncv9Q3j43krlN9hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=uX/kplLo5CTyEGcDpdLq/uLjlYQ837jWRls5Fa0d2bQ=;
        b=n7YW14HMPXk/VX1uLMyjlSyd8+xVN0NXKSd1Rst1vDJXz9Qo+q06d7afU296MK6NMy4Wu/
        WedSjnxQNdt/fPDw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 55/58] x86/apic: Mark all hotpath APIC callback wrappers
 __always_inline
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:16:00 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no value for instrumentation to look at those wrappers and with the
upcoming conversion to static calls even less so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/apic.h |   34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -370,62 +370,62 @@ void __init apic_install_driver(struct a
 		pr_info("APIC::%s() replaced with %ps()\n", #_callback, _fn);	\
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
 
 #else /* CONFIG_X86_LOCAL_APIC */
 
-static inline u32 apic_read(u32 reg) { return 0; }
-static inline void apic_write(u32 reg, u32 val) { }
-static inline void apic_eoi(void) { }
-static inline u64 apic_icr_read(void) { return 0; }
-static inline void apic_icr_write(u32 low, u32 high) { }
-static inline void apic_wait_icr_idle(void) { }
-static inline u32 safe_apic_wait_icr_idle(void) { return 0; }
-static inline void apic_set_eoi(void (*eoi)(void)) {}
+static __always_inline u32 apic_read(u32 reg) { return 0; }
+static __always_inline void apic_write(u32 reg, u32 val) { }
+static __always_inline void apic_eoi(void) { }
+static __always_inline u64 apic_icr_read(void) { return 0; }
+static __always_inline void apic_icr_write(u32 low, u32 high) { }
+static __always_inline void apic_wait_icr_idle(void) { }
+static __always_inline u32 safe_apic_wait_icr_idle(void) { return 0; }
+static __always_inline void apic_set_eoi(void (*eoi)(void)) {}
 
 #endif /* CONFIG_X86_LOCAL_APIC */
 

