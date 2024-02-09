Return-Path: <linux-kernel+bounces-58978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5529884EF57
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ACC91C216AA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DF934CD5;
	Fri,  9 Feb 2024 03:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lq5497B1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988A01864C;
	Fri,  9 Feb 2024 03:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707448498; cv=none; b=lt6LXKcazX53N4yR8nC/HW9liRo3wzLdeVi9dd0Y2tQbF1nS7pCmHtV/lU4xj7nPdQ/6XbWNCbJ/9ehnuAAGJaNjbpOtp4GCEEf4hiHQ8sVlNaI+L1nVDvdn0SnBkcamOITJQwHfqE8ST4Cf4YFAeYjKdpEIiwnMdAH/Jln0Cec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707448498; c=relaxed/simple;
	bh=mL5H4TvbTCZl43JaCvHWfIfur/YIYIR57bOSDnbW6HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1MmKi/Xpuvb51FWD4O0rtlUJkNegwpRy5BSN7Dm3xtVfbnEEt1mPEvjW39myg8rb0UnhVRTJOHdxtVhwxnwaSVWpcMp9I7hM55hVAdIiLKQASli49qY9RThBMVaLeIk3dWoBZ6TBTfoxk/iQKTsikdy9D6t+Oqpn5MsG7w1r9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lq5497B1; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707448497; x=1738984497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mL5H4TvbTCZl43JaCvHWfIfur/YIYIR57bOSDnbW6HY=;
  b=Lq5497B1TlTNJwvvzgE4f1s4aFE0i7U7kXKoMVhif80WuJvmsrV7mbnB
   BvntQpHhfZXiN3vJfrSe4lR1vstnIdoi56TMa5FAVHevwlDJ3w1YTSzqf
   HW7bDHcci8AVDmkU2MILm1ltP60GUIrO/B3zM+xP7QQ3o7WNaEoPW0YPg
   m+EXFsL4Qorhr4LZbKEWnfjOqsNX5Ve3lTw/w+HyD8lqB1T46yQOXz/ju
   lavxIztXgHI2KFwIrNEe0mR1VS9oDlpO9ja3I6BLEG2I8z6bYvcKaTMRy
   We6WfIrAIsdH4XVkSxc9HwJ0bywa04PnvvGgwe1gphT+aJG53FJl8fNaf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1257942"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="1257942"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 19:14:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="32631446"
Received: from b49691a74b80.jf.intel.com ([10.165.54.183])
  by orviesa002.jf.intel.com with ESMTP; 08 Feb 2024 19:14:48 -0800
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [RFC PATCH v4 11/15] perf stat: Handle taken alone in hardware-grouping
Date: Thu,  8 Feb 2024 19:14:37 -0800
Message-ID: <20240209031441.943012-12-weilin.wang@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240209031441.943012-1-weilin.wang@intel.com>
References: <20240209031441.943012-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

Add taken alone into consideration when grouping. Only one taken
alone event is supported per group.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/pmu-events/jevents.py   |  7 ++++++-
 tools/perf/pmu-events/pmu-events.h |  1 +
 tools/perf/util/metricgroup.c      | 20 +++++++++++++++-----
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index bc91b7efa49a..4fbb367a3228 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -56,7 +56,9 @@ _json_event_attributes = [
     # The list of counter(s) this event could use
     'counters',
     # Longer things (the last won't be iterated over during decompress).
-    'long_desc'
+    'long_desc',
+    # Taken alone event could not be collected in the same group with other taken alone event
+    'taken_alone'
 ]
 
 # Attributes that are in pmu_unit_layout.
@@ -355,6 +357,9 @@ class JsonEvent:
     self.num_counters = jd.get('NumCounters')
     # Number of fixed counter
     self.num_fixed_counters = jd.get('NumFixedCounters')
