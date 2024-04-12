Return-Path: <linux-kernel+bounces-143362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AB08A3797
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BFED2860F5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3180D14F12A;
	Fri, 12 Apr 2024 21:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BGdumuUj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AD0152519;
	Fri, 12 Apr 2024 21:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956098; cv=none; b=ueYpwkp+rMpqnAPGVn5yWx9jN1iTEiEUgBQAUmBqvC3ZtpM3SX0QIY5j8XUZfKBQzNU92pzxt6Jm9lIus++his8ZryqYnRxhtfmKREEvm7IdAc5E7d2awiQd2s3y4Wp8ot4rgry8vJKwrDUzcyAZGwmqkMnPPnBUK8Z8OWAsAx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956098; c=relaxed/simple;
	bh=DV3uTwrh+Qu4EgrPMg7ey229zxW4jOgVXR6iSOG6fp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apOZZv1qL7Rt2AUb91SvE0T0Y1Jo0O91mgf6x9etbvQplitO+ve9H3JSKLV67Ai+zFrUVuCJSphqODDSl4Xr6mzHZouAMqtjCJPNFsiWvT8KlcXPHtPEpbNsVNwMjDMXdd51GPav8Y7GAuZ2AXeft8A/9kzoouSLPsFwIjjRfPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BGdumuUj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712956096; x=1744492096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DV3uTwrh+Qu4EgrPMg7ey229zxW4jOgVXR6iSOG6fp4=;
  b=BGdumuUj24+fGQgwI2pkaSV1i6JRIYBknVElGmYY+7fu0us6rGxWOHne
   0YRePACsLVBlfOp9ZKEczPvHl/3c0fb5fzTwUyn7cMjoT/tvyZcd7N32f
   ycUHOxp2ruxdf8VRJqpQDVFhFT4JJ5vmnw5mrZl/79fGe8WntuvU80leS
   HRgB4xrEyRDDUq2I8ecTkktL7NrsJ/h/cY8Eo3zlEmzBSxwD/wweBfCnf
   s9hQ3TkDW5wRl32HefpelfILwBNvi3eW41mqNd6I5rgTBIFXK/j0T1/Ln
   cTm335s8BD6r/+GjZrqk4bQikKDBgi3UJjh0MLeSQbvT0JbgDcfgnwax4
   A==;
X-CSE-ConnectionGUID: DDgm+IDqQcODYhyvVmieWQ==
X-CSE-MsgGUID: XcZrwr1FQ+ejpT+EXtpq6w==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="19575473"
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="19575473"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 14:08:11 -0700
X-CSE-ConnectionGUID: AA2x1v9kT6m+UvTXJXpS5g==
X-CSE-MsgGUID: bOzImhUCSe+2pF9AkjRTNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="21772101"
Received: from b49691a74b80.jf.intel.com ([10.165.54.183])
  by orviesa006.jf.intel.com with ESMTP; 12 Apr 2024 14:08:10 -0700
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
	Caleb Biggers <caleb.biggers@intel.com>
Subject: [RFC PATCH v5 08/16] perf stat: Add build string function and topdown events handling in hardware-grouping
Date: Fri, 12 Apr 2024 14:07:48 -0700
Message-ID: <20240412210756.309828-9-weilin.wang@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240412210756.309828-1-weilin.wang@intel.com>
References: <20240412210756.309828-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

Add the function to generate final grouping strings. This function is
very similar to the existing metricgroup__build_event_string() function.
The difference is that the input data includes a list of grouping lists.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 97 +++++++++++++++++++++++++++++++++--
 1 file changed, 93 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 88c86664c90c..04d988ace734 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -2018,6 +2018,96 @@ static int assign_event_grouping(struct metricgroup__event_info *e,
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
+			ret = strbuf_addf(events, "}");
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
@@ -2029,8 +2119,8 @@ static int assign_event_grouping(struct metricgroup__event_info *e,
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
@@ -2046,6 +2136,7 @@ static int create_grouping(struct list_head *pmu_info_list,
 		if (ret)
 			goto out;
 	}
+	ret = hw_aware_metricgroup__build_event_string(groupings, modifier, &groups);
 out:
 	metricgroup__free_group_list(&groups);
 	return ret;
@@ -2075,8 +2166,6 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
 	hashmap__for_each_entry(ctx->ids, cur, bkt) {
 		const char *id = cur->pkey;
 
-		pr_debug("found event %s\n", id);
-
 		ret = get_metricgroup_events(id, etable, &event_info_list);
 		if (ret)
 			goto err_out;
-- 
2.42.0


