Return-Path: <linux-kernel+bounces-57963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C7C84DFC3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38915284A8A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037C47318E;
	Thu,  8 Feb 2024 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OyCRs2B7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622266F50F;
	Thu,  8 Feb 2024 11:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707391930; cv=none; b=J4WzP58k2KpS2V+Wr43DV6NwkJMMWpx+FD4gdfFZuLM8E5ixJh3QHF8LUMpdR/mpB6ajIju+HNThbLnGzGZ7qWqa7i3fdS1KRj6Z0V92QSY5tCNn6PFX7KU0AqyLyQ/skMm5T5QXmBCR1QFUjLDAZigs++dz+tecN4ig9mETuNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707391930; c=relaxed/simple;
	bh=ltm4BNE1kVbTScZPdTe85e8QfDDAc7SPDrUZuF1fT8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e4KuyrrWmPawjeoMCYjk0JO/VUaidlU/3/yM7Dbx0ta8bcMrIveoIF96F3uGXJuPZsOqYWEf04ueZqoJEHv8Hwest2++P2n1jamFlVgQdSWaoO1I6io8mki1Ri4Pei3V77YDWbmX3irqj8M9FMn/8ig9Yu2D2/b4sqYJLB29CXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OyCRs2B7; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707391929; x=1738927929;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ltm4BNE1kVbTScZPdTe85e8QfDDAc7SPDrUZuF1fT8Y=;
  b=OyCRs2B7WPntVcGUgb1QfC1mCFWh5uQewg11Su78W3Tbu5M3NBQfywSb
   oedbolZCjwP9Gj3CmGuzQq5UNOOlK5n97hRoFjM4TqN2E8fBg76t4OON+
   4HJl7j4W+pOayRCiUnE0Y5RzrrVSBN9EFn+TbMbnSWATdlGWnZBPjvzW/
   IwBWbnFDGOFDJdj4s8A5LQzJqwH+OLJQK6sI/8NN3RL7ltiyMy8fHJfSu
   LNl/oVlybhKUiH/zqijMHNw0+PlGIKqbjS/A+wqRoB2TXJuGLuA8nBdqu
   G2ez/UfOgB4xk1kuNEBwHMzU/A9nM8hbY3bk13fY6tiod5XlNjJ+41Tpb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1345552"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1345552"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 03:32:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1957506"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.219.88])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 03:32:02 -0800
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
Subject: [PATCH V5 04/12] perf tools: Enable evsel__is_aux_event() to work for ARM/ARM64
Date: Thu,  8 Feb 2024 13:31:19 +0200
Message-Id: <20240208113127.22216-5-adrian.hunter@intel.com>
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

Set pmu->auxtrace on ARM/ARM64 AUX area PMUs. evsel__is_aux_event() needs
the setting to identify AUX area tracing selected events.

Currently, the features that use evsel__is_aux_event() are used only by
Intel PT, but that may change in the future.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm/util/pmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
index 8b7cb68ba1a8..668a4310cb69 100644
--- a/tools/perf/arch/arm/util/pmu.c
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -20,16 +20,19 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
 #ifdef HAVE_AUXTRACE_SUPPORT
 	if (!strcmp(pmu->name, CORESIGHT_ETM_PMU_NAME)) {
 		/* add ETM default config here */
+		pmu->auxtrace = true;
 		pmu->selectable = true;
 		pmu->perf_event_attr_init_default = cs_etm_get_default_config;
 #if defined(__aarch64__)
 	} else if (strstarts(pmu->name, ARM_SPE_PMU_NAME)) {
+		pmu->auxtrace = true;
 		pmu->selectable = true;
 		pmu->is_uncore = false;
 		pmu->perf_event_attr_init_default = arm_spe_pmu_default_config;
 		if (!strcmp(pmu->name, "arm_spe_0"))
 			pmu->mem_events = perf_mem_events_arm;
 	} else if (strstarts(pmu->name, HISI_PTT_PMU_NAME)) {
+		pmu->auxtrace = true;
 		pmu->selectable = true;
 #endif
 	}
-- 
2.34.1


