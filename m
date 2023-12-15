Return-Path: <linux-kernel+bounces-1261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8923E814C88
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD36F1C2113A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EA83BB29;
	Fri, 15 Dec 2023 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x4BIH5xP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZTrz60FV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2304358AE;
	Fri, 15 Dec 2023 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 15 Dec 2023 16:10:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702656604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vcVVoR+RZFF50yRzXY1sZhrm2rQsd1jYlF45Q+o/krU=;
	b=x4BIH5xPi8S21JxewcuTVB5FQ7vngtJQ5G6En/lNa+Y85RONqurNewm8c2D/abInO33lku
	FU9FXGDWl8BwUZC9MhhfCS8bB0ukknWd5af91kHxfO87rKj/YilAN8shYr/BOPpFFCkAr2
	AN0xCUw0p4wImdDftJ78kqX3xQF5eJnXcFdmGCw2bGMabp+mELtVpsU+0lSlk7jKXv84rP
	Rih6Q+vOSCHWqNcyg5QXJX1o5+0WHkQA7+tHmCCoNm+FszpSzpJLJk/cTw3W5HOk8n5di4
	GESiDDwR01MVAB8QvAuVLmLqfPAQzfrdpAs+61/JOeM6STSWHQ0zG9l4WadN6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702656604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vcVVoR+RZFF50yRzXY1sZhrm2rQsd1jYlF45Q+o/krU=;
	b=ZTrz60FVzInklwW/n8a2qBCx7nSHiAOzVdsYxaQ9KtPTYgBHpHrhBnzaNNvk0Bxt8INovT
	EWIFBqTkVNgorHBw==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Add per-bank CMCI storm mitigation
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231115195450.12963-3-tony.luck@intel.com>
References: <20231115195450.12963-3-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170265660377.398.5708293697259169201.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     7eae17c4add5de46efcca45356388f480103e6d9
Gitweb:        https://git.kernel.org/tip/7eae17c4add5de46efcca45356388f480103e6d9
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 15 Nov 2023 11:54:49 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 15 Dec 2023 14:52:01 +01:00

x86/mce: Add per-bank CMCI storm mitigation

This is the core functionality to track CMCI storms at the machine check
bank granularity. Subsequent patches will add the vendor specific hooks
to supply input to the storm detection and take actions on the start/end
of a storm.

machine_check_poll() is called both by the CMCI interrupt code, and for
periodic polls from a timer. Add a hook in this routine to maintain
a bitmap history for each bank showing whether the bank logged an
corrected error or not each time it is polled.

In normal operation the interval between polls of these banks determines
how far to shift the history. The 64 bit width corresponds to about one
second.

When a storm is observed a CPU vendor specific action is taken to reduce
or stop CMCI from the bank that is the source of the storm.  The bank is
added to the bitmap of banks for this CPU to poll. The polling rate is
increased to once per second.  During a storm each bit in the history
indicates the status of the bank each time it is polled. Thus the
history covers just over a minute.

Declare a storm for that bank if the number of corrected interrupts seen
in that history is above some threshold (defined as 5 in this series,
could be tuned later if there is data to suggest a better value).

