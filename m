Return-Path: <linux-kernel+bounces-58981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAFE84EF5A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB941C23BA0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E072439840;
	Fri,  9 Feb 2024 03:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R9BoWN15"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9961DA32;
	Fri,  9 Feb 2024 03:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707448502; cv=none; b=IWMzUzqgihIKCZ+kytDKyTg9UExLVdx7a+BqX8KqiYmAjVU+6YHga8TiDm+h0xoMxtLV8kP5fm8oREF6eAsyo+ww//a//v7sps0/XWA7X1JqX9dIRXlc88n+sdf5O/Pz2qBp7hQc9CEY5fcG4N0nUbWfPqN1mip+AVEH7eUpHTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707448502; c=relaxed/simple;
	bh=nObyFR7ak2CI9RBnkdMxnonoYCxryMBB96Dff9fIYBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dI65umDV6RloJtiyvk97h3nO8xhGXSd1vpz/sp7KlFJri9BnY8arp5cCwBkHEZiVy0YZSdm8XcQln6ZIejv3qPqYLBQuTQ2S96jF/TtY71wAvDCxbCqt6u1q932zEBNXrcitGMvktG6yKdxJgnPcb5TLh2kWoH+fnDA2+zDYnwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R9BoWN15; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707448497; x=1738984497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nObyFR7ak2CI9RBnkdMxnonoYCxryMBB96Dff9fIYBo=;
  b=R9BoWN15C1kFRuH9fFbqY8GqeTunEeBspXuHep/iCV7ksZiGA5J9gem8
   R3NMF7gRGmDlHThj1k49PQRoPA08YAEPwFV6t3ZFp1ZCVuplyJ6tKsyQG
   4LIVdOs4kwJdrZcpX+WHOKviu0oFex1N2+pv4+HFrk+AVnryt9IjOSvFK
   PcYyMuuYhbZ8gvk7sDrtljhvszGu3Qso2O6EN9TR5mzmF7OvvO7wVkZpY
   qWpNydTUM1vCbydkdd7UtUt7/pPyx37jtPjUucRgtkilmk5j0EkJgGHnN
   NTrJ4MLbV3Nz5lSL5Y2/CHiTcW99V4qKKxk5Dm3eovLp4heSqrPb6KNMj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1257948"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="1257948"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 19:14:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="32631457"
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
Subject: [RFC PATCH v4 13/15] perf stat: Code refactoring in hardware-grouping
Date: Thu,  8 Feb 2024 19:14:39 -0800
Message-ID: <20240209031441.943012-14-weilin.wang@intel.com>
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

