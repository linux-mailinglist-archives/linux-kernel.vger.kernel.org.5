Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5928D75F877
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjGXNfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjGXNe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:34:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDB110E0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:34:31 -0700 (PDT)
Message-ID: <20230724132045.734417851@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690205657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=puds9uet7raznuk9F0PAVBH9TUSCPzyaOfXQkH8xFMc=;
        b=Ma7S2W6YsGUNRlynq2m6LcyDflsz0YgJZgpNL5x4ZWKRFccuyLqjiImqRwxe0HiiSv6EIH
        e2pYUmo6DcDAM0bFq/htjv1gtvWUF5pK9LPZQIJ9kwmOhxXrOv88FhtEftRUM/zEofUSd1
        fOpTz1LU8MvqThlYm5xVW3vbJqf4CGuNX7vXaICd6WqC94NaxCgyb4oEYFbZyC4V34v7Q2
        UNoqqO6bZJly5BgSM8ZtdUhbKi4OyEXz1eFHN9Im/Vzei2oixrI+C7mr941kfGjUPSpxGs
        ur8EZxJ5agTo37B/FEgc0khiU9UaKOXAkzrefJMSoOxA6PwsNjmU18gQ1Z93Sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690205657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=puds9uet7raznuk9F0PAVBH9TUSCPzyaOfXQkH8xFMc=;
        b=7qu7rbCVxICsTyxYNn+Lv2EG63SEVqJl7O6gSGmK8mrLfSYMo9AmBP3pYLfYlUfxI8NcPx
        n81cQJF86Mp3W1DQ==
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
Subject: [patch V2 19/58] x86/apic: Get rid of apic_phys
References: <20230724131206.500814398@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 15:34:16 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 

