Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE2477682A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbjHITNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbjHITMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:12:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D50B2717;
        Wed,  9 Aug 2023 12:12:25 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:12:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691608340;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fzti2xQUly3b/kP3Xg8CC36cxRJZCss877lxRX7bCuk=;
        b=rnmi5GGXTCuNkEGUNd2uThVt9ywtUlHrILRYVR30cr/jy3gAJGXVmif6/+v5VlcDF64c++
        OESD9PQn51H6GtGIxE0JIDMz5x3zRypuRKwn3T6mcRtD+9K1/63m55Z+YHG+5E6wVJLwCV
        d7QajkJqeC2QkTdDkiJckrzJzwy3ZXfaR3OfjH69uT7v74eLIh9YKlr4/SOzjA54R9J0lW
        5RZ8Wdum5xATi843xx/VhWB05+HRxhm9SL2kCR5g+yPeOa43ai7fbFFY844cELH7XCD/2H
        +yNtec51WbXgJpuGDQ11tHoXkTZyvXuPnJUNTONEn7MRuEwlwE6C55NtzBppXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691608340;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fzti2xQUly3b/kP3Xg8CC36cxRJZCss877lxRX7bCuk=;
        b=tB8WQ9584Anm9izw/CeiGCFQBMzRe7a8sqCFPSySDP3I9LMo/zI0VBKElKHndqjPRXc1fp
        UAZyqv2iCE+1qgBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic/32: Remove pointless default_acpi_madt_oem_check()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169160833993.27769.566734109101233603.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     d75baa260c850b3d184b1e3cceeff450d65e5603
Gitweb:        https://git.kernel.org/tip/d75baa260c850b3d184b1e3cceeff450d65e5603
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:55 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:24 -07:00

x86/apic/32: Remove pointless default_acpi_madt_oem_check()

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
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/include/asm/apic.h      |  4 +++-
 arch/x86/kernel/apic/bigsmp_32.c |  1 -
 arch/x86/kernel/apic/probe_32.c  | 22 ----------------------
 3 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index daef681..f6541a2 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -459,10 +459,12 @@ static inline unsigned int read_apic_id(void)
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
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index b649048..d19dcf9 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -112,7 +112,6 @@ static struct apic apic_bigsmp __ro_after_init = {
 
 	.name				= "bigsmp",
 	.probe				= probe_bigsmp,
-	.acpi_madt_oem_check		= NULL,
 	.apic_id_valid			= default_apic_id_valid,
 	.apic_id_registered		= bigsmp_apic_id_registered,
 
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 3ee0211..20d7f57 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -60,7 +60,6 @@ static struct apic apic_default __ro_after_init = {
 
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
