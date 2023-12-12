Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9415580FAF0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377943AbjLLXDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbjLLXDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:03:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3B6D57;
        Tue, 12 Dec 2023 15:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702422189; x=1733958189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dmrN8wQ1G0CXm6oFndY7YcNFAAzOZvEAIAUMEMECUmw=;
  b=kOgbhniQSz2TtZWX5+aw5g5jSbMwRNLhMX2g3QXXIzcfUHHMFPmZ6fK6
   uA8BVVHJTNJUqYAXGU2d2BsbcAh1u/3VbKhZw7VsFtmiu2Ug0wP8X4hfI
   VwRxn6oOIQZAiaH7N/l78vIJmqIiJTAdDdC9iUeZvgtBpIj+6VgRMqTLr
   C3rTIVEzHDNswegRh1LMILrzMTmgOI/SOZ0Qm+V5+xCv6t8aiWAOfM4uP
   UWmTCN/LjNLiIOXWPv/wv0Yp21VbHI9CTWui0jy/gv/KswCw36mo9dYi1
   UkES7e7lS4bvLJ6X7jJncACn2nGTwM9OTdR0agrCHvoZFIrdlA5j9buFB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="392055957"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="392055957"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 15:02:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="864392004"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="864392004"
Received: from node-10329.jf.intel.com ([10.54.34.22])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Dec 2023 15:02:50 -0800
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
Subject: [RFC PATCH v3 07/18] perf stat: Add functions to set counter bitmaps for hardware-grouping method
Date:   Tue, 12 Dec 2023 15:02:13 -0800
Message-Id: <20231212230224.1473300-9-weilin.wang@intel.com>
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

Add metricgroup__event_info data structure to represent an event in the
metric grouping context; the list of counters and the PMU name an event
should be collected with.

Add functions to parse event counter info from pmu-events and generate a
list of metricgroup__event_info data to prepare grouping.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 196 +++++++++++++++++++++++++++++++++-
 tools/perf/util/metricgroup.h |  27 +++++
 2 files changed, 220 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 8d1143ee898c..24268882d355 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1432,6 +1432,182 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
 	return ret;
 }
 
