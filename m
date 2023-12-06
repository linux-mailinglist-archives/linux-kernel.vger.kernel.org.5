Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B3D807932
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442863AbjLFUN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 15:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379507AbjLFUN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:13:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3D31A5;
        Wed,  6 Dec 2023 12:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701893612; x=1733429612;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NtWRySGhr0Bbdk5ZktY4nQZC/k3j2mpJylW2qfJns3c=;
  b=YoGugz8Nfv7j+dlCh7/G5wv/6nUUjUjGOTdNs57RfVfGIt/4FbTfbm3Z
   DoI606tmad9aNqdqyO4lhe9Vz3T8hNQOAgqnKOZkklqk6nvJmTwvgQhDU
   3KIVSNrJ1Id7i8p6KBNI653zgyOHL80cln/pHY161bPukPZkLRJ7/nAzT
   Np3OtSGy3O+zsWkpjxatshvMA/l1w0cwNkH3JSzd6g1e1kzw3uu1fdrTs
   c9plU6lITlM1bpafrJF1BCh0wx9etyMr6tDnI4Su4k4OnOCDtqrtzl98M
   dNoYWFBlMoYS4NZzhUY/kF1mhYYFCj1Lxip8u3bIV4VL0cfZZJiGNLUzZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="458445527"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="458445527"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 12:13:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="944766664"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="944766664"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga005.jf.intel.com with ESMTP; 06 Dec 2023 12:13:31 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, irogers@google.com, peterz@infradead.org,
        mingo@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, john.g.garry@oracle.com, will@kernel.org,
        james.clark@arm.com, mike.leach@linaro.org, leo.yan@linaro.org,
        yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
        tmricht@linux.ibm.com, ravi.bangoria@amd.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 0/6] Clean up perf mem
Date:   Wed,  6 Dec 2023 12:13:18 -0800
Message-Id: <20231206201324.184059-1-kan.liang@linux.intel.com>
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

Kan Liang (6):
  perf mem: Add mem_events into the supported perf_pmu
  perf mem: Clean up perf_mem_events__ptr()
  perf mem: Clean up perf_mem_events__name()
  perf mem: Clean up perf_mem_event__supported()
  perf mem: Clean up is_mem_loads_aux_event()
  perf mem: Remove useless header files for X86

 tools/perf/arch/arm64/util/mem-events.c   |  36 +----
 tools/perf/arch/arm64/util/mem-events.h   |   7 +
 tools/perf/arch/arm64/util/pmu.c          |   6 +
 tools/perf/arch/powerpc/util/mem-events.c |  13 +-
 tools/perf/arch/powerpc/util/mem-events.h |   7 +
 tools/perf/arch/powerpc/util/pmu.c        |  11 ++
 tools/perf/arch/s390/util/pmu.c           |   3 +
 tools/perf/arch/x86/util/mem-events.c     |  99 +++---------
 tools/perf/arch/x86/util/mem-events.h     |  10 ++
 tools/perf/arch/x86/util/pmu.c            |  11 ++
 tools/perf/builtin-c2c.c                  |  28 +++-
 tools/perf/builtin-mem.c                  |  28 +++-
 tools/perf/util/mem-events.c              | 177 +++++++++++++---------
 tools/perf/util/mem-events.h              |  15 +-
 tools/perf/util/pmu.c                     |   4 +-
 tools/perf/util/pmu.h                     |   7 +
 16 files changed, 248 insertions(+), 214 deletions(-)
 create mode 100644 tools/perf/arch/arm64/util/mem-events.h
 create mode 100644 tools/perf/arch/powerpc/util/mem-events.h
 create mode 100644 tools/perf/arch/powerpc/util/pmu.c
 create mode 100644 tools/perf/arch/x86/util/mem-events.h

-- 
2.35.1

