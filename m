Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7417F5EEA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 13:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345279AbjKWMTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 07:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345280AbjKWMTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 07:19:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20F1D42;
        Thu, 23 Nov 2023 04:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700741964; x=1732277964;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8aCNwpSFHAyXWSCRr6tTvoejhaLHrQ0RcXndxzv80fA=;
  b=gWMCoVhCK77yAS/boOmjr8CBHR3C6EJ8rUVhE0PkIexL+VjjCH380kZ1
   hZ2fpRnkQqOTrgdfnLdYUTiRf9Q7qqdJFOjdDUSr/rvCPjXBcYg2uMsaj
   ekb2K6iS6i8bAxCnERhOvArnT1/2Mp3d2Vp9prxB9Yh0PZQVSo4cbrAYe
   BGko5U4gRsPkYesaQs6YYgNBScjHi7oxddftAuRFkXJXAPDwz5UyxAttY
   yFkrzbIKT631k/F/IsW1iN/5KACb4X9CVO2BLCU+e+zd1J0tNxcKUrl3i
   SnS1TKPH9P1EMbdO+vShL4fyaNGGPNRWlwkyruUq8zHUWLF0zGUDAn+Xa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="478456361"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="478456361"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 04:19:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="890774792"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="890774792"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.41.107])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 04:19:18 -0800
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
Subject: [PATCH RFC 2/3] perf/x86/intel/pt: Add support for pause_resume()
Date:   Thu, 23 Nov 2023 14:18:50 +0200
Message-Id: <20231123121851.10826-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123121851.10826-1-adrian.hunter@intel.com>
References: <20231123121851.10826-1-adrian.hunter@intel.com>
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

Prevent tracing to start if aux_paused.

Implement pause_resume() callback. When aux_paused, stop tracing. When
not aux_paused, only start tracing if it isn't currently meant to be
stopped.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/events/intel/pt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 42a55794004a..aa883b64814a 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -418,6 +418,9 @@ static void pt_config_start(struct perf_event *event)
 	struct pt *pt = this_cpu_ptr(&pt_ctx);
 	u64 ctl = event->hw.config;
 
+	if (event->aux_paused)
+		return;
+
 	ctl |= RTIT_CTL_TRACEEN;
 	if (READ_ONCE(pt->vmx_on))
 		perf_aux_output_flag(&pt->handle, PERF_AUX_FLAG_PARTIAL);
@@ -1563,6 +1566,14 @@ EXPORT_SYMBOL_GPL(intel_pt_handle_vmx);
  * PMU callbacks
  */
 
+static void pt_event_pause_resume(struct perf_event *event)
+{
+	if (event->aux_paused)
+		pt_config_stop(event);
+	else if (!event->hw.state)
+		pt_config_start(event);
+}
+
 static void pt_event_start(struct perf_event *event, int mode)
 {
 	struct hw_perf_event *hwc = &event->hw;
@@ -1798,6 +1809,7 @@ static __init int pt_init(void)
 	pt_pmu.pmu.del			 = pt_event_del;
 	pt_pmu.pmu.start		 = pt_event_start;
 	pt_pmu.pmu.stop			 = pt_event_stop;
+	pt_pmu.pmu.pause_resume		 = pt_event_pause_resume;
 	pt_pmu.pmu.snapshot_aux		 = pt_event_snapshot_aux;
 	pt_pmu.pmu.read			 = pt_event_read;
 	pt_pmu.pmu.setup_aux		 = pt_buffer_setup_aux;
-- 
2.34.1

