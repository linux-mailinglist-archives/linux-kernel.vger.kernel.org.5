Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD262811F75
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbjLMTww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbjLMTwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:52:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED76F1987;
        Wed, 13 Dec 2023 11:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702497127; x=1734033127;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+2J+lMKmnDWmo0pwzPu6dSwdKZ/4VMnKLp1WLefwysQ=;
  b=HClcTJQPQ0uifvDdCeyKjDCK2m+fUlqf1VypgeYyZSkCoFniuiVXjfK7
   jlxxz1mq6Y3IX3dLQf2PN1gS2aHLd5V6OB15U81kmg7u/r5WuIy9J0xRk
   4fAwpIDsPZ+OyMPUzPFBT9tBCKLwTtZtunbaa7SC0vg+K6hoiTryrNUsv
   B6pZaHtQnKJKGePq7tlGsxhl9CLgTxGigRzqqkjGAu+FQkspIGqVQyfAH
   bpoh91VAQK1oOlMCdUQ0KT6L0mfBn2ONiVfW6oPCucO+qDM/TybECZjHm
   hyUhxDs/RpQmWRn2pg9CQRNrQ1Or6q8+Eo8i1PD8nDrM8F2tVxUE/oQ1i
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="8412871"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="8412871"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 11:52:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="917772546"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="917772546"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga001.fm.intel.com with ESMTP; 13 Dec 2023 11:52:04 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, irogers@google.com, peterz@infradead.org,
        mingo@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, john.g.garry@oracle.com, will@kernel.org,
        james.clark@arm.com, mike.leach@linaro.org, leo.yan@linaro.org,
        yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
        tmricht@linux.ibm.com, ravi.bangoria@amd.com,
        atrajeev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 0/7] Clean up perf mem
Date:   Wed, 13 Dec 2023 11:51:47 -0800
Message-Id: <20231213195154.1085945-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

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
 tools/perf/arch/powerpc/util/mem-events.c |  13 +-
 tools/perf/arch/powerpc/util/mem-events.h |   7 +
 tools/perf/arch/powerpc/util/pmu.c        |  11 ++
 tools/perf/arch/s390/util/pmu.c           |   3 +
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
 18 files changed, 278 insertions(+), 280 deletions(-)
 create mode 100644 tools/perf/arch/arm64/util/mem-events.h
 create mode 100644 tools/perf/arch/powerpc/util/mem-events.h
 create mode 100644 tools/perf/arch/powerpc/util/pmu.c
 create mode 100644 tools/perf/arch/x86/util/mem-events.h

-- 
2.35.1

