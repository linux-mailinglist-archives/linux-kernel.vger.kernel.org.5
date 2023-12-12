Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8394580FAE9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377905AbjLLXCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjLLXCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:02:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C4A98;
        Tue, 12 Dec 2023 15:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702422161; x=1733958161;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Wy+I6W7fxpeKZmWP0/XW0hwkCjvSZETHygBMlm6vFU4=;
  b=Xcouywp4tD989wjpTqMbmqmELtYi2qgcbfUtxyAUSKzUBLMf6Ia0NyEB
   n92O+WhmXcSKwbvSO6ijGhwWbBIcB40qI2Jy0dhmmTS2TWD1Q2nYSThFn
   n/XUNfJRE74/8nnBYyJgZOP2GrZo6W4lmOQ3/Sxp+ERHCuuELZB2KcryF
   FCoZ1ws3xZEkrBbV2sSnC0/s44ma7OowdhXkHpp/msf7oVWM7eWEbSSoa
   gpxd/H2UIppcRoqOzPUfmM1+2zsWHzaChfcpGwmlnm/5b8Q9kDVaBMR2e
   fqJxp5w4hg7ZGf/PEvFszX6lRTmdgEpdOXegrZYupVZ85K97L9jrWGhIk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="392055859"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="392055859"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 15:02:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="864391939"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="864391939"
Received: from node-10329.jf.intel.com ([10.54.34.22])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Dec 2023 15:02:40 -0800
From:   weilin.wang@intel.com
To:     weilin.wang@intel.com, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Yang Jihong <yangjihong1@huawei.com>
Subject: [RFC PATCH v3 00/18] Perf stat metric grouping with hardware information
Date:   Tue, 12 Dec 2023 15:02:05 -0800
Message-Id: <20231212230224.1473300-1-weilin.wang@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weilin Wang <weilin.wang@intel.com>

Changes in v3:
 - Updated the ordering of patches to add --hardware-grouping cmd option after
 completely enable this feature [Kan]
 - Resolved merge conflict [Ian]

 v2: https://lore.kernel.org/all/20231014015202.1175377-1-weilin.wang@intel.com/

Weilin Wang (18):
  perf stat: Add new field in stat_config to enable hardware aware
    grouping.
  perf stat: Add basic functions for the hardware aware grouping
  perf pmu-events: Add functions in jevent.py to parse counter and event
    info for hardware aware grouping
  perf pmu-events: Add counter info into JSON files for SapphireRapids
  perf pmu-events: Add event counter data for Cascadelakex
  perf pmu-events: Add event counter data for Icelakex
  perf stat: Add functions to set counter bitmaps for hardware-grouping
    method
  perf stat: Add functions to get counter info
  perf stat: Add functions to create new group and assign events into
    groups for hardware-grouping method
  perf stat: Add build string function and topdown events handling in
    hardware-grouping
  perf stat: Add function to handle special events in hardware-grouping
  perf stat: Add function to combine metrics for hardware-grouping
  perf stat: Handle taken alone in hardware-grouping
  perf stat: Handle NMI in hardware-grouping
  perf stat: Code refactoring in hardware-grouping
  perf stat: Add tool events support in hardware-grouping
  perf pmu-events: Add event counter data for Tigerlake
  perf stat: Add hardware-grouping cmd option to perf stat

 tools/lib/bitmap.c                            |   20 +
 tools/perf/builtin-stat.c                     |    7 +
 .../arch/x86/cascadelakex/cache.json          | 1237 ++++++++++++
 .../arch/x86/cascadelakex/counter.json        |   16 +
 .../arch/x86/cascadelakex/floating-point.json |   16 +
 .../arch/x86/cascadelakex/frontend.json       |   68 +
 .../arch/x86/cascadelakex/memory.json         |  751 ++++++++
 .../arch/x86/cascadelakex/other.json          |  168 ++
 .../arch/x86/cascadelakex/pipeline.json       |  102 +
 .../arch/x86/cascadelakex/uncore-cache.json   | 1138 +++++++++++
 .../x86/cascadelakex/uncore-interconnect.json | 1272 +++++++++++++
 .../arch/x86/cascadelakex/uncore-io.json      |  394 ++++
 .../arch/x86/cascadelakex/uncore-memory.json  |  509 +++++
 .../arch/x86/cascadelakex/uncore-power.json   |   25 +
 .../arch/x86/cascadelakex/virtual-memory.json |   28 +
 .../pmu-events/arch/x86/icelakex/cache.json   |   98 +
 .../pmu-events/arch/x86/icelakex/counter.json |   16 +
 .../arch/x86/icelakex/floating-point.json     |   13 +
 .../arch/x86/icelakex/frontend.json           |   55 +
 .../pmu-events/arch/x86/icelakex/memory.json  |   53 +
 .../pmu-events/arch/x86/icelakex/other.json   |   52 +
 .../arch/x86/icelakex/pipeline.json           |   92 +
 .../arch/x86/icelakex/uncore-cache.json       |  965 ++++++++++
 .../x86/icelakex/uncore-interconnect.json     | 1667 +++++++++++++++++
 .../arch/x86/icelakex/uncore-io.json          |  966 ++++++++++
 .../arch/x86/icelakex/uncore-memory.json      |  186 ++
 .../arch/x86/icelakex/uncore-power.json       |   26 +
 .../arch/x86/icelakex/virtual-memory.json     |   22 +
 .../arch/x86/sapphirerapids/cache.json        |  104 +
 .../arch/x86/sapphirerapids/counter.json      |   16 +
 .../x86/sapphirerapids/floating-point.json    |   25 +
 .../arch/x86/sapphirerapids/frontend.json     |   59 +
 .../arch/x86/sapphirerapids/memory.json       |   44 +
 .../arch/x86/sapphirerapids/other.json        |   40 +
 .../arch/x86/sapphirerapids/pipeline.json     |  118 ++
 .../arch/x86/sapphirerapids/uncore-cache.json |  514 +++++
 .../arch/x86/sapphirerapids/uncore-cxl.json   |   56 +
 .../sapphirerapids/uncore-interconnect.json   |  476 +++++
 .../arch/x86/sapphirerapids/uncore-io.json    |  373 ++++
 .../x86/sapphirerapids/uncore-memory.json     |  391 ++++
 .../arch/x86/sapphirerapids/uncore-power.json |   24 +
 .../x86/sapphirerapids/virtual-memory.json    |   20 +
 .../pmu-events/arch/x86/tigerlake/cache.json  |   65 +
 .../arch/x86/tigerlake/counter.json           |    6 +
 .../arch/x86/tigerlake/floating-point.json    |   13 +
 .../arch/x86/tigerlake/frontend.json          |   56 +
 .../pmu-events/arch/x86/tigerlake/memory.json |   31 +
 .../pmu-events/arch/x86/tigerlake/other.json  |    4 +
 .../arch/x86/tigerlake/pipeline.json          |   96 +
 .../x86/tigerlake/uncore-interconnect.json    |   11 +
 .../arch/x86/tigerlake/uncore-memory.json     |    6 +
 .../arch/x86/tigerlake/uncore-other.json      |    1 +
 .../arch/x86/tigerlake/virtual-memory.json    |   20 +
 tools/perf/pmu-events/jevents.py              |  176 +-
 tools/perf/pmu-events/pmu-events.h            |   26 +-
 tools/perf/util/metricgroup.c                 |  947 ++++++++++
 tools/perf/util/metricgroup.h                 |  106 ++
 tools/perf/util/stat.h                        |    1 +
 58 files changed, 13778 insertions(+), 9 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tigerlake/counter.json

--
2.39.3

