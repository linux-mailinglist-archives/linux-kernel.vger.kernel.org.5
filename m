Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DA280FAFA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjLLXEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378015AbjLLXEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:04:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BB718B;
        Tue, 12 Dec 2023 15:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702422231; x=1733958231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3GTSojueKrZAHm7+ztYQ/xXSABrjDOLxOrKwyxXPHCI=;
  b=lzbPZoBmEOMCpPSqiGC4DuXK0IwR+tLCXQvBMy/a7dya2ROtSkUEu05Z
   oSDi5jB/p9/QhYh1UXLh86aKbSWRYoVF6Pd0cbbBx5FeFVTSuyCMhZJ9M
   qnBKPIgydcXlWx0EndvsvQCnBEGH/vn9I+pyJQUwrRmrmmpz0UaNUcmT9
   /Sc2ya+mBGNh5WrxwO+QRbMWg2b1zzlzZEZvNX/b09A2t5xmhv7j/46YY
   dIqRmKnQ7156lH0kdLadw7QD3ULTfcRarEseweagteoBkRi5Uost6v4LZ
   yDTrws+EWb2o1Kqacqz6Z/2L20IEdG5Q9Vq/jmBO03JERkUZDEqAYxgoi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="392056015"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="392056015"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 15:02:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="864392027"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="864392027"
Received: from node-10329.jf.intel.com ([10.54.34.22])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Dec 2023 15:02:55 -0800
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
Subject: [RFC PATCH v3 13/18] perf stat: Handle taken alone in hardware-grouping
Date:   Tue, 12 Dec 2023 15:02:19 -0800
Message-Id: <20231212230224.1473300-15-weilin.wang@intel.com>
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

Add taken alone into consideration when grouping. Only one taken
alone event is supported per group.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/pmu-events/jevents.py   |  7 +++++--
 tools/perf/pmu-events/pmu-events.h |  1 +
 tools/perf/util/metricgroup.c      | 18 +++++++++++++-----
 tools/perf/util/metricgroup.h      |  2 ++
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 16f17d335f8e..e5919e5e6d4a 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -55,7 +55,9 @@ _json_event_attributes = [
     # Counter this event could use
     'counter',
     # Longer things (the last won't be iterated over during decompress).
-    'long_desc'
+    'long_desc',
+    # Taken alone event could not be collected in the same group with other taken alone event
+    'taken_alone'
 ]
 
 # Attributes that are in pmu_unit_layout.
@@ -71,7 +73,7 @@ _json_metric_attributes = [
 ]
 # Attributes that are bools or enum int values, encoded as '0', '1',...
 _json_enum_attributes = ['aggr_mode', 'deprecated', 'event_grouping', 'perpkg',
-    'size', 'fixed_size'
+    'size', 'fixed_size', 'taken_alone'
 ]
 
 def removesuffix(s: str, suffix: str) -> str:
@@ -331,6 +333,7 @@ class JsonEvent:
       extra_desc += '  Spec update: ' + jd['Errata']
     self.pmu = unit_to_pmu(jd.get('Unit'))
     self.counter = jd.get('Counter')
+    self.taken_alone = jd.get('TakenAlone')
     self.size = jd.get('Size')
     self.fixed_size = jd.get('FixedSize')
     filter = jd.get('Filter')
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 65e0c5dd8bb4..ce10356e9665 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -50,6 +50,7 @@ struct pmu_event {
 	const char *unit;
 	bool perpkg;
 	bool deprecated;
+	bool taken_alone;
 };
 
 struct pmu_metric {
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 016ea949ba5d..78e607f3ad56 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1624,6 +1624,7 @@ static void metricgroup__free_pmu_info(struct list_head *pmu_info_list)
 static struct metricgroup__event_info *event_info__new(const char *name,
 						      const char *pmu_name,
 						      const char *counter,
+						      bool taken_alone,
 						      bool free_counter)
 {
 	int ret = 0;
@@ -1638,6 +1639,7 @@ static struct metricgroup__event_info *event_info__new(const char *name,
 		pmu_name = "core";
 
 	e->name = name;
+	e->taken_alone = taken_alone;
 	e->free_counter = free_counter;
 	e->pmu_name = pmu_name;
 	if (free_counter) {
@@ -1676,7 +1678,8 @@ static int metricgroup__add_metric_event_callback(const struct pmu_event *pe,
 	if (!strcasecmp(pe->name, d->event_name)) {
 		if (!pe->counter)
 			return -EINVAL;
-		event = event_info__new(d->event_id, pe->pmu, pe->counter, /*free_counter=*/false);
+		event = event_info__new(d->event_id, pe->pmu, pe->counter,
+					pe->taken_alone, /*free_counter=*/false);
 		if (!event)
 			return -ENOMEM;
 		list_add(&event->nd, d->list);
@@ -1799,6 +1802,8 @@ static int find_and_set_counters(struct metricgroup__event_info *e,
 	int ret;
 	unsigned long find_bit = 0;
 
+	if (e->taken_alone && current_group->taken_alone)
+		return -ENOSPC;
 	if (e->free_counter)
 		return 0;
 	if (e->fixed_counter) {
@@ -1833,11 +1838,13 @@ static int _insert_event(struct metricgroup__event_info *e,
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
@@ -1847,6 +1854,7 @@ static int insert_new_group(struct list_head *head,
 	INIT_LIST_HEAD(&new_group->event_head);
 	fill_counter_bitmap(new_group->gp_counters, 0, size);
 	fill_counter_bitmap(new_group->fixed_counters, 0, fixed_size);
+	new_group->taken_alone = false;
 	list_add_tail(&new_group->nd, head);
 	return 0;
 }
@@ -2050,8 +2058,8 @@ static int create_grouping(struct list_head *pmu_info_list,
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
@@ -2098,7 +2106,7 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
 		if (is_special_event(id)) {
 			struct metricgroup__event_info *event;
 
-			event = event_info__new(id, "default_core", "0",
+			event = event_info__new(id, "default_core", "0", false,
 						/*free_counter=*/true);
 			if (!event)
 				goto err_out;
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 37fdf8c5ba77..8f6a1bb9d1ad 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -105,6 +105,7 @@ struct metricgroup__event_info {
 	const char *pmu_name;
 	bool fixed_counter;
 	bool free_counter;
+	bool taken_alone;
 	/** The counters the event allowed to be collected on. */
 	DECLARE_BITMAP(counters, NR_COUNTERS);
 };
@@ -154,6 +155,7 @@ struct metricgroup__group {
 	DECLARE_BITMAP(fixed_counters, NR_COUNTERS);
 	/** Head to the list of event names in this group*/
 	struct list_head event_head;
+	bool taken_alone;
 };
 
 struct metricgroup__group_events {
-- 
2.39.3

