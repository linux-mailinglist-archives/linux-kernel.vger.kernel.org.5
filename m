Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BDC76B23B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbjHAKsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbjHAKrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:47:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2180B269E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:47:08 -0700 (PDT)
Message-ID: <20230801103816.253785465@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=puds9uet7raznuk9F0PAVBH9TUSCPzyaOfXQkH8xFMc=;
        b=zQUyNqUFAxgHnbu8wVCjGcw8XCW3zsRBB00g1c2WbIRh+K1CksaMxQlkh8P2Jgc6CJk+bz
        zLsSva4isIU0JzeP3EUNr6ZzQ7+FB3tXXqHEsBmFI2fkxxdbD6J5WxnLBcVZTDoSDzCByg
        QJEDO81JQTqc8U0XwuDbdJXhuqem8ueCPpLIKANvkng0OsUSNTFcjRYrtT12q8Gn023yi8
        2R3nWL1c/fNwgGPcMLNQqUAX+reOJajNvIXt29PVb1Wke71dII6qBcJeE6pG3z8CsjAlM2
        O2gO7ettBgvstJdF6jCf7jAsuYLx71glpVxomUO7KgtngyCcs8K6707jdt8ucg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=puds9uet7raznuk9F0PAVBH9TUSCPzyaOfXQkH8xFMc=;
        b=mK7ip4WNvKKu8E0WEfammoLSay4eNdWuMt3afkXHg3umb5e2QbAk+vMfkkDNpFvuTsAr0R
        DI0LnVhHCKxd2HDg==
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
Subject: [patch V3 20/60] x86/apic: Get rid of apic_phys
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:47:05 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need for an extra variable to find out whether the APIC has been mapped
or is accessible (X2APIC mode).

Provide an inline for this and check apic_mmio_base which is only set when
the local APIC has been mapped.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/apic/apic.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -99,6 +99,11 @@ static bool virt_ext_dest_id __ro_after_
 /* For parallel bootup. */
 unsigned long apic_mmio_base __ro_after_init;
 
+static inline bool apic_accessible(void)
+{
+	return x2apic_mode || apic_mmio_base;
+}
+
 /*
  * Map cpu index to physical APIC ID
  */
@@ -199,8 +204,6 @@ unsigned int lapic_timer_period = 0;
 
 static void apic_pm_activate(void);
 
-static unsigned long apic_phys __ro_after_init;
-
 /*
  * Get the LAPIC version
  */
@@ -1127,8 +1130,7 @@ void clear_local_APIC(void)
 	int maxlvt;
 	u32 v;
 
-	/* APIC hasn't been mapped yet */
-	if (!x2apic_mode && !apic_phys)
+	if (!apic_accessible())
 		return;
 
 	maxlvt = lapic_get_maxlvt();
@@ -1218,8 +1220,7 @@ void apic_soft_disable(void)
  */
 void disable_local_APIC(void)
 {
-	/* APIC hasn't been mapped yet */
-	if (!x2apic_mode && !apic_phys)
+	if (!apic_accessible())
 		return;
 
 	apic_soft_disable();
@@ -2142,7 +2143,7 @@ void __init init_apic_mappings(void)
 static __init void apic_set_fixmap(void)
 {
 	set_fixmap_nocache(FIX_APIC_BASE, mp_lapic_addr);
-	apic_phys = apic_mmio_base = APIC_BASE;
+	apic_mmio_base = APIC_BASE;
 	apic_printk(APIC_VERBOSE, "mapped APIC to %16lx (%16lx)\n",
 		    apic_mmio_base, mp_lapic_addr);
 	apic_read_boot_cpu_id(false);
@@ -2896,11 +2897,11 @@ early_param("apic", apic_set_verbosity);
 
 static int __init lapic_insert_resource(void)
 {
-	if (!apic_phys)
+	if (!apic_mmio_base)
 		return -1;
 
 	/* Put local APIC into the resource map. */
-	lapic_resource.start = apic_phys;
+	lapic_resource.start = apic_mmio_base;
 	lapic_resource.end = lapic_resource.start + PAGE_SIZE - 1;
 	insert_resource(&iomem_resource, &lapic_resource);
 

