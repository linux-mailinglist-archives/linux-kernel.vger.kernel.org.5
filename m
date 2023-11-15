Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816B37ED072
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343526AbjKOTzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343527AbjKOTzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 14:55:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A9019E;
        Wed, 15 Nov 2023 11:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700078103; x=1731614103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fwO16fD9R0KxrPXng3uzjYUXYaUurUShgouwRbd9mbg=;
  b=XibImg1ncw/LWPJWECMrFQemPXTgWJnUDx8GHnXs6XhHUwSkw+F1zLDf
   xfPMk1T1cpJMpW5WrELGGfEznyGzIavr2XTnTiUQidV4ByTiayzBrsaq2
   iLWdZbPfcmMmqGfnqq9N6xebYAJf+caPUaRpYB7GPdNPGguYLue1yULCw
   1b7xu8jZo2OB8+xRn0/pkBb2p7ZGK8cWuqZjhh6okuRfoWiMJJ7ofWeHR
   tBXXP35uzlJPeO5PieJjjeB23qXy+3GikJq+Fku8jXCizC71EogMb3ZFi
   3OgyHS5rcq7srXZA6mRaHxNCmLV15U03Bq/juvBI2Vum1SCTM9cTizSJS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="477165989"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="477165989"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 11:54:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="768693281"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="768693281"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 11:54:57 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v10 1/3] x86/mce: Remove old CMCI storm mitigation code
Date:   Wed, 15 Nov 2023 11:54:48 -0800
Message-ID: <20231115195450.12963-2-tony.luck@intel.com>
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

When a "storm" of CMCI is detected this code mitigates by
disabling CMCI interrupt signalling from all of the banks
owned by the CPU that saw the storm.

There are problems with this approach:

1) It is very coarse grained. In all likelihood only one of the
banks was generating the interrupts, but CMCI is disabled for all.
This means Linux may delay seeing and processing errors logged
from other banks.

2) Although CMCI stands for Corrected Machine Check Interrupt, it
is also used to signal when an uncorrected error is logged. This
is a problem because these errors should be handled in a timely
manner.

Delete all this code in preparation for a finer grained solution.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Tested-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/internal.h |   6 --
 arch/x86/kernel/cpu/mce/core.c     |  20 +---
 arch/x86/kernel/cpu/mce/intel.c    | 145 -----------------------------
 3 files changed, 1 insertion(+), 170 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index e13a26c9c0ac..b18e99016ce5 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -41,9 +41,6 @@ struct dentry *mce_get_debugfs_dir(void);
 extern mce_banks_t mce_banks_ce_disabled;
 
 #ifdef CONFIG_X86_MCE_INTEL
-unsigned long cmci_intel_adjust_timer(unsigned long interval);
-bool mce_intel_cmci_poll(void);
-void mce_intel_hcpu_update(unsigned long cpu);
 void cmci_disable_bank(int bank);
 void intel_init_cmci(void);
 void intel_init_lmce(void);
@@ -51,9 +48,6 @@ void intel_clear_lmce(void);
 bool intel_filter_mce(struct mce *m);
 bool intel_mce_usable_address(struct mce *m);
 #else
-# define cmci_intel_adjust_timer mce_adjust_timer_default
-static inline bool mce_intel_cmci_poll(void) { return false; }
-static inline void mce_intel_hcpu_update(unsigned long cpu) { }
 static inline void cmci_disable_bank(int bank) { }
 static inline void intel_init_cmci(void) { }
 static inline void intel_init_lmce(void) { }
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 7b397370b4d6..117848a63aff 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1601,13 +1601,6 @@ static unsigned long check_interval = INITIAL_CHECK_INTERVAL;
 static DEFINE_PER_CPU(unsigned long, mce_next_interval); /* in jiffies */
 static DEFINE_PER_CPU(struct timer_list, mce_timer);
 