A storm on a bank ends if enough consecutive polls of the bank show no
corrected errors (defined as 30, may also change). That calls the CPU
vendor specific function to revert to normal operational mode, and
changes the polling rate back to the default.

  [ bp: Massage. ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231115195450.12963-3-tony.luck@intel.com
---
 arch/x86/kernel/cpu/mce/core.c      |  33 ++++++--
 arch/x86/kernel/cpu/mce/internal.h  |  58 +++++++++++++-
 arch/x86/kernel/cpu/mce/threshold.c | 112 +++++++++++++++++++++++++++-
 3 files changed, 194 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index b2ef487..fd5ce12 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -686,6 +686,16 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		barrier();
 		m.status = mce_rdmsrl(mca_msr_reg(i, MCA_STATUS));
 
+		/*
+		 * Update storm tracking here, before checking for the
+		 * MCI_STATUS_VAL bit. Valid corrected errors count
+		 * towards declaring, or maintaining, storm status. No
+		 * error in a bank counts towards avoiding, or ending,
+		 * storm status.
+		 */
+		if (!mca_cfg.cmci_disabled)
+			mce_track_storm(&m);
+
 		/* If this entry is not valid, ignore it */
 		if (!(m.status & MCI_STATUS_VAL))
 			continue;
@@ -1658,22 +1668,29 @@ static void mce_timer_fn(struct timer_list *t)
 	else
 		iv = min(iv * 2, round_jiffies_relative(check_interval * HZ));
 
-	__this_cpu_write(mce_next_interval, iv);
-	__start_timer(t, iv);
+	if (mce_get_storm_mode()) {
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
+	mce_set_storm_mode(storm);
 
-	if (interval < iv)
-		__this_cpu_write(mce_next_interval, interval);
+	if (storm)
+		__start_timer(t, HZ);
+	else
+		__this_cpu_write(mce_next_interval, check_interval * HZ);
 }
 
 /* Must not be called in IRQ context where del_timer_sync() can deadlock */
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index b18e990..157b2f2 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -56,7 +56,63 @@ static inline bool intel_filter_mce(struct mce *m) { return false; }
 static inline bool intel_mce_usable_address(struct mce *m) { return false; }
 #endif
 
-void mce_timer_kick(unsigned long interval);
+void mce_timer_kick(bool storm);
+
+#ifdef CONFIG_X86_MCE_THRESHOLD
+void cmci_storm_begin(unsigned int bank);
+void cmci_storm_end(unsigned int bank);
+void mce_track_storm(struct mce *mce);
+void mce_inherit_storm(unsigned int bank);
+bool mce_get_storm_mode(void);
+void mce_set_storm_mode(bool storm);
+#else
+static inline void cmci_storm_begin(unsigned int bank) {}
+static inline void cmci_storm_end(unsigned int bank) {}
+static inline void mce_track_storm(struct mce *mce) {}
+static inline void mce_inherit_storm(unsigned int bank) {}
+static inline bool mce_get_storm_mode(void) { return false; }
+static inline void mce_set_storm_mode(bool storm) {}
+#endif
+
+/*
+ * history:		Bitmask tracking errors occurrence. Each set bit
+ *			represents an error seen.
+ *
+ * timestamp:		Last time (in jiffies) that the bank was polled.
+ * in_storm_mode:	Is this bank in storm mode?
+ * poll_only:		Bank does not support CMCI, skip storm tracking.
+ */
+struct storm_bank {
+	u64 history;
+	u64 timestamp;
+	bool in_storm_mode;
+	bool poll_only;
+};
+
+#define NUM_HISTORY_BITS (sizeof(u64) * BITS_PER_BYTE)
+
+/* How many errors within the history buffer mark the start of a storm. */
+#define STORM_BEGIN_THRESHOLD	5
+
+/*
+ * How many polls of machine check bank without an error before declaring
+ * the storm is over. Since it is tracked by the bitmasks in the history
+ * field of struct storm_bank the mask is 30 bits [0 ... 29].
+ */
+#define STORM_END_POLL_THRESHOLD	29
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
+DECLARE_PER_CPU(struct mca_storm_desc, storm_desc);
 
 #ifdef CONFIG_ACPI_APEI
 int apei_write_mce(struct mce *m);
diff --git a/arch/x86/kernel/cpu/mce/threshold.c b/arch/x86/kernel/cpu/mce/threshold.c
index ef4e7bb..0e19884 100644
--- a/arch/x86/kernel/cpu/mce/threshold.c
+++ b/arch/x86/kernel/cpu/mce/threshold.c
@@ -29,3 +29,115 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_threshold)
 	trace_threshold_apic_exit(THRESHOLD_APIC_VECTOR);
 	apic_eoi();
 }
+
+DEFINE_PER_CPU(struct mca_storm_desc, storm_desc);
+
+void mce_inherit_storm(unsigned int bank)
+{
+	struct mca_storm_desc *storm = this_cpu_ptr(&storm_desc);
+
+	/*
+	 * Previous CPU owning this bank had put it into storm mode,
+	 * but the precise history of that storm is unknown. Assume
+	 * the worst (all recent polls of the bank found a valid error
+	 * logged). This will avoid the new owner prematurely declaring
+	 * the storm has ended.
+	 */
+	storm->banks[bank].history = ~0ull;
+	storm->banks[bank].timestamp = jiffies;
+}
+
+bool mce_get_storm_mode(void)
+{
+	return __this_cpu_read(storm_desc.poll_mode);
+}
+
+void mce_set_storm_mode(bool storm)
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
+	storm->banks[bank].in_storm_mode = true;
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
+	storm->banks[bank].in_storm_mode = false;
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
+	/* No tracking needed for banks that do not support CMCI */
+	if (storm->banks[mce->bank].poll_only)
+		return;
+
+	/*
+	 * When a bank is in storm mode it is polled once per second and
+	 * the history mask will record about the last minute of poll results.
+	 * If it is not in storm mode, then the bank is only checked when
+	 * there is a CMCI interrupt. Check how long it has been since
+	 * this bank was last checked, and adjust the amount of "shift"
+	 * to apply to history.
+	 */
+	if (!storm->banks[mce->bank].in_storm_mode) {
+		delta = now - storm->banks[mce->bank].timestamp;
+		shift = (delta + HZ) / HZ;
+	}
+
+	/* If it has been a long time since the last poll, clear history. */
+	if (shift < NUM_HISTORY_BITS)
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
+	if (storm->banks[mce->bank].in_storm_mode) {
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

