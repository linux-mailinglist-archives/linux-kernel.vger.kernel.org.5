Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0DB7AD004
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjIYGU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjIYGUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:20:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47044CC4;
        Sun, 24 Sep 2023 23:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695622797; x=1727158797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qG1e1YClORB9MUuLJIL/q/m6xLgbd/H000c70OIVGno=;
  b=WwYgouzY2Q0ZVggO/4okx++7M4dbn3hJ4+b6WnY7wxgTdIyIpd/WKJc4
   waROqpxbBOcGCd5HvpStC1ac/kX+mIVOTr5aA0bJBcwUoeVLWLz6gjc/h
   65/FsgXv1cMpsLKnWe6+vqIjrTMp4PBjbLyvxV8oVpiyixPFZTTm8mwDn
   iIHJaqS8T+KDA3PNpKOoRHiFxe5m6RdGVAEXh2gptRw+OBULR3SVCJdgy
   g4Lmmv09hIQ9mMiyYMYhp+M/0uvxpe3CQ4TNkEoOMDSvUKTk5ughReu05
   Hhwcq02nGtkenWjuglf8LdIogt5vNO6UlZBixYLvfv1jOLaj8gk0f8OoZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="445279459"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="445279459"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 23:19:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="818494360"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="818494360"
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
Subject: [RFC PATCH 11/25] perf stat: Add utility functions to hardware-grouping method
Date:   Sun, 24 Sep 2023 23:18:10 -0700
Message-Id: <20230925061824.3818631-12-weilin.wang@intel.com>
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

Add functions to handle counter bitmaps. Add functions do find and insert
operations to handle inserting event into groups.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/lib/bitmap.c            |  20 ++++++
 tools/perf/util/metricgroup.c | 115 +++++++++++++++++++++++++++++++++-
 2 files changed, 133 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
index c3e487196..a96dbf001 100644
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
index de6a6a1d7..68d56087b 100644
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
@@ -1681,12 +1702,102 @@ static int get_pmu_counter_layouts(struct list_head *pmu_info_list,
 	return ret;
 }
 
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
+ * Insert event e into a group capable to include it
+ *
+ */
+static int insert_event_to_group(struct metricgroup__event_info *e,
+				struct metricgroup__pmu_group_list *pmu_group_head)
+{
+	struct metricgroup__group *g;
+	int ret;
+	//struct list_head *head;
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
+		struct metricgroup__group *current_group = malloc(sizeof(struct metricgroup__group));
+		if (!current_group)
+			return -ENOMEM;
+		pr_debug("create_new_group for [event] %s\n", e->name);
+
+		//head = &pmu_group_head->group_head;
+		//ret = create_new_group(head, current_group, pmu_group_head->size,
+		//			pmu_group_head->fixed_size);
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
 /**
  * assign_event_grouping - Assign an event into a group. If existing group
  * cannot include it, create a new group and insert the event to it.
  */
 static int assign_event_grouping(struct metricgroup__event_info *e,
-				struct list_head *pmu_info_list __maybe_unused,
+				struct list_head *pmu_info_list,
 				struct list_head *groups)
 {
 	int ret = 0;
@@ -1717,7 +1828,7 @@ static int assign_event_grouping(struct metricgroup__event_info *e,
 		list_add_tail(&pmu_group_head->nd, groups);
 	}
 
-	//ret = insert_event_to_group(e, pmu_group_head, pmu_info_list);
+	ret = insert_event_to_group(e, pmu_group_head);
 	return ret;
 }
 
-- 
2.39.3

