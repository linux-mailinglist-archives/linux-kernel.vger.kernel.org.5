Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364767B8AB0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244519AbjJDSiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244470AbjJDSiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:38:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05379C6;
        Wed,  4 Oct 2023 11:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696444677; x=1727980677;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3JOcCyKJEBU3Z15X3+uV8egNcpc2HjfwPLBRmA4tnvI=;
  b=l6zZmj2cHq0Y5Aq5d2MXQQtLB1DjPKAMYXGVX9UxUjv2zEmAb2/rFxKV
   GM451g/X3T67AgXzDc4fWy9+mzwjeOGfJ8q4uNcIxR2m4LRHgk4v+4Kex
   JasgkLFPEtk3qVJWXRrGkJO8th931BU7LatxS5HblKM7zxkXH027o2qNy
   Q9/QlYkj4s78615ebiSrp/rNm01Q/QGrEI3JO+oq2PkrBd1Jx8rn96kYb
   wgDYrpx5Dl4qmhxC91g9hHgP9kZKanTYCIegFt+hJoHskaGGbxJvruNHU
   ckmeP2qu1PP4B3QqKCAbapY5ZCvCfjpEYLviB+DBE7IsHiAdyWNydZcbK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="387133515"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="387133515"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 11:36:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="701236056"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="701236056"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 11:36:32 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v9 2/3] x86/mce: Add per-bank CMCI storm mitigation
Date:   Wed,  4 Oct 2023 11:36:22 -0700
Message-ID: <20231004183623.17067-3-tony.luck@intel.com>
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

This is the core functionality to track CMCI storms at the
machine check bank granularity. Subsequent patches will add
the vendor specific hooks to supply input to the storm
detection and take actions on the start/end of a storm.

Maintain a bitmap history for each bank showing whether the bank
logged an corrected error or not each time it is polled.

In normal operation the interval between polls of this banks
determines how far to shift the history. The 64 bit width corresponds
to about one second.

When a storm is observed a CPU vendor specific action is taken to reduce
or stop CMCI from the bank that is the source of the storm.  The bank
is added to the bitmap of banks for this CPU to poll. The polling rate
is increased to once per second.  During a storm each bit in the history
indicates the status of the bank each time it is polled. Thus the history
covers just over a minute.

Declare a storm for that bank if the number of corrected interrupts
seen in that history is above some threshold (defined as 5 in this
series, could be tuned later if there is data to suggest a better
value).

A storm on a bank ends if enough consecutive polls of the bank show
no corrected errors (defined as 30, may also change). That calls the
CPU vendor specific function to revert to normal operational mode,
and changes the polling rate back to the default.

Signed-off-by: Tony Luck <tony.luck@intel.com>

---
v8: Updated with review comments from Yazen.
    Link: https://lore.kernel.org/r/c76723df-f2f1-4888-9e05-61917145503c@amd.com
v9: Fix lkp randconfig build issue when neither INTEL nor AMD configured
---
 arch/x86/kernel/cpu/mce/internal.h  |  40 +++++++++-
 arch/x86/kernel/cpu/mce/core.c      |  25 +++++--
 arch/x86/kernel/cpu/mce/threshold.c | 112 ++++++++++++++++++++++++++++
 3 files changed, 168 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 616732ec16f7..4aa957442c8d 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -54,7 +54,45 @@ static inline void intel_clear_lmce(void) { }
 static inline bool intel_filter_mce(struct mce *m) { return false; }
 #endif
 
-void mce_timer_kick(unsigned long interval);
+void mce_timer_kick(bool storm);
+
+#ifdef CONFIG_X86_MCE_THRESHOLD
+void cmci_storm_begin(unsigned int bank);
+void cmci_storm_end(unsigned int bank);
+void mce_track_storm(struct mce *mce);
+void mce_inherit_storm(unsigned int bank);
+bool mce_is_storm(void);
+void mce_set_storm(bool storm);
+#else
+static inline void cmci_storm_begin(unsigned int bank) {}
+static inline void cmci_storm_end(unsigned int bank) {}
+static inline void mce_track_storm(struct mce *mce) {}
+static inline void mce_inherit_storm(unsigned int bank) {}
+static inline bool mce_is_storm(void) { return false; }
+static inline void mce_set_storm(bool storm) {}
+#endif
+
+/*
+ * history:	bitmask tracking whether errors were seen or not seen in
+ *		the most recent polls of a bank.
+ * timestamp:	last time (in jiffies) that the bank was polled
+ * storm:	Is this bank in storm mode?
+ */
+struct storm_bank {
+	u64 history;
+	u64 timestamp;
+	bool storm;
+};
+
+/* How many errors within the history buffer mark the start of a storm. */
+#define STORM_BEGIN_THRESHOLD	5
+
+/*
+ * How many polls of machine check bank without an error before declaring
+ * the storm is over. Since it is tracked by the bitmaks in the history
+ * field of struct storm_bank the mask is 30 bits [0 ... 29].
+ */
+#define STORM_END_POLL_THRESHOLD	29
 
 #ifdef CONFIG_ACPI_APEI
 int apei_write_mce(struct mce *m);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index f6e87443b37a..7c931f0c9251 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -680,6 +680,8 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		barrier();
 		m.status = mce_rdmsrl(mca_msr_reg(i, MCA_STATUS));
 
+		mce_track_storm(&m);
+
 		/* If this entry is not valid, ignore it */
 		if (!(m.status & MCI_STATUS_VAL))
 			continue;
@@ -1652,22 +1654,29 @@ static void mce_timer_fn(struct timer_list *t)
 	else
 		iv = min(iv * 2, round_jiffies_relative(check_interval * HZ));
 
