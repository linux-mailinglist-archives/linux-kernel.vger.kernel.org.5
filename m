Return-Path: <linux-kernel+bounces-35203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18ED4838D86
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E2021C215DC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601FD5D91C;
	Tue, 23 Jan 2024 11:34:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CBE5D749;
	Tue, 23 Jan 2024 11:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706009682; cv=none; b=iFY1bT1xpVBygSCRctuJJDJWBlBqrb5Zak2Io0hXrcdKIk1Y6BR+KF3TEw1nDaOUXQo4bBdWvC2vMeSRmOSRln3rRWUTtUTpFfUutl656Fz0W/9krIpyaWq1BJKxE76vwFkDhi27pS+f5YF4OVt6p8+uhgrcGJDNKXHUt3qVwoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706009682; c=relaxed/simple;
	bh=Cc/p6EAOGiTANpj0L+SitTQEdRt/dqFYisZ1hnh761s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qips+1bHNsmBaboPYl1YvGnc+skPw0CeMHBBWvPKgzQKvsGSVnnvxAJRmarWQaSzgq1f6schv4cfBEJxXtzn/zGXUMJgsbYBVWnDwsywiwBn3lIH7qvzuH0YTVCRC8o6bk17WHFk2H+qnQUl3oyvPj+1tcy7iiXEQ/R43X5GswI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A9B6FEC;
	Tue, 23 Jan 2024 03:35:25 -0800 (PST)
