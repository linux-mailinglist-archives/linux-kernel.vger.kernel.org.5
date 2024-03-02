Return-Path: <linux-kernel+bounces-89249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7515686ED3D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 129D7B248C2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E049EBE;
	Sat,  2 Mar 2024 00:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K2MZNme9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F6818E;
	Sat,  2 Mar 2024 00:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709338308; cv=none; b=FNHm1A1Q/iBjrC3gtOHC9E/8rGbE3hFTJ3x4K2nCuwJd1+v54f9fAhOqy5+LcWpZfGJk9oQ0Dxkd2scQkg5rPDZAjkYqpH3SS3PcVe2SRHDECHoD99nTuYSsVtCJ7B1A5a63EeHPpszcIymms7xQAG7HQw2gwbujSm4Oy2OzScA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709338308; c=relaxed/simple;
	bh=YbbN4/2I6FjwwqjnWSCQGvc02IAtIL2K9ffSxBw2VkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OhixWz56PBZSUnGS4sKS1+6CmElG4eSTxq7jr3XyMCVcgkTuCZjrEOzKXMQL03kIdsEk+UhIswycv7NAeyVJIndsX/2TKZN4tc06ljFWyDnBkV54lNQ1hdcQobEJY9a0sj11rsJqNkxrLi4b1Zf90DJHRJMW8okWjkp1RjX55EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K2MZNme9; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709338307; x=1740874307;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YbbN4/2I6FjwwqjnWSCQGvc02IAtIL2K9ffSxBw2VkM=;
  b=K2MZNme9CbbvPA4m3l/Y3hT5tB9qzsAXrSCbVYZnT9APuYGwm6YmNnDC
   lWgkHRPxfRsuhKP4bvhjHdgGtCQH7QFe5S17lPNplL7UdvAIRE6QhDKxB
   tGyFnzLgdcTpVTXjk8odzgpbVECPjvLfuFMv5JN2y7nha/v7Tl1ndbxSm
   LENh+ge3KVqyfMMz5VlMtIEPoekChp6AP3tbjmzWE7KPk9z1hwi01lNy2
   yCAneM3cazhkOHCGteO0TWiR9wTuUcwckvabBLXQP7wCYSbwkYTyPVhHl
   nPWZaVOI3CLaUX5Rii1zhdzsQXlrnkqghOZ8cY4mio/MW7X81q4/bQO69
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="4476129"
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="4476129"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 16:11:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="13054628"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by orviesa005.jf.intel.com with ESMTP; 01 Mar 2024 16:11:45 -0800
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: [RFC PATCH v3 0/6] TPEBS counting mode support
Date: Fri,  1 Mar 2024 19:11:32 -0500
Message-ID: <20240302001139.604829-1-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

Changes in v3:
- Remove ':' when event name has '@' [Ian]
- Use 'R' as the modifier instead of "retire_latency" [Ian]

v2: https://lore.kernel.org/all/20240228161227.484886-1-weilin.wang@intel.com/

Weilin Wang (6):
  perf stat: Parse and find tpebs events when parsing metrics to prepare
    for perf record sampling
  perf stat: Fork and launch perf record when perf stat needs to get
    retire latency value for a metric.
  perf stat: Add retire latency values into the expr_parse_ctx to
    prepare for final metric calculation
  perf stat: Create another thread for sample data processing
  perf stat: Add retire latency print functions to print out at the very
    end of print out
  perf vendor events intel: Add MTL metric json files

 tools/perf/builtin-stat.c                     |  222 +-
 .../arch/x86/meteorlake/metricgroups.json     |  127 +
 .../arch/x86/meteorlake/mtl-metrics.json      | 2547 +++++++++++++++++
 tools/perf/util/data.c                        |    4 +
 tools/perf/util/data.h                        |    1 +
 tools/perf/util/metricgroup.c                 |   81 +-
 tools/perf/util/metricgroup.h                 |   18 +-
 tools/perf/util/stat-display.c                |   65 +
 tools/perf/util/stat-shadow.c                 |   18 +
 tools/perf/util/stat.h                        |    5 +
 10 files changed, 3069 insertions(+), 19 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.json

--
2.43.0


