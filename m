Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A1375D062
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjGURLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjGURLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:11:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2376A1710;
        Fri, 21 Jul 2023 10:11:07 -0700 (PDT)
Date:   Fri, 21 Jul 2023 17:11:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689959465;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vi6cCicNwWyAB5LUQqwwsECz3OgXnLAG3wsxIu9BQfc=;
        b=ae6Kr3A701kX8L/iXG/2GCRc7slZW36BFBPMpV/Qxf5mDI/Y3wSXMos0OXYYWLtx7Lpr+o
        yBR6zjsmgSf0cbrxoEMxIKWcDxTS6StYPWAP0S9pDkMqX+XPN8g6jSB8aBj1sr7cnsRztY
        l1ITNaJKvvwcVI6RPROxSH+dnzHZQ4DEDB6+Z1nMqlsFEoPzBVS06rcdQLPFOukZvL6ZYo
        oWlUPYLs+UXpr6UT7kZp5lnWrFqjFujP8RfzQ2GW70plA2FAA4/vFdR71HYzqmMuz50cdD
        fSWON0v6Sp0pZy5TNWnuikOXALYFrQqFtHU+zOjCUk7z/DYKXUQK/h/GIMSl4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689959465;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vi6cCicNwWyAB5LUQqwwsECz3OgXnLAG3wsxIu9BQfc=;
        b=oX5LeEzkMKLOYxW+2u/emjsoXV+jOLDkM3sVAwkXSAv9vsPyS3MKzqcDlAQn28IJ8rj29S
        ybSxJBDH0HC7OEDw==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Prevent duplicate error records
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Aristeu Rozanski <aris@ruivo.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230515143225.GC4090740@cathedrallabs.org>
References: <20230515143225.GC4090740@cathedrallabs.org>
MIME-Version: 1.0
Message-ID: <168995946413.28540.2865986697159776163.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     c3629dd7e67d6ec5705d33b0de0d142c972fe573
Gitweb:        https://git.kernel.org/tip/c3629dd7e67d6ec5705d33b0de0d142c972fe573
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 19 Jul 2023 14:19:50 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 21 Jul 2023 18:55:46 +02:00

x86/mce: Prevent duplicate error records

A legitimate use case of the MCA infrastructure is to have the firmware
log all uncorrectable errors and also, have the OS see all correctable
errors.

The uncorrectable, UCNA errors are usually configured to be reported
through an SMI. CMCI, which is the correctable error reporting
interrupt, uses SMI too and having both enabled, leads to unnecessary
overhead.

So what ends up happening is, people disable CMCI in the wild and leave
on only the UCNA SMI.

When CMCI is disabled, the MCA infrastructure resorts to polling the MCA
banks. If a MCA MSR is shared between the logical threads, one error
ends up getting logged multiple times as the polling runs on every
logical thread.

Therefore, introduce locking on the Intel side of the polling routine to
prevent such duplicate error records from appearing.

Based on a patch by Aristeu Rozanski <aris@ruivo.org>.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Tony Luck <tony.luck@intel.com>
Acked-by: Aristeu Rozanski <aris@ruivo.org>
Link: https://lore.kernel.org/r/20230515143225.GC4090740@cathedrallabs.org
---
 arch/x86/kernel/cpu/mce/core.c     |  9 ++++++++-
 arch/x86/kernel/cpu/mce/intel.c    | 19 ++++++++++++++++++-
 arch/x86/kernel/cpu/mce/internal.h |  1 +
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 89e2aab..b8ad5a5 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1608,6 +1608,13 @@ static void __start_timer(struct timer_list *t, unsigned long interval)
 	local_irq_restore(flags);
 }
 
+static void mc_poll_banks_default(void)
+{
+	machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
+}
+
+void (*mc_poll_banks)(void) = mc_poll_banks_default;
+
 static void mce_timer_fn(struct timer_list *t)
 {
 	struct timer_list *cpu_t = this_cpu_ptr(&mce_timer);
@@ -1618,7 +1625,7 @@ static void mce_timer_fn(struct timer_list *t)
 	iv = __this_cpu_read(mce_next_interval);
 
 	if (mce_available(this_cpu_ptr(&cpu_info))) {
-		machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
+		mc_poll_banks();
 
 		if (mce_intel_cmci_poll()) {
 			iv = mce_adjust_timer(iv);
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 95275a5..f532355 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -56,6 +56,13 @@ static DEFINE_PER_CPU(int, cmci_backoff_cnt);
  */
 static DEFINE_RAW_SPINLOCK(cmci_discover_lock);
 
+/*
+ * On systems that do support CMCI but it's disabled, polling for MCEs can
+ * cause the same event to be reported multiple times because IA32_MCi_STATUS
+ * is shared by the same package.
+ */
+static DEFINE_SPINLOCK(cmci_poll_lock);
+
 #define CMCI_THRESHOLD		1
 #define CMCI_POLL_INTERVAL	(30 * HZ)
 #define CMCI_STORM_INTERVAL	(HZ)
@@ -426,12 +433,22 @@ void cmci_disable_bank(int bank)
 	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
 }
 
+/* Bank polling function when CMCI is disabled. */
+static void cmci_mc_poll_banks(void)
+{
+	spin_lock(&cmci_poll_lock);
+	machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
+	spin_unlock(&cmci_poll_lock);
+}
+
 void intel_init_cmci(void)
 {
 	int banks;
 
-	if (!cmci_supported(&banks))
+	if (!cmci_supported(&banks)) {
+		mc_poll_banks = cmci_mc_poll_banks;
 		return;
+	}
 
 	mce_threshold_vector = intel_threshold_interrupt;
 	cmci_discover(banks);
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index d2412ce..ed4a71c 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -274,4 +274,5 @@ static __always_inline u32 mca_msr_reg(int bank, enum mca_msr reg)
 	return 0;
 }
 
+extern void (*mc_poll_banks)(void);
 #endif /* __X86_MCE_INTERNAL_H__ */
