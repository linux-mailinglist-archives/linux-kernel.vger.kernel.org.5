Return-Path: <linux-kernel+bounces-57959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4287584DFBE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 680D8B25880
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08771DFCE;
	Thu,  8 Feb 2024 11:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A6syVpbv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8E51E884;
	Thu,  8 Feb 2024 11:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707391907; cv=none; b=AGGBaKBQeMMtSNivEowB9KJp8rDZ48ln3MzCYwC0wqHgwt7wn3vRTOi/8PUKwOtNscuXYRS2Edg7Cg6R5co9+BSaeZ7igIg9xYSiJNqPO2A4kngoRC+n1uSM8QW3ruqiKRQ4UG/d/sULpmm264gFOz3tbSmDmhNHRMIszbTB/Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707391907; c=relaxed/simple;
	bh=+Lq1+Yjwc1/TnXA6RrghdQBok9enssN3fOFULsujD9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iWKb0seoD7Ia5DH0Tames/GJbtD3osetNhZtUkC5puzjlmkYVe1FwgEIMJVEvaHkLSeHWnvQ3Euq5bYEvsPe0aNujzQHopW66WBmc9O46gt05t0lrE6P05NXchbtPqyn/WIGr3e2plZCs5mqXIzyAb3U0LTg+2SZPpFdbXjWAmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A6syVpbv; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707391905; x=1738927905;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+Lq1+Yjwc1/TnXA6RrghdQBok9enssN3fOFULsujD9Y=;
  b=A6syVpbv4AH0Fpe8JEDyPRVaAV+wYdmIox2EbSmoezPdPUoga+mSz+c8
   JRaKRCfR7xuj7R7RoszdkDMMCs3bRZUykeQHPJnzy6E8lziCnoTygsIji
   19Su1G2NgoYvP4rmkz0i4WYtEjHlVA+AfgzkrHUdHULYYBkZLNU8VfXfk
   M5/310i5CeJHUi6JCdFWpcdEPhb7cD07OwyiyWZEBz7Igx2/yUEkFRbqK
   QOzOw3BtckUsbUpy3ffiCQasSaoXEqm0P/i92rSqPefuUybap6Y2LZ+y5
   9z/WC+2J0lUyEtuHzMM994QwyMdhmnxxboq4anHsw6IIuX9E1pXSaJ6AJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1345406"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1345406"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 03:31:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1957417"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.219.88])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 03:31:38 -0800
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
Subject: [PATCH V5 00/12] perf/core: Add ability for an event to "pause" or "resume" AUX area tracing
Date: Thu,  8 Feb 2024 13:31:15 +0200
Message-Id: <20240208113127.22216-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Hi

Hardware traces, such as instruction traces, can produce a vast amount of
trace data, so being able to reduce tracing to more specific circumstances
can be useful.

The ability to pause or resume tracing when another event happens, can do
that.

These patches add such a facilty and show how it would work for Intel
Processor Trace.

Maintainers of other AUX area tracing implementations are requested to
consider if this is something they might employ and then whether or not
the ABI would work for them.  Note, thank you to James Clark (ARM) for
evaluating the API for Coresight.  Suzuki K Poulose (ARM) also responded
positively to the RFC.

Changes to perf tools are now (since V4) fleshed out.


Changes in V5:

    perf/core: Add aux_pause, aux_resume, aux_start_paused
	Added James' Ack

    perf/x86/intel: Do not enable large PEBS for events with aux actions or aux sampling
	New patch

    perf tools
	Added Ian's Ack

Changes in V4:

    perf/core: Add aux_pause, aux_resume, aux_start_paused
	Rename aux_output_cfg -> aux_action
	Reorder aux_action bits from:
		aux_pause, aux_resume, aux_start_paused
	to:
		aux_start_paused, aux_pause, aux_resume
	Fix aux_action bits __u64 -> __u32

    coresight: Have a stab at support for pause / resume
	Dropped

    perf tools
	All new patches

Changes in RFC V3:

    coresight: Have a stab at support for pause / resume
	'mode' -> 'flags' so it at least compiles

Changes in RFC V2:

	Use ->stop() / ->start() instead of ->pause_resume()
	Move aux_start_paused bit into aux_output_cfg
	Tighten up when Intel PT pause / resume is allowed
	Add an example of how it might work for CoreSight


Adrian Hunter (12):
      perf/core: Add aux_pause, aux_resume, aux_start_paused
      perf/x86/intel/pt: Add support for pause / resume
      perf/x86/intel: Do not enable large PEBS for events with aux actions or aux sampling
      perf tools: Enable evsel__is_aux_event() to work for ARM/ARM64
      perf tools: Enable evsel__is_aux_event() to work for S390_CPUMSF
      perf tools: Add aux_start_paused, aux_pause and aux_resume
      perf tools: Add aux-action config term
      perf tools: Parse aux-action
      perf tools: Add missing_features for aux_start_paused, aux_pause, aux_resume
      perf intel-pt: Improve man page format
      perf intel-pt: Add documentation for pause / resume
      perf intel-pt: Add a test for pause / resume

 arch/x86/events/intel/core.c               |  10 +-
 arch/x86/events/intel/pt.c                 |  63 ++-
 arch/x86/events/intel/pt.h                 |   4 +
 include/linux/perf_event.h                 |  15 +
 include/uapi/linux/perf_event.h            |  11 +-
 kernel/events/core.c                       |  72 +++-
 kernel/events/internal.h                   |   1 +
 tools/include/uapi/linux/perf_event.h      |  11 +-
 tools/perf/Documentation/perf-intel-pt.txt | 596 ++++++++++++++++++-----------
 tools/perf/Documentation/perf-record.txt   |   4 +
 tools/perf/arch/arm/util/pmu.c             |   3 +
 tools/perf/builtin-record.c                |   4 +-
 tools/perf/tests/shell/test_intel_pt.sh    |  28 ++
 tools/perf/util/auxtrace.c                 |  67 +++-
 tools/perf/util/auxtrace.h                 |   6 +-
 tools/perf/util/evsel.c                    |  13 +-
 tools/perf/util/evsel.h                    |   1 +
 tools/perf/util/evsel_config.h             |   1 +
 tools/perf/util/parse-events.c             |  10 +
 tools/perf/util/parse-events.h             |   1 +
 tools/perf/util/parse-events.l             |   1 +
 tools/perf/util/perf_event_attr_fprintf.c  |   3 +
 tools/perf/util/pmu.c                      |   6 +-
 23 files changed, 691 insertions(+), 240 deletions(-)


Regards
Adrian

