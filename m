Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF697ACFF1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjIYGTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjIYGTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:19:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDABDF;
        Sun, 24 Sep 2023 23:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695622749; x=1727158749;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4Obo2SIzygs8SZ0g6qVFXJblfFe784mBRrqGqQ0ZfSU=;
  b=ci7sAPsGdtJd/NZU6m+vnYPhGIBJksZL2HtiEswiCGwNLPGxKkaG9XJd
   Yh+DIxWEeuJNG3T/C82DtJiLdqyz0KD7r+paCbgAb1htcQjqJXDB9ZqVj
   EUwGRLBIc6ChhyLdJTRpv1yPeMDoDLqO1jsbAaYO+97MhePtH4FN6Eppp
   AsTtoKbLF51bfKU42oqX+KzXibAawTSAHzP0AasU9iMJKpXYyYu0hhLQr
   Z2GvIJQVVkZf6XU840XVObQgRaC/VXlnY1rsBGcBouRn3MP0TGmS00Vbk
   U3r0LED/Yc4EMdumNOotfPo0Pzyjurn9a4xTHbTSpg4f+G6EmqHx7gqe3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="445279363"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="445279363"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 23:19:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="818494306"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="818494306"
Received: from b49691a75598.jf.intel.com ([10.54.34.22])
  by fmsmga004.fm.intel.com with ESMTP; 24 Sep 2023 23:19:07 -0700
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
        Mark Rutland <mark.rutland@arm.com>
Subject: [RFC PATCH 00/25] Perf stat metric grouping with hardware information
Date:   Sun, 24 Sep 2023 23:17:59 -0700
Message-Id: <20230925061824.3818631-1-weilin.wang@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weilin Wang <weilin.wang@intel.com>

Perf stat metric grouping generates event groups that are provided to kernel for
data collection using the hardware counters. Sometimes, the grouping might fail
and kernel has to retry the groups because generated groups do not fit in the
hardware counters correctly. In some other cases, the groupings are collected
correctly, however, they left some hardware counters unused.

To improve these inefficiencies, we would like to propose a hardware aware
grouping method that does metric/event grouping based on event counter
restriction rules and the availability of hardware counters in the system. This
method is generic as long as all the restriction rules could be provided from
the pmu-event JSON files.

This patch set includes code that does hardware aware grouping and updated
pmu-event JSON files for four platforms (SapphireRapids, Icelakex, Cascadelakex,
and Tigerlake) for your testing and experimenting. We've successfully tested
these patches on three platforms (SapphireRapids, Icelakex, and Cascadelakex)
with topdown metrics from TopdownL1 to TopdownL6.

There are some optimization opportunities that we might implement in the future:
1) Better NMI hanlding: when NMI watchdog is enabled, we reduce the default_core
total counter size by one. This could be improved to better utilize the counter.
2) Fill important events into unused counter for better counter utlization:
there might be some unused counters scattered in the groups. We could consider
to add important events in this slots if necessary. This could help increase the
multiplexing percentage and help improve accuracy if the event is critical.

Remaining questions for dicussion:
3) Where to start grouping from? The current implementation start grouping by
combining all the events into a single list. This step deduplicates events. But
it does not maintain the relationship of events according to the metrics, i.e.
events required by one metric may not be collected at the same time. Another
type of starting point would be grouping each individual metric and then try to
merge the groups.
4) Any comments, suggestions, new ideas?
5) If you are interested to test the patch out and the pmu-event JSON files of
your testing platform is not provided here, please let me know so that I could
provide you the files.


Weilin Wang (25):
  perf stat: Add hardware-grouping cmd option to perf stat
  perf stat: Add basic functions for the hardware-grouping stat cmd
    option
  perf pmu-events: Add functions in jevent.py
  perf pmu-events: Add counter info into JSON files for SapphireRapids
  perf pmu-events: Add event counter data for Cascadelakex
  perf pmu-events: Add event counter data for Icelakex
  perf stat: Add helper functions for hardware-grouping method
  perf stat: Add functions to get counter info
  perf stat: Add helper functions for hardware-grouping method
  perf stat: Add helper functions to hardware-grouping method
  perf stat: Add utility functions to hardware-grouping method
  perf stat: Add more functions for hardware-grouping method
  perf stat: Add functions to hardware-grouping method
  perf stat: Add build string function and topdown events handling in
    hardware-grouping
  perf stat: Add function to combine metrics for hardware-grouping
  perf stat: Update keyword core to default_core to adjust to the
    changes for events with no unit
  perf stat: Handle taken alone in hardware-grouping
  perf stat: Handle NMI in hardware-grouping
  perf stat: Handle grouping method fall back in hardware-grouping
  perf stat: Code refactoring in hardware-grouping
  perf stat: Add tool events support in hardware-grouping
  perf stat: Add TSC support in hardware-grouping
  perf stat: Fix a return error issue in hardware-grouping
  perf stat: Add check to ensure correctness in platform that does not
    support hardware-grouping
  perf pmu-events: Add event counter data for Tigerlake

 tools/lib/bitmap.c                            |   20 +
 tools/perf/builtin-stat.c                     |    7 +
 .../arch/x86/cascadelakex/cache.json          | 1237 ++++++++++++
 .../arch/x86/cascadelakex/counter.json        |   17 +
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
 .../pmu-events/arch/x86/icelakex/counter.json |   17 +
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
 .../arch/x86/sapphirerapids/counter.json      |   17 +
 .../x86/sapphirerapids/floating-point.json    |   25 +
 .../arch/x86/sapphirerapids/frontend.json     |   98 +-
 .../arch/x86/sapphirerapids/memory.json       |   44 +
 .../arch/x86/sapphirerapids/other.json        |   40 +
 .../arch/x86/sapphirerapids/pipeline.json     |  118 ++
 .../arch/x86/sapphirerapids/uncore-cache.json |  534 +++++-
 .../arch/x86/sapphirerapids/uncore-cxl.json   |   56 +
 .../sapphirerapids/uncore-interconnect.json   |  476 +++++
 .../arch/x86/sapphirerapids/uncore-io.json    |  373 ++++
 .../x86/sapphirerapids/uncore-memory.json     |  391 ++++
 .../arch/x86/sapphirerapids/uncore-power.json |   24 +
 .../x86/sapphirerapids/virtual-memory.json    |   20 +
 .../pmu-events/arch/x86/tigerlake/cache.json  |   65 +
 .../arch/x86/tigerlake/counter.json           |    7 +
 .../arch/x86/tigerlake/floating-point.json    |   13 +
 .../arch/x86/tigerlake/frontend.json          |   56 +
 .../pmu-events/arch/x86/tigerlake/memory.json |   31 +
 .../pmu-events/arch/x86/tigerlake/other.json  |    4 +
 .../arch/x86/tigerlake/pipeline.json          |   96 +
 .../x86/tigerlake/uncore-interconnect.json    |   11 +
 .../arch/x86/tigerlake/uncore-memory.json     |    6 +
 .../arch/x86/tigerlake/uncore-other.json      |    1 +
 .../arch/x86/tigerlake/virtual-memory.json    |   20 +
 tools/perf/pmu-events/jevents.py              |  179 +-
 tools/perf/pmu-events/pmu-events.h            |   26 +-
 tools/perf/util/metricgroup.c                 |  927 +++++++++
 tools/perf/util/metricgroup.h                 |   82 +
 tools/perf/util/pmu.c                         |    5 +
 tools/perf/util/pmu.h                         |    1 +
 tools/perf/util/stat.h                        |    1 +
 60 files changed, 13790 insertions(+), 25 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tigerlake/counter.json

--
2.39.3

