Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575B880FAF6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377957AbjLLXEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377945AbjLLXDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:03:43 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8894B10D8;
        Tue, 12 Dec 2023 15:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702422211; x=1733958211;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LSts5xKMFQPZVuTT4Ye0kZVPVu/oNteFmUfX9bIUYIQ=;
  b=daOXzcUQ+4jYo2/Da6oMgnfu+Zdz8yF3s+CXayL7T94s6GKIn1FlMnou
   +oMtyt/RwOrGEgj27l5HUwuRSes7Lz4ixptMq3AFtTmsSuyhr/TZOkzUZ
   Zh9u6sL6Un5Kopqm4AEuNxp9ESEm4zg6vUJNHCzGhYsEoCvMHgL1i/QxH
   /hjusHDBoyOYHgo1NaiI00pXSy60Gh9aP4DxaYmSsJGGY8tDZU+/qIJNF
   dWEKWKmotSz62xZ/9U5iIL11t3xxFlyGMjUbkHdE6jvhdcB6VVVerW8ny
   3N5ltqry5ZXARH8pDjnAG0++QwlOOd61Wu4s11/6wtysYBDMyJihluSr7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="392055979"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="392055979"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 15:02:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="864392012"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="864392012"
Received: from node-10329.jf.intel.com ([10.54.34.22])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Dec 2023 15:02:52 -0800
From:   weilin.wang@intel.com
To:     weilin.wang@intel.com, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Yang Jihong <yangjihong1@huawei.com>
Subject: [RFC PATCH v3 09/18] perf stat: Add functions to create new group and assign events into groups for hardware-grouping method
Date:   Tue, 12 Dec 2023 15:02:15 -0800
Message-Id: <20231212230224.1473300-11-weilin.wang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231212230224.1473300-1-weilin.wang@intel.com>
References: <20231212230224.1473300-1-weilin.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 tools/lib/bitmap.c            |  20 +++
 tools/perf/util/metricgroup.c | 254 ++++++++++++++++++++++++++++++++++
 tools/perf/util/metricgroup.h |  37 +++++
 3 files changed, 311 insertions(+)

diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
index c3e4871967bc..a96dbf001244 100644
--- a/tools/lib/bitmap.c
+++ b/tools/lib/bitmap.c
@@ -100,3 +100,23 @@ bool __bitmap_intersects(const unsigned long *bitmap1,
 			return true;
 	return false;
 }
+
+void bitmap_clear(unsigned long *map, unsigned int start, int len)
+{
+	unsigned long *p = map + BIT_WORD(start);
+	const unsigned int size = start + len;
+	int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
+	unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
+
+	while (len - bits_to_clear >= 0) {
+		*p &= ~mask_to_clear;
+		len -= bits_to_clear;
+		bits_to_clear = BITS_PER_LONG;
+		mask_to_clear = ~0UL;
+		p++;
+	}
+	if (len) {
+		mask_to_clear &= BITMAP_LAST_WORD_MASK(size);
+		*p &= ~mask_to_clear;
+	}
+}
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index a393584c7a73..9d06fe4488dc 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1450,6 +1450,27 @@ static int set_counter_bitmap(int pos, unsigned long *bitmap)
 	return 0;
 }
 
+static int find_counter_bitmap(unsigned long *addr1,
+			      unsigned long *addr2,
+			      unsigned long *bit)
+{
+	unsigned long find_bit = find_next_and_bit(addr1, addr2, NR_COUNTERS, 0);
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
+	bitmap_clear(bitmap, find_bit, 1);
+	return 0;
+}
+
 static int parse_fixed_counter(const char *counter,
 			      unsigned long *bitmap,
 			      bool *fixed)
@@ -1507,6 +1528,38 @@ static int parse_counter(const char *counter,
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
@@ -1682,6 +1735,203 @@ static int get_pmu_counter_layouts(struct list_head *pmu_info_list,
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
+ * counter is available, use this counter by fill the bit in the correct counter
+ * bitmap. Otherwise, return error (-ERANGE).
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
+			   size_t size,
+			   size_t fixed_size)
+{
+	INIT_LIST_HEAD(&new_group->event_head);
+	fill_counter_bitmap(new_group->gp_counters, 0, size);
+	fill_counter_bitmap(new_group->fixed_counters, 0, fixed_size);
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
+		ret = insert_new_group(head, current_group, pmu_group_head->size,
+				      pmu_group_head->fixed_size);
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
+				pmu_group_head->size = p->size;
+				pmu_group_head->fixed_size = p->fixed_size;
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
@@ -1713,6 +1963,10 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
 			goto err_out;
 	}
 	ret = get_pmu_counter_layouts(&pmu_info_list, ltable);
+	if (ret)
+		goto err_out;
+	ret = create_grouping(&pmu_info_list, &event_info_list, groupings,
+			     modifier);
 
 err_out:
 	metricgroup__free_event_info(&event_info_list);
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 802ca15e7c6b..51596e4b4341 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -109,6 +109,43 @@ struct metricgroup__pmu_counters {
 	size_t fixed_size;
 };
 
+/**
+ * A list of groups for this pmu.
+ * This is updated during the grouping.
+ */
+struct metricgroup__pmu_group_list {
+	struct list_head nd;
+	/** The name of the pmu(/core) the events collected on. */
+	const char *pmu_name;
+	/** The number of gp counters in the pmu(/core). */
+	size_t size;
+	/** The number of fixed counters in the pmu(/core) if applicable. */
+	size_t fixed_size;
+	/** Head to the list of groups using this pmu(/core)*/
+	struct list_head group_head;
+};
+
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
+
 /**
  * Each group is one node in the group string list.
  */
-- 
2.39.3

