Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11877C922E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 03:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjJNBxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 21:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbjJNBwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 21:52:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C111A5;
        Fri, 13 Oct 2023 18:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697248361; x=1728784361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GhmKyyKghlCEg+CW3TJQssYCSwZXT90Z3xVeUT4bde4=;
  b=e4XGfPKTlrSVtYcNN3unp1q3YTvH6ytAtubF17U3whqMaF/lGOqnZr1W
   gvW2+X9RCvGdfsJkbxvGDfyzSwtA5djXVmE1GiUYqv433zTA0iXReQbl9
   xZr5luBTQt156nz/9DC/Sisdkx1cyd/o/rGr1LPWxSa2tIB61kr7c7GUW
   awPidszTQfWNzyjjz8OKz2GsX8rgsSFlBMgyVYHVSs2PlsHpuAOaueotR
   ZhluZTGHN+aj6tN6VWJmRyc1VS40+eJujbx21u6TrhLbvx2WaqMCvpZeV
   u2Mp36WrQ/fMdyKsSA6ATEAIgY16kLyDDfe0dbTwzM1Qo+CTeIQgAX0O5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="389154735"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="389154735"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 18:52:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="731565686"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="731565686"
Received: from b49691a75598.jf.intel.com ([10.54.34.22])
  by orsmga006.jf.intel.com with ESMTP; 13 Oct 2023 18:52:19 -0700
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
Subject: [RFC PATCH v2 10/17] perf stat: Add build string function and topdown events handling in hardware-grouping
Date:   Fri, 13 Oct 2023 18:51:55 -0700
Message-Id: <20231014015202.1175377-11-weilin.wang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231014015202.1175377-1-weilin.wang@intel.com>
References: <20231014015202.1175377-1-weilin.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 96 +++++++++++++++++++++++++++++++++--
 1 file changed, 93 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 089919687..dccd16a58 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1899,6 +1899,96 @@ static int assign_event_grouping(struct metricgroup__event_info *e,
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
+			struct metricgroup__group_strs *new_group_str =
+				malloc(sizeof(struct metricgroup__group_strs));
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
@@ -1910,8 +2000,8 @@ static int assign_event_grouping(struct metricgroup__event_info *e,
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
@@ -1927,6 +2017,7 @@ static int create_grouping(struct list_head *pmu_info_list,
 		if (ret)
 			goto out;
 	}
+	ret = hw_aware_metricgroup__build_event_string(groupings, modifier, &groups);
 out:
 	metricgroup__free_group_list(&groups);
 	return ret;
@@ -1957,7 +2048,6 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
 		const char *id = cur->pkey;
 
 		pr_debug("found event %s\n", id);
-
 		ret = get_metricgroup_events(id, etable, &event_info_list);
 		if (ret)
 			goto err_out;
-- 
2.39.3

