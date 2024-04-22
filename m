Return-Path: <linux-kernel+bounces-153232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2758ACB39
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9241F282007
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17D7145FFF;
	Mon, 22 Apr 2024 10:49:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C3584DE0;
	Mon, 22 Apr 2024 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782982; cv=none; b=h/Rd/qyO7WkYxUe24h7wVZRqEj9WNY8FC3buhfxIbPd3068NsSHgOEqYWpFAPBzovRrF7eRJu/XDAKgnx+aixEXt4DMP2gq6VRgKfheIkuZOodPQAD3De/QIuSBh5ahwtL2H4MlS9y5VaDoLizfQSchqfJHysKwwIUCz203tWqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782982; c=relaxed/simple;
	bh=YjXWyHSEbgscaEgpxtkOZ2LyLY0BsD2fw1O+wecDHfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnnREEgGHMdd9eyz1H/Ujf+xeuyoLXn+MaNACn9oFmX2O3jmjbYscvHVEjXW9Jhmj9WKgZYmgXK7TCz0Hq3H+F6Tbpy6WGlnZ3BMCrg8RJ+Bzn/aYUvXx1RmJ5MUHJ4K/nrwgrRKKp+2ElbhtulVDHw34C0/6V1NC4H0QuY5ew4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA1F51063;
	Mon, 22 Apr 2024 03:50:07 -0700 (PDT)
Received: from e126817.cambridge.arm.com (e126817.cambridge.arm.com [10.2.3.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8A9333F7BD;
	Mon, 22 Apr 2024 03:49:37 -0700 (PDT)
From: Ben Gainey <ben.gainey@arm.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: ak@linux.intel.com,
	will@kernel.org,
	james.clark@arm.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ben Gainey <ben.gainey@arm.com>
Subject: [RFC PATCH v2 1/4] perf: Allow periodic events to alternate between two sample periods
Date: Mon, 22 Apr 2024 11:49:26 +0100
Message-ID: <20240422104929.264241-2-ben.gainey@arm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422104929.264241-1-ben.gainey@arm.com>
References: <20240422104929.264241-1-ben.gainey@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change modifies perf_event_attr to add a second, alternative
sample period field, and modifies the core perf overflow handling
such that when specified an event will alternate between two sample
periods.

Currently, perf does not provide a  mechanism for decoupling the period
over which counters are counted from the period between samples. This is
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
 include/linux/perf_event.h      |  5 +++++
 include/uapi/linux/perf_event.h |  3 +++
 kernel/events/core.c            | 39 +++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d2a15c0c6f8a..212bd302e548 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -267,6 +267,11 @@ struct hw_perf_event {
 	 */
 	u64				freq_time_stamp;
 	u64				freq_count_stamp;
+
+	/*
+	 * Indicates that the alternative_sample_period is used
+	 */
+	bool				using_alternative_sample_period;
 #endif
 };
 
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 3a64499b0f5d..5c1701d091cf 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -379,6 +379,7 @@ enum perf_event_read_format {
 #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
 #define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
 #define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
+#define PERF_ATTR_SIZE_VER9	144	/* add: alternative_sample_period */
 
 /*
  * Hardware event_id to monitor via a performance monitoring event:
@@ -522,6 +523,8 @@ struct perf_event_attr {
 	__u64	sig_data;
 
 	__u64	config3; /* extension of config2 */
+
+	__u64	alternative_sample_period;
 };
 
 /*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 724e6d7e128f..07f1f931e18e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4100,6 +4100,8 @@ static void perf_adjust_period(struct perf_event *event, u64 nsec, u64 count, bo
 	s64 period, sample_period;
 	s64 delta;
 
+	WARN_ON_ONCE(hwc->using_alternative_sample_period);
+
 	period = perf_calculate_period(event, nsec, count);
 
 	delta = (s64)(period - hwc->sample_period);
@@ -9552,6 +9554,7 @@ static int __perf_event_overflow(struct perf_event *event,
 				 int throttle, struct perf_sample_data *data,
 				 struct pt_regs *regs)
 {
+	struct hw_perf_event *hwc = &event->hw;
 	int events = atomic_read(&event->event_limit);
 	int ret = 0;
 
@@ -9564,6 +9567,26 @@ static int __perf_event_overflow(struct perf_event *event,
 
 	ret = __perf_event_account_interrupt(event, throttle);
 
+	/*
+	 * Swap the sample period to the alternative period
+	 */
+	if (event->attr.alternative_sample_period) {
+		bool using_alt = hwc->using_alternative_sample_period;
+		u64 sample_period = (using_alt ? event->attr.sample_period
+					       : event->attr.alternative_sample_period);
+
+		hwc->sample_period = sample_period;
+		hwc->using_alternative_sample_period = !using_alt;
+
+		if (local64_read(&hwc->period_left) > 0) {
+			event->pmu->stop(event, PERF_EF_UPDATE);
+
+			local64_set(&hwc->period_left, 0);
+
+			event->pmu->start(event, PERF_EF_RELOAD);
+		}
+	}
+
 	/*
 	 * XXX event_limit might not quite work as expected on inherited
 	 * events
@@ -12005,6 +12028,12 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 
 	local64_set(&hwc->period_left, hwc->sample_period);
 
+	/*
+	 * alternative_sample_period cannot be used with freq
+	 */
+	if (attr->freq && attr->alternative_sample_period)
+		goto err_ns;
+
 	/*
 	 * We currently do not support PERF_SAMPLE_READ on inherited events.
 	 * See perf_output_read().
@@ -12459,9 +12488,19 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (attr.freq) {
 		if (attr.sample_freq > sysctl_perf_event_sample_rate)
 			return -EINVAL;
+		if (attr.alternative_sample_period)
+			return -EINVAL;
 	} else {
 		if (attr.sample_period & (1ULL << 63))
 			return -EINVAL;
+		if (attr.alternative_sample_period) {
+			if (!attr.sample_period)
+				return -EINVAL;
+			if (attr.alternative_sample_period & (1ULL << 63))
+				return -EINVAL;
+			if (attr.alternative_sample_period == attr.sample_period)
+				attr.alternative_sample_period = 0;
+		}
 	}
 
 	/* Only privileged users can get physical addresses */
-- 
2.44.0


