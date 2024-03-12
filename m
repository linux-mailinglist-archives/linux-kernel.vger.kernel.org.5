Return-Path: <linux-kernel+bounces-100930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 414C6879FC9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F661C217FE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DEF482FE;
	Tue, 12 Mar 2024 23:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j/DoIPeG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8105F482CD;
	Tue, 12 Mar 2024 23:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710287375; cv=none; b=oRsuI8fpKy9ZvwHw1Ird+ITzqvrS3pexaWFLh4e/nmlx0Ip7mhlGGMd0fM1HEY3RiVqyvYzP80exNVUdIf70+KvFiv2gFYF52mbLCSE7JtAiNGfsDDp6IUy/Em1LVU1fsMmXTxrZqPAQrjwSb5hvjjEVoLbgQBzSNvn3U9AAoIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710287375; c=relaxed/simple;
	bh=OtolE6CfIog4+s2OsadQub4oH1qqtGz/aAJ3MFhUzus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UK0lI0Q/Pq0uDUb73uzumKJl2OyM85NGCIJn9lqdjgUQbi4+/qTMep99P4IbNAaB5evP+Qrq8RsGVs2JJmCHtLRYmri87l5u0332Rk3StWkNQOwlMVfo6MLgQjc/NQ0gM6U+/075XTEGHnA2SDtvQbCRu0yfKJzwdFmeY3H+DX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j/DoIPeG; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710287373; x=1741823373;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OtolE6CfIog4+s2OsadQub4oH1qqtGz/aAJ3MFhUzus=;
  b=j/DoIPeGckomc2OAs4mRLh5J46Kory4DPegxTD75aaVrJXVjxIUdwHNi
   eIyRL6Vso54HEAPzal/N4bLTKe0Vmu1w1QbNsAolRCmrWQQykIIovqv0x
   aeaS75V4qz8g80nETxY84GXTwPzdLp1NVhiFEs2jtkxms6rVNRfjOLtq3
   6oJ079kPr+k+5Z9ifa1leRVEAXrsB9jd9JAzw77lMTOpLBnTY7992rtO/
   kJxeDfO938/BAYUKYgVvWrlYkePNfv2ww31D4C0dCacdAsPVichcxxvEY
   qEkGjYZcHQ96Ma9yfb5iws8KEfC4vvebgVlgO6eTFqButs46CqeZ9m8rU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="8847684"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="8847684"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 16:49:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="42715663"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa001.fm.intel.com with ESMTP; 12 Mar 2024 16:49:32 -0700
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: [RFC PATCH v4 0/6] TPEBS counting mode support
Date: Tue, 12 Mar 2024 19:49:15 -0400
Message-ID: <20240312234921.812685-1-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

Changes in v4:
- Remove uncessary debug print and update code and comments for better
readability and quality [Namhyung]
- Update mtl metric json file with consistent TmaL1 and TopdownL1 metricgroup

v3: https://lore.kernel.org/all/20240302001139.604829-1-weilin.wang@intel.com/

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

 tools/perf/builtin-stat.c                     |  211 +-
 .../arch/x86/meteorlake/metricgroups.json     |  127 +
 .../arch/x86/meteorlake/mtl-metrics.json      | 2551 +++++++++++++++++
 tools/perf/util/data.c                        |    4 +
 tools/perf/util/data.h                        |    1 +
 tools/perf/util/metricgroup.c                 |   88 +-
 tools/perf/util/metricgroup.h                 |   23 +-
 tools/perf/util/stat-display.c                |   65 +
 tools/perf/util/stat-shadow.c                 |   19 +
 tools/perf/util/stat.h                        |    4 +
 10 files changed, 3074 insertions(+), 19 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.json

--
2.43.0


