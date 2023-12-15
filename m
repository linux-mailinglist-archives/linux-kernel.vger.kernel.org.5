Return-Path: <linux-kernel+bounces-1260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51810814C86
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7666D1C2345E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB6E3A8F7;
	Fri, 15 Dec 2023 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mD1TDwEm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bizR7pGn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F6236AE0;
	Fri, 15 Dec 2023 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 15 Dec 2023 16:10:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702656603;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Btt23pwddYep2IfeXogsp96qqv8TKfBas9gLu9BeYs=;
	b=mD1TDwEmGij3yEgSEPgH+KNswa+3FOuWu1YIoeoCrATSxNnaYJGts8G7EOqGd9iW9bvmvt
	/FxsS3Niua9xlJUpZr77NyjUgSiyDd1QyksURAwXHdqaHbBCD6FvH5ba98yWCYLesA/qLK
	LCwoO/+x38iVshBIhVz0L2iXabu4PRP6PVc6zMxhW7iNtZocuKKL3rEMrAarKfDsP+XVtC
	MVdLj3osr94OpMjTPwZYt062lsHac4l+hStsFHBSPQccL9dO1zDATjQCQBSRGxXIFNcy01
	bjwN0OAFp8tGHQU+wzbmJ5rwYzvgRLAjZcPZePUN0uMRaJ4AuHoEoZ513HQaFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702656603;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Btt23pwddYep2IfeXogsp96qqv8TKfBas9gLu9BeYs=;
	b=bizR7pGnDHGVu/qdgzLBceDZg8kqxnGYE1lEAyghJTrt50jXm4r0OczJZ87CWJwdfiQvKt
	ndfk5NELzPNI9+BA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Handle Intel threshold interrupt storms
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231115195450.12963-4-tony.luck@intel.com>
References: <20231115195450.12963-4-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170265660288.398.1352223643373155784.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     1f68ce2a027250aeeb1756391110cdc4dc97c797
Gitweb:        https://git.kernel.org/tip/1f68ce2a027250aeeb1756391110cdc4dc97c797
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 15 Nov 2023 11:54:50 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 15 Dec 2023 14:53:42 +01:00

x86/mce: Handle Intel threshold interrupt storms

Add an Intel specific hook into machine_check_poll() to keep track of
per-CPU, per-bank corrected error logs (with a stub for the
CONFIG_MCE_INTEL=n case).

When a storm is observed the rate of interrupts is reduced by setting
a large threshold value for this bank in IA32_MCi_CTL2. This bank is
added to the bitmap of banks for this CPU to poll. The polling rate is
increased to once per second.

When a storm ends reset the threshold in IA32_MCi_CTL2 back to 1, remove
the bank from the bitmap for polling, and change the polling rate back
to the default.

If a CPU with banks in storm mode is taken offline, the new CPU that
inherits ownership of those banks takes over management of storm(s) in
the inherited bank(s).

The cmci_discover() function was already very large. These changes
pushed it well over the top. Refactor with three helper functions to
bring it back under control.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231115195450.12963-4-tony.luck@intel.com
---
 arch/x86/kernel/cpu/mce/intel.c     | 205 ++++++++++++++++++++-------
 arch/x86/kernel/cpu/mce/internal.h  |   2 +-
 arch/x86/kernel/cpu/mce/threshold.c |   3 +-
 3 files changed, 160 insertions(+), 50 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index fc4ffc4..399b62e 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -54,8 +54,27 @@ static DEFINE_RAW_SPINLOCK(cmci_discover_lock);
  */
 static DEFINE_SPINLOCK(cmci_poll_lock);
 
+/* Linux non-storm CMCI threshold (may be overridden by BIOS) */
 #define CMCI_THRESHOLD		1
 
