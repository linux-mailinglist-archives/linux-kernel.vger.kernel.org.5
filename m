Return-Path: <linux-kernel+bounces-58975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D9384EF54
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823621C26494
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14419208CB;
	Fri,  9 Feb 2024 03:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eqZhLYem"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F72FBF0;
	Fri,  9 Feb 2024 03:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707448496; cv=none; b=qz3kM5DoMq8gQ6rf48/pO4LbEWxSYw+Aqdyj9+g9S8qiG28D2VAXp/qjngy0uVoeVGg04jhLAUlehqYAk3aKQo7GdrvQqtG0xBIwUS01/kIh8oNayLC1+EyQBlfTAjQBFR0q3tU0utQ4JpysO6syM62UlB8dTi+w8DYGOCD6vvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707448496; c=relaxed/simple;
	bh=dstIOELs4oGs/0dQrJIS3jxgee0OEbKkbpMgzEO7qmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/uHu6zWRBP+yZOzRkhTA54xHljloueEx31wCyJQPXaPIQ7GEYPXfIALXsj9NP4V0BH51NPJOK75HdzOQ3NWwCJQbFbULEN24sm1wahjb1R/CZdYxrgWbKBKKjZwqxGF6IotkCnsua9MQiifhuEMUJmJBqHj4Ax8MgRK4SR/fR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eqZhLYem; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707448495; x=1738984495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dstIOELs4oGs/0dQrJIS3jxgee0OEbKkbpMgzEO7qmE=;
  b=eqZhLYem7ipIXGctCQMX5gIH43Psq/AkeoBwmsaEBaD+93ulCIWBESzV
   MWpvz7EtSLAuu60CvGWuPzNM5k0t0C6HcKsTebnZc8IeWnXtXkoq7lSU5
   0GLSdHqcQZNLm+j92TVsd0oat/7bP68n5G99pPPGlNRS5Ii7q1z1G6KFi
   rPsdzOCE74S1sdujBsrD0Jx+2v6K0ORJjHxgakMZgM0jeh/gYzBMwGMN6
   OkohqGHcDf0RzrcE2V09NPE+nKDzMY/bPH7oulRiyeIcEobXDx/5TFoJw
   4w7/OnAd2Zyzkn6SDgYa3hy9JqbGDGu+ReTMV664qBv5Y+gRQ12lDKuRI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1257920"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="1257920"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 19:14:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="32631432"
Received: from b49691a74b80.jf.intel.com ([10.165.54.183])
  by orviesa002.jf.intel.com with ESMTP; 08 Feb 2024 19:14:47 -0800
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
Subject: [RFC PATCH v4 07/15] perf stat: Add functions to create new group and assign events into groups
Date: Thu,  8 Feb 2024 19:14:33 -0800
Message-ID: <20240209031441.943012-8-weilin.wang@intel.com>
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

Add struct metricgroup__pmu_group_list to hold the lists of groups from
different PMUs. Each PMU has one separate list.

Add struct metricgroup__group as one node (one group in the grouping
result) of the metricgroup__pmu_group_list. It uses two bitmaps to log
counter availabilities(gp counters and fixed counters).

Add functions to create group and assign event into the groups based on the
event restrictions (struct metricgroup__event_info) and counter
availability (pmu_info_list and bitmaps). New group is inserted into the
list of groups.

Add functions to handle counter bitmaps. Add functions do find and insert
operations to handle inserting event into groups.

