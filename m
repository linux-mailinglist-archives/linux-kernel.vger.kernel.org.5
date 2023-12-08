Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960CC80AAD7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbjLHRcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574557AbjLHRZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:25:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFF610E3;
        Fri,  8 Dec 2023 09:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702056351; x=1733592351;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KmdBc3HWqTwUasM7vZjbBzM2mrzmquHQNOkk6b78KiY=;
  b=fTlEJ7CpPbxGXy9gUyjriiXVFqrH35Mx6lGLKRFEXFJzxb4hKRCh1e8x
   +aHm3N+hIawSiL5yC4VwhqSsr6Z9BW9d/FR4iXMUq26Ppsa0R+Zn8SfhN
   PlXOGhczzk/DhNc2NrtnOleLdH/lXFi9BZoRSyKZWUCuFD7A4uGF4jg7C
   yYMEVWdHx+Mek/HzkDWSvTcSvt4nG2lj4zNaATYKzR4gej1eOp1I2p413
   fYSU+BnBSrn9cRPf0bUklnFJ+5ewMRk8RcWNTNskdwjMi2Txtg/E0In+f
   jITeAXzih4RABDheVCr/QFFDUbNIJhsBzWwB/miG75HvgsAnBymoT/L7c
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="379432530"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="379432530"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 09:25:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="772201694"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="772201694"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.34.218])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 09:25:27 -0800
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
Subject: [PATCH RFC V2 4/4] coresight: Have a stab at support for pause / resume
Date:   Fri,  8 Dec 2023 19:24:49 +0200
Message-Id: <20231208172449.35444-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208172449.35444-1-adrian.hunter@intel.com>
References: <20231208172449.35444-1-adrian.hunter@intel.com>
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

For discussion only, un-tested, not even compiled...

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../hwtracing/coresight/coresight-etm-perf.c  | 29 ++++++++++++++++---
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 5ca6278baff4..36e774405c51 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -45,6 +45,7 @@ static bool etm_perf_up;
 struct etm_ctxt {
 	struct perf_output_handle handle;
 	struct etm_event_data *event_data;
+	int pr_allowed;
 };
 
 static DEFINE_PER_CPU(struct etm_ctxt, etm_ctxt);
@@ -452,6 +453,13 @@ static void etm_event_start(struct perf_event *event, int flags)
 	struct list_head *path;
 	u64 hw_id;
 
+	if (mode & PERF_EF_RESUME) {
+		if (!READ_ONCE(ctxt->pr_allowed))
+			return;
+	} else if (READ_ONCE(event->aux_paused)) {
+		goto out_pr_allowed;
+	}
+
 	if (!csdev)
 		goto fail;
 
@@ -514,6 +522,8 @@ static void etm_event_start(struct perf_event *event, int flags)
 	event->hw.state = 0;
 	/* Save the event_data for this ETM */
 	ctxt->event_data = event_data;
+out_pr_allowed:
+	WRITE_ONCE(ctxt->pr_allowed, 1);
 	return;
 
 fail_disable_path:
@@ -530,6 +540,7 @@ static void etm_event_start(struct perf_event *event, int flags)
 	}
 fail:
 	event->hw.state = PERF_HES_STOPPED;
+	WRITE_ONCE(ctxt->pr_allowed, 0);
 	return;
 }
 
@@ -543,6 +554,11 @@ static void etm_event_stop(struct perf_event *event, int mode)
 	struct etm_event_data *event_data;
 	struct list_head *path;
 
+	if (mode & PERF_EF_PAUSE && !READ_ONCE(ctxt->pr_allowed))
+		return;
+
+	WRITE_ONCE(ctxt->pr_allowed, 0);
+
 	/*
 	 * If we still have access to the event_data via handle,
 	 * confirm that we haven't messed up the tracking.
@@ -556,7 +572,7 @@ static void etm_event_stop(struct perf_event *event, int mode)
 	ctxt->event_data = NULL;
 
 	if (event->hw.state == PERF_HES_STOPPED)
-		return;
+		goto out_pr_allowed;
 
 	/* We must have a valid event_data for a running event */
 	if (WARN_ON(!event_data))
@@ -627,6 +643,10 @@ static void etm_event_stop(struct perf_event *event, int mode)
 
 	/* Disabling the path make its elements available to other sessions */
 	coresight_disable_path(path);
+
+out_pr_allowed:
+	if (mode & PERF_EF_PAUSE)
+		WRITE_ONCE(ctxt->pr_allowed, 1);
 }
 
 static int etm_event_add(struct perf_event *event, int mode)
@@ -634,7 +654,7 @@ static int etm_event_add(struct perf_event *event, int mode)
 	int ret = 0;
 	struct hw_perf_event *hwc = &event->hw;
 
-	if (mode & PERF_EF_START) {
+	if (mode & PERF_EF_START && !READ_ONCE(event->aux_paused)) {
 		etm_event_start(event, 0);
 		if (hwc->state & PERF_HES_STOPPED)
 			ret = -EINVAL;
@@ -886,8 +906,9 @@ int __init etm_perf_init(void)
 {
 	int ret;
 
-	etm_pmu.capabilities		= (PERF_PMU_CAP_EXCLUSIVE |
-					   PERF_PMU_CAP_ITRACE);
+	etm_pmu.capabilities		= PERF_PMU_CAP_EXCLUSIVE |
+					  PERF_PMU_CAP_ITRACE |
+					  PERF_PMU_CAP_AUX_PAUSE;
 
 	etm_pmu.attr_groups		= etm_pmu_attr_groups;
 	etm_pmu.task_ctx_nr		= perf_sw_context;
-- 
2.34.1

