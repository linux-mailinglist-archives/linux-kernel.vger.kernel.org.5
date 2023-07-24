Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AD075F871
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjGXNe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjGXNec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:34:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79B51BF1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:34:10 -0700 (PDT)
Message-ID: <20230724132045.434855520@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690205648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=EJkw3wmb0xhqWNonEGYegw1kbsCG+7tuReZsQsrarng=;
        b=Kyiv3T1joglVmzf6J56J1lTfa+Jalt2vb2QpjzFy/28THUaEiuQVpcgvUdLUiAV8p4MWhE
        bH4GgH0YGoO6nUuiXr3vhkv5Mu0PX+orFE+7gslHVsUkNr87zS37uzoydhgEPhIA3HaiRB
        GCyg3+jVZSOh0bYoKYGK6gCblPwSG/es5vv7IyMDGlWovMOM3/6u76NoNUCdcOvZrNQ3b/
        JbPGHRsTL3GaUl5DAx5YXQY10kdh7vastronQsdO4K2FDADbaNjjco0SGMB0SEe2wROZOC
        C0I92gH8usC92EJTjHYtFcWTq17KKBizs5s9xKHrsVXRO5UFgKrumBScIO5Q6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690205648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=EJkw3wmb0xhqWNonEGYegw1kbsCG+7tuReZsQsrarng=;
        b=YAdf/YGLep1yAK7cFLYNYVlMFi9OoBc3sTKs1TjW/NIly0HoutTMn0Y+8cnEao5C4hn3N3
        Pi3WaC7HU5wg5AAw==
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
Subject: [patch V2 14/58] x86/apic: Split register_apic_address()
References: <20230724131206.500814398@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 15:34:08 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split the fixmap setup out of register_lapic_address() and reuse it when
the X2APIC is disabled during setup.

This avoids that the APIC ID is registered twice.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/apic/apic.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1852,6 +1852,8 @@ void x2apic_setup(void)
 	__x2apic_enable();
 }
 
+static __init void apic_set_fixmap(void);
+
 static __init void x2apic_disable(void)
 {
 	u32 x2apic_id, state = x2apic_state;
@@ -1872,7 +1874,7 @@ static __init void x2apic_disable(void)
 	}
 
 	__x2apic_disable();
-	register_lapic_address(mp_lapic_addr);
+	apic_set_fixmap();
 }
 
 static __init void x2apic_enable(void)
@@ -2145,17 +2147,21 @@ void __init init_apic_mappings(void)
 	}
 }
 
+static __init void apic_set_fixmap(void)
+{
+	set_fixmap_nocache(FIX_APIC_BASE, mp_lapic_addr);
+	apic_mmio_base = APIC_BASE;
+	apic_printk(APIC_VERBOSE, "mapped APIC to %16lx (%16lx)\n",
+		    apic_mmio_base, mp_lapic_addr);
+	apic_read_boot_cpu_id(false);
+}
+
 void __init register_lapic_address(unsigned long address)
 {
 	mp_lapic_addr = address;
 
-	if (x2apic_mode)
-		return;
-
-	set_fixmap_nocache(FIX_APIC_BASE, address);
-	apic_mmio_base = APIC_BASE;
-	apic_printk(APIC_VERBOSE, "mapped APIC to %16lx (%16lx)\n", APIC_BASE, address);
-	apic_read_boot_cpu_id(false);
+	if (!x2apic_mode)
+		apic_set_fixmap();
 }
 
 /*

