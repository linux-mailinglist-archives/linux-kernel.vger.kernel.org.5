Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23A477269A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbjHGNws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbjHGNwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:52:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65C892
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:52:39 -0700 (PDT)
Message-ID: <20230807135026.583926152@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=d94K6TZuk9UQVnHU8hugmyHyNVbrMnQ9c00omcsE0/8=;
        b=XiJre2F21rkX+aipwOorw1II23Kx9Q/Ep5ull5Wq2PER54URIRU/SxCqdDgTa7Fz2y/HJh
        xeCTqjiW8rZpstGn8RzhpUpB4EF1zTifBCJY3S0JyyetIfe0MVCh6v/g36qwmlP6lfu4Z2
        PpNT9EtIPeFpKD+Ailz8K65+J6Yb7gTgcPu9JW1x18pEnHFeBQhx0BkmNHB1w6NUdGSJpi
        gnoGYXXiG2JzbgeuJVt8ihQeciirYjtM4+C0cmwivSmjDiDNS4MNtHhtQvoO5+X8jGlJoI
        yQn/hC0yD5vHA8mmW0HKhlLwIwu4O6j9kDxzyJ6uz8f1goMG5YEqQjy2s+mM0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=d94K6TZuk9UQVnHU8hugmyHyNVbrMnQ9c00omcsE0/8=;
        b=BtHqpGBLjlz56f4CRT9zVPQI+4sj0XHUiDA2V/EzODvrqkSqRK3YFjvAI9OxJeW4A7xg2/
        Ndk3bg2kbYRRGTAw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
Subject: [patch 03/53] x86/platform/ce4100: Dont override
 x86_init.mpparse.setup_ioapic_ids
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:52:38 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point to do that. The ATOMs have an XAPIC for which this
function is a pointless exercise.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Shevchenko <andy@infradead.org>
---
 arch/x86/include/asm/io_apic.h    |    1 -
 arch/x86/kernel/apic/io_apic.c    |    2 +-
 arch/x86/platform/ce4100/ce4100.c |    1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

--- a/arch/x86/include/asm/io_apic.h
+++ b/arch/x86/include/asm/io_apic.h
@@ -140,7 +140,6 @@ extern void mask_ioapic_entries(void);
 extern int restore_ioapic_entries(void);
 
 extern void setup_ioapic_ids_from_mpc(void);
-extern void setup_ioapic_ids_from_mpc_nocheck(void);
 
 extern int mp_find_ioapic(u32 gsi);
 extern int mp_find_ioapic_pin(int ioapic, u32 gsi);
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1458,7 +1458,7 @@ void restore_boot_irq_mode(void)
  *
  * by Matt Domsch <Matt_Domsch@dell.com>  Tue Dec 21 12:25:05 CST 1999
  */
-void __init setup_ioapic_ids_from_mpc_nocheck(void)
+static void __init setup_ioapic_ids_from_mpc_nocheck(void)
 {
 	union IO_APIC_reg_00 reg_00;
 	physid_mask_t phys_id_present_map;
--- a/arch/x86/platform/ce4100/ce4100.c
+++ b/arch/x86/platform/ce4100/ce4100.c
@@ -139,7 +139,6 @@ void __init x86_ce4100_early_setup(void)
 	x86_init.resources.probe_roms = x86_init_noop;
 	x86_init.mpparse.get_smp_config = x86_init_uint_noop;
 	x86_init.mpparse.find_smp_config = x86_init_noop;
-	x86_init.mpparse.setup_ioapic_ids = setup_ioapic_ids_from_mpc_nocheck;
 	x86_init.pci.init = ce4100_pci_init;
 	x86_init.pci.init_irq = sdv_pci_init;
 

