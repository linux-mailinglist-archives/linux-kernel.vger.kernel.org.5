Return-Path: <linux-kernel+bounces-58974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B99484EF53
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20D05B290A8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836A51EA78;
	Fri,  9 Feb 2024 03:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ORB6GULE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8909CFC19;
	Fri,  9 Feb 2024 03:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707448496; cv=none; b=BC+XIa+PXdpdhIQxfqB9ZhBuXoyH+uek6ypPMfv7XVJScs+Esn7MpTb49hVwFk3MaFkKe3hb8ZW17SV6wLOCaxGje5PgsUFyvQsXW1MAN63a/Q59+HtaERyUaWL4aM+5tQQZwazberMPxbvNzOOhNyXz8h5yOS/L6zFTBmj1lrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707448496; c=relaxed/simple;
	bh=QrlkCZNny4tWyjIwHE8jfNEOkLmWaf4ylMQufuD0nQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6DFCgbz2wtfLgqkYYFFwko0o0uFNvByrgyWAEfEcO6xgmy4E+0kzMg35y8CyyJzfKRTriJd05e9rZ3IRUFURDfDPguVpS5zGoaHOgRjz/aVCOXgH91iNpGFrxZodvWIzVXq//lE24WQoioJHPueOz6vAOVuMhga9WxSk0RoPMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ORB6GULE; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707448495; x=1738984495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QrlkCZNny4tWyjIwHE8jfNEOkLmWaf4ylMQufuD0nQI=;
  b=ORB6GULEezVp5amF0oxTFcOWmeUhYJkNtx+7sJfkXJmyI+oX61p+tclg
   u7icw3W57EyXw4aEeXYpWtQb29RJ1vgCncpW/VJS/bUxc7byWYo9BnEDl
   X4Sww2MKA/v0TluC9oAWYVwgHeJr/ywo2DIFY6g0ZjAlwkaOy/Ii0vyRN
   hdSzaj5n6gu58yWu24us2V0jr4VTTHrpZf4rpsmp2sDbapld3tBwpSV/c
   nxpGN/l2mTujB/ss/Vn7W9QU1ytoxN4w3tjBnETtVLZZS7JlJKEUnf8eQ
   NfPAOIw07gbn0Mc0wZT/vcjZ3B7gr4/xNJoJfdphd/d+TvWuIjQqJX8yQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1257931"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="1257931"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 19:14:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="32631438"
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
Subject: [RFC PATCH v4 09/15] perf stat: Add function to handle special events in hardware-grouping
Date: Thu,  8 Feb 2024 19:14:35 -0800
Message-ID: <20240209031441.943012-10-weilin.wang@intel.com>
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

There are some special events like topdown events and TSC that are not
described in pmu-event JSON files. Add support to handle this type of
events. This should be considered as a temporary solution because including
these events in JSON files would be a better solution.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 38 ++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 660c6b9b5fa7..a0579b0f81e5 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -160,6 +160,20 @@ struct metric {
 
 /* Maximum number of counters per PMU*/
 #define NR_COUNTERS	16
+/* Special events that are not described in pmu-event JSON files.
+ * topdown-* and TSC use dedicated registers, set as free
+ * counter for grouping purpose
+ */
+enum special_events {
+	TOPDOWN	= 0,
+	TSC	= 1,
+	SPECIAL_EVENT_MAX,
+};
+
+static const char *const special_event_names[SPECIAL_EVENT_MAX] = {
+	"topdown-",
+	"TSC",
+};
 
 /**
  * An event used in a metric. This info is for metric grouping.
@@ -2102,6 +2116,15 @@ static int create_grouping(struct list_head *pmu_info_list,
 	return ret;
 };
 
+static bool is_special_event(const char *id)
+{
+	for (int i = 0; i < SPECIAL_EVENT_MAX; i++) {
+		if (!strncmp(id, special_event_names[i], strlen(special_event_names[i])))
+			return true;
+	}
+	return false;
+}
+
 /**
  * hw_aware_build_grouping - Build event groupings by reading counter
  * requirement of the events and counter available on the system from
@@ -2126,6 +2149,17 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
 	hashmap__for_each_entry(ctx->ids, cur, bkt) {
 		const char *id = cur->pkey;
 
+		if (is_special_event(id)) {
+			struct metricgroup__event_info *event;
+
+			event = event_info__new(id, "default_core", "0",
+						/*free_counter=*/true);
+			if (!event)
+				goto err_out;
+
+			list_add(&event->nd, &event_info_list);
+			continue;
+		}
 		ret = get_metricgroup_events(id, etable, &event_info_list);
 		if (ret)
 			goto err_out;
@@ -2597,8 +2631,10 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
 		ret = hw_aware_parse_groups(perf_evlist, pmu, str,
 			    metric_no_threshold, user_requested_cpu_list, system_wide,
 			    /*fake_pmu=*/NULL, metric_events, table);
-		if (!ret)
+		if (!ret) {
+			pr_info("Hardware aware grouping completed\n");
 			return 0;
+		}
 	}
 
 	return parse_groups(perf_evlist, pmu, str, metric_no_group, metric_no_merge,
-- 
2.42.0


