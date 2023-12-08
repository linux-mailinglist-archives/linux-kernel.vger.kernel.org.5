Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09ED080AAB1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574271AbjLHRZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbjLHRZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:25:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B1C137;
        Fri,  8 Dec 2023 09:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702056313; x=1733592313;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HS9B5laS4FVE8LbmCpzPPPQI/CT1mCILRKewwhWMU8E=;
  b=Yb5s4ke7Myoo3PJ9FcgyFccWloEr1oshSFKaFolYD4SqSyLzh9s8NCvf
   OAoqYkrwKoncrE8ZESmfWn2dUm24Qcj1yxWie5DIGKMklZltyTaBiEKkX
   fgurYVS703WfoUzQ1mb8tjb/wjdvyesfkbLfZDVak7pIjAAX9JLeBfGaL
   pbfxA+TNWP5QzFpSndMVlFXMrW63QMb977GsoWaAblp3vQpWzmocl5gIx
   nUc+O5ThtzzzlVSj3gtOCEicO6Xi+Wr7igmpcmc2W8KlmEeEw0YwHvIBo
   1K46d1wklkWImIKJPBGxYchrDq/oesFT7cwkpdtJep3RXllgKPhN4G99y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="379432363"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="379432363"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 09:25:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="772201553"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="772201553"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.34.218])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 09:25:01 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        Yicong Yang <yangyicong@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH RFC V2 0/4] perf/core: Add ability for an event to "pause" or "resume" AUX area tracing
Date:   Fri,  8 Dec 2023 19:24:45 +0200
Message-Id: <20231208172449.35444-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
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
the ABI would work for them.

Changes to perf tools are not fleshed out yet.


Changes in RFC V2:

      Use ->stop() / ->start() instead of ->pause_resume()
      Move aux_start_paused bit into aux_output_cfg
      Tighten up when Intel PT pause / resume is allowed
      Add an example of how it might work for CoreSight


Adrian Hunter (4):
      perf/core: Add aux_pause, aux_resume, aux_start_paused
      perf/x86/intel/pt: Add support for pause / resume
      perf tools: Add support for AUX area pause / resume
      coresight: Have a stab at support for pause / resume

 arch/x86/events/intel/pt.c                       | 63 ++++++++++++++++++++-
 arch/x86/events/intel/pt.h                       |  4 ++
 drivers/hwtracing/coresight/coresight-etm-perf.c | 29 ++++++++--
 include/linux/perf_event.h                       | 15 +++++
 include/uapi/linux/perf_event.h                  | 11 +++-
 kernel/events/core.c                             | 72 +++++++++++++++++++++++-
 kernel/events/internal.h                         |  1 +
 tools/include/uapi/linux/perf_event.h            | 11 +++-
 tools/perf/util/auxtrace.c                       |  4 ++
 tools/perf/util/evsel.c                          |  9 +++
 tools/perf/util/evsel_config.h                   |  6 ++
 tools/perf/util/parse-events.c                   | 33 +++++++++++
 tools/perf/util/parse-events.h                   |  3 +
 tools/perf/util/parse-events.l                   |  3 +
 tools/perf/util/perf_event_attr_fprintf.c        |  3 +
 15 files changed, 255 insertions(+), 12 deletions(-)


Regards
Adrian