-	__this_cpu_write(mce_next_interval, iv);
-	__start_timer(t, iv);
+	if (mce_is_storm()) {
+		__start_timer(t, HZ);
+	} else {
+		__this_cpu_write(mce_next_interval, iv);
+		__start_timer(t, iv);
+	}
 }
 
 /*
- * Ensure that the timer is firing in @interval from now.
+ * When a storm starts on any bank on this CPU, switch to polling
+ * once per second. When the storm ends, revert to the default
+ * polling interval.
  */
-void mce_timer_kick(unsigned long interval)
+void mce_timer_kick(bool storm)
 {
 	struct timer_list *t = this_cpu_ptr(&mce_timer);
-	unsigned long iv = __this_cpu_read(mce_next_interval);
 
-	__start_timer(t, interval);
+	mce_set_storm(storm);
 
-	if (interval < iv)
-		__this_cpu_write(mce_next_interval, interval);
+	if (storm)
+		__start_timer(t, HZ);
+	else
+		__this_cpu_write(mce_next_interval, check_interval * HZ);
 }
 
 /* Must not be called in IRQ context where del_timer_sync() can deadlock */
diff --git a/arch/x86/kernel/cpu/mce/threshold.c b/arch/x86/kernel/cpu/mce/threshold.c
index ef4e7bb5fd88..ecdf13f1bb7d 100644
--- a/arch/x86/kernel/cpu/mce/threshold.c
+++ b/arch/x86/kernel/cpu/mce/threshold.c
@@ -29,3 +29,115 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_threshold)
 	trace_threshold_apic_exit(THRESHOLD_APIC_VECTOR);
 	apic_eoi();
 }
+
+/*
+ * banks:		per-cpu, per-bank details
+ * stormy_bank_count:	count of MC banks in storm state
+ * poll_mode:		CPU is in poll mode
+ */
+struct mca_storm_desc {
+	struct storm_bank	banks[MAX_NR_BANKS];
+	u8			stormy_bank_count;
+	bool			poll_mode;
+};
+
+static DEFINE_PER_CPU(struct mca_storm_desc, storm_desc);
+
+void mce_inherit_storm(unsigned int bank)
+{
+	struct mca_storm_desc *storm = this_cpu_ptr(&storm_desc);
+
+	storm->banks[bank].history = ~0ull;
+	storm->banks[bank].timestamp = jiffies;
+}
+
+bool mce_is_storm(void)
+{
+	return __this_cpu_read(storm_desc.poll_mode);
+}
+
+void mce_set_storm(bool storm)
+{
+	__this_cpu_write(storm_desc.poll_mode, storm);
+}
+
+static void mce_handle_storm(unsigned int bank, bool on)
+{
+	switch (boot_cpu_data.x86_vendor) {
+	}
+}
+
+void cmci_storm_begin(unsigned int bank)
+{
+	struct mca_storm_desc *storm = this_cpu_ptr(&storm_desc);
+
+	__set_bit(bank, this_cpu_ptr(mce_poll_banks));
+	storm->banks[bank].storm = true;
+
+	/*
+	 * If this is the first bank on this CPU to enter storm mode
+	 * start polling.
+	 */
+	if (++storm->stormy_bank_count == 1)
+		mce_timer_kick(true);
+}
+
+void cmci_storm_end(unsigned int bank)
+{
+	struct mca_storm_desc *storm = this_cpu_ptr(&storm_desc);
+
+	__clear_bit(bank, this_cpu_ptr(mce_poll_banks));
+	storm->banks[bank].history = 0;
+	storm->banks[bank].storm = false;
+
+	/* If no banks left in storm mode, stop polling. */
+	if (!this_cpu_dec_return(storm_desc.stormy_bank_count))
+		mce_timer_kick(false);
+}
+
+void mce_track_storm(struct mce *mce)
+{
+	struct mca_storm_desc *storm = this_cpu_ptr(&storm_desc);
+	unsigned long now = jiffies, delta;
+	unsigned int shift = 1;
+	u64 history = 0;
+
+	/*
+	 * When a bank is in storm mode it is polled once per second and
+	 * the history mask will record about the last minute of poll results.
+	 * If it is not in storm mode, then the bank is only checked when
+	 * there is a CMCI interrupt. Check how long it has been since
+	 * this bank was last checked, and adjust the amount of "shift"
+	 * to apply to history.
+	 */
+	if (!storm->banks[mce->bank].storm) {
+		delta = now - storm->banks[mce->bank].timestamp;
+		shift = (delta + HZ) / HZ;
+	}
+
+	/* If it has been a long time since the last poll, clear history. */
+	if (shift < 64)
+		history = storm->banks[mce->bank].history << shift;
+
+	storm->banks[mce->bank].timestamp = now;
+
+	/* History keeps track of corrected errors. VAL=1 && UC=0 */
+	if ((mce->status & MCI_STATUS_VAL) && mce_is_correctable(mce))
+		history |= 1;
+
+	storm->banks[mce->bank].history = history;
+
+	if (storm->banks[mce->bank].storm) {
+		if (history & GENMASK_ULL(STORM_END_POLL_THRESHOLD, 0))
+			return;
+		printk_deferred(KERN_NOTICE "CPU%d BANK%d CMCI storm subsided\n", smp_processor_id(), mce->bank);
+		mce_handle_storm(mce->bank, false);
+		cmci_storm_end(mce->bank);
+	} else {
+		if (hweight64(history) < STORM_BEGIN_THRESHOLD)
+			return;
+		printk_deferred(KERN_NOTICE "CPU%d BANK%d CMCI storm detected\n", smp_processor_id(), mce->bank);
+		mce_handle_storm(mce->bank, true);
+		cmci_storm_begin(mce->bank);
+	}
+}
-- 
2.41.0