+/*
+ * MCi_CTL2 threshold for each bank when there is no storm.
+ * Default value for each bank may have been set by BIOS.
+ */
+static u16 cmci_threshold[MAX_NR_BANKS];
+
+/*
+ * High threshold to limit CMCI rate during storms. Max supported is
+ * 0x7FFF. Use this slightly smaller value so it has a distinctive
+ * signature when some asks "Why am I not seeing all corrected errors?"
+ * A high threshold is used instead of just disabling CMCI for a
+ * bank because both corrected and uncorrected errors may be logged
+ * in the same bank and signalled with CMCI. The threshold only applies
+ * to corrected errors, so keeping CMCI enabled means that uncorrected
+ * errors will still be processed in a timely fashion.
+ */
+#define CMCI_STORM_THRESHOLD	32749
+
 static int cmci_supported(int *banks)
 {
 	u64 cap;
@@ -111,6 +130,31 @@ static bool lmce_supported(void)
 }
 
 /*
+ * Set a new CMCI threshold value. Preserve the state of the
+ * MCI_CTL2_CMCI_EN bit in case this happens during a
+ * cmci_rediscover() operation.
+ */
+static void cmci_set_threshold(int bank, int thresh)
+{
+	unsigned long flags;
+	u64 val;
+
+	raw_spin_lock_irqsave(&cmci_discover_lock, flags);
+	rdmsrl(MSR_IA32_MCx_CTL2(bank), val);
+	val &= ~MCI_CTL2_CMCI_THRESHOLD_MASK;
+	wrmsrl(MSR_IA32_MCx_CTL2(bank), val | thresh);
+	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
+}
+
+void mce_intel_handle_storm(int bank, bool on)
+{
+	if (on)
+		cmci_set_threshold(bank, CMCI_STORM_THRESHOLD);
+	else
+		cmci_set_threshold(bank, cmci_threshold[bank]);
+}
+
+/*
  * The interrupt handler. This is called on every event.
  * Just call the poller directly to log any events.
  * This could in theory increase the threshold under high load,
@@ -122,71 +166,129 @@ static void intel_threshold_interrupt(void)
 }
 
 /*
+ * Check all the reasons why current CPU cannot claim
+ * ownership of a bank.
+ * 1: CPU already owns this bank
+ * 2: BIOS owns this bank
+ * 3: Some other CPU owns this bank
+ */
+static bool cmci_skip_bank(int bank, u64 *val)
+{
+	unsigned long *owned = (void *)this_cpu_ptr(&mce_banks_owned);
+
+	if (test_bit(bank, owned))
+		return true;
+
+	/* Skip banks in firmware first mode */
+	if (test_bit(bank, mce_banks_ce_disabled))
+		return true;
+
+	rdmsrl(MSR_IA32_MCx_CTL2(bank), *val);
+
+	/* Already owned by someone else? */
+	if (*val & MCI_CTL2_CMCI_EN) {
+		clear_bit(bank, owned);
+		__clear_bit(bank, this_cpu_ptr(mce_poll_banks));
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * Decide which CMCI interrupt threshold to use:
+ * 1: If this bank is in storm mode from whichever CPU was
+ *    the previous owner, stay in storm mode.
+ * 2: If ignoring any threshold set by BIOS, set Linux default
+ * 3: Try to honor BIOS threshold (unless buggy BIOS set it at zero).
+ */
+static u64 cmci_pick_threshold(u64 val, int *bios_zero_thresh)
+{
+	if ((val & MCI_CTL2_CMCI_THRESHOLD_MASK) == CMCI_STORM_THRESHOLD)
+		return val;
+
+	if (!mca_cfg.bios_cmci_threshold) {
+		val &= ~MCI_CTL2_CMCI_THRESHOLD_MASK;
+		val |= CMCI_THRESHOLD;
+	} else if (!(val & MCI_CTL2_CMCI_THRESHOLD_MASK)) {
+		/*
+		 * If bios_cmci_threshold boot option was specified
+		 * but the threshold is zero, we'll try to initialize
+		 * it to 1.
+		 */
+		*bios_zero_thresh = 1;
+		val |= CMCI_THRESHOLD;
+	}
+
+	return val;
+}
+
+/*
+ * Try to claim ownership of a bank.
+ */
+static void cmci_claim_bank(int bank, u64 val, int bios_zero_thresh, int *bios_wrong_thresh)
+{
+	struct mca_storm_desc *storm = this_cpu_ptr(&storm_desc);
+
+	val |= MCI_CTL2_CMCI_EN;
+	wrmsrl(MSR_IA32_MCx_CTL2(bank), val);
+	rdmsrl(MSR_IA32_MCx_CTL2(bank), val);
+
+	/* If the enable bit did not stick, this bank should be polled. */
+	if (!(val & MCI_CTL2_CMCI_EN)) {
+		WARN_ON(!test_bit(bank, this_cpu_ptr(mce_poll_banks)));
+		storm->banks[bank].poll_only = true;
+		return;
+	}
+
+	/* This CPU successfully set the enable bit. */
+	set_bit(bank, (void *)this_cpu_ptr(&mce_banks_owned));
+
+	if ((val & MCI_CTL2_CMCI_THRESHOLD_MASK) == CMCI_STORM_THRESHOLD) {
+		pr_notice("CPU%d BANK%d CMCI inherited storm\n", smp_processor_id(), bank);
+		mce_inherit_storm(bank);
+		cmci_storm_begin(bank);
+	} else {
+		__clear_bit(bank, this_cpu_ptr(mce_poll_banks));
+	}
+
+	/*
+	 * We are able to set thresholds for some banks that
+	 * had a threshold of 0. This means the BIOS has not
+	 * set the thresholds properly or does not work with
+	 * this boot option. Note down now and report later.
+	 */
+	if (mca_cfg.bios_cmci_threshold && bios_zero_thresh &&
+	    (val & MCI_CTL2_CMCI_THRESHOLD_MASK))
+		*bios_wrong_thresh = 1;
+
+	/* Save default threshold for each bank */
+	if (cmci_threshold[bank] == 0)
+		cmci_threshold[bank] = val & MCI_CTL2_CMCI_THRESHOLD_MASK;
+}
+
+/*
  * Enable CMCI (Corrected Machine Check Interrupt) for available MCE banks
  * on this CPU. Use the algorithm recommended in the SDM to discover shared
- * banks.
+ * banks. Called during initial bootstrap, and also for hotplug CPU operations
+ * to rediscover/reassign machine check banks.
  */
 static void cmci_discover(int banks)
 {
-	unsigned long *owned = (void *)this_cpu_ptr(&mce_banks_owned);
+	int bios_wrong_thresh = 0;
 	unsigned long flags;
 	int i;
-	int bios_wrong_thresh = 0;
 
 	raw_spin_lock_irqsave(&cmci_discover_lock, flags);
 	for (i = 0; i < banks; i++) {
 		u64 val;
 		int bios_zero_thresh = 0;
 
-		if (test_bit(i, owned))
-			continue;
-
-		/* Skip banks in firmware first mode */
-		if (test_bit(i, mce_banks_ce_disabled))
+		if (cmci_skip_bank(i, &val))
 			continue;
 
-		rdmsrl(MSR_IA32_MCx_CTL2(i), val);
-
-		/* Already owned by someone else? */
-		if (val & MCI_CTL2_CMCI_EN) {
-			clear_bit(i, owned);
-			__clear_bit(i, this_cpu_ptr(mce_poll_banks));
-			continue;
-		}
-
-		if (!mca_cfg.bios_cmci_threshold) {
-			val &= ~MCI_CTL2_CMCI_THRESHOLD_MASK;
-			val |= CMCI_THRESHOLD;
-		} else if (!(val & MCI_CTL2_CMCI_THRESHOLD_MASK)) {
-			/*
-			 * If bios_cmci_threshold boot option was specified
-			 * but the threshold is zero, we'll try to initialize
-			 * it to 1.
-			 */
-			bios_zero_thresh = 1;
-			val |= CMCI_THRESHOLD;
-		}
-
-		val |= MCI_CTL2_CMCI_EN;
-		wrmsrl(MSR_IA32_MCx_CTL2(i), val);
-		rdmsrl(MSR_IA32_MCx_CTL2(i), val);
-
-		/* Did the enable bit stick? -- the bank supports CMCI */
-		if (val & MCI_CTL2_CMCI_EN) {
-			set_bit(i, owned);
-			__clear_bit(i, this_cpu_ptr(mce_poll_banks));
-			/*
-			 * We are able to set thresholds for some banks that
-			 * had a threshold of 0. This means the BIOS has not
-			 * set the thresholds properly or does not work with
-			 * this boot option. Note down now and report later.
-			 */
-			if (mca_cfg.bios_cmci_threshold && bios_zero_thresh &&
-					(val & MCI_CTL2_CMCI_THRESHOLD_MASK))
-				bios_wrong_thresh = 1;
-		} else {
-			WARN_ON(!test_bit(i, this_cpu_ptr(mce_poll_banks)));
-		}
+		val = cmci_pick_threshold(val, &bios_zero_thresh);
+		cmci_claim_bank(i, val, bios_zero_thresh, &bios_wrong_thresh);
 	}
 	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
 	if (mca_cfg.bios_cmci_threshold && bios_wrong_thresh) {
@@ -225,6 +327,9 @@ static void __cmci_disable_bank(int bank)
 	val &= ~MCI_CTL2_CMCI_EN;
 	wrmsrl(MSR_IA32_MCx_CTL2(bank), val);
 	__clear_bit(bank, this_cpu_ptr(mce_banks_owned));
+
+	if ((val & MCI_CTL2_CMCI_THRESHOLD_MASK) == CMCI_STORM_THRESHOLD)
+		cmci_storm_end(bank);
 }
 
 /*
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 157b2f2..01f8f03 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -41,6 +41,7 @@ struct dentry *mce_get_debugfs_dir(void);
 extern mce_banks_t mce_banks_ce_disabled;
 
 #ifdef CONFIG_X86_MCE_INTEL
+void mce_intel_handle_storm(int bank, bool on);
 void cmci_disable_bank(int bank);
 void intel_init_cmci(void);
 void intel_init_lmce(void);
@@ -48,6 +49,7 @@ void intel_clear_lmce(void);
 bool intel_filter_mce(struct mce *m);
 bool intel_mce_usable_address(struct mce *m);
 #else
+static inline void mce_intel_handle_storm(int bank, bool on) { }
 static inline void cmci_disable_bank(int bank) { }
 static inline void intel_init_cmci(void) { }
 static inline void intel_init_lmce(void) { }
diff --git a/arch/x86/kernel/cpu/mce/threshold.c b/arch/x86/kernel/cpu/mce/threshold.c
index 0e19884..89e31e1 100644
--- a/arch/x86/kernel/cpu/mce/threshold.c
+++ b/arch/x86/kernel/cpu/mce/threshold.c
@@ -60,6 +60,9 @@ void mce_set_storm_mode(bool storm)
 static void mce_handle_storm(unsigned int bank, bool on)
 {
 	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_INTEL:
+		mce_intel_handle_storm(bank, on);
+		break;
 	}
 }
 

