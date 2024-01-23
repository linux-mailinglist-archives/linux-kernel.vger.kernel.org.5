Return-Path: <linux-kernel+bounces-35927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EE48398E0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F42E1F27A5C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD7682D92;
	Tue, 23 Jan 2024 18:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EL/5EY8h"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081EA482F5;
	Tue, 23 Jan 2024 18:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035873; cv=none; b=B0c4Tkm4pe7xqTIIMFj3JLDfzILQ2eDlC+jc229eNc2meTl7FsXjUDnVCQJBzM+S9WkcBGTegVfykUB2UAVOQyFZfcm3+c8MPcDrlnx08624Z3+A7B9PIstZyKsUq68FPZfbhdqOlXCZx4alm9ddbyg01LW+Q7jtcOGGyr+rQEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035873; c=relaxed/simple;
	bh=YMOcb6hl8iUDrjLlIf8ciPA+xalxhlTzrF2htcHhtSE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a49TrcilQDotjYx/p/PuxpIJ8ctnA+sDc5nnjZj0Fi4yegNVJVpH/4uRNDnBZVTGXUOr9b0c5v6/p10hY6rPuhLhAOKbIqg8ifK3aeAk2dGV8op9phKmUuKMIgtF07FnaB210ytfLEuUv3fr42AyDqDypObdnTeVVhSq04kOz4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EL/5EY8h; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706035871; x=1737571871;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YMOcb6hl8iUDrjLlIf8ciPA+xalxhlTzrF2htcHhtSE=;
  b=EL/5EY8hK7uJCEcD53vy/VBNocJajq/bFqjU3SaXplMczyzUyBFGD2yI
   CCChOgEknfAax2t/xakE9rkwKT7zFUGEgRyrmO7LKe7ss92gFMBL+PDIJ
   pSbxcYZpl29tWOxZ8SeQW2RrYs3V59mzvtq1oVCTECBwEFGdsdROK9nqq
   gOpJubVjxj8iJMybf46lJZ4GnsdWvQtPIh+rAmvLoyqByQWm3zphsE60p
   EZFTPctjySaVVkh+acH3XtAlsnObRDo7YTNg4KyuH74F2cNfeCYXJ3QQT
   uuhgVtYmFX39kUri+8vzvVE5jTflUpmgbzyZWX/KqEPwTeOp+7C+/cYAm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="400487430"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="400487430"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:51:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="1764008"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa004.fm.intel.com with ESMTP; 23 Jan 2024 10:51:10 -0800
From: kan.liang@linux.intel.com
To: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	peterz@infradead.org,
	mingo@redhat.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	john.g.garry@oracle.com,
	will@kernel.org,
	james.clark@arm.com,
	mike.leach@linaro.org,
	leo.yan@linaro.org,
	yuhaixin.yhx@linux.alibaba.com,
	renyu.zj@linux.alibaba.com,
	tmricht@linux.ibm.com,
	ravi.bangoria@amd.com,
	atrajeev@linux.vnet.ibm.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 0/7] Clean up perf mem
Date: Tue, 23 Jan 2024 10:50:29 -0800
Message-Id: <20240123185036.3461837-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Changes since V3:
- Fix the powerPC building error (Kajol Jain)
- The s390 does not support perf mem. Remove the code. (Thomas)
- Add reviewed-by and tested-by from Kajol Jain for patch 1 and 2
- Add tested-by from Leo

Changes since V2:
- Fix the Arm64 building error (Leo)
- Add two new patches to clean up perf_mem_events__record_args()
  and perf_pmus__num_mem_pmus() (Leo)

Changes since V1:
- Fix strcmp of PMU name checking (Ravi)
- Fix "/," typo (Ian)
- Rename several functions with perf_pmu__mem_events prefix. (Ian)
- Fold the header removal patch into the patch where the cleanups made.
  (Arnaldo)
- Add reviewed-by and tested-by from Ian and Ravi

