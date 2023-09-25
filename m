Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEF87AD006
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjIYGUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjIYGUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:20:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837E3CE8;
        Sun, 24 Sep 2023 23:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695622801; x=1727158801;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wLqn6jaAB87oqyPf2xszc+s2QS2KfthyFm7b+XPWl/g=;
  b=dIwNqC1OLZldji0htSJxs7l3v8VlVdgVa79m/EZ7vPQ1zqhexR40Gw58
   yb4s/xw1XycU9BI+qB45pgKKKjY3eoSfNcQjZ368nu/pDB+9X7O0/WkDo
   Iam/oJ7OgnoIUTzVW8Lv5l8pWQkWSadgUmQCxswnmcJyeFvC32QhkhBrR
   buqaf3LsUN8rr8CckRoLR1XaT/4bb9ahzWLYZMxjkr1KU2RowhQbWfjdb
   E9SLvNoXKezuZn0G6nHgYCBWUYZ8E6gG1e5Teutnup5hS9SNh6+pKpS+m
   yRGZA0O/M01y4H/gwcSlhBr5olrzRjAWsw59MAne9hAoCklm7u77HkNq9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="445279481"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="445279481"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 23:19:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="818494381"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="818494381"
Received: from b49691a75598.jf.intel.com ([10.54.34.22])
  by fmsmga004.fm.intel.com with ESMTP; 24 Sep 2023 23:19:19 -0700
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
Subject: [RFC PATCH 14/25] perf stat: Add build string function and topdown events handling in hardware-grouping
Date:   Sun, 24 Sep 2023 23:18:13 -0700
Message-Id: <20230925061824.3818631-15-weilin.wang@intel.com>
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

Add the function to generate final grouping strings. This function is
very similar to the existing metricgroup__build_event_string() function.
The difference is that the input data includes a list of grouping lists.

Topdown events need special handling because they are not included in the
pmu-event JSON file. This should be a temporary solution to group topdown
events. Better solution could be using JSON files to cover these events.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 106 +++++++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 4b1b0470d..797f831e1 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1895,6 +1895,95 @@ static int assign_event_grouping(struct metricgroup__event_info *e,
 	return ret;
 }
 
+static int hw_aware_metricgroup__build_event_string(struct list_head *group_strs,
+					   const char *modifier,
+					   struct list_head *groups)
+{
+	struct metricgroup__pmu_group_list *p;
+	struct metricgroup__group *g;
+	struct metricgroup__group_events *ge;
+	bool no_group = true;
+	int ret = 0;
+
+#define RETURN_IF_NON_ZERO(x) do { if (x) return x; } while (0)
+
+	list_for_each_entry(p, groups, nd) {
+		list_for_each_entry(g, &p->group_head, nd) {
+			struct strbuf *events;
+			struct metricgroup__group_strs *new_group_str = malloc(sizeof(struct metricgroup__group_strs));
+
+			if (!new_group_str)
+				return -ENOMEM;
+			strbuf_init(&new_group_str->grouping_str, 0);
+			events = &new_group_str->grouping_str;
+			ret = strbuf_addch(events, '{');
+			RETURN_IF_NON_ZERO(ret);
+			no_group = true;
+			list_for_each_entry(ge, &g->event_head, nd) {
+				const char *sep, *rsep, *id = ge->event_name;
+
+				pr_debug("found event %s\n", id);
+
+				/* Separate events with commas and open the group if necessary. */
+				if (!no_group) {
+					ret = strbuf_addch(events, ',');
+					RETURN_IF_NON_ZERO(ret);
+				}
+				/*
+				 * Encode the ID as an event string. Add a qualifier for
+				 * metric_id that is the original name except with characters
+				 * that parse-events can't parse replaced. For example,
+				 * 'msr@tsc@' gets added as msr/tsc,metric-id=msr!3tsc!3/
+				 */
+				sep = strchr(id, '@');
+				if (sep) {
+					ret = strbuf_add(events, id, sep - id);
+					RETURN_IF_NON_ZERO(ret);
+					ret = strbuf_addch(events, '/');
+					RETURN_IF_NON_ZERO(ret);
+					rsep = strrchr(sep, '@');
+					ret = strbuf_add(events, sep + 1, rsep - sep - 1);
+					RETURN_IF_NON_ZERO(ret);
+					ret = strbuf_addstr(events, ",metric-id=");
+					RETURN_IF_NON_ZERO(ret);
+					sep = rsep;
+				} else {
+					sep = strchr(id, ':');
+					if (sep) {
+						ret = strbuf_add(events, id, sep - id);
+						RETURN_IF_NON_ZERO(ret);
+					} else {
+						ret = strbuf_addstr(events, id);
+						RETURN_IF_NON_ZERO(ret);
+					}
+					ret = strbuf_addstr(events, "/metric-id=");
+					RETURN_IF_NON_ZERO(ret);
+				}
+				ret = encode_metric_id(events, id);
+				RETURN_IF_NON_ZERO(ret);
+				ret = strbuf_addstr(events, "/");
+				RETURN_IF_NON_ZERO(ret);
+
+				if (sep) {
+					ret = strbuf_addstr(events, sep + 1);
+					RETURN_IF_NON_ZERO(ret);
+				}
+				if (modifier) {
+					ret = strbuf_addstr(events, modifier);
+					RETURN_IF_NON_ZERO(ret);
+				}
+				no_group = false;
+			}
+			ret = strbuf_addf(events, "}:W");
+			RETURN_IF_NON_ZERO(ret);
+			pr_debug("events-buf: %s\n", events->buf);
+			list_add_tail(&new_group_str->nd, group_strs);
+		}
+	}
+	return ret;
+#undef RETURN_IF_NON_ZERO
+}
+
 /**
  * create_grouping - Create a list of groups and place all the events of
  * event_info_list into these groups.
@@ -1906,8 +1995,8 @@ static int assign_event_grouping(struct metricgroup__event_info *e,
  */
 static int create_grouping(struct list_head *pmu_info_list,
 			  struct list_head *event_info_list,
-			  struct list_head *groupings __maybe_unused,
-			  const char *modifier __maybe_unused)
+			  struct list_head *groupings,
+			  const char *modifier)
 {
 	int ret = 0;
 	struct metricgroup__event_info *e;
@@ -1923,6 +2012,7 @@ static int create_grouping(struct list_head *pmu_info_list,
 		if (ret)
 			goto out;
 	}
+	ret = hw_aware_metricgroup__build_event_string(groupings, modifier, &groups);
 out:
 	metricgroup__free_group_list(&groups);
 	return ret;
@@ -1951,9 +2041,19 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
 #define RETURN_IF_NON_ZERO(x) do { if (x) return x; } while (0)
 	hashmap__for_each_entry(ctx->ids, cur, bkt) {
 		const char *id = cur->pkey;
+		const char *special_pattern = "topdown-";
 
 		pr_debug("found event %s\n", id);
-
+		if (!strncmp(id, special_pattern, strlen(special_pattern))) {
+			struct metricgroup__event_info *event;
+			event = event_info__new(id, "core", "0", true);
+			if (!event) {
+				ret = -ENOMEM;
+				goto err_out;
+			}
+			list_add(&event->nd, &event_info_list);
+			continue;
+		}
 		ret = get_metricgroup_events(id, etable, &event_info_list);
 		if (ret)
 			goto err_out;
-- 
2.39.3

