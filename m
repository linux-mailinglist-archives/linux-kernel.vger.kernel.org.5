Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE477CBA17
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 07:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbjJQFZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 01:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbjJQFZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 01:25:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09146D60;
        Mon, 16 Oct 2023 22:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697520307; x=1729056307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=CQh+bZwgm8XQjgey0Vkw8VOLhpnt8WUpS87zpwPo/+4=;
  b=QW2al59wTJUCIautj6v0BYFMGz+G3zdhTxyKcw8/wwgod0gvPgIMp7de
   dVSLpKQDRikKdWluyDQaiHcJ0aklp39GgJqkkLrUSYI3jQocwqMyw/H5b
   jS0LnJIz7maBmIYD3iJ7/sjrSf7/G7SeSASnXqdIrBsUrpYeeq5j0ZTYq
   V3s9WnNCdFmUWEX9FFnUWwZEjecElm6Rn4Cj8dfdOHYv1FsyAQbnc9h0V
   v0Avn9MDGYKk0C5M7UsGmFGcHqf1j38Re4OjP5R9Mlyvcfg4EBqYXXR1X
   /2MJteiGP1c8YpiRQ7A2tO2iu52L9lLeZy/RCNhqd0fl4NJpnplwpxRB1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="388561724"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="388561724"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 22:25:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="1087357980"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="1087357980"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga005.fm.intel.com with ESMTP; 16 Oct 2023 22:25:02 -0700
From:   lakshmi.sowjanya.d@intel.com
To:     tglx@linutronix.de, jstultz@google.com, giometti@enneenne.com,
        corbet@lwn.net, linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, eddie.dong@intel.com,
        christopher.s.hall@intel.com, pandith.n@intel.com,
        mallikarjunappa.sangannavar@intel.com, thejesh.reddy.t.r@intel.com,
        lakshmi.sowjanya.d@intel.com
Subject: [PATCH v1 1/6] kernel/time: Add system time to system counter conversion
Date:   Tue, 17 Oct 2023 10:54:52 +0530
Message-Id: <20231017052457.25287-2-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231017052457.25287-1-lakshmi.sowjanya.d@intel.com>
References: <20231017052457.25287-1-lakshmi.sowjanya.d@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>

Support system-clock to system-counter conversion. Intel Timed IO
hardware, using system counter as reference to schedule events.

Co-developed-by: Christopher Hall <christopher.s.hall@intel.com>
Signed-off-by: Christopher Hall <christopher.s.hall@intel.com>
Co-developed-by: Pandith N <pandith.n@intel.com>
Signed-off-by: Pandith N <pandith.n@intel.com>
Co-developed-by: Thejesh Reddy T R <thejesh.reddy.t.r@intel.com>
Signed-off-by: Thejesh Reddy T R <thejesh.reddy.t.r@intel.com>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Reviewed-by: Eddie Dong <eddie.dong@intel.com>
---
 include/linux/timekeeping.h |  3 +++
 kernel/time/timekeeping.c   | 54 +++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index fe1e467ba046..e5eb6699d691 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -289,6 +289,9 @@ extern int get_device_system_crosststamp(
 			struct system_time_snapshot *history,
 			struct system_device_crosststamp *xtstamp);
 
+extern int ktime_convert_real_to_system_counter(ktime_t sys_realtime,
+						struct system_counterval_t *ret);
+
 /*
  * Simultaneously snapshot realtime and monotonic raw clocks
  */
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 266d02809dbb..ff6a4c7387ee 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -371,6 +371,19 @@ static void tk_setup_internals(struct timekeeper *tk, struct clocksource *clock)
 
 /* Timekeeper helper functions. */
 
+static inline int timekeeping_ns_to_delta(const struct tk_read_base *tkr, u64 nsec,
+					  u64 *cycles)
+{
+	if (BITS_TO_BYTES(fls64(nsec) + tkr->shift) > sizeof(nsec))
+		return -ERANGE;
+
+	*cycles = nsec << tkr->shift;
+	*cycles -= tkr->xtime_nsec;
+	do_div(*cycles, tkr->mult);
+
+	return 0;
+}
+
 static inline u64 timekeeping_delta_to_ns(const struct tk_read_base *tkr, u64 delta)
 {
 	u64 nsec;
@@ -1303,6 +1316,47 @@ int get_device_system_crosststamp(int (*get_time_fn)
 }
 EXPORT_SYMBOL_GPL(get_device_system_crosststamp);
 
+/**
+ * ktime_convert_real_to_system_counter - Convert system time to system counter
+ * value
+ * @sys_realtime:	realtime clock value to convert
+ * @ret:		Computed system counter value with clocksource pointer
+ *
+ * Converts a supplied, future realtime clock value to the corresponding
+ * system counter value.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int ktime_convert_real_to_system_counter(ktime_t sys_realtime,
+					 struct system_counterval_t *ret)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+	ktime_t base_real;
+	unsigned int seq;
+	u64 ns_delta;
+	int err;
+
+	do {
+		seq = read_seqcount_begin(&tk_core.seq);
+
+		base_real = ktime_add(tk->tkr_mono.base,
+				      tk_core.timekeeper.offs_real);
+		if (ktime_compare(sys_realtime, base_real) < 0)
+			return -EINVAL;
+
+		ret->cs = tk->tkr_mono.clock;
+		ns_delta = ktime_to_ns(ktime_sub(sys_realtime, base_real));
+		err = timekeeping_ns_to_delta(&tk->tkr_mono, ns_delta, &ret->cycles);
+		if (err < 0)
+			return err;
+
+		ret->cycles += tk->tkr_mono.cycle_last;
+	} while (read_seqcount_retry(&tk_core.seq, seq));
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ktime_convert_real_to_system_counter);
+
 /**
  * do_settimeofday64 - Sets the time of day.
  * @ts:     pointer to the timespec64 variable containing the new time
-- 
2.17.1

