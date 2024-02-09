Return-Path: <linux-kernel+bounces-58967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBBB84EF4B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E44931C240D3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E3A5663;
	Fri,  9 Feb 2024 03:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C6rpb2Ks"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386144C6F;
	Fri,  9 Feb 2024 03:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707448491; cv=none; b=uQGumUzI7KnbNoCFXd3L5Vb/h1QHatKHNz3qg53VxBY9revm6znP62UxNaDTqbph4kLDa993V7ITCIH6EbQt40cTyZuDDW1f0h0KDUT55RbR4K0N/42uyP7gCDmnkL3d2WB7i3G6buYBX4Nwx61qMzdHgodga1zsVuAUR4bAc0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707448491; c=relaxed/simple;
	bh=eIAG1lzH2RfVMJ7M1xyrOqwbKw0bArWx7n920cAVzVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0aB33fujvyJRFmq+VIJUZuQ+ZArEHcIgmOo+3eqO2WZdNJkEYilMNUWHkDEltR7Y61OLpMdTzWxGWoifhkerN3t8y3kBq44ojQimgeC69ZNxAeV/RMzfYJwxj4MwReoh9tP8lHj3y9gcmJZ2ug8Dt01zMije9YCbC8Dw648CPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C6rpb2Ks; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707448489; x=1738984489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eIAG1lzH2RfVMJ7M1xyrOqwbKw0bArWx7n920cAVzVs=;
  b=C6rpb2KsTN8biYoEuNKkES23bVx/kEGinN2MRJX3c/YyXLLZqk0nr8Yb
   Q3woLNgHYQTSpRFUmacu3c5+IE29tTYAkW/AXGv6dnzfs+UAHWLWKz5Ud
   s0TkCBPEQj8wwIcSWgaeuWz84CePZZitN6r98Y/D4F6FijzzMPcedaNqC
   qsmiH9qDTwUxo9ABn6/OLSo7tOqddRooWO2RGrImRiZjgGAqnGo0e18XP
   jrxnvsV2DXCY2FU1M7ZJE0nr7g/bcq8q6LzAwIUulpU1uXrceBKRWWcQF
   Y3F6F8EVutSM3c0R4R+ju3Y5UyWs9lap99PABe/vDE7vPH00OigV4XzTp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1257875"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="1257875"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 19:14:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="32631404"
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
Subject: [RFC PATCH v4 01/15] perf stat: Add new field in stat_config to enable hardware aware grouping.
Date: Thu,  8 Feb 2024 19:14:27 -0800
Message-ID: <20240209031441.943012-2-weilin.wang@intel.com>
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

Hardware counter and event information could be used to help creating event
groups that better utilize hardware counters and improve multiplexing.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/builtin-stat.c     | 5 +++++
 tools/perf/util/metricgroup.c | 5 +++++
 tools/perf/util/metricgroup.h | 1 +
 tools/perf/util/stat.h        | 1 +
 4 files changed, 12 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 5fe9abc6a524..d08a40c4bae1 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2062,6 +2062,7 @@ static int add_default_attributes(void)
 						stat_config.metric_no_threshold,
 						stat_config.user_requested_cpu_list,
 						stat_config.system_wide,
+						stat_config.hardware_aware_grouping,
 						&stat_config.metric_events);
 	}
 
@@ -2095,6 +2096,7 @@ static int add_default_attributes(void)
 						stat_config.metric_no_threshold,
 						stat_config.user_requested_cpu_list,
 						stat_config.system_wide,
+						stat_config.hardware_aware_grouping,
 						&stat_config.metric_events);
 	}
 
@@ -2129,6 +2131,7 @@ static int add_default_attributes(void)
 						/*metric_no_threshold=*/true,
 						stat_config.user_requested_cpu_list,
 						stat_config.system_wide,
+						stat_config.hardware_aware_grouping,
 						&stat_config.metric_events) < 0)
 			return -1;
 	}
@@ -2170,6 +2173,7 @@ static int add_default_attributes(void)
 							/*metric_no_threshold=*/true,
 							stat_config.user_requested_cpu_list,
 							stat_config.system_wide,
+							stat_config.hardware_aware_grouping,
 							&stat_config.metric_events) < 0)
 				return -1;
 
@@ -2702,6 +2706,7 @@ int cmd_stat(int argc, const char **argv)
 						stat_config.metric_no_threshold,
 						stat_config.user_requested_cpu_list,
 						stat_config.system_wide,
+						stat_config.hardware_aware_grouping,
 						&stat_config.metric_events);
 
 		zfree(&metrics);
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index ca3e0404f187..18df1af4bdd3 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1690,12 +1690,17 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
 			      bool metric_no_threshold,
 			      const char *user_requested_cpu_list,
 			      bool system_wide,
+			      bool hardware_aware_grouping,
 			      struct rblist *metric_events)
 {
 	const struct pmu_metrics_table *table = pmu_metrics_table__find();
 
 	if (!table)
 		return -EINVAL;
+	if (hardware_aware_grouping) {
+		pr_debug("Use hardware aware grouping instead of traditional metric grouping method\n");
+	}
+
 
 	return parse_groups(perf_evlist, pmu, str, metric_no_group, metric_no_merge,
 			    metric_no_threshold, user_requested_cpu_list, system_wide,
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index d5325c6ec8e1..779f6ede1b51 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -77,6 +77,7 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
 			      bool metric_no_threshold,
 			      const char *user_requested_cpu_list,
 			      bool system_wide,
+			      bool hardware_aware_grouping,
 			      struct rblist *metric_events);
 int metricgroup__parse_groups_test(struct evlist *evlist,
 				   const struct pmu_metrics_table *table,
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 4357ba114822..a7798506465b 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -86,6 +86,7 @@ struct perf_stat_config {
 	bool			 metric_no_group;
 	bool			 metric_no_merge;
 	bool			 metric_no_threshold;
+	bool			 hardware_aware_grouping;
 	bool			 stop_read_counter;
 	bool			 iostat_run;
 	char			 *user_requested_cpu_list;
-- 
2.42.0


