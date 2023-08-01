Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E347D76B233
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbjHAKru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbjHAKrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:47:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F9BE5C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:47:00 -0700 (PDT)
Message-ID: <20230801103815.927989749@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=EJkw3wmb0xhqWNonEGYegw1kbsCG+7tuReZsQsrarng=;
        b=EDNg7MUMxkWgPHgZUAro7549ueqK237B6jax7erstsq6P9g2AiA9vyAEBQvxt4IbNGpNTC
        3Vc1Wb1LMRYQMlGOu5zvWHvY54yK0W8MXOjD3tWaQk1gfAI5AsWBXOWwbREouXU4uKiLf3
        /YLaEqki/y0PKMFhskgcy9l/tyd/UybtjhuUvF7r2kn8zMwPdpl8ZCDF04eD7Rg3BfzjrU
        jVoLkLhHOBI5Bek5J88We4zFEcx7RK9vxb48sHFuc+vF8gdnDdg3fzblqPK8bR8VUztuyE
        0W9l69TWclesYL4z56evQZaAeSDIURaKkeAmqWoZIQs9Xs9nQJYpY9RFNmUjtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=EJkw3wmb0xhqWNonEGYegw1kbsCG+7tuReZsQsrarng=;
        b=u8G9h4g0Ze769QRkXmduC9mOPnQO93TsMo8Tu7hEaveDB5G9gNuqxTxYogShNgfhELF6Yl
        e5dkbXlT+zKt4FDg==
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
Subject: [patch V3 14/60] x86/apic: Split register_apic_address()
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:46:58 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
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

