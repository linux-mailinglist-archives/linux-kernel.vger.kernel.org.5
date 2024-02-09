Return-Path: <linux-kernel+bounces-58971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2831F84EF50
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3E41C2724D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D09516416;
	Fri,  9 Feb 2024 03:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cu2xU6wH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6813B6125;
	Fri,  9 Feb 2024 03:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707448494; cv=none; b=nbA5aT7wNrbNfj7dr0Fi7wz2RiLuvz/EUdk1g2W7C2UI3Dz63MEuDRhQYktvvChMPyiKdep8vaSRghbNXbwUoysKF5dUwDABQNZxJ3BcIeZQjGAQ6+cNntXP8U6MtdC93zmsp11y798EvAS0qDNeSXbWXWk5zEqUZb5t4olr6MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707448494; c=relaxed/simple;
	bh=DjJPq4T9ViJb+2InPFFCi7oWrQjyZ8Rl/e9jnSYLBoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aE13RwUhHYDOuqBoW5L5AsZn1pOxFcObgKfDK7dra2dlT7I6IivmfmtiQhl2VL18VUe/aEMLP8RrqXYWTJpwPkRl0neLjltuzS072O00mD4C9SPQB5zoNHQrHC2PGfyEkpq5UdNhMkKleMDLxSzYbt+oXpRc63iRCvyxNe32hWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cu2xU6wH; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707448493; x=1738984493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DjJPq4T9ViJb+2InPFFCi7oWrQjyZ8Rl/e9jnSYLBoc=;
  b=cu2xU6wHEY8Lnm0RVlHFmw+kBa44yoPNQ4yyeNvZMHgsyIUj9qS3N8jH
   CWi2H9xJsxQzb6YSMfsyEYUblPzS7uj/svLyX1AByh8td+1CFcmIMyidd
   EY8yq1g/Lzj+2JOZKJQ7he07kf+VB54HxzBt/a4FktQluoJX58oxvyhEV
   wdydDKm/cYydpkv4H3qfg/QrhCIm9XyI1UFfGX9URqzTMFQFCJz4mXDpY
   BlWIMPEK4lO1WbQdyGsfVHwcBYlILM2AM1YTyBZRSbikeXHYnXvu8zQzG
   xMJ3OHeNP9hSdXliv76fSCDHUjS9J3cTvr8ypNnK7NZTa+ybhj6GLRHUd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1257908"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="1257908"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 19:14:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="32631423"
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
Subject: [RFC PATCH v4 05/15] perf stat: Add functions to set counter bitmaps for hardware-grouping method
Date: Thu,  8 Feb 2024 19:14:31 -0800
Message-ID: <20240209031441.943012-6-weilin.wang@intel.com>
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

Add metricgroup__event_info data structure to represent an event in the
metric grouping context; the list of counters and the PMU name an event
should be collected with.

Add functions to parse event counter info from pmu-events and generate a
list of metricgroup__event_info data to prepare grouping.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 211 +++++++++++++++++++++++++++++++++-
 1 file changed, 208 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index ee638578afdd..2a917220fb34 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -24,6 +24,7 @@
 #include <linux/list_sort.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
+#include <linux/bitmap.h>
 #include <perf/cpumap.h>
 #include <subcmd/parse-options.h>
 #include <api/fs/fs.h>
@@ -157,6 +158,27 @@ struct metric {
 	struct evlist *evlist;
 };
 
+/* Maximum number of counters per PMU*/
+#define NR_COUNTERS	16
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
+	/** The event uses fixed counter*/
+	bool fixed_counter;
+	/** The event uses special counters that we consider that as free counter
+	 *  during the event grouping*/
+	bool free_counter;
+	/** The counters the event allowed to be collected on. */
+	DECLARE_BITMAP(counters, NR_COUNTERS);
+};
+
 /**
  * Each group is one node in the group string list.
  */
@@ -1440,6 +1462,175 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
 	return ret;
 }
 
+/**
+ * set_counter_bitmap - The counter bitmap: [0-15].
+ */
+static int set_counter_bitmap(int pos, unsigned long *bitmap)
+{
+	if (pos >= NR_COUNTERS || pos < 0)
+		return -EINVAL;
+	__set_bit(pos, bitmap);
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
@@ -1453,9 +1644,25 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
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
@@ -1529,8 +1736,6 @@ static int hw_aware_parse_ids(struct perf_pmu *fake_pmu,
 	*out_evlist = parsed_evlist;
 	parsed_evlist = NULL;
 err_out:
-	parse_events_error__exit(&parse_error);
-	evlist__delete(parsed_evlist);
 	metricgroup__free_grouping_strs(&groupings);
 	return ret;
 }
-- 
2.42.0


