Return-Path: <linux-kernel+bounces-57965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD76584DFCC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09268B276EA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F0A74E01;
	Thu,  8 Feb 2024 11:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mChSWcZR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC7C76037;
	Thu,  8 Feb 2024 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707391935; cv=none; b=UA6jVeYfpfGk9DhwHc6N08F/jfBxkUi9LZkWXpTdpPhl/+YSbgjldK8fGFFCkZ+DLVImGIfA4BzavXhbpdkSLZWAXTQozwDFdG/cKYHQkR3A1CgFE/EUzvxcwf86HN8ucLltyfzjeJ93KmtS5V1cU0v3i0mx2h0olfH89Mrb0j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707391935; c=relaxed/simple;
	bh=/uNuO1osfQ/KqtLrzS800xAbLzNCQEyTMRkrAuppesM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gdzduZy3CV2GkM/I3rNXet/AFbP7KSw5TTmyiPKKUGG/pd9m/tkhBqwQOHCJy5t0fbAyr5oiDXbWWUqXUPYTsk1tQHoqEQ/2zaOA1XiLD+rEsTszFJnLS2pVMY/ldyncKP53EFuzyYFNihX8Qbfzq4VTiWvIPG6u5vssb2M1oZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mChSWcZR; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707391934; x=1738927934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/uNuO1osfQ/KqtLrzS800xAbLzNCQEyTMRkrAuppesM=;
  b=mChSWcZR4jRIH6JuZiyZhMyf6D3l9gXnwyUGtufWBArJ2YRJopCQVas/
   Lp4IuYexIOwu/Lo0gGEJ7/lRU4Ig7LTZcZmxz2eoBRzUTPHhUmHN/9VbH
   nQY6OAzbDTj1B9L4XiywVWOR9LyCwRF9ghQW5zqxMi3Rb3rLFTRDBozRS
   ZBHiEe1JDy80XQnotqJbHAdsMUJYifl0uZxMVL64lvkHxv/b76/lW/HRB
   PUcWqGpmfrAREDqntNAO2eH9Pk18EIKVvTqdZHcxvUjJDvwY4vtENYWbq
   o6V5UEMXMNVddHDosSYriH2CUExSk0SRw4wh2dO34HUx7+vFakoyassrG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1345594"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1345594"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 03:32:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1957534"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.219.88])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 03:32:08 -0800
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
Subject: [PATCH V5 05/12] perf tools: Enable evsel__is_aux_event() to work for S390_CPUMSF
Date: Thu,  8 Feb 2024 13:31:20 +0200
Message-Id: <20240208113127.22216-6-adrian.hunter@intel.com>
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

evsel__is_aux_event() identifies AUX area tracing selected events.

S390_CPUMSF uses a raw event type (PERF_TYPE_RAW - refer
s390_cpumsf_evsel_is_auxtrace()) not a PMU type value that could be checked
in evsel__is_aux_event(). However it sets needs_auxtrace_mmap (refer
auxtrace_record__init()), so check that first.

Currently, the features that use evsel__is_aux_event() are used only by
Intel PT, but that may change in the future.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 437386dedd5c..40be43f1f648 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1099,8 +1099,12 @@ void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu)
 
 bool evsel__is_aux_event(const struct evsel *evsel)
 {
-	struct perf_pmu *pmu = evsel__find_pmu(evsel);
+	struct perf_pmu *pmu;
+
+	if (evsel->needs_auxtrace_mmap)
+		return true;
 
+	pmu = evsel__find_pmu(evsel);
 	return pmu && pmu->auxtrace;
 }
 
-- 
2.34.1


