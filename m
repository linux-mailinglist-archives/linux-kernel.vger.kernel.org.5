Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD5775F8A2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjGXNjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjGXNig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:38:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3623F10D5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:36:55 -0700 (PDT)
Message-ID: <20230724132047.837772527@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690205720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ughx6myInj7tBGUgtVNaK0CKBD3pdVmOGF8WRhhzTa4=;
        b=kwoiOuDAovdAN5YiiqAECbj6LLitpjSJP+TZ+3qeF4Bl0Q4kNBW8ZOGZ6vmO0QnEH5yhgs
        ZldHloRckXQgBf9hQWCR493aunpVDGjOmDFOV3uQS9ykP1QdgQ5BIgllzb3ZcaPPO1RDpl
        SOi/zlRzJIDAR4IH4NVv6DCIsAG4h9YU+RMaVMNjsKF31fjZWohtGY6E/KHpjfnpXpip26
        9bfKdl5PcHWPNHIRf32md5tNpRnZQAdm+IOGrdS3QlRmmiRSMheq1FPYpPvJW6cmyShcJ9
        q5gkkYRsdstEX72ASXepqBQCj6l+U977gYTSDIdU4pmYJUw9qgAWw7uIsR9kqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690205720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ughx6myInj7tBGUgtVNaK0CKBD3pdVmOGF8WRhhzTa4=;
        b=2WL7HNmn/6HgtJssUiNXv9sezZpnoJgvv1UvWVS3rp+2602W790X3X0MZYw1ym0th1zxaR
        Jc9ma375Z2A2EkDg==
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
Subject: [patch V2 55/58] x86/apic: Mark all hotpath APIC callback wrappers
 __always_inline
References: <20230724131206.500814398@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 15:35:19 +0200 (CEST)
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

