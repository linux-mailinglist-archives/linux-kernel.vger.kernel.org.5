Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6317ACFFE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjIYGUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjIYGUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:20:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A1DCD1;
        Sun, 24 Sep 2023 23:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695622798; x=1727158798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+aubAkzZ9fM27xEp4GwOouz7KCLea9GS4cMIVbkPI8s=;
  b=GWfDtBcvwEEirs/X3/MmYnrT35QSomXJCr+plBdWyBUE3kkB+Wji+ZJ1
   tiPLZ8D7bvJleBNJrUa1HjKIxUvYlObxbl+rtO3T6O/z0yZz7ZWKeLB9V
   23B3NqF/9CERxWnaUdfSzoJVH/fkqhfegu5j/R9WzvO5/OBwbx2w6Ilb4
   yJVWEaMbdUiAK4Zw4NwQLNiADFLJeKuRduehJ6ZIqRDFigBn08K3cCtf9
   nLLUAKxfyYOXoTQi4G16WTVGu9TpEOrgG1EJACxrBJW63ja+XjE2+tvJ2
   3PTWDRRB4j4NgUVT0xhPmhmFB0bYVjpZrPltcPfL0y3121KsZRpLaNV19
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="445279470"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="445279470"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 23:19:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="818494366"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="818494366"
Received: from b49691a75598.jf.intel.com ([10.54.34.22])
  by fmsmga004.fm.intel.com with ESMTP; 24 Sep 2023 23:19:17 -0700
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
        Mark Rutland <mark.rutland@arm.com>
Subject: [RFC PATCH 12/25] perf stat: Add more functions for hardware-grouping method
Date:   Sun, 24 Sep 2023 23:18:11 -0700
Message-Id: <20230925061824.3818631-13-weilin.wang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230925061824.3818631-1-weilin.wang@intel.com>
References: <20230925061824.3818631-1-weilin.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weilin Wang <weilin.wang@intel.com>

Add function to fill all bits of one counter bitmap. Add functions to
create new groups when no counter is available in all the existing groups.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 39 ++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 68d56087b..8d54e71bf 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1702,6 +1702,19 @@ static int get_pmu_counter_layouts(struct list_head *pmu_info_list,
 	return ret;
 }
 
+static int fill_counter_bitmap(unsigned long *bitmap, int start, int size)
+{
+	int ret;
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
 /**
  * Find if there is a counter available for event e in current_group. If a
  * counter is available, use this counter by fill the bit in the correct counter
@@ -1750,6 +1763,21 @@ static int _insert_event(struct metricgroup__event_info *e,
 	return 0;
 }
 
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
 /**
  * Insert event e into a group capable to include it
  *
@@ -1759,7 +1787,7 @@ static int insert_event_to_group(struct metricgroup__event_info *e,
 {
 	struct metricgroup__group *g;
 	int ret;
-	//struct list_head *head;
+	struct list_head *head;
 
 	list_for_each_entry(g, &pmu_group_head->group_head, nd) {
 		ret = find_and_set_counters(e, g);
@@ -1774,13 +1802,14 @@ static int insert_event_to_group(struct metricgroup__event_info *e,
 	 */
 	{
 		struct metricgroup__group *current_group = malloc(sizeof(struct metricgroup__group));
+
 		if (!current_group)
 			return -ENOMEM;
 		pr_debug("create_new_group for [event] %s\n", e->name);
 
-		//head = &pmu_group_head->group_head;
-		//ret = create_new_group(head, current_group, pmu_group_head->size,
-		//			pmu_group_head->fixed_size);
+		head = &pmu_group_head->group_head;
+		ret = insert_new_group(head, current_group, pmu_group_head->size,
+				      pmu_group_head->fixed_size);
 		if (ret)
 			return ret;
 		ret = find_and_set_counters(e, current_group);
@@ -1817,7 +1846,7 @@ static int assign_event_grouping(struct metricgroup__event_info *e,
 
 		pmu_group_head = malloc(sizeof(struct metricgroup__pmu_group_list));
 		INIT_LIST_HEAD(&pmu_group_head->group_head);
-		pr_debug("create new group for event %s in pmu %s ", e->name, e->pmu_name);
+		pr_debug("create new group for event %s in pmu %s\n", e->name, e->pmu_name);
 		pmu_group_head->pmu_name = e->pmu_name;
 		list_for_each_entry(p, pmu_info_list, nd) {
 			if (!strcasecmp(p->name, e->pmu_name)) {
-- 
2.39.3

