Return-Path: <linux-kernel+bounces-57969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEC684DFDC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 990CDB289E1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC7F7640C;
	Thu,  8 Feb 2024 11:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dYH+3/b4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B8076417;
	Thu,  8 Feb 2024 11:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707391960; cv=none; b=X/iIpJBk747gTR+dHECkOkh1TOJ7fKeKgw5di26KP7APFdMKnRV8t5N1NLxmLf+MUB/sy1M0txWIvpMa1GQZXU1VbNDQaiDCu+yzFxZnDUOouV8ib/KjZkXneeCC8pG8okkRMSzWhDyHwU94d4+y9ZYWvSKaPD/9IL+wN7xpOsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707391960; c=relaxed/simple;
	bh=6DpUpJ1gq9LuRkJBX6BDqLjCRgV6K9lzl/yGpxHeMUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aq+O9sQEyg+HHd2VB5Vai0svyu6q0U2DKqr9BI3lCp/4siqGdTw9qVY7dDma3Bh3aH+O7RchBsO2SRfrloFaPocMc4hjqx9xJajFNGZFpmxLzMV0Qvzc83NwF5i/ZicpDs57NDzYtGPQkbry6P1UeFfwUlB7zcDMQtK3Ok/dRvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dYH+3/b4; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707391959; x=1738927959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6DpUpJ1gq9LuRkJBX6BDqLjCRgV6K9lzl/yGpxHeMUY=;
  b=dYH+3/b4lPFYwf5TIXEWpSBEhuDlIADspzz3xdS+X6YAVX0RL5LqFvyO
   r3H9bSmyDOnbZ+gAEI5ojwNifr+EucrsjVynxn/Hl4iradG7Zj/X76enE
   dM8PdixUvR9qB3ARKnjZ+HjeLPrdJKvAfNfbidCzE9+GHJ5nngP/2op7L
   12Mm7nB9XX5YuThTPO7XwP9S79duUzTezgxKuAoKu95RC+jHAEfB+e7G5
   OCAQ4PESi9NbD1+9DUttKpYc16rEVUHFSBVreEqfHb4CPk/VB4jA1eoWC
   2oixvukn7ppFGHqWxhShK4y+AJovBTR3fL/k6YrreMqmKFH6WQu5fcRbL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1345710"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1345710"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 03:32:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1957714"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.219.88])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 03:32:32 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V5 09/12] perf tools: Add missing_features for aux_start_paused, aux_pause, aux_resume
Date: Thu,  8 Feb 2024 13:31:24 +0200
Message-Id: <20240208113127.22216-10-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208113127.22216-1-adrian.hunter@intel.com>
References: <20240208113127.22216-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Display "feature is not supported" error message if aux_start_paused,
aux_pause or aux_resume result in a perf_event_open() error.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 10 +++++++++-
 tools/perf/util/evsel.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 8401685461bf..9d2fde919604 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1890,7 +1890,13 @@ bool evsel__detect_missing_features(struct evsel *evsel)
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
 	 */
-	if (!perf_missing_features.branch_counters &&
+	if (!perf_missing_features.aux_pause_resume &&
+	    (evsel->core.attr.aux_pause || evsel->core.attr.aux_resume ||
+	     evsel->core.attr.aux_start_paused)) {
+		perf_missing_features.aux_pause_resume = true;
+		pr_debug2_peo("Kernel has no aux_pause/aux_resume support, bailing out\n");
+		return false;
+	} else if (!perf_missing_features.branch_counters &&
 	    (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS)) {
 		perf_missing_features.branch_counters = true;
 		pr_debug2("switching off branch counters support\n");
@@ -3089,6 +3095,8 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			return scnprintf(msg, size, "clockid feature not supported.");
 		if (perf_missing_features.clockid_wrong)
 			return scnprintf(msg, size, "wrong clockid (%d).", clockid);
+		if (perf_missing_features.aux_pause_resume)
+			return scnprintf(msg, size, "The 'aux_pause / aux_resume' feature is not supported, update the kernel.");
 		if (perf_missing_features.aux_output)
 			return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
 		if (!target__has_cpu(target))
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 517cff431de2..8ef5a6fdbd45 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -192,6 +192,7 @@ struct perf_missing_features {
 	bool weight_struct;
 	bool read_lost;
 	bool branch_counters;
+	bool aux_pause_resume;
 };
 
 extern struct perf_missing_features perf_missing_features;
-- 
2.34.1