Add function to fill all bits of one counter bitmap. Add functions to
create new groups when no counter is available in all the existing groups.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 296 ++++++++++++++++++++++++++++++++++
 1 file changed, 296 insertions(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 9061ed4ca015..f86e9a0b0d65 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -192,6 +192,41 @@ struct metricgroup__pmu_counters {
 	size_t num_counters;
 	size_t num_fixed_counters;
 };
+/**
+ * A list of event groups for this pmu.
+ * This is updated during the grouping.
+ */
+struct metricgroup__pmu_group_list {
+	struct list_head nd;
+	/** The name of the pmu(/core) the events collected on. */
+	const char *pmu_name;
+	/** The number of gp counters in the pmu(/core). */
+	size_t num_counters;
+	/** The number of fixed counters in the pmu(/core) if applicable. */
+	size_t num_fixed_counters;
+	/** Head to the list of groups using this pmu(/core)*/
+	struct list_head group_head;
+};
+/**
+ * This is one node in the metricgroup__pmu_group_list.
+ * It represents on group.
+ */
+struct metricgroup__group {
+	struct list_head nd;
+	/** The bitmaps represent availability of the counters.
+	 *  They are updated once the corresponding counter is used by
+	 *  an event (event inserted into the group).
+	 */
+	DECLARE_BITMAP(gp_counters, NR_COUNTERS);
+	DECLARE_BITMAP(fixed_counters, NR_COUNTERS);
+	/** Head to the list of event names in this group*/
+	struct list_head event_head;
+};
+
+struct metricgroup__group_events {
+	struct list_head nd;
+	const char *event_name;
+};
 
 /**
  * Each group is one node in the group string list.
@@ -1487,6 +1522,34 @@ static int set_counter_bitmap(int pos, unsigned long *bitmap)
 	return 0;
 }
 
+/**
+ * Returns 0 on success. Finds the last counter that is not used in pmu_counters
+ * and supports the event, included in event_counters.
+ */
+static int find_counter_bitmap(const unsigned long *pmu_counters,
+			      const unsigned long *event_counters,
+			      unsigned long *bit)
+{
+	/*It is helpful to assign from the highest bit because some events can
+	 *only be collected using GP0-3.
+	 */
+	unsigned long find_bit = find_last_and_bit(pmu_counters, event_counters, NR_COUNTERS);
+
+	if (find_bit == NR_COUNTERS)
+		return -ERANGE;
+	*bit = find_bit;
+	return 0;
+}
+
+static int use_counter_bitmap(unsigned long *bitmap,
+			     unsigned long find_bit)
+{
+	if (find_bit >= NR_COUNTERS)
+		return -EINVAL;
+	__clear_bit(find_bit, bitmap);
+	return 0;
+}
+
 static int parse_fixed_counter(const char *counter,
 			      unsigned long *bitmap,
 			      bool *fixed)
@@ -1544,6 +1607,38 @@ static int parse_counter(const char *counter,
 	return 0;
 }
 
+static void group_event_list_free(struct metricgroup__group *groups)
+{
+	struct metricgroup__group_events *e, *tmp;
+
+	list_for_each_entry_safe(e, tmp, &groups->event_head, nd) {
+		list_del_init(&e->nd);
+		free(e);
+	}
+}
+
+static void group_list_free(struct metricgroup__pmu_group_list *groups)
+{
+	struct metricgroup__group *g, *tmp;
+
+	list_for_each_entry_safe(g, tmp, &groups->group_head, nd) {
+		list_del_init(&g->nd);
+		group_event_list_free(g);
+		free(g);
+	}
+}
+
+static void metricgroup__free_group_list(struct list_head *groups)
+{
+	struct metricgroup__pmu_group_list *g, *tmp;
+
+	list_for_each_entry_safe(g, tmp, groups, nd) {
+		list_del_init(&g->nd);
+		group_list_free(g);
+		free(g);
+	}
+}
+
 static void metricgroup__free_event_info(struct list_head
 					*event_info_list)
 {
@@ -1719,6 +1814,203 @@ static int get_pmu_counter_layouts(struct list_head *pmu_info_list,
 	return ret;
 }
 
+static int fill_counter_bitmap(unsigned long *bitmap, int start, int size)
+{
+	int ret;
+
+	bitmap_zero(bitmap, NR_COUNTERS);
+
+	for (int pos = start; pos < start + size; pos++) {
+		ret = set_counter_bitmap(pos, bitmap);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+/**
+ * Find if there is a counter available for event e in current_group. If a
+ * counter is available, use this counter by filling the bit in the correct
+ * counter bitmap. Otherwise, return error (-ERANGE).
+ */
+static int find_and_set_counters(struct metricgroup__event_info *e,
+				struct metricgroup__group *current_group)
+{
+	int ret;
+	unsigned long find_bit = 0;
+
+	if (e->free_counter)
+		return 0;
+	if (e->fixed_counter) {
+		ret = find_counter_bitmap(current_group->fixed_counters, e->counters,
+					 &find_bit);
+		if (ret)
+			return ret;
+		pr_debug("found counter for [event]=%s [e->fixed_counters]=%lu\n",
+			e->name, *current_group->fixed_counters);
+		ret = use_counter_bitmap(current_group->fixed_counters, find_bit);
+	} else {
+		ret = find_counter_bitmap(current_group->gp_counters, e->counters,
+					 &find_bit);
+		if (ret)
+			return ret;
+		pr_debug("found counter for [event]=%s [e->gp_counters]=%lu\n",
+			e->name, *current_group->gp_counters);
+		ret = use_counter_bitmap(current_group->gp_counters, find_bit);
+	}
+	return ret;
+}
+
+static int _insert_event(struct metricgroup__event_info *e,
+			struct metricgroup__group *group)
+{
+	struct metricgroup__group_events *event = malloc(sizeof(struct metricgroup__group_events));
+
+	if (!event)
+		return -ENOMEM;
+	event->event_name = e->name;
+	if (e->fixed_counter)
+		list_add(&event->nd, &group->event_head);
+	else
+		list_add_tail(&event->nd, &group->event_head);
+	return 0;
+}
+
+/**
+ * Insert the new_group node at the end of the group list.
+ */
+static int insert_new_group(struct list_head *head,
+			   struct metricgroup__group *new_group,
+			   size_t num_counters,
+			   size_t num_fixed_counters)
+{
+	INIT_LIST_HEAD(&new_group->event_head);
+	fill_counter_bitmap(new_group->gp_counters, 0, num_counters);
+	fill_counter_bitmap(new_group->fixed_counters, 0, num_fixed_counters);
+	list_add_tail(&new_group->nd, head);
+	return 0;
+}
+
+/**
+ * Insert event e into a group capable to include it
+ *
+ */
+static int insert_event_to_group(struct metricgroup__event_info *e,
+				struct metricgroup__pmu_group_list *pmu_group_head)
+{
+	struct metricgroup__group *g;
+	int ret;
+	struct list_head *head;
+
+	list_for_each_entry(g, &pmu_group_head->group_head, nd) {
+		ret = find_and_set_counters(e, g);
+		if (!ret) { /* return if successfully find and set counter*/
+			ret = _insert_event(e, g);
+			return ret;
+		}
+	}
+	/*
+	 * We were not able to find an existing group to insert this event.
+	 * Continue to create a new group and insert the event in it.
+	 */
+	{
+		struct metricgroup__group *current_group =
+				malloc(sizeof(struct metricgroup__group));
+
+		if (!current_group)
+			return -ENOMEM;
+		pr_debug("create_new_group for [event] %s\n", e->name);
+
+		head = &pmu_group_head->group_head;
+		ret = insert_new_group(head, current_group, pmu_group_head->num_counters,
+				      pmu_group_head->num_fixed_counters);
+		if (ret)
+			return ret;
+		ret = find_and_set_counters(e, current_group);
+		if (ret)
+			return ret;
+		ret = _insert_event(e, current_group);
+	}
+
+	return ret;
+}
+
+/**
+ * assign_event_grouping - Assign an event into a group. If existing group
+ * cannot include it, create a new group and insert the event to it.
+ */
+static int assign_event_grouping(struct metricgroup__event_info *e,
+				struct list_head *pmu_info_list,
+				struct list_head *groups)
+{
+	int ret = 0;
+
+	struct metricgroup__pmu_group_list *g = NULL;
+	struct metricgroup__pmu_group_list *pmu_group_head = NULL;
+
+	list_for_each_entry(g, groups, nd) {
+		if (!strcasecmp(g->pmu_name, e->pmu_name)) {
+			pr_debug("found group for event %s in pmu %s\n", e->name, g->pmu_name);
+			pmu_group_head = g;
+			break;
+		}
+	}
+	if (!pmu_group_head) {
+		struct metricgroup__pmu_counters *p;
+
+		pmu_group_head = malloc(sizeof(struct metricgroup__pmu_group_list));
+		if (!pmu_group_head)
+			return -ENOMEM;
+		INIT_LIST_HEAD(&pmu_group_head->group_head);
+		pr_debug("create new group for event %s in pmu %s\n", e->name, e->pmu_name);
+		pmu_group_head->pmu_name = e->pmu_name;
+		list_for_each_entry(p, pmu_info_list, nd) {
+			if (!strcasecmp(p->name, e->pmu_name)) {
+				pmu_group_head->num_counters = p->num_counters;
+				pmu_group_head->num_fixed_counters = p->num_fixed_counters;
+				break;
+			}
+		}
+		list_add_tail(&pmu_group_head->nd, groups);
+	}
+
+	ret = insert_event_to_group(e, pmu_group_head);
+	return ret;
+}
+
+/**
+ * create_grouping - Create a list of groups and place all the events of
+ * event_info_list into these groups.
+ * @pmu_info_list: the list of PMU units info based on pmu-events data, used for
+ * creating new groups.
+ * @event_info_list: the list of events to be grouped.
+ * @groupings: the list of groups with events placed in.
+ * @modifier: any modifiers added to the events.
+ */
+static int create_grouping(struct list_head *pmu_info_list,
+			  struct list_head *event_info_list,
+			  struct list_head *groupings __maybe_unused,
+			  const char *modifier __maybe_unused)
+{
+	int ret = 0;
+	struct metricgroup__event_info *e;
+	LIST_HEAD(groups);
+	char *bit_buf = malloc(NR_COUNTERS);
+
+	//TODO: for each new core group, we should consider to add events that uses fixed counters
+	list_for_each_entry(e, event_info_list, nd) {
+		bitmap_scnprintf(e->counters, NR_COUNTERS, bit_buf, NR_COUNTERS);
+		pr_debug("Event name %s, [pmu]=%s, [counters]=%s\n", e->name,
+			e->pmu_name, bit_buf);
+		ret = assign_event_grouping(e, pmu_info_list, &groups);
+		if (ret)
+			goto out;
+	}
+out:
+	metricgroup__free_group_list(&groups);
+	return ret;
+};
+
 /**
  * hw_aware_build_grouping - Build event groupings by reading counter
  * requirement of the events and counter available on the system from
@@ -1750,6 +2042,10 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
 			goto err_out;
 	}
 	ret = get_pmu_counter_layouts(&pmu_info_list, ltable);
+	if (ret)
+		goto err_out;
+	ret = create_grouping(&pmu_info_list, &event_info_list, groupings,
+			     modifier);
 
 err_out:
 	metricgroup__free_event_info(&event_info_list);
-- 
2.42.0


