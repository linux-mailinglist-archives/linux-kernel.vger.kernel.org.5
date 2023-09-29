Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7557B3B09
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 22:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbjI2UOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 16:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbjI2UNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 16:13:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97861DE;
        Fri, 29 Sep 2023 13:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696018433; x=1727554433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r9Y1nm7ako9u8ZWyJ5Uv1/Q78sCXkVFxKSkSwbn7zu4=;
  b=afhx60Ejy0UL3Iwk+VdswT6uY6rynIVDHDwAcDoKmzOk220TGZBA9ZQG
   0MDT+ZVzc3yogaVx8tr5N5u8MtC40jn8OymBKIyPdMLwE9h779qNWgbaB
   qhL/lLTSd2MFOWQN3zXD12eA75evuXwrNAubLc+7TLYNFj2EcR9oMkbHv
   6eA/uOs+5fg215bYX4NUPwslzg+3duisi/nK77geH83HzfIGPtwiJfHIW
   qw/xiNGwPiBf8oTPtevUq6DUosqJpGAwnd1vTKurytqjUTBJrqvaVqq/i
   btmHw6RVcrXru6Wvc6dy9qxWADcExXak2Ngd7dGOIjWZbSLFohJSUAk0V
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="362604245"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="362604245"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 11:16:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="921798"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 11:16:37 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v8 2/3] x86/mce: Add per-bank CMCI storm mitigation
Date:   Fri, 29 Sep 2023 11:16:25 -0700
Message-ID: <20230929181626.210782-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230929181626.210782-1-tony.luck@intel.com>
References: <20230718210813.291190-1-tony.luck@intel.com>
 <20230929181626.210782-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

Updated with review comments from Yazen.
Link: https://lore.kernel.org/r/c76723df-f2f1-4888-9e05-61917145503c@amd.com

Signed-off-by: Tony Luck <tony.luck@intel.com>
---

Note that the storm begin/end warnings are now printed using
printk_deferred(KERN_NOTICE ...) instead of pr_notice. This
is my solution for a locking issue when in poll mode because
of the "cmci_poll_lock" introduced by:

commit c3629dd7e67d ("x86/mce: Prevent duplicate error records")

Is this the right way to handle this?


 arch/x86/kernel/cpu/mce/internal.h  | 39 +++++++++++++-
 arch/x86/kernel/cpu/mce/core.c      | 25 ++++++---
 arch/x86/kernel/cpu/mce/threshold.c | 83 +++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 616732ec16f7..5e75f5f81464 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -54,7 +54,44 @@ static inline void intel_clear_lmce(void) { }
 static inline bool intel_filter_mce(struct mce *m) { return false; }
 #endif
 
-void mce_timer_kick(unsigned long interval);
+void mce_timer_kick(bool storm);
+void cmci_storm_begin(unsigned int bank);
+void cmci_storm_end(unsigned int bank);
+void mce_track_storm(struct mce *mce);
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
+DECLARE_PER_CPU(struct mca_storm_desc, storm_desc);
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
index f6e87443b37a..fccbf4a7e783 100644
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
+	if (__this_cpu_read(storm_desc.poll_mode)) {
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
+	__this_cpu_write(storm_desc.poll_mode, storm);
 
-	if (interval < iv)
-		__this_cpu_write(mce_next_interval, interval);
+	if (storm)
+		__start_timer(t, HZ);
+	else
+		__this_cpu_write(mce_next_interval, check_interval * HZ);
 }
 
 /* Must not be called in IRQ context where del_timer_sync() can deadlock */
diff --git a/arch/x86/kernel/cpu/mce/threshold.c b/arch/x86/kernel/cpu/mce/threshold.c
index ef4e7bb5fd88..c9e32d92cf8f 100644
--- a/arch/x86/kernel/cpu/mce/threshold.c
+++ b/arch/x86/kernel/cpu/mce/threshold.c
@@ -29,3 +29,86 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_threshold)
 	trace_threshold_apic_exit(THRESHOLD_APIC_VECTOR);
 	apic_eoi();
 }
+
+DEFINE_PER_CPU(struct mca_storm_desc, storm_desc);
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

