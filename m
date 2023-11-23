Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181817F5EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 13:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345264AbjKWMTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 07:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345168AbjKWMTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 07:19:05 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC811B6;
        Thu, 23 Nov 2023 04:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700741952; x=1732277952;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bQdpKQROgueA3Gs7uL4fvcxngYtStie2+8CIT0nxY54=;
  b=P9N2QDQYAL4Oj5xl36hBoKllks2wA2Iep2V0a+sWbZS81MraBq1jmwDT
   GbfICuT1oIIitDIP8NFHjHLglQYaap0w01E4iWj+rgCtudUKIYgb2seaf
   nERSRG0RS0yfuw3cLTkvMK07UeJrm49Lox5gLXNah95wi0Yv23v6h4Co0
   2lLRwEMLXj0NdhOGuosReLNYfZhglXmrSnG6hwxcjSvvGH+oFV1j545Nn
   3G+yQ8RJi0Gr3rvtI+qffAHboPQQWI7Xm20Q9dKHqzukV2WsiUt9j9cjO
   Z0p+YhdKBZcAeB8mNvA8DnfTqGa4yvYKcixC552L+eg39uoF77HnDT7k/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="478456331"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="478456331"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 04:19:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="890774781"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="890774781"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.41.107])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 04:19:06 -0800
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
Subject: [PATCH RFC 0/3] perf/core: Add ability for an event to "pause" or "resume" AUX area tracing
Date:   Thu, 23 Nov 2023 14:18:48 +0200
Message-Id: <20231123121851.10826-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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


Adrian Hunter (3):
      perf/core: Add aux_pause, aux_resume, aux_start_paused
      perf/x86/intel/pt: Add support for pause_resume()
      perf tools: Add support for AUX area pause_resume()

 arch/x86/events/intel/pt.c                | 12 ++++++
 include/linux/perf_event.h                |  9 +++++
 include/uapi/linux/perf_event.h           | 13 ++++++-
 kernel/events/core.c                      | 65 +++++++++++++++++++++++++++++--
 kernel/events/internal.h                  |  1 +
 tools/include/uapi/linux/perf_event.h     | 13 ++++++-
 tools/perf/util/auxtrace.c                |  4 ++
 tools/perf/util/evsel.c                   |  9 +++++
 tools/perf/util/evsel_config.h            |  6 +++
 tools/perf/util/parse-events.c            | 33 ++++++++++++++++
 tools/perf/util/parse-events.h            |  3 ++
 tools/perf/util/parse-events.l            |  3 ++
 tools/perf/util/perf_event_attr_fprintf.c |  3 ++
 13 files changed, 167 insertions(+), 7 deletions(-)


Regards
Adrian
