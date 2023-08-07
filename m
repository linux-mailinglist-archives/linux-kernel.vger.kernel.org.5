Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C8B7726A5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbjHGNxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbjHGNxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:53:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC2C1998
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:52:59 -0700 (PDT)
Message-ID: <20230807135027.220542701@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=i7sHYpcfJ8EKrCzslt2cAc24NWY6qek5394P5PZEbDQ=;
        b=xAQ++Jeb+Bws6TZKoZprgVFN41qjVqyRoZrxNcbKYSE7HCHUH3izQG3H37/Ne7AE4sZnJf
        4Ji1ddnHpxaq3LxwaSyZ6oVbxDwjLkLbot99d6K/QnxIFeJ3yjKCFcBpZrRd6TJEKkWIyH
        LnHp9b5RDo4O/tfbeYI0rqpkZ7noKLrNV66xMHwBZdSmy5Dmz0xEnWtRQekpptE+kuF8p1
        i5C5+5ZQilAsSEEJl0ZJnM9pIQ/n4XRbS5xMGfU1/WpMM0FIrqd8Ra7Ij1quzBu36X2R4l
        ygoUyh41HVQrnBAV5VjZXAezj2GfcY8veyzg+yXUPEg06wdzxqwhzbuy6EP9PA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=i7sHYpcfJ8EKrCzslt2cAc24NWY6qek5394P5PZEbDQ=;
        b=J+42HbohHoZY8IBobNxA3UyjtM/YGMN0JHljRLaHwjgARHDCbePa1M9g8a9X9Awe4JKQjt
        21fpEsZfZMJH9rBg==
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
Subject: [patch 15/53] x86/jailhouse: Prepare for separate mpparse callbacks
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:52:56 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a wrapper around the existing function and fill the new callbacks
in.

No functional change as the new callbacks are not yet operational.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/jailhouse.c |   34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -118,6 +118,11 @@ static void __init jailhouse_get_smp_con
 	}
 }
 
+static void __init jailhouse_parse_smp_config(void)
+{
+	jailhouse_get_smp_config(false);
+}
+
 static void jailhouse_no_restart(void)
 {
 	pr_notice("Jailhouse: Restart not supported, halting\n");
@@ -201,21 +206,24 @@ static void __init jailhouse_init_platfo
 	struct setup_data header;
 	void *mapping;
 
-	x86_init.irqs.pre_vector_init	= x86_init_noop;
-	x86_init.timers.timer_init	= jailhouse_timer_init;
-	x86_init.mpparse.get_smp_config	= jailhouse_get_smp_config;
-	x86_init.pci.arch_init		= jailhouse_pci_arch_init;
-
-	x86_platform.calibrate_cpu	= jailhouse_get_tsc;
-	x86_platform.calibrate_tsc	= jailhouse_get_tsc;
-	x86_platform.get_wallclock	= jailhouse_get_wallclock;
-	x86_platform.legacy.rtc		= 0;
-	x86_platform.legacy.warm_reset	= 0;
-	x86_platform.legacy.i8042	= X86_LEGACY_I8042_PLATFORM_ABSENT;
+	x86_init.irqs.pre_vector_init		= x86_init_noop;
+	x86_init.timers.timer_init		= jailhouse_timer_init;
+	x86_init.mpparse.find_mptable		= x86_init_noop;
+	x86_init.mpparse.early_parse_smp_cfg	= x86_init_noop;
+	x86_init.mpparse.parse_smp_cfg		= jailhouse_parse_smp_config;
+	x86_init.mpparse.get_smp_config		= jailhouse_get_smp_config;
+	x86_init.pci.arch_init			= jailhouse_pci_arch_init;
+
+	x86_platform.calibrate_cpu		= jailhouse_get_tsc;
+	x86_platform.calibrate_tsc		= jailhouse_get_tsc;
+	x86_platform.get_wallclock		= jailhouse_get_wallclock;
+	x86_platform.legacy.rtc			= 0;
+	x86_platform.legacy.warm_reset		= 0;
+	x86_platform.legacy.i8042		= X86_LEGACY_I8042_PLATFORM_ABSENT;
 
-	legacy_pic			= &null_legacy_pic;
+	legacy_pic				= &null_legacy_pic;
 
-	machine_ops.emergency_restart	= jailhouse_no_restart;
+	machine_ops.emergency_restart		= jailhouse_no_restart;
 
 	while (pa_data) {
 		mapping = early_memremap(pa_data, sizeof(header));

