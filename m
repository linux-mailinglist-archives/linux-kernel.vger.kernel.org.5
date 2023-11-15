Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1F17ED08A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343515AbjKOTz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343545AbjKOTzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 14:55:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CA91A8;
        Wed, 15 Nov 2023 11:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700078106; x=1731614106;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9kn0IcXzVyhNwBtqgo8ESAmVudabJ++07BmvROIMeHg=;
  b=SCK3o16jrB5NW1BsDHoDyU+gK3Y+kPXJl5m10C40LW7XedWjP0HBPpju
   ShISj/DXElPWFaPekr8K+4G0cidO556+nT/4PmZxRZuh4wof1npr4RgRn
   NbbGbQ7daHikDvmdKC5hLbfMo6If5SeYqHHLU7FBgH4E2qkE9/DVndKE/
   lZOJh671FvuXnF0QUqkaT1B6V6xJCMQgnXjAFgmEHw/rGg8Qc7yCLK04v
   CvTL803nZZWOpwkpYSUa6QPp+dL+iEY7iPOzErd5Y7w7cz8MBktCogDUR
   XxRvX5LbGM9l6oakyMOpkE1QvA7dTHfXJ1lbHrsbNMryUCjX9wWAD49dY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="477165999"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="477165999"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 11:54:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="768693288"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="768693288"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 11:54:58 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v10 3/3] x86/mce: Handle Intel threshold interrupt storms
Date:   Wed, 15 Nov 2023 11:54:50 -0800
Message-ID: <20231115195450.12963-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115195450.12963-1-tony.luck@intel.com>
References: <20231004183623.17067-1-tony.luck@intel.com>
 <20231115195450.12963-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an Intel specific hook into machine_check_poll() to keep track
of per-CPU, per-bank corrected error logs (with a stub for the
CONFIG_MCE_INTEL=n case).

When a storm is observed the rate of interrupts is reduced by setting
a large threshold value for this bank in IA32_MCi_CTL2. This bank is
added to the bitmap of banks for this CPU to poll. The polling rate
is increased to once per second.

When a storm ends reset the threshold in IA32_MCi_CTL2 back to 1, remove
the bank from the bitmap for polling, and change the polling rate back
to the default.

If a CPU with banks in storm mode is taken offline, the new CPU
that inherits ownership of those banks takes over management of
storm(s) in the inherited bank(s).

The cmci_discover() function was already very large. These changes
pushed it well over the top. Refactor with three helper functions
to bring it back under control.

Updated with review comments from Yazen.
Link: https://lore.kernel.org/r/6ae4df67-ba0b-4b50-8c1d-a5d382105ad2@amd.com

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/internal.h  |   2 +
 arch/x86/kernel/cpu/mce/intel.c     | 205 +++++++++++++++++++++-------
 arch/x86/kernel/cpu/mce/threshold.c |   3 +
 3 files changed, 160 insertions(+), 50 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index e55676f096d8..6315dbf58146 100644
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
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index fc4ffc434023..399b62e223d2 100644
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
@@ -110,6 +129,31 @@ static bool lmce_supported(void)
 	return tmp & FEAT_CTL_LMCE_ENABLED;
 }
 
+/*
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
 /*
  * The interrupt handler. This is called on every event.
  * Just call the poller directly to log any events.
@@ -121,72 +165,130 @@ static void intel_threshold_interrupt(void)
 	machine_check_poll(MCP_TIMESTAMP, this_cpu_ptr(&mce_banks_owned));
 }
 
+/*
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
 /*
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
diff --git a/arch/x86/kernel/cpu/mce/threshold.c b/arch/x86/kernel/cpu/mce/threshold.c
index 0e1988468ee4..89e31e1e5c9c 100644
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
 
-- 
2.41.0