Received: from e126817.. (e126817.cambridge.arm.com [10.2.3.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0CE1C3F762;
	Tue, 23 Jan 2024 03:34:37 -0800 (PST)
From: Ben Gainey <ben.gainey@arm.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	will@kernel.org,
	Ben Gainey <ben.gainey@arm.com>
Subject: [RFC PATCH 1/2] arm_pmu: Allow the PMU to alternate between two sample_period values.
Date: Tue, 23 Jan 2024 11:34:19 +0000
Message-ID: <20240123113420.1928154-2-ben.gainey@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123113420.1928154-1-ben.gainey@arm.com>
References: <20240123113420.1928154-1-ben.gainey@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arm PMU does not provide any mechanism for decoupling the period over
which counters are counted from the period between samples. This is
problematic for building a tool to measure per-function metrics derived
from a sampled counter group. Ideally such a tool wants a very small
sample window in order to correctly attribute the metrics to a given
function, but prefers a larger sample period that provides representative
coverage without excessive probe effect, triggering throttling, or
generating excessive amounts of data.

By alternating between a long and short sample_period and subsequently
discarding the long samples, tools may decouple the period between
samples that the tool cares about from the window of time over which
interesting counts are collected.

It is expected that typically tools would use this feature with the
cycles or instructions events as an approximation for time, but no
restrictions are applied to which events this can be applied to.

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
---
 drivers/perf/arm_pmu.c       | 74 +++++++++++++++++++++++++++++-------
 include/linux/perf/arm_pmu.h |  1 +
 include/linux/perf_event.h   | 10 ++++-
 3 files changed, 70 insertions(+), 15 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 8458fe2cebb4f..58e40dbabfc3f 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -99,6 +99,17 @@ static const struct pmu_irq_ops percpu_pmunmi_ops = {
 	.free_pmuirq = armpmu_free_percpu_pmunmi
 };
 
+static inline bool armpmu_is_strobe_enabled(struct hw_perf_event *hwc)
+{
+	return hwc->strobe_period != 0;
+}
+
+void armpmu_set_strobe_period(struct hw_perf_event *hwc, u32 period)
+{
+	hwc->strobe_period = period;
+	hwc->strobe_active = false;
+}
+
 static DEFINE_PER_CPU(struct arm_pmu *, cpu_armpmu);
 static DEFINE_PER_CPU(int, cpu_irq);
 static DEFINE_PER_CPU(const struct pmu_irq_ops *, cpu_irq_ops);
@@ -202,22 +213,45 @@ int armpmu_event_set_period(struct perf_event *event)
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 	s64 left = local64_read(&hwc->period_left);
-	s64 period = hwc->sample_period;
-	u64 max_period;
+	s64 period_active = hwc->sample_period;
+	u64 max_period = arm_pmu_event_max_period(event);
 	int ret = 0;
 
-	max_period = arm_pmu_event_max_period(event);
-	if (unlikely(left <= -period)) {
-		left = period;
-		local64_set(&hwc->period_left, left);
-		hwc->last_period = period;
-		ret = 1;
-	}
+	if (likely(!armpmu_is_strobe_enabled(hwc))) {
+		if (unlikely(left <= -period_active)) {
+			left = period_active;
+			local64_set(&hwc->period_left, left);
+			hwc->last_period = period_active;
+			ret = 1;
+		}
+
+		if (unlikely(left <= 0)) {
+			left += period_active;
+			local64_set(&hwc->period_left, left);
+			hwc->last_period = period_active;
+			ret = 1;
+		}
+	} else if (unlikely(left <= 0)) {
+		s64 new_period;
+		bool new_active;
+
+		/*
+		 * When strobing is enabled, do not attempt to adjust the
+		 * period based on the previous overflow, instead just
+		 * alternate between the two periods
+		 */
+		if (hwc->strobe_active) {
+			new_period = period_active;
+			new_active = false;
+		} else {
+			new_period = hwc->strobe_period;
+			new_active = true;
+		}
 
-	if (unlikely(left <= 0)) {
-		left += period;
+		left = new_period;
 		local64_set(&hwc->period_left, left);
-		hwc->last_period = period;
+		hwc->last_period = new_period;
+		hwc->strobe_active = new_active;
 		ret = 1;
 	}
 
@@ -448,6 +482,9 @@ __hw_perf_event_init(struct perf_event *event)
 	int mapping, ret;
 
 	hwc->flags = 0;
+	hwc->strobe_active = false;
+	hwc->strobe_period = 0;
+
 	mapping = armpmu->map_event(event);
 
 	if (mapping < 0) {
@@ -456,6 +493,15 @@ __hw_perf_event_init(struct perf_event *event)
 		return mapping;
 	}
 
+	if (armpmu_is_strobe_enabled(hwc)) {
+		if (event->attr.freq)
+			return -EINVAL;
+		if (hwc->strobe_period == 0)
+			return -EINVAL;
+		if (hwc->strobe_period >= event->attr.sample_period)
+			return -EINVAL;
+	}
+
 	/*
 	 * We don't assign an index until we actually place the event onto
 	 * hardware. Use -1 to signify that we haven't decided where to put it
@@ -488,8 +534,8 @@ __hw_perf_event_init(struct perf_event *event)
 		 * is far less likely to overtake the previous one unless
 		 * you have some serious IRQ latency issues.
 		 */
-		hwc->sample_period  = arm_pmu_event_max_period(event) >> 1;
-		hwc->last_period    = hwc->sample_period;
+		hwc->sample_period = arm_pmu_event_max_period(event) >> 1;
+		hwc->last_period = hwc->sample_period;
 		local64_set(&hwc->period_left, hwc->sample_period);
 	}
 
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index b3b34f6670cfb..3ee74382e7a93 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -175,6 +175,7 @@ void armpmu_free(struct arm_pmu *pmu);
 int armpmu_register(struct arm_pmu *pmu);
 int armpmu_request_irq(int irq, int cpu);
 void armpmu_free_irq(int irq, int cpu);
+void armpmu_set_strobe_period(struct hw_perf_event *hwc, u32 period);
 
 #define ARMV8_PMU_PDEV_NAME "armv8-pmu"
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d2a15c0c6f8a9..7ef3f39fe6171 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -157,7 +157,15 @@ struct hw_perf_event {
 	union {
 		struct { /* hardware */
 			u64		config;
-			u64		last_tag;
+			union {
+				/* for s390 and x86 */
+				u64	last_tag;
+				/* for arm_pmu */
+				struct {
+					u32 strobe_period;
+					bool strobe_active;
+				};
+			};
 			unsigned long	config_base;
 			unsigned long	event_base;
 			int		event_base_rdpmc;
-- 
2.43.0