+    # If the event is taken alone event, which cannot be grouped with any other
+    # taken alone event.
+    self.taken_alone = jd.get('TakenAlone')
     filter = jd.get('Filter')
     self.unit = jd.get('ScaleUnit')
     self.perpkg = jd.get('PerPkg')
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index e245e4738970..837edfeb676a 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -54,6 +54,7 @@ struct pmu_event {
 	const char *unit;
 	bool perpkg;
 	bool deprecated;
+	bool taken_alone;
 };
 
 struct pmu_metric {
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index fe115f0880f9..95d3868819e3 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -189,6 +189,7 @@ struct metricgroup__event_info {
 	/** The event uses special counters that we consider that as free counter
 	 *  during the event grouping*/
 	bool free_counter;
+	bool taken_alone;
 	/** The counters the event allowed to be collected on. */
 	DECLARE_BITMAP(counters, NR_COUNTERS);
 };
@@ -235,6 +236,7 @@ struct metricgroup__group {
 	DECLARE_BITMAP(fixed_counters, NR_COUNTERS);
 	/** Head to the list of event names in this group*/
 	struct list_head event_head;
+	bool taken_alone;
 };
 
 struct metricgroup__group_events {
@@ -1717,6 +1719,7 @@ static void metricgroup__free_pmu_info(struct list_head *pmu_info_list)
 static struct metricgroup__event_info *event_info__new(const char *name,
 						      const char *pmu_name,
 						      const char *counter,
+						      bool taken_alone,
 						      bool free_counter)
 {
 	int ret = 0;
@@ -1731,6 +1734,7 @@ static struct metricgroup__event_info *event_info__new(const char *name,
 		pmu_name = "core";
 
 	e->name = name;
+	e->taken_alone = taken_alone;
 	e->free_counter = free_counter;
 	e->pmu_name = pmu_name;
 	if (free_counter) {
@@ -1769,7 +1773,8 @@ static int metricgroup__add_metric_event_callback(const struct pmu_event *pe,
 	if (!strcasecmp(pe->name, d->event_name)) {
 		if (!pe->counters)
 			return -EINVAL;
-		event = event_info__new(d->event_id, pe->pmu, pe->counters, /*free_counter=*/false);
+		event = event_info__new(d->event_id, pe->pmu, pe->counters,
+					pe->taken_alone, /*free_counter=*/false);
 		if (!event)
 			return -ENOMEM;
 		list_add(&event->nd, d->list);
@@ -1892,6 +1897,8 @@ static int find_and_set_counters(struct metricgroup__event_info *e,
 	int ret;
 	unsigned long find_bit = 0;
 
+	if (e->taken_alone && current_group->taken_alone)
+		return -ENOSPC;
 	if (e->free_counter)
 		return 0;
 	if (e->fixed_counter) {
@@ -1926,11 +1933,13 @@ static int _insert_event(struct metricgroup__event_info *e,
 		list_add(&event->nd, &group->event_head);
 	else
 		list_add_tail(&event->nd, &group->event_head);
+	if (e->taken_alone)
+		group->taken_alone = true;
 	return 0;
 }
 
 /**
- * Insert the new_group node at the end of the group list.
+ * Initialize the new group and insert it to the end of the group list.
  */
 static int insert_new_group(struct list_head *head,
 			   struct metricgroup__group *new_group,
@@ -1940,6 +1949,7 @@ static int insert_new_group(struct list_head *head,
 	INIT_LIST_HEAD(&new_group->event_head);
 	fill_counter_bitmap(new_group->gp_counters, 0, num_counters);
 	fill_counter_bitmap(new_group->fixed_counters, 0, num_fixed_counters);
+	new_group->taken_alone = false;
 	list_add_tail(&new_group->nd, head);
 	return 0;
 }
@@ -2143,8 +2153,8 @@ static int create_grouping(struct list_head *pmu_info_list,
 	//TODO: for each new core group, we should consider to add events that uses fixed counters
 	list_for_each_entry(e, event_info_list, nd) {
 		bitmap_scnprintf(e->counters, NR_COUNTERS, bit_buf, NR_COUNTERS);
-		pr_debug("Event name %s, [pmu]=%s, [counters]=%s\n", e->name,
-			e->pmu_name, bit_buf);
+		pr_debug("Event name %s, [pmu]=%s, [counters]=%s, [taken_alone]=%d\n",
+			e->name, e->pmu_name, bit_buf, e->taken_alone);
 		ret = assign_event_grouping(e, pmu_info_list, &groups);
 		if (ret)
 			goto out;
@@ -2191,7 +2201,7 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
 		if (is_special_event(id)) {
 			struct metricgroup__event_info *event;
 
-			event = event_info__new(id, "default_core", "0",
+			event = event_info__new(id, "default_core", "0", false,
 						/*free_counter=*/true);
 			if (!event)
 				goto err_out;
-- 
2.42.0


