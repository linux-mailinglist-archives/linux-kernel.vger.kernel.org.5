Return-Path: <linux-kernel+bounces-163311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3378B6939
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE2CDB210BE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C8310A36;
	Tue, 30 Apr 2024 03:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MPnP00Mm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDD2DDA6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 03:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714449001; cv=none; b=WAUgOadT8H1xbMP8zDYBI//ZQLveYUY3aVvFrT+7NWoayIK/l/gjOd58a+XfwNJjQ97lbP0tzfhb/zrk+e0qehff/0bSdFXL8dE44XP5C69D75e+eFuo2toJUAcxrZNVCOkFnwtcGuzH5vNlEjqrer9HqcOEZXKlIbsxv72XPkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714449001; c=relaxed/simple;
	bh=vvI1moVYeHltFNtwdM5kPHPuSTcIHcJ1PbKgkEZZxcI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sr7W36nuXJlqW0dFMo+OgGnU9YmtdFWA4fwly1+IbhcK8iDTih3e8DyuMa51pdrlmQDsSJLeQk9pYSsvwqXGAqFskq9DFe6BbEkFcAJvHDf7w5q7wb6F/2eE2Y/CmDuqK4NQXb/M7DNEaX7kJ2FDicukn87BtBA8Bfh1GS/NY1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MPnP00Mm; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714449000; x=1745985000;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vvI1moVYeHltFNtwdM5kPHPuSTcIHcJ1PbKgkEZZxcI=;
  b=MPnP00Mm21U/6BBEBeCgT6inwNhtraaGmBCANoyAsjzjBuhljSv37Swd
   LzXeVUtFyRUHuByu5z5iEiPCwBvSxzCSKASLtRzVPWniKLNG3sKZ01QVF
   PsV1C4TrafglBqdfBjyhEw6wc/t9Z49CO07McamAFsTbJKoMCsxzAuDa9
   8vt/JqxVCE1r2HM9ZOSfu1jAbesBiU66PEraZ3gFLb3qnLaAAQGdu54NP
   54JLQSGYs4/y38tuVgjo2rsMZKPqLqJ5ZMm28a6RLhPaHFVPFffgjQnPa
   ftikHAdx8/wIrDRzYxjyn+xde1uFXgy4Tkquv3pWGSaGp3+FezlbO1QUI
   Q==;
X-CSE-ConnectionGUID: 1tBwmmsKQWKq+iQVv3wM0g==
X-CSE-MsgGUID: /Y93q5n+Sv+7u1xgG1k92A==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10059032"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="10059032"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 20:50:00 -0700
X-CSE-ConnectionGUID: KNG9BqR+SWGMu9ZZz8s40w==
X-CSE-MsgGUID: u4tReFtBRTutuoXeNbU7fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="26184555"
Received: from unknown (HELO dmi-pnp-i7.sh.intel.com) ([10.239.159.155])
  by orviesa010.jf.intel.com with ESMTP; 29 Apr 2024 20:49:57 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 1/2] perf/x86: Remove perf_events_lapic_init() calling from x86_pmu_enable()
Date: Tue, 30 Apr 2024 11:56:52 +0800
Message-Id: <20240430035653.19457-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_events_lapic_init() helper is called to configure PMI to NMI vector
and clear MASK bit simultaneously by writing APIC_LVTPC MSR. It's called
firstly to initialize APIC_LVTPC MSR by init_hw_perf_events(), and the
PMI handler would always to clear the MASK bit in APIC_LVTPC MSR by
writing APIC_LVTPC MSR directly.

So it becomes unnecessary to call perf_events_lapic_init() again in
x86_pmu_enable(), and worse x86_pmu_enable() could be called very
frequently in some scenarios with very high context-switches. This would
cause performance overhead which can't be ignored especially in KVM guest
environment since frequent APIC_LVTPC writing would cause huge number
of VM-Exits.

For example, in guest environment Geekbench score (running multiplxing
perf-stat command in background) increases 1% and perf-sched benchmark
increases 7% after removing perf_events_lapic_init() calling from
x86_pmu_enable().

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 5b0dd07b1ef1..580923443813 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1347,7 +1347,6 @@ static void x86_pmu_enable(struct pmu *pmu)
 			x86_pmu_start(event, PERF_EF_RELOAD);
 		}
 		cpuc->n_added = 0;
-		perf_events_lapic_init();
 	}
 
 	cpuc->enabled = 1;

base-commit: 854dd99b5ddc9d90e31e5f112462a5994dd31810
-- 
2.40.1


