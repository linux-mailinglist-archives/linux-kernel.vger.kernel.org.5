Return-Path: <linux-kernel+bounces-58973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C9D84EF51
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566941F24F74
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163E2175B0;
	Fri,  9 Feb 2024 03:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GrXXwEFZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10140CA7F;
	Fri,  9 Feb 2024 03:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707448495; cv=none; b=gj5YcnWX77fYQrVD0/xSphAD0LrIvxjmkCn2I2sd46RtwA6h/Yy7N+bOnSljJhoRlKbPUptsLaRU0m34GVGYPCQkHhhSLv9RY4ThEij6WAycd7zhXvy39wxX59vvuoMvb4+9dqTSKubeoB3EzQ4FM56qVPifq5l2dOJ7OR9rkGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707448495; c=relaxed/simple;
	bh=nwvJ4bQEjdGfxAja5WB8p9z4vCfBey7kRZHlUv8cNoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IACxRJjXL8UqG3XOYTQKlkp697zcmjP2zaAddsG7vS36mg/BYd3n7iiJy19pzHzdEKhkqXnaFI0dbvJ7+BAf6BCynQvUcSVx0AM3Qr1Ejv6Zn85aCNhKAc98VE8tJP/DCmD0zxsVPvsvkyNCrsMM4XFx6gtA9o/Vb5y7v5HW+Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GrXXwEFZ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707448493; x=1738984493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nwvJ4bQEjdGfxAja5WB8p9z4vCfBey7kRZHlUv8cNoY=;
  b=GrXXwEFZTCDqS++vvYT9rQFT+PP9HfnlFc2/NUPyrZgqrmyTZWGKFgIR
   v7gPyojPnooKFDZO8BECWc5V5A/k3qjRBt2nOvows9FjOTZSFPMIoshhA
   lUieFzf/5jjEwT5SmZJLnSa89lbLfw7PUdRIxrSqjaqvcqV7CZI3B8CBG
   SwWbFd2xGp2hlwlhP0mZ7wuMQ+8g92SDNTMa9WUFjXiMFm/xEDPCJ0lhi
   c8rDARPyaPr759qF1mLq1j/HeYT7FO22kNUvlkcpqpBADb+AWzSQHBIos
   cdmPUT09DH6a9drc8LDb7RSgIAE09WQi4yfHjTwCf/kU3v+i0q31k6MDZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1257921"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="1257921"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 19:14:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="32631435"
Received: from b49691a74b80.jf.intel.com ([10.165.54.183])
  by orviesa002.jf.intel.com with ESMTP; 08 Feb 2024 19:14:48 -0800
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
Subject: [RFC PATCH v4 08/15] perf stat: Add build string function and topdown events handling in hardware-grouping
Date: Thu,  8 Feb 2024 19:14:34 -0800
Message-ID: <20240209031441.943012-9-weilin.wang@intel.com>
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

Add the function to generate final grouping strings. This function is
very similar to the existing metricgroup__build_event_string() function.
The difference is that the input data includes a list of grouping lists.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 97 +++++++++++++++++++++++++++++++++--
 1 file changed, 93 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index f86e9a0b0d65..660c6b9b5fa7 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1978,6 +1978,96 @@ static int assign_event_grouping(struct metricgroup__event_info *e,
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
@@ -1989,8 +2079,8 @@ static int assign_event_grouping(struct metricgroup__event_info *e,
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
@@ -2006,6 +2096,7 @@ static int create_grouping(struct list_head *pmu_info_list,
 		if (ret)
 			goto out;
 	}
+	ret = hw_aware_metricgroup__build_event_string(groupings, modifier, &groups);
 out:
 	metricgroup__free_group_list(&groups);
 	return ret;
@@ -2035,8 +2126,6 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
 	hashmap__for_each_entry(ctx->ids, cur, bkt) {
 		const char *id = cur->pkey;
 
-		pr_debug("found event %s\n", id);
-
 		ret = get_metricgroup_events(id, etable, &event_info_list);
 		if (ret)
 			goto err_out;
-- 
2.42.0


