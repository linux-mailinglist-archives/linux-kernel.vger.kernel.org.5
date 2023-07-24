Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054E975F865
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjGXNfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjGXNfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:35:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBF21B8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:34:47 -0700 (PDT)
Message-ID: <20230724132046.033563977@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690205666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=XBWDLku2nyQ5/5bJqq7OR3c/AtCppUf/8w42TtOLQ9Q=;
        b=Rn1RuI4ok1LNKdo0pSoUsJ8vum8dDf3MJB+pYApITyqT958xUvvroeGHufqwRLSKxfhh1u
        Pdjp9hDei1bguhaBx4/cPfR1yZbwSPQViCqOgse4llUuagbergyIxZy7MV4evoqlri88Os
        z35ZOOZlL3jm0jJxibuToAWWurEGpQgOIy55xe3GPcMMZSMq/Fn9ij3feKTHLcQdQ+W3ov
        bc9BBe7xGuVleG2MwLJvG6DM4bqG9ewg+LHD82lPcXJVjtYsbkT3NXkJ/pmbkfjsoHToeX
        uW9jqRgjkVQjXyPwjIkfVcoTEyaJO2xgpw6sLYZEbJS7knotbe8bNNdGMYNT+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690205666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=XBWDLku2nyQ5/5bJqq7OR3c/AtCppUf/8w42TtOLQ9Q=;
        b=TjfLjKbPKwED1Fu6tWBWhB/ljvQL/gtk/WYYh2A0OslVlfyEN2Sl+5rSrftEab67kKAs07
        HeXhXzsjVSl3O8Bw==
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
Subject: [patch V2 24/58] x86/apic/32: Remove pointless default_acpi_madt_oem_check()
References: <20230724131206.500814398@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 15:34:25 +0200 (CEST)
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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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