Decouple the step to generate final grouping strings out from the
build_grouping step so that we could do single metric grouping and then
merge groups if needed later.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 50 +++++++++++++++++------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index f1eb73957765..cfdbb5f7fb77 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1896,9 +1896,10 @@ static int find_and_set_counters(struct metricgroup__event_info *e,
 {
 	int ret;
 	unsigned long find_bit = 0;
-
-	if (e->taken_alone && current_group->taken_alone)
+	if (e->taken_alone && current_group->taken_alone) {
+		pr_debug("current group with taken alone event already\n");
 		return -ENOSPC;
+	}
 	if (e->free_counter)
 		return 0;
 	if (e->fixed_counter) {
@@ -2017,7 +2018,8 @@ static int assign_event_grouping(struct metricgroup__event_info *e,
 
 	list_for_each_entry(g, groups, nd) {
 		if (!strcasecmp(g->pmu_name, e->pmu_name)) {
-			pr_debug("found group for event %s in pmu %s\n", e->name, g->pmu_name);
+			pr_debug("found group header for event %s in pmu %s\n",
+				e->name, g->pmu_name);
 			pmu_group_head = g;
 			break;
 		}
@@ -2146,26 +2148,22 @@ static int hw_aware_metricgroup__build_event_string(struct list_head *group_strs
  */
 static int create_grouping(struct list_head *pmu_info_list,
 			  struct list_head *event_info_list,
-			  struct list_head *groupings,
-			  const char *modifier)
+			  struct list_head *grouping)
 {
 	int ret = 0;
 	struct metricgroup__event_info *e;
-	LIST_HEAD(groups);
 	char *bit_buf = malloc(NR_COUNTERS);
 
-	//TODO: for each new core group, we should consider to add events that uses fixed counters
+	//TODO: for each new core group, we could consider to add events that
+	//uses fixed counters
 	list_for_each_entry(e, event_info_list, nd) {
 		bitmap_scnprintf(e->counters, NR_COUNTERS, bit_buf, NR_COUNTERS);
 		pr_debug("Event name %s, [pmu]=%s, [counters]=%s, [taken_alone]=%d\n",
 			e->name, e->pmu_name, bit_buf, e->taken_alone);
-		ret = assign_event_grouping(e, pmu_info_list, &groups);
+		ret = assign_event_grouping(e, pmu_info_list, grouping);
 		if (ret)
-			goto out;
+			return ret;
 	}
-	ret = hw_aware_metricgroup__build_event_string(groupings, modifier, &groups);
-out:
-	metricgroup__free_group_list(&groups);
 	return ret;
 };
 
@@ -2186,9 +2184,8 @@ static bool is_special_event(const char *id)
  * @groupings: header to the list of final event grouping.
  * @modifier: any modifiers added to the events.
  */
-static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
-				  struct list_head *groupings __maybe_unused,
-				  const char *modifier __maybe_unused)
+static int hw_aware_build_grouping(struct expr_parse_ctx *ctx,
+				   struct list_head *grouping)
 {
 	int ret = 0;
 	struct hashmap_entry *cur;
@@ -2220,8 +2217,7 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
 	ret = get_pmu_counter_layouts(&pmu_info_list, ltable);
 	if (ret)
 		goto err_out;
-	ret = create_grouping(&pmu_info_list, &event_info_list, groupings,
-			     modifier);
+	ret = create_grouping(&pmu_info_list, &event_info_list, grouping);
 
 err_out:
 	metricgroup__free_event_info(&event_info_list);
@@ -2267,23 +2263,25 @@ static int hw_aware_parse_ids(struct perf_pmu *fake_pmu,
 {
 	struct parse_events_error parse_error;
 	struct evlist *parsed_evlist;
-	LIST_HEAD(groupings);
+	LIST_HEAD(grouping_str);
+	LIST_HEAD(grouping);
 	struct metricgroup__group_strs *group;
 	int ret;
 
 	*out_evlist = NULL;
-	ret = hw_aware_build_grouping(ids, &groupings, modifier);
-	if (ret) {
-		metricgroup__free_grouping_strs(&groupings);
-		return ret;
-	}
+	ret = hw_aware_build_grouping(ids, &grouping);
+	if (ret)
+		goto out;
+	ret = hw_aware_metricgroup__build_event_string(&grouping_str, modifier, &grouping);
+	if (ret)
+		goto out;
 
 	parsed_evlist = evlist__new();
 	if (!parsed_evlist) {
 		ret = -ENOMEM;
 		goto err_out;
 	}
-	list_for_each_entry(group, &groupings, nd) {
+	list_for_each_entry(group, &grouping_str, nd) {
 		struct strbuf *events = &group->grouping_str;
 
 		pr_debug("Parsing metric events '%s'\n", events->buf);
@@ -2303,7 +2301,9 @@ static int hw_aware_parse_ids(struct perf_pmu *fake_pmu,
 err_out:
 	parse_events_error__exit(&parse_error);
 	evlist__delete(parsed_evlist);
-	metricgroup__free_grouping_strs(&groupings);
+out:
+	metricgroup__free_group_list(&grouping);
+	metricgroup__free_grouping_strs(&grouping_str);
 	return ret;
 }
 
-- 
2.42.0


