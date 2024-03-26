Return-Path: <linux-kernel+bounces-119916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF1E88CEF1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE43A1FA0374
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFB413E89E;
	Tue, 26 Mar 2024 20:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JbkNdxqa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F92013D60B;
	Tue, 26 Mar 2024 20:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484974; cv=none; b=pYgq/dd0WZdJtk3It3qNsPGaKW9Fumg5cWfSLIhpQEHefEmFUtY0sFBA32PzavFBaLhGBMdL2qbIsEcgeVFDJLgfFw+WsqJ0y2K0fhccWnCq2vhXSIIFDJHoIUYHAepQslRAU4IXG97/MCBbnLGx08q/GF7jX0zsyVeHyUJhDE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484974; c=relaxed/simple;
	bh=4hlpqAQd5tKpB941Bi5b5enQ2JvIR959aRQ4GT535tA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DPytmeoGTupailKPcVyru09mvjhIKMfE1osa+9+HaolP6oLnMtV1EJQ+qqOy8f5655r0Ma3fKa4X616Lqx5JDTY7Q9H9WJBDUG3Puvb4yO/zzLLHAPd7wDQ3a0DcFoEpL9qCQTze/C6Kkq7hv7Txz9EwiXGHJ8yaos4XHGIjUjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JbkNdxqa; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711484972; x=1743020972;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4hlpqAQd5tKpB941Bi5b5enQ2JvIR959aRQ4GT535tA=;
  b=JbkNdxqaJXDHKXB2RlsqG/Sl19a6xawHf0eveWEHRQvGG2/VjkvH+ll+
   sATfcsAN9pWBPXUd5eCNMhIJMEf8NCHvCcJ5+Y1gBkjvOF68/u0lMb6SR
   IVZ5/2rDRo6N1ywfMb5iZ/IFw3TZR4T2gmAOJp4ZFqA3PvCR7JoKuRVp/
   1peD9TwJ19yD+KUOHg6UiMlVnVJouwjwZlK6qCSlIlnpSUTnhiTUcUzNf
   b03R/3TfMyCsB0gFCyj5Zyp2aM49ZRKZKON10X8nYeVSfj/5xb/XFTULe
   /nMgac8Snv5KL0emBVhwcZFgt1ek1bTnlgv55lj1s4wNxZMrmik+mVjV7
   A==;
X-CSE-ConnectionGUID: R1d/17SyRReLnepekwL51g==
X-CSE-MsgGUID: 6gZCgWe9RuKhutePbKSbEw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="24049071"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="24049071"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 13:29:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="16162994"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa008.fm.intel.com with ESMTP; 26 Mar 2024 13:29:31 -0700
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
Subject: [RFC PATCH v5 0/6] TPEBS counting mode support
Date: Tue, 26 Mar 2024 16:28:53 -0400
Message-ID: <20240326202859.960577-1-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

Changes in v5:
- Update code and add comments for better code quality [Ian]

v4: https://lore.kernel.org/all/20240312234921.812685-1-weilin.wang@intel.com/

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
 tools/perf/util/data.c                        |    3 +
 tools/perf/util/data.h                        |    5 +
 tools/perf/util/metricgroup.c                 |   88 +-
 tools/perf/util/metricgroup.h                 |   22 +-
 tools/perf/util/stat-display.c                |   65 +
 tools/perf/util/stat-shadow.c                 |   19 +
 tools/perf/util/stat.h                        |    4 +
 10 files changed, 3076 insertions(+), 19 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.json

--
2.43.0