As discussed in the below thread, the patch set is to clean up perf mem.
https://lore.kernel.org/lkml/afefab15-cffc-4345-9cf4-c6a4128d4d9c@linux.intel.com/

Introduce generic functions perf_mem_events__ptr(),
perf_mem_events__name() ,and is_mem_loads_aux_event() to replace the
ARCH specific ones.
Simplify the perf_mem_event__supported().

Only keeps the ARCH-specific perf_mem_events array in the corresponding
mem-events.c for each ARCH.

There is no functional change.

The patch set touches almost all the ARCHs, Intel, AMD, ARM, Power and
etc. But I can only test it on two Intel platforms.
Please give it try, if you have machines with other ARCHs.

Here are the test results:
Intel hybrid machine:

$perf mem record -e list
ldlat-loads  : available
ldlat-stores : available

$perf mem record -e ldlat-loads -v --ldlat 50
calling: record -e cpu_atom/mem-loads,ldlat=50/P -e cpu_core/mem-loads,ldlat=50/P

$perf mem record -v
calling: record -e cpu_atom/mem-loads,ldlat=30/P -e cpu_atom/mem-stores/P -e cpu_core/mem-loads,ldlat=30/P -e cpu_core/mem-stores/P

$perf mem record -t store -v
calling: record -e cpu_atom/mem-stores/P -e cpu_core/mem-stores/P


Intel SPR:
$perf mem record -e list
ldlat-loads  : available
ldlat-stores : available

$perf mem record -e ldlat-loads -v --ldlat 50
calling: record -e {cpu/mem-loads-aux/,cpu/mem-loads,ldlat=50/}:P

$perf mem record -v
calling: record -e {cpu/mem-loads-aux/,cpu/mem-loads,ldlat=30/}:P -e cpu/mem-stores/P

$perf mem record -t store -v
calling: record -e cpu/mem-stores/P

Kan Liang (7):
  perf mem: Add mem_events into the supported perf_pmu
  perf mem: Clean up perf_mem_events__ptr()
  perf mem: Clean up perf_mem_events__name()
  perf mem: Clean up perf_mem_event__supported()
  perf mem: Clean up is_mem_loads_aux_event()
  perf mem: Clean up perf_mem_events__record_args()
  perf mem: Clean up perf_pmus__num_mem_pmus()

 tools/perf/arch/arm/util/pmu.c            |   3 +
 tools/perf/arch/arm64/util/mem-events.c   |  39 +---
 tools/perf/arch/arm64/util/mem-events.h   |   7 +
 tools/perf/arch/powerpc/util/Build        |   1 +
 tools/perf/arch/powerpc/util/mem-events.c |  16 +-
 tools/perf/arch/powerpc/util/mem-events.h |   7 +
 tools/perf/arch/powerpc/util/pmu.c        |  12 ++
 tools/perf/arch/x86/util/mem-events.c     |  99 ++--------
 tools/perf/arch/x86/util/mem-events.h     |  10 +
 tools/perf/arch/x86/util/pmu.c            |  19 +-
 tools/perf/builtin-c2c.c                  |  45 ++---
 tools/perf/builtin-mem.c                  |  48 ++---
 tools/perf/util/mem-events.c              | 217 +++++++++++++---------
 tools/perf/util/mem-events.h              |  19 +-
 tools/perf/util/pmu.c                     |   4 +-
 tools/perf/util/pmu.h                     |   7 +
 tools/perf/util/pmus.c                    |   6 -
 tools/perf/util/pmus.h                    |   1 -
 18 files changed, 279 insertions(+), 281 deletions(-)
 create mode 100644 tools/perf/arch/arm64/util/mem-events.h
 create mode 100644 tools/perf/arch/powerpc/util/mem-events.h
 create mode 100644 tools/perf/arch/powerpc/util/pmu.c
 create mode 100644 tools/perf/arch/x86/util/mem-events.h

-- 
2.35.1


