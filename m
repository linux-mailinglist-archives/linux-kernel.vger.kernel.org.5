Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6108F757064
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjGQXQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjGQXQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:16:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E67619B3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:15:51 -0700 (PDT)
Message-ID: <20230717223224.504601096@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=KOrCgxfZUWOEP5kQU9kDQX721qeaGgb7AagTW/GicUQ=;
        b=oiRhFEFFvGuOGsKWDiQ8THEq6of5+8aMxDRz8+YOj50I8rOP8AY970wOn35phqd76f38XD
        8zFZw3BC4E+ZRTJpTr258Pf6glz18bevFmz9K6hBj8mpl+QBFT1gSk4iufxaN9carsBtW5
        Y9hPPM2z54hgpT/d95k7+tP8iAenhd3Zu24DrOkb4wMhbk71PFHTUeaAQHx9cMzZ1ScpzO
        +vonEO4uHaQTiCsl6RtjECwQNpDVscxUFX9mv5tM7A1TvJmY9NGwsttjuzZyNEnnMhNsdZ
        +cZpTde91cpythj/IUHK3pJ0alWpYsPvUwPplg6p/kTdR+rYnQmi2MFL3FPH8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=KOrCgxfZUWOEP5kQU9kDQX721qeaGgb7AagTW/GicUQ=;
        b=Nc/fnigbZfoKzY8HMkUzD6HHp5XpCEeUqCsfekUtoDmN4YGLGQMvvszhGWqLGWAXsaq1Ai
        5HwnoT74tFmHmJAQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 24/58] x86/apic/32: Remove pointless default_acpi_madt_oem_check()
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:15:11 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32bit there is no APIC implementing the acpi_madt_oem_check() except XEN
PV, but that does not matter at all.

generic_apic_probe() runs before ACPI tables are parsed. This selects the
XEN APIC if there is no command line override because the XEN APIC driver
is the first to be probed.

If there is a command line override then the XEN PV driver won't be
selected in the MADT OEM check either.

As there is no other MADT check implemented for 32bit APICs, this whole
excercise is a NOOP and can be removed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/apic.h      |    4 +++-
 arch/x86/kernel/apic/bigsmp_32.c |    1 -
 arch/x86/kernel/apic/probe_32.c  |   22 ----------------------
 3 files changed, 3 insertions(+), 24 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -459,10 +459,12 @@ static inline unsigned int read_apic_id(
 #ifdef CONFIG_X86_64
 typedef int (*wakeup_cpu_handler)(int apicid, unsigned long start_eip);
 extern void acpi_wake_cpu_handler_update(wakeup_cpu_handler handler);
+extern int default_acpi_madt_oem_check(char *, char *);
+#else
+static inline int default_acpi_madt_oem_check(char *a, char *b) { return 0; }
 #endif
 
 extern int default_apic_id_valid(u32 apicid);
-extern int default_acpi_madt_oem_check(char *, char *);
 extern void default_setup_apic_routing(void);
 
 extern u32 apic_default_calc_apicid(unsigned int cpu);
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -112,7 +112,6 @@ static struct apic apic_bigsmp __ro_afte
 
 	.name				= "bigsmp",
 	.probe				= probe_bigsmp,
-	.acpi_madt_oem_check		= NULL,
 	.apic_id_valid			= default_apic_id_valid,
 	.apic_id_registered		= bigsmp_apic_id_registered,
 
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -60,7 +60,6 @@ static struct apic apic_default __ro_aft
 
 	.name				= "default",
 	.probe				= probe_default,
-	.acpi_madt_oem_check		= NULL,
 	.apic_id_valid			= default_apic_id_valid,
 	.apic_id_registered		= default_apic_id_registered,
 
@@ -176,24 +175,3 @@ void __init generic_apic_probe(void)
 	}
 	printk(KERN_INFO "Using APIC driver %s\n", apic->name);
 }
-
-/* This function can switch the APIC even after the initial ->probe() */
-int __init default_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
-{
-	struct apic **drv;
-
-	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++) {
-		if (!(*drv)->acpi_madt_oem_check)
-			continue;
-		if (!(*drv)->acpi_madt_oem_check(oem_id, oem_table_id))
-			continue;
-
-		if (!cmdline_apic) {
-			apic = *drv;
-			printk(KERN_INFO "Switched to APIC driver `%s'.\n",
-			       apic->name);
-		}
-		return 1;
-	}
-	return 0;
-}

