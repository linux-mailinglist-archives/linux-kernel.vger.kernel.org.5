Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E343D77658B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjHIQuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbjHIQth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:49:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537DC1FEE;
        Wed,  9 Aug 2023 09:49:37 -0700 (PDT)
Date:   Wed, 09 Aug 2023 16:49:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691599776;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=DFmH501DpZEoPD+wgAkXug+itjo9DUkCazk4SMnh0GY=;
        b=tz3pngus4ODJ/87RPakNlJSmlcZAv0srEbLt2M8lMRhJU2B1kIDvtCmVYo2ftEQ7XJiWEY
        yAi7tyavGXHCxtOZXyGyl1oGJi1a1dcuTgwtG89er0pCMIaZwap5ajnIV3M1wf8CH2iRVf
        bskXQMD44ZuiJHyw3HTI+USIVEE9jR/hWcOD/BM/UUhYp7C9Ml2yNcC647GvdEzed8qzQp
        CaGfP8qWSQjqVd5Al8gG0WIPBJOsI6/7YnjfA2eRt1YcX8gtRU9NfCNfACq1vAThu/o/n+
        xk7UxStZDgF5RMGEj/N0AEldHGKzDw0si474XZOBsYfjbTjliAL4p61/wUyZvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691599776;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=DFmH501DpZEoPD+wgAkXug+itjo9DUkCazk4SMnh0GY=;
        b=DuXBpWYRtIcYhL40SrU8V0fhfOlqkguQVsBW4TH8kxvoQZUL+WH5FaZUZMnU2EGsxWgzRv
        sgL5wARR7jUuNnAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic/32: Remove pointless default_acpi_madt_oem_check()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169159977545.27769.16011214663204260889.tip-bot2@tip-bot2>
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

Commit-ID:     b74e35c4320500465f3280f4fa35f73f06cfd7cf
Gitweb:        https://git.kernel.org/tip/b74e35c4320500465f3280f4fa35f73f06cfd7cf
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:55 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 08:10:11 -07:00

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
