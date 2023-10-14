Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4A87C9224
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 03:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjJNBwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 21:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjJNBwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 21:52:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D33BF;
        Fri, 13 Oct 2023 18:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697248336; x=1728784336;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zFHx/xW5GogHGqmoDh7SW5qdl32CguSjEtbLiPwLVfk=;
  b=alEud5A4Pqi/mVFvTGCI3lg3YC2AvTPBXppcgoQPhWggft0MN4rZdBnP
   uK6klP8nA6Kr8I2Fqx9NUbcvUvpniH5lJs7XpGahguBb4Ne2TVKH/4rd+
   bXphImS81gYi1IW+Wbu1urDm1gIerSx+JaTbaZJPi+4AMlr1ZJEM+lYub
   gxzNeYALtkXSzOGKTNpUcU+P7Jx9cOM9LT6OqbX8CMg5nrgU1i+v0xzMq
   6JCOZBEffBwki/9DTG9SPPjI7r5oejk70SxCIMzVQiKOpu8UQs2QYOCS/
   cHZBFeacvAjHk8WGB0bQkIp2pHXd+LCCTbdSPBICVzPWqyBijJT8Dpd8s
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="389154658"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="389154658"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 18:52:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="731565652"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="731565652"
Received: from b49691a75598.jf.intel.com ([10.54.34.22])
  by orsmga006.jf.intel.com with ESMTP; 13 Oct 2023 18:52:15 -0700
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
Subject: [RFC PATCH v2 00/17] Perf stat metric grouping with hardware information
Date:   Fri, 13 Oct 2023 18:51:45 -0700
Message-Id: <20231014015202.1175377-1-weilin.wang@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weilin Wang <weilin.wang@intel.com>

Chanages in v2:
 - Updated the ordering of patches and removed bug fixing patches [Kan]
 - Move code into dedicated patches or more related patches [Kan]
 - Removed unnecessary code [Kan, Yang]

Grouping algorithm details:
 - Currently, this grouping method groups a combined list of events, which is a
 unique list of events for the required metrics.
 - The grouping process traverses the event list to build up a event_info_list
 that includes counter restriction rules of each event. It also creates a
 pmu_info_list for the counter info - the number of gp counters and fixed
 counters available in each PMU in current system. When grouping is in progress,
 there are two bitmaps used to represent usages of gp counters and fixed
 counters in each group. These two bitmaps are initialized based on the two
 counter sizes of the corresponding PMU.
 Assumption: this method reads counter availablility from data described in JSON
 files and builds up groups based on this info.
 - The grouping step traverses the event_info_list. For each event, it checks
 bitmaps to get counter availability in current group. It sets the bit and
 inserts event into the group if found a vacant counter that fits the
 restrictions of the event. Otherwise, it creates a new group, places event in
 it, and then inserts it into the group list.


v1: https://lore.kernel.org/all/20230925061824.3818631-1-weilin.wang@intel.com/


Weilin Wang (17):
  perf stat: Add hardware-grouping cmd option to perf stat
  perf stat: Add basic functions for the hardware-grouping stat cmd
    option
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
 tools/perf/pmu-events/jevents.py              |  177 +-
 tools/perf/pmu-events/pmu-events.h            |   26 +-
 tools/perf/util/metricgroup.c                 |  947 ++++++++++
 tools/perf/util/metricgroup.h                 |  106 ++
 tools/perf/util/pmu.c                         |    5 +
 tools/perf/util/pmu.h                         |    1 +
 tools/perf/util/stat.h                        |    1 +
 60 files changed, 13832 insertions(+), 25 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tigerlake/counter.json

--
2.39.3

