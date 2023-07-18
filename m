Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED48758688
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 23:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjGRVJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 17:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjGRVJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 17:09:03 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6F21995;
        Tue, 18 Jul 2023 14:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689714541; x=1721250541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7OOWHj6sUN3hPV/Uwfs3P9eHhLNlbFi1NIi6u5rm7jE=;
  b=QPH9FpLV59n8LIcPExqHUKK0uiJ0Rpq23DQkiKw5zWbjWM01XHvPmYIK
   mawT9kgazM+gPT78GHjcJ9lmuyulAwpnh4+lEggdDgjZwpU96O3eDyeXM
   TY4n/VsTA/N+VvasPnxU9Cgn57zJLg3g9h4/ffxyAaxr32YUxOyffJQsX
   1CVCKG7TCNXUDumhR1lElDLT3N8AwNfSSqai+iZVhXOET0/P79V70Ve6j
   ZmSqTSWBf+0IOONNwhby6CJTH9NasOSaDjwn0fIRpCE0L5GP2aCFqHYfH
   N/V3jJY/bmHnwrtoOerwyGRRqEFAN7C3BqRX8QdjJfM+hHj8j0D32+c+o
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="369872203"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="369872203"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 14:08:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="813897795"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="813897795"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 14:08:58 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v7 1/3] x86/mce: Remove old CMCI storm mitigation code
Date:   Tue, 18 Jul 2023 14:08:11 -0700
Message-Id: <20230718210813.291190-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230718210813.291190-1-tony.luck@intel.com>
References: <20230616182744.17632-1-tony.luck@intel.com>
 <20230718210813.291190-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index d2412ce2d312..9dcad55835fa 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -41,18 +41,12 @@ struct dentry *mce_get_debugfs_dir(void);
 extern mce_banks_t mce_banks_ce_disabled;
 
 #ifdef CONFIG_X86_MCE_INTEL
-unsigned long cmci_intel_adjust_timer(unsigned long interval);
-bool mce_intel_cmci_poll(void);
-void mce_intel_hcpu_update(unsigned long cpu);
 void cmci_disable_bank(int bank);
 void intel_init_cmci(void);
 void intel_init_lmce(void);
 void intel_clear_lmce(void);
 bool intel_filter_mce(struct mce *m);
 #else
-# define cmci_intel_adjust_timer mce_adjust_timer_default
-static inline bool mce_intel_cmci_poll(void) { return false; }
-static inline void mce_intel_hcpu_update(unsigned long cpu) { }
 static inline void cmci_disable_bank(int bank) { }
 static inline void intel_init_cmci(void) { }
 static inline void intel_init_lmce(void) { }
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 89e2aab5d34d..b45c5008df34 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1588,13 +1588,6 @@ static unsigned long check_interval = INITIAL_CHECK_INTERVAL;
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
@@ -1617,15 +1610,9 @@ static void mce_timer_fn(struct timer_list *t)
 
 	iv = __this_cpu_read(mce_next_interval);
 
-	if (mce_available(this_cpu_ptr(&cpu_info))) {
+	if (mce_available(this_cpu_ptr(&cpu_info)))
 		machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
 
-		if (mce_intel_cmci_poll()) {
-			iv = mce_adjust_timer(iv);
-			goto done;
-		}
-	}
-
 	/*
 	 * Alert userspace if needed. If we logged an MCE, reduce the polling
 	 * interval, otherwise increase the polling interval.
@@ -1635,7 +1622,6 @@ static void mce_timer_fn(struct timer_list *t)
 	else
 		iv = min(iv * 2, round_jiffies_relative(check_interval * HZ));
 
-done:
 	__this_cpu_write(mce_next_interval, iv);
 	__start_timer(t, iv);
 }
@@ -1972,7 +1958,6 @@ static void mce_zhaoxin_feature_init(struct cpuinfo_x86 *c)
 
 	intel_init_cmci();
 	intel_init_lmce();
-	mce_adjust_timer = cmci_intel_adjust_timer;
 }
 
 static void mce_zhaoxin_feature_clear(struct cpuinfo_x86 *c)
@@ -1985,7 +1970,6 @@ static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 	switch (c->x86_vendor) {
 	case X86_VENDOR_INTEL:
 		mce_intel_feature_init(c);
-		mce_adjust_timer = cmci_intel_adjust_timer;
 		break;
 
 	case X86_VENDOR_AMD: {
@@ -2642,8 +2626,6 @@ static void mce_reenable_cpu(void)
 
 static int mce_cpu_dead(unsigned int cpu)
 {
-	mce_intel_hcpu_update(cpu);
-
 	/* intentionally ignoring frozen here */
 	if (!cpuhp_tasks_frozen)
 		cmci_rediscover();
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 95275a5e57e0..052bf2708391 100644
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
@@ -57,21 +48,6 @@ static DEFINE_PER_CPU(int, cmci_backoff_cnt);
 static DEFINE_RAW_SPINLOCK(cmci_discover_lock);
 
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
@@ -127,124 +103,6 @@ static bool lmce_supported(void)
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
@@ -253,9 +111,6 @@ static bool cmci_storm_detect(void)
  */
 static void intel_threshold_interrupt(void)
 {
-	if (cmci_storm_detect())
-		return;
-
 	machine_check_poll(MCP_TIMESTAMP, this_cpu_ptr(&mce_banks_owned));
 }
 
-- 
2.40.1

