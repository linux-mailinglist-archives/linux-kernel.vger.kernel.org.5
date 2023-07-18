Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C02475868A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 23:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjGRVJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 17:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjGRVJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 17:09:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A600EC;
        Tue, 18 Jul 2023 14:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689714542; x=1721250542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QzvGj65Fpudi2h1UCS8VtTbgD9FJCdQ0vtr8zlVjwU4=;
  b=D8qaBaH+YKwMEbDzpu86H7fuP0PGLdl4P7qTolKDHKraObiFwYt8zbt/
   fxtbuEoVwyLqgo00psGlACyzbMVt/SiHvjbnLpGa4kTwyR/fIINeb3LO1
   A2fwTTuDXuh85HhWQY2esVEOvgi2qIcvz5luugBSEdFYixf7i/8w4KCCG
   ixNqHcfOtQg97BTqSkIc5UwXQw4qJlobDM01ae4hlM9nl7uyHvGZcBQYn
   LyV/izbImtYM2+u5z3OikOgk6Are9DxetvG9H/cCyFj4UyIuKnd6BFTeb
   dBlZLLHuffZMkdweEF5HNYM2voDco9O/8I8yefXVqruwO7HIRIYRonZ7W
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="369872208"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="369872208"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 14:08:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="813897798"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="813897798"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 14:08:58 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v7 2/3] x86/mce: Add per-bank CMCI storm mitigation
Date:   Tue, 18 Jul 2023 14:08:12 -0700
Message-Id: <20230718210813.291190-3-tony.luck@intel.com>
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
 arch/x86/kernel/cpu/mce/internal.h |  41 ++++++++++-
 arch/x86/kernel/cpu/mce/core.c     | 108 ++++++++++++++++++++++++++---
 2 files changed, 140 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 9dcad55835fa..da790d13d010 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -54,7 +54,46 @@ static inline void intel_clear_lmce(void) { }
 static inline bool intel_filter_mce(struct mce *m) { return false; }
 #endif
 
-void mce_timer_kick(unsigned long interval);
+void mce_timer_kick(bool storm);
+void mce_handle_storm(int bank, bool on);
+void cmci_storm_begin(int bank);
+void cmci_storm_end(int bank);
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
+	int			stormy_bank_count;
+	bool			poll_mode;
+};
+DECLARE_PER_CPU(struct mca_storm_desc, storm_desc);
+
+/*
+ * How many errors within the history buffer mark the start of a storm
+ */
+#define STORM_BEGIN_THRESHOLD	5
+
+/*
+ * How many polls of machine check bank without an error before declaring
+ * the storm is over. Since it is tracked by the bitmaks in the history
+ * field of struct storm_bank the mask is 30 bits [0 ... 29]
+ */
+#define STORM_END_POLL_THRESHOLD	29
 
 #ifdef CONFIG_ACPI_APEI
 int apei_write_mce(struct mce *m);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index b45c5008df34..6a44e15d74fe 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -607,6 +607,83 @@ static struct notifier_block mce_default_nb = {
 	.priority	= MCE_PRIO_LOWEST,
 };
 
+DEFINE_PER_CPU(struct mca_storm_desc, storm_desc);
+
+void cmci_storm_begin(int bank)
+{
+	struct mca_storm_desc *storm = this_cpu_ptr(&storm_desc);
+
+	__set_bit(bank, this_cpu_ptr(mce_poll_banks));
+	storm->banks[bank].storm = true;
+
+	/*
+	 * If this is the first bank on this CPU to enter storm mode
+	 * start polling
+	 */
+	if (++storm->stormy_bank_count == 1)
+		mce_timer_kick(true);
+}
+
+void cmci_storm_end(int bank)
+{
+	struct mca_storm_desc *storm = this_cpu_ptr(&storm_desc);
+
+	__clear_bit(bank, this_cpu_ptr(mce_poll_banks));
+	storm->banks[bank].history = 0ull;
+	storm->banks[bank].storm = false;
+
+	/* If no banks left in storm mode, stop polling */
+	if (!this_cpu_dec_return(storm_desc.stormy_bank_count))
+		mce_timer_kick(false);
+}
+
+static void track_storm(int bank, u64 status)
+{
+	struct mca_storm_desc *storm = this_cpu_ptr(&storm_desc);
+	unsigned long now = jiffies, delta;
+	unsigned int shift = 1;
+	u64 history;
+
+	/*
+	 * When a bank is in storm mode it is polled once per second and
+	 * the history mask will record about the last minute of poll results.
+	 * If it is not in storm mode, then the bank is only checked when
+	 * there is a CMCI interrupt. Check how long it has been since
+	 * this bank was last checked, and adjust the amount of "shift"
+	 * to apply to history.
+	 */
+	if (!storm->banks[bank].storm) {
+		delta = now - storm->banks[bank].timestamp;
+		shift = (delta + HZ) / HZ;
+	}
+
+	/* If has been a long time since the last poll, clear history */
+	if (shift >= 64)
+		history = 0;
+	else
+		history = storm->banks[bank].history << shift;
+	storm->banks[bank].timestamp = now;
+
+	/* History keeps track of corrected errors. VAL=1 && UC=0 */
+	if ((status & (MCI_STATUS_VAL | MCI_STATUS_UC)) == MCI_STATUS_VAL)
+		history |= 1;
+	storm->banks[bank].history = history;
+
+	if (storm->banks[bank].storm) {
+		if (history & GENMASK_ULL(STORM_END_POLL_THRESHOLD, 0))
+			return;
+		pr_notice("CPU%d BANK%d CMCI storm subsided\n", smp_processor_id(), bank);
+		mce_handle_storm(bank, false);
+		cmci_storm_end(bank);
+	} else {
+		if (hweight64(history) < STORM_BEGIN_THRESHOLD)
+			return;
+		pr_notice("CPU%d BANK%d CMCI storm detected\n", smp_processor_id(), bank);
+		mce_handle_storm(bank, true);
+		cmci_storm_begin(bank);
+	}
+}
+
 /*
  * Read ADDR and MISC registers.
  */
@@ -680,6 +757,8 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		barrier();
 		m.status = mce_rdmsrl(mca_msr_reg(i, MCA_STATUS));
 
+		track_storm(i, m.status);
+
 		/* If this entry is not valid, ignore it */
 		if (!(m.status & MCI_STATUS_VAL))
 			continue;
@@ -1622,22 +1701,29 @@ static void mce_timer_fn(struct timer_list *t)
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
@@ -1965,6 +2051,12 @@ static void mce_zhaoxin_feature_clear(struct cpuinfo_x86 *c)
 	intel_clear_lmce();
 }
 
+void mce_handle_storm(int bank, bool on)
+{
+	switch (boot_cpu_data.x86_vendor) {
+	}
+}
+
 static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 {
 	switch (c->x86_vendor) {
-- 
2.40.1

