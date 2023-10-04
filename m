Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74447B8ABC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244531AbjJDSiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244510AbjJDSiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:38:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F93CA6;
        Wed,  4 Oct 2023 11:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696444678; x=1727980678;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IZk3+rlL9saMs4f4kwEoKyW42P2ceIQ4ZmbhTJNBUYo=;
  b=CVJjjYSad4gg0yshB+LwD3KvkbpR3jBWiuLvCHK5LMCdpSpcl6fUKxub
   FoT9aWUzF8VFEG/WBKUXlq2+7IF+P9u7KyJMPdgFJB51+phmfuEeuyjU0
   GViqQXgxtCPcHSZgn+rlJHZefYmlSef9wD49M5GN1CSIn8eUY5PpY2rGl
   3I2wEgByXdpdS52a8ctR+7CtGVElOXxi4XYI+eZdiI9onmuZ6A69jyYTC
   y8+zt1LCWQ+FPUzSYOpP+a/Rr3Nvsf78BaXTM9LiAn/r/IsPs3T+DAeSh
   l865nk4Bn6DdYA5OsIOsGDACZwzvDcqP8wz7Tb1SyRZBM9zilQtH54qOY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="387133520"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="387133520"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 11:36:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="701236060"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="701236060"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 11:36:32 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v9 3/3] x86/mce: Handle Intel threshold interrupt storms
Date:   Wed,  4 Oct 2023 11:36:23 -0700
Message-ID: <20231004183623.17067-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004183623.17067-1-tony.luck@intel.com>
References: <20230929181626.210782-1-tony.luck@intel.com>
 <20231004183623.17067-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
v9: Fixed lkp randconfig build issue
---
 arch/x86/kernel/cpu/mce/internal.h  |   2 +
 arch/x86/kernel/cpu/mce/intel.c     | 202 +++++++++++++++++++++-------
 arch/x86/kernel/cpu/mce/threshold.c |   3 +
 3 files changed, 157 insertions(+), 50 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 4aa957442c8d..373cc2fbad6c 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -41,12 +41,14 @@ struct dentry *mce_get_debugfs_dir(void);
 extern mce_banks_t mce_banks_ce_disabled;
 
 #ifdef CONFIG_X86_MCE_INTEL
+void mce_intel_handle_storm(int bank, bool on);
 void cmci_disable_bank(int bank);
 void intel_init_cmci(void);
 void intel_init_lmce(void);
 void intel_clear_lmce(void);
 bool intel_filter_mce(struct mce *m);
 #else
+static inline void mce_intel_handle_storm(int bank, bool on) { }
 static inline void cmci_disable_bank(int bank) { }
 static inline void intel_init_cmci(void) { }
 static inline void intel_init_lmce(void) { }
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index b07656408f67..ae8817c03534 100644
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
@@ -121,72 +165,127 @@ static void intel_threshold_interrupt(void)
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
+	val |= MCI_CTL2_CMCI_EN;
+	wrmsrl(MSR_IA32_MCx_CTL2(bank), val);
+	rdmsrl(MSR_IA32_MCx_CTL2(bank), val);
+
+	/* If the enable bit did not stick, this bank should be polled. */
+	if (!(val & MCI_CTL2_CMCI_EN)) {
+		WARN_ON(!test_bit(bank, this_cpu_ptr(mce_poll_banks)));
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
@@ -225,6 +324,9 @@ static void __cmci_disable_bank(int bank)
 	val &= ~MCI_CTL2_CMCI_EN;
 	wrmsrl(MSR_IA32_MCx_CTL2(bank), val);
 	__clear_bit(bank, this_cpu_ptr(mce_banks_owned));
+
+	if ((val & MCI_CTL2_CMCI_THRESHOLD_MASK) == CMCI_STORM_THRESHOLD)
+		cmci_storm_end(bank);
 }
 
 /*
diff --git a/arch/x86/kernel/cpu/mce/threshold.c b/arch/x86/kernel/cpu/mce/threshold.c
index ecdf13f1bb7d..209bb0b7428b 100644
--- a/arch/x86/kernel/cpu/mce/threshold.c
+++ b/arch/x86/kernel/cpu/mce/threshold.c
@@ -64,6 +64,9 @@ void mce_set_storm(bool storm)
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

