Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2377DA0E5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346561AbjJ0Sqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346393AbjJ0Sqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:46:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B97DD64;
        Fri, 27 Oct 2023 11:46:34 -0700 (PDT)
Date:   Fri, 27 Oct 2023 18:46:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698432392;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Md4gd9s5tpLbWsHux4o16pXnsroMWe4JjJyoBD7SUKw=;
        b=g8BRZ0V1/5Bnhk/ix83s2gYCe4EWGtCal3YC97eZcP8pVrT8JMzgQ06CgcSAA7jqkVZUQP
        D4GxHwVVJQvhK7SbtNPEFCfnxJQVCChxLS3znDNVFHJXVPsTgZ/WLKKnSdhGWHr1GX9Aas
        oDkHVeaPmFnewqeQx27kkj8/NyLvZp1cMSbc/PUYgHtZCeHDbNDm8gElPgBQm1Myc3rEvv
        I1GcNp+pvUv5KNFkFaxbvqjYhvWpumzHJF+zhlk836oesH6qs8izDy+95n99x5Dv+eqQ3S
        tRyvaoXx8fhwOpoOI5zFo06bnAP41jaERnLxiIPYu5aG8SmOp8+WuHV8lNnlzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698432392;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Md4gd9s5tpLbWsHux4o16pXnsroMWe4JjJyoBD7SUKw=;
        b=qFgsd2vHGavKteH2w7+7SkNfDO8J9A/PpdwlPW7GYiwnHiPrXNgsOi+cufS1TUxCvyz5lT
        aBod3D9DnNYB9aDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/i8259: Skip probing when ACPI/MADT advertises
 PCAT compatibility
Cc:     David Lazar <dlazar@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        stable@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <875y2u5s8g.ffs@tglx>
References: <875y2u5s8g.ffs@tglx>
MIME-Version: 1.0
Message-ID: <169843239181.3135.14432177110076341391.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     128b0c9781c9f2651bea163cb85e52a6c7be0f9e
Gitweb:        https://git.kernel.org/tip/128b0c9781c9f2651bea163cb85e52a6c7be0f9e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 25 Oct 2023 23:04:15 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 27 Oct 2023 20:36:49 +02:00

x86/i8259: Skip probing when ACPI/MADT advertises PCAT compatibility

David and a few others reported that on certain newer systems some legacy
interrupts fail to work correctly.

Debugging revealed that the BIOS of these systems leaves the legacy PIC in
uninitialized state which makes the PIC detection fail and the kernel
switches to a dummy implementation.

Unfortunately this fallback causes quite some code to fail as it depends on
checks for the number of legacy PIC interrupts or the availability of the
real PIC.

In theory there is no reason to use the PIC on any modern system when
IO/APIC is available, but the dependencies on the related checks cannot be
resolved trivially and on short notice. This needs lots of analysis and
rework.

The PIC detection has been added to avoid quirky checks and force selection
of the dummy implementation all over the place, especially in VM guest
scenarios. So it's not an option to revert the relevant commit as that
would break a lot of other scenarios.

One solution would be to try to initialize the PIC on detection fail and
retry the detection, but that puts the burden on everything which does not
have a PIC.

Fortunately the ACPI/MADT table header has a flag field, which advertises
in bit 0 that the system is PCAT compatible, which means it has a legacy
8259 PIC.

Evaluate that bit and if set avoid the detection routine and keep the real
PIC installed, which then gets initialized (for nothing) and makes the rest
of the code with all the dependencies work again.

Fixes: e179f6914152 ("x86, irq, pic: Probe for legacy PIC and set legacy_pic appropriately")
Reported-by: David Lazar <dlazar@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: David Lazar <dlazar@gmail.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Cc: stable@vger.kernel.org
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218003
Link: https://lore.kernel.org/r/875y2u5s8g.ffs@tglx

---
 arch/x86/include/asm/i8259.h |  2 ++-
 arch/x86/kernel/acpi/boot.c  |  3 +++-
 arch/x86/kernel/i8259.c      | 38 +++++++++++++++++++++++++++--------
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/i8259.h b/arch/x86/include/asm/i8259.h
index 637fa1d..c715097 100644
--- a/arch/x86/include/asm/i8259.h
+++ b/arch/x86/include/asm/i8259.h
@@ -69,6 +69,8 @@ struct legacy_pic {
 	void (*make_irq)(unsigned int irq);
 };
 
+void legacy_pic_pcat_compat(void);
+
 extern struct legacy_pic *legacy_pic;
 extern struct legacy_pic null_legacy_pic;
 
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 2a0ea38..c55c0ef 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -148,6 +148,9 @@ static int __init acpi_parse_madt(struct acpi_table_header *table)
 		pr_debug("Local APIC address 0x%08x\n", madt->address);
 	}
 
+	if (madt->flags & ACPI_MADT_PCAT_COMPAT)
+		legacy_pic_pcat_compat();
+
 	/* ACPI 6.3 and newer support the online capable bit. */
 	if (acpi_gbl_FADT.header.revision > 6 ||
 	    (acpi_gbl_FADT.header.revision == 6 &&
diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
index 30a5520..c20d183 100644
--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -32,6 +32,7 @@
  */
 static void init_8259A(int auto_eoi);
 
+static bool pcat_compat __ro_after_init;
 static int i8259A_auto_eoi;
 DEFINE_RAW_SPINLOCK(i8259A_lock);
 
@@ -299,15 +300,32 @@ static void unmask_8259A(void)
 
 static int probe_8259A(void)
 {
+	unsigned char new_val, probe_val = ~(1 << PIC_CASCADE_IR);
 	unsigned long flags;
-	unsigned char probe_val = ~(1 << PIC_CASCADE_IR);
-	unsigned char new_val;
+
+	/*
+	 * If MADT has the PCAT_COMPAT flag set, then do not bother probing
+	 * for the PIC. Some BIOSes leave the PIC uninitialized and probing
+	 * fails.
+	 *
+	 * Right now this causes problems as quite some code depends on
+	 * nr_legacy_irqs() > 0 or has_legacy_pic() == true. This is silly
+	 * when the system has an IO/APIC because then PIC is not required
+	 * at all, except for really old machines where the timer interrupt
+	 * must be routed through the PIC. So just pretend that the PIC is
+	 * there and let legacy_pic->init() initialize it for nothing.
+	 *
+	 * Alternatively this could just try to initialize the PIC and
+	 * repeat the probe, but for cases where there is no PIC that's
+	 * just pointless.
+	 */
+	if (pcat_compat)
+		return nr_legacy_irqs();
+
 	/*
-	 * Check to see if we have a PIC.
-	 * Mask all except the cascade and read
-	 * back the value we just wrote. If we don't
-	 * have a PIC, we will read 0xff as opposed to the
-	 * value we wrote.
+	 * Check to see if we have a PIC.  Mask all except the cascade and
+	 * read back the value we just wrote. If we don't have a PIC, we
+	 * will read 0xff as opposed to the value we wrote.
 	 */
 	raw_spin_lock_irqsave(&i8259A_lock, flags);
 
@@ -429,5 +447,9 @@ static int __init i8259A_init_ops(void)
 
 	return 0;
 }
-
 device_initcall(i8259A_init_ops);
+
+void __init legacy_pic_pcat_compat(void)
+{
+	pcat_compat = true;
+}