-static unsigned long mce_adjust_timer_default(unsigned long interval)
-{
-	return interval;
-}
-
-static unsigned long (*mce_adjust_timer)(unsigned long interval) = mce_adjust_timer_default;
-
 static void __start_timer(struct timer_list *t, unsigned long interval)
 {
 	unsigned long when = jiffies + interval;
@@ -1637,15 +1630,9 @@ static void mce_timer_fn(struct timer_list *t)
 
 	iv = __this_cpu_read(mce_next_interval);
 
-	if (mce_available(this_cpu_ptr(&cpu_info))) {
+	if (mce_available(this_cpu_ptr(&cpu_info)))
 		mc_poll_banks();
 
-		if (mce_intel_cmci_poll()) {
-			iv = mce_adjust_timer(iv);
-			goto done;
-		}
-	}
-
 	/*
 	 * Alert userspace if needed. If we logged an MCE, reduce the polling
 	 * interval, otherwise increase the polling interval.
@@ -1655,7 +1642,6 @@ static void mce_timer_fn(struct timer_list *t)
 	else
 		iv = min(iv * 2, round_jiffies_relative(check_interval * HZ));
 
-done:
 	__this_cpu_write(mce_next_interval, iv);
 	__start_timer(t, iv);
 }
@@ -1995,7 +1981,6 @@ static void mce_zhaoxin_feature_init(struct cpuinfo_x86 *c)
 
 	intel_init_cmci();
 	intel_init_lmce();
-	mce_adjust_timer = cmci_intel_adjust_timer;
 }
 
 static void mce_zhaoxin_feature_clear(struct cpuinfo_x86 *c)
@@ -2008,7 +1993,6 @@ static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 	switch (c->x86_vendor) {
 	case X86_VENDOR_INTEL:
 		mce_intel_feature_init(c);
-		mce_adjust_timer = cmci_intel_adjust_timer;
 		break;
 
 	case X86_VENDOR_AMD: {
@@ -2665,8 +2649,6 @@ static void mce_reenable_cpu(void)
 
 static int mce_cpu_dead(unsigned int cpu)
 {
-	mce_intel_hcpu_update(cpu);
-
 	/* intentionally ignoring frozen here */
 	if (!cpuhp_tasks_frozen)
 		cmci_rediscover();
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 52bce533ddcc..fc4ffc434023 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -41,15 +41,6 @@
  */
 static DEFINE_PER_CPU(mce_banks_t, mce_banks_owned);
 
-/*
- * CMCI storm detection backoff counter
- *
- * During storm, we reset this counter to INITIAL_CHECK_INTERVAL in case we've
- * encountered an error. If not, we decrement it by one. We signal the end of
- * the CMCI storm when it reaches 0.
- */
-static DEFINE_PER_CPU(int, cmci_backoff_cnt);
-
 /*
  * cmci_discover_lock protects against parallel discovery attempts
  * which could race against each other.
@@ -64,21 +55,6 @@ static DEFINE_RAW_SPINLOCK(cmci_discover_lock);
 static DEFINE_SPINLOCK(cmci_poll_lock);
 
 #define CMCI_THRESHOLD		1
-#define CMCI_POLL_INTERVAL	(30 * HZ)
-#define CMCI_STORM_INTERVAL	(HZ)
-#define CMCI_STORM_THRESHOLD	15
-
-static DEFINE_PER_CPU(unsigned long, cmci_time_stamp);
-static DEFINE_PER_CPU(unsigned int, cmci_storm_cnt);
-static DEFINE_PER_CPU(unsigned int, cmci_storm_state);
-
-enum {
-	CMCI_STORM_NONE,
-	CMCI_STORM_ACTIVE,
-	CMCI_STORM_SUBSIDED,
-};
-
-static atomic_t cmci_storm_on_cpus;
 
 static int cmci_supported(int *banks)
 {
@@ -134,124 +110,6 @@ static bool lmce_supported(void)
 	return tmp & FEAT_CTL_LMCE_ENABLED;
 }
 
-bool mce_intel_cmci_poll(void)
-{
-	if (__this_cpu_read(cmci_storm_state) == CMCI_STORM_NONE)
-		return false;
-
-	/*
-	 * Reset the counter if we've logged an error in the last poll
-	 * during the storm.
-	 */
-	if (machine_check_poll(0, this_cpu_ptr(&mce_banks_owned)))
-		this_cpu_write(cmci_backoff_cnt, INITIAL_CHECK_INTERVAL);
-	else
-		this_cpu_dec(cmci_backoff_cnt);
-
-	return true;
-}
-
-void mce_intel_hcpu_update(unsigned long cpu)
-{
-	if (per_cpu(cmci_storm_state, cpu) == CMCI_STORM_ACTIVE)
-		atomic_dec(&cmci_storm_on_cpus);
-
-	per_cpu(cmci_storm_state, cpu) = CMCI_STORM_NONE;
-}
-
-static void cmci_toggle_interrupt_mode(bool on)
-{
-	unsigned long flags, *owned;
-	int bank;
-	u64 val;
-
-	raw_spin_lock_irqsave(&cmci_discover_lock, flags);
-	owned = this_cpu_ptr(mce_banks_owned);
-	for_each_set_bit(bank, owned, MAX_NR_BANKS) {
-		rdmsrl(MSR_IA32_MCx_CTL2(bank), val);
-
-		if (on)
-			val |= MCI_CTL2_CMCI_EN;
-		else
-			val &= ~MCI_CTL2_CMCI_EN;
-
-		wrmsrl(MSR_IA32_MCx_CTL2(bank), val);
-	}
-	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
-}
-
-unsigned long cmci_intel_adjust_timer(unsigned long interval)
-{
-	if ((this_cpu_read(cmci_backoff_cnt) > 0) &&
-	    (__this_cpu_read(cmci_storm_state) == CMCI_STORM_ACTIVE)) {
-		mce_notify_irq();
-		return CMCI_STORM_INTERVAL;
-	}
-
-	switch (__this_cpu_read(cmci_storm_state)) {
-	case CMCI_STORM_ACTIVE:
-
-		/*
-		 * We switch back to interrupt mode once the poll timer has
-		 * silenced itself. That means no events recorded and the timer
-		 * interval is back to our poll interval.
-		 */
-		__this_cpu_write(cmci_storm_state, CMCI_STORM_SUBSIDED);
-		if (!atomic_sub_return(1, &cmci_storm_on_cpus))
-			pr_notice("CMCI storm subsided: switching to interrupt mode\n");
-
-		fallthrough;
-
-	case CMCI_STORM_SUBSIDED:
-		/*
-		 * We wait for all CPUs to go back to SUBSIDED state. When that
-		 * happens we switch back to interrupt mode.
-		 */
-		if (!atomic_read(&cmci_storm_on_cpus)) {
-			__this_cpu_write(cmci_storm_state, CMCI_STORM_NONE);
-			cmci_toggle_interrupt_mode(true);
-			cmci_recheck();
-		}
-		return CMCI_POLL_INTERVAL;
-	default:
-
-		/* We have shiny weather. Let the poll do whatever it thinks. */
-		return interval;
-	}
-}
-
-static bool cmci_storm_detect(void)
-{
-	unsigned int cnt = __this_cpu_read(cmci_storm_cnt);
-	unsigned long ts = __this_cpu_read(cmci_time_stamp);
-	unsigned long now = jiffies;
-	int r;
-
-	if (__this_cpu_read(cmci_storm_state) != CMCI_STORM_NONE)
-		return true;
-
-	if (time_before_eq(now, ts + CMCI_STORM_INTERVAL)) {
-		cnt++;
-	} else {
-		cnt = 1;
-		__this_cpu_write(cmci_time_stamp, now);
-	}
-	__this_cpu_write(cmci_storm_cnt, cnt);
-
-	if (cnt <= CMCI_STORM_THRESHOLD)
-		return false;
-
-	cmci_toggle_interrupt_mode(false);
-	__this_cpu_write(cmci_storm_state, CMCI_STORM_ACTIVE);
-	r = atomic_add_return(1, &cmci_storm_on_cpus);
-	mce_timer_kick(CMCI_STORM_INTERVAL);
-	this_cpu_write(cmci_backoff_cnt, INITIAL_CHECK_INTERVAL);
-
-	if (r == 1)
-		pr_notice("CMCI storm detected: switching to poll mode\n");
-	return true;
-}
-
 /*
  * The interrupt handler. This is called on every event.
  * Just call the poller directly to log any events.
@@ -260,9 +118,6 @@ static bool cmci_storm_detect(void)
  */
 static void intel_threshold_interrupt(void)
 {
-	if (cmci_storm_detect())
-		return;
-
 	machine_check_poll(MCP_TIMESTAMP, this_cpu_ptr(&mce_banks_owned));
 }
 
-- 
2.41.0

