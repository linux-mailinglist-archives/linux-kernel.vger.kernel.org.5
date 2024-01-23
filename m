Return-Path: <linux-kernel+bounces-35204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FB3838D89
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA3A2B21A8F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32175DF2E;
	Tue, 23 Jan 2024 11:34:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27E55D8FE;
	Tue, 23 Jan 2024 11:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706009684; cv=none; b=pJZLN9ahEWkzuim2h72HC/PcCdn1bizF7i9KtEqL8rHk78oA7IzMUHqnZWsXeUvLXF8pT612NUlYAss9K6fanQr82syg+0bd6iso4dBGzqtA1Zguc7O8x3asOdRfzmAFJBWHNCvcYeC5Uw8t7qWcooj+t8BjzfROA9ZmdSd5UGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706009684; c=relaxed/simple;
	bh=Ev/78lNrKeEn0GKrbVaNQkMKhQsuAjKk6QQf3ZBpTYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KPIrecwmKVn+60hgWVZ4zPvyEIyVTLpqi8FTsmdIDcGhXwQ8nlcDQdvrNHHt6MS8qdLfdBQpRWGr17iu2DZvGO4yIZVgcaGBELCkKoAUa46nGzjRRAiNCNpZxcT4cCGsyxiX3ROv+qbLLPhPUDbFNOc0sVpKvRIBPptcwWHMkyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40622106F;
	Tue, 23 Jan 2024 03:35:27 -0800 (PST)
Received: from e126817.. (e126817.cambridge.arm.com [10.2.3.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 130203F762;
	Tue, 23 Jan 2024 03:34:39 -0800 (PST)
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
Subject: [RFC PATCH 2/2] arm_pmuv3: Add config bits for sample period strobing
Date: Tue, 23 Jan 2024 11:34:20 +0000
Message-ID: <20240123113420.1928154-3-ben.gainey@arm.com>
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

To expose the ability to alternate between sample periods to tools.
The field `strobe_period` is defined for config2 to hold the alternate
sample period. A non-zero value will enable strobing.

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
---
 drivers/perf/arm_pmuv3.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 23fa6c5da82c4..66b0219111bb8 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -318,6 +318,9 @@ static const struct attribute_group armv8_pmuv3_events_attr_group = {
 #define ATTR_CFG_FLD_threshold_CFG		config1 /* PMEVTYPER.TH */
 #define ATTR_CFG_FLD_threshold_LO		5
 #define ATTR_CFG_FLD_threshold_HI		16
+#define ATTR_CFG_FLD_strobe_period_CFG		config2
+#define ATTR_CFG_FLD_strobe_period_LO		0
+#define ATTR_CFG_FLD_strobe_period_HI		31
 
 GEN_PMU_FORMAT_ATTR(event);
 GEN_PMU_FORMAT_ATTR(long);
@@ -325,6 +328,7 @@ GEN_PMU_FORMAT_ATTR(rdpmc);
 GEN_PMU_FORMAT_ATTR(threshold_count);
 GEN_PMU_FORMAT_ATTR(threshold_compare);
 GEN_PMU_FORMAT_ATTR(threshold);
+GEN_PMU_FORMAT_ATTR(strobe_period);
 
 static int sysctl_perf_user_access __read_mostly;
 
@@ -352,6 +356,16 @@ static u8 armv8pmu_event_threshold_control(struct perf_event_attr *attr)
 	return (th_compare << 1) | th_count;
 }
 
+static inline u32 armv8pmu_event_strobe_period(struct perf_event *event)
+{
+	return ATTR_CFG_GET_FLD(&event->attr, strobe_period);
+}
+
+static inline bool armv8pmu_event_want_strobe(struct perf_event *event)
+{
+	return armv8pmu_event_strobe_period(event) != 0;
+}
+
 static struct attribute *armv8_pmuv3_format_attrs[] = {
 	&format_attr_event.attr,
 	&format_attr_long.attr,
@@ -359,6 +373,7 @@ static struct attribute *armv8_pmuv3_format_attrs[] = {
 	&format_attr_threshold.attr,
 	&format_attr_threshold_compare.attr,
 	&format_attr_threshold_count.attr,
+	&format_attr_strobe_period.attr,
 	NULL,
 };
 
@@ -1125,6 +1140,16 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
 	if (armv8pmu_event_is_64bit(event))
 		event->hw.flags |= ARMPMU_EVT_64BIT;
 
+	/*
+	 * Support alternating between two sample periods
+	 */
+	if (armv8pmu_event_want_strobe(event)) {
+		u32 strobe_period = armv8pmu_event_strobe_period(event);
+		armpmu_set_strobe_period(&(event->hw), strobe_period);
+	} else {
+		armpmu_set_strobe_period(&(event->hw), 0);
+	}
+
 	/*
 	 * User events must be allocated into a single counter, and so
 	 * must not be chained.
-- 
2.43.0