+/**
+ * set_counter_bitmap - The counter bit mapping: [8-15,0-7], e.g. the GP0 is the
+ * 8th bit and GP7 is the 1st bit in this 16-bits bitmap. It is helpful for
+ * assigning GP4-7 before GP0-3 because some events can be collected using GP0-3
+ * only on some platforms.
+ */
+static int set_counter_bitmap(int pos, unsigned long *bitmap)
+{
+	if (pos >= NR_COUNTERS || pos < 0)
+		return -EINVAL;
+	if (pos <= 7)
+		pos = TRANSFER_FIRST_BYTE(pos);
+	else
+		pos = TRANSFER_SEC_BYTE(pos);
+	*bitmap |= 1ul << pos;
+	return 0;
+}
+
+static int parse_fixed_counter(const char *counter,
+			      unsigned long *bitmap,
+			      bool *fixed)
+{
+	int ret = -ENOENT;
+	//TODO: this pattern is different on some other platforms
+	const char *pattern = "Fixed counter ";
+	int pos = 0;
+
+	if (!strncmp(counter, pattern, strlen(pattern))) {
+		pos = atoi(counter + strlen(pattern));
+		ret = set_counter_bitmap(pos, bitmap);
+		if (ret)
+			return ret;
+		*fixed = true;
+		return 0;
+	}
+	return ret;
+}
+
+/**
+ * parse_counter - Parse event counter info from pmu-events and set up bitmap
+ * accordingly.
+ *
+ * @counter: counter info string to be parsed.
+ * @bitmap: bitmap to set based on counter info parsed.
+ * @fixed: is set to true if the event uses fixed counter.
+ */
+static int parse_counter(const char *counter,
+			unsigned long *bitmap,
+			bool *fixed)
+{
+	int ret = 0;
+	char *p;
+	char *tok;
+	int pos = 0;
+
+	ret = parse_fixed_counter(counter, bitmap, fixed);
+	// ret==0 means matched with fixed counter
+	if (ret == 0)
+		return ret;
+
+	p = strdup(counter);
+	tok = strtok(p, ",");
+	if (!tok)
+		return -ENOENT;
+
+	while (tok) {
+		pos = atoi(tok);
+		ret = set_counter_bitmap(pos, bitmap);
+		if (ret)
+			return ret;
+		tok = strtok(NULL, ",");
+	}
+	return 0;
+}
+
+static struct metricgroup__event_info *event_info__new(const char *name,
+						      const char *pmu_name,
+						      const char *counter,
+						      bool free_counter)
+{
+	int ret = 0;
+	char *bit_buf = malloc(NR_COUNTERS);
+	bool fixed_counter = false;
+	struct metricgroup__event_info *e;
+
+	e = zalloc(sizeof(*e));
+	if (!e)
+		return NULL;
+	if (!pmu_name)
+		pmu_name = "core";
+
+	e->name = name;
+	e->free_counter = free_counter;
+	e->pmu_name = strdup(pmu_name);
+	if (free_counter) {
+		ret = set_counter_bitmap(0, e->counters);
+		if (ret)
+			return NULL;
+	} else {
+		ret = parse_counter(counter, e->counters, &fixed_counter);
+		if (ret)
+			return NULL;
+		e->fixed_counter = fixed_counter;
+	}
+
+	bitmap_scnprintf(e->counters, NR_COUNTERS, bit_buf, NR_COUNTERS);
+	pr_debug("Event %s requires pmu %s counter: %s bitmap %s, [pmu=%s]\n",
+		e->name, e->pmu_name, counter, bit_buf, pmu_name);
+
+	return e;
+}
+
+struct metricgroup__add_metric_event_data {
+	struct list_head *list;
+	/* pure event name, exclude umask and other info*/
+	const char *event_name;
+	/* event name and umask if applicable*/
+	const char *event_id;
+};
+
+static int metricgroup__add_metric_event_callback(const struct pmu_event *pe,
+						 const struct pmu_events_table *table __maybe_unused,
+						 void *data)
+{
+	struct metricgroup__event_info *event;
+	struct metricgroup__add_metric_event_data *d = data;
+
+	if (!strcasecmp(pe->name, d->event_name)) {
+		event = event_info__new(d->event_id, pe->pmu, pe->counter, /*free_counter=*/false);
+		if (!event)
+			return -ENOMEM;
+		list_add(&event->nd, d->list);
+	}
+
+	return 0;
+}
+
+/**
+ * get_metricgroup_events - Find counter requirement of events from the
+ * pmu_events table
+ * @full_id: the full event identifiers.
+ * @table: pmu_events table that is searched for event data.
+ * @event_info_list: the list that the new event counter info added to.
+ */
+static int get_metricgroup_events(const char *full_id,
+				 const struct pmu_events_table *table,
+				 struct list_head *event_info_list)
+{
+	LIST_HEAD(list);
+	int ret = 0;
+	const char *id;
+	const char *rsep, *sep = strchr(full_id, '@');
+
+	if (sep) {
+		rsep = strchr(full_id, ',');
+		id = strndup(sep + 1, rsep - sep - 1);
+		if (ret)
+			goto out;
+	} else {
+		id = full_id;
+	}
+	{
+		struct metricgroup__add_metric_event_data data = {
+			.list = &list,
+			.event_name = id,
+			.event_id = full_id,
+		};
+		ret = pmu_events_table_for_each_event(table,
+				metricgroup__add_metric_event_callback, &data);
+	}
+
+out:
+	list_splice(&list, event_info_list);
+	return ret;
+}
+
 /**
  * hw_aware_build_grouping - Build event groupings by reading counter
  * requirement of the events and counter available on the system from
@@ -1445,9 +1621,25 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
 				  const char *modifier __maybe_unused)
 {
 	int ret = 0;
+	struct hashmap_entry *cur;
+	LIST_HEAD(pmu_info_list);
+	LIST_HEAD(event_info_list);
+	size_t bkt;
+	const struct pmu_events_table *etable = perf_pmu__find_events_table(NULL);
+
+#define RETURN_IF_NON_ZERO(x) do { if (x) return x; } while (0)
+	hashmap__for_each_entry(ctx->ids, cur, bkt) {
+		const char *id = cur->pkey;
+
+		pr_debug("found event %s\n", id);
+
+		ret = get_metricgroup_events(id, etable, &event_info_list);
+		if (ret)
+			return ret;
+	}
 
-	pr_debug("This is a placeholder\n");
 	return ret;
+#undef RETURN_IF_NON_ZERO
 }
 
 static void group_str_free(struct metricgroup__group_strs *g)
@@ -1521,8 +1713,6 @@ static int hw_aware_parse_ids(struct perf_pmu *fake_pmu,
 	*out_evlist = parsed_evlist;
 	parsed_evlist = NULL;
 err_out:
-	parse_events_error__exit(&parse_error);
-	evlist__delete(parsed_evlist);
 	metricgroup__free_grouping_strs(&groupings);
 	return ret;
 }
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 89809df85644..3704545c9a11 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -5,6 +5,7 @@
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include <stdbool.h>
+#include <linux/bitmap.h>
 #include "pmu-events/pmu-events.h"
 #include "strbuf.h"
 
@@ -67,6 +68,32 @@ struct metric_expr {
 	int runtime;
 };
 
+/* Maximum number of counters per PMU*/
+#define NR_COUNTERS	16
+/*
+ * Transfer bit position in the bitmap to ensure start assigning counter from
+ * the last GP counter to the first.
+ * bit15 <---> bit0
+ * [GP8-GP15] [GP0-GP7]
+ */
+#define TRANSFER_FIRST_BYTE(pos) (7 - pos)
+#define TRANSFER_SEC_BYTE(pos) (23 - pos)
+
+/**
+ * An event used in a metric. This info is for metric grouping.
+ */
+struct metricgroup__event_info {
+	struct list_head nd;
+	/** The name of the event. */
+	const char *name;
+	/** The name of the pmu the event be collected on. */
+	const char *pmu_name;
+	bool fixed_counter;
+	bool free_counter;
+	/** The counters the event allowed to be collected on. */
+	DECLARE_BITMAP(counters, NR_COUNTERS);
+};
+
 /**
  * Each group is one node in the group string list.
  */
-- 
2.39.3

